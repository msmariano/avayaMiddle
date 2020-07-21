object Form4: TForm4
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Lista de Chamadas'
  ClientHeight = 475
  ClientWidth = 460
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 460
    Height = 105
    Align = alTop
    Caption = 'Filtros'
    TabOrder = 0
    object Label1: TLabel
      Left = 55
      Top = 28
      Width = 27
      Height = 13
      Caption = 'Data:'
    end
    object Label2: TLabel
      Left = 41
      Top = 67
      Width = 41
      Height = 13
      Caption = 'N'#250'mero:'
    end
    object DateTimePicker1: TDateTimePicker
      Left = 88
      Top = 25
      Width = 312
      Height = 21
      Date = 43493.404120405090000000
      Time = 43493.404120405090000000
      TabOrder = 0
      OnChange = DateTimePicker1Change
    end
    object Edit1: TEdit
      Left = 88
      Top = 64
      Width = 312
      Height = 21
      TabOrder = 1
      OnChange = Edit1Change
    end
    object Edit2: TEdit
      Left = 3
      Top = 51
      Width = 38
      Height = 21
      TabOrder = 2
      Text = 'ramal'
      Visible = False
    end
    object Edit3: TEdit
      Left = 3
      Top = 78
      Width = 38
      Height = 21
      TabOrder = 3
      Text = 'num'
      Visible = False
    end
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 105
    Width = 460
    Height = 370
    Align = alClient
    ColCount = 4
    FixedCols = 0
    RowCount = 2
    GradientStartColor = clGradientInactiveCaption
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    TabOrder = 1
    OnDrawCell = StringGrid1DrawCell
    ColWidths = (
      73
      70
      148
      138)
    RowHeights = (
      24
      24)
  end
  object DataSource2: TDataSource
    DataSet = FDQuery2
    Left = 192
    Top = 312
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=dbtoolbar.db'
      'DriverID=SQLite')
    Left = 232
    Top = 312
  end
  object FDQuery2: TFDQuery
    Connection = FDConnection1
    Left = 272
    Top = 312
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 320
    Top = 312
  end
end
