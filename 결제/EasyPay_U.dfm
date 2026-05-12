object EasyPay_F: TEasyPay_F
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'EasyPay_F'
  ClientHeight = 497
  ClientWidth = 725
  Color = clWhite
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #47569#51008' '#44256#46357
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 20
  object OutLineShape: TShape
    Left = 0
    Top = 0
    Width = 725
    Height = 497
    Align = alClient
    ExplicitTop = -1
    ExplicitWidth = 552
    ExplicitHeight = 283
  end
  object MessageLabel: TcxLabel
    Left = 120
    Top = 106
    AutoSize = False
    Caption = 'QR '#46608#45716' '#48148#53076#46300#47484' '#51069#54784#51452#49464#50836
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = 4737096
    Style.Font.Height = -33
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taCenter
    Properties.Alignment.Vert = taVCenter
    Properties.WordWrap = True
    Transparent = True
    Height = 97
    Width = 539
    AnchorX = 390
    AnchorY = 155
  end
  object BarCodeLabel: TcxLabel
    Left = 138
    Top = 250
    AutoSize = False
    ParentFont = False
    Style.BorderStyle = ebsOffice11
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = 4737096
    Style.Font.Height = -23
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taCenter
    Properties.Alignment.Vert = taVCenter
    Properties.WordWrap = True
    Transparent = True
    Height = 73
    Width = 489
    AnchorX = 383
    AnchorY = 287
  end
  object NoButton: TAdvSmoothButton
    Left = 397
    Top = 368
    Width = 169
    Height = 71
    Appearance.PictureAlignment = taCenter
    Appearance.PictureStretchMode = pmStretch
    Appearance.Font.Charset = HANGEUL_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -27
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
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
    Color = 3881787
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
    TabOrder = 3
    ShowFocus = False
    HorizontalSpacing = 0
    VerticalSpacing = 0
    Version = '2.2.2.0'
    OnClick = NoButtonClick
    TMSStyle = 8
  end
  object YesButton: TAdvSmoothButton
    Left = 204
    Top = 368
    Width = 169
    Height = 71
    Appearance.PictureAlignment = taCenter
    Appearance.PictureStretchMode = pmStretch
    Appearance.Font.Charset = HANGEUL_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -27
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
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
    Color = 14117632
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
    Version = '2.2.2.0'
    OnClick = YesButtonClick
    TMSStyle = 8
  end
  object FDKPanel: TPanel
    Left = 7
    Top = 6
    Width = 712
    Height = 488
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 2
    Visible = False
    object KaoPayButton: TAdvSmoothButton
      Left = 103
      Top = 136
      Width = 245
      Height = 107
      Hint = 'KAO'
      Appearance.PictureAlignment = taCenter
      Appearance.Font.Charset = HANGEUL_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -23
      Appearance.Font.Name = #47569#51008' '#44256#46357
      Appearance.Font.Style = []
      Appearance.Layout = blPictureTop
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
      Caption = #52852#52852#50724#54168#51060
      Color = 14117632
      ParentFont = False
      Picture.Data = {
        89504E470D0A1A0A0000000D49484452000000320000003208060000001E3F88
        B1000000097048597300000B1300000B1301009A9C180000046249444154789C
        ED99FB8B555514C7AFAF197BF824D0A2341F1392668A8614953DD450241B5F54
        D85F206A42930F046D8C482B432422EC87104A54ACD082F4071B7FB03011A212
        8DD4498344A920272D5FF389A5DF136B0EE7DCF6B9F71C35BA5F38CC39FBEEBD
        D6FA9EB3F65A6BAF29956AA8A1861AFE97000602CF02AF03DB816F81E3C06FBA
        ECFE1B609BE63C030C285D0F0006012F01DF51398CF00AE0CE6B41602CF03170
        C919F427D0023403D38051C01D401F5D763F1A784A73766B4D0493F51130E66A
        10E80F6C00DAA5FC22B0159808D45720AF1E98047C285948F67B40BFA2484C01
        4E5D56057F01ABEC2DE7287F00B01A38271D2781C979C98F942C706EF405303C
        57051D7535009FBBAFB3222FC1AF48A87DFA26A0732E82CBEBEC0CBCE8DC6D65
        B5029F9720FBDC4FE66669B8FE46E76AF32A15F22070412E3523772BC3ED982D
        173B0F3C504934F95E6FA2B9302BB3BBF741A02ECBC2855A6899B85BA15686D9
        53E792EEFCD045DD809FB428DFF0570580A9B2E947A06BC88227B4C0DE402737
        FE868B2271981BF602EE554DB51FE81B93FBBEE675C83DAA022CC337B9B1C780
        AFECAF1BEB041C92BE092144D669F2F2D8F827A4C30CB9CDC57FC39AD87ADBAC
        8699B1712B200D9FE9F971E0ACC65E8DCDB5BACEB03684C8979AFC486CFC46AB
        83749DD19C17F47C3B3058D1254A9CA7FCC6540434CC4A234247123B811B6273
        ED4B19F6841089CA90D45A0738AD39D3DD981582A8F63AACFBC60C44CC255349
        B85ACF70328448E40275A14494898F45638ED4B60C4422B4D97E2B13BD0CE742
        88982043CF0C44ACFA35FC6E6F1218A66733FED68C440CEB52F4DE7CF957680B
        21D2AAC9433310F940CF17DC8930425320917DC0CB6EDDEC04BD43F55B6B0891
        283A3D1D4204E8ED7C3B09076244E62A30D8D535B6D9BB00BBDCD76D4828570C
        DB43882CD1E47703893CA7FB3F14BDA213E1C38ECC0847C4636B42F8ED0F9CD0
        D8A731BD76E0322C0A217297C2685BDA3E0176446FCCF28202C49B09F35A24E7
        6E60A3733BBB7EB1F25C19DB5EC242B76E3CF0B3E50D37D64B3ADBCBB97D9201
        86A565E6FC5383994B949997FA5B1600CB64D38E2C8BC63B771958BA3EBA3567
        F4351ECABA788B3BDA666E2CE405AE1C29F6CA960D9508E8AB4A13157CB9B848
        461BBA009B64C3E1B4441922688C36986173A6434D9500BA4BA7E1578B7CD50A
        BCDF91D9171C31AAD33942653C8A6EF7E525F81EE007093EAD0E477D41FBA1D9
        351C4CE7B0BC95F4D65E8970D41F7CAA947D0BB0D8159E28F9F5C8437E9AD209
        CED56654D9599CA316ACEF017F0D3C9AAFD5C906F454263F9F1445D446B222F2
        2D656E6B64CCB7B2C2B2BFCA92281A4668578D35CD1FAF8B2662DD74434B4294
        792DD6A12F87B33A1A5BF772C85531DE03783B5EB8294C47ED1A6B50AC51BF78
        B9EED7DAF95B47E3596A52FC7B27A448004764F04895E18B5C943992B984B816
        E04A658C2AD3E1CA2B918FBF03DC54FA2F009827C34FE87F24E844597C94C913
        C0FA58A4595F68AC2F0AEA3BB52ADA8C2B4C510D35D4504329057F0301CFC321
        64AEAA0A0000000049454E44AE426082}
      Shadow = True
      DisabledColor = clWhite
      TabOrder = 0
      ShowFocus = False
      HorizontalSpacing = 0
      VerticalSpacing = 0
      Version = '2.2.2.0'
      OnClick = KaoPayButtonClick
      TMSStyle = 8
    end
    object ZeroPayButton: TAdvSmoothButton
      Left = 387
      Top = 136
      Width = 245
      Height = 107
      Hint = 'ZRO'
      Appearance.PictureAlignment = taCenter
      Appearance.PictureStretchMode = pmStretch
      Appearance.Font.Charset = HANGEUL_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -23
      Appearance.Font.Name = #47569#51008' '#44256#46357
      Appearance.Font.Style = []
      Appearance.Layout = blPictureTop
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
      Caption = #51228#47196#54168#51060
      Color = 14117632
      ParentFont = False
      Shadow = True
      DisabledColor = clWhite
      TabOrder = 1
      ShowFocus = False
      HorizontalSpacing = 0
      VerticalSpacing = 0
      Version = '2.2.2.0'
      OnClick = KaoPayButtonClick
      TMSStyle = 8
    end
    object SSGPayButton: TAdvSmoothButton
      Left = 103
      Top = 255
      Width = 245
      Height = 106
      Hint = 'SSG'
      Appearance.PictureAlignment = taCenter
      Appearance.Font.Charset = HANGEUL_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -23
      Appearance.Font.Name = #47569#51008' '#44256#46357
      Appearance.Font.Style = []
      Appearance.Layout = blPictureTop
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
      Caption = 'SSG'
      Color = 14117632
      ParentFont = False
      Shadow = True
      DisabledColor = clWhite
      TabOrder = 2
      ShowFocus = False
      HorizontalSpacing = 0
      VerticalSpacing = 0
      Version = '2.2.2.0'
      OnClick = KaoPayButtonClick
      TMSStyle = 8
    end
    object AriPayButton: TAdvSmoothButton
      Left = 387
      Top = 255
      Width = 245
      Height = 106
      Hint = 'CHI'
      Appearance.PictureAlignment = taCenter
      Appearance.PictureStretchMode = pmStretch
      Appearance.Font.Charset = HANGEUL_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -23
      Appearance.Font.Name = #47569#51008' '#44256#46357
      Appearance.Font.Style = []
      Appearance.Layout = blPictureTop
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
      Caption = #50508#47532'&&'#50948#52423
      Color = 14117632
      ParentFont = False
      Shadow = True
      DisabledColor = clWhite
      TabOrder = 3
      ShowFocus = False
      HorizontalSpacing = 0
      VerticalSpacing = 0
      Version = '2.2.2.0'
      OnClick = KaoPayButtonClick
      TMSStyle = 8
    end
    object CancelButton: TAdvSmoothButton
      Left = 453
      Top = 392
      Width = 179
      Height = 80
      Hint = 'ARI'
      Appearance.PictureAlignment = taCenter
      Appearance.Font.Charset = HANGEUL_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -27
      Appearance.Font.Name = #47569#51008' '#44256#46357
      Appearance.Font.Style = []
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
      Color = 3881787
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
      TabOrder = 4
      ShowFocus = False
      HorizontalSpacing = 0
      VerticalSpacing = 0
      Version = '2.2.2.0'
      OnClick = CancelButtonClick
      TMSStyle = 8
    end
    object cxLabel1: TcxLabel
      Left = 93
      Top = 24
      AutoSize = False
      Caption = #44036#54200#44208#51228#47484' '#49440#53469#54644#51452#49464#50836
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = 4737096
      Style.Font.Height = -36
      Style.Font.Name = #47569#51008' '#44256#46357
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taCenter
      Properties.Alignment.Vert = taVCenter
      Properties.WordWrap = True
      Transparent = True
      Height = 65
      Width = 539
      AnchorX = 363
      AnchorY = 57
    end
  end
end
