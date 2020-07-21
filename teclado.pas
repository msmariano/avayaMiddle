unit teclado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel13Click(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel5MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel6MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel7MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel7MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel8MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel8MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel9MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel9MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel10MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel10MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel11MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel11MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel12MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel12MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel14MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel14MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses toolbar;

{$R *.dfm}

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
   sc_DragMove = $f012;
begin
  ReleaseCapture;
  Perform(wm_SysCommand, sc_DragMove, 0);
end;


procedure TForm1.Panel10MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel10.BevelOuter := bvLowered;
  Form1.Panel10.Color := clBtnShadow;
  Form3.EditDisplay.Text := Form3.EditDisplay.Text+'*';
end;

procedure TForm1.Panel10MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel10.BevelOuter := bvRaised;
  Form1.Panel10.Color := clSilver;
end;

procedure TForm1.Panel11MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel11.BevelOuter := bvLowered;
  Form1.Panel11.Color := clBtnShadow;
  Form3.EditDisplay.Text := Form3.EditDisplay.Text+'0';
end;

procedure TForm1.Panel11MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel11.BevelOuter := bvRaised;
  Form1.Panel11.Color := clSilver;
end;

procedure TForm1.Panel12MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel12.BevelOuter := bvLowered;
  Form1.Panel12.Color := clBtnShadow;
  Form3.EditDisplay.Text := Form3.EditDisplay.Text+'#';
end;

procedure TForm1.Panel12MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel12.BevelOuter := bvRaised;
  Form1.Panel12.Color := clSilver;
end;

procedure TForm1.Panel13Click(Sender: TObject);
begin
Form1.Close;
end;

procedure TForm1.Panel14MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  campo : string;
begin
  Form1.Panel14.BevelOuter := bvLowered;
  Form1.Panel14.Color := clBtnShadow;
  campo := form3.EditDisplay.text;
  delete(campo,length(campo),1);
  form3.EditDisplay.text := campo;
end;

procedure TForm1.Panel14MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel14.BevelOuter := bvRaised;
  Form1.Panel14.Color := clSilver;
end;

procedure TForm1.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel1.BevelOuter := bvLowered;
  Form1.Panel1.Color := clBtnShadow;
  Form3.EditDisplay.Text := Form3.EditDisplay.Text+'1';
end;

procedure TForm1.Panel1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel1.BevelOuter := bvRaised;
  Form1.Panel1.Color := clSilver;
end;

procedure TForm1.Panel2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel2.BevelOuter := bvLowered;
  Form1.Panel2.Color := clBtnShadow;
  Form3.EditDisplay.Text := Form3.EditDisplay.Text+'2';
end;

procedure TForm1.Panel2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel2.BevelOuter := bvRaised;
  Form1.Panel2.Color := clSilver;
end;

procedure TForm1.Panel3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel3.BevelOuter := bvLowered;
  Form1.Panel3.Color := clBtnShadow;
  Form3.EditDisplay.Text := Form3.EditDisplay.Text+'3';
end;

procedure TForm1.Panel3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel3.BevelOuter := bvRaised;
  Form1.Panel3.Color := clSilver;
end;

procedure TForm1.Panel4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel4.BevelOuter := bvLowered;
  Form1.Panel4.Color := clBtnShadow;
  Form3.EditDisplay.Text := Form3.EditDisplay.Text+'4';
end;

procedure TForm1.Panel4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel4.BevelOuter := bvRaised;
  Form1.Panel4.Color := clSilver;
end;

procedure TForm1.Panel5MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel5.BevelOuter := bvLowered;
  Form1.Panel5.Color := clBtnShadow;
  Form3.EditDisplay.Text := Form3.EditDisplay.Text+'5';
end;

procedure TForm1.Panel5MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel5.BevelOuter := bvRaised;
  Form1.Panel5.Color := clSilver;
end;

procedure TForm1.Panel6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel6.BevelOuter := bvLowered;
  Form1.Panel6.Color := clBtnShadow;
  Form3.EditDisplay.Text := Form3.EditDisplay.Text+'6';
end;

procedure TForm1.Panel6MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel6.BevelOuter := bvRaised;
  Form1.Panel6.Color := clSilver;
end;

procedure TForm1.Panel7MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel7.BevelOuter := bvLowered;
  Form1.Panel7.Color := clBtnShadow;
  Form3.EditDisplay.Text := Form3.EditDisplay.Text+'7';
end;

procedure TForm1.Panel7MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel7.BevelOuter := bvRaised;
  Form1.Panel7.Color := clSilver;
end;

procedure TForm1.Panel8MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel8.BevelOuter := bvLowered;
  Form1.Panel8.Color := clBtnShadow;
  Form3.EditDisplay.Text := Form3.EditDisplay.Text+'8';
end;

procedure TForm1.Panel8MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel8.BevelOuter := bvRaised;
  Form1.Panel8.Color := clSilver;
end;

procedure TForm1.Panel9MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel9.BevelOuter := bvLowered;
  Form1.Panel9.color := clBtnShadow;
  Form3.EditDisplay.Text := Form3.EditDisplay.Text+'9';
end;

procedure TForm1.Panel9MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Panel9.BevelOuter := bvRaised;
  Form1.Panel9.Color := clSilver;
end;

end.
