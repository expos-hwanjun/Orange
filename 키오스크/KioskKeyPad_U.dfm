object KioskKeyPad_F: TKioskKeyPad_F
  Left = 525
  Top = 201
  BorderStyle = bsNone
  Caption = 'KioskKeyPad_F'
  ClientHeight = 917
  ClientWidth = 563
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Shape1: TShape
    Left = 68
    Top = 244
    Width = 412
    Height = 1
  end
  object KeyInLabel: TcxLabel
    Left = 68
    Top = 168
    AutoSize = False
    ParentColor = False
    ParentFont = False
    Style.BorderStyle = ebsNone
    Style.Color = clNone
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -60
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.TextColor = clBlack
    Style.TextStyle = []
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taCenter
    Properties.Alignment.Vert = taVCenter
    Transparent = True
    Height = 78
    Width = 357
    AnchorX = 247
    AnchorY = 207
  end
  object MessageLabel: TcxLabel
    Left = 2
    Top = 11
    AutoSize = False
    Caption = #44288#47532#51088' '#50516#54840#47484' '#51077#47141#54616#49464#50836
    ParentColor = False
    ParentFont = False
    Style.Color = 14935011
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -33
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.TextColor = clBlack
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taCenter
    Properties.Alignment.Vert = taVCenter
    Properties.WordWrap = True
    Transparent = True
    Height = 118
    Width = 553
    AnchorX = 279
    AnchorY = 70
  end
  object OKButton: TAdvSmoothButton
    Left = 287
    Top = 768
    Width = 204
    Height = 100
    InitPause = 0
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
    Appearance.Rounding = 35
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
    Caption = #54869#51064
    Color = 13789440
    ParentFont = False
    DisabledColor = clWhite
    TabOrder = 2
    TabStop = False
    ShowFocus = False
    Version = '2.2.2.0'
    OnClick = OKButtonClick
    TMSStyle = 8
  end
  object Num9Button: TAdvSmoothToggleButton
    Left = 356
    Top = 503
    Width = 129
    Height = 105
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColor = 13395456
    BevelColorDisabled = clWhite
    AutoToggle = False
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -60
    Appearance.Font.Name = #46027#50880
    Appearance.Font.Style = [fsBold]
    Appearance.Spacing = 1
    Appearance.ShiftDown = 0
    Appearance.SimpleLayout = True
    Appearance.Rounding = 50
    VerticalSpacing = 0
    HorizontalSpacing = 0
    Caption = '9'
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
    TabStop = False
    OnClick = Num1ButtonClick
    TMSStyle = 0
  end
  object Num6Button: TAdvSmoothToggleButton
    Left = 356
    Top = 390
    Width = 129
    Height = 105
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColor = 13395456
    BevelColorDisabled = clWhite
    AutoToggle = False
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -60
    Appearance.Font.Name = #46027#50880
    Appearance.Font.Style = [fsBold]
    Appearance.Spacing = 1
    Appearance.ShiftDown = 0
    Appearance.SimpleLayout = True
    Appearance.Rounding = 50
    VerticalSpacing = 0
    HorizontalSpacing = 0
    Caption = '6'
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
    TabStop = False
    OnClick = Num1ButtonClick
    TMSStyle = 0
  end
  object Num3Button: TAdvSmoothToggleButton
    Left = 356
    Top = 277
    Width = 129
    Height = 105
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColor = 13395456
    BevelColorDisabled = clWhite
    AutoToggle = False
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -60
    Appearance.Font.Name = #46027#50880
    Appearance.Font.Style = [fsBold]
    Appearance.Spacing = 1
    Appearance.ShiftDown = 0
    Appearance.SimpleLayout = True
    Appearance.Rounding = 50
    VerticalSpacing = 0
    HorizontalSpacing = 0
    Caption = '3'
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
    TabOrder = 5
    TabStop = False
    OnClick = Num1ButtonClick
    TMSStyle = 0
  end
  object ClearButton: TAdvSmoothToggleButton
    Left = 356
    Top = 616
    Width = 129
    Height = 105
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColorDisabled = clWhite
    AutoToggle = False
    Picture.Data = {
      89504E470D0A1A0A0000000D49484452000000320000003208060000001E3F88
      B1000000097048597300000B1300000B1301009A9C180000039D49444154789C
      ED9A494F145110C77F468431189141406F723418F54BA8A0A8C8CDEDA6D18B4B
      D0ABCB193D9998F03934482051832B02EE8902CAC9E5A2F1E6085133A6E2BF93
      0ACED2DDD3B348F8279D0CBCAAEA7AAFEAD5ABAAD7B08CA58B34D00B5C018680
      69E01BB0A0C77EBFD598D1EC079AA911A480A3C028F01BC8467C7E0123C011A0
      A11A13580D9C033E3BA5E6813BC0055966B3567C959E66FDCFC62E0277C513F0
      7F02FAB53815C11E60CE2930091C039A62C85A071C07A69CBCF740376584ADD4
      A07BE153606782F2BB80E74EFEF57258678314B7177C074E012B937E097F659E
      0132CEDAED4909EF90B9B38A3A5B283FB602337AE73BE950125A9DC009603D95
      4333F040EF9E9357C442CAB9D323A091CAA31118776E166BCF0C3A77B2C3AE5A
      68715E61012072880D367625F644983D93914E16DD421F76C13961D1A95670D6
      6DFE502E76DE9D13E508B1715107BC906E36A9826850AA60C43BA83DEC966E9F
      8B59E5888B1061714F29465B0CC5DA64F9FB21E957B8487AA810E1A8882C770A
      8B09F1BC8E389936F118EF93087C27C4339C8F20ADB47A3E6202E8150A3B9938
      3CFEA0B4FAE6673E3D0F48F06DE26500AFDCB9B331026D9C137B4CFC7B730D5E
      D5A0D513711066954BB184C765C91820078634B88FF8286499242CB1D87B6E90
      03B31AB42AAE14E45AF5A42C11A053B2AC2FF00FBE6AD0729B52B158F1242781
      B27093F7851C58D0603DC9C0BB5212EEB4F8E00EFA04559948A16816050527B2
      645C6B76A96CF6210D5A07302E0A85D828876631F4150ABFC18168CDB3FFFA40
      ECD5A0750BA322CA61978465C6C4DF932F190B9246EB00D66AD2987649E3DA7C
      4423126E6DCCB0984C208DB752202C4E8AE75621A2C322B242292C1E9758584D
      4946185861F54C3A1E2C76D07C14E12E6A0F3DD2ED43986B887E113FABC1E6C3
      4BE9763A0C43CAF57AADA15C2BE8974E33512E85BAC5945173ACDAD80EFC904E
      91AF32AEBB154822FF8A8B5635E54C976B7104A45C681DAF52137B8D3A2C41A7
      A5A194D59876B1DEFEAE14D2C043771D57F2854F8733ADB9D9362AB327DEE99D
      96956F4A4A70BB73B38C7AAF160E93469DA2D30FE74E49D42FFFEC99200064D5
      504EEAF67585AE325E3AF9D7CA7DF7DEE5CC1E74ED4FC4FC8A21ADDC29483BB2
      72A5246F8B8B5AE7AC4B67B2CA482DBDBEA4BE53A7C276BD9E165D1AF58966CC
      F50982B4E374B5BE806850577C58254036E2F35395E9C16A4D20179AD48BB5AA
      EDA68AA6AFEEA31AFBFD46E5E98068F3D613CBE03FC71FB7D36E8754A9C5ED00
      00000049454E44AE426082}
    Appearance.PictureAlignment = taCenter
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -47
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
    Appearance.Spacing = 1
    Appearance.ShiftDown = 0
    Appearance.SimpleLayout = True
    Appearance.Rounding = 50
    VerticalSpacing = 0
    HorizontalSpacing = 0
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
    TabOrder = 6
    TabStop = False
    OnClick = ClearButtonClick
    TMSStyle = 0
  end
  object AdvSmoothToggleButton4: TAdvSmoothToggleButton
    Left = 211
    Top = 616
    Width = 129
    Height = 105
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColorDisabled = clWhite
    AutoToggle = False
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -60
    Appearance.Font.Name = #46027#50880
    Appearance.Font.Style = [fsBold]
    Appearance.Spacing = 1
    Appearance.ShiftDown = 0
    Appearance.SimpleLayout = True
    Appearance.Rounding = 50
    VerticalSpacing = 0
    HorizontalSpacing = 0
    Caption = '0'
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
    TabOrder = 7
    TabStop = False
    OnClick = Num1ButtonClick
    TMSStyle = 0
  end
  object Num2Button: TAdvSmoothToggleButton
    Left = 211
    Top = 277
    Width = 129
    Height = 105
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColor = 13395456
    BevelColorDisabled = clWhite
    AutoToggle = False
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -60
    Appearance.Font.Name = #46027#50880
    Appearance.Font.Style = [fsBold]
    Appearance.Spacing = 1
    Appearance.ShiftDown = 0
    Appearance.SimpleLayout = True
    Appearance.Rounding = 50
    VerticalSpacing = 0
    HorizontalSpacing = 0
    Caption = '2'
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
    TabOrder = 8
    TabStop = False
    OnClick = Num1ButtonClick
    TMSStyle = 0
  end
  object Num5Button: TAdvSmoothToggleButton
    Left = 211
    Top = 390
    Width = 129
    Height = 105
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColor = 13395456
    BevelColorDisabled = clWhite
    AutoToggle = False
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -60
    Appearance.Font.Name = #46027#50880
    Appearance.Font.Style = [fsBold]
    Appearance.Spacing = 1
    Appearance.ShiftDown = 0
    Appearance.SimpleLayout = True
    Appearance.Rounding = 50
    VerticalSpacing = 0
    HorizontalSpacing = 0
    Caption = '5'
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
    TabOrder = 9
    TabStop = False
    OnClick = Num1ButtonClick
    TMSStyle = 0
  end
  object Num8Button: TAdvSmoothToggleButton
    Left = 211
    Top = 503
    Width = 129
    Height = 105
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColor = 13395456
    BevelColorDisabled = clWhite
    AutoToggle = False
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -60
    Appearance.Font.Name = #46027#50880
    Appearance.Font.Style = [fsBold]
    Appearance.Spacing = 1
    Appearance.ShiftDown = 0
    Appearance.SimpleLayout = True
    Appearance.Rounding = 50
    VerticalSpacing = 0
    HorizontalSpacing = 0
    Caption = '8'
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
    TabOrder = 10
    TabStop = False
    OnClick = Num1ButtonClick
    TMSStyle = 0
  end
  object BSButton: TAdvSmoothToggleButton
    Left = 67
    Top = 614
    Width = 129
    Height = 105
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColorDisabled = clWhite
    AutoToggle = False
    Picture.Data = {
      89504E470D0A1A0A0000000D49484452000000320000003208060000001E3F88
      B1000000097048597300000B1300000B1301009A9C180000017E49444154789C
      ED98414AC4301486BFC5E84E5C594646A90B3D81289EC3951E41D7EA5D142F20
      E24E17B3F20CDA018FA01B4145DD69A4F016B1763A69C97492FA3E0894E1A5E4
      9B367FD280A2288AA228FF974520034C00ED0DB80236EA4AF480610002A6D09E
      81411D9153E9F808A4CC9E01702D63BA70ED742C1D3E802DC26155C6F5E252BC
      0B7C01DFC01EE161A455B209BC4BE11161622689A4321FF2A273C2C554892C00
      7752700BCC13A148CF8AD94CD68E261C0089435D22B54D192BE223660FAD3FA2
      4A26B116D8BC8F379113F9F113D8A1394BC0BDDCEB015876A8E9FB12F11DB355
      32BE24FE88D8319B2F7EBE2893F129F14BC48ED97C7EF8C69E0759E1DA250C9C
      4546723194C462CA323E25C68ACC11B1486ABD5A6744FC6AB539D9FB8ED11C74
      FCDAE9E453C6B4B9209645AC2F1933698BF214F316A5B8691CC5BC69ECCC36BE
      531F56D38EE5D6458AB1BC4FC422F671501ECBDB447A1C5416CB6BCC9E15E046
      C674D99523D3F5980FB15FE549D496501445511485C0F90111244B310575A1FC
      0000000049454E44AE426082}
    Appearance.PictureAlignment = taCenter
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -47
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
    Appearance.Spacing = 1
    Appearance.ShiftDown = 0
    Appearance.SimpleLayout = True
    Appearance.Rounding = 50
    VerticalSpacing = 0
    HorizontalSpacing = 0
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
    TabOrder = 11
    TabStop = False
    OnClick = BSButtonClick
    TMSStyle = 0
  end
  object Num1Button: TAdvSmoothToggleButton
    Left = 67
    Top = 279
    Width = 129
    Height = 105
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColor = 13395456
    BevelColorDisabled = clWhite
    AutoToggle = False
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -60
    Appearance.Font.Name = #46027#50880
    Appearance.Font.Style = [fsBold]
    Appearance.Spacing = 1
    Appearance.ShiftDown = 0
    Appearance.SimpleLayout = True
    Appearance.Rounding = 50
    VerticalSpacing = 0
    HorizontalSpacing = 0
    Caption = '1'
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
    TabOrder = 12
    TabStop = False
    OnClick = Num1ButtonClick
    TMSStyle = 0
  end
  object Num4Button: TAdvSmoothToggleButton
    Left = 67
    Top = 390
    Width = 129
    Height = 105
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColor = 13395456
    BevelColorDisabled = clWhite
    AutoToggle = False
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -60
    Appearance.Font.Name = #46027#50880
    Appearance.Font.Style = [fsBold]
    Appearance.Spacing = 1
    Appearance.ShiftDown = 0
    Appearance.SimpleLayout = True
    Appearance.Rounding = 50
    VerticalSpacing = 0
    HorizontalSpacing = 0
    Caption = '4'
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
    TabOrder = 13
    TabStop = False
    OnClick = Num1ButtonClick
    TMSStyle = 0
  end
  object Num7Button: TAdvSmoothToggleButton
    Left = 67
    Top = 503
    Width = 129
    Height = 105
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColor = 13395456
    BevelColorDisabled = clWhite
    AutoToggle = False
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -60
    Appearance.Font.Name = #46027#50880
    Appearance.Font.Style = [fsBold]
    Appearance.Spacing = 1
    Appearance.ShiftDown = 0
    Appearance.SimpleLayout = True
    Appearance.Rounding = 50
    VerticalSpacing = 0
    HorizontalSpacing = 0
    Caption = '7'
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
    TabOrder = 14
    TabStop = False
    OnClick = Num1ButtonClick
    TMSStyle = 0
  end
  object CancelButton: TAdvSmoothToggleButton
    Left = 61
    Top = 768
    Width = 204
    Height = 100
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = 10658466
    BorderInnerColor = 10658466
    BevelWidth = 0
    BevelColor = 4473924
    BevelColorDisabled = clWhite
    BevelColorDown = 10658466
    AutoToggle = False
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -40
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
    Appearance.Spacing = 1
    Appearance.ShiftDown = 0
    Appearance.SimpleLayout = True
    Appearance.Rounding = 35
    VerticalSpacing = 0
    HorizontalSpacing = 0
    Caption = #51060#51204
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
    TabOrder = 15
    TabStop = False
    OnClick = CancelButtonClick
    TMSStyle = 0
  end
  object AdvSmoothButton1: TAdvSmoothButton
    Left = 432
    Top = 187
    Width = 51
    Height = 49
    InitPause = 0
    Appearance.GlowPercentage = 0
    Appearance.PictureAlignment = taCenter
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -33
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
    Appearance.Spacing = 1
    Appearance.ShiftDown = 0
    Appearance.SimpleLayout = True
    Appearance.Rounding = 25
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
    Color = clWhite
    ParentFont = False
    Picture.Data = {
      89504E470D0A1A0A0000000D494844520000001E0000001E08060000003B30AE
      A2000000097048597300000B1300000B1301009A9C18000001FD49444154789C
      D597C94A03411086BF83D178530FF1E8F61AEE7A713DEA25FA0EEA5368625EC1
      051750BCB823820BF11D5CD037500FE6A03729F82383F4743A6644FCA161A8EE
      9E9AAAFEEBAF1EF807680426803CB0095C69D8730E1807D2493AEC04D68112F0
      0CEC00CBC09C863DEF022F5AB30A74D4E2B00128001FC03E3000D479D6DBDC20
      70A83D79BDA32AB40237C02DD0F3838FEE03EE812290A9C6E913700A34F17334
      0367C06388F306457A5A21ADA1A893F32250EF5B58507A6B89D415F99D98EF84
      31F15D244A1ABD225C976BD24AE62066A39D517780836ECF791E016B2E712879
      A2EDD117673D4EB35A13570543C0DB7791999438F80835A517CF3AE6A63537E3
      D99F92C88C458D39A94F25641D91BB6C71D80396A2866D1FEB3C9187441AC5B2
      B4FD0B17C03CE12847191A69190BF2F5F78EB724EA2188A6D747B83881DAF82B
      722D460DD6C45F45F938F8881412794A3E46A2C6B48ADBFA695C9B0B15109347
      17865D0282E4CC9AB80B1939AF843E8F641E032BAE89763589B8A86B41BFB261
      D72827F26A61D6CA92420BF0F09D54AE8B4051CD3B898B8011EA1CB8AE741140
      67F428E7CD35467A1E7AF52923A3C8EF743ED56250E9BDAEC66934ED3911EE48
      FDD457E72995CC89F62C86A4D7870E955A49FD744FD257BED017647B559D5AC9
      B49120D26AE2D64F4D6F2F35ECD96CA349FFC2FC0A3E013BBF834CFFDEB37E00
      00000049454E44AE426082}
    DisabledColor = clWhite
    TabOrder = 16
    ShowFocus = False
    Version = '2.2.2.0'
    OnClick = ClearButtonClick
    TMSStyle = 8
  end
  object CloseTimer: TTimer
    OnTimer = CloseTimerTimer
    Top = 187
  end
end
