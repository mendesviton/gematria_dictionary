program GematriaProjeto;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frGematriaPrincipal},
  uExportacao in 'uExportacao.pas' {frExportacao},
  uConexaoBanco in 'model\uConexaoBanco.pas',
  uControleSQL in 'model\uControleSQL.pas',
  uUtil in 'uUtil.pas',
  Vcl.Themes,
  Vcl.Styles,
  uThread in 'Threads\uThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrGematriaPrincipal, frGematriaPrincipal);
  Application.Run;
end.
