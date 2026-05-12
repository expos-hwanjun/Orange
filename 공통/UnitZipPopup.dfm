object FrmZipPopup: TFrmZipPopup
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #50864#54200#48264#54840' '#51312#54924
  ClientHeight = 515
  ClientWidth = 589
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #47569#51008' '#44256#46357
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    589
    515)
  PixelsPerInch = 96
  TextHeight = 20
  object lvResult: TListView
    Left = 8
    Top = 57
    Width = 571
    Height = 400
    Anchors = [akLeft, akRight, akBottom]
    Columns = <>
    TabOrder = 1
    OnDblClick = lvResultDblClick
  end
  object edtKeyword: TcxTextEdit
    Left = 11
    Top = 13
    Anchors = [akLeft, akTop, akRight]
    ParentFont = False
    Properties.ImeMode = imSHanguel
    Properties.MaxLength = 150
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -15
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 0
    OnKeyDown = edtKeywordKeyDown
    Width = 466
  end
  object SearchButton: TAdvSmoothToggleButton
    Left = 486
    Top = 8
    Width = 90
    Height = 36
    Hint = 'N'
    RepeatInterval = 0
    FontColorDisabled = clWhite
    Color = 7945472
    ColorDisabled = 8404992
    ColorDown = 8404992
    BorderColor = clWhite
    BorderInnerColor = 6160384
    BevelWidth = 0
    BevelColorDisabled = 8404992
    BevelColorDown = 14925219
    DropDownArrowColor = clWhite
    AutoToggle = False
    Picture.Data = {
      89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
      F800000006624B474400FF00FF00FFA0BDA793000001AA494441544889D5D43B
      6B56411485E1359A1B11042F894562A155100B0B110B318D76F903820829AC45
      824510E1437F8DE0255A5829E94CA5A2221A0289A8C14282188DA8888F852304
      C9E5C47C200E1C1866AFBDDEBDE7B027F9DF57594F80A1240349BE26992EA5BC
      DB3415DD18C32B7CC433CCE21B2631BC19F37E4CE11146D0899E1AEBC3383EA0
      F5B7954FE12AB6E102E6FC5AC3CB7407F116E7360A18AB95F7E2165EE2140657
      D01EC3D24AB1D5CC4BBDF3119CAFE63BD6C999C095A680217C4217A671BA41CE
      194CADA5D9B26C3F98E475921F49F625996C50D76C92BD4D015F92F49452BE27
      D95F4A996F00E8A9798D00D34906D15F4A79D3C03C490E2779DE509BD4211AAF
      FB27E85D43DB811718DD0860B80ED181B5CCABF61266D0D91850135B98C7D155
      E25B71118B38B49E5FC79F07A59416DE27B9873B496E24994BD295E44892D124
      9D498E2769E16E92C524D74A299F37D2C9002EE37EED6806B731FAFB5AEAE42F
      D5FFF5103B1B031A1671168FEBD3325121BBDA09D88EA7B85E1FC7093C40773B
      217DB58B9B15B280936D0354C8EE5AF942FDF6B4155021DD3881FEB69BFFD3F5
      136D59B8C02977F9D30000000049454E44AE426082}
    Appearance.GlowPercentage = 20
    Appearance.PictureAlignment = taCenter
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -17
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
    Appearance.FocusColor = clWhite
    Appearance.SimpleLayout = False
    Appearance.ImageIndex = 0
    Appearance.Rounding = 5
    Caption = #51312#54924
    Version = '1.7.2.2'
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
    ParentFont = False
    TabOrder = 2
    OnClick = SearchButtonClick
    TMSStyle = 0
  end
  object OKButton: TAdvSmoothToggleButton
    Left = 162
    Top = 466
    Width = 121
    Height = 40
    Hint = 'N'
    RepeatInterval = 0
    FontColorDisabled = clWhite
    Color = 7945472
    ColorDisabled = 8404992
    ColorDown = 8404992
    BorderColor = clWhite
    BorderInnerColor = 6160384
    BevelWidth = 0
    BevelColorDisabled = 8404992
    BevelColorDown = 14925219
    DropDownArrowColor = clWhite
    AutoToggle = False
    Appearance.GlowPercentage = 20
    Appearance.PictureAlignment = taCenter
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -17
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
    Appearance.FocusColor = clWhite
    Appearance.SimpleLayout = False
    Appearance.ImageIndex = 0
    Appearance.Rounding = 5
    Caption = #54869#51064
    Version = '1.7.2.2'
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
    ParentFont = False
    TabOrder = 3
    OnClick = OKButtonClick
    TMSStyle = 0
  end
  object CloseButton: TAdvSmoothToggleButton
    Left = 336
    Top = 466
    Width = 121
    Height = 40
    Hint = 'N'
    RepeatInterval = 0
    FontColorDisabled = clWhite
    Color = 7945472
    ColorDisabled = 8404992
    ColorDown = 8404992
    BorderColor = clWhite
    BorderInnerColor = 6160384
    BevelWidth = 0
    BevelColorDisabled = 8404992
    BevelColorDown = 14925219
    DropDownArrowColor = clWhite
    AutoToggle = False
    Appearance.GlowPercentage = 20
    Appearance.PictureAlignment = taCenter
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -17
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
    Appearance.FocusColor = clWhite
    Appearance.SimpleLayout = False
    Appearance.ImageIndex = 0
    Appearance.Rounding = 5
    Caption = #45803#44592
    Version = '1.7.2.2'
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
    ParentFont = False
    TabOrder = 4
    OnClick = CloseButtonClick
    TMSStyle = 0
  end
end
