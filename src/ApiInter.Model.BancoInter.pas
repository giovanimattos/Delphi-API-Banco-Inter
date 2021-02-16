unit ApiInter.Model.BancoInter;

interface

uses
  ApiInter.Model.Boleto, ApiInter.Model.JsonSerializable, ApiInter.Commons,
  System.SysUtils, System.JSON, System.Classes, System.NetEncoding;

type

  TBancoInter = class
  private
    FAccountNumber: string;
    FCertificateFile: string;
    FKeyFile: string;
    FKeyPassword: string;
    FCurl: string;
    FHttp_params: TStringList;
    function ControllerGet(Url: string): TReply;
    function ControllerPost(Url: string; Data: TJsonSerializable): TReply;
  public
    constructor Create(AccountNumber, CertificateFile, KeyFile: string);
    destructor Destroy; override;
    function GetBoleto(NossoNumero: string): string;
    function CreateBoleto(Boleto: TBoleto): string;
    function getPdfBoleto(NossoNumero, SavePath: string): string;

  end;

Const
  _APIBASEURL = 'https://apis.bancointer.com.br';

implementation

uses
  ApiInter.Controller.Http;

{ TBancoInter }

constructor TBancoInter.Create(AccountNumber, CertificateFile, KeyFile: string);
begin
  FAccountNumber := AccountNumber;
  FCertificateFile :=  CertificateFile;
  FKeyFile := KeyFile;
  FKeyPassword := '';
  FCurl := '';
  FHttp_params := TStringList.Create;
end;

destructor TBancoInter.Destroy;
begin
  FHttp_params.Free;
  inherited;
end;

function TBancoInter.ControllerGet(Url: string): TReply;
begin
  var NumeroDeTentativas: Integer := 5;
  while (NumeroDeTentativas > 0) do
  begin

    Result :=
      TControllerHttp
        .New
        .SetUrl(_APIBASEURL + Url)
        .SetCertificateFile(FCertificateFile)
        .SetKeyFile(FKeyFile)
        .SetKeyPassword(FKeyPassword)
        .SetCustomHeaders(FHttp_params)
        .Get;

    if (Result.Http_code = 503) then
    begin
      Dec(NumeroDeTentativas);
      sleep(5);
    end
    else
    begin
      NumeroDeTentativas := 0;
    end;

  end;

  if (Result.Http_code = 0) then
    raise Exception.Create('Curl error: ' + Result.Http_response);

  if (Result.Http_code < 200) or (Result.Http_code > 299) then
    raise Exception.Create('Erro HTTP: ' + Result.Http_code.ToString + Result.Http_response);

end;

function TBancoInter.ControllerPost(Url: string; Data: TJsonSerializable): TReply;
begin
  var NumeroDeTentativas: Integer := 5;
  while (NumeroDeTentativas > 0) do
  begin

    Result :=
      TControllerHttp
        .New
        .SetUrl(_APIBASEURL + Url)
        .SetCertificateFile(FCertificateFile)
        .SetKeyFile(FKeyFile)
        .SetKeyPassword(FKeyPassword)
        .SetCustomHeaders(FHttp_params)
        .Post(Data.ToJson);

    if (Result.Http_code = 503) then
    begin
      Dec(NumeroDeTentativas);
      sleep(5);
    end
    else
    begin
      NumeroDeTentativas := 0;
    end;

  end;

  if (Result.Http_code = 0) then
    raise Exception.Create('Curl error: ' + Result.Http_response);

  if (Result.Http_code < 200) or (Result.Http_code > 299) then
    raise Exception.Create('Erro HTTP: ' + Result.Http_code.ToString + Result.Http_response);
end;

function TBancoInter.getBoleto(NossoNumero: string): string;
Var
  Reply: TReply;
begin
  FHttp_params.Clear;
  FHttp_params.AddPair('accept', 'application/json');
  FHttp_params.AddPair('x-inter-conta-corrente', FAccountNumber);

  Reply := Self.ControllerGet('/openbanking/v1/certificado/boletos/' + NossoNumero);
  Result := Reply.body;
end;

function TBancoInter.CreateBoleto(Boleto: TBoleto): string;
Var
  Reply: TReply;
begin
  FHttp_params.Clear;
  FHttp_params.AddPair('accept', 'application/json');
  FHttp_params.AddPair('Content-type', 'application/json');
  FHttp_params.AddPair('x-inter-conta-corrente', FAccountNumber);

  Reply := Self.ControllerPost('/openbanking/v1/certificado/boletos', Boleto as TJsonSerializable);

  var LJSONObject: TJSONObject := nil;
  try

    LJSONObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes( Reply.body ), 0) as TJSONObject;
    Result := LJSONObject.ToString;

    Boleto.NossoNumero := LJSONObject.GetValue<string>('nossoNumero');
    Boleto.CodigoBarras := LJSONObject.GetValue<string>('codigoBarras');
    Boleto.LinhaDigitavel := LJSONObject.GetValue<string>('linhaDigitavel');

  finally
    LJSONObject.Free;
  end;

end;

function TBancoInter.getPdfBoleto(NossoNumero, SavePath: string): string;
Var
  Reply: TReply;
  ASource: TStringStream;
  ATarget: TMemoryStream;
begin
  FHttp_params.Clear;
  FHttp_params.AddPair('accept', 'application/pdf');
  FHttp_params.AddPair('x-inter-conta-corrente', FAccountNumber);

  Reply := Self.ControllerGet('/openbanking/v1/certificado/boletos/' + NossoNumero + '/pdf');

  ASource := TStringStream.Create(Reply.body);
  ATarget:= TMemoryStream.Create;
  try

    TBase64Encoding.Base64.Decode(ASource, ATarget);

    Result := SavePath + '\boleto-inter-' + NossoNumero + '.pdf';

    ATarget.SaveToFile( Result );

  finally
    ASource.Free;
    ATarget.Free;
  end;

end;

end.
