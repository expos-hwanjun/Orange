unit RcpChange_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls, DB, ComCtrls,
  Mask, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxLabel, cxCurrencyEdit, cxContainer,
  cxGridCustomTableView, cxGridTableView, cxControls, cxGridCustomView,
  cxClasses, cxGridLevel, cxGrid, jpeg, StrUtils, cxTextEdit,
  cxLookAndFeels, cxDBData, cxGridDBTableView, Common_U, cxMaskEdit,
  cxDropDownEdit, cxCalendar, Menus, cxLookAndFeelPainters, cxButtons,
  MemDS, DBAccess, Uni, ActnList, DateUtils, cxNavigator, dxCore, cxDateUtils,
  System.Actions, AdvShape, dxGDIPlusClasses, AdvGlassButton, ToolPanels,
  Vcl.WinXCalendars, cxGroupBox, AdvSmoothToggleButton, POSCard, dxmdaset,
  AdvPanel, dxDateRanges, dxScrollbarAnnotations, AdvSmoothButton, Math;

type
  TRcpChange_F = class(TForm)
    meo_Present: TMemo;
    GridLevel: TcxGridLevel;
    Grid: TcxGrid;
    gvMaster1: TcxGridTableView;
    gvMaster1Column1: TcxGridColumn;
    gvMaster1Column2: TcxGridColumn;
    gvMaster1Column3: TcxGridColumn;
    gvMaster1Column4: TcxGridColumn;
    gvMaster1Column5: TcxGridColumn;
    gvMaster1Column6: TcxGridColumn;
    cxGrid2: TcxGrid;
    gvDetail: TcxGridTableView;
    gvDetailMenuName: TcxGridColumn;
    gvDetailSaleQty: TcxGridColumn;
    gvDetailSalePrice: TcxGridColumn;
    gvDetailSaleAmt: TcxGridColumn;
    cxGridLevel1: TcxGridLevel;
    gvMaster1Column7: TcxGridColumn;
    gvMaster1Column8: TcxGridColumn;
    gvMaster1Column9: TcxGridColumn;
    gvMaster1Column10: TcxGridColumn;
    gvMaster1Column11: TcxGridColumn;
    gvMaster1Column12: TcxGridColumn;
    gvMaster1Column13: TcxGridColumn;
    gvMaster1Column14: TcxGridColumn;
    gvMaster1Column15: TcxGridColumn;
    gvMaster1Column16: TcxGridColumn;
    gvMaster1Column17: TcxGridColumn;
    gvMaster1Column18: TcxGridColumn;
    gvMaster1Column19: TcxGridColumn;
    gvMaster1Column20: TcxGridColumn;
    gvMaster1Column21: TcxGridColumn;
    gvMaster1Column22: TcxGridColumn;
    cxGrid3: TcxGrid;
    gvBanpum: TcxGridTableView;
    cxGridColumn6: TcxGridColumn;
    cxGridColumn7: TcxGridColumn;
    cxGridColumn8: TcxGridColumn;
    cxGridColumn9: TcxGridColumn;
    cxGridColumn10: TcxGridColumn;
    cxGridLevel2: TcxGridLevel;
    gvBanpumColumn1: TcxGridColumn;
    gvBanpumColumn2: TcxGridColumn;
    ActionList: TActionList;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action5: TAction;
    Action6: TAction;
    Action7: TAction;
    Action8: TAction;
    edtTotalAmt: TcxCurrencyEdit;
    edtSaleAmt: TcxCurrencyEdit;
    edtBankAmt: TcxCurrencyEdit;
    edtOrderAmt: TcxCurrencyEdit;
    edtCustomerCount: TcxCurrencyEdit;
    edtCardAmt: TcxCurrencyEdit;
    edtCancelAmt: TcxCurrencyEdit;
    Action9: TAction;
    Show_Timer: TTimer;
    Image1: TImage;
    cxLabel7: TcxLabel;
    TotalSaleAmtLabel: TcxLabel;
    SaleAmtLabel: TcxLabel;
    CashAmtLabel: TcxLabel;
    BankAmtLabel: TcxLabel;
    OrderAmtLabel: TcxLabel;
    GuestCountLabel: TcxLabel;
    CardAmtLabel: TcxLabel;
    CancelAmtLabel: TcxLabel;
    BanpumButton: TAdvGlassButton;
    AdvShape3: TAdvShape;
    TitleLabel: TLabel;
    CloseButton: TcxButton;
    FullSearchButton: TAdvGlassButton;
    CardSearchButton: TAdvGlassButton;
    CashSearchButton: TAdvGlassButton;
    SaleDatePicker: TCalendarPicker;
    PrintOptionButton: TAdvGlassButton;
    Action10: TAction;
    GridTableView: TcxGridTableView;
    GridTableViewRcpNo: TcxGridColumn;
    GridTableViewSaleAmt: TcxGridColumn;
    GridTableViewTableName: TcxGridColumn;
    GridTableViewPayType: TcxGridColumn;
    GridTableViewSaleTime: TcxGridColumn;
    GridTableViewDsSale: TcxGridColumn;
    GridTableViewComeTime: TcxGridColumn;
    GridTableViewCashAmt: TcxGridColumn;
    GridTableViewCardAmt: TcxGridColumn;
    GridTableViewCashRcpAmt: TcxGridColumn;
    GridTableViewTrustAmt: TcxGridColumn;
    GridTableViewCheckAmt: TcxGridColumn;
    GridTableViewGiftAmt: TcxGridColumn;
    GridTableViewPointDc: TcxGridColumn;
    GridTableViewPointAmt: TcxGridColumn;
    GridTableViewDcAmt: TcxGridColumn;
    GridTableViewSawonCode: TcxGridColumn;
    GridTableViewSawonName: TcxGridColumn;
    GridTableViewTableNo: TcxGridColumn;
    GridTableViewBankAmt: TcxGridColumn;
    GridTableViewGuestCount: TcxGridColumn;
    GridTableViewTaxFreeNo: TcxGridColumn;
    GridTableViewSaveStamp: TcxGridColumn;
    GridTableViewUseStamp: TcxGridColumn;
    GridTableViewDamdang: TcxGridColumn;
    GridTableViewAcctLinkNo: TcxGridColumn;
    GridTableViewCallNo: TcxGridColumn;
    GridTableViewTipAmt: TcxGridColumn;
    GridTableViewSaleDate: TcxGridColumn;
    GridTableViewCloseNo: TcxGridColumn;
    GridTableViewCardNo: TcxGridColumn;
    GridTableViewAddPoint: TcxGridColumn;
    GridTableViewUsePoint: TcxGridColumn;
    GridTableViewMemberName: TcxGridColumn;
    GridTableViewMemberCode: TcxGridColumn;
    GridTableViewComeDate: TcxGridColumn;
    StyleRepository: TcxStyleRepository;
    cxStyle1: TcxStyle;
    GridTableViewEtcAmt: TcxGridColumn;
    GridTableViewCashRcpNo: TcxGridColumn;
    GridTableViewCouponDC: TcxGridColumn;
    StyleHeader: TcxStyle;
    MenuGridTableView: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    MenuGridTableView1: TcxGridDBTableView;
    DataSource: TDataSource;
    DataSource1: TDataSource;
    MenuGridTableViewMenuName: TcxGridDBColumn;
    MenuGridTableViewQty: TcxGridDBColumn;
    MenuGridTableViewPrice: TcxGridDBColumn;
    MenuGridTableViewAmont: TcxGridDBColumn;
    MenuGridTableView1Seq: TcxGridDBColumn;
    MenuGridTableView1MenuName: TcxGridDBColumn;
    MenuGridTableView1Qty: TcxGridDBColumn;
    MenuGridTableView1Amount: TcxGridDBColumn;
    MenuGridTableViewMenuType: TcxGridDBColumn;
    MenuGridTableViewMenuCode: TcxGridDBColumn;
    MenuGridTableViewDsSale: TcxGridDBColumn;
    MemData: TdxMemData;
    MemDataCD_MENU: TStringField;
    MemDataNM_MENU: TStringField;
    MemDataQTY_SALE: TStringField;
    MemDataAMT_SALE: TCurrencyField;
    MemDataPR_SALE: TCurrencyField;
    MemDataDS_MENU_TYPE: TStringField;
    MemDataDS_SALE: TStringField;
    MemData1: TdxMemData;
    StringField2: TStringField;
    StringField3: TStringField;
    CurrencyField2: TCurrencyField;
    MemDataLINK: TStringField;
    MemData1LINK: TStringField;
    MemData1SEQ: TIntegerField;
    PrintLogPanel: TAdvPanel;
    GridTableViewLetsOrderAmt: TcxGridColumn;
    MessageImage: TImage;
    PosPanel: TAdvPanel;
    PrintOptionPanel: TAdvPanel;
    cxGroupBox1: TcxGroupBox;
    CardPrintSplitOffButton: TAdvSmoothToggleButton;
    CardPrintSplitOnButton: TAdvSmoothToggleButton;
    cxGroupBox2: TcxGroupBox;
    MenuPrintOnButton: TAdvSmoothToggleButton;
    MenuPrintOffButton: TAdvSmoothToggleButton;
    KitchenPrintGroupBox: TcxGroupBox;
    KitchenReceiptOnButton: TAdvSmoothToggleButton;
    KitchenReceiptOffButton: TAdvSmoothToggleButton;
    cxStyle2: TcxStyle;
    Label95: TLabel;
    GridTableViewDsDelivery: TcxGridColumn;
    GridTableViewDeliveryNo: TcxGridColumn;
    GridPrevButton: TAdvSmoothButton;
    GridNextButton: TAdvSmoothButton;
    GridFirstButton: TAdvSmoothButton;
    GridEndButton: TAdvSmoothButton;
    MenuGridPrevButton: TAdvSmoothButton;
    MenuGridNextButton: TAdvSmoothButton;
    PrintLogButton: TAdvSmoothButton;
    edtCashAmt: TcxCurrencyEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure Action8Execute(Sender: TObject);
    procedure Action9Execute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Show_TimerTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure GridPrevButtonClick(Sender: TObject);
    procedure BanpumButtonClick(Sender: TObject);
    procedure MenuGridPrevButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FullSearchButtonClick(Sender: TObject);
    procedure SaleDatePickerChange(Sender: TObject);
    procedure PrintOptionButtonClick(Sender: TObject);
    procedure Action11Execute(Sender: TObject);
    procedure CardPrintSplitOffButtonClick(Sender: TObject);
    procedure MenuPrintOnButtonClick(Sender: TObject);
    procedure KitchenReceiptOnButtonClick(Sender: TObject);
    procedure GridTableViewStylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      var AStyle: TcxStyle);
    procedure GridTableViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure PrintLogButtonClick(Sender: TObject);
    procedure GridTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    FunctionButton: array of TAdvSmoothButton;
    ClickTime          : TDateTime;
    ClickObject        : TObject;

    FWorkDate: String;
    FCardNo  : String;
    FOrgTable : TTable;
    isPosChange,
    ChangePosKiosk,                      //변경한 포스가 키오스크
    ChangePosLetsOrder :Boolean;         //변경한 포스가 렛츠오더
    Option10 : Char;
    isShowing :Boolean;

    procedure SelectReceipt(aType:Integer;aRcpNo:String='');
    function  CheckTrust:Boolean;
    function  SetCornerReceipt:Boolean;
    procedure ScannerReadEvent(const S : String);
    procedure PosButtonClick(Sender:TObject);
    procedure FunctionButtonCreate;
    procedure FunctionButtonClick(Sender: TObject);
    function  CheckCardCancel(vApprovalNo, vApprovalAmt:String):Boolean;
    function  CheckCashCancel(vApprovalNo:String):Boolean;
  public
    OrgWorkDate :String;
    ShowMode :TFormShowMode;
  end;

var
  RcpChange_F: TRcpChange_F;

implementation
uses GlobalFunc_U, DbModule_U, Const_U, Order_U, OrderCancel_U, TaxfreeA_U,
     KioskKeyPad_U;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TRcpChange_F.FormCreate(Sender: TObject);
var vIndex :Integer;
begin
  DoubleBuffered := true;
  Width  := 1024;
  Height := 768;
  if (Common.Config.Style = 'D') or not Common.Config.IsKiosk then
    for vIndex := 0 to ComponentCount-1 do
    begin
      if Components[vIndex] is TAdvSmoothButton then
        Common.SetButtonColor((Components[vIndex] as TAdvSmoothButton));
      if Components[vIndex] is TAdvGlassButton then
        Common.SetButtonColor((Components[vIndex] as TAdvGlassButton));
    end;

  if Common.Config.Style = 'D' then
    StyleHeader.Color := $002D2D2D;

  FunctionButtonCreate;
  if GetHeadOption(9) = '1' then
    CashSearchButton.Caption := '렛츠오더';
  ChangePosKiosk     := false;
  ChangePosLetsOrder := false;
  isPosChange        := false;
  isShowing          := true;
end;

procedure TRcpChange_F.FormShow(Sender: TObject);
var vTemp :String;
    vIndex :Integer;
    vColList :TStringList;
begin
  Option10 := Common.Config.Options[10];
  PrintOptionPanel.Visible  := false;
  PosPanel.Visible          := false;
  vTemp := Common.GetIniFile('POS','영수증관리_그리드','');
  if vTemp <> EmptyStr then
  begin
    vColList := TstringList.Create;
    try
      Split(vTemp, #2, vColList);

      for vIndex := 0 to vColList.Count-1 do
        GridTableView.Columns[vIndex].Width := StrToInt(vColList[vIndex]);
    finally
      vColList.Free;
    end;
  end;
  if not Common.Config.IsKiosk then
  begin
    TitleLabel.Caption          := Common.GetPaPago(TitleLabel.Caption);
    PrintOptionButton.Caption   := Common.GetPaPago(PrintOptionButton.Caption);
    FullSearchButton.Caption    := Common.GetPaPago(FullSearchButton.Caption);
    CardSearchButton.Caption    := Common.GetPaPago(CardSearchButton.Caption);
    CashSearchButton.Caption    := Common.GetPaPago(CashSearchButton.Caption);

    TotalSaleAmtLabel.Caption   := Common.GetPaPago(TotalSaleAmtLabel.Caption);
    SaleAmtLabel.Caption        := Common.GetPaPago(SaleAmtLabel.Caption);
    CashAmtLabel.Caption        := Common.GetPaPago(CashAmtLabel.Caption);
    BankAmtLabel.Caption        := Common.GetPaPago(BankAmtLabel.Caption);
    OrderAmtLabel.Caption       := Common.GetPaPago(OrderAmtLabel.Caption);
    GuestCountLabel.Caption     := Common.GetPaPago(GuestCountLabel.Caption);
    CardAmtLabel.Caption        := Common.GetPaPago(CardAmtLabel.Caption);
    CancelAmtLabel.Caption      := Common.GetPaPago(CancelAmtLabel.Caption);
  end;

  //취소 시 주방주문서 출력여부 출력하는데 변경가능
  if GetOption(72) = '0' then
    KitchenReceiptOnButtonClick(KitchenReceiptOffButton)
  else if GetOption(72) = '1' then
    KitchenReceiptOnButtonClick(KitchenReceiptOnButton)
  else
  begin
    KitchenPrintGroupBox.Enabled := false;
    KitchenReceiptOnButtonClick(KitchenReceiptOnButton);
  end;

  Show_Timer.Enabled        := true;
end;

procedure TRcpChange_F.FullSearchButtonClick(Sender: TObject);
begin
  if PosPanel.Visible then Exit;
  try
    SaleDatePicker.Enabled := false;
    if Sender = FullSearchButton then SelectReceipt(0)
    else if Sender = CardSearchButton then SelectReceipt(1)
    else if Sender = CashSearchButton   then SelectReceipt(2);
  finally
    SaleDatePicker.Enabled := true;
  end;
end;

procedure TRcpChange_F.FunctionButtonClick(Sender: TObject);
var vIndex :Integer;
    vAction :String;
begin
  Common.KioskTouchBeep('kioskwave12');
  if PosPanel.Visible or PrintOptionPanel.Visible then Exit;
  
  if (MilliSecondsBetween(Now(),ClickTime) < 1000) and (ClickObject = Sender) then Exit;
  ClickTime   := Now;
  ClickObject := Sender;
  try
    vAction := (Sender as TAdvSmoothButton).Hint;
    For vIndex:= 0 to ActionList.ActionCount -1 do
    begin
       if  TAction(ActionList[vIndex]).Hint = vAction then
       begin
          Common.WriteLog('work', TAction(ActionList[vIndex]).Caption );
          ActionList[vIndex].Execute;
          Break;
       end;
    end;
  except
  end;
end;

procedure TRcpChange_F.FunctionButtonCreate;
var I, vButtonCount, vCol, vLeft :Integer;
    vIndex :Integer;
    vWidth :Integer;
    vButtonColor, vBorderColor, vRound :TColor;
    vButtonFont  :TFont;
    vIConDisplay, vShadow :Boolean;
begin
  vButtonFont := TFont.Create;
  try
    //버튼 설정
    OpenQuery('select * '
             +'  from MS_CODE '
             +' where CD_STORE = :P0 '
             +'   and CD_KIND  = :P1 '
             +'   and CD_CODE  = ''400'' ',
             [Common.Config.StoreCode,
              Common.Config.DesignCode]);
    if not Common.Query.Eof then
    begin
      Common.LogoCreate(Self,1);
      vButtonColor        := StringToColor(Common.Query.FieldByName('NM_CODE2').AsString);
      vButtonCount        := StrToIntDef(Common.Query.FieldByName('NM_CODE1').AsString,5);
      vButtonFont.Name    := Common.Query.FieldByName('NM_CODE3').AsString;
      vButtonFont.Size    := StrToIntDef(Common.Query.FieldByName('NM_CODE4').AsString,11);
      if Common.Query.FieldByName('NM_CODE5').AsString = '1' then
        vButtonFont.Style := [fsBold];
      vButtonFont.Color       := StringToColor(Common.Query.FieldByName('NM_CODE6').AsString);
      vBorderColor            := StringToColorDef(Common.Query.FieldByName('NM_CODE8').AsString, vButtonColor);
      vRound                  := StrToIntDef(Common.Query.FieldByName('NM_CODE9').AsString, 0);
      vShadow                 := Common.Query.FieldByName('NM_CODE10').AsString = 'Y';
      Common.Query.Close;
    end
    else
    begin
      Common.Query.Close;
      Common.LogoCreate(Self,2);
      MessageImage.Visible := true;
      Exit;
    end;
    SetLength(FunctionButton, vButtonCount);
    vWidth := (Self.Width - 20)  div vButtonCount;
    if not vShadow then
      vWidth := vWidth - 1;
    vLeft := 10;
    for vIndex := Low(FunctionButton) to High(FunctionButton) do
    begin
      FunctionButton[vIndex] := TAdvSmoothButton.Create(Self);
      with FunctionButton[vIndex] do
      begin
        Name   := 'FunctionButton'+IntToStr(vIndex);
        Parent := Self;
        Color                         := vButtonColor;
        BevelColor                    := vBorderColor;
        Appearance.SimpleLayout       := true;
        Appearance.SimpleLayoutBorder := true;
        Appearance.Rounding           := vRound;
        Appearance.Font               := vButtonFont;
        Appearance.PictureAlignment   := taCenter;
        Caption                       := EmptyStr;
        Cursor                        := crHandPoint;
        Top                           := Self.Height - 60;
        Width                         := vWidth;
        Height                        := 53;
        Left                          := vLeft;
        vLeft                         := vLeft + vWidth + Ifthen(vShadow,0,2);
        Tag                           := vIndex-1;
        Shadow                        := vShadow;
      end;
    end;

    // 버튼 기능 연결
    if Assigned(FunctionButton) and (Length(FunctionButton) > 0) then
    begin
      OpenQuery('select * '
               +'  from MS_CODE  '
               +' where CD_STORE = :P0 '
               +'   and CD_KIND  = :P1 '
               +'   and CD_CODE  between ''401'' and ''499'' '
               +' order by CD_CODE ',
               [Common.Config.StoreCode,
                Common.Config.DesignCode]);
      while not Common.Query.Eof do
      begin
        vCol := StoI(Common.Query.FieldByName('NM_CODE7').AsString);
        if Assigned(FunctionButton[vCol]) then
        begin
          if Common.Query.FieldByName('NM_CODE1').AsString = '' then Continue;
          FunctionButton[vCol].Caption           := Common.GetPaPago(LineFeed(Common.Query.FieldByName('NM_CODE3').AsString));
          if Common.Query.FieldByName('NM_CODE6').AsString = '1' then
            FunctionButton[vCol].Appearance.Font.Style := [fsBold];
          FunctionButton[vCol].Hint := Common.Query.FieldByName('NM_CODE1').AsString;
          FunctionButton[vCol].Color  := StringToColor(Common.Query.FieldByName('NM_CODE4').AsString);
          FunctionButton[vCol].Appearance.Font.Color := StringToColor(Common.Query.FieldByName('NM_CODE5').AsString);
          if StoI(Common.Query.FieldByName('NM_CODE8').AsString) >= 5 then
            FunctionButton[vCol].Appearance.Font.Size    := Common.Query.FieldByName('NM_CODE8').AsInteger;

          FunctionButton[vCol].OnClick := FunctionButtonClick;
          Common.Query.Next;
        end;
      end;
    end;
  finally
    vButtonFont.Free;
  end;
end;

procedure TRcpChange_F.GridPrevButtonClick(Sender: TObject);
begin
  if Sender = GridFirstButton then
  begin
    if GridTableView.Controller.FocusedRowIndex >= 10 then
      GridTableView.Controller.FocusedRowIndex :=  GridTableView.Controller.FocusedRowIndex - 10
    else
      GridTableView.DataController.GotoFirst;
  end
  else if Sender = GridPrevButton then GridTableView.DataController.GotoPrev
  else if Sender = GridEndButton then
  begin
    if GridTableView.Controller.FocusedRowIndex + 10 <= GridTableView.DataController.RecordCount then
      GridTableView.Controller.FocusedRowIndex :=  GridTableView.Controller.FocusedRowIndex + 10
    else
      GridTableView.DataController.GotoLast;
  end
  else if Sender = GridNextButton then GridTableView.DataController.GotoNext;
end;

procedure TRcpChange_F.GridTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  // 선택만 되어 있으면 포커스가 없어도 선택 색깔로 표시한다
  if AViewInfo.Selected then
  begin
    ACanvas.Brush.Color := clHighlight;
    ACanvas.Font.Color  := clHighlightText;
  end;
//  else
//  begin
//    ACanvas.Brush.Color := clWindow;
//    ACanvas.Font.Color  := clWindowText;
//  end;
end;

procedure TRcpChange_F.GridTableViewFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
var vTemp, vSQL, vSQL2:String;
    I, vIndex  :Integer;
    vItemList:TStringList;
begin
  try
    if not Common.Config.IsKiosk then
      cxGrid2.Height  := 453;
    gvBanpum.DataController.RecordCount := 0;
    cxGrid3.Visible                     := False;
    gvDetail.DataController.RecordCount := 0;
    if GridTableView.DataController.RecordCount = 0 then Exit;

    Common.Query.Close;
    if (GetOption(20) = '1') and (Trim(Common.Config.TipMenu) <> '') then
      vSQL := 'select case t1.DS_SALE_TYPE when ''D'' then ConCat(t2.NM_MENU,:P4) when ''P'' then ConCat(t2.NM_MENU,:P5) else t2.NM_MENU end as NM_MENU,'
             +'       t1.QTY_SALE, '
             +'       t1.PR_SALE, '
             +'       t1.AMT_SALE, '
             +'       t2.DS_MENU_TYPE, '
             +'       t1.CD_MENU, '
             +'       t1.DS_SALE, '
             +'       t2.PR_SALE as PR_SALE_MST, '
             +'       t2.PR_SALE_DOUBLE, '
             +'       t1.NM_ITEMS, '
             +'       Cast(t1.SEQ as Char) as LINK '
             +'  from SL_SALE_D  t1 left outer join '
             +'       MS_MENU    t2 on t1.CD_STORE =t2.CD_STORE and t1.CD_MENU =t2.CD_MENU '
             +' where t1.CD_STORE =:P0 '
             +'   and t1.YMD_SALE =:P1 '
             +'   and t1.NO_POS   =:P2 '
             +'   and t1.NO_RCP   =:P3 '
             +'   and t1.CD_MENU <> ''' + Common.Config.TipMenu+''' '
             +' order by t1.SEQ '
    else
      vSQL := 'select case t1.DS_SALE_TYPE when ''D'' then ConCat(t2.NM_MENU,:P4) when ''P'' then ConCat(t2.NM_MENU,:P5) else t2.NM_MENU end as NM_MENU,'
             +'        t1.QTY_SALE, '
             +'        t1.PR_SALE, '
             +'        t1.AMT_SALE, '
             +'        t2.DS_MENU_TYPE, '
             +'        t1.CD_MENU, '
             +'        t1.DS_SALE, '
             +'        t2.PR_SALE as PR_SALE_MST, '
             +'        t2.PR_SALE_DOUBLE, '
             +'        t1.NM_ITEMS, '
             +'        Cast(t1.SEQ as Char) as LINK '
             +'   from SL_SALE_D t1 left outer join '
             +'        MS_MENU   t2 on t1.CD_STORE = t2.CD_STORE and t1.CD_MENU = t2.CD_MENU '
             +'  where t1.CD_STORE =:P0 '
             +'    and t1.YMD_SALE =:P1 '
             +'    and t1.NO_POS   =:P2 '
             +'    and t1.NO_RCP   =:P3 '
             +'  order by t1.SEQ ';

    OpenQuery(vSQL,
             [Common.Config.StoreCode,
              FWorkDate,
              Common.Config.PosNo,
              GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index],
              Common.Config.ServiceTxt,
              Common.Config.PackingTxt]);
    if MemData.Active then
      MemData.Close;
    if MemData1.Active then
      MemData1.Close;
    DataSource.DataSet  := nil;
    DataSource1.DataSet := nil;
    vItemList := TStringList.Create;
    MenuGridTableView.DataController.BeginUpdate;
    MenuGridTableView1.DataController.BeginUpdate;
    try
      MemData.Open;
      MemData1.Open;
      while not Common.Query.Eof do
      begin
        MemData.Append;
        MemData.FieldByName('CD_MENU').AsString := Common.Query.FieldByName('CD_MENU').AsString;
        MemData.FieldByName('NM_MENU').AsString := Common.Query.FieldByName('NM_MENU').AsString;
        if (Common.Query.FieldByName('PR_SALE_MST').AsInteger <> Common.Query.FieldByName('PR_SALE_DOUBLE').AsInteger)
         and (Common.Query.FieldByName('PR_SALE_DOUBLE').AsInteger > 0)
         and (Common.Query.FieldByName('PR_SALE').AsInteger =Common.Query. FieldByName('PR_SALE_DOUBLE').AsInteger) then
          MemData.FieldByName('NM_MENU').AsString := Common.Query.FieldByName('NM_MENU').AsString+'(곱빼기)';


        MemData.FieldByName('QTY_SALE').AsString := Common.GetQtyReplace(Common.Query.FieldByName('DS_MENU_TYPE').AsString,
                                                    Common.Query.FieldByName('QTY_SALE').AsString);

        if Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'W' then
        begin
          //중량이 1보다 크면 g 값이기 때문에 100g당 단가를 계산한다
          if Abs(Common.Query.FieldByName('QTY_SALE').AsInteger) > 1 then
            MemData.FieldByName('PR_SALE').AsCurrency := Common.Query.FieldByName('PR_SALE').AsCurrency / Common.Query.FieldByName('QTY_SALE').AsCurrency * 100
          else
            MemData.FieldByName('PR_SALE').AsCurrency := Common.Query.FieldByName('PR_SALE').AsInteger;
        end
        else
          MemData.FieldByName('PR_SALE').AsCurrency := Common.Query.FieldByName('PR_SALE').AsInteger;

        MemData.FieldByName('AMT_SALE').AsCurrency   := Common.Query.FieldByName('AMT_SALE').AsCurrency;
        MemData.FieldByName('DS_MENU_TYPE').AsString := Common.Query.FieldByName('DS_MENU_TYPE').AsString;
        MemData.FieldByName('DS_SALE').AsString      := Common.Query.FieldByName('DS_SALE').AsString;
        MemData.FieldByName('LINK').AsString         := Common.Query.FieldByName('LINK').AsString;
        if Common.Query.FieldByName('NM_ITEMS').AsString <> '' then
        begin
          Split(Common.Query.FieldByName('NM_ITEMS').AsString, #$D, vItemList);
          for vIndex := 0 to vItemList.Count-2 do
          begin
            MemData1.Append;
            MemData1.FieldByName('LINK').AsString    := Common.Query.FieldByName('LINK').AsString;
            MemData1.FieldByName('NM_MENU').AsString := vItemList.Strings[vIndex];
            MemData1.Post;
          end;
        end;
        Common.Query.Next;
      end;
    finally
      if Common.Query.RecordCount > 0 then
        MemData.Post;
      Common.Query.Close;
      vItemList.Free;
    end;
    DataSource.DataSet  := MemData;
    DataSource1.DataSet := MemData1;
    MenuGridTableView.DataController.EndUpdate;
    MenuGridTableView1.DataController.EndUpdate;

    MenuGridTableView.DataController.BeginUpdate;
    MenuGridTableView.DataController.GridView.ViewData.Expand(true);
    MenuGridTableView.DataController.EndUpdate;
    //시재를 보여준다
    meo_Present.Clear;
    with GridTableView.DataController do
    begin
      if Values[GetFocusedRecordIndex, GridTableViewTipAmt.Index] <> 0 then
      begin
        meo_Present.Lines.Add(' 봉 사 료 :  '+ LPad(FormatFloat('#,0',Values[GetFocusedRecordIndex, GridTableViewTipAmt.Index]) +'원',16,' '));
        meo_Present.Lines.Add('');
      end;
      if (Values[GetFocusedRecordIndex, GridTableViewCashAmt.Index] <> 0) then
         meo_Present.Lines.Add(' 현    금 :  '+ LPad(FormatFloat('#,0',Values[GetFocusedRecordIndex, GridTableViewCashAmt.Index]) +'원',16,' '));
      if (Values[GetFocusedRecordIndex, GridTableViewCardAmt.Index] + Values[GetFocusedRecordIndex, GridTableViewLetsOrderAmt.Index] <> 0 )   then
      begin
        if Values[GetFocusedRecordIndex, GridTableViewCardAmt.Index] <> 0 then
          meo_Present.Lines.Add(' 신용카드 :  '+ LPad(FormatFloat('#,0',Values[GetFocusedRecordIndex, GridTableViewCardAmt.Index]) +'원',16,' '));
        if Values[GetFocusedRecordIndex, GridTableViewLetsOrderAmt.Index] <> 0 then
          meo_Present.Lines.Add(' 렛츠오더 :  '+ LPad(FormatFloat('#,0',Values[GetFocusedRecordIndex, GridTableViewLetsOrderAmt.Index]) +'원',16,' '));
        vTemp := NVL(Values[GetFocusedRecordIndex, GridTableViewCardNo.Index],'');
        For I := 1 to CharCnt(vTemp,'|') do
        begin
          if I = 1 then
            meo_Present.Lines.Add(' 카드번호 :  '+  CopyPos(vTemp,'|',I-1))
          else
            meo_Present.Lines.Add('             '+  CopyPos(vTemp,'|',I-1));
        end;
      end;
      if Values[GetFocusedRecordIndex, GridTableViewTrustAmt.Index] <> 0 then
         meo_Present.Lines.Add(' 외    상 :  '+ LPad(FormatFloat('#,0',Values[GetFocusedRecordIndex, GridTableViewTrustAmt.Index]) +'원',16,' '));
      if Values[GetFocusedRecordIndex, GridTableViewCheckAmt.Index] <> 0 then
         meo_Present.Lines.Add(' 수    표 :  '+ LPad(FormatFloat('#,0',Values[GetFocusedRecordIndex, GridTableViewCheckAmt.Index]) +'원',16,' '));
      if Values[GetFocusedRecordIndex, GridTableViewGiftAmt.Index] <> 0 then
         meo_Present.Lines.Add(' 상 품 권 :  '+ LPad(FormatFloat('#,0',Values[GetFocusedRecordIndex, GridTableViewGiftAmt.Index]) +'원',16,' '));
      if Values[GetFocusedRecordIndex, GridTableViewPointAmt.Index] <> 0 then
         meo_Present.Lines.Add(' 포 인 트 :  '+ LPad(FormatFloat('#,0',Values[GetFocusedRecordIndex,GridTableViewPointAmt.Index]) +'원',16,' '));
      if (Values[GetFocusedRecordIndex, GridTableViewBankAmt.Index] <> 0) then
         meo_Present.Lines.Add(' 계좌입금 :  '+ LPad(FormatFloat('#,0',Values[GetFocusedRecordIndex,GridTableViewBankAmt.Index]) +'원',16,' '));
      if Values[GetFocusedRecordIndex, GridTableViewDcAmt.Index] <> 0 then
         meo_Present.Lines.Add(' 할인금액 :  '+ LPad(FormatFloat('#,0',Values[GetFocusedRecordIndex, GridTableViewDcAmt.Index]) +'원',16,' '));
      if (Values[GetFocusedRecordIndex, GridTableViewCashAmt.Index] < 0) and (Values[GetFocusedRecordIndex, GridTableViewDsSale.Index] <> '반품') then
         meo_Present.Lines.Add(' 현금지급(거스름돈) :'+ LPad(FormatFloat('#,0',Values[GetFocusedRecordIndex, GridTableViewCashAmt.Index]) +'원',10,' '));
      if Values[GetFocusedRecordIndex, GridTableViewCashRcpAmt.Index] <> 0 then
      begin
        meo_Present.Lines.Add('');
        meo_Present.Lines.Add('※ 현금영수증발행'+ LPad(FormatFloat('#,0',Values[GetFocusedRecordIndex, GridTableViewCashRcpAmt.Index]) +'원',12,' '));
        vTemp := NVL(Values[GetFocusedRecordIndex, GridTableViewCashRcpNo.Index],'');
        For I := 1 to CharCnt(vTemp,'|') do
        begin
          if I = 1 then
            meo_Present.Lines.Add('   식별번호 : '+  CopyPos(vTemp,'|',I-1))
          else
            meo_Present.Lines.Add('              '+  CopyPos(vTemp,'|',I-1));
        end;
      end;

      if Length(NVL(Values[GetFocusedRecordIndex, GridTableViewMemberCode.Index],'')) = 10  then
      begin
        meo_Present.Lines.Add('   회원정보 : '+NVL(Values[GetFocusedRecordIndex, GridTableViewMemberName.Index],'')+' ( ' + NVL(Values[GetFocusedRecordIndex, GridTableViewMemberCode.Index],'') +' )');
        if Values[GetFocusedRecordIndex, GridTableViewAddPoint.Index] <> 0 then
          meo_Present.Lines.Add(' 적립포인트 :  ' + FormatFloat('#,0',Values[GetFocusedRecordIndex, GridTableViewAddPoint.Index]) +' 점');
        if Values[GetFocusedRecordIndex, GridTableViewUsePoint.Index] <> 0 then
          meo_Present.Lines.Add(' 사용포인트 :  ' + FormatFloat('#,0',Values[GetFocusedRecordIndex, GridTableViewUsePoint.Index]) +' 점');

        //스템프정보
        if GetOption(21)='1' then
        begin
          if Values[GetFocusedRecordIndex, GridTableViewSaveStamp.Index] <> 0 then
            meo_Present.Lines.Add(' 적립스템프 :  ' + FormatFloat('#,0',Values[GetFocusedRecordIndex, GridTableViewSaveStamp.Index]) );
          if Values[GetFocusedRecordIndex,  GridTableViewUseStamp.Index] <> 0 then
            meo_Present.Lines.Add(' 사용스템프 :  ' + FormatFloat('#,0',Values[GetFocusedRecordIndex, GridTableViewUseStamp.Index]) );
        end;
      end;


      meo_Present.Lines.Add(' 계 산 원 : '+ NVL(Values[GetFocusedRecordIndex, GridTableViewSawonName.Index],'')+ ' ('+Values[GetFocusedRecordIndex, GridTableViewSawonCode.Index]+')');
      if GetOption(311) = '1' then
        meo_Present.Lines.Add(' 호출번호 : '+ IntToStr(NVL(Values[GetFocusedRecordIndex, GridTableViewCallNo.Index],0)));

      if Values[GetFocusedRecordIndex, GridTableViewDamdang.Index] <> '' then
      begin
         meo_Present.Lines.Add(' 담 당 자 :'+ Values[GetFocusedRecordIndex, GridTableViewDamdang.Index]);
      end;

      if NVL(Values[GetFocusedRecordIndex, GridTableViewDeliveryNo.Index],'') <> ''  then
      begin
         if NVL(Values[GetFocusedRecordIndex, GridTableViewDsDelivery.Index],'') = ''  then
           meo_Present.Lines.Add(' 배달번호 : '+ Values[GetFocusedRecordIndex, GridTableViewDeliveryNo.Index])
         else  if NVL(Values[GetFocusedRecordIndex, GridTableViewDsDelivery.Index],'') = 'B'  then
           meo_Present.Lines.Add(Format(' 배달번호 : %s (%s)',[Values[GetFocusedRecordIndex, GridTableViewDeliveryNo.Index], '배민의민족']))
         else  if NVL(Values[GetFocusedRecordIndex, GridTableViewDsDelivery.Index],'') = 'C'  then
           meo_Present.Lines.Add(Format(' 배달번호 : %s (%s)',[Values[GetFocusedRecordIndex, GridTableViewDeliveryNo.Index], '쿠팡이츠']))
         else  if NVL(Values[GetFocusedRecordIndex, GridTableViewDsDelivery.Index],'') = 'Y'  then
           meo_Present.Lines.Add(Format(' 배달번호 : %s (%s)',[Values[GetFocusedRecordIndex, GridTableViewDeliveryNo.Index], '요기요']));

      end;

    end;
    BanpumButton.Enabled := GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDsSale.Index] = '정상';
  finally
    Grid.Enabled := true;
  end;

  if PrintLogPanel.Visible then
    PrintLogButtonClick(nil);
end;

procedure TRcpChange_F.GridTableViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if (ARecord.Values[GridTableViewDsSale.Index] = '취소') or (ARecord.Values[GridTableViewDsSale.Index] = '반품') then
     AStyle := cxStyle1;
end;

procedure TRcpChange_F.SelectReceipt(aType:Integer;aRcpNo:String);
var vSQL     :String;
    vRcp     :String;
    vEachTime, vOrderAmt:Integer;
begin
  try
    Common.ShowWaitForm;
    GridTableView.DataController.ClearSorting(true);
    gvDetail.DataController.ClearSorting(true);
    gvBanpum.DataController.ClearSorting(true);
    MenuGridTableView.DataController.RecordCount := 0;
    gvBanpum.DataController.RecordCount          := 0;

    try
      vSQL :='select a.NO_RCP, '
            +'       a.AMT_SALE, '
            +ifThen( GetOption(25) = '1', 'case when ifnull(a.NO_DELIVERY,'''') <> '''' then ConCat( ''배달'', case when Ifnull(a.DS_DELIVERY,'''') then '''' else ConCat(''('',a.DS_DELIVERY,'')'') end) '
            +'                                             else case when a.NO_TABLE=0 then ''선불판매'' else  b.NM_TABLE end end',
                                          'case when ifnull(a.NO_DELIVERY,'''') <> '''' then ''배달'' else case when a.NO_TABLE=0 then ''선불판매'' else LPad(Cast(a.NO_TABLE as Char),3,''0'') end end') +' as NM_TABLE,'
            +'       Date_Format(a.DT_SALE, ''%H:%i'')   as SALE_TIME, '
            +'       Date_Format(a.COME_TIME, ''%H:%i'') as COME_TIME, '
            +'       case when a.AMT_SALE = a.AMT_CASHRCP   and a.AMT_CASHRCP <> 0  then ''현금영수증'' '
            +'            when a.AMT_SALE = a.AMT_CASH      and a.AMT_CASH    <> 0  then ''현금'' '
            +'            when a.AMT_SALE = a.AMT_CARD      and a.AMT_CARD    <> 0  then ''신용카드'' '
            +'            when a.AMT_SALE = a.AMT_TRUST     and a.AMT_TRUST   <> 0  then ''외상'' '
            +'            when a.AMT_SALE = a.AMT_GIFT      and a.AMT_GIFT    <> 0  then ''상품권'' '
            +'            when a.AMT_SALE = a.AMT_POINT     and a.AMT_POINT   <> 0  then ''포인트'' '
            +'            when a.AMT_SALE = a.AMT_BANK      and a.AMT_BANK    <> 0  then ''계좌입금'' '
            +'            when a.AMT_SALE = a.AMT_ETC       and a.AMT_ETC     <> 0  then ''기타결제'' '
            +'            when a.AMT_SALE = a.AMT_LETSORDER and a.AMT_LETSORDER  <> 0  then ''렛츠오더'' '
            +'            when a.AMT_SALE = 0               and a.DC_TOT      <> 0  then ''할인'' '
            +'            when a.AMT_SALE = 0               and a.AMT_SERVICE <> 0  then ''서비스'' '
            +'            else ''복합'' end as PAY_TYPE, '
            +'       case a.DS_SALE when ''S'' then ''정상'' when ''V'' then ''취소'' when ''B'' then ''반품'' end as DS_SALE, '
            +'       a.AMT_CASH, '
            +'       a.AMT_CARD, '
            +'       a.AMT_TRUST, '
            +'       a.AMT_CHECK, '
            +'       a.AMT_GIFT, '
            +'       a.AMT_BANK, '
            +'       a.AMT_ETC, '
            +'       a.AMT_LETSORDER, '
            +'       a.AMT_POINT, '
            +'       a.DC_POINT, '
            +'       a.AMT_CASHTIP+a.AMT_CARDTIP as AMT_TIP, '
            +'       a.DC_TOT, '
            +'       a.AMT_CASHRCP, '
            +'       a.DC_COUPON, '
            +'       a.NO_CLOSE, '
            +'       ifnull(a.CD_MEMBER,'''') as CD_MEMBER, '
            +'       ifnull(c.NM_MEMBER,'''') as NM_MEMBER, '
            +'       ifnull(a.PNT_OCCUR,   0) as PNT_OCCUR, '
            +'       ifnull(a.PNT_USE,     0) as PNT_USE, '
            +'       GetCardSale(a.CD_STORE, a.YMD_SALE, a.NO_POS, a.NO_RCP) as NO_CARD, '
            +'       GetCashSale(a.CD_STORE, a.YMD_SALE, a.NO_POS, a.NO_RCP) as NO_CASHRCP, '
            +'       a.CD_SAWON, '
            +'       d.NM_SAWON, '
            +'       ifnull(e.NM_SAWON,'''') as DAMDANG, '
            +'       a.NO_ACCT_REF, '
            +'       a.NO_TABLE, '
            +'       a.DT_SALE, '
            +'       a.COME_TIME as DT_COME, '
            +'       a.CNT_PERSON, '
            +'       a.NO_CALL, '
            +'       ifnull(a.TAXFREE_BUY_NO,'''') as TAXFREE_BUY_NO, '
            +'       a.SAVE_STAMP, '
            +'       a.USE_STAMP, '
            +'       a.DS_DELIVERY, '
            +'       a.NO_DELIVERY '
            +'  from SL_SALE_H a left outer join '
            +'       MS_TABLE  b on a.CD_STORE = b.CD_STORE and a.NO_TABLE   = b.NO_TABLE and b.SEQ = 0 left outer join '
            +'       MS_MEMBER c on a.CD_STORE = c.CD_STORE and a.CD_MEMBER  = c.CD_MEMBER left outer join '
            +'       MS_SAWON  d on a.CD_STORE = d.CD_STORE and a.CD_SAWON   = d.CD_SAWON left outer join '
            +'       MS_SAWON  e on a.CD_STORE = e.CD_STORE and a.CD_DAMDANG = e.CD_SAWON '
            +' where a.CD_STORE    =:P0 '
            +'   and a.YMD_SALE    =:P1 '
            +'   and a.NO_POS      =:P2 ';
      meo_Present.Clear;
      case aType of
        0 : vSQL := vSQL + 'order by a.NO_RCP   ';
        1 : vSQL := vSQL + 'and a.AMT_CARD    > 0 order by a.NO_RCP ';
        2 : vSQL := vSQL + Format('and a.%s    > 0 order by a.NO_RCP ',[Ifthen(GetHeadOption(9) = '0', 'AMT_CASH','AMT_LETSORDER')]);
        3 : vSQL := vSQL + 'and a.AMT_CASHRCP > 0 order by A.NO_RCP ';
        4 :
          begin
            OpenQuery('select NO_RCP '
                     +'  from SL_CASH '
                     +' where CD_STORE =:P0 '
                     +'   and YMD_SALE =:P1 '
                     +'   and NO_POS   =:P2 '
                     +'   and (NO_CARD like ConCat(:P3,''%'') or NO_CARD like ConCat(''%'',:P3) or NO_CARD = GetCardNo(:P3, ''Y'')) '
                     +'union all '
                     +'select NO_RCP '
                     +'  from SL_CARD '
                     +' where CD_STORE =:P0 '
                     +'   and YMD_SALE =:P1 '
                     +'   and NO_POS   =:P2 '
                     +'   and (NO_CARD like ConCat(:P3,''%'') or NO_CARD like ConCat(''%'',:P3) or NO_CARD = GetCardNo(:P3, ''Y'')) ',
                     [Common.Config.StoreCode,
                     FWorkDate,
                     Common.Config.PosNo,
                     FCardNo] );
            while not Common.Query.Eof do
            begin
              vRcp := vRcp + Common.Query.Fields[0].AsString+',';
              Common.Query.Next;
            end;
            Common.Query.Close;
            if Pos(',', vRcp) > 0 then
              vRcp := Copy(vRcp, 1, Length(vRcp)-1);

            if vRcp = '' then
            begin
              Common.HideWaitForm;
              Common.ErrBox('조건에 맞는 자료가 없습니다');
              Exit;
            end;

            vSQL := vSQL + 'and a.NO_RCP in ( '+ vRcp +' ) order by a.NO_RCP ';
          end;
        5 : vSQL := vSQL + 'and a.NO_RCP ='''+aRcpNo+''' ';
      end;
      OpenQuery(vSQL,
               [Common.Config.StoreCode,
                FWorkDate,
                Common.Config.PosNo]);
      DM.ReadQuery(Common.Query, GridTableView);


      if (aType = 5) and (GridTableView.DataController.RecordCount=0) then
      begin
        Common.ErrBox('조건에 맞는 영수증이 없습니다');
      end;

      OpenQuery('select Sum(AMT_SALE)    as AMT_SALE, '
               +'       Sum(AMT_CASH+AMT_CHECK) as AMT_CASH, '
               +'       Sum(AMT_CARD)    as AMT_CARD,   '
               +'       Sum(CNT_PERSON)  as CNT_PERSON, '
               +'       Sum(AMT_BANK)    as AMT_BANK, '
               +'       Sum(AMT_CASHRCP) as AMT_CASHRCP '
               +'  from SL_SALE_H '
               +' where DS_SALE <> ''V'' '
               +'   and CD_STORE = :P0 '
               +'   and YMD_SALE = :P1 '
               +'   and NO_POS   = :P2 ',
               [Common.Config.StoreCode,
                FWorkDate,
                Common.Config.PosNo]);

      if not Common.Query.Eof then
      begin
        edtSaleAmt.Value       := Common.Query.Fields[0].AsInteger;
        edtCashAmt.Value       := Common.Query.Fields[1].AsInteger;
        edtCardAmt.Value       := Common.Query.Fields[2].AsInteger;
        edtCustomerCount.Value := Common.Query.Fields[3].AsInteger;
        edtBankAmt.Value       := Common.Query.Fields[4].AsInteger;
        if GetOption(498) = '1' then
        begin
          OrderAmtLabel.Caption := '현영금액';
          edtOrderAmt.Value       := Common.Query.Fields[5].AsInteger;
        end;
      end;

      OpenQuery('select Sum(AMT_SALE) as AMT_SALE '
               +'  from SL_SALE_H '
               +' where DS_SALE  = ''V'' '
               +'   and CD_STORE = :P0 '
               +'   and YMD_SALE = :P1 '
               +'   and NO_POS   = :P2 ',
               [Common.Config.StoreCode,
                FWorkDate,
                Common.Config.PosNo]);

      if not Common.Query.Eof then
        edtCancelAmt.Value    := Common.Query.Fields[0].AsInteger;

      if Common.Config.OverTimeEach=0 then
        vEachTime := 1
      else
        vEachTime := Common.Config.OverTimeEach;
      with Common.Config do
      begin
        if not Common.Config.IsKiosk then
        begin
          OpenQuery('select Sum(AMT_ORDER) as AMT_SALE, '
                   +Ifthen(OverTimeMenu = '','0 as AMT_ADDMENU ', Format('Sum(case when (DS_ORDER = ''T'') and (TIMESTAMPDIFF(MINUTE, COME_TIME, Now()) > %d)  then (TIMESTAMPDIFF(MINUTE, COME_TIME, Now()) - %d) / %d * %d * %s end) as AMT_ADDMENU ',
                                                                         [OverTimeTime,
                                                                          OverTimeTime,
                                                                          vEachTime,
                                                                          OverTimeAmt,
                                                                          Ifthen(GetOption(223)='1', 'CNT_PERSON', '1') ]))
                   +'  from SL_ORDER_H '
                   +' where CD_STORE = :P0 ',
                   [Common.Config.StoreCode]);

          if not Common.Query.Eof then
            vOrderAmt    := Common.Query.Fields[0].AsInteger + Common.Query.Fields[1].AsInteger;
        end
        else
          vOrderAmt := 0;
      end;

      if GetOption(498) = '0' then
        edtOrderAmt.Value := vOrderAmt;

      //조회일자와 개점일자가 같으면 주문금액을 총금액에 더한다
      if (FWorkDate = Common.WorkDate) then
        edtTotalAmt.Value := edtSaleAmt.Value + vOrderAmt
      else
        edtTotalAmt.Value := edtSaleAmt.Value;

      Common.Query.Close;
    except
      on E: Exception do
      begin
        Common.HideWaitForm;
        Common.ErrBox(E.Message);
      end;
    end;

    if GridTableView.DataController.RowCount > 0 then
      GridTableView.DataController.FocusedRecordIndex := GridTableView.DataController.RowCount - 1;
  finally
    Common.HideWaitForm;
  end;
end;

procedure TRcpChange_F.KitchenReceiptOnButtonClick(Sender: TObject);
begin
  if Sender = KitchenReceiptOnButton then
  begin
    Common.Config.Options[10] := '1';
    KitchenReceiptOnButton.Status.Caption   := 'V';
    KitchenReceiptOffButton.Status.Caption  := '';
  end
  else if Sender = KitchenReceiptOffButton then
  begin
    Common.Config.Options[10] := '0';
    KitchenReceiptOnButton.Status.Caption   := '';
    KitchenReceiptOffButton.Status.Caption  := 'V';
  end;
  if Sender = nil then
  begin
    if GetOption(10) = '1' then
    begin
      KitchenReceiptOnButton.Status.Caption   := 'V';
      KitchenReceiptOffButton.Status.Caption  := '';
    end
    else
    begin
      KitchenReceiptOnButton.Status.Caption   := '';
      KitchenReceiptOffButton.Status.Caption  := 'V';
    end;
  end;

  PrintOptionPanel.Visible := false;
end;

procedure TRcpChange_F.CardPrintSplitOffButtonClick(Sender: TObject);
begin
  if Sender = CardPrintSplitOffButton then
  begin
    Common.SplitPrintMode := spmOnePage;
    CardPrintSplitOffButton.Status.Caption := 'V';
    CardPrintSplitOnButton.Status.Caption  := '';
  end
  else if Sender = CardPrintSplitOnButton then
  begin
    Common.SplitPrintMode := spmSplit;
    CardPrintSplitOffButton.Status.Caption := '';
    CardPrintSplitOnButton.Status.Caption  := 'V';
  end;

  if Sender = nil then
  begin
    if Common.SplitPrintMode = spmOnePage then
    begin
      CardPrintSplitOffButton.Status.Caption := 'V';
      CardPrintSplitOnButton.Status.Caption  := '';
    end
    else
    begin
      CardPrintSplitOffButton.Status.Caption := '';
      CardPrintSplitOnButton.Status.Caption  := 'V';
    end;
  end;
  PrintOptionPanel.Visible := false;
end;

function TRcpChange_F.CheckCardCancel(vApprovalNo,
  vApprovalAmt: String): Boolean;
var vRow :Integer;
begin
  Result := False;
  For vRow := 0 to Common.Card_SGrd.RowCount-1 do
  begin
    if (Common.Card_sGrd.Cells[GDC_DS_TRD, vRow] = dtCancel) and
       (Common.Card_sGrd.Cells[GDC_AMT, vRow]    = vApprovalAmt) and
       (Common.Card_sGrd.Cells[GDC_APPROVAL_ORG, vRow] = vApprovalNo) then
    begin
      Result := True;
      Break;
    end;
  end;
end;

function TRcpChange_F.CheckCashCancel(vApprovalNo: String): Boolean;
var vRow :Integer;
begin
  Result := False;
  For vRow := 0 to Common.Cash_SGrd.RowCount-1 do
  begin
    if (Common.Cash_SGrd.Cells[GDR_DS_TRD, vRow] = dtCancel) and
       (Common.Cash_SGrd.Cells[GDR_APPROVAL_ORG, vRow] = vApprovalNo) and
       (Common.Cash_SGrd.Cells[GDR_DS_INPUT, vRow] <> 'O') then
    begin
      Result := True;
      Break;
    end;
  end;
end;

function TRcpChange_F.CheckTrust: Boolean;
begin
  if Trim(NVL(GridTableView.Controller.FocusedRow.Values[GridTableViewAcctLinkNo.Index ],'')) <> '' then
  begin
    Common.ErrBox('외상에 대해 결제가 완료된 내역입니다');
    Result := False;
  end
  else Result := True;
end;

procedure TRcpChange_F.CloseButtonClick(Sender: TObject);
var vTemp  :String;
    vIndex :Integer;
begin
  if PosPanel.Visible then Exit;
  if Common.Config.IsTakeOut and not Common.Config.IsKiosk then
    Order_F.FormShow(nil);
  Common.WorkDate := Common.OpenDate;
  ShowMode := fsmNone;
  Common.Config.PosNo := Common.Config.OriginalPosNo;

  //그리드 칼럼  위치 및 Width 저장
  vTemp := EmptyStr;
  For vIndex := 0 to GridTableView.ColumnCount-1 do
    vTemp := vTemp + Format('%d',[GridTableView.Columns[vIndex].Width])+#2;
  vTemp := Copy(vTemp, 1, Length(vTemp)-1);
  Common.SetIniFile('POS', '영수증관리_그리드', vTemp);
  Close;
end;

procedure TRcpChange_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case Key of
     VK_ESCAPE : CloseButton.Click;
   end;
end;

function TRcpChange_F.SetCornerReceipt:Boolean;
begin
  Result := True;
  //푸드코트 + 층별 VAN다르게
  if (GetOption(231)='1') and (GetOption(267)='1') then
  begin
    OpenQuery('select b.NM_CODE6 '
             +'  from MS_TABLE a inner join  '
             +'       MS_CODE  b a.CD_STORE = b.CD_STORE and a.CD_FLOOR = b.CD_CODE '
             +' where a.CD_STORE =:P0 '
             +'   and a.NO_TABLE =:P1 '
             +'   and b.CD_KIND  =''03'' ',
             [Common.Config.StoreCode,
              GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewTableNo.Index]]);
    if Length(Common.Query.Fields[0].AsString) <> 6 then
    begin
      Common.ErrBox('층에 코너가 설정되어 있지 않습니다');
      Result := False;
      Exit;
    end;
    Common.SetCornerCardInfo(Common.Query.Fields[0].AsString );
  end;
end;

procedure TRcpChange_F.Action1Execute(Sender: TObject);
var vRcpNo :String;
begin

  vRcpNo := Common.ShowNumberForm('영수증번호를 입력하세요',14);
  if vRcpNo = 'mrClose' then Exit;

  if Length(vRcpNo) <= 4 then
    vRcpNo := DtoS(SaleDatePicker.Date)+Common.Config.PosNo+LPad(vRcpNo,4,'0')
  else if Length(vRcpNo) = 12 then
    vRcpNo := LeftStr(vRcpNo,8)+Common.Config.PosNo+RightStr(vRcpNo,4)
  else if Length(vRcpNo) <> 14 then
    Exit;

  if Copy(vRcpNo,9,2) <> Common.Config.PosNo then
  begin
    Common.ErrBox('다른포스의 영수증은 조회할 수 없습니다');
    Exit;
  end;
  SaleDatePicker.Date := StoD(LeftStr(vRcpNo,8));
  SelectReceipt(5, RightStr(vRcpNo,4));
end;

procedure TRcpChange_F.Action2Execute(Sender: TObject);
var vRtn, vTemp :String;
begin
  vRtn := Common.ShowNumberForm('금액을 입력하세요',0,9000000,'0');

  if (vRtn = 'mrClose') or (StoI(vRtn) = 0) then Exit;
  vTemp := Common.WorkDate;
  try
    Common.WorkDate := FWorkDate;
    Common.Device.PrintSimpluRcp(0,StoI(vRtn));
  finally
    Common.WorkDate := vTemp;
  end;
end;

procedure TRcpChange_F.Action3Execute(Sender: TObject);
begin
  if (GetOption(379)='0') then
    FCardNo := Common.ShowNumberForm('신용카드,현금영수증번호 입력', 6)
  else
    FCardNo := Common.ShowNumberForm('신용카드,현금영수증번호 입력', 300);
  if FCardNo = 'mrClose' then Exit;

  SelectReceipt(4);
end;

procedure TRcpChange_F.Action4Execute(Sender: TObject);
var vTempDate : String;
    vErrMsg   : String;
    vRow, vBefRow :Integer;
    vTelNo    : String;
    vRePoint  : Boolean;
begin
  vRePoint := false;
  if GetOption(310) = '1' then
  begin
    Common.ErrBox('사용이 제한된 기능입니다');
    Exit;
  end;

  if GridTableView.DataController.GetFocusedRecordIndex < 0 then Exit;

  if (GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDsSale.Index] = '취소') or (GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDsSale.Index] = '반품') then
    Exit;

  if NVL(GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewMemberCode.Index],'') <> '' then
  begin
    //회원에 포인트 적립코드를 지정안하고 판매 했을때 다시 적립해주기 위함
    if Common.AskBox(Format('이미 %s가 적립된 영수증입니다'#13'다시 적립하시겠습니까?',[Ifthen(GetOption(21) = '0', '포인트','스템프')])) then
      vRePoint := true
    else
      Exit;
  end;

  OpenQuery('select Count(*) '
           +'  from SL_SALE_H '
           +' where CD_STORE   =:P0 '
           +'   and NO_RCP_ORG =:P1 ',
           [Common.Config.StoreCode,
            FWorkDate+Common.Config.PosNo+GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index]]);
  if Common.Query.Fields[0].AsInteger > 0 then
  begin
    Common.Query.Close;
    Common.ErrBox('반품된 영수증입니다');
    Exit;
  end;

  Common.SetReceipt(FWorkDate,
                    Common.Config.PosNo,
                    GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index]);
  Common.GridToGrid(Common.Summary_sGrd, Common.Temp_sGrd);
  Common.Member.OrgOccurPoint := Common.PreSent.OccurPnt;
  Common.TaxCalculation;                         //부가세, 포인트  계산

  For vRow := 0 to Common.Card_SGrd.RowCount-1 do
    Common.Card_SGrd.Cells[GDC_YN_PRINT, vRow] := 'N';

  Common.WorkState := wsMagam;
  if not vRePoint then
  begin
    if Common.Config.IsKiosk then
    begin
      if FileExists(Common.AppPath+'\Kiosk\키패드.png') then
      begin
        KioskKeyPad_F := TKioskKeyPad_F.Create(Self);
        KioskKeyPad_F.isPhoneNumber := GetOption(442) = '0';
        KioskKeyPad_F.isPassword           := false;
        if GetOption(442) = '0' then
          KioskKeyPad_F.MessageLabel.Caption := '전화번호를 입력하세요'
        else
          KioskKeyPad_F.MessageLabel.Caption := '카드번호 또는 전화번호를 입력하세요';
        try
          if KioskKeyPad_F.ShowModal <> mrOK then Exit;
          vTelNo := KioskKeyPad_F.KeyInLabel.Hint;
        finally
          KioskKeyPad_F.Free;
        end;
      end
      else
      begin
        vTelNo := Common.ShowNumberForm('전화번호를 입력하세요', 12, 0, '010');
        if vTelNo = 'mrClose' then Exit;
      end;

      if Length(vTelNo) < 9 then
      begin
        Common.MsgBox('전화번호를 다시 입력해주세요');
        Exit;
      end;

      Common.SelectMemberInfo('','',vTelNo);
      if Common.Member.Code = '' then
      begin
        Common.MsgBox('등록되지 않은 전화번호입니다');
        Exit;
      end;
    end
    else
      if not Common.ShowMemberForm then Exit;
  end;
    //푸드코트 + 층별 VAN다르게
  if not SetCornerReceipt then Exit;

  try
    Common.SelectMemberInfo(Common.Member.Code,'','');
    Common.PreSent.RcpNo := GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index];
    vTempDate            := Common.WorkDate;
    Common.WorkDate      := FWorkDate;


    if Common.SaleDataSave('P', vErrMsg) then
      Common.MsgBox(Format('%s가 정상적으로 적립되었습니다',[Ifthen(GetOption(21) = '0', '포인트','스템프')]))
    else
      Common.ErrBox(vErrMsg+#13+Format('%s가 정상적으로 적립되지 않았습니다',[Ifthen(GetOption(21) = '0', '포인트','스템프')]));
  finally
    Common.WorkDate      := vTempDate;
    vBefRow := GridTableView.DataController.GetFocusedRecordIndex;
    SelectReceipt(0);
    GridTableView.DataController.FocusedRecordIndex := vBefRow;
  end;
end;

procedure TRcpChange_F.Action5Execute(Sender: TObject);
var vRow :Integer;
    vSaleDate, vTemp:String;
begin
  try
    LockWindowUpdate(Handle);

    if GetUserOption(10) = '0' then
    begin
      if GetOption(172) = '0' then
      begin
        Common.ErrBox('결제변경 사용권한이 없습니다');
        Exit;
      end
      else
      begin
        if not Common.CheckAuthority(10) then Exit;
      end;
    end;

    Common.ClearCornerData;
    if GridTableView.DataController.GetFocusedRecordIndex < 0 then Exit;
    if not Common.CheckAcctPos then Exit;

    if (GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewCloseNo.Index] <> '0') and (GetOption(221) = '0') then
    begin
      Common.ErrBox('계산원마감이 완료된 영수증은'+#13#13+
                    '결제변경을 할 수 없습니다');
      Exit;
    end;

    if GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDsSale.Index] = '취소' then
    begin
      Common.ErrBox('취소 된 영수증은'#13'결제변경을 할 수 없습니다');
      Exit;
    end;

    if not CheckTrust then Exit;

    if GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDsSale.Index] = '반품' then
    begin
      Common.ErrBox('반품 영수증은'#13'결제변경을 할 수 없습니다');
      Exit;
    end;

    Common.Present.RcpNo   := GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index];

    if OpenQuery('select * '
                +'  from SL_SALE_H '
                +' where CD_STORE   =:P0 '
                +'   and NO_RCP_ORG =:P1 ',
                [Common.Config.StoreCode,
                 FWorkDate + Common.Config.PosNo + Common.Present.RcpNo]) > 0 then
    begin
      Common.ErrBox('이미 반품 된 영수증입니다');
      Exit;
    end;

    if GetOption(22) = '1' then
    begin
      vTemp := Common.ShowNumberForm('패스워드를 입력하세요', 16);
      if vTemp = 'mrClose' then Exit;

      if Common.Config.UserPass <> vTemp then
      begin
        Common.ErrBox('패스워드가 올바르지 않습니다');
        Exit;
      end;
    end;

    if not Common.IsDebugMode then
      BlockInput(true);
    Common.ShowWaitForm;
    InitTableRecord(Common.Table);
    Common.SetReceipt(FWorkDate,
                      Common.Config.PosNo,
                      Common.Present.RcpNo);

    Common.PreSent_Temp := Common.PreSent;

    //불러온 신용카드결제 내역은 출력하지 않도록 한다
    for vRow := Common.Card_SGrd.RowCount-1 downto 0 do
    begin
      if Common.Card_sGrd.Cells[GDC_DS_TRD, vRow] = dtCancel then Continue;
      //이미취소된 건인지 체크
      if CheckCardCancel(Common.Card_sGrd.Cells[GDC_NO_APPROVAL, vRow], Common.Card_sGrd.Cells[GDC_AMT, vRow]) then
         Common.DeleteRow(Common.Card_sGrd, vRow);
    end;

    for vRow := Common.Card_SGrd.RowCount-1 downto 0 do
    begin
      if Common.Card_sGrd.Cells[GDC_DS_TRD, vRow] = dtCancel then
         Common.DeleteRow(Common.Card_sGrd, vRow);
    end;


    for vRow := Common.Cash_SGrd.RowCount-1 downto 0 do
    begin
      if Common.Cash_sGrd.Cells[GDR_DS_TRD, vRow] = dtCancel then Continue;
      //이미취소된 건인지 체크
      if CheckCashCancel(Common.Cash_sGrd.Cells[GDR_NO_APPROVAL, vRow]) then
         Common.DeleteRow(Common.Cash_sGrd, vRow);
    end;

    for vRow := Common.Cash_SGrd.RowCount-1 downto 0 do
    begin
      if Common.Cash_sGrd.Cells[GDR_DS_TRD, vRow] = dtCancel then
        Common.DeleteRow(Common.Cash_sGrd, vRow);
    end;


    Common.OrderKind := okChange;

    //푸드코트 + 층별 VAN다르게
    if not SetCornerReceipt then Exit;

    //테이블방식일때는 주문폼생성
    if not Common.Config.IsTakeOut then
    begin
      Order_F := TOrder_F.Create(self);
    end;
    Common.HideWaitForm;
    case ShowMode of
      fsmNone :
      begin
        //마감된 일자에 대해 결제변경시  (키오스크 또는 렛츠오더 건을 결제변경)
        if ((GetOption(221) = '1') or ChangePosKiosk or ChangePosLetsOrder) and (Common.WorkDate <> FWorkDate) then
        begin
          vSaleDate       := Common.WorkDate;
          Common.WorkDate := FWorkDate;
        end;
        Order_F.ShowModal;
        try
          Application.ProcessMessages;
        finally
          Common.OrderKind := okNew;
          vRow := GridTableView.DataController.GetFocusedRecordIndex;
          if not Common.Config.IsTakeOut then
            FreeAndNil(Order_F);
          if ((GetOption(221) = '1') or ChangePosKiosk or ChangePosLetsOrder) and (Common.WorkDate <> FWorkDate) then
            Common.WorkDate := vSaleDate;
          FullSearchButtonClick(FullSearchButton);
          GridTableView.DataController.FocusedRecordIndex := vRow;
        end;
      end;
      fsmSale :
      begin
        Common.WorkDate := FWorkDate;
        Close;
      end;
    end;
  finally
    if ShowMode <> fsmSale then
      SelectReceipt(0);
    Common.ClearKitchenData;
    BlockInput(false);
    LockWindowUpdate(0);
  end;
end;

procedure TRcpChange_F.Action6Execute(Sender: TObject);
  function CheckCardCancel(vApprovalNo:String):Boolean;
  var vRow :Integer;
  begin
    Result := False;
    For vRow := 0 to Common.Card_SGrd.RowCount-1 do
    begin
      if (Common.Card_sGrd.Cells[GDC_DS_TRD, vRow] = dtCancel) and
         (Common.Card_sGrd.Cells[GDC_APPROVAL_ORG, vRow] = vApprovalNo) then
      begin
        Common.Card_sGrd.Cells[GDC_YN_PRINT, vRow] := 'N';
        Result := True;
        Break;
      end;
    end;
  end;
var TmpPrintMode : TPrintMode;
    vTempDate :String;
    vIndex, vCnt, vPoint :Integer;
begin
  Common.ClearCornerData;
  if GridTableView.DataController.GetFocusedRecordIndex < 0 then Exit;

  Common.SetReceipt(FWorkDate,
                    Common.Config.PosNo,
                    GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index]);

  Common.GridToGrid(Common.Summary_sGrd, Common.Temp_sGrd);
  vPoint := Common.PreSent.OccurPnt;
  Common.TaxCalculation;                         //부가세, 포인트  계산
  Common.PreSent.OccurPnt := vPoint;
  Common.Member.CreditAmt := Common.Member.CreditAmt - Common.PreSent.TrustAmt;
  vCnt := 0;

  Common.WorkState := wsMagam;

  //푸드코트 + 층별 VAN다르게
  if not SetCornerReceipt then Exit;

  if GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDsSale.Index] = '취소' then
  begin
    with Common.PreSent, Common.Summary_sGrd do
    begin
      Common.Member.OrgOccurPoint := OccurPnt;
      TotalAmt  := TotalAmt    * -1;
      CashAmt   := CashAmt     * -1;
      GiveAmt   := 0;
      CheckAmt  := CheckAmt    * -1;
      GiftAmt   := GiftAmt     * -1;
      TrustAmt  := TrustAmt    * -1;
      MenuDc    := MenuDc      * -1;
      SpcDc     := SpcDc       * -1;
      TipAmt    := TipAmt      * -1;
      RcpDc     := RcpDc       * -1;
      MemberDc  := MemberDc    * -1;
      PointDc   := PointDc     * -1;
      OccurPnt  := OccurPnt    * -1;
      UsePnt    := UsePnt      * -1;
      For vIndex := 0 to RowCount-1 do
      begin
        Cells[GDM_VIEWQTY,    vIndex] := FtoS( StoF(Cells[GDM_QTY,        vIndex]) *-1);
        Cells[GDM_QTY,        vIndex] := FtoS( StoF(Cells[GDM_QTY,        vIndex]) *-1);
        Cells[GDM_DC_RECEIPT, vIndex] := FtoS( StoF(Cells[GDM_DC_RECEIPT, vIndex]) *-1);
        Cells[GDM_DC_STAMP,   vIndex] := FtoS( StoF(Cells[GDM_DC_STAMP,   vIndex]) *-1);
        Cells[GDM_DC_TAXFREE, vIndex] := FtoS( StoF(Cells[GDM_DC_TAXFREE, vIndex]) *-1);
        Cells[GDM_DC_MENU,    vIndex] := FtoS( StoF(Cells[GDM_DC_MENU,    vIndex]) *-1);
        Cells[GDM_DC_SPC,     vIndex] := FtoS( StoF(Cells[GDM_DC_SPC,     vIndex]) *-1);
        Cells[GDM_DC_MEMBER,  vIndex] := FtoS( StoF(Cells[GDM_DC_MEMBER,  vIndex]) *-1);

        if Cells[GDM_DS_MENU, vIndex] = 'W' then
          Cells[GDM_AMT,    vIndex] := '-' + Cells[GDM_AMT,    vIndex]
        else
          Cells[GDM_AMT,    vIndex] := FtoS( StoF(Cells[GDM_PR_SALE,   vIndex]) * StoF(Cells[GDM_QTY, vIndex]));
      end;
      Common.GridToGrid(Common.Summary_sGrd, Common.Temp_sGrd);
      Common.TaxCalculation;
    end;
  end;

  Common.SaleDateTime := GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewSaleDate.Index];
  Common.ComeDateTime := GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewComeDate.Index];
  vTempDate        := Common.WorkDate;
  Common.WorkDate  := FWorkDate;
  TmpPrintMode     := Common.RealPrintMode;
  Common.RealPrintMode := pmRePrint;
  try
    Common.ShowWaitForm('출력 중 입니다...');
    if GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDsSale.Index] = '취소' then
      Common.isVoidRePrint := true;
    Common.Device.Receipt_Print('P');
    if (GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDsSale.Index] = '정상') and (Common.PreSent.CouponAmt_Issue > 0) then
      Common.Device.CouponPrint;
    Common.RealPrintMode := TmpPrintMode;

    //TakeOut일때만 출력한다
    if (KitchenReceiptOnButton.Status.Caption = 'V') and (GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewTableNo.Index] = 0) then
    begin

      OpenQuery('select a.CD_PRINTER, '
               +'       a.PRINT_DATA, '
               +'       a.ORDER_TIME, '
               +'       a.NO_ORDER,'
               +'       a.NO_PERSON, '
               +'       a.NM_DAMDANG '
               +'  from SL_SALE_PRT as a inner join '
               +'       MS_CODE     as b on b.CD_STORE = a.CD_STORE '
               +'                       and b.CD_KIND  = ''02'' '
               +'                       and b.CD_CODE  = a.CD_PRINTER '
               +'                       and b.NM_CODE12 <> ''1'' '             //KDS 주방제외
               +' where a.CD_STORE =:P0 '
               +'   and a.YMD_SALE =:P1 '
               +'   and a.NO_POS   =:P2  '
               +'   and a.NO_RCP   =:P3 '
               +'   and a.CD_PRINTER <> ''000'' '
               +' order by a.CD_PRINTER',
               [Common.Config.StoreCode,
                FWorkDate,
                Common.Config.PosNo,
                GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index]]);

      Common.ClearKitchenData;
      if not Common.Query.Eof then
      begin
        if not Common.AskBox('주방주문서를 출력하시겠습니까?') then Exit;
      end;

      while not Common.Query.Eof do
      begin
        Common.Table.OrderNo       := Common.Query.FieldByName('no_order').AsInteger;
        Common.Table.CustomerCount := Common.Query.FieldByName('no_person').AsInteger;
        Common.Table.DamdangName   := Common.Query.FieldByName('nm_damdang').AsString;
        vIndex  := Common.GetKitchenIndex(0, 1, Common.Query.FieldByName('cd_printer').AsString);
        Common.KitchenPrinter[vIndex].Data   :=Common.Query.FieldByName('print_data').AsString;
        Common.Device.KitchenOrderPrint(vIndex);
        Common.Query.Next;
      end;
    end;
  finally
    Common.Query.Close;
    Common.isVoidRePrint := false;
    Common.HideWaitForm;
    Common.WorkDate := vTempDate;
  end;
end;

procedure TRcpChange_F.Action7Execute(Sender: TObject);
var vCashAmt :Integer;
    vErrMsg  :String;
    vWorkDate:String;
    vGiftAmt :Integer;
begin
  if GridTableView.DataController.GetFocusedRecordIndex < 0 then Exit;

  if not Common.CheckAcctPos then Exit;
  if GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewCashRcpAmt.Index] > 0 then
  begin
    Common.ErrBox('현금영수증이 발행된 영수증입니다');
    Exit;
  end;

  if (GetOption(128) = '0') and (GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewCloseNo.Index] <> '0') then
  begin
    Common.ErrBox('계산원마감이 완료된 영수증입니다');
    Exit;
  end;


  if GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDsSale.Index] = '취소' then
  begin
    Common.ErrBox('취소 된 영수증은 현금영수증을'+#13#13+'발행할 수 없습니다');
    Exit;
  end;

  if GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDsSale.Index] = '반품' then
  begin
    Common.ErrBox('반품영수증은 현금영수증을'+#13#13+'발행할 수 없습니다');
    Exit;
  end;

  if OpenQuery('select * '
              +'  from SL_SALE_H '
              +' where CD_STORE   =:P0 '
              +'   and NO_RCP_ORG =:P1 ',
              [Common.Config.StoreCode,
               FWorkDate + Common.Config.PosNo + GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index]]) > 0 then
  begin
    Common.ErrBox('이미 반품 된 영수증입니다');
    Exit;
  end;

  if (GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewCashAmt.Index]     //현금
     +GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewBankAmt.Index]
     +GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewCheckAmt.Index]
     +GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewGiftAmt.Index]) <= 0 then
  begin
    Common.ErrBox('현금금액이 없습니다');
    Exit;
  end;

  //푸드코트 + 층별 VAN다르게
  if not SetCornerReceipt then Exit;

  try
    vWorkDate := Common.WorkDate;
    with Common do
    begin
      Common.WorkDate := FWorkDate;
      SetReceipt(FWorkDate,
                 Config.PosNo,
                 GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index]);

      PreSent.WRcvAmt := PreSent.CashAmt
                       + Present.CheckAmt
                       + Present.BankAmt
                       + Present.GiftAmt
                       + Present.TrustAmt
                       + Present.PointAmt;

      vGiftAmt := Present.GiftAmt;
      Present.GiftAmt := 0;
      vCashAmt := PreSent.CashAmt + PreSent.BankAmt;
      //투밴을 사용하면서 단말기 승인이 아니면 현금영수증폼에서 현금금액을 계산한다.
      if (GetOption(60) = '1') and (Common.CashRcp.Ds_Input <> 'O') then
        PreSent.CashAmt := 0;
      InitCashRcpRecord(Common.CashRcp);
      GridToGrid(Summary_sGrd, Temp_sGrd);

      if not ShowCashRcpForm(true) then Exit;
      if (GetOption(60) = '0') and (Common.CashRcp.Ds_Input <> 'O') then
      begin
        PreSent.CashAmt := vCashAmt;
        PreSent.CashRcpAmt := CashRcp.Amt_Approval;
        CashRcpInfoSave;
      end
      else if (Common.CashRcp.Ds_Input = 'O') then
      begin
        PreSent.CashAmt := vCashAmt;
        PreSent.CashRcpAmt := CashRcp.Amt_Approval;
        CashRcpInfoSave;
      end;
      InitCashRcpRecord(CashRcp);

      Present.RcpNo := GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index];
      Present.GiftAmt := vGiftAmt;
      if not SaleDataSave('H', vErrMsg) then
      begin
        ErrBox(vErrMsg+#13+'현금영수증 발행내역을 저장하지 못했습니다');
        Exit;
      end
      else
      begin
        GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewCashRcpAmt.Index] := IntToStr(Present.CashRcpAmt);
        GridTableViewFocusedRecordChanged(GridTableView, nil, nil, False);
        MsgBox('현금영수증 발행이 완료되었습니다');
      end;
    end;
  finally
    Common.WorkDate := vWorkDate;
  end;
end;

//결제취소
procedure TRcpChange_F.Action8Execute(Sender: TObject);
var vRow, vCashAmt, VCardAmt, I, II :Integer;
    lbCancel :Boolean;
    vTemp, vTemp1, vSaleDate :String;
    vErrMsg :String;
    vGubun :Char;
    vTempGrid :TStringGrid;
    vIsKDS    :Boolean;
    vIndex    :Integer;
    vSaleRcpNo,
    vReceiptNo :String;
    vOptions   :String;
    vUserCode,
    vUserName :String;
    vCnt, vCancelCount :Integer;
    vExistsPrintData :Boolean;
label Loop, LoopPG;
begin
  vOptions := Common.Config.Options;

  if GetUserOption(10) = '0' then
  begin
    if GetOption(172) = '0' then
    begin
      Common.ErrBox('결제취소 사용권한이 없습니다');
      Exit;
    end
    else
    begin
      if not Common.CheckAuthority(10) then Exit;
    end;
  end;
  try
    if isPosChange then
    begin
      vUserCode := Common.Config.UserCode;
      vUserName := Common.Config.UserName;
    end;

    Common.ClearCornerData;
    vTempGrid          := TStringGrid.Create(Application);
    vTempGrid.ColCount := GDM_COLCOUNT;
    vTempGrid.RowCount := 0;
    VCardAmt := 0;

    if GridTableView.DataController.GetFocusedRecordIndex < 0 then Exit;

    lbCancel := False;
    if not Common.CheckAcctPos then Exit;

    if GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDsSale.Index] = '반품' then
    begin
      Common.ErrBox('반품 영수증입니다');
      Exit;
    end;

    if GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDsSale.Index] = '취소' then
    begin
      Common.ErrBox('취소 된 영수증입니다');
      Exit;
    end;

    Common.OrgReceiptNo := FWorkDate + Common.Config.PosNo + GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index];

    OpenQuery('select Count(*) '
             +'  from SL_SALE_H '
             +' where CD_STORE   =:P0 '
             +'   and NO_RCP_ORG =:P1 ',
             [Common.Config.StoreCode,
              FWorkDate + Common.Config.PosNo + GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index]]);

    if Common.Query.Fields[0].AsInteger > 0 then
    begin
      Common.Query.Close;
      Common.ErrBox('이미 반품 된 영수증입니다');
      Exit;
    end;

    //식권사용여부체크
    if Common.KioskConfig[12] = 1 then
    begin
      OpenQuery('select Count(*) '
               +'  from SL_SALE_TICKET '
               +' where CD_STORE =:P0 '
               +'   and YMD_SALE =:P1 '
               +'   and NO_POS   =:P2 '
               +'   and NO_RCP   =:P3 '
               +'   and DS_STATUS=''1'' ',
               [Common.Config.StoreCode,
                FWorkDate,
                Common.Config.PosNo,
                GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index]]);

      if Common.Query.Fields[0].AsInteger > 0 then
      begin
        Common.Query.Close;
        Common.ErrBox('사용된 식권이 있습니다');
        Exit;
      end;
    end;

    try
      Common.OrgReceiptCoupon := false;
      OpenQuery('select DS_STATUS '
               +'  from MS_COUPON '
               +' where CD_STORE  =:P0 '
               +'   and RCP_ISSUE =:P1 ',
               [Common.Config.StoreCode,
                FWorkDate+Common.Config.PosNo
                +GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index]]);

      if not Common.Query.Eof and (Common.Query.Fields[0].AsString = '1') then
      begin
        Common.Query.Close;
        Common.ErrBox('해당 영수증으로 발행된 쿠폰이'#13'사용되어 취소할 수 없습니다');
        Exit;
      end
      else if not Common.Query.Eof and (Common.Query.Fields[0].AsString = '0') then
        Common.OrgReceiptCoupon := true;

    finally
      Common.Query.Close;
    end;


    if not CheckTrust then Exit;

    //푸드코트 + 층별 VAN다르게
    if not SetCornerReceipt then Exit;

    if (cxGrid3.Visible) and (gvBanpum.DataController.RowCount > 0) then
    begin
      //테이블방식일때는 주문폼생성
      if not Common.Config.IsTakeOut then
      begin
        Order_F := TOrder_F.Create(self);
      end;
      Common.HideWaitForm;
      Common.OrderKind := okBanpum;
      InitTableRecord(Common.Table);

      case ShowMode of
        fsmNone :
        begin
          Order_F.ShowModal;
          try
            Application.ProcessMessages;
          finally
            Common.OrderKind := okNew;
            vRow := GridTableView.DataController.GetFocusedRecordIndex;
            if not Common.Config.IsTakeOut then
              FreeAndNil(Order_F);
            FullSearchButtonClick(FullSearchButton);
            GridTableView.DataController.FocusedRecordIndex := vRow;
          end;
        end;
        fsmSale :
        begin
          Close;
        end;
      end;
      Exit;
     end;

    if (GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewCloseNo.Index] <> '0') and (GetOption(221) = '0') then
    begin
      if not Common.AskBox('계산원마감이 완료된 영수증입니다'+#13#13+
                           '반품처리 하시겠습니까?') then Exit;
        Common.BanReceipt := FWorkDate + GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index];

      vTemp := '반품';
    end
    else
    begin
      if GetOption(357) = '1' then
      begin
        vTemp := '반품';
        Common.BanReceipt := FWorkDate + GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index];
      end
      else
      begin
        vTemp := '취소';
        //푸드코트 취소시 사용(혹시나해서 Common.BanReceipt에 셋팅하지 않는다)
        vSaleRcpNo := FWorkDate + GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index];
      end;
    end;

    if not Common.AskBox(GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index]+'번 영수증을'+#13#13+
                         vTemp+' 하시겠습니까?') then Exit;

    if (vTemp = '반품') and (Common.Config.PosNo <> Common.Config.OriginalPosNo) and ChangePosKiosk then
      Common.MsgBox(Format('%s 포스가 사용 중인지 확인하세요'#13'사용 중에 반품을 하면 저장을 못할 수 있습니다',[Common.Config.PosNo]));

    //취소사유를 입력한다고 체크했으면
    if (GetOption(40) = '1') and not Common.Config.IsKiosk then
    begin
      try
        OrderCancel_F := TOrderCancel_F.Create(Self);       //주문취소폼 생성
        OrderCancel_F.CanMode := cmSale;
        OrderCancel_F.ShowModal;
      finally
        FreeAndNil(OrderCancel_F);
      end;

      if Common.WhyOrdercancel = EmptyStr then
      begin
        Common.ErrBox('취소사유를 입력하지 않았습니다'+#13#13+
                      '취소사유를 입력하세요');
        Exit;
      end;
    end;
    if not Common.IsDebugMode then
      BlockInput(true);

    if vTemp = '취소' then
    begin
      if not Common.SetReceipt(FWorkDate,
                               Common.Config.PosNo,
                               GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index]) then
      begin
        Common.ErrBox('영수증을 불러오지 못했습니다'+#13#13+
                      '잠시 후 다시 시도하세요');
        Exit;
      end;

      vReceiptNo := FWorkDate + Common.Config.PosNo + GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index];

      Common.PreSent.OccurPnt := 0;
      Common.PreSent.UsePnt   := 0;
      OpenQuery('select DS_STATUS '
               +'  from MS_COUPON '
               +' where CD_STORE  =:P0 '
               +'   and RCP_ISSUE =:P1 ',
               [Common.Config.StoreCode,
                FWorkDate+Common.Config.PosNo+GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index]]);

    end
    else
    begin
      if not Common.SetReceipt(Copy(Common.BanReceipt, 1, 8),
                               Common.Config.PosNo,
                               Copy(Common.BanReceipt, 9, 4)) then
      begin
        Common.ErrBox('영수증을 불러오지 못했습니다'+#13#13+
                      '잠시 후 다시 시도하세요');
        Exit;
      end;

      vReceiptNo := Copy(Common.BanReceipt, 1, 8) + Common.Config.PosNo + Copy(Common.BanReceipt, 9, 4);
      //반품일때는 외상금액을 다시 계산한다

      //쿠폰을 발행해서 쿠폰을 사용 후에 반품할려구 할때
      OpenQuery('select DS_STATUS '
               +'  from MS_COUPON '
               +' where CD_STORE  =:P0 '
               +'   and RCP_ISSUE =:P1 ',
               [Common.Config.StoreCode,
                Copy(Common.BanReceipt, 1, 8)+Common.Config.PosNo+Copy(Common.BanReceipt, 9, 4)]);
    end;


    if not Common.Query.Eof and (Common.Query.Fields[0].AsString = '1') then
    begin
      if not Common.AskBox('해당 영수증으로 발행된 쿠폰이'#13'이미 사용되었습니다'+#13#13+
                           '계속 하시겠습니까?') then Exit;
    end;

    //시스템시간을 체크한다
    Common.SetSystemTimeSync;

    Common.PreSent.RcpNo := GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index];

    Common.GridToGrid(Common.Summary_sGrd, vTempGrid);
    For vRow := 0 to Common.Card_SGrd.RowCount-1 do
      Common.Card_SGrd.Cells[GDC_YN_PRINT, vRow] := 'N';

    For vRow := 0 to Common.Cash_SGrd.RowCount-1 do
      Common.Cash_SGrd.Cells[GDR_YN_PRINT, vRow] := 'N';

    Common.OrderKind := okCancel;

    Common.DeleteSignFile;
    with Common.PreSent, Common.Summary_sGrd do
    begin
      //신용카드승인이 있을때
      //신용카드를 사용하지 않는다고 설정했으면
      if GetOption(51) = '1' then
      begin
        Common.WriteLog('work', '신용카드 기능을 사용하지 않아서 실제 취소 안함');
        CardAmt := CardAmt * -1;
      end
      else
      begin
        if (CardAmt > 0) then
        begin
          CardAmt := 0;
          vCancelCount := 0;
          with Common.Card_SGrd do
          for vRow := 0 to RowCount-1 do
          begin
            if Common.Card_sGrd.Cells[GDC_DS_TRD, vRow] = dtCancel then Continue;
            if Common.Card_sGrd.Cells[GDC_DS_CARD, vRow] = 'P' then Continue;
            //이미취소된 건인지 체크
            if CheckCardCancel(Common.Card_sGrd.Cells[GDC_NO_APPROVAL, vRow], Common.Card_sGrd.Cells[GDC_AMT, vRow]) then Continue;

            //카드 제거시간을 준다
            if vCancelCount > 0 then
              Common.MsgBox('카드를 제거해주세요');

            InitCardRecord(Common.Card);
            Common.CardInfoLoad(vRow);

            Loop:
            if Common.ShowCardForm(false, False) then
            begin
              Application.ProcessMessages;
              lbCancel := True;
              Common.Card_sGrd.Cells[GDC_YN_CAN, vRow] := 'Y';
              CardCancelAmt := CardCancelAmt + Common.Card.Amt;
              Common.CardInfoSave;
              vCardAmt := vCardAmt + Common.Card.Amt * -1;  //카드가 2건 이상일때 1건은 취소가 되고 1건이 취소안될때 사용
              CardAmt  := CardAmt + Common.Card.Amt * -1;
              Inc(vCancelCount);
            end
            else
            begin
               if (GetOption(299)='1') and (Common.AskBox('신용카드가 취소되지 않았습니다'+#13#13+'현금으로 지급하시겠습니까?')) then
               begin
                 vTemp   := '반품';
                 Common.BanReceipt := CtoC(FWorkDate, '-','')+GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index];
                 CashAmt := CashAmt + Common.Card.Amt;
               end
               else
               begin
                 if vCardAmt < 0 then
                 begin
                   if Common.AskBox('신용카드가 취소되지 않았습니다'+#13#13+'다시 시도하시겠습니까?') then goto Loop
                   else
                   begin
                     Common.MsgBox('카드 취소내역이 있어서 취소되지 않은'+#13#13+'카드금액은 현금으로 지급합니다');
                     vTemp   := '반품';
                     Common.BanReceipt := CtoC(FWorkDate,'-','')+GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index];
                     CashAmt := CashAmt + Common.Card.Amt;
                   end;
                 end
                 else Exit;
               end
            end; //if Common.ShowCardForm('2') then
          end;
          // 결제변경 시 할인 기능을 사용할 수 없습니다.
          if (GetOption(299)='0') and (Common.PreSent.CardAmt = 0) then
          begin
            Common.ErrBox('신용카드가 취소되지 않았습니다'+#13#13+
                          '다시 시도하세요');
            Exit;
          end;
        end;

        if (LetsOrderAmt > 0) then
        begin
          LetsOrderAmt := 0;
          with Common.Card_SGrd do
          for vRow := 0 to RowCount-1 do
          begin
            if Common.Card_sGrd.Cells[GDC_DS_TRD, vRow] = dtCancel then Continue;
            if Common.Card_sGrd.Cells[GDC_DS_CARD, vRow] <> 'P' then Continue;
            if StrToInt(Common.Card_sGrd.Cells[GDC_AMT, vRow]) - StrToInt(Common.Card_sGrd.Cells[GDC_AMT_CANCEL, vRow]) = 0 then Continue;

            //이미취소된 건인지 체크
            if CheckCardCancel(Common.Card_sGrd.Cells[GDC_NO_APPROVAL, vRow], Common.Card_sGrd.Cells[GDC_AMT, vRow]) then Continue;

            InitCardRecord(Common.Card);
            Common.CardInfoLoad(vRow);

            LoopPG:
            //온라인(배달)주문건 취소일때
            if Common.PGCardCancel(vReceiptNo, Common.Card_sGrd.Cells[GDC_PG_TID, vRow], StrToInt(Common.Card_sGrd.Cells[GDC_AMT, vRow]) - StrToInt(Common.Card_sGrd.Cells[GDC_AMT_CANCEL, vRow]), Common.Card_sGrd.Cells[GDC_AMT_CANCEL, vRow] <> '0') then
            begin
              Application.ProcessMessages;
              lbCancel := True;
              Common.Card_sGrd.Cells[GDC_YN_CAN, vRow] := 'Y';
              Common.Card.CardNo         := Common.Card_sGrd.Cells[GDC_CARDNO, vRow];
              Common.Card.Nm_Card        := Common.Card_sGrd.Cells[GDC_NAME, vRow];
              Common.Card.OrgApprovalNo  := Common.Card_sGrd.Cells[GDC_NO_APPROVAL, vRow];
              Common.Card.Halbu          := Common.Card_sGrd.Cells[GDC_HALBU, vRow];
              Common.Card.Trd_Date       := FormatDateTime('yyyymmdd',Now());
              Common.Card.Trd_Time       := FormatDateTime('hhnn',Now());
              Common.Card.Trd_Date_Org   := Common.Card_sGrd.Cells[GDC_TRD_DATE, vRow];
              Common.Card.VatAmt         := StrToInt(Common.Card_sGrd.Cells[GDC_VATAMT, vRow]);

              //일부취소건 반품일때
              if StrToInt(Common.Card_sGrd.Cells[GDC_AMT_CANCEL, vRow]) > 0 then
              begin
                Common.Card.Amt       := StrToInt(Common.Card_sGrd.Cells[GDC_AMT, vRow]);
                Common.Card.CancelAmt := StrToInt(Common.Card_sGrd.Cells[GDC_AMT_CANCEL, vRow]);
              end;

              Common.CardInfoSave(2);
              vCardAmt := vCardAmt + Common.Card.Amt * -1;  //카드가 2건 이상일때 1건은 취소가 되고 1건이 취소안될때 사용
              LetsOrderAmt  := LetsOrderAmt + Common.Card.Amt * -1;
            end
            else
            begin
               if (GetOption(299)='1') and (Common.AskBox('렛츠오더가 취소되지 않았습니다'+#13#13+'현금으로 지급하시겠습니까?')) then
               begin
                 vTemp   := '반품';
                 Common.BanReceipt := CtoC(FWorkDate, '-','')+GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index];
                 CashAmt := CashAmt + Common.Card.Amt;
               end
               else
               begin
                 if vCardAmt < 0 then
                 begin
                   if Common.AskBox('렛츠오더가 취소되지 않았습니다'+#13#13+'다시 시도하시겠습니까?') then goto LoopPG
                   else
                   begin
                     Common.MsgBox('렛츠오더 취소내역이 있어서 취소되지 않은'+#13#13+'렛츠오더 금액은 현금으로 지급합니다');
                     vTemp   := '반품';
                     Common.BanReceipt := CtoC(FWorkDate,'-','')+GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index];
                     CashAmt := CashAmt + Common.Card.Amt;
                   end;
                 end
                 else Exit;
               end
            end;
          end;
          // 결제변경 시 할인 기능을 사용할 수 없습니다.
          if (GetOption(299)='0') and (Common.PreSent.LetsOrderAmt = 0) then
          begin
            Common.ErrBox('렛츠오더가 취소되지 않았습니다'+#13#13+
                          '다시 시도하세요');
            Exit;
          end;
        end;
      end;

      BlockInput(false);
      //현금영수증 승인이 있을때
      if CashRcpAmt > 0 then
      begin
        if GetOption(51) = '1' then
        begin
          CashRcpAmt := CashRcpAmt * -1;
        end
        else
        begin
          with Common.Cash_SGrd do
          For vRow := 0 to RowCount-1 do
          begin
            InitCashRcpRecord(Common.CashRcp);
            Common.CashRcpInfoLoad(vRow);
            if Common.Cash_sGrd.Cells[GDR_DS_TRD, vRow] = dtCancel then Continue;
            if CheckCashCancel(Cells[GDR_NO_APPROVAL, vRow]) then Continue;
            if Common.CashRcp.Ds_Input <> 'O' then
            begin
              if Common.ShowCashRcpForm(false) then
              begin
                lbCancel := True;
                Common.Cash_sGrd.Cells[GDR_YN_CAN, vRow] := 'Y';
                CashRcpAmt := Common.CashRcp.Amt_Approval;
                Common.CashRcpInfoSave;
              end
              else if vCardAmt < 0 then
              begin
                Common.MsgBox('현금영수증이 취소되지 않았습니다'+#13+'신용카드 취소내역이 있어서 영수증은 취소됩니다');
              end
              else
              begin
                if not Common.AskBox('현금영수증이 취소되지 않았습니다'+#13#13+'계속하시겠습니까?') then
                  Exit;
              end; //if Common.ShowCashRcpForm('1') then
            end
            else
            begin
              Common.CashRcp.Ds_Trd := dtCancel;
              Common.CashRcp.Yn_Can := 'Y';
              CashRcpAmt := Common.CashRcp.Amt_Approval;
              Common.CashRcpInfoSave;
            end;
          end; //For liRow := 0 to RowCount-1 do
        end;
      end;

      if Common.PreSent.UPlusDc > 0 then
      begin
        Common.UplusInfoLoad(False);
        if not Common.ShowUPlusForm(False) then
        begin
          if not Common.AskBox('유플러스 할인이 취소되지 않았습니다'+#13#13+
                               '계속하시겠습니까?') then
          begin
            InitUPlusRecord(Common.UPlus);
            Exit;
          end;
        end;
      end;

      TotalAmt   := TotalAmt    * -1;
      TotalDc    := TotalDc     * -1;
      CashAmt    := CashAmt     * -1;
      GiveAmt    := 0;
      CheckAmt   := CheckAmt    * -1;
      GiftAmt    := GiftAmt     * -1;
      TrustAmt   := TrustAmt    * -1;
      BankAmt    := BankAmt     * -1;
      MenuDc     := MenuDc      * -1;
      SpcDc      := SpcDc       * -1;
      TipAmt     := TipAmt      * -1;
      ServiceAmt := ServiceAmt  * -1;
      RcpDc      := RcpDc       * -1;
      MemberDc   := MemberDc    * -1;
      PointDc    := PointDc     * -1;
      VatDc      := VatDc       * -1;
      CutDc      := CutDc       * -1;
      CodeDc     := CodeDc      * -1;
      TaxFreeDc  := TaxFreeDc   * -1;
      UplusDc    := UplusDc     * -1;
      CouponDc   := CouponDc    * -1;
      OccurPnt   := OccurPnt    * -1;
      UsePnt     := UsePnt      * -1;
      PointAmt   := PointAmt    * -1;
      StampDc    := StampDc     * -1;
      SaveStamp  := SaveStamp   * -1;
      UseStamp   := UseStamp    * -1;

      For vRow := 0 to RowCount-1 do
      begin
        Cells[GDM_VIEWQTY,    vRow] := FtoS( StoF(Cells[GDM_QTY,        vRow]) *-1);
        Cells[GDM_QTY,        vRow] := FtoS( StoF(Cells[GDM_QTY,        vRow]) *-1);
        Cells[GDM_DC_RECEIPT, vRow] := FtoS( StoF(Cells[GDM_DC_RECEIPT, vRow]) *-1);
        Cells[GDM_DC_STAMP,   vRow] := FtoS( StoF(Cells[GDM_DC_STAMP,   vRow]) *-1);
        if Cells[GDM_DS_MENU, vRow] = 'W' then
          Cells[GDM_AMT,    vRow] := '-' + Cells[GDM_AMT,    vRow]
        else
          Cells[GDM_AMT,    vRow] := FtoS( StoF(Cells[GDM_PR_SALE,   vRow]) * StoF(Cells[GDM_QTY, vRow]) - StoF(Cells[GDM_PR_ITEM,   vRow]));
      end;
    end;

    if vTemp = '취소' then
    begin
      vGubun := 'V';
      Common.SelectMemberInfo(Common.Member.Code,'','');
      Common.Member.Point         := Common.Member.Point + Common.PreSent.UsePnt;
      Common.Member.Stamp         := Common.Member.Stamp + Common.PreSent.UseStamp;
      Common.Member.OrgOccurPoint := Common.PreSent.OccurPnt;
    end
    else
    begin
      Common.GetReceiptNo;
      vGubun := 'B';
      Common.SelectMemberInfo(Common.Member.Code,'','');
    end;


    Common.ClearGrid(Common.Cancel_sGrd);
    Common.ClearKitchenData;
    //마감된 일자에 대해 결제변경시
    if (GetOption(221) = '1') or ((ChangePosKiosk or ChangePosLetsOrder) and (Common.WorkDate <> FWorkDate)) then
    begin
      vSaleDate       := Common.WorkDate;
      Common.WorkDate := FWorkDate;
    end;

    if not Common.IsDebugMode then
      BlockInput(true);

    if Common.Config.IsKiosk then
    begin
      Common.Config.Options[165] := '0'; //전자서명 사용 시 전표를 출력하지 않습니다.
      Common.Config.Options[6]   := '0'; //신용카드 영수증 3장 출력함 (기본 2장)
      Common.Config.Options[230] := '0'; //신용카드 승인 시 영수증을 출력하지 않습니다.
      Common.Config.Options[42]  := '0'; //영수증과 신용카드 전표를 별도로 출력합니다.
    end;

    //포스변경을 했으면 계산원도 변경해준다
    if isPosChange then
    begin
      Common.Config.UserCode := GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewSawonCode .Index];
      Common.Config.UserName := GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewSawonName .Index];
    end;

    Common.Table.OrderNo := 0;
    if not Common.SaleDataSave(vGubun, vErrMsg) then
    begin
      if (GetOption(221) = '1') or ((ChangePosKiosk or ChangePosLetsOrder) and (Common.WorkDate <> FWorkDate)) then
        Common.WorkDate := vSaleDate;
      Common.ErrBox(vTemp+' ' +vErrMsg +#13+'작업을 완료하지 못했습니다');
      Exit;
    end
    else
    begin
      if (GetOption(221) = '1') or ((ChangePosKiosk or ChangePosLetsOrder) and (Common.WorkDate <> FWorkDate)) then
        Common.WorkDate := vSaleDate;
      if vTemp = '반품' then
        SaleDatePicker.Date := StoD(Common.WorkDate)
      else
        GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDsSale.Index] := '취소';

      if KitchenReceiptOnButton.Status.Caption  = 'V' then
      begin
        Common.ClearKitchenData;

        For vRow := 0 to vTempGrid.RowCount-1 do
          Common.Device.OrderCancel(vTempGrid, vRow, vTempGrid.Cells[GDM_QTY, vRow]);

        //주방주문서를 메뉴별로 출력하면서 그룹을 사용시 그룹으로 지정된 내역을 주방주문서 헤더를 만든다
        if (GetOption(9) = '1') and (GetOption(79) = '1') then
        begin
          For I := 0 to High(Common.KitchenPrinter) do
          begin
            For II := 1 to 100 do
            begin
              if Common.KitchenPrinter[I].GroupSource[II] = '' then Continue;

              vTemp1 := Common.Device.SetOrderPrintHeader(Common.KitchenPrinter[I].GroupSource[II], I);
              Common.KitchenPrinter[I].Data := Common.KitchenPrinter[I].Data +
                                               Common.Device.PrinterCommendReplace(vTemp1,
                                                                                   Common.KitchenPrinter[I].Device,
                                                                                   Common.KitchenPrinter[I].Col,
                                                                                   Common.KitchenPrinter[I].BottomMargin );
            end;
          end;
        end;

        vExistsPrintData := false;
        for I := 0 to High(Common.KitchenPrinter) do
        begin
          if Common.KitchenPrinter[I].Cancel <> '' then
          begin
            vExistsPrintData := true;
            Break;
          end;
        end;

        if vExistsPrintData and (Common.Table.Number > 0) and (GetOption(231) = '0') and (GetOption(233) = '0') then
          Common.Table.OrderNo := Common.GetOrderNo(1);

        For I := 0 to High(Common.KitchenPrinter) do
          Common.Device.KitchenOrderPrint(I);
      end;

      //주방모니터 내역 취소
      ExecQuery('update MS_COUPON '
               +'   set DS_STATUS  = ''0'', '
               +'       DT_CHANgE  = Now(), '
               +'       RCP_SALE   = '''' '
               +' where CD_STORE   =:P0 '
               +'   and RCP_SALE   =:P1 ',
               [Common.Config.StoreCode,
                FWorkDate
               +Common.Config.PosNo
               +GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index]]);

      vIsKDS := false;
      for vIndex := 0 to High(Common.KitchenPrinter) do
        if Common.KitchenPrinter[vIndex].IsKDS then
        begin
          vIsKDS := true;
          Break;
        end;

      if vIsKDS then
        ExecQuery('update SL_ORDER_KDS '
                 +'   set DS_STATUS = ''2'', '
                 +'       DT_CANCEL = Now(), '
                 +'       CD_SAWON  = :P4 '
                 +' where CD_STORE =:P0 '
                 +'   and YMD_SALE =:P1 '
                 +'   and NO_POS   =:P2 '
                 +'   and NO_RCP   =:P3 ',
                 [Common.Config.StoreCode,
                  Common.WorkDate,
                  Common.Config.PosNo,
                  GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index],
                  Common.Config.UserCode]);
    end;
    Common.CustomerCancel := EmptyStr;
    if (GetOption(231) = '1') and (GetOption(233) = '1') then
      Common.BanReceipt := vSaleRcpNo;

    vRow := GridTableView.DataController.GetFocusedRecordIndex;
    SelectReceipt(0);
    Common.MsgBox(vTemp +' 작업이 완료되었습니다');
    if vTemp = '취소' then
    begin
      GridTableView.Controller.FocusedRowIndex := vRow;
      GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDsSale.Index] := '취소';
    end;

  finally
    if isPosChange then
    begin
      Common.Config.UserCode := vUserCode;
      Common.Config.UserName := vUserName;
    end;

    Common.BanReceipt   := EmptyStr;
    Common.OrgReceiptNo := EmptyStr;
    vTempGrid.Free;
    if not Common.Config.IsTakeOut or (Common.OrderKind <> okBanpum) then
      Common.OrderKind := okNew;
    BlockInput(false);
  end;
end;

procedure TRcpChange_F.SaleDatePickerChange(Sender: TObject);
begin
  FWorkDate := DtoS(SaleDatePicker.Date);
  if isShowing then Exit;
  FullSearchButtonClick(FullSearchButton);
end;

procedure TRcpChange_F.ScannerReadEvent(const S: String);
begin
  if Length(S) <> 10 then Exit;

  if Copy(S,9,2) <> Common.Config.PosNo then
  begin
    Common.ErrBox('다른포스의 영수증은 조회할 수 없습니다');
    Exit;
  end;
  SaleDatePicker.Date := StoD(LeftStr(S,8));
  SelectReceipt(5, RightStr(S,4));
end;

procedure TRcpChange_F.Action9Execute(Sender: TObject);
var vSpcDc    :Integer;
    vTotDc    :Integer;
begin
  //선불제일때
  if GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewTableNo.Index] = 0 then
  begin
    Common.OrderKind := okSaleChange;
    InitTableRecord(Common.Table);
    Common.SetReceipt(FWorkDate,
                      Common.Config.PosNo,
                      GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index]);

    vSpcDc := Common.Present.SpcDc;
    vTotDc := Common.Present.TotalDC;
    InitPreSentRecord(Common.Present);
    Common.Present.SpcDc   := vSpcDc;
    Common.Present.TotalDC := vTotDc;
    InitCardRecord(Common.Card);
    InitCashRcpRecord(Common.CashRcp);        //현금영수증초기화
    Common.HideWaitForm;
    Close;

    Common.ClearKitchenData;
  end
  else //테이블제일때
  begin
    if Common.WorkDate <> DtoS(SaleDatePicker.Date) then
    begin
      Common.ErrBox('이전일자는 판매전환 할 수 없습니다');
      Exit;
    end;

    if (GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDsSale.Index] <> '취소') and
       (GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDsSale.Index] <> '반품') then
    begin
      Common.ErrBox( '취소 된 영수증에 대해서만'#13'사용 할 수 있습니다');
      Exit;
    end;

    if GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewTableName.Index] = '배달' then
    begin
      Common.ErrBox('배달영수증에는 사용 할 수 있습니다');
      Exit;
    end;

    OpenQuery('select Count(*) '
             +'  from SL_ORDER_H '
             +' where CD_STORE =:P0 '
             +'   and DS_ORDER =''T'' '
             +'   and NO_TABLE =:P1 ',
             [Common.Config.StoreCode,
              GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewTableNo.Index]]);
    if Common.Query.Fields[0].AsInteger = 1 then
    begin
      Common.ErrBox(Format('%s 테이블이 사용중 이어서'#13#13'판매전환을 할 수 없습니다',[GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewTableName.Index]]));
      Exit;
    end;

    OpenQuery('select Count(*) '
             +'  from SL_SALE_H '
             +' where CD_STORE =:P0 '
             +'   and YMD_SALE =:P1 '
             +'   and NO_POS   =:P2 '
             +'   and NO_TABLE =:P3 '
             +'   and NO_RCP   >:P4 ',
             [Common.Config.StoreCode,
              Common.WorkDate,
              Common.Config.PosNo,
              GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewTableNo.Index],
              GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index]]);
    if Common.Query.Fields[0].AsInteger > 0 then
    begin
      Common.ErrBox('이후에 계산한 내역이 있어서'#13#13'판매전환을 할 수 없습니다');
      Exit;
    end;

    OpenQuery('select Count(*) '
             +'  from SL_ORDER_D '
             +' where CD_STORE =:P0 '
             +'   and DS_ORDER =''T'' '
             +'   and NO_TABLE =:P1 ',
             ['9999',
              GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewTableNo.Index]]);
    if Common.Query.Fields[0].AsInteger = 0 then
    begin
      Common.ErrBox(Format('%s 테이블을 주문하지 않고 계산을 해서'#13#13'판매전환을 할 수 없습니다',[GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewTableName.Index]]));
      Exit;
    end;

    try
      Common.BeginTran;
      ExecQuery('update SL_ORDER_H '
               +'   set CD_STORE =:P0 '
               +' where CD_STORE = ''9999'' '
               +'   and DS_ORDER = ''T'' '
               +'   and NO_TABLE = :P1 ',
               [Common.Config.StoreCode,
                GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewTableNo.Index]]);

      ExecQuery('update SL_ORDER_D '
               +'   set CD_STORE =:P0 '
               +' where CD_STORE = ''9999'' '
               +'   and DS_ORDER = ''T'' '
               +'   and NO_TABLE = :P1 ',
               [Common.Config.StoreCode,
                GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewTableNo.Index]]);

      ExecQuery('update SL_ORDER_C '
               +'   set CD_STORE =:P0 '
               +' where CD_STORE = ''9999'' '
               +'   and DS_ORDER = ''T'' '
               +'   and NO_TABLE = :P1 ',
               [Common.Config.StoreCode,
                GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewTableNo.Index]]);

      ExecQuery('update SL_ORDER_PRT '
               +'   set CD_STORE =:P0 '
               +' where CD_STORE = ''9999'' '
               +'   and DS_ORDER = ''T'' '
               +'   and NO_TABLE = :P1 ',
               [Common.Config.StoreCode,
                GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewTableNo.Index]]);
      Common.CommitTran;
      Common.MsgBox(Format('판매전환 완료'#13'%s 테이블이 주문상태로 전환되었습니다',[GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewTableName.Index]]));
    except
      on E: Exception do
      begin
        Common.RollbackTran;
        Common.ErrBox(E.Message);
      end;
    end;
  end;
end;

procedure TRcpChange_F.PrintLogButtonClick(Sender: TObject);
begin
  if (Sender <> nil) and PrintLogPanel.Visible then
  begin
    PrintLogPanel.Visible := false;
    Exit;
  end;
  PrintLogPanel.Visible := true;
  PrintLogPanel.Top     := cxGrid2.Top;
  PrintLogPanel.Left    := cxGrid2.Left-6;
  OpenQuery('select ORDER_TIME, '
           +'       PRINT_DATA, '
           +'       GetTableName(:P0,NO_TABLE), '
           +'       NO_ORDER '
           +'  from SL_SALE_PRT '
           +' where CD_STORE  =:P0 '
           +'   and YMD_SALE  =:P1 '
           +'   and NO_POS    =:P2 '
           +'   and NO_RCP    =:P3 '
           +'   and CD_PRINTER =''000'' '
           +' order by ORDER_TIME ',
           [Common.Config.StoreCode,
            FWorkDate,
            Common.Config.PosNo,
            GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewRcpNo.Index]]);
  PrintLogPanel.Text := '';
  while not Common.Query.Eof do
  begin
    PrintLogPanel.Text := PrintLogPanel.Text
                        + Format('<FONT face="맑은 고딕" size="14"> <B>%s [%s:%s] 테이블-%s 주문번호-%d </B></FONT>',
                               ['주문시간',
                                Copy(Common.Query.Fields[0].AsString,9,2),
                                Copy(Common.Query.Fields[0].AsString,11,2),
                                Common.Query.Fields[2].AsString,
                                Common.Query.Fields[3].AsInteger])+#13
                        + Format('<FONT face="굴림체" size="14">%s </FONT>',[Replace(Common.Query.Fields[1].AsString,#$D#$D,#$D)])+#13;
    Common.Query.Next;
  end;
  Common.Query.Close;
end;

procedure TRcpChange_F.MenuGridPrevButtonClick(Sender: TObject);
begin
  if Sender = MenuGridPrevButton then gvDetail.DataController.GotoPrev
  else if Sender = MenuGridNextButton  then gvDetail.DataController.GotoNext;
end;

procedure TRcpChange_F.MenuPrintOnButtonClick(Sender: TObject);
begin
  if Sender = MenuPrintOnButton then
  begin
    Common.MenuPrintMode := true;
    MenuPrintOnButton.Status.Caption   := 'V';
    MenuPrintOffButton.Status.Caption  := '';
  end
  else if Sender = MenuPrintOffButton then
  begin
    Common.MenuPrintMode := false;
    MenuPrintOnButton.Status.Caption   := '';
    MenuPrintOffButton.Status.Caption  := 'V';
  end;

  if Sender = nil then
  begin
    if Common.MenuPrintMode then
    begin
      Common.MenuPrintMode := true;
      MenuPrintOnButton.Status.Caption   := 'V';
      MenuPrintOffButton.Status.Caption  := '';
    end
    else
    begin
      Common.MenuPrintMode := false;
      MenuPrintOnButton.Status.Caption   := '';
      MenuPrintOffButton.Status.Caption  := 'V';
    end;
  end;
  PrintOptionPanel.Visible := false;
end;

procedure TRcpChange_F.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Common.Table := FOrgTable;
  Common.Config.Options[10] := Option10;
end;

procedure TRcpChange_F.Action11Execute(Sender: TObject);
var vIndex :Integer;
    vLeft, vTop :Integer;
label Loop;
begin
  if PosPanel.Visible then
  begin
    PosPanel.Visible := false;
    Exit;
  end;

  OpenQuery('select 1 as SEQ, '
           +'       NM_CODE1 '
           +'  from MS_CODE '
           +' where CD_STORE =:P0 '
           +'   and CD_KIND  =''01'' '
           +'   and NM_CODE1 =:P1 '
           +'union all '
           +'select 2, '
           +'       NM_CODE1 '
           +'  from MS_CODE '
           +' where CD_STORE =:P0 '
           +'   and CD_KIND  =''01'' '
           +'   and NM_CODE1 <> :P1 '
           +'   and NM_CODE3 = ''2'' '
           +'union all '
           +'select 3, '
           +'       NM_CODE1 '
           +'  from MS_CODE '
           +' where CD_STORE =:P0 '
           +'   and CD_KIND  =''01'' '
           +'   and NM_CODE1 <> :P1 '
           +'   and NM_CODE3 = ''7'' '
           +' order by 1 ',
           [Common.Config.StoreCode,
            Common.Config.OriginalPosNo]);

  Loop:
    for vIndex := 0 to PosPanel.ControlCount-1 do
      if PosPanel.Controls[vIndex] is TAdvGlassButton then
      begin
        (PosPanel.Controls[vIndex] as TAdvGlassButton).Free;
        Goto Loop;
      end;

  vTop   := 60;
  vLeft  := 64;
  vIndex := 0;
  PosPanel.Width := 305;

  while not Common.Query.Eof do
  begin
    if vTop > 500 then
    begin
      Inc(vIndex);
      vTop  := 60;
      vLeft := (64 + 200) + ((vIndex-1)*200);
      PosPanel.Width := PosPanel.Width + 200;
    end;

    with TAdvGlassButton.Create(Self) do
    begin
      Parent    := PosPanel;
      Top       := vTop;
      Left      := vLeft;
      Height    := 60;
      Width     := 180;
      Font.Name := '맑은 고딕';
      Font.Size := 13;
      Font.Color := clWhite;
      BackColor  := $00592D00;
      ShineColor := $00592D00;
      OnClick   := PosButtonClick;
      if Common.Config.OriginalPosNo = Common.Query.Fields[1].AsString then
        Caption   := Format('%s - [내포스]',[Common.Query.Fields[1].AsString])
      else if Common.Query.Fields[0].AsString = '2' then
        Caption   := Format('%s - 키오스크',[Common.Query.Fields[1].AsString])
      else if Common.Query.Fields[0].AsString = '3' then
        Caption   := Format('%s - 레츠오더',[Common.Query.Fields[1].AsString]);
      Hint      := Common.Query.Fields[1].AsString;
      Tag       := Common.Query.Fields[0].AsInteger;
      vTop    := vTop + 65;
    end;
    Common.Query.Next;
  end;
  Common.Query.Close;
  PosPanel.Height := vTop+5 ;
  if PosPanel.Height < 350 then
    PosPanel.Height := 350;

  PosPanel.Top  := (Self.Height - PosPanel.Height) div 2;
  PosPanel.Left := (Self.Width  - PosPanel.Width ) div 2;
  PosPanel.Visible := true;
  PosPanel.BringToFront;
end;

procedure TRcpChange_F.Show_TimerTimer(Sender: TObject);
begin
  Show_Timer.Enabled := false;

  FOrgTable := Common.Table;
  InitTableRecord(Common.Table);

  if not Common.Config.IsKiosk then
  begin
    if GetOption(54) = '1' then
      Grid.Height := 648;
  end;
  if Common.WorkDate <> EmptyStr then
    SaleDatePicker.Date := StoD(Common.WorkDate)
  else
    SaleDatePicker.Date := Now();
  FWorkDate := DtoS(SaleDatePicker.Date);

  Common.CustomerPrinter := EmptyStr;

  BanpumButton.Enabled := False;
  if GetOption(359) = '0' then
    SelectReceipt(0);
  Common.MenuPrintMode := GetOption(68) = '0';
  if not Common.Config.IsKiosk then
    cxGrid2.Height := 453;
  gvBanpum.DataController.RecordCount := 0;
  cxGrid3.Visible                     := False;

  MenuPrintOnButtonClick(nil);
  KitchenReceiptOnButtonClick(nil);
  CardPrintSplitOffButtonClick(nil);

  Common.Device.OnScannerReadData := ScannerReadEvent;

  //기본을 렛츠오더 포스로 사용할때
  if GetOption(359) = '1' then
  begin
    OpenQuery('select NM_CODE1 '
             +'  from MS_CODE '
             +' where CD_STORE =:P0 '
             +'   and CD_KIND  =''01'' '
             +'   and NM_CODE3 = ''7'' '
             +' order by 1 ',
             [Common.Config.StoreCode]);

    if not Common.Query.Eof then
    begin
      Common.Config.PosNo := Common.Query.Fields[0].AsString;
      Common.Query.Close;
      ChangePosLetsOrder  := true;
      isPosChange         := true;
      SelectReceipt(0);
    end;
  end;
  isShowing := false;
end;

procedure TRcpChange_F.FormActivate(Sender: TObject);
begin
  BlockInput(false);
  Common.ShowNormalDualScreen;
end;

procedure TRcpChange_F.PosButtonClick(Sender: TObject);
begin
  Common.Config.PosNo := (Sender as TAdvGlassButton).Hint;
  PosPanel.Visible    := false;
  //Tag = 1 내포스

  ChangePosKiosk      := (Sender as TAdvGlassButton).Tag = 2;
  ChangePosLetsOrder  := (Sender as TAdvGlassButton).Tag = 3;
  isPosChange         := true;
  FullSearchButtonClick(FullSearchButton);
  Grid.SetFocus;
end;

procedure TRcpChange_F.PrintOptionButtonClick(Sender: TObject);
begin
  PrintOptionPanel.Top  := (Self.Height - PrintOptionPanel.Height) div 2;
  PrintOptionPanel.Left := (Self.Width - PrintOptionPanel.Width) div 2;
  PrintOptionPanel.Visible := not PrintOptionPanel.Visible;
  PrintOptionPanel.BringToFront;
end;

procedure TRcpChange_F.BanpumButtonClick(Sender: TObject);
  function GetRowIndex(aMenuCode:String):Integer;
  var nRow :Integer;
  begin
    Result := -1;
    For nRow := 0 to gvBanpum.DataController.RowCount-1 do
    begin
      if gvBanpum.DataController.Values[nRow, 5] = aMenuCode then
      begin
        if gvDetail.DataController.Values[gvDetail.DataController.FocusedRecordIndex, 1] = gvBanpum.DataController.Values[nRow, 1] then
        begin
          Common.ErrBox('반품 할 수량이 없습니다');
          Result := -2;
        end
        else Result := nRow;
        Break;
      end;
    end;
  end;
var vIndex :Integer;
begin
  if PosPanel.Visible then Exit;
  if gvDetail.DataController.FocusedRecordIndex = -1 then Exit;
  if gvDetail.DataController.RecordCount = 0 then Exit;

  if gvDetail.DataController.Values[gvDetail.DataController.FocusedRecordIndex, 4] <> 'N' then
  begin
    Common.ErrBox('일반 메뉴만 반품이 가능합니다');
    Exit;
  end;

  if gvDetail.DataController.Values[gvDetail.DataController.FocusedRecordIndex, 6] = 'D' then
  begin
    Common.ErrBox('서비스메뉴는 반품할 수 없습니다');
    Exit;
  end;

  if not Common.Config.IsKiosk then
    cxGrid2.Height  := 290;
  cxGrid3.Visible := True;

  vIndex := GetRowIndex(gvDetail.DataController.Values[gvDetail.DataController.FocusedRecordIndex, 5]);

  if vIndex = -2 then Exit;

  if vIndex = -1 then
  begin
    gvBanpum.DataController.AppendRecord;
    gvBanpum.DataController.Values[gvBanpum.DataController.RecordCount-1, 0] := gvDetail.DataController.Values[gvDetail.DataController.FocusedRecordIndex, 0];
    gvBanpum.DataController.Values[gvBanpum.DataController.RecordCount-1, 1] := 1;
    gvBanpum.DataController.Values[gvBanpum.DataController.RecordCount-1, 2] := gvDetail.DataController.Values[gvDetail.DataController.FocusedRecordIndex, 2];
    gvBanpum.DataController.Values[gvBanpum.DataController.RecordCount-1, 3] := gvDetail.DataController.Values[gvDetail.DataController.FocusedRecordIndex, 2];
    gvBanpum.DataController.Values[gvBanpum.DataController.RecordCount-1, 4] := gvDetail.DataController.Values[gvDetail.DataController.FocusedRecordIndex, 4];
    gvBanpum.DataController.Values[gvBanpum.DataController.RecordCount-1, 5] := gvDetail.DataController.Values[gvDetail.DataController.FocusedRecordIndex, 5];
    gvBanpum.DataController.Values[gvBanpum.DataController.RecordCount-1, 6] := gvDetail.DataController.Values[gvDetail.DataController.FocusedRecordIndex, 6];

    gvBanpum.Controller.FocusedRowIndex := gvBanpum.DataController.RecordCount-1;
  end
  else
  begin
    gvBanpum.DataController.Values[vIndex, 1] := gvBanpum.DataController.Values[vIndex, 1] + 1;
    gvBanpum.DataController.Values[vIndex, 3] := gvBanpum.DataController.Values[vIndex, 1] * gvBanpum.DataController.Values[vIndex, 2];

    gvBanpum.Controller.FocusedRowIndex := vIndex;
  end;
end;

end.



