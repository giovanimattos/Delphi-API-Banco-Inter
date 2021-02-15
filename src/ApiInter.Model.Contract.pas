unit ApiInter.Model.Contract;

interface

uses
  ApiInter.Commons, System.Classes;

type

  IClientHttp = interface
    ['{04C33461-F0A4-4E24-B8ED-31B19960EC26}']
    function SetUrl(Url: String): IClientHttp;
    function SetCertificateFile(CertificateFile: String): IClientHttp;
    function SetKeyFile(KeyFile: String): IClientHttp;
    function SetKeyPassword(KeyPassword: String): IClientHttp;
    function SetCustomHeaders(CustomHeaders: TStrings): IClientHttp;
    function Get: TReply;
    function Post(ASource: String): TReply;
  end;

implementation

end.
