unit View.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, System.DateUtils, Winapi.ShellAPI;

type
  TFFormMain = class(TForm)
    Memo: TMemo;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    ButtonGetBoleto: TButton;
    EditNossoNomero: TLabeledEdit;
    GroupBoxConf: TGroupBox;
    EditCertificateFile: TLabeledEdit;
    EditKeyFile: TLabeledEdit;
    EditAccountNumber: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    OpenDialog: TOpenDialog;
    GroupBox2: TGroupBox;
    ButtonCreateBoleto: TButton;
    EditPagadorNome: TLabeledEdit;
    EditPagadorCPF: TLabeledEdit;
    EditPagadorUF: TLabeledEdit;
    EditBeneficiarioCNPJ: TLabeledEdit;
    EditSeuNumero: TLabeledEdit;
    MemoAlert: TMemo;
    EditPagadorCidade: TLabeledEdit;
    EditPagadorCEP: TLabeledEdit;
    ButtonGetPDF: TButton;
    procedure ButtonGetBoletoClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure ButtonCreateBoletoClick(Sender: TObject);
    procedure ButtonGetPDFClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetDir(Edit: TLabeledEdit);
  public
    { Public declarations }
  end;

var
  FFormMain: TFFormMain;

implementation

uses
  ApiInter.Model.BancoInter, ApiInter.Model.Boleto, ApiInter.Model.Pagador;

{$R *.dfm}

procedure TFFormMain.GetDir(Edit: TLabeledEdit);
begin
  OpenDialog.InitialDir := ExtractFileDir(Edit.Text);
  if (OpenDialog.Execute) then
    Edit.Text := OpenDialog.FileName;
end;

procedure TFFormMain.SpeedButton1Click(Sender: TObject);
begin
  GetDir(EditCertificateFile);
end;

procedure TFFormMain.SpeedButton2Click(Sender: TObject);
begin
  GetDir(EditKeyFile)
end;

procedure TFFormMain.ButtonCreateBoletoClick(Sender: TObject);
begin

  var Boleto: TBoleto := TBoleto.Create;
  var BancoInter: TBancoInter := TBancoInter.Create(EditAccountNumber.Text, EditCertificateFile.Text, EditKeyFile.Text);
  try

    Boleto.Pagador.TipoPessoa := PESSOA_FISICA;
    Boleto.Pagador.Nome := EditPagadorNome.Text;
    Boleto.Pagador.CnpjCpf := EditPagadorCPF.Text;
    Boleto.Pagador.Cidade := EditPagadorCidade.Text;
    Boleto.Pagador.Uf := EditPagadorUF.Text;
    Boleto.Pagador.Cep := EditPagadorCEP.Text;
    Boleto.Pagador.Endereco := 'Rua teste';
    Boleto.Pagador.Numero := '999';
    Boleto.Pagador.Bairro := 'Bairro';

    Boleto.cnpjCPFBeneficiario := EditBeneficiarioCNPJ.Text;
    Boleto.SeuNumero := EditSeuNumero.Text;
    Boleto.DataEmissao := FormatDateTime('yyyy-mm-dd', Date);
    Boleto.DataVencimento := FormatDateTime('yyyy-mm-dd', IncDay(Date, 10));
    Boleto.ValorNominal := 10.0;

    Memo.Text := BancoInter.CreateBoleto(Boleto);

  finally
    Boleto.Free;
    BancoInter.Free;
  end;

end;

procedure TFFormMain.ButtonGetBoletoClick(Sender: TObject);
begin

  var BancoInter: TBancoInter := TBancoInter.Create(EditAccountNumber.Text, EditCertificateFile.Text, EditKeyFile.Text);
  try

    Memo.Text := BancoInter.GetBoleto( EditNossoNomero.Text );

  finally
    BancoInter.Free;
  end;


end;

procedure TFFormMain.ButtonGetPDFClick(Sender: TObject);
begin
  var BancoInter: TBancoInter := TBancoInter.Create(EditAccountNumber.Text, EditCertificateFile.Text, EditKeyFile.Text);
  try

    Memo.Text := BancoInter.getPdfBoleto( EditNossoNomero.Text, ExtractFilePath(Application.ExeName) );
    ShellExecute(Handle, nil, PChar(Memo.Text), nil,  nil, SW_SHOWNORMAL);

  finally
    BancoInter.Free;
  end;
end;

end.
