unit DeliveryTable_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxCurrencyEdit,
  cxContainer, cxClasses, AdvGlassButton, Vcl.StdCtrls, cxLabel,
  cxGridTableView, cxGridLevel, cxGridCustomTableView, cxGridCardView,
  cxGridCustomView, cxGridCustomLayoutView, cxGrid, cxButtons, dxGDIPlusClasses,
  Vcl.ExtCtrls, Data.DB, StrUtils, Math, ToolPanels, AdvOfficePager, PosButton,
  System.ImageList, Vcl.ImgList, AdvBadge, AdvOfficePagerStylers, cxTextEdit,
  cxMemo, cxRichEdit, Vcl.ComCtrls, TreeList, cxVGrid, cxInplaceContainer,
  AdvScrollControl, cxImage, Winapi.MMSystem, AdvSmoothButton, DateUtils;

//부메뉴
type
  TSubMenu = record
    Menu      :TcxLabel;
    Qty       :TcxLabel;
  end;

//주문리스트
type
  TOrderList = record
    GroupBox       :TPanel;
    ReceiptNo      :String;
    OrderNo        :String;
    Status         :String;    //0:주문, 1:조리중, 2: 호출, 3:픽업대기
    DsOrder        :String;
    TableNo        :Integer;
    MobielNo       :String;
    TitleShape     :TShape;
    OrderType      :TcxLabel;   //포장 or 테이블번호
    OrderTime      :TcxLabel;   //주문시간
    PickupTime     :String;
    HotImage,
    TableImage,
    TimeImage      :TImage;
    ElapsedTime    :TcxLabel;   //경과시간(분)
    MenuGrid       :TcxGrid;
    DsCall         :String;     //M:모바일(카카오), N:주문번호(앱)
    CancelButton   :TPosButton; //TAdvSmoothButton;
    OkButton       :TPosButton;
  end;

type
  TDeliveryTable_F = class(TForm)
    CloseButton: TcxButton;
    TitleLabel: TLabel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    WebOrderPager: TAdvOfficePager;
    OrderPage: TAdvOfficePage;
    PickupPage: TAdvOfficePage;
    Panel1: TPanel;
    Shape1: TShape;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    cxLabel8: TcxLabel;
    OfficeStyler: TAdvOfficePagerOfficeStyler;
    StyleRepository: TcxStyleRepository;
    StyleFontDetail: TcxStyle;
    StyleHeader: TcxStyle;
    AdvOfficePage1: TAdvOfficePage;
    Panel3: TPanel;
    Shape3: TShape;
    PosButton5: TPosButton;
    PosButton6: TPosButton;
    cxLabel7: TcxLabel;
    cxLabel18: TcxLabel;
    cxLabel19: TcxLabel;
    cxLabel20: TcxLabel;
    cxLabel21: TcxLabel;
    cxLabel22: TcxLabel;
    cxLabel23: TcxLabel;
    cxLabel24: TcxLabel;
    Panel4: TPanel;
    Shape4: TShape;
    cxLabel25: TcxLabel;
    cxLabel28: TcxLabel;
    cxLabel29: TcxLabel;
    cxLabel30: TcxLabel;
    cxLabel31: TcxLabel;
    cxLabel32: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel11: TcxLabel;
    cxLabel9: TcxLabel;
    TableOrderButton: TAdvSmoothButton;
    ImageCollection: TcxImageCollection;
    ImageCollectionItem1: TcxImageCollectionItem;
    ImageCollectionItem2: TcxImageCollectionItem;
    AllFinishButton: TAdvSmoothButton;
    ImageCollectionItem3: TcxImageCollectionItem;
    NewOrderButton: TAdvSmoothButton;
    AdvSmoothButton1: TAdvSmoothButton;
    AdvSmoothButton4: TAdvSmoothButton;
    cxLabel10: TcxLabel;
    cxLabel12: TcxLabel;
    AdvSmoothButton6: TAdvSmoothButton;
    AdvSmoothButton7: TAdvSmoothButton;
    cxLabel13: TcxLabel;
    cxLabel14: TcxLabel;
    PageLabel: TcxLabel;
    PriorButton: TAdvSmoothButton;
    NextButton: TAdvSmoothButton;
    cxLabel37: TcxLabel;
    Panel5: TPanel;
    Shape5: TShape;
    cxLabel39: TcxLabel;
    cxLabel40: TcxLabel;
    cxLabel41: TcxLabel;
    cxLabel42: TcxLabel;
    cxLabel43: TcxLabel;
    cxLabel44: TcxLabel;
    cxLabel45: TcxLabel;
    cxLabel46: TcxLabel;
    cxLabel47: TcxLabel;
    AdvSmoothButton12: TAdvSmoothButton;
    AdvSmoothButton13: TAdvSmoothButton;
    cxLabel48: TcxLabel;
    Panel6: TPanel;
    Shape6: TShape;
    cxLabel49: TcxLabel;
    cxLabel50: TcxLabel;
    cxLabel51: TcxLabel;
    cxLabel52: TcxLabel;
    cxLabel53: TcxLabel;
    cxLabel54: TcxLabel;
    cxLabel55: TcxLabel;
    cxLabel56: TcxLabel;
    cxLabel57: TcxLabel;
    AdvSmoothButton14: TAdvSmoothButton;
    AdvSmoothButton15: TAdvSmoothButton;
    cxLabel58: TcxLabel;
    Panel7: TPanel;
    Shape7: TShape;
    cxLabel59: TcxLabel;
    cxLabel60: TcxLabel;
    cxLabel61: TcxLabel;
    cxLabel62: TcxLabel;
    cxLabel63: TcxLabel;
    cxLabel64: TcxLabel;
    cxLabel65: TcxLabel;
    cxLabel66: TcxLabel;
    cxLabel67: TcxLabel;
    AdvSmoothButton16: TAdvSmoothButton;
    AdvSmoothButton17: TAdvSmoothButton;
    cxLabel68: TcxLabel;
    Panel2: TPanel;
    Shape2: TShape;
    cxLabel15: TcxLabel;
    cxLabel16: TcxLabel;
    cxLabel17: TcxLabel;
    cxLabel26: TcxLabel;
    cxLabel27: TcxLabel;
    cxLabel33: TcxLabel;
    cxLabel34: TcxLabel;
    cxLabel35: TcxLabel;
    cxLabel36: TcxLabel;
    AdvSmoothButton10: TAdvSmoothButton;
    AdvSmoothButton11: TAdvSmoothButton;
    cxLabel38: TcxLabel;
    Panel8: TPanel;
    Shape8: TShape;
    cxLabel69: TcxLabel;
    cxLabel70: TcxLabel;
    cxLabel71: TcxLabel;
    cxLabel72: TcxLabel;
    cxLabel73: TcxLabel;
    cxLabel74: TcxLabel;
    cxLabel75: TcxLabel;
    cxLabel76: TcxLabel;
    cxLabel77: TcxLabel;
    AdvSmoothButton18: TAdvSmoothButton;
    AdvSmoothButton19: TAdvSmoothButton;
    cxLabel78: TcxLabel;
    Panel9: TPanel;
    Shape9: TShape;
    cxLabel79: TcxLabel;
    cxLabel80: TcxLabel;
    cxLabel81: TcxLabel;
    cxLabel82: TcxLabel;
    cxLabel83: TcxLabel;
    cxLabel84: TcxLabel;
    cxLabel85: TcxLabel;
    cxLabel86: TcxLabel;
    cxLabel87: TcxLabel;
    AdvSmoothButton20: TAdvSmoothButton;
    AdvSmoothButton21: TAdvSmoothButton;
    cxLabel88: TcxLabel;
    Panel10: TPanel;
    Shape10: TShape;
    cxLabel89: TcxLabel;
    cxLabel90: TcxLabel;
    cxLabel91: TcxLabel;
    cxLabel92: TcxLabel;
    cxLabel93: TcxLabel;
    cxLabel94: TcxLabel;
    cxLabel95: TcxLabel;
    cxLabel96: TcxLabel;
    cxLabel97: TcxLabel;
    AdvSmoothButton22: TAdvSmoothButton;
    AdvSmoothButton23: TAdvSmoothButton;
    cxLabel98: TcxLabel;
    DeleteOrderButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure DetailButtonClick(Sender: TObject);
    procedure WebOrderPagerChange(Sender: TObject);
    procedure GridTableViewStylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      var AStyle: TcxStyle);
    procedure PriorButtonClick(Sender: TObject);
    procedure AllPickupButtonClick(Sender: TObject);
    procedure PickupButtonClick(Sender: TObject);
    procedure PickupCloseButtonClick(Sender: TObject);
    procedure PickupNowButtonClick(Sender: TObject);
  private
    NewCreate :Boolean;
    MaxPageCount :Integer;  //총페이지
    CurrentPage  :Integer;  //현재페이지
    OrderList : Array of TOrderList;
    OnePageCount :Integer;  //한페이지 표시갯수
    ClickTime :TDateTime;
    procedure CreateOrderList(aPage:TAdvOfficePage; aCount:Integer);
    procedure ClearOrderList(aPage:TAdvOfficePage);
    procedure ShowOrderList;
    procedure ShowDetailList;
    procedure SetListCount;
  public
    FormCall :String; //T:테이블화면에서 콜, O:주문화면에서 콜
  end;

var
  DeliveryTable_F: TDeliveryTable_F;

implementation
uses Common_U, DBModule_U, GlobalFunc_U, Const_U;
{$R *.dfm}
procedure TDeliveryTable_F.FormCreate(Sender: TObject);
begin
  Self.Width    := Screen.Width;
  Self.Height   := Screen.Height;
  Common.LogoCreate(Self,1);
  NewCreate := true;
  ClickTime           := IncSecond(Now,-3);
  CreateOrderList(OrderPage, OnePageCount);
end;

procedure TDeliveryTable_F.CreateOrderList(aPage:TAdvOfficePage; aCount:Integer);
var vIndex, vX, vY, vTop, vLeft, vWidth, vHeight, vIndex2, vIndex3, vCount  :Integer;
    vGridView :TcxGridTableView;
    vGridLevel :TcxGridLevel;
    vColumn    :TcxGridColumn;
begin
  if NewCreate then
  begin
    NewCreate := false;
    vX := StrToIntDef(GetOption(449),4);
    vY := StrToIntDef(GetOption(450),2);

    if vX < 4 then
      vX := 4;
    if vY < 2 then
      vY := 2;

    OnePageCount := vX * vY;

    SetLength(OrderList, OnePageCount);
    vWidth  := OrderPage.Width div vX - 3;
    vHeight := OrderPage.Height div vY - 2;

    vLeft  := 1;
    vTop   := 3;
    vCount := 0;
    for vIndex := 0 to High(OrderList) do
    begin
      if (vX - vCount) <= 0 then
      begin
        vCount := 1;
        vLeft  := 1;
        vTop  := vTop + vHeight;
      end
      else
        Inc(vCount);


      OrderList[vIndex].GroupBox := TPanel.Create(Self);
      OrderList[vIndex].GroupBox.Parent            := aPage;
      OrderList[vIndex].GroupBox.Align             := alNone;
      OrderList[vIndex].GroupBox.BevelOuter        := bvNone;
      OrderList[vIndex].GroupBox.ParentColor       := false;
      OrderList[vIndex].GroupBox.ParentBackground  := false;
      OrderList[vIndex].GroupBox.Color             := clWhite;
      OrderList[vIndex].GroupBox.Ctl3D             := false;
      OrderList[vIndex].GroupBox.BorderStyle       := bsSingle;
      OrderList[vIndex].GroupBox.Caption           := EmptyStr;
      OrderList[vIndex].GroupBox.Width             := vWidth;
      OrderList[vIndex].GroupBox.Height            := vHeight;
      OrderList[vIndex].GroupBox.Visible           := true;
      OrderList[vIndex].GroupBox.Top               := vTop;
      OrderList[vIndex].GroupBox.Left              := vLeft;

      OrderList[vIndex].TitleShape                 := TShape.Create(Self);
      OrderList[vIndex].TitleShape.Parent          := OrderList[vIndex].GroupBox;
      OrderList[vIndex].TitleShape.Pen.Style       := psClear;
      OrderList[vIndex].TitleShape.Align           := alNone;
      OrderList[vIndex].TitleShape.Brush.Color     := $00D06800;
      OrderList[vIndex].TitleShape.Height          := Trunc(vHeight * 0.15);// 50;
      OrderList[vIndex].TitleShape.Width           := OrderList[vIndex].GroupBox.Width;
      OrderList[vIndex].TitleShape.Top             := 0;
      OrderList[vIndex].TitleShape.Left            := 0;

      OrderList[vIndex].OrderType := TcxLabel.Create(Self);                                         //주문구문 포장 or 테이블번호
      OrderList[vIndex].OrderType.Parent           := OrderList[vIndex].GroupBox;
      OrderList[vIndex].OrderType.Style.Font.Name  := '맑은 고딕';
      OrderList[vIndex].OrderType.Style.Font.Size  := 17;
      OrderList[vIndex].OrderType.Style.Font.Color := clWhite;
      OrderList[vIndex].OrderType.Top              := 1;
      OrderList[vIndex].OrderType.Height           := Trunc(vHeight * 0.15) - 3;
      OrderList[vIndex].OrderType.Properties.Alignment.Vert := taVCenter;
      OrderList[vIndex].OrderType.Left             := 7;
      OrderList[vIndex].OrderType.Transparent      := true;

      OrderList[vIndex].OrderTime := TcxLabel.Create(Self);
      OrderList[vIndex].OrderTime.Parent           := OrderList[vIndex].GroupBox;
      OrderList[vIndex].OrderTime.Style.Font.Name  := '맑은 고딕';
      OrderList[vIndex].OrderTime.Style.Font.Size  := 11;
      OrderList[vIndex].OrderTime.Style.Font.Color := clWhite;
      OrderList[vIndex].OrderTime.Top              := 2;
      OrderList[vIndex].OrderTime.Left             := vWidth - 50;
      OrderList[vIndex].OrderTime.Transparent      := true;

      OrderList[vIndex].TableImage   := TImage.Create(Self);
      OrderList[vIndex].TableImage.Parent           := OrderList[vIndex].GroupBox;
      OrderList[vIndex].TableImage.Top              := Trunc(vHeight * 0.15) - 25;
      OrderList[vIndex].TableImage.Left             := 151;
      OrderList[vIndex].TableImage.Width            := 22;
      OrderList[vIndex].TableImage.Height           := 22;

      OrderList[vIndex].TimeImage   := TImage.Create(Self);
      OrderList[vIndex].TimeImage.Parent           := OrderList[vIndex].GroupBox;
      OrderList[vIndex].TimeImage.Top              := Trunc(vHeight * 0.15) - 25;
      OrderList[vIndex].TimeImage.Left             := 176;
      OrderList[vIndex].TimeImage.Width            := 22;
      OrderList[vIndex].TimeImage.Height           := 22;

      OrderList[vIndex].HotImage   := TImage.Create(Self);
      OrderList[vIndex].HotImage.Parent           := OrderList[vIndex].GroupBox;
      OrderList[vIndex].HotImage.Top              := 0;
      OrderList[vIndex].HotImage.Left             := 0;
      OrderList[vIndex].HotImage.Width            := 24;
      OrderList[vIndex].HotImage.Height           := 25;


      OrderList[vIndex].ElapsedTime := TcxLabel.Create(Self);
      OrderList[vIndex].ElapsedTime.Parent           := OrderList[vIndex].GroupBox;
      OrderList[vIndex].ElapsedTime.Style.Font.Name  := '맑은 고딕';
      OrderList[vIndex].ElapsedTime.Style.Font.Size  := 11;
      OrderList[vIndex].ElapsedTime.Style.Font.Color := clWhite;
      OrderList[vIndex].ElapsedTime.Top              := Trunc(vHeight * 0.15) - 25;
      OrderList[vIndex].ElapsedTime.Left             := vWidth - 50;
      OrderList[vIndex].ElapsedTime.AutoSize         := false;
      OrderList[vIndex].ElapsedTime.Width            := 45;
      OrderList[vIndex].ElapsedTime.Height           := 21;
      OrderList[vIndex].ElapsedTime.Properties.Alignment.Horz := taRightJustify;
      OrderList[vIndex].ElapsedTime.Transparent      := true;


      OrderList[vIndex].OrderTime := TcxLabel.Create(Self);
      OrderList[vIndex].OrderTime.Parent           := OrderList[vIndex].GroupBox;
      OrderList[vIndex].OrderTime.Style.Font.Name  := '맑은 고딕';
      OrderList[vIndex].OrderTime.Style.Font.Size  := 12;
      OrderList[vIndex].OrderTime.Style.Font.Color := clWhite;
      OrderList[vIndex].OrderTime.Top              := 2;
      OrderList[vIndex].OrderTime.Left             := vWidth - 55;
      OrderList[vIndex].OrderTime.Transparent      := true;

      OrderList[vIndex].MenuGrid := TcxGrid.Create(Self);
      OrderList[vIndex].MenuGrid.Parent      := OrderList[vIndex].GroupBox;
      vGridLevel := OrderList[vIndex].MenuGrid.Levels.Add;
      vGridView  := OrderList[vIndex].MenuGrid.CreateView(TcxGridTableView) as TcxGridTableView;
      vGridLevel.GridView := vGridView;
      OrderList[vIndex].MenuGrid.BorderStyle := cxcbsNone;
      OrderList[vIndex].MenuGrid.Top         := Trunc(vHeight * 0.15) + 1;
      OrderList[vIndex].MenuGrid.Left        := 1;
      OrderList[vIndex].MenuGrid.Width       := OrderList[vIndex].GroupBox.Width-2;
      OrderList[vIndex].MenuGrid.Height      := OrderList[vIndex].GroupBox.Height -Trunc(vHeight * 0.30) - 2;
      vGridView.OptionsView.Header          := false;
      OrderList[vIndex].MenuGrid.Font.Name := '맑은 고딕';
      OrderList[vIndex].MenuGrid.Font.Size := 12;
      vGridView.Styles.OnGetContentStyle  := GridTableViewStylesGetContentStyle;
      vGridView.OptionsView.GroupByBox    := false;
      vGridView.OptionsView.GridLines     := glNone;
      vGridView.OptionsView.ScrollBars    := ssNone;
      vGridView.OptionsSelection.CellSelect := false;

      vColumn := vGridView.CreateColumn;
      with vColumn do
      begin
        PropertiesClassName       := 'TcxLabelProperties';
        Properties.Alignment.Horz := taCenter;
        Properties.Alignment.Vert := taVCenter;
        Width                     := 10
      end;

      vColumn := vGridView.CreateColumn;
      with vColumn do
      begin
        PropertiesClassName       := 'TcxLabelProperties';
        Properties.Alignment.Vert := taVCenter;
        Width                     := OrderList[vIndex].GroupBox.Width - 55;
      end;

      vColumn := vGridView.CreateColumn;
      with vColumn do
      begin
        PropertiesClassName       := 'TcxCurrencyEditProperties';
        Properties.Alignment.Horz := taRightJustify;
        Properties.Alignment.Vert := taVCenter;
        TcxCustomCurrencyEditProperties(Properties).DisplayFormat := ',0';
        Width                     := 30;
      end;

      OrderList[vIndex].CancelButton := TPosButton.Create(Self);
      OrderList[vIndex].CancelButton.Parent     := OrderList[vIndex].GroupBox;
      OrderList[vIndex].CancelButton.Color      := clWhite;
      OrderList[vIndex].CancelButton.Font.Name  := '맑은 고딕';
      OrderList[vIndex].CancelButton.Font.Size  := 13;
      OrderList[vIndex].CancelButton.Font.Color := $00D06800;
      OrderList[vIndex].CancelButton.BorderStyle := pbsSingle;
      OrderList[vIndex].CancelButton.BorderColor := $00D06800;
      OrderList[vIndex].CancelButton.Top      := vHeight - Trunc(vHeight * 0.15) -1;
      OrderList[vIndex].CancelButton.Width    := vWidth div 2 - 10;
      OrderList[vIndex].CancelButton.Height   := Trunc(vHeight * 0.15) - 5;
      OrderList[vIndex].CancelButton.Left     := 5;
      OrderList[vIndex].CancelButton.Caption  := '상세내역';
      OrderList[vIndex].CancelButton.OnClick  := DetailButtonClick;
      OrderList[vIndex].CancelButton.Tag      := vIndex;

      OrderList[vIndex].OkButton := TPosButton.Create(Self);
      OrderList[vIndex].OkButton.Parent           := OrderList[vIndex].GroupBox;
      OrderList[vIndex].OkButton.Color      := $00D06800;
      OrderList[vIndex].OkButton.Font.Name  := '맑은 고딕';
      OrderList[vIndex].OkButton.Font.Size  := 13;
      OrderList[vIndex].OkButton.Font.Color := clWhite;
      OrderList[vIndex].OkButton.BorderStyle := pbsSingle;
      OrderList[vIndex].OkButton.BorderColor := $00D06800;
      OrderList[vIndex].OkButton.Top      := vHeight - Trunc(vHeight * 0.15)-1;
      OrderList[vIndex].OkButton.Width    := vWidth div 2 - 10;
      OrderList[vIndex].OkButton.Height   := Trunc(vHeight * 0.15) - 5;//45;
      OrderList[vIndex].OkButton.Left     := vWidth div 2 + 3;
      OrderList[vIndex].OkButton.OnClick  := OkButtonClick;
      OrderList[vIndex].OkButton.Caption  := '조리시작';
      OrderList[vIndex].OkButton.Cursor   := crHandPoint;
      OrderList[vIndex].OkButton.Tag      := vIndex;

      vLeft := vLeft + vWidth + 3;
    end;
  end
  else
  begin
//    SetLength(OrderList, aCount);
    for vIndex := 0 to High(OrderList) do
    begin
      OrderList[vIndex].GroupBox.Visible := false;
      OrderList[vIndex].GroupBox.Parent  := aPage;
      OrderList[vIndex].MenuGrid.Views[0].DataController.RecordCount := 0;
    end;
  end;
end;

procedure TDeliveryTable_F.SetListCount;
begin
  OrderPage.Badge   := '';
  PickupPage.Badge  := '';
  OpenQuery('select DS_STATUS, COUNT(DS_STATUS) '
           +'  from (select distinct NO_RECEIPT, DS_STATUS '
           +'          from SL_LETSORDER '
           +'         where CD_STORE  =:P0 '
           +'         group by NO_RECEIPT '
           +'       ) as t '
           +' group by DS_STATUS ',
           [Common.Config.StoreCode]);
  while not Common.Query.Eof do
  begin
    Common.Query.Next;
  end;
  Common.Query.Close;
end;

procedure TDeliveryTable_F.AllPickupButtonClick(Sender: TObject);
begin
  if not Common.AskBox('픽업대기를 일괄픽업완료'#13'처리 하시겠습니까?') then Exit;

  ExecQuery('delete from SL_LETSORDER '
           +' where CD_STORE  = :P0 '
           +'   and DS_STATUS = ''2'' ',
           [Common.Config.StoreCode]);

  ShowOrderList;
end;

procedure TDeliveryTable_F.ClearOrderList(aPage:TAdvOfficePage);
var vIndex :Integer;
begin
  for vIndex := 0 to High(OrderList) do
  begin
    OrderList[vIndex].GroupBox.Parent       := aPage;
    OrderList[vIndex].GroupBox.Visible      := false;
    OrderList[vIndex].ReceiptNo             := '';
    OrderList[vIndex].MenuGrid.Views[0].DataController.RecordCount := 0;
    OrderList[vIndex].OrderTime.Caption     := '';
    OrderList[vIndex].DsOrder               := '';
    OrderList[vIndex].Status                := '';
    OrderList[vIndex].ElapsedTime.Caption   := '';
    OrderList[vIndex].TableImage.Visible    := false;
    OrderList[vIndex].TimeImage.Visible     := false;
    OrderList[vIndex].HotImage.Visible      := false;
  end;
end;


procedure TDeliveryTable_F.ShowDetailList;
  function GetListIndex(aReceiptNo:String):Integer;
  var vIndex :Integer;
  begin
    Result := -1;
    for vIndex := 0 to High(OrderList) do
    begin
      if (OrderList[vIndex].ReceiptNo = aReceiptNo) then
      begin
        Result := vIndex;
        Break;
      end;
    end;
  end;
var vIndex, vIdx, vIndex2, vSeq :Integer;
    vOrderNo, vStatus, vReceiptNo :String;
begin
  ClearOrderList(WebOrderPager.ActivePage);
//  if WebOrderPager.ActivePage = OrderPage then
//    vStatus := '0'
//  else if WebOrderPager.ActivePage = CookingPage then
//    vStatus := '1'
//  else if WebOrderPager.ActivePage = PickupPage then
//    vStatus := '2';

  OpenQuery('select NO_RECEIPT '
           +'  from SL_LETSORDER '
           +' where CD_STORE  =:P0 '
           +'   and DS_STATUS =:P1 '
           +'  group by NO_RECEIPT '
           +'  limit :P2, :P3 ',
           [Common.Config.StoreCode,
            vStatus,
            (CurrentPage-1) * OnePageCount,
            OnePageCount ]);
  vReceiptNo := '';

  while not Common.Query.Eof do
  begin
    vReceiptNo := vReceiptNo + Format('''%s'',',[Common.Query.Fields[0].AsString]);
    Common.Query.Next;
  end;
  Common.Query.Close;

  if vReceiptNo = '' then
    Exit;
  vReceiptNo := Format('and o.NO_RECEIPT in (%s) ',[LeftStr(vReceiptNo,Length(vReceiptNo)-1)]);

  OpenQuery('select o.NO_GROUP, '
           +'       o.NO_STEP, '
           +'       o.NO_RECEIPT, '
           +'       o.NO_ORDER, '
           +'       Date_Format(o.DT_ORDER, ''%H:%i'') as DT_ORDER, '
           +'       o.DS_STATUS, '
           +'       o.MENU_MEMO, '
           +'       o.CD_MENU, '
           +'       o.CD_MENU1, '
           +'       m.NM_MENU, '
           +'       o.QTY_ORDER, '
           +'       o.DS_ORDER_TYPE, '
           +'       GetPhoneNo(o.TEL_MOBILE) as TEL_MOBILE, '
           +'       s.NM_MENU as NM_MENU_SUB, '
           +'       TIMESTAMPDIFF(minute,  o.DT_ORDER, NOW() ) as LAPES_TIME, '
           +'       o.NO_TABLE, '
           +'       TIMESTAMPDIFF(minute,  o.DT_PICKUP, NOW() ) as PICKUP_TIME, '
           +'       TIMESTAMPDIFF(minute,  o.DT_CHANGE, o.DT_PICKUP ) as PICKUP_TIME2, '
           +'       o.DT_PICKUP '
           +'  from SL_LETSORDER as o inner join '
           +'       MS_MENU      as m on m.CD_STORE  = o.CD_STORE '
           +'                        and m.CD_MENU   = o.CD_MENU left outer join '
           +'       MS_MENU      as s on s.CD_STORE  = o.CD_STORE '
           +'                        and s.CD_MENU   = o.CD_MENU1 '
           +' where o.CD_STORE  =:P0 '
           +'   and o.DS_STATUS =:P1 '
           +vReceiptNo
           +' order by o.NO_RECEIPT desc, o.NO_GROUP, o.NO_STEP ',
           [Common.Config.StoreCode,
            vStatus]);


  vOrderNo := '';

  for vIndex := 0 to High(OrderList) do
    OrderList[vIndex].MenuGrid.Views[0].DataController.BeginUpdate;

  vIndex2 := -1;
  vSeq := 1;
  while not Common.Query.Eof do
  begin
    vIdx := GetListIndex(Common.Query.FieldByName('NO_RECEIPT').AsString);
    if vIdx >= 0 then
      vIndex := vIdx
    else
    begin
      Inc(vIndex2);
      vIndex := vIndex2;
      vSeq := 1;
    end;

    OrderList[vIndex].ReceiptNo          := Common.Query.FieldByName('NO_RECEIPT').AsString;
    OrderList[vIndex].OkButton.Tag       := vIndex;        //주문상태저장
    OrderList[vIndex].CancelButton.Tag   := vIndex;        //주문상태저장
    OrderList[vIndex].GroupBox.Visible   := true;
    OrderList[vIndex].MobielNo           := Common.Query.FieldByName('TEL_MOBILE').AsString;
    if OrderList[vIndex].MobielNo = '000-0000-0000' then
      OrderList[vIndex].MobielNo := '';

    OrderList[vIndex].TableImage.Visible := false;
    OrderList[vIndex].HotImage.Visible   := false;

    OrderList[vIndex].OrderTime.Caption    := Common.Query.FieldByName('DT_ORDER').AsString;
    OrderList[vIndex].Status               := Common.Query.FieldByName('DS_STATUS').AsString;
    OrderList[vIndex].ElapsedTime.Caption  := Format('%d분',[Common.Query.FieldByName('LAPES_TIME').AsInteger]);
    //주문한지 3분이내이면 핫이미지 표시

    OrderList[vIndex].OrderNo              := Common.Query.FieldByName('NO_ORDER').AsString;

    if vStatus = '2' then
      OrderList[vIndex].PickupTime  := Format('%s (%d분)',[FormatDateTime('hh:nn', Common.Query.FieldByName('DT_PICKUP').AsDateTime), Common.Query.FieldByName('PICKUP_TIME').AsInteger])
    //픽업예정기능 사용시
    else if (GetOption(192) = '2') and (vStatus = '1') then
      OrderList[vIndex].PickupTime  := Format('%s (%d분)',[FormatDateTime('hh:nn', Common.Query.FieldByName('DT_PICKUP').AsDateTime), Common.Query.FieldByName('PICKUP_TIME2').AsInteger]);


    if Common.Query.FieldByName('NO_TABLE').AsInteger = 0  then
      OrderList[vIndex].OrderType.Caption := Format('포장 [ %s ]',[Common.Query.FieldByName('NO_ORDER').AsString])
    else
    begin
      OrderList[vIndex].OrderType.Caption := Format('매장 [ %s ]',[Common.Query.FieldByName('NO_ORDER').AsString]);
      OrderList[vIndex].TableImage.Visible  := true;
    end;

    OrderList[vIndex].MenuGrid.Views[0].DataController.AppendRecord;
    if Common.Query.FieldByName('CD_MENU1').AsString = '' then
    begin
      OrderList[vIndex].MenuGrid.Views[0].DataController.Values[OrderList[vIndex].MenuGrid.Views[0].DataController.RecordCount-1, 0] := IntToStr(vSeq);
      OrderList[vIndex].MenuGrid.Views[0].DataController.Values[OrderList[vIndex].MenuGrid.Views[0].DataController.RecordCount-1, 1] := Common.Query.FieldByName('NM_MENU').AsString;
      OrderList[vIndex].MenuGrid.Views[0].DataController.Values[OrderList[vIndex].MenuGrid.Views[0].DataController.RecordCount-1, 2] := Common.Query.FieldByName('QTY_ORDER').AsString;
      Inc(vSeq);
    end
    else
    begin
      OrderList[vIndex].MenuGrid.Views[0].DataController.Values[OrderList[vIndex].MenuGrid.Views[0].DataController.RecordCount-1, 0] := '';
      OrderList[vIndex].MenuGrid.Views[0].DataController.Values[OrderList[vIndex].MenuGrid.Views[0].DataController.RecordCount-1, 1] := '-'+Common.Query.FieldByName('NM_MENU_SUB').AsString;
      OrderList[vIndex].MenuGrid.Views[0].DataController.Values[OrderList[vIndex].MenuGrid.Views[0].DataController.RecordCount-1, 2] := Common.Query.FieldByName('QTY_ORDER').AsString;
    end;

    Common.Query.Next;
  end;
  Common.Query.Close;
  for vIndex := 0 to High(OrderList) do
    OrderList[vIndex].MenuGrid.Views[0].DataController.EndUpdate;
end;

procedure TDeliveryTable_F.ShowOrderList;
var vIndex, vIdx, vIndex2, vSeq, vCount :Integer;
    vOrderNo, vStatus :String;
begin
  if NewCreate then Exit;

  SetListCount;
  ClearOrderList(WebOrderPager.ActivePage);
  if WebOrderPager.ActivePage = OrderPage then
    vStatus := '0'
//  else if WebOrderPager.ActivePage = CookingPage then
//    vStatus := '1'
  else if WebOrderPager.ActivePage = PickupPage then
    vStatus := '2';

  OpenQuery('select distinct NO_RECEIPT '
           +'  from SL_LETSORDER '
           +' where CD_STORE  =:P0 '
           +'   and DS_STATUS =:P1 '
           +' group by NO_RECEIPT ',
           [Common.Config.StoreCode,
            vStatus]);
  if not Common.Query.Eof then
    vCount := Common.Query.RecordCount
  else
    vCount := 0;

  Common.Query.Close;
  CreateOrderList(WebOrderPager.ActivePage, vCount);

  MaxPageCount := 0;
  MaxPageCount := vCount div OnePageCount;
  if vCount mod OnePageCount > 0 then
    MaxPageCount := MaxPageCount + 1;

  CurrentPage := 1;
  PageLabel.Caption := Format('%d/%d',[CurrentPage, MaxPageCount]);

  PriorButton.Enabled := false;
  NextButton.Enabled  := MaxPageCount > 1;

  PageLabel.Visible   :=  MaxPageCount > 1;
  PriorButton.Visible :=  MaxPageCount > 1;
  NextButton.Visible  :=  MaxPageCount > 1;

  if vCount > 0 then
    ShowDetailList;
end;


procedure TDeliveryTable_F.WebOrderPagerChange(Sender: TObject);
begin
  ShowOrderList;
end;


procedure TDeliveryTable_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;


//주문버튼 클릭
procedure TDeliveryTable_F.OkButtonClick(Sender: TObject);
var vIndex, vRow   :Integer;
    vTableNo, vCallNo :Integer;
    vPrintData, vStatus :String;
begin
  if MilliSecondsBetween(Now(),ClickTime) < 500 then Exit;
  ClickTime := Now;

  vIndex   := (Sender as TPosButton).Tag;

//  if WebOrderPager.ActivePage = CookingPage then
//  begin
//    if (GetOption(192) = '1') and (OrderList[vIndex].MobielNo <> '') then
//    begin
//      OpenQuery('select NO_CALL '
//               +'  from SL_SALE_H '
//               +' where CD_STORE =:P0 '
//               +'   and YMD_SALE =:P1 '
//               +'   and NO_POS   =:P2 '
//               +'   and NO_RCP   =:P3 ',
//               [Common.Config.StoreCode,
//                LeftStr(OrderList[vIndex].ReceiptNo,8),
//                Copy(OrderList[vIndex].ReceiptNo,9,2),
//                RightStr(OrderList[vIndex].ReceiptNo,4)]);
//
//      if not Common.Query.Eof then
//        vCallNo := Common.Query.FieldByName('NO_CALL').AsInteger
//      else
//        vCallNo := -1;
//      Common.Query.Close;
//
//
//      if vCallNo > 0 then
//      begin
//        Common.KaKaoSendMessage('L', [IntToStr(vCallNo)], GetOnlyNumber(OrderList[vIndex].MobielNo), '알림톡 호출실패');
//        if (GetOption(478) = '1') and (Common.Config.BellDev = 2) then
//        begin
//          ExecQuery('insert into MS_ORDERNO(CD_STORE, DS_NUMBER, NO_POS, NO_ORDER, PICKUP_POS, DT_CHANGE, TEL_MOBILE)'
//                   +'                 values(:P0, ''D'', ''00'', :P1, :P2, Now(), :P3)  '
//                   +'ON DUPLICATE KEY UPDATE DT_CHANGE = Now() ',
//                   [Common.Config.StoreCode,
//                    vCallNo,
//                    Common.Config.DIDPickupPos,
//                    GetOnlyNumber(OrderList[vIndex].MobielNo)]);
//        end;
//      end;
//    end;
//
//    //확인증 출력
//    if GetOption(66) = '1' then
//    begin
//      vPrintData:= rptAlignCenter;
//      //전화번호가 있을때
//      if OrderList[vIndex].MobielNo <> '' then
//        vPrintData:= vPrintData+ rptSize3Times   + '전화번호'+rptLF+rptAlignCenter+ '[ '+RightStr(OrderList[vIndex].MobielNo,4)+ ' ]'+rptLF+rptLF
//      else if OrderList[vIndex].TableNo > 0 then
//        vPrintData:= vPrintData+ rptSize3Times   + 'TableNo -'+IntToStr(OrderList[vIndex].TableNo)+ rptLF+rptLF
//      else
//        vPrintData:= vPrintData+ rptSize3Times   + '주문번호'+rptLF+rptAlignCenter+ '[ '+OrderList[vIndex].OrderNo+ ' ]'+rptLF+rptLF;
//
//      vPrintData := vPrintData + rptAlignLeft;
//      vPrintData := vPrintData + rptSizeHeight;
//      for vRow := 0 to OrderList[vIndex].MenuGrid.Views[0].DataController.RecordCount-1 do
//      begin
//        if OrderList[vIndex].MenuGrid.Views[0].DataController.Values[vRow, 0] <> '' then
//        begin
//          vPrintData := vPrintData + rptCharBold;
//          vPrintData := vPrintData + RPadB(OrderList[vIndex].MenuGrid.Views[0].DataController.Values[vRow, 1],38,' ')+
//                                     LPadB(IntToStr(OrderList[vIndex].MenuGrid.Views[0].DataController.Values[vRow, 2]),4,' ')+rptLF;
//        end
//        else
//        begin
//          vPrintData := vPrintData + rptCharNormal;
//          vPrintData := vPrintData + ' '+RPadB(OrderList[vIndex].MenuGrid.Views[0].DataController.Values[vRow, 1],37,' ')+
//                                     LPadB(IntToStr(OrderList[vIndex].MenuGrid.Views[0].DataController.Values[vRow, 2]),4,' ')+rptLF;
//        end;
//      end;
//      vPrintData := vPrintData + rptLF;
//
//      Common.Device.PrintData :=vPrintData;
//      Common.Device.PrintPrinter(rptLetsOrder);
//    end;
//  end;
  ShowOrderList;
end;

procedure TDeliveryTable_F.PriorButtonClick(Sender: TObject);
begin
  if Sender = PriorButton then
  begin
    CurrentPage := CurrentPage - 1;
    PriorButton.Enabled := CurrentPage > 1;
    NextButton.Enabled  := true;
  end
  else
  begin
    CurrentPage := CurrentPage + 1;
    PriorButton.Enabled := true;
    NextButton.Enabled  := CurrentPage < MaxPageCount;
  end;
  PageLabel.Caption := Format('%d/%d',[CurrentPage, MaxPageCount]);
  ShowDetailList;
end;

procedure TDeliveryTable_F.PickupButtonClick(Sender: TObject);
var vIndex :Integer;
begin
  vIndex   := (Sender as TPosButton).Tag;

  if not Common.AskBox('픽업대기 변경 하시겠습니까?') then Exit;

  ExecQuery('update SL_LETSORDER '
           +'   set DS_STATUS = ''2'' '
           +' where CD_STORE  = :P0 '
           +'   and NO_RECEIPT =:P1 ',
           [Common.Config.StoreCode,
            OrderList[vIndex].ReceiptNo]);

  ShowOrderList;
end;

procedure TDeliveryTable_F.PickupCloseButtonClick(Sender: TObject);
begin
  WebOrderPager.Enabled   := true;
  CloseButton.Enabled     := true;
end;

procedure TDeliveryTable_F.PickupNowButtonClick(Sender: TObject);
var vMessage, vReceipt, vResult :String;
    vMinute :Integer;
begin
  vMinute := (Sender as TAdvSmoothButton).Tag;
end;

procedure TDeliveryTable_F.DetailButtonClick(Sender: TObject);
var vIndex   :Integer;
    vTableNo :Integer;
    vStatus :String;
    vSeq    :Integer;
begin
  vIndex   := (Sender as TPosButton).Tag;
//  OpenQuery('select o.CD_MENU1, '
//           +'       m.NM_MENU, '
//           +'       o.QTY_ORDER, '
//           +'       s.NM_MENU as NM_MENU_SUB '
//           +'  from SL_LETSORDER as o inner join '
//           +'       MS_MENU      as m on m.CD_STORE  = o.CD_STORE '
//           +'                        and m.CD_MENU   = o.CD_MENU left outer join '
//           +'       MS_MENU      as s on s.CD_STORE  = o.CD_STORE '
//           +'                        and s.CD_MENU   = o.CD_MENU1 '
//           +' where o.CD_STORE   =:P0 '
//           +'   and o.NO_RECEIPT =:P1 '
//           +' order by o.NO_RECEIPT desc, o.NO_GROUP, o.NO_STEP ',
//           [Common.Config.StoreCode,
//            OrderList[vIndex].ReceiptNo]);
//
//  OrderPanel.Visible := true;
//  GridTableView.DataController.RecordCount := 0;
//  vSeq := 1;
//  while not Common.Query.Eof do
//  begin
//    GridTableView.DataController.AppendRecord;
//    if Common.Query.FieldByName('CD_MENU1').AsString = '' then
//    begin
//      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewSeq.Index]      := IntToStr(vSeq);
//      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewMenuName.Index] := Common.Query.FieldByName('NM_MENU').AsString;
//      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewQty.Index]      := Common.Query.FieldByName('QTY_ORDER').AsInteger;
//      Inc(vSeq);
//    end
//    else
//    begin
//      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewSeq.Index] := '';
//      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewMenuName.Index] := '-'+Common.Query.FieldByName('NM_MENU_SUB').AsString;
//      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewQty.Index]      := Common.Query.FieldByName('QTY_ORDER').AsInteger;
//    end;
//    Common.Query.Next;
//  end;
  Common.Query.Close;
end;

procedure TDeliveryTable_F.FormShow(Sender: TObject);
begin
//  WebOrderPager.ActivePageIndex := 0;
  ShowOrderList;
end;

procedure TDeliveryTable_F.GridTableViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if ARecord.Values[0] = '' then
    AStyle := StyleFontDetail;
end;

//접수 페이지 Show
end.
