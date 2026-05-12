object KioskEasyPay_F: TKioskEasyPay_F
  Left = 553
  Top = 358
  BorderStyle = bsNone
  Caption = 'KioskEasyPay_F'
  ClientHeight = 655
  ClientWidth = 793
  Color = clWhite
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClick = MainImageClick
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    793
    655)
  PixelsPerInch = 96
  TextHeight = 13
  object Shape1: TShape
    Left = 0
    Top = 1
    Width = 1
    Height = 653
    Align = alLeft
    Brush.Style = bsClear
    ExplicitHeight = 438
  end
  object Shape2: TShape
    Left = 0
    Top = 0
    Width = 793
    Height = 1
    Align = alTop
    Brush.Style = bsClear
    ExplicitWidth = 468
  end
  object Shape3: TShape
    Left = 792
    Top = 1
    Width = 1
    Height = 653
    Align = alRight
    Brush.Style = bsClear
    ExplicitLeft = 467
    ExplicitHeight = 438
  end
  object Shape4: TShape
    Left = 0
    Top = 654
    Width = 793
    Height = 1
    Align = alBottom
    Brush.Style = bsClear
    ExplicitTop = 439
    ExplicitWidth = 468
  end
  object MessageLabel: TcxLabel
    Left = 56
    Top = 127
    AutoSize = False
    Caption = 'QR '#46608#45716' '#48148#53076#46300#47484' '#51069#54784#51452#49464#50836
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = 4737096
    Style.Font.Height = -47
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taCenter
    Properties.Alignment.Vert = taVCenter
    Properties.WordWrap = True
    Transparent = True
    OnClick = MainImageClick
    Height = 241
    Width = 681
    AnchorX = 397
    AnchorY = 248
  end
  object CancelButton: TAdvSmoothToggleButton
    Left = 222
    Top = 478
    Width = 350
    Height = 113
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clGray
    BorderInnerColor = clGray
    BevelWidth = 0
    BevelColorDisabled = clWhite
    BevelColorDown = 14925219
    AutoToggle = False
    Picture.Data = {
      89504E470D0A1A0A0000000D49484452000000280000002808060000008CFEB8
      6D000000097048597300000B1300000B1301009A9C18000001B849444154789C
      ED99BD4A244114854B03591F42C4D011A6CE57D360474EE4660B8288C622EB23
      6862A0A1B9188A66CEBA8966ABEFA0E01BA8A138C6E2A25C686110FF7ABAC669
      B40F5C3A68B8FDD5BDB7AB8BD3CE3D93F77E02D805AE80FFC043CE684B3A9134
      E79C1B7031256949D21D700AAC00F3F6A03C1142F82DE9C01667D75AAD361405
      CE7BFF33ABD87A8C950353926E256D470104CE813F519265B20E6495ACB92202
      C66D7E1A8DC6A48BAB01491792D60A65017E1960B3D9FCE1224BD2A1A4BDA249
      E60C301A558724ED032D574415205505BB97AA19EC510593241901464BBBCD00
      9B92AE25F95202A6693A0C1C033740523AC05C90BD04F4DECF58BC76DF20B3F3
      E3B5F75E9F0EF8117554B2FD6225FB0DF82E643780D636A01533241D1987B5BB
      5EAF8F7D6DC0D84ADF7AA3FB0D98BEB7DD7CEB6D461FDCA843088DD27EEAC25B
      70FD02A4EC8785A4ECC7AD5CAA00A92AD8BDF42D6690DE9A474785CDA327FB2D
      8490BA32DA6F4F06A6A4BF2EA28085CCB51D2F9C4CD274966CC3393718215FD3
      2C6060CBC512B09899E8679256AD02794D7460D93A912DB615CD44EF80B479DC
      012E25DD77F11BC20E9DFF80D918BF211E0107857E7DB0836D25000000004945
      4E44AE426082}
    Appearance.PictureAlignment = taCenter
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -40
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
    Appearance.Spacing = 1
    Appearance.ShiftDown = 0
    Appearance.SimpleLayout = True
    Appearance.Rounding = 30
    VerticalSpacing = 0
    HorizontalSpacing = 0
    Caption = #45208#44032#44592
    Version = '1.7.2.2'
    Status.Visible = True
    Status.Caption = '0'
    Status.Appearance.Fill.Color = clWhite
    Status.Appearance.Fill.ColorMirror = clNone
    Status.Appearance.Fill.ColorMirrorTo = clNone
    Status.Appearance.Fill.GradientType = gtSolid
    Status.Appearance.Fill.GradientMirrorType = gtSolid
    Status.Appearance.Fill.BorderColor = clGray
    Status.Appearance.Fill.Rounding = 12
    Status.Appearance.Fill.ShadowOffset = 0
    Status.Appearance.Fill.Glow = gmNone
    Status.Appearance.Font.Charset = DEFAULT_CHARSET
    Status.Appearance.Font.Color = clBlack
    Status.Appearance.Font.Height = -16
    Status.Appearance.Font.Name = 'Tahoma'
    Status.Appearance.Font.Style = []
    ShowFocus = False
    ParentFont = False
    Anchors = [akLeft, akBottom]
    TabOrder = 1
    TabStop = False
    OnClick = CancelButtonClick
    TMSStyle = 0
  end
  object CloseTimer: TTimer
    OnTimer = CloseTimerTimer
    Left = 31
    Top = 156
  end
end
