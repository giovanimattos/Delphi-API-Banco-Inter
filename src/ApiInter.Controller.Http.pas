unit ApiInter.Controller.Http;

interface

uses
  ApiInter.Model.Contract, ApiInter.Model.IndyClientHttp, ApiInter.Commons, System.Classes;

type

  TControllerHttp = class(TInterfacedObject, IClientHttp)
  private
    FUrl: string;
    FCertificateFile: string;
    FCustomHeaders: TStrings;
    FKeyFile: string;
    FKeyPassword: string;
    FBearerToken:String;
    function SetUrl(Url: String): IClientHttp;
    function SetCertificateFile(CertificateFile: String): IClientHttp;
    function SetKeyFile(KeyFile: String): IClientHttp;
    function SetKeyPassword(KeyPassword: String): IClientHttp;
    function SetCustomHeaders(CustomHeaders: TStrings): IClientHttp;
    function SetBearerToken(token: String): IClientHttp;
    function Get: TReply; overload;
    function Get(AStream:TMemoryStream): TReply; overload;
    function Post(ASource: String): TReply;  overload;
    function Post(ASource: TStrings): TReply; overload;
  public
    class function New: IClientHttp;
  end;

implementation

{ TControllerHttp }

function TControllerHttp.Get(AStream: TMemoryStream): TReply;
begin
  Result :=
    TIndyClientHttp.New
      .SetUrl(FUrl)
      .SetCertificateFile(FCertificateFile)
      .SetKeyFile(FKeyFile)
      .SetKeyPassword(FKeyPassword)
      .SetBearerToken(FBearerToken)
      .SetCustomHeaders(FCustomHeaders)
      .Get(AStream);
end;

class function TControllerHttp.New: IClientHttp;
begin
  Result := TControllerHttp.Create;
end;

function TControllerHttp.SetCustomHeaders(CustomHeaders: TStrings): IClientHttp;
begin
  Result := Self;
  FCustomHeaders := CustomHeaders;
end;

function TControllerHttp.SetBearerToken(token: String): IClientHttp;
begin
  Result := Self;
  FBearerToken := token;
end;

function TControllerHttp.SetCertificateFile(CertificateFile: String): IClientHttp;
begin
  Result := Self;
  FCertificateFile := CertificateFile;
end;

function TControllerHttp.SetKeyFile(KeyFile: String): IClientHttp;
begin
  Result := Self;
  FKeyFile := KeyFile;
end;

function TControllerHttp.SetKeyPassword(KeyPassword: String): IClientHttp;
begin
  Result := Self;
  FKeyPassword := KeyPassword;
end;

function TControllerHttp.SetUrl(Url: String): IClientHttp;
begin
  Result := Self;
  FUrl := Url;
end;

function TControllerHttp.Get: TReply;
begin
  Result :=
    TIndyClientHttp.New
      .SetUrl(FUrl)
      .SetCertificateFile(FCertificateFile)
      .SetKeyFile(FKeyFile)
      .SetKeyPassword(FKeyPassword)
      .SetBearerToken(FBearerToken)
      .SetCustomHeaders(FCustomHeaders)
      .Get;
end;

function TControllerHttp.Post(ASource: String): TReply;
begin
  Result :=
    TIndyClientHttp.New
      .SetUrl(FUrl)
      .SetCertificateFile(FCertificateFile)
      .SetKeyFile(FKeyFile)
      .SetKeyPassword(FKeyPassword)
      .SetBearerToken(FBearerToken)
      .SetCustomHeaders(FCustomHeaders)
      .Post(ASource);
end;

function TControllerHttp.Post(ASource: TStrings): TReply;
begin
  Result :=
    TIndyClientHttp.New
      .SetUrl(FUrl)
      .SetCertificateFile(FCertificateFile)
      .SetKeyFile(FKeyFile)
      .SetKeyPassword(FKeyPassword)
      .SetBearerToken(FBearerToken)
      .SetCustomHeaders(FCustomHeaders)
      .Post(ASource);
end;

end.
