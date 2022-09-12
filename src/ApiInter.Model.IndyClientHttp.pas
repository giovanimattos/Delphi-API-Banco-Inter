unit ApiInter.Model.IndyClientHttp;

interface

uses
  ApiInter.Model.Contract, ApiInter.Commons, System.Classes,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdSSLOpenSSL;

type

  TIndyClientHttp = class(TInterfacedObject, IClientHttp)
  private
    ATarget: TComponent;
    IdHTTP: TIdHTTP;
    IdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
    FKeyPassword: string;
    function SetUrl(Url: String): IClientHttp;
    function SetCertificateFile(CertificateFile: String): IClientHttp;
    function SetKeyFile(KeyFile: String): IClientHttp;
    function SetKeyPassword(KeyPassword: String): IClientHttp;
    function SetBearerToken(token: String): IClientHttp;
    function SetCustomHeaders(CustomHeaders: TStrings): IClientHttp;
    function Get: TReply; overload;
    function Get(ATarget:TMemoryStream): TReply; overload;
    function Post(ASource: String): TReply; overload;
    function Post(ASource: TStrings): TReply; overload;
  protected
    constructor Create;
    destructor Destroy; override;
  public
    class function New: IClientHttp;
  end;

implementation

uses
  System.SysUtils;

{ TIndyClientHttp }

class function TIndyClientHttp.New: IClientHttp;
begin
  Result := TIndyClientHttp.Create;
end;

constructor TIndyClientHttp.Create;
begin
  ATarget := TComponent.Create(nil);

  IdHTTP := TIdHTTP.Create(ATarget);
  IdHTTP.HandleRedirects := true;
  IdHTTP.Request.BasicAuthentication := False;
  IdHTTP.Request.UserAgent := 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0';
  //IdHTTP.Request.Accept := 'application/json';
  //IdHTTP.Request.ContentType := 'application/json';
  IdHTTP.HTTPOptions :=  IdHTTP.HTTPOptions + [hoNoprotocolErrorException,hoWantProtocolErrorContent ];

  IdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create( IdHTTP );
  IdSSLIOHandlerSocket.SSLOptions.Method := sslvTLSv1_2;
  IdSSLIOHandlerSocket.SSLOptions.Mode:= sslmUnassigned;

  IdHTTP.IOHandler := IdSSLIOHandlerSocket;

end;

destructor TIndyClientHttp.Destroy;
begin
  IdSSLIOHandlerSocket.Free;
  IdHTTP.Free;
  ATarget.Free;
  inherited;
end;

function TIndyClientHttp.Get(ATarget: TMemoryStream): TReply;
begin
  Result.Header := '';
  Result.Body := '';
  Result.Http_code := 0;
  Result.Http_response := '';

  try
    try
      IdHTTP.Get(IdHTTP.Request.URL, ATarget);

      Result.Header := '';
      Result.Http_code := IdHTTP.ResponseCode;
      Result.Http_response := IdHTTP.ResponseText;
    except
      on e: exception do
      begin
        Result.Http_code := IdHTTP.ResponseCode;
        Result.Http_response := IdHTTP.ResponseText;
      end;
    end;
  finally
  end;
end;

function TIndyClientHttp.SetCustomHeaders(CustomHeaders: TStrings): IClientHttp;
begin
  Result := Self;
  if CustomHeaders<>nil then
    IdHTTP.Request.CustomHeaders.AddStrings(CustomHeaders);
end;

function TIndyClientHttp.SetBearerToken(token: String): IClientHttp;
begin
  result := self;
  if not token.IsEmpty then
    IdHTTP.Request.CustomHeaders.Add('Authorization: Bearer ' + token);
end;

function TIndyClientHttp.SetCertificateFile(CertificateFile: String): IClientHttp;
begin
  Result := Self;
  IdSSLIOHandlerSocket.SSLOptions.CertFile := CertificateFile;
end;

function TIndyClientHttp.SetKeyFile(KeyFile: String): IClientHttp;
begin
  Result := Self;
  IdSSLIOHandlerSocket.SSLOptions.KeyFile  := KeyFile;
end;

function TIndyClientHttp.SetKeyPassword(KeyPassword: String): IClientHttp;
begin
  Result := Self;
  FKeyPassword := KeyPassword;
end;

function TIndyClientHttp.SetUrl(Url: String): IClientHttp;
begin
  Result := Self;
  IdHTTP.Request.URL := Url;
end;

function TIndyClientHttp.Get: TReply;
var
  Resp: TStringStream;
begin
  Result.Header := '';
  Result.Body := '';
  Result.Http_code := 0;
  Result.Http_response := '';

  Resp := TStringStream.Create;
  try
    try
      IdHTTP.Get(IdHTTP.Request.URL, Resp);

      Result.Header := '';
      Result.Body := Resp.DataString;
      Result.Http_code := IdHTTP.ResponseCode;
      Result.Http_response := IdHTTP.ResponseText;
    except
      on e: exception do
      begin
        Result.Http_code := IdHTTP.ResponseCode;
        Result.Http_response := IdHTTP.ResponseText;
      end;
    end;
  finally
    Resp.Free;
  end;

end;

function TIndyClientHttp.Post(ASource: String): TReply;
var
  RequestBody: TStringStream;
begin
  Result.Header := '';
  Result.Body := '';
  Result.Http_code := 0;
  Result.Http_response := '';

  RequestBody := TStringStream.Create(ASource);
  try
    try
      Result.Body := IdHTTP.Post(IdHTTP.Request.URL, RequestBody);

      Result.Header := '';
      Result.Http_code := IdHTTP.ResponseCode;
      Result.Http_response := IdHTTP.ResponseText;
    except
      on e: exception do
      begin
        Result.Http_code := IdHTTP.ResponseCode;
        Result.Http_response := IdHTTP.ResponseText;
      end;
    end;
  finally
    RequestBody.Free;
  end;

end;

function TIndyClientHttp.Post(ASource: TStrings): TReply;
begin
  Result.Header := '';
  Result.Body := '';
  Result.Http_code := 0;
  Result.Http_response := '';

  try
    try
      Result.Body := IdHTTP.Post(IdHTTP.Request.URL, ASource);

      Result.Header := '';
      Result.Http_code := IdHTTP.ResponseCode;
      Result.Http_response := IdHTTP.ResponseText;
    except
      on e: exception do
      begin
        Result.Http_code := IdHTTP.ResponseCode;
        Result.Http_response := IdHTTP.ResponseText;
      end;
    end;
  finally
  end;
end;

end.
