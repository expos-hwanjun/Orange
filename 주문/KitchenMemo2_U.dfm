inherited KitchenMemo2_F: TKitchenMemo2_F
  Left = 483
  Top = 208
  Caption = #51452#47581#47700#47784
  ClientHeight = 600
  ClientWidth = 800
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 15
  inherited lbl_Mode: TLabel
    Left = 672
    Top = 118
    Font.Color = clRed
    ExplicitLeft = 672
    ExplicitTop = 118
  end
  object obtn_Prev: TOXSpeedButton [2]
    Left = 410
    Top = 58
    Width = 36
    Height = 121
    Flat = True
    Title.Font.Charset = DEFAULT_CHARSET
    Title.Font.Color = clBlack
    Title.Font.Height = -11
    Title.Font.Name = #44404#47548#52404
    Title.Font.Style = []
    Number = 0
    Bottom.Top = 20
    Bottom.Font.Charset = DEFAULT_CHARSET
    Bottom.Font.Color = clWindowText
    Bottom.Font.Height = -11
    Bottom.Font.Name = #44404#47548#52404
    Bottom.Font.Style = []
    Lapse = 0
    IsWork = False
    OnClick = obtn_PrevClick
    DrawFrame = False
  end
  object obtn_Next: TOXSpeedButton [3]
    Left = 410
    Top = 180
    Width = 36
    Height = 121
    Flat = True
    Title.Font.Charset = DEFAULT_CHARSET
    Title.Font.Color = clBlack
    Title.Font.Height = -11
    Title.Font.Name = #44404#47548#52404
    Title.Font.Style = []
    Number = 0
    Bottom.Top = 20
    Bottom.Font.Charset = DEFAULT_CHARSET
    Bottom.Font.Color = clWindowText
    Bottom.Font.Height = -11
    Bottom.Font.Name = #44404#47548#52404
    Bottom.Font.Style = []
    Lapse = 0
    IsWork = False
    OnClick = obtn_PrevClick
    DrawFrame = False
  end
  object obtn_confirm: TOXSpeedButton [4]
    Left = 580
    Top = 250
    Width = 95
    Height = 49
    Hint = 'GIF'
    Flat = True
    Title.Font.Charset = DEFAULT_CHARSET
    Title.Font.Color = clBlack
    Title.Font.Height = -11
    Title.Font.Name = #44404#47548#52404
    Title.Font.Style = []
    Number = 0
    Bottom.Top = 20
    Bottom.Font.Charset = DEFAULT_CHARSET
    Bottom.Font.Color = clWindowText
    Bottom.Font.Height = -11
    Bottom.Font.Name = #44404#47548#52404
    Bottom.Font.Style = []
    Lapse = 0
    IsWork = False
    OnClick = obtn_confirmClick
    DrawFrame = False
  end
  object obtn_close: TOXSpeedButton [5]
    Left = 736
    Top = 5
    Width = 58
    Height = 47
    Cursor = crHandPoint
    Hint = 'JPG'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Title.Font.Charset = DEFAULT_CHARSET
    Title.Font.Color = clBlack
    Title.Font.Height = -11
    Title.Font.Name = #44404#47548#52404
    Title.Font.Style = []
    Number = 0
    Bottom.Top = 20
    Bottom.Font.Charset = DEFAULT_CHARSET
    Bottom.Font.Color = clWindowText
    Bottom.Font.Height = -11
    Bottom.Font.Name = #44404#47548#52404
    Bottom.Font.Style = []
    Lapse = 0
    IsWork = False
    OnClick = obtn_closeClick
    DrawFrame = False
  end
  object lblTitle: TLabel [6]
    Left = 112
    Top = 16
    Width = 169
    Height = 31
    AutoSize = False
    Caption = #51452#48169#47700#47784
    Font.Charset = HANGEUL_CHARSET
    Font.Color = 15246443
    Font.Height = -31
    Font.Name = #55092#47676#47784#51020'T'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object sgr_Grid: TStringGrid [8]
    Left = 5
    Top = 87
    Width = 400
    Height = 215
    TabStop = False
    ColCount = 2
    Ctl3D = False
    DefaultRowHeight = 30
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #44404#47548
    Font.Style = [fsBold]
    Options = [goRowSelect]
    ParentCtl3D = False
    ParentFont = False
    ScrollBars = ssNone
    TabOrder = 0
    OnClick = sgr_GridClick
    OnDrawCell = sgr_GridDrawCell
    ColWidths = (
      64
      64)
    RowHeights = (
      30)
  end
  object meo_Memo: TcxMemo [9]
    Left = 497
    Top = 186
    ImeMode = imSHanguel
    Properties.ImeMode = imSHanguel
    Style.BorderColor = clBlack
    Style.BorderStyle = ebsNone
    TabOrder = 1
    Height = 57
    Width = 264
  end
end
