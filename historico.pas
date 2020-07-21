unit historico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TForm4 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    DateTimePicker1: TDateTimePicker;
    Edit1: TEdit;
    StringGrid1: TStringGrid;
    Edit2: TEdit;
    Edit3: TEdit;
    DataSource2: TDataSource;
    FDConnection1: TFDConnection;
    FDQuery2: TFDQuery;
    FDQuery1: TFDQuery;
    procedure FormShow(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    filtro_data,filtro_num: String;
    Col,Row : integer;
  end;

var
  Form4: TForm4;

implementation
uses
  toolbar;
{$R *.dfm}


procedure TForm4.DateTimePicker1Change(Sender: TObject);
var
  lastcallid,dti,dtf,nlinhas,query,query1: String;
  nlinhas2,data,hora,callid,event,numa,numb,tipo,strtipo,num : String;
  i,x: Integer;
begin
  StringGrid1.Cells[0,0] := 'DATA';
  StringGrid1.Cells[1,0] := 'HORA';
  StringGrid1.Cells[2,0] := 'NÚMERO';
  StringGrid1.Cells[3,0] := 'TIPO';

  filtro_data := FormatDateTime('yyyymmdd',DateTimePicker1.Date);
  dti := filtro_data+'000000';
  dtf := filtro_data+'235959';

  Edit1.Text := '';
  Edit2.Text := Form3.Label2.Caption;

  query := 'update events set visualizado=1';
  FDQuery2.SQL.Clear;
  FDQuery2.SQL.Add(query);
  FDQuery2.Execute;

  form3.Label5.Caption := '0';
  form3.Label5.Visible := false;

  query := 'select count(*) as x from events where 1=1 and datetime between "'+dti+'" and "'+dtf+'"';
  FDQuery2.SQL.Clear;
  FDQuery2.SQL.Add(query);
  FDQuery2.Open;

  nlinhas := FDQuery2.Fields[0].Value;
  x := 1;

  for i := 1 to StrToInt(nlinhas) do
  begin

    if i = 1 then
    begin
      try
      query := 'select datetime, callid, event, numa, numb, tipo from events where datetime between "'+dti+'" and "'+dtf+'" order by datetime desc limit '+IntToStr(i)+',1';
      FDQuery2.SQL.Clear;
      FDQuery2.SQL.Add(query);
      FDQuery2.Open;

      data := copy(FDQuery2.Fields[0].Value,7,2)+'/'+copy(FDQuery2.Fields[0].Value,5,2)+'/'+copy(FDQuery2.Fields[0].Value,1,4);
      hora := copy(FDQuery2.Fields[0].Value,9,2)+':'+copy(FDQuery2.Fields[0].Value,11,2)+':'+copy(FDQuery2.Fields[0].Value,13,2);
      callid := FDQuery2.Fields[1].Value;
      event := FDQuery2.Fields[2].Value;
      numa := FDQuery2.Fields[3].Value;
      numb := FDQuery2.Fields[4].Value;
      tipo := FDQuery2.Fields[5].Value;

      query1 := 'select count(*) as x from events where callid="'+callid+'"';
      FDQuery1.SQL.Clear;
      FDQuery1.SQL.Add(query1);
      FDQuery1.Open;
      nlinhas2 := FDQuery1.Fields[0].Value;

      if nlinhas2 <> '3' then
      begin
        tipo := '3';
      end;

      if tipo = '1' then
      begin
        strtipo := 'Saída';
        num := numb;
      end
      else if tipo = '2' then
      begin
        strtipo := 'Entrada';
        num := numa;
      end
      else begin
        strtipo := 'Não Atendida';
        if FDQuery2.Fields[5].Value = 1 then
        begin
          num := numb;
        end
        else begin
          num := numa;
        end;
      end;

      StringGrid1.Cells[0,x] := data;
      StringGrid1.Cells[1,x] := hora;
      StringGrid1.Cells[2,x] := num;
      StringGrid1.Cells[3,x] := strtipo;

      x := x+1;
      StringGrid1.RowCount := x;
      lastcallid := callid;

      except

      end;
    end
    else begin
      try
      query := 'select datetime, callid, event, numa, numb, tipo from events where datetime between "'+dti+'" and "'+dtf+'" order by datetime desc limit '+IntToStr(i)+',1';
      FDQuery2.SQL.Clear;
      FDQuery2.SQL.Add(query);
      FDQuery2.Open;

      data := copy(FDQuery2.Fields[0].Value,7,2)+'/'+copy(FDQuery2.Fields[0].Value,5,2)+'/'+copy(FDQuery2.Fields[0].Value,1,4);
      hora := copy(FDQuery2.Fields[0].Value,9,2)+':'+copy(FDQuery2.Fields[0].Value,11,2)+':'+copy(FDQuery2.Fields[0].Value,13,2);
      callid := FDQuery2.Fields[1].Value;
      event := FDQuery2.Fields[2].Value;
      numa := FDQuery2.Fields[3].Value;
      numb := FDQuery2.Fields[4].Value;
      tipo := FDQuery2.Fields[5].Value;

      if callid <> lastcallid then
      begin
        query1 := 'select count(*) as x from events where callid="'+callid+'"';
        FDQuery1.SQL.Clear;
        FDQuery1.SQL.Add(query1);
        FDQuery1.Open;
        nlinhas2 := FDQuery1.Fields[0].Value;

        if nlinhas2 <> '3' then
        begin
          tipo := '3';
        end;

        if tipo = '1' then
        begin
          strtipo := 'Saída';
          num := numb;
        end
        else if tipo = '2' then
        begin
          strtipo := 'Entrada';
          num := numa;
        end
        else begin
          strtipo := 'Não Atendida';
          if FDQuery2.Fields[5].Value = 1 then
          begin
            num := numb;
          end
          else begin
            num := numa;
          end;
        end;

        StringGrid1.Cells[0,x] := data;
        StringGrid1.Cells[1,x] := hora;
        StringGrid1.Cells[2,x] := num;
        StringGrid1.Cells[3,x] := strtipo;

        x := x+1;
        StringGrid1.RowCount := x;
        lastcallid := callid;

      end;
      except

      end;
    end;

  end;

end;

procedure TForm4.Edit1Change(Sender: TObject);
var
  lastcallid,dti,dtf,nlinhas,query,query1: String;
  nlinhas2,data,hora,callid,event,numa,numb,tipo,strtipo,num : String;
  i,x: Integer;
begin
  StringGrid1.Cells[0,0] := 'DATA';
  StringGrid1.Cells[1,0] := 'HORA';
  StringGrid1.Cells[2,0] := 'NÚMERO';
  StringGrid1.Cells[3,0] := 'TIPO';

  filtro_data := FormatDateTime('yyyymmdd',DateTimePicker1.Date);
  filtro_num := Edit1.Text;

  dti := filtro_data+'000000';
  dtf := filtro_data+'235959';

  Edit2.Text := Form3.Label2.Caption;

  query := 'update events set visualizado=1';
  FDQuery2.SQL.Clear;
  FDQuery2.SQL.Add(query);
  FDQuery2.Execute;

  form3.Label5.Caption := '0';
  form3.Label5.Visible := false;

  query := 'select count(*) as x from events where 1=1 and datetime between "'+dti+'" and "'+dtf+'" and (numa like "%'+filtro_num+'%" or numb like "%'+filtro_num+'%")';
  FDQuery2.SQL.Clear;
  FDQuery2.SQL.Add(query);
  FDQuery2.Open;

  nlinhas := FDQuery2.Fields[0].Value;
  x := 1;

  for i := 1 to StrToInt(nlinhas) do
  begin

    if i = 1 then
    begin
      try
      query := 'select datetime, callid, event, numa, numb, tipo from events where datetime between "'+dti+'" and "'+dtf+'" and (numa like "%'+filtro_num+'%" or numb like "%'+filtro_num+'%") order by datetime desc limit '+IntToStr(i)+',1';
      FDQuery2.SQL.Clear;
      FDQuery2.SQL.Add(query);
      FDQuery2.Open;

      data := copy(FDQuery2.Fields[0].Value,7,2)+'/'+copy(FDQuery2.Fields[0].Value,5,2)+'/'+copy(FDQuery2.Fields[0].Value,1,4);
      hora := copy(FDQuery2.Fields[0].Value,9,2)+':'+copy(FDQuery2.Fields[0].Value,11,2)+':'+copy(FDQuery2.Fields[0].Value,13,2);
      callid := FDQuery2.Fields[1].Value;
      event := FDQuery2.Fields[2].Value;
      numa := FDQuery2.Fields[3].Value;
      numb := FDQuery2.Fields[4].Value;
      tipo := FDQuery2.Fields[5].Value;

      query1 := 'select count(*) as x from events where callid="'+callid+'"';
      FDQuery1.SQL.Clear;
      FDQuery1.SQL.Add(query1);
      FDQuery1.Open;
      nlinhas2 := FDQuery1.Fields[0].Value;

      if nlinhas2 <> '3' then
      begin
        tipo := '3';
      end;

      if tipo = '1' then
      begin
        strtipo := 'Saída';
        num := numb;
      end
      else if tipo = '2' then
      begin
        strtipo := 'Entrada';
        num := numa;
      end
      else begin
        strtipo := 'Não Atendida';
        if FDQuery2.Fields[5].Value = 1 then
        begin
          num := numb;
        end
        else begin
          num := numa;
        end;
      end;

      StringGrid1.Cells[0,x] := data;
      StringGrid1.Cells[1,x] := hora;
      StringGrid1.Cells[2,x] := num;
      StringGrid1.Cells[3,x] := strtipo;

      x := x+1;
      StringGrid1.RowCount := x;
      lastcallid := callid;

      except

      end;
    end
    else begin
      try
      query := 'select datetime, callid, event, numa, numb, tipo from events where datetime between "'+dti+'" and "'+dtf+'" and (numa like "%'+filtro_num+'%" or numb like "%'+filtro_num+'%") order by datetime desc limit '+IntToStr(i)+',1';
      FDQuery2.SQL.Clear;
      FDQuery2.SQL.Add(query);
      FDQuery2.Open;

      data := copy(FDQuery2.Fields[0].Value,7,2)+'/'+copy(FDQuery2.Fields[0].Value,5,2)+'/'+copy(FDQuery2.Fields[0].Value,1,4);
      hora := copy(FDQuery2.Fields[0].Value,9,2)+':'+copy(FDQuery2.Fields[0].Value,11,2)+':'+copy(FDQuery2.Fields[0].Value,13,2);
      callid := FDQuery2.Fields[1].Value;
      event := FDQuery2.Fields[2].Value;
      numa := FDQuery2.Fields[3].Value;
      numb := FDQuery2.Fields[4].Value;
      tipo := FDQuery2.Fields[5].Value;

      if callid <> lastcallid then
      begin
        query1 := 'select count(*) as x from events where callid="'+callid+'"';
        FDQuery1.SQL.Clear;
        FDQuery1.SQL.Add(query1);
        FDQuery1.Open;
        nlinhas2 := FDQuery1.Fields[0].Value;

        if nlinhas2 <> '3' then
        begin
          tipo := '3';
        end;

        if tipo = '1' then
        begin
          strtipo := 'Saída';
          num := numb;
        end
        else if tipo = '2' then
        begin
          strtipo := 'Entrada';
          num := numa;
        end
        else begin
          strtipo := 'Não Atendida';
          if FDQuery2.Fields[5].Value = 1 then
          begin
            num := numb;
          end
          else begin
            num := numa;
          end;
        end;

        StringGrid1.Cells[0,x] := data;
        StringGrid1.Cells[1,x] := hora;
        StringGrid1.Cells[2,x] := num;
        StringGrid1.Cells[3,x] := strtipo;

        x := x+1;
        StringGrid1.RowCount := x;
        lastcallid := callid;

      end;
      except

      end;
    end;

  end;
end;

procedure TForm4.FormShow(Sender: TObject);
var
  lastcallid,dti,dtf,nlinhas,query,query1: String;
  nlinhas2,data,hora,callid,event,numa,numb,tipo,strtipo,num : String;
  i,x: Integer;
begin
  StringGrid1.Cells[0,0] := 'DATA';
  StringGrid1.Cells[1,0] := 'HORA';
  StringGrid1.Cells[2,0] := 'NÚMERO';
  StringGrid1.Cells[3,0] := 'TIPO';

  DateTimePicker1.Date := Now;
  filtro_data := FormatDateTime('yyyymmdd',DateTimePicker1.Date);
  dti := filtro_data+'000000';
  dtf := filtro_data+'235959';

  Edit1.Text := '';
  Edit2.Text := Form3.Label2.Caption;

  query := 'update events set visualizado=1';
  FDQuery2.SQL.Clear;
  FDQuery2.SQL.Add(query);
  FDQuery2.Execute;

  form3.Label5.Caption := '0';
  form3.Label5.Visible := false;

  query := 'select count(*) as x from events where 1=1 and datetime between "'+dti+'" and "'+dtf+'"';
  FDQuery2.SQL.Clear;
  FDQuery2.SQL.Add(query);
  FDQuery2.Open;

  nlinhas := FDQuery2.Fields[0].Value;
  x := 1;

  for i := 1 to StrToInt(nlinhas) do
  begin

    if i = 1 then
    begin
      try
      query := 'select datetime, callid, event, numa, numb, tipo from events where datetime between "'+dti+'" and "'+dtf+'" order by datetime desc limit '+IntToStr(i)+',1';
      FDQuery2.SQL.Clear;
      FDQuery2.SQL.Add(query);
      FDQuery2.Open;

      data := copy(FDQuery2.Fields[0].Value,7,2)+'/'+copy(FDQuery2.Fields[0].Value,5,2)+'/'+copy(FDQuery2.Fields[0].Value,1,4);
      hora := copy(FDQuery2.Fields[0].Value,9,2)+':'+copy(FDQuery2.Fields[0].Value,11,2)+':'+copy(FDQuery2.Fields[0].Value,13,2);
      callid := FDQuery2.Fields[1].Value;
      event := FDQuery2.Fields[2].Value;
      numa := FDQuery2.Fields[3].Value;
      numb := FDQuery2.Fields[4].Value;
      tipo := FDQuery2.Fields[5].Value;

      query1 := 'select count(*) as x from events where callid="'+callid+'"';
      FDQuery1.SQL.Clear;
      FDQuery1.SQL.Add(query1);
      FDQuery1.Open;
      nlinhas2 := FDQuery1.Fields[0].Value;

      if nlinhas2 <> '3' then
      begin
        tipo := '3';
      end;

      if tipo = '1' then
      begin
        strtipo := 'Saída';
        num := numb;
      end
      else if tipo = '2' then
      begin
        strtipo := 'Entrada';
        num := numa;
      end
      else begin
        strtipo := 'Não Atendida';
        if FDQuery2.Fields[5].Value = 1 then
        begin
          num := numb;
        end
        else begin
          num := numa;
        end;
      end;

      StringGrid1.Cells[0,x] := data;
      StringGrid1.Cells[1,x] := hora;
      StringGrid1.Cells[2,x] := num;
      StringGrid1.Cells[3,x] := strtipo;

      x := x+1;
      StringGrid1.RowCount := x;
      lastcallid := callid;

      except

      end;
    end
    else begin
      try
      query := 'select datetime, callid, event, numa, numb, tipo from events where datetime between "'+dti+'" and "'+dtf+'" order by datetime desc limit '+IntToStr(i)+',1';
      FDQuery2.SQL.Clear;
      FDQuery2.SQL.Add(query);
      FDQuery2.Open;

      data := copy(FDQuery2.Fields[0].Value,7,2)+'/'+copy(FDQuery2.Fields[0].Value,5,2)+'/'+copy(FDQuery2.Fields[0].Value,1,4);
      hora := copy(FDQuery2.Fields[0].Value,9,2)+':'+copy(FDQuery2.Fields[0].Value,11,2)+':'+copy(FDQuery2.Fields[0].Value,13,2);
      callid := FDQuery2.Fields[1].Value;
      event := FDQuery2.Fields[2].Value;
      numa := FDQuery2.Fields[3].Value;
      numb := FDQuery2.Fields[4].Value;
      tipo := FDQuery2.Fields[5].Value;

      if callid <> lastcallid then
      begin
        query1 := 'select count(*) as x from events where callid="'+callid+'"';
        FDQuery1.SQL.Clear;
        FDQuery1.SQL.Add(query1);
        FDQuery1.Open;
        nlinhas2 := FDQuery1.Fields[0].Value;

        if nlinhas2 <> '3' then
        begin
          tipo := '3';
        end;

        if tipo = '1' then
        begin
          strtipo := 'Saída';
          num := numb;
        end
        else if tipo = '2' then
        begin
          strtipo := 'Entrada';
          num := numa;
        end
        else begin
          strtipo := 'Não Atendida';
          if FDQuery2.Fields[5].Value = 1 then
          begin
            num := numb;
          end
          else begin
            num := numa;
          end;
        end;

        StringGrid1.Cells[0,x] := data;
        StringGrid1.Cells[1,x] := hora;
        StringGrid1.Cells[2,x] := num;
        StringGrid1.Cells[3,x] := strtipo;

        x := x+1;
        StringGrid1.RowCount := x;
        lastcallid := callid;

      end;
      except

      end;
    end;

  end;

end;

procedure TForm4.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  if Arow = 0 then
  begin
    StringGrid1.Canvas.Brush.color := clBtnFace;
    StringGrid1.Canvas.Font.Color := clBlack;
  end
  else begin

    if gdSelected in State then
      StringGrid1.Canvas.Brush.Color := clGradientInactiveCaption
    else
      StringGrid1.Canvas.Brush.Color := clWindow;

    if StringGrid1.Cells[3,ARow] = 'Não Atendida'  then
    begin
      StringGrid1.Canvas.Font.Color := clRed;
      StringGrid1.Canvas.Font.Style:=[fsbold];
    end
    else begin
      StringGrid1.Canvas.Font.Color := clblack;
      StringGrid1.Canvas.Font.Style:=[];
    end;
    StringGrid1.canvas.fillRect(Rect);
    StringGrid1.canvas.TextOut(Rect.Left,Rect.Top,StringGrid1.Cells[ACol,ARow]);
  end;
end;

end.
