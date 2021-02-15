unit ApiInter.Model.Multa;

interface

uses
  ApiInter.Model.JsonSerializable;

type

  TMulta = class(TJsonSerializable)
  private
    FCodigoMulta: String;
    FValor: Currency;
    FTaxa: Currency;
    FData: String;
    function GetCodigoMulta: String;
    function GetData: String;
    function GetTaxa: Currency;
    function GetValor: Currency;
    procedure SetCodigoMulta(const Value: String);
    procedure SetData(const Value: String);
    procedure SetTaxa(const Value: Currency);
    procedure SetValor(const Value: Currency);
  public
    property CodigoMulta: String read GetCodigoMulta write SetCodigoMulta;
    property Valor: Currency read GetValor write SetValor;
    property Taxa: Currency read GetTaxa write SetTaxa;
    property Data: String read GetData write SetData;
    constructor Create;
    destructor Destroy; override;
  end;

const
  NAO_TEM_MULTA = 'NAOTEMMULTA';
  VALOR_FIXO = 'VALORFIXO';
  PERCENTUAL = 'PERCENTUAL';

implementation

{ TMulta }

constructor TMulta.Create;
begin
  FCodigoMulta := NAO_TEM_MULTA;
  FValor := 0.0;
  FTaxa := 0.0;
  FData := '';
end;

destructor TMulta.Destroy;
begin

  inherited;
end;

function TMulta.GetCodigoMulta: String;
begin
  Result := FCodigoMulta;
end;

function TMulta.GetData: String;
begin
  Result := FData;
end;

function TMulta.GetTaxa: Currency;
begin
  Result := FTaxa;
end;

function TMulta.GetValor: Currency;
begin
  Result := FValor;
end;

procedure TMulta.SetCodigoMulta(const Value: String);
begin
  FCodigoMulta := Value;
end;

procedure TMulta.SetData(const Value: String);
begin
  FData := Value;
end;

procedure TMulta.SetTaxa(const Value: Currency);
begin
  FTaxa := Value;
end;

procedure TMulta.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

end.
