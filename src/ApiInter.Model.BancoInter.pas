unit ApiInter.Model.BancoInter;

interface

uses
  ApiInter.Model.Boleto, ApiInter.Model.FiltroBoleto, ApiInter.Model.JsonSerializable, ApiInter.Commons,
  System.SysUtils, System.JSON, System.Classes, System.NetEncoding,
  ApiInter.Model.OAuth, System.Generics.Collections;

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
    oAuthToken:TOAuthToken;
    constructor Create(AccountNumber, CertificateFile, KeyFile: string);
    function auth(ClientId, ClientSecret: String): TReply;
    destructor Destroy; override;
    function GetBoleto(NossoNumero: string): string;
    function GetRelacaoBoletos(pfiltro:TFiltroBoleto): TList<TBoleto>;
    function CancelarBoleto(NossoNumero: string;motivoCancelamento:TBoletoCancelamento): string;
    function CreateBoleto(Boleto: TBoleto): string;
    function getPdfBoleto(NossoNumero, SavePath: string): string; overload;
    procedure getPdfBoleto(NossoNumero: string; ATarget:TMemoryStream); overload;

  end;

Const
  _APIBASEURL = 'https://cdpj.partners.bancointer.com.br';

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
  oAuthToken := TOAuthToken.Create;
end;

destructor TBancoInter.Destroy;
begin
  FHttp_params.Free;
  oAuthToken.Free;
  inherited;
end;

function TBancoInter.auth(ClientId, ClientSecret: String):TReply;
begin
  var NumeroDeTentativas: Integer := 5;
  var FormData:TStringList := TStringList.Create;
  try
    FHttp_params.Clear;
    FHttp_params.AddPair('Content-Type', 'application/x-www-form-urlencoded');
    FormData.AddPair('client_id',ClientId);
    FormData.AddPair('client_secret',ClientSecret);
    FormData.AddPair('scope','boleto-cobranca.read boleto-cobranca.write'); // extrato.read');
    FormData.AddPair('grant_type','client_credentials');

    while (NumeroDeTentativas > 0) do
    begin
      Result :=
        TControllerHttp
          .New
          .SetUrl(_APIBASEURL + '/oauth/v2/token')
          .SetCertificateFile(FCertificateFile)
          .SetKeyFile(FKeyFile)
          .SetKeyPassword(FKeyPassword)
          .SetCustomHeaders(FHttp_params)
          .Post(FormData);

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
      raise Exception.Create('Erro HTTP: ' + Result.Http_code.ToString + Result.Http_response + sLineBreak +result.Body);
    oAuthToken.Free;
    oAuthToken := TOAuthToken.Create;
    oAuthToken.FromJson(result.Body);

  finally
    FormData.Free;
  end;
end;

function TBancoInter.CancelarBoleto(NossoNumero: string; motivoCancelamento:TBoletoCancelamento): string;
Var
  Reply: TReply;
begin
  FHttp_params.Clear;
  FHttp_params.AddPair('Content-type', 'application/json');

  Reply := Self.ControllerPost('/cobranca/v2/boletos/'+NossoNumero+'/cancelar', motivoCancelamento as TJsonSerializable);

  var LJSONObject: TJSONObject := nil;
  try
    result := '';

    LJSONObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes( Reply.body ), 0) as TJSONObject;
    if(LJSONObject<>nil) then
      Result := LJSONObject.ToString;

  finally
    LJSONObject.Free;
  end;
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
        .SetBearerToken(self.oAuthToken.access_token)
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
    raise Exception.Create('Erro HTTP: ' + Result.Http_code.ToString + Result.Http_response + sLineBreak +result.Body);
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
        .SetBearerToken(self.oAuthToken.access_token)
        .SetCustomHeaders(FHttp_params)
        .Post(Data.ToJson.ToJSON);

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
    raise Exception.Create('Erro HTTP: ' + Result.Http_code.ToString + Result.Http_response + sLineBreak +result.Body);
end;

function TBancoInter.getBoleto(NossoNumero: string): string;
Var
  Reply: TReply;
begin
  FHttp_params.Clear;

  Reply := Self.ControllerGet('/cobranca/v2/boletos/'+NossoNumero);
  Result := Reply.body;
end;

procedure TBancoInter.getPdfBoleto(NossoNumero: string;
  ATarget: TMemoryStream);
Var
  Reply: TReply;
  ASource: TStringStream;
begin
  FHttp_params.Clear;
  FHttp_params.AddPair('accept', 'application/pdf');

  Reply := Self.ControllerGet('/cobranca/v2/boletos/'+NossoNumero+'/pdf');
  var pdfRetorno : TBoletoPDFRetorno := TBoletoPDFRetorno.Create;
  try
    pdfRetorno.FromJson(reply.Body);
    ASource := TStringStream.Create(pdfRetorno.pdf);
  finally
    pdfRetorno.Free;
  end;
  try

    TBase64Encoding.Base64.Decode(ASource, ATarget);

  finally
    ASource.Free;
  end;

end;

function TBancoInter.CreateBoleto(Boleto: TBoleto): string;
Var
  Reply: TReply;
begin
  FHttp_params.Clear;
  FHttp_params.AddPair('Content-type', 'application/json');

  Reply := Self.ControllerPost('/cobranca/v2/boletos', Boleto as TJsonSerializable);

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

  Reply := Self.ControllerGet('/cobranca/v2/boletos/'+NossoNumero+'/pdf');
  var pdfRetorno : TBoletoPDFRetorno := TBoletoPDFRetorno.Create;
  try
    pdfRetorno.FromJson(reply.Body);
    ASource := TStringStream.Create(pdfRetorno.pdf);
  finally
    pdfRetorno.Free;
  end;
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

function TBancoInter.GetRelacaoBoletos(pfiltro:TFiltroBoleto): TList<TBoleto>;
Var
  Reply: TReply;
  lRetornoHeader:TRetornoFiltroBoleto;
  I:Integer;
begin
  FHttp_params.Clear;
  FHttp_params.AddPair('Content-type', 'application/json');
  lRetornoHeader := TRetornoFiltroBoleto.Create;
  result := TList<TBoleto>.create;
  var LJSONObject: TJSONObject := nil;
  try
    repeat

       Reply := Self.ControllerGet('/cobranca/v2/boletos?'+pfiltro.toURLQueryParam);

      try

        LJSONObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes( Reply.body ), 0) as TJSONObject;
        lRetornoHeader.FromJson(LJSONObject);

        var lListaBoletos : TJSONArray := LJSONObject.GetValue<TJSONArray>('content');
        for I := 0 to lListaBoletos.Count-1 do
        begin
          var lBoleto:TBoleto := TBoleto.Create;
          lBoleto.FromJson(lListaBoletos.Items[i] as TJSONObject);
          Result.Add(lBoleto);
        end;
      finally
        LJSONObject.Free;
      end;
      if not lRetornoHeader.last then
        pfiltro.paginaAtual := pfiltro.paginaAtual+1;

    until lRetornoHeader.last;
  finally
    lRetornoHeader.Free;
  end;
end;

end.
