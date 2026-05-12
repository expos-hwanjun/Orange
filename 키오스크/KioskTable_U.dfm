object KioskTable_F: TKioskTable_F
  Left = 348
  Top = 234
  BorderStyle = bsNone
  Caption = 'KioskTable_F'
  ClientHeight = 651
  ClientWidth = 965
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #47569#51008' '#44256#46357
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    965
    651)
  PixelsPerInch = 96
  TextHeight = 20
  object CloseButton: TAdvSmoothButton
    Left = 895
    Top = 4
    Width = 64
    Height = 62
    HelpType = htKeyword
    HelpKeyword = 'C'
    InitPause = 0
    Anchors = [akTop, akRight]
    Appearance.GlowPercentage = 0
    Appearance.PictureAlignment = taCenter
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -40
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
    Appearance.Spacing = 1
    Appearance.ShiftDown = 0
    Appearance.SimpleLayout = True
    Appearance.Rounding = 30
    Status.Caption = '0'
    Status.Appearance.Fill.Color = clRed
    Status.Appearance.Fill.ColorMirror = clNone
    Status.Appearance.Fill.ColorMirrorTo = clNone
    Status.Appearance.Fill.GradientType = gtSolid
    Status.Appearance.Fill.GradientMirrorType = gtSolid
    Status.Appearance.Fill.BorderColor = clGray
    Status.Appearance.Fill.Rounding = 8
    Status.Appearance.Fill.ShadowOffset = 0
    Status.Appearance.Fill.Glow = gmNone
    Status.Appearance.Font.Charset = DEFAULT_CHARSET
    Status.Appearance.Font.Color = clWhite
    Status.Appearance.Font.Height = -11
    Status.Appearance.Font.Name = 'Tahoma'
    Status.Appearance.Font.Style = []
    Bevel = False
    BevelColor = 13395456
    Color = 13789440
    ParentFont = False
    Picture.Data = {
      89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
      F4000000097048597300000B1300000B1301009A9C180000008D49444154789C
      ED94C10D80200C455942A3EEE07C5E9D8C2534EA36CF6030F1A2099580C4BE1B
      073E0F5A6A8CA2DC40644CB102E6252A80960086E44D08F480056ABF1E530B58
      BF7D3E25520B54C0E42336A04B2AE07037F72F2093E041006804C370092A075F
      16C85E82C0265C8156127250EA37ECB30EA22BEE70510EF1046439A8C0574A10
      8BF20494DFB003F6181FD7FEBD1A540000000049454E44AE426082}
    DisabledColor = clWhite
    TabOrder = 0
    ShowFocus = False
    Version = '2.2.2.0'
    OnClick = CloseButtonClick
    TMSStyle = 8
  end
  object CloseTimer: TTimer
    Interval = 15000
    OnTimer = CloseTimerTimer
    Left = 136
    Top = 24
  end
end
