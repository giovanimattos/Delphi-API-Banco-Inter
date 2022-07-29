unit ApiInter.Model.JsonSerializable;

interface

uses
  Rest.Json, JSON;

type
  TJsonSerializable = class
  public
    function ToJson: string; Virtual;
    procedure FromJson(json:String);virtual;
  end;

implementation

{ TJsonSerializable }

procedure TJsonSerializable.FromJson(json: String);
begin
  TJson.JsonToObject(self, TJSONObject.ParseJSONValue(json) as TJSONObject)
end;

function TJsonSerializable.ToJson: string;
begin
  Result := TJson.ObjectToJsonString( Self );
end;

end.
