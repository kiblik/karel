object DZoom: TDZoom
  Left = 243
  Top = 228
  BorderStyle = bsToolWindow
  Caption = 'Klikni na sipky na krajoch posuvnika'
  ClientHeight = 59
  ClientWidth = 222
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SBSize: TScrollBar
    Left = 8
    Top = 24
    Width = 200
    Height = 17
    Max = 10
    Min = 1
    PageSize = 0
    Position = 1
    TabOrder = 0
  end
end
