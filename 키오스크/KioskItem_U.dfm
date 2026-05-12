object KioskItem_F: TKioskItem_F
  Left = 445
  Top = 234
  Hint = 'Logo'
  BorderStyle = bsNone
  Caption = 'KioskItem_F'
  ClientHeight = 930
  ClientWidth = 1000
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #47569#51008' '#44256#46357
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    1000
    930)
  PixelsPerInch = 96
  TextHeight = 20
  object MenuGroupBox: TcxGroupBox
    Left = 53
    Top = 218
    Alignment = alCenterCenter
    Anchors = [akTop, akBottom]
    PanelStyle.Active = True
    PanelStyle.BorderWidth = 2
    PanelStyle.CaptionIndent = 3
    ParentFont = False
    Style.BorderStyle = ebsNone
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWhite
    Style.Font.Height = -15
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.TextColor = clWhite
    Style.IsFontAssigned = True
    TabOrder = 0
    Transparent = True
    Height = 530
    Width = 897
  end
  object OrderButton: TAdvSmoothButton
    Left = 535
    Top = 789
    Width = 350
    Height = 100
    HelpType = htKeyword
    HelpKeyword = 'C'
    InitPause = 0
    Anchors = [akLeft, akBottom]
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
    Caption = #49440#53469#50756#47308
    Color = 13789440
    ParentFont = False
    Picture.Data = {
      89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
      F4000000097048597300000B1300000B1301009A9C18000000A549444154789C
      EDD5310AC2401085E15888E0013C8778092D3C8A47B1D29CC34AB0F73C5A8BD5
      276210092226261BC5F9CB85D9F7989D379B654110FC0BE861816157E26B3776
      5D88AF0AF133E621FEBD6DC7084BF41B1AB81366558AF745E1A68E898FC4AF60
      8C4371C116832CF5B4AB61A2F1A8A960A2B59C7BC344EB4BC60B13C9369C2726
      92AF574C707C88685E3B6A0D7522FDC75232915EBCF41CD3FB411004BFCE059E
      D2B85DEF48C51F0000000049454E44AE426082}
    DisabledColor = clWhite
    TabOrder = 1
    ShowFocus = False
    Version = '2.2.2.0'
    OnClick = OrderButtonClick
    TMSStyle = 8
  end
  object CancelButton: TAdvSmoothToggleButton
    Left = 139
    Top = 789
    Width = 350
    Height = 100
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clGray
    BorderInnerColor = clGray
    BevelWidth = 0
    BevelColorDisabled = clWhite
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
    Caption = #52376#51020#51004#47196
    Version = '1.7.2.2'
    Status.Visible = True
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
    TabOrder = 2
    OnClick = CancelButtonClick
    TMSStyle = 0
  end
  object HeaderPanel: TAdvPanel
    Left = 5
    Top = 5
    Width = 989
    Height = 198
    Color = 10354589
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    UseDockManager = True
    Version = '2.5.11.0'
    BorderColor = clBlack
    Caption.Color = clHighlight
    Caption.ColorTo = clNone
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clWindowText
    Caption.Font.Height = -11
    Caption.Font.Name = 'Tahoma'
    Caption.Font.Style = []
    Caption.Indent = 0
    CollapsSteps = 10
    ColorTo = 14811105
    ColorMirror = 14811105
    ColorMirrorTo = 10354589
    DoubleBuffered = True
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clWindowText
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    Text = ''
    FullHeight = 200
    object lblOrderAmt: TcxLabel
      Left = 718
      Top = 125
      AutoSize = False
      Caption = '30,000 '#50896
      ParentColor = False
      ParentFont = False
      Style.Color = 13789440
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = 15246443
      Style.Font.Height = -47
      Style.Font.Name = #47569#51008' '#44256#46357
      Style.Font.Style = [fsBold]
      Style.LookAndFeel.Kind = lfOffice11
      Style.LookAndFeel.NativeStyle = True
      Style.Shadow = True
      Style.TextColor = clWhite
      Style.TextStyle = [fsBold]
      Style.IsFontAssigned = True
      StyleDisabled.LookAndFeel.Kind = lfOffice11
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.Kind = lfOffice11
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.Kind = lfOffice11
      StyleHot.LookAndFeel.NativeStyle = True
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 57
      Width = 261
      AnchorX = 979
      AnchorY = 154
    end
    object lblQty: TcxLabel
      Tag = 1
      Left = 612
      Top = 132
      AutoSize = False
      Caption = '1'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -31
      Style.Font.Name = #47569#51008' '#44256#46357
      Style.Font.Style = [fsBold]
      Style.LookAndFeel.Kind = lfOffice11
      Style.LookAndFeel.NativeStyle = True
      Style.Shadow = True
      Style.TextColor = clWhite
      Style.IsFontAssigned = True
      StyleDisabled.LookAndFeel.Kind = lfOffice11
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.Kind = lfOffice11
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.Kind = lfOffice11
      StyleHot.LookAndFeel.NativeStyle = True
      Properties.Alignment.Horz = taCenter
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 46
      Width = 45
      AnchorX = 635
      AnchorY = 155
    end
    object lblMenuName: TcxLabel
      Left = 25
      Top = 14
      AutoSize = False
      Caption = #50500#47700#47532#52852#45432
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWhite
      Style.Font.Height = -47
      Style.Font.Name = #47569#51008' '#44256#46357
      Style.Font.Style = [fsBold]
      Style.HotTrack = False
      Style.TextColor = clWhite
      Style.TextStyle = []
      Style.IsFontAssigned = True
      StyleDisabled.Color = clBlack
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Properties.LabelStyle = cxlsLowered
      Transparent = True
      Height = 58
      Width = 975
      AnchorY = 43
    end
    object btnAdd: TAdvSmoothToggleButton
      Left = 658
      Top = 130
      Width = 50
      Height = 50
      Color = 13789440
      ColorDisabled = 14277081
      ColorDown = clWhite
      BorderColor = clNone
      BorderInnerColor = clNone
      BevelWidth = 0
      AutoToggle = False
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -36
      Appearance.Font.Name = #47569#51008' '#44256#46357
      Appearance.Font.Style = [fsBold]
      Appearance.Spacing = 1
      Appearance.ShiftDown = -3
      Appearance.SimpleLayout = True
      Appearance.Rounding = 0
      VerticalSpacing = 0
      HorizontalSpacing = 0
      Caption = '+'
      Version = '1.7.2.2'
      Status.Caption = '0'
      Status.Appearance.Fill.Color = clRed
      Status.Appearance.Fill.ColorMirror = clNone
      Status.Appearance.Fill.ColorMirrorTo = clNone
      Status.Appearance.Fill.GradientType = gtSolid
      Status.Appearance.Fill.GradientMirrorType = gtSolid
      Status.Appearance.Fill.BorderColor = clGray
      Status.Appearance.Fill.Rounding = 0
      Status.Appearance.Fill.ShadowOffset = 0
      Status.Appearance.Fill.Glow = gmNone
      Status.Appearance.Font.Charset = DEFAULT_CHARSET
      Status.Appearance.Font.Color = clWhite
      Status.Appearance.Font.Height = -11
      Status.Appearance.Font.Name = 'Tahoma'
      Status.Appearance.Font.Style = []
      ShowFocus = False
      ParentFont = False
      TabOrder = 3
      OnClick = btnAddClick
      TMSStyle = 0
    end
    object btnDec: TAdvSmoothToggleButton
      Left = 560
      Top = 130
      Width = 50
      Height = 50
      Color = 13789440
      ColorDisabled = 14277081
      ColorDown = clWhite
      BorderColor = clNone
      BorderInnerColor = clNone
      BevelWidth = 0
      AutoToggle = False
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -36
      Appearance.Font.Name = #47569#51008' '#44256#46357
      Appearance.Font.Style = [fsBold]
      Appearance.Spacing = 1
      Appearance.ShiftDown = -3
      Appearance.SimpleLayout = True
      Appearance.Rounding = 0
      VerticalSpacing = 0
      HorizontalSpacing = 0
      Caption = '-'
      Version = '1.7.2.2'
      Status.Caption = '0'
      Status.Appearance.Fill.Color = clRed
      Status.Appearance.Fill.ColorMirror = clNone
      Status.Appearance.Fill.ColorMirrorTo = clNone
      Status.Appearance.Fill.GradientType = gtSolid
      Status.Appearance.Fill.GradientMirrorType = gtSolid
      Status.Appearance.Fill.BorderColor = clGray
      Status.Appearance.Fill.Rounding = 0
      Status.Appearance.Fill.ShadowOffset = 0
      Status.Appearance.Fill.Glow = gmNone
      Status.Appearance.Font.Charset = DEFAULT_CHARSET
      Status.Appearance.Font.Color = clWhite
      Status.Appearance.Font.Height = -11
      Status.Appearance.Font.Name = 'Tahoma'
      Status.Appearance.Font.Style = []
      ShowFocus = False
      ParentFont = False
      TabOrder = 4
      OnClick = btnDecClick
      TMSStyle = 0
    end
    object MenuInfoLabel: TcxLabel
      Left = 34
      Top = 98
      AutoSize = False
      Caption = '222'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWhite
      Style.Font.Height = -24
      Style.Font.Name = #47569#51008' '#44256#46357
      Style.Font.Style = [fsBold]
      Style.HotTrack = False
      Style.TextColor = clWhite
      Style.TextStyle = []
      Style.IsFontAssigned = True
      StyleDisabled.Color = clBlack
      Properties.Alignment.Horz = taLeftJustify
      Properties.WordWrap = True
      Transparent = True
      Height = 93
      Width = 514
    end
  end
  object CloseTimer: TTimer
    OnTimer = CloseTimerTimer
    Left = 424
    Top = 167
  end
end
