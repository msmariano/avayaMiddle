object Form5: TForm5
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Testes TAPI'
  ClientHeight = 328
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 13
    Width = 41
    Height = 13
    Caption = 'N'#250'mero:'
  end
  object Label2: TLabel
    Left = 8
    Top = 61
    Width = 26
    Height = 13
    Caption = 'Logs:'
  end
  object Disca: TButton
    Left = 322
    Top = 30
    Width = 75
    Height = 25
    Caption = 'Discar'
    TabOrder = 0
    OnClick = DiscaClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 80
    Width = 289
    Height = 233
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 8
    Top = 32
    Width = 289
    Height = 21
    TabOrder = 2
  end
  object Button2: TButton
    Left = 322
    Top = 78
    Width = 75
    Height = 25
    Caption = 'Desligar'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button1: TButton
    Left = 322
    Top = 126
    Width = 75
    Height = 25
    Caption = 'Atender'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 322
    Top = 174
    Width = 75
    Height = 25
    Caption = 'Transferir'
    TabOrder = 5
    OnClick = Button2Click
  end
end
