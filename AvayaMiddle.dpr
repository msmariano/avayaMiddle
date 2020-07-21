program AvayaMiddle;

uses
  Vcl.Forms,
  toolbar in 'toolbar.pas' {Form3},
  teclado in 'teclado.pas' {Form1},
  config in 'config.pas' {Form2},
  historico in 'historico.pas' {Form4},
  testes in 'testes.pas' {Form5},
  Tapi in 'Tapi.pas',
  transferir in 'transferir.pas' {Form6};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Avaya Middleware';
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.Run;
end.
