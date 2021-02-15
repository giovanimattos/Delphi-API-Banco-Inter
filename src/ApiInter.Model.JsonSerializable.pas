unit ApiInter.Model.JsonSerializable;

interface

uses
  Rest.Json;

type
  TJsonSerializable = class
  public
    function ToJson: string;
  end;

implementation

{ TJsonSerializable }

function TJsonSerializable.ToJson: string;
begin
  Result := TJson.ObjectToJsonString( Self );
end;

end.
