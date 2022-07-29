unit ApiInter.Model.JsonSerializable;

interface

uses
  Rest.Json, JSON, IdURI;

type
  TJsonSerializable = class
  public
    function ToJson: TJSONObject; overload; Virtual;
    function toURLQueryParam:String;
    procedure FromJson(json:String);overload;virtual;
    procedure FromJson(json:TJSONObject);overload;virtual;
  end;

implementation

uses
  System.SysUtils;
{ TJsonSerializable }

procedure TJsonSerializable.FromJson(json: String);
begin
  self.FromJson(TJSONObject.ParseJSONValue(json) as TJSONObject);
end;

procedure TJsonSerializable.FromJson(json: TJSONObject);
begin
  TJson.JsonToObject(self, json)
end;

function TJsonSerializable.ToJson: TJSONObject;
begin
  Result := TJson.ObjectToJsonObject( Self );
end;

function TJsonSerializable.toURLQueryParam: String;
var lJSON:TJSONObject;
  I:Integer;
begin
  lJSON := self.ToJson;
  for i := 0 to lJSON.Count-1 do
  begin
    if i>0 then
      result := result+'&';
    result := result+format('%s=%s', [lJSON.Pairs[i].JsonString.Value,TIdURI.ParamsEncode(lJSON.Pairs[i].JsonValue.Value)])
  end;
end;

end.
