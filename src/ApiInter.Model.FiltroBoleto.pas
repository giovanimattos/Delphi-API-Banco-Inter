unit ApiInter.Model.FiltroBoleto;

interface
uses
  ApiInter.Model.JsonSerializable, REST.Json.Types, JSON, dateutils;
const
    FILTRO_RELACAO_BOLETOS_FILTRARPOR_VENCIMENTO = 'VENCIMENTO';
    FILTRO_RELACAO_BOLETOS_FILTRARPOR_EMISSAO    = 'EMISSAO';
    FILTRO_RELACAO_BOLETOS_FILTRARPOR_SITUACAO   = 'SITUACAO';
    FILTRO_RELACAO_BOLETOS_SITUACAO_EXPIRADO     = 'EXPIRADO';
    FILTRO_RELACAO_BOLETOS_SITUACAO_VENCIDO      = 'VENCIDO';
    FILTRO_RELACAO_BOLETOS_SITUACAO_EMABERTO     = 'EMABERTO';
    FILTRO_RELACAO_BOLETOS_SITUACAO_PAGO         = 'PAGO';
    FILTRO_RELACAO_BOLETOS_SITUACAO_CANCELADO    = 'CANCELADO';
    FILTRO_RELACAO_BOLETOS_ORDENARPOR_PAGADOR    = 'PAGADOR';
    FILTRO_RELACAO_BOLETOS_ORDENARPOR_NOSSONUMERO    = 'NOSSONUMERO';
    FILTRO_RELACAO_BOLETOS_ORDENARPOR_SEUNUMERO    = 'SEUNUMERO';
    FILTRO_RELACAO_BOLETOS_ORDENARPOR_DATASITUACAO    = 'DATASITUACAO';
    FILTRO_RELACAO_BOLETOS_ORDENARPOR_DATAVENCIMENTO    = 'DATAVENCIMENTO';
    FILTRO_RELACAO_BOLETOS_ORDENARPOR_VALOR    = 'VALOR';
    FILTRO_RELACAO_BOLETOS_ORDENARPOR_STATUS    = 'STATUS';


    FILTRO_RELACAO_BOLETOS_TIPOORDENACAO_ASC    = 'ASC';
    FILTRO_RELACAO_BOLETOS_TIPOORDENACAO_DESC    = 'DESC';
type
  TFiltroBoleto = class(TJsonSerializable)
  private
    FfiltrarDataPor: String;
    FdataFinal: String;
    FdataInicial: String;
    Fsituacao: String;
    Fnome: String;
    Femail: String;
    FitensPorPagina: integer;
    FpaginaAtual: Integer;
    FordenarPor: String;
    FtipoOrdenacao: String; public
    function ToJson: TJSONObject; override;
    property dataInicial: String read FdataInicial write FdataInicial;
    property dataFinal: String read FdataFinal write FdataFinal;
    property filtrarDataPor: String read FfiltrarDataPor write FfiltrarDataPor;
    property situacao: String read Fsituacao write Fsituacao;
    property nome: String read Fnome write Fnome;
    property email: String read Femail write Femail;
    property itensPorPagina: integer read FitensPorPagina write FitensPorPagina;
    property paginaAtual: Integer read FpaginaAtual write FpaginaAtual;
    property ordenarPor: String read FordenarPor write FordenarPor;
    property tipoOrdenacao: String read FtipoOrdenacao write FtipoOrdenacao;
    procedure setDataInicial(pData:TDate);
    procedure setDataFinal(pData:TDate);
    constructor create; overload;
    constructor create(pDataInicial, pDataFinal:TDate; pFiltrarDataPor:String = FILTRO_RELACAO_BOLETOS_FILTRARPOR_VENCIMENTO; pSituacao:String = '' ); overload;
  end;
  TRetornoFiltroBoleto = class(TJsonSerializable)
  private

    FtotalPages: Integer;
    FtotalElements: Integer;
    Flast: Boolean;
    Ffirst: Boolean;
    Fsize: Integer;
    FnumberOfElements: Integer;    public
  public
    property totalPages: Integer read FtotalPages write FtotalPages;  //Quantidade total de páginas disponíveis para consulta.
    property totalElements: Integer read FtotalElements write FtotalElements; //Quantidade total de itens disponíveis de acordo com os parâmetros informados.
    property last: Boolean read Flast write Flast; //Última página
    property first: Boolean read Ffirst write Ffirst; //Primeira página
    property size: Integer read Fsize write Fsize; //Quantidade de registros por página, configurado na requisição.
    property numberOfElements: Integer read FnumberOfElements write FnumberOfElements; //Quantidade de registros retornado na página atual.
    constructor create;
  end;


implementation

uses
  System.SysUtils;

{ TFiltroBoleto }

constructor TFiltroBoleto.create;
begin
  inherited create;
  self.setDataInicial(today-1);
  self.setDataFinal(today);
  //Valores padrão da API:
  self.filtrarDataPor := FILTRO_RELACAO_BOLETOS_FILTRARPOR_VENCIMENTO;
  self.situacao       := '';
  self.ordenarPor     := FILTRO_RELACAO_BOLETOS_ORDENARPOR_PAGADOR;
  self.tipoOrdenacao  := FILTRO_RELACAO_BOLETOS_TIPOORDENACAO_ASC;
  self.itensPorPagina := 1000;
  self.paginaAtual    := 0;
end;

constructor TFiltroBoleto.create(pDataInicial, pDataFinal: TDate;
  pFiltrarDataPor, pSituacao: String);
begin
  inherited create;
  self.setDataInicial(pDataInicial);
  self.setDataFinal(pDataFinal);
  self.filtrarDataPor := pFiltrarDataPor;
  self.situacao       := pSituacao;
  //Valores padrão da API:
  self.ordenarPor     := FILTRO_RELACAO_BOLETOS_ORDENARPOR_PAGADOR;
  self.tipoOrdenacao  := FILTRO_RELACAO_BOLETOS_TIPOORDENACAO_ASC;
  self.itensPorPagina := 1000;
  self.paginaAtual    := 0;
end;

procedure TFiltroBoleto.setDataFinal(pData: TDate);
begin
  self.dataFinal  := FormatDateTime('yyyy-mm-dd', pData);
end;

procedure TFiltroBoleto.setDataInicial(pData: TDate);
begin
  self.dataInicial := FormatDateTime('yyyy-mm-dd', pData);

end;

function TFiltroBoleto.ToJson: TJSONObject;
var
  I: Integer;
begin
  result := inherited;
  for I := result.Count-1 downto 0 do
    if result.Pairs[i].JsonValue.Value= '' then
    begin
      Result.RemovePair(result.Pairs[i].JsonString.Value);
    end;

end;

{ TRetornoFiltroBoleto }

constructor TRetornoFiltroBoleto.create;
begin
  self.last  := false;
  self.first := false;
end;

end.
