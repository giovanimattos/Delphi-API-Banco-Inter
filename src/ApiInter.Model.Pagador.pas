unit ApiInter.Model.Pagador;

interface

uses
  ApiInter.Model.JsonSerializable, SysUtils;

type

  TPagador = class(TJsonSerializable)
  private
    FcpfCnpj: String;
    FTipoPessoa: String;
    FEmail: String;
    FBairro: String;
    Fddd: String;
    FUf: String;
    FCep: String;
    FNumero: String;
    FComplemento: String;
    FNome: String;
    FCidade: String;
    FEndereco: String;
    FTelefone: String;
    function GetcpfCnpj: String;
    function GetBairro: String;
    function GetCep: String;
    function GetCidade: String;
    function GetComplemento: String;
    function Getddd: String;
    function GetEmail: String;
    function GetEndereco: String;
    function GetNome: String;
    function GetNumero: String;
    function GetTelefone: String;
    function GetTipoPessoa: String;
    function GetUf: String;
    procedure SetcpfCnpj(const Value: String);
    procedure SetBairro(const Value: String);
    procedure SetCep(const Value: String);
    procedure SetCidade(const Value: String);
    procedure SetComplemento(const Value: String);
    procedure Setddd(const Value: String);
    procedure SetEmail(const Value: String);
    procedure SetEndereco(const Value: String);
    procedure SetNome(const Value: String);
    procedure SetNumero(const Value: String);
    procedure SetTelefone(const Value: String);
    procedure SetTipoPessoa(const Value: String);
    procedure SetUf(const Value: String);
  public
    property cpfCnpj: String read GetcpfCnpj write SetcpfCnpj;
    property Nome: String read GetNome write SetNome;
    property Cep: String read GetCep write SetCep;
    property Bairro: String read GetBairro write SetBairro;
    property Endereco: String read GetEndereco write SetEndereco;
    property Numero: String read GetNumero write SetNumero;
    property Complemento: String read GetComplemento write SetComplemento;
    property Cidade: String read GetCidade write SetCidade;
    property Uf: String read GetUf write SetUf;
    property TipoPessoa: String read GetTipoPessoa write SetTipoPessoa;
    property Email: String read GetEmail write SetEmail;
    property ddd: String read Getddd write Setddd;
    property Telefone: String read GetTelefone write SetTelefone;
  end;

const
  PESSOA_FISICA = 'FISICA';
  PESSOA_JURIDICA = 'JURIDICA';

implementation

{ TPagador }

function TPagador.GetBairro: String;
begin
  Result := FBairro;
end;

function TPagador.GetCep: String;
begin
  Result := FCep;
end;

function TPagador.GetCidade: String;
begin
  Result := FCidade;
end;

function TPagador.GetcpfCnpj: String;
begin
  Result := FcpfCnpj;
end;

function TPagador.GetComplemento: String;
begin
  Result := FComplemento;
end;

function TPagador.Getddd: String;
begin
  Result := Fddd;
end;

function TPagador.GetEmail: String;
begin
  Result := FEmail;
end;

function TPagador.GetEndereco: String;
begin
  Result := FEndereco;
end;

function TPagador.GetNome: String;
begin
  Result := FNome;
end;

function TPagador.GetNumero: String;
begin
  Result := FNumero;
end;

function TPagador.GetTelefone: String;
begin
  Result := FTelefone;
end;

function TPagador.GetTipoPessoa: String;
begin
  Result := FTipoPessoa;
end;

function TPagador.GetUf: String;
begin
  Result := FUf;
end;

procedure TPagador.SetBairro(const Value: String);
begin
  FBairro := Value;
end;

procedure TPagador.SetCep(const Value: String);
begin
  FCep :=  Value.Replace('-','');
end;

procedure TPagador.SetCidade(const Value: String);
begin
  FCidade := Value;
end;

procedure TPagador.SetcpfCnpj(const Value: String);
begin
  FcpfCnpj := Value;
end;

procedure TPagador.SetComplemento(const Value: String);
begin
  FComplemento := Value;
end;

procedure TPagador.Setddd(const Value: String);
begin
  Fddd := Value;
end;

procedure TPagador.SetEmail(const Value: String);
begin
  FEmail := Value;
end;

procedure TPagador.SetEndereco(const Value: String);
begin
  FEndereco := Value;
end;

procedure TPagador.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TPagador.SetNumero(const Value: String);
begin
  FNumero := Value;
end;

procedure TPagador.SetTelefone(const Value: String);
begin
  FTelefone := Value;
end;

procedure TPagador.SetTipoPessoa(const Value: String);
begin
  FTipoPessoa := Value;
end;

procedure TPagador.SetUf(const Value: String);
begin
  FUf := Value;
end;

end.
