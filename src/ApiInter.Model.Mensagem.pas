unit ApiInter.Model.Mensagem;

interface

uses
  ApiInter.Model.JsonSerializable;

type

  TMensagem = class(TJsonSerializable)
  private
    FLinha1: string;
    FLinha2: string;
    FLinha3: string;
    FLinha4: string;
    FLinha5: string;
    function GetLinha1: string;
    function GetLinha2: string;
    function GetLinha3: string;
    function GetLinha4: string;
    function GetLinha5: string;
    procedure SetLinha1(const Value: string);
    procedure SetLinha2(const Value: string);
    procedure SetLinha3(const Value: string);
    procedure SetLinha4(const Value: string);
    procedure SetLinha5(const Value: string);
  public
    property Linha1: string read GetLinha1 write SetLinha1;
    property Linha2: string read GetLinha2 write SetLinha2;
    property Linha3: string read GetLinha3 write SetLinha3;
    property Linha4: string read GetLinha4 write SetLinha4;
    property Linha5: string read GetLinha5 write SetLinha5;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TMensagem }

constructor TMensagem.Create;
begin
  FLinha1:= '';
  FLinha2:= '';
  FLinha3:= '';
  FLinha4:= '';
  FLinha5:= '';
end;

destructor TMensagem.Destroy;
begin

  inherited;
end;

function TMensagem.GetLinha1: string;
begin
  Result := FLinha1;
end;

function TMensagem.GetLinha2: string;
begin
  Result := FLinha2;
end;

function TMensagem.GetLinha3: string;
begin
  Result := FLinha3;
end;

function TMensagem.GetLinha4: string;
begin
  Result := FLinha4;
end;

function TMensagem.GetLinha5: string;
begin
  Result := FLinha5;
end;

procedure TMensagem.SetLinha1(const Value: string);
begin
  FLinha1 := Value;
end;

procedure TMensagem.SetLinha2(const Value: string);
begin
  FLinha2 := Value;
end;

procedure TMensagem.SetLinha3(const Value: string);
begin
  FLinha3 := Value;
end;

procedure TMensagem.SetLinha4(const Value: string);
begin
  FLinha4 := Value;
end;

procedure TMensagem.SetLinha5(const Value: string);
begin
  FLinha5 := Value;
end;

end.
