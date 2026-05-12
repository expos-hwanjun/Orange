unit Const_U;

interface

uses Messages, AdvPanel, cxLabel;
const
  RestBaseURL          = 'https://letsorder.expos.co.kr:19008/Orange/|';
  jsonSMSURL           = 'http://39.120.147.83:18008/Orange/';
  StandardStore         = '00000000';
  fmtDateTimeLong       = 'yyyy"년" m"월" d"일" ampm h:nn:ss';
  fmtDateTime           = 'yyyy/mm/dd(ddd) ampm hh:nn';
  fmtDateShort          = 'yyyymmdd';
  fmtDate               = 'yyyy-mm-dd';
  atSwipe               = 'S';
  atKeyIn               = 'K';
  atCat                 = 'C';
  atPG                  = 'P';
  dtApproval            = 'A';
  dtCancel              = 'C';
  otStore               = 0;
  otTakeOut             = 1;
  alCenter              = 1;
  alLeft                = 0;
  alRight               = 2;
  trPort                = 8005;
  DemonPort             = 7066;
  AgentPort             = 7004;

  vanVCat               = '2';
  vanCat                = '1';

   _INIFILENAME    = 'Config.ini';          //환경설정 파일명
   _INIFILECARDLOG = 'CARDLOG.INI';         //캐셔별 카드전표 승인 및 취소 건수 로그
   
   PORT          :Array[1..10] of String =('COM1','COM2','COM3','COM4','COM5','COM6','COM7','COM8','COM9','COM10');
   VANTRDPL      :Array[0..12] of String =('(KOCES)', '(DAOU)','(NICE)','(KICC)','(KIS)','(KSNET)','(KCP)','(KPN)','(JTNET)','(KFTC)','(SMARTRO)','(KOVAN)','(Secta9ine)');
   BAUDRATE      :Array[0..4] of Integer =(9600,19200,38400,57600,115200);


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
      rptLink3     = 25;
      rptLink4     = 26;
      rptLetsOrder = 27;
      rptInterimReceipt=28;

   {매출그리드 사용 환경설정} {상품}
   GDM_COLCOUNT    = 69;  //그리드 칼럼수
   GDM_NO          = 0;
   GDM_TYPE        = 1;   //N:일반, S:세트, C:코스, W:저울, P:포장, G:싯가
   GDM_NM_MENU     = 2;   //메뉴명
   GDM_VIEWQTY     = 3;   //판매수량
   GDM_VIEWPRICE   = 4;   //판매단가(중량형일때는 100g당단가를 보이기위함)
   GDM_AMT         = 5;   //판매금액
   GDM_DC_MENU     = 6;   //메뉴할인
   GDM_CD_MENU     = 7;   //메뉴코드
   GDM_SEQ         = 8;   //코스메뉴일때 메뉴순번
   GDM_DS_MENU     = 9;   //메뉴구분
   GDM_CD_MENU1    = 10;  //세트 OR 코스구성메뉴
   GDM_NO_STEP     = 11;  //코스단계
   GDM_DC_RECEIPT  = 12;  //전체금액할인
   GDM_DC_MEMBER   = 13;  //회원할인
   GDM_DC_SPC      = 14;  //행사할인
   GDM_NO_SPC      = 15;  //행사번호
   GDM_DS_SALE     = 16;  //매출구분(매출-S,서비스-D, P-포장)
   GDM_DS_TAX      = 17;  //세무구분   0:면세, 1:과세(포함), 2:과세(별도)
   GDM_AMT_TAX     = 18;  //과세금액
   GDM_YN_ORDER    = 19;  //주문여부(Y:주문, N:미주문)
   GDM_NEPUM       = 20;  //세트 구성수량
   GDM_KITCHEN     = 21;  //주방프린터
   GDM_ORDERTIME   = 22;  //주문시간(주문취소시 사용함)
   GDM_TABLENO     = 23;  //분할영수증 사용시 멀티 SELECT
   GDM_QTY         = 24;  //중량형일때 실제 중량
   GDM_DT_ORDER    = 25;  //주문률시간
   GDM_MEMO        = 26;  //주방메모
   GDM_YN_DC       = 27;  //할인여부
   GDM_YN_POINT    = 28;  //포인트적립여부
   GDM_YN_RCP      = 29;  //영수증출력여부
   GDM_PRT_KITCHEN =  30;
   GDM_NO_GROUP    =  31;  //주방출력 옵션(0:같은층 주방, 1:체크한 모든주방, 2:주방에 설정한 층)
   GDM_PR_SALE_ORG =  32;  //주방 메뉴그룹
   GDM_PR_SALE_DB  =  33;  //
   GDM_NM_MENU_ORG =  34;  //
   GDM_CHANGE      =  35;  //메뉴원래명
   GDM_TIP         =  36;
   GDM_CD_ITEM     =  37;
   GDM_PR_ITEM     =  38;
   GDM_NM_ITEM     =  39;  //아이템명
   GDM_CD_CLASS    =  40;
   GDM_CORNER      =  41;
   GDM_PR_SALE     =  42; //코너코드
   GDM_SVC         =  43; //판매단가
   GDM_YN_DOUBLE   =  44;//곱빼기여부
   GDM_YN_PERSON   =  45;
   GDM_PR_BUY      =  46; //고객수 추정메뉴
   GDM_RT_PROFIT   =  47; //매입금액
   GDM_CD_SERVICE  =  48; //이익율
   GDM_YN_BILL     =  49; //서비스코드
   GDM_YN_KITCHEN  =  50; //고개주문서 출력여부
   GDM_YN_MUST     =  51; //서비스로 변경 후 그냥 닫기를 했을때 저장하기 위함
   GDM_YN_TICKET   =  52; //식권
   GDM_DC_TAXFREE  =  53; //배분
   GDM_DC_STAMP    =  54;
   GDM_SAVE_STAMP_M=  55;
   GDM_USE_STAMP_M =  56;
   GDM_SAVE_STAMP  =  57;
   GDM_USE_STAMP   =  58; //스템프 적림
   GDM_AMT_ORG     =  59;
   GDM_DS_STOCK    =  60;
   GDM_QTY_UNIT    =  61;
   GDM_YN_POINT_LIMIT=62;
   GDM_CONFIG        =63;
   GDM_PR_SALE_PACKING = 64;
   GDM_NM_MENU_KITCHEN = 65;
   GDM_SERVICE_CHG     = 66;   // 기존주문을 서비스로 일부변경 시 (Y/N)
   GDM_YN_CASHTEMP     = 67;
   GDM_QTY_SELECT      = 68;

   {카드}
   GDC_COLCOUNT       = 43;
   GDC_DS_CARD        = 0;                      //카드구분(C:신용카드, I:현금IC카드, P:PG)
   GDC_DS_TRD         = 1;                      //거래구분(A:승인, C:취소)
   GDC_TYPE_TRD       = 2;                      //거래형태(S:Swipe, K:Key-In, C:단말기)
   GDC_NAME           = 3;                      //카드명(발급사)
   GDC_CD_BUY         = 4;                      //매입사코드
   GDC_NM_BUY         = 5;                      //매입사명
   GDC_CHAINPL        = 6;                      //가맹점코드
   GDC_CARDNO         = 7;                      //카드번호
   GDC_HALBU          = 8;                      //할부개월수
   GDC_AMT            = 9;                      //금액
   GDC_TIPAMT         = 10;                     //봉사료금액
   GDC_VATAMT         = 11;                     //부가세
   GDC_DCAMT          = 12;
   GDC_VALID          = 13;                     //카드유효기간
   GDC_NO_APPROVAL    = 14;                     //승인번호
   GDC_APPROVAL_ORG   = 15;                     //당초매출시 승인번호
   GDC_TRD_DATE       = 16;                    //승인일자
   GDC_TRD_TIME       = 17;                    //승인시간
   GDC_TRD_DATE_ORG   = 18;                    //당초매출일자
   GDC_REALMODE       = 19;                    //승인모드
   GDC_IMGFILE        = 20;                    //전자서명화일명
   GDC_SENDLOG        = 21;                    //송신데이터
   GDC_RECVLOG        = 22;                    //응답데이터
   GDC_NOTE           = 23;                    //알림메세지
   GDC_YN_CAN         = 24;                    //취소여부(Y:취소, N:취소안됨)
   GDC_YN_PRINT       = 25;                    //출력여부(Y:출력, N:출력안함)
   GDC_YN_SAVE        = 26;                    //저장여부(Y:저장함, N:저장안함)
   GDC_SIGNFILE       = 27;
   GDC_CORNER         = 28;                    //코너코드
   GDC_DS_DC          = 29;                    //할인구분
   GDC_YN_UNIONPAY    = 30;                    //선불카드 잔액
   GDC_BALANCEAMT     = 31;                    //선불카드 잔액
   GDC_YN_CAT         = 32;                    //5만원미만 무서명
   GDC_VAN_TID        = 33;
   GDC_YN_PRINT_TEMP  = 34;
   GDC_YN_PRINT_TEMP2 = 35;
   GDC_PG_TID         = 36;
   GDC_YN_AHEAD       = 37;
   GDC_AMT_CANCEL     = 38;                   //선결제승인여부
   GDC_ORG_TABLENO    = 39;
   GDC_TRANSNO        = 40;                   //렛츠오더에서 그룹디테일에 결제시 마스터로 저장하니 원래테이블 번호
   GDC_PAYCODE        = 41;                   //거래고유번호
   GDC_NO_EASYPAY     = 42;


   {현금영수증}
   GDR_COLCOUNT     = 19;
   GDR_DS_TRD       = 0;                      //거래구분(A:승인, C:취소)
   GDR_DS_KIND      = 1;                      //거래유형(0:개인, 1:사업자)
   GDR_DS_TYPE      = 2;                      //승인유형(0:카드, 1:휴대폰, 2:주민번호, 3:사업자번호)
   GDR_DS_INPUT     = 3;                      //입력방법(S:SWIPE, O:외부)
   GDR_CARDNO       = 4;                      //번호
   GDR_NO_APPROVAL  = 5;                      //승인번호
   GDR_AMT          = 6;                      //승인금액
   GDR_VAT          = 7;                      //부가세금액
   GDR_TRD_DATE     = 8;                      //승인일자
   GDR_TRD_DATE_ORG = 9;                      //원승인일자
   GDR_APPROVAL_ORG = 10;                     //원승인번호
   GDR_YN_CAN       = 11;                     //취소여부(Y:취소할수있음, N:취소할수없음)
   GDR_YN_PRINT     = 12;                     //저출력여부(Y:출력, N:출력안함)
   GDR_YN_SAVE      = 13;                     //저장여부(Y:저장함, N:저장안함)
   GDR_CORNER       = 14;
   GDR_FULLCARDNO   = 15;
   GDR_YN_CAT       = 16;
   GDR_VAN_TID      = 17;
   GDR_YN_AHEAD     = 18;

   {OK캐쉬백}
   GDO_COLCOUNT     = 16;
   GDO_DS_TRD       = 0;                      //거래구분(0:승인, 1:취소)
   GDO_DS_TYPE      = 1;                      //거래유령(S:적립, U:사용)
   GDO_DS_AMT       = 2;                      //거래금액구분(01:현금, 02:카드)
   GDO_CARDNO       = 3;                      //카드번호
   GDO_PNT_OCCUR    = 4;                      //적립포인트
   GDO_PNT_AVAIL    = 5;                      //가용용포인트
   GDO_PNT_TOTAL    = 6;                      //누적포인트
   GDO_CHAINPL_FEE  = 7;                      //가맹점수수료
   GDO_NO_APPROVAL  = 8;                      //승인번호
   GDO_AMT          = 9;                      //승인금액
   GDO_TRD_DATE     = 10;                      //승인일자
   GDO_TRD_DATE_ORG = 11;                     //원승인일자
   GDO_APPROVAL_ORG = 12;                     //원승인번호
   GDO_YN_CAN       = 13;                     //취소여부(Y:취소할수있음, N:취소할수없음)
   GDO_YN_PRINT     = 14;                     //저출력여부(Y:출력, N:출력안함)
   GDO_YN_SAVE      = 15;                     //저장여부(Y:저장함, N:저장안함)

   {올레클럽 or OhPoint}
   GDK_COLCOUNT     = 14;
   GDK_DS_TRD       = 0;                      //거래구분(1:승인, 2:취소)
   GDK_CARDNO       = 1;                      //카드번호
   GDK_DC_AMT       = 2;                      //사용포인트
   GDK_PNT_REST     = 3;                      //잔여포인트
   GDK_NO_APPROVAL  = 4;                      //승인번호
   GDK_AMT          = 5;                      //승인금액
   GDK_CHAINPL      = 6;                      //가맹점번호
   GDK_TRD_DATE     = 7;                      //승인일자
   GDK_TRD_DATE_ORG = 8;                      //원승인일자
   GDK_APPROVAL_ORG = 9;                      //원승인번호
   GDK_YN_CAN       = 10;                     //취소여부(Y:취소할수있음, N:취소할수없음)
   GDK_YN_PRINT     = 11;                     //저출력여부(Y:출력, N:출력안함)
   GDK_YN_SAVE      = 12;                     //저장여부(Y:저장함, N:저장안함)

   {보류}
   GDH_COLCOUNT = 4;
   GDH_DS_SALE  = 0;
   GDH_CD_MENU  = 1; //보류순번
   GDH_QTY      = 2; //보류번호
   GDH_PRICE    = 3; //단가(금액형상품일때);
   GDH_ITEM     = 4; //아이템메뉴

   {결재화면에 시재그리드}
   GDP_COLCOUNT = 6;
   GDP_KIND     = 0;
   GDP_AMT      = 1;
   GDP_CARD     = 2;
   GDP_CHECK    = 3;
   GDP_CARDINFO = 4;
   GDP_ROW      = 5;

// 프린터 특수명령
   rptCharNormal   = '{N}';   // 일반 글자
   rptCharBold     = '{B}';   // 굵은 글자
   rptCharInverse  = '{I}';   // 역상 글자
   rptCharUnderline= '{U}';   // 밑줄 글자
   rptAlignLeft    = '{L}';   // 왼쪽 정렬
   rptAlignCenter  = '{C}';   // 가운데 정렬
   rptAlignRight   = '{R}';   // 오른쪽 정렬
   rptSizeNormal   = '{S}';   // 보통 크기
   rptLogoImage    = '{J}';   // 영수증로고
   rptQRImage      = '{Q}';   // QR이미지
   rptBeep         = '{E}';   // TM계열 벨소리
   rptSignImage0    = '{S0}';   // 카드이미지
   rptSignImage1    = '{S1}';   // 카드이미지
   rptSignImage2    = '{S2}';   // 카드이미지
   rptSignImage3    = '{S3}';   // 카드이미지
   rptSignImage4    = '{S4}';   // 카드이미지
   rptSignImage5    = '{S5}';   // 카드이미지
   rptSignImage6    = '{S6}';   // 카드이미지
   rptSignImage7    = '{S7}';   // 카드이미지
   rptSignImage8    = '{S8}';   // 카드이미지
   rptSignImage9    = '{S9}';   // 카드이미지
   rptEnlargeNone  = rptSizeNormal;
   rptSizeWidth    = '{X}';   // 가로확대 크기
   rptEnlargeX     = rptSizeWidth;
   rptSizeHeight   = '{Y}';   // 세로확대 크기
   rptEnlargeY     = rptSizeHeight;
   rptSizeBoth     = '{Z}';   // 가로세로확대 크기
   rptEnlargeXY    = rptSizeBoth;
   rptSize3Times   = '{3}';   // 가로세로3배확대 크기
   rptLF           = #13;
   rptOneLine      = '{O}';
   rptTwoLine      = '{T}';
   rptOneLine2     = '{2}';
   rptTwoLine2     = '{4}';
   rptpStr         = '{6}';
   rptBarcode      = '{D}';      //14자리
   rptStamp        = '{ST}';    //스템프 이미지

   prtNone         = 0;
   prtESPON        = 1;       //엡슨계열
   prtTM           = 2;
   prtKICC         = 3;

   vanKOCES         = 0;
   vanDaou          = 1;
   vanNICE          = 2;
   vanKICC          = 3;
   vanKIS           = 4;
   vanKSNET         = 5;
   vanKCP           = 6;
   vanFDIK          = 7;
   vanJTNET         = 8;
   vanKFTC          = 9;
   vanSmartro       = 10;
   vanKOVAN         = 11;
   vanSPC           = 12;


   WM_RECEIVEMSG     = WM_USER + 100;
   WM_SENDTOTR       = WM_USER + $17;
   WM_KSNET_REQUEST             = 1325;
   WM_KSNET_IC_FIRST            = 1326;
   WM_KSNET_FALLBACK            = 1327;
   WM_KSNET_IC_READING          = 1329;
   WM_KSNET_IC_APPROVAL_REQUEST = 1332;
   WM_KSNET_MS_APPROVAL_REQUEST = 1333;
   WM_KSNET_SIGN_REQUEST        = 1365;

  msgDevErrInit          = '를 초기화 할 수 없습니다.';
  msgDevPortCom          = 'COM%d';
  msgDevPortErrOpen      = msgDevPortCom+' 포트를 열 수 없습니다.';
  msgDevPortErrUsed      = msgDevPortCom+' 포트는 이미 다른 장치에서 사용 중입니다.';
  msgDevPrnErrNotReady   = '프린터('+msgDevPortCom+')가 준비되어 있지 않습니다.';
  msgDevPrnErrBuffer     = '프린터('+msgDevPortCom+') 버퍼가 꽉 찼습니다.';
  msgDevPrnErrCutter     = '프린터('+msgDevPortCom+') 커터에 문제가 있습니다.';
  msgDevPrnErrCoverOpen  = '프린터('+msgDevPortCom+') 덮개가 열려 있습니다.';
  msgDevPrnErrCoverPaper = '프린터('+msgDevPortCom+') 덮개가 열렸거나 용지가 없습니다.';
  msgDevPrnErrDataSend   = '프린터('+msgDevPortCom+')에 자료를 전송할 수 없습니다.';
  msgDevPrnErrHeadTemp   = '프린터('+msgDevPortCom+') 헤드 온도가 높습니다.';
  msgDevPrnErrOffline    = '프린터('+msgDevPortCom+')가 Off Line 상태입니다.';
  msgDevPrnErrPaper      = '프린터('+msgDevPortCom+') 용지가 없거나 잘못 끼워져 있습니다.';
  msgDevPrnErrPaperJam   = '프린터('+msgDevPortCom+') 용지가 걸렸습니다.';
  msgDevPrnErrPowerOff   = '프린터('+msgDevPortCom+') 전원이 꺼져있거나 응답이 없습니다.';
  msgDevPrnErrUnrecover  = '프린터('+msgDevPortCom+')에 심각한 문제가 있습니다.';
  msgDevPrnErrLPT        = '프린터(LPT1)로 인쇄를 할 수 없습니다.';
  msgAsk                 = 1;
  msgMsg                 = 2;
  msgError               = 3;

  splitColumn          = #$03F0;

  _CryptKey       = 2843;
  _LincenseKey    = 4962;
  _DemoKey        = 2345;

  mbInfo = 1;  //정보
  mbFill = 2;  //
  mbErr  = 3;  //에러
             
  KtisServer = '121.78.129.247';
  KtisPort   = 21015;

  PadLicenseKey = 'A08C3BAD8B0842E39EAF482C774853A6';

  iniConfig            = 'Config.ini';
  iniMain              = 'MAIN';
  iniPos               = 'POS';
  iniCommon            = '공통';
  iniStore             = '매장코드';
  iniLastUser          = '최종사용자';
  iniDBIP              = 'DB_IP';
  iniPosIP             = 'POS_IP';
  iniDBName            = 'DB_NAME';
  iniDBUser            = 'DB_USER';
  iniDBPort            = 'DB_PORT';

  bfNone               = 'N';    //선택안함
  bfWheelChair         = 'L';    //저자세모드
  bfLowVision          = 'V';    //저시력모드
type
  PStrPointer = ^TStrPointer;
  TStrPointer = record
    Data: string;
  end;

implementation

end.








