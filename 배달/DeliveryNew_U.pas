unit DeliveryNew_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxContainer, cxLabel, cxGridCustomTableView, cxGridTableView,
  cxGridCustomView, cxClasses, cxGridLevel, cxGrid, ExtCtrls, Menus,
  StdCtrls, Grids, cxMemo, cxTextEdit,
  DB, MemDS, DBAccess, Uni, Common_U, Math, StrUtils,
  cxCurrencyEdit, cxGroupBox, cxGridBandedTableView, jpeg, ImgList,
  cxPCdxBarPopupMenu, cxMaskEdit, cxDropDownEdit, cxCalendar, cxPC, DateUtils,
  cxDBData, cxGridDBTableView, dxmdaset, cxNavigator, Vcl.ComCtrls, dxCore,
  cxDateUtils, System.ImageList, AdvSmoothToggleButton, AdvGlassButton,
  Vcl.WinXCtrls, dxGDIPlusClasses, cxGridCardView, cxGridCustomLayoutView,
  System.Actions, Vcl.ActnList, Vcl.WinXCalendars, AdvGlowButton, cxButtons,
  Vcl.Buttons, MaskUtils, dxDateRanges, dxScrollbarAnnotations;

type TBaeminOrderMenu = record
  Code :String;
  Item :String;
  Step :Integer;
  Name :String;
  Memo :String;
  Qty :Integer;
  Price,
  Amount :Integer;
  TotalItem :String;
end;

type TDeliveryStep = (dsNone, dsOrder, dsDelivery, dsAccount, dsDishReturn, dsCancel); //주문,배달,계산
type TCallStep     = (csNone, csCall, csSaleMenu);
type
  TDeliveryNew_F = class(TForm)
    panDeliveryInfo: TPanel;
    edt_CustName: TcxTextEdit;
    edt_TelNo1: TcxTextEdit;
    edt_TelNo2: TcxTextEdit;
    edt_TelNo3: TcxTextEdit;
    edt_TelNo4: TcxTextEdit;
    edt_Address1: TcxTextEdit;
    edt_Address2: TcxTextEdit;
    meo_Remark: TcxMemo;
    lblDeliveryNo: TcxLabel;
    lblOrderDate: TcxLabel;
    lblDeliveryStatus: TcxLabel;
    lblDeliveryDamdang: TcxLabel;
    lbl_Member: TcxLabel;
    Grid: TcxGrid;
    Level: TcxGridLevel;
    OrderGrid: TcxGrid;
    OrderTableView: TcxGridTableView;
    OrderTableViewMenuName: TcxGridColumn;
    OrderTableViewQty: TcxGridColumn;
    OrderTableViewSalePrice: TcxGridColumn;
    OrderTableViewSaleAmt: TcxGridColumn;
    HistoryTableView: TcxGridTableView;
    HistoryTableViewSaleDate: TcxGridColumn;
    HistoryTableViewSaleMenu: TcxGridColumn;
    HistoryTableViewSaleType: TcxGridColumn;
    OrderLevel: TcxGridLevel;
    HistoryLevel: TcxGridLevel;
    OrderTableViewViewQty: TcxGridColumn;
    OrderTableViewDsMenu: TcxGridColumn;
    OrderTableViewDsSale: TcxGridColumn;
    OrderTableViewOrgSalePrice: TcxGridColumn;
    OrderTableViewMemo: TcxGridColumn;
    OrderTableViewMenuCode: TcxGridColumn;
    OrderTableViewNo: TcxGridColumn;
    OrderTableViewType: TcxGridColumn;
    OrderTableViewViewPrice: TcxGridColumn;
    OrderTableViewSubMenuCode: TcxGridColumn;
    OrderTableViewSeq: TcxGridColumn;
    OrderTableViewStep: TcxGridColumn;
    OrderTableViewOrderYN: TcxGridColumn;
    OrderTableViewOrderDate: TcxGridColumn;
    OrderTableViewDoublePrice: TcxGridColumn;
    OrderTableViewMenuDc: TcxGridColumn;
    OrderTableViewDsTax: TcxGridColumn;
    OrderTableViewKitchen: TcxGridColumn;
    OrderTableViewEventNo: TcxGridColumn;
    OrderTableViewEventDc: TcxGridColumn;
    OrderTableViewDcYn: TcxGridColumn;
    OrderTableViewPointYn: TcxGridColumn;
    OrderTableViewRcpYn: TcxGridColumn;
    OrderTableViewVanNo: TcxGridColumn;
    OrderTableViewDsKitchen: TcxGridColumn;
    OrderTableViewGroupNo: TcxGridColumn;
    OrderTableViewOrgMenuName: TcxGridColumn;
    OrderTableViewChangeYn: TcxGridColumn;
    HistoryTableViewSaleAmt: TcxGridColumn;
    ButtonPanel: TPanel;
    GridTableView: TcxGridBandedTableView;
    GridTableViewDeliveryNo: TcxGridBandedColumn;
    GridTableViewStatus: TcxGridBandedColumn;
    GridTableViewType: TcxGridBandedColumn;
    GridTableViewCustName: TcxGridBandedColumn;
    GridTableViewTelMobile: TcxGridBandedColumn;
    GridTableViewAddress: TcxGridBandedColumn;
    GridTableViewCourse: TcxGridBandedColumn;
    GridTableViewOrderAmt: TcxGridBandedColumn;
    panCall: TPanel;
    lblCallStatus: TcxLabel;
    lblCallNo: TcxLabel;
    GridTableViewTelHome: TcxGridBandedColumn;
    GridTableViewTelEtc: TcxGridBandedColumn;
    GridTableViewTelEtc2: TcxGridBandedColumn;
    lblCallCustName: TcxLabel;
    GridPopupMenu: TPopupMenu;
    DeliveryNoMenu: TMenuItem;
    StatusMenu: TMenuItem;
    TypeMenu: TMenuItem;
    CustNameMenu: TMenuItem;
    TelNoMenu: TMenuItem;
    AddressMenu: TMenuItem;
    CourseMenu: TMenuItem;
    OrderAmtMenu: TMenuItem;
    ElapsedtimeMenu: TMenuItem;
    GridTableViewElapsedTime: TcxGridBandedColumn;
    lblCallLine: TcxLabel;
    GridTableViewAcctType: TcxGridBandedColumn;
    ImageList: TImageList;
    AcctTypeMenu: TMenuItem;
    PrintPopupMenu: TPopupMenu;
    OrderPrintMenu: TMenuItem;
    BillPrintMenu: TMenuItem;
    ClockTimer: TTimer;
    panManagement: TPanel;
    Grid2: TcxGrid;
    Grid2Level1: TcxGridLevel;
    Grid2Level2: TcxGridLevel;
    cxLabel2: TcxLabel;
    bvGridView: TcxGridBandedTableView;
    bvGridViewDate: TcxGridBandedColumn;
    bvGridViewNo: TcxGridBandedColumn;
    bvGridViewType: TcxGridBandedColumn;
    bvGridViewStatus: TcxGridBandedColumn;
    bvGridViewCustName: TcxGridBandedColumn;
    bvGridViewOrderAmt: TcxGridBandedColumn;
    bvGridViewTelNo: TcxGridBandedColumn;
    bvGridViewDeliverySawon: TcxGridBandedColumn;
    bvGridViewReturnSawon: TcxGridBandedColumn;
    bvGridViewCoupon: TcxGridBandedColumn;
    bvGridViewAcctType: TcxGridBandedColumn;
    bvGridViewAddress: TcxGridBandedColumn;
    bvGridViewLocal: TcxGridBandedColumn;
    bvGridViewCourse: TcxGridBandedColumn;
    tvGridView: TcxGridTableView;
    tvGridViewTelNo: TcxGridColumn;
    tvGridViewStatus: TcxGridColumn;
    tvGridViewCustName: TcxGridColumn;
    tvGridViewCallDate: TcxGridColumn;
    StartTimer: TTimer;
    GridTableViewOrderTime: TcxGridBandedColumn;
    OrderTimeMenu: TMenuItem;
    GridTableViewDamdang: TcxGridBandedColumn;
    DamdangMenu: TMenuItem;
    bvGridViewOrderTime: TcxGridBandedColumn;
    bvGridViewDeliveryTime: TcxGridBandedColumn;
    tvGridViewAddress: TcxGridColumn;
    HistoryTableViewDeliveryNo: TcxGridColumn;
    HistoryTableViewRemark: TcxGridColumn;
    GridTableViewBaeminOrderNo: TcxGridBandedColumn;
    N1: TMenuItem;
    PostButton: TAdvSmoothToggleButton;
    SearchButton: TAdvSmoothToggleButton;
    MemberSaveButton: TAdvSmoothToggleButton;
    MemberSearchButton: TAdvSmoothToggleButton;
    DeliveryNoLabel: TcxLabel;
    cxLabel7: TcxLabel;
    DeliveryOrderTimeLabel: TcxLabel;
    DeliveryDamdangLabel: TcxLabel;
    DeliveryMemberLabel: TcxLabel;
    GuestNameLabel: TcxLabel;
    TelNo1Label: TcxLabel;
    TelNo2Label: TcxLabel;
    TelNo3Label: TcxLabel;
    MapButton: TAdvSmoothToggleButton;
    CouponButton: TAdvSmoothToggleButton;
    DeliveryButton: TAdvSmoothToggleButton;
    PackingButton: TAdvSmoothToggleButton;
    LocalButton: TAdvSmoothToggleButton;
    CourseButton: TAdvSmoothToggleButton;
    OrderTypeLabel: TcxLabel;
    CouponLabel: TcxLabel;
    CourseLabel: TcxLabel;
    LocalLabel: TcxLabel;
    PayTypeLabel: TcxLabel;
    RequestItemButton: TAdvSmoothToggleButton;
    DeliveryGoButton: TAdvGlassButton;
    DishReturnButton: TAdvGlassButton;
    DishListButton: TAdvGlassButton;
    DeleteButton: TAdvGlassButton;
    TakeOutButton: TAdvGlassButton;
    NewButton: TAdvGlassButton;
    ReprintButton: TAdvGlassButton;
    CaptionLabel: TLabel;
    Search2Button: TAdvSmoothToggleButton;
    CloseButton: TcxButton;
    StatusSearchButton: TAdvGlassButton;
    SearchPanel: TRelativePanel;
    AllSearchButton: TAdvGlassButton;
    OrderSearchButton: TAdvGlassButton;
    DeliverySearchButton: TAdvGlassButton;
    AcctSearchButton: TAdvGlassButton;
    RiderCallButton: TAdvGlassButton;
    ViewModeButton: TAdvGlassButton;
    GridCardView: TcxGridCardView;
    GridCardViewDeliveryNo: TcxGridCardViewRow;
    GridCardViewBaeminDeliveryNo: TcxGridCardViewRow;
    GridCardViewStatus: TcxGridCardViewRow;
    GridCardViewType: TcxGridCardViewRow;
    GridCardViewOrderTime: TcxGridCardViewRow;
    GridCardViewCustName: TcxGridCardViewRow;
    GridCardViewTelMobile: TcxGridCardViewRow;
    GridCardViewAddress: TcxGridCardViewRow;
    GridCardViewCourse: TcxGridCardViewRow;
    GridCardViewOrderAmt: TcxGridCardViewRow;
    GridCardViewElapsedTime: TcxGridCardViewRow;
    GridCardViewAcctType: TcxGridCardViewRow;
    GridCardViewDamdang: TcxGridCardViewRow;
    GridCardViewTelHome: TcxGridCardViewRow;
    GridCardViewTelEtc: TcxGridCardViewRow;
    GridCardViewTelEtc2: TcxGridCardViewRow;
    StyleRepository: TcxStyleRepository;
    cxStyle41: TcxStyle;
    StyleHeader: TcxStyle;
    StyleFooter: TcxStyle;
    cxStyleRepository1: TcxStyleRepository;
    styleFontRed: TcxStyle;
    styleFontBlue: TcxStyle;
    styleFontBlack: TcxStyle;
    styleFontNotTel: TcxStyle;
    styleFontRed2: TcxStyle;
    styleFontBlue2: TcxStyle;
    styleFontBlack2: TcxStyle;
    styleFontNotTel2: TcxStyle;
    styleFontEven: TcxStyle;
    StyleLevel: TcxStyle;
    MessageImage: TImage;
    MessageLabel: TLabel;
    ActionList: TActionList;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action5: TAction;
    Action6: TAction;
    Action7: TAction;
    Action8: TAction;
    Action9: TAction;
    CancelButton: TAdvSmoothToggleButton;
    OrderButton: TAdvSmoothToggleButton;
    SaveButton: TAdvSmoothToggleButton;
    MissedCallButton: TAdvSmoothToggleButton;
    lblWork: TLabel;
    SearchDatePicker: TCalendarPicker;
    NotDishReturnLabel: TLabel;
    NotDishReturnCountLabel: TLabel;
    NotDishReturnImage: TImage;
    SaleHistoryPanel: TPanel;
    cxLabel1: TcxLabel;
    cxLabel4: TcxLabel;
    SaleRemarkMemo: TMemo;
    cxGrid1: TcxGrid;
    SaleTableView: TcxGridTableView;
    SaleTableViewSeq: TcxGridColumn;
    SaleTableViewMenu: TcxGridColumn;
    SaleTableViewQty: TcxGridColumn;
    SaleTableViewPrice: TcxGridColumn;
    SaleTableViewAmt: TcxGridColumn;
    cxGridLevel1: TcxGridLevel;
    Close2Button: TAdvSmoothToggleButton;
    PayPanel: TPanel;
    CardButton: TAdvSmoothToggleButton;
    CashButton: TAdvSmoothToggleButton;
    CashRcpButton: TAdvSmoothToggleButton;
    EtcButton: TAdvSmoothToggleButton;
    PayFinishButton: TAdvSmoothToggleButton;
    PayButton: TAdvSmoothToggleButton;
    RcpManagerTimer: TTimer;
    FunctionPanelButton: TSpeedButton;
    cxLabel3: TcxLabel;
    procedure FormShow(Sender: TObject);
    procedure GridTableViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridTableViewCanSelectRecord(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; var AAllow: Boolean);
    procedure btnDishReturnListPrintClick(Sender: TObject);
    procedure btnDishReturnClick(Sender: TObject);
    procedure GridTableViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure GridTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure GridResize(Sender: TObject);
    procedure GridTableViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure edt_CustNamePropertiesChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DeliveryNoMenuClick(Sender: TObject);
    procedure OrderPrintMenuClick(Sender: TObject);
    procedure BillPrintMenuClick(Sender: TObject);
    procedure Grid2Resize(Sender: TObject);
    procedure StartTimerTimer(Sender: TObject);
    procedure bvGridViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure tvGridViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure edt_TelNo1Exit(Sender: TObject);
    procedure panDeliveryInfoEnter(Sender: TObject);
    procedure tvGridViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure HistoryTableViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure tvGridViewKeyPress(Sender: TObject; var Key: Char);
    procedure PostButtonClick(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure MemberSaveButtonClick(Sender: TObject);
    procedure MemberSearchButtonClick(Sender: TObject);
    procedure MapButtonClick(Sender: TObject);
    procedure CouponButtonClick(Sender: TObject);
    procedure DeliveryButtonClick(Sender: TObject);
    procedure CourseButtonClick(Sender: TObject);
    procedure LocalButtonClick(Sender: TObject);
    procedure PayButtonClick(Sender: TObject);
    procedure RequestItemButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure OrderButtonClick(Sender: TObject);
    procedure ReprintButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure DeliveryGoButtonClick(Sender: TObject);
    procedure DishReturnButtonClick(Sender: TObject);
    procedure DishListButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure TakeOutButtonClick(Sender: TObject);
    procedure NewButtonClick(Sender: TObject);
    procedure Search2ButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure Close2ButtonClick(Sender: TObject);
    procedure AllSearchButtonClick(Sender: TObject);
    procedure OrderSearchButtonClick(Sender: TObject);
    procedure DeliverySearchButtonClick(Sender: TObject);
    procedure AcctSearchButtonClick(Sender: TObject);
    procedure StatusSearchButtonClick(Sender: TObject);
    procedure CaptionLabelClick(Sender: TObject);
    procedure OrderGridResize(Sender: TObject);
    procedure RiderCallButtonClick(Sender: TObject);
    procedure ViewModeButtonClick(Sender: TObject);
    procedure AdvSmoothToggleButton1Click(Sender: TObject);
    procedure lblCallStatusClick(Sender: TObject);
    procedure MissedCallButtonClick(Sender: TObject);
    procedure CardButtonClick(Sender: TObject);
    procedure RcpManagerTimerTimer(Sender: TObject);
    procedure FunctionPanelButtonClick(Sender: TObject);
    procedure cxLabel3Click(Sender: TObject);
  private
    FCallStep     : TCallStep;
    FMemberCode   :String;            //회원번호
    FBefOrderAmt  :Integer;           //직전 주문금액
    FRowCount     :Integer;
    FBefRowCount  :Integer;
    FTableNo      :Integer;
    FBeforStep    :TDeliveryStep;    //직전 배달상태
    FDeliveryStep :TDeliveryStep;    //배달상태
    FDeliveryMan  :String;           //배달담당
    FRecallMan    :String;
    FDeliveryDate :TDateTime;
    FDefaultAddr  :String;
    FTelLine      :String;
    isNew         :Boolean;
    FisData       :Boolean;
    FisChanged    :Boolean;
    isLoading     :Boolean;
    isNotTel      :Boolean;
    isAbsent      :Boolean; //부재중전화여부
    ClickTime :TDateTime;
    FListMode     :Boolean;
  private
    procedure SetForm;
    procedure SetFunctionButton;
    procedure GetDeliveryList;
    procedure CidReadEvent(const S : String);
    procedure SetUsePos(aValue:String);
    function  GetUseCheck(aDeliveryNo:String):Boolean;
    procedure GetOrderMenu;
    function  GetDeliveryMan:Boolean;
    function  GetRecallMan:Boolean;
    function  DataSave(Sender: TObject=nil):Boolean;
    procedure SetDeliveryDisplay;
    procedure SetDeliveryHistory(Kind:Integer);
    procedure ClearDeliveryData;
    procedure DeleteDelivery;
    procedure SetCustomerInfo(aValue:String);
    procedure SetDeliveryStep(const Value: TDeliveryStep);
    procedure SetCallStep(AValue:TCallStep);
    procedure SetMemberCode(AValue:String);
    procedure SetAbsentCall(aAll:Boolean=true);
    function  GetDeliveryOrderDataIndex(aTelNo:String):Integer;
    property  CallStep     :TCallStep      read FCallStep     write SetCallStep;
    property  DeliveryStep :TDeliveryStep  read FDeliveryStep write SetDeliveryStep;
    property  MemberCode   :String         read FMemberCode   write SetMemberCode;
    procedure SetData(aData:Boolean);
    procedure SetChanged(aChanged: Boolean);
    procedure SetListMode(aMode: Boolean);
    property  isListMode: Boolean read FListMode write SetListMode;
    property  isData: Boolean read FisData write SetData;
    property  isChanged: Boolean read FisChanged write SetChanged;
  public
    FOrderGrid :TStringGrid;
    FCidTelNo  :String;
    FOrderAmt  :Integer;
    FDCAmount  :Integer;
    procedure TableViewToStringGrid;
    procedure BaeminDeliveryPrint(aDeliveryNo:String);
  end;

var
  DeliveryNew_F: TDeliveryNew_F;

const
  msgMissedCall  = '부재중';
  msgOrder       = '주문';
  msgDelivery    = '배달';
  msgAcct        = '계산';
  msgNoOrder     = '미주문';
  msgOrderCancel = '주문취소';

implementation
uses GlobalFunc_U, Const_U, Order_U, DeliveryAddr_U, Delivery_U,
  DBModule_U, RePrint_U, Map_U, RcpChange_U;

{$R *.dfm}

{ TDeliveryNew_F }
procedure TDeliveryNew_F.FormCreate(Sender: TObject);
var vIndex   :Integer;
    vTemp :String;
    vWidth :Integer;
begin

  if Common.Config.DeliveryDisplay = '' then
  begin
    Self.Position := poOwnerFormCenter;
    if Screen.Width > 1920 then
    begin
      Self.Width    := 1920;
      Self.Height   := 1080;
    end
    else
    begin
      Self.Width    := Screen.Width;
      Self.Height   := Screen.Height;
    end;
  end
  else
  begin
    vTemp := ','+Common.Config.DeliveryDisplay;
    Self.Top      := StoI(CopyPos(vTemp,',',1));
    Self.Left     := StoI(CopyPos(vTemp,',',2));
    Self.Width    := StoI(CopyPos(vTemp,',',3));
    Self.Height   := StoI(CopyPos(vTemp,',',4));

    Self.Width    := Ifthen(Self.Width > Screen.Width, Screen.Width, Self.Width);
    Self.Height   := Ifthen(Self.Height > Screen.Height, Screen.Height, Self.Height);
  end;

  Common.LogoCreate(Self,2);

  SaleHistoryPanel.Top  := (Self.Height - SaleHistoryPanel.Height) div 2 + Self.Top;
  SaleHistoryPanel.Left := (Self.Width  - SaleHistoryPanel.Width ) div 2 + Self.Left;
  isAbsent := false;

{  if GetOption(290) = '1' then
  begin
    bvGridView.DataController.Summary.FooterSummaryItems[1].Kind    := skNone;
    GridTableView.DataController.Summary.FooterSummaryItems[0].Kind := skNone;
  end;
}
  AcctSearchButton.Visible := GetOption(56)='1';

  OpenQuery('select DELIVERY_ROWHEIGHT, '
           +'       DELIVERY_FONTSIZE, '
           +'       DELIVERY_DEFADDR '
           +'  from MS_STORE '
           +' where CD_STORE =:P0 ',
           [Common.Config.StoreCode]);
  GridTableView.OptionsView.DataRowHeight  := Common.Query.Fields[0].AsInteger;
  GridTableView.OptionsView.HeaderHeight   := Common.Query.Fields[0].AsInteger;
  OrderTableView.OptionsView.DataRowHeight := Common.Query.Fields[0].AsInteger;
  OrderTableView.OptionsView.HeaderHeight  := Common.Query.Fields[0].AsInteger;
  bvGridView.OptionsView.DataRowHeight     := Common.Query.Fields[0].AsInteger;
  bvGridView.OptionsView.HeaderHeight      := Common.Query.Fields[0].AsInteger;
  tvGridView.OptionsView.DataRowHeight     := Common.Query.Fields[0].AsInteger;
  tvGridView.OptionsView.HeaderHeight      := Common.Query.Fields[0].AsInteger;
  Grid.Font.Size                           := Common.Query.Fields[1].AsInteger;
  Grid2.Font.Size                          := Common.Query.Fields[1].AsInteger;
  OrderGrid.Font.Size                      := Common.Query.Fields[1].AsInteger;

  styleFontBlack.Font.Size                := Common.Query.Fields[1].AsInteger;
  styleFontRed.Font.Size                  := Common.Query.Fields[1].AsInteger;
  styleFontBlue.Font.Size                 := Common.Query.Fields[1].AsInteger;
  styleFontNotTel.Font.Size               := Common.Query.Fields[1].AsInteger;
  StyleHeader.Font.Size                   := Common.Query.Fields[1].AsInteger;
  FDefaultAddr                            := Common.Query.Fields[2].AsString;
  Common.Query.Close;

  FOrderGrid := TStringGrid.Create(Self);
  FOrderGrid.ColCount := GDM_COLCOUNT;
  CallStep   := csNone;
  isNew      := false;
  isChanged  := false;
  isLoading  := false;
  isNotTel   := false;
end;

procedure TDeliveryNew_F.FormShow(Sender: TObject);
var vIndex :Integer;
begin
  SearchDatePicker.Date := StoD(Common.WorkDate);

  SetForm;
  SetFunctionButton;

  panCall.Top  := (Self.Height - panCall.Height) div 2;
  panCall.Left := (Self.Width  - panCall.Width ) div 2;
  Grid.Tag := Grid.Width;
  isListMode := false;
  GridTableView.Bands[0].Width := Grid.Width-15;
  if Common.Config.Cid_Port > 0 then
    Common.Device.OnCidReadData :=CidReadEvent;
  NotDishReturnLabel.Visible      := GetOption(56) = '1';
  NotDishReturnCountLabel.Visible := GetOption(56) = '1';
  ClearDeliveryData;
  GetDeliveryList;
  GridTableViewFocusedRecordChanged(nil,nil,nil,false);
  Common.WriteLog('work', Format('DeliveryNew-FormShow(%s)',[FCidTelNo]));

  if FCidTelNo <> EmptyStr then
    StartTimer.Enabled := true;
  //두번눌리는현상 방지
  ClickTime         := IncSecond(Now,-3);
end;

procedure TDeliveryNew_F.FunctionPanelButtonClick(Sender: TObject);
begin
  if ButtonPanel.Visible then
  begin
    MissedCallButton.Visible    := false;
    ButtonPanel.Visible := false;
    Grid.Left  := 5;
    Grid.Width := Grid.Width + 127;
  end
  else
  begin
    MissedCallButton.Visible    := true;
    ButtonPanel.Visible := true;
    Grid.Left  := 132;
    Grid.Width := Grid.Width - 127;
  end;
end;

procedure TDeliveryNew_F.MapButtonClick(Sender: TObject);
begin
  if (Trim(edt_Address1.Text) = '') and (Trim(edt_Address2.Text) = '') then
  begin
    Common.ErrBox('주소가 없습니다');
    if edt_Address2.Enabled then
      edt_Address2.SetFocus;
    Exit;
  end;

  Common.MapCount := Common.MapCount + 1;
  Map_F := TMap_F.Create(Application);
  try
    Map_F.WebURL := edt_Address1.Text + edt_Address2.Text;
    Map_F.ShowModal;
  finally
    FreeAndNil(Map_F);
  end;
end;

procedure TDeliveryNew_F.MemberSaveButtonClick(Sender: TObject);
var vMobileNo,
    vHomeNo :String;
    vDeliveryDate,
    vDeliveryNo :String;
    vSeq, vIndex :Integer;
    vCode  :String;
    vPoint :Integer;
    vWhere :String;
begin
  for vIndex := 0 to ComponentCount-1 do
    if (Components[vIndex] is TcxTextEdit) then
      (Components[vIndex] as TcxTextEdit).PostEditValue;

  if (GetOption(150) = '0') and (Trim(edt_CustName.Text) = '') and (Sender <> nil) then
  begin
    Common.ErrBox('회원명을 입력하세요');
    edt_CustName.SetFocus;
    Exit;
  end;

  if (Trim(edt_TelNo1.Text) = '') and (Trim(edt_TelNo2.Text) = '') and (Sender <> nil) then
  begin
    Common.ErrBox('전화번호를 입력하세요');
    edt_TelNo1.SetFocus;
    Exit;
  end;

  if (GetOption(150) = '0') and (Trim(edt_Address1.Text) = '') and (Sender <> nil) then
  begin
    Common.ErrBox('주소를 입력하세요');
    edt_Address1.SetFocus;
    Exit;
  end;

  try
    MemberSaveButton.Enabled := False;
    if GetOnlyNumber(edt_TelNo1.Text) <> '' then
      vWhere := Format('''%s'',',[GetOnlyNumber(edt_TelNo1.Text)]);

    if GetOnlyNumber(edt_TelNo2.Text) <> '' then
      vWhere := vWhere + Format('''%s'',',[GetOnlyNumber(edt_TelNo2.Text)]);

    if GetOnlyNumber(edt_TelNo3.Text) <> '' then
      vWhere := vWhere + Format('''%s'',',[GetOnlyNumber(edt_TelNo3.Text)]);

    if GetOnlyNumber(edt_TelNo4.Text) <> '' then
      vWhere := vWhere + Format('''%s'',',[GetOnlyNumber(edt_TelNo4.Text)]);

    vWhere := '('+LeftStr(vWhere,Length(vWhere)-1)+')';

   if MemberCode = '' then
   begin
     OpenQuery('select Count(*) '
               +'  from MS_MEMBER '
               +' where CD_STORE =:P0 '
               +'   and ( TEL_MOBILE in '+vWhere
               +'		   or TEL_HOME  in '+vWhere
               +'		   or TEL_ETC1  in '+vWhere
               +'		   or TEL_ETC2  in '+vWhere+' ) '
               +'   and DS_STATUS = ''0'' ',
                [Common.Config.StoreCode]);

      if Common.Query.Fields[0].AsInteger > 0 then
      begin
        Common.ErrBox('이미 등록된 전화번호입니다');
        Exit;
      end;
    end;

    if IsMobileNumber(GetOnlyNumber(edt_TelNo1.Text)) then
      vMobileNo := GetOnlyNumber(edt_TelNo1.Text)
    else
      vHomeNo := GetOnlyNumber(edt_TelNo1.Text);

    //신규주문시 고객명에 포커스를 위치하지 않을때 고객명이 없으면 주소를 고객명에 넣는다
    if (GetOption(377) = '1') and (Trim(edt_CustName.Text) = EmptyStr) then
      edt_CustName.Text := edt_Address1.Text;

    Common.Query.Close;
    if MemberCode = '' then
    begin
     if not Common.SaveMemberAdd(true,                            //aNew
                                  '',                             //aMemberNo
                                  edt_CustName.Text,              //aName
                                  Common.Member.cd_class,         //aDsMember
                                  '',                             //aGender
                                  vHomeNo,                        //aHomeTel
                                  vMobileNo,                      //aMobileTel
                                  Common.Member.CardNo,           //aCardNo
                                  '',                             //aPost
                                  edt_Address1.Text,              //aAddr1
                                  edt_Address2.Text,              //aAddr2
                                  Common.Member.no_cashrcp,       //aCashRcpNo
                                  CourseButton.Hint,              //aCourse
                                  LocalButton.Hint,               //aLocal
                                  '',                            //aLunar
                                  Common.Member.Yn_trust,         //aTrust
                                  '',                             //aNews
                                  '',                             //aBirthDay
                                  '',                             //aDamdangCode
                                  meo_Remark.Text,                //aRemark
                                  GetOnlyNumber(edt_TelNo3.Text),        //aEtcTel1
                                  GetOnlyNumber(edt_TelNo4.Text)) then   //aEtcTel2
      Exit;

      //일반고객으로 판매된 배달내역을 회원으로 변경한다
      if HistoryTableView.DataController.RecordCount > 0 then
      begin
        ExecQuery('update SL_DELIVERY '
                 +'   set CD_MEMBER = :P2 '
                 +' where CD_STORE  = :P0 '
                 +'   and NO_TEL1   = :P1 '
                 +'   and CD_MEMBER = '''' ',
                 [Common.Config.StoreCode,
                  GetOnlyNumber(edt_TelNo1.Text),
                  MemberCode]);
      end;
    end
    else
    begin
      if not Common.SaveMemberAdd(false,                                           //aNew
                                  MemberCode,                                      //aMemberNo
                                  edt_CustName.Text,                               //aName
                                  Common.Member.cd_class,                          //aDsMember
                                  '',                                              //aGender
                                  GetOnlyNumber(edt_TelNo2.Text),                  //aHomeTel
                                  GetOnlyNumber(edt_TelNo1.Text),                  //aMobileTel
                                  Common.Member.CardNo,                            //aCardNo
                                  '',                                              //aPost
                                  edt_Address1.Text,                               //aAddr1
                                  edt_Address2.Text,                               //aAddr2
                                  Common.Member.no_cashrcp,                        //aCashRcpNo
                                  CourseButton.Hint,                               //aCourse
                                  LocalButton.Hint,                                //aLocal
                                  '',                                              //aLunar
                                  Common.Member.Yn_trust,                          //aTrust
                                  '',                                              //aNews
                                  '',                                              //aBirthDay
                                  '',                                              //aDamdangCode
                                  meo_Remark.Text,                                 //aRemark
                                  GetOnlyNumber(edt_TelNo3.Text),                  //aEtcTel1
                                  GetOnlyNumber(edt_TelNo4.Text)) then             //aEtcTel2

      Exit;

      OpenQuery('select YMD_DELIVERY, '
               +'			  NO_DELIVERY '
               +'	 from SL_DELIVERY '
               +'	where CD_STORE	=:P0 '
               +'		and CD_MEMBER =:P1 '
               +'	order by YMD_DELIVERY DESC, NO_DELIVERY desc '
               +' limit 1 ',
               [Common.Config.StoreCode,
                MemberCode]);

      vDeliveryDate := Common.Query.Fields[0].AsString;
      vDeliveryNo   := Common.Query.Fields[1].AsString;
      Common.Query.Close;

      ExecQuery('update SL_DELIVERY '
               +'   set NO_TEL1		=:P4, '
               +'				NO_TEL2		=:P5, '
               +'				ADDRESS1	=:P6, '
               +'				ADDRESS2	=:P7 '
               +'	where CD_STORE      =:P0 '
               +'   and CD_MEMBER   	=:P1 '
               +'		and YMD_DELIVERY	=:P2 '
               +'		and NO_DELIVERY 	=:P3 ',
               [Common.Config.StoreCode,
                MemberCode,
                vDeliveryDate,
                vDeliveryNo,
                GetOnlyNumber(edt_TelNo1.Text),
                GetOnlyNumber(edt_TelNo2.Text),
                edt_Address1.Text,
                edt_Address2.Text]);
    end;

    MemberCode         := Common.Member.Code;
    lbl_Member.Caption := '회원 ('+MemberCode+')';
  finally
    MemberSaveButton.Enabled := True;
  end;
end;

procedure TDeliveryNew_F.MemberSearchButtonClick(Sender: TObject);
begin
  if Common.ShowMemberForm then
  begin
    MemberCode         := Common.Member.Code;
    lbl_Member.Caption := '회원 ('+MemberCode+')';
    edt_CustName.Text  := Common.Member.Name;
    edt_TelNo1.Text    := Common.Member.MobileTel;
    edt_TelNo2.Text    := Common.Member.HomeTel;
    edt_Address1.Text  := Common.Member.addr1;
    edt_Address2.Text  := Common.Member.addr2;
    meo_Remark.Text    := Common.Member.Remark;

    //회원여부 체크
    OpenQuery('select TEL_ETC1, '
             +'       TEL_ETC2, '
             +'		    TEL_MOBILE	as NO_TEL1, '
             +'			  TEL_HOME	as NO_TEL2, '
             +'			  CD_LOCAL, '
             +'			  GetCommonName(:P0, ''22'', CD_LOCAL) as NM_LOCAL, '
             +'			  CD_COURSE, '
             +'			  GetCommonName(:P0, ''20'', CD_COURSE) as NM_COURSE, '
             +'       ADDR1, '
             +'       ADDR2, '
             +'       REMARK '
             +'	 from MS_MEMBER '
             +' where CD_STORE 	=:P0 '
             +'   and CD_MEMBER  =:P1 '
             +'   and DS_STATUS  =''0'' ',
             [Common.Config.StoreCode,
              Common.Member.Code]);

    if not Common.Query.Eof then
    begin
      edt_TelNo3.Text         := SetTelephone(Common.Query.FieldByName('TEL_ETC1').AsString);
      edt_TelNo4.Text         := SetTelephone(Common.Query.FieldByName('TEL_ETC2').AsString);
      edt_TelNo1.Text         := SetTelephone(Common.Query.FieldByName('NO_TEL1').AsString);
      edt_TelNo2.Text         := SetTelephone(Common.Query.FieldByName('NO_TEL2').AsString);
      CourseButton.Caption    := Common.Query.FieldByName('NM_COURSE').AsString;
      CourseButton.Hint       := Common.Query.FieldByName('CD_COURSE').AsString;
      LocalButton.Caption     := Common.Query.FieldByName('NM_lOCAL').AsString;
      LocalButton.Hint        := Common.Query.FieldByName('CD_lOCAL').AsString;
      edt_Address1.Text       := Common.Query.FieldByName('ADDR1').AsString;
      edt_Address2.Text       := Common.Query.FieldByName('ADDR2').AsString;
    end;
    Common.Query.Close;
    InitMemberRecord(Common.Member);
    SetDeliveryHistory(0);
  end;
end;

procedure TDeliveryNew_F.MissedCallButtonClick(Sender: TObject);
var visNotTel : Boolean;
begin
  visNotTel := isNotTel;
  if not isNotTel then
  begin
    GridTableViewStatus.DataBinding.AddToFilter(nil, foEqual, msgMissedCall);
    GridTableView.DataController.Filter.Active := true;
    isData := false;
    lblWork.Visible := true;
    lblWork.Caption := msgMissedCall;
  end
  else
  begin
    AllSearchButton.Click;
    GridTableView.Controller.FocusedRecordIndex := GridTableView.DataController.RecordCount-1;
    isData    := GridTableView.DataController.RecordCount > 0;
    isChanged := false;
  end;
  isNotTel := not visNotTel;
end;

procedure TDeliveryNew_F.NewButtonClick(Sender: TObject);
var vTemp :String;
begin
  if isListMode then
    isListMode := false;

  //수화기를 들어서 자동으로 클릭된 경우
  if Sender = nil then
    vTemp := edt_TelNo1.Text;

  Common.WriteLog('work', Format('DeliveryNew-btnNewClick lblWork.Caption(%s), vTemp(%s)', ['신규배달',vTemp]));

  if (lblWork.Caption = msgMissedCall) and (GridTableView.DataController.GetFocusedRecordIndex >= 0) then
  begin
    vTemp := GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewTelMobile.Index];
    Common.DeleteCidData(GetOnlyNumber(vTemp));
    GridTableView.DataController.DeleteRecord(GridTableView.DataController.GetFocusedRecordIndex);
    MissedCallButton.Click;
  end
  else if lblWork.Caption = msgMissedCall then
    MissedCallButton.Click;

  if (GridTableView.DataController.GetFocusedRecordIndex >= 0) and (GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewStatus.Index] = msgMissedCall) then
  begin
    vTemp := GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewTelMobile.Index];
    Common.DeleteCidData(GetOnlyNumber(vTemp));
    GridTableView.DataController.DeleteRecord(GridTableView.DataController.GetFocusedRecordIndex);
  end;

  if Sender <> nil then ClearDeliveryData;
  isNew     := true;
  isChanged := true;
  if GetOption(395) = '0' then
  begin
    PayButton.Hint    := CardButton.Hint;
    PayButton.Caption := CardButton.Caption;
  end
  else
  begin
    PayButton.Hint    := CashButton.Hint;
    PayButton.Caption := CashButton.Caption;
  end;
  edt_TelNo1.Text := vTemp;
  DeliveryStep            := dsNone;
  panDeliveryInfo.Enabled := True;
  OrderGrid.ActiveLevel       := HistoryLevel;
  if FDefaultAddr <> EmptyStr then
    edt_Address1.Text       := FDefaultAddr;
  if edt_TelNo1.Text <> EmptyStr then
    SearchButtonClick(nil);

  //기존고객이면 주문화면으로 바로 간다
  if (lbl_Member.Caption <> EmptyStr) and (GetOption(188) = '1') then
    OrderButtonClick(nil)
  else
  begin
    if GetOption(316) = '0' then
      edt_CustName.SetFocus
    else if Trim(edt_TelNo1.Text) = EmptyStr then
      edt_TelNo1.SetFocus
    else
      edt_Address1.SetFocus;
  end;
end;

procedure TDeliveryNew_F.CancelButtonClick(Sender: TObject);
begin
  isNew     := false;
  isChanged := false;
  isData    := false;
  GridTableViewFocusedRecordChanged(nil,nil,nil,false);
  if isAbsent then
    SetAbsentCall(false);
end;

procedure TDeliveryNew_F.CaptionLabelClick(Sender: TObject);
begin
  if not isListMode then Exit;

  panManagement.Visible := not panManagement.Visible;
  if panManagement.Visible then
    ViewModeButton.Visible := false
  else
  begin
    SetChanged(isChanged);
    ViewModeButton.Visible := true;
  end;

  panManagement.BringToFront;
end;

procedure TDeliveryNew_F.CardButtonClick(Sender: TObject);
begin
  PayButton.Hint    := (Sender as TAdvSmoothToggleButton).Hint;
  PayButton.Caption := (Sender as TAdvSmoothToggleButton).Caption;
  PayPanel.Visible  := false;
  isChanged := true;
end;

procedure TDeliveryNew_F.PayButtonClick(Sender: TObject);
begin
  if PayPanel.Visible then
  begin
    payPanel.Visible := false;
    Exit;
  end
  else
  begin
    PayPanel.Top := PayButton.Top + PayButton.Height - PayPanel.Height;
    PayPanel.Left := PayButton.Left + PayButton.Width + 5;
    PayPanel.Visible := true;
  end;
end;

procedure TDeliveryNew_F.CidReadEvent(const S: String);
  function GetPopUpTop:Integer;
  var I :Integer;
  begin
    For I := 1 to 4 do
    begin
      if Common.DeliveryTel[I].Status = '' then
      begin
        Result := (I * 122)-122+16;
        Break;
      end;
    end;
  end;
  procedure DeleteCidData(S:String);
  var I :Integer;
  begin
    For I := 0 to Common.CidData.Count-1 do
    begin
      if Copy(S,4,12) = Copy(Common.CidData.Strings[I],1,12) then
      begin
        Common.CidData.Delete(I);
        Break;
      end;
    end;
  end;
var vIndex :Integer;
    vDeliveryStep :String;
    vTelNo   :String;
    vDeliveryNo :String;
    vLine :Integer;
begin
  if panManagement.Visible then
    panManagement.Visible := false;

  if not isChanged then
    AllSearchButton.Click;
  vTelNo := Copy(S,4, Length(S)-3);
  vIndex := GetDeliveryOrderDataIndex(vTelNo);
  lblCallLine.Caption  := Format('[ %s회선 ]',[Copy(S,2,1)]);

  //전화가 왔을때
  if (S[3] = 'I') then
  begin
    //배달주문 작성중일때
    if isChanged then
    begin
      //새로부재중전화 리스트에 저장
      Common.AddCidData(S);

      vLine := StrToInt(Copy(S,2,1));
//      FPopUp[vLine].Close(FPopUp[vLine].Caption);
      Common.ClearDeliveryTel(vLine);
//      FPopUp[vLine].PopupStartY := (vLine * 122)-122+16;
      Common.GetDeliveryTelInfo( S );
      //기주문건이면 부재중에서 삭제한다
      if (Common.DeliveryTel[vLine].Status <> '0') or (Common.DeliveryTel[vLine].Status <> '1') then
        DeleteCidData(S);

      isAbsent := true;
//      FPopUp[vLine].Title := Common.DeliveryTel[vLine].Cust + ' ['+Copy(S,2,1)+'회선]';
//      if (Common.DeliveryTel[vLine].Status = '0') or (Common.DeliveryTel[vLine].Status = '1') then
//        FPopUp[vLine].Text  := Common.DeliveryTel[vLine].TelNo + #13 +'(출력)'
//      else
//      begin
//        if Common.DeliveryTel[vLine].Status = 'N' then
//          FPopUp[vLine].Text  := Common.DeliveryTel[vLine].TelNo + #13 +'[미주문]'+#13+'(출력)'
//        else if Common.DeliveryTel[vLine].Status = 'O' then
//          FPopUp[vLine].Text  := Common.DeliveryTel[vLine].TelNo + #13 +'[주문]'+#13+'(출력)'
//        else if Common.DeliveryTel[vLine].Status = 'D' then
//          FPopUp[vLine].Text  := Common.DeliveryTel[vLine].TelNo + #13 +'[배달]'+#13+'(출력)';
//      end;
//      FPopUp[vLine].URL     := '';
//      FPopUp[vLine].TimeOut := 15;
//      FPopUp[vLine].ShowPopUp;
    end
    else
    begin
      //부재중리스트에 있으면 삭제한다
      Common.DeleteCidData(vTelNo);
      //주문된 배달내역에 있는 전화번호인지 체크한다
      if vIndex >= 0 then
      begin
        GridTableView.DataController.FocusedRecordIndex := vIndex;
        vDeliveryStep           := NVL(GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewStatus.Index],'');
        lblCallCustName.Caption := NVL(GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewCustName.Index],'');
        if vDeliveryStep <> msgMissedCall then
          lblCallStatus.Caption   := Format('[%s] 상태의 고객',[vDeliveryStep])
        else if lblCallCustName.Caption <> EmptyStr then
          lblCallStatus.Caption := '신규주문'
        else
          lblCallStatus.Caption :='신규고객';
        lblCallNo.Caption       := SetTelephone(vTelNo);
        vDeliveryNo             := GetOnlyNumber(lblDeliveryNo.Caption);
      end
      else
      begin
        SetCustomerInfo(vTelNo);
        lblCallNo.Caption       := SetTelephone(vTelNo);
        vDeliveryNo             := EmptyStr;
      end;

      Common.AddCidData( S, vDeliveryNo);
      CallStep := csCall;
    end;
  end
  //전화를 받았을때(콜스타)
  else if S[3] = 'S' then
  begin
    if isChanged then Exit;
    //신규배달전화일때
    if (vIndex < 0) then
    begin
      //부재중전화 상태로 변경한다
      ClearDeliveryData;
      Common.DeleteCidData(vTelNo);
      edt_TelNo1.Text := SetTelephone(vTelNo);
      NewButtonClick(nil);
      CallStep := csNone;
    end
    else
    begin
      Common.DeleteCidData(vTelNo);
      if (GridTableView.DataController.Values[vIndex, GridTableViewStatus.Index] = msgMissedCall) or Common.AskBox(Format('현재 [%s] 상태의 고객입니다'#13#13'신규배달로 주문하시겠습니까?',[GridTableView.DataController.Values[vIndex, GridTableViewStatus.Index]]) ) then
      begin
        ClearDeliveryData;
        Common.DeleteCidData(vTelNo);
        edt_TelNo1.Text := SetTelephone(vTelNo);
        NewButtonClick(nil);
        CallStep := csNone;
      end
      else
      begin
        Common.DeleteCidData(vTelNo);
        GridTableView.DataController.FocusedRecordIndex := vIndex;
        CallStep := csNone;
      end;
    end;
  end
  else if (S[3] = 'E') or (S[3] = 'A') then
  begin
     if isChanged or (CallStep = csNone) then Exit;
     vIndex   := GetDeliveryOrderDataIndex(GetOnlyNumber(lblCallNo.Caption));
     if (vIndex < 0) or ((vIndex >= 0) and (GridTableView.DataController.Values[vIndex, GridTableViewStatus.Index] <> msgMissedCall)) and (S[3] = 'A') then
     begin
       GridTableView.DataController.AppendRecord;
       GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewStatus.Index]     := msgMissedCall;
       GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewTelMobile.Index]  := lblCallNo.Caption;
       if vIndex < 0 then
         GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewCustName.Index]   := Ifthen(lblCallCustName.Caption=EmptyStr, '신규고객',lblCallCustName.Caption)
       else
         GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewCustName.Index]   := Format('%s [%s] 중인 고객',[lblCallCustName.Caption,GridTableView.DataController.Values[vIndex, GridTableViewStatus.Index]]);

       MissedCallButton.Status.Caption := FormatFloat('#,0건', Common.CidData.Count);
       GridTableView.DataController.FocusedRecordIndex := GridTableView.DataController.RecordCount-1;
    end;
    CallStep := csNone;
  end;
end;

procedure TDeliveryNew_F.GetDeliveryList;
var vOrderCnt,    vOrderAmt,
    vDeliveryCnt, vDeliveryAmt,
    vReturnCnt,   vReturnAmt,
    vOutTelCnt :Integer;
    vIndex     :Integer;
    vWhere1, vWhere2 :String;
    vRecordIndex :Integer;
begin
  vOrderCnt    := 0; vOrderAmt    := 0;
  vDeliveryCnt := 0; vDeliveryAmt := 0;
  vReturnCnt   := 0; vReturnAmt   := 0;
  vOutTelCnt   := 0;

  panDeliveryInfo.Enabled := false;
  DeliveryGoButton.Enabled   := false;
  DishReturnButton.Enabled   := false;
  DeleteButton.Enabled       := false;

  with GridTableView.DataController do
  begin
    OpenQuery('select a.YMD_DELIVERY, '
             +'       a.NO_DELIVERY, '
             +'       case when ifnull(a.NO_ORDER_BAEMIN,'''') ='''' then case a.DS_ORDER when ''D'' THEN ''배달'' when ''P'' THEN ''포장'' end else ''배달의민족'' end as NM_ORDER, '
             +'       a.DS_STEP, '
             +'       CASE a.DS_STEP when ''N'' then ''미주문'' when ''O'' THEN ''주문'' when ''D'' then ''배달'' when ''A'' then ''계산'' end as NM_STEP, '
             +'       Date_Format(a.DT_ORDER, ''%H:%i'') as ORDER_TIME, '
             +'       a.DT_ORDER, '
             +'       a.DT_DELIVERY, '
             +'       case a.DS_CUSTOMER when ''N'' then ''비회원'' else a.CD_MEMBER end as DS_MEMBER, '
             +'       a.NM_NAME as NM_CUSTOMER, '
             //그릇회수기능 사용여부
             +Ifthen(GetOption(56)='1',' case when a.DS_STEP = ''A'' and a.DS_ORDER = ''D'' then d.AMT_SALE else b.AMT_ORDER end as AMT_ORDER, ',
                                                  ' b.AMT_ORDER, ')
             +'	      case when a.CD_SAWON <> '''' then (select NM_SAWON '
             +'                                            from MS_SAWON '
             +'                                           where CD_STORE =a.CD_STORE '
             +'                                             and CD_SAWON =a.CD_SAWON ) '
             +'	                                   else '''' end DAMDANG, '
             +'       b.NO_TABLE, '
             +'       a.NO_TEL1, '
             +'       a.NO_TEL2, '
             +'       a.NO_TEL3, '
             +'       a.NO_TEL4, '
             +'       a.ADDRESS1, '
             +'       a.ADDRESS2, '
             +'       case  a.PAYTYPE when ''CARD'' then ''신용카드'' when ''CASH'' then ''현금'' when ''ETC'' then ''복합'' else a.PAYTYPE end as PAYTYPE, '
             +'       TIMESTAMPDIFF(MINUTE,  a.DT_ORDER, Now() ) as LAPSE_TIME, '
             +'       a.CD_LOCAL, '
             +'       GetCommonName(a.CD_STORE, ''22'', a.CD_LOCAL) as NM_LOCAL, '
             +'       a.CD_COURSE, '
             +'       GetCommonName(a.CD_STORE, ''20'', a.CD_COURSE) as NM_COURSE, '
             +'       a.NO_ORDER_BAEMIN '
             +'  from SL_DELIVERY a left outer join '
             +'       SL_ORDER_H  b on b.CD_STORE = a.CD_STORE and b.NO_TABLE  = a.NO_TABLE and b.DS_ORDER = ''D'' left outer join '
             +'       MS_MEMBER   c on c.CD_STORE = a.CD_STORE and c.CD_MEMBER = a.CD_MEMBER '
             +Ifthen(GetOption(56)='1','left outer join SL_SALE_H d on d.CD_STORE = a.CD_STORE and d.NO_DELIVERY = ConCat(a.YMD_DELIVERY,a.NO_DELIVERY) ','')
             +' where a.CD_STORE  = :P0 '
             +Ifthen(GetOption(56)='1','and a.DS_STEP in (''N'',''O'',''D'',''A'') order by a.YMD_DELIVERY, a.NO_DELIVERY ', 'and a.DS_STEP in (''N'',''O'',''D'') order by a.YMD_DELIVERY, a.NO_DELIVERY '),
             [Common.Config.StoreCode]);

    vRecordIndex := GridTableView.DataController.GetFocusedRecordIndex;
    BeginUpdate;
    GridTableView.DataController.RecordCount := 0;
    GridTableView.DataController.Filter.Clear;
    GridTableView.DataController.ClearSorting(true);
    while not Common.Query.Eof do
    begin
      GridTableView.DataController.AppendRecord;
      Values[GridTableView.DataController.RecordCount-1, GridTableViewDeliveryNo.Index] := Format('%s-%s',[Common.Query.FieldByName('YMD_DELIVERY').AsString, Common.Query.FieldByName('NO_DELIVERY').AsString]);
      Values[GridTableView.DataController.RecordCount-1, GridTableViewStatus.Index]     := Common.Query.FieldByName('NM_STEP').AsString;
      Values[GridTableView.DataController.RecordCount-1, GridTableViewType.Index]       := Common.Query.FieldByName('NM_ORDER').AsString;
      Values[GridTableView.DataController.RecordCount-1, GridTableViewOrderTime.Index]  := Common.Query.FieldByName('ORDER_TIME').AsString;
      Values[GridTableView.DataController.RecordCount-1, GridTableViewCustName.Index]   := Common.Query.FieldByName('NM_CUSTOMER').AsString;
      Values[GridTableView.DataController.RecordCount-1, GridTableViewTelMobile.Index]  := SetTelephone(Common.Query.FieldByName('NO_TEL1').AsString);
      Values[GridTableView.DataController.RecordCount-1, GridTableViewTelHome.Index]    := SetTelephone(Common.Query.FieldByName('NO_TEL2').AsString);
      Values[GridTableView.DataController.RecordCount-1, GridTableViewTelEtc.Index]     := SetTelephone(Common.Query.FieldByName('NO_TEL3').AsString);
      Values[GridTableView.DataController.RecordCount-1, GridTableViewTelEtc2.Index]    := SetTelephone(Common.Query.FieldByName('NO_TEL4').AsString);
      Values[GridTableView.DataController.RecordCount-1, GridTableViewAddress.Index]    := Format('%s %s',[Common.Query.FieldByName('ADDRESS1').AsString, Common.Query.FieldByName('ADDRESS2').AsString]);
      Values[GridTableView.DataController.RecordCount-1, GridTableViewCourse.Index]     := Common.Query.FieldByName('NM_COURSE').AsString;
      Values[GridTableView.DataController.RecordCount-1, GridTableViewOrderAmt.Index]   := Common.Query.FieldByName('AMT_ORDER').AsInteger;
      Values[GridTableView.DataController.RecordCount-1, GridTableViewElapsedTime.Index]:= Common.Query.FieldByName('LAPSE_TIME').AsInteger;
      Values[GridTableView.DataController.RecordCount-1, GridTableViewAcctType.Index]   := Common.Query.FieldByName('PAYTYPE').AsString;
      Values[GridTableView.DataController.RecordCount-1, GridTableViewDamdang.Index]    := Common.Query.FieldByName('DAMDANG').AsString;
      Values[GridTableView.DataController.RecordCount-1, GridTableViewBaeminOrderNo.Index]    := Common.Query.FieldByName('NO_ORDER_BAEMIN').AsString;

      Inc(vOrderCnt);
      vOrderAmt := vOrderAmt + Common.Query.FieldByName('AMT_ORDER').AsInteger;
      if Common.Query.FieldByName('NM_STEP').AsString = '배달' then
      begin
        Inc(vDeliveryCnt);
        vDeliveryAmt := vDeliveryAmt + Common.Query.FieldByName('AMT_ORDER').AsInteger;
      end;
      if Common.Query.FieldByName('NM_STEP').AsString = '계산' then
      begin
        if Common.Query.FieldByName('NM_ORDER').AsString <> '포장' then
          Inc(vReturnCnt);
        vDeliveryAmt := vDeliveryAmt + Common.Query.FieldByName('AMT_ORDER').AsInteger;
      end;
      Common.Query.Next;
    end;

    SetAbsentCall;
    EndUpdate;
  end;

  if GridTableView.DataController.RecordCount > 0 then
  begin
    if Self.Enabled and Grid.Enabled then
      Grid.SetFocus;
    if (vRecordIndex < GridTableView.DataController.RecordCount) and ( vRecordIndex >= 0) then
      GridTableView.DataController.FocusedRecordIndex := vRecordIndex
    else
      GridTableView.DataController.FocusedRecordIndex :=  GridTableView.DataController.RecordCount-1;
  end;
  isData := GridTableView.DataController.RecordCount > 0;
  isChanged := false;
  NotDishReturnCountLabel.Caption := FormatFloat('#,0건', vReturnCnt);
  MissedCallButton.Status.Caption := FormatFloat('#,0건', Common.CidData.Count);
  GridTableViewStatus.DataBinding.AddToFilter(nil, foNotEqual, '계산');
  GridTableView.DataController.Filter.Active := true;
end;

procedure TDeliveryNew_F.GridTableViewFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord;
  ANewItemRecordFocusingChanged: Boolean);
begin
  if isLoading then Exit;
  isChanged := false;
  isNew     := false;
  if GridTableView.DataController.GetFocusedRecordIndex < 0 then
  begin
    ClearDeliveryData;
    panDeliveryInfo.Enabled := false;
    Exit;
  end;
  if GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewStatus.Index] = msgMissedCall then
  begin
    ClearDeliveryData;
    DeleteButton.Enabled       := true;
    Exit;
  end;

  SetDeliveryDisplay;
end;
procedure TDeliveryNew_F.SetDeliveryStep(const Value: TDeliveryStep);
begin
  FDeliveryStep := Value;
  case FDeliveryStep of
    dsNone        :
    begin
      lblDeliveryStatus.Caption := '미주문';
      SaveButton.Enabled           := True;
      OrderButton.Enabled          := True;
      DeliveryGoButton.Enabled     := False;
      DishReturnButton.Enabled     := False;
      ReprintButton.Enabled        := False;
    end;
    dsOrder       :
    begin
      lblDeliveryStatus.Caption := '주문';
      SaveButton.Enabled           := True;
      OrderButton.Enabled          := True;
      DeliveryGoButton.Enabled     := True;
      DishReturnButton.Enabled     := False;
      ReprintButton.Enabled        := True;
      FDeliveryMan              := '';
      lblDeliveryDamdang.Caption:= '';
    end;
    dsDelivery    :
    begin
      lblDeliveryStatus.Caption := Format('배달 [%s]',[FormatDateTime('hh:nn', FDeliveryDate)]);
      SaveButton.Enabled           := True;
      OrderButton.Enabled          := True;
      DeliveryGoButton.Enabled     := True;
      DishReturnButton.Enabled     := False;
      ReprintButton.Enabled        := True;
    end;
    dsAccount     :
    begin
      lblDeliveryStatus.Caption := '계산';
      SaveButton.Enabled           := True;
      OrderButton.Enabled          := False;
      DeliveryGoButton.Enabled     := False;
      DishReturnButton.Enabled     := True;
      ReprintButton.Enabled        := False;
    end;
    dsDishReturn  :
    begin
      lblDeliveryStatus.Caption := '그룻회수';
      SaveButton.Enabled           := True;
      OrderButton.Enabled          := False;
      DeliveryGoButton.Enabled     := False;
      DishReturnButton.Enabled     := False;
      //그릇회수 시 담당자를 사용할때
      if GetOption(144) = '1' then
        GetRecallMan;
      ReprintButton.Enabled        := False;
    end;
    dsCancel      :
    begin
      lblDeliveryStatus.Caption := '취소';
      SaveButton.Enabled           := False;
      OrderButton.Enabled          := False;
      DeliveryGoButton.Enabled     := False;
      DishReturnButton.Enabled     := False;
      ReprintButton.Enabled        := False;
    end;
  end;
end;

procedure TDeliveryNew_F.SetForm;
begin
  if Self.Width = 1280 then
  begin
    panDeliveryInfo.Top    := 56;
    panDeliveryInfo.Left   := 770;
    panDeliveryInfo.Width  := 502;
    panDeliveryInfo.Height := 622;
    edt_CustName.Top    := 114;
    edt_CustName.Left   := 84;
    edt_CustName.Width  := 197;
    edt_CustName.Height := 32;
    edt_CustName.Style.Font.Size := 11;
    edt_TelNo1.Top    := 152;
    edt_TelNo1.Left   := 84;
    edt_TelNo1.Width  := 197;
    edt_TelNo1.Height := 32;
    edt_TelNo1.Style.Font.Size := 11;
    edt_TelNo2.Top    := 190;
    edt_TelNo2.Left   := 84;
    edt_TelNo2.Width  := 196;
    edt_TelNo2.Height := 32;
    edt_TelNo2.Style.Font.Size := 11;
    edt_TelNo3.Top    := 229;
    edt_TelNo3.Left   := 84;
    edt_TelNo3.Width  := 195;
    edt_TelNo3.Height := 32;
    edt_TelNo3.Style.Font.Size := 11;
    edt_TelNo4.Top    := 228;
    edt_TelNo4.Left   := 290;
    edt_TelNo4.Width  := 205;
    edt_TelNo4.Height := 32;
    edt_TelNo4.Style.Font.Size := 11;
    edt_Address1.Top    := 268;
    edt_Address1.Left   := 84;
    edt_Address1.Width  := 411;
    edt_Address1.Height := 32;
    edt_Address1.Style.Font.Size := 11;
    edt_Address2.Top    := 304;
    edt_Address2.Left   := 84;
    edt_Address2.Width  := 411;
    edt_Address2.Height := 32;
    edt_Address2.Style.Font.Size := 11;
    meo_Remark.Top    := 479;
    meo_Remark.Left   := 84;
    meo_Remark.Width  := 409;
    meo_Remark.Height := 82;
    meo_Remark.Style.Font.Size := 9;
    lblDeliveryNo.Top    := 11;
    lblDeliveryNo.Left   := 84;
    lblDeliveryNo.Width  := 117;
    lblDeliveryNo.Height := 28;
    lblDeliveryNo.Style.Font.Size := 11;
    lblOrderDate.Top    := 12;
    lblOrderDate.Left   := 292;
    lblOrderDate.Width  := 202;
    lblOrderDate.Height := 28;
    lblOrderDate.Style.Font.Size := 11;
    lblDeliveryStatus.Top    := 45;
    lblDeliveryStatus.Left   := 84;
    lblDeliveryStatus.Width  := 117;
    lblDeliveryStatus.Height := 28;
    lblDeliveryStatus.Style.Font.Size := 11;
    lblDeliveryDamdang.Top    := 45;
    lblDeliveryDamdang.Left   := 292;
    lblDeliveryDamdang.Width  := 97;
    lblDeliveryDamdang.Height := 28;
    lblDeliveryDamdang.Style.Font.Size := 11;
    lbl_Member.Top    := 78;
    lbl_Member.Left   := 84;
    lbl_Member.Width  := 306;
    lbl_Member.Height := 30;
    lbl_Member.Style.Font.Size := 11;
    PostButton.Top    := 266;
    PostButton.Left   := 4;
    PostButton.Width  := 76;
    PostButton.Height := 72;
    PostButton.Appearance.Font.Size := 11;
    SearchButton.Top    := 147;
    SearchButton.Left   := 290;
    SearchButton.Width  := 97;
    SearchButton.Height := 75;
    SearchButton.Appearance.Font.Size := 11;
    MemberSaveButton.Top    := 149;
    MemberSaveButton.Left   := 399;
    MemberSaveButton.Width  := 98;
    MemberSaveButton.Height := 73;
    MemberSaveButton.Appearance.Font.Size := 11;
    MemberSearchButton.Top    := 75;
    MemberSearchButton.Left   := 395;
    MemberSearchButton.Width  := 101;
    MemberSearchButton.Height := 37;
    MemberSearchButton.Appearance.Font.Size := 11;
    DeliveryNoLabel.Top    := 13;
    DeliveryNoLabel.Left   := 10;
    DeliveryNoLabel.Width  := 68;
    DeliveryNoLabel.Height := 25;
    DeliveryNoLabel.Style.Font.Size := 12;
    cxLabel7.Top    := 48;
    cxLabel7.Left   := 8;
    cxLabel7.Width  := 68;
    cxLabel7.Height := 25;
    cxLabel7.Style.Font.Size := 12;
    DeliveryOrderTimeLabel.Top    := 14;
    DeliveryOrderTimeLabel.Left   := 216;
    DeliveryOrderTimeLabel.Width  := 68;
    DeliveryOrderTimeLabel.Height := 25;
    DeliveryOrderTimeLabel.Style.Font.Size := 12;
    DeliveryDamdangLabel.Top    := 46;
    DeliveryDamdangLabel.Left   := 216;
    DeliveryDamdangLabel.Width  := 68;
    DeliveryDamdangLabel.Height := 25;
    DeliveryDamdangLabel.Style.Font.Size := 12;
    DeliveryMemberLabel.Top    := 83;
    DeliveryMemberLabel.Left   := 8;
    DeliveryMemberLabel.Width  := 68;
    DeliveryMemberLabel.Height := 25;
    DeliveryMemberLabel.Style.Font.Size := 12;
    GuestNameLabel.Top    := 114;
    GuestNameLabel.Left   := 9;
    GuestNameLabel.Width  := 64;
    GuestNameLabel.Height := 25;
    GuestNameLabel.Style.Font.Size := 12;
    TelNo1Label.Top    := 153;
    TelNo1Label.Left   := 8;
    TelNo1Label.Width  := 71;
    TelNo1Label.Height := 25;
    TelNo1Label.Style.Font.Size := 12;
    TelNo2Label.Top    := 190;
    TelNo2Label.Left   := 8;
    TelNo2Label.Width  := 71;
    TelNo2Label.Height := 25;
    TelNo2Label.Style.Font.Size := 12;
    TelNo3Label.Top    := 228;
    TelNo3Label.Left   := 7;
    TelNo3Label.Width  := 71;
    TelNo3Label.Height := 25;
    TelNo3Label.Style.Font.Size := 12;
    MapButton.Top    := 342;
    MapButton.Left   := 401;
    MapButton.Width  := 93;
    MapButton.Height := 37;
    MapButton.Appearance.Font.Size := 11;
    CouponButton.Top    := 342;
    CouponButton.Left   := 305;
    CouponButton.Width  := 92;
    CouponButton.Height := 37;
    CouponButton.Appearance.Font.Size := 11;
    DeliveryButton.Top    := 342;
    DeliveryButton.Left   := 87;
    DeliveryButton.Width  := 64;
    DeliveryButton.Height := 37;
    DeliveryButton.Appearance.Font.Size := 11;
    PackingButton.Top    := 342;
    PackingButton.Left   := 156;
    PackingButton.Width  := 67;
    PackingButton.Height := 37;
    PackingButton.Appearance.Font.Size := 11;
    LocalButton.Top    := 384;
    LocalButton.Left   := 305;
    LocalButton.Width  := 92;
    LocalButton.Height := 34;
    LocalButton.Appearance.Font.Size := 11;
    CourseButton.Top    := 385;
    CourseButton.Left   := 87;
    CourseButton.Width  := 107;
    CourseButton.Height := 35;
    CourseButton.Appearance.Font.Size := 11;
    OrderTypeLabel.Top    := 346;
    OrderTypeLabel.Left   := 9;
    OrderTypeLabel.Width  := 68;
    OrderTypeLabel.Height := 25;
    OrderTypeLabel.Style.Font.Size := 12;
    CouponLabel.Top    := 349;
    CouponLabel.Left   := 254;
    CouponLabel.Width  := 36;
    CouponLabel.Height := 25;
    CouponLabel.Style.Font.Size := 12;
    CourseLabel.Top    := 391;
    CourseLabel.Left   := 8;
    CourseLabel.Width  := 68;
    CourseLabel.Height := 25;
    CourseLabel.Style.Font.Size := 12;
    LocalLabel.Top    := 386;
    LocalLabel.Left   := 221;
    LocalLabel.Width  := 68;
    LocalLabel.Height := 25;
    LocalLabel.Style.Font.Size := 12;
    PayButton.Top    := 436;
    PayButton.Left   := 86;
    PayButton.Width  := LocalButton.Width;
    PayButton.Height := 38;
    PayButton.Appearance.Font.Size := 11;
    PayTypeLabel.Top    := 440;
    PayTypeLabel.Left   := 8;
    PayTypeLabel.Width  := 68;
    PayTypeLabel.Height := 25;
    PayTypeLabel.Style.Font.Size := 12;
    RequestItemButton.Top    := 480;
    RequestItemButton.Left   := 6;
    RequestItemButton.Width  := 74;
    RequestItemButton.Height := 81;
    RequestItemButton.Appearance.Font.Size := 9;
    CancelButton.Top    := 567;
    CancelButton.Left   := 6;
    CancelButton.Width  := 104;
    CancelButton.Height := 48;
    CancelButton.Appearance.Font.Size := 11;
    OrderButton.Top    := 567;
    OrderButton.Left   := 115;
    OrderButton.Width  := 262;
    OrderButton.Height := 48;
    OrderButton.Appearance.Font.Size := 11;
    SaveButton.Top    := 567;
    SaveButton.Left   := 389;
    SaveButton.Width  := 105;
    SaveButton.Height := 48;
    SaveButton.Appearance.Font.Size := 11;
    OrderGrid.Top    := 682;
    OrderGrid.Left   := 771;
    OrderGrid.Width  := 502;
    OrderGrid.Height := 284;
  end
  else if Self.Width = 1920 then
  begin
    panDeliveryInfo.Top    := 58;
    panDeliveryInfo.Left   := 1383;
    panDeliveryInfo.Width  := 527;
    panDeliveryInfo.Height := 624;
    edt_CustName.Top    := 114;
    edt_CustName.Left   := 84;
    edt_CustName.Width  := 197;
    edt_CustName.Height := 32;
    edt_CustName.Style.Font.Size := 11;
    edt_TelNo1.Top    := 152;
    edt_TelNo1.Left   := 84;
    edt_TelNo1.Width  := 197;
    edt_TelNo1.Height := 32;
    edt_TelNo1.Style.Font.Size := 11;
    edt_TelNo2.Top    := 190;
    edt_TelNo2.Left   := 84;
    edt_TelNo2.Width  := 196;
    edt_TelNo2.Height := 32;
    edt_TelNo2.Style.Font.Size := 11;
    edt_TelNo3.Top    := 229;
    edt_TelNo3.Left   := 84;
    edt_TelNo3.Width  := 195;
    edt_TelNo3.Height := 32;
    edt_TelNo3.Style.Font.Size := 11;
    edt_TelNo4.Top    := 228;
    edt_TelNo4.Left   := 290;
    edt_TelNo4.Width  := 207;
    edt_TelNo4.Height := 32;
    edt_TelNo4.Style.Font.Size := 11;
    edt_Address1.Top    := 268;
    edt_Address1.Left   := 84;
    edt_Address1.Width  := 411;
    edt_Address1.Height := 32;
    edt_Address1.Style.Font.Size := 11;
    edt_Address2.Top    := 304;
    edt_Address2.Left   := 84;
    edt_Address2.Width  := 411;
    edt_Address2.Height := 32;
    edt_Address2.Style.Font.Size := 11;
    meo_Remark.Top    := 479;
    meo_Remark.Left   := 84;
    meo_Remark.Width  := 431;
    meo_Remark.Height := 82;
    meo_Remark.Style.Font.Size := 9;
    lblDeliveryNo.Top    := 11;
    lblDeliveryNo.Left   := 84;
    lblDeliveryNo.Width  := 128;
    lblDeliveryNo.Height := 28;
    lblDeliveryNo.Style.Font.Size := 11;
    lblOrderDate.Top    := 12;
    lblOrderDate.Left   := 311;
    lblOrderDate.Width  := 202;
    lblOrderDate.Height := 28;
    lblOrderDate.Style.Font.Size := 11;
    lblDeliveryStatus.Top    := 45;
    lblDeliveryStatus.Left   := 84;
    lblDeliveryStatus.Width  := 109;
    lblDeliveryStatus.Height := 28;
    lblDeliveryStatus.Style.Font.Size := 11;
    lblDeliveryDamdang.Top    := 45;
    lblDeliveryDamdang.Left   := 311;
    lblDeliveryDamdang.Width  := 97;
    lblDeliveryDamdang.Height := 28;
    lblDeliveryDamdang.Style.Font.Size := 11;
    lbl_Member.Top    := 78;
    lbl_Member.Left   := 84;
    lbl_Member.Width  := 306;
    lbl_Member.Height := 30;
    lbl_Member.Style.Font.Size := 11;
    PostButton.Top    := 266;
    PostButton.Left   := 4;
    PostButton.Width  := 76;
    PostButton.Height := 72;
    PostButton.Appearance.Font.Size := 11;
    SearchButton.Top    := 147;
    SearchButton.Left   := 290;
    SearchButton.Width  := 97;
    SearchButton.Height := 75;
    SearchButton.Appearance.Font.Size := 11;
    MemberSaveButton.Top    := 149;
    MemberSaveButton.Left   := 399;
    MemberSaveButton.Width  := 98;
    MemberSaveButton.Height := 73;
    MemberSaveButton.Appearance.Font.Size := 11;
    MemberSearchButton.Top    := 75;
    MemberSearchButton.Left   := 395;
    MemberSearchButton.Width  := 101;
    MemberSearchButton.Height := 37;
    MemberSearchButton.Appearance.Font.Size := 11;
    DeliveryNoLabel.Top    := 13;
    DeliveryNoLabel.Left   := 10;
    DeliveryNoLabel.Width  := 68;
    DeliveryNoLabel.Height := 25;
    DeliveryNoLabel.Style.Font.Size := 12;
    cxLabel7.Top    := 48;
    cxLabel7.Left   := 8;
    cxLabel7.Width  := 68;
    cxLabel7.Height := 25;
    cxLabel7.Style.Font.Size := 12;
    DeliveryOrderTimeLabel.Top    := 14;
    DeliveryOrderTimeLabel.Left   := 235;
    DeliveryOrderTimeLabel.Width  := 68;
    DeliveryOrderTimeLabel.Height := 25;
    DeliveryOrderTimeLabel.Style.Font.Size := 12;
    DeliveryDamdangLabel.Top    := 46;
    DeliveryDamdangLabel.Left   := 235;
    DeliveryDamdangLabel.Width  := 68;
    DeliveryDamdangLabel.Height := 25;
    DeliveryDamdangLabel.Style.Font.Size := 12;
    DeliveryMemberLabel.Top    := 83;
    DeliveryMemberLabel.Left   := 8;
    DeliveryMemberLabel.Width  := 68;
    DeliveryMemberLabel.Height := 25;
    DeliveryMemberLabel.Style.Font.Size := 12;
    GuestNameLabel.Top    := 114;
    GuestNameLabel.Left   := 9;
    GuestNameLabel.Width  := 64;
    GuestNameLabel.Height := 25;
    GuestNameLabel.Style.Font.Size := 12;
    TelNo1Label.Top    := 153;
    TelNo1Label.Left   := 8;
    TelNo1Label.Width  := 71;
    TelNo1Label.Height := 25;
    TelNo1Label.Style.Font.Size := 12;
    TelNo2Label.Top    := 190;
    TelNo2Label.Left   := 8;
    TelNo2Label.Width  := 71;
    TelNo2Label.Height := 25;
    TelNo2Label.Style.Font.Size := 12;
    TelNo3Label.Top    := 228;
    TelNo3Label.Left   := 7;
    TelNo3Label.Width  := 71;
    TelNo3Label.Height := 25;
    TelNo3Label.Style.Font.Size := 12;
    MapButton.Top    := 342;
    MapButton.Left   := 414;
    MapButton.Width  := 102;
    MapButton.Height := 37;
    MapButton.Appearance.Font.Size := 11;
    CouponButton.Top    := 342;
    CouponButton.Left   := 305;
    CouponButton.Width  := 96;
    CouponButton.Height := 37;
    CouponButton.Appearance.Font.Size := 11;
    DeliveryButton.Top    := 342;
    DeliveryButton.Left   := 87;
    DeliveryButton.Width  := 64;
    DeliveryButton.Height := 37;
    DeliveryButton.Appearance.Font.Size := 11;
    PackingButton.Top    := 342;
    PackingButton.Left   := 156;
    PackingButton.Width  := 67;
    PackingButton.Height := 37;
    PackingButton.Appearance.Font.Size := 11;
    LocalButton.Top    := 384;
    LocalButton.Left   := 305;
    LocalButton.Width  := 114;
    LocalButton.Height := 34;
    LocalButton.Appearance.Font.Size := 11;
    CourseButton.Top    := 385;
    CourseButton.Left   := 87;
    CourseButton.Width  := 107;
    CourseButton.Height := 35;
    CourseButton.Appearance.Font.Size := 11;
    OrderTypeLabel.Top    := 346;
    OrderTypeLabel.Left   := 9;
    OrderTypeLabel.Width  := 68;
    OrderTypeLabel.Height := 25;
    OrderTypeLabel.Style.Font.Size := 12;
    CouponLabel.Top    := 349;
    CouponLabel.Left   := 254;
    CouponLabel.Width  := 36;
    CouponLabel.Height := 25;
    CouponLabel.Style.Font.Size := 12;
    CourseLabel.Top    := 391;
    CourseLabel.Left   := 8;
    CourseLabel.Width  := 68;
    CourseLabel.Height := 25;
    CourseLabel.Style.Font.Size := 12;
    LocalLabel.Top    := 386;
    LocalLabel.Left   := 221;
    LocalLabel.Width  := 68;
    LocalLabel.Height := 25;
    LocalLabel.Style.Font.Size := 12;
    PayButton.Top    := 436;
    PayButton.Left   := 86;
    PayButton.Width  := LocalButton.Width;
    PayButton.Height := 38;
    PayButton.Appearance.Font.Size := 11;
    PayTypeLabel.Top    := 440;
    PayTypeLabel.Left   := 8;
    PayTypeLabel.Width  := 68;
    PayTypeLabel.Height := 25;
    PayTypeLabel.Style.Font.Size := 12;
    RequestItemButton.Top    := 480;
    RequestItemButton.Left   := 6;
    RequestItemButton.Width  := 74;
    RequestItemButton.Height := 81;
    RequestItemButton.Appearance.Font.Size := 9;
    CancelButton.Top    := 567;
    CancelButton.Left   := 6;
    CancelButton.Width  := 104;
    CancelButton.Height := 48;
    CancelButton.Appearance.Font.Size := 11;
    OrderButton.Top    := 567;
    OrderButton.Left   := 115;
    OrderButton.Width  := 288;
    OrderButton.Height := 48;
    OrderButton.Appearance.Font.Size := 11;
    SaveButton.Top    := 567;
    SaveButton.Left   := 411;
    SaveButton.Width  := 105;
    SaveButton.Height := 48;
    SaveButton.Appearance.Font.Size := 11;
    OrderGrid.Top    := 688;
    OrderGrid.Left   := 1383;
    OrderGrid.Width  := 527;
    OrderGrid.Height := 340;
  end
  else //  if Self.Width = 1024 then
  begin
    panDeliveryInfo.Top    := 58;
    panDeliveryInfo.Left   := 612;
    panDeliveryInfo.Width  := 402;
    panDeliveryInfo.Height := 485;
    edt_CustName.Top    := 87;
    edt_CustName.Left   := 65;
    edt_CustName.Width  := 147;
    edt_CustName.Height := 25;
    edt_CustName.Style.Font.Size := 9;
    edt_TelNo1.Top    := 115;
    edt_TelNo1.Left   := 65;
    edt_TelNo1.Width  := 147;
    edt_TelNo1.Height := 25;
    edt_TelNo1.Style.Font.Size := 9;
    edt_TelNo2.Top    := 143;
    edt_TelNo2.Left   := 65;
    edt_TelNo2.Width  := 147;
    edt_TelNo2.Height := 25;
    edt_TelNo2.Style.Font.Size := 9;
    edt_TelNo3.Top    := 171;
    edt_TelNo3.Left   := 65;
    edt_TelNo3.Width  := 147;
    edt_TelNo3.Height := 25;
    edt_TelNo3.Style.Font.Size := 9;
    edt_TelNo4.Top    := 171;
    edt_TelNo4.Left   := 215;
    edt_TelNo4.Width  := 149;
    edt_TelNo4.Height := 25;
    edt_TelNo4.Style.Font.Size := 9;
    edt_Address1.Top    := 199;
    edt_Address1.Left   := 65;
    edt_Address1.Width  := 299;
    edt_Address1.Height := 25;
    edt_Address1.Style.Font.Size := 9;
    edt_Address2.Top    := 227;
    edt_Address2.Left   := 65;
    edt_Address2.Width  := 299;
    edt_Address2.Height := 25;
    edt_Address2.Style.Font.Size := 9;
    meo_Remark.Top    := 363;
    meo_Remark.Left   := 66;
    meo_Remark.Width  := 329;
    meo_Remark.Height := 69;
    meo_Remark.Style.Font.Size := 9;
    lblDeliveryNo.Top    := 5;
    lblDeliveryNo.Left   := 65;
    lblDeliveryNo.Width  := 95;
    lblDeliveryNo.Height := 24;
    lblDeliveryNo.Style.Font.Size := 10;
    lblOrderDate.Top    := 5;
    lblOrderDate.Left   := 228;
    lblOrderDate.Width  := 163;
    lblOrderDate.Height := 24;
    lblOrderDate.Style.Font.Size := 10;
    lblDeliveryStatus.Top    := 32;
    lblDeliveryStatus.Left   := 65;
    lblDeliveryStatus.Width  := 76;
    lblDeliveryStatus.Height := 24;
    lblDeliveryStatus.Style.Font.Size := 10;
    lblDeliveryDamdang.Top    := 32;
    lblDeliveryDamdang.Left   := 227;
    lblDeliveryDamdang.Width  := 45;
    lblDeliveryDamdang.Height := 24;
    lblDeliveryDamdang.Style.Font.Size := 10;
    lbl_Member.Top    := 60;
    lbl_Member.Left   := 65;
    lbl_Member.Width  := 231;
    lbl_Member.Height := 24;
    lbl_Member.Style.Font.Size := 10;
    PostButton.Top    := 197;
    PostButton.Left   := 3;
    PostButton.Width  := 57;
    PostButton.Height := 55;
    PostButton.Appearance.Font.Size := 9;
    SearchButton.Top    := 85;
    SearchButton.Left   := 220;
    SearchButton.Width  := 73;
    SearchButton.Height := 80;
    SearchButton.Appearance.Font.Size := 9;
    MemberSaveButton.Top    := 85;
    MemberSaveButton.Left   := 300;
    MemberSaveButton.Width  := 93;
    MemberSaveButton.Height := 80;
    MemberSaveButton.Appearance.Font.Size := 9;
    MemberSearchButton.Top    := 42;
    MemberSearchButton.Left   := 300;
    MemberSearchButton.Width  := 93;
    MemberSearchButton.Height := 37;
    MemberSearchButton.Appearance.Font.Size := 9;
    DeliveryNoLabel.Top    := 8;
    DeliveryNoLabel.Left   := 4;
    DeliveryNoLabel.Width  := 56;
    DeliveryNoLabel.Height := 21;
    DeliveryNoLabel.Style.Font.Size := 10;
    cxLabel7.Top    := 33;
    cxLabel7.Left   := 4;
    cxLabel7.Width  := 56;
    cxLabel7.Height := 21;
    cxLabel7.Style.Font.Size := 10;
    DeliveryOrderTimeLabel.Top    := 7;
    DeliveryOrderTimeLabel.Left   := 170;
    DeliveryOrderTimeLabel.Width  := 56;
    DeliveryOrderTimeLabel.Height := 21;
    DeliveryOrderTimeLabel.Style.Font.Size := 10;
    DeliveryDamdangLabel.Top    := 34;
    DeliveryDamdangLabel.Left   := 169;
    DeliveryDamdangLabel.Width  := 56;
    DeliveryDamdangLabel.Height := 21;
    DeliveryDamdangLabel.Style.Font.Size := 10;
    DeliveryMemberLabel.Top    := 60;
    DeliveryMemberLabel.Left   := 4;
    DeliveryMemberLabel.Width  := 56;
    DeliveryMemberLabel.Height := 21;
    DeliveryMemberLabel.Style.Font.Size := 10;
    GuestNameLabel.Top    := 87;
    GuestNameLabel.Left   := 4;
    GuestNameLabel.Width  := 53;
    GuestNameLabel.Height := 21;
    GuestNameLabel.Style.Font.Size := 10;
    TelNo1Label.Top    := 116;
    TelNo1Label.Left   := 4;
    TelNo1Label.Width  := 59;
    TelNo1Label.Height := 21;
    TelNo1Label.Style.Font.Size := 10;
    TelNo2Label.Top    := 143;
    TelNo2Label.Left   := 4;
    TelNo2Label.Width  := 59;
    TelNo2Label.Height := 21;
    TelNo2Label.Style.Font.Size := 10;
    TelNo3Label.Top    := 170;
    TelNo3Label.Left   := 4;
    TelNo3Label.Width  := 59;
    TelNo3Label.Height := 21;
    TelNo3Label.Style.Font.Size := 10;
    MapButton.Top    := 255;
    MapButton.Left   := 310;
    MapButton.Width  := 83;
    MapButton.Height := 34;
    MapButton.Appearance.Font.Size := 9;
    CouponButton.Top    := 255;
    CouponButton.Left   := 241;
    CouponButton.Width  := 66;
    CouponButton.Height := 34;
    CouponButton.Appearance.Font.Size := 9;
    DeliveryButton.Top    := 255;
    DeliveryButton.Left   := 65;
    DeliveryButton.Width  := 64;
    DeliveryButton.Height := 34;
    DeliveryButton.Appearance.Font.Size := 9;
    PackingButton.Top    := 255;
    PackingButton.Left   := 128;
    PackingButton.Width  := 64;
    PackingButton.Height := 34;
    PackingButton.Appearance.Font.Size := 9;
    LocalButton.Top    := 292;
    LocalButton.Left   := 240;
    LocalButton.Width  := 84;
    LocalButton.Height := 31;
    LocalButton.Appearance.Font.Size := 9;
    CourseButton.Top    := 292;
    CourseButton.Left   := 64;
    CourseButton.Width  := 107;
    CourseButton.Height := 32;
    CourseButton.Appearance.Font.Size := 9;
    OrderTypeLabel.Top    := 260;
    OrderTypeLabel.Left   := 6;
    OrderTypeLabel.Width  := 56;
    OrderTypeLabel.Height := 21;
    OrderTypeLabel.Style.Font.Size := 10;
    CouponLabel.Top    := 262;
    CouponLabel.Left   := 208;
    CouponLabel.Width  := 30;
    CouponLabel.Height := 21;
    CouponLabel.Style.Font.Size := 10;
    CourseLabel.Top    := 296;
    CourseLabel.Left   := 6;
    CourseLabel.Width  := 56;
    CourseLabel.Height := 21;
    CourseLabel.Style.Font.Size := 10;
    LocalLabel.Top    := 296;
    LocalLabel.Left   := 182;
    LocalLabel.Width  := 56;
    LocalLabel.Height := 21;
    LocalLabel.Style.Font.Size := 10;
    PayButton.Top    := 330;
    PayButton.Left   := 64;
    PayButton.Width  := LocalButton.Width;
    PayButton.Height := 32;
    PayButton.Appearance.Font.Size := 10;
    PayTypeLabel.Top    := 334;
    PayTypeLabel.Left   := 7;
    PayTypeLabel.Width  := 56;
    PayTypeLabel.Height := 21;
    PayTypeLabel.Style.Font.Size := 10;
    RequestItemButton.Top    := 361;
    RequestItemButton.Left   := 4;
    RequestItemButton.Width  := 59;
    RequestItemButton.Height := 70;
    RequestItemButton.Appearance.Font.Size := 9;
    CancelButton.Top    := 438;
    CancelButton.Left   := 4;
    CancelButton.Width  := 93;
    CancelButton.Height := 40;
    CancelButton.Appearance.Font.Size := 11;
    OrderButton.Top    := 438;
    OrderButton.Left   := 103;
    OrderButton.Width  := 191;
    OrderButton.Height := 40;
    OrderButton.Appearance.Font.Size := 11;
    SaveButton.Top    := 438;
    SaveButton.Left   := 302;
    SaveButton.Width  := 93;
    SaveButton.Height := 40;
    SaveButton.Appearance.Font.Size := 11;
    OrderGrid.Top    := 548;
    OrderGrid.Left   := 614;
    OrderGrid.Width  := 400;
    OrderGrid.Height := Self.Height - OrderGrid.Top - 55;
  end;

  Grid.Left            := 132;
  Grid.Height          := Self.Height - Grid.Top - 55;
  Grid.Width           := Self.Width  - Grid.Left - panDeliveryInfo.Width - 20;
  ButtonPanel.Top      := 180;
  ButtonPanel.Left     := 8;
  ButtonPanel.Height   := Self.Height - ButtonPanel.Top - 55;
  panDeliveryInfo.Top  := Grid.Top;
  panDeliveryInfo.Left := Grid.Left + Grid.Width + 10;
  OrderGrid.Left       := Grid.Left + Grid.Width + 10;
  OrderGrid.Top        := panDeliveryInfo.Top + panDeliveryInfo.Height + 5;

  ViewModeButton.Left := panDeliveryInfo.Left;

  MessageImage.Top    := Self.Height - 41;
  MessageLabel.Top    := Self.Height - 41;
  MessageLabel.Width  := Grid.Width;
  lblWork.Top         := Self.Height - 41;

  lblWork.Left        := OrderGrid.Left;
  lblWork.Width       := OrderGrid.Width;
  if GetOption(56) = '1' then
  begin
    NotDishReturnImage.Visible := true;
    lblWork.Width           := OrderGrid.Width div 2;
    NotDishReturnImage.Top  := lblWork.Top + 5;
    NotDishReturnImage.Left := lblWork.Left + lblWork.Width + 10;
    NotDishReturnLabel.Top  := lblWork.Top + 5;
    NotDishReturnLabel.Left := lblWork.Left + lblWork.Width + 50;
    NotDishReturnCountLabel.Top  := lblWork.Top + 5;
    NotDishReturnCountLabel.Left := NotDishReturnLabel.Left + NotDishReturnLabel.Width;
  end;
end;

procedure TDeliveryNew_F.SetFunctionButton;
  function FindButton(aTag:Integer):TAdvGlassButton;
  var vIndex :Integer;
  begin
    Result := nil;
    for vIndex := 0 to ButtonPanel.ControlCount-1 do
      if ButtonPanel.Controls[vIndex] is TAdvGlassButton then
      begin
        if not TAdvGlassButton(ButtonPanel.Controls[vIndex]).Visible then Continue;
        if TAdvGlassButton(ButtonPanel.Controls[vIndex]).Tag = aTag then
        begin
          Result := TAdvGlassButton(ButtonPanel.Controls[vIndex]);
          Break;
        end;
      end;
  end;
var vIndex, vHeight, vTop, vCount, vPanelHeight, vGap :Integer;
    vButton : TAdvGlassButton;
begin
  TakeOutButton.Visible := Common.Config.IsTakeOut;

  //그릇회수기능을 사용하지 않을 때
  if GetOption(56) = '0' then
  begin
    DishReturnButton.Visible  := false;
    DishListButton.Visible    := false;
    vCount := 7;
  end
  else
    vCount := 9;

  vCount := vCount - Ifthen(TakeOutButton.Visible,0,1);

  vHeight := ButtonPanel.Height div vCount - 3;

  vTop    := 0;
  // 디자인 버튼 크기를 재조정한다

  for vIndex := 1 to 9 do
  begin
    vButton := FindButton(vIndex);
    if vButton = nil then Continue;
    vButton.Width  :=  ButtonPanel.Width;
    vButton.Height := vHeight;
    vButton.Top    := vTop;
    vButton.Left   := 0;
    vPanelHeight   := vHeight + vTop;
    vTop := vTop + vHeight + 3;
  end;

  vGap := ButtonPanel.Height - vPanelHeight - 4;

  for vIndex := 1 to 9 do
  begin
    vButton := FindButton(vIndex);
    if vButton = nil then Continue;
    vButton.Top    := vButton.Top + vGap;
    if Self.Width <> 1024 then
      vButton.Layout := AdvGlowButton.blGlyphTop;

    //다크모드
    if GetOption(18) = '1' then
    begin
      ButtonPanel.ParentBackground  := false;
      ButtonPanel.ParentColor       := false;
      ButtonPanel.Color             := clBlack;
      ButtonPanel.Color             := clBlack;
      vButton.Font.Color            := clWhite;
      vButton.BackColor             := clBlack;
      vButton.InnerBorderColor      := clBlack;
      vButton.OuterBorderColor      := clBlack;
      vButton.ShineColor            := clBlack;
    end;
  end;
end;

procedure TDeliveryNew_F.SetMemberCode(AValue: String);
begin
  FMemberCode := AValue;
  edt_TelNo2.Enabled := FMemberCode <> EmptyStr;
  edt_TelNo3.Enabled := FMemberCode <> EmptyStr;
  edt_TelNo4.Enabled := FMemberCode <> EmptyStr;
end;


procedure TDeliveryNew_F.GetOrderMenu;
var vSeq :Integer;
begin
  FDCAmount := 0;
  if DeliveryStep in [dsAccount, dsDishReturn] then
  begin
    FOrderAmt := 0;
    //기존주문내역을 불러온다
    with OrderTableView.DataController do
    begin
      OpenQuery('select a.CD_MENU, '
               +'       c.NM_MENU, '
               +'       a.QTY_SALE as QTY_ORDER, '
               +'       a.PR_SALE, '
               +'       c.PR_SALE as PR_SALE_ORG, '
               +'       c.DS_MENU_TYPE, '
               +'       a.AMT_SALE, '
               +'       a.DC_TOT, '
               +'       c.DS_MENU_TYPE '
               +'  from SL_SALE_D a inner join '
               +'       SL_SALE_H b on a.CD_STORE = b.CD_STORE and a.YMD_SALE = b.YMD_SALE and a.NO_POS = b.NO_POS and a.NO_RCP = b.NO_RCP and b.NO_DELIVERY = :p1 inner join '
               +'       MS_MENU   c on a.CD_STORE = c.CD_STORE and a.CD_MENU  = c.CD_MENU '
               +' where a.CD_STORE = :P0 ',
               [Common.Config.StoreCode,
                GetOnlyNumber(lblDeliveryNo.Caption)]);

      BeginUpdate;
      OrderTableView.DataController.RecordCount := 0;
      while not Common.Query.Eof do
      begin
        OrderTableView.DataController.AppendRecord;
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewMenuCode.Index]  := Common.Query.FieldByName('cd_menu').AsString;
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewMenuName.Index]  := Common.Query.FieldByName('nm_menu').AsString;
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewSalePrice.Index] := Common.Query.FieldByName('pr_sale').AsInteger;
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewViewQty.Index]   := Common.GetQtyReplace(Common.Query.FieldByName('ds_menu_type').AsString, Common.Query.FieldByName('qty_order').AsString);  //수량
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewQty.Index]       := Common.Query.FieldByName('qty_order').AsInteger;

        if Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'W' then
        begin
          Values[OrderTableView.DataController.RecordCount-1, OrderTableViewViewPrice.Index] := Common.Query.FieldByName('pr_sale_org').AsString;    //상품단가
        end
        else
        begin
          Values[OrderTableView.DataController.RecordCount-1, OrderTableViewViewPrice.Index] := Common.Query.FieldByName('pr_sale').AsString;    //상품단가
        end;
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewNo.Index]      := OrderTableView.DataController.RecordCount;                //순번
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewSaleAmt.Index] := Common.Query.FieldByName('amt_sale').AsString;   //금액

        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewDsMenu.Index]      := Common.Query.FieldByName('DS_MENU_TYPE').AsString;
        if (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'N') or (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'G') then                                      //메뉴구분
          Values[OrderTableView.DataController.RecordCount-1, OrderTableViewType.Index] :=''
        else if Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'W' then                                      //메뉴구분
          Values[OrderTableView.DataController.RecordCount-1, OrderTableViewType.Index] :='ⓦ'
        else if (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'S') then
          Values[OrderTableView.DataController.RecordCount-1, OrderTableViewType.Index] := 'ⓢ'
        else if (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'S') then
          Values[OrderTableView.DataController.RecordCount-1, OrderTableViewType.Index] := '-'
        else if (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'O') then
          Values[OrderTableView.DataController.RecordCount-1, OrderTableViewType.Index] := '-'
        else if (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'O') then
          Values[OrderTableView.DataController.RecordCount-1, OrderTableViewType.Index] := 'ⓞ'
        else if (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'C') then
          Values[OrderTableView.DataController.RecordCount-1, OrderTableViewType.Index] := 'ⓒ';

        FOrderAmt := FOrderAmt + Common.Query.FieldByName('AMT_SALE').AsInteger - Common.Query.FieldByName('DC_TOT').AsInteger;
        FDcAmount := FDcAmount + Common.Query.FieldByName('DC_TOT').AsInteger;
        Common.Query.Next;
      end;
      Common.Query.Close;
      EndUpdate;
    end;
  end
  else
  begin
    //기존주문내역을 불러온다
    with OrderTableView.DataController do
    begin
      OpenQuery('select a.CD_MENU, '
               +'       a.NM_MENU, '
               +'       a.DS_MENU_TYPE, '
               +'       a.NO_STEP, '
               +'       a.CD_MENU1, '
               +'       a.SEQ, '
               +'       a.PR_SALE, '
               +'       a.QTY_ORDER, '
               +'       a.AMT_ORDER, '
               +'       Date_Format(a.DT_CHANGE, ''%Y%m%d%H%i'') as DT_ORDER, '
               +'       a.DS_SALE, '
               +'       a.DS_TAX, '
               +'       ifnull(a.CD_PRINTER, '''') as CD_PRINTER, '
               +'       a.NO_SPC, '
               +'       a.DC_SPC, '
               +'       a.MEMO, '
               +'       Substring(b.CONFIG,1,1) as YN_DC, '
               +'       Substring(b.CONFIG,2,1) as YN_POINT, '
               +'       Substring(b.CONFIG,3,1) as YN_RCP, '
               +'       b.DS_KITCHEN, '
               +'       b.NO_GROUP, '
               +'       b.PR_SALE_DOUBLE, '
               +'       b.PR_SALE as PR_SALE_ORG, '
               +'       b.NM_MENU_SHORT '
               +'  from SL_ORDER_D a inner join '
               +'       MS_MENU    b on a.CD_STORE = b.CD_STORE and a.CD_MENU  = b.CD_MENU '
               +' where a.CD_STORE =:P0 '
               +'   and a.NO_TABLE =:P1 '
               +'   and a.DS_ORDER =:P2 '
               +' order by a.ORDERSEQ ',
               [Common.Config.StoreCode,
                FTableNo,
                'D']);

      vSeq := 0;
      BeginUpdate;
      OrderTableView.DataController.RecordCount := 0;
      while not Common.Query.Eof do
      begin
        OrderTableView.DataController.AppendRecord;
        if Common.Query.FieldByName('NO_STEP').AsInteger > 0 then
          Values[OrderTableView.DataController.RecordCount-1, OrderTableViewNo.Index] := ''
        else
        begin
          Inc(vSeq);
          Values[OrderTableView.DataController.RecordCount-1, OrderTableViewNo.Index] := vSeq;                //순번
        end;
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewMenuCode.Index] := Common.Query.FieldByName('CD_MENU').AsString;              //상품명
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewMenuName.Index] := Common.Query.FieldByName('NM_MENU').AsString;              //상품명
        if (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'N') or (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'G') then                                      //메뉴구분
          Values[OrderTableView.DataController.RecordCount-1, OrderTableViewType.Index] :=''
        else if Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'W' then                                      //메뉴구분
          Values[OrderTableView.DataController.RecordCount-1, OrderTableViewType.Index] :='ⓦ'
        else if (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'S') and (Common.Query.FieldByName('NO_STEP').AsInteger = 0) then
          Values[OrderTableView.DataController.RecordCount-1, OrderTableViewType.Index] := 'ⓢ'
        else if (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'S') and (Common.Query.FieldByName('NO_STEP').AsInteger > 0) then
          Values[OrderTableView.DataController.RecordCount-1, OrderTableViewType.Index] := '-'
        else if (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'O') and (Common.Query.FieldByName('NO_STEP').AsInteger > 0) then
          Values[OrderTableView.DataController.RecordCount-1, OrderTableViewType.Index] := '-'
        else if (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'O') and (Common.Query.FieldByName('NO_STEP').AsInteger = 0) then
          Values[OrderTableView.DataController.RecordCount-1, OrderTableViewType.Index] := 'ⓞ'
        else if (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'C') and (Common.Query.FieldByName('NO_STEP').AsInteger = 0) then
          Values[OrderTableView.DataController.RecordCount-1, OrderTableViewType.Index] := 'ⓒ'
        else Values[OrderTableView.DataController.RecordCount-1, OrderTableViewType.Index] := IntToStr(Common.Query.FieldByName('NO_STEP').AsInteger);

        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewDsMenu.Index]      := Common.Query.FieldByName('DS_MENU_TYPE').AsString;
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewSubMenuCode.Index] := Common.Query.FieldByName('CD_MENU1').AsString;   //상품명
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewSeq.Index]         := Common.Query.FieldByName('SEQ').AsString;
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewStep.Index]        := Common.Query.FieldByName('NO_STEP').AsString;    //코스단계
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewSalePrice.Index]   := Common.Query.FieldByName('PR_SALE').AsString;    //상품단가
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewViewQty.Index]     := Common.GetQtyReplace(Common.Query.FieldByName('DS_MENU_TYPE').AsString,
                                                                                                                     Common.Query.FieldByName('QTY_ORDER').AsString);
        if Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'W' then
          Values[OrderTableView.DataController.RecordCount-1, OrderTableViewViewPrice.Index] := Common.Query.FieldByName('PR_SALE_ORG').AsString    //상품단가
        else
          Values[OrderTableView.DataController.RecordCount-1, OrderTableViewViewPrice.Index] := Common.Query.FieldByName('PR_SALE').AsString;    //상품단가

        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewQty.Index]          := Common.Query.FieldByName('QTY_ORDER').AsString;
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewSaleAmt.Index]      := Common.Query.FieldByName('AMT_ORDER').AsString;  //금액
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewOrderYN.Index]      := 'Y';                                          //상품명
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewOrderDate.Index]    := Common.Query.FieldByName('DT_ORDER').AsString;
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewOrgSalePrice.Index] := Common.Query.FieldByName('PR_SALE_ORG').AsString;          //상품단가
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewDoublePrice.Index]  := Common.Query.FieldByName('PR_SALE_DOUBLE').AsString;       //상품단가(곱빼기)
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewMenuDc.Index]       := '0';                                          //메뉴할인
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewDsSale.Index]       := Common.Query.FieldByName('DS_SALE').AsString;              //매출구분
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewDsTax.Index]        := Common.Query.FieldByName('DS_TAX').AsString;               //세무구분
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewKitchen.Index]      := Common.Query.FieldByName('CD_PRINTER').AsString;              //주방프린터
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewEventNo.Index]      := Common.Query.FieldByName('NO_SPC').AsString;               //행사번호
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewEventDc.Index]      := Common.Query.FieldByName('DC_SPC').AsString;     //행사할인금액
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewMemo.Index]         := Common.Query.FieldByName('MEMO').AsString;                 //주방메모
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewDcYn.Index]         := Common.Query.FieldByName('YN_DC').AsString;                //할인여부
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewPointYn.Index]      := Common.Query.FieldByName('YN_POINT').AsString;             //포인트적용여부
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewRcpYn.Index]        := Common.Query.FieldByName('YN_RCP').AsString;               //영수증출력여부
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewDsKitchen.Index]    := Common.Query.FieldByName('DS_KITCHEN').AsString;//
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewGroupNo.Index]      := Common.Query.FieldByName('NO_GROUP').AsString;   //메뉴그룹
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewOrgMenuName.Index]  := Common.Query.FieldByName('NM_MENU_SHORT').AsString;          //메뉴원래명
        Values[OrderTableView.DataController.RecordCount-1, OrderTableViewChangeYn.Index]     := 'N';                                          //변경여부
        Common.Query.Next;
      end;
      Common.Query.Close;
      EndUpdate;

      OpenQuery('SELECT AMT_ORDER,  '
               +'       AMT_DC + AMT_CODEDC + DC_MENU as DC_TOT '
               +'  FROM SL_ORDER_H '
               +' WHERE CD_STORE =:p0 '
               +'   AND NO_TABLE =:p1 '
               +'   AND DS_ORDER =''D'' ',
               [Common.Config.StoreCode,
                FTableNo]);
      FDcAmount := Common.Query.FieldByName('dc_tot').AsInteger;
      Common.Query.Close;
    end;
  end;
end;

procedure TDeliveryNew_F.SetDeliveryDisplay;
begin
  try
    isLoading := true;
    OpenQuery('select a.*, '
             +'       case a.DS_CUSTOMER when ''N'' then ''비회원'' else ConCat(''회원 ('',a.CD_MEMBER,'')'') end as DS_MEMBER, '
             +'       a.NM_NAME as NM_CUSTOMER, '
             +'       b.REMARK  as BIGO, '
             +'	      case when a.CD_SAWON <> '''' then (select NM_SAWON '
             +'                                            from MS_SAWON '
             +'                                           where CD_STORE = a.CD_STORE '
             +'                                             and CD_SAWON = a.CD_SAWON ) '
             +'	      else '''' end DAMDANG, '
             +'       GetCommonName(a.CD_STORE, ''20'', a.CD_COURSE) as NM_COURSE, '
             +'       GetCommonName(a.CD_STORE, ''22'', a.CD_LOCAL)  as NM_LOCAL, '
             +'       b.NO_CASHRCP '
             +'  from SL_DELIVERY a left outer join '
             +'       MS_MEMBER   b on a.CD_STORE = b.CD_STORE and a.CD_MEMBER = b.CD_MEMBER '
             +' where a.CD_STORE      = :P0 '
             +'   and a.YMD_DELIVERY  = :P1 '
             +'   and a.NO_DELIVERY   = :P2 ',
             [Common.Config.StoreCode,
              LeftStr(GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDeliveryNo.Index],8),
              RightStr(GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDeliveryNo.Index], 4)]);

    lblDeliveryNo.Caption      := GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDeliveryNo.Index];
    lblDeliveryNo.Hint         := lblDeliveryNo.Caption;
    if GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewBaeminOrderNo.Index] <> '' then
      lblDeliveryNo.Hint      := Format('%s(%s)',[lblDeliveryNo.Caption, GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewBaeminOrderNo.Index]]);
    lblOrderDate.Caption       := FormatDateTime('yyyy년 mm월 dd일 hh시 nn분', NVL(Common.Query.FieldByName('dt_order').Value, now()));
    if Common.Query.FieldByName('dt_delivery').Value <> null then
      FDeliveryDate              := NVL(Common.Query.FieldByName('dt_delivery').Value, now());
    if (Common.Query.FieldByName('ds_step').AsString = 'N') or (Common.Query.FieldByName('ds_step').AsString = '') then
      DeliveryStep := dsNone
    else if Common.Query.FieldByName('ds_step').AsString = 'O' then
      DeliveryStep := dsOrder
    else if Common.Query.FieldByName('ds_step').AsString = 'D' then
      DeliveryStep := dsDelivery
    else if Common.Query.FieldByName('ds_step').AsString = 'A' then
      DeliveryStep := dsAccount;

    lblDeliveryDamdang.Hint    := Common.Query.FieldByName('cd_sawon').AsString;
    lblDeliveryDamdang.Caption := Common.Query.FieldByName('Damdang').AsString;
    edt_CustName.Text   := Common.Query.FieldByName('nm_name').AsString;
    lbl_Member.Caption  := Common.Query.FieldByName('ds_member').AsString;
    edt_Telno1.Text     := SetTelephone(Common.Query.FieldByName('no_tel1').AsString);
    edt_TelNo2.Text     := SetTelephone(Common.Query.FieldByName('no_tel2').AsString);
    edt_Telno3.Text     := SetTelephone(Common.Query.FieldByName('no_tel3').AsString);
    edt_TelNo4.Text     := SetTelephone(Common.Query.FieldByName('no_tel4').AsString);
    if Common.Query.FieldByName('ds_order').AsString = 'D' then
    begin
      DeliveryButton.Appearance.SimpleLayout := true;
      PackingButton.Appearance.SimpleLayout  := false;
    end
    else
    begin
      DeliveryButton.Appearance.SimpleLayout := false;
      PackingButton.Appearance.SimpleLayout  := true;
    end;

    PayButton.Hint    := Common.Query.FieldByName('PAYTYPE').AsString;
    PayButton.Caption := Common.Query.FieldByName('PAYTYPE').AsString;
    if PayButton.Caption = '현영' then
      PayButton.Caption := '현금영수증';

    if Common.Query.FieldByName('ds_step').AsString = 'A' then
    begin
      DeleteButton.Enabled       := false;
      DishReturnButton.Enabled   := true;
      panDeliveryInfo.Enabled := false;
    end
    else
    begin
      DeleteButton.Enabled       := true;
      panDeliveryInfo.Enabled := true;
      DishReturnButton.Enabled   := false;
    end;
    DeliveryGoButton.Enabled := true;

    edt_Address1.Text   := Common.Query.FieldByName('address1').AsString;
    edt_Address2.Text   := Common.Query.FieldByName('address2').AsString;
    meo_Remark.Text     := Common.Query.FieldByName('remark').AsString;
    CouponButton.Caption   := FormatFloat('#0 매', Common.Query.FieldByName('coupon_cnt').AsInteger);
    CouponButton.Tag       := Common.Query.FieldByName('coupon_cnt').AsInteger;
    CourseButton.Caption   := Common.Query.FieldByName('nm_course').AsString;
    CourseButton.Hint      := Common.Query.FieldByName('cd_course').AsString;
    LocalButton.Caption    := Common.Query.FieldByName('nm_Local').AsString;
    LocalButton.Hint       := Common.Query.FieldByName('cd_Local').AsString;

    Common.Table.Course     := CourseButton.Caption;
    Common.Table.Local      := LocalButton.Caption;
    if Trim(edt_TelNo1.Text) <> '' then
      Common.Table.DeliveryTel := edt_TelNo1.Text
    else if Trim(edt_TelNo2.Text) <> '' then
      Common.Table.DeliveryTel := edt_TelNo2.Text;

    MemberCode :=  Common.Query.FieldByName('cd_member').AsString;
    FOrderAmt  :=  Common.Query.FieldByName('amt_order').AsInteger;
    FTableNo   :=  Common.Query.FieldByName('no_table').AsInteger;
    Common.Query.Close;

    GetOrderMenu;
    SetDeliveryHistory(1);
    OrderGrid.Enabled           := true;
    OrderGrid.ActiveLevel       := OrderLevel;
    isChanged               := false;
  finally
    isLoading := false;
  end;

end;

procedure TDeliveryNew_F.SetDeliveryHistory(Kind: Integer);
begin
  if (Length(GetOnlyNumber(edt_TelNo1.Text)) > 10) and (MemberCode = '') then
  begin
    HistoryTableView.DataController.RecordCount := 0;
    Exit;
  end;

  with HistoryTableView.DataController do
  begin
    OpenQuery('select StoD(YMD_DELIVERY) YMD_DELIVERY, '
             +'		    ORDERMENU, '
             +'		    COUPON_CNT, '
             +'       case  PAYTYPE when ''CARD'' then ''신용카드'' when ''CASH'' then ''현금'' when ''ETC'' then ''복합'' else PAYTYPE end as PAYTYPE, '
             +'       AMT_ORDER, '
             +'       ConCat(YMD_DELIVERY,NO_DELIVERY) as DELIVERY_NO, '
             +'       REMARK '
             +'  from SL_DELIVERY '
             +' where CD_STORE = :P0 '
             +'		and DS_STEP in (''A'' , ''R'') '
             +'	  and YMD_DELIVERY >= Date_Format(DATE_ADD(Now(), INTERVAL -:P2 MONTH), ''%Y%m%d'') '
             +Ifthen(MemberCode = '',' and NO_TEL1 = :P1 ', ' and CD_MEMBER = :P1 ')
             +'order by 1, 4 desc ',
             [Common.Config.StoreCode,
              Ifthen(MemberCode = '', GetOnlyNumber(edt_TelNo1.Text),MemberCode),
              3]);

    HistoryTableView.DataController.RecordCount := 0;
    BeginUpdate;
    while not Common.Query.Eof do
    begin
      HistoryTableView.DataController.AppendRecord;
      Values[HistoryTableView.DataController.RecordCount-1, HistoryTableViewSaleDate.Index]    := Common.Query.FieldByName('YMD_DELIVERY').AsString;
      Values[HistoryTableView.DataController.RecordCount-1, HistoryTableViewSaleMenu.Index]    := Common.Query.FieldByName('ORDERMENU').AsString;
      Values[HistoryTableView.DataController.RecordCount-1, HistoryTableViewSaleType.Index]    := Common.Query.FieldByName('PAYTYPE').AsString;
      Values[HistoryTableView.DataController.RecordCount-1, HistoryTableViewSaleAmt.Index]     := Common.Query.FieldByName('AMT_ORDER').AsCurrency;
      Values[HistoryTableView.DataController.RecordCount-1, HistoryTableViewDeliveryNo.Index]  := Common.Query.FieldByName('DELIVERY_NO').AsString;
      Values[HistoryTableView.DataController.RecordCount-1, HistoryTableViewRemark.Index]      := Common.Query.FieldByName('REMARK').AsString;
      Common.Query.Next;
    end;
    EndUpdate;
    Common.Query.Close;
  end;
end;

function TDeliveryNew_F.GetRecallMan: Boolean;
var vName :String;
begin
  Result := False;
  if Common.ShowChooseForm('D','',FRecallMan,vName) then
  begin
    Result     := True;
  end;
end;

procedure TDeliveryNew_F.SetUsePos(aValue: String);
begin
  if GridTableView.DataController.GetFocusedRecordIndex < 0 then Exit;
  if NVL(GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDeliveryNo.Index],'') = '' then Exit;
  if aValue <> '' then
  begin
    ExecQuery('update SL_DELIVERY '
             +'   set USE_POSNO   =:P3 '
             +' where CD_STORE    =:P0 '
             +'   and YMD_DELIVERY=:P1 '
             +'   and NO_DELIVERY =:P2',
             [Common.Config.StoreCode,
              LeftStr(GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDeliveryNo.Index],8),
              RightStr(GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDeliveryNo.Index], 4),
              aValue]);
  end
  else
  begin                                                                                      
    ExecQuery('update SL_DELIVERY '
             +'   set USE_POSNO   ='''' '
             +' where CD_STORE    =:P0 '
             +'   and USE_POSNO   =:P1 ',
             [Common.Config.StoreCode,
              Common.Config.PosNo]);
  end;
end;

procedure TDeliveryNew_F.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Common.Device.OnCidReadData := nil;
end;

procedure TDeliveryNew_F.ClearDeliveryData;
begin
  MemberCode        := EmptyStr;  //회원번호
  FBefOrderAmt      := 0;         //직전 주문금액
  FTableNo          := 0;
  FBeforStep        := dsNone;    //직전 배달상태
  DeliveryStep     := dsNone;    //배달상태
  FDeliveryMan      := EmptyStr;  //배달담당
  FRecallMan        := EmptyStr;
  FDeliveryDate     := 0;
  CouponButton.Caption := '0 매';
  CouponButton.Tag     := 0;
  CourseButton.Caption := '';
  CouponButton.Hint    := '';
  LocalButton.Caption        := '';
  LocalButton.Hint           := '';

  lblDeliveryNo.Caption      := '';
  lblDeliveryNo.Hint         := '';

  lblOrderDate.Caption       := '';
  lblDeliveryStatus.Caption  := '';
  lblDeliveryDamdang.Caption := '';
  edt_CustName.Clear;
  lbl_Member.Caption         := '';
  edt_Telno2.Clear;
  edt_TelNo1.Clear;
  edt_Telno3.Clear;
  edt_TelNo4.Clear;
  //기본배달구분
  if GetOption(118) = '0' then
  begin
    DeliveryButton.Appearance.SimpleLayout := true;
    PackingButton.Appearance.SimpleLayout  := false;
  end
  else
  begin
    DeliveryButton.Appearance.SimpleLayout := false;
    PackingButton.Appearance.SimpleLayout  := true;
  end;

  CardButton.Appearance.SimpleLayout     := false;
  CashButton.Appearance.SimpleLayout     := false;
  CashRcpButton.Appearance.SimpleLayout  := false;
  EtcButton.Appearance.SimpleLayout      := false;

  //기본결제방법
  if GetOption(395)='0' then
    CardButton.Appearance.SimpleLayout := true
  else
    CashButton.Appearance.SimpleLayout := true;

  edt_Address1.Clear;
  edt_Address2.Clear;
  meo_Remark.Clear;
  OrderTableView.DataController.RecordCount   := 0;
  HistoryTableView.DataController.RecordCount := 0;
  FOrderAmt := 0;
  FDcAmount := 0;
  isChanged := false;
end;

procedure TDeliveryNew_F.Close2ButtonClick(Sender: TObject);
begin
  CallStep := csNone;
end;

procedure TDeliveryNew_F.CloseButtonClick(Sender: TObject);
var vIndex :Integer;
    vTemp  :String;
begin
  SetUsePos('');
  if panManagement.Visible then
  begin
    panManagement.Visible := false;
    Exit;
  end;
  //그리드 칼럼  위치 및 Width 저장
  vTemp := EmptyStr;
  For vIndex := 0 to GridTableView.ColumnCount-1 do
  begin
    if (GridTableView.Columns[vIndex].Tag = 0) or not GridTableView.Columns[vIndex].Visible then Continue;
    vTemp := vTemp + Format('%d|%d|%d',[GridTableView.Columns[vIndex].Position.ColIndex,
                                        GridTableView.Columns[vIndex].Tag,
                                        GridTableView.Columns[vIndex].Width])+#2;
  end;

  vTemp := Copy(vTemp, 1, Length(vTemp)-1);
  Common.SetIniFile('POS', 'GridTableView', vTemp);

  vTemp := EmptyStr;
  For vIndex := 0 to bvGridView.ColumnCount-1 do
    vTemp := vTemp + Format('%d',[bvGridView.Columns[vIndex].Width])+#2;

  vTemp := Copy(vTemp, 1, Length(vTemp)-1);
  Common.SetIniFile('POS', 'bvGridView', vTemp);

  vTemp := EmptyStr;
  For vIndex := 0 to tvGridView.ColumnCount-1 do
    vTemp := vTemp + Format('%d',[tvGridView.Columns[vIndex].Width])+#2;

  vTemp := Copy(vTemp, 1, Length(vTemp)-1);
  Common.SetIniFile('POS', 'tvGridView', vTemp);

  vTemp := EmptyStr;
  For vIndex := 0 to OrderTableView.ColumnCount-1 do
    vTemp := vTemp + Format('%d',[OrderTableView.Columns[vIndex].Width])+#2;

  vTemp := Copy(vTemp, 1, Length(vTemp)-1);
  Common.SetIniFile('POS', 'OrderTableView', vTemp);

  vTemp := EmptyStr;
  For vIndex := 0 to HistoryTableView.ColumnCount-1 do
    vTemp := vTemp + Format('%d',[HistoryTableView.Columns[vIndex].Width])+#2;

  vTemp := Copy(vTemp, 1, Length(vTemp)-1);
  Common.SetIniFile('POS', 'HistoryTableView', vTemp);

  Close;
end;

procedure TDeliveryNew_F.CouponButtonClick(Sender: TObject);
var vRtn :String;
begin
  vRtn := Common.ShowNumberForm('쿠폰매수를 입력하세요', 0,99,'0');
  if vRtn = 'mrClose' then Exit;

  CouponButton.Caption := FormatFloat('#0 매', StoI(vRtn));
  CouponButton.Tag     := StoI(vRtn);
  isChanged := true;
end;

procedure TDeliveryNew_F.CourseButtonClick(Sender: TObject);
var vCode, vName, vSql :String;
begin
  vSql := 'select CD_CODE, '
         +'       NM_CODE1 as NM_COURSE, '
         +'       0 as CNT_DELIVERY '
         +'  from MS_CODE '
         +' where CD_STORE =:P0 '
         +'   and CD_KIND =''20'' '
         +'   and DS_STATUS = ''0'' '
         +' order by CD_CODE';

  if Common.ShowChooseForm('C','',vCode, vName, vSql) then
  begin
    CourseButton.Caption := vName;
    CourseButton.Hint    := vCode;
    edt_Address1.SetFocus;
    edt_Address1.SetSelection(Length(edt_Address1.Text),1);
  end
  else
  begin
    LocalButton.Caption := '';
    LocalButton.Hint    := '';
  end;
  isChanged := true;
  Common.Table.Course := CourseButton.Caption;
end;

procedure TDeliveryNew_F.cxLabel3Click(Sender: TObject);
  function SetBaeminOrder(var aDeliveryNo, aAddress, aTableMemo:String; var aNoMathAmt:Integer; aValue: String):Integer;
  var vOrderData :TStringList;
      vTemp :String;
      vIndex, vIndex2 :Integer;
      vOrderNo,
      vOrderDate,
      vTelNo,
      vAddr,
      vAddr1,
      vAddr2,
      vTableMemo :String;
      vOrderAmt,
      vCheckCount :Integer;
      vBeginIndex,
      vEndIndex,
      vSeq :Integer;
      vDeliveryNo :String;
      vTableNo :Integer;
      BaeminOrderMenu :TList;
      vMenuList :^TBaeminOrderMenu;
      vMatchAmt :Integer;
      vMenuPosBegin,
      vMenuPosEnd  :Integer;
      vMainIndex,
      vStep :Integer;
      vPos, vPos2 :Integer;
      vPayType :String;
      vResult :String;
  begin
    try
      Result     := -1;
      vTableMemo := EmptyStr;
      vTemp      := aValue;
      Common.WriteLog('work', aValue);
      vMenuPosBegin := 0;
      vMenuPosEnd   := 0;
      vOrderData := TStringList.Create;
      vOrderData.Clear;
      if (Pos('주문번호',vTemp) = 0) or (Pos('배달 주문서', vTemp) > 0) or (Pos('포장 주문서', vTemp) > 0) then
      begin
        Common.WriteLog('work', Format('Format Error %d, %d, %d',[Pos('주문번호',vTemp), Pos('배달 주문서', vTemp), Pos('포장 주문서', vTemp)]));
        Exit;
      end;
      try
        vTemp := Replace(vTemp, #$A#$D, splitColumn);
        vTemp := Replace(vTemp, #$A, '');
        vTemp := Replace(vTemp, #$1B#$40, '');
        vTemp := Replace(vTemp, #$1B'E'#1, '');
        vTemp := Replace(vTemp, #$1B'E'#0, '');
        vTemp := Replace(vTemp, #$1B'E', '');
        vTemp := Replace(vTemp, #$1B'i', '');
        vTemp := Replace(vTemp, #$1B, '');
        vTemp := Replace(vTemp, 'E'#1, '');
        vTemp := Replace(vTemp, 'E'#0, '');
        vTemp := Replace(vTemp, '!'#0, '');
        vTemp := Replace(vTemp, '! ', '');
        vTemp := Replace(vTemp, '!'#$18, '');
        vTemp := Replace(vTemp, #$D, '');
        Split(vTemp, splitColumn, vOrderData);

        for vIndex := vOrderData.Count-1 downto 0 do
        begin
          if vOrderData.Strings[vIndex] = '' then vOrderData.Delete(vIndex);
        end;

        BaeminOrderMenu := TList.Create;
        BaeminOrderMenu.Clear;
        //배민 주문 헤더를 만든다
        vAddr1 := '';
        vAddr2 := '';
        for vIndex := 0 to vOrderData.Count-1 do
        begin
          if Pos('주문번호:', vOrderData.Strings[vIndex]) > 0 then
          begin
            vOrderNo   := CopyAnsi(vOrderData.Strings[vIndex],10,12);
            if vOrderData.Strings[vIndex+1] <> '' then
              vOrderDate := GetOnlyNumber(CopyAnsi(vOrderData.Strings[vIndex+1],1,20))
            else
              vOrderDate := GetOnlyNumber(CopyAnsi(vOrderData.Strings[vIndex+2],1,20));
            vOrderDate := FormatMaskText('!0000-00-00 00:00;0; ',vOrderDate);
          end;

          if (Pos('배달주소:', vOrderData.Strings[vIndex]) > 0) then
          begin
            vAddr := vOrderData.Strings[vIndex+2] ;
            //주소가 두줄일때
//            if Pos('연락처:',vOrderData.Strings[vIndex+3]) = 0 then
//            begin
//              vAddr := vOrderData.Strings[vIndex+2];
//            end;
            //42칼럼
            if Common.Config.PrintColum = 0 then
            begin
              vAddr1 := SCopy(vAddr, 1, 42);
              vAddr2 := SCopy(vAddr, 43, 42);
            end
            else
            begin
              vAddr1 := SCopy(vAddr, 1, 48);
              vAddr2 := SCopy(vAddr, 49, 48);
            end;
          end;

          if (Pos('연락처:', vOrderData.Strings[vIndex]) > 0) then
             vTelNo := GetOnlyNumber(vOrderData.Strings[vIndex+1]);

          if (Pos('요청사항:', vOrderData.Strings[vIndex]) > 0) then
          begin
             vTableMemo := Trim(vOrderData.Strings[vIndex+1])+#13;
             if (Pos('------------------', vOrderData.Strings[vIndex+2]) = 0) then
             begin
               vTableMemo := vTableMemo + Trim(vOrderData.Strings[vIndex+2])+#13;
                 if (Pos('------------------', vOrderData.Strings[vIndex+3]) = 0) then
                   vTableMemo := vTableMemo + Trim(vOrderData.Strings[vIndex+3])+#13;
             end;
          end;

          //메뉴를 찾는다
          if (Pos('메뉴명', vOrderData.Strings[vIndex]) > 0) and (Pos('수량', vOrderData.Strings[vIndex]) > 0) and (Pos('금액', vOrderData.Strings[vIndex]) > 0) then
            vMenuPosBegin := vIndex + 2;

          if (Pos('합계', vOrderData.Strings[vIndex]) > 0) then
          begin
            vOrderAmt   := StrToInt(GetOnlyNumber(RightStr(vOrderData.Strings[vIndex],7)));
            vMenuPosEnd := vIndex -2;
          end;

          if (Pos('(후불카드)', vOrderData.Strings[vIndex]) > 0) then
            vPayType := '카드';
          if (Pos('(후불현금)', vOrderData.Strings[vIndex]) > 0) then
            vPayType := '현금';
          if (Pos('(결제완료)', vOrderData.Strings[vIndex]) > 0) then
            vPayType := '결제완료';
        end;


        for vIndex := vMenuPosBegin to vMenuPosEnd do
        begin
          if Copy(vOrderData.Strings[vIndex],1,1) <> ' ' then
          begin
            New(vMenuList);
            vMenuList^.Code   := '';
            vMenuList^.Item   := '';
            vMenuList^.TotalItem := '';
            vMenuList^.Step   := 0;
            //주문메뉴가 한줄일때
            if GetOnlyNumber(RightStr(vOrderData.Strings[vIndex],3)) = RightStr(vOrderData.Strings[vIndex],3) then
            begin
              vMenuList^.Name   := Trim(CopyAnsi(vOrderData.Strings[vIndex],1,25));
              vMenuList^.Memo   := '';
              vMenuList^.Qty    := StrToIntDef(GetOnlyNumber(CopyAnsi(vOrderData.Strings[vIndex],26,3)),1);
              vMenuList^.Amount := StrToIntDef(GetOnlyNumber(CopyAnsi(vOrderData.Strings[vIndex],29,14)),0);
              vMenuList^.Price  := vMenuList^.Amount div Ifthen(vMenuList^.Qty=0,1,vMenuList^.Qty);
              vPos := vIndex;
            end
            else
            begin
              vMenuList^.Name   := vOrderData.Strings[vIndex];
              vMenuList^.Memo   := '';
              vMenuList^.Qty    := StrToIntDef(GetOnlyNumber(CopyAnsi(vOrderData.Strings[vIndex+1],26,3)),1);
              vMenuList^.Amount := StrToIntDef(GetOnlyNumber(CopyAnsi(vOrderData.Strings[vIndex+1],29,14)),0);
              vMenuList^.Price  := vMenuList^.Amount div Ifthen(vMenuList^.Qty=0,1,vMenuList^.Qty);
              vPos := vIndex + 1;
            end;
            vPos2 := vPos;

            //메모가 있는지 확인                                                            //금액이 있는지 체크
            if (vPos+1 < vMenuPosEnd) and (Copy(vOrderData.Strings[vPos+1],2,1) = '+') and (Pos('0원)',vOrderData.Strings[vPos+1]) = 0) then
            begin
              vPos2 := vPos + 1;
              vMenuList^.Memo   := ' '+Trim(vOrderData.Strings[vPos+1])+#13;
              if (vPos+2 < vMenuPosEnd) and (CopyAnsi(vOrderData.Strings[vPos+2],2,1) = '+') and (Pos('0원)',vOrderData.Strings[vPos+2]) = 0) then
              begin
               vPos2 := vPos + 2;
                vMenuList^.Memo   := vMenuList^.Memo + ' '+Trim(vOrderData.Strings[vPos+2])+#13;
                if (vPos+3 < vMenuPosEnd) and (CopyAnsi(vOrderData.Strings[vPos+3],2,1) = '+') and (Pos('0원)',vOrderData.Strings[vPos+3]) = 0) then
                begin
                  vPos2 := vPos + 3;
                  vMenuList^.Memo   := vMenuList^.Memo + ' '+Trim(vOrderData.Strings[vPos+3])+#13;
                  if (vPos+4 < vMenuPosEnd) and (CopyAnsi(vOrderData.Strings[vPos+4],2,1) = '+') and (Pos('0원)',vOrderData.Strings[vPos+4]) = 0) then
                  begin
                    vPos2 := vPos + 4;
                    vMenuList^.Memo   := vMenuList^.Memo +' '+ Trim(vOrderData.Strings[vPos+4])+#13;
                    if (vPos+5 < vMenuPosEnd) and (CopyAnsi(vOrderData.Strings[vPos+5],2,1) = '+') and (Pos('0원)',vOrderData.Strings[vPos+5]) = 0) then
                    begin
                      vPos2 := vPos + 5;
                      vMenuList^.Memo   := vMenuList^.Memo + ' '+Trim(vOrderData.Strings[vPos+5])+#13;
                    end;
                  end;
                end;
              end;
            end;
            BaeminOrderMenu.Add(vMenuList);
            //아이템 부메뉴도 메뉴정보에 추가한다
            for vIndex2 := 1 to 10 do
              if (vPos2+vIndex2 < vMenuPosEnd) and (CopyAnsi(vOrderData.Strings[vPos2+vIndex2],2,1) = '+') and (Pos('0원)',vOrderData.Strings[vPos2+vIndex2]) > 0) then
              begin
                New(vMenuList);
                vMenuList^.Code        := '';
                vMenuList^.Item        := '';
                vMenuList^.Step        := 0;
                vMenuList^.TotalItem   := '';
                //부메뉴는 수량과 금액 없어 전부를 메뉴명으로 처리한다
                vMenuList^.Name   := Trim(CopyAnsi(vOrderData.Strings[vPos2+vIndex2],3,50));
                vMenuList^.Qty    := 1;
                vMenuList^.Amount := 0;
                vMenuList^.Price  := 0;
                BaeminOrderMenu.Add(vMenuList);
              end
              else Break;
          end;
        end;

        vMatchAmt := 0;
        vStep     := 0;
        for vIndex := 0 to BaeminOrderMenu.Count-1 do
        begin
          OpenQuery('select a.CD_MENU, '
                   +'       b.DS_MENU_TYPE '
                   +'  from MS_MENU_BAEMIN a left outer join '
                   +'       MS_MENU        b on b.CD_STORE = a.CD_STORE '
                   +'                       and b.CD_MENU  = a.CD_MENU '
                   +' where a.CD_STORE  =:P0 '
                   +'   and a.NM_BAEMIN =:P1 ',
                   [Common.Config.StoreCode,
                    TBaeminOrderMenu(BaeminOrderMenu.Items[vIndex]^).Name]);
          if Common.Query.Eof then
          begin
            ExecQuery('insert into MS_MENU_BAEMIN(CD_STORE, '
                     +'                           CD_MENU, '
                     +'                           NM_BAEMIN) '
                     +'                    values(:P0, '
                     +'                           :P1, '
                     +'                           :P2) ',
                     [Common.Config.StoreCode,
                      'XX'+FormatDateTime('yyyymmddhhss', Now())+IntToStr(vIndex),
                      TBaeminOrderMenu(BaeminOrderMenu.Items[vIndex]^).Name]);
          end
          else
          begin
            if LeftStr(Common.Query.FieldByName('CD_MENU').AsString,2) <> 'XX' then
            begin
              //아이템메뉴일때
              if Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'I' then
              begin
                TBaeminOrderMenu(BaeminOrderMenu.Items[vIndex]^).Code          := TBaeminOrderMenu(BaeminOrderMenu.Items[vMainIndex]^).Code;
                TBaeminOrderMenu(BaeminOrderMenu.Items[vIndex]^).Item          := Common.Query.FieldByName('CD_MENU').AsString;
                TBaeminOrderMenu(BaeminOrderMenu.Items[vMainIndex]^).TotalItem := TBaeminOrderMenu(BaeminOrderMenu.Items[vMainIndex]^).TotalItem + Format('%s|',[TBaeminOrderMenu(BaeminOrderMenu.Items[vIndex]^).Item]);
                Inc(vStep);
                TBaeminOrderMenu(BaeminOrderMenu.Items[vIndex]^).Step          := vStep;
              end
              else
              begin
                TBaeminOrderMenu(BaeminOrderMenu.Items[vIndex]^).Code := Common.Query.FieldByName('CD_MENU').AsString;
                vMainIndex := vIndex;
                vStep := 0;
              end;
              vMatchAmt := vMatchAmt + TBaeminOrderMenu(BaeminOrderMenu.Items[vIndex]^).Amount;
            end;
          end;
        end;

        OpenQuery('select NO_ORDER_BAEMIN '
                 +'  from SL_DELIVERY '
                 +' where CD_STORE        =:P0 '
                 +'   and NO_ORDER_BAEMIN =:P1 ',
                 [Common.Config.StoreCode,
                  vOrderNo]);
        if Common.Query.Eof then
        begin
          Common.Query.Close;
          try
            Common.BeginTran;
            with DM.StoredProc do
            begin
              Close;
              StoredProcName := 'POS_SAVE_DELIVERY';
              PrepareSQL;
              ParamByName('_CD_STORE').AsString     := Common.Config.StoreCode;
              ParamByName('_NO_DELIVERY').AsString  := '';
              ParamByName('_NO_TABLE').AsInteger    := 0;
              ParamByName('_NO_POS').AsString       := Common.Config.PosNo;
              ParamByName('_DS_ORDER').AsString     := 'D';
              ParamByName('_PAYTYPE').AsString      := vPayType;
              ParamByName('_CD_MEMBER').AsString    := '';
              ParamByName('_NM_NAME').AsString      := '배달의민족';
              ParamByName('_NO_TEL1').AsString      := vTelNo;
              ParamByName('_NO_TEL2').AsString      := '';
              ParamByName('_NO_TEL3').AsString      := '';
              ParamByName('_NO_TEL4').AsString      := '';
              ParamByName('_ADDRESS1').AsString     := vAddr1;
              ParamByName('_ADDRESS2').AsString     := vAddr2;
              ParamByName('_COUPON_CNT').AsInteger  := 0;
              ParamByName('_CD_COURSE').AsString    := '';
              ParamByName('_CD_LOCAL').AsString     := '';
              ParamByName('_TEL_LINE').AsString     := '0';
              ParamByName('_REMARK').AsString       := vTableMemo;
              ParamByName('_DS_STEP').AsString      := 'O';
              ParamByName('_DT_ORDER').AsDate       := StrToDateTime(vOrderDate);
              ParamByName('_CD_SAWON').AsString     := '';
              ParamByName('_RECALL_SAWON').AsString := '';
              ParamByName('_AMT_ORDER').AsInteger   := vOrderAmt;
              ParamByName('_YMD_DELIVERY').AsString := Common.WorkDate;
              ParamByName('_WORK_KIND').AsString    := 'I';
              ExecProc;
              vResult := ParamByName('_RESULT').AsString;
              if vResult <> 'OK' then
                raise Exception.Create(vResult);

              vDeliveryNo := ParamByName('_NO_DELIVERY').AsString;
              vTableNo    := ParamByName('_NO_TABLE').AsInteger;
            end;

            ExecQuery('update SL_DELIVERY '
                     +'   set NO_ORDER_BAEMIN =:P3, '
                     +'       REMARK          =:P4 '
                     +' where CD_STORE     =:P0 '
                     +'   and YMD_DELIVERY =:P1 '
                     +'   and NO_DELIVERY  =:P2 ',
                     [Common.Config.StoreCode,
                      Common.WorkDate,
                      vDeliveryNo,
                      vOrderNo,
                      vTableMemo]);

            ExecQuery('update SL_ORDER_H '
                     +'   set AMT_ORDER =:P2, '
                     +'       MEMO_TXT  =:P3 '
                     +' where CD_STORE  =:P0 '
                     +'   and NO_TABLE  =:P1 '
                     +'   and DS_ORDER  =''D'' ',
                     [Common.Config.StoreCode,
                      vTableNo,
                      vOrderAmt,
                      vTableMemo]);

            vSeq := 1;
            for vIndex := 0 to BaeminOrderMenu.Count-1 do
            begin
              if TBaeminOrderMenu(BaeminOrderMenu.Items[vIndex]^).Code = '' then
                Continue;

              ExecQuery('insert into SL_ORDER_D(CD_STORE, '
                       +'	    	                NO_TABLE, '
                       +'	    	                DS_ORDER, '
                       +'                       DS_SALE, '
                       +'                       SEQ, '
                       +'                       NO_STEP, '
                       +'	    	                CD_MENU, '
                       +'                       PR_SALE, '
                       +'	    	                QTY_ORDER, '
                       +'                       AMT_ORDER, '
                       +'                       NM_MENU, '
                       +'                       PR_SALE_ORG, '
                       +'                       CD_MENU1, '
                       +'                       PR_TIP, '
                       +'                       DS_TAX, '
                       +'                       QTY_NEPUM, '
                       +'                       YN_DOUBLE, '
                       +'                       DS_MENU_TYPE, '
                       +'                       MEMO, '
                       +'                       NO_POS, '
                       +'                       CD_ITEM, '
                       +'                       PR_ITEM) '
                       +'               select  CD_STORE, '
                       +'	    	                :P1, '
                       +'	    	                ''D'', '
                       +'                       ''S'', '
                       +'                       :P3, '
                       +'                       :P4, '
                       +'	    	                :P5, '
                       +'                       :P6, '
                       +'	    	                :P7, '
                       +'                       :P8, '
                       +'                       NM_MENU_SHORT, '
                       +'                       :P6, '
                       +'                       :P9, '
                       +'                       0, '
                       +'                       DS_TAX, '
                       +'                       1, '
                       +'                       ''N'', '
                       +'                       DS_MENU_TYPE, '
                       +'                       :P10, '
                       +'                       :P11, '
                       +'                       :P12, '
                       +'                       :P13 '
                       +'                 from  MS_MENU '
                       +'                where  CD_STORE =:P0 '
                       +'                  and  CD_MENU  =:P2 ',
                       [Common.Config.StoreCode,
                        vTableNo,
                        //아이템메뉴일때
                        Ifthen(TBaeminOrderMenu(BaeminOrderMenu.Items[vIndex]^).Item = '', TBaeminOrderMenu(BaeminOrderMenu.Items[vIndex]^).Code, TBaeminOrderMenu(BaeminOrderMenu.Items[vIndex]^).Item),
                        vSeq,
                        TBaeminOrderMenu(BaeminOrderMenu.Items[vIndex]^).Step,
                        TBaeminOrderMenu(BaeminOrderMenu.Items[vIndex]^).Code,               //:P5
                        TBaeminOrderMenu(BaeminOrderMenu.Items[vIndex]^).Price,              //:P6
                        TBaeminOrderMenu(BaeminOrderMenu.Items[vIndex]^).Qty,                //:P7
                        TBaeminOrderMenu(BaeminOrderMenu.Items[vIndex]^).Amount,             //:P8
                        TBaeminOrderMenu(BaeminOrderMenu.Items[vIndex]^).Item,               //:P9
                        TBaeminOrderMenu(BaeminOrderMenu.Items[vIndex]^).Memo,               //:P10
                        Common.Config.PosNo,                                                 //:P11
                        TBaeminOrderMenu(BaeminOrderMenu.Items[vIndex]^).TotalItem,          //:P12
                        Ifthen(TBaeminOrderMenu(BaeminOrderMenu.Items[vIndex]^).Item = '',0,TBaeminOrderMenu(BaeminOrderMenu.Items[vIndex]^).Price)]);        //:P13
              Inc(vSeq);
            end;

            aNoMathAmt := vOrderAmt-vMatchAmt;

            //매칭이되지 않을 메뉴가 있을때
            if vOrderAmt-vMatchAmt <> 0 then
              ExecQuery('insert into SL_ORDER_D(CD_STORE, '
                       +'	    	                NO_TABLE, '
                       +'	    	                DS_ORDER, '
                       +'                       DS_SALE, '
                       +'                       SEQ, '
                       +'                       NO_STEP, '
                       +'	    	                CD_MENU, '
                       +'                       PR_SALE, '
                       +'	    	                QTY_ORDER, '
                       +'                       AMT_ORDER, '
                       +'                       NM_MENU, '
                       +'                       PR_SALE_ORG, '
                       +'                       CD_MENU1, '
                       +'                       PR_TIP, '
                       +'                       PR_ITEM, '
                       +'                       DS_TAX, '
                       +'                       QTY_NEPUM, '
                       +'                       YN_DOUBLE, '
                       +'                       DS_MENU_TYPE, '
                       +'                       NO_POS) '
                       +'               select  CD_STORE, '
                       +'	    	                :P1, '
                       +'	    	                ''D'', '
                       +'                       ''S'', '
                       +'                       :P3, '
                       +'                       0, '
                       +'	    	                CD_MENU, '
                       +'                       :P4, '
                       +'	    	                1, '
                       +'                       :P4, '
                       +'                       NM_MENU_SHORT, '
                       +'                       PR_SALE, '
                       +'                       '''', '
                       +'                       0, '
                       +'                       0, '
                       +'                       DS_TAX, '
                       +'                       1, '
                       +'                       ''N'', '
                       +'                       DS_MENU_TYPE, '
                       +'                       :P5 '
                       +'                 from  MS_MENU '
                       +'                where  CD_STORE =:P0 '
                       +'                  and  CD_MENU  =:P2 ',
                       [Common.Config.StoreCode,
                        vTableNo,
                        Common.Config.BaeminMenuCode,
                        vSeq,
                        vOrderAmt-vMatchAmt,
                        Common.Config.PosNo]);
            Common.CommitTran;
            Result := vTableNo;
            aDeliveryNo := vOrderNo;
            aAddress    := vAddr1 + vAddr2;
            aTableMemo  := vTableMemo;
            Common.WriteLog('work', Format('[주문번호] %s [배민주문번호] %s 저장완료',[vDeliveryNo, vOrderNo]));
          except
            on E :Exception do
            begin
              Common.RollbackTran;
              Common.WriteLog('work', Format('주문번호 %s 저장 중 %s',[vOrderNo, E.Message]));
            end;
          end;
        end
        else
          Common.WriteLog('work', Format('[배민주문번호] %s 이미 주문된 배달건으로 패스',[vOrderNo]));
      except
        on E :Exception do
        begin
          Common.WriteLog('work', Format('배민주문 저장 오류 주문번호 %s 저장 중 %s',[vOrderNo, E.Message]));
        end;
      end;
    finally
      BaeminOrderMenu.Free;
      vOrderData.Free;
    end;
  end;
var vReadData :AnsiString;
    vTableNo, vNoMathAmt, vIndex  :Integer;
    vDeliverNo,
    vAddress,
    vTableMemo,
    vPrintData :String;
    vTempList :TStringList;
begin
  vTempList := TStringList.Create;
  vTempList.LoadFromFile('D:\Solution\CloudOrange\Bin\20240508.Log');
  vPrintData := vTempList.Text;
  SetBaeminOrder(vDeliverNo, vAddress, vTableMemo, vNoMathAmt, vPrintData);
end;

//특이사항 버튼 클릭
procedure TDeliveryNew_F.GridTableViewCanSelectRecord(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
  //멀티선택시 수정을 못하게 한다
  if GridTableView.Controller.SelectedRecordCount > 1 then
  begin
    panDeliveryInfo.Enabled := false;
    MissedCallButton.Enabled       := false;
    TakeOutButton.Enabled         := false;
    NewButton.Enabled          := false;
  end
  else
  begin
    MissedCallButton.Enabled       := true;
    TakeOutButton.Enabled         := true;
    NewButton.Enabled          := true;
  end;
end;

function TDeliveryNew_F.DataSave(Sender: TObject): Boolean;
var vRecordIndex :Integer;
    vResult :String;
begin
  try
    Result := False;
    //신규주문시 고객명에 포커스를 위치하지 않을때 고객명이 없으면 주소를 고객명에 넣는다
    if (GetOption(377) = '1') and (Trim(edt_CustName.Text) = EmptyStr) then
      edt_CustName.Text := edt_Address1.Text;
    DM.StoredProc.StoredProcName := 'POS_SAVE_DELIVERY';
    DM.StoredProc.PrepareSQL;
    Common.BeginTran;
    with DM.StoredProc do
    begin
      Close;
      ParamByName('_cd_store').AsString     := Common.Config.StoreCode;
      ParamByName('_no_delivery').AsString  := RightStr(lblDeliveryNo.Caption,4);
      ParamByName('_no_table').AsInteger    := FTableNo;
      ParamByName('_no_pos').AsString       := Common.Config.PosNo;
      ParamByName('_ds_order').AsString     := IfThen(DeliveryButton.Appearance.SimpleLayout, 'D','P');
      ParamByName('_paytype').AsString      := PayButton.Hint;
      ParamByName('_cd_member').AsString    := MemberCode;
      ParamByName('_nm_name').AsString      := edt_CustName.Text;
      ParamByName('_no_tel1').AsString      := CtoC(edt_TelNo1.Text);
      ParamByName('_no_tel2').AsString      := CtoC(edt_TelNo2.Text);
      ParamByName('_no_tel3').AsString      := CtoC(edt_TelNo3.Text);
      ParamByName('_no_tel4').AsString      := CtoC(edt_TelNo4.Text);
      ParamByName('_address1').AsString     := edt_Address1.Text;
      ParamByName('_address2').AsString     := edt_Address2.Text;
      ParamByName('_coupon_cnt').AsInteger  := CouponButton.Tag;
      ParamByName('_cd_course').AsString    := CourseButton.Hint;
      ParamByName('_cd_local').AsString     := LocalButton.Hint;
      ParamByName('_tel_line').AsString     := FTelLine;
      ParamByName('_remark').AsString       := meo_Remark.Text;
      case DeliveryStep of
        dsNone      : ParamByName('_ds_step').Value := 'N';
        dsOrder     :
        begin
          ParamByName('_ds_step').AsString  := 'O';
          ParamByName('_dt_order').AsDate := Now;
        end;
        dsDelivery  :
        begin
          ParamByName('_ds_step').AsString     := 'D';
          ParamByName('_dt_delivery').AsDate := Now;
        end;
        dsAccount   : ParamByName('_ds_step').AsString := 'A';
        dsDishReturn: ParamByName('_ds_step').AsString := 'R';
      end;
      ParamByName('_cd_sawon').AsString     := FDeliveryMan;
      ParamByName('_recall_sawon').AsString := FRecallMan;
      ParamByName('_amt_order').AsInteger   := FOrderAmt;
      if isNew then
      begin
        ParamByName('_ymd_delivery').AsString := Common.WorkDate;
        ParamByName('_work_kind').AsString    := 'I';
      end
      else
      begin
        ParamByName('_ymd_delivery').AsString := LeftStr(lblDeliveryNo.Caption,8);
        ParamByName('_work_kind').AsString    := 'E';
      end;

      ExecProc;
      vResult := ParamByName('_RESULT').AsString;
      if vResult <> 'OK' then
        raise Exception.Create(vResult);
      if isNew then
      begin
        FTableNo              := ParamByName('_no_table').AsInteger;
        lblDeliveryNo.Caption := Common.WorkDate+'-'+ParamByName('_no_delivery').AsString;
        lblDeliveryNo.Hint    := lblDeliveryNo.Caption;

        isLoading := true;
        GridTableView.DataController.AppendRecord;
        GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewDeliveryNo.Index] := lblDeliveryNo.Caption;
        GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewStatus.Index]     := '미주문';
        GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewType.Index]       := IfThen(DeliveryButton.Appearance.SimpleLayout,'배달','포장');
        if CardButton.Appearance.SimpleLayout then
          GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewAcctType.Index]       := CardButton.Caption
        else if CashButton.Appearance.SimpleLayout then
          GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewAcctType.Index]       := CashButton.Caption
        else if CashRcpButton.Appearance.SimpleLayout then
          GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewAcctType.Index]       := CashRcpButton.Caption
        else if EtcButton.Appearance.SimpleLayout then
          GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewAcctType.Index]       := EtcButton.Caption;
        GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewCustName.Index]   := edt_CustName.Text;
        GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewTelMobile.Index]  := SetTelephone(edt_TelNo1.Text);
        GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewTelHome.Index]    := SetTelephone(edt_TelNo2.Text);
        GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewTelEtc.Index]     := SetTelephone(edt_TelNo3.Text);
        GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewTelEtc2.Index]    := SetTelephone(edt_TelNo4.Text);
        GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewAddress.Index]    := Format('%s %s',[edt_Address1.Text, edt_Address2.Text]);
        GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewCourse.Index]     := CourseButton.Caption;
        GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewOrderAmt.Index]   := 0;
        GridTableView.Controller.FocusedRecordIndex := GridTableView.DataController.RecordCount-1;
        isLoading := false;
      end;
    end;
    Common.CommitTran;
    Result := True;
  except
    on E: Exception do
    begin
      Common.RollbackTran;
      Common.WriteLog('Delivery_DataSave',E.Message);
      Common.ErrBox(E.Message+#13#13+'저장하지 못했습니다');
      Exit;
    end;
  end;

  //배달주문내역 저장 시 회원정보를 같이 저장한다고 했을때
  if (GetOption(364) = '1') and (MemberCode <> EmptyStr) and (Sender <> MemberSaveButton)  then
  begin
    MemberSaveButtonClick(nil);
  end;
end;

function TDeliveryNew_F.GetDeliveryMan: Boolean;
var  vName :String;
begin
  if Common.ShowChooseForm('D','',FDeliveryMan,vName) then
  begin
    lblDeliveryDamdang.Caption := vName;
    Result := True;
  end;
end;

procedure TDeliveryNew_F.DeleteButtonClick(Sender: TObject);
  procedure DeleteReadyData(aData:String);
  var I :Integer;
  begin
    For I := 0 to Common.CidData.Count-1 do
    begin
      if Trim(Copy(Common.CidData.Strings[I],1,12)) = aData then
      begin
        Common.CidData.Delete(I);
        Break;
      end;
    end;
  end;

  procedure OrderCancelGridSave(aRow,aQty:Integer);
  begin
    if FOrderGrid.Cells[GDM_CD_MENU,   aRow]  = '' then Exit;
    if FOrderGrid.Cells[GDM_CD_MENU1,  aRow] <> '' then Exit;

    with Common.Cancel_sGrd do
    begin
      if Cells[0,0] <> '' then RowCount := RowCount + 1;
      Cells[0, RowCount-1] := FOrderGrid.Cells[GDM_CD_MENU,   aRow];
      Cells[1, RowCount-1] := IntToStr( aQty );
      Cells[2, RowCount-1] := Common.WhyOrdercancel;
      if FOrderGrid.Cells[GDM_YN_ORDER,  aRow] = 'Y' then
        cells[3, RowCount-1] := FOrderGrid.Cells[GDM_DT_ORDER,  aRow]
      else
        cells[3, RowCount-1] := '';
      cells[4, RowCount-1] := FOrderGrid.Cells[GDM_YN_ORDER,  aRow];
      cells[5, RowCount-1] := FOrderGrid.Cells[GDM_SEQ,       aRow];
      cells[6, RowCount-1] := FOrderGrid.Cells[GDM_NO_STEP,   aRow];
      cells[7, RowCount-1] := FOrderGrid.Cells[GDM_CD_MENU1,  aRow];
      cells[8, RowCount-1] := FOrderGrid.Cells[GDM_AMT,       aRow];
      cells[9, RowCount-1] := FOrderGrid.Cells[GDM_NM_MENU,   aRow];
      cells[10, RowCount-1] := FOrderGrid.Cells[GDM_ORDERTIME,   aRow];
    end;
  end;
var vIndex :Integer;
    vTemp  :String;
    vBefRow :Integer;
begin
  Common.WriteLog('work', Format('DeliveryNew-DeleteButtonClick(%s)',[lblDeliveryNo.Caption]));
  vBefRow := GridTableView.DataController.GetFocusedRecordIndex;
  if GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewStatus.Index] = msgMissedCall then
  begin
    DeleteReadyData( GetOnlyNumber( GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewTelMobile.Index]));
    GridTableView.DataController.DeleteRecord(GridTableView.DataController.GetFocusedRecordIndex);
    GridTableView.DataController.FocusedRecordIndex := vBefRow-1;
  end
  else
  begin
    if not GetUseCheck(GetOnlyNumber(lblDeliveryNo.Caption)) then Exit;
    if Common.AskBox(Format('배달주문(%s)을'#13'취소하시겠습니까?',[lblDeliveryNo.Caption])) then
    begin
      Common.Table.Name := GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDeliveryNo.Index];
      Common.ClearKitchenData;                   //주문서출력정보 초기화

      if DeliveryStep = dsNone then
      begin
        DeleteDelivery;
        GridTableView.DataController.DeleteRecord(GridTableView.DataController.GetFocusedRecordIndex);
        GridTableView.DataController.FocusedRecordIndex := vBefRow-1;
      end
      else
      begin
        TableViewToStringGrid;
        try
          //////////////////////////  감사저널에 저장  ///////////////////////////////
          For vIndex := 0 to FOrderGrid.RowCount-1 do
          begin
            OrderCancelGridSave(vIndex, StoI( FOrderGrid.Cells[GDM_QTY, vIndex] ) );
            vTemp := FOrderGrid.Cells[GDM_VIEWQTY, vIndex];

            Common.Device.OrderCancel(FOrderGrid, vIndex, vTemp);
          end;

          DM.StoredProc.StoredProcName := 'POS_SAVE_ORDER_CANCEL';
          DM.StoredProc.PrepareSQL;
          For vIndex := 0 to Common.Cancel_sGrd.RowCount-1 do
          begin
            if Common.Cancel_sGrd.Cells[4, vIndex] = 'N' then Continue;
            if Common.Cancel_sGrd.Cells[7, vIndex] <> '' then Continue;
            if Common.Cancel_sGrd.Cells[0, vIndex] = ''  then Continue;


            DM.StoredProc.Close;
            DM.StoredProc.ParamByName('_work_kind').AsInteger:= 2;
            DM.StoredProc.ParamByName('_cd_store').AsString  := Common.Config.StoreCode;
            DM.StoredProc.ParamByName('_no_table').AsInteger := Common.Table.Number;
            DM.StoredProc.ParamByName('_ds_order').AsString  := Common.Table.OrderType;
            DM.StoredProc.ParamByName('_cd_menu').AsString   := Common.Cancel_sGrd.Cells[0, vIndex];
            DM.StoredProc.ParamByName('_seq').AsInteger      := StoI(Common.Cancel_sGrd.Cells[5, vIndex]);
            DM.StoredProc.ParamByName('_no_step').AsInteger  := StoI(Common.Cancel_sGrd.Cells[6, vIndex]);
            DM.StoredProc.ParamByName('_qty_order').AsInteger:= StoI(Common.Cancel_sGrd.Cells[1, vIndex]);
            DM.StoredProc.ParamByName('_ymd_sale').AsString  := Common.WorkDate;
            DM.StoredProc.ExecProc;
          end;
        finally
          Common.Device.OrderPrint(False, ((GetOption(10) ='1') and (GetOption(154)='0')));
          DeleteDelivery;
          GridTableView.DataController.DeleteRecord(GridTableView.DataController.GetFocusedRecordIndex);
          GridTableView.DataController.FocusedRecordIndex := vBefRow-1;
        end;
      end;
    end;
  end;
  isData := GridTableView.DataController.RecordCount > 0;
  isChanged := false;
end;

procedure TDeliveryNew_F.DeleteDelivery;
begin
  try
    Common.BeginTran;

    DM.StoredProc.StoredProcName := 'SAVE_TABLE_CANCEL';
    DM.StoredProc.PrepareSQL;

    DM.StoredProc.Close;
    DM.StoredProc.ParamByName('_cd_store').Value  := Common.Config.StoreCode;
    DM.StoredProc.ParamByName('_ymd_sale').Value  := Common.WorkDate;
    DM.StoredProc.ParamByName('_v_no_table').Value:= FTableNo;
    DM.StoredProc.ParamByName('_no_rcp').Value    := '';
    DM.StoredProc.ParamByName('_ds_order').Value  := 'D';
    DM.StoredProc.ExecProc;

    if DeliveryStep = dsNone then
    begin
      //미주문상태에서 삭제하면 정말삭제한다
      ExecQuery('delete '
               +'  from SL_DELIVERY '
               +' where CD_STORE     =:P0 '
               +'   and YMD_DELIVERY =:P1 '
               +'   and NO_DELIVERY  =:P2 ',
               [Common.Config.StoreCode,
                LeftStr(lblDeliveryNo.Caption,8),
                RightStr(lblDeliveryNo.Caption,4)]);
    end
    else
    begin
      ExecQuery('update SL_DELIVERY '
               +'   set DS_STEP      = ''C'' '
               +' where CD_STORE     =:P0 '
               +'   and YMD_DELIVERY =:P1 '
               +'   and NO_DELIVERY  =:P2 ',
               [Common.Config.StoreCode,
                LeftStr(lblDeliveryNo.Caption,8),
                RightStr(lblDeliveryNo.Caption,4)]);

    end;
    ExecQuery('delete '
             +'  from SL_ORDER_H '
             +' where CD_STORE =:P0 '
             +'   and NO_TABLE =:P1 '
             +'   and DS_ORDER = ''D'' ',
             [Common.Config.StoreCode,
              FTableNo ]);
    ExecQuery('delete '
             +'  from SL_ORDER_D '
             +' where CD_STORE =:P0 '
             +'   and NO_TABLE =:P1 '
             +'   and DS_ORDER = ''D'' ',
             [Common.Config.StoreCode,
              FTableNo ]);

    ExecQuery('delete '
             +'  from SL_ORDER_C '
             +' where CD_STORE =:P0 '
             +'   and NO_TABLE =:P1 '
             +'   and DS_ORDER = ''D'' ' ,
             [Common.Config.StoreCode,
              FTableNo ]);

    ExecQuery('delete '
             +'  from SL_ORDER_PRT '
             +' where CD_STORE =:P0 '
             +'   and NO_TABLE =:P1 '
             +'   and DS_ORDER = ''D'' ',
             [Common.Config.StoreCode,
              FTableNo ]);

    Common.CommitTran;
  except
    on E: Exception do
    begin
      Common.RollbackTran;
      Common.WriteLog('Delivery002',E.Message);
      Common.ErrBox(E.Message);
      Exit;
    end;
  end;
end;

procedure TDeliveryNew_F.TableViewToStringGrid;
var vIndex :Integer;
begin
  FOrderGrid.RowCount := 0;
  with OrderTableView.DataController do
  for vIndex := 0 to RecordCount-1 do
  begin
    FOrderGrid.RowCount := vIndex+1;
    FOrderGrid.Cells[GDM_NO, vIndex]          := Values[vIndex, OrderTableViewNo.Index];
    FOrderGrid.Cells[GDM_CD_MENU, vIndex]     := Values[vIndex, OrderTableViewMenuCode.Index];
    FOrderGrid.Cells[GDM_NM_MENU, vIndex]     := Values[vIndex, OrderTableViewMenuName.Index];
    FOrderGrid.Cells[GDM_TYPE, vIndex]        := Values[vIndex, OrderTableViewType.Index];
    FOrderGrid.Cells[GDM_DS_MENU, vIndex]     := Values[vIndex, OrderTableViewDsMenu.Index];
    FOrderGrid.Cells[GDM_CD_MENU1, vIndex]    := NVL(Values[vIndex, OrderTableViewSubMenuCode.Index],'');
    FOrderGrid.Cells[GDM_SEQ, vIndex]         := NVL(Values[vIndex, OrderTableViewSeq.Index],'');
    FOrderGrid.Cells[GDM_NO_STEP, vIndex]     := NVL(Values[vIndex, OrderTableViewStep.Index],'');
    FOrderGrid.Cells[GDM_PR_SALE, vIndex]     := NVL(Values[vIndex, OrderTableViewSalePrice.Index],'');
    FOrderGrid.Cells[GDM_VIEWQTY, vIndex]     := NVL(Values[vIndex, OrderTableViewViewQty.Index],'');
    FOrderGrid.Cells[GDM_VIEWPRICE, vIndex]   := NVL(Values[vIndex, OrderTableViewViewPrice.Index],'');
    FOrderGrid.Cells[GDM_QTY, vIndex]         := NVL(Values[vIndex, OrderTableViewQty.Index],'');
    FOrderGrid.Cells[GDM_AMT, vIndex]         := NVL(Values[vIndex, OrderTableViewSaleAmt.Index],'');
    FOrderGrid.Cells[GDM_YN_ORDER, vIndex]    := NVL(Values[vIndex, OrderTableViewOrderYN.Index],'');
    FOrderGrid.Cells[GDM_DT_ORDER, vIndex]    := NVL(Values[vIndex, OrderTableViewOrderDate.Index],'');
    FOrderGrid.Cells[GDM_PR_SALE_ORG, vIndex] := NVL(Values[vIndex, OrderTableViewOrgSalePrice.Index],'');
    FOrderGrid.Cells[GDM_PR_SALE_DB, vIndex]  := NVL(Values[vIndex, OrderTableViewDoublePrice.Index],'');
    FOrderGrid.Cells[GDM_DC_MENU, vIndex]     := NVL(Values[vIndex, OrderTableViewMenuDc.Index],'');
    FOrderGrid.Cells[GDM_DS_SALE, vIndex]     := NVL(Values[vIndex, OrderTableViewDsSale.Index],'');
    FOrderGrid.Cells[GDM_DS_TAX, vIndex]      := NVL(Values[vIndex, OrderTableViewDsTax.Index],'');
    FOrderGrid.Cells[GDM_KITCHEN, vIndex]     := NVL(Values[vIndex, OrderTableViewKitchen.Index],'');
    FOrderGrid.Cells[GDM_NO_SPC, vIndex]      := NVL(Values[vIndex, OrderTableViewEventNo.Index],'');
    FOrderGrid.Cells[GDM_DC_SPC, vIndex]      := NVL(Values[vIndex, OrderTableViewEventDc.Index],'');
    FOrderGrid.Cells[GDM_MEMO, vIndex]        := NVL(Values[vIndex, OrderTableViewMemo.Index],'');
    FOrderGrid.Cells[GDM_YN_DC, vIndex]       := NVL(Values[vIndex, OrderTableViewDcYn.Index],'');
    FOrderGrid.Cells[GDM_YN_POINT, vIndex]    := NVL(Values[vIndex, OrderTableViewPointYn.Index],'');
    FOrderGrid.Cells[GDM_YN_RCP, vIndex]      := NVL(Values[vIndex, OrderTableViewRcpYn.Index],'');
    FOrderGrid.Cells[GDM_PRT_KITCHEN, vIndex] := NVL(Values[vIndex, OrderTableViewDsKitchen.Index],'');
    FOrderGrid.Cells[GDM_NO_GROUP, vIndex]    := NVL(Values[vIndex, OrderTableViewGroupNo.Index],'');
    FOrderGrid.Cells[GDM_NM_MENU_ORG, vIndex] := NVL(Values[vIndex, OrderTableViewOrgMenuName.Index],'');
    FOrderGrid.Cells[GDM_CHANGE, vIndex]      := NVL(Values[vIndex, OrderTableViewChangeYn.Index],'');
  end;
end;

procedure TDeliveryNew_F.TakeOutButtonClick(Sender: TObject);
var vCidData   :String;
    vIsTackOut :Boolean;
begin
  case Common.PosType of
    ptOnlyOrder :
    begin
      Common.ErrBox('정산포스에서만 사용이 가능합니다');
      Exit;
    end;
    ptNotAccount :
    begin
       if (Trim(Common.WorkDate) = '') then
       begin
         Common.ErrBox('개점이 안됐습니다'+#13#13+'개점을 해야 사용할 수 있습니다');
         Exit;
       end;
    end;
  end;
  vIsTackOut := Common.Config.IsTakeOut;
  Common.Config.IsTakeOut := true;
  Common.OrderKind := okNew;
  InitTableRecord(Common.Table);
  Order_F := TOrder_F.Create(Application);
  try
    if Order_F.ShowModal = mrAbort then
    begin
      Common.ShowWaitForm('잠시만 기다려 주세요');
      RcpManagerTimer.Enabled := true;
    end;
  finally
    vCidData := Order_F.FCidData;
    FreeAndNil(Order_F);
    Common.Config.IsTakeOut := vIsTackOut;
    if Common.Config.Cid_Port > 0 then
      Common.Device.OnCidReadData :=CidReadEvent;

    if vCidData <> '' then CidReadEvent(vCidData);
  end;
end;

function TDeliveryNew_F.GetUseCheck(aDeliveryNo: String): Boolean;
begin
  OpenQuery('select USE_POSNO '
           +'  from SL_DELIVERY '
           +' where CD_STORE     =:P0 '
           +'   and YMD_DELIVERY =:P1 '
           +'   and NO_DELIVERY  =:P2 ',
           [Common.Config.StoreCode,
            LeftStr(aDeliveryNo,8),
            RightStr(aDeliveryNo,4)]);
  if (Common.Query.Fields[0].AsString <> Common.Config.PosNo) and (Common.Query.Fields[0].AsString <> '') then
  begin
    Common.ErrBox(Common.Query.Fields[0].AsString+'번 포스에서 사용 중 입니다');
    Result := False;
  end
  else Result := True;

  Common.Query.Close;
end;

//그릇회수리스트 출력버튼 클릭
procedure TDeliveryNew_F.btnDishReturnListPrintClick(Sender: TObject);
begin
end;

//그릇회수버튼 클릭
procedure TDeliveryNew_F.btnDishReturnClick(Sender: TObject);
begin
end;

//재인쇄 버튼 클릭
procedure TDeliveryNew_F.GridTableViewCellDblClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
var vIndex :Integer;
begin
  if OrderButton.Enabled and (GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewStatus.Index] = msgMissedCall) then
  begin
    vIndex := GetDeliveryOrderDataIndex(GetOnlyNumber(GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewTelMobile.Index]));
    if vIndex < 0 then
    begin
      edt_TelNo1.Text := GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewTelMobile.Index];
      NewButtonClick(nil);
    end
    else if Common.AskBox(Format('현재 [%s] 상태의 고객입니다'#13#13'신규배달로 주문하시겠습니까?',[GridTableView.DataController.Values[vIndex, GridTableViewStatus.Index]]) ) then
    begin
      edt_TelNo1.Text := GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewTelMobile.Index];
      NewButtonClick(nil);
    end
    else
      DeleteButtonClick(nil);
  end
  else if not isChanged then
    isListMode := not isListMode;
end;

procedure TDeliveryNew_F.GridTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.Selected then
  begin
    ACanvas.Brush.Color := clHighlight;
    ACanvas.Font.Color  := clHighlightText;
  end;
end;

procedure TDeliveryNew_F.GridResize(Sender: TObject);
  procedure SetPopGridCheckBox(aTag:Integer; aCheck:Boolean);
  var vIndex :Integer;
  begin
    For vIndex := 0 to GridPopupMenu.Items.Count-1 do
    begin
      if GridPopupMenu.Items[vIndex].Tag = aTag then
        GridPopupMenu.Items[vIndex].Checked := aCheck;
    end;
  end;
var vIndex   :Integer;
    vRowList :TStringList;
    vColList :TStringList;
    vCol     :Integer;
    vTemp    :String;
begin
  vTemp := Common.GetIniFile('POS','GridTableView','');
  if vTemp <> EmptyStr then
    For vCol := 0 to GridTableView.ColumnCount-1 do
      GridTableView.Columns[vCol].Visible := false;

  vRowList := TstringList.Create;
  vColList := TStringList.Create;
  try
    if vTemp = EmptyStr then
      Exit
    else
    begin
      For vIndex := 0 to GridPopupMenu.Items.Count-1 do
        GridPopupMenu.Items[vIndex].Checked := false;
    end;

    Split(vTemp, #2, vRowList);
    For vIndex := 0 to vRowList.Count-1 do
    begin
      vRowList[vIndex] := Replace(vRowList[vIndex],'|',#2);
      Split(vRowList[vIndex], #2, vColList);
      For vCol := 0 to GridTableView.ColumnCount-1 do
      begin
        if GridTableView.Columns[vCol].Tag = 0 then Continue;
        if StrToInt(vColList[1]) = GridTableView.Columns[vCol].Tag then
        begin
          GridTableView.Columns[vCol].Visible := true;
          GridTableView.Columns[vCol].Position.ColIndex := StrToInt(vColList[0]);
          SetPopGridCheckBox(StrToInt(vColList[1]), true);
          Break;
        end;
      end;
    end;
  finally
    vRowList.Free;
    vColList.Free;
  end;
end;

procedure TDeliveryNew_F.GridTableViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  if ARecord.Values[GridTableViewStatus.Index] = msgDelivery then
    AStyle := styleFontBlue
  else if ARecord.Values[GridTableViewStatus.Index] = msgAcct then
    AStyle := styleFontRed
  else if ARecord.Values[GridTableViewStatus.Index] = msgMissedCall then
    AStyle := styleFontNotTel
  else
    AStyle := styleFontBlack;
end;

procedure TDeliveryNew_F.SetCallStep(AValue: TCallStep);
begin
  FCallStep := AValue;
  case FCallStep of
    csNone :
    begin
      panCall.Visible           := false;
      Grid.Enabled              := true;
      OrderGrid.Enabled         := true;
      panDeliveryInfo.Enabled   := true;
      ButtonPanel.Enabled       := true;
      SaleHistoryPanel.Visible  := false;
    end;
    csCall :
    begin
      panCall.Visible           := true;
      Grid.Enabled              := false;
      OrderGrid.Enabled         := false;
      panDeliveryInfo.Enabled   := false;
      ButtonPanel.Enabled       := false;
      SaleHistoryPanel.Visible  := false;
    end;
    csSaleMenu :
    begin
      panCall.Visible            := false;
      Grid.Enabled               := false;
      OrderGrid.Enabled          := false;
      panDeliveryInfo.Enabled    := false;
      ButtonPanel.Enabled        := false;
      SaleHistoryPanel.Visible   := true;
      SaleHistoryPanel.BringToFront;
    end;
  end;
end;

procedure TDeliveryNew_F.edt_CustNamePropertiesChange(Sender: TObject);
begin
  isChanged := true;
end;

procedure TDeliveryNew_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
  begin
    if edt_TelNo1.Focused and edt_TelNo1.EditModified then
    begin
      edt_TelNo1.Text := SetTelephone(edt_TelNo1.Text);
      SearchButtonClick(SearchButton);
      if Length(GetOnlyNumber(edt_TelNo1.Text)) >= 8 then
      begin
        edt_TelNo1.EditModified := False;
        edt_Address1.SetFocus;
      end
      else edt_TelNo1.SetFocus;
    end
    else if edt_TelNo1.Focused then
      SearchButtonClick(SearchButton)
    else if not meo_Remark.Focused then
      SelectNext(TWinControl(ActiveControl), true,  true);
  end
  else if Key = VK_ESCAPE then
  begin
    if panCall.Visible then
    begin
      CidReadEvent('C'+GetOnlyNumber(lblCallLine.Caption)+'E'+GetOnlyNumber(lblCallNo.Caption));
    end;
  end;

  if Shift = [ssCtrl] then
  begin
    if Key = Ord('T') then
    begin
      CidReadEvent('C1I01011112222');
      Common.AddCidData('C1I01011112222');
    end;
    if Key = Ord('S') then
      CidReadEvent('C1S01011112222');
    if Key = Ord('A') then
      CidReadEvent('C1A');
  end;
end;

procedure TDeliveryNew_F.SetChanged(aChanged: Boolean);
var vIndex :Integer;
begin
  FisChanged := aChanged;
  ButtonPanel.Enabled  := not FisChanged;
  SaveButton.Enabled   := FisChanged;
  CancelButton.Enabled := FisChanged;
  if isNew then
  begin
    lblWork.Visible := true;
    lblWork.Caption := '신규배달';
    MessageLabel.Caption := '신규배달 접수 중입니다.... 작업을 취소하시려면 [취소] 버튼을 클릭하세요';
  end
  else if FisChanged then
  begin
    lblWork.Visible := true;
    lblWork.Caption := '배달수정';
    MessageLabel.Caption := '기존배달 수정 중입니다.... 작업을 취소하시려면 [취소] 버튼을 클릭하세요';
  end
  else
  begin
    lblWork.Visible      := false;
    MessageLabel.Caption := '';
  end;

  if not aChanged then
  begin
    ViewModeButton.Visible := true;
    SetUsePos('');
    if CallStep = csNone then
      Self.ActiveControl := Grid;

    for vIndex := 0 to ButtonPanel.ControlCount-1 do
      if ButtonPanel.Controls[vIndex] is TAdvGlassButton then
        TAdvGlassButton(ButtonPanel.Controls[vIndex]).Font.Color := clWhite;
  end
  else
  begin
    ViewModeButton.Visible := false;
    for vIndex := 0 to ButtonPanel.ControlCount-1 do
      if ButtonPanel.Controls[vIndex] is TAdvGlassButton then
        TAdvGlassButton(ButtonPanel.Controls[vIndex]).Font.Color := clGray;
  end;
end;

procedure TDeliveryNew_F.SetListMode(aMode: Boolean);
begin
  FListMode := aMode;
  if FListMode then
  begin
    Grid.Width          := Self.Width - Ifthen(ButtonPanel.Visible, 127, 0) - 15;
    panManagement.Left  := ButtonPanel.Left;
    panManagement.Top   := Grid.Top;
    panManagement.Width := Grid.Width + ButtonPanel.Width + 10;
    panManagement.Height := Grid.Height;
    OrderGrid.Visible       := false;
    panDeliveryInfo.Visible := false;
    ViewModeButton.Picture := ViewModeButton.PictureDown;
    ViewModeButton.Caption := '상세';
  end
  else
  begin
    Grid.Width          := Grid.Tag;
    panManagement.Left  := ButtonPanel.Left;
    panManagement.Top   := Grid.Top;
    panManagement.Width := Grid.Width + ButtonPanel.Width + 10;
    panManagement.Height := Grid.Height;
    OrderGrid.Visible       := true;
    panDeliveryInfo.Visible := true;
    ViewModeButton.Picture := ViewModeButton.PictureDisabled;
    ViewModeButton.Caption := '리스트';

    if (GridTableView.DataController.GetFocusedRecordIndex >= 0) and (GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewStatus.Index] <> msgMissedCall) then
      SetDeliveryDisplay;
  end;
end;

procedure TDeliveryNew_F.DeliveryButtonClick(Sender: TObject);
begin
  if Sender = DeliveryButton then
  begin
    DeliveryButton.Appearance.SimpleLayout := true;
    PackingButton.Appearance.SimpleLayout  := false;
    DeliveryButton.Color := $00DF7000;
    PackingButton.Color  := $00793D00;
  end
  else
  begin
    DeliveryButton.Appearance.SimpleLayout := false;
    PackingButton.Appearance.SimpleLayout  := true;
    DeliveryButton.Color := $00793D00;
    PackingButton.Color  := $00DF7000;
  end;
  isChanged := true;
end;

procedure TDeliveryNew_F.DeliveryGoButtonClick(Sender: TObject);
var vIndex   :Integer;
    vIndex1  :Integer;
    vRowList :TStringList;
begin
  if OrderTableView.DataController.RecordCount = 0 then
  begin
    Common.ErrBox('주문내역이 없습니다');
    Exit;
  end;
  Common.WriteLog('work', 'DeliveryNew-DeliveryGoButtonClick');

  //배달담당자를 사용 시 배달담당자를 지정한다
  if (GetOption(120) = '0') and (not GetDeliveryMan) then
  begin
    if not Common.AskBox('배달담당자가 지정되지 않았습니다'+#13#13+'계속하시겠습니까?') then Exit;
  end;



  vRowList := TStringList.Create;
  vRowList.Clear;
  FBeforStep := dsOrder;
  try
    Common.BeginTran;
    FDeliveryDate := now();
    DeliveryStep  := dsDelivery;
    if GridTableView.Controller.SelectedRecordCount > 0 then
      For vIndex := 0 to GridTableView.Controller.SelectedRecordCount-1 do
      begin
//        if GridTableView.Controller.SelectedRecords[vIndex].Values[GridTableViewStatus.Index] <> '주문' then Continue;
        vRowList.Add(IntToStr(GridTableView.Controller.SelectedRecords[vIndex].RecordIndex));
        ExecQuery('update SL_DELIVERY '
                 +'   set CD_SAWON =:P2, '
                 +'       DS_STEP  =''D'', '
                 +'       DT_DELIVERY = Now() '
                 +' where CD_STORE =:P0 '
                 +'   and ConCat(YMD_DELIVERY,NO_DELIVERY) =:P1 ',
                 [Common.Config.StoreCode,
                  GetOnlyNumber(GridTableView.Controller.SelectedRecords[vIndex].Values[GridTableViewDeliveryNo.Index]),
                  FDeliveryMan]);

        if GridTableView.Controller.SelectedRecords[vIndex].Values[GridTableViewStatus.Index] <> msgAcct then
          GridTableView.Controller.SelectedRecords[vIndex].Values[GridTableViewStatus.Index]  := msgDelivery;
        GridTableView.Controller.SelectedRecords[vIndex].Values[GridTableViewDamdang.Index] := Common.DamdangName;
      end
    else
    begin
      vRowList.Add(IntToStr(GridTableView.DataController.GetFocusedRecordIndex));
      ExecQuery('update SL_DELIVERY '
               +'   set CD_SAWON    =:P2, '
               +'       DS_STEP     =''D'', '
               +'       DT_DELIVERY = Now() '
               +' where CD_STORE =:P0 '
               +'   and ConCat(YMD_DELIVERY,NO_DELIVERY) =:P1 ',
               [Common.Config.StoreCode,
                GetOnlyNumber(GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDeliveryNo.Index]),
                FDeliveryMan]);

      GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewStatus.Index]  := msgDelivery;
      GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewDamdang.Index] := Common.DamdangName;
    end;
    Common.CommitTran;
  except
    on E: Exception do
    begin
      Common.RollbackTran;
      Common.ErrBox(E.Message+#13#13+'저장하지 못했습니다');
      Exit;
    end;
  end;

  OrderTableView.Controller.ClearSelection;
  for vIndex := 0 to vRowList.Count-1 do
  begin
    OrderTableView.Controller.FocusedRecordIndex := StrToInt(vRowList.Strings[vIndex]);
    //배달전표
    For vIndex1 := 1 to StoI(GetOption(189)) do
      Common.Device.DeliveryPrint;

    //고객영수증 출력
    if (GetOption(119) = '1') then
      Common.Device.DeliveryReceiptPrint;
  end;
end;

procedure TDeliveryNew_F.DeliveryNoMenuClick(Sender: TObject);
var vIndex :Integer;
begin
  // 칼럼 선택을 토글한다
  (Sender as TMenuItem).Checked := not (Sender as TMenuItem).Checked;
  For vIndex := 0 to GridTableView.ColumnCount-1 do
    if GridTableView.Columns[vIndex].Tag = (Sender as TMenuItem).Tag then
      GridTableView.Columns[vIndex].Visible := (Sender as TMenuItem).Checked;
end;

procedure TDeliveryNew_F.DeliverySearchButtonClick(Sender: TObject);
begin
  GridTableViewStatus.DataBinding.Filter.Clear;
  GridTableViewStatus.DataBinding.AddToFilter(nil, foEqual, msgDelivery);
  GridTableView.DataController.Filter.Active := true;
  GridTableView.Controller.FocusedRecordIndex := GridTableView.DataController.RecordCount-1;
  isData    := GridTableView.Controller.FocusedRecordIndex >=0 ;
  panDeliveryInfo.Enabled := isData;
  isNotTel  := false;
  isChanged := false;
  SearchPanel.Visible := false;
  StatusSearchButton.Caption := '배달상태';
end;

procedure TDeliveryNew_F.DishListButtonClick(Sender: TObject);
var vTemp,
    vCode,
    vName,
    vSql  :String;
    vIndex :Integer;
begin
  if GridTableView.Controller.SelectedRecordCount > 1 then
  begin
    vTemp := EmptyStr;
    For vIndex :=0 to GridTableView.Controller.SelectedRecordCount-1 do
    begin
      if GridTableView.Controller.SelectedRecords[vIndex].Values[GridTableViewStatus.Index] <> msgAcct then Continue;
      vTemp := vTemp + Format('''%s'',',[GetOnlyNumber(GridTableView.Controller.SelectedRecords[vIndex].Values[GridTableViewDeliveryNo.Index])]);
    end;
    if vTemp = EmptyStr then Exit;

    vTemp := Format(' and ConCat(a.YMD_DELIVERY,a.NO_DELIVERY) in (%s) ',[LeftStr(vTemp, Length(vTemp)-1)]);
    Common.Device.DeliveryDishRetrunListPrint(vTemp);
    if (GetOption(380) = '1') and Common.AskBox('출력 된 회수리스트 배달을'#13#13'그릇회수 완료로 처리하시겠습니까?') then
    begin
      try
        ExecQuery('update SL_DELIVERY '
                 +'   set DS_STEP  =''R'' '
                 +' where CD_STORE =:P0 '
                 +Replace(vTemp, 'a.',''),
                 [Common.Config.StoreCode]);
        GridTableView.DataController.DeleteSelection;
      except
        on E: Exception do
        begin
          Common.RollbackTran;
          Common.WriteLog('DeliveryNew001',E.Message);
          Common.ErrBox(E.Message);
          Exit;
        end;
      end;
    end;
    GridTableView.Controller.ClearSelection;
  end
  else
  begin
    OpenQuery('select Count(*) '
             +'  from SL_DELIVERY '
             +' where CD_STORE =:P0 '
             +'   and DS_ORDER =''D'' '
             +'   and DS_STEP  =''A'' '
             +'   and Length(CD_COURSE) = 3 ',
             [Common.Config.StoreCode]);

    if Common.Query.Fields[0].AsInteger > 0 then
    begin
      vSql := 'select ''A'' as CD_CODE, '
             +'       ''전체'' as NM_COURSE, '
             +'       Count(*) as CNT_DELIVERY '
             +'  from SL_DELIVERY '
             +' where CD_STORE =:P0 '
             +'   and DS_ORDER =''D'' '
             +'   and DS_STEP  =''A'' '
             +' union all '
             +'select a.CD_COURSE, '
             +'       ifnull(Max(b.NM_CODE1),''미지정'') as NM_COURSE, '
             +'       Count(*) as CNT_DELIVERY '
             +'  from SL_DELIVERY a left outer join '
             +'       MS_CODE     b on a.CD_STORE = b.CD_STORE and a.CD_COURSE = b.CD_CODE and b.CD_KIND = ''20'' '
             +' where a.CD_STORE =:P0 '
             +'   and a.DS_ORDER = ''D'' '
             +'   and a.DS_STEP  = ''A''  '
             +' group by a.CD_COURSE ';

      if Common.ShowChooseForm('C','',vCode, vName, vSql) then
      begin
        if Common.Device.DeliveryDishRetrunListPrint(vCode) then
        begin
          if (GetOption(380) = '1') and Common.AskBox('출력 된 회수리스트 배달을'#13#13'그릇회수 완료로 처리하시겠습니까?') then
          begin
            try
              if vCode <> 'A' then
                vTemp := Format(' and ifnull(CD_COURSE,'''') = ''%s'' ',[vCode])
              else
                vTemp := EmptyStr;

              ExecQuery('update SL_DELIVERY '
                       +'   set DS_STEP  =''R'' '
                       +' where CD_STORE =:P0 '
                       +'   and DS_ORDER =''D'' '
                       +'   and DS_STEP  =''A'' '
                       +vTemp,
                       [Common.Config.StoreCode]);
              AllSearchButton.Click;
            except
              on E: Exception do
              begin
                Common.WriteLog('DeliveryNew0021',E.Message);
                Common.ErrBox(E.Message);
              end;
            end;
          end;
        end;
      end;
    end
    else
    begin
      if Common.Device.DeliveryDishRetrunListPrint('A') then
        if (GetOption(380) = '1') and Common.AskBox('출력 된 회수리스트 배달을'#13#13'그릇회수 완료로 처리하시겠습니까?') then
        begin
          try
            ExecQuery('update SL_DELIVERY '
                     +'   set DS_STEP  =''R'' '
                     +' where CD_STORE =:P0 '
                     +'   and DS_ORDER =''D'' '
                     +'   and DS_STEP  =''A'' ',
                     [Common.Config.StoreCode]);
            AllSearchButton.Click;
          except
            on E: Exception do
            begin
              Common.WriteLog('DeliveryNew003',E.Message);
              Common.ErrBox(E.Message);
            end;
          end;
        end;
    end;
  end;
end;

procedure TDeliveryNew_F.DishReturnButtonClick(Sender: TObject);
  function GetRecallMan: String;
  var vCode, vName :String;
  begin
    Result := EmptyStr;
    if Common.ShowChooseForm('D','',vCode,vName) then
    begin
      Result := vCode;
    end;
  end;
var vTemp :String;
    vIndex :Integer;
begin
  //그릇회수 시 담당자를 사용할때
  if GetOption(144) = '1' then
  begin
    vTemp := GetRecallMan;
    if vTemp = EmptyStr then
    begin
      Common.ErrBox('그릇회수담당자가 지정되지 않았습니다');
      Exit;
    end;
  end;

  try
    Common.BeginTran;
    For vIndex := 0 to GridTableView.Controller.SelectedRecordCount-1 do
    begin
      if GridTableView.Controller.SelectedRecords[vIndex].Values[GridTableViewStatus.Index] <> msgAcct then Continue;
      ExecQuery('update SL_DELIVERY '
               +'   set RECALL_SAWON =:P2, '
               +'       DS_STEP      =''R'' '
               +' where CD_STORE =:P0 '
               +'   and ConCat(YMD_DELIVERY,NO_DELIVERY) =:P1 ',
               [Common.Config.StoreCode,
                GetOnlyNumber(GridTableView.Controller.SelectedRecords[vIndex].Values[GridTableViewDeliveryNo.Index]),
                vTemp]);
    end;
    Common.CommitTran;
  except
    on E: Exception do
    begin
      Common.RollbackTran;
      Common.WriteLog('Delivery003',E.Message);
      Common.ErrBox(E.Message);
      Exit;
    end;
  end;
  GetDeliveryList;
end;

procedure TDeliveryNew_F.SetData(aData: Boolean);
begin
  FisData := aData;
  if FisData then
  begin
    panDeliveryInfo.Enabled := true;
    OrderGrid.Enabled           := true;
  end
  else
  begin
    ClearDeliveryData;
    panDeliveryInfo.Enabled := false;
    OrderGrid.Enabled           := false;
    OrderTableView.DataController.RecordCount   := 0;
    HistoryTableView.DataController.RecordCount := 0;
  end;
end;

procedure TDeliveryNew_F.OrderButtonClick(Sender: TObject);
var Rtn :TModalResult;
    vRow :Integer;
begin
  if MilliSecondsBetween(Now(),ClickTime) < 1500 then Exit;
  ClickTime := Now;
  try
    if (GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewType.Index] <> '배달의민족') and
       (Trim(edt_TelNo1.Text) = ''  ) and
       (Trim(edt_TelNo2.Text) = ''  ) and
       (Trim(edt_TelNo3.Text) = ''  ) and
       (Trim(edt_TelNo4.Text) = ''  ) then
    begin
      Common.ErrBox('주문자 전화번호가 없습니다'+#13#13+'전화번호를 입력하세요');
      edt_CustName.SetFocus;
      Exit;
    end;

    vRow := GridTableView.DataController.GetFocusedRecordIndex;
    if isNew then vRow := vRow + 1;
    //미주문 상태였으면 저장을 한다
    if DeliveryStep = dsNone then
    begin
      if (GetOption(392) <> '0') and (Sender = OrderButton) and (MemberCode = '')  then
      begin
        if (GetOption(392) = '2') or ((GetOption(392) = '1') and Common.AskBox('신규고객입니다'#13#13'회원으로 저장하시겠습니까?')) then
          MemberSaveButtonClick(nil);
      end;

      if not DataSave then Exit;
    end;

    InitTableRecord(Common.Table);
    Common.Table.Number     := FTableNo;
    Common.Config.IsTakeOut := false;
    Common.Table.OrderType  := 'D';
    Common.Table.GroupType  := 'N';
    Common.Table.Course     := CourseButton.Caption;
    Common.Table.Local      := LocalButton.Caption;
    Common.Table.Addr1      := edt_Address1.Text;
    Common.Table.Addr2      := edt_Address2.Text;
    if Trim(edt_TelNo1.Text) <> '' then
      Common.Table.DeliveryTel := edt_TelNo1.Text
    else if Trim(edt_TelNo2.Text) <> '' then
      Common.Table.DeliveryTel := edt_TelNo2.Text;

    Common.SetAgeInfo('');

    if isNew then
    begin
      Common.OrderKind     := okNew;
      lblOrderDate.Caption := FormatDateTime('yyyy년 mm월 dd일 hh시 nn분', now());
    end
    else
      Common.OrderKind    := okAppend;

    Common.Table.Date  := FormatDateTime('yyyymmdd',now());
    Common.Table.Time  := FormatDateTime('hh:nn',now());
    Common.Table.Name  := Ifthen(DeliveryButton.Appearance.SimpleLayout, '배달','포장') + '('+ lblDeliveryNo.Caption + ')';
    OpenQuery('select CD_CODE, '
             +'       RT_DC, '
             +'       AMT_DC, '
             +'       DC_MENU, '
             +'       AMT_CODEDC, '
             +'       (select Count(*) '
             +'          from SL_ORDER_D '
             +'         where CD_STORE = a.CD_STORE '
             +'           and NO_TABLE = a.NO_TABLE '
             +'           and DS_ORDER = ''D '') as ORDER_CNT '
             +'  from SL_ORDER_H as a '
             +' where CD_STORE =:P0 '
             +'   and NO_TABLE =:P1 '
             +'   and DS_ORDER =''D'' ',
             [Common.Config.StoreCode,
              Common.Table.Number]);
    if not Common.Query.Eof then
    begin
      Common.Table.DcCode      := Common.Query.FieldByName('cd_code').AsString;
      Common.Table.Dc_Rate     := Common.Query.FieldByName('rt_dc').AsInteger;
      Common.Table.Dc_Amt      := Common.Query.FieldByName('amt_dc').AsInteger;
      Common.Table.Dc_Menu     := Common.Query.FieldByName('dc_menu').AsInteger;
      Common.Table.Dc_CodeAmt  := Common.Query.FieldByName('amt_codedc').AsInteger;
      if Common.Query.FieldByName('ORDER_CNT').AsInteger > 0 then
        Common.OrderKind         := okAppend
      else
        Common.OrderKind         := okNew;
    end
    else
    begin
      ExecQuery('insert into SL_ORDER_H(CD_STORE, '
               +'	    	                NO_TABLE, '
               +'	    	                DS_ORDER, '
               +'	    	                TABLE_STATE, '
               +'	    	                LAST_POS) '
               +'                values(:P0, '
               +'	    	                :P1, '
               +'	    	                ''D'', '
               +'	    	                ''Y'', '
               +'	    	                :P2)',
               [Common.Config.StoreCode,
                Common.Table.Number,
                Common.Config.PosNo,
                Common.Config.UserCode]);
      Common.OrderKind         := okNew;
    end;
    Common.Query.Close;

    Common.Table.DeliveryNo := GetOnlyNumber(lblDeliveryNo.Caption);
    isChanged := true;

    Order_F := TOrder_F.Create(self);
    FBefOrderAmt       := FOrderAmt;
    FBefRowCount       := FRowCount;
    Common.Table.MemberCode :=MemberCode;
    Common.ShowSaleDualScreen;
    try
      FBeforStep := DeliveryStep;
      Rtn := Order_F.ShowModal;
      case Rtn of
        mrOK,
        mrCancel : DeliveryStep := dsOrder;
        mrYes    : DeliveryStep := dsAccount;
      end;
      GetOrderMenu;
      isNew := false;
      if Rtn <> mrCancel then
        SaveButtonClick(nil);
      if vRow <= GridTableView.DataController.RecordCount-1 then
        GridTableView.DataController.FocusedRecordIndex := vRow
      else
        GridTableView.DataController.FocusedRecordIndex := vRow-1;

      GridTableViewFocusedRecordChanged(nil,nil,nil,false);
    finally
      FreeAndNil(Order_F);
      Common.WorkKind  := wkSale;
      Common.ShowNormalDualScreen;
      if isAbsent then
        SetAbsentCall(false);
    end;
  finally
    Common.ClearKitchenData;
  end;
end;

procedure TDeliveryNew_F.OrderPrintMenuClick(Sender: TObject);
begin
  RePrint_F := TRePrint_F.Create(Application);
  try
    Common.Table.Number     := FTableNo;
    if GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewType.Index] = '배달의민족' then
      Common.Table.Name := Format('배달의민족 - %s',[GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewBaeminOrderNo.Index]])
    else
      Common.Table.Name       := '배달('+lblDeliveryNo.Caption+')';
    Common.Table.Memo       := meo_Remark.Text;
    Common.Table.DeliveryNo := GetOnlyNumber(lblDeliveryNo.Caption);
    Common.Table.Course     := CourseButton.Caption;
    Common.Table.Local      := LocalButton.Caption;
    Common.Table.Addr1      := edt_Address1.Text;
    Common.Table.Addr2      := edt_Address2.Text;
    if Trim(edt_TelNo1.Text) <> '' then
      Common.Table.DeliveryTel := edt_TelNo1.Text
    else if Trim(edt_TelNo2.Text) <> '' then
      Common.Table.DeliveryTel := edt_TelNo2.Text;
    
    Common.Table.OrderType  := 'D';
    RePrint_F.ShowModal;
  finally
    FreeAndNil(RePrint_F);
  end;
end;

procedure TDeliveryNew_F.OrderSearchButtonClick(Sender: TObject);
begin
  GridTableViewStatus.DataBinding.Filter.Clear;
  GridTableViewStatus.DataBinding.AddToFilter(nil, foEqual, msgNoOrder);
  GridTableViewStatus.DataBinding.AddToFilter(nil, foEqual, msgOrder);
  GridTableView.DataController.Filter.Active := true;
  GridTableView.Controller.FocusedRecordIndex := GridTableView.DataController.RecordCount-1;
  isData    := GridTableView.Controller.FocusedRecordIndex >=0 ;
  panDeliveryInfo.Enabled := isData;
  isNotTel  := false;
  isChanged := false;
  StatusSearchButton.Caption := '주문상태';
  SearchPanel.Visible := false;
end;

procedure TDeliveryNew_F.BillPrintMenuClick(Sender: TObject);
begin
  case DeliveryStep of
    dsOrder :
    begin
      //주문시 배달전표출력
      if (StoI(GetOption(143)) > 0) then Common.Device.DeliveryPrint;
      //주문 시 고객영수증을 출력합니다.
      if (StoI(GetOption(186)) > 0) then Common.Device.DeliveryReceiptPrint;
    end;
    dsDelivery :
    begin
      //배달 시 배달전표를           장 출력합니다.
      if (StoI(GetOption(189)) > 0) then Common.Device.DeliveryPrint;
      //배달 시 고객영수증을 출력합니다.
      if (StoI(GetOption(119)) > 0) then Common.Device.DeliveryReceiptPrint;
    end;
    dsAccount :
    begin
      //계산 시 배달전표를           장 출력합니다.
      if (StoI(GetOption(145)) > 0) then Common.Device.DeliveryPrint;
      //계산 시 고객영수증을 출력합니다.
      if (StoI(GetOption(190)) > 0) then Common.Device.DeliveryReceiptPrint;
    end;
  end;
end;

procedure TDeliveryNew_F.OrderGridResize(Sender: TObject);
var vIndex   :Integer;
    vColList :TStringList;
    vCol     :Integer;
    vTemp    :String;
begin
  vColList := TStringList.Create;

  try
    vTemp := Common.GetIniFile('POS','OrderTableView','');
    if vTemp <> EmptyStr then
    begin
      Split(vTemp, #2, vColList);
      For vIndex := 0 to vColList.Count-1 do
        OrderTableView.Columns[vIndex].Width := StrToInt(vColList[vIndex]);
    end;

    vTemp := Common.GetIniFile('POS','HistoryTableView','');
    if vTemp <> EmptyStr then
    begin
      Split(vTemp, #2, vColList);
      For vIndex := 0 to vColList.Count-1 do
        HistoryTableView.Columns[vIndex].Width := StrToInt(vColList[vIndex]);
    end;
  finally
    vColList.Free;
  end;
end;

procedure TDeliveryNew_F.Grid2Resize(Sender: TObject);
var vIndex   :Integer;
    vColList :TStringList;
    vCol     :Integer;
    vTemp    :String;
begin
  bvGridView.Bands[0].Width := Grid2.Width-15;
  vColList := TStringList.Create;

  try
    vTemp := Common.GetIniFile('POS','bvGridView','');
    if vTemp <> EmptyStr then
    begin
      Split(vTemp, #2, vColList);
      For vIndex := 0 to vColList.Count-1 do
        bvGridView.Columns[vIndex].Width := StrToInt(vColList[vIndex]);
    end;

    vTemp := Common.GetIniFile('POS','tvGridView','');
    if vTemp <> EmptyStr then
    begin
      Split(vTemp, #2, vColList);
      For vIndex := 0 to vColList.Count-1 do
        tvGridView.Columns[vIndex].Width := StrToInt(vColList[vIndex]);
    end;
  finally
    vColList.Free;
  end;
end;

procedure TDeliveryNew_F.SetCustomerInfo(aValue: String);
var vIsSearch :Boolean;
begin
  OpenQuery('select 1 as SEQ, '
           +'		    NM_MEMBER	as NM_NAME, '
           +'			  ADDR1		as ADDRESS1, '
           +'			  ADDR2		as ADDRESS2 '
           +'	 from MS_MEMBER '
           +' where CD_STORE 	=:P0 '
           +' 	and (TEL_MOBILE = :P1'
           +'		   or TEL_HOME  = :P1'
           +'		   or TEL_ETC1  = :P1'
           +'		   or TEL_ETC2  = :P1) '
           +'  and DS_STATUS = ''0'' '
           +'	union all  '
           +'select 2 as SEQ, '
           +'		    NM_NAME, '
           +'		    ADDRESS1, '
           +'		    ADDRESS2 '
           +'  from SL_DELIVERY '
           +' where CD_STORE 	= :P0 '
           +'	  and NO_TEL1   = :P1 '
           +' limit 1 ',
           [Common.Config.StoreCode,
            aValue]);
  if not Common.Query.Eof then
  begin
    lblCallStatus.Caption   := '신규주문';
    lblCallCustName.Caption := Common.Query.FieldByName('NM_NAME').AsString;
  end
  else
  begin
    lblCallStatus.Caption   := '신규고객';
    lblCallCustName.Caption := EmptyStr;
  end;
  Common.Query.Close;
end;

procedure TDeliveryNew_F.StartTimerTimer(Sender: TObject);
begin
  StartTimer.Enabled := false;
  CidReadEvent(FCidTelNo);
  FCidTelNo := EmptyStr;

end;

procedure TDeliveryNew_F.StatusSearchButtonClick(Sender: TObject);
begin
  SearchPanel.Top     := ButtonPanel.Top + ButtonPanel.Height - SearchPanel.Height - 5;
  SearchPanel.Left    := ButtonPanel.Left + ButtonPanel.Width + 5;
  SearchPanel.Visible := not SearchPanel.Visible;
end;

procedure TDeliveryNew_F.LocalButtonClick(Sender: TObject);
var vCode, vName :String;
begin
  if Common.ShowChooseForm('L','',vCode,vName) then
  begin
    LocalButton.Caption := vName;
    LocalButton.Hint    := vCode;
    edt_Address1.SetFocus;
    edt_Address1.SetSelection(Length(edt_Address1.Text),1);
  end
  else
  begin
    LocalButton.Caption := '';
    LocalButton.Hint    := '';
  end;
  Common.Table.Local := LocalButton.Caption;

  isChanged := true;
end;

procedure TDeliveryNew_F.bvGridViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  if ARecord.Values[bvGridViewStatus.Index] = '배달 중' then
    AStyle := styleFontBlue2
  else if ARecord.Values[bvGridViewStatus.Index] = msgOrderCancel then
    AStyle := styleFontRed2
  else if (ARecord.Values[bvGridViewStatus.Index] = msgOrder) or (ARecord.Values[bvGridViewStatus.Index] = msgNoOrder) then
    AStyle := styleFontNotTel2
  else
    AStyle := styleFontBlack2;
end;

procedure TDeliveryNew_F.tvGridViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  if ARecord.Values[tvGridViewStatus.Index] = msgNoOrder then
    AStyle := styleFontRed2;
end;

procedure TDeliveryNew_F.ViewModeButtonClick(Sender: TObject);
begin
  isListMode := not isListMode;
end;

procedure TDeliveryNew_F.edt_TelNo1Exit(Sender: TObject);
begin
  (Sender as TcxTextEdit).Text := SetTelephone((Sender as TcxTextEdit).Text);
end;

procedure TDeliveryNew_F.panDeliveryInfoEnter(Sender: TObject);
begin
  if GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewStatus.Index] = msgMissedCall then
  begin
    NewButton.Click;
    Exit;
  end;
  if not GetUseCheck(GetOnlyNumber(lblDeliveryNo.Caption)) then
    Grid.SetFocus
  else
  begin
    SetUsePos(Common.Config.PosNo);
  end;
end;

procedure TDeliveryNew_F.PostButtonClick(Sender: TObject);
begin
  DeliveryAddr_F := TDeliveryAddr_F.Create(Application);
  try
    if DeliveryAddr_F.ShowModal = mrOK then
    begin
      edt_Address1.Text := DeliveryAddr_F.FAddress;
      if DeliveryAddr_F.CourseCode <> '' then
      begin
        CourseButton.Hint    := DeliveryAddr_F.CourseCode;
        CourseButton.Caption := DeliveryAddr_F.CourseName;
      end
      else
      begin
        CourseButton.Hint    := '';
        CourseButton.Caption := '';
      end;
      if DeliveryAddr_F.LocalCode <> '' then
      begin
        LocalButton.Hint    := DeliveryAddr_F.LocalCode;
        LocalButton.Caption := DeliveryAddr_F.LocalName;
      end
      else
      begin
        LocalButton.Hint    := '';
        LocalButton.Caption := '';
      end;
      if DeliveryAddr_F.DamdangCode <> '' then
      begin
        FDeliveryMan  := DeliveryAddr_F.DamdangCode;
        lblDeliveryDamdang.Caption := DeliveryAddr_F.DamdangName;
      end
      else
      begin
        FDeliveryMan  := '';
        lblDeliveryDamdang.Caption := '';
      end;
      edt_Address2.SetFocus;
    end;
  finally
    FreeAndNil(DeliveryAddr_F);
  end;
end;

procedure TDeliveryNew_F.RcpManagerTimerTimer(Sender: TObject);
begin
  //선불제에서 영수증관리
  RcpManagerTimer.Enabled := false;
  RcpChange_F := TRcpChange_F.Create(Self);
  try
    Order_F := TOrder_F.Create(Self);

    RcpChange_F.ShowMode := fsmNone;
    RcpChange_F.ShowModal;
  finally
    FreeAndNil(RcpChange_F);
    if Assigned(Order_F) then
      FreeAndNil(Order_F);

    TakeOutButton.Click;
  end;
end;

procedure TDeliveryNew_F.ReprintButtonClick(Sender: TObject);
begin
  RePrint_F := TRePrint_F.Create(Application);
  try
    Common.Table.Number     := FTableNo;
    Common.Table.Name       := '배달('+lblDeliveryNo.Caption+')';
    Common.Table.DeliveryNo := lblDeliveryNo.Caption;
    Common.Table.Course     := CourseButton.Caption;
    Common.Table.Local      := LocalButton.Caption;
    Common.Table.Addr1      := edt_Address1.Text;
    Common.Table.Addr2      := edt_Address2.Text;
    if Trim(edt_TelNo1.Text) <> '' then
      Common.Table.DeliveryTel := edt_TelNo1.Text
    else if Trim(edt_TelNo2.Text) <> '' then
      Common.Table.DeliveryTel := edt_TelNo2.Text;

    Common.Table.OrderType  := 'D';
    if RePrint_F.ShowModal = mrYesToAll then
      Common.Device.DeliveryPrint;
  finally
    FreeAndNil(RePrint_F);
  end;
end;

procedure TDeliveryNew_F.RequestItemButtonClick(Sender: TObject);
var vCode, vName :String;
begin
  if Common.ShowChooseForm('I','',vCode,vName) then
  begin
    meo_Remark.Text := meo_Remark.Text + Ifthen(meo_Remark.Text <> '', #13, '') + vName;
    meo_Remark.SetFocus;
    meo_Remark.SelStart := Length(meo_Remark.Text)+1;
  end;
end;

procedure TDeliveryNew_F.RiderCallButtonClick(Sender: TObject);
var vTemp :String;
    vIndex :Integer;
begin
  if (Trim(edt_TelNo1.Text) = ''  ) and
     (Trim(edt_TelNo2.Text) = ''  ) and
     (Trim(edt_TelNo3.Text) = ''  ) and
     (Trim(edt_TelNo4.Text) = ''  ) then
  begin
    Common.ErrBox('주문자 전화번호가 없습니다'+#13#13+'전화번호를 입력하세요');
    Exit;
  end;

  if (edt_Address1.Text = '') and (edt_Address2.Text = '') then
  begin
    Common.MsgBox('배달 주소가 없습니다');
    Exit;
  end;

  vTemp := rptSizeHeight + rptCharBold + rptAlignCenter +'배민1 주문전표' + rptLF
         + rptSizeHeight + rptAlignLeft +'주문번호 EXPOS '+ rptLF
         + rptSizeNormal + rptOneLine + rptLF
         + '배달주소:' + rptLF
         + rptSizeHeight + rptAlignLeft + edt_Address1.Text + rptLF
         + rptSizeNormal + rptCharNormal + edt_Address2.Text + rptLF + rptLF
         + '연락처:' + rptLF
         + rptSizeHeight + rptCharBold + edt_TelNo1.Text + rptLF
         + rptSizeNormal + rptCharNormal + rptOneLine + rptLF
         +'메뉴명                     수량       금액'+rptLF
         + rptSizeNormal + rptCharNormal + rptOneLine + rptLF;
  for vIndex := 0 to OrderTableView.DataController.RecordCount-1 do
    vTemp := vTemp
           + rptSizeHeight + rptCharBold + OrderTableView.DataController.Values[vIndex, OrderTableViewMenuName.Index] + rptLF
           + Format('%28.28s%14.14s',[OrderTableView.DataController.Values[vIndex, OrderTableViewViewQty.Index],
                                                       FormatFloat(',0',OrderTableView.DataController.Values[vIndex, OrderTableViewSaleAmt.Index])]) + rptLF;

  vTemp := vTemp
         + rptSizeNormal + rptOneLine + rptLF
         + rptSizeHeight + rptCharBold + '합계'+Ifthen(CardButton.Appearance.SimpleLayout,'(후불카드)','          ') + Format('%28.28s',[OrderTableView.DataController.Summary.FooterSummaryTexts[0]]) + rptLF
         + rptSizeNormal+ rptOneLine + rptLF
         +'주문번호: '+lblDeliveryNo.Caption + rptLF
         +FormatDateTime('yyyy.mm.dd hh:nn',Now()) + rptLF;

//  Common.Device.RiderCall(vTemp);
end;

procedure TDeliveryNew_F.tvGridViewCellDblClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  if Common.AskBox(Format('%s 번호로'#13#13'신규주문 하시겠습니까?',[tvGridView.DataController.Values[tvGridView.DataController.GetFocusedRecordIndex, tvGridViewTelNo.Index]])) then
  begin
    Close2Button.Click;
    ClearDeliveryData;
    edt_TelNo1.Text := tvGridView.DataController.Values[tvGridView.DataController.GetFocusedRecordIndex, tvGridViewTelNo.Index];
    NewButtonClick(nil);
  end;
end;

procedure TDeliveryNew_F.SaveButtonClick(Sender: TObject);
var vIndex :Integer;
begin
  if (Trim(edt_TelNo1.Text) = ''  ) and
     (Trim(edt_TelNo2.Text) = ''  ) and
     (Trim(edt_TelNo3.Text) = ''  ) and
     (Trim(edt_TelNo4.Text) = ''  ) then
  begin
    Common.ErrBox('주문자 전화번호가 없습니다'+#13#13+'전화번호를 입력하세요');
    edt_TelNo1.SetFocus;
    Exit;
  end;

  try
    if DataSave(Sender) then
    begin
      if (Sender = SaveButton) or (Sender = nil) then
        //배달전표 출력
        case DeliveryStep of
          dsOrder :
          begin
            //주문시 배달전표를 출력한다고
            if (GetOption(143) <> '0') and ((Sender = SaveButton) or (FBefOrderAmt < FOrderAmt) or (FBefRowCount < FRowCount)) then
            begin
              if (Sender <> SaveButton) and (FBeforStep = dsOrder) and (GetOption(279) = '0') then
              begin
                //배달전표에 주문내역을 출력하지 않을 때는 스탭이 바뀌지 않았을때는 출력여부를 물어본다
                if Common.AskBox('배달전표를 출력하시겠습니까?') then
                begin
                  For vIndex := 1 to StoI(GetOption(143)) do
                    Common.Device.DeliveryPrint;
                end;
              end
              else if Sender <> SaveButton then
              begin
                For vIndex := 1 to StoI(GetOption(143)) do
                  Common.Device.DeliveryPrint;
              end
              else if (Sender = SaveButton) and (Common.AskBox('배달전표를 출력하시겠습니까?')) then
              begin
                For vIndex := 1 to StoI(GetOption(143)) do
                  Common.Device.DeliveryPrint;
              end;
            end;

            //주문시 배달고객영수증을 출력한다고
            if (GetOption(186) = '1') and ((Sender = SaveButton) or (FBefOrderAmt < FOrderAmt) or (FBefRowCount < FRowCount)) then
            begin
              if Sender <> SaveButton then
                Common.Device.DeliveryReceiptPrint
              else if (Sender = SaveButton) and (Common.AskBox('배달영수증을 출력하시겠습니까?')) then
                Common.Device.DeliveryReceiptPrint;
            end;

          end;
          dsDelivery :
          begin
            //주문상태에서 배달로 바뀌었고 배달시 배달전표를 출력한다고 체크했을때
            if (GetOption(189) <> '0') and ((Sender = SaveButton) or (FBeforStep = dsOrder))  then
            begin
              if (Sender <> SaveButton) and (FBeforStep = dsDelivery) and (GetOption(279) = '0') then
              begin
                //배달전표에 주문내역을 출력하지 않을 때는 스탭이 바뀌지 않았을때는 출력여부를 물어본다
                if Common.AskBox('배달전표를 출력하시겠습니까?') then
                begin
                  For vIndex := 1 to StoI(GetOption(189)) do
                    Common.Device.DeliveryPrint;
                end;
              end
              else if Sender <> SaveButton then
              begin
                For vIndex := 1 to StoI(GetOption(189)) do
                  Common.Device.DeliveryPrint;
              end
              else if (Sender = SaveButton) and (Common.AskBox('배달전표를 출력하시겠습니까?')) then
              begin
                For vIndex := 1 to StoI(GetOption(189)) do
                  Common.Device.DeliveryPrint;
              end;
            end;

            //배달시 배달고객영수증을 출력한다고
            if (GetOption(119) = '1') and ((Sender = SaveButton) or (FBeforStep = dsOrder)) then
            begin
              if Sender <> SaveButton then
                Common.Device.DeliveryReceiptPrint
              else if (Sender = SaveButton) and (Common.AskBox('배달영수증을 출력하시겠습니까?')) then
                Common.Device.DeliveryReceiptPrint;
            end;
          end;
          dsAccount :
          begin
            if (GetOption(145) <> '0') and ((Sender = SaveButton) or (FBeforStep <> dsAccount)) then
            begin
              if (Sender <> SaveButton) and (FBeforStep = dsAccount) and (GetOption(279) = '0') then
              begin
                //배달전표에 주문내역을 출력하지 않을 때는 스탭이 바뀌지 않았을때는 출력여부를 물어본다
                if Common.AskBox('배달전표를 출력하시겠습니까?') then
                begin
                  For vIndex := 1 to StoI(GetOption(145)) do
                    Common.Device.DeliveryPrint;
                end;
              end
              else if Sender <> SaveButton then
              begin
                For vIndex := 1 to StoI(GetOption(145)) do
                  Common.Device.DeliveryPrint;
              end
              else if (Sender = SaveButton) and (Common.AskBox('배달전표를 출력하시겠습니까?')) then
              begin
                For vIndex := 1 to StoI(GetOption(145)) do
                  Common.Device.DeliveryPrint;
              end;
            end;

            //계산시 배달고객영수증을 출력한다고
            if (GetOption(190) = '1') and ((Sender = SaveButton) or (FBeforStep <> dsAccount)) then
            begin
              if Sender <> SaveButton then
                Common.Device.DeliveryReceiptPrint
              else if (Sender = SaveButton) and (Common.AskBox('배달영수증을 출력하시겠습니까?')) then
                Common.Device.DeliveryReceiptPrint;
            end;
          end;
        end;
      GetDeliveryList;
    end;
  finally
    if isAbsent then
      SetAbsentCall(false);
  end;
end;

procedure TDeliveryNew_F.Search2ButtonClick(Sender: TObject);
var vIndex :Integer;
    vMobileTel,
    vHomeTel :String;
begin
  OpenQuery('select StoDW(a.YMD_DELIVERY) as YMD_DELIVERY, '
           +'       a.NO_DELIVERY as DELIVERYNO, '
           +'       case a.DS_ORDER when ''D'' then ''배달'' '
           +'                       when ''P'' THEN ''포장'' '
           +'       end as DS_ORDER, '
           +'       a.DT_ORDER, '
           +'       a.DT_DELIVERY, '
           +'       case a.DS_STEP when ''A'' then ''정산완료'' '
           +'                      when ''O'' then ''주문'' '
           +'                      when ''D'' then ''배달 중'' '
           +'                      when ''C'' then ''주문취소'' '
           +'                      when ''R'' then ''그릇회수'' '
           +'                      when ''N'' then ''미주문'' '
           +'                      when ''V'' then ''매출취소'' '
           +'       end as DS_STEP, '
           +'       case when a.DS_STEP in (''A'',''R'',''V'') then ifnull(d.AMT_SALE,0) else ifnull(a.AMT_ORDER,0) end as AMT_ORDER, '
           +'       a.NM_NAME, '
           +'       case when a.NO_TEL1 <> '''' then GetPhoneNo(a.NO_TEL1) '
           +'            else case when a.NO_TEL2 <> '''' then GetPhoneNo(a.NO_TEL2) '
           +'                      else case when a.NO_TEL3 <> '''' then GetPhoneNo(a.NO_TEL3) '
           +'                                else case when a.NO_TEL4 <> '''' then GetPhoneNo(a.NO_TEL4) '
           +'                                     end  '
           +'                           end '
           +'                  end '
           +'       end as NO_TEL1, '
           +'       ConCat(a.ADDRESS1,'' '',ADDRESS2) as ADDR, '
           +'       b.NM_SAWON, '
           +'       c.NM_SAWON as RECALL_SAWON, '
           +'       GetCommonName(a.CD_STORE, ''22'', a.CD_LOCAL) as LOCAL, '
           +'       GetCommonName(a.CD_STORE, ''20'', a.CD_COURSE) as COURSE, '
           +'       a.COUPON_CNT, '
           +'       case  a.PAYTYPE when ''CARD'' then ''신용카드'' when ''CASH'' then ''현금'' when ''ETC'' then ''복합'' else a.PAYTYPE end as PAYTYPE '
           +'  from SL_DELIVERY a left outer join '
           +'       MS_SAWON    b on a.CD_STORE = b.CD_STORE and a.CD_SAWON     = b.CD_SAWON left outer join '
           +'       MS_SAWON    c on a.CD_STORE = c.CD_STORE and a.RECALL_SAWON = c.CD_SAWON left outer join '
           +'       SL_SALE_H   d on a.CD_STORE = d.CD_STORE and Length(d.NO_DELIVERY) = 12 and ConCat(a.YMD_DELIVERY,a.NO_DELIVERY) = d.NO_DELIVERY '
           +' where a.CD_STORE      =:P0 '
           +'   and a.YMD_DELIVERY  =:P1 ',
           [Common.Config.StoreCode,
            DtoS(SearchDatePicker.Date)]);

  bvGridView.DataController.BeginUpdate;
  bvGridView.DataController.RecordCount := 0;
  while not Common.Query.Eof do
  begin
    bvGridView.DataController.AppendRecord;
    bvGridView.DataController.Values[bvGridView.DataController.RecordCount-1, bvGridViewDate.Index]          := Common.Query.FieldByName('YMD_DELIVERY').AsString;
    bvGridView.DataController.Values[bvGridView.DataController.RecordCount-1, bvGridViewNo.Index]            := Common.Query.FieldByName('DELIVERYNO').AsString;
    bvGridView.DataController.Values[bvGridView.DataController.RecordCount-1, bvGridViewType.Index]          := Common.Query.FieldByName('DS_ORDER').AsString;
    bvGridView.DataController.Values[bvGridView.DataController.RecordCount-1, bvGridViewStatus.Index]        := Common.Query.FieldByName('DS_STEP').AsString;
    bvGridView.DataController.Values[bvGridView.DataController.RecordCount-1, bvGridViewOrderAmt.Index]      := Common.Query.FieldByName('AMT_ORDER').AsCurrency;
    bvGridView.DataController.Values[bvGridView.DataController.RecordCount-1, bvGridViewCustName.Index]      := Common.Query.FieldByName('NM_NAME').AsString;
    bvGridView.DataController.Values[bvGridView.DataController.RecordCount-1, bvGridViewOrderTime.Index]     := FormatDateTime(fmtDateTime, Common.Query.FieldByName('DT_ORDER').AsDateTime);
    if Common.Query.FieldByName('DT_DELIVERY').AsDateTime > 0 then
      bvGridView.DataController.Values[bvGridView.DataController.RecordCount-1, bvGridViewDeliveryTime.Index]  := FormatDateTime(fmtDateTime, Common.Query.FieldByName('DT_DELIVERY').AsDateTime);
    bvGridView.DataController.Values[bvGridView.DataController.RecordCount-1, bvGridViewTelNo.Index]         := Common.Query.FieldByName('NO_TEL1').AsString;
    bvGridView.DataController.Values[bvGridView.DataController.RecordCount-1, bvGridViewAddress.Index]       := Common.Query.FieldByName('ADDR').AsString;
    bvGridView.DataController.Values[bvGridView.DataController.RecordCount-1, bvGridViewDeliverySawon.Index] := Common.Query.FieldByName('NM_SAWON').AsString;
    bvGridView.DataController.Values[bvGridView.DataController.RecordCount-1, bvGridViewReturnSawon.Index]   := Common.Query.FieldByName('RECALL_SAWON').AsString;
    bvGridView.DataController.Values[bvGridView.DataController.RecordCount-1, bvGridViewLocal.Index]         := Common.Query.FieldByName('LOCAL').AsString;
    bvGridView.DataController.Values[bvGridView.DataController.RecordCount-1, bvGridViewCourse.Index]        := Common.Query.FieldByName('COURSE').AsString;
    bvGridView.DataController.Values[bvGridView.DataController.RecordCount-1, bvGridViewAcctType.Index]      := Common.Query.FieldByName('PAYTYPE').AsString;
    bvGridView.DataController.Values[bvGridView.DataController.RecordCount-1, bvGridViewCoupon.Index]        := Common.Query.FieldByName('COUPON_CNT').AsCurrency;
    Common.Query.Next;
  end;
  bvGridView.DataController.Summary.FooterSummaryValues[0] := 0;
  For vIndex := 0 to bvGridView.DataController.RecordCount-1 do
  begin
    if (bvGridView.DataController.Values[vIndex, bvGridViewStatus.Index] <> '매출취소') and (bvGridView.DataController.Values[vIndex, bvGridViewStatus.Index] <> '주문취소') and (bvGridView.DataController.Values[vIndex, bvGridViewStatus.Index] <> '미주문') then
      bvGridView.DataController.Summary.FooterSummaryValues[0] := bvGridView.DataController.Summary.FooterSummaryValues[0] + bvGridView.DataController.Values[vIndex, bvGridViewOrderAmt.Index];
  end;
  bvGridView.DataController.EndUpdate;

  Common.Query.Close;
  OpenQuery('select GetPhoneNo(a.NO_TEL) as NO_TEL, '
           +'       a.DT_CALL, '
           +'       case when c.DS_ORDER is null then ''미주문'' else ''주문'' end DS_ORDER, '
           +'       ifnull(b.NM_MEMBER, ''신규고객'') as NM_CUST, '
           +'	      a.NO_LINE, '
           +'       ConCat(b.ADDR1,'' '',b.ADDR2) as ADDRESS '
           +'  from SL_CID_LOG a left outer join '
           +'       MS_MEMBER  b on b.CD_STORE  = a.CD_STORE '
           +'                   and b.TEL_MOBILE = a.NO_TEL left outer join '
           +'       SL_DELIVERY c on c.CD_STORE = a.CD_STORE '
           +'                    and Date_Format(c.DT_ORDER, ''%Y%m%d'') = a.YMD_CALL '
           +'                    and (c.NO_TEL1 = a.NO_TEL '
           +'                      or c.NO_TEL2 = a.NO_TEL '
           +'                      or c.NO_TEL3 = a.NO_TEL '
           +'                      or c.NO_TEL4 = a.NO_TEL) '
           +' where a.CD_STORE =:P0 '
           +'   and Date_Format(a.DT_CALL, ''%Y%m%d'')  = :P1 '
           +'order by a.DT_CALL ',
           [Common.Config.StoreCode,
            DtoS(SearchDatePicker.Date)]);

  tvGridView.DataController.BeginUpdate;
  tvGridView.DataController.RecordCount := 0;
  while not Common.Query.Eof do
  begin
    tvGridView.DataController.AppendRecord;
    tvGridView.DataController.Values[tvGridView.DataController.RecordCount-1, tvGridViewTelNo.Index]    := Common.Query.FieldByName('NO_TEL').AsString;
    tvGridView.DataController.Values[tvGridView.DataController.RecordCount-1, tvGridViewStatus.Index]   := Common.Query.FieldByName('DS_ORDER').AsString;
    tvGridView.DataController.Values[tvGridView.DataController.RecordCount-1, tvGridViewCustName.Index] := Common.Query.FieldByName('NM_CUST').AsString;
    tvGridView.DataController.Values[tvGridView.DataController.RecordCount-1, tvGridViewCallDate.Index] := Common.Query.FieldByName('DT_CALL').AsString;
    tvGridView.DataController.Values[tvGridView.DataController.RecordCount-1, tvGridViewAddress.Index]  := Common.Query.FieldByName('ADDRESS').AsString;
    Common.Query.Next;
  end;
  tvGridView.DataController.EndUpdate;
  Common.Query.Close;
end;

procedure TDeliveryNew_F.SearchButtonClick(Sender: TObject);
var vIsSearch :Boolean;
    vWhere1,
    vWhere2 :String;
begin
  vIsSearch := false;
  if (edt_TelNo1.Text ='') and (edt_TelNo2.Text ='') and (edt_TelNo3.Text ='') and (edt_TelNo4.Text ='') then
  begin
    Common.ErrBox('전화번호를 입력하세요');
    edt_TelNo1.SetFocus;
    Exit;
  end;

  if Length(GetOnlyNumber(edt_TelNo1.Text)) >= 10 then
    vWhere1 := Format(' and (a.TEL_MOBILE = ''%s'' or a.TEL_HOME = ''%s'') ',[GetOnlyNumber(edt_TelNo1.Text), GetOnlyNumber(edt_TelNo1.Text)])
  else
    vWhere1 := '';



  if vWhere1 = '' then Exit;

    //회원여부 체크
  OpenQuery('select 1 as SEQ, '
           +'		    a.CD_MEMBER, '
           +'		    a.NM_MEMBER	as NM_NAME, '
           +'		    a.TEL_MOBILE as NO_TEL1, '
           +'			  a.TEL_HOME	as NO_TEL2, '
           +'			  a.TEL_ETC1	as NO_TEL3, '
           +'			  a.TEL_ETC2	as NO_TEL4, '
           +'			  a.ADDR1		as ADDRESS1, '
           +'			  a.ADDR2		as ADDRESS2, '
           +'			  a.REMARK, '
           +'			  a.CD_LOCAL, '
           +'			  b.NM_CODE1 as NM_LOCAL, '
           +'			  a.CD_COURSE, '
           +'			  c.NM_CODE1 as NM_COURSE '
           +'	from  MS_MEMBER a left outer join '
           +'       MS_CODE   b on b.CD_STORE = a.CD_STORE and b.CD_KIND = ''22'' and b.CD_CODE = a.CD_LOCAL left outer join '
           +'       MS_CODE   c on c.CD_STORE = a.CD_STORE and c.CD_KIND = ''20'' and c.CD_CODE = a.CD_COURSE '
           +' where a.CD_STORE 	=:P0 '
           +vWhere1
           +Ifthen(GetOnlyNumber(edt_TelNo1.Text)<>'',
           '	union all  '
           +'select 2 as SEQ, '
           +'		    a.CD_MEMBER, '
           +'		    a.NM_NAME, '
           +'		    a.NO_TEL1, '
           +'		    a.NO_TEL2, '
           +'		    a.NO_TEL3, '
           +'		    a.NO_TEL4, '
           +'		    a.ADDRESS1, '
           +'		    a.ADDRESS2, '
           +'		    '''' as REMARK, '
           +'		    a.CD_LOCAL, '
           +'			  b.NM_CODE1 as NM_LOCAL, '
           +'		    a.CD_COURSE, '
           +'			  c.NM_CODE1 as NM_COURSE '
           +'  from SL_DELIVERY a left outer join '
           +'       MS_CODE     b on b.CD_STORE = a.CD_STORE and b.CD_KIND = ''22'' and b.CD_CODE = a.CD_LOCAL left outer join '
           +'       MS_CODE     c on c.CD_STORE = a.CD_STORE and c.CD_KIND = ''20'' and c.CD_CODE = a.CD_COURSE '
           +' where a.CD_STORE 	= :P0 '
           +'   and ConCat(a.YMD_DELIVERY,a.NO_DELIVERY) = (select Max(ConCat(YMD_DELIVERY,NO_DELIVERY)) '
           +'                                                 from SL_DELIVERY '
           +'                                                where CD_STORE = :P0 '
           +'                                                  and NO_TEL1    = '''+GetOnlyNumber(edt_TelNo1.Text)+''')',
            '')
           +' order by 1 ',
           [Common.Config.StoreCode]);

  MemberCode := EmptyStr;
  lbl_Member.Caption := EmptyStr;
  while not Common.Query.Eof do
  begin
    case Common.Query.FieldByName('seq').AsInteger of
      1 :
      begin
        MemberCode              := Common.Query.FieldByName('cd_member').AsString;
        lbl_Member.Caption      := IfThen(MemberCode = '', '비회원', '회원 (' + MemberCode + ')');
        edt_CustName.Text       := Common.Query.FieldByName('nm_name').AsString;
        edt_TelNo1.Text         := SetTelephone(Common.Query.FieldByName('no_tel1').AsString);
        edt_TelNo2.Text         := SetTelephone(Common.Query.FieldByName('no_tel2').AsString);
        edt_TelNo3.Text         := SetTelephone(Common.Query.FieldByName('no_tel3').AsString);
        edt_TelNo4.Text         := SetTelephone(Common.Query.FieldByName('no_tel4').AsString);
        edt_Address1.Text       := Common.Query.FieldByName('address1').AsString;
        edt_Address2.Text       := Common.Query.FieldByName('address2').AsString;
        meo_Remark.Text         := Common.Query.FieldByName('remark').AsString;
        CourseButton.Caption    := Common.Query.FieldByName('nm_course').AsString;
        CourseButton.Hint       := Common.Query.FieldByName('cd_course').AsString;
        LocalButton.Caption     := Common.Query.FieldByName('nm_Local').AsString;
        LocalButton.Hint        := Common.Query.FieldByName('cd_Local').AsString;
        vIsSearch := true;
      end;
      2 :
      begin
        if MemberCode = EmptyStr then
        begin
          lbl_Member.Caption    := IfThen(MemberCode = '', '비회원', '회원 (' + MemberCode + ')');
          edt_CustName.Text     := Common.Query.FieldByName('nm_name').AsString;
          edt_TelNo1.Text       := SetTelephone(Common.Query.FieldByName('no_tel1').AsString);
          edt_TelNo2.Text       := SetTelephone(Common.Query.FieldByName('no_tel2').AsString);
          edt_TelNo3.Text       := SetTelephone(Common.Query.FieldByName('no_tel3').AsString);
          edt_TelNo4.Text       := SetTelephone(Common.Query.FieldByName('no_tel4').AsString);
          edt_Address1.Text     := Common.Query.FieldByName('address1').AsString;
          edt_Address2.Text     := Common.Query.FieldByName('address2').AsString;
          meo_Remark.Text       := Common.Query.FieldByName('remark').AsString;
          CourseButton.Caption  := Common.Query.FieldByName('nm_course').AsString;
          CourseButton.Hint     := Common.Query.FieldByName('cd_course').AsString;
          LocalButton.Caption   := Common.Query.FieldByName('nm_Local').AsString;
          LocalButton.Hint      := Common.Query.FieldByName('cd_Local').AsString;
          vIsSearch := true;
        end;
      end;
    end;
    Common.Query.Next;
  end;
  Common.Query.Close;

  if not vIsSearch then
  begin
    if (Sender = SearchButton) then
    begin
      Common.ErrBox('조건에 맞는 자료가 없습니다');
      Exit;
    end;
    Exit;
  end;
  SetDeliveryHistory(0);
end;

procedure TDeliveryNew_F.SetAbsentCall(aAll: Boolean);
var vIndex :Integer;
    vWhere :String;
begin
  with GridTableView.DataController do
  begin
    For vIndex := Ifthen(aAll, 0, Common.CidData.Count-1) to Common.CidData.Count-1 do
    begin
      if Trim(Copy(Common.CidData.Strings[vIndex],1,12)) <> '' then
        vWhere := Format('''%s'' ',[Trim(Copy(Common.CidData.Strings[vIndex],1,12))]);

      OpenQuery('select 1 as SEQ, '
               +'		    NM_MEMBER	AS NM_NAME, '
               +'			  ADDR1		as ADDRESS1, '
               +'			  ADDR2		as ADDRESS2 '
               +'	 from MS_MEMBER '
               +' where CD_STORE 	=:P0 '
               +'   and ( TEL_MOBILE = '+vWhere
               +'		   or TEL_HOME  = '+vWhere
               +'		   or TEL_ETC1  = '+vWhere
               +'		   or TEL_ETC2  = '+vWhere+' ) '
               +'   and DS_STATUS = ''0'' '
               +'union all  '
               +'select 2 as SEQ, '
               +'		    NM_NAME, '
               +'		    ADDRESS1, '
               +'		    ADDRESS2 '
               +'  from SL_DELIVERY '
               +' where CD_STORE 	= :P0 '
               +'	  and NO_TEL1    =:P1 '
               +' limit 1 ',
               [Common.Config.StoreCode,
                Trim(Copy(Common.CidData.Strings[vIndex],1,12))]);

      GridTableView.DataController.AppendRecord;
      Values[GridTableView.DataController.RecordCount-1, GridTableViewStatus.Index]     := '부재중';
      Values[GridTableView.DataController.RecordCount-1, GridTableViewTelMobile.Index]  := SetTelephone(Trim(Copy(Common.CidData.Strings[vIndex],1,12)));
      Values[GridTableView.DataController.RecordCount-1, GridTableViewCustName.Index]   := '신규고객';
      Values[GridTableView.DataController.RecordCount-1, GridTableViewOrderTime.Index]  := Copy(Common.CidData.Strings[vIndex],24,5);

      if not Common.Query.Eof then
      begin
        Values[GridTableView.DataController.RecordCount-1, GridTableViewCustName.Index]   := Common.Query.FieldByName('NM_NAME').AsString;
        Values[GridTableView.DataController.RecordCount-1, GridTableViewAddress.Index]    := Format('%s %s',[Common.Query.FieldByName('ADDRESS1').AsString, Common.Query.FieldByName('ADDRESS2').AsString]);
      end;
      Common.Query.Close;
    end;
  end;
  isAbsent := false;
end;

procedure TDeliveryNew_F.HistoryTableViewCellDblClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  CallStep := csSaleMenu;

  OpenQuery('select m.NM_MENU, '
           +'       GetQty(s.DS_MENU_TYPE, s.QTY_SALE) as QTY_SALE, '
           +'       s.PR_SALE, '
           +'       s.AMT_SALE, '
           +'       s.SEQ, '
           +'       s.DS_SALE_TYPE, '
           +'       s.SEQ1 '
           +'  from ( '
           +'         select a.CD_STORE, '
           +'                b.CD_MENU, '
           +'                b.QTY_SALE, '
           +'                b.PR_SALE, '
           +'                b.AMT_SALE, '
           +'                b.DS_SALE_TYPE, '
           +'                b.SEQ, '
           +'                1 as SEQ1 '
           +'          from SL_SALE_H a inner join '
           +'               SL_SALE_D b on b.CD_STORE = a.CD_STORE '
           +'                          and b.YMD_SALE = a.YMD_SALE '
           +'                          and b.NO_POS   = a.NO_POS '
           +'                          and b.NO_RCP   = a.NO_RCP '
           +'         where a.CD_STORE    =:P0 '
           +'           and a.NO_DELIVERY =:P1 '
           +'         union all '
           +'         select a.CD_STORE, '
           +'                b.CD_MENU, '
           +'                b.QTY_SALE, '
           +'                0, '
           +'                0, '
           +'                '''', '
           +'                b.SEQ, '
           +'                2 as SEQ1 '
           +'          from SL_SALE_H a left outer join '
           +'               SL_SALE_S b on b.CD_STORE = a.CD_STORE '
           +'                          and b.YMD_SALE = a.YMD_SALE '
           +'                          and b.NO_POS   = a.NO_POS '
           +'                          and b.NO_RCP   = a.NO_RCP '
           +'         where a.CD_STORE    =:P0 '
           +'           and a.NO_DELIVERY =:P1 '
           +'       ) as s left outer join '
           +'       MS_MENU m on m.CD_STORE =s.CD_STORE and m.CD_MENU = s.CD_MENU '
           +' order by s.SEQ, s.SEQ1 ',
           [Common.Config.StoreCode,
            HistoryTableView.DataController.Values[HistoryTableView.DataController.GetFocusedRecordIndex, HistoryTableViewDeliveryNo.Index]]);
  SaleTableView.DataController.BeginUpdate;
  SaleTableView.DataController.RecordCount := 0;
  while not Common.Query.Eof do
  begin
    if Common.Query.FieldByName('SEQ1').AsString = '1' then
    begin
      SaleTableView.DataController.AppendRecord;
      SaleTableView.DataController.Values[SaleTableView.DataController.RecordCount-1, SaleTableViewSeq.Index]   := Common.Query.FieldByName('SEQ').AsString;
      SaleTableView.DataController.Values[SaleTableView.DataController.RecordCount-1, SaleTableViewMenu.Index]  := Common.Query.FieldByName('NM_MENU').AsString + Ifthen(Common.Query.FieldByName('DS_SALE_TYPE').AsString='D',Common.Config.ServiceTxt,'');
      SaleTableView.DataController.Values[SaleTableView.DataController.RecordCount-1, SaleTableViewQty.Index]   := Common.Query.FieldByName('QTY_SALE').AsString;
      SaleTableView.DataController.Values[SaleTableView.DataController.RecordCount-1, SaleTableViewPrice.Index] := Common.Query.FieldByName('PR_SALE').AsCurrency;
      SaleTableView.DataController.Values[SaleTableView.DataController.RecordCount-1, SaleTableViewAmt.Index]   := Common.Query.FieldByName('AMT_SALE').AsCurrency;
    end
    else if Common.Query.FieldByName('NM_MENU').AsString <> '' then
    begin
      SaleTableView.DataController.AppendRecord;
      SaleTableView.DataController.Values[SaleTableView.DataController.RecordCount-1, SaleTableViewSeq.Index]   := '-';
      SaleTableView.DataController.Values[SaleTableView.DataController.RecordCount-1, SaleTableViewMenu.Index]  := Common.Query.FieldByName('NM_MENU').AsString;
      SaleTableView.DataController.Values[SaleTableView.DataController.RecordCount-1, SaleTableViewQty.Index]   := Common.Query.FieldByName('QTY_SALE').AsString;
    end;
    Common.Query.Next;
  end;
  SaleTableView.DataController.EndUpdate;
  SaleRemarkMemo.Lines.Text := HistoryTableView.DataController.Values[HistoryTableView.DataController.GetFocusedRecordIndex, HistoryTableViewRemark.Index];
end;

procedure TDeliveryNew_F.lblCallStatusClick(Sender: TObject);
begin
  CidReadEvent('C'+GetOnlyNumber(lblCallLine.Caption)+'S'+GetOnlyNumber(lblCallNo.Caption));
end;

procedure TDeliveryNew_F.tvGridViewKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key <> #13 then Exit;
  if tvGridView.DataController.GetFocusedRecordIndex < 0 then Exit;
  if Common.AskBox(Format('%s 번호로'#13#13'신규주문 하시겠습니까?',[tvGridView.DataController.Values[tvGridView.DataController.GetFocusedRecordIndex, tvGridViewTelNo.Index]])) then
  begin
    Close2Button.Click;
    edt_TelNo1.Text := tvGridView.DataController.Values[tvGridView.DataController.GetFocusedRecordIndex, tvGridViewTelNo.Index];
    NewButtonClick(nil);
  end;  
end;

procedure TDeliveryNew_F.AcctSearchButtonClick(Sender: TObject);
begin
  GridTableViewStatus.DataBinding.Filter.Clear;
  GridTableViewStatus.DataBinding.AddToFilter(nil, foEqual, '계산');
  GridTableView.DataController.Filter.Active := true;
  GridTableView.Controller.FocusedRecordIndex := GridTableView.DataController.RecordCount-1;
  isData    := GridTableView.Controller.FocusedRecordIndex >=0 ;
  panDeliveryInfo.Enabled := isData;
  isNotTel  := false;
  isChanged := false;
  SearchPanel.Visible := false;
  StatusSearchButton.Caption := '계산상태';
end;

procedure TDeliveryNew_F.AdvSmoothToggleButton1Click(Sender: TObject);
var vIndex :Integer;
    vList  :TStringList;
begin
  vList := TStringList.Create;
    vList.Add(Format('%s.Top    := %d;', [panDeliveryInfo.Name,panDeliveryInfo.Top]));
    vList.Add(Format('%s.Left   := %d;', [panDeliveryInfo.Name,panDeliveryInfo.Left]));
    vList.Add(Format('%s.Width  := %d;', [panDeliveryInfo.Name,panDeliveryInfo.Width]));
    vList.Add(Format('%s.Height := %d;', [panDeliveryInfo.Name,panDeliveryInfo.Height]));
    for vIndex := 0 to ComponentCount-1 do
    begin
      if (Components[vIndex] is TAdvSmoothToggleButton) and ((Components[vIndex] as TAdvSmoothToggleButton).Parent = panDeliveryInfo) then
      begin
        vList.Add(Format('%s.Top    := %d;', [Components[vIndex].Name,(Components[vIndex] as TAdvSmoothToggleButton).Top]));
        vList.Add(Format('%s.Left   := %d;', [Components[vIndex].Name,(Components[vIndex]  as TAdvSmoothToggleButton).Left]));
        vList.Add(Format('%s.Width  := %d;', [Components[vIndex].Name,(Components[vIndex]  as TAdvSmoothToggleButton).Width]));
        vList.Add(Format('%s.Height := %d;', [Components[vIndex].Name,(Components[vIndex] as TAdvSmoothToggleButton).Height]));
        vList.Add(Format('%s.Appearance.Font.Size := %d;', [Components[vIndex].Name,(Components[vIndex] as TAdvSmoothToggleButton).Appearance.Font.Size]));
      end;
      if (Components[vIndex] is TcxLabel) and ((Components[vIndex] as TcxLabel).Parent = panDeliveryInfo) then
      begin
        vList.Add(Format('%s.Top    := %d;', [Components[vIndex].Name,(Components[vIndex] as TcxLabel).Top]));
        vList.Add(Format('%s.Left   := %d;', [Components[vIndex].Name,(Components[vIndex]  as TcxLabel).Left]));
        vList.Add(Format('%s.Width  := %d;', [Components[vIndex].Name,(Components[vIndex]  as TcxLabel).Width]));
        vList.Add(Format('%s.Height := %d;', [Components[vIndex].Name,(Components[vIndex] as TcxLabel).Height]));
        vList.Add(Format('%s.Style.Font.Size := %d;', [Components[vIndex].Name,(Components[vIndex] as TcxLabel).Style.Font.Size]));
      end;

      if (Components[vIndex] is TcxTextEdit) and ((Components[vIndex] as TcxTextEdit).Parent = panDeliveryInfo) then
      begin
        vList.Add(Format('%s.Top    := %d;', [Components[vIndex].Name,(Components[vIndex] as TcxTextEdit).Top]));
        vList.Add(Format('%s.Left   := %d;', [Components[vIndex].Name,(Components[vIndex]  as TcxTextEdit).Left]));
        vList.Add(Format('%s.Width  := %d;', [Components[vIndex].Name,(Components[vIndex]  as TcxTextEdit).Width]));
        vList.Add(Format('%s.Height := %d;', [Components[vIndex].Name,(Components[vIndex] as TcxTextEdit).Height]));
        vList.Add(Format('%s.Style.Font.Size := %d;', [Components[vIndex].Name,(Components[vIndex] as TcxTextEdit).Style.Font.Size]));
      end;
      if (Components[vIndex] is TcxMemo) and ((Components[vIndex] as TcxMemo).Parent = panDeliveryInfo) then
      begin
        vList.Add(Format('%s.Top    := %d;', [Components[vIndex].Name,(Components[vIndex] as TcxMemo).Top]));
        vList.Add(Format('%s.Left   := %d;', [Components[vIndex].Name,(Components[vIndex]  as TcxMemo).Left]));
        vList.Add(Format('%s.Width  := %d;', [Components[vIndex].Name,(Components[vIndex]  as TcxMemo).Width]));
        vList.Add(Format('%s.Height := %d;', [Components[vIndex].Name,(Components[vIndex] as TcxMemo).Height]));
        vList.Add(Format('%s.Style.Font.Size := %d;', [Components[vIndex].Name,(Components[vIndex] as TcxMemo).Style.Font.Size]));
      end;
    end;
    vList.Add(Format('%s.Top    := %d;', [OrderGrid.Name,OrderGrid.Top]));
    vList.Add(Format('%s.Left   := %d;', [OrderGrid.Name,OrderGrid.Left]));
    vList.Add(Format('%s.Width  := %d;', [OrderGrid.Name,OrderGrid.Width]));
    vList.Add(Format('%s.Height := %d;', [OrderGrid.Name,OrderGrid.Height]));
    if Self.Width = 1024 then
      vList.SaveToFile('1024.txt')
    else if Self.Width = 1280 then
      vList.SaveToFile('1280.txt')
    else if Self.Width = 1920 then
      vList.SaveToFile('1920.txt');
end;

procedure TDeliveryNew_F.AllSearchButtonClick(Sender: TObject);
begin
  GridTableViewStatus.DataBinding.Filter.Clear;
  if AcctSearchButton.Visible then
  begin
    GridTableViewStatus.DataBinding.AddToFilter(nil, foNotEqual, '계산');
    GridTableView.DataController.Filter.Active := true;
  end
  else
    GridTableView.DataController.Filter.Active := false;
  GridTableView.Controller.FocusedRecordIndex := GridTableView.DataController.RecordCount-1;
  isData    := GridTableView.Controller.FocusedRecordIndex >=0 ;
  isNotTel  := false;
  isChanged := false;
  SearchPanel.Visible := false;
  StatusSearchButton.Caption := '전체';
end;

procedure TDeliveryNew_F.BaeminDeliveryPrint(aDeliveryNo: String);
var vIndex, vRow :Integer;
begin
  GetDeliveryList;
  vRow := -1;
  for vIndex := 0 to GridTableView.DataController.RecordCount-1 do
  begin
    if GridTableView.DataController.Values[vIndex, GridTableViewBaeminOrderNo.Index] = aDeliveryNo then
    begin
      vRow := vIndex;
      Break;
    end;
  end;
  if vRow >= 0 then
  begin
    GridTableView.Controller.FocusRecord(vIndex, true);
    Common.Device.DeliveryPrint;
  end;
end;

function TDeliveryNew_F.GetDeliveryOrderDataIndex(aTelNo:String):Integer;
var vIndex :Integer;
begin
  Result := -1;
  For vIndex :=0 to GridTableView.DataController.FilteredRecordCount-1 do
  begin
    if ((GetOnlyNumber(NVL(GridTableView.DataController.Values[GridTableView.DataController.FilteredRecordIndex[vIndex], GridTableViewTelMobile.Index],'')) = aTelNo) or
       (GetOnlyNumber(NVL(GridTableView.DataController.Values[GridTableView.DataController.FilteredRecordIndex[vIndex], GridTableViewTelHome.Index],'')) = aTelNo) or
       (GetOnlyNumber(NVL(GridTableView.DataController.Values[GridTableView.DataController.FilteredRecordIndex[vIndex], GridTableViewTelEtc.Index],'')) = aTelNo) or
       (GetOnlyNumber(NVL(GridTableView.DataController.Values[GridTableView.DataController.FilteredRecordIndex[vIndex], GridTableViewTelEtc2.Index],'')) = aTelNo)) and
       (NVL(GridTableView.DataController.Values[GridTableView.DataController.FilteredRecordIndex[vIndex], GridTableViewStatus.Index],'') <> '계산') then
    begin
      Result := GridTableView.DataController.FilteredRecordIndex[vIndex];
      Break;
    end;
  end;
end;
end.



