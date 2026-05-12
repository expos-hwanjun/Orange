{******************************************************************************
 Table
 Temp1 : 예약번호
 Temp2 : 사용중 or ''
 Temp3 : 주문금액
 Temp4 : 포장테이블 여부
 Temp5 : Number.Font.Color
 Temp6 : 입장시간
 Temp7 : 테이블이미지여부 Y/N
 Temp8 : 테이블 주문여부 (Y-주문,N-미주문)
 Temp9 : 담당자
 ******************************************************************************}
unit Table_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, MaskUtils, ActiveX,
  Common_U, GraphicEx, ImgList, Menus, ActnList,
  cxLookAndFeels, cxControls, cxContainer, cxEdit, DateUtils,
  cxLookAndFeelPainters, cxLabel, cxButtons, cxColorComboBox,
  cxGroupBox, cxSplitter, cxImage, PNGImage, ShellAPI,
  cxGraphics, cxTextEdit, cxMaskEdit, cxDropDownEdit, dxGDIPlusClasses,
  MemDS, DBAccess, Uni, cxClasses, System.Actions, System.ImageList, PosButton,
  cxCalendar, AdvSmoothToggleButton, AdvGlassButton, AdvSysKeyboardHook,
  AdvReflectionLabel, Vcl.Buttons, AdvSmoothButton, GDIPFill, AdvGlowButton,
  AdvSmoothPanel, Winapi.MMSystem, frmshape, AdvTimePickerDropDown, dxmdaset,
  AdvPanel, shlObj, System.Threading, Vcl.AppEvnts, AdvShape;

type
  TBottonStyle = (btRect, btRound, btEllipse);
type
  TTrayIconAccess = class(TTrayIcon)
  end;

type
  TBtnSize = ^ButtonSize;
  ButtonSize = record
    Style  : TBottonStyle;
    Left   : Integer;
    Top    : Integer;
    Height : Integer;
    Width  : Integer;
    Number : Integer;
    btnStyle :Integer;
    btnType  :Integer;
    Color      : TColor;
    NumberColor : TColor;
    FontColor   : TColor;
    Group  : String[10];
    Name   : String[20];
    Packing : String[1];
    GroupIndex :Integer;
  end;

type TTableData = record
    Floor     : String;
    TableNo   : Integer;
    Seq       : Integer;
    Top       : Integer;
    Left      : Integer;
    Height    : Integer;
    Width     : Integer;
    Color     : TColor;
    NumberColor : TColor;
    FontColor   : TColor;
    BorderColor : TColor;
    BottomColor : TColor;
    GroupTable  : Integer;
    TableName   : String;
    Style       : String;
    Packing     : String;
  end;
  PTableData = ^TTableData;

type
  TTable_F = class(TForm)
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
    FloorPanel: TPanel;
    Tmr_Msg: TTimer;
    ImgPopup: TImageList;
    Action10: TAction;
    Action11: TAction;
    Action12: TAction;
    Action13: TAction;
    Action14: TAction;
    Tmr_Time: TTimer;
    Action15: TAction;
    Action16: TAction;
    Action17: TAction;
    Action18: TAction;
    Action19: TAction;
    Tmr_TableState: TTimer;
    Tmr_TableMark: TTimer;
    cxColorComboBox1: TcxColorComboBox;
    CaptionLabel: TLabel;
    CloseButton: TcxButton;
    MainPanel: TPanel;
    CashBoxOpenButton: TAdvGlassButton;
    SaleReportButton: TAdvGlassButton;
    Action20: TAction;
    MessageImage: TImage;
    FunctionPanel: TAdvSmoothPanel;
    TablePanel: TPanel;
    FunctionPanelImageCollection: TcxImageCollection;
    cxImageCollection1Item1: TcxImageCollectionItem;
    cxImageCollection1Item2: TcxImageCollectionItem;
    Action21: TAction;
    RcpManagerTimer: TTimer;
    OrderInfoButton: TAdvSmoothToggleButton;
    FunctionImageCollection: TcxImageCollection;
    FunctionImageCollectionItem1: TcxImageCollectionItem;
    FunctionImageCollectionItem2: TcxImageCollectionItem;
    FunctionImageCollectionItem3: TcxImageCollectionItem;
    FunctionImageCollectionItem4: TcxImageCollectionItem;
    FunctionImageCollectionItem5: TcxImageCollectionItem;
    FunctionImageCollectionItem6: TcxImageCollectionItem;
    FunctionImageCollectionItem7: TcxImageCollectionItem;
    FunctionImageCollectionItem8: TcxImageCollectionItem;
    FunctionImageCollectionItem9: TcxImageCollectionItem;
    FunctionImageCollectionItem10: TcxImageCollectionItem;
    FunctionImageCollectionItem11: TcxImageCollectionItem;
    FunctionImageCollectionItem12: TcxImageCollectionItem;
    FunctionImageCollectionItem13: TcxImageCollectionItem;
    FunctionImageCollectionItem14: TcxImageCollectionItem;
    FunctionImageCollectionItem15: TcxImageCollectionItem;
    FunctionImageCollectionItem16: TcxImageCollectionItem;
    FunctionImageCollectionItem17: TcxImageCollectionItem;
    FunctionImageCollectionItem18: TcxImageCollectionItem;
    FunctionImageCollectionItem19: TcxImageCollectionItem;
    FunctionImageCollectionItem20: TcxImageCollectionItem;
    FunctionImageCollectionItem21: TcxImageCollectionItem;
    FunctionPanelImageCollectionItem1: TcxImageCollectionItem;
    MsgLabel: TcxLabel;
    Action22: TAction;
    FunctionImageCollectionItem22: TcxImageCollectionItem;
    OrderMemData: TdxMemData;
    OrderMemDataNO_TABLE: TIntegerField;
    OrderMemDataAMT_ORDER: TIntegerField;
    OrderMemDataORDER_MENU: TStringField;
    OrderMemDataLAPSE_TIME: TIntegerField;
    OrderMemDataORDER_QTY: TStringField;
    OrderMemDataCOME_TIME: TStringField;
    OrderMemDataCOLOR: TStringField;
    OrderMemDataYN_USE: TStringField;
    OrderMemDataGROUP_NAME: TStringField;
    FunctionImageCollectionItem23: TcxImageCollectionItem;
    Action23: TAction;
    MessageLabel: TLabel;
    Action24: TAction;
    FunctionImageCollectionItem24: TcxImageCollectionItem;
    Action25: TAction;
    DeliveryPanel: TAdvPanel;
    FunctionImageCollectionItem25: TcxImageCollectionItem;
    DeliveryImageCollection: TcxImageCollection;
    DeliveryImageCollectionItem1: TcxImageCollectionItem;
    DeliveryImageCollectionItem2: TcxImageCollectionItem;
    DeliveryImageCollectionItem3: TcxImageCollectionItem;
    OrderMemDataYN_TABLEHOLD: TStringField;
    FunctionImageCollectionItem27: TcxImageCollectionItem;
    FunctionImageCollectionItem28: TcxImageCollectionItem;
    FunctionImageCollectionItem29: TcxImageCollectionItem;
    Action26: TAction;
    Action27: TAction;
    Action28: TAction;
    Action29: TAction;
    FunctionImageCollectionItem26: TcxImageCollectionItem;
    FunctionPanelButton: TAdvSmoothButton;
    FunctionImageCollectionItem30: TcxImageCollectionItem;
    Action30: TAction;
    Tmr_TableKey: TTimer;
    FloorUpButton: TAdvSmoothButton;
    FloorDownButton: TAdvSmoothButton;
    FunctionPanelImageCollectionItem2: TcxImageCollectionItem;
    Info2Panel: TPanel;
    Info1Panel: TPanel;
    Info1Image: TImage;
    Info1NameLabel: TLabel;
    SaleAmountLabel: TLabel;
    Info2Image: TImage;
    Info2NameLabel: TLabel;
    OrderAmountLabel: TLabel;
    TableBackgroundImage: TcxImageCollection;
    TableBackgroundImageItem1: TcxImageCollectionItem;
    TableBackgroundImageItem2: TcxImageCollectionItem;
    TableBackgroundImageItem3: TcxImageCollectionItem;
    TableBackgroundImageItem4: TcxImageCollectionItem;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure Action8Execute(Sender: TObject);
    procedure Action9Execute(Sender: TObject);
    procedure Tmr_MsgTimer(Sender: TObject);
    procedure Action10Execute(Sender: TObject);
    procedure Action12Execute(Sender: TObject);
    procedure Action13Execute(Sender: TObject);
    procedure Action14Execute(Sender: TObject);
    procedure Action15Execute(Sender: TObject);
    procedure Tmr_TimeTimer(Sender: TObject);
    procedure Action16Execute(Sender: TObject);
    procedure Action18Execute(Sender: TObject);
    procedure cxColorComboBox1PropertiesCloseUp(Sender: TObject);
    procedure cxColorComboBox1PropertiesChange(Sender: TObject);
    procedure Action19Execute(Sender: TObject);
    procedure Tmr_TableStateTimer(Sender: TObject);
    procedure Tmr_TableMarkTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FloorUpButtonClick(Sender: TObject);
    procedure SaleReportButtonClick(Sender: TObject);
    procedure CashBoxOpenButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure Action11Execute(Sender: TObject);
    procedure Action20Execute(Sender: TObject);
    procedure ShowPanelImageClick(Sender: TObject);
    procedure FunctionPanelButtonClick(Sender: TObject);
    procedure Action21Execute(Sender: TObject);
    procedure RcpManagerTimerTimer(Sender: TObject);
    procedure Action22Execute(Sender: TObject);
    procedure Action23Execute(Sender: TObject);
    procedure Action24Execute(Sender: TObject);
    procedure Action17Execute(Sender: TObject);
    procedure Action25Execute(Sender: TObject);
    procedure Action26Execute(Sender: TObject);
    procedure Action27Execute(Sender: TObject);
    procedure Action28Execute(Sender: TObject);
    procedure Action29Execute(Sender: TObject);
    procedure Action30Execute(Sender: TObject);
    procedure Tmr_TableKeyTimer(Sender: TObject);
  private
    FloorButton   : array of TAdvSmoothButton;
    ClickTime :TDateTime;
    ClickObject :TObject;
    TableKeyFloorButton :TAdvSmoothButton;
    TableKeyButton : TPosButton;
    TableData         :TList;

    NormalColor,
    NormalBorderColor,
    NormalFontColor,
    OldColor           : TColor;
    BorderColor        : TColor;
    FTableMode         : TTableMode;
    FTableMark         : Boolean;
    BtnSize            : TBtnSize;
    FloorMaxCount,
    FloorButtonCount,
    FloorPageCount,
    FFloorPage,                                   //층 페이지번호
    FTablePageCount :Integer;
    FTempButton :TPosButton;                     //층바뀌고 처음실행인지
    MarkTableData : Array of Array of String;      //깜박이는 테이블정보
    LetsOrderButtonIndex,
    LetsOrderCallButtonIndex :Integer;
    WaitOrderTableNo :Integer;                     //대기중 주문테이블

    FIsWorking :Boolean;
    FErrCnt :Integer;    //SetOrderInfo 프로시져를 수행중 에러 횟수
    FIsFormShow :Boolean;

    isTableImage,
    isTableRefresh :Boolean;                       //테이블 리플래쉬
    FloorColor :TColor;
    FloorButtonHeight,
    FloorWidth : Integer;
    FloorFont  :TFont;
    FunctionButtonHeight :Integer;
    isOrderInfoWorking :Boolean;                          //SetOrderInfo 작업중여부
    procedure TableCreate;                         //테이블생성
    procedure TableButtonClick(Sender :TObject);   //테이블 클릭이벤트
    procedure TableImageButtonClick(Sender :TObject);   //테이블 이미지클릭이벤트
    procedure TableModeApply;                      //TableMode 적용
    function  CheckOrderTable:Boolean;
    procedure SetTableGroupColor;
    procedure SetFloorPage(AValue :Integer);
    procedure SetTableMode(AValue:TTableMode);
    procedure SetTableMark(aValue:Boolean);
    property  FloorPage :Integer          read FFloorPage       write SetFloorPage;
    property  TableMode       :TTableMode read FTableMode       write SetTableMode;
    property  TableMark       :Boolean    read FTableMark       write SetTableMark;
    procedure WMCopyData(var Msg:TWmCopyData); message WM_CopyData;
    procedure CidReadEvent(const S : String);
    procedure FunctionButtonCreate;
    procedure FunctionButtonClick(Sender: TObject);
    procedure FloorButtonCreate;
    procedure SetFloorButton;
    procedure FloorButtonClick(Sender: TObject);
    function  AHeadCheck(aTableNo:Integer):Boolean;
    function  GetFloorIndex(aCode:String):Integer;
    procedure ExecOrderInfo;
    procedure DeliveryButtonClick(Sender:TObject);
    procedure TableKeyReadEvent(const S: String);
    procedure FreeTableDataList(AList: TList);
  protected
    FunctionButton: array of TAdvSmoothButton;
  public
    FCidData :String;
    FromTable,
    ToTable : TTable;                              //작업 테이블
    CardMsg  :String;
    TrayIconIdentifier: TNotifyIconIdentifier;
    procedure SetOrderInfo(aMust:Boolean=false);                        //주문정보 셋팅
    procedure SetTableVisible;                     //TableMode에 따라 테이블 보이고 안보이고
    procedure SetLetsOrderHotImage;
  end;

var
  Table_F: TTable_F;
implementation

uses Order_U, DBModule_U, GlobalFunc_U, RePrint_U, Booking_U, MenuMove_U,
    Work_U, CashBook_U, RcpChange_U, DualOrder_U,
    Main_U, Delivery_U, CustomerInfo_U,
    BookingInput_U, SaleReport_U, StrUtils, DutchPay_U, Math,
    MenuAdd_U, Const_U, DeliveryNew_U, Wait_U, LetsOrderTakeOut_U, AHeadPay_U,
    Tablet_U, LetsOrderCallList_U, OrderHistory_U, ToDaySaleQty_U;

{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';
// 데몬으로부터 메세지를 받는다 (신용카드 데이터)//
procedure TTable_F.WMCopyData(var Msg:TWmCopyData);
var
 vData  :AnsiString;
 vTableNo :Integer;
 vCount, vIndex, vKitchen   :Integer;
 vPrintData :String;
Begin
  try
    SetString(vData, PAnsiChar(Msg.CopyDataStruct.lpData), Msg.CopyDataStruct.cbData);
    {받은데이터가 테이블 주문정보이면}
    if (LeftStr(vData,5) = 'ORDER') and (not Common.Config.IsTakeOut) then
    begin
      if FIsWorking then Exit;
      if Assigned(OrderHistory_F)  and OrderHistory_F.Showing then
      begin
        OrderHistory_F.SelectOrderMenu;
        Exit;
      end;
      if not Self.Showing then Exit;
      SetOrderInfo(true);
    end
    else if (LeftStr(vData,9) = 'LetsOrder') then
    begin
      vData := Replace(vData, #0, '');
      if vData = 'LetsOrderTakeOut' then
      begin
        if LetsOrderButtonIndex >= 0 then
        begin
          FunctionButton[LetsOrderButtonIndex].Status.Visible := true;
          FunctionButton[LetsOrderButtonIndex].Status.Caption := '주문';
        end;
        Exit;
      end;
      if FIsWorking then Exit;
      if not Self.Showing then Exit;
      if (TableMode <> tbmNone) then Exit;

      SetOrderInfo(true);

      vCount := CharCnt(vData,'|');
      SetLength(MarkTableData, vCount, 5);
      for vCount := 0 to vCount-1 do
      begin
        MarkTableData[vCount,0] := GetOnlyNumber(CopyPos(vData,'|',vCount+1));
        MarkTableData[vCount,1] := FormatDateTime('yyyy-mm-dd hh:nn:ss:000', IncSecond(Now(), 10));
        MarkTableData[vCount,2] := 'LETSORDER';
      end;
      TableMark := true;
    end
    else if (LeftStr(vData,7) <> 'ORDER'+Common.Config.PosNo) then
    begin
      Common.Device.PrintData := HexToString(vData);
      Common.Device.PrintPrinter;
    end;
  except
  end;
end;

{------------------------------------------------------------------------------}
{ 폼생성                                                                       }
{ 주문폼을 생성 시킨다                                                         }
{------------------------------------------------------------------------------}
procedure TTable_F.FormCreate(Sender: TObject);
begin
  ClientWidth   := Common.Config.PosWidth;
  ClientHeight  := Common.Config.PosHeight;
  Self.DoubleBuffered       := true;
  TablePanel.DoubleBuffered := true;
  OnShow := FormShow;
  isTableRefresh := true;
  //데몬에서 포스번호별로 메세지를 받기 위함
  Self.Caption := 'TableForm'+Common.Config.PosNo;

  CaptionLabel.Caption := Common.Config.StoreName;
  MessageImage.Top          := Self.Height - 41;
  MessageLabel.Top          := Self.Height - 41;
  FunctionPanelButton.Top   := Self.Height - 47;

  TableData := TList.Create;
  Common.SetButtonColor(CashBoxOpenButton);
  Common.SetButtonColor(SaleReportButton);
  Common.SetButtonColor(FunctionPanelButton);
  if GetOption(58) = '1' then
  begin
    MessageImage.Left         := 6;
    MessageLabel.Left         := 175;
  end;

  //포스 타입별로 상단을 다르게 설정
  case Common.PosType of
    ptAccount,
    ptNotAccount :
    begin
      Info1Panel.Visible       := StoI(GetOption(13)) = 0;
      Info2Panel.Visible       := StoI(GetOption(13)) in [0,1];
      SaleReportButton.Visible := StoI(GetOption(13)) in [0,1];
    end;
    ptOnlyOrder  :
    begin
      Info1Panel.Visible       := StoI(GetOption(170)) = 0;
      Info2Panel.Visible       := StoI(GetOption(170)) in [0,1];
      SaleReportButton.Visible := StoI(GetOption(170)) in [0,1];
    end;
  end;

  if not Info1Panel.Visible then
    Info1Panel.Height := 0;

  if not Info2Panel.Visible then
    Info2Panel.Height := 0;

  FTempButton := TPosButton.Create(self);
  Common.IsWorking := False;
  Common.OrderKind := okNone;
  CardMsg          := '';

  isTableImage := false;
  if (GetOption(499) <> '0') then
  begin
    isTableImage := true;
    with TImage.Create(nil) do
    begin
      Parent := TablePanel;
      if FileExists(Common.AppPath+'dll\table_back.jpg') then
        Picture.LoadFromFile(Common.AppPath+'dll\table_back.jpg')
      else
        Picture.Assign(TableBackgroundImage.Items.Items[StrToInt(GetOption(499))-1].Picture.Graphic);
      Align := alClient;
      Stretch := true;
    end;
  end;

  LetsOrderButtonIndex     := -1;
  LetsOrderCallButtonIndex := -1;
  FunctionButtonCreate;
  FloorButtonCreate;

  if (GetOption(58) = '1') and not Common.Config.IsKiosk then
    MainPanel.Color        := Common.FloorData[0].BackGroundColor;

  FIsWorking := False;
  FErrCnt     := 0;
  FCidData    := '';
  FIsFormShow := False;
end;
{------------------------------------------------------------------------------}
{ 폼 Show                                                                      }
{------------------------------------------------------------------------------}
procedure TTable_F.FormShow(Sender: TObject);
  procedure SetDBPosDateTime(aData:String);
  var
    vYear, vMonth, vDay, vHour, vMinute, vSecond, vMilliSecond: Word;
    vCurTime: TDateTime;
    vSystemTime: TSystemTime;
    vTimeZoneInfo: TTimeZoneInformation;
  begin
    vYear  := StrToInt( Copy(aData,1,4) );
    vMonth := StrToInt( Copy(aData,5,2) );
    vDay   := StrToInt( Copy(aData,7,2) );
    vHour  := StrToInt( Copy(aData,9,2) );
    vMinute:= StrToInt( Copy(aData,11,2) );
    vSecond:= StrToInt( Copy(aData,13,2) );
    vMilliSecond :=0 ;

    vCurTime  := EncodeDateTime(vYear, vMonth, vDay, vHour, vMinute, vSecond, vMilliSecond);
    GetTimeZoneInformation(vTimeZoneInfo);
    DateTimeToSystemTime(vCurTime + vTimeZoneInfo.Bias / 1440, vSystemTime);
    SetSystemTime(vSystemTime);
  end;
var vIndex :Integer;
    vFloorIndex :Integer;
    vTableData : ^TTableData;
begin
  ClickTime   := IncSecond(Now,-3);
  ClickObject := nil;

  if not Common.IsDBServer then
  begin
    OpenQuery('select Now() ',[]);
    SetDBPosDateTime(FormatDateTime('yyyymmddhhnnss',Common.Query.Fields[0].AsDateTime));
  end;

  if GetFloorIndex(Common.Config.DefaultFloor) = -1 then
    Common.Config.DefaultFloor := Common.FloorData[0].Code;

  vFloorIndex := 0;
  for vIndex := Low(FloorButton) to High(FloorButton) do
  begin
    if Common.FloorData[vIndex].Code = Common.Config.DefaultFloor then
    begin
      vFloorIndex := vIndex;
      Break;
    end;
  end;
  ExecQuery('delete '
           +'  from MS_UPLOAD '
           +' where CD_STORE =:P0 '
           +'   and NM_TABLE =''SL_ORDER_H'' ',
           [Common.Config.StoreCode]);

  ExecQuery('insert into MS_UPLOAD(CD_STORE, '
           +'                      NM_TABLE, '
           +'                      YMD_SALE, '
           +'                      PK, '           //ALL
           +'                      DS_STATUS, '    //A
           +'                      DT_INSERT) '
           +'              values (:P0, '
           +'                     ''SL_ORDER_H'', '
           +'                      Date_Format(NOW(), ''%Y%m%d''), '
           +'                      :P1, '
           +'                      ''A'', '
           +'                      NOW()) '
           +' ON DUPLICATE KEY UPDATE DT_INSERT = NOW()',
           [Common.Config.StoreCode,
            'ALL']);
  Common.TRSendMessage;

  FIsFormShow := True;
  try
    OpenQuery('select CD_FLOOR, '
             +'       SEQ, '
             +'       NO_TOP, '
             +'       NO_LEFT, '
             +'       NO_HEIGHT, '
             +'       NO_WIDTH, '
             +'       NO_TABLE, '
             +'       COLOR, '
             +'       NUMBER_COLOR, '
             +'       FONT_COLOR, '
             +'       BORDER_COLOR, '
             +'       NO_TABLE_GROUP, '
             +'       NM_TABLE, '
             +'       DT_CHANGE, '
             +'       TABLE_STYLE, '
             +'       YN_PACKING, '
             +'       BOTTOM_COLOR, '
             +'       CHAIR_COUNT '
             +'  from MS_TABLE   '
             +' where CD_STORE =:P0 '
             +' order by NO_TABLE ',
             [Common.Config.StoreCode]);

    FreeTableDataList(TableData);
    while not Common.Query.Eof do
    begin
      New(vTableData);
      vTableData^.Floor         := Common.Query.FieldByName('CD_FLOOR').AsString;
      vTableData^.TableNo       := Common.Query.FieldByName('NO_TABLE').AsInteger;
      vTableData^.Seq           := Common.Query.FieldByName('SEQ').AsInteger;
      vTableData^.Top           := Common.Query.FieldByName('NO_TOP').AsInteger;
      vTableData^.Left          := Common.Query.FieldByName('NO_LEFT').AsInteger;
      vTableData^.Height        := Common.Query.FieldByName('NO_HEIGHT').AsInteger;
      vTableData^.Width         := Common.Query.FieldByName('NO_WIDTH').AsInteger;
      vTableData^.Color         := StringToColorDef(Common.Query.FieldByName('COLOR').AsString, NormalColor);
      vTableData^.NumberColor   := StringToColorDef(Common.Query.FieldByName('NUMBER_COLOR').AsString, clWhite);
      vTableData^.FontColor     := StringToColorDef(Common.Query.FieldByName('FONT_COLOR').AsString, clWhite);
      vTableData^.BorderColor   := StringToColorDef(Common.Query.FieldByName('BORDER_COLOR').AsString, clNone);
      vTableData^.BottomColor   := StringToColorDef(Common.Query.FieldByName('BOTTOM_COLOR').AsString, StringToColor(Common.FloorData[vFloorIndex].BottomFontColor));
      vTableData^.GroupTable    := Common.Query.FieldByName('NO_TABLE_GROUP').AsInteger;
      vTableData^.TableName     := Common.Query.FieldByName('NM_TABLE').AsString;
      vTableData^.Style         := Common.Query.FieldByName('TABLE_STYLE').AsString;
      vTableData^.Packing       := Common.Query.FieldByName('YN_PACKING').AsString;
      TableData.Add(vTableData);
      Common.Query.Next;
    end;
  finally
    Common.Query.Close;
  end;

  TableCreate;
  Application.ProcessMessages;
  SetOrderInfo(true);
  Screen.Cursor := crDefault;
  TableMode     := tbmNone;

  FloorPanel.Enabled := not Common.Config.IsFloorFix;

  Common.SetLanguage(Self);
  FunctionPanelButton.Caption := Common.GetPaPago(FunctionPanelButton.Caption);

  if High(FloorButton) > 0 then
    FloorButtonClick(FloorButton[vFloorIndex])
  else
    FloorButtonClick(TAdvSmoothButton(FindComponent('Floor0Button')));

  if Common.Config.Cid_Port > 0 then
    Common.Device.OnCidReadData :=CidReadEvent;

  if Common.Config.TableKeyPort > 0 then
    Common.Device.OnTableKeyReadData :=TableKeyReadEvent;

  Order_F := TOrder_F.Create(Self);

  //예약테이블 작업
  if Tag = 1 then
    TableMode := tbmBooking;
end;

procedure TTable_F.FreeTableDataList(AList: TList);
var
  I: Integer;
begin
  for I := 0 to AList.Count - 1 do
    Dispose(PTableData(AList[I]));
  AList.Clear;
end;

procedure TTable_F.FunctionButtonClick(Sender: TObject);
var vIndex :Integer;
    vAction :String;
begin
  if (MilliSecondsBetween(Now(),ClickTime) < 500) and (ClickObject = Sender) then Exit;
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

procedure TTable_F.FunctionButtonCreate;
var I, vButtonCount, vCol, vLeft :Integer;
    vIndex :Integer;
    vTop, vWidth, vHeidth, vPanelHeight, vGap :Integer;
    vButtonColor, vRound :TColor;
    vButtonFont  :TFont;
    vIConDisplay :String;
    vBottomMode, vShadow  :Boolean;
begin
  vButtonFont := TFont.Create;
  FloorFont   := TFont.Create;
  try
    //버튼 설정
    OpenQuery('select * '
             +'  from MS_CODE '
             +' where CD_STORE = :P0 '
             +'   and CD_KIND  = :P1 '
             +'   and CD_CODE  = ''300'' ',
             [Common.Config.StoreCode,
              Common.Config.DesignCode]);
    if not Common.Query.Eof then
    begin
      vButtonColor        := StringToColor(Common.Query.FieldByName('NM_CODE2').AsString);
      vButtonCount        := StrToIntDef(Common.Query.FieldByName('NM_CODE1').AsString,5);
      vButtonFont.Name    := Common.Query.FieldByName('NM_CODE3').AsString;
      vButtonFont.Size    := StrToIntDef(Common.Query.FieldByName('NM_CODE4').AsString,11);
      if Common.Query.FieldByName('NM_CODE5').AsString = '1' then
        vButtonFont.Style := [fsBold];
      vButtonFont.Color   := StringToColor(Common.Query.FieldByName('NM_CODE6').AsString);
      vIConDisplay        := Common.Query.FieldByName('NM_CODE7').AsString;
      FunctionButtonHeight := StrToIntDef(Common.Query.FieldByName('NM_CODE8').AsString,0);
      FloorButtonHeight   := StrToIntDef(Common.Query.FieldByName('NM_CODE9').AsString,72);
      FloorWidth          := StrToIntDef(Common.Query.FieldByName('NM_CODE10').AsString,124);
      FloorColor          := StringToColorDef(Common.Query.FieldByName('NM_CODE11').AsString, clBlue);
      FloorFont.Name      := Common.Query.FieldByName('NM_CODE12').AsString;
      FloorFont.Size      := StrToIntDef(Common.Query.FieldByName('NM_CODE13').AsString,11);
      if Common.Query.FieldByName('NM_CODE14').AsString = '1' then
        FloorFont.Style := [fsBold];
      FloorFont.Color     := StringToColor(Common.Query.FieldByName('NM_CODE15').AsString);
      vBottomMode         := Common.Query.FieldByName('NM_CODE17').AsString = '1';
      BorderColor         := StringToColorDef(Common.Query.FieldByName('NM_CODE18').AsString, clBlack);
      vRound              := StrToIntDef(Common.Query.FieldByName('NM_CODE19').AsString, 0);
      vShadow             := Common.Query.FieldByName('NM_CODE20').AsString = 'Y';
    end
    else
    begin
      Common.LogoCreate(Self,2);
      Exit;
    end;

    if vBottomMode and (FunctionButtonHeight = 0) then
      FunctionButtonHeight := 65;

    FunctionPanel.Width  := FloorWidth;

    //층을 사용하지 않습니다.

    MainPanel.Width  := Self.Width  - 10;
    MainPanel.Height := Self.Height - MainPanel.Top - 5;
    MainPanel.Left   :=  5;
    //층을 사용하면서 하단에 기능버튼 표시
    if (GetOption(58) = '0') and vBottomMode then
      FloorPanel.Height  := MainPanel.Height - 90  - FunctionButtonHeight - OrderInfoButton.Height
    else
      FloorPanel.Height    := Self.Height - Info2Panel.Height - 57;

    SetLength(FunctionButton, vButtonCount);

    //층을사용하지 않으면서 기능버튼 하단
    if (GetOption(58) = '1') then
    begin
      OrderInfoButton.Tag    := 1;
      OrderInfoButton.Left   := 550;
      OrderInfoButton.Top    := 3;
      OrderInfoButton.Width  := 287;
      CaptionLabel.Width     := 670;
      FloorPanel.Top         := MainPanel.Top;
      FloorPanel.Height      := MainPanel.Height+5;
    end;

    //기능버튼을 하단에 표시할때
    if vBottomMode then
    begin
      if vButtonCount > 0 then
      begin
        Common.LogoCreate(Self,1);
        FunctionPanel.Visible := false;
        FunctionPanel.Height := FunctionButtonHeight;
        if vShadow then
          vWidth := (Self.Width - 15) div vButtonCount
        else
          vWidth := (Self.Width - 10) div vButtonCount - 3;

        vLeft  := 5;
        for vIndex := Low(FunctionButton) to High(FunctionButton) do
        begin
          FunctionButton[vIndex] := TAdvSmoothButton.Create(Self);
          with FunctionButton[vIndex] do
          begin
            Name             := 'FunctionButton'+IntToStr(vIndex);
            Parent           := TablePanel;
            Caption          := EmptyStr;
            Top              := TablePanel.Height-15;
            Width            := vWidth;
            Color            := vButtonColor;
            BevelColor       := BorderColor;
            Appearance.Font  := vButtonFont;
            Appearance.SimpleLayout       := true;
            Appearance.SimpleLayoutBorder := true;
            Appearance.Rounding           := vRound;
            Appearance.PictureAlignment := taCenter;
            Height           := FunctionButtonHeight;
            Left             := vLeft;
            vLeft            := Left + vWidth + Ifthen(vShadow,0,3);
            Shadow           := vShadow;
            Tag              := vIndex-1;
          end;
        end;
      end
      else
      begin
        Common.LogoCreate(Self,2);

        FloorPanel.Visible          := false;
        FunctionPanel.Visible       := false;
        FunctionPanelButton.Visible := false;
      end;

      //층사용하지 않을때
      if GetOption(58) = '1' then
      begin
        FloorPanel.Visible          := false;
        FunctionPanelButton.Visible := false;
        MainPanel.Width             := Self.Width  - 10;
      end;
      FunctionPanelButton.Visible := false;
      MessageImage.Left  := 8;
      MessageLabel.Left  := MessageImage.Left + MessageImage.Width;
    end
    else
    begin
      Common.LogoCreate(Self,2);

      //층을 사용하지 않으면 층버튼 위치에 기능키
      if GetOption(58) = '1' then
      begin
        //기능버튼이 없을때
        if vButtonCount > 0 then
        begin
          FunctionPanel.Visible       := false;
          FunctionPanelButton.Visible := false;

          vWidth  := FloorWidth-2;
          if FunctionButtonHeight = 0 then
            vHeidth := (FloorPanel.Height - Info1Panel.Height - Info2Panel.Height)  div vButtonCount - 2
          else
            vHeidth := FunctionButtonHeight;
          vTop    := 5;
          FloorPanel.Visible := false;
          for vIndex := Low(FunctionButton) to High(FunctionButton) do
          begin
            FunctionButton[vIndex] := TAdvSmoothButton.Create(Self);
            with FunctionButton[vIndex] do
            begin
              Name                          := 'FunctionButton'+IntToStr(vIndex);
              Parent                        := TablePanel;
              Caption                       := EmptyStr;
              Top                           := vTop + (vIndex * vHeidth) + vIndex;
              Width                         := vWidth;
              Color                         := vButtonColor;
              BevelColor                    := BorderColor;
              Appearance.Font               := vButtonFont;
              Appearance.SimpleLayout       := true;
              Appearance.SimpleLayoutBorder := true;
              Appearance.Rounding           := vRound;
              Appearance.PictureAlignment   := taCenter;
              Height                        := vHeidth;
              Left                          := Self.Width - vWidth - 11;
              Shadow                        := vShadow;
              Tag                           := vIndex-1;
            end;
          end;
        end
        else
        begin
          FunctionPanel.Visible       := false;
          FunctionPanelButton.Visible := false;
          MainPanel.Width             := Self.Width  - 15;
        end;
        MessageImage.Left  := 8;
        MessageLabel.Left  := MessageImage.Left + MessageImage.Width;
      end
      else
      begin
        FunctionPanel.Visible := false;
        if vButtonCount > 0 then
        begin
          vWidth  := FloorWidth-Ifthen(vShadow,0,5);
          vHeidth := FunctionPanel.Height div vButtonCount - Ifthen(vShadow,1,3);

          for vIndex := Low(FunctionButton) to High(FunctionButton) do
          begin
            FunctionButton[vIndex] := TAdvSmoothButton.Create(Self);
            with FunctionButton[vIndex] do
            begin
              Name             := 'FunctionButton'+IntToStr(vIndex);
              Parent           := FunctionPanel;
              Caption          := EmptyStr;
              Top              := (vIndex * vHeidth) + 3 + Ifthen(vShadow,0,vIndex*2) ;
              Width            := vWidth;
              Color            := vButtonColor;
              BevelColor       := BorderColor;
              Appearance.Font             := vButtonFont;
              Appearance.SimpleLayout := true;
              Appearance.SimpleLayoutBorder := true;
              Appearance.Rounding           := vRound;
              Appearance.PictureAlignment := taCenter;
              Height           := vHeidth;
              Left             := 3;
              Shadow           := vShadow;
              Tag              := vIndex-1;
            end;
          end;
        end
        else
        begin
          FloorPanel.Visible          := false;
          FunctionPanel.Visible       := false;
          FunctionPanelButton.Visible := false;
          MainPanel.Width             := Self.Width  - 15;
        end;
      end;
    end;

    // 버튼 기능 연결
    if Assigned(FunctionButton) and (Length(FunctionButton) > 0) then
    begin
      OpenQuery('select NM_CODE1, '
               +'       NM_CODE3, '
               +'       NM_CODE4, '
               +'       NM_CODE6, '
               +'       NM_CODE7, '
               +'       NM_CODE8 '
               +'  from MS_CODE  '
               +' where CD_STORE = :P0 '
               +'   and CD_KIND  = :P1 '
               +'   and CD_CODE  between ''301'' and ''399'' '
               +' order by CD_CODE '
               +' limit :P2 ',
               [Common.Config.StoreCode,
                Common.Config.DesignCode,
                vButtonCount]);
      while not Common.Query.Eof do
      begin
        vCol := StoI(Common.Query.FieldByName('NM_CODE7').AsString);
        if Assigned(FunctionButton[vCol]) then
        begin
          if Common.Query.FieldByName('NM_CODE1').AsString = '' then Continue;
          FunctionButton[vCol].Caption           := LineFeed(Common.Query.FieldByName('NM_CODE3').AsString);
          FunctionButton[vCol].Caption           := Common.GetPaPago(FunctionButton[vCol].Caption);
          FunctionButton[vCol].Color         := StringToColor(Common.Query.FieldByName('NM_CODE4').AsString);
          FunctionButton[vCol].Cursor            := crHandPoint;
          if Common.Query.FieldByName('NM_CODE6').AsString = '1' then
            FunctionButton[vCol].Appearance.Font.Style := [fsBold];

          if StoI(Common.Query.FieldByName('NM_CODE8').AsString) >= 5 then
            FunctionButton[vCol].Appearance.Font.Size    := Common.Query.FieldByName('NM_CODE8').AsInteger;

          FunctionButton[vCol].Hint := Common.Query.FieldByName('NM_CODE1').AsString;
          if vIConDisplay <> '0' then
          begin
            if FunctionImageCollection.Items.Count > StoI(Common.Query.FieldByName('NM_CODE1').AsString) then
            begin
              FunctionButton[vCol].Picture.Assign(FunctionImageCollection.Items[StoI(Common.Query.FieldByName('NM_CODE1').AsString)].Picture);
              //렛츠오더 버튼은 index를 알아논다
              if Common.Query.FieldByName('NM_CODE1').AsString = '19' then
                LetsOrderButtonIndex := vCol
              else if Common.Query.FieldByName('NM_CODE1').AsString = '22' then    //호출내역
                LetsOrderCallButtonIndex := vCol;
            end;
          end;

          if vIConDisplay = '1' then
            FunctionButton[vCol].Appearance.Layout  := blPictureLeft
          else
            FunctionButton[vCol].Appearance.Layout  := blPictureTop;

          FunctionButton[vCol].OnClick := FunctionButtonClick;
        end;
        Common.Query.Next;
      end;
    end;
  finally
    FreeAndNil(vButtonFont);
  end;
end;

procedure TTable_F.FunctionPanelButtonClick(Sender: TObject);
var vIndex :Integer;
begin
  if true then //isTableImage then
  begin
    if not FunctionPanel.Visible then
    begin
      FunctionPanel.Visible := True;
      FunctionPanelButton.Caption := Common.GetPaPago('숨기기');
      FunctionPanelButton.Picture.Assign(FunctionPanelImageCollection.Items[1].Picture.Graphic);
      for vIndex := Low(FloorButton) to High(FloorButton) do
        FloorButton[vIndex].Visible := false;

      if OrderInfoButton.Top <> 3 then
        OrderInfoButton.Visible := false;

      Info1Panel.Visible := false;
      Info2Panel.Visible := false;
    end
    else
    begin
      FunctionPanel.Visible := false;
      FunctionPanelButton.Caption := Common.GetPaPago('기능키');
      FunctionPanelButton.Picture.Assign(FunctionPanelImageCollection.Items[0].Picture.Graphic);
      for vIndex := Low(FloorButton) to High(FloorButton) do
      begin
        if FloorButton[vIndex].Caption <> '' then
          FloorButton[vIndex].Visible := true;
      end;

      if OrderInfoButton.Top <> 3 then
        OrderInfoButton.Visible := true;
      Info1Panel.Visible := true;
      Info2Panel.Visible := true;
    end;

  end
  else
  begin
    if not FunctionPanel.Visible then
    begin
      FunctionPanel.Visible := True;
      FunctionPanelButton.Caption := Common.GetPaPago('숨기기');
      FunctionPanelButton.Picture.Assign(FunctionPanelImageCollection.Items[1].Picture.Graphic);
      FloorPanel.Visible  := false;
      MainPanel.Width     := MainPanel.Width + FloorPanel.Width;
      if OrderInfoButton.Top <> 3 then
        OrderInfoButton.Visible := false;
    end
    else
    begin
      FunctionPanel.Visible := false;
      FunctionPanelButton.Caption := Common.GetPaPago('기능키');
      FunctionPanelButton.Picture.Assign(FunctionPanelImageCollection.Items[0].Picture.Graphic);
      FloorPanel.Visible  := true;
      MainPanel.Width     := MainPanel.Width - FloorPanel.Width;
      if OrderInfoButton.Top <> 3 then
        OrderInfoButton.Visible := true;
    end;
  end;
end;

function TTable_F.GetFloorIndex(aCode: String): Integer;
var vIndex :Integer;
begin
  Result := -1;
  for vIndex :=0 to High(Common.FloorData) do
  begin
    if Common.FloorData[vIndex].Code = aCode then
    begin
      Result := vIndex;
      Break;
    end;
  end;
end;

procedure TTable_F.RcpManagerTimerTimer(Sender: TObject);
var vOption10 : Char;
begin
  RcpManagerTimer.Enabled := false;
  RcpChange_F := TRcpChange_F.Create(Self);
  try
    vOption10 := Common.Config.Options[10];
    Order_F := TOrder_F.Create(Self);

    RcpChange_F.ShowMode := fsmNone;
    RcpChange_F.ShowModal;
  finally
    Common.Config.Options[10] := vOption10;
    FreeAndNil(RcpChange_F);
    if Assigned(Order_F) then
      FreeAndNil(Order_F);

    Action14.Execute;
  end;
end;

procedure TTable_F.FormDestroy(Sender: TObject);
begin
//  FreeTableDataList(TableData);
  FreeAndNil(FloorFont);
  TableData.Free;
  SetLength(FloorButton,0);
  try
    if Assigned(Order_F) then
      FreeAndNil(Order_F);
  except
  end;
end;

{------------------------------------------------------------------------------}
{ 층정보 셋팅                                                                  }
{------------------------------------------------------------------------------}
procedure TTable_F.SaleReportButtonClick(Sender: TObject);
var vTemp :String;
begin
  if Common.PosType = ptOnlyOrder then
    if not Common.CheckAcctPos(1) then Exit;

  if Common.Config.ReportPwd <> '' then
  begin
    vTemp := Common.ShowNumberForm('패스워드를 입력하세요', 16);
    if vTemp = 'mrClose' then Exit;

    if Common.Config.ReportPwd <> vTemp then
    begin
      Common.ErrBox('패스워드가 올바르지 않습니다');
      Exit;
    end;
  end;

  SaleReport_F := TSaleReport_F.Create(Application);
  try
    SaleReport_F.ShowModal;
  finally
    FreeAndNil(SaleReport_F);
  end;
end;

procedure TTable_F.SetFloorButton;
var vIndex :Integer;
    vBtton :TAdvSmoothButton;
    vFirst :Boolean;
begin
  vFirst :=true;
  For vIndex := 0 to FloorButtonCount-1 do
  begin
    TAdvSmoothButton(FindComponent(Format('Floor%dButton',[vIndex]))).Hint    := '';
    TAdvSmoothButton(FindComponent(Format('Floor%dButton',[vIndex]))).Caption := '';
    TAdvSmoothButton(FindComponent(Format('Floor%dButton',[vIndex]))).Visible := false;
  end;

  For vIndex := 0  to FloorButtonCount-1 do
  begin
    if ( ((FloorPage-1)*FloorButtonCount) + vIndex ) >= FloorMaxCount then Continue;
    if vFirst then
    begin
      vBtton := TAdvSmoothButton(FindComponent(Format('Floor%dButton',[vIndex])));
      vFirst := false;
    end;

    TAdvSmoothButton(FindComponent(Format('Floor%dButton',[vIndex]))).Hint    := Common.FloorData[((FloorPage-1)*FloorButtonCount)+vIndex].Code;
    TAdvSmoothButton(FindComponent(Format('Floor%dButton',[vIndex]))).Caption := Common.FloorData[((FloorPage-1)*FloorButtonCount)+vIndex].Name;
    TAdvSmoothButton(FindComponent(Format('Floor%dButton',[vIndex]))).Status.Caption := Common.FloorData[((FloorPage-1)*FloorButtonCount)+vIndex].Name;
    if (GetOption(58) = '0') and ((Pos('000',Common.Config.AvailFloor) > 0) or (Pos(Common.FloorData[((FloorPage-1)*FloorButtonCount)+vIndex].Code, Common.Config.AvailFloor) > 0))  then
      TAdvSmoothButton(FindComponent(Format('Floor%dButton',[vIndex]))).Visible := True;

  end;

  //바뀐 페이지에 선택된 테이블이 있는지 체크한다
  FloorButtonClick(vBtton);
end;

{------------------------------------------------------------------------------}
{ 테이블 버튼 DB에서 불러와서 생성                                             }
{------------------------------------------------------------------------------}
procedure TTable_F.TableCreate;
  procedure TableButtonDelete;
  var vIndex :Integer;
  label go;
  begin
    go:
    For vIndex := 0 to ComponentCount-1 do
    begin
      if (Components[vIndex] is TPosButton) and
         ( (Components[vIndex] as TPosButton).Parent = TablePanel )  then
      begin
        (Components[vIndex] as TPosButton).Free;
        Goto go;
      end;

      if (Components[vIndex] is TAdvSmoothButton) and
         ( (Components[vIndex] as TAdvSmoothButton).Parent = TablePanel ) and
         ((LeftStr((Components[vIndex] as TAdvSmoothButton).Name,5) = 'Table') or (LeftStr((Components[vIndex] as TAdvSmoothButton).Name,4) = 'Wall')) then
      begin
        (Components[vIndex] as TAdvSmoothButton).Free;
        Goto go;
      end;

    end;
  end;
var vIsImage: Boolean;
    vTableButton :TPosButton;
    vFloorIndex :Integer;
    vImageButton :TAdvSmoothButton;
    vIndex, vWidth, vHeight :Integer;
begin
  //층이 없을때
  if High(Common.FloorData) < 0 then Exit;

  //기존 테이블 버튼 모두삭제
  TableButtonDelete;
  //저장된 테이블 내역 불러오기
//  try
//    OpenQuery('select SEQ, '
//             +'       NO_TOP, '
//             +'       NO_LEFT, '
//             +'       NO_HEIGHT, '
//             +'       NO_WIDTH, '
//             +'       NO_TABLE, '
//             +'       COLOR, '
//             +'       NUMBER_COLOR, '
//             +'       FONT_COLOR, '
//             +'       BORDER_COLOR, '
//             +'       NO_TABLE_GROUP, '
//             +'       NM_TABLE, '
//             +'       DT_CHANGE, '
//             +'       TABLE_STYLE, '
//             +'       YN_PACKING, '
//             +'       BOTTOM_COLOR, '
//             +'       CHAIR_COUNT '
//             +'  from MS_TABLE   '
//             +' where CD_STORE =:P0 '
//             +'   and CD_FLOOR =:P1 '
//             +' order by NO_TABLE ',
//             [Common.Config.StoreCode,
//              Common.Table.Floor]);
//  except
//    on E: Exception do
//    begin
//      Common.WriteLog('TableCreate',E.Message);
//      Common.ErrBox(E.Message);
//      Exit;
//    end;
//  end;

  FTablePageCount := 1;

  for vIndex := 0 to TableData.Count-1 do
  begin
    if TTableData(TableData[vIndex]^).Floor <> Common.Table.Floor then Continue;
    if TTableData(TableData[vIndex]^).Seq > 0 then
    begin
      vImageButton                               := TAdvSmoothButton.Create(Self);
      vImageButton.Parent                        := TablePanel;
      vImageButton.Name                          := Format('Wall%d',[TTableData(TableData[vIndex]^).Seq]);
      vImageButton.Top                           := TTableData(TableData[vIndex]^).Top;
      vImageButton.Left                          := TTableData(TableData[vIndex]^).Left;
      vImageButton.Height                        := TTableData(TableData[vIndex]^).Height;
      vImageButton.Width                         := TTableData(TableData[vIndex]^).Width;
      vImageButton.Color                         := TTableData(TableData[vIndex]^).Color;
      vImageButton.Appearance.Font.Color         := TTableData(TableData[vIndex]^).FontColor;
      vImageButton.Caption                       := TTableData(TableData[vIndex]^).TableName;
      vImageButton.Status.Appearance.Font.Size   := Common.FloorData[vFloorIndex].TableNumberSize;
      vImageButton.Cursor                        := crNone;
      vImageButton.Appearance.SimpleLayout       := true;
      vImageButton.Appearance.SimpleLayoutBorder := true;
      vImageButton.Bevel                         := true;
      vImageButton.BevelColor                    := vImageButton.Color;
      vImageButton.Shadow                        := true;
      vImageButton.ShowFocus                     := false;
      vImageButton.Appearance.GlowPercentage     := 10;
    end
    else
    begin
      vTableButton := TPosButton.Create(Self);
      with vTableButton do
      begin
        Name             := Format('Table%d',[TTableData(TableData[vIndex]^).TableNo]);

        Parent           := TablePanel;
        vFloorIndex := GetFloorIndex(Common.Table.Floor);
        if vFloorIndex < 0 then
          vFloorIndex := 0;

        if isTableImage then
          Style := bsRect
        else
          Style := bsRound;

        if GetOption(25) = '1' then
        begin
          Number.NumberString := TTableData(TableData[vIndex]^).TableName;
          Number.TempString   := TTableData(TableData[vIndex]^).TableName;

          if Number.NumberString = '' then
          begin
            Number.NumberString := TTableData(TableData[vIndex]^).TableName;
            Number.TempString   := TTableData(TableData[vIndex]^).TableName;
          end;
        end
        else
        begin
          Number.NumberString := IntToStr(TTableData(TableData[vIndex]^).TableNo);
          Number.TempString   := IntToStr(TTableData(TableData[vIndex]^).TableNo);
        end;

        Tag                 := 0;
        Top                 := TTableData(TableData[vIndex]^).Top;
        Left                := TTableData(TableData[vIndex]^).Left;
        Height              := TTableData(TableData[vIndex]^).Height;
        Width               := TTableData(TableData[vIndex]^).Width;
        //그룹이 지정되 있을때
        if TTableData(TableData[vIndex]^).GroupTable > 0 then
        begin
          if (TTableData(TableData[vIndex]^).TableNo = TTableData(TableData[vIndex]^).GroupTable) then
            Bottom.CenterString := 'G-M'
          else
            Bottom.CenterString      := 'G-'+ IntToStr(TTableData(TableData[vIndex]^).GroupTable);
        end
        else
          Bottom.CenterString      := '';

        Temp4               := TTableData(TableData[vIndex]^).Packing;
        ShowAccelChar       := False;

        BorderColor         := TTableData(TableData[vIndex]^).BorderColor;
        Font.Size           := Common.FloorData[vFloorIndex].CaptionSize;
        Number.Font.Name    := '맑은 고딕';
        Number.Font.Color   := TTableData(TableData[vIndex]^).FontColor;
        Number.Font.Size    := Common.FloorData[vFloorIndex].NumberSize;

        Bottom.Font.Name    := '맑은 고딕';
        if Common.FloorData[vFloorIndex].BottomFontColor = '' then
          Bottom.Font.Color   := Number.Font.Color
        else
          Bottom.Font.Color   := TTableData(TableData[vIndex]^).BottomColor;
        Bottom.Font.Size    := Common.FloorData[vFloorIndex].BottomSize;

        Amount.Font.Name    := '맑은 고딕';
        Amount.Font.Color   := Number.Font.Color;
        Amount.Font.Size    := Common.FloorData[vFloorIndex].AmountSize;
        Amount.Font.Style   := [fsBold];
        Menu.Font.Name      := '맑은 고딕';
        Menu.Font.Size      := Common.FloorData[vFloorIndex].CaptionSize;
        Menu.Font.Color     := Number.Font.Color;

        Font                := Amount.Font;
        Temp5 := ColorToString(Number.Font.Color);

        Number.Height       := Trunc(Number.Font.Size * 2.3)+2;
        Bottom.Height       := Bottom.Font.Size * 2;
        Onclick             := TableButtonClick;
        Number.ShowColor    := true;
        Color               := $00D7D7D7;
        BorderInnerColor    := clNone;
        Cursor              := crHandPoint;

        Number.Number       := TTableData(TableData[vIndex]^).TableNo;
        Number.Color        := NormalColor;
        //최종주문 테이블 매핑
        if (Number.Number = Common.LastOrderTableNo) and (Common.LastOrderFloor = Common.Table.Floor) then
          Common.LastOrderTableButton := vTableButton;
        if (GetOption(252)= '0') and FileExists(Common.AppPath+'DLL\Table.png') then
        begin
          vImageButton  := TAdvSmoothButton.Create(Self);
          vImageButton.Parent  := TablePanel;
          vImageButton.Name    := Format('TableImageButton%d',[Number.Number]);

          if GetOption(252) = '0' then
          begin
            if (TTableData(TableData[vIndex]^).Packing = 'Y') and FileExists(Common.AppPath+'DLL\Packing.png')  then
              vImageButton.Picture.LoadFromFile(Common.AppPath+'DLL\Packing.png')
            else if TTableData(TableData[vIndex]^).Style = 'C' then
            begin
              if FileExists(Common.AppPath+'DLL\CircleTable.png') then
                vImageButton.Picture.LoadFromFile(Common.AppPath+'DLL\CircleTable.png')
              else
                vImageButton.Picture.LoadFromFile(Common.AppPath+'DLL\Table.png');

              vImageButton.Appearance.Rounding := 50;
            end
            else
            begin
              vImageButton.Appearance.Rounding := 10;
              vImageButton.Picture.LoadFromFile(Common.AppPath+'DLL\Table.png');
            end;
          end
          else
          begin
            if TTableData(TableData[vIndex]^).Style = 'C' then
              vImageButton.Appearance.Rounding := 50
            else
              vImageButton.Appearance.Rounding := 10;
          end;

          vImageButton.Top       := TTableData(TableData[vIndex]^).Top;
          vImageButton.Left      := TTableData(TableData[vIndex]^).Left;
          vImageButton.Height    := TTableData(TableData[vIndex]^).Height;
          vImageButton.Width     := TTableData(TableData[vIndex]^).Width;

          //원형테이블일때는 가로 세로 중 작은 거에 1/2
          if vImageButton.Appearance.Rounding = 50 then
          begin
            if vImageButton.Height < vImageButton.Width then
              vImageButton.Appearance.Rounding := (vImageButton.Height-16) div 2
            else
              vImageButton.Appearance.Rounding := (vImageButton.Width-16) div 2;
          end;

          vImageButton.Tag       := Number.Number;
          vImageButton.Hint      := Number.TempString;
          vImageButton.Color     := NormalColor;
          vImageButton.Bevel     := true;
          vImageButton.Shadow    := true;
          vImageButton.ClickDelay := true;
          vImageButton.AllowTimer := true;
          vImageButton.Appearance.GlowPercentage := 10;

          vImageButton.Appearance.Font.Color       := clBlack;
          vImageButton.Appearance.Layout           := TGDIPButtonLayout.blNone;
          vImageButton.Appearance.PictureAlignment := taCenter;
          vImageButton.Appearance.SimpleLayout     := true;
          vImageButton.Appearance.SimpleLayoutBorder := true;
          vImageButton.Status.Visible := true;
          vImageButton.Status.Appearance.Font.Size        := Common.FloorData[vFloorIndex].TableNumberSize;
          if vImageButton.Status.Appearance.Font.Size < 5 then
            vImageButton.Status.Appearance.Font.Size := 13;

          vImageButton.Appearance.Font.Size               := vImageButton.Status.Appearance.Font.Size;
          vImageButton.Status.Appearance.Fill.Color       := clWhite;
          vImageButton.Status.Appearance.Fill.ColorTo     := clWhite;
          vImageButton.Status.Appearance.Fill.BorderColor := clBlack;
          vImageButton.Status.Caption := Number.NumberString;
          vImageButton.Caption  := Number.NumberString;
          vImageButton.ClickDelay := false;
          vImageButton.RepeatInterval := 0;
          vImageButton.OnClick := TableImageButtonClick;
          vImageButton.ShowFocus := false;
          vImageButton.Cursor  := crHandPoint;
          Temp7 := 'Y';                                //Temp7 이미지테이블 사용여부
        end
        else if FileExists(Common.AppPath+'DLL\Packing.png') and (TTableData(TableData[vIndex]^).Packing = 'Y') then
        begin
          vImageButton  := TAdvSmoothButton.Create(Self);
          vImageButton.Parent  := TablePanel;
          vImageButton.Name    := Format('TableImageButton%d',[Number.Number]);

          vImageButton.Picture.LoadFromFile(Common.AppPath+'DLL\Packing.png');

          vImageButton.Top       := TTableData(TableData[vIndex]^).Top;
          vImageButton.Left      := TTableData(TableData[vIndex]^).Left;
          vImageButton.Height    := TTableData(TableData[vIndex]^).Height;
          vImageButton.Width     := TTableData(TableData[vIndex]^).Width;

          //원형테이블일때는 가로 세로 중 작은 거에 1/2
          if vImageButton.Appearance.Rounding = 50 then
          begin
            if vImageButton.Height < vImageButton.Width then
              vImageButton.Appearance.Rounding := (vImageButton.Height-16) div 2
            else
              vImageButton.Appearance.Rounding := (vImageButton.Width-16) div 2;
          end;

          vImageButton.Tag       := Number.Number;
          vImageButton.Hint      := Number.TempString;
          vImageButton.Color     := NormalColor;
          vImageButton.Bevel     := true;
          vImageButton.Shadow    := true;
          vImageButton.ClickDelay := true;
          vImageButton.AllowTimer := true;
          vImageButton.Appearance.GlowPercentage := 10;

          vImageButton.Appearance.Font.Color       := clBlack;
          vImageButton.Appearance.Layout           := TGDIPButtonLayout.blNone;
          vImageButton.Appearance.PictureAlignment := taCenter;
          vImageButton.Appearance.SimpleLayout     := true;
          vImageButton.Appearance.SimpleLayoutBorder := true;
          vImageButton.Status.Visible := true;
          vImageButton.Status.Appearance.Font.Size        := Common.FloorData[vFloorIndex].TableNumberSize;
          if vImageButton.Status.Appearance.Font.Size < 5 then
            vImageButton.Status.Appearance.Font.Size := 13;
          vImageButton.Appearance.Font.Size        := vImageButton.Status.Appearance.Font.Size;
          vImageButton.Status.Appearance.Fill.Color       := clWhite;
          vImageButton.Status.Appearance.Fill.ColorTo     := clWhite;
          vImageButton.Status.Appearance.Fill.BorderColor := clBlack;
          vImageButton.Status.Caption := Number.NumberString;
          vImageButton.Caption  := Number.NumberString;
          vImageButton.ClickDelay := false;
          vImageButton.RepeatInterval := 0;
          vImageButton.OnClick := TableImageButtonClick;
          vImageButton.ShowFocus := false;
          vImageButton.Cursor  := crHandPoint;
          Temp7 := 'Y';                                //Temp7 이미지테이블 사용여부
        end
        else
          Temp7 := 'N';
        Temp8 := 'Y';
      end;
    end;
  end;
end;

procedure TTable_F.TableImageButtonClick(Sender: TObject);
  function GetTableButton(aTableNo:Integer):TPosButton;
  var vIndex :Integer;
  begin
    For vIndex := 0 to ComponentCount-1 do
    begin
      if (Components[vIndex] is TPosButton) and
         ( (Components[vIndex] as TPosButton).Parent = TablePanel ) and
         ( (Components[vIndex] as TPosButton).Number.Number = aTableNo) then
      begin
        Result := TPosButton(Components[vIndex]);
        Break;
      end;
    end;
  end;
var vTableButton :TPosButton;
begin
  vTableButton := GetTableButton((Sender as TAdvSmoothButton).Tag);
  TableButtonClick(vTableButton);
end;

procedure TTable_F.TableKeyReadEvent(const S: String);
  function GetTableButton(aValue:Integer):TPosButton;
  var I :Integer;
  begin
    Result := nil;
    For I := 0 to ComponentCount-1 do
    begin
      if (Components[I] is TPosButton) and
         ( (Components[I] as TPosButton).Parent = TablePanel ) and
         ( (Components[I] as TPosButton).Number.Number = aValue ) then
      begin
        Result := TPosButton(Components[I]);
        Break;
      end;
    end;
  end;

  function GetFloorButton(aValue:String):TAdvSmoothButton;
  var I :Integer;
  begin
    Result := nil;
    //층을 사용안할때
    if GetOption(58) = '1' then Exit;
    For I := 0 to ComponentCount-1 do
    begin
      if (Components[I] is TAdvSmoothButton) and
         ( (Components[I] as TAdvSmoothButton).Parent = FloorPanel ) and
         ( (Components[I] as TAdvSmoothButton).Hint = aValue ) then
      begin
        Result := TAdvSmoothButton(Components[I]);
        Break;
      end;
    end;
  end;
var vTableNo :Integer;
begin
  try
    OpenQuery('select NO_TABLE, '
             +'       CD_FLOOR '
             +'  from MS_TABLE '
             +' where CD_STORE =:P0 '
             +'   and NO_RFID  =:P1 ',
             [Common.Config.StoreCode,
              Trim(S)]);
    if not Common.Query.Eof then
    begin
      vTableNo := Common.Query.Fields[0].AsInteger;
      TableKeyFloorButton := GetFloorButton(Common.Query.Fields[1].AsString);
      if TableKeyFloorButton <> nil then
      begin
        FloorButtonClick(TableKeyFloorButton);
        Sleep(30);
      end;
      TableKeyButton      := GetTableButton(vTableNo);
      Common.Query.Close;
      Tmr_TableKey.Enabled := True;
      Tmr_TableKeyTimer(nil);
      Exit;
    end
    else
    begin
      Common.MsgBox('등록이 안된 TableKey 입니다');
      Exit;
    end;
    //테이블을 선택하게 한다
    TableMode := tbmTableKey;
  except
    on E: Exception do
      Common.WriteLog('Table_F(TableKeyReadEvent)',E.Message);
  end;
end;

{------------------------------------------------------------------------------}
{ 층버튼 눌렀을때                                                              }
{------------------------------------------------------------------------------}
procedure TTable_F.FloorButtonClick(Sender: TObject);
var Temp :String;
    vIndex, vFloorIndex :Integer;
begin
  TableMark := false;
  try
    if Sender <> nil then
    begin
      vFloorIndex := ((FloorPage-1)*FloorButtonCount)+(Sender as TAdvSmoothButton).Tag;
      Common.BookingTableNo.Clear;
      if (Sender as TAdvSmoothButton).Caption = EmptyStr then Exit;
      if Common.Table.Floor = Common.FloorData[vFloorIndex].Code then Exit;

      NormalColor        := StringToColorDef(Common.FloorData[vFloorIndex].Color,clSkyBlue);
      NormalBorderColor  := StringToColorDef(Common.FloorData[vFloorIndex].BorderColor,clNone);
      NormalFontColor    := StringToColorDef(Common.FloorData[vFloorIndex].FontColor,clWhite);

      for vIndex := Low(FloorButton) to High(FloorButton) do
      begin
        FloorButton[vIndex].BevelColor := clWhite;
        FloorButton[vIndex].Color      := FloorColor;
        FloorButton[vIndex].Picture    := nil;
      end;                                                            //FloorUpButton

      (Sender as TAdvSmoothButton).BevelColor := clLime;
      (Sender as TAdvSmoothButton).Picture.Assign(FunctionPanelImageCollection.Items[3].Picture);

      Screen.Cursor          := crHourGlass;
      Temp                   := Common.Table.Floor;
      Common.Table.Floor     := Common.FloorData[vFloorIndex].Code;
      Common.Table.FloorName := Trim((Sender as TAdvSmoothButton).Caption);
      if Pos(#13,Common.Table.FloorName) > 0 then
        Common.Table.FloorName := LeftStr(Common.Table.FloorName, Pos(#13,Common.Table.FloorName)-1);
      Common.Table.Corner    := Common.FloorData[vFloorIndex].Corner;

      if not isTableImage then
      begin
        Self.Color          := Common.FloorData[vFloorIndex].BackGroundColor;
        FloorPanel.Color    := Common.FloorData[vFloorIndex].BackGroundColor;
        MainPanel.Color     := Common.FloorData[vFloorIndex].BackGroundColor;
        TablePanel.Color    := Common.FloorData[vFloorIndex].BackGroundColor;
        MainPanel.Width     := Self.Width - MainPanel.Left * 2;// - Ifthen(GetOption(58)='1', 0, FloorPanel.Width);
        MainPanel.Height    := Self.Height - MainPanel.Top - 5;
        FunctionPanel.Fill.Color         := Common.FloorData[vFloorIndex].BackGroundColor;
        FunctionPanel.Fill.ColorMirror   := Common.FloorData[vFloorIndex].BackGroundColor;
        FunctionPanel.Fill.ColorTo       := Common.FloorData[vFloorIndex].BackGroundColor;
        FunctionPanel.Fill.ColorMirrorTo := Common.FloorData[vFloorIndex].BackGroundColor;
      end;
    end
    else
    begin
      if High(Common.FloorData) > 0 then
      begin
        Common.Table.Floor  := Common.FloorData[0].Code;
        NormalColor         := StringToColorDef(Common.FloorData[0].Color,clSkyBlue);
        NormalBorderColor   := StringToColorDef(Common.FloorData[0].BorderColor,clNone);
        NormalFontColor     := StringToColorDef(Common.FloorData[0].FontColor,clWhite);
        Common.Table.Corner := Common.FloorData[0].Corner;
      end
      else
        Common.Table.Floor := '001';
    end;



    if not FIsFormShow then Exit;
    if Temp <> Common.Table.Floor then
      TableCreate;
    isTableRefresh := true;
    SetOrderInfo(true);
//    SetTableVisible;
    isTableRefresh := false;

  finally
    Screen.Cursor    := crDefault;
  end;
end;

{------------------------------------------------------------------------------}
{ 층버튼 생성                                                            }
{------------------------------------------------------------------------------}
procedure TTable_F.FloorButtonCreate;
var vIndex,
    vTop :Integer;
begin
  Common.Table.Floor := '000';
  if LeftStr(Common.Config.AvailFloor,3) = '000' then
    OpenQuery('select * '
             +'  from MS_CODE  '
             +' where CD_STORE=:P0 '
             +'   and CD_KIND = ''03'' '
             +'   and DS_STATUS=0 '
             +' order by CD_CODE',
             [Common.Config.StoreCode])
  else
    OpenQuery('select * '
             +'  from MS_CODE  '
             +' where CD_STORE =:P0 '
             +'   and CD_KIND  =''03'' '
             +'   and CD_CODE in ('''+StringReplace(Common.Config.AvailFloor,',',''',''',[rfReplaceAll])+''')'
             +'   and DS_STATUS=0 '
             +' order by CD_CODE',
             [Common.Config.StoreCode]);

  SetLength(Common.FloorData, Common.Query.RecordCount);
  vIndex := 0;
  while not Common.Query.Eof do
  begin
    Common.FloorData[vIndex].Code        := Common.Query.FieldByName('CD_CODE').AsString;
    Common.FloorData[vIndex].Name        := Common.Query.FieldByName('NM_CODE1').AsString;
    Common.FloorData[vIndex].NumberSize  := StrToIntDef(Common.Query.FieldByName('NM_CODE2').AsString,6);
    Common.FloorData[vIndex].CaptionSize := StrToIntDef(Common.Query.FieldByName('NM_CODE3').AsString,6);
    Common.FloorData[vIndex].AmountSize  := StrToIntDef(Common.Query.FieldByName('NM_CODE4').AsString,6);
    Common.FloorData[vIndex].BottomSize  := StrToIntDef(Common.Query.FieldByName('NM_CODE5').AsString,6);
    Common.FloorData[vIndex].Corner      := Common.Query.FieldByName('NM_CODE6').AsString;
    Common.FloorData[vIndex].Color       := Common.Query.FieldByName('NM_CODE7').AsString;
    Common.FloorData[vIndex].BorderColor := Common.Query.FieldByName('NM_CODE8').AsString;
    Common.FloorData[vIndex].FontColor   := Common.Query.FieldByName('NM_CODE9').AsString;
    Common.FloorData[vIndex].TableNumberSize  := StrToIntDef(Common.Query.FieldByName('NM_CODE10').AsString,11);
    if Common.FloorData[vIndex].TableNumberSize > 100 then
      Common.FloorData[vIndex].TableNumberSize := 11;
    Common.FloorData[vIndex].BottomFontColor := Common.Query.FieldByName('NM_CODE18').AsString;
    Common.FloorData[vIndex].MenuCount   := StrToIntDef(Common.Query.FieldByName('NM_CODE19').AsString,11);
    Common.FloorData[vIndex].isWaitFloor := Common.Query.FieldByName('NM_CODE20').AsString = 'Y';
    Common.FloorData[vIndex].BackGroundColor := StringToColorDef(Common.Query.FieldByName('NM_CODE21').AsString, clWhite);


    
    if Common.FloorData[vIndex].NumberSize  > 30 then Common.FloorData[vIndex].NumberSize  := 11;
    if Common.FloorData[vIndex].CaptionSize > 30 then Common.FloorData[vIndex].CaptionSize := 11;
    if Common.FloorData[vIndex].AmountSize  > 30 then Common.FloorData[vIndex].AmountSize  := 11;
    if Common.FloorData[vIndex].BottomSize  > 30 then Common.FloorData[vIndex].BottomSize  := 11;
    Common.Query.Next;
    Inc(vIndex);
  end;
  Common.Query.Close;

  //층사용하지 않을때
  if GetOption(58) = '1' then
    Common.Table.Floor := Common.FloorData[0].Code;

  FloorPanel.Width    := FloorWidth;
  FloorPanel.Left     := Self.Width - FloorWidth - 7;

  FloorMaxCount := High(Common.FloorData)+1;

  if not Info1Panel.Visible then
    Info1Panel.Height := 0;

  if not Info2Panel.Visible then
    Info2Panel.Height := 0;


  //한페이지 이내일때 이전 다음버튼 안보이게
  if (FloorButtonHeight = 0) or ((FloorPanel.Height div  (FloorButtonHeight+2)) >= FloorMaxCount) then
  begin
    if FloorButtonHeight = 0 then
    begin
      FloorButtonCount  := FloorMaxCount;
      FloorButtonHeight := (FloorPanel.Height -  2) div FloorMaxCount - 5;
    end
    else
      FloorButtonCount        := ((FloorPanel.Height) div  (FloorButtonHeight+2));
    FloorUpButton.Visible   := false;
    FloorDownButton.Visible := false;
  end
  else
  begin
    FloorUpButton.Visible   := true;
    FloorDownButton.Visible := true;
    //한페이지에 표시버튼 갯수
    FloorButtonCount := ((FloorPanel.Height)  div  (FloorButtonHeight+2));
    //층총 페이지 계산
    FloorPageCount := FloorMaxCount div FloorButtonCount;
    if (FloorMaxCount Mod FloorButtonCount) > 0 then
      FloorPageCount := FloorPageCount + 1;

    if FloorPageCount > 1 then
      FloorButtonCount := FloorButtonCount - 1;

    FloorUpButton.Height    := FloorButtonHeight;
    FloorDownButton.Height  := FloorButtonHeight;

    FloorUpButton.Top     := FloorPanel.Height - FloorUpButton.Height -1;
    FloorDownButton.Top   := FloorPanel.Height - FloorUpButton.Height -1;
    FloorUpButton.Width   := FloorPanel.Width div 2 - 1;
    FloorDownButton.Width := FloorPanel.Width div 2 - 1;
    FloorDownButton.Left  := FloorUpButton.Left + FloorUpButton.Width;
  end;

  SetLength(FloorButton, FloorButtonCount);

  if true then //isTableImage then
  begin
    vTop := 50;
    if GetOption(58) = '0' then
    begin
      if Info1Panel.Height <> 0 then
      begin
        Info1Image.Parent := TablePanel;
        Info1Image.Top    := vTop + 5;
        Info1Image.Left   := FloorPanel.Left + Info1Image.Left-5;

        Info1NameLabel.Parent := TablePanel;
        Info1NameLabel.Top    := vTop  + 5;
        Info1NameLabel.Left   := FloorPanel.Left + Info1NameLabel.Left-5;

        SaleAmountLabel.Parent := TablePanel;
        SaleAmountLabel.Top    := vTop  + 16 + 5;
        SaleAmountLabel.Left   := FloorPanel.Left + SaleAmountLabel.Left -2;
      end;

      if Info2Panel.Height <> 0 then
      begin
        Info2Image.Parent := TablePanel;
        Info2Image.Top    := vTop + 45 + 5;
        Info2Image.Left   := FloorPanel.Left + Info2Image.Left-5;

        Info2NameLabel.Parent := TablePanel;
        Info2NameLabel.Top    := vTop + 45 + 5;
        Info2NameLabel.Left   := FloorPanel.Left + Info2NameLabel.Left-5;

        OrderAmountLabel.Parent := TablePanel;
        OrderAmountLabel.Top    := vTop + 45 + 16 + 5;
        OrderAmountLabel.Left   := FloorPanel.Left + OrderAmountLabel.Left - 2;
      end;
    end;

    vTop := OrderInfoButton.Height + 100;
    for vIndex := Low(FloorButton) to High(FloorButton) do
    begin
      FloorButton[vIndex] := TAdvSmoothButton.Create(Self);
      with FloorButton[vIndex] do
      begin
        Name        := Format('Floor%dButton',[vIndex]);
        Parent      := TablePanel;
        Color       := FloorColor;
        Appearance.SimpleLayout := true;
        Appearance.SimpleLayoutBorder := true;
        BevelColor  := clBlack;
        Appearance.Rounding     := 5;
        Appearance.Font := FloorFont;
        Appearance.PictureAlignment := taCenter;
        Cursor      := crHandPoint;
        Top         := vTop;
        Width       := FloorPanel.Width-2;
        Height      := FloorButtonHeight-4;
        Left        := MainPanel.Width - FloorPanel.Width-2;
        Tag         := vIndex;
        OnClick     := FloorButtonClick;
        vTop := vTop + FloorButtonHeight + 1;
      end;
      FloorPanel.Visible := false;

      FloorUpButton.Parent   := MainPanel;
      FloorDownButton.Parent := MainPanel;
      FloorUpButton.Top      := FloorPanel.Top + FloorPanel.Height - FloorUpButton.Height;
      FloorUpButton.Left     := MainPanel.Width - FloorPanel.Width-2;
      FloorDownButton.Top    := FloorPanel.Top + FloorPanel.Height - FloorUpButton.Height;
      FloorDownButton.Left   := FloorUpButton.Left + FloorUpButton.Width + 1;
    end;
  end
  else
  begin
    vTop := Info1Panel.Height + Info2Panel.Height + 10;
    for vIndex := Low(FloorButton) to High(FloorButton) do
    begin
      FloorButton[vIndex] := TAdvSmoothButton.Create(Self);
      with FloorButton[vIndex] do
      begin
        Name        := Format('Floor%dButton',[vIndex]);
        Parent      := FloorPanel;
        Color       := FloorColor;
        Appearance.SimpleLayout := true;
        Appearance.SimpleLayoutBorder := true;
        BevelColor  := clBlack;
        Appearance.Rounding     := 5;
        Appearance.Font := FloorFont;
        Appearance.PictureAlignment := taCenter;
        Cursor      := crHandPoint;
        Top         := vTop;
        Width       := FloorPanel.Width-2;
        Height      := FloorButtonHeight-4;
        Left        := 0;
        Tag         := vIndex;
        OnClick     := FloorButtonClick;
        vTop := vTop + FloorButtonHeight + 1;
        if GetOption(58) = '1' then
          Visible := false;
      end;
    end;
  end;


  FloorUpButton.Color    := FloorColor;
  FloorDownButton.Color  := FloorColor;

  if FloorPageCount > 1 then
  begin
    FloorUpButton.Visible   := true;
    FloorDownButton.Visible := true;
  end;

  if GetOption(58) = '1' then
  begin
    FloorUpButton.Visible   := false;
    FloorDownButton.Visible := false;
  end;

  FloorPage := 1;
end;

procedure TTable_F.FloorUpButtonClick(Sender: TObject);
begin
  if Sender = FloorUpButton then
    FloorPage := FloorPage - 1
  else if Sender = FloorDownButton then
    FloorPage := FloorPage + 1;
end;

{------------------------------------------------------------------------------}
{ 테이블 버튼 눌렀을때                                                         }
{------------------------------------------------------------------------------}
procedure TTable_F.TableButtonClick(Sender: TObject);
  procedure SetImageButton(aTableNo:Integer;aVisible:Boolean);
  var vIndex :Integer;
  begin
    For vIndex := 0 to ComponentCount-1 do
    begin
      if (Components[vIndex] is TAdvSmoothButton) and
         ( (Components[vIndex] as TAdvSmoothButton).Parent = TablePanel ) and
         ( (Components[vIndex] as TAdvSmoothButton).Tag = aTableNo) then
      begin
        TAdvSmoothButton(Components[vIndex]).Status.Appearance.Fill.Color   := Ifthen(aVisible, clRed, clWhite);
        TAdvSmoothButton(Components[vIndex]).Status.Appearance.Fill.ColorTo := Ifthen(aVisible, clRed, clWhite);
        TAdvSmoothButton(Components[vIndex]).Status.Appearance.Font.Color   := Ifthen(aVisible, clWhite, clBlack );
        Break;
      end;
    end;
  end;
  procedure GetFloorData;
  var vIndex :Integer;
  begin
    for vIndex := 0 to High(Common.FloorData) do
    begin
      if Common.FloorData[vIndex].Code = Common.Table.Floor then
      begin
        Common.Table.FloorName := Common.FloorData[vIndex].Name;

        if Pos(#13,Common.Table.FloorName) > 0 then
          Common.Table.FloorName := LeftStr(Common.Table.FloorName, Pos(#13,Common.Table.FloorName)-1);
        Common.Table.Corner    := Common.FloorData[vIndex].Corner;
        Break;
      end;
    end;
  end;
var vTemp,
    vFloor,
    vFloorName,
    vResult,
    vPosNo,
    vRfid,
    vBookingNo :String;
    vDsGroup,
    vUseTable,
    nLoop :Integer;
    vExist :Boolean;
    vOption : Integer;
    vTableMark :Boolean;
    vIndex :Integer;
    visOK :Boolean;
    vFloorIndex :Integer;
    vGroupNo :Integer;
begin
  try
    if not Common.IsDebugMode then
      BlockInput(true);
    if MilliSecondsBetween(Now(),ClickTime) < Ifthen(TableMode = tbmNone, 100, 10) then Exit;
    ClickTime   := Now;
    ClickObject := Sender;
    if Trim(Common.Config.UserCode) = '' then
    begin
      Common.ErrBox('계산원 정보가 올바르지 않습니다'+#13#13+'포스를 다시 시작하세요');
      Exit;
    end;

    TableMark := false;
    if Sender = nil then Exit;

    if Common.Table.Floor = '000' then
      Common.Table.Floor := '001';

    if (TableMode <> tbmNone) and Common.FloorData[GetFloorIndex(Common.Table.Floor)].isWaitFloor then
    begin
      Common.ErrBox('대기층의 테이블은 선택할 수 없습니다');
      Exit;
    end;

    if Common.Table.FloorName = '' then
      GetFloorData;
    vFloor     := Common.Table.Floor;
    vFloorName := Common.Table.FloorName;
    InitTableRecord(Common.Table);
    InitPreSentRecord(Common.Present);
    Common.Table.Floor       := vFloor;
    Common.Table.FloorName   := vFloorName;
    Common.Table.isWaitTable := Common.FloorData[GetFloorIndex(Common.Table.Floor)].isWaitFloor;

    Common.Table.OrderAmt  := StoI((Sender as TPosButton).Temp3);

    //테이블번호
    Common.Table.Number := (Sender as TPosButton).Number.Number;
    Common.Table.Name   := (Sender as TPosButton).Number.TempString;
    vBookingNo          := (Sender as TPosButton).Temp1;
    Common.WriteLog('work', Format('%s(%d) Table Click',[Common.Table.Name, Common.Table.Number]));

    case TableMode of
      tbmTableMove,    {테이블이동}
      tbmMerge,        {테이블합석}
      tbmGroup,        {테이블그룹}
      tbmMenuMove     :{메뉴이동}
        begin
          if TableMode = tbmTableMove then
            if not Common.CheckTable('A',Common.Table.Number) then
            begin
              TableMode := tbmNone;
              SetOrderInfo;
              Exit;
            end;

          if TableMode = tbmMerge then
            if not Common.CheckTable('A',Common.Table.Number) then
            begin
              TableMode := tbmNone;
              SetOrderInfo;
              Exit;
            end;

          if TableMode = tbmMenuMove then
            if not Common.CheckTable('A',Common.Table.Number) then
            begin
              TableMode := tbmNone;
              SetOrderInfo;
              Exit;
            end;

          if TableMode = tbmGroup then
            if not Common.CheckTable('A',Common.Table.Number) then
            begin
              TableMode := tbmNone;
              SetOrderInfo;
              Exit;
            end;

          //추가요금 사용 시 이동할 테이블의 입장시간을 체크한다
          if (TableMode = tbmMerge) and (Common.GetAddMenuAmt(Common.Table.Number) > 0) then
          begin
            if not Common.AskBox('추가요금이 있는 테이블입니다'+#13+'계속 하시겠습니까?') then
            begin
              TableMode := tbmNone;
              SetOrderInfo;
              Exit;
            end;
          end;

          FromTable             := Common.Table;
          FromTable.Number      := (Sender as TPosButton).Number.Number;
          FromTable.Name        := (Sender as TPosButton).Number.TempString;
          FromTable.DamdangName := (Sender as TPosButton).Temp9;
          case TableMode of
            tbmTableMove : TableMode   := tbmTableMoveing;
            tbmMerge     : TableMode   := tbmMergeing;
            tbmGroup     : TableMode   := tbmGrouping;
            tbmMenuMove  : TableMode   := tbmMenuMoveing;
          end;
          Exit;
        end;
      tbmTableMoveing,      {테이블이동중}
      tbmMergeing,          {테이블합석중}
      tbmGrouping,          {테이블그룹중}
      tbmMenuMoveing     :  {메뉴이동중}
        begin
          if not Common.CheckTable('U',Common.Table.Number) then
          begin
            Exit;
          end;

          ToTable             := Common.Table;
          ToTable.Number      := (Sender as TPosButton).Number.Number;
          ToTable.Name        := (Sender as TPosButton).Number.TempString;
          ToTable.DamdangName := (Sender as TPosButton).Temp9;
          if TableMode = tbmGrouping then
            if not Common.CheckTable('A',Common.Table.Number) then
            begin
              TableMode := tbmNone;
              SetOrderInfo;
              Exit;
            end;

          //테이블 이동인데 주분중인 테이블로 이동하면 합석으로 처리한다
          if TableMode = tbmTableMoveing then
          begin
            if (Sender as TPosButton).Temp8 = 'Y' then
            begin
              if not Common.AskBox(Format('%s 테이블과 %s 테이블을'#13'합석하시겠습시까?',[FromTable.Name, ToTable.Name]))  then
              begin
                TableMode := tbmNone;
                Exit;
              end;
              TableMode := tbmMergeing;
            end;
          end;


          TableModeApply;
          if TableMode <> tbmGrouping then
            TableMode := tbmNone;
          Exit;
        end;
      tbmUnGroup :           {테이블그룹해제}
        begin
          FromTable.Number := (Sender as TPosButton).Number.Number;
          FromTable.Name   := (Sender as TPosButton).Number.TempString;
          TableModeApply;
          TableMode := tbmNone;
          Exit;
        end;
      tbmRePrint :           {주문서재인쇄}
        begin
          vTemp     := TPosButton(Sender).Bottom.CenterString;
          Common.Table.Packing    := TPosButton(Sender).Temp4;
          Common.Table.OrderType  := 'T';
          if vTemp = '' then
            Common.Table.GroupType := 'N'
          else if vTemp = 'G-M' then
            Common.Table.GroupType := 'M'
          else
            Common.Table.GroupType := Copy( vTemp, POS('-', vTemp)+1, Length(vTemp) );

          RePrint_F := TRePrint_F.Create(self);
          try
            Common.Table.OrderType  := 'T';
            Common.Device.OnCidReadData :=nil;
            RePrint_F.ShowModal;
          finally
            FreeAndNil(RePrint_F);
            TableMode := tbmNone;
          end;
          Exit;
        end;
      tbmBooking :
        begin
          vExist := False;
          For nLoop := 0 to Common.BookingTableNo.Count-1 do
          begin
            if Common.BookingTableNo.Strings[nLoop] = IntToStr((Sender as TPosButton).Number.Number) then
            begin
              SetImageButton( (Sender as TPosButton).Number.Number, false);
              (Sender as TPosButton).Caption := '';
              Common.BookingTableNo.Delete(nLoop);
              vExist := True;
              Break;
            end;
          end;
          if not vExist then
          begin
            (Sender as TPosButton).Caption := '예약';
            SetImageButton( (Sender as TPosButton).Number.Number, true);
            Common.BookingTableNo.Add(IntToStr((Sender as TPosButton).Number.Number));
          end;
          (Sender as TPosButton).Refresh;
          Exit;
          Action6.Execute;
        end;
      tbmDutchPay :
        begin
          if not Common.CheckTable('A',Common.Table.Number) then
          begin
            TableMode := tbmNone;
            SetOrderInfo;
            Exit;
          end;

          OpenQuery('select * '
                   +'  from SL_ORDER_H  '
                   +' where CD_STORE =:P0 '
                   +'   and NO_TABLE =:P1 '
                   +'   and DS_ORDER =''T'' ',
                   [Common.Config.StoreCode,
                    Common.Table.Number]);
          if Common.Query.FieldByName('amt_dc').AsInteger + Common.Query.FieldByName('amt_codedc').AsInteger + Common.Query.FieldByName('dc_menu').AsInteger > 0 then
            Common.ErrBox('할인내역이 있는 테이블은'#13#13+'더치페이를 할 수 없습니다')
          else if TPosButton(Sender).Bottom.CenterString <> '' then
            Common.ErrBox('그룹이 지정된 테이블은'+#13#13+'더치페이를 할 수 없습니다')
          else
          begin
            if Assigned(Order_F) then
              FreeAndNil(Order_F);
            //테이블을 사용 상태로 변경한다
            ExecQuery('update SL_ORDER_H '
                     +'   set TABLE_STATE = ''Y'' '
                     +' where CD_STORE =:P0 '
                     +'   and NO_TABLE =:P1',
                     [Common.Config.StoreCode,
                      Common.Table.Number]);
            DutchPay_F := TDutchPay_F.Create(Self);
            try
              DutchPay_F.ShowModal;
            finally
              FreeAndNil(DutchPay_F);
              //테이블을 사용 상태로 변경한다
              ExecQuery('update SL_ORDER_H '
                       +'   set TABLE_STATE = ''O'' '
                       +' where CD_STORE =:P0 '
                       +'   and NO_TABLE =:P1',
                       [Common.Config.StoreCode,
                        Common.Table.Number]);
              if not Assigned(Order_F) then
                Order_F := TOrder_F.Create(Self);
            end;
          end;
          TableMode := tbmNone;
          Common.OrderKind := okNew;
          SetOrderInfo;
          Exit;
        end;
      tbmClear :
      begin
        ExecQuery('update MS_TABLE '
                 +'   set YN_TABLEHOLD = ''N'' '
                 +' where CD_STORE =:P0 '
                 +'   and NO_TABLE =:P1',
                 [Common.Config.StoreCode,
                  Common.Table.Number]);
        TableMode := tbmNone;
        ExecOrderInfo;
        Exit;
      end;
    end;
    isTableRefresh := false;

    //CID연동을 잠시 끊는다
    Common.Device.OnCidReadData := nil;
    visOK := false;
    //주문화면으로 가면 테이블조회를 하지 않는다
    try
      if TPosButton(Sender).Amount.Caption = '[이용중]' then
      begin
        Common.ErrBox('테이블정리를 먼저 해야합니다');
        Exit;
      end;
      //푸드코트 + 층별 VAN다르게
      if (GetOption(231)='1') and (GetOption(267)='1') and (Length(Common.Table.Corner)<> 6) then
      begin
        Common.ErrBox('층에 코너가 설정되어 있지 않습니다');
        Exit;
      end;

      if not Common.Config.IsKiosk and (GetOption(375) = '1') and (Common.PosType <> ptOnlyOrder) then
        Common.PosAutoCloseOpen;


      {테이블그룹상태}
      TableMode := tbmNone;
      vTemp     := TPosButton(Sender).Bottom.CenterString;
      Common.Table.Packing    := TPosButton(Sender).Temp4;
      Common.Table.OrderType  := 'T';
      if vTemp = '' then
        Common.Table.GroupType := 'N'
      else if vTemp = 'G-M' then
        Common.Table.GroupType := 'M'
      else
        Common.Table.GroupType := Copy( vTemp, POS('-', vTemp)+1, Length(vTemp) );

      Screen.Cursor    := crHourGlass;
      try
        OpenQuery('select NO_TABLE_GROUP '
                 +' from MS_TABLE '
                 +'where CD_STORE =:P0 '
                 +'  and NO_TABLE =:P1 ',
                 [Common.Config.StoreCode,
                  Common.Table.Number]);
        vGroupNo := Common.Query.Fields[0].AsInteger;
        Common.Query.Close;
        //그룹마스터일때
        if (vGroupNo > 0) and (vGroupNo = Common.Table.Number) then
        begin
          OpenQuery('select COUNT(*) '
                   +'  from SL_ORDER_H a inner join '
                   +'       MS_TABLE   b on a.CD_STORE =b.CD_STORE '
                   +'                   and a.NO_TABLE =b.NO_TABLE '
                   +' where a.CD_STORE     =:P0 '
                   +'   and a.DS_ORDER     =''T'' '
                   +'   and a.TABLE_STATE  =''Y'' '
                   +'   and b.NO_TABLE     <> b.NO_TABLE_GROUP '
                   +'   and b.NO_TABLE_GROUP = :P1 ',
                   [Common.Config.StoreCode,
                    Common.Table.Number]);
           if Common.Query.Fields[0].AsInteger > 0 then
           begin
             Screen.Cursor    := crDefault;
             Common.MsgBox('그룹디테일 테이블이 사용 중 입니다');
             Exit;
           end;
        end
        else
        begin
          OpenQuery('select COUNT(*) '
                   +'  from SL_ORDER_H '
                   +' where CD_STORE     =:P0 '
                   +'   and DS_ORDER     =''T'' '
                   +'   and TABLE_STATE  =''Y'' '
                   +'   and NO_TABLE     = :P1 ',
                   [Common.Config.StoreCode,
                    vGroupNo]);
           if Common.Query.Fields[0].AsInteger > 0 then
           begin
             Screen.Cursor    := crDefault;
             Common.MsgBox('그룹마스터 테이블이 사용 중 입니다');
             Exit;
           end;
        end;

        Common.Query.Close;
        OpenQuery('select LAST_POS '
                 +'  from SL_ORDER_H '
                 +' where CD_STORE     =:P0 '
                 +'   and DS_ORDER     =''T'' '
                 +'   and NO_TABLE     = :P1 '
                 +'   and Ifnull(YN_SALE,'''')  <> ''Y'' '
                 +'   and IFNULL(TABLE_STATE, ''N'') = ''Y'' ',
                 [Common.Config.StoreCode,
                  Common.Table.Number]);

        if not Common.Query.Eof and (Common.Config.PosNo <> Common.Query.Fields[0].AsString) then
        begin
          Screen.Cursor    := crDefault;
          Common.MsgBox(Format('%s 포스에서 사용 중입니다',[Common.Query.Fields[0].AsString]));
          Exit;
        end;

        if WaitOrderTableNo > 0 then
        begin
          Common.Table.WaitTableNo := WaitOrderTableNo;
          WaitOrderTableNo         := 0;
          ExecQuery('update SL_ORDER_D '
                   +'   set NO_TABLE = :P2 '
                   +' where CD_STORE =:P0 '
                   +'   and DS_ORDER =''T'' '
                   +'   and NO_TABLE =:P1 ',
                   [Common.Config.StoreCode,
                    Common.Table.WaitTableNo,
                    Common.Table.Number]);
          ExecQuery('update SL_ORDER_H '
                   +'   set NO_TABLE = :P2 '
                   +' where CD_STORE =:P0 '
                   +'   and DS_ORDER =''T'' '
                   +'   and NO_TABLE =:P1 ',
                   [Common.Config.StoreCode,
                    Common.Table.WaitTableNo,
                    Common.Table.Number]);

          ExecQuery('update SL_CARD_AHEAD '
                   +'   set NO_TABLE = :P2 '
                   +' where CD_STORE =:P0 '
                   +'   and NO_TABLE =:P1 ',
                   [Common.Config.StoreCode,
                    Common.Table.WaitTableNo,
                    Common.Table.Number]);

          //렛츠오더 사용시
          if GetHeadOption(9) = '1' then
            ExecQueryEx('insert into TR_ORDER(CD_STORE, '
                       +'                     GROUP_SEQ, '
                       +'                     GROUP_STEP, '
                       +'                     DS_ORDER, '
                       +'                     NO_TABLE, '
                       +'                     NO_TABLE_TO, '
                       +'                     ORDER_DEVICE) '
                       +'              values(:P0, '
                       +'                     GetNextVal(''TR_ORDER''), '
                       +'                      0, '
                       +'                      ''M'', '
                       +'                      :P1, '
                       +'                      :P2, '
                       +'                      ''P'');',
                       [Common.Config.StoreCode,
                        Common.Table.WaitTableNo,
                        Common.Table.Number]);
        end;

        Common.Query.Close;
        OpenQuery('select a.*, '
                 +'       b.NM_SAWON as NM_DAMDANG '
                 +'  from SL_ORDER_H a left outer join '
                 +'       MS_SAWON   b on b.CD_STORE = a.CD_STORE '
                 +'                   and b.CD_SAWON = a.CD_DAMDANG '
                 +' where a.CD_STORE     =:P0 '
                 +'   and a.DS_ORDER     =:P1 '
                 +'   and a.NO_TABLE     =:P2 ',
                 [Common.Config.StoreCode,
                  Common.Table.OrderType,
                  Common.Table.Number]);


        ExecQuery('insert into SL_ORDER_H(CD_STORE, '
                 +'                       NO_TABLE, '
                 +'                       DS_ORDER, '
                 +'                       TABLE_STATE, '
                 +'                       LAST_POS, '
                 +'                       CNT_PERSON, '
                 +'                       COME_TIME, '
                 +'                       YN_NEWORDER) '
                 +'               values(:P0, '
                 +'                      :P1, '
                 +'                      :P2, '
                 +'                      :P3, '
                 +'                      :P4, '
                 +'                      1, '
                 +'                      Now(), '
                 +'                      ''Y'') '
                 +' ON DUPLICATE KEY UPDATE TABLE_STATE = :P3, '
                 +'                         LAST_POS    = :P4, '
                 +'                         YN_NEWORDER = ''N'' ',
                 [Common.Config.StoreCode,
                  Common.Table.Number,
                  Common.Table.OrderType,
                  'Y',
                  Common.Config.PosNo]);

        if not Common.Query.Eof then
        begin
          Common.Table.MemberCode    := Common.Query.FieldByName('CD_MEMBER').AsString;
          Common.Table.BookingNo     := Common.Query.FieldByName('NO_BOOKING').AsString;
          Common.Table.CustomerCount := Common.Query.FieldByName('CNT_PERSON').AsInteger;
          Common.Table.CustCode      := Common.Query.FieldByName('CD_CUSTOMER').AsString;
          Common.SetAgeInfo( Common.Query.FieldByName('CD_AGE').AsString );
          Common.Table.Date        := FormatDateTime('yyyymmdd',Common.Query.FieldByName('COME_TIME').AsDateTime);
          Common.ComeDateTime      := Common.Query.FieldByName('COME_TIME').AsDateTime;
          Common.Table.isCashOrder := Common.Query.FieldByName('YN_CASHORDER').AsString = 'Y';

          if Common.Table.Date = EmptyStr then
          begin
            Common.Table.Date := FormatDateTime('yyyymmdd', now());
            Common.Table.Time := FormatDateTime('hh:nn', now());
          end
          else
          begin
            vTemp := Copy((Sender as TPosButton).Temp6,2,5);
            Common.Table.Time := Ifthen(vTemp=EmptyStr, FormatDateTime('hh:nn', now()), vTemp);
          end;

          Common.Table.DamdangCode := Trim(Common.Query.FieldByName('CD_DAMDANG').AsString);
          Common.Table.DamdangName := Common.Query.FieldByName('NM_DAMDANG').AsString;
          Common.Table.DcCode      := Common.Query.FieldByName('CD_CODE').AsString;
          Common.Table.Dc_Rate     := Common.Query.FieldByName('RT_DC').AsCurrency;
          Common.Table.Dc_Amt      := Common.Query.FieldByName('AMT_DC').AsInteger;
          Common.Table.Dc_Menu     := Common.Query.FieldByName('DC_MENU').AsInteger;
          Common.Table.Dc_CodeAmt  := Common.Query.FieldByName('AMT_CODEDC').AsInteger;
          Common.Table.DsCust      := Common.Query.FieldByName('DS_CUST').AsString;
          Common.Table.Memo        := Common.Query.FieldByName('MEMO_TXT').AsString;
          Common.Table.LetsOrder   := Common.Query.FieldByName('YN_LETSORDER').AsString;
          vResult := 'U';
        end
        else
        begin
          Common.ComeDateTime      := Now();
          Common.SetAgeInfo('');
          vResult := 'I';
        end;
        Common.Query.Close;
      except
        on E: Exception do
        begin
          Screen.Cursor    := crDefault;
          Common.WriteLog('Table001',E.Message);
          Common.ErrBox(E.Message);
          Exit;
        end;
      end;

      if Common.Table.isCashOrder then
        Common.MsgBox('태블릿에서 현금결제를'#13'요청한 테이블입니다');

      if Trim(Common.Table.Date) = '' then
        Common.Table.Date := FormatDateTime('yyyymmdd', now());
      if Trim(Common.Table.Time) = '' then
        Common.Table.Time := FormatDateTime('hh:nn', now());

      if vResult = 'I' then
      begin
        Common.OrderKind := okNew;
        //푸드기능을 사용하지 않을때
        if GetOption(254) = '1' then
        begin
          //주문시 고객정보를 입력받을때
          if GetOption(14) = '0' then vOption := 0
          else                        vOption := 3;
        end
        else
          vOption := StoI(GetOption(14));

        case vOption of
          1 : //고객수를 입력받음
          begin
            vTemp := Common.ShowNumberForm('고객수를 입력하세요',0,999,'0');
            if vTemp = 'mrClose' then
              vTemp := '0';

            Common.Table.CustomerCount := StoI(vTemp);
            if (Common.Table.CustomerCount = 0) and (GetOption(307) = '0') then
            begin
              Common.Table.CustomerCount := 1;
              if Common.Table.AgeCode.Count > 0 then
                Common.Table.AgeCode.Strings[0] := Copy(Common.Table.AgeCode.Strings[0],1,3) + FormatFloat('000', Common.Table.CustomerCount);
            end
            else if (Common.Table.CustomerCount > 0) and (Common.Table.AgeCode.Count > 0) then
              Common.Table.AgeCode.Strings[0] := Copy(Common.Table.AgeCode.Strings[0],1,3) + FormatFloat('000', Common.Table.CustomerCount);
          end;
          2 : //고객성향을 입력받음
          begin
            Common.ShowCustomerInfo;
          end;
          3,4,5 : //테이블 담당자를 입력받음
          begin
            //외식기능을 사용하지 않을때 연령대코드가 있으면 연령대,고객수 정보를 기본셋팅하지 않는다
            if (GetOption(254) = '1') and (Common.AgeData.Count > 0) then
              Common.Table.AgeCode.Clear;
            Common.ShowChooseForm('T','',Common.Table.DamdangCode, Common.Table.DamdangName );
            if GetOption(254) = '0' then
            case vOption of
              4 :
              begin
                vTemp := Common.ShowNumberForm('고객수를 입력하세요',0,999,'0');
                if vTemp = 'mrClose' then
                  vTemp := '0';

                Common.Table.CustomerCount := StoI(vTemp);
                if (Common.Table.CustomerCount = 0) and (GetOption(307) = '0') then
                begin
                  Common.Table.CustomerCount := 1;
                  if Common.Table.AgeCode.Count > 0 then
                    Common.Table.AgeCode.Strings[0] := Copy(Common.Table.AgeCode.Strings[0],1,3) + FormatFloat('000', Common.Table.CustomerCount);
                end
                else if (Common.Table.CustomerCount > 0) and (Common.Table.AgeCode.Count > 0) then
                  Common.Table.AgeCode.Strings[0] := Copy(Common.Table.AgeCode.Strings[0],1,3) + FormatFloat('000', Common.Table.CustomerCount);
              end;
              5 : begin
                    Common.ShowCustomerInfo;
                    if (Common.Table.CustomerCount = 0) and (GetOption(307) = '0') then
                    begin
                      Common.Table.CustomerCount := 1;
                      if Common.Table.AgeCode.Count > 0 then
                        Common.Table.AgeCode.Strings[0] := Copy(Common.Table.AgeCode.Strings[0],1,3) + FormatFloat('000', Common.Table.CustomerCount);
                    end;
                  end;
              else
              begin
                if (GetOption(307) = '0') then
                begin
                  Common.Table.CustomerCount := 1;
                  if Common.Table.AgeCode.Count > 0 then
                    Common.Table.AgeCode.Strings[0] := Copy(Common.Table.AgeCode.Strings[0],1,3) + FormatFloat('000', Common.Table.CustomerCount);
                end;
              end;
            end;
          end;
          else if (GetOption(307) = '0') then
          begin
            Common.Table.CustomerCount := 1;
            if Common.Table.AgeCode.Count > 0 then
              Common.Table.AgeCode.Strings[0] := '000' + FormatFloat('000', Common.Table.CustomerCount);
          end;
        end;
      end
      else
      begin
        //주문시마다 담당자를 입력한다고 설정했으면
        if GetOption(37) = '1' then
        begin
          Common.ShowChooseForm('T','',Common.Table.DamdangCode, Common.Table.DamdangName);
          Common.WriteLog('work', Format('담당자 [%s]', [Common.Table.DamdangName]));
        end;
        Common.OrderKind := okAppend;
      end;

      if (Common.Table.CustomerCount = 0) and (GetOption(307) = '0') then
        Common.Table.CustomerCount := 1;

      try
        Common.Table.BookingImg := (Sender as TPosButton).Number.CenterString;
        //예약손님여부 확인
        if (Common.OrderKind = okNew) and (Common.Table.BookingImg = '☎') then
        begin
          if Common.AskBox('예약손님이 맞습니까?') then
          begin
            Common.Table.BookingNo := vBookingNo;
            OpenQuery('select AMT_BOOKING, '
                     +'       REMARK '
                     +'  from SL_BOOKING  '
                     +' where CD_STORE   =:P0 '
                     +'   and NO_BOOKING =:P1 ',
                     [Common.Config.StoreCode,
                      Common.Table.BookingNo ]);
            Common.Table.BookingAmt := Common.Query.Fields[0].AsInteger;

            if Trim(Common.Query.Fields[1].AsString) <> '' then
              Common.MsgBox(Common.Query.Fields[1].AsString);

            ExecQueryEx('update SL_ORDER_H '
                       +'   set NO_BOOKING =:P2 '
                       +' where CD_STORE   =:P0 '
                       +'   and NO_TABLE   =:P1 '
                       +'   and DS_ORDER   = ''T'';',
                       [Common.Config.StoreCode,
                        Common.Table.Number,
                        Common.Table.BookingNo ]);
            ExecQueryEx('update SL_BOOKING '
                       +'   set YN_SALE    =''Y'' '
                       +' where CD_STORE   =:P0 '
                       +'   and NO_BOOKING =:P1;',
                       [Common.Config.StoreCode,
                        Common.Table.BookingNo ]);
          end;
        end;

        //계산완료 후 깜박임
        if GetOption(360) <> '0' then
        begin
          TableMark := false;
          ExecQueryEx('update MS_TABLE '
                     +'   set DT_ACCT_LAST =null '
                     +' where CD_STORE =:P0 '
                     +'   and NO_TABLE =:P1;',
                     [Common.Config.StoreCode,
                      Common.Table.Number]);
        end;

        Screen.Cursor := crDefault;
        Common.ShowSaleDualScreen;
        if Common.SQLBuffer <> '' then
          ExecQueryEx('',[],true);
        //푸드코트 + 층별 VAN다르게
        if (GetOption(231)='1') and (GetOption(267)='1') then
          Common.SetCornerCardInfo(Common.Table.Corner);

        if not Assigned(Order_F) then
           Order_F := TOrder_F.Create(Self);

        if Order_F.ShowModal = mrOK then
        begin
          if GetOption(321) = '1' then
          begin
            //최종주문 테이블 색상을 변경하기 위함
            Common.LastOrderTableButton := (Sender as TPosButton);
            Common.LastOrderTableNo     := Common.LastOrderTableButton.Number.Number;
            Common.LastOrderFloor       := Common.Table.Floor;
            Common.LastOrderTime        := now();
          end;
          Common.TRSendMessage;
        end
        else
        begin
          visOK := true;
          Common.LastOrderTableButton := nil;
          Common.LastOrderTableNo     := 0;
          Common.LastOrderFloor       := EmptyStr;
        end;
      except
        on E: Exception do
        begin
          Common.WriteLog('TableButtonClick',E.Message);
          Common.ErrBox(E.Message);
          Exit;
        end;
      end;
    finally
      ExecQuery('insert into SL_ORDER_LOG(CD_STORE, '
               +'                					NO_POS,'
               +'                					DT_CHANGE) '
               +'              	   select CD_STORE, '
               +'                         NM_CODE1, '
               +'                         Now() '
               +'             	     from MS_CODE '
               +'             	    where CD_STORE = :P0 '
               +'             		    and CD_KIND   = ''01'' '
               +'             		    and NM_CODE1 not in (select NO_POS '
               +'                                            from SL_ORDER_LOG '
               +'                                           where CD_STORE =:P0) ',
               [Common.Config.StoreCode]);

      Common.Table.Floor     := vFloor;
      Common.Table.FloorName := vFloorName;
      isTableRefresh := true;
      SetOrderInfo(true);
      //바로 다시 리플래쉬되는 현상 방지
      isTableRefresh := false;
      Tmr_Time.Tag := 1;
      Common.ShowNormalDualScreen;
      Common.OrderKind      := okNone;
      vTableMark            := TableMark;
      TableMode             := tbmNone;
      TableMark             := vTableMark;
      if CardMsg <> '' then
      begin
        Tmr_Msg.Tag          := 0;
        Tmr_Msg.Enabled      := True;
        MessageLabel.Caption := Common.GetPaPago(CardMsg);
        CardMsg              := '';
      end;
    end;
  finally
    BlockInput(false);
    isTableRefresh  := true;
    if Common.Config.Cid_Port > 0 then
      Common.Device.OnCidReadData :=CidReadEvent;
    Common.Config.UserWork := String(Common.Config.LoginUserWork);
    ExecQuery('delete '
             +'  from MS_UPLOAD '
             +' where CD_STORE =:P0 '
             +'   and NM_TABLE =''SL_ORDER_H'' ',
             [Common.Config.StoreCode]);

    ExecQuery('insert into MS_UPLOAD(CD_STORE, '
             +'                      NM_TABLE, '
             +'                      YMD_SALE, '
             +'                      PK, '           //ALL
             +'                      DS_STATUS, '    //A
             +'                      DT_INSERT) '
             +'              values (:P0, '
             +'                     ''SL_ORDER_H'', '
             +'                      Date_Format(NOW(), ''%Y%m%d''), '
             +'                      :P1, '
             +'                      ''A'', '
             +'                      NOW()) '
             +' ON DUPLICATE KEY UPDATE DT_INSERT = NOW()',
             [Common.Config.StoreCode,
              'ALL']);
    Common.TRSendMessage;
    Application.ProcessMessages;
  end;
end;

procedure TTable_F.SetOrderInfo(aMust:Boolean=false);
label retry;
begin
  retry:
  isOrderInfoWorking := false;
  try
    if not aMust and (Assigned(Order_F) and Order_F.Showing and Order_F.Active) then Exit;

    if not aMust and not Table_F.Active then Exit;

    ExecOrderInfo;
  except
  end;
  if isOrderInfoWorking then
    goto retry;
end;

{------------------------------------------------------------------------------}
{ 테이블 주문정보 셋팅                                                         }
{------------------------------------------------------------------------------}
procedure TTable_F.ExecOrderInfo;
  procedure SetPosButton(aTableNo,aOrderAmt:Integer; aAmnt,aCount,aTime,aState,aBooking,aBookingNo,aBookingImg,aBookingName,aBookingRemark, aGroup, aMenuName, aMenuQty, aDamdang, aTableName,
                         aColor, aBorderColor, aNumberColor, aFontColor, aBottomColor, aNoColor, aBorderNoColor, aFontNoColor, aLastOrderTime:String; aLapse:Integer; aTableColor:String;
                         aOrderSeq, aColorMenu, aPGTable:Integer; aCashOrder:String; aLetsOrderTable:Integer; aLetsOrderTime, aTableHold:String);
    function CheckChange(aButton:TPosButton):Boolean;
    begin
      Result := True;
      if aButton.Color                <> FTempButton.Color           then Exit;
      if aButton.Number.Color         <> FTempButton.Number.Color         then Exit;
      if aButton.Caption              <> FTempButton.Caption then Exit;
      if aButton.Bottom.CenterString  <> FTempButton.Bottom.CenterString  then Exit;
      if aButton.Menu.Name            <> FTempButton.Menu.Name     then Exit;
      if aButton.Menu.Qty             <> FTempButton.Menu.Qty      then Exit;
      if aButton.Amount.Caption       <> FTempButton.Amount.Caption       then Exit;
      if aButton.Number.CenterString  <> FTempButton.Number.CenterString  then Exit;
      if aButton.Bottom.LeftString    <> FTempButton.Bottom.LeftString    then Exit;
      if aButton.Number.NumberString  <> FTempButton.Number.NumberString  then Exit;
      if (aButton.Number.RightString  <> FTempButton.Number.RightString)   then Exit;
      if aButton.Bottom.RightString   <> FTempButton.Bottom.RightString   then Exit;
      if aButton.Temp2                <> FTempButton.Temp2                then Exit;
      if aButton.Temp3                <> FTempButton.Temp3                then Exit;
      Result := False;
    end;
  var vIndex, vTemp :Integer;
      vBooking :String;
      visChange :Boolean;
  begin
    //고객수를 사용하지않을때
    if (GetOption(14) = '0') and (GetOption(254) = '0') then  aCount := '';

    for vIndex := 0 to ComponentCount-1 do
    begin
      if (Components[vIndex] is TPosButton) and
         ( (Components[vIndex] as TPosButton).Parent = TablePanel ) and
         ( (Components[vIndex] as TPosButton).Number.Number = ATableNo ) and
         ( (Components[vIndex] as TPosButton).Tag = 0 )then
      begin
        {[99:99]이면 빈테블}
        if (aTime <> '[99:99]') or (aLetsOrderTable > 0) or (aTableHold = 'Y') then
        begin
          if (aTime = '[99:99]') and (aLetsOrderTable > 0) then
            aTime := aLetsOrderTime;

          FTempButton.Bottom.Color := (Components[vIndex] as TPosButton).Bottom.Color;
          if (Components[vIndex] as TPosButton).Temp7 = 'Y' then
          begin
            TAdvSmoothButton(FindComponent(Format('TableImageButton%d',[aTableNo]))).Visible := false;
            (Components[vIndex] as TPosButton).Visible     := true;
          end;
          (Components[vIndex] as TPosButton).Temp8 := 'Y';                 //주문중인 테이블 설정
          FTempButton.Font.Color          := StringToColor(aFontColor);
          FTempButton.Number.Font.Color   := StringToColor(aFontColor);
          FTempButton.Bottom.Font.Color   := StringToColor(aBottomColor);

          if aTableColor = '' then
            FTempButton.Color      := StringToColorDef(aColor, (Components[vIndex] as TPosButton).Color)
          else
            FTempButton.Color      := StringToColorDef(aTableColor, (Components[vIndex] as TPosButton).Color);

          FTempButton.BorderColor  := StringToColorDef(aBorderColor, (Components[vIndex] as TPosButton).BorderColor);
          FTempButton.BorderInnerColor := clNone;
          FTempButton.Bottom.Color := FTempButton.Color;

          //특정메뉴 주문시 테이블 색상변경
          if (aColorMenu > 0) and (Common.TableMenuColor <> EmptyStr) then
            FTempButton.Color := StringToColor(Common.TableMenuColor);

          if ((Components[vIndex] as TPosButton).GroupIndex >= 1) then
            FTempButton.Bottom.Color  := Common.GroupColor[(Components[vIndex] as TPosButton).GroupIndex-1];

          //그룹정보
          FTempButton.Bottom.CenterString    := AGroup;
          FTempButton.Bottom.ShowColor       := AGroup <> EmptyStr;
          {주문금액이 있고 사용중일때}
          if ( (Components[vIndex] as TPosButton).Menu.Name <> AAmnt ) or
             ( AState = 'O' ) or
             ( (Components[vIndex] as TPosButton).Number.Number = Common.Table.Number) then
          begin

            FTempButton.Number.TempString := ATableName;

            //테이블명을 보인다고 설정했을때
            if GetOption(25) = '1' then
            begin
              //주문내역을 출력하지 않을때
              if (GetOption(24) = '0') then
              begin
                FTempButton.Caption := '';
                //테이블명을 좌측상단에 표시할때
                if GetOption(174) = '0' then
                begin
                  FTempButton.Caption := aTableName;
                  FTempButton.Number.NumberString  := '' ;
                end
                else
                begin
                  FTempButton.Number.NumberString  := ' '+ATableName ;
                end;
                FTempButton.Temp3                := IntToStr(AOrderAmt);
                FTempButton.Number.ShowColor     := True;
              end
              else
              //주문내역을 보일때
              begin
                FTempButton.Caption := '';
                FTempButton.Menu.Name            := aMenuName;
                FTempButton.Menu.Qty             := aMenuQty;
                FTempButton.Temp3                := IntToStr(AOrderAmt);
                FTempButton.Number.ShowColor     := True;
                FTempButton.Number.NumberString  := ' '+ATableName;
              end;
            end
            else
            begin
              //주문내역을 출력하지 않을때
              if (GetOption(24) = '0') then
              begin
                FTempButton.Caption              := '';
                FTempButton.Number.NumberString  := ' '+ATableName;
                FTempButton.Menu.Name            := EmptyStr;
                FTempButton.Menu.Qty             := EmptyStr;
                FTempButton.Temp3                := IntToStr(AOrderAmt);
                FTempButton.Number.ShowColor     := True;
              end
              else
              begin
                FTempButton.Caption := '';
                FTempButton.Menu.Name            := aMenuName;
                FTempButton.Menu.Qty             := aMenuQty;
                FTempButton.Temp3                := IntToStr(AOrderAmt);
                FTempButton.Number.ShowColor     := True;
                FTempButton.Number.NumberString  := ' '+ATableName;
              end;
            end;

            //마지막 주문시간
            case StoI(GetOption(237)) of
              0 : FTempButton.Bottom.RightString   := '';
              1 : FTempButton.Bottom.RightString   := ALastOrderTime;
              2 : //주문순번
              begin
                if aOrderSeq > 0 then
                  FTempButton.Bottom.RightString := Format('[%d]', [aOrderSeq]);
              end;
              3 :
              begin
                if GetOption(175) = '0' then
                  FTempButton.Bottom.RightString := aAmnt;
                FTempButton.Amount.Caption     := '';
              end;
              4 : FTempButton.Bottom.RightString := aDamdang;
            end;

            if (GetOption(237) <> '3') and (GetOption(175) = '0') then
              FTempButton.Amount.Caption := aAmnt;


            FTempButton.Temp2 := FTempButton.Bottom.RightString;
            //예약정보
            if ABooking <> '' then
              vBooking := ABookingImg+'('+ABooking+')'
            else
              vBooking := '';
            FTempButton.Number.CenterString  := vBooking;
            FTempButton.Hint                 := aBookingNo;

            //고객수
            FTempButton.Bottom.LeftString    := aCount;

            //입장시간은 표시안하고 경과시간만 표시할때
            if (GetOption(378)='1') and (GetOption(59)='1') then
            begin
              if ALapse > 60 then
                FTempButton.Number.RightString := Format('%d:%d',[ALapse div 60, ALapse mod 60])
              else
                FTempButton.Number.RightString := Format('%d분',[ALapse]);
            end
            else if GetOption(59)='1' then
            begin
              if ALapse > 60 then
                FTempButton.Number.RightString := Format('%d:%d',[ALapse div 60, ALapse mod 60])+aTime
              else if (aLapse >= 1) then
                FTempButton.Number.RightString := Format('%d분',[ALapse])+aTime
              else
                FTempButton.Number.RightString := aTime;
            end
            else
              FTempButton.Number.RightString   := Ifthen(GetOption(378)='0', aTime,'') ;

            //주문시 사용
            FTempButton.Temp6 := aTime;

            FTempButton.Temp9 := aDamdang;
            //주문순번표시

            //사용중인 테이블인지  )2023.7.26 표지하지 않도록 수정
//            if aState = 'Y' then
//            begin
//              if GetOption(14) in ['3','4','5'] then
//                FTempButton.Number.RightString := '사용중'
//              else
//                FTempButton.Bottom.RightString   := '사용중';
//              FTempButton.Temp2                 := '사용중';
//            end;

            if (Common.Config.Red_Hour > 0) and (aLapse > Common.Config.Red_Hour) then
              FTempButton.Number.Color := StringToColorDef(Common.Config.TableChangeColor, StringToColor(aNumberColor))
            else
              FTempButton.Number.Color := StringToColor(aNumberColor);

            //렛츠오더에서 결제가 끝났을때
            if ((aPGTable > 0) and (aOrderAmt = 0)) or ((aOrderAmt = 0) and (aLetsOrderTime <> '') and (aLetsOrderTable > 0)) then
            begin
              FTempButton.Amount.Caption    := '[결제완료]';
              FTempButton.BorderInnerColor  := clRed;
              FTempButton.BorderColor       := clRed;
              FTempButton.Amount.Font.Color := clRed;
              //결제완료 시 주문내역표시 안함
              if GetOption(402) = '1' then
              begin
                FTempButton.Menu.Name := '';
                FTempButton.Menu.Qty  := '';
              end;
            end;

            //태블릿에서 현금결제 요청한 테이블일때
            if aCashOrder = 'Y' then
            begin
              FTempButton.Amount.Caption    := '[현금요청]';
              FTempButton.BorderInnerColor  := clRed;
              FTempButton.BorderColor       := clRed;
              FTempButton.Amount.Font.Color := clRed;
            end;

            if aTableHold = 'Y' then
            begin
              FTempButton.Amount.Caption    := '[이용중]';
              FTempButton.BorderInnerColor  := clRed;
              FTempButton.BorderColor       := clRed;
              FTempButton.Amount.Font.Color := clRed;
              FTempButton.Number.RightString := '';
              FTempButton.Bottom.RightString := '';
            end;

          end;
        end
        else //미주문시
        begin
          FTempButton.Bottom.Color := (Components[vIndex] as TPosButton).Bottom.Color;
          if ((Components[vIndex] as TPosButton).Temp7 = 'Y') and (aGroup = '') then
          begin
            TAdvSmoothButton(FindComponent(Format('TableImageButton%d',[aTableNo]))).Visible := true;
            (Components[vIndex] as TPosButton).Visible     := false;
          end
          else if (Components[vIndex] as TPosButton).Temp7 = 'Y' then
          begin
            TAdvSmoothButton(FindComponent(Format('TableImageButton%d',[aTableNo]))).Visible := false;
            (Components[vIndex] as TPosButton).Visible     := true;
          end;
          (Components[vIndex] as TPosButton).Temp8 := 'N';

          FTempButton.Color            := StringToColorDef(aNoColor, NormalColor) ;
          if aBorderNoColor = 'FFFFFF' then
            FTempButton.BorderColor      := NormalColor
          else
            FTempButton.BorderColor      := StringToColorDef(aBorderNoColor, NormalColor) ;
          FTempButton.BorderInnerColor := clNone;
          if aFontNoColor = 'FFFFFF' then
            FTempButton.Font.Color       := NormalFontColor
          else
            FTempButton.Font.Color       := StringToColorDef(aFontNoColor, NormalFontColor) ;

          if ((Components[vIndex] as TPosButton).GroupIndex >= 1)  then
          begin
            FTempButton.Bottom.Color  := Common.GroupColor[(Components[vIndex] as TPosButton).GroupIndex-1];
          end;

          FTempButton.Bottom.ShowColor  := AGroup <> EmptyStr;
          //테이블명을 사용하고 메뉴내역을 출력하지 않을때
          if (GetOption(25) = '1') and (GetOption(24) = '0') then
          begin
            FTempButton.Number.TempString   := aTableName;
            FTempButton.Number.NumberString := '';
            FTempButton.Caption := aTableName;
            if ABookingImg = '☎' then
            begin
              if (GetOption(206) = '1') and (Trim(ABookingRemark) <> '') then
                FTempButton.Amount.Caption := '예약석['+ABookingName+']'+ #13 + ABookingRemark
              else
                FTempButton.Amount.Caption := '예약석['+ABookingName+']';
            end
            else
              FTempButton.Amount.Caption := aTableName;
          end
          else
          begin
            FTempButton.Number.NumberString  := '';
            FTempButton.Number.TempString    := aTableName;
            if ABookingImg = '☎' then
            begin
              if (GetOption(206) = '1') and (Trim(ABookingRemark) <> '') then
                FTempButton.Caption := '예약석'+#13+'['+ABookingName+']'+#13#13+ Trim(ABookingRemark)
              else
                FTempButton.Caption := '예약석'+#13+'['+ABookingName+']';
            end
            else
              FTempButton.Caption := aTableName;
          end;

          FTempButton.Font.Size :=  Common.FloorData[GetFloorIndex(Common.Table.Floor)].TableNumberSize;
          if FTempButton.Font.Size < 5 then
            FTempButton.Font.Size := 13;

          FTempButton.Number.ShowColor        := False;
          FTempButton.Number.CenterString  := aBookingImg;
          FTempButton.Number.RightString   := aBooking;
          if ABookingImg = '☎' then
            FTempButton.Temp1                 := aBookingNo;
          FTempButton.Menu.Name               := '';
          FTempButton.Amount.Caption       := '';
          FTempButton.Bottom.LeftString    := '';
          //그룹정보
          FTempButton.Bottom.CenterString  := aGroup;
          FTempButton.Bottom.RightString   := '';
          FTempButton.Temp2                := '';
          FTempButton.Temp3                := '';
          FTempButton.Temp6                := '';
          FTempButton.Temp10               := '';

          //테이블 이미지 사용시
          if ((Components[vIndex] as TPosButton).Temp7 = 'Y') then
          begin
            if (aGroup <> '') then
            begin
              TAdvSmoothButton(FindComponent(Format('TableImageButton%d',[aTableNo]))).Visible := false;
              (Components[vIndex] as TPosButton).Visible := true;
              FTempButton.Visible := true;
            end
            else if aBookingNo <> '' then
            begin
              if GetOption(252) = '0' then
              begin
                TAdvSmoothButton(FindComponent(Format('TableImageButton%d',[aTableNo]))).Status.Caption := Format('%s(예약석)',[aTableName]);
                TAdvSmoothButton(FindComponent(Format('TableImageButton%d',[aTableNo]))).Caption := '';
              end
              else
              begin
                TAdvSmoothButton(FindComponent(Format('TableImageButton%d',[aTableNo]))).Status.Caption := '';
                TAdvSmoothButton(FindComponent(Format('TableImageButton%d',[aTableNo]))).Caption := Format('%s(예약석)',[aTableName]);
              end;
            end
            else
            begin
              if GetOption(252) = '0' then
              begin
                TAdvSmoothButton(FindComponent(Format('TableImageButton%d',[aTableNo]))).Status.Caption := Format('%s',[aTableName]);
                TAdvSmoothButton(FindComponent(Format('TableImageButton%d',[aTableNo]))).Caption := '';
              end
              else
              begin
                TAdvSmoothButton(FindComponent(Format('TableImageButton%d',[aTableNo]))).Status.Caption := '';
                TAdvSmoothButton(FindComponent(Format('TableImageButton%d',[aTableNo]))).Caption := Format('%s',[aTableName]);
              end;
            end;
            TAdvSmoothButton(FindComponent(Format('TableImageButton%d',[aTableNo]))).Color                 := FTempButton.Color;
            TAdvSmoothButton(FindComponent(Format('TableImageButton%d',[aTableNo]))).BevelColor            := FTempButton.BorderColor;
            TAdvSmoothButton(FindComponent(Format('TableImageButton%d',[aTableNo]))).Appearance.Font.Color := FTempButton.Font.Color;
            TAdvSmoothButton(FindComponent(Format('TableImageButton%d',[aTableNo]))).ShowFocus             := false;
          end;
        end;

        visChange := true;
        if (OrderMemData.RecordCount > 0) and (OrderMemData.Locate('NO_TABLE', aTableNo, [loCaseInsensitive] )) then
        begin
          if (OrderMemData.FieldByName('COME_TIME').AsString = aTime)
           and ((GetOption(378)='1') and (GetOption(59)='1') and (OrderMemData.FieldByName('LAPSE_TIME').AsInteger = aLapse))
           and (OrderMemData.FieldByName('AMT_ORDER').AsInteger = aOrderAmt)
           and (OrderMemData.FieldByName('ORDER_MENU').AsString = aMenuName)
           and (OrderMemData.FieldByName('ORDER_QTY').AsString  = aMenuQty)
           and (OrderMemData.FieldByName('YN_USE').AsString  = FTempButton.Temp2)
           and (OrderMemData.FieldByName('COLOR').AsString  = ColorToString(FTempButton.Color))
           and (OrderMemData.FieldByName('YN_TABLEHOLD').AsString  = aTableHold) then
             visChange := false;

           OrderMemData.Edit;
           OrderMemData.FieldByName('YN_USE').AsString := FTempButton.Temp2;
           OrderMemData.FieldByName('COLOR').AsString  := ColorToString(FTempButton.Color);
           OrderMemData.Post;
        end;

        if visChange or (aGroup <> '') then //CheckChange( (Components[vIndex] as TPosButton) ) then // visChange then
        begin
          (Components[vIndex] as TPosButton).BorderStyle          := pbsSingle;
          (Components[vIndex] as TPosButton).Color                := FTempButton.Color;
          (Components[vIndex] as TPosButton).Font.Color           := FTempButton.Font.Color;
          (Components[vIndex] as TPosButton).Bottom.Color         := FTempButton.Bottom.Color;
          (Components[vIndex] as TPosButton).BorderColor          := FTempButton.BorderColor;
          (Components[vIndex] as TPosButton).BorderInnerColor     := FTempButton.BorderInnerColor;
          (Components[vIndex] as TPosButton).Number.Color         := FTempButton.Number.Color;
          (Components[vIndex] as TPosButton).Number.ShowColor     := FTempButton.Number.ShowColor;
          (Components[vIndex] as TPosButton).Menu.Name            := FTempButton.Menu.Name;
          (Components[vIndex] as TPosButton).Menu.Qty             := FTempButton.Menu.Qty;
          (Components[vIndex] as TPosButton).Amount.Caption       := FTempButton.Amount.Caption;
          (Components[vIndex] as TPosButton).Amount.Font.Color    := FTempButton.Amount.Font.Color;
          (Components[vIndex] as TPosButton).Font.Size            := FTempButton.Font.Size;
          (Components[vIndex] as TPosButton).Caption              := FTempButton.Caption;
          (Components[vIndex] as TPosButton).Bottom.ShowColor     := FTempButton.Bottom.ShowColor;
          (Components[vIndex] as TPosButton).Bottom.CenterString  := FTempButton.Bottom.CenterString;
          (Components[vIndex] as TPosButton).Number.CenterString  := FTempButton.Number.CenterString;
          (Components[vIndex] as TPosButton).Bottom.LeftString    := FTempButton.Bottom.LeftString;
          (Components[vIndex] as TPosButton).Number.RightString   := FTempButton.Number.RightString;
          //테이블 넓이가 100이하이면 입장시간을 표시하지 않는다
          if ((Components[vIndex] as TPosButton).Width < 100) and ((Components[vIndex] as TPosButton).Number.Font.Size > 12) then
            (Components[vIndex] as TPosButton).Number.RightString := EmptyStr;
          (Components[vIndex] as TPosButton).Number.NumberString  := FTempButton.Number.NumberString;
          (Components[vIndex] as TPosButton).Number.TempString    := FTempButton.Number.TempString;
          (Components[vIndex] as TPosButton).Bottom.RightString   := FTempButton.Bottom.RightString;
          (Components[vIndex] as TPosButton).Temp1                := FTempButton.Temp1;           //예약번호
          (Components[vIndex] as TPosButton).Temp2                := FTempButton.Temp2;
          (Components[vIndex] as TPosButton).Temp3                := FTempButton.Temp3;
          (Components[vIndex] as TPosButton).Temp9                := FTempButton.Temp9;
          (Components[vIndex] as TPosButton).Temp10               := FTempButton.Temp10;


          if  (aTime <> '[99:99]') then
          begin
            if (GetOption(25) = '1') and (GetOption(24) = '1') then
            begin
              (Components[vIndex] as TPosButton).Caption := '';
              (Components[vIndex] as TPosButton).Menu.Name := aMenuName;
              (Components[vIndex] as TPosButton).Menu.Qty  := aMenuQty;
            end
            //테이블명을 사용하면서 주문메뉴를 표시하지 않을때
            else if (GetOption(25) = '1') and (GetOption(24) = '0') then
            begin
              (Components[vIndex] as TPosButton).Caption := '';
              (Components[vIndex] as TPosButton).Number.NumberString := '';
              //주문메뉴를 표시하지 않을때
              if (GetOption(24) = '0') then
              begin
                //주문 시 테이블명을 좌측상단에 표시합니다.
                if GetOption(174) = '0' then
                  (Components[vIndex] as TPosButton).Caption := FTempButton.Number.TempString+#13
                else //주문시 테이블명 좌측상단
                begin
                  (Components[vIndex] as TPosButton).Number.NumberString := FTempButton.Number.TempString;
                  (Components[vIndex] as TPosButton).Amount.Caption      := '';
                end;
              end
              else
                (Components[vIndex] as TPosButton).Menu.Name := FTempButton.Number.TempString;
            end;
          end;
        end
        else
          (Components[vIndex] as TPosButton).Bottom.ShowColor       := FTempButton.Bottom.ShowColor;

        Break;
      end;
    end;
  end;
  procedure SetOrderMenu(aTableNo, aAddMenu, aPerson, aLapeTime:Integer;var aMenuName, aMenuQty:String);
  var vIndex :Integer;
      vTemp  :String;
  begin
    DM.OpenQuery('select case when t1.DS_SALE = ''D'' then ConCat(t1.NM_MENU,:P3) '
                +'                                    else t1.NM_MENU '
                +' 		   end as NM_MENU, '
                +'       GetQty(t2.DS_MENU_TYPE, t1.QTY_ORDER) as QTY_ORDER '
                +'  from SL_ORDER_D t1  inner join '
                +'       MS_MENU    t2  on t1.CD_STORE = t2.CD_STORE '
                +'                     and t1.CD_MENU  = t2.CD_MENU '
                +' where t1.CD_STORE	=:P0 '
                +'   and t1.NO_TABLE	=:P1 '
                +'   and t1.DS_ORDER =''T'' '
                +'   and t1.NO_STEP	=0 '
                +Ifthen(GetOption(164)='0','order by t1.SEQ', 'order by t2.BILL_SEQ, t1.SEQ')
                +' limit :P2 ',
                [Common.Config.StoreCode,
                 aTableNo,
                 Common.FloorData[GetFloorIndex(Common.Table.Floor)].MenuCount,
                 Common.Config.ServiceTxt]);
    vIndex := 1;
    aMenuName := EmptyStr;
    aMenuQty  := EmptyStr;
    while not DM.Query.Eof do
    begin
      aMenuName := aMenuName +  Common.GetPaPago(DM.Query.Fields[0].AsString) + #13;
      aMenuQty  := aMenuQty  +  DM.Query.Fields[1].AsString + #13;
      Inc(vIndex);
      DM.Query.Next;
    end;
    //추가요금 표시
    if (aAddMenu > 0) then
    begin
      if aLapeTime > Common.Config.OverTimeTime then
      begin
        if aLapeTime - Common.Config.OverTimeTime > 60 then
          vTemp := Format('(%d시간%d분)',[(aLapeTime - Common.Config.OverTimeTime) div 60, (aLapeTime - Common.Config.OverTimeTime) mod 60])
        else
          vTemp := Format('(%d분)',[aLapeTime - Common.Config.OverTimeTime]);
      end
      else
        vTemp := EmptyStr;

      aMenuName := aMenuName + '추가요금'+vTemp;
      aMenuQty  := aMenuQty  + Ifthen(GetOption(223) = '1', IntToStr(aPerson), '1');
    end;
    DM.Query.Close;
  end;

var vTemp      :String;
    vBooking   :Integer;
    vUseTable  :String;
    vOrderAmt  :Integer;
    vSaleAmt   :Integer;
    vSaleCancelAmt  :Integer;
    vOrderCancelAmt :Integer;
    vTotalAddAmt    :Integer;
    I :Integer;
    vOrderSeq  :Integer;
    vOrderList :TStringList;
    vMenuName,
    vMenuQty :String;
    vIndex :Integer;
begin
  vOrderList := nil;
  vOrderList := TStringList.Create;
  try
    try
      SetTableGroupColor;
     //주문순번을 표시할때
      if GetOption(237) = '2' then
      begin
        DM.OpenQueryEx('select NO_TABLE '
                      +'  from SL_ORDER_H  '
                      +' where CD_STORE =:P0 '
                      +'   and DS_ORDER = ''T'' '
                      +' order by COME_TIME',
                      [Common.Config.StoreCode]);
        while not DM.QueryEx.Eof do
        begin
          vOrderList.Add(DM.QueryEx.Fields[0].AsString);
          DM.QueryEx.Next;
        end;
        DM.QueryEx.Close;
      end;
    except
      on E: Exception do
      begin
        Common.WriteLog('Table005',E.Message+#13+Common.Query.SQL.Text);
        if (Pos('연결을실패했습니다', Replace(E.Message,' ','')) > 0) or (Pos('TCP공급자', Replace(E.Message,' ','')) > 0) then
          Common.LogoClick(nil);
        Exit;
      end;
    end;

    vUseTable    := '';
    vOrderAmt    := 0;
    vTotalAddAmt := 0;
    //저장된 테이블 내역 불러오기

    try
      DM.OpenQueryEx('select a.NO_TABLE, '
                    +'	    	Ifnull(a.COME_TIME, ''99:99'') as COME_TIME, '
                    +'	    	a.AMT_ORDER + Ifnull(a.AMT_ADDMENU,0) as AMT_ORDER, '
                    +'	    	a.CNT_PERSON, '
                    +'	    	Ifnull(a.LAPSE_TIME,0) as LAPSE_TIME, '
                    +'	    	a.DT_BOOKING, '
                    +'	    	a.NO_BOOKING, '
                    +'	    	case when a.GROUP_NO <> '''' and a.GROUP_NO <> ''G-M'' and Ifnull(a.NO_BOOKING,'''') <> '''' then ''☎'' '
                    +'            else a.BOOKING_IMG'
                    +'	    	end BOOKING_IMG, '
                    +'	    	Ifnull(a.TABLE_STATE,'''') as TABLE_STATE, '
                    +'	    	a.GROUP_NAME, '
                    +'	      a.DAMDANG, '
                    +'	    	a.NM_TABLE as TABLENAME, '
                    +'	    	a.COLOR, '
                    +'	    	a.NUMBER_COLOR, '
                    +'        a.FONT_COLOR, '
                    +'        a.BOTTOM_COLOR, '
                    +'        a.BORDER_COLOR, '
                    +'	    	a.COLOR_HEX, '
                    +'	    	a.FONT_COLOR_HEX, '
                    +'	    	a.BORDER_COLOR_HEX, '
                    +'	    	a.NO_RFID, '
                    +'	    	a.NM_NAME, '
                    +'	    	a.REMARK, '
                    +'	    	a.DT_LASTORDER, '
                    +'        a.TABLE_COLOR, '
                    +'	    	a.DS_CUST, '
                    +'        Ifnull(a.AMT_ADDMENU,0) as AMT_ADDMENU, '
                    +'        a.COLOR_MENU, '
                    +'        a.PG_TABLE, '
                    +'        a.YN_CASHORDER, '
                    +'        a.YN_TABLEHOLD, '
                    +'        case when c.NO_TABLE is null or (c.DT_SALE < b.DT_SALE_LETSORDER) then Ifnull(b.NO_TABLE,-1) else -1 end as LETSORDER_TABLE, '
                    +'        Ifnull(b.LETSORDER_TIME,'''') as LETSORDER_TIME '
                    +'	 from '
                    +'		   (select t1.CD_STORE, '
                    +'		  		     t1.CD_FLOOR, '
                    +'		  		     t1.NO_TABLE, '
                    +'		  		     case when COME_TIME IS NULL then ''99:99'' '
                    +'		  		     		  else Date_Format(t2.COME_TIME, ''%H:%i'')'
                    +'		  		     end as COME_TIME, '
                    +'               t2.AMT_ORDER as AMT_ORDER, '
                    +'		  	       Ifnull(t2.CNT_PERSON, 	1) 	as CNT_PERSON, '
                    +'		  		     TIMESTAMPDIFF(MINUTE,  COME_TIME, Now() ) as LAPSE_TIME, '
                    +'		  		     Ifnull(Date_Format(t3.DT_BOOKING, ''%H:%i''), '''')  as DT_BOOKING, '
                    +'		  		     Ifnull(t3.NO_BOOKING, '''')  as NO_BOOKING, '
                    +'		  		     case  when Ifnull(t3.NO_BOOKING, '''') <>  '''' then	''☎'' '
                    +'		  		     	     else '''' '
                    +'		  		     end as BOOKING_IMG, '
                    +'		  		     TABLE_STATE, '
                    +'		  		     case 	when  t1.NO_TABLE_GROUP = 0 then '''' '
                    +'		  		     	      when (t1.NO_TABLE_GROUP > 0) and (t1.NO_TABLE  = t1.NO_TABLE_GROUP) then ''G-M'' '
                    +'		  		            when (t1.NO_TABLE_GROUP > 0) and (t1.NO_TABLE <> t1.NO_TABLE_GROUP) then ConCat(''G-'', GetTableGroup(:P0, t1.NO_TABLE_GROUP)) '
                    +'		  		     end as GROUP_NAME, '
                    +'		  		     case 	when  t1.NO_TABLE_GROUP = 0 then '''' '
                    +'		  		     	      when (t1.NO_TABLE_GROUP > 0) and (t1.NO_TABLE  = t1.NO_TABLE_GROUP) then ''G-M'' '
                    +'		  		            when (t1.NO_TABLE_GROUP > 0) and (t1.NO_TABLE <> t1.NO_TABLE_GROUP) then Cast(t1.NO_TABLE_GROUP as Char) '
                    +'		  		     end as GROUP_NO, '
                    +'		  		     Ifnull(t2.CD_DAMDANG,'''')	as CD_DAMDANG, '
                    +'		  		     t1.NM_TABLE, '
                    +'		  		     t1.COLOR, '
                    +'		  		     t1.NUMBER_COLOR, '
                    +'               t1.FONT_COLOR, '
                    +'               t1.BOTTOM_COLOR, '
                    +'               t1.BORDER_COLOR, '
                    +'		  		     t1.COLOR_HEX, '
                    +'               t1.FONT_COLOR_HEX, '
                    +'               t1.BORDER_COLOR_HEX, '
                    +'		  		     t2.NO_RFID, '
                    +'		  		     t3.NM_NAME, '
                    +'		  		     t3.REMARK, '
                    +'		  		     t2.TABLE_COLOR, '
                    +'               t4.DT_LASTORDER, '
                    +'               Ifnull(t5.NM_SAWON,'''') as DAMDANG, '
                    +'               t7.COLOR_MENU, '
                    +'               t2.YN_CASHORDER, '
                    +'               t1.YN_TABLEHOLD, '
                    +'		  		     case  t2.DS_CUST when  ''N'' then ''신규'' when ''O'' then ''단골'' end as DS_CUST, '
                    +Ifthen(Common.Config.OverTimeMenu = '', '0 as AMT_ADDMENU, ',
                                                             Format('case when TIMESTAMPDIFF(MINUTE, t2.COME_TIME, Now()) > %d  then ((TIMESTAMPDIFF(MINUTE, t2.COME_TIME, Now()) - %d) / %d * %d + %d) * %s  end as AMT_ADDMENU, ', [Common.Config.OverTimeTime, Common.Config.OverTimeTime, Ifthen(Common.Config.OverTimeEach=0,1,Common.Config.OverTimeEach), Common.Config.OverTimeAmt, Ifthen(GetOption(412)='1',Common.Config.OverTimeAmt,0), Ifthen(GetOption(223) = '1', 't2.CNT_PERSON ', '1')]))
                    +Ifthen(GetHeadOption(9)='1', ' t8.NO_TABLE as PG_TABLE ', ' 0 as PG_TABLE ')
                    +'	        from MS_TABLE    t1  left outer join '
                    +'		  	       SL_ORDER_H  t2  on t1.CD_STORE = t2.CD_STORE and t1.NO_TABLE = t2.NO_TABLE and t2.DS_ORDER = ''T'' left outer join '
                    +'		  		     (select a.CD_STORE, '
                    +'                       b.NO_TABLE, '
                    +'                       a.NO_BOOKING, '
                    +'                       a.DT_BOOKING, '
                    +'                       a.NM_NAME, '
                    +'                       a.REMARK '
                    +'		  		        from SL_BOOKING       a  inner join '
                    +'		  		             SL_BOOKING_TABLE b  on a.CD_STORE = b.CD_STORE and a.NO_BOOKING = b.NO_BOOKING '
                    +         Format('where ((a.DT_BOOKING Between DATE_ADD(Now(), INTERVAL -%d MINUTE ) and Now() ) '
                    +'              				   or (a.DT_BOOKING between  Now() and DATE_ADD(Now(), INTERVAL %d MINUTE) )) ',[Common.Config.BookingEnd, Common.Config.BookingTime])
                    +'                  and a.YN_SALE = ''N'' '
                    +'                order by a.DT_BOOKING desc '
                    +'                limit 1000 '
                    +'               ) as t3 on t1.CD_STORE = t3.CD_STORE and t1.NO_TABLE = t3.NO_TABLE left outer join '
                    +'              (select NO_TABLE, '
                    +'                      Date_Format(Max(DT_CHANGE), ''%H:%i'') as DT_LASTORDER '
                    +'                 from SL_ORDER_D  '
                    +'                where CD_STORE =:P0 '
                    +'                  and DS_ORDER = ''T'' '
                    +'                group by NO_TABLE) as t4 on t4.NO_TABLE = t1.NO_TABLE left outer join '
                    +'              MS_SAWON as t5 on t5.CD_STORE = t2.CD_STORE and t5.CD_SAWON = t2.CD_DAMDANG left outer join '
                    +'              (select a.NO_TABLE, '
                    +'                      Sum(case when Substring(b.CONFIG,6,1) = ''Y'' then 1 else 0 end) as COLOR_MENU '
                    +'                 from SL_ORDER_D a  inner join '
                    +'                      MS_MENU    b  on b.CD_STORE = a.CD_STORE and b.CD_MENU = a.CD_MENU '
                    +'                where a.CD_STORE = :P0 '
                    +'                  and a.DS_ORDER = ''T'' '
                    +'                group by a.NO_TABLE) t7 on t7.NO_TABLE = t1.NO_TABLE '
                    +Ifthen(GetHeadOption(9)='1',' left outer join (select NO_TABLE '
                    +'                                                from SL_CARD_AHEAD '
                    +'                                               where CD_STORE =:P0 '
                    +'                                               group by NO_TABLE ) as t8 on t8.NO_TABLE = t1.NO_TABLE ','')
                    +'       	 where t1.CD_STORE 	=:P0 '
                    +'	         and t1.CD_FLOOR 	=:P1 '
                    +'           and t1.SEQ        =0 ) a left outer join '
                    +'       (select NO_TABLE, '
                    +'               Date_Format(Max(DT_SALE), ''%H:%i'') as LETSORDER_TIME, '
                    +'               Max(DT_SALE) as DT_SALE_LETSORDER '
                    +'          from SL_SALE_H '
                    +'         where CD_STORE =:P0 '
                    +'           and YMD_SALE =:P2 '
                    +'           and NO_POS   =:P3 '
                    +'           and DS_SALE  =''S'' '
                    +'           and TIMESTAMPDIFF(second,  DT_SALE, NOW() ) <= 10 '
                    +'         group by NO_TABLE '
                    +'       ) b on b.NO_TABLE = a.NO_TABLE  left outer join '
                    +'       (select NO_TABLE, '
                    +'               Max(DT_SALE) as DT_SALE '
                    +'          from SL_SALE_H '
                    +'         where CD_STORE =:P0 '
                    +'           and YMD_SALE =:P2 '
                    +'           and NO_POS   <> :P3 '
                    +'           and DS_SALE  = ''S'' '
                    +'           and TIMESTAMPDIFF(second,  DT_SALE, NOW() ) <= 10 '
                    +'         group by NO_TABLE '
                    +'       ) c on c.NO_TABLE = a.NO_TABLE '
                    +' order by a.COME_TIME ',
                    [Common.Config.StoreCode,
                     Common.Table.Floor,
                     Common.WorkDate,
                     Common.Config.LetsOrderPosNo,
                     Ifthen(GetOption(469)='0',-1,1)]);  //결제완료 표시
    except
      on E: Exception do
      begin
        Common.WriteLog('SetOrderInfo',E.Message);
        if (Pos('연결을실패했습니다', Replace(E.Message,' ','')) > 0) or (Pos('TCP공급자', Replace(E.Message,' ','')) > 0) then
          Common.LogoClick(nil);
        if FErrCnt = 0 then
        begin
          FErrCnt := 1;
          SetOrderInfo;
          Exit;
        end
        else Exit;
      end;
    end;

    if not OrderMemData.Active then
      OrderMemData.Open;
    vOrderSeq := 0;
    while not DM.QueryEx.Eof do
    begin
      try
        vTemp := FormatFloat('#,0',DM.QueryEx.FieldByName('amt_order').AsInteger)+'원';

        //주문순번을 표시할때
        if (GetOption(237) = '2') and (DM.QueryEx.FieldByName('come_time').AsString <> '99:99') then
          if vOrderList.IndexOf(IntToStr(DM.QueryEx.FieldByName('no_table').AsInteger)) >= 0 then
          vOrderSeq := vOrderSeq + 1;

        SetOrderMenu(DM.QueryEx.FieldByName('no_table').AsInteger,
                     DM.QueryEx.FieldByName('amt_addmenu').AsInteger,
                     DM.QueryEx.FieldByName('cnt_person').AsInteger,
                     DM.QueryEx.FieldByName('lapse_time').AsInteger,
                     vMenuName,
                     vMenuQty);

        SetPosButton(DM.QueryEx.FieldByName('no_table').AsInteger,
                     DM.QueryEx.FieldByName('amt_order').AsInteger,
                     vTemp,
                     Ifthen(GetOption(254)='0', DM.QueryEx.FieldByName('cnt_person').AsString +'명',DM.QueryEx.FieldByName('ds_cust').AsString),
                     Format('[%s]', [DM.QueryEx.FieldByName('come_time').AsString]),
                     DM.QueryEx.FieldByName('Table_state').AsString,
                     DM.QueryEx.FieldByName('dt_booking').AsString,
                     DM.QueryEx.FieldByName('no_booking').AsString,
                     DM.QueryEx.FieldByName('booking_Img').AsString,
                     DM.QueryEx.FieldByName('nm_name').AsString,
                     DM.QueryEx.FieldByName('remark').AsString,
                     DM.QueryEx.FieldByName('group_name').AsString,
                     vMenuName,
                     vMenuQty,
                     DM.QueryEx.FieldByName('Damdang').AsString,
                     DM.QueryEx.FieldByName('TableName').AsString,
                     DM.QueryEx.FieldByName('Color').AsString,
                     DM.QueryEx.FieldByName('Border_Color').AsString,
                     DM.QueryEx.FieldByName('Number_Color').AsString,
                     DM.QueryEx.FieldByName('Font_Color').AsString,
                     DM.QueryEx.FieldByName('Bottom_Color').AsString,
                     DM.QueryEx.FieldByName('Color_Hex').AsString,
                     DM.QueryEx.FieldByName('Border_Color_Hex').AsString,
                     DM.QueryEx.FieldByName('Font_Color_Hex').AsString,
                     DM.QueryEx.FieldByName('dt_lastorder').AsString,
                     DM.QueryEx.FieldByName('Lapse_Time').AsInteger,
                     DM.QueryEx.FieldByName('Table_Color').AsString,
                     vOrderSeq,
                     DM.QueryEx.FieldByName('color_menu').AsInteger,
                     DM.QueryEx.FieldByName('pg_table').AsInteger,
                     DM.QueryEx.FieldByName('YN_CASHORDER').AsString,
                     Ifthen((GetOption(94)='1') and (GetOption(469)<>'0'), DM.QueryEx.FieldByName('LETSORDER_TABLE').AsInteger, -1),
                     DM.QueryEx.FieldByName('LETSORDER_TIME').AsString,
                     DM.QueryEx.FieldByName('YN_TABLEHOLD').AsString);
        vTotalAddAmt := vTotalAddAmt + DM.QueryEx.FieldByName('amt_addmenu').AsInteger;

        if (OrderMemData.RecordCount > 0) and (OrderMemData.Locate('NO_TABLE', DM.QueryEx.FieldByName('NO_TABLE').AsString, [loCaseInsensitive] )) then
          OrderMemData.Edit
        else
          OrderMemData.Append;
        OrderMemData.FieldByName('NO_TABLE').AsInteger  := DM.QueryEx.FieldByName('NO_TABLE').AsInteger;
        OrderMemData.FieldByName('COME_TIME').AsString := DM.QueryEx.FieldByName('COME_TIME').AsString;
        OrderMemData.FieldByName('LAPSE_TIME').AsInteger := DM.QueryEx.FieldByName('LAPSE_TIME').AsInteger;
        OrderMemData.FieldByName('AMT_ORDER').AsInteger := DM.QueryEx.FieldByName('AMT_ORDER').AsInteger;
        OrderMemData.FieldByName('ORDER_MENU').AsString := vMenuName;
        OrderMemData.FieldByName('ORDER_QTY').AsString  := vMenuQty;
        OrderMemData.FieldByName('GROUP_NAME').AsString := DM.QueryEx.FieldByName('GROUP_NAME').AsString;
        OrderMemData.FieldByName('YN_TABLEHOLD').AsString := DM.QueryEx.FieldByName('YN_TABLEHOLD').AsString;
        OrderMemData.Post;
      except
        on E: Exception do
          Common.WriteLog('Table006',E.Message);
      end;
      DM.QueryEx.Next;
    end;
    DM.QueryEx.Close;


    if LetsOrderButtonIndex >= 0 then
    begin
      DM.OpenQueryEx('select Count(*) '
                    +'  from SL_LETSORDER '
                    +' where CD_STORE =:P0 '
                    +'   and DS_STATUS =:P1 ',
                    [Common.Config.StoreCode,
                     Ifthen(GetOption(62)='0','0','1')]);
      if DM.QueryEx.Fields[0].AsInteger > 0 then
      begin
        FunctionButton[LetsOrderButtonIndex].Status.Visible := true;
        FunctionButton[LetsOrderButtonIndex].Status.Caption := '주문';
      end
      else
        FunctionButton[LetsOrderButtonIndex].Status.Visible := false;
      DM.QueryEx.Close;
    end;


    //계산완료 후 깜박임
    if GetOption(360) <> '0' then
    begin
      TableMark := false;
      DM.OpenQueryEx('select NO_TABLE, '
                    +'       DT_ACCT_LAST  '
                    +'  from MS_TABLE  '
                    +' where CD_STORE   =:P0 '
                    +'   and CD_FLOOR   =:P1 '
                    +'   and SEQ        = 0 '
                    +'   and YN_PACKING = ''N'' '
                    +'   and TIMESTAMPDIFF(SECOND, DT_ACCT_LAST, Now()) <= :P2 ',
                    [Common.Config.StoreCode,
                     Common.Table.Floor,
                     (StoI(GetOption(360))+2) * 10]);
      SetLength(MarkTableData, DM.QueryEx.RecordCount, 5);
      I := 0;
      while not DM.QueryEx.Eof do
      begin
        MarkTableData[I,0] := DM.QueryEx.Fields[0].AsString;
        MarkTableData[I,1] := FormatDateTime('yyyy-mm-dd hh:nn:ss:000', IncSecond(DM.QueryEx.Fields[1].AsDateTime, (StoI(GetOption(360))+2) * 10));
        MarkTableData[I,2] := 'TableClear';
        Inc(I);
        DM.QueryEx.Next;
      end;
      DM.QueryEx.Close;
      TableMark := true;
    end
    else TableMark := false;

    FErrCnt   := 0;

    //주문정보
    DM.OpenQueryEx('select a.CD_FLOOR, '
                  +'       ConCat(Cast(Count(b.NO_TABLE) as Char ) '
                  +'       ,''/'',Cast((select count(*) '
                  +'                       from MS_TABLE  '
                  +'                      where CD_STORE	=a.CD_STORE '
                  +'                        and CD_FLOOR = a.CD_FLOOR '
                  +'                        and NO_TABLE 	> 0) as Char)) as ORDER_TABLE, '
                  +'	      Ifnull(sum(AMT_ORDER), 0) '
                  +'  from MS_TABLE   a  left outer join '
                  +'       SL_ORDER_H b  on b.CD_STORE = a.CD_STORE and b.NO_TABLE = a.NO_TABLE and b.DS_ORDER = ''T'' '
                  +' where a.CD_STORE	= :P0 '
                  +' group by a.CD_STORE, a.CD_FLOOR ',
                  [Common.Config.StoreCode]);

    while not DM.QueryEx.Eof do
    begin
      for vIndex := Low(FloorButton) to High(FloorButton) do
      begin
        if DM.QueryEx.Fields[0].AsString = FloorButton[vIndex].Hint then
        begin
          FloorButton[vIndex].Caption := FloorButton[vIndex].Status.Caption + #13#10+ Format('[ %s ]',[DM.QueryEx.Fields[1].AsString]);
          Break;
        end;
      end;
      vOrderAmt := vOrderAmt + DM.QueryEx.Fields[2].AsInteger;
      DM.QueryEx.Next;
    end;
    DM.QueryEx.Close;

    //매출정보
    if Self.Showing and SaleAmountLabel.Visible then
    begin
      DM.OpenQueryEx('select Ifnull(Sum(AMT_SALE),0) '
                    +'	 from SL_SALE_H  '
                    +'	where CD_STORE	=:P0 '
                    +'	  and YMD_SALE  =:P1 '
                    +'	  and DS_SALE   <> ''V'' ',
                    [Common.Config.StoreCode,
                     Common.WorkDate]);
      vSaleAmt := DM.QueryEx.Fields[0].AsInteger;
    end;
    DM.QueryEx.Close;

    if Self.Showing then
      ExecQuery('delete from SL_ORDER_LOG '
               +'	where CD_STORE =:P0 '
               +'	  and NO_POS 	 =:P1 ',
               [Common.Config.StoreCode,
                Common.Config.PosNo]);

    //마지막주문한지 10분이 안지났으면 테이블 색상 변경
    if (IncMinute(Common.LastOrderTime, 10) > Now()) and (Common.LastOrderTableButton <> nil) and (Common.LastOrderFloor = Common.Table.Floor) then
    begin
      Common.LastOrderTableButton.Color    := clRed;
    end;

    Info1NameLabel.Caption  := Common.GetPaPago('매출');
    SaleAmountLabel.Caption := FormatFloat('#,0원',vSaleAmt);
    Info2NameLabel.Caption  := Common.GetPaPago('주문');
    OrderAmountLabel.Caption := FormatFloat('#,0원',vOrderAmt);

    if OrderInfoButton.Tag = 1 then
    begin
      if Info1Panel.Visible and Info2Panel.Visible then
      begin
        OrderInfoButton.Caption := Format('%s/%s',[FormatFloat('#,0원',vOrderAmt), FormatFloat('#,0원',vSaleAmt)]);
        OrderInfoButton.Appearance.Font.Size := 20;
        OrderInfoButton.Left   := 500;
        OrderInfoButton.Width  := 337;
      end
      else if Info1Panel.Visible  then
        OrderInfoButton.Caption := Format('%s',[FormatFloat('#,0원',vSaleAmt)])
      else if Info2Panel.Visible  then
        OrderInfoButton.Caption := Format('%s',[FormatFloat('#,0원',vOrderAmt)]);
    end;
  finally
    FreeAndNil(vOrderList);
    DM.QueryEx.Close;
    Tmr_TableState.Enabled := false;
    Tmr_TableState.Enabled := true;
  end;
end;

{------------------------------------------------------------------------------}
{ TableMode에 따라 테이블 Visible 상태                                         }
{------------------------------------------------------------------------------}
procedure TTable_F.SetTableVisible;
  procedure SetImageButton(aTableNo:Integer;aVisible:Boolean);
  var vIndex :Integer;
  begin
    For vIndex := 0 to ComponentCount-1 do
    begin
      if (Components[vIndex] is TAdvSmoothButton) and
         ( (Components[vIndex] as TAdvSmoothButton).Parent = TablePanel ) and
         ( (Components[vIndex] as TAdvSmoothButton).Tag = aTableNo) and
         ((LeftStr((Components[vIndex] as TAdvSmoothButton).Name,5) = 'Table') or (LeftStr((Components[vIndex] as TAdvSmoothButton).Name,4) = 'Wall')) then
      begin
        TAdvSmoothButton(Components[vIndex]).Enabled := aVisible;
//        TAdvSmoothButton(Components[vIndex]).Visible := aVisible;
        Break;
      end;
    end;
  end;

var vIndex :Integer;
begin
  case TableMode of
    tbmNone :
      begin
        for vIndex := 0 to ComponentCount-1 do
        if (Components[vIndex] is TPosButton) and
           ( (Components[vIndex] as TPosButton).Tag = 0 ) and
           ( (Components[vIndex] as TPosButton).Parent = TablePanel ) then  //빈테이블이 었으면 그냥통과
        begin
          if ((Components[vIndex] as TPosButton).Temp7 = 'Y') then
          begin
            if LeftStr((Components[vIndex] as TPosButton).Bottom.CenterString,2) <> 'G-' then
            begin
              if (Components[vIndex] as TPosButton).Temp8 = 'N' then  //미주문
              begin
                SetImageButton((Components[vIndex] as TPosButton).Number.Number, true );
                (Components[vIndex] as TPosButton).Visible    := false;
              end
              else
              begin
                SetImageButton((Components[vIndex] as TPosButton).Number.Number, false );
                (Components[vIndex] as TPosButton).Visible    := True;
              end;
            end
            else
            begin
              SetImageButton((Components[vIndex] as TPosButton).Number.Number, false );
              (Components[vIndex] as TPosButton).Visible    := True;
            end;
          end
          else if not (Components[vIndex] as TPosButton).Visible  then
            (Components[vIndex] as TPosButton).Visible    := True;
        end;
      end;
    tbmTableMove,
    tbmMerge,
    tbmRePrint,
    tbmMenuMove,
    tbmDutchPay   :  //현재 주문중인 테이블만 보이게
      begin
        For vIndex := 0 to ComponentCount-1 do
        if ( (Components[vIndex] is TPosButton) and
           ( (Components[vIndex] as TPosButton).Tag = 0 ) and
           ( (Components[vIndex] as TPosButton).Parent = TablePanel ) and
           ( (Components[vIndex] as TPosButton).Number.Number= 0 ))
        or ( (Components[vIndex] is TPosButton) and
           ( (Components[vIndex] as TPosButton).Tag = 0 ) and
           (( (Components[vIndex] as TPosButton).Temp8 = 'N' ) or ( LeftStr((Components[vIndex] as TPosButton).Bottom.CenterString,2) <> '')))  then  //빈테이블이 었으면 그냥통과
        begin
          if ((Components[vIndex] as TPosButton).Temp7 = 'Y') and (LeftStr((Components[vIndex] as TPosButton).Bottom.CenterString,2) <> 'G-') then
            SetImageButton((Components[vIndex] as TPosButton).Number.Number, false)
          else if (LeftStr((Components[vIndex] as TPosButton).Bottom.CenterString,2) <> 'G-') then
            (Components[vIndex] as TPosButton).Visible    := False;
        end;
      end;
    tbmTableMoveing :
      begin
        For vIndex := 0 to ComponentCount-1 do
          if (Components[vIndex] is TPosButton) and
           ( (Components[vIndex] as TPosButton).Tag = 0 ) and
             ( (Components[vIndex] as TPosButton).Parent = TablePanel ) and
            not ( (Components[vIndex] as TPosButton).Number.ShowColor  )  then  //빈테이블이 었으면 그냥통과
          begin
            if (Components[vIndex] as TPosButton).Temp7 = 'Y' then
            begin
              if (Components[vIndex] as TPosButton).Temp8 = 'N' then
              begin
                SetImageButton((Components[vIndex] as TPosButton).Number.Number, true );
                (Components[vIndex] as TPosButton).Visible    := false;
              end
              else
              begin
                SetImageButton((Components[vIndex] as TPosButton).Number.Number, false );
                (Components[vIndex] as TPosButton).Visible    := True;
              end;
            end
            else
              (Components[vIndex] as TPosButton).Visible    := True;
          end
          else if ( (Components[vIndex] is TPosButton) and
                  ( (Components[vIndex] as TPosButton).Tag = 0 ) and
                  ( (Components[vIndex] as TPosButton).Parent = TablePanel ) )
               or ( (Components[vIndex] is TPosButton) and
                  ( (Components[vIndex] as TPosButton).Tag = 0 ) and
                  ( (Components[vIndex] as TPosButton).Temp2 <> '' ) ) then
          begin
            if (Components[vIndex] as TPosButton).Temp7 = 'Y' then
            begin
              SetImageButton((Components[vIndex] as TPosButton).Number.Number, false );
              (Components[vIndex] as TPosButton).Visible    := True;
            end
            else
              (Components[vIndex] as TPosButton).Visible    := true;

            if (Components[vIndex] as TPosButton).Number.Number = FromTable.Number then
              (Components[vIndex] as TPosButton).Visible    := false;

          end;
      end;
    tbmTableKey,
    tbmWaitOrder: //주문중이고, 이동할려구 선택한 테이블제외
      begin
        For vIndex := 0 to ComponentCount-1 do
          if (Components[vIndex] is TPosButton) and
           ( (Components[vIndex] as TPosButton).Tag = 0 ) and
             ( (Components[vIndex] as TPosButton).Parent = TablePanel ) and
            not ( (Components[vIndex] as TPosButton).Number.ShowColor  ) and
             ( (Components[vIndex] as TPosButton).Temp2 = '' )  then  //빈테이블이 었으면 그냥통과
          begin
            if (Components[vIndex] as TPosButton).Temp7 = 'Y' then
            begin
              if (Components[vIndex] as TPosButton).Temp8 = 'N' then
              begin
                SetImageButton((Components[vIndex] as TPosButton).Number.Number, true );
                (Components[vIndex] as TPosButton).Visible    := false;
              end
              else
              begin
                SetImageButton((Components[vIndex] as TPosButton).Number.Number, false );
                (Components[vIndex] as TPosButton).Visible    := True;
              end;
            end
            else
              (Components[vIndex] as TPosButton).Visible    := True;
          end
          else if ( (Components[vIndex] is TPosButton) and
                  ( (Components[vIndex] as TPosButton).Tag = 0 ) and
                  ( (Components[vIndex] as TPosButton).Parent = TablePanel ) )
               or ( (Components[vIndex] is TPosButton) and
                  ( (Components[vIndex] as TPosButton).Tag = 0 ) and
                  ( (Components[vIndex] as TPosButton).Temp2 <> '' ) ) then
          begin
            if (Components[vIndex] as TPosButton).Temp7 = 'Y' then
            begin
              //주문중인 테이블
              if (Components[vIndex] as TPosButton).Temp8 = 'Y' then
              begin
                SetImageButton((Components[vIndex] as TPosButton).Number.Number, false );
                (Components[vIndex] as TPosButton).Visible    := false;
              end
              else
              begin
                SetImageButton((Components[vIndex] as TPosButton).Number.Number, false );
                (Components[vIndex] as TPosButton).Visible    := True;
              end;
            end
            else
              (Components[vIndex] as TPosButton).Visible    := False;
          end;
      end;
    tbmMergeing   :   //합석(주문중인 테이블)
      begin
        For vIndex := 0 to ComponentCount-1 do
        begin
          if (Components[vIndex] is TPosButton) and ((Components[vIndex] as TPosButton).Parent = TablePanel ) then
          begin
            if   ( (Components[vIndex] is TPosButton)  and
                 ( (Components[vIndex] as TPosButton).Tag = 0 ) and
                 ( (Components[vIndex] as TPosButton).Parent = TablePanel ) and
                  not ( (Components[vIndex] as TPosButton).Number.ShowColor ) )
               or
                 ( (Components[vIndex] is TPosButton) and
                 ( (Components[vIndex] as TPosButton).Tag = 0 ) and
                 ( (Components[vIndex] as TPosButton).Parent = TablePanel ) and
                 ( (Components[vIndex] as TPosButton).Number.Number = FromTable.Number ) )
               or
                 ( (Components[vIndex] is TPosButton) and
                 ( (Components[vIndex] as TPosButton).Tag = 0 ) and
                 ( (Components[vIndex] as TPosButton).Temp8 = 'N' ) ) then  //빈테이블이 었으면 그냥통과
            begin
              (Components[vIndex] as TPosButton).Visible    := False;
            end
            else if  (Components[vIndex] is TPosButton) and
                     ( (Components[vIndex] as TPosButton).Tag = 0 ) and
                     ( (Components[vIndex] as TPosButton).Parent = TablePanel ) then
            begin
              (Components[vIndex] as TPosButton).Visible    := true;
            end;
          end;
        end;
      end;
    tbmMenuMoveing :     //합석(주문중인 테이블)
      begin
        For vIndex := 0 to ComponentCount-1 do
        if   ( (Components[vIndex] is TPosButton) and
             ( (Components[vIndex] as TPosButton).Tag = 0 ) and
             ( (Components[vIndex] as TPosButton).Parent = TablePanel ) and
             ( (Components[vIndex] as TPosButton).Number.Number = FromTable.Number ) ) then
        begin
          SetImageButton((Components[vIndex] as TPosButton).Number.Number, false);
          (Components[vIndex] as TPosButton).Visible    := False;
        end
        else if  ( (Components[vIndex] is TPosButton) and
                 ( (Components[vIndex] as TPosButton).Parent = TablePanel)  ) then
        begin
          if ((Components[vIndex] as TPosButton).Temp7 = 'Y') then
          begin
            if (Components[vIndex] as TPosButton).Temp8 = 'N'  then
            begin
              SetImageButton((Components[vIndex] as TPosButton).Number.Number, true);
              (Components[vIndex] as TPosButton).Visible    := false;
            end
            else
              (Components[vIndex] as TPosButton).Visible    := true;
          end
          else
            (Components[vIndex] as TPosButton).Visible    := true;
        end;
      end;
     tbmGroup : {그룹지정}
      begin
        For vIndex := 0 to ComponentCount-1 do
        if (Components[vIndex] is TPosButton) and
           ( (Components[vIndex] as TPosButton).Tag = 0 ) and
           ( (Components[vIndex] as TPosButton).Parent = TablePanel ) then
           begin
              if ( Copy( (Components[vIndex] as TPosButton).Bottom.CenterString,1,2) = 'G-' ) and
                 ( (Components[vIndex] as TPosButton).Bottom.CenterString <> 'G-M' )then  //빈테이블이 었으면 그냥통과
              begin
                if ((Components[vIndex] as TPosButton).Temp7 = 'Y')  then
                  SetImageButton((Components[vIndex] as TPosButton).Number.Number, false)
                else
                  (Components[vIndex] as TPosButton).Visible    := False;
              end
              else if  (Components[vIndex] is TPosButton) and
                      ( (Components[vIndex] as TPosButton).Parent = TablePanel ) then
              begin
                if ((Components[vIndex] as TPosButton).Temp7 = 'Y') and (LeftStr((Components[vIndex] as TPosButton).Bottom.CenterString,2) <> 'G-') then
                begin
                  if (Components[vIndex] as TPosButton).Temp8 = 'Y' then
                  begin
                    SetImageButton((Components[vIndex] as TPosButton).Number.Number, false);
                    (Components[vIndex] as TPosButton).Visible    := True;
                  end
                  else
                  begin
                    SetImageButton((Components[vIndex] as TPosButton).Number.Number, true);
                    (Components[vIndex] as TPosButton).Visible    := false;
                  end;
                end
                else
                  (Components[vIndex] as TPosButton).Visible    := True;
              end;
           end;
      end;
     tbmGrouping :  {그룹지정중}
      begin
        For vIndex := 0 to ComponentCount-1 do
        if (Components[vIndex] is TPosButton) and
           ( (Components[vIndex] as TPosButton).Tag = 0 ) and
           ( (Components[vIndex] as TPosButton).Parent = TablePanel ) then
        begin
          if  LeftStr((Components[vIndex] as TPosButton).Bottom.CenterString,2) = 'G-'  then
          begin
            (Components[vIndex] as TPosButton).Visible    := false;
          end
          else if  ( (Components[vIndex] as TPosButton).Number.Number = FromTable.Number ) or
              ( (Components[vIndex] as TPosButton).Bottom.CenterString = 'G-M' ) or
              ( Copy( (Components[vIndex] as TPosButton).Bottom.CenterString,1,2) = 'G-' ) then  //빈테이블이 었으면 그냥통과
          begin
            if (Components[vIndex] as TPosButton).Temp7 = 'Y' then
              SetImageButton((Components[vIndex] as TPosButton).Number.Number, false)
            else
              (Components[vIndex] as TPosButton).Visible    := False;
          end
          else
          begin
            if (Components[vIndex] as TPosButton).Temp7 = 'Y' then
            begin
              if (Components[vIndex] as TPosButton).Temp8 = 'Y' then
              begin
                SetImageButton((Components[vIndex] as TPosButton).Number.Number, false);
                (Components[vIndex] as TPosButton).Visible    := True;
              end
              else
              begin
                SetImageButton((Components[vIndex] as TPosButton).Number.Number, true);
                (Components[vIndex] as TPosButton).Visible    := false;
              end;
            end
            else
              (Components[vIndex] as TPosButton).Visible    := True;
          end;
        end;
      end;
     tbmUnGroup : {그룹해제}
      begin
        For vIndex := 0 to ComponentCount-1 do
        if (Components[vIndex] is TPosButton) and
           ( (Components[vIndex] as TPosButton).Tag = 0 ) and
           ( (Components[vIndex] as TPosButton).Parent = TablePanel ) then
        begin
          if  ( (Components[vIndex] as TPosButton).Bottom.CenterString <> '' ) then  //그룹지정 내역이 없으면
            (Components[vIndex] as TPosButton).Visible    := true
          else
          begin
            if (Components[vIndex] as TPosButton).Temp7 = 'Y' then
              SetImageButton((Components[vIndex] as TPosButton).Number.Number, false);
            (Components[vIndex] as TPosButton).Visible    := false;
          end;
        end;
      end;
      tbmBooking :   //예약
      begin
          For vIndex := 0 to ComponentCount-1 do
          if (Components[vIndex] is TPosButton) and
             ( (Components[vIndex] as TPosButton).Tag = 0 ) and
             ( (Components[vIndex] as TPosButton).Parent = TablePanel ) then
          begin
            (Components[vIndex] as TPosButton).Color               := $00ACB7BD;
            (Components[vIndex] as TPosButton).Number.ShowColor    := false;
//            (Components[vIndex] as TPosButton).Number.Color        := $00A23C22;
            (Components[vIndex] as TPosButton).Menu.Name    := EmptyStr;
            (Components[vIndex] as TPosButton).Menu.Qty    := EmptyStr;
            //테이블명을 사용하고 중앙에 테이블명을 보일때
            if (GetOption(25) = '1') and (GetOption(24) = '0') then
            begin
              (Components[vIndex] as TPosButton).Caption  := (Components[vIndex] as TPosButton).Number.TempString;
              (Components[vIndex] as TPosButton).Number.NumberString := EmptyStr;
            end;

            (Components[vIndex] as TPosButton).Amount.Caption      := EmptyStr;
            (Components[vIndex] as TPosButton).Number.CenterString := EmptyStr;
            (Components[vIndex] as TPosButton).Number.RightString  := EmptyStr;
            (Components[vIndex] as TPosButton).Bottom.CenterString := EmptyStr;
            (Components[vIndex] as TPosButton).Bottom.LeftString   := EmptyStr;
            (Components[vIndex] as TPosButton).Bottom.RightString  := EmptyStr;
            (Components[vIndex] as TPosButton).Temp2               := EmptyStr;
            (Components[vIndex] as TPosButton).Number.ShowColor    := False;

            if (Components[vIndex] as TPosButton).Temp7 = 'Y' then
            begin
              SetImageButton((Components[vIndex] as TPosButton).Number.Number, true );
              (Components[vIndex] as TPosButton).Visible    := false;
            end

         end;
      end;
      tbmClear : //테이블 클리어
      begin
        For vIndex := 0 to ComponentCount-1 do
        if (Components[vIndex] is TPosButton) and
           ( (Components[vIndex] as TPosButton).Tag = 0 ) and
           ( (Components[vIndex] as TPosButton).Parent = TablePanel ) then
        begin
          if  ( (Components[vIndex] as TPosButton).Amount.Caption  = '[이용중]') then  //그룹지정 내역이 없으면
            (Components[vIndex] as TPosButton).Visible    := true
          else
          begin
            if (Components[vIndex] as TPosButton).Temp7 = 'Y' then
              SetImageButton((Components[vIndex] as TPosButton).Number.Number, false);
            (Components[vIndex] as TPosButton).Visible    := false;
          end;
        end;
      end;
    end;
end;

procedure TTable_F.ShowPanelImageClick(Sender: TObject);
begin
end;

{------------------------------------------------------------------------------}
{ 층변경 시                                                                    }
{------------------------------------------------------------------------------}
procedure TTable_F.SetFloorPage(AValue: Integer);
begin
  FFloorPage              := AValue;
  FloorUpButton.Enabled   := FloorPage > 1;
  FloorDownButton.Enabled := FloorPage < FloorPageCount;
  SetFloorButton;
end;

procedure TTable_F.SetLetsOrderHotImage;
begin
  if LetsOrderCallButtonIndex >= 0 then
  begin
    FunctionButton[LetsOrderCallButtonIndex].Status.Visible := true;
    FunctionButton[LetsOrderCallButtonIndex].Status.Caption := '호출';
  end;
end;

{------------------------------------------------------------------------------}
{ 테이블관련 작업모드 변경시                                                   }
{------------------------------------------------------------------------------}
procedure TTable_F.SetTableMode(AValue: TTableMode);
  procedure SetButtonDown(aCode:String);
  var vIndex :Integer;
  begin
    for vIndex := Low(FunctionButton) to High(FunctionButton) do
    begin
      FunctionButton[vIndex].BevelColor := BorderColor;
      if aCode <> '' then
        FunctionButton[vIndex].Enabled := false
      else
        FunctionButton[vIndex].Enabled := true;
    end;


    if aCode = '' then Exit;
    for vIndex := Low(FunctionButton) to High(FunctionButton) do
    begin
      if FunctionButton[vIndex].Hint = aCode then
      begin
        FunctionButton[vIndex].BevelColor := clRed;
        FunctionButton[vIndex].Enabled    := true;
        Break;
      end;
    end;

  end;
var vIndex :Integer;
begin
  TableMark := false;
  FTableMode       := AValue;
  Common.TableMode := AValue;
  SetTableVisible;
  Tmr_Msg.Tag     := 0;
  if not FunctionPanelButton.Visible then
    MessageLabel.Visible := false;
  case FTableMode of
    tbmNone      :
      begin
        MessageLabel.Caption := '';
        MsgLabel.Visible     := false;
        Tmr_Msg.Enabled      := False;
        SetButtonDown('');
      end;
    tbmTableMove :
      begin
        Tmr_Msg.Enabled := True;
        MessageLabel.Caption := Common.GetPaPago('이동 또는 합석 할 테이블을 선택하세요 (작업을 취소하실려면 좌석이동 버튼을 누르세요)');
        if not FunctionPanelButton.Visible then
        begin
          MsgLabel.Visible := true;
          MsgLabel.Caption := MessageLabel.Caption;
        end;
        SetButtonDown('00');
      end;
    tbmTableMoveing :
      begin
        Tmr_Msg.Enabled := True;
        MessageLabel.Caption := Common.GetPaPago('이동 또는 합석 할 테이블을 선택하세요 (작업을 취소하실려면 좌석이동 버튼을 누르세요)');
        if not FunctionPanelButton.Visible then
        begin
          MsgLabel.Visible := true;
          MsgLabel.Caption := MessageLabel.Caption;
        end;
      end;
    tbmMerge :
      begin
        Tmr_Msg.Enabled := True;
        MessageLabel.Caption := Common.GetPaPago('합석 할 테이블을 선택하세요 (작업을 취소하실려면 좌석합석 버튼을 누르세요)');
        if not FunctionPanelButton.Visible then
        begin
          MsgLabel.Visible := true;
          MsgLabel.Caption := MessageLabel.Caption;
        end;
        SetButtonDown('01');
      end;
    tbmMergeing :
      begin
        Tmr_Msg.Enabled := True;
        MessageLabel.Caption := Common.GetPaPago('합석 할 테이블을 선택하세요 (작업을 취소하실려면 좌석합석 버튼을 누르세요)');
        if not FunctionPanelButton.Visible then
        begin
          MsgLabel.Visible := true;
          MsgLabel.Caption := MessageLabel.Caption;
        end;
      end;
    tbmGroup :
      begin
        Tmr_Msg.Enabled := True;
        MessageLabel.Caption := Common.GetPaPago('그룹를 지정할 테이블을 선택 후 [그룹지정] 버튼을 누르세요');
        if not FunctionPanelButton.Visible then
        begin
          MsgLabel.Visible := true;
          MsgLabel.Caption := MessageLabel.Caption;
        end;
        SetButtonDown('02');
      end;
    tbmGrouping :
      begin
        Tmr_Msg.Enabled := True;
        MessageLabel.Caption := Common.GetPaPago('그룹를 지정할 테이블을 선택 후 [그룹지정] 버튼을 누르세요');
        if not FunctionPanelButton.Visible then
        begin
          MsgLabel.Visible := true;
          MsgLabel.Caption := MessageLabel.Caption;
        end;
      end;
    tbmUnGroup :
      begin
        Tmr_Msg.Enabled := True;
        MessageLabel.Caption := Common.GetPaPago('그룹를 해제 할 테이블을 선택하세요 (작업을 취소하실려면 그룹해제 버튼을 누르세요)');
        if not FunctionPanelButton.Visible then
        begin
          MsgLabel.Visible := true;
          MsgLabel.Caption := MessageLabel.Caption;
        end;
        SetButtonDown('03');
      end;
    tbmRePrint :
      begin
        Tmr_Msg.Enabled := True;
        MessageLabel.Caption := Common.GetPaPago('재인쇄 할 테이블을 선택하세요');
        if not FunctionPanelButton.Visible then
        begin
          MsgLabel.Visible := true;
          MsgLabel.Caption := MessageLabel.Caption;
        end;
        SetButtonDown('06');
      end;
    tbmMenuMove :
      begin
        Tmr_Msg.Enabled := True;
        if not FunctionPanelButton.Visible then
        begin
          MsgLabel.Visible := true;
          MsgLabel.Caption := MessageLabel.Caption;
        end;
        MessageLabel.Caption := Common.GetPaPago('메뉴를 이동할 테이블을 선택하세요 (작업을 취소하실려면 메뉴이동 버튼을 누르세요)');
        SetButtonDown('04');
      end;
    tbmBooking :
      begin
        if FunctionPanelButton.Visible then
          FunctionPanelButton.Click;

        //예약버튼만 활성화 시킨다
        for vIndex := Low(FunctionButton) to High(FunctionButton) do
          FunctionButton[vIndex].Visible := FunctionButton[vIndex].Hint = '05';

        Tmr_Msg.Enabled := True;
        MessageLabel.Caption := Common.GetPaPago('예약 테이블 선택이 끝나면 예약버튼을 누르세요');
        if not FunctionPanelButton.Visible then
        begin
          MsgLabel.Visible := true;
          MsgLabel.Caption := MessageLabel.Caption;
        end;
      end;
    tbmDutchPay :
      begin
        Tmr_Msg.Enabled := True;
        MessageLabel.Caption := Common.GetPaPago('더치페이 할 테이블을 선택하세요 (작업을 취소하실려면 더치페이 버튼을 누르세요)');
        if not FunctionPanelButton.Visible then
        begin
          MsgLabel.Visible := true;
          MsgLabel.Caption := MessageLabel.Caption;
        end;
        SetButtonDown('15');
      end;
    tbmWaitOrder:
      begin
        Tmr_Msg.Enabled := True;
        Common.MsgBox('대기 손님이 이용할 테이블을 지정하세요');
        if not FunctionPanelButton.Visible then
        begin
          MsgLabel.Visible := true;
          MsgLabel.Caption := MessageLabel.Caption;
        end;
      end;
    tbmTableKey :
      begin
        Tmr_Msg.Enabled := True;
        MessageLabel.Caption := Common.GetPaPago('주문 할 테이블을 선택하세요');
        if not FunctionPanelButton.Visible then
        begin
          MsgLabel.Visible := true;
          MsgLabel.Caption := MessageLabel.Caption;
        end;
      end;
  end;
  if FTableMode <> tbmNone then
    Tmr_MsgTimer(nil);
end;

procedure TTable_F.SetTableMark(aValue:Boolean);
var vIndex, vTableNo :Integer;
    vTableName :String;
begin
  FTableMark := aValue;
  if aValue then
    Tmr_TableMark.Enabled := true
  else
  begin
    Tmr_TableMark.Enabled := false;
    For vIndex := 0 to High(MarkTableData) do
    begin
      if Assigned(TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]])))) then
      begin
        vTableNo := TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]]))).Number.Number;
        vTableName := TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]]))).Number.TempString;
        if Assigned(TAdvSmoothButton(FindComponent(Format('TableImageButton%d',[vTableNo])))) then
          TAdvSmoothButton(FindComponent(Format('TableImageButton%d',[vTableNo]))).Status.Caption := vTableName;

        if MarkTableData[vIndex,2] = 'TableClear' then
          TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]]))).Amount.Caption := EmptyStr
        else if MarkTableData[vIndex,3] <> '' then
        begin
          TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]]))).BorderInnerColor  := clNone;
          TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]]))).BorderColor       := StringToColor(MarkTableData[vIndex,3]);
          TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]]))).Amount.Font.Color := StringToColor(MarkTableData[vIndex,4]);
        end;
        TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]]))).Amount.Font.Color := StringToColorDef(TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]]))).Temp5, clBlue);
      end;
    end;
  end;
end;


{------------------------------------------------------------------------------}
{ 테이블 관련 작업 적용(합석, 이동, 그룹, 그룹해제)                            }
{------------------------------------------------------------------------------}
procedure TTable_F.TableModeApply;
var FromAge, ToAge, SetAge  :String;
    I, vCnt, vGroupTableNo :Integer;
    vResult :String;
begin
  InitPreSentRecord(Common.Present);
  InitMemberRecord(Common.Member);
  case TableMode of
    tbmTableMoveing : {테이블이동}
    begin
      OpenQuery('select NO_TABLE_GROUP '
               +'	 from MS_TABLE '
               +'	where CD_STORE	=:P0 '
               +'	  and NO_TABLE	=:P1 ',
               [Common.Config.StoreCode,
                FromTable.Number]);
      vGroupTableNo := Common.Query.Fields[0].AsInteger;
      Common.Query.Close;

      ExecQueryEx('update SL_ORDER_H '
                 +'   set NO_TABLE =:P2 '
                 +' where CD_STORE =:P0 '
                 +'   and NO_TABLE =:P1 '
                 +'   and DS_ORDER =''T'';',
                 [Common.Config.StoreCode,
                  FromTable.Number,
                  ToTable.Number]);
      ExecQueryEx('update SL_ORDER_D '
                 +'   set NO_TABLE=:P2 '
                 +' where CD_STORE =:P0 '
                 +'   and NO_TABLE =:P1 '
                 +'   and DS_ORDER =''T'';',
                 [Common.Config.StoreCode,
                  FromTable.Number,
                  ToTable.Number]);
      ExecQueryEx('update SL_ORDER_C '
                 +'   set NO_TABLE=:P2 '
                 +' where CD_STORE =:P0 '
                 +'   and NO_TABLE =:P1 '
                 +'   and DS_ORDER =''T'';',
                 [Common.Config.StoreCode,
                  FromTable.Number,
                  ToTable.Number]);
      ExecQueryEx('update SL_ORDER_PRT '
                 +'   set NO_TABLE=:P2 '
                 +' where CD_STORE =:P0 '
                 +'   and NO_TABLE =:P1 '
                 +'   and DS_ORDER =''T'';',
                 [Common.Config.StoreCode,
                  FromTable.Number,
                  ToTable.Number]);
      ExecQueryEx('update SL_CARD_AHEAD '
                 +'   set NO_TABLE=:P2 '
                 +' where CD_STORE =:P0 '
                 +'   and NO_TABLE =:P1;',
                 [Common.Config.StoreCode,
                  FromTable.Number,
                  ToTable.Number]);
      ExecQueryEx('update SL_CASH_AHEAD '
                 +'   set NO_TABLE=:P2 '
                 +' where CD_STORE =:P0 '
                 +'   and NO_TABLE =:P1;',
                 [Common.Config.StoreCode,
                  FromTable.Number,
                  ToTable.Number]);

      //이동할려고 하는 테이블이 그룹마스터일때
      if FromTable.Number = vGroupTableNo then
      begin
        ExecQueryEx('update MS_TABLE '
                   +'   set NO_TABLE_GROUP = case when NO_TABLE = :P1 then 0 else :P2 end, '
                   +'       DT_CHANGE     =Now() '
                   +' where CD_STORE=:P0 '
                   +'   and NO_TABLE_GROUP=:P1; ',
                   [Common.Config.StoreCode,
                    FromTable.Number,
                    ToTable.Number]);

        ExecQueryEx('update MS_TABLE '
                   +'   set NO_TABLE_GROUP=:P1, '
                   +'       DT_CHANGE     =Now() '
                   +' where CD_STORE=:P0 '
                   +'   and NO_TABLE=:P1;',
                   [Common.Config.StoreCode,
                    ToTable.Number]);
      end;


      //렛츠오더 사용시
      if GetHeadOption(9) = '1' then
      begin
        ExecQueryEx('insert into TR_ORDER(CD_STORE, '
                   +'                     GROUP_SEQ, '
                   +'                     GROUP_STEP, '
                   +'                     DS_ORDER, '
                   +'                     NO_TABLE, '
                   +'                     ORDER_DEVICE) '
                   +'              values(:P0, '
                   +'                     GetNextVal(''TR_ORDER''), '
                   +'                     0, '
                   +'                     ''T'', '
                   +'                     :P1, '
                   +'                     ''P'');',
                   [Common.Config.StoreCode,
                    ToTable.Number]);

        ExecQueryEx('insert into TR_ORDER(CD_STORE, '
                   +'                     GROUP_SEQ, '
                   +'                     GROUP_STEP, '
                   +'                     DS_ORDER, '
                   +'                     NO_TABLE, '
                   +'                     NO_TABLE_TO, '
                   +'                     ORDER_DEVICE) '
                   +'              values(:P0, '
                   +'                     GetNextVal(''TR_ORDER''), '
                   +'                      0, '
                   +'                      ''M'', '
                   +'                      :P1, '
                   +'                      :P2, '
                   +'                      ''P'');',
                   [Common.Config.StoreCode,
                    FromTable.Number,
                    ToTable.Number]);
      end;

      if ExecQueryEx('insert into SL_ORDER_LOG(CD_STORE, '
                    +'                         NO_POS, '
                    +'                         DT_CHANGE) '
                    +'select CD_STORE, NM_CODE1, Now() '
                    +'  from MS_CODE  '
                    +' where CD_STORE  =:P0 '
                    +'   and CD_KIND   = ''01''  '
                    +'   and NM_CODE1 not in (select NO_POS from SL_ORDER_LOG where CD_STORE =:P0);',
                    [Common.Config.StoreCode],true) then
      begin
        if GetOption(25) = '0' then
          Common.WriteLog('work', Format('좌석이동 %s->%s',[IntToStr(FromTable.Number),IntToStr(ToTable.Number)]) )
        else
          Common.WriteLog('work', Format('좌석이동 %s->%s',[FromTable.Name,ToTable.Name]) );

        Common.Device.TableWork;
        Common.MsgBox('테이블을 이동했습니다');
      end;
      SetOrderInfo;
    end;
    tbmMergeing :  {합석}
    begin
      Common.ShowWaitForm;

      if not AHeadCheck(FromTable.Number) then
      begin
        Common.ErrBox('선결제가 있는 테이블은'#13'합석할 수 없습니다');
        Exit;
      end;

      Common.BeginTran;
      try
        //연령대별 고객수를 합한다
        OpenQuery('select CD_AGE '
                 +'  from SL_ORDER_H  '
                 +' where CD_STORE =:P0 '
                 +'   and NO_TABLE =:P1 '
                 +'   and DS_ORDER = ''T'' ',
                 [Common.Config.StoreCode,
                  FromTable.Number]);
        FromAge := Common.Query.Fields[0].AsString;

        OpenQuery('select CD_AGE '
                 +'  from SL_ORDER_H  '
                 +' where CD_STORE =:P0 '
                 +'   and NO_TABLE =:P1 '
                 +'   and DS_ORDER = ''T'' ',
                 [Common.Config.StoreCode,
                  ToTable.Number]);
        ToAge   := Common.Query.Fields[0].AsString;

        SetAge := '';
        while Trim(FromAge) <> '' do
        begin
          I := Pos(',',FromAge);
          if I > 0 then
          begin
            vCnt := StoI(Copy(FromAge,4,3));
            vCnt := vCnt + StoI(Copy(ToAge,4,3));

            SetAge := SetAge + Copy(FromAge,1,3) + LPad(IntToStr(vCnt),3,'0')+',' ;
            Delete(FromAge,1,I);
            Delete(ToAge,1,I);
          end
          else
          begin
            vCnt := StoI(Copy(FromAge,4,3));
            vCnt := vCnt + StoI(Copy(ToAge,4,3));

            SetAge  := SetAge + Copy(FromAge,1,3) + LPad(IntToStr(vCnt),3,'0') ;
            FromAge := '';
            ToAge   := '';
          end;
        end;
        ExecQuery('update SL_ORDER_H '
                 +'   set CD_AGE   =:P2 '
                 +' where CD_STORE =:P0 '
                 +'   and NO_TABLE =:P1 '
                 +'   and DS_ORDER = ''T'' ',
                 [Common.Config.StoreCode,
                  ToTable.Number,
                  SetAge]);

        DM.StoredProc.StoredProcName := 'POS_SAVE_TABLE_MERGE';
        DM.StoredProc.PrepareSQL;
        DM.StoredProc.Close;
        DM.StoredProc.ParamByName('_cd_store').AsString       := Common.Config.StoreCode;
        DM.StoredProc.ParamByName('_no_table_from').AsInteger := FromTable.Number;
        DM.StoredProc.ParamByName('_no_table_to').AsInteger   := ToTable.Number;
        DM.StoredProc.ExecProc;
        vResult := DM.StoredProc.ParamByName('_result').AsString;
        if vResult <> 'OK' then
          raise Exception.Create(vResult);

        Common.CommitTran;
        if GetOption(25) = '0' then
          Common.WriteLog('work', Format('좌석합석 %s->%s',[IntToStr(FromTable.Number),IntToStr(ToTable.Number)]) )
        else
          Common.WriteLog('work', Format('좌석합석 %s->%s',[FromTable.Name,ToTable.Name]) );

        Common.MsgBox('테이블을 합석을 했습니다');
        Common.Device.TableWork;
      except
        on E: Exception do
        begin
          Common.RollbackTran;
          Common.WriteLog('Table008',E.Message);
          Common.ErrBox(E.Message+#13#13+'테이블을 합석하지 못했습니다');
        end;
      end;
      SetOrderInfo;
      Common.HideWaitForm;
    end;
    tbmGrouping : {그룹지정중}
    begin
      if not AHeadCheck(FromTable.Number) then
      begin
        Common.ErrBox('선결제가 있는 테이블은'#13'그룹을 지정할 수 없습니다');
        Exit;
      end;

      ExecQueryEx('update MS_TABLE '
                 +'   set NO_TABLE_GROUP=:P1, '
                 +'       DT_CHANGE     =Now() '
                 +' where CD_STORE=:P0 '
                 +'   and NO_TABLE=:P1; ',
                 [Common.Config.StoreCode,
                  FromTable.Number]);
      ExecQueryEx('update MS_TABLE '
                 +'   set NO_TABLE_GROUP=:P2, '
                 +'       DT_CHANGE     =Now() '
                 +' where CD_STORE=:P0 '
                 +'   and NO_TABLE=:P1;',
                 [Common.Config.StoreCode,
                  ToTable.Number,
                  FromTable.Number ]);
      if ExecQueryEx('insert into SL_ORDER_LOG(CD_STORE, '
                    +'                         NO_POS, '
                    +'                         DT_CHANGE) '
                    +' select CD_STORE, NM_CODE1, Now() '
                    +'   from MS_CODE  '
                    +'  where CD_STORE  =:P0 '
                    +'    and CD_KIND   = ''01''  '
                    +'    and NM_CODE1 not in (select NO_POS '
                    +'                           from SL_ORDER_LOG  '
                    +'                          where CD_STORE =:P0) ',
                    [Common.Config.StoreCode],true) then
      begin
        if GetOption(25) = '0' then
          Common.WriteLog('work', Format('그룹지정 %s->%s',[IntToStr(FromTable.Number),IntToStr(ToTable.Number)]) )
        else
          Common.WriteLog('work', Format('그룹지정 %s->%s',[FromTable.Name,ToTable.Name]) );
      end;
      SetOrderInfo;
      SetTableVisible;
    end;
    tbmUnGroup : {그룹해제}
    begin
      OpenQuery('select NO_TABLE_GROUP '
               +'	 from MS_TABLE '
               +'	where CD_STORE	=:P0 '
               +'	  and NO_TABLE	=:P1 ',
               [Common.Config.StoreCode,
                FromTable.Number]);
      vGroupTableNo := Common.Query.Fields[0].AsInteger;
      Common.Query.Close;

      OpenQuery('select * '
               +'	 from SL_CARD_AHEAD '
               +'	where CD_STORE	=:P0 '
               +'	  and NO_TABLE	=:P1 '
               +'   and DS_CARD   =''P'' ',
               [Common.Config.StoreCode,
                FromTable.Number]);
      if not Common.Query.Eof then
      begin
        Common.Query.Close;
        Common.ErrBox('렛츠오더에서 결제한 내역이 있으면'#13'그룹을 해제할 수 없습니다');
        Exit;
      end;
      Common.Query.Close;

      ExecQueryEx('update MS_TABLE '
                 +'   set NO_TABLE_GROUP = 0 '
                 +' where CD_STORE   	    =:P0 '
                 +Ifthen(vGroupTableNo = FromTable.Number, ' and NO_TABLE_GROUP	=:P1;', ' and NO_TABLE =:P1;'),
                 [Common.Config.StoreCode,
                  FromTable.Number]);

      if ExecQueryEx('insert into SL_ORDER_LOG(CD_STORE, '
                 +'                         NO_POS, '
                 +'                         DT_CHANGE) '
                 +' select CD_STORE, '
                 +'        NM_CODE1, '
                 +'        Now() '
                 +'   from MS_CODE  '
                 +'  where CD_STORE  =:P0 '
                 +'    and CD_KIND   = ''01''  '
                 +'    and NM_CODE1 not in (select NO_POS '
                 +'                           from SL_ORDER_LOG  '
                 +'                          where CD_STORE =:P0);',
                 [Common.Config.StoreCode],true) then
      begin
        if GetOption(25) = '0' then
          Common.WriteLog('work', Format('그룹해제 %s',[IntToStr(FromTable.Number)]) )
        else
          Common.WriteLog('work', Format('그룹해제 %s',[FromTable.Name]) );

        Common.MsgBox('그룹이 해제되었습니다');
      end;
      SetOrderInfo;
    end;
    tbmMenuMoveing : {메뉴이동}
    begin
      if not AHeadCheck(FromTable.Number) then
      begin
        Common.ErrBox('선결제가 있는 테이블은'#13'메뉴를 이동할 수 없습니다');
        Exit;
      end;


      MenuMove_F := TMenuMove_F.Create(Application);
      MenuMove_F.FromTable := FromTable;
      MenuMove_F.ToTable   := ToTable;
      try
        Common.Device.OnCidReadData :=nil;
        MenuMove_F.ShowModal;
      finally
        FreeAndNil(MenuMove_F);
        SetOrderInfo;
        if Common.Config.Cid_Port > 0 then
          Common.Device.OnCidReadData :=CidReadEvent;
      end;
      if GetOption(25) = '0' then
        Common.WriteLog('work', Format('메뉴이동 %s->%s',[IntToStr(FromTable.Number),IntToStr(ToTable.Number)]) )
      else
        Common.WriteLog('work', Format('메뉴이동 %s->%s',[FromTable.Name,ToTable.Name]) )
    end;
  end;
  Common.TRSendMessage;
  Common.LastOrderTableButton := nil;
  Common.LastOrderTableNo     := 0;
  Common.LastOrderFloor       := EmptyStr;
end;

procedure TTable_F.Action1Execute(Sender: TObject);
begin
  case TableMode of
    tbmNone :
    begin
      if not CheckOrderTable then Exit;
      TableMode := tbmTableMove;
    end;
    tbmTableMove,
    tbmTableMoveing :
      begin
        TableMode := tbmNone;
      end;
  end;
end;

function TTable_F.CheckOrderTable:Boolean;
begin
  OpenQuery('select count(*) '
           +'  from SL_ORDER_H  '
           +' where CD_STORE =:P0 '
           +'   and NO_TABLE > 0 ',
           [Common.Config.StoreCode]);

  if Common.Query.Fields[0].AsInteger = 0 then
  begin
    Common.MsgBox('주문 된 테이블이 없습니다');
    Result := False;
  end
  else Result := True;
  Common.Query.Close;
end;

procedure TTable_F.SetTableGroupColor;
  function GetGroupIndex(aTableNo:Integer):Integer;
  var vIndex :Integer;
  begin
    Result := -1;
    For vIndex := 0 to ComponentCount-1 do
    begin
      if (Components[vIndex] is TPosButton) and
         ((Components[vIndex] as TPosButton).Parent = TablePanel) and
         ((Components[vIndex] as TPosButton).Number.Number = aTableNo)  then
      begin
        Result := (Components[vIndex] as TPosButton).GroupIndex;
        Break;
      end;
    end;
  end;

  procedure SetGroupIndex(aTableNo, aGroupIndex:Integer);
  var vIndex :Integer;
  begin
    For vIndex := 0 to ComponentCount-1 do
    begin
      if (Components[vIndex] is TPosButton) and
         ((Components[vIndex] as TPosButton).Parent = TablePanel) and
         ((Components[vIndex] as TPosButton).Number.Number = aTableNo)  then
      begin
        (Components[vIndex] as TPosButton).GroupIndex := aGroupIndex;
        Break;
      end;
    end;
  end;
var vGroupIndex,
    vIndex :Integer;
begin
  //저장된 테이블 내역 불러오기
  try
    DM.OpenQueryEx('select 1 as SEQ, '
                  +'       NO_TABLE_GROUP, '
                  +'       NO_TABLE, '
                  +'       NM_TABLE, '
                  +'       DT_CHANGE '
                  +'  from MS_TABLE  '
                  +' where CD_STORE =:P0 '
                  +'   and CD_FLOOR =:P1 '
                  +'   and NO_TABLE  > 0 '
                  +'   and NO_TABLE_GROUP = NO_TABLE '
                  +'union all '
                  +'select 2 as SEQ, '
                  +'       NO_TABLE_GROUP, '
                  +'       NO_TABLE, '
                  +'       NM_TABLE, '
                  +'       DT_CHANGE '
                  +'  from MS_TABLE  '
                  +' where CD_STORE =:P0 '
                  +'   and CD_FLOOR =:P1 '
                  +'   and NO_TABLE > 0 '
                  +'   and NO_TABLE_GROUP <> NO_TABLE '
                  +' order by SEQ, DT_CHANGE ',
                  [Common.Config.StoreCode,
                   Common.Table.Floor]);
  except
    on E: Exception do
    begin
      Common.WriteLog('Table_SetTableGroupColor',E.Message);
      Common.ErrBox(E.Message);
      Exit;
    end;
  end;

  For vIndex := 0 to ComponentCount-1 do
  begin
    if (Components[vIndex] is TPosButton) and
       ( (Components[vIndex] as TPosButton).Parent = TablePanel ) and
       ((Components[vIndex] as TPosButton).GroupIndex > 0 ) then
    begin
      (Components[vIndex] as TPosButton).GroupIndex := 0;
    end;
  end;

  try
    vGroupIndex := 0;
    with DM.QueryEx do
    begin
      while not Eof do
      begin
        //그룹이 지정되 있을때
        if FieldByName('no_table_group').AsInteger > 0 then
        begin
          if (FieldByName('no_table').AsInteger = FieldByName('no_table_group').AsInteger) then
          begin
            Inc(vGroupIndex);
            if (vGroupIndex <= High(Common.GroupColor)+2) then
              SetGroupIndex(FieldByName('no_table').AsInteger, vGroupIndex)
            else
              SetGroupIndex(FieldByName('no_table').AsInteger, 1);
          end
          else
          begin
            if (FieldByName('no_table_group').AsInteger > 0) and (GetGroupIndex(FieldByName('no_table_group').AsInteger) >= 0) then
              SetGroupIndex(FieldByName('no_table').AsInteger, GetGroupIndex(FieldByName('no_table_group').AsInteger));
          end;
        end;
        Next;
      end;
    end;
    DM.QueryEx.Close;
  except
    on E: Exception do
    begin
      Common.WriteLog('Table_SetTableGroupColor',E.Message);
    end;
  end;
end;

procedure TTable_F.Action20Execute(Sender: TObject);
begin
  try
    LetsOrderTakeOut_F := TLetsOrderTakeOut_F.Create(Self);
    LetsOrderTakeOut_F.ShowModal;
  finally
    FreeAndNil(LetsOrderTakeOut_F);
    if LetsOrderButtonIndex >= 0 then
    begin
      OpenQuery('select Count(*) '
               +'  from SL_LETSORDER '
               +' where CD_STORE =:P0 '
               +'   and DS_STATUS =:P1 ',
               [Common.Config.StoreCode,
                Ifthen(GetOption(62)='0','0','1')]);           //주문 시 조리중 상태로 저장합니다
      if Common.Query.Fields[0].AsInteger > 0 then
      begin
        FunctionButton[LetsOrderButtonIndex].Status.Visible := true;
        FunctionButton[LetsOrderButtonIndex].Status.Caption := '주문';
      end
      else
        FunctionButton[LetsOrderButtonIndex].Status.Visible := false;
      Common.Query.Close;
    end;
  end;
end;

procedure TTable_F.Action21Execute(Sender: TObject);
begin
  try
    AHeadPay_F := TAHeadPay_F.Create(Self);
    AHeadPay_F.ShowModal;
  finally
    FreeAndNil(AHeadPay_F);
  end;
end;

procedure TTable_F.Action22Execute(Sender: TObject);
var vFloorCode :String;
begin
  vFloorCode := Common.Table.Floor;
  with TTablet_F.Create(Self) do
  try
    FloorButtonHeight := Self.FloorButtonHeight;
    FloorWidth        := Self.FloorWidth;
    ShowModal;
  finally
    Common.Table.Floor := vFloorCode;
    FreeAndNil(Tablet_F);
  end;
end;

procedure TTable_F.Action23Execute(Sender: TObject);
begin
  LetsOrderCallList_F := TLetsOrderCallList_F.Create(Self);
  try
    LetsOrderCallList_F.ShowModal;
  finally
    FreeAndNil(LetsOrderCallList_F);
    FunctionButton[LetsOrderCallButtonIndex].Status.Visible := false;
  end;
end;

procedure TTable_F.Action24Execute(Sender: TObject);
begin
  OrderHistory_F := TOrderHistory_F.Create(Self);
  try
    OrderHistory_F.ShowModal;
  finally
    FreeAndNil(OrderHistory_F);
  end;
end;

procedure TTable_F.Action25Execute(Sender: TObject);
var vIndex :Integer;
    vLeft, vTop :Integer;
var vHandle :THandle;
    vCount :Integer;
    vRect: TRect;
    vPoint :TPoint;
label Loop;
begin
  if DeliveryPanel.Visible then
  begin
    DeliveryPanel.Visible := false;
    Exit;
  end;

  vCount := 0;
  for vIndex := 0 to High(Common.DeliveryCompany) do
  begin
    if (Common.DeliveryCompany[vIndex].WindowName = 'vFloatingIconDlg') and (FindWindow(nil, PWideChar(Common.DeliveryCompany[vIndex].WindowName)) = 0) then
    begin
      if FindWindow(PWideChar('TvBaeminOrderMain'), nil) > 0 then
      begin
        Common.DeliveryCompany[vIndex].Exists := true;
        Inc(vCount);
      end
      else
        Common.DeliveryCompany[vIndex].Exists := false;
    end
    else if (Common.DeliveryCompany[vIndex].WindowName = 'BadgeWinodw') and (FindWindow(nil, PWideChar(Common.DeliveryCompany[vIndex].WindowName)) = 0) then
    begin
      if FindWindow(nil, PWideChar('Go Yogiyo')) > 0 then
      begin
        Common.DeliveryCompany[vIndex].Exists := true;
        Inc(vCount);
      end
      else
        Common.DeliveryCompany[vIndex].Exists := false;
    end
    else if FindWindow(nil, PWideChar(Common.DeliveryCompany[vIndex].WindowName)) > 0 then
    begin
      Common.DeliveryCompany[vIndex].Exists := true;
      Inc(vCount);
    end
    else
      Common.DeliveryCompany[vIndex].Exists := false;
  end;

  if vCount = 0 then
  begin
    Common.MsgBox('실행 중인 배달접수 프로그램이 없습니다');
    Exit;
  end;

  if vCount = 1 then
  begin
    GetCursorPos(vPoint);

    for vIndex := 0 to High(Common.DeliveryCompany) do
    begin
      vHandle := FindWindow(nil, PWideChar(Common.DeliveryCompany[vIndex].WindowName));
      if vHandle > 0 then
      begin
        GetWindowRect(vHandle, vRect);
        SetCursorPos(vRect.Left+50, vRect.Top+50);
        mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
        mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
        SetCursorPos(vPoint.X, vPoint.Y);
        Exit;
        Break;
      end;
    end;
  end;

  Loop:
    for vIndex := 0 to DeliveryPanel.ControlCount-1 do
      if DeliveryPanel.Controls[vIndex] is TAdvSmoothButton then
      begin
        (DeliveryPanel.Controls[vIndex] as TAdvSmoothButton).Free;
        Goto Loop;
      end;

  vTop   := 60;
  vLeft  := 28;

  for vIndex := 0 to High(Common.DeliveryCompany) do
  begin
    if not Common.DeliveryCompany[vIndex].Exists then Continue;

    with TAdvSmoothButton.Create(Self) do
    begin
      Parent    := DeliveryPanel;
      Top       := vTop;
      Left      := vLeft;
      Height    := 84;
      Width     := 260;
      Appearance.Font.Name := '맑은 고딕';
      Appearance.Font.Size := 17;
      Appearance.Font.Color := clBlack;
      Appearance.Font.Style := [fsBold];
      Appearance.SimpleLayout := true;
      Appearance.PictureAlignment   := taLeftJustify;
      Appearance.SimpleLayout       := true;
      Appearance.SimpleLayoutBorder := true;
      Appearance.PictureStretch     := true;
      AutoSizeToPicture             := true;
      BevelColor                    := clGray;
      Color     := clWhite;
      Picture.Assign(DeliveryImageCollection.Items.Items[Common.DeliveryCompany[vIndex].Image].Picture.Graphic);
      OnClick   := DeliveryButtonClick;
      Caption   := Common.DeliveryCompany[vIndex].Caption;
      Hint      := Common.DeliveryCompany[vIndex].WindowName;
      vTop      := vTop + 90;
    end;
  end;

  DeliveryPanel.Top  := (Self.Height - DeliveryPanel.Height) div 2;
  DeliveryPanel.Left := (Self.Width  - DeliveryPanel.Width ) div 2;
  DeliveryPanel.Visible := true;
end;

procedure TTable_F.DeliveryButtonClick(Sender: TObject);
  function SubWindowFind(ParentWnd:HWND; FindClassName:String):HWND;
  var ClassName:Array[0..255] of Char;
      FindWnd :HWND;
  begin
    Result := 0;
    if ParentWnd = 0 then Exit;
    FindWnd := GetWindow(ParentWnd, GW_CHILD);
    while (FindWnd <> 0) do
    begin
      if Boolean(GetClassName(FindWnd, ClassName,255)) then
      begin
        if String(ClassName) = FindClassName then
        begin
          Result := FindWnd;
          Break;
        end;
      end;
      FindWnd := GetNextWindow(FindWnd, GW_HWNDNEXT);
    end;
  end;
var vHandle :THandle;
    vRect: TRect;
    vPoint :TPoint;
begin
  vHandle := FindWindow(nil, PWideChar((Sender as TAdvSmoothButton).Hint));

  if (Sender as TAdvSmoothButton).Hint = 'vFloatingIconDlg' then
  begin
    vHandle := FindWindow(PWideChar('TvBaeminOrderMain'), nil);
    if vHandle > 0 then
    begin
      ShowWindow(vHandle, SW_SHOWDEFAULT);
      ExecuteProgram('C:\BaeminRelay','bmrelay.exe','');
    end;
  end
  else if (Sender as TAdvSmoothButton).Hint = 'BadgeWinodw' then
  begin
    vHandle := FindWindow(nil, PWideChar('Go Yogiyo'));
    if vHandle > 0 then
      ShowWindow(vHandle, SW_SHOWDEFAULT);
  end
  else if vHandle > 0 then
  begin
    GetCursorPos(vPoint);
    GetWindowRect(vHandle, vRect);
    SetCursorPos(vRect.Left+50, vRect.Top+50);
    mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
    mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
    DeliveryPanel.Visible := false;
    SetCursorPos(vPoint.X, vPoint.Y);
  end;
  DeliveryPanel.Visible := false;
end;

procedure TTable_F.Action2Execute(Sender: TObject);
begin
  case TableMode of
    tbmNone :
    begin
      if not CheckOrderTable then Exit;
      TableMode := tbmMerge;
    end;
    tbmMerge,
    tbmMergeing :
      begin
        TableMode := tbmNone;
      end;
  end;
end;

procedure TTable_F.Action30Execute(Sender: TObject);
begin
  if Common.WorkDate = '' then
  begin
    Common.ErrBox('개점을 먼저 해야합니다');
    Exit;
  end;

  ToDaySaleQty_F := TToDaySaleQty_F.Create(Self);
  try
    ToDaySaleQty_F.ShowModal;
  finally
    FreeAndNil(ToDaySaleQty_F);
  end;
end;

procedure TTable_F.Action3Execute(Sender: TObject);
begin
  case TableMode of
    tbmNone : TableMode := tbmGroup;
    tbmGroup :
      begin
        TableMode := tbmNone;
      end;
    tbmGrouping :
      begin
        TableMode := tbmNone;
        TableCreate;
        SetOrderInfo;
        Common.MsgBox('그룹지정이 완료되었습니다');
      end;
  end;
end;

procedure TTable_F.Action4Execute(Sender: TObject);
begin
  case TableMode of
    tbmNone    : TableMode := tbmUnGroup;
    tbmUnGroup :
      begin
        TableMode := tbmNone;
      end;
  end;
end;

procedure TTable_F.Action5Execute(Sender: TObject);
begin
  case TableMode of
    tbmNone :
    begin
      if not CheckOrderTable then Exit;
      TableMode := tbmMenuMove;
    end;
    tbmMenuMove,
    tbmMenuMoveing:TableMode := tbmNone;
  end;
end;

procedure TTable_F.Action6Execute(Sender: TObject);
begin
  case TableMode of
    tbmNone :
      begin
        Booking_F := TBooking_F.Create(self);
        Booking_F.WorkType := wtNone;
        try
          Booking_F.ShowModal;
          TableMode := tbmNone;
          SetOrderInfo;
        finally
          FreeAndNil(Booking_F);
        end;
      end;
    tbmBooking : ModalResult := mrYes; {예약테이블 선택}
  end;
end;

procedure TTable_F.Action7Execute(Sender: TObject);
begin
  case TableMode of
    tbmNone :
    begin
      if not CheckOrderTable then Exit;
      TableMode := tbmRePrint;
    end;
    tbmRePrint: TableMode := tbmNone;
  end;
end;

procedure TTable_F.Action8Execute(Sender: TObject);
begin
  if TableMode <> tbmNone then Exit;
  case Common.PosType of
    ptNotAccount :
    begin
       if (Trim(Common.WorkDate) = '') then
       begin
         Common.MsgBox('개점이 안됐습니다'+#13#13+'개점을 해야 사용할 수 있습니다');
         Exit;
       end;
    end;
  end;

  FreeAndNil(Order_F);

  //배달화면 타입
  if GetOption(368) = '0' then
  begin
    Delivery_F := TDelivery_F.Create(Self);
    try
      Delivery_F.ShowModal;
    finally
      FreeAndNil(Delivery_F);
      Common.IsWorking := False;
      Common.OrderKind := okNone;
      Order_F := TOrder_F.Create(Self);
      if Common.Config.Cid_Port > 0 then
        Common.Device.OnCidReadData :=CidReadEvent;
    end;
  end
  else
  begin
    DeliveryNew_F := TDeliveryNew_F.Create(Self);
    try
      DeliveryNew_F.ShowModal;
    finally
      FreeAndNil(DeliveryNew_F);
      Common.IsWorking := False;
      Common.OrderKind := okNone;
      Order_F := TOrder_F.Create(Self);
      if Common.Config.Cid_Port > 0 then
        Common.Device.OnCidReadData :=CidReadEvent;
    end;
  end;
end;

procedure TTable_F.Action9Execute(Sender: TObject);
begin
  if GetUserOption(7) = '0' then
  begin
    if GetOption(172) = '0' then
    begin
      Common.MsgBox('사용권한이 없습니다');
      Exit;
    end
    else if not Common.CheckAuthority(7) then Exit;

    Common.Device.CashBoxOpen;
  end
  else Common.Device.CashBoxOpen;
end;

function TTable_F.AHeadCheck(aTableNo: Integer): Boolean;
begin
  Result := false;
  try
    OpenQuery('select Count(*) '
             +'  from SL_CARD_AHEAD  '
             +' where CD_STORE =:P0 '
             +'   and NO_TABLE =:P1 ',
             [Common.Config.StoreCode,
              aTableNo]);
    if Common.Query.Fields[0].AsInteger > 0 then
      Exit;
  finally
    Common.Query.Close;
  end;

  try
    OpenQuery('select Count(*) '
             +'  from SL_CASH_AHEAD  '
             +' where CD_STORE =:P0 '
             +'   and NO_TABLE =:P1 ',
             [Common.Config.StoreCode,
              aTableNo]);
    if Common.Query.Fields[0].AsInteger > 0 then
      Exit;
  finally
    Common.Query.Close;
  end;

  try
    OpenQuery('select AMT_CASH '
             +'  from SL_ORDER_H  '
             +' where CD_STORE =:P0 '
             +'   and NO_TABLE =:P1 ',
             [Common.Config.StoreCode,
              aTableNo]);
    if Common.Query.Fields[0].AsInteger > 0 then
      Exit;
  finally
    Common.Query.Close;
  end;

  Result := true;
end;

procedure TTable_F.CashBoxOpenButtonClick(Sender: TObject);
begin
  Common.Device.CashBoxOpen;
end;

procedure TTable_F.Tmr_MsgTimer(Sender: TObject);
begin
  Tmr_Msg.Tag := Tmr_Msg.Tag + 1;
  //일반메세지는 5초후에 Clear한다
  if (TableMode = tbmNone) and (Tmr_Msg.Tag > 5) then
  begin
    Tmr_Msg.Tag          := 0;
    Tmr_Msg.Enabled      := false;
    MessageLabel.Caption := '';
    MsgLabel.Caption     := '';
    MsgLabel.Visible     := false;
  end;
end;

procedure TTable_F.Action10Execute(Sender: TObject);
var vOption10 : Char;
    vTemp     : String;
begin
  TableMark := false;
  if TableMode <> tbmNone then Exit;
  try
    vOption10 := Common.Config.Options[10];
    Screen.Cursor := crHourGlass;
    if (Common.PosType = ptOnlyOrder) and  (not Common.CheckAcctPos) then Exit;
    if not Common.PosNo_Check then Exit;
    if Common.Config.RcpSearchPwd <> '' then
    begin
      vTemp := Common.ShowNumberForm('패스워드를 입력하세요', 16);
      if vTemp = 'mrClose' then Exit;

      if Common.Config.RcpSearchPwd <> vTemp then
      begin
        Common.MsgBox('패스워드가 올바르지 않습니다');
        Exit;
      end;
    end;

    //자동마감
    if not Common.Config.IsKiosk and (GetOption(375) = '1') and (Common.PosType <> ptOnlyOrder) then
      Common.PosAutoCloseOpen;

    if Assigned(Order_F) then
      FreeAndNil(Order_F);
    if Assigned(RcpChange_F) then
      FreeAndNil(RcpChange_F);
    RcpChange_F    := TRcpChange_F.Create(Application);

    RcpChange_F.Height := 768;
    RcpChange_F.Width  := 1024;
    try
      RcpChange_F.ShowMode := fsmNone;
      Common.Device.OnCidReadData := nil;
      RcpChange_F.ShowModal;
    finally
      BlockInput(true);
      Common.ShowNormalDualScreen;
      Order_F := TOrder_F.Create(Self);
      if Common.Config.Cid_Port > 0 then
        Common.Device.OnCidReadData :=CidReadEvent;
    end;
  finally
    Common.Config.Options[10] := vOption10;
    Screen.Cursor := crDefault;
    SetOrderInfo;
    BlockInput(false);
  end;
end;

procedure TTable_F.Action11Execute(Sender: TObject);
begin
  try
    Screen.Cursor := crHourGlass;
    if not Common.CheckAcctPos then Exit;
    if not Common.PosNo_Check  then Exit;

    CashBook_F := TCashBook_F.Create(Self);
    try
      Common.Device.OnCidReadData := nil;
      CashBook_F.ShowModal;
    finally
      FreeAndNil(CashBook_F);
      if Common.Config.Cid_Port > 0 then
        Common.Device.OnCidReadData :=CidReadEvent;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TTable_F.Action12Execute(Sender: TObject);
begin
  try
    Screen.Cursor := crHourGlass;
    if not Common.PosNo_Check then Exit;

    Work_F := TWork_F.Create(Self);
    try
      Common.Device.OnCidReadData :=nil;
      Work_F.ShowModal;
    finally
      FreeAndNil(Work_F);
      if Common.Config.Cid_Port > 0 then
        Common.Device.OnCidReadData :=CidReadEvent;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TTable_F.Action13Execute(Sender: TObject);
var vIndex :Integer;
begin
  Common.Device.BefCustomerOrderPrint;
  Common.KitchenDataCopy(1);
  Common.Device.OrderPrint(false, true);
  Common.ClearKitchenData;

  Common.PrintBuffer.Clear;
  for vIndex := 0 to Common.BackupPrintBuffer.Count-1 do
    Common.PrintBuffer.Add(Common.BackupPrintBuffer.Strings[vIndex]);

  Common.Device.PrintPrinter(1);
end;

procedure TTable_F.Action14Execute(Sender: TObject);
begin
  if TableMode <> tbmNone then Exit;
  if (Common.PosType = ptOnlyOrder) and  (not Common.CheckAcctPos) then Exit;
  if Common.OrderKind <> okSaleChange then
    Common.OrderKind := okNew;
  InitTableRecord(Common.Table);
  Common.Config.IsTakeOut := True;
  if not Assigned(Order_F) then
     Order_F := TOrder_F.Create(Self);
  try
    if Order_F.ShowModal = mrAbort then
    begin
      Common.ShowWaitForm('잠시만 기다려 주세요');
      RcpManagerTimer.Enabled := true;
    end;

  finally
    Common.ShowNormalDualScreen;
    Common.OrderKind      := okNone;
    Common.Config.IsTakeOut := False;
    if Common.Config.Cid_Port > 0 then
      Common.Device.OnCidReadData :=CidReadEvent;
  end;
end;

procedure TTable_F.Action15Execute(Sender: TObject);
begin
  Wait_F := TWait_F.Create(Application);
  try
    Wait_F.isOrder := true;
    if Wait_F.ShowModal = mrYes then
    begin
      WaitOrderTableNo := Wait_F.WaitTableNo;
      Common.MsgBox('대기손님이 미리 주문하셨습니다'#13#13'이용할 테이블을 선택하세요');
      TableMode := tbmWaitOrder;
    end;
  finally
    Application.ProcessMessages;
    FreeAndNil(Wait_F);
  end;
end;

procedure TTable_F.Tmr_TimeTimer(Sender: TObject);
begin
  if Assigned(OrderInfoButton) and (OrderInfoButton.Tag = 1) and (Pos('원',OrderInfoButton.Caption) > 0) then
    OrderInfoButton.Status.Caption  := FormatDateTime('hh:nn', Now())
  else
  begin
    OrderInfoButton.Status.Caption  := '';
    if OrderInfoButton.Tag = 1 then
    begin
      OrderInfoButton.Left      := 600;
      OrderInfoButton.Width     := 237;
      OrderInfoButton.Caption   := FormatDateTime('hh:nn ss', Now());
    end
    else
      OrderInfoButton.Caption   := FormatDateTime('hh:nn', Now());
  end;
  if Tmr_Time.Tag = 1 then
  begin
    isTableRefresh := true;
    Tmr_Time.Tag   := 0;
  end;
end;

procedure TTable_F.CidReadEvent(const S: String);
begin
  Common.WriteLog('work', Format('Table-CidReadEvent(%s)',[S]));
  try
    FreeAndNil(Order_F);

    //배달화면 타입
    if GetOption(368) = '0' then
    begin
      Delivery_F := TDelivery_F.Create(Application);
      try
        Delivery_F.FCidTelNo        := S;
        Delivery_F.ShowModal;
      finally
        try
          BlockInput(true);
          Delivery_F.FCidTelNo := '';
          FreeAndNil(Delivery_F);
          Order_F := TOrder_F.Create(Self);
        finally
          BlockInput(false);
        end;
        if Common.Config.Cid_Port > 0 then
          Common.Device.OnCidReadData :=CidReadEvent;
      end;
    end
    else
    begin
      DeliveryNew_F := TDeliveryNew_F.Create(Application);
      try
        DeliveryNew_F.FCidTelNo        := S;
        DeliveryNew_F.ShowModal;
      finally
        try
          BlockInput(true);
          DeliveryNew_F.FCidTelNo := '';
          FreeAndNil(DeliveryNew_F);
          Order_F := TOrder_F.Create(Self);
        finally
          BlockInput(false);
        end;
        if Common.Config.Cid_Port > 0 then
          Common.Device.OnCidReadData :=CidReadEvent;
      end;
    end;
  except
    on E: Exception do
      Common.WriteLog('Table_F(CidReadEvent)',E.Message);
  end;
end;

procedure TTable_F.CloseButtonClick(Sender: TObject);
begin
  if (MilliSecondsBetween(Now(),ClickTime) < 100) and (ClickObject = Sender) then Exit;
  ClickTime   := Now;
  ClickObject := Sender;

  if TableMode = tbmBooking then Action6.Execute
  else Close;
end;

procedure TTable_F.Action16Execute(Sender: TObject);
begin
  if (Common.PosType = ptOnlyOrder) and  (not Common.CheckAcctPos) then Exit;
  case TableMode of
    tbmNone :
    begin
      if not CheckOrderTable then Exit;
      TableMode := tbmDutchPay;
    end;
    tbmDutchPay: TableMode := tbmNone;
  end;
end;

procedure TTable_F.Action17Execute(Sender: TObject);
begin
  case TableMode of
    tbmNone :
    begin
      OpenQuery('select count(*) '
               +'  from MS_TABLE  '
               +' where CD_STORE =:P0 '
               +'   and YN_TABLEHOLD = ''Y'' ',
               [Common.Config.StoreCode]);

      if Common.Query.Fields[0].AsInteger = 0 then
      begin
        Common.Query.Close;
        Common.MsgBox('이용 중인 테이블이 없습니다');
        Exit;
      end;
      Common.Query.Close;
      TableMode := tbmClear;
    end;
    tbmClear:TableMode := tbmNone;
  end;
end;

procedure TTable_F.Action18Execute(Sender: TObject);
begin
  if GetOption(363)='1' then
  begin
    Common.MsgBox('사용할 수 없는 기능입니다');
    Exit;
  end;
  MenuAdd_F := TMenuAdd_F.Create(Self);
  Order_F.isPLUReFlash := true;
  try
    MenuAdd_F.WorkPluNo  := Common.Config.PluNo;
    MenuAdd_F.isMenuAdd := true;
    MenuAdd_F.ShowModal;
  finally
    FreeAndNil(MenuAdd_F);
  end;
end;

procedure TTable_F.cxColorComboBox1PropertiesCloseUp(Sender: TObject);
begin
  cxColorComboBox1.Visible := False;
  TableMode := tbmNone;
  SetOrderInfo;
end;

procedure TTable_F.cxColorComboBox1PropertiesChange(Sender: TObject);
begin
  ExecQueryEx('update SL_ORDER_H '
             +'   set TABLE_COLOR   =:P2 '
             +' where CD_STORE =:P0 '
             +'   and NO_TABLE =:P1 '
             +'   and DS_ORDER = ''T'';',
             [Common.Config.StoreCode,
              Common.Table.Number,
              ColorToString(cxColorComboBox1.ColorValue)],true);
  cxColorComboBox1.Visible := False;
  TableMode := tbmNone;
end;

procedure TTable_F.Action19Execute(Sender: TObject);
begin
  if GetOption(363)='1' then
  begin
    Common.MsgBox('사용할 수 없는 기능입니다');
    Exit;
  end;
  MenuAdd_F := TMenuAdd_F.Create(Self);
  try
    MenuAdd_F.WorkPluNo  := Common.Config.PluNo;
    MenuAdd_F.isMenuAdd := false;
    MenuAdd_F.ShowModal;
  finally
    FreeAndNil(MenuAdd_F);
  end;
end;

procedure TTable_F.Tmr_TableStateTimer(Sender: TObject);
begin
  Tmr_TableState.Enabled := false;
  SetOrderInfo;
end;

procedure TTable_F.Tmr_TableKeyTimer(Sender: TObject);
begin
  Tmr_TableKey.Enabled := False;
  TableButtonClick(TableKeyButton);
end;

procedure TTable_F.Tmr_TableMarkTimer(Sender: TObject);
var vIndex, vTableNo, vCount :Integer;
    vTableName :String;
begin
  vCount := 0;
  For vIndex := 0 to High(MarkTableData) do
  begin
    if (MarkTableData[vIndex,1] <> '') and (StrToDateTime(MarkTableData[vIndex,1]) > Now()) then
    begin
      Inc(vCount);
      if Assigned(TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]])))) then
      begin
        if MarkTableData[vIndex,2] = 'LETSORDER' then
        begin
          if MarkTableData[vIndex,3] = '' then
          begin
            MarkTableData[vIndex,3] := ColorToString(TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]]))).BorderColor);
            MarkTableData[vIndex,4] := ColorToString(TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]]))).Amount.Font.Color);
          end;

          TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]]))).BorderInnerColor  := clRed;
          TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]]))).BorderColor       := clRed;
          TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]]))).Amount.Font.Color := clRed;
        end
        else
        begin
          vTableNo := TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]]))).Number.Number;
          vTableName := TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]]))).Number.TempString;
          if Assigned(TAdvSmoothButton(FindComponent(Format('TableImageButton%d',[vTableNo])))) then
            TAdvSmoothButton(FindComponent(Format('TableImageButton%d',[vTableNo]))).Status.Caption := Format(' %s-테이블정리',[vTableName]);
          TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]]))).Amount.Font.Color := clRed;
          TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]]))).Amount.Caption := '[테이블정리]';
        end
      end;
    end
    else
    begin
      if Assigned(TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]])))) then
      begin
        if MarkTableData[vIndex,2] = 'TableClear' then
        begin
          vTableNo := TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]]))).Number.Number;
          vTableName := TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]]))).Number.TempString;

          if Assigned(TAdvSmoothButton(FindComponent(Format('TableImageButton%d',[vTableNo])))) then
            TAdvSmoothButton(FindComponent(Format('TableImageButton%d',[vTableNo]))).Status.Caption := vTableName;
          TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]]))).Amount.Caption := EmptyStr;
          TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]]))).Amount.Font.Color := StringToColorDef(TPosButton(FindComponent(Format('Table%s',[MarkTableData[vIndex,0]]))).Temp5, clBlue);
        end;
      end;
    end;
  end;
  if vCount = 0 then
    TableMark := false;
end;

procedure TTable_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [ssCtrl] then
  begin
    if Key = Ord('T') then
      CidReadEvent('C1I01011112222');
  end;
end;

procedure TTable_F.Action26Execute(Sender: TObject);
var vHandle :THandle;
begin
  vHandle := FindWindow(PWideChar('TvBaeminOrderMain'), nil);
  if vHandle > 0 then
  begin
    ShowWindow(vHandle, SW_SHOWDEFAULT);
    ExecuteProgram('C:\BaeminRelay','bmrelay.exe','') ;
  end
  else
    Common.MsgBox('배민 프로그램이'#13'실행되어 있지 않습니다');
end;

procedure TTable_F.Action27Execute(Sender: TObject);
var vHandle :THandle;
    vRect: TRect;
    vPoint :TPoint;
begin
  vHandle := FindWindow(nil, PWideChar('coupang POS'));
  if vHandle > 0 then
  begin
    GetCursorPos(vPoint);
    GetWindowRect(vHandle, vRect);
    SetCursorPos(vRect.Left+50, vRect.Top+50);
    mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
    mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
    SetCursorPos(vPoint.X, vPoint.Y);
  end
  else
    Common.MsgBox('쿠팡포스 프로그램이'#13'실행되어 있지 않습니다');
end;

procedure TTable_F.Action28Execute(Sender: TObject);
var vHandle :THandle;
    vRect: TRect;
    vPoint :TPoint;
begin
  vHandle := FindWindow(nil, PWideChar('Go Yogiyo'));
  if vHandle > 0 then
    ShowWindow(vHandle, SW_SHOWDEFAULT)
  else
    Common.MsgBox('요기요 프로그램이'#13'실행되어 있지 않습니다');
end;

procedure TTable_F.Action29Execute(Sender: TObject);
begin
  MenuAdd_F := TMenuAdd_F.Create(Self);
  try
    MenuAdd_F.isMenuAdd    := false;
    MenuAdd_F.isSetSoldOut := true;
    MenuAdd_F.WorkPluNo    := Common.Config.PluNo;
    MenuAdd_F.ShowModal;
  finally
    FreeAndNil(MenuAdd_F);
  end;
end;

end.





















































































