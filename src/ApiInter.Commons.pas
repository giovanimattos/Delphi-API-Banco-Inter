unit ApiInter.Commons;

interface

uses
  System.SysUtils;
type

  TReply = record
    Header: string;
    Body: string;
    Http_code: Integer;
    Http_response: string;
  end;
var
  formatSettingsBancoInter : TFormatSettings;


implementation


initialization
  GetLocaleFormatSettings(TLanguages.UserDefaultLocale, formatSettingsBancoInter);
  formatSettingsBancoInter.DateSeparator   := '-';
  formatSettingsBancoInter.ShortDateFormat := 'yyyy-mm-dd';
  formatSettingsBancoInter.ShortTimeFormat := 'hh:nn';


end.
