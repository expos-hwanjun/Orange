object LetsOrderService_F: TLetsOrderService_F
  Left = 695
  Top = 482
  AlphaBlend = True
  BorderStyle = bsNone
  Caption = #47131#52768#50724#45908
  ClientHeight = 473
  ClientWidth = 590
  Color = clWhite
  DefaultMonitor = dmMainForm
  Font.Charset = HANGEUL_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = #44404#47548#52404
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  Visible = True
  OnShow = FormShow
  DesignSize = (
    590
    473)
  PixelsPerInch = 96
  TextHeight = 11
  object Shape1: TShape
    Left = 0
    Top = 0
    Width = 590
    Height = 473
    Align = alClient
    ExplicitTop = 120
    ExplicitHeight = 353
  end
  object TitelShape: TAdvShape
    Left = 0
    Top = 0
    Width = 590
    Height = 53
    Appearance.Brush.Style = bsClear
    Appearance.Color = 9652480
    Appearance.ColorTo = 4727808
    Appearance.Direction = gdVertical
    Appearance.URLColor = clBlue
    BackGround.Position = bpTopLeft
    ShapeHeight = 53
    ShapeWidth = 590
    Text = ''
    TextOffsetX = 0
    TextOffsetY = 0
    Version = '1.2.0.2'
  end
  object LogoImage: TImage
    Left = 5
    Top = 5
    Width = 117
    Height = 45
  end
  object TitleLabel: TLabel
    Left = 128
    Top = 6
    Width = 129
    Height = 42
    AutoSize = False
    Caption = #47131#52768#50724#45908
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWhite
    Font.Height = -31
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object ReceiptNoLabel: TLabel
    Left = 280
    Top = 5
    Width = 302
    Height = 42
    Alignment = taCenter
    AutoSize = False
    Caption = '[ 20230803-02-03 ]'
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWhite
    Font.Height = -27
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object ServiceMessageLabel: TcxLabel
    Left = 490
    Top = 59
    Anchors = [akLeft, akRight]
    AutoSize = False
    Caption = #48520#54032' '#44368#54872#54644#51452#49464#50836
    ParentFont = False
    Style.Font.Charset = HANGEUL_CHARSET
    Style.Font.Color = 11862016
    Style.Font.Height = -40
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.TextColor = 3223857
    Style.TextStyle = []
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taCenter
    Properties.Alignment.Vert = taVCenter
    Height = 209
    Width = 551
    AnchorX = 766
    AnchorY = 164
  end
  object TableNoLabel: TcxLabel
    Left = 21
    Top = 59
    Anchors = [akLeft, akRight]
    AutoSize = False
    Caption = #53580#51060#48660#48264#54840' -'
    ParentFont = False
    Style.Font.Charset = HANGEUL_CHARSET
    Style.Font.Color = 11862016
    Style.Font.Height = -40
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.TextColor = 204
    Style.TextStyle = [fsBold]
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taCenter
    Properties.Alignment.Vert = taVCenter
    Height = 59
    Width = 547
    AnchorX = 295
    AnchorY = 89
  end
  object MenuNameLabel: TcxLabel
    Left = 21
    Top = 144
    Anchors = [akLeft, akRight]
    AutoSize = False
    Caption = #49340#44217#49332
    ParentFont = False
    Style.Font.Charset = HANGEUL_CHARSET
    Style.Font.Color = 11862016
    Style.Font.Height = -40
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.TextColor = clBlack
    Style.TextStyle = []
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taLeftJustify
    Properties.Alignment.Vert = taVCenter
    Height = 221
    Width = 446
    AnchorY = 255
  end
  object MenuQtyLabel: TcxLabel
    Left = 473
    Top = 144
    Anchors = [akLeft, akRight]
    AutoSize = False
    Caption = '1'
    ParentFont = False
    Style.Font.Charset = HANGEUL_CHARSET
    Style.Font.Color = 11862016
    Style.Font.Height = -40
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.TextColor = 3223857
    Style.TextStyle = []
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taRightJustify
    Properties.Alignment.Vert = taVCenter
    Height = 221
    Width = 86
    AnchorX = 559
    AnchorY = 255
  end
  object YesButton: TAdvSmoothButton
    Left = 224
    Top = 371
    Width = 185
    Height = 68
    Cursor = crHandPoint
    Appearance.PictureAlignment = taCenter
    Appearance.PictureStretchMode = pmStretch
    Appearance.Font.Charset = HANGEUL_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -24
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = [fsBold]
    Appearance.ShiftDown = 0
    Appearance.FocusColor = clWhite
    Appearance.SimpleLayout = True
    Appearance.Rounding = 5
    Status.Visible = True
    Status.Caption = '10'
    Status.Appearance.Fill.Color = clRed
    Status.Appearance.Fill.ColorMirror = clNone
    Status.Appearance.Fill.ColorMirrorTo = clNone
    Status.Appearance.Fill.GradientType = gtSolid
    Status.Appearance.Fill.GradientMirrorType = gtSolid
    Status.Appearance.Fill.BorderColor = clGray
    Status.Appearance.Fill.Rounding = 16
    Status.Appearance.Fill.ShadowOffset = 0
    Status.Appearance.Fill.Glow = gmNone
    Status.Appearance.Font.Charset = DEFAULT_CHARSET
    Status.Appearance.Font.Color = clWhite
    Status.Appearance.Font.Height = -20
    Status.Appearance.Font.Name = #47569#51008' '#44256#46357
    Status.Appearance.Font.Style = [fsBold]
    Caption = #54869' '#51064
    Color = 8404992
    ParentFont = False
    Picture.Data = {
      89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
      F4000000097048597300000B1300000B1301009A9C180000021649444154789C
      ED974D4B5B411486A3C582D48F62215A772EAA71D36A1B14A1FF40B0FA3B74E1
      A2ADBAD47E2CDC0A8A44EBDABFA0A92DF62F48A3B8D1D2A50AB68D14177964E0
      8D0EF99899DC1854F0C0707367CEFB9E9973CE9C7B128BDDCB5D12A0179806D2
      C02EF04F635773EF81442D0C0F005B84CB26F0EA3A0C3F0496819C888F801430
      02F4008F34CCEF5160153891AEC1CC030FA21A7F026C8B2C0BCC02CD01B8C7C0
      67E0BFB0EB514FBE2D8243A02F02C710B00FBCD67B07301E0A5EB68C3FADF804
      573CF596F18C38277CA041C52F1BE5E425F86CE3E6D9E1037C97F2EC4D18EFB5
      B2BDB916C6813A176846805495C6DB811D719922D5A9F96160D2054C0B345283
      933F07CE4D917281F704EC2EB33EEE8AA32BE64097E67FB936F0474A45F137D7
      C7954CBE84031AF3452D64034D25D6E2565CF7F27175C5BC00DFA2F5D390103C
      2BB35EB48910E3C226F2DE0949C2370E9D425707DD73604C7A1BAE0D4C4969A5
      AC52B1279C27B7306BD27DEB524A5885A8C543683CF153C359E18056E0D875C3
      2E05F826C5B99847E4897880DE4771A643BB9F9C3E46FD5E809FEF257026CEB0
      2E0958CA170D5F6C3D3C9DE230B25009B0C1EA017F03C908C65F0007E2F8619A
      9C4A09DAAC4FB309C7075F625A05E793DC8E72AAADD203D89E58B49AD263359E
      A3BA314D1A09CD7D29684A170C47AC5A0192C057C2257D2D6D79A1A8FD367F3E
      3654F9FE6A6434F7CE7BCFEFE5B6C905DFF24BE6057984AF0000000049454E44
      AE426082}
    Shadow = True
    DisabledColor = clWhite
    TabOrder = 4
    ShowFocus = False
    HorizontalSpacing = 0
    VerticalSpacing = 0
    Version = '2.1.1.5'
    OnClick = YesButtonClick
    TMSStyle = 0
  end
  object CallListButton: TAdvSmoothButton
    Left = 493
    Top = 371
    Width = 74
    Height = 68
    Cursor = crHandPoint
    Appearance.PictureAlignment = taCenter
    Appearance.PictureStretchMode = pmStretch
    Appearance.Font.Charset = HANGEUL_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -24
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = [fsBold]
    Appearance.ShiftDown = 0
    Appearance.FocusColor = clWhite
    Appearance.SimpleLayout = True
    Appearance.Rounding = 30
    Status.Caption = '10'
    Status.Appearance.Fill.Color = clRed
    Status.Appearance.Fill.ColorMirror = clNone
    Status.Appearance.Fill.ColorMirrorTo = clNone
    Status.Appearance.Fill.GradientType = gtSolid
    Status.Appearance.Fill.GradientMirrorType = gtSolid
    Status.Appearance.Fill.BorderColor = clGray
    Status.Appearance.Fill.Rounding = 16
    Status.Appearance.Fill.ShadowOffset = 0
    Status.Appearance.Fill.Glow = gmNone
    Status.Appearance.Font.Charset = DEFAULT_CHARSET
    Status.Appearance.Font.Color = clWhite
    Status.Appearance.Font.Height = -20
    Status.Appearance.Font.Name = #47569#51008' '#44256#46357
    Status.Appearance.Font.Style = [fsBold]
    Color = 8404992
    ParentFont = False
    Picture.Data = {
      89504E470D0A1A0A0000000D49484452000000320000003208060000001E3F88
      B1000000097048597300000B1300000B1301009A9C180000010B49444154789C
      EDD8314A04411005D05A3410153116C403085E42F008C62206DE400C3D80B918
      7806C113181B9A88A99986061A084F963518D76177035DAAA55E36CC74C3EFA2
      E13311A5945F850156A37538C52376A255D8C58791371C466BB08517DF3D633D
      5A8125DC8D85184E662F32C30AD63ACF577E3AE9593737314388055CE31E9B38
      EED967F87E903DC865E7FB27BC8FEDF1D09D56CA20389AB2FE15DB13D6A709B2
      8C9B09EBF7A3154677E4A227C479B408679D10B7588C56E1E0EBC26F44EBFC87
      82D8A7DA6F26AAFD26A1DAEFDF89194EBFDAAF398A29D3A8F69B8E6ABF89A9F6
      DB00F5EF3711D57E9350EDF7EFC40CA75FEDD71CC5946954FB4D47B5DFC454FB
      2DA544329F0F9DD6ACC0A196700000000049454E44AE426082}
    Shadow = True
    DisabledColor = clWhite
    TabOrder = 5
    ShowFocus = False
    HorizontalSpacing = 0
    VerticalSpacing = 0
    Version = '2.1.1.5'
    OnClick = CallListButtonClick
    TMSStyle = 0
  end
  object CloseTimer: TTimer
    OnTimer = CloseTimerTimer
    Left = 72
    Top = 80
  end
  object ElapsedTimer: TTimer
    Enabled = False
    OnTimer = ElapsedTimerTimer
    Left = 144
    Top = 168
  end
end
