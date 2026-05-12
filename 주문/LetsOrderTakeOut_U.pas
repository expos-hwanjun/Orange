unit LetsOrderTakeOut_U;

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
  AdvScrollControl, cxImage, Winapi.MMSystem, AdvSmoothButton, DateUtils,
  dxDateRanges, dxScrollbarAnnotations;

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
    CancelButton   :TPosButton;
    OkButton       :TPosButton;
  end;

type
  TLetsOrderTakeOut_F = class(TForm)
    CloseButton: TcxButton;
    TitleLabel: TLabel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    WebOrderPager: TAdvOfficePager;
    OrderPage: TAdvOfficePage;
    CookingPage: TAdvOfficePage;
    PickupPage: TAdvOfficePage;
    Panel1: TPanel;
    Shape1: TShape;
    cxLabel1: TcxLabel;
    PosButton2: TPosButton;
    PosButton1: TPosButton;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    Image1: TImage;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    cxLabel8: TcxLabel;
    OfficeStyler: TAdvOfficePagerOfficeStyler;
    Panel2: TPanel;
    Shape2: TShape;
    PosButton3: TPosButton;
    PosButton4: TPosButton;
    cxLabel9: TcxLabel;
    cxLabel10: TcxLabel;
    cxLabel11: TcxLabel;
    cxLabel12: TcxLabel;
    cxLabel13: TcxLabel;
    cxLabel14: TcxLabel;
    cxLabel15: TcxLabel;
    Image4: TImage;
    cxLabel17: TcxLabel;
    Image3: TImage;
    cxLabel16: TcxLabel;
    StyleRepository: TcxStyleRepository;
    StyleFontDetail: TcxStyle;
    StyleHeader: TcxStyle;
    OrderPanel: TAdvToolPanel;
    DetailOkButton: TPosButton;
    CancelButton: TPosButton;
    Grid: TcxGrid;
    GridTableView: TcxGridTableView;
    GridTableViewSeq: TcxGridColumn;
    GridTableViewMenuName: TcxGridColumn;
    GridTableViewQty: TcxGridColumn;
    GridLevel: TcxGridLevel;
    KakaoImage: TImage;
    MobileNoLabel: TcxLabel;
    NextButton: TAdvGlassButton;
    PriorButton: TAdvGlassButton;
    PageLabel: TcxLabel;
    TimeImage: TImage;
    TableImage: TImage;
    PickupTimeLabel: TcxLabel;
    Image2: TImage;
    PickTableImage: TImage;
    PickUpTableNoLabel: TcxLabel;
    AllPickupButton: TAdvGlassButton;
    PickupButton: TPosButton;
    HotImage: TImage;
    PickupPanel: TAdvToolPanel;
    Image6: TImage;
    PickupTelNoLabel: TcxLabel;
    Pickup5Button: TAdvSmoothButton;
    Pickup10Button: TAdvSmoothButton;
    Pickup15Button: TAdvSmoothButton;
    Pickup20Button: TAdvSmoothButton;
    Pickup25Button: TAdvSmoothButton;
    PickupCloseButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure DetailButtonClick(Sender: TObject);
    procedure WebOrderPagerChange(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
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
    procedure WMCopyData(var Msg:TWmCopyData); message WM_CopyData;
  public
    FormCall :String; //T:테이블화면에서 콜, O:주문화면에서 콜
  end;

var
  LetsOrderTakeOut_F: TLetsOrderTakeOut_F;

implementation
uses Common_U, DBModule_U, GlobalFunc_U, Const_U;
{$R *.dfm}
procedure TLetsOrderTakeOut_F.FormCreate(Sender: TObject);
begin
  Self.Width    := Screen.Width;
  Self.Height   := Screen.Height;
  Common.LogoCreate(Self,1);
  Common.SetButtonColor(AllPickupButton);
  NewCreate := true;
  OrderPanel.Visible := false;
  PickupPanel.Visible := false;
  ClickTime           := IncSecond(Now,-3);
  //주문 시 조리중으로 저장한다고 했을때는 주문탭을 안보이기게 한다
  if GetOption(62) = '1' then
  begin
    OrderPage.TabVisible   := false;
    CookingPage.Caption    := ' 주문 ';
    WebOrderPager.ActivePage := CookingPage;
    CreateOrderList(CookingPage, OnePageCount);
  end
  else
    CreateOrderList(OrderPage, OnePageCount);
  OrderPanel.Left := (Self.Width - OrderPanel.Width)  div 2;
  OrderPanel.Top  := (Self.Height -OrderPanel.Height) div 2;

  PickupPanel.Left := (Self.Width - PickupPanel.Width)  div 2;
  PickupPanel.Top  := (Self.Height -PickupPanel.Height) div 2;
end;

procedure TLetsOrderTakeOut_F.CreateOrderList(aPage:TAdvOfficePage; aCount:Integer);
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
    vTop   := 0;
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
      OrderList[vIndex].OrderType.Style.Font.Size  := 15;
      OrderList[vIndex].OrderType.Style.Font.Color := clWhite;
      OrderList[vIndex].OrderType.Top              := 1;
      OrderList[vIndex].OrderType.Height           := Trunc(vHeight * 0.15) - 3;
      OrderList[vIndex].OrderType.Properties.Alignment.Vert := taVCenter;
      OrderList[vIndex].OrderType.Left             := 7;
      OrderList[vIndex].OrderType.Transparent      := true;

      OrderList[vIndex].OrderTime := TcxLabel.Create(Self);
      OrderList[vIndex].OrderTime.Parent           := OrderList[vIndex].GroupBox;
      OrderList[vIndex].OrderTime.Style.Font.Name  := '맑은 고딕';
      OrderList[vIndex].OrderTime.Style.Font.Size  := 13;
      OrderList[vIndex].OrderTime.Style.Font.Color := clWhite;
      OrderList[vIndex].OrderTime.Top              := 0;
      OrderList[vIndex].OrderTime.Left             := vWidth - 50;
      OrderList[vIndex].OrderTime.Transparent      := true;
      OrderList[vIndex].OrderTime.Properties.Alignment.Vert := taTopJustify;

      OrderList[vIndex].TableImage   := TImage.Create(Self);
      OrderList[vIndex].TableImage.Parent           := OrderList[vIndex].GroupBox;
      OrderList[vIndex].TableImage.Top              := Trunc(vHeight * 0.15) - 25;
      OrderList[vIndex].TableImage.Left             := 151;
      OrderList[vIndex].TableImage.Width            := 22;
      OrderList[vIndex].TableImage.Height           := 22;
      OrderList[vIndex].TableImage.Picture          := TableImage.Picture;

      OrderList[vIndex].TimeImage   := TImage.Create(Self);
      OrderList[vIndex].TimeImage.Parent           := OrderList[vIndex].GroupBox;
      OrderList[vIndex].TimeImage.Top              := Trunc(vHeight * 0.15) - 25;
      OrderList[vIndex].TimeImage.Left             := 176;
      OrderList[vIndex].TimeImage.Width            := 22;
      OrderList[vIndex].TimeImage.Height           := 22;
      OrderList[vIndex].TimeImage.Picture          := TimeImage.Picture;

      OrderList[vIndex].HotImage   := TImage.Create(Self);
      OrderList[vIndex].HotImage.Parent           := OrderList[vIndex].GroupBox;
      OrderList[vIndex].HotImage.Top              := 0;
      OrderList[vIndex].HotImage.Left             := 0;
      OrderList[vIndex].HotImage.Width            := 24;
      OrderList[vIndex].HotImage.Height           := 25;
      OrderList[vIndex].HotImage.Picture          := HotImage.Picture;


      OrderList[vIndex].ElapsedTime := TcxLabel.Create(Self);
      OrderList[vIndex].ElapsedTime.Parent           := OrderList[vIndex].GroupBox;
      OrderList[vIndex].ElapsedTime.Style.Font.Name  := '맑은 고딕';
      OrderList[vIndex].ElapsedTime.Style.Font.Size  := 13;
      OrderList[vIndex].ElapsedTime.Style.Font.Color := clWhite;
      OrderList[vIndex].ElapsedTime.Top              := Trunc(vHeight * 0.15) - 30;
      OrderList[vIndex].ElapsedTime.Left             := vWidth - 50;
      OrderList[vIndex].ElapsedTime.AutoSize         := false;
      OrderList[vIndex].ElapsedTime.Width            := 45;
      OrderList[vIndex].ElapsedTime.Height           := 30;
      OrderList[vIndex].ElapsedTime.Properties.Alignment.Horz := taRightJustify;
      OrderList[vIndex].ElapsedTime.Transparent      := true;


//      OrderList[vIndex].OrderTime := TcxLabel.Create(Self);
//      OrderList[vIndex].OrderTime.Parent           := OrderList[vIndex].GroupBox;
//      OrderList[vIndex].OrderTime.Style.Font.Name  := '맑은 고딕';
//      OrderList[vIndex].OrderTime.Style.Font.Size  := 15;
//      OrderList[vIndex].OrderTime.Style.Font.Color := clWhite;
//      OrderList[vIndex].OrderTime.Top              := 0;
//      OrderList[vIndex].OrderTime.Left             := vWidth - 55;
//      OrderList[vIndex].OrderTime.Transparent      := true;

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
      OrderList[vIndex].MenuGrid.Font.Size := 15;
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
      OrderList[vIndex].CancelButton.Font.Size  := 16;
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
      OrderList[vIndex].OkButton.Font.Size  := 16;
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

      if aPage = OrderPage then
        OrderList[vIndex].OKButton.Caption := '조리시작'
      else if aPage = CookingPage then
        OrderList[vIndex].OKButton.Caption := '호 출'
      else if aPage = PickupPage then
        OrderList[vIndex].OKButton.Caption := '픽업완료';
    end;
  end;
end;

procedure TLetsOrderTakeOut_F.SetListCount;
begin
  OrderPage.Badge   := '';
  CookingPage.Badge := '';
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
    if Common.Query.Fields[0].AsString = '0' then
      OrderPage.Badge := Common.Query.Fields[1].AsString
    else if Common.Query.Fields[0].AsString = '1' then
      CookingPage.Badge := Common.Query.Fields[1].AsString
    else if Common.Query.Fields[0].AsString = '2' then
      PickupPage.Badge := Common.Query.Fields[1].AsString;
    Common.Query.Next;
  end;
  Common.Query.Close;
end;

procedure TLetsOrderTakeOut_F.AllPickupButtonClick(Sender: TObject);
begin
  if not Common.AskBox('픽업대기를 일괄픽업완료'#13'처리 하시겠습니까?') then Exit;

  ExecQuery('delete from SL_LETSORDER '
           +' where CD_STORE  = :P0 '
           +'   and DS_STATUS = ''2'' ',
           [Common.Config.StoreCode]);

  ShowOrderList;
end;

procedure TLetsOrderTakeOut_F.ClearOrderList(aPage:TAdvOfficePage);
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


procedure TLetsOrderTakeOut_F.ShowDetailList;
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
    vOrderNo, vStatus, vReceiptNo, vOrderBy :String;
begin
  ClearOrderList(WebOrderPager.ActivePage);
  if WebOrderPager.ActivePage = OrderPage then
  begin
    vStatus := '0';
    vOrderBy := 'order by o.DT_ORDER desc ';
  end
  else if WebOrderPager.ActivePage = CookingPage then
  begin
    vStatus := '1';
    vOrderBy := 'order by o.DT_PICKUP desc ';
  end
  else if WebOrderPager.ActivePage = PickupPage then
  begin
    vStatus := '2';
    vOrderBy := 'order by o.DT_CHANGE desc ';
  end;

  OpenQuery('select NO_RECEIPT '
           +'  from SL_LETSORDER '
           +' where CD_STORE  =:P0 '
           +'   and DS_STATUS =:P1 '
           +'  group by NO_RECEIPT '
           +Replace(vOrderBy, 'o.','')
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
           +vOrderBy +', o.NO_RECEIPT, o.NO_GROUP, o.NO_STEP ',
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

    if ((GetOption(62)='0') and (WebOrderPager.ActivePage = OrderPage) and (Common.Query.FieldByName('LAPES_TIME').AsInteger <= 3))
       or ((GetOption(62)='1') and (WebOrderPager.ActivePage = CookingPage) and (Common.Query.FieldByName('LAPES_TIME').AsInteger <= 3)) then
      OrderList[vIndex].HotImage.Visible := true;
    OrderList[vIndex].OrderNo              := Common.Query.FieldByName('NO_ORDER').AsString;

    if vStatus = '2' then
      OrderList[vIndex].PickupTime  := Format('%s (%d분)',[FormatDateTime('hh:nn', Common.Query.FieldByName('DT_PICKUP').AsDateTime), Common.Query.FieldByName('PICKUP_TIME').AsInteger])
    //픽업예정기능 사용시
    else if (GetOption(192) = '2') and (vStatus = '1') then
      OrderList[vIndex].PickupTime  := Format('%s (%d분)',[FormatDateTime('hh:nn', Common.Query.FieldByName('DT_PICKUP').AsDateTime), Common.Query.FieldByName('PICKUP_TIME2').AsInteger]);


    if Common.Query.FieldByName('NO_TABLE').AsInteger = 0  then
    begin
      if OrderList[vIndex].MobielNo <> '' then
        OrderList[vIndex].OrderType.Caption := Format('%s [%s]',[OrderList[vIndex].MobielNo, Common.Query.FieldByName('NO_ORDER').AsString])
      else
        OrderList[vIndex].OrderType.Caption := Format('포장 [ %s ]',[Common.Query.FieldByName('NO_ORDER').AsString]);
    end
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

procedure TLetsOrderTakeOut_F.ShowOrderList;
var vIndex, vIdx, vIndex2, vSeq, vCount :Integer;
    vOrderNo, vStatus :String;
begin
  if NewCreate then Exit;

  SetListCount;
  ClearOrderList(WebOrderPager.ActivePage);
  if WebOrderPager.ActivePage = OrderPage then
    vStatus := '0'
  else if WebOrderPager.ActivePage = CookingPage then
    vStatus := '1'
  else if WebOrderPager.ActivePage = PickupPage then
    vStatus := '2';

  OpenQuery('select distinct NO_RECEIPT '
           +'  from SL_LETSORDER '
           +' where CD_STORE  =:P0 '
           +'   and DS_STATUS =:P1 '
           +' group by NO_RECEIPT '
           +' order by DT_ORDER desc ',
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


procedure TLetsOrderTakeOut_F.WebOrderPagerChange(Sender: TObject);
begin
  ShowOrderList;
  AllPickupButton.Visible := (WebOrderPager.ActivePage = PickupPage) and (MaxPageCount >= 1);

end;

procedure TLetsOrderTakeOut_F.WMCopyData(var Msg: TWmCopyData);
var
 vData :String;
begin
  vData := PAnsiChar(Msg.CopyDataStruct.lpData);
  if vData = 'LetsOrder' then
  begin
    if not OrderPanel.Visible then
    begin
      if (GetOption(62) = '0') and (WebOrderPager.ActivePage <> OrderPage) then
      begin
        WebOrderPager.ActivePage := OrderPage;
        ShowOrderList;
      end
      else if (GetOption(62) = '1') and (WebOrderPager.ActivePage <> CookingPage) then
      begin
        WebOrderPager.ActivePage := CookingPage;
        ShowOrderList;
      end;
    end
    else
      SetListCount;
  end;
end;

procedure TLetsOrderTakeOut_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;


//주문버튼 클릭
procedure TLetsOrderTakeOut_F.OkButtonClick(Sender: TObject);
var vIndex, vRow   :Integer;
    vTableNo, vCallNo :Integer;
    vPrintData, vStatus :String;
begin
  if MilliSecondsBetween(Now(),ClickTime) < 500 then Exit;
  ClickTime := Now;

  vIndex   := (Sender as TPosButton).Tag;
  if WebOrderPager.ActivePage = OrderPage then
  begin
    vStatus := '1';
    //픽업예정시간 기능사용
    if GetOption(192) = '2' then
    begin
      OrderPanel.Visible       := false;
      PickupPanel.Visible      := true;
      PickupPanel.Hint         := OrderList[vIndex].ReceiptNo;
      PickupTelnoLabel.Caption := OrderList[vIndex].MobielNo;
      WebOrderPager.Enabled    := false;
      AllPickupButton.Enabled  := false;
      CloseButton.Enabled      := false;
      Exit;
    end;
  end
  else if WebOrderPager.ActivePage = CookingPage then
  begin
    vStatus := '2';
    //카카오 호출
    if (OrderList[vIndex].MobielNo = '') then
    begin
      if not Common.AskBox('전화번호가 없어 호출할 수 없습니다'#13'계속하시겠습니까?') then Exit;
    end;
  end
  else if WebOrderPager.ActivePage = PickupPage then
    vStatus := '3' ;

  if vStatus = '3' then
    ExecQuery('delete from SL_LETSORDER '
             +' where CD_STORE  = :P0 '
             +'   and NO_RECEIPT =:P1 ',
             [Common.Config.StoreCode,
              OrderList[vIndex].ReceiptNo])
  else if vStatus = '2' then
    ExecQuery('update SL_LETSORDER '
             +'   set DS_STATUS = :P2, '
             +'       DT_PICKUP = Now() '
             +' where CD_STORE  = :P0 '
             +'   and NO_RECEIPT =:P1 ',
             [Common.Config.StoreCode,
              OrderList[vIndex].ReceiptNo,
              vStatus])
  else
    ExecQuery('update SL_LETSORDER '
             +'   set DS_STATUS = :P2 '
             +' where CD_STORE  = :P0 '
             +'   and NO_RECEIPT =:P1 ',
             [Common.Config.StoreCode,
              OrderList[vIndex].ReceiptNo,
              vStatus]);

  if WebOrderPager.ActivePage = CookingPage then
  begin
    if ((GetOption(192) = '1') or (GetOption(192) = '2')) and (OrderList[vIndex].MobielNo <> '') then
    begin
      OpenQuery('select NO_CALL '
               +'  from SL_SALE_H '
               +' where CD_STORE =:P0 '
               +'   and YMD_SALE =:P1 '
               +'   and NO_POS   =:P2 '
               +'   and NO_RCP   =:P3 ',
               [Common.Config.StoreCode,
                LeftStr(OrderList[vIndex].ReceiptNo,8),
                Copy(OrderList[vIndex].ReceiptNo,9,2),
                RightStr(OrderList[vIndex].ReceiptNo,4)]);

      if not Common.Query.Eof then
        vCallNo := Common.Query.FieldByName('NO_CALL').AsInteger
      else
        vCallNo := -1;
      Common.Query.Close;


      if vCallNo > 0 then
      begin
        Common.KaKaoSendMessage('L', [IntToStr(vCallNo)], GetOnlyNumber(OrderList[vIndex].MobielNo), '알림톡 호출실패');
        if (GetOption(478) = '1') and (Common.Config.BellDev = 2) then
        begin
          ExecQuery('insert into MS_ORDERNO(CD_STORE, DS_NUMBER, NO_POS, NO_ORDER, PICKUP_POS, DT_CHANGE, TEL_MOBILE)'
                   +'                 values(:P0, ''D'', ''00'', :P1, :P2, Now(), :P3)  '
                   +'ON DUPLICATE KEY UPDATE DT_CHANGE = Now() ',
                   [Common.Config.StoreCode,
                    vCallNo,
                    Common.Config.DIDPickupPos,
                    GetOnlyNumber(OrderList[vIndex].MobielNo)]);
        end;
      end;
    end;

    //확인증 출력
    if GetOption(66) = '1' then
    begin
      vPrintData:= rptAlignCenter;
      //전화번호가 있을때
      if OrderList[vIndex].MobielNo <> '' then
        vPrintData:= vPrintData+ rptSize3Times   + '전화번호'+rptLF+rptAlignCenter+ '[ '+RightStr(OrderList[vIndex].MobielNo,4)+ ' ]'+rptLF+rptLF
      else if OrderList[vIndex].TableNo > 0 then
        vPrintData:= vPrintData+ rptSize3Times   + 'TableNo -'+IntToStr(OrderList[vIndex].TableNo)+ rptLF+rptLF
      else
        vPrintData:= vPrintData+ rptSize3Times   + '주문번호'+rptLF+rptAlignCenter+ '[ '+OrderList[vIndex].OrderNo+ ' ]'+rptLF+rptLF;

      vPrintData := vPrintData + rptAlignLeft;
      vPrintData := vPrintData + rptSizeHeight;
      for vRow := 0 to OrderList[vIndex].MenuGrid.Views[0].DataController.RecordCount-1 do
      begin
        if OrderList[vIndex].MenuGrid.Views[0].DataController.Values[vRow, 0] <> '' then
        begin
          vPrintData := vPrintData + rptCharBold;
          vPrintData := vPrintData + RPadB(OrderList[vIndex].MenuGrid.Views[0].DataController.Values[vRow, 1],38,' ')+
                                     LPadB(IntToStr(OrderList[vIndex].MenuGrid.Views[0].DataController.Values[vRow, 2]),4,' ')+rptLF;
        end
        else
        begin
          vPrintData := vPrintData + rptCharNormal;
          vPrintData := vPrintData + ' '+RPadB(OrderList[vIndex].MenuGrid.Views[0].DataController.Values[vRow, 1],37,' ')+
                                     LPadB(IntToStr(OrderList[vIndex].MenuGrid.Views[0].DataController.Values[vRow, 2]),4,' ')+rptLF;
        end;
      end;
      vPrintData := vPrintData + rptLF;

      Common.Device.PrintData :=vPrintData;
      Common.Device.PrintPrinter(rptLetsOrder);
    end;
  end;
  if OrderPanel.Visible then
    OrderPanel.Visible := false;
  ShowOrderList;
end;

procedure TLetsOrderTakeOut_F.CancelButtonClick(Sender: TObject);
begin
  OrderPanel.Visible := false;
end;

procedure TLetsOrderTakeOut_F.PriorButtonClick(Sender: TObject);
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

procedure TLetsOrderTakeOut_F.PickupButtonClick(Sender: TObject);
var vIndex :Integer;
begin
  vIndex   := (Sender as TPosButton).Tag;

  if PickupButton.Caption = '재호출' then
  begin
    Common.KaKaoSendMessage('L', [OrderList[vIndex].OrderNo+'(재호출)'], GetOnlyNumber(OrderList[vIndex].MobielNo), '알림톡 호출실패');
    Exit;
  end;

  if not Common.AskBox('픽업대기 변경 하시겠습니까?') then Exit;

  ExecQuery('update SL_LETSORDER '
           +'   set DS_STATUS = ''2'' '
           +' where CD_STORE  = :P0 '
           +'   and NO_RECEIPT =:P1 ',
           [Common.Config.StoreCode,
            OrderList[vIndex].ReceiptNo]);

  OrderPanel.Visible := false;
  ShowOrderList;
end;

procedure TLetsOrderTakeOut_F.PickupCloseButtonClick(Sender: TObject);
begin
  PickupPanel.Visible     := false;
  WebOrderPager.Enabled   := true;
  AllPickupButton.Enabled := true;
  CloseButton.Enabled     := true;
end;

procedure TLetsOrderTakeOut_F.PickupNowButtonClick(Sender: TObject);
var vMessage, vReceipt, vResult :String;
    vMinute :Integer;
begin
  vMinute := (Sender as TAdvSmoothButton).Tag;
  try
    OpenQuery('select NO_CALL, '
             +'       LETSORDER_RECEIPT '
             +'  from SL_SALE_H '
             +' where CD_STORE =:P0 '
             +'   and YMD_SALE =:P1 '
             +'   and NO_POS   =:P2 '
             +'   and NO_RCP   =:P3 ',
             [Common.Config.StoreCode,
              LeftStr(PickupPanel.Hint,8),
              Copy(PickupPanel.Hint,9,2),
              RightStr(PickupPanel.Hint,4)]);
    if not Common.Query.Eof then
    begin
      if Common.Query.Fields[1].AsString = '' then
      begin
        Common.ErrBox('영수증 내용이 없습니다');
        Exit;
      end;

      vMessage := Format('고객님이 주문하신 메뉴가'#13'접수 되었습니다.'
                         +#13#13'■ 주문번호 : %s'+#13#13'■ 조리 예상 시간은'#13+'   %d분(%s) 입니다.'
                         +#13#13'메뉴가 준비되는 대로 안내해 드리겠습니다.'
                         +#13#13'이용해 주셔서 감사합니다.',
                         [Common.Query.Fields[0].AsString,
                          vMinute,
                          FormatDateTime('hh시nn분',IncMinute(Now(), vMinute))]);

      vReceipt := Common.Query.Fields[1].AsString;
      if (GetOnlyNumber(PickupTelNoLabel.Caption)='') or (Common.KaKaoSendMessage('O', [vMessage, vReceipt, PickupPanel.Hint], GetOnlyNumber(PickupTelNoLabel.Caption),'')) then
      begin
        if GetOnlyNumber(PickupTelNoLabel.Caption) <> '' then
          Common.MsgBox('픽업호출이 정상 처리되었습니다');

        ExecQuery('update SL_LETSORDER '
                 +'   set DS_STATUS = :P2, '
                 +'       DT_PICKUP = DATE_ADD(NOW(), INTERVAL :P3 MINUTE) '
                 +' where CD_STORE  = :P0 '
                 +'   and NO_RECEIPT =:P1 ',
                 [Common.Config.StoreCode,
                  PickupPanel.Hint,
                  '1',
                  vMinute]);
        ShowOrderList;
        PickupCloseButton.Click;
      end;
    end
    else
      Common.ErrBox('영수증 내용이 없습니다');
  finally
    Common.Query.Close;
  end;
end;

procedure TLetsOrderTakeOut_F.DetailButtonClick(Sender: TObject);
var vIndex   :Integer;
    vTableNo :Integer;
    vStatus :String;
    vSeq    :Integer;
begin
  vIndex   := (Sender as TPosButton).Tag;
  if WebOrderPager.ActivePage = OrderPage then
  begin
    Grid.Height := 514;
    vStatus     := '0';
    PickupButton.Caption := '픽업대기';
    PickupButton.Visible := true;
    CancelButton.Width   := 104;
  end
  else if WebOrderPager.ActivePage = CookingPage then
  begin
    Grid.Height := 514;
    vStatus     := '1';
    PickupButton.Caption := '픽업대기';
    PickupButton.Visible := true;
    CancelButton.Width   := 104;
  end
  else if WebOrderPager.ActivePage = PickupPage then
  begin
    Grid.Height := 474;
    vStatus     := '2';

    if (GetOption(83) = '1') and (OrderList[vIndex].MobielNo <> '') then
      PickupButton.Caption := '재호출'
    else
    begin
      PickupButton.Visible := false;
      CancelButton.Width   := 214;
    end;

    PickupTimeLabel.Caption    := OrderList[vIndex].PickupTime;
    if OrderList[vIndex].TableNo > 0 then
    begin
      PickTableImage.Visible     := true;
      PickupTableNoLabel.Visible := true;
      PickupTableNoLabel.Caption := IntToStr(OrderList[vIndex].TableNo);
    end
    else
    begin
      PickTableImage.Visible     := false;
      PickupTableNoLabel.Visible := false;
    end;
  end;

  if OrderList[vIndex].MobielNo = '' then
  begin
    KakaoImage.Visible    := false;
    MobileNoLabel.Visible := false;
  end
  else
  begin
    KakaoImage.Visible     := true;
    MobileNoLabel.Visible  := true;
    MobileNoLabel.Caption  := OrderList[vIndex].MobielNo;
  end;
  DetailOkButton.Caption := OrderList[vIndex].OkButton.Caption;
  OrderPanel.Caption     := OrderList[vIndex].OrderType.Caption;
  //테이블이용일때는 테이블정보 표시
  if OrderList[vIndex].TableImage.Visible then
    OrderPanel.Caption := OrderPanel.Caption + Format(' T-%d',[OrderList[vIndex].TableNo]);

  OpenQuery('select o.CD_MENU1, '
           +'       m.NM_MENU, '
           +'       o.QTY_ORDER, '
           +'       s.NM_MENU as NM_MENU_SUB '
           +'  from SL_LETSORDER as o inner join '
           +'       MS_MENU      as m on m.CD_STORE  = o.CD_STORE '
           +'                        and m.CD_MENU   = o.CD_MENU left outer join '
           +'       MS_MENU      as s on s.CD_STORE  = o.CD_STORE '
           +'                        and s.CD_MENU   = o.CD_MENU1 '
           +' where o.CD_STORE   =:P0 '
           +'   and o.NO_RECEIPT =:P1 '
           +' order by o.NO_RECEIPT desc, o.NO_GROUP, o.NO_STEP ',
           [Common.Config.StoreCode,
            OrderList[vIndex].ReceiptNo]);

  OrderPanel.Visible := true;
  GridTableView.DataController.RecordCount := 0;
  vSeq := 1;
  while not Common.Query.Eof do
  begin
    GridTableView.DataController.AppendRecord;
    if Common.Query.FieldByName('CD_MENU1').AsString = '' then
    begin
      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewSeq.Index]      := IntToStr(vSeq);
      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewMenuName.Index] := Common.Query.FieldByName('NM_MENU').AsString;
      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewQty.Index]      := Common.Query.FieldByName('QTY_ORDER').AsInteger;
      Inc(vSeq);
    end
    else
    begin
      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewSeq.Index] := '';
      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewMenuName.Index] := '-'+Common.Query.FieldByName('NM_MENU_SUB').AsString;
      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewQty.Index]      := Common.Query.FieldByName('QTY_ORDER').AsInteger;
    end;
    Common.Query.Next;
  end;
  Common.Query.Close;
end;

procedure TLetsOrderTakeOut_F.FormShow(Sender: TObject);
begin
//  WebOrderPager.ActivePageIndex := 0;
  ShowOrderList;
end;

procedure TLetsOrderTakeOut_F.GridTableViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if ARecord.Values[0] = '' then
    AStyle := StyleFontDetail;
end;

//접수 페이지 Show
end.
