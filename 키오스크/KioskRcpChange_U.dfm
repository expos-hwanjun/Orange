inherited KioskRcpChange_F: TKioskRcpChange_F
  Left = 420
  Top = 222
  Caption = 'KioskRcpChange_F'
  ClientHeight = 768
  ClientWidth = 900
  ExplicitWidth = 900
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 15
  inherited Image1: TImage
    Visible = False
  end
  inherited AdvShape3: TAdvShape
    Left = -242
    Top = 724
    Visible = False
    ExplicitLeft = -242
    ExplicitTop = 724
  end
  inherited TitleLabel: TLabel
    Visible = False
  end
  object PointButton: TOXSpeedButton [3]
    Left = 273
    Top = 699
    Width = 147
    Height = 60
    Action = Action4
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
    DrawFrame = False
  end
  object CashRcpButton: TOXSpeedButton [4]
    Left = 429
    Top = 699
    Width = 147
    Height = 60
    Action = Action7
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
    DrawFrame = False
  end
  object RePrintButton: TOXSpeedButton [5]
    Left = 585
    Top = 699
    Width = 147
    Height = 60
    Action = Action6
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
    DrawFrame = False
  end
  object VoidButton: TOXSpeedButton [6]
    Left = 741
    Top = 699
    Width = 147
    Height = 60
    Action = Action8
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
    DrawFrame = False
  end
  object AllSearchButton: TOXSpeedButton [7]
    Left = 655
    Top = 13
    Width = 84
    Height = 43
    Hint = '03'
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
    OnClick = FullSearchButtonClick
    DrawFrame = False
  end
  object obtn_close: TOXSpeedButton [8]
    Left = 832
    Top = 8
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
    OnClick = CloseButtonClick
    DrawFrame = False
  end
  inherited PosPanel: TAdvToolPanel [9]
  end
  inherited GridPrevButton: TAdvGlassButton [10]
    Left = 399
    Top = 72
    Width = 47
    Height = 134
    Font.Height = -20
    ExplicitLeft = 399
    ExplicitTop = 72
    ExplicitWidth = 47
    ExplicitHeight = 134
  end
  inherited GridNextButton: TAdvGlassButton [11]
    Left = 399
    Top = 207
    Width = 47
    Height = 134
    Font.Height = -20
    ExplicitLeft = 399
    ExplicitTop = 207
    ExplicitWidth = 47
    ExplicitHeight = 134
  end
  inherited GridFirstButton: TAdvGlassButton [12]
    Left = 399
    Top = 420
    Width = 48
    Height = 133
    Font.Height = -20
    ExplicitLeft = 399
    ExplicitTop = 420
    ExplicitWidth = 48
    ExplicitHeight = 133
  end
  inherited GridEndButton: TAdvGlassButton [13]
    Left = 399
    Top = 556
    Width = 48
    Height = 133
    Font.Height = -20
    ExplicitLeft = 399
    ExplicitTop = 556
    ExplicitWidth = 48
    ExplicitHeight = 133
  end
  inherited MenuGridPrevButton: TAdvGlassButton [14]
    Left = 844
    Top = 72
    Width = 46
    Height = 185
    Font.Height = -20
    ExplicitLeft = 844
    ExplicitTop = 72
    ExplicitWidth = 46
    ExplicitHeight = 185
  end
  inherited MenuGridNextButton: TAdvGlassButton [15]
    Left = 845
    Top = 263
    Width = 45
    Height = 198
    Font.Height = -20
    ExplicitLeft = 845
    ExplicitTop = 263
    ExplicitWidth = 45
    ExplicitHeight = 198
  end
  inherited cxLabel7: TcxLabel [16]
    Style.IsFontAssigned = True
    Visible = False
  end
  inherited cxLabel3: TcxLabel [17]
    Style.IsFontAssigned = True
    Visible = False
  end
  inherited cxLabel2: TcxLabel [18]
    Style.IsFontAssigned = True
    Visible = False
  end
  inherited edtCancelAmt: TcxCurrencyEdit [19]
    Left = 283
    Style.IsFontAssigned = True
    Visible = False
    ExplicitLeft = 283
    ExplicitWidth = 0
    Width = 0
  end
  inherited cxLabel4: TcxLabel [20]
    Style.IsFontAssigned = True
    Visible = False
  end
  inherited edtCardAmt: TcxCurrencyEdit [21]
    Left = 283
    Style.IsFontAssigned = True
    Visible = False
    ExplicitLeft = 283
    ExplicitWidth = 0
    Width = 0
  end
  inherited cxLabel1: TcxLabel [22]
    Style.IsFontAssigned = True
    Visible = False
  end
  inherited edtCustomerCount: TcxCurrencyEdit [23]
    Left = 283
    Style.IsFontAssigned = True
    Visible = False
    ExplicitLeft = 283
    ExplicitWidth = 0
    Width = 0
  end
  inherited cxLabel5: TcxLabel [24]
    Style.IsFontAssigned = True
    Visible = False
  end
  inherited edtOrderAmt: TcxCurrencyEdit [25]
    Left = 283
    Style.IsFontAssigned = True
    Visible = False
    ExplicitLeft = 283
    ExplicitWidth = 0
    Width = 0
  end
  inherited cxLabel6: TcxLabel [26]
    Style.IsFontAssigned = True
    Visible = False
  end
  inherited edtCashRcpAmt: TcxCurrencyEdit [27]
    Left = 97
    Style.IsFontAssigned = True
    Visible = False
    ExplicitLeft = 97
    ExplicitWidth = 0
    Width = 0
  end
  inherited cxLabel8: TcxLabel [28]
    Style.IsFontAssigned = True
    Visible = False
  end
  inherited edtCashAmt: TcxCurrencyEdit [29]
    Left = 97
    Style.IsFontAssigned = True
    Visible = False
    ExplicitLeft = 97
    ExplicitWidth = 0
    Width = 0
  end
  inherited cxLabel9: TcxLabel [30]
    Style.IsFontAssigned = True
    Visible = False
  end
  inherited edtSaleAmt: TcxCurrencyEdit [31]
    Left = 97
    Style.IsFontAssigned = True
    Visible = False
    ExplicitLeft = 97
    ExplicitWidth = 0
    Width = 0
  end
  inherited BanpumButton: TAdvGlassButton [32]
    Left = 786
    Top = 472
    ExplicitLeft = 786
    ExplicitTop = 472
  end
  inherited edtTotalAmt: TcxCurrencyEdit [33]
    Left = 97
    Style.IsFontAssigned = True
    Visible = False
    ExplicitLeft = 97
    ExplicitWidth = 0
    Width = 0
  end
  inherited CloseButton: TcxButton [34]
    Left = 722
    Top = 18
    OptionsImage.Glyph.Data = {00000000}
    Visible = False
    ExplicitLeft = 722
    ExplicitTop = 18
  end
  inherited Grid: TcxGrid [35]
    Top = 72
    Width = 385
    Height = 616
    ExplicitTop = 72
    ExplicitWidth = 385
    ExplicitHeight = 616
    inherited GridTableView: TcxGridTableView
      inherited GridTableViewRcpNo: TcxGridColumn
        Width = 41
      end
      inherited GridTableViewSaleAmt: TcxGridColumn
        Width = 99
      end
      inherited GridTableViewTableName: TcxGridColumn
        Visible = False
      end
      inherited GridTableViewSaleTime: TcxGridColumn
        Width = 94
      end
      inherited GridTableViewDsSale: TcxGridColumn
        Width = 70
      end
    end
  end
  inherited meo_Present: TMemo [36]
    Left = 453
    Top = 530
    Width = 440
    Height = 158
    Anchors = [akLeft, akBottom]
    ScrollBars = ssNone
    ExplicitLeft = 453
    ExplicitTop = 530
    ExplicitWidth = 440
    ExplicitHeight = 158
  end
  inherited FullSearchButton: TAdvGlassButton [37]
    Left = 1001
    Top = 116
    Visible = False
    ExplicitLeft = 1001
    ExplicitTop = 116
  end
  inherited CardSearchButton: TAdvGlassButton [38]
    Left = 1001
    Top = 96
    Visible = False
    ExplicitLeft = 1001
    ExplicitTop = 96
  end
  inherited cxGrid2: TcxGrid [39]
    Left = 453
    Top = 72
    Width = 388
    Height = 388
    Anchors = [akLeft, akTop, akBottom]
    BevelKind = bkSoft
    LookAndFeel.Kind = lfFlat
    ExplicitLeft = 453
    ExplicitTop = 72
    ExplicitWidth = 388
    ExplicitHeight = 388
    inherited gvDetail: TcxGridTableView
      OptionsView.DataRowHeight = 35
      inherited gvDetailMenuName: TcxGridColumn
        Width = 182
      end
      inherited gvDetailSaleQty: TcxGridColumn
        Width = 49
      end
      inherited gvDetailSalePrice: TcxGridColumn
        Width = 70
      end
      inherited gvDetailSaleAmt: TcxGridColumn
        Width = 88
      end
    end
  end
  inherited CashSearchButton: TAdvGlassButton [40]
    Left = 983
    Top = 14
    Visible = False
    ExplicitLeft = 983
    ExplicitTop = 14
  end
  inherited SaleDatePicker: TCalendarPicker [41]
    Left = 505
    Top = 14
    ExplicitLeft = 505
    ExplicitTop = 14
  end
  inherited PrintOptionPanel: TAdvToolPanel [42]
    Left = -136
    Top = 907
    ExplicitLeft = -136
    ExplicitTop = 907
  end
  inherited cxGrid3: TcxGrid [43]
    Left = 437
    Width = 416
    Height = 0
    ExplicitLeft = 437
    ExplicitWidth = 416
    ExplicitHeight = 0
  end
  inherited PrintOptionButton: TAdvGlassButton
    Left = 292
    Top = 6
    Visible = False
    OnClick = nil
    ExplicitLeft = 292
    ExplicitTop = 6
  end
  inherited Show_Timer: TTimer
    Left = 608
    Top = 48
  end
  inherited StyleRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
end
