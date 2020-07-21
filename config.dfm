object Form2: TForm2
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Configura'#231#245'es'
  ClientHeight = 230
  ClientWidth = 569
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 6
    Width = 233
    Height = 142
    Caption = 'Configura'#231#245'es CTI'
    TabOrder = 0
    object Label2: TLabel
      Left = 9
      Top = 19
      Width = 44
      Height = 13
      Caption = 'Servidor:'
    end
    object Label3: TLabel
      Left = 9
      Top = 59
      Width = 33
      Height = 13
      Caption = 'Ramal:'
    end
    object Label7: TLabel
      Left = 9
      Top = 98
      Width = 79
      Height = 13
      Caption = 'URL Integra'#231#227'o:'
    end
    object Edit1: TEdit
      Left = 9
      Top = 34
      Width = 216
      Height = 21
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 9
      Top = 74
      Width = 216
      Height = 21
      TabOrder = 1
    end
    object Edit3: TEdit
      Left = 9
      Top = 113
      Width = 216
      Height = 21
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 152
    Width = 233
    Height = 36
    Caption = 'Vers'#227'o'
    TabOrder = 1
    object Label1: TLabel
      Left = 2
      Top = 15
      Width = 229
      Height = 19
      Align = alClient
      Alignment = taCenter
      Caption = '1.0.4 - AGIS'
      ExplicitWidth = 60
      ExplicitHeight = 13
    end
  end
  object Button1: TButton
    Left = 87
    Top = 197
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = Button1Click
  end
  object GroupBox3: TGroupBox
    Left = 247
    Top = 6
    Width = 314
    Height = 216
    Caption = 'Configura'#231#245'es TAPI'
    TabOrder = 3
    object LabelDevice: TLabel
      Left = 10
      Top = 23
      Width = 58
      Height = 13
      Caption = 'Line Device:'
    end
    object Label4: TLabel
      Left = 10
      Top = 67
      Width = 61
      Height = 13
      Caption = 'Media Mode:'
    end
    object Label5: TLabel
      Left = 10
      Top = 113
      Width = 49
      Height = 13
      Caption = 'Privileges:'
    end
    object Label6: TLabel
      Left = 10
      Top = 159
      Width = 43
      Height = 13
      Caption = 'Address:'
    end
    object ComboBox_Device: TComboBox
      Left = 10
      Top = 41
      Width = 290
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = ComboBox_DeviceChange
    end
    object ComboBox_MediaMode: TComboBox
      Left = 10
      Top = 86
      Width = 183
      Height = 21
      Style = csDropDownList
      TabOrder = 1
    end
    object ComboBox_Privileges: TComboBox
      Left = 10
      Top = 132
      Width = 183
      Height = 21
      Style = csDropDownList
      TabOrder = 2
      OnChange = ComboBox_PrivilegesChange
      Items.Strings = (
        'Owner+Monitor'
        'Monitor'
        'None')
    end
    object ComboBox_Address: TComboBox
      Left = 10
      Top = 178
      Width = 183
      Height = 21
      Style = csDropDownList
      TabOrder = 3
    end
    object CheckBox_SyncMode: TCheckBox
      Left = 225
      Top = 112
      Width = 86
      Height = 17
      Caption = 'SyncMode'
      Checked = True
      State = cbChecked
      TabOrder = 4
      OnClick = CheckBox_SyncModeClick
    end
    object CheckBox_BlockID: TCheckBox
      Left = 224
      Top = 158
      Width = 73
      Height = 17
      Caption = 'BlockID'
      TabOrder = 5
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=dbtoolbar.db'
      'DriverID=SQLite')
    Left = 448
    Top = 4
  end
  object FDQuery2: TFDQuery
    Connection = Form3.FDConnection1
    Left = 376
    Top = 5
  end
  object DataSource2: TDataSource
    DataSet = FDQuery2
    Left = 520
    Top = 5
  end
end
