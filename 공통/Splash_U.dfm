object Splash_F: TSplash_F
  Left = 556
  Top = 329
  AlphaBlend = True
  BorderStyle = bsNone
  Caption = 'Splash_F'
  ClientHeight = 171
  ClientWidth = 219
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = HANGEUL_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = #44404#47548#52404
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 11
  object MessageLabel: TLabel
    Left = 22
    Top = 108
    Width = 170
    Height = 23
    Alignment = taCenter
    AutoSize = False
    Caption = #51104#49884#47564' '#44592#45796#47532#49464#50836' . . .'
    Font.Charset = HANGEUL_CHARSET
    Font.Color = 3750201
    Font.Height = -17
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object ActivityIndicator: TActivityIndicator
    Left = 80
    Top = 37
    Animate = True
    IndicatorSize = aisLarge
    IndicatorType = aitSectorRing
  end
end
