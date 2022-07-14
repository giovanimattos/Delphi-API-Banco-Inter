unit ApiInter.Model.OAuth;

interface

uses
  ApiInter.Model.JsonSerializable, DateUtils, SysUtils;

type

  TOAuthToken = class(TJsonSerializable)
  private
    Faccess_token: String;
    Ftoken_type: String;
    Fexpires_in: Integer;
    Fscope: String;
    FTimeLimit:TDateTime;
    procedure setexpires_in(const Value: Integer);
  public
    function getTImeLimit:TDateTime;
    procedure FromJson(json: string); override;

    property access_token: String read Faccess_token write Faccess_token;
    property token_type: String read Ftoken_type write Ftoken_type;
    property expires_in: Integer read Fexpires_in write setexpires_in;
    property scope: String read Fscope write Fscope;
    constructor Create;
    destructor Destroy; override;
  end;


implementation


{ TOAuthToken }

constructor TOAuthToken.Create;
begin

end;

destructor TOAuthToken.Destroy;
begin

  inherited;
end;

procedure TOAuthToken.FromJson(json: string);
begin
  inherited FromJson(json);
  self.setexpires_in(Fexpires_in);

end;

function TOAuthToken.getTImeLimit: TDateTime;
begin
  result := FTimeLimit;
end;

procedure TOAuthToken.setexpires_in(const Value: Integer);
begin
  Fexpires_in := Value;
  FTimeLimit := IncSecond(now, Value);
end;

end.

