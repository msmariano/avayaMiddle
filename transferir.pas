unit transferir;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm6 = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

uses toolbar;

{$R *.dfm}

procedure TForm6.Button1Click(Sender: TObject);
begin
  if Edit1.Text = '' then
  begin
    ShowMessage('ATENÇÃO! O número de transferência está em branco!');
  end
  else begin
    if form3.hbTapiLine1.Calls.count > 0 then
    begin
      form3.hold := false;

      form3.ListBox1.Items.Add('Calling Call.Transfer...');
      form3.hbTapiLine1.Calls[0].BlindTransfer(Edit1.Text);

      form3.Timer2.Enabled := False;
      form3.Timer3.Enabled := False;
      form3.EditDisplay.Clear;
      form3.EditDisplay.Enabled := True;
      form3.Label4.Caption := 'Conectado';
      form3.Label4.Left := 27;
      form3.Label4.Font.Color := clGreen;
      form3.Label4.Font.Style := [];
      form6.Close;
    end;
  end;
end;

end.
