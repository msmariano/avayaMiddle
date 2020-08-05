unit toolbar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, System.Types, System.StrUtils, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, hbTapi, hbTAPIUtils, hbTapiApi, ShellAPI,
  Vcl.Menus, System.Win.ScktComp;

type
  TForm3 = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    Image3: TImage;
    EditDisplay: TEdit;
    Label3: TLabel;
    Image4: TImage;
    Image5: TImage;
    Label4: TLabel;
    IdHTTP1: TIdHTTP;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    Image7: TImage;
    FDQuery2: TFDQuery;
    FDConnection1: TFDConnection;
    DataSource2: TDataSource;
    Image8: TImage;
    Label5: TLabel;
    Button1: TButton;
    hbTapiLine1: ThbTapiLine;
    ListBox1: TListBox;
    Timer4: TTimer;
    TrayIcon1: TTrayIcon;
    Button2: TButton;
    Button3: TButton;
    PopupMenu1: TPopupMenu;
    Sair1: TMenuItem;
    Label6: TLabel;
    ClientSocket1: TClientSocket;
    Memo1: TMemo;
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure EditDisplayKeyPress(Sender: TObject; var Key: Char);
    procedure Image10Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure EditDisplayChange(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure Memo1DblClick(Sender: TObject);
    procedure hbTapiLine1CallState(Sender: ThbTapiLine; Call: ThbTapiCall;
      CallState: Cardinal);
    procedure hbTapiLine1CallEnd(Sender: ThbTapiLine; Call: ThbTapiCall);
    procedure hbTapiLine1Disconnected(Sender: ThbTapiLine; Call: ThbTapiCall);
  private
    FNumMakeCall : Integer;
  public
    TimeOld: TDateTime;
    server,ramal,userdata: String;
    LineDevice,MediaMode,Privileges,Address,SyncMode : String;
    hold,event_hold : Boolean;
  end;

var
  Form3: TForm3;

{tapi Errors}
const TAPIERR_CONNECTED          = 0;
const TAPIERR_DROPPED            = -1;
const TAPIERR_NOREQUESTRECIPIENT = -2;
const TAPIERR_REQUESTQUEUEFULL   = -3;
const TAPIERR_INVALDESTADDRESS   = -4;
const TAPIERR_INVALWINDOWHANDLE  = -5;
const TAPIERR_INVALDEVICECLASS   = -6;
const TAPIERR_INVALDEVICEID      = -7;
const TAPIERR_DEVICECLASSUNAVAIL = -8;
const TAPIERR_DEVICEIDUNAVAIL    = -9;
const TAPIERR_DEVICEINUSE        = -10;
const TAPIERR_DESTBUSY           = -11;
const TAPIERR_DESTNOANSWER       = -12;
const TAPIERR_DESTUNAVAIL        = -13;
const TAPIERR_UNKNOWNWINHANDLE   = -14;
const TAPIERR_UNKNOWNREQUESTID   = -15;
const TAPIERR_REQUESTFAILED      = -16;
const TAPIERR_REQUESTCANCELLED   = -17;
const TAPIERR_INVALPOINTER       = -18;

{tapi size constants}
const TAPIMAXDESTADDRESSSIZE      = 80;
const TAPIMAXAPPNAMESIZE          = 40;
const TAPIMAXCALLEDPARTYSIZE      = 40;
const TAPIMAXCOMMENTSIZE          = 80;
const TAPIMAXDEVICECLASSSIZE      = 40;
const TAPIMAXDEVICEIDSIZE         = 40;


implementation

uses teclado, config, historico, testes, transferir;
{$R *.dfm}


function tapiRequestMakeCallA(DestAddress : PAnsiChar;
                              AppName : PAnsiChar;
                              CalledParty : PAnsiChar;
                              Comment : PAnsiChar) : LongInt;
  stdcall; external 'TAPI32.DLL';

function tapiRequestMakeCallW(DestAddress : PWideChar;
                              AppName : PWideChar;
                              CalledParty : PWideChar;
                              Comment : PWideChar) : LongInt;
  stdcall; external 'TAPI32.DLL';

function tapiRequestMakeCall(DestAddress : PChar;
                             AppName : PChar;
                             CalledParty : PChar;
                             Comment : PChar) : LongInt;
  stdcall; external 'TAPI32.DLL';


procedure TForm3.Button1Click(Sender: TObject);
begin
  form5.ShowModal;
end;

procedure TForm3.Button2Click(Sender: TObject);
var
  url, rml, link: string;
  datetime, callid, event, numa, numb : String;
  query : String;
begin
  query := 'Select ramal, link from config';
  FDQuery2.SQL.Clear;
  FDQuery2.SQL.Add(query);
  FDQuery2.Open;
  rml := FDQuery2.Fields[0].Value;
  link := FDQuery2.Fields[1].Value;
  numa := '41991956061';
  callid := '8743987';

  url := link+'ReceberLigacao.aspx?ramal='+rml+'&ani='+numa+'&callid='+callid;
  ShellExecute(Handle, '', Pchar(url) , '', '', SW_HIDE);
end;

procedure TForm3.Button3Click(Sender: TObject);
var
  url, rml, link, resp: string;
  datetime, callid, event, numa, numb : String;
  query : String;
begin
  query := 'Select ramal, link from config';
  FDQuery2.SQL.Clear;
  FDQuery2.SQL.Add(query);
  FDQuery2.Open;
  rml := FDQuery2.Fields[0].Value;
  link := FDQuery2.Fields[1].Value;
  numa := '41991956061';
  callid := '8743987';
  event := 'Connected';
  datetime := '20190331113650';

  url := link+'ReceberEvento.aspx?ramal='+rml+'&ani='+numa+'&callid='+callid+'&evento='+event+'&data='+datetime;
  resp := IdHTTP1.Get(url);
end;

procedure TForm3.EditDisplayChange(Sender: TObject);
begin
  Timer4.Enabled := False;
  form3.FormStyle := fsStayOnTop;
  Timer4.Enabled := True;
end;

procedure TForm3.EditDisplayKeyPress(Sender: TObject; var Key: Char);
begin
  if(key = #13) then
  begin
    if hbTapiLine1.Calls.count > 0 then
    begin
      ListBox1.Items.Add('Calling Call.Answer...');
      hbTapiLine1.Calls[0].Answer;
      if hbTapiLine1.Options.SyncMode then
        ListBox1.Items.Add('Call.Answer returned')
      else
        ListBox1.Items.Add('Answer returned. LastRequestID = 0x' + IntToHex(hbTapiLine1.LastRequestID, 2));
    end
    else begin
      if EditDisplay.Text = '' then
      begin
        ShowMessage('ATEN��O! Informe o n�mero para discar!');
      end
      else begin
        try
          hbTapiLine1.CallParams.MediaMode := StrToLineMediaMode(MediaMode);
          hbTapiLine1.CallParams.AddressID := form2.ComboBox_Address.ItemIndex;
          ListBox1.Items.Add('Calling hbTapiLine1.MakeCall...');
          hbTapiLine1.MakeCall(EditDisplay.Text);
          inc(FNumMakeCall);
          if hbTapiLine1.Options.SyncMode then
            ListBox1.Items.Add('MakeCall returned.')
          else
          begin
            ListBox1.Items.Add('MakeCall returned. LastRequestID= 0x' + IntToHex(hbTapiLine1.LastRequestID, 2));
            hbTapiLine1.SetRequestNote(hbTapiLine1.LastRequestID, 'NumMakeCall', FNumMakeCall);
          end;
        except
          on E:EhbTapiError do
            MessageDlg('MakeCall failed! ' + E.Message, mtError, [mbok], 0);
        end;
      end;
    end;
  end;
end;

procedure TForm3.FormCreate(Sender: TObject);
var
  get_url: string;
  resp : String;
  query : String;
  linhas, i, lig_perdidas, x,teste : Integer;
begin
  hold := false;
  try
    query := 'Select server, ramal, TapiLineDevice, TapiMediaMode, TapiPrevileges, TapiAddress, TapiSyncMode from config';
    FDQuery2.SQL.Clear;
    FDQuery2.SQL.Add(query);
    FDQuery2.Open;

    server := FDQuery2.Fields[0].Value;
    ramal := FDQuery2.Fields[1].Value;
    Label2.Caption := ramal;
    LineDevice := FDQuery2.Fields[2].Value;
    MediaMode := FDQuery2.Fields[3].Value;
    Privileges := FDQuery2.Fields[4].Value;
    Address := FDQuery2.Fields[5].Value;
    SyncMode := FDQuery2.Fields[6].Value;



     //ShowMessage(IntToStr(hbTapiLine1.DeviceList.Count));

    //CARREGAR TAPI NA INICIALIZA��O

    {if LineDevice <> '' then
    begin
      hbTapiLine1.Options.SyncMode :=  StrToBool(SyncMode);
      hbTapiLine1.DeviceList.Text := LineDevice;
      hbTapiLine1.DeviceName := LineDevice;
      hbTapiLine1.DeviceID := 0;

      hbTapiLine1.Privileges.None := TRUE;
      if Privileges = 'Owner' then
        hbTapiLine1.Privileges.Owner := TRUE;
      if Privileges = 'Monitor' then
        hbTapiLine1.Privileges.Monitor := TRUE;

      hbTapiLine1.MediaModes := StrToLineMediaMode(MediaMode);
      hbTapiLine1.Address[Address];

      try
        hbTapiLine1.Active := True;
      except
      on E:EhbTapiError do
        case E.ErrorCode of
           LINEERR_INVALMEDIAMODE :
           begin
             try
               hbTapiLine1.Privileges.Owner := FALSE;
               hbTapiLine1.Active := True;
             except
               on E:Exception do
                 MessageDlg('Error opening line device: ' + E.Message, mtError, [mbOk],0);
             end;
             MessageDlg('This device is not 100% TAPI compliant',mtWarning, [mbOk],0);
           end;
        else  // Time for a little error checking
          MessageDlg('Error opening line device: ' + E.Message, mtError, [mbOk],0);
        end;
      end;
    end;}
    //FIM

    get_url := 'http://'+server+'/identificadoravaya/login.php?d=';
    resp := IdHTTP1.Get(get_url+ramal);
    if resp = 'v:1.0;event:Login' then
    begin
      Label4.Caption := 'Conectado';
      Label4.Left := 27;
      Label4.Font.Color := clGreen;
      Timer1.Enabled := True;
    end
    else
    begin
      Label4.Caption := 'Erro - Conex�o';
      Label4.Left := 15;
      Label4.Font.Color := clRed;
    end;
    //Timer1.Enabled := True;

    query := 'select callid, count(*) as x from events where visualizado=0 group by callid';
    FDQuery2.SQL.Clear;
    FDQuery2.SQL.Add(query);
    FDQuery2.Open;
    linhas := FDQuery2.RowsAffected;
    lig_perdidas := 0;

    for i := 1 to linhas do
    begin
      x := StrToInt(FDQuery2.Fields[1].Value);
      if  x = 2 then
      begin
        lig_perdidas := lig_perdidas + 1;
      end;
      FDQuery2.Next;
    end;

    if lig_perdidas > 0 then
    begin
      label5.Visible := true;
      label5.Caption := IntToStr(lig_perdidas);
    end
    else begin
      label5.Visible := false;
      label5.Caption := '0';
    end;

  except
    Label4.Caption := 'Erro - Conex�o';
    Label4.Left := 15;
    Label4.Font.Color := clRed;
    MessageDlg('Erro de Conex�o! Verifique as configura��es.',mtError,[mbOk],0);
  end;

  Application.ShowMainForm := false;

end;

procedure TForm3.hbTapiLine1CallEnd(Sender: ThbTapiLine; Call: ThbTapiCall);
begin
  //Memo1.Lines.Add('hbTapiLine1CallEnd');
  Timer2.Enabled := False;
            Timer3.Enabled := False;
            EditDisplay.Clear;
            EditDisplay.Enabled := True;
            Label4.Caption := 'Conectado';
            Label4.Left := 27;
            Label4.Font.Color := clGreen;
            Label4.Font.Style := [];
end;

procedure TForm3.hbTapiLine1CallState(Sender: ThbTapiLine; Call: ThbTapiCall;
  CallState: Cardinal);
begin
  //Memo1.Lines.Add('hbTapiLine1CallState');
end;

procedure TForm3.hbTapiLine1Disconnected(Sender: ThbTapiLine;
  Call: ThbTapiCall);
begin
  //Memo1.Lines.Add('hbTapiLine1Disconnected');
end;

procedure TForm3.Image10Click(Sender: TObject);
begin
  if hbTapiLine1.Calls.count > 0 then
  begin

    event_hold := true;

    if hold = false then
    begin
      ListBox1.Items.Add('Calling Call.Hold...');
      hbTapiLine1.Calls[0].Hold;
      hold := true;
    end
    else begin
      ListBox1.Items.Add('Calling Call.UnHold...');
      hbTapiLine1.Calls[0].Unhold;
      hold := false;
    end;
  end;
end;

procedure TForm3.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
   sc_DragMove = $f012;
begin
  ReleaseCapture;
  Perform(wm_SysCommand, sc_DragMove, 0);
end;

procedure TForm3.Image2Click(Sender: TObject);
begin
  If  MessageDlg('Voc� tem certeza que deseja sair do Avaya Middleware?',mtConfirmation,[mbyes,mbno],0)=mryes
  then
  begin
    Application.Terminate;
  end;
            //ramal e destino saida retornar jason com callid como string
end;

procedure TForm3.Image3Click(Sender: TObject);
begin
  //Application.Minimize;
  Form3.Hide;
end;

procedure TForm3.Image4Click(Sender: TObject);
begin

  if hbTapiLine1.Calls.count > 0 then
  begin
    ListBox1.Items.Add('Calling Call.Answer...');
    hbTapiLine1.Calls[0].Answer;
    if hbTapiLine1.Options.SyncMode then
      ListBox1.Items.Add('Call.Answer returned')
    else
      ListBox1.Items.Add('Answer returned. LastRequestID = 0x' + IntToHex(hbTapiLine1.LastRequestID, 2));
  end
  else begin
    if EditDisplay.Text = '' then
    begin
      ShowMessage('ATEN��O! Informe o n�mero para discar!');
    end
    else begin
      try
        hbTapiLine1.CallParams.MediaMode := StrToLineMediaMode(MediaMode);
        hbTapiLine1.CallParams.AddressID := form2.ComboBox_Address.ItemIndex;
        ListBox1.Items.Add('Calling hbTapiLine1.MakeCall...');
        hbTapiLine1.MakeCall(EditDisplay.Text);
        inc(FNumMakeCall);
        if hbTapiLine1.Options.SyncMode then
          ListBox1.Items.Add('MakeCall returned.')
        else
        begin
          ListBox1.Items.Add('MakeCall returned. LastRequestID= 0x' + IntToHex(hbTapiLine1.LastRequestID, 2));
          hbTapiLine1.SetRequestNote(hbTapiLine1.LastRequestID, 'NumMakeCall', FNumMakeCall);
        end;
      except
        on E:EhbTapiError do
          MessageDlg('MakeCall failed! ' + E.Message, mtError, [mbok], 0);
      end;
    end;
  end;
end;

procedure TForm3.Image5Click(Sender: TObject);
begin
 if hbTapiLine1.Calls.count > 0 then
  begin
    hold := false;

    ListBox1.Items.Add('Calling Call.Drop...');
    hbTapiLine1.Calls[0].Drop;
    if hbTapiLine1.options.SyncMode then
      ListBox1.Items.Add('Call.Drop returned')
    else
      ListBox1.Items.Add('Drop returned. LastRequestID = 0x' + IntToHex(hbTapiLine1.LastRequestID, 2));
  end;
end;

procedure TForm3.Image6Click(Sender: TObject);
begin
  Form1.ShowModal;
end;

procedure TForm3.Image7Click(Sender: TObject);
begin
  Form2.ShowModal;
end;

procedure TForm3.Image8Click(Sender: TObject);
begin
  Form4.ShowModal;
end;

procedure TForm3.Image9Click(Sender: TObject);
begin
  Form6.ShowModal;
end;

procedure TForm3.Memo1DblClick(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TForm3.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
   sc_DragMove = $f012;
begin
  ReleaseCapture;
  Perform(wm_SysCommand, sc_DragMove, 0);
end;

procedure TForm3.Sair1Click(Sender: TObject);
begin
 If  MessageDlg('Voc� tem certeza que deseja sair do Avaya Middleware?',mtConfirmation,[mbyes,mbno],0)=mryes
  then
  begin
    Application.Terminate;
  end;
end;

procedure TForm3.Timer1Timer(Sender: TObject);
var
  get_url, url, rml, link: string;
  resp, resp_url : String;
  str_v, str_event, str_callid, str_numa, str_numb, str_datetime, str_userdata : String;
  datetime, callid, event, numa, numb : String;
  query : String;
  i,linhas,lig_perdidas,x : Integer;
begin
  try
    get_url := 'http://'+server+'/identificadoravaya/id.php?d=';
    resp := IdHTTP1.Get(get_url+ramal);
    if resp <> 'v:1.0;event:Idle' then
    begin
        //v:1.0;event:Ringing;callid:45;numa:6654;numb:4654;datetime:20190124113209
        //v:1.0;event:Connected;callid:45;numa:6654;numb:4654;datetime:20190124113221
        //v:1.0;event:Closed;callid:45;numa:6654;numb:4654;datetime:20190124113234
        //v:1.0;event:Idle

        //TIPOS
        //1 - SAIDA
        //2 - ENTRADA
        //3 - N�O ATENDIDA

        str_v := SplitString(resp, ';')[0];
        str_event := SplitString(resp, ';')[1];
        str_callid := SplitString(resp, ';')[2];
        str_numa := SplitString(resp, ';')[3];
        str_numb := SplitString(resp, ';')[4];
        str_datetime := SplitString(resp, ';')[5];

        Memo1.Lines.Add(resp);

        if SplitString(str_numa, ':')[1] = ramal then //LIGA��O DE SA�DA
        begin

          if str_event = 'event:RESTMakecall' then
          begin
            str_userdata := SplitString(resp, ';')[6];

            datetime := SplitString(str_datetime, ':')[1];
            callid := SplitString(str_callid, ':')[1];
            event := SplitString(str_event, ':')[1];
            numa := SplitString(str_numa, ':')[1];
            numb := SplitString(str_numb, ':')[1];
            userdata := SplitString(str_userdata, ':')[1];

            try
              hbTapiLine1.CallParams.MediaMode := StrToLineMediaMode(MediaMode);
              hbTapiLine1.CallParams.AddressID := form2.ComboBox_Address.ItemIndex;
              ListBox1.Items.Add('Calling hbTapiLine1.MakeCall...');
              hbTapiLine1.MakeCall(numb);
              inc(FNumMakeCall);
              if hbTapiLine1.Options.SyncMode then
                ListBox1.Items.Add('MakeCall returned.')
              else
              begin
                ListBox1.Items.Add('MakeCall returned. LastRequestID= 0x' + IntToHex(hbTapiLine1.LastRequestID, 2));
                hbTapiLine1.SetRequestNote(hbTapiLine1.LastRequestID, 'NumMakeCall', FNumMakeCall);
              end;
            except
              on E:EhbTapiError do
                MessageDlg('MakeCall failed! ' + E.Message, mtError, [mbok], 0);
            end;

            {
            //TESTE
            query := 'Select ramal, link from config';
            FDQuery2.SQL.Clear;
            FDQuery2.SQL.Add(query);
            FDQuery2.Open;
            rml := FDQuery2.Fields[0].Value;
            link := FDQuery2.Fields[1].Value;

            callid := '171819';

            if link <> '' then
            begin
              url := link+'ReceberCallId.aspx?callid='+callid+'&idcrm='+userdata;
              resp_url := IdHTTP1.Get(url);
            end;
            }
          end;

          if str_event = 'event:Ringing' then
          begin
            datetime := SplitString(str_datetime, ':')[1];
            callid := SplitString(str_callid, ':')[1];
            event := SplitString(str_event, ':')[1];
            numa := SplitString(str_numa, ':')[1];
            numb := SplitString(str_numb, ':')[1];

            EditDisplay.Text := numb;
            EditDisplay.Enabled := False;
            Timer2.Enabled := True;
            //Self.WindowState := wsNormal;

            query := 'INSERT INTO events (datetime, callid, event, numa, numb, tipo) VALUES ("'+datetime+'", "'+callid+'", "'+event+'", "'+numa+'", "'+numb+'", 1)';
            FDQuery2.SQL.Clear;
            FDQuery2.SQL.Add(query);
            FDQuery2.Execute;

            query := 'Select ramal, link from config';
            FDQuery2.SQL.Clear;
            FDQuery2.SQL.Add(query);
            FDQuery2.Open;
            rml := FDQuery2.Fields[0].Value;
            link := FDQuery2.Fields[1].Value;

            if link <> '' then
            begin
              url := link+'ReceberCallId.aspx?callid='+callid+'&idcrm='+userdata;
              resp_url := IdHTTP1.Get(url);
              Memo1.Lines.Add('=> EVENTO RINGING SAIDA: '+url);
              Memo1.Lines.Add('=> RESP EVENTO RINGING SAIDA: '+resp_url);
            end;

           end;

          if str_event = 'event:Connected' then
          begin
            Memo1.Lines.Add('=> EVENTO CONNECTED SAIDA 1 ');
            if event_hold = false then
            begin
              Memo1.Lines.Add('=> EVENTO CONNECTED SAIDA 2 ');
              datetime := SplitString(str_datetime, ':')[1];
              callid := SplitString(str_callid, ':')[1];
              event := SplitString(str_event, ':')[1];
              numa := SplitString(str_numa, ':')[1];
              numb := SplitString(str_numb, ':')[1];

              EditDisplay.Text := numb;
              EditDisplay.Enabled := False;
              Timer2.Enabled := False;
              TimeOld := Now;
              Timer3.Enabled := True;

              query := 'INSERT INTO events (datetime, callid, event, numa, numb, tipo) VALUES ("'+datetime+'", "'+callid+'", "'+event+'", "'+numa+'", "'+numb+'", 1)';
              FDQuery2.SQL.Clear;
              FDQuery2.SQL.Add(query);
              FDQuery2.Execute;

              query := 'Select ramal, link from config';
              FDQuery2.SQL.Clear;
              FDQuery2.SQL.Add(query);
              FDQuery2.Open;
              rml := FDQuery2.Fields[0].Value;
              link := FDQuery2.Fields[1].Value;

              if link <> '' then
              begin
                Memo1.Lines.Add('=> EVENTO CONNECTED SAIDA 3 ');
                url := link+'ReceberEvento.aspx?ramal='+rml+'&ani='+numa+'&callid='+callid+'&evento='+event+'&data='+datetime;
                resp_url := IdHTTP1.Get(url);
                Memo1.Lines.Add('=> EVENTO CONNECTED SAIDA: '+url);
                Memo1.Lines.Add('=> RESP EVENTO CONNECTED SAIDA: '+resp_url);
              end;

            end;
          end;

          if str_event = 'event:Closed' then
          begin
            Memo1.Lines.Add('=> EVENTO CLOSED SAIDA 1');
            datetime := SplitString(str_datetime, ':')[1];
            callid := SplitString(str_callid, ':')[1];
            event := SplitString(str_event, ':')[1];
            numa := SplitString(str_numa, ':')[1];
            numb := SplitString(str_numb, ':')[1];
            event_hold := false;

            Timer2.Enabled := False;
            Timer3.Enabled := False;
            EditDisplay.Clear;
            EditDisplay.Enabled := True;
            Label4.Caption := 'Conectado';
            Label4.Left := 27;
            Label4.Font.Color := clGreen;
            Label4.Font.Style := [];

            query := 'INSERT INTO events (datetime, callid, event, numa, numb, tipo) VALUES ("'+datetime+'", "'+callid+'", "'+event+'", "'+numa+'", "'+numb+'", 1)';
            FDQuery2.SQL.Clear;
            FDQuery2.SQL.Add(query);
            FDQuery2.Execute;

            query := 'Select ramal, link from config';
            FDQuery2.SQL.Clear;
            FDQuery2.SQL.Add(query);
            FDQuery2.Open;
            rml := FDQuery2.Fields[0].Value;
            link := FDQuery2.Fields[1].Value;

            if link <> '' then
            begin
              Memo1.Lines.Add('=> EVENTO CLOSED SAIDA 2');
              url := link+'ReceberEvento.aspx?ramal='+rml+'&ani='+numa+'&callid='+callid+'&evento='+event+'&data='+datetime;
              resp_url := IdHTTP1.Get(url);
              Memo1.Lines.Add('=> EVENTO CLOSED SAIDA: '+url);
              Memo1.Lines.Add('=> RESP EVENTO CLOSED SAIDA: '+resp_url);
            end;

          end;
        end
        else begin  //LIGA��O DE ENTRADA
          if str_event = 'event:Ringing' then
          begin
            datetime := SplitString(str_datetime, ':')[1];
            callid := SplitString(str_callid, ':')[1];
            event := SplitString(str_event, ':')[1];
            numa := SplitString(str_numa, ':')[1];
            numb := SplitString(str_numb, ':')[1];

            EditDisplay.Text := numa;
            EditDisplay.Enabled := False;
            Timer2.Enabled := True;
            //Self.WindowState := wsNormal;

            query := 'INSERT INTO events (datetime, callid, event, numa, numb, tipo) VALUES ("'+datetime+'", "'+callid+'", "'+event+'", "'+numa+'", "'+numb+'", 2)';
            FDQuery2.SQL.Clear;
            FDQuery2.SQL.Add(query);
            FDQuery2.Execute;

            query := 'Select ramal, link from config';
            FDQuery2.SQL.Clear;
            FDQuery2.SQL.Add(query);
            FDQuery2.Open;
            rml := FDQuery2.Fields[0].Value;
            link := FDQuery2.Fields[1].Value;

            if link <> '' then
            begin
              url := link+'ReceberLigacao.aspx?ramal='+rml+'&ani='+numa+'&callid='+callid;
              ShellExecute(Handle, '', Pchar(url) , '', '', SW_HIDE);
              Memo1.Lines.Add('=> EVENTO RINGING ENTRADA: '+url);

            end;


          end;

          if str_event = 'event:Connected' then
          begin
            if event_hold = false then
            begin
              datetime := SplitString(str_datetime, ':')[1];
              callid := SplitString(str_callid, ':')[1];
              event := SplitString(str_event, ':')[1];
              numa := SplitString(str_numa, ':')[1];
              numb := SplitString(str_numb, ':')[1];

              EditDisplay.Text := numa;
              EditDisplay.Enabled := False;
              Timer2.Enabled := False;
              TimeOld := Now;
              Timer3.Enabled := True;

              query := 'INSERT INTO events (datetime, callid, event, numa, numb, tipo) VALUES ("'+datetime+'", "'+callid+'", "'+event+'", "'+numa+'", "'+numb+'", 2)';
              FDQuery2.SQL.Clear;
              FDQuery2.SQL.Add(query);
              FDQuery2.Execute;

              query := 'Select ramal, link from config';
              FDQuery2.SQL.Clear;
              FDQuery2.SQL.Add(query);
              FDQuery2.Open;
              rml := FDQuery2.Fields[0].Value;
              link := FDQuery2.Fields[1].Value;

              if link <> '' then
              begin
                url := link+'ReceberEvento.aspx?ramal='+rml+'&ani='+numa+'&callid='+callid+'&evento='+event+'&data='+datetime;
                //ShowMessage(url);
                resp_url := IdHTTP1.Get(url);
                Memo1.Lines.Add('=> EVENTO CONNECTED ENTRADA: '+url);
                Memo1.Lines.Add('=> RESP EVENTO CONNECTED ENTRADA: '+resp_url);
              end;

            end;
          end;

          if str_event = 'event:Closed' then
          begin
            datetime := SplitString(str_datetime, ':')[1];
            callid := SplitString(str_callid, ':')[1];
            event := SplitString(str_event, ':')[1];
            numa := SplitString(str_numa, ':')[1];
            numb := SplitString(str_numb, ':')[1];
            event_hold := false;

            Timer2.Enabled := False;
            Timer3.Enabled := False;
            EditDisplay.Clear;
            EditDisplay.Enabled := True;
            Label4.Caption := 'Conectado';
            Label4.Left := 27;
            Label4.Font.Color := clGreen;
            Label4.Font.Style := [];

            query := 'INSERT INTO events (datetime, callid, event, numa, numb, tipo) VALUES ("'+datetime+'", "'+callid+'", "'+event+'", "'+numa+'", "'+numb+'", 2)';
            FDQuery2.SQL.Clear;
            FDQuery2.SQL.Add(query);
            FDQuery2.Execute;

            query := 'Select ramal, link from config';
            FDQuery2.SQL.Clear;
            FDQuery2.SQL.Add(query);
            FDQuery2.Open;
            rml := FDQuery2.Fields[0].Value;
            link := FDQuery2.Fields[1].Value;

            if link <> '' then
            begin
              url := link+'ReceberEvento.aspx?ramal='+rml+'&ani='+numa+'&callid='+callid+'&evento='+event+'&data='+datetime;
              resp_url := IdHTTP1.Get(url);
              Memo1.Lines.Add('=> EVENTO CLOSED ENTRADA: '+url);
              Memo1.Lines.Add('=> RESP EVENTO CLOSED ENTRADA: '+resp_url);
            end;

            query := 'select callid, count(*) as x from events where visualizado=0 group by callid';
            FDQuery2.SQL.Clear;
            FDQuery2.SQL.Add(query);
            FDQuery2.Open;
            linhas := FDQuery2.RowsAffected;
            lig_perdidas := 0;

            for i := 1 to linhas do
            begin
              x := StrToInt(FDQuery2.Fields[1].Value);
              if  x = 2 then
              begin
                lig_perdidas := lig_perdidas + 1;
              end;
              FDQuery2.Next;
            end;

            if lig_perdidas > 0 then
            begin
              label5.Visible := true;
              label5.Caption := IntToStr(lig_perdidas);
            end
            else begin
              label5.Visible := false;
              label5.Caption := '0';
            end;
          end;
        end;
    end;
  except
    Label4.Caption := 'Erro - Conex�o';
    Label4.Left := 15;
    Label4.Font.Color := clRed;
    ShowMessage('Erro ao tentar se conectar, favor verificar conex�o e reiniciar a aplica��o!');
  end;
end;

procedure TForm3.Timer2Timer(Sender: TObject);
begin
  Label4.Caption := 'Tocando';
  Label4.Left := 32;
  Label4.Font.Color := clBlue;
  if Label4.Font.Style = [] then
  begin
    Label4.Font.Style := [fsBold];
  end
  else begin
    Label4.Font.Style := [];
  end;
end;

procedure TForm3.Timer3Timer(Sender: TObject);
begin
  Label4.Caption := FormatDateTime('HH:MM:SS', NOW -TimeOld);
  Label4.Left := 27;
  Label4.Font.Color := clGreen;
  Label4.Font.Style := [fsBold];
end;

procedure TForm3.Timer4Timer(Sender: TObject);
begin
    form3.FormStyle := fsNormal;
end;

procedure TForm3.TrayIcon1Click(Sender: TObject);
begin
  Form3.Show;
end;

procedure TForm3.TrayIcon1DblClick(Sender: TObject);
begin
  Form3.Hide;
end;

end.
