unit testes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm5 = class(TForm)
    Disca: TButton;
    Memo1: TMemo;
    Edit1: TEdit;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button3: TButton;
    procedure DiscaClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses Tapi;
{$R *.dfm}

var              hInstance: HInst;
      buf:array[0..1023] of char;
            lineApp: THLineApp;
            line: THLine;
            call: THCall;
            CallParams:TLineCallParams;

procedure lineCallback(hDevice, dwMsg, dwCallbackInstance,
            dwParam1, dwParam2, dwParam3: LongInt);
{$IFDEF WIN32}
            stdcall;
{$ELSE}
            export;
{$ENDIF}
      var
            s: string;
            hCall: THCall;
    hline:THline;
    Sender:Tobject;

      begin
      form5.memo1.Lines.Add('dwmsg='+inttostr(dwmsg)+'  dwparam1='+inttostr(dwparam1)+'  dwparam2='+inttostr(dwparam2)+'  dwparam3='+inttostr(dwparam3));

  end;

procedure TForm5.DiscaClick(Sender: TObject);
var
  nDevs, tapiVersion: Longint;
  extid: TLineExtensionID;
  c: array[0..30] of char;
begin
  edit1.text:='6654'; // your tel. no.
  FillChar(CallParams, sizeof(CallParams), 0);
  with CallParams do
  begin
    dwTotalSize := sizeof(CallParams);
    dwBearerMode := LINEBEARERMODE_VOICE;
    dwMediaMode := LINEMEDIAMODE_INTERACTIVEVOICE;
  end;

  if lineInitialize(lineApp, HInstance, @lineCallback, nil, nDevs) < 0 then { < 0 is an error }
    lineApp := 0
  else if nDevs = 0 then  { no TAPI devices?? }
  begin
    lineShutDown(lineApp);
    lineApp := 0;
  end
  else if lineNegotiateAPIVersion(lineApp, 0, $00010000, $10000000, tapiVersion, extid) < 0 then
  begin
    lineShutDown(lineApp);
    lineApp := 0;
  end
  else if lineOpen(lineApp, LINEMAPPER, line, tapiVersion, 0, 0, LINECALLPRIVILEGE_OWNER, LINEMEDIAMODE_AUTOMATEDVOICE ,@CallParams) < 0 then
  begin
    lineShutDown(lineApp);
    lineApp := 0;
    line := 0;
  end;

  if line = 0 then
    memo1.Lines.Add('Error!!');

  memo1.Lines.Clear;
  StrPCopy(c, Edit1.Text);

  if lineMakeCall(line, call, c, 0, @CallParams) < 0 then
    memo1.Lines.Add('Error in lineMakeCall');

end;



procedure TForm5.Button1Click(Sender: TObject);
begin
  lineAnswer(call, PChar('4654'), 0);
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
  lineclose(line);
end;

end.
