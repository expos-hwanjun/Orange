object SaleReport_F: TSaleReport_F
  Left = 322
  Top = 144
  BorderStyle = bsNone
  Caption = 'SaleReport_F'
  ClientHeight = 768
  ClientWidth = 1024
  Color = clWhite
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  HelpFile = 'BackOffice/POS/'#47588#52636#54788#54889'/'#47588#52636#54788#54889'.htm'
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TitleLabel: TLabel
    Left = 125
    Top = 4
    Width = 161
    Height = 42
    AutoSize = False
    Caption = #47588#52636#54788#54889
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWhite
    Font.Height = -31
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object SearchDateEdit: TcxDateEdit
    Left = 721
    Top = 8
    EditValue = 39229d
    ParentFont = False
    Properties.Alignment.Horz = taCenter
    Properties.DateButtons = [btnClear, btnNow, btnToday]
    Properties.ImmediatePost = True
    Properties.SaveTime = False
    Properties.ShowTime = False
    Properties.OnChange = SearchDateEditPropertiesChange
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -20
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.ButtonStyle = btsOffice11
    Style.IsFontAssigned = True
    TabOrder = 0
    Width = 129
  end
  object SearchButton: TAdvGlassButton
    Left = 857
    Top = 7
    Width = 85
    Height = 39
    BackColor = 5844224
    Caption = #51312#54924
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = []
    ForeColor = clWhite
    GlowColor = 6160384
    ImageIndex = -1
    InnerBorderColor = 6160384
    OuterBorderColor = clWhite
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
    ParentFont = False
    ShineColor = clWhite
    TabOrder = 1
    Version = '1.3.3.0'
    OnClick = SearchButtonClick
  end
  object PrintButton: TAdvGlassButton
    Left = 630
    Top = 7
    Width = 85
    Height = 39
    BackColor = 5844224
    Caption = #52636#47141
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = []
    ForeColor = clWhite
    GlowColor = 6160384
    ImageIndex = -1
    InnerBorderColor = 6160384
    OuterBorderColor = clWhite
    Picture.Data = {
      89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
      F800000006624B474400FF00FF00FFA0BDA793000001FD494441544889DD953D
      6854411485BFB31A8D226109262C561210246044B410B110857469041B0B512C
      05DB856869A156423426A68B3FBD60A90644D4C666C122B8044404418B1824CD
      921C8B374B9EC39BB72F3195B7993BE7DE3967EECC9DF7E0BF35DB7BB6235725
      8B9E017DDD29500BE35F6981A323E962D50D750566B623B7B629D52DD8CE5E09
      B6EF00F51CB42CA919702435FF490078CAC65DFC92D4CEE13DAD8AC018B037F8
      5F80760E07685516B07D06B80A7CE862929E142D8C71DBD78093C09CA4378502
      81FC9224DB9EB17D1AF849D68EFB815D21AF13E1487A607B1A98079202AB81BC
      011C90F436175B2CAA0458B4DDB4DD90F4DDF66A3E98BA83F3C088EDDB89786C
      2361CD746996EDD98A84651C0FF3F3C20AC211DD64A33D53B646B6EB06708EAC
      DB5AB6EB92968B8867C338617BA2C26E076D3FB67DC5F690ED7EDBA702369EAC
      0058070ED93E5EC2BF04DC0326257DCDE1EF6CBF07A66C7F4B092C00C34099C0
      41602122C7F63EB2473809DC4D7DEC8681A3C0E120361AF943C009E045443E00
      CC013F24AD003B5202478057C00A70B6C06F935DE86FDB7DB66FD91E041E0137
      247D0E3CEBB1C0C730B6C8BA6200785DE08F019F8063923AC04BE039D094B494
      E3DB9D28A0B7D9AE876E5198D7A2F805DB97B72C1048C66DDF0F671F934FD956
      F29FBC099151E03A59CBAF01FD6447392FC97F00331DFAA27EB4827A00000000
      49454E44AE426082}
    ParentFont = False
    ShineColor = clWhite
    TabOrder = 2
    Version = '1.3.3.0'
    OnClick = PrintButtonClick
  end
  object ReportPager: TAdvPageControl
    Left = 8
    Top = 58
    Width = 1009
    Height = 701
    ActivePage = TotalTabSheet
    ActiveFont.Charset = DEFAULT_CHARSET
    ActiveFont.Color = clWhite
    ActiveFont.Height = -17
    ActiveFont.Name = #47569#51008' '#44256#46357
    ActiveFont.Style = []
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = []
    ParentFont = False
    DefaultTabColor = clWhite
    DefaultTabColorTo = clWhite
    ActiveColor = 9175040
    ActiveColorTo = 12615680
    TabBackGroundColor = clBtnFace
    TabMargin.TopMargin = 10
    TabMargin.RightMargin = 0
    TabOverlap = 0
    TabSplitLine = True
    Version = '2.0.3.0'
    PersistPagesState.Location = plRegistry
    PersistPagesState.Enabled = False
    TabHeight = 45
    TabOrder = 3
    TabWidth = 130
    OnChange = ReportPagerChange
    object TotalTabSheet: TAdvTabSheet
      Caption = '     '#47588#52636#52509#44292
      Color = clWhite
      ColorTo = clWhite
      TabColor = clWhite
      TabColorTo = clWhite
      object edtNow9: TcxCurrencyEdit
        Left = 237
        Top = 148
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Color = 8454143
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clRed
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 0
        Height = 36
        Width = 76
      end
      object edtNow8: TcxCurrencyEdit
        Left = 140
        Top = 148
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Color = 8454143
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 1
        Height = 36
        Width = 98
      end
      object edtNow2: TcxCurrencyEdit
        Left = 478
        Top = 148
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Color = 8454143
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 2
        Height = 36
        Width = 90
      end
      object edtNow3: TcxCurrencyEdit
        Left = 567
        Top = 148
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Color = 8454143
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 3
        Height = 36
        Width = 101
      end
      object edtNow7: TcxCurrencyEdit
        Left = 910
        Top = 148
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Color = 8454143
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 4
        Height = 36
        Width = 74
      end
      object edtNow6: TcxCurrencyEdit
        Left = 857
        Top = 148
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Color = 8454143
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 5
        Height = 36
        Width = 54
      end
      object edtNow5: TcxCurrencyEdit
        Left = 764
        Top = 148
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Color = 8454143
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 6
        Height = 36
        Width = 94
      end
      object edtNow4: TcxCurrencyEdit
        Left = 667
        Top = 148
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Color = 8454143
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 7
        Height = 36
        Width = 98
      end
      object edtNow1: TcxCurrencyEdit
        Left = 386
        Top = 148
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Color = 8454143
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 8
        Height = 36
        Width = 93
      end
      object txtNow: TcxTextEdit
        Left = 16
        Top = 148
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.Color = 8454143
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 9
        Text = #44552#51068'(2007-05-27)'
        Height = 36
        Width = 125
      end
      object edtBefDay9: TcxCurrencyEdit
        Left = 237
        Top = 113
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clRed
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 10
        Height = 36
        Width = 76
      end
      object edtBefDay8: TcxCurrencyEdit
        Left = 140
        Top = 113
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 11
        Height = 36
        Width = 98
      end
      object edtBefDay2: TcxCurrencyEdit
        Left = 478
        Top = 113
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 12
        Height = 36
        Width = 90
      end
      object edtBefDay3: TcxCurrencyEdit
        Left = 567
        Top = 113
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 13
        Height = 36
        Width = 101
      end
      object edtBefDay7: TcxCurrencyEdit
        Left = 910
        Top = 113
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 14
        Height = 36
        Width = 74
      end
      object edtBefDay6: TcxCurrencyEdit
        Left = 857
        Top = 113
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 15
        Height = 36
        Width = 54
      end
      object edtBefDay5: TcxCurrencyEdit
        Left = 764
        Top = 113
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 16
        Height = 36
        Width = 94
      end
      object edtBefDay4: TcxCurrencyEdit
        Left = 667
        Top = 113
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 17
        Height = 36
        Width = 98
      end
      object edtBefDay1: TcxCurrencyEdit
        Left = 386
        Top = 113
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 18
        Height = 36
        Width = 93
      end
      object txtBefDay: TcxTextEdit
        Left = 16
        Top = 113
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 19
        Text = #51204#51068'(2007-05-26)'
        Height = 36
        Width = 125
      end
      object lblNow1: TcxTextEdit
        Left = 385
        Top = 8
        Margins.Left = 0
        Margins.Top = 10
        Margins.Right = 0
        Margins.Bottom = 0
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.BorderStyle = ebsNone
        Style.Color = 8404992
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.TextColor = clWhite
        Style.IsFontAssigned = True
        TabOrder = 20
        Text = #47588#52636#44552#50529
        Height = 36
        Width = 97
      end
      object lblNow4: TcxTextEdit
        Left = 666
        Top = 8
        Margins.Left = 0
        Margins.Top = 10
        Margins.Right = 0
        Margins.Bottom = 0
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.BorderStyle = ebsNone
        Style.Color = 8404992
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.TextColor = clWhite
        Style.IsFontAssigned = True
        TabOrder = 21
        Text = #44284#49464#47588#52636
        Height = 36
        Width = 100
      end
      object lblNow5: TcxTextEdit
        Left = 763
        Top = 8
        Margins.Left = 0
        Margins.Top = 10
        Margins.Right = 0
        Margins.Bottom = 0
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.BorderStyle = ebsNone
        Style.Color = 8404992
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.TextColor = clWhite
        Style.IsFontAssigned = True
        TabOrder = 22
        Text = #47732#49464#47588#52636
        Height = 36
        Width = 96
      end
      object lblNow6: TcxTextEdit
        Left = 856
        Top = 8
        Margins.Left = 0
        Margins.Top = 10
        Margins.Right = 0
        Margins.Bottom = 0
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.BorderStyle = ebsNone
        Style.Color = 8404992
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.TextColor = clWhite
        Style.IsFontAssigned = True
        TabOrder = 23
        Text = #44256#44061#49688
        Height = 36
        Width = 56
      end
      object lblNow7: TcxTextEdit
        Left = 909
        Top = 8
        Margins.Left = 0
        Margins.Top = 10
        Margins.Right = 0
        Margins.Bottom = 0
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.BorderStyle = ebsNone
        Style.Color = 8404992
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.TextColor = clWhite
        Style.IsFontAssigned = True
        TabOrder = 24
        Text = #44061#45800#44032
        Height = 36
        Width = 78
      end
      object txtBefWeek: TcxTextEdit
        Left = 16
        Top = 78
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 25
        Text = #51204#51452'(2007-05-20)'
        Height = 36
        Width = 125
      end
      object cxTextEdit24: TcxTextEdit
        Left = 14
        Top = 8
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.BorderStyle = ebsNone
        Style.Color = 8404992
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.TextColor = clWhite
        Style.IsFontAssigned = True
        TabOrder = 26
        Text = #44396#48516
        Height = 36
        Width = 128
      end
      object edtBefWeek1: TcxCurrencyEdit
        Left = 386
        Top = 78
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 27
        Height = 36
        Width = 93
      end
      object edtBefWeek4: TcxCurrencyEdit
        Left = 667
        Top = 78
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 28
        Height = 36
        Width = 98
      end
      object edtBefWeek5: TcxCurrencyEdit
        Left = 764
        Top = 78
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 29
        Height = 36
        Width = 94
      end
      object edtBefWeek6: TcxCurrencyEdit
        Left = 857
        Top = 78
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 30
        Height = 36
        Width = 54
      end
      object edtBefWeek7: TcxCurrencyEdit
        Left = 910
        Top = 78
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 31
        Height = 36
        Width = 74
      end
      object txtBefMonth: TcxTextEdit
        Left = 16
        Top = 43
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 32
        Text = #51204#50900'(2007-04-27)'
        Height = 36
        Width = 125
      end
      object edtBefMonth1: TcxCurrencyEdit
        Left = 386
        Top = 43
        AutoSize = False
        EditValue = 100000000.000000000000000000
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 33
        Height = 36
        Width = 93
      end
      object edtBefMonth4: TcxCurrencyEdit
        Left = 667
        Top = 43
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 34
        Height = 36
        Width = 98
      end
      object edtBefMonth5: TcxCurrencyEdit
        Left = 764
        Top = 43
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 35
        Height = 36
        Width = 94
      end
      object edtBefMonth6: TcxCurrencyEdit
        Left = 857
        Top = 43
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 36
        Height = 36
        Width = 54
      end
      object edtBefMonth7: TcxCurrencyEdit
        Left = 910
        Top = 43
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 37
        Height = 36
        Width = 74
      end
      object lblNow3: TcxTextEdit
        Left = 566
        Top = 8
        Margins.Left = 0
        Margins.Top = 10
        Margins.Right = 0
        Margins.Bottom = 0
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.BorderStyle = ebsNone
        Style.Color = 8404992
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.TextColor = clWhite
        Style.IsFontAssigned = True
        TabOrder = 38
        Text = #48176#45804#47588#52636
        Height = 36
        Width = 103
      end
      object edtBefWeek3: TcxCurrencyEdit
        Left = 567
        Top = 78
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 39
        Height = 36
        Width = 101
      end
      object edtBefMonth3: TcxCurrencyEdit
        Left = 567
        Top = 43
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 40
        Height = 36
        Width = 101
      end
      object cxLabel2: TcxLabel
        Left = 275
        Top = 191
        AutoSize = False
        Caption = #9654#51452#44036' '#47588#52636#54788#54889
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -17
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        Transparent = True
        Height = 25
        Width = 166
      end
      object txtWeek1: TcxTextEdit
        Left = 274
        Top = 222
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.BorderStyle = ebsNone
        Style.Color = 8404992
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.TextColor = clWhite
        Style.IsFontAssigned = True
        TabOrder = 42
        Text = '05-26('#51068')'
        Height = 34
        Width = 104
      end
      object txtWeek3: TcxTextEdit
        Left = 482
        Top = 222
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.BorderStyle = ebsNone
        Style.Color = 8404992
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.TextColor = clWhite
        Style.IsFontAssigned = True
        TabOrder = 43
        Text = '05-28('#54868')'
        Height = 34
        Width = 97
      end
      object txtWeek4: TcxTextEdit
        Left = 576
        Top = 222
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.BorderStyle = ebsNone
        Style.Color = 8404992
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.TextColor = clWhite
        Style.IsFontAssigned = True
        TabOrder = 44
        Text = '05-29('#49688')'
        Height = 34
        Width = 102
      end
      object txtWeek5: TcxTextEdit
        Left = 675
        Top = 222
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.BorderStyle = ebsNone
        Style.Color = 8404992
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.TextColor = clWhite
        Style.IsFontAssigned = True
        TabOrder = 45
        Text = '05-30('#47785')'
        Height = 34
        Width = 104
      end
      object txtWeek6: TcxTextEdit
        Left = 776
        Top = 222
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.BorderStyle = ebsNone
        Style.Color = 8404992
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.TextColor = clWhite
        Style.IsFontAssigned = True
        TabOrder = 46
        Text = '06-01('#44552')'
        Height = 34
        Width = 103
      end
      object edtWeek1: TcxCurrencyEdit
        Left = 276
        Top = 255
        AutoSize = False
        EditValue = 100000000.000000000000000000
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 47
        Height = 33
        Width = 101
      end
      object edtWeek3: TcxCurrencyEdit
        Left = 482
        Top = 255
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 48
        Height = 33
        Width = 95
      end
      object edtWeek4: TcxCurrencyEdit
        Left = 576
        Top = 255
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 49
        Height = 33
        Width = 101
      end
      object edtWeek5: TcxCurrencyEdit
        Left = 676
        Top = 255
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 50
        Height = 33
        Width = 101
      end
      object edtWeek6: TcxCurrencyEdit
        Left = 776
        Top = 255
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 51
        Height = 33
        Width = 102
      end
      object txtWeek2: TcxTextEdit
        Left = 375
        Top = 222
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.BorderStyle = ebsNone
        Style.Color = 8404992
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.TextColor = clWhite
        Style.IsFontAssigned = True
        TabOrder = 52
        Text = '05-27('#50900')'
        Height = 34
        Width = 110
      end
      object edtWeek2: TcxCurrencyEdit
        Left = 376
        Top = 255
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 53
        Height = 33
        Width = 107
      end
      object txtWeek7: TcxTextEdit
        Left = 876
        Top = 222
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.BorderStyle = ebsNone
        Style.Color = 8404992
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.TextColor = clWhite
        Style.IsFontAssigned = True
        TabOrder = 54
        Text = '06-02('#53664')'
        Height = 34
        Width = 110
      end
      object edtWeek7: TcxCurrencyEdit
        Left = 877
        Top = 255
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 55
        Height = 33
        Width = 107
      end
      object edtWeekPer1: TcxCurrencyEdit
        Left = 276
        Top = 287
        AutoSize = False
        EditValue = 0.000000000000000000
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '#0.# %'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 56
        Height = 33
        Width = 101
      end
      object edtWeekPer3: TcxCurrencyEdit
        Left = 482
        Top = 287
        AutoSize = False
        EditValue = 0.000000000000000000
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '#0.# %'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 57
        Height = 33
        Width = 95
      end
      object edtWeekPer4: TcxCurrencyEdit
        Left = 576
        Top = 287
        AutoSize = False
        EditValue = 0.000000000000000000
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '#0.# %'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 58
        Height = 33
        Width = 101
      end
      object edtWeekPer5: TcxCurrencyEdit
        Left = 676
        Top = 287
        AutoSize = False
        EditValue = 0.000000000000000000
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '#0.# %'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 59
        Height = 33
        Width = 101
      end
      object edtWeekPer6: TcxCurrencyEdit
        Left = 776
        Top = 287
        AutoSize = False
        EditValue = 0.000000000000000000
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '#0.# %'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 60
        Height = 33
        Width = 102
      end
      object edtWeekPer2: TcxCurrencyEdit
        Left = 376
        Top = 287
        AutoSize = False
        EditValue = 0.000000000000000000
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '#0.# %'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 61
        Height = 33
        Width = 107
      end
      object edtWeekPer7: TcxCurrencyEdit
        Left = 877
        Top = 287
        AutoSize = False
        EditValue = 0.000000000000000000
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '#0.# %'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 62
        Height = 33
        Width = 107
      end
      object lblNow2: TcxTextEdit
        Left = 479
        Top = 8
        Margins.Left = 0
        Margins.Top = 10
        Margins.Right = 0
        Margins.Bottom = 0
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.BorderStyle = ebsNone
        Style.Color = 8404992
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.TextColor = clWhite
        Style.IsFontAssigned = True
        TabOrder = 63
        Text = #48512#44032#49464
        Height = 36
        Width = 90
      end
      object edtBefWeek2: TcxCurrencyEdit
        Left = 478
        Top = 78
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 64
        Height = 36
        Width = 90
      end
      object edtBefMonth2: TcxCurrencyEdit
        Left = 478
        Top = 43
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 65
        Height = 36
        Width = 90
      end
      object cxLabel1: TcxLabel
        Left = 14
        Top = 191
        AutoSize = False
        Caption = #9654#44552#51068' '#50689#50629#54788#54889
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -17
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        Transparent = True
        Height = 25
        Width = 166
      end
      object cxTextEdit6: TcxTextEdit
        Left = 15
        Top = 222
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.BorderStyle = ebsNone
        Style.Color = 8404992
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.TextColor = clWhite
        Style.IsFontAssigned = True
        TabOrder = 67
        Text = #51452#47928#44552#50529
        Height = 35
        Width = 116
      end
      object cxTextEdit7: TcxTextEdit
        Left = 15
        Top = 254
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.BorderStyle = ebsNone
        Style.Color = 8404992
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.TextColor = clWhite
        Style.IsFontAssigned = True
        TabOrder = 68
        Text = #52509'  '#44552'  '#50529
        Height = 35
        Width = 116
      end
      object cxTextEdit8: TcxTextEdit
        Left = 15
        Top = 286
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.BorderStyle = ebsNone
        Style.Color = 8404992
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.Shadow = False
        Style.TextColor = clWhite
        Style.IsFontAssigned = True
        TabOrder = 69
        Text = #53580#51060#48660'('#44256#44061')'
        Height = 36
        Width = 116
      end
      object edtOrderAmt: TcxCurrencyEdit
        Left = 129
        Top = 224
        AutoSize = False
        EditValue = 100000000.000000000000000000
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 70
        Height = 33
        Width = 119
      end
      object edtTotalAmt: TcxCurrencyEdit
        Left = 129
        Top = 255
        AutoSize = False
        EditValue = 100000000.000000000000000000
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 71
        Height = 33
        Width = 119
      end
      object edtTable: TcxTextEdit
        Left = 129
        Top = 287
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.Color = clWhite
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.Shadow = False
        Style.IsFontAssigned = True
        TabOrder = 72
        Text = '10 / 20'
        Height = 33
        Width = 119
      end
      object PayPanel: TPanel
        Left = 16
        Top = 336
        Width = 466
        Height = 299
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Color = clWhite
        Ctl3D = False
        ParentBackground = False
        ParentCtl3D = False
        TabOrder = 73
      end
      object ClassPanel: TPanel
        Left = 500
        Top = 335
        Width = 484
        Height = 299
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Color = clWhite
        Ctl3D = False
        ParentBackground = False
        ParentCtl3D = False
        TabOrder = 74
      end
      object lblNow8: TcxTextEdit
        Left = 139
        Top = 8
        Margins.Left = 0
        Margins.Top = 10
        Margins.Right = 0
        Margins.Bottom = 0
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.BorderStyle = ebsNone
        Style.Color = 8404992
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.TextColor = clWhite
        Style.IsFontAssigned = True
        TabOrder = 75
        Text = #52509#47588#52636#44552#50529
        Height = 36
        Width = 100
      end
      object edtBefWeek8: TcxCurrencyEdit
        Left = 140
        Top = 78
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 76
        Height = 37
        Width = 98
      end
      object edtBefMonth8: TcxCurrencyEdit
        Left = 140
        Top = 43
        AutoSize = False
        EditValue = 100000000.000000000000000000
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 77
        Height = 36
        Width = 98
      end
      object lblNow9: TcxTextEdit
        Left = 236
        Top = 8
        Margins.Left = 0
        Margins.Top = 10
        Margins.Right = 0
        Margins.Bottom = 0
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.BorderStyle = ebsNone
        Style.Color = 8404992
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clRed
        Style.Font.Height = -13
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.TextColor = clWhite
        Style.IsFontAssigned = True
        TabOrder = 78
        Text = #54624#51064#44552#50529
        Height = 36
        Width = 79
      end
      object edtBefWeek9: TcxCurrencyEdit
        Left = 237
        Top = 78
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clRed
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 79
        Height = 36
        Width = 76
      end
      object edtBefMonth9: TcxCurrencyEdit
        Left = 237
        Top = 43
        AutoSize = False
        EditValue = 1000000.000000000000000000
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clRed
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 80
        Height = 36
        Width = 76
      end
      object edtNow10: TcxCurrencyEdit
        Left = 312
        Top = 148
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Color = 8454143
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clBlue
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 81
        Height = 36
        Width = 75
      end
      object edtBefDay10: TcxCurrencyEdit
        Left = 312
        Top = 113
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clBlue
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 82
        Height = 36
        Width = 75
      end
      object lblNow10: TcxTextEdit
        Left = 312
        Top = 8
        Margins.Left = 0
        Margins.Top = 10
        Margins.Right = 0
        Margins.Bottom = 0
        AutoSize = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.BorderStyle = ebsNone
        Style.Color = 8404992
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clBlue
        Style.Font.Height = -13
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.TextColor = clWhite
        Style.IsFontAssigned = True
        StyleFocused.TextColor = clBlue
        TabOrder = 83
        Text = #49436#48708#49828
        Height = 36
        Width = 76
      end
      object edtBefWeek10: TcxCurrencyEdit
        Left = 312
        Top = 78
        AutoSize = False
        EditValue = 0
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clBlue
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 84
        Height = 36
        Width = 75
      end
      object edtBefMonth10: TcxCurrencyEdit
        Left = 312
        Top = 43
        AutoSize = False
        EditValue = 1000000.000000000000000000
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clBlue
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 85
        Height = 36
        Width = 75
      end
    end
    object MenuTabSheet: TAdvTabSheet
      Caption = '  '#47700#45684#48324' '#47588#52636
      Color = clWhite
      ColorTo = clNone
      TabColor = clWhite
      TabColorTo = clWhite
      object cxGrid: TcxGrid
        Left = 11
        Top = 8
        Width = 980
        Height = 345
        Font.Charset = HANGEUL_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = #47569#51008' '#44256#46357
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = False
        LookAndFeel.Kind = lfUltraFlat
        LookAndFeel.NativeStyle = False
        LookAndFeel.SkinName = ''
        object MenuGridView: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0'
              Kind = skSum
              Column = MenuGridViewTotAmt
            end
            item
              Format = ',0'
              Kind = skSum
              Column = MenuGridViewDcAmt
            end
            item
              Format = ',0'
              Kind = skSum
              Column = MenuGridViewSaleAmt
            end
            item
              Format = ',0'
              Kind = skSum
              Column = MenuGridViewVatAmt
            end
            item
              Format = ',0'
              Kind = skSum
              Column = MenuGridViewSoonAmt
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsSelection.CellSelect = False
          OptionsView.DataRowHeight = 30
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          OptionsView.HeaderHeight = 30
          Styles.Footer = StyleFooter
          Styles.Header = StyleHeader
          object MenuGridViewMenuCode: TcxGridColumn
            Caption = #47700#45684#53076#46300
            DataBinding.FieldName = 'CD_MENU'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Styles.Header = StyleHeader
            Width = 123
          end
          object MenuGridViewMenuName: TcxGridColumn
            Caption = #47700#45684#47749
            DataBinding.FieldName = 'NM_MENU'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 228
          end
          object MenuGridViewSaleQty: TcxGridColumn
            Caption = #49688#47049
            DataBinding.FieldName = 'QTY_SALE'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taRightJustify
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 85
          end
          object MenuGridViewTotAmt: TcxGridColumn
            Caption = #52509#47588#52636#44552#50529
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'AMT_TOT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 106
          end
          object MenuGridViewDcAmt: TcxGridColumn
            Caption = #54624#51064#44552#50529
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'AMT_DC'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 98
          end
          object MenuGridViewSaleAmt: TcxGridColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'AMT_SALE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 108
          end
          object MenuGridViewVatAmt: TcxGridColumn
            Caption = #48512#44032#49464
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'AMT_VAT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 97
          end
          object MenuGridViewSoonAmt: TcxGridColumn
            Caption = #49692#47588#52636
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'AMT_SOON'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 105
          end
        end
        object cxGridLevel2: TcxGridLevel
          Caption = #47700#45684#48324' '#47588#52636#54788#54889
          GridView = MenuGridView
        end
      end
      object MenuPanel: TPanel
        Left = 12
        Top = 366
        Width = 980
        Height = 268
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Color = clWhite
        Ctl3D = False
        ParentBackground = False
        ParentCtl3D = False
        TabOrder = 1
      end
    end
    object CalenderTab: TAdvTabSheet
      Caption = '   '#52888#47536#45908' '#47588#52636' '
      Color = clWhite
      ColorTo = clWhite
      TabColor = clWhite
      TabColorTo = clWhite
      object SunLabel: TcxLabel
        Tag = 1
        Left = 3
        Top = 52
        AutoSize = False
        Caption = #51068#50836#51068
        ParentColor = False
        ParentFont = False
        Style.BorderStyle = ebsFlat
        Style.Color = clWhite
        Style.Font.Charset = HANGEUL_CHARSET
        Style.Font.Color = clRed
        Style.Font.Height = -12
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        Height = 25
        Width = 105
        AnchorX = 56
        AnchorY = 65
      end
      object MonLabel: TcxLabel
        Tag = 2
        Left = 109
        Top = 52
        AutoSize = False
        Caption = #50900#50836#51068
        ParentColor = False
        ParentFont = False
        Style.BorderStyle = ebsFlat
        Style.Color = clWhite
        Style.Font.Charset = HANGEUL_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        Height = 25
        Width = 105
        AnchorX = 162
        AnchorY = 65
      end
      object TueLabel: TcxLabel
        Tag = 3
        Left = 215
        Top = 52
        AutoSize = False
        Caption = #54868#50836#51068
        ParentColor = False
        ParentFont = False
        Style.BorderStyle = ebsFlat
        Style.Color = clWhite
        Style.Font.Charset = HANGEUL_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        Height = 25
        Width = 105
        AnchorX = 268
        AnchorY = 65
      end
      object WedLabel: TcxLabel
        Tag = 4
        Left = 320
        Top = 52
        AutoSize = False
        Caption = #49688#50836#51068
        ParentColor = False
        ParentFont = False
        Style.BorderStyle = ebsFlat
        Style.Color = clWhite
        Style.Font.Charset = HANGEUL_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        Height = 25
        Width = 105
        AnchorX = 373
        AnchorY = 65
      end
      object ThuLabel: TcxLabel
        Tag = 5
        Left = 426
        Top = 52
        AutoSize = False
        Caption = #47785#50836#51068
        ParentColor = False
        ParentFont = False
        Style.BorderStyle = ebsFlat
        Style.Color = clWhite
        Style.Font.Charset = HANGEUL_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        Height = 25
        Width = 105
        AnchorX = 479
        AnchorY = 65
      end
      object FriLabel: TcxLabel
        Tag = 6
        Left = 527
        Top = 52
        AutoSize = False
        Caption = #44552#50836#51068
        ParentColor = False
        ParentFont = False
        Style.BorderStyle = ebsFlat
        Style.Color = clWhite
        Style.Font.Charset = HANGEUL_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        Height = 25
        Width = 105
        AnchorX = 580
        AnchorY = 65
      end
      object SatLabel: TcxLabel
        Tag = 7
        Left = 638
        Top = 52
        AutoSize = False
        Caption = #53664#50836#51068
        ParentColor = False
        ParentFont = False
        Style.BorderStyle = ebsFlat
        Style.Color = clWhite
        Style.Font.Charset = HANGEUL_CHARSET
        Style.Font.Color = clBlue
        Style.Font.Height = -12
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        Height = 25
        Width = 105
        AnchorX = 691
        AnchorY = 65
      end
      object SumLabel: TcxLabel
        Tag = 8
        Left = 744
        Top = 52
        AutoSize = False
        Caption = #54633#12288#44228
        ParentColor = False
        ParentFont = False
        Style.BorderStyle = ebsFlat
        Style.Color = clWhite
        Style.Font.Charset = HANGEUL_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        Height = 25
        Width = 105
        AnchorX = 797
        AnchorY = 65
      end
    end
    object TimeTabSheet: TAdvTabSheet
      Caption = '  '#49884#44036#45824#48324#47588#52636
      Color = clWhite
      ColorTo = clNone
      TabColor = clWhite
      TabColorTo = clWhite
      object cxGrid1: TcxGrid
        Left = 5
        Top = 4
        Width = 991
        Height = 637
        Font.Charset = HANGEUL_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = #47569#51008' '#44256#46357
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = False
        LookAndFeel.Kind = lfUltraFlat
        LookAndFeel.NativeStyle = False
        RootLevelOptions.DetailTabsPosition = dtpLeft
        RootLevelStyles.Tab = StyleLevel
        RootLevelStyles.TabsBackground = StyleLevel
        object bvGridView: TcxGridBandedTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridViewColumn2
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridViewColumn3
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridViewColumn4
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridViewColumn5
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridViewColumn6
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridViewColumn7
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridViewColumn8
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridViewColumn9
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridViewColumn10
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridViewColumn11
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridViewColumn12
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridViewColumn13
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridViewColumn14
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridViewColumn15
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridViewColumn16
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridViewColumn17
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridViewColumn18
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridViewColumn19
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridViewColumn20
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridViewColumn21
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridViewColumn22
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridViewColumn23
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsSelection.CellSelect = False
          OptionsView.DataRowHeight = 25
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderHeight = 25
          OptionsView.Indicator = True
          OptionsView.BandHeaderHeight = 25
          Styles.Footer = StyleFooter
          Styles.Header = StyleHeader
          Styles.BandHeader = StyleHeader
          Bands = <
            item
              Width = 138
            end
            item
              Visible = False
            end
            item
              Visible = False
            end
            item
              Visible = False
            end
            item
              Visible = False
            end
            item
              Visible = False
            end
            item
              Visible = False
            end
            item
              Visible = False
            end
            item
              Visible = False
            end
            item
              Visible = False
            end
            item
              Visible = False
            end
            item
              Visible = False
            end>
          object bvGridViewColumn1: TcxGridBandedColumn
            Caption = #49884#44036#45824
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridViewColumn2: TcxGridBandedColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Width = 120
            Position.BandIndex = 1
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridViewColumn3: TcxGridBandedColumn
            Caption = #44256#44061#49688
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Position.BandIndex = 1
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object bvGridViewColumn4: TcxGridBandedColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Width = 120
            Position.BandIndex = 2
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridViewColumn5: TcxGridBandedColumn
            Caption = #44256#44061#49688
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Position.BandIndex = 2
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object bvGridViewColumn6: TcxGridBandedColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Width = 120
            Position.BandIndex = 3
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridViewColumn7: TcxGridBandedColumn
            Caption = #44256#44061#49688
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Position.BandIndex = 3
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object bvGridViewColumn8: TcxGridBandedColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Width = 120
            Position.BandIndex = 4
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridViewColumn9: TcxGridBandedColumn
            Caption = #44256#44061#49688
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Position.BandIndex = 4
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object bvGridViewColumn10: TcxGridBandedColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Width = 120
            Position.BandIndex = 5
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridViewColumn11: TcxGridBandedColumn
            Caption = #44256#44061#49688
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Position.BandIndex = 5
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object bvGridViewColumn12: TcxGridBandedColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Width = 120
            Position.BandIndex = 6
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridViewColumn13: TcxGridBandedColumn
            Caption = #44256#44061#49688
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Position.BandIndex = 6
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object bvGridViewColumn14: TcxGridBandedColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Width = 120
            Position.BandIndex = 7
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridViewColumn15: TcxGridBandedColumn
            Caption = #44256#44061#49688
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Position.BandIndex = 7
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object bvGridViewColumn16: TcxGridBandedColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Width = 120
            Position.BandIndex = 8
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridViewColumn17: TcxGridBandedColumn
            Caption = #44256#44061#49688
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Position.BandIndex = 8
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object bvGridViewColumn18: TcxGridBandedColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Width = 120
            Position.BandIndex = 9
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridViewColumn19: TcxGridBandedColumn
            Caption = #44256#44061#49688
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Position.BandIndex = 9
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object bvGridViewColumn20: TcxGridBandedColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Width = 120
            Position.BandIndex = 10
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridViewColumn21: TcxGridBandedColumn
            Caption = #44256#44061#49688
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Position.BandIndex = 10
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object bvGridViewColumn22: TcxGridBandedColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Width = 120
            Position.BandIndex = 11
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridViewColumn23: TcxGridBandedColumn
            Caption = #44256#44061#49688
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Position.BandIndex = 11
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object bvGridViewRate: TcxGridBandedColumn
            Caption = #48708#50984
            PropertiesClassName = 'TcxProgressBarProperties'
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Options.Moving = False
            Width = 80
            Position.BandIndex = -1
            Position.ColIndex = -1
            Position.RowIndex = -1
          end
        end
        object bvGridView1: TcxGridBandedTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridView1Column2
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridView1Column3
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridView1Column4
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridView1Column5
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridView1Column6
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridView1Column7
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridView1Column8
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridView1Column9
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridView1Column10
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridView1Column11
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridView1Column12
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridView1Column13
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridView1Column14
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridView1Column15
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridView1Column16
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridView1Column17
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridView1Column18
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridView1Column19
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridView1Column20
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridView1Column21
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridView1Column22
            end
            item
              Format = ',0'
              Kind = skSum
              Column = bvGridView1Column23
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsSelection.CellSelect = False
          OptionsView.DataRowHeight = 25
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderHeight = 25
          OptionsView.Indicator = True
          OptionsView.BandHeaderHeight = 25
          Styles.Footer = StyleFooter
          Styles.Header = StyleHeader
          Styles.BandHeader = StyleHeader
          Bands = <
            item
              Styles.Header = StyleHeader
              Width = 133
            end
            item
              Styles.Header = StyleHeader
              Visible = False
            end
            item
              Styles.Header = StyleHeader
              Visible = False
            end
            item
              Styles.Header = StyleHeader
              Visible = False
            end
            item
              Styles.Header = StyleHeader
              Visible = False
            end
            item
              Styles.Header = StyleHeader
              Visible = False
            end
            item
              Styles.Header = StyleHeader
              Visible = False
            end
            item
              Styles.Header = StyleHeader
              Visible = False
            end
            item
              Styles.Header = StyleHeader
              Visible = False
            end
            item
              Styles.Header = StyleHeader
              Visible = False
            end
            item
              Styles.Header = StyleHeader
              Visible = False
            end
            item
              Styles.Header = StyleHeader
              Visible = False
            end>
          object bvGridView1Column1: TcxGridBandedColumn
            Caption = #49884#44036#45824
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            FooterAlignmentHorz = taCenter
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridView1Column2: TcxGridBandedColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Width = 120
            Position.BandIndex = 1
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridView1Column3: TcxGridBandedColumn
            Caption = #44256#44061#49688
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Position.BandIndex = 1
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object bvGridView1Column4: TcxGridBandedColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Width = 120
            Position.BandIndex = 2
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridView1Column5: TcxGridBandedColumn
            Caption = #44256#44061#49688
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Position.BandIndex = 2
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object bvGridView1Column6: TcxGridBandedColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Width = 120
            Position.BandIndex = 3
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridView1Column7: TcxGridBandedColumn
            Caption = #44256#44061#49688
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Position.BandIndex = 3
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object bvGridView1Column8: TcxGridBandedColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Width = 120
            Position.BandIndex = 4
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridView1Column9: TcxGridBandedColumn
            Caption = #44256#44061#49688
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Position.BandIndex = 4
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object bvGridView1Column10: TcxGridBandedColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Width = 120
            Position.BandIndex = 5
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridView1Column11: TcxGridBandedColumn
            Caption = #44256#44061#49688
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Position.BandIndex = 5
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object bvGridView1Column12: TcxGridBandedColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Width = 120
            Position.BandIndex = 6
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridView1Column13: TcxGridBandedColumn
            Caption = #44256#44061#49688
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Position.BandIndex = 6
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object bvGridView1Column14: TcxGridBandedColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Width = 120
            Position.BandIndex = 7
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridView1Column15: TcxGridBandedColumn
            Caption = #44256#44061#49688
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Position.BandIndex = 7
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object bvGridView1Column16: TcxGridBandedColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Width = 120
            Position.BandIndex = 8
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridView1Column17: TcxGridBandedColumn
            Caption = #44256#44061#49688
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Position.BandIndex = 8
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object bvGridView1Column18: TcxGridBandedColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Width = 120
            Position.BandIndex = 9
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridView1Column19: TcxGridBandedColumn
            Caption = #44256#44061#49688
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Position.BandIndex = 9
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object bvGridView1Column20: TcxGridBandedColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Width = 120
            Position.BandIndex = 10
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridView1Column21: TcxGridBandedColumn
            Caption = #44256#44061#49688
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Position.BandIndex = 10
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object bvGridView1Column22: TcxGridBandedColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Width = 120
            Position.BandIndex = 11
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object bvGridView1Column23: TcxGridBandedColumn
            Caption = #44256#44061#49688
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            Visible = False
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Position.BandIndex = 11
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object bvGridView1Rate: TcxGridBandedColumn
            Caption = #48708#50984
            PropertiesClassName = 'TcxProgressBarProperties'
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Options.Moving = False
            Styles.Header = StyleHeader
            Width = 80
            Position.BandIndex = -1
            Position.ColIndex = -1
            Position.RowIndex = -1
          end
        end
        object cxGridLevel3: TcxGridLevel
          Caption = #51077#51109#49884#44036#44592#51456' '
          GridView = bvGridView1
        end
        object cxGridLevel4: TcxGridLevel
          Caption = #53748#51109#49884#44036#44592#51456
          GridView = bvGridView
        end
      end
    end
    object CancelTabSheet: TAdvTabSheet
      Caption = '    '#52712#49548#45236#50669
      Color = clWhite
      ColorTo = clWhite
      TabColor = clWhite
      TabColorTo = clWhite
      object cxGrid3: TcxGrid
        Left = 0
        Top = 0
        Width = 1001
        Height = 646
        Align = alClient
        Font.Charset = HANGEUL_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = #47569#51008' '#44256#46357
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = False
        LookAndFeel.Kind = lfUltraFlat
        LookAndFeel.NativeStyle = False
        object CancelGridView: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0 '#44148
              Kind = skCount
              Column = CancelGridViewMenuName
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsSelection.CellSelect = False
          OptionsView.DataRowHeight = 30
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          OptionsView.HeaderHeight = 30
          Styles.Footer = StyleFooter
          Styles.Header = StyleHeader
          object CancelGridViewMenuCode: TcxGridColumn
            Caption = #47700#45684#53076#46300
            DataBinding.FieldName = 'CD_MENU'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 108
          end
          object CancelGridViewMenuName: TcxGridColumn
            Caption = #47700#45684#47749
            DataBinding.FieldName = 'NM_MENU'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Vert = taVCenter
            FooterAlignmentHorz = taCenter
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 193
          end
          object CancelGridViewQty: TcxGridColumn
            Caption = #49688#47049
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'QTY_CANCEL'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 72
          end
          object CancelGridViewOrderTime: TcxGridColumn
            Caption = #51452#47928#49884#44036
            DataBinding.FieldName = 'DT_ORDER'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 147
          end
          object CancelGridViewCancelTime: TcxGridColumn
            Caption = #52712#49548#49884#44036
            DataBinding.FieldName = 'DT_CANCEL'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 154
          end
          object CancelGridViewUseTable: TcxGridColumn
            Caption = #53580#51060#48660
            DataBinding.FieldName = 'NM_TABLE'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 88
          end
          object CancelGridViewWhy: TcxGridColumn
            Caption = #52712#49548#49324#50976
            DataBinding.FieldName = 'CANCEL_TXT'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Vert = taVCenter
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 157
          end
          object CancelGridViewPosNo: TcxGridColumn
            Caption = 'POS'
            DataBinding.FieldName = 'NO_POS'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
          end
        end
        object cxGridLevel5: TcxGridLevel
          GridView = CancelGridView
        end
      end
    end
    object MonthTabSheet: TAdvTabSheet
      Caption = '     '#50900#48324#47588#52636
      Color = clWhite
      ColorTo = clNone
      TabColor = clWhite
      TabColorTo = clWhite
      object MonthGrid: TcxGrid
        Left = 0
        Top = 0
        Width = 1001
        Height = 646
        Align = alClient
        Font.Charset = HANGEUL_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = #47569#51008' '#44256#46357
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = False
        LookAndFeel.Kind = lfUltraFlat
        LookAndFeel.NativeStyle = False
        object MonthGridView: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0'
              Kind = skSum
              Column = MonthGridViewTotAmt
            end
            item
              Format = ',0'
              Kind = skSum
              Column = MonthGridViewDcAmt
            end
            item
              Format = ',0'
              Kind = skSum
              Column = MonthGridViewServiceAmt
            end
            item
              Format = ',0'
              Kind = skSum
              Column = MonthGridViewSaleAmt
            end
            item
              Format = ',0'
              Kind = skSum
              Column = MonthGridViewVatAmt
            end
            item
              Format = ',0'
              Kind = skSum
              Column = MonthGridViewNetAmt
            end
            item
              Format = ',0'
              Kind = skSum
              Column = MonthGridViewDutyFreeAmt
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsSelection.CellSelect = False
          OptionsView.DataRowHeight = 35
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          OptionsView.HeaderHeight = 35
          Styles.Footer = StyleFooter
          Styles.Header = StyleHeader
          object MonthGridViewMonth: TcxGridColumn
            Caption = #50900
            DataBinding.FieldName = 'CD_MENU'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 95
          end
          object MonthGridViewTotAmt: TcxGridColumn
            Caption = #52509#47588#52636#44552#50529
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'NM_MENU'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 145
          end
          object MonthGridViewDcAmt: TcxGridColumn
            Caption = #54624#51064#44552#50529
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'QTY_CANCEL'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 106
          end
          object MonthGridViewServiceAmt: TcxGridColumn
            Caption = #49436#48708#49828#44552#50529
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'DT_ORDER'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 102
          end
          object MonthGridViewSaleAmt: TcxGridColumn
            Caption = #47588#52636#44552#50529
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'DT_CANCEL'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 143
          end
          object MonthGridViewVatAmt: TcxGridColumn
            Caption = #48512#44032#49464
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'NM_TABLE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 107
          end
          object MonthGridViewNetAmt: TcxGridColumn
            Caption = #44284#49464#47588#52636
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'CANCEL_TXT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 132
          end
          object MonthGridViewDutyFreeAmt: TcxGridColumn
            Caption = #47732#49464#47588#52636
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'NO_POS'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Width = 141
          end
        end
        object MonthGridLevel: TcxGridLevel
          GridView = MonthGridView
        end
      end
    end
    object YearCompareTabSheet: TAdvTabSheet
      Caption = '  '#51204#45380#45824#48708#47588#52636
      Color = clWhite
      ColorTo = clNone
      TabColor = clWhite
      TabColorTo = clWhite
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object YearGrid: TcxGrid
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 995
        Height = 358
        BevelOuter = bvNone
        TabOrder = 0
        LookAndFeel.Kind = lfUltraFlat
        LookAndFeel.NativeStyle = False
        object YearGridView: TcxGridTableView
          Tag = 99
          Navigator.Buttons.CustomButtons = <>
          FilterBox.CustomizeDialog = False
          FilterBox.Visible = fvNever
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0'
              Kind = skSum
              Column = YearGridViewColumn2
            end
            item
              Format = ',0'
              Kind = skSum
              Column = YearGridViewColumn3
            end
            item
              Format = ',0'
              Kind = skSum
              Column = YearGridViewColumn4
            end
            item
              Format = ',0'
              Kind = skSum
              Column = YearGridViewColumn5
            end
            item
              Format = ',0'
              Kind = skSum
              Column = YearGridViewColumn6
            end
            item
              Format = ',0'
              Kind = skSum
              Column = YearGridViewColumn7
            end
            item
              Format = ',0'
              Kind = skSum
              Column = YearGridViewColumn8
            end
            item
              Format = ',0'
              Kind = skSum
              Column = YearGridViewColumn9
            end
            item
              Format = ',0'
              Kind = skSum
              Column = YearGridViewColumn10
            end
            item
              Format = ',0'
              Kind = skSum
              Column = YearGridViewColumn11
            end
            item
              Format = ',0'
              Kind = skSum
              Column = YearGridViewColumn12
            end
            item
              Format = ',0'
              Kind = skSum
              Column = YearGridViewColumn13
            end
            item
              Format = ',0'
              Kind = skSum
              Column = YearGridViewColumn14
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.HideFocusRectOnExit = False
          OptionsView.DataRowHeight = 35
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          OptionsView.HeaderHeight = 35
          Styles.Footer = StyleFooter
          Styles.Header = StyleHeader
          object YearGridViewColumn1: TcxGridColumn
            Caption = #45380#46020
            DataBinding.FieldName = 'YEAR'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            HeaderAlignmentHorz = taCenter
            Width = 76
          end
          object YearGridViewColumn2: TcxGridColumn
            Caption = '1'#50900
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'JAN_AMT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object YearGridViewColumn3: TcxGridColumn
            Caption = '2'#50900
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'FEB_AMT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object YearGridViewColumn4: TcxGridColumn
            Caption = '3'#50900
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'MAR_AMT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object YearGridViewColumn5: TcxGridColumn
            Caption = '4'#50900
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'APR_AMT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object YearGridViewColumn6: TcxGridColumn
            Caption = '5'#50900
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'MAY_AMT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object YearGridViewColumn7: TcxGridColumn
            Caption = '6'#50900
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'JUN_AMT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object YearGridViewColumn8: TcxGridColumn
            Caption = '7'#50900
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'JUL_AMT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object YearGridViewColumn9: TcxGridColumn
            Caption = '8'#50900
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'AUG_AMT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object YearGridViewColumn10: TcxGridColumn
            Caption = '9'#50900
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'SEP_AMT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object YearGridViewColumn11: TcxGridColumn
            Caption = '10'#50900
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'OCT_AMT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object YearGridViewColumn12: TcxGridColumn
            Caption = '11'#50900
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'NOV_AMT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object YearGridViewColumn13: TcxGridColumn
            Caption = '12'#50900
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'DEC_AMT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object YearGridViewColumn14: TcxGridColumn
            Caption = #54633#44228
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'TOT_AMT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            FooterAlignmentHorz = taRightJustify
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
        end
        object YearGridLevel: TcxGridLevel
          GridView = YearGridView
        end
      end
      object YearPanel: TPanel
        Left = 3
        Top = 374
        Width = 997
        Height = 268
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Color = clWhite
        Ctl3D = False
        ParentBackground = False
        ParentCtl3D = False
        TabOrder = 1
      end
    end
  end
  object CloseButton: TcxButton
    AlignWithMargins = True
    Left = 962
    Top = 3
    Width = 59
    Height = 48
    Cursor = crHandPoint
    Cancel = True
    Colors.Default = clWhite
    Colors.DefaultText = clWhite
    Colors.Normal = clWhite
    Colors.NormalText = clWhite
    Colors.Disabled = clWhite
    Colors.DisabledText = clWhite
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.NativeStyle = True
    OptionsImage.Glyph.SourceDPI = 96
    OptionsImage.Glyph.Data = {
      424D761400000000000036000000280000002400000024000000010020000000
      000000000000C40E0000C40E0000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000909090952525252A7A7
      A7A7EAEAEAEAE5E5E5E588888888060606060000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000090909095252
      5252A7A7A7A7F3F3F3F3FFFFFFFFE9E9E9E99E9E9E9EA6A6A6A6FFFFFFFF8787
      8787000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000909
      090952525252A7A7A7A7F3F3F3F3FFFFFFFFE9E9E9E997979797424242420303
      03030000000000000000A7A7A7A7E5E5E5E50000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000040404048A8A8A8AF3F3F3F3FFFFFFFFE9E9E9E9979797974242
      424203030303000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008B8B8B8BFFFFFFFFA6A6
      A6A6424242420303030300000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF8888888888888888888888888888
      8888888888887979797940404040000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EBEBEBEBABABABAB000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA9A9
      A9A9050505050000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      0000000000000E0E0E0E72727272FEFEFEFE7E7E7E7E00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF00000000000000000000000000000000000000000000000000000000AFAF
      AFAFE5E5E5E50000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      000000000000000000000000000081818181FEFEFEFE00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF000000000000000000000000000000001C1C1C1C5B5B5B5B0101
      01010000000000000000000000000000000000000000FFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      0000000000005C5C5C5CFFFFFFFF909090900101010100000000000000000000
      000000000000FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000000000000000000000000000007C7C
      7C7CFCFCFCFC00000000000000000000000000000000000000008F8F8F8FFFFF
      FFFF9090909001010101000000000000000000000000FFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      00000000000000000000000000001C1C1C1C5555555500000000000000000000
      00000000000000000000000000008F8F8F8FFFFFFFFF90909090010101010000
      000000000000FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000087878787FFFFFFFF8F8F8F8F0101010100000000FFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000087878787FFFFFFFF8F8F
      8F8F01010101FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000001C1C1C1C82828282888888888888
      8888888888888888888888888888888888888888888888888888888888888888
      88888888888888888888EAEAEAEAFFFFFFFF8D8D8D8DFFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      000056565656FCFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFE0E0E0E0FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000026262626E5E5E5E5E8E8E8E82A2A2A2AFFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000026262626E5E5E5E5E8E8E8E82A2A
      2A2A00000000FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002727
      2727E5E5E5E5E8E8E8E82A2A2A2A0000000000000000FFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      000000000000000000000000000059595959D1D1D1D100000000000000000000
      0000000000000000000029292929E7E7E7E7E6E6E6E628282828000000000000
      000000000000FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000023232323E7E7E7E7E6E6
      E6E62828282800000000000000000000000000000000FFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      00000000000056565656DADADADA282828280000000000000000000000000000
      000000000000FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A2A2A2A2EAEAEAEA0000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFFFF80808080000000000000000000000000000000000000
      00000000000000000000000000000303030342424242A5A5A5A5FFFFFFFF8B8B
      8B8B000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFFFF808080800000
      000000000000000000000000000000000000030303034242424297979797E9E9
      E9E9FFFFFFFFF3F3F3F38A8A8A8A040404040000000000000000000000000000
      00000000000000000000000000008E8E8E8EF8F8F8F800000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E5E5E5E5A3A3A3A3000000000000000003030303424242429797
      9797E9E9E9E9FFFFFFFFF3F3F3F3A7A7A7A75252525209090909000000000000
      000000000000000000000000000000000000000000000000000010101010E0E0
      E0E0C0C0C0C00000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000088888888FDFDFDFDA3A3
      A3A39C9C9C9CE9E9E9E9FFFFFFFFFFFFFFFFFFFFFFFFDADADADA919191918888
      8888888888888888888888888888888888888888888888888888888888888888
      88888888888891919191E0E0E0E0F9F9F9F93131313100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000606060689898989E6E6E6E6FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F8F8C2C2C2C23131
      3131000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000}
    SpeedButtonOptions.CanBeFocused = False
    SpeedButtonOptions.Flat = True
    SpeedButtonOptions.Transparent = True
    TabOrder = 4
    TabStop = False
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWhite
    Font.Height = -23
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = CloseButtonClick
  end
  object StyleRepository: TcxStyleRepository
    Left = 424
    Top = 8
    PixelsPerInch = 96
    object cxStyle41: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = []
      TextColor = clRed
    end
    object StyleHeader: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 8404992
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = []
      TextColor = clWhite
    end
    object StyleFooter: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 14380288
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = []
      TextColor = clWhite
    end
    object StyleLevel: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = []
      TextColor = 2236962
    end
  end
end
