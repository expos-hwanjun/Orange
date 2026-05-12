object BookingList_F: TBookingList_F
  Left = 280
  Top = 65
  BorderStyle = bsNone
  Caption = 'BookingList_F'
  ClientHeight = 768
  ClientWidth = 1024
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TitleLabel: TLabel
    Left = 125
    Top = 4
    Width = 177
    Height = 42
    AutoSize = False
    Caption = #50696#50557#54788#54889
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWhite
    Font.Height = -31
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object MonthLabel: TLabel
    Left = 676
    Top = 4
    Width = 187
    Height = 42
    Alignment = taCenter
    AutoSize = False
    Caption = '2020'#45380'5'#50900
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWhite
    Font.Height = -31
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = []
    ParentFont = False
    Transparent = True
    Layout = tlCenter
  end
  object ReservePager: TAdvPageControl
    Left = 8
    Top = 62
    Width = 1008
    Height = 697
    ActivePage = CalendarTabSheet
    ActiveFont.Charset = DEFAULT_CHARSET
    ActiveFont.Color = clWhite
    ActiveFont.Height = -20
    ActiveFont.Name = #47569#51008' '#44256#46357
    ActiveFont.Style = []
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = []
    ParentFont = False
    DefaultTabColor = clWhite
    DefaultTabColorTo = clWhite
    ActiveColor = 7274496
    ActiveColorTo = 12615680
    TabBackGroundColor = clBtnFace
    TabMargin.TopMargin = 7
    TabMargin.RightMargin = 0
    TabOverlap = 0
    TabSplitLine = True
    Version = '2.0.3.0'
    PersistPagesState.Location = plRegistry
    PersistPagesState.Enabled = False
    TabHeight = 50
    TabOrder = 0
    TabWidth = 180
    object CalendarTabSheet: TAdvTabSheet
      Caption = '  '#51068#51088#48324' '#50696#50557#54788#54889'  '
      Color = clWhite
      ColorTo = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -20
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabColor = clWhite
      TabColorTo = clWhite
      OnResize = CalendarTabSheetResize
      object SumLabel: TcxLabel
        Tag = 8
        Left = 744
        Top = 4
        AutoSize = False
        Caption = #54633#12288#44228
        ParentColor = False
        ParentFont = False
        Style.BorderStyle = ebsFlat
        Style.Color = clWhite
        Style.Font.Charset = HANGEUL_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        Height = 29
        Width = 105
        AnchorX = 797
        AnchorY = 19
      end
      object SatLabel: TcxLabel
        Tag = 7
        Left = 638
        Top = 4
        AutoSize = False
        Caption = #53664#50836#51068
        ParentColor = False
        ParentFont = False
        Style.BorderStyle = ebsFlat
        Style.Color = clWhite
        Style.Font.Charset = HANGEUL_CHARSET
        Style.Font.Color = clBlue
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        Height = 29
        Width = 105
        AnchorX = 691
        AnchorY = 19
      end
      object ThuLabel: TcxLabel
        Tag = 5
        Left = 426
        Top = 4
        AutoSize = False
        Caption = #47785#50836#51068
        ParentColor = False
        ParentFont = False
        Style.BorderStyle = ebsFlat
        Style.Color = clWhite
        Style.Font.Charset = HANGEUL_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        Height = 29
        Width = 105
        AnchorX = 479
        AnchorY = 19
      end
      object WedLabel: TcxLabel
        Tag = 4
        Left = 320
        Top = 4
        AutoSize = False
        Caption = #49688#50836#51068
        ParentColor = False
        ParentFont = False
        Style.BorderStyle = ebsFlat
        Style.Color = clWhite
        Style.Font.Charset = HANGEUL_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        Height = 29
        Width = 105
        AnchorX = 373
        AnchorY = 19
      end
      object TueLabel: TcxLabel
        Tag = 3
        Left = 215
        Top = 4
        AutoSize = False
        Caption = #54868#50836#51068
        ParentColor = False
        ParentFont = False
        Style.BorderStyle = ebsFlat
        Style.Color = clWhite
        Style.Font.Charset = HANGEUL_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        Height = 29
        Width = 105
        AnchorX = 268
        AnchorY = 19
      end
      object SunLabel: TcxLabel
        Tag = 1
        Left = 3
        Top = 4
        AutoSize = False
        Caption = #51068#50836#51068
        ParentColor = False
        ParentFont = False
        Style.BorderStyle = ebsFlat
        Style.Color = clWhite
        Style.Font.Charset = HANGEUL_CHARSET
        Style.Font.Color = clRed
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        Height = 29
        Width = 105
        AnchorX = 56
        AnchorY = 19
      end
      object MonLabel: TcxLabel
        Tag = 2
        Left = 109
        Top = 4
        AutoSize = False
        Caption = #50900#50836#51068
        ParentColor = False
        ParentFont = False
        Style.BorderStyle = ebsFlat
        Style.Color = clWhite
        Style.Font.Charset = HANGEUL_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        Height = 29
        Width = 105
        AnchorX = 162
        AnchorY = 19
      end
      object FriLabel: TcxLabel
        Tag = 6
        Left = 532
        Top = 4
        AutoSize = False
        Caption = #44552#50836#51068
        ParentColor = False
        ParentFont = False
        Style.BorderStyle = ebsFlat
        Style.Color = clWhite
        Style.Font.Charset = HANGEUL_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = #47569#51008' '#44256#46357
        Style.Font.Style = []
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        Height = 29
        Width = 105
        AnchorX = 585
        AnchorY = 19
      end
    end
    object DayTabSheet: TAdvTabSheet
      Caption = '   '#51068#51068#50696#50557#54788#54889
      Color = clWhite
      ColorTo = clNone
      TabColor = clWhite
      TabColorTo = clWhite
      OnShow = DayTabSheetShow
      object Grid: TcxGrid
        Left = 0
        Top = 0
        Width = 1000
        Height = 637
        Align = alClient
        Font.Charset = HANGEUL_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #47569#51008' '#44256#46357
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = False
        LevelTabs.Style = 2
        LookAndFeel.Kind = lfUltraFlat
        LookAndFeel.NativeStyle = False
        object GridTableView: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsSelection.CellSelect = False
          OptionsView.DataRowHeight = 30
          OptionsView.GroupByBox = False
          OptionsView.HeaderHeight = 30
          Styles.Header = StyleHeader
          object GridTableViewColumn1: TcxGridColumn
            Caption = #50696#50557#51068#51088
            DataBinding.FieldName = 'YMD_RESERVE'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            HeaderAlignmentHorz = taCenter
            Width = 114
          end
          object GridTableViewColumn2: TcxGridColumn
            Caption = #50696#50557#51088#47749
            DataBinding.FieldName = 'NM_GUST'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            HeaderAlignmentHorz = taCenter
            Width = 136
          end
          object GridTableViewColumn3: TcxGridColumn
            Caption = #50672#46973#52376
            DataBinding.FieldName = 'TEL_MOBILE'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            HeaderAlignmentHorz = taCenter
            Width = 148
          end
          object GridTableViewColumn4: TcxGridColumn
            Caption = #50696#50557#49884#44036
            DataBinding.FieldName = 'RESERVE_TIME'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            HeaderAlignmentHorz = taCenter
            Width = 114
          end
          object GridTableViewColumn5: TcxGridColumn
            Caption = #50696#50557#51064#50896
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'CNT_PERSON'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = '#0'#47749
            HeaderAlignmentHorz = taCenter
            Width = 88
          end
          object GridTableViewColumn6: TcxGridColumn
            Caption = #50696#50557#44552#50529
            DataBinding.ValueType = 'Currency'
            DataBinding.FieldName = 'AMT_BOOKING'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = ',0'
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object GridTableViewColumn7: TcxGridColumn
            Caption = #48169#47928
            DataBinding.FieldName = 'YN_VISIT'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            HeaderAlignmentHorz = taCenter
            Width = 88
          end
          object GridTableViewColumn8: TcxGridColumn
            Caption = #48708#44256
            DataBinding.FieldName = 'REMARK'
            HeaderAlignmentHorz = taCenter
            Width = 186
          end
        end
        object GridLevel: TcxGridLevel
          GridView = GridTableView
        end
      end
    end
  end
  object CloseButton: TcxButton
    AlignWithMargins = True
    Left = 961
    Top = 2
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
  object PrevMonthButton: TAdvGlassButton
    Left = 616
    Top = 4
    Width = 51
    Height = 43
    BackColor = 5844224
    Caption = '<'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -27
    Font.Name = #44404#47548#52404
    Font.Style = [fsBold]
    ForeColor = clWhite
    GlowColor = 6160384
    ImageIndex = -1
    InnerBorderColor = clNone
    OuterBorderColor = clNone
    ParentFont = False
    ShineColor = 5844224
    TabOrder = 2
    Version = '1.3.3.0'
    OnClick = PrevMonthButtonClick
  end
  object NextMonthButton: TAdvGlassButton
    Left = 867
    Top = 4
    Width = 48
    Height = 43
    BackColor = 5844224
    Caption = '>'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -27
    Font.Name = #44404#47548#52404
    Font.Style = [fsBold]
    ForeColor = clWhite
    GlowColor = 6160384
    ImageIndex = -1
    InnerBorderColor = clNone
    OuterBorderColor = clNone
    ParentFont = False
    ShineColor = 5844224
    TabOrder = 3
    Version = '1.3.3.0'
    OnClick = NextMonthButtonClick
  end
  object StyleRepository: TcxStyleRepository
    Left = 416
    Top = 304
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
      AssignedValues = [svColor, svFont]
      Color = 16768189
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = []
    end
  end
end
