object WebOrder_F: TWebOrder_F
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'WebOrder_F'
  ClientHeight = 768
  ClientWidth = 1024
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = #47569#51008' '#44256#46357
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 23
  object CaptionLabel: TLabel
    Left = 125
    Top = 4
    Width = 204
    Height = 42
    AutoSize = False
    Caption = #48156#51452#46321#47197
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWhite
    Font.Height = -31
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Grid: TcxGrid
    Left = 9
    Top = 229
    Width = 1005
    Height = 456
    BevelInner = bvNone
    BevelOuter = bvRaised
    BevelKind = bkFlat
    BorderWidth = 1
    BorderStyle = cxcbsNone
    TabOrder = 0
    TabStop = False
    LookAndFeel.Kind = lfFlat
    LookAndFeel.NativeStyle = False
    object GridTableView: TcxGridTableView
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Visible = fvNever
      OnFocusedRecordChanged = GridTableViewFocusedRecordChanged
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = ',0'
          Kind = skSum
          Column = GridTableViewOrderNetAmt
        end
        item
          Format = ',0'
          Kind = skSum
          Column = GridTableViewOrderVatAmt
        end
        item
          Format = ',0'
          Kind = skSum
          Column = GridTableViewOrderAmt
        end>
      DataController.Summary.SummaryGroups = <>
      DataController.OnAfterPost = GridTableViewDataControllerAfterPost
      NewItemRow.InfoText = #49345#54408#51012' '#52628#44032#54616#47140#47732' '#51060#44275#51012' '#45572#47476#49901#49884#50724'.'
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.FocusFirstCellOnNewRecord = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsBehavior.FocusCellOnCycle = True
      OptionsView.GroupByBox = False
      OptionsView.HeaderHeight = 35
      Styles.Footer = StyleFooter
      Styles.Header = StyleHeader
      object GridTableViewGoodsCode: TcxGridColumn
        Caption = #49345#54408#53076#46300
        DataBinding.FieldName = 'CD_GOODS'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        HeaderAlignmentHorz = taCenter
        Options.Filtering = False
        Options.Focusing = False
        Width = 124
      end
      object GridTableViewGoodsName: TcxGridColumn
        Caption = #49345#54408#51060#47492
        DataBinding.FieldName = 'NM_GOODS'
        HeaderAlignmentHorz = taCenter
        Options.Filtering = False
        Options.Focusing = False
        Width = 431
      end
      object GridTableViewOrderUnit: TcxGridColumn
        Caption = #48156#51452#45800#50948
        DataBinding.FieldName = 'NM_UNIT'
        HeaderAlignmentHorz = taCenter
        Options.Filtering = False
        Options.Focusing = False
        Width = 119
      end
      object GridTableViewNepumQty: TcxGridColumn
        Caption = #51077#49688
        DataBinding.ValueType = 'Currency'
        DataBinding.FieldName = 'QTY_NEPUM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        HeaderAlignmentHorz = taCenter
        Options.Filtering = False
        Options.Focusing = False
      end
      object GridTableViewOrderQty: TcxGridColumn
        Caption = #48156#51452#49688#47049
        DataBinding.ValueType = 'Currency'
        DataBinding.FieldName = 'QTY_ORDER'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0'
        Properties.OnValidate = GridTableViewOrderQtyPropertiesValidate
        HeaderAlignmentHorz = taCenter
        Options.Filtering = False
        Width = 104
      end
      object GridTableViewOrderPrice: TcxGridColumn
        Caption = #48156#51452#45800#44032
        DataBinding.ValueType = 'Currency'
        DataBinding.FieldName = 'PR_ORDER'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DecimalPlaces = 2
        Properties.DisplayFormat = ',0.00'
        HeaderAlignmentHorz = taCenter
        Options.Filtering = False
        Options.Focusing = False
        Width = 127
      end
      object GridTableViewOrderNetAmt: TcxGridColumn
        Caption = #44277#44553#44552#50529
        DataBinding.ValueType = 'Currency'
        DataBinding.FieldName = 'AMT_DUTY'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Visible = False
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taCenter
        Options.Filtering = False
        Options.Focusing = False
        Width = 102
      end
      object GridTableViewOrderNotAmt: TcxGridColumn
        Tag = 99
        Caption = #47732#49464#44552#50529
        DataBinding.ValueType = 'Currency'
        DataBinding.FieldName = 'AMT_DUTYFREE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Visible = False
      end
      object GridTableViewOrderVatAmt: TcxGridColumn
        Caption = #48512#44032#49464
        DataBinding.ValueType = 'Currency'
        DataBinding.FieldName = 'AMT_TAX'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Visible = False
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taCenter
        Options.Filtering = False
        Options.Focusing = False
        Width = 101
      end
      object GridTableViewOrderAmt: TcxGridColumn
        Caption = #48156#51452#44552#50529
        DataBinding.ValueType = 'Currency'
        DataBinding.FieldName = 'AMT_ORDER'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0'
        Visible = False
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taCenter
        Options.Filtering = False
        Options.Focusing = False
        Width = 105
      end
      object GridTableViewDsTax: TcxGridColumn
        Tag = 99
        Caption = #44284#49464#44396#48516
        DataBinding.FieldName = 'DS_TAX'
        Visible = False
      end
      object GridTableViewSeq: TcxGridColumn
        Tag = 99
        Caption = #49692#48264
        DataBinding.FieldName = 'SEQ'
        Visible = False
      end
      object GridTableViewRowState: TcxGridColumn
        Tag = 99
        Caption = #49345#53468
        DataBinding.FieldName = 'ROW_STATE'
        Visible = False
      end
    end
    object GridLevel: TcxGridLevel
      GridView = GridTableView
    end
  end
  object SaveButton: TAdvSmoothButton
    Left = 824
    Top = 700
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
    Caption = #48156#51452#51200#51109
    Color = 11031552
    ParentFont = False
    Picture.Data = {
      89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
      F800000006624B474400FF00FF00FFA0BDA793000001BF494441544889ED93BF
      6B54511085BF13DC24856BA3166263CA14818856C18086FC094111044D63632B
      088246632F898818302076B1B3175208110541FF00833F0A11ED62132C3E0BAF
      E4F9B2FB7613051B4FF366E6CEDC7366EE1BF88F1E48D551E7801160131805BE
      0063C06AC31DD3C06B6025C9E34636F561C5BEA81E53EF77C83BAF5E29F652F9
      DE524FD773076AFE66A3822D9C02C6AB8124D780B13A499DE08F5048CE54637B
      7679D72BE07097B3AFFD12BC012E03C77FCDB98E12FFDCA4A42B419217C0D9A6
      E27EF057DFE09F10741D516DE99A300CBC4D32BF23026024C9859E12F97D4177
      4270489D60EBB73B00B48AFDBD161F52E7813630AEB6936C7452B2D4C96E50DE
      561FA8B3EA4175589D5097D5A95E1D8CA8278A528BD2C14A072F8105E046928F
      95BA35F539B0A07EDA7507EA4975B6437C6FE9A2ADDEDDD6813A99E41970A4F6
      06FB6B1D4C038BB5DA7DC012703DC986BA6D4443C08762BF4BB2D6D0C10CF04D
      6D0173C06DE01E7035C97A496BD509D6819BEA2630D9634CE3C0D1246BEA53E0
      09702EC9FB4ACE60E7D23E5066BCACA6F803B5F319B5AF3D6A22995217D57687
      CBEFA849B7E21D908C02978ADBE2E73BAE028F92F803054AFD5EF42C87400000
      000049454E44AE426082}
    Shadow = True
    DisabledColor = clWhite
    TabOrder = 1
    ShowFocus = False
    HorizontalSpacing = 0
    VerticalSpacing = 0
    Version = '2.1.1.5'
    OnClick = SaveButtonClick
    TMSStyle = 0
  end
  object MenuAddButton: TAdvSmoothButton
    Left = 33
    Top = 700
    Width = 200
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
    Caption = #48156#51452#49345#54408' '#52628#44032
    Color = 11031552
    ParentFont = False
    Picture.Data = {
      89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
      0D00000006624B474400FF00FF00FFA0BDA7930000010649444154388DED92AD
      4E03411446CF6DD680C150B71602A2AA75A58F82DD6780205068342049106D09
      E12170FC294A78065EA11CCC6CB382B2D95D24379964EE37F9CE7C3733A1DE03
      3920ED6A13388D881900EA534B50E91FA917659F011BEAB00373AFDA64401F28
      3A00B781CF55A73E7680A10EAB23F7BAC07EAAAC72D33E700D9C25E9A4C6BB88
      88C3B5C0885800A3CAD9DD7FC2750997C0D74AFD836FD353B75A278C88919A03
      E7C020C96FEA51447C344EA8E6EAB33AAE6863F545CDDB0067254C2DD422ED27
      EA3403FAA558534BE0061844C443F24C128C88B854AF7AC071938475033477E8
      ED2F23CFDB0077D3031C54B489FAAAEE34062640AE4ED5F7B4E625EC1B16EAD0
      291792A4950000000049454E44AE426082}
    Shadow = True
    DisabledColor = clWhite
    TabOrder = 2
    ShowFocus = False
    HorizontalSpacing = 0
    VerticalSpacing = 0
    Version = '2.1.1.5'
    OnClick = MenuAddButtonClick
    TMSStyle = 0
  end
  object MenuDeleteButton: TAdvSmoothButton
    Left = 256
    Top = 700
    Width = 193
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
    Caption = #48156#51452#49345#54408' '#49325#51228
    Color = 8355711
    ParentFont = False
    Picture.Data = {
      89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
      0D00000006624B474400FF00FF00FFA0BDA793000001BE49444154388D9D93BF
      6A145114C67F27BB04B2B109165136EA266417124BB5F305B4D1465F401BAD85
      6D6C058B3C41CA2042207DF2002955480229560C88642DC442FC8368D8CF62BF
      49EE4C6626C40303E77EF73BBF3973CF9DA026243D071E027F2C4D02EB11F1A2
      AAA65900DC069613E931F01218793D01F4257D493CFB11B19D2DC2A08BC033E0
      06B051D775493C00DE002B11F135EBECB5A4279266CE0943D28CA4A7925EC1C9
      277F0356804792CECB045802D68A6F7A2729FEA3C390F4365B4F247B87405BD2
      75490B363725DD498AEF4A6A385F94B404CC01C332E07BA00BDC04EE5B9B02FA
      89A76F0DE01E70CB35833AE001306FED27D04A3C2DE097F3797B7BAE3D051C24
      C005808818153C610D7B0ECEEAB0C7F83C2EA5908AFC32F0D9C0D20E3F01ED88
      101092D2BD5CF8368CECBDC278A079A037F11487EEA02ADAC0D0DEA3E4182876
      F111B84A7E3047BE3E4DE0AFB56C201DD71C471138607C8EC783613CE969E082
      733819488F642065C0F4EA1481D30930EB303790BA0E3FF87300BE1BD6027E58
      EB540173216956D2A6FFCFAEB58EA4869F6BD6BAF66C499AAD04DABC53776512
      5F43D25E516F9678D7805D49BFCF604E01AB45F11F53D8DC9D6AF0FA08000000
      0049454E44AE426082}
    Shadow = True
    DisabledColor = clWhite
    TabOrder = 3
    ShowFocus = False
    HorizontalSpacing = 0
    VerticalSpacing = 0
    Version = '2.1.1.5'
    OnClick = MenuDeleteButtonClick
    TMSStyle = 0
  end
  object CloseButton: TcxButton
    AlignWithMargins = True
    Left = 956
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
    TabOrder = 4
    TabStop = False
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWhite
    Font.Height = -23
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = CloseButtonClick
  end
  object PosPanel: TAdvPanel
    Left = 9
    Top = 58
    Width = 1005
    Height = 166
    BevelOuter = bvNone
    Color = clWhite
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    UseDockManager = True
    Version = '2.5.5.1'
    BorderColor = 9868950
    BorderWidth = 1
    Caption.Color = clHighlight
    Caption.ColorTo = clNone
    Caption.Font.Charset = HANGEUL_CHARSET
    Caption.Font.Color = clHighlightText
    Caption.Font.Height = -20
    Caption.Font.Name = #47569#51008' '#44256#46357
    Caption.Font.Style = [fsBold]
    Caption.Height = 0
    Caption.Indent = 10
    Caption.Text = '<P align="center"><FONT size="14"></FONT>'#48320#44221' '#54624' '#54252#49828'</P>'
    Caption.TopIndent = 5
    Caption.Visible = True
    ColorTo = clWhite
    DoubleBuffered = True
    ShadowOffset = 5
    ShowMoveCursor = True
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clWindowText
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    Text = ''
    FullHeight = 220
    object CommentLabel: TLabel
      Left = 26
      Top = 68
      Width = 80
      Height = 28
      Caption = #50836#52397#49324#54637
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = []
      ParentFont = False
    end
    object BuyAmtLabel: TLabel
      Left = 780
      Top = 115
      Width = 80
      Height = 28
      Caption = #48156#51452#44552#50529
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label1: TLabel
      Left = 542
      Top = 24
      Width = 80
      Height = 28
      Caption = #50668#49888#44552#50529
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 541
      Top = 71
      Width = 88
      Height = 28
      Caption = #54788'  '#48120'  '#49688
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 780
      Top = 26
      Width = 80
      Height = 28
      Caption = #51092#50668#50668#49888
      Font.Charset = HANGEUL_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      Left = 541
      Top = 116
      Width = 88
      Height = 28
      Caption = #48512'  '#44032'  '#49464
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object RemarkMemo: TcxMemo
      Left = 121
      Top = 68
      ParentFont = False
      Properties.MaxLength = 100
      TabOrder = 0
      Height = 79
      Width = 400
    end
    object OrderTotalAmtEdit: TcxCurrencyEdit
      Left = 871
      Top = 112
      TabStop = False
      EditValue = 0c
      ImeMode = imSAlpha
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0'
      Properties.ImeMode = imSAlpha
      Properties.ReadOnly = True
      Properties.UseLeftAlignmentOnEditing = False
      Style.Color = clWhite
      Style.Font.Charset = HANGEUL_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -20
      Style.Font.Name = #47569#51008' '#44256#46357
      Style.Font.Style = []
      Style.TextColor = clBlack
      Style.TextStyle = [fsBold]
      Style.IsFontAssigned = True
      TabOrder = 1
      Width = 117
    end
    object cxLabel1: TcxLabel
      Left = 278
      Top = 23
      AutoSize = False
      Caption = #52636#44256#50836#52397#51068
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -20
      Style.Font.Name = #47569#51008' '#44256#46357
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taCenter
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 27
      Width = 106
      AnchorX = 331
      AnchorY = 37
    end
    object CreditAmtEdit: TcxCurrencyEdit
      Left = 635
      Top = 20
      TabStop = False
      EditValue = 0c
      ImeMode = imSAlpha
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0'
      Properties.ImeMode = imSAlpha
      Properties.ReadOnly = True
      Properties.UseLeftAlignmentOnEditing = False
      Style.Color = clWhite
      Style.Font.Charset = HANGEUL_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -20
      Style.Font.Name = #47569#51008' '#44256#46357
      Style.Font.Style = []
      Style.TextColor = clBlue
      Style.IsFontAssigned = True
      TabOrder = 3
      Width = 114
    end
    object RemainAmtEdit: TcxCurrencyEdit
      Left = 635
      Top = 67
      TabStop = False
      EditValue = 0c
      ImeMode = imSAlpha
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0'
      Properties.ImeMode = imSAlpha
      Properties.ReadOnly = True
      Properties.UseLeftAlignmentOnEditing = False
      Style.Color = clWhite
      Style.Font.Charset = HANGEUL_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -20
      Style.Font.Name = #47569#51008' '#44256#46357
      Style.Font.Style = []
      Style.TextColor = clBlue
      Style.IsFontAssigned = True
      TabOrder = 4
      Width = 114
    end
    object RestCreditAmtEdit: TcxCurrencyEdit
      Left = 870
      Top = 20
      TabStop = False
      EditValue = 0c
      ImeMode = imSAlpha
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0'
      Properties.ImeMode = imSAlpha
      Properties.ReadOnly = True
      Properties.UseLeftAlignmentOnEditing = False
      Style.Color = clWhite
      Style.Font.Charset = HANGEUL_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -20
      Style.Font.Name = #47569#51008' '#44256#46357
      Style.Font.Style = []
      Style.TextColor = clBlue
      Style.TextStyle = [fsBold]
      Style.IsFontAssigned = True
      TabOrder = 5
      Width = 117
    end
    object OrderDateEdit: TcxDateEdit
      Left = 121
      Top = 20
      AutoSize = False
      EditValue = 45379d
      ParentFont = False
      Properties.Alignment.Horz = taCenter
      Properties.ShowTime = False
      Properties.OnCloseUp = OrderDateEditPropertiesCloseUp
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -20
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 6
      Height = 37
      Width = 128
    end
    object cxLabel2: TcxLabel
      Left = 17
      Top = 23
      AutoSize = False
      Caption = #48156#51452#51068#51088
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -20
      Style.Font.Name = #47569#51008' '#44256#46357
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taCenter
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 27
      Width = 98
      AnchorX = 66
      AnchorY = 37
    end
    object RequestDateEdit: TcxDateEdit
      Left = 393
      Top = 20
      AutoSize = False
      EditValue = 45379d
      ParentFont = False
      Properties.Alignment.Horz = taCenter
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -20
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 8
      Height = 37
      Width = 128
    end
    object cxCurrencyEdit1: TcxCurrencyEdit
      Left = 635
      Top = 112
      TabStop = False
      EditValue = 0c
      ImeMode = imSAlpha
      ParentFont = False
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = ',0'
      Properties.ImeMode = imSAlpha
      Properties.ReadOnly = True
      Properties.UseLeftAlignmentOnEditing = False
      Style.Color = clWhite
      Style.Font.Charset = HANGEUL_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -20
      Style.Font.Name = #47569#51008' '#44256#46357
      Style.Font.Style = []
      Style.TextColor = clBlack
      Style.TextStyle = [fsBold]
      Style.IsFontAssigned = True
      TabOrder = 9
      Width = 114
    end
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
      Color = 8404992
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
