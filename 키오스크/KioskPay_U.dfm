object KioskPay_F: TKioskPay_F
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'KioskPay_F'
  ClientHeight = 856
  ClientWidth = 960
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    960
    856)
  PixelsPerInch = 96
  TextHeight = 13
  object KioskCardButton: TAdvSmoothButton
    Tag = 1
    Left = 102
    Top = 210
    Width = 340
    Height = 162
    InitPause = 0
    Appearance.GlowPercentage = 0
    Appearance.PictureAlignment = taCenter
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -40
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
    Appearance.Layout = blPictureTop
    Appearance.Spacing = 1
    Appearance.ShiftDown = 0
    Appearance.SimpleLayout = True
    Appearance.Rounding = 5
    Status.Caption = '0'
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
    Bevel = False
    BevelColor = 13395456
    Caption = #49888#50857#52852#46300
    Color = 13789440
    ParentFont = False
    Picture.Data = {
      89504E470D0A1A0A0000000D49484452000000320000003208060000001E3F88
      B1000000097048597300000B1300000B1301009A9C18000001A249444154789C
      ED993D4EC34010852D01211102890A242A0E4141414D68B8010D27E002FC1D20
      9C871AA8A0A10E110D9128A8AD78DE223D34DE75E4C216894DB023CD276DB1BB
      4E665E66DF5A9A4491611886D114247B22720B602422DF00D8E6213E47CDF586
      64372FE2A9E9E46A887A4CC5844AE8E28773EE986427AB54F6F05F55FEB7A4A2
      E2D3B21B12FECCAD759C737D00E3F0D92BFDF2914E544459E0360841C17E10A3
      7B43AD88E884E4E6B20921B915AA95E42BD25F3621CEB9936945005C87C95837
      DAEA11E4F649AE071199472E75B1ABCE9F37401342507C6B3DA8B0ECE1AE3A1F
      C05BD17BA46D42C4E738D44A4C45CC12B86DD7EFDC989012AC22B0A3E5318F94
      601E8179C4631E29C13C02F388C73C52827904E6118F79A404F308CC231EDF84
      4CBB90BDA8A1A335994CF6C3FE7B9DC0691712C0511D01758488C859385AF795
      038BC85DAE75BF12FDB31092DBFA2F41C8E1BC7260ED2989C8572606C001C9B5
      450B21B99124C9A91EA710FB85E46A652121F86126A6A1F11AC7F15E2D11B95F
      68474406A1A59A5E008B1C22128BC833808B995AA286611846D4103F60A3CADF
      384926EF0000000049454E44AE426082}
    DisabledColor = clWhite
    TabOrder = 0
    TabStop = False
    ShowFocus = False
    Version = '2.2.2.0'
    OnClick = KioskCardButtonClick
    TMSStyle = 8
  end
  object CancelButton: TAdvSmoothToggleButton
    Left = 320
    Top = 683
    Width = 350
    Height = 113
    FontColorDisabled = clBlack
    Color = clWhite
    ColorDisabled = clWhite
    ColorDown = clGray
    BorderColor = clGray
    BorderInnerColor = clGray
    BevelWidth = 0
    BevelColorDisabled = clWhite
    AutoToggle = False
    Picture.Data = {
      89504E470D0A1A0A0000000D49484452000000280000002808060000008CFEB8
      6D000000097048597300000B1300000B1301009A9C18000001B849444154789C
      ED99BD4A244114854B03591F42C4D011A6CE57D360474EE4660B8288C622EB23
      6862A0A1B9188A66CEBA8966ABEFA0E01BA8A138C6E2A25C686110FF7ABAC669
      B40F5C3A68B8FDD5BDB7AB8BD3CE3D93F77E02D805AE80FFC043CE684B3A9134
      E79C1B7031256949D21D700AAC00F3F6A03C1142F82DE9C01667D75AAD361405
      CE7BFF33ABD87A8C950353926E256D470104CE813F519265B20E6495ACB92202
      C66D7E1A8DC6A48BAB01491792D60A65017E1960B3D9FCE1224BD2A1A4BDA249
      E60C301A558724ED032D574415205505BB97AA19EC510593241901464BBBCD00
      9B92AE25F95202A6693A0C1C033740523AC05C90BD04F4DECF58BC76DF20B3F3
      E3B5F75E9F0EF8117554B2FD6225FB0DF82E643780D636A01533241D1987B5BB
      5EAF8F7D6DC0D84ADF7AA3FB0D98BEB7DD7CEB6D461FDCA843088DD27EEAC25B
      70FD02A4EC8785A4ECC7AD5CAA00A92AD8BDF42D6690DE9A474785CDA327FB2D
      8490BA32DA6F4F06A6A4BF2EA28085CCB51D2F9C4CD274966CC3393718215FD3
      2C6060CBC512B09899E8679256AD02794D7460D93A912DB615CD44EF80B479DC
      012E25DD77F11BC20E9DFF80D918BF211E0107857E7DB0836D25000000004945
      4E44AE426082}
    Appearance.PictureAlignment = taCenter
    Appearance.Font.Charset = DEFAULT_CHARSET
    Appearance.Font.Color = clWindowText
    Appearance.Font.Height = -40
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
    Appearance.Spacing = 1
    Appearance.ShiftDown = 0
    Appearance.SimpleLayout = True
    Appearance.Rounding = 30
    VerticalSpacing = 0
    HorizontalSpacing = 0
    Caption = #45208#44032#44592
    Version = '1.7.2.2'
    Status.Visible = True
    Status.Caption = '0'
    Status.Appearance.Fill.Color = clWhite
    Status.Appearance.Fill.ColorMirror = clNone
    Status.Appearance.Fill.ColorMirrorTo = clNone
    Status.Appearance.Fill.GradientType = gtSolid
    Status.Appearance.Fill.GradientMirrorType = gtSolid
    Status.Appearance.Fill.BorderColor = clGray
    Status.Appearance.Fill.Rounding = 12
    Status.Appearance.Fill.ShadowOffset = 0
    Status.Appearance.Fill.Glow = gmNone
    Status.Appearance.Font.Charset = DEFAULT_CHARSET
    Status.Appearance.Font.Color = clBlack
    Status.Appearance.Font.Height = -16
    Status.Appearance.Font.Name = 'Tahoma'
    Status.Appearance.Font.Style = []
    ShowFocus = False
    ParentFont = False
    Anchors = [akLeft, akBottom]
    TabOrder = 1
    OnClick = CancelButtonClick
    TMSStyle = 0
  end
  object KioskCashButton: TAdvSmoothButton
    Tag = 3
    Left = 529
    Top = 210
    Width = 340
    Height = 162
    Appearance.PictureAlignment = taCenter
    Appearance.Font.Charset = HANGEUL_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -40
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
    Appearance.Layout = blPictureTop
    Appearance.ShiftDown = 0
    Appearance.SimpleLayout = True
    Appearance.Rounding = 5
    Status.Caption = '0'
    Status.Appearance.Fill.Color = clRed
    Status.Appearance.Fill.ColorMirror = clNone
    Status.Appearance.Fill.ColorMirrorTo = clNone
    Status.Appearance.Fill.GradientType = gtSolid
    Status.Appearance.Fill.GradientMirrorType = gtSolid
    Status.Appearance.Fill.BorderColor = clGray
    Status.Appearance.Fill.Rounding = 0
    Status.Appearance.Fill.ShadowOffset = 0
    Status.Appearance.Fill.Glow = gmNone
    Status.Appearance.Font.Charset = DEFAULT_CHARSET
    Status.Appearance.Font.Color = clWhite
    Status.Appearance.Font.Height = -11
    Status.Appearance.Font.Name = 'Tahoma'
    Status.Appearance.Font.Style = []
    Caption = #54788#44552#44208#51228
    Color = 13789440
    ParentFont = False
    Picture.Data = {
      89504E470D0A1A0A0000000D49484452000000320000003208060000001E3F88
      B1000000097048597300000B1300000B1301009A9C180000034B49444154789C
      ED585D8B8D51147EF3D9C8C705175C908F1F80144AB9221742891FC01452C28D
      A1199970C1053794610C21722591A499342E94840B919099C2B810A3D079F7F3
      BC585A33EB9DB6E39879E79C33CE3E759E5A753A67AFBD9FE7ACB5F75E7B4551
      0D35D45043554344263BE7D603D818A239E7D62BC72185906C252981DB992C42
      B602700190954266DCB69429016BA82133446412C97D00EE937C13B2A19FE35E
      1199F88788388E67937C5DE98DCCE1DB2BE59E466234C9277622FC22798D6423
      C98640AD51391A5715F348444645CEB935DED1B629AA1200D89CF24E9264B57E
      71D4BEE88AAA0C24BB2D0047066E72001D798396EBC59367CBA28000A0C382D0
      EA0B694F0788C8340049815B157ABA45810040FB5042C600B803A037CF6EF66D
      AC614044C6A9554448A900B090E46992EFF474B113463FB7005810BC1011190F
      E038809F83147D3F001C2B47943012429498A69E475A2370C839B7410DC06192
      EFBDDF6F942A06232144DF08DEBF7E4A44EA0A889D6029978E6B094A489224AB
      D29B16C0890C044EA6954492242B831102E0814DF8344BBAE81892CF6CDD8741
      0821B9344D15E7DCDAAC7ECEB975DE7E595C7121000EDA643D5A8066F5B362B5
      C7D66E0E4148A74D7669B8BE242FDBDA774348AD6E9B6C4F11BE0DA514AC2873
      44BE997F7D11BEF5E6FB2D0421BD36D9B6E1FA92DC6E6B7F0A21B55EDA64078A
      20D26CBE2F421072DDFC6F1541E4B611B91682909D699E67EAC91A44640A80EF
      466447C585E472B959DE236C57563F92BB6D5DE672B99941942824AFDA1CBD22
      327DA8F1223203C0172371A5D875516E21711CCF01F035AD9D067B0E6BFAE918
      1BFB3D8EE379C108C96FCF907C4E724954B82E7B9156BEA5B69F30522F44CD7B
      AF71A6F698E459926D6913D06B0466DE4F1579B3EBFBC22B5B0A595792242BAA
      A2F9202263AD4C6FD5796DC1562DF3B54393718EA92417F9A66DAAFF2AA45488
      481D808F051A179FFD83A41A848C27F9B680900FFAEEFF9790BE6600807B5140
      109109711CCFF5CD17A150CE034D0C92FBBDB0FDD5F90815D29F7E69E5DDD4D7
      15F48ECC0BD5204644EA485EF4EEA3F97D3F903CEFE5A1F6783BD3D32640EBF4
      22A1D696BFB9CEE55D66411BFAB9B629F7BF42A621D23DA39BC70E81E0CCB835
      0DA493E1373A591CA89E5D399E0000000049454E44AE426082}
    TabOrder = 2
    TabStop = False
    ShowFocus = False
    Version = '2.2.2.0'
    OnClick = KioskCardButtonClick
    TMSStyle = 8
  end
  object KioskEasyPayButton: TAdvSmoothButton
    Tag = 2
    Left = 102
    Top = 420
    Width = 340
    Height = 162
    Appearance.PictureAlignment = taCenter
    Appearance.Font.Charset = HANGEUL_CHARSET
    Appearance.Font.Color = clWhite
    Appearance.Font.Height = -40
    Appearance.Font.Name = #47569#51008' '#44256#46357
    Appearance.Font.Style = []
    Appearance.Layout = blPictureTop
    Appearance.ShiftDown = 0
    Appearance.SimpleLayout = True
    Appearance.Rounding = 5
    Status.Visible = True
    Status.Caption = 'QR '#46608#45716' '#48148#53076#46300
    Status.Appearance.Fill.Color = clRed
    Status.Appearance.Fill.ColorMirror = clNone
    Status.Appearance.Fill.ColorMirrorTo = clNone
    Status.Appearance.Fill.GradientType = gtSolid
    Status.Appearance.Fill.GradientMirrorType = gtSolid
    Status.Appearance.Fill.BorderColor = clGray
    Status.Appearance.Fill.Rounding = 12
    Status.Appearance.Fill.ShadowOffset = 0
    Status.Appearance.Fill.Glow = gmNone
    Status.Appearance.Font.Charset = DEFAULT_CHARSET
    Status.Appearance.Font.Color = clWhite
    Status.Appearance.Font.Height = -16
    Status.Appearance.Font.Name = 'Tahoma'
    Status.Appearance.Font.Style = []
    Caption = #44036#54200#44208#51228
    Color = 13789440
    ParentFont = False
    Picture.Data = {
      89504E470D0A1A0A0000000D49484452000000320000003208060000001E3F88
      B1000000097048597300000B1300000B1301009A9C180000037249444154789C
      ED9A3D4C144114C7D78F44511B23C652E9B4F0F3626F143B2BC5040C21C68ED8
      28163640343426041B1B0882606263020D180B2CA43B72162474263656164A42
      C3EEFFBFC167E66EEE32ACFB3177DC9EBBE04BA6B8F9DAF7BB999D79FBDE731C
      43005C26390C609CE444B000181391762765119176F5AC081D946E434AD7B081
      8748CE90148B32903608C927497A00F84DF28DD2DD1C588300F00BC067004BC1
      42726E7373F374DA20AEEB9E21391FA683D66DDD809A2E0F0270C5A89C1191C3
      4EC64544DA48CE565706C025B51AC3D595C8038409A374D60B30E8E89748812C
      3B391300CB5AF7710532A97F2C39391354DE5BB522937B0704C03D0045925FA2
      0A80C5A4FB05C07D009F3CCF3B57AD1391936A6CC2DC45003DCD0029DADC2F00
      BAE34048AEEA7ECF8CB9BB2DE72E3603A4A4DB5700BC08295BBABD3701644DF7
      1B31E6EED5755B1173AFE8F65222088097FAC75C02C86844BBDF04103F62EED1
      38107569EAF6B1B25D43F271D48D9D6510B762013C12911371CFCE3C485DF21F
      24AB2BC2E423B2B6B57CDFBF066023A2DF5F201673979A01B268F330DFF76F18
      634662FA3E34803B2D4116760CA24E35CFF3BA00DC8D2ABEEF5F0FC05741BE07
      FADD129183665F35366E6ECFF3BAAC4EA534C4005973F22CD82B2022B29F647F
      8849F25C5D724E5E40D4A916F372BF4F4529113900E03CC982EBBA1D31FD8E6A
      775281E4EB8415390EE043C05CFFA94FA88FA98028978BE982F13CEF4E8862FB
      487E0DF977D7EA7D0E5204990E80DCAE03E45D664064FBD68A7C1145E488B1B5
      0A002EA8B10D806C04B65C09409F931511916324AF46B503781573B367C79FA0
      CC0CADD483B0761139A5FDCEC12379C4F3BCB34E5624CCFACDA5F05F83889DD1
      58B37CEB0551632D8CC6F6569AF19DF582F8BE7FB365663C1AF8B0B20569F587
      5569CF3A1FA412BFE827F9B45A00FCC81D08634267CA544F05442A0EBA8128F3
      A31190AA190F0024BF19456DAF42B3405CD7ED50BA974FB5345CA6B65F884D75
      993205277603203B77623385B0820A1DE8FAD504909686157A2C023D0BE6EDAB
      82393A94DC6791186013E8E9DE31489605BB156462B784A7878C848136275F09
      03EB7A4506CB19413A414555CCE601462A26D0DBAA4304C0C53097CF7A4C52CD
      7C2B3C816E7D493553C134A7696365F292E634B52DCDA92A6A897452575CE259
      EA2E7E8BC4B3C1DA76D2F207107A4D872E9CC6450000000049454E44AE426082}
    TabOrder = 3
    TabStop = False
    ShowFocus = False
    Version = '2.2.2.0'
    OnClick = KioskCardButtonClick
    TMSStyle = 8
  end
  object HeaderPanel: TAdvPanel
    Left = 8
    Top = 8
    Width = 946
    Height = 120
    Anchors = [akLeft, akTop, akRight]
    Color = 5000268
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #47569#51008' '#44256#46357
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    UseDockManager = True
    Version = '2.5.11.0'
    BorderColor = clBlack
    Caption.Color = clHighlight
    Caption.ColorTo = clNone
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clWindowText
    Caption.Font.Height = -11
    Caption.Font.Name = 'Tahoma'
    Caption.Font.Style = []
    Caption.GradientDirection = gdVertical
    Caption.Indent = 0
    Caption.ShadeLight = 255
    CollapsColor = clNone
    CollapsDelay = 0
    CollapsSteps = 1
    ColorTo = 3881787
    ColorMirror = 5000268
    ColorMirrorTo = 3881787
    DoubleBuffered = True
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderColor = clNone
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clWindowText
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = clWhite
    StatusBar.GradientDirection = gdVertical
    Text = ''
    DesignSize = (
      946
      120)
    FullHeight = 120
    object lblTitle: TcxLabel
      Left = 0
      Top = 7
      HelpType = htKeyword
      HelpKeyword = 'C'
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = #44208#51228#49688#45800#51012' '#49440#53469#54644' '#51452#49464#50836
      ParentColor = False
      ParentFont = False
      Style.Color = clWhite
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWhite
      Style.Font.Height = -44
      Style.Font.Name = #47569#51008' '#44256#46357
      Style.Font.Style = []
      Style.HotTrack = False
      Style.TextColor = clWhite
      Style.IsFontAssigned = True
      StyleDisabled.Color = 2960685
      Properties.Alignment.Horz = taCenter
      Properties.Alignment.Vert = taVCenter
      Properties.LabelStyle = cxlsLowered
      Transparent = True
      Height = 98
      Width = 942
      AnchorX = 471
      AnchorY = 56
    end
  end
  object CloseTimer: TTimer
    OnTimer = CloseTimerTimer
    Left = 438
    Top = 127
  end
end
