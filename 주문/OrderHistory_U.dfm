object OrderHistory_F: TOrderHistory_F
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = #51452#47928#47196#44536
  ClientHeight = 768
  ClientWidth = 1024
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #47569#51008' '#44256#46357
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 20
  object TitleLabel: TLabel
    Left = 125
    Top = 4
    Width = 213
    Height = 42
    HelpType = htKeyword
    HelpKeyword = 'C'
    AutoSize = False
    Caption = #47700#45684' '#51452#47928#51060#47141' '
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWhite
    Font.Height = -31
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Grid: TcxGrid
    Left = 8
    Top = 57
    Width = 952
    Height = 624
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.NativeStyle = False
    object GridTableView1: TcxGridTableView
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.First.Visible = True
      Navigator.Buttons.PriorPage.Visible = True
      Navigator.Buttons.Prior.Visible = True
      Navigator.Buttons.Next.Visible = True
      Navigator.Buttons.NextPage.Visible = True
      Navigator.Buttons.Last.Visible = True
      Navigator.Buttons.Insert.Visible = True
      Navigator.Buttons.Delete.Visible = True
      Navigator.Buttons.Edit.Visible = True
      Navigator.Buttons.Post.Visible = True
      Navigator.Buttons.Cancel.Visible = True
      Navigator.Buttons.Refresh.Visible = True
      Navigator.Buttons.SaveBookmark.Visible = True
      Navigator.Buttons.GotoBookmark.Visible = True
      Navigator.Buttons.Filter.Visible = True
      ScrollbarAnnotations.CustomAnnotations = <>
      OnCellDblClick = GridTableView1CellDblClick
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsSelection.CellSelect = False
      OptionsView.ScrollBars = ssNone
      OptionsView.ColumnAutoWidth = True
      OptionsView.DataRowHeight = 40
      OptionsView.GroupByBox = False
      OptionsView.HeaderHeight = 35
      Styles.Header = StyleHeader
      object GridTableView1TableName: TcxGridColumn
        Caption = #53580#51060#48660
        DataBinding.FieldName = 'NM_TABLE'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Filtering = False
        Styles.Content = cxStyle2
        Width = 140
      end
      object GridTableView1OrderMenu: TcxGridColumn
        Caption = #51452#47928#47700#45684
        DataBinding.FieldName = 'ORDER_MENU'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Filtering = False
        Width = 571
      end
      object GridTableView1LapeTime: TcxGridColumn
        Caption = #44221#44284#49884#44036
        DataBinding.ValueType = 'Integer'
        DataBinding.FieldName = 'LAPSE_TIME'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0 '#48516
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Filtering = False
        Width = 132
      end
      object GridTableView1OrderNo: TcxGridColumn
        Caption = #51452#47928#48264#54840
        DataBinding.FieldName = 'NO_ORDER'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        HeaderAlignmentHorz = taCenter
        Width = 107
      end
      object GridTableView1TableNo: TcxGridColumn
        DataBinding.FieldName = 'NO_TABLE'
        Visible = False
      end
    end
    object GridTableView: TcxGridTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsSelection.CellSelect = False
      OptionsView.ScrollBars = ssNone
      OptionsView.DataRowHeight = 35
      OptionsView.GroupByBox = False
      OptionsView.HeaderHeight = 35
      Styles.OnGetContentStyle = GridTableViewStylesGetContentStyle
      Styles.Footer = cxStyle2
      Styles.Header = StyleHeader
      object GridTableViewTableNo: TcxGridColumn
        Caption = #53580#51060#48660
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        HeaderAlignmentHorz = taCenter
        Width = 122
      end
      object GridTableViewMenuName: TcxGridColumn
        Caption = #47700#45684#47749
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Vert = taVCenter
        HeaderAlignmentHorz = taCenter
        Width = 343
      end
      object GridTableViewOrderQty: TcxGridColumn
        Caption = #49688#47049
        DataBinding.ValueType = 'Currency'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.DisplayFormat = '#0'
        HeaderAlignmentHorz = taCenter
        Width = 99
      end
      object GridTableViewPosNo: TcxGridColumn
        Caption = #51452#47928#54252#49828
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        HeaderAlignmentHorz = taCenter
        Width = 109
      end
      object GridTableViewOrderNo: TcxGridColumn
        Caption = #51452#47928#48264#54840
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        HeaderAlignmentHorz = taCenter
        Width = 123
      end
      object GridTableViewOrderDate: TcxGridColumn
        Caption = #51452#47928#49884#44036
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        HeaderAlignmentHorz = taCenter
        Width = 122
      end
    end
    object GridLevel: TcxGridLevel
      GridView = GridTableView1
    end
  end
  object CloseButton: TcxButton
    AlignWithMargins = True
    Left = 957
    Top = 3
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
    OptionsImage.Glyph.SourceDPI = 96
    OptionsImage.Glyph.Data = {
      424D761400000000000036000000280000002400000024000000010020000000
      000000000000C40E0000C40E0000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000909090952525252A7A7
      A7A7EAEAEAEAE5E5E5E588888888060606060000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000090909095252
      5252A7A7A7A7F3F3F3F3FFFFFFFFE9E9E9E99E9E9E9EA6A6A6A6FFFFFFFF8787
      8787000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000909
      090952525252A7A7A7A7F3F3F3F3FFFFFFFFE9E9E9E997979797424242420303
      03030000000000000000A7A7A7A7E5E5E5E50000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000040404048A8A8A8AF3F3F3F3FFFFFFFFE9E9E9E9979797974242
      424203030303000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008B8B8B8BFFFFFFFFA6A6
      A6A6424242420303030300000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF8888888888888888888888888888
      8888888888887979797940404040000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EBEBEBEBABABABAB000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA9A9
      A9A9050505050000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      0000000000000E0E0E0E72727272FEFEFEFE7E7E7E7E00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF00000000000000000000000000000000000000000000000000000000AFAF
      AFAFE5E5E5E50000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      000000000000000000000000000081818181FEFEFEFE00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF000000000000000000000000000000001C1C1C1C5B5B5B5B0101
      01010000000000000000000000000000000000000000FFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      0000000000005C5C5C5CFFFFFFFF909090900101010100000000000000000000
      000000000000FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000000000000000000000000000007C7C
      7C7CFCFCFCFC00000000000000000000000000000000000000008F8F8F8FFFFF
      FFFF9090909001010101000000000000000000000000FFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      00000000000000000000000000001C1C1C1C5555555500000000000000000000
      00000000000000000000000000008F8F8F8FFFFFFFFF90909090010101010000
      000000000000FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000087878787FFFFFFFF8F8F8F8F0101010100000000FFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000087878787FFFFFFFF8F8F
      8F8F01010101FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000001C1C1C1C82828282888888888888
      8888888888888888888888888888888888888888888888888888888888888888
      88888888888888888888EAEAEAEAFFFFFFFF8D8D8D8DFFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      000056565656FCFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFE0E0E0E0FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000026262626E5E5E5E5E8E8E8E82A2A2A2AFFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000026262626E5E5E5E5E8E8E8E82A2A
      2A2A00000000FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002727
      2727E5E5E5E5E8E8E8E82A2A2A2A0000000000000000FFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      000000000000000000000000000059595959D1D1D1D100000000000000000000
      0000000000000000000029292929E7E7E7E7E6E6E6E628282828000000000000
      000000000000FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000023232323E7E7E7E7E6E6
      E6E62828282800000000000000000000000000000000FFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      00000000000056565656DADADADA282828280000000000000000000000000000
      000000000000FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808080FFFFFFFF0000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFFFF80808080000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808080FFFF
      FFFF000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFFFF808080800000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A2A2A2A2EAEAEAEA0000000000000000000000000000
      000000000000000000000000000080808080FFFFFFFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFFFF80808080000000000000000000000000000000000000
      00000000000000000000000000000303030342424242A5A5A5A5FFFFFFFF8B8B
      8B8B000000000000000000000000000000000000000000000000000000008080
      8080FFFFFFFF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFFFF808080800000
      000000000000000000000000000000000000030303034242424297979797E9E9
      E9E9FFFFFFFFF3F3F3F38A8A8A8A040404040000000000000000000000000000
      00000000000000000000000000008E8E8E8EF8F8F8F800000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E5E5E5E5A3A3A3A3000000000000000003030303424242429797
      9797E9E9E9E9FFFFFFFFF3F3F3F3A7A7A7A75252525209090909000000000000
      000000000000000000000000000000000000000000000000000010101010E0E0
      E0E0C0C0C0C00000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000088888888FDFDFDFDA3A3
      A3A39C9C9C9CE9E9E9E9FFFFFFFFFFFFFFFFFFFFFFFFDADADADA919191918888
      8888888888888888888888888888888888888888888888888888888888888888
      88888888888891919191E0E0E0E0F9F9F9F93131313100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000606060689898989E6E6E6E6FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F8F8C2C2C2C23131
      3131000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000}
    SpeedButtonOptions.CanBeFocused = False
    SpeedButtonOptions.Flat = True
    SpeedButtonOptions.Transparent = True
    TabOrder = 1
    TabStop = False
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWhite
    Font.Height = -23
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = CloseButtonClick
  end
  object MenuSearchButton: TAdvSmoothButton
    Left = 821
    Top = 695
    Width = 198
    Height = 64
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
    Appearance.Rounding = 5
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
    Caption = #47700#45684#51312#54924
    Color = 8404992
    ParentFont = False
    Shadow = True
    DisabledColor = clWhite
    TabOrder = 2
    TabStop = False
    ShowFocus = False
    HorizontalSpacing = 0
    VerticalSpacing = 0
    Version = '2.2.2.0'
    OnClick = MenuSearchButtonClick
    TMSStyle = 8
  end
  object Minute5Button: TAdvSmoothButton
    Tag = 5
    Left = 8
    Top = 694
    Width = 107
    Height = 60
    Cursor = crHandPoint
    Appearance.PictureAlignment = taCenter
    Appearance.PictureStretchMode = pmStretch
    Appearance.Font.Charset = HANGEUL_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -20
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = [fsBold]
    Appearance.ShiftDown = 0
    Appearance.FocusColor = clWhite
    Appearance.SimpleLayout = True
    Appearance.Rounding = 5
    Status.Visible = True
    Status.Caption = 'V'
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
    Caption = '5'#48516
    Color = 8404992
    ParentFont = False
    Shadow = True
    DisabledColor = clWhite
    TabOrder = 3
    TabStop = False
    ShowFocus = False
    HorizontalSpacing = 0
    VerticalSpacing = 0
    Version = '2.2.2.0'
    OnClick = Minute5ButtonClick
    TMSStyle = 8
  end
  object Minute10Button: TAdvSmoothButton
    Tag = 10
    Left = 118
    Top = 694
    Width = 107
    Height = 61
    Cursor = crHandPoint
    Appearance.PictureAlignment = taCenter
    Appearance.PictureStretchMode = pmStretch
    Appearance.Font.Charset = HANGEUL_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -20
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = [fsBold]
    Appearance.ShiftDown = 0
    Appearance.FocusColor = clWhite
    Appearance.SimpleLayout = True
    Appearance.Rounding = 5
    Status.Caption = 'V'
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
    Caption = '10'#48516
    Color = 8404992
    ParentFont = False
    Shadow = True
    DisabledColor = clWhite
    TabOrder = 4
    TabStop = False
    ShowFocus = False
    HorizontalSpacing = 0
    VerticalSpacing = 0
    Version = '2.2.2.0'
    OnClick = Minute5ButtonClick
    TMSStyle = 8
  end
  object Minute15Button: TAdvSmoothButton
    Tag = 15
    Left = 228
    Top = 694
    Width = 107
    Height = 60
    Cursor = crHandPoint
    Appearance.PictureAlignment = taCenter
    Appearance.PictureStretchMode = pmStretch
    Appearance.Font.Charset = HANGEUL_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -20
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = [fsBold]
    Appearance.ShiftDown = 0
    Appearance.FocusColor = clWhite
    Appearance.SimpleLayout = True
    Appearance.Rounding = 5
    Status.Caption = 'V'
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
    Caption = '15'#48516
    Color = 8404992
    ParentFont = False
    Shadow = True
    DisabledColor = clWhite
    TabOrder = 5
    TabStop = False
    ShowFocus = False
    HorizontalSpacing = 0
    VerticalSpacing = 0
    Version = '2.2.2.0'
    OnClick = Minute5ButtonClick
    TMSStyle = 8
  end
  object Minute20Button: TAdvSmoothButton
    Tag = 20
    Left = 337
    Top = 694
    Width = 107
    Height = 60
    Cursor = crHandPoint
    Appearance.PictureAlignment = taCenter
    Appearance.PictureStretchMode = pmStretch
    Appearance.Font.Charset = HANGEUL_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -20
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = [fsBold]
    Appearance.ShiftDown = 0
    Appearance.FocusColor = clWhite
    Appearance.SimpleLayout = True
    Appearance.Rounding = 5
    Status.Caption = 'V'
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
    Caption = '20'#48516
    Color = 8404992
    ParentFont = False
    Shadow = True
    DisabledColor = clWhite
    TabOrder = 6
    TabStop = False
    ShowFocus = False
    HorizontalSpacing = 0
    VerticalSpacing = 0
    Version = '2.2.2.0'
    OnClick = Minute5ButtonClick
    TMSStyle = 8
  end
  object FullButton: TAdvSmoothButton
    Left = 454
    Top = 695
    Width = 115
    Height = 60
    Cursor = crHandPoint
    Appearance.PictureAlignment = taCenter
    Appearance.PictureStretchMode = pmStretch
    Appearance.Font.Charset = HANGEUL_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -20
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = [fsBold]
    Appearance.ShiftDown = 0
    Appearance.FocusColor = clWhite
    Appearance.SimpleLayout = True
    Appearance.Rounding = 5
    Status.Visible = True
    Status.Caption = 'V'
    Status.Appearance.Fill.Color = 204
    Status.Appearance.Fill.ColorMirror = clNone
    Status.Appearance.Fill.ColorMirrorTo = clNone
    Status.Appearance.Fill.GradientType = gtSolid
    Status.Appearance.Fill.GradientMirrorType = gtSolid
    Status.Appearance.Fill.BorderColor = clGray
    Status.Appearance.Fill.Rounding = 11
    Status.Appearance.Fill.ShadowOffset = 0
    Status.Appearance.Fill.Glow = gmNone
    Status.Appearance.Font.Charset = DEFAULT_CHARSET
    Status.Appearance.Font.Color = clWhite
    Status.Appearance.Font.Height = -13
    Status.Appearance.Font.Name = #47569#51008' '#44256#46357
    Status.Appearance.Font.Style = []
    Caption = #51204#52404
    Color = 16744448
    ParentFont = False
    Shadow = True
    DisabledColor = clWhite
    TabOrder = 7
    TabStop = False
    ShowFocus = False
    HorizontalSpacing = 0
    VerticalSpacing = 0
    Version = '2.2.2.0'
    OnClick = FullButtonClick
    TMSStyle = 8
  end
  object PosButton: TAdvSmoothButton
    Left = 571
    Top = 696
    Width = 118
    Height = 60
    Cursor = crHandPoint
    Appearance.PictureAlignment = taCenter
    Appearance.PictureStretchMode = pmStretch
    Appearance.Font.Charset = HANGEUL_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -20
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = [fsBold]
    Appearance.ShiftDown = 0
    Appearance.FocusColor = clWhite
    Appearance.SimpleLayout = True
    Appearance.Rounding = 5
    Status.Caption = 'V'
    Status.Appearance.Fill.Color = 204
    Status.Appearance.Fill.ColorMirror = clNone
    Status.Appearance.Fill.ColorMirrorTo = clNone
    Status.Appearance.Fill.GradientType = gtSolid
    Status.Appearance.Fill.GradientMirrorType = gtSolid
    Status.Appearance.Fill.BorderColor = clGray
    Status.Appearance.Fill.Rounding = 11
    Status.Appearance.Fill.ShadowOffset = 0
    Status.Appearance.Fill.Glow = gmNone
    Status.Appearance.Font.Charset = DEFAULT_CHARSET
    Status.Appearance.Font.Color = clWhite
    Status.Appearance.Font.Height = -13
    Status.Appearance.Font.Name = #47569#51008' '#44256#46357
    Status.Appearance.Font.Style = []
    Caption = #54252#49828
    Color = 16744448
    ParentFont = False
    Shadow = True
    DisabledColor = clWhite
    TabOrder = 8
    TabStop = False
    ShowFocus = False
    HorizontalSpacing = 0
    VerticalSpacing = 0
    Version = '2.2.2.0'
    OnClick = FullButtonClick
    TMSStyle = 8
  end
  object LetsOrderButton: TAdvSmoothButton
    Left = 691
    Top = 697
    Width = 119
    Height = 60
    Cursor = crHandPoint
    Appearance.PictureAlignment = taCenter
    Appearance.PictureStretchMode = pmStretch
    Appearance.Font.Charset = HANGEUL_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -20
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = [fsBold]
    Appearance.ShiftDown = 0
    Appearance.FocusColor = clWhite
    Appearance.SimpleLayout = True
    Appearance.Rounding = 5
    Status.Caption = 'V'
    Status.Appearance.Fill.Color = 204
    Status.Appearance.Fill.ColorMirror = clNone
    Status.Appearance.Fill.ColorMirrorTo = clNone
    Status.Appearance.Fill.GradientType = gtSolid
    Status.Appearance.Fill.GradientMirrorType = gtSolid
    Status.Appearance.Fill.BorderColor = clGray
    Status.Appearance.Fill.Rounding = 11
    Status.Appearance.Fill.ShadowOffset = 0
    Status.Appearance.Fill.Glow = gmNone
    Status.Appearance.Font.Charset = DEFAULT_CHARSET
    Status.Appearance.Font.Color = clWhite
    Status.Appearance.Font.Height = -13
    Status.Appearance.Font.Name = #47569#51008' '#44256#46357
    Status.Appearance.Font.Style = []
    Caption = #47131#52768#50724#45908
    Color = 16744448
    ParentFont = False
    Shadow = True
    DisabledColor = clWhite
    TabOrder = 9
    TabStop = False
    ShowFocus = False
    HorizontalSpacing = 0
    VerticalSpacing = 0
    Version = '2.2.2.0'
    OnClick = FullButtonClick
    TMSStyle = 8
  end
  object GridPrevButton: TAdvGlassButton
    Left = 966
    Top = 57
    Width = 46
    Height = 152
    BackColor = 5844224
    BackGroundSymbolColor = 3881787
    Caption = #9650
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -20
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = [fsBold]
    ForeColor = clWhite
    GlowColor = 16760205
    ImageIndex = -1
    InnerBorderColor = clBlack
    OuterBorderColor = clWhite
    ParentFont = False
    ShineColor = clWhite
    TabOrder = 10
    Version = '1.3.3.0'
    OnClick = GridPrevButtonClick
  end
  object GridNextButton: TAdvGlassButton
    Left = 966
    Top = 529
    Width = 46
    Height = 152
    BackColor = 5844224
    BackGroundSymbolColor = 3881787
    Caption = #9660
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -20
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = [fsBold]
    ForeColor = clWhite
    GlowColor = 16760205
    ImageIndex = -1
    InnerBorderColor = clBlack
    OuterBorderColor = clWhite
    ParentFont = False
    ShineColor = clWhite
    TabOrder = 11
    Version = '1.3.3.0'
    OnClick = GridPrevButtonClick
  end
  object CashbyButton: TAdvSmoothToggleButton
    Left = 365
    Top = 4
    Width = 124
    Height = 48
    HelpType = htKeyword
    RepeatInterval = 0
    FontColorDisabled = clWhite
    Color = 14643200
    ColorDisabled = 8404992
    ColorDown = 8404992
    BorderColor = clWhite
    BorderInnerColor = 6160384
    BevelWidth = 0
    BevelColorDisabled = 8404992
    DropDownArrowColor = clWhite
    AutoToggle = False
    Appearance.GlowPercentage = 20
    Appearance.PictureAlignment = taCenter
    Appearance.PictureStretch = True
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -20
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
    Appearance.FocusColor = clWhite
    Appearance.SimpleLayout = True
    Appearance.ImageIndex = 0
    Appearance.Rounding = 5
    Caption = #44148#48324
    Version = '1.7.2.2'
    Status.Caption = 'V'
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
    ParentFont = False
    TabOrder = 12
    OnClick = CashbyButtonClick
    TMSStyle = 0
  end
  object TableByButton: TAdvSmoothToggleButton
    Left = 494
    Top = 4
    Width = 123
    Height = 48
    RepeatInterval = 0
    FontColorDisabled = clWhite
    Color = 7945472
    ColorDisabled = 8404992
    ColorDown = 8404992
    BorderColor = clWhite
    BorderInnerColor = 6160384
    BevelWidth = 0
    BevelColorDisabled = 8404992
    DropDownArrowColor = clWhite
    AutoToggle = False
    Appearance.GlowPercentage = 20
    Appearance.PictureAlignment = taCenter
    Appearance.PictureStretch = True
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -20
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
    Appearance.FocusColor = clWhite
    Appearance.SimpleLayout = False
    Appearance.ImageIndex = 0
    Appearance.Rounding = 5
    Caption = #53580#51060#48660#48324
    Version = '1.7.2.2'
    Status.Caption = 'V'
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
    ParentFont = False
    TabOrder = 13
    OnClick = CashbyButtonClick
    TMSStyle = 0
  end
  object DetailOrderButton: TAdvSmoothToggleButton
    Left = 966
    Top = 324
    Width = 48
    Height = 85
    RepeatInterval = 0
    FontColorDisabled = clWhite
    Color = 7945472
    ColorDisabled = 8404992
    ColorDown = 8404992
    BorderColor = clWhite
    BorderInnerColor = 6160384
    BevelWidth = 0
    BevelColorDisabled = 8404992
    DropDownArrowColor = clWhite
    AutoToggle = False
    Picture.Data = {
      89504E470D0A1A0A0000000D494844520000001E0000001E08060000003B30AE
      A2000000097048597300000B1300000B1301009A9C180000020249444154789C
      EDD64F888D5118C7F177AEC6584C42363264C542582AB323F9939DB5F1676585
      853F49C8CA4611D92836B3D0A54CEE284976EE2D4AB62C87908D86E44FC947A7
      7B26C73BF77DEFBDBA7736FCEA5DDCE7FCEEF9BEE739CFFB9C93653D1036E01C
      EEE0216EE20856F462FE59C2324C28D6775CC050D62B61355EEB4C8F31DCC9A4
      83317D2305E3C378A13BDD6E07DD8857C91FAAF954E14C07A09F7880F7496C6B
      D94A03B48E518CE16B00259E0ADE76003D18FDDB92F8441138A4376853121B47
      A38567465FF0B11534FACF27639F31D00A3C120D7BE3EF8100C564E2D9958384
      225B147D79E8C916D9585AB4EA6A4CEF7832D9E6647C676EA27531BE10BBDB40
      839614818762F1847DAEA5D038BED69F7A13569DF31441A7B3BF554CFF5411BC
      041A54ED045029193B6AB6A6F154B946CB80A1C026E33EBFC3F17C2562019EEB
      4ED74B578927F15B3E84CBB1B80EB4F0AEC4CB0EA1F74BFB35D644E3F6247617
      8F92FDBD34F34960316EE04701F0134E615E213407DE91C46A39F0355CC4FCC4
      B30A87433A434FC6D5D00B0A3F9D36A90E135D294A75CFA5595CB5585CA1271F
      6BD9E6FAF80295EC9F9066CB3C1BFBF43D6C992BF0ADE490A8C7E2EA2FDCEF63
      71ACE458DC8F135D3E7BDA818B2E02F5E4459EE143974FA31D78309E3C8D78F5
      D9876F389DF55B9A97BDA9B2CB5E3FE183588FE57302FCAFAC8FFA05B13F1E61
      854DA5090000000049454E44AE426082}
    Appearance.GlowPercentage = 20
    Appearance.PictureAlignment = taCenter
    Appearance.PictureStretch = True
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -20
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
    Appearance.FocusColor = clWhite
    Appearance.SimpleLayout = False
    Appearance.ImageIndex = 0
    Appearance.Rounding = 5
    Version = '1.7.2.2'
    Status.Caption = 'V'
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
    ParentFont = False
    TabOrder = 14
    OnClick = DetailOrderButtonClick
    TMSStyle = 0
  end
  object StyleRepository: TcxStyleRepository
    Left = 448
    Top = 128
    PixelsPerInch = 96
    object StyleFontRed: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = []
      TextColor = clRed
    end
    object StyleHeader: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 8404992
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = []
      TextColor = clWhite
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = [fsBold]
    end
  end
  object DetailTimer: TTimer
    Enabled = False
    Interval = 1
    OnTimer = DetailTimerTimer
    Left = 704
    Top = 8
  end
end
