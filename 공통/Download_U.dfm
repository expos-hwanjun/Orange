object Download_F: TDownload_F
  Left = 830
  Top = 290
  BorderStyle = bsNone
  Caption = 'Download_F'
  ClientHeight = 764
  ClientWidth = 430
  Color = clWhite
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object Shape1: TShape
    Left = 0
    Top = 1
    Width = 1
    Height = 762
    Align = alLeft
    Brush.Color = clBlack
    ExplicitHeight = 302
  end
  object Shape2: TShape
    Left = 0
    Top = 763
    Width = 430
    Height = 1
    Align = alBottom
    Brush.Color = clBlack
    ExplicitTop = 303
    ExplicitWidth = 436
  end
  object Shape3: TShape
    Left = 0
    Top = 0
    Width = 430
    Height = 1
    Align = alTop
    Brush.Color = clBlack
    ExplicitWidth = 436
  end
  object Shape4: TShape
    Left = 429
    Top = 1
    Width = 1
    Height = 762
    Align = alRight
    Brush.Color = clBlack
    ExplicitLeft = 435
    ExplicitHeight = 302
  end
  object Message2Label: TcxLabel
    Left = 63
    Top = 105
    Caption = #51648#44552' '#50629#45936#51060#53944#47484' '#48155#51004#49884#44192#49845#45768#44620'?'
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -21
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.TextStyle = []
    Style.IsFontAssigned = True
    Visible = False
  end
  object Message1Label: TcxLabel
    Left = 39
    Top = 59
    Caption = #49352#47213#44172' '#48148#45072' '#50629#45936#51060#53944#45236#50669#51060' '#51080#49845#45768#45796
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -21
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = [fsBold]
    Style.TextStyle = []
    Style.IsFontAssigned = True
    Visible = False
  end
  object UpdateButton: TAdvSmoothButton
    Left = 73
    Top = 178
    Width = 133
    Height = 56
    Cursor = crHandPoint
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
    Appearance.Rounding = 3
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
    Caption = #50696
    Color = 2368548
    ParentFont = False
    Picture.Data = {
      89504E470D0A1A0A0000000D494844520000001E0000001E08060000003B30AE
      A2000000097048597300000B1300000B1301009A9C180000011A49444154789C
      ED94B14A03411086AFD12EAD8A854F208804D2A5131F2069B4B2F30904DF44B4
      F42104FB58E645B4D662E71FF964EFD6CBE11148F4F640921F06969961BE6166
      778BE2BF0938020EFB86EE237D20BD037BFD81CD86B8539AD9700BCE26B6A3EE
      4B6C47DD97D88851136170B00C1CFFECCE9B403A2B21D22B211CFF0497BE18AB
      72CEBB0387708A64A9F01BEE5735389E2B5F8C59CCED0C1C85346DC0430DFE3E
      C798342D72086952C39B2639EE1759A04BE17D405BF00A7A59FCA990FB3566E3
      3577BEF24E311B970C69B270BACFD3D81E7ED1F7AA8DDEA7F5CC371BFC9C9C33
      CC46E56FD4AD8D707F498CA726F8B6F536F3D9CD020CBB4877E979E4014A9F48
      8FC04E7B0F30208493CE471D6BC220D7FD594B5F38796ADC2A171A0F00000000
      49454E44AE426082}
    Shadow = True
    DisabledColor = clWhite
    TabOrder = 4
    ShowFocus = False
    HorizontalSpacing = 0
    VerticalSpacing = 0
    Version = '2.2.2.0'
    OnClick = UpdateButtonClick
    TMSStyle = 8
  end
  object CancelButton: TAdvSmoothButton
    Left = 231
    Top = 178
    Width = 133
    Height = 56
    Cursor = crHandPoint
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
    Appearance.Rounding = 3
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
    Caption = #50500#45768#50724
    Color = 6908265
    ParentFont = False
    Shadow = True
    DisabledColor = clWhite
    TabOrder = 5
    ShowFocus = False
    HorizontalSpacing = 0
    VerticalSpacing = 0
    Version = '2.2.2.0'
    OnClick = CancelButtonClick
    TMSStyle = 8
  end
  object panPassWord: TPanel
    Left = 27
    Top = 99
    Width = 337
    Height = 489
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = clWhite
    Ctl3D = False
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 0
    Visible = False
    object Shape5: TShape
      Left = 56
      Top = 119
      Width = 225
      Height = 1
    end
    object edtPassword: TcxTextEdit
      Left = 58
      Top = 62
      ParentFont = False
      Properties.Alignment.Horz = taCenter
      Properties.PasswordChar = '*'
      Properties.ReadOnly = False
      Properties.ShowPasswordRevealButton = True
      Style.BorderStyle = ebsNone
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -33
      Style.Font.Name = #47569#51008' '#44256#46357
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 0
      OnKeyPress = edtPasswordKeyPress
      Width = 223
    end
    object Num_7: TAdvSmoothToggleButton
      Left = 46
      Top = 132
      Width = 80
      Height = 79
      RepeatInterval = 0
      Color = 1184274
      ColorDisabled = 16361472
      ColorDown = 16744448
      BorderColor = clNone
      BorderInnerColor = clNone
      BevelWidth = 0
      AutoToggle = False
      Appearance.PictureAlignment = taCenter
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -27
      Appearance.Font.Name = #47569#51008' '#44256#46357
      Appearance.Font.Style = []
      Appearance.ShiftDown = 0
      Appearance.SimpleLayout = True
      Appearance.ImageIndex = 3
      Appearance.Rounding = 37
      Caption = '7'
      Version = '1.7.2.2'
      Status.Caption = '10'
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
      ShowFocus = False
      ParentFont = False
      TabOrder = 1
      TabStop = False
      OnDblClick = Num_7Click
      OnClick = Num_7Click
      TMSStyle = 0
    end
    object Num_8: TAdvSmoothToggleButton
      Left = 131
      Top = 132
      Width = 80
      Height = 79
      RepeatInterval = 0
      Color = 1184274
      ColorDisabled = 16361472
      ColorDown = 16744448
      BorderColor = clNone
      BorderInnerColor = clNone
      BevelWidth = 0
      AutoToggle = False
      Appearance.PictureAlignment = taCenter
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -27
      Appearance.Font.Name = #47569#51008' '#44256#46357
      Appearance.Font.Style = []
      Appearance.ShiftDown = 0
      Appearance.SimpleLayout = True
      Appearance.ImageIndex = 3
      Appearance.Rounding = 37
      Caption = '8'
      Version = '1.7.2.2'
      Status.Caption = '10'
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
      ShowFocus = False
      ParentFont = False
      TabOrder = 2
      TabStop = False
      OnDblClick = Num_7Click
      OnClick = Num_7Click
      TMSStyle = 0
    end
    object Num_9: TAdvSmoothToggleButton
      Left = 214
      Top = 132
      Width = 80
      Height = 79
      RepeatInterval = 0
      Color = 1184274
      ColorDisabled = 16361472
      ColorDown = 16744448
      BorderColor = clNone
      BorderInnerColor = clNone
      BevelWidth = 0
      AutoToggle = False
      Appearance.PictureAlignment = taCenter
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -27
      Appearance.Font.Name = #47569#51008' '#44256#46357
      Appearance.Font.Style = []
      Appearance.ShiftDown = 0
      Appearance.SimpleLayout = True
      Appearance.ImageIndex = 3
      Appearance.Rounding = 37
      Caption = '9'
      Version = '1.7.2.2'
      Status.Caption = '10'
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
      ShowFocus = False
      ParentFont = False
      TabOrder = 3
      TabStop = False
      OnDblClick = Num_7Click
      OnClick = Num_7Click
      TMSStyle = 0
    end
    object Num_4: TAdvSmoothToggleButton
      Left = 46
      Top = 213
      Width = 80
      Height = 79
      RepeatInterval = 0
      Color = 1184274
      ColorDisabled = 16361472
      ColorDown = 16744448
      BorderColor = clNone
      BorderInnerColor = clNone
      BevelWidth = 0
      AutoToggle = False
      Appearance.PictureAlignment = taCenter
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -27
      Appearance.Font.Name = #47569#51008' '#44256#46357
      Appearance.Font.Style = []
      Appearance.ShiftDown = 0
      Appearance.SimpleLayout = True
      Appearance.ImageIndex = 3
      Appearance.Rounding = 37
      Caption = '4'
      Version = '1.7.2.2'
      Status.Caption = '10'
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
      ShowFocus = False
      ParentFont = False
      TabOrder = 4
      TabStop = False
      OnDblClick = Num_7Click
      OnClick = Num_7Click
      TMSStyle = 0
    end
    object Num_5: TAdvSmoothToggleButton
      Left = 131
      Top = 213
      Width = 80
      Height = 79
      RepeatInterval = 0
      Color = 1184274
      ColorDisabled = 16361472
      ColorDown = 16744448
      BorderColor = clNone
      BorderInnerColor = clNone
      BevelWidth = 0
      AutoToggle = False
      Appearance.PictureAlignment = taCenter
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -27
      Appearance.Font.Name = #47569#51008' '#44256#46357
      Appearance.Font.Style = []
      Appearance.ShiftDown = 0
      Appearance.SimpleLayout = True
      Appearance.ImageIndex = 3
      Appearance.Rounding = 37
      Caption = '5'
      Version = '1.7.2.2'
      Status.Caption = '10'
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
      ShowFocus = False
      ParentFont = False
      TabOrder = 5
      TabStop = False
      OnDblClick = Num_7Click
      OnClick = Num_7Click
      TMSStyle = 0
    end
    object Num_6: TAdvSmoothToggleButton
      Left = 214
      Top = 213
      Width = 80
      Height = 79
      RepeatInterval = 0
      Color = 1184274
      ColorDisabled = 16361472
      ColorDown = 16744448
      BorderColor = clNone
      BorderInnerColor = clNone
      BevelWidth = 0
      AutoToggle = False
      Appearance.PictureAlignment = taCenter
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -27
      Appearance.Font.Name = #47569#51008' '#44256#46357
      Appearance.Font.Style = []
      Appearance.ShiftDown = 0
      Appearance.SimpleLayout = True
      Appearance.ImageIndex = 3
      Appearance.Rounding = 37
      Caption = '6'
      Version = '1.7.2.2'
      Status.Caption = '10'
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
      ShowFocus = False
      ParentFont = False
      TabOrder = 6
      TabStop = False
      OnDblClick = Num_7Click
      OnClick = Num_7Click
      TMSStyle = 0
    end
    object Num_1: TAdvSmoothToggleButton
      Left = 46
      Top = 294
      Width = 80
      Height = 79
      RepeatInterval = 0
      Color = 1184274
      ColorDisabled = 16361472
      ColorDown = 16744448
      BorderColor = clNone
      BorderInnerColor = clNone
      BevelWidth = 0
      AutoToggle = False
      Appearance.PictureAlignment = taCenter
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -27
      Appearance.Font.Name = #47569#51008' '#44256#46357
      Appearance.Font.Style = []
      Appearance.ShiftDown = 0
      Appearance.SimpleLayout = True
      Appearance.ImageIndex = 3
      Appearance.Rounding = 37
      Caption = '1'
      Version = '1.7.2.2'
      Status.Caption = '10'
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
      ShowFocus = False
      ParentFont = False
      TabOrder = 7
      TabStop = False
      OnDblClick = Num_7Click
      OnClick = Num_7Click
      TMSStyle = 0
    end
    object Num_2: TAdvSmoothToggleButton
      Left = 131
      Top = 294
      Width = 80
      Height = 79
      RepeatInterval = 0
      Color = 1184274
      ColorDisabled = 16361472
      ColorDown = 16744448
      BorderColor = clNone
      BorderInnerColor = clNone
      BevelWidth = 0
      AutoToggle = False
      Appearance.PictureAlignment = taCenter
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -27
      Appearance.Font.Name = #47569#51008' '#44256#46357
      Appearance.Font.Style = []
      Appearance.ShiftDown = 0
      Appearance.SimpleLayout = True
      Appearance.ImageIndex = 3
      Appearance.Rounding = 37
      Caption = '2'
      Version = '1.7.2.2'
      Status.Caption = '10'
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
      ShowFocus = False
      ParentFont = False
      TabOrder = 8
      TabStop = False
      OnDblClick = Num_7Click
      OnClick = Num_7Click
      TMSStyle = 0
    end
    object Num_3: TAdvSmoothToggleButton
      Left = 214
      Top = 294
      Width = 80
      Height = 79
      RepeatInterval = 0
      Color = 1184274
      ColorDisabled = 16361472
      ColorDown = 16744448
      BorderColor = clNone
      BorderInnerColor = clNone
      BevelWidth = 0
      AutoToggle = False
      Appearance.PictureAlignment = taCenter
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -27
      Appearance.Font.Name = #47569#51008' '#44256#46357
      Appearance.Font.Style = []
      Appearance.ShiftDown = 0
      Appearance.SimpleLayout = True
      Appearance.ImageIndex = 3
      Appearance.Rounding = 37
      Caption = '3'
      Version = '1.7.2.2'
      Status.Caption = '10'
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
      ShowFocus = False
      ParentFont = False
      TabOrder = 9
      TabStop = False
      OnDblClick = Num_7Click
      OnClick = Num_7Click
      TMSStyle = 0
    end
    object Num_0: TAdvSmoothToggleButton
      Left = 46
      Top = 375
      Width = 80
      Height = 79
      RepeatInterval = 0
      Color = 1184274
      ColorDisabled = 16361472
      ColorDown = 16744448
      BorderColor = clNone
      BorderInnerColor = clNone
      BevelWidth = 0
      AutoToggle = False
      Appearance.PictureAlignment = taCenter
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -27
      Appearance.Font.Name = #47569#51008' '#44256#46357
      Appearance.Font.Style = []
      Appearance.ShiftDown = 0
      Appearance.SimpleLayout = True
      Appearance.ImageIndex = 3
      Appearance.Rounding = 37
      Caption = '0'
      Version = '1.7.2.2'
      Status.Caption = '10'
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
      ShowFocus = False
      ParentFont = False
      TabOrder = 10
      TabStop = False
      OnDblClick = Num_7Click
      OnClick = Num_7Click
      TMSStyle = 0
    end
    object Num_Enter: TAdvSmoothToggleButton
      Left = 214
      Top = 375
      Width = 80
      Height = 80
      RepeatInterval = 0
      Color = 1184274
      ColorDisabled = 16361472
      ColorDown = 16744448
      BorderColor = clNone
      BorderInnerColor = clNone
      BevelWidth = 0
      AutoToggle = False
      Appearance.PictureAlignment = taCenter
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -20
      Appearance.Font.Name = #47569#51008' '#44256#46357
      Appearance.Font.Style = [fsBold]
      Appearance.ShiftDown = 0
      Appearance.SimpleLayout = True
      Appearance.ImageIndex = 3
      Appearance.Rounding = 37
      Caption = #54869#51064
      Version = '1.7.2.2'
      Status.Caption = '10'
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
      ShowFocus = False
      ParentFont = False
      TabOrder = 11
      TabStop = False
      OnDblClick = Num_EnterClick
      OnClick = Num_EnterClick
      TMSStyle = 0
    end
    object Num_BS: TAdvSmoothToggleButton
      Left = 131
      Top = 375
      Width = 80
      Height = 79
      RepeatInterval = 0
      Color = 1184274
      ColorDisabled = 16361472
      ColorDown = 16744448
      BorderColor = clNone
      BorderInnerColor = clNone
      BevelWidth = 0
      AutoToggle = False
      Picture.Data = {
        89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
        F800000006624B474400FF00FF00FFA0BDA793000000FB494441544889ED943B
        4A43411885BF7B452301B5122CD2895616E20AAC5264052E412B9721580B828F
        1558259045A473011616064DA15DEACFE65E1842EE44983BD8E4543387F39F33
        CF1FD6F86F14CB487503384DF49E1545F1D11470079C039F090147C0C332F36B
        75A27613CC5177D59F4572A0BEA90729E681DF3C9C9CA953F5A441DC55CB05AE
        A36EAE0C507BEABBDA8F886FD4A73AA4321FAB97D10075477D55AF9A8495784B
        1DAACFEAB63AAAC665A4664EB58ADB98795050AF7A1AEE26161015B48112B800
        FA7F3922E005F8020E817DE071D52EEAE27C971C4CF23DD380C8F7D102B2AD56
        B1A77EE76C76C7C07DF6769DE8B1460BF8058BF01B72B14074E3000000004945
        4E44AE426082}
      Appearance.PictureAlignment = taCenter
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -24
      Appearance.Font.Name = #47569#51008' '#44256#46357
      Appearance.Font.Style = []
      Appearance.Layout = blPictureTop
      Appearance.ShiftDown = 0
      Appearance.SimpleLayout = True
      Appearance.ImageIndex = 3
      Appearance.Rounding = 37
      Version = '1.7.2.2'
      Status.Caption = '10'
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
      ShowFocus = False
      ParentFont = False
      TabOrder = 13
      TabStop = False
      OnDblClick = Num_BSClick
      OnClick = Num_BSClick
      TMSStyle = 0
    end
    object cxLabel3: TcxLabel
      Left = 8
      Top = 7
      Caption = #50629#45936#51060#53944' '#50516#54840#47484' '#51077#47141#54644#51452#49464#50836
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -20
      Style.Font.Name = #47569#51008' '#44256#46357
      Style.Font.Style = [fsBold]
      Style.TextStyle = []
      Style.IsFontAssigned = True
    end
    object CallCancelButton: TcxButton
      AlignWithMargins = True
      Left = 289
      Top = 2
      Width = 42
      Height = 38
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
        424D460E00000000000036000000280000001E0000001E000000010020000000
        000000000000C40E0000C40E0000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000808081C1F1F206B363637B63E3E41D7474748F3474748F33E3E
        41D7353537B51F1F206A0808081C000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000060606152B2B2C914A4A
        4CFB4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF49494BFD303031A207070819000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000001717174D464648F24B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF474749F11616174C00000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000002020
        216D49494BFD4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4949
        4BFD2020216D0000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000001515164949494BFC4B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF49494BFD1717
        174D000000000000000000000000000000000000000000000000000000000000
        0000000000000808081A464648F24B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF474749F1070708190000
        0000000000000000000000000000000000000000000000000000000000002E2E
        2F9B4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF2D2D2E9800000000000000000000
        0000000000000000000000000000000000000808081C49494BFC4B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF1212123C0F0F1034454545E94B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF454545E90F0F10341212123D4B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4A4A4CFB0808081C0000000000000000000000000000
        000000000000000000001F1F206B4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF0F0F0F33000000000D0D0D2C454545E94B4B4DFF4B4B4DFF4545
        45E90D0D0D2C000000000F0F10344B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF1F1F206A00000000000000000000000000000000000000000000
        0000363637B64B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4545
        45E90D0D0D2C000000000D0D0D2C454545E9454545E90D0D0D2C000000000D0D
        0D2C454545E94B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF3535
        37B5000000000000000000000000000000000000000000000000404042D94B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF454545E90D0D
        0D2C000000000D0D0D2C0D0D0D2C000000000D0D0D2C454545E94B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF404040D8000000000000
        000000000000000000000000000000000000464648F24B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF454547EA0D0D0E2D0000
        0000000000000C0C0C28444445E64B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF474749F10000000000000000000000000000
        00000000000000000000474748F34B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF454547EA0D0D0E2D00000000000000000C0C
        0C28444446E74B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF474748F300000000000000000000000000000000000000000000
        0000404042D94B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF454545E90D0D0D2C000000000D0D0D2C0D0D0D2C000000000D0D0D2C4545
        45E94B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4040
        40D8000000000000000000000000000000000000000000000000363637B64B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF454545E90D0D0D2C0000
        00000D0D0D2C454545E9454545E90D0D0D2C000000000D0D0D2C454545E94B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF353537B5000000000000
        0000000000000000000000000000000000002020216C4B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF0F0F0F33000000000D0D0D2C454545E94B4B
        4DFF4B4B4DFF454545E90D0D0D2C000000000F0F10344B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF1F1F206B0000000000000000000000000000
        000000000000000000000909091D49494BFC4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF1111123B0F0F1034454545E94B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF454545E90F0F0F331212123C4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF4A4A4CFB0808081C00000000000000000000000000000000000000000000
        0000000000002E2E2E9C4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF2D2D2E9A0000
        0000000000000000000000000000000000000000000000000000000000000808
        081B464648F24B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF464648F20808081A00000000000000000000
        0000000000000000000000000000000000000000000000000000151516494949
        4BFC4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF49494BFD1717184E00000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000002020216D49494BFD4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF49494BFD2020216D0000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000001717184E464648F24B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF464648F21717174D0000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000808081B2D2D2E994A4A4CFB4B4B4DFF4B4B
        4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF4B4B4DFF49494BFD3232
        33AA0909091F0000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000909091D2020216C363637B73E3E41D74848
        4AF448484AF43E3E41D7363637B71F1F206B0808081C00000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000}
      SpeedButtonOptions.CanBeFocused = False
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
      TabOrder = 14
      TabStop = False
      Font.Charset = HANGEUL_CHARSET
      Font.Color = clWhite
      Font.Height = -23
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = CallCancelButtonClick
    end
  end
  object WorkPanel: TPanel
    Left = 7
    Top = 247
    Width = 430
    Height = 257
    BevelOuter = bvNone
    BevelWidth = 2
    BorderStyle = bsSingle
    Color = clWhite
    Ctl3D = False
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 3
    object MessageLabel: TLabel
      Left = 11
      Top = 199
      Width = 403
      Height = 48
      Alignment = taCenter
      AutoSize = False
      Caption = #50629#45936#51060#53944' '#45236#50669#51012' '#54869#51064' '#51473' '#51077#45768#45796
      Font.Charset = HANGEUL_CHARSET
      Font.Color = 3750201
      Font.Height = -27
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object ActivityIndicator: TActivityIndicator
      Left = 181
      Top = 75
      Animate = True
      IndicatorSize = aisXLarge
      IndicatorType = aitSectorRing
    end
  end
  object CloseTimer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = CloseTimerTimer
    Left = 252
    Top = 2
  end
  object cxLookAndFeelController1: TcxLookAndFeelController
    Kind = lfOffice11
    Left = 335
    Top = 108
  end
  object IdHTTP: TIdHTTP
    OnWorkEnd = IdHTTPWorkEnd
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 167
    Top = 3
  end
  object StartTimer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = StartTimerTimer
    Left = 114
    Top = 5
  end
end
