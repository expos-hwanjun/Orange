object CardLog_F: TCardLog_F
  Left = 394
  Top = 233
  BorderStyle = bsNone
  Caption = 'CardLog_F'
  ClientHeight = 391
  ClientWidth = 379
  Color = clWhite
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #44404#47548#52404
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Shape1: TShape
    Left = 0
    Top = 0
    Width = 379
    Height = 391
    Align = alClient
    ExplicitWidth = 355
    ExplicitHeight = 364
  end
  object cxLabel1: TcxLabel
    Left = 36
    Top = 31
    Caption = #52852#46300#48264#54840
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -17
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.Shadow = True
    Style.IsFontAssigned = True
  end
  object cxLabel2: TcxLabel
    Left = 36
    Top = 72
    Caption = #49849#51064#44552#50529
    ParentColor = False
    ParentFont = False
    Style.BorderStyle = ebsNone
    Style.Color = clWhite
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -17
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.HotTrack = False
    Style.Shadow = True
    Style.IsFontAssigned = True
  end
  object cxLabel3: TcxLabel
    Left = 36
    Top = 116
    Caption = #48156#44553#49324#47749
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -17
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.IsFontAssigned = True
  end
  object cxLabel4: TcxLabel
    Left = 36
    Top = 160
    Caption = #49849#51064#51068#49884
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -17
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.IsFontAssigned = True
  end
  object lblCardNo: TcxLabel
    Left = 126
    Top = 27
    AutoSize = False
    ParentFont = False
    Style.BorderStyle = ebsOffice11
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -20
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Height = 35
    Width = 215
  end
  object lblAgreeAmt: TcxLabel
    Left = 126
    Top = 70
    AutoSize = False
    ParentFont = False
    Style.BorderStyle = ebsOffice11
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -20
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taRightJustify
    Height = 35
    Width = 215
    AnchorX = 341
  end
  object lblCardName: TcxLabel
    Left = 126
    Top = 114
    AutoSize = False
    ParentFont = False
    Style.BorderStyle = ebsOffice11
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -20
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Height = 35
    Width = 215
  end
  object lblAgreeDate: TcxLabel
    Left = 126
    Top = 158
    AutoSize = False
    ParentFont = False
    Style.BorderStyle = ebsOffice11
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -20
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Height = 35
    Width = 215
  end
  object cxGroupBox1: TcxGroupBox
    Left = 32
    Top = 201
    Caption = #52376#47532#48169#48277
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -16
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 8
    Height = 99
    Width = 309
    object cxLabel5: TcxLabel
      Left = 22
      Top = 27
      Caption = '1. '#44057#51008#44552#50529#51004#47196' '#47700#45684#51452#47928
      ParentColor = False
      ParentFont = False
      Style.BorderStyle = ebsNone
      Style.Color = clWhite
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -17
      Style.Font.Name = #47569#51008' '#44256#46357
      Style.Font.Style = []
      Style.HotTrack = False
      Style.Shadow = True
      Style.IsFontAssigned = True
    end
    object cxLabel6: TcxLabel
      Left = 22
      Top = 58
      Caption = '2. '#52852#46300#54268#50640#49436' '#47196#44536#49849#51064
      ParentColor = False
      ParentFont = False
      Style.BorderStyle = ebsNone
      Style.Color = clWhite
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -17
      Style.Font.Name = #47569#51008' '#44256#46357
      Style.Font.Style = []
      Style.HotTrack = False
      Style.Shadow = True
      Style.IsFontAssigned = True
    end
  end
  object DeleteButton: TAdvGlassButton
    Left = 32
    Top = 309
    Width = 111
    Height = 53
    BackColor = 5844224
    Caption = #49325#51228
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -20
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = []
    ForeColor = clWhite
    GlowColor = 4859136
    InnerBorderColor = clWhite
    OuterBorderColor = 5844224
    Picture.Data = {
      89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
      F800000006624B474400FF00FF00FFA0BDA793000001E7494441544889B595BD
      6E13511085BF4B36295CD09020CC33A48706A4D062B01429242255828097800A
      5A78000A1A1489382584162C1A52870A3A7E6C05D12028031F85C77863EFAE6D
      A28CB4CD9999337367EF3D03276CA9CAA966C065A0012C02F5707581F7C00BE0
      6D4AE970AA026A02568107400DD805F680830839075C04AE023F81FB402BA5E4
      D823A9357547FDA46EA8335527546FAB5FD5965A9B84FC9DFA5A3D33B69B41DE
      82DA8EDCE2226A8ACEDFA8739392E7F2E722B715231E095853BFA8F3D392E738
      E683636DD891A91FD55BFF4B9EE3DA0CAE2C0F5E513B47C0A349B3936081CF04
      D712C0A9C01BC06ED17D8EA21D75398735816E514329A5DFC02BE01A403F6011
      68157594523A543780E7EA1F40600B58AF78607BC04ABECB7DB55112DC8FB9AE
      FE8AAF3926B6A1EEC360449358E9832BB07FD7B45FA04BEFF99775B40C3C036E
      02EBC0D69853D4814E9EE0B1FAA4847C56FD9E1FA1DA54BF95C988FA547D9407
      96E26A95258CE015B1997AD0BFA679F083BA5994348DA977832B1B76ACAA9F8F
      291567D5AE7AA3C89942A88E23766D75BB50EC22A82FD76D7561CACEABE57AA8
      C876FCF43B65FA14B159CCBC1B3923E4552B730578089C66B0323B9153072ED0
      D3B01FC03D60A768654EB2F42F3158FAE7C3D5A1B7F45F3266E99FB8FD05453C
      C4CA43488EBF0000000049454E44AE426082}
    ParentFont = False
    ShineColor = 5844224
    TabOrder = 9
    Version = '1.3.0.2'
    OnClick = DeleteButtonClick
  end
  object CloseButton: TAdvGlassButton
    Left = 230
    Top = 309
    Width = 111
    Height = 53
    BackColor = 5844224
    Caption = #45803#44592
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -20
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = []
    ForeColor = clWhite
    GlowColor = 4859136
    InnerBorderColor = clWhite
    OuterBorderColor = 5844224
    Picture.Data = {
      89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
      F8000001E8494441544889A5D63D4F544114C6F159ABAD848DC6C402888912B0
      3216F616B6561A125B133F816840E237E0E50318889D1636D8DA08D426D0F992
      182BCDBE40ECA0F167B167DDE1B277F72E4EB2D9BDCF3DCFFF9C393377EEA634
      C6401DF5713CA38033788E3D74F44727B467983E0FB8810D9C64D0260EE2D3CC
      F413AC63B22AFC26BE65D025DC1810378B65B422F62BE6ABC08FC2F00A172B14
      3481CDF01C952689B6F42A5FAE34DDD3FE956C268D41011BBDCAC780DEC1DDEC
      7A2B186BC5C09958AC6695B684E7327EE10F16429B8835393EB5BB622BC2D218
      D5BF09CF6FCC64FA8BD017F3E0BD10672BC21F66DBF471E1DE5CE8BBB9D841B3
      22FC8AFE73F0BE24A68D76EFA21E7DDC1F10780B1F0A2D7817F036AE9624D80F
      667D54828F01FB8E6B7894B56661C82CFB094218D822DCD63F837E64BFDF96C1
      CFB42884D2452E24819FB83404DE5BE49D9452BA10FA767C3F281A6AB5DAA794
      D2BD94D261484F6AB55A67C8047A8CED7F0AA6751F8E16264A2ABB8EFB43C009
      93D19E634C156FAEC7D43687414624781D8CD541371BBA0715AC9C03FE32BC9F
      95BD1B30AF7F5C6F95B5ABE099CC2A3FC4DC28C37C3693B6EED972C614BB6525
      62E0CB4878666E602D16AB375AFAAFCC76A61F63B5B42D23124D6111BB05680B
      3B787A66B7FCCF708EBF2D7F015AD337A6227C72AD0000000049454E44AE4260
      82}
    ParentFont = False
    ShineColor = 5844224
    TabOrder = 10
    Version = '1.3.0.2'
    OnClick = CloseButtonClick
  end
  object cxLookAndFeelController1: TcxLookAndFeelController
    Kind = lfOffice11
    Left = 84
    Top = 326
  end
end
