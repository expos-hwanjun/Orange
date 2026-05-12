object DualOrder480_F: TDualOrder480_F
  Left = 310
  Top = 427
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsNone
  Caption = 'DualOrder480_F'
  ClientHeight = 481
  ClientWidth = 798
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = HANGEUL_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #44404#47548#52404
  Font.Style = []
  FormStyle = fsMDIForm
  KeyPreview = True
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Dual_sGrd: TStringGrid
    Left = 7
    Top = 29
    Width = 472
    Height = 441
    BorderStyle = bsNone
    Color = clWhite
    Ctl3D = False
    DefaultRowHeight = 44
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = [fsBold]
    Options = [goRowSelect]
    ParentCtl3D = False
    ParentFont = False
    ScrollBars = ssNone
    TabOrder = 0
  end
  object CurrencyEdit1: TcxCurrencyEdit
    Left = 611
    Top = 286
    AutoSize = False
    EditValue = 0.000000000000000000
    ParentFont = False
    Properties.Alignment.Horz = taRightJustify
    Properties.Alignment.Vert = taVCenter
    Properties.DisplayFormat = ',0'
    Style.BorderStyle = ebsNone
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -29
    Style.Font.Name = #48148#53461
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    TabOrder = 1
    Height = 34
    Width = 178
  end
  object CurrencyEdit3: TcxCurrencyEdit
    Left = 610
    Top = 382
    AutoSize = False
    EditValue = 0.000000000000000000
    ParentFont = False
    Properties.Alignment.Horz = taRightJustify
    Properties.Alignment.Vert = taVCenter
    Properties.DisplayFormat = ',0'
    Style.BorderStyle = ebsNone
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -29
    Style.Font.Name = #48148#53461
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    TabOrder = 2
    Height = 35
    Width = 179
  end
  object CurrencyEdit2: TcxCurrencyEdit
    Left = 610
    Top = 334
    AutoSize = False
    EditValue = 0.000000000000000000
    ParentFont = False
    Properties.Alignment.Horz = taRightJustify
    Properties.Alignment.Vert = taVCenter
    Properties.DisplayFormat = ',0'
    Style.BorderStyle = ebsNone
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clRed
    Style.Font.Height = -29
    Style.Font.Name = #48148#53461
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    TabOrder = 3
    Height = 35
    Width = 179
  end
  object Panel1: TPanel
    Left = 485
    Top = 8
    Width = 307
    Height = 262
    BevelOuter = bvNone
    TabOrder = 4
    object Swf: TShockwaveFlash
      Left = 0
      Top = 0
      Width = 307
      Height = 262
      Align = alClient
      TabOrder = 0
      ControlData = {
        6755665500090000BB1F0000141B000008000200000000000800040000002000
        00000800040000002000000008000E000000570069006E0064006F0077000000
        0800060000002D00310000000800060000002D003100000008000A0000004800
        690067006800000008000200000000000800060000002D003100000008000000
        000008000200000000000800120000004E006F0042006F007200640065007200
        0000080004000000300000000800040000003000000008000200000000000800
        0000000008000200000000000D00000000000000000000000000000000000800
        0400000031000000080004000000300000000800000000000800040000003000
        000008000800000061006C006C00000008000C000000660061006C0073006500
        000008000C000000660061006C00730065000000080004000000300000000800
        0C0000007300630061006C0065000000}
    end
  end
  object panNews: TcxGroupBox
    Left = 8
    Top = 428
    Alignment = alCenterCenter
    PanelStyle.Active = True
    PanelStyle.CaptionIndent = 3
    ParentFont = False
    Style.BorderColor = clHighlight
    Style.BorderStyle = ebsOffice11
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWhite
    Style.Font.Height = -15
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.TextColor = clWhite
    Style.IsFontAssigned = True
    StyleDisabled.BorderColor = clBlue
    StyleDisabled.BorderStyle = ebsOffice11
    TabOrder = 5
    Transparent = True
    Height = 45
    Width = 469
    object lblName: TcxLabel
      Left = 3
      Top = 2
      AutoSize = False
      ParentFont = False
      Style.Font.Charset = HANGEUL_CHARSET
      Style.Font.Color = clBlue
      Style.Font.Height = -20
      Style.Font.Name = #47569#51008#44256#46357
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      Transparent = True
      Height = 25
      Width = 294
    end
    object lblAddr: TcxLabel
      Left = 3
      Top = 25
      AutoSize = False
      ParentFont = False
      Style.Font.Charset = HANGEUL_CHARSET
      Style.Font.Color = clBlue
      Style.Font.Height = -13
      Style.Font.Name = #47569#51008#44256#46357
      Style.Font.Style = [fsBold]
      Style.TextColor = 4227327
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taRightJustify
      Transparent = True
      Height = 19
      Width = 462
      AnchorX = 465
    end
  end
  object panScale: TcxGroupBox
    Left = 51
    Top = -4
    Alignment = alCenterCenter
    PanelStyle.Active = True
    PanelStyle.CaptionIndent = 3
    ParentColor = False
    ParentFont = False
    Style.BorderColor = 15504960
    Style.BorderStyle = ebsOffice11
    Style.Color = clWhite
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWhite
    Style.Font.Height = -15
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.TextColor = clWhite
    Style.IsFontAssigned = True
    StyleDisabled.BorderColor = clBlue
    StyleDisabled.BorderStyle = ebsOffice11
    TabOrder = 6
    Visible = False
    Height = 467
    Width = 474
    object imgDualScale: TImage
      Left = 8
      Top = 9
      Width = 457
      Height = 451
    end
    object lblPincode: TcxLabel
      Left = 186
      Top = 213
      AutoSize = False
      ParentColor = False
      ParentFont = False
      Style.BorderStyle = ebsNone
      Style.Color = clWhite
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clRed
      Style.Font.Height = -25
      Style.Font.Name = #44404#47548#52404
      Style.Font.Style = [fsBold]
      Style.TextColor = 1401599
      Style.TextStyle = []
      Style.IsFontAssigned = True
      StyleDisabled.BorderColor = clBlack
      StyleDisabled.BorderStyle = ebsOffice11
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Properties.LabelStyle = cxlsRaised
      Transparent = True
      Height = 31
      Width = 276
      AnchorY = 229
    end
    object lblGrade: TcxLabel
      Left = 186
      Top = 293
      AutoSize = False
      ParentColor = False
      ParentFont = False
      Style.BorderStyle = ebsNone
      Style.Color = clWhite
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clRed
      Style.Font.Height = -25
      Style.Font.Name = #44404#47548#52404
      Style.Font.Style = [fsBold]
      Style.TextColor = 1401599
      Style.TextStyle = []
      Style.IsFontAssigned = True
      StyleDisabled.BorderColor = clBlack
      StyleDisabled.BorderStyle = ebsOffice11
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Properties.LabelStyle = cxlsRaised
      Transparent = True
      Height = 31
      Width = 276
      AnchorY = 309
    end
    object lblOrigin: TcxLabel
      Left = 186
      Top = 253
      AutoSize = False
      ParentColor = False
      ParentFont = False
      Style.BorderStyle = ebsNone
      Style.Color = clWhite
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clRed
      Style.Font.Height = -25
      Style.Font.Name = #44404#47548#52404
      Style.Font.Style = [fsBold]
      Style.TextColor = 1401599
      Style.TextStyle = []
      Style.IsFontAssigned = True
      StyleDisabled.BorderColor = clBlack
      StyleDisabled.BorderStyle = ebsOffice11
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Properties.LabelStyle = cxlsRaised
      Transparent = True
      Height = 31
      Width = 276
      AnchorY = 269
    end
    object lblButcheryDay: TcxLabel
      Left = 186
      Top = 373
      AutoSize = False
      ParentColor = False
      ParentFont = False
      Style.BorderStyle = ebsNone
      Style.Color = clWhite
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clRed
      Style.Font.Height = -25
      Style.Font.Name = #44404#47548#52404
      Style.Font.Style = [fsBold]
      Style.TextColor = 1401599
      Style.TextStyle = []
      Style.IsFontAssigned = True
      StyleDisabled.BorderColor = clBlack
      StyleDisabled.BorderStyle = ebsOffice11
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Properties.LabelStyle = cxlsRaised
      Transparent = True
      Height = 31
      Width = 267
      AnchorY = 389
    end
    object lblPrice: TcxLabel
      Left = 186
      Top = 333
      AutoSize = False
      ParentColor = False
      ParentFont = False
      Style.BorderStyle = ebsNone
      Style.Color = clWhite
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clRed
      Style.Font.Height = -25
      Style.Font.Name = #44404#47548#52404
      Style.Font.Style = [fsBold]
      Style.TextColor = 1401599
      Style.TextStyle = []
      Style.IsFontAssigned = True
      StyleDisabled.BorderColor = clBlack
      StyleDisabled.BorderStyle = ebsOffice11
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Properties.LabelStyle = cxlsRaised
      Transparent = True
      Height = 31
      Width = 276
      AnchorY = 349
    end
    object lblKeep: TcxLabel
      Left = 186
      Top = 413
      AutoSize = False
      ParentColor = False
      ParentFont = False
      Style.BorderStyle = ebsNone
      Style.Color = clWhite
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clRed
      Style.Font.Height = -25
      Style.Font.Name = #44404#47548#52404
      Style.Font.Style = [fsBold]
      Style.TextColor = 1401599
      Style.TextStyle = []
      Style.IsFontAssigned = True
      StyleDisabled.BorderColor = clBlack
      StyleDisabled.BorderStyle = ebsOffice11
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Properties.LabelStyle = cxlsRaised
      Transparent = True
      Height = 31
      Width = 276
      AnchorY = 429
    end
    object lblMenuName: TcxLabel
      Left = 108
      Top = 35
      AutoSize = False
      ParentColor = False
      ParentFont = False
      Style.BorderColor = clWhite
      Style.BorderStyle = ebsOffice11
      Style.Color = clWhite
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = 2124031
      Style.Font.Height = -28
      Style.Font.Name = #44404#47548#52404
      Style.Font.Style = [fsBold]
      Style.Shadow = False
      Style.TextColor = clBlack
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Properties.LabelStyle = cxlsRaised
      Height = 42
      Width = 327
      AnchorY = 56
    end
    object lblAmt: TcxLabel
      Left = 108
      Top = 91
      AutoSize = False
      ParentColor = False
      ParentFont = False
      Style.BorderColor = clWhite
      Style.BorderStyle = ebsOffice11
      Style.Color = clWhite
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = 1401599
      Style.Font.Height = -33
      Style.Font.Name = #44404#47548#52404
      Style.Font.Style = [fsBold]
      Style.Shadow = False
      Style.TextColor = clBlack
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Properties.LabelStyle = cxlsRaised
      Height = 42
      Width = 195
      AnchorX = 303
      AnchorY = 112
    end
    object lblWeight: TcxLabel
      Left = 108
      Top = 146
      AutoSize = False
      ParentColor = False
      ParentFont = False
      Style.BorderColor = clWhite
      Style.BorderStyle = ebsOffice11
      Style.Color = clWhite
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = 1401599
      Style.Font.Height = -33
      Style.Font.Name = #44404#47548#52404
      Style.Font.Style = [fsBold]
      Style.Shadow = False
      Style.TextColor = clBlack
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Properties.LabelStyle = cxlsRaised
      Height = 42
      Width = 195
      AnchorX = 303
      AnchorY = 167
    end
  end
  object Swf_Tmr: TTimer
    Interval = 10
    OnTimer = Swf_TmrTimer
    Left = 456
    Top = 432
  end
  object ImgList: TImageList
    Left = 488
    Top = 280
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
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
      C0000000A8000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005863
      6B00383A3D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BFC1BB000000
      C0004040FF000000C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C4C5C0005E63
      6700778792000D0D0E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BFC1BB00D6D6D600BFC1
      BB000000C0000000C00000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C3C6C100DAD9D500BDBA
      B70052565A00535A600000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BFC1BB00D6D6D600E7E2DE00F7F7
      F700DEDED6000000800000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BFC2BD00D9D7D300E5E2DE00F6F4
      F100E0DDD9000606060000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BFC1BB00D6D6D600E7E2DE00F7F7F700DEDE
      D600000080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BDC0BA00D7D6D200E3E1DD00F6F4F100E0DD
      D900060606000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BFC1BB00D6D6D600DEDEDE00F0EDEA00DEDED6000000
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BCBEB900D5D4D000E2DFDB00F4F2F000E0DDD9000606
      0600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BFC1BB00D6D6D600DEDED600F0EDEA00DEDED600000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BBBCB700D3D2CE00E0DEDA00F2F0ED00E0DDD900060606000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BFC1BB00CCCEC900DEDED600F7F7F700DEDED60000008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B7B8B400D0D0CB00DFDCD800F6F4F100E0DDD90006060600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BFC1
      BB00CCCEC900DEDED600F7F7F700DEDED6000000800000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B1B3
      AF00CCCDC800DDDBD700F6F4F100E0DDD9000606060000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BFC1BB00CCCE
      C900DED6D600F7F7F700DEDED600000080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000AAAEAA00C7C9
      C400DCDAD600F6F4F100E0DDD900060606000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BFC1BB00BFC1BB00D6D6
      D600F7F7F700DEDED60000008000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000898C8900C2C5C000DAD8
      D400F6F4F100E0DDD90006060600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000C0004040FF00D6D6D600F7F7
      F700DEDED6000000800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005B5B5B0066676500D8D7D300F6F4
      F100E0DDD9000606060000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000C8000000C8004040FF00DEDE
      D600000080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002B2B2B00060606009C9B9800E0DD
      D900060606000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000C8000000C8000000C0000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000606060000000000494949000606
      0600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000800000008000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000606060006060600060606000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFE7FFE700000000
      FFC3FFC300000000FF83FF8300000000FF03FF0300000000FE07FE0700000000
      FC0FFC0F00000000F81FF81F00000000F03FF03F00000000E07FE07F00000000
      C0FFC0FF0000000081FF81FF0000000003FF03FF0000000007FF07FF00000000
      0FFF0FFF000000001FFF1FFF0000000000000000000000000000000000000000
      000000000000}
  end
end
