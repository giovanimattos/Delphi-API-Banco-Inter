program VCL;

uses
  Vcl.Forms,
  View.Main in 'src\View.Main.pas' {FFormMain};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFFormMain, FFormMain);
  Application.Run;
end.
