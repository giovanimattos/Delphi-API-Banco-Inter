unit ApiInter.Model.Mora;

interface

uses
  ApiInter.Model.JsonSerializable;

type

  TMora = class(TJsonSerializable)
  private
    FCodigoMora: String;
    FValor: Currency;
    FTaxa: Currency;
    FData: String;
    function GetCodigoMora: String;
    function GetData: String;
    function GetTaxa: Currency;
    function GetValor: Currency;
    procedure SetCodigoMora(const Value: String);
    procedure SetData(const Value: String);
    procedure SetTaxa(const Value: Currency);
    procedure SetValor(const Value: Currency);
  public
    property CodigoMora: String read GetCodigoMora write SetCodigoMora;
    property Valor: Currency read GetValor write SetValor;
    property Taxa: Currency read GetTaxa write SetTaxa;
    property Data: String read GetData write SetData;
    constructor Create;
    destructor Destroy; override;
  end;

const
  ISENTO = 'ISENTO';
  TAXA_MENSAL = 'TAXAMENSAL';
  VALOR_POR_DIA = 'VALORDIA';

implementation

{ TMora }

constructor TMora.Create;
begin
  FCodigoMora := ISENTO;
  FValor := 0.0;
  FTaxa := 0.0;
  FData := '';
end;

destructor TMora.Destroy;
begin

  inherited;
end;

function TMora.GetCodigoMora: String;
begin
  Result := FCodigoMora;
end;

function TMora.GetData: String;
begin
  Result := FData;
end;

function TMora.GetTaxa: Currency;
begin
  Result := FTaxa;
end;

function TMora.GetValor: Currency;
begin
  Result := FValor;
end;

procedure TMora.SetCodigoMora(const Value: String);
begin
  FCodigoMora := Value;
end;

procedure TMora.SetData(const Value: String);
begin
  FData := Value;
end;

procedure TMora.SetTaxa(const Value: Currency);
begin
  FTaxa := Value;
end;

procedure TMora.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

end.

