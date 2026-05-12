object WebOrderMenuForm: TWebOrderMenuForm
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'WebOrderMenuForm'
  ClientHeight = 768
  ClientWidth = 1024
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #47569#51008' '#44256#46357
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    1024
    768)
  PixelsPerInch = 96
  TextHeight = 21
  object ConditionSearchLabel: TLabel
    Left = 16
    Top = 67
    Width = 74
    Height = 28
    Caption = #44160' '#49353' '#50612
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object CaptionLabel: TLabel
    Left = 125
    Top = 4
    Width = 204
    Height = 42
    AutoSize = False
    Caption = #48156#51452#49345#54408' '#51312#54924
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWhite
    Font.Height = -31
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object CommentLabel: TLabel
    Left = 11
    Top = 427
    Width = 523
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #39'Ctrl+'#53364#47533#39', '#39'Shift+'#53364#47533#39#51004#47196' '#50668#47084' '#49345#54408#51012' '#49440#53469#54624' '#49688' '#51080#49845#45768#45796'.'
    Font.Charset = HANGEUL_CHARSET
    Font.Color = 204
    Font.Height = -19
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = []
    ParentFont = False
  end
  object CloseButton: TcxButton
    AlignWithMargins = True
    Left = 954
    Top = 4
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
    OptionsImage.Glyph.Data = {
      76140000424D7614000000000000360000002800000024000000240000000100
      2000000000004014000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000090909095252
      5252A7A7A7A7EAEAEAEAE5E5E5E5888888880606060600000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000909
      090952525252A7A7A7A7F3F3F3F3FFFFFFFFE9E9E9E99E9E9E9EA6A6A6A6FFFF
      FFFF878787870000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000909090952525252A7A7A7A7F3F3F3F3FFFFFFFFE9E9E9E9979797974242
      4242030303030000000000000000A7A7A7A7E5E5E5E500000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000040404048A8A8A8AF3F3F3F3FFFFFFFFE9E9E9E99797
      9797424242420303030300000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008B8B8B8BFFFF
      FFFFA6A6A6A64242424203030303000000000000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF88888888888888888888
      8888888888888888888879797979404040400000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EBEBEBEBABABABAB0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFA9A9A9A90505050500000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFFFF8080
      8080000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      000000000000000000000E0E0E0E72727272FEFEFEFE7E7E7E7E000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFFFF808080800000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000000000000000000000000
      0000AFAFAFAFE5E5E5E500000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFFFF8080
      8080000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      00000000000000000000000000000000000081818181FEFEFEFE000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFFFF808080800000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000000000000000000000000
      000080808080FFFFFFFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFFFF8080
      8080000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      00000000000000000000000000000000000080808080FFFFFFFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFFFF808080800000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000000000000000000000000
      000080808080FFFFFFFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFFFF8080
      8080000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      00000000000000000000000000000000000080808080FFFFFFFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFFFF808080800000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000000000000000000000000
      000080808080FFFFFFFF000000000000000000000000000000001C1C1C1C5B5B
      5B5B010101010000000000000000000000000000000000000000FFFFFFFF8080
      8080000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      00000000000000000000000000000000000080808080FFFFFFFF000000000000
      000000000000000000005C5C5C5CFFFFFFFF9090909001010101000000000000
      00000000000000000000FFFFFFFF808080800000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000000000000000000000000
      00007C7C7C7CFCFCFCFC00000000000000000000000000000000000000008F8F
      8F8FFFFFFFFF9090909001010101000000000000000000000000FFFFFFFF8080
      8080000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      0000000000000000000000000000000000001C1C1C1C55555555000000000000
      0000000000000000000000000000000000008F8F8F8FFFFFFFFF909090900101
      01010000000000000000FFFFFFFF808080800000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000087878787FFFFFFFF8F8F8F8F0101010100000000FFFFFFFF8080
      8080000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000087878787FFFF
      FFFF8F8F8F8F01010101FFFFFFFF808080800000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF000000000000000000000000000000001C1C1C1C828282828888
      8888888888888888888888888888888888888888888888888888888888888888
      8888888888888888888888888888EAEAEAEAFFFFFFFF8D8D8D8DFFFFFFFF8080
      8080000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      00000000000056565656FCFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFE0E0E0E0FFFFFFFF808080800000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000026262626E5E5E5E5E8E8E8E82A2A2A2AFFFFFFFF8080
      8080000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000026262626E5E5E5E5E8E8
      E8E82A2A2A2A00000000FFFFFFFF808080800000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000027272727E5E5E5E5E8E8E8E82A2A2A2A0000000000000000FFFFFFFF8080
      8080000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      00000000000000000000000000000000000059595959D1D1D1D1000000000000
      000000000000000000000000000029292929E7E7E7E7E6E6E6E6282828280000
      00000000000000000000FFFFFFFF808080800000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000000000000000000000000
      000080808080FFFFFFFF0000000000000000000000000000000023232323E7E7
      E7E7E6E6E6E62828282800000000000000000000000000000000FFFFFFFF8080
      8080000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      00000000000000000000000000000000000080808080FFFFFFFF000000000000
      0000000000000000000056565656DADADADA2828282800000000000000000000
      00000000000000000000FFFFFFFF808080800000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000000000000000000000000
      000080808080FFFFFFFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFFFF8080
      8080000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      00000000000000000000000000000000000080808080FFFFFFFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFFFF808080800000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000000000000000000000000
      000080808080FFFFFFFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFFFF8080
      8080000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A2A2A2A2EAEAEAEA00000000000000000000
      00000000000000000000000000000000000080808080FFFFFFFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFFFF808080800000000000000000000000000000
      0000000000000000000000000000000000000303030342424242A5A5A5A5FFFF
      FFFF8B8B8B8B0000000000000000000000000000000000000000000000000000
      000080808080FFFFFFFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFFFF8080
      8080000000000000000000000000000000000000000003030303424242429797
      9797E9E9E9E9FFFFFFFFF3F3F3F38A8A8A8A0404040400000000000000000000
      0000000000000000000000000000000000008E8E8E8EF8F8F8F8000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E5E5E5E5A3A3A3A30000000000000000030303034242
      424297979797E9E9E9E9FFFFFFFFF3F3F3F3A7A7A7A752525252090909090000
      0000000000000000000000000000000000000000000000000000000000001010
      1010E0E0E0E0C0C0C0C000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000088888888FDFD
      FDFDA3A3A3A39C9C9C9CE9E9E9E9FFFFFFFFFFFFFFFFFFFFFFFFDADADADA9191
      9191888888888888888888888888888888888888888888888888888888888888
      8888888888888888888891919191E0E0E0E0F9F9F9F931313131000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000606060689898989E6E6E6E6FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F8F8C2C2
      C2C2313131310000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000}
    SpeedButtonOptions.CanBeFocused = False
    SpeedButtonOptions.Flat = True
    SpeedButtonOptions.Transparent = True
    TabOrder = 0
    TabStop = False
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWhite
    Font.Height = -23
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = CloseButtonClick
  end
  object ConditionSearchEdit: TcxTextEdit
    Left = 112
    Top = 63
    AutoSize = False
    ImeMode = imSHanguel
    ParentFont = False
    Properties.ImeMode = imSHanguel
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -20
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 1
    OnKeyDown = ConditionSearchEditKeyDown
    Height = 36
    Width = 209
  end
  object Grid: TcxGrid
    AlignWithMargins = True
    Left = 9
    Top = 110
    Width = 1007
    Height = 296
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkTile
    BorderWidth = 1
    BorderStyle = cxcbsNone
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    LookAndFeel.Kind = lfFlat
    LookAndFeel.NativeStyle = False
    object GridTableView: TcxGridTableView
      Tag = 99
      Navigator.Buttons.CustomButtons = <>
      FilterBox.CustomizeDialog = False
      FilterBox.Visible = fvNever
      OnCellDblClick = GridTableViewCellDblClick
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = ',0'#44148
          Kind = skCount
          Column = GridTableViewGoodsCode
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsBehavior.FocusCellOnCycle = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsSelection.HideFocusRectOnExit = False
      OptionsSelection.MultiSelect = True
      OptionsView.DataRowHeight = 30
      OptionsView.GroupByBox = False
      OptionsView.HeaderHeight = 30
      Styles.Footer = StyleFooter
      Styles.Header = StyleHeader
      object GridTableViewGoodsClass: TcxGridColumn
        Caption = #48516#47448
        DataBinding.FieldName = 'NM_CLASS'
        HeaderAlignmentHorz = taCenter
        Options.Focusing = False
        Width = 132
      end
      object GridTableViewGoodsCode: TcxGridColumn
        Caption = #49345#54408#53076#46300
        DataBinding.FieldName = 'CD_GOODS'
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Focusing = False
        Width = 113
      end
      object GridTableViewGoodsName: TcxGridColumn
        Caption = #49345#54408#51060#47492
        DataBinding.FieldName = 'NM_GOODS'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Focusing = False
        Width = 279
      end
      object GridTableViewOrderUnit: TcxGridColumn
        Caption = #48156#51452#45800#50948
        DataBinding.FieldName = 'NM_UNIT'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Focusing = False
        Width = 101
      end
      object GridTableViewNepumQty: TcxGridColumn
        Caption = #51077#49688
        DataBinding.FieldName = 'QTY_NEPUM'
        HeaderAlignmentHorz = taCenter
        Options.Focusing = False
        Width = 69
      end
      object GridTableViewKeepName: TcxGridColumn
        Caption = #48372#44288#48169#48277
        DataBinding.FieldName = 'NM_KEEP'
        HeaderAlignmentHorz = taCenter
        Options.Focusing = False
        Width = 107
      end
      object GridTableViewOrderPrice: TcxGridColumn
        Caption = #48156#51452#45800#44032
        DataBinding.ValueType = 'Currency'
        DataBinding.FieldName = 'PR_SALE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Focusing = False
        Width = 88
      end
      object GridTableViewOrderQty: TcxGridColumn
        Caption = #48156#51452#49688#47049
        DataBinding.ValueType = 'Currency'
        DataBinding.FieldName = 'QTY_ORDER'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0'
        HeaderAlignmentHorz = taCenter
        Width = 80
      end
      object GridTableViewDsTax: TcxGridColumn
        Tag = 99
        Caption = #49464#47924#44396#48516
        Visible = False
      end
    end
    object GridLevel: TcxGridLevel
      GridView = GridTableView
    end
  end
  object AddGrid: TcxGrid
    AlignWithMargins = True
    Left = 9
    Top = 469
    Width = 1007
    Height = 223
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkTile
    BorderWidth = 1
    BorderStyle = cxcbsNone
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    LookAndFeel.Kind = lfFlat
    LookAndFeel.NativeStyle = False
    object AddGridTableView: TcxGridTableView
      Tag = 99
      Navigator.Buttons.CustomButtons = <>
      FilterBox.CustomizeDialog = False
      FilterBox.Visible = fvNever
      OnCellDblClick = AddGridTableViewCellDblClick
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = ',0'#44148
          Kind = skCount
          Column = AddGridTableViewGoodsCode
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsBehavior.FocusCellOnCycle = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsSelection.HideFocusRectOnExit = False
      OptionsSelection.MultiSelect = True
      OptionsView.DataRowHeight = 30
      OptionsView.GroupByBox = False
      OptionsView.HeaderHeight = 30
      Styles.Footer = StyleFooter
      Styles.Header = StyleHeader
      object AddGridTableViewGoodsClass: TcxGridColumn
        Caption = #48516#47448
        HeaderAlignmentHorz = taCenter
        Options.Focusing = False
        Width = 115
      end
      object AddGridTableViewGoodsCode: TcxGridColumn
        Caption = #49345#54408#53076#46300
        DataBinding.FieldName = 'CD_GOODS'
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Focusing = False
        Width = 110
      end
      object AddGridTableViewGoodsName: TcxGridColumn
        Caption = #49345#54408#51060#47492
        DataBinding.FieldName = 'NM_GOODS_SHORT'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Focusing = False
        Width = 281
      end
      object AddGridTableViewOrderUnit: TcxGridColumn
        Caption = #48156#51452#45800#50948
        HeaderAlignmentHorz = taCenter
        Options.Focusing = False
        Width = 114
      end
      object AddGridTableViewNepumQty: TcxGridColumn
        Caption = #51077#49688
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        HeaderAlignmentHorz = taCenter
        Options.Focusing = False
      end
      object AddGridTableViewKeep: TcxGridColumn
        Caption = #48372#44288#48169#48277
        HeaderAlignmentHorz = taCenter
        Options.Focusing = False
        Width = 117
      end
      object AddGridTableViewOrderPrice: TcxGridColumn
        Caption = #48156#51452#45800#44032
        DataBinding.ValueType = 'Currency'
        DataBinding.FieldName = 'PR_SALE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Focusing = False
        Width = 96
      end
      object AddGridTableViewOrderQty: TcxGridColumn
        Caption = #48156#51452#49688#47049
        DataBinding.ValueType = 'Integer'
        DataBinding.FieldName = 'QTY_BUY'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        HeaderAlignmentHorz = taCenter
        Width = 76
      end
      object AddGridTableViewDsTax: TcxGridColumn
        Tag = 99
        Caption = #49464#47924#44396#48516
        Visible = False
      end
    end
    object AddGridLevel: TcxGridLevel
      GridView = AddGridTableView
    end
  end
  object SaveButton: TAdvSmoothButton
    Left = 456
    Top = 702
    Width = 179
    Height = 55
    Appearance.PictureAlignment = taCenter
    Appearance.Font.Charset = HANGEUL_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -20
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
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
    Caption = #54869' '#51064
    Color = 11031552
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
    Shadow = True
    DisabledColor = clWhite
    TabOrder = 4
    ShowFocus = False
    HorizontalSpacing = 0
    VerticalSpacing = 0
    Version = '2.1.1.5'
    TMSStyle = 0
  end
  object MenuDecButton: TAdvSmoothButton
    Left = 824
    Top = 418
    Width = 169
    Height = 43
    Appearance.PictureAlignment = taCenter
    Appearance.Font.Charset = HANGEUL_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -17
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
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
    Caption = #49325#51228#8593
    ParentFont = False
    Shadow = True
    DisabledColor = clWhite
    TabOrder = 5
    ShowFocus = False
    HorizontalSpacing = 0
    VerticalSpacing = 0
    Version = '2.1.1.5'
    OnClick = MenuDecButtonClick
    TMSStyle = 0
  end
  object MenuAddButton: TAdvSmoothButton
    Left = 631
    Top = 418
    Width = 169
    Height = 43
    Appearance.PictureAlignment = taCenter
    Appearance.Font.Charset = HANGEUL_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -17
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
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
    Caption = #52628#44032#8595
    Color = 11031552
    ParentFont = False
    Shadow = True
    DisabledColor = clWhite
    TabOrder = 6
    ShowFocus = False
    HorizontalSpacing = 0
    VerticalSpacing = 0
    Version = '2.1.1.5'
    OnClick = MenuAddButtonClick
    TMSStyle = 0
  end
  object MenuSearchButton: TAdvSmoothButton
    Left = 327
    Top = 61
    Width = 116
    Height = 43
    Appearance.PictureAlignment = taCenter
    Appearance.Font.Charset = HANGEUL_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -17
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
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
    Caption = #51312#54924
    Color = 11031552
    ParentFont = False
    Picture.Data = {
      89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
      0D00000006624B474400FF00FF00FFA0BDA7930000015C49444154388DAD94CF
      2B055114C7BF77BCC58B8DB2C44A6F497A1E1BDE2BA5947FC156B2B4F147283B
      F907442C51ACBD2CEC240B59288590FC080FF9D5C762CED434CD9B997A733667
      EEFD9EF3B9F7DC73EF48399B8B9B044A92A62555247549BA935497B4E69C7BC8
      4C070AC012F0836F37C009F068E31760262BCC019B96B8030C84340F98008E4D
      5FC8029CB3E065A0D951B403FBC01F50498279C035700A145216EE06DE81EDA4
      A061DBDD7C6A297EFC3AF00914A39A67BE64FE280BD0E28A927A9B01311F7B76
      3116C47951219838375FCE082C4BFA927419AB5A53AE80B30C4DE9013E80ADC4
      2581596BCC4ACAB5A903BFC0501AD0011B06DD0506435A1B3069AF06BB366389
      C050E222F06D89B70679B6F113D0B0EF37A01A65342BAD4FFECF614452A7A40B
      49879256E537644F5287A486A429E7DC41EA6E532A19055E43E58FB70434682D
      527E2D0F68B0D37BA0BF65A041ABB9C1E2EC1F05796D4F063E5E440000000049
      454E44AE426082}
    Shadow = True
    DisabledColor = clWhite
    TabOrder = 7
    ShowFocus = False
    HorizontalSpacing = 0
    VerticalSpacing = 0
    Version = '2.1.1.5'
    OnClick = MenuSearchButtonClick
    TMSStyle = 0
  end
  object StyleRepository: TcxStyleRepository
    Left = 528
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
