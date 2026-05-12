inherited MemberAdd_F: TMemberAdd_F
  Left = 832
  Top = 264
  ActiveControl = MemberNameEdit
  Caption = 'MemberAdd_F'
  ClientHeight = 651
  ClientWidth = 531
  KeyPreview = True
  OldCreateOrder = True
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  ExplicitWidth = 531
  ExplicitHeight = 651
  PixelsPerInch = 96
  TextHeight = 15
  inherited CaptionLabel: TLabel
    Width = 161
    HelpType = htKeyword
    HelpKeyword = 'C'
    Caption = #54924#50896#46321#47197
    ExplicitWidth = 161
  end
  object Label1: TLabel [1]
    Left = 240
    Top = 198
    Width = 74
    Height = 19
    AutoSize = False
    Caption = '"-" '#50630#51060
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWhite
    Font.Height = -15
    Font.Name = #44404#47548#52404
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  inherited CloseButton: TcxButton
    Left = 470
    Top = 1
    TabOrder = 13
    ExplicitLeft = 470
    ExplicitTop = 1
  end
  object chkTrust: TcxCheckBox [3]
    Left = 112
    Top = 531
    Caption = ' '#50808#49345#44032#45733
    ParentFont = False
    Properties.NullStyle = nssUnchecked
    Style.Font.Charset = HANGEUL_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -17
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 7
    Transparent = True
  end
  object chkGender: TcxCheckBox [4]
    Left = 292
    Top = 108
    Caption = ' '#45224#51088
    ParentFont = False
    Properties.NullStyle = nssUnchecked
    Style.Font.Charset = HANGEUL_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -17
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 1
    Transparent = True
  end
  object MemberCodeLabel: TcxLabel [5]
    Left = 112
    Top = 70
    AutoSize = False
    ParentFont = False
    Style.BorderStyle = ebsOffice11
    Style.Font.Charset = HANGEUL_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -17
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taCenter
    Properties.Alignment.Vert = taVCenter
    Transparent = True
    Height = 34
    Width = 139
    AnchorX = 182
    AnchorY = 87
  end
  object MemberNameEdit: TcxTextEdit [6]
    Left = 112
    Top = 108
    OnFocusChanged = MemberNameEditFocusChanged
    AutoSize = False
    ParentFont = False
    Properties.ImeMode = imSHanguel
    Properties.MaxLength = 30
    Style.Font.Charset = HANGEUL_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -17
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    StyleFocused.Color = clYellow
    TabOrder = 0
    OnExit = MemberNameEditExit
    Height = 33
    Width = 173
  end
  object CardNoEdit: TcxTextEdit [7]
    Left = 112
    Top = 185
    OnFocusChanged = MemberNameEditFocusChanged
    AutoSize = False
    ParentFont = False
    Properties.ImeMode = imDisable
    Properties.MaxLength = 20
    Style.Font.Charset = HANGEUL_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -17
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    StyleFocused.Color = clYellow
    TabOrder = 3
    OnExit = CardNoEditExit
    Height = 33
    Width = 247
  end
  object MobileEdit: TcxTextEdit [8]
    Left = 112
    Top = 223
    OnFocusChanged = MemberNameEditFocusChanged
    AutoSize = False
    ParentFont = False
    Properties.ImeMode = imDisable
    Properties.MaxLength = 13
    Style.Font.Charset = HANGEUL_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -17
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    StyleFocused.Color = clYellow
    TabOrder = 4
    OnExit = MobileEditExit
    Height = 33
    Width = 138
  end
  object RemarkMemo: TcxMemo [9]
    Left = 112
    Top = 454
    OnFocusChanged = MemberNameEditFocusChanged
    ParentFont = False
    Properties.ImeMode = imSHanguel
    Properties.MaxLength = 300
    Style.Font.Charset = HANGEUL_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -15
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.IsFontAssigned = True
    StyleFocused.Color = clYellow
    TabOrder = 8
    OnEnter = RemarkMemoEnter
    Height = 73
    Width = 361
  end
  object MemberClassComboBox: TcxComboBox [10]
    Left = 112
    Top = 146
    AutoSize = False
    ParentFont = False
    Properties.DropDownListStyle = lsFixedList
    Style.Font.Charset = HANGEUL_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -17
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 2
    Height = 33
    Width = 247
  end
  object HomeTelEdit: TcxTextEdit [11]
    Left = 112
    Top = 262
    OnFocusChanged = MemberNameEditFocusChanged
    AutoSize = False
    ParentFont = False
    Properties.ImeMode = imDisable
    Properties.MaxLength = 13
    Style.Font.Charset = HANGEUL_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -17
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    StyleFocused.Color = clYellow
    TabOrder = 6
    OnExit = MobileEditExit
    Height = 33
    Width = 138
  end
  object edt_Addr1: TcxTextEdit [12]
    Left = 112
    Top = 300
    OnFocusChanged = MemberNameEditFocusChanged
    AutoSize = False
    ParentFont = False
    Properties.ImeMode = imSHanguel
    Properties.MaxLength = 40
    Style.Font.Charset = HANGEUL_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -17
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    StyleFocused.Color = clYellow
    TabOrder = 9
    Height = 33
    Width = 361
  end
  object edt_Addr2: TcxTextEdit [13]
    Left = 112
    Top = 339
    OnFocusChanged = MemberNameEditFocusChanged
    AutoSize = False
    ParentFont = False
    Properties.ImeMode = imSHanguel
    Properties.MaxLength = 40
    Style.Font.Charset = HANGEUL_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -17
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    StyleFocused.Color = clYellow
    TabOrder = 10
    OnEnter = edt_Addr2Enter
    Height = 33
    Width = 361
  end
  object edt_Birthday: TcxMaskEdit [14]
    Left = 112
    Top = 377
    OnFocusChanged = MemberNameEditFocusChanged
    AutoSize = False
    ParentFont = False
    Properties.Alignment.Horz = taCenter
    Properties.ImeMode = imDisable
    Properties.EditMask = '0000\-00\-00;1;_'
    Properties.MaxLength = 0
    Style.Font.Charset = HANGEUL_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -17
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 11
    Text = '    -  -  '
    Height = 31
    Width = 121
  end
  object chklunar: TcxCheckBox [15]
    Left = 239
    Top = 378
    OnFocusChanged = MemberNameEditFocusChanged
    Caption = ' '#51020#47141
    ParentFont = False
    Properties.NullStyle = nssUnchecked
    Style.Font.Charset = HANGEUL_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -17
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 12
    Transparent = True
  end
  object chkSms: TcxCheckBox [16]
    Left = 292
    Top = 531
    Caption = ' '#47928#51088#49688#49888
    ParentFont = False
    Properties.NullStyle = nssUnchecked
    State = cbsChecked
    Style.Font.Charset = HANGEUL_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -17
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 5
    Transparent = True
  end
  object edt_CashRcpNo: TcxTextEdit [17]
    Left = 112
    Top = 416
    OnFocusChanged = MemberNameEditFocusChanged
    AutoSize = False
    ParentFont = False
    Properties.ImeMode = imDisable
    Properties.MaxLength = 20
    Style.Font.Charset = HANGEUL_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -17
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    StyleFocused.Color = clYellow
    TabOrder = 14
    OnExit = CardNoEditExit
    Height = 33
    Width = 247
  end
  object lblMenuCode: TcxLabel [18]
    Left = 31
    Top = 76
    HelpType = htKeyword
    HelpKeyword = 'C'
    Caption = #54924#50896#48264#54840
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -16
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Transparent = True
  end
  object lblMenuName: TcxLabel [19]
    Left = 31
    Top = 113
    HelpType = htKeyword
    HelpKeyword = 'C'
    Caption = #54924#50896#51060#47492
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -16
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Transparent = True
  end
  object lblSalePrice: TcxLabel [20]
    Left = 31
    Top = 150
    HelpType = htKeyword
    HelpKeyword = 'C'
    Caption = #54924#50896#44396#48516
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -16
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Transparent = True
  end
  object lblMenuClass: TcxLabel [21]
    Left = 31
    Top = 191
    HelpType = htKeyword
    HelpKeyword = 'C'
    Caption = #52852#46300#48264#54840
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -16
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Transparent = True
  end
  object cxLabel1: TcxLabel [22]
    Left = 31
    Top = 227
    HelpType = htKeyword
    HelpKeyword = 'C'
    Caption = #55092#45824#51204#54868
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -16
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Transparent = True
  end
  object cxLabel2: TcxLabel [23]
    Left = 31
    Top = 266
    HelpType = htKeyword
    HelpKeyword = 'C'
    Caption = #51088#53469#51204#54868
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -16
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Transparent = True
  end
  object cxLabel3: TcxLabel [24]
    Left = 31
    Top = 418
    HelpType = htKeyword
    HelpKeyword = 'C'
    Caption = #49885#48324#48264#54840
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -16
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Transparent = True
  end
  object cxLabel4: TcxLabel [25]
    Left = 31
    Top = 380
    HelpType = htKeyword
    HelpKeyword = 'C'
    Caption = #49373#45380#50900#51068
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -16
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Transparent = True
  end
  object PostButton: TAdvGlassButton [26]
    Left = 30
    Top = 300
    Width = 69
    Height = 33
    HelpType = htKeyword
    HelpKeyword = 'C'
    BackColor = 5844224
    Caption = #51452#49548
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -15
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = []
    ForeColor = clWhite
    GlowColor = 6160384
    ImageIndex = -1
    InnerBorderColor = 6160384
    OuterBorderColor = clWhite
    Picture.Data = {
      89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
      0D00000006624B474400FF00FF00FFA0BDA7930000019749444154388DB594BD
      4B02611CC7BF779EA767665A18A4080EBD4118412DDD56AD8D2D1259E0100DF9
      37B8B447041511545B353434D5144142350861903628F6262A6665DE79DE4B43
      50A687A057DFF1CBEFF93C9FE7E1E101FE3804002C6C5DAF3034C968017182CC
      ADF907031400787A5D332463B16A01CADC5B1E4080D402510B050010797EB8AB
      4D13E82AC6F33FC032CF8F38086DC09B2FE09F1FF99FEEB022894C116EBB09B7
      4F0584EE727517B33DEDE87798EB03DD761300A0DF61AE19AE9758AA60D16458
      6D37E1B1EB97B518EE9E3F60FF22055A4F4228CB301B757453866C4F3B2EE379
      D07A1ABE71E7771F8AA60D731BD7AB4D19EE5DA4305B010300B6AF1391E4ABAF
      214346AF83977582A175AA1BB5D294B129434E9054FB7741E41B7ED892ACE085
      13955034F3AB0F4533CA73AEB45B63582FA2A460E928AEB475D8711C7E4CDC24
      F31D265A67FC10243E95E376B6E787160900F06F86B70D146954831405D96635
      51DDDE5167E9309C75596C9D2D91D8FDC9533A3B791A1C13ABE71BFA62A6D723
      670A817CF999983A080E086A339F5E16A57DA7084D650000000049454E44AE42
      6082}
    ParentFont = False
    ShineColor = 5844224
    TabOrder = 15
    Version = '1.3.3.0'
    OnClick = PostButtonClick
  end
  object cxLabel5: TcxLabel [27]
    Left = 31
    Top = 454
    HelpType = htKeyword
    HelpKeyword = 'C'
    Caption = #53945#51060#49324#54637
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -16
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Transparent = True
  end
  inherited KeyBoardButton: TAdvSmoothButton
    Left = 409
    Top = 70
    Width = 114
    Height = 51
    HelpType = htKeyword
    HelpKeyword = 'C'
    Appearance.Font.Height = -17
    TabOrder = 26
    ExplicitLeft = 409
    ExplicitTop = 70
    ExplicitWidth = 114
    ExplicitHeight = 51
    TMSStyle = 8
  end
  object SaveButton: TAdvSmoothButton
    Left = 208
    Top = 577
    Width = 151
    Height = 59
    Cursor = crHandPoint
    HelpType = htKeyword
    Appearance.PictureAlignment = taCenter
    Appearance.PictureStretchMode = pmStretch
    Appearance.Font.Charset = HANGEUL_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -21
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
    Caption = #51200#51109
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
    TabOrder = 27
    TabStop = False
    ShowFocus = False
    HorizontalSpacing = 0
    VerticalSpacing = 0
    Version = '2.2.2.0'
    OnClick = SaveButtonClick
    TMSStyle = 8
  end
  object PinPadButton: TAdvGlassButton
    Left = 256
    Top = 222
    Width = 103
    Height = 38
    HelpType = htKeyword
    HelpKeyword = 'C'
    BackColor = 5844224
    Caption = #44256#44061#51077#47141
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -15
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = []
    ForeColor = clWhite
    GlowColor = 6160384
    ImageIndex = -1
    InnerBorderColor = 6160384
    OuterBorderColor = clWhite
    ParentFont = False
    ShineColor = 5844224
    TabOrder = 28
    Version = '1.3.3.0'
    OnClick = PinPadButtonClick
  end
end
