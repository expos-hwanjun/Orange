object KioskMemberAdd_F: TKioskMemberAdd_F
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'KioskMemberAdd_F'
  ClientHeight = 850
  ClientWidth = 809
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = #47569#51008' '#44256#46357
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    809
    850)
  PixelsPerInch = 96
  TextHeight = 13
  object edt_Mobile: TcxTextEdit
    Left = 236
    Top = 192
    AutoSize = False
    ParentFont = False
    Properties.ImeMode = imDisable
    Properties.MaxLength = 13
    Style.Font.Charset = HANGEUL_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -33
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    StyleFocused.Color = clYellow
    TabOrder = 0
    OnExit = edt_MobileExit
    Height = 53
    Width = 301
  end
  object cxLabel2: TcxLabel
    Left = 30
    Top = 197
    HelpType = htKeyword
    AutoSize = False
    Caption = #51204#54868#48264#54840
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWhite
    Style.Font.Height = -27
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.Shadow = True
    Style.TextColor = 2763306
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    Height = 49
    Width = 185
    AnchorX = 215
  end
  object GenderGroupBox: TcxGroupBox
    Left = 196
    Top = 365
    Caption = ' '#49457#48324' '
    ParentFont = False
    Style.Font.Charset = HANGEUL_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -27
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 2
    Height = 108
    Width = 341
    object rdo_Gender: TcxRadioButton
      Left = 67
      Top = 42
      Width = 86
      Height = 45
      Caption = ' '#50668#51088
      Checked = True
      Font.Charset = HANGEUL_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = True
    end
    object rdo_GenderM: TcxRadioButton
      Left = 197
      Top = 41
      Width = 92
      Height = 45
      Caption = ' '#45224#51088
      Font.Charset = HANGEUL_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object edt_certifyNo: TcxTextEdit
    Left = 236
    Top = 264
    AutoSize = False
    ParentFont = False
    Properties.ImeMode = imDisable
    Properties.MaxLength = 4
    Properties.ReadOnly = True
    Style.Font.Charset = HANGEUL_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -33
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    StyleFocused.Color = clYellow
    TabOrder = 3
    Height = 53
    Width = 102
  end
  object lbl_certifyNo: TcxLabel
    Left = 30
    Top = 269
    HelpType = htKeyword
    AutoSize = False
    Caption = #51064#51613#48264#54840
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWhite
    Style.Font.Height = -27
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.Shadow = True
    Style.TextColor = 2763306
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    Height = 49
    Width = 185
    AnchorX = 215
  end
  object ConfirmButton: TAdvSmoothButton
    Left = 442
    Top = 693
    Width = 274
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
    Caption = #51200#51109
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
    TabOrder = 5
    ShowFocus = False
    Version = '2.2.2.0'
    OnClick = ConfirmButtonClick
    TMSStyle = 8
  end
  object obtn_certify: TAdvSmoothButton
    Left = 344
    Top = 263
    Width = 113
    Height = 55
    HelpType = htKeyword
    HelpKeyword = 'C'
    InitPause = 0
    Appearance.GlowPercentage = 0
    Appearance.PictureAlignment = taCenter
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -20
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
    Appearance.Spacing = 1
    Appearance.ShiftDown = 0
    Appearance.SimpleLayout = True
    Appearance.Rounding = 5
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
    Caption = #51064#51613#50836#52397
    Color = 13789440
    ParentFont = False
    DisabledColor = clWhite
    TabOrder = 6
    ShowFocus = False
    Version = '2.2.2.0'
    OnClick = obtn_certifyClick
    TMSStyle = 8
  end
  object CancelButton: TAdvSmoothToggleButton
    Left = 90
    Top = 693
    Width = 274
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
    Caption = #45208#44032#44592
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
    TabOrder = 7
    OnClick = CancelButtonClick
    TMSStyle = 0
  end
  object MessageLabel: TcxLabel
    Left = 50
    Top = 32
    AutoSize = False
    Caption = #54924#50896#44032#51077
    ParentColor = False
    ParentFont = False
    Style.Color = 14935011
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -53
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.TextColor = clBlack
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taCenter
    Properties.WordWrap = True
    Transparent = True
    Height = 97
    Width = 692
    AnchorX = 396
  end
  object AgreeButton: TAdvSmoothButton
    Left = 95
    Top = 602
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
    TabOrder = 9
    ShowFocus = False
    Version = '2.2.2.0'
    OnClick = AgreeLabelClick
    TMSStyle = 8
  end
  object AgreeLabel: TcxLabel
    Left = 137
    Top = 596
    AutoSize = False
    Caption = #44060#51064#51221#48372' '#49688#51665' '#48143' '#51060#50857#46041#51032
    ParentColor = False
    ParentFont = False
    Style.Color = 14935011
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -27
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.TextColor = clBlack
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taLeftJustify
    Properties.Alignment.Vert = taVCenter
    Properties.WordWrap = True
    Transparent = True
    OnClick = AgreeLabelClick
    Height = 42
    Width = 496
    AnchorY = 617
  end
  object CloseTimer: TTimer
    OnTimer = CloseTimerTimer
    Left = 80
    Top = 47
  end
  object ImageCollection: TcxImageCollection
    Left = 552
    Top = 145
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
end
