object SelfWait_F: TSelfWait_F
  Left = 0
  Top = 0
  ActiveControl = TelNo2Edit
  BorderStyle = bsNone
  Caption = #49472#54532' '#45824#44592#46321#47197
  ClientHeight = 768
  ClientWidth = 868
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #47569#51008' '#44256#46357
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 21
  object TeamCountLabel: TcxLabel
    Left = 96
    Top = 39
    AutoSize = False
    Caption = #45824#44592#51064#50896' 10'#54016'-20'#47749
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -67
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taCenter
    Transparent = True
    OnClick = TeamCountLabelClick
    Height = 98
    Width = 689
    AnchorX = 441
  end
  object WaitFinishLabel: TcxLabel
    Left = 32
    Top = 662
    AutoSize = False
    Caption = #45824#44592#44032' '#51221#49345' '#46321#47197#46104#50632#49845#45768#45796'.'
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = 13789440
    Style.Font.Height = -47
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taCenter
    Transparent = True
    Visible = False
    OnClick = TeamCountLabelClick
    Height = 68
    Width = 836
    AnchorX = 450
  end
  inline fmKeyPad: TfmKeyPad
    Left = 286
    Top = 226
    Width = 280
    Height = 367
    VertScrollBar.Smooth = True
    Color = clWhite
    ParentBackground = False
    ParentColor = False
    TabOrder = 2
    Touch.InteractiveGestures = [igZoom]
    Touch.InteractiveGestureOptions = []
    Touch.ParentTabletOptions = False
    Touch.TabletOptions = []
    ExplicitLeft = 286
    ExplicitTop = 226
    ExplicitWidth = 280
    ExplicitHeight = 367
    inherited Num_7: TAdvSmoothToggleButton
      Left = 6
      Top = 3
      Width = 84
      Height = 83
      AllowTimer = True
      Color = 13789440
      ColorDown = 16361472
      BorderColor = clNone
      BorderInnerColor = 13789440
      BevelColor = 13789440
      Appearance.Font.Height = -33
      Appearance.Font.Style = [fsBold]
      Appearance.Rounding = 40
      ExplicitLeft = 6
      ExplicitTop = 3
      ExplicitWidth = 84
      ExplicitHeight = 83
      TMSStyle = 0
    end
    inherited Num_8: TAdvSmoothToggleButton
      Left = 99
      Top = 3
      Width = 84
      Height = 83
      AllowTimer = True
      Color = 13789440
      ColorDown = 16361472
      BorderColor = clNone
      BorderInnerColor = 13789440
      BevelColor = 13789440
      Appearance.Font.Height = -33
      Appearance.Font.Style = [fsBold]
      Appearance.Rounding = 40
      ExplicitLeft = 99
      ExplicitTop = 3
      ExplicitWidth = 84
      ExplicitHeight = 83
      TMSStyle = 0
    end
    inherited Num_9: TAdvSmoothToggleButton
      Left = 192
      Top = 3
      Width = 84
      Height = 83
      AllowTimer = True
      Color = 13789440
      ColorDown = 16361472
      BorderColor = clNone
      BorderInnerColor = 13789440
      BevelColor = 13789440
      Appearance.Font.Height = -33
      Appearance.Font.Style = [fsBold]
      Appearance.Rounding = 40
      ExplicitLeft = 192
      ExplicitTop = 3
      ExplicitWidth = 84
      ExplicitHeight = 83
      TMSStyle = 0
    end
    inherited Num_4: TAdvSmoothToggleButton
      Left = 6
      Top = 91
      Width = 84
      Height = 83
      AllowTimer = True
      Color = 13789440
      ColorDown = 16361472
      BorderColor = clWhite
      BorderInnerColor = 13789440
      BevelColor = 13789440
      Appearance.Font.Height = -33
      Appearance.Font.Style = [fsBold]
      Appearance.Rounding = 40
      ExplicitLeft = 6
      ExplicitTop = 91
      ExplicitWidth = 84
      ExplicitHeight = 83
      TMSStyle = 0
    end
    inherited Num_5: TAdvSmoothToggleButton
      Left = 99
      Top = 91
      Width = 84
      Height = 83
      AllowTimer = True
      Color = 13789440
      ColorDown = 16361472
      BorderColor = clWhite
      BorderInnerColor = 13789440
      BevelColor = 13789440
      Appearance.Font.Height = -33
      Appearance.Font.Style = [fsBold]
      Appearance.Rounding = 40
      ExplicitLeft = 99
      ExplicitTop = 91
      ExplicitWidth = 84
      ExplicitHeight = 83
      TMSStyle = 0
    end
    inherited Num_6: TAdvSmoothToggleButton
      Left = 192
      Top = 91
      Width = 84
      Height = 83
      AllowTimer = True
      Color = 13789440
      ColorDown = 16361472
      BorderColor = clNone
      BorderInnerColor = 13789440
      BevelColor = 13789440
      Appearance.Font.Height = -33
      Appearance.Font.Style = [fsBold]
      Appearance.Rounding = 40
      ExplicitLeft = 192
      ExplicitTop = 91
      ExplicitWidth = 84
      ExplicitHeight = 83
      TMSStyle = 0
    end
    inherited Num_1: TAdvSmoothToggleButton
      Left = 6
      Top = 181
      Width = 84
      Height = 83
      AllowTimer = True
      Color = 13789440
      ColorDown = 16361472
      BorderColor = clNone
      BorderInnerColor = 13789440
      BevelColor = 13789440
      Appearance.Font.Height = -33
      Appearance.Font.Style = [fsBold]
      Appearance.Rounding = 40
      ExplicitLeft = 6
      ExplicitTop = 181
      ExplicitWidth = 84
      ExplicitHeight = 83
      TMSStyle = 0
    end
    inherited Num_2: TAdvSmoothToggleButton
      Left = 99
      Top = 181
      Width = 84
      Height = 83
      AllowTimer = True
      Color = 13789440
      ColorDown = 16361472
      BorderColor = clNone
      BorderInnerColor = 13789440
      BevelColor = 13789440
      Appearance.Font.Height = -33
      Appearance.Font.Style = [fsBold]
      Appearance.Rounding = 40
      ExplicitLeft = 99
      ExplicitTop = 181
      ExplicitWidth = 84
      ExplicitHeight = 83
      TMSStyle = 0
    end
    inherited Num_3: TAdvSmoothToggleButton
      Left = 192
      Top = 181
      Width = 84
      Height = 83
      AllowTimer = True
      Color = 13789440
      ColorDown = 16361472
      BorderColor = clNone
      BorderInnerColor = 13789440
      BevelColor = 13789440
      Appearance.Font.Height = -33
      Appearance.Font.Style = [fsBold]
      Appearance.Rounding = 40
      ExplicitLeft = 192
      ExplicitTop = 181
      ExplicitWidth = 84
      ExplicitHeight = 83
      TMSStyle = 0
    end
    inherited Num_0: TAdvSmoothToggleButton
      Left = 99
      Top = 270
      Width = 84
      Height = 83
      AllowAllUp = True
      AllowTimer = True
      Color = 13789440
      ColorDown = 16361472
      BorderColor = clNone
      BorderInnerColor = 13789440
      BevelColor = 13789440
      Appearance.Font.Height = -33
      Appearance.Font.Style = [fsBold]
      Appearance.Rounding = 40
      ExplicitLeft = 99
      ExplicitTop = 270
      ExplicitWidth = 84
      ExplicitHeight = 83
      TMSStyle = 0
    end
    inherited Num_Enter: TAdvSmoothToggleButton
      Left = 194
      Top = 408
      Width = 95
      Height = 96
      AllowTimer = True
      Appearance.Font.Height = -27
      ExplicitLeft = 194
      ExplicitTop = 408
      ExplicitWidth = 95
      ExplicitHeight = 96
      TMSStyle = 0
    end
    inherited Num_BS: TAdvSmoothToggleButton
      Left = 6
      Top = 271
      Width = 84
      Height = 83
      AllowTimer = True
      Color = 13789440
      ColorDown = 16361472
      BorderColor = clNone
      BorderInnerColor = 13789440
      BevelColor = 13789440
      Picture.Data = {
        89504E470D0A1A0A0000000D49484452000000280000002808060000008CFEB8
        6D000000097048597300000B1300000B1301009A9C18000001D749444154789C
        ED98BF2E045118C5178D44941A8950EA1414ECD2F00034949E8152814A22BB85
        27A0F0023C8252505169284427E24F76E67C67C52737D98D71B377E7CEEECC5A
        3227B9CDEC37F7FE72EEB767EE4CA1902B57AE7F2E55ED27591291D5AC07C992
        AA0E7AC385613801F04684DAC5714F72C6C7B901402EBA0CA70DC85827016EFC
        129C9A61B6DB0957AD5647017989DC709BA837DAD44F48596B5578D22804E433
        0C6B8BED2E9A3A2080E56821C043D7842467016EFB2C4E721EE0564780AA3A64
        1A34E2DE93AA8E38169C03E4B53E592506AE04C85BBD76BF6D401139B08AD69B
        4D64FA51848F56ED9E036E1E90F7686D18D69612038AC81420B5887B67AADAE7
        E70AB599938E9A726207CDD30290F3081C004CBA26F2816442B8968076E601DC
        89838B402ED85B08F0D8BEE66A8158C034328F4DDDF277AE25605A994727A41F
        5C2BC0D38C012B1D01064130664D9CC51657DA06ECF93FC9F7D18A5729C54CB9
        FE5B312E27130535C969403E3A0CEAB2559308F26F3FEA8C547558840F9E8705
        E3F8B34F94449D04B8EBAA8B053402B06235FC51CF1CB71A4A2B1B93CA1B308D
        6CCC14D008E0A63B78B31F248B3EAF9D97BF0478E7B56341108C03BCEE361C7D
        5EDCAD4F1FC59EFCF4912B57AE42EFEB0B56028D6755B633030000000049454E
        44AE426082}
      Appearance.Rounding = 40
      ExplicitLeft = 6
      ExplicitTop = 271
      ExplicitWidth = 84
      ExplicitHeight = 83
      TMSStyle = 0
    end
    inherited Num_010: TAdvSmoothToggleButton
      Left = 192
      Top = 270
      Width = 84
      Height = 83
      Color = clSilver
      ColorDown = 16361472
      BorderColor = clNone
      BorderInnerColor = clSilver
      BevelColor = 13789440
      Appearance.Font.Height = -23
      Appearance.Font.Style = [fsBold]
      Appearance.Rounding = 40
      Caption = #52712#49548
      OnClick = fmKeyPadNum_010Click
      ExplicitLeft = 192
      ExplicitTop = 270
      ExplicitWidth = 84
      ExplicitHeight = 83
      TMSStyle = 0
    end
    inherited Num_00: TAdvSmoothToggleButton
      Top = 457
      Width = 90
      Height = 79
      ExplicitTop = 457
      ExplicitWidth = 90
      ExplicitHeight = 79
      TMSStyle = 0
    end
    inherited MinusButton: TAdvSmoothToggleButton
      Top = 457
      ColorDown = 16744448
      DropDownArrowColor = 16744448
      ExplicitTop = 457
      TMSStyle = 0
    end
    inherited HoButton: TAdvSmoothToggleButton
      Left = 171
      Top = 473
      ColorDown = 16744448
      DropDownArrowColor = 16744448
      ExplicitLeft = 171
      ExplicitTop = 473
      TMSStyle = 0
    end
    inherited DongButton: TAdvSmoothToggleButton
      Left = 11
      Top = 502
      ColorDown = 16744448
      DropDownArrowColor = 16744448
      ExplicitLeft = 11
      ExplicitTop = 502
      TMSStyle = 0
    end
    inherited Num_000: TAdvSmoothToggleButton
      Left = 95
      Top = 501
      Width = 90
      Height = 79
      AllowTimer = True
      Appearance.Font.Height = -33
      ExplicitLeft = 95
      ExplicitTop = 501
      ExplicitWidth = 90
      ExplicitHeight = 79
      TMSStyle = 0
    end
    inherited Num_CL: TAdvSmoothToggleButton
      Left = 85
      Top = 387
      Width = 80
      Height = 80
      AllowAllUp = True
      AllowTimer = True
      Color = clWhite
      Appearance.Font.Color = 7929856
      Appearance.Rounding = 40
      ExplicitLeft = 85
      ExplicitTop = 387
      ExplicitWidth = 80
      ExplicitHeight = 80
      TMSStyle = 0
    end
  end
  object SaveButton: TAdvSmoothButton
    Left = 611
    Top = 488
    Width = 161
    Height = 105
    Appearance.PictureAlignment = taCenter
    Appearance.Font.Charset = HANGEUL_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -23
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
    Appearance.Layout = blPictureTop
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
    Status.Appearance.Fill.Rounding = 0
    Status.Appearance.Fill.ShadowOffset = 0
    Status.Appearance.Fill.Glow = gmNone
    Status.Appearance.Font.Charset = DEFAULT_CHARSET
    Status.Appearance.Font.Color = clWhite
    Status.Appearance.Font.Height = -11
    Status.Appearance.Font.Name = 'Tahoma'
    Status.Appearance.Font.Style = []
    Caption = #45824#44592#46321#47197
    Color = 13789440
    ParentFont = False
    Picture.Data = {
      89504E470D0A1A0A0000000D49484452000000320000003208060000001E3F88
      B1000000097048597300000B1300000B1301009A9C180000056149444154789C
      D55A6B685C55103E51ABA2551441E3AB0ABE8AA952C5EA1F415410B1E25B0BA2
      3F047FA8A814EC03848A1A6BFDD1367D60A845AD3FFD25A2B44431B51A44EBA3
      2A462B52AC509FD1A2661FF7FB666D4766EFDCEC657393EC6EB2E1EE0717F6CC
      3967CE993B8F3367EE86D02080CACD240701160116E2DF95C5618640F252921B
      49F9D6D72802324C7203C94B666A91E748D1EC87BDD3E1ADAAC700DC02F0D044
      6B581FC07E1BDBF242B126AACC00C8B262514FB70790E5468BFB5AD38C0BB1CB
      F99748AE159145AA7ABC3DF69BE43A80657F69EFB72C0CC99DF142B26CBC90B2
      C217186C85B769C2DFFA8F00E6A7E81F00FCACD6C6C5A4EC77815F6C491080A3
      C6C0B450DF572A95CE70E6A3ADF8849B4C292D842131A9908209639A01F81FC9
      052147826C746DAE1DDF27E304F139EB7D4E5FB3EBD9E44137ADE5F57D80AC6C
      D5B42C3AD95C11B9A2514144E44ADFCB702BCEBE38E5EC2B4C0BF6981000D9AA
      B3279A56D5B91309522C6A779AAEAA27B46A01CE98BD331D7E271304902F9DFF
      DEB430D316A4A699EA815898890331655A8BEAFB8A45ED3621DC8CBE4AE82272
      95D3BE0979417C625735BA2EABBF58D46E1302E027A9397D3E67FDB437A0AA27
      9AE3937C0FE06E405E89A2CAF5CDF2B1B4C3C36FD9426B03E37B00461E7E7BC2
      7400E0423BBCB2D308794955BB9AE3C77E9FBF7F326148F6240722C9CDCD6CF8
      02802316A5129AAACE49EC1AE0A724EF2179B9A72A55C7056455338258BA6169
      87F32C9BC9981F5800B027F609F699265C889DAA7A74C30B24F19A941F526F65
      89D3BEB33CA86EFC356E26A3667ACD0A6369476C323251D268E6B4B929219CF9
      9C3889132D14F434176493BFF595597348BEE36FEDBEA616ABCD5F10BF7D194E
      22A345A7F8349F864FD49245DC99B667409EC81A6F74EFDF1AF20492CFA4C363
      14C9A3BED157A730C7EF439E1045951BDC3E775B9BE442DFE8BEACF1AA7A94F9
      08C0C38939E602AA3A1760C51E8F2247003C68C294CBE5B3B3E6907C376D8EB9
      01205FD8C6A2A8729DB54979CBCDEDDE09C6AFF2FE0D214FA0DF1992F3C16E89
      6E6E5BB2C65B18F6F17B429E40F26E7FC303750EBD779233C1D28843AA7A52C8
      0B8A71166A1AF857558F6CC4A1010EF91DE5A6902790B2CFB57259DCE6803BF4
      5DD9E3B9DAC7AF09790220DB628797C7BCFDA46F7453D6F828AADCE85AFC28E4
      09241F74077EDDDA2272B5B7BF9E226C53558F0B790180F9EEE03F5BDB12B7B8
      84C3C3AA7A4AF61CF9DCC3F6B5212F50D52E927FC41B8BCEADCBC36ECD9A532B
      DB4CFE00144B0C45E4110B26A1DD20E58D74660BC8536E5EDBB2C6DB3D1CE03F
      8D089312AABFED8200B2349D30C629775C222A954A67B5CAD7AE0B161C2CBCFB
      8B5A18DA89288ACEF78DFFA9AAC7A6B5644E3FDDC38FE4F32EC8EAD06E5838F5
      8D2FB576A1A0A792F2936FE0571179D804B6E4B2D58A3F3D83682BAC52E25A29
      5811C268E572795E7C7F6FDC175285BD818C1AF248980D00F2727227492298A5
      2D24EFB7AB2EC0BF9A11A6542A9D99F026F99B5F11E6B55D103BE0925CCA42F2
      4469CA5420B9A33E7C93DCEEB4DBC36CC08421E5CD543D6B0F208FDBF78E462B
      28B55A329FCDA0F5B655808CCD3C40CA8126CF8A219B0BE036DFF48E849F6982
      316D7B986DC4453B2E01E435BBA34C750802FCD0E6D9553931CF8457B95C3EC7
      69BF874E429673031CA90F02B947CAE1EFA82FF201B825740A52CE3D769A935C
      E3B4A743A720E5F0630723AB85F12AEDEDD029B064D303C0C1E47344E4391D29
      BF844E74F85496D005F0EF893E877782C38F65081CFB5E32737FD8994D877F21
      A101B2D56822F250E814D89DDE7DE200808BA2283A2F293F59113D740ABC303E
      9491017C3C2B77F89984AA9E6C1F522D353147B7AB82D19A65F43F34982F30A8
      758D8B0000000049454E44AE426082}
    DisabledColor = clWhite
    TabOrder = 3
    ShowFocus = False
    Version = '2.1.1.5'
    OnClick = SaveButtonClick
    TMSStyle = 0
  end
  object PhoneNumberPanel: TPanel
    Left = 284
    Top = 155
    Width = 283
    Height = 62
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 4
    object TelNo3Edit: TcxTextEdit
      Left = 194
      Top = 5
      Margins.Left = 10
      Margins.Right = 10
      AutoSize = False
      ParentFont = False
      Properties.Alignment.Horz = taCenter
      Properties.MaxLength = 4
      Properties.OnChange = TelNo3EditPropertiesChange
      Style.BorderColor = 13789440
      Style.BorderStyle = ebsSingle
      Style.Font.Charset = HANGEUL_CHARSET
      Style.Font.Color = 13789440
      Style.Font.Height = -29
      Style.Font.Name = #47569#51008' '#44256#46357
      Style.Font.Style = []
      Style.LookAndFeel.Kind = lfFlat
      Style.LookAndFeel.NativeStyle = False
      Style.TextColor = clBlack
      Style.IsFontAssigned = True
      StyleDisabled.BorderColor = clBlack
      StyleDisabled.Color = clWhite
      StyleDisabled.LookAndFeel.Kind = lfFlat
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.TextColor = clBlack
      StyleFocused.LookAndFeel.Kind = lfFlat
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.Kind = lfFlat
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 0
      Height = 54
      Width = 87
    end
    object TelNo2Edit: TcxTextEdit
      Left = 99
      Top = 5
      Margins.Left = 10
      Margins.Right = 10
      AutoSize = False
      ParentFont = False
      Properties.Alignment.Horz = taCenter
      Properties.MaxLength = 4
      Properties.OnChange = TelNo2EditPropertiesChange
      Style.BorderColor = 13789440
      Style.BorderStyle = ebsSingle
      Style.Font.Charset = HANGEUL_CHARSET
      Style.Font.Color = 13789440
      Style.Font.Height = -29
      Style.Font.Name = #47569#51008' '#44256#46357
      Style.Font.Style = []
      Style.LookAndFeel.Kind = lfFlat
      Style.LookAndFeel.NativeStyle = False
      Style.TextColor = clBlack
      Style.IsFontAssigned = True
      StyleDisabled.BorderColor = clBlack
      StyleDisabled.Color = clWhite
      StyleDisabled.LookAndFeel.Kind = lfFlat
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.TextColor = clBlack
      StyleFocused.LookAndFeel.Kind = lfFlat
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.Kind = lfFlat
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 1
      Height = 54
      Width = 87
    end
    object TelNo1Edit: TcxTextEdit
      Left = 2
      Top = 5
      Margins.Left = 10
      Margins.Right = 10
      AutoSize = False
      ParentFont = False
      Properties.Alignment.Horz = taCenter
      Properties.MaxLength = 3
      Style.BorderColor = 13789440
      Style.BorderStyle = ebsSingle
      Style.Font.Charset = HANGEUL_CHARSET
      Style.Font.Color = 13789440
      Style.Font.Height = -29
      Style.Font.Name = #47569#51008' '#44256#46357
      Style.Font.Style = []
      Style.LookAndFeel.Kind = lfFlat
      Style.LookAndFeel.NativeStyle = False
      Style.TextColor = clBlack
      Style.IsFontAssigned = True
      StyleDisabled.BorderColor = clBlack
      StyleDisabled.Color = clWhite
      StyleDisabled.LookAndFeel.Kind = lfFlat
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.TextColor = clBlack
      StyleFocused.LookAndFeel.Kind = lfFlat
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.Kind = lfFlat
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 2
      Text = '010'
      Height = 54
      Width = 87
    end
  end
  object AdultButton: TAdvSmoothToggleButton
    Left = 607
    Top = 229
    Width = 170
    Height = 93
    Color = 13789440
    BorderColor = 13789440
    BorderInnerColor = 13789440
    BevelWidth = 0
    Picture.Data = {
      89504E470D0A1A0A0000000D49484452000000280000002808060000008CFEB8
      6D000000097048597300000B1300000B1301009A9C18000001CD49444154789C
      ED98BB4A0341148657A3168AB752DB888F22083E81858ABD588895A2968ABD44
      24C642456C447C026F21C54A2CB430366AA7AD28C1DB27873D915949422EEC4E
      20FBC38199FC73D88F9399DD3DEB38CD22200E8C6BC49D4611D0071CE2D70F70
      00F4DA866B07D20A9502C63476F4B70BA0CD26E0B4822C16F196D49BB243E741
      1C036F52C9225E07F00E1CD9A1F320D2C05D193F075C864BE507D8033EE5A014
      F1FAD5DBB543E7418CEA3EDB330F831E9E7DF546AC018A806D05B9069681151D
      8BB61CDB025A8179E0C5B80F3E0373408BD3280262C0B046CC364C0FB00E3CEA
      53A3947E74CD1AD01D265C618FB94012D82C11E25DE9DA6C28905A39D14C1539
      B39AB31A2C9D77B127A95C0D792EF0100C95FF42DFF2D7D5909794DC60A8FC17
      126DD6909790C460A84A00020B1265D6FEF9B600DD72FBD1F423C082A20AD6AB
      A882F50AF892AE4DC7B7159CE21B1DA7C2BA519F6AA374527861303CDF7D5101
      D1B592731E06E090F6BBAF40FE1FA05B649ED7B567921B38E03F58B702C0AA5F
      2C224027AA608522DA834D50C18C7478C65C3AB7AC3197EE2F631330A11F8826
      353E3426E4BBA07A1B360107817BA351CF6998F3016B808E07D9697CFA957197
      39B70A17867E01C12B15A9B79D2E350000000049454E44AE426082}
    Appearance.PictureAlignment = taCenter
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -20
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
    Appearance.Layout = blPictureTop
    Appearance.Spacing = 0
    Appearance.SimpleLayout = True
    Caption = #49457#51064
    Version = '1.5.1.1'
    Status.Visible = True
    Status.Caption = '0'#47749
    Status.Appearance.Fill.Color = clWhite
    Status.Appearance.Fill.ColorMirror = clNone
    Status.Appearance.Fill.ColorMirrorTo = clNone
    Status.Appearance.Fill.GradientType = gtSolid
    Status.Appearance.Fill.GradientMirrorType = gtSolid
    Status.Appearance.Fill.PicturePosition = ppTopCenter
    Status.Appearance.Fill.BorderColor = clBlack
    Status.Appearance.Fill.Rounding = 18
    Status.Appearance.Fill.ShadowOffset = 0
    Status.Appearance.Fill.Glow = gmNone
    Status.Appearance.Font.Charset = DEFAULT_CHARSET
    Status.Appearance.Font.Color = clBlack
    Status.Appearance.Font.Height = -23
    Status.Appearance.Font.Name = #47569#51008' '#44256#46357
    Status.Appearance.Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = AdultButtonClick
    TMSStyle = 0
  end
  object KidButton: TAdvSmoothToggleButton
    Left = 607
    Top = 328
    Width = 170
    Height = 98
    Color = 13789440
    BorderColor = 13789440
    BorderInnerColor = 13789440
    BevelWidth = 0
    Picture.Data = {
      89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
      F4000000097048597300000B1300000B1301009A9C18000003DC49444154789C
      EDD7598856651807F04F47D4A649B3A28820A542B09DA268A5200BB3A8284DB3
      A089B22828D18BBAA82828B28536CDB02EB402AD2CCB720A5A088A169349DB37
      9B32DA68A3552DB75F3CC3F3315FA773E6CC5D37BEF0F27D3CDBFB3FCFFB6C6F
      A351B2B01BEEC537F81BEFE0120C2A932FE80EC2C5588D0DF80A73B1739D6EEF
      C21EF8123D9889B371670259D0A83FFC8194BD237567A6ADCFB17B7FFABD0B8F
      E37D7414E8C7630B4E6FA5B7F08FC12A6CC671055E47DAFC05576270998D460A
      6EC45915FC6578B4847E4E7E75AC272B7427EB5B8F614899D05E29B05F8591D9
      78AD40DB27EF7A41EACEAED0DD3FF94BF06778A24C68FBFC92291546BAB0B840
      9B8335E1F63C607985EED4E4CFC70DF81E6D65828BF1094615E827636BFC16E8
      1F65904EC9FB0F9909059951F834F9CB71688239A40CC0AE29FC35AE4127EE4F
      E5B925F27F605DEE77713736A54E67DA085B1FE3D6E44530AA0AE826E2DB12C8
      4F71EF38AF42F6C80CB0C9CDD8C134BC8A1FF2E09B31022323C053F60C0C2F33
      381617E0AAC29E1588234E4A51F7E90FC749B8280B52EC336B6B00DA302F73FD
      3B741776B8773DBEC5F80A1B135237DCBC360B504F46FD5FB8AEB29AE246FC8A
      89FD80EC489071DF7B177807640DB91D3B147883716EEACDA84ABFDF7061BF6E
      EA2BB76FE1AE02FD093C57A31B65F9676C57E6BA4D11287500523E62624D2173
      E2EB4FA9D11B915E985664DC8215E9E27B30B4C2C061B82C7F63ED99F459191B
      43707085EE18EC8887F06291B9123761521A1E5D61E4EABCAA6199CB9D497F2F
      73FC840CE27FC540CB152D6C696A639A8C9159644ECCE2510720D611780A0FB6
      78631C1EC60B15BAE76736C4799FE1FA26E3B44C91F6ECD9B10ECC6254DC51C3
      259019396CC4E0F20676CAA634B502407B66D9745C8B2F7ADB7244335ECEAE36
      D0F552A69D3C34A6A5CB33C2FF5BDDFA4004D8D72376F21AC63772DC8A027169
      12639D9A0DA3B8E7B51CDA9EA5767DBA3546B039558727806613DA17CF635123
      D32782EFE99C68EA62A0276366621A790687A7DE41FD01481BABD3EB57C4E8D7
      8CCE8DB9A70F0040774E341B7276D892FF57D51DDE92B25BB31E2C0CC2D00CC4
      B119C9B116E1BE92BD32010CCB8E16AE3C2A3DF276854E710778597BDA8AE89A
      00BAD2D5D1C797B6045EE47B7749699E9FA356EC0FF163FEDF9CADBC3BBFB829
      F348645A997B9A004627DAA5196CB18E6D5E418D8BA3A9BD92FFD7652B8E96BC
      7620F7336E1B00DBAEE07F0EC25DB2B044698E19304A6F8C53D144E2851BA9D8
      5563237A423C3AA2B447C1898E194FBA15B500D2408C4DD1EBDF6C1938E2ED17
      75FF83BA729B43CDB3F83D1FBAF1C48F9A727499C23F943E307D5EC47FAA0000
      000049454E44AE426082}
    Appearance.PictureAlignment = taCenter
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -20
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
    Appearance.Layout = blPictureTop
    Appearance.Spacing = 0
    Appearance.SimpleLayout = True
    Caption = #50612#47536#51060
    Version = '1.5.1.1'
    Status.Visible = True
    Status.Caption = '0'#47749
    Status.Appearance.Fill.Color = clWhite
    Status.Appearance.Fill.ColorMirror = clNone
    Status.Appearance.Fill.ColorMirrorTo = clNone
    Status.Appearance.Fill.GradientType = gtSolid
    Status.Appearance.Fill.GradientMirrorType = gtSolid
    Status.Appearance.Fill.BorderColor = clBlack
    Status.Appearance.Fill.Rounding = 18
    Status.Appearance.Fill.ShadowOffset = 0
    Status.Appearance.Fill.Glow = gmNone
    Status.Appearance.Font.Charset = DEFAULT_CHARSET
    Status.Appearance.Font.Color = clBlack
    Status.Appearance.Font.Height = -23
    Status.Appearance.Font.Name = #47569#51008' '#44256#46357
    Status.Appearance.Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = AdultButtonClick
    TMSStyle = 0
  end
  object AuthCheckBox: TcxCheckBox
    Left = 292
    Top = 613
    Caption = ' '#44060#51064#51221#48372' '#54876#50857#50640' '#46041#51032#54633#45768#45796'.'
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -20
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 7
  end
  object ReflashTimer: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = ReflashTimerTimer
    Left = 472
    Top = 56
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 600
    Top = 96
  end
  object Tmr_Wait: TTimer
    Enabled = False
    OnTimer = Tmr_WaitTimer
    Left = 64
    Top = 204
  end
  object ApplicationEvents: TApplicationEvents
    OnMessage = ApplicationEventsMessage
    Left = 144
    Top = 208
  end
end
