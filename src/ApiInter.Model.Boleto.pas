unit ApiInter.Model.Boleto;

interface

uses
  ApiInter.Model.JsonSerializable, ApiInter.Model.Desconto, ApiInter.Model.Multa,
  ApiInter.Model.Mensagem, ApiInter.Model.Mora, ApiInter.Model.Pagador,
  REST.Json.Types, SysUtils;

type

  TBoleto = class(TJsonSerializable)
  private
    FPagador: TPagador;
    FValorNominal: Currency;
    FLinhaDigitavel: String;
    FNossoNumero: String;
    FMora: TMora;
    FCodigoBarras: String;
    FDataVencimento: String;
    FMulta: TMulta;
    FDataEmissao: String;
    FcnpjCPFBeneficiario: string;
    FSeuNumero: string;
    FNumDiasAgenda: Integer;
    FValorAbatimento: Currency;
    FMensagem: TMensagem;
    FDesconto2: TDesconto;
    FDesconto3: TDesconto;
    FDesconto1: TDesconto;
    Fsituacao: String;
    FvalorTotalRecebimento: Currency;
    FdataHoraSituacao: String;
    function GetcnpjCPFBeneficiario: string;
    function GetCodigoBarras: String;
    function GetDataEmissao: String;
    function GetDataVencimento: String;
    function GetDesconto1: TDesconto;
    function GetDesconto2: TDesconto;
    function GetDesconto3: TDesconto;
    function GetLinhaDigitavel: String;
    function GetMensagem: TMensagem;
    function GetMora: TMora;
    function GetMulta: TMulta;
    function GetNossoNumero: String;
    function GetNumDiasAgenda: Integer;
    function GetPagador: TPagador;
    function GetSeuNumero: string;
    function GetValorAbatimento: Currency;
    function GetValorNominal: Currency;
    procedure SetcnpjCPFBeneficiario(const Value: string);
    procedure SetCodigoBarras(const Value: String);
    procedure SetDataEmissao(const Value: String);
    procedure SetDataVencimento(const Value: String);
    procedure SetDesconto1(const Value: TDesconto);
    procedure SetDesconto2(const Value: TDesconto);
    procedure SetDesconto3(const Value: TDesconto);
    procedure SetLinhaDigitavel(const Value: String);
    procedure SetMensagem(const Value: TMensagem);
    procedure SetMora(const Value: TMora);
    procedure SetMulta(const Value: TMulta);
    procedure SetNossoNumero(const Value: String);
    procedure SetNumDiasAgenda(const Value: Integer);
    procedure SetPagador(const Value: TPagador);
    procedure SetSeuNumero(const Value: string);
    procedure SetValorAbatimento(const Value: Currency);
    procedure SetValorNominal(const Value: Currency);
  public
    property DataEmissao: String read GetDataEmissao write SetDataEmissao;
    property SeuNumero: string read GetSeuNumero write SetSeuNumero;
    property DataVencimento: String read GetDataVencimento write SetDataVencimento;
    property ValorNominal: Currency read GetValorNominal write SetValorNominal;
    property ValorAbatimento: Currency read GetValorAbatimento write SetValorAbatimento;
    property cnpjCPFBeneficiario: string read GetcnpjCPFBeneficiario write SetcnpjCPFBeneficiario;
    property NumDiasAgenda: Integer read GetNumDiasAgenda write SetNumDiasAgenda;
    property Pagador: TPagador read GetPagador write SetPagador;
    property Mensagem: TMensagem read GetMensagem write SetMensagem;
    property Desconto1: TDesconto read GetDesconto1 write SetDesconto1;
    property Desconto2: TDesconto read GetDesconto2 write SetDesconto2;
    property Desconto3: TDesconto read GetDesconto3 write SetDesconto3;
    property Multa: TMulta read GetMulta write SetMulta;
    property Mora: TMora read GetMora write SetMora;
    //Dados provenientes do Banco:
    property NossoNumero: String read GetNossoNumero write SetNossoNumero;
    property CodigoBarras: String read GetCodigoBarras write SetCodigoBarras;
    property LinhaDigitavel: String read GetLinhaDigitavel write SetLinhaDigitavel;
    property situacao: String read Fsituacao write Fsituacao;
    property valorTotalRecebimento: Currency read FvalorTotalRecebimento write FvalorTotalRecebimento;
    property dataHoraSituacao: String read FdataHoraSituacao write FdataHoraSituacao;
    function getDataHoraSituacao:TDateTime;

    //property Controller = null;
    constructor Create;
    destructor Destroy; override;
  end;

  TBoletoPDFRetorno = class(TJsonSerializable)
  private
    Fpdf: String;
  published
    property pdf: String read Fpdf write Fpdf;
  end;
  TBoletoCancelamento = class(TJsonSerializable)
  private
    FmotivoCancelamento: String;
  published
    property motivoCancelamento: String read FmotivoCancelamento write FmotivoCancelamento;
  end;

const
  SESSENTA_DIAS = 60;
  TRINTA_DIAS   = 30;


    MOTIVO_CANCELAMENTO_ACERTOS = 'ACERTOS' ;// (cancelado por acertos)
    MOTIVO_CANCELAMENTO_APEDIDODOCLIENTE = 'APEDIDODOCLIENTE'; //(cancelado a pedido do cliente)
    MOTIVO_CANCELAMENTO_PAGODIRETOAOCLIENTE = 'PAGODIRETOAOCLIENTE';// (cancelado por ter sido pago direto ao cliente)
    MOTIVO_CANCELAMENTO_SUBSTITUICAO = 'SUBSTITUICAO';// (cancelado por substituição)


implementation

uses
  ApiInter.Commons;

{ TBoleto }

constructor TBoleto.Create;
begin
  FValorNominal:= 0.0;
  FLinhaDigitavel:= '';
  FNossoNumero:= '';
  FCodigoBarras:= '';
  FDataVencimento:= '';
  FDataEmissao:= '';
  FcnpjCPFBeneficiario:= '';
  FSeuNumero:= '';
  FNumDiasAgenda:= SESSENTA_DIAS;
  FValorAbatimento:= 0.0;
  FMora:= TMora.Create;
  FMulta:= TMulta.Create;
  FPagador:= TPagador.Create;
  FMensagem:= TMensagem.Create;
  FDesconto1:= TDesconto.Create;
  FDesconto2:= TDesconto.Create;
  FDesconto3:= TDesconto.Create;
end;

destructor TBoleto.Destroy;
begin
  FMora.Free;
  FMulta.Free;
  FPagador.Free;
  FMensagem.Free;
  FDesconto1.Free;
  FDesconto2.Free;
  FDesconto3.Free;
  inherited;
end;

function TBoleto.GetcnpjCPFBeneficiario: string;
begin
  Result := FcnpjCPFBeneficiario;
end;

function TBoleto.GetCodigoBarras: String;
begin
  Result := FCodigoBarras;
end;

function TBoleto.GetDataEmissao: String;
begin
  Result := FDataEmissao;
end;

function TBoleto.getDataHoraSituacao: TDateTime;
begin
  result := StrToDateTime(FdataHoraSituacao, FormatSettingsBancoInter)
end;

function TBoleto.GetDataVencimento: String;
begin
  Result := FDataVencimento;
end;

function TBoleto.GetDesconto1: TDesconto;
begin
  Result := FDesconto1;
end;

function TBoleto.GetDesconto2: TDesconto;
begin
  Result := FDesconto2;
end;

function TBoleto.GetDesconto3: TDesconto;
begin
  Result := FDesconto3;
end;

function TBoleto.GetLinhaDigitavel: String;
begin
  Result := FLinhaDigitavel;
end;

function TBoleto.GetMensagem: TMensagem;
begin
  Result := FMensagem;
end;

function TBoleto.GetMora: TMora;
begin
  Result := FMora;
end;

function TBoleto.GetMulta: TMulta;
begin
  Result := FMulta;
end;

function TBoleto.GetNossoNumero: String;
begin
  Result := FNossoNumero;
end;

function TBoleto.GetNumDiasAgenda: Integer;
begin
  Result := FNumDiasAgenda;
end;

function TBoleto.GetPagador: TPagador;
begin
  Result := FPagador;
end;

function TBoleto.GetSeuNumero: string;
begin
  Result := FSeuNumero;
end;

function TBoleto.GetValorAbatimento: Currency;
begin
  Result := FValorAbatimento;
end;

function TBoleto.GetValorNominal: Currency;
begin
  Result := FValorNominal;
end;

procedure TBoleto.SetcnpjCPFBeneficiario(const Value: string);
begin
  FcnpjCPFBeneficiario := Value;
end;

procedure TBoleto.SetCodigoBarras(const Value: String);
begin
  FCodigoBarras := Value;
end;

procedure TBoleto.SetDataEmissao(const Value: String);
begin
  FDataEmissao := Value;
end;

procedure TBoleto.SetDataVencimento(const Value: String);
begin
  FDataVencimento := Value;
end;

procedure TBoleto.SetDesconto1(const Value: TDesconto);
begin
  FDesconto1 := Value;
end;

procedure TBoleto.SetDesconto2(const Value: TDesconto);
begin
  FDesconto2 := Value;
end;

procedure TBoleto.SetDesconto3(const Value: TDesconto);
begin
  FDesconto3 := Value;
end;

procedure TBoleto.SetLinhaDigitavel(const Value: String);
begin
  FLinhaDigitavel := Value;
end;

procedure TBoleto.SetMensagem(const Value: TMensagem);
begin
  FMensagem := Value;
end;

procedure TBoleto.SetMora(const Value: TMora);
begin
  FMora := Value;
end;

procedure TBoleto.SetMulta(const Value: TMulta);
begin
  FMulta := Value;
end;

procedure TBoleto.SetNossoNumero(const Value: String);
begin
  FNossoNumero := Value;
end;

procedure TBoleto.SetNumDiasAgenda(const Value: Integer);
begin
  FNumDiasAgenda := Value;
end;

procedure TBoleto.SetPagador(const Value: TPagador);
begin
  FPagador := Value;
end;

procedure TBoleto.SetSeuNumero(const Value: string);
begin
  FSeuNumero := Value;
end;

procedure TBoleto.SetValorAbatimento(const Value: Currency);
begin
  FValorAbatimento := Value;
end;

procedure TBoleto.SetValorNominal(const Value: Currency);
begin
  FValorNominal := Value;
end;

end.
