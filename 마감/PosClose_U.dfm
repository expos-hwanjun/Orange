object PosClose_F: TPosClose_F
  Left = 246
  Top = 180
  Hint = 'Logo'
  BorderStyle = bsNone
  Caption = 'PosClose_F'
  ClientHeight = 550
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = HANGEUL_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #44404#47548#52404
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object lbl_Cash: TLabel
    Left = 152
    Top = 163
    Width = 122
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    Caption = '0'
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #44404#47548#52404
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lbl_Check: TLabel
    Left = 152
    Top = 202
    Width = 122
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    Caption = '0'
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #44404#47548#52404
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lbl_Card: TLabel
    Left = 152
    Top = 242
    Width = 122
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    Caption = '0'
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #44404#47548#52404
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lbl_Point: TLabel
    Left = 152
    Top = 321
    Width = 122
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    Caption = '0'
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #44404#47548#52404
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lbl_Sale: TLabel
    Left = 152
    Top = 441
    Width = 122
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    Caption = '0'
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #44404#47548#52404
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lbl_PosNo: TLabel
    Left = 415
    Top = 85
    Width = 80
    Height = 21
    AutoSize = False
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWhite
    Font.Height = -19
    Font.Name = #44404#47548#52404
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lbl_WorkDate: TLabel
    Left = 147
    Top = 85
    Width = 153
    Height = 21
    AutoSize = False
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWhite
    Font.Height = -19
    Font.Name = #44404#47548#52404
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object obtn_magam: TOXSpeedButton
    Left = 343
    Top = 414
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
    OnClick = obtn_magamClick
    DrawFrame = False
  end
  object obtn_MagamCan: TOXSpeedButton
    Left = 458
    Top = 414
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
    OnClick = obtn_MagamCanClick
    DrawFrame = False
  end
  object lbl_Count: TLabel
    Left = 430
    Top = 203
    Width = 119
    Height = 18
    Alignment = taRightJustify
    AutoSize = False
    Caption = '0'
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #44404#47548
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lbl_Void: TLabel
    Left = 430
    Top = 243
    Width = 119
    Height = 18
    Alignment = taRightJustify
    AutoSize = False
    Caption = '0'
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #44404#47548
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lbl_Loss: TLabel
    Left = 152
    Top = 401
    Width = 122
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    Caption = '0'
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #44404#47548#52404
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lbl_Dc: TLabel
    Left = 430
    Top = 283
    Width = 119
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = '0'
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #44404#47548
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lbl_lack: TLabel
    Left = 430
    Top = 323
    Width = 119
    Height = 16
    Alignment = taRightJustify
    AutoSize = False
    Caption = '0'
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #44404#47548
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lbl_Trust: TLabel
    Left = 152
    Top = 361
    Width = 122
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    Caption = '0'
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #44404#47548#52404
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lbl_Cashier: TLabel
    Left = 430
    Top = 164
    Width = 119
    Height = 19
    Alignment = taRightJustify
    AutoSize = False
    Caption = '0'
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #44404#47548
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lbl_TipAmt: TLabel
    Left = 152
    Top = 282
    Width = 122
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    Caption = '0'
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #44404#47548#52404
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object obtn_Cashbox: TOXSpeedButton
    Left = 482
    Top = 7
    Width = 50
    Height = 39
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
    OnClick = obtn_CashboxClick
    DrawFrame = False
  end
  object obtn_close: TOXSpeedButton
    Left = 539
    Top = 4
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
  object obtn_init: TOXSpeedButton
    Left = 458
    Top = 359
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
    OnClick = obtn_initClick
    DrawFrame = False
  end
  object lbl_OrderNo: TLabel
    Left = 312
    Top = 376
    Width = 139
    Height = 20
    Caption = #51452#47928#48264#54840'-1020'
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWhite
    Font.Height = -20
    Font.Name = #44404#47548#52404
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object ADOProc_PosSelect: TADOStoredProc
    Connection = DmModule.Pos_DB
    CursorType = ctStatic
    ProcedureName = 'POS_SELECT_POS_MGM;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@CD_STORE'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4
        Value = ' '
      end
      item
        Name = '@YMD_CLOSE'
        Attributes = [paNullable]
        DataType = ftString
        Size = 8
        Value = ' '
      end
      item
        Name = '@NO_POS'
        Attributes = [paNullable]
        DataType = ftString
        Size = 2
        Value = ' '
      end
      item
        Name = '@AMT_SALE'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = 0
      end
      item
        Name = '@AMT_TAX'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = 0
      end
      item
        Name = '@AMT_CASH'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = 0
      end
      item
        Name = '@AMT_CARD'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = 0
      end
      item
        Name = '@AMT_CHECK'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = 0
      end
      item
        Name = '@AMT_TRUST'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = 0
      end
      item
        Name = '@AMT_GIFT'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = 0
      end
      item
        Name = '@AMT_POINT'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = 0
      end
      item
        Name = '@AMT_LOSS'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = 0
      end
      item
        Name = '@AMT_TIP'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = 0
      end
      item
        Name = '@DC_TOTAL'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = 0
      end
      item
        Name = '@AMT_VOID'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = 0
      end
      item
        Name = '@CNT_CUSTOMER'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = 0
      end
      item
        Name = '@CNT_CASHIER'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = 0
      end
      item
        Name = '@AMT_LACK'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = 0
      end
      item
        Name = '@AMT_CASHRCP'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = 0
      end
      item
        Name = '@NOT_CLOSE'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 6
        Value = Null
      end
      item
        Name = '@DS_STATUS'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 1
        Value = ' '
      end>
    Left = 337
    Top = 11
  end
  object ADOProc_PosSave: TADOStoredProc
    Connection = DmModule.Pos_DB
    CursorType = ctStatic
    ProcedureName = 'POS_SAVE_POS_MGM;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@CD_STORE'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4
        Value = Null
      end
      item
        Name = '@YMD_CLOSE'
        Attributes = [paNullable]
        DataType = ftString
        Size = 8
        Value = Null
      end
      item
        Name = '@NO_POS'
        Attributes = [paNullable]
        DataType = ftString
        Size = 2
        Value = Null
      end
      item
        Name = '@CD_WEATHER'
        Attributes = [paNullable]
        DataType = ftString
        Size = 3
        Value = Null
      end
      item
        Name = '@DS_ORDERNO'
        Attributes = [paNullable]
        DataType = ftString
        Size = 1
        Value = Null
      end
      item
        Name = '@WORK_KIND'
        Attributes = [paNullable]
        DataType = ftString
        Size = 1
        Value = Null
      end
      item
        Name = '@RESULT'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 1
        Value = Null
      end
      item
        Name = '@YMD_LAST'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 8
        Value = Null
      end>
    Prepared = True
    Left = 425
    Top = 11
  end
end
