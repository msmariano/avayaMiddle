object Form6: TForm6
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Transferir'
  ClientHeight = 134
  ClientWidth = 212
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 193
    Height = 81
    Caption = 'Transferir para:'
    TabOrder = 0
    object Edit1: TEdit
      Left = 24
      Top = 32
      Width = 145
      Height = 21
      TabOrder = 0
    end
  end
  object Button1: TButton
    Left = 68
    Top = 98
    Width = 75
    Height = 25
    Caption = 'Transferir'
    TabOrder = 1
    OnClick = Button1Click
  end
end
