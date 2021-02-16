object FFormMain: TFFormMain
  Left = 0
  Top = 0
  Caption = 'FormMain'
  ClientHeight = 539
  ClientWidth = 967
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo: TMemo
    Left = 313
    Top = 0
    Width = 654
    Height = 539
    Align = alClient
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 313
    Height = 539
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 0
      Top = 153
      Width = 313
      Height = 68
      Align = alTop
      Caption = 'GET Boleto'
      TabOrder = 0
      object ButtonGetBoleto: TButton
        Left = 175
        Top = 30
        Width = 62
        Height = 25
        Caption = 'Get JSON'
        TabOrder = 0
        OnClick = ButtonGetBoletoClick
      end
      object EditNossoNomero: TLabeledEdit
        Left = 10
        Top = 34
        Width = 159
        Height = 21
        EditLabel.Width = 69
        EditLabel.Height = 13
        EditLabel.Caption = 'Nosso N'#250'mero'
        TabOrder = 1
      end
      object ButtonGetPDF: TButton
        Left = 245
        Top = 30
        Width = 62
        Height = 25
        Caption = 'Get PDF'
        TabOrder = 2
        OnClick = ButtonGetPDFClick
      end
    end
    object GroupBoxConf: TGroupBox
      Left = 0
      Top = 0
      Width = 313
      Height = 153
      Align = alTop
      Caption = 'Conf'
      TabOrder = 1
      object SpeedButton1: TSpeedButton
        Left = 284
        Top = 36
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = SpeedButton1Click
      end
      object SpeedButton2: TSpeedButton
        Left = 284
        Top = 77
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = SpeedButton2Click
      end
      object EditCertificateFile: TLabeledEdit
        Left = 7
        Top = 37
        Width = 274
        Height = 21
        EditLabel.Width = 94
        EditLabel.Height = 13
        EditLabel.Caption = 'Certificate File Path'
        TabOrder = 0
        Text = 'D:\ssl\certs\certificado.crt'
      end
      object EditKeyFile: TLabeledEdit
        Left = 7
        Top = 77
        Width = 274
        Height = 21
        EditLabel.Width = 62
        EditLabel.Height = 13
        EditLabel.Caption = 'Key File Path'
        TabOrder = 1
        Text = 'D:\ssl\certs\certificado.key'
      end
      object EditAccountNumber: TLabeledEdit
        Left = 8
        Top = 117
        Width = 299
        Height = 21
        EditLabel.Width = 79
        EditLabel.Height = 13
        EditLabel.Caption = 'Account Number'
        TabOrder = 2
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 338
      Width = 313
      Height = 198
      Align = alTop
      Caption = 'Create Boleto'
      TabOrder = 2
      object ButtonCreateBoleto: TButton
        Left = 232
        Top = 144
        Width = 75
        Height = 25
        Caption = 'Create'
        TabOrder = 0
        OnClick = ButtonCreateBoletoClick
      end
      object EditPagadorNome: TLabeledEdit
        Left = 10
        Top = 37
        Width = 194
        Height = 21
        EditLabel.Width = 70
        EditLabel.Height = 13
        EditLabel.Caption = 'Pagador Nome'
        TabOrder = 1
      end
      object EditPagadorCPF: TLabeledEdit
        Left = 211
        Top = 37
        Width = 96
        Height = 21
        EditLabel.Width = 62
        EditLabel.Height = 13
        EditLabel.Caption = 'Pagador CPF'
        TabOrder = 2
      end
      object EditPagadorUF: TLabeledEdit
        Left = 146
        Top = 77
        Width = 58
        Height = 21
        EditLabel.Width = 59
        EditLabel.Height = 13
        EditLabel.Caption = ' Pagador UF'
        MaxLength = 2
        TabOrder = 3
      end
      object EditBeneficiarioCNPJ: TLabeledEdit
        Left = 10
        Top = 117
        Width = 194
        Height = 21
        EditLabel.Width = 83
        EditLabel.Height = 13
        EditLabel.Caption = 'Beneficiario CNPJ'
        TabOrder = 4
      end
      object EditSeuNumero: TLabeledEdit
        Left = 211
        Top = 117
        Width = 96
        Height = 21
        EditLabel.Width = 61
        EditLabel.Height = 13
        EditLabel.Caption = ' Seu N'#250'mero'
        MaxLength = 2
        TabOrder = 5
      end
      object EditPagadorCidade: TLabeledEdit
        Left = 11
        Top = 77
        Width = 129
        Height = 21
        EditLabel.Width = 76
        EditLabel.Height = 13
        EditLabel.Caption = 'Pagador Cidade'
        TabOrder = 6
      end
      object EditPagadorCEP: TLabeledEdit
        Left = 211
        Top = 77
        Width = 96
        Height = 21
        EditLabel.Width = 62
        EditLabel.Height = 13
        EditLabel.Caption = 'Pagador CEP'
        TabOrder = 7
      end
    end
    object MemoAlert: TMemo
      Left = 0
      Top = 221
      Width = 313
      Height = 117
      Align = alTop
      Color = 9934847
      Lines.Strings = (
        'ATEN'#199#195'O!'
        ''
        'Todas as cobran'#231'as s'#227'o registradas no banco central e '
        'aparecer'#227'o no DDA dos sacados.'
        'Sendo assim, utilize seus pr'#243'prios dados ou de alguma pessoa '
        'que esteja ciente, pois todos os dados verific'#225'veis precisam '
        'ser v'#225'lidos (CPF/CNPJ, CEP, Cidade e Estado). ')
      TabOrder = 3
    end
  end
  object OpenDialog: TOpenDialog
    Left = 344
    Top = 8
  end
end
