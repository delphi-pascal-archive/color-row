object Form1: TForm1
  Left = 229
  Top = 132
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Color Row'
  ClientHeight = 119
  ClientWidth = 266
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 120
  TextHeight = 16
  object ColorRow1: TColorRow
    Left = 8
    Top = 8
    Width = 265
    Height = 25
    CrossStyle = csInvert
    NoBorder = False
    ItemIndex = 1
    Color1 = clWhite
    Color2 = clSkyBlue
    Color3 = clAqua
    Color4 = clMoneyGreen
    Color5 = clLime
    Color6 = clYellow
    Color7 = clRed
    Color8 = clBlue
    Color9 = clFuchsia
    Color10 = clBlack
    onClick = ColorRow1Click
  end
  object ColorRow2: TColorRow
    Left = 8
    Top = 40
    Width = 185
    Height = 17
    CrossStyle = csBlackWhite
    NoBorder = False
    ItemIndex = 6
    Color1 = clBlack
    Color2 = clGreen
    Color3 = clOlive
    Color4 = clTeal
    Color5 = clRed
    Color6 = clSilver
    Color7 = clBlue
    Color8 = clAppWorkSpace
    Color9 = clSkyBlue
    Color10 = clMaroon
    onClick = ColorRow2Click
  end
end
