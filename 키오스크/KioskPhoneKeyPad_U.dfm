object KioskPhoneKeyPad_F: TKioskPhoneKeyPad_F
  Left = 525
  Top = 201
  BorderStyle = bsNone
  Caption = 'KioskPhoneKeyPad_F'
  ClientHeight = 1413
  ClientWidth = 860
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -80
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
  TextHeight = 92
  object Shape1: TShape
    Left = 91
    Top = 481
    Width = 657
    Height = 1
  end
  object KeyInLabel: TcxLabel
    Left = 91
    Top = 392
    AutoSize = False
    ParentColor = False
    ParentFont = False
    Style.BorderStyle = ebsNone
    Style.Color = clNone
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -67
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.TextColor = clBlack
    Style.TextStyle = []
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taCenter
    Properties.Alignment.Vert = taVCenter
    Transparent = True
    Height = 81
    Width = 590
    AnchorX = 386
    AnchorY = 433
  end
  object MessageLabel: TcxLabel
    Left = 5
    Top = 42
    AutoSize = False
    Caption = #55092#45824#54256' '#48264#54840' '#51077#47141
    ParentColor = False
    ParentFont = False
    Style.Color = 14935011
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -53
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.TextColor = 3158064
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taCenter
    Properties.WordWrap = True
    Transparent = True
    Height = 85
    Width = 847
    AnchorX = 429
  end
  object OKButton: TAdvSmoothButton
    Left = 441
    Top = 1267
    Width = 350
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
  object CancelButton: TAdvSmoothToggleButton
    Left = 55
    Top = 1267
    Width = 350
    Height = 100
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = 10658466
    BorderInnerColor = 10658466
    BevelWidth = 0
    BevelColorDisabled = clWhite
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
    TabOrder = 3
    TabStop = False
    OnClick = CancelButtonClick
    TMSStyle = 0
  end
  object Message1Label: TcxLabel
    Left = 8
    Top = 165
    AutoSize = False
    Caption = #51077#47141#54620' '#55092#45824#54256' '#48264#54840#47196' '#47700#45684#44032' '#51456#48708#46104#47732
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
    Properties.Alignment.Vert = taBottomJustify
    Properties.WordWrap = True
    Transparent = True
    Height = 92
    Width = 844
    AnchorX = 430
    AnchorY = 257
  end
  object Message2Label: TcxLabel
    Left = 2
    Top = 263
    AutoSize = False
    Caption = #52852#52852#50724#53665'/SMS'
    ParentColor = False
    ParentFont = False
    Style.Color = 14935011
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -33
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.TextColor = 13789440
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taRightJustify
    Properties.Alignment.Vert = taVCenter
    Properties.WordWrap = True
    Transparent = True
    Height = 42
    Width = 390
    AnchorX = 392
    AnchorY = 284
  end
  object Message3Label: TcxLabel
    Left = 393
    Top = 263
    AutoSize = False
    Caption = #47196' '#50508#47140#46300#47549#45768#45796'.'
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
    Properties.Alignment.Horz = taLeftJustify
    Properties.Alignment.Vert = taVCenter
    Properties.WordWrap = True
    Transparent = True
    Height = 42
    Width = 456
    AnchorY = 284
  end
  object ClearButton: TAdvSmoothButton
    Left = 698
    Top = 426
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
      89504E470D0A1A0A0000000D49484452000000230000002308060000001ED9B3
      59000000097048597300000B1300000B1301009A9C180000023049444154789C
      ED97CF6A144110C67F837AF2AAF105346189A7C48B041F22075111A2E624AB3E
      827B480C040CE28A26089ADCDD3DC4AB8987442FB2E4259488BE42FE3052F02D
      14E3F46CCFEE4C0E211F0CC34C7F555DDDF5A7ABE10CA71863C03CB0086C009B
      7ADBF7238DD78A04B8077C078E81B4E03902BE01772457296E017B99097F029F
      8036F05CEF8EFE7B5E0F98A9CA90A7C0A1141F006F81A902BEEDC434F04EFC54
      F2CD510D79E556F805B85A52DEF85B4EC7CAB0863C734ADE031786D4730E5876
      BA9AC3C4C8A1845F530DDACED5D131643EDF73AEB1955581F3C0B60BEAA82CB3
      F4EDAF2014231707E8088D5F73416D693F10564752654D1EEE03FB402330DED0
      B8F1F2B02AFDBB830CB9E20ADA5460C5FB1AFF93635043FF53F1F27668DA15C6
      CB45C63C74052D0970FC84DEA0D0FF2C125718E78A8C5912A95344CA997836D2
      903E3AE2DA5916C44689749E702EEB3F7F81C91269FEB188F459A4167198CD18
      63DF3168896FF305B12E523B72677EE7ECCCF508D937E27F2822BD38A198E9C6
      C4CC4965D3AF986C1A53FEA7AA0775D4991BB175067568A9FA913A2AF09AF4EF
      1081BB359E4DE3EE6CBA1D638CF9B427812D9DB655C0F47C95DE1F657AE319B7
      823AFA999B65859FD4D4E93D1E520F2B4EC9B6FA91321877AEB1E72523A299B9
      1DAC2AED433E4F94BE6BCED507A3EC485E0CF572EE4D5DC5424BEFAE2B68A90B
      D6D2313208895AC55D57188B6E943B4ADFCA6F945958E57C002CB8BBF6BABEAD
      C45FFA4FE20CA705FF009CF6EABFFC03AC9C0000000049454E44AE426082}
    DisabledColor = clWhite
    TabOrder = 7
    TabStop = False
    ShowFocus = False
    Version = '2.2.2.0'
    OnClick = ClearButtonClick
    TMSStyle = 8
  end
  object AgreeButton: TAdvSmoothButton
    Left = 66
    Top = 1186
    Width = 29
    Height = 33
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
      A2000000097048597300000B1300000B1301009A9C18000000F249444154789C
      ED964D0AC23010850BBD813F277022E22114EFA3F61EA238E30FE8D6656FA457
      7052B517A84C4A4048E9A62922E6415681F70D6F66F1A2E8EF355CE73D404E14
      F11188CF4D9EF1404EC4B336D801DD678AF801A8AF0AF5A531583C8C176740D9
      B4120A94F74B28AFA2B488BDAD3E2D62F104623DDABFBA2E183991E9BC423FE0
      8AF44D112F9C3FD98744E31D6AFDD1C47E703EEC5EDA0203F2A9D23F807D0B42
      D456E1B87C0BC2715985E3F22D08C7F5F522A076BC6CB3FA4059FAE6CE9F5450
      D306DB2A7BC85C59F6445241A50DFAAEB70255DB6C523BA04C256D50F6D1142C
      1EE235DE3C3BDE12FC59BD010837A4E5F1DE85CF0000000049454E44AE426082}
    DisabledColor = clWhite
    TabOrder = 8
    TabStop = False
    ShowFocus = False
    Version = '2.2.2.0'
    OnClick = AgreeButtonClick
    TMSStyle = 8
  end
  object AgreeLabel: TcxLabel
    Left = 108
    Top = 1181
    AutoSize = False
    Caption = #44060#51064#51221#48372' '#49688#51665' '#48143' '#51060#50857#46041#51032
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
    Properties.Alignment.Horz = taLeftJustify
    Properties.Alignment.Vert = taVCenter
    Properties.WordWrap = True
    Transparent = True
    OnClick = AgreeButtonClick
    Height = 42
    Width = 591
    AnchorY = 1202
  end
  object CloseButton: TAdvSmoothButton
    Left = 803
    Top = 3
    Width = 46
    Height = 40
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
      89504E470D0A1A0A0000000D49484452000000280000002808060000008CFEB8
      6D000000097048597300000B1300000B1301009A9C18000004EE49444154789C
      ED586B4C9B55183E6ACC74FE9962A24BBC44F7C33F4B50A33FD40CE604B6E12E
      A0225EC031E2408561193057B631DDC48D8B108980B0655BD8D82A91E180143A
      A61B088C7153C65AB1DAD609AE6B29DFF7BD8786CD90EC35EF474B282DC58DC2
      16C3499EA4DF779EF39CA7EFFB9E4BCBD87C9B6FFF838688778D8C8C3C3A3C3C
      BC14009EE29C3F888877DE525392242D018014006802806B9C739C0800E08220
      340040AADD6E7F78CE8C518400A01200AE4F3464B5DA50A735E0EFFA4B383838
      E4625692A451ABD55A2108C263B39A4600C8028051A7A193554D989E5682AB5F
      49C3E52F24B9202C341DF7EC3A8CA7EACFA32088B2515114AF994CA67444BCC3
      A7E644515CC439AFA34968325579836C2062FD4ECCDD770C1BCF74CBD123D397
      2F5B50DBFB076AEADAF0F35D8771EDCA6DF84EC46EAC579FA3B4CB460D0683C6
      6432DDE3137366B3F93E00E826E181FE2B98109787EB5729B1BC4C83A228B9A4
      D2136C834378E8402D86066DC5ED5B4B71D03A967EBD5EDFA256AB17CCC81CAD
      4400384182DA8B0639628A84AFE4284D678C4F02D5E686B73331366AAFFC45E9
      5D5757571563ECE6573BAD4012FA7BE00ABEF5DAA7F8D98E83FF296A7C0A582C
      364CD8948789F1F9E375595959A9B829739224DDCF3917482439B1003FDAF425
      0A4363A233417FBF19DF0CCBC0FCDC6FE567B3D93C181818F8C80D1BE49CE791
      C00F0D1D18B23C054DC681199BE30E9C3FD78B41CB92B14F6774A6BA9E735EC3
      39AF1D1E1E5E31AD3944BC9B732ED260AA9BC2824A9F99E30E2853BFC19DCAFD
      6EEF45511C55A9542BA74B6F30917FF9F9375CF192424E8BAF0DB6B75DC4E080
      2D725DD2F3B1231AACFAEEACFC59A3D1D0E259E82DBD05442C29FA1E377F90EF
      3353C29088397BCBE5152D4980E1AF6E47756D2B5EE8D163504032369DED9679
      2A95EA0863ECF1290D024023115392BEC6D2E2933E332849122AD34A704DC827
      F8E3E90ECC501EC0BC1C15C66DCCC6DD1987648ED56AE5FEFEFE718CB145DE22
      682472CCBB5FE00947D87D05009037798A585C4C36C646EDC375ABB68D975161
      616111636CD974356821F2EB6B77C8C798AFEB8F738EADCD3D18EA38C36BAB9B
      E5775AADB68731F60663EC5EAF0645516CA201BFEA8C725A66C320A7E3AEEF4F
      3C585A3B569F8270353838388931B6C4AB3987C1672C168BBC49CF0500E07A71
      7131A576EA3DD06EB72FA6CD120046E6CA18775F44576D369BDAE305D7B193E3
      ED80BEBEBE56C698EB4DC719B975ABD3DD2E9F13A1D85C382EA4A96BC3975FFC
      784A2EF511C7C9A7B1DEB4696E473DFEC3187B6E7204E54E226EC8EFC0F8A37F
      B921525983EF45658D4F5871FC3486872B30F3F8FB1E417DC471F2692C6978D2
      A639696E2797311632A5C1B8A397507106DD109DD5EC66302232198B7E8AF508
      EA9B6C90343C69D39C930CBA9EC7F306F97C04F1F6A9C148650D4667B7B821FC
      C33237836B4215989A1BEF11D437D9206978D2A639BD1A0400C9B95791D054C8
      CBA91817696BEDC58DD1991813BDC723A88F384E3E8DF5A6EDDC636D369BDDCD
      A0CD662BBD91DD9EAEE67C16B884C6C6C6538CB100178388B8A0A5A565BF5EAF
      EF337A693A9DAEA7A4A4A438222222B1B3B3B3D168341ABCD00DEDEDED4D6161
      615BCACACAF2753ADD056FDA3477757575859F9F5F3463EC214F7706FACFE449
      C731F3BC172C75FC6658E8F8EC8D4B5A4F38B41733C69E9D86FF3463EC014FE6
      E6DB7C63B7A0FD0B4C30125C1ED341410000000049454E44AE426082}
    DisabledColor = clWhite
    TabOrder = 10
    TabStop = False
    ShowFocus = False
    Version = '2.2.2.0'
    OnClick = CloseButtonClick
    TMSStyle = 8
  end
  object Num1Button: TAdvSmoothToggleButton
    Left = 91
    Top = 512
    Width = 199
    Height = 151
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColor = 13395456
    BevelColorDisabled = clWhite
    BevelColorDown = 14925219
    AutoToggle = False
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -80
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
    TabOrder = 11
    TabStop = False
    OnClick = Num1ButtonClick
    TMSStyle = 0
  end
  object Num2Button: TAdvSmoothToggleButton
    Left = 321
    Top = 512
    Width = 199
    Height = 151
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColor = 13395456
    BevelColorDisabled = clWhite
    BevelColorDown = 14925219
    AutoToggle = False
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -80
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
    TabOrder = 12
    TabStop = False
    OnClick = Num1ButtonClick
    TMSStyle = 0
  end
  object Num3Button: TAdvSmoothToggleButton
    Left = 548
    Top = 512
    Width = 199
    Height = 151
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColor = 13395456
    BevelColorDisabled = clWhite
    BevelColorDown = 14925219
    AutoToggle = False
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -80
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
    TabOrder = 13
    TabStop = False
    OnClick = Num1ButtonClick
    TMSStyle = 0
  end
  object Num6Button: TAdvSmoothToggleButton
    Left = 548
    Top = 668
    Width = 199
    Height = 151
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColor = 13395456
    BevelColorDisabled = clWhite
    BevelColorDown = 14925219
    AutoToggle = False
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -80
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
    TabOrder = 14
    TabStop = False
    OnClick = Num1ButtonClick
    TMSStyle = 0
  end
  object Num5Button: TAdvSmoothToggleButton
    Left = 321
    Top = 668
    Width = 199
    Height = 151
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColor = 13395456
    BevelColorDisabled = clWhite
    BevelColorDown = 14925219
    AutoToggle = False
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -80
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
    TabOrder = 15
    TabStop = False
    OnClick = Num1ButtonClick
    TMSStyle = 0
  end
  object Num4Button: TAdvSmoothToggleButton
    Left = 91
    Top = 668
    Width = 199
    Height = 151
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColor = 13395456
    BevelColorDisabled = clWhite
    BevelColorDown = 14925219
    AutoToggle = False
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -80
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
    TabOrder = 16
    TabStop = False
    OnClick = Num1ButtonClick
    TMSStyle = 0
  end
  object Num7Button: TAdvSmoothToggleButton
    Left = 91
    Top = 824
    Width = 199
    Height = 151
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColor = 13395456
    BevelColorDisabled = clWhite
    BevelColorDown = 14925219
    AutoToggle = False
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -80
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
    TabOrder = 17
    TabStop = False
    OnClick = Num1ButtonClick
    TMSStyle = 0
  end
  object Num8Button: TAdvSmoothToggleButton
    Left = 321
    Top = 824
    Width = 199
    Height = 151
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColor = 13395456
    BevelColorDisabled = clWhite
    BevelColorDown = 14925219
    AutoToggle = False
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -80
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
    TabOrder = 18
    TabStop = False
    OnClick = Num1ButtonClick
    TMSStyle = 0
  end
  object Num9Button: TAdvSmoothToggleButton
    Left = 548
    Top = 824
    Width = 199
    Height = 151
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColor = 13395456
    BevelColorDisabled = clWhite
    BevelColorDown = 14925219
    AutoToggle = False
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -80
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
    TabOrder = 19
    TabStop = False
    OnClick = Num1ButtonClick
    TMSStyle = 0
  end
  object ZeroButton: TAdvSmoothToggleButton
    Left = 321
    Top = 980
    Width = 199
    Height = 151
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColorDisabled = clWhite
    BevelColorDown = 14925219
    AutoToggle = False
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -80
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
    TabOrder = 20
    TabStop = False
    OnClick = Num1ButtonClick
    TMSStyle = 0
  end
  object Zero3Button: TAdvSmoothToggleButton
    Left = 548
    Top = 980
    Width = 199
    Height = 151
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColorDisabled = clWhite
    BevelColorDown = 14925219
    AutoToggle = False
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -80
    Appearance.Font.Name = #46027#50880
    Appearance.Font.Style = [fsBold]
    Appearance.Spacing = 1
    Appearance.ShiftDown = 0
    Appearance.SimpleLayout = True
    Appearance.Rounding = 50
    VerticalSpacing = 0
    HorizontalSpacing = 0
    Caption = '010'
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
    TabOrder = 21
    TabStop = False
    OnClick = Num1ButtonClick
    TMSStyle = 0
  end
  object BSButton: TAdvSmoothToggleButton
    Left = 91
    Top = 980
    Width = 199
    Height = 150
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clWhite
    BorderInnerColor = clWhite
    BevelWidth = 0
    BevelColorDisabled = clWhite
    BevelColorDown = 14925219
    AutoToggle = False
    Picture.Data = {
      89504E470D0A1A0A0000000D49484452000000500000005008060000008E11F2
      AD000000097048597300000B1300000B1301009A9C18000002EF49444154789C
      ED9C3F6B144118879F20B91491EC6A1563630A2D6C54B0B2899549A18D607336
      5A9E95ADC62FA07E032D6C35F6E217F0CF0514B1F46FA18560A18228881A1918
      611976EFF676E79D9B9D7B1F58084BEE9DEC93DDCDCC6F66028AA2288AA2288A
      A2288AA22811B1045C07B6123CEE00C724E52D028F809D848F7752F27AC08308
      2E30C4E19D5DC07DA79157113C72BE8EC79202E7805B4E03AF8165D2E19CA4C0
      1B4EF18FC001D2424CE035A7F067E030E92122F09253F41B709C34F12EF03CF0
      A750F007B046BA78157806F8552866BE3E4DDA78137812F85928F417B840FA78
      117814F8E214BACC6CD05AE021E09353E40AB3432B81A64FF7C1297053E087DC
      0FAC030B02B54DCD0DDB465081CB764856FCF06D3BFAF089B9B0AFB6FE10C83D
      D6CE6DCD1DFB0A5A0925700FF0C2F9E0961DF7FA66C36967DB93C4DCD62AD63E
      154260592CF5D0262E12F40A77892F8965F29E36BC86890496C5524F80DDC892
      D90B2CB6FB1CD8DBB096FB0B79D6B0D64402CDE379CFF9E697F6710E41E641A2
      6F79B505C6124B652D244AC8AB2D30A6582A6B20514A5E2D8131C652D9041225
      E58D1518732C95D590282D6FA4C02EC452D9088921E4550AEC522C9597F4E9B6
      2BCEF91CC5540A5CB377DBFF13E62EEC13377989B010F24A05BE774E0CE80679
      854449790615D8127D845BA27F44A4BA31FD926E8C99F788896C4457C56700D1
      B8233D88BC233D1CD3CF0B2171EC506E33D2A1DCB06627595A62E3306195E990
      351861484A6C1C67BD01F61196ACC5F04C4AE24481EADD9240D5F74BB90A1F63
      5B09891345FAF3538CF4872DE549498C7E526921D0A4D230C4A452EAD39AEB0D
      EAE8C43A5398580FBDB463C54E7A4BBC267AF6CE6B22CFCBE2A283258B8BAE32
      3B7859DE764497B7D14AA0E104F0DD59607991F4115DE2FB1B384BDA785F64DE
      EF400C16FD368741C431586736DA6C46188325B1D56B95B410153817490CD659
      8106DDEEEA8179DD70DD9EC519D8F2FF16619612FFA71366C796A2288AA2288A
      A2288AA2280AB5F907B0BBCAB248671FEC0000000049454E44AE426082}
    Appearance.PictureAlignment = taCenter
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -80
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
    TabOrder = 22
    TabStop = False
    OnClick = BSButtonClick
    TMSStyle = 0
  end
  object CloseTimer: TTimer
    OnTimer = CloseTimerTimer
    Left = 18
    Top = 208
  end
  object ImageCollection: TcxImageCollection
    Left = 680
    Top = 545
    object ImageCollectionItem1: TcxImageCollectionItem
      Picture.Data = {
        0B546478504E47496D61676589504E470D0A1A0A0000000D494844520000001E
        0000001E08060000003B30AEA20000000467414D410000B18F0BFC6105000000
        097048597300000B1300000B1301009A9C18000000F949444154484BED964B0A
        C23010860BDEC0C7094C443C84E27D7CDC4314131FA05B97DE48AFE0A46A2FA0
        33E9B441C8A634E2C27C308B0CE5FFA7339B3F89F496595B28984B0D7BA1E158
        A7AC066A9126CBFBE9EADB183FBE0B652E5299934FAC4A590DAB05A9D0E9886D
        3E113AEBE4A6B048CEAF06B7EB835AA4898398FEF6D9E2AE835642D305352D40
        4DA9CD157F6CCA1D07DD8356C3CFE0F0DA77FC741477E1677070A307AF7E340E
        4D342E89C6A189C625D13834D1B8E46741406E60F6CDE8C3A16FC21D0745509B
        06BF15F6148037EC111441F10E269F2E5CBC2553B94E876CE387A6A23448F7F0
        89552AD420ADC1EAD164F9BF2549DE0837A4E5E63F98120000000049454E44AE
        426082}
    end
    object ImageCollectionItem2: TcxImageCollectionItem
      Picture.Data = {
        0B546478504E47496D61676589504E470D0A1A0A0000000D494844520000001E
        0000001E08060000003B30AEA20000000467414D410000B18F0BFC6105000000
        097048597300000B1300000B1301009A9C18000001F749444154484BED963D2F
        044118C717090595974683DCEE9295A8341A2F8D4FA0D0E824148E0F2071AD78
        BB9B731234123A85CF207A950A518A979BB93B17220A59FF67EFB9DB5C2C67EF
        7643F04B26B9796EE6FF9F99676676B47FCCB57CBB9E900B86905BBA903BB514
        47035AA4C9F2DE44447A0C8DB37A429D1B09B5EF25E6A7381A8E96CCE82233C2
        36E5E822DF5130952BDAA1DDC0E1DA8116696220AA6FF3A18DA32EB42434BA40
        4D8B40D310EA02138B72C485F2414BC3D5C0E1654F71D5A59817AE060E5674DB
        53FF5718F76EA607ADD45D0B571D4237868685E39333859AE69043A8C6745CB0
        7B2FB189F638542234632B663762A6C73038D185DDC4E112E118DB761D8EE301
        FA5FD145C4D1327C1B47E2E9513399EDE1AA27E8B784829BE9DEE4D03B7C1B53
        BE50AE231BAA9F4365E0629844BF171A20873CF1BFD474D70AB94B177D24AE86
        38EA40C706C64F4652CD70E843AACB3172888EB8E8D523DA8C53A83B95E9C20E
        BEC580969D3615A8CE98C1065AC40C9FF1F99CC2EF330CE4488BD9F5FCF7A7D4
        644C20DFB3307DC56C4F07566F9A395C919A8D09B49B407E3BB9FA250231AE86
        9F67FC6D0F012329E7F147684F1FD2C6D19BE3880B3D41E992C09284F3D84B48
        E9F9D823E8098A3CA8C2E8827BDE92A911CF0CB38D37856FAA8C523EBCC47C15
        689096B59E6B65F93F8BA6BD0133B3147AB38732660000000049454E44AE4260
        82}
    end
  end
  object ShowTimer: TTimer
    Enabled = False
    OnTimer = ShowTimerTimer
    Left = 74
    Top = 328
  end
end
