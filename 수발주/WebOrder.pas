unit WebOrder;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxButtonEdit, cxTextEdit, Vcl.StdCtrls, AdvGroupBox, cxLabel, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxCurrencyEdit, cxMemo, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator, cxClasses, AdvSmoothButton,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridCustomView, cxGrid,
  Vcl.Menus, Vcl.ExtCtrls, AdvPanel, cxButtons, DateUtils, Math, StrUtils;

type
  TcxGridDataControllerAccess = class (TcxGridDataController);

type
  TcxGridSiteAccess = class (TcxGridSite);
  TcxControlScrollBarsAccess = class (TcxControlScrollBars);

type
  TWebOrder_F = class(TForm)
    Grid: TcxGrid;
    GridTableView: TcxGridTableView;
    GridTableViewGoodsCode: TcxGridColumn;
    GridTableViewGoodsName: TcxGridColumn;
    GridTableViewOrderUnit: TcxGridColumn;
    GridTableViewNepumQty: TcxGridColumn;
    GridTableViewOrderQty: TcxGridColumn;
    GridTableViewOrderPrice: TcxGridColumn;
    GridTableViewOrderNetAmt: TcxGridColumn;
    GridTableViewOrderNotAmt: TcxGridColumn;
    GridTableViewOrderVatAmt: TcxGridColumn;
    GridTableViewOrderAmt: TcxGridColumn;
    GridTableViewDsTax: TcxGridColumn;
    GridTableViewSeq: TcxGridColumn;
    GridTableViewRowState: TcxGridColumn;
    GridLevel: TcxGridLevel;
    SaveButton: TAdvSmoothButton;
    MenuAddButton: TAdvSmoothButton;
    MenuDeleteButton: TAdvSmoothButton;
    CaptionLabel: TLabel;
    CloseButton: TcxButton;
    PosPanel: TAdvPanel;
    CommentLabel: TLabel;
    BuyAmtLabel: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RemarkMemo: TcxMemo;
    OrderTotalAmtEdit: TcxCurrencyEdit;
    cxLabel1: TcxLabel;
    CreditAmtEdit: TcxCurrencyEdit;
    RemainAmtEdit: TcxCurrencyEdit;
    RestCreditAmtEdit: TcxCurrencyEdit;
    StyleRepository: TcxStyleRepository;
    cxStyle41: TcxStyle;
    StyleHeader: TcxStyle;
    StyleFooter: TcxStyle;
    StyleLevel: TcxStyle;
    OrderDateEdit: TcxDateEdit;
    cxLabel2: TcxLabel;
    RequestDateEdit: TcxDateEdit;
    Label4: TLabel;
    cxCurrencyEdit1: TcxCurrencyEdit;
    procedure GridTableViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OrderDateEditPropertiesCloseUp(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuAddButtonClick(Sender: TObject);
    procedure MenuDeleteButtonClick(Sender: TObject);
    procedure GridTableViewDataControllerAfterPost(
      ADataController: TcxCustomDataController);
    procedure GridTableViewOrderQtyPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure SaveButtonClick(Sender: TObject);
  private
    OrderLimitCode :String;
    isChanged      :Boolean;
    OrderNo        :String;
    procedure DoSearch;
    procedure SetRemainAmt;
    procedure CalcAmts(aAllRows: Boolean);
  public
    { Public declarations }
  end;

var
  WebOrder_F: TWebOrder_F;

const rsNormal = 'rsNormal';
      rsDelete = 'rsDelete';
      rsInsert = 'rsInsert';
      rsUpdate = 'rsUpdate';

implementation
uses Common_U, DBModule_U, GlobalFunc_U, Const_U, WebOrderMenu;

{$R *.dfm}

procedure TWebOrder_F.FormCreate(Sender: TObject);
var vGridSite: TcxGridSiteAccess;
    vScrollBar: TcxControlScrollBarHelper;
    vPos :Integer;
begin
  ClientWidth   := Common.Config.PosWidth;
  ClientHeight  := Common.Config.PosHeight;
  Common.LogoCreate(Self,1);
  OrderDateEdit.Date := Now();
  OrderDateEdit.Date := Now();

  GridTableViewRowState.DataBinding.AddToFilter(nil, foNotEqual, rsDelete);
  GridTableView.DataController.Filter.Active := true;

  vGridSite := TcxGridSiteAccess(GridTableView.Site);
  vScrollBar := TcxControlScrollBarsAccess(vGridSite.MainScrollBars).HScrollBar;
  vPos := vScrollBar.Min;
  GridTableView.Controller.Scroll(sbHorizontal, Vcl.StdCtrls.scTrack, vPos);

end;

procedure TWebOrder_F.FormShow(Sender: TObject);
begin
  SetRemainAmt;
end;

procedure TWebOrder_F.CalcAmts(aAllRows: Boolean);
  function RoundNumber(aNumber: Currency; aUnit: Currency): Currency;
  begin
    // 델파이에서 Banker's Round 계산법을 사용해서 새로 만듦
  //Result := Round(aNumber/aUnit)*aUnit;
    if aNumber = 0 then
      Result := 0
    else if aNumber > 0 then
      Result := Trunc(aNumber/aUnit+0.5)*aUnit
    else
      Result := Trunc(aNumber/aUnit-0.5)*aUnit
  end;
var
  vIndex     : Integer;
  vOrderQty    : Currency;
  vApplyAmt  : Currency;
  vReceiptDc : Currency;
begin
  try
    GridTableView.BeginUpdate;
    OrderTotalAmtEdit.Value := 0;

    for vIndex := 0 to GridTableView.DataController.RecordCount-1 do
    begin
      vOrderQty := Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderQty.Index], 0.0);
//      GridTableView.DataController.Values[vIndex, GridTableViewOrderAmt.Index]  := RoundNumber(GridTableView.DataController.Values[vIndex, GridTableViewOrderPrice.Index] * vOrderQty);

      // 면세금액
      GridTableView.DataController.Values[vIndex, GridTableViewOrderNotAmt.Index]         := IfThen(GridTableView.DataController.Values[vIndex, GridTableViewDsTax.Index] = '1', 0, Currency(GridTableView.DataController.Values[vIndex, GridTableViewOrderAmt.Index]));

      // 부가세를 먼저 계산한다
      if GridTableView.DataController.Values[vIndex, GridTableViewDsTax.Index] = '1' then
      begin
        //부가세(매입금액-공병금액 / 11)
        GridTableView.DataController.Values[vIndex, GridTableViewOrderVatAmt.Index]         := Trunc((GridTableView.DataController.Values[vIndex, GridTableViewOrderAmt.Index]) / 11);
        GridTableView.DataController.Values[vIndex, GridTableViewOrderNetAmt.Index]         := GridTableView.DataController.Values[vIndex, GridTableViewOrderAmt.Index] - GridTableView.DataController.Values[vIndex, GridTableViewOrderVatAmt.Index];
      end
      else
      begin
        GridTableView.DataController.Values[vIndex, GridTableViewOrderVatAmt.Index]         := 0;
        GridTableView.DataController.Values[vIndex, GridTableViewOrderNetAmt.Index]         := GridTableView.DataController.Values[vIndex, GridTableViewOrderAmt.Index] - GridTableView.DataController.Values[vIndex, GridTableViewOrderVatAmt.Index];
      end;
      OrderTotalAmtEdit.Value := OrderTotalAmtEdit.Value + GridTableView.DataController.Values[vIndex, GridTableViewOrderAmt.Index];
    end;
  finally
    GridTableView.EndUpdate;
  end;
end;

procedure TWebOrder_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TWebOrder_F.GridTableViewDataControllerAfterPost(
  ADataController: TcxCustomDataController);
begin
  CalcAmts(True);
end;

procedure TWebOrder_F.GridTableViewFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  MenuDeleteButton.Enabled                     := AFocusedRecord <> nil;
end;

procedure TWebOrder_F.GridTableViewOrderQtyPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewOrderQty.Index] := DisplayValue;
  // 금액 재계산
  CalcAmts(true);
  GridTableView.DataController.Post;
end;

procedure TWebOrder_F.MenuAddButtonClick(Sender: TObject);
var
  vIndex: Integer;
begin
  with TWebOrderMenuForm.Create(Self) do
    try
      if Self.Tag = 0 then
        OrderLimitCode := Self.OrderLimitCode
      else
        OrderLimitCode := '';
      if ShowModal = mrOK then
      begin
        try
          Self.GridTableView.DataController.BeginFullUpdate;
          for vIndex := 0 to AddGridTableView.DataController.RecordCount-1 do
          begin
            // 그리드에 이미 등록되어 있는 상품코드면 무시하고 넘어간다
            if Self.GridTableView.DataController.FindRecordIndexByText(0, Self.GridTableViewGoodsCode.Index, AddGridTableView.DataController.Values[vIndex, AddGridTableViewGoodsCode.Index], false, false, true) >= 0 then
              Continue;
            // 매입 수량이 없으면 다음으로 넘어간다
            if Nvl(AddGridTableView.DataController.Values[vIndex, AddGridTableViewOrderQty.Index], 0) = 0 then
              Continue;

            try
              Self.GridTableView.DataController.AppendRecord;
              Self.GridTableView.DataController.Values[Self.GridTableView.DataController.RecordCount-1, Self.GridTableViewGoodsCode.Index]         := AddGridTableView.DataController.Values[vIndex, AddGridTableViewGoodsCode.Index];
              Self.GridTableView.DataController.Values[Self.GridTableView.DataController.RecordCount-1, Self.GridTableViewGoodsName.Index]         := AddGridTableView.DataController.Values[vIndex, AddGridTableViewGoodsName.Index];
              Self.GridTableView.DataController.Values[Self.GridTableView.DataController.RecordCount-1, Self.GridTableViewOrderUnit.Index]         := AddGridTableView.DataController.Values[vIndex, AddGridTableViewOrderUnit.Index];
              Self.GridTableView.DataController.Values[Self.GridTableView.DataController.RecordCount-1, Self.GridTableViewNepumQty.Index]          := AddGridTableView.DataController.Values[vIndex, AddGridTableViewNepumQty.Index];
              Self.GridTableView.DataController.Values[Self.GridTableView.DataController.RecordCount-1, Self.GridTableViewOrderPrice.Index]        := AddGridTableView.DataController.Values[vIndex, AddGridTableViewOrderPrice.Index];
              Self.GridTableView.DataController.Values[Self.GridTableView.DataController.RecordCount-1, Self.GridTableViewOrderQty.Index]          := AddGridTableView.DataController.Values[vIndex, AddGridTableViewOrderQty.Index];
              Self.GridTableView.DataController.Values[Self.GridTableView.DataController.RecordCount-1, Self.GridTableViewOrderAmt.Index]          := 0;
              Self.GridTableView.DataController.Values[Self.GridTableView.DataController.RecordCount-1, Self.GridTableViewOrderNetAmt.Index]       := 0;
              Self.GridTableView.DataController.Values[Self.GridTableView.DataController.RecordCount-1, Self.GridTableViewOrderNotAmt.Index]       := 0;
              Self.GridTableView.DataController.Values[Self.GridTableView.DataController.RecordCount-1, Self.GridTableViewOrderVatAmt.Index]       := 0;
              Self.GridTableView.DataController.Values[Self.GridTableView.DataController.RecordCount-1, Self.GridTableViewDsTax.Index]             := AddGridTableView.DataController.Values[vIndex, AddGridTableViewDsTax.Index];
              Self.GridTableView.DataController.Values[Self.GridTableView.DataController.RecordCount-1, Self.GridTableViewRowState.Index]          := rsInsert;
              isChanged := true;
            finally
            end;
          end;
        finally
          Self.GridTableView.DataController.EndFullUpdate;
          Self.Grid.SetFocus;
        end;
      end
      else
        Exit;
    finally
      Free;
    end;
  // 각 금액 계산

  CalcAmts(true);
end;

procedure TWebOrder_F.MenuDeleteButtonClick(Sender: TObject);
var vRowIndex :Integer;
    vIndex    :Integer;
begin
  inherited;
  if GridTableView.Controller.IsNewItemRowFocused then
  begin
    GridTableView.DataController.Cancel;
    isChanged := true;
  end
  else if (GridTableView.DataController.RecordCount > 0) and (GridTableView.DataController.FocusedRecordIndex >= 0) then
  begin
    // 선택한 레코드를 삭제한다
    //신규로 입력한 레코드는 삭제한다
    if GridTableView.DataController.Values[GridTableView.Controller.FocusedRecordIndex, GridTableViewRowState.Index] = rsInsert then
      GridTableView.DataController.DeleteFocused
    else
    begin
      //불로온 레코드는 마지막레코드로 옮기고 State만 변경한다
      vRowIndex := GridTableView.Controller.FocusedRecordIndex;
      GridTableView.DataController.Values[GridTableView.Controller.FocusedRecordIndex, GridTableViewRowState.Index] := rsDelete;
      GridTableView.DataController.AppendRecord;
      for vIndex := 0 to GridTableView.ColumnCount-1 do
        GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, vIndex] := GridTableView.DataController.Values[vRowIndex, vIndex];
      GridTableView.DataController.DeleteRecord(vRowIndex);
    end;
    CalcAmts(True);
    isChanged := true;
  end;
end;

procedure TWebOrder_F.OrderDateEditPropertiesCloseUp(Sender: TObject);
begin
  if FormatDateTime(fmtDateShort, OrderDateEdit.Date) < FormatDateTime(fmtDateShort, Now()) then
  begin
    Common.MsgBox('오늘보다 이전일자로는 발주 할 수 없습니다');
    OrderDateEdit.Date := Now();
  end;
end;

procedure TWebOrder_F.SaveButtonClick(Sender: TObject);
var vExist :Boolean;
    vSeq, vIndex, vCount :Integer;
    vPrice, vNet, vNot, vVat, vSum, vBuyPrice: Currency;
    vOrderNo, vSQL :String;
begin
  if RequestDateEdit.Date < Date then
  begin
    Common.MsgBox('출고요청일이 오늘보다 이전 일수 없습니다');
    if RequestDateEdit.Enabled then
      RequestDateEdit.SetFocus;
    Exit;
  end;

  // 입력 중이던 자료 포스트
  GridTableView.DataController.Post;
  // 목록을 뒤져서 매입 수량이 모두 입력 되었는지 확인한다
  if GridTableView.DataController.RecordCount = 0 then
    vExist := false
  else
  begin
    vExist := true;
    for vIndex := 0 to GridTableView.DataController.RecordCount-1 do
      if (Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderQty.Index],    0.0)        = 0) then
      begin
        vExist := false;
        break;
      end;
  end;
  if not vExist then
  begin
    Common.ErrBox('발주 수량을 입력하지 않은 레코드가 있습니다.');
    Exit;
  end;

  CalcAmts(True);

  SetRemainAmt;
  if RestCreditAmtEdit.Value < OrderTotalAmtEdit.Value then
  begin
    if Tag = 0 then
    begin
      Common.MsgBox('여신한도를 초과합니다');
      Exit;
    end;

    if (Tag = 1) and not Common.AskBox('여신한도를 초과합니다'#13'저장하시겠습니까?') then Exit;
  end;



    // 발주 저장
  try
    vSeq    := 0;
    DM.OpenCloud('select   Max(NO_ORDER) as NO_ORDER, '
                +'         Now() '
                +'from     OL_ORDER_H '
                +'where    CD_HEAD   = :P0 '
                +'  and    YMD_ORDER = :P1',
                 [Common.Config.HeadStoreCode,
                  DtoS(OrderDateEdit.Date)],Common.RestDBURL);
    try
      // 신규매입일때는 매입번호, 입력일시를 알아낸다
      if (OrderNo = EmptyStr) then
        vOrderNo     := FormatFloat('0000', StoI(DM.CloudData.Fields[0].AsString)+1);
    finally
      DM.CloudData.Close;
    end;

    if (OrderNo <> EmptyStr) then
    begin
      vOrderNo := LPad(OrderNo, 4, '0');
      OpenQuery('select   Max(SEQ) as SEQ '
               +'  from   OL_ORDER_D '
               +' where   CD_HEAD    = :P0 '
               +'   and   YMD_ORDER  = :P1 '
               +'   and   NO_ORDER   = :P2 ',
                [Common.Config.HeadStoreCode,
                 DtoS(OrderDateEdit.Date),
                 vOrderNo]);
      try
        // 신규매입일때는 매입번호, 입력일시를 알아낸다
        if not DM.CloudData.Eof then
          vSeq     := DM.CloudData.Fields[0].AsInteger
        else
          vSeq       := 0;
      finally
        DM.CloudData.Close;
      end;
    end;


    // 디테일을 저장한다
    vNet    := 0;
    vNot    := 0;
    vVat    := 0;
    vSum    := 0;
    vCount  := 0;
    GridTableView.DataController.PostEditingData;

    //매입마스터 저장
    for vIndex := 0 to GridTableView.DataController.RecordCount-1 do
    begin
      if GridTableView.DataController.Values[vIndex, GridTableViewRowState.Index] = rsNormal then
      begin
        vNet    := vNet    +(Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderNetAmt.Index],    0.0) - Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderNotAmt.Index], 0.0));
        vNot    := vNot    + Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderNotAmt.Index],    0.0);
        vVat    := vVat    + Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderVatAmt.Index],    0.0);
        vSum    := vSum    + Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderAmt.Index],       0.0);
        Inc(vCount);
        Continue;
      end;

      if GridTableView.DataController.Values[vIndex, GridTableViewRowState.Index] = rsDelete then Continue;

      vNet    := vNet    +(Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderNetAmt.Index],    0.0) - Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderNotAmt.Index], 0.0));
      vNot    := vNot    + Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderNotAmt.Index],    0.0);
      vVat    := vVat    + Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderVatAmt.Index],    0.0);
      vSum    := vSum    + Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderAmt.Index],       0.0);
      Inc(vCount);
    end;

    //발주상품이 없으면 발주서를 삭제한다
    if (vCount = 0) and (OrderNo <> EmptyStr) then
    begin
      if not Common.AskBox('발주서를 삭제하시겠습니까?') then Exit;

      DM.ExecCloud('delete from OL_ORDER_D '
               +' where CD_HEAD   =:P0 '
               +'   and YMD_ORDER =:P1 '
               +'   and NO_ORDER  =:P2;',
                [Common.Config.HeadStoreCode,
                 DtoS(OrderDateEdit.Date),
                 OrderNo],
                 false,Common.RestDBURL);

      // 매입 마스터 테이블을 삭제한다
      DM.ExecCloud('delete from OL_ORDER_H '
               +' where CD_HEAD    = :P0 '
               +'   and YMD_ORDER  = :P1 '
               +'   and NO_ORDER   = :P2;',
                [Common.Config.HeadStoreCode,
                 DtoS(OrderDateEdit.Date),
                 OrderNo],
                 true,Common.RestDBURL);
    end
    else
    begin
      // 마스터를 저장한다
      DM.ExecCloud('insert into OL_ORDER_H(CD_HEAD, '
               +'                       YMD_ORDER, '
               +'                       NO_ORDER, '
               +'                       DS_ORDER, '
               +'                       CD_STORE, '
               +'                       YMD_REQUEST, '
               +'                       AMT_DUTY, '
               +'                       AMT_TAX, '
               +'                       AMT_DUTYFREE, '
               +'                       AMT_ORDER, '
               +'                       ORDER_REMARK, '
               +'                       DS_STATUS, '
               +'                       CD_SAWON_INSERT, '
               +'                       AMT_LOAN_LIMIT, '
               +'                       DT_INSERT, '
               +'                       DT_CHANGE) '
               +'              Values (:P0, '
               +'                      :P1, '
               +'                      :P2, '
               +'                      :P3, '
               +'                      :P4, '
               +'                      :P5, '
               +'                      :P6, '
               +'                      :P7, '
               +'                      :P8, '
               +'                      :P6+:P7+:P8, '
               +'                      :P9, '
               +'                      :P10, '
               +'                      :P11, '
               +'                      :P12, '
               +'                      Now(), '
               +'                      Now()) '
               +'ON DUPLICATE KEY UPDATE YMD_REQUEST    =:P5, '
               +'                        AMT_DUTY       =:P6, '
               +'                        AMT_TAX        =:P7, '
               +'                        AMT_DUTYFREE   =:P8, '
               +'                        AMT_ORDER      =:P6+:P7+:P8, '
               +'                        ORDER_REMARK   =:P9, '
               +'                        CD_SAWON_CHG   =:P11, '
               +'                        DT_CHANGE      =Now();',
                [Common.Config.HeadStoreCode,
                 DtoS(OrderDateEdit.Date),
                 vOrderNo,
                 Ifthen(Tag=0,'S','H'),
                 Common.Config.StoreCode,
                 DtoS(RequestDateEdit.Date),
                 vNet,
                 vVat,
                 vNot,
                 RemarkMemo.Text,
                 Ifthen(Tag=0,'O','C'),
                 'POS',
                 RestCreditAmtEdit.Value],
                 false,Common.RestDBURL);

      vSQL := '';
      for vIndex := 0 to GridTableView.DataController.RecordCount-1 do
      begin
        vBuyPrice := Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderPrice.Index], 0.0);

        if GridTableView.DataController.Values[vIndex, GridTableViewRowState.Index] = rsNormal then Continue;

        if GridTableView.DataController.Values[vIndex, GridTableViewRowState.Index] = rsDelete then
        begin
          DM.ExecCloud('delete from OL_ORDER_D '
                   +' where CD_HEAD    = :P0 '
                   +'   and YMD_ORDER  = :P1 '
                   +'   and NO_ORDER   = :P2 '
                   +'   and SEQ        = :P3;',
                  [Common.Config.HeadStoreCode,
                   DtoS(OrderDateEdit.Date),
                   vOrderNo,
                   GridTableView.DataController.Values[vIndex, GridTableViewSeq.Index]],
                   false,Common.RestDBURL);
        end
        else
        begin
          if GridTableView.DataController.Values[vIndex, GridTableViewRowState.Index] = rsInsert then
          begin
            Inc(vSeq);
            vSQL := vSQL + Format('(''%s'', ''%s'', ''%s'', %s,''%s'',''%s'', %s, %s, %s, %s, %s, %s,''%s'',%s, ''%s'',''%s''),',
                                  [Common.Config.HeadStoreCode,
                                   DtoS(OrderDateEdit.Date),
                                   vOrderNo,
                                   IntToStr(vSeq),
                                   Common.Config.StoreCode,
                                   GridTableView.DataController.Values[vIndex, GridTableViewGoodsCode.Index],
                                   FloatToStr(vBuyPrice),
                                   FloatToStr(Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderQty.Index],    0.0)),
                                   FloatToStr(Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderNetAmt.Index], 0.0) - Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderNotAmt.Index], 0.0)),
                                   FloatToStr(Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderVatAmt.Index], 0.0)),
                                   FloatToStr(Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderNotAmt.Index], 0.0)),
                                   FloatToStr(Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderNetAmt.Index], 0.0)+Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderVatAmt.Index], 0.0)),
                                   GridTableView.DataController.Values[vIndex, GridTableViewDsTax.Index],
                                   Ifthen(Tag=0,'null',FloatToStr(Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderQty.Index],    0.0))),
                                   'POS',
                                   GetIPAddress])
          end
          else
            DM.ExecCloud('update OL_ORDER_D '
                     +'   set CD_GOODS      =:P4, '
                     +'       PR_ORDER      =:P5, '
                     +'       QTY_ORDER     =:P6, '
                     +'       AMT_DUTY      =:P7, '
                     +'       AMT_TAX       =:P8, '
                     +'       AMT_DUTYFREE  =:P9,  '
                     +'       AMT_ORDER     =:P10, '
                     +Ifthen(Tag=0,'QTY_CONFIRM=null, ','QTY_CONFIRM =:P6, ')
                     +'       CD_SAWON_CHG  =:P11, '
                     +'       UPDATE_IP     =:P12 '
                     +' where CD_HEAD    =:P0 '
                     +'   and YMD_ORDER  =:P1 '
                     +'   and NO_ORDER   =:P2 '
                     +'   and SEQ        =:P3; ',
                      [Common.Config.HeadStoreCode,
                       DtoS(OrderDateEdit.Date),
                       vOrderNo,
                       Ifthen(GridTableView.DataController.Values[vIndex, GridTableViewRowState.Index] = rsInsert, vSeq, NVL(GridTableView.DataController.Values[vIndex, GridTableViewSeq.Index],0)),
                       GridTableView.DataController.Values[vIndex, GridTableViewGoodsCode.Index],
                       vBuyPrice,
                       Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderQty.Index],    0.0),
                       Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderNetAmt.Index], 0.0) - Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderNotAmt.Index], 0.0),
                       Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderVatAmt.Index], 0.0),
                       Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderNotAmt.Index], 0.0),
                       Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderNetAmt.Index], 0.0)+Nvl(GridTableView.DataController.Values[vIndex, GridTableViewOrderVatAmt.Index], 0.0),
                       'POS',
                       GetIPAddress],
                       false,Common.RestDBURL);
        end;
      end;

      if vSQL <> '' then
      begin
        vSQL := 'insert into OL_ORDER_D(CD_HEAD, YMD_ORDER, NO_ORDER, SEQ, CD_STORE, CD_GOODS, PR_ORDER, QTY_ORDER, AMT_DUTY, AMT_TAX, AMT_DUTYFREE, AMT_ORDER, DS_TAX, QTY_CONFIRM, CD_SAWON_CHG, UPDATE_IP) '
               +' values '+LeftStr(vSQL, Length(vSQL)-1)+';';

        DM.ExecCloud(vSQL, [], false,Common.RestDBURL);
      end;
      DM.ExecCloud('', [], true,Common.RestDBURL);
      OrderNo := vOrderNo;
    end;
  except
    on E: Exception do
    begin
      Common.ErrBox(E.Message);
    end;
  end;
end;

procedure TWebOrder_F.SetRemainAmt;
begin
  DM.OpenCloud('select a.CD_ORDER_LIMIT, '
              +'       a.AMT_ORDER_LIMIT, '
              +'       b.AMT_REMAIN, '
              +'       b.AMT_ORDER '
              +'  from MS_STORE_ETC a, '
              +'      (select  Sum(Ifnull(AMT_BASE,0) + Ifnull(AMT_SALE,0) - Ifnull(AMT_PAY,0)) as AMT_REMAIN, '
              +'               Sum(Ifnull(AMT_ORDER,0)) as AMT_ORDER '
              +'         from  (select   AMT_BASE, '
              +'                         0 as AMT_ORDER, '
              +'                         0 as AMT_SALE, '
              +'                         0 as AMT_PAY '
              +'                  from   SL_BOOKS_MONTH '
              +'                 where   CD_HEAD  = :P0 '
              +'                   and   CD_STORE = :P1 '
              +'                   and   CD_CLOSE = :P3 '
              +'                   and   CD_CODE  = :P2 '
              +'                   and   YM_CLOSE = Left(:P4,6) '
              +'                union all '
              +'                select   0 , '
              +'                         Sum((Ifnull(b.QTY_CONFIRM, b.QTY_ORDER) - Ifnull(b.QTY_SALE,0)) * b.PR_ORDER) as AMT_ORDER, '  //발주-출고 수량을 여신에 포함
              +'                         0, '
              +'                         0 '
              +'                  from   OL_ORDER_H a inner join '
              +'                         OL_ORDER_D b on b.CD_HEAD   = a.CD_HEAD '
              +'                                     and b.CD_STORE  = a.CD_STORE '
              +'                                     and b.YMD_ORDER = a.YMD_ORDER '
              +'                                     and b.NO_ORDER  = a.NO_ORDER '
              +'                 where   a.CD_HEAD   =:P0 '
              +'                   and   a.CD_STORE  =:P3 '
              +'                   and   a.DS_STATUS <> ''D'' '
              +'                   and   ConCat(a.YMD_ORDER,a.NO_ORDER) <> :P5 '
              +'                union all '
              +'                select   0 as AMT_BASE, '
              +'                         0, '
              +'                         Sum(AMT_SALE) as AMT_SALE, '
              +'                         0 as AMT_PAY '
              +'                  from   OL_SALE_H '
              +'                 where   CD_HEAD   =:P0 '
              +'                   and   CD_STORE  =:P3 '
              +'                   and   YMD_SALE >= ConCat(Left(:P4,6),''01'') '
              +'                union all '
              +'                select   0 as AMT_BASE, '
              +'                         0 as AMT_ORDER, '
              +'                         0 as AMT_RETURN, '
              +'                         Sum(AMT_PAYIN+AMT_DC) as AMT_PAY '
              +'                  from   SL_ACCT '
              +'                 where   CD_HEAD  =:P0 '
              +'                   and   CD_STORE =:P1 '
              +'                   and   CD_MEMBER =:P3 '
              +'                   and   CD_ACCT =''001'' '
              +'                   and   YMD_OCCUR >= ConCat(Left(:P4,6),''01'')  '
              +'                ) as t '
              +'        ) as b '
              +' where a.CD_HEAD  =:P0 '
              +'   and a.CD_STORE =:P3 ',
              [Common.Config.HeadStoreCode,
               StandardStore,
               '50',
               Common.Config.StoreCode,
               DtoS(OrderDateEdit.Date),
               DtoS(OrderDateEdit.Date)+'0001'],Common.RestDBURL);
  if not DM.CloudData.Eof then
  begin
    OrderLimitCode         := DM.CloudData.Fields[0].AsString;
    CreditAmtEdit.Value    := DM.CloudData.Fields[1].AsCurrency;
    if CreditAmtEdit.Value > 0 then
      RestCreditAmtEdit.Value:= DM.CloudData.Fields[1].AsCurrency - DM.CloudData.Fields[2].AsCurrency - DM.CloudData.Fields[3].AsCurrency;
    RemainAmtEdit.Value := DM.CloudData.Fields[2].AsCurrency;
  end
  else
  begin
    OrderLimitCode      := '';
    CreditAmtEdit.Value := 0;
    RemainAmtEdit.Value := 0;
    RestCreditAmtEdit.Value := 0;
  end;
  DM.CloudData.Close;
end;

procedure TWebOrder_F.DoSearch;
begin

end;
end.
