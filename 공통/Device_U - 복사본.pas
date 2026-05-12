{******************************************************************************

                 Copyright (c) 2007 ExtremePOS

 * Unit Name   : Device_U.pas
 * Purpose     : 주변기기 제어 모듈
 * Make Date   : 2007/07/28
 * Programming : 김 환 준
 * History     :
 ******************************************************************************}
unit Device_U;

interface

uses  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, Variants, MaskUtils, ComObj, DB,
  IdTCPClient, CPort, Grids, StrUtils, MSNPopUp,
  ExtCtrls, IdGlobal, IniFiles, nrcomm,
  cxGridTableView, KiccDSC_TLB, DateUtils, POSCard, IdTCPServer, IdContext,
  IdTCPConnection, IdUDPClient;

type
  TCashDrawerOpen = function(OutPort, OpenPort:Integer):Integer; stdcall;

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

type
  TDevice = Class
  private
    MSNPopUp       : TMSNPopUp;
    PrintComPort   : TnrComm;
    MsrComPort     : TnrComm;
    CidComPort     : TnrComm;                //콜스타 컴포트
    KiccDSCX       : TKiccDSCX;
    ScannerComPort : TnrComm;                //스캐너 컴포트
    FixScannerComPort : TnrComm;             //스캐너 컴포트
    LabelPrinterComPort : TnrComm;           //라벨프린터 컴포트
    BellComPort    : TnrComm;
    JtentICDetectComPort :TnrComm;
    PrinterSocket  : TIdTCPClient;            //주방프린터 출력용 소켓
    FScannerTimer  : TTimer;
    FCidTimer      : TTimer;
    FDispenserTimer: TTimer;
    FCidTimeOutTimer :TTimer;
    PadServer      : TIdTCPServer;
    PadClient      : TidUDPClient;
    DispenserComPort  : TnrComm;
    BaeminComPort  : TnrComm;                 //라이더 호출시 사용
    LinkComPort    : TnrComm;
    Link2ComPort   : TnrComm;
    Link3ComPort    : TnrComm;
    Link4ComPort   : TnrComm;

    CheckData      : String;
    LinkPortData   : AnsiString;
    Link2PortData  : AnsiString;
    Link3PortData  : AnsiString;
    Link4PortData  : AnsiString;
    IsCheck        : Boolean;                 //저울체크모드인지 여부
    SignImage      : TImage;
    FScannerBuff, FCidBuff   : AnsiString;
    FScannerData, FCidData   : AnsiString;
    FDispenserData    : AnsiString;
    JtnetDetectData   : AnsiString;
    FOnScannerReadData  : TGetStrProc;
    FOnCidReadData      : TGetStrProc;
    FOnDispenserReadData    : TGetStrProc;
    IsPrinting     : Boolean;                 //출력중인지
    pLen           : Integer;
    pStr           : String;
    FCidTimeOut    : Boolean;
    FFaleCount     : Integer;

    procedure AddPrintData(aData:AnsiString);
    procedure PrintToTxt(aMustPrint:Boolean=false);                     //텍스트화일로 저장
    procedure Cashier_Header(AIndex:Integer; ACorner:String='');
    procedure DetailPrint;                    //영수증디테일출력
    procedure TrustPrint;                      //외상결제내역출력(마트용)
    procedure MemPointPrint;                  //포인트결제내역 출력 (마트용)
    procedure PrinterPortOpen;
    procedure CIDPortOpen;
    procedure LinkPortOpen;
    procedure Link2PortOpen;
    procedure Link3PortOpen;
    procedure Link4PortOpen;
    procedure ScannerPortOpen;                //스캐너포트오픈
    procedure LabelPrinterPortOpen;           //라벨프린터포트오픈
    procedure BellPortOpen;                   //진동벨포트오픈
    procedure DispenserPortOpen;
    procedure JtnetICDetectPortOpen;
    procedure ScannerTimerTimer(Sender: TObject);
    procedure CidTimerTimer(Sender: TObject);
    procedure DispenserTimerTimer(Sender: TObject);
    procedure CidTimeOutTimer(Sender: Tobject);
    procedure CheckCidDeivce;
    procedure KiccDSCXRcvPinData(ASender: TObject; const Flag,
              Data: WideString; DataLen: Integer);
    function  GetKiccPrinterFormat(aData:String):String;
    procedure PadServerExecute(AContext: TIdContext);
  public
    FDispenserBuff,
    PrintData      : AnsiString;                  //출력할 데이터

    isCIDCheck     : Boolean;
    BefCustomerOrder :String;                 //이전고객주문서
    constructor Create;
    destructor Destroy; override;
    procedure DeviceSetup;

    //신용카드 승인즉시 출력시 
    procedure CreditPrint(Kind:Integer=0);
    //현금영수증 선결제시 출력
    procedure CashRcpPrint;
    /////////////////////// 프린터 ////////////////////////////
    function  PrinterCheck: String;
    procedure Receipt_Print(Kind:Char);                              //영수증출력
    procedure Receipt_Ahead;
    procedure Ready_Prt(CashAmt, CashOld:Double);                    //준비금영수증
    procedure DepositPrint(DepositAmt, TotalDepositAmt:Double);      //중간입금영수증
    procedure CashBoxOpen(Kind:Integer=0);                           //영수증 출력(서말)
    procedure CardPrint(aKind:Integer=0);                            //카드승인내역출력
    procedure CashierClosePrint(CloseNo:String='');                  //계산원마감출력
    procedure PosClosePrint(Kind:Integer=0);                         //포스마감시 원장별정산, 시재장출력(0-포스정산, 1-전체정산)
    procedure CardSaleBuyPrint(CloseNo:String='');                   //신용카드내역 매입사별
    procedure CardSalePrint(CloseNo:String='');                      //신용카드내역 전부출력
    procedure MenuSalePrint(CloseNo:String='');                      //메뉴별정산서
    procedure ClassSalePrint(CloseNo:String='');                     //분류별정산서
    procedure ClassMenuSalePrint(CloseNo:String='');                     //분류별정산서
    procedure TimeSalePrint(CloseNo:String='');                      //시간대별정산서
    procedure DiscountPrint(CloseNo:String='');                      //할인내역
    procedure ServicePrint(CloseNo:String='');                       //서비스내역
    procedure CashBookPrint(CloseNo:String='');                      //출납내역
    procedure DamdangPrint(CloseNo:String='');                       //담당자매출내역
    procedure OrderCancelPrint;                                      //주문취소내역
    procedure SaleCancelPrint;                                       //매출취소내역
    procedure PackingSalePrint(CloseNo:String='');
    procedure DeliveryDamdangPrint;
    procedure CornerByPrint;
    procedure ReservePrint;
    procedure BookingPrint(aKind:Integer; aValue:String);            //예약자명단출력
    procedure CloseCashRcpPrint(CloseNo:String='');
    procedure BefCustomerOrderPrint;
    procedure PrintSimpluRcp(aType,aValue:Integer);                  //간이영수증(aType 0-현금, 1:카드)
    function  SetImage(aFileName:String;aSize:Char;aCount:Integer=0):String;          //동적이미지데이터 생성
    procedure SetTitle(aCorner:String;aType:Integer=0);
    function  WaitTicketPrint(aWaitNumber, aWaitPerson, aWaitKid, aTeamCount, aWaitTime:Integer; aTelNo:String):Boolean;                       //대기표출력
    procedure ItemLabelPrint;                                        //아이템메뉴 라벨 출력
    procedure LabelPrinterPrint(aValue:String);
    procedure DeliveryTelPrint(aIndex:Integer);
    procedure SaleReportPrint(aGrid:TcxGridTableView;aKind:Integer;aSaleDate:String);
    procedure MemberTrustReceivePrint(aValue: Integer; aAcctNo:String='');              //호출번호 셋팅
    procedure SetBell(aBellNo:Integer);
    procedure CallBell(aBellNo:Integer);
    procedure CouponPrint;
    procedure TicketPrint;
    procedure UPSSPrint;                                             //위해상품차단 출력
    procedure SetPrintPort(aValue:Boolean);
    procedure SetJtentDetect(aValue:Boolean);
    procedure TaxRefundPrint(aApproval:Boolean; aTaxfreeNo, aSaleDate:String; aRefundAmt:Currency);
    function  SendToPad(aData:String;aMsgShow:Boolean=true):Boolean;
    function  SendToDispenser(aData:AnsiString):Boolean;

    function  StrToHex(vsSource: string;var RevData:Array of String): Integer;
    function  SetOrderPrintHeader(AValue:String;AIndex:Integer):String;  //일반주문시 주방주문서 헤더
    procedure PrintKitchen(aCode, aMenu, aSubMenu, aMemo, aQty, aAmt, aSpcDC, aKitchen, aMenuType, aDSSale, aDsTax, aCorner,
                           aMaster, aMasterQty, aMenuCode :AnsiString;aGroup, aSeq, aStep, aRealQty:Integer;
                           aCustomerSubMenuPrint,aKitchenSubMenuPrint,aBill,aDouble,aKitchenMenuName:AnsiString);
    procedure OrderCancel(aGrid:TStringGrid;ARow:Integer;AQty:String);

    ///////////////////////////////////////////////////////////////////////////
    //                       Local 프린터 제어                               //
    ///////////////////////////////////////////////////////////////////////////
    procedure PrinterRxChar(Com: TObject; Buffer: Pointer; Received: Cardinal);
    procedure LinkRxChar(Com: TObject; Buffer: Pointer; Received: Cardinal);
    procedure Link2RxChar(Com: TObject; Buffer: Pointer; Received: Cardinal);
    procedure Link3RxChar(Com: TObject; Buffer: Pointer; Received: Cardinal);
    procedure Link4RxChar(Com: TObject; Buffer: Pointer; Received: Cardinal);
    procedure CidRxChar(Com: TObject; Buffer: Pointer; Received: Cardinal);
    procedure ExecuteCID(aData:String);
    procedure CheckRxChar(Com: TObject; Buffer: Pointer; Received: Cardinal);
    procedure ScannerRxChar(Com: TObject; Buffer: Pointer; Received: Cardinal);
    procedure PrintPrinter(AType:Integer=0);
    procedure DispenserRxChar(Com: TObject; Buffer: Pointer; Received: Cardinal);
    procedure JtentICDetectRxChar(Com: TObject; Buffer: Pointer; Received: Cardinal);


    ///////////////////////////////////////////////////////////////////////////
    //                       주방프린터 프린터 제어                          //
    ///////////////////////////////////////////////////////////////////////////
    function  OrderSend(aKind,aCode,aData,aHost,aPort :String):String;
    procedure OrderPrint(aValue:Boolean=True;aValue1:Boolean=True);
    function  PrinterCommendReplace(aValue:String;aDevice,aCol,aMagin:Integer):String;
    procedure KitchenOrderPrint(AIndex:Integer);
    procedure CustomerOrderPrint(aOrderNo,AType:Integer);

    procedure TableWork(aGrid:TStringGrid=nil;aKind:Integer=0);

    ///////////////////////////////////////////////////////////////////////////
    //                            배달전표 출력                              //
    ///////////////////////////////////////////////////////////////////////////
    procedure DeliveryPrint(aCount:Integer=1);
    procedure DeliveryReceiptPrint;
    function  DeliveryDishRetrunListPrint(aCode:String):Boolean;
    procedure BaeminKitchPrint(aTableNo:Integer; aDeliveryNo, aAddress, aTableMemo:String);
    procedure RiderCall(aData:String);

    property OnScannerReadData : TGetStrProc read FOnScannerReadData write FOnScannerReadData;
    property OnCidReadData : TGetStrProc read FOnCidReadData write FOnCidReadData;
    property OnDispenserReadData : TGetStrProc read FOnDispenserReadData write FOnDispenserReadData;
  end;

var
  PrinterCom   : THandle;
  PrnComDCB    : TDCB;
  tPrn         : TextFile;
  CDPCom       : THandle;
  CDPComDCB    : TDCB;
  CmdChar      : Array[0..10] of String;
  HexData      : Array[0..80] of String;
  PrinterStatus: String;
  LPTFile  : THandle;
const rptNone      = 0;
      rptReceipt   = 1;
      rptCustOrder = 2;
      rptHold      = 3;
      rptReady     = 4;
      rptMid       = 5;
      rptCashier   = 6;
      rptPosClose  = 7;
      rptDelivery  = 8;
      rptCredit    = 9;
      rptReceipt1  = 10;
      rptSimpleRcp = 11;
      rptBooking   = 12;
      rptWaitTicket= 13;
      rptPinCode   = 14;
      rptNotTel    = 15;
      rptParking   = 16;
      rptSaleRpt   = 17;
      rptCoupon    = 18;
      rptDeliveryReceipt=19;
      rptUPSS      = 20;
      rptTicket    = 21;
      rptTaxRefund = 22;
      rptLink      = 23;
      rptLink2     = 24;
      rptLetsOrder = 25;

      mm2pt      = 4;     // mm를 화면용 포인트로 바꾸는 비율
      mm2dot     = 8;     // mm를 프린터용 도트로 바꾸는 비율

implementation

uses Common_U, GlobalFunc_U, Const_U, DbModule_U, Order_U,
     Table_U, Card_U, CashRcp_U, Member_U, DeliveryInfo_U, Main_U,
     Check_U, NumPan_U, SaleReport_U, MemberAdd_U, IdIOHandler,
     Delivery_U, Math, Uni, DeliveryNew_U, MultiCard_U, MultiCashRcp_U,
     SmartPadSign, QuesMsg_U, PadWait_U, KioskCash_U, IdUDPBase;

constructor TDevice.Create;
begin
   MSNPopUp := TMSNPopUp.Create(Application);
   MSNPopUp.Options := [];
   {프린터 컴포트 생성}
   PrintComPort := TnrComm.Create(Application);
   PrintComPort.OnAfterReceive := PrinterRxChar;

   CidComPort := TnrComm.Create(Application);
   CidComPort.OnAfterReceive := CidRxChar;

   BaeminComPort := TnrComm.Create(Application);

   LinkComPort := TnrComm.Create(Application);
   LinkComPort.OnAfterReceive := LinkRxChar;

   Link2ComPort := TnrComm.Create(Application);
   Link2ComPort.OnAfterReceive := Link2RxChar;

   Link3ComPort := TnrComm.Create(Application);
   Link3ComPort.OnAfterReceive := Link3RxChar;

   Link4ComPort := TnrComm.Create(Application);
   Link4ComPort.OnAfterReceive := Link4RxChar;

   {KiccDSC OCX 생성}
   try
     KiccDSCX := TKiccDSCX.Create(Application);
     KiccDSCX.OnRcvPinData := KiccDSCXRcvPinData;
   except
   end;

   isCIDCheck := false;
   {주방주문서 전송용 클라이언트 소켓생성}
   PrinterSocket := TIdTCPClient.Create(Application);
   PrinterSocket.port := 7002;
   PrintData     := EmptyStr; //영수증 프린터에 출력할 데이터

   {MSR ComPort 생성}
   MsrComPort := TnrComm.Create(Application);
   MsrComPort.Tag := 5;
   MsrComPort.OnAfterReceive := PrinterRxChar;

   {스캐너컴포트 생성}
   ScannerComPort := TnrComm.Create(Application);
   ScannerComPort.OnAfterReceive := ScannerRxChar;
   FixScannerComPort := TnrComm.Create(Application);
   FixScannerComPort.OnAfterReceive := ScannerRxChar;

   {라벨프린터 컴포트 생성}
   LabelPrinterComPort := TnrComm.Create(Application);

   {진동벨 컴포트 생성}
   BellComPort := TnrComm.Create(Application);

   {키오스크 지폐/동전호퍼}
   DispenserComPort := TnrComm.Create(Application);
   DispenserComPort.OnAfterReceive := DispenserRxChar;

   {JTNET IC Detect 컴포트 생성}
   JtentICDetectComPort := TnrComm.Create(Application);
   JtentICDetectComPort.OnAfterReceive := JtentICDetectRxChar;

   FScannerTimer := TTimer.Create(Application);
   FScannerTimer.Interval := 10;
   FScannerTimer.Enabled := False;
   FScannerTimer.OnTimer := ScannerTimerTimer;

   FCidTimer := TTimer.Create(Application);
   FCidTimer.Interval := 1;
   FCidTimer.Enabled := False;
   FCidTimer.OnTimer := CidTimerTimer;

   FDispenserTimer := TTimer.Create(Application);
   FDispenserTimer.Interval := 1;
   FDispenserTimer.Enabled := False;
   FDispenserTimer.OnTimer := DispenserTimerTimer;

   FCidTimeOutTimer := TTimer.Create(Application);
   FCidTimeOutTimer.Interval := 30000;
   FCidTimeOutTimer.Enabled := False;
   FCidTimeOutTimer.OnTimer := CidTimeOutTimer;

   PadServer      := TIdTCPServer.Create(Application);
   PadServer.Bindings.Add.IP :='0.0.0.0';
   PadServer.Bindings.Add.Port := 7007;
   PadServer.OnExecute := PadServerExecute;

   PadClient := TIdUDPClient.Create(Application);
   PadClient.Host := Common.GetIniFile('POS','스마트패드IP','');

   IsCheck := False;
   BefCustomerOrder := EmptyStr;
   CheckData := EmptyStr;
   FFaleCount    := 0;

   SignImage := TImage.Create(Application);
   SignImage.AutoSize := True;

   IsPrinting := False;
end;

destructor TDevice.Destroy;
begin
   MSNPopUp.Free;
   PrintComPort.Free;
   BaeminComPort.Free;
   LinkComPort.Free;
   Link2ComPort.Free;
   Link3ComPort.Free;
   Link4ComPort.Free;
   MsrComPort.Free;
   CidComPort.Free;
   KiccDSCX.Free;
   DispenserComPort.Free;
   JtentICDetectComPort.Free;

   SignImage.Free;
end;
////////////////////////////////////////////////////////////////////////////////
// Name         : DeviceSetup
// Type         : procedure
// Explanation  : Device 환경설정
////////////////////////////////////////////////////////////////////////////////
procedure TDevice.DeviceSetup;
begin
  {플래쉬화일 셋팅}
  Common.FlashData.Clear;
  OpenQuery('select NM_CODE1 '
           +'  from MS_CODE '
           +' where CD_STORE =:p0 '
           +'   and (CD_KIND = ''96'' or CD_KIND = ''97'') '
           +' order by CD_CODE ',
           [Common.Config.StoreCode]);
  While not Common.Query.Eof do
  begin
    if FileExists(Format('%sDual\%s',[Common.AppPath,Common.Query.FieldByName('NM_CODE1').AsString])) then
      Common.FlashData.Add( Common.Query.FieldByName('NM_CODE1').AsString );
    Common.Query.Next;
  end;
  Common.Query.Close;

  OpenQuery('select DELIVERY_TIME '
           +'  from MS_STORE '
           +' where CD_STORE =:P0',
           [Common.Config.StoreCode]);
  FCidTimeOutTimer.Interval := Common.Query.Fields[0].AsInteger * 1000;
  Common.Query.Close;

  if PrintComPort.Active          then PrintComPort.Active := false;
  if LinkComPort.Active           then LinkComPort.Active := false;
  if Link2ComPort.Active          then Link2ComPort.Active := false;
  if Link3ComPort.Active          then Link3ComPort.Active := false;
  if Link4ComPort.Active          then Link4ComPort.Active := false;
  if MsrComPort.Active            then MsrComPort.Active := false;
  if CidComPort.Active            then CidComPort.Active := false;
  if ScannerComPort.Active        then ScannerComPort.Active := false;
  if FixScannerComPort.Active     then FixScannerComPort.Active := false;
  if LabelPrinterComPort.Active   then LabelPrinterComPort.Active := false;
  if BellComPort.Active           then BellComPort.Active := false;
  if DispenserComPort.Active      then DispenserComPort.Active := false;
  if JtentICDetectComPort.Active  then JtentICDetectComPort.Active := false;

  PrinterPortOpen;
  CIDPortOpen;
  LinkPortOpen;
  Link2PortOpen;
  Link3PortOpen;
  Link4PortOpen;
  ScannerPortOpen;
  CheckCidDeivce;
  LabelPrinterPortOpen;
  BellPortOpen;
  DispenserPortOpen;
  JtnetICDetectPortOpen;
  Common.ICCard.SmartPadIP := PadClient.Host;
  if Common.Config.SmartPad then
    PadServer.Active := true;

  if Common.Config.PrintColum = 1 then
  begin
    pLen := 6;
    pStr := '   ';
  end
  else
  begin
    pLen := 0;
    pStr := EmptyStr;
  end;
end;

procedure TDevice.PrinterPortOpen;                   //영수증프린터 셋팅
begin
  //프린터를 설정하지 않았으면 그냥 빠져나감
  if (Common.Config.ReceiptPrinterDev = 0) or (Common.Config.ReceiptPrinterPort[1] in ['0','E']) then Exit;
  if Common.Config.RcpToKitchen and not Common.isReceiptToKitehcn then Exit;

  if Common.Config.ReceiptPrinterDev = prtKICC then
  begin
    try
      KiccDSCX.Open := false;
      KiccDSCX.Port := StoI(Common.Config.ReceiptPrinterPort);
      KiccDSCX.LineType := 0 - cTRS232;
      KiccDSCX.HwType   := 0 - EP1000;
  //    KiccDSCX.ReqSendRS232 := '';

      case Common.Config.ReceiptPrinterBaudRate of
        0 : KiccDSCX.Speed := 9600;
        1 : KiccDSCX.Speed := 19200;
        2 : KiccDSCX.Speed := 38400;
        3 : KiccDSCX.Speed := 57600;
        4 : KiccDSCX.Speed := 115200;
      end;
      Sleep(100);
      KiccDSCX.Open := true;
      Exit;
    except
      on E: Exception do
      begin
        Common.ErrBox('영수증프린터(KICC)를 초기화하지 못했습니다'+#13+e.Message);
      end;
    end;
  end
  else if (GetOption(379) = '1') and (Common.PosType <> ptOnlyOrder) then
  begin
    if (Common.Config.van_trd = vanFDIK) and (Common.ICCard.FDIK_Init) then
    begin
      Common.ICCard.AppType := atCatCard;
      Common.ICCard.VAN     := vtFDIK;
      Common.ICCard.Execute;
    end;
  end;

  PrintComPort.Active := false;

  PrintComPort.ComPortNo      := StoI(Common.Config.ReceiptPrinterPort);
  PrintComPort.BufferInSize   := 4096 * 2;
  PrintComPort.BufferOutSize  := 4096 * 2;
  PrintComPort.Parity         := pNone;
  PrintComPort.StopBits       := sbOne;
  PrintComPort.StreamProtocol := spNone;
  PrintComPort.TimeoutRead    := 5000;
  PrintComPort.TimeoutWrite   := 5000;
  PrintComPort.TraceStates    := [tsRxChar];

  PrintComPort.Update;

  //MSR과 KM1000은 Tag를 5로 설정한다
  PrintComPort.Tag  := Common.Config.ReceiptPrinterDev;
  case Common.Config.ReceiptPrinterBaudRate of
    0 : PrintComPort.BaudRate := 9600;
    1 : PrintComPort.BaudRate := 19200;
    2 : PrintComPort.BaudRate := 38400;
    3 : PrintComPort.BaudRate := 57600;
    4 : PrintComPort.BaudRate := 115200;
  end;
  try
    Sleep(150);
    PrintComPort.Active := true;
  except
    Common.ErrBox('영수증프린터를 초기화하지 못했습니다');
  end;
end;

procedure TDevice.CIDPortOpen;                   //영수증프린터 셋팅
begin
  if Common.Config.Cid_Port = 0 then Exit;

  CIDComPort.Active := false;
  CIDComPort.BaudRate       := 19200;
  CIDComPort.ComPortNo      := Common.Config.Cid_Port;
  CIDComPort.BufferInSize   := 4096;
  CIDComPort.BufferOutSize  := 4096;
  CIDComPort.Parity         := pNone;
  CIDComPort.StopBits       := sbOne;
  CIDComPort.StreamProtocol := spNone;
  CIDComPort.TimeoutRead    := 5000;
  CIDComPort.TimeoutWrite   := 5000;
  CIDComPort.TraceStates    := [tsRxChar];
  CIDComPort.Update;

  try
    Sleep(100);
    CIDComPort.Active := true;
  except
    Common.ErrBox('CID 포트 오픈 실패');
  end;
end;

procedure TDevice.LinkPortOpen;                   //영수증프린터 셋팅
begin
  if (GetOption(185) = '0') or (Common.Config.LinkPort = 0) then Exit;

  BaeminComPort.ComPortNo      := Common.Config.LinkPort-1;  //배민포트는 무조건 연결프린터 전포트 사용
  BaeminComPort.BufferInSize   := 4096;
  BaeminComPort.Parity         := pNone;
  BaeminComPort.StopBits       := sbOne;
  BaeminComPort.StreamProtocol := spNone;
  BaeminComPort.TraceStates    := [tsRxChar];
  BaeminComPort.TimeoutRead    := 5000;
  BaeminComPort.TimeoutWrite   := 5000;
  BaeminComPort.BaudRate       := Common.Config.BaeminBuadRate;

  LinkPortData := EmptyStr;
  LinkComPort.ComPortNo := Common.Config.LinkPort;
  LinkComPort.BufferInSize   := 4096;
  LinkComPort.Parity         := pNone;
  LinkComPort.StopBits       := sbOne;
  LinkComPort.StreamProtocol := spNone;
  LinkComPort.TraceStates    := [tsRxChar];
  LinkComPort.TimeoutRead    := 5000;
  LinkComPort.TimeoutWrite   := 5000;

  LinkComPort.BaudRate := 9600;
  try
    Sleep(100);
    LinkComPort.Active := true;
  except
    Common.ErrBox('배민 연결컴포트 오픈 실패');
  end;
end;

procedure TDevice.Link2PortOpen;                   //영수증프린터 셋팅
begin
  if (GetOption(185) = '0') or (Common.Config.Link2Port = 0) then Exit;
  Link2PortData := EmptyStr;
  Link2ComPort.ComPortNo      := Common.Config.Link2Port;
  Link2ComPort.BufferInSize   := 4096;
  Link2ComPort.Parity         := pNone;
  Link2ComPort.StopBits       := sbOne;
  Link2ComPort.StreamProtocol := spNone;
  Link2ComPort.TraceStates    := [tsRxChar];
  Link2ComPort.TimeoutRead    := 5000;
  Link2ComPort.TimeoutWrite   := 5000;

  Link2ComPort.BaudRate := 9600;
  try
    Sleep(100);
    Link2ComPort.Active := true;
  except
    Common.ErrBox('연결2컴포트 오픈 실패');
  end;
end;

procedure TDevice.Link3PortOpen;                   //영수증프린터 셋팅
begin
  if (GetOption(185) = '0') or (Common.Config.Link3Port = 0) then Exit;
  Link3PortData := EmptyStr;
  Link3ComPort.ComPortNo      := Common.Config.Link3Port;
  Link3ComPort.BufferInSize   := 4096;
  Link3ComPort.Parity         := pNone;
  Link3ComPort.StopBits       := sbOne;
  Link3ComPort.StreamProtocol := spNone;
  Link3ComPort.TraceStates    := [tsRxChar];
  Link3ComPort.TimeoutRead    := 5000;
  Link3ComPort.TimeoutWrite   := 5000;

  Link3ComPort.BaudRate := 9600;
  try
    Sleep(100);
    Link3ComPort.Active := true;
  except
    Common.ErrBox('연결3컴포트 오픈 실패');
  end;
end;

procedure TDevice.Link4PortOpen;                   //영수증프린터 셋팅
begin
  if (GetOption(185) = '0') or (Common.Config.Link4Port = 0) then Exit;
  Link4PortData := EmptyStr;
  Link4ComPort.ComPortNo      := Common.Config.Link4Port;
  Link4ComPort.BufferInSize   := 4096;
  Link4ComPort.Parity         := pNone;
  Link4ComPort.StopBits       := sbOne;
  Link4ComPort.StreamProtocol := spNone;
  Link4ComPort.TraceStates    := [tsRxChar];
  Link4ComPort.TimeoutRead    := 5000;
  Link4ComPort.TimeoutWrite   := 5000;

  Link4ComPort.BaudRate := 9600;
  try
    Sleep(100);
    Link4ComPort.Active := true;
  except
    Common.ErrBox('연결4컴포트 오픈 실패');
  end;
end;


//CloudOrange에서는 체크하지 않는다
procedure TDevice.CheckCidDeivce;
var
  vGetTime : Cardinal;
  IsCheck  : Boolean;
  vTemp    : String;
begin
  Exit;
  if Common.Config.Cid_Port > 0 then
  begin
    vTemp := String(GetRegistry(HKEY_CURRENT_USER, regPath, 'Delivery'));
    vTemp := Decrypt(vTemp, 123);
    if vTemp = Common.Config.StoreCode + Format('COM%d',[Common.Config.Cid_Port]) then Exit;

    if not CidComPort.Active then Exit;
    FCidBuff := EmptyStr;
    try
      isCIDCheck := true;
      CidComPort.SendString(#2+' P                  '+#3);
      vGetTime := GetTickCount;
      IsCheck  := False;
      while vGetTime + 3000 > GetTickCount do
      begin
        Application.ProcessMessages;
        if (Length(FCidBuff) > 0) and (POS('EPOS', FCidBuff) > 0) then
        begin
          IsCheck := True;
          Break;
        end;
      end;
    finally
      isCIDCheck := false;
    end;
    if not IsCheck then
    begin
      Common.WriteLog('CheckCidDeivce',FCidBuff);
      Common.ErrBox('CID 장비가 프로그램과'+#13+'호환되지 않습니다'+#13#13+'설치점에 문의바랍니다');
      SetRegistry(HKEY_CURRENT_USER, regPath, 'Delivery', '');
      CidComPort.Active := false;
    end
    else
    //정상장비로 체크시에는 레지스트리에 고객번호와 같이 체크됐음을 기록한다
    begin
      vTemp := Encrypt(Common.Config.StoreCode + Format('COM%d',[Common.Config.Cid_Port]), 123);
      SetRegistry(HKEY_CURRENT_USER, regPath, 'Delivery', vTemp);
    end;
    FCidBuff := EmptyStr;
  end;
end;

procedure TDevice.ScannerPortOpen;                //스캐너포트오픈
begin
  if Common.Config.HandScannerPort > 0 then
  begin
    ScannerComPort.ComPortNo := Common.Config.HandScannerPort;
    ScannerComPort.BufferInSize   := 4096;
    ScannerComPort.Parity         := pNone;
    ScannerComPort.StopBits       := sbOne;
    ScannerComPort.StreamProtocol := spNone;
    ScannerComPort.TraceStates    := [tsRxChar];
    ScannerComPort.TimeoutRead    := 5000;
    ScannerComPort.TimeoutWrite   := 5000;
    ScannerComPort.BaudRate := 9600;
    try
      Sleep(100);
      ScannerComPort.Active := true;
    except
      Common.ErrBox('스캐너를 초기화하지 못했습니다');
    end;
  end;

  if Common.Config.FixScannerPort > 0 then
  begin
    FixScannerComPort.ComPortNo := Common.Config.FixScannerPort;
    FixScannerComPort.BaudRate := 9600;
    FixScannerComPort.BufferInSize   := 4096;
    FixScannerComPort.Parity         := pNone;
    FixScannerComPort.StopBits       := sbOne;
    FixScannerComPort.StreamProtocol := spNone;
    FixScannerComPort.TraceStates    := [tsRxChar];
    FixScannerComPort.TimeoutRead    := 5000;
    FixScannerComPort.TimeoutWrite   := 5000;
    try
      Sleep(100);
      FixScannerComPort.Active := true;
    except
      Common.ErrBox('고정스캐너를 초기화하지 못했습니다');
    end;
  end;

end;

procedure TDevice.LabelPrinterPortOpen;                //테이블키포트오픈
begin
  if (Common.Config.LabelPrinterPort = 0)  then Exit;

  LabelPrinterComPort.ComPortNo      := Common.Config.LabelPrinterPort;
  LabelPrinterComPort.BaudRate       := 115200;
  LabelPrinterComPort.BufferInSize   := 4096;
  LabelPrinterComPort.Parity         := pNone;
  LabelPrinterComPort.StopBits       := sbOne;
  LabelPrinterComPort.StreamProtocol := spNone;
  LabelPrinterComPort.TraceStates    := [tsRxChar];
  LabelPrinterComPort.TimeoutRead    := 5000;
  LabelPrinterComPort.TimeoutWrite   := 5000;
  try
    Sleep(100);
    LabelPrinterComPort.Active := true;
    LabelPrinterComPort.SendString('SP115200,N,8,1');
  except
     Common.ErrBox('라벨프린터기를 초기화하지 못했습니다');
  end;
end;

procedure TDevice.BellPortOpen;                //테이블키포트오픈
begin
  if (Common.Config.BellPort = 0)  then Exit;

  BellComPort.ComPortNo      := Common.Config.BellPort;
  BellComPort.BaudRate       := 9600;
  BellComPort.BufferInSize   := 4096;
  BellComPort.Parity         := pNone;
  BellComPort.StopBits       := sbOne;
  BellComPort.StreamProtocol := spNone;
  BellComPort.TimeoutWrite   := 3000;
  BellComPort.TraceStates    := [tsRxChar];
  try
    Sleep(100);
    BellComPort.Active := true;
  except
     Common.ErrBox('진동벨포트를 초기화하지 못했습니다');
  end;
end;

procedure TDevice.DispenserPortOpen;
begin
  if (Common.Config.KioskDispenserPort = 0) or not Common.Config.IsKiosk  then Exit;

  DispenserComPort.ComPortNo      := Common.Config.KioskDispenserPort;
  DispenserComPort.BufferInSize   := 4096*2;
  DispenserComPort.BufferOutSize  := 4096*2;
  DispenserComPort.BaudRate       := 9600;
  DispenserComPort.EventChar      := #10;
  DispenserComPort.ByteSize       := 8;
  DispenserComPort.Parity         := pNone;
  DispenserComPort.StopBits       := sbOne;
  DispenserComPort.StreamProtocol := spNone;
  DispenserComPort.TraceStates    := [tsRxChar];
  DispenserComPort.EnumPorts      := epQuickAll;
  DispenserComPort.TimeoutRead    := 5000;
  DispenserComPort.TimeoutWrite   := 5000;
  FDispenserData                  := EmptyStr;
  try
    Sleep(100);
    DispenserComPort.Active := true;
  except
    Common.ErrBox(Format('현금 입출금기[%s]를'#13'초기화하지 못했습니다',[DispenserComPort.ComName]));
  end;
end;

procedure TDevice.JtnetICDetectPortOpen;
begin
  if not Common.Config.IsKiosk and ((GetOption(379)='0')) and (Common.ICCard.VAN = vtJTNET) then
  begin
    JtentICDetectComPort.ComPortNo     := Common.Config.ICReaderPort;
    JtentICDetectComPort.BufferInSize   := 4096;
    JtentICDetectComPort.BufferOutSize  := 4096;
    JtentICDetectComPort.Parity         := pNone;
    JtentICDetectComPort.StopBits       := sbOne;
    JtentICDetectComPort.StreamProtocol := spNone;
    JtentICDetectComPort.TimeoutRead    := 5000;
    JtentICDetectComPort.TimeoutWrite   := 5000;
    JtentICDetectComPort.TraceStates    := [tsRxChar];

    case Common.Config.ICReaderBaudRate of
      0 : JtentICDetectComPort.BaudRate := 9600;
      1 : JtentICDetectComPort.BaudRate := 19200;
      2 : JtentICDetectComPort.BaudRate := 38400;
      3 : JtentICDetectComPort.BaudRate := 57600;
      4 : JtentICDetectComPort.BaudRate := 115200;
    end;

    JtnetDetectData            := EmptyStr;
  end;
end;

{----------------------------------------------------------------}
{  주방프린터에 프린터상태를 요청한다                            }
{----------------------------------------------------------------}
function TDevice.PrinterCheck: String;
  // ESC/POS 프린터 상태 체크 --------------------------------------------------
  function EpsonMode: String;
  var
    vGetTime : Cardinal;
  begin
    try
      with PrintComPort do
        try
          Result := Format(msgDevPrnErrNotReady, [ComPortNo]);
          if not Active then
          begin
            Result := Format(msgDevPrnErrNotReady, [ComPortNo]);
            Exit;
          end; // if not Connected then

          // 프린터 Ready 상태인지 알아내기
          PrinterStatus := EmptyStr;
          SendString(#16#4#1);
          Application.ProcessMessages;
          vGetTime := GetTickCount;
          while vGetTime + 3000 > GetTickCount do
          begin
            Application.ProcessMessages;
            if (Length(PrinterStatus) > 0) and
               ((Ord(PrinterStatus[1]) and $08) <> $08) then
            begin
              Result := EmptyStr;
              Exit;
            end; // if (Length(ComPortStatus[aComPort]) > 0) and..
          end;


          // 덮개가 열려있는지 알아내기
          PrinterStatus := EmptyStr;
          SendString(#16#4#2);
          Application.ProcessMessages;
          vGetTime := GetTickCount;
          while vGetTime + 1000 > GetTickCount do
          begin
            Application.ProcessMessages;
            if (Length(PrinterStatus) > 0) and
               ((Ord(PrinterStatus[1]) and $04) = $04) then
            begin
              Result := Format(msgDevPrnErrCoverOpen, [ComPortNo]);
              Exit;
            end; // if (Length(ComPortStatus[aComPort]) > 0) and..
          end;

          // 종이 상태 알아내기
          PrinterStatus := EmptyStr;
          SendString(#16#4#4);
          Application.ProcessMessages;
          vGetTime := GetTickCount;
          while vGetTime + 2000 > GetTickCount do
          begin
            Application.ProcessMessages;
            if (Length(PrinterStatus) > 0) and ((Ord(PrinterStatus[1]) and $60) = $60) then
            begin
              Result := Format(msgDevPrnErrPaper, [ComPortNo]);
              Exit;
            end; // if (Length(ComPortStatus[aComPort]) > 0) and ..
          end;

          // 에러 상태 알아내기
          PrinterStatus := EmptyStr;
          SendString(#16#4#3);
          Application.ProcessMessages;
          vGetTime := GetTickCount;
          while vGetTime + 1000 > GetTickCount do
          begin
            Application.ProcessMessages;
            if Length(PrinterStatus) > 0 then
            begin
              if (Ord(PrinterStatus[1]) and $08) = $08 then
              begin
                Result := Format(msgDevPrnErrCutter, [ComPortNo]);
                Exit;
              end // if      (Ord(ComPortStatus[aComPort][1]) and $08) = $08 then
              else if ((Ord(PrinterStatus[1]) and $20) = $20) or
                      ((Ord(PrinterStatus[1]) and $40) = $40) then
              begin
                Result := Format(msgDevPrnErrUnrecover, [ComPortNo]);
                Exit;
              end; // else if ((Ord(ComPortStatus[aComPort][1]) and $20) = $20) or ..
            end;
          end;
          Result := Format(msgDevPrnErrPowerOff, [ComPortNo]);
        except
          Result := Format(msgDevPrnErrDataSend, [ComPortNo]);
        end; // try .. except ..
      finally
      end;
  end;

  function TMMode: String;
  var
    vGetTime : Cardinal;
  begin
    with PrintComPort do
      try
        Result := Format(msgDevPrnErrNotReady, [ComPortNo]);
        if not Active then
        begin
          Result := Format(msgDevPrnErrNotReady, [ComPortNo]);
          Exit;
        end; // if not Connected then

        // 프린터 Ready 상태인지 알아내기
        PrinterStatus := EmptyStr;
        SendString(#16#4#1);
        Application.ProcessMessages;
        vGetTime := GetTickCount;
        while vGetTime + 3000 > GetTickCount do
        begin
          Application.ProcessMessages;
          if (Length(PrinterStatus) > 0) and
             ((Ord(PrinterStatus[1]) and $08) <> $08) then
          begin
            Result := EmptyStr;
            Exit;
          end; // if (Length(ComPortStatus[aComPort]) > 0) and..
        end;

        // 에러 상태 알아내기
        PrinterStatus := EmptyStr;
        SendString(#16#4#3);
        Application.ProcessMessages;
        vGetTime := GetTickCount;
        while vGetTime + 3000 > GetTickCount do
        begin
          Application.ProcessMessages;
          if (Length(PrinterStatus) > 0) and ((Ord(PrinterStatus[1]) and $08) = $08) then
          begin
            Result := Format(msgDevPrnErrCoverPaper, [ComPortNo]);
            Exit;
          end // if      (Ord(ComPortStatus[aComPort][1]) and $08) = $08 then
          else if (Length(PrinterStatus) > 0) and
                  (((Ord(PrinterStatus[1]) and $20) = $20) or ((Ord(PrinterStatus[1]) and $40) = $40)) then
          begin
            Result := Format(msgDevPrnErrUnrecover, [ComPortNo]);
            Exit;
          end; // else if ((Ord(ComPortStatus[aComPort][1]) and $20) = $20) or ..
        end;
        Result := Format(msgDevPrnErrPowerOff, [ComPortNo]);
      except
        Result := Format(msgDevPrnErrCoverPaper, [ComPortNo]);
      end; // try .. except ..
  end;

begin
  try
    case Common.Config.ReceiptPrinterDev of
      prtTM      : Result := TMMode;
      prtESPON   : Result := EpsonMode;
    end;
  finally
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Name         : Ready_Prt
// Type         : procedure
// Explanation  : 준비금영수증 출력
////////////////////////////////////////////////////////////////////////////////
procedure TDevice.Ready_Prt(CashAmt, CashOld:Double);
var I :Integer;
begin
  PrintData := EmptyStr;

  with Common, Common.Config do
  begin
     AddPrintData(rptSizeBoth);
     AddPrintData(rptAlignCenter);
     AddPrintData('준비금영수증');
     AddPrintData(rptLF);
     AddPrintData(rptAlignLeft);
     AddPrintData(rptSizeNormal);
     For I := 1 to 4 do
       if Trim(Config.ReceiptTitle[I]) <> '' then  AddPrintData(Config.ReceiptTitle[I]);

     AddPrintData(rptTwoLine);
     AddPrintData(FormatMaskText('!0000년90월90일 00:00;0; ',WorkDate+NowTime)+' 계산원:'+PosNo+'-'+UserName);
     AddPrintData(rptTwoLine);

     AddPrintData(pStr+'   현      금 : '+pStr+LPadB(FormatFloat('#,##0',CashAmt),23,' ')+'   ' );
     AddPrintData(pStr+'   기등록현금 : '+pStr+LPadB(FormatFloat('#,##0',CashOld),23,' ')+'   ' );
     AddPrintData(pStr+'   합      계 : '+pStr+LPadB(FormatFloat('#,##0',CashAmt  +
                                                                   CashOld),23,' ')+'   ' );
     AddPrintData(rptOneLine);
     if ReceiptPrinterDev <> prtTM then
     begin
       AddPrintData(rptLF);
       AddPrintData(rptLF);
     end;
  end;

  //실제 프린터에 출력한다
  PrintPrinter(rptReady);
end;

////////////////////////////////////////////////////////////////////////////////
// Name         : Middle_Prt
// Type         : procedure
// Explanation  : 중간출금영수증 출력
////////////////////////////////////////////////////////////////////////////////
procedure TDevice.DepositPrint(DepositAmt, TotalDepositAmt:Double);
var vIndex :Integer;
begin
  PrintData := EmptyStr;

  with Common, Common.Config do
  begin
     AddPrintData(rptSizeBoth);
     AddPrintData(rptAlignCenter);
     AddPrintData('중간출금영수증');
     AddPrintData(rptLF);
     AddPrintData(rptAlignLeft);
     AddPrintData(rptSizeNormal);
     For vIndex := 1 to 4 do
       if Trim(Config.ReceiptTitle[vIndex]) <> '' then  AddPrintData(Config.ReceiptTitle[vIndex]);

     AddPrintData(rptTwoLine);
     AddPrintData(FormatMaskText('!0000년90월90일 00:00;0; ',WorkDate+NowTime)+' 계산원:'+PosNo+'-'+UserName);
     AddPrintData(rptTwoLine);

     AddPrintData(pStr+'     출금금액 : '+LPadB(FormatFloat('#,##0',DepositAmt), 23,' ')+'   ' );
     AddPrintData(pStr+'   총출금금액 : '+LPadB(FormatFloat('#,##0',TotalDepositAmt+DepositAmt), 23,' ')+'   ' );

     AddPrintData(rptOneLine);
     if ReceiptPrinterDev <> prtTM then
     begin
       AddPrintData(rptLF);
       AddPrintData(rptLF);
     end;

  end;

  //실제 프린터에 출력한다
  PrintPrinter(rptMid);
end;


////////////////////////////////////////////////////////////////////////////////
// Name         : Thermal_Print
// Type         : procedure
// Explanation  : 영수증 출력(열전사식)
////////////////////////////////////////////////////////////////////////////////
procedure TDevice.Receipt_Print(Kind:Char);
var I, vCardAmt, vCashAmt, vCardCnt, vCatCnt, vTempCnt, vHalbuCnt :Integer;
    bPrint, vMustPrint, vChoose :Boolean;
    vGetTime : Cardinal;
    vCardData :String;
begin
  vCardAmt   := 0;
  vCashAmt   := 0;
  vChoose    := false;
  bPrint     := False;
  vMustPrint := false;//Common.RealPrintMode <> pmNoPrint;
  vCardData  := '';

  for I := 0 to Common.Card_SGrd.RowCount-1 do
    Common.Card_sGrd.Cells[GDC_YN_PRINT_TEMP,I] := Common.Card_sGrd.Cells[GDC_YN_PRINT,I];

  vTempCnt  := 0;
  vHalbuCnt := 0;
  for I := 0 to Common.Card_SGrd.RowCount-1 do
  begin
    if (Common.Card_sGrd.Cells[GDC_YN_PRINT,I] = 'Y') and (Common.Card_SGrd.Cells[GDC_TYPE_TRD,I] <> atCat) then    //출력해야할 전표이고
       Inc(vTempCnt);

    if (Common.Card_sGrd.Cells[GDC_YN_PRINT,I] = 'Y') and (Common.Card_SGrd.Cells[GDC_TYPE_TRD,I] = atCat) and (Common.Card_sGrd.Cells[GDC_HALBU,I] <> '00') then    //할부전표있느지 체크
       Inc(vHalbuCnt);
  end;


  //재출력이 아니면서 전자서명 시 신용카드전표를 출력하지 않는다고 체크했을때
  if (GetOption(165) = '1') and (Common.RealPrintMode <> pmRePrint) and (Kind = 'P') then
  begin
    for I := 0 to Common.Card_SGrd.RowCount-1 do
    begin
      //전자서명건은 패스  단말기연동은 무조건 전자서명으로 적용한다(알수가 없음)
      if ((GetOption(379) = '1') or (Trim(Common.Card_sGrd.Cells[GDC_IMGFILE,I]) <> '') or (Common.Card_sGrd.Cells[GDC_YN_NOCVM,I] = 'Y')) and (Common.Card_sGrd.Cells[GDC_HALBU,I] = '00') then
      begin
        Common.Card_sGrd.Cells[GDC_YN_PRINT,I]      := 'N';
        Common.Card_sGrd.Cells[GDC_YN_PRINT_TEMP,I] := 'Y';  //전자서명 시 전표를 출력하지 않는데, 가맹점보관용은 무조건 출력할때
      end;
    end;
  end;

  for I := 0 to Common.Card_SGrd.RowCount-1 do
    if (Common.Card_sGrd.Cells[GDC_TYPE_TRD,I] = atCat) and   //단말기 승인
       (Common.Card_sGrd.Cells[GDC_YN_PRINT,I] = 'Y')       //출력해야할 전표이고
       then vCardAmt := vCardAmt + StoI(Common.Card_sGrd.Cells[GDC_AMT,I]);

  for I := 0 to Common.Cash_SGrd.RowCount-1 do
  begin
    if ((Common.Cash_SGrd.Cells[GDR_DS_INPUT,I] = 'O') and   //단말기 승인
        (Common.Cash_SGrd.Cells[GDR_YN_PRINT,I] = 'Y') )      //출력해야할 전표이고
       or
       ((Common.Cash_SGrd.Cells[GDR_DS_TRD,I] = dtApproval) and
        (Common.Cash_SGrd.Cells[GDR_YN_PRINT,I] = 'Y') ) then
        vCashAmt := vCashAmt + StoI(Common.Cash_SGrd.Cells[GDR_AMT,I]);
  end;

  vCardCnt  := 0;
  for I := 0 to Common.Card_SGrd.RowCount-1 do
    if (Common.Card_sGrd.Cells[GDC_YN_PRINT,I] = 'Y') and (Common.Card_SGrd.Cells[GDC_TYPE_TRD,I] <> atCat) then    //출력해야할 전표이고
       Inc(vCardCnt);

  vCatCnt := 0;
  for I := 0 to Common.Card_SGrd.RowCount-1 do
    if (Common.Card_sGrd.Cells[GDC_YN_PRINT,I] = 'Y') and (Common.Card_SGrd.Cells[GDC_TYPE_TRD,I] = atCat)       //출력해야할 전표이고
       then Inc(vCatCnt);


  if not Common.Config.IsKiosk then
  begin
                                             //승인즉시 출력     //카드전표 출력 시 출력여부를 확인합니다
    if (Common.RealPrintMode <> pmRePrint) and (Common.CardPrintMode = cpmAtAcct) and (GetOption(407) = '1') and (vTempCnt > 0) and  (vHalbuCnt=0) then
    begin
      if Common.Config.SmartPad then
      begin
        if Common.Device.SendToPad(#2+'ask'
                                  +#2+'1'
                                  +#2+'영수증을 출력하시겠습니까?'
                                  +#2+'예'
                                  +#2+'아니오'
                                  +#2+'180') then
           if Common.AskBox('영수증을 출력하시겠습니까?') then
           begin
             vMustPrint := true;
             Common.RealPrintMode := pmPrint;
           end
           else
           begin
             vMustPrint := false;
             Common.RealPrintMode := pmNoPrint;
           end;
        vChoose := true;
      end
      else
      begin
        if Common.AskBox('영수증을 출력하시겠습니까?') then
        begin
          vMustPrint := true;
          Common.RealPrintMode := pmPrint;
        end
        else
        begin
          vMustPrint := false;
          Common.RealPrintMode := pmNoPrint;
        end;
        vChoose := true;
      end;

      PrintData := EmptyStr;
      for I := 0 to Common.Card_SGrd.RowCount-1 do
      begin
        Common.Card_sGrd.Cells[GDC_YN_PRINT_TEMP2,I] := Common.Card_sGrd.Cells[GDC_YN_PRINT,I];
        Common.Card_sGrd.Cells[GDC_YN_PRINT,I]       := Common.Card_sGrd.Cells[GDC_YN_PRINT_TEMP,I];
      end;

      if vMustPrint then
        vCardCnt := vTempCnt;

      if GetOption(6) = '1' then
         CardPrint(1);
      if GetOption(6) = '2' then
         CardPrint(2);

      vCardData := PrintData;

      if not vMustPrint then
      for I := 0 to Common.Card_SGrd.RowCount-1 do
        Common.Card_sGrd.Cells[GDC_YN_PRINT,I]       := Common.Card_sGrd.Cells[GDC_YN_PRINT_TEMP2,I];

     //가맹점 보관용과 카드사 제출용은 출력여부와 상관없이 옵션에 의해 출력
      if not vMustPrint and ((GetOption(6) = '1') or (GetOption(6) = '2')) then
      begin
        Common.PrintBuffer.Clear;
        Common.PrintBuffer.Add(PrintData);
        Common.BackupPrintBuffer.Clear;
        Common.BackupPrintBuffer.Add(PrintData);
        PrintPrinter(rptReceipt);
        Exit;
      end
      else if not vMustPrint and (GetOption(6) = '0') then
      begin
        Common.BackupPrintBuffer.Clear;
        Common.BackupPrintBuffer.Add(PrintData);
        Exit;
      end;
    end
    //전자서명시 전표를 출력하지 않는데 가맹점보관용은 출력할때
    else if (GetOption(165) = '1') and (vCardCnt = 0) then
    begin
      PrintData := EmptyStr;
      //승인즉시 출력일때
      if (Common.CardPrintMode = cpmAtAcct) and (Common.RealPrintMode <> pmRePrint) then
      begin
        for I := 0 to Common.Card_SGrd.RowCount-1 do
        begin
          Common.Card_sGrd.Cells[GDC_YN_PRINT_TEMP2,I] := Common.Card_sGrd.Cells[GDC_YN_PRINT,I];
          Common.Card_sGrd.Cells[GDC_YN_PRINT,I]       := Common.Card_sGrd.Cells[GDC_YN_PRINT_TEMP,I];
        end;
        if GetOption(6) = '1' then
          CardPrint(1);
        if GetOption(6) = '2' then
           CardPrint(2);
        vCardData := PrintData;
      end;

      //가맹점 보관용과 카드사 제출용은 출력여부와 상관없이 옵션에 의해 출력
      if (Common.RealPrintMode = pmNoPrint) and (GetOption(6) = '1') or (GetOption(6) = '2') then
      begin
        Common.PrintBuffer.Clear;
        Common.PrintBuffer.Add(PrintData);
        Common.BackupPrintBuffer.Clear;
        Common.BackupPrintBuffer.Add(PrintData);
        PrintPrinter(rptReceipt);
        Exit;
      end;
//      else if Common.RealPrintMode = pmNoPrint then
//        Exit;
      if ((GetOption(165) = '1') or (GetOption(230) = '1')) and (Common.Present.CardAmt <> 0) then
        vMustPrint := false
      else
        vMustPrint := Common.RealPrintMode = pmPrint;
    end
    else if (GetOption(165) = '1') or (GetOption(230) = '1') then
      vMustPrint := false
    //전자서명시 신용카드출력 안함옵션 X 이면서 카드승인건이 있을때
    else if (GetOption(165) = '0') and (vCardCnt > 0) then
      vMustPrint := true
    else
      vMustPrint := Common.RealPrintMode = pmPrint;


    PrintData := EmptyStr;
    //재발행이 아닐때
    if Kind = 'P' then
    begin
       if (Common.WorkState <> wsMagam)  then Exit;
       Common.PrintBuffer.Clear;
       PrintToTxt(vMustPrint);

       if (vCatCnt > 0) then
       begin
         //단말기 승인건
         case StoI(GetOption(125)) of
           0 : Common.RealPrintMode := pmNoPrint;          //출력안함
           1 : bPrint := True;                             //출력함
           2 : if Common.RealPrintMode = pmRePrint then    //재발행시만 출력함
                 bPrint := True
               else
                 Common.RealPrintMode := pmNoPrint;
         end;
       end;

       //카드금액이 있을때
       if (Common.Present.CardAmt <> 0) or (vCardCnt > 0) then
       begin
         //카드금액이 있으면서 무조건 출력한다
         if (Common.Present.CardAmt - vCardAmt  <> 0) then
           bPrint := True;
         //신용카드 기능을 사용안한다고 했을때
         if GetOption(51) = '1' then
           bPrint := False;
         if vCardCnt > 0 then
           bPrint := True;
       end;

       // 외상금액이 있으면
       if (GetOption(318) = '0') and (Common.PreSent.TrustAmt <> 0) then bPrint := True;
       //회원매출일때 영수증출력
       if ((Trim(Common.Member.Code) <> '') and  (GetOption(264) = '1')) then bPrint := True;
       // 배달결제 시 영수증을 출력하지 않습니다
       if (GetOption(344) = '1') and (Common.Table.OrderType = 'D') and (Common.RealPrintMode = pmPrint) then
         Common.RealPrintMode := pmNoPrint;

       {키오스크일때 영수증을 출력 안한다고 했을때}
       if Common.Config.IsKiosk and (Common.RealPrintMode = pmNoPrint) then Exit;

      {카드나 외상결제시 무조건 출력}
       if (Common.RealPrintMode = pmNoPrint) and not bPrint and (Common.PreSent.CashRcpAmt - vCashAmt = 0) then
       begin
         //가맹점보관용 또는 카드사 제출용을 무조건 출력한다고 했을때
         if vCardData <> '' then
         begin
           Common.PrintBuffer.Clear;
           Common.PrintBuffer.Add(vCardData);
           Common.BackupPrintBuffer.Clear;
           Common.BackupPrintBuffer.Add(vCardData);
           PrintPrinter(rptReceipt);
           Exit;
         end
         else if not vChoose and (GetOption(8)='1') and Common.AskBox('영수증을 출력하시겠습니까?') then
         begin
           vMustPrint := true;
           Common.RealPrintMode := pmPrint;
           vChoose    := true;
         end
         else
           Exit;
       end
       else if not vChoose and (GetOption(8)='1') then
       begin
         if Common.AskBox('영수증을 출력하시겠습니까?') then
         begin
           vMustPrint := true;
           Common.RealPrintMode := pmPrint;
         end
         else
         begin
           vMustPrint := false;
           Common.RealPrintMode := pmNoPrint;
         end;
         vChoose := true;
       end
       else if not vChoose then
         PrintData := EmptyStr;
    end;

    //재출력일때
    if Common.RealPrintMode = pmRePrint then
    begin
      PrintPrinter(rptReceipt);
      Exit;
    end;
                                                         //영수증 출력함        영수증 출력안함
//    if vMustPrint or (not vMustPrint and ((GetOption(8)='0') or ((GetOption(8)='1') and  Common.AskBox('영수증을 출력하시겠습니까?')))) then
    if vMustPrint or (not vMustPrint and not vChoose and (GetOption(8)='1') and Common.AskBox('영수증을 출력하시겠습니까?')) then
    begin
      //영수증출력여부에 예를 했을때 0

      if GetOption(8)='1' then
        PrintPrinter(rptReceipt)
      else //실제 프린터에 출력한다
      if GetOption(80) <> '0' then    //영수증출력 매수
        PrintPrinter(rptReceipt);
      //영수증출력 매수
      for I := 2 to StoI(GetOption(80)) do
      begin
        PrintData := Common.PrintBuffer.Strings[0];
        if Trim(PrintData) <> '' then
          PrintPrinter(rptReceipt1);
      end;
      Common.BackupPrintBuffer.Clear;
      for I := 0 to Common.PrintBuffer.Count-1 do
        Common.BackupPrintBuffer.Add(Common.PrintBuffer.Strings[I]);

      //영수증출력 매수출력매수가 0일때 카드전표 출력
      if GetOption(80) = '0' then
      begin
        Common.PrintBuffer.Delete(0);
        PrintPrinter(rptReceipt);
      end;

    end;
  end
  else
  begin
    //전자서명시 전표를 출력하지 않는데 가맹점보관용은 출력할때
    if (GetOption(165) = '1') and (vCardCnt = 0) then
    begin
      PrintData := EmptyStr;
      //승인즉시 출력일때
      if (Common.CardPrintMode = cpmAtAcct) and (Common.RealPrintMode <> pmRePrint) then
      begin
        for I := 0 to Common.Card_SGrd.RowCount-1 do
        begin
          Common.Card_sGrd.Cells[GDC_YN_PRINT_TEMP2,I] := Common.Card_sGrd.Cells[GDC_YN_PRINT,I];
          Common.Card_sGrd.Cells[GDC_YN_PRINT,I]       := Common.Card_sGrd.Cells[GDC_YN_PRINT_TEMP,I];
        end;
        if GetOption(6) = '1' then
          CardPrint(1);
        if GetOption(6) = '2' then
           CardPrint(2);
        vCardData := PrintData;
      end;

      //가맹점 보관용과 카드사 제출용은 출력여부와 상관없이 옵션에 의해 출력
      if (Common.RealPrintMode = pmNoPrint) and (GetOption(6) = '1') or (GetOption(6) = '2') then
      begin
        Common.PrintBuffer.Clear;
        Common.PrintBuffer.Add(PrintData);
        Common.BackupPrintBuffer.Clear;
        Common.BackupPrintBuffer.Add(PrintData);

        if (GetOption(337) = '0') and (Common.OrderKind = okNew) then
          PrintPrinter(rptReceipt);
        Exit;
      end;
//      else if Common.RealPrintMode = pmNoPrint then
//        Exit;

      vMustPrint := true;
    end;

    PrintData := EmptyStr;
    //재발행이 아닐때
    if Kind = 'P' then
    begin
       if (Common.WorkState <> wsMagam)  then Exit;
       Common.PrintBuffer.Clear;
       PrintToTxt(vMustPrint);

       if (vCatCnt > 0) then
       begin
         //단말기 승인건
         case StoI(GetOption(125)) of
           0 : Common.RealPrintMode := pmNoPrint;          //출력안함
           1 : bPrint := True;                             //출력함
           2 : if Common.RealPrintMode = pmRePrint then    //재발행시만 출력함
                 bPrint := True
               else
                 Common.RealPrintMode := pmNoPrint;
         end;
       end;

       //카드금액이 있을때
       if (Common.Present.CardAmt <> 0) or (vCardCnt > 0) then
       begin
         //카드금액이 있으면서 무조건 출력한다
         if (Common.Present.CardAmt - vCardAmt  <> 0) then
           bPrint := True;
         //신용카드 기능을 사용안한다고 했을때
         if GetOption(51) = '1' then
           bPrint := False;
         if vCardCnt > 0 then
           bPrint := True;
       end;

       // 외상금액이 있으면
       if (GetOption(318) = '0') and (Common.PreSent.TrustAmt <> 0) then bPrint := True;
       //회원매출일때 영수증출력
       if ((Trim(Common.Member.Code) <> '') and  (GetOption(264) = '1')) then bPrint := True;
       // 배달결제 시 영수증을 출력하지 않습니다
       if (GetOption(344) = '1') and (Common.Table.OrderType = 'D') and (Common.RealPrintMode = pmPrint) then
         Common.RealPrintMode := pmNoPrint;

       {키오스크일때 영수증을 출력 안한다고 했을때}
       if Common.Config.IsKiosk and (Common.RealPrintMode = pmNoPrint) then Exit;

      {카드나 외상결제시 무조건 출력}
       if (Common.RealPrintMode = pmNoPrint) and not bPrint and (Common.PreSent.CashRcpAmt - vCashAmt = 0) then
       begin
         //가맹점보관용 또는 카드사 제출용을 무조건 출력한다고 했을때
         if vCardData <> '' then
         begin
           Common.PrintBuffer.Clear;
           Common.PrintBuffer.Add(vCardData);
           Common.BackupPrintBuffer.Clear;
           Common.BackupPrintBuffer.Add(vCardData);
           if (GetOption(337) = '0') and (Common.OrderKind = okNew) then
             PrintPrinter(rptReceipt);
           Exit;
         end
         else
           Exit;
       end;
       PrintData := EmptyStr;
    end;

    //재출력일때
    if Common.RealPrintMode = pmRePrint then
    begin
      PrintPrinter(rptReceipt);
      Exit;
    end;

    //계산 완료 후 영수증 출력여부 확인합니다.(KIOSK)
    if (GetOption(337) = '0') then
    begin
      //영수증출력여부에 예를 했을때
      if GetOption(8)='1' then
        PrintPrinter(rptReceipt)
      else //실제 프린터에 출력한다
      if GetOption(80) <> '0' then    //영수증출력 매수
        PrintPrinter(rptReceipt);
      //영수증출력 매수
      for I := 2 to StoI(GetOption(80)) do
      begin
        PrintData := Common.PrintBuffer.Strings[0];
        if Trim(PrintData) <> '' then
          PrintPrinter(rptReceipt1);
      end;

      //영수증출력 매수출력매수가 0일때 카드전표 출력
      if GetOption(80) = '0' then
      begin
        Common.PrintBuffer.Delete(0);
        PrintPrinter(rptReceipt);
      end;
    end;
  end;

  PrintData := #12;
  PrintData := #3;
  PrintData := EmptyStr;
end;

procedure TDevice.Receipt_Ahead;
var vIndex :Integer;
    lsStr, vTemp, vPriceTxt, vMenuName, vGroup : String;
    I, vCardCnt, vCashCnt, PrSale, AmtSale, TaxCnt :Integer;
begin
  with Common do
  begin
    PrintData := EmptyStr;
    AddPrintData(rptSizeBoth);
    AddPrintData(rptAlignCenter);
    AddPrintData('계  산  서');
    AddPrintData(rptLF);
    AddPrintData(rptAlignLeft);
    AddPrintData(rptSizeNormal);
    AddPrintData('테이블 - '+Common.Table.Name);
    AddPrintData(FormatMaskText('!0000년90월90일 00시00분;0; ',WorkDate + NowTime)+ '     '+Config.PosNo+'-'+Config.UserName);
    AddPrintData(rptTwoLine);
    AddPrintData(pStr+'      메뉴명  '+pStr+'         단가 수량      금액');
    AddPrintData(rptTwoLine);
    with Summary_sGrd do
    begin
       For I := 0 to RowCount - 1 do
       begin
          if Cells[GDM_YN_RCP, I] = 'N' then Continue;
          vMenuName := Cells[GDM_NM_MENU, I];

          if ((GetOption(255) = '0') and (Cells[GDM_DS_TAX, I] = '2')) or ((GetOption(255) = '1') and (Cells[GDM_DS_TAX, I] = '0')) then
          begin
            if GetOption(81) = '0' then
              lsStr := RPadB(SCopy('*' + vMenuName,1,18+pLen),18+pLen,' ')
            else
              lsStr := '*' + Cells[GDM_NM_MENU, I];
            TaxCnt := 1;
          end
          else
          begin
            if GetOption(81) = '0' then
              lsStr := RPadB(SCopy(' ' + vMenuName,1,18+pLen),18+pLen,' ')
            else
              lsStr := ' ' + vMenuName;
          end;

          //저울형 상품이면
          if Cells[GDM_DS_MENU, I] = 'W' then
            vTemp  := Cells[GDM_VIEWQTY, I]
          else
            vTemp  := FormatFloat('#,##0',  StoF(Cells[GDM_QTY, I]));

          //영수증메뉴에 부가세금액을 제외한다고 체크했을때
          if (GetOption(176) = '1') and (Cells[GDM_DS_TAX, I] = '2') then
          begin
            PrSale  := StoI(Cells[GDM_PR_SALE, I]) - FtoI( hTrunc(StoI(Cells[GDM_PR_SALE, I]) / 11, 1));
            AmtSale := StoI(Cells[GDM_AMT, I])     - FtoI( hTrunc(StoI(Cells[GDM_AMT, I]) / 11, 1) );
          end
          else
          begin
            PrSale  := StoI(Cells[GDM_PR_SALE, I]);
            AmtSale := StoI(Cells[GDM_AMT    , I]);
          end;

          if Cells[GDM_DS_MENU, I] = 'W' then
            PrSale  := StoI(Cells[GDM_VIEWPRICE, I])
          else
            PrSale  := PrSale  + StoI(Cells[GDM_PR_ITEM, I]);

          if GetOption(81) = '0' then
          begin
            if Cells[GDM_DS_SALE, I] = 'D' then
              vPriceTxt := LPadB('서비스', 9,' ')
            else
              vPriceTxt := LPadB(FormatFloat('#,##0',   PrSale), 9,' ');
          end
          //메뉴를 두줄로 사용할때
          else
          begin
            if Cells[GDM_DS_SALE, I] = 'D' then
              vPriceTxt := LPadB(FormatFloat('#,##0',StoI(Cells[GDM_PR_SALE_ORG, I]))+'(서비스)', 27+pLen,' ')
            else
              vPriceTxt := LPadB(FormatFloat('#,##0',   PrSale), 27+pLen,' ');
          end;


          if GetOption(81) = '0' then
          begin
            AddPrintData(lsStr + vPriceTxt+
                         LPadB(vTemp, 5,' ')+
                         LPadB(FormatFloat('#,##0',   AmtSale),10,' '));
          end
          else //두줄로 출력할때
          begin
            AddPrintData(lsStr);
            AddPrintData(vPriceTxt+
                         LPadB(vTemp, 5,' ')+
                         LPadB(FormatFloat('#,##0',   AmtSale),10,' '));

          end;

          if Cells[GDM_NM_ITEM, I] <> '' then
            AddPrintData(' '+Replace(Cells[GDM_NM_ITEM, I],splitColumn, rptLF));

          //할인내역 출력
          if (GetOption(390) <> '0') and ((StoI(Cells[GDM_DC_MENU, I]) * StoI(Cells[GDM_QTY, I])) <> 0) then
            AddPrintData('     (메뉴할인)'+LPadB(FormatFloat('#,0', (StoI(Cells[GDM_DC_MENU, I]) * StoI(Cells[GDM_QTY, I])) * -1), 27+pLen,' '));
          if (GetOption(390) <> '0') and ((StoI(Cells[GDM_DC_SPC, I]) * StoI(Cells[GDM_QTY, I])) <> 0) then
            AddPrintData('     (행사할인)'+LPadB(FormatFloat('#,0', (StoI(Cells[GDM_DC_SPC, I]) * StoI(Cells[GDM_QTY, I])) * -1), 27+pLen,' '));
          if (GetOption(390) = '2') and (StoI(Cells[GDM_DC_RECEIPT, I]) <> 0) then
          begin
            if Common.PreSent.CodeDc = StoI(Cells[GDM_DC_RECEIPT, I]) then
              AddPrintData(LPadB(Format('(%s)',[Common.PreSent.CodeDcName]),17,' ')+LPadB(FormatFloat('#,0', StoI(Cells[GDM_DC_RECEIPT, I]) * -1), 25+pLen,' '))
            else if Common.PreSent.MemberDc = StoI(Cells[GDM_DC_RECEIPT, I]) then
              AddPrintData('     (회원할인)'+LPadB(FormatFloat('#,0', StoI(Cells[GDM_DC_RECEIPT, I]) * -1), 27+pLen,' '))
            else if Common.PreSent.CouponDc = StoI(Cells[GDM_DC_RECEIPT, I]) then
              AddPrintData('     (쿠폰할인)'+LPadB(FormatFloat('#,0', StoI(Cells[GDM_DC_RECEIPT, I]) * -1), 27+pLen,' '))
            else
              AddPrintData('     (영수증할인)'+LPadB(FormatFloat('#,0', StoI(Cells[GDM_DC_RECEIPT, I]) * -1), 25+pLen,' '));
          end;
       end;

       vGroup := EmptyStr;
       if Common.Group_sGrd.Cells[0,0] <> '' then
       with Common.Group_sGrd do
       begin
          For I := 0 to RowCount - 1 do
          begin
             if (vGroup = EmptyStr) or (vGroup <> Cells[GDM_TABLENO, I]) then
             begin
               AddPrintData(Format('그룹테이블 -> %s',[Cells[GDM_TABLENO, I]]));
               vGroup := Cells[GDM_TABLENO, I];
             end;

             if (Cells[GDM_DS_MENU, I] = 'I') and (Cells[GDM_NM_ITEM, I] ='') then Continue;

             vMenuName := Cells[GDM_NM_MENU, I];

             if ((GetOption(255) = '0') and (Cells[GDM_DS_TAX, I] = '2')) or ((GetOption(255) = '1') and (Cells[GDM_DS_TAX, I] = '0')) then
             begin
               lsStr := RPadB(SCopy('*' + vMenuName,1,18+pLen),18+pLen,' ');
               TaxCnt := 1;
             end
             else
             begin
               lsStr := RPadB(SCopy(' ' + vMenuName,1,18+pLen),18+pLen,' ');
             end;

             //저울형 상품이면
             if Cells[GDM_DS_MENU, I] = 'W' then vTemp := Cells[GDM_VIEWQTY, I]
             else  vTemp := FormatFloat('#,##0',  StoF(Cells[GDM_QTY, I]));

             PrSale := StoI(Cells[GDM_PR_SALE, I]);
             PrSale  := PrSale  + StoI(Cells[GDM_PR_ITEM, I]);
             AmtSale := StoI(Cells[GDM_AMT    , I]) + (StoI(Cells[GDM_PR_ITEM, I]) * StoI(Cells[GDM_QTY, I]));

             if Cells[GDM_DS_TAX, I] = '2' then
             begin
               PrSale := Trunc(PrSale / 1.1);
               AmtSale := Trunc(AmtSale / 1.1);
             end;

             if (Cells[GDM_YN_RCP, I] = 'N') and (AmtSale = 0) then Continue;

             AddPrintData(lsStr + LPadB(FormatFloat('#,##0',   PrSale), 9,' ')+
                                  LPadB(vTemp, 5,' ')+
                                  LPadB(FormatFloat('#,##0',   AmtSale),10,' '));

             if Cells[GDM_NM_ITEM, I] <> '' then
               AddPrintData(' '+Cells[GDM_NM_ITEM, I]);
          end;
       end;
    end;

    AddPrintData(rptOneLine);

    AddPrintData(rptSizeWidth);
    AddPrintData('주문금액 '+LPadB(FormatFloat('#,##0',Common.Present.WRcvAmt),12+(pLen div 2),' '));
  end;
  PrintPrinter(rptLetsOrder);
end;

////////////////////////////////////////////////////////////////////////////////
// Name         : PrintToTxt
// Type         : procedure
// Explanation  : 텍스트화일로 저장
////////////////////////////////////////////////////////////////////////////////
procedure TDevice.PrintToTxt(aMustPrint:Boolean);
  procedure SetCornerbyOrder(aCorner, aRcpData:String);
  var I :Integer;
  begin
    For I := 0 to High(Common.Corner) do
    begin
      if Common.Corner[I].Code = aCorner then
      begin
        Common.Corner[I].RcpData := Common.Corner[I].RcpData + aRcpData + #13;
        Break;
      end;
    end;
  end;

var lsStr, vTemp, vPriceTxt, vMenuName, vGroup : String;
    I, vCardCnt, vCashCnt, PrSale, AmtSale, TaxCnt,
    vIndex   : Integer;
    vServiceAmt : Integer;
    vPrintData  : AnsiString;
    vTempCnt :Integer;
begin
   PrintData := EmptyStr;
   with Common, Common.Config, Common.PreSent do
   begin
     if IsBusinessVersion then
     begin
       AddPrintData(rptSizeBoth);
       AddPrintData(rptAlignCenter);
       AddPrintData('!!! 영업 지원용 !!!');
     end;
     if GetOption(126) = '0' then
     begin
       AddPrintData(rptSizeBoth);
       AddPrintData(rptAlignCenter);
       if (Common.Config.van_trd = vanKSNET) and (GetOption(379) = '1') then
         AddPrintData('    영  수  증')
       else
         AddPrintData('영  수  증');
       AddPrintData(rptAlignLeft);
       AddPrintData(rptLF);
     end
     else if GetOption(126) = '2' then
     begin
       AddPrintData(rptSizeBoth);
       AddPrintData(rptAlignCenter);
       AddPrintData(Common.Config.StoreName);
       AddPrintData(rptAlignLeft);
       AddPrintData(rptLF);
     end
     else AddPrintData(rptAlignLeft);

     AddPrintData(rptSizeNormal);
     For vIndex := 1 to 4 do
       if Trim(Config.ReceiptTitle[vIndex]) <> '' then  AddPrintData(Config.ReceiptTitle[vIndex]);

     //시스템 출력여부
     if GetOption(260) = '0' then
     begin
       if RealPrintMode <> pmRePrint then
       begin
         //영수증번호 출력여부
         if GetOption(157)='0' then
           AddPrintData(FormatMaskText('!0000년90월90일 00:00;0; ',WorkDate + NowTime)+ ' '+Config.PosNo+'-'+RcpNo+' '+Config.UserName)
         else
           AddPrintData(FormatMaskText('!0000년90월90일 00시00분;0; ',WorkDate + NowTime)+ '     '+Config.PosNo+'-'+Config.UserName);
       end
       else
       begin
         //영수증번호 출력여부
         if GetOption(157)='0' then
           AddPrintData(FormatDateTime('yyyy년MM월dd일 hh:nn', SaleDateTime) + ' No:'+FormatMaskText('!0000-00-00 00-0000;0;',WorkDate+PosNo+RcpNo))
         else
           AddPrintData(FormatDateTime('yyyy년MM월dd일 hh시nn분', SaleDateTime) + '     '+Config.PosNo+'-'+Config.UserName);
       end;
     end
     else
     begin
       if RealPrintMode <> pmRePrint then
       begin
         //영수증번호 출력여부
         if GetOption(157)='0' then
           AddPrintData(FormatDateTime('yyyy년MM월dd일 hh:nn', Now()) + ' No:'+FormatMaskText('!0000-00-00 00-0000;0;',WorkDate+PosNo+RcpNo))
         else
           AddPrintData(FormatDateTime('yyyy년MM월dd일 hh시nn분', Now()) + '     '+Config.PosNo+'-'+Config.UserName);
       end
       else
       begin
         //영수증번호 출력여부
         if GetOption(157)='0' then
           AddPrintData(FormatDateTime('yyyy년MM월dd일 hh:nn', SaleDateTime) + ' No:'+FormatMaskText('!0000-00-00 00-0000;0;',WorkDate+PosNo+RcpNo))
         else
           AddPrintData(FormatDateTime('yyyy년MM월dd일 hh시nn분', SaleDateTime) + '     '+Config.PosNo+'-'+Config.UserName);
       end;
     end;

     //영수증에 메뉴내역 출력여부  (재출시는 무조건 출력한다)
     if Common.MenuPrintMode then
     begin
       AddPrintData(rptTwoLine);
       AddPrintData(pStr+'      메뉴명  '+pStr+'         단가 수량      금액');
       AddPrintData(rptTwoLine);
       TaxCnt := 0;
       with Summary_sGrd do
       begin
          For I := 0 to RowCount - 1 do
          begin
             if Cells[GDM_YN_RCP, I] = 'N' then Continue;
             vMenuName := Cells[GDM_NM_MENU, I];

             if ((GetOption(255) = '0') and (Cells[GDM_DS_TAX, I] = '2')) or ((GetOption(255) = '1') and (Cells[GDM_DS_TAX, I] = '0')) then
             begin
               if GetOption(81) = '0' then
                 lsStr := RPadB(SCopy('*' + vMenuName,1,18+pLen),18+pLen,' ')
               else
                 lsStr := '*' + Cells[GDM_NM_MENU, I];
               TaxCnt := 1;
             end
             else
             begin
               if GetOption(81) = '0' then
                 lsStr := RPadB(SCopy(' ' + vMenuName,1,18+pLen),18+pLen,' ')
               else
                 lsStr := ' ' + vMenuName;
             end;

             //저울형 상품이면
             if Cells[GDM_DS_MENU, I] = 'W' then
               vTemp  := Cells[GDM_VIEWQTY, I]
             else
               vTemp  := FormatFloat('#,##0',  StoF(Cells[GDM_QTY, I]));

             //영수증메뉴에 부가세금액을 제외한다고 체크했을때
             if (GetOption(176) = '1') and (Cells[GDM_DS_TAX, I] = '2') then
             begin
               PrSale  := StoI(Cells[GDM_PR_SALE, I]) - FtoI( hTrunc(StoI(Cells[GDM_PR_SALE, I]) / 11, 1));
               AmtSale := StoI(Cells[GDM_AMT, I])     - FtoI( hTrunc(StoI(Cells[GDM_AMT, I]) / 11, 1) );
             end
             else
             begin
               PrSale  := StoI(Cells[GDM_PR_SALE, I]);
               AmtSale := StoI(Cells[GDM_AMT    , I]);
             end;

             if Cells[GDM_DS_MENU, I] = 'W' then
               PrSale  := StoI(Cells[GDM_VIEWPRICE, I])
             else
             begin
               PrSale   := PrSale   + StoI(Cells[GDM_PR_ITEM, I]);
               AmtSale  := AmtSale  + StoI(Cells[GDM_PR_ITEM, I]) * StoI(Cells[GDM_QTY, I]);
             end;

             if GetOption(81) = '0' then
             begin
               if Cells[GDM_DS_SALE, I] = 'D' then
                 vPriceTxt := LPadB('서비스', 9,' ')
               else
                 vPriceTxt := LPadB(FormatFloat('#,##0',   PrSale), 9,' ');
             end
             //메뉴를 두줄로 사용할때
             else
             begin
               if Cells[GDM_DS_SALE, I] = 'D' then
                 vPriceTxt := LPadB(FormatFloat('#,##0',StoI(Cells[GDM_PR_SALE_ORG, I]))+'(서비스)', 27+pLen,' ')
               else
                 vPriceTxt := LPadB(FormatFloat('#,##0',   PrSale), 27+pLen,' ');
             end;

             //푸드코트 코너별 인쇄
             if (GetOption(231) = '1') and (GetOption(232) = '1') then
             begin
               SetCornerbyOrder(Cells[GDM_CORNER, I],
                                lsStr +Ifthen(GetOption(81)='1',#13,'')+ vPriceTxt+
                                LPadB(vTemp, 5,' ')+
                                LPadB(FormatFloat('#,##0', AmtSale),10,' '));

               if Cells[GDM_NM_ITEM, I] <> '' then
                 SetCornerbyOrder(Cells[GDM_CORNER, I],
                                  ' '+Cells[GDM_NM_ITEM, I]+#13);

             end
             else
             begin
               if GetOption(81) = '0' then
               begin
                 AddPrintData(lsStr + vPriceTxt+
                              LPadB(vTemp, 5,' ')+
                              LPadB(FormatFloat('#,##0',   AmtSale),10,' '));
               end
               else //두줄로 출력할때
               begin
                 AddPrintData(lsStr);
                 AddPrintData(vPriceTxt+
                              LPadB(vTemp, 5,' ')+
                              LPadB(FormatFloat('#,##0',   AmtSale),10,' '));

               end;

               if Cells[GDM_NM_ITEM, I] <> '' then
                 AddPrintData(' -'+Replace(Cells[GDM_NM_ITEM, I],splitColumn, rptLF+' -'));
//                 AddPrintData(' '+Cells[GDM_NM_ITEM, I]);

               //할인내역 출력
               if (GetOption(390) <> '0') and ((StoI(Cells[GDM_DC_MENU, I]) * StoI(Cells[GDM_QTY, I])) <> 0) then
                 AddPrintData('     (메뉴할인)'+LPadB(FormatFloat('#,0', (StoI(Cells[GDM_DC_MENU, I]) * StoI(Cells[GDM_QTY, I])) * -1), 27+pLen,' '));
               if (GetOption(390) <> '0') and ((StoI(Cells[GDM_DC_SPC, I]) * StoI(Cells[GDM_QTY, I])) <> 0) then
                 AddPrintData('     (행사할인)'+LPadB(FormatFloat('#,0', (StoI(Cells[GDM_DC_SPC, I]) * StoI(Cells[GDM_QTY, I])) * -1), 27+pLen,' '));
               if (GetOption(390) = '2') and (StoI(Cells[GDM_DC_RECEIPT, I]) <> 0) then
               begin
                 if Common.PreSent.CodeDc = StoI(Cells[GDM_DC_RECEIPT, I]) then
                   AddPrintData(LPadB(Format('(%s)',[Common.PreSent.CodeDcName]),17,' ')+LPadB(FormatFloat('#,0', StoI(Cells[GDM_DC_RECEIPT, I]) * -1), 25+pLen,' '))
                 else if Common.PreSent.MemberDc = StoI(Cells[GDM_DC_RECEIPT, I]) then
                   AddPrintData('     (회원할인)'+LPadB(FormatFloat('#,0', StoI(Cells[GDM_DC_RECEIPT, I]) * -1), 27+pLen,' '))
                 else if Common.PreSent.CouponDc = StoI(Cells[GDM_DC_RECEIPT, I]) then
                   AddPrintData('     (쿠폰할인)'+LPadB(FormatFloat('#,0', StoI(Cells[GDM_DC_RECEIPT, I]) * -1), 27+pLen,' '))
                 else
                   AddPrintData('     (영수증할인)'+LPadB(FormatFloat('#,0', StoI(Cells[GDM_DC_RECEIPT, I]) * -1), 25+pLen,' '));
               end;
             end;
          end;
       end;

       //푸드코트 코너별 인쇄
       if (GetOption(231) = '1') and (GetOption(232) = '1') then
       begin
         For vIndex := 0 to High(Common.Corner) do
         begin
           if Common.Corner[vIndex].RcpData = '' then Continue;

           AddPrintData(rptCharBold);
           AddPrintData(Format('[%s] %s(%s)',[Common.Corner[vIndex].Name,
                                         Common.Corner[vIndex].BizNo,
                                         Common.Corner[vIndex].Boss])+#13);
           AddPrintData(rptCharNormal);
           AddPrintData(Copy(Common.Corner[vIndex].RcpData,1,Length(Common.Corner[vIndex].RcpData)-1));
         end;
       end;

       vGroup := EmptyStr;
       if Common.Group_sGrd.Cells[0,0] <> '' then
       with Common.Group_sGrd do
       begin
          For I := 0 to RowCount - 1 do
          begin
             if (vGroup = EmptyStr) or (vGroup <> Cells[GDM_TABLENO, I]) then
             begin
               AddPrintData(Format('그룹테이블 -> %s',[Cells[GDM_TABLENO, I]]));
               vGroup := Cells[GDM_TABLENO, I];
             end;

             if (Cells[GDM_DS_MENU, I] = 'I') and (Cells[GDM_NM_ITEM, I] ='') then Continue;

             vMenuName := Cells[GDM_NM_MENU, I];

             if ((GetOption(255) = '0') and (Cells[GDM_DS_TAX, I] = '2')) or ((GetOption(255) = '1') and (Cells[GDM_DS_TAX, I] = '0')) then
             begin
               lsStr := RPadB(SCopy('*' + vMenuName,1,18+pLen),18+pLen,' ');
               TaxCnt := 1;
             end
             else
             begin
               lsStr := RPadB(SCopy(' ' + vMenuName,1,18+pLen),18+pLen,' ');
             end;

             //저울형 상품이면
             if Cells[GDM_DS_MENU, I] = 'W' then vTemp := Cells[GDM_VIEWQTY, I]
             else  vTemp := FormatFloat('#,##0',  StoF(Cells[GDM_QTY, I]));

             PrSale := StoI(Cells[GDM_PR_SALE, I]);
             PrSale  := PrSale  + StoI(Cells[GDM_PR_ITEM, I]);
             AmtSale := StoI(Cells[GDM_AMT    , I]) + (StoI(Cells[GDM_PR_ITEM, I]) * StoI(Cells[GDM_QTY, I]));

             if Cells[GDM_DS_TAX, I] = '2' then
             begin
               PrSale := Trunc(PrSale / 1.1);
               AmtSale := Trunc(AmtSale / 1.1);
             end;

             if (Cells[GDM_YN_RCP, I] = 'N') and (AmtSale = 0) then Continue;
             
             AddPrintData(lsStr + LPadB(FormatFloat('#,##0',   PrSale), 9,' ')+
                                  LPadB(vTemp, 5,' ')+
                                  LPadB(FormatFloat('#,##0',   AmtSale),10,' '));

             if Cells[GDM_NM_ITEM, I] <> '' then
               AddPrintData(' '+Cells[GDM_NM_ITEM, I]);
          end;
       end;
     end;

     AddPrintData(rptOneLine);

     //합계금액에 서비스 금액을 포함할때
     if (GetOption(323) = '1') and (ServiceAmt <> 0) then
       vServiceAmt := ServiceAmt
     else
       vServiceAmt := 0;

     if GetOption(399) = '0' then
     begin
       AddPrintData(rptSizeWidth);
       AddPrintData('판매금액 '+LPadB(FormatFloat('#,##0',TotalAmt+vServiceAmt),12+(pLen div 2),' '));
     end
     else
     begin
       AddPrintData(rptCharBold);
       AddPrintData(rptSizeNormal);
       AddPrintData('판매금액                  '+LPadB(FormatFloat('#,##0',TotalAmt+vServiceAmt),16+pLen,' '));
       AddPrintData(rptCharNormal);
     end;

     AddPrintData(rptSizeNormal);
     if TotalDC <> 0 then
     begin
        if CouponDc <> 0 then
          AddPrintData('                  쿠폰할인'+LPadB(FormatFloat('#,##0',CouponDc*-1),16+pLen,' '));
        if SpcDc <> 0 then
          AddPrintData('                  행사할인'+LPadB(FormatFloat('#,##0',SpcDc*-1),16+pLen,' '));
        if MenuDc <> 0 then
          AddPrintData('                  메뉴할인'+LPadB(FormatFloat('#,##0',MenuDc*-1),16+pLen,' '));
        if RcpDc <> 0 then
          AddPrintData('                영수증할인'+LPadB(FormatFloat('#,##0',RcpDc*-1),16+pLen,' '));
        if MemberDc <> 0 then
          AddPrintData('                  회원할인'+LPadB(FormatFloat('#,##0',MemberDc*-1),16+pLen,' '));
        if PointDc <> 0 then
          AddPrintData('                포인트할인'+LPadB(FormatFloat('#,##0',PointDc*-1),16+pLen,' '));
        if VatDc <> 0 then
          AddPrintData('                부가세할인'+LPadB(FormatFloat('#,##0',VatDc*-1),16+pLen,' '));
        if EventDc <> 0 then
          AddPrintData('                이벤트할인'+LPadB(FormatFloat('#,##0',EventDc*-1),16+pLen,' '));
        if CutDc <> 0 then
          AddPrintData('                  단차할인'+LPadB(FormatFloat('#,##0',CutDc*-1),16+pLen,' '));
        if CodeDc <> 0 then
          AddPrintData(LPadB(CodeDcName, 26,' ')+LPadB(FormatFloat('#,##0',CodeDc*-1),16+pLen,' '));
        if TaxFreeDc <> 0 then
          AddPrintData('                Tax Refund'+LPadB(FormatFloat('#,##0',TaxFreeDc*-1),16+pLen,' '));
        if StampDc <> 0 then
          AddPrintData('                스템프할인'+LPadB(FormatFloat('#,##0',StampDc*-1),16+pLen,' '));
        AddPrintData(rptCharNormal);
       AddPrintData(rptLF);
     end;

     if GetOption(127) = '0' then
     begin
       if FreeAmt_Prt <> 0 then
          AddPrintData('              면세공급가액'+LPadB(FormatFloat('#,##0',FreeAmt_Prt),16+pLen,' '));
       if DutyAmt <> 0 then
          AddPrintData('              과세공급가액'+LPadB(FormatFloat('#,##0',DutyAmt_Prt),16+pLen,' '));
       if TaxAmt <> 0 then
          AddPrintData('                  부가세액'+LPadB(FormatFloat('#,##0',TaxAmt_Prt ),16+pLen,' '));
     end;

     if TipAmt <> 0 then
     begin
        AddPrintData(rptCharBold);
        AddPrintData('                봉사료금액'+LPadB(FormatFloat('#,##0',TipAmt),16+pLen,' '));
        AddPrintData(rptCharNormal);
     end;

     if (GetOption(323) = '1') and (ServiceAmt <> 0) then
     begin
        AddPrintData(rptCharBold);
        AddPrintData('                서비스금액'+LPadB(FormatFloat('#,##0',ServiceAmt),16+pLen,' '));
        AddPrintData(rptCharNormal);
     end;

     case ReceiptPrinterDev of
       prtTM     : AddPrintData('              ─────────────────');
       else
       begin
         if Common.Config.PrintColum = 0 then
           AddPrintData('           -------------------------------')
         else
           AddPrintData('              ----------------------------------');
       end;
     end;
     //판매금액하고 받을금액이 다를때만 출력한다(2019.7.17)
     if (TotalAmt+vServiceAmt) <> (FreeAmt + DutyAmt + TaxAmt) then
     begin
       if GetOption(399) = '0' then
       begin
         AddPrintData(rptSizeWidth);
         AddPrintData('받을금액'+ LPadB(FormatFloat('#,##0',FreeAmt + DutyAmt + TaxAmt),13+(pLen div 2),' '));
       end
       else
       begin
         AddPrintData(rptCharBold);
         AddPrintData(rptSizeNormal);
         AddPrintData('받을금액                  '+LPadB(FormatFloat('#,##0',FreeAmt + DutyAmt + TaxAmt),16+pLen,' '));
         AddPrintData(rptCharNormal);
       end;
     end;

     AddPrintData(rptSizeNormal);
     if CardAmt <> 0 then
        AddPrintData('                  신용카드'+LPadB(FormatFloat('#,##0',CardAmt),16+pLen,' '));
     if LetsOrderAmt <> 0 then
        AddPrintData('                  렛츠오더'+LPadB(FormatFloat('#,##0',LetsOrderAmt),16+pLen,' '));
     if CashAmt <> 0 then
        AddPrintData('                  현    금'+LPadB(FormatFloat('#,##0',CashAmt),16+pLen,' '));
     if CheckAmt <> 0 then
        AddPrintData('                  수    표'+LPadB(FormatFloat('#,##0',CheckAmt),16+pLen,' '));
     if TrustAmt <> 0 then
        AddPrintData('                  외    상'+LPadB(FormatFloat('#,##0',TrustAmt),16+pLen,' '));
     if GiftAmt <> 0 then
        AddPrintData('                  상 품 권'+LPadB(FormatFloat('#,##0',GiftAmt),16+pLen,' '));
     if BankAmt <> 0 then
        AddPrintData('                  계좌입금'+LPadB(FormatFloat('#,##0',BankAmt),16+pLen,' '));
     if PointAmt <> 0 then
        AddPrintData('                  포 인 트'+LPadB(FormatFloat('#,##0',PointAmt),16+pLen,' '));
     if EtcAmt <> 0 then
        AddPrintData('                  기타금액'+LPadB(FormatFloat('#,##0',EtcAmt),16+pLen,' '));
     if GiveAmt <> 0 then
     begin
       AddPrintData(rptSizeWidth);
       AddPrintData('거스름돈'+ LPadB(FormatFloat('#,##0', GiveAmt),13+(pLen div 2),' '));
       AddPrintData(rptSizeNormal);
     end;

     if Common.PreSent.TaxFreeDc > 0 then
     begin
       AddPrintData(rptOneLine);
       AddPrintData(rptAlignCenter + rptSizeBoth);
       AddPrintData('즉시환급 제공정보');
       AddPrintData(rptAlignCenter + rptSizeNormal);
       AddPrintData('(Immediate Tax Refund Information)');
       AddPrintData(rptAlignLeft + rptSizeNormal);
       AddPrintData(rptLF);
       AddPrintData(Format('%-20.20s%s %s %s %s %s',['구매일련번호',
                                                     Copy(Common.PreSent.TaxfreeNo,1,4),
                                                     Copy(Common.PreSent.TaxfreeNo,5,4),
                                                     Copy(Common.PreSent.TaxfreeNo,9,4),
                                                     Copy(Common.PreSent.TaxfreeNo,13,4),
                                                     Copy(Common.PreSent.TaxfreeNo,17,2)]));
       AddPrintData('즉시환급 Refund Amount'+ LPadB(FormatFloat('#,##0', TaxFreeDc),20+(pLen div 2),' '));
       AddPrintData('즉시환급 구매 잔여한도'+ LPadB(FormatFloat('#,##0', TaxRefundAfterLimit),20+(pLen div 2),' '));
       AddPrintData('Remaining Purchase Amount of Immediate Tax Refund');
       AddPrintData(rptOneLine);
       AddPrintData('www.golbal-taxfree.com');
       AddPrintData('gtf@global-taxfree.com');
    end;

     AddPrintData(rptOneLine);

     if (GetOption(127) = '0') and (TaxCnt > 0)  then
     begin
       if GetOption(255) = '0' then
         AddPrintData('  * 표시는 부가세 별도 메뉴입니다         ')
       else
         AddPrintData('  * 표시는 면세 메뉴입니다                ');
     end;

     if RealPrintMode = pmRePrint then
     begin
        AddPrintData(rptAlignCenter);
        AddPrintData('*** 재발행된 영수증입니다 ***');
        AddPrintData(rptAlignLeft);
     end;
     if Trim(Common.Member.Code) <> '' then
     begin
       AddPrintData(rptLF);
       if LengthB(Member.Name) = 6 then
         vTemp := Format('%s*%s',[LeftStr(Member.Name,2), RightStr(Member.Name,2)])
       else
         vTemp := Member.Name;

       AddPrintData(Format('  %s 고객님 감사합니다',[vTemp]));
       if (GetOption(21)='1') then
       begin
          if Common.Member.Stamp+Common.PreSent.SaveStamp-Common.PreSent.UseStamp > 0 then
          begin
            if FileExists(Common.AppPath+'\DLL\Stamp.bmp') then
              AddPrintData(rptStamp)
            else
            begin
              AddPrintData(rptLF);
              AddPrintData(rptSizeWidth);
              if Common.OrderKind in [okChange, okCancel] then
                AddPrintData(Format(' 잔여스템프 : %d 개',[Common.Member.Stamp]))
              else
                AddPrintData(Format(' 잔여스템프 : %d 개',[Common.Member.Stamp+Common.PreSent.SaveStamp-Common.PreSent.UseStamp]));
              AddPrintData(rptSizeNormal);
            end;
          end;
       end;

       // 영수증에 포인트내역을 출력합니다.
       if (GetOption(21)='0') and (GetOption(5) = '1') and not Common.isVoidRePrint then
       begin
          if UsePnt <> 0 then
            AddPrintData('  사용포인트 :'+LPadB(FormatFloat('#,#0',UsePnt)+'점',23,' '));
          //매출취소일때
          if Common.Member.OrgOccurPoint > 0  then
            AddPrintData('  금회포인트 :'+LPadB(FormatFloat('#,#0',Common.Member.OrgOccurPoint*-1)+'점',23,' '))
          else
            AddPrintData('  금회포인트 :'+LPadB(FormatFloat('#,#0',OccurPnt)+'점',23,' '));

          AddPrintData('  누계포인트 :'+LPadB(FormatFloat('#,#0',Member.Point)+'점',23,' '))
       end;
       //외상잔액출력
       if (Common.Member.Code <> '') and (GetOption(373) = '1') then
       begin
         if GetOption(292) = '0' then
           AddPrintData('    외상잔액 :'+LPadB(FormatFloat('#,#0',Common.Member.CreditAmt+Common.PreSent.TrustAmt)+'원',23,' '))
         else
           AddPrintData('    충전잔액 :'+LPadB(FormatFloat('#,#0',(Common.Member.CreditAmt+Common.PreSent.TrustAmt)*-1)+'원',23,' '));
       end;
       //전화번호출력
       if (GetOption(319) = '1') and (Trim(Member.MobileTel) <> EmptyStr) then
       begin
         vTemp := GetOnlyNumber(Member.MobileTel);
         case Length(vTemp) of
           10 : vTemp := LeftStr(vTemp,3)+'-***-'+RightStr(vTemp,4);
           11 : vTemp := LeftStr(vTemp,3)+'-****-'+RightStr(vTemp,4);
           else vTemp := SetTelephone(Member.MobileTel);
         end;

         AddPrintData(Format('  전화번호   : %s ', [vTemp]));
       end;
       //주소출력
       if (GetOption(319) = '2') and (Trim(Member.addr1)+Trim(Member.addr2) <> EmptyStr) then
       begin
         AddPrintData('  '+Member.addr1);
         if Trim(Member.addr2) <> EmptyStr then
           AddPrintData('  '+Member.addr2);
       end;
       //전화번호 + 주소출력
       if (GetOption(319) = '3') then
       begin
         if (Trim(Member.MobileTel) <> EmptyStr) then
         begin
           vTemp := GetOnlyNumber(Member.MobileTel);
           case Length(vTemp) of
             10 : vTemp := LeftStr(vTemp,3)+'-***-'+RightStr(vTemp,4);
             11 : vTemp := LeftStr(vTemp,3)+'-****-'+RightStr(vTemp,4);
             else vTemp := SetTelephone(Member.MobileTel);
           end;

           AddPrintData(Format('  전화번호   : %s ', [vTemp]));
         end;
         if (Trim(Member.addr1)+Trim(Member.addr2) <> EmptyStr) then
         begin
           AddPrintData('  '+Member.addr1);
           if Trim(Member.addr2) <> EmptyStr then
             AddPrintData('  '+Member.addr2);
         end;
       end;

       AddPrintData(rptOneLine);
     end;

     {출력할 신용카드 내역이 있는지 체크}
     vCardCnt := 0;
     for I := 0 to Common.Card_SGrd.RowCount-1 do
       if (Card_sGrd.Cells[GDC_TYPE_TRD,I] <> atCat) and   //단말기 승인이 아니고
          (Card_sGrd.Cells[GDC_YN_PRINT,I]  = 'Y')         //출력해야할 전표이고
          then Inc(vCardCnt);

     {출력할 현금영수증 내역이 있는지 체크}
     vCashCnt := 0;
     For I := 0 to Common.Cash_SGrd.RowCount-1 do
       if (Cash_sGrd.Cells[GDR_DS_INPUT,I] <> 'O') and
          (Cash_sGrd.Cells[GDR_YN_PRINT,I] = 'Y') then Inc(vCashCnt);

     {현금영수증 내역이 있으면 출력}
     if  (vCashCnt > 0) then
     begin
        lsStr := ' ';
        For I := 0 to Common.Cash_SGrd.RowCount-1 do
        begin
          if (Cash_sGrd.Cells[GDR_DS_INPUT,I] <> 'O') and (Cash_sGrd.Cells[GDR_YN_PRINT,I] = 'Y') then
          begin
             //개인과 사업자가 한 영수증에 같이 있을때
             if (Cash_sGrd.Cells[GDR_DS_KIND,I]) <> lsStr then
             begin
                if Cash_sGrd.Cells[GDR_DS_KIND,I] = '0' then
                   AddPrintData('현금(소득공제)')
                else if Cash_sGrd.Cells[GDR_DS_KIND,I] = '1' then
                   AddPrintData('현금(지출증빙)')
                else if Cash_sGrd.Cells[GDR_DS_KIND,I] = '2' then
                   AddPrintData('현금(자진발급)');
                AddPrintData(rptSizeNormal);

                lsStr := Cash_sGrd.Cells[GDR_DS_KIND,I];
             end;

             AddPrintData(rptAlignLeft);
             if GetOption(60) = '1' then
               SetTitle( Cash_sGrd.Cells[GDR_CORNER,I],1 );

             AddPrintData(rptAlignLeft);
             vTemp := Cash_sGrd.Cells[GDR_CARDNO,I];
             if Cash_sGrd.Cells[GDR_DS_KIND,I] <> '2' then
             case StoI(Cash_sGrd.Cells[GDR_DS_TYPE,I]) of
               0 :
                 begin
                   AddPrintData(rptSizeWidth);
                   AddPrintData(LPadB(GetCardNoFormat(vTemp),20,' '))
                 end;
               1 :
                 begin
                   AddPrintData(rptSizeWidth);
                   if Length(vTemp)= 11 then
                     AddPrintData(LPadB(Format('%s-****-%s',[LeftStr(vTemp,3), RightStr(vTemp,4)]),18,' '))
                   else
                     AddPrintData(LPadB(Format('%s-***-%s',[LeftStr(vTemp,3), RightStr(vTemp,4)]),18,' '))
                 end;
               2 :
                 begin
                   AddPrintData(rptSizeWidth);
                   AddPrintData(LPadB(FormatMaskText('!000000-*******;0;',Copy(vTemp,1,6)),18,' '));
                 end;
               3 :
                 begin
                   AddPrintData(rptSizeWidth);
                   AddPrintData(LPadB(FormatMaskText('!000-00-*****;0;',Copy(vTemp,1,5)),18,' '));
                 end;
             end;
             AddPrintData(rptSizeNormal);

             if Cash_sGrd.Cells[GDR_DS_KIND,I] = '2' then
             begin
                AddPrintData('  가맹점 사업자번호 ');
                AddPrintData(rptAlignCenter);
                AddPrintData(FormatMaskText('!000-00-00000;0;', Common.Config.BizNo));
                AddPrintData(rptAlignLeft);
             end;

             AddPrintData(rptSizeNormal);
             if Cash_sGrd.Cells[GDR_DS_TRD,I] = dtApproval then
                AddPrintData(Format('승인금액      %s원  (%s)',[FormatFloat('#,0',StoI(Cash_sGrd.Cells[GDR_AMT,I])),Cash_sGrd.Cells[GDR_NO_APPROVAL,I]]))
             else
                AddPrintData(Format('취소금액      %s원  (%s)',[FormatFloat('#,0',StoI(Cash_sGrd.Cells[GDR_AMT,I])),Cash_sGrd.Cells[GDR_NO_APPROVAL,I]]));
          end;
        end;
        AddPrintData('http://www.hometax.go.kr');
     end;

     DetailPrint;

     vPrintData := '';
     //신용카드일때 영수증을 출력하지 않을때 , 영수증출력 매수, 카드금액 있을때(할부개월 있는 전표체크)
     if not aMustPrint and ((GetOption(230) = '1') or (GetOption(80)='0'))  and ((Common.PreSent.CardAmt <> 0) or (vCashCnt > 0)) and (RealPrintMode <> pmRePrint)  then
     begin
       vPrintData := PrintData;
       if not Common.Config.IsKiosk then
         PrintData := '';
     end;

     if Common.Config.IsKiosk then
     begin
       vPrintData := PrintData;
       CardPrint;
       if PrintData = '' then
         Common.PrintBuffer.Add(vPrintData)
       else
         Common.PrintBuffer.Add(PrintData);
       vPrintData := '';
       PrintData  := '';
     end
     else
     begin
//       if vPrintData <> EmptyStr then
//         Common.PrintBuffer.Add(vPrintData);
       //고객보관용
       //승인즉시 출력이 아니고, 별도출력 아니고
       if (vCardCnt > 0) and (Common.SplitPrintMode = spmOnePage) and ((Common.CardPrintMode = cpmAtAcct) or (RealPrintMode = pmRePrint)) then
       begin
         //푸드코트 사용 / 코너별로 카드승인
         if (GetOption(231) = '1') and (GetOption(249) = '1') then
           CardPrint(3)
         else
         begin
//           if (Common.PrintBuffer.Count = 0) and (PrintData = EmptyStr) then
//             CardPrint(3)
//           else
//           begin
             CardPrint;
             if PrintData <> EmptyStr then
             begin
               if (Common.RealPrintMode = pmNoPrint) then
                 vPrintData := vPrintData + PrintData
               else
                 Common.PrintBuffer.Add(PrintData);
             end;
             PrintData := '';
             //가맹점보관용
             if GetOption(6) = '1' then
             begin
               CardPrint(1);
               if PrintData <> EmptyStr then
                 Common.PrintBuffer.Add(PrintData);
               PrintData := '';
             end;
             //카드사제출용 출력
             if GetOption(6) = '2' then
             begin
               CardPrint(2);
               if PrintData <> EmptyStr then
                 Common.PrintBuffer.Add(PrintData);
               PrintData := '';
             end;
//           end;
         end;
       end;

       //승인즉시 출력인데 카드가 한건일때는 여기서 출력한다
       if (Common.CardPrintMode = cpmAtOnce) and (vCardCnt = 1) and (RealPrintMode <> pmRePrint) and (Common.SplitPrintMode = spmOnePage) then
       begin
         if (Common.PrintBuffer.Count = 0) and (PrintData = EmptyStr) then
           CardPrint(3)
         else
         begin
           CardPrint;
           if PrintData <> EmptyStr then
             Common.PrintBuffer.Add(PrintData);
           PrintData := '';
           //가맹점보관용
           if GetOption(6) = '1' then
           begin
             CardPrint(1);
             if PrintData <> EmptyStr then
               Common.PrintBuffer.Add(PrintData);
             PrintData := '';
           end;
           //카드사제출용 출력
           if GetOption(6) = '2' then
           begin
             CardPrint(2);
             if PrintData <> EmptyStr then
               Common.PrintBuffer.Add(PrintData);
             PrintData := '';
           end;
         end;
       end;
     end;

     //영수증 끝부분 출력(승인즉시출력이 아닐때)
//     if (vPrintData <> EmptyStr) and (GetOption(80) <> '0') then
//       DetailPrint;

     {외상영수증출력}
     if (GetOption(318) = '0') and (TrustAmt > 0) then
     begin
        PrintData := EmptyStr;
        TrustPrint;
        Common.PrintBuffer.Add(PrintData);
        PrintData := EmptyStr;
     end
     else if (GetOption(230) = '1') and (vCardCnt > 0) then
       PrintData := EmptyStr
     else
     begin
       if PrintData <> EmptyStr then
         Common.PrintBuffer.Add(PrintData);
       PrintData := EmptyStr;
     end;


     case RealPrintMode of
       pmPrint   : vTemp := 'pmPrint';
       pmNoPrint : vTemp := 'pmNoPrint';
       pmRePrint : vTemp := 'pmRePrint';
     end;

     //승인 즉시 신용카드 전표를 출력하지 않을때.
     if (vCardCnt > 0) and ((Common.CardPrintMode = cpmAtOnce) or Common.Config.IsKiosk) then
     begin
       vTempCnt := 0;
        //직전출력을 위해서 카드승인내역을 저장해놓는다
        if (GetOption(165) = '1') and (Common.RealPrintMode <> pmRePrint) then
        begin
          PrintData := EmptyStr;
          for vIndex := 0 to Common.Card_SGrd.RowCount-1 do
            if (Trim(Common.Card_sGrd.Cells[GDC_IMGFILE,vIndex]) <> '') or (Common.Card_sGrd.Cells[GDC_YN_NOCVM,vIndex] = 'Y') then
            begin
              if Common.Card_sGrd.Cells[GDC_YN_PRINT,vIndex] = 'N' then
              begin
                Common.Card_sGrd.Cells[GDC_YN_PRINT,vIndex] := 'Y';
                Inc(vTempCnt);
              end;
            end;

          if vTempCnt > 0 then
            CardPrint(3);
          if PrintData <> EmptyStr then
          begin
            vPrintData := vPrintData + PrintData;
            PrintData  := '';
          end;
          for vIndex := 0 to Common.Card_SGrd.RowCount-1 do
            if ((Trim(Common.Card_sGrd.Cells[GDC_IMGFILE,vIndex]) <> '') or (Common.Card_sGrd.Cells[GDC_YN_NOCVM,vIndex] = 'Y')) then
              Common.Card_sGrd.Cells[GDC_YN_PRINT,vIndex] := 'N';
        end;

        //고객보관용
        //영수증과 신용카드 전표를 별도로 출력 체크했을때
        if (Common.SplitPrintMode = spmSplit) and (Common.CardPrintMode = cpmAtAcct) and (Common.RealPrintMode <> pmRePrint) then
        begin
          PrintData := EmptyStr;
          CardPrint(3); //매장타이틀출력
        end;

        //카드사제출용
        if (GetOption(6) = '1') or (GetOption(6) = '2') then
        begin
          PrintData := EmptyStr;
          CardPrint(1);
          if (Common.SplitPrintMode = spmOnePage) then
          begin
            Common.PrintBuffer.Add(PrintData);
            PrintData := EmptyStr;
          end;
        end;
        //가맹점보관용
        if GetOption(6) = '2' then
        begin
          PrintData := EmptyStr;
          CardPrint(2);
          if (Common.SplitPrintMode = spmOnePage) then
          begin
            Common.PrintBuffer.Add(PrintData);
            PrintData := EmptyStr;
          end;
        end;
     end
     else if (vCardCnt > 0) and ((Common.CardPrintMode = cpmAtOnce) or (RealPrintMode = pmRePrint) or Common.Config.IsKiosk or (Common.SplitPrintMode = spmSplit))  then
     begin
       //고개보관용
       //재출력이면서 별도출력일때
       if (RealPrintMode = pmRePrint) and (Common.SplitPrintMode = spmSplit)  then
         CardPrint(3);

       //카드사제출용
       if (GetOption(6) = '1') or (GetOption(6) = '2') then
       begin
         PrintData := EmptyStr;
         CardPrint(1);
         if (Common.SplitPrintMode = spmOnePage) then
         begin
           Common.PrintBuffer.Add(PrintData);
           PrintData := EmptyStr;
         end;
       end;

       //가맹점보관용
       if GetOption(6) = '2' then
       begin
         PrintData := EmptyStr;
         CardPrint(2);
         if (Common.SplitPrintMode = spmOnePage) then
         begin
           Common.PrintBuffer.Add(PrintData);
           PrintData := EmptyStr;
         end;
       end;
     end;

     {포인트결제내역이 있으면 매장용 출력}
     if (PointDc+PointAmt <> 0) and (GetOption(158) = '0') then
     begin
       PrintData := EmptyStr;
       MemPointPrint;
       Common.PrintBuffer.Add(PrintData);
       PrintData := EmptyStr;
     end;
   end; //with Common.PreSent, Common do

   if PrintData <> EmptyStr then
     Common.PrintBuffer.Add(PrintData);

   Common.BackupPrintBuffer.Clear;
   if vPrintData <> '' then
     Common.BackupPrintBuffer.Add(vPrintData);
   for vIndex := 0 to Common.PrintBuffer.Count-1 do
     Common.BackupPrintBuffer.Add(Common.PrintBuffer.Strings[vIndex]);

   PrintData := EmptyStr;
end;

procedure TDevice.Cashier_Header(AIndex:Integer;ACorner:String='');
  function SetCornerbyTitle(aCorner:String):Integer;
  var I :Integer;
  begin
    Result := -1;
    For I := 0 to High(Common.Corner) do
    begin
      if Common.Corner[I].Code = aCorner then
      begin
        AddPrintData('상호-'+Common.Corner[I].Name);
        AddPrintData('사업자번호-'+Common.Corner[I].BizNo + ' 대표자:'+Common.Corner[I].Boss);
        AddPrintData('주소-'+Common.Corner[I].Addr);
        AddPrintData('전화번호-'+ Common.Corner[I].TelNo);
        Result := I;
        Break;
      end;
    end;
  end;
var I :Integer;
begin
   with Common, Common.PreSent, Common.Config do
   begin
      AddPrintData(rptSizeNormal);
      AddPrintData(rptAlignLeft);

      if (ACorner = '') or (ACorner = '000000') then
      begin
        For I := 1 to 4 do
          if Trim(Config.ReceiptTitle[I]) <> '' then  AddPrintData(Config.ReceiptTitle[I]);
      end
      else SetCornerbyTitle(ACorner);
      AddPrintData(rptAlignLeft);

      AddPrintData(rptTwoLine);

      //시스템 출력여부
      if GetOption(260) = '0' then
      begin
        //영수증번호 출력여부
        if (GetOption(157)='0') and (not Common.CashBookCard) then
          AddPrintData(FormatMaskText('!0000년90월90일 00:00;0; ',WorkDate + NowTime)+ ' '+Config.PosNo+'-'+RcpNo+' '+Config.UserName)
        else
          AddPrintData(FormatMaskText('!0000년90월90일 00시00분;0; ',WorkDate + NowTime)+ '     '+Config.PosNo+'-'+Config.UserName);
      end
      else
      begin
        //영수증번호 출력여부
        if (GetOption(157)='0') and (not Common.CashBookCard) then
          AddPrintData(FormatDateTime('yyyy년MM월dd일 hh:nn', Now()) + ' No:'+FormatMaskText('!0000-00-00 00-0000;0;',WorkDate+PosNo+RcpNo))
        else
          AddPrintData(FormatDateTime('yyyy년MM월dd일 hh시nn분', Now()) + '     '+Config.PosNo+'-'+Config.UserName);
      end;

      AddPrintData(rptTwoLine);

   end;
end;

procedure TDevice.DetailPrint;
var vBarCode :String;
    I, vCnt :Integer;
begin
   with Common.Config, Common  do
   begin
      AddPrintData(rptAlignLeft);
       //영수증 하단 내용출력
       For I := 1 to High(Config.Rcp_end) do
         if Trim(Config.Rcp_end[I]) <> '' then AddPrintData(Config.Rcp_end[I]);

      if (GetOption(393) = '1') and (Table.OrderType='T') and not IsTakeOut then
      begin
        if (RealPrintMode <> pmRePrint) then
        begin
          AddPrintData('입장시간 :'+ FormatDateTime(fmtDateTime, SetDateTime(Table.Date+Table.Time)));
          AddPrintData('퇴장시간 :'+ FormatDateTime(fmtDateTime, Now()));
        end
        else
        begin
          AddPrintData('입장시간 :'+ FormatDateTime(fmtDateTime, ComeDateTime));
          AddPrintData('퇴장시간 :'+ FormatDateTime(fmtDateTime, SaleDateTime));
        end;
      end;

      //후불제이면서 배달이 아닐때
      if (Common.Table.OrderType='T') and (OrderKind <> okBanpum) then
      begin
        if (not Config.IsTakeOut) and (GetOption(155) = '0') then
          AddPrintData('테이블번호 : '+ Ifthen(GetOption(58) = '0', Table.FloorName+'-', '') + Ifthen(GetOption(25) = '0', IntToStr(Table.Number), Table.Name));
        if Table.DamdangName <> EmptyStr then
          AddPrintData('테이블 담당자 : '+ Table.DamdangName);
        if (GetOption(155) = '0') or (Table.DamdangName <> EmptyStr) then
          AddPrintData(rptTwoLine);
//        AddPrintData(rptLF);
      end;

      //호출번호 출력
      if PreSent.CallNo > 0 then
      begin
        PrintData := PrintData + rptAlignCenter;
        case StoI(GetOption(314)) of
          1 : AddPrintData(rptSizeNormal   + Format('호출번호 - %d',[Common.PreSent.CallNo]));
          2 : AddPrintData(rptSizeHeight   + Format('호출번호 - %d',[Common.PreSent.CallNo]));
          3 : AddPrintData(rptSizeBoth     + Format('호출번호 - %d',[Common.PreSent.CallNo]));
          4 : AddPrintData(rptSize3Times   + Format('호출번호 - %d',[Common.PreSent.CallNo]));
        end;
        PrintData := PrintData + rptAlignLeft;
      end;

      //주문번호
      case StoI(GetOption(320)) of
        1 : AddPrintData(rptSizeNormal  + Format('주문번호 - %d',[Common.Table.OrderNo]));
        2 : AddPrintData(rptSizeHeight  + Format('주문번호 - %d',[Common.Table.OrderNo]));
        3 : AddPrintData(rptSizeBoth    + Format('주문번호 - %d',[Common.Table.OrderNo]));
        4 : AddPrintData(rptSize3Times  + Format('주문번호 - %d',[Common.Table.OrderNo]));
      end;
      PrintData := PrintData + rptAlignLeft;
     if GetOption(333) = '1' then
       AddPrintData(rptBarcode + Chr(Length(WorkDate+Config.PosNo+PreSent.RcpNo))+ WorkDate+Config.PosNo+PreSent.RcpNo);  //바코드

     //나이스파크 주차바코드 출력
     if (GetOption(291) = '1') then
     begin
       vBarCode := Format('%s%s%s%s%s',[Config.ParkingCode,
                                        RightStr(WorkDate,6),
                                        Lpad(Config.PosNo,4,'0'),
                                        PreSent.RcpNo,
                                        FormatFloat('0000', PreSent.TotalAmt div 1000)]);

       PrintData := PrintData + rptAlignCenter;
       AddPrintData(rptSizeNormal  + '---------  주차 할인권  ---------');
       AddPrintData(rptBarcode + Chr(Length(vBarCode))+ vBarCode);
     end;

     //아마노코리아
     if (GetOption(291) = '2') then
     begin
       vBarCode := Format('%s%s%s%s',[FormatDateTime('yyyymmdd',Now()),
                                      Config.ParkingCode,
                                      Config.PosNo,
                                      PreSent.RcpNo]);
       PrintData := PrintData + rptAlignCenter;
       AddPrintData(rptSizeNormal  + '---------  주차 할인권  ---------');
       AddPrintData(rptBarcode + Chr(Length(vBarCode))+ vBarCode);
     end;

   end;
end;

procedure TDevice.TrustPrint;
begin
   with Common do
   begin
     AddPrintData(rptSizeBoth);
     AddPrintData(rptAlignCenter);
     AddPrintData('외상영수증');
     AddPrintData(rptAlignLeft);
     AddPrintData(rptLF);
     Cashier_Header(0);
     if GetOption(250) = '1' then
     begin
       AddPrintData('    회 원 번 호 : '+Member.Code);
       AddPrintData(rptSizeHeight);
       AddPrintData('    회   원  명 : '+Member.Name);
     end;
     AddPrintData('    외상금액  :  '+FormatFloat('#,##0',Common.PreSent.TrustAmt));
     if GetOption(292) = '1' then
       AddPrintData('    충전잔액  :  '+FormatFloat('#,##0',(Common.Member.CreditAmt+Common.PreSent.TrustAmt) * -1))
     else
       AddPrintData('    외상잔액  :  '+FormatFloat('#,##0',Common.Member.CreditAmt+Common.PreSent.TrustAmt));
     AddPrintData(rptSizeNormal);
     AddPrintData(rptLF);
     AddPrintData(rptLF);
     AddPrintData('  - 서 명 -  ');
     AddPrintData(rptLF);
     AddPrintData(rptLF);
     AddPrintData(rptLF);
     AddPrintData(rptLF);
     AddPrintData(rptLF);
     AddPrintData(rptOneLine);
     AddPrintData(rptLF);
   end;
end;

procedure TDevice.MemPointPrint;
begin
  if Common.isVoidRePrint then Exit;
  PrintData := EmptyStr;
  with Common,Common.Present do
  begin
    AddPrintData(rptSizeBoth);
    AddPrintData(rptAlignCenter);
    AddPrintData('포인트 결제');
    AddPrintData(rptAlignLeft);
    AddPrintData(rptLF);
    Cashier_Header(0);
    AddPrintData(rptSizeNormal);
    AddPrintData('    회 원 번 호 : '+Member.Code);
    AddPrintData('    회   원  명 : '+Member.Name);
    AddPrintData('    사용 포인트 : '+LPadB(FormatFloat('#,#0',UsePnt)+'점',20,' '));
    AddPrintData('    잔여 포인트 : '+LPadB(FormatFloat('#,#0',Member.Point)+'점',20,' '));
    AddPrintData(rptLF);
    AddPrintData(rptLF);
    AddPrintData(' - 서   명 - ' );
    AddPrintData(rptLF);
    AddPrintData(rptLF);
    AddPrintData(rptLF);
    AddPrintData(rptLF);
    AddPrintData(rptOneLine);
    AddPrintData(rptLF);
  end;
end;

procedure TDevice.CardPrint(aKind:Integer=0);
var I, vIndex :Integer;
    vTemp :String;
label go_Print, go_Print1;
begin
  with Common.Card_SGrd, Common.Config  do
  begin
    //다중사업자 사용하지 않을때
    if GetOption(60) = '0' then
    begin
      For I:= 0 to RowCount-1 do
      begin
        go_Print:
        if (Common.SplitPrintMode = spmSplit) then
          PrintData := EmptyStr;

        if Trim(Cells[GDC_YN_PRINT, I]) = 'Y' then
        begin
           AddPrintData(rptSizeNormal);
           AddPrintData(rptCharBold);
           AddPrintData(rptAlignCenter);
           if Common.IsBusinessVersion then
             AddPrintData('!!! 영업 지원용 !!!');
           if aKind <> 0 then
           begin
             AddPrintData(rptAlignCenter);
             if Trim(Cells[GDC_DS_TRD,I]) = dtApproval then
               AddPrintData('[ 신용카드(승인)전표 ]')
             else
               AddPrintData('[ 신용카드(취소)전표 ]');
           end;
           AddPrintData(rptSizeNormal);
           AddPrintData(rptCharNormal);
           if GetOption(382) = '1' then
             AddPrintData(rptAlignCenter);
           case aKind of
             0,3 :
             begin
               //영수증과 신용카드 전표를 별도로 출력 체크했을때   영수증출력매수 0
               if (Common.SplitPrintMode = spmSplit) or (aKind = 3) or (GetOption(80) = '0') then
               begin
                 if GetOption(382) = '1' then
                   AddPrintData('(고객보관용)');
                 AddPrintData(rptLF);
                 AddPrintData(rptAlignLeft);
                 if GetOption(336) = '1' then
                   Cashier_Header(0, Cells[GDC_CORNER, I])
                 else if (Common.SplitPrintMode = spmSplit) or (GetOption(80) = '0') then
                   Cashier_Header(0, '');
               end;
             end;
             1 :
             begin
               if GetOption(382) = '1' then
                 AddPrintData('(가맹점보관용)');
               AddPrintData(rptLF);
               AddPrintData(rptAlignLeft);
               if GetOption(336) = '1' then
                 Cashier_Header(0, Cells[GDC_CORNER, I]);
             end;
             2 :
             begin
               if GetOption(382) = '1' then
                 AddPrintData('(카드사제출용)');
               AddPrintData(rptLF);
               AddPrintData(rptAlignLeft);
               if GetOption(336) = '1' then
                 Cashier_Header(0, Cells[GDC_CORNER, I]);
             end;
           end;
           AddPrintData(rptAlignLeft);
           if (Cells[GDC_TYPE_TRD, I] = atSwipe) or (Cells[GDC_TYPE_TRD, I] = atKeyin) or (Cells[GDC_DS_CARD, I] = atPG) then
           begin
              case StoI(GetOption(208)) of
                0 : AddPrintData(rptSizeNormal);
                1 : AddPrintData(rptSizeHeight);
                2 : AddPrintData(rptSizeWidth);
              end;
              AddPrintData('카 드 명  : '+Cells[GDC_NAME,    I]);
              if (Cells[GDC_DS_CARD,I] = 'C') or (Cells[GDC_DS_CARD, I] = atPG) then
              begin
                case StoI(GetOption(209)) of
                  0 : AddPrintData(rptSizeNormal);
                  1 : AddPrintData(rptSizeHeight);
                  2 : AddPrintData(rptSizeWidth);
                end;
                AddPrintData('카드번호  : '+Common.GetCardNoFormat(Cells[GDC_CARDNO,I]));
              end;
              if Trim(Cells[GDC_DS_TRD,I]) = dtCancel then
              begin
                case StoI(GetOption(218)) of
                  1 : AddPrintData(rptSizeNormal);
                  2 : AddPrintData(rptSizeHeight);
                  3 : AddPrintData(rptSizeWidth);
                end;
                if (GetOption(218) <> '0') then
                  AddPrintData('공급금액  : '+LPadB(FormatFloat('#,##0',(StoI(Cells[GDC_AMT,I]) - StoI(Cells[GDC_VATAMT,I]))*-1)+' 원',14, ' '));

                case StoI(GetOption(219)) of
                  1 : AddPrintData(rptSizeNormal);
                  2 : AddPrintData(rptSizeHeight);
                  3 : AddPrintData(rptSizeWidth);
                end;
                if (GetOption(219)<>'0') then
                  AddPrintData('부가세금액: '+LPadB(FormatFloat('#,##0',StoI(Cells[GDC_VATAMT,I])*-1)+' 원',14, ' '));

                case StoI(GetOption(220)) of
                  1 : AddPrintData(rptSizeNormal);
                  2 : AddPrintData(rptSizeHeight);
                  3 : AddPrintData(rptSizeWidth);
                end;
                if (StoI(Cells[GDC_TIPAMT,I]) > 0) and (GetOption(220)<>'0') then
                  AddPrintData('봉사료금액: '+LPadB(FormatFloat('#,##0',StoI(Cells[GDC_TIPAMT,I])*-1)+' 원',14,' '));
                case StoI(GetOption(212)) of
                  0 : AddPrintData(rptSizeNormal);
                  1 : AddPrintData(rptSizeHeight);
                  2 : AddPrintData(rptSizeWidth);
                end;
                AddPrintData('취소금액  : '+LPadB(FormatFloat('#,##0',StoI(Cells[GDC_AMT,I])*-1)+' 원', 14, ' '));
                if Cells[GDC_BALANCEAMT, I] <> EmptyStr then
                  AddPrintData('    잔액  : '+LPadB(FormatFloat('#,##0',StoI(Cells[GDC_BALANCEAMT,I]))+' 원', 14, ' '));
              end
              else
              begin
                case StoI(GetOption(218)) of
                  1 : AddPrintData(rptSizeNormal);
                  2 : AddPrintData(rptSizeHeight);
                  3 : AddPrintData(rptSizeWidth);
                end;
                if (GetOption(218)<>'0') then
                  AddPrintData('공급금액  : '+LPadB(FormatFloat('#,##0',StoI(Cells[GDC_AMT,I]) - StoI(Cells[GDC_VATAMT,I]))+' 원',14, ' '));

                case StoI(GetOption(219)) of
                  1 : AddPrintData(rptSizeNormal);
                  2 : AddPrintData(rptSizeHeight);
                  3 : AddPrintData(rptSizeWidth);
                end;
                if (GetOption(219)<>'0') then
                  AddPrintData('부가세금액: '+LPadB(FormatFloat('#,##0',StoI(Cells[GDC_VATAMT,I]))+' 원', 14, ' '));

                case StoI(GetOption(220)) of
                  1 : AddPrintData(rptSizeNormal);
                  2 : AddPrintData(rptSizeHeight);
                  3 : AddPrintData(rptSizeWidth);
                end;
                if (StoI(Cells[GDC_TIPAMT,I]) > 0) and (GetOption(220)<>'0') then
                  AddPrintData('봉사료금액: '+LPadB(FormatFloat('#,##0',StoI(Cells[GDC_TIPAMT,I]))+' 원', 14, ' '));

                case StoI(GetOption(212)) of
                  0 : AddPrintData(rptSizeNormal);
                  1 : AddPrintData(rptSizeHeight);
                  2 : AddPrintData(rptSizeWidth);
                end;
                if Cells[GDC_HALBU,I] = '00' then vTemp := '(일시불)'
                else vTemp := '('+Cells[GDC_HALBU,I]+'개월'+')';

                AddPrintData('승인금액  : '+LPadB(FormatFloat('#,##0',StoI(Cells[GDC_AMT,I])-StoI(Cells[GDC_AMT_CANCEL,I]))+' 원', 14, ' ') + vTemp);
                if Cells[GDC_BALANCEAMT, I] <> EmptyStr then
                  AddPrintData('    잔액  : '+LPadB(FormatFloat('#,##0',StoI(Cells[GDC_BALANCEAMT,I]))+' 원', 14, ' '));
              end;

              case StoI(GetOption(214)) of
                0 : AddPrintData(rptSizeNormal);
                1 : AddPrintData(rptSizeHeight);
                2 : AddPrintData(rptSizeWidth);
              end;

              AddPrintData('승인번호  : '+Cells[GDC_NO_APPROVAL,I]+Ifthen((Cells[GDC_DS_CARD, I] = atPG),'', ' ('+Cells[GDC_CHAINPL,I]+')'));
              case StoI(GetOption(215)) of
                1 : AddPrintData(rptSizeNormal);
                2 : AddPrintData(rptSizeHeight);
                3 : AddPrintData(rptSizeWidth);
              end;
              if (GetOption(215) <> '0') and (Cells[GDC_DS_CARD, I] <> 'P') then
                AddPrintData('매입사명  : '+Cells[GDC_NM_BUY,I]+VANTRDPL[Common.Config.van_trd]);

              case StoI(GetOption(216)) of
                1 : AddPrintData(rptSizeNormal);
                2 : AddPrintData(rptSizeHeight);
                3 : AddPrintData(rptSizeWidth);
              end;
              if GetOption(216) <> '0' then
              AddPrintData('승인일시  : '+FormatMaskText('!0000년90월90일 00:00;0;', Cells[GDC_TRD_DATE,I]+ Cells[GDC_TRD_TIME,I]));
              if Trim(Cells[GDC_DS_TRD,I]) = dtCancel then
              begin
                if Length(Cells[GDC_TRD_DATE_ORG,I]) = 8 then
                  AddPrintData('원거래일  : '+FormatMaskText('!0000/90/90;0;', Cells[GDC_TRD_DATE_ORG,I]))
                else
                  AddPrintData('원거래일  : '+FormatMaskText('!0000/90/90;0;', '20'+Cells[GDC_TRD_DATE_ORG,I]));
              end;

              //스타밴 금결원 일때는 메세지 추가
              case StoI(GetOption(217)) of
                1 : AddPrintData(rptSizeNormal);
                2 : AddPrintData(rptSizeHeight);
                3 : AddPrintData(rptSizeWidth);
              end;
              if (GetOption(217) <> '0') or (Cells[GDC_DS_CARD,I] = 'I') then
                case van_trd of
                  vanDaou,
                  vanKCP,
                  vanKFTC,
                  vanSmartro :
                  begin
                    if LengthB(Cells[GDC_NOTE,I]) > 30 then
                    begin
                      AddPrintData('전표구분  : '+ sCopy(Cells[GDC_NOTE,I],1,27));
                      AddPrintData('            '+ sCopy(Cells[GDC_NOTE,I],28,LengthB(Cells[GDC_NOTE,I])-28));

                    end
                    else AddPrintData(Ifthen(Cells[GDC_DS_CARD,I]='I','계좌번호', '전표구분')+'  : '+Cells[GDC_NOTE,I]);
                  end;
                end;
           end;
          if Trim(Cells[GDC_NOTE,I]) <> '' then
            AddPrintData('알림:'+Trim(Cells[GDC_NOTE,I]));


          {카드사제출용, 매장보관용에만 출력}
          //제이티넷 취소일때는 출력하지 않는다
          if ((Common.Config.van_trd = vanJTNET) and (GetOption(379) = '2') and (Trim(Cells[GDC_DS_TRD,I]) = dtCancel)) then

          else
          begin
            if (GetOption(69) = '0') and (Trim(Cells[GDC_IMGFILE,I]) = '') and (GetOption(379) <> '1') and (Trim(Cells[GDC_YN_NOCVM,I]) = 'N') and (Trim(Cells[GDC_DS_CARD,I]) <> atPG) then
            case aKind of
              1,2 :
              begin
                AddPrintData('--- 서 명 -------------------------------');
                AddPrintData(rptLF);
                AddPrintData(rptLF);
                AddPrintData(rptLF);
                AddPrintData(rptLF);
                AddPrintData(rptLF);
              end;
            end
            else if (GetOption(69) = '0') and (GetOption(379) <> '1') and (Trim(Cells[GDC_YN_NOCVM,I]) = 'N') then
            begin
              case I of
                0 : AddPrintData(rptSignImage0);
                1 : AddPrintData(rptSignImage1);
                2 : AddPrintData(rptSignImage2);
                3 : AddPrintData(rptSignImage3);
                4 : AddPrintData(rptSignImage4);
                5 : AddPrintData(rptSignImage5);
                6 : AddPrintData(rptSignImage6);
                7 : AddPrintData(rptSignImage7);
                8 : AddPrintData(rptSignImage8);
                9 : AddPrintData(rptSignImage9);
              end;
            end;
          end;

          vTemp := Cells[GDC_REALMODE,I];

          if (I < RowCount -1) or (Common.SplitPrintMode = spmSplit) then
          begin
            AddPrintData(rptTwoLine);
            For vIndex := 1 to 5 do
              if Trim(Common.Config.Card_End[vIndex]) <> '' then  AddPrintData(Common.Config.Card_End[vIndex]);
            //별도출력일때만 한줄을 띄운다
            if Common.SplitPrintMode = spmSplit then
              AddPrintData(rptLF);
          end
          else
            AddPrintData(rptOneLine);
            For vIndex := 1 to 5 do
              if Trim(Common.Config.Card_End[vIndex]) <> '' then  AddPrintData(Common.Config.Card_End[vIndex]);

          case StoI(GetOption(124)) of
            1 : AddPrintData(rptSizeNormal);
            2 : AddPrintData(rptSizeHeight);
            3 : AddPrintData(rptSizeWidth);
          end;
          if (GetOption(124) <> '0') then
            AddPrintData('테이블번호 : '+ Ifthen(GetOption(58) = '0', Common.Table.FloorName+'-', '') + Ifthen(GetOption(25) = '0', IntToStr(Common.Table.Number), Common.Table.Name));
        end;

        AddPrintData(rptSizeNormal);
        if vTemp = 'FALSE' then
          AddPrintData('실제 승인이 아닙니다(테스트모드)');

        //영수증과 신용카드전표 별도 출력
        if Common.SplitPrintMode = spmSplit then
        begin
          Common.PrintBuffer.Add(PrintData);
          PrintData := EmptyStr;
        end;

        //수기승인일때는 두장 출력하도록 한다
        if (GetOption(379) <> '1') and (Cells[GDC_DS_CARD,I] <> atPG ) and (GetOption(6) = '0') and (aKind = 0) and ((Trim(Cells[GDC_IMGFILE,I]) = '') and (Trim(Cells[GDC_YN_NOCVM,I]) = 'N')) then
        begin
          aKind := 1;
          Common.PrintBuffer.Add(PrintData);
          PrintData := EmptyStr;
          Goto go_print;
        end;
      end;
    end
    else //다중사업자
    begin
      For I:= 0 to RowCount-1 do
      begin
         go_print1:
         if (Common.SplitPrintMode = spmSplit) then
           PrintData := EmptyStr;

         if Trim(Cells[GDC_YN_PRINT, I]) = 'Y' then
         begin
            AddPrintData(rptSizeNormal);
            AddPrintData(rptCharBold);
            if Common.IsBusinessVersion then
            begin
              AddPrintData(rptAlignCenter);
              AddPrintData('!!! 영업 지원용 !!!');
            end;
            AddPrintData(rptAlignCenter);
            if Trim(Cells[GDC_DS_TRD,I]) = dtCancel then
              AddPrintData('[ 신용카드(취소)전표 ]')
            else
              AddPrintData('[ 신용카드(승인)전표 ]');
            AddPrintData(rptSizeNormal);
            AddPrintData(rptCharNormal);
            if GetOption(382) = '1' then
              AddPrintData(rptAlignCenter);
            if (Cells[GDC_TYPE_TRD, I] = atSwipe) or (Cells[GDC_TYPE_TRD, I] = atKeyin) or (Cells[GDC_DS_CARD, I] = atPG) then
            begin
               if GetOption(382) = '1' then
                 case aKind of
                   0 : AddPrintData('(고객보관용)');
                   1 : AddPrintData('(가맹점보관용)');
                   2 : AddPrintData('(카드사제출용)');
                 end;
               AddPrintData(rptLF);
               AddPrintData(rptAlignLeft);
               //신용카드 매장정보 출력
               if GetOption(336) = '1' then
                 SetTitle(Cells[GDC_CORNER,I] );

               AddPrintData(rptAlignLeft);
               case StoI(GetOption(208)) of
                 0 : AddPrintData(rptSizeNormal);
                 1 : AddPrintData(rptSizeHeight);
                 2 : AddPrintData(rptSizeWidth);
               end;
               AddPrintData('카 드 명  : '+Cells[GDC_NAME,    I]);

               if (Cells[GDC_DS_CARD,I] = 'C') or (Cells[GDC_DS_CARD, I] = atPG) then
               begin
                 case StoI(GetOption(209)) of
                   0 : AddPrintData(rptSizeNormal);
                   1 : AddPrintData(rptSizeHeight);
                   2 : AddPrintData(rptSizeWidth);
                 end;
                 AddPrintData('카드번호  : '+Common.GetCardNoFormat(Cells[GDC_CARDNO,I]));
               end;

               if Trim(Cells[GDC_DS_TRD,I]) = dtCancel then
               begin
                 case StoI(GetOption(218)) of
                   1 : AddPrintData(rptSizeNormal);
                   2 : AddPrintData(rptSizeHeight);
                   3 : AddPrintData(rptSizeWidth);
                 end;
                 if (GetOption(218)<>'0') then
                   AddPrintData('공급금액  : '+LPadB(FormatFloat('#,##0',(StoI(Cells[GDC_AMT,I]) - StoI(Cells[GDC_VATAMT,I]))*-1)+' 원',14, ' '));

                 case StoI(GetOption(219)) of
                   1 : AddPrintData(rptSizeNormal);
                   2 : AddPrintData(rptSizeHeight);
                   3 : AddPrintData(rptSizeWidth);
                 end;
                 if (GetOption(219)<>'0') then
                   AddPrintData('부가세금액: '+LPadB(FormatFloat('#,##0',StoI(Cells[GDC_VATAMT,I])*-1)+' 원',14, ' '));

                 case StoI(GetOption(220)) of
                   1 : AddPrintData(rptSizeNormal);
                   2 : AddPrintData(rptSizeHeight);
                   3 : AddPrintData(rptSizeWidth);
                 end;
                 if (StoI(Cells[GDC_TIPAMT,I]) > 0) and (GetOption(220)<>'0') then
                   AddPrintData('봉사료금액: '+LPadB(FormatFloat('#,##0',StoI(Cells[GDC_TIPAMT,I])*-1)+' 원',14,' '));
                 case StoI(GetOption(212)) of
                   0 : AddPrintData(rptSizeNormal);
                   1 : AddPrintData(rptSizeHeight);
                   2 : AddPrintData(rptSizeWidth);
                 end;
                 if Cells[GDC_HALBU,I] = '00' then vTemp := '(일시불)'
                 else vTemp := '('+Cells[GDC_HALBU,I]+'개월'+')';
                 AddPrintData('취소금액  : '+LPadB(FormatFloat('#,##0',StoI(Cells[GDC_AMT,I])*-1)+' 원', 14, ' ')+vTemp);
                 if Cells[GDC_BALANCEAMT, I] <> EmptyStr then
                   AddPrintData('    잔액  : '+LPadB(FormatFloat('#,##0',StoI(Cells[GDC_BALANCEAMT,I]))+' 원', 14, ' '));
               end
               else
               begin
                 case StoI(GetOption(218)) of
                   1 : AddPrintData(rptSizeNormal);
                   2 : AddPrintData(rptSizeHeight);
                   3 : AddPrintData(rptSizeWidth);
                 end;
                 if (GetOption(218)<>'0') then
                   AddPrintData('공급금액  : '+LPadB(FormatFloat('#,##0',StoI(Cells[GDC_AMT,I]) - StoI(Cells[GDC_VATAMT,I]))+' 원',14, ' '));

                 case StoI(GetOption(219)) of
                   1 : AddPrintData(rptSizeNormal);
                   2 : AddPrintData(rptSizeHeight);
                   3 : AddPrintData(rptSizeWidth);
                 end;
                 if (GetOption(219)<>'0') then
                   AddPrintData('부가세금액: '+LPadB(FormatFloat('#,##0',StoI(Cells[GDC_VATAMT,I]))+' 원', 14, ' '));

                 case StoI(GetOption(220)) of
                   1 : AddPrintData(rptSizeNormal);
                   2 : AddPrintData(rptSizeHeight);
                   3 : AddPrintData(rptSizeWidth);
                 end;
                 if (StoI(Cells[GDC_TIPAMT,I]) > 0) and (GetOption(220)<>'0') then
                   AddPrintData('봉사료금액: '+LPadB(FormatFloat('#,##0',StoI(Cells[GDC_TIPAMT,I]))+' 원', 14, ' '));

                 case StoI(GetOption(212)) of
                   0 : AddPrintData(rptSizeNormal);
                   1 : AddPrintData(rptSizeHeight);
                   2 : AddPrintData(rptSizeWidth);
                 end;
                 if Cells[GDC_HALBU,I] = '00' then vTemp := '(일시불)'
                 else vTemp := '('+Cells[GDC_HALBU,I]+'개월'+')';

                 AddPrintData('승인금액  : '+LPadB(FormatFloat('#,##0',StoI(Cells[GDC_AMT,I])-StoI(Cells[GDC_AMT_CANCEL,I]))+' 원', 14, ' ')+vTemp);
                 if Cells[GDC_BALANCEAMT, I] <> EmptyStr then
                   AddPrintData('    잔액  : '+LPadB(FormatFloat('#,##0',StoI(Cells[GDC_BALANCEAMT,I]))+' 원', 14, ' '));
               end;
               AddPrintData(rptSizeNormal);

               case StoI(GetOption(214)) of
                 0 : AddPrintData(rptSizeNormal);
                 1 : AddPrintData(rptSizeHeight);
                 2 : AddPrintData(rptSizeWidth);
               end;
               AddPrintData('승인번호  : '+Cells[GDC_NO_APPROVAL,I]+Ifthen((Cells[GDC_DS_CARD, I] = atPG),'',' ('+Cells[GDC_CHAINPL,I]+')'));
               case StoI(GetOption(215)) of
                 1 : AddPrintData(rptSizeNormal);
                 2 : AddPrintData(rptSizeHeight);
                 3 : AddPrintData(rptSizeWidth);
               end;
               if (GetOption(215) <> '0') and (Cells[GDC_DS_CARD, I] <> 'P') then
                 AddPrintData('매입사명  : '+Cells[GDC_NM_BUY,I]+VANTRDPL[Common.Config.van_trd]);
               case StoI(GetOption(216)) of
                 1 : AddPrintData(rptSizeNormal);
                 2 : AddPrintData(rptSizeHeight);
                 3 : AddPrintData(rptSizeWidth);
               end;
               if GetOption(216) <> '0' then
                 AddPrintData('승인일시  : '+FormatMaskText('!0000년90월90일 00:00;0;', Cells[GDC_TRD_DATE,I]+ Cells[GDC_TRD_TIME,I]));

               if Trim(Cells[GDC_DS_TRD,I]) = dtCancel then
               begin
                 if Length(Cells[GDC_TRD_DATE_ORG,I]) = 8 then
                   AddPrintData('원거래일  : '+FormatMaskText('!0000/90/90;0;', Cells[GDC_TRD_DATE_ORG,I]))
                 else
                   AddPrintData('원거래일  : '+FormatMaskText('!0000/90/90;0;', '20'+Cells[GDC_TRD_DATE_ORG,I]));
               end;

              if Trim(Cells[GDC_NOTE,I]) <> '' then
                AddPrintData('알림:'+Trim(Cells[GDC_NOTE,I]));


               //다우,금결원 일때는 메세지 추가
               case StoI(GetOption(217)) of
                 1 : AddPrintData(rptSizeNormal);
                 2 : AddPrintData(rptSizeHeight);
                 3 : AddPrintData(rptSizeWidth);
               end;
               if (GetOption(217) <> '0') or (Cells[GDC_DS_CARD,I] = 'I') then
                 case Common.Config.van_trd of
                   1, 6, 9, 10 :
                   begin
                     if LengthB(Cells[GDC_NOTE,I]) > 30 then
                     begin
                       AddPrintData('전표구분  : '+ sCopy(Cells[GDC_NOTE,I],1,27));
                       AddPrintData('            '+ sCopy(Cells[GDC_NOTE,I],28,LengthB(Cells[GDC_NOTE,I])-28));

                     end
                     else AddPrintData(Ifthen(Cells[GDC_DS_CARD,I]='I','계좌번호', '전표구분')+'  : '+Cells[GDC_NOTE,I]);
                   end;
                 end;
            end;
           {카드사제출용, 매장보관용에만 출력}
           if ((Common.Config.van_trd = vanJTNET) and (GetOption(379) = '2') and (Trim(Cells[GDC_DS_TRD,I]) = dtCancel)) then
           else
           begin
             if (GetOption(69) = '0') and (Trim(Cells[GDC_IMGFILE,I]) = '') and (Cells[GDC_DS_CARD,I] <> atPG ) and (GetOption(379) <> '1') and (Trim(Cells[GDC_YN_NOCVM,I]) = 'N') and (Trim(Cells[GDC_DS_CARD,I]) <> 'P') then
             case aKind of
               1,2 :
               begin
                 AddPrintData('--- 서 명 -------------------------------');
                 AddPrintData(rptLF);
                 AddPrintData(rptLF);
                 AddPrintData(rptLF);
                 AddPrintData(rptLF);
                 AddPrintData(rptLF);
               end;
             end
             else if (GetOption(69) = '0') and (GetOption(379) <> '1') and (Trim(Cells[GDC_YN_NOCVM,I]) = 'N')  then
             begin
               case I of
                 0 : AddPrintData(rptSignImage0);
                 1 : AddPrintData(rptSignImage1);
                 2 : AddPrintData(rptSignImage2);
                 3 : AddPrintData(rptSignImage3);
                 4 : AddPrintData(rptSignImage4);
                 5 : AddPrintData(rptSignImage5);
                 6 : AddPrintData(rptSignImage6);
                 7 : AddPrintData(rptSignImage7);
                 8 : AddPrintData(rptSignImage8);
                 9 : AddPrintData(rptSignImage9);
               end;
             end;
           end;

           vTemp := Cells[GDC_REALMODE,I];

           if (I < RowCount -1) or (Common.SplitPrintMode = spmSplit) then
           begin
              AddPrintData(rptTwoLine);
              For vIndex := 1 to 5 do
                if Trim(Common.Config.Card_End[vIndex]) <> '' then  AddPrintData(Common.Config.Card_End[vIndex]);
              if Common.SplitPrintMode = spmSplit then
                AddPrintData(rptLF);
           end
           else
           begin
              AddPrintData(rptOneLine);
             For vIndex := 1 to 5 do
               if Trim(Common.Config.Card_End[vIndex]) <> '' then  AddPrintData(Common.Config.Card_End[vIndex]);
           end;

          case StoI(GetOption(124)) of
            1 : AddPrintData(rptSizeNormal);
            2 : AddPrintData(rptSizeHeight);
            3 : AddPrintData(rptSizeWidth);
          end;
          if (GetOption(124) <> '0') then
            AddPrintData('테이블번호 : '+ Ifthen(GetOption(58) = '0', Common.Table.FloorName+'-', '') + Ifthen(GetOption(25) = '0', IntToStr(Common.Table.Number), Common.Table.Name));

         end; //if Trim(Cells[GDC_YN_PRINT, I]) = 'Y' then

         if vTemp = 'FALSE' then
           AddPrintData('실제 승인이 아닙니다(테스트모드)');

         if Common.SplitPrintMode = spmSplit then
         begin
           Common.PrintBuffer.Add(PrintData);
           PrintData := EmptyStr;
         end;

         //수기승인일때는 두장 출력하도록 한다
         if (GetOption(379) <> '1') and (GetOption(6) = '0') and (aKind = 0) and (Cells[GDC_DS_CARD,I] <> atPG) and (Trim(Cells[GDC_IMGFILE,I]) = '') and (Trim(Cells[GDC_YN_NOCVM,I]) = 'N') then
         begin
           Common.PrintBuffer.Add(PrintData);
           PrintData := EmptyStr;
           aKind := 1;
           Goto go_print1;
         end;
      end;

      end;
    end;
end;

procedure TDevice.CreditPrint(Kind:Integer=0);
var vIndex :Integer;
    vTemp :String;
label go_Print;
begin
   go_Print:

   PrintData := EmptyStr;
   with Common.Card, Common.Config do
   begin
     if (Kind <> 0) and (Ds_Card = 'P') then
       Exit;

     AddPrintData(rptSizeNormal);
     AddPrintData(rptCharBold);

     if Common.IsBusinessVersion then
     begin
       AddPrintData(rptAlignCenter);
       AddPrintData('!!! 영업 지원용 !!!');
     end;
     AddPrintData(rptAlignCenter);
     if Trim(Ds_trd) = dtApproval then
       AddPrintData('[신용카드(승인)전표]')
     else
       AddPrintData('[신용카드(취소)전표]');
     AddPrintData(rptSizeNormal);
     if GetOption(382) = '1' then
     begin
       AddPrintData(rptAlignCenter);
       AddPrintData(rptCharNormal);
       case Kind of
         0 : AddPrintData('(고객보관용)');
         1 : AddPrintData('(가맹점보관용)');
         2 : AddPrintData('(카드사제출용)');
       end;
     end;
     AddPrintData(rptAlignLeft);
     AddPrintData(rptLF);
     AddPrintData(rptCharNormal);
     if GetOption(336) = '1' then
       Cashier_Header(no_van, Corner);

    case StoI(GetOption(208)) of
      0 : AddPrintData(rptSizeNormal);
      1 : AddPrintData(rptSizeHeight);
      2 : AddPrintData(rptSizeWidth);
    end;
    AddPrintData('카 드 명  : '+Nm_Card);

    if (Ds_Card = 'C') or (Ds_Card = 'P') then
    begin
      case StoI(GetOption(209)) of
        0 : AddPrintData(rptSizeNormal);
        1 : AddPrintData(rptSizeHeight);
        2 : AddPrintData(rptSizeWidth);
      end;
      AddPrintData('카드번호  : '+Common.GetCardNoFormat(CardNo));
    end;

    if Ds_trd = dtCancel then
    begin
      case StoI(GetOption(218)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
      end;
      if (GetOption(218)<>'0') then
        AddPrintData('공급금액  : '+LPadB(FormatFloat('#,##0',(Amt-VatAmt)*-1)+' 원',14, ' '));

      case StoI(GetOption(218)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
      end;
      if (GetOption(219)<>'0') then
        AddPrintData('부가세금액: '+LPadB(FormatFloat('#,##0',VatAmt*-1)+' 원',14, ' '));

      case StoI(GetOption(220)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
      end;
      if (TipAmt > 0) and (GetOption(220)<>'0') then
        AddPrintData('봉사료금액: '+LPadB(FormatFloat('#,##0',TipAmt*-1)+' 원',14,' '));
      case StoI(GetOption(212)) of
        0 : AddPrintData(rptSizeNormal);
        1 : AddPrintData(rptSizeHeight);
        2 : AddPrintData(rptSizeWidth);
      end;

      if (Ds_Card = 'C') or (Ds_Card = 'P') then
      begin
        if Halbu = '00' then vTemp := '(일시불)'
        else vTemp := '('+Halbu+'개월'+')';
      end;

      AddPrintData('취소금액  : '+LPadB(FormatFloat('#,##0',Amt*-1)+' 원', 14, ' ')+vTemp);
      if BalanceAmt <> '' then
        AddPrintData('    잔액  : '+LPadB(FormatFloat('#,##0',StoI(BalanceAmt))+' 원', 14, ' '));
    end
    else
    begin
      case StoI(GetOption(218)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
      end;
      if (GetOption(218)<>'0') then
        AddPrintData('공급금액  : '+LPadB(FormatFloat('#,##0',Amt-VatAmt)+' 원',14, ' '));

      case StoI(GetOption(219)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
      end;
      if (GetOption(219)<>'0') then
        AddPrintData('부가세금액: '+LPadB(FormatFloat('#,##0',VatAmt)+' 원', 14, ' '));

      case StoI(GetOption(220)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
      end;
      if (TipAmt > 0) and (GetOption(220)<>'0') then
        AddPrintData('봉사료금액: '+LPadB(FormatFloat('#,##0',TipAmt)+' 원', 14, ' '));

      case StoI(GetOption(212)) of
        0 : AddPrintData(rptSizeNormal);
        1 : AddPrintData(rptSizeHeight);
        2 : AddPrintData(rptSizeWidth);
      end;

      if (Ds_Card = 'C') or ((Ds_Card = 'P') and (Type_Trd = 'P')) then
      begin
        if Halbu = '00' then vTemp := '(일시불)'
        else vTemp := '('+Halbu+'개월'+')';
      end;
      AddPrintData('승인금액  : '+LPadB(FormatFloat('#,##0',Amt)+' 원', 14, ' ')+vTemp);
      if BalanceAmt <> '' then
        AddPrintData('    잔액  : '+LPadB(FormatFloat('#,##0',StoI(BalanceAmt))+' 원', 14, ' '));
    end;

    case StoI(GetOption(214)) of
      0 : AddPrintData(rptSizeNormal);
      1 : AddPrintData(rptSizeHeight);
      2 : AddPrintData(rptSizeWidth);
    end;
    AddPrintData('승인번호  : '+ApprovalNo+' ('+ChainPL+')');
    case StoI(GetOption(215)) of
      1 : AddPrintData(rptSizeNormal);
      2 : AddPrintData(rptSizeHeight);
      3 : AddPrintData(rptSizeWidth);
    end;
    if (GetOption(215) <> '0') and (Ds_Card <> 'P') then
      AddPrintData('매입사명  : '+nm_buy+VANTRDPL[Common.Config.van_trd]);
    case StoI(GetOption(216)) of
      1 : AddPrintData(rptSizeNormal);
      2 : AddPrintData(rptSizeHeight);
      3 : AddPrintData(rptSizeWidth);
    end;
    if GetOption(216) <> '0' then
      AddPrintData('승인일시  : '+FormatMaskText('!0000년90월90일 00:00;0;', Trd_Date + Trd_Time));

    if Trim(Ds_trd) = '2' then
    begin
      if Length(Trd_Date_Org) = 8 then
        AddPrintData('원거래일  : '+FormatMaskText('!0000/90/90;0;', Trd_Date_Org))
      else
        AddPrintData('원거래일  : '+FormatMaskText('!0000/90/90;0;', '20'+Trd_Date_Org));
    end;

    if Note <> '' then
      AddPrintData('알림:'+Trim(Note));


    case StoI(GetOption(217)) of
      1 : AddPrintData(rptSizeNormal);
      2 : AddPrintData(rptSizeHeight);
      3 : AddPrintData(rptSizeWidth);
    end;
    if (GetOption(217) <> '0') or (Ds_Card = 'I') then
      //스타밴 금결원 일때는 메세지 추가
      case van_trd of
        1, 6, 9, 10 :
        begin
          if LengthB(Note) > 30 then
          begin
            AddPrintData('전표구분  : '+ sCopy(Note,1,27));
            AddPrintData('            '+ sCopy(Note,28,LengthB(Note)-28));
          end
          else AddPrintData(Ifthen(Ds_Card='I','계좌번호', '전표구분')+'  : '+Note);
        end;
      end;

    {카드사제출용, 매장보관용에만 출력}
    if ((Common.Config.van_trd = vanJTNET) and (GetOption(379) = '2') and (DS_TRD = dtCancel)) then
    else
    begin
      if (GetOption(69) = '0') and (Trim(ImgFile) = '') and (GetOption(379) <> '1') and (Yn_NoCVM = 'N') and (Ds_Card <> 'P') then
      case Kind of
        1,2 :
        begin
          AddPrintData(rptLF);
          AddPrintData('--- 서 명 -------------------------------');
          AddPrintData(rptLF);
          AddPrintData(rptLF);
          AddPrintData(rptLF);
          AddPrintData(rptLF);
          AddPrintData(rptLF);
        end;
      end
      else if (GetOption(69) = '0') and (GetOption(379) <> '1') and (Yn_NoCVM = 'N')  then
      begin
        case Common.Card_sGrd.RowCount-1 of
          0 : AddPrintData(rptSignImage0);
          1 : AddPrintData(rptSignImage1);
          2 : AddPrintData(rptSignImage2);
          3 : AddPrintData(rptSignImage3);
          4 : AddPrintData(rptSignImage4);
          5 : AddPrintData(rptSignImage5);
          6 : AddPrintData(rptSignImage6);
          7 : AddPrintData(rptSignImage7);
          8 : AddPrintData(rptSignImage8);
          9 : AddPrintData(rptSignImage9);
        end;
      end;
    end;

    AddPrintData(rptTwoLine);
    case StoI(GetOption(124)) of
      1 : AddPrintData(rptSizeNormal);
      2 : AddPrintData(rptSizeHeight);
      3 : AddPrintData(rptSizeWidth);
    end;
    if (GetOption(124) <> '0') then
      AddPrintData('테이블번호 : '+ Ifthen(GetOption(58) = '0', Common.Table.FloorName+'-', '') + Ifthen(GetOption(25) = '0', IntToStr(Common.Table.Number), Common.Table.Name));

    For vIndex := 1 to 5 do
      if Trim(Card_End[vIndex]) <> '' then  AddPrintData(Card_End[vIndex]);

    if not RealMode then
    begin
      AddPrintData('실제 승인이 아닙니다(테스트모드)');
      AddPrintData(rptLF);
    end
    else AddPrintData(rptLF);
    try
      PrintPrinter(rptCredit);
    except
    end;
    //단말기연동은 무조건 전자서명 승인으로 간주한다/ 수기숭인일때는 두장출력하도록한다
    if (GetOption(379) <> '1') and (Ds_Card <> atPG ) and (GetOption(6)='0') and (Kind = 0) and (Trim(ImgFile) = '') and (Yn_NoCVM = 'N') then
    begin
      Kind := 1;
      Goto go_Print;
    end;
  end;
end;

procedure TDevice.CashRcpPrint;
var I, vIndex :Integer;
    lsStr :String;
begin
  PrintData := EmptyStr;
  with Common do
  begin
    lsStr := ' ';
    For I := 0 to Common.Cash_SGrd.RowCount-1 do
    begin
      if (Cash_sGrd.Cells[GDR_DS_INPUT,I] <> 'O') and (Cash_sGrd.Cells[GDR_YN_PRINT,I] = 'Y') then
      begin
         //개인과 사업자가 한 영수증에 같이 있을때
         if (Cash_sGrd.Cells[GDR_DS_KIND,I]) <> lsStr then
         begin
            AddPrintData(rptSizeWidth);
            AddPrintData(rptAlignCenter);
            if Cash_sGrd.Cells[GDR_DS_KIND,I] = '0' then
               AddPrintData('현금(소득공제)')
            else
               AddPrintData('현금(지출증빙)');
            AddPrintData(rptAlignLeft);
            AddPrintData(rptLF);
            AddPrintData(rptSizeNormal);
            lsStr := Cash_sGrd.Cells[GDR_DS_KIND,I];
         end;

         For vIndex := 1 to 4 do
           if Trim(Config.ReceiptTitle[vIndex]) <> '' then  AddPrintData(Config.ReceiptTitle[vIndex]);

         AddPrintData(rptTwoLine);
         AddPrintData(FormatMaskText('!0000년90월90일 00:00;0; ',Common.WorkDate+NowTime)+' 계산원:'+Common.Config.PosNo+'-'+Common.Config.UserName);
         AddPrintData(rptTwoLine);

         case StoI(Cash_sGrd.Cells[GDR_DS_TYPE,I]) of
            0 :
              begin
                 AddPrintData(' 식별번호 ( 카드번호 ) ');
                 AddPrintData(rptSizeWidth);
                 if Length(Cash_sGrd.Cells[GDR_CARDNO,I]) = 16 then
                   AddPrintData(LPadB(Common.GetCardNoFormat(Cash_sGrd.Cells[GDR_CARDNO,I]),20,' '))
                 else
                   AddPrintData(LPadB(Cash_sGrd.Cells[GDR_CARDNO,I],20,' '));
              end;
            1 :
              begin
                 AddPrintData(' 식별번호 ( 핸드폰번호 ) ');
                 AddPrintData(rptSizeWidth);
                 if Length(Cash_sGrd.Cells[GDR_CARDNO,I])= 11 then
                   AddPrintData(LPadB(FormatMaskText('!000-0000-00**;0;',Copy(Cash_sGrd.Cells[GDR_CARDNO,I],1,9)),20,' '))
                 else
                   AddPrintData(LPadB(FormatMaskText('!000-000-00**;0;',Copy(Cash_sGrd.Cells[GDR_CARDNO,I],1,8)),20,' '));
              end;
            2 :
              begin
                 AddPrintData(' 식별번호 ( 주민번호 ) ');
                 AddPrintData(rptSizeWidth);
                 AddPrintData(LPadB(FormatMaskText('!000000-*******;0;',Copy(Cash_sGrd.Cells[GDR_CARDNO,I],1,6)),20,' '));
              end;
            3 :
              begin
                 AddPrintData(' 식별번호 ( 사업자번호 ) ');
                 AddPrintData(rptSizeWidth);
                 AddPrintData(LPadB(FormatMaskText('!000-00-*****;0;',Copy(Cash_sGrd.Cells[GDR_CARDNO,I],1,5)),20,' '));
              end;
         end;
         AddPrintData(rptSizeNormal);
         if Cash_sGrd.Cells[GDR_DS_TRD,I] = dtCancel then
            AddPrintData('  승인금액 :'+Format('%21.21s',[FormatFloat('#,0',StoI(Cash_sGrd.Cells[GDR_AMT,I]))]))
         else
            AddPrintData('  취소금액 :'+Format('%21.21s',[FormatFloat('#,0',StoI(Cash_sGrd.Cells[GDR_AMT,I]))]));
         AddPrintData('  승인번호 :'+Format('%21.21s',[Cash_sGrd.Cells[GDR_NO_APPROVAL,I]]) );
         AddPrintData(rptLF);
      end;
    end;
  end;
  AddPrintData('http://www.hometax.go.kr');
  AddPrintData(rptOneLine);
  try
    PrintPrinter(rptCredit);
  except
  end;
end;

//정산표출력
procedure TDevice.CashierClosePrint(CloseNo:String);
var I :Integer;
    vPrintData :AnsiString;
begin
  PrintData := EmptyStr;

  With Common, Common.Magam, Common.Config do
  begin
     AddPrintData(rptSizeBoth);
     AddPrintData(rptAlignCenter);
     AddPrintData('계산원정산서');
     AddPrintData(rptAlignLeft);
     AddPrintData(rptLF);
     AddPrintData(rptSizeNormal);
     AddPrintData(pStr+'   포스번호 : '+PosNo+'-'+UserName);
     AddPrintData(pStr+'   개점일자 : '+FormatMaskText('!0000년90월90일;0; ',WorkDate)+DayToWeek(WorkDate));
     AddPrintData(rptTwoLine);
     AddPrintData(pStr+'   준 비 금(+):' +LPadB(FormatFloat('#,#0',amt_ready    ),24,' '));
     AddPrintData(pStr+'   중간출금(-):' +LPadB(FormatFloat('#,#0',amt_deposit  ),24,' '));
     AddPrintData(pStr+'   출납입금   :' +LPadB(FormatFloat('#,#0',amt_acct_cash+amt_acct_card  ),24,' '));
     AddPrintData(pStr+'   출납현금(+):' +LPadB(FormatFloat('#,#0',amt_acct_cash  ),24,' '));
     AddPrintData(pStr+'   출납카드   :' +LPadB(FormatFloat('#,#0',amt_acct_card  ),24,' '));
     AddPrintData(pStr+'   출납출금(-):' +LPadB(FormatFloat('#,#0',amt_acct_out ),24,' '));
     AddPrintData(pStr+'   현    금(+):' +LPadB(FormatFloat('#,#0',amt_cash     ),24,' '));
     AddPrintData(pStr+'   수    표(+):' +LPadB(FormatFloat('#,#0',amt_check    ),24,' '));
     AddPrintData(pStr+' 현금봉사료(+):' +LPadB(FormatFloat('#,#0',amt_cashtip  ),24,' '));
     AddPrintData(pStr+'   시재잔액   :' +LPadB(FormatFloat('#,#0',amt_present  ),24,' '));
     AddPrintData(rptOneLine);
     AddPrintData(pStr+'   신용카드   :' +LPadB(FormatFloat('#,#0',cnt_card)+'건 '+FormatFloat('#,#0',amt_card     ),24,' '));
     AddPrintData(pStr+' 카드봉사료   :' +LPadB(FormatFloat('#,#0',amt_cardtip  ),24,' '));
     AddPrintData(pStr+'   렛츠오더   :' +LPadB(FormatFloat('#,#0',amt_letsorder ),24,' '));
     AddPrintData(pStr+'   외    상   :' +LPadB(FormatFloat('#,#0',amt_trust    ),24,' '));
     AddPrintData(pStr+'   상 품 권   :' +LPadB(FormatFloat('#,#0',amt_gift     ),24,' '));
     AddPrintData(pStr+'   포 인 트   :' +LPadB(FormatFloat('#,#0',amt_point ),24,' '));
     AddPrintData(pStr+'   계좌입금   :' +LPadB(FormatFloat('#,#0',amt_bank ),24,' '));
     AddPrintData(pStr+'   기타금액   :' +LPadB(FormatFloat('#,#0',amt_etc  ),24,' '));
     AddPrintData(rptOneLine);
     AddPrintData(pStr+'     부가세   :' +LPadB(FormatFloat('#,#0',amt_tax),24,' '));
     AddPrintData(pStr+'   매출금액   :' +LPadB(FormatFloat('#,#0',amt_sale),24,' '));
     AddPrintData(rptOneLine);

     if dc_member <> 0 then
       AddPrintData(pStr+'     회원할인 :' +LPadB(FormatFloat('#,#0',dc_member    ),24,' '));
     if dc_point <> 0 then
       AddPrintData(pStr+'   포인트할인 :' +LPadB(FormatFloat('#,#0',dc_point     ),24,' '));
     if dc_menu <> 0 then
       AddPrintData(pStr+'     단품할인 :' +LPadB(FormatFloat('#,#0',dc_menu      ),24,' '));
     if dc_code <> 0 then
       AddPrintData(pStr+'     지정할인 :' +LPadB(FormatFloat('#,#0',dc_code     ),24,' '));
     if dc_receipt <> 0 then
       AddPrintData(pStr+'   영수증할인 :' +LPadB(FormatFloat('#,#0',dc_receipt   ),24,' '));
     if dc_spc <> 0 then
       AddPrintData(pStr+'     행사할인 :' +LPadB(FormatFloat('#,#0',dc_spc       ),24,' '));
     if dc_event <> 0 then
       AddPrintData(pStr+'   이벤트할인 :' +LPadB(FormatFloat('#,#0',dc_event     ),24,' '));
     if dc_cut <> 0 then
       AddPrintData(pStr+'     단차할인 :' +LPadB(FormatFloat('#,#0',dc_cut       ),24,' '));
     if dc_vat <> 0 then
       AddPrintData(pStr+'   부가세할인 :' +LPadB(FormatFloat('#,#0',dc_vat       ),24,' '));
     if dc_coupon <> 0 then
       AddPrintData(pStr+'     쿠폰할인 :' +LPadB(FormatFloat('#,#0',dc_coupon   ),24,' '));
     if dc_taxfree <> 0 then
       AddPrintData(pStr+'     TAX FREE :' +LPadB(FormatFloat('#,#0',dc_taxfree   ),24,' '));
     if dc_stamp <> 0 then
       AddPrintData(pStr+'   스템프할인 :' +LPadB(FormatFloat('#,#0',dc_stamp   ),24,' '));
     if dc_uplus <> 0 then
       AddPrintData(pStr+' 유플러스할인 :' +LPadB(FormatFloat('#,#0',dc_uplus   ),24,' '));
     if dc_kakao <> 0 then
       AddPrintData(pStr+' 카카오  할인 :' +LPadB(FormatFloat('#,#0',dc_kakao   ),24,' '));
     if dc_letsorder <> 0 then
       AddPrintData(pStr+'렛츠오더 할인 :' +LPadB(FormatFloat('#,#0',dc_letsorder ),24,' '));
     if dc_tot <> 0 then
     begin
       AddPrintData(rptOneLine);
       AddPrintData(pStr+'   할인금액   :' +LPadB(FormatFloat('#,#0',dc_tot       ),24,' '));
       AddPrintData(rptOneLine);
     end;
     AddPrintData(pStr+'   고 객 수   :' +LPadB(FormatFloat('#,#0',cnt_customer ),24,' '));
     AddPrintData(pStr+'   객 단 가   :' +LPadB(FormatFloat('#,#0',amt_average  ),24,' '));
     AddPrintData(pStr+'   반품금액   :' +LPadB(FormatFloat('#,#0',amt_banpum   ),24,' '));
     AddPrintData(pStr+'   매출취소   :' +LPadB(FormatFloat('#,#0',cnt_void) +'건 '+ FormatFloat('#,#0',amt_void     ),24,' '));
     AddPrintData(pStr+'   현금영수증 :' +LPadB(FormatFloat('#,#0',amt_cashrcp  ),24,' '));
     AddPrintData(pStr+'   서비스금액 :' +LPadB(FormatFloat('#,#0',amt_service  ),24,' '));
     if not Common.Config.IsTakeOut then
     begin
       OpenQuery('select b.CD_FLOOR, '
                +'       Max(b.NM_FLOOR) as NM_FLOOR, '
                +'       COUNT(a.NO_TABLE) as CNT, '
                +'       SUM(a.AMT_ORDER) as AMT_ORDER '
                +'  from SL_ORDER_H a inner join '
                +'       (select a.CD_STORE, '
                +'               a.NO_TABLE, '
                +'               a.CD_FLOOR, '
                +'               b.NM_CODE1 as NM_FLOOR '
                +'          from MS_TABLE a inner join '
                +'               MS_CODE    b on b.CD_STORE = a.CD_STORE and a.CD_FLOOR = b.CD_CODE and b.CD_KIND = ''03'' '
                +'        ) as b on b.CD_STORE = a.CD_STORE and a.NO_TABLE = b.NO_TABLE '
                +' where a.CD_STORE =:P0 '
                +'   and a.DS_ORDER =''T'' '
                +' group by b.CD_FLOOR  '
                +' order by b.CD_FLOOR ',
                [Common.Config.StoreCode]);
       if not Common.Query.Eof then
         AddPrintData(pStr+'   주문테이블 :' +LPadB(order_table,24,' '));

       if not Common.Query.Eof then
       begin
         AddPrintData(Format('       %s %-18.18s  %-20.20s',[pStr,
                                                            Common.Query.Fields[1].AsString,
                                                            FormatFloat('#,0',Common.Query.Fields[3].AsInteger)+'[ '+Common.Query.Fields[2].AsString+' ]']));
         Common.Query.Next;
       end;
       Common.Query.Close;
     end;

     OpenQuery('select COUNT(NO_TABLE) as CNT, '
              +'       SUM(AMT_ORDER) as AMT_ORDER '
              +'  from SL_ORDER_H  '
              +' where CD_STORE =:P0 '
              +'   and DS_ORDER =''D'' ',
              [Common.Config.StoreCode]);

     if not Common.Query.Eof and (Common.Query.Fields[0].AsInteger > 0) then
     begin
       AddPrintData(pStr+Format('   미정산배달 : %d건  %s원',[Common.Query.Fields[0].AsInteger,
                                                              FormatFloat('#,0',Common.Query.Fields[1].AsInteger)]));
       Common.Query.Close;
     end;

     if GetOption(349) = '0' then
     begin
       AddPrintData(rptOneLine);
       AddPrintData(pStr+'         수표 :' +LPadB(FormatFloat('#,#0',_Check       ),24,' '));
       AddPrintData(pStr+'       오만원 :' +LPadB(FormatFloat('#,#0',_50000       ),24,' '));
       AddPrintData(pStr+'         만원 :' +LPadB(FormatFloat('#,#0',_10000       ),24,' '));
       AddPrintData(pStr+'       오천원 :' +LPadB(FormatFloat('#,#0',_5000        ),24,' '));
       AddPrintData(pStr+'         천원 :' +LPadB(FormatFloat('#,#0',_1000        ),24,' '));
       AddPrintData(pStr+'       오백원 :' +LPadB(FormatFloat('#,#0',_500         ),24,' '));
       AddPrintData(pStr+'         백원 :' +LPadB(FormatFloat('#,#0',_100         ),24,' '));
       AddPrintData(pStr+'       오십원 :' +LPadB(FormatFloat('#,#0',_50          ),24,' '));
       AddPrintData(pStr+'         십원 :' +LPadB(FormatFloat('#,#0',_10          ),24,' '));
       AddPrintData(pStr+'     입금시재 :' +LPadB(FormatFloat('#,#0',_Check +
                                                          _50000 +
                                                          _10000 +
                                                          _5000  +
                                                          _1000  +
                                                          _500   +
                                                          _100   +
                                                          _50    +
                                                          _10          ),24,' '));
       AddPrintData(pStr+'   과부족금액 :' +LPadB(FormatFloat('#,#0',amt_lack     ),24,' '));
     end;
     AddPrintData(rptTwoLine);
     AddPrintData(pStr+'   출력일시 : '+FormatMaskText('!0000년90월90일 00:00;0; ',NowDate+NowTime));
     if GetOption(263) = '1' then
     begin
       AddPrintData(rptOneLine);
       AddPrintData('- 메모 -');
       AddPrintData(rptLF);
       AddPrintData(rptLF);
       AddPrintData(rptLF);
       AddPrintData(rptLF);
       AddPrintData(rptLF);
     end;
     AddPrintData(rptLF);
     AddPrintData(rptLF);

  end;

  //실제 프린터에 출력한다
  vPrintData := PrintData;
  for I := 1 to StoI(GetOption(74)) do
  begin
    PrintData := vPrintData;
    PrintPrinter(rptCashier);
  end;

  //메뉴별 매출내역
  if GetOption(133) = '1' then
    MenuSalePrint(CloseNo);
  //신용카드 매출내역(매입사별)
  if GetOption(130) = '1' then
    CardSaleBuyPrint(CloseNo);
  //신용카드 매출내역
  if GetOption(131) = '1' then
    CardSalePrint(CloseNo);
  //분류별 매출내역
  if GetOption(132) = '1' then
    ClassSalePrint(CloseNo);
  //시간대별 매출내역
  if GetOption(134) = '1' then
    TimeSalePrint(CloseNo);
  //할인내역
  if GetOption(135) = '1' then
    DiscountPrint(CloseNo);
  //현금영수증발행내역
  if GetOption(136) = '1' then
    CloseCashrcpPrint(CloseNo);
  //서비스매출내역
  if GetOption(137) = '1' then
    ServicePrint(CloseNo);
  //출납내역
  if GetOption(147) = '1' then
    CashBookPrint(CloseNo);
  //담당자별매출내역
  if GetOption(183) = '1' then
    DamdangPrint(CloseNo);
  //분류/메뉴별 매출내역
  if GetOption(225) = '1' then
    ClassMenuSalePrint(CloseNo);
  //포장매출내역
  if GetOption(339) = '1' then
    PackingSalePrint(CloseNo);
end;

//포스마감시 원장별정산, 시재장출력
procedure TDevice.PosClosePrint(Kind:Integer=0);
var I :Integer;
    vPosNo :String;
    vPrintData :AnsiString;
    vCashCount :Integer;
begin
  PrintData := EmptyStr;

  case Kind of
    0 : vPosNo := Common.Config.PosNo+'%';
    1 : vPosNo := '%';
  end;

  with Common, Common.Magam, Common.Config do
  begin
    AddPrintData(rptSizeBoth);
    if IsBusinessVersion then
    begin
      AddPrintData(rptAlignCenter);
      AddPrintData('!!! 영업 지원용 !!!');
    end;
    AddPrintData(rptAlignCenter);
    case Kind of
      0 : AddPrintData('포스마감정산서');
      1 : AddPrintData('포스마감정산서(총괄)');
    end;
    AddPrintData(rptAlignLeft);
    AddPrintData(rptLF);
    AddPrintData(rptSizeNormal);
    AddPrintData(pStr+'   매 장 명 : '+StoreName);
    if Kind = 0 then
    begin
      AddPrintData(pStr+'   포스번호 : '+PosNo+'-'+UserName);
      AddPrintData(pStr+'   계산원수 : '+IntToStr(cnt_cashier)+' 명');
    end;
    AddPrintData(pStr+'   개점일자 : '+FormatMaskText('!0000년90월90일;0; ',WorkDate)+DayToWeek(WorkDate));
    AddPrintData(rptTwoLine);
    AddPrintData(rptCharBold);
    AddPrintData(pStr+'   [ 매출내역 ]');
    AddPrintData(rptCharNormal);
    AddPrintData(pStr+'   총매출금액 :' +LPadB(FormatFloat('#,#0',amt_sale+dc_tot+amt_service   ),24,' '));
    AddPrintData(pStr+'   할인금액   :' +LPadB(FormatFloat('#,#0',dc_tot                        ),24,' '));
    AddPrintData(pStr+'   서비스금액 :' +LPadB(FormatFloat('#,#0',amt_service                   ),24,' '));
    AddPrintData(pStr+'   매출금액   :' +LPadB(FormatFloat('#,#0',amt_sale),24,' '));
    AddPrintData(pStr+'   봉 사 료   :' +LPadB(FormatFloat('#,#0',amt_cashtip+amt_cardtip),24,' '));
    AddPrintData(pStr+'   부 가 세   :' +LPadB(FormatFloat('#,#0',amt_tax                       ),24,' '));
    AddPrintData(pStr+'   순매출금액 :' +LPadB(FormatFloat('#,#0',amt_sale-amt_tax-amt_cashtip-amt_cardtip),24,' '));
    AddPrintData(rptOneLine);
    OpenQuery('select Sum(case when ((DS_SALE = ''S'') and (AMT_CASH > 0)) or ((DS_SALE = ''B'') and (AMT_CASH < 0)) then 1 else 0 end) '
             +'  from SL_SALE_H '
             +' where CD_STORE=:P0 '
             +'   and YMD_SALE=:P1 '
             +'   and NO_POS like :P2 '
             +'   and DS_SALE <> ''V'' ',
             [Config.StoreCode,
              WorkDate,
              vPosNo]);
    vCashCount := Query.Fields[0].AsInteger;
    Common.Query.Close;
    AddPrintData(pStr+'   현    금   :' +LPadB(FormatFloat('#,#0',vCashCount)+'건 '+FormatFloat('#,#0',amt_cash),24,' '));
    AddPrintData(pStr+'   수    표   :' +LPadB(FormatFloat('#,#0',amt_check    ),24,' '));
    AddPrintData(pStr+'   신용카드   :' +LPadB(FormatFloat('#,#0',cnt_card)+'건 '+FormatFloat('#,#0',amt_card),24,' '));
    Query.Close;

    //다중사업자 사용
    if GetOption(60) = '1' then
    begin
      OpenQuery('select b.NM_TRDPL, '
               +'       a.AMT_CARD '
               +'  from ( '
               +'         select CD_CORNER, '
               +'                Sum(case when DS_TRD =:P3 then AMT_APPROVAL else AMT_APPROVAL*-1 end) as AMT_CARD '
               +'           from SL_CARD '
               +'          where CD_STORE=:P0 '
               +'            and YMD_SALE=:P1 '
               +'            and NO_POS like :P2 '
               +'          group by CD_CORNER '
               +'        ) as a inner join '
               +'        MS_TRD as b on b.CD_STORE =:P0 and b.CD_TRDPL = a.CD_CORNER ',
               [Config.StoreCode,
                WorkDate,
                vPosNo,
                dtApproval]);
      while not Query.Eof do
      begin
        AddPrintData(pStr+RPadB(Query.Fields[0].AsString,20,' ') +LPadB(FormatFloat('#,#0',Query.Fields[1].AsInteger    ),14,' '));
        Query.Next;
      end;
      Query.Close;

    end;
    AddPrintData(pStr+'   렛츠오더   :' +LPadB(FormatFloat('#,#0',amt_letsorder    ),24,' '));
    AddPrintData(pStr+'   외    상   :' +LPadB(FormatFloat('#,#0',amt_trust    ),24,' '));
    AddPrintData(pStr+'   상 품 권   :' +LPadB(FormatFloat('#,#0',amt_gift     ),24,' '));
    AddPrintData(pStr+'   포 인 트   :' +LPadB(FormatFloat('#,#0',amt_point ),24,' '));
    if amt_bank <> 0 then
      AddPrintData(pStr+'   계좌입금   :' +LPadB(FormatFloat('#,#0',amt_bank ),24,' '));
    if amt_etc <> 0 then
      AddPrintData(pStr+'   기타금액   :' +LPadB(FormatFloat('#,#0',amt_etc  ),24,' '));
    AddPrintData(rptOneLine);
    if Kind = 1 then
      AddPrintData(pStr+'   고 객 수   :' +LPadB(FormatFloat('#,#0',cnt_customer ),24,' '));
    AddPrintData(pStr+'   매출취소   :' +LPadB(FormatFloat('#,#0',amt_void     ),24,' '));
    AddPrintData(pStr+'   현금영수증 :' +LPadB(FormatFloat('#,#0',amt_cashrcp  ),24,' '));
    //투밴사용시
    if GetOption(60) = '1' then
    begin
      OpenQuery('select b.NM_TRDPL, '
               +'       a.AMT_CARD '
               +'  from ( '
               +'         select CD_CORNER, '
               +'                Sum(case when DS_TRD =:P3 then AMT_APPROVAL else AMT_APPROVAL*-1 end) as AMT_CARD '
               +'           from SL_CARD '
               +'          where CD_STORE=:P0 '
               +'            and YMD_SALE=:P1 '
               +'            and NO_POS like :P2 '
               +'          group by CD_CORNER '
               +'        ) as a inner join '
               +'        MS_TRD as b on b.CD_STORE =:P0 and b.CD_TRDPL = a.CD_CORNER ',
               [Config.StoreCode,
                WorkDate,
                vPosNo,
                dtApproval]);
      while not Query.Eof do
      begin
        AddPrintData(pStr+RPadB(Query.Fields[0].AsString,20,' ') +LPadB(FormatFloat('#,#0',Query.Fields[1].AsInteger    ),14,' '));
        Query.Next;
      end;
      Query.Close;
    end;
    //배달사용시
    if GetOption(185) = '1' then
    begin
      OpenQuery('select Count(*), '
               +'       Sum(AMT_SALE) as AMT_SALE '
               +'  from SL_SALE_H '
               +' where CD_STORE=:P0 '
               +'   and YMD_SALE=:P1 '
               +'   and NO_POS like :p2 '
               +'   and DS_SALE <> ''V'' '
               +'   and NO_DELIVERY <> ''''',
               [Config.StoreCode,
                WorkDate,
                vPosNo]);

      AddPrintData(pStr+'   배달매출   :' +LPadB(FormatFloat('#,#0',Query.Fields[0].AsInteger)+'건 '+FormatFloat('#,#0',Query.Fields[1].AsInteger     ),24,' '));
      Query.Close;
    end;

    AddPrintData(pStr+'   서비스금액 :' +LPadB(FormatFloat('#,#0',amt_service  ),24,' '));
    //이익률 및 이익금액
    if GetOption(351) = '1' then
    begin
      OpenQuery('select GetProfitRate(Sum(AMT_BUY), Sum(AMT_SALE)) as RATE_PROFIT, '
               +'       Sum(AMT_SALE - AMT_BUY) as AMT_PROFIT '
               +'  from SL_SALE_H '
               +' where CD_STORE=:P0 '
               +'   and YMD_SALE=:P1 '
               +'   and NO_POS like :P2 '
               +'   and DS_SALE <> ''V'' ',
               [Config.StoreCode,
                WorkDate,
                vPosNo]);

      AddPrintData(pStr+'   이익률/이익금액 :' +LPadB(FormatFloat('#.00',Query.Fields[0].AsCurrency)+'% '+FormatFloat('#,#0',Query.Fields[1].AsCurrency),19,' '));
      Query.Close;
    end;
    //총괄매출이 아닐때
    if Kind = 0 then
    begin
      OpenQuery('select Sum(Ifnull(SALE_CNT,0)), '
              +'       Sum(Ifnull(BAN_CNT,0)), '
              +'       Sum(Ifnull(VOID_CNT,0)), '
              +'       Sum(Ifnull(TOT_CNT,0)) '
              +'  from (  '
              +'        select case when DS_SALE =''S'' then 1 end as SALE_CNT, '
              +'               case when DS_SALE =''B'' then 1 end as BAN_CNT, '
              +'               case when DS_SALE =''V'' then 1 end as VOID_CNT, '
              +'               1 as TOT_CNT '
              +'         from SL_SALE_H '
              +'        where CD_STORE=:P0 '
              +'          and YMD_SALE=:P1 '
              +'          and NO_POS  =:P2 '
              +'       ) t ',
              [Config.StoreCode,
               WorkDate,
               Config.PosNo]);

      AddPrintData(pStr+'   [ 영수증 ]   판매' +LPadB(FormatFloat('#,#0',Query.Fields[0].AsInteger)+' 건',19,' '));
      AddPrintData(pStr+'                반품' +LPadB(FormatFloat('#,#0',Query.Fields[1].AsInteger)+' 건',19,' '));
      AddPrintData(pStr+'                취소' +LPadB(FormatFloat('#,#0',Query.Fields[2].AsInteger)+' 건',19,' '));
      AddPrintData(pStr+'                전체' +LPadB(FormatFloat('#,#0',Query.Fields[3].AsInteger)+' 건',19,' '));
      Query.Close;

      OpenQuery('select Count(*) as CNT_TABLE '
               +'  from SL_SALE_H   '
               +' where CD_STORE=:P0 '
               +'   and YMD_SALE=:P1 '
               +'   and DS_SALE <> ''V'' '
               +'   and NO_POS  =:P2  ',
               [Config.StoreCode,
                WorkDate,
                Config.PosNo]);

      AddPrintData(rptOneLine);
      if not Config.IsTakeOut then
      begin
        AddPrintData(pStr+'         사용 테이블' +LPadB(FormatFloat('#,#0',Query.Fields[0].AsInteger),19,' '));
        if Query.Fields[0].AsInteger=0 then
          AddPrintData(pStr+'        테이블평단가' +LPadB('0', 19,' '))
        else
          AddPrintData(pStr+'        테이블평단가' +LPadB(FormatFloat('#,#0',(amt_sale-amt_cashtip) div Query.Fields[0].AsInteger ), 19,' '));
      end;
      AddPrintData(pStr+'              고객수' +LPadB(FormatFloat('#,#0',cnt_customer),19,' '));
      if cnt_customer=0 then
        AddPrintData(pStr+'              객단가' +LPadB('0', 19,' '))
      else
        AddPrintData(pStr+'              객단가' +LPadB(FormatFloat('#,#0',(amt_sale-amt_cashtip) div cnt_customer),19,' '));
      Query.Close;
    end;

    if not Config.IsTakeOut then
    begin
      Magam.order_table := '';
      OpenQuery('select Count(*), '
               +'       Sum(AMT_ORDER) '
               +'  from SL_ORDER_H '
               +' where CD_STORE   =:P0 '
               +'   and DS_ORDER =''T'' ',
               [Common.Config.StoreCode]);
      if Query.Fields[0].AsInteger > 0 then
        Magam.order_table := FormatFloat(',0', Query.Fields[1].AsInteger)+'[ '+Query.Fields[0].AsString + ' ]';
      Query.Close;

      OpenQuery('select b.CD_FLOOR, '
               +'       Max(b.NM_FLOOR) as NM_FLOOR, '
               +'       COUNT(a.NO_TABLE) as CNT, '
               +'       SUM(a.AMT_ORDER) as AMT_ORDER '
               +'  from SL_ORDER_H a inner join '
               +'       (select a.CD_STORE, '
               +'               a.NO_TABLE, '
               +'               a.CD_FLOOR, '
               +'               b.NM_CODE1 as NM_FLOOR '
               +'          from MS_TABLE a inner join '
               +'               MS_CODE    b on b.CD_STORE = a.CD_STORE and a.CD_FLOOR = b.CD_CODE and b.CD_KIND = ''03'' '
               +'        ) as b on b.CD_STORE = a.CD_STORE and a.NO_TABLE = b.NO_TABLE '
               +' where a.CD_STORE =:P0 '
               +'   and a.DS_ORDER = ''T'' '
               +' group by b.CD_FLOOR  '
               +' order by b.CD_FLOOR ',
               [Config.StoreCode]);
      if not Query.Eof then
        AddPrintData(pStr+'   주문테이블 :' +LPadB(order_table,24,' '));

      if not Common.Query.Eof then
      begin
        AddPrintData(Format('       %s %-18.18s  %-21.21s',[pStr,
                                                           Query.Fields[1].AsString,
                                                           FormatFloat('#,0',Query.Fields[3].AsInteger)+'[ '+Query.Fields[2].AsString+' ]']));
        Query.Next;
      end;
      Query.Close;
    end;

    OpenQuery('select COUNT(NO_TABLE) as CNT, '
             +'       SUM(AMT_ORDER) as AMT_ORDER '
             +'  from SL_ORDER_H  '
             +' where CD_STORE =:P0 '
             +'   and DS_ORDER =''D'' ',
             [Config.StoreCode]);

    if not Query.Eof and (Common.Query.Fields[0].AsInteger > 0) then
    begin
      AddPrintData(pStr+Format('   미정산배달 : %d건  %s원',[Query.Fields[0].AsInteger,
                                                             FormatFloat('#,0',Query.Fields[1].AsInteger)]));
      Query.Close;
    end;

    if GetOption(349) = '0' then
    begin
      AddPrintData(rptOneLine);
      AddPrintData(pStr+'   과부족금액 :' +LPadB(FormatFloat('#,#0',amt_lack     ),24,' '));
      AddPrintData(rptTwoLine);
    end;

    if Kind = 0 then
    begin
      OpenQuery('select DT_INSERT, '
               +'       DT_CHANGE '
               +'  from SL_POSCLOSE '
               +' where CD_STORE  =:P0 '
               +'   and YMD_CLOSE =:P1 '
               +'   and NO_POS    =:P2',
               [StoreCode,
                WorkDate,
                PosNo]);
      AddPrintData(pStr+'   개점일시 : '+ FormatDateTime('yyyy년mm월dd일 hh시nn분', Query.FieldByName('dt_insert').Value ));
      AddPrintData(pStr+'   마감일시 : '+ FormatDateTime('yyyy년mm월dd일 hh시nn분', Query.FieldByName('dt_change').Value ));
      Query.Close;

      OpenQuery('select min(COME_TIME) COME_TIME '
               +'  from SL_SALE_H '
               +' where CD_STORE =:P0 '
               +'   and YMD_SALE =:P1 '
               +'   and NO_POS   =:P2',
               [StoreCode,
                WorkDate,
                PosNo]);
      if Query.FieldByName('COME_TIME').Value <> null then
        AddPrintData(pStr+' 첫주문일시 : '+ FormatDateTime('yyyy년mm월dd일 hh시nn분', Query.FieldByName('COME_TIME').Value ));
      Query.Close;
      AddPrintData(pStr+'   출력일시 : '+FormatMaskText('!0000년90월90일 90시90분;0; ',NowDate+NowTime));
    end;
    AddPrintData(rptLF);
  end;

  //실제 프린터에 출력한다
  vPrintData := PrintData;
  For I := 1 to StoI(GetOption(75)) do
  begin
    PrintData := vPrintData;
    PrintPrinter(rptPosClose);
  end;

  if Kind = 1 then Exit;

  //메뉴별 매출내역
  if GetOption(49) = '1' then
    MenuSalePrint;
  //신용카드 매출내역(매입사별)
  if GetOption(78) = '1' then
    CardSaleBuyPrint;
  //신용카드 매출내역
  if GetOption(47) = '1' then
    CardSalePrint;
  //분류별 매출내역
  if GetOption(48) = '1' then
    ClassSalePrint;
  //시간대별 매출내역
  if GetOption(50) = '1' then
    TimeSalePrint;
  //할인내역
  if GetOption(76) = '1' then
    DiscountPrint;
  //현금영수증발행내역
  if GetOption(53) = '1' then
    CloseCashrcpPrint;
  //서비스매출내역
  if GetOption(4) = '1' then
    ServicePrint;
  //출납내역
  if GetOption(146) = '1' then
    CashBookPrint;
  //담당자별매출내역
  if GetOption(184) = '1' then
    DamdangPrint;
  //분류/메뉴별 매출내역
  if GetOption(226) = '1' then
    ClassMenuSalePrint;
  //배달담당자별 매출내역
  if GetOption(227) = '1' then
    DeliveryDamdangPrint;
  //코너별 매출내역
  if GetOption(234) = '1' then
    CornerByPrint;
  //주문취소내역
  if GetOption(32) = '1' then
    OrderCancelPrint;
  //매출취소내역
  if GetOption(245) = '1' then
    SaleCancelPrint;
  //포장매출내역
  if GetOption(340) = '1' then
    PackingSalePrint;
end;

//계산원마감시 신용카드매입사별 출력
procedure TDevice.CardSaleBuyPrint(CloseNo:String);
var liCnt,
    SaleAmt,
    SaleCnt      :Integer;
    lsStr :String;
begin
  PrintData := EmptyStr;
  SaleAmt := 0; SaleCnt := 0; liCnt := 0;

  With Common, Common.Config do
  begin
     OpenQuery('select t.NM_CARD_BUY, '
              +'       Sum(t.CNT_TOTAL) as CNT, '
              +'       Sum(t.AMT_APPROVAL) as AMT_APPROVAL '
              +' from (select  case when Ifnull(b.NM_CODE1,'''') = '''' then case when Ifnull(a.NM_CARD_BUY, '''') = '''' then ''단말기'' else Ifnull(a.NM_CARD_BUY,''단말기'') end else b.NM_CODE1 end AS NM_CARD_BUY, '
              +'               Count(*) as CNT_TOTAL, '
              +'               Sum(case when a.DS_TRD = :P5 then a.AMT_APPROVAL else -a.AMT_APPROVAL end)  as AMT_APPROVAL '
              +'        from   SL_CARD    a left outer join '
              +'               MS_CODE    b on a.CD_STORE   = b.CD_STORE '
              +'                           and a.NO_CHAINPL = b.NM_CODE2 '
              +'                           and b.CD_KIND    = ''06'' inner join '
              +'               SL_SALE_H  c on a.CD_STORE = c.CD_STORE '
              +'                           and a.YMD_SALE = c.YMD_SALE '
              +'                           and a.NO_POS   = c.NO_POS '
              +'                           and a.NO_RCP   = c.NO_RCP '
              +'       where   a.CD_STORE = :P0 '
              +'         and   a.YMD_SALE = :P1 '
              +'         and   a.NO_POS   = :P2 '
              +'         and   c.CD_SAWON   like :P3 '
              +'         and   Cast(c.NO_CLOSE as Char)  like :P4 '
              +'       group by a.CD_STORE, a.NM_CARD_BUY, b.NM_CODE1 '
              +'      ) as t  '
              +'group by NM_CARD_BUY ',
              [Config.StoreCode,
               WorkDate,
               Config.PosNo,
               Ifthen(CloseNo='', '%',Config.UserCode+'%'),
               CloseNo + '%',
               dtApproval]);
     if not Query.Eof then
     begin
        AddPrintData(rptSizeBoth);
        AddPrintData(rptAlignCenter);
        AddPrintData('매입사별승인내역');
        AddPrintData(rptAlignLeft);
        AddPrintData(rptLF);
        AddPrintData(rptSizeNormal);
        AddPrintData('포스번호 : '+ PosNo);
        if CloseNo <> '' then
          AddPrintData('계 산 원 : '+ UserCode+' - '+UserName);
        AddPrintData('매출일자 : '+ FormatMaskText('!0000년90월90일;0; ',WorkDate)+DayToWeek(WorkDate));
        AddPrintData(rptTwoLine);
        AddPrintData(pStr+'      매입사명'+pStr+'           건수       금 액 ');
        AddPrintData(rptTwoLine);
        Query.First;
        while not Query.Eof do
        begin
           lsStr := RPadB(Trim(Query.FieldByName('NM_CARD_BUY').AsString),24+pLen,' ') +
                    LPadB(Trim(Query.FieldByName('Cnt').AsString),5,' ') +
                    LPadB(FormatFloat('#,0', Query.FieldByName('AMT_APPROVAL').AsInteger),13,' ');

           AddPrintData(lsStr);
           SaleCnt := SaleCnt + Query.FieldByName('Cnt').AsInteger;
           SaleAmt := SaleAmt + Query.FieldByName('AMT_APPROVAL').AsInteger;
           Query.Next;
        end;
        Query.Close;
        AddPrintData(rptOneLine);
        OpenQuery('select Sum(t1.CNT_APPROVAL), '
                 +'       Sum(t1.AMT_APPROVAL), '
                 +'       Sum(t1.CNT_CANCEL), '
                 +'       Sum(t1.AMT_CANCEL) '
                 +'  from ( '
                 +'        select case when a.DS_TRD = :P5 then 1              end as CNT_APPROVAL, '
	               +'               case when a.DS_TRD = :P5 then a.AMT_APPROVAL end as AMT_APPROVAL, '
	               +'               case when a.DS_TRD = :P6 then 1              end as CNT_CANCEL, '
	               +'               case when a.DS_TRD = :P6 then a.AMT_APPROVAL end as AMT_CANCEL '
                 +'          from SL_CARD   a inner join '
                 +'               SL_SALE_H b on b.CD_STORE = a.CD_STORE '
                 +'                          and b.YMD_SALE = a.YMD_SALE '
                 +'                          and b.NO_POS   = a.NO_POS '
                 +'                          and b.NO_RCP   = a.NO_RCP '
                 +'         where a.CD_STORE   = :P0 '
                 +'           and a.YMD_SALE   = :P1 '
                 +'           and a.NO_POS     = :P2 '
                 +'           and Cast(b.NO_CLOSE as Char) like :P3 '
                 +'           and b.CD_SAWON   like :P4 '
                 +'        ) t1  ',
                 [Config.StoreCode,
                  WorkDate,
                  Config.PosNo,
                  CloseNo + '%',
                  Ifthen(CloseNo='', '%',Config.UserCode+'%'),
                  dtApproval,
                  dtCancel]);

        AddPrintData('  [ 승인합계 ]  '+LPadB(FormatFloat('#,#0', Query.Fields[0].AsInteger),13+pLen,' ') + LPadB(FormatFloat('#,#0', Query.Fields[1].AsInteger),13,' '));
        AddPrintData('  [ 취소합계 ]  '+LPadB(FormatFloat('#,#0', Query.Fields[2].AsInteger),13+pLen,' ') + LPadB(FormatFloat('#,#0', Query.Fields[3].AsInteger),13,' '));
        AddPrintData('  [  합 계   ]  '+LPadB(FormatFloat('#,#0', Query.Fields[0].AsInteger-Query.Fields[2].AsInteger),13+pLen,' ') + LPadB(FormatFloat('#,#0', Query.Fields[1].AsInteger-Query.Fields[3].AsInteger),13,' '));
        AddPrintData(rptTwoLine);
        Query.Close;
        //실제 프린터에 출력한다
        PrintPrinter(rptCashier);
     end;
  end;
end;

//계산원마감시 신용카드내역 전부출력
procedure TDevice.CardSalePrint(CloseNo:String);
var liCnt,
    SaleAmt,
    CanAmt       :Integer;
    lsPrt, lsStr :String;
begin
  PrintData := EmptyStr;
  SaleAmt := 0; CanAmt := 0; liCnt := 0;

  With Common, Common.Config do
  begin
     if OpenQuery('select a.NO_CARD, '
                 +'       a.DS_TRD, '
                 +'       a.NO_APPROVAL, '
                 +'       a.AMT_APPROVAL-a.AMT_CANCEL as AMT_APPROVAL '
                 +'  from SL_CARD   a inner join '
                 +'       SL_SALE_H b on b.CD_STORE = a.CD_STORE '
                 +'                  and b.YMD_SALE = a.YMD_SALE '
                 +'                  and b.NO_POS   = a.NO_POS '
                 +'                  and b.NO_RCP   = a.NO_RCP '
                 +' where a.CD_STORE   =:P0 '
                 +'   and a.YMD_SALE   =:P1 '
                 +'   and a.NO_POS     =:P2 '
                 +'   and Cast(b.NO_CLOSE as Char) like :P3 '
                 +'   and b.CD_SAWON   like :P4 '
                 +' order by a.NO_RCP, a.SEQ ',
                 [Common.Config.StoreCode,
                  Common.WorkDate,
                  Common.Config.PosNo,
                  CloseNo + '%',
                  Ifthen(CloseNo='', '%',Common.Config.UserCode+'%')]) > 0 then
     begin
        AddPrintData(rptSizeBoth);
        AddPrintData(rptAlignCenter);
        AddPrintData('카드승인내역');
        AddPrintData(rptAlignLeft);
        AddPrintData(rptLF);
        AddPrintData(rptSizeNormal);
        AddPrintData('포스번호 : '+ PosNo);
        if CloseNo <> '' then
          AddPrintData('계 산 원 : '+ UserCode+' - '+UserName);
        AddPrintData('매출일자 : '+ FormatMaskText('!0000년90월90일;0; ',WorkDate)+DayToWeek(WorkDate));
        AddPrintData(rptTwoLine);
        AddPrintData('구분 승인번호     카드번호          금 액 ');
        AddPrintData(rptTwoLine);
        Query.First;
        While not Query.Eof do
        begin
           lsStr := Trim(Common.Query.FieldByName('NO_CARD').AsString);
           if Common.Query.FieldByName('DS_TRD').AsString = dtApproval then
           begin
              lsPrt   := lsPrt   + '승인 ';
              lsPrt   := lsPrt   + RPadB(Query.FieldByName('no_approval').AsString,10,' ');
              lsPrt   := lsPrt   + RPadB(Copy(lsStr,1,Length(lsStr)-2)+'**',18,' ');
              lsPrt   := lsPrt   + LPadB(FormatFloat('#,#0',Query.FieldByName('amt_approval').AsInteger),9,' ');
              SaleAmt := SaleAmt + Query.FieldByName('amt_approval').AsInteger;
           end
           else
           begin
              lsPrt   := lsPrt   + '취소 ';
              lsPrt   := lsPrt   + RPadB(Query.FieldByName('no_approval').AsString,10,' ');
              lsPrt   := lsPrt   + RPadB(Copy(lsStr,1,Length(lsStr)-2)+'**',18,' ');
              lsPrt   := lsPrt   + LPadB('-'+FormatFloat('#,#0',Query.FieldByName('amt_approval').AsInteger),9,' ');
              CanAmt  := CanAmt  + Query.FieldByName('amt_approval').AsInteger;
           end;
           AddPrintData(pStr+lsPrt);
           lsPrt := '';
           Inc(liCnt);
           Query.Next;
        end;
        AddPrintData(rptOneLine);
        AddPrintData(pStr+LPadB(FormatFloat('#,#0',liCnt),5,' ')+' 건  승인:'+LPadB(FormatFloat('#,#0', SaleAmt),10,' ')
                +'  취소:'+LPadB(FormatFloat('#,#0', CanAmt),10,' '));
        AddPrintData(pStr+'          [ 합 계 금 액 ] '+LPadB(FormatFloat('#,#0', SaleAmt-CanAmt),16,' '));
        AddPrintData(rptTwoLine);
        Common.Query.Close;

        //실제 프린터에 출력한다
        PrintPrinter(rptPosClose);
     end;
  end;
end;

procedure TDevice.MenuSalePrint(CloseNo:String);
var SaleAmt,
    TaxAmt,
    SaleCnt,
    SaleCnt1   :Integer;
    lsStr :String;
begin
  PrintData := EmptyStr;
  SaleAmt := 0; SaleCnt := 0; SaleCnt1 := 0; TaxAmt := 0;

  With Common, Common.Config do
  begin
     if OpenQuery('select b.NM_MENU, '
                 +'       sum(a.QTY_SALE) as QTY_SALE, '
                 +'       sum(a.AMT_SALE - a.DC_TOT) as AMT_SALE, '
                 +'       b.DS_MENU_TYPE, '
                 +'       sum(a.AMT_VAT) as AMT_VAT '
                 +'  from SL_SALE_D a left outer join '
                 +'       MS_MENU   b on a.CD_STORE = b.CD_STORE and a.CD_MENU  = b.CD_MENU inner join '
                 +'       SL_SALE_H c on a.CD_STORE = c.CD_STORE and a.YMD_SALE = c.YMD_SALE and a.NO_POS = c.NO_POS and a.NO_RCP = c.NO_RCP '
                 +'  where a.CD_STORE =:P0 '
                 +'    and a.YMD_SALE =:P1 '
                 +'    and a.NO_POS   =:P2 '
                 +'    and c.DS_SALE  <> ''V'' '
                 +'    and c.CD_SAWON like :P3 '
                 +'    and Cast(c.NO_CLOSE as Char) like :P4 '
                 +'  group by b.CD_CLASS, b.NM_MENU, b.DS_MENU_TYPE '
                 +'  order by b.CD_CLASS, b.NM_MENU ',
                 [Common.Config.StoreCode,
                  Common.WorkDate,
                  Common.Config.PosNo,
                  Ifthen(CloseNo='', '%',Common.Config.UserCode+'%'),
                  CloseNo + '%']) > 0 then
     begin
        AddPrintData(rptSizeBoth);
        AddPrintData(rptAlignCenter);
        AddPrintData('메뉴별매출내역');
        AddPrintData(rptAlignLeft);
        AddPrintData(rptLF);
        AddPrintData(rptSizeNormal);
        AddPrintData('포스번호 : '+ PosNo);
        if CloseNo <> '' then
          AddPrintData('계 산 원 : '+ UserCode+' - '+UserName);
        AddPrintData('매출일자 : '+ FormatMaskText('!0000년90월90일;0; ',WorkDate)+DayToWeek(WorkDate));
        AddPrintData(rptTwoLine);
        AddPrintData(pStr+'      메뉴명  '+pStr+'            수량      금 액 ');
        AddPrintData(rptTwoLine);
        Common.Query.First;
        While not Common.Query.Eof do
        begin
           lsStr := RPadB(Trim(Common.Query.Fields[0].AsString),23+pLen,' ');
           lsStr := lsStr   + LPadB(Common.GetQtyReplace(Common.Query.Fields[3].AsString, Common.Query.Fields[1].AsString),7,' ');
           lsStr := lsStr   + LPadB(FormatFloat('#,#0',Common.Query.Fields[2].AsInteger),12,' ');
           SaleAmt := SaleAmt + Common.Query.Fields[2].AsInteger;
           TaxAmt  := TaxAmt  + Common.Query.Fields[4].AsInteger;
           if Common.Query.Fields[3].AsString = 'W' then
             SaleCnt1 := SaleCnt1 + Common.Query.Fields[1].AsInteger
           else
             SaleCnt := SaleCnt + Common.Query.Fields[1].AsInteger;
           AddPrintData(lsStr);
           Common.Query.Next;
        end;
        AddPrintData(rptOneLine);
        AddPrintData(rptCharBold);
        if SaleCnt1 = 0 then
        begin
          AddPrintData(pStr+'     [ 부가세 ]    '+pStr+LPadB(FormatFloat('#,#0', TaxAmt),23,' '));
          AddPrintData(pStr+'     [ 합  계 ]    '+pStr+LPadB(FormatFloat('#,#0', SaleCnt),11,' ')
                                            +LPadB(FormatFloat('#,#0', SaleAmt),12,' ') );
        end
        else
        begin
          AddPrintData(pStr+'[ 부가세 ]'+pStr+LPadB(FormatFloat('#,#0', TaxAmt),22,' '));
          AddPrintData(pStr+'[ 합  계 ]'+pStr+LPadB(Common.GetQtyReplace('W',IntToStr(SaleCnt1)) +'/'
                             +FormatFloat('#,#0', SaleCnt),20,' ')
                             +LPadB(FormatFloat('#,#0', SaleAmt),12,' ') );
        end;

        AddPrintData(rptSizeNormal);
        AddPrintData(rptTwoLine);

        //실제 프린터에 출력한다
        PrintPrinter(rptPosClose);
     end;
  end;

end;

procedure TDevice.ClassSalePrint(CloseNo:String);
var SaleAmt,
    TaxAmt,
    SaleCnt,
    SaleCnt1   :Integer;
    lsStr :String;
begin
  PrintData := EmptyStr;
  SaleAmt := 0; SaleCnt := 0; SaleCnt1 := 0;  TaxAmt := 0;

  With Common, Common.Config do
  begin
     if OpenQuery('select t2.NM_CLASS, '
                 +'       sum(t1.QTY_SALE), '
                 +'       sum(t1.AMT_SALE), '
                 +'       t2.DS_MENU, '
                 +'       sum(t1.AMT_VAT) '
                 +'  from ( '
                 +'         select a.CD_STORE, '
                 +'                a.CD_MENU, '
                 +'                a.QTY_SALE, '
                 +'                a.AMT_SALE-a.DC_TOT as AMT_SALE, '
                 +'                a.DS_SALE, '
                 +'                a.YMD_SALE, '
                 +'                a.NO_POS,  '
                 +'                a.AMT_VAT '
                 +'           from SL_SALE_D a inner join '
                 +'                SL_SALE_H b on a.CD_STORE = b.CD_STORE '
                 +'                           and a.YMD_SALE = b.YMD_SALE '
                 +'                           and a.NO_POS   = b.NO_POS '
                 +'                           and a.NO_RCP   = b.NO_RCP '
                 +'          where b.DS_SALE  <> ''V'' '
                 +'            and b.CD_SAWON like :P3 '
                 +'            and Cast(b.NO_CLOSE as Char) like :P4 '
                 +'       ) t1, '
                 +'        (select a.CD_STORE, '
                 +'                a.CD_MENU, '
                 +'                Left(a.CD_CLASS,2) as CD_CLASS, '
                 +'                b.NM_CLASS, '
                 +'                case DS_MENU_TYPE when ''W'' then ''W'' else ''E'' end DS_MENU '
                 +'           from MS_MENU       a left outer join '
                 +'                MS_MENU_CLASS b on a.CD_STORE         = b.CD_STORE '
                 +'                               and Left(a.CD_CLASS,2) = Left(b.CD_CLASS,2) '
                 +'                               and length(b.CD_CLASS)    = 2 '
                 +'        ) t2 '
                 +' where t1.CD_STORE = t2.CD_STORE '
                 +'   and t1.CD_MENU  = t2.CD_MENU '
                 +'   and t1.CD_STORE = :P0 '
                 +'   and t1.YMD_SALE = :P1 '
                 +'   and t1.NO_POS   = :P2 '
                 +' group by t2.CD_CLASS, t2.NM_CLASS,  t2.DS_MENU '
                 +' order by t2.NM_CLASS ',
                 [Common.Config.StoreCode,
                  Common.WorkDate,
                  Common.Config.PosNo,
                  Ifthen(CloseNo='', '%',Common.Config.UserCode+'%'),
                  CloseNo + '%']) > 0 then
     begin
        AddPrintData(rptSizeBoth);
        AddPrintData(rptAlignCenter);
        AddPrintData('분류별매출내역');
        AddPrintData(rptAlignLeft);
        AddPrintData(rptLF);
        AddPrintData(rptSizeNormal);
        AddPrintData('포스번호 : '+ PosNo);
        if CloseNo <> '' then
          AddPrintData('계 산 원 : '+ UserCode+' - '+UserName);
        AddPrintData('매출일자 : '+ FormatMaskText('!0000년90월90일;0; ',WorkDate)+DayToWeek(WorkDate));
        AddPrintData(rptTwoLine);
        AddPrintData(pStr+'      분 류 명            수량      금 액 ');
        AddPrintData(rptTwoLine);
        Common.Query.First;
        While not Common.Query.Eof do
        begin
           lsStr := RPadB(Trim(Common.Query.Fields[0].AsString),23,' ');
           lsStr := lsStr   + LPadB(Common.GetQtyReplace(Common.Query.Fields[3].AsString, Common.Query.Fields[1].AsString),7,' ');
           lsStr := lsStr   + LPadB(FormatFloat('#,#0', Common.Query.Fields[2].AsInteger),12,' ');
           SaleAmt := SaleAmt + Common.Query.Fields[2].AsInteger;
           TaxAmt  := TaxAmt  + Common.Query.Fields[4].AsInteger;

           if Common.Query.Fields[3].AsString = 'W' then
             SaleCnt1 := SaleCnt1 + Common.Query.Fields[1].AsInteger
           else
             SaleCnt := SaleCnt + Common.Query.Fields[1].AsInteger;
           AddPrintData(pStr+lsStr);
           Common.Query.Next;
        end;
        AddPrintData(rptOneLine);
        AddPrintData(rptCharBold);
        if SaleCnt1 = 0 then
        begin
          AddPrintData(pStr+'     [ 부가세 ]    '+pStr+LPadB(FormatFloat('#,#0', TaxAmt),23,' '));
          AddPrintData(pStr+'     [ 합  계 ]    '+LPadB(FormatFloat('#,#0', SaleCnt),11,' ')
                                       +LPadB(FormatFloat('#,#0', SaleAmt),12,' ') );
        end
        else
        begin
          AddPrintData(pStr+'[ 부가세 ]'+pStr+LPadB(FormatFloat('#,#0', TaxAmt),22,' '));
          AddPrintData(pStr+'[ 합  계 ]'+LPadB(Common.GetQtyReplace('W',IntToStr(SaleCnt1)) +'/'
                             +FormatFloat('#,#0', SaleCnt),20,' ')
                             +LPadB(FormatFloat('#,#0', SaleAmt),12,' ') );
        end;

        AddPrintData(rptSizeNormal);
        AddPrintData(rptTwoLine);

        //실제 프린터에 출력한다
        PrintPrinter(rptPosClose);
     end;
  end;
end;

procedure TDevice.ClassMenuSalePrint(CloseNo:String);
var SaleAmt,
    TaxAmt,
    SaleCnt,
    SaleCnt1   :Integer;
    lsStr :String;
begin
  PrintData := EmptyStr;
  SaleAmt := 0; SaleCnt := 0; SaleCnt1 := 0;  TaxAmt := 0;

  With Common, Common.Config do
  begin
     if OpenQuery('select ''0'' as SEQ   , '
                 +'       t2.CD_CLASS, '
                 +'       t2.NM_CLASS, '
                 +'       Sum(t1.QTY_SALE), '
                 +'       Sum(t1.AMT_SALE), '
                 +'       t2.DS_MENU, '
                 +'       sum(t1.AMT_VAT) '
                 +'  from (select a.CD_MENU, '
                 +'               a.QTY_SALE, '
                 +'               a.AMT_SALE-a.DC_TOT as AMT_SALE, '
                 +'               a.AMT_VAT, '
                 +'               a.NO_POS '
                 +'          from SL_SALE_D a inner join '
                 +'               SL_SALE_H b on a.CD_STORE = b.CD_STORE '
                 +'                          and a.YMD_SALE = b.YMD_SALE '
                 +'                          and a.NO_POS   = b.NO_POS '
                 +'                          and a.NO_RCP   = b.NO_RCP '
                 +'         where a.CD_STORE =:P0 '
                 +'           and a.YMD_SALE =:P1 '
                 +'           and a.NO_POS   =:P2 '
                 +'           and b.DS_SALE  <> ''V'' '
                 +'           and b.CD_SAWON like :P3 '
                 +'           and Cast(b.NO_CLOSE as Char) like :P4 '
                 +'       ) t1, '
                 +'       (select a.CD_MENU, '
                 +'               Left(a.CD_CLASS,2) as CD_CLASS, '
                 +'               b.NM_CLASS, '
                 +'               case DS_MENU_TYPE when ''W'' then ''W'' else ''N'' end DS_MENU '
                 +'          from MS_MENU       a left outer join  '
                 +'               MS_MENU_CLASS b on b.CD_STORE         = a.CD_STORE '
                 +'                              and Left(a.CD_CLASS,2) = Left(b.CD_CLASS,2) '
                 +'                              and Length(b.CD_CLASS)    = 2 '
                 +'         where a.CD_STORE =:P0 '
                 +'      ) t2 '
                 +' where t1.CD_MENU  = t2.CD_MENU '
                 +' group by  t2.CD_CLASS, t2.NM_CLASS, t2.DS_MENU '
                 +'union all '
                 +'select ''1'' as seq, '
                 +'       Left(c.cd_class,2) as CD_CLASS, '
                 +'       c.NM_MENU, '
                 +'       Sum(a.QTY_SALE), '
                 +'       Sum(a.AMT_SALE - a.DC_TOT), '
                 +'       case c.DS_MENU_TYPE when ''W'' then ''W'' else ''N'' end DS_MENU, '
                 +'       Sum(a.AMT_VAT) '
                 +'  from SL_SALE_D a inner join '
                 +'       SL_SALE_H b on b.CD_STORE = a.CD_STORE '
                 +'                  and b.YMD_SALE = a.YMD_SALE '
                 +'                  and b.NO_POS   = a.NO_POS '
                 +'                  and b.NO_RCP   = a.NO_RCP '
                 +'                  and b.DS_SALE <> ''V'' left outer join '
                 +'       MS_MENU   c on c.CD_STORE = a.CD_STORE '
                 +'                  and c.CD_MENU  = a.CD_MENU '
                 +' where a.CD_STORE = :P0 '
                 +'   and a.YMD_SALE = :P1 '
                 +'   and a.NO_POS   = :P2 '
                 +'   and b.CD_SAWON like :P3 '
                 +'   and Cast(b.NO_CLOSE as Char) like :P4 '
                 +' group by c.CD_CLASS, c.NM_MENU, c.DS_MENU_TYPE '
                 +' order by CD_CLASS, DS_MENU, SEQ ',
                 [Common.Config.StoreCode,
                  Common.WorkDate,
                  Common.Config.PosNo,
                  Ifthen(CloseNo='', '%',Common.Config.UserCode+'%'),
                  CloseNo + '%']) > 0 then
     begin
        AddPrintData(rptSizeBoth);
        AddPrintData(rptAlignCenter);
        AddPrintData('분류별 메뉴매출내역');
        AddPrintData(rptAlignLeft);
        AddPrintData(rptLF);
        AddPrintData(rptSizeNormal);
        AddPrintData('포스번호 : '+ PosNo);
        if CloseNo <> '' then
          AddPrintData('계 산 원 : '+ UserCode+' - '+UserName);
        AddPrintData('매출일자 : '+ FormatMaskText('!0000년90월90일;0; ',WorkDate)+DayToWeek(WorkDate));
        AddPrintData(rptTwoLine);
        AddPrintData(pStr+'      분 류 명            수량      금 액 ');
        AddPrintData(rptTwoLine);
        Common.Query.First;
        While not Common.Query.Eof do
        begin
           //분류이면
           if Common.Query.Fields[0].AsString = '0' then
           begin
             AddPrintData(rptCharBold);
             lsStr := RPadB(Trim(Common.Query.Fields[2].AsString),24,' ');
           end
           else
           begin
             AddPrintData(rptCharNormal);
             lsStr := ' -'+RPadB(SCopy(Trim(Common.Query.Fields[2].AsString),1,22),22,' ');
           end;
           lsStr := lsStr   + LPadB(Common.GetQtyReplace(Common.Query.Fields[5].AsString, Common.Query.Fields[3].AsString),7,' ');
           lsStr := lsStr   + LPadB(FormatFloat('#,#0', Common.Query.Fields[4].AsInteger),11,' ');
           if Common.Query.Fields[0].AsString = '0' then
           begin
             SaleAmt := SaleAmt + Common.Query.Fields[4].AsInteger;
             TaxAmt  := TaxAmt  + Common.Query.Fields[6].AsInteger;
           end;
           AddPrintData(pStr+lsStr);
           Common.Query.Next;
        end;
        AddPrintData(rptOneLine);
        AddPrintData(rptCharBold);
        AddPrintData(pStr+'     [ 부가세 ]    '+LPadB(FormatFloat('#,#0', TaxAmt),23,' ') );
        AddPrintData(pStr+'     [ 합  계 ]    '+LPadB(FormatFloat('#,#0', SaleAmt),23,' ') );
        AddPrintData(rptSizeNormal);
        AddPrintData(rptTwoLine);

        //실제 프린터에 출력한다
        PrintPrinter(rptPosClose);
     end;
  end;
end;

procedure TDevice.TimeSalePrint(CloseNo:String);
var SaleAmt,
    SaleCnt  :Integer;
    lsStr    :String;
begin
  PrintData := EmptyStr;
  SaleAmt := 0; SaleCnt := 0;

  With Common, Common.Config do
  begin
     if OpenQuery('select ConCat(SUBSTRING(a.CODENAME,1,2),'':00 ~ '',SUBSTRING(a.CODENAME,9,2),'':00'')	as CODENAME, '
                 +'       SUM(Ifnull(t.AMT_SALE,0))    as AMT_TOT, '
                 +'       SUM(Ifnull(t.CNT_PERSON, 0)) as CNT_TOT '
                 +'  from '
                 +'      (select CD_CODE, '
                 +'              NM_CODE1 AS CODENAME '
                 +'         from MS_CODE '
                 +'        where CD_STORE = :P0 '
                 +'          and CD_KIND  = ''15'' '
                 +'          and DS_STATUS=''0'' '
                 +'      ) a left outer join '
                 +'      (select SUM(CNT_PERSON)   AS CNT_PERSON, '
                 +'              GetBetweenTime(CD_STORE, DT_SALE) AS time24, '
                 +'              Ifnull(SUM(AMT_SALE),0)AS AMT_SALE '
                 +'         from SL_SALE_H '
                 +'        where CD_STORE     =:P0 '
                 +'          and YMD_SALE     =:P1 '
                 +'          and DS_SALE  <> ''V'' '
                 +'          and NO_POS       =:P2 '
                 +'          and CD_SAWON like :P3 '
                 +'          and cast(NO_CLOSE as char) like :P4 '
                 +'        group by CD_STORE, DT_SALE '
                 +'      ) t on a.CD_CODE = t.TIME24 '
                 +'  group by a.CD_CODE, A.CODENAME '
                 +'  order by a.CD_CODE ',
                 [Common.Config.StoreCode,
                  Common.WorkDate,
                  Common.Config.PosNo,
                  Ifthen(CloseNo='', '%',Common.Config.UserCode+'%'),
                  CloseNo + '%']) > 0 then
     begin
        AddPrintData(rptSizeBoth);
        AddPrintData(rptAlignCenter);
        AddPrintData('시간대별 매출내역');
        AddPrintData(rptAlignLeft);
        AddPrintData(rptLF);
        AddPrintData(rptSizeNormal);
        AddPrintData('포스번호 : '+ PosNo);
        if CloseNo <> '' then
          AddPrintData('계 산 원 : '+ UserCode+' - '+UserName);
        AddPrintData('매출일자 : '+ FormatMaskText('!0000년90월90일;0; ',WorkDate)+DayToWeek(WorkDate));
        AddPrintData(rptTwoLine);
        AddPrintData(pStr+'      시 간 대          고객수      금 액 ');
        AddPrintData(rptTwoLine);
        Common.Query.First;
        While not Common.Query.Eof do
        begin
           lsStr := '    '+RPadB(Trim(Common.Query.Fields[0].AsString),19,' ');
           lsStr := lsStr   + LPadB(Common.Query.Fields[2].AsString,7,' ');
           lsStr := lsStr   + LPadB(FormatFloat('#,#0',Common.Query.Fields[1].AsInteger),12,' ');
           SaleAmt := SaleAmt + Common.Query.Fields[1].AsInteger;
           SaleCnt := SaleCnt + Common.Query.Fields[2].AsInteger;
           AddPrintData(pStr+lsStr);
           Common.Query.Next;
        end;
        AddPrintData(rptOneLine);
        AddPrintData(rptCharBold);
        AddPrintData(pStr+'     [ 합 계 ]     '+LPadB(FormatFloat('#,#0', SaleCnt),11,' ')
                                     +LPadB(FormatFloat('#,#0', SaleAmt),12,' ') );
        AddPrintData(rptSizeNormal);
        AddPrintData(rptOneLine);

        //실제 프린터에 출력한다
        PrintPrinter(rptPosClose);
     end;
  end;

end;

procedure TDevice.DiscountPrint(CloseNo:String);
var lsStr    :String;
begin
  PrintData := EmptyStr;
  with Common.Config, Common do
  begin
    OpenQuery('select StoD(t1.YMD_SALE), t1.NAME, t1.CNT, AMOUNT '
             +'  from '
             +'    (select YMD_SALE, b.NM_CODE1 as NAME, sum(case when a.DC_CODE <> 0 then 1 else 0 end)  as CNT, sum(a.DC_CODE) as AMOUNT '
             +'    	  from SL_SALE_H a inner join '
             +'            MS_CODE   b on b.CD_STORE = a.CD_STORE and b.CD_CODE = a.CD_CODE and b.CD_KIND = ''07'' '
             +'    	 where a.DS_SALE  <> ''V'' '
             +'    	   and a.CD_STORE = :P0 '
             +'    	   and a.YMD_SALE = :P1 '
             +'    	   and a.NO_POS   like ConCat(:P2,''%'') '
             +'    	   and a.CD_SAWON like ConCat(:P3,''%'') '
             +'    	   and a.NO_CLOSE like ConCat(:P4,''%'') '
             +'    	group by a.YMD_SALE, b.NM_CODE1 '
             +'    	union all '
             +'    	select YMD_SALE, ''영수증할인'' as NAME, sum(case when DC_RECEIPT <> 0 then 1 else 0 end) as CNT, sum(DC_RECEIPT) as AMOUNT '
             +'    	  from SL_SALE_H '
             +'    	 where CD_STORE = :P0 '
             +'    	   and YMD_SALE = :P1  '
             +'    	   and DS_SALE  <> ''V'' '
             +'    	   and NO_POS   like ConCat(:P2,''%'') '
             +'    	   and CD_SAWON like ConCat(:P3,''%'') '
             +'    	   and NO_CLOSE like ConCat(:P4,''%'') '
             +'    	 group by YMD_SALE '
             +'    	union all '
             +'    	select YMD_SALE, ''메뉴할인'' as name, sum(case when DC_MENU <> 0 then 1 else 0 end)  as cnt,  sum(DC_MENU) as amount '
             +'    	  from SL_SALE_H '
             +'    	 where CD_STORE = :P0 '
             +'    	   and YMD_SALE = :P1  '
             +'    	   and DS_SALE  <> ''V'' '
             +'    	   and NO_POS   like ConCat(:P2,''%'') '
             +'    	   and CD_SAWON like ConCat(:P3,''%'') '
             +'    	   and NO_CLOSE like ConCat(:P4,''%'') '
             +'    	 group by YMD_SALE '
             +'    	union all '
             +'    	select YMD_SALE, ''행사할인'' as name, sum(case when DC_SPC <> 0 then 1 else 0 end)  as cnt, sum(DC_SPC) as amount '
             +'    	  from SL_SALE_H '
             +'    	 where CD_STORE = :P0 '
             +'    	   and YMD_SALE = :P1  '
             +'    	   and DS_SALE  <> ''V'' '
             +'    	   and NO_POS   like ConCat(:P2,''%'')'
             +'    	   and CD_SAWON like ConCat(:P3,''%'')'
             +'    	   and NO_CLOSE like ConCat(:P4,''%'')'
             +'    	 group by YMD_SALE '
             +'    	union all '
             +'    	select YMD_SALE, ''회원할인'' as name,  sum(case when DC_MEMBER <> 0 then 1 else 0 end)  as cnt, sum(DC_MEMBER) as amount '
             +'    	  from SL_SALE_H '
             +'    	 where CD_STORE = :P0 '
             +'    	   and YMD_SALE = :P1  '
             +'    	   and DS_SALE  <> ''V'' '
             +'    	   and NO_POS   like ConCat(:P2,''%'') '
             +'    	   and CD_SAWON like ConCat(:P3,''%'') '
             +'    	   and NO_CLOSE like ConCat(:P4,''%'') '
             +'    	 group by YMD_SALE '
             +'    	union all '
             +'    	select YMD_SALE, ''포인트할인'' as name,  sum(case when DC_POINT <> 0 then 1 else 0 end)  as cnt, sum(DC_POINT) as amount '
             +'    	  from SL_SALE_H '
             +'    	 where CD_STORE = :P0 '
             +'    	   and YMD_SALE = :P1  '
             +'    	   and DS_SALE  <> ''V'' '
             +'    	   and NO_POS   like ConCat(:P2,''%'') '
             +'    	   and CD_SAWON like ConCat(:P3,''%'') '
             +'    	   and NO_CLOSE like ConCat(:P4,''%'') '
             +'    	 group by YMD_SALE '
             +'    	union all '
             +'    	select YMD_SALE, ''이벤트할인'' as name,  sum(case when DC_EVENT <> 0 then 1 else 0 end)  as cnt, sum(DC_EVENT) as amount '
             +'    	  from SL_SALE_H '
             +'    	 where CD_STORE = :P0 '
             +'    	   and YMD_SALE = :P1  '
             +'    	   and DS_SALE  <> ''V'' '
             +'    	   and NO_POS   like ConCat(:P2,''%'') '
             +'    	   and CD_SAWON like ConCat(:P3,''%'') '
             +'    	   and NO_CLOSE like ConCat(:P4,''%'') '
             +'    	 group by YMD_SALE '
             +'    	union all '
             +'    	select YMD_SALE, ''쿠폰할인'' as NAME,  sum(case when DC_COUPON <> 0 then 1 else 0 end)  as CNT, sum(DC_COUPON) as amount '
             +'    	  from SL_SALE_H '
             +'    	 where CD_STORE = :P0 '
             +'    	   and YMD_SALE = :P1  '
             +'    	   and DS_SALE  <> ''V'' '
             +'    	   and NO_POS   like ConCat(:P2,''%'') '
             +'    	   and CD_SAWON like ConCat(:P3,''%'') '
             +'    	   and NO_CLOSE like ConCat(:P4,''%'') '
             +'    	 group by YMD_SALE '
             +'    	union all '
             +'    	select YMD_SALE, ''부가세할인'' as name,  sum(case when DC_VAT <> 0 then 1 else 0 end)  as cnt, sum(DC_VAT) as amount '
             +'    	  from SL_SALE_H '
             +'    	 where CD_STORE = :P0 '
             +'    	   and YMD_SALE = :P1  '
             +'    	   and DS_SALE  <> ''V'' '
             +'    	   and NO_POS   like ConCat(:P2,''%'') '
             +'    	   and CD_SAWON like ConCat(:P3,''%'') '
             +'    	   and NO_CLOSE like ConCat(:P4,''%'') '
             +'    	 group by YMD_SALE '
             +'    	union all '
             +'    	select YMD_SALE, ''단차할인'' as name,  sum(case when dc_cut <> 0 then 1 else 0 end)  as cnt, sum(DC_CUT) as amount '
             +'    	  from SL_SALE_H  '
             +'    	 where CD_STORE = :P0 '
             +'    	   and YMD_SALE = :P1  '
             +'    	   and DS_SALE  <> ''V'' '
             +'    	   and NO_POS   like ConCat(:P2 +''%'') '
             +'    	   and CD_SAWON like ConCat(:P3 +''%'') '
             +'    	   and NO_CLOSE like ConCat(:P4 +''%'') '
             +'    	 group by YMD_SALE '
             +'      union all '
             +'      select YMD_SALE, ''Tax Refund'' as name,  sum(case when DC_TAXFREE <> 0 then 1 else 0 end)  as cnt, sum(DC_TAXFREE) as amount '
             +'        from SL_SALE_H '
             +'       where CD_STORE = :P0 '
             +'         and YMD_SALE = :P1  '
             +'         and NO_POS   like ConCat(:P2,''%'') '
             +'         and CD_SAWON like ConCat(:P3,''%'') '
             +'         and NO_CLOSE like ConCat(:P4,''%'') '
             +'         and DS_SALE  <> ''V'' '
             +'       group by YMD_SALE '
             +'      union all '
             +'      select YMD_SALE, ''스템프할인'' as name,  sum(case when DC_STAMP <> 0 then 1 else 0 end)  as cnt, sum(DC_STAMP) as amount '
             +'        from SL_SALE_H '
             +'       where CD_STORE = :P0 '
             +'         and YMD_SALE = :P1  '
             +'         and NO_POS   like ConCat(:P2,''%'') '
             +'         and CD_SAWON like ConCat(:P3,''%'') '
             +'         and NO_CLOSE like ConCat(:P4,''%'') '
             +'         and DS_SALE  <> ''V'' '
             +'       group by YMD_SALE '
             +'      union all '
             +'      select YMD_SALE, ''유플러스할인'' as name,  sum(case when DC_UPLUS <> 0 then 1 else 0 end)  as cnt, sum(DC_UPLUS) as amount '
             +'        from SL_SALE_H '
             +'       where CD_STORE = :P0 '
             +'         and YMD_SALE = :P1  '
             +'         and NO_POS   like ConCat(:P2,''%'') '
             +'         and CD_SAWON like ConCat(:P3,''%'') '
             +'         and NO_CLOSE like ConCat(:P4,''%'') '
             +'         and DS_SALE  <> ''V'' '
             +'       group by YMD_SALE '
             +'      union all '
             +'      select YMD_SALE, ''카카오할인'' as name,  sum(case when DC_KAKAO <> 0 then 1 else 0 end)  as cnt, sum(DC_KAKAO) as amount '
             +'        from SL_SALE_H '
             +'       where CD_STORE = :P0 '
             +'         and YMD_SALE = :P1  '
             +'         and NO_POS   like ConCat(:P2,''%'') '
             +'         and CD_SAWON like ConCat(:P3,''%'') '
             +'         and NO_CLOSE like ConCat(:P4,''%'') '
             +'         and DS_SALE  <> ''V'' '
             +'       group by YMD_SALE '
             +'      union all '
             +'      select YMD_SALE, ''렛츠오더할인'' as name,  sum(case when DC_LETSORDER <> 0 then 1 else 0 end)  as cnt, sum(DC_LETSORDER) as amount '
             +'        from SL_SALE_H '
             +'       where CD_STORE = :P0 '
             +'         and YMD_SALE = :P1  '
             +'         and NO_POS   like ConCat(:P2,''%'') '
             +'         and CD_SAWON like ConCat(:P3,''%'') '
             +'         and NO_CLOSE like ConCat(:P4,''%'') '
             +'         and DS_SALE  <> ''V'' '
             +'       group by YMD_SALE '
             +'    	) t1'
             +'	where t1.amount > 0 ',
             [StoreCode,
              Common.WorkDate,
              PosNo,
              UserCode,
              CloseNo]);

    //출력할 내용이 없을때
    if Common.Query.Eof then
    begin
      Common.Query.Close;
      PrintData := EmptyStr;
      Exit;
    end;

    AddPrintData(rptSizeBoth);
    AddPrintData(rptAlignCenter);
    AddPrintData('할인내역');
    AddPrintData(rptAlignLeft);
    AddPrintData(rptLF);
    AddPrintData(rptSizeNormal);
    AddPrintData('포스번호 : '+ PosNo);
    AddPrintData('매출일자 : '+ FormatMaskText('!0000년90월90일;0; ',Common.WorkDate)+DayToWeek(Common.WorkDate));
    AddPrintData(rptTwoLine);
    AddPrintData(pStr+'       할 인 명 '+pStr+'         건수       금 액 ');
    AddPrintData(rptTwoLine);

    while not Common.Query.Eof do
    begin
      lsStr := RPadB(Common.Query.Fields[1].Value,24+pLen,' ')+LPadB(Common.Query.Fields[2].AsString,5,' ')+LPadB(FormatFloat('#,0',Common.Query.Fields[3].AsInteger),13,' ');
      AddPrintData(lsStr);
      Common.Query.Next;
    end;

    AddPrintData(rptOneLine);
    AddPrintData(rptCharBold);
    AddPrintData(pStr+'     [ 합 계 ]     '+LPadB(FormatFloat('#,#0', Common.Magam.dc_tot),23,' '));
    AddPrintData(rptSizeNormal);
    AddPrintData(rptTwoLine);

    //실제 프린터에 출력한다
    PrintPrinter(rptPosClose);
    Common.Query.Close;
  end;
end;

procedure TDevice.ServicePrint(CloseNo:String);                           //서비스내역
var lsStr :String;
    SaleAmt,
    SaleCnt,
    SaleCnt1  :Integer;
    TempAmt   :Double;
begin
  PrintData := EmptyStr;

  with Common, Common.Config do
  begin
     if OpenQuery('select c.NM_MENU, '
                 +'       SUM(a.QTY_SALE), '
                 +'       SUM(a.PR_SERVICE * a.QTY_SALE), '
                 +'       SUM(a.PR_SERVICE), '
                 +'       c.DS_MENU_TYPE '
                 +'  from SL_SALE_D a inner join '
                 +'       SL_SALE_H b on a.CD_STORE	= b.CD_STORE and a.YMD_SALE	= b.YMD_SALE and a.NO_POS = b.NO_POS and a.NO_RCP	= b.NO_RCP inner join '
                 +'       MS_MENU   c on a.CD_STORE	= c.CD_STORE and a.CD_MENU  = c.CD_MENU '
                 +' where a.CD_STORE	=:P0 '
                 +'   and a.YMD_SALE  =:P1 '
                 +'   and a.NO_POS    =:P2 '
                 +'   and b.DS_SALE	  <> ''V'' '
                 +'   and a.DS_SALE_TYPE	= ''D'' '
                 +'   and b.CD_SAWON like :P3 '
                 +'   and Cast(b.NO_CLOSE as Char) like :P4 '
                 +' group BY c.NM_MENU, a.CD_MENU, a.PR_SERVICE, c.DS_MENU_TYPE '
                 +' order BY a.CD_MENU ',
                 [Common.Config.StoreCode,
                  Common.WorkDate,
                  Common.Config.PosNo,
                  Ifthen(CloseNo='', '%',Common.Config.UserCode+'%'),
                  CloseNo + '%']) > 0 then
     begin
        AddPrintData(rptSizeBoth);
        AddPrintData(rptAlignCenter);
        AddPrintData('서비스 매출내역');
        AddPrintData(rptAlignLeft);
        AddPrintData(rptLF);
        AddPrintData(rptSizeNormal);
        AddPrintData('포스번호 : '+ PosNo);
        if CloseNo <> '' then
          AddPrintData('계 산 원 : '+ UserCode+' - '+UserName);
        AddPrintData('매출일자 : '+ FormatMaskText('!0000년90월90일;0; ',WorkDate)+DayToWeek(WorkDate));
        AddPrintData(rptTwoLine);
        AddPrintData(pStr+'       메뉴명 '+pStr+'            수량      금 액 ');
        AddPrintData(rptTwoLine);
        Common.Query.First;
        While not Common.Query.Eof do
        begin
           lsStr := RPadB(Trim(Common.Query.Fields[0].AsString),23+pLen,' ');
           lsStr := lsStr   + LPadB(Common.GetQtyReplace(Common.Query.Fields[4].AsString, Common.Query.Fields[1].AsString),7,' ');
           if Common.Query.Fields[4].AsString <> 'W' then
           begin
             SaleAmt := SaleAmt + Common.Query.Fields[2].AsInteger;
             TempAmt := Common.Query.Fields[2].AsInteger
           end
           else
           begin
             SaleAmt := SaleAmt + Common.Query.Fields[3].AsInteger;
             TempAmt := (Common.Query.Fields[1].AsInteger / 100) * Common.Query.Fields[3].AsInteger;
           end;

           lsStr := lsStr + LPadB(FormatFloat('#,#0',TempAmt),12,' ');


           if Common.Query.Fields[4].AsString = 'W' then
             SaleCnt1 := SaleCnt1 + Common.Query.Fields[1].AsInteger
           else
             SaleCnt := SaleCnt + Common.Query.Fields[1].AsInteger;
           AddPrintData(lsStr);
           Common.Query.Next;

        end;
        AddPrintData(rptOneLine);
        AddPrintData(rptCharBold);
        if SaleCnt1 = 0 then
          AddPrintData(pStr+'     [ 합 계 ]     '+LPadB(FormatFloat('#,#0', SaleCnt),11,' ')
                                            +LPadB(FormatFloat('#,#0', SaleAmt),12,' ') )
        else
          AddPrintData(pStr+'[ 합 계 ]'+LPadB(Common.GetQtyReplace('W',IntToStr(SaleCnt1)) +'/'
                                  +FormatFloat('#,#0', SaleCnt),21,' ')
                                  +LPadB(FormatFloat('#,#0', SaleAmt),12,' ') );

        AddPrintData(rptSizeNormal);
        AddPrintData(rptTwoLine);

        //실제 프린터에 출력한다
        PrintPrinter(rptPosClose);
     end;
  end;

end;

procedure TDevice.CashBookPrint(CloseNo:String);                      //출납내역
var InAmt, OutAmt :Integer;
    lsStr :String;
begin
  PrintData := EmptyStr;

  With Common, Common.Config do
  begin
     if OpenQuery('select GetCommonName(CD_STORE,''11'', CD_ACCT) as NM_ACCT,'
                 +'       AMT_PAYIN, '
                 +'       AMT_OUT, '
                 +'       REMARK '
                 +'  from SL_ACCT '
                 +' where CD_STORE  =:P0 '
                 +'   and YMD_OCCUR =:P1 '
                 +'   and NO_POS    =:P2 '
                 +'   and CD_SAWON_CHG like :P3 '
                 +'   and Cast(NO_CLOSE as Char) like :P4 '
                 +' order by NO_ACCT ',
                 [Common.Config.StoreCode,
                  Common.WorkDate,
                  Common.Config.PosNo,
                  Ifthen(CloseNo='', '%',Common.Config.UserCode+'%'),
                  CloseNo + '%'
                  ]) > 0 then
     begin
        AddPrintData(rptSizeBoth);
        AddPrintData(rptAlignCenter);
        AddPrintData('출납내역');
        AddPrintData(rptAlignLeft);
        AddPrintData(rptLF);
        AddPrintData(rptSizeNormal);
        AddPrintData('포스번호 : '+ PosNo);
        if CloseNo <> '' then
          AddPrintData('계 산 원 : '+ UserCode+' - '+UserName);
        AddPrintData('매출일자 : '+ FormatMaskText('!0000년90월90일;0; ',WorkDate)+DayToWeek(WorkDate));
        AddPrintData(rptTwoLine);
        AddPrintData(pStr+'       출납명'+pStr+'           수입금액  지출금액');
        AddPrintData(rptTwoLine);
        Common.Query.First;
        While not Common.Query.Eof do
        begin
           lsStr := RPadB(Trim(Common.Query.Fields[0].AsString),22+pLen,' ')+
                    LPadB(FormatFloat('#,#0',Common.Query.Fields[1].AsInteger),10,' ')+
                    LPadB(FormatFloat('#,#0',Common.Query.Fields[2].AsInteger),10,' ');

           InAmt  := InAmt  + Common.Query.Fields[1].AsInteger;
           OutAmt := OutAmt + Common.Query.Fields[2].AsInteger;
           AddPrintData(lsStr);
           //비고내역이 있으면 출력한다
           if Common.Query.Fields[3].AsString <> '' then AddPrintData(pStr+Common.Query.Fields[3].AsString);
           Common.Query.Next;
        end;
        AddPrintData(rptOneLine);
        AddPrintData(rptCharBold);
        AddPrintData(pStr+'      수입합계     '+LPadB(FormatFloat('#,#0', InAmt),22+pLen,' '));
        AddPrintData(pStr+'      지출합계     '+LPadB(FormatFloat('#,#0', OutAmt),22+pLen,' '));
        AddPrintData(pStr+'      합계금액     '+LPadB(FormatFloat('#,#0', InAmt-OutAmt),22+pLen,' '));
        AddPrintData(rptSizeNormal);
        AddPrintData(rptTwoLine);

        //실제 프린터에 출력한다
        PrintPrinter(rptPosClose);
     end;
  end;
end;

procedure TDevice.DamdangPrint(CloseNo:String);                      //담당자매출내역
var TotAmt :Integer;
    lsStr :String;
begin
  PrintData := EmptyStr;

  With Common, Common.Config do
  begin
     if OpenQuery('select ConCat(a.CD_DAMDANG ,''-'',Ifnull(b.NM_SAWON,'''')) as DAMDANG, '
                 +'       sum(a.AMT_SALE) as AMT_SALE '
                 +'  from SL_SALE_H a inner join '
                 +'       MS_SAWON  b on b.CD_STORE = a.CD_STORE and b.CD_SAWON = a.CD_DAMDANG '
                 +' where a.CD_STORE =:P0 '
                 +'   and a.YMD_SALE =:P1 '
                 +'   and a.NO_POS   =:P2 '
                 +'   and a.CD_SAWON like :P3 '
                 +'   and Cast(a.NO_CLOSE as Char) like :P4 '
                 +'   and a.DS_SALE <> ''V'' '
                 +' group by a.CD_DAMDANG, b.NM_SAWON '
                 +'  order by a.CD_DAMDANG ',
                 [Common.Config.StoreCode,
                  Common.WorkDate,
                  Common.Config.PosNo,
                  Ifthen(CloseNo='', '%',Common.Config.UserCode+'%'),
                  CloseNo + '%'
                  ]) > 0 then
     begin
        AddPrintData(rptSizeBoth);
        AddPrintData(rptAlignCenter);
        AddPrintData('담당자별 매출내역');
        AddPrintData(rptAlignLeft);
        AddPrintData(rptLF);
        AddPrintData(rptSizeNormal);
        AddPrintData('포스번호 : '+ PosNo);
        if CloseNo <> '' then
          AddPrintData('계 산 원 : '+ UserCode+' - '+UserName);
        AddPrintData('매출일자 : '+ FormatMaskText('!0000년90월90일;0; ',WorkDate)+DayToWeek(WorkDate));
        AddPrintData(rptTwoLine);
        AddPrintData(pStr+'       담당자'+pStr+'                   매출금액');
        AddPrintData(rptTwoLine);
        Common.Query.First;
        While not Common.Query.Eof do
        begin
           lsStr := RPadB(Trim(Common.Query.Fields[0].AsString),32+pLen,' ')+
                    LPadB(FormatFloat('#,#0',Common.Query.Fields[1].AsInteger),10,' ');

           TotAmt  := TotAmt  + Common.Query.Fields[1].AsInteger;
           AddPrintData(lsStr);
           Common.Query.Next;
        end;
        AddPrintData(rptOneLine);
        AddPrintData(rptCharBold);
        AddPrintData(pStr+'     [ 합 계 ]     '+LPadB(FormatFloat('#,#0', TotAmt),23,' '));

        AddPrintData(rptSizeNormal);
        AddPrintData(rptTwoLine);

        //실제 프린터에 출력한다
        PrintPrinter(rptPosClose);
     end;
  end;
end;

procedure TDevice.DeliveryDamdangPrint;
var TotAmt :Integer;
    lsStr :String;
begin
  PrintData := EmptyStr;

  With Common, Common.Config do
  begin
     if OpenQuery('select c.NM_SAWON, '
                 +'       Count(*), '
                 +'       Sum(b.AMT_SALE) '
                 +'  from SL_DELIVERY a inner join '
                 +'       SL_SALE_H   b on a.CD_STORE    = b.CD_STORE '
                 +'                    and b.NO_DELIVERY = a.YMD_DELIVERY+a.NO_DELIVERY '
                 +'                    and b.DS_SALE      <> ''V'' inner join '
                 +'       MS_SAWON    c on a.CD_STORE = c.CD_STORE '
                 +'                    and a.CD_SAWON = c.CD_SAWON '
                 +' where a.CD_STORE =:P0 '
                 +'   and b.NO_POS   =:P1 '
                 +'   and b.YMD_SALE =:P2 '
                 +'   and a.DS_STEP <> ''C'' '
                 +' group by a.CD_SAWON, c.NM_SAWON '
                 +' order by a.CD_SAWON ',
                 [Common.Config.StoreCode,
                  Common.Config.PosNo,
                  Common.WorkDate
                  ]) > 0 then
     begin
        AddPrintData(rptSizeBoth);
        AddPrintData(rptAlignCenter);
        AddPrintData('배달원별 매출내역');
        AddPrintData(rptAlignLeft);
        AddPrintData(rptLF);
        AddPrintData(rptSizeNormal);
        AddPrintData('포스번호 : '+ PosNo);
        AddPrintData('매출일자 : '+ FormatMaskText('!0000년90월90일;0; ',WorkDate)+DayToWeek(WorkDate));
        AddPrintData(rptTwoLine);
        AddPrintData(pStr+'  담당자  '+pStr+'         건수         매출금액');
        AddPrintData(rptTwoLine);
        Common.Query.First;
        While not Common.Query.Eof do
        begin
           lsStr := RPadB(Trim(Common.Query.Fields[0].AsString),16+pLen,' ')+
                    LPadB(FormatFloat('#,#0',Common.Query.Fields[1].AsInteger),7,' ')+
                    LPadB(FormatFloat('#,#0',Common.Query.Fields[2].AsInteger),17,' ');

           TotAmt  := TotAmt  + Common.Query.Fields[1].AsInteger;
           AddPrintData(lsStr);
           Common.Query.Next;
        end;
        AddPrintData(rptOneLine);
        AddPrintData(rptCharBold);
        AddPrintData(pStr+'     [ 합 계 ]     '+LPadB(FormatFloat('#,#0', TotAmt),21,' '));

        AddPrintData(rptSizeNormal);
        AddPrintData(rptTwoLine);

        //실제 프린터에 출력한다
        PrintPrinter(rptPosClose);
     end;
  end;
end;

procedure TDevice.OrderCancelPrint;
var lsStr :String;
    vTemp :String;
begin
  PrintData := EmptyStr;

  //정산포스 대수를 구한다
  //정산포스가 한대이면 주문포스에 취소내역도 같이 출력한다
  OpenQuery('select Count(*) '
           +'  from MS_CODE '
           +' where CD_STORE  =:P0 '
           +'   and CD_KIND   =''01'' '
           +'   and DS_STATUS =0 '
           +'   and NM_CODE3  =''0'' ',
           [Common.Config.StoreCode]);
  if Common.Query.Fields[0].AsInteger = 1 then
    vTemp := '%'
  else
    vTemp := Common.Config.PosNo +'%';
  Common.Query.Close;

  With Common, Common.Config do
  begin
     if OpenQuery('select b.NM_MENU, '
                 +'        GetQty(b.DS_MENU_TYPE, a.QTY_CANCEL), '
                 +'        SubString(StoD(a.DT_ORDER), 12,5), '
                 +'        SubString(StoD(a.DT_CANCEL), 12,5), '
                 +'        c.nm_sawon '
                 +'   from SL_SALE_C a left outer join '
                 +'        MS_MENU   b on a.CD_STORE = b.CD_STORE '
                 +'                   and a.CD_MENU  = b.CD_MENU left outer join '
                 +'        MS_SAWON  c on a.CD_STORE = c.CD_STORE '
                 +'                   and a.CD_SAWON = c.CD_SAWON '
                 +'  where a.CD_STORE = :P0 '
                 +'    and a.NO_POS   like :P1 '
                 +'    and a.YMD_SALE = :P2 '
                 +' order by a.DT_CANCEL ',
                 [Common.Config.StoreCode,
                  vTemp,
                  Common.WorkDate]) > 0 then
     begin
        AddPrintData(rptSizeBoth);
        AddPrintData(rptAlignCenter);
        AddPrintData('주문취소내역');
        AddPrintData(rptAlignLeft);
        AddPrintData(rptLF);
        AddPrintData(rptSizeNormal);
        AddPrintData('포스번호 : '+ PosNo);
        AddPrintData('매출일자 : '+ FormatMaskText('!0000년90월90일;0; ',WorkDate)+DayToWeek(WorkDate));
        AddPrintData(rptTwoLine);
        AddPrintData(pStr+'    메뉴명    '+pStr+' 수량  주문  취소   담당자  ');
        AddPrintData(rptTwoLine);
        Common.Query.First;
        While not Common.Query.Eof do
        begin
           lsStr := RPadB(Trim(Common.Query.Fields[0].AsString),14+pLen,' ')+
                    LPadB(Trim(Common.Query.Fields[1].AsString),5,' ')+
                    LPadB(Trim(Common.Query.Fields[2].AsString),6,' ')+
                    LPadB(Trim(Common.Query.Fields[3].AsString),6,' ')+
                    LPadB(Trim(Common.Query.Fields[4].AsString),11,' ');
           AddPrintData(lsStr);
           Common.Query.Next;
        end;
        AddPrintData(rptTwoLine);

        //실제 프린터에 출력한다
        PrintPrinter(rptPosClose);
     end;
  end;

end;

procedure TDevice.SaleCancelPrint;
var lsStr :String;
begin
  PrintData := EmptyStr;

  With Common, Common.Config do
  begin
     if OpenQuery('select NO_RCP, '
                 +'       case AMT_SALE when AMT_CASH  then case when AMT_CASHRCP = 0 then ''현금'' else ''현금영수증'' end '
                 +'                     when AMT_CARD  then ''신용카드''  '
                 +'                     when AMT_LETSORDER  then ''렛츠오더''  '
                 +'                     when DC_POINT  then ''포인트''   '
                 +'                     when AMT_TRUST then ''외상''     '
                 +'                     when AMT_CHECK then ''수표''     '
                 +'                     when AMT_GIFT  then ''상품권'' '
                 +'                     when AMT_BANK THEN ''계좌입금'' '
                 +'                     else ''기타'' '
                 +'        end as TYPE_SALE, '
                 +'        Ifnull(AMT_SALE,    0) AS AMT_SALE, '
                 +'        Date_Format(DT_SALE,   ''%H:%i'') as SALE_TIME, '
                 +'        Date_Format(DT_CHANGE, ''%H:%i'') as DT_CHANGE '
                 +'   from SL_SALE_H '
                 +'  where DS_SALE = ''V'' '
                 +'    and CD_STORE = :P0 '
                 +'    and NO_POS   = :P1 '
                 +'    and YMD_SALE = :P2 '
                 +'  order by NO_RCP ',
                 [Common.Config.StoreCode,
                  Common.Config.PosNo,
                  Common.WorkDate]) > 0 then
     begin
        AddPrintData(rptSizeBoth);
        AddPrintData(rptAlignCenter);
        AddPrintData('매출취소내역');
        AddPrintData(rptAlignLeft);
        AddPrintData(rptLF);
        AddPrintData(rptSizeNormal);
        AddPrintData('포스번호 : '+ PosNo);
        AddPrintData('매출일자 : '+ FormatMaskText('!0000년90월90일;0; ',WorkDate)+DayToWeek(WorkDate));
        AddPrintData(rptTwoLine);
        AddPrintData(pStr+' 번호 '+pStr+'   결제          금액  계 산  취 소 ');
        AddPrintData(rptTwoLine);
        Common.Query.First;
        While not Common.Query.Eof do
        begin
           lsStr := RPadB(Trim(Common.Query.Fields[0].AsString),6+pLen,' ')+
                    RPadB(Trim(Common.Query.Fields[1].AsString),10,' ')+
                    LPadB(FormatFloat('#,#0',Common.Query.Fields[2].AsInteger),11,' ')+
                    LPadB(Trim(Common.Query.Fields[3].AsString),7,' ')+
                    LPadB(Trim(Common.Query.Fields[4].AsString),7,' ');
           AddPrintData(lsStr);
           Common.Query.Next;
        end;
        AddPrintData(rptTwoLine);

        //실제 프린터에 출력한다
        PrintPrinter(rptPosClose);
     end;
  end;
end;

procedure TDevice.PackingSalePrint(CloseNo:String='');
var vTotAmt :Integer;
    lsStr :String;
begin
  PrintData := EmptyStr;

  With Common, Common.Config do
  begin
     if OpenQuery('select c.NM_MENU, '
                 +'       GetQty(c.DS_MENU_TYPE, Sum(a.QTY_SALE)) as QTY_SALE, '
                 +'       Sum(a.AMT_SALE-a.DC_TOT) as AMT_SALE '
                 +'  from SL_SALE_D a inner join '
                 +'       SL_SALE_H b on b.CD_STORE = a.CD_STORE '
                 +'                  and b.YMD_SALE = a.YMD_SALE '
                 +'                  and b.NO_POS   = a.NO_POS '
                 +'                  and b.NO_RCP   = a.NO_RCP inner join '
                 +'       MS_MENU   c on c.CD_STORE = a.CD_STORE '
                 +'                  and c.CD_MENU  = a.CD_MENU '
                 +' where a.CD_STORE =:P0 '
                 +'   and a.YMD_SALE =:P1 '
                 +'   and a.NO_POS   =:P2 '
                 +'   and b.CD_SAWON like :P3 '
                 +'   and b.NO_CLOSE like :P4 '
                 +'   and a.DS_SALE_TYPE = ''P'' '
                 +'   and a.DS_SALE <> ''V'' '
                 +' group by a.CD_MENU, c.NM_MENU, c.DS_MENU_TYPE '
                 +' order by a.CD_MENU ',
                 [Common.Config.StoreCode,
                  Common.WorkDate,
                  Common.Config.PosNo,
                  Ifthen(CloseNo='', '%',Common.Config.UserCode+'%'),
                  CloseNo + '%'
                  ]) > 0 then
     begin
        AddPrintData(rptSizeBoth);
        AddPrintData(rptAlignCenter);
        AddPrintData('포장매출내역');
        AddPrintData(rptAlignLeft);
        AddPrintData(rptLF);
        AddPrintData(rptSizeNormal);
        AddPrintData('포스번호 : '+ PosNo);
        if CloseNo <> '' then
          AddPrintData('계 산 원 : '+ UserCode+' - '+UserName);
        AddPrintData('매출일자 : '+ FormatMaskText('!0000년90월90일;0; ',WorkDate)+DayToWeek(WorkDate));
        AddPrintData(rptTwoLine);
        AddPrintData(pStr+'       메뉴명 '+pStr+'            수량      금 액 ');
        AddPrintData(rptTwoLine);
        Common.Query.First;
        vTotAmt := 0;
        While not Common.Query.Eof do
        begin
           lsStr := RPadB(Trim(Common.Query.Fields[0].AsString),23+pLen,' ');
           lsStr := lsStr   + LPadB(Common.Query.Fields[1].AsString,7,' ');
           vTotAmt := vTotAmt + Common.Query.Fields[2].AsInteger;
           AddPrintData(lsStr);
           Common.Query.Next;

        end;
        AddPrintData(rptOneLine);
        AddPrintData(rptCharBold);
        AddPrintData(pStr+'      합계금액     '+LPadB(FormatFloat('#,#0', vTotAmt),11,' '));

        AddPrintData(rptSizeNormal);
        AddPrintData(rptTwoLine);

        //실제 프린터에 출력한다
        PrintPrinter(rptPosClose);
     end;
  end;
end;

procedure TDevice.CornerByPrint;
var TotAmt :Integer;
    vTemp  :String;
begin
  PrintData := EmptyStr;

  With Common, Common.Config do
  begin
     if OpenQuery('select d.NM_TRDPL, '
                 +'       sum(b.AMT_SALE-b.DC_TOT) as AMT_SOON '
                 +'  from SL_SALE_H a inner join '
                 +'       SL_SALE_D b on a.CD_STORE  = b.CD_STORE '
                 +'                  and a.YMD_SALE  = b.YMD_SALE '
                 +'                  and a.NO_POS    = b.NO_POS '
                 +'                  and a.NO_RCP    = b.NO_RCP inner join '
                 +'       MS_MENU   c on b.CD_STORE  = c.CD_STORE '
                 +'                  and b.CD_MENU   = c.CD_MENU inner join '
                 +'       MS_TRD    d on c.CD_STORE  = d.CD_STORE '
                 +'                  and c.CD_CORNER = d.CD_TRDPL '
                 +'                  and d.DS_TRDPL  = ''C'' '
                 +' where a.CD_STORE =:P0 '
                 +'   and a.YMD_SALE =:P1 '
                 +'   and a.NO_POS   =:P2 '
                 +'   and a.DS_SALE <> ''V''  '
                 +' group by d.NM_TRDPL ',
                 [Common.Config.StoreCode,
                  Common.WorkDate,
                  Common.Config.PosNo]) > 0 then
     begin
        AddPrintData(rptSizeBoth);
        AddPrintData(rptAlignCenter);
        AddPrintData('코너별 매출내역');
        AddPrintData(rptAlignLeft);
        AddPrintData(rptLF);
        AddPrintData(rptSizeNormal);
        AddPrintData('포스번호 : '+ PosNo);
        AddPrintData('매출일자 : '+ FormatMaskText('!0000년90월90일;0; ',WorkDate)+DayToWeek(WorkDate));
        AddPrintData(rptTwoLine);
        AddPrintData(pStr+'  코너명  '+pStr+'                      매출금액');
        AddPrintData(rptTwoLine);
        Common.Query.First;
        While not Common.Query.Eof do
        begin
           vTemp := RPadB(Trim(Common.Query.Fields[0].AsString),23+pLen,' ')+
                    LPadB(FormatFloat('#,#0',Common.Query.Fields[1].AsInteger),17,' ');

           TotAmt  := TotAmt  + Common.Query.Fields[1].AsInteger;
           AddPrintData(vTemp);
           Common.Query.Next;
        end;
        AddPrintData(rptOneLine);
        AddPrintData(rptCharBold);
        AddPrintData(pStr+'     [ 합 계 ]     '+LPadB(FormatFloat('#,#0', TotAmt),21,' '));

        AddPrintData(rptSizeNormal);
        AddPrintData(rptTwoLine);

        //실제 프린터에 출력한다
        PrintPrinter(rptPosClose);
     end;
  end;
end;

procedure TDevice.CloseCashRcpPrint(CloseNo:String);
var SaleAmt,
    SaleCnt  :Integer;
    lsStr    :String;
begin
  PrintData := EmptyStr;
  SaleAmt := 0; SaleCnt := 0;

  OpenQuery('select a.NO_CARD, '
           +'       case when a.DS_TRD = :P5 then ''승인'' '
           +'            else ''취소'' '
           +'       end as DS_TRD, '
           +'       case when a.DS_TRD = :P5 then Ifnull(a.AMT_APPROVAL,0)'
           +'            else (Ifnull(a.AMT_APPROVAL,0)) * -1 '
           +'       end as AMT_APPROVAL, '
           +'       a.NO_APPROVAL, '
           +'       case when a.DS_INPUT = ''O'' then ''단말기'' '
           +'            else ''인터넷'' '
           +'       end as TYPE_TRD  '
           +'  from SL_CASH   a inner join '
           +'       SL_SALE_H b on a.CD_STORE = b.CD_STORE '
           +'                  and a.YMD_SALE = b.YMD_SALE '
           +'                  and a.NO_POS   = b.NO_POS '
           +'                  and a.NO_RCP   = b.NO_RCP '
           +' where a.CD_STORE = :P0 '
           +'   and a.YMD_SALE = :P1 '
           +'   and a.NO_POS   = :P2 '
           +'   and b.DS_SALE  <> ''V''  '
           +'   and b.CD_SAWON   like :P3 '
           +'   and Cast(b.NO_CLOSE as Char) like :P4 '
           +' order by a.NO_RCP ',
          [Common.Config.StoreCode,
           Common.WorkDate,
           Common.Config.PosNo,
           Common.Config.UserCode+'%',
           CloseNo + '%',
           dtApproval]);
  if not Common.Query.Eof then
  begin
    AddPrintData(rptSizeBoth);
    AddPrintData(rptAlignCenter);
    AddPrintData('현금영수증 발행내역');
    AddPrintData(rptAlignLeft);
    AddPrintData(rptLF);
    AddPrintData(rptSizeNormal);
    AddPrintData('포스번호 : '+ Common.Config.PosNo);
    if CloseNo <> '' then
      AddPrintData('계 산 원 : '+ Common.Config.UserCode+' - '+Common.Config.UserName);
    AddPrintData('매출일자 : '+ FormatMaskText('!0000년90월90일;0; ',Common.WorkDate)+DayToWeek(Common.WorkDate));
    AddPrintData(rptTwoLine);
    AddPrintData('      식별번호         승인금액   승인번호');
    AddPrintData(rptTwoLine);
    Common.Query.First;
    While not Common.Query.Eof do
    begin
      case Length(Common.Query.Fields[0].AsString) of
        10 : lsStr := RPadB(FormatMaskText('!000-000-0000;0;', Common.Query.Fields[0].AsString),20,' ');
        11 : lsStr := RPadB(FormatMaskText('!000-0000-0000;0;', Common.Query.Fields[0].AsString),20,' ');
        16 : lsStr := FormatMaskText('!0000-0000-0000-00000;0;', Common.Query.Fields[0].AsString);
        else lsStr := Common.Query.Fields[0].AsString;
      end;
      if Common.Query.Fields[1].AsString = '승인' then
        lsStr := lsStr + LPadB(FormatFloat('#,0', Common.Query.Fields[2].AsInteger),11,' ')
      else
        lsStr := lsStr + LPadB('-'+FormatFloat('#,0', Common.Query.Fields[2].AsInteger),11,' ');

      lsStr := lsStr + LPadB(Common.Query.Fields[3].AsString,11, ' ');

       SaleAmt := SaleAmt + Common.Query.Fields[2].AsInteger;
       SaleCnt := SaleCnt + 1;
       AddPrintData(pStr+lsStr);
       Common.Query.Next;
    end;
    AddPrintData(rptOneLine);
    AddPrintData(rptCharBold);
    AddPrintData(pStr+'     [ 합 계 ]     '+LPadB(FormatFloat('#,#0', SaleCnt),11,' ')
                                      +LPadB(FormatFloat('#,#0', SaleAmt),12,' ') );
    AddPrintData(rptSizeNormal);
    AddPrintData(rptTwoLine);

    //실제 프린터에 출력한다
    PrintPrinter(rptPosClose);
  end;
end;

procedure TDevice.ReservePrint;
var I :Integer;
    lsStr,
    vTemp :String;
begin
  PrintData := EmptyStr;

  with Common.Config do
  begin
     AddPrintData(rptSizeBoth);
     AddPrintData(rptAlignCenter);
     AddPrintData(Ifthen(IsKiosk,'주문확인증','보류확인증'));
     AddPrintData(rptAlignLeft);
     AddPrintData(rptLF);
     AddPrintData(rptSizeNormal);

     AddPrintData('포스번호 : '+PosNo+'-'+UserName);
     if not IsKiosk then
     begin
       AddPrintData('보류번호 : '+Common.RestoreNo );
       AddPrintData('보류일시 : '+FormatDateTime('yyyy년mm월dd일 AM/PM hh시 nn분',now()));
     end
     else
     begin
       AddPrintData('주문번호 : '+Common.RestoreNo );
       AddPrintData('주문일시 : '+FormatDateTime('yyyy년mm월dd일 AM/PM hh시 nn분',now()));
     end;
     AddPrintData(rptOneLine);
     AddPrintData(pStr+'      메뉴명 '+pStr+'          단가 수량      금액');
     AddPrintData(rptOneLine);
     with Common.Summary_sGrd do
     begin
        For I := 0 to RowCount - 1 do
        begin
           lsStr := RPadB(SCopy(Cells[GDM_NM_MENU, I],1,18+pLen),18+pLen,' ');

           //저울형 상품이면
           if Cells[GDM_DS_MENU, I] = 'W' then vTemp := Cells[GDM_VIEWQTY, I]
           else  vTemp := FormatFloat('#,##0',  StoF(Cells[GDM_QTY, I]));

           AddPrintData(lsStr+ LPadB(FormatFloat('#,##0',StoI(Cells[GDM_PR_SALE, I])), 9,' ')+
                          LPadB(vTemp, 5, ' ')+
                          LPadB(FormatFloat('#,##0',StoI(Cells[GDM_AMT,    I])),10,' '));
        end;
     end;
     AddPrintData(rptOneLine);
     AddPrintData(rptSizeHeight);
     if not IsKiosk then
       AddPrintData(pStr+'                  보류금액'+LPadB(FormatFloat('#,##0',Common.PreSent.TotalAmt),16,' '))
     else
       AddPrintData(pStr+'                  주문금액'+LPadB(FormatFloat('#,##0',Common.PreSent.TotalAmt),16,' '));

     AddPrintData(rptSizeNormal);
     if Common.Member.Code <> '' then
       AddPrintData(Format('회원정보: %s(%s) ',[Common.Member.Name,Common.Member.Code]));
     AddPrintData(rptLF);
     AddPrintData(' ※상기금액은 정산시 변경될 수 있습니다');
     AddPrintData(rptLF);
  end;
  //실제 프린터에 출력한다
  PrintPrinter(rptHold);
end;

procedure TDevice.RiderCall(aData: String);
var vPrintData :String;
begin
  vPrintData := PrinterCommendReplace(aData,
                                      Common.Config.ReceiptPrinterDev,
                                      Common.Config.PrintColum,
                                      Common.Config.PrintBottomMargin);
  try
    BaeminComPort.Active;
  except
    Common.MsgBox('배달의 민족 프린터 오픈실패');
    Exit;
  end;

  BaeminComPort.SendString(vPrintData);
end;

procedure TDevice.BookingPrint(aKind:Integer; aValue:String);
const SQL_TXT = 'select NO_BOOKING, '
               +'       Date_Format(DT_BOOKING, ''%Y-%m-%d %H:%i'') as DT_BOOKING,'
               +'       NM_NAME, '
               +'       NO_TEL, '
               +'       CNT_PERSON, '
               +'       (select GetTableName(CD_STORE, NO_TABLE) '
               +'          from SL_BOOKING_TABLE '
               +'         where CD_STORE = a.CD_STORE '
               +'           and NO_BOOKING = a.NO_BOOKING '
               +'          limit 1 ) as TABLENAME, '
               +'       AMT_BOOKING, '
               +'       REMARK, '
               +'       Date_Format(DT_CHANGE, ''%Y-%m-%d %H:%i'') as DT_CHANGE   '
               +'  from SL_BOOKING as a '
               +' where CD_STORE	=:p0  '
               +'   and YN_SALE 	= ''N''  ';
var vTemp :String;
    vSqlTxt :String;
    vDate   :String;
    vTableName :String;
    vKind : Integer;
begin
  PrintData := EmptyStr;
  vKind := aKind;
  if aKind in [0,1] then
  begin
    if not Common.AskBox('간략하게 출력하시겠습니까?') then
      vKind := 2;
  end;

  with Common.Config do
  begin
     AddPrintData(rptSizeBoth);
     AddPrintData(rptAlignCenter);
     AddPrintData('예약현황');
     AddPrintData(rptAlignLeft);
     AddPrintData(rptLF);
     AddPrintData(rptSizeNormal);
     case aKind of
       0 : vSqlTxt := SQL_TXT + ' and Date_Format(DT_BOOKING, ''%Y%m%d'') >= Date_Format(Now(), ''%Y%m%d'') order by DT_BOOKING ';
       1 : vSqlTxt := SQL_TXT + ' and Date_Format(DT_BOOKING, ''%Y%m%d'') = '+GetOnlyNumber(LeftStr(aValue,10)) + ' order by DT_BOOKING ';
       2 : vSqlTxt := SQL_TXT + ' and NO_BOOKING = '+aValue;
     end;

     OpenQuery( vSqlTxt,
              [Common.Config.StoreCode]);
     case vKind of
       0,1 :
       begin
         if not Common.Query.Eof then
           AddPrintData(pStr+'예약일자 : '+ FormatDateTime('yyyy-mm-dd', Common.Query.FieldByName('DT_BOOKING').AsDateTime));
         AddPrintData(rptOneLine);
         AddPrintData(pStr+'시 간   예약자   인원     연락처    예약석');
         AddPrintData(rptOneLine);

         vDate := '';
         while not Common.Query.Eof do
         begin
           if (vDate <> '') and (vDate <> FormatDateTime('yyyymmdd', Common.Query.FieldByName('DT_BOOKING').AsDateTime)) then
           begin
             AddPrintData(rptLF);
             AddPrintData(pStr+'예약일자 : '+FormatDateTime('yyyy-mm-dd',Common.Query.FieldByName('DT_BOOKING').AsDateTime));
             AddPrintData(rptOneLine);
           end;
           vDate := FormatDateTime('yyyymmdd', Common.Query.FieldByName('DT_BOOKING').AsDateTime);

           AddPrintData(pStr+FormatDateTime('hh:nn ', Common.Query.FieldByName('DT_BOOKING').AsDateTime)
                           +RPadB(SCopy(Common.Query.FieldByName('nm_name').AsString,1,12),12,' ')
                           +' '+RPadB(Common.Query.FieldByName('cnt_person').AsString,2,' ')
                           +LPadB(SetTelephone(Common.Query.FieldByName('no_tel').AsString),13,' ')
                           +LPadB(Common.Query.FieldByName('tablename').AsString,8,' '));

           DM.OpenQuery('select b.NM_MENU, '
                       +'       a.QTY_MENU '
                       +'  from SL_BOOKING_MENU a inner join '
                       +'       MS_MENU         b on a.CD_STORE	 = b.CD_STORE '
                       +'                        and a.CD_MENU   = b.CD_MENU '
                       +' where a.CD_STORE	 = :P0 '
                       +'   and a.NO_BOOKING = :P1 ',
                       [Common.Config.StoreCode,
                        Common.Query.FieldByName('NO_BOOKING').AsString ]);
           if not DM.Query.Eof then
             AddPrintData('[예약메뉴]');

           while not DM.Query.Eof do
           begin
             AddPrintData('          '+RPadB(DM.Query.FieldByName('NM_MENU').AsString,26,' ')+LPadB(DM.Query.FieldByName('QTY_MENU').AsString,5,' '));
             DM.Query.Next;
           end;
           DM.Query.Close;

           if Trim(Common.Query.FieldByName('REMARK').AsString) <> EmptyStr then
             AddPrintData(pStr+'[비고] '+Trim(Common.Query.FieldByName('REMARK').AsString));

           Common.Query.Next;
         end;
       end;
       2 :
       begin
         AddPrintData(rptOneLine);
         while not Common.Query.Eof do
         begin
           AddPrintData(' 고 객 명 : '+Common.Query.FieldByName('NM_NAME').AsString);
           AddPrintData(' 연 락 처 : '+Common.Query.FieldByName('NO_TEL').AsString);
           AddPrintData(' 예약일시 : '+Common.Query.FieldByName('DT_BOOKING').AsString);
           AddPrintData(' 예약인원 : '+Common.Query.FieldByName('CNT_PERSON').AsString+'명');
           //테이블 이름
           DM.OpenQuery('select GetTableName(CD_STORE, NO_TABLE) '
                       +'  from SL_BOOKING_TABLE  '
                       +' where CD_STORE	 = :P0 '
                       +'   and NO_BOOKING = :P1 ',
                       [Common.Config.StoreCode,
                        Common.Query.FieldByName('NO_BOOKING').AsString ]);
           vTableName := '';
           while not DM.Query.Eof do
           begin
             vTableName := vTableName + DM.Query.Fields[0].AsString;
             DM.Query.Next;
             vTableName := vTableName + Ifthen(not DM.Query.Eof,',','');
           end;
           DM.Query.Close;
           AddPrintData(' 테 이 블 : '+vTableName);
           AddPrintData(' 예약금액 : '+FormatFloat('#,0',Common.Query.FieldByName('AMT_BOOKING').AsInteger));
           DM.OpenQuery('select b.NM_MENU, '
                       +'       a.QTY_MENU '
                       +'  from SL_BOOKING_MENU a inner join '
                       +'       MS_MENU         b on a.CD_STORE	 = b.CD_STORE '
                       +'                        and a.CD_MENU   = b.CD_MENU '
                       +' where a.CD_STORE	 = :P0 '
                       +'   and a.NO_BOOKING = :P1 ',
                       [Common.Config.StoreCode,
                        Common.Query.FieldByName('no_booking').AsString ]);
           if not DM.Query.Eof then
             AddPrintData('[예약메뉴]');

           while not DM.Query.Eof do
           begin
             AddPrintData('          '+RPadB(DM.Query.FieldByName('NM_MENU').AsString,26,' ')+LPadB(DM.Query.FieldByName('QTY_MENU').AsString,5,' '));
             DM.Query.Next;
           end;
           AddPrintData(' 비    고 : '+Trim(Common.Query.FieldByName('REMARK').AsString));
           AddPrintData(' 접수일시 : '+Common.Query.FieldByName('DT_CHANGE').AsString);
           Common.Query.Next;
           if not Common.Query.Eof then
             AddPrintData(rptOneLine);
         end;
       end;
     end;
     Common.Query.Close;
     AddPrintData(rptTwoLine);
     AddPrintData(rptLF);
  end;
  //실제 프린터에 출력한다
  PrintPrinter(rptBooking);
end;

//이전 고객주문서 재인쇄
procedure TDevice.BefCustomerOrderPrint;
begin
  if BefCustomerOrder = EmptyStr then Exit;
  PrintData := BefCustomerOrder;
  PrintPrinter(rptCustOrder);
  PrintData := EmptyStr;
end;

procedure TDevice.PrintSimpluRcp(aType,aValue:Integer);
var I :Integer;
begin
  PrintData := EmptyStr;
  with Common, Common.PreSent do
  begin
    AddPrintData(rptSizeBoth);
    AddPrintData(rptAlignCenter);
    AddPrintData('영  수  증');
    AddPrintData(rptAlignLeft);
    AddPrintData(rptLF);
    AddPrintData(rptSizeNormal);
    For I := 1 to 4 do
      if Trim(Config.ReceiptTitle[I]) <> '' then  AddPrintData(Config.ReceiptTitle[I]);

    AddPrintData(rptLF);
    AddPrintData(FormatMaskText('!0000년90월90일 00:00;0; ',WorkDate + NowTime)+'  '+Config.PosNo+'-'+Config.UserName);
    AddPrintData(rptTwoLine);
    if Config.SimpleRcpTxt <> '' then
    begin
      AddPrintData(pStr+'    메 뉴 명'+pStr+'           단가 수량      금액');
      AddPrintData(rptTwoLine);
      AddPrintData(RPadB(Config.SimpleRcpTxt,17+pLen,' ')+LPadB(FormatFloat('#,0',aValue),10,' ')+'    1'+LPadB(FormatFloat('#,0',aValue),10,' ') );
      AddPrintData(rptOneLine);
    end;
    AddPrintData(rptSizeWidth);
    AddPrintData('판매금액 '+LPadB(FormatFloat('#,##0',aValue),12+(pLen div 2),' '));
    AddPrintData(rptSizeNormal);
    AddPrintData('                  공급금액'+LPadB(FormatFloat('#,##0',(aValue/1.1) ),16+pLen,' '));
    AddPrintData('                부가세금액'+LPadB(FormatFloat('#,##0',aValue - (aValue/1.1) ),16+pLen,' '));
    AddPrintData(rptSizeWidth);
    AddPrintData('받을금액'+ LPadB(FormatFloat('#,##0',aValue),13+(pLen div 2),' '));
    AddPrintData(rptSizeNormal);
    case aType of
      0 : AddPrintData('                  현    금'+LPadB(FormatFloat('#,##0',aValue),16+pLen,' '));
      1 : AddPrintData('                  신용카드'+LPadB(FormatFloat('#,##0',aValue),16+pLen,' '));
    end;

    AddPrintData(rptOneLine);
    AddPrintData(rptLF);
    For I := 1 to High(Config.Rcp_end) do
      if Trim(Config.Rcp_End[I]) <> '' then  AddPrintData(Config.Rcp_End[I]);
  end;
  try
    PrintPrinter(rptSimpleRcp);
  except
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Name         : CashBoxOpen
// Type         : procedure
// Explanation  : 돈통열기
////////////////////////////////////////////////////////////////////////////////
procedure TDevice.CashBoxOpen(Kind:Integer);
begin
  if Common.Config.ReceiptPrinterDev = prtNone then Exit;
  if (Kind = 0) and (GetOption(44) = '1') then
  begin
    if Common.Config.UserPass <> Common.ShowNumberForm('패스워드를 입력하세요', 16,0,'') then
    begin
      Common.ErrBox('패스워드가 올바르지 않습니다');
      Exit;
    end;
  end;

{
  try
    ExecQuery('insert into SL_CASHBOX(CD_STORE, '
             +'                       YMD_REAL, '
             +'                       SEQ, '
             +'                       YMD_SALE, '
             +'                       NO_POS, '
             +'                       NO_RCP, '
             +'                       DS_OPEN, '
             +'                       CD_SAWON, '
             +'                       DT_CHANGE)  '
             +'               values (:P0, '
             +'                       Date_Format(Now(), ''%Y%m%d''), '
             +'                      (select Ifnull(Max(SEQ),0) + 1 '
             +'                         from SL_CASHBOX as s '
             +'                        where CD_STORE =:P0 '
             +'                          and YMD_REAL = Date_Format(Now(), ''%Y%m%d'')), '
             +'                       :P1, '
             +'                       :P2, '
             +'                       :P3, '
             +'                       :P4, '
             +'                       :P5, '
             +'                       Now()) ',
             [Common.Config.StoreCode,
              Common.WorkDate,
              Common.Config.PosNo,
              Ifthen(Kind=1,Common.PreSent.RcpNo,''),
              Ifthen(Kind=1, 'S','O'),
              Common.Config.UserCode]);
  except
    on E: Exception do
    begin
      Common.WriteLog('Device_CashBoxOpen',E.Message);
    end;
  end;
}
  try
    PrintData := EmptyStr;
    AddPrintData(#27'p'#0#25#250);
    PrintPrinter(rptNone);
  except
  end;
end;

{스트링을 Hex로 변환}
function TDevice.StrToHex(vsSource: string; var RevData:Array of String): Integer;
var vbOne, vbHigh, vbLow : byte;
    vcCount,I : integer;
begin
  vcCount := 1;
  I       := 0;
  While vcCount <= length(vsSource) do
  begin
    vbOne := byte(vsSource[vcCount]);
    vbHigh := vbOne shr 4;
    vbLow  := vbOne and 15;
    RevData[I] := format('%x', [vbHigh]) + format('%x', [vbLow]);
    inc(I);
    inc(vcCount);
  end;
  Result := I;
end;

procedure TDevice.AddPrintData(aData:AnsiString);
begin
  if (aData = rptCharNormal)     or
     (aData = rptCharBold)       or
     (aData = rptCharInverse)    or
     (aData = rptCharUnderline)  or
     (aData = rptAlignLeft)      or
     (aData = rptAlignCenter)    or
     (aData = rptAlignRight)     or
     (aData = rptSizeNormal)     or
     (aData = rptEnlargeNone)    or
     (aData = rptSizeWidth)      or
     (aData = rptEnlargeX)       or
     (aData = rptSizeHeight)     or
     (aData = rptEnlargeY)       or
     (aData = rptSizeBoth)       or
     (aData = rptEnlargeXY)      or
     (aData = rptSize3Times)     or
     (aData = rptLF)   then
  begin
    PrintData := PrintData + aData;
  end
  else
  begin
    PrintData := PrintData + aData +#13;
  end;

end;

procedure TDevice.PrintKitchen(aCode, aMenu, aSubMenu, aMemo, aQty, aAmt, aSpcDC, aKitchen, aMenuType, aDsSale, aDsTax, aCorner,
                               aMaster, aMasterQty, aMenuCode :AnsiString;aGroup, aSeq, aStep, aRealQty:Integer;
                               aCustomerSubMenuPrint,aKitchenSubMenuPrint,aBill,aDouble,aKitchenMenuName:AnsiString);
  procedure SetCornerbyOrder(aCorner, aOrderData:AnsiString);
  var I :Integer;
  begin
    For I := 0 to High(Common.Corner) do
    begin
      if Common.Corner[I].Code = aCorner then
      begin
        Common.Corner[I].OrderData := Common.Corner[I].OrderData + aOrderData;
        Break;
      end;
    end;
  end;
var I, vIdx, MenuLen, QtyLen, vCol, vIndex, vPrintQty :Integer;
    vCode,
    vTemp,
    vTemp1,                                                                  
    vMenu,
    vKitchenMenu,
    vGroupTxt,
    vTemp2,
    vMaster2,
    vMemo :String;
begin
  //배민 주방메모는 다음줄로 출력한다
  if Pos('배달의민족',Common.Table.Name) > 0 then
  begin
    vMemo := aMemo;
    aMemo := EmptyStr;
  end;
  //주방 주문서
  if (aCode <> '') and (aKitchenSubMenuPrint = 'Y') then
  begin
    if aDsSale = 'D' then
      vMenu := '서비스(' + AMenu + ')'
    else
      vMenu := aMenu;
    repeat
      if Pos(',',ACode) > 0 then
      begin
        vCode := Copy(aCode, 1, Pos(',',aCode)-1);
        aCode := Copy(aCode, 5, LengthB(aCode));
      end
      else
      begin
        vCode := Copy(ACode, 1, 3);
        ACode := EmptyStr;
      end;
      //주방프린터 위치 찾기
      vIdx := Common.GetKitchenIndex(0,StoI(aKitchen), vCode);
      if vIdx >= 0 then
      begin
        //푸드코트일때 주방에 코너를 연결한다
        Common.KitchenPrinter[vIdx].Corner := ACorner;
        if Common.KitchenPrinter[vIdx].LetsOrderOnly then Continue;

        vCol := Ifthen(Common.KitchenPrinter[vIdx].Col=1,6,0);
        //주방주문서 폰트크기에 따라
        case StoI(GetOption(103)) of
          0,1:
          begin
            if AMenuType = 'G' then
            begin
              case StoI(GetOption(142)) of
                0 :  //금액출력
                begin
                  MenuLen := 33+vCol;
                  QtyLen  := 7;
                end;
                1 :  //수량출력
                begin
                  MenuLen := 36+vCol;
                  QtyLen  := 4;
                end;
                2 :  //금액+(수량) 출력
                begin
                  MenuLen := 30+vCol;
                  QtyLen  := 10;
                end;
              end;
            end
            else
            begin
              MenuLen := 37+vCol;
              QtyLen  := 3;
            end;

            vTemp := RPadB(vMenu,MenuLen,' ');

            if aMaster <> EmptyStr then
              aMaster := RPadB(aMaster,  MenuLen,' ');


            //싯가일때는 금액을 출력한다
            if AMenuType = 'G' then
            begin
              case StoI(GetOption(142)) of
                0 : vTemp := vTemp + LPadB(AAmt,  QtyLen,' ')+#13;
                1 : vTemp := vTemp + LPadB(AQty,  QtyLen,' ')+#13;
                2 : vTemp := vTemp + LPadB(AAmt+'('+AQty+')',  QtyLen,' ')+#13;
              end;
              vTemp2    := vTemp;
              vPrintQty := 1;
            end
            else
            begin
              //메뉴 수량별로 낱장을 출력하기 위함
              vTemp2  := vTemp + LPadB('1',  QtyLen,' ')+#13;
              vTemp   := vTemp + LPadB(AQty,  QtyLen,' ')+#13;
              if aMaster <> EmptyStr then
              begin
                aMaster  := aMaster + LPadB(aMasterQty,  QtyLen,' ')+#13;
                vMaster2 := aMaster + LPadB('1',         QtyLen,' ')+#13;
              end;
              if AMenuType = 'W' then
                vPrintQty := 1
              else
                vPrintQty := aRealQty;
            end;
          end;
          2 :
          begin
            if AMenuType = 'G' then
            begin
              case StoI(GetOption(142)) of
                0 :  //금액출력
                begin
                  MenuLen := 14+(vCol div 2);
                  QtyLen  := 6;
                end;
                1 :  //수량출력
                begin
                  MenuLen := 18+(vCol div 2);
                  QtyLen  := 2;
                end;
                2 :  //금액+(수량) 출력
                begin
                  MenuLen := 10+(vCol div 2);
                  QtyLen  := 10;
                end;
              end;
            end
            else
            begin
              MenuLen := 18+(vCol div 2);
              QtyLen  := 2;
            end;

            vTemp  := RPadB(vMenu,MenuLen,' ');
            if aMaster <> EmptyStr then
              aMaster := RPadB(aMaster,  MenuLen,' ');

            //싯가일때는 금액을 출력한다
            if AMenuType = 'G' then
            begin
              case StoI(GetOption(142)) of
                0 : vTemp := vTemp + LPadB(aAmt,  QtyLen,' ')+#13;
                1 : vTemp := vTemp + LPadB(aQty,  QtyLen,' ')+#13;
                2 : vTemp := vTemp + LPadB(aAmt+'('+aQty+')',  QtyLen,' ')+#13;
              end;
              vTemp2    := vTemp;
              if aMenuType = 'W' then
                vPrintQty := 1
              else
                vPrintQty := aRealQty;
            end
            else
            begin
              //메뉴 수량별로 낱장을 출력하기 위함
              vTemp2  := vTemp + LPadB('1',        QtyLen,' ')+#13;
              vTemp   := vTemp + LPadB(aQty,       QtyLen,' ')+#13;
              if aMaster <> EmptyStr then
              begin
                aMaster  := aMaster + LPadB(aMasterQty,  QtyLen,' ')+#13;
                vMaster2 := aMaster + LPadB('1',         QtyLen,' ')+#13;
              end;
              vPrintQty := aRealQty;
            end;
          end;
        end;

        //부메뉴를 출력할때만 주메뉴 밑에 부메뉴를 붙인다
        if (GetOption(354) = '0') and (GetOption(241) = '1') then
        begin
          vTemp  := aMaster  + vTemp;
          if aMemo <> '' then
            vTemp := vTemp + aMemo + #13;
          vTemp2 := vMaster2 + vTemp2;
        end
        else if aMemo <> '' then
          vTemp := vTemp + aMemo + #13;

        //주방전용 메뉴명
        if (GetOption(308)='1') and (aKitchenMenuName <> '') then
          vTemp := vTemp + aKitchenMenuName + #13;

        //메뉴별로 주방주문서 낱장인쇄시
        if GetOption(9) = '1' then
        begin
          vGroupTxt := '';
          For I := 1 to 100 do
            vGroupTxt := vGroupTxt +  Common.KitchenPrinter[vIdx].GroupSource[I];

          if (GetOption(77) = '1') and ((Common.TableMode = tbmTableMoveing) or (Common.TableMode = tbmMergeing))
             and ((vGroupTxt <> '') or (Common.KitchenPrinter[vIdx].Source <> '')) then
          begin
          //
          end
          else
          begin

            //그룹을 사용하면서 그룹이 지정되었을때
            if (GetOption(79) = '1') and (aGroup > 0) then
            begin
              Common.KitchenPrinter[vIdx].GroupSource[aGroup] := Common.KitchenPrinter[vIdx].GroupSource[aGroup] + vTemp;
            end
            else
            begin
              if GetOption(374) = '0' then
              begin
                Common.KitchenPrinter[vIdx].Source := Common.KitchenPrinter[vIdx].Source +
                                                      vTemp + #28;  //저장하기 위함
                vTemp1 := SetOrderPrintHeader(vTemp, vIdx);
                Common.KitchenPrinter[vIdx].Data := Common.KitchenPrinter[vIdx].Data +
                                                    PrinterCommendReplace(vTemp1, Common.KitchenPrinter[vIdx].Device,
                                                    Common.KitchenPrinter[vIdx].Col,
                                                    Common.KitchenPrinter[vIdx].BottomMargin);
              end
              else   //메뉴별 낱장인쇄
              begin
                for vIndex := 1 to vPrintQty do
                begin
                  Common.KitchenPrinter[vIdx].Source := Common.KitchenPrinter[vIdx].Source +
                                                        vTemp2 + #28;  //저장하기 위함
                  vTemp1 := SetOrderPrintHeader(vTemp2, vIdx);
                  Common.KitchenPrinter[vIdx].Data := Common.KitchenPrinter[vIdx].Data +
                                                      PrinterCommendReplace(vTemp1, Common.KitchenPrinter[vIdx].Device,
                                                      Common.KitchenPrinter[vIdx].Col,
                                                      Common.KitchenPrinter[vIdx].BottomMargin );
                end;
              end;
            end;
          end;
          //주방모니터용
          if vTemp <> EmptyStr then
            Common.KitchenPrinter[vIdx].Menu   := Common.KitchenPrinter[vIdx].Menu + 'O'             + splitColumnAnsi
                                                                                   + IntToStr(aSeq)  + splitColumnAnsi
                                                                                   + IntToStr(aStep) + splitColumnAnsi
                                                                                   + aMenuCode       + splitColumnAnsi
                                                                                   + aSubMenu        + splitColumnAnsi
                                                                                   + IntToStr(aRealQty) + splitColumnAnsi
                                                                                   + aAmt            + splitColumnAnsi
                                                                                   + aMemo           + splitColumnAnsi
                                                                                   + aDsSale         + splitColumnAnsi
                                                                                   + aDouble         + splitRecordAnsi;

        end
        else
        begin
          if (Pos('배달의민족',Common.Table.Name) > 0) and (vMemo <> '') then
            vTemp := vTemp + vMemo;

          if GetOption(104) = '1' then
            vTemp := vTemp + #13;

          Common.KitchenPrinter[vIdx].Source := Common.KitchenPrinter[vIdx].Source + vTemp;  //저장하기 위함
          Common.KitchenPrinter[vIdx].Data   := Common.KitchenPrinter[vIdx].Data   + vTemp;
          //주방모니터용
          if vTemp <> EmptyStr then
            Common.KitchenPrinter[vIdx].Menu   := Common.KitchenPrinter[vIdx].Menu + 'O'             + splitColumnAnsi
                                                                                   + IntToStr(aSeq)  + splitColumnAnsi
                                                                                   + IntToStr(aStep) + splitColumnAnsi
                                                                                   + aMenuCode       + splitColumnAnsi
                                                                                   + aSubMenu        + splitColumnAnsi
                                                                                   + IntToStr(aRealQty) + splitColumnAnsi
                                                                                   + aAmt            + splitColumnAnsi
                                                                                   + aMemo           + splitColumnAnsi
                                                                                   + aDsSale         + splitColumnAnsi
                                                                                   + aDouble         + splitRecordAnsi;
        end;
      end;
    until Length(ACode) = 0;
  end; //if ACode <> '' then

  //고객용 주문서 (aKind 0:부메뉴이면서 부메뉴 출력안할때)
  if (aCustomerSubMenuPrint = 'Y') and (aBill = 'Y') then
  begin
    aMenu := StringReplace(aMenu,' (추가)','',[rfReplaceAll]);
    if GetOption(409) = '0' then
    begin
      vTemp := RPadB(aMenu,27+pLen,' ');
    end
    else
    begin
      if (aDsSale = 'D') and (Pos('서비스',aMenu)=0) then
        aMenu := aMenu + '(서비스)';

      vTemp := RPadB(aMenu,37+pLen,' ');
    end;

    //푸드코트 사용 시 코너별로 주문서를 출력할때
    if (Common.Config.IsTakeOut) and (GetOption(231) = '1') and (GetOption(233) = '1') then
    begin
      vTemp := vTemp + LPadB(aQty, 4,' ');
      if ADsSale = 'D' then
        vTemp := vTemp + LPadB('서비스',11,' ')+#13
      else
      begin
        //부가세별도 메뉴일때 부가세를 출력하지 않을때는 단가에서 부가세를 뺀다
        if (GetOption(224) = '1') and (aDsTax = '2') then
          AAmt := FormatFloat('#0', StoI(aAmt) / 1.1);

        vTemp := vTemp + LPadB(FormatFloat('#,0',StoI(aAmt)+(StoI(aSpcDc)*aRealQty)),11,' ')+#13;
      end;

      //주방메모 출력
      if (GetOption(161) = '1') and (aMemo <> '') then
        vTemp := vTemp + aMemo + #13;

      if GetOption(114) = '1' then
        vTemp := vTemp + #13;

      SetCornerbyOrder(aCorner, vTemp);
    end
    else
    begin
      //메뉴별 통합출력
      if GetOption(410) = '0' then
      begin
        Common.CustomerPrinter := Common.CustomerPrinter + vTemp;
        Common.CustomerPrinter := Common.CustomerPrinter + LPadB(aQty, 4,' ');
        //고객주문서에 금액 출력여부
        if GetOption(409) = '0' then
        begin
          if aDsSale = 'D' then
            Common.CustomerPrinter := Common.CustomerPrinter + LPadB('서비스',11,' ')+#13
          else
          begin
            //부가세별도 메뉴일때 부가세를 출력하지 않을때는 단가에서 부가세를 뺀다
            if (GetOption(224) = '1') and (aDsTax = '2') then
              aAmt := FormatFloat('#0', StoI(aAmt) / 1.1);

            Common.CustomerPrinter := Common.CustomerPrinter + LPadB(FormatFloat('#,0',StoI(AAmt)+StoI(aSpcDc)*aRealQty),11,' ')+#13;
          end;
        end
        else
          Common.CustomerPrinter := Common.CustomerPrinter + #13;

        //주방메모 출력
        if (GetOption(161) = '1') and (aMemo <> '') then
          Common.CustomerPrinter := Common.CustomerPrinter + aMemo + #13;

        if GetOption(114) = '1' then
          Common.CustomerPrinter := Common.CustomerPrinter + #13;
      end
      //메뉴별 낱장 출력
      else if GetOption(410) = '1' then
      begin
        vTemp := vTemp + '   1';
        if GetOption(409) = '0' then
        begin
          if aDsSale = 'D' then
            vTemp := vTemp +  LPadB('서비스',11,' ')
          else
          begin
            //부가세별도 메뉴일때 부가세를 출력하지 않을때는 단가에서 부가세를 뺀다
            if (GetOption(224) = '1') and (aDsTax = '2') then
              aAmt := FormatFloat('#0', StoI(aAmt) / 1.1);
            vTemp := vTemp + LPadB(FormatFloat('#,0',StoI(AAmt)+StoI(aSpcDc)),11,' ');
          end
        end;

        for vIndex := 1 to aRealQty do
          Common.CustomerPrinter := Common.CustomerPrinter + vTemp + #13 + splitColumnAnsi;
      end
      //메뉴별 출력
      else if GetOption(410) = '2' then
      begin
        vTemp := vTemp + LPadB(aQty, 4,' ');
        if GetOption(409) = '0' then
        begin
          if aDsSale = 'D' then
            vTemp := vTemp +  LPadB('서비스',11,' ')
          else
          begin
            //부가세별도 메뉴일때 부가세를 출력하지 않을때는 단가에서 부가세를 뺀다
            if (GetOption(224) = '1') and (aDsTax = '2') then
              aAmt := FormatFloat('#0', StoI(aAmt) / 1.1);
            vTemp := vTemp + LPadB(FormatFloat('#,0',StoI(AAmt)+StoI(aSpcDc)*aRealQty),11,' ');
          end
        end;
        Common.CustomerPrinter := Common.CustomerPrinter + vTemp + #13 + splitColumnAnsi;
      end;
    end;
  end;

  Common.OrderAmt := Common.OrderAmt + StoI(AAmt);
end;

//**************************************************************************//
//                       주문취소시 취소내역 저장
//**************************************************************************//
procedure TDevice.OrderCancel(aGrid:TStringGrid;aRow:Integer;aQty:String);
var vIdx, I, aGroup, MenuLen, QtyLen, vCol   :Integer;
    aCode, vMenu, vAmt,
    vCode, vTemp, vTemp1, vMemo, vQty, vGroupTxt :String;
    IsAll  :Boolean;
    vPrint :Boolean;
begin
  //취소주문시 출력여부
  vPrint := GetOption(154) = '0';

  //부메뉴를 출력안한다고 했을때
  if vPrint and (GetOption(354) = '1') and (aGrid.Cells[GDM_CD_MENU1, aRow] <> '') then
    vPrint := false;

  //부메뉴를 설정 주방으로 출력할때
  if vPrint and (GetOption(241) = '0') and (aGrid.Cells[GDM_CD_MENU1, aRow] <> '') then
    vPrint := false;

  //주문취소시 주방주문서를 출력하지 않는다고 했으면 가냥 빠져나간다
  if vPrint then 
  begin
    with aGrid do
    begin
      //주문이 완료되지 않은 메뉴이면 그냥빠져나감
      if Cells[GDM_YN_ORDER, aRow] = 'N' then Exit;

      aCode := Cells[GDM_KITCHEN,      aRow];
      vMenu := StringReplace(Cells[GDM_NM_MENU, aRow],
                             Cells[GDM_MEMO, aRow],
                             '',
                             [rfReplaceAll]);

      vMenu  := Cells[GDM_TYPE,    aRow] + vMenu;
      // 취소 시 메뉴명 뒤에 (취소)를 출력한다고 체크했을때
      if GetOption(30) = '0' then
        vMenu := vMenu + '(취소)';

      //중량형일때
      if Cells[GDM_DS_MENU, aRow] = 'W' then
      begin
        vAmt  := Cells[GDM_AMT,          ARow];
        AQty  := Cells[GDM_VIEWQTY,      ARow];
        vQty  := Cells[GDM_VIEWQTY,      ARow];
      end
      else
      begin
        vAmt  := IntToStr( StoI(AQty) * StoI(Cells[GDM_PR_SALE, ARow]) );
        vQty  := IntToStr( ABS(StoI(AQty)) );
      end;
      vMemo  := Cells[GDM_MEMO,      ARow];
      aGroup := StoI(Cells[GDM_NO_GROUP,  ARow]);
    end;

    IsAll := Pos('000',aCode) > 0;
    if aCode <> '' then
    begin
      //주방주문서 취소내역
      repeat
        if Pos(',',ACode) > 0 then
        begin
          vCode := Copy(ACode, 1, Pos(',',ACode)-1);
          ACode := Copy(ACode, 5, LengthB(ACode));
        end
        else
        begin
          vCode := Copy(ACode, 1, 3);
          ACode := EmptyStr;
        end;

        vIdx := Common.GetKitchenIndex(0,StoI(aGrid.Cells[GDM_PRT_KITCHEN, aRow]), vCode);
        if vIdx >= 0 then
        begin
          vCol := Ifthen(Common.KitchenPrinter[vIdx].Col=1,6,0);
          if Common.KitchenPrinter[vIdx].LetsOrderOnly then Continue;


          //메뉴명 글자크기(보통, 세로확대)
          case StoI(GetOption(103)) of
            0,1:
            begin
              if aGrid.Cells[GDM_DS_MENU, ARow] = 'G' then
              begin
                case StoI(GetOption(142)) of
                  0 :  //금액출력
                  begin
                    MenuLen := 34+vCol;
                    QtyLen  := 6;
                  end;
                  1 :  //수량출력
                  begin
                    MenuLen := 36+vCol;
                    QtyLen  := 4;
                  end;
                  2 :  //금액+(수량) 출력
                  begin
                    MenuLen := 30+vCol;
                    QtyLen  := 10;
                  end;
                end;
              end
              else
              begin
                MenuLen := 36+vCol;
                QtyLen  := 4;
              end;

              if LengthB(vMenu)+LengthB(vMemo) <= MenuLen then
                vTemp := RPadB(vMenu+vMemo,MenuLen,' ')
              else
                vTemp := RPadB(Scopy(vMenu+vMemo,1,MenuLen),MenuLen,' ');

              vTemp := vTemp + LPadB('-'+AQty,  QtyLen,' ')+#13;

              //메뉴명이 길때 두번째줄 출력
              if (LengthB(vMenu)+LengthB(vMemo) > MenuLen) then
                vTemp := vTemp + Scopy(vMenu+vMemo,MenuLen+1,LengthB(vMenu+vMemo)) +#13;
            end;
            2 : //가로세로확대
            begin
              if aGrid.Cells[GDM_DS_MENU, aRow] = 'G' then
              begin
                case StoI(GetOption(142)) of
                  0 :  //금액출력
                  begin
                    MenuLen := 14+(vCol div 2);
                    QtyLen  := 6;
                  end;
                  1 :  //수량출력
                  begin
                    MenuLen := 18+(vCol div 2);
                    QtyLen  := 2;
                  end;
                  2 :  //금액+(수량) 출력
                  begin
                    MenuLen := 10+(vCol div 2);
                    QtyLen  := 10;
                  end;
                end;
              end
              else
              begin
                MenuLen := 17+(vCol div 2);
                QtyLen  := 4;
              end;

              if LengthB(vMenu)+LengthB(vMemo) <= MenuLen then
                vTemp := RPadB(vMenu+vMemo,MenuLen,' ')
              else
                vTemp := RPadB(Scopy(vMenu+vMemo,1,MenuLen),MenuLen,' ');

              vTemp := vTemp + LPadB('-'+AQty,  QtyLen,' ')+#13;

              //메뉴명이 길때 두번째줄 출력
              if (LengthB(vMenu)+LengthB(vMemo) > MenuLen) then
                vTemp := vTemp + Scopy(vMenu+vMemo,MenuLen+1,LengthB(vMenu+vMemo)) +#13;
            end;
          end;

          if GetOption(30) = '2' then
            vTemp := '(취소)'+#13+vTemp;

          //취소가 있다는 표시
          vTemp := vTemp + '∵';
          //메뉴별로 주방주문서 낱장인쇄시
          if GetOption(9) = '1' then
          begin
            vGroupTxt := '';
            For I := 1 to 100 do
              vGroupTxt := vGroupTxt +  Common.KitchenPrinter[vIdx].GroupSource[I];

            if (GetOption(77) = '1') and ((Common.TableMode = tbmTableMoveing) or (Common.TableMode = tbmMergeing))
               and ((vGroupTxt <> '') or (Common.KitchenPrinter[vIdx].Source <> '')) then
            begin
            //
            end
            else
            begin
              //그룹을 사용하면서 그룹이 지정되었을때
              if (GetOption(79) = '1') and (aGroup > 0) then
              begin
                Common.KitchenPrinter[vIdx].GroupSource[aGroup] := Common.KitchenPrinter[vIdx].GroupSource[aGroup] + vTemp;
              end
              else
              begin
                Common.KitchenPrinter[vIdx].Source := Common.KitchenPrinter[vIdx].Source + vTemp + #28;  //저장하기 위함
                Common.KitchenPrinter[vIdx].Corner := aGrid.Cells[GDM_CORNER, ARow];
                vTemp1 := SetOrderPrintHeader(vTemp, vIdx);
                Common.KitchenPrinter[vIdx].Cancel := Common.KitchenPrinter[vIdx].Cancel +
                                                  PrinterCommendReplace(vTemp1, Common.KitchenPrinter[vIdx].Device,
                                                  Common.KitchenPrinter[vIdx].Col,
                                                  Common.KitchenPrinter[vIdx].BottomMargin );
              end;
            end;

            //주방모니터용
            if vTemp <> EmptyStr then
              Common.KitchenPrinter[vIdx].Menu   := Common.KitchenPrinter[vIdx].Menu + 'C'                             + splitColumnAnsi
                                                                                     + aGrid.Cells[GDM_SEQ, aRow]      + splitColumnAnsi
                                                                                     + aGrid.Cells[GDM_NO_STEP, aRow]  + splitColumnAnsi
                                                                                     + aGrid.Cells[GDM_CD_MENU, aRow]  + splitColumnAnsi
                                                                                     + aGrid.Cells[GDM_CD_MENU1, aRow] + splitColumnAnsi
                                                                                     + GetOnlyNumber(aQty)             + splitColumnAnsi
                                                                                     + aGrid.Cells[GDM_AMT, aRow]      + splitColumnAnsi
                                                                                     + aGrid.Cells[GDM_MEMO, aRow]     + splitColumnAnsi
                                                                                     + aGrid.Cells[GDM_DS_SALE, aRow]  + splitColumnAnsi
                                                                                     + aGrid.Cells[GDM_YN_DOUBLE, aRow]+ splitRecordAnsi;

          end
          else
          begin
            //주문메뉴별로 공백라인 추가
            if GetOption(104) = '1' then
               vTemp := vTemp + #13;

            Common.KitchenPrinter[vIdx].Source := Common.KitchenPrinter[vIdx].Source + vTemp;
            Common.KitchenPrinter[vIdx].Cancel := Common.KitchenPrinter[vIdx].Cancel + vTemp;
            Common.KitchenPrinter[vIdx].Corner := aGrid.Cells[GDM_CORNER, ARow];

            //주방모니터용
            if vTemp <> EmptyStr then
              Common.KitchenPrinter[vIdx].Menu   := Common.KitchenPrinter[vIdx].Menu + 'C'                             + splitColumnAnsi
                                                                                     + aGrid.Cells[GDM_SEQ, aRow]      + splitColumnAnsi
                                                                                     + aGrid.Cells[GDM_NO_STEP, aRow]  + splitColumnAnsi
                                                                                     + aGrid.Cells[GDM_CD_MENU, aRow]  + splitColumnAnsi
                                                                                     + aGrid.Cells[GDM_CD_MENU1, aRow] + splitColumnAnsi
                                                                                     + GetOnlyNumber(aQty)             + splitColumnAnsi
                                                                                     + aGrid.Cells[GDM_AMT, aRow]      + splitColumnAnsi
                                                                                     + aGrid.Cells[GDM_MEMO, aRow]     + splitColumnAnsi
                                                                                     + aGrid.Cells[GDM_DS_SALE, aRow]  + splitColumnAnsi
                                                                                     + aGrid.Cells[GDM_YN_DOUBLE, aRow]+ splitRecordAnsi;

          end;
        end;
      until Length(ACode) = 0;
    end;
  end
  else
  begin
    vMenu := StringReplace(aGrid.Cells[GDM_NM_MENU, aRow],
                           aGrid.Cells[GDM_MEMO, aRow],
                           '',
                           [rfReplaceAll]);

    // 취소 시 메뉴명 뒤에 (취소)를 출력한다고 체크했을때
    if GetOption(30) = '0' then
      vMenu := vMenu + '(취소)';

    //중량형일때
    if aGrid.Cells[GDM_DS_MENU, ARow] = 'W' then
    begin
      vAmt  := aGrid.Cells[GDM_AMT,          aRow];
      vQty  := aGrid.Cells[GDM_VIEWQTY,      aRow];
    end
    else
    begin
      vAmt  := IntToStr( StoI(aQty) * StoI(aGrid.Cells[GDM_PR_SALE, aRow]) );
      vQty  := IntToStr( ABS(StoI(aQty)) );
    end;
  end;


  // 고객주문서에 취소내역을 출력할때
  if (aGrid.Cells[GDM_YN_ORDER, aRow] = 'Y') and (GetOption(163) = '0') and ((GetOption(338) = '0') or (aGrid.Cells[GDM_CD_MENU1, aRow] = '')) and (vMenu <> EmptyStr) then
  begin
    if GetOption(30) = '1' then
      vMenu := vMenu + '(취소)';
    //고객주문서 취소내역
    Common.CustomerCancel := Common.CustomerCancel + RPadB(vMenu, 27+pLen, ' ')
                                                   + LPadB('-'+vQty,   4, ' ')
                                                   + LPadB(FormatFloat('#,0',StoI(vAmt)),11, ' ')+#13;

    //메뉴간 공백줄
    if GetOption(114) = '1' then                                                       
      Common.CustomerCancel := Common.CustomerCancel + #13;
  end;
end;

{-----------------------------------------------------------------------}
{                   주방주문서(AKind - 0:상태체크, 1:출력)              }
{-----------------------------------------------------------------------}
function TDevice.OrderSend(aKind, aCode, aData, aHost, aPort: String): String;
var vHnd      :THandle;
    Data     :TCOPYDATASTRUCT;
    vSendData :AnsiString;
begin
  //IP가 같으면 윈도우 메세지로 보낸다
  if (GetOption(427) = '1') or (Common.Config.RcpToKitchen and (GetOption(379) = '1')) then
  begin
    PrintData := aData;
    PrintPrinter;
    Result := 'OK'
  end
  //포스와 주방 IP가 같을때 상태체크를 하지 않고 출력시에는 WindowsMessage로 전송한다
  else if (Common.Config.PosIP = aHost) and ((aKind = '0') and (GetOption(17) = '0')) then
  begin
    vHnd := FindWindow('TfrmDemonMain', nil);
    vSendData := aKind+#7+aCode +#7+ aData +#7;
    Data.dwData:=0;
    Data.cbData:=Length(vSendData)+1;
    Data.lpData:=PAnsiChar(vSendData);

    SendMessage(vHnd, WM_COPYDATA, 0, LPARAM(@Data));
    Result := 'OK';
  end
  else
    with TIdTCPClient.Create(Application) do
    begin
      //주방이 연결된 포스가 자신일때
      if Common.Config.PosIP = aHost then
        Host := '127.0.0.1'
      else
        Host := aHost;
      Port := 7002;
      try
        try
          ConnectTimeout := 1000;
          Connect;
          Socket.WriteLnRFC(aKind+#7+aCode +#7+ aData +#7+#9, IndyTextEncoding_OSDefault);

          Result := '상태체크가 지원되지 않는 프린터입니다';
          Result := Socket.ReadLn(#3,IndyTextEncoding_OSDefault);
        except
          Result := 'Connect Error';
          Exit;
        end;
      finally
        try
          Disconnect(true);
          if Connected then
            Disconnect(true);
        except
        end;
        Free;
      end;
    end;
end;

procedure TDevice.PrinterRxChar(Com: TObject; Buffer: Pointer; Received: Cardinal);
var vStr :String;
    vBool :Boolean;
    vIndex, vCount :Integer;
begin
  vBool := False;
  PrinterStatus :='';
  for vIndex := 0 to Received - 1 do
    PrinterStatus := PrinterStatus + PAnsiChar(Buffer)[vIndex];

  Common.WriteLog('PrinterRxChar',PrinterStatus);
  //NICE Cat단말기를 연동시
  if (GetOption(379) = '1') and (Common.Config.van_trd = vanNICE) then Exit;

  //TM 프린터에서 전원을 껐다가 켜면 이 값이 옴
  if PrinterStatus = ';1'#0 then Exit;
  vStr := PrinterStatus;
  Common.PrinterInData := Common.PrinterInData + vStr;
  //KIS Cat 단말기 연동시  2018.09.20 보안IC버젼을 사용해도 단말기 연동 사용하도록 수정
  if (Common.Config.van_trd = vanKIS) and (vStr=#$16#$16#$16#$16#$16) then
  begin
    vStr := #3;
    Common.PrinterInData  := '11'#3;
    vBool := True;
  end;
  //JTNET Cat단말기를 연동시
  if (Common.Config.van_trd = vanJTNET) and (Pos(#3, vStr) > 0) then
    vBool := True;
  //FDK Cat단말기 연동시 ENQ(#5)요청후 응답대기(#6)
  if (GetOption(379) = '1') and (Common.Config.van_trd = vanFDIK) then
  begin
    if (Pos(#4, vStr) > 0) then
      Exit
    else
    begin
      Common.PrinterInData := EmptyStr;
      Exit;
    end;
  end;


  if (Pos(#13, vStr) > 0) or (Pos(#0, vStr) > 0) or (Pos(#3, vStr) > 0) then
  begin
    if ((GetOption(379)='0')) and not (Common.Config.van_trd in [vanKIS, vanJTNET]) then Exit;

    try
      if (Length(Common.PrinterInData) = 1) then
      begin
         PrinterStatus := Common.PrinterInData
      end
      {회원 띄워있을때}
      else if vBool and Assigned(Member_F) and Member_F.Showing then
      begin
        if Length(Common.PrinterInData) > 20 then
          Member_F.SearchEdit.Text := Common.PrinterInData
        else
          Member_F.SearchEdit.Text := GetOnlyNumber(Common.PrinterInData);
        Member_F.SelectMember(0, 0);
      end
      else if vBool and Assigned(MemberAdd_F) and MemberAdd_F.Showing then
      begin
        if LengthB(Common.PrinterInData) > 20 then
        begin
          MemberAdd_F.CardNoEdit.Text := Common.PrinterInData;
          MemberAdd_F.CardNoEditExit(nil);
        end
        else
          MemberAdd_F.CardNoEdit.Text := GetOnlyNumber(Common.PrinterInData);
      end
      else if vBool and ((Assigned(MultiCard_F) and MultiCard_F.Showing) or (Assigned(MultiCashRcp_F) and MultiCashRcp_F.Showing)) then
      begin
        Exit;
      end
      //신용카드폼에서 시리얼방식 MSR 리딩시
      else if vBool and Assigned(Card_F) and Card_F.Showing then
      begin
        if ((GetOption(379)='0')) and not (Common.Config.van_trd in [vanKIS, vanJTNET]) then Exit;
        //JTNET 카드이벤트로 받았을때
        if (Pos(#3, Common.PrinterInData) > 0) and (Common.Config.van_trd = vanJTNET) and ((Pos('~0092',Common.PrinterInData) > 0 ) or (Pos('~0023',Common.PrinterInData) > 0 )) then
        begin
          //다중사업자일때는 카드승인 폼에 있을때는 패스
          if GetOption(60) = '1' then
            Exit;
          if (Copy(Common.PrinterInData,10,1) = '0') or (Copy(Common.PrinterInData,10,1) = '1') then
            Common.PrinterInData := Copy(Common.PrinterInData,10,1)+#3
          else
          begin
          //AID Format 1(Count)+Label(16)+Label(16)
            vCount := StoI(Copy(Common.PrinterInData,10,1));
            if vCount = 0 then
              Common.PrinterInData := '1'+#3
            else
            begin
              vStr := Copy(Common.PrinterInData,11,vCount*17);
              Common.PrinterInData := EmptyStr;
              for vIndex := 1 to vCount do
              begin
                Common.PrinterInData := Common.PrinterInData + Copy(vStr,2, 16);
                Delete(vStr,1,17);
              end;
              Common.PrinterInData := 'AID'+IntToStr(vCount)+Common.PrinterInData;
            end;
          end;
        end;
        if (GetOption(379) = '1') and not (Common.Config.van_trd in [vanJTNET, vanKIS]) then Exit;

        if (Common.Config.van_trd in [vanKIS, vanJTNET]) then
        begin
          //이번거래만 단말기 연동으로 사용하기 위함
          Common.Config.Options[379]   := '1';
          if Common.Config.van_trd = vanKIS then
            Common.PrinterInData        := '1'+#3;
        end;

        Card_F.MsrData := Common.PrinterInData;
        Card_F.Timer1.Enabled := True;
      end
      //현금영수증폼에서 시리얼방식 MSR 리딩시
      else if vBool and Assigned(CashRcp_F) and CashRcp_F.Showing then
      begin
        CashRcp_F.MsrData := Common.PrinterInData;;
        CashRcp_F.SetMsrData;
      end
      {숫자입력폼에서 MSR을 읽었을때}
      else if vBool and Assigned(NumPan_F) and NumPan_F.Showing then
      begin
        NumPan_F.InputEdit.Text := Common.PrinterInData;
      end
      {주문폼에서 카드를 꽂았을때}
      else if vBool and Assigned(Order_F) and Order_F.Showing then
      begin
        if ((GetOption(379)='0')) and not (Common.Config.van_trd in [vanKIS, vanJTNET]) then Exit;
        //JTNET 카드이벤트로 받았을때
        if (Pos(#3, Common.PrinterInData) > 0) and (Common.Config.van_trd = vanJTNET) and ((Pos('~0092',Common.PrinterInData) > 0 ) or (Pos('~0023',Common.PrinterInData) > 0 )) then
        begin
          //다중사업자일때는 카드승인 폼에 있을때는 패스
          if GetOption(60) = '1' then
          begin
            Order_F.Action35.Tag := 1;
            Common.Config.Options[60] := '0';
          end;

          if (Copy(Common.PrinterInData,10,1) = '0') or (Copy(Common.PrinterInData,10,1) = '1') then
            Common.PrinterInData := Copy(Common.PrinterInData,10,1)+#3
          else
          begin
            vCount := StoI(Copy(Common.PrinterInData,10,1));
            if vCount = 0 then
              Common.PrinterInData := '1'+#3
            else
            begin
              vStr := Copy(Common.PrinterInData,11,vCount*17);
              Common.PrinterInData := EmptyStr;
              for vIndex := 1 to vCount do
              begin
                Common.PrinterInData := Common.PrinterInData + Copy(vStr,2, 16);
                Delete(vStr,1,17);
              end;
              Common.PrinterInData := 'AID'+IntToStr(vCount)+Common.PrinterInData;
            end;
          end;
        end;

        if (GetOption(379) = '1') and not (Common.Config.van_trd in [vanJTNET, vanKIS]) then Exit;
        if (Common.Config.van_trd in [vanKIS, vanJTNET]) then
        begin
          //이번거래만 단말기 연동으로 사용하기 위함
          Common.Config.Options[379]   := '1';
          if Common.Config.van_trd = vanKIS then
            Common.PrinterInData        := '1'+#3;
        end;

        Order_F.FCardData := Common.PrinterInData;
        Order_F.Tmr_Card.Enabled := True;
      end;
    finally
      Common.PrinterInData := EmptyStr;
    end;
  end;
end;

procedure TDevice.Link2RxChar(Com: TObject; Buffer: Pointer; Received: Cardinal);
var vReadData :AnsiString;
    vIndex  :Integer;
begin
  for vIndex := 0 to Received - 1 do
    vReadData := vReadData + PAnsiChar(Buffer)[vIndex];

  Link2PortData := Link2PortData + vReadData;
  if (Pos(#27'i', Link2PortData) > 0) or (Pos(#27'm', Link2PortData) > 0) or (Pos(#1, Link2PortData) > 0) then
  begin
    Common.WriteLog('work',Link2PortData);
    PrintData     := Link2PortData;
    PrintData     := Replace(PrintData, #$D,'');
    PrintPrinter(rptLink2);
    PrintData     := EmptyStr;
    Link2PortData := EmptyStr;
  end;
end;

procedure TDevice.Link3RxChar(Com: TObject; Buffer: Pointer; Received: Cardinal);
var vReadData :AnsiString;
    vIndex  :Integer;
begin
  for vIndex := 0 to Received - 1 do
    vReadData := vReadData + PAnsiChar(Buffer)[vIndex];

  Link3PortData := Link3PortData + vReadData;
  if (Pos(#27'i', Link3PortData) > 0) or (Pos(#27'm', Link3PortData) > 0) or (Pos(#1, Link3PortData) > 0) then
  begin
    Common.WriteLog('work',Link3PortData);
    PrintData     := Link3PortData;
    PrintData     := Replace(PrintData, #$D,'');
    PrintPrinter(rptLink2);
    PrintData     := EmptyStr;
    Link3PortData := EmptyStr;
  end;
end;

procedure TDevice.Link4RxChar(Com: TObject; Buffer: Pointer; Received: Cardinal);
var vReadData :AnsiString;
    vIndex  :Integer;
begin
  for vIndex := 0 to Received - 1 do
    vReadData := vReadData + PAnsiChar(Buffer)[vIndex];

  Link4PortData := Link4PortData + vReadData;
  if (Pos(#27'i', Link4PortData) > 0) or (Pos(#27'm', Link4PortData) > 0) or (Pos(#1, Link4PortData) > 0) then
  begin
    Common.WriteLog('work',Link4PortData);
    PrintData     := Link4PortData;
    PrintData     := Replace(PrintData, #$D,'');
    PrintPrinter(rptLink2);
    PrintData     := EmptyStr;
    Link4PortData := EmptyStr;
  end;
end;



procedure TDevice.LinkRxChar(Com: TObject; Buffer: Pointer; Received: Cardinal);
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
        vTemp := Replace(vTemp, #$A#$D, #$D);
        vTemp := Replace(vTemp, #$A,    #$D);
        while vTemp <> '' do
        begin
          vIndex := Pos(#$D,vTemp);
          if vIndex > 0 then
          begin
             vOrderData.Add(Copy(vTemp,1,vIndex-1));
             Delete(vTemp,1,vIndex);
          end
          else
          begin
             vOrderData.Add(vTemp);;
             vTemp :='';
          end;
        end;

        for vIndex := 0 to vOrderData.Count-1 do
        begin
          vOrderData.Strings[vIndex] := Replace(vOrderData.Strings[vIndex], #$A, '');
          vOrderData.Strings[vIndex] := Replace(vOrderData.Strings[vIndex], #$1B, '');
          vOrderData.Strings[vIndex] := Replace(vOrderData.Strings[vIndex], 'E'#1, '');
          vOrderData.Strings[vIndex] := Replace(vOrderData.Strings[vIndex], 'E'#0, '');
          vOrderData.Strings[vIndex] := Replace(vOrderData.Strings[vIndex], '!'#0, '');
          vOrderData.Strings[vIndex] := Replace(vOrderData.Strings[vIndex], '!'#$18, '');
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
            vOrderNo   := Copy(vOrderData.Strings[vIndex],10,12);
            if vOrderData.Strings[vIndex+1] <> '' then
              vOrderDate := GetOnlyNumber(Copy(vOrderData.Strings[vIndex+1],1,20))
            else
              vOrderDate := GetOnlyNumber(Copy(vOrderData.Strings[vIndex+2],1,20));
            vOrderDate := FormatMaskText('!0000-00-00 00:00;0; ',vOrderDate);
          end;

          if (Pos('배달주소:', vOrderData.Strings[vIndex]) > 0) then
          begin
            vAddr1 := vOrderData.Strings[vIndex+2] ;
            //주소가 두줄일때
            if Pos('연락처:',vOrderData.Strings[vIndex+4]) = 0 then
            begin
              vAddr2 := vOrderData.Strings[vIndex+3];
            end;
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
            vOrderAmt   := StrToInt(GetOnlyNumber(vOrderData.Strings[vIndex]));
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
              vMenuList^.Name   := Trim(Copy(vOrderData.Strings[vIndex],1,25));
              vMenuList^.Memo   := '';
              vMenuList^.Qty    := StrToIntDef(GetOnlyNumber(Copy(vOrderData.Strings[vIndex],26,3)),1);
              vMenuList^.Amount := StrToIntDef(GetOnlyNumber(Copy(vOrderData.Strings[vIndex],29,14)),0);
              vMenuList^.Price  := vMenuList^.Amount div Ifthen(vMenuList^.Qty=0,1,vMenuList^.Qty);
              vPos := vIndex;
            end
            else
            begin
              vMenuList^.Name   := vOrderData.Strings[vIndex];
              vMenuList^.Memo   := '';
              vMenuList^.Qty    := StrToIntDef(GetOnlyNumber(Copy(vOrderData.Strings[vIndex+1],26,3)),1);
              vMenuList^.Amount := StrToIntDef(GetOnlyNumber(Copy(vOrderData.Strings[vIndex+1],29,14)),0);
              vMenuList^.Price  := vMenuList^.Amount div Ifthen(vMenuList^.Qty=0,1,vMenuList^.Qty);
              vPos := vIndex + 1;
            end;
            vPos2 := vPos;

            //메모가 있는지 확인                                                            //금액이 있는지 체크
            if (vPos+1 < vMenuPosEnd) and (Copy(vOrderData.Strings[vPos+1],2,1) = '+') and (Pos('0원)',vOrderData.Strings[vPos+1]) = 0) then
            begin
              vPos2 := vPos + 1;
              vMenuList^.Memo   := ' '+Trim(vOrderData.Strings[vPos+1])+#13;
              if (vPos+2 < vMenuPosEnd) and (Copy(vOrderData.Strings[vPos+2],2,1) = '+') and (Pos('0원)',vOrderData.Strings[vPos+2]) = 0) then
              begin
               vPos2 := vPos + 2;
                vMenuList^.Memo   := vMenuList^.Memo + ' '+Trim(vOrderData.Strings[vPos+2])+#13;
                if (vPos+3 < vMenuPosEnd) and (Copy(vOrderData.Strings[vPos+3],2,1) = '+') and (Pos('0원)',vOrderData.Strings[vPos+3]) = 0) then
                begin
                  vPos2 := vPos + 3;
                  vMenuList^.Memo   := vMenuList^.Memo + ' '+Trim(vOrderData.Strings[vPos+3])+#13;
                  if (vPos+4 < vMenuPosEnd) and (Copy(vOrderData.Strings[vPos+4],2,1) = '+') and (Pos('0원)',vOrderData.Strings[vPos+4]) = 0) then
                  begin
                    vPos2 := vPos + 4;
                    vMenuList^.Memo   := vMenuList^.Memo +' '+ Trim(vOrderData.Strings[vPos+4])+#13;
                    if (vPos+5 < vMenuPosEnd) and (Copy(vOrderData.Strings[vPos+5],2,1) = '+') and (Pos('0원)',vOrderData.Strings[vPos+5]) = 0) then
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
              if (vPos2+vIndex2 < vMenuPosEnd) and (Copy(vOrderData.Strings[vPos2+vIndex2],2,1) = '+') and (Pos('0원)',vOrderData.Strings[vPos2+vIndex2]) > 0) then
              begin
                New(vMenuList);
                vMenuList^.Code        := '';
                vMenuList^.Item        := '';
                vMenuList^.Step        := 0;
                vMenuList^.TotalItem   := '';
                //부메뉴는 수량과 금액 없어 전부를 메뉴명으로 처리한다
                vMenuList^.Name   := Trim(Copy(vOrderData.Strings[vPos2+vIndex2],3,50));
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
    vTableMemo :String;
begin
  for vIndex := 0 to Received - 1 do
    vReadData := vReadData + PAnsiChar(Buffer)[vIndex];

  LinkPortData := LinkPortData + vReadData;
  //라이더콜일때는 출력만 한다
  if Pos('EXPOS', LinkPortData) > 0 then
  begin
    LinkPortData := '';
    Exit;
  end;

  if (Pos(#27'i', LinkPortData) > 0) or (Pos(#27'm', LinkPortData) > 0) then
  begin
    PrintData := LinkPortData;
    if  (Common.Config.BaeminMenuCode <> '') then
    begin
      vTableNo := SetBaeminOrder(vDeliverNo, vAddress, vTableMemo, vNoMathAmt, PrintData);
      if (vTableNo > 0) and Common.Config.BaeminKitchPrint then
        BaeminKitchPrint(vTableNo, vDeliverNo, vAddress, vTableMemo);
    end;
    //배민 전표를 출력한다고 했을때, 매칭되지 않는 메뉴가 있을때
    if (GetOption(444) = '0') or (vNoMathAmt <> 0) or not Assigned(DeliveryNew_F) then
    begin
      PrintData := LinkPortData;
      PrintData := Replace(PrintData, #$D,'');
      PrintPrinter(rptLink);
    end;
    PrintData    := EmptyStr;
    LinkPortData := EmptyStr;
    if (GetOption(443)='1') and Assigned(DeliveryNew_F)  then
      DeliveryNew_F.BaeminDeliveryPrint(vDeliverNo);
  end;
end;


//전화가 왔을때 플래그
//I :전화가 왔을때          ( ex) 1I01012345678
//S :전화가 받았을때        ( ex) 1S01012345678
//E :수화기를 놔서 끊었을때 ( ex) 1E01012345678
//A :전화가 끊겼을때        ( ex) 1A
procedure TDevice.CidRxChar(Com: TObject; Buffer: Pointer; Received: Cardinal);
var
  vTempBuff : AnsiString;
  vTemp, vTemp1    : AnsiString;
  vIndex :Integer;
begin
  for vIndex := 0 to Received - 1 do
    vTempBuff := vTempBuff + PAnsiChar(Buffer)[vIndex];

  FCidBuff := FCidBuff + vTempBuff;
  Common.WriteLog('work', Format('%s - %s',[vTempBuff,FCidBuff]));

  if not isCIDCheck and (CharCnt(FCidBuff, #3) > 0) then
  begin
    if Pos('A', FCidBuff) > 0 then
    begin
      vTempBuff := '';
      FCidBuff := '';
      Exit;
    end;
    if (CharCnt(FCidBuff, #3) = 1) then
    begin
      FCidBuff := LeftStr(FCidBuff,3)+ GetOnlyNumber(Copy(FCidBuff,4,20));
      //배달을 테이블형태로 사용할때
      if GetOption(368) = '0' then
      begin
        if (Copy(FCidBuff,3,1) = 'I') or (Copy(FCidBuff,3,1) = 'S') then
          ExecuteCID(FCidBuff);
        FCidBuff := EmptyStr;
      end
      else
      begin
        ExecuteCID(FCidBuff);
        FCidBuff := EmptyStr;
      end;                                                                                                     
    end
    else if (CharCnt(FCidBuff, #3) > 1) then
    begin
      vTemp     := FCidBuff;
      FCidBuff  := EmptyStr;
      repeat
        vTemp1   := Copy(vTemp,1,Pos(#3,vTemp));
        try
          vTemp1 := LeftStr(vTemp1,3)+ GetOnlyNumber(Copy(vTemp1,4,20));
          if GetOption(368) = '0' then
          begin
            if (Copy(FCidBuff,3,1) = 'I') or (Copy(FCidBuff,3,1) = 'S') then
              ExecuteCID(vTemp1);
          end
          else
            ExecuteCID(vTemp1);
        finally
          Delete(vTemp, 1, Pos(#3, vTemp));
        end;
      until vTemp = '' ;
    end;
  end;
end;

procedure TDevice.ExecuteCID(aData:String);
var vTelNo :String;
    vIndex :Integer;
var vQuery :TUniQuery;
begin
  vQuery := TUniQuery.Create(Application);
  vQuery.Connection := DM.UniConnection;
  aData := StringReplace(aData,#2,'',[rfReplaceAll]);
  aData := StringReplace(aData,#3,'',[rfReplaceAll]);

  if Copy(aData,2,1) = 'A' then Exit;
  //국이 없이 4자리만 올때
  if (Length(aData) = 6) and (Trim(Common.Config.FixPhoneNo) <> '') then
    aData := LeftStr(aData,2) + Trim(Common.Config.FixPhoneNo) + RightStr(aData,4);
  FCidData := 'C'+Trim(aData);


  //콜스타일때 수화기를 들었을때 전화가 끊긴 상태에서 받았을때
  if ((FCidData[1] = 'C') and (FCidData[3] = 'S') and (FCidTimeOut)) or ((FCidData[3] <> 'A') and (Length(FCidData) < 8)) then
  begin
    FCidTimeOut       := False;
    FCidBuff := '';
    Exit;
  end;

  //전화번호가 정상인지 체크
  vTelNo := GetOnlyNumber(Copy(FCidData,4,12));
  if (FCidData[3] = 'I') and ((LeftStr(vTelNo,3) = '010') or (LeftStr(vTelNo,3) = '070')) and (Length(vTelNo) = 10) then
  begin
    OpenQuery(vQuery, 'select NO_TEL1 '
                     +'  from SL_DELIVERY '
                     +' where CD_STORE =:P0 '
                     +'   and Left(NO_TEL1,3) = :P2 '
                     +'   and (Right(NO_TEL1,8) like ConCat(''%'',:P1) '
                     +'     or Right(NO_TEL1,8) like ConCat(Left(:P1,1),''%'',Right(:P1,6)) '
                     +'     or Right(NO_TEL1,8) like ConCat(Left(:P1,2),''%'',Right(:P1,5)) '
                     +'     or Right(NO_TEL1,8) like ConCat(Left(:P1,3),''%'',Right(:P1,4)) '
                     +'     or Right(NO_TEL1,8) like ConCat(Left(:P1,4),''%'',Right(:P1,3)) '
                     +'     or Right(NO_TEL1,8) like ConCat(Left(:P1,2),''%'',Right(:P1,2)) '
                     +'     or Right(NO_TEL1,8) like ConCat(Left(:P1,1),''%'',Right(:P1,6)) '
                     +'     or Right(NO_TEL1,8) like ConCat(:P1,''%'')) '
                     +'limit 1 ',
                     [Common.Config.StoreCode,
                      Copy(FCidData, 7, 7),
                      LeftStr(vTelNo,3)]);
    if not vQuery.Eof then
    begin
      if Common.AskBox(Format('CID장비에서 전화번호가 누락되었습니다'#13#13'%s 전화번호가 맞습니까?',[SetTelephone(vQuery.Fields[0].AsString)])) then
      begin
        Common.CIDReplaceList.Add(LeftStr(vTelNo,3)+Copy(FCidData, 7, 7)+' '+vQuery.Fields[0].AsString);
        FCidData := LeftStr(FCidData,3) + vQuery.Fields[0].AsString;
      end
      else
      begin
        Common.ErrBox( '배달주문을 수동으로 접수해야합니다');
        Exit;
      end;
    end
    else
    begin
      Common.MsgBox('CID에서 일부전화번호가 누락되었습니다'#13#13'배달주문을 수동으로 접수해야합니다');
      Exit;
    end;
    vQuery.Close;
  end;

  if (FCidData[3] = 'I') and (Copy(FCidData,4,2) = '02') and (Length(Copy(FCidData,6,10)) < 7) then
  begin
    Common.MsgBox('CID에서 일부전화번호가 누락되었습니다'#13#13'배달주문을 수동으로 접수해야합니다');
    Exit;
  end;

  if (FCidData[3] = 'I') and (Copy(FCidData,4,2) <> '02') and (Copy(FCidData,4,2) <> '01') and (Copy(FCidData,4,2) <> '05') and (Copy(FCidData,4,2) <> '07') and (Length(Copy(FCidData,6,10)) < 7) then
  begin
    Common.MsgBox('CID에서 일부전화번호가 누락되었습니다'#13#13'배달주문을 수동으로 접수해야합니다');
    Exit;
  end;

  if (FCidData[3] in ['S','A','E']) and (Copy(FCidData,4,2) = '02') and (Length(Copy(FCidData,6,10)) < 7) then
  begin
    Exit;
  end;

  if (FCidData[3] in ['S','A','E']) and (Copy(FCidData,4,2) <> '02') and (Copy(FCidData,4,2) <> '01') and (Copy(FCidData,4,2) <> '05') and  (Copy(FCidData,4,2) <> '07') and (Length(Copy(FCidData,6,10)) < 7) then
  begin
    Exit;
  end;

  //수화기를 들었을때는 로그를 저장하지 않는다
  if FCidData[3] = 'I' then
  begin
    try
      //가끔 앞에 '0'이 빠져서 오는경우가 있어 맨앞자가 '0'이 아니면 '0'을 붙여준다
      if FCidData[4] <> '0' then
        FCidData := LeftStr(FCidData,3)+'0'+RightStr(FCidData, Length(FCidData)-3);

      ExecQuery('insert into SL_CID_LOG(CD_STORE, NO_TEL, NO_LINE, DT_CALL, YMD_CALL) '
               +'                values(:P0, :P1, :P2, Now(), Date_Format(Now(), ''%Y%m%d''))',
               [Common.Config.StoreCode,
                Copy(FCidData, 4, 12),
                StrToIntDef(Copy(FCidData, 2, 1),1)]);
    except
    end;
  end;

  FCidTimer.Enabled := True;
  FCidTimeOut       := False;
  //전화가 끊긴 상태에서 수화기를 들었을때를 체크하기 위함
  FCidTimeOutTimer.Enabled := True;
end;

procedure TDevice.CheckRxChar(Com: TObject; Buffer: Pointer; Received: Cardinal);
var vStr :String;
    vIndex :Integer;
begin
  for vIndex := 0 to Received - 1 do
    vStr := vStr + PAnsiChar(Buffer)[vIndex];

  CheckData := CheckData + vStr;
  if (Pos(#3, CheckData) > 0) or (LengthB(CheckData) > 30) then
  begin
    try
      if Assigned(Check_F) and Check_F.Showing then
      begin
        Check_F.Number1Edit.Text := RightStr(CopyPos(CheckData,'<',0),8);
        Check_F.Number2Edit.Text := RightStr(CopyPos(CheckData,'=',0),2);
        Check_F.Number3Edit.Text := RightStr(CopyPos(CheckData,':',0),4);
        Check_F.Number4Edit.Text := RightStr(CopyPos(CheckData,';',0),2);
        CheckData := EmptyStr;
        Check_F.SearchButtonClick(nil);
      end;
    finally
      CheckData := EmptyStr;
    end;
  end;
end;

procedure TDevice.ScannerRxChar(Com: TObject; Buffer: Pointer; Received: Cardinal);
var
  i, vIndex : Integer;
  vReadData : String;
begin
  for vIndex := 0 to Received - 1 do
    vReadData := vReadData + PAnsiChar(Buffer)[vIndex];

  FScannerBuff := FScannerBuff + vReadData;
  i := Pos(#13, FScannerBuff);
  if i = 0 then
    i := Pos(#3, FScannerBuff);
  if (Length(FScannerBuff) > 0) and ((FScannerBuff[1] = #2) or (FScannerBuff[1] = #10)) then
    System.Delete(FScannerBuff, 1, 1);
  if i > 0 then
  begin
    FScannerBuff := Replace(FScannerBuff, #2, '');
    FScannerBuff := Replace(FScannerBuff, #3, '');
    FScannerData := Copy(FScannerBuff, 1, i - 1);
    FScannerTimer.Enabled := True;
    FScannerBuff := '';
  end;
end;

// aType - 0:주문서 헤더가 필요없을때
procedure TDevice.PrintPrinter(aType:Integer=0);
  procedure InitPort;
  var
   aTimeOut : TCommTimeouts;
   bSuccess : boolean;
  begin
     LPTFile := CreateFile(PChar('LPT1'), GENERIC_WRITE, 0,nil,OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
     if GetCommTimeouts(LPTFile,aTimeOut) then
     begin
       aTimeOut.WriteTotalTimeoutMultiplier := 200;   // 200
       aTimeOut.WriteTotalTimeoutConstant   := 4000;   // 4000
       SetCommTimeouts(LPTFile,aTimeOut);
       bSuccess := SetCommTimeouts(LPTFile,aTimeOut);
     end;
  end;

 function GetKitchenPrinterIndex(aCode:String):Integer;
 var I :Integer;
 begin
    Result := -1;
    For I := 0 to High(Common.KitchenPrinter) do
    begin
      if Common.KitchenPrinter[I].Code = aCode then
      begin
        Result := I;
        Break;
      end;
    end;
 end;

  procedure SaveFile(aData:String);
  var
    FileName, VANName,
    LogPath: String;
  begin
    // 파일 불러오기
    with TStringList.Create do
      try
        FileName := Common.AppPath+'PrintData.dat';
        if FileExists(FileName) then DeleteFile(FileName);
        Add(aData);
        SaveToFile(FileName);
      finally
        Free;
      end; // try .. finally ..
  end;

  function GetXorData(aData: string): string;
  var
    vI: Integer;
  begin
    Result := aData[1];
    for vI := 2 to LengthB(aData) do
      Result := Chr(Ord(Result[1]) xor Ord(aData[vI]));
  end;

  function GetLRCData(aData:String):String;
  var vI: Integer;
  begin
    Result := aData[1];
    for vI := 2 to LengthB(aData) do
      Result := Chr(Ord(Result[1]) xor Ord(aData[vI]));

    Result := Chr(Ord(Result[1]) or $20);
  end;

  function isCatKitchen:Boolean;
  var vIndex :Integer;
  begin
    Result := false;
    if not Common.isReceiptToKitehcn then Exit;
    if GetKitchenPrinterIndex(Common.Config.CustPrinterCode) < 0 then Exit;
    if Common.Config.PosNo <> Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.CustPrinterCode)].LinkPOS then Exit;
    vIndex := Common.GetKitchenIndex(1, 1, Common.Config.PosIP);
    if Common.Config.CustPrinterCode <> Common.KitchenPrinter[vIndex].Code then Exit;
    Result := true;
  end;

  procedure RealPrint(aPrintData:AnsiString);
  var  vPrn         : TextFile;
  begin
    try
      PrintComPort.Active := false;
      Sleep(1000);
      AssignFile(vPrn, Format('COM%d', [Common.Config.ReceiptPrinterPort]));
      rewrite(vPrn);
      writeln(vPrn, aPrintData);
    finally
      closeFile(vPrn);
    end;
  end;
var
    vTemp,vRtn, vPrintData :AnsiString;
    vIdx, vCol   :Integer;
    BytesWritten : DWORD;
    Hnd :THandle;
    Data     : TCOPYDATASTRUCT;
    vIndex :Integer;
    vData  :String;
    vPos   :Integer;
    vSystemPath :String;
    vFailCount :Integer;
    pGetData : Array[0..4096] of Char;
    vGetTime  : Cardinal;    
label go_kitchen;
label go_receipt;
label go_receipt2;  //배달관련출력을 주방과 영수증프린터를 같이 쓸때
label go_customer;
label go_delivery;
label go_link;
label go_link2;
label go_deliveryreceipt;
begin
  vFailCount := 0;
  vGetTime := GetTickCount;
  while IsPrinting and (vGetTime + 3000 > GetTickCount) do Application.ProcessMessages;
  try
    IsPrinting := True;
    case aType of
      rptNone,
      rptLink, rptLink2    : vPrintData := PrintData;
      rptLetsOrder :
      begin
        vPrintData := PrinterCommendReplace(PrintData,
                                            Common.Config.ReceiptPrinterDev,
                                            Common.Config.PrintColum,
                                            Common.Config.PrintBottomMargin);
      end;
      rptReceipt :
      begin
        For vIdx := 0 to Common.PrintBuffer.Count-1 do
        begin
          if Common.PrintBuffer.Strings[vIdx] <> '' then
            vPrintData := vPrintData + PrinterCommendReplace(Common.PrintBuffer.Strings[vIdx],
                                                             Common.Config.ReceiptPrinterDev,
                                                             Common.Config.PrintColum,
                                                             Common.Config.PrintBottomMargin);
        end;
        if vPrintData = EmptyStr then vPrintData := PrintData;
      end;
      else
      begin
        //고객주문서를 영수증프린터에 출력하지 않을때는 설정된 주방프린터의 기종을 찾는다
        if (Common.Config.CustPrinterCode <> '000') and not isCatKitchen and (GetKitchenPrinterIndex(Common.Config.CustPrinterCode) >=0 ) then
          vPrintData := PrinterCommendReplace(PrintData,
                                              Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.CustPrinterCode)].Device,
                                              Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.CustPrinterCode)].Col,
                                              Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.CustPrinterCode)].BottomMargin)
        else
          vPrintData := PrinterCommendReplace(PrintData,
                                              Common.Config.ReceiptPrinterDev,
                                              Common.Config.PrintColum,
                                              Common.Config.PrintBottomMargin);
      end;
    end;
    if vPrintData = '' then Exit;


    //고객주문서를 영수증프린터에 출력하지 않을때
    if (aType = rptCustOrder) and (Common.Config.CustPrinterCode <> '000') and not isCatKitchen then
    begin
      go_customer:
      Common.ShowWaitForm;
      if Common.isReceiptToKitehcn and Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.CustPrinterCode)].Link then
      begin
        goto go_receipt2;
        Common.HideWaitForm;
      end
      else
        vRtn := OrderSend('1',
                           Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.CustPrinterCode)].Code,
                           vPrintData,
                           Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.CustPrinterCode)].IP,
                           ifThen(Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.CustPrinterCode)].Port = 'E',
                                  Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.CustPrinterCode)].EthernetIP,
                                  Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.CustPrinterCode)].Port)
                           );

      if (Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.CustPrinterCode)].Port = 'E') and (vRtn <> 'OK') and (vFailCount = 0) then
      begin
        Inc(vFailCount);
        goto go_customer;
      end;
      Common.HideWaitForm;
      if vRtn <> 'OK' then
      begin
        if Common.AskBox('[ 고객주문서 ]'+#13+Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.CustPrinterCode)].Name+' 프린터에'+#13+
                         ' 출력하지 못했습니다'+#13+
                         '다시시도 하시겠습니까?') then
        begin
          Inc(vFailCount);
          goto go_customer;
        end;
      end;
      Exit;
    end;

    //배달전표를 영수증프린터에 출력하지 않을때
    if (aType = rptDelivery) and (Common.Config.DeliveryPrinterCode <> '000') and not isCatKitchen then
    begin
      go_delivery:
      Common.ShowWaitForm;
      if Common.isReceiptToKitehcn and Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.DeliveryPrinterCode)].Link then
      begin
        goto go_receipt2;
        Common.HideWaitForm;
      end
      else
        vRtn := OrderSend('1',
                           Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.DeliveryPrinterCode)].Code,
                           vPrintData,
                           Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.DeliveryPrinterCode)].IP,
                           ifThen(Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.DeliveryPrinterCode)].Port = 'E',
                                  Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.DeliveryPrinterCode)].EthernetIP,
                                  Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.DeliveryPrinterCode)].Port)
                           );

      if (Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.DeliveryPrinterCode)].Port = 'E') and (vRtn <> 'OK') and (vFailCount = 0) then
      begin
        Inc(vFailCount);
        goto go_delivery;
      end;

      Common.HideWaitForm;
      if vRtn <> 'OK' then
      begin
        if Common.AskBox('[ 배달전표 ]'+#13+Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.DeliveryPrinterCode)].Name+' 프린터에'+#13+
                         ' 출력하지 못했습니다'+#13+
                         '다시시도 하시겠습니까?') then
        begin
          Inc(vFailCount);
          goto go_delivery;
        end;
      end;
      Exit;
    end;

    //배달고객영수증을 영수증프린터에 출력하지 않을때
    if (aType = rptDeliveryReceipt) and (Common.Config.DeliveryReceiptPrinterCode <> '000') and not isCatKitchen then
    begin
      go_deliveryreceipt:
      Common.ShowWaitForm;
      if Common.isReceiptToKitehcn and Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.DeliveryReceiptPrinterCode)].Link then
      begin
        goto go_receipt2;
        Common.HideWaitForm;
      end
      else
        vRtn := OrderSend('1',
                           Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.DeliveryReceiptPrinterCode)].Code,
                           vPrintData,
                           Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.DeliveryReceiptPrinterCode)].IP,
                           ifThen(Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.DeliveryReceiptPrinterCode)].Port = 'E',
                                  Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.DeliveryReceiptPrinterCode)].EthernetIP,
                                  Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.DeliveryReceiptPrinterCode)].Port)
                           );

      if (Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.DeliveryReceiptPrinterCode)].Port = 'E') and (vRtn <> 'OK') and (vFailCount = 0) then
      begin
        Inc(vFailCount);
        goto go_deliveryreceipt;
      end;
      Common.HideWaitForm;
      if vRtn <> 'OK' then
      begin
        if Common.AskBox('[ 배달전표 ]'+#13+Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.DeliveryReceiptPrinterCode)].Name+' 프린터에'+#13+
                         ' 출력하지 못했습니다'+#13+
                         '다시시도 하시겠습니까?') then
        begin
          Inc(vFailCount);
          goto go_deliveryreceipt;
        end;
      end;
      Exit;
    end;

    //배달의 민족 연결포트
    if (aType = rptLink) and (Common.Config.LinkPrinterCode <> '000') and not isCatKitchen then
    begin
      go_Link:
      Common.ShowWaitForm;
      if Common.isReceiptToKitehcn and Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.LinkPrinterCode)].Link then
      begin
        goto go_receipt2;
        Common.HideWaitForm;
      end
      else
        vRtn := OrderSend('1',
                           Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.LinkPrinterCode)].Code,
                           vPrintData,
                           Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.LinkPrinterCode)].IP,
                           ifThen(Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.LinkPrinterCode)].Port = 'E',
                                  Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.LinkPrinterCode)].EthernetIP,
                                  Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.LinkPrinterCode)].Port)
                           );

      if (Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.LinkPrinterCode)].Port = 'E') and (vRtn <> 'OK') and (vFailCount = 0) then
      begin
        Inc(vFailCount);
        goto go_Link;
      end;

      Common.HideWaitForm;
      if vRtn <> 'OK' then
      begin
        if Common.AskBox('[ 배달전표 ]'+#13+Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.LinkPrinterCode)].Name+' 프린터에'+#13+
                         ' 출력하지 못했습니다'+#13+
                         '다시시도 하시겠습니까?') then
        begin
          Inc(vFailCount);
          goto go_Link;
        end;
      end;
      Exit;
    end;

    //요기요 연결포트
    if (aType = rptLink2) and (Common.Config.Link2PrinterCode <> '000') and not isCatKitchen then
    begin
      go_Link2:
      Common.ShowWaitForm;
      if Common.isReceiptToKitehcn and Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.Link2PrinterCode)].Link then
      begin
        goto go_receipt2;
        Common.HideWaitForm;
      end
      else
        vRtn := OrderSend('1',
                           Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.Link2PrinterCode)].Code,
                           vPrintData,
                           Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.Link2PrinterCode)].IP,
                           ifThen(Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.Link2PrinterCode)].Port = 'E',
                                  Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.Link2PrinterCode)].EthernetIP,
                                  Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.Link2PrinterCode)].Port)
                           );

      if (Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.Link2PrinterCode)].Port = 'E') and (vRtn <> 'OK') and (vFailCount = 0) then
      begin
        Inc(vFailCount);
        goto go_Link2;
      end;

      Common.HideWaitForm;
      if vRtn <> 'OK' then
      begin
        if Common.AskBox('[ 요기요전표 ]'+#13+Common.KitchenPrinter[GetKitchenPrinterIndex(Common.Config.Link2PrinterCode)].Name+' 프린터에'+#13+
                         ' 출력하지 못했습니다'+#13+
                         '다시시도 하시겠습니까?') then
        begin
          Inc(vFailCount);
          goto go_Link2;
        end;
      end;
      Exit;
    end;

    //주방프린터를 영수증프린터로 쓸때
    if Common.Config.RcpToKitchen and not Common.isReceiptToKitehcn and not Common.KitchenPrinter[Common.Config.KitchenIndex].Link then
    begin
      go_kitchen:
      Common.ShowWaitForm;
      vRtn := OrderSend('3',
                         Common.KitchenPrinter[Common.Config.KitchenIndex].Code,
                         vPrintData,// StrToBin(vPrintData), //Tohex(ToBytes(vPrintData)),
                         Common.KitchenPrinter[Common.Config.KitchenIndex].IP,
                         ifThen(Common.KitchenPrinter[Common.Config.KitchenIndex].Port = 'E',
                                Common.KitchenPrinter[Common.Config.KitchenIndex].EthernetIP,
                                Common.KitchenPrinter[Common.Config.KitchenIndex].Port)
                         );

      if (Common.KitchenPrinter[Common.Config.KitchenIndex].Port = 'E') and (vRtn <> 'OK') and (vFailCount = 0) then
      begin
        Inc(vFailCount);
        goto go_kitchen;
      end;

      Common.HideWaitForm;
      case aType of
        rptReceipt, rptReceipt1 :
          if vRtn <> 'OK' then
          begin
            if Common.AskBox('영수증을 출력하지 못했습니다'+#13+
                                  '다시시도 하시겠습니까?') then
            begin
              Inc(vFailCount);
              goto go_kitchen;
            end;
          end;
        rptCustOrder :
          if vRtn <> 'OK' then
          begin
            if Common.AskBox('[ 고객주문서 ]'+#13+Common.KitchenPrinter[Common.Config.KitchenIndex].Name+' 프린터에'+#13+
                             ' 출력하지 못했습니다'+#13+
                             '다시시도 하시겠습니까?') then
            begin
              Inc(vFailCount);
              goto go_kitchen;
            end;
          end;
        rptDelivery :
          if vRtn <> 'OK' then
          begin
            if Common.AskBox('[ 배달전표 ]'+#13+Common.KitchenPrinter[Common.Config.KitchenIndex].Name+' 프린터에'+#13+
                             ' 출력하지 못했습니다'+#13+
                             '다시시도 하시겠습니까?') then
            begin
              Inc(vFailCount);
              goto go_kitchen;
            end;
          end;
        rptDeliveryReceipt :
          if vRtn <> 'OK' then
          begin
            if Common.AskBox('[ 배달영수증 ]'+#13+Common.KitchenPrinter[Common.Config.KitchenIndex].Name+' 프린터에'+#13+
                             ' 출력하지 못했습니다'+#13+
                             '다시시도 하시겠습니까?') then
            begin
              Inc(vFailCount);
              goto go_kitchen;
            end;
          end;

        rptNotTel :
          if vRtn <> 'OK' then
          begin
            if Common.AskBox('[ 배달수기주문서 ]'+#13+Common.KitchenPrinter[Common.Config.KitchenIndex].Name+' 프린터에'+#13+
                             ' 출력하지 못했습니다'+#13+
                             '다시시도 하시겠습니까?') then
            begin
              Inc(vFailCount);
              goto go_kitchen;
            end;
          end;
        rptParking :
          if vRtn <> 'OK' then
          begin
            if Common.AskBox('[ 주차확인증 ]'+#13+Common.KitchenPrinter[Common.Config.KitchenIndex].Name+' 프린터에'+#13+
                             ' 출력하지 못했습니다'+#13+
                             '다시시도 하시겠습니까?') then
            begin
              Inc(vFailCount);
              goto go_kitchen;
            end;
          end;
        rptSaleRpt :
          if vRtn <> 'OK' then
          begin
            if Common.AskBox('[ 매출현황 ]'+#13+Common.KitchenPrinter[Common.Config.KitchenIndex].Name+' 프린터에'+#13+
                             ' 출력하지 못했습니다'+#13+
                             '다시시도 하시겠습니까?') then
            begin
              Inc(vFailCount);
              goto go_kitchen;
            end;
          end;

        rptCoupon :
          if vRtn <> 'OK' then
          begin
            if Common.AskBox('[ 영수증쿠폰 ]'+#13+Common.KitchenPrinter[Common.Config.KitchenIndex].Name+' 프린터에'+#13+
                             ' 출력하지 못했습니다'+#13+
                             '다시시도 하시겠습니까?') then
            begin
              Inc(vFailCount);
              goto go_kitchen;
            end;
          end;
        rptUPSS :
          if vRtn <> 'OK' then
          begin
            if Common.AskBox('[ 위해상품차단 ]'+#13+Common.KitchenPrinter[Common.Config.KitchenIndex].Name+' 프린터에'+#13+
                             ' 출력하지 못했습니다'+#13+
                             '다시시도 하시겠습니까?') then
            begin
              Inc(vFailCount);
              goto go_kitchen;
            end;
          end;
        rptTicket :
          if vRtn <> 'OK' then
          begin
            if Common.AskBox('[ 식권 ]'+#13+Common.KitchenPrinter[Common.Config.KitchenIndex].Name+' 프린터에'+#13+
                             ' 출력하지 못했습니다'+#13+
                             '다시시도 하시겠습니까?') then
            begin
              Inc(vFailCount);
              goto go_kitchen;
            end;
          end;
        rptTaxRefund :
          if vRtn <> 'OK' then
          begin
            if Common.AskBox('[ TAXFREE ]'+#13+Common.KitchenPrinter[Common.Config.KitchenIndex].Name+' 프린터에'+#13+
                             ' 출력하지 못했습니다'+#13+
                             '다시시도 하시겠습니까?') then
            begin
              Inc(vFailCount);
              goto go_kitchen;
            end;
          end;
        rptLetsOrder :
          if vRtn <> 'OK' then
          begin
            if Common.AskBox('[ 렛츠오더]'+#13+Common.KitchenPrinter[Common.Config.KitchenIndex].Name+' 프린터에'+#13+
                             ' 출력하지 못했습니다'+#13+
                             '다시시도 하시겠습니까?') then
            begin
              Inc(vFailCount);
              goto go_kitchen;
            end;
          end;
        end;
    end
    else
    begin
      go_receipt2:
      if Common.Config.ReceiptPrinterDev = prtNone then Exit;

      if Common.Config.ReceiptPrinterPort = '0' then
      begin
        InitPort;
        try
          repeat
            // 일부 POS에서 256Byte 이상이 되면 인쇄가 안되는 문제가 있어서 300글자씩 나눠서 인쇄한다
            vTemp      := Copy(vPrintData, 1, 300);
            vPrintData := Copy(vPrintData, 301, Length(vPrintData));
            WriteFile(LPTFile,PChar(vTemp)^,Length(vTemp),BytesWritten,nil);
          until Length(vPrintData) = 0;
        except
        end;

        try
          if (BytesWritten < Length(vPrintData)) then
          begin
            CloseHandle(LPTFile);
            raise Exception.Create('Error Write LPT');
          end
          else CloseHandle(LPTFile);
        except
        end;
      end
      else  //Serial
      begin
        //영수증프린터 체크(돈통열때만)
        if (aType <> rptNone) and (Common.Config.ReceiptPrinterCheck) then
        begin
          go_receipt:
          if PrinterCheck <> '' then
          begin
            case aType of
              rptCustOrder : vTemp := '고객주문서를';
              rptReceipt   : vTemp := '영수증을';
              rptHold      : vTemp := '보류영수증을';
              rptReady     : vTemp := '준비금 영수증을';
              rptMid       : vTemp := '중간출금 영수증을';
              rptCashier   : vTemp := '계산원 정산서를';
              rptPosClose  : vTemp := '포스 정산서를';
              rptCredit    : vTemp := '신용카드전표를';
              rptDelivery  : vTemp := '배달전표를';
              rptDeliveryReceipt  : vTemp := '배달영수증을';
              rptSimpleRcp : vTemp := '간이영수증을';
              rptBooking   : vTemp := '예약명부를';
              rptWaitTicket: vTemp := '대기표를';
              rptPinCode   : vTemp := '쇠고기이력을';
              rptNotTel    : vTemp := '배달수기주문서를';
              rptParking   : vTemp := '주차확인증을';
              rptSaleRpt   : vTemp := '매출현황을';
              rptTicket    : vTemp := '식권을';
              rptTaxRefund : vTemp := 'TAXFREE 영수증을';
            end;

            if (aType <> rptLetsOrder) and Common.AskBox(vTemp +' 출력하지 못했습니다'+#13+
                                    '다시시도 하시겠습니까?') then goto go_receipt;

            Exit;
          end;
        end;
        try
          if Common.Config.ReceiptPrinterDev = prtKICC then
          begin
            SetLength(vSystemPath, 256);
            GetSystemDirectory(PChar(vSystemPath), 256);
            vSystemPath := Copy(vSystemPath, 1, Pos(#0, vSystemPath)-1);

            if Length(vPrintData) < 20 then
              KiccDSCX.ReqCat('CD'#1310)
            else
            begin
              vPrintData := Replace(vPrintData, '★', '**');
              vPrintData := Replace(vPrintData, '☎', 'T.');
              vPrintData := Replace(vPrintData, '☏', 'T.');
              vPrintData := Replace(vPrintData, 'ⓦ', 'W-');
              vPrintData := Replace(vPrintData, 'ⓢ', 'S-');
              vPrintData := Replace(vPrintData, 'ⓒ', 'C-');
              vPrintData := Replace(vPrintData, 'ⓞ', 'O-');
              vPrintData := Replace(vPrintData, 'ⓖ', 'G-');
              vPrintData := Replace(vPrintData, 'ⓘ', 'I-');

              KiccDSCX.ReqSendRS232(vPrintData);
            end;
          end
          //JTNet 단말기 연동일때 일때 그냥 출력해야해서 사용안함
//          else if (Common.Config.van_trd = vanJTNET) and (GetOption(379) = '1') then
//          begin
//            vTemp := #$52+#$01+#$20+vPrintData+GetXorData(vPrintData)+#3;
//            vTemp := #$7e + FormatFloat('0000',LengthB(vTemp)) + vTemp;
//            PrintComPort.SendString(vTemp);
//            if LengthB(vTemp) > 100 then
//              Sleep(500);
//          end
          //FDK 단말기 연동일때 일때
          else if (Common.Config.van_trd = vanFDIK) and (GetOption(379) = '1') then
          begin
            vTemp := 'EP'+FormatFloat('0000', LengthB(vPrintData))+vPrintData+#3;
            vTemp :=  #5#2+vTemp+GetLRCData(vTemp);
            PrintComPort.SendString(vTemp);
          end
          //단말기연동으로 사용시
          else if GetOption(379) = '1' then
          begin
            repeat
              // 일부 POS에서 256Byte 이상이 되면 인쇄가 안되는 문제가 있어서 200글자씩 나눠서 인쇄한다
              vTemp      := Copy(vPrintData, 1, 200);
              vPrintData := Copy(vPrintData, 201, Length(vPrintData));
              PrintComPort.SendString(vTemp);
              //KICC일때는 돈통을 열고 바로 출력하면 출력이 안됨
              if (Common.Config.van_trd = vanKICC) and (Length(vPrintData) < 50) then
                Sleep(500);
            until Length(vPrintData) = 0;
          end
          else
          begin
            PrintComPort.SendString(vPrintData);
          end;
        except
        end;
      end;
    end;
  finally
    IsPrinting := False;
    if aType = rptLink then
      Common.HideWaitForm;
  end;
end;

procedure TDevice.OrderPrint(aValue:Boolean=True;aValue1:Boolean=True);
  function GetCornerData:Boolean;
  var vIndex :Integer;
  begin
    Result := False;
    For vIndex:=0 to High(Common.Corner) do
    begin
      if Common.Corner[vIndex].OrderData <> '' then
      begin
        Result := True;
        Break;
      end;
    end;
  end;
var I, vOrderNo, vPos     : Integer;
    vTemp :String;
    vCustPrintList : TStringList;
begin
  vOrderNo := Common.Table.OrderNo;
  try
    //고객주문서를 출력한다고 체크했으면
    if (Common.OrderKind <> okChange) and aValue and
       ( (Common.CustomerCancel + Common.CustomerPrinter <> '') or GetCornerData ) then
    begin
      //고객주문서 출력여부 묻는다고 했을때
      if (GetOption(41) = '1') and (((Common.OrderKind <> okChange) or (GetOption(408)='1')) or (GetOption(231) = '0')) then
      begin
        if Common.AskBox('고객주문서를 출력하시겠습니까?') then
        begin
          if (Common.Config.IsTakeOut) and (GetOption(231) = '1') and (GetOption(233) = '1') then
          begin
            if ((Common.OrderKind <> okChange) or (GetOption(408)='1')) then
              For I:= 0 to High(Common.Corner) do
              begin
                if Common.Corner[I].OrderData = '' then Continue;
                Common.CustomerPrinter       := Common.Corner[I].OrderData;
                Common.Config.CustOrderTitle := Common.Corner[I].Name;
                CustomerOrderPrint(Common.Corner[I].OrderNo,0);
              end;
          end
          else if GetOption(410)='0' then
            CustomerOrderPrint(0,0)
          else
          begin
            vCustPrintList := TStringList.Create;
            try
              Common.WSSplit(Common.CustomerPrinter, 3, vCustPrintList);
              for I := 0 to vCustPrintList.Count-1 do
              begin
                Common.CustomerPrinter := vCustPrintList[I];
                CustomerOrderPrint(0,0);
              end;
            finally
              vCustPrintList.Free;
            end;
          end;
        end;
      end
      else
      begin
        //푸드코트 사용 시 코너별로 주문서를 출력할때
        if (Common.Config.IsTakeOut) and (GetOption(231) = '1') and (GetOption(233) = '1') then
        begin
          if ((Common.OrderKind <> okChange) or (GetOption(408)='1')) then
            For I:= 0 to High(Common.Corner) do
            begin
              if Common.Corner[I].OrderData = '' then Continue;
              if GetOption(365) = '0' then
              begin
                Common.CustomerPrinter       := Common.Corner[I].OrderData;
                Common.Config.CustOrderTitle := Common.Corner[I].Name;
                CustomerOrderPrint(Common.Corner[I].OrderNo,0);
              end
              //메뉴 종류별로 출력
              else
              begin
                vTemp := Common.Corner[I].OrderData;
                vTemp := Replace(vTemp, #$D#$D, #13);
                repeat
                  vPos   := Pos(#13, vTemp);
                  Common.CustomerPrinter      := Copy(vTemp, 1, vPos);
                  if Trim(Common.CustomerPrinter) <> EmptyStr then
                  begin
                    vTemp  := Copy(vTemp, vPos+1, LengthB(vTemp));
                    CustomerOrderPrint(Common.Corner[I].OrderNo,0);
                  end
                  else
                    vTemp := EmptyStr;
                until Length(vTemp) = 0;
              end;
            end;
        end
        else if GetOption(410)='0' then
          CustomerOrderPrint(0,0)
        else
        begin
          vCustPrintList := TStringList.Create;
          try
            Common.WSSplit(Common.CustomerPrinter, 3, vCustPrintList);
            for I := 0 to vCustPrintList.Count-1 do
            begin
              Common.CustomerPrinter := vCustPrintList[I];
              if Common.CustomerPrinter <> EmptyStr then
                CustomerOrderPrint(0,0);
            end;
          finally
            vCustPrintList.Free;
          end;
        end;
      end;
    end;
  except
  end;

  try
    //주방주문서를 출력한다고 체크했으면
    if ((Common.OrderKind <> okChange) or (GetOption(408)='1')) and (aValue1) then
    begin
      For I := 0 to High(Common.KitchenPrinter) do
      begin
        if (Common.KitchenPrinter[I].Data   = EmptyStr) and
           (Common.KitchenPrinter[I].Cancel = EmptyStr) then Continue;

        if Common.KitchenPrinter[I].IsKDS then Continue;

        //첫주문만 출력한다고 했을때
        if (Common.KitchenPrinter[I].IsFirst and (Common.OrderKind <> okNew) ) then Continue;

        if ((Common.OrderKind <> okChange) or (GetOption(408)='1')) and (Common.Config.IsTakeOut) and (GetOption(231) = '1') and (GetOption(233) = '1') then
          Common.KitchenPrinter[I].OrderNo := Common.Corner[Common.GetCornerIndex(Common.KitchenPrinter[I].Corner)].OrderNo
        //푸드코트 취소일때
        else if (Common.OrderKind = okCancel) and (GetOption(231) = '1') and (GetOption(233) = '1') then
        begin
          if Common.KitchenPrinter[I].Corner = EmptyStr then Continue;
          OpenQuery('select NO_ORDER '
                   +'  from SL_SALE_NO '
                   +' where CD_STORE  =:P0 '
                   +'   and YMD_SALE  =:P1 '
                   +'   and NO_POS    =:P2 '
                   +'   and NO_RCP    =:P3 '
                   +'   and CD_CORNER =:P4 ',
                   [Common.Config.StoreCode,
                    Copy(Common.BanReceipt, 1, 8),
                    Common.Config.PosNo,
                    Copy(Common.BanReceipt, 9, 4),
                    Common.Corner[Common.GetCornerIndex(Common.KitchenPrinter[I].Corner)].Code]);
          if not Common.Query.Eof then
            Common.KitchenPrinter[I].OrderNo := Common.Query.Fields[0].AsInteger;
        end;
        KitchenOrderPrint(I);
      end;
    end;
  except
  end;
end;

function TDevice.SetOrderPrintHeader(AValue:String;aIndex:Integer): String;
var vNowNumber,
    vFromNumber,
    vToNumber, vTemp, ppStr :String;
    I, vCol :Integer;
    bCancel :Boolean;
begin
  vCol := Ifthen(Common.KitchenPrinter[aIndex].Col=1,6,0);

  //선불제가 아니고 테이블명을 사용 안할때
  if (not Common.Config.IsTakeOut) and (GetOption(25) = '0') then
  begin
    if (Common.Table.OrderType = 'D') then
      vNowNumber  := Common.Table.Name
    else
    begin
      vNowNumber  := IntToStr(Common.Table.Number);
      if Assigned(Table_F) then
      begin
        vFromNumber := IntToStr(Table_F.FromTable.Number);
        vToNumber   := IntToStr(Table_F.ToTable.Number);
      end;
    end;
  end
  else if (not Common.Config.IsTakeOut) then
  begin
    vNowNumber  := Common.Table.Name;
    if Assigned(Table_F) and (Common.Table.OrderType = 'T') then
    begin
      vFromNumber := Table_F.FromTable.Name;
      vToNumber   := Table_F.ToTable.Name;
    end;
  end
  else if (Common.Config.IsTakeOut) and (Common.Table.OrderType = 'D') then
  begin
    vNowNumber  := Common.Table.Name;
  end;

  case Common.TableMode of
    tbmNone :
      begin
        Result := rptAlignCenter;
        //타이블에 주방명을 출력할때
        if GetOption(205) = '1' then
        begin
          case StoI(GetOption(96)) of
            1 : Result := Result + rptSizeNormal + Common.KitchenPrinter[aIndex].Name+#13;
            2 : Result := Result + rptSizeHeight + Common.KitchenPrinter[aIndex].Name+#13;
            3 : Result := Result + rptSizeWidth  + Common.KitchenPrinter[aIndex].Name+#13;
            4 : Result := Result + rptSizeBoth   + Common.KitchenPrinter[aIndex].Name+#13;
          end;
        end
        else
        begin
          case StoI(GetOption(96)) of
            1 : Result := Result + rptSizeNormal + Common.Config.KitchenPrintTitle+#13;
            2 : Result := Result + rptSizeHeight + Common.Config.KitchenPrintTitle+#13;
            3 : Result := Result + rptSizeWidth  + Common.Config.KitchenPrintTitle+#13;
            4 : Result := Result + rptSizeBoth   + Common.Config.KitchenPrintTitle+#13;
          end;
        end;

        bCancel := POS('∵',AValue) > 0;
        AValue := CtoC(AValue,'∵', '');
        Common.KitchenPrinter[aIndex].Data   := CtoC(Common.KitchenPrinter[aIndex].Data,  '∵', '');
        Common.KitchenPrinter[aIndex].Cancel := CtoC(Common.KitchenPrinter[aIndex].Cancel,'∵', '');

        Result := Result + rptCharBold + rptAlignCenter;
        if Common.OrderKind = okNew then
        begin
          case StoI(GetOption(97)) of
            1 : Result := Result + rptSizeNormal + '[ 신규주문 ]'+#13;
            2 : Result := Result + rptSizeHeight + '[ 신규주문 ]'+#13;
            3 : Result := Result + rptSizeBoth   + '[신규주문]'+#13;
          end;
        end;

        Result := Result + rptAlignCenter;
        if Common.OrderKind = okAppend then
        begin
          if (Common.OrderKind = okAppend) then
          begin
            if (Common.KitchenPrinter[aIndex].Data = '') and (Pos('(취소)',aValue) > 0) then
              Result := Result
            else if (Common.KitchenPrinter[aIndex].Data <> '') or (aValue <> '')  then
              case StoI(GetOption(97)) of
                1 : Result := Result + rptSizeNormal + '[ 추가주문 ]'+#13;
                2 : Result := Result + rptSizeHeight + '[ 추가주문 ]'+#13;
                3 : Result := Result + rptSizeBoth   + '[추가주문]'+#13;
              end;
          end;
          //취소주문내역 있으면
          if bCancel  then
          begin
            Result := Result + rptAlignCenter;
            case StoI(GetOption(97)) of
              1 : Result := Result + rptSizeNormal + '[ 취소주문 ]'+#13;
              2 : Result := Result + rptSizeHeight + '[ 취소주문 ]'+#13;
              3 : Result := Result + rptSizeBoth   + '[취소주문]'+#13;
            end;
          end;
        end;

        if Result <> rptAlignCenter then
          Result := Result + rptLF;
        Result := Result + rptAlignLeft;

        case StoI(GetOption(98)) of
          1 : Result := Result + rptSizeNormal + '주 방 명  : ' + Common.KitchenPrinter[aIndex].Name+#13;
          2 : Result := Result + rptSizeHeight + '주 방 명  : ' + Common.KitchenPrinter[aIndex].Name+#13;
          3 : Result := Result + rptSizeBoth   + '주방명  : ' + Common.KitchenPrinter[aIndex].Name+#13;
        end;

        case StoI(GetOption(99)) of
          1,2 :
          begin
            if StoI(GetOption(99)) = 1 then Result := Result + rptSizeNormal
            else                            Result := Result + rptSizeHeight;
            if (not Common.Config.IsTakeOut) then
            begin
              if (GetOption(58) = '0') and (High(Common.FloorData) > 0) then
              begin
                if Common.Table.OrderType='D' then
                  Result := Result + vNowNumber+#13
                else
                  Result := Result + '테이블  : ' + Common.Table.FloorName+' - ' +vNowNumber+#13;
              end
              else
                Result := Result + '테이블  : ' + vNowNumber+#13;
            end
            else if Common.Table.OrderType = 'D' then
              Result := Result + '배달번호  : ' + Copy(vNowNumber, 6, 13)+#13;
          end;
          3 : //가로세로 확대
          begin
            Result := Result + rptSizeBoth;
            if (not Common.Config.IsTakeOut) then
            begin
              if (GetOption(58) = '0') and (High(Common.FloorData) > 0) then
              begin
                if Common.Table.OrderType = 'D' then
                  Result := Result + vNowNumber+#13
                else
                Result := Result + Common.Table.FloorName+'-'+vNowNumber+#13;
              end
              else if Common.Table.OrderType = 'D' then
                Result := Result + vNowNumber+#13
              else
                Result := Result + '테이블 : ' + vNowNumber+#13;
            end
            else if Common.Table.OrderType = 'D' then
              Result := Result +  vNowNumber+#13;
          end;
        end;

        if (Common.Table.OrderType <> 'D') then
        begin
          if (GetOption(138) = '0') or (Common.Table.AgeCode.Count=0) then
          begin
            case StoI(GetOption(100)) of
              1 : Result := Result + rptSizeNormal + '고 객 수  : ' + IntToStr(Common.Table.CustomerCount)+' 명'+#13;
              2 : Result := Result + rptSizeHeight + '고 객 수  : ' + IntToStr(Common.Table.CustomerCount)+' 명'+#13;
              3 : Result := Result + rptSizeBoth   + '고객수 : ' + IntToStr(Common.Table.CustomerCount)+' 명'+#13;
            end;
          end
          else
          begin
            case StoI(GetOption(100)) of
              1 : Result := Result + rptSizeNormal + '고객수 : ' + Common.GetAgePerson(Common.Table)+#13;
              2 : Result := Result + rptSizeHeight + '고객수 : ' + Common.GetAgePerson(Common.Table)+#13;
              3 : Result := Result + rptSizeBoth   + '고객수 : ' + Common.GetAgePerson(Common.Table)+#13;
            end;
          end;
        end;

        //테이블메모
        if (GetOption(343) <> '0') and (Common.Table.Memo <> EmptyStr) then
        begin
          Result := Result + rptAlignLeft;
          Result := Result + '-메모-'+#13;
          case StoI(GetOption(343)) of
              1 : Result := Result + rptSizeNormal;
              2 : Result := Result + rptSizeHeight;
          end;
          Result := Result + Common.Table.Memo+#13;
        end;

        //푸드코트이면서 코너별로 주문서를 출력할때
        if (Common.Config.IsTakeOut) and (GetOption(231) = '1') and (GetOption(233) = '1') then
        begin
          Result := Result + rptAlignCenter;
          Result := Result + rptSizeBoth;
          case Common.OrderKind of
            okCancel : Result := Result + '[ 취 소 : '+ FormatFloat('0000',Common.KitchenPrinter[aIndex].OrderNo)+' ]'+#13;
            else       Result := Result + ' 정 상 : '+ FormatFloat('0000',Common.KitchenPrinter[aIndex].OrderNo)+#13;
          end;
          Result := Result + rptAlignLeft;
        end;

        case StoI(GetOption(101)) of
          0 :  //출력을 안한다고 했으면 메뉴설정하고 같게한다(세로확대일때는 가로확대로)
          begin
            case StoI(GetOption(103)) of
              0 : Result := Result + rptSizeNormal + rptOneLine+#13;
              1 : Result := Result + rptSizeWidth  + rptOneLine2+#13;
              2 : Result := Result + rptSizeBoth   + rptOneLine2+#13;
            end;
          end;
          1 :
          begin
            Result := Result + rptSizeNormal;
            Result := Result + rptOneLine+#13;
            Result := Result + rptpStr+'            메   뉴'+rptpStr+'                   수량'+#13;
            Result := Result + rptOneLine+#13;
          end;
          2 :
          begin
            Result := Result + rptSizeWidth;
            Result := Result + rptOneLine2+#13;
            Result := Result + '     메뉴  '+rptpStr+'      수량'+#13;
            Result := Result + rptOneLine2+#13;
          end;
          3 :
          begin
            Result := Result + rptSizeBoth;
            Result := Result + rptOneLine2+#13;
            Result := Result + rptSizeBoth;
            Result := Result + '     메뉴  '+rptpStr+'      수량'+#13;
            Result := Result + rptOneLine2+#13;
          end;
        end;

        if Common.OrderKind = okNew then
        begin
          Result := Result + rptAlignCenter;
          case StoI(GetOption(102)) of
            1 : Result := Result + rptSizeNormal + '[ 신규주문 ]'+#13;
            2 : Result := Result + rptSizeHeight + '[ 신규주문 ]'+#13;
            3 : Result := Result + rptSizeBoth   + '[신규주문]'+#13;
          end;
        end;

        if Common.OrderKind = okAppend then
        begin
          Result := Result + rptAlignCenter;
          if (Common.OrderKind = okAppend) then
          begin
            if (Common.KitchenPrinter[aIndex].Data = '') and (Pos('(취소)',aValue) > 0) then
              Result := Result
            else if (Common.KitchenPrinter[aIndex].Data <> '') or (aValue <> '')  then
            case StoI(GetOption(102)) of
              1 : Result := Result + rptSizeNormal + '[ 추가주문 ]'+#13;
              2 : Result := Result + rptSizeHeight + '[ 추가주문 ]'+#13;
              3 : Result := Result + rptSizeBoth   + '[추가주문]'+#13;
            end;
          end;

          //취소주문내역 있으면
          if bCancel  then
          begin
            Result := Result + rptAlignCenter;
            case StoI(GetOption(102)) of
              1 : Result := Result + rptSizeNormal + '[ 취소주문 ]'+#13;
              2 : Result := Result + rptSizeHeight + '[ 취소주문 ]'+#13;
              3 : Result := Result + rptSizeBoth   + '[취소주문]'+#13;
            end;
          end;
        end;

        Result := Result + rptAlignLeft;
        //메뉴별로 한줄 띄울때
        if (GetOption(104) = '1') then
          Result := Result + #13;

        //실제주문메뉴내역
        case StoI(GetOption(103)) of
          0 : Result := Result + rptSizeNormal + AValue+#13;
          1 : Result := Result + rptSizeHeight + AValue+#13;
          2 : Result := Result + rptSizeBoth + AValue+#13;
        end;

        Result := Result + rptAlignLeft;
        case StoI(GetOption(101)) of
          0 :  //출력을 안한다고 했으면 메뉴설정하고 같게한다(세로확대일때는 가로확대로)
          begin
             case StoI(GetOption(103)) of
               0 : Result := Result + rptSizeNormal + rptOneLine+#13;
               1 : Result := Result + rptSizeWidth  + rptOneLine2+#13;
               2 : Result := Result + rptSizeBoth   + rptOneLine2+#13;
             end;
          end;
          1 : Result := Result + rptSizeNormal + rptTwoLine+#13;
          2 : Result := Result + rptSizeWidth  + rptTwoLine2+#13;
          3 : Result := Result + rptSizeBoth   + rptTwoLine2+#13;
        end;


        if StoI(GetOption(447)) > 0 then
        begin
          Result := Result + rptAlignRight;

          case StoI(GetOption(447)) of
            1 : Result := Result +  rptSizeNormal + Format('주문금액    %s',[FormatFloat(',0원', Common.Present.TotalAmt-Common.PreSent.TotalDC)]) +#13;
            2 : Result := Result +  rptSizeHeight + Format('주문금액    %s',[FormatFloat(',0원', Common.Present.TotalAmt-Common.PreSent.TotalDC)]) +#13;
            3 : Result := Result +  rptSizeBoth   + Format('주문금액    %s',[FormatFloat(',0원', Common.Present.TotalAmt-Common.PreSent.TotalDC)]) +#13;
          end;
          Result := Result + rptAlignLeft;
        end;

        case StoI(GetOption(107)) of
          1 : Result :=Result + rptSizeNormal + '담 당 자  : '+ Common.Table.DamdangName+#13;
          2 : Result :=Result + rptSizeHeight + '담 당 자  : '+ Common.Table.DamdangName+#13;
          3 : Result :=Result + rptSizeBoth   + '담당자 : '+ Common.Table.DamdangName+#13;
        end;

        //배달주문일때 코스 및 지역출력
        if Common.Table.OrderType = 'D' then
        begin
          if Common.Table.Course <> EmptyStr then
            case StoI(GetOption(203)) of
              1 : Result :=Result + rptSizeNormal + '배달코스 : '+ Common.Table.Course+#13;
              2 : Result :=Result + rptSizeHeight + '배달코스 : '+ Common.Table.Course+#13;
              3 : Result :=Result + rptSizeBoth   + '배달코스 : '+ Common.Table.Course+#13;
            end;

          if Common.Table.Local <> EmptyStr then
            case StoI(GetOption(204)) of
              1 : Result :=Result + rptSizeNormal + '배달지역 : '+ Common.Table.Local+#13;
              2 : Result :=Result + rptSizeHeight + '배달지역 : '+ Common.Table.Local+#13;
              3 : Result :=Result + rptSizeBoth   + '배달지역 : '+ Common.Table.Local+#13;
            end;

          if GetOption(288) <> '0' then
          begin
            if Common.Table.Addr1 <> EmptyStr then
              case StoI(GetOption(288)) of
                1 : Result :=Result + rptSizeNormal + Common.Table.Addr1+#13;
                2 : Result :=Result + rptSizeHeight + Common.Table.Addr1+#13;
              end;
            if Common.Table.Addr2 <> EmptyStr then
              case StoI(GetOption(288)) of
                1 : Result :=Result + rptSizeNormal + Common.Table.Addr2+#13;
                2 : Result :=Result + rptSizeHeight + Common.Table.Addr2+#13;
              end;
          end;

          if Common.Table.DeliveryTel <> EmptyStr then
            case StoI(GetOption(448)) of
              1 : Result :=Result + rptSizeNormal + '연 락 처 : '+Common.Table.DeliveryTel+#13;
              2 : Result :=Result + rptSizeHeight + '연 락 처 : '+Common.Table.DeliveryTel+#13;
              3 : Result :=Result +rptAlignRight + rptSizeBoth   + '연락처 : '+Common.Table.DeliveryTel+#13;
            end;
        end;

        //호출번호 출력
        if Common.PreSent.CallNo > 0 then
        begin
          Result := Result + rptAlignCenter;
          case StoI(GetOption(312)) of
            1 : Result :=Result + rptSizeNormal + Format('호출번호 - %d %s',[Common.PreSent.CallNo, Ifthen(Common.PreSent.CallTelNo <> '', Format('[%s]', [RightStr(Common.PreSent.CallTelNo,4)]),'')])+#13;
            2 : Result :=Result + rptSizeHeight + Format('호출번호 - %d %s',[Common.PreSent.CallNo, Ifthen(Common.PreSent.CallTelNo <> '', Format('[%s]', [RightStr(Common.PreSent.CallTelNo,4)]),'')])+#13;
            3 : Result :=Result + rptSizeBoth   + Format('호출번호 - %d %s',[Common.PreSent.CallNo, Ifthen(Common.PreSent.CallTelNo <> '', Format('[%s]', [RightStr(Common.PreSent.CallTelNo,4)]),'')])+#13;
            4 : Result :=Result + rptSize3Times + Format('호출번호 - %d %s',[Common.PreSent.CallNo, Ifthen(Common.PreSent.CallTelNo <> '', Format('[%s]', [RightStr(Common.PreSent.CallTelNo,4)]),'')])+#13;
          end;
          PrintData := PrintData + rptAlignLeft;
        end;


        Result := Result + rptSizeNormal;

        //푸드코트이면서 코너별로 주문번호를 출력할때
        if (Common.Config.IsTakeOut) and (GetOption(231) = '1') and (GetOption(233) = '1') then
        begin
          case StoI(GetOption(105)) of
            1: Result := Result + rptSizeNormal + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now())+#13;
            2: Result := Result + rptSizeHeight + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now())+#13;
            3: Result := Result + rptSizeBoth + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now())+#13;
          end;
        end
        else
        begin
          //주문시간
          case StoI(GetOption(105)) of
            0 :
            begin
              case StoI(GetOption(106)) of
                1 : Result := Result + rptSizeNormal + '주문번호 : '+IntToStr(Common.Table.OrderNo)+#13;
                2 : Result := Result + rptSizeHeight + '주문번호 : '+IntToStr(Common.Table.OrderNo)+#13;
                3 : Result := Result + rptSizeBoth   + '주문번호 : '+IntToStr(Common.Table.OrderNo)+#13;
              end;
            end;
            1 :
            begin
              case StoI(GetOption(106)) of
                0: Result := Result + rptSizeNormal + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now())+#13;
                1: Result := Result + rptSizeNormal + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now()) + rptSizeNormal
                                    + LPadB('주문번호 : '+IntToStr(Common.Table.OrderNo),22+vCol,' ')+#13;
                2: Result := Result + rptSizeNormal + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now()) + rptSizeHeight
                                    + LPadB('주문번호 : '+IntToStr(Common.Table.OrderNo),22+vCol,' ')+#13;
                3: Result := Result + rptSizeNormal   + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now()) + rptSizeBoth
                                    + ' 주문번호 '+IntToStr(Common.Table.OrderNo)+#13;
              end;
            end;
            2 :
            begin
              case StoI(GetOption(106)) of
                0: Result := Result + rptSizeHeight + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now()) +#13;
                1: Result := Result + rptSizeHeight + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now()) + rptSizeNormal
                                    + LPadB('주문번호 : '+IntToStr(Common.Table.OrderNo),22+vCol,' ')+#13;
                2: Result := Result + rptSizeHeight + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now()) + rptSizeHeight
                                    + LPadB('주문번호 : '+IntToStr(Common.Table.OrderNo),22+vCol,' ')+#13;
                3: Result := Result + rptSizeHeight   + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now()) + rptSizeBoth
                                    + ' 주문번호 '+IntToStr(Common.Table.OrderNo)+#13;
              end;
            end;
            3 :
            begin
              case StoI(GetOption(106)) of
                0: Result := Result + rptSizeBoth + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now())+#13;
                1: Result := Result + rptSizeBoth + FormatDateTime('mm-dd hh:nn:ss', Now()) + rptSizeNormal
                                    + LPadB(IntToStr(Common.Table.OrderNo),13+(vCol div 2),' ')+#13;
                2: Result := Result + rptSizeBoth + FormatDateTime('mm-dd hh:nn:ss', Now()) + rptSizeHeight
                                    + LPadB(IntToStr(Common.Table.OrderNo),13+(vCol div 2),' ')+#13;
                3: Result := Result + rptSizeBoth   + FormatDateTime('mm-dd hh:nn:ss', Now()) + rptSizeBoth
                                    + LPadB(IntToStr(Common.Table.OrderNo),7+(vCol div 2),' ')+#13;
              end;
            end;
          end;
        end;
        

        //상단여백
        For I := 1 to Common.KitchenPrinter[aIndex].TopMargin do
          Result := rptLF + Result;

        //하단여백
        For I := 1 to Common.KitchenPrinter[aIndex].BottomMargin do
          Result := Result + rptLF;

        if Common.KitchenPrinter[aIndex].Device = prtTM then
          Result := Result + rptBeep;
        Exit;
      end;
  end;

  Result := rptAlignCenter;
  case StoI(GetOption(96)) of
    1 : Result := Result + rptSizeNormal + '주방주문서'+#13;
    2 : Result := Result + rptSizeHeight + '주방주문서'+#13;
    3 : Result := Result + rptSizeWidth  + '주방주문서'+#13;
    4 : Result := Result + rptSizeBoth   + '주방주문서'+#13;
  end;

  Result := Result + rptAlignCenter;
  case Common.TableMode of
    tbmTableMoveing : Result := Result + '[테이블이동]'+#13;
    tbmMergeing     : Result := Result + '[테이블합석]'+#13;
    tbmMenuMoveing  : Result := Result + '[메뉴이동]'+#13;
  end;

  Result := Result + rptLF;
  Result := Result + rptAlignLeft;

  case StoI(GetOption(98)) of
    1 : Result := Result + rptSizeNormal + '주 방 명  : ' + Common.KitchenPrinter[aIndex].Name+#13;
    2 : Result := Result + rptSizeHeight + '주 방 명  : ' + Common.KitchenPrinter[aIndex].Name+#13;
    3 : Result := Result + rptSizeBoth   + '주방명:'      + Common.KitchenPrinter[aIndex].Name+#13;
  end;

  case StoI(GetOption(99)) of
    1,2 :
    begin
      if StoI(GetOption(99)) = 1 then Result := Result + rptSizeNormal
      else                                       Result := Result + rptSizeHeight;
      if Assigned(Table_F) and (GetOption(58) = '0') and (High(Common.FloorData) > 0) then
        Result := Result + Format('[이동] %s-%s => %s-%s',[Table_F.FromTable.FloorName, vFromNumber, Table_F.ToTable.FloorName, vToNumber])+#13
      else
        Result := Result + Format('[이동] %s => %s',[vFromNumber, vToNumber])+#13;
      Result := Result +   '이동시간: ' + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now())+#13;
    end;
    3 :
    begin
      Result := Result + rptSizeBoth;
      if Assigned(Table_F) and (GetOption(58) = '0') and (High(Common.FloorData) > 0) then
      begin
        Result := Result + '이동 전 :' + Table_F.FromTable.FloorName+' - '+vFromNumber+#13;
        Result := Result + '이동 후 :' + Table_F.ToTable.FloorName+' - '+vToNumber+#13;
      end
      else
      begin
        Result := Result + '이동 전:' + vFromNumber+#13;
        Result := Result + '이동 후:' + vToNumber+#13;
      end;
      Result := Result +   '이동시간:' + FormatDateTime('hh:nn:ss', Now())+#13;
    end;
  end;
  Result := Result + rptLF;

  //테이블 이동, 합석시 메뉴내역 출력안한다고 설정했을때
  if (Common.TableMode <> tbmMenuMoveing) and (GetOption(77) = '1') then
  begin
    //상단여백
    For I := 1 to Common.KitchenPrinter[aIndex].TopMargin do
      Result := rptLF + Result;

    //하단여백
    For I := 1 to Common.KitchenPrinter[aIndex].BottomMargin do
      Result := Result + rptLF;
    Exit;
  end;

  case StoI(GetOption(101)) of
     0 :  //출력을 안한다고 했으면 메뉴설정하고 같게한다(세로확대일때는 가로확대로)
     begin
       case StoI(GetOption(103)) of
         0 : Result := Result + rptSizeNormal + rptOneLine+#13;
         1,2 : Result := Result + rptSizeWidth  + rptOneLine2+#13;
       end;
     end;
     1 :
    begin
      Result := Result + rptSizeNormal;
      Result := Result + rptOneLine+#13;
      Result := Result + rptpStr+'            메   뉴'+rptpStr+'                   수량'+#13;
      Result := Result + rptOneLine+#13;
    end;
      2 :
    begin
      Result := Result + rptSizeWidth;
      Result := Result + rptOneLine2+#13;
      Result := Result + '     메뉴 '+rptpStr+'       수량'+#13;
      Result := Result + rptOneLine2+#13;
    end;
      3 :
    begin
      Result := Result + rptSizeBoth;
      Result := Result + rptOneLine2+#13;
      Result := Result + '     메뉴 '+rptpStr+'       수량'+#13;
      Result := Result + rptOneLine2+#13;
    end;
  end;

  case StoI(GetOption(103)) of
      0 : Result := Result + rptSizeNormal;
      1 : Result := Result + rptSizeHeight;
      2 : Result := Result + rptSizeBoth;
  end;
  //메뉴별 줄간격
  if (GetOption(104) = '1') then
    Result := Result + #13 + AValue
  else
    Result := Result + AValue;

  case StoI(GetOption(101)) of
     0 :  //출력을 안한다고 했으면 메뉴설정하고 같게한다(세로확대일때는 가로확대로)
     begin
        case StoI(GetOption(103)) of
            0 : Result := Result + rptSizeNormal + rptOneLine;
            1,2 : Result := Result + rptSizeWidth  + rptOneLine2;
        end;
     end;
     1 : Result := Result + rptSizeNormal + rptTwoLine;
     2,3 : Result := Result + rptSizeWidth  + rptTwoLine2;
  end;
  Result := Result + rptLF;

  //상단여백
  For I := 1 to Common.KitchenPrinter[aIndex].TopMargin do
    Result := rptLF + Result;

  //하단여백
  For I := 1 to Common.KitchenPrinter[aIndex].BottomMargin do
    Result := Result + rptLF;

  if Common.KitchenPrinter[aIndex].Device = prtTM then
    Result := Result + rptBeep;

end;

function TDevice.PrinterCommendReplace(aValue:String;aDevice,aCol,aMagin:Integer):String;
  procedure FileReName(aFileName, bFileName: String);
  var
    SourceFile,
    TargetFile : TFileStream;
  begin
    if not FileExists(aFileName) then Exit;
    while FileExists(bFileName)    do DeleteFile(bFileName);
    SourceFile := TFileStream.Create(aFileName, fmOpenRead );
    TargetFile := TFileStream.Create(bFileName, fmOpenWrite or fmCreate );
    TargetFile.CopyFrom(SourceFile, SourceFile.Size ) ;
    SourceFile.Free;
    TargetFile.Free;
  end;
var vIndex :Integer;
    vStamp :String;
    vMargin :String;
begin
  vMargin := '';
  for vIndex := 1 to aMagin do //Common.Config.PrintBottomMargin do
    vMargin:= vMargin + #13;

  if aDevice = prtESPON then
  begin
    Result := #27'@'+   // 프린터 초기화
              Ifthen(GetOption(27) = '1', #28#112#1#0, '') + // 그림인쇄
              AValue+
              vMargin+
              #27#74#0+ // 인쇄(Feed)
              Ifthen(Common.Config.IsKiosk and Common.Config.IsKioskCash,  #27'i', #27'm');  // 컷팅
  end
  else if ADevice = prtTM then
  begin
    Result := #27'@'+   // 프린터 초기화
            Ifthen(GetOption(27) = '1', #13#28#112#1#0, '') + // 그림인쇄
            AValue+
            vMargin+
            #27#74#0+ // 인쇄(Feed)
            #27'i';  // 컷팅
  end
  else if ADevice in [prtKICC] then
  begin
    Result := #27'@'+   // 프린터 초기화
              Ifthen(GetOption(27) = '1', #28#112#1#0, '') + // 그림인쇄
              AValue+
              vMargin+
              #27#74#0+ // 인쇄(Feed)
              Ifthen(Common.Config.IsKiosk and Common.Config.IsKioskCash,  #27'i', #27'm');  // 컷팅
  end;
  Result := Replace(Result, rptLogoImage,     '');

  Result := Replace(Result, rptCharNormal,    #27#71#0#29#66#0#27#45#0);
  if aDevice = prtKICC then
    Result := Replace(Result, rptCharBold,      '');

  if (Common.Config.van_trd in [vanKICC,vanNICE]) and (GetOption(379) = '1') then
     Result := Replace(Result, rptCharBold,      '');

  //KIS에서 나온 단말기가 진하게 출력시 크게 출력되서 옵션처리함
  if Common.GetIniFile('POS', '폰트진하게', 'Y') = 'N' then
    Result := Replace(Result, rptCharBold, '');

  if (Common.Config.van_trd in [vanKCP,vanKSNET]) and (GetOption(379) = '1') then
    Result := Replace(Result, rptCharBold,      #27#33#8)
  else
    Result := Replace(Result, rptCharBold,      #27#71#1);

  Result := Replace(Result, rptCharInverse,   #29#66#1);
  Result := Replace(Result, rptCharUnderline, #27#45#1);

  Result := Replace(Result, rptAlignLeft,     #27#97#0);
  Result := Replace(Result, rptAlignCenter,   #27#97#1);
  Result := Replace(Result, rptAlignRight,    #27#97#2);

  if (Common.Config.van_trd in [vanKCP, vanKSNET]) and (GetOption(379) = '1') then
    Result := Replace(Result, rptSizeNormal,    #27#33#1)
  else
    Result := Replace(Result, rptSizeNormal,    #29#33#0);

  if (Common.Config.van_trd in [vanKCP, vanKsnet]) and (GetOption(379) = '1') then
    Result := Replace(Result, rptSizeWidth,    #27#33#32)
  else
    Result := Replace(Result, rptSizeWidth,    #29#33#16);

  if (Common.Config.van_trd in [vanKCP, vanKsnet]) and (GetOption(379) = '1') then
    Result := Replace(Result, rptSizeHeight,    #27#33#16)
  else
    Result := Replace(Result, rptSizeHeight,    #29#33#1);

  if (Common.Config.van_trd in [vanKCP, vanKsnet]) and (GetOption(379) = '1') then
    Result := Replace(Result, rptSizeBoth,    #27#33#48)
  else
    Result := Replace(Result, rptSizeBoth,    #29#33#17);
  Result := Replace(Result, rptSize3Times,    #29#33#34);
  Result := Replace(Result, rptBeep,          #$1B#$70#1#2#10);
  Result := Replace(Result, rptLF,            #13#10);

  case ADevice of
    prtTM :
    begin
       Result := Replace(Result, rptOneLine,  '────────────────────────');
       Result := Replace(Result, rptOneLine2, '────────────');
       Result := Replace(Result, rptTwoLine,  '━━━━━━━━━━━━━━━━━━━━━━━━');
       Result := Replace(Result, rptTwoLine2, '━━━━━━━━━━━━');
       Result := Replace(Result, rptpStr,     '   ');
    end;
    else
    begin
      if aCol = 0 then
      begin
        Result := Replace(Result, rptOneLine,  '------------------------------------------');
        Result := Replace(Result, rptOneLine2, '---------------------');
        Result := Replace(Result, rptTwoLine,  '==========================================');
        Result := Replace(Result, rptTwoLine2, '=====================');
        Result := Replace(Result, rptpStr,     '');
      end
      else
      begin
        Result := Replace(Result, rptOneLine,  '------------------------------------------------'+#13);
        Result := Replace(Result, rptOneLine2, '------------------------'+#13);
        Result := Replace(Result, rptTwoLine,  '================================================');
        Result := Replace(Result, rptTwoLine2, '========================');
        Result := Replace(Result, rptpStr,     '   ');
      end;
    end;
  end;

  Result := Replace(Result, rptBarCode, #$1D#$68#$46#$1D#$77#$02#$1D#$48#$02#$1B#$61#$01#$1D#$66#$01#$1D#$6B#$46);      //#$46(ITF),  #$49(Code128), #$43(EAN13)
  //#$1D#$68#$50 Barcode Height
  //#$1D#$77#$02 BarCode Width
  // #$1B#$61#$01#
  //#$1D#$48#$02    Select printing position of HRI characters
  //#$1D#$6B#$49    Print bar code     (바코드가 255 작으면 Code128 73->49(Hex)
  //#$1D#$66#$48  바코드 문자 출력안함
  if (Pos(rptStamp, AValue) > 0) and (FileExists(Common.AppPath+'\DLL\Stamp.bmp')) then
  begin
    vStamp := EmptyStr;
    for vIndex := 1 to (Common.Member.Stamp+Common.PreSent.SaveStamp-Common.PreSent.UseStamp) div 10 do
      vStamp := vStamp +  SetImage(Common.AppPath+'\DLL\Stamp.bmp', #0, 10);

    if (Common.Member.Stamp+Common.PreSent.SaveStamp-Common.PreSent.UseStamp) mod 10 > 0 then
      vStamp := vStamp +  SetImage(Common.AppPath+'\DLL\Stamp.bmp', #0, (Common.Member.Stamp+Common.PreSent.SaveStamp-Common.PreSent.UseStamp) mod 10);

    Result := Replace(Result, rptStamp, vStamp);
  end;

  //전자서명 이미지
  if (Pos(rptSignImage0, AValue) > 0) and (FileExists(Common.AppPath+'Sign0.bmp')) then
    Result := Replace(Result, rptSignImage0,     SetImage(Common.AppPath+'Sign0.bmp', #3));
  if (Pos(rptSignImage1, AValue) > 0) and (FileExists(Common.AppPath+'Sign1.bmp')) then
    Result := Replace(Result, rptSignImage1,     SetImage(Common.AppPath+'Sign1.bmp', #3));
  if (Pos(rptSignImage2, AValue) > 0) and (FileExists(Common.AppPath+'Sign2.bmp')) then
    Result := Replace(Result, rptSignImage2,     SetImage(Common.AppPath+'Sign2.bmp', #3));
  if (Pos(rptSignImage3, AValue) > 0) and (FileExists(Common.AppPath+'Sign3.bmp')) then
    Result := Replace(Result, rptSignImage3,     SetImage(Common.AppPath+'Sign3.bmp', #3));
  if (Pos(rptSignImage4, AValue) > 0) and (FileExists(Common.AppPath+'Sign4.bmp')) then
    Result := Replace(Result, rptSignImage4,     SetImage(Common.AppPath+'Sign4.bmp', #3));
  if (Pos(rptSignImage5, AValue) > 0) and (FileExists(Common.AppPath+'Sign5.bmp')) then
    Result := Replace(Result, rptSignImage5,     SetImage(Common.AppPath+'Sign5.bmp', #3));
  if (Pos(rptSignImage6, AValue) > 0) and (FileExists(Common.AppPath+'Sign6.bmp')) then
    Result := Replace(Result, rptSignImage6,     SetImage(Common.AppPath+'Sign6.bmp', #3));
  if (Pos(rptSignImage7, AValue) > 0) and (FileExists(Common.AppPath+'Sign7.bmp')) then
    Result := Replace(Result, rptSignImage7,     SetImage(Common.AppPath+'Sign7.bmp', #3));
  if (Pos(rptSignImage8, AValue) > 0) and (FileExists(Common.AppPath+'Sign8.bmp')) then
    Result := Replace(Result, rptSignImage8,     SetImage(Common.AppPath+'Sign8.bmp', #3));
  if (Pos(rptSignImage9, AValue) > 0) and (FileExists(Common.AppPath+'Sign9.bmp')) then
    Result := Replace(Result, rptSignImage9,     SetImage(Common.AppPath+'Sign9.bmp', #3));
end;

procedure TDevice.KitchenOrderPrint(AIndex: Integer);
  function CheckFloor(aValue:String):Boolean;
  var I :Integer;
  begin
    Result := False;
    While aValue <> '' do
    begin
       I := Pos(',',aValue);
       if I > 0 then
       begin
          if Copy(aValue,1,I-1) = Common.Table.Floor then
          begin
            Result := True;
            Break;
          end;
          Delete(aValue,1,I);
       end
       else
       begin
          if aValue = Common.Table.Floor then
          begin
            Result := True;
            Break;
          end;
          aValue := '';
       end;
    end;

  end;
var vRtn  :String;
    vTemp :String;
    vFailCount :Integer; //무선프린터일때는 한번더 시도하도록(가끔 다시 시도해야되는경우가 있어서)
    vIndex     :Integer;
label go;
begin
  vFailCount := 0;
  with Common do
  begin
    vTemp := KitchenPrinter[AIndex].Data;
    try
      KitchenPrinter[AIndex].Data := Ifthen(GetOption(149)= '1', rptCharInverse, '') + KitchenPrinter[AIndex].Cancel+ Ifthen(GetOption(149)= '1', rptCharNormal, '') +
                                     KitchenPrinter[AIndex].Data;// + rptCharNormal;

      //주문서별로 주문서 출력시 주문서 헤더를 만든다
      if GetOption(9) = '0' then
      begin
        if not Common.OrderRePrint then
        begin
          KitchenPrinter[AIndex].Data := SetOrderPrintHeader(KitchenPrinter[AIndex].Data, AIndex);
          KitchenPrinter[AIndex].Data := PrinterCommendReplace(KitchenPrinter[AIndex].Data,
                                                               KitchenPrinter[AIndex].Device,
                                                               KitchenPrinter[AIndex].Col,
                                                               KitchenPrinter[AIndex].BottomMargin);
        end;
      end;
      go:
      Common.ShowWaitForm;
      Application.ProcessMessages;
      if Common.isReceiptToKitehcn and KitchenPrinter[AIndex].Link then
      begin
        PrintData := KitchenPrinter[AIndex].Data;
        for vIndex := 1 to KitchenPrinter[aIndex].Count do
          PrintPrinter;
        vRtn := 'OK';
      end
      else
      begin
        vRtn := OrderSend('2',
                           KitchenPrinter[AIndex].Code,
                           KitchenPrinter[AIndex].Data,
                           KitchenPrinter[AIndex].IP,
                           ifThen(KitchenPrinter[AIndex].Port = 'E',
                                  KitchenPrinter[AIndex].EthernetIP,
                                  KitchenPrinter[AIndex].Port)
                           );
      end;

      HideWaitForm;
      ShowWaitForm('주방에 주문서를 출력 중 입니다...');
      if (KitchenPrinter[AIndex].Port = 'E') and (vRtn <> 'OK') and (vFailCount = 0) then
      begin
        Inc(vFailCount);
        goto go
      end;
      if vRtn <> 'OK' then
      begin
        if not Common.Config.IsKiosk then
        begin
          if AskBox('[ 주방주문서 ]'+#13+KitchenPrinter[AIndex].Name+' 프린터에'+#13+
                    '출력하지 못했습니다'+#13+
                    '다시시도 하시겠습니까?') then
          begin
            Inc(vFailCount);
            goto go
          end
          else
          begin
            //영수증을 주방프린터에 출력하지 않을때
            if (Config.ReceiptPrinterDev <> prtNone) and (not Config.RcpToKitchen) then
            begin
              if AskBox('영수증 프린터에 주방주문서를'+#13+'출력하시겠습니까?') then
              begin
                PrintData := KitchenPrinter[AIndex].Data;
                PrintPrinter(rptNone);
              end
              else
              begin
                Common.HideWaitForm;
                Exit;
              end;
            end
            else
            begin
              Common.HideWaitForm;
              Exit;
            end;
          end;
        end
        else
        begin
          //키오스크는 2번 시도해본다
          if vFailCount < 1 then
          begin
            Inc(vFailCount);
            goto go
          end
          else
          begin
            //영수증을 주방프린터에 출력하지 않을때
            if (Config.ReceiptPrinterDev <> prtNone) and (not Config.RcpToKitchen) then
            begin
              Common.HideWaitForm;
              MsgBox('주방에 주문서를 출력하지 못했습니다'#13'주문서를 주방에 전달 부탁드립니다');
              Common.KakaoSendMessage('P',['출력실패'+#13
                                      +'주방에 주문서를 출력하지 못했습니다'],'');

              PrintData := KitchenPrinter[AIndex].Data;
              PrintPrinter(rptNone);
            end
            else
            begin
              Common.HideWaitForm;
              Exit;
            end;
          end;
        end;
      end;
      Common.HideWaitForm;
    finally
      KitchenPrinter[AIndex].Data := vTemp;
    end;
  end;
end;

procedure TDevice.CustomerOrderPrint(aOrderNo,AType:Integer);
var
    vNumber, vNumber1, vTemp :String;
    vIdx    :Integer;
    vCustPrinterCode : String;
label go;
begin
  //고객주문서를 첫장만 출력
  if (GetOption(73) = '1') and (Common.OrderKind = okAppend) then Exit;

  if (Common.Table.OrderType = 'D') and (LeftStr(Common.Table.Name, 2) = '배달') then Exit;
  with Common  do
  begin
    case Common.TableMode of
      tbmNone :
      begin
        if GetOption(25) = '0' then
          vNumber := IntToStr(Common.Table.Number)
        else
          vNumber := Common.Table.Name;
      end;
      else
      begin
        if Assigned(Table_F) and (GetOption(25) = '0') and (Table.OrderType = 'T') then
          vNumber := IntToStr(Table_F.ToTable.Number)
        else if Assigned(Table_F) then
          vNumber := Table_F.ToTable.Name;
      end;
    end;

    if (AType = 1) and Assigned(Table_F) then
    begin
      if GetOption(25) = '0' then
        vNumber1 := IntToStr(Table_F.FromTable.Number)
      else
        vNumber1 := Table_F.FromTable.Name;
    end;

    PrintData := EmptyStr;
    //상단여백
    for vIdx := 0 to StoI(GetOption(435)) do
      PrintData := PrintData + rptLF;

    PrintData := PrintData + rptAlignCenter;
    case StoI(GetOption(108)) of
      1 : PrintData := PrintData + rptSizeNormal + Config.CustOrderTitle+#13;
      2 : PrintData := PrintData + rptSizeHeight + Config.CustOrderTitle+#13;
      3 : PrintData := PrintData + rptSizeWidth  + Config.CustOrderTitle+#13;
      4 : PrintData := PrintData + rptSizeBoth   + Config.CustOrderTitle+#13;
    end;

    PrintData := PrintData + rptAlignCenter;
    if not Common.OrderRePrint then
      if Common.OrderKind = okAppend then
        case StoI(GetOption(109)) of
          1 : PrintData := PrintData + rptSizeNormal + '[ 추가주문 ]'+#13;
          2 : PrintData := PrintData + rptSizeHeight + '[ 추가주문 ]'+#13;
          3 : PrintData := PrintData + rptSizeBoth   + '[추가주문]'+#13;
        end;

    // 고객주문서에 영수증 상단문구를 출력합니다.
    if GetOption(162) = '1' then
    begin
      PrintData := PrintData + rptAlignLeft;
      PrintData := PrintData + rptSizeNormal;
      PrintData := PrintData + rptLF;
      For vIdx := 1 to 4 do
        if Trim(Config.ReceiptTitle[vIdx]) <> '' then  AddPrintData(Config.ReceiptTitle[vIdx]);
    end;

    //키오스크 or 푸드코트일때
    if Common.Config.isKiosk or ((Common.Config.IsTakeOut) and (GetOption(231) = '1') and (GetOption(233) = '1')) then
    begin
      PrintData := PrintData + rptAlignCenter;
      PrintData := PrintData + rptSizeBoth   + Format('주문번호 - %s',[FormatFloat('0000', Ifthen(Common.Config.IsKiosk, Common.Table.OrderNo, aOrderNo))])+#13;
      PrintData := PrintData + rptLF;
    end
    else if PrintData <> rptAlignCenter then
      PrintData := PrintData + rptLF;

    PrintData := PrintData + rptAlignLeft;

    if not Common.OrderRePrint then
      case StoI(GetOption(110)) of
        1 : PrintData := PrintData + rptSizeNormal;
        2 : PrintData := PrintData + rptSizeHeight;
        3 : PrintData := PrintData + rptSizeBoth;
      end;

    if (not Common.Config.IsTakeOut) and (GetOption(110) <> '0') then // 선불제가 아닐경우
    begin
      if (aType = 1) and Assigned(Table_F) then
      begin
        if (GetOption(58) = '0') and (High(Common.FloorData) > 0) and (Common.Table.OrderType <> 'D') then
          PrintData := PrintData + Format('[이동] %s-%s => %s-%s',[Table_F.FromTable.FloorName, vNumber1, Common.Table.FloorName, vNumber])+#13
        else
          PrintData := PrintData + Format('[이동] %s => %s',[vNumber1, vNumber])+#13
      end;

      if (vNumber <> '') and (GetOption(58) = '0') and (High(Common.FloorData) > 0) and (Common.Table.OrderType <> 'D') then
        PrintData := PrintData + '테이블 : '+ Common.Table.FloorName +' - '+  vNumber + #13
      else if (vNumber <> '') then 
        PrintData := PrintData + '테이블 : '+  vNumber + #13;
    end;

    if Common.OrderRePrint then
      PrintData := PrintData + rptSizeNormal;

    if not Common.OrderRePrint then
      case StoI(GetOption(111)) of
        1 : PrintData := PrintData + rptSizeNormal;
        2 : PrintData := PrintData + rptSizeHeight;
        3 : PrintData := PrintData + rptSizeBoth;
      end;

    if (GetOption(111) <> '0') and (Common.Table.OrderType <> 'D') then
    begin
      if (GetOption(138) = '0') or (Common.Table.AgeCode.Count=0) then
        PrintData := PrintData + '고객수 : ' + IntToStr(Common.Table.CustomerCount)+' 명' + #13
      else
        PrintData := PrintData + '고객수 : ' + Common.GetAgePerson(Common.Table) + #13;
    end;

    //테이블메모
    if (GetOption(370) <> '0') and (Common.Table.Memo <> EmptyStr) then
    begin
      PrintData := PrintData + rptAlignLeft;
      PrintData := PrintData + '-메모-'+#13;
      case StoI(GetOption(370)) of
          1 : PrintData := PrintData + rptSizeNormal;
          2 : PrintData := PrintData + rptSizeHeight;
      end;
      PrintData := PrintData + Common.Table.Memo+#13;
    end;

    if not Common.OrderRePrint then
      case StoI(GetOption(112)) of
        1 : PrintData := PrintData + rptSizeNormal;
        2 : PrintData := PrintData + rptSizeHeight;
      end;

    if (GetOption(112) <> '0') then
    begin
      PrintData := PrintData + rptTwoLine+#13;
      if GetOption(409) = '0' then
        PrintData := PrintData + pStr+'      메     뉴 '+pStr+'            수량      금액'+#13
      else
        PrintData := PrintData + pStr+'           메     뉴      '+pStr+'            수량'+#13;

      PrintData := PrintData + rptTwoLine+#13;
    end
    else
    begin
      if not Common.OrderRePrint then
        case StoI(GetOption(113)) of
          0,1 : PrintData := PrintData + rptSizeNormal;
            2 : PrintData := PrintData + rptSizeHeight;
        end;
      PrintData := PrintData + rptOneLine+#13;
    end;

    //메뉴별 줄간격
    if (GetOption(114) = '1') then PrintData := PrintData + #13;

    if not Common.OrderRePrint then
      case StoI(GetOption(113)) of
        1 : PrintData := PrintData + rptSizeNormal;
        2 : PrintData := PrintData + rptSizeHeight;
      end;


    //최종주문서를 재인쇄시에는 메뉴내역을 출력한다
    if (GetOption(113) <> '0') or Common.CustomerPrintLast then
    begin
      PrintData := PrintData + CustomerCancel + CustomerPrinter;
      PrintData := PrintData + rptOneLine+#13;
    end;
    // 푸드코트 기능을 사용안하거나 코너벌로 주문서 출력을 안할때
    if (GetOption(231) = '0') or (GetOption(233) = '0') then
    begin
      //환경설정에서 부가세금액을 출력한다고 했으면
      if (GetOption(52) = '1') and (GetOption(409) = '0') and (GetOption(152) <> '1') then
      begin
        if Present.TotalDC <> 0 then
          AddPrintData('       할인금액  '+ LPadB('-'+FormatFloat('#,0', PreSent.TotalDC),25+pLen, ' ') );
        if OrderDutyFreeAmt <> 0 then
          AddPrintData('       면세금액  '+ LPadB(FormatFloat('#,0', OrderDutyFreeAmt),25+pLen, ' ') );
        if OrderDutyAmt <> 0 then
          AddPrintData('       과세금액  '+ LPadB(FormatFloat('#,0', OrderDutyAmt),25+pLen, ' ') );
        if OrderVatAmt <> 0 then
          AddPrintData('     부가세금액  '+ LPadB(FormatFloat('#,0', OrderVatAmt),25+pLen, ' ') );
        if OrderTipAmt <> 0 then
          AddPrintData('     봉사료금액  '+ LPadB(FormatFloat('#,0', OrderTipAmt),25+pLen, ' ') );

        PrintData := PrintData + rptOneLine+#13;
      end;

      if ((GetOption(113) <> '0') or Common.CustomerPrintLast) and (GetOption(409) = '0')  then
      begin
        PrintData := PrintData + rptSizeHeight;
        if (GetOption(52) = '0') and (OrderTipAmt <> 0) then
          AddPrintData('     봉사료금액  '+ LPadB(FormatFloat('#,0', OrderTipAmt),25+pLen, ' ') );
        if (GetOption(52) = '0') and (Present.TotalDC <> 0) then
          AddPrintData('       할인금액  '+ LPadB('-'+FormatFloat('#,0', PreSent.TotalDC),25+pLen, ' ') );
        AddPrintData('   주문합계금액  '+ LPadB(FormatFloat('#,0', OrderAmt-Present.TotalDC+Present.SpcDc),25+pLen, ' ') );
        PrintData := PrintData + rptSizeNormal;
        AddPrintData(rptTwoLine);
      end;
    end;

    if Pos('*', CustomerPrinter) > 0 then
      AddPrintData('  * 표시는 부가세 별도 메뉴입니다         ');

    //키오스크 or 푸드코트일때
    if Common.Config.isKiosk then
    begin
      PrintData := PrintData + rptAlignLeft;
      PrintData := PrintData + rptSizeNormal + Format('영수증번호 : %s-%s-%s',[Common.WorkDate, Common.Config.PosNo, Common.PreSent.RcpNo]) +#13;
    end;

    if not Common.OrderRePrint then
      case StoI(GetOption(115)) of
        1 : PrintData := PrintData + rptSizeNormal;
        2 : PrintData := PrintData + rptSizeHeight;
        3 : PrintData := PrintData + rptSizeBoth;
      end;

    if (GetOption(115) <> '0') then
      PrintData := PrintData + '테이블담당 : '+Common.Table.DamdangName + #13;

    //주문시간
    if not Common.OrderRePrint then
      if (Common.Table.OrderNo > 0) and ((GetOption(231) = '0') ) and not Common.Config.isKiosk then
      begin
        case StoI(GetOption(117)) of
          0 :
          begin
            case StoI(GetOption(116)) of
              1 : PrintData := PrintData + rptSizeNormal + '주문번호 : '+IntToStr(Common.Table.OrderNo)+#13;
              2 : PrintData := PrintData + rptSizeHeight + '주문번호 : '+IntToStr(Common.Table.OrderNo)+#13;
              3 : PrintData := PrintData + rptSizeBoth   + '주문번호 : '+IntToStr(Common.Table.OrderNo)+#13;
            end;
          end;
          1 :
          begin
            case StoI(GetOption(116)) of
              0: PrintData := PrintData + rptSizeNormal + '주문시간   : '+ FormatDateTime('yyyy년 mm월 dd일 hh시 nn분', Now())+#13;
              1: PrintData := PrintData + rptSizeNormal + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now()) + rptSizeNormal
                                        + LPadB('주문번호 : '+IntToStr(Common.Table.OrderNo), 23+pLen, ' ')+#13;
              2: PrintData := PrintData + rptSizeNormal + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now()) + rptSizeHeight
                                        + LPadB('주문번호 : '+IntToStr(Common.Table.OrderNo), 23+pLen, ' ')+#13;
              3: PrintData := PrintData + rptSizeNormal + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now()) + rptSizeBoth
                                        + ' 주문번호 '+IntToStr(Common.Table.OrderNo)+#13;
            end;
          end;
          2 :
          begin
            case StoI(GetOption(116)) of
              0: PrintData := PrintData + rptSizeHeight + '주문시간   : '+ FormatDateTime('yyyy년 mm월 dd일 hh시 nn분', Now())+#13;
              1: PrintData := PrintData + rptSizeHeight + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now()) + rptSizeNormal
                                        + LPadB('주문번호 : '+IntToStr(Common.Table.OrderNo), 23+pLen, ' ')+#13;
              2: PrintData := PrintData + rptSizeHeight + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now()) + rptSizeHeight
                                        + LPadB('주문번호 : '+IntToStr(Common.Table.OrderNo), 23+pLen, ' ')+#13;
              3: PrintData := PrintData + rptSizeHeight + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now()) + rptSizeBoth
                                        + ' 주문번호 '+IntToStr(Common.Table.OrderNo)+#13;
            end;
          end;
          3 :
          begin
            case StoI(GetOption(116)) of
              0: PrintData := PrintData + rptSizeBoth + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now())+#13;
              1: PrintData := PrintData + rptSizeBoth + FormatDateTime('mm-dd hh:nn:ss', Now()) + rptSizeNormal
                                        + LPadB(IntToStr(Common.Table.OrderNo), 14+pLen, ' ')+#13;
              2: PrintData := PrintData + rptSizeBoth + FormatDateTime('mm-dd hh:nn:ss', Now()) + rptSizeHeight
                                        + LPadB(IntToStr(Common.Table.OrderNo), 14+pLen, ' ')+#13;
              3: PrintData := PrintData + rptSizeBoth   + FormatDateTime('mm-dd hh:nn:ss', Now()) + rptSizeBoth
                                        + LPadB(IntToStr(Common.Table.OrderNo), 7+(pLen div 2), ' ')+#13;
            end;
          end;
        end;
      end
      else
      begin
        case StoI(GetOption(117)) of
          1 : PrintData := PrintData + rptSizeNormal + '주문시간   : '+ FormatDateTime('yyyy년 mm월 dd일 hh시 nn분', Now())+#13;
          2 : PrintData := PrintData + rptSizeHeight + '주문시간   : '+ FormatDateTime('yyyy년 mm월 dd일 hh시 nn분', Now())+#13;
          3 : PrintData := PrintData + rptSizeBoth + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now())+#13;
        end;
      end;


    //호출번호 출력
    if not Common.OrderRePrint then
      if Common.PreSent.CallNo > 0 then
      begin
        PrintData := PrintData + rptAlignCenter;
        case StoI(GetOption(313)) of
          1 : PrintData :=PrintData + rptSizeNormal   + Format('호출번호 - %d',[Common.PreSent.CallNo])+#13;
          2 : PrintData :=PrintData + rptSizeHeight   + Format('호출번호 - %d',[Common.PreSent.CallNo])+#13;
          3 : PrintData :=PrintData + rptSizeBoth     + Format('호출번호 - %d',[Common.PreSent.CallNo])+#13;
          4 : PrintData :=PrintData + rptSize3Times   + Format('호출번호 - %d',[Common.PreSent.CallNo])+#13;
        end;
        PrintData := PrintData + rptAlignLeft;
      end;

    PrintData := PrintData + rptSizeNormal;

    //고객주문서 하단문구(최종거를 출력할때 제외)
    if not Common.CustomerPrintLast then
      For vIdx := 0 to High(Config.CustRcpEnd) do
        AddPrintData(Config.CustRcpEnd[vIdx]);

    //하단여백
    for vIdx := 0 to StoI(GetOption(436)) do
      PrintData := PrintData + rptLF;

    if not Common.OrderRePrint then
      BefCustomerOrder := PrintData;

    //고객주문서 설정매수 만큼 출력
    vTemp := PrintData;
    vCustPrinterCode := Common.Config.CustPrinterCode;
    For vIdx := 1 to StoI(GetOption(39)) do
    begin
      PrintData := vTemp;
      PrintPrinter(rptCustOrder);
    end;

    //고객주문서를 두군데 출력할때
    if Common.Config.CustPrinter2Code <> '' then
    begin
      Common.Config.CustPrinterCode := Common.Config.CustPrinter2Code;
      For vIdx := 1 to StoI(GetOption(39)) do
      begin
        PrintData := vTemp;
        PrintPrinter(rptCustOrder);
      end;
      Common.Config.CustPrinterCode := vCustPrinterCode;
    end;
  end;

  Common.CustomerCancel  := EmptyStr;
  Common.CustomerPrinter := EmptyStr;
  Common.OrderAmt        := 0;
end;

procedure TDevice.TableWork(aGrid:TStringGrid=nil;aKind:Integer=0);
var I, II, vSeq :Integer;
    vTemp, vMaster, vPrtMaster, vBefKitchen,
    vGroupTxt, vMasterQty :String;
    aCustomerSubMenuPrint,
    aKitchenSubMenuPrint :String;
    vOnlyCustomerPrint :Boolean;
    vMenuName :String;
begin
  Common.ClearKitchenData;
  Common.CustomerPrinter := EmptyStr;
  vSeq := 0;
  case Common.TableMode of
    tbmTableMoveing, tbmMergeing :
      begin
        OpenQuery('select a.NM_MENU, '
                 +'       a.QTY_ORDER, '
                 +'       a.CD_PRINTER, '
                 +'       a.AMT_ORDER, '
                 +'       a.DC_SPC,'
                 +'       a.DS_MENU_TYPE, '
                 +'       a.MEMO, '
                 +'       b.DS_KITCHEN, '
                 +'       b.NO_GROUP, '
                 +'       a.DS_SALE,'
                 +'       c.CNT_PERSON, '
                 +'       a.DS_TAX, '
                 +'       a.NO_STEP, '
                 +'       a.CD_MENU1, '
                 +'       a.SEQ, '
                 +'       a.CD_MENU, '
                 +'       a.YN_DOUBLE, '
                 +'       Substring(b.CONFIG,5,1) as YN_BILL, '
                 +'       a.PR_ITEM, '
                 +'       b.NM_MENU_KITCHEN '
                 +'  from SL_ORDER_D a inner join '
                 +'       MS_MENU    b on b.CD_STORE = a.CD_STORE '
                 +'                   and b.CD_MENU  = a.CD_MENU  inner join '
                 +'       SL_ORDER_H c on c.CD_STORE = a.CD_STORE '
                 +'                   and c.NO_TABLE = a.NO_TABLE '
                 +'                   and c.DS_ORDER = a.DS_ORDER '
                 +' where a.CD_STORE =:P0 '
                 +'   and a.NO_TABLE =:P1 '
                 +'order by a.SEQ, a.NO_STEP ',
                 [Common.Config.StoreCode,
                  Table_F.ToTable.Number]);
        Common.Table := Table_F.ToTable;
        Common.Table.CustomerCount := Common.Query.FieldByName('cnt_person' ).AsInteger;
        vPrtMaster := '';
        while not Common.Query.Eof do
        begin
          vOnlyCustomerPrint := false;
          if Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'N' then                                      //메뉴구분
             vMenuName := Common.Query.FieldByName('NM_MENU').AsString
           else if (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'W') then
             vMenuName := 'ⓦ'+Common.Query.FieldByName('NM_MENU').AsString
           else if (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'S') and (Common.Query.FieldByName('NO_STEP').AsInteger = 0) then
             vMenuName := 'ⓢ'+Common.Query.FieldByName('NM_MENU').AsString
           else if (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'S') and (Common.Query.FieldByName('NO_STEP').AsInteger > 0) then
             vMenuName := '-'+Common.Query.FieldByName('NM_MENU').AsString
           else if (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'I') and (Common.Query.FieldByName('NO_STEP').AsInteger = 0) then
             vMenuName := 'ⓘ'+Common.Query.FieldByName('NM_MENU').AsString
           else if (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'I') and (Common.Query.FieldByName('NO_STEP').AsInteger > 0) then
             vMenuName := '-'+Common.Query.FieldByName('NM_MENU').AsString
           else if (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'O') and (Common.Query.FieldByName('NO_STEP').AsInteger > 0) then
             vMenuName := '-'+Common.Query.FieldByName('NM_MENU').AsString
           else if (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'O') and (Common.Query.FieldByName('NO_STEP').AsInteger = 0) then
             vMenuName := 'ⓞ'+Common.Query.FieldByName('NM_MENU').AsString
           else if (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'C') and (Common.Query.FieldByName('NO_STEP').AsInteger = 0) then
             vMenuName := 'ⓒ'+Common.Query.FieldByName('NM_MENU').AsString
           else if (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'C') and (Common.Query.FieldByName('NO_STEP').AsInteger > 0) then
             vMenuName := '-'+Common.Query.FieldByName('NM_MENU').AsString
           else if (Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'G') and (Common.Query.FieldByName('NO_STEP').AsInteger = 0) then
             vMenuName := 'ⓖ'+Common.Query.FieldByName('NM_MENU').AsString
           else vMenuName := Common.Query.FieldByName('NO_STEP').AsString;


          //세트,코스,오픈세트 출력 시 부메뉴 설정 주방으로 출력합니다
          if GetOption(241) = '1' then
          begin
            if (Common.Query.FieldByName('NO_STEP').AsInteger = 0) and (Common.Query.FieldByName('DS_MENU_TYPE' ).AsString[1] in ['C','O','S']) then
            begin
              vMaster    := Common.Query.FieldByName('DS_MENU_TYPE' ).AsString + Common.Query.FieldByName('NM_MENU').AsString;
              vMasterQty := Common.GetQtyReplace(Common.Query.FieldByName('DS_MENU_TYPE').AsString,
                                                 Common.Query.FieldByName('QTY_ORDER').AsString);
              vPrtMaster := vMaster;
              vSeq    := 0;
              vOnlyCustomerPrint := true;
            end
            else
            begin
              if Common.Query.FieldByName('CD_MENU1').AsString = '' then
                vPrtMaster := ''
              else
                Inc(vSeq);

              //부메뉴 첫번째만 주메뉴를 출력하기 위함
              if (vPrtMaster <> '') and (vSeq > 1) then vPrtMaster := '';

              if (Common.Query.FieldByName('CD_MENU1').AsString <> '') and (vBefKitchen <> Common.Query.FieldByName('CD_PRINTER').AsString) then
              begin
                 vPrtMaster  := vMaster;
                 vBefKitchen := Common.Query.FieldByName('CD_PRINTER').AsString;
              end;
            end;
          end;

          if (Common.Query.FieldByName('CD_MENU1').AsString <> '') and (GetOption(338) = '1') then
            aCustomerSubMenuPrint := 'N'
          else
            aCustomerSubMenuPrint := 'Y';

          if (Common.Query.FieldByName('CD_MENU1').AsString <> '') and (GetOption(354) = '1') then
            aKitchenSubMenuPrint := 'N'
          else
            aKitchenSubMenuPrint := 'Y';


          PrintKitchen(Ifthen(vOnlyCustomerPrint,'', Common.Query.FieldByName('CD_PRINTER').AsString),
                       vMenuName,
                       Common.Query.FieldByName('CD_MENU1').AsString,
                       Common.Query.FieldByName('MEMO').AsString,
                       Common.GetQtyReplace(Common.Query.FieldByName('DS_MENU_TYPE').AsString,
                                            Common.Query.FieldByName('QTY_ORDER').AsString),
                       IntToStr(Common.Query.FieldByName('AMT_ORDER').AsInteger - (Common.Query.FieldByName('QTY_ORDER').AsInteger *  Common.Query.FieldByName('PR_ITEM').AsInteger)),
                       Common.Query.FieldByName('DC_SPC').AsString,
                       Common.Query.FieldByName('DS_KITCHEN').AsString,
                       Common.Query.FieldByName('DS_MENU_TYPE').AsString,
                       Common.Query.FieldByName('DS_SALE').AsString,
                       Common.Query.FieldByName('DS_TAX').AsString,
                       '',
                       vPrtMaster,
                       vMasterQty,
                       Common.Query.FieldByName('CD_MENU').AsString,
                       Common.Query.FieldByName('NO_GROUP').AsInteger,
                       Common.Query.FieldByName('SEQ').AsInteger,
                       Common.Query.FieldByName('NO_STEP').AsInteger,
                       Common.Query.FieldByName('QTY_ORDER').AsInteger,
                       aCustomerSubMenuPrint,
                       aKitchenSubMenuPrint,
                       Common.Query.FieldByName('YN_BILL').AsString,
                       Common.Query.FieldByName('YN_DOUBLE').AsString,
                       Common.Query.FieldByName('NM_MENU_KITCHEN').AsString);

          Common.Query.Next;
        end;
      end;
    tbmMenuMoveing :  //메뉴이동
      begin
        vMaster := '';
        vSeq    := 0;
        For I := 0 to aGrid.RowCount-1 do
        begin
          if aGrid.Cells[6, I] = 'S' then Continue;

          if GetOption(241) = '1' then
          begin
            if (aGrid.Cells[5, I] = '0') and (aGrid.Cells[11, I][1] in ['C','O','S','I']) then
            begin
              vMaster := aGrid.Cells[11, I] + aGrid.Cells[1, I];
              vMasterQty  := Common.GetQtyReplace( aGrid.Cells[8, I], aGrid.Cells[2, I]);
              vPrtMaster  := vMaster;
              vSeq    := 0;
              Continue;
            end
            else
            begin
              if aGrid.Cells[16, I] = '' then vPrtMaster := ''
              else Inc(vSeq);

              if (vPrtMaster <> '') and (vSeq > 1) then vPrtMaster := '';

              if (aGrid.Cells[16, I] <> '') and (vBefKitchen <> aGrid.Cells[7,  I]) then
              begin
                 vPrtMaster  := vMaster;
                 vBefKitchen := aGrid.Cells[7,  I];
              end;

            end;
          end;

          if (aGrid.Cells[16,    I] <> '') and (GetOption(338) = '1') then
            aCustomerSubMenuPrint := 'N'
          else
            aCustomerSubMenuPrint := 'Y';

          if (aGrid.Cells[16,    I] <> '') and (GetOption(354) = '1') then
            aKitchenSubMenuPrint := 'N'
          else
            aKitchenSubMenuPrint := 'Y';

          PrintKitchen(aGrid.Cells[7,  I],
                       StringReplace(aGrid.Cells[1,  I], ' '+aGrid.Cells[10, I],'',[rfReplaceAll]),   //주방메모는 뺀다
                       aGrid.Cells[16, I],                        //cd_menu1
                       aGrid.Cells[10, I],                        //memo
                       Common.GetQtyReplace( aGrid.Cells[8, I], aGrid.Cells[2, I]),
                       aGrid.Cells[13, I],                        //amt_order
                       aGrid.Cells[14, I],                        //dc_spc
                       '0',                                       //ds_kitchen
                       aGrid.Cells[8, I],                         //ds_menu_type
                       aGrid.Cells[11, I],                        //ds_sale
                       aGrid.Cells[15, I],                        //ds_tax
                       '',                                        //corner
                       vPrtMaster,
                       vMasterQty,
                       aGrid.Cells[3, I],                         //cd_menu
                       StrToIntDef(aGrid.Cells[12, I],0),         //no_group
                       StrToIntDef(aGrid.Cells[4, I],0),          //seq
                       StrToIntDef(aGrid.Cells[5, I],0),          //no_step
                       StrToIntDef(aGrid.Cells[2, I],0),          //realqty
                       aCustomerSubMenuPrint,
                       aKitchenSubMenuPrint,
                       aGrid.Cells[19, I],                        //yn_bill
                       aGrid.Cells[20, I],                        //yn_double
                       aGrid.Cells[21, I]);                       //nm_menu_kitchen
        end;
      end;
  end;

  //고객주문서
  if (GetOption(38) = '1') and (aKind = 0 ) then
  begin
    Common.Table.Number         := Table_F.ToTable.Number;
    Common.Table.Name           := Table_F.ToTable.Name;
    Common.Table.DamdangName    := Table_F.ToTable.DamdangName;
    Common.OrderKind     := okNone;
    Common.Table.OrderNo := 0;
//    Common.CustomerPrinter := EmptyStr;
//    Common.GetAllCustomerOrder;
    Common.Present.CutDc   := AmtofCut(Common.OrderAmt, StrToIntDef(GetOption(153),0));
    Common.PreSent.TotalDC := Common.PreSent.TotalDC + Common.Present.CutDc;
    Common.Device.CustomerOrderPrint(0,1);
  end;


  //주방주문서
  if GetOption(12) = '1' then
  begin
    //주방주문서를 메뉴별로 출력하면서 그룹을 사용시 그룹으로 지정된 내역을 주방주문서 헤더를 만든다
    if (GetOption(9) = '1') and (GetOption(79) = '1') then
    begin
      For I := 0 to High(Common.KitchenPrinter) do
      begin
        vGroupTxt := '';
        For II := 1 to 100 do
          vGroupTxt := vGroupTxt + Common.KitchenPrinter[I].GroupSource[II];
        if vGroupTxt = '' then Continue;

        vTemp := Common.Device.SetOrderPrintHeader(vGroupTxt, I);
        Common.KitchenPrinter[I].Data := Common.KitchenPrinter[I].Data +
                                         Common.Device.PrinterCommendReplace(vTemp,
                                                                             Common.KitchenPrinter[I].Device,
                                                                             Common.KitchenPrinter[I].Col,
                                                                             Common.KitchenPrinter[I].BottomMargin );
      end;
    end;

    For I := 0 to High(Common.KitchenPrinter) do
    begin
      if (Common.KitchenPrinter[I].Data   = EmptyStr) and
         (Common.KitchenPrinter[I].Cancel = EmptyStr) then Continue;

      KitchenOrderPrint(I);
    end;
  end;

  Common.ClearKitchenData;
end;

procedure TDevice.DeliveryPrint(aCount:Integer=1);
var I : Integer;
    lsStr, vTemp :String;
begin
  if GetOption(368) = '0' then
    with DeliveryInfo_F, Common do
    begin
      PrintData := EmptyStr;
      case StoI(GetOption(121)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
        4 : AddPrintData(rptSizeBoth);
      end;
      AddPrintData(rptAlignCenter);
      if StoI(GetOption(121)) > 0 then
      begin
        if DeliveryButton.Appearance.SimpleLayout then AddPrintData('배 달 전 표')
        else                                           AddPrintData('포 장 전 표');
      end;

      AddPrintData(rptAlignLeft);
      if StoI(GetOption(121)) > 0 then
        AddPrintData(rptLF);
      case StoI(GetOption(271)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
        4 : AddPrintData(rptSizeBoth);
      end;

      if StoI(GetOption(271)) > 0 then
        AddPrintData('배달번호 : '+ lblDeliveryNo.Caption);

      case StoI(GetOption(272)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
      end;

      if StoI(GetOption(272)) > 0 then
        AddPrintData('주문시간 : '+ lblOrderDate.Caption);


      case StoI(GetOption(273)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
        4 : AddPrintData(rptSizeBoth);
      end;

      if (StoI(GetOption(273)) > 0) and (edt_CustName.Text <> '') then
        AddPrintData('고 객 명 : '+ edt_CustName.Text);

      case StoI(GetOption(274)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
        4 : AddPrintData(rptSizeBoth);
      end;
      if (StoI(GetOption(274)) > 0) and (Trim(edt_TelNo1.Text) <> '') then
        AddPrintData('연락처 1 : '+ edt_TelNo1.Text);

      case StoI(GetOption(275)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
        4 : AddPrintData(rptSizeBoth);
      end;

      if (StoI(GetOption(275)) > 0) and (Trim(edt_TelNo2.Text) <> '') then
        AddPrintData('연락처 2 : '+ edt_TelNo2.Text);

      case StoI(GetOption(276)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeBoth);
      end;

      if StoI(GetOption(276)) > 0 then
      begin
        if Trim(edt_Address1.Text) <> EmptyStr then
          AddPrintData(edt_Address1.Text);
        if Trim(edt_Address2.Text) <> EmptyStr then
          AddPrintData(edt_Address2.Text);
      end;

      if (StoI(GetOption(277)) > 0) and (Trim(RequestRemarkMemo.Text) <> EmptyStr) then
      begin
        AddPrintData('특이사항');
        case StoI(GetOption(277)) of
          1 : AddPrintData(rptSizeNormal);
          2 : AddPrintData(rptSizeHeight);
          3 : AddPrintData(rptSizeWidth);
          4 : AddPrintData(rptSizeBoth);
        end;
        For I := 0 to RequestRemarkMemo.Lines.Count-1 do
          AddPrintData(RequestRemarkMemo.Lines[I]);
      end;

      if GetOption(278) = '1' then
      begin
        AddPrintData(rptSizeNormal);
        AddPrintData(rptOneLine);
        if GetOption(279) <> '3' then
          AddPrintData(pStr+'    메 뉴 명 '+pStr+'          단가 수량      금액')
        else
          AddPrintData(pStr+'            주 문 메 뉴 ');

        AddPrintData(rptSizeNormal);
        AddPrintData(rptOneLine);
      end;

      case StoI(GetOption(279)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeBoth);
      end;

      if StoI(GetOption(279)) > 0 then
      begin
        with Order_sGrd do
        begin
           For I := 0 to RowCount - 1 do
           begin
             if GetOption(279) <> '3' then
             begin
               if LengthB(Cells[GDM_NM_MENU, I]) < (18+pLen) then
                 lsStr := RPadB(SCopy(Cells[GDM_NM_MENU, I],1,18+pLen),18+pLen,' ')
               else
               begin
                 AddPrintData(RPadB(SCopy(Cells[GDM_NM_MENU, I],1,42+pLen),42+pLen,' '));
                 lsStr := Space(18+pLen);
               end;

               AddPrintData(lsStr + LPadB(FormatFloat('#,##0',   StoI(Cells[GDM_PR_SALE, I])), 9,' ')+
                               LPadB(Cells[GDM_VIEWQTY, I], 5,' ')+
                               LPadB(FormatFloat('#,##0',   StoI(Cells[GDM_AMT,     I])),10,' '));
             end
             else //가로세로 확대일때
             begin
               if pLen = 0 then
                 lsStr := Format('%s(%s)',[SCopy(Cells[GDM_NM_MENU, I],1,18), Cells[GDM_VIEWQTY, I]])
               else
                 lsStr := Format('%s(%s)',[SCopy(Cells[GDM_NM_MENU, I],1,21), Cells[GDM_VIEWQTY, I]]);
               AddPrintData(lsStr);
             end;
           end;
        end;

        AddPrintData(rptSizeNormal);
        AddPrintData(rptOneLine);
        if FDCAmount <> 0 then
        begin
          AddPrintData(rptSizeWidth);
          AddPrintData(pStr+'할인금액'+ LPadB(FormatFloat('#,0',FDCAmount)+' 원',13,' '));
        end;
        AddPrintData(rptSizeWidth);
        AddPrintData(pStr+'합계금액'+ LPadB(lblOrderAmt.Caption,13,' '));
        AddPrintData(rptSizeNormal);
        AddPrintData(rptTwoLine);
      end
      else
      begin
        AddPrintData(rptSizeNormal);
        AddPrintData(rptTwoLine);
      end;

      case StoI(GetOption(280)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
      end;

      if StoI(GetOption(280)) > 0 then
        AddPrintData('출력시간 : '+  FormatDateTime('yyyy-mm-dd hh:nn:ss', Now()));

      case StoI(GetOption(281)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
        4 : AddPrintData(rptSizeBoth);
      end;

      if (StoI(GetOption(281)) > 0) and (not DeliveryButton.Appearance.SimpleLayout) and (GetOption(120) = '0') then
        AddPrintData('배달담당 : '+ lblDeliveryDamdang.Caption);



      case StoI(GetOption(282)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
        4 : AddPrintData(rptSizeBoth);
      end;

      if (StoI(GetOption(282)) > 0) then
        AddPrintData('배달코스 : '+ Common.Table.Course);

      case StoI(GetOption(283)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
        4 : AddPrintData(rptSizeBoth);
      end;

      if (StoI(GetOption(283)) > 0) then
        AddPrintData('배달지역 : '+ Common.Table.Local);

      case StoI(GetOption(191)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
        4 : AddPrintData(rptSizeBoth);
      end;

      if (StoI(GetOption(191)) > 0) then
        AddPrintData('쿠    폰 : '+ CouponButton.Caption);

      For I :=1 to 5 do
        if Common.Config.Delivery_End[I] <> EmptyStr then
          AddPrintData(Common.Config.Delivery_End[I]);

      for I := 1 to aCount do
        PrintPrinter(rptDelivery);
    end
  else
    with DeliveryNew_F, Common do
    begin
      TableViewToStringGrid;
      PrintData := EmptyStr;
      case StoI(GetOption(121)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
        4 : AddPrintData(rptSizeBoth);
      end;
      AddPrintData(rptAlignCenter);
      if StoI(GetOption(121)) > 0 then
      begin
        if DeliveryButton.Appearance.SimpleLayout then AddPrintData('배 달 전 표')
        else                                           AddPrintData('포 장 전 표');
      end;

      AddPrintData(rptAlignLeft);
      if StoI(GetOption(121)) > 0 then
        AddPrintData(rptLF);
      case StoI(GetOption(271)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
        4 : AddPrintData(rptSizeBoth);
      end;

      if StoI(GetOption(271)) > 0 then
      begin
        if DeliveryButton.Appearance.SimpleLayout then
          AddPrintData('배달번호 : '+ lblDeliveryNo.Hint)
        else
          AddPrintData('포장번호 : '+ lblDeliveryNo.Hint);
      end;

      case StoI(GetOption(272)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
      end;

      if StoI(GetOption(272)) > 0 then
        AddPrintData('주문시간 : '+ lblOrderDate.Caption);


      case StoI(GetOption(273)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
        4 : AddPrintData(rptSizeBoth);
      end;

      if (StoI(GetOption(273)) > 0) and (edt_CustName.Text <> '') then
        AddPrintData('고 객 명 : '+ edt_CustName.Text);

      case StoI(GetOption(274)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
        4 : AddPrintData(rptSizeBoth);
      end;
      if (StoI(GetOption(274)) > 0) and (Trim(edt_TelNo1.Text) <> '') then
        AddPrintData('연락처 1 : '+ edt_TelNo1.Text);

      case StoI(GetOption(275)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
        4 : AddPrintData(rptSizeBoth);
      end;

      if (StoI(GetOption(275)) > 0) and (Trim(edt_TelNo2.Text) <> '') then
        AddPrintData('연락처 2 : '+ edt_TelNo2.Text);

      case StoI(GetOption(276)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeBoth);
      end;

      if StoI(GetOption(276)) > 0 then
      begin
        if Trim(edt_Address1.Text) <> EmptyStr then
          AddPrintData(edt_Address1.Text);
        if Trim(edt_Address2.Text) <> EmptyStr then
          AddPrintData(edt_Address2.Text);
      end;

      if (StoI(GetOption(277)) > 0) and (Trim(meo_Remark.Text) <> EmptyStr) then
      begin
        AddPrintData('- 특이사항 -');
        case StoI(GetOption(277)) of
          1 : AddPrintData(rptSizeNormal);
          2 : AddPrintData(rptSizeHeight);
          3 : AddPrintData(rptSizeWidth);
          4 : AddPrintData(rptSizeBoth);
        end;
        For I := 0 to meo_Remark.Lines.Count-1 do
          AddPrintData(meo_Remark.Lines[I]);
      end;

      if GetOption(278) = '1' then
      begin
        AddPrintData(rptSizeNormal);
        AddPrintData(rptOneLine);
        if GetOption(279) <> '3' then
          AddPrintData(pStr+'    메 뉴 명 '+pStr+'          단가 수량      금액')
        else
          AddPrintData(pStr+'            주 문 메 뉴 ');

        AddPrintData(rptSizeNormal);
        AddPrintData(rptOneLine);
      end;

      case StoI(GetOption(279)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeBoth);
      end;

      if StoI(GetOption(279)) > 0 then
      begin
        with FOrderGrid do
        begin
           For I := 0 to RowCount - 1 do
           begin
             if GetOption(279) <> '3' then
             begin
                if LengthB(Cells[GDM_NM_MENU, I]) < (18+pLen) then
                  lsStr := RPadB(SCopy(Cells[GDM_NM_MENU, I],1,18+pLen),18+pLen,' ')
                else
                begin
                  AddPrintData(RPadB(SCopy(Cells[GDM_NM_MENU, I],1,42+pLen),42+pLen,' '));
                  lsStr := Space(18+pLen);
                end;

                AddPrintData(lsStr + LPadB(FormatFloat('#,##0',   StoI(Cells[GDM_PR_SALE, I])), 9,' ')+
                                LPadB(Cells[GDM_VIEWQTY, I], 5,' ')+
                                LPadB(FormatFloat('#,##0',   StoI(Cells[GDM_AMT,     I])),10,' '));
             end
             else
             begin
               if pLen = 0 then
                 lsStr := Format('%s(%s)',[SCopy(Cells[GDM_NM_MENU, I],1,18), Cells[GDM_VIEWQTY, I]])
               else
                 lsStr := Format('%s(%s)',[SCopy(Cells[GDM_NM_MENU, I],1,21), Cells[GDM_VIEWQTY, I]]);
               AddPrintData(lsStr);
             end;

             if edt_CustName.Text = '배달의민족' then
               AddPrintData(Cells[GDM_MEMO, I]);
           end;
        end;

        AddPrintData(rptSizeNormal);
        AddPrintData(rptOneLine);
        if FDCAmount <> 0 then
        begin
          AddPrintData(rptSizeWidth);
          AddPrintData(pStr+'할인금액'+ LPadB(FormatFloat('#,0',FDCAmount)+' 원',13,' '));
        end;
        AddPrintData(rptSizeWidth);
        AddPrintData(pStr+'합계금액'+ LPadB(FormatFloat('#,0',FOrderAmt)+' 원',13,' '));
        AddPrintData(rptSizeNormal);
        AddPrintData(rptTwoLine);
      end
      else
      begin
        AddPrintData(rptSizeNormal);
        AddPrintData(rptTwoLine);
      end;

      case StoI(GetOption(280)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
      end;

      if StoI(GetOption(280)) > 0 then
        AddPrintData('출력시간 : '+  FormatDateTime('yyyy-mm-dd hh:nn:ss', Now()));

      case StoI(GetOption(281)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
        4 : AddPrintData(rptSizeBoth);
      end;

      if (StoI(GetOption(281)) > 0) and (DeliveryButton.Appearance.SimpleLayout) and (GetOption(120) = '0') then
        AddPrintData('배달담당 : '+ lblDeliveryDamdang.Caption);

      case StoI(GetOption(394)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
        4 : AddPrintData(rptSizeBoth);
      end;

      if (StoI(GetOption(394)) > 0) then
      begin
        AddPrintData('결제예상 : '+PayButton.Caption)
      end;

      case StoI(GetOption(282)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
        4 : AddPrintData(rptSizeBoth);
      end;

      if (StoI(GetOption(282)) > 0) then
        AddPrintData('배달코스 : '+ Common.Table.Course);

      case StoI(GetOption(283)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
        4 : AddPrintData(rptSizeBoth);
      end;

      if (StoI(GetOption(283)) > 0) then
        AddPrintData('배달지역 : '+ Common.Table.Local);

      case StoI(GetOption(191)) of
        1 : AddPrintData(rptSizeNormal);
        2 : AddPrintData(rptSizeHeight);
        3 : AddPrintData(rptSizeWidth);
        4 : AddPrintData(rptSizeBoth);
      end;

      if (StoI(GetOption(191)) > 0) then
        AddPrintData('쿠    폰 : '+ CouponButton.Caption);

      For I :=1 to 5 do
        if Common.Config.Delivery_End[I] <> EmptyStr then
          AddPrintData(Common.Config.Delivery_End[I]);

      for I := 1 to aCount do
        PrintPrinter(rptDelivery);
    end;
end;

procedure TDevice.DeliveryReceiptPrint;
var I : Integer;
    vMenu, vTemp, vPrice, vMemo :String;
begin
  if GetOption(368) = '0' then
    with DeliveryInfo_F, Common do
    begin
      PrintData := EmptyStr;
      AddPrintData(rptSizeBoth);
      AddPrintData(rptAlignCenter);
      AddPrintData('영   수   증');
      AddPrintData(rptAlignLeft);
      AddPrintData(rptLF);
      AddPrintData(rptSizeNormal);
      For I := 1 to 4 do
        if Trim(Config.ReceiptTitle[I]) <> '' then  AddPrintData(Config.ReceiptTitle[I]);

      AddPrintData(rptLF);
      AddPrintData(FormatMaskText('!0000년90월90일 00:00;0; ',WorkDate + NowTime)+' '+Config.PosNo+'-'+Config.UserName);
      AddPrintData(rptTwoLine);
      AddPrintData(pStr+'    메 뉴 명 '+pStr+'          단가 수량      금액');
      AddPrintData(rptTwoLine);
      with Order_sGrd do
      begin
        For I := 0 to RowCount - 1 do
        begin
          //영수증에 메뉴 두줄로 출력한다고 했을때는 배달전표도 같이 적용한다
          if GetOption(81) = '0' then
            vMenu := RPadB(SCopy(Cells[GDM_NM_MENU, I],1,18+pLen),18+pLen,' ')
          else
            vMenu := Cells[GDM_NM_MENU, I];

          //배달전표에 주방메모를 출력한다고 했을때
          if GetOption(348) = '1' then
            vMemo := Cells[GDM_MEMO, I];
          if vMemo <> EmptyStr then
            vMemo := Format('[%s]', [vMemo]);

          //저울형 상품이면
          if Cells[GDM_DS_MENU, I] = 'W' then vTemp := Cells[GDM_VIEWQTY, I]
          else  vTemp := FormatFloat('#,##0',  StoF(Cells[GDM_QTY, I]));

          if GetOption(81) = '0' then
          begin
            if Cells[GDM_DS_SALE, I] = 'D' then
               vPrice := LPadB('서비스', 9,' ')
            else
               vPrice := LPadB(FormatFloat('#,##0',   StoI(Cells[GDM_PR_SALE, I])), 9,' ');
          end
          else
          begin
            if Cells[GDM_DS_SALE, I] = 'D' then
              vPrice := LPadB(FormatFloat('#,##0',StoI(Cells[GDM_PR_SALE_ORG, I]))+'(서비스)', 27+pLen,' ')
            else
              vPrice := LPadB(FormatFloat('#,##0',   StoI(Cells[GDM_PR_SALE, I])), 27+pLen,' ');
          end;

          if GetOption(81) = '0' then
          begin
            AddPrintData(vMenu + vPrice +
                            LPadB(vTemp, 5,' ')+
                            LPadB(FormatFloat('#,##0',   StoI(Cells[GDM_AMT,     I])),10,' '));
            if vMemo <> EmptyStr then
              AddPrintData(Cells[GDM_MEMO, I]);
          end
          else
          begin
            AddPrintData(vMenu+vMemo);
            AddPrintData(vPrice +
                         LPadB(vTemp, 5,' ')+
                         LPadB(FormatFloat('#,##0',   StoI(Cells[GDM_AMT,     I])),10,' '));
          end;
        end;
      end;
      AddPrintData(rptTwoLine);
      if FDCAmount <> 0 then
      begin
        AddPrintData(rptSizeWidth);
        AddPrintData(pStr+'할인금액'+ LPadB(FormatFloat('#,0',FDCAmount)+' 원',13,' '));
      end;
      AddPrintData(rptSizeWidth);
      AddPrintData(pStr+'합계금액'+ LPadB(lblOrderAmt.Caption,13,' '));
      AddPrintData(rptLF);
      AddPrintData(rptSizeHeight);
      AddPrintData('주문시간 : '+ lblOrderDate.Caption);
      if (not DeliveryButton.Appearance.SimpleLayout) then
        AddPrintData('배달담당 : '+ lblDeliveryDamdang.Caption);

      if GetOption(82)='1' then
      begin
        AddPrintData(rptLF);
        AddPrintData(rptOneLine);
        AddPrintData('고 객 명 : '+ edt_CustName.Text);
        if (Trim(edt_TelNo1.Text) <> '') then
          AddPrintData('연락처 1 : '+ edt_TelNo1.Text);
        if (Trim(edt_TelNo2.Text) <> '') then
          AddPrintData('연락처 2 : '+ edt_TelNo2.Text);
        if Trim(edt_Address1.Text) <> EmptyStr then
          AddPrintData(edt_Address1.Text);
        if Trim(edt_Address2.Text) <> EmptyStr then
          AddPrintData(edt_Address2.Text);
      end;

      PrintPrinter(rptDeliveryReceipt);
    end
  else
    with DeliveryNew_F, Common do
    begin
      TableViewToStringGrid;
      PrintData := EmptyStr;
      AddPrintData(rptSizeBoth);
      AddPrintData(rptAlignCenter);
      AddPrintData('영   수   증');
      AddPrintData(rptAlignLeft);
      AddPrintData(rptLF);
      AddPrintData(rptSizeNormal);
      For I := 1 to 4 do
        if Trim(Config.ReceiptTitle[I]) <> '' then  AddPrintData(Config.ReceiptTitle[I]);

      AddPrintData(rptLF);
      AddPrintData(FormatMaskText('!0000년90월90일 00:00;0; ',WorkDate + NowTime)+' '+Config.PosNo+'-'+Config.UserName);
      AddPrintData(rptTwoLine);
      AddPrintData(pStr+'    메 뉴 명 '+pStr+'          단가 수량      금액');
      AddPrintData(rptTwoLine);
      with FOrderGrid do
      begin
        For I := 0 to RowCount - 1 do
        begin
          //영수증에 메뉴 두줄로 출력한다고 했을때는 배달전표도 같이 적용한다
          if GetOption(81) = '0' then
            vMenu := RPadB(SCopy(Cells[GDM_NM_MENU, I],1,18+pLen),18+pLen,' ')
          else
            vMenu := Cells[GDM_NM_MENU, I];

          //배달전표에 주방메모를 출력한다고 했을때
          if GetOption(348) = '1' then
            vMemo := Cells[GDM_MEMO, I];
          if vMemo <> EmptyStr then
            vMemo := Format('[%s]', [vMemo]);

          //저울형 상품이면
          if Cells[GDM_DS_MENU, I] = 'W' then vTemp := Cells[GDM_VIEWQTY, I]
          else  vTemp := FormatFloat('#,##0',  StoF(Cells[GDM_QTY, I]));

          if GetOption(81) = '0' then
          begin
            if Cells[GDM_DS_SALE, I] = 'D' then
               vPrice := LPadB('서비스', 9,' ')
            else
               vPrice := LPadB(FormatFloat('#,##0',   StoI(Cells[GDM_PR_SALE, I])), 9,' ');
          end
          else
          begin
            if Cells[GDM_DS_SALE, I] = 'D' then
              vPrice := LPadB(FormatFloat('#,##0',StoI(Cells[GDM_PR_SALE_ORG, I]))+'(서비스)', 27+pLen,' ')
            else
              vPrice := LPadB(FormatFloat('#,##0',   StoI(Cells[GDM_PR_SALE, I])), 27+pLen,' ');
          end;

          if GetOption(81) = '0' then
          begin
            AddPrintData(vMenu + vPrice +
                         LPadB(vTemp, 5,' ')+
                         LPadB(FormatFloat('#,##0',   StoI(Cells[GDM_AMT,     I])),10,' '));
            if vMemo <> EmptyStr then
              AddPrintData(Cells[GDM_MEMO, I]);
          end
          else
          begin
            AddPrintData(vMenu+vMemo);
            AddPrintData(vPrice +
                         LPadB(vTemp, 5,' ')+
                         LPadB(FormatFloat('#,##0',   StoI(Cells[GDM_AMT,     I])),10,' '));
          end;
        end;
      end;
      AddPrintData(rptTwoLine);
      if FDCAmount <> 0 then
      begin
        AddPrintData(rptSizeWidth);
        AddPrintData(pStr+'할인금액'+ LPadB(FormatFloat('#,0',FDCAmount)+' 원',13,' '));
      end;
      AddPrintData(rptSizeWidth);
      AddPrintData(pStr+'합계금액'+ LPadB(FormatFloat('#,0',FOrderAmt)+' 원',13,' '));
      AddPrintData(rptLF);
      AddPrintData(rptSizeHeight);
      AddPrintData('주문시간 : '+ lblOrderDate.Caption);
      if (lblDeliveryDamdang.Caption <> '') then
        AddPrintData('배달담당 : '+ lblDeliveryDamdang.Caption);

      if GetOption(82)='1' then
      begin
        AddPrintData(rptLF);
        AddPrintData(rptOneLine);
        AddPrintData('고 객 명 : '+ edt_CustName.Text);
        if (Trim(edt_TelNo1.Text) <> '') then
          AddPrintData('연락처 1 : '+ edt_TelNo1.Text);
        if (Trim(edt_TelNo2.Text) <> '') then
          AddPrintData('연락처 2 : '+ edt_TelNo2.Text);
        if Trim(edt_Address1.Text) <> EmptyStr then
          AddPrintData(edt_Address1.Text);
        if Trim(edt_Address2.Text) <> EmptyStr then
          AddPrintData(edt_Address2.Text);
        if CardButton.Appearance.SimpleLayout then
          AddPrintData('결제구분 : 신용카드')
        else if CashButton.Appearance.SimpleLayout then
          AddPrintData('결제구분 : 현금')
        else if CashRcpButton.Appearance.SimpleLayout then
          AddPrintData('결제구분 : 현금영수증')
        else if EtcButton.Appearance.SimpleLayout then
          AddPrintData('결제구분 : 기타');
          
      end;

      PrintPrinter(rptDeliveryReceipt);
    end;
end;

function TDevice.DeliveryDishRetrunListPrint(aCode:String):Boolean;
var BefCourse,
    vTemp,
    vPrintData,
    vWhere :String;
begin
  if aCode = 'A' then
    vWhere := EmptyStr
  else if LengthB(aCode) = 3 then
    vWhere := Format(' and Ifnull(a.CD_COURSE,'''') = ''%s'' ',[aCode])
  else
    vWhere := aCode;
  OpenQuery('select a.*, '
           +'       GetCommonName(a.CD_STORE, ''20'', a.CD_COURSE) as NM_COURSE, '
           +'       b.NM_SAWON '
           +'  from SL_DELIVERY a left outer join '
           +'       MS_SAWON    b on a.CD_STORE = b.CD_STORE '
           +'                    and a.CD_SAWON = b.CD_SAWON '
           +' where a.CD_STORE =:P0 '
           +'   and a.DS_ORDER = ''D'' '
           +'   and a.DS_STEP  = ''A''  '
           +vWhere
           +' order by CD_COURSE ',
           [Common.Config.StoreCode]);
  BefCourse  := 'Start';
  vPrintData := '';
  PrintData := EmptyStr;
  while not Common.Query.Eof do
  begin
    if (BefCourse <> 'Start') and (BefCourse <> Common.Query.FieldByName('NM_COURSE').AsString) then
    begin
      vPrintData := vPrintData + PrinterCommendReplace(PrintData,
                                                       Common.Config.ReceiptPrinterDev,
                                                       Common.Config.PrintColum,
                                                       Common.Config.PrintBottomMargin);
      PrintData := EmptyStr;
    end;

    if PrintData = EmptyStr then
    begin
      AddPrintData(rptSizeBoth);
      AddPrintData(rptAlignCenter);
      AddPrintData('그릇회수리스트');
      AddPrintData(rptSizeNormal);
      AddPrintData(rptAlignCenter);
      if Common.Query.FieldByName('NM_COURSE').AsString <> '' then
        AddPrintData('('+ Common.Query.FieldByName('NM_COURSE').AsString+')');
      BefCourse := Common.Query.FieldByName('NM_COURSE').AsString;
      AddPrintData(rptAlignLeft);
      AddPrintData(rptLF);
      AddPrintData(rptOneLine);
    end;

    AddPrintData(rptSizeNormal);
    AddPrintData(rptAlignLeft);
    if GetOption(301) = '0' then
    begin
      AddPrintData('배달번호 : '+ Common.Query.FieldByName('ymd_delivery').AsString+'-'+Common.Query.FieldByName('no_delivery').AsString);
      if Common.Query.FieldByName('dt_delivery').Value <> null then
        AddPrintData('배달시간 : '+ FormatDateTime('yyyy-mm-dd hh:nn', Common.Query.FieldByName('dt_delivery').Value));
      if GetOption(120) = '0' then
        AddPrintData('배달담당 : '+ Common.Query.FieldByName('nm_sawon').AsString);
      AddPrintData('고 객 명 : '+ Common.Query.FieldByName('nm_name').AsString);
      if Trim(Common.Query.FieldByName('no_tel1').AsString) <> '' then
        AddPrintData('연락처 1 : '+ SetTelephone(Common.Query.FieldByName('no_tel1').AsString));
      if Trim(Common.Query.FieldByName('no_tel2').AsString) <> '' then
        AddPrintData('연락처 2 : '+ SetTelephone(Common.Query.FieldByName('no_tel2').AsString));
      if Trim(Common.Query.FieldByName('no_tel3').AsString) <> '' then
        AddPrintData('연락처 3 : '+ SetTelephone(Common.Query.FieldByName('no_tel3').AsString));
      if Trim(Common.Query.FieldByName('no_tel4').AsString) <> '' then
        AddPrintData('연락처 4 : '+ SetTelephone(Common.Query.FieldByName('no_tel4').AsString));

      if (Common.Query.FieldByName('address1').AsString <> '') or (Common.Query.FieldByName('address2').AsString <> '') then
      begin
        AddPrintData('주 소');
        AddPrintData(Common.Query.FieldByName('address1').AsString);
      end;
      if Trim(Common.Query.FieldByName('address2').AsString) <> EmptyStr then
        AddPrintData(Common.Query.FieldByName('address2').AsString);

      if Trim(Common.Query.FieldByName('remark').AsString) <> EmptyStr then
      begin
        AddPrintData('특이사항');
        AddPrintData(Common.Query.FieldByName('remark').AsString);
      end;
    end
    //회수리스트를 간략하게 출력할때
    else
    begin
      if Trim(Common.Query.FieldByName('no_tel1').AsString) <> '' then
        AddPrintData('연락처 : '+ SetTelephone(Common.Query.FieldByName('no_tel1').AsString));

      if (Trim(Common.Query.FieldByName('no_tel1').AsString) = '') and (Trim(Common.Query.FieldByName('no_tel2').AsString) = '') then
        AddPrintData('연락처 : '+ SetTelephone(Common.Query.FieldByName('no_tel2').AsString));

      if LengthB(Common.Query.FieldByName('address1').AsString +' '+ Common.Query.FieldByName('address2').AsString) <= 42 then
         AddPrintData(Common.Query.FieldByName('address1').AsString +' '+ Common.Query.FieldByName('address2').AsString)
      else
      begin
         AddPrintData(Common.Query.FieldByName('address1').AsString);
         AddPrintData(Common.Query.FieldByName('address2').AsString);
      end;
    end;

    //메뉴내역을 출력할때
    if GetOption(270)='1' then
    begin
      vTemp := EmptyStr;
      DM.OpenQuery('select c.NM_MENU_SHORT, '
                  +'       b.QTY_SALE '
                  +'  from SL_SALE_H a inner join '
                  +'       SL_SALE_D b on a.CD_STORE =b.CD_STORE '
                  +'                  and a.YMD_SALE =b.YMD_SALE '
                  +'                  and a.NO_POS   =b.NO_POS   '
                  +'                  and a.NO_RCP   =b.NO_RCP inner join '
                  +'       MS_MENU   c on b.CD_STORE =c.CD_STORE '
                  +'                  and b.CD_MENU  =c.CD_MENU  '
                  +' where a.CD_STORE   =:P0 '
                  +'   and a.NO_DELIVERY=:P1 ',
                  [Common.Config.StoreCode,
                   Common.Query.FieldByName('ymd_delivery').AsString+Common.Query.FieldByName('no_delivery').AsString ]);
      while not DM.Query.Eof do
      begin
        vTemp := vTemp + Ifthen(vTemp <> '', ', ','')+ DM.Query.FieldByName('nm_menu_short').AsString+'('+ DM.Query.FieldByName('qty_sale').AsString+')';
        DM.Query.Next;
      end;
      DM.Query.Close;
      AddPrintData(vTemp);
    end;
    AddPrintData(rptOneLine);
    Common.Query.Next;
  end;
  if PrintData <> EmptyStr then
  begin
    Result     := True;
    vPrintData := vPrintData + PrinterCommendReplace(PrintData,
                                                     Common.Config.ReceiptPrinterDev,
                                                     Common.Config.PrintColum,
                                                     Common.Config.PrintBottomMargin);
  end
  else
    Result     := False;
  PrintData := vPrintData;
  PrintPrinter(rptNone);
end;

procedure TDevice.BaeminKitchPrint(aTableNo:Integer; aDeliveryNo, aAddress, aTableMemo:String);
var vIndex, vIndex1, vCount :Integer;
    vKetchenCode, vTemp :String;
    vOrgTable : TTable;
begin
  vOrgTable := Common.Table;
  Common.ClearKitchenData;

  InitTableRecord(Common.Table);
  Common.Table.OrderNo := Common.GetOrderNo(1);
  Common.Table.Number     := aTableNo;
  Common.Table.OrderType  := 'D';
  Common.Table.GroupType  := 'N';
  Common.Table.Course     := '';
  Common.Table.Local      := '';
  Common.Table.Addr1      := aAddress;
  Common.Table.Addr2      := '';
  Common.Table.Date       := FormatDateTime('yyyymmdd',now());
  Common.Table.Time       := FormatDateTime('hh:nn',now());
  Common.Table.Name       := Format('배달의민족 - %s',[aDeliveryNo]);
  Common.Table.Memo       := aTableMemo;

  OpenQuery('select b.CD_PRINTER, '
           +'       b.NM_MENU_SHORT, '
           +'       a.MEMO, '
           +'       a.QTY_ORDER, '
           +'       a.PR_SALE, '
           +'       b.DS_KITCHEN, '
           +'       b.DS_MENU_TYPE, '
           +'       a.DS_SALE, '
           +'       b.DS_TAX, '
           +'       a.CD_MENU, '
           +'       b.NO_GROUP, '
           +'       a.SEQ, '
           +'       a.NO_STEP, '
           +'       a.QTY_ORDER, '
           +'       Substring(b.CONFIG,5,1) as YN_BILL, '
           +'       b.NM_MENU_KITCHEN '
           +'  from SL_ORDER_D as a inner join '
           +'       MS_MENU    as b on b.CD_STORE = a.CD_STORE '
           +'                      and b.CD_MENU  = a.CD_MENU '
           +' where a.CD_STORE =:P0 '
           +'   and a.NO_TABLE =:P1 '
           +'   and a.DS_ORDER =''D'' ',
           [Common.Config.StoreCode,
            aTableNo]);
  while not Common.Query.Eof do
  begin
    vKetchenCode := Common.Query.FieldByName('CD_PRINTER').AsString;
    if vKetchenCode <> '' then
      Common.Device.PrintKitchen(vKetchenCode,
                                 Common.Query.FieldByName('NM_MENU_SHORT').AsString,
                                 '',
                                 Common.Query.FieldByName('MEMO').AsString,
                                 Common.Query.FieldByName('QTY_ORDER').AsString,
                                 Common.Query.FieldByName('PR_SALE').AsString,
                                 '',
                                 Common.Query.FieldByName('DS_KITCHEN').AsString,
                                 Common.Query.FieldByName('DS_MENU_TYPE').AsString,
                                 Common.Query.FieldByName('DS_SALE').AsString,
                                 Common.Query.FieldByName('DS_TAX').AsString,
                                 '',  //코너
                                 '',
                                 '',
                                 Common.Query.FieldByName('CD_MENU').AsString,
                                 Common.Query.FieldByName('NO_GROUP').AsInteger,
                                 Common.Query.FieldByName('SEQ').AsInteger,
                                 Common.Query.FieldByName('NO_STEP').AsInteger,
                                 Common.Query.FieldByName('QTY_ORDER').AsInteger,
                                 'N',
                                 'Y',
                                 Common.Query.FieldByName('YN_BILL').AsString,
                                 'N',
                                 Common.Query.FieldByName('NM_MENU_KITCHEN').AsString );
    Common.Query.Next;
  end; //For nRow := 0 to RowCount - 1 do
  Common.Query.Close;

  //주방주문서를 메뉴별로 출력하면서 그룹을 사용시 그룹으로 지정된 내역을 주방주문서 헤더를 만든다
  if (GetOption(9) = '1') and (GetOption(79) = '1') then
  begin
    For vIndex := 0 to High(Common.KitchenPrinter) do
    begin
      For vIndex1 := 1 to 100 do
      begin
        if Common.KitchenPrinter[vIndex].GroupSource[vIndex1] = '' then Continue;

        vTemp := Common.Device.SetOrderPrintHeader(Common.KitchenPrinter[vIndex].GroupSource[vIndex1], vIndex);
        Common.KitchenPrinter[vIndex].Data := Common.KitchenPrinter[vIndex].Data +
                                              Common.Device.PrinterCommendReplace(vTemp,
                                                                                  Common.KitchenPrinter[vIndex].Device,
                                                                                  Common.KitchenPrinter[vIndex].Col,
                                                                                  Common.KitchenPrinter[vIndex].BottomMargin );
      end;
    end;
  end;

  For vIndex := 0 to High(Common.KitchenPrinter) do
  begin
    vTemp := EmptyStr;

    if (GetOption(79) = '0') and (Common.KitchenPrinter[vIndex].Source = EmptyStr) then Continue;
    //낱장으로 인쇄한다고 설정을 안하면 구분자가 없기때문에 여기서 붙어준다
    if GetOption(9) = '0' then
      Common.KitchenPrinter[vIndex].Source := Common.KitchenPrinter[vIndex].Source + #28;

    vCount := CharCnt(Common.KitchenPrinter[vIndex].Source, #28);

    for vIndex1 := 0 to vCount-1 do
    begin
      vTemp := CopyPos( Common.KitchenPrinter[vIndex].Source, #28, vIndex1);
      try
        Common.SavePrintData(Common.KitchenPrinter[vIndex].Code,
                             vTemp,
                             Common.Table.DamdangName,
                             Common.Config.PosNo,
                             Common.NowDate+Common.NowTime,
                             Common.Table.CustomerCount,
                             Common.Table.OrderNo);
      except
        on E: Exception do
        begin
          Common.WriteLog('배민 주방주문서',E.Message);
        end;
      end;
    end;
  end;

  For vIndex := 0 to High(Common.KitchenPrinter) do
  begin
    if (Common.KitchenPrinter[vIndex].Data   = EmptyStr) and
       (Common.KitchenPrinter[vIndex].Cancel = EmptyStr) then Continue;

    KitchenOrderPrint(vIndex);
  end;
  Common.HideWaitForm;
  Common.Table := vOrgTable;
end;

function TDevice.SetImage(aFileName:String;aSize:Char;aCount:Integer): String;
var
  vRow : PByteArray;
  vHeight, vWidth, vIndex, vCount : Integer;
  vBmp, vBmpTemp : TBitmap;
begin
  Result   := '';
  if not FileExists(aFileName) then Exit;
  vBmp     := TBitmap.Create;
  vBmpTemp := TBitmap.Create;
  try
    try
      vBmpTemp.LoadFromFile(aFileName);
      if aCount = 0 then
      begin
        vBmp.Width  := vBmpTemp.Width;
        vBmp.Height := vBmpTemp.Height;
        vBmp.PixelFormat := pf1bit;
        vBmp.Canvas.Draw(0, 0, vBmpTemp);
      end
      else
      begin
        vBmp.Width  := vBmpTemp.Width * aCount + 5;
        vBmp.Height := vBmpTemp.Height;
        vBmp.PixelFormat := pf1bit;
        for vIndex := 1 to aCount do
          vBmp.Canvas.Draw(vBmpTemp.Width*(vIndex-1), 0, vBmpTemp);
      end;

      for vHeight := 0 to vBmp.Height-1 do
      begin
        vRow := PByteArray(vBmp.Scanline[vHeight]);
        for vWidth := 0 to (vBmp.Width div 8)-1 do
          Result := Result + (Char(vRow[vWidth] xor $ff));
      end;

      if Common.Config.ReceiptPrinterDev = prtTM then
        Result := #27#97#1#29#118#48+#0+ Char(vBmp.Width div 8)+#0+Char(vBmp.Height)+#0+Result
      else
      begin
        if aCount = 0 then
          Result := #27#97#1#29#118#48+aSize+ Char(vBmp.Width div 8)+#0+Char(vBmp.Height)+#0+Result
        else
          Result := #27#97#0#29#118#48+aSize+ Char(vBmp.Width div 8)+#0+Char(vBmp.Height)+#0+Result;
      end;
    except
    end;
  finally
    vBmp.Free;
    vBmpTemp.Free;
  end;
end;

procedure TDevice.ScannerTimerTimer(Sender: TObject);
begin
  FScannerTimer.Enabled := False;
  if Assigned(FOnScannerReadData) then
    FOnScannerReadData(FScannerData);
end;

procedure TDevice.CidTimerTimer(Sender: TObject);
begin
  FCidTimer.Enabled := False;
  if Assigned(FOnCidReadData) then FOnCidReadData(FCidData)
  else
  begin
    if (FCidData[1] = 'C') and (FCidData[3] = 'I') then
      Common.AddCidData(FCidData);
  end;
end;

procedure TDevice.DispenserTimerTimer(Sender: TObject);
begin
  FDispenserTimer.Enabled := False;
  if Assigned(FOnDispenserReadData) then
    FOnDispenserReadData(String(FDispenserData));
  FDispenserData := EmptyStr;
end;

procedure TDevice.CidTimeOutTimer(Sender: Tobject);
begin
  FCidTimeOutTimer.Enabled := False;
  FCidTimeOut              := True;
end;

procedure TDevice.SetTitle(aCorner:String;aType:Integer=0);
var vIndex :Integer;
begin
  vIndex := Common.GetCornerIndex(aCorner,'');
  with Common.Config do
  begin
    AddPrintData(rptSizeNormal);
    AddPrintData(rptAlignLeft);
    if vIndex >= 0 then
    begin
      AddPrintData('상호 : '+Common.Corner[vIndex].Name);
      AddPrintData('사업자번호 : '+Common.Corner[vIndex].BizNo + ' 대표자:'+Common.Corner[vIndex].Boss);
//      AddPrintData('주소 : '+Common.Corner[vIndex].Addr);
//      AddPrintData('전화번호 : '+Common.Corner[vIndex].TelNo);
    end
    else
    begin
     for vIndex := 1 to 4 do
       if Trim(Common.Config.ReceiptTitle[vIndex]) <> '' then  AddPrintData(Common.Config.ReceiptTitle[vIndex]);
    end;

    if aType = 0 then
      AddPrintData(rptOneLine);
  end;
end;

function TDevice.WaitTicketPrint(aWaitNumber, aWaitPerson, aWaitKid, aTeamCount, aWaitTime:Integer; aTelNo:String):Boolean;
var vIndex,
    vTemp,
    vTableNo :Integer;
    vLetsOrderURL,
    vJsonURL :String;
begin
  Result := false;
  if (GetOption(286) = '1') then
  begin
    vTableNo      := -1;
    vLetsOrderURL := '';
    //렛츠오더 사용매장
    if GetHeadOption(9) = '1' then
    begin
      OpenQuery('select NO_TABLE, '
               +'       LETSORDER_URL '
               +'  from MS_TABLE  '
               +' where CD_STORE = :P0 '
               +'   and Ifnull(LETSORDER_URL,'''') <> '''' '
               +'   and NO_TABLE not in (select NO_TABLE '
               +'                          from SL_WAIT '
               +'                         where CD_STORE =:P0) '
               +' order by NO_TABLE '
               +' limit 1',
               [Common.Config.StoreCode]);

      if not Common.Query.Eof then
      begin
        vTableNo      := Common.Query.FieldByName('NO_TABLE').AsInteger;
        vLetsOrderURL := Common.Query.FieldByName('LETSORDER_URL').AsString;
      end;
      Common.Query.Close;
    end;

    if Common.KaKaoSendMessage(Ifthen(aWaitTime>0,'WT','WN'),
                               [IntToStr(aWaitNumber),             //대기번호
                                IntToStr(aWaitPerson),             //대기인원
                                IntToStr(aTeamCount+1),            //대기팀
                                IntToStr(aWaitTime),
                                vLetsOrderURL],                    //대기시간
                                aTelNo,' ▷알림톡 발송실패 ◁') then
    begin
      ExecQuery('insert into SL_WAIT(CD_STORE, '
               +'                    WAIT_NUMBER, '
               +'                    PERSON_COUNT, '
               +'                    KID_COUNT, '
               +'                    MOBILE_NO, '
               +'                    WAIT_TIME, '
               +'                    NO_TABLE, '
               +'                    STATUS, '
               +'                    DT_INSERT) '
               +'            values(:P0, '
               +'                   :P1, '
               +'                   :P2, '
               +'                   :P3, '
               +'                   :P4, '
               +'                   :P5, '
               +'                   :P6, '
               +'                   ''W'', '
               +'                   Now()) ',
               [Common.Config.StoreCode,
                aWaitNumber,
                aWaitPerson,
                aWaitKid,
                GetOnlyNumber(aTelNo),
                aWaitTime,
                vTableNo]);
      Result := true;
    end;
  end
  else
  begin
    try
      PrintData := EmptyStr;

      AddPrintData(rptSizeBoth);
      AddPrintData(rptAlignCenter);
      AddPrintData('대 기 표');
      AddPrintData(rptLF);
      AddPrintData(rptSizeBoth);
      AddPrintData(rptAlignCenter);
      AddPrintData(LPadB(IntToStr(aWaitNumber),4,'0'));
      if GetOption(196) = '0' then
      begin
        AddPrintData(rptAlignCenter);
        AddPrintData(rptSizeNormal);
        AddPrintData(Format('대기인원 %d팀 예상대기 %d분',[aTeamCount, aWaitTime]));
      end;
      AddPrintData(rptLF);
      AddPrintData(rptSizeNormal);
      AddPrintData(rptAlignLeft);
  //    AddPrintData(rptOneLine);
      if Trim(Common.WaitPrint1) <> '' then
        AddPrintData(Common.WaitPrint1);
      if Trim(Common.WaitPrint2) <> '' then
        AddPrintData(Common.WaitPrint2);
      if Trim(Common.WaitPrint3) <> '' then
        AddPrintData(Common.WaitPrint3);
      AddPrintData('출력일시:'+FormatMaskText('!0000년90월90일 90시90분;0; ',Common.NowDate+Common.NowTime));

      vTemp := IfThen(GetOption(151)='0',1, StoI(GetOption(151)));


      For vIndex := 1 to vTemp do
        PrintPrinter(rptWaitTicket);

      if ExecQuery('insert into SL_WAIT(CD_STORE, '
                  +'                    WAIT_NUMBER, '
                  +'                    PERSON_COUNT, '
                  +'                    KID_COUNT, '
                  +'                    MOBILE_NO, '
                  +'                    STATUS, '
                  +'                    DT_INSERT) '
                  +'            values(:P0, '
                  +'                   :P1, '
                  +'                   :P2, '
                  +'                   :P3, '
                  +'                   :P4, '
                  +'                   ''W'', '
                  +'                   Now()) ',
                  [Common.Config.StoreCode,
                   aWaitNumber,
                   aWaitPerson,
                   aWaitKid,
                   GetOnlyNumber(aTelNo)]) then
      Result := true;
    except
      on E : Exception do
      begin
        Common.ErrBox(E.Message);
      end;
    end;
  end;
end;

procedure TDevice.ItemLabelPrint;
var vIndex, vPos, vCol, vWidth, vHeight, vGab :Integer;
    vTemp,
    vPrintData :String;
begin                                                          
  if Common.LabelPrintData.Count = 0 then Exit;

  vWidth  := Common.GetIniFile('POS', 'LABEL_W', 40) * 8;
  vHeight := Common.GetIniFile('POS', 'LABEL_H', 20) * 8;
  vGab    := Common.GetIniFile('POS', 'LABEL_G', 3)  * 8;

  For vIndex := 0 to Common.LabelPrintData.Count-1 do
  begin
    LabelPrinterPrint(Format('SL%d,%d,G'#13,[vHeight, vGab]));
    LabelPrinterPrint(Format('SW%d'#13,[vWidth]));

    vPrintData := EmptyStr;
    vPrintData :='T300,'      //  //p1  X좌표
                +Format('%d,',[vHeight-20])     //p2  Y좌표
                +'b,'      //p3 글자크기
                +'0,'      //p4 수평확대
                +'0,'      //p5 수직확대
                +'0,'      //p6 자간
                +'2,'      //p7 로테이션
                +'N,'      //p8 역상
                +'B,'      //p9 굵기
                +Format('''        %s-%s-%s''',[Common.WorkDate, Common.Config.PosNo, Common.Present.RcpNo]);   //상품명
    LabelPrinterPrint(vPrintData+#13);
    vPrintData := EmptyStr;

    For vCol := 1 to CharCnt(Common.LabelPrintData.Strings[vIndex],#28) do
    begin
      vTemp := CopyPos(#28+Common.LabelPrintData.Strings[vIndex], #28, vCol);
      vPos  := (vHeight-20) - (vCol * 30);
      vPrintData :='T300,' //  //p1  X좌표
                  +Format('%d,',[vPos])//p2  Y좌표
                  +'b,'      //p3 글자크기
                  +'0,'      //p4 수평확대
                  +'0,'      //p5 수직확대
                  +'0,'      //p6 자간
                  +'2,'      //p7 로테이션
                  +'N,'      //p8 역상
                  +'B,'      //p9 굵기
                  +Format('''%s''',[Ifthen(vCol=1,'','-')+vTemp]);   //상품명
      LabelPrinterPrint(vPrintData+#13);
      vPrintData := EmptyStr;
    end;
    LabelPrinterPrint('P1'+ #13);
  end;
end;

procedure TDevice.LabelPrinterPrint(aValue: String);
  procedure InitPort;
  var
   aTimeOut : TCommTimeouts;
   bSuccess : boolean;
  begin
     LPTFile := CreateFile(PChar('LPT1'), GENERIC_WRITE, 0,nil,OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
     if GetCommTimeouts(LPTFile,aTimeOut) then
     begin
       aTimeOut.WriteTotalTimeoutMultiplier := 200;   // 200
       aTimeOut.WriteTotalTimeoutConstant   := 4000;   // 4000
       SetCommTimeouts(LPTFile,aTimeOut);
       bSuccess := SetCommTimeouts(LPTFile,aTimeOut);
     end;
  end;
var vTemp :String;
    BytesWritten : DWORD;
begin
  if Common.Config.LabelPrinterPort = 0 then
  begin
    InitPort;
    try
      repeat
        // 일부 POS에서 256Byte 이상이 되면 인쇄가 안되는 문제가 있어서 300글자씩 나눠서 인쇄한다
        vTemp      := Copy(aValue, 1, 300);
        aValue := Copy(aValue, 301, Length(aValue));
        WriteFile(LPTFile,PChar(vTemp)^,Length(vTemp),BytesWritten,nil);
      until Length(aValue) = 0;
    except
    end;

    try
      if (BytesWritten < Length(aValue)) then
      begin
        CloseHandle(LPTFile);
        raise Exception.Create('Error Write LPT');
      end
      else CloseHandle(LPTFile);
    except
    end;
  end
  else
  begin
    try
      repeat
        // 일부 POS에서 256Byte 이상이 되면 인쇄가 안되는 문제가 있어서 200글자씩 나눠서 인쇄한다
        vTemp     := Copy(aValue, 1, 200);
        aValue := Copy(aValue, 201, Length(aValue));
        LabelPrinterComPort.SendString(vTemp);
      until Length(aValue) = 0;
    finally
    end;
  end;

end;

procedure TDevice.DeliveryTelPrint(aIndex: Integer);
var I :Integer;
begin
  PrintData := EmptyStr;
  AddPrintData(rptSizeBoth);
  AddPrintData(rptAlignCenter);
  AddPrintData('배달수기주문서');
  AddPrintData(rptAlignLeft);
  AddPrintData(rptSizeNormal);
  AddPrintData(rptLF);
  AddPrintData('전화번호 : '+Common.DeliveryTel[aIndex].TelNo +'  [ '+IntToStr(aIndex)+'회선 ]');
  AddPrintData('고 객 명 : '+Common.DeliveryTel[aIndex].Cust);
  AddPrintData('주    소 : '+Common.DeliveryTel[aIndex].Addr1);
  AddPrintData('           '+Common.DeliveryTel[aIndex].Addr2);
  AddPrintData(rptLF);
  if Common.DeliveryTel[aIndex].Status = 'N' then
    AddPrintData(' 미주문')
  else if Common.DeliveryTel[aIndex].Status = 'O' then
  begin
    AddPrintData('주문번호 : '+Common.DeliveryTel[aIndex].OrderNo );
    AddPrintData('주문시간 : '+Common.DeliveryTel[aIndex].OrderTime );
  end
  else if Common.DeliveryTel[aIndex].Status = 'D' then
  begin
    AddPrintData('주문번호 : '+Common.DeliveryTel[aIndex].OrderNo );
    AddPrintData('주문시간 : '+Common.DeliveryTel[aIndex].OrderTime );
    AddPrintData('배달시간 : '+Common.DeliveryTel[aIndex].GoTime );
  end;
  AddPrintData('출력시간 : '+FormatDateTime('yyyy/mm/dd(ddd) ampm hh:nn ',now));
  if GetOption(228) = '1' then
  begin
    AddPrintData(rptOneLine);
    For I := 0 to Common.DeliveryBottomList.Count-1 do
      AddPrintData(Common.DeliveryBottomList.Strings[I]);
    AddPrintData(rptLF);
  end;
  PrintPrinter(rptNotTel);
end;

procedure TDevice.SaleReportPrint(aGrid:TcxGridTableView;aKind:Integer;aSaleDate:String);
var vRow, vIndex  :Integer;
    lsStr :String;
begin
  PrintData := EmptyStr;
  case aKind of
    0 :
    begin
      with SaleReport_F do
      begin
        AddPrintData(rptSizeBoth);
        AddPrintData(rptAlignCenter);
        AddPrintData('매출총괄표');
        AddPrintData(rptAlignLeft);
        AddPrintData(rptSizeNormal);
        AddPrintData(rptLF);
        AddPrintData('매 장 명 : '+Common.Config.StoreName);
        AddPrintData('매출일자 : '+aSaleDate);
        AddPrintData(rptTwoLine);
        AddPrintData(pStr+LPadB(lblNow8.Text,13,' ')  + LPadB(FormatFloat('#,0', edtNow8.Value),27,' '));
        AddPrintData(pStr+LPadB(lblNow9.Text,13,' ')  + LPadB(FormatFloat('#,0', edtNow9.Value),27,' '));
        AddPrintData(pStr+LPadB(lblNow10.Text,13,' ') + LPadB(FormatFloat('#,0', edtNow10.Value),27,' '));
        AddPrintData(pStr+LPadB(lblNow1.Text,13,' ')  + LPadB(FormatFloat('#,0', edtNow1.Value),27,' '));
        AddPrintData(pStr+LPadB(lblNow2.Text,13,' ')  + LPadB(FormatFloat('#,0', edtNow2.Value),27,' '));
        AddPrintData(pStr+LPadB(lblNow3.Text,13,' ')  + LPadB(FormatFloat('#,0', edtNow3.Value),27,' '));
        AddPrintData(pStr+LPadB(lblNow4.Text,13,' ')  + LPadB(FormatFloat('#,0', edtNow4.Value),27,' '));
        AddPrintData(pStr+LPadB(lblNow5.Text,13,' ')  + LPadB(FormatFloat('#,0', edtNow5.Value),27,' '));
        AddPrintData(pStr+LPadB(lblNow6.Text,13,' ')  + LPadB(FormatFloat('#,0', edtNow6.Value),27,' '));
        AddPrintData(pStr+LPadB(lblNow7.Text,13,' ')  + LPadB(FormatFloat('#,0', edtNow7.Value),27,' '));
        AddPrintData(rptAlignCenter);
        AddPrintData('[ 매출비교 ]');
        AddPrintData(pStr+'  '+txtBefMonth.Text + LPadB(FormatFloat('#,0', edtBefMonth1.Value),20,' '));
        AddPrintData(pStr+'  '+txtBefWeek.Text  + LPadB(FormatFloat('#,0', edtBefWeek1.Value),20,' '));
        AddPrintData(pStr+'  '+txtBefDay.Text   + LPadB(FormatFloat('#,0', edtBefDay1.Value),20,' '));
        AddPrintData(pStr+'  '+txtNow.Text      + LPadB(FormatFloat('#,0', edtNow1.Value),20,' '));
        AddPrintData(rptAlignCenter);
        AddPrintData('[ 주간매출 ]');
        AddPrintData(pStr+'  '+txtWeek1.Text    + LPadB(FormatFloat('#,0', edtWeek1.Value),19,' ') + LPadB(edtWeekPer1.Text,8,' '));
        AddPrintData(pStr+'  '+txtWeek2.Text    + LPadB(FormatFloat('#,0', edtWeek2.Value),19,' ') + LPadB(edtWeekPer2.Text,8,' '));
        AddPrintData(pStr+'  '+txtWeek3.Text    + LPadB(FormatFloat('#,0', edtWeek3.Value),19,' ') + LPadB(edtWeekPer3.Text,8,' '));
        AddPrintData(pStr+'  '+txtWeek4.Text    + LPadB(FormatFloat('#,0', edtWeek4.Value),19,' ') + LPadB(edtWeekPer4.Text,8,' '));
        AddPrintData(pStr+'  '+txtWeek5.Text    + LPadB(FormatFloat('#,0', edtWeek5.Value),19,' ') + LPadB(edtWeekPer5.Text,8,' '));
        AddPrintData(pStr+'  '+txtWeek6.Text    + LPadB(FormatFloat('#,0', edtWeek6.Value),19,' ') + LPadB(edtWeekPer6.Text,8,' '));
        AddPrintData(pStr+'  '+txtWeek7.Text    + LPadB(FormatFloat('#,0', edtWeek7.Value),19,' ') + LPadB(edtWeekPer7.Text,8,' '));
        AddPrintData(rptAlignCenter);
        AddPrintData('[ 결제수단별매출 ]');
        AddPrintData(rptAlignLeft);
        for vIndex := 0 to PayList.Count-1 do
          AddPrintData(PayList.Strings[vIndex]);
        AddPrintData(rptAlignCenter);
        AddPrintData('[ 분류별매출 ]');
        AddPrintData(rptAlignLeft);
        DM.OpenQuery('select Ifnull(c.NM_CLASS, ''분류미지정'') as NM_CLASS, '
                    +'       SUM(a.AMT_SALE) as AMT_SALE '
                    +'  from SL_SALE_D a inner join '
                    +'       SL_SALE_H b on b.CD_STORE	= a.CD_STORE '
                    +'                  and b.YMD_SALE	= a.YMD_SALE '
                    +'                  and b.NO_POS		= a.NO_POS '
                    +'                  and b.NO_RCP		= a.NO_RCP '
                    +'                  and b.DS_SALE <> ''V'' left outer join '
                    +'       (select t1.CD_STORE, '
                    +'               t1.CD_MENU, '
                    +'               Substring(t2.CD_CLASS,1,2) as CD_CLASS, '
                    +'               t2.NM_CLASS '
                    +'          from MS_MENU       t1 left outer join '
                    +'               MS_MENU_CLASS t2 on t1.CD_STORE = t2.CD_STORE '
                    +'                               and Substring(t1.CD_CLASS,1,2) = Substring(t2.CD_CLASS,1,2) '
                    +'		                            and length(t2.CD_CLASS) = 2 '
                    +'	    	 ) c on a.CD_STORE	= c.CD_STORE '
                    +'           and a.CD_MENU	  = c.CD_MENU '
                    +' where a.CD_STORE  = :P0 '
                    +'   and a.YMD_SALE  = :P1 '
                    +' group by C.NM_CLASS ',
                    [Common.Config.StoreCode,
                     DtoS(SearchDateEdit.Date)]);

        while not DM.Query.Eof do
        begin
          AddPrintData(pStr+'  '+RPadB(DM.Query.Fields[0].AsString,20,' ') + LPadB(FormatFloat('#,0', DM.Query.Fields[1].AsInteger),18,' '));
          DM.Query.Next;
        end;
        AddPrintData(rptTwoLine);
        AddPrintData('출력시간 : '+FormatDateTime('yyyy/mm/dd(ddd) ampm hh:nn ',now));
        DM.Query.Close;
      end;
    end;
    1 :
    begin
      AddPrintData(rptSizeBoth);
      AddPrintData(rptAlignCenter);
      AddPrintData('메뉴별 매출');
      AddPrintData(rptAlignLeft);
      AddPrintData(rptSizeNormal);
      AddPrintData('매 장 명 : '+Common.Config.StoreName);
      AddPrintData('매출일자 : '+aSaleDate);
      AddPrintData(rptTwoLine);
      AddPrintData(pStr+'      메뉴명  '+pStr+'            수량    매출금액');
      AddPrintData(rptTwoLine);
      For vRow := 0 to aGrid.DataController.RecordCount-1 do
      begin
        lsStr := RPadB(Trim(aGrid.DataController.Values[vRow, 1]),23+pLen,' ');
        lsStr := lsStr   + LPadB(aGrid.DataController.Values[vRow, 2],7,' ');
        lsStr := lsStr   + LPadB(FormatFloat('#,#0',aGrid.DataController.Values[vRow, 5]),12,' ');
        AddPrintData(lsStr);
      end;
      AddPrintData('    [ 합  계 ] '+ LPadB(FormatFloat(',0',aGrid.DataController.Summary.FooterSummaryValues[3]),27+pLen,' '));
      AddPrintData(rptOneLine);
    end;
  end;
  AddPrintData('출력시간 : '+FormatDateTime('yyyy/mm/dd(ddd) ampm hh:nn ',now));

  PrintPrinter(rptSaleRpt);
end;

procedure TDevice.MemberTrustReceivePrint(aValue: Integer; aAcctNo:String);
begin
  PrintData := EmptyStr;
  AddPrintData(rptSizeBoth);
  AddPrintData(rptAlignCenter);
  AddPrintData('외상결제 영수증');
  AddPrintData(rptLF);
  AddPrintData(rptAlignLeft);
  AddPrintData(rptSizeNormal);
  AddPrintData(' 매 장 명 : '+Common.Config.StoreName);
  AddPrintData(' 담 당 자 : '+Common.Config.UserName);
  AddPrintData(rptTwoLine);
  AddPrintData(' 회원코드   : '+Common.Member.Code);
  AddPrintData(' 회원이름   : '+Common.Member.Name);
  AddPrintData(' 결제전미수 : '+LPadB(FormatFloat(',0', Common.Member.CreditAmt) +' 원',15,' '));
  AddPrintData(' 결제금액   : '+LPadB(FormatFloat(',0', aValue)+' 원',15,' '));
  AddPrintData(' 결제후미수 : '+LPadB(FormatFloat(',0', Common.Member.CreditAmt - aValue) +' 원',15,' '));
  AddPrintData(rptOneLine);
  AddPrintData('출력시간 : '+FormatDateTime('yyyy/mm/dd(ddd) ampm hh:nn ',now));
  PrintPrinter(rptReceipt1);
end;

procedure TDevice.SetBell(aBellNo:Integer);
var vTemp :String;
begin
  try
    if Common.Config.BellPort = 0 then Exit;

    if not BellComPort.Active then
      BellComPort.Active := true;

    if Common.Config.BellDev = 0 then
      BellComPort.SendString(Format('S%s',[FormatFloat('0000', aBellNo)])+#3)
    else
    begin
      vTemp := #$01+#$4E+#$31+#$30+#$30+#$31+#$39+#$39+#$39+#$32+#$02+FormatFloat('000', aBellNo)+#$03+#$04;
      BellComPort.SendString(vTemp);
    end;

  except
    BellComPort.Active := False;
  end;
end;

procedure TDevice.CallBell(aBellNo:Integer);
var vTemp :String;
begin
  try
    if not BellComPort.Active then
      BellComPort.Active := true;

    if Common.Config.BellDev = 0 then
      BellComPort.SendString(#1+FormatFloat('0000', aBellNo)+#3)
    else
    begin
      vTemp := #$01+#$4E+#$31+#$30+#$30+#$31+#$30+#$30+#$30+#$38+#$02+FormatFloat('000', aBellNo)+#$03+#$04;
      BellComPort.SendString(vTemp);
    end;

  except
    BellComPort.Active := false;
  end;
end;

procedure TDevice.DispenserRxChar(Com: TObject; Buffer: Pointer; Received: Cardinal);
var
  vIndex   : Integer;
begin
  for vIndex := 0 to Received - 1 do
    FDispenserBuff := FDispenserBuff + PAnsiChar(Buffer)[vIndex];
//    vReadData := vReadData + PAnsiChar(Buffer)[vIndex];

  //전원을 껏다가 켜면 이값이 들어옴
  if FDispenserBuff = '^' then
  begin
    FDispenserBuff := FDispenserBuff;
    FDispenserData := EmptyStr;
    Exit;
  end;

  Common.WriteLog('work', Format('KIOSK->POS - %s',[Common.KioskLogFormat(FDispenserBuff)]));

  if ((Length(FDispenserBuff) = 1) and (StringToHex(FDispenserBuff)='11'))
  or ((Length(FDispenserBuff) > 1)  and (StringToHex(FDispenserBuff[1])='FE') and (Ord(FDispenserBuff[2]) < Length(FDispenserBuff))) then
  begin
    FDispenserData := FDispenserBuff;
    FDispenserBuff := EmptyStr;
    DispenserTimerTimer(nil);
  end;
end;

procedure TDevice.JtentICDetectRxChar(Com: TObject; Buffer: Pointer; Received: Cardinal);
var
  vReadData : String;
  vIndex    : Integer;
begin
  for vIndex := 0 to Received - 1 do
    vReadData := vReadData + PAnsiChar(Buffer)[vIndex];

  JtnetDetectData := JtnetDetectData + vReadData;
  if Pos(#3, JtnetDetectData) > 0 then
  begin
    if Pos('DETECT', JtnetDetectData) > 0 then
    begin
      if Common.Present.WRcvAmt = 0 then
      begin
        JtnetDetectData := EmptyStr;
        Exit;
      end;
      if Assigned(Card_F) and Card_F.Showing then
        Card_F.Timer1.Enabled := True
      else if Assigned(Order_F) and Order_F.Showing then
        Order_F.Tmr_Card.Enabled := True;
    end;
    JtnetDetectData := EmptyStr;
  end;
end;

procedure TDevice.KiccDSCXRcvPinData(ASender: TObject; const Flag,
  Data: WideString; DataLen: Integer);
var vData :String;
begin
  if LeftStr(Data,2) <> 'MS' then Exit;
  vData := Copy(Data, Pos('A',Data)+1, LengthB(Data));
  Common.PrinterInData := vData;
  PrinterRxChar(nil, 0, 0);
end;

function TDevice.GetKiccPrinterFormat(aData: String): String;
  function  StringCenterAlign(const aStr: String; aTotalLen: Integer; aEnlargeX: Boolean): String;
  var
    Index: Integer;
  begin
    // 가로 확대 상태면 빈칸을 반만 띄운다
    if aEnlargeX then
      aTotalLen := aTotalLen div 2;
    // 앞에 띄울 빈칸 개수를 알아낸다
    Index := (aTotalLen - LengthB(aStr)) div 2;
    if Index < 0 then
      Index := 0;
    Result := EmptyStr;
    // 앞에 빈칸을 만든다
    while Index > 0 do
    begin
      Result := Result + ' ';
      Dec(Index);
    end; // while Index >= 0 do
    Result := CopyStr(Result + aStr, 1, aTotalLen);
  end;

var vPos   :Integer;
    vTemp  :String;
    vTemp1 :String;
    vIsAlignCenter :Boolean;
begin
  Result := EmptyStr;
  repeat
    vPos := Pos(#10, aData);
    if vPos > 0 then
    begin
      vTemp  := Copy(aData, 1, vPos);
      aData  := Copy(aData, vPos+1, Length(aData));
    end
    else
    begin
      vTemp   := aData;
      aData   := EmptyStr;
    end;

    if (Pos(rptAlignCenter, vTemp) > 0) and (Pos(rptAlignLeft, vTemp) > 0) then
    begin
      if Pos(rptAlignCenter, vTemp) > Pos(rptAlignLeft, vTemp) then
        vTemp := Replace(vTemp, rptAlignCenter, '')
      else
        vTemp := Replace(vTemp, rptAlignLeft, '');
    end
    else vTemp := Replace(vTemp, rptAlignLeft, '');

    vIsAlignCenter := Pos(rptAlignCenter, vTemp) > 0;
    vTemp  := Replace(vTemp, rptAlignCenter, '');
    if vTemp = '{L}'#13#10 then
      vTemp := EmptyStr
    else if vTemp = #13#10 then
      vTemp := 'L29'#13#10
    else if (Length(vTemp) > 0) and not (vTemp[1] in ['C','T','L','P','D','S']) then
      vTemp := 'T110'+vTemp;

    //앞에 문자크기 설정이 두번돼 있을때 첫번째거 무시
    if (Length(vTemp) > 4) and (vTemp[1] = 'T') and (vTemp[5] = 'T') then
      vTemp := Copy(vTemp, 5, Length(vTemp)-4);

    //한줄에 문자크기 설정이 두번 있을때
    if (Length(vTemp) > 1) and (vTemp[1] = 'T') then
    begin
      vTemp1 := vTemp;
      vTemp1  := Replace(Copy(vTemp1,5, Length(vTemp1)-4), LeftStr(vTemp1,4), '');
      if vTemp1[1] <> 'T' then
        vTemp := LeftStr(vTemp,4)+vTemp1
      else
        vTemp := vTemp1;
    end;

    //가운데정렬일때 앞에 공백을 채운다
    if vIsAlignCenter then
    begin
      vTemp  := Replace(vTemp, rptAlignCenter, '');
      vTemp1 := Copy(vTemp,5, Pos(#13, vTemp)-5);
      if vTemp1 <> EmptyStr then
      begin
        if vTemp[2] = '2' then
          vTemp := LeftStr(vTemp,4) + StringCenterAlign(vTemp1, 48, true) + #13#10
        else if vTemp[2] = '1' then
          vTemp := LeftStr(vTemp,4) + StringCenterAlign(vTemp1, 48, false) + #13#10;
      end
      else vTemp := EmptyStr;
    end;

    if Pos('PC', vTemp) > 0 then
      vTemp  := 'PC'#13#10;

    Result := Result + vTemp;
  until vPos = 0;
end;

//쿠폰출력
procedure TDevice.CouponPrint;
  // 크기 계산
  function GetSize(aSize: Integer; aEnlarge: Boolean): Integer;
  begin
    Result := aSize * mm2dot * IfThen(aEnlarge, 2, 1);
  end;
var vPrintData :String;
    vPrintList :TStringList;
    vRotate    :Integer;
    vTop, vLeft :Integer;
    vTicketWidth :Integer;
const
  fmtText    = 'V%d,%d,K,%d,%d,0,%s,N,N,%d,%s,0,''%s'''#13;  // 가로위치,세로위치,(글꼴),폭,높이,(자간),굵기(N정상,B굵게),(역상),(기울임),(회전),정렬(L왼쪽,R오른쪽,C가운데),(쓰는방향),찍을문자열
  fmtBarcode = 'B1%d,%d,%d,%d,%d,%d,%d,%d,''%s'''#13;        // 가로위치,세로위치,바코드종류,좁은바코드폭,넓은바코드폭,바코드높이,(회전),바코드숫자크기,바코드
begin
  vPrintData := EmptyStr;
  //라벨프린터가 지정되지 않았을때는 영수증프린터로 출려한다
  if Common.Config.LabelPrinterPort = 0 then
  begin
    vPrintData := Common.Present.CouponName_Issue + rptLF;
    if Common.Present.CouponType_Issue = 'A' then
      vPrintData := vPrintData + rptSizeBoth + rptAlignCenter + Format('%s원',[FormatFloat('#,0', Common.Present.CouponAmt_Issue)])+rptSizeNormal +'할인권' + rptLF
    else
      vPrintData := vPrintData + rptSizeBoth + rptAlignCenter +FormatFloat('#0 %', Common.Present.CouponAmt_Issue)+rptSizeNormal +'할인권' + rptLF;

    vPrintData := vPrintData + rptAlignLeft + rptLF + Format('유효기간   %s ~ %s',[FormatDateTime('yyyy년mm월dd일',StoD(Common.PreSent.CouponFromDate_Issue)), FormatDateTime('yyyy년mm월dd일',StoD(Common.PreSent.CouponToDate_Issue))]) +rptLF+rptLF;
    vPrintData := vPrintData + Format('쿠폰번호   %s',[Common.PreSent.CouponNo_Issue])+rptLF;
    vPrintData := vPrintData + Format('매장명     %s',[Common.Config.StoreName])+rptLF;
    vPrintData := vPrintData + Format('영수증번호 %s-%s-%s',[Common.WorkDate, Common.Config.PosNo, Common.PreSent.RcpNo]) + rptLF;
    vPrintData := vPrintData + Format('출력일시   %s',[FormatDateTime(fmtDateTime, now())]) + rptLF;
    vPrintData := vPrintData + rptBarcode + Chr(Length(Common.PreSent.CouponNo_Issue)) + Common.PreSent.CouponNo_Issue + rptLF;  //바코드
    PrintData := vPrintData;
    PrintPrinter(rptCoupon);
    Exit;
  end;

  vPrintList := TStringList.Create;

  DM.OpenQuery('select * '
              +'  from MS_PRINT_H '
              +' where CD_STORE =:P0 '
              +'   and DS_PRINT =1 ',
              [Common.Config.StoreCode]);

  if not DM.Query.Eof then
  begin
    if DM.Query.FieldByName('DIRECTION').AsInteger in [2,3] then
      vRotate := 1
    else
      vRotate := 0;

    // 버퍼 지우기
    vPrintData := 'CB'#13;
    // 인쇄 속도 지정 (SS 속도(0:2.5인치/s ~ 6:8인치/s)
    vPrintData := vPrintData + 'SS3'#13;
    // 인쇄 농도 지정 (SD 농도(0:옅음 ~ 20:짙음)
    vPrintData := vPrintData + 'SD10'#13;
    // 인쇄 방향 지정 (SO 방향(T:똑바로인쇄, B:거꾸로인쇄))
    vPrintData := vPrintData + Format('SO%s'#13, [IfThen(DM.Query.FieldByName('DIRECTION').AsInteger = 2, 'B', 'T')]);
    // 속도 등 지정 (SP BaudRate(0:9600, 1:19200, 2:38400, 3:57600, 4:115200), 패러티(O,E,N), 데이터비트(7,8), 스톱비트(1,2))
    vPrintData := vPrintData + Format('SP%d,N,8,1'#13, [4]);
    // 용지 종류 지정 (ST 종류(d:써멀, t:리본))
    vPrintData := vPrintData + 'STd'#13;
    // 블랙마크,연속 용지 되감기
    if DM.Query.FieldByName('MARGIN_LEFT').AsInteger in [1, 2] then
      vPrintData := vPrintData + Format('SF1,%d'#13, [Trunc(DM.Query.FieldByName('MARGIN_LEFT').AsInteger * mm2dot)]);
    if vRotate = 0 then
    begin
      // 용지 길이 지정 (SL 용지 길이(도트), 용지사이 갭(도트), 용지타입[옵션](G:갭, C:연속지, B:블랙마크), 블랙마크와 절취선간 거리[옵션](도트)
      vPrintData := vPrintData + Format('SL%d,%d,%s'#13, [Trunc(DM.Query.FieldByName('TAG_HEIGHT').AsInteger * mm2dot), 30, IfThen(DM.Query.FieldByName('TAG_MARGIN_RIGHT').AsInteger div 10 = 0, 'G', IfThen(DM.Query.FieldByName('TAG_MARGIN_RIGHT').AsInteger div 10 = 1, 'B','C'))]);
      // 용지 폭 지정 (SW 용지 폭(도트))
      vPrintData := vPrintData + Format('SW%d'#13, [Trunc(DM.Query.FieldByName('TAG_WIDTH').AsInteger * mm2dot)]);
      vTicketWidth := Trunc(DM.Query.FieldByName('TAG_WIDTH').AsInteger * mm2dot);
    end
    else
    begin
      // 용지 길이 지정 (SL 용지 길이(도트), 용지사이 갭(도트), 용지타입[옵션](G:갭, C:연속지, B:블랙마크), 블랙마크와 절취선간 거리[옵션](도트)
      vPrintData := vPrintData + Format('SL%d,%d,%s'#13, [Trunc(DM.Query.FieldByName('TAG_WIDTH').AsInteger * mm2dot), 30, IfThen(DM.Query.FieldByName('TAG_MARGIN_RIGHT').AsInteger div 10 = 0, 'G', IfThen(DM.Query.FieldByName('TAG_MARGIN_RIGHT').AsInteger div 10 = 1, 'B','C'))]);
      // 용지 폭 지정 (SW 용지 폭(도트))
      vPrintData := vPrintData + Format('SW%d'#13, [Trunc(DM.Query.FieldByName('TAG_HEIGHT').AsInteger * mm2dot)]);
      vTicketWidth := Trunc(DM.Query.FieldByName('TAG_HEIGHT').AsInteger * mm2dot);
    end;
    // 컷팅 CUT(y or n)
    vPrintData := vPrintData + Format('CUT%s'#13, [IfThen(DM.Query.FieldByName('TAG_MARGIN_RIGHT').AsInteger mod 10 = 0,'n','y')]);
    // 더블버퍼링 하지 않음
    vPrintData := vPrintData + 'SB0'#13;
  end;

  DM.OpenQuery('select * '
               +'  from MS_PRINT_D '
               +' where CD_STORE =:P0 '
               +'   and DS_PRINT =1 ',
               [Common.Config.StoreCode]);

  while not DM.Query.Eof do
  begin
    if vRotate = 1 then
    begin
      vTop  := DM.Query.FieldByName('OBJECT_LEFT').AsInteger * mm2dot;
      vLeft := vTicketWidth - DM.Query.FieldByName('OBJECT_TOP').AsInteger * mm2dot;
    end
    else
    begin
      vTop  := DM.Query.FieldByName('OBJECT_TOP').AsInteger * mm2dot;
      vLeft := DM.Query.FieldByName('OBJECT_LEFT').AsInteger * mm2dot;
    end;
    case DM.Query.FieldByName('CD_OBJECT').AsInteger of
      11 :  //쿠폰금액
      begin
        vPrintData := vPrintData + Format(fmtText, [vLeft, // 가로위치
                                                    vTop,  // 세로위치
                                                    GetSize(DM.Query.FieldByName('FONT_SIZE').AsInteger, DM.Query.FieldByName('FONT_COLOR').AsInteger in [1,3]),  // 폭
                                                    GetSize(DM.Query.FieldByName('FONT_SIZE').AsInteger, DM.Query.FieldByName('FONT_COLOR').AsInteger in [2,3]),  // 높이
                                                    IfThen(DM.Query.FieldByName('FONT_STYLE').AsInteger = 1, 'B', 'N'), // 굵게
                                                    vRotate,                                                   // 회전(0:회전 안 함, 1:90도 회전, 2:180도, 3:270도)
                                                    IfThen(DM.Query.FieldByName('FONT_ALIGN').AsInteger = 4, 'R', 'L'), // 정렬
                                                    FormatFloat(',0 ', Common.PreSent.CouponAmt_Issue) + Ifthen(Common.PreSent.CouponType_Issue='A', '원','%')]); // 레이블 내용

      end;
      12 : //바코드
      begin
        vPrintData := vPrintData + Format(fmtBarcode, [vLeft, // 가로위치
                                                       vTop,  // 세로위치
                                                       1,                                            // 7:EAN13, 1:Code128
                                                       2,                                            // 좁은 바의 폭
                                                       6,                                            // 넓은 바의 폭
                                                       DM.Query.FieldByName('FONT_SIZE').AsInteger * mm2dot,   // 바코드 높이
                                                       vRotate,                                      // 회전(0:회전 안 함, 1:90도 회전, 2:180도, 3:270도)
                                                       3,                                            // 바코드 아래 숫자 크기(1,3,5,7)
                                                       Common.PreSent.CouponNo_Issue]);              // 레이블 내용
      end;
      13 : //사용기간
      begin
        vPrintData := vPrintData + Format(fmtText, [vLeft, // 가로위치
                                                    vTop,  // 세로위치
                                                    GetSize(DM.Query.FieldByName('FONT_SIZE').AsInteger, DM.Query.FieldByName('FONT_COLOR').AsInteger in [1,3]),  // 폭
                                                    GetSize(DM.Query.FieldByName('FONT_SIZE').AsInteger, DM.Query.FieldByName('FONT_COLOR').AsInteger in [2,3]),  // 높이
                                                    IfThen(DM.Query.FieldByName('FONT_STYLE').AsInteger = 1, 'B', 'N'), // 굵게
                                                    vRotate,                                                   // 회전(0:회전 안 함, 1:90도 회전, 2:180도, 3:270도)
                                                    IfThen(DM.Query.FieldByName('FONT_ALIGN').AsInteger = 4, 'R', 'L'), // 정렬
                                                    Format(DM.Query.FieldByName('OBJECT_TEXT').AsString,[FormatMaskText('!0000년90월90일;0; ',Common.PreSent.CouponFromDate_Issue),
                                                                                                FormatMaskText('!0000년90월90일;0; ',Common.PreSent.CouponToDate_Issue)])]);// 레이블 내용
      end;
      14 : //발행일자
      begin
        vPrintData := vPrintData + Format(fmtText, [vLeft, // 가로위치
                                                    vTop,  // 세로위치
                                                    GetSize(DM.Query.FieldByName('FONT_SIZE').AsInteger, DM.Query.FieldByName('FONT_COLOR').AsInteger in [1,3]),  // 폭
                                                    GetSize(DM.Query.FieldByName('FONT_SIZE').AsInteger, DM.Query.FieldByName('FONT_COLOR').AsInteger in [2,3]),  // 높이
                                                    IfThen(DM.Query.FieldByName('FONT_STYLE').AsInteger = 1, 'B', 'N'), // 굵게
                                                    vRotate,                                                   // 회전(0:회전 안 함, 1:90도 회전, 2:180도, 3:270도)
                                                    IfThen(DM.Query.FieldByName('FONT_ALIGN').AsInteger = 4, 'R', 'L'), // 정렬
                                                    FormatMaskText('!0000년 90월 90일;0; ', FormatDateTime('yyyymmdd',now()))]);// 레이블 내용
      end;
      15 : //영수증번호
      begin
        vPrintData := vPrintData + Format(fmtText, [vLeft, // 가로위치
                                                    vTop,  // 세로위치
                                                    GetSize(DM.Query.FieldByName('FONT_SIZE').AsInteger, DM.Query.FieldByName('FONT_COLOR').AsInteger in [1,3]),  // 폭
                                                    GetSize(DM.Query.FieldByName('FONT_SIZE').AsInteger, DM.Query.FieldByName('FONT_COLOR').AsInteger in [2,3]),  // 높이
                                                    IfThen(DM.Query.FieldByName('FONT_STYLE').AsInteger = 1, 'B', 'N'), // 굵게
                                                    vRotate,                                                   // 회전(0:회전 안 함, 1:90도 회전, 2:180도, 3:270도)
                                                    IfThen(DM.Query.FieldByName('FONT_ALIGN').AsInteger = 4, 'R', 'L'), // 정렬
                                                    Format(DM.Query.FieldByName('OBJECT_TEXT').AsString,[Common.WorkDate,
                                                                                                Common.Config.PosNo,
                                                                                                Common.PreSent.RcpNo])]);// 레이블 내용
      end;
      else
      begin
        vPrintData := vPrintData + Format(fmtText, [vLeft, // 가로위치
                                                    vTop, // 세로위치
                                                    GetSize(DM.Query.FieldByName('FONT_SIZE').AsInteger, DM.Query.FieldByName('FONT_COLOR').AsInteger in [1,3]),  // 폭
                                                    GetSize(DM.Query.FieldByName('FONT_SIZE').AsInteger, DM.Query.FieldByName('FONT_COLOR').AsInteger in [2,3]),  // 높이
                                                    IfThen(DM.Query.FieldByName('FONT_STYLE').AsInteger = 1, 'B', 'N'), // 굵게
                                                    vRotate,                                                   // 회전(0:회전 안 함, 1:90도 회전, 2:180도, 3:270도)
                                                    IfThen(DM.Query.FieldByName('FONT_ALIGN').AsInteger = 4, 'R', 'L'), // 정렬
                                                    DM.Query.FieldByName('OBJECT_TEXT').AsString])                                           // 레이블 내용
      end;
    end;
    DM.Query.Next;
  end;

  // 더블버퍼링 하지 않음
  vPrintData := vPrintData + 'P1'#13;
  LabelPrinterPrint(vPrintData);
end;

//티켓출력
procedure TDevice.TicketPrint;
  // 크기 계산
  function GetSize(aSize: Integer; aEnlarge: Boolean): Integer;
  begin
    Result := aSize * mm2dot * IfThen(aEnlarge, 2, 1);
  end;
var vPrintData, vPrintDataSub :String;
    vPrintList :TStringList;
    vRotate    :Integer;
    vTop, vLeft :Integer;
    vTicketWidth :Integer;
    vIndex, vIndex1   :Integer;
const
  fmtText    = 'V%d,%d,K,%d,%d,0,%s,N,N,%d,%s,0,''%s'''#13;  // 가로위치,세로위치,(글꼴),폭,높이,(자간),굵기(N정상,B굵게),(역상),(기울임),(회전),정렬(L왼쪽,R오른쪽,C가운데),(쓰는방향),찍을문자열
  fmtBarcode = 'B1%d,%d,%d,%d,%d,%d,%d,%d,''%s'''#13;        // 가로위치,세로위치,바코드종류,좁은바코드폭,넓은바코드폭,바코드높이,(회전),바코드숫자크기,바코드
begin
  vPrintData := EmptyStr;

  //라벨프린터가 지정되지 않았을때는 영수증프린터로 출려한다
  if Common.Config.LabelPrinterPort = 0 then
  begin
    for vIndex := 0 to Common.PreSent.TicketPrintData.Count-1 do
    begin
      vPrintData := rptSizeBoth + rptAlignCenter;
      vPrintData := vPrintData  + CopyPos(Common.PreSent.TicketPrintData.Strings[vIndex], #28, 1) + rptLF;                                  //메뉴명
      vPrintData := vPrintData  + rptBarcode + Chr(Length(CopyPos(Common.PreSent.TicketPrintData.Strings[vIndex], #28, 0))) + CopyPos(Common.PreSent.TicketPrintData.Strings[vIndex], #28, 0)+ rptLF;  //바코드
      vPrintData := vPrintData  + rptAlignLeft;
      vPrintData := vPrintData  + rptSizeNormal;

//      vPrintData := vPrintData + Format('식권번호   %s',[GetTicketNo(CopyPos(Common.PreSent.TicketPrintData.Strings[vIndex], #28, 0),true)])+rptLF;
      vPrintData := vPrintData + Format('영수증번호 %s-%s-%s',[Common.WorkDate, Common.Config.PosNo, Common.PreSent.RcpNo]) + rptLF;
      vPrintData := vPrintData + Format('매장명     %s',[Common.Config.StoreName])+rptLF;
      vPrintData := vPrintData + Format('출력일시   %s',[FormatDateTime(fmtDateTime, now())]) + rptLF;
      PrintData := vPrintData;
      PrintPrinter(rptTicket);
    end;
    Exit;
  end;

  vPrintList := TStringList.Create;

  DM.OpenQuery('select * '
              +'   from MS_PRINT_H '
              +'  where CD_STORE =:P0 '
              +'    and DS_PRINT =2 ',
              [Common.Config.StoreCode]);

  if not DM.Query.Eof then
  begin
    if DM.Query.FieldByName('DIRECTION').AsInteger in [2,3] then
      vRotate := 1
    else
      vRotate := 0;

    // 버퍼 지우기
    vPrintData := 'CB'#13;
    // 인쇄 속도 지정 (SS 속도(0:2.5인치/s ~ 6:8인치/s)
    vPrintData := vPrintData + 'SS3'#13;
    // 인쇄 농도 지정 (SD 농도(0:옅음 ~ 20:짙음)
    vPrintData := vPrintData + 'SD10'#13;
    // 인쇄 방향 지정 (SO 방향(T:똑바로인쇄, B:거꾸로인쇄))
    vPrintData := vPrintData + Format('SO%s'#13, [IfThen(DM.Query.FieldByName('DIRECTION').AsInteger = 2, 'B', 'T')]);
    // 속도 등 지정 (SP BaudRate(0:9600, 1:19200, 2:38400, 3:57600, 4:115200), 패러티(O,E,N), 데이터비트(7,8), 스톱비트(1,2))
    vPrintData := vPrintData + Format('SP%d,N,8,1'#13, [4]);
    // 용지 종류 지정 (ST 종류(d:써멀, t:리본))
    vPrintData := vPrintData + 'STd'#13;
    // 블랙마크,연속 용지 되감기
    if DM.Query.FieldByName('MARGIN_LEFT').AsInteger in [1, 2] then
      vPrintData := vPrintData + Format('SF1,%d'#13, [Trunc(DM.Query.FieldByName('MARGIN_LEFT').AsInteger * mm2dot)]);
    if vRotate = 0 then
    begin
      // 용지 길이 지정 (SL 용지 길이(도트), 용지사이 갭(도트), 용지타입[옵션](G:갭, C:연속지, B:블랙마크), 블랙마크와 절취선간 거리[옵션](도트)
      vPrintData := vPrintData + Format('SL%d,%d,%s'#13, [Trunc(DM.Query.FieldByName('TAG_HEIGHT').AsInteger * mm2dot), 30, IfThen(DM.Query.FieldByName('TAG_MARGIN_RIGHT').AsInteger div 10 = 0, 'G', IfThen(DM.Query.FieldByName('TAG_MARGIN_RIGHT').AsInteger div 10 = 1, 'B','C'))]);
      // 용지 폭 지정 (SW 용지 폭(도트))
      vPrintData := vPrintData + Format('SW%d'#13, [Trunc(DM.Query.FieldByName('TAG_WIDTH').AsInteger * mm2dot)]);
      vTicketWidth := Trunc(DM.Query.FieldByName('TAG_WIDTH').AsInteger * mm2dot);
    end
    else
    begin
      // 용지 길이 지정 (SL 용지 길이(도트), 용지사이 갭(도트), 용지타입[옵션](G:갭, C:연속지, B:블랙마크), 블랙마크와 절취선간 거리[옵션](도트)
      vPrintData := vPrintData + Format('SL%d,%d,%s'#13, [Trunc(DM.Query.FieldByName('TAG_WIDTH').AsInteger * mm2dot), 30, IfThen(DM.Query.FieldByName('TAG_MARGIN_RIGHT').AsInteger div 10 = 0, 'G', IfThen(DM.Query.FieldByName('TAG_MARGIN_RIGHT').AsInteger div 10 = 1, 'B','C'))]);
      // 용지 폭 지정 (SW 용지 폭(도트))
      vPrintData := vPrintData + Format('SW%d'#13, [Trunc(DM.Query.FieldByName('TAG_HEIGHT').AsInteger * mm2dot)]);
      vTicketWidth := Trunc(DM.Query.FieldByName('TAG_HEIGHT').AsInteger * mm2dot);
    end;
    // 컷팅 CUT(y or n)
    vPrintData := vPrintData + Format('CUT%s'#13, [IfThen(DM.Query.FieldByName('TAG_MARGIN_RIGHT').AsInteger mod 10 = 0,'n','y')]);
    // 더블버퍼링 하지 않음
    vPrintData := vPrintData + 'SB0'#13;
  end;

  for vIndex :=0 to Common.PreSent.TicketPrintData.Count-1 do
  begin
    vPrintDataSub := EmptyStr;
    DM.OpenQuery('select * '
                +'  from MS_PRINT_D '
                +' where CD_STORE =:P0 '
                +'   and DS_PRINT =2 ',
                [Common.Config.StoreCode]);
    while not Eof do
    begin
      if vRotate = 1 then
      begin
        vTop  := DM.Query.FieldByName('OBJECT_LEFT').AsInteger * mm2dot;
        vLeft := vTicketWidth - DM.Query.FieldByName('OBJECT_TOP').AsInteger * mm2dot;
      end
      else
      begin
        vTop  := DM.Query.FieldByName('OBJECT_TOP').AsInteger * mm2dot;
        vLeft := DM.Query.FieldByName('OBJECT_LEFT').AsInteger * mm2dot;
      end;
      case DM.Query.FieldByName('CD_OBJECT').AsInteger of
        11 :  //쿠폰금액
        begin
          vPrintDataSub := vPrintDataSub + Format(fmtText, [vLeft, // 가로위치
                                                      vTop,  // 세로위치
                                                      GetSize(DM.Query.FieldByName('FONT_SIZE').AsInteger, DM.Query.FieldByName('FONT_COLOR').AsInteger in [1,3]),  // 폭
                                                      GetSize(DM.Query.FieldByName('FONT_SIZE').AsInteger, DM.Query.FieldByName('FONT_COLOR').AsInteger in [2,3]),  // 높이
                                                      IfThen(DM.Query.FieldByName('FONT_STYLE').AsInteger = 1, 'B', 'N'), // 굵게
                                                      vRotate,                                                   // 회전(0:회전 안 함, 1:90도 회전, 2:180도, 3:270도)
                                                      IfThen(DM.Query.FieldByName('FONT_ALIGN').AsInteger = 4, 'R', 'L'), // 정렬
                                                      FormatFloat(',0 원', StoI(CopyPos(Common.PreSent.TicketPrintData.Strings[vIndex], #28, 2)))]); // 레이블 내용

        end;
        12 : //바코드
        begin
          vPrintDataSub := vPrintDataSub + Format(fmtBarcode, [vLeft, // 가로위치
                                                         vTop,  // 세로위치
                                                         1,                                            // 7:EAN13, 1:Code128
                                                         2,                                            // 좁은 바의 폭
                                                         6,                                            // 넓은 바의 폭
                                                         DM.Query.FieldByName('FONT_SIZE').AsInteger * mm2dot,   // 바코드 높이
                                                         vRotate,                                      // 회전(0:회전 안 함, 1:90도 회전, 2:180도, 3:270도)
                                                         3,                                            // 바코드 아래 숫자 크기(1,3,5,7)
                                                         CopyPos(Common.PreSent.TicketPrintData.Strings[vIndex], #28, 0)]);              // 레이블 내용
        end;
        14 : //발행일자
        begin
          vPrintDataSub := vPrintDataSub + Format(fmtText, [vLeft, // 가로위치
                                                      vTop,  // 세로위치
                                                      GetSize(DM.Query.FieldByName('FONT_SIZE').AsInteger, DM.Query.FieldByName('FONT_COLOR').AsInteger in [1,3]),  // 폭
                                                      GetSize(DM.Query.FieldByName('FONT_SIZE').AsInteger, DM.Query.FieldByName('FONT_COLOR').AsInteger in [2,3]),  // 높이
                                                      IfThen(DM.Query.FieldByName('FONT_STYLE').AsInteger = 1, 'B', 'N'), // 굵게
                                                      vRotate,                                                   // 회전(0:회전 안 함, 1:90도 회전, 2:180도, 3:270도)
                                                      IfThen(DM.Query.FieldByName('FONT_ALIGN').AsInteger = 4, 'R', 'L'), // 정렬
                                                      FormatMaskText('!0000년 90월 90일;0; ', FormatDateTime('yyyymmdd',now()))]);// 레이블 내용
        end;
        15 : //영수증번호
        begin
          vPrintDataSub := vPrintDataSub + Format(fmtText, [vLeft, // 가로위치
                                                      vTop,  // 세로위치
                                                      GetSize(DM.Query.FieldByName('FONT_SIZE').AsInteger, DM.Query.FieldByName('FONT_COLOR').AsInteger in [1,3]),  // 폭
                                                      GetSize(DM.Query.FieldByName('FONT_SIZE').AsInteger, DM.Query.FieldByName('FONT_COLOR').AsInteger in [2,3]),  // 높이
                                                      IfThen(DM.Query.FieldByName('FONT_STYLE').AsInteger = 1, 'B', 'N'), // 굵게
                                                      vRotate,                                                   // 회전(0:회전 안 함, 1:90도 회전, 2:180도, 3:270도)
                                                      IfThen(DM.Query.FieldByName('FONT_ALIGN').AsInteger = 4, 'R', 'L'), // 정렬
                                                      Format(DM.Query.FieldByName('OBJECT_TEXT').AsString,[Common.WorkDate,
                                                                                                           Common.Config.PosNo,
                                                                                                           Common.PreSent.RcpNo])]);// 레이블 내용
        end;
        16 : //메뉴명
        begin
          vPrintDataSub := vPrintDataSub + Format(fmtText, [vLeft, // 가로위치
                                                            vTop,  // 세로위치
                                                            GetSize(DM.Query.FieldByName('FONT_SIZE').AsInteger, DM.Query.FieldByName('FONT_COLOR').AsInteger in [1,3]),  // 폭
                                                            GetSize(DM.Query.FieldByName('FONT_SIZE').AsInteger, DM.Query.FieldByName('FONT_COLOR').AsInteger in [2,3]),  // 높이
                                                            IfThen(DM.Query.FieldByName('FONT_STYLE').AsInteger = 1, 'B', 'N'), // 굵게
                                                            vRotate,                                                   // 회전(0:회전 안 함, 1:90도 회전, 2:180도, 3:270도)
                                                            IfThen(DM.Query.FieldByName('FONT_ALIGN').AsInteger = 4, 'R', 'L'), // 정렬
                                                            CopyPos(Common.PreSent.TicketPrintData.Strings[vIndex], #28, 1)]);// 레이블 내용
        end;
        else
        begin
          vPrintDataSub := vPrintDataSub + Format(fmtText, [vLeft, // 가로위치
                                                      vTop, // 세로위치
                                                      GetSize(DM.Query.FieldByName('FONT_SIZE').AsInteger, DM.Query.FieldByName('FONT_COLOR').AsInteger in [1,3]),  // 폭
                                                      GetSize(DM.Query.FieldByName('FONT_SIZE').AsInteger, DM.Query.FieldByName('FONT_COLOR').AsInteger in [2,3]),  // 높이
                                                      IfThen(DM.Query.FieldByName('FONT_STYLE').AsInteger = 1, 'B', 'N'), // 굵게
                                                      vRotate,                                                   // 회전(0:회전 안 함, 1:90도 회전, 2:180도, 3:270도)
                                                      IfThen(DM.Query.FieldByName('FONT_ALIGN').AsInteger = 4, 'R', 'L'), // 정렬
                                                      DM.Query.FieldByName('OBJECT_TEXT').AsString])                                           // 레이블 내용
        end;
      end;
      DM.Query.Next;
    end;
    vPrintList.Add(vPrintData + vPrintDataSub + 'P1'#13);
  end;

  for vIndex := 0 to vPrintList.Count-1 do
    LabelPrinterPrint(vPrintList.Strings[vIndex]);
end;

procedure TDevice.UPSSPrint;
begin
  PrintData := rptSizeBoth + rptAlignCenter
              +'위해상품차단' + rptLF
              +rptSizeNormal + rptAlignLeft
              +rptTwoLine
              +PrintData
              +rptTwoLine + rptLF;
  Common.Device.PrintPrinter(rptUPSS);
end;

procedure TDevice.SetPrintPort(aValue: Boolean);
begin
  try
    if Common.Config.ReceiptPrinterDev = prtKICC then
    begin
      if aValue then
      begin
        Sleep(500);
        KiccDSCX.Open := true;
      end
      else
        KiccDSCX.Open := false;
    end
    else if (not Common.Config.RcpToKitchen and (Common.Config.ReceiptPrinterDev > 0)) or (Common.Config.RcpToKitchen and (GetOption(379) = '1'))  then
    begin
      if aValue then
        PrintComPort.Active := true
      else
        PrintComPort.Active := false;
      Sleep(100);
    end;
  except
  end;
end;

procedure TDevice.SetJtentDetect(aValue:Boolean);
begin
  if not Common.Config.IsKiosk and ((GetOption(379)='0')) and (Common.ICCard.VAN = vtJTNET) then
  begin
    if Common.Config.ICReaderPort = 0 then Exit;
    try
      if aValue then
        JtentICDetectComPort.Active := true
      else
        JtentICDetectComPort.Active := false;
      Sleep(100);
    except
    end;
  end;
end;

procedure TDevice.TaxRefundPrint(aApproval:Boolean; aTaxfreeNo, aSaleDate:String; aRefundAmt:Currency);
var vPrintData,
    vTemp :String;
    vTotSale,
    vTotVat :Integer;
    vSaleDate :TDateTime;
begin
  vSaleDate  := StrToDate(FormatMaskText('!0000-90-90;0; ', aSaleDate));
  vPrintData := rptAlignCenter + rptSizeBoth;
  vPrintData := vPrintData + 'GLOBAL TAX FREE'+rptLF;
  vPrintData := vPrintData + rptAlignLeft + rptSizeNormal;
  vPrintData := vPrintData + 'www.global-taxfree.com'+rptLF;
  vPrintData := vPrintData + 'gtf@global-taxfree.com'+rptLF;
  vPrintData := vPrintData + rptOneLine;
  if aApproval then
  begin
    vPrintData := vPrintData + rptAlignCenter + rptBarcode + Chr(Length(aTaxfreeNo))+ aTaxfreeNo;
    vPrintData := vPrintData + #27'@' + rptAlignLeft + rptSizeWidth;
    vPrintData := vPrintData + '구매자 CUSTOMER' + rptLF;
    vPrintData := vPrintData + rptAlignLeft + rptSizeNormal;
    vPrintData := vPrintData + 'Passport Name' + rptLF;
    vPrintData := vPrintData + 'Passport No.' + rptLF;
    vPrintData := vPrintData + 'Nationality' + rptLF;
    vPrintData := vPrintData + 'Credit Card No.(Address)' + rptLF;
    vPrintData := vPrintData + 'Alipay No.(Phone)' + rptLF+rptLF+ rptLF;
    vPrintData := vPrintData + rptOneLine;
    vPrintData := vPrintData + rptAlignLeft + rptSizeWidth;
    vPrintData := vPrintData + 'DECLARATION' + rptLF;
    vPrintData := vPrintData + rptAlignLeft + rptSizeNormal;
    vPrintData := vPrintData + '-I confirm that my personal information and purchase items are true'+ rptLF;
    vPrintData := vPrintData + '-I declare that I am not a resident in Korea and I am foreigner tourist'+ rptLF;
    vPrintData := vPrintData + '-I will export the goods within 3 months from the purchase date'+ rptLF;
    vPrintData := vPrintData + rptAlignLeft + rptSizeHeight;
    vPrintData := vPrintData + 'Tourist signature                Date' + rptLF+rptLF+rptLF;
    vPrintData := vPrintData + 'PRIVACY NOTICE' + rptLF;
    vPrintData := vPrintData + rptAlignLeft + rptSizeNormal;
    vPrintData := vPrintData + 'The personal data provided by the Tourist in this “Cheque” will be processed '
                             + 'by the GLOBAL TAX FREE CO.,LTD. and such bank or credit card company designed by the '
                             + 'Tourist in this “Cheque”, for the purpose of performing a refund of value '
                             + 'added tax(TAX). The Tourist’s personal data is necessary for the refund of '
                             + 'value added tax(TAX). If the Tourist does not provide this data,  '
                             + 'GLOBAL TAX FREE CO.,LTD. is not able to refund the TAX '+ rptLF;
    vPrintData := vPrintData + rptOneLine;
  end;
  vPrintData := vPrintData + rptAlignLeft + rptSizeWidth;
  vPrintData := vPrintData + '판매자 RETAILER' + rptLF;
  vPrintData := vPrintData + rptAlignLeft + rptSizeNormal;
  vPrintData := vPrintData + Common.Config.StoreName + rptLF;
  vPrintData := vPrintData + Common.Config.StoreAddress + rptLF;
  vPrintData := vPrintData + Format('Tel +82-%s         %s',[Copy(SetTelephone(Common.Config.StoreTel),2,Length(SetTelephone(Common.Config.StoreTel))-1),
                                                             FormatMaskText('!000-00-00000;0;', GetOnlyNumber(Common.Config.StoreBizNo))]) + rptLF;
  vPrintData := vPrintData + rptAlignLeft + rptSizeHeight;
  if aApproval then
  begin
    vPrintData := vPrintData + Format('%-32.32s%s',['Date of sale',FormatDateTime('yyyy.mm.dd',vSaleDate)])+ rptLF;
    vPrintData := vPrintData + rptAlignLeft + rptSizeNormal;
    vPrintData := vPrintData + LPadB(Format('(Expiry Date %s)',[FormatDateTime('yyyy.mm.dd', IncDay(IncMonth(vSaleDate,3),-1))]),42,' ')+ rptLF;
  end
  else
  begin
    vPrintData := vPrintData + rptSizeNormal + rptCharBold;
    vPrintData := vPrintData + Format('%-23.23s%s',['Cancel sale',FormatDateTime('yyyy.mm.dd hh:nn:ss',Now)])+ rptLF;
    vPrintData := vPrintData + rptSizeNormal + rptCharNormal;
  end;
  vPrintData := vPrintData + rptOneLine;
  vPrintData := vPrintData + rptAlignLeft + rptSizeHeight;
  vPrintData := vPrintData + Format('%-20.20s%s %s %s %s %s',['구매일련번호',
                                                           Copy(aTaxfreeNo,1,4),
                                                           Copy(aTaxfreeNo,5,4),
                                                           Copy(aTaxfreeNo,9,4),
                                                           Copy(aTaxfreeNo,13,4),
                                                           Copy(aTaxfreeNo,17,2)])+rptLF;
  vPrintData := vPrintData + rptAlignLeft + rptSizeNormal;
  if aApproval then
  begin
    vPrintData := vPrintData + rptAlignLeft + rptSizeHeight;
    vPrintData := vPrintData + '물품구매내역 Description of Goods'+rptLF;
    vPrintData := vPrintData + rptAlignLeft + rptSizeNormal;
    vPrintData := vPrintData + Format('%-28.28s%s  %s',['물품명','수량','판매가격'])+rptLF;
  end
  else
    vPrintData := vPrintData + rptAlignLeft + rptSizeNormal;

  OpenQuery('select PROD_CTS, '
           +'       QTY, '
           +'       SALE_PRICE, '
           +'       VAT '
           +'  from SL_TAXFREE_S '
           +' where TAXFREE_BUY_NO =:P0 '
           +' order by SEQ, SEQ1 ',
           [aTaxfreeNo]);
  vTotSale := 0;
  vTotVat  := 0;
  while not Common.Query.Eof do
  begin
    if aApproval then
      vPrintData := vPrintData + Format('%-28.28s%s%s',[SCopy(Common.Query.FieldByName('PROD_CTS').AsString,1,28),
                                                          LPadB(Common.Query.FieldByName('QTY').AsString,4,' '),
                                                          LPadB(FormatFloat('#,0',Common.Query.FieldByName('SALE_PRICE').AsCurrency),10,' ')])+rptLF;
    vTotSale := vTotSale + Common.Query.FieldByName('SALE_PRICE').AsInteger;
    vTotVat  := vTotVat  + Common.Query.FieldByName('VAT').AsInteger;
    Common.Query.Next;
  end;
  Common.Query.Close;
  vPrintData := vPrintData + rptOneLine;
  vPrintData := vPrintData + rptCharBold;
  if not aApproval then
    vTotSale := vTotSale * -1;
  vPrintData := vPrintData + Format('총액(세금포함) Sales amount%s',[LPadB(FormatFloat('#,0',vTotSale),14,' ')])+rptLF;
  vPrintData := vPrintData + rptSizeNormal + rptCharNormal;
  if not aApproval then
    vPrintData := vPrintData + rptOneLine
  else
  begin
    vPrintData := vPrintData + Format('부가세         V.A.T       %s',[LPadB(FormatFloat('#,0',vTotVat),14,' ')])+rptLF;
    vPrintData := vPrintData + Format('개소세         I.C.T       %s',[LPadB('0',14,' ')])+rptLF;
    vPrintData := vPrintData + Format('교육세         E.T         %s',[LPadB('0',14,' ')])+rptLF;
    vPrintData := vPrintData + Format('농어촌특별세   S.T.R.D     %s',[LPadB('0',14,' ')])+rptLF;
    vPrintData := vPrintData + rptCharBold;
    vPrintData := vPrintData + Format('환급액(￦)    NET REFUND   %s',[LPadB(FormatFloat('#,0',aRefundAmt),14,' ')])+rptLF;
    vPrintData := vPrintData + rptOneLine;
    vPrintData := vPrintData + rptAlignLeft + rptSizeHeight;
    vPrintData := vPrintData + '세관의 반출 확인란 CUSTOMS VERIFICATION'+rptLF+rptLF+rptLF+rptLF;
    vPrintData := vPrintData + rptCharNormal + rptAlignLeft + rptSizeNormal;
    vPrintData := vPrintData + '외국인관광객 물품판매확인서 / Tourist`s Application for Tax Refund'+rptLF;
    vPrintData := vPrintData + '국세청 인정서식 / This document is authorized by Korea National Tax Service'+rptLF;
  end;
  PrintData := vPrintData;
  PrintPrinter(rptTaxRefund);
end;

procedure TDevice.PadServerExecute(AContext: TIdContext);
var
  vS : string;
  vSl: TStringList;
  vI1, vI2: Integer;
  vCommand, vSuccess, vResult: string;
  vStream: TMemoryStream;
  vSaveBmp  : TBitmap;
  vPicture: TPicture;
begin
  try
    // 처리결과 수신
    vS  := AContext.Connection.Socket.ReadLn;//(#3,1000);
    vI1 := Pos(#1, vS);
    vI2 := Pos(#3, vS);
    if (vI1 > 0) and (vI2 > vI1) then
    begin
      // 전문 구분자 제거 및 결과 쪼개기
      vS  := Copy(vS, vI1+1, vI2-vI1-1);
      vSl := TStringList.Create;
      Split(vS, #2, vSl);
      // 연결(패드 IP 수신용) 전문
      if (vSl.Count = 2) and (vSl[1] = 'connect') then
      begin
        PadClient.Host := AContext.Connection.Socket.Binding.PeerIP;
        Common.ICCard.SmartPadIP := PadClient.Host;
        Common.SetIniFile('POS', '스마트패드IP', PadClient.Host);
      end
      // 요청결과 전문
      else if vSl.Count = 4 then
      begin
        vCommand := vSl[1];
        vSuccess := vSl[2];
        vResult  := vSl[3];
        // 번호입력 결과 처리
        if vCommand = 'keypad' then
        begin
          if vSuccess = 'Y' then
          begin
            if Assigned(PadWait_F) and PadWait_F.Showing then
              PadWait_F.EndTimer.Enabled    := true;
            if Assigned(MemberAdd_F) and MemberAdd_F.Showing then
            begin
              MemberAdd_F.MobileEdit.Text  := SetTelephone(vResult);
            end
            else if Assigned(Member_F) and Member_F.Showing then
            begin
              Member_F.SearchEdit.Text := vResult;
              Member_F.Tmr_Search.Enabled := true;
            end
            else if Assigned(CashRcp_F) and CashRcp_F.Showing then
            begin
              CashRcp_F.NumberEdit.Text      := vResult;
              Common.CashRcp.Ds_Input        := 'K';
              Common.CashRcp.CardNoFull      := vResult;
              CashRcp_F.Tmr_Approval.Enabled := true;
            end
            else if Assigned(Order_F) and Order_F.Showing then
            begin
              Common.PreSent.CallTelNo := vResult;
            end

          end
          else
          begin
            if Assigned(PadWait_F) and PadWait_F.Showing then
              PadWait_F.EndTimer.Enabled    := true;
          end;
        end
        else if vCommand = 'ask' then
        begin
          if Assigned(QuesMsg_F) and QuesMsg_F.Showing then
          begin
            if vResult = 'Y' then
              QuesMsg_F.AskTimer.Tag := 0
            else
              QuesMsg_F.AskTimer.Tag := 1;
            QuesMsg_F.AskTimer.Enabled := true;
          end;
        end
        // 서명 결과처리
        else if vCommand = 'sign' then
        begin
          if vSuccess = 'Y' then
          begin
            // 서명문자열 HEX값을 byte 배열로 변경해 png 파일로 저장
            if (Length(vResult) mod 2 = 0) then
            begin
              vStream := TMemoryStream.Create;
              try
                try
                  vStream.Size := Length(vResult) div 2;
                  HexToBin(PAnsiChar(vResult), vStream.Memory, vStream.Size);
                  vStream.SaveToFile('sign.png');                              // png 파일을 bmp로 변경해서 사용...

                  vPicture := TPicture.Create;
                  try
                    vPicture.LoadFromFile('sign.png');
                    vSaveBmp := TBitmap.Create;
                    try
                      vSaveBmp.PixelFormat := pf1bit;
                      vSaveBmp.Width  := 128;
                      vSaveBmp.Height := 64;
                      vSaveBmp.Canvas.StretchDraw(vSaveBmp.Canvas.ClipRect, vPicture.Graphic );
                      vSaveBmp.SaveToFile('PadSign.bmp');
                    finally
                      vSaveBmp.Free;
                    end;
                  finally
                    vPicture.Free;
                  end;
                except
                end;
              finally
                vStream.Free;
              end;
            end;
          end
          else if vSuccess = 'N' then
          begin
            if Assigned(frmSmartPadSign) and frmSmartPadSign.Showing then
              frmSmartPadSign.EndTimer.Enabled    := true;
            if Pos('입력시간이 초과되었습니다',vResult) > 0 then
              Common.SetIniFile('POS', 'SIGNCANCEL', 'Y');
          end
        end;
//        AContext.Connection.Socket.WriteLn(#1#3);  // 결과는 안 보내도 상관없음
      end;
    end;
  finally
    AContext.Connection.Disconnect;
  end;
end;

function TDevice.SendToPad(aData: String;aMsgShow:Boolean): Boolean;
var vSend,
    vGetData : String;
begin
  Result     := false;
  vGetData   := EmptyStr;
  with PadClient do
  begin
    try
      try
        PadClient.Port := 7007;
        Connect;
        vSend := #1+PadLicenseKey
                +aData
                +#3;
        Send(vSend,IndyTextEncoding_OSDefault);
        if Pos('dual', aData) = 0 then
          vGetData := ReceiveString(1000);
        Result := true;
      except
      end;
    finally
       try
         Disconnect;
         if Connected then
           Disconnect;
       except
       end;
    end;
  end;

  if (Pos('time', aData) > 0) then
  begin
    //3일이 지나면 패드 전원 다시시작
    if (GetOnlyNumber(vGetData) <> '') and (StrToInt(GetOnlyNumber(vGetData)) > 72) then
      Common.MsgBox('스마트패드 전원을 다시 시작해주세요'+#13+'스마트패드가 느리게 동작할 수 있습니다');
//    else if vGetData = '' then
//      Common.ErrBox('패드에 접속하지 못했습니다'+#13+'패드가 켜져있는지 확인해주세요');
  end
  else if ((Pos('member', aData) > 0) or (Pos('keypad', aData) > 0) )and (vGetData = '') then
  begin
//    Common.ErrBox('패드에 접속하지 못했습니다'+#13+'패드가 켜져있는지 확인해주세요');
    Result := false;
  end;
end;

function TDevice.SendToDispenser(aData: AnsiString): Boolean;
begin
  if Common.Config.KioskDispenserPort = 0 then Exit;
  try
    FDispenserBuff    := EmptyStr;
    FDispenserData    := EmptyStr;

    if not DispenserComPort.Active then
      DispenserComPort.Active := true;
    Common.WriteLog('work', Format('키오스크(OUT) - %s',[Common.KioskLogFormat(aData)]));
    DispenserComPort.SendString(aData);
    Result := true;
  except
    Result := false;
  end;
end;

end.








