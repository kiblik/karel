object FCommands: TFCommands
  Left = 238
  Top = 184
  Width = 614
  Height = 352
  Caption = 'Príkazy'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 28
    Top = 8
    Width = 81
    Height = 13
    Caption = 'Zoznam príkazov'
  end
  object ListBox1: TListBox
    Left = 24
    Top = 28
    Width = 121
    Height = 213
    ItemHeight = 13
    TabOrder = 0
  end
  object MyEditor1: TMyEditor
    Left = 152
    Top = 28
    Width = 413
    Height = 217
    Lines.Strings = (
      'MyEditor1')
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
  end
end