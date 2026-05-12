object QuesMsg_F: TQuesMsg_F
  Left = 835
  Top = 262
  BorderStyle = bsNone
  Caption = 'QuesMsg_F'
  ClientHeight = 295
  ClientWidth = 553
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = #44404#47548#52404
  Font.Style = [fsBold]
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 21
  object OutLineShape: TShape
    Left = 0
    Top = 0
    Width = 553
    Height = 295
    Align = alClient
    Brush.Color = 16579836
    ExplicitTop = -1
    ExplicitWidth = 552
    ExplicitHeight = 283
  end
  object MessageLabel: TcxLabel
    Left = 8
    Top = 15
    AutoSize = False
    Caption = #51333#47308#54616#49884#44192#49845#45768#44620'?'
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = 4737096
    Style.Font.Height = -28
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taCenter
    Properties.Alignment.Vert = taVCenter
    Properties.WordWrap = True
    Transparent = True
    Height = 163
    Width = 539
    AnchorX = 278
    AnchorY = 97
  end
  object YesButton: TAdvSmoothButton
    Left = 124
    Top = 199
    Width = 162
    Height = 67
    Cursor = crHandPoint
    Appearance.PictureAlignment = taCenter
    Appearance.PictureStretchMode = pmStretch
    Appearance.Font.Charset = HANGEUL_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -23
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = [fsBold]
    Appearance.ShiftDown = 0
    Appearance.FocusColor = clWhite
    Appearance.SimpleLayout = True
    Appearance.Rounding = 5
    Status.Caption = '0'
    Status.Appearance.Fill.Color = clWhite
    Status.Appearance.Fill.ColorMirror = clNone
    Status.Appearance.Fill.ColorMirrorTo = clNone
    Status.Appearance.Fill.GradientType = gtSolid
    Status.Appearance.Fill.GradientMirrorType = gtSolid
    Status.Appearance.Fill.BorderColor = clGray
    Status.Appearance.Fill.Rounding = 11
    Status.Appearance.Fill.ShadowOffset = 0
    Status.Appearance.Fill.Glow = gmNone
    Status.Appearance.Font.Charset = DEFAULT_CHARSET
    Status.Appearance.Font.Color = clBlack
    Status.Appearance.Font.Height = -13
    Status.Appearance.Font.Name = #47569#51008' '#44256#46357
    Status.Appearance.Font.Style = []
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
    TabOrder = 1
    TabStop = False
    ShowFocus = False
    HorizontalSpacing = 0
    VerticalSpacing = 0
    Version = '2.1.1.5'
    OnClick = YesButtonClick
    TMSStyle = 0
  end
  object NoButton: TAdvSmoothButton
    Left = 304
    Top = 199
    Width = 162
    Height = 67
    Cursor = crHandPoint
    Appearance.PictureAlignment = taCenter
    Appearance.PictureStretchMode = pmStretch
    Appearance.Font.Charset = HANGEUL_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -23
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = [fsBold]
    Appearance.ShiftDown = 0
    Appearance.FocusColor = clWhite
    Appearance.SimpleLayout = True
    Appearance.Rounding = 5
    Status.Caption = '0'
    Status.Appearance.Fill.Color = clWhite
    Status.Appearance.Fill.ColorMirror = clNone
    Status.Appearance.Fill.ColorMirrorTo = clNone
    Status.Appearance.Fill.GradientType = gtSolid
    Status.Appearance.Fill.GradientMirrorType = gtSolid
    Status.Appearance.Fill.BorderColor = clGray
    Status.Appearance.Fill.Rounding = 11
    Status.Appearance.Fill.ShadowOffset = 0
    Status.Appearance.Fill.Glow = gmNone
    Status.Appearance.Font.Charset = DEFAULT_CHARSET
    Status.Appearance.Font.Color = clBlack
    Status.Appearance.Font.Height = -13
    Status.Appearance.Font.Name = #47569#51008' '#44256#46357
    Status.Appearance.Font.Style = []
    Caption = #52712' '#49548
    Color = 5921370
    ParentFont = False
    Picture.Data = {
      89504E470D0A1A0A0000000D49484452000000230000002308060000001ED9B3
      59000000097048597300000B1300000B1301009A9C180000020D49444154789C
      ED97CF2E245114C62BCCC22CB0678384C5ACB0F56F65C51EB321C3CE788B66C5
      CC4E8817C073984E9008AF604826CC92CC58FDB8F1DDE42855DDB76E577722E9
      6F53A9AAF39DFBE5D4F95749D2461B2D00D009CC001BC026B0AFABBB9F76EF5B
      2162083800FE521BF7B21B6C8688CFC04FE0C91CF81F38010E813D5D7FE9B987
      B3FFE1F86509E907CECD0117C002D09D63DF032CCACEE3CCF92943C86F397C00
      96818E406E07B0221EF2D3DFC8A73997A31B6034D2CFA8F83E42C53F19AF39E2
      231225C4F81A031EE56F27A66A9E445E6E4488F1F9CD24FE4011E28149D67739
      02CC022339DC11F73E27872EE5773F54C827D347167284FC036ED38224E456EF
      B3042DC9EF5D50635467F5E17C57BEE640ACA0BCE71965EF3FFF548898EF323E
      A961933E78BE9E10C3ADCA6E3D44CC968C0FEBD80D9B92F5F8037CA9C33B92ED
      66881837F41C76036CE75262E60238BBC149ACE9EB70D4A4C81CCBB6F2E17266
      DA54534FC9D5D46BAA69327471BA1761B1E43EF3B5509F697207BE2AD481451C
      34E15C0926D6F6B91A359B1CB4A1F9A93D96340060DC4CEDEDD87DE64C0E6E62
      0549884FECD3E81594B79BDEA3D680229BDE9A89C835D017252425C84708AD01
      6EFAF6261950F92E9964F511694C48EA93ED646CFE55CD9A3D75D66AC61FC436
      D095940D6040B3CBF5895AB8935DB1AA8914D5E93AA84647450757743FD1923F
      CA36DA7889C0337447CF81C06386210000000049454E44AE426082}
    Shadow = True
    DisabledColor = clWhite
    TabOrder = 2
    TabStop = False
    ShowFocus = False
    HorizontalSpacing = 0
    VerticalSpacing = 0
    Version = '2.1.1.5'
    OnClick = NoButtonClick
    TMSStyle = 0
  end
  object CloseTimer: TTimer
    Enabled = False
    OnTimer = CloseTimerTimer
    Left = 32
    Top = 152
  end
  object AskTimer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = AskTimerTimer
    Left = 80
    Top = 192
  end
end
