object DualSign_F: TDualSign_F
  Left = 520
  Top = 65
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'DualSign_F'
  ClientHeight = 466
  ClientWidth = 466
  Color = clWhite
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #44404#47548#52404
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  object ImgScreen: TcxImage
    Left = 1
    Top = 48
    Properties.Stretch = True
    Style.Color = clWhite
    Style.TransparentBorder = False
    TabOrder = 3
    OnMouseDown = ImgScreenMouseDown
    OnMouseMove = ImgScreenMouseMove
    Height = 417
    Width = 464
  end
  object lblSign: TcxLabel
    Left = 56
    Top = 235
    Caption = #50668#44592#50640' '#49436#47749#54644#51452#49464#50836'...'
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -31
    Style.Font.Name = #44404#47548#52404
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Transparent = True
    Visible = False
  end
  inline fmKeyPad: TfmKeyPad
    Left = 188
    Top = 147
    Width = 269
    Height = 307
    TabOrder = 0
    Visible = False
    inherited Img_KeyPad: TImage
      Width = 269
      Height = 307
    end
    inherited Num_Enter: TOXSpeedButton
      OnClick = fmKeyPadNum_EnterClick
    end
  end
  object edt_Input: TcxTextEdit
    Left = 188
    Top = 95
    AutoSize = False
    ParentFont = False
    Properties.Alignment.Horz = taLeftJustify
    Properties.Alignment.Vert = taVCenter
    Properties.OnChange = edt_InputPropertiesChange
    Style.Font.Charset = HANGEUL_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -28
    Style.Font.Name = #44404#47548#52404
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    StyleFocused.Color = clYellow
    TabOrder = 1
    Visible = False
    Height = 40
    Width = 270
  end
  object lblAmt: TcxLabel
    Left = 8
    Top = 8
    Caption = #49849#51064#44552#50529
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -31
    Style.Font.Name = #44404#47548#52404
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Transparent = True
  end
  object Tmr_End: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = Tmr_EndTimer
    Left = 112
    Top = 272
  end
end
