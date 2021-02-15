unit ApiInter.Model.Desconto;

interface

uses
  ApiInter.Model.JsonSerializable;

type

  TDesconto = class(TJsonSerializable)
  private
    FCodigoDesconto: String;
    FValor: Currency;
    FTaxa: Currency;
    FData: String;
    function GetCodigoDesconto: String;
    function GetData: String;
    function GetTaxa: Currency;
    function GetValor: Currency;
    procedure SetCodigoDesconto(const Value: String);
    procedure SetData(const Value: String);
    procedure SetTaxa(const Value: Currency);
    procedure SetValor(const Value: Currency);
  public
    property CodigoDesconto: String read GetCodigoDesconto write SetCodigoDesconto;
    property Valor: Currency read GetValor write SetValor;
    property Taxa: Currency read GetTaxa write SetTaxa;
    property Data: String read GetData write SetData;
    constructor Create;
    destructor Destroy; override;
  end;

const
  NAO_TEM_DESCONTO = 'NAOTEMDESCONTO';
  VALOR_FIXO = 'VALORFIXODATAINFORMADA';
  PERCENTUAL_FIXO = 'PERCENTUALDATAINFORMADA';
  VALOR_DIA_CORRIDO = 'VALORANTECIPACAODIACORRIDO';
  VALOR_DIA_UTIL = 'VALORANTECIPACAODIAUTIL';
  PERCENTUAL_DIA_CORRIDO = 'PERCENTUALVALORNOMINALDIACORRIDO';
  PERCENTUAL_DIA_UTIL = 'PERCENTUALVALORNOMINALDIAUTIL';

implementation

{ TDesconto }

constructor TDesconto.Create;
begin
  FCodigoDesconto := NAO_TEM_DESCONTO;
  FValor := 0.0;
  FTaxa := 0.0;
  FData := '';
end;

destructor TDesconto.Destroy;
begin

  inherited;
end;

function TDesconto.GetCodigoDesconto: String;
begin
  Result := FCodigoDesconto;
end;

function TDesconto.GetData: String;
begin
  Result := FData;
end;

function TDesconto.GetTaxa: Currency;
begin
  Result := FTaxa;
end;

function TDesconto.GetValor: Currency;
begin
  Result := FValor;
end;

procedure TDesconto.SetCodigoDesconto(const Value: String);
begin
  FCodigoDesconto := Value;
end;

procedure TDesconto.SetData(const Value: String);
begin
  FData := Value;
end;

procedure TDesconto.SetTaxa(const Value: Currency);
begin
  FTaxa := Value;
end;

procedure TDesconto.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

end.

