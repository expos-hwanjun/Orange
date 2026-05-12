{******************************************************************************

                 Copyright (c) 2021 ExtremePOS

 * Unit Name   : Common_U.pas
 * Purpose     : 프로젝트 메인 모듈
 * Make Date   : 2021/06/10
 * Programming : 김 환 준
 * History     :                                         
 ******************************************************************************}
unit Common_U;

interface

uses Winapi.Windows, SysUtils, System.Classes, Forms, Controls, db, Dialogs,   Grids,
     Printers, IniFiles, Graphics, stdCtrls, Registry, Variants,
     Mask, Buttons, ExtCtrls, Messages, Const_U, Math, cxCurrencyEdit, cxCalendar,
     MaskUtils, ShellAPI, Device_U, Types,  PosButton,
     GraphicEx, IdTCPClient, StrUtils, DateUtils, cxGridTableView, Imm, Winsock,
     Uni, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack,
     IdIntercept, IdGlobal, POSCard, Tlhelp32, MMSystem, AdvShape, dxmdaset,
     Vcl.Imaging.PNGImage, cxButtons, REST.Types, REST.Client, System.JSON, System.Hash,
     AdvSmoothButton, AdvSmoothToggleButton, GDIPFill, System.Net.URLClient,
     cxCheckBox, cxLabel, AdvGlassButton, AdvPageControl, cxGroupBox, IdHTTP,
     System.RegularExpressions, System.NetEncoding, cxImage, cxGraphics, AdvPanel,
     ActiveX;

const
  splitRecord     = #$03E0;
  splitColumn     = #$03F0;
  splitRecordAnsi = '|';
  splitColumnAnsi = #9;
  regPath         = 'ExtremePOS\CloudOrange';
  filConfigIni    = 'Config.ini';                                //환경설정 파일

type TPosType    = (ptOnlyOrder, ptAccount, ptNotAccount );      //포스타입(주문전용, 개점된정산포스, 개점이 안된정산포스)
type TWorkKind   = (wkSale, wkPacking, wkService, wkRefund);               //업무구분(판매등록, 포장, 서비스, 반품 )
type TOrderKind  = (okNone, okNew,  okAppend, okChange, okCancel, okBanpum, okDutchPay, okDutchPayEnd, okDutchPayAll, okSaleChange);         //주문구분(신규주문, 추가주문, 결제변경)
type TPrintState = (psOnLine, psOffLine);                //프린터상태
type TWorkState  = (wsReady, wsSale, wsAcct, wsMagam);   //판매준비중, 판매중, 정산중, 정산완료
type TPrintMode  = (pmPrint, pmNoPrint, pmRePrint);      //영수증출력여부
type TTableMode  = (tbmNone,
                    tbmTableMove, tbmTableMoveing,  //테이블이동
                    tbmMerge,     tbmMergeing,      //테이블합석        Get
                    tbmMenuMove,  tbmMenuMoveIng,   //메뉴이동
                    tbmGroup,     tbmGrouping, tbmGroupEnd,  //그룹지정
                    tbmUnGroup,                    //그룹해제
                    tbmRePrint,                    //재인쇄
                    tbmBooking,                    //예약
                    tbmDutchPay,
                    tbmWaitOrder,                  //대기주문시 실제이용테이블 지정
                    tbmClear,
                    tbmTableKey);
type TDeliveryMode = (dmNone, dmOrder, dmReprint, dmDelivery, dmDishReturn, dmDishReturnPrint, dmDelete, dmNotTel); //주문정보(재출력, 배달, 그릇회수)
type TMsgKind    = (mkShow, mkHide);              //확인메세지 구분(mkShow:무조건보인다, mkHide :조건에따라 패스)
type TFormShowMode   = (fsmNone, fsmSale);
type TWorkType   = (wtNew, wtOutNew, wtEdit);  //신규주문, 신규주문(부재중), 주문수정)
type TFormShowType   = (fstNone, fstOrder, fstDelete, fstDeliveryGo, fstDishReturn, fstRePrint);
type TSplitPrintMode = (spmOnePage, spmSplit);
type TCardPrintMode  = (cpmAtOnce, cpmAtAcct);  //신용카드 출력 cpmatOnce - 승인즉시,  cpmatAcct - 정산시

type
  TDeleteGrid = class(TStringGrid); //RowDelete 시 사용

  {처리중 메세지 쓰레드}
   TWaitThread = class(TThread)
   private
     procedure ShowMsg;
   protected
     procedure Execute; override;
   public
     constructor Create;
     destructor Destroy; override;
   end;

  {렛츠오더 메세지 쓰레드}
   TLetsOrderThread = class(TThread)
   private
     procedure ShowMsg;
   protected
     procedure Execute; override;
   public
     constructor Create;
     destructor Destroy; override;
   end;
type
  TMenu = record                  { 메 뉴 }
    cd_menu      :String[100];  //메뉴코드
    nm_menu      :String;       //메뉴명
    nm_menu_org  :String;
    nm_menu_kitchen:String;
    ds_menu      :String[1];    //메뉴구분(N:일반, S:세트, C:코스, D:쿠폰)
    cd_menu1     :String[14];    //세트 or 코스 구성메뉴
    seq          :Integer;      //코스메뉴일때(메뉴가 같으면) 순번
    no_step      :Integer;      //코스단계
    pr_sale      :Integer;      //판매단가
    pr_sale_org  :Integer;
    pr_sale_db   :Integer;      //곱빼기기능
    pr_sale_std  :Integer;      //기준판매가
    pr_sale_tax  :Integer;      //부가세
    pr_item      :Integer;
    pr_sale_packing :Integer;   //포장단가
    qty_sale     :Integer;      //판매수량
    amt_sale     :Integer;      //판매금액
    dc_menu      :Integer;      //메뉴할인금액
    dc_enuri     :Integer;      //에누리할인금액
    no_coupon    :String;       //쿠폰번호
    dc_coupon    :Integer;      //쿠폰할인금액
    dc_member    :Integer;      //회원할인금액
    dc_spc       :Integer;      //행사할인금액
    no_spc       :String[12];   //행사번호
    dc_code      :Integer;      //코드할인
    no_code      :String[3];    //코드할인번호
    ds_sale      :String[1];    //매출구분(S:매출, D:서비스)
    ds_tax       :String[1];    //과세구분(0:면세, 1:과세(포함), 2:과세(별도))
    qty_nepum    :Integer;
    qty_select   :Integer;
    kitchen      :String;       //주방프린터
    nm_table     :String;
    memo         :String;       //주방메모
    dt_order     :String;       //주문시간
    yn_order     :String;
    yn_dc        :String;
    yn_point     :String;
    yn_point_limit:String;
    yn_rcp       :String;
    prt_kitchen  :Integer;
    no_group     :Integer;      //주방주문서 메뉴별 인쇄시 메뉴그룹
    change       :String;
    pr_tip       :Integer;
    cd_item      :String;       //아이템 메뉴코드(0001,0002)
    nm_item      :String;       //아이템 메뉴명
    cd_class     :String;
    scaleorder   :String[1];    //저울주문여부(Y,N)
    corner       :String;       //코너코드
    svc          :String[1];
    yn_double    :String[1];
    yn_person    :String[1];
    pr_buy       :Integer;
    rt_profit    :Currency;
    cd_service   :String;
    yn_bill      :String[1];
    yn_kitchen   :String;
    yn_ticket    :string;
    save_stamp   :integer;
    use_stamp    :integer;
    ds_stock     :string;
    qty_unit     :integer;
    config       :string;
    menu_info    :string;
    yn_cashtemp  :string;      //현금요청시 주문여부(폼닫을때 체크에사용)
  end;

  TTable = record
     OrderNo     : Integer;     //주문번호
     OrderType   : String[1];   //주문타입(T-테이블, D-배달주문)
     Floor       : String[3];   //층번호
     FloorName   : String;
     Number      : Integer;     //테이블번호
     Name        : String[50];
     DamdangCode : String;      //테이블담당자코드
     DamdangName : String;      //네이블담당자명
     CustomerCount : Integer;     //인원수
     Date        : String[8];   //들어온일자
     Time        : String[5];   //들어온시간
     BookingImg  : String[2];
     BookingNo   : String[11];  //예약번호
     BookingAmt  : Integer;
     GroupType   : String[10];  //M-Master, N-None, 그외는 Sub이면서 마스터테이블 번호
     GroupAmt    : Integer;     //그룹주문금액
     CustCode    : String[3];   //객층코드
     AgeCode     : TStringList;  //연령대 (00102,00210....)
     DsDelivery  : String;
     DeliveryNo  : String;      //배달번호
     AHeadPay    : Boolean;     //선결제여부
     DcCode      : String;
     Dc_Rate     : Currency;
     Dc_Amt      : Integer;
     Dc_Menu     : Integer;
     Dc_CodeAmt  : Integer;
     Course      : String;       //배달코스
     Local       : String;       //배달지역
     Addr1       : String;
     Addr2       : String;
     OrderAmt    : Integer;
     Corner      : String;
     DsCust      : String[1];    //신규고객여부
     Packing     : String[1];    //포장전용테이블
     Memo        : String;
     LapeTime    : Integer;
     MemberCode  : String;
     DeliveryTel : String;
     LetsOrder   : String;       //렛츠오더 주문여부(Y/N)
     WaitTableNo : Integer;      //대기시 주문한 테이블
     isWaitTable : Boolean;
     isCashOrder : Boolean;      //렛츠오더에서 현금주문 여부
  end;

  TDelivery = record
    Number   :String;     //배달번호
    CustName :String;     //고객명
    Status   :String;     //상태
    Damdang  :String;     //담당자
  end;

  {쿠폰}
  TCupon = record
     Kind      : String[1];                       //쿠폰종류(MOBILE, HOME, CMS, LG, MEMBER, ARI, LOCAL)
     barcd_c   : String[13];                      //쿠폰바코드
     Nm_Cpn    : String;                          //쿠폰명칭
     barcd_s   : String;                          //대상상품바코드
     cpn_type  : String;                          //쿠폰할인유형(1:수량, 2:금액)
     qty_cpn   : Integer;                         //쿠폰수량
     qty_goods : Integer;                         //대상상품갯수
     amt_goods : Double;                          //쿠폰기준금액
     pr_cpn    : Integer;                         //할인단가
     cpn_from  : String;                          //쿠폰할인유효기간 from
     cpn_to    : String;                          //쿠폰할인유효기간 to
     hecha     : String;                          //쿠폰회차
  end;


  {시재정보}
  TPreSent = record
    DsTrd        : String[1];               // 조회영수증이 반품일경우 판매취소를 하지 못하게 하기위함
    RcpNo        : String;                  // 영수증번호
    CardSeq      : Integer;                 // 신용카드승인시 사용
    CashSeq      : Integer;                 // 현금영수증승인시 사용
    GoodQty      : Integer;                 // 품목건수

    MenuDc       : Integer;                 // 단품할인
    MemberDc     : Integer;                 // 회원할인
    RcpDc        : Integer;                 // 전체금액 할인
    SpcDc        : Integer;                 // 행사할인금액
    CodeDc       : Integer;                 // 지정할인
    EventDc      : Integer;                 // 이벤트 할인

    CouponNo     : String;                  // 쿠폰번호
    CouponKind   : String;                  // 쿠폰구분(0:매장발행, 1:본부발행)
    CouponType   : String;                  // 쿠폰유형(A:금액형쿠폰, R:%할인쿠폰)
    CouponRate   : Integer;                 // 쿠폰할인율
    CouponDc     : Integer;                 // 쿠폰할인금액
    CouponMember : Boolean;                 // 회원전용여부
    CouponLimit  : Integer;                 // 쿠폰할인 최대 금액
    CouponMenu   : String;                  // 쿠폰적용메뉴
    CouponMemberNo :String;                 // 특정회원만 사용가능
    CouponSaleAmt   :Integer;               // 최소구매금액

    CutDc        : Integer;                 // 단차할인
    VatDc        : Integer;                 // 부가세할인
    CodeDcCode   : String;                  // 지정할인코드
    CodeDcName   : String;                  // 지정할인명
    CodeDcClass  : String;                  // 지정할인 메뉴분류
    CodeDcType   : String;                  // 할인구분(0:률, 1:금액)
    CodeDcRate   : Currency;                // 할인율
    CodeDcStdAmt : Integer;                 // 할인기준금액
    CodeDcAmt    : Integer;                 // 할인금액
    RcpDc_Rate   : Currency;                // 전체할인 할인율
    PointDc      : Integer;                 // 포인트할인
    TaxFreeDc    : Integer;
    StampDc      : Integer;
    UPlusDc      : Integer;
    KaKaoDc      : Integer;
    LetsOrderDc  : Integer;
    TotalDC      : Integer;                 // 할인 합계

    DutyAmt      : Integer;                 // 부가세 과세 품목 합계
    FreeAmt      : Integer;                 // 면세금액
    TaxAmt       : Integer;                 // 부가세
    DutyAmt_Prt  : Integer;                 // 부가세 과세 품목 합계
    FreeAmt_Prt  : Integer;                 // 면세금액
    TaxAmt_Prt   : Integer;                 // 부가세
    TotalAmt     : Integer;                 // 합계금액
    SoonAmt      : Integer;                 // 매출합계(DB에 저장되는 데이터)

    UsePnt       : Integer;                 // 사용포인트
    OccurPnt     : Integer;                 // 적립포인트
    TrustAmt     : Integer;                 // 외상금액
    GiftAmt      : Integer;                 // 상품권
    CardAmt      : Integer;                 // 카드결제금액
    CashAmt      : Integer;                 // 현금 입금액
    CheckAmt     : Integer;                 // 수표금액
    BankAmt      : Integer;                 // 계좌입금
    PointAmt     : Integer;                 // 포인트결제
    EtcAmt       : Integer;                 // 기타결제
    SetTip       : Integer;                 // 계산원이 조정한 봉사료 금액 또는 율
    CashTipAmt   : Integer;                 // 현금봉사료
    CardTipAmt   : Integer;                 // 카드봉사료
    TipAmt       : Integer;                 // 봉사료
    ExistDcAmt   : Integer;                 // 할인제외금액
    ExistPointAmt: Integer;                 // 포인트제외상품
    ExistPointUseAmt :Integer;              // 포인트사용제외상품
    ServiceAmt   : Integer;                 // 서비스금액
    AddMenuAmt   : Integer;                 // 추가요금
    TaxfreeNo    : String;                  // 환급전표번호
    TaxRefundAfterLimit   : Integer;                 // 즉시환급 잔여한도
    SaveStamp    : Integer;
    UseStamp     : Integer;
    OldMember    : String;
    OldSaveStamp : Integer;
    OldUseStamp  : Integer;

    RcvAmt       : Integer;                 // 받은 금액
    OrgRcvAmt    : Integer;                 // 테이블 들어올때 받을 금액
    CashRcpAmt   : Integer;                 // 현금영수증승인금액
    CashRcvAmt   : Integer;                 // 현금영수증 받은금액

    OrgCardAmt   : Integer;                 // 취소시 원카드승인금액(출력시 사용)
    CardCancelAmt: Integer;                 // 카드취소금액

    WRcvAmt      : Integer;                 // 받을 금액
    GiveAmt      : Integer;                 // 거스름돈
    ReadyChk     : Boolean;
    CardSign     : Boolean;

    SaleTime     : String;                  //재출력 시 사용
    SaleDate     : TDateTime;
    CallNo       : Integer;                 //호출번호
    CallTelNo    : String;                  //키오스크일때 호출전화번호
    //발행쿠폰 정보
    CouponNo_Issue :String;
    CouponName_Issue:String;
    CouponType_Issue:String;
    CouponAmt_Issue :Integer;
    CouponFromDate_Issue,
    CouponToDate_Issue :String;

    DutchPayAmt : Integer;
    LetsOrderAmt : Integer;
    AHeadPayAmt  : Integer;                //선결제금액
    AHeadCashAmt : Integer;                //선결제현금(현금영수증 제외)
    //키오스크 티켓(식권)출력 데이터
    TicketPrintData :TStringList;          //영수증번호(20170814010001) #28 메뉴명 #28 시작번호 #28 끝번호
  end;

  {카드}
  TCard = record
     Ds_Card      : String;                  //카드구분 (C:신용카드, I:현금IC카드, K:카카오페이, Z:제로페이, P:PG, M:카카오머니)
     Ds_trd       : String;                  //거래구분 (1:카드승인, 2:카드승인취소)
     Nm_Card      : String;                  //카드종류
     cd_buy       : String;                  //매입사코드
     nm_buy       : String;                  //매입사명
     CardNoFull   : String;                  //카드번호 풀네임
     CardNo       : String;                  //카드번호
     Halbu        : String;                  //할부개월수
     Valid        : String;                  //카드유효기간
     Amt          : Integer;                 //금액
     TipAmt       : Integer;                 //봉사료금액
     VatAmt       : Integer;                 //부가세금액
     DcAmt        : Integer;                 //할인금액(현대M카드, 광주은행카드)
     ChainPL      : String;                  //가맹점번호
     ApprovalNo   : String;                  //승인번호
     OrgApprovalNo : String;                 //승인번호(취소시 당초 승인번호)
     Trd_Date     : String;                  //승인일자
     Trd_Date_Org : String;                  //원매출일자(취소시 당초 매출일자)
     Trd_Time     : String;                  //승인시간
     SendData     : String;                  //요청전문
     RecvData     : String;                  //응답전문
     Type_Trd     : String;                  //거래형태(1:S:Swipe, 2:K:Key-In, 3:전화승인)
     RealMode     : Boolean;                 //승인모드
     ImgFile      : String;                  //전자서명화일
     Note         : String;                  //출력메세지
     Yn_Can       : String[1];               //취소여부
     Yn_Print     : String[1];               //출력여부
     Yn_Search    : String[1];               //조회여부
     Yn_Save      : String[1];               //조회여부
     no_van       : Integer;                 //밴구분(0:OneVan, 1:TwoVan)
     Corner       : String;
     SignFile     : String;                  //싸인이미지
     DsDc         : String;                  //M:현대 M카드, K:카카오할인
     Yn_UnionPay  : String;                  //은련카드여부
     BalanceAmt   : String;                  //선불카드 잔액(출력여부를 몰라 String 타입으로 사용한다)
     Yn_Cat       : String;                  //보안리더기 사용시 단말기에서 승인여부
     VanTID       : String;
     PG_TID       : String;
     CancelAmt    : Integer;
     OrgTableNo   : Integer;
     TransNo      : String;                  //거래고유번호
     PayCode      : String;
     EasyPayNo    : String;
  end;

  {현금영수증}
  TCashRcp = record
     Ds_Trd       : String;                  //거래구분(A:승인, C:취소)
     Ds_Kind      : String;                  //거래유형(0:개인, 1:사업자)
     Ds_Type      : String;                  //승인유형(0:카드, 1:휴대폰, 2:주민번호, 3:사업자번호)
     Ds_Input     : String;                  //입력방법(S:SWIPE, K:KEYIN, O:단밀기)
     CardNoFull   : String;                  //카드번호 풀네임
     CardNo       : String;                  //카드번호
     No_Approval  : String;                  //승인번호
     Amt_Approval : Integer;                 //승인금액
     VatAmt       : Integer;                 //부가세금액
     trd_date     : String;                  //승인일자
     trd_date_org : String;                  //원승인일자
     Approval_Org : String;                  //원승인번호
     Yn_Can       : String[1];               //취소여부
     yn_print     : String[1];               //출력여부
     yn_save      : String[1];               //저장여부
     Corner       : String;
     RcvAmt       : Integer;                 //받은금액
     Yn_Cat       : String;
     VanTid       : String;
  end;

  TKioskCash = record
    DataBytes: array[0..19] of Byte;
    inAmount  :integer;          //입금금액
    outAmount :integer;          //방출금액
    RecvPos   :integer;
    Pay       :Boolean;
    BD1       :Boolean;
    BD2       :Boolean;
    HP1       :Boolean;
    HP2       :Boolean;
    Ver       :String;
  end;

  TUPlus = record
    ds_trd        : String;                  //거래구분(A:승인, C:취소)
    CardNo        : String;                  //카드번호
    AgreeAmt      : Integer;                 //승인금액
    Dc_Amt        : Integer;                 //할인금액
    AgreeDate     : String;                  //승인일자
    AgreeNo       : String;                  //승인번호
    OrgAgreeDate  : String;                  //원승인일자
    OrgAgreeNo    : String;                  //원승인번호
    pnt_rest      : Integer;                 //잔여포인트
    TelmflwNo     : String;                  //전문추적번호
    yn_can        : String[1];
    yn_print     : String[1];                //출력여부
    yn_save       : String[1];               //저장여부
  end;

  TMember = record
     Code       : String[10];                //회원코드번호
     Name       : String[30];                //회원명
     cd_class   : String[3];                 //회원등급코드
     nm_class   : String[30];                //회원구분명
     DcType     : String;                    //할인 or 포인트적립 구분
     CardNo     : String;
     MobileTel  : String;                    //연락처
     MobileTelFull :String;
     HomeTel    : String;
     dt_birth   : String;                    //생일
     dt_visit   : String;                    //최종방문일
     Dc_Rate    : Integer;                   //할인율
     OrgOccurPoint :Integer;
     OrgOccurStamp :Integer;
     Point      : Integer;                   //보유포인트
     Yn_trust   : String[1];                 //외상가능여부
     addr1      : String;
     addr2      : String;
     Remark     : String;
     no_cashrcp : String;                    //현금영수증 식별번호
     DamdangCode : String;                   //담당자코드
     DamdangName : String;                   //담당자이름
     Stamp       : Integer;
     CreditAmt   : Integer;                  //외상잔액
     AgeCode     : String;
  end;

  TConfig = record
     Style         : String;       //포스 스타일(B:Blue, D:Dark);
     PosLanguage   : String;       //언어(ko:한국어, en:영어, C:중국어, ja:일본어, vi:배트남, in:인도네시아, fr:프랑스, de:독일어)
     LanguagePath  : String;       //키오스크일때 이미지 Path
     HeadStoreCode : String;
     StoreCode     : String[8];    //매장코드
     StoreName     : String;       //매장명
     StoreBizNo    : String;
     StoreAddress  : String;
     StoreBoss     : String;
     IsTakeOut     : Boolean;
     StoreTel      : String;
     StoreMobile   : TStringList;      //카카오알림톡
     KioskKaKaoTel : TStringList;
     KtisChainNo   : String;
     DefaultAddress: String;       //기본주소(배달)
     PosNo         : String[2];    //포스번호
     MainPosNo     : String;
     OriginalPosNo : String;       //원래포스번호
     PosIP         : String[15];   //포스IP
     DefaultFloor  : String;       //기본층
     AvailFloor    : String;
     ServerIP      : String[15];   //서버ip
     Check_Service : Boolean;      //서비스 관리자만 지급여부
     URL           : String;
     HelpURL       : String;
     SmSTime       : Integer;
     AutoLogin     : Boolean;      //자동로그인
     UseLanguage   : String;       //사용다국어(미국,중국,일본,배트남,태국,인도네시아,프랑스,독일 순)

     UserCode      : String[6];    //로그인한 사원 ID
     UserName      : String;       //로그인한 사원 이름
     UserPass      : String;       //로그인한 사원 패스워드
     ClosePass     : String;
     UserGrade     : String;       //사용자 등급
     LoginUserWork : String;
     UserWork      : String;       //담당업무
     EndUser       : String;

     AutoStart     : String;       //윈도우 시작시 자동실행
     RcpToKitchen  : Boolean;      //영수증프린터 내역을 주방프린터와 같이 사용
     KitchenIndex  : Integer;      //주방프린터의 순번
     ReceiptPrinterDev   : Integer;      //영수증프린터 기종
     ReceiptPrinterPort  : String;      //영수증프린터 포트(0 사용안함, 1..6 com, 7-LPT)
     PrintBottomMargin   : Integer;   //영수증프린터 하단여백
     ReceiptPrinterBaudRate  : Integer;
     ReceiptPrinterCheck     : Boolean;      //영수증프린터 출력전 체크
     Cid_Port      : Integer;      //CID포트
     ScalePort     : Integer;
     DemonCid_Port : Integer;
     Check_Port    : Integer;      //수표인식기
     HandScannerPort  : Integer;      //스캐너포트
     FixScannerPort   : Integer;
     LabelPrinterPort:Integer;
     PassPortPort  : Integer;      //여권리더기
     BellPort,
     BellDev      : Integer;      //진동벨 포트
     TableBellPort   :Integer;    //테이블호출벨포트
     CustPrinterCode :String;      //고객주문서 출력프린터코드
     CustPrinter2Code :String;      //고객주문서 출력프린터코드 (두번째)
     DeliveryPrinterCode:String;   //배달전표 출력프린터코드
     DeliveryReceiptPrinterCode:String; //배달 고객영수증 출력프린터 코드
     DeliveryDisplay :String;
     IsFloorFix    : Boolean;
     DualSize      : Integer;      //듀얼해상도(0:800X600, 1:800X480)
     DualMode      : Integer;      //듀얼모드(0:일반, 1:판매화면 안보임)
     DualText      : String;
     PrintColum    : Integer;      //0:42칼럼, 1:48칼럼

     pnt_min_use   : Integer;      //최소사용포인트

     Options       : String;
     HeadOptions   : String;       //표준 환경설정
     StoreOptions  : String;       //인증관리에서 설정한 옵션

     PosCatUse     : Boolean;      //보안 방식일때 이포스만 단말기 연동으로 사용할때
     IsCardOut     : Boolean;      //단말기승인시 (True-가맹점번호만 입력)
     van_trd       : Integer;      //밴사
     van_Terid     : String;       //밴사터미널 ID
     BizNo         : String;       //사업자번호
     van_ip        : String;       //밴사IP
     van_port      : Integer;      //밴사PORT
     DIDPickupPos  : String;       //DID 픽업위치
     SerialNo      : AnsiString;   //Koces 사용시 단말기 시리얼번호
     van_tax       : Integer;      //Tid별 과세구분(0:과세, 1:면세)
     VanWorkingKey : String;       //금융결제원 WorkingKey
     VanEasyPay    : String;       //0:사용안함, 1:멀티패드, 2:통합결제

     ReceiptTitle  : Array[1..4] of String;       //영수증타이틀
     rcp_end       : Array[1..8] of String;       //영수증끝메세지
     dual_msg      : Array[1..8] of String;       //듀얼메세지
     card_end      : Array[1..5] of String;
     delivery_end  : Array[1..5] of String;

     PluNo         : String[2];    //PLU구분
     ListFontSize  : Integer;
     ListRowHeight : Integer;
     PluFontSize   : Integer;
     DualGridFontSize : Integer;
     DualGridRowHeight: Integer;
     fixdcCode     : String;
     dc_unit       : Integer;      //할인률 할인단위
     len_card      : Integer;      //회원카드 길이
     len_card2     : Integer;      //회원카드 길이
     MemberNoPreFix   : String;    //회원번호프리픽스
     MemberPreFix   : String;       //회원카드프리픽스
     MemberPreFix2  : String;       //회원카드프리픽스
     Red_Hour      : Integer;      //테이블색상을 변경할 입장시간
     TableChangeColor :String;

     TipType       : String[1];
     TipApply      : Integer;
     TipMenu       : String;
     TipTax        : String;

     ScalePrefix : String;       //저울바코드프리픽스
     CustOrderTitle: String;
     KitchenPrintTitle :String;    //주방주문서 타이틀
     ReportPwd     : String;
     RcpSearchPwd  : String;
     SimpleRcpTxt  : String;
     CustRcpEnd    : Array of String;
     ReadyTelCount : Integer;
     BookingMenu   : String;
     HeadCouponPrefix,
     CouponPrefix  : String;

     HeadCouponLen,
     CouponLen     :Integer;

     Amt_DefReady  : Integer;      //기본준비금

     AutoUpdate    : Boolean;
     IsAcctKitchenPrint :Boolean;  //계산시 주방주문서를 출력할지 여부
     ReceiptLogPrint :Boolean;

     OverTimeTime   :Integer;
     OverTimeMenu   :String;
     OverTimeEach   :Integer;
     OverTimeAmt    :Integer;

     default_menu    : String;      //테이블에 기본메뉴

     PowerOff        : Boolean;

     AcctSMSMessage  : String;      //계산시 문자메세지 내용

     MemberDefaultMenu : String;
     BookingTime     : Integer;
     BookingEnd      : Integer;

     FixPhoneNo      : String;
     SetStampDc      : Integer;
     SetStampCount   : Integer;

     SmartPosDemon   : Boolean;
     SmartPad        : Boolean;

     //키오스크관련
     IsKiosk       : Boolean;
     IsKioskCash   : Boolean;      //현금을 사용하는 키오스크인지여부
     KioskType     : String;       //84:일반모드, 85:배리어프리모드
     KioskDefaultFontName :String;  //키오스크 기본폰트명
     KioskButtonRound     :Integer;
     KioskPwd      : String;
     KioskDispenserPort :Integer;
     KioskAlram    : Array[0..5] of Integer;   //키오스크 알람(0:1000원 준비금, 1:100원 준비금 2:1000원 방출수량, 3:100원 방출수량, 4:1000원 중지, 5:100원 중지)
     KioskCashPause: Boolean;     // 잔돈부족으로 현금 일시중지(true :중지, false: 정상)
     notKioskTouch    : Boolean;
     TimePLU         : Array[1..3,  0..3] of String;
     KioskMustMenuCode,
     KioskMustMenuName :String;
     KioskBegin1,
     KioskBegin2     : String;
     KioskOrderPassWord :String;
     BarrierFreeMode  :String;   // bfNone:선택안함,  bfWheelChair:저자세모드, bfLowVision:저시력모드
     BarrierTop        :Integer;

     TableKeyPort    :Integer;

     UplusJoinCode   : String;
     BaeminMenuCode  : String;

     PosWidth,
     PosHeight       : Integer;
     DesignCode      : String;

     PluClassColor : TColor;
     PluClassBorderColor : TColor;
     PluMenuColor  : TColor;
     PluMenuBorderColor  : TColor;
     PluClassDownColor :TColor;
     PluClassDownFontColor :TColor;

     PluMenuFont,
     PluClassFont,
     PluPriceFont  : TFont;
     PluMenuPriceShow,
     PluMenuEmptyShow :Boolean;

     PluClassHeight,
     PluClassWidth,
     PluClassX,
     PluClassY,
     PluMenuX,
     PluMenuY :Integer;
     AllClassPLU :Boolean;

    //하단 판넬 설정값
     PanelConfig  :String;
     PanelWidth : array [1..4] of Integer;
     PanelHeight : Integer;
     TitleCaption : String;
     TitleWidth : array [1..6] of Integer;

     PG_Mid,                  //KisPG 가맹점 TID
     PG_MidKey,
     PG_Cancel   :String;       //암호화 KEY
     PG_BankCode,               //은행명
     PG_BankOwner,              //예금주
     PG_BankNo,                 //계좌번호
     OrderCloseTime   :String;  //주문마감시간

     ParkingCode      :String;
     DefaultPickUp    :String;

     Online_PG_Mid,                  //KisPG 가맹점 TID
     Online_PG_MidKey :String;

     LetsOrderPosNo   :String;
     LetsOrderNoShow  :Boolean;
     LetsOrderCall    :String;       //렛츠오더 주문시 출력 설정

     PosCloseTime     :String;
     ServiceTxt       :String;
     PackingTxt       :String;
  end;


 TMagam = record
     UserCod        : String;    //계산원코드
     amt_ready      : Integer;   //준비금
     amt_deposit    : Integer;   //중간입금
     amt_acct_cash  : Integer;   //출납입금
     amt_acct_card  : Integer;
     amt_acct_out   : Integer;   //출납지출
     amt_cash       : Integer;   //현금매출
     cnt_card       : Integer;   //카드건수
     amt_card       : Integer;   //카드매출
     amt_trust      : Integer;   //외상매출
     amt_check      : Integer;   //수표매출
     amt_gift       : Integer;   //상품권매출
     amt_bank       : Integer;   //계좌입금
     amt_point      : Integer;   //포인트결제
     amt_etc        : Integer;   //기타금액
     amt_letsorder  : Integer;   //렛츠오더금액
     amt_cashtip    : Integer;   //현금봉사료
     amt_cardtip    : Integer;   //카드봉사료
     amt_service    : Integer;   //서비스금액
     dc_menu        : Integer;   //메뉴할인
     dc_member      : Integer;   //회원할인
     dc_code        : Integer;   //지정할인
     dc_receipt     : Integer;   //영수증전체할인
     dc_spc         : Integer;   //행사할인
     dc_event       : Integer;   //영수증번호 행사할인
     dc_cut         : Integer;
     dc_vat         : Integer;   //부가세할인
     dc_point       : Integer;
     dc_coupon      : Integer;
     dc_taxfree     : Integer;
     dc_stamp       : Integer;
     dc_uplus       : Integer;
     dc_kakao       : Integer;
     dc_letsorder   : Integer;
     dc_tot         : Integer;   //할인합계
     amt_sale       : Integer;   //매출합계
     amt_tax        : Integer;
     cnt_customer   : Integer;   //영수증총건수
     amt_average    : Integer;   //객단가
     amt_banpum     : Integer;
     cnt_void       : Integer;
     amt_void       : Integer;   //VOID금액
     amt_lack       : Integer;   //과부족금액
     amt_cashrcp    : Integer;   //현금영수증
     cnt_cashier    : Integer;   //계산원수
     _Check         : Integer;
     _50000         : Integer;
     _10000         : Integer;
     _5000          : Integer;
     _1000          : Integer;
     _500           : Integer;
     _100           : Integer;
     _50            : Integer;
     _10            : Integer;
     amt_input      : Integer;
     amt_present    : Integer;
     rcp_begin      : String[4];
     rcp_end        : String[4];
     order_table    : String;
  end;

  {주방프린터}
  TKitchenPrinter = record
     Code           : String[3];
     Name           : String[30];  //주방명
     Floor          : String;      //주방층
     PrintFloor     : String;
     IP             : String[15];
     EthernetIP     : String[15];
     Device         : Integer;     //프린터기종
     Port           : String;   //출력포트
     BaudRate       : Integer;     //속도(1:9600, 2:19200, 3:38400, 56000);
     GroupSource    : Array[1..100] of String;      //그룹출력할 내용(원)
     Source         : String;      //출력할 내용(원)
     Data           : String;      //출력할 내용(명령어컨버젼된거)
     Cancel         : String;      //취소메뉴
     IsFirst        : Boolean;     //첫주문만 출력여부
     Corner         : String;      //코너코드
     OrderNo        : Integer;     //푸드코트일때 주문번호
     IsKDS          : Boolean;     //주방모니터 사용여부
     Menu           : String;      //메뉴정보(메뉴명|수량|단가) 주방모니터에 사용
     Count          : Integer;     //출력매수
     Link           : Boolean;     //영수증을 같이 사용하는 주방인지 여부
     LinkPOS        : String;      //연결포스
     Col            : Integer;     //칼럭수 0:42,1:48
     TopMargin      : Integer;
     BottomMargin   : Integer;
     LetsOrderOnly  : Boolean;     //렛츠오더 주문만 출력 주방
     MenuList       : TStringList;
  end;

  TFloor = record
     Code        : String;       //층코드
     Name        : String;       //층명
     NumberSize  : Integer;      //테이블 Number Font 크기
     CaptionSize : Integer;      //테이블 Caption Font 크기
     AmountSize  : Integer;      //테이블 Amount Font 크기
     BottomSize  : Integer;      //테이블 Buttom Font 크기
     TableNumberSize :Integer; //테이블 미주문시 테이블번호크기
     Corner      : String;
     Color       : String;
     BorderColor : String;
     FontColor   : String;
     MenuCount   : Integer;
     BottomFontColor : String;
     isWaitFloor : Boolean;
     BackGroundColor :TColor;
  end;

  TItemMenu = record
    Code      : String;
    Name      : String;
    Price     : Integer;
    Qty       : Integer;
    PrintMenuName :String;
  end;

  TDeliveryTel = record
    Status    : String;   //상태(0:신규, 1:기존고객, N:미주문, O:주문, D:배달, A:계산)
    TelNo     : String;   //전화번호
    OrderNo   : String;   //배달중일때 배달번호(12자리)
    OrderTime : String;   //배달중일때 주문시간
    GoTime    : String;   //배달중일때 배달시간
    Cust      : String;   //고객명(신규고객일때는 신규고객)
    Addr1     : String;   //배달주소
    Addr2     : String;   //배달주소2
  end;

  TDeliveryCompany = record
    Handle     :THandle;
    WindowName :String;
    Caption    :String;
    Image      :Integer;
    Exists     :Boolean;
  end;

  TDeliverySplit = record
    BaeminTitle  : Array of String;
    CoupangTitle  : Array of String;
    YogiyoTitle  : Array of String;
    BaeminTotAmt  : Array of String;
    CoupangTotAmt : Array of String;
    YogiyoTotAmt  : Array of String;
    BaeminDeliveryNo  : Array of String;
    CoupangDeliveryNo : Array of String;
    YogiyoDeliveryNo  : Array of String;
  end;

  TDeliveryLinkPrinter = record
    InComPort  :Integer;        //입력포트
    OutComPort :String;        //아웃포트
    Collection :String;        //Y or N
  end;

  TCorner = record
     Code       :String;       //코드
     Name       :String;       //코너명
     BizNo      :String;       //사업자번호
     Boss       :String;       //대표자
     RowIndex   :Integer;
     OrderData  :String;       //주문서출력
     RcpData    :String;
     Addr       :String;       //주소
     TelNo      :String;       //전화번호
     DsTax      :Integer;      //0 면세, 1 과세
     VanTID     :String;       //밴터미널아이디
     VanSerial  :String;       //밴시리얼번호
     SaleAmt    :Integer;
     NetAmt     :Integer;
     TaxAmt     :Integer;
     VanTax     :Integer;
     OrderNo    :Integer;
  end;

  TDutchPay = record
    nm_menu     :String;
    qty_order   :Integer;
    pr_order    :Integer;
    amt_order   :Integer;
    cd_menu     :String;
    seq         :Integer;
    ds_menu_type:String;
  end;

  TCourseOrderMenu = record
    Step        : Integer;
    MenuName    : String;
    MenuCode    : String;
    PrintMenuName :String;
    KitchenCode : String;
    OrderQty    : Integer;
    OrderPrice  : Integer;
  end;
  PCourseOrderMenu = ^TCourseOrderMenu;

  TLanguage = record
    Korean   : String;    //일본오
    English  : String;    //영어
    China    : String;    //중국(간체)
    Japanese : String;    //일본
    Vitenam  : String;    //베트남
    Thai     : String;    //태국어
    Indo     : String;    //인도어
    French   : String;    //프랑스어
    German   : String;    //독일어
  end;


  {어플리케이션 공통 모듈 클래스 생성}
  TCommon = class
    {어플리케이션 환경정보}
    ProgramTitle  : String;
    ProgramURL    : String;
    AppPath       : String;                    //어플리케이션 실행 디렉터리
    IniFile       : TIniFile;                  //환경정보 저장 파일
    Registry      : TRegistry;                 //레지스트리 설정
    OpenDate      : String;                    //개점일자
    WorkDate      : String;                    //작업일자
    LastCloseDate : String;                    //최종마감일자
    isSupportLicense: Boolean;                 //영업지원용 여부
    IsDebugMode   : Boolean;
    LanguageData  : TList;

    IsAction      : Boolean;                   //중복처리 방지를 위해...
    IsCashierMgm  : Boolean;                   //캐셔마감여부
    WaitThread    : TWaitThread;
    LetsOrderThread  : TLetsOrderThread;
    TmrDemonCheck : TTimer;
    SmartAgentTimer :TTimer;
    DBVersion     : String;
    IsDBServer    : Boolean;
    RestDBURL     : String;

    {공통 정보 저장 레코드}
    Member        : TMember;                   //현재 처리중인 회원 정보
    PreSent       : TPreSent;                  //카드/현금 입금액 정보
    PreSent_Temp  : TPreSent;                  //조회한 영수증 출력시 Present 잠시 보관
    Table         : TTable;                    //테이블정보
    KioskTable    : TTable;
    TableMode     : TTableMode;                //테이블모드
    Menu          : TMenu;                     //현재 처리중인 메뉴 정보
    TempMenu      : TMenu;
    Card          : TCard;                     //카드 승인내역 임시 보관
    CashRcp       : TCashRcp;                  //현금영수증정보
    KioskCash     : TKioskCash;                //키오스크 현금모듈
    UPlus         : TUPlus;
    Magam         : TMagam;                    //마감정보
    Config        : TConfig;                   //포스환경정보
    MsgKind       : TMsgKind;
    ICCard        : TPosCard;
    DetectData    : String;
    isReaderYN    : Boolean;                   //N이면 프로그램을 재시작해야함
    MenuImageCollection :TcxImageCollection;
    MenuInfoImageCollection :TcxImageCollection;

    {인터페이스    클래스, 레코드}
    Device            : TDevice;    //주변기기 인터페이스 정의
    PosType           : TPosType;
    WorkKind          : TWorkKind;
    OrderKind         : TOrderKind;
    WorkState         : TWorkState;
    PrintState        : TPrintState;
    SetPrintMode      : TPrintMode;     //설정출력모드
    RealPrintMode     : TPrintMode;     //실제출력모드
    PrintBuffer       : TStringList;                       //영수증 출력할 내용 임시정
    BackupPrintBuffer : TStringList;
    SetBillPrintMode  : Boolean;
    DllHandle         : THandle;
    ResStream         : TResourceStream;
    KitchenPrinter    : Array of TKitchenPrinter;          //주방프린터
    BefKitchenPrinter : Array of TKitchenPrinter;          //직전주방출력 내역
    Corner            : Array of TCorner;
    CustomerPrinter   : String;
    CustomerCancel    : String;       //주문취소내역(고객주문서)
    CustomerPrintLast : Boolean;      //최종 고객주문서 출력여부(고객주문서 하단문구와 첫장만 출력시 사용)
    OrderAmt          : Integer;
    OrderVatAmt       : Integer;
    OrderDutyAmt      : Integer;
    OrderTipAmt       : Integer;
    OrderDutyFreeAmt  : Integer;
    PrinterInData     : String;
    WhyOrdercancel    : String;       //주문취소사유
    OrderRePrint      : Boolean;      //주문서재인쇄
    IsAvailable       : Boolean;      //사용가능한 상태인지
    CashBookCard      : Boolean;      //출납카드여부
    SplitPrintMode    : TSplitPrintMode;      //tpmOnePage:영수증에 신용카드전표 같이 출력 tpmSplit:영수증과 신용카드전표 별도 출력
    CardPrintMode     : TCardPrintMode;
    MenuPrintMode     : Boolean;      //영수증에 메뉴출력여부
    PrimaryMonitors   : Integer;      //Primary모니터인덱스
    ServerRcvData     : String;
    AutoCloseTime     : String;
    LastOrderTableButton :TPosButton;
    LastOrderTableNo  : Integer;
    LastOrderFloor    : String;
    LastOrderTime     : TDateTime;
    SaleDateTime      : TDateTime;
    ComeDateTime      : TDateTime;
    SQLBuffer         : String;
    LetsOrderPrint    : Boolean;      //렛츠오더 출력여부(레츠오더 출력일때는 출력오류 메세지를 보이지 않는다)
    isLanguageTrans   : Boolean;      //1개월 최대번역을 초과했을때
    isKFTCDetect      : Boolean;
    KFTCDetectData    : String;       //감지이벤트코드

    IsMainFormLoad    : Boolean;

    IsWindow7         : Boolean;
    IsWorking         : Boolean;      //현재 테이블내역을 처리중인지여부
    BanReceipt        : String;
    OrgReceiptNo      : String;       //취소, 반품 시 원영수증번호
    OrgReceiptCoupon  : Boolean;      //취소시 쿠폰발행영수증여부
    CidData           : TStringList;
    CidPhoneData      : TStringList;

    DeliveryTel       : Array[1..4] of TDeliveryTel;
    DeliveryBottomList : TStringList;
    DeliverySplit     : TDeliverySplit;

    DamdangCode,
    DamdangName       : String;
    IsBusinessVersion : Boolean;
    isVoidRePrint     : Boolean; //Void(취소중인지여부)
    WaitPrint1,
    WaitPrint2,
    WaitPrint3        : String;

    LabelPrintData    :TStringList;                          //라벨 출력용
    GroupColor        :Array of TColor;
    TableMenuColor    :String;
    KeyPadType        :Integer;   //키패드타입(0:기본, 1:소숫점)
    KioskConfig       :Array[1..17] of Integer;
    CourseOrderMenu   :TList;

    KioskWaitList     :TStringList;
    KioskWaitImage    :String;  //P:Png, A:AVI
    isBFKiosk         :Boolean;   //배리어프리 키오스크여부
    isBFChoose        :Boolean;   //장애인 비장애인 선택여부 false일때는 선택해야하는 상태로 변경
    KioskVoice        :Boolean;

    //Cat단말기연동 + 포스1대 + 주방프린터와 영수증프린터 같이 사용여부
    isReceiptToKitehcn : Boolean;

    {DB관련}
    Query  : TUniQuery;
    UniSQL : TUniSQL;

    {임시저장 스트링그리드}
    Summary_sGrd      :TStringGrid;                        //영수증출력 및 저장시 사용
    Temp_sGrd         :TStringGrid;                        //조회한 내역 출력시 Summary_sGrd 잠시보관
    Group_sGrd        :TStringGrid;
    Card_SGrd         :TStringGrid;                        //카드정보
    Hold_sGrd         :TStringGrid;                        //보류내역 저장
    Cash_sGrd         :TStringGrid;                        //현금영수증내역 저장
    Cancel_sGrd       :TStringGrid;                        //주문취소내역 저장
    DuthPay_sGrd      :TStringGrid;                        //더치페이그리드
    UPlus_sGrd        :TStringGrid;                        //UPlus할인 그리드

    {소트할 배열}
    SortData      :Array of Array of String;
    SortCount     :Integer;

    DeleteData    :Array[1..20] of String;

    {듀얼 이미지/동영상화일}
    DualData  : TStringList;
    DualIndex : Integer;

    SaleManaLink : Array[0..9] of Integer;

    AgeData :TStringList;
    FloorData : Array of TFloor;

    DeliveryCompany: array[0..2] of TDeliveryCompany;
    DeliveryLinkPrinter :array[0..3] of TDeliveryLinkPrinter;

    BookingTableNo :TStringList;

    {보류정보}
    RestoreNo,
    RestoreMem   : String;

    DBConnectError:Boolean;
    MapCount : Integer;
    CIDReplaceList :TStringList;
    TRErrorCount :Integer;
    isFallBack :Boolean;
    isCashRecieptCard :Boolean;
    isVanFirst :Boolean;
    Option_379  :Char;

  public
    {클래스 선언자}
    constructor Create;
    destructor Destroy; override;

    {데이터베이스 제어}
    procedure BeginTran;                             //포스트랜잭션 시작
    procedure RollbackTran;                          //포스트랜잭션 롤백 처리
    procedure CommitTran;                            //포스트랜잭션 커밋 처리

    {등록되어있는 포스인지 체크}
    function  PosNo_Check:Boolean;

    function  GetCardSeq:String;
    procedure SetCardSeq(AValue:String);

    {환경정보 제어}
    procedure GetIni;                                     //INI 파일 내용 전부 가져오기
    procedure SetIni;                                     //INI 파일 내용 전부 저장하가
    procedure SortExecute;                                //소트실행

    {공용정보 제어}
    function  SetDayOpen(aOpenDate:String):Boolean;                          //개점저장
    function  GetReceiptNo:Boolean;                       //영수증번호 채번
    function  GetOrderNo(aMode:Integer=0):Integer;        //주문번호 채번 (0:출력할 내역이 있을때만, 1:무조건);
    procedure SelectStoreInfo;           //매장정보
    procedure SelectMemberInfo(aMemberNo,aCardNo,aTelNo:String);          //회원정보조회
    procedure CardInfoLoad(aRow:Integer);                 //카드승인정보 그리드에서 레크드로 이동
    procedure CardInfoSave(aType:Integer=0);              //카드승인승인내역 그리드에 저장 (aType 1: 출납부, 2:선결제);
    function  ShowCardForm(aEasyPay,aApproval:Boolean;aAmount:Integer=0):Boolean;            //신용카드폼 호출
    procedure CashRcpInfoLoad(pRow:Integer);              //현금영수증승인정보 그리드에서 레크드로 이동
    procedure CashRcpInfoSave;                            //현금영수증승인승인내역 그리드에 저장

    function  UPlusInfoLoad(aGugun:Boolean):Boolean;    //UPlus할인 승인정보 그리드에서 레크드로 이동
    procedure UPlusInfoSave;                            //UPlus할인 승인내역 그리드에 저장
    function  ShowCashRcpForm(aApproval:Boolean;aAmount:Integer=0):Boolean;         //현금영수증폼 호출
    function  ShowUPlusForm(aGubun:Boolean):Boolean;
    procedure ShowCustomerInfo;                           //고객정보를 받는다
    function  ShowMemberForm(MsrData:String=''):Boolean;
    function  ShowMemberAddForm(aTelNo:String=''):Boolean;
    function  ShowChooseForm(aMode:String;aMenuCode:String; var aCode, aName:String; aSQL:String=''):Boolean;       //T-테이블, D:배달, W:출퇴근
    function  ShowCashForm:Boolean;
    function  ShowCheckForm:Boolean;
    function  ShowMenuItemForm:Boolean;
    procedure TaxCalculation(aGubun:String='');                                  //정산전 부가세 및 각종 합계계산
    procedure PointCalculation(aGubun:String; aSaleAmt,aPointExistAmt:Integer);                 //포인트계산
    function  SaleDataSave(aGubun:String; var ErrMsg:String):Boolean;        //매출데이터 저장
    function  CardDataSave(aWorkDate,aGubun,aRcpNo:String; aIndex :Integer):Boolean;   //C:카드, A:출납
    function  AHeadCardDataSave:Boolean;   //선결제 카드저장
    function  AHeadCashDataSave:Boolean;   //선결제 현금영수증저장
    function  SubMenuDataSave(aMenuCode, aDsSale:String; aQty, aPrice, aQtyUnit:Integer; aDsMenu, aDsStock:String; aSeq,aSubSeq:Integer):String;
    procedure ClearKitchenData;                           //주방프린터내용 클리어
    procedure ClearCornerData;                            //코너프린터내용 클리어
    function  GetKitchenIndex(aKind,aKitchen:Integer;aValue:String):Integer;
    procedure OrderCancelGridSave(ARow,AQty:Integer;aPrint,aService:String);     //주문취소내역 저장그리드에 저장
    procedure Allot_Dc(aGrid:TStringGrid);                //할인금액 배분
    function  SetReceipt(aDate,aPosNo,aRcpNo:String):Boolean;     //영수증내역을 불러온다
    procedure SetCardSale(aValue:String; aType:Integer=0);
    procedure SetCashSale(aValue:String; aType:Integer=0);
    function  CheckAcctPos(aType:Integer=0):Boolean;
    function  GetQtyReplace(aMenuType, aQty:String):String;  //중량형 메뉴의 단위구하기
    procedure GetAllCustomerOrder(aType:Integer=0);
    procedure LogoCreate(aForm:TControl; aToolBar:Integer=1); //0:사용안함, 1:상단, 2:상하단
    procedure SetLanguage(aForm:TControl);
    procedure LogoClick(Sender:TObject);
    procedure DbConnect;
    function  GetCustomerAgeCount(aValue:String):Integer;
    procedure SetCustomerAgeCount(aValue:String);
    procedure SetAgeInfo(aValue:String);
    function  GetAgePerson(aTable:TTable):String;
    function  DemonCheck(aHost,aData:String; aPort:Integer=7006):Boolean;
    function  TRSendMessage(aValue:String='UPLOAD'):Boolean;
    procedure OpenDataToGrid(ADataset:TDataset; AGrid:TcxGridTableView); OverLoad;// 조회한 데이터를 그리드에 표시
    procedure OpenDataToGrid(ADataset:TDataset; AGrid:TStringGrid);    OverLoad;// 조회한 데이터를 그리드에 표시
    procedure WriteLog(aJob,aLog:String;aSend:Boolean=false);
    procedure TaxfreeLogSave(aLog:String);
    procedure TmrDemonCheckTimer(Sender: TObject);
    procedure SmartAgentTimerTimer(Sender: TObject);
    procedure DeleteSignFile;
    function  GetCardLog(aValue:Boolean=True):String;                            //권한있는 사용자 체크
    function  CheckAuthority(aPos:Integer):Boolean;
    function  CheckTable(aCheck:String; aTableNo:Integer):Boolean;              //U:사용중체크, M:선결제체크, A:둘다(사용중이 우선)
    procedure DeleteCidData(aValue:String);
    procedure AddCidData(aValue:String; aDeliveryNo:String='');
    function  GetAddMenuAmt(TableNo:Integer):Integer;
    procedure ClearDeliveryTel(aLine:Integer=0);
    procedure GetDeliveryTelInfo(aTelNo:String);
    function  GetCorner:Integer;                                                //금액이 존재하는 업장을 찾는다
    function  SetCornerAmt:Integer;
    function  GetCamCapture:Boolean;
    function  SetSystemTimeSync:Boolean;
    procedure Shutdown;
    procedure SetCornerCardInfo(aCorner:String);
    function  GetCornerIndex(aCorner:String;aTID:String=''):Integer;
    procedure KitchenDataCopy(aKind:Integer=0);
    function  GetPluNo:String;
    procedure SaveKDSData(aTakeOut:Boolean);
    procedure SetCustomerCount(aCount:Integer);
    function  SetIniFile(aSection, aIdent, aData: string): Boolean; overload;                               // Ini File 값 저장
    function  SetIniFile(aSection, aIdent: string; aData: Integer): Boolean; overload;                      // Ini File 값 저장
    function  SetIniFile(aSection, aIdent: string; aData: Boolean): Boolean; overload;                      // Ini File 값 저장
    function  GetIniFile(aSection, aIdent, aDefault: string): string; overload;                             // Ini File 값 읽기
    function  GetIniFile(aSection, aIdent: string; aDefault: Integer): Integer; overload;                   // Ini File 값 읽기
    function  GetIniFile(aSection, aIdent: string; aDefault: Boolean): Boolean; overload;                   // Ini File 값 읽기
    function  GetCardNoFormat(aValue:String;aSave:Boolean=false):String;
    function  RunningProgram(aExeFileName:String):Boolean;
    function  GetProgramHandle(aExeFileName:String):Integer;
    procedure GroupGridTable(aGridTableView:TcxGridTableView; aKey, aTextIndex:Integer; aText:String; aCol:array of Integer);
    function  SaveReadyAmt(aCashAmt:Currency;aCommit:Boolean=true):Boolean;
    function  GetMemberCode:String;
    function  SaveMemberAdd(aNew:Boolean; aMemberNo, aName, aDsMember, aGender, aHomeTel, aMobileTel, aCardNo, aPost, aAddr1, aAddr2, aCashRcpNo,
                            aCourse, aLocal, aLunar, aTrust, aNews, aBirthDay, aDamdangCode, aRemark, aEtcTel1, aEtcTel2:String):Boolean;

    procedure SetPNGImage(aButton:TObject; aFileName:String);
    function  GetProcess(aFileName:String):Cardinal;
    function  isMemberCardNo(aCardNo:String):Boolean;
    function  SMSSendMessage(aMessage, aRcvTel:String; aErrTitle: String=''):Boolean;
    function  KaKaoSendMessage(aTemplate:String; aMessage: array of Variant; aRcvTel:String;aErrTitle:String=''):Boolean;
    function  PosAutoCloseOpen:Boolean;
    function  KioskLogFormat(aData:AnsiString):String;
    procedure KioskTouchBeep(aCode:String);
    function  KioskAutoOpen:Boolean;
    procedure KillTask(ExeFileName: string);
    function  GetTaskHandle(ExeFileName: string):THandle;
    function  SavePrintData(aPrintCode, aPrintData, aDamdang, aPosNo, aOrderTime:String; aPerson, aOrderNo:Integer):Boolean;
    function  isWindows64 : Boolean;
    function  PGCardCancel(aRcpNo,aTID :String; aCardAmt :Integer;aPart:Boolean):Boolean;
    procedure BellCall(aCallNo:Integer;aKitchenName:String);
    procedure SetButtonColor(aObject:TObject; aFixed:Boolean=false);
    procedure SetKioskButton(aObject:TObject;aImageFile:String='');
    function  GetImageCollectionIndex(aMenuCode:String):Integer;
    function  GetInfoImageCollectionIndex(aMenuCode:String):Integer;
    function  FileDownLoad(aFileName, aPath: String): Boolean;
    function  SendTabletMessage(aMsgType:String; aTableNo:Integer; aMsg:String):Boolean;
    function  LetsOrderAuth(aHeadStore:String):String;
    procedure LogFilesDelete(aPath:String);
    procedure TextToSpeech(aText:String);

    {듀얼}
    procedure ShowNormalDualScreen;
    procedure ShowSaleDualScreen;
//    procedure HideDualScreen;
    procedure FreeDualScreen;

    {이벤트}
    procedure OnClick(Sender:TObject);                    //Edit box 클릭시 SelectAll
    procedure MaskEditOnEnter(Sender:TObject);            //MaskEdit OnEnter 이벤트 처리
    procedure CurrencyEdit(Sender:TObject);               //CurrencyEdit Exit 시 DisplayFormat := #,##0

    {보류 데이터 제어}
    function  SaveReserveData:Boolean;                    //데이터 보류
    procedure RestoreReserveData;                         //데이터 복구

    {팝업 화면 호출}
    procedure  ErrBox(aMsg:String);
    procedure  MsgBox(aMsg:String;aTimeOut:Integer=5);
    function   AskBox(aMsg:String;aTimeOut:Integer=0):Boolean;

    procedure  ShowWaitForm(aMsg:String='';aButton:Boolean=false);                               //진행 대기 메시지 팝업 화면 보이기
    procedure  HideWaitForm;                               //진행 대기 메시지 팝업 화면 숨기기
    procedure  PadWaitForm(aMsg,aSendMsg:String);

    procedure  ShowLetsOrderServiceForm(aMsg:String='');                               //진행 대기 메시지 팝업 화면 보이기
    procedure  HideLetsOrderServiceForm;                               //진행 대기 메시지 팝업 화면 숨기기

    function   ShowNumberForm(Msg:String;MaxLength:Integer;
                              MaxValue:Integer=0;InitValue:String=''):String; //NumPad Form 생성
    {StringGrid 제어}
    procedure GridDrawCell(Sender: TObject; Col, Row: Integer; //각 입력화면 그리드용 디자인 적용
                           Rect: TRect; State: TGridDrawState);
    procedure Grid_Align(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
    procedure Grid_DisplayFormat(Sender: TObject; ACol, ARow: Integer; Rect: TRect; aType:String='I');
    procedure RowSelect(Grid:TStringGrid; ARow:Integer);
    procedure RowPrev(Grid:TStringGrid);                     //그리드 로우 위로
    procedure RowNext(Grid:TStringGrid);                     //그리드 로우 아래로
    procedure RowFirst(Grid:TStringGrid);                    //그리드 로우 처음으로
    procedure RowEnd(Grid:TStringGrid);                      //그리드 로우 마지막으로
    procedure AddRow(var Grid:TStringGrid);                  //그리드 로우추가
    procedure DeleteRow(Grid:TStringGrid;Row:Integer);       //그리드로우삭제
    procedure ClearGrid(Grid:TStringGrid);                   //그리드클리어
    procedure GridRefresh(Grid:TStringGrid);                 //그리드새로고침
    procedure GridToGrid(FromGrid,ToGrid:TStringGrid;aAdd:Boolean=false);           //그리드데이터 이동

    function  GetNowDate:String;                             //현재일자 가져오기
    function  GetNowTime:String;                             //현재 시간 가져오기
    property  NowDate: String read GetNowDate;               //현재일자
    property  NowTime: String read GetNowTime;               //현재시간

    function  SetStr(S:String):String;                       //버튼에 Caption 잘라서 보이기

    { 웹서비스 관련 (2011.07.26 이승혁) }
    procedure WSSplit(const aValue: WideString; aSplitType: Integer; var aList: TStringList);
    function  WSReplace(const aValue: string): WideString;
    function  WSReplace2(const aValue: string): String;

   function  GetPaPago(aText:String):String;  //en, cha, jpn

   procedure  DoModalBegin(Sender: TObject);
   procedure  DoModalEnd(Sender: TObject);


   procedure  DoModalReset;

   procedure  DoModalClose;


end;

  procedure InitMemberRecord(var AValue: TMember);
  procedure InitTableRecord(var AValue: TTable);
  procedure InitMenuRecord(var AValue: TMenu);
  procedure InitPreSentRecord(var AValue: TPreSent);
  procedure InitCardRecord(var AValue: TCard);
  procedure InitCashRcpRecord(var AValue: TCashRcp);        //현금영수증초기화
  procedure InitUPlusRecord(var AValue: TUPlus);
  procedure InitMagamRecord(var AValue: TMagam);
  procedure InitKioskCashRecord(var aValue :TKioskCash);

var
  Common     : TCommon;
implementation
uses DBModule_U, GlobalFunc_U, NumPan_U,QuesMsg_U, Discount_U,
     Card_U, WaitMsg_U, LetsOrderService_U, CashRcp_U, Order_U, CustomerInfo_U,
     Member_U, MemberAdd_U, RcpChange_U, Main_U, CommonChoose_U,
     Cash_U, Course_U, OpenSet_U, Check_U, MenuItem_U, IdTCPConnection,
     UserCheck_U, DualOrder_U, Capture_U,
     DBAccess, DualOrder800_U, Delivery_U, DeliveryNew_U, KioskQuesMsg_U,
     KioskItem_U, PadWait_U, KioskItem2_U, UPlus_U, MultiCard_U,
     MultiCashRcp_U, LetsOrderCallList_U, BackGroundScreen, Table_U;
////////////////////////////////////////////////////////////////////////////////
// Name         : TWaitThread.Execute
// Type         : procedure
// Explanation  : 처리중 메세지 표시 쓰레드 생성자
////////////////////////////////////////////////////////////////////////////////
constructor TWaitThread.Create;
begin
   Execute;
   inherited Create(True);
end;

procedure TWaitThread.Execute;
begin
   FreeOnTerminate := True;
   Synchronize(ShowMsg);
end;

procedure TWaitThread.ShowMsg;
begin
   Application.CreateForm(TWaitMsg_F, WaitMsg_F);
   WaitMsg_F.Show;
end;

destructor TWaitThread.Destroy;
begin
   WaitMsg_F.Close;
   FreeAndNil(WaitMsg_F);
   Application.ProcessMessages;
end;

////////////////////////////////////////////////////////////////////////////////
// Name         : TLetsOrderThread.Execute
// Type         : procedure
// Explanation  : 처리중 메세지 표시 쓰레드 생성자
////////////////////////////////////////////////////////////////////////////////
constructor TLetsOrderThread.Create;
begin
   Execute;
   inherited Create(True);
end;

procedure TLetsOrderThread.Execute;
begin
   FreeOnTerminate := True;
   Synchronize(ShowMsg);
end;

procedure TLetsOrderThread.ShowMsg;
begin
   Application.CreateForm(TLetsOrderService_F, LetsOrderService_F);
   LetsOrderService_F.Show;
end;

destructor TLetsOrderThread.Destroy;
begin
   LetsOrderService_F.Close;
   FreeAndNil(LetsOrderService_F);
   Application.ProcessMessages;
end;



////////////////////////////////////////////////////////////////////////////////
// Name         : Create
// Type         : constructor
// Explanation  : 공통 모듈 클래스 생성자
// Parameter    :
// Return value :
// Example      :
////////////////////////////////////////////////////////////////////////////////
constructor TCommon.Create;
begin
  IsMultiThread := True;
  AppPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));;
  if AppPath = EmptyStr then
    AppPath := String(GetRegistry(HKEY_CURRENT_USER, regPath, 'Path'));

  if AppPath <> '' then
    SetRegistry(HKEY_CURRENT_USER, regPath, 'Path',AppPath);

  DllHandle := LoadLibrary(Pchar(AppPath+'dll\Sound.Dll'));
  {POS Db를 사용하는 작업용 쿼리 컴포넌트 생성}
  TRErrorCount := 0;
  {디바이스 인터페이스 클래스 생성}
  Device := TDevice.Create;

  ICCard := TPosCard.Create(Application);
  ICCard.LogPath := AppPath;

  CIDReplaceList := TStringList.Create;
  CIDReplaceList.Clear;

  Query  := TUniQuery.Create(Application);
  Query.Connection := DM.UniConnection;

  UniSQL    := TUniSQL.Create(Application);
  UniSQL.Connection := DM.UniConnection;

  SQLBuffer := '';

  LanguageData    := TList.Create;
  isLanguageTrans := true;

  {캐셔마감여부}
  IsCashierMgm := True;

  {매출정보요약 그리드}
  Summary_SGrd          := TStringGrid.Create(Application);
  Summary_SGrd.ColCount := GDM_COLCOUNT;
  Summary_SGrd.RowCount := 0;

  Temp_SGrd          := TStringGrid.Create(Application);
  Temp_SGrd.ColCount := GDM_COLCOUNT;
  Temp_SGrd.RowCount := 0;

  Group_SGrd          := TStringGrid.Create(Application);
  Group_SGrd.ColCount := GDM_COLCOUNT;
  Group_SGrd.RowCount := 0;

  //카드승인내역을 저장할 그리드
  Card_SGrd          := TStringGrid.Create(Application);
  Card_SGrd.ColCount := GDC_COLCOUNT;
  Card_SGrd.RowCount := 0;

  //현금영수증승인내역을 저장할 그리드
  Cash_SGrd          := TStringGrid.Create(Application);
  Cash_SGrd.ColCount := GDR_COLCOUNT;
  Cash_SGrd.RowCount := 0;

  //UPlus할인 승인내역을 저장할 그리드
  UPlus_SGrd          := TStringGrid.Create(Application);
  UPlus_SGrd.ColCount := GDK_COLCOUNT;
  UPlus_SGrd.RowCount := 0;


  {보류정보 그리드}
  Hold_SGrd          := TStringGrid.Create(Application);
  Hold_SGrd.ColCount := GDH_COLCOUNT;
  Hold_SGrd.RowCount := 0;

  {주문취소정보 그리드}
  Cancel_sGrd          := TStringGrid.Create(Application);
  Cancel_sGrd.ColCount := 10;
  Cancel_sGrd.RowCount := 0;

  {더치페이정보 그리드}
  DuthPay_sGrd          := TStringGrid.Create(Application);
  DuthPay_sGrd.ColCount := 13;
  DuthPay_sGrd.RowCount := 0;

  PrintBuffer       := TStringList.Create;
  BackupPrintBuffer := TStringList.Create;
  OrderRePrint      := False;

  {플래쉬와 JPG}
  DualData := TStringList.Create;

  BookingTableNo := TStringList.Create;

  {CID데이터를 저장할 스트링리스트}
  CidData := TStringList.Create;
  CidPhoneData := TStringList.Create;

  DeliveryBottomList := TStringList.Create;

  {연령대 데이터}
  AgeData := TStringList.Create;

  //여기서 생성한게 아래에서 안먹어서 할 수 없이 그때그때 생성함 이유는 모르겠다
//  LabelPrintData := TStringList.Create;

  KioskWaitList := TStringList.Create;
  DBConnectError := False;

  CashBookCard   := False;
  KFTCDetectData := '';
  DeliveryCompany[0].WindowName := 'vFloatingIconDlg';
  DeliveryCompany[0].Caption    := '배달의민족';
  DeliveryCompany[0].Exists     := false;
  DeliveryCompany[0].Image      := 0;
  DeliveryCompany[1].WindowName := 'coupang POS';
  DeliveryCompany[1].Caption    := '쿠팡이츠';
  DeliveryCompany[1].Exists     := false;
  DeliveryCompany[1].Image      := 1;
  DeliveryCompany[2].WindowName := 'BadgeWinodw';
  DeliveryCompany[2].Caption    := '요기요';
  DeliveryCompany[2].Exists     := false;
  DeliveryCompany[2].Image      := 2;


  LetsOrderService_F := TLetsOrderService_F.Create(Application);
  LetsOrderService_F.Hide;

  TmrDemonCheck := TTimer.Create(Application);
  TmrDemonCheck.Interval := 60000;
  TmrDemonCheck.OnTimer  := TmrDemonCheckTimer;
  TmrDemonCheck.Enabled  := false;

  SmartAgentTimer := TTimer.Create(Application);
  SmartAgentTimer.Interval := 3000;
  SmartAgentTimer.OnTimer  := SmartAgentTimerTimer;
  SmartAgentTimer.Enabled  := false;

  IsBusinessVersion := False;

  LastOrderTableButton := TPosButton.Create(Application);
  CourseOrderMenu := TList.Create;

  MenuImageCollection := TcxImageCollection.Create(Application);
  MenuInfoImageCollection := TcxImageCollection.Create(Application);

  DualIndex  := -1;
  KeyPadType  := 0;

  MapCount    := 0;
  isReaderYN  := True;
  isVoidRePrint := false;
  isVanFirst    := false;
  LetsOrderPrint := false;

  Config.PluClassFont := TFont.Create;
  Config.PluMenuFont  := TFont.Create;
  Config.PluPriceFont := TFont.Create;

  WaitMsg_F := TWaitMsg_F.Create(Application);
  WaitMsg_F.Hide;

end;

////////////////////////////////////////////////////////////////////////////////
// Name         : Destroy
// Type         : destructor
// Explanation  : 공통 모듈 클래스 파괴자
// Parameter    :
// Return value :
// Example      :
////////////////////////////////////////////////////////////////////////////////
destructor TCommon.Destroy;
var I :Integer;
begin
  FreeAndNil(Config.StoreMobile);
  FreeAndNil(Config.KioskKaKaoTel);

  for I := 0 to High(KitchenPrinter) do
    FreeAndNil(KitchenPrinter[I].MenuList);

  for I := 0 to High(BefKitchenPrinter) do
    FreeAndNil(BefKitchenPrinter[I].MenuList);

  FreeAndNil(Query);
  FreeAndNil(UniSQL);

  FreeAndNil(WaitMsg_F);
  FreeAndNil(LetsOrderService_F);

  FreeAndNil(CIDReplaceList);
  FreeAndNil(LanguageData);

  FreeAndNil(Temp_SGrd);
  FreeAndNil(Group_SGrd);
  FreeAndNil(Hold_SGrd);
  FreeAndNil(Cancel_sGrd);
  FreeAndNil(DuthPay_sGrd);

  FreeAndNil(PrintBuffer);
  FreeAndNil(BackupPrintBuffer);
  FreeAndNil(BookingTableNo);
  FreeAndNil(DeliveryBottomList);
  FreeAndNil(KioskWaitList);

  FreeAndNil(TmrDemonCheck);
  FreeAndNil(SmartAgentTimer);
  FreeAndNil(LastOrderTableButton);

  FreeAndNil(Config.PluClassFont);
  FreeAndNil(Config.PluMenuFont);
  FreeAndNil(Config.PluPriceFont);

  FreeAndNil(NumPan_F);
  FreeAndNil(Member_F);
  Card_SGrd.Free;
  Cash_SGrd.Free;
  UPlus_SGrd.Free;
  Summary_sGrd.Free;
  if Assigned(Common.ICCard) then
    ICCard.Free;
  DualData.Free;
  CidData.Free;
  CidPhoneData.Free;
  AgeData.Free;
  CourseOrderMenu.Free;
  FreeAndNil(CustomerInfo_F);
  if Assigned(Course_F) then FreeAndNil(Course_F);
  if Assigned(OpenSet_F) then FreeAndNil(OpenSet_F);
  if Assigned(UserCheck_F) then FreeAndNil(UserCheck_F);
  if Common.PosType <> ptOnlyOrder then
  begin
    FreeAndNil(CashRcp_F);
    FreeAndNil(RcpChange_F);
    FreeAndNil(Cash_F);
    FreeAndNil(Check_F);
  end;
  if Assigned(MenuItem_F)  then FreeAndNil(MenuItem_F);
  if Assigned(KioskItem_F) then FreeAndNil(KioskItem_F);
  if Assigned(KioskItem2_F) then FreeAndNil(KioskItem2_F);
  if Assigned(UPlus_F) then FreeAndNil(UPlus_F);
  if Assigned(Member_F) then FreeAndNil(Member_F);
  FreeLibrary(DllHandle);
  MenuImageCollection.Free;
  MenuInfoImageCollection.Free;
  Device.Free;
end;


//**************************************************************************//
//                           컴퍼넌트 동적생성
//**************************************************************************//


//**************************************************************************//
//                       주방프린터내용 클리어
//**************************************************************************//
procedure TCommon.ClearKitchenData;
var I,II :Integer;
begin
  For I := 0 to High(KitchenPrinter) do
  begin
    For II := 1 to 100 do
    KitchenPrinter[I].GroupSource[II] := EmptyStr;
    KitchenPrinter[I].Menu        := EmptyStr;
    KitchenPrinter[I].Source      := EmptyStr;
    KitchenPrinter[I].Data        := EmptyStr;
    KitchenPrinter[I].Cancel      := EmptyStr;
    KitchenPrinter[I].Corner      := EmptyStr;
    KitchenPrinter[I].OrderNo     := 0;
    KitchenPrinter[I].MenuList.Clear;
  end;

  CustomerPrinter   := '';
  CustomerPrintLast := False;
  OrderAmt          := 0;
  OrderVatAmt       := 0;
  OrderDutyAmt      := 0;
  OrderDutyFreeAmt  := 0;
  OrderTipAmt       := 0;
end;

procedure TCommon.ClearCornerData;
var I :Integer;
begin
  For I := 0 to High(Corner) do
  begin
    Corner[I].OrderData := EmptyStr;
    Corner[I].RcpData   := EmptyStr;
    Corner[I].SaleAmt   := 0;
    Corner[I].NetAmt    := 0;
    Corner[I].TaxAmt    := 0;
  end;
end;

//**************************************************************************//
// 주방프린터 위치 찾기
// AKind : 0-PrintCode, 1-PrintIP
// AKitchen  : 주방출력 옵션(0:같은층 주방, 1:체크한 모든주방, 2:주방에 설정한 층)
//**************************************************************************//
function TCommon.GetKitchenIndex(AKind,AKitchen:Integer;AValue:String):Integer;
var I :Integer;
begin
  Result := -1;
  For I := High(Common.KitchenPrinter) downto 0 do
  begin
    if (GetOption(26) = '0') or (AKitchen = 1)  then
    begin
      case AKind of
        0 :
          begin
            if Common.KitchenPrinter[I].Code = AValue then
            begin
              Result := I;
              Break;
            end;
          end;
        1 :
          begin
            if Common.KitchenPrinter[I].IP = AValue then
            begin
              Result := I;
              Break;
            end;
          end;
      end;
    end
    //테이블과 층이 주방프린터만 출력합니다
    else if (GetOption(26) = '1') and (AKitchen <> 1) then
    begin
      case AKitchen of
        0 : //같은층 주방
        begin
          case AKind of
            0 :
              begin
                if (KitchenPrinter[I].Code = AValue) and (KitchenPrinter[I].Floor = Table.Floor) then
                begin
                  Result := I;
                  Break;
                end;
              end;
            1 :
              begin
                if (KitchenPrinter[I].IP = AValue) and (KitchenPrinter[I].Floor = Table.Floor) then
                begin
                  Result := I;
                  Break;
                end;
              end;
          end;
        end;
        2 : //주방에 설정한 층만 출력
        begin
          case AKind of
            0 :
              begin
                if (KitchenPrinter[I].Code = AValue) and (POS(Table.Floor,KitchenPrinter[I].PrintFloor) > 0) then
                begin
                  Result := I;
                  Break;
                end;
              end;
            1 :
              begin
                if (KitchenPrinter[I].IP = AValue) and (POS(Table.Floor,KitchenPrinter[I].PrintFloor) > 0) then
                begin
                  Result := I;
                  Break;
                end;
              end;
          end;
        end;
      end;
    end;
  end;
end;

//**************************************************************************//
//                       주문취소내역 임시그리드에 저장
//**************************************************************************//
procedure TCommon.OrderCancelGridSave(aRow,aQty:Integer;aPrint,aService:String);
begin
  if Order_F.Main_sGrd.Cells[GDM_CD_MENU,   ARow]  = '' then Exit;
  if Order_F.Main_sGrd.Cells[GDM_CD_MENU1,  ARow] <> '' then Exit;
  if Order_F.Main_sGrd.Cells[GDM_CD_MENU,   ARow] = Config.OverTimeMenu then Exit;

  with Cancel_sGrd do
  begin
    if Cells[0,0] <> '' then RowCount := RowCount + 1;
    Cells[0, RowCount-1] := Order_F.Main_sGrd.Cells[GDM_CD_MENU,   ARow];
    Cells[1, RowCount-1] := IntToStr( AQty );
    Cells[2, RowCount-1] := WhyOrdercancel;
    if (Order_F.Main_sGrd.Cells[GDM_YN_ORDER,  ARow] = 'Y') then
      cells[3, RowCount-1] := Order_F.Main_sGrd.Cells[GDM_DT_ORDER,  ARow]
    else
      cells[3, RowCount-1] := '';
    cells[4, RowCount-1] := Order_F.Main_sGrd.Cells[GDM_YN_ORDER,  ARow];
    cells[5, RowCount-1] := Order_F.Main_sGrd.Cells[GDM_SEQ,       ARow];
    cells[6, RowCount-1] := Order_F.Main_sGrd.Cells[GDM_NO_STEP,   ARow];
    cells[7, RowCount-1] := Order_F.Main_sGrd.Cells[GDM_CD_MENU1,  ARow];
    cells[8, RowCount-1] := Order_F.Main_sGrd.Cells[GDM_AMT,       ARow];
    cells[9, RowCount-1] := Order_F.Main_sGrd.Cells[GDM_NM_MENU,   ARow];
    cells[10, RowCount-1] := Order_F.Main_sGrd.Cells[GDM_ORDERTIME,   ARow];
    cells[11, RowCount-1] := aPrint;
    cells[GDM_SERVICE_CHG, RowCount-1] := aService;
  end;

  if aPrint = 'N' then Exit;
  with Order_F.Cancel_sGrd do
  begin
    if Order_F.Main_sGrd.Cells[GDM_YN_ORDER,  ARow] <> 'Y' then Exit;
    if Cells[0,0] <> '' then RowCount := RowCount + 1;

    if Common.PosType = ptOnlyOrder then
      Order_F.Main_sGrd.Height  := Order_F.Main_sGrd.Tag - Order_F.Cancel_sGrd.Height
    else
      Order_F.Main_sGrd.Height  := Order_F.Main_sGrd.Tag;

    Order_F.Cancel_sGrd.Visible      := True;
    Order_F.GroupTable_sGrd.Visible  := False;
    Order_F.Cancel_sGrd.Rows[RowCount-1].Assign(Order_F.Main_sGrd.Rows[aRow]);

    Order_F.Cancel_sGrd.Cells[GDM_VIEWQTY,  RowCount-1] := Common.GetQtyReplace(Order_F.Cancel_sGrd.Cells[GDM_DS_MENU,  RowCount-1], FtoS(AQty*-1));
    Order_F.Cancel_sGrd.Cells[GDM_YN_ORDER, RowCount-1] := 'C';
    Order_F.Cancel_sGrd.Cells[GDM_NO,       RowCount-1] := IntToStr(RowCount);
    Order_F.Cancel_sGrd.Cells[GDM_SERVICE_CHG, RowCount-1] := aService;
  end;
end;

//**************************************************************************//
//                       영수증할인 금액 배분
//**************************************************************************//
procedure TCommon.Allot_Dc(aGrid:TStringGrid);
var vRow, vTotDc, Cnt, GoodCnt, vGoodCnt  :Integer;
    TotAmt, TmpAmt, ApplyAmt, vTotAmt,
    vTempDc   :Double;
    vYnDc :String;
    vIsDc :Boolean;
begin
   TotAmt := 0;  Cnt := 0; vTotAmt := 0;
   GoodCnt:= 0; ApplyAmt :=0; TmpAmt := 0;
   vIsDc  := False;
   vTotDc := Present.MemberDc + Present.CodeDc + PreSent.RcpDc + PreSent.EventDc + Present.CutDc + Present.VatDc + Present.PointDc + Present.KaKaoDc + Present.CouponDc + Present.UPlusDc;

   //할인합계 = 단차할인일때는 해당상품에만 적용
   if (vTotDc <> 0) and (vTotDc = Present.CutDc) then
   begin
     with aGrid do
     begin
       ApplyAmt := 0;
       For vRow := 0 to RowCount-1 do
         Cells[GDM_DC_RECEIPT, vRow] := '0';

       For vRow := 0 to RowCount-1 do
         if ((Cells[GDM_DS_SALE, vRow] = 'S') or (Cells[GDM_DS_SALE, vRow] = 'P')) and (StoI(Cells[GDM_QTY, vRow]) <> 0) and (StoI(Cells[GDM_AMT, vRow]) > 0) and (AmtofCut(StoI(Cells[GDM_AMT, vRow]),StrToIntDef(GetOption(153),0)) = Present.CutDc)  then
         begin
           Cells[GDM_DC_RECEIPT, vRow] := IntToStr(Present.CutDc);
           ApplyAmt := Present.CutDc;
           Break;
         end;
     end;
     if ApplyAmt = Present.CutDc then Exit;
   end;

   vYnDc  := 'Y';
   with aGrid do
   begin
      //포인트할인만 있을 때는 포인트사용제한 메뉴는 제외한다
      if (vTotDc <> 0) and (vTotDc = Present.PointDc) then
      begin
        For vRow := 0 to RowCount-1 do
        begin
          if ((Cells[GDM_YN_POINT, vRow] = 'Y') or (Cells[GDM_YN_POINT, vRow] = 'N')) and ((Cells[GDM_YN_DC, vRow]) = 'Y') and ((Cells[GDM_DS_SALE, vRow] = 'S') or (Cells[GDM_DS_SALE, vRow] = 'P')) and (StoI(Cells[GDM_QTY, vRow]) <> 0) and (StoI(Cells[GDM_AMT, vRow]) > 0) and (Cells[GDM_CD_MENU, vRow] <> Config.OverTimeMenu)  then
             Inc(GoodCnt);
        end;

        //배분할 상품이 없을때 (단차할인인데 모두 할인제외상품일때)
        if GoodCnt = 0 then vYnDc := 'N';

        GoodCnt     := 0;
        vGoodCnt := 0;
        For vRow := 0 to RowCount-1 do
        begin
          if ((Cells[GDM_YN_POINT, vRow] = 'Y') or (Cells[GDM_YN_POINT, vRow] = 'N')) and ((Cells[GDM_YN_DC, vRow]) = vYnDc) and ((Cells[GDM_DS_SALE, vRow] = 'S') or (Cells[GDM_DS_SALE, vRow] = 'P')) and (StoI(Cells[GDM_QTY, vRow]) <> 0) and (StoI(Cells[GDM_AMT, vRow]) > 0) and (Cells[GDM_CD_MENU, vRow] <> Config.OverTimeMenu)  then
          begin
             TotAmt := TotAmt + StoI(Cells[GDM_AMT,       vRow])
                              - StoI(Cells[GDM_DC_MENU,   vRow])     //단품할인
                              - StoI(Cells[GDM_DC_SPC,    vRow]);    //행사할인
             Inc(GoodCnt);
          end;

          //배분할 메뉴의 합계금액이 할인금액보다 작을때 사용
          if ((Cells[GDM_YN_POINT, vRow] = 'Y') or (Cells[GDM_YN_POINT, vRow] = 'N')) and ((Cells[GDM_DS_SALE, vRow] = 'S') or (Cells[GDM_DS_SALE, vRow] = 'P')) and (StoI(Cells[GDM_QTY, vRow]) <> 0) and (StoI(Cells[GDM_AMT, vRow]) > 0) and (Cells[GDM_CD_MENU, vRow] <> Config.OverTimeMenu)  then
          begin
             vTotAmt := vTotAmt + StoI(Cells[GDM_AMT,       vRow])
                                - StoI(Cells[GDM_DC_MENU,   vRow])     //단품할인
                                - StoI(Cells[GDM_DC_SPC,    vRow]);    //행사할인
            Inc(vGoodCnt);
          end;
          Cells[GDM_DC_RECEIPT, vRow]     := '0';
        end;

        if vTotDc = 0 then Exit;

        //배분할 메뉴의 합계금액이 할인금액보다 작을때
        if vTotDc > TotAmt then
        begin
          GoodCnt := vGoodCnt;
          TotAmt  := vTotAmt;
          vIsDc   := True;
        end;

        {금액배분}
        For vRow := 0 to RowCount-1 do
        begin
          if ((Cells[GDM_YN_POINT, vRow] = 'Y') or (Cells[GDM_YN_POINT, vRow] = 'N')) and (( (Cells[GDM_YN_DC, vRow]) = vYnDc) or vIsDc) and ((Cells[GDM_DS_SALE, vRow] = 'S') or (Cells[GDM_DS_SALE, vRow] = 'P')) and (StoI(Cells[GDM_QTY, vRow]) <> 0) and (StoI(Cells[GDM_AMT, vRow]) > 0) and (Cells[GDM_CD_MENU, vRow] <> Config.OverTimeMenu) then
          begin
            if Cnt + 1 = GoodCnt then
            begin
              TmpAmt := TmpAmt
                      + StoI(Cells[GDM_DC_RECEIPT, vRow])
                      + vTotDc
                      - ApplyAmt;
              Cells[GDM_DC_RECEIPT, vRow] := FtoS( StoI(Cells[GDM_DC_RECEIPT, vRow])
                                            + vTotDc -  ApplyAmt );
              Break;
            end
            else if Abs(ApplyAmt) < Abs(vTotDc) then {배분할금액이 총할인금액보다 작으면}
            begin
              TmpAmt := StoI(Cells[GDM_AMT,       vRow])
                      - StoI(Cells[GDM_DC_MENU,   vRow])     //단품할인
                      - StoI(Cells[GDM_DC_SPC,    vRow]);    //행사할인

              vTempDc := hRound( (TmpAmt / TotAmt) * vTotDc, 0) ;

              //배분할 금액을 총할인금액과 비교한다
              if (Abs(vTotDc) - Abs(ApplyAmt)) > StoI(Cells[GDM_DC_RECEIPT, vRow]) + vTempDc then
              begin
                Cells[GDM_DC_RECEIPT, vRow] :=  FtoS(  StoI(Cells[GDM_DC_RECEIPT, vRow]) + vTempDc );
                ApplyAmt := ApplyAmt + vTempDc ;
              end
              else
              begin
                Cells[GDM_DC_RECEIPT, vRow] := FtoS( Abs(vTotDc) - Abs(ApplyAmt) );
                ApplyAmt := ApplyAmt + Abs(vTotDc) - Abs(ApplyAmt) ;
              end;
              Inc(Cnt);
            end;
          end;
        end;
      end
      else
      begin
        For vRow := 0 to RowCount-1 do
        begin
          if ((Cells[GDM_YN_DC, vRow]) = 'Y') and ((Cells[GDM_DS_SALE, vRow] = 'S') or (Cells[GDM_DS_SALE, vRow] = 'P')) and (StoI(Cells[GDM_QTY, vRow]) <> 0) and (StoI(Cells[GDM_AMT, vRow]) > 0) and (Cells[GDM_CD_MENU, vRow] <> Config.OverTimeMenu)  then
             Inc(GoodCnt);
        end;

        //배분할 상품이 없을때 (단차할인인데 모두 할인제외상품일때)
        if GoodCnt = 0 then vYnDc := 'N';

        GoodCnt     := 0;
        vGoodCnt := 0;
        For vRow := 0 to RowCount-1 do
        begin
          if ((Cells[GDM_YN_DC, vRow]) = vYnDc) and ((Cells[GDM_DS_SALE, vRow] = 'S') or (Cells[GDM_DS_SALE, vRow] = 'P')) and (StoI(Cells[GDM_QTY, vRow]) <> 0) and (StoI(Cells[GDM_AMT, vRow]) > 0) and (Cells[GDM_CD_MENU, vRow] <> Config.OverTimeMenu)  then
          begin
             TotAmt := TotAmt + StoI(Cells[GDM_AMT,       vRow])
                              - StoI(Cells[GDM_DC_MENU,   vRow])     //단품할인                                                      
                              - StoI(Cells[GDM_DC_SPC,    vRow]);    //행사할인
             Inc(GoodCnt);
          end;

          //배분할 메뉴의 합계금액이 할인금액보다 작을때 사용
          if ((Cells[GDM_DS_SALE, vRow] = 'S') or (Cells[GDM_DS_SALE, vRow] = 'P')) and (StoI(Cells[GDM_QTY, vRow]) <> 0) and (StoI(Cells[GDM_AMT, vRow]) > 0) and (Cells[GDM_CD_MENU, vRow] <> Config.OverTimeMenu)  then
          begin
             vTotAmt := vTotAmt + StoI(Cells[GDM_AMT,       vRow])
                                - StoI(Cells[GDM_DC_MENU,   vRow])     //단품할인
                                - StoI(Cells[GDM_DC_SPC,    vRow]);    //행사할인
            Inc(vGoodCnt);
          end;
          Cells[GDM_DC_RECEIPT, vRow]     := '0';
        end;

        if vTotDc = 0 then Exit;

        //배분할 메뉴의 합계금액이 할인금액보다 작을때
        if vTotDc > TotAmt then
        begin
          GoodCnt := vGoodCnt;
          TotAmt  := vTotAmt;
          vIsDc   := True;
        end;

        {금액배분}
        For vRow := 0 to RowCount-1 do
        begin
          if (( (Cells[GDM_YN_DC, vRow]) = vYnDc) or vIsDc) and ((Cells[GDM_DS_SALE, vRow] = 'S') or (Cells[GDM_DS_SALE, vRow] = 'P')) and (StoI(Cells[GDM_QTY, vRow]) <> 0) and (StoI(Cells[GDM_AMT, vRow]) > 0) and (Cells[GDM_CD_MENU, vRow] <> Config.OverTimeMenu) then
          begin
            if Cnt + 1 = GoodCnt then
            begin
              TmpAmt := TmpAmt
                      + StoI(Cells[GDM_DC_RECEIPT, vRow])
                      + vTotDc
                      - ApplyAmt;
              Cells[GDM_DC_RECEIPT, vRow] := FtoS( StoI(Cells[GDM_DC_RECEIPT, vRow])
                                            + vTotDc -  ApplyAmt );
              Break;
            end
            else if Abs(ApplyAmt) < Abs(vTotDc) then {배분할금액이 총할인금액보다 작으면}
            begin
              TmpAmt := StoI(Cells[GDM_AMT,       vRow])
                      - StoI(Cells[GDM_DC_MENU,   vRow])     //단품할인
                      - StoI(Cells[GDM_DC_SPC,    vRow]);    //행사할인

              vTempDc := hRound( (TmpAmt / TotAmt) * vTotDc, 0) ;

              //배분할 금액을 총할인금액과 비교한다
              if (Abs(vTotDc) - Abs(ApplyAmt)) > StoI(Cells[GDM_DC_RECEIPT, vRow]) + vTempDc then
              begin
                Cells[GDM_DC_RECEIPT, vRow] :=  FtoS(  StoI(Cells[GDM_DC_RECEIPT, vRow]) + vTempDc );
                ApplyAmt := ApplyAmt + vTempDc ;
              end
              else
              begin
                 Cells[GDM_DC_RECEIPT, vRow] := FtoS( Abs(vTotDc) - Abs(ApplyAmt) );
                 ApplyAmt := ApplyAmt + Abs(vTotDc) - Abs(ApplyAmt) ;
              end;
              Inc(Cnt);
            end;
          end;
        end;
      end;
   end;
end;

//**************************************************************************//
//                       영수증을 불러와서 셋팅
//**************************************************************************//
function TCommon.SetReceipt(aDate,aPosNo,aRcpNo:String):Boolean;
  function GetItemMenu(aValue:String;aQty:Integer):String;
  var I, Index, vQty :Integer;
      vList :TStringList;
  begin
    vList := TStringList.Create;
    try
      Split(aValue, '|', vList);
      Index := 1;
      Result := '';
      for Index := 0 to vList.Count-1 do
      begin
        if vList.Strings[Index] = '' then Continue;

        DM.UniQuery.Close;
        DM.UniQuery.SQL.Text := 'select NM_MENU_SHORT, '
                               +'       NM_MENU_KITCHEN, '
                               +Ifthen(GetOption(194)='1','GetSalePrice(CD_STORE, CD_MENU) as PR_SALE ', 'PR_SALE ')
                               +'  from MS_MENU '
                               +' where CD_STORE =:P0 '
                               +'   and CD_MENU  =:P1';
        DM.UniQuery.ParamByName('P0').AsString := Common.Config.StoreCode;
        DM.UniQuery.ParamByName('P1').AsString := Copy(vList.Strings[Index],1,Pos(',',vList.Strings[Index])-1);
        DM.UniQuery.Open;
        if not DM.UniQuery.Eof then
        begin
          vQty := StrToIntDef(Copy(vList.Strings[Index],Pos(',',vList.Strings[Index])+1,3),1);
          if vQty > 1 then
          begin
            if DM.UniQuery.FieldByName('pr_sale').AsInteger = 0 then
              Result := Result + Format(' -%s %d개'+#13,[DM.UniQuery.FieldByName('nm_menu_short').AsString, vQty*aQty])
            else
              Result := Result + Format(' -%s %d개 (%s)'+#13,[DM.UniQuery.FieldByName('nm_menu_short').AsString, vQty*aQty, FormatFloat(',0원',DM.UniQuery.FieldByName('pr_sale').AsInteger)]);
          end
          else
          begin
            if DM.UniQuery.FieldByName('pr_sale').AsInteger = 0 then
              Result := Result + Format(' -%s'+#13,[DM.UniQuery.FieldByName('nm_menu_short').AsString])
            else
              Result := Result + Format(' -%s (%s)'+#13,[DM.UniQuery.FieldByName('nm_menu_short').AsString, FormatFloat(',0원',DM.UniQuery.FieldByName('pr_sale').AsInteger)]);
          end;
        end;
      end;
      if (Result <> '') then Delete(Result, Length(Result), 1);
    finally
      vList.Free;
      DM.UniQuery.Close;
    end;
  end;

var vDsSale :String;
    vAgeCode :String;
    vNowStamp,
    vLapeTime,
    vSalePrice:Integer;
begin
  Result := false;
  try
    InitMemberRecord(Member);
    InitPreSentRecord(PreSent);
    InitMenuRecord(Menu);               //상품정보초기화
    InitCardRecord(Card);               //신용카드정보초기화
    InitCashRcpRecord(CashRcp);         //현금영수증정보초기화
    ClearGrid(Group_sGrd);

    //매출헤더
    OpenQuery('select a.*, '
             +'       b.NM_MEMBER, '
             +'       b.DS_MEMBER, '
             +'       a.PNT_OCCUR, '
             +'       a.PNT_USE, '
             +'       Date_Format(a.COME_TIME, ''%Y%m%d'') as COME_DATE, '
             +'       Date_Format(a.COME_TIME, ''%H:%i'')  as COME_TIME, '
             +'       a.COME_TIME as DT_COME, '
             +'       GetCommonName(a.CD_STORE, ''07'', a.CD_CODE) as NM_DC, '
             +'       (select NM_TABLE '
             +'          from MS_TABLE '
             +'         where CD_STORE = a.CD_STORE '
             +'           and NO_TABLE = a.NO_TABLE '
             +'           and SEQ      = 0 '
             +'          limit 1) as NM_TABLE, '
             +'       (select t2.NM_CODE1 '
             +'          from MS_TABLE t1 inner join '
             +'               MS_CODE  t2 on t2.CD_STORE = t1.CD_STORE and t2.CD_KIND = ''03'' and t2.CD_CODE = t1.CD_FLOOR '
             +'         where t1.CD_STORE = a.CD_STORE '
             +'           and t1.NO_TABLE = a.NO_TABLE '
             +'         limit 1) nm_floor, '
             +'       c.NM_SAWON, '
             +'       d.AFT_LMT, '
             +'       b.AMT_TRUST as AMT_MISU '
             +'  from SL_SALE_H    a left outer join '
             +'       MS_MEMBER    b on b.CD_STORE = a.CD_STORE and b.CD_MEMBER = a.CD_MEMBER left outer join '
             +'       MS_SAWON     c on c.CD_STORE = a.CD_STORE and c.CD_SAWON  = a.CD_DAMDANG left outer join '
             +'       SL_TAXFREE_H d on d.TAXFREE_BUY_NO = a.TAXFREE_BUY_NO '
             +' where a.CD_STORE =:P0   '
             +'   and a.YMD_SALE =:P1 '
             +'   and a.NO_POS   =:P2 '
             +'   and a.NO_RCP   =:P3 ',
             [Config.StoreCode,
              aDate,
              aPosNo,
              aRcpNo ]);

    if Query.Eof then
    begin
      Result := false;
      Exit;
    end;
    Result := True;
    Present.RcpNo     := aRcpNo;
    Present.TotalAmt  := Query.FieldByName('amt_sale').AsInteger;
    Present.CashAmt   := Query.FieldByName('amt_cash').AsInteger;
    Present.CardAmt   := Query.FieldByName('amt_card').AsInteger;
    Present.CheckAmt  := Query.FieldByName('amt_check').AsInteger;
    Present.GiftAmt   := Query.FieldByName('amt_gift').AsInteger;
    Present.TrustAmt  := Query.FieldByName('amt_trust').AsInteger;
    Present.BankAmt   := Query.FieldByName('amt_bank').AsInteger;
    Present.EtcAmt    := Query.FieldByName('amt_etc').AsInteger;
    Present.LetsOrderAmt := Query.FieldByName('amt_letsorder').AsInteger;
    Present.PointAmt  := Query.FieldByName('amt_point').AsInteger;
    Present.MemberDc  := Query.FieldByName('dc_member').AsInteger;
    Present.MenuDc    := Query.FieldByName('dc_Menu').AsInteger;
    Present.CodeDc    := Query.FieldByName('dc_code').AsInteger;
    Present.CodeDcCode:= Query.FieldByName('cd_code').AsString;
    Present.CodeDcName:= Query.FieldByName('nm_dc').AsString;
    Present.RcpDc     := Query.FieldByName('dc_receipt').AsInteger;
    Present.SpcDc     := Query.FieldByName('dc_spc').AsInteger;
    Present.CashTipAmt:= Query.FieldByName('amt_CashTip').AsInteger;
    Present.CardTipAmt:= Query.FieldByName('amt_CardTip').AsInteger;
    Present.TipAmt    := Present.CashTipAmt + Present.CardTipAmt;
    Present.SetTip    := Present.TipAmt;
    Present.EventDc   := Query.FieldByName('dc_Event').AsInteger;
    Present.CutDc     := Query.FieldByName('dc_Cut').AsInteger;
    Present.VatDc     := Query.FieldByName('dc_vat').AsInteger;
    Present.PointDc   := Query.FieldByName('dc_point').AsInteger;
    Present.TaxFreeDc := Query.FieldByName('dc_taxfree').AsInteger;
    Present.StampDc   := Query.FieldByName('dc_stamp').AsInteger;
    Present.TotalDc   := Query.FieldByName('dc_Tot').AsInteger;
    Present.CashRcpAmt:= Query.FieldByName('amt_CashRcp').AsInteger;
    Present.UsePnt    := Query.FieldByName('pnt_use').AsInteger;
    Present.OccurPnt  := Query.FieldByName('pnt_occur').AsInteger;
    Present.DutyAmt   := Query.FieldByName('amt_duty').AsInteger;
    Present.FreeAmt   := Query.FieldByName('amt_dutyfree').AsInteger;
    Present.TaxAmt    := Query.FieldByName('amt_tax').AsInteger;
    Present.ServiceAmt:= Query.FieldByName('amt_service').AsInteger;
    Present.SaleTime  := FormatDateTime('hhnn', Query.FieldByName('dt_sale').AsDateTime);
    Present.SaleDate  := Query.FieldByName('dt_sale').AsDateTime;
    ComeDateTime      := Query.FieldByName('DT_COME').AsDateTime;
    Present.TaxfreeNo := Query.FieldByName('taxfree_buy_no').AsString;
    Present.TaxRefundAfterLimit := Query.FieldByName('aft_lmt').AsInteger;
    Present.SaveStamp := Query.FieldByName('save_stamp').AsInteger;
    Present.UseStamp  := Query.FieldByName('use_stamp').AsInteger;
    Present.OldMember    := Query.FieldByName('cd_member').AsString;
    Present.OldSaveStamp := Present.SaveStamp;
    Present.OldUseStamp  := Present.UseStamp;
    vNowStamp            := Query.FieldByName('now_stamp').AsInteger;
    Present.UPlusDc      := Query.FieldByName('dc_uplus').AsInteger;
    Present.KaKaoDc      := Query.FieldByName('dc_kakao').AsInteger;
    Present.LetsOrderDc  := Query.FieldByName('dc_letsorder').AsInteger;

    Present.TotalAmt   := Present.TotalAmt - Ifthen(GetOption(160)='0', Present.TipAmt + 0) + Present.TotalDc;
    Present.OrgCardAmt := Present.CardAmt;

    Member.Code        := Query.FieldByName('cd_member').AsString;
    Table.OrderNo     := Query.FieldByName('no_order').AsInteger;
    //호출번호를 수동으로 사용할때
    PreSent.CallNo := Query.FieldByName('no_call').AsInteger;
    Table.Date        := Query.FieldByName('come_date').AsString;
    Table.Time        := Query.FieldByName('come_time').AsString;
    Table.FloorName   := Query.FieldByName('nm_Floor').AsString;
    Table.Number      := Query.FieldByName('no_Table').AsInteger;
    Table.Name        := Query.FieldByName('nm_Table').AsString;
    Table.CustomerCount := Query.FieldByName('cnt_person').AsInteger;
    Table.DamdangCode := Query.FieldByName('cd_damdang').AsString;
    Table.DamdangName := Query.FieldByName('nm_sawon').AsString;
    Table.CustCode    := Query.FieldByName('cd_customer').AsString;
    Table.DsDelivery  := Query.FieldByName('ds_delivery').AsString;
    Table.DeliveryNo  := Query.FieldByName('no_delivery').AsString;
    Member.CreditAmt   := Query.FieldByName('amt_misu').AsInteger;
    Query.Close;
    if Member.Code <> '' then
    begin
      SelectMemberInfo(Member.Code,'','');
      Member.Stamp := vNowStamp - Present.SaveStamp + Present.UseStamp;
    end;
    OpenQuery('select PNT_TOTAL '
             +'  from SL_POINT '
             +' where CD_STORE =:P0 '
             +'   and RCP_LINK =:P1 ',
             [Config.StoreCode,
             aDate+aPosNo+aRcpNo ]);
    if not Query.Eof then
    begin
      Member.Point      := Query.FieldByName('PNT_TOTAL').AsInteger;
      Member.Point      := Member.Point + Present.OccurPnt - Present.UsePnt;
      Query.Close;
    end;

    if Table.DeliveryNo <> '' then
      Table.OrderType   := 'D';
    //연령대별 고객수 설정
    OpenQuery('select CD_AGE, '
             +'       CNT_PERSON '
             +'  from SL_SALE_AGE '
             +' where CD_STORE =:P0 '
             +'   and YMD_SALE =:P1 '
             +'   and NO_POS   =:P2 '
             +'   and NO_RCP   =:P3 '
             +'   and CNT_PERSON > 0 ',
             [Config.StoreCode,
              aDate,
              aPosNo,
              aRcpNo ]);
    vAgeCode := EmptyStr;
    while not Query.Eof do
    begin
      vAgeCode := vAgeCode + Format('%s%s,',[Query.FieldByName('cd_age').AsString,
                                             FormatFloat('000', Query.FieldByName('CNT_PERSON').AsInteger)]);
      Query.Next;
    end;
    Query.Close;

    if vAgeCode <> EmptyStr then
    begin
      vAgeCode := vAgeCode + LeftStr(vAgeCode, Length(vAgeCode)-1);
      SetAgeInfo( vAgeCode );
    end;

    //지정할인이 있을때 할인정보 설정
    if Present.CodeDcCode <> '' then
    begin
      OpenQuery('select NM_CODE1, '
               +'       NM_CODE2, '
               +'       NM_CODE3, '
               +'       NM_CODE4, '
               +'       NM_CODE5, '
               +'       NM_CODE6 '
               +'  from MS_CODE '
               +' where CD_STORE =:P0 '
               +'   and CD_KIND  =''07'' '
               +'   and CD_CODE  =:P1 ',
               [Config.StoreCode,
                Present.CodeDcCode ]);
      if not Query.Eof then
      begin
        Present.CodeDcType   := Query.FieldByName('NM_CODE2').AsString;
        Present.CodeDcRate   := StoF(Query.FieldByName('NM_CODE3').AsString);
        Present.CodeDcStdAmt := StoI(Query.FieldByName('NM_CODE4').AsString);
        Present.CodeDcAmt    := StoI(Query.FieldByName('NM_CODE5').AsString);
        Present.CodeDcClass  := Query.FieldByName('NM_CODE6').AsString;
      end;
      Query.Close;
    end;

    //매출상세
    OpenQuery('select a.*, '
             +'       b.NM_MENU as NM_MENU1, '
             +'       Substring(b.CONFIG,3,1) as YN_RCP, '
             +'       b.DS_KITCHEN, '
             +'       b.DS_MENU_TYPE, '
             +'       b.CD_PRINTER, '
             +'       b.NO_GROUP, '
             +'       Substring(b.CONFIG,2,1) as YN_POINT, '
             +'       Substring(b.CONFIG,1,1) as YN_DC, '
             +'       Substring(b.CONFIG,9,1) as YN_POINT_LIMIT, '
             +'       b.CD_CORNER as NO_CORNER, '
             +'       b.PR_SALE as PR_SALE_ORG,  '
             +'       b.CD_CLASS, '
             +'       b.PR_SALE_DOUBLE, '
             +'       Substring(b.CONFIG,4,1) as YN_PERSON, '
             +'       b.PR_BUY, '
             +'       b.PR_SALE_PROFIT, '
             +'       a.CD_SERVICE, '
             +'       Substring(b.CONFIG,5,1) as YN_BILL, '
             +'       a.DC_TAXFREE, '
             +'       a.DC_STAMP, '
             +'       b.SAVE_STAMP as SAVE_STAMP_M, '
             +'       b.USE_STAMP as USE_STAMP_M, '
             +'       b.DS_STOCK, '
             +'       b.QTY_UNIT, '
             +'       b.PR_SALE_PACKING, '
             +'       b.NM_MENU_KITCHEN '
             +'  from SL_SALE_D a left outer join '
             +'       MS_MENU   b on b.CD_STORE = a.CD_STORE and b.CD_MENU = a.CD_MENU '
             +' where a.CD_STORE =:P0 '
             +'   and a.YMD_SALE =:P1 '
             +'   and a.NO_POS   =:P2 '
             +'   and a.NO_RCP   =:P3 '
             +' order by a.SEQ ',
             [Config.StoreCode,
              aDate,
              aPosNo,
              aRcpNo ]);
    ClearGrid(Summary_sGrd);
    while not Query.Eof do
    begin
      with Summary_sGrd do
      begin
        if (GetOption(20) = '1') and (Common.Config.TipMenu = Query.FieldByName('cd_menu').AsString) then
        begin
          Query.Next;
          Continue;
        end;
        if Cells[0,0] <> '' then RowCount := RowCount + 1;

        vSalePrice := Query.FieldByName('pr_sale').asInteger - Query.FieldByName('pr_item').asInteger;
        Cells[GDM_NO         ,RowCount-1] := IntToStr(RowCount-1+1);                                  //순번
        Cells[GDM_SEQ        ,RowCount-1] := Cells[GDM_NO ,RowCount-1];
        vDsSale := Query.FieldByName('ds_sale_type').AsString;

        //메뉴명
        if vDsSale = 'P' then
          Cells[GDM_NM_MENU    ,RowCount-1] := Common.Config.PackingTxt+Query.FieldByName('nm_menu1').AsString
        else
          Cells[GDM_NM_MENU    ,RowCount-1] := Query.FieldByName('nm_menu1').AsString;

        //추가요금 메뉴일때
        if Common.Config.OverTimeMenu = Query.FieldByName('CD_MENU').AsString then
        begin
          vLapeTime := MinutesBetween(ComeDateTime, Present.SaleDate) - Config.OverTimeTime;
          if vLapeTime - FtoI((vSalePrice / Config.OverTimeAmt) * Config.OverTimeEach) > Config.OverTimeEach then
            vLapeTime := FtoI((vSalePrice / Config.OverTimeAmt) * Config.OverTimeEach);
          if vLapeTime > 60  then
            Cells[GDM_NM_MENU    ,RowCount-1] := Cells[GDM_NM_MENU    ,RowCount-1] +Format('(%d:%d)',[vLapeTime div 60, vLapeTime mod 60])
          else
            Cells[GDM_NM_MENU    ,RowCount-1] := Cells[GDM_NM_MENU    ,RowCount-1] +Format('(%d분)',[vLapeTime]);
        end;
        Cells[GDM_DS_MENU    ,RowCount-1] := Query.FieldByName('ds_menu_type').AsString;     //상품단가
        if Cells[GDM_DS_MENU    ,RowCount-1] = 'N' then                                      //메뉴구분
          Cells[GDM_TYPE       ,RowCount-1] :=''
        else if (Cells[GDM_DS_MENU    ,RowCount-1] = 'W') then
          Cells[GDM_TYPE       ,RowCount-1] := 'ⓦ'
        else if (Cells[GDM_DS_MENU    ,RowCount-1] = 'S') then
          Cells[GDM_TYPE       ,RowCount-1] := 'ⓢ'
        else if (Cells[GDM_DS_MENU    ,RowCount-1] = 'I') then
          Cells[GDM_TYPE       ,RowCount-1] := 'ⓘ'
        else if (Cells[GDM_DS_MENU    ,RowCount-1] = 'C') then
          Cells[GDM_TYPE       ,RowCount-1] := 'ⓒ'
        else if (Cells[GDM_DS_MENU    ,RowCount-1] = 'O') then
          Cells[GDM_TYPE       ,RowCount-1] := 'ⓞ'
        else if (Cells[GDM_DS_MENU    ,RowCount-1] = 'G') then
          Cells[GDM_TYPE       ,RowCount-1] := 'ⓖ';
        Cells[GDM_PR_SALE    ,RowCount-1] := IntToStr(vSalePrice);           //상품단가
        Cells[GDM_PR_SALE_DB, RowCount-1] := Query.FieldByName('pr_sale_double').AsString;
        Cells[GDM_PR_SALE_PACKING, RowCount-1] := Query.FieldByName('pr_sale_packing').AsString;
        Cells[GDM_YN_DOUBLE      ,RowCount-1] := Query.FieldByName('yn_double').AsString;

        //곱빼기일때
        if Cells[GDM_YN_DOUBLE      ,RowCount-1] = 'Y'  then
          Cells[GDM_NM_MENU    ,RowCount-1] := Cells[GDM_NM_MENU    ,RowCount-1] + '(곱빼기)';

        Cells[GDM_DS_SALE    ,RowCount-1] := vDsSale;
        Cells[GDM_VIEWQTY    ,RowCount-1] := GetQtyReplace(Query.FieldByName('ds_menu_type').AsString,
                                                           Query.FieldByName('qty_sale').AsString);          //상품수량
        if Cells[GDM_DS_MENU    ,RowCount-1] = 'W' then
        begin
          Cells[GDM_AMT        ,RowCount-1] := IntToStr(vSalePrice);
          if vSalePrice = 0 then
            Cells[GDM_VIEWPRICE  ,RowCount-1] := FormatFloat(',0',vSalePrice)
          else
            Cells[GDM_VIEWPRICE  ,RowCount-1] := FormatFloat(',0',FtoI(vSalePrice / Query.FieldByName('qty_sale').AsInteger * 100));
        end
        else
        begin
          Cells[GDM_AMT        ,RowCount-1] := FToS(Query.FieldByName('qty_sale').AsFloat
                                             * (vSalePrice + Query.FieldByName('pr_item').AsInteger));
          Cells[GDM_VIEWPRICE  ,RowCount-1] := IntToStr(vSalePrice);       //상품단가
        end;

        Cells[GDM_CD_MENU    ,RowCount-1] := Query.FieldByName('cd_menu').AsString;                //판매기준바코드
        Cells[GDM_DS_TAX     ,RowCount-1] := Query.FieldByName('ds_tax').AsString;                 //세무구분
        if Cells[GDM_DS_MENU    ,RowCount-1] = 'W' then
        begin
          Cells[GDM_DC_MENU    ,RowCount-1] := Query.FieldByName('dc_menu').AsString; //단품할인금액
          Cells[GDM_DC_SPC     ,RowCount-1] := Query.FieldByName('dc_spc').AsString;  //행사할인
        end
        else
        begin
          if Query.FieldByName('qty_sale').AsInteger = 0 then
          begin
            Cells[GDM_DC_MENU    ,RowCount-1] := Query.FieldByName('dc_menu').AsString; //단품할인금액
            Cells[GDM_DC_SPC     ,RowCount-1] := Query.FieldByName('dc_spc').AsString;  //행사할인
          end
          else
          begin
            Cells[GDM_DC_MENU    ,RowCount-1] := IntToStr(Query.FieldByName('dc_menu').AsInteger
                                                          div ABS(Query.FieldByName('qty_sale').AsInteger) ); //단품할인금액
            Cells[GDM_DC_SPC     ,RowCount-1] := IntToStr(Query.FieldByName('dc_spc').AsInteger
                                                          div ABS(Query.FieldByName('qty_sale').AsInteger) );  //행사할인
          end;
        end;
        Cells[GDM_NO_SPC         ,RowCount-1] := Query.FieldByName('no_spc').AsString;
        Cells[GDM_DC_RECEIPT     ,RowCount-1] := Query.FieldByName('dc_receipt').AsString;
        Cells[GDM_DC_MEMBER      ,RowCount-1] := Query.FieldByName('dc_member').AsString;
        Cells[GDM_QTY            ,RowCount-1] := Query.FieldByName('qty_sale').AsString;          //상품수량
        Cells[GDM_KITCHEN        ,RowCount-1] := Query.FieldByName('cd_printer').AsString;
        Cells[GDM_PRT_KITCHEN    ,RowCount-1] := Query.FieldByName('ds_kitchen').AsString;
        Cells[GDM_NO_GROUP       ,RowCount-1] := Query.FieldByName('no_group').AsString;
        Cells[GDM_YN_RCP         ,RowCount-1] := Query.FieldByName('yn_rcp').AsString;
        Cells[GDM_YN_DC          ,RowCount-1] := Query.FieldByName('yn_dc').AsString;      //
        Cells[GDM_YN_POINT       ,RowCount-1] := Query.FieldByName('yn_point').AsString;
        Cells[GDM_YN_POINT_LIMIT ,RowCount-1] := Query.FieldByName('yn_point_limit').AsString;
        Cells[GDM_NO_STEP        ,RowCount-1] := '0';
        Cells[GDM_CD_ITEM        ,RowCount-1] := Query.FieldByName('cd_items').AsString;
        Cells[GDM_NM_ITEM        ,RowCount-1] := GetItemMenu(Query.FieldByName('cd_items').AsString, Query.FieldByName('qty_sale').AsInteger);
        Cells[GDM_TIP            ,RowCount-1] := Query.FieldByName('pr_tip').AsString;
        Cells[GDM_PR_ITEM        ,RowCount-1] := Query.FieldByName('pr_item').AsString;
        Cells[GDM_CORNER         ,RowCount-1] := Query.FieldByName('no_corner').AsString;
        Cells[GDM_YN_ORDER       ,RowCount-1] := Ifthen(OrderKind = okSaleChange, 'N', 'Y');
        Cells[GDM_SVC            ,RowCount-1] := 'N';
        Cells[GDM_PR_SALE_ORG    ,RowCount-1] := Query.FieldByName('pr_sale_org').AsString;
        Cells[GDM_CD_CLASS       ,RowCount-1] := Query.FieldByName('cd_class').AsString;
        Cells[GDM_YN_PERSON      ,RowCount-1] := Query.FieldByName('yn_person').AsString;
        Cells[GDM_PR_BUY         ,RowCount-1] := Query.FieldByName('pr_buy').AsString;
        Cells[GDM_RT_PROFIT      ,RowCount-1] := Query.FieldByName('pr_sale_profit').AsString;
        Cells[GDM_CD_SERVICE     ,RowCount-1] := Query.FieldByName('cd_service').AsString;
        Cells[GDM_YN_BILL        ,RowCount-1] := Query.FieldByName('yn_bill').AsString;
        Cells[GDM_DC_TAXFREE     ,RowCount-1] := Query.FieldByName('dc_taxfree').AsString;
        Cells[GDM_DC_STAMP       ,RowCount-1] := Query.FieldByName('dc_stamp').AsString;
        Cells[GDM_SAVE_STAMP     ,RowCount-1] := Query.FieldByName('save_stamp').AsString;
        Cells[GDM_USE_STAMP      ,RowCount-1] := Query.FieldByName('use_stamp').AsString;
        Cells[GDM_SAVE_STAMP_M   ,RowCount-1] := Query.FieldByName('save_stamp_m').AsString;
        Cells[GDM_USE_STAMP_M    ,RowCount-1] := Query.FieldByName('use_stamp_m').AsString;
        Cells[GDM_DS_STOCK       ,RowCount-1] := Query.FieldByName('ds_stock').AsString;
        Cells[GDM_QTY_UNIT       ,RowCount-1] := Query.FieldByName('qty_unit').AsString;
        Cells[GDM_NM_MENU_KITCHEN,RowCount-1] := Query.FieldByName('NM_MENU_KITCHEN').AsString;
      end;
      Query.Next;
    end;
    Query.Close;

    //신용카드 승인내역 불러온기
    SetCardSale(aDate+aPosNo+aRcpNo);
    //현금영수증 승인내역 불러온기
    SetCashSale(aDate+aPosNo+aRcpNo);

//    if GetOption(92) = '1' then
//    begin
//      OpenQuery('select * '
//               +'  from SL_UPLUS '
//               +' where CD_STORE =:P0 '
//               +'   and YMD_SALE =:P1 '
//               +'   and NO_POS   =:P2 '
//               +'   and NO_RCP   =:P3 '
//               +'   and DS_TRD = =:P4 ',
//               [Config.StoreCode,
//                aDate,
//                aPosNo,
//                aRcpNo,
//                dtApproval]);
//      ClearGrid(Common.UPlus_sGrd);
//      with Query, UPlus_sGrd do
//       while not Eof do
//       begin
//         if Cells[0,0] <> '' then RowCount := RowCount + 1;
//         Cells[GDK_DS_TRD           ,RowCount-1]  :=  FieldByName('ds_trd').AsString;
//         Cells[GDK_CARDNO           ,RowCount-1]  :=  FieldByName('no_card').AsString;
//         Cells[GDK_AMT              ,RowCount-1]  :=  FieldByName('amt_sale').AsString;
//         Cells[GDK_DC_AMT           ,RowCount-1]  :=  FieldByName('amt_dc').AsString;
//         Cells[GDK_CHAINPL          ,RowCount-1]  :=  FieldByName('no_telmfLw').AsString;
//         Cells[GDK_TRD_DATE         ,RowCount-1]  :=  FieldByName('approval_date').AsString;
//         Cells[GDK_NO_APPROVAL      ,RowCount-1]  :=  FieldByName('no_approval').AsString;
//         Cells[GDK_TRD_DATE_ORG     ,RowCount-1]  :=  FieldByName('approval_date_org').AsString;
//         Cells[GDK_APPROVAL_ORG     ,RowCount-1]  :=  FieldByName('no_approval_org').AsString;
//         Cells[GDK_PNT_REST         ,RowCount-1]  :=  FieldByName('pnt_rest').AsString;
//         Cells[GDK_YN_CAN           ,RowCount-1]  :=  'Y';
//         Cells[GDK_YN_PRINT         ,RowCount-1]  :=  'Y';
//         Cells[GDK_YN_SAVE          ,RowCount-1]  :=  'N';
//         Query.Next;
//       end;
//    end;

    OpenQuery('select a.NO_COUPON, '
             +'       a.AMT_DC, '
             +'       b.COUPON_TYPE, '
             +'       b.AMT_DC as RATE_COUPON '
             +'  from SL_SALE_COUPON a left outer join '
             +'       MS_COUPON      b on b.CD_STORE = a.CD_STORE and b.NO_COUPON = a.NO_COUPON '
             +' where a.CD_STORE =:P0 '
             +'   and a.YMD_SALE =:P1 '
             +'   and a.NO_POS   =:P2 '
             +'   and a.NO_RCP   =:P3 ',
             [Config.StoreCode,
              aDate,
              aPosNo,
              aRcpNo]);
    if not Query.Eof then
    begin
      PreSent.CouponNo   := Query.FieldByName('NO_COUPON').AsString;
      PreSent.CouponType := Query.FieldByName('COUPON_TYPE').AsString;
      PreSent.CouponRate := Query.FieldByName('RATE_COUPON').AsInteger;
      PreSent.CouponDc   := Query.FieldByName('AMT_DC').AsInteger;
    end;
    Query.Close;

    OpenQuery('select * '
             +'  from MS_COUPON '
             +' where CD_STORE  =:P0 '
             +'   and RCP_ISSUE =:P1 ',
             [Config.StoreCode,
              aDate+aPosNo+aRcpNo]);
    if not Query.Eof then
    begin
      Present.CouponNo_Issue       := Query.FieldByName('NO_COUPON').AsString;
      Present.CouponName_Issue     := Query.FieldByName('NM_COUPON').AsString;
      Present.CouponType_Issue     := Query.FieldByName('COUPON_TYPE').AsString;
      Present.CouponAmt_Issue      := Query.FieldByName('AMT_DC').AsInteger;
      Present.CouponFromDate_Issue := Query.FieldByName('YMD_FROM').AsString;
      Present.CouponToDate_Issue   := Query.FieldByName('YMD_TO').AsString;
    end;
    Query.Close;

    if (GetOption(231) = '1') and (GetOption(233) = '1') then
    begin
      OpenQuery('select * '
               +'  from SL_SALE_NO '
               +' where CD_STORE =:P0 '
               +'   and YMD_SALE =:P1 '
               +'   and NO_POS   =:P2 '
               +'   and NO_RCP   =:P3 ',
               [Config.StoreCode,
                aDate,
                aPosNo,
                aRcpNo]);
      while not Query.Eof do
      begin
        Corner[ GetCornerIndex(Query.FieldByName('CD_CORNER').AsString)].OrderNo :=  Query.FieldByName('NO_ORDER').AsInteger;
        Query.Next;
      end;
      Query.Close;
    end;

    if Assigned(Order_F) and Order_F.Showing then GridToGrid(Summary_sGrd, Order_F.Main_sGrd);
  except
  end;
end;

procedure TCommon.SetCardSale(aValue:String; AType:Integer=0);
var vBmp    : TBitmap;
    vStream : TStream;
begin
  //신용카드 승인내역 불러온기
  if aType = 0 then
    OpenQuery('select * '
             +'  from SL_CARD '
             +' where CD_STORE =:P0 '
             +'   and YMD_SALE =:P1 '
             +'   and NO_POS   =:P2 '
             +'   and NO_RCP   =:P3 '
             +' order by SEQ ',
             [Config.StoreCode,
              LeftStr(aValue,8),
              Copy(aValue,9,2),
              RightStr(aValue,4)])
  else if AType = 1 then
    OpenQuery('select * '
             +'  from SL_ACCT_CARD '
             +' where CD_STORE =:P0 '
             +'   and YMD_SALE =:P1 '
             +'   and NO_POS   =:P2 '
             +'   and NO_ACCT  =:P3 '
             +' order by SEQ ',
             [Config.StoreCode,
              LeftStr(aValue,8),
              Copy(aValue,9,2),
              RightStr(aValue,3)])
  else if aType = 2 then
  begin
    OpenQuery('select * '
             +'  from SL_CARD_AHEAD '
             +' where CD_STORE =:P0 '
             +'   and NO_TABLE =:P1 '
             +'   and (DS_CARD  <> ''P'' and YN_LETSORDER <> ''Y'') ',
             [Common.Config.StoreCode,
              Common.Table.Number]);
  end;

  if aType <> 2 then
    ClearGrid(Card_sGrd);
  with Query, Card_sGrd do
  while not Eof do
  begin
     if Cells[0,0] <> '' then RowCount := RowCount + 1;

     Cells[GDC_DS_CARD,     RowCount-1] := FieldByName('DS_CARD').AsString;
     Cells[GDC_DS_TRD,      RowCount-1] := FieldByName('DS_TRD').AsString;
     Cells[GDC_CARDNO,      RowCount-1] := FieldByName('NO_CARD').AsString;
     Cells[GDC_APPROVAL_ORG,RowCount-1] := FieldByName('NO_APPROVAL_ORG').AsString;
     Cells[GDC_CHAINPL,     RowCount-1] := FieldByName('NO_CHAINPL').AsString;
     Cells[GDC_NO_APPROVAL, RowCount-1] := FieldByName('NO_APPROVAL').AsString;
     Cells[GDC_AMT,         RowCount-1] := IntToStr(FieldByName('AMT_APPROVAL').AsInteger);
     Cells[GDC_TIPAMT,      RowCount-1] := IntToStr(FieldByName('AMT_TIP').AsInteger);
     Cells[GDC_VATAMT,      RowCount-1] := IntToStr(FieldByName('AMT_VAT').AsInteger);
     if aType = 0 then
       Cells[GDC_DCAMT,       RowCount-1] := IntToStr(FieldByName('AMT_DC').AsInteger)
     else
       Cells[GDC_DCAMT,       RowCount-1] := '0';

     Cells[GDC_HALBU,       RowCount-1] := FieldByName('TERM_HALBU').AsString;
     Cells[GDC_VALID,       RowCount-1] := FieldByName('TERM_VALID').AsString;
     Cells[GDC_TYPE_TRD,    RowCount-1] := FieldByName('TYPE_TRD').AsString;
     Cells[GDC_TRD_TIME,    RowCount-1] := FieldByName('TRD_TIME').AsString;
     Cells[GDC_TRD_DATE,    RowCount-1] := FieldByName('TRD_DATE').AsString;
     Cells[GDC_TRD_DATE_ORG,RowCount-1] := FieldByName('TRD_DATE_ORG').AsString;
     Cells[GDC_NAME,        RowCount-1] := FieldByName('NM_CARDPL').AsString;
     Cells[GDC_CD_BUY,      RowCount-1] := FieldByName('CD_CARD_BUY').AsString;
     Cells[GDC_NM_BUY,      RowCount-1] := FieldByName('NM_CARD_BUY').AsString;
     Cells[GDC_REALMODE,    RowCount-1] := FieldByName('REALMODE').AsString;
     Cells[GDC_IMGFILE,     RowCount-1] := FieldByName('IMGFILE').AsString;
     Cells[GDC_NOTE,        RowCount-1] := FieldByName('NOTE_MSG').AsString;
     if aType = 0 then
       Cells[GDC_CORNER,      RowCount-1] := FieldByName('CD_CORNER').AsString;
     if aType = 0 then
       Cells[GDC_DS_DC,       RowCount-1] := FieldByName('DS_DC').AsString
     else
       Cells[GDC_DS_DC,       RowCount-1] := '';
     Cells[GDC_YN_CAN,      RowCount-1] := 'Y';
     Cells[GDC_YN_PRINT,    RowCount-1] := 'Y';
     Cells[GDC_YN_SAVE,     RowCount-1] := 'N';
     if aType=0 then
       Cells[GDC_BALANCEAMT,  RowCount-1] := FieldByName('AMT_BALANCE').AsString;
     if aType = 0 then
       Cells[GDC_YN_UNIONPAY,  RowCount-1] := FieldByName('YN_UNIONPAY').AsString;
     Cells[GDC_YN_CAT,            RowCount-1] := FieldByName('YN_CAT').AsString;
     Cells[GDC_VAN_TID,           RowCount-1] := FieldByName('VAN_TID').AsString;
     if AType <> 1 then
     begin
       Cells[GDC_PG_TID,           RowCount-1] := FieldByName('PG_TID').AsString;
       Cells[GDC_AMT_CANCEL,       RowCount-1] := FieldByName('AMT_CANCEL').AsString;
     end;
     Cells[GDC_TRANSNO,           RowCount-1] := FieldByName('NO_UNIQUE_ORG').AsString;
     Cells[GDC_PAYCODE,           RowCount-1] := FieldByName('PAY_CODE').AsString;
     Cells[GDC_NO_EASYPAY,        RowCount-1] := FieldByName('NO_EASYPAY').AsString;

     vBmp := TBitmap.Create;
//     vStream := TMemoryStream.Create;
     try
       vStream := CreateBLOBStream(FieldByName('SIGN_IMAGE'), bmRead);
       vBmp.LoadFromStream(vStream);
       vBmp.SaveToFile(AppPath+'Sign'+IntToStr(RowCount-1)+'.bmp');
     finally
       vBmp.Free;
       vStream.Free;
     end;

     if aType = 2 then
     begin
       PreSent.CardAmt      := PreSent.CardAmt     + FieldByName('AMT_APPROVAL').AsInteger;
       PreSent.AHeadPayAmt  := PreSent.AHeadPayAmt + FieldByName('AMT_APPROVAL').AsInteger;
       Cells[GDC_YN_AHEAD,   RowCount-1] := 'Y';
       Cells[GDC_YN_SAVE,    RowCount-1] := 'Y';
     end;

     Next;
  end;
end;

procedure TCommon.SetCashSale(aValue:String; aType:Integer);
begin
  if aType = 0 then
    OpenQuery('select * '
             +'  from SL_CASH '
             +' where CD_STORE =:P0 '
             +'   and YMD_SALE =:P1 '
             +'   and NO_POS   =:P2 '
             +'   and NO_RCP   =:P3 '
             +' order by SEQ',
             [Config.StoreCode,
              LeftStr(aValue,8),
              Copy(aValue,9,2),
              RightStr(aValue,4)])
  else
    OpenQuery('select * '
             +'  from SL_CASH_AHEAD '
             +' where CD_STORE =:P0 '
             +'   and NO_TABLE =:P1 '
             +' order by SEQ',
             [Config.StoreCode,
              Table.Number]);

  ClearGrid(Cash_sGrd);
  with Query, Cash_sGrd do
  while not Eof do
  begin
     if Cells[0,0] <> '' then RowCount := RowCount + 1;

     Cells[GDR_DS_TRD,      RowCount-1] := FieldByName('ds_trd').AsString;
     Cells[GDR_DS_KIND,     RowCount-1] := FieldByName('ds_kind').AsString;
     Cells[GDR_DS_TYPE,     RowCount-1] := FieldByName('ds_type').AsString;
     Cells[GDR_DS_INPUT,    RowCount-1] := FieldByName('ds_input').AsString;
     Cells[GDR_CARDNO,      RowCount-1] := FieldByName('no_card').AsString;
     Cells[GDR_FULLCARDNO,  RowCount-1] := FieldByName('no_card').AsString;
     Cells[GDR_NO_APPROVAL, RowCount-1] := FieldByName('no_approval').AsString;
     Cells[GDR_AMT,         RowCount-1] := IntToStr(FieldByName('amt_approval').AsInteger);
     Cells[GDR_VAT,         RowCount-1] := IntToStr(FieldByName('amt_vat').AsInteger);
     Cells[GDR_TRD_DATE,    RowCount-1] := FieldByName('trd_date').AsString;
     Cells[GDR_TRD_DATE_ORG,RowCount-1] := FieldByName('trd_date_org').AsString;
     Cells[GDR_APPROVAL_ORG,RowCount-1] := FieldByName('no_approval_org').AsString;
     Cells[GDR_CORNER,      RowCount-1] := FieldByName('cd_corner').AsString;
     Cells[GDR_VAN_TID,     RowCount-1] := FieldByName('van_tid').AsString;
     Cells[GDR_YN_CAN,      RowCount-1] := 'Y';
     Cells[GDR_YN_PRINT,    RowCount-1] := 'Y';
     Cells[GDR_YN_SAVE,     RowCount-1] := 'N';
     Cells[GDR_FULLCARDNO,  RowCount-1] := FieldByName('no_card_full').AsString;
     Cells[GDR_YN_CAT,      RowCount-1] := FieldByName('yn_cat').AsString;
     if aType = 1 then
     begin
       Cells[GDR_YN_AHEAD,      RowCount-1] := 'Y';
       Cells[GDR_YN_SAVE,       RowCount-1] := 'Y';
       PreSent.CashAmt      := PreSent.CashAmt     + FieldByName('AMT_APPROVAL').AsInteger;
       PreSent.AHeadPayAmt  := PreSent.AHeadPayAmt + FieldByName('AMT_APPROVAL').AsInteger;
     end;
     Next;
  end;
  Query.Close;
end;

function  TCommon.CheckAcctPos(aType:Integer=0):Boolean;  //정산이 가능한포스인지 체크
begin
  //다우 단말기 연동일때는 원인을 알수 없지만 늦음
  if (GetOption(379) <> '1') or (Common.Config.van_trd <> 1) then
    Application.ProcessMessages;
  Result := False;
  if GetUserOption(2) = '0' then
  begin
    if GetOption(172) = '0' then
    begin
      ErrBox('주문만 가능한 사용자입니다');
      Exit;
    end
    else if not Common.CheckAuthority(2) then Exit;
  end;

  if aType = 0 then
    case Common.PosType of
      ptOnlyOrder :
      begin
        ErrBox('정산포스에서만 사용이 가능합니다');
        Exit;
      end;
      ptNotAccount :
      begin
         if Trim(WorkDate) = '' then
         begin
           ErrBox('개점이 안됐습니다'+#13#13+'개점을 해야 사용할 수 있습니다');
           Exit;
         end;
      end;
    end;
  Result := True;
end;

//*************************************************************************//
//                       수량을 중량형이면 g, Kg으로 변화한다
//**************************************************************************//
function  TCommon.GetQtyReplace(aMenuType, aQty:String):String;
begin
  if aMenuType <> 'W' then
    Result := aQty
  else
  begin
    if Abs(StoI(aQty)) >= 1000 then
      Result := FormatFloat('0.##',hRound(StoI(aQty) / 1000, -2))+'k'
    else
      Result := aQty + 'g';
   end;
end;

//**************************************************************************//
//                       고객주문서 총주문내역 출력
// aType (0-일반, 1-정산시, 2-재출력
//**************************************************************************//
procedure TCommon.GetAllCustomerOrder(aType:Integer=0);
var
  vPrSale, vDcSpc, pLen, vQty, vOrderAmt: Integer;
  vCustomerPrinter, vNmMenu, vMemo, vTemp: String;
  vAddVatAmt, vCol :Integer;           //부가세별도 메뉴의 부가세
  vTable, vQtyStr :String;
begin
  if (Common.Config.IsTakeOut) or (aType = 1) then
  begin
    TaxCalculation;
    OrderVatAmt  := Present.TaxAmt;
    OrderDutyAmt := Present.DutyAmt;
    Exit;
  end;

  if Common.Config.PrintColum = 1 then
    pLen := 6
  else
    pLen := 0;

  vCustomerPrinter := CustomerPrinter;
  if aType in [2,3] then
  begin
    if aType = 3 then
    begin
      OpenQuery('select a.NO_TABLE '
               +'  from SL_ORDER_H a inner join '
               +'       MS_TABLE   b on a.CD_STORE = b.CD_STORE and a.NO_TABLE = b.NO_TABLE '
               +' where a.CD_STORE		    =:P0 '
               +'   and b.NO_TABLE_GROUP 	=:P1 '
               +'   and a.DS_ORDER        =:P2 '
               +'   and b.NO_TABLE 	<> b.NO_TABLE_GROUP  '
               +'   and b.NO_TABLE not in (select NO_TABLE '
               +'                            from SL_SALE_H '
               +'                           where CD_STORE = b.CD_STORE '
               +'                             and DS_SALE = ''M'') ',
               [Config.StoreCode,
                Table.Number,
                Table.OrderType]);
      vTable := Format('%d,',[Table.Number]);
      while not Query.eof do
      begin
        vTable := vTable + Format('%d,',[Query.Fields[0].AsInteger]);
        Query.Next;
      end;
      vTable := Format(' in (%s) ',[LeftStr(vTable, Length(vTable)-1)]);
    end
    else vTable := Format(' = %d ', [Table.Number]);

  end
  else
  begin
    OpenQuery('select AMT_DC, '
             +'       AMT_CODEDC '
             +'  from SL_ORDER_H '
             +' where CD_STORE = :P0 '
             +'   and NO_TABLE = :P1 '
             +'   and DS_ORDER = :P2 ',
             [Config.StoreCode,
              Table.Number,
              Table.OrderType]);
    PreSent.RcpDc   := Query.Fields[0].AsInteger;
    PreSent.CodeDc  := Query.Fields[1].AsInteger;
    PreSent.TotalDC := PreSent.RcpDc + PreSent.CodeDc;
    vTable := Format(' = %d ', [Table.Number]);
  end;

  OpenQuery('select a.*, '
           +'       b.CD_CORNER, '
           +'       Substring(b.CONFIG,3,1) as YN_RCP, '
           +'       Substring(b.CONFIG,5,1) as YN_BILL '
           +'  from SL_ORDER_D a left outer join '
           +'       MS_MENU    b on b.CD_STORE = a.CD_STORE and b.CD_MENU = a.CD_MENU '
           +' where a.CD_STORE = :P0 '
           +'   and a.NO_TABLE '+vTable
           +'   and a.DS_ORDER = :P1 '
           +' order by a.ORDERSEQ ',
           [Config.StoreCode,
            Table.OrderType]);

  case Common.OrderKind of
    okNew    : CustomerPrinter := EmptyStr;
    okAppend :
    begin
      CustomerPrinter := CustomerPrinter +  Space(42)+#13
                        + '               최종주문내역               '+#13
                        + rptOneLine+#13;
    end;
  end;
  OrderAmt         := 0;
  OrderVatAmt      := 0;
  OrderDutyAmt     := 0;
  OrderDutyFreeAmt := 0;
  OrderTipAmt      := 0;
  vAddVatAmt       := 0;
  Present.SpcDc    := 0;
  if GetOption(152) = '2' then CustomerPrinter := EmptyStr;

  while not Query.Eof do
  begin
    vCustomerPrinter := '';
    if (Query.FieldByName('YN_RCP').AsString = 'Y') and (Query.FieldByName('YN_BILL').AsString = 'Y') then
    begin
      //푸드코트 사용 시 코너별로 주문서를 출력할때
      if (GetOption(231) = '1') and (GetOption(233) = '1') then
         vCustomerPrinter := EmptyStr;

      if Query.FieldByName('CD_MENU1').AsString = '' then
      begin
        vTemp   := '';
        vNmMenu := Query.FieldByName('NM_MENU').AsString;
        vMemo   := Query.FieldByName('Memo').AsString;
        if (GetOption(161) = '1') then
          vNmMenu := vNmMenu + vMemo;

        if GetOption(409) = '0' then
        begin
          //고객주문서에 주방메모를 출력합니다.
          vTemp := RPadB(vTemp+vNmMenu,27+pLen,' ');
          vCustomerPrinter := vCustomerPrinter + vTemp;
        end
        else
        begin
          if (Query.FieldByName('DS_SALE').AsString = 'D') and (Pos(Common.Config.ServiceTxt,vNmMenu)=0) then
            vNmMenu := vNmMenu + Common.Config.ServiceTxt;

          //고객주문서에 주방메모를 출력합니다.
          vTemp := RPadB(vTemp+vNmMenu,37+pLen,' ');
          vCustomerPrinter := vCustomerPrinter + vTemp;
        end;
      end
      else
      begin
        if GetOption(338) = '1' then
        begin
          Query.Next;
          Continue;
        end;

        if (Query.FieldByName('NO_STEP').AsInteger = 0) or
           (Query.FieldByName('DS_MENU_TYPE').AsString = 'I') or
           (Query.FieldByName('DS_MENU_TYPE').AsString = 'C') or
           (Query.FieldByName('DS_MENU_TYPE').AsString = 'O') then
          vCustomerPrinter := vCustomerPrinter + RPadB('  - '+Query.FieldByName('NM_MENU').AsString,27+pLen,' ')
        else
          vCustomerPrinter := vCustomerPrinter + RPad('  '+Query.FieldByName('NO_STEP').AsString+' '+Query.FieldByName('NM_MENU').AsString,27+pLen,' ')
      end;

      //행사할인
      if Query.FieldByName('CD_MENU1').AsString = '' then
        vDcSpc := Query.FieldByName('DC_SPC').AsInteger *  Query.FieldByName('QTY_ORDER').AsInteger
      else
        vDcSpc := 0;

      Present.SpcDc := Present.SpcDc + vDcSpc;

      if Query.FieldByName('DS_MENU_TYPE').AsString = 'W' then vQty := 1
      else vQty := Query.FieldByName('QTY_ORDER').AsInteger;

      vOrderAmt := Query.FieldByName('PR_SALE').AsInteger * vQty;

      //부가세별도 메뉴일때 부가세를 제외할때 단가에서 부가세를 뺀다
      if (GetOption(224) = '1') and (Query.FieldByName('DS_TAX').AsString = '2') then
      begin
        vPrSale := FtoI(vOrderAmt /1.1);
        vAddVatAmt := vAddVatAmt + vOrderAmt - vPrSale;
      end
      else
        vPrSale := vOrderAmt;

      vQtyStr := GetQtyReplace(Query.FieldByName('DS_MENU_TYPE').AsString, Query.FieldByName('QTY_ORDER').AsString);

      if Query.FieldByName('ds_sale').AsString = 'D' then
        vCustomerPrinter := vCustomerPrinter + Common.Config.ServiceTxt;

      //메뉴금액 출력
      if GetOption(409)='0' then
        vCustomerPrinter := RPadB(vCustomerPrinter,27+pLen,' ')+LPadB(vQtyStr,5,' ') + LPadB(FormatFloat('#,0', vPrSale),10,' ')+#13
      else
      begin
        //가로세로확대
        if GetOption(113) = '3' then
          vCustomerPrinter := RPadB(vCustomerPrinter,17+pLen,' ')+LPadB(vQtyStr,4,' ') + #13
        else
          vCustomerPrinter := RPadB(vCustomerPrinter,37+pLen,' ')+LPadB(vQtyStr,5,' ') + #13;
      end;

//      if (GetOption(161) = '1') and (vMemo <> '') then
//        vCustomerPrinter := vCustomerPrinter + vMemo + #13;

      if GetOption(114) = '1' then
        vCustomerPrinter := vCustomerPrinter + #13;

      //코스에 부메뉴 단가를 사용할때는 부메뉴는 제외한다 마스터에 이미 반영되어 있음
//      if not ((GetOption(23) = '1') and (Query.FieldByName('DS_MENU_TYPE').AsString = 'C') and (Query.FieldByName('CD_MENU1').AsString <> '')) then
        OrderAmt := OrderAmt + vOrderAmt - vDcSpc;

      //면세금액
        if Query.FieldByName('DS_TAX').AsString = '0' then
          OrderDutyFreeAmt := OrderDutyFreeAmt + vOrderAmt - (Query.FieldByName('DC_MENU').AsInteger*vQty) - (Query.FieldByName('PR_TIP').AsInteger*vQty) - vDcSpc
        else
          OrderDutyAmt := OrderDutyAmt + vOrderAmt  - (Query.FieldByName('DC_MENU').AsInteger*vQty) - (Query.FieldByName('PR_TIP').AsInteger*vQty) - vDcSpc;

        OrderTipAmt := OrderTipAmt + (Query.FieldByName('PR_TIP').AsInteger * vQty);
        PreSent.TotalDC := PreSent.TotalDC + vDcSpc;
    end; //if Query.FieldByName('yn_rcp').AsString = 'Y' then
    CustomerPrinter := CustomerPrinter + vCustomerPrinter;

    Query.Next;
  end;
  //부가세금액
  OrderVatAmt  := FtoI(hTrunc( OrderDutyAmt / 11 ,1)) ;
  //공급가금액
  OrderDutyAmt := OrderDutyAmt - OrderVatAmt;

  //고객주문서에 부가세를 출력하지 않고 최종주문서만 출력할때는 총금액에서 부가세별도금액을 뺀다
  if (GetOption(52) = '0') and (GetOption(152) = '2') then
    OrderAmt := OrderAmt - vAddVatAmt;

  //고객주문서 마지막주문내역을 출력한다고 했으면 최종출력내역을 지운다
  if (GetOption(152) = '1') and (aType < 2) then
    CustomerPrinter := vCustomerPrinter;
end;

procedure TCommon.LogoCreate(aForm:TControl; aToolBar:Integer);
  function CreateControl(aClass :TControlClass; aOwner:TControl; aName:String): TControl;
  begin
    Result        := aClass.Create(AOwner);
    Result.Parent := TWinControl(aOwner);
    Result.Name   := aName;
  end;
begin
  if aToolBar > 0 then
  begin
    if (aToolBar <> 3) and FileExists(Common.AppPath+'dll\Logo.png') then
    begin
      with CreateControl(TImage, aForm, 'Logo') do
      begin
        Top     := 5;
        Left    := 5;
        Height  := 45;
        Width   := 117;
        BringToFront;
      end;
      with aForm do
      begin
        TImage(FindComponent('Logo')).picture.LoadFromFile(AppPath+'dll\Logo.png');
      end;
    end;


    with CreateControl(TAdvShape, aForm, 'FormHeaderLine') do
    begin
      Align   := alNone;
      Top     := 0;
      Left    := 0;
      Height  := 53;
      Width   := aForm.Width+1;
      SendToBack;
    end;

    with aForm do
    begin
      if (Config.Style = 'B') or Config.IsKiosk then
      begin
        TAdvShape(FindComponent('FormHeaderLine')).Appearance.Color     := $00934900;
        TAdvShape(FindComponent('FormHeaderLine')).Appearance.ColorTo   := $00482400;
      end
      else
      begin
        TAdvShape(FindComponent('FormHeaderLine')).Appearance.Color     := $002D2D2D;
        TAdvShape(FindComponent('FormHeaderLine')).Appearance.ColorTo   := $002D2D2D;
      end;
      TAdvShape(FindComponent('FormHeaderLine')).Appearance.Direction := AdvShape.TGradientDirection.gdVertical;
      TAdvShape(FindComponent('FormHeaderLine')).ShapeHeight          := 53;
      TAdvShape(FindComponent('FormHeaderLine')).ShapeWidth           := aForm.Width;
    end;
  end;

  if aToolBar = 2 then
  begin
    with CreateControl(TAdvShape, aForm, 'FormBottomLine') do
    begin
      Align   := alNone;
      Top     := aForm.Height-52;
      Left    := 0;
      Height  := 51;
      Width   := aForm.Width+1;

      SendToBack;
    end;
    with aForm do
    begin
      if (Config.Style = 'B') or Config.IsKiosk then
      begin
        TAdvShape(FindComponent('FormBottomLine')).Appearance.Color     := $00603000;
        TAdvShape(FindComponent('FormBottomLine')).Appearance.ColorTo   := $00793D00;
      end
      else
      begin
        TAdvShape(FindComponent('FormBottomLine')).Appearance.Color     := $002D2D2D;
        TAdvShape(FindComponent('FormBottomLine')).Appearance.ColorTo   := $002D2D2D;
      end;
      TAdvShape(FindComponent('FormBottomLine')).Appearance.Direction := AdvShape.TGradientDirection.gdVertical;
      TAdvShape(FindComponent('FormBottomLine')).ShapeHeight          := 53;
      TAdvShape(FindComponent('FormBottomLine')).ShapeWidth           := aForm.Width;
    end;
  end;

  with CreateControl(TShape, aForm, 'FormOutLine') do
  begin
    //이폼만 적용이 안됨 //이유를 모르겠음
    if aForm.Name = 'DualOrder_F' then
    begin
      Top   := 53;
      Left  := 0;
      Width := 1020;
      Height := 768 - 103;
    end
    else if aForm.Name = 'DualOrder800_F' then
    begin
      Top   := 53;
      Left  := 0;
      Width := 796;
      Height := 600 - 103;
    end
    else
      Align   := alClient;
    SendToBack;
  end;

  with aForm do
  begin
    TShape(FindComponent('FormOutLine')).Brush.Style := bsClear;
    TShape(FindComponent('FormOutLine')).Brush.Color := $00FAFAFA;//clWhite;
    if (aForm.Name = 'NumPan_F') or Config.IsKiosk then
      TShape(FindComponent('FormOutLine')).Pen.Width := 2
    else
      TShape(FindComponent('FormOutLine')).Pen.Width := 5;

    if (LeftStr(aForm.Name,5) = 'Kiosk') and (GetOption(458) = '2') then
      TShape(FindComponent('FormOutLine')).Pen.Color := clBlack
    else if (LeftStr(aForm.Name,5) = 'Kiosk') and (GetOption(458) = '3') then
      TShape(FindComponent('FormOutLine')).Pen.Color := $000000CC
    else if (LeftStr(aForm.Name,5) = 'Kiosk') and (GetOption(458) = '4') then
      TShape(FindComponent('FormOutLine')).Pen.Color := $00009900
    else
    begin
      if (Config.Style = 'B') or Config.IsKiosk then
        TShape(FindComponent('FormOutLine')).Pen.Color := $00603000
      else
        TShape(FindComponent('FormOutLine')).Pen.Color := clBlack;
    end;
  end;
end;

procedure TCommon.LogoClick(Sender: TObject);
var
  vShellExecuteInfo: TShellExecuteInfo;
begin
  FillChar(vShellExecuteInfo, Sizeof(vShellExecuteInfo), 0);
  with vShellExecuteInfo do
  begin
    cbSize       := Sizeof(vShellExecuteInfo);
    fMask        := SEE_MASK_NOCLOSEPROCESS or SEE_MASK_FLAG_DDEWAIT;
    wnd          := GetActiveWindow;
    lpVerb       := 'open';
    lpFile       := PChar('explorer.exe');
    lpParameters := PChar('shell:::{3080F90D-D7AD-11D9-BD98-0000947B0257}');
    nShow        := SW_HIDE;
  end;
  // 프로그램을 실행한다
  ShellExecuteEx(@vShellExecuteInfo);
end;


procedure TCommon.SetLanguage(aForm:TControl);
var vIndex :Integer;
begin
  with aForm do
  begin
    if (Hint = Config.PosLanguage) or ((GetHeadOption(14)='0') and not Config.IsKiosk) or (Config.PosLanguage = 'KO') then
      Exit;

    For vIndex := 0 to ComponentCount-1 do
    begin
      if (Components[vIndex] is TcxButton) and (Components[vIndex] as TcxButton).Visible then
        (Components[vIndex] as TcxButton).Caption := Common.GetPaPago((Components[vIndex] as TcxButton).Caption)
      else if (Components[vIndex] is TLabel) and ((Components[vIndex] as TLabel).HelpKeyword = 'C') then
        (Components[vIndex] as TLabel).Caption := Common.GetPaPago((Components[vIndex] as TLabel).Caption)
      else if (Components[vIndex] is TcxLabel) and ((Components[vIndex] as TcxLabel).HelpKeyword = 'C') then
        (Components[vIndex] as TcxLabel).Caption := Common.GetPaPago((Components[vIndex] as TcxLabel).Caption)
      else if (Components[vIndex] is TcxCheckBox) and (Components[vIndex] as TcxCheckBox).Visible then
        (Components[vIndex] as TcxCheckBox).Caption := Common.GetPaPago((Components[vIndex] as TcxCheckBox).Caption)
      else if (Components[vIndex] is TAdvTabSheet) then
        (Components[vIndex] as TAdvTabSheet).Caption := Common.GetPaPago((Components[vIndex] as TAdvTabSheet).Caption)
      else if (Components[vIndex] is TAdvSmoothToggleButton) and ((Components[vIndex] as TAdvSmoothToggleButton).HelpKeyword = 'C') then
        (Components[vIndex] as TAdvSmoothToggleButton).Caption := Common.GetPaPago((Components[vIndex] as TAdvSmoothToggleButton).Caption)
      else if (Components[vIndex] is TAdvGlassButton) and ((Components[vIndex] as TAdvGlassButton).HelpKeyword = 'C') then
        (Components[vIndex] as TAdvGlassButton).Caption := Common.GetPaPago((Components[vIndex] as TAdvGlassButton).Caption)
      else if (Components[vIndex] is TcxGroupBox) and (Components[vIndex] as TcxGroupBox).Visible then
        (Components[vIndex] as TcxGroupBox).Caption := Common.GetPaPago((Components[vIndex] as TcxGroupBox).Caption);

      Hint := Config.PosLanguage;
    end;
  end;
end;

procedure TCommon.DbConnect;
begin
  if DBConnectError then
  begin
    DM.UniConnection.Disconnect;
    DM.UniConnection.Connect;
    DBConnectError := False;
  end;
end;

function TCommon.GetCustomerAgeCount(aValue:String):Integer;
var vIndex :Integer;
begin
  Result := 0;
  For vIndex := 0 to Table.AgeCode.Count-1 do
  begin
    if Copy(Table.AgeCode.Strings[vIndex] ,1,3) = aValue then
    begin
      Result := StrToIntDef( Copy(Table.AgeCode.Strings[vIndex],4,3 ),0 );
      Break;
    end;
  end;

  Table.CustomerCount := 0;
  For vIndex := 0 to Table.AgeCode.Count-1 do
    Table.CustomerCount := Table.CustomerCount + StrToIntDef( Copy(Table.AgeCode.Strings[vIndex],4,3),0 );

end;

//**************************************************************************//
//                       연령대 셋팅
//**************************************************************************//
procedure TCommon.SetCustomerAgeCount(aValue:String);
var vIndex, vTemp :Integer;
begin
  vTemp := -1;
  For vIndex := 0 to Table.AgeCode.Count-1 do
  begin
    if Copy(Table.AgeCode.Strings[vIndex],1,3) = Copy(aValue,1,3) then
    begin
      Table.AgeCode.Strings[vIndex] := aValue;
      vTemp := vIndex;
      Break;
    end;
  end;

  if vTemp = -1 then Table.AgeCode.Add(aValue);

  Table.CustomerCount := 0;
  For vIndex := 0 to Table.AgeCode.Count-1 do
    Table.CustomerCount := Table.CustomerCount + StrToIntDef( Copy(Table.AgeCode.Strings[vIndex],4,3),0 );

end;

procedure TCommon.SetAgeInfo(aValue:String);
var vIndex :Integer;
begin
  Table.AgeCode.Clear;
  if (aValue = '') and ((GetOption(14) = '0') or (GetOption(14) = '1')) then
  begin
    Table.AgeCode.Add('00100');
    Exit;
  end;

  for vIndex:=0 to AgeData.Count-1 do
    Table.AgeCode.Add( AgeData.Strings[vIndex] );

  while Trim(aValue) <> '' do
  begin
     vIndex := Pos(',',aValue);
     if vIndex > 0 then begin
        SetCustomerAgeCount( Copy(aValue,1,vIndex-1) );
        Delete(aValue,1,vIndex);
     end
     else
     begin
        SetCustomerAgeCount( aValue );
        aValue :='';
     end;
  end;
end;

function TCommon.GetAgePerson(aTable:TTable):String;
var vIndex :Integer;
begin
  Result := '';
  For vIndex := 0 to aTable.AgeCode.Count-1 do
  begin
    if Copy(aTable.AgeCode.Strings[vIndex],4,3) = '000' then Continue;
    OpenQuery('select NM_CODE1 '
             +'  from MS_CODE '
             +' where CD_STORE =:P0 '
             +'   and CD_KIND  =''14'' '
             +'   and CD_CODE  =:P1',
             [Config.StoreCode,
              LeftStr(aTable.AgeCode.Strings[vIndex],3)]);
    if not Query.Eof then
      Result := Result + Query.Fields[0].AsString+'-'+ IntToStr(StoI(Copy(aTable.AgeCode.Strings[vIndex],4,3)))+'명,';
  end;
  Query.Close;
  if Result <> '' then
    Result := Copy(Result, 1, Length(Result)-1)
  else
    Result := IntToStr(Common.Table.CustomerCount)+' 명';
end;

function TCommon.DemonCheck(aHost,aData:String; aPort:Integer):Boolean;
var ReadData :String;
begin
  if (aHost = 'www.expos.co.kr') or IsDebuggerPresent then Exit;

  with TIdTCPClient.Create(Application) do
  begin
    try
       try
         Result := True;
         Host   := aHost;
         Port   := aPort;
         ConnectTimeout := 1000;
         Connect;
         if aData = '' then Exit;
         Socket.WriteLnRFC(aData + #3, IndyTextEncoding_OSDefault);
         ReadData := Socket.ReadLn(#3,IndyTextEncoding_OSDefault);
         if aData = 'DBCHECK' then
           Result := ReadData = 'TRUE'
         else if aData = 'CHECK' then
           Result := ReadData = 'OK';
       except
         on E: Exception do
         begin
           Result := False;
           WriteLog('DemonCheck','서버데몬 연결실패('+aData+')!!! '+E.Message);
           if aData <> '00' then Exit;
           ErrBox('서버에 데몬이 실행되지 않았습니다'+#13+#13+
                  '서버에 데몬 프로그램을 실행하세요');
         end;
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

//**************************************************************************//
//                       카드승인정보 그리드에서 레크드로 이동
//**************************************************************************//
procedure TCommon.CardInfoLoad(aRow:Integer);
begin
  InitCardRecord(Common.Card);
  with Card_sGrd, Card do
  begin
    Ds_Card       :=   Cells[GDC_DS_CARD       ,aRow] ; //카드구분
    Ds_Trd        :=   Cells[GDC_DS_TRD       ,aRow] ;  //거래구분(승인=dtApproval, 취소=dtCancel)
    Nm_Card       :=   Cells[GDC_NAME         ,aRow] ;  //카드명(발급사)
    Cd_buy        :=   Cells[GDC_CD_BUY       ,aRow] ;  //매입사코드
    Nm_buy        :=   Cells[GDC_NM_BUY       ,aRow] ;  //매입사명
    CardNo        :=   Cells[GDC_CARDNO       ,aRow] ;  //카드번호
    Halbu         :=   Cells[GDC_HALBU        ,aRow] ;  //할부개월수
    Amt           :=   StoI(Cells[GDC_AMT     ,aRow]);  //금액
    TipAmt        :=   StoI(Cells[GDC_TIPAMT  ,aRow]);  //금액
    VatAmt        :=   StoI(Cells[GDC_VATAMT  ,aRow]);  //부가세
    DcAmt         :=   StoI(Cells[GDC_DCAMT   ,aRow]);  //부가세
    Valid         :=   Cells[GDC_VALID        ,aRow] ;  //카드유효기간
    ChainPl       :=   Cells[GDC_CHAINPL      ,aRow] ;  //가맹점번호
    ApprovalNo   :=   '' ;                             //승인번호
    OrgApprovalNo  :=   Cells[GDC_NO_APPROVAL  ,aRow] ;  //당초매출시 승인번호
    Trd_Time      :=   Cells[GDC_TRD_TIME     ,aRow] ;  //매출시간
    Trd_Date      :=   Cells[GDC_TRD_DATE     ,aRow] ;  //매출일자
    Trd_Date_Org  :=   Copy(Cells[GDC_TRD_DATE,aRow],3, 6) ;  //원매출일자(6자리)
    Type_Trd      :=   Cells[GDC_TYPE_TRD     ,aRow] ;  //거래형태
    RealMode      :=   Cells[GDC_REALMODE     ,aRow] = 'TRUE' ;  //승인모드
    imgFile       :=   Cells[GDC_IMGFILE      ,aRow];   //전자서명이미지화일명
    SendData      :=   '' ;                             //송신데이터
    RecvData      :=   '' ;                             //응답데이터
    Note          :=   Cells[GDC_NOTE         ,aRow];
    SignFile      :=   Cells[GDC_SIGNFILE      ,aRow];
    Corner        :=   Cells[GDC_CORNER        ,aRow];
    DsDc          :=   Cells[GDC_DS_DC         ,aRow];
    BalanceAmt    :=   Cells[GDC_BALANCEAMT    ,aRow];
    Yn_UnionPay   :=   Cells[GDC_YN_UNIONPAY   ,aRow];
    Yn_Cat        :=   Cells[GDC_YN_CAT        ,aRow];
    VanTid        :=   Cells[GDC_VAN_TID       ,aRow];
    PG_TID        :=   Cells[GDC_PG_TID        ,aRow];
    CancelAmt     :=   StoI(Cells[GDC_AMT_CANCEL, aRow]);  //금액
    OrgTableNo    :=   StoI(Cells[GDC_ORG_TABLENO, aRow]);
    TransNo       :=   Cells[GDC_TRANSNO,     aRow];
    PayCode       :=   Cells[GDC_PAYCODE,     aRow];
    EasyPayNo     :=   Cells[GDC_NO_EASYPAY,  aRow];
  end;
end;

//**************************************************************************//
//                         카드승인정보 그리드에 저장
//**************************************************************************//
procedure TCommon.CardInfoSave(aType:Integer=0);
var vIndex :Integer;
begin
  with Card_sGrd, Card do
  begin
    if Cells[0,0] <> '' then RowCount := RowCount + 1;
    Cells[GDC_DS_CARD      ,RowCount-1] := Trim(Ds_Card);         //카드구분
    Cells[GDC_DS_TRD       ,RowCount-1] := Trim(Ds_trd);          //거래구분(승인=dtApproval, 취소=dtCancel)
    Cells[GDC_NAME         ,RowCount-1] := Trim(Nm_Card);         //카드명(발급사)
    Cells[GDC_CD_BUY       ,RowCount-1] := Trim(Cd_buy);          //매입사코드
    Cells[GDC_NM_BUY       ,RowCount-1] := Trim(nm_buy);          //매입사명
    Cells[GDC_CARDNO       ,RowCount-1] := Trim(CardNo);          //카드번호
    Cells[GDC_HALBU        ,RowCount-1] := Trim(Halbu);           //할부개월수
    Cells[GDC_AMT          ,RowCount-1] := FtoS(Amt);             //금액
    Cells[GDC_TIPAMT       ,RowCount-1] := FtoS(TipAmt);          //봉사료금액
    Cells[GDC_VATAMT       ,RowCount-1] := FtoS(VatAmt);          //부가세금액
    Cells[GDC_DCAMT        ,RowCount-1] := FtoS(DcAmt);           //할인금액
    Cells[GDC_VALID        ,RowCount-1] := GetOnlyNumber(Trim(Valid));           //카드유효기간
    if (Ds_trd = dtApproval) and (Type_Trd = atCat) and ( Trim(ApprovalNo) = '') then
      Cells[GDC_NO_APPROVAL  ,RowCount-1] := FormatDateTime('yymmddhhnnss', now())
    else
      Cells[GDC_NO_APPROVAL  ,RowCount-1] := Trim(ApprovalNo);     //승인번호
    Cells[GDC_APPROVAL_ORG ,RowCount-1] := Trim(OrgApprovalNo);    //당초매출시 승인번호
    Cells[GDC_TRD_TIME     ,RowCount-1] := Trim(Trd_Time);        //승인시간
    Cells[GDC_TRD_DATE     ,RowCount-1] := Trim(Trd_Date);        //승인일자
    Cells[GDC_TRD_DATE_ORG ,RowCount-1] := Trim(Trd_Date_org);    //당초매출시 승인일자
    Cells[GDC_CHAINPL      ,RowCount-1] := Trim(ChainPL);         //가맹점코드
    Cells[GDC_SENDLOG      ,RowCount-1] := Trim(SendData);        //송신데이터
    Cells[GDC_RECVLOG      ,RowCount-1] := Trim(RecvData);        //응답데이터
    Cells[GDC_TYPE_TRD     ,RowCount-1] := Trim(Type_Trd);        //거래형태
    if RealMode then                                              //승인모드
      Cells[GDC_REALMODE     ,RowCount-1] := 'TRUE'
    else
      Cells[GDC_REALMODE     ,RowCount-1] := 'FALSE';
    Cells[GDC_IMGFILE      ,RowCount-1] := Trim(ImgFile);         //전자서명이미지화일명
    Cells[GDC_NOTE         ,RowCount-1] := Trim(Note);
    Cells[GDC_YN_CAN       ,RowCount-1] := Trim(Yn_Can);          //취소여부
    if Present.DutchPayAmt > 0 then
      Cells[GDC_YN_PRINT     ,RowCount-1] := 'N'       //출력여부
    else
      Cells[GDC_YN_PRINT     ,RowCount-1] := Trim(Yn_Print);      //출력여부
    Cells[GDC_YN_SAVE      ,RowCount-1] := Trim(Yn_save);         //저장여부
    Cells[GDC_SIGNFILE     ,RowCount-1] := '';                    //화일명
    Cells[GDC_CORNER       ,RowCount-1] := Corner;                //코너코드
    Cells[GDC_DS_DC        ,RowCount-1] := DsDC;                  //할인구분
    Cells[GDC_BALANCEAMT   ,RowCount-1] := BalanceAmt;            //잔액
    Cells[GDC_YN_UNIONPAY  ,RowCount-1] := Yn_UnionPay;           //은련카드
    Cells[GDC_YN_CAT       ,RowCount-1] := Yn_Cat;
    Cells[GDC_VAN_TID      ,RowCount-1] := VanTid;
    Cells[GDC_PG_TID       ,RowCount-1] := PG_TID;
    Cells[GDC_AMT_CANCEL   ,RowCount-1] := IntToStr(CancelAmt);
    Cells[GDC_ORG_TABLENO  ,RowCount-1] := IntToStr(OrgTableNo);
    Cells[GDC_TRANSNO      ,RowCount-1] := TransNo;
    Cells[GDC_PAYCODE      ,RowCount-1] := PayCode;
    Cells[GDC_NO_EASYPAY   ,RowCount-1] := EasyPayNo;

    if aType = 2 then
       Cells[GDC_YN_AHEAD       ,RowCount-1] := 'Y';
    vIndex := RowCount-1;
  end;

  //Lets Order
  if aType = 2 then Exit;

  //전자서명을 했으면 고객용부터 출력한다
  if (Card.ImgFile <> '') then
  begin
    while FileExists(AppPath+'sign'+IntToStr(vIndex)+'.bmp') do
      DeleteFile(AppPath+'sign'+IntToStr(vIndex)+'.bmp');
    if FileExists(AppPath+'sign.bmp') then
      RenameFile(AppPath+'sign.bmp', AppPath+'sign'+IntToStr(vIndex)+'.bmp');

    Card_sGrd.Cells[GDC_SIGNFILE, vIndex] :=AppPath+'sign'+IntToStr(vIndex)+'.bmp';
  end;


  //출납에서 신용카드를 사용할때는 고객용을 출력한다
  if CashBookCard then
  begin
    if (Card.Type_Trd <> atCAT) and Common.AskBox('전표를 출력하시겠습니까?') then
      Device.CreditPrint;

    Exit;
  end;

  //승인즉시 출력인데 카드 한건이면 영수증하고 같이 출력한다
  if (Common.CardPrintMode = cpmAtOnce) and (Present.CardAmt=0) and (Common.SplitPrintMode = spmOnePage) then
  begin
    if ((Card.Ds_Trd=dtApproval) and (Present.WRcvAmt=Card.Amt)) or ((Card.Ds_Trd=dtCancel) and (Present.OrgCardAmt = Present.CardCancelAmt)) then
      Exit;
  end;

  //승인즉시 출력한다고 체크했을때  또는 출납부 카드
  if ((Common.CardPrintMode = cpmAtOnce) or (aType = 1)) and not Config.IsKiosk then
  begin
    try
      //신용카드 전표를 출력합니다
      if (Card.Type_Trd = atSwipe) or (Card.Type_Trd = atCat) then
      begin
        case OrderKind of
          okNone, okNew, okAppend : if RealPrintMode <> pmReprint then GetReceiptNo;
        end;
        //전자서명 사용 시 전표를 출력하지 않습니다
//        if (GetOption(165) = '0') and ((Card.ImgFile = '') or (Card.Yn_NoCVM = 'N')) then
//        begin
          //카드전표 출력 시 출력여부를 확인합니다
          if (GetOption(407) = '1') and not Common.Config.IsKiosk and (Card.Halbu = '00') then
          begin
            if Common.Config.SmartPad then
            begin
              if Common.Device.SendToPad(#2+'ask'
                                        +#2+'1'
                                        +#2+'영수증을 출력하시겠습니까?'
                                        +#2+'예'
                                        +#2+'아니오'
                                        +#2+'180') then
                 if not Common.AskBox('영수증을 출력하시겠습니까?') then
                   Exit;
            end
            else if not Common.AskBox('영수증을 출력하시겠습니까?') then
              Exit;
          end;
          Device.CreditPrint;
//        end;
      end;
    except
    end;
  end;
end;

//**************************************************************************//
//                           신용카드폼 호출
//**************************************************************************//
function TCommon.ShowCardForm(aEasyPay, aApproval:Boolean;aAmount:Integer):Boolean;
var vCount :Integer;
begin
  DoModalReset;
  if not CashBookCard then
    TaxCalculation;

  //사용중에 알수없는 이유로 밴정보가 지워졌을때
  if (GetOption(60)='0') and (Config.van_trd = 8) and (Trim(Config.van_Terid) = '')  then
  begin
    OpenQuery('select NM_CODE5, '
             +'       NM_CODE6, '
             +'       NM_CODE9, '
             +'       NM_CODE10, '
             +'       NM_CODE12, '
             +'       NM_CODE18, '
             +'       NM_CODE19 '
             +'  from MS_CODE '
             +' where CD_STORE =:P0 '
             +'   and CD_KIND  =''01'' '
             +'   and NM_CODE1 =:P1 ',
             [Config.StoreCode,
              Config.PosNo]);

    if not Query.Eof then
    begin
      Config.van_trd       := StrToIntDef(Query.FieldByName('NM_CODE5').AsString,0);
      Config.van_Terid     := Trim(Query.FieldByName('NM_CODE6').AsString);
      Config.BizNo         := GetOnlyNumber(Query.FieldByName('NM_CODE9').AsString);
      Config.SerialNo      := Query.FieldByName('NM_CODE10').AsString;
      Config.VanEasyPay    := Query.FieldByName('NM_CODE18').AsString;
      Config.VanWorkingKey := Query.FieldByName('NM_CODE19').AsString;

      ICCard.TerminalID       := Config.van_Terid;
      ICCard.SerialNo         := Config.SerialNo;
      ICCard.RealMode         := Config.van_Terid <> 'cardtest';
      ICCard.BizNo            := Config.BizNo;
      ICCard.PosVer           := GetFileVersion(Application.ExeName);
      ICCard.LogPath          := AppPath;
    end;
    Query.Close;
  end;


  //다중매장일때 대상매장 확인
  if (GetOption(60)='1') and ((PreSent.RcvAmt = 0) and aApproval and not aEasyPay) then
  begin
    vCount := SetCornerAmt;
    if (vCount = 0) and (High(Corner) > 0) then
    begin
      Config.van_Terid := Corner[0].VanTID;
      Config.SerialNo  := Corner[0].VanSerial;
      Config.BizNo     := GetOnlyNumber(Corner[0].BizNo);
    end;
  end;

  if (vCount <= 1) or (GetOption(60)='0') or (Common.PreSent.RcvAmt <> 0) or not aApproval or aEasyPay then
  begin
    Card_F := TCard_F.Create(Application);
    if Assigned(Order_F) and Assigned(Card_F) then
      Card_F.MsrData := Order_F.FCardData;

    if aEasyPay then
      Card_F.MsrData := 'EasyPay';

    Common.PreSent.CardSeq := Common.PreSent.CardSeq +1;
    if aApproval then
      Common.Card.Ds_Trd := dtApproval
    else
      Common.Card.Ds_Trd := dtCancel;

    try
      Card_F.CashToAmount := aAmount;
      if Card_F.ShowModal = mrOk then
      begin
        Result := True;
        Common.WriteLog('work', '신용카드완료');
      end
      else Result := False;
    finally
      Card_F.CashToAmount := 0;
      FreeAndNil(Card_F);
       if Assigned(Order_F) then
         Order_F.FCardData := EmptyStr;
    end;
  end
  else
  begin
    if Common.PreSent.WRcvAmt <= 0 then
    begin
      MsgBox('받을금액이 없습니다');
      Exit;
    end;
    MultiCard_F := TMultiCard_F.Create(Application);

    Card.Ds_Trd := dtApproval;

    try
       if MultiCard_F.ShowModal = mrOk then Result := True
       else                                 Result := False;
       Application.ProcessMessages;
    finally
       FreeAndNil(MultiCard_F);
       if Assigned(Order_F) then
         Order_F.FCardData := EmptyStr;
    end;
  end;
end;

//**************************************************************************//
//                       현금영수증승인정보 그리드에서 레크드로 이동
//**************************************************************************//
procedure TCommon.CashRcpInfoLoad(pRow:Integer);
begin
  InitCashRcpRecord(Common.CashRcp);
  with Cash_sGrd, CashRcp do
  begin
     Ds_Trd          :=   Cells[GDR_DS_TRD        ,pRow] ;  //거래구분(승인=dtApproval, 취소=dtCancel)
     Ds_Kind         :=   Cells[GDR_DS_KIND       ,pRow] ;  //거래유형(0:개인, 1:사업자)
     Ds_Type         :=   Cells[GDR_DS_TYPE       ,pRow] ;  //승인유형(0:카드, 1:휴대폰, 2:주민번호, 3:사업자번호)
     Ds_Input        :=   Cells[GDR_DS_INPUT      ,pRow] ;  //입력방법(S:SWIPE, K:KEYIN, O:외부)
     CardNo          :=   Cells[GDR_CARDNO        ,pRow] ;  //카드등번호
     No_Approval     :=   Cells[GDR_NO_APPROVAL   ,pRow] ;  //승인번호
     Amt_Approval    :=   StoI(Cells[GDR_AMT      ,pRow]);  //승인금액
     VatAmt          :=   StoI(Cells[GDR_VAT      ,pRow]);  //부가세금액
     trd_date        :=   Cells[GDR_TRD_DATE      ,pRow] ;  //승인일자
     trd_date_org    :=   Cells[GDR_TRD_DATE_ORG  ,pRow] ;  //원승인일자
     Approval_org    :=   Cells[GDR_APPROVAL_ORG  ,pRow] ;  //원승인번호
     Corner          :=   Cells[GDR_CORNER        ,pRow];
     CardNoFull      :=   Cells[GDR_FULLCARDNO    ,pRow];
     Yn_Cat          :=   Cells[GDR_YN_CAT        ,pRow];
     VanTid          :=   Cells[GDR_VAN_TID       ,pRow];
  end;
end;

procedure InitUPlusRecord(var AValue: TUPlus);
begin
  with AValue do
  begin
    ds_trd        := dtApproval;
    CardNo        := EmptyStr;
    AgreeAmt      := 0;
    Dc_Amt        := 0;
    TelMflwNo     := EmptyStr;
    AgreeDate     := EmptyStr;
    AgreeNo       := EmptyStr;
    OrgAgreeDate  := EmptyStr;
    OrgAgreeNo    := EmptyStr;
    pnt_rest      := 0;
    yn_can        := 'Y';
    yn_print      := 'Y';
    yn_save       := 'Y';
  end;
end;

function TCommon.UPlusInfoLoad(aGugun:Boolean):Boolean;
var vIndex :Integer;
begin
   Result := False;
   InitUPlusRecord(Common.UPlus);

   with UPlus_sGrd, UPlus do
   begin
     if Cells[0,0] = '' then Exit;
     For vIndex := 0 to RowCount-1 do
     begin
       if Cells[GDK_YN_CAN, vIndex] = '1' then Continue;

       DS_TRD         :=  Ifthen(aGugun, dtApproval, dtCancel);  //
       CardNo         :=  Cells[GDK_CARDNO           ,vIndex];
       AgreeAmt       :=  StoI(Cells[GDK_AMT         ,vIndex]);
       Dc_Amt         :=  StoI(Cells[GDK_DC_AMT      ,vIndex]);
       TelmflwNo      :=  Cells[GDK_CHAINPL          ,vIndex];   //전문추적번호
       AgreeDate      :=  Cells[GDK_TRD_DATE         ,vIndex];
       AgreeNo        :=  Cells[GDK_NO_APPROVAL      ,vIndex];
       OrgAgreeDate   :=  Cells[GDK_TRD_DATE         ,vIndex];
       OrgAgreeNo     :=  Cells[GDK_NO_APPROVAL      ,vIndex];
       pnt_rest       :=  StoI(Cells[GDK_PNT_REST    ,vIndex]);
       Result := True;
     end;
   end;
end;

procedure TCommon.UPlusInfoSave;
begin
   with UPlus_sGrd, UPlus do
   begin
      if Cells[0,0] <> '' then RowCount := RowCount + 1;

      Cells[GDK_DS_TRD           ,RowCount-1]  := Ds_Trd;
      Cells[GDK_CARDNO           ,RowCount-1]  := CardNo;
      Cells[GDK_AMT              ,RowCount-1]  := IntToStr(AgreeAmt);
      Cells[GDK_DC_AMT           ,RowCount-1]  := IntToStr(Dc_Amt);
      Cells[GDK_CHAINPL          ,RowCount-1]  := TelmflwNo;
      Cells[GDK_TRD_DATE         ,RowCount-1]  := AgreeDate;
      Cells[GDK_NO_APPROVAL      ,RowCount-1]  := AgreeNo;
      Cells[GDK_TRD_DATE_ORG     ,RowCount-1]  := OrgAgreeDate;
      Cells[GDK_APPROVAL_ORG     ,RowCount-1]  := OrgAgreeNo;
      Cells[GDK_PNT_REST         ,RowCount-1]  := IntToStr(pnt_rest);
      Cells[GDK_YN_CAN           ,RowCount-1]  := Trim(Yn_Can);         //취소가능여부
      Cells[GDK_YN_PRINT         ,RowCount-1]  := Trim(Yn_print);       //출력여부
      Cells[GDK_YN_SAVE          ,RowCount-1]  := Trim(Yn_save);        //저장여부
   end;
end;

procedure InitMagamRecord(var AValue: TMagam);
begin
  with AValue do
  begin
    UserCod        := EmptyStr;
    amt_ready      := 0;
    amt_deposit    := 0;
    amt_acct_cash  := 0;
    amt_acct_card  := 0;
    amt_acct_out   := 0;
    amt_cash       := 0;
    cnt_card       := 0;
    amt_card       := 0;
    amt_trust      := 0;
    amt_check      := 0;
    amt_gift       := 0;
    amt_bank       := 0;
    amt_point      := 0;
    amt_etc        := 0;
    amt_letsorder  := 0;
    amt_cashtip    := 0;
    amt_cardtip    := 0;
    amt_service    := 0;
    dc_menu        := 0;
    dc_member      := 0;
    dc_code        := 0;
    dc_receipt     := 0;
    dc_spc         := 0;
    dc_event       := 0;
    dc_cut         := 0;
    dc_vat         := 0;
    dc_point       := 0;
    dc_coupon      := 0;
    dc_taxfree     := 0;
    dc_stamp       := 0;
    dc_uplus       := 0;
    dc_kakao       := 0;
    dc_letsorder   := 0;
    dc_tot         := 0;
    amt_sale       := 0;
    amt_tax        := 0;
    cnt_customer   := 0;
    amt_average    := 0;
    amt_banpum     := 0;
    cnt_void       := 0;
    amt_void       := 0;
    amt_lack       := 0;
    amt_cashrcp    := 0;
    cnt_cashier    := 0;
    _Check         := 0;
    _50000         := 0;
    _10000         := 0;
    _5000          := 0;
    _1000          := 0;
    _500           := 0;
    _100           := 0;
    _50            := 0;
    _10            := 0;
    amt_input      := 0;
    amt_present    := 0;
    rcp_begin      := EmptyStr;
    rcp_end        := EmptyStr;
  end;
end;

procedure InitKioskCashRecord(var aValue :TKioskCash);
var
  I: Integer;
begin
  with aValue do
  begin
    for I := 0 to 9 do
      DataBytes[3 + I] := 0;

    inAmount  := 0;
    outAmount := 0;
    RecvPos   := 0;
    Pay       := false;
    BD1       := false;
    BD2       := false;
    HP1       := false;
    HP2       := false;
    Ver       := '';
  end;
end;


//**************************************************************************//
//                         현금영수증승인정보 그리드에 저장
//**************************************************************************//
procedure TCommon.CashRcpInfoSave;
begin
   with Cash_sGrd, CashRcp do
   begin
      if Amt_Approval = 0 then Exit;
      
      if Cells[0,0] <> '' then RowCount := RowCount + 1;

      Cells[GDR_DS_TRD       ,RowCount-1] := Trim(Ds_Trd);         //거래구분(승인=dtApproval, 취소=dtCancel)
      Cells[GDR_DS_KIND      ,RowCount-1] := Trim(Ds_Kind);        //거래유형(0:개인, 1:사업자)
      Cells[GDR_DS_TYPE      ,RowCount-1] := Trim(Ds_Type);        //승인유형(0:카드, 1:휴대폰, 2:주민번호, 3:사업자번호)
      Cells[GDR_DS_INPUT     ,RowCount-1] := Trim(Ds_Input);       //입력방법(S:SWIPE, K:KEYIN, O:외부)
      Cells[GDR_CARDNO       ,RowCount-1] := Trim(CardNo);         //카드등번호
      Cells[GDR_NO_APPROVAL  ,RowCount-1] := Trim(No_Approval);    //승인번호
      Cells[GDR_AMT          ,RowCount-1] := FtoS(Amt_Approval);   //승인금액
      Cells[GDR_VAT          ,RowCount-1] := FtoS(VatAmt);         //부가세금액
      Cells[GDR_TRD_DATE     ,RowCount-1] := Trim(trd_date);       //승인일자
      Cells[GDR_TRD_DATE_ORG ,RowCount-1] := Trim(trd_date_org);   //원승인일자
      Cells[GDR_APPROVAL_ORG ,RowCount-1] := Trim(Approval_org);   //원승인번호
      Cells[GDR_YN_CAN       ,RowCount-1] := Trim(Yn_Can);         //취소가능여부
      Cells[GDR_YN_PRINT     ,RowCount-1] := Trim(Yn_print);       //출력여부
      Cells[GDR_YN_SAVE      ,RowCount-1] := Trim(Yn_save);        //저장여부
      Cells[GDR_VAN_TID      ,RowCount-1] := VanTid;               //밴구분
      Cells[GDR_CORNER       ,RowCount-1] := Corner;               //밴구분
      if (Length(CardNoFull) < 30) and (Length(CardNo) < 30) then
        Cells[GDR_FULLCARDNO   ,RowCount-1] := Ifthen(CardNoFull=EmptyStr, Trim(CardNo), CardNoFull);
      Cells[GDR_YN_CAT       ,RowCount-1] := Yn_Cat;               
   end;
   InitCashRcpRecord(CashRcp);
end;

//**************************************************************************//
//                           현금영수증폼 호출
//**************************************************************************//
function TCommon.ShowCashRcpForm(aApproval:Boolean;aAmount:Integer=0):Boolean;
var vCount :Integer;
    vTid, vPass, vSerialNo, vBizNo :String;
begin
   DoModalReset;
   TaxCalculation;
   CashRcp.Ds_Trd  := Ifthen(aApproval, dtApproval,dtCancel);
   Present.CashSeq := Present.CashSeq + 1;

  //다중매장일때 대상매장 확인
  if (GetOption(60) = '1') and (PreSent.RcvAmt = 0) and aApproval then
  begin
    vCount := SetCornerAmt;
    if vCount = 0 then
    begin
      Config.van_Terid := Corner[0].VanTID;
      Config.SerialNo  := Corner[0].VanSerial;
      Config.BizNo     := GetOnlyNumber(Corner[0].BizNo);
    end;
  end;

  if (vCount <= 1) or (GetOption(60) = '0') or (Common.PreSent.RcvAmt <> 0) or not aApproval then
  begin
    CashRcp_F.ReceiveAmtEdit.Value := 0;

    if aAmount > 0 then
    begin
      CashRcp_F.ReceiveAmtEdit.Value := aAmount;
      if aAmount > Present.WRcvAmt then
        CashRcp_F.ApprovalAmtEdit.Value  := Present.WRcvAmt
      else
        CashRcp_F.ApprovalAmtEdit.Value  := aAmount;
    end;

    if CashRcp_F.ShowModal = mrOk then
    begin
      Result := True;
      WriteLog('work', '현금영수증완료');
    end
    else
      Result := False;
      DoModalClose;
  end
  else
  begin
    if Common.PreSent.WRcvAmt <= 0 then
    begin
      MsgBox('받을금액이 없습니다');
      Exit;
    end;
    MultiCashRcp_F := TMultiCashRcp_F.Create(Application);

    CashRcp.Ds_Trd := dtApproval;

    try
       if MultiCashRcp_F.ShowModal = mrOk then Result := True
       else                                    Result := False;
       Application.ProcessMessages;
    finally
       FreeAndNil(MultiCashRcp_F);
       DoModalClose;
       if Assigned(Order_F) then
         Order_F.FCardData := EmptyStr;
    end;
  end;
end;

function TCommon.ShowUPlusForm(aGubun:Boolean):Boolean;
begin
  UPlus.Ds_Trd := Ifthen(aGubun, dtApproval,dtCancel);
  if aGubun then UPlus_F.lbl_Kind.Caption := '【 승인 】'
  else           UPlus_F.lbl_Kind.Caption := '【 취소 】';

  try
     if UPlus_F.ShowModal = mrOk then Result := True
     else                             Result := False;
     Application.ProcessMessages;
  finally
  end;
end;

procedure TCommon.ShowCustomerInfo;                           //고객정보를 받는다
begin
  if GetOption(307) = '1' then
  begin
    MsgBox('고객수 추정 기능을 사용시 에는'#13'고객정보를 입력할 수 없습니다');
    Exit;
  end;
  CustomerInfo_F.ShowModal;
end;

function  TCommon.ShowMemberForm(MsrData:String):Boolean;
begin
  DoModalReset;
  try
    if not Assigned(Member_F) then
      Member_F       := TMember_F.Create(Application);
    if MsrData = 'CASHBOOK' then
    begin
      Member_F.Tag := 1;
      Result := Member_F.ShowModal = mrOK;
    end
    else
    begin
      Member_F.PhoneNo := MsrData;
      Member_F.Tag := 0;
      Result := Member_F.ShowModal = mrOK;
      if Result then
        WriteLog('work', Format('회원조회 - %s', [Member.Code]));
    end;
  finally
    DoModalClose;
  end;

end;

function TCommon.ShowMemberAddForm(aTelNo:String):Boolean;
begin
  DoModalReset;
  MemberAdd_F := TMemberAdd_F.Create(Application);
  MemberAdd_F.IsNew := True;
  MemberAdd_F.TelNo := aTelNo;
  try
    Result := MemberAdd_F.ShowModal= mrOK;
  finally
    FreeAndNil(MemberAdd_F);
    DoModalClose;
  end;
end;

function TCommon.ShowChooseForm(aMode:String;aMenuCode:String; var aCode, aName:String; aSQL:String):Boolean;
begin
  DoModalReset;
  try
    CommonChoose_F  := TCommonChoose_F.Create(Application);

    CommonChoose_F.strSelectMode := aMode;
    CommonChoose_F.GroupMenuCode := aMenuCode;
    if aMode = 'G' then
      CommonChoose_F.GroupMenuName := aSQL
    else
      CommonChoose_F.SqlText       := aSQL;

    CommonChoose_F.SelectQty       := aName;

    if CommonChoose_F.ShowModal = mrOk then
    begin
      aCode := CommonChoose_F.SelectCode;
      aName := CommonChoose_F.SelectName;
      Result := True;
    end
    else
    begin
      aCode := '';
      aName := '';
      Result := False;
    end;
  finally
    FreeAndNil(CommonChoose_F);
    DoModalClose;
  end;
end;

function TCommon.ShowCashForm: Boolean;
begin
  DoModalReset;
  Cash_F.ShowModal;
end;

function TCommon.ShowCheckForm: Boolean;
begin
  DoModalReset;
  Result := Check_F.ShowModal = mrOK;
  DoModalClose;
end;

function TCommon.ShowMenuItemForm: Boolean;
begin
  DoModalReset;
  if not Config.IsKiosk then
    Result := MenuItem_F.ShowModal = mrOK
  else if GetOption(35) = '0' then
    Result := KioskItem_F.ShowModal = mrOK
  else
  begin
    if Assigned(Order_F) then
      Order_F.Tmr_KioskWait.Enabled := false;

    Result := KioskItem2_F.ShowModal = mrOK;
    if Assigned(Order_F) then
      Order_F.Tmr_KioskWait.Enabled := true;
  end;
end;

//**************************************************************************//
//                           클릭시 AllSelect
//**************************************************************************//
procedure TCommon.OnClick(Sender:TObject);
begin
  if (Sender is TEdit) then
  begin
    (Sender as TEdit).SelStart  := 0;
    (Sender as TEdit).SelLength := Length((Sender as TEdit).Text);
  end
  else if (Sender is TMaskEdit) then
  begin
    (Sender as TMaskEdit).SelStart  := 0;
    (Sender as TMaskEdit).SelLength := Length((Sender as TMaskEdit).Text)
                                      +CharCnt((Sender as TMaskEdit).EditMask,'-')
                                      +CharCnt((Sender as TMaskEdit).EditMask,'.');
  end
  else if (Sender is TcxCurrencyEdit) then
  begin
    (Sender as TcxCurrencyEdit).SelStart  := 0;
    (Sender as TcxCurrencyEdit).SelLength := Length((Sender as TcxCurrencyEdit).Text);
  end;
end;

//**************************************************************************//
//                           OnEnter 이벤트 처리
//**************************************************************************//
procedure TCommon.MaskEditOnEnter(Sender:TObject);
begin
   (Sender as TMaskEdit).EditMask := '';
end;

//**************************************************************************//
//                    NumberEdit Exit 시 DisplayFormat := #,##0
//**************************************************************************//
procedure TCommon.CurrencyEdit(Sender:TObject);
begin
   (Sender as TcxCurrencyEdit).Properties.DisplayFormat := '#,##0'
end;

procedure  TCommon.ErrBox(aMsg:String);
begin
  HideWaitForm;
  if not Config.isKiosk then
  begin
    if Assigned(QuesMsg_F) and QuesMsg_F.Showing then Exit;
    QuesMsg_F := TQuesMsg_F.Create(Application);
    if Pos('Query must return', aMsg) > 0 then
    begin
      WriteLog('work', Format('ErrBox [ %s ]', [Replace(aMsg,#13,' ')]));
      DM.UniConnection.Disconnect;
      DM.UniConnection.Connect;
      WriteLog('work', 'Database ReConnect');
      Exit;
    end;
    if Common.Config.DualSize in [1,2] then QuesMsg_F.DefaultMonitor := dmDesktop;
    QuesMsg_F.NoButton.Visible  := False;
    QuesMsg_F.YesButton.Left    := (QuesMsg_F.Width - QuesMsg_F.YesButton.Width) div 2;
    QuesMsg_F.msgText    := aMsg;
    WriteLog('work', Format('ErrBox [ %s ]', [Replace(aMsg,#13,' ')]));
    try
       QuesMsg_F.ShowModal;
    finally
      FreeAndNil(QuesMsg_F);
      DoModalClose;
      Application.ProcessMessages;
    end;
  end
  else
  begin
    if Assigned(KioskQuesMsg_F) and KioskQuesMsg_F.Showing then Exit;
    KioskQuesMsg_F := TKioskQuesMsg_F.Create(Application);
    if Pos('Query must return', aMsg) > 0 then
    begin
      WriteLog('work', Format('ErrBox [ %s ]', [Replace(aMsg,#13,' ')]));
      DM.UniConnection.Disconnect;
      DM.UniConnection.Connect;
      WriteLog('work', 'Database ReConnect');
      Exit;
    end;
    if Common.Config.DualSize in [1,2] then KioskQuesMsg_F.DefaultMonitor := dmDesktop;
    KioskQuesMsg_F.NoButton.Visible  := False;
    KioskQuesMsg_F.YesButton.Caption := Common.GetPaPago('확인');

    KioskQuesMsg_F.FMsgState        := msgError;
    KioskQuesMsg_F.msgText    := aMsg;
    if KioskVoice then
      TextToSpeech(aMsg);

    WriteLog('work', Format('ErrBox [ %s ]', [Replace(aMsg,#13,' ')]));
    try
       DoModalReset;
       KioskQuesMsg_F.ShowModal;
    finally
      DoModalClose;
      FreeAndNil(KioskQuesMsg_F);
      Application.ProcessMessages;
    end;
  end;
end;

procedure  TCommon.MsgBox(aMsg:String;aTimeOut:Integer);
begin
  HideWaitForm;
  if not Config.isKiosk then
  begin
    if Assigned(QuesMsg_F) and QuesMsg_F.Showing then Exit;
    QuesMsg_F := TQuesMsg_F.Create(Application);
    if Pos('Query must return', aMsg) > 0 then
    begin
      WriteLog('work', Format('MsgBox [ %s ]', [aMsg]));
      DM.UniConnection.Disconnect;
      DM.UniConnection.Connect;
      WriteLog('work', 'Database ReConnect');
      Exit;
    end;
    if Common.Config.DualSize in [1,2] then QuesMsg_F.DefaultMonitor := dmDesktop;

    QuesMsg_F.NoButton.Visible  := False;
    QuesMsg_F.YesButton.Left    := (QuesMsg_F.Width - QuesMsg_F.YesButton.Width) div 2;
    QuesMsg_F.msgText    := aMsg;
    WriteLog('work', Format('MsgBox [ %s ]', [Replace(aMsg,#13,' ')]));
    try
       QuesMsg_F.ShowModal;
    finally
      FreeAndNil(QuesMsg_F);
      Application.ProcessMessages;
    end;
  end
  else
  begin
    if Assigned(KioskQuesMsg_F) and KioskQuesMsg_F.Showing then Exit;
    KioskQuesMsg_F := TKioskQuesMsg_F.Create(Application);
    if Pos('Query must return', aMsg) > 0 then
    begin
      WriteLog('work', Format('MsgBox [ %s ]', [aMsg]));
      DM.UniConnection.Disconnect;
      DM.UniConnection.Connect;
      WriteLog('work', 'Database ReConnect');
      Exit;
    end;
    if Common.Config.DualSize in [1,2] then KioskQuesMsg_F.DefaultMonitor := dmDesktop;

    KioskQuesMsg_F.NoButton.Visible  := False;
    KioskQuesMsg_F.YesButton.Caption := Common.GetPaPago('확인');
    KioskQuesMsg_F.FMsgState        := msgMsg;
    KioskQuesMsg_F.msgText    := aMsg;
    if KioskVoice then
      TextToSpeech(aMsg);
    WriteLog('work', Format('MsgBox [ %s ]', [Replace(aMsg,#13,' ')]));
    try
       DoModalReset;
       KioskQuesMsg_F.ShowModal;
    finally
      DoModalClose;
      Application.ProcessMessages;
      FreeAndNil(KioskQuesMsg_F);
    end;
  end;
end;

function  TCommon.AskBox(aMsg:String;aTimeOut:Integer):Boolean;
begin
  HideWaitForm;
  if not Config.isKiosk then
  begin
    if Assigned(QuesMsg_F) and QuesMsg_F.Showing then Exit;
    Result := False;
    QuesMsg_F := TQuesMsg_F.Create(Application);
    QuesMsg_F.DefaultMonitor    := dmDesktop;
    QuesMsg_F.msgText           := aMsg;
    QuesMsg_F.NoButton.Visible  := True;
    QuesMsg_F.YesButton.Left    := 116;
    QuesMsg_F.TimeOut           := aTimeOut;

    try
       Application.ProcessMessages;
       if QuesMsg_F.ShowModal = mrOK then
         Result := True;
       WriteLog('work', Format('%s [%s]', [Replace(aMsg,#13,' '), Ifthen(Result,'예','아니오')]));
    finally
      FreeAndNil(QuesMsg_F);
      Application.ProcessMessages;
    end;
  end
  else
  begin
    if Assigned(KioskQuesMsg_F) and KioskQuesMsg_F.Showing then Exit;
    Result := False;
    KioskQuesMsg_F := TKioskQuesMsg_F.Create(Application);
    KioskQuesMsg_F.DefaultMonitor := dmDesktop;
    KioskQuesMsg_F.FMsgState        := msgAsk;
    KioskQuesMsg_F.msgText          := aMsg;
    if KioskVoice then
      TextToSpeech(aMsg);
    KioskQuesMsg_F.NoButton.Visible  := True;
    KioskQuesMsg_F.YesButton.Caption := Common.GetPaPago('예');
    KioskQuesMsg_F.TimeOut           := Ifthen(aTimeOut=0, 60, aTimeOut);
    try
       Application.ProcessMessages;
       DoModalReset;
       if KioskQuesMsg_F.ShowModal = mrOK then
         Result := True;
       WriteLog('work', Format('%s [%s]', [Replace(aMsg,#13,' '), Ifthen(Result,'예','아니오')]));
    finally
      DoModalClose;
      FreeAndNil(KioskQuesMsg_F);
      Application.ProcessMessages;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Name         : ShowWaitForm
// Type         : procedure
// Explanation  : 진행 대기 메시지 팝업 화면 보이기
// Parameter    : Text   : 디스플레이 내용
////////////////////////////////////////////////////////////////////////////////
procedure TCommon.ShowWaitForm(aMsg:String;aButton:Boolean);
begin
  if not aButton and Config.IsKiosk then Exit;

  WaitMsg_F.Msg := Common.GetPaPago(aMsg);
  WaitMsg_F.ShowButton := aButton;
  WaitMsg_F.Show;
  WaitMsg_F.Msg := EmptyStr;
  Application.ProcessMessages;
end;

////////////////////////////////////////////////////////////////////////////////
// Name         : HideWaitForm
// Type         : procedure
// Explanation  : 진행 대기 메시지 팝업 화면 숨기기
////////////////////////////////////////////////////////////////////////////////
procedure TCommon.HideWaitForm;
begin
   if not WaitMsg_F.Showing then Exit;
   WaitMsg_F.Hide;
   //다우 단말기 연동일때는 원인을 알수 없지만 늦음
   if (GetOption(379) <> '1') or (Common.Config.van_trd <> 1) then
     Application.ProcessMessages;
end;

////////////////////////////////////////////////////////////////////////////////
// Name         : ShowLetsOrderServiceForm
// Type         : procedure
// Explanation  : 진행 대기 메시지 팝업 화면 보이기
// Parameter    : Text   : 디스플레이 내용
////////////////////////////////////////////////////////////////////////////////
procedure TCommon.ShowLetsOrderServiceForm(aMsg:String);
begin
  LetsOrderService_F.Msg := aMsg;
  LetsOrderService_F.Show;
  LetsOrderService_F.Msg := EmptyStr;
  Application.ProcessMessages;
end;

////////////////////////////////////////////////////////////////////////////////
// Name         : HideWaitForm
// Type         : procedure
// Explanation  : 진행 대기 메시지 팝업 화면 숨기기
////////////////////////////////////////////////////////////////////////////////
procedure TCommon.HideLetsOrderServiceForm;
begin
   if not LetsOrderService_F.Showing then Exit;
   LetsOrderService_F.Hide;
end;



procedure TCommon.PadWaitForm(aMsg,aSendMsg:String);
begin
  PadWait_F := TPadWait_F.Create(Application);
  try
    PadWait_F.Msg     := aMsg;
    PadWait_F.SendMsg := aSendMsg;
    try
      PadWait_F.ShowModal;
    except
    end;
  finally
    FreeAndNil(PadWait_F);
  end
end;


function TCommon.ShowNumberForm(Msg:String;MaxLength:Integer;
                                MaxValue:Integer=0;InitValue:String=''):String;
begin
  DoModalReset;
  NumPan_F.CaptionLabel.Caption   := GetPaPago(Msg);
  NumPan_F.InputEdit.Properties.MaxLength := MaxLength;
  NumPan_F.FMaxValue           := MaxValue;
  NumPan_F.FInitValue          := InitValue;
  try
     if NumPan_F.ShowModal = mrOk then
     begin
       if MaxValue > 0 then
         Result := GetOnlyNumber(NumPan_F.InputEdit.Text)
       else
         Result := NumPan_F.InputEdit.Text;

       if Result = '' then
         Result := 'mrClose';
     end
     else  Result := 'mrClose';

     WriteLog('work', Format('%s [ %s ]', [Msg, Result]));

  finally
  end;
  Application.ProcessMessages;
end;



procedure TCommon.BeginTran;
begin
    if not DM.UniConnection.Connected then
      DM.UniConnection.Connect;
    DM.UniConnection.StartTransaction;
end;

procedure TCommon.CommitTran;
begin
  if DM.UniConnection.InTransaction then
    DM.UniConnection.Commit;
end;

procedure TCommon.RollbackTran;
begin
  if DM.UniConnection.InTransaction then
    DM.UniConnection.Rollback;
end;

function TCommon.GetNowDate:String;
begin
  Result := FormatDateTime(fmtDateShort, Now());
end;

////////////////////////////////////////////////////////////////////////////////
// Name         : SortExecute
// Type         : procedure
// Explanation  : 소트실행
////////////////////////////////////////////////////////////////////////////////
procedure TCommon.SortExecute;
var I , J       :Integer;
    lsOld,lsNew :String;
begin
  For I := 0 to SortCount-2 do
    For J := I+1 to SortCount-1 do
    begin
       if SortData[I,1] > SortData[J,1] then
       begin
          lsOld := SortData[I,0];
          lsNew   := SortData[I,1];
          SortData[I,0] := SortData[J,0];
          SortData[I,1] := SortData[J,1];
          SortData[J,0] := lsOld;
          SortData[J,1] := lsNew  ;
       end;
    end;
end;
////////////////////////////////////////////////////////////////////////////////
// Name         : GetServerTime
// Type         : function
// Explanation  : 서버의 시간 가져오기
////////////////////////////////////////////////////////////////////////////////
function TCommon.GetNowTime:String;
begin
  Result := FormatDateTime('hhnn', Now());
end;

////////////////////////////////////////////////////////////////////////////////
// Name         : SetDayOpen
// Type         : function
// Explanation  : 개점저장
////////////////////////////////////////////////////////////////////////////////
function  TCommon.SetDayOpen(aOpenDate:String):Boolean;
var vTemp :String;
begin
  Result := false;
  if not IsDate(aOpenDate) then
  begin
    ErrBox(Format('개점일자가 올바르지 않습니다[%s]',[aOpenDate]));
    Exit;
  end;
  
  OpenQuery('select DS_STATUS '
           +'  from SL_POSCLOSE '
           +' where CD_STORE	=:P0 '
           +'   and YMD_CLOSE	=:P1 '
           +'   and NO_POS   	=:P2 ',
           [Config.StoreCode,
            aOpenDate,
            Config.PosNo]);
  if Query.eof or (Query.Fields[0].AsString <> 'C') then
  begin
    Query.Close;
    OpenQuery('select ConCat(StoD(YMD_CLOSE),NO_POS) '
             +'  from SL_POSCLOSE '
             +' where CD_STORE  	= :P0 '
             +'		and YMD_CLOSE	= :P1 '
             +'		and DS_STATUS	=''O'' '
             +' limit 1 ',
             [Config.StoreCode,
              aOpenDate]);
    if not Query.eof then
    begin
      vTemp := Query.Fields[0].AsString;
      Query.Close;
      if Copy(vTemp,11,2) <> Common.Config.PosNo then
      begin
        //정산포스가 2대 이상 시 개점일자를 동일하게 사용합니다.
        if GetOption(328) = '1' then
        begin
          ExecQuery('insert into SL_POSCLOSE(CD_STORE, YMD_CLOSE, NO_POS, DT_CHANGE, DS_STATUS) '
                   +'                 values(:P0, :P1, :P2, NULL, ''O'')',
                   [Config.StoreCode,
                    aOpenDate,
                    Config.PosNo]);
          WorkDate := aOpenDate;
          if Common.Config.Amt_DefReady > 0 then
            Common.SaveReadyAmt(Common.Config.Amt_DefReady, false);
          Result := true;
        end;
      end
      else
      begin
        ErrBox(Copy(vTemp,1,10)+'일자의 '+Copy(vTemp,11,2)+'번 포스가'
               +#13+'마감되지 않았습니다'+#13#13
               +'마감을 완료후에 개점를 해야합니다' );
        Exit;
      end;
    end
    else
    begin
      try
        ExecQuery('insert into SL_POSCLOSE(CD_STORE, YMD_CLOSE, NO_POS, DT_CHANGE, DS_STATUS) '
                 +'                 values(:P0, :P1, :P2, NULL, ''O'')',
                 [Config.StoreCode,
                  aOpenDate,
                  Config.PosNo]);
        WorkDate := aOpenDate;
        if Common.Config.Amt_DefReady > 0 then
          Common.SaveReadyAmt(Common.Config.Amt_DefReady, false);

        Result := true;
      except
        on E:Exception do
        begin
          WriteLog('work',Format('개점오류[%s] ',[aOpenDate])+ E.Message);
          ErrBox(E.Message+#13#13+'개점을 완료하지 못했습니다');
        end;
      end;
    end;
  end
  else
    ErrBox('마감이 완료 된 일자입니다');
end;

//**************************************************************************//
//                          영수증번호 채번
//**************************************************************************//
function TCommon.GetReceiptNo:Boolean;
begin
  try
    Result := False;
    DBConnect;

    OpenQuery('select LPad( Ifnull(max(NO_RCP),0) + 1, 4, ''0'') '
             +'  from SL_SALE_H '
             +' where CD_STORE =:P0 '
             +'   and YMD_SALE =:P1 '
             +'   and NO_POS   =:P2 ',
             [Config.StoreCode,
              WorkDate,
              Config.PosNo]);

    if not Query.Eof then
    begin
      Present.RcpNo := Query.Fields[0].AsString;
      Result := True;
    end;
    Query.Close;
  except
    on E: Exception do
    begin
      WriteLog('GetReceiptNo',E.Message);
      if E.Message = '연결을 실패했습니다' then
        DBConnectError := True;
    end;
  end;

  //영수증번호가 0001이면 혹시 서버에 영수증번호를 확인한다
  if (Present.RcpNo = '0001') and DM.CloudConnected then
  begin
    try
      DM.OpenCloud('select LPad(ifnull(Max(NO_RCP),0) + 1, 4, ''0'') '
                  +'  from SL_SALE_H '
                  +' where CD_HEAD  =:P0 '
                  +'   and CD_STORE =:P1 '
                  +'   and YMD_SALE =:P2 '
                  +'   and NO_POS   =:P3 ',
                  [Common.Config.HeadStoreCode,
                   Common.Config.StoreCode,
                   Common.WorkDate,
                   Common.Config.PosNo],Common.RestDBURL);

      if not DM.CloudData.Eof then
      begin
        if DM.CloudData.Fields[0].asString > Present.RcpNo then
          Present.RcpNo := DM.CloudData.Fields[0].asString;
      end;
    finally
      DM.CloudData.Close;
    end;
  end;

end;

//**************************************************************************//
//                          주문번호 채번
// 주문을 취소만 하고 취소한 내역중 주방과 연결된 메뉴가 없으면 주문번호를 발행하지 않는다
//**************************************************************************//
function TCommon.GetOrderNo(aMode:Integer=0):Integer;
var vIndex, vIndex2, vMax :Integer;
    lbExist :Boolean;
    vTemp :String;
begin
  Result  := 0;
  lbExist := False;
  //주방에 출력할 내용이 있는지 체크
  For vIndex := 0 to High(KitchenPrinter) do
  begin
    For vIndex2 := 1 to 100 do
    begin
      if Common.KitchenPrinter[vIndex].GroupSource[vIndex2] <> '' then
      begin
        lbExist := True;
        Break;
      end;
    end;

    if (KitchenPrinter[vIndex].Data <> EmptyStr)
       or (KitchenPrinter[vIndex].Cancel <> EmptyStr) then
    begin
      lbExist := True;
      Break;
    end;
  end;

  if not lbExist and (aMode = 0) then Exit;
  try

    DM.StoredProc.StoredProcName :='GET_NUMBER';
    DM.StoredProc.PrepareSQL;
    DM.StoredProc.ParamByName('_CD_STORE'  ).AsString    := Common.Config.StoreCode;
    DM.StoredProc.ParamByName('_DS_NUMBER'  ).AsString   := 'O';
    DM.StoredProc.ParamByName('_NO_POS'  ).AsString      := '00';
    DM.StoredProc.ParamByName('_TEL_MOBILE'  ).AsString  := '';
    DM.StoredProc.ParamByName('_PICKUP_POS'  ).AsString  := '';
    DM.StoredProc.ParamByName('_NO_RECEIPT'  ).AsString  := '';
    DM.StoredProc.ParamByName('_NO_MAX'  ).AsString     := GetOption(304);
    DM.StoredProc.ExecProc;
    Result := DM.StoredProc.ParamByName('_NO_CALL').AsInteger;
    DM.StoredProc.Close;
  except
    on E: Exception do
    begin
      Result := -1;
      WriteLog('GetOrderNo',E.Message);
      ErrBox(E.Message+#13#13+Format('주문번호(%d) 채번오류',[Result]));
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Name         : PosNo_Check
// Type         : function
// Explanation  : 포스번호 체크
////////////////////////////////////////////////////////////////////////////////
function TCommon.PosNo_Check:Boolean;
begin
   Result := False;
   try
     OpenQuery('select count(*) CNT '
              +'  from MS_CODE '
              +' where CD_KIND =''01'' '
              +'   and NM_CODE1=:P0 ',
              [Config.PosNo]);
   except
     on E: Exception do
     begin
       if E.Message = '연결을 실패했습니다' then LogoClick(nil);
       Exit;
     end;
   end;

   if Query.Fields[0].Value > 0 then
     Result := True
   else
   begin
     ErrBox('등록되어있지 않은 포스번호입니다');
     Exit;
   end;
   Query.Close;
   Screen.Cursor := crDefault;
end;

function TCommon.GetCardSeq:String;
var vTemp :String;
begin
  vTemp   := GetIniFile('POS', 'CARDSEQ','');
  if Copy(vTemp,1,4) <> FormatDateTime('MMDD',now) then
     Result := FormatDateTime('MMDD',now) + Config.PosNo+ '0001'
  else
     Result := Copy(vTemp,1,6)+LPadB( IntToStr( StoI(Copy(vTemp,7,4))+1 ) , 4, '0');
end;


procedure TCommon.SetCardSeq(AValue:String);
begin
  SetIniFile('POS', 'CARDSEQ',AValue);
end;

////////////////////////////////////////////////////////////////////////////////
// Name         : SelectStoreInfo
// Type         : procedure
// Explanation  : 매장정보 셋팅
////////////////////////////////////////////////////////////////////////////////
procedure TCommon.SelectStoreInfo;
var
    I, vIndex :Integer;
    vNowDate :String;
    vCardTID :String;
    vIsLink  :Boolean;
    vStream :TStream;
    vTemp    :String;
begin
  OpenQuery('select a.*, '
           +'       b.DS_TAX, '
           +'       c.NM_MENU as KIOSK_MUST_MENUNAME, '
           +'       d.ONLINE_PG_MID    as ON_PG_MID, '
           +'       d.ONLINE_PG_MIDKEY as ON_PG_MIDKEY, '
           +'       d.KIOSK_LANGUAGE, '
           +'       d.KIOSK_BEGIN1, '
           +'       d.KIOSK_BEGIN2, '
           +'      Ifnull((select NM_CODE1 '
           +'               from MS_CODE '
           +'              where CD_STORE =:P0 '
           +'                and CD_KIND  =''01'' '
           +'                and NM_CODE3 = ''7'' '
           +'                and DS_STATUS = ''0'' '
           +'               limit 1 ),'''') as LETSORDER_POS '
           +'  from MS_STORE     a left outer join '
           +'       MS_MENU      b on a.CD_STORE = b.CD_STORE and a.TIP_MENU = b.CD_MENU left outer join '
           +'       MS_MENU      c on a.CD_STORE = c.CD_STORE and a.KIOSK_MUST_MENUCODE = c.CD_MENU left outer join '
           +'       MS_STORE_ETC d on a.CD_STORE = d.CD_STORE '
           +' where a.CD_STORE  =:P0',
           [Config.StoreCode]);

  with Config, Query do
  begin
    try
      HeadStoreCode :=  FieldByName('CD_HEAD').AsString;
      StoreName     :=  FieldByName('nm_store').AsString;
      StoreBizNo    :=  FieldByName('no_bizer').AsString;
      StoreAddress  :=  Trim(FieldByName('addr1').AsString);
      StoreBoss     :=  Trim(FieldByName('nm_boss').AsString);
      StoreAddress  :=  StoreAddress + Ifthen(StoreAddress <> '', ' ', '') + Trim(FieldByName('addr2').AsString);
      StoreTel      :=  CtoC(FieldByName('tel_office').AsString,'-','');
      if not Assigned(StoreMobile) then
        StoreMobile := TStringList.Create;
      Split(FieldByName('tel_mobile').AsString, ',',StoreMobile);
      pnt_min_use     :=  FieldByName('point_min').AsInteger;
      Config.Options  :=  FieldByName('options').AsString;
      Config.HeadOptions  :=  FieldByName('head_options').AsString;
      UseLanguage         :=  FieldByName('KIOSK_LANGUAGE').AsString;

      ReceiptTitle[1]   :=  FieldByName('rcp_title1').AsString;
      ReceiptTitle[2]   :=  FieldByName('rcp_title2').AsString;
      ReceiptTitle[3]   :=  FieldByName('rcp_title3').AsString;
      ReceiptTitle[4]   :=  FieldByName('rcp_title4').AsString;
      rcp_end[1]        :=  FieldByName('rcp_end1').AsString;
      rcp_end[2]        :=  FieldByName('rcp_end2').AsString;
      rcp_end[3]        :=  FieldByName('rcp_end3').AsString;
      rcp_end[4]        :=  FieldByName('rcp_end4').AsString;
      rcp_end[5]        :=  FieldByName('rcp_end5').AsString;
      rcp_end[6]        :=  FieldByName('rcp_end6').AsString;
      rcp_end[7]        :=  FieldByName('rcp_end7').AsString;
      rcp_end[8]        :=  FieldByName('rcp_end8').AsString;

      card_end[1]       :=  FieldByName('card_end1').AsString;
      card_end[2]       :=  FieldByName('card_end2').AsString;
      card_end[3]       :=  FieldByName('card_end3').AsString;
      card_end[4]       :=  FieldByName('card_end4').AsString;
      card_end[5]       :=  FieldByName('card_end5').AsString;

      Delivery_end[1]   :=  FieldByName('delivery_end1').AsString;
      Delivery_end[2]   :=  FieldByName('delivery_end2').AsString;
      Delivery_end[3]   :=  FieldByName('delivery_end3').AsString;
      Delivery_end[4]   :=  FieldByName('delivery_end4').AsString;
      Delivery_end[5]   :=  FieldByName('delivery_end5').AsString;

      dc_unit           :=  FieldByName('dc_unit').AsInteger;
      len_card          :=  FieldByName('len_card').AsInteger;
      len_card2         :=  FieldByName('len_card2').AsInteger;
      MemberNoPrefix    := FieldByName('memberno_PreFix').AsString;
      if GetHeadOption(5)='0' then
        MemberNoPrefix := '000';

      MemberPreFix      :=  FieldByName('member_PreFix').AsString;
      MemberPreFix2     :=  FieldByName('member_PreFix2').AsString;
      Red_Hour          :=  FieldByName('red_hour').AsInteger;
      TableChangeColor  :=  FieldByName('table_change_color').AsString;

      TipType           :=  FieldByName('Tip_Type').AsString;
      TipApply          :=  FieldByName('Tip_Apply').AsInteger;
      TipMenu           :=  FieldByName('Tip_Menu').AsString;

      MainPosNo         := FieldByName('MAIN_POSNO').AsString;
      vNowDate          := FormatDateTime('yyyymmdd', now());
      ScalePrefix       := FieldByName('SCALE_PREFIX').AsString;
      HeadCouponPrefix  := Trim(FieldByName('HEADCOUPON_PREFIX').AsString);
      HeadCouponLen     := FieldByName('HEADCOUPON_LEN').AsInteger;

      CouponPrefix      := Trim(FieldByName('COUPON_PREFIX').AsString);
      CouponLen         := FieldByName('COUPON_LEN').AsInteger;
      CustOrderTitle    := FieldByName('cust_title').AsString;
      KitchenPrintTitle := FieldByName('kitchen_title').AsString;
      ReportPwd         := FieldByName('posrpt_pwd').AsString;
      RcpSearchPwd      := FieldByName('searchrcp_pwd').AsString;
      SimpleRcpTxt      := FieldByName('simple_rcp').AsString;
      ReadyTelCount     := FieldByName('cnt_waittel').AsInteger;
      fixdcCode         := FieldByName('cd_fixdc').AsString;

      Amt_DefReady      := FieldByName('Amt_DefReady').AsInteger;

      OverTimeMenu      := FieldByName('OverTime_Menu').AsString;
      OverTimeTime      := FieldByName('OverTime_Time').AsInteger;
      OverTimeEach      := FieldByName('OverTime_Each').AsInteger;
      OverTimeAmt       := FieldByName('OverTime_Amt').AsInteger;

      default_menu      := FieldByName('default_table_menu').AsString;
      IsBusinessVersion := LeftStr(StoreCode,2) = 'TT';
      MemberDefaultMenu := FieldByName('use_menu').AsString;
      BookingTime       := FieldByName('booking_time').AsInteger;
      BookingEnd        := FieldByName('booking_end').AsInteger;
      SetStampDc        := FieldByName('AMT_STAMP').AsInteger;
      SetStampCount     := FieldByName('CNT_STAMP').AsInteger;

      WaitPrint1       := FieldByName('wait_text1').AsString;
      WaitPrint2       := FieldByName('wait_text2').AsString;
      WaitPrint3       := FieldByName('wait_text3').AsString;

      UplusJoinCode    := Trim(FieldByName('uplus_joincode').AsString);
      BaeminMenuCode   := FieldByName('baemin_menu').AsString;
      KtisChainNo      := FieldByName('ktis_store').AsString;
      TableMenuColor   := FieldByName('TABLEMENU_COLOR').AsString;
      ClosePass        := FieldByName('POSCLOSE_PWD').AsString;
      ProgramTitle     := FieldByName('POS_TITLE').AsString;
      ProgramURL       := FieldByName('POS_URL').AsString;
      PG_Mid           := FieldByName('PG_MID').AsString;
      PG_MidKey        := FieldByName('PG_MIDKEY').AsString;
      OnLine_PG_Mid    := FieldByName('ON_PG_MID').AsString;
      OnLine_PG_MidKey := FieldByName('ON_PG_MIDKEY').AsString;

      PG_Cancel        := FieldByName('PG_CANCEL_PWD').AsString;
      PG_BankCode      := FieldByName('PG_BANK_CODE').AsString;
      PG_BankOwner     := FieldByName('PG_BANK_OWNER').AsString;
      PG_BankNo        := FieldByName('PG_BANK_NO').AsString;
      OrderCloseTime   := FieldByName('ORDERCLOSE_TIME').AsString;
      ParkingCode      := FieldByName('PARKING_CODE').AsString;
      DefaultPickUp    := FieldByName('DEFAULT_PICKUP').AsString;
      LetsOrderPosNo   := FieldByName('LETSORDER_POS').AsString;

      if not Assigned(StoreMobile) then
        StoreMobile := TStringList.Create;
      Split(FieldByName('TEL_KAKAOTALK').AsString,',', StoreMobile);

      RestDBURL        := Decrypt(FieldByName('JsonDBURL').AsString, _CryptKey);
      if IsKiosk then
      begin
        if not Assigned(KioskKaKaoTel) then
          KioskKaKaoTel := TStringList.Create;
        Split(FieldByName('KIOSK_KAKAO_TEL').AsString,',', KioskKaKaoTel);
        KioskPwd := FieldByName('kiosk_pwd').AsString;
        if IsKioskCash then
        begin
          KioskAlram[2]  := FieldByName('KIOSK_ALARM1000').AsInteger;
          KioskAlram[3]  := FieldByName('KIOSK_ALARM100').AsInteger;
          KioskAlram[4]  := FieldByName('KIOSK_STOP1000').AsInteger;
          KioskAlram[5]  := FieldByName('KIOSK_STOP100').AsInteger;
          KioskCashPause := false;
        end;

        KioskType         := '84';
        KioskMustMenuCode := FieldByName('KIOSK_MUST_MENUCODE').AsString;
        KioskMustMenuName := FieldByName('KIOSK_MUST_MENUNAME').AsString;
        KioskBegin1       := FieldByName('KIOSK_BEGIN1').AsString;
        KioskBegin2       := FieldByName('KIOSK_BEGIN2').AsString;
      end;
    except
      on E: Exception do
      begin
        ErrBox(E.Message);
        Exit;
      end;
    end;
    if OverTimeTime = 0 then OverTimeMenu := '';

    BookingMenu     := FieldByName('booking_menu').AsString;
    SmsTime         := FieldByName('booking_sms').AsInteger;
    PosCloseTime    := GetOnlyNumber(FieldByName('POSCLOSE_TIME').AsString);

    if Config.PosCatUse then
      Config.Options[379] := '1';

    if Length(Config.Options) > 379 then
      Option_379      :=  Config.Options[379];

    //키오스크이면 카드영수증 별도, 승인즉시출력  적용안함
    if Config.IsKiosk then
    begin
      Config.Options[6]   := '0';
      Config.Options[45]  := '0';
      Config.Options[42]  := '0';
      Config.Options[165] := '0';
      Config.Options[230] := '0';
      if IsDebuggerPresent then
        Config.Options[28]  := '1';
    end;

    //PLU 버튼 설정
    try
      OpenQuery('select * '
               +'  from MS_CODE '
               +' where CD_STORE = :P0 '
               +'   and CD_KIND  = :P1 '
               +'   and CD_CODE  in (''001'',''002'') '
               +' order by CD_CODE ',
               [Config.StoreCode,
                Config.DesignCode]);
      while not Query.Eof do
      begin
        if Query.FieldByName('CD_CODE').AsString = '001' then
        begin
          Config.PluClassX          := StrToIntDef(Query.FieldByName('NM_CODE1').AsString,5);
          Config.PluClassY          := StrToIntDef(Query.FieldByName('NM_CODE2').AsString,2);
          Config.PluClassColor      := StringToColorDef(Query.FieldByName('NM_CODE3').AsString, clBlue);
          Config.PluClassFont.Name  := Query.FieldByName('NM_CODE5').AsString;
          Config.PluClassFont.Color := StringToColor(Query.FieldByName('NM_CODE8').AsString);
          Config.PluClassFont.Size  := StrToIntDef(Query.FieldByName('NM_CODE6').AsString,10);
          if Query.FieldByName('NM_CODE7').AsString  = '1' then
            Config.PluClassFont.Style := [fsBold];

          Config.PluClassDownColor     := StringToColorDef(Query.FieldByName('NM_CODE4').AsString, clBtnFace);
          Config.PluClassDownFontColor := StringToColorDef(Query.FieldByName('NM_CODE9').AsString, clWhite);

          //PLU 분류를 사용하지 않을때
          if Query.FieldByName('NM_CODE10').AsString = '1' then
            Config.PluClassX := 0;

          Config.PluClassHeight        := StrToIntDef(Query.FieldByName('NM_CODE11').AsString,40);
          Config.PluClassWidth         := StrToIntDef(Query.FieldByName('NM_CODE12').AsString,517);
          Config.PluClassBorderColor   := StringToColorDef(Query.FieldByName('NM_CODE13').AsString, clBlack);
          Config.AllClassPLU           := Query.FieldByName('NM_CODE10').AsString = '2';
        end
        else if Query.FieldByName('CD_CODE').AsString = '002' then
        begin
          Config.PluMenuX          := StrToIntDef(Query.FieldByName('NM_CODE1').AsString,5);
          Config.PluMenuY          := StrToIntDef(Query.FieldByName('NM_CODE2').AsString,5);
          Config.PluMenuColor      := StringToColorDef(Query.FieldByName('NM_CODE3').AsString, clWhite);
          Config.PluMenuFont.Name  := Query.FieldByName('NM_CODE4').AsString;
          Config.PluMenuFont.Color := StringToColorDef(Query.FieldByName('NM_CODE7').AsString, clBlack);
          Config.PluMenuFont.Size  := StrToIntDef(Query.FieldByName('NM_CODE5').AsString,10);
          if Query.FieldByName('NM_CODE6').AsString  = '1' then
            Config.PluMenuFont.Style := [fsBold];

          PluMenuPriceShow          := Query.FieldByName('NM_CODE8').AsString = '1';
          Config.PluPriceFont.Name  := Query.FieldByName('NM_CODE9').AsString;
          Config.PluPriceFont.Color := StringToColorDef(Query.FieldByName('NM_CODE12').AsString, clBlack);
          Config.PluMenuBorderColor := StringToColorDef(Query.FieldByName('NM_CODE13').AsString, clBlack);
          Config.PluMenuEmptyShow   := Query.FieldByName('NM_CODE14').AsString = '1';
          Config.PluPriceFont.Size  := StrToIntDef(Query.FieldByName('NM_CODE10').AsString,10);
          if Query.FieldByName('NM_CODE11').AsString  = '1' then
            Config.PluPriceFont.Style := [fsBold];
        end;
        Query.Next;
      end;
    finally
      Query.Close;
    end;

     //화면 디자인 적용
    OpenQuery('select NM_CODE1, '
             +'       NM_CODE2, '
             +'       NM_CODE3, '
             +'       NM_CODE4, '
             +'       NM_CODE5, '
             +'       NM_CODE6, '
             +'       NM_CODE7, '
             +'       NM_CODE8, '
             +'       NM_CODE9, '
             +'       NM_CODE10, '
             +'       NM_CODE11, '
             +'       NM_CODE12, '
             +'       NM_CODE13, '
             +'       NM_CODE14, '
             +'       NM_CODE15, '
             +'       NM_CODE16, '
             +'       NM_CODE17, '
             +'       NM_CODE18, '
             +'       NM_CODE19, '
             +'       NM_CODE20 '
             +'  from MS_CODE '
             +' where CD_STORE =:P0 '
             +'   and CD_KIND  =:P1 '
             +'   and CD_CODE  =''500'' ',
             [Config.StoreCode,
              Config.DesignCode]);
    if not Query.Eof then
    begin
      Config.PosWidth  := StrToIntDef(Query.FieldByName('NM_CODE1').AsString,1024);
      Config.PosHeight := StrToIntDef(Query.FieldByName('NM_CODE2').AsString,768);

      for I := 1 to 4 do
        Config.PanelWidth[I] := 0;

      Config.PanelConfig := Query.FieldByName('NM_CODE3').AsString;
      if Config.PanelConfig = '' then
        Config.PanelConfig := '1230';
      Config.PanelHeight := StrToIntDef(Query.FieldByName('NM_CODE4').AsString,192);
      if Config.PanelConfig[1] <> '0' then
        Config.PanelWidth[StrToInt(Config.PanelConfig[1])] := StrToIntDef(Query.FieldByName('NM_CODE5').AsString,243);
      if Config.PanelConfig[2] <> '0' then
        Config.PanelWidth[StrToInt(Config.PanelConfig[2])] := StrToIntDef(Query.FieldByName('NM_CODE6').AsString,243);
      if Config.PanelConfig[3] <> '0' then
        Config.PanelWidth[StrToInt(Config.PanelConfig[3])] := StrToIntDef(Query.FieldByName('NM_CODE7').AsString,517);
      if Config.PanelConfig[4] <> '0' then
        Config.PanelWidth[StrToInt(Config.PanelConfig[4])] := StrToIntDef(Query.FieldByName('NM_CODE8').AsString,200);

      Config.ListFontSize       := StrToIntDef(Query.FieldByName('NM_CODE9').AsString,14);
      Config.ListRowHeight      := StrToIntDef(Query.FieldByName('NM_CODE10').AsString,28);
      Config.DualGridFontSize   := StrToIntDef(Query.FieldByName('NM_CODE18').AsString,14);
      Config.DualGridRowHeight  := StrToIntDef(Query.FieldByName('NM_CODE19').AsString,28);

      Config.TitleCaption      := Query.FieldByName('NM_CODE11').AsString;
      Config.TitleWidth[1]     := StrToIntDef(Query.FieldByName('NM_CODE12').AsString,52);
      Config.TitleWidth[2]     := StrToIntDef(Query.FieldByName('NM_CODE13').AsString,200);
      Config.TitleWidth[3]     := StrToIntDef(Query.FieldByName('NM_CODE14').AsString,50);
      Config.TitleWidth[4]     := StrToIntDef(Query.FieldByName('NM_CODE15').AsString,60);
      Config.TitleWidth[5]     := StrToIntDef(Query.FieldByName('NM_CODE16').AsString,70);
      Config.TitleWidth[6]     := StrToIntDef(Query.FieldByName('NM_CODE17').AsString,0);
      Config.Style             := Ifthen(Query.FieldByName('NM_CODE20').AsString = '1','D','B');
      SetIniFile('POS','Style', Config.Style);
      Query.Close;
    end
    else
    begin
      Query.Close;
      Config.PosWidth      := 1024;
      Config.PosHeight     := 768;
      Config.PanelConfig   := '1230';
      Config.PanelHeight   := 192;
      Config.PanelWidth[1] := 243;
      Config.PanelWidth[2] := 243;
      Config.PanelWidth[3] := 517;
      Config.PanelWidth[4] := 0;
      Config.ListFontSize  := 14;
      Config.ListRowHeight := 28;
      Config.TitleWidth[1] := 52;
      Config.TitleWidth[2] := 200;
      Config.TitleWidth[3] := 50;
      Config.TitleWidth[4] := 60;
      Config.TitleWidth[5] := 70;
      Config.TitleWidth[6] := 0;
    end;

    //영수증계산 시 문자메제시 내용
    OpenQuery('select NM_CODE2 '
             +'  from MS_CODE '
             +' where CD_STORE  = :P0 '
             +'   and CD_KIND   = ''22'' '
             +'   and NM_CODE3  = ''1'' '
             +'   and DS_STATUS = ''0'' '
             +' limit 1 ',
             [Config.StoreCode]);
    if not Query.Eof then
      Config.AcctSMSMessage := Query.Fields[0].AsString
    else
      Config.AcctSMSMessage := EmptyStr;

    OpenQuery('select NM_CODE1 '
             +'  from MS_CODE '
             +' where CD_STORE =:P0 '
             +'   and CD_KIND  =''81'' '
             +' order by cd_code',
             [Config.StoreCode]);

    I := 0;
    while not Query.Eof do
    begin
      Query.Next;
      Inc(I);
    end;

    SetLength(CustRcpEnd, I);
    I := 0;
    Query.First;
    while not Query.Eof do
    begin
      CustRcpEnd[I] :=Query.Fields[0].AsString;
      Query.Next;
      Inc(I);
    end;

    //배달하단내용
    OpenQuery('select NM_CODE1 '
             +'  from MS_CODE '
             +' where CD_STORE =:P0 '
             +'   and CD_KIND  =''82'' '
             +' order by CD_CODE',
             [Config.StoreCode]);

    DeliveryBottomList.Clear;
    while not Query.Eof do
    begin
      DeliveryBottomList.Add(Query.Fields[0].AsString);
      Query.Next;
    end;

    //테이블그룹 색상
    OpenQuery('select NM_CODE1, '
             +'       CD_CODE '
             +'  from MS_CODE '
             +' where CD_STORE =:P0 '
             +'   and CD_KIND  =''83'' '
             +' order by CD_CODE',
             [Config.StoreCode]);

    SetLength(GroupColor, Query.RecordCount);
    I := 0;
    while not Query.Eof do
    begin
      GroupColor[I] := StringToColor(Query.Fields[0].AsString);
      Inc(I);
      Query.Next;
    end;
    Query.Close;

    if Common.Config.IsKiosk then
    begin
      vTemp := '';
      OpenQuery('select NM_CODE1, '
               +'       CD_CODE '
               +'  from MS_CODE '
               +' where CD_STORE =:P0 '
               +'   and CD_KIND  =''97'' '
               +'   and NM_CODE1 not in (''Order.png'',''Order.jpg'',''OrderWheelChair.png'',''OrderWheelChair.jpg'',''OrderLowVision.png'',''OrderLowVision.jpg'',''KioskTable.png'',''KioskTable.jpg'') '
               +' order by CD_CODE',
               [Config.StoreCode]);

      KioskWaitList.Clear;
      while not Query.Eof do
      begin
        if vTemp ='' then
        begin
          vTemp := RightStr(Query.Fields[0].AsString,3);
          if (vTemp = 'png') or (vTemp = 'jpg') then
            KioskWaitImage := 'P'
          else
            KioskWaitImage := Query.Fields[0].AsString;
        end;

        if (vTemp <> '') and (vTemp = RightStr(Query.Fields[0].AsString,3)) then
          KioskWaitList.Add(Common.AppPath+'\Kiosk\'+Query.Fields[0].AsString);
        Query.Next;
      end;
      Query.Close;
    end;


    {VAN 셋팅}
    if Config.PosNo <> '' then
    begin
      OpenQuery('select NM_CODE5, '
               +'       NM_CODE6, '
               +'       NM_CODE9, '
               +'       NM_CODE10, '
               +'       NM_CODE12, '
               +'       NM_CODE18, '
               +'       NM_CODE19 '
               +'  from MS_CODE '
               +' where CD_STORE =:P0 '
               +'   and CD_KIND  =''01'' '
               +'   and NM_CODE1 =:P1 ',
               [Config.StoreCode,
                Config.PosNo]);

      if not Query.Eof then
      begin
        Config.van_trd       := StrToIntDef(Query.FieldByName('NM_CODE5').AsString,0);
        Config.van_Terid     := Trim(Query.FieldByName('NM_CODE6').AsString);
        Config.BizNo         := GetOnlyNumber(Query.FieldByName('NM_CODE9').AsString);
        Config.SerialNo      := Query.FieldByName('NM_CODE10').AsString;
        Config.VanEasyPay    := Query.FieldByName('NM_CODE18').AsString;
        Config.VanWorkingKey := Query.FieldByName('NM_CODE19').AsString;

        ICCard.TerminalID       := Config.van_Terid;
        ICCard.SerialNo         := Config.SerialNo;
        ICCard.RealMode         := Config.van_Terid <> 'cardtest';
        ICCard.BizNo            := Config.BizNo;
        ICCard.PosVer           := GetFileVersion(Application.ExeName);
        ICCard.LogPath          := AppPath;
      end;
      Query.Close;

      case Common.Config.van_trd of
        vanKFTC   : ICCard.VAN := vtKFTC;
        vanSmartro: ICCard.VAN := vtSmartro;
        vanSPC    : ICCard.VAN := vtSPC;
        vanKIS    : ICCard.VAN := vtKIS;
        vanJTNET  : ICCard.VAN := vtJTNET;
        vanDaou   : ICCard.VAN := vtDaou;
        vanFDIK   : ICCard.VAN := vtFDIK;
      end;
      Query.Close;
    end;
  end;

  ////////////////////   주방프린터 정보 //////////////////////
  Query.Options.QueryRecCount := true;
  OpenQuery('select a.CD_CODE, '       //0
           +'       b.NM_CODE2, '      //1
           +'       case a.NM_CODE3 when ''LPT'' then ''0'' '
           +'                       when ''Ethernet(LAN)'' then ''E'' '
           +'                       else substring(a.nm_code3,4,12) '
           +'       end as PORT, '     //2
           +'       a.NM_CODE1, '      //3
           +'       a.NM_CODE4, '      //4
           +'       a.NM_CODE5, '      //5
           +'       a.NM_CODE8, '      //6
           +'       a.NM_CODE9, '      //7
           +'       a.NM_CODE10, '     //8
           +'       a.NM_CODE11, '     //9
           +'       a.NM_CODE12, '      //10
           +'       a.NM_CODE6, '       //11 출력매수
           +'       b.NM_CODE1 as POS_NO, '  //12 연결포스번호
           +'       a.NM_CODE13, '      //13
           +'       a.NM_CODE7, '       //14
           +'       a.NM_CODE14, '       //15
           +'       a.NM_CODE15 '       //16
           +'  from MS_CODE a inner join '
           +'       MS_CODE b on a.CD_STORE = b.CD_STORE and a.NM_CODE2 = b.NM_CODE1 '
           +' where a.CD_STORE  =:P0 '
           +'   and a.CD_KIND   =''02'' '
           +'   and a.DS_STATUS =''0'' '
           +'   and b.CD_KIND   =''01'' '
           +' order by a.CD_CODE desc ',
           [Config.StoreCode]);

  SetLength(KitchenPrinter,    Query.RecordCount);
  SetLength(BefKitchenPrinter, Query.RecordCount);
  I := 0;
  vIsLink := false;
  while not Query.Eof do
  begin
    KitchenPrinter[I].Code          := Query.Fields[0].AsString;
    KitchenPrinter[I].Ip            := CtoC(Query.Fields[1].AsString,' ','');
    KitchenPrinter[I].EthernetIP    := CtoC(Query.Fields[9].AsString,' ','');
    KitchenPrinter[I].Device        := Query.Fields[4].AsInteger;
    KitchenPrinter[I].Port          := Query.Fields[2].AsString;
    KitchenPrinter[I].BaudRate      := StoI(Query.Fields[5].AsString);
    KitchenPrinter[I].Name          := Query.Fields[3].AsString;
    KitchenPrinter[I].Floor         := Query.Fields[6].AsString;
    KitchenPrinter[I].PrintFloor    := Query.Fields[7].AsString;
    KitchenPrinter[I].IsFirst       := Query.Fields[8].AsString = '1';
    KitchenPrinter[I].IsKDS         := Query.Fields[10].AsString = '1';
    KitchenPrinter[I].Count         := StrToIntDef(Query.Fields[11].AsString,1);
    KitchenPrinter[I].Link          := false;
    KitchenPrinter[I].LinkPOS       := Query.Fields[12].AsString;
    KitchenPrinter[I].Col           := StrToIntDef(Query.Fields[13].AsString,0);
    KitchenPrinter[I].TopMargin     := StrToIntDef(Query.Fields[14].AsString,0);
    KitchenPrinter[I].BottomMargin  := StrToIntDef(Query.Fields[15].AsString,0);
    KitchenPrinter[I].LetsOrderOnly := Query.Fields[16].AsString = 'Y';
    KitchenPrinter[I].MenuList      := TStringList.Create;

    BefKitchenPrinter[I].Code       := Query.Fields[0].AsString;
    BefKitchenPrinter[I].Ip         := CtoC(Query.Fields[1].AsString,' ','');
    BefKitchenPrinter[I].EthernetIP := CtoC(Query.Fields[9].AsString,' ','');
    BefKitchenPrinter[I].Device     := Query.Fields[4].AsInteger;
    BefKitchenPrinter[I].Port       := Query.Fields[2].AsString;
    BefKitchenPrinter[I].BaudRate   := StoI(Query.Fields[5].AsString);
    BefKitchenPrinter[I].Name       := Query.Fields[3].AsString;
    BefKitchenPrinter[I].Floor      := Query.Fields[6].AsString;
    BefKitchenPrinter[I].PrintFloor := Query.Fields[7].AsString;
    BefKitchenPrinter[I].IsFirst    := Query.Fields[8].AsString = '1';
    BefKitchenPrinter[I].IsKDS      := Query.Fields[10].AsString = '1';
    BefKitchenPrinter[I].Count      := StrToIntDef(Query.Fields[11].AsString,1);
    BefKitchenPrinter[I].Link       := false;
    BefKitchenPrinter[I].LinkPOS    := Query.Fields[12].AsString;
    BefKitchenPrinter[I].Col           := StrToIntDef(Query.Fields[13].AsString,0);
    BefKitchenPrinter[I].TopMargin     := StrToIntDef(Query.Fields[14].AsString,0);
    BefKitchenPrinter[I].BottomMargin  := StrToIntDef(Query.Fields[15].AsString,0);
    BefKitchenPrinter[I].LetsOrderOnly := Query.Fields[16].AsString = 'Y';
    BefKitchenPrinter[I].MenuList      := TStringList.Create;

    //영수증을 주방프린터로 출력한다고 했을때 프린터 기종을 찾음
    if Config.RcpToKitchen then
    begin
      if Config.PosIP = KitchenPrinter[I].Ip then
      begin
        Config.ReceiptPrinterDev      := KitchenPrinter[I].Device;
        if KitchenPrinter[I].Port <> 'E' then
          Config.ReceiptPrinterPort     := KitchenPrinter[I].Port;
        Config.KitchenIndex := I;
      end;
    end;
    Query.Next;
    Inc(I);
  end;

  //주방프린터가 없으면 영수증을 주방으로 출력하는 옵션을 해제한다
  if I = 0 then
    Config.RcpToKitchen := false;

  if Config.RcpToKitchen and (GetOption(379) = '1') then
  begin
    For I := 0 to  High(KitchenPrinter) do
      if (KitchenPrinter[I].IP = Common.Config.PosIP) and (KitchenPrinter[I].Port = Config.ReceiptPrinterPort) then
      begin
        KitchenPrinter[I].Link          := true;
        BefKitchenPrinter[I].Link       := true;
      end;
  end;

  //푸드코트 기능 또는 다중사업자
  if (GetOption(231) = '1') or (GetOption(60) = '1') then
  begin
    OpenQuery('select * '
             +'  from MS_TRD '
             +' where DS_TRDPL  = ''C'' '
             +'   and DS_STATUS =0 '
             +'   and CD_STORE  =:P0',
             [Config.StoreCode]);

    SetLength(Corner, Query.RecordCount);
    I := 0;
    while not Query.Eof do
    begin
      Corner[I].Code    := Query.FieldByName('CD_TRDPL').AsString;
      Corner[I].Name    := Query.FieldByName('NM_TRDPL').AsString;
      Corner[I].BizNo   := Query.FieldByName('NO_BIZER').AsString;
      Corner[I].Boss    := Query.FieldByName('NM_BOSS').AsString;
      Corner[I].Addr    := Query.FieldByName('ADDR1').AsString+' '+Query.FieldByName('ADDR2').AsString;
      Corner[I].TelNo   := SetTelephone(Query.FieldByName('TEL_MOBILE').AsString);
      Corner[I].VanTID  := Trim(Query.FieldByName('VAN_TID').AsString);
      Corner[I].VanSerial:= Query.FieldByName('VAN_SERIALNO').AsString;
      Corner[I].SaleAmt := 0;
      Query.Next;
      Inc(I);
    end;
  end;
  Query.Close;
  Query.Options.QueryRecCount := false;

  OpenQuery('select * '
           +'  from MS_CODE '
           +' where CD_STORE =:P0 '
           +' order by CD_KIND, CD_CODE ',
           ['0000']);
  while not Query.Eof do
  begin
    //주문금액
    if (Query.FieldByName('CD_KIND').AsString = '01') and (Query.FieldByName('CD_CODE').AsString = '001') then
    begin
      SetLength(DeliverySplit.BaeminTotAmt,  Query.FieldByName('DS_STATUS').AsInteger);
      for vIndex := 1 to Query.FieldByName('DS_STATUS').AsInteger do
        DeliverySplit.BaeminTotAmt[vIndex-1] := Query.FieldByName(Format('NM_CODE%d',[vIndex])).AsString;
    end;
    if (Query.FieldByName('CD_KIND').AsString = '02') and (Query.FieldByName('CD_CODE').AsString = '001') then
    begin
      SetLength(DeliverySplit.CoupangTotAmt,  Query.FieldByName('DS_STATUS').AsInteger);
      for vIndex := 1 to Query.FieldByName('DS_STATUS').AsInteger do
        DeliverySplit.CoupangTotAmt[vIndex-1] := Query.FieldByName(Format('NM_CODE%d',[vIndex])).AsString;
    end;
    if (Query.FieldByName('CD_KIND').AsString = '03') and (Query.FieldByName('CD_CODE').AsString = '001') then
    begin
      SetLength(DeliverySplit.YogiyoTotAmt,  Query.FieldByName('DS_STATUS').AsInteger);
      for vIndex := 1 to Query.FieldByName('DS_STATUS').AsInteger do
        DeliverySplit.YogiyoTotAmt[vIndex-1] := Query.FieldByName(Format('NM_CODE%d',[vIndex])).AsString;
    end;
    //주문번호
    if (Query.FieldByName('CD_KIND').AsString = '01') and (Query.FieldByName('CD_CODE').AsString = '002') then
    begin
      SetLength(DeliverySplit.BaeminDeliveryNo,  Query.FieldByName('DS_STATUS').AsInteger);
      for vIndex := 1 to Query.FieldByName('DS_STATUS').AsInteger do
        DeliverySplit.BaeminDeliveryNo[vIndex-1] := Query.FieldByName(Format('NM_CODE%d',[vIndex])).AsString;
    end;
    if (Query.FieldByName('CD_KIND').AsString = '02') and (Query.FieldByName('CD_CODE').AsString = '002') then
    begin
      SetLength(DeliverySplit.CoupangDeliveryNo,  Query.FieldByName('DS_STATUS').AsInteger);
      for vIndex := 1 to Query.FieldByName('DS_STATUS').AsInteger do
        DeliverySplit.CoupangDeliveryNo[vIndex-1] := Query.FieldByName(Format('NM_CODE%d',[vIndex])).AsString;
    end;
    if (Query.FieldByName('CD_KIND').AsString = '03') and (Query.FieldByName('CD_CODE').AsString = '002') then
    begin
      SetLength(DeliverySplit.YogiyoDeliveryNo,  Query.FieldByName('DS_STATUS').AsInteger);
      for vIndex := 1 to Query.FieldByName('DS_STATUS').AsInteger do
        DeliverySplit.YogiyoDeliveryNo[vIndex-1] := Query.FieldByName(Format('NM_CODE%d',[vIndex])).AsString;
    end;
    //주문서 타이틀
    if (Query.FieldByName('CD_KIND').AsString = '01') and (Query.FieldByName('CD_CODE').AsString = '003') then
    begin
      SetLength(DeliverySplit.BaeminTitle,  Query.FieldByName('DS_STATUS').AsInteger);
      for vIndex := 1 to Query.FieldByName('DS_STATUS').AsInteger do
        DeliverySplit.BaeminTitle[vIndex-1] := Query.FieldByName(Format('NM_CODE%d',[vIndex])).AsString;
    end;
    if (Query.FieldByName('CD_KIND').AsString = '02') and (Query.FieldByName('CD_CODE').AsString = '003') then
    begin
      SetLength(DeliverySplit.CoupangTitle,  Query.FieldByName('DS_STATUS').AsInteger);
      for vIndex := 1 to Query.FieldByName('DS_STATUS').AsInteger do
        DeliverySplit.CoupangTitle[vIndex-1] := Query.FieldByName(Format('NM_CODE%d',[vIndex])).AsString;
    end;
    if (Query.FieldByName('CD_KIND').AsString = '03') and (Query.FieldByName('CD_CODE').AsString = '003') then
    begin
      SetLength(DeliverySplit.YogiyoTitle,  Query.FieldByName('DS_STATUS').AsInteger);
      for vIndex := 1 to Query.FieldByName('DS_STATUS').AsInteger do
        DeliverySplit.YogiyoTitle[vIndex-1] := Query.FieldByName(Format('NM_CODE%d',[vIndex])).AsString;
    end;

    Query.Next;
  end;
  Query.Close;
  isReceiptToKitehcn := Config.RcpToKitchen and (GetOption(379) = '1');

  if not Assigned(NumPan_F) then
  begin
    NumPan_F       := TNumPan_F.Create(Application);
    if Common.Config.DualSize in [1,2] then NumPan_F.DefaultMonitor := dmDesktop;
  end;

  //주문전용포스가 아닐때
  if Common.PosType <> ptOnlyOrder then
  begin
    if not Assigned(CashRcp_F) then
      CashRcp_F      := TCashRcp_F.Create(Application);
    if not Assigned(RcpChange_F) then
    begin
      RcpChange_F    := TRcpChange_F.Create(Application);
      RcpChange_F.Height := 768;
      RcpChange_F.Width  := 1024;
    end;
    if not Assigned(Cash_F) then
      Cash_F         := TCash_F.Create(Application);
    if not Assigned(Check_F) then
      Check_F        := TCheck_F.Create(Application);
  end;
  if not Assigned(CustomerInfo_F) then
    CustomerInfo_F := TCustomerInfo_F.Create(Application);

  if (GetOption(92) = '1') and not Assigned(UPlus_F) then
    UPlus_F     := TUPlus_F.Create(Application);
end;

////////////////////////////////////////////////////////////////////////////////
// Name         : SelectMemberInfo
// Type         : procedure
// Explanation  : 회원정보조회
////////////////////////////////////////////////////////////////////////////////
procedure TCommon.SelectMemberInfo(aMemberNo,aCardNo,aTelNo:String);
var vFirstRow :Integer;
    vSearchType,
    vSearchData,
    vTempData,
    vData,
    vParamsType,
    vResultStr   :WideString;
    vRowList : TStringList;
    vColList : TStringList;
    vIndex   : Integer;
    vResult  : Boolean;
    vBefMemberCode :String;
    vWhere   : String;
begin
  if (aMemberNo='') and (aCardNo='') and (aTelNo='') then Exit;
  vBefMemberCode := Member.Code;

  if (aCardNo <> '') or Common.isMemberCardNo(aCardNo) then
  begin
    vWhere      := Format('and a.NO_CARD = ''%s'' ',[aCardNo]);
    vSearchType := 'C';
    vSearchData := aCardNo;
  end
  else if aTelNo <> '' then
  begin
    vWhere      := Format('and a.TEL_MOBILE = ''%s'' ',[aTelNo]);
    vSearchType := 'T';
    vSearchData := aTelNo;
  end
  else
  begin
    vWhere      := Format('and a.CD_MEMBER = ''%s'' ',[aMemberNo]);
    vSearchType := 'N';
    vSearchData := aMemberNo;
  end;


  DM.OpenQuery('select a.*, '
              +'       a.TEL_MOBILE as MOBILE_TEL, '
              +'       a.TEL_HOME as HOME_TEL, '
              +'       Ifnull(a.TOTAL_POINT,0) as PNT_TOTAL, '
              +'       b.NM_CODE1, '
              +'       ifnull(b.NM_CODE2, 0) as NM_CODE2, '
              +'       b.NM_CODE17, '
              +'       d.NM_SAWON '
              +'  from MS_MEMBER a left outer join '
              +'       MS_CODE   b on b.CD_STORE = a.CD_STORE and b.CD_CODE   = a.DS_MEMBER and b.CD_KIND = ''05'' left outer join '
              +'       MS_SAWON  d on d.CD_STORE = a.CD_STORE and d.CD_SAWON  = a.CD_DAMDANG '
              +' where a.CD_STORE   =:P0 '
              +vWhere
              +'   and a.DS_STATUS  =''0'' ',
              [Config.StoreCode]);
  if not DM.Query.Eof then
  begin
    Member.Code        := DM.Query.FieldByName('CD_MEMBER').AsString;
    Member.Name        := DM.Query.FieldByName('NM_MEMBER').AsString;
    Member.CardNo      := DM.Query.FieldByName('NO_CARD').AsString;
    Member.MobileTel   := SetTelephone(DM.Query.FieldByName('MOBILE_TEL').AsString);
    Member.HomeTel     := SetTelephone(DM.Query.FieldByName('HOME_TEL').AsString);
    Member.dt_visit    := FormatMaskText('!0000년 90월 90일;0; ',DM.Query.FieldByName('YMD_VISIT').AsString);
    Member.Point       := StrToIntDef(DM.Query.FieldByName('PNT_TOTAL').AsString,0);
    Member.Yn_trust    := DM.Query.FieldByName('YN_TRUST').AsString;
    Member.cd_class    := DM.Query.FieldByName('DS_MEMBER').AsString;
    Member.nm_class    := DM.Query.FieldByName('NM_CODE1').AsString;
    Member.Dc_Rate     := StrToIntDef(DM.Query.FieldByName('NM_CODE2').AsString,0);
    Member.addr1       := DM.Query.FieldByName('ADDR1').AsString;
    Member.addr2       := DM.Query.FieldByName('ADDR2').AsString;
    Member.Remark      := DM.Query.FieldByName('REMARK').AsString;
    Member.no_cashrcp  := DM.Query.FieldByName('NO_CASHRCP').AsString;
    Member.DamdangCode := DM.Query.FieldByName('CD_DAMDANG').AsString;
    Member.DamdangName := DM.Query.FieldByName('NM_SAWON').AsString;
    Member.Stamp       := DM.Query.FieldByName('TOTAL_STAMP').AsInteger;
    Member.CreditAmt   := DM.Query.FieldByName('AMT_TRUST').AsInteger;
    Member.DamdangName := DM.Query.FieldByName('NM_SAWON').AsString;
    Member.DcType      := DM.Query.FieldByName('NM_CODE17').AsString;
    Member.AgeCode     := DM.Query.FieldByName('CD_AGE').AsString;
  end;
  DM.Query.Close;
  WriteLog('work', Format('회원조회[%d, %d] - %s', [Member.Point, Member.CreditAmt, Member.Code]));

  if vBefMemberCode <> Member.Code then
  begin
    PreSent.PointAmt := 0;
    PreSent.PointDc  := 0;
    PreSent.UsePnt   := 0;
    PreSent.OccurPnt := 0;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Name         : GetIni
// Type         : procedure
// Explanation  : INI 파일 내용 가져오기
////////////////////////////////////////////////////////////////////////////////
procedure TCommon.GetIni;
var vIndex :Integer;
    vTemp :String;
    vSourceFile,vTargetFile : TFileStream;
begin
  with TIniFile.Create(AppPath+filConfigIni), Config do
    try
      EndUser         := ReadString('POS', '최종사용자',     '999999');      //사원번호
      vTemp           := ReadString('공통', 'DB_IP',       '127.0.0.1');     //서버IP
      ServerIP        := IfThen(Pos('\',vTemp)=0, vTemp, Copy(vTemp, 1, Pos('\',vTemp)-1));
      if ReadBool('POS', '영수증출력',     True) then
        SetPrintMode := pmPrint
      else
        SetPrintMode := pmNoPrint;

      AutoStart := ReadString('POS', '자동실행',    'N');
      AutoLogin := ReadBool('POS', '자동로그인',     False);
      if GetOption(167) = '1' then
        SetBillPrintMode  := ReadBool('POS', '고객주문서출력',  True)
      else
        SetBillPrintMode  := GetOption(11) = '1';

      IsAcctKitchenPrint := ReadBool('POS', '계산시주방주문서출력',     False);
      RcpToKitchen    := ReadBool('POS', '영수증->주방프린터',     False);
      AvailFloor      := ReadString('POS', '사용층',      '000');            //사용층
      if AvailFloor = '' then AvailFloor := '000';
      DefaultFloor    := ReadString('POS', '기본층',      '001');            //사용층
      if DefaultFloor = '' then DefaultFloor := '001';

      PosLanguage     := ReadString('POS', 'Language', 'KO');
      URL             := ReadString('POS', 'URL',          '');            //plu구분
      HelpURL         := ReadString('POS', 'HELPURL',      'http://ezh.kr/extremepos/');

      ReceiptPrinterDev         := ReadInteger('DEVICE', '프린터기종',  0);
      ReceiptPrinterPort        := ReadString('DEVICE', '프린터포트',  '0');
      ReceiptPrinterBaudRate    := ReadInteger('DEVICE', '프린터속도',  0);
      PrintBottomMargin := ReadInteger('DEVICE', '영수증하단여백',  0);
      ReceiptPrinterCheck       := ReadBool('DEVICE', '프린터체크',  False);

      CustPrinterCode := ReadString('DEVICE', '고객영수증프린터', '000');
      CustPrinterCode := Ifthen(CustPrinterCode='','000', CustPrinterCode);
      CustPrinter2Code := ReadString('DEVICE', '고객영수증프린터2', '');
      DIDPickupPos     := ReadString('DEVICE', 'DID_PICKUP', '');

      DeliveryPrinterCode := ReadString('DEVICE', '배달전표프린터', '000');
      DeliveryPrinterCode := Ifthen(DeliveryPrinterCode='','000', DeliveryPrinterCode);
      DeliveryReceiptPrinterCode := ReadString('DEVICE', '배달영수증프린터', '');
      if DeliveryReceiptPrinterCode = '' then
        DeliveryReceiptPrinterCode := DeliveryPrinterCode;

      DeliveryLinkPrinter[0].InComPort  := ReadInteger('DEVICE', '연결포트',  0);
      DeliveryLinkPrinter[0].OutComPort := ReadString('DEVICE', '연결프린터', '000');
      DeliveryLinkPrinter[0].Collection := ReadString('DEVICE', '연결프린터_수집', 'Y');
      DeliveryLinkPrinter[1].InComPort  := ReadInteger('DEVICE', '연결2포트',  0);
      DeliveryLinkPrinter[1].OutComPort := ReadString('DEVICE', '연결프린터2', '000');
      DeliveryLinkPrinter[1].Collection := ReadString('DEVICE', '연결프린터2_수집', 'Y');
      DeliveryLinkPrinter[2].InComPort  := ReadInteger('DEVICE', '연결3포트',  0);
      DeliveryLinkPrinter[2].OutComPort := ReadString('DEVICE', '연결프린터3', '000');
      DeliveryLinkPrinter[2].Collection := ReadString('DEVICE', '연결프린터3_수집', 'Y');
      DeliveryLinkPrinter[3].InComPort  := ReadInteger('DEVICE', '연결4포트',  0);
      DeliveryLinkPrinter[3].OutComPort := ReadString('DEVICE', '연결프린터4', '000');
      DeliveryLinkPrinter[3].Collection := ReadString('DEVICE', '연결프린터4_수집', 'Y');

      if DeliveryLinkPrinter[0].OutComPort = '' then
        DeliveryLinkPrinter[0].OutComPort := '000';
      if DeliveryLinkPrinter[1].OutComPort = '' then
        DeliveryLinkPrinter[1].OutComPort := '000';
      if DeliveryLinkPrinter[2].OutComPort = '' then
        DeliveryLinkPrinter[2].OutComPort := '000';
      if DeliveryLinkPrinter[3].OutComPort = '' then
        DeliveryLinkPrinter[3].OutComPort := '000';

      DeliveryDisplay  := ReadString('DEVICE',  '배달화면해상도', '');


      DualSize        := ReadInteger('DEVICE', '듀얼해상도',  0);
      DualMode        := ReadInteger('DEVICE', '듀얼모드',  0);      
      DualText        := ReadString('DEVICE', '듀얼광고'   ,'');
      LabelPrinterPort := ReadInteger('DEVICE', '라벨프린터포트' ,0);
      BellPort        := ReadInteger('DEVICE', '진동벨포트' ,0);
      BellDev         := ReadInteger('DEVICE', '진동벨장비' ,0);
      Cid_Port        := ReadInteger('DEVICE', 'CID'         ,0);
      DemonCid_Port   := ReadInteger('DEVICE', 'DEMONCID'    ,0);
      Check_Port      := ReadInteger('DEVICE', '수표포트'    ,0);
      HandScannerPort := ReadInteger('DEVICE', '스캐너'      ,0);
      TableKeyPort    := ReadInteger('DEVICE', 'TableKey'    ,0);
      FixScannerPort  := ReadInteger('DEVICE', '고정스캐너'      ,0);
      PassPortPort    := ReadInteger('DEVICE', '여권리더기' ,0);
      TableBellPort   := ReadInteger('DEVICE', '테이블호출벨' ,0);
      AutoUpdate      := ReadBool('POS','UPDATE'            ,True);
      PowerOff        := ReadBool('POS','POWEROFF'          ,False);
      ReceiptLogPrint := ReadBool('POS','LOG'               ,False);
      FixPhoneNo      := ReadString('DEVICE', 'FixPhoneNo', '');
      PrintColum      := ReadInteger('DEVICE', '프린터칼럼', 0);
      SmartPosDemon   := ReadBool('POS','스마트포스데몬'    ,false);
      SmartPad        := ReadBool('POS','스마트패드'    ,false);
      LetsOrderNoShow := ReadBool('POS','레츠오더화면표시'    ,false);
      KioskDispenserPort := ReadInteger('DEVICE', 'DISPENSER',     0);
      IsKioskCash        := KioskDispenserPort > 0;
      notKioskTouch      := ReadBool('DEVICE', '키오스크터치',    false);
      PosCatUse          := ReadBool('DEVICE','단말기연동'    ,false);
      ServiceTxt         := ReadString('POS',  '서비스', '(서비스)');
      PackingTxt         := ReadString('POS',  '포장', '(포장)');
      //보안리더기를 사용하는 매장인데 이포스만 단말기 연동을 사용시
      if PosCatUse then
      begin
        Options[379] := '1';
        Option_379   := '1';
      end;

      vTemp           := ReadString('POS', 'TimePLU1', '0,00:00,00:00,,');
      for vIndex := 0 to 3 do
        TimePlu[1,vIndex] := CopyPos(vTemp,',',vIndex);
      vTemp           := ReadString('POS', 'TimePLU2', '0,00:00,00:00,,');
      for vIndex := 0 to 3 do
        TimePlu[2,vIndex] := CopyPos(vTemp,',',vIndex);
      vTemp           := ReadString('POS', 'TimePLU3', '0,00:00,00:00,,');
      for vIndex := 0 to 3 do
        TimePlu[3,vIndex] := CopyPos(vTemp,',',vIndex);
    finally
      Free;
    end;
end;

////////////////////////////////////////////////////////////////////////////////
// Name         : SetIni
// Type         : procedure
// Explanation  : INI 파일 내용 저장하기
////////////////////////////////////////////////////////////////////////////////
procedure TCommon.SetIni;
var vIndex :Integer;
    vTemp :String;
begin
  with TIniFile.Create(AppPath+_INIFILENAME), Config do
  try
    if Trim(UserCode) <> '' then
      WriteString('POS',     '최종사용자',  UserCode  );            //사원번호

    WriteString('POS',     '사용층',      AvailFloor    );
    WriteString('POS',     '기본층',      DefaultFloor    );
    WriteString('POS',    'URL',          URL    );
    WriteString('POS',    'HELPURL',      HelpURL    );
    WriteBool('POS', '영수증출력',        SetPrintMode = pmPrint );    //영수증출력여부
    WriteBool('POS', '고객주문서출력',        SetBillPrintMode);
    WriteBool('POS', '계산시주방주문서출력',    IsAcctKitchenPrint);
    WriteBool('POS', '영수증->주방프린터',     RcpToKitchen);
    WriteString('POS', '자동실행',        AutoStart);
    WriteBool('POS', '자동로그인',        AutoLogin );                 //영수증출력여부
    if AutoLogin then
      WriteString('POS', '로그인암호',        Encrypt(Common.Config.UserPass, _CryptKey))
    else
      WriteString('POS', '로그인암호',        '');

    WriteInteger('DEVICE', '프린터기종',  ReceiptPrinterDev   );
    WriteString('DEVICE', '프린터포트',  ReceiptPrinterPort  );
    WriteInteger('DEVICE', '프린터속도',  ReceiptPrinterBaudRate  );
    WriteInteger('DEVICE', '영수증하단여백',  PrintBottomMargin  );
    WriteBool('DEVICE',    '프린터체크',  ReceiptPrinterCheck  );
    WriteInteger('DEVICE', '연결포트',  Common.DeliveryLinkPrinter[0].InComPort  );
    WriteInteger('DEVICE', '연결2포트',  Common.DeliveryLinkPrinter[1].InComPort  );
    WriteInteger('DEVICE', '연결3포트',  Common.DeliveryLinkPrinter[2].InComPort  );
    WriteInteger('DEVICE', '연결4포트',  Common.DeliveryLinkPrinter[3].InComPort  );
    WriteString('DEVICE',  '고객영수증프린터', CustPrinterCode);
    WriteString('DEVICE',  '고객영수증프린터2', CustPrinter2Code);
    WriteString('DEVICE',  '배달전표프린터', DeliveryPrinterCode);
    WriteString('DEVICE',  '배달영수증프린터', DeliveryReceiptPrinterCode);
    WriteString('DEVICE',  '연결프린터', Common.DeliveryLinkPrinter[0].OutComPort);
    WriteString('DEVICE',  '연결프린터2', Common.DeliveryLinkPrinter[1].OutComPort);
    WriteString('DEVICE',  '연결프린터3', Common.DeliveryLinkPrinter[2].OutComPort);
    WriteString('DEVICE',  '연결프린터4', Common.DeliveryLinkPrinter[3].OutComPort);
    WriteString('DEVICE',  '연결프린터_수집', Common.DeliveryLinkPrinter[0].Collection);
    WriteString('DEVICE',  '연결프린터2_수집', Common.DeliveryLinkPrinter[1].Collection);
    WriteString('DEVICE',  '연결프린터3_수집', Common.DeliveryLinkPrinter[2].Collection);
    WriteString('DEVICE',  '연결프린터4_수집', Common.DeliveryLinkPrinter[3].Collection);

    WriteString('DEVICE',  '배달화면해상도', DeliveryDisplay);
    WriteInteger('DEVICE', '듀얼해상도',  DualSize  );
    WriteInteger('DEVICE', '듀얼모드',    DualMode  );
    WriteString('DEVICE',  '듀얼광고',    DualText);
    WriteInteger('DEVICE', '라벨프린터포트',LabelPrinterPort);
    WriteInteger('DEVICE', '진동벨포트'    ,BellPort);
    WriteInteger('DEVICE', '진동벨장비'    ,BellDev);
    WriteInteger('DEVICE', 'CID'         ,Cid_Port);
    WriteInteger('DEVICE', 'DEMONCID'    ,DemonCid_Port);
    WriteInteger('DEVICE', '스캐너'      ,HandScannerPort);
    WriteInteger('DEVICE', 'TableKey'      ,TableKeyPort);
    WriteInteger('DEVICE', '고정스캐너'      ,FixScannerPort);
    WriteInteger('DEVICE', '테이블호출벨'    ,TableBellPort);
    if ReadString('POS', 'UPDATE_PWD' ,'') = '15444171' then
      WriteBool('POS',       'UPDATE',      True)
    else
      WriteBool('POS',       'UPDATE',      AutoUpdate);
    WriteString('DEVICE',    'DID_PICKUP', DIDPickupPos);
    WriteBool('POS',       'POWEROFF',  PowerOff);
    WriteString('POS',     'VAN',          VANTRDPL[Common.Config.van_trd]);
    WriteString('DEVICE', 'FixPhoneNo', FixPhoneNo);
    WriteInteger('DEVICE',    '프린터칼럼',  PrintColum);
    WriteBool('POS',       '스마트포스데몬', SmartPosDemon);
    WriteBool('POS',       '스마트패드', SmartPad);
    WriteBool('POS',       '레츠오더화면표시', LetsOrderNoShow);

    WriteInteger('DEVICE',    'DISPENSER',     KioskDispenserPort);
    WriteBool('DEVICE',       '키오스크터치',  notKioskTouch);
    WriteBool('DEVICE',       '단말기연동',  PosCatUse);

    vTemp := EmptyStr;
    for vIndex := 0 to 3 do
      vTemp := vTemp + Format('%s,',[TimePlu[1,vIndex]]);
    WriteString('POS', 'TimePlu1', vTemp);
    vTemp := EmptyStr;
    for vIndex := 0 to 3 do
      vTemp := vTemp + Format('%s,',[TimePlu[2,vIndex]]);
    WriteString('POS', 'TimePlu2', vTemp);
    vTemp := EmptyStr;
    for vIndex := 0 to 3 do
      vTemp := vTemp + Format('%s,',[TimePlu[3,vIndex]]);
    WriteString('POS', 'TimePlu3', vTemp);
  finally
    Free;
  end;
end;


////////////////////////////////////////////////////////////////////////////////
// Name         : GridDrawCell
// Type         : procedure
// Explanation  : 각 입력 화면 그리드 셋팅
////////////////////////////////////////////////////////////////////////////////
procedure TCommon.GridDrawCell(Sender: TObject; Col, Row: Integer;
  Rect: TRect; State: TGridDrawState);
var  vAlign : integer;
begin
  if TStringGrid(Sender).Name <> 'Dual_sGrd' then
    TStringGrid(Sender).Canvas.Font.Size := Common.Config.ListFontSize
  else
    TStringGrid(Sender).Canvas.Font.Size := Common.Config.DualGridFontSize;

  if TStringGrid(Sender).Name <> 'GroupTable_sGrd' then
  begin
    if TStringGrid(Sender).Cells[0,0] = '' then
    begin
      TStringGrid(Sender).Canvas.Brush.Color := clWhite;
      TStringGrid(Sender).Canvas.Font.Color  := clBlack
    end
    else if TStringGrid(Sender).Name = 'Cancel_sGrd' then
    begin
      TStringGrid(Sender).Canvas.Brush.Color := $00B3FFFF;
      TStringGrid(Sender).Canvas.Font.Color  := clBlack
    end
    else if TStringGrid(Sender).Name <> 'Dual_sGrd' then
    begin
      case WorkState of
        wsMagam :
        begin
          TStringGrid(Sender).Canvas.Font.Color  := clWhite;
          TStringGrid(Sender).Canvas.Font.Color  := clRed;
        end;
        else
        begin
          if gdSelected in State then
          begin
            TStringGrid(Sender).Canvas.Font.Color  := clWhite;
            TStringGrid(Sender).Canvas.Brush.Color := $00AE5700;
          end
          else
          begin
            if TStringGrid(Sender).Cells[GDM_YN_ORDER,Row] = 'Y' then
              TStringGrid(Sender).Canvas.Brush.Color := $00FFF4DD
            else
              TStringGrid(Sender).Canvas.Brush.Color := clWhite;;

            TStringGrid(Sender).Canvas.Font.Color  := clBlack;
          end;

          if ((GetOption(350) = '2') or (GetOption(350) = '3')) and (TStringGrid(Sender).Cells[GDM_CD_MENU1,Row] <> '') then
          begin
            if TStringGrid(Sender).Cells[GDM_NO_STEP,Row] = '1' then
              TStringGrid(Sender).RowHeights[Row] := 0
            else
              TStringGrid(Sender).RowHeights[Row] := -1;
            TStringGrid(Sender).Canvas.Brush.Color := clWhite;
            TStringGrid(Sender).Canvas.Font.Color  := clWhite;
            Exit;
          end;
        end;
      end;
    end
    else
    begin
      TStringGrid(Sender).Canvas.Brush.Color := clWhite;
      TStringGrid(Sender).Canvas.Font.Color  := clBlack
    end;

    case Col of
       0,1 :  vAlign  := alCenter; //가운데
       2   :  vAlign  := alLeft;   //좌측
       3..6:  vAlign  := alRight;  //우측
    end;
    Grid_Align(Sender, Col, Row, Rect, vAlign);

    // 숫자형 출력시 Format 형식   //
    case Col of
      4..6: Grid_DisplayFormat(Sender, Col, Row, Rect, 'I');
      else Grid_DisplayFormat(Sender, Col, Row, Rect, 'S');
    end;

  end
  else
  begin
    TStringGrid(Sender).Canvas.Brush.Color := clWhite;
    TStringGrid(Sender).Canvas.Font.Color  := clBlack;

    case Col of
       0   :  vAlign  := alLeft;   //좌측
       1   :  vAlign  := alRight;  //우측
    end;
    Grid_Align(Sender, Col, Row, Rect, vAlign);

    // 숫자형 출력시 Format 형식   //
    Grid_DisplayFormat(Sender, Col, Row, Rect, 'S');
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Name         : Grid_Align
// Type         : procedure
// Explanation  : 그리드의 Align 셋팅
////////////////////////////////////////////////////////////////////////////////
procedure TCommon.Grid_Align(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
var  vLeftPos,vTopPos: Integer;
     vCellStr: string;
begin
  with TStringGrid(Sender).Canvas do begin
    vCellStr := Trim(TStringGrid(Sender).Cells[ACol, ARow]);

    vTopPos  := ((Rect.Top - Rect.Bottom -TStringGrid(Sender).Canvas.TextHeight(vCellStr)) div 2) + Rect.Bottom;

    case i_align of
      1 : vLeftPos := ((Rect.Right - Rect.Left - TStringGrid(Sender).Canvas.TextWidth(vCellStr)) div 2) + Rect.Left;
      2 : vLeftPos :=  (Rect.Right - Rect.Left - TStringGrid(Sender).Canvas.TextWidth(vCellStr)) +
                        Rect.Left - 5;
      else vLeftPos := Rect.Left + 2;
    end;

    FillRect(Rect);
    TextOut(vLeftPos, vTopPos, vCellStr);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Name         : Grid_DisplayFormat
// Type         : procedure
// Explanation  : 그리드의 DisplayForma 셋팅
////////////////////////////////////////////////////////////////////////////////
procedure TCommon.Grid_DisplayFormat(Sender: TObject; ACol, ARow: Integer; Rect: TRect; aType:String);
var  xPos, yPos, vStrLen, vStrHgt : integer;
     vCellText:String;
begin
  vCellText := TStringGrid(Sender).Cells[Acol, ARow];
  if vCellText <> '' then
  begin
    if aType = 'I' then
    begin
      vCellText := FormatFloat('#,##0.##', StrToFlt(vCellText,ARow));
      vStrLen := (Sender as TStringGrid).Canvas.TextWidth(vCellText);
      xPos := Rect.Right - vStrLen - 5;
    end;

    vStrHgt := (Sender as TStringGrid).Canvas.TextHeight(vCellText);
    yPos := Rect.Top  + ((Rect.Bottom - Rect.Top) - vStrHgt ) div 2;
    (Sender as TStringGrid).Canvas.TextOut(xPos, yPos, vCellText);
  end;
end;

procedure TCommon.RowSelect(Grid:TStringGrid; ARow:Integer);
begin
   Grid.Row :=  ARow;
end;


//**************************************************************************//
//                           그리드 로우 위로
//**************************************************************************//
procedure TCommon.RowPrev(Grid:TStringGrid);
begin
  if Grid.Row > Grid.FixedRows then Grid.Row :=  Grid.Row - 1;
end;

//**************************************************************************//
//                           그리드 로우 위로
//**************************************************************************//
procedure TCommon.RowNext(Grid:TStringGrid);
begin
  if Grid.Row < Grid.RowCount-1 then Grid.Row := Grid.Row + 1;
end;

//**************************************************************************//
//                           그리드 처음으로 이동
//**************************************************************************//
procedure TCommon.RowFirst(Grid:TStringGrid);
begin
  Grid.Row  := 0;
end;

//**************************************************************************//
//                           그리드 마지막으로 이동
//**************************************************************************//
procedure TCommon.RowEnd(Grid:TStringGrid);
begin
  Grid.Row  :=  Grid.RowCount - 1;
end;

//**************************************************************************//
//                          그리드 Row 추가
//**************************************************************************//
procedure TCommon.AddRow(var Grid:TStringGrid);
begin
  if Grid.Cells[0,0] <> '' then
  begin
    Grid.RowCount := Grid.RowCount + 1;
    Grid.Row      := Grid.RowCount-1;
  end
  else
    Grid.Row := Grid.RowCount-1;
end;

//**************************************************************************//
//                          그리드 Row 삭제
//**************************************************************************//
procedure TCommon.DeleteRow(Grid:TStringGrid;Row:Integer);
begin
   Grid.Rows[Row].Clear;
   TDeleteGrid(Grid).DeleteRow(Row);
   if Row < Grid.RowCount then Grid.Row := Row;
   if Grid.Name = 'Main_sGrd' then GridRefresh(Grid);
end;

//**************************************************************************//
//                           그리드 클리어
//**************************************************************************//
procedure TCommon.ClearGrid(Grid : TStringGrid);
var I, C: integer;
begin
   for I := 0 to Grid.RowCount  do
   begin
      For C := 0 to Grid.ColCount -1 do Grid.Cells[C, I] := '';
      Grid.Rows[I].Clear;
   end;
   Grid.RowCount:=1;
end;

//**************************************************************************//
//                           그리드새로고침
//**************************************************************************//
procedure TCommon.GridRefresh(Grid:TStringGrid);
var I :Integer;
begin
   with Grid do
   begin
      if Cells[0,0] = '' then ClearGrid(Grid)
      else For I:=0 to RowCount-1 do Cells[0,I] := IntToStr(I+1);
   end;
end;

procedure TCommon.GridToGrid(FromGrid,ToGrid:TStringGrid;aAdd:Boolean);           //그리드데이터 이동
var vIndex, vCol :Integer;
begin
  if not aAdd then
  begin
    ClearGrid(ToGrid);
    ToGrid.ColCount    := FromGrid.ColCount;
    ToGrid.RowCount    := FromGrid.RowCount;
    for vIndex := 0 To FromGrid.RowCount -1 do
      ToGrid.Rows[vIndex].Assign( FromGrid.Rows[vIndex]);
     ToGrid.Row := FromGrid.Row;
  end
  else
  begin
    For vIndex := 0 To FromGrid.RowCount -1 do
    begin
      ToGrid.RowCount := ToGrid.RowCount + 1;
      ToGrid.Rows[ToGrid.RowCount-1].Assign( FromGrid.Rows[vIndex]);
    end;
  end;
end;


//***************************************************************************//
//                             회원정보 초기화                               //
//***************************************************************************//
procedure InitMemberRecord(var AValue: TMember);
begin
  with AValue do
  begin
     Code       := '';                     //회원코드번호
     Name       := '';                     //고객명
     cd_class   := '';
     nm_class   := '';                     //회원구분명
     CardNo     := '';
     MobileTel  := '';                     //연락처
     MobileTelFull := '';
     HomeTel    := '';
     dt_birth   := '';                     //생일
     dt_visit   := '';                     //최종방문일
     Dc_Rate    := 0;                      //할인율
     OrgOccurPoint := 0;
     OrgOccurStamp := 0;
     Point      := 0;                      //보유포인트
     Yn_Trust   := 'N';                    //외상가능여부
     addr1      := '';
     addr2      := '';
     Remark     := '';
     no_cashrcp := '';
     DamdangCode := '';
     DamdangName := '';
     Stamp       := 0;
     CreditAmt   := 0;
     AgeCode     := '';
  end;
end;


//***************************************************************************//
//                             회원정보 초기화                               //
//***************************************************************************//
procedure InitTableRecord(var AValue: TTable);
begin
  with AValue do
  begin
     OrderNo    := 0;         //주문번호
     OrderType  := 'T';       //주문타입
     Floor      := ifthen(Common.Config.DefaultFloor=EmptyStr, '001', Common.Config.DefaultFloor);     //층번호
     FloorName  := EmptyStr;  //층명
     Number     := 0;         //테이블번호
     Name       := EmptyStr;  //테이블명
     DamDangCode:= EmptyStr;  //담당자코드
     DamDangName:= EmptyStr;  //담당자명
     CustomerCount := 1;         //인원수
     Date       := FormatDateTime('yyyymmdd', now);  //들어온일자
     Time       := FormatDateTime('hh:nn', now);      //들어온시간
     BookingImg := EmptyStr;  //예약테이블인지 여부
     BookingNo  := EmptyStr;  //예약번호
     BookingAmt := 0;
     GroupType  := 'N';       //그룹상태 M-Master, S-Sub, N-None
     GroupAmt   := 0;         //그룹주문금액
     CustCode   := EmptyStr;  //객층코드
     DsDelivery := '';
     DeliveryNo := EmptyStr;  //배달번호
     AHeadPay := False;
     DcCode     := EmptyStr;
     Dc_Rate    := 0;
     Dc_Amt     := 0;
     Dc_Menu    := 0;
     Dc_CodeAmt := 0;
     Course     := EmptyStr;
     Local      := EmptyStr;
     Addr1      := EmptyStr;
     Addr2      := EmptyStr;
     OrderAmt   := 0;
     DsCust     := EmptyStr;
     Packing    := 'N';
     Memo       := EmptyStr;
     LapeTime   := 0;
     MemberCode := '';
     DeliveryTel := '';
     LetsOrder  := 'N';
     WaitTableNo := 0;
     isWaitTable := false;
     isCashOrder := false;
  end;
  if Assigned(AValue.AgeCode) then
    FreeAndNil(AValue.AgeCode);
  AValue.AgeCode := TStringList.Create;
  AValue.AgeCode.Clear;
end;

//***************************************************************************//
//                             상품레코드 초기화                             //
//***************************************************************************//
procedure InitMenuRecord(var AValue: TMenu);
begin
   with AValue do
   begin
     cd_menu      := EmptyStr;
     nm_menu      := EmptyStr;
     ds_menu      := 'N';
     cd_menu1     := EmptyStr;
     seq          := 1;
     no_step      := 0;
     pr_sale      := 0;
     pr_sale_db   := 0;
     pr_sale_std  := 0;
     pr_sale_tax  := 0;
     pr_sale_packing := 0;
     qty_sale     := 0;
     amt_sale     := 0;
     dc_menu      := 0;
     dc_enuri     := 0;
     no_coupon    := EmptyStr;
     dc_coupon    := 0;
     dc_member    := 0;
     dc_spc       := 0;
     no_spc       := EmptyStr;
     dc_code      := 0;
     no_code      := EmptyStr;
     ds_sale      := 'S';
     ds_tax       := '1';
     qty_nepum    := 1;
     qty_select   := 1;
     memo         := EmptyStr;
     dt_order     := EmptyStr;
     yn_order     := 'N';
     yn_dc        := 'Y';
     yn_point     := 'Y';
     yn_rcp       := 'Y';
     prt_kitchen  := 0;
     no_group     := 0;
     nm_menu_org  := EmptyStr;
     Change       := 'Y';
     pr_tip       := 0;
     pr_item      := 0;
     cd_item      := EmptyStr;
     nm_item      := EmptyStr;
     corner       := EmptyStr;
     svc          := 'N';
     yn_double    := 'N';
     cd_service   := EmptyStr;
     yn_bill      := 'Y';
     yn_kitchen   := 'Y';
     yn_ticket    := 'N';
     save_stamp   := 0;
     use_stamp    := 0;
     ds_stock     := '0';
     qty_unit     := 0;
     nm_menu_kitchen := '';
     yn_cashtemp  := 'N';
   end;
end;

//***************************************************************************//
//                    정산시 사용되는 레코드 초기화                          //
//***************************************************************************//
procedure InitPreSentRecord(var AValue: TPreSent);
begin
   with AValue do
   begin
      DsTrd        := ' ';
      RcpNo        := ' ';                   // 영수증번호
      CardSeq      := 0;                     // 신용카드 승인시
      CashSeq      := 0;                     // 현금영수증 승인시
      GoodQty      := 0;                     // 품목건수

      MenuDc       := 0;                     // 단품할인
      MemberDc     := 0;                     // 회원할인
      RcpDc        := 0;                     // 전체금액 할인
      SpcDc        := 0;                     // 행사할인금액
      CodeDc       := 0;                     // 코드할인
      VatDc        := 0;                     // 부가세할인
      EventDc      := 0;                     // 영수증번호 할인
      CouponNo     := '';
      CouponKind   := '';
      CouponType   := '';
      CouponRate   := 0;
      CouponDc     := 0;                     // 쿠폰할인금액
      CouponMember := false;
      CouponLimit  := 0;
      CouponMenu   := '';
      CouponMemberNo := '';
      CouponSaleAmt := 0;
      CutDc        := 0;                     // 단차할인
      CodeDcCode   := '';                    // 전체할인코드
      CodeDcType   := '';                    // 할인구분(0:율, 1:금액)
      CodeDcName   := '';                    // 전체할인명
      CodeDcRate   := 0;                     // 할인율
      CodeDcStdAmt := 0;                     // 할인기준금액
      CodeDcAmt    := 0;
      PointDc      := 0;                     // 포인트할인
      RcpDc_Rate   := 0;                     // 전체할인 할인율
      TaxFreeDc    := 0;
      StampDc      := 0;
      UPlusDc      := 0;
      KaKaoDc      := 0;
      LetsOrderDc  := 0;
      TotalDC      := 0;                     // 할인 합계

      DutyAmt      := 0;                     // 부가세 과세 품목 합계
      FreeAmt      := 0;                     // 면세금액
      TaxAmt       := 0;                     // 부가세
      DutyAmt_Prt  := 0;
      FreeAmt_Prt  := 0;
      TaxAmt_Prt   := 0;
      TotalAmt     := 0;                     // 합계금액
      SoonAmt      := 0;                     // 매출합계

      UsePnt       := 0;                     // 사용포인트
      OccurPnt     := 0;                     // 발생포인트
      TrustAmt     := 0;                     // 외상금액
      GiftAmt      := 0;                     // 상품권
      CardAmt      := 0;                     // 카드결제금액
      CashAmt      := 0;                     // 현금 입금액
      CheckAmt     := 0;                     // 수표금액
      BankAmt      := 0;                     // 계좌입금
      PointAmt     := 0;                     // 포인트결제
      EtcAmt       := 0;                     // 기타결제
      RcvAmt       := 0;                     // 받은 금액
      OrgRcvAmt    := 0;
      CashRcpAmt   := 0;                     // 현금영수증승인금액
      SetTip       := -1;
      CashTipAmt   := 0;
      CardTipAmt   := 0;
      TipAmt       := 0;                     // 봉사료
      ExistDcAmt   := 0;                     // 할인제외상품
      ExistPointAmt:= 0;                     // 포인트제외상품
      ExistPointUseAmt := 0;                 // 포인트사용제외상품
      ServiceAmt   := 0;                     // 서비스금액
      AddMenuAmt   := 0;
      TaxfreeNo    := '';
      TaxRefundAfterLimit   := 0;
      SaveStamp    := 0;
      UseStamp     := 0;
      OldMember    := '';
      OldSaveStamp := 0;
      OldUseStamp  := 0;

      OrgCardAmt   := 0;
      CardCancelAmt := 0;

      WRcvAmt      := 0;                     // 받을 금액
      GiveAmt      := 0;                     // 거스름돈
      ReadyChk     := False;
      CardSign     := True;                  //카드서명(True :받는다, false:안받는다)

      SaleTime     := '';
      SaleDate     := now();
      CallNo       := 0;
      CallTelNo    := '';

      CouponNo_Issue       := '';
      CouponName_Issue     := '';
      CouponType_Issue     := '';
      CouponAmt_Issue      := 0;
      CouponFromDate_Issue := '';
      CouponToDate_Issue   := '';

      DutchPayAmt  := 0;
      LetsOrderAmt := 0;
      AHeadPayAmt     := 0;
      AHeadCashAmt    := 0;
   end;

   if Assigned(AValue.TicketPrintData) then
     FreeAndNil(AValue.TicketPrintData);
   AValue.TicketPrintData := TStringList.Create;
   AValue.TicketPrintData.Clear;
end;

//***************************************************************************//
//                               카드 레코드 초기화                          //
//***************************************************************************//
procedure InitCardRecord(var AValue: TCard);
begin
  with AValue do
  begin
     Ds_Card       := 'C';                   //카드구분(C:신용카드, I:현금IC, K:카카오페이, Z:제로페이)
     Ds_trd        := dtApproval;            //승인=dtApproval, 승인취소=dtCancel 구분
     Nm_Card       := '';                    //카드종류
     cd_buy        := '';                    //매입사코드
     nm_buy        := '';                    //매입사명
     CardNo        := #12;                   //카드번호
     CardNo        := #3;                    //카드번호
     CardNo        := '';                    //카드번호
     Halbu         := ' ';                   //할부개월수
     Amt           := 0;                     //금액
     TipAmt        := 0;                     //봉사료금액
     VatAmt        := 0;                     //부가세금액
     DcAmt         := 0;                     //할인금액
     Valid         := '';                    //카드유효기간
     ChainPL       := '';                    //가맹점번호
     ApprovalNo    := '';                    //승인번호
     trd_Date      := '';                    //승인일자
     trd_Time      := '';                    //승인시간
     OrgApprovalNo  := '';                    //원승인번호
     trd_date_org  := '';                    //원매츨일자
     SendData      := '';                    //송신데이터
     RecvData      := '';                    //응답데이터
     Type_trd      := atSwipe;               //거래형태(S:Swipe, C:Cat)
     RealMode      := True;                  //실모드
     ImgFile       := EmptyStr;              //이미지화일
     Note          := EmptyStr;              //출력메세지
     Yn_Can        := 'Y';                   //저장여부
     Yn_Print      := 'Y';                   //출력여부
     Yn_Search     := 'N';                   //조회여부
     yn_save       := 'Y';
     Corner        := '';
     DsDc          := '';
     BalanceAmt    := '';
     Yn_UnionPay   := 'N';
     CardNoFull    := #12;                    //카드번호
     CardNoFull    := #3;                     //카드번호
     CardNoFull    := EmptyStr;
     Yn_Cat        := 'N';
     VanTid        := '';
     PG_TID        := '';
     CancelAmt     := 0;
     OrgTableNo    := 0;
     TransNo       := '';
     PayCode       := '';
  end;
end;

//***************************************************************************//
//                               현금영수증 레코드 초기화                                 //
//***************************************************************************//
procedure InitCashRcpRecord(var AValue: TCashRcp);
begin
  with AValue do
  begin
     Ds_Trd        :=dtApproval;
     Ds_Kind       :='0';
     Ds_Type       :='0';
     Ds_Input      :='S';
     CardNoFull    :=#12;
     CardNo        :=#12;
     CardNoFull    :=#3;
     CardNo        :='';
     CardNoFull    :='';
     CardNo        :='';
     No_Approval   :='';
     Amt_Approval  :=0;
     VatAmt        := 0;
     trd_date      :='';
     trd_date_org  :='';
     Approval_org  :='';
     Yn_Can        :='Y';
     yn_print      :='Y';
     yn_save       :='Y';
     Corner        := '';
     RcvAmt        := 0;
     Yn_Cat        := 'N';
  end;
end;

function TCommon.SetStr(S:String):String;
begin
   if Length(Trim(S)) <= 12 then       Result := Trim(S)
   else if Length(Trim(S)) in [13, 14] then  Result := SCopy(S,1,12) + #13 + SCopy(S,13,12)
   else if Length(Trim(S)) in [20, 21] then  Result := SCopy(S,1,10) + #13 + SCopy(S,11,10)
   else if Length(Trim(S)) in [22, 23] then  Result := SCopy(S,1,11) + #13 + SCopy(S,12,11)
   else if Length(Trim(S)) in [24, 25] then  Result := SCopy(S,1,12) + #13 + SCopy(S,13,12)
   else if Length(Trim(S)) in [26, 27] then  Result := SCopy(S,1,13) + #13 + SCopy(S,14,13)
   else Result := SCopy(S,1,14) + #13 + SCopy(S,15,14)
end;

procedure TCommon.TaxCalculation(aGubun:String);
var
  liRow, TmpAmt, vPntRate, vPointAmt, vOccurPoint :Integer;
  vQty :String;
begin
  with Temp_sGrd do
  begin
    Present.DutyAmt := 0;
    Present.TaxAmt  := 0;
    Present.FreeAmt := 0;
    Present.ExistPointAmt := 0;
    if aGubun <> 'V' then
    begin
      Present.OccurPnt      := 0;
    end;

    if (GetOption(307) = '1') then
      Table.CustomerCount := 0;

    For liRow := 0 to RowCount-1 do
    begin
      if (GetOption(307) = '1') and (StrToIntDef(Cells[GDM_YN_PERSON, liRow],0) > 0) then
      begin
        if Cells[GDM_DS_MENU, liRow] = 'W' then
          Table.CustomerCount := Table.CustomerCount + 1
        else
          Table.CustomerCount := Table.CustomerCount + StoI(Cells[GDM_QTY, liRow]) * StrToIntDef(Cells[GDM_YN_PERSON, liRow],0);
      end;

      //서비스이면 패스
      if Cells[GDM_DS_SALE, liRow] = 'D' then Continue;

      if Cells[GDM_DS_MENU, liRow] = 'W' then
      begin
        if StoI(Cells[GDM_QTY, liRow]) > 0 then vQty := '1'
        else                                    vQty := '-1';
      end
      else vQty := Cells[GDM_QTY, liRow];

      TmpAmt := (StoI(Cells[GDM_PR_SALE,    liRow])
               + StoI(Cells[GDM_PR_ITEM,    liRow])
               - Abs(StoI(Cells[GDM_DC_MENU,    liRow]))      //단품할인
               - Abs(StoI(Cells[GDM_DC_SPC,     liRow]))
               - Ifthen(GetOption(289)='0', StoI(Cells[GDM_TIP,  liRow]),0))
               * StoI(vQty);
      TmpAmt := TmpAmt - StoI(Cells[GDM_DC_TAXFREE, liRow]) - StoI(Cells[GDM_DC_STAMP, liRow]) - StoI(Cells[GDM_DC_RECEIPT,  liRow]);

      if Cells[GDM_DS_TAX, liRow] = '0' then
      begin
        Cells[GDM_AMT_TAX, liRow] := '0';
        Present.FreeAmt := Present.FreeAmt + TmpAmt ;     //면세상품금액
      end
      else
      begin
        Present.DutyAmt := Present.DutyAmt + TmpAmt ;     //과세상품금액
        Cells[GDM_AMT_TAX, liRow] := FtoS(hTrunc( TmpAmt / 11 ,1) ) ;
      end;

      //포인트제외상품 금액
      if (Cells[GDM_YN_POINT, liRow] = 'N') or (Cells[GDM_YN_POINT, liRow] = 'L') and (aGubun <> 'V') then
        Present.ExistPointAmt := Present.ExistPointAmt + TmpAmt
      //행사상품 포인트 적립제외
      else if (GetOption(302) = '1') and (Cells[GDM_NO_SPC, liRow] <> '') and (aGubun <> 'V') then
        Present.ExistPointAmt := Present.ExistPointAmt + TmpAmt
      //할인메뉴 포인트 적립제외
      else if (GetOption(413) = '1') and (Cells[GDM_DC_MENU, liRow] <> '0') and (aGubun <> 'V') then
        Present.ExistPointAmt := Present.ExistPointAmt + TmpAmt;

      //메뉴별로 포인트적립율 사용 시
      if (GetOption(258) <> '0') and ((Cells[GDM_YN_POINT, liRow] = 'Y') or (Cells[GDM_YN_POINT, liRow] = 'A')) and (aGubun <> 'V') then
      begin
         //포인트를 사용하고 남은 금액에 대해 포인트를 적립할때
         if (GetOption(296) = '1') and (Present.TotalAmt <> 0) then
           vPointAmt :=  TmpAmt - FtoI(TmpAmt * (Present.PointAmt / Present.TotalAmt))
         else
           vPointAmt := TmpAmt;

         OpenQuery('select POINT_RATE '
                  +'  from MS_MENU_DC '
                  +' where CD_STORE  =:P0 '
                  +'   and DS_MEMBER =:P1 '
                  +'   and CD_MENU   =:P2 ',
                  [Common.Config.StoreCode,
                   Common.Member.cd_class,
                   Cells[GDM_CD_MENU, liRow]]);

         if not Query.Eof then
           vPntRate := Query.Fields[0].AsInteger
         else
           vPntRate := 0;

         vOccurPoint := FtoI( hRound( vPntRate / 100 * vPointAmt,0) );

         //행사상품 포인트 적립제외
         if (GetOption(302) = '1') and (Cells[GDM_NO_SPC, liRow] <> '')  then
            vOccurPoint := 0;
         //할인메뉴 포인트 적립제외
         if (GetOption(413) = '1') and (Cells[GDM_DC_MENU, liRow] <> '0') then
            vOccurPoint := 0;

         Present.OccurPnt := Present.OccurPnt + vOccurPoint;
         Query.Close;
      end;
    end;

    //봉사료때문에 출력을 위하여
    Present.DutyAmt_Prt  := Present.DutyAmt;
    Present.FreeAmt_Prt  := Present.FreeAmt;
    Present.TaxAmt_Prt   := FtoI(hTrunc( (Present.DutyAmt) / 11 ,1)) ;
    Present.DutyAmt_Prt  := Present.DutyAmt_Prt - Present.TaxAmt_Prt;

    Present.FreeAmt := Present.FreeAmt + Present.TipAmt;
    TmpAmt          := Present.DutyAmt;
    Present.TaxAmt  := FtoI(hTrunc( (Present.DutyAmt) / 11 ,1)) ;
    Present.DutyAmt := TmpAmt - Present.TaxAmt;
  end;

  //고객수 추정메뉴 사용 시
  if GetOption(307) = '1' then
    SetCustomerCount(Table.CustomerCount);

  //신용카드/현금영수증 기능을 사용하지 않을때는 수행하지 않는다
  if GetOption(51) = '0' then
  begin
    Present.CashRcpAmt := 0;
    For liRow := 0 to Cash_sGrd.RowCount -1 do
    begin
      if (Cash_SGrd.Cells[GDR_YN_PRINT, liRow] = 'N') and (aGubun = 'B') then Continue;
      if Cash_SGrd.Cells[GDR_DS_TRD, liRow] = dtApproval then
        Present.CashRcpAmt := Present.CashRcpAmt + StoI(Trim(Cash_sGrd.Cells[GDR_AMT,    liRow]))
      else
        Present.CashRcpAmt := Present.CashRcpAmt - StoI(Trim(Cash_sGrd.Cells[GDR_AMT,    liRow]));
    end;
  end;
end;

procedure TCommon.PointCalculation(aGubun:String; aSaleAmt,aPointExistAmt:Integer);
var vCashAmtStd,
    vCashPointStd,
    vCardAmtStd,
    vCardPointStd,
    vCashRcpAmtStd,
    vCashRcpPointStd,
    vGiftAmtStd,
    vGiftPointStd,
    vTrustAmtStd,
    vTrustPointStd,
    vPointAmtStd,
    vPointPointStd,
    vCashAmt,
    vCashPoint,
    vCardAmt,
    vCardPoint,
    vCashRcpAmt,
    vCashRcpPoint,
    vGiftAmt,
    vGiftPoint,
    vTrustAmt,
    vTrustPoint,
    vPointAmt,
    vPointPoint :Integer;
    vAddPoint,
    vUsePoint :Integer;
    vKind,
    vApplyAmt :Integer;
    vWork :String;  //작업(PU:적립사용, P적립, U:사용)
    vSeq,
    vPoint,
    vTempPoint  :Integer;
label POINT_SAVE;
begin
  //이미적립한 영수증을 다시 할때
  if (aGubun = 'P') and (Member.OrgOccurPoint > 0) then
  begin
    PreSent.OccurPnt     := Member.OrgOccurPoint;
    Member.Point         := Member.Point + Member.OrgOccurPoint;
    Member.OrgOccurPoint := 0;
    Exit;
  end;

  vTempPoint := 1;
  try
    if (aGubun = 'C') or (aGubun = 'V') or (aGubun = 'H') then
    begin
      if (Member.DcType = '1') or (Member.DcType = '2') then
      begin
        OpenQuery('select PNT_OCCUR, '
                 +'       PNT_USE '
                 +'  from SL_SALE_H '
                 +' where CD_STORE =:P0 '
                 +'   and YMD_SALE =:P1 '
                 +'   and NO_POS   =:P2 '
                 +'   and NO_RCP   =:P3 ',
                 [Config.StoreCode,
                  WorkDate,
                  Config.PosNo,
                  Present.RcpNo]);
        Member.Point := Member.Point - Query.Fields[0].AsInteger;
        Member.Point := Member.Point + Query.Fields[1].AsInteger;
        Query.Close;
      end;

      if aGubun = 'V' then Exit;

      //포인트사용을 매출로 사용시
      if (aGubun = 'C') and (GetOption(372) = '0') then
        Present.UsePnt := Present.PointAmt;
    end
    else
    begin
      if GetOption(372) = '0' then
        Present.UsePnt := Present.PointAmt
      else
        Present.UsePnt := Present.PointDc;
    end;

    //포인트 사용영수증은 포인트 적립을 하지 않습니다.
    if (GetOption(296)='0') and (Present.UsePnt <> 0) then
    begin
      Present.OccurPnt := 0;
      vWork            := 'U';
      goto POINT_SAVE;
    end;

    //메뉴별로 포인트 적립시
    if GetOption(258) = '1' then
    begin
      if Present.OccurPnt <> 0 then
        vWork  := 'P';
      if Present.UsePnt <> 0 then
        vWork  := vWork + 'U';

      vCashPoint    := Present.OccurPnt;
      vCashRcpPoint := 0;
      vCardPoint    := 0;

      goto POINT_SAVE;
    end;

    vWork := 'PU';
    if (Member.Code <> '') and not (aGubun[1] in ['V','M']) and ((Member.DcType = '1') or (Member.DcType = '2')) then
    begin
      OpenQuery('select * '
               +'  from MS_CODE '
               +' where CD_STORE =:P0 '
               +'   and CD_CODE  =:P1 '
               +'   and CD_KIND  =''05'' ',
               [Config.StoreCode,
                Member.cd_class]);
      if Query.Eof then
      begin
        Query.Close;
        vCashAmt      := 0;
        vCashPoint    := 0;
        vCardAmt      := 0;
        vCardPoint    := 0;
        vCashRcpAmt   := 0;
        vCashRcpPoint := 0;
        vGiftAmt      := 0;
        vGiftPoint    := 0;
        vTrustAmt     := 0;
        vTrustPoint   := 0;
        vPointAmt     := 0;
        vPointPoint   := 0;
        goto POINT_SAVE;
      end
      else
      begin
        vCashAmtStd      := StrToIntDef(Query.FieldByName('NM_CODE5').asString,0);
        vCashPointStd    := StrToIntDef(Query.FieldByName('NM_CODE6').asString,0);
        vCardAmtStd      := StrToIntDef(Query.FieldByName('NM_CODE7').asString,0);
        vCardPointStd    := StrToIntDef(Query.FieldByName('NM_CODE8').asString,0);
        vCashRcpAmtStd   := StrToIntDef(Query.FieldByName('NM_CODE9').asString,0);
        vCashRcpPointStd := StrToIntDef(Query.FieldByName('NM_CODE10').asString,0);
        vGiftAmtStd      := StrToIntDef(Query.FieldByName('NM_CODE11').asString,0);
        vGiftPointStd    := StrToIntDef(Query.FieldByName('NM_CODE12').asString,0);
        vTrustAmtStd     := StrToIntDef(Query.FieldByName('NM_CODE13').asString,0);
        vTrustPointStd   := StrToIntDef(Query.FieldByName('NM_CODE14').asString,0);
        vPointAmtStd     := StrToIntDef(Query.FieldByName('NM_CODE15').asString,0);
        vPointPointStd   := StrToIntDef(Query.FieldByName('NM_CODE16').asString,0);
        Query.Close;
      end;


      /////////////////////////////////////////////////////////////////////
      ////////////////             적립포인트 계산            /////////////
      /////////////////////////////////////////////////////////////////////
      //처음에 계산이 잘 안되는 현상때문에 두번함                                                                                   //예약금은 현금으로
      vCashAmt      := Present.CashAmt + Present.CheckAmt + Present.BankAmt - Present.CashRcpAmt + Present.EtcAmt - Present.GiveAmt + Common.Table.BookingAmt;
      vCashPoint    := 0;
      vCardAmt      := Present.CardAmt + Present.LetsOrderAmt;
      vCardPoint    := 0;
      vCashRcpAmt   := Present.CashRcpAmt;
      vCashRcpPoint := 0;
      vGiftAmt      := Present.GiftAmt;
      vGiftPoint    := 0;
      vTrustAmt     := Present.TrustAmt;
      vTrustPoint   := 0;
      vPointAmt     := Present.PointAmt;
      vPointPoint   := 0;

      if (vCashAmt+vCardAmt+vCashRcpAmt+vGiftAmt+vTrustAmt+vPointAmt = 0) or (Abs(vCashAmt+vCardAmt+vCashRcpAmt+vGiftAmt+vTrustAmt+vPointAmt) <= Abs(aPointExistAmt)) then
      begin
        Present.OccurPnt := 0;
        if Present.UsePnt <> 0 then
        begin
          vWork            := 'U';
          goto POINT_SAVE;
        end;
      end;

      vKind     := 0;
      vApplyAmt := 0;
      while vApplyAmt < aPointExistAmt do
      begin
        case vKind of
          0 :  //현금포인트 계산
          begin
            if vCashAmt >= (aPointExistAmt-vApplyAmt) then
            begin
              vCashAmt  := vCashAmt - aPointExistAmt;
              vApplyAmt := aPointExistAmt;
            end
            else if vCashAmt > 0 then
            begin
              vApplyAmt := vCashAmt;
              vCashAmt  := vCashAmt - (aPointExistAmt-(aPointExistAmt-vCashAmt));
            end;
            vKind := 1;
          end;
          1 :  //현금영수증 포인트 계산
          begin
            if vCashRcpAmt >= (aPointExistAmt-vApplyAmt) then
            begin
              vCashRcpAmt := vCashRcpAmt - (aPointExistAmt-vApplyAmt);
              vApplyAmt   := vApplyAmt   + (aPointExistAmt-vApplyAmt);
            end
            else if vCashRcpAmt > 0 then
            begin
              vApplyAmt   := vApplyAmt + vCashRcpAmt;
              if aPointExistAmt >= vApplyAmt then
                vCashRcpAmt := 0
              else
                vCashRcpAmt := aPointExistAmt-vApplyAmt;
            end;
            vKind := 2;
          end;
          2 : //신용카드
          begin
            if vCardAmt >= (aPointExistAmt-vApplyAmt) then
            begin
              vCardAmt    := vCardAmt  - (aPointExistAmt-vApplyAmt);
              vApplyAmt   := vApplyAmt + (aPointExistAmt-vApplyAmt);
            end
            else if vCardAmt > 0 then
            begin
              vApplyAmt   := vApplyAmt + vCardAmt;
              if aPointExistAmt >= vApplyAmt then
                vCardAmt := 0
              else
                vCardAmt := aPointExistAmt-vApplyAmt;
            end;
            vKind := 3;
          end;
          3 : //상품권
          begin
            if vGiftAmt >= (aPointExistAmt-vApplyAmt) then
            begin
              vGiftAmt    := vGiftAmt  - (aPointExistAmt-vApplyAmt);
              vApplyAmt   := vApplyAmt + (aPointExistAmt-vApplyAmt);
            end
            else if vGiftAmt > 0 then
            begin
              vApplyAmt   := vApplyAmt + vGiftAmt;
              if aPointExistAmt >= vApplyAmt then
                vGiftAmt := 0
              else
                vGiftAmt := aPointExistAmt-vApplyAmt;
            end;
            vKind := 4;
          end;
          4 : //외상
          begin
            if vTrustAmt >= (aPointExistAmt-vApplyAmt) then
            begin
              vTrustAmt   := vTrustAmt - (aPointExistAmt-vApplyAmt);
              vApplyAmt   := vApplyAmt + (aPointExistAmt-vApplyAmt);
            end
            else if vTrustAmt > 0 then
            begin
              vApplyAmt   := vApplyAmt + vTrustAmt;
              if aPointExistAmt >= vApplyAmt then
                vTrustAmt := 0
              else
                vTrustAmt := aPointExistAmt-vApplyAmt;
            end;
            vKind := 5;
          end;
          5 : //포인트
          begin
            if vPointAmt >= (aPointExistAmt-vApplyAmt) then
            begin
              vPointAmt   := vPointAmt - (aPointExistAmt-vApplyAmt);
              vApplyAmt   := vApplyAmt + (aPointExistAmt-vApplyAmt);
            end
            else if vPointAmt > 0 then
            begin
              vApplyAmt   := vApplyAmt + vPointAmt;
              if aPointExistAmt >= vApplyAmt then
                vPointAmt := 0
              else
                vPointAmt := aPointExistAmt-vApplyAmt;
            end
            else 
              Break;
          end;
        end;
      end;
    end;

    if vCashAmtStd > 0 then
      vCashPoint := vCashAmt Div vCashAmtStd * vCashPointStd
    else
      vCashPoint := 0;

    if vCashRcpAmtStd > 0 then
      vCashRcpPoint := vCashRcpAmt Div vCashRcpAmtStd * vCashRcpPointStd
    else
      vCashRcpPoint := 0;

    if vCardAmtStd > 0 then
      vCardPoint := vCardAmt Div vCardAmtStd * vCardPointStd
    else
      vCardPoint := 0;

    if vGiftAmtStd > 0 then
      vGiftPoint := vGiftAmt Div vGiftAmtStd * vGiftPointStd
    else
      vGiftPoint := 0;

    if vTrustAmtStd > 0 then
      vTrustPoint := vTrustAmt Div vTrustAmtStd * vTrustPointStd
    else
      vTrustPoint := 0;

    if vPointAmtStd > 0 then
      vPointPoint := vPointAmt Div vPointAmtStd * vPointPointStd
    else
      vPointPoint := 0;

    //렛츠오더 or 키오스크일때 2배적립
    if ((GetOption(420)='1') and (Present.LetsOrderAmt > 0)) or ((GetOption(285)='1') and Config.IsKiosk) then
      vTempPoint := 2
    else
      vTempPoint := 1;

    Present.OccurPnt := (vCashPoint + vCashRcpPoint + vCardPoint + vGiftPoint + vTrustPoint + vPointPoint) * vTempPoint;

  POINT_SAVE:
    if ((Present.SaveStamp <> 0) or (Present.StampDc <> 0) or (Present.OccurPnt <> 0) or (Present.UsePnt <> 0)) and (Member.Code <> EmptyStr) then
    begin
      OpenQuery('select Ifnull(Max(SEQ),0)+1 '
                   +'  from SL_POINT '
                   +' where CD_STORE  =:P0 '
                   +'   and YMD_OCCUR =:P1 '
                   +'   and NO_POS    =:P2 ',
                   [Config.StoreCode,
                    WorkDate,
                    Config.PosNo]);
      vSeq := Query.Fields[0].AsInteger;
      Query.Close;

      ExecQuery('delete from TEMP_POINT '
               +' where CD_STORE  =:P0 '
               +'   and YMD_OCCUR =:P1 '
               +'   and NO_POS    =:P2 ',
               [Config.StoreCode,
                WorkDate,
                Config.PosNo]);

      ExecQuery('insert into TEMP_POINT(CD_STORE, '
               +'                       YMD_OCCUR, '
               +'                       NO_POS, '
               +'                       SEQ, '
               +'                       CD_MEMBER, '
               +'                       CD_CODE, '
               +'                       AMT_CASH, '
               +'                       PNT_CASH, '
               +'                       AMT_CASHRCP, '
               +'                       PNT_CASHRCP, '
               +'                       AMT_CARD, '
               +'                       PNT_CARD, '
               +'                       AMT_GIFT, '
               +'                       PNT_GIFT, '
               +'                       AMT_TRUST, '
               +'                       PNT_TRUST, '
               +'                       AMT_POINT, '
               +'                       PNT_POINT, '
               +'                       AMT_EXCLUDE, '
               +'                       PNT_ADD, '
               +'                       PNT_USE, '
               +'                       PNT_TOTAL, '
               +'                       STAMP_ADD, '
               +'                       STAMP_USE, '
               +'                       RCP_LINK, '
               +'                       CD_SAWON_CHG) '
               +'               values(:P0,  '
               +'                      :P1,  '
               +'                      :P2,  '
               +'                      :P3,  '
               +'                      :P4,  '
               +'                      :P5,  '
               +'                      :P6,  '
               +'                      :P7,  '
               +'                      :P8,  '
               +'                      :P9,  '
               +'                      :P10, '
               +'                      :P11, '
               +'                      :P12, '
               +'                      :P13, '
               +'                      :P14, '
               +'                      :P15, '
               +'                      :P16, '
               +'                      :P17, '
               +'                      :P18, '
               +'                      :P19, '
               +'                      :P20, '
               +'                      :P21, '
               +'                      :P22, '
               +'                      :P23, '
               +'                      :P24, '
               +'                      :P25) ',
               [Config.StoreCode,
                WorkDate,
                Config.PosNo,
                vSeq,
                Member.Code,
                '000',
                vCashAmt,
                vCashPoint * vTempPoint,
                vCashRcpAmt,
                vCashRcpPoint * vTempPoint,
                vCardAmt,
                vCardPoint * vTempPoint,
                vGiftAmt,
                vGiftPoint * vTempPoint,
                vTrustAmt,
                vTrustPoint * vTempPoint,
                vPointAmt,
                vPointPoint * vTempPoint,
                aPointExistAmt,
                Present.OccurPnt,
                Present.UsePnt,
                Member.Point,
                Present.SaveStamp,
                Present.UseStamp,
                WorkDate+Config.PosNo+Present.RcpNo,
                Config.UserCode]);

      OpenQuery('select SEQ '
               +'  from SL_POINT '
               +' where CD_STORE  =:P0 '
               +'   and RCP_LINK      =:P1 ',
               [Config.StoreCode,
                WorkDate+Config.PosNo+Present.RcpNo]);
      if Query.Eof then
        ExecQuery('insert into SL_POINT(CD_STORE, '
                 +'                     YMD_OCCUR, '
                 +'                     NO_POS, '
                 +'                     SEQ, '
                 +'                     CD_MEMBER, '
                 +'                     CD_CODE, '
                 +'                     AMT_CASH, '
                 +'                     PNT_CASH, '
                 +'                     AMT_CASHRCP, '
                 +'                     PNT_CASHRCP, '
                 +'                     AMT_CARD, '
                 +'                     PNT_CARD, '
                 +'                     AMT_GIFT, '
                 +'                     PNT_GIFT, '
                 +'                     AMT_TRUST, '
                 +'                     PNT_TRUST, '
                 +'                     AMT_POINT, '
                 +'                     PNT_POINT, '
                 +'                     AMT_EXCLUDE, '
                 +'                     PNT_ADD, '
                 +'                     PNT_USE, '
                 +'                     PNT_TOTAL, '
                 +'                     STAMP_ADD, '
                 +'                     STAMP_USE, '
                 +'                     RCP_LINK, '
                 +'                     CD_SAWON_CHG, '
                 +'                     DT_CHANGE) '
                 +'             select  CD_STORE, '
                 +'                     YMD_OCCUR, '
                 +'                     NO_POS, '
                 +'                     SEQ, '
                 +'                     CD_MEMBER, '
                 +'                     CD_CODE, '
                 +'                     AMT_CASH, '
                 +'                     PNT_CASH, '
                 +'                     AMT_CASHRCP, '
                 +'                     PNT_CASHRCP, '
                 +'                     AMT_CARD, '
                 +'                     PNT_CARD, '
                 +'                     AMT_GIFT, '
                 +'                     PNT_GIFT, '
                 +'                     AMT_TRUST, '
                 +'                     PNT_TRUST, '
                 +'                     AMT_POINT, '
                 +'                     PNT_POINT, '
                 +'                     AMT_EXCLUDE, '
                 +'                     PNT_ADD, '
                 +'                     PNT_USE, '
                 +'                     PNT_TOTAL, '
                 +'                     STAMP_ADD, '
                 +'                     STAMP_USE, '
                 +'                     RCP_LINK, '
                 +'                     CD_SAWON_CHG, '
                 +'                     Now() '
                 +'               from  TEMP_POINT '
                 +'              where  CD_STORE  =:P0 '
                 +'                and  YMD_OCCUR =:P1 '
                 +'                and  NO_POS    =:P2 ',
                 [Config.StoreCode,
                  WorkDate,
                  Config.PosNo])
      else
        ExecQuery('update SL_POINT inner join '
                 +'       TEMP_POINT as t on SL_POINT.CD_STORE = t.CD_STORE '
                 +'                      and SL_POINT.RCP_LINK = t.RCP_LINK '
                 +'                      and t.CD_STORE  =:P0 '
                 +'                      and t.YMD_OCCUR =:P1 '
                 +'                      and t.NO_POS    =:P2 '
                 +'   set SL_POINT.CD_MEMBER  =  t.CD_MEMBER, '
                 +'       SL_POINT.CD_CODE    =  t.CD_CODE, '
                 +'       SL_POINT.AMT_CASH   =  t.AMT_CASH, '
                 +'       SL_POINT.PNT_CASH   =  t.PNT_CASH, '
                 +'       SL_POINT.AMT_CASHRCP=  t.AMT_CASHRCP, '
                 +'       SL_POINT.PNT_CASHRCP=  t.PNT_CASHRCP, '
                 +'       SL_POINT.AMT_CARD   =  t.AMT_CARD, '
                 +'       SL_POINT.PNT_CARD   =  t.PNT_CARD, '
                 +'       SL_POINT.AMT_GIFT   =  t.AMT_GIFT, '
                 +'       SL_POINT.PNT_GIFT   =  t.PNT_GIFT, '
                 +'       SL_POINT.AMT_TRUST  =  t.AMT_TRUST, '
                 +'       SL_POINT.PNT_TRUST  =  t.PNT_TRUST, '
                 +'       SL_POINT.AMT_POINT  =  t.AMT_POINT, '
                 +'       SL_POINT.PNT_POINT  =  t.PNT_POINT, '
                 +'       SL_POINT.AMT_EXCLUDE =  t.AMT_EXCLUDE, '
                 +'       SL_POINT.PNT_ADD    =  t.PNT_ADD, '
                 +'       SL_POINT.PNT_USE    =  t.PNT_USE, '
                 +'       SL_POINT.PNT_TOTAL  =  t.PNT_TOTAL, '
                 +'       SL_POINT.STAMP_ADD  =  t.STAMP_ADD, '
                 +'       SL_POINT.STAMP_USE  =  t.STAMP_USE, '
                 +'       SL_POINT.DT_CHANGE  =  Now() ',
                 [Config.StoreCode,
                  WorkDate,
                  Config.PosNo]);
    end;

  finally
    //Temp 테이블에 적립내역이 없으면 기존에 적립내역을 삭제한다
    ExecQuery('delete from SL_POINT '
             +' where CD_STORE =:P0 '
             +'   and RCP_LINK =:P1 '
             +'   and not exists (select * '
             +'            from TEMP_POINT '
             +'           where CD_STORE  =:P0 '
             +'             and YMD_OCCUR =:P1 '
             +'             and NO_POS    =:P2) ',
             [Config.StoreCode,
              WorkDate,
              Config.PosNo,
              WorkDate+Config.PosNo+Present.RcpNo]);

  end;

  ExecQuery('delete from TEMP_POINT '
           +' where CD_STORE  =:P0 '
           +'   and YMD_OCCUR =:P1 '
           +'   and NO_POS    =:P2 ',
           [Config.StoreCode,
            WorkDate,
            Config.PosNo]);
  Member.Point  := Member.Point + Present.OccurPnt - Present.UsePnt;
end;
//****************************************************************************//
//                          매출데이터 저장
// aGubun : S-일반매출, C-결제변경, B-반품, V-결제취소, H-현금영수증재발행, P:포인트사후적립
//****************************************************************************//
function TCommon.SaleDataSave(aGubun:String; var ErrMsg:String):Boolean;
  function CheckSaleCount:Integer;
  var I :Integer;
  begin
    Result := 0;
    For I := 0 to Summary_sGrd.RowCount-1 do
    begin
      if StoI(Summary_sGrd.Cells[GDM_QTY, I]) > 0 then
        Result := Result + 1;
    end;
  end;
  function CheckFoodCourtOrderNo(aIndex:Integer):Boolean;
  var I :Integer;
  begin
    Result := false;
    For I := 0 to aIndex-1 do
    begin
      if Corner[I].Code = Corner[aIndex].Code then
      begin
        Result := True;
        Break;
      end;
    end;
  end;

var
   liRow, liMenu, Cnt, liPos, vTemp, vSeq, vSubSeq, vGroupSeq, vIndex, vIndex1, vTicketIndex :Integer;
   vSaleAmt :Integer;
   MenuCode, vMenuCode, vTemp1, vTemp2, vWhere, vSmsTxt, vSQL: String;
   vBmp : TBitmap;
   vStream    : TMemoryStream;
   vGetTime   : Cardinal;
   vOrgGubun  :String;
   visPerson  :Boolean;
   vLabelData :String;
   vQty       :Integer;
   vQty1      :Integer;
   visItemMenu :Boolean;
   vResult    :String;
   vPerson    :Integer;
   vCouponNo  :String;
   vReturn    :Boolean;
   vResultStr :WideString;
   vPoint,
   vGroupTableNo     :Integer;
   visTicket  :Boolean;
   vGroupTable :String;
begin
  if (Trim(WorkDate) = '') then
  begin
    ErrBox(Format('개점일자(%s)가 올바르지 않습니다'+#13#13+'프로그램을 종료 후 다시 실행하세요',[WorkDate]));
    Result := False;
    Exit;
  end;

  ShowWaitForm;
  Result      := True;
  WorkState   := wsMagam;
  if (Common.PreSent.CashAmt <> 0) or ((GetOption(33) = '1') and (Common.PreSent.CardAmt <> 0)) then
    Common.Device.CashBoxOpen(1);        //돈통열기

  try
    //영수증번호 채번
    if (aGubun = 'S') or (aGubun = 'B')  then
    begin
      //테이블제일때만 영수증번호를 채번한다
      if not Config.IsTakeOut or Config.IsKiosk then
      begin
        vGetTime := GetTickCount;
        while (vGetTime + 2000 > GetTickCount) and (not GetReceiptNo)  do Application.ProcessMessages;
      end;
      Present.SaleDate := Now();
    end;
    GridToGrid(Summary_sGrd, Temp_sGrd);
    if OrderKind <> okChange then
      GridToGrid(Group_sGrd, Temp_sGrd, true);

    if (aGubun <> 'B') and (aGubun <> 'V') then
      Allot_Dc(Temp_sGrd);
    TaxCalculation(aGubun);                        //부가세, 포인트  계산

    BeginTran;
    if (aGubun = 'S') and (not Common.Config.IsTakeOut) then
      Order_F.OrderCancelDBApply(2);

    with DM, PreSent do
    begin
      SoonAmt   :=  CashAmt - GiveAmt + CheckAmt + TrustAmt + CardAmt + GiftAmt + BankAmt + PointAmt + EtcAmt + LetsOrderAmt;

      if Assigned(Order_F) and (Common.Table.OrderType = 'D') then
        Order_F.SaveDeliveryAmnt(true, SoonAmt);

      if Trim(Present.RcpNo) = EmptyStr then
      begin
        raise Exception.Create('영수증번호가 올바르지 않습니다.'+#13+'다시 시도하세요');
        result := false;
        Exit;
      end;

      //입금변경일때 스템프 계산 스템프기능사용,  결제변경 시 메뉴를 수정할 수 있습니다.
      if (aGubun = 'V') or ((GetOption(235) = '0') and (OrderKind = okChange)) then
      begin
        ExecQuery('delete from SL_POINT '
                 +' where CD_STORE  =:P0 '
                 +'   and RCP_LINK  =:P1 ',
                 [Common.Config.StoreCode,
                  Common.OrgReceiptNo]);
      end;
      //포인트추후적립은 아래에서 처리한다
      if (aGubun <> 'P') and (Member.Code <> '') then
        PointCalculation(aGubun, SoonAmt, Present.ExistPointAmt);

      //결제변경 시 메뉴수정을 하는 매장일때
      vOrgGubun := aGubun;
      if (GetOption(235) = '1') and (OrderKind = okChange) then
      begin
        StoredProc.StoredProcName :='POS_SAVE_SALE_H';
        StoredProc.PrepareSQL;
        StoredProc.ParamByName('_WORK_KIND' ).AsString  := 'V';
        StoredProc.ParamByName('_CD_STORE'  ).AsString  := Config.StoreCode;
        StoredProc.ParamByName('_YMD_SALE'  ).AsString  := WorkDate;
        StoredProc.ParamByName('_NO_POS'    ).AsString  := Config.PosNo;
        StoredProc.ParamByName('_NO_RCP'    ).AsString  := Present.RcpNo;
        StoredProc.ParamByName('_DS_ORDER'  ).AsString  := Table.OrderType;
        StoredProc.ParamByName('_YN_TAKEOUT').AsString  := Ifthen(Common.Config.IsTakeOut, 'Y','N');
        StoredProc.ExecProc;

        ExecQuery('delete '
                 +'  from SL_SALE_D '
                 +' where CD_STORE=:P0 '
                 +'   and YMD_SALE=:P1 '
                 +'   and NO_POS  =:P2 '
                 +'   and NO_RCP  =:P3',
                 [Config.StoreCode,
                  WorkDate,
                  Config.PosNo,
                  Present.RcpNo]);

        ExecQuery('delete '
                 +'  from SL_SALE_S '
                 +' where CD_STORE =:P0 '
                 +'   and YMD_SALE =:P1 '
                 +'   and NO_POS   =:P2 '
                 +'   and NO_RCP   =:P3',
                 [Config.StoreCode,
                  WorkDate,
                  Config.PosNo,
                  Present.RcpNo]);

        vOrgGubun := 'C';
        aGubun    := 'S';
      end;

      //총고객수를 구한다
      vPerson := Table.CustomerCount;
      Table.CustomerCount := 0;
      if Assigned(Table.AgeCode) then
        for Cnt := 0 to Table.AgeCode.Count-1 do
        begin
          if Length(Trim(Table.AgeCode.Strings[Cnt])) = 6 then
            Table.CustomerCount := Table.CustomerCount + StrToIntDef(Copy(Table.AgeCode.Strings[Cnt],4,3),0);
        end;

      //고객수 추정메뉴를 사용하지 않으면 고객수가 기본 1명
      if (GetOption(307) = '0') and (Table.CustomerCount = 0) then
      begin
        Table.CustomerCount := vPerson;
        SetCustomerCount(Table.CustomerCount);
      end;

      //스템프 계산
      if (aGubun = 'P') then
      begin
        ExecQuery('update SL_SALE_D inner join '
                 +'       MS_MENU m on m.CD_STORE = SL_SALE_D.CD_STORE '
                 +'                and m.CD_MENU  = SL_SALE_D.CD_MENU inner join '
                 +'       MS_STORE s on m.CD_STORE = s.CD_STORE inner join '
                 +'       MS_CODE  c on m.CD_STORE = c.CD_STORE '
                 +'                 and c.CD_KIND  = ''01'' '
                 +'                 and c.NM_CODE1 = :P2 '
                 +'   set SL_SALE_D.SAVE_STAMP = m.SAVE_STAMP * SL_SALE_D.QTY_SALE * case when ((substring(s.OPTIONS,420,1)=''1'') and (c.NM_CODE3 = ''7'')) or ((substring(s.OPTIONS,285,1)=''1'') and (c.NM_CODE3 = ''2'')) then 2 else 1 end '
                 +' where SL_SALE_D.CD_STORE =:P0 '
                 +'   and SL_SALE_D.YMD_SALE =:P1 '
                 +'   and SL_SALE_D.NO_POS   =:P2 '
                 +'   and SL_SALE_D.NO_RCP   =:P3 '
                 +'   and SL_SALE_D.DS_SALE = ''S'' ',
                 [Common.Config.StoreCode,
                  Common.WorkDate,
                  Common.Config.PosNo,
                  Common.Present.RcpNo]);

        OpenQuery('select SUM(SAVE_STAMP) '
                 +'  from SL_SALE_D '
                 +' where CD_STORE =:P0 '
                 +'   and YMD_SALE =:P1 '
                 +'   and NO_POS   =:P2 '
                 +'   and NO_RCP   =:P3 ',
                 [Common.Config.StoreCode,
                  Common.WorkDate,
                  Common.Config.PosNo,
                  Common.Present.RcpNo]);
        PreSent.SaveStamp := DM.Query.Fields[0].AsInteger;
        DM.Query.Close;
        PointCalculation(aGubun, SoonAmt, Present.ExistPointAmt);
      end;

      StoredProc.StoredProcName :='POS_SAVE_SALE_H';
      StoredProc.PrepareSQL;
      StoredProc.ParamByName('_WORK_KIND' ).AsString  := aGubun;
      StoredProc.ParamByName('_CD_STORE'  ).AsString  := Config.StoreCode;
      StoredProc.ParamByName('_YMD_SALE'  ).AsString  := WorkDate;
      StoredProc.ParamByName('_NO_POS'    ).AsString  := Config.PosNo;
      StoredProc.ParamByName('_NO_RCP'    ).AsString  := Present.RcpNo;
      StoredProc.ParamByName('_DS_ORDER'  ).AsString  := Table.OrderType;
      StoredProc.ParamByName('_YN_TAKEOUT' ).AsString := Ifthen(Common.Config.IsTakeOut, 'Y','N');
      if aGubun = 'C' then
        StoredProc.ParamByName('_DS_SALE'   ).AsString  := 'S'
      else
      begin
        if (aGubun = 'S') and (SoonAmt < 0) and (Common.Table.GroupAmt = 0) and (CheckSaleCount = 0) then
          StoredProc.ParamByName('_DS_SALE'   ).AsString  := 'B'
        else
          StoredProc.ParamByName('_DS_SALE'   ).AsString  := aGubun;
      end;
      StoredProc.ParamByName('_AMT_SALE'    ).AsInteger    := SoonAmt;
      StoredProc.ParamByName('_AMT_DUTY'    ).AsInteger    := Present.DutyAmt + Present.FreeAmt;
      StoredProc.ParamByName('_AMT_TAX'     ).AsInteger    := Present.TaxAmt;
      StoredProc.ParamByName('_AMT_DUTYFREE').AsInteger    := Present.FreeAmt;
      StoredProc.ParamByName('_AMT_CASH'    ).AsInteger    := Present.CashAmt - FtoI(Present.GiveAmt);
      StoredProc.ParamByName('_AMT_CARD'    ).AsInteger    := Present.CardAmt;
      StoredProc.ParamByName('_AMT_CHECK'   ).AsInteger    := Present.CheckAmt;
      StoredProc.ParamByName('_AMT_TRUST'   ).AsInteger    := Present.TrustAmt;
      StoredProc.ParamByName('_AMT_GIFT'    ).AsInteger    := Present.GiftAmt;
      StoredProc.ParamByName('_AMT_BANK'    ).AsInteger    := Present.BankAmt;
      StoredProc.ParamByName('_AMT_ETC'     ).AsInteger    := Present.EtcAmt;
      StoredProc.ParamByName('_AMT_LETSORDER').AsInteger   := Present.LetsOrderAmt;
      StoredProc.ParamByName('_AMT_POINT'   ).AsInteger    := Present.PointAmt;
      StoredProc.ParamByName('_NO_CALL'     ).AsInteger    := Present.CallNo;
      StoredProc.ParamByName('_DC_COUPON'   ).AsInteger    := Present.CouponDc;
      StoredProc.ParamByName('_DC_MENU'     ).AsInteger    := Present.MenuDc;
      StoredProc.ParamByName('_DC_SPC'      ).AsInteger    := Present.SpcDc;
      StoredProc.ParamByName('_DC_MEMBER'   ).AsInteger    := Present.MemberDc;
      StoredProc.ParamByName('_CD_CODE'     ).AsString     := Present.CodeDcCode;
      StoredProc.ParamByName('_DC_RECEIPT'  ).AsInteger    := Present.RcpDc;
      StoredProc.ParamByName('_DC_CODE'     ).AsInteger    := Present.CodeDc;
      StoredProc.ParamByName('_AMT_CASHTIP' ).AsInteger    := Present.CashTipAmt;
      StoredProc.ParamByName('_AMT_CARDTIP' ).AsInteger    := Present.CardTipAmt;
      StoredProc.ParamByName('_AMT_SERVICE' ).AsInteger    := Present.ServiceAmt;
      StoredProc.ParamByName('_DC_EVENT'    ).AsInteger    := 0;
      StoredProc.ParamByName('_DC_CUT'      ).AsInteger    := Present.CutDc;
      StoredProc.ParamByName('_DC_VAT'      ).AsInteger    := Present.VatDc;
      StoredProc.ParamByName('_DC_POINT'    ).AsInteger    := Present.PointDc;
      StoredProc.ParamByName('_DC_UPLUS').AsInteger        := Present.UPlusDc;
      StoredProc.ParamByName('_DC_KAKAO').AsInteger        := Present.KaKaoDc;
      StoredProc.ParamByName('_DC_LETSORDER').AsInteger    := Present.LetsOrderDc;
      StoredProc.ParamByName('_AMT_CASHRCP' ).AsInteger    := Present.CashRcpAmt;
      StoredProc.ParamByName('_NO_TABLE'    ).AsInteger    := Table.Number;
      StoredProc.ParamByName('_CD_SAWON'    ).AsString     := Config.UserCode;
      StoredProc.ParamByName('_CD_MEMBER'   ).AsString     := Member.Code;
      StoredProc.ParamByName('_DS_MEMBER'   ).AsString     := Member.cd_class;
      StoredProc.ParamByName('_CNT_PERSON'  ).Value        := Ifthen(StoredProc.ParamByName('_DS_SALE').AsString='B',-1,1) * Table.CustomerCount;
      StoredProc.ParamByName('_CD_CUSTOMER' ).AsString     := Table.CustCode;
      StoredProc.ParamByName('_CD_AGE'      ).AsString     := Table.DsCust;
      StoredProc.ParamByName('_DS_DELIVERY' ).AsString     := Ifthen(Config.isKiosk, ' ', Ifthen(Table.Packing='Y','S', Table.DsDelivery));
      StoredProc.ParamByName('_NO_DELIVERY' ).AsString     := Table.DeliveryNo;
      StoredProc.ParamByName('_NO_ORDER'    ).Value        := Table.OrderNo;
      StoredProc.ParamByName('_YMD_SALE_ORG').AsString     := Copy(BanReceipt,1,8);
      StoredProc.ParamByName('_NO_RCP_ORG').AsString       := Copy(BanReceipt,9,4);
      if OrderKind in [okDutchPay, okDutchPayEnd, okDutchPayAll] then
        StoredProc.ParamByName('_YN_DUTCHPAY').AsString    := 'Y'
      else
        StoredProc.ParamByName('_YN_DUTCHPAY').AsString    := 'N';
      StoredProc.ParamByName('_CD_DAMDANG').AsString       := Table.DamdangCode;
      StoredProc.ParamByName('_CANCEL_TXT').AsString       := WhyOrdercancel;
      StoredProc.ParamByName('_AMT_EXISTPOINT').AsInteger  := Present.ExistPointAmt;
      StoredProc.ParamByName('_PNT_USE').AsInteger         := Present.UsePnt;
      StoredProc.ParamByName('_PNT_OCCUR').AsInteger       := Present.OccurPnt;
      StoredProc.ParamByName('_DC_TAXFREE').AsInteger      := Present.TaxFreeDc;
      StoredProc.ParamByName('_TAXFREE_BUY_NO').AsString   := Present.TaxfreeNo;
      StoredProc.ParamByName('_DC_STAMP').AsInteger        := Present.StampDc;
      StoredProc.ParamByName('_SAVE_STAMP').AsInteger      := Present.SaveStamp;
      StoredProc.ParamByName('_USE_STAMP').AsInteger       := Present.UseStamp;
      StoredProc.ParamByName('_NOW_STAMP').AsInteger       := NVL(Member.Stamp+PreSent.SaveStamp-PreSent.UseStamp,0);
      StoredProc.ParamByName('_YN_LETSORDER' ).AsString    := Table.LetsOrder;
      StoredProc.ExecProc;

      vResult := StoredProc.ParamByName('_RESULT').AsString;
      StoredProc.Close;
      if vResult <> 'OK' then
        raise Exception.Create(vResult);

      //매달건을 취소했을때 배달전표를 결제취소 상태로 변경한다.
      if (Table.OrderType = 'D') and (aGubun = 'V') then
      begin
        ExecQuery('update SL_DELIVERY '
                 +'   set DS_STEP  =''V'' '
				         +' where CD_STORE =:P0 '
				         +'   and ConCat(YMD_DELIVERY,NO_DELIVERY) =:P1 ',
                 [Config.StoreCode,
                  Table.DeliveryNo]);
      end;

      // 매출 디테일 저장   결제변경일때는 프로시저에서  SL_SALE_D을 삭제한다
      if (aGubun = 'S') or (aGubun = 'C') then
      begin
        with Temp_sGrd, UniSQL do
        begin
          SQL.Text := 'insert into SL_SALE_D(CD_STORE, '
                     +'					             YMD_SALE, '
                     +'					             NO_POS, '
                     +'					             NO_RCP, '
                     +'					             SEQ, '
                     +'					             CD_MENU, '
                     +'					             DS_SALE_TYPE, '
                     +'                      DS_SALE, '
                     +'					             QTY_SALE, '
                     +'					             PR_SALE, '
                     +'					             AMT_SALE, '
                     +'					             PR_SERVICE, '
                     +'					             PR_TIP, '
                     +'					             PR_ITEM, '
                     +'					             DC_MENU, '
                     +'					             DC_SPC, '
                     +'					             NO_SPC, '
                     +'					             DC_RECEIPT, '
                     +'					             DC_MEMBER, '
                     +'					             AMT_VAT, '
                     +'					             DS_TAX, '
                     +'					             CD_ITEMS, '
                     +'					             NM_ITEMS, '
                     +'					             AMT_BUY, '
                     +'                      CD_SERVICE, '
                     +'                      DC_TAXFREE, '
                     +'                      DC_STAMP, '
                     +'                      SAVE_STAMP, '
                     +'                      USE_STAMP, '
                     +'                      CD_MEMBER, '
                     +'                      DS_MENU_TYPE, '
                     +'                      DS_STOCK, '
                     +'                      QTY_UNIT, '
                     +'                      YN_DOUBLE, '
                     +'                      DC_TOT) '
                     +'              	values(:P0, '
                     +'              				 :P1, '
                     +'              				 :P2, '
                     +'              				 :P3, '
                     +'              				 :P4, '
                     +'              				 :P5, '
                     +'              				 :P6, '
                     +'                      :P7, '
                     +'              				 :P8, '
                     +'              				 :P9, '
                     +'              				 :P10, '
                     +'              				 :P11, '
                     +'              				 :P12, '
                     +'              				 :P13, '
                     +'              				 :P14, '
                     +'              				 :P15, '
                     +'              				 :P16, '
                     +'              				 :P17, '
                     +'              				 :P18, '
                     +'              				 :P19, '
                     +'              				 :P20, '
                     +'              				 :P21, '
                     +'              				 :P22, '
                     +'              				 :P23, '
                     +'                      :P24, '
                     +'                      :P25, '
                     +'                      :P26, '
                     +'                      :P27, '
                     +'                      :P28, '
                     +'                      :P29, '
                     +'                      :P30, '
                     +'                      :P31, '
                     +'                      :P32, '
                     +'                      :P33, '
                     +'                      :P14+:P15+:P17+:P18+:P25+:P26) ';
          vSeq := 1;
          for liRow := 0 to RowCount-1 do
          begin
            if Trim(Cells[GDM_CD_MENU, liRow])  = ''  then Continue;
            if Trim(Cells[GDM_CD_MENU1, liRow]) <> '' then Continue;
            if (GetOption(178) = '1') and (Cells[GDM_YN_RCP, liRow] = 'N') then Continue;

            Cells[GDM_SEQ, liRow] := IntToStr(vSeq);

            ParamByName('P0').AsString  := Config.StoreCode;
            ParamByName('P1').AsString  := WorkDate;
            ParamByName('P2').AsString  := Config.PosNo;
            ParamByName('P3').AsString  := Present.RcpNo;
            ParamByName('P4').AsInteger  := vSeq;
            liPos := POS(',',Cells[GDM_CD_MENU, liRow]);
            if liPos > 0 then
              ParamByName('P5').AsString := Copy(Cells[GDM_CD_MENU, liRow],1, liPos-1)
            else
              ParamByName('P5').AsString := Cells[GDM_CD_MENU, liRow];

            ParamByName('P6').AsString  := Cells[GDM_DS_SALE, liRow];

            if aGubun[1] in ['B','V']  then
              ParamByName('P7').AsString  := aGubun
            else
              ParamByName('P7').AsString  := 'S';

            ParamByName('P8').AsInteger  := StoI(Cells[GDM_QTY,       liRow]);
            ParamByName('P9').AsInteger  := StoI(Cells[GDM_PR_SALE,   liRow])+ Ifthen(Cells[GDM_DS_SALE, liRow]='D',0, StoI(Cells[GDM_PR_ITEM,   liRow]));
            ParamByName('P10').AsInteger := StoI(Cells[GDM_AMT,       liRow]);
            if Cells[GDM_DS_SALE, liRow] = 'D' then
              ParamByName('P11').AsInteger  := ABS(StoI(Cells[GDM_PR_SALE_ORG, liRow]))
            else
              ParamByName('P11').AsInteger  := 0;
            ParamByName('P12').AsInteger    := StoI(Cells[GDM_TIP,       liRow]);
            ParamByName('P13').AsInteger    := StoI(Cells[GDM_PR_ITEM,   liRow]);

            if Cells[GDM_DS_MENU,  liRow] <> 'W' then
            begin
              ParamByName('P14').AsInteger  := StoI(Cells[GDM_DC_MENU,   liRow]) * StoI(Cells[GDM_QTY,  liRow]);
              if Cells[GDM_DS_SALE, liRow] = 'D' then
              begin
                ParamByName('P15').AsInteger := 0;
                ParamByName('P16').AsString  :='';
              end
              else
              begin
                ParamByName('P15').AsInteger := StoI(Cells[GDM_DC_SPC,    liRow]) * StoI(Cells[GDM_QTY,  liRow]);
                ParamByName('P16').AsString  := Cells[GDM_NO_SPC,         liRow];
              end;
              ParamByName('P10').AsInteger   := (StoI(Cells[GDM_PR_SALE,   liRow])+Ifthen(Cells[GDM_DS_SALE, liRow]='D',0, StoI(Cells[GDM_PR_ITEM,   liRow]))) * StoI(Cells[GDM_QTY,  liRow]);
            end
            else
            begin
              ParamByName('P14').AsInteger  := StoI(Cells[GDM_DC_MENU,   liRow]);
              if Cells[GDM_DS_SALE, liRow] = 'D' then
              begin
                ParamByName('P15').AsInteger  := 0;
                ParamByName('P16').AsString   :='';
              end
              else
              begin
                ParamByName('P15').AsInteger  := StoI(Cells[GDM_DC_SPC,    liRow]);
                ParamByName('P16').AsString   := Cells[GDM_NO_SPC,         liRow];
              end;
            end;
            ParamByName('P17').AsInteger  := StoI(Cells[GDM_DC_RECEIPT, liRow]);
            ParamByName('P18').AsInteger  := StoI(Cells[GDM_DC_MEMBER,  liRow]);
            ParamByName('P19').AsInteger  := StoI(Cells[GDM_AMT_TAX,    liRow]);
            ParamByName('P20').AsString   := Cells[GDM_DS_TAX,          liRow];
            ParamByName('P21').AsString   := Cells[GDM_CD_ITEM,         liRow];
            ParamByName('P22').AsString   := Cells[GDM_NM_ITEM,         liRow];

            vSaleAmt := StoI(Cells[GDM_AMT, liRow]) - StoI(Cells[GDM_DC_MENU, liRow]) - StoI(Cells[GDM_DC_RECEIPT, liRow]) - StoI(Cells[GDM_DC_SPC, liRow]);
            //매입단가0, 이익률 100%
            if (Cells[GDM_PR_BUY, liRow] = '0') and (Cells[GDM_RT_PROFIT, liRow] = '100') then
              ParamByName('P23').AsInteger := 0
            //매입단가0, 이익률 0%
            else if (Cells[GDM_PR_BUY, liRow] = '0') and (Cells[GDM_RT_PROFIT, liRow] = '0') then
              ParamByName('P23').AsInteger := vSaleAmt
            //매입단가0, 이익률 0이 아닐때
            else if (Cells[GDM_PR_BUY, liRow] = '0') and (Cells[GDM_RT_PROFIT, liRow] <> '0') then
              ParamByName('P23').AsInteger := vSaleAmt - FtoI(vSaleAmt * (StoF(Cells[GDM_RT_PROFIT, liRow]) / 100))
            else
              ParamByName('P23').AsInteger := StoI(Cells[GDM_PR_BUY, liRow]) * Ifthen(Cells[GDM_DS_MENU,  liRow] = 'W', 1, StoI(Cells[GDM_QTY,  liRow]));
            ParamByName('P24').AsString   := Cells[GDM_CD_SERVICE,         liRow];
            ParamByName('P25').AsInteger  := StoI(Cells[GDM_DC_TAXFREE,  liRow]);
            ParamByName('P26').AsInteger  := StoI(Cells[GDM_DC_STAMP,    liRow]);
            ParamByName('P27').AsInteger  := StoI(Cells[GDM_SAVE_STAMP,  liRow]);
            ParamByName('P28').AsInteger  := StoI(Cells[GDM_USE_STAMP,  liRow]);
            ParamByName('P29').AsString  := Member.Code;
            ParamByName('P30').AsString  := Cells[GDM_DS_MENU,   liRow];
            ParamByName('P31').AsString  := Cells[GDM_DS_STOCK,  liRow];
            ParamByName('P32').AsInteger  := StoI(Cells[GDM_QTY_UNIT,  liRow]);
            ParamByName('P33').AsString  := Cells[GDM_YN_DOUBLE,  liRow];
            Execute;
            Inc(vSeq);
          end;

          for vIndex := 0 to Order_F.Main_sGrd.RowCount-1 do
          begin
            if Order_F.Main_sGrd.Cells[GDM_YN_ORDER,    vIndex] = 'Y' then Continue;
            if Order_F.Main_sGrd.Cells[GDM_CD_MENU1,    vIndex] <> '' then Continue;

            DM.SQL.SQL.Text := 'insert into SL_ORDER_HIST(CD_STORE, '
                              +'                          NO_TABLE, '
                              +'                          SEQ, '
                              +'                          DS_ORDER, '
                              +'                          NO_POS, '
                              +'                          CD_MENU, '
                              +'                          QTY_ORDER, '
                              +'                          DT_ORDER, '
                              +'                          ORDER_REF, '
                              +'                          NO_ORDER) '
                              +'                   values(:P0, '
                              +'                          :P1, '
                              +'                           (select Ifnull(MAX(SEQ),0)+1 '
                              +'                              from SL_ORDER_HIST s '
                              +'                             where CD_STORE  = :P0 '
                              +'                               and NO_TABLE  = :P1), '
                              +'                          ''P'', '
                              +'                          :P2, '
                              +'                          :P3, '
                              +'                          :P4, '
                              +'                          NOW(), '
                              +'                          '''', '
                              +'                          :P5) ';
             DM.SQL.ParamByName('P0').AsString  := StoreCode;
             DM.SQL.ParamByName('P1').AsInteger := Table.Number;
             DM.SQL.ParamByName('P2').AsString  := Config.PosNo;
             DM.SQL.ParamByName('P3').AsString  := Order_F.Main_sGrd.Cells[GDM_CD_MENU, vIndex];
             DM.SQL.ParamByName('P4').AsInteger := StoI(Order_F.Main_sGrd.Cells[GDM_QTY, vIndex]);
             DM.SQL.ParamByName('P5').AsInteger := Table.OrderNo;
             DM.SQL.Execute;
          end;


          //저장데이터가 없을때 (출력하지 않는메뉴 저장하지 않을때 등)
          if vSeq = 1 then
            raise Exception.Create('저장할 메뉴내역이 없습니다');


          //메뉴에 봉사료금액을 포함하지 않으면서 봉사료 금액이 있으면 환경설정에 설정된 봉사료 메뉴를 자동을 추가한다
          if (GetOption(160) = '0') and (Present.TipAmt > 0) and (aGubun = 'S') then
          begin
            UniSQL.ParamByName('P0').AsString   := Config.StoreCode;
            UniSQL.ParamByName('P1').AsString   := WorkDate;
            UniSQL.ParamByName('P2').AsString   := Config.PosNo;
            UniSQL.ParamByName('P3').AsString   := Present.RcpNo;
            UniSQL.ParamByName('P4').AsInteger  := Cnt;
            UniSQL.ParamByName('P5').AsString   := Config.TipMenu;
            UniSQL.ParamByName('P6').AsString   := 'S';
            UniSQL.ParamByName('P7').AsString   := 'S';
            UniSQL.ParamByName('P8').AsInteger  := 1;
            UniSQL.ParamByName('P9').AsInteger  := Present.TipAmt;
            UniSQL.ParamByName('P10').AsInteger := Present.TipAmt;
            UniSQL.ParamByName('P11').AsInteger := 0;
            UniSQL.ParamByName('P12').AsInteger := Present.TipAmt;
            UniSQL.ParamByName('P13').AsInteger := 0;
            UniSQL.ParamByName('P14').AsInteger := 0;
            UniSQL.ParamByName('P15').AsInteger := 0;
            UniSQL.ParamByName('P16').AsString  := '';
            UniSQL.ParamByName('P17').AsInteger := 0;
            UniSQL.ParamByName('P18').AsInteger := 0;
            UniSQL.ParamByName('P19').AsInteger := 0;
            UniSQL.ParamByName('P20').AsString  := '0';
            UniSQL.ParamByName('P21').AsString  := '';
            UniSQL.ParamByName('P22').AsString  := '';
            UniSQL.ParamByName('P23').AsInteger := 0;
            UniSQL.ParamByName('P24').AsString  := '';
            UniSQL.ParamByName('P25').AsInteger := 0;
            UniSQL.ParamByName('P26').AsInteger := 0;
            UniSQL.ParamByName('P27').AsInteger := 0;
            UniSQL.ParamByName('P28').AsInteger := 0;
            UniSQL.ParamByName('P29').AsString  := Member.Code;
            UniSQL.ParamByName('P30').AsString  := 'N';
            UniSQL.ParamByName('P31').AsString  := '0';
            UniSQL.ParamByName('P32').AsInteger  := 0;
            UniSQL.ParamByName('P33').AsString  := 'N';
            UniSQL.Execute;
          end;
        end;
      end;

      //그룹정산시 사용
      vGroupSeq := vSeq;

      //고객수 추정메뉴 라벨출력시
      if GetOption(326) = '1' then
      begin
        LabelPrintData := TStringList.Create;
        LabelPrintData.Clear;
        vLabelData := EmptyStr;
        vQty1      := 1;
      end;

      //매출출해더에 이익률 금액을 반영한다
      ExecQuery('update SL_SALE_H '
               +'   set AMT_BUY =Ifnull((select Sum(AMT_BUY) '
               +'                          from SL_SALE_D '
               +'                         where CD_STORE =:P0 '
               +'                           and YMD_SALE =:P1 '
               +'                           and NO_POS   =:P2 '
               +'                           and NO_RCP   =:P3) ,0) '
               +' where CD_STORE =:P0 '
               +'   and YMD_SALE =:P1 '
               +'   and NO_POS   =:P2 '
               +'   and NO_RCP   =:P3 ',
               [Config.StoreCode,
                WorkDate,
                Config.PosNo,
                Present.RcpNo]);

      vSeq    := 0;
      vSubSeq := 0;
      if (aGubun = 'S') then
      begin
        with Order_F.Main_sGrd do
        begin
          For liRow := 0 to RowCount-1 do
          begin
            if Order_F.Main_sGrd.Cells[0,0] = '' then Continue;
            if Order_F.Main_sGrd.Cells[GDM_CD_MENU1, liRow] = '' then
            begin
              Inc(vSeq);
              vSubSeq := 0;
            end
            else Inc(vSubSeq);

            if Order_F.Main_sGrd.Cells[GDM_DS_MENU, liRow] = 'I' then
            begin
              //아이템 부메뉴 라벨출력
              if Order_F.Main_sGrd.Cells[GDM_CD_MENU1, liRow] = '' then
              begin
                if GetOption(326) = '1' then
                begin
                  Cnt := CharCnt(Order_F.Main_sGrd.Cells[GDM_CD_MENU, liRow],',');
                  MenuCode  := Order_F.Main_sGrd.Cells[GDM_CD_MENU, liRow] + ',';
                  if vLabelData <> '' then
                  begin
                    For vIndex := 1 to vQty do
                      LabelPrintData.Add(vLabelData);
                  end;
                  vLabelData := EmptyStr;
                  //고객수 추정메뉴인지
                  visPerson := Order_F.Main_sGrd.Cells[GDM_YN_PERSON, liRow] <> '0';
                  vQty      := StoI(Order_F.Main_sGrd.Cells[GDM_QTY, liRow]);
                end;
              end
              else
              begin
                Cnt := 0;
                MenuCode := Order_F.Main_sGrd.Cells[GDM_CD_MENU1, liRow] + ',';
                vResult := SubMenuDataSave(Order_F.Main_sGrd.Cells[GDM_CD_MENU1, liRow],
                                           Order_F.Main_sGrd.Cells[GDM_DS_SALE, liRow],
                                           StoI(Order_F.Main_sGrd.Cells[GDM_QTY, liRow]),
                                           StoI(Order_F.Main_sGrd.Cells[GDM_PR_SALE, liRow]),
                                           StoI(Order_F.Main_sGrd.Cells[GDM_QTY_UNIT, liRow]),
                                           Order_F.Main_sGrd.Cells[GDM_DS_MENU, liRow],
                                           Order_F.Main_sGrd.Cells[GDM_DS_STOCK, liRow],
                                           vSeq,
                                           vSubSeq);
                if vResult <> EmptyStr then
                  raise Exception.Create(vResult);
              end;

              For liMenu := 0 to Cnt do
              begin
                vMenuCode := CopyPos(MenuCode,',',liMenu);

                if Trim(vMenuCode) = EmptyStr then Continue;

                if (GetOption(326) = '1') and visPerson then
                begin
                  OpenQuery('select NM_MENU_SHORT '
                           +'  from MS_MENU '
                           +' where CD_STORE =:P0 '
                           +'   and CD_MENU  =:P1 ',
                           [Config.StoreCode,
                            vMenuCode]);
                  if vLabelData = EmptyStr then
                  begin
                    vQty1 := StoI(Order_F.Main_sGrd.Cells[GDM_QTY, liRow]);
                    vLabelData := vLabelData + Query.Fields[0].AsString +#28;
                  end
                  else
                    vLabelData := vLabelData + Format('%-20.20s  %d',[Query.Fields[0].AsString, StoI(Order_F.Main_sGrd.Cells[GDM_QTY, liRow]) div vQty1 ])+#28;
                  Query.Close;
                end;
              end;
            end
            else
            begin
              if vLabelData <> '' then
              begin
                For vIndex := 1 to vQty do
                  LabelPrintData.Add(vLabelData);
                vLabelData := EmptyStr;
              end;

              if (GetOption(326) = '1') and (Order_F.Main_sGrd.Cells[GDM_DS_MENU, liRow] = 'N') and (Order_F.Main_sGrd.Cells[GDM_YN_PERSON, liRow] = 'Y') and (Order_F.Main_sGrd.Cells[GDM_CD_MENU1, liRow] = '') then
              begin
                vQty      := StoI(Order_F.Main_sGrd.Cells[GDM_QTY, liRow]);
                vLabelData := vLabelData + Format('%-20.20s  %d',[Order_F.Main_sGrd.Cells[GDM_NM_MENU, liRow], 1 ])+#28;
              end;

              vResult := SubMenuDataSave(Order_F.Main_sGrd.Cells[GDM_CD_MENU1, liRow],
                                         Order_F.Main_sGrd.Cells[GDM_DS_SALE, liRow],
                                         StoI(Order_F.Main_sGrd.Cells[GDM_QTY, liRow]),
                                         StoI(Order_F.Main_sGrd.Cells[GDM_PR_SALE, liRow]),
                                         StoI(Order_F.Main_sGrd.Cells[GDM_QTY_UNIT, liRow]),
                                         Order_F.Main_sGrd.Cells[GDM_DS_MENU, liRow],
                                         Order_F.Main_sGrd.Cells[GDM_DS_STOCK, liRow],
                                         vSeq,
                                         vSubSeq);

              if vResult <> EmptyStr then
                raise Exception.Create(vResult);
            end;
          end;

          if (GetOption(326) = '1') and (vLabelData <> '') then
          begin
            For vIndex := 1 to vQty do
              LabelPrintData.Add(vLabelData);
          end;
        end;

        //그룹디테일의 상품내역을 저장한다
        if (Group_sGrd.Cells[0,0] <> '') then
        begin
          vGroupSeq := 0;
          OpenQuery('select Ifnull(Max(SEQ),0) '
                   +'  from SL_SALE_S '
                   +' where CD_STORE =:P0 '
                   +'   and YMD_SALE =:P1 '
                   +'   and NO_POS   =:P2 '
                   +'   and NO_RCP   =:P3 ',
                   [Config.StoreCode,
                    WorkDate,
                    Config.PosNo,
                    Present.RcpNo]);
          if not Query.Eof then
            vGroupSeq := Query.Fields[0].AsInteger;
          Query.Close;

          OpenQuery('select t1.NO_TABLE, '
                   +'       t1.CD_MENU1, '
                   +'       t1.QTY_ORDER, '
                   +'       t1.PR_SALE, '
                   +'       t1.DS_MENU_TYPE, '
                   +'       t3.DS_STOCK, '
                   +'       t3.QTY_UNIT, '
                   +'       t1.DS_SALE, '
                   +'       t1.SEQ, '
                   +'       t1.NO_STEP '
                   +'  from SL_ORDER_D t1 inner join '
                   +'	     (select a.CD_STORE, '
                   +'              a.NO_TABLE '
                   +'	        from SL_ORDER_H a inner join '
                   +'              MS_TABLE   b on b.CD_STORE = a.CD_STORE '
                   +'                          and b.NO_TABLE = a.NO_TABLE '
                   +'                          and b.NO_TABLE <> b.NO_TABLE_GROUP '
                   +'                          and b.NO_TABLE_GROUP =:P1 '
                   +'	       where a.CD_STORE =:P0 '
                   +'          and a.DS_ORDER =''T'') t2 on t2.CD_STORE = t1.CD_STORE '
                   +'                                   and t2.NO_TABLE = t1.NO_TABLE inner join '
                   +'       MS_MENU as t3 on t3.CD_STORE = t1.CD_STORE '
                   +'                    and t3.CD_MENU  = t1.CD_MENU '
                   +' where t1.CD_STORE = :P0 '
                   +'   and t1.DS_MENU_TYPE in (''C'',''S'',''O'',''I'') '
                   +'   and t1.DS_ORDER = ''T'' '
                   +' order by t1.NO_TABLE, t1.SEQ, t1.NO_STEP ',
                   [Config.StoreCode,
                    Table.Number]);
          while not Query.Eof do
          begin
            if Query.FieldByName('CD_MENU1').AsString = '' then
              vGroupSeq := vGroupSeq + 1
            else
              ExecQuery('insert into SL_SALE_S(CD_STORE, '
                       +'				        		   YMD_SALE, '
                       +'				        			 NO_POS, '
                       +'				        			 NO_RCP, '
                       +'				        			 SEQ, '
                       +'                      SUB_SEQ, '
                       +'				        			 CD_MENU, '
                       +'                      DS_SALE_TYPE, '
                       +'				        			 QTY_SALE, '
                       +'                      PR_SALE, '
                       +'                      DS_MENU_TYPE, '
                       +'                      DS_STOCK, '
                       +'                      QTY_UNIT) '
                       +'	          	values( :P0, '
                       +'				        			:P1, '
                       +'				        			:P2, '
                       +'				        			:P3, '
                       +'				        			:P4, '
                       +'				        			:P5, '
                       +'				        			:P6, '
                       +'				        			:P7, '
                       +'				        			:P8, '
                       +'				        			:P9, '
                       +'				        			:P10, '
                       +'                     :P11, '
                       +'                     :P12) ',
                       [Config.StoreCode,
                        WorkDate,
                        Config.PosNo,
                        Present.RcpNo,
                        vGroupSeq,
                        Query.FieldByName('NO_STEP').AsInteger,
                        Query.FieldByName('CD_MENU1').AsString,
                        Query.FieldByName('DS_SALE').AsString,
                        Query.FieldByName('QTY_ORDER').AsInteger,
                        Query.FieldByName('PR_SALE').AsInteger,
                        Query.FieldByName('DS_MENU_TYPE').AsString,
                        Query.FieldByName('DS_STOCK').AsString,
                        Query.FieldByName('QTY_UNIT').AsInteger,
                        vSeq]);

            Query.Next;
          end;
          Query.Close;

          //그룹디테일에 출력로그
          ExecQuery('insert into SL_SALE_PRT(CD_STORE, '
                   +'                        YMD_SALE, '
                   +'                        NO_POS, '
                   +'                        NO_RCP, '
                   +'                   		 NO_TABLE, '
                   +'                   		 DS_ORDER, '
                   +'                   		 NO_ORDER, '
                   +'                   		 CD_PRINTER, '
                   +'                   		 SEQ, '
                   +'                   		 PRINT_DATA, '
                   +'                   		 NO_PERSON, '
                   +'                   		 NM_DAMDANG, '
                   +'                   		 ORDER_TIME) '
                   +'select t1.CD_STORE, '
                   +'       :P1, '
                   +'       :P2, '
                   +'       :P3, '
                   +'       t1.NO_TABLE, '
                   +'       t1.DS_ORDER, '
                   +'       t1.NO_ORDER, '
                   +'       t1.CD_PRINTER, '
                   +'       @ROWNUM:=@ROWNUM+1, '
                   +'       t1.PRINT_DATA, '
                   +'       t1.NO_PERSON, '
                   +'       t1.NM_DAMDANG, '
                   +'       t1.ORDER_TIME '
                   +'  from SL_ORDER_PRT t1 inner join '
                   +'	     (select NO_TABLE '
                   +'	        from MS_TABLE '
                   +'	       where CD_STORE =:P0 '
                   +'          and NO_TABLE <> NO_TABLE_GROUP '
                   +'          and NO_TABLE_GROUP =:P4 '
                   +'      ) t2 on t2.NO_TABLE = t1.NO_TABLE inner join  '
                   +'      (SELECT @rownum:=0) as R '
                   +' where t1.CD_STORE = :P0 '
                   +' order by t1.NO_TABLE ',
                   [Config.StoreCode,
                    WorkDate,
                    Config.PosNo,
                    Present.RcpNo,
                    Table.Number]);
        end;
      end;

      {연령대정보}
      if (OrderKind <> okChange) then
      begin
        ExecQuery('delete '
                 +'  from SL_SALE_AGE '
                 +' where CD_STORE =:P0 '
                 +'   and YMD_SALE =:P1 '
                 +'   and NO_POS   =:P2 '
                 +'   and NO_RCP   =:P3 ',
                 [Config.StoreCode,
                  WorkDate,
                  Config.PosNo,
                  Present.rcpno]);

        //회원에 연령대가 있으면
        if Length(Common.Member.AgeCode) = 3 then
        begin
          For vIndex := 0 to Table.AgeCode.Count-1 do
          begin
            if LeftStr(Table.AgeCode.Strings[vIndex],3) = Common.Member.AgeCode then
            begin
              Table.AgeCode.Strings[vIndex] := Format('%s%s',[Common.Member.AgeCode, FormatFloat('000',Ifthen(Table.CustomerCount=0,1,Table.CustomerCount))]);
              Break;
            end;
          end;
        end;


        For vIndex := 0 to Table.AgeCode.Count-1 do
        begin
          if StrToIntDef(Copy(Table.AgeCode.Strings[vIndex],4,3),0) = 0 then Continue;
          if Length(Trim(Table.AgeCode.Strings[vIndex])) = 6 then
          ExecQuery('insert into SL_SALE_AGE(CD_STORE, YMD_SALE, NO_POS, NO_RCP, CD_AGE, CNT_PERSON) '
                   +'                 values(:P0,:P1,:P2,:P3,:P4,:P5)',
                   [Config.StoreCode,
                     WorkDate,
                     Config.PosNo,
                     Present.rcpno,
                     Copy(Table.AgeCode.Strings[vIndex],1,3),
                     StrToIntDef(Copy(Table.AgeCode.Strings[vIndex],4,3),0)
                    ]);
        end;
      end;

      // 렛츠오더 전송때문에 앞에서 저장
      {신용카드}
      if  Card_SGrd.Cells[0,0] <> '' then
      begin
         For vIndex := 0 to Card_sGrd.RowCount -1 do
         begin
            With Card_SGrd, Common do
            begin
               if Cells[GDC_YN_SAVE,vIndex] = 'Y' then
               begin
                  if not CardDataSave('','C', PreSent.RcpNo, vIndex) then
                    raise Exception.Create('신용카드 저장 중 에러');
               end;
            end;
         end;
      end;

      {현금영수증}
      if Cash_SGrd.Cells[0,0] <> '' then
      begin
        DM.OpenQuery('select Ifnull(MAX(SEQ), 0) as SEQ '
                 +'  from SL_CASH '
                 +' where CD_STORE	 =:P0 '
                 +'   and YMD_SALE	 =:P1 '
                 +'   and NO_POS	   =:P2 '
                 +'   and NO_RCP     =:P3 ',
                 [Config.StoreCode,
                  WorkDate,
                  Config.PosNo,
                  PreSent.RcpNo]);
        vSeq := DM.Query.FieldByName('SEQ').AsInteger;
        Query.Close;

        For vIndex := 0 to Cash_sGrd.RowCount -1 do
        begin
          with Cash_SGrd, Common do
          begin
            if Cells[GDR_YN_SAVE,vIndex] = 'Y' then
            begin
              Inc(vSeq);
              ExecQuery('insert into SL_CASH(CD_STORE, '
                       +'		                 YMD_SALE, '
                       +'		                 NO_POS, '
                       +'		                 NO_RCP, '
                       +'		                 SEQ, '
                       +'		                 DS_TRD, '
                       +'		                 DS_KIND, '
                       +'		                 DS_TYPE, '
                       +'		                 DS_INPUT, '
                       +'		                 NO_CARD, '
                       +'		                 NO_APPROVAL, '
                       +'		                 AMT_APPROVAL, '
                       +'		                 AMT_VAT, '
                       +'		                 TRD_DATE, '
                       +'		                 TRD_DATE_ORG, '
                       +'		                 NO_APPROVAL_ORG, '
                       +'		                 CD_CORNER, '
                       +'                    NO_CARD_FULL, '
                       +'                    YN_CAT, '
                       +'                    VAN_TID) '
                       +'             Values(:P0, '
                       +'		                :P1, '
                       +'		                :P2, '
                       +'		                :P3, '
                       +'		                :P4, '
                       +'		                :P5, '
                       +'		                :P6, '
                       +'		                :P7, '
                       +'		                :P8, '
                       +'		                :P9, '
                       +'		                :P10, '
                       +'		                :P11, '
                       +'		                :P12, '
                       +'		                :P13, '
                       +'		                :P14, '
                       +'		                :P15, '
                       +'		                :P16, '
                       +'		                :P17, '
                       +'                   :P18, '
                       +'                   :P19)',
                       [Config.StoreCode,
                        WorkDate,
                        Config.PosNo,
                        PreSent.RcpNo,
                        vSeq,
                        Trim(Cells[GDR_DS_TRD,           vIndex]),
                        Trim(Cells[GDR_DS_KIND,          vIndex]),
                        Trim(Cells[GDR_DS_TYPE,          vIndex]),
                        Trim(Cells[GDR_DS_INPUT,         vIndex]),
                        LeftStr(GetCardNoFormat(Cells[GDR_CARDNO, vIndex],true),20),
                        Trim(Cells[GDR_NO_APPROVAL, vIndex]),
                        StoI(Trim(Cells[GDR_AMT,    vIndex])),
                        StoI(Trim(Cells[GDR_VAT,    vIndex])),
                        Trim(Cells[GDR_TRD_DATE,         vIndex]),
                        Trim(Cells[GDR_TRD_DATE_ORG,     vIndex]),
                        Trim(Cells[GDR_APPROVAL_ORG,     vIndex]),
                        Trim(Cells[GDR_CORNER,           vIndex]),
                        Trim(Cells[GDR_FULLCARDNO,       vIndex]),
                        Trim(Cells[GDR_YN_CAT,           vIndex]),
                        Trim(Cells[GDR_VAN_TID,          vIndex])]);
            end;
          end;
        end;
      end;


      if (Table.OrderType = 'T') and (OrderKind in [okNew, okAppend]) and (aGubun <> 'V') then
      begin
        ExecQuery('delete from SL_CARD_AHEAD '
                 +' where CD_STORE =:P0 '
                 +'   and NO_TABLE =:P1 '
                 +'   and DS_CARD  <> ''P'' ',
                 [Config.StoreCode,
                  Table.Number]);
        ExecQuery('delete from SL_CASH_AHEAD '
                 +' where CD_STORE =:P0 '
                 +'   and NO_TABLE =:P1 ',
                 [Config.StoreCode,
                  Table.Number]);

        //Lets Order에 결제내역 삭제
        for vIndex := 0 to Card_SGrd.RowCount-1 do
          if Card_SGrd.Cells[GDC_PG_TID,   vIndex] <> '' then
            ExecQuery('delete from SL_CARD_AHEAD '
                     +' where CD_STORE =:P0 '
                     +'   and DS_CARD  =''P'' '
                     +'   and PG_TID   =:P1 ',
                     [Config.StoreCode,
                      Card_SGrd.Cells[GDC_PG_TID,   vIndex]]);
      end;


      {UPlus할인 저장}
      if UPlus_sGrd.Cells[0,0] <> '' then
      begin
        For vIndex := 0 to UPlus_SGrd.RowCount -1 do
        begin
          With UPlus_SGrd do
          begin
            if Cells[GDK_YN_SAVE,vIndex] = 'Y' then
            begin
              OpenQuery('select Ifnull(MAX(SEQ), 0) + 1 '
                       +'  from SL_UPLUS '
                       +' where CD_STORE	 =:P0 '
                       +'   and YMD_SALE	 =:P1 '
                       +'   and NO_POS	   =:P2 '
                       +'   and NO_RCP    =:P3 ',
                       [Config.StoreCode,
                        WorkDate,
                        Config.PosNo,
                        PreSent.RcpNo]);
              vSeq := Query.Fields[0].AsInteger;
              Query.Close;

              ExecQuery('insert into SL_UPLUS(CD_STORE, '
                       +'                    	YMD_SALE, '
                       +'                    	NO_POS, '
                       +'                    	NO_RCP, '
                       +'                     SEQ, '
                       +'                    	DS_TRD, '
                       +'                    	AMT_DC, '
                       +'                    	AMT_SALE, '
                       +'                    	NO_CARD, '
                       +'                    	NO_APPROVAL, '
                       +'                    	APPROVAL_DATE, '
                       +'                    	PNT_REST, '
                       +'                    	NO_TELMFlW, '
                       +'                    	APPROVAL_DATE_ORG, '
                       +'                    	NO_APPROVAL_ORG) '
                       +'              VALUES(:P0, '
                       +'                    	:P1, '
                       +'                    	:P2, '
                       +'                    	:P3, '
                       +'                    	:P4, '
                       +'                    	:P5, '
                       +'                    	:P6, '
                       +'                    	:P7, '
                       +'                    	:P8, '
                       +'                    	:P9, '
                       +'                    	:P10, '
                       +'                    	:P11, '
                       +'                    	:P12, '
                       +'                    	:P13, '
                       +'                    	:P14) ',
                       [Config.StoreCode,
                        WorkDate,
                        Config.PosNo,
                        PreSent.RcpNo,
                        vSeq,
                        Cells[GDK_DS_TRD,        vIndex],
                        StoI(Cells[GDK_DC_AMT,   vIndex]),
                        StoI(Cells[GDK_AMT,      vIndex]),
                        Cells[GDK_CARDNO,        vIndex],
                        Cells[GDK_NO_APPROVAL,   vIndex],
                        Cells[GDK_TRD_DATE,      vIndex],
                        StoI(Cells[GDK_PNT_REST, vIndex]),
                        StoI(Cells[GDK_CHAINPL,  vIndex]),     //전문번호로 사용(GDK_CHAINPL)
                        Cells[GDK_TRD_DATE_ORG,  vIndex],
                        Cells[GDK_APPROVAL_ORG,  vIndex]]);
            end;
          end;
        end;
      end;


      //쿠폰사용내역 저장
      if (aGubun = 'S') and (Present.CouponNo <> '') then
      begin
        ExecQuery('insert into SL_SALE_COUPON(CD_STORE, '
                 +'                           YMD_SALE, '
                 +'                           NO_POS, '
                 +'                           NO_RCP, '
                 +'                           SEQ, '
                 +'                           NO_COUPON, '
                 +'                           AMT_DC, '
                 +'                           DS_COUPON) '
                 +'                    Values(:P0, '
                 +'                           :P1, '
                 +'                           :P2, '
                 +'                           :P3, '
                 +'                           :P4, '
                 +'                           :P5, '
                 +'                           :P6, '
                 +'                           :P7) ',
                 [Config.StoreCode,
                  WorkDate,
                  Config.PosNo,
                  Present.RcpNo,
                  1,
                  Present.CouponNo,
                  Present.CouponDC,
                  Present.CouponKind]);

        ExecQuery('update MS_COUPON '
                 +'   set DS_STATUS  =''1'', '
                 +'       RCP_SALE   =:P2, '
                 +'       DT_CHANGE  = Now() '
                 +' where CD_STORE   =:P0 '
                 +'   and NO_COUPON  =:P1 ',
                 [Config.StoreCode,
                  Present.CouponNo,
                  WorkDate+Config.PosNo+Present.RcpNo]);

        //통합쿠폰은 온라인시만 사용
        if Common.PreSent.CouponKind = '1' then
          if not DM.ExecCloud('update MS_COUPON '
                             +'   set DS_STATUS  =''1'', '
                             +'       RCP_SALE   =:P3, '
                             +'       DT_CHANGE  = Now() '
                             +' where CD_HEAD    =:P0 '
                             +'   and CD_STORE   =:P1 '
                             +'   and NO_COUPON  =:P2;',
                             [Config.HeadStoreCode,
                              Config.StoreCode,
                              Present.CouponNo,
                              Config.StoreCode+WorkDate+Config.PosNo+Present.RcpNo],true,Common.RestDBURL) then
          begin
            raise Exception.Create('서버 접속 실패 !!!.'#13'쿠폰은 온라인시에만 사용이 가능합니다'#13'잠시 후 다시 실행해 주십시오.');
          end;
      end;

      {쿠폰발행}              //쿠폰사용 시 쿠폰을 발행하지 않습니다
      if (aGubun = 'S') and (GetOption(335)='1') and ((GetOption(64)='0') or (Present.CouponDc=0)) then
      begin
        if not (OrderKind in [okChange, okCancel, okBanpum]) then
        begin
          DM.OpenQuery('select * '
                      +'  from MS_EVENT '
                      +' where CD_STORE =:P0 '
                      +'   and YMD_FROM <= :P1 '
                      +'   and YMD_TO   >= :P1 '
                      +'   and YN_USE   = ''Y'' '
                      +'   and TIME_FROM <= :P2 '
                      +'   and TIME_TO   >= :P2 '
                      +'   and AMT_SALE_FROM <= (:P3 - case when YN_POINT in (''Y'',''A'') then :P4 else 0 end)  '
                      +'   and AMT_SALE_TO >= (:P3 - case when YN_POINT in (''Y'',''A'') then :P4 else 0 end) '
                      +'   and Substring(WEEKLY, DAYOFWEEK(Now()), 1) = ''1'' '
                      +' order by AMT_DC '
                      +' limit 1 ',
                      [Config.StoreCode,
                       NowDate,
                       Copy(NowTime,1,2) + ':' + Copy(NowTime,3,2),
                       Present.TotalAmt-Present.TotalDC,
                       Present.ExistPointAmt]);

          if not DM.Query.Eof and (((DM.Query.FieldByName('YN_MEMBER').AsString = 'N') or (Member.Code <> '')) and (Config.CouponPrefix <> '')) then
          begin
            DM.OpenCloud('select Max(NO_COUPON)'
                        +'  from MS_COUPON '
                        +' where CD_HEAD   =:P0 '
                        +'   and CD_STORE  =:P1 '
                        +'   and Length(NO_COUPON) =:P2 ',
                        [Config.HeadStoreCode,
                         Config.StoreCode,
                         Config.CouponLen],Common.RestDBURL);

            if Config.CouponLen = Length(DM.CloudData.Fields[0].AsString) then
              vCouponNo := LeftStr(DM.CloudData.Fields[0].AsString, Config.CouponLen-5) + FormatFloat('00000', StrToInt(RightStr(DM.CloudData.Fields[0].AsString,5))+1)
            else
            begin
              vTemp1 := '';
              for vIndex := 6 to Config.CouponLen-1 do
                vTemp1 := vTemp1 + '0';
              vCouponNo := Config.CouponPrefix + FormatDateTime('yyyy', now()) + FormatFloat(vTemp1, 1);
            end;
            DM.CloudData.Close;

            DM.ExecCloud('insert into MS_COUPON(CD_HEAD, '
                        +'                      CD_STORE, '
                        +'                      DS_COUPON, '
                        +'                      NO_COUPON, '
                        +'                      NM_COUPON, '
                        +'                      YMD_ISSUE, '
                        +'                      YMD_FROM, '
                        +'                      YMD_TO, '
                        +'                      COUPON_TYPE, '
                        +'                      AMT_DC, '
                        +'                      DS_STATUS, '
                        +'                      RCP_ISSUE, '
                        +'                      CD_SAWON_CHG, '
                        +'                      CD_MENU) '
                        +'               Values(:P0, '
                        +'                      :P1, '
                        +'                      ''0'', '
                        +'                      :P2, '
                        +'                      :P3, '
                        +'                      Date_Format(NOW(), ''%Y%m%d''), '
                        +'                      :P4, '
                        +'                      :P5, '
                        +'                      :P6, '
                        +'                      :P7, '
                        +'                      ''0'', '
                        +'                      :P8, '
                        +'                      :P9, '
                        +'                      ''''); ',
                        [Config.HeadStoreCode,
                         Config.StoreCode,
                         vCouponNo,
                         DM.Query.FieldByName('NM_EVENT').AsString,
                         DM.Query.FieldByName('YMD_USE_FROM').AsString,
                         DM.Query.FieldByName('YMD_USE_TO').AsString,
                         DM.Query.FieldByName('COUPON_TYPE').AsString,
                         DM.Query.FieldByName('AMT_DC').AsCurrency,
                         WorkDate+Config.PosNo+Present.RcpNo,
                         Config.UserCode],true,Common.RestDBURL);

            DM.OpenCloud('select CD_STORE, NO_COUPON,NM_COUPON,YMD_ISSUE,DS_COUPON,YMD_FROM,YMD_TO,AMT_DC,AMT_SALE_MIN, AMT_DC_MAX, DS_TARGET, YN_POINT, CD_MEMBER, CD_MENU, RCP_ISSUE,RCP_SALE,COUPON_TYPE,DS_STATUS '
                        +'  from MS_COUPON '
                        +' where CD_HEAD   =:P0 '
                        +'   and CD_STORE  =:P1 '
                        +'   and NO_COUPON =:P2 ',
                       [Common.Config.HeadStoreCode,
                        Common.Config.StoreCode,
                        vCouponNo],Common.RestDBURL);
            vSQL := Format('delete from MS_COUPON where CD_STORE =''%s'' and NO_COUPON =''%s'';',[Common.Config.StoreCode, vCouponNo]);
            vSQL := vSQL + DM.GetCloudData('MS_COUPON');
            DM.StoredProc.StoredProcName := 'MULTI_EXECUTE';
            DM.StoredProc.PrepareSQL;
            DM.StoredProc.ParamByName('_SQL').AsString := vSQL;
            DM.StoredProc.ExecProc;

            Present.CouponNo_Issue          := vCouponNo;
            Present.CouponName_Issue        := DM.Query.FieldByName('NM_EVENT').AsString;
            Present.CouponType_Issue        := DM.Query.FieldByName('COUPON_TYPE').AsString;
            Present.CouponAmt_Issue         := DM.Query.FieldByName('AMT_DC').AsInteger;
            Present.CouponFromDate_Issue    := DM.Query.FieldByName('YMD_USE_FROM').AsString;
            Present.CouponToDate_Issue      := DM.Query.FieldByName('YMD_USE_TO').AsString;
          end;
        end;
      end
      else if (aGubun = 'B') and (Present.CouponNo <> '' ) then
      begin
        ExecQuery('insert into SL_SALE_COUPON(CD_STORE, '
                 +'                           YMD_SALE, '
                 +'                           NO_POS, '
                 +'                           NO_RCP, '
                 +'                           SEQ, '
                 +'                           NO_COUPON, '
                 +'                           AMT_DC) '
                 +'                    Values(:P0, '
                 +'                           :P1, '
                 +'                           :P2, '
                 +'                           :P3, '
                 +'                           :P4, '
                 +'                           :P5, '
                 +'                           :P6) ',
                 [Config.StoreCode,
                  WorkDate,
                  Config.PosNo,
                  Present.RcpNo,
                  1,
                  Present.CouponNo,
                  Present.CouponDC]);
      end;

      if Common.Table.isCashOrder then
        ExecQuery('delete from SL_ORDER_D '
                 +' where CD_STORE = ''CASHTEMP'' '
                 +'   and NO_TABLE =:P0',
                 [Common.Table.Number]);


      {티켓(식권)발행}
      if Common.Config.IsKiosk and (aGubun = 'S') then //and (GetOption(341)='1') then
      begin
        vTicketIndex := 1;
        for vIndex := 0 to Summary_sGrd.RowCount-1 do
        begin
          if Summary_sGrd.Cells[GDM_YN_TICKET, vIndex] <> 'Y' then Continue;

          for vIndex1 := 1 to StoI(Summary_sGrd.Cells[GDM_QTY, vIndex]) do
          begin
            TicketPrintData.Add(GetTicketNo(WorkDate+Config.PosNo+Present.RcpNo+FormatFloat('000',vTicketIndex)) + #28 +
                                Summary_sGrd.Cells[GDM_NM_MENU, vIndex] + #28 +
                                Summary_sGrd.Cells[GDM_PR_SALE, vIndex] + #28);
            ExecQuery('insert into SL_SALE_TICKET(CD_STORE, '
                     +'                           YMD_SALE, '
                     +'                           NO_POS, '
                     +'                           NO_RCP, '
                     +'                           NO_TICKET, '
                     +'                           CD_MENU, '
                     +'                           DS_STATUS) '
                     +'                    values(:P0, '
                     +'                           :P1, '
                     +'                           :P2, '
                     +'                           :P3, '
                     +'                           :P4, '
                     +'                           :P5, '
                     +'                           :P6) ',
                     [Config.StoreCode,
                      WorkDate,
                      Config.PosNo,
                      Present.RcpNo,
                      GetTicketNo(WorkDate+Config.PosNo+Present.RcpNo+FormatFloat('000',vTicketIndex)),
                      Summary_sGrd.Cells[GDM_CD_MENU, vIndex],
                      '0']);
            Inc(vTicketIndex);
          end;

        end;
      end;

      if ((aGubun = 'B') or (aGubun = 'V')) then
      begin
        //취소하는 영수증으로 발행된 쿠폰이 있을때
        if OrgReceiptCoupon then
          ExecQuery('update MS_COUPON '
                   +'   set DS_STATUS = ''2'', '
                   +'       DT_CHANGE = Now() '
                   +' where CD_STORE  =:P0 '
                   +'   and RCP_ISSUE  =:P1 ',
                   [Config.StoreCode,
                    Ifthen(aGubun='V', WorkDate+Config.PosNo+Present.RcpNo, Copy(Common.BanReceipt, 1, 8)+Common.Config.PosNo+Copy(Common.BanReceipt, 9, 4))]);

        if Present.CouponDc <> 0 then
          ExecQuery('update MS_COUPON '
                   +'   set DS_STATUS = ''0'', '
                   +'       RCP_SALE  = '''', '
                   +'       DT_CHANGE = Now() '
                   +' where CD_STORE  =:P0 '
                   +'   and RCP_SALE  =:P1 ',
                   [Config.StoreCode,
                    Ifthen(aGubun='V', WorkDate+Config.PosNo+Present.RcpNo, Copy(Common.BanReceipt, 1, 8)+Common.Config.PosNo+Copy(Common.BanReceipt, 9, 4))]);

        visTicket := false;
        if GetOption(341) = '1' then
        begin
          if DM.OpenQuery('select DS_STATUS '
                         +'  from SL_SALE_TICKET '
                         +' where CD_STORE  =:P0 '
                         +'   and YMD_SALE  =:P1 '
                         +'   and NO_POS    =:P2 '
                         +'   and NO_RCP    =:P3 ',
                         [Config.StoreCode,
                          Ifthen(aGubun='V', WorkDate, Copy(Common.BanReceipt, 1, 8)),
                          Ifthen(aGubun='V', Config.PosNo, Common.Config.PosNo),
                          Ifthen(aGubun='V', Present.RcpNo, Copy(Common.BanReceipt, 9, 4))]) > 0 then
          begin
            ExecQuery('update SL_SALE_TICKET '
                     +'   set DS_STATUS = ''2'', '
                     +'       DT_CHANGE = Now() '
                     +' where CD_STORE  =:P0 '
                     +'   and YMD_SALE  =:P1 '
                     +'   and NO_POS    =:P2 '
                     +'   and NO_RCP    =:P3 ',
                     [Config.StoreCode,
                      Ifthen(aGubun='V', WorkDate, Copy(Common.BanReceipt, 1, 8)),
                      Ifthen(aGubun='V', Config.PosNo, Common.Config.PosNo),
                      Ifthen(aGubun='V', Present.RcpNo, Copy(Common.BanReceipt, 9, 4))]);
            visTicket := true;
          end;
        end;

        //서버에 반영
        if OrgReceiptCoupon then
           DM.ExecCloud('update MS_COUPON '
                      +'   set DS_STATUS = ''2'', '
                      +'       REMARK    = ''영수증반품으로 취소'', '
                      +'       DT_CHANGE = Now() '
                      +' where CD_HEAD   =:P0 '
                      +'   and CD_STORE  =:P1 '
                      +'   and RCP_ISSUE  =:P2; ',
                      [Config.HeadStoreCode,
                       Config.StoreCode,
                       Ifthen(aGubun='V', WorkDate+Config.PosNo+Present.RcpNo, Copy(Common.BanReceipt, 1, 8)+Common.Config.PosNo+Copy(Common.BanReceipt, 9, 4))],false,Common.RestDBURL);

        if Present.CouponDc <> 0 then
          DM.ExecCloud('update MS_COUPON '
                      +'   set DS_STATUS = ''0'', '
                      +'       RCP_SALE  = '''', '
                      +'       DT_CHANGE = Now() '
                      +' where CD_HEAD   =:P0 '
                      +'   and CD_STORE  =:P1 '
                      +'   and RCP_SALE  =:P2; ',
                      [Config.HeadStoreCode,
                       Config.StoreCode,
                       Ifthen(aGubun='V', WorkDate+Config.PosNo+Present.RcpNo, Copy(Common.BanReceipt, 1, 8)+Common.Config.PosNo+Copy(Common.BanReceipt, 9, 4))],false,Common.RestDBURL);

        if visTicket then
          DM.ExecCloud('update SL_SALE_TICKET '
                      +'   set DS_STATUS = ''2'', '
                      +'       DT_CHANGE = Now() '
                      +' where CD_HEAD   =:P0 '
                      +'   and CD_STORE  =:P1 '
                      +'   and YMD_SALE  =:P2 '
                      +'   and NO_POS    =:P3 '
                      +'   and NO_RCP    =:P4; ',
                      [Config.HeadStoreCode,
                       Config.StoreCode,
                       Ifthen(aGubun='V', WorkDate, Copy(Common.BanReceipt, 1, 8)),
                       Ifthen(aGubun='V', Config.PosNo, Common.Config.PosNo),
                       Ifthen(aGubun='V', Present.RcpNo, Copy(Common.BanReceipt, 9, 4))],false,Common.RestDBURL);

        if (TempSQL <> '') and not DM.ExecCloud(TempSQL,[],true,Common.RestDBURL) then
        begin
          if visTicket then
            raise Exception.Create('서버 접속 실패 !!!.'#13'티켓은 온라인시에만 취소가 가능합니다'#13'잠시 후 다시 실행해 주십시오.')
          else
            raise Exception.Create('서버 접속 실패 !!!.'#13'쿠폰은 온라인시에만 취소가 가능합니다'#13'잠시 후 다시 실행해 주십시오.');
        end;

        ExecQuery('delete '
                 +'  from SL_LETSORDER '
                 +' where CD_STORE   =:P0 '
                 +'   and NO_RECEIPT =:P1 ',
                 [Config.StoreCode,
                 Ifthen(aGubun='V', WorkDate + Config.PosNo + Present.RcpNo, Common.BanReceipt)]);

      end;

      //푸드코트일때 코너별 주문번호 저장
      if (GetOption(231) = '1') and (GetOption(233) = '1') then
      begin
        For liRow := 0 to High(Common.Corner) do
        begin
          if Corner[liRow].OrderData = '' then Continue;
          if (liRow > 0) and CheckFoodCourtOrderNo(liRow) then Continue;
          try
            ExecQuery('insert into SL_SALE_NO(CD_STORE,YMD_SALE,NO_POS,NO_RCP,CD_CORNER,NO_ORDER) '
                     +'                values(:P0, :P1, :P2, :P3, :P4, :P5)',
                     [Config.StoreCode,
                      WorkDate,
                      Config.PosNo,
                      Present.RcpNo,
                      Corner[liRow].Code,
                      Corner[liRow].OrderNo]);
          except
          end;
        end;
      end;

      if ((not Config.IsTakeOut) and (aGubun = 'S') and not (OrderKind in [okBanpum, okDutchPay, okChange])) or (Table.OrderType = 'D') then
      begin
        if (Table.OrderType <> 'D') then
        begin
          vWhere := ' where CD_STORE =:P0 '
                   +'   and DS_ORDER =:P1 '
                   +'   and NO_TABLE =:P2 ';

          //테이블복귀를 위해 9999매장에 저장해둔다
          OpenQuery('select Count(*) '
                   +'  from SL_ORDER_H '
                   +vWhere,
                  [Config.StoreCode,
                   Table.OrderType,
                   Table.Number]);
          if Query.Fields[0].AsInteger = 1 then
          begin

            ExecQuery('delete from SL_ORDER_D '+ vWhere,
                     ['9999',
                      Table.OrderType,
                      Table.Number]);
            ExecQuery('delete from SL_ORDER_C '+ vWhere,
                     ['9999',
                      Table.OrderType,
                      Table.Number]);
            ExecQuery('delete from SL_ORDER_PRT '+ vWhere,
                     ['9999',
                      Table.OrderType,
                      Table.Number]);
            ExecQuery('delete from SL_ORDER_H '+ vWhere,
                     ['9999',
                      Table.OrderType,
                      Table.Number]);

            ExecQuery('insert into SL_ORDER_D(CD_STORE, NO_TABLE, DS_ORDER, CD_MENU, SEQ, NO_STEP, NO_POS, DS_SALE, NM_MENU, CD_MENU1, DS_MENU_TYPE, DS_TAX, PR_SALE, '
                     +'                       QTY_ORDER, AMT_ORDER, PR_SALE_ORG, PR_TIP, PR_ITEM, CD_ITEM, QTY_NEPUM, CD_PRINTER, NO_SPC, DC_SPC, DC_MENU,   '
                     +'                       DT_INSERT, DT_CHANGE, MEMO, YN_DOUBLE) '
                     +'            select ''9999'', NO_TABLE, DS_ORDER, CD_MENU, SEQ, NO_STEP, NO_POS, DS_SALE, NM_MENU, CD_MENU1, DS_MENU_TYPE, DS_TAX, PR_SALE, '
                     +'                   QTY_ORDER, AMT_ORDER, PR_SALE_ORG, PR_TIP, PR_ITEM, CD_ITEM, QTY_NEPUM, CD_PRINTER, NO_SPC, DC_SPC, DC_MENU,  '
                     +'                   DT_INSERT, DT_CHANGE, MEMO, YN_DOUBLE '
                     +'              from SL_ORDER_D '
                     +'             where CD_STORE =:P0 '
                     +'               and DS_ORDER =:P1 '
                     +'               and NO_TABLE =:P2 ',
                     [Config.StoreCode,
                      Table.OrderType,
                      Table.Number]);

            ExecQuery('insert into SL_ORDER_C( CD_STORE, NO_TABLE, DS_ORDER, SEQ, CD_MENU, QTY_CANCEL, CANCEL_TXT, NO_POS, CD_SAWON, DT_ORDER, DT_CANCEL, AMT_CANCEL, DT_CHANGE) '
                     +'            select ''9999'', NO_TABLE, DS_ORDER, SEQ, CD_MENU, QTY_CANCEL, CANCEL_TXT, NO_POS, CD_SAWON, DT_ORDER, DT_CANCEL, AMT_CANCEL, DT_CHANGE '
                     +'              from SL_ORDER_C '
                     +'             where CD_STORE =:P0 '
                     +'               and DS_ORDER =:P1 '
                     +'               and NO_TABLE =:P2 ',
                     [Config.StoreCode,
                      Table.OrderType,
                      Table.Number]);

            ExecQuery('insert into SL_ORDER_PRT(CD_STORE, NO_TABLE, DS_ORDER, NO_ORDER, CD_PRINTER, SEQ, PRINT_DATA, NM_DAMDANG, NO_PERSON, ORDER_TIME, TEL_MOBILE, NO_POS, DT_CHANGE) '
                     +'            select ''9999'', NO_TABLE, DS_ORDER, NO_ORDER, CD_PRINTER, SEQ, PRINT_DATA, NM_DAMDANG, NO_PERSON, ORDER_TIME, TEL_MOBILE, NO_POS, DT_CHANGE '
                     +'              from SL_ORDER_PRT '
                     +'             where CD_STORE =:P0 '
                     +'               and DS_ORDER =:P1 '
                     +'               and NO_TABLE =:P2 ',
                     [Config.StoreCode,
                      Table.OrderType,
                      Table.Number]);

            ExecQuery('insert into SL_ORDER_H(CD_STORE, NO_TABLE, DS_ORDER, COME_TIME, CNT_PERSON, CD_CUSTOMER, CD_AGE, CD_MEMBER, NO_BOOKING, AMT_ORDER, CD_CODE, '
                     +'                       AMT_DC, AMT_CODEDC, RT_DC, DC_MENU, CD_DAMDANG, LAST_POS, TABLE_STATE, NO_RFID, YN_SALE, TABLE_COLOR, DS_CUST, DT_LASTORDER) '
                     +'            select ''9999'', NO_TABLE, DS_ORDER, COME_TIME, CNT_PERSON, CD_CUSTOMER, CD_AGE, CD_MEMBER, NO_BOOKING, AMT_ORDER, CD_CODE, '
                     +'                       AMT_DC, AMT_CODEDC, RT_DC, DC_MENU, CD_DAMDANG, LAST_POS, ''N'', NO_RFID, YN_SALE, TABLE_COLOR, DS_CUST, DT_LASTORDER '
                     +'              from SL_ORDER_H '
                     +'             where CD_STORE =:P0 '
                     +'               and DS_ORDER =:P1 '
                     +'               and NO_TABLE =:P2 ',
                     [Config.StoreCode,
                      Table.OrderType,
                      Table.Number]);
          end;
        end;

        if Table.GroupType = 'M' then
        begin
          OpenQuery('select a.NO_TABLE  '
                   +' from SL_ORDER_H a inner join '
                   +'      MS_TABLE b on a.CD_STORE = b.CD_STORE '
                   +'                and a.NO_TABLE = b.NO_TABLE '
                   +'where a.CD_STORE    =:P0 '
                   +'  and a.DS_ORDER    =:P1 '
                   +'  and b.NO_TABLE_GROUP=:P2 ',
                   [Config.StoreCode,
                    Table.OrderType,
                    Table.Number]);
          vGroupTable := '';
          while not Query.Eof do
          begin
            vGroupTable := vGroupTable + Format('%d,',[Query.Fields[0].AsInteger]);
            Query.Next;
          end;
          if vGroupTable <> '' then
            vGroupTable := Format('and (NO_TABLE in (%s) or NO_TABLE =:P2) ',[LeftStr(vGroupTable, Length(vGroupTable)-1)])
          else
            vGroupTable := 'and NO_TABLE = :P2 ';


          vWhere :=  'where CD_STORE =:P0 '
                    +'  and DS_ORDER =:P1 '
                    +vGroupTable;
        end
        else
          vWhere := ' where CD_STORE = :P0 '
                   +'   and DS_ORDER = :P1 '
                   +'   and NO_TABLE = :P2 ';


        ExecQuery('delete from SL_ORDER_C '+ vWhere,
                 [Config.StoreCode,
                  Table.OrderType,
                  Table.Number]);
        ExecQuery('delete from SL_ORDER_PRT '+ vWhere,
                 [Config.StoreCode,
                  Table.OrderType,
                  Table.Number]);
        ExecQuery('delete from SL_ORDER_H '+ vWhere,
                 [Config.StoreCode,
                  Table.OrderType,
                  Table.Number]);
        ExecQuery('delete from SL_ORDER_D '+ vWhere,
                 [Config.StoreCode,
                  Table.OrderType,
                  Table.Number]);

        //그룹테이블 정산이면 그룹을 해제한다
        if (not Common.Config.IsTakeOut) and ((Table.GroupType = 'M') and (Table.BookingImg = '☎') and (Common.Table.BookingNo <> EmptyStr)) or
           ((Table.GroupType = 'M') and (Table.BookingImg = '') and (Common.Table.BookingNo = EmptyStr)) or
           ((Table.GroupType <> 'M') and (Common.Table.BookingNo <> EmptyStr)) and (Common.OrderKind <> okBanpum) and (Common.OrderKind <> okChange) then
        begin
          OpenQuery('select NO_TABLE_GROUP '
                   +'	 from MS_TABLE '
                   +'	where CD_STORE	=:P0 '
                   +'	  and NO_TABLE	=:P1 ',
                   [Common.Config.StoreCode,
                    Table.Number]);
          vGroupTableNo := DM.Query.Fields[0].AsInteger;
          DM.Query.Close;
          ExecQuery('update MS_TABLE '
                   +'   set NO_TABLE_GROUP = 0 '
                   +' where CD_STORE   	    =:P0 '
                   +Ifthen(vGroupTableNo = Table.Number, ' and NO_TABLE_GROUP	=:P1 ', ' and NO_TABLE =:P1 '),
                   [Common.Config.StoreCode,
                    Table.Number]);

          ExecQuery('insert into SL_ORDER_LOG(CD_STORE, '
                   +'                         NO_POS, '
                   +'                         DT_CHANGE) '
                   +' select CD_STORE, '
                   +'        NM_CODE1, '
                   +'        Now() '
                   +'   from MS_CODE '
                   +'  where CD_STORE  =:P0 '
                   +'    and CD_KIND   = ''01''  '
                   +'    and NM_CODE1 not in (select NO_POS '
                   +'                           from SL_ORDER_LOG '
                   +'                          where CD_STORE =:P0) ',
                   [Common.Config.StoreCode]);
        end;
      end; //if aGubun = 'S' then
    end; //with DM, PreSent do
    //지우면 안됨(없으면 정산시 깜박임)
    Application.ProcessMessages;
    //선결제일때는 밖에서 트랜잭션처리

    CommitTran;
    GetCardLog;

    //포인트 적립/사용 시 문자를 발송합니다(키오스크일때 영수증을 알림톡을 발송할 때는 포인트적립 내역을 발송하지 않는다)
    if (GetOption(470) = '0') or not Common.Config.IsKiosk or (Common.PreSent.CallTelNo <> '') then
    begin
      if (GetOption(179) = '1') and ((PreSent.UsePnt <> 0) or (Present.OccurPnt <> 0)) then
      begin
        if Length(GetOnlyNumber(Common.Member.MobileTelFull)) >= 10 then
        begin
          KakaoSendMessage('PN',[FormatFloat('#,0', PreSent.OccurPnt),
                                 FormatFloat('#,0', PreSent.UsePnt),
                                 FormatFloat('#,0', Member.Point )],
                                 Common.Member.MobileTelFull);
        end;
      end;

      //스템프 적립/사용 시 문자를 발송합니다
      if (GetOption(179) = '1') and ((PreSent.UseStamp <> 0) or (Present.SaveStamp <> 0)) then
      begin
        if Length(GetOnlyNumber(Common.Member.MobileTelFull)) >= 10 then
        begin
          KakaoSendMessage('PN',[FormatFloat('#,0', PreSent.SaveStamp),
                                 FormatFloat('#,0', PreSent.UseStamp),
                                 FormatFloat('#,0', Member.Stamp+PreSent.SaveStamp-PreSent.UseStamp )],
                                 Common.Member.MobileTelFull);
        end;
      end;
    end;

    //결제취소, 결제변경 시 문자발송
    if (GetOption(261) = '1') and ((aGubun = 'V') or (OrderKind = okChange)) then
    begin
      vTemp2 := '';
      if Present.CashAmt <> 0 then
        vTemp2 := ' 현금 '+ FormatFloat('#,0', Present.CashAmt - Ifthen(Present.GiveAmt > 0, Present.GiveAmt,0));

      if Present.CardAmt <> 0 then
        vTemp2 := vTemp2 + ' 카드 '+ FormatFloat('#,0', Present.CardAmt);

      if Present.LetsOrderAmt <> 0 then
        vTemp2 := vTemp2 + ' 렛츠오더 '+ FormatFloat('#,0', Present.LetsOrderAmt);

      if Present.TrustAmt <> 0 then
        vTemp2 := vTemp2 + ' 외상 '+ FormatFloat('#,0', Present.TrustAmt);

      if Present.GiftAmt <> 0 then
        vTemp2 := vTemp2 + ' 상품권 '+ FormatFloat('#,0', Present.GiftAmt);

      if Present.BankAmt <> 0 then
        vTemp2 := vTemp2 + '계좌입금'+ FormatFloat('#,0', Present.BankAmt);

      if (aGubun = 'V') then
      begin
        for liRow := 0 to Common.Config.StoreMobile.Count -1 do
          if Length(Config.StoreMobile[liRow]) >= 9 then
            KakaoSendMessage('P',[Format('[결제취소]%s[%s-%s-%s]'#13'[취소시간 %s]',[vTemp2,WorkDate,Config.PosNo,Present.RcpNo, FormatDateTime('yyyy-mm-dd hh:nn:ss',Now)])],
                             Config.StoreMobile[liRow]);
      end
      else if (aGubun = 'B') then
      begin
        for liRow := 0 to Common.Config.StoreMobile.Count -1 do
          if Length(Config.StoreMobile[liRow]) >= 9 then
            KakaoSendMessage('P',[Format('[반품]%s[%s-%s-%s]'#13'[반품시간 %s]',[vTemp2,WorkDate,Config.PosNo,Present.RcpNo, FormatDateTime('yyyy-mm-dd hh:nn:ss',Now)])],
                             Config.StoreMobile[liRow]);
      end
      else if (OrderKind = okChange) then
      begin
        vTemp1 := '';
        if Present_Temp.CashAmt <> 0 then
          vTemp1 := ' 현금 '+ FormatFloat('#,0', Present_Temp.CashAmt);

        if Present_Temp.CardAmt <> 0 then
          vTemp1 := vTemp1 + ' 카드 '+ FormatFloat('#,0', Present_Temp.CardAmt);

        if Present_Temp.LetsOrderAmt <> 0 then
          vTemp1 := vTemp1 + ' 렛츠오더 '+ FormatFloat('#,0', Present_Temp.LetsOrderAmt);

        if Present_Temp.TrustAmt <> 0 then
          vTemp1 := vTemp1 + ' 외상 '+ FormatFloat('#,0', Present_Temp.TrustAmt);

        if Present_Temp.GiftAmt <> 0 then
          vTemp1 := vTemp1 + ' 상품권 '+ FormatFloat('#,0', Present_Temp.GiftAmt);

        if Present_Temp.BankAmt <> 0 then
          vTemp1 := vTemp1 + '계좌입금'+ FormatFloat('#,0', Present_Temp.BankAmt);

        For liRow := 0 to Common.Config.StoreMobile.Count -1 do
          if Length(Config.StoreMobile[liRow]) >= 9 then
            KakaoSendMessage('P',['[결제변경]'+WorkDate+'-'+Config.PosNo+'-'+Present.RcpNo +
                             #13'(변경전) ['+FormatFloat('#,0', Present_Temp.TotalAmt)+'] '+vTemp1+
                             #13'(변경후) ['+FormatFloat('#,0', Present.TotalAmt)+'] '+vTemp2],
                              Config.StoreMobile[liRow]);
      end;
    end;

    Common.TRSendMessage;
  except
    on E: Exception do
    begin
      ErrMsg := E.Message;
      Common.ClearKitchenData;
      RollbackTran;
      DM.UniConnection.Disconnect;
      DM.UniConnection.Connect;
      Result := False;
      HideWaitForm;
      WriteLog('Common004',E.Message);
      ErrBox(E.Message+#13#13+'저장을 완료하지 못했습니다');

      //중복키 에러일때는 에러 데이터를 9999 매장으로 옮겨놓는다
      If Pos('PRIMARY KEY', E.Message) > 0 then
      begin
        vTemp2 := CopyPos(E.Message, '''',3 );
        ExecQueryEx('update '+vTemp2
                   +'   set CD_STORE = ''9999'' '
                   +' where CD_STORE =:P0 '
                   +'   and YMD_SALE =:P1 '
                   +'   and NO_POS   =:P2 '
                   +'   and NO_RCP   =:P3;',
                   [Config.StoreCode,
                    WorkDate,
                    Config.PosNo,
                    Present.RcpNo]);

        ExecQueryEx('update SL_SALE_S '
                   +'   set CD_STORE = ''9999'' '
                   +' where CD_STORE =:P0 '
                   +'   and YMD_SALE =:P1 '
                   +'   and NO_POS   =:P2 '
                   +'   and NO_RCP   =:P3;',
                   [Config.StoreCode,
                    WorkDate,
                    Config.PosNo,
                    Present.RcpNo]);

        ExecQueryEx('update SL_SALE_C '
                   +'   set CD_STORE = ''9999'' '
                   +' where CD_STORE =:P0 '
                   +'   and YMD_SALE =:P1 '
                   +'   and NO_POS   =:P2 '
                   +'   and NO_RCP   =:P3;',
                   [Config.StoreCode,
                    WorkDate,
                    Config.PosNo,
                    Present.RcpNo]);

        ExecQueryEx('update SL_CARD '
                   +'   set CD_STORE = ''9999'' '
                   +' where CD_STORE =:P0 '
                   +'   and YMD_SALE =:P1 '
                   +'   and NO_POS   =:P2 '
                   +'   and NO_RCP   =:P3;',
                   [Config.StoreCode,
                    WorkDate,
                    Config.PosNo,
                    Present.RcpNo]);

        ExecQueryEx('update SL_CASH '
                   +'   set CD_STORE = ''9999'' '
                   +' where CD_STORE =:P0 '
                   +'   and YMD_SALE =:P1 '
                   +'   and NO_POS   =:P2 '
                   +'   and NO_RCP   =:P3;',
                   [Config.StoreCode,
                    WorkDate,
                    Config.PosNo,
                    Present.RcpNo]);

        ExecQueryEx('update SL_SALE_PRT '
                   +'   set CD_STORE = ''9999'' '
                   +' where CD_STORE =:P0 '
                   +'   and YMD_SALE =:P1 '
                   +'   and NO_POS   =:P2 '
                   +'   and NO_RCP   =:P3;',
                   [Config.StoreCode,
                    WorkDate,
                    Config.PosNo,
                    Present.RcpNo],true);
      end;
      Exit;
    end;
  end;

  Application.ProcessMessages;

  //영수증출력
  try
    //키오스크일때는 기본 영수증을 출력하지 않는다
    if Config.IsKiosk then
    begin
      if Common.PreSent.TotalAmt <> 0 then
      begin
        if ((GetOption(311) = '1') and (Common.PreSent.CallTelNo = '')) or ((GetOption(337) = '1') and Common.AskBox('영수증을 받으시겠습니까?',10)) then
          Device.Receipt_Print('P')
        else if GetOption(337) = '0' then
          Device.Receipt_Print('P');
      end;
    end
    else
      Device.Receipt_Print('P');


    if (aGubun = 'S') and (Common.PreSent.CouponAmt_Issue > 0) then
      Device.CouponPrint;

    //티켓(식권)
    if (aGubun = 'S') and (Common.PreSent.TicketPrintData.Count > 0) then
    begin
      PlaySound(nil, 0, SND_MEMORY or SND_ASYNC);
      if FileExists(Common.AppPath+'\Kiosk\Ticket.wav') then
        sndPlaySound(PChar(Common.AppPath+'\Kiosk\Ticket.wav'), SND_NODEFAULT or SND_ASYNC)
      else
        PlaySound(PChar('TicketWave'), Common.DllHandle, SND_RESOURCE or SND_ASYNC);
      Device.TicketPrint;
    end;

    if GetOption(326) = '1' then
    begin
      Device.ItemLabelPrint;
      LabelPrintData.Free;
    end;
  except
  end;
  //지우면 안됨
  HideWaitForm;
end;

function TCommon.CardDataSave(aWorkDate,aGubun,aRcpNo:String; aIndex :Integer):Boolean;
var vSeq      : Integer;
    vBmp      : TBitmap;
    vStream   : TMemoryStream;
    vIndex    : Integer;
    vCorner   : String;
begin
  if aWorkDate = '' then
    aWorkDate := WorkDate;

  OpenQuery('select Ifnull(Max(SEQ), 0) + 1 '
           +'  from '+Ifthen(aGubun='C', 'SL_CARD ','SL_ACCT_CARD ')
           +' where CD_STORE	=:P0 '
           +'	  and YMD_SALE	=:P1 '
           +'	  and NO_POS	  =:P2 '
           +Ifthen(aGubun='C', 'and NO_RCP  =:P3 ','and NO_ACCT  =:P3'),
          [Config.StoreCode,
           aWorkDate,
           Config.PosNo,
           aRcpNo]);

  vSeq := Query.Fields[0].AsInteger;
  Query.Close;

  try
    Query.Close;
    Query.SQL.Text := 'insert into '+Ifthen(aGubun='C', 'SL_CARD ','SL_ACCT_CARD ')+'(CD_STORE, '
                    +'             				YMD_SALE, '
                    +'             				NO_POS, '
                    +Ifthen(aGubun='C','NO_RCP, ','NO_ACCT,')
                    +'             				SEQ, '
                    +'                    DS_CARD, '
                    +'             				DS_TRD, '
                    +'             				NO_CARD, '
                    +'             				NO_APPROVAL_ORG, '
                    +'             				NO_CHAINPL, '
                    +'             				NO_APPROVAL, '
                    +'             				AMT_APPROVAL, '
                    +'             				AMT_TIP, '
                    +'             				AMT_VAT, '
                    +'             				TERM_HALBU, '
                    +'             				TERM_VALID, '
                    +'             				TYPE_TRD, '
                    +'             				TRD_TIME, '
                    +'             				TRD_DATE, '
                    +'             				TRD_DATE_ORG, '
                    +'             				NM_CARDPL, '
                    +'             				CD_CARD_BUY, '
                    +'             				NM_CARD_BUY, '
                    +'             				REALMODE, '
                    +'             				IMGFILE, '
                    +'                  	CD_CORNER,'
                    +'	                  AMT_DC, '
                    +Ifthen(aGubun='C','DS_DC, ','')
                    +'                    NOTE_MSG, '
                    +'             				SIGN_IMAGE, '
                    +'                    YN_UNIONPAY, '
                    +'                    YN_CAT, '
                    +'                    VAN_TID, '
                    +'                    AMT_BALANCE, '
                    +Ifthen(aGubun='C','NO_UNIQUE_ORG, ','')
                    +'                    PAY_CODE, '
                    +'                    NO_EASYPAY '
                    +Ifthen(aGubun='C',',PG_TID,AMT_CANCEL) ',')')
                    +'            VALUES( :P0, '
                    +'             				:P1, '
                    +'             				:P2, '
                    +'             				:P3, '
                    +'             				:P4, '
                    +'                  	:P5, '
                    +'             				:P6, '
                    +'                    :P7, '
                    +'             				:P8, '
                    +'             				:P9, '
                    +'             				:P10, '
                    +'             				:P11, '
                    +'             				:P12, '
                    +'             				:P13, '
                    +'             				:P14, '
                    +'             				:P15, '
                    +'             				:P16, '
                    +'             				:P17, '
                    +'             				:P18, '
                    +'             				:P19, '
                    +'             				:P20, '
                    +'             				:P21, '
                    +'             				:P22, '
                    +'             				:P23, '
                    +'             				:P24, '
                    +'             				:P25, '
                    +'             				:P26, '
                   +Ifthen(aGubun='C',':P27, ','')
                    +'             				:P28, '
                    +'             				:P29, '
                    +'                    :P30, '
                    +'                    :P31, '
                    +'                    :P32, '
                    +'                    :P33, '
                    +Ifthen(aGubun='C',':P34, ','')
                    +'                    :P35, '
                    +'                    :P36 '
                    +Ifthen(aGubun='C',',:P37,:P38) ',')');

    with Card_SGrd do
    begin
      Query.ParamByName('P0').AsString   := Config.StoreCode;
      Query.ParamByName('P1').AsString   := aWorkDate;
      Query.ParamByName('P2').AsString   := Config.PosNo;
      Query.ParamByName('P3').AsString   := aRcpNo;
      Query.ParamByName('P4').AsInteger  := vSeq;
      Query.ParamByName('P5').AsString   := Cells[GDC_DS_CARD,          aIndex];
      Query.ParamByName('P6').AsString   := Cells[GDC_DS_TRD,           aIndex];
      Query.ParamByName('P7').AsString   := Copy(GetCardNoFormat(Cells[GDC_CARDNO, aIndex],true),1,30);
      Query.ParamByName('P8').AsString   := Trim(Cells[GDC_APPROVAL_ORG,aIndex]);
      Query.ParamByName('P9').AsString   := Copy(Cells[GDC_CHAINPL,          aIndex],1,15);
      Query.ParamByName('P10').AsString  := Copy(Trim(Cells[GDC_NO_APPROVAL, aIndex]),1,15);
      Query.ParamByName('P11').AsInteger := StoI(Trim(Cells[GDC_AMT,    aIndex]));
      Query.ParamByName('P12').AsInteger := StoI(Trim(Cells[GDC_TIPAMT, aIndex]));
      Query.ParamByName('P13').AsInteger := StoI(Trim(Cells[GDC_VATAMT, aIndex]));
      Query.ParamByName('P14').AsString  := GetOnlyNumber(Cells[GDC_HALBU, aIndex]);
      Query.ParamByName('P15').AsString  := EmptyStr; //유효기간은 저장하지 않는다Cells[GDC_VALID,  aIndex];
      Query.ParamByName('P16').AsString  := Cells[GDC_TYPE_TRD,         aIndex];
      Query.ParamByName('P17').AsString  := Copy(GetOnlyNumber(Cells[GDC_TRD_TIME, aIndex]),1,4);
      Query.ParamByName('P18').AsString  := Copy(Cells[GDC_TRD_DATE,         aIndex],1,8);
      Query.ParamByName('P19').AsString  := Cells[GDC_TRD_DATE_ORG,     aIndex];
      Query.ParamByName('P20').AsString  := Copy(Cells[GDC_NAME,             aIndex],1,50);
      Query.ParamByName('P21').AsString  := Copy(Cells[GDC_CD_BUY,           aIndex],1,4);
      Query.ParamByName('P22').AsString  := Copy(Cells[GDC_NM_BUY,           aIndex],1,50);
      Query.ParamByName('P23').AsString  := Cells[GDC_REALMODE,         aIndex];
      Query.ParamByName('P24').AsString  := Cells[GDC_IMGFILE,          aIndex];
      vIndex := GetCornerIndex('',Cells[GDC_VAN_TID,       aIndex]);
      if vIndex >= 0 then
        Cells[GDC_CORNER,           aIndex] := Corner[vIndex].Code;
      Query.ParamByName('P25').AsString  := Cells[GDC_CORNER,           aIndex];
      Query.ParamByName('P26').AsInteger := StoI(Trim(Cells[GDC_DCAMT,  aIndex]));
      if aGubun='C' then
        Query.ParamByName('P27').AsString  := Cells[GDC_DS_DC,            aIndex];
      Query.ParamByName('P28').AsString  := Copy(Cells[GDC_NOTE, aIndex],1,100);

      vBmp     := TBitmap.Create;
      vStream  := TMemoryStream.Create;
      try
        if (Cells[GDC_SIGNFILE,  aIndex] <> '') and (FileExists(Cells[GDC_SIGNFILE,  aIndex]))  then
        begin
          vBmp.LoadFromFile(Cells[GDC_SIGNFILE,  aIndex]);
          vBmp.SaveToStream ( vStream );
          Query.ParamByName('P29').LoadFromStream(vStream, ftBlob);
        end
        else
        begin
          vBmp.SaveToStream ( vStream );
          Query.ParamByName('P29').LoadFromStream(vStream, ftBlob);
        end;
      finally
        vBmp.Free;
        vStream.Free;
      end;
      Query.ParamByName('P30').AsString  := Cells[GDC_YN_UNIONPAY,   aIndex];
      Query.ParamByName('P31').AsString  := Cells[GDC_YN_CAT,        aIndex];
      Query.ParamByName('P32').AsString  := Cells[GDC_VAN_TID,       aIndex];
      Query.ParamByName('P33').AsString  := GetOnlyNumber(Cells[GDC_BALANCEAMT, aIndex]);
      if aGubun='C' then
        Query.ParamByName('P34').AsString  := Cells[GDC_TRANSNO,       aIndex];
      Query.ParamByName('P35').AsString  := Cells[GDC_PAYCODE,       aIndex];
      Query.ParamByName('P36').AsString  := Cells[GDC_NO_EASYPAY,    aIndex];
      if aGubun='C' then
      begin
        Query.ParamByName('P37').AsString  := Cells[GDC_PG_TID, aIndex];
        Query.ParamByName('P38').AsInteger := StoI(Trim(Cells[GDC_AMT_CANCEL,  aIndex]));
      end;

      //인터넷승인이면서 카드번호가 없을때
      if (Cells[GDC_DS_CARD,  aIndex] = 'C') and (Cells[GDC_TYPE_TRD,  aIndex] = atSwipe) and (Trim(Cells[GDC_CARDNO, aIndex]) = '') and (Trim(Cells[GDC_NO_APPROVAL, aIndex]) = '') then
      begin
         HideWaitForm;
         WriteLog('CardDataSave',Format('카드번호 - %s, 승인번호 - %s',[Trim(Cells[GDC_CARDNO, aIndex]), Cells[GDC_NO_APPROVAL, aIndex]]));
         ErrBox('신용카드 승인내역이 올바르지 않습니다'+#13+'반드시 관리자에 문의바랍니다');
         Result := False;
         Exit;
      end;
    end;
    Query.Execute;

    Result := True;
  except
    on E: Exception do
    begin
      WriteLog('CardDataSave',E.Message);
      Result := false;
    end;
  end;
end;

function  TCommon.AHeadCardDataSave:Boolean;
var vIndex : Integer;
begin
  try
    for vIndex := 0 to Card_SGrd.RowCount -1 do
    begin
      Query.Close;
      Query.SQL.Text := 'insert into SL_CARD_AHEAD(CD_STORE, '
                       +'             				     NO_TABLE, '
                       +'             	  		     SEQ, '
                       +'                          DS_CARD, '
                       +'             				     DS_TRD, '
                       +'             				     NO_CARD, '
                       +'             				     NO_CHAINPL, '
                       +'             				     NO_APPROVAL, '
                       +'             				     AMT_APPROVAL, '
                       +'             				     AMT_TIP, '
                       +'             				     AMT_VAT, '
                       +'             				     TERM_HALBU, '
                       +'             				     TYPE_TRD, '
                       +'             				     TRD_TIME, '
                       +'             				     TRD_DATE, '
                       +'             				     NM_CARDPL, '
                       +'             				     CD_CARD_BUY, '
                       +'             				     NM_CARD_BUY, '
                       +'             				     IMGFILE, '
                       +'                          NOTE_MSG, '
                       +'                          YN_UNIONPAY, '
                       +'                          YN_CAT, '
                       +'                          VAN_TID, '
                       +'                          AMT_BALANCE, '
                       +'                          PAY_CODE, '
                       +'                          NO_EASYPAY) '
                       +'                 VALUES( :P0, '
                       +'             				    :P1, '
                       +'                        (select Ifnull(Max(SEQ), 0) + 1 '
                       +'                           from SL_CARD_AHEAD as s '
                       +'                          where CD_STORE	=:P0 '
                       +'	                           and NO_TABLE	=:P1), '
                       +'             			     	:P2, '
                       +'             				    :P3, '
                       +'             				    :P4, '
                       +'                  	      :P5, '
                       +'             				    :P6, '
                       +'                         :P7, '
                       +'             				    :P8, '
                       +'             				    :P9, '
                       +'             				    :P10, '
                       +'             				    :P11, '
                       +'             				    :P12, '
                       +'             				    :P13, '
                       +'             				    :P14, '
                       +'             				    :P15, '
                       +'             				    :P16, '
                       +'             				    :P17, '
                       +'             				    :P18, '
                       +'             				    :P19, '
                       +'             				    :P20, '
                       +'             				    :P21, '
                       +'             				    :P22, '
                       +'             				    :P23, '
                       +'                         :P24) ';

      with Card_SGrd do
      begin
        if Cells[GDC_YN_AHEAD, vIndex] = 'Y' then Continue;
        Query.ParamByName('P0').AsString  := Config.StoreCode;
        Query.ParamByName('P1').AsInteger  := Table.Number;
        Query.ParamByName('P2').AsString   := Cells[GDC_DS_CARD,          vIndex];
        Query.ParamByName('P3').AsString   := Cells[GDC_DS_TRD,           vIndex];
        Query.ParamByName('P4').AsString   := Copy(GetCardNoFormat(Cells[GDC_CARDNO, vIndex],true),1,30);
        Query.ParamByName('P5').AsString   := Copy(Cells[GDC_CHAINPL,          vIndex],1,15);
        Query.ParamByName('P6').AsString  := Copy(Trim(Cells[GDC_NO_APPROVAL, vIndex]),1,15);
        Query.ParamByName('P7').AsInteger := StoI(Trim(Cells[GDC_AMT,    vIndex]));
        Query.ParamByName('P8').AsInteger := StoI(Trim(Cells[GDC_TIPAMT, vIndex]));
        Query.ParamByName('P9').AsInteger := StoI(Trim(Cells[GDC_VATAMT, vIndex]));
        Query.ParamByName('P10').AsString  := GetOnlyNumber(Cells[GDC_HALBU, vIndex]);
        Query.ParamByName('P11').AsString  := Cells[GDC_TYPE_TRD,         vIndex];
        Query.ParamByName('P12').AsString  := Copy(GetOnlyNumber(Cells[GDC_TRD_TIME, vIndex]),1,4);
        Query.ParamByName('P13').AsString  := Copy(Cells[GDC_TRD_DATE,   vIndex],1,8);
        Query.ParamByName('P14').AsString  := Copy(Cells[GDC_NAME,       vIndex],1,50);
        Query.ParamByName('P15').AsString  := Copy(Cells[GDC_CD_BUY,     vIndex],1,4);
        Query.ParamByName('P16').AsString  := Copy(Cells[GDC_NM_BUY,     vIndex],1,50);
        Query.ParamByName('P17').AsString  := Cells[GDC_IMGFILE,         vIndex];
        Query.ParamByName('P18').AsString  := Copy(Cells[GDC_NOTE, vIndex],1,100);
        Query.ParamByName('P19').AsString := Cells[GDC_YN_UNIONPAY,   vIndex];
        Query.ParamByName('P20').AsString := Cells[GDC_YN_CAT,        vIndex];
        Query.ParamByName('P21').AsString := Cells[GDC_VAN_TID,       vIndex];
        Query.ParamByName('P22').AsString := GetOnlyNumber(Cells[GDC_BALANCEAMT, vIndex]);
        Query.ParamByName('P23').AsString := Cells[GDC_PAYCODE,       vIndex];
        Query.ParamByName('P24').AsString := Cells[GDC_NO_EASYPAY,       vIndex];
      end;
      Query.Execute;
    end;
    Result := True;
    GetCardLog;
  except
    on E: Exception do
    begin
      WriteLog('AHeadCardDataSave',E.Message);
      Result := false;
    end;
  end;
end;

function  TCommon.AHeadCashDataSave:Boolean;
var vIndex : Integer;
begin
  try
    for vIndex := 0 to Cash_SGrd.RowCount -1 do
    begin
      Query.Close;
      Query.SQL.Text := 'insert into SL_CASH_AHEAD(CD_STORE, '
                       +'		                       NO_TABLE, '
                       +'		                       SEQ, '
                       +'		                       DS_TRD, '
                       +'		                       DS_KIND, '
                       +'		                       DS_TYPE, '
                       +'		                       DS_INPUT, '
                       +'		                       NO_CARD, '
                       +'		                       NO_APPROVAL, '
                       +'		                       AMT_APPROVAL, '
                       +'		                       AMT_VAT, '
                       +'		                       TRD_DATE, '
                       +'		                       TRD_DATE_ORG, '
                       +'		                       NO_APPROVAL_ORG, '
                       +'		                       CD_CORNER, '
                       +'                          NO_CARD_FULL, '
                       +'                          YN_CAT, '
                       +'                          VAN_TID) '
                       +'                 VALUES( :P0, '
                       +'             				    :P1, '
                       +'                        (select Ifnull(Max(SEQ), 0) + 1 '
                       +'                           from SL_CASH_AHEAD as s '
                       +'                          where CD_STORE	=:P0 '
                       +'	                           and NO_TABLE	=:P1), '
                       +'             			     	:P2, '
                       +'             				    :P3, '
                       +'             				    :P4, '
                       +'                  	      :P5, '
                       +'             				    :P6, '
                       +'                         :P7, '
                       +'             				    :P8, '
                       +'             				    :P9, '
                       +'             				    :P10, '
                       +'             				    :P11, '
                       +'             				    :P12, '
                       +'             				    :P13, '
                       +'             				    :P14, '
                       +'             				    :P15, '
                       +'             				    :P16) ';

      with Cash_SGrd do
      begin
        if Cells[GDR_YN_AHEAD, vIndex] = 'Y' then Continue;
        Query.ParamByName('P0').AsString   := Config.StoreCode;
        Query.ParamByName('P1').AsInteger  := Table.Number;
        Query.ParamByName('P2').AsString   := Trim(Cells[GDR_DS_TRD,           vIndex]);
        Query.ParamByName('P3').AsString   := Trim(Cells[GDR_DS_KIND,          vIndex]);
        Query.ParamByName('P4').AsString   := Trim(Cells[GDR_DS_TYPE,          vIndex]);
        Query.ParamByName('P5').AsString   := Trim(Cells[GDR_DS_INPUT,         vIndex]);
        Query.ParamByName('P6').AsString   := LeftStr(GetCardNoFormat(Cells[GDR_CARDNO, vIndex],true),20);
        Query.ParamByName('P7').AsString  := Trim(Cells[GDR_NO_APPROVAL, vIndex]);
        Query.ParamByName('P8').AsInteger  := StoI(Trim(Cells[GDR_AMT,    vIndex]));
        Query.ParamByName('P9').AsInteger  := StoI(Trim(Cells[GDR_VAT,    vIndex]));
        Query.ParamByName('P10').AsString  := Trim(Cells[GDR_TRD_DATE,         vIndex]);
        Query.ParamByName('P11').AsString  := Trim(Cells[GDR_TRD_DATE_ORG,     vIndex]);
        Query.ParamByName('P12').AsString  := Trim(Cells[GDR_APPROVAL_ORG,     vIndex]);
        Query.ParamByName('P13').AsString  := Trim(Cells[GDR_CORNER,           vIndex]);
        Query.ParamByName('P14').AsString  := Trim(Cells[GDR_FULLCARDNO,       vIndex]);
        Query.ParamByName('P15').AsString  := Trim(Cells[GDR_YN_CAT,           vIndex]);
        Query.ParamByName('P16').AsString  := Trim(Cells[GDR_VAN_TID,          vIndex]);
      end;
      Query.Execute;

      //렛츠오더에 결제내역 전송
      if GetHeadOption(9) = '1' then
      begin
        ExecQuery('insert into TR_ORDER(CD_STORE, '
                 +'                     GROUP_SEQ, '
                 +'                     GROUP_STEP, '
                 +'                     DS_ORDER, '
                 +'                     NO_TABLE, '
                 +'                     CD_ITEMS, '
                 +'                     DS_AHEADPAY, '
                 +'                     NM_AHEADPAY, '
                 +'                     AMT_AHEADPAY, '
                 +'                     ORDER_DEVICE) '
                 +'              values(:P0, '
                 +'                     GetNextVal(''TR_ORDER''), '
                 +'                      0, '
                 +'                      ''A'', '
                 +'                      :P1, '
                 +'                      :P2, '
                 +'                      1, '
                 +'                      :P3, '
                 +'                      :P4, '
                 +'                      ''P'')',
                 [Common.Config.StoreCode,
                  Common.Table.Number,
                  Cash_SGrd.Cells[GDR_NO_APPROVAL, vIndex],
                  LeftStr(GetCardNoFormat(Cash_SGrd.Cells[GDR_CARDNO, vIndex],true),20),
                  StoI(Trim(Cash_SGrd.Cells[GDR_AMT,    vIndex]))]);
      end;

    end;
    Result := True;
  except
    on E: Exception do
    begin
      WriteLog('AHeadCashDataSave',E.Message);
      Result := false;
    end;
  end;
end;

function TCommon.SubMenuDataSave(aMenuCode, aDsSale: String; aQty,
  aPrice, aQtyUnit: Integer; aDsMenu, aDsStock: String; aSeq,aSubSeq:Integer): String;
begin
  Result := EmptyStr;
  if aMenuCode = EmptyStr then Exit;
  try
    ExecQuery('insert into SL_SALE_S(CD_STORE, '
             +'				        	 		 YMD_SALE, '
             +'				        			 NO_POS, '
             +'				        			 NO_RCP, '
             +'				        			 SEQ, '
             +'                      SUB_SEQ, '
             +'				        			 CD_MENU, '
             +'                      DS_SALE_TYPE, '
             +'				        			 QTY_SALE, '
             +'                      PR_SALE, '
             +'                      DS_MENU_TYPE, '
             +'                      DS_STOCK, '
             +'                      QTY_UNIT) '
             +'	          	  VALUES(:P0, '
             +'				        		   :P1, '
             +'				        			 :P2, '
             +'				        			 :P3, '
             +'				        			 :P4, '
             +'                      :P5, '
             +'				        			 :P6, '
             +'				        			 :P7, '
             +'                      :P8, '
             +'                      :P9, '
             +'                      :P10, '
             +'                      :P11, '
             +'                      :P12) ',
             [Config.StoreCode,
              WorkDate,
              Config.PosNo,
              Present.RcpNo,
              aSeq,
              aSubSeq,
              aMenuCode,
              aDsSale,
              aQty,
              aPrice,
              aDsMenu,
              aDsStock,
              aQtyUnit]);
  except
    on E: Exception do
    begin
      Result := E.Message;
    end;
  end;
end;

procedure TCommon.RestoreReserveData;
begin
   if OpenQuery('select * '
               +'  from SL_HOLD_D '
               +' where CD_STORE=:P0 '
               +'   and NO_POS  =:P1 '
               +'   and NO_HOLD =:P2 ',
               [Config.StoreCode,
                Copy(RestoreNo,1,2),
                Copy(RestoreNo,3,3)]) = 0 then Exit;
   ClearGrid(Hold_sGrd);
   with Hold_sGrd do
   begin
     while not Query.Eof do
     begin
        if Cells[0,0] <> '' then RowCount := RowCount + 1;
        Cells[GDH_DS_SALE, RowCount - 1] := Query.FieldByName('DS_SALE').AsString;
        Cells[GDH_CD_MENU, RowCount - 1] := Query.FieldByName('CD_MENU').AsString;
        Cells[GDH_QTY,     RowCount - 1] := Query.FieldByName('QTY_SALE').AsString;
        Cells[GDH_PRICE,   RowCount - 1] := Query.FieldByName('PR_SALE').AsString;
        Cells[GDH_ITEM,    RowCount - 1] := Query.FieldByName('CD_ITEM').AsString;
        Query.Next;
     end;
     Query.Close;
   end;
   try
     BeginTran;
     ExecQuery('delete from SL_HOLD_D '
              +' where CD_STORE=:P0 '
              +'   and NO_POS  =:P1 '
              +'   and NO_HOLD =:P2',
              [Config.StoreCode,
               Copy(RestoreNo,1,2),
               Copy(RestoreNo,3,3)]);
     ExecQuery('delete from SL_HOLD_H '
              +' where CD_STORE=:P0 '
              +'   and NO_POS  =:P1 '
              +'   and NO_HOLD =:P2',
              [Config.StoreCode,
               Copy(RestoreNo,1,2),
               Copy(RestoreNo,3,3)]);
     CommitTran;
   except
     on E: Exception do
     begin
       RollbackTran;
       WriteLog('RestoreReserveData',E.Message);
     end;
   end;
end;

function TCommon.SaveReserveData: Boolean;
var vIndex : Integer;
    vHoldNo   : String;
begin
  Result := False;
  OpenQuery('select Max(NO_HOLD) '
           +'	 from SL_HOLD_H '
           +' where CD_STORE	=:P0 '
           +'	  and NO_POS   	=:P1 '
           +'   and YN_INIT   =''N'' ',
           [Config.StoreCode,
            Config.PosNo]);

  vHoldNo := Common.Query.Fields[0].AsString;
  Common.Query.Close;

  if vHoldNo = '999' then
  begin
    ExecQuery('update SL_HOLD_H '
             +'   set YN_INIT = ''Y'' '
             +' where CD_STORE =:P0 '
             +'   and NO_POS   =:P1 ',
             [Config.StoreCode,
              Config.PosNo]);
    vHoldNo := Common.Query.Fields[0].AsString;
    Common.Query.Close;

    if vHoldNo = '' then
      vHoldNo := '001'
    else
      vHoldNo := FormatFloat('000',StrToIntDef(vHoldNo,0)+1);
  end
  else
    vHoldNo := FormatFloat('000',StrToIntDef(vHoldNo,0)+1);

  BeginTran;
  try
    ExecQuery('insert into SL_HOLD_H(CD_STORE, NO_POS, NO_HOLD, HOLD_TIME, AMT_HOLD, CD_MEMBER, YN_RESTORE, YN_INIT) '
             +'              values (:P0, :P1, :P2, :P3, :P4, :P5, ''N'',''N'') '
             +'ON DUPLICATE KEY UPDATE YN_INIT    = ''N'', '
             +'                        HOLD_TIME  = :P3, '
             +'                        AMT_HOLD   = :P4, '
             +'                        CD_MEMBER  = :P5, '
             +'                        YN_RESTORE = ''N'' ',
             [Config.StoreCode,
              Config.PosNo,
              vHoldNo,
              FormatDateTime('yyyymmddhhnn', now()),
              Present.TotalAmt,
              Member.Code]);

    for vIndex := 0 to Summary_sGrd.RowCount-1 do
      ExecQuery('insert into SL_HOLD_D(CD_STORE, '
               +'	          					NO_POS, '
               +'	          					NO_HOLD, '
               +'	          					SEQ, '
               +'	          					DS_SALE, '
               +'	          					CD_MENU, '
               +'	          					QTY_SALE, '
               +'	          					PR_SALE, '
               +'                     CD_ITEM) '
               +'	        		values (:P0, '
               +'	          					:P1, '
               +'	          					:P2, '
               +'	          					:P3, '
               +'	          					:P4, '
               +'	          					:P5, '
               +'	          					:P6, '
               +'	          					:P7, '
               +'                     :P8 )',
               [Config.StoreCode,
                Config.PosNo,
                vHoldNo,
                vIndex+1,
                Summary_sGrd.Cells[GDM_DS_SALE, vIndex],
                Summary_sGrd.Cells[GDM_CD_MENU, vIndex],
                ABS(StoF(Summary_sGrd.Cells[GDM_QTY, vIndex])),
                StoI(Summary_sGrd.Cells[GDM_PR_SALE, vIndex]),
                Summary_sGrd.Cells[GDM_CD_ITEM, vIndex]]);

    CommitTran;
    RestoreNo    := Config.PosNo+vHoldNo;
    Result       := True;
  except
    on E: Exception do
    begin
      RollbackTran;
      Result := False;
      HideWaitForm;
      WriteLog('SaveReserveData',E.Message);
      ErrBox(E.Message+#13#13+'저장을 완료하지 못했습니다');
      Exit;
    end;
  end;
end;

procedure TCommon.OpenDataToGrid(ADataset: TDataset;
  AGrid: TcxGridTableView);
var
  nCol: Integer;
begin
  if Not ADataset.Active then Exit;

  Screen.Cursor := crHourGlass;
  try
    ADataset.First;
    AGrid.DataController.BeginUpdate;
    AGrid.DataController.RecordCount := 0;
    while not ADataset.Eof do
    begin
      AGrid.DataController.AppendRecord;
      for nCol := 0 to ADataset.FieldCount-1 do
        AGrid.DataController.Values[AGrid.DataController.GetRecordCount-1, nCol] := ADataset.Fields.Fields[nCol].Value;

      ADataset.Next;
    end;
    if ADataset.Active then ADataset.Close;
  finally
    AGrid.DataController.EndUpdate;
    Screen.Cursor := crDefault;
  end;
end;

procedure TCommon.OpenDataToGrid(ADataset: TDataset;
  AGrid: TStringGrid);
var
  nCol: Integer;
begin
  if Not ADataset.Active then Exit;

  Screen.Cursor := crHourGlass;
  try
    ADataset.First;
    ClearGrid(AGrid);
    while not ADataset.Eof do
    begin
      if AGrid.Cells[0,0] <> '' then AGrid.RowCount := AGrid.RowCount+1;
      for nCol := 0 to ADataset.FieldCount-1 do
        AGrid.Cells[nCol, AGrid.RowCount-1] := ADataset.Fields.Fields[nCol].Value;

      ADataset.Next;
    end;
    if ADataset.Active then ADataset.Close;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TCommon.WriteLog(aJob,aLog:String;aSend:Boolean);
var vLogFile  :TextFile;
    vLogPath: String;
    lbFile   :Boolean;
    vWorkDate :String;
begin
  if Trim(WorkDate) = EmptyStr then
    vWorkDate := FormatDateTime('yyyymmdd', now())
  else
    vWorkDate := WorkDate;

  try
    vLogPath := AppPath+'Log\Work\';
    // Log 폴더 지정
    if not DirectoryExists(vLogPath) then
      ForceDirectories(vLogPath);

    //현재일자의 로그화일이 존재하는지 체크
    if FileExists(vLogPath+vWorkDate+'.Log') then lbFile := True
    else                                          lbFile := False;

    AssignFile(vLogFile, vLogPath+vWorkDate+'.Log');

    try
      if lbFile then Append(vLogFile)
      else           reWrite(vLogFile);

      Writeln(vLogFile, Format('[%s] : %s',[FormatDateTime('yyyy-mm-dd hh:nn:ss.z', Now), aLog]))
     finally
       System.Close(vLogFile); // 화일 닫기
    end;
  except
  end;

  if not aSend then Exit;

  DM.ExecCloud('insert into LOG(CD_COMPANY, '
              +'                CD_CUSTOMER, '
              +'                YMD_LOG, '
              +'                NO_POS, '
              +'                DS_LOG, '
              +'                FORM_NAME, '
              +'                ACTION_NAME, '
              +'                ACTION_TEXT, '
              +'                LOG_TEXT, '
              +'                VERSION, '
              +'                DT_INSERT) '
              +'        Values(:P0, '
              +'               :P1, '
              +'               Date_Format(NOW(), ''%Y%m%d''), '
              +'               ''PO'', '
              +'               :P2, '
              +'               :P3, '
              +'               :P4, '
              +'               :P5, '
              +'               :P6, '
              +'               :P7, '
              +'               NOW());',
              [Config.HeadStoreCode,
               Config.StoreCode,
               Ifthen(LowerCase(aJob) ='work','W','E'),
               '',
               aJob,
               '',
               aLog,
               GetFileVersion(Application.ExeName)],true,RestBaseURL);

end;

procedure TCommon.TaxfreeLogSave(aLog:String);
var vLogFile  :TextFile;
    vLogPath: String;
    lbFile   :Boolean;
    vWorkDate :String;
begin
  if Trim(WorkDate) = EmptyStr then
    vWorkDate := FormatDateTime('yyyymmdd', now())
  else
    vWorkDate := WorkDate;

  try
    vLogPath := AppPath+'Log\taxrefund\';
    // Log 폴더 지정
    if not DirectoryExists(vLogPath) then
      ForceDirectories(vLogPath);

    //현재일자의 로그화일이 존재하는지 체크
    if FileExists(vLogPath+vWorkDate+'.Log') then lbFile := True
    else                                          lbFile := False;

    AssignFile(vLogFile, vLogPath+vWorkDate+'.Log');

    try
      if lbFile then Append(vLogFile)
      else           reWrite(vLogFile);

      Writeln(vLogFile, Format('[%s] : %s',[FormatDateTime('yyyy-mm-dd hh:nn:ss.z', Now), aLog]));
    finally
      System.Close(vLogFile); // 화일 닫기
    end;
  except
  end;
end;

procedure TCommon.TmrDemonCheckTimer(Sender: TObject);
var vReadData :String;
    vMemory:Integer;
    vHnd :THandle;
    vSendData :AnsiString;
    vData     :TCOPYDATASTRUCT;
begin
  TmrDemonCheck.Enabled := False;

//  vMemory := GetFreeMemoryMB;
//  if (vMemory < 300) then
//  begin
//    vHnd := FindWindow('TOrangeTRMainForm', nil);
//    if vHnd > 0 then
//    begin
//      WriteLog('work',Format('메모리(%d) 잔량부족으로 OrangeTR 다시 실행',[vMemory]));
//      vSendData := 'restart';
//      vData.dwData:=0;
//      vData.cbData:=Length(vSendData)+1;
//      vData.lpData:=PAnsiChar(vSendData);
//      SendMessage(vHnd, WM_COPYDATA, 0, LPARAM(@vData));
//    end;
//  end;

  try
//    if GetOption(327) <> '0' then
//    begin
//      //메모리가 300메가 이하일때는 TR을 다시 실행한다
//      if ((GetOption(327)='1') and (vMemory < 500)) or ((GetOption(327)='2') and (vMemory < 400)) or ((GetOption(327)='3') and (vMemory < 300)) then
//      begin
//        if (GetFileVersion('Demon.exe') >= '2026.02.11.1') and Assigned(Table_F) and Table_F.Showing and Table_F.Active then
//        begin
//          vHnd := FindWindow('TfrmDemonMain', nil);
//          if vHnd > 0 then
//          begin
//            WriteLog('work',Format('메모리(%d) 잔량부족으로 OrangePOS 다시 실행',[vMemory]));
//            vSendData := 'update';
//            vData.dwData:=0;
//            vData.cbData:=Length(vSendData)+1;
//            vData.lpData:=PAnsiChar(vSendData);
//            SendMessage(vHnd, WM_COPYDATA, 0, LPARAM(@vData));
//            ShowWaitForm('메모리 부족으로 프로그램을 재실행합니다'#13'잠시만 기다려주세요');
//            Exit;
//          end;
//        end;
//      end;
//    end;

    // FindWindow로 데몬을 체크한다
    if ( not DemonCheck('127.0.0.1','CHECK',DemonPort)) and (FindWindow(nil, 'POSDemon') = 0) then
    begin
      WriteLog('work','데몬실행');
      KillTask('Demon.exe');
      ExcuteProgram('Demon.exe');
    end;

    //Nice페이먼츠 데몬 체크
    if (PosType <> ptOnlyOrder) and (GetOption(379)='2') and (Config.van_trd = vanJTNET) then
    begin
      if not Common.RunningProgram('JTtPayDaemon.exe') then
        ExcuteProgram('C:\JTNet\JTtPayDaemon.exe');
    end;
  finally
    TmrDemonCheck.Enabled := True;
  end;
end;

procedure TCommon.SmartAgentTimerTimer(Sender: TObject);
var vReadData :String;
begin
  SmartAgentTimer.Enabled := False;
  try
    if not Common.RunningProgram('SmartAgent.exe') then
    begin
      Sleep(1000);
      if not Common.RunningProgram('SmartAgent.exe') then
      begin
        WriteLog('work','SmartAgent 실행');
        KillTask('SmartAgent.exe');
        Sleep(500);
        ExcuteProgram(AppPath+'SmartAgent.exe');
      end;
    end;
  finally
    SmartAgentTimer.Enabled := True;
  end;
end;


function TCommon.TRSendMessage(aValue:String):Boolean;
var vHnd      :THandle;
    vData     :TCOPYDATASTRUCT;
    vSendData :AnsiString;
begin
  if Common.IsDebugMode then Exit;
  Result := true;
  if IsDBServer then
  begin
    vHnd := FindWindow('TOrangeTRMainForm', nil);
    if vHnd > 0 then
    begin
      vSendData := aValue;
      vData.dwData:=0;

      vData.cbData:=Length(vSendData)+1;
      vData.lpData:=PAnsiChar(vSendData);

      SendMessage(vHnd, WM_COPYDATA, 0, Integer(@vData));
      WriteLog('work','TRSendMessage-'+aValue);
    end;
  end
  else
  begin
    Result := true;
    Exit;
    with TIdTCPClient.Create(Application) do
    begin
      ConnectTimeout := 1000;
      ReadTimeout    := 1000;
      Host := Config.ServerIP;
      Port := 8005;
      try
        try
          ConnectTimeout := 1000;
          Connect;
          Socket.WriteLnRFC(aValue, IndyTextEncoding_OSDefault);
        except
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
end;

procedure TCommon.DeleteSignFile;
begin
  if FileExists(AppPath+'sign.bmp')   then DeleteFile(AppPath+'sign.bmp');
  if FileExists(AppPath+'sign0.bmp')  then DeleteFile(AppPath+'sign0.bmp');
  if FileExists(AppPath+'sign1.bmp')  then DeleteFile(AppPath+'sign1.bmp');
  if FileExists(AppPath+'sign2.bmp')  then DeleteFile(AppPath+'sign2.bmp');
  if FileExists(AppPath+'sign3.bmp')  then DeleteFile(AppPath+'sign3.bmp');
  if FileExists(AppPath+'sign4.bmp')  then DeleteFile(AppPath+'sign4.bmp');
  if FileExists(AppPath+'sign5.bmp')  then DeleteFile(AppPath+'sign5.bmp');
  if FileExists(AppPath+'sign6.bmp')  then DeleteFile(AppPath+'sign6.bmp');
  if FileExists(AppPath+'sign7.bmp')  then DeleteFile(AppPath+'sign7.bmp');
  if FileExists(AppPath+'sign8.bmp')  then DeleteFile(AppPath+'sign8.bmp');
  if FileExists(AppPath+'sign9.bmp')  then DeleteFile(AppPath+'sign9.bmp');
  if FileExists(AppPath+'sign10.bmp') then DeleteFile(AppPath+'sign10.bmp');
end;

function TCommon.GetCardLog(aValue: Boolean): String;
var vTemp :String;
begin
  if aValue then
    SetIniFile('POS', 'CARDLOG', '')
  else
  begin
    if not Config.IsKiosk then
      Result := GetIniFile('POS', 'CARDLOG', '')
    else
    begin
      Result := EmptyStr;
    end
  end;
end;

function TCommon.CheckAuthority(aPos:Integer):Boolean;
begin
  if not Assigned(UserCheck_F) then
    UserCheck_F    := TUserCheck_F.Create(Application);
  UserCheck_F.aPOS := aPos;
  Result := UserCheck_F.ShowModal = mrOK;
end;

function TCommon.CheckTable(aCheck:String; aTableNo:Integer): Boolean;
var vAHeadAmt :Integer;
begin
  Result := false;
  OpenQuery('select Sum(Ifnull(AMT_CASHRCP,0)+Ifnull(AMT_CARD,0)+Ifnull(AMT_CASH,0)) as AMT_AHEAD '
           +'  from (select Sum(AMT_APPROVAL) as AMT_CASHRCP, '
           +'               0 as AMT_CARD, '
           +'               0 as AMT_CASH '
           +'          from SL_CASH_AHEAD '
           +'         where CD_STORE  =:P0 '
           +'           and NO_TABLE  =:P1 '
           +'        union all '
           +'        select 0 as AMT_CASHRCP, '
           +'               Sum(AMT_APPROVAL) as AMT_CARD, '
           +'               0 as AMT_CASH '
           +'          from SL_CARD_AHEAD '
           +'         where CD_STORE  =:P0 '
           +'           and NO_TABLE  =:P1 '
           +'        union all '
           +'        select 0 as AMT_CASHRCP, '
           +'               0 as AMT_CARD, '
           +'               Sum(AMT_CASH) as AMT_CASH '
           +'          from SL_ORDER_H '
           +'         where CD_STORE  =:P0 '
           +'           and NO_TABLE  =:P1 '
           +'           and DS_ORDER  =''T'' '
           +'        ) as t ',
           [Config.StoreCode,
            aTableNo]);

  vAHeadAmt := Query.Fields[0].AsInteger;
  Query.Close;

  OpenQuery('select Ifnull(TABLE_STATE, '''') as TABLE_STATE '
           +'  from SL_ORDER_H '
           +' where CD_STORE =:P0 '
           +'   and DS_ORDER =''T'' '
           +'   and NO_TABLE =:P1 ',
           [Config.StoreCode,
            aTableNo]);

  if not Common.Query.Eof then
  begin
    if ((aCheck = 'A') or (aCheck = 'U')) and (Query.Fields[0].AsString = 'Y')  then
    begin
      MsgBox('사용 중인 테이블 입니다');
      Exit;
    end;
  end;

  if ((aCheck = 'A') or (aCheck = 'M')) and (vAHeadAmt > 0) then
  begin
    MsgBox('선결제 된 테이블 입니다'#13'사용할 수 없습니다');
    Exit;
  end;
  Result := true;
  Query.Close;
end;

procedure TCommon.DeleteCidData(aValue: String);
var I :Integer;
begin
  For I := 0 to Common.CidData.Count-1 do
  begin
    if Trim(Copy(Common.CidData.Strings[I],1,12)) = aValue then
    begin
      Common.CidData.Delete(I);
      Break;
    end;
  end;
end;

//첫째자리는 회선번호, 둘째자리는 수화기정보
procedure TCommon.AddCidData(aValue:String; aDeliveryNo:String='');
var I :Integer;
begin
  if (Common.Config.ReadyTelCount <= Common.CidData.Count) and (Common.CidData.Count > 0) then
    Common.CidData.Delete(0);

  For I := 0 to Common.CidData.Count-1 do
  begin
    if Trim(Copy(Common.CidData.Strings[I],1,12)) = Trim(Copy(aValue,4,12)) then
    begin
      Common.CidData.Delete(I);
      Break;
    end;
  end;
  Common.CidData.Add(RPadB(Copy(aValue,4, length(aValue)-3) ,12,' ')+
                     FormatDateTime('yyyy-mm-dd hh:nn',now() )+
                     Copy(aValue,2,1)+
                     aDeliveryNo);
end;

procedure TCommon.ShowNormalDualScreen;
begin
  if Config.IsKiosk then Exit;

  //듀얼을 사용하면
  case Config.DualSize of
    1 :
    begin
      //플래쉬 화일이 있으면 풀화면을 생성한다
      if not Assigned(DualOrder_F) then
      begin
        Application.CreateForm(TDualOrder_F, DualOrder_F);
        DualOrder_F.Top    := 0;
        DualOrder_F.Left   := Screen.Width;
      end;
      DualOrder_F.DShowPanel.Width  := 1024;
      DualOrder_F.DShowPanel.Height := 768;
      DualOrder_F.DShowPanel.Left   := 0;
      DualOrder_F.DShowPanel.Top    := 0;
      DualOrder_F.DShowPanel.BringToFront;
      Application.ProcessMessages;
      DualOrder_F.News_Tmr.Enabled := false;
      DualOrder_F.MsgLabel.Caption := '';
    end;
    2 :
    begin
      //플래쉬 화일이 있으면 풀화면을 생성한다
      if not Assigned(DualOrder800_F) then
      begin
        Application.CreateForm(TDualOrder800_F, DualOrder800_F);
        DualOrder800_F.Top    := 0;
        DualOrder800_F.Left   := Screen.Width;
      end;
      DualOrder800_F.DShowPanel.Width  := 800;
      DualOrder800_F.DShowPanel.Height := 600;
      DualOrder800_F.DShowPanel.Left   := 0;
      DualOrder800_F.DShowPanel.Top    := 0;
      DualOrder800_F.DShowPanel.BringToFront;
      DualOrder800_F.News_Tmr.Enabled := false;
      DualOrder800_F.MsgLabel.Caption := '';
    end;
    3 : Common.Device.SendToPad(#2+'dual'+#2+''+#2+'');
  end;
end;

procedure TCommon.ShowSaleDualScreen;
begin
  if Config.IsKiosk then Exit;
  //듀얼에 판매화면을 안보인다고 했을때
  if Config.DualMode = 1 then Exit;
  //듀얼을 사용하면

  case Config.DualSize of
    1 :
    begin
      //플래쉬 화일이 있으면 풀화면을 생성한다
      if not Assigned(DualOrder_F) then
      begin
        Application.CreateForm(TDualOrder_F, DualOrder_F);
        DualOrder_F.Top    := 0;
        DualOrder_F.Left   := Screen.Width;
      end;

      DualOrder_F.DShowPanel.Width   := 430;
      DualOrder_F.DShowPanel.Height  := 359;
      DualOrder_F.DShowPanel.Left    := 580;
      DualOrder_F.DShowPanel.Top     := 66;
      if Common.Member.Code = '' then
      begin
        DualOrder_F.Dual_sGrd.Height    := 596;
        DualOrder_F.MemberPanel.Visible := false;
      end
      else
      begin
        DualOrder_F.Dual_sGrd.Height    := 430;
        DualOrder_F.MemberPanel.Visible := true;
      end;

      Application.ProcessMessages;
      DualOrder_F.News_Tmr.Enabled := true;
    end;
    2 :
    begin
      //플래쉬 화일이 있으면 풀화면을 생성한다
      if not Assigned(DualOrder800_F) then
      begin
        Application.CreateForm(TDualOrder800_F, DualOrder800_F);
        DualOrder800_F.Top    := 0;
        DualOrder800_F.Left   := Screen.Width;
      end;

      if Common.Member.Code = '' then
      begin
        DualOrder800_F.Dual_sGrd.Height    := 596;
        DualOrder800_F.MemberPanel.Visible := false;
      end
      else
      begin
        DualOrder800_F.Dual_sGrd.Height    := 430;
        DualOrder800_F.MemberPanel.Visible := true;
      end;

      DualOrder800_F.DShowPanel.Width  := 301;
      DualOrder800_F.DShowPanel.Height := 252;
      DualOrder800_F.DShowPanel.Left   := 488;
      DualOrder800_F.DShowPanel.Top    := 64;
      DualOrder800_F.News_Tmr.Enabled := true;
    end;
    3 : Common.Device.SendToPad(#2+'dual'+#2+''+#2+'');
  end;
end;

procedure TCommon.FreeDualScreen;
begin
  if Config.IsKiosk then Exit;
  if Common.Config.DualSize in [0,3] then Exit;
  //플래쉬 화일이 있으면 풀화면을 닫는다
  if Assigned(DualOrder800_F) then  FreeAndNil(DualOrder800_F);
  if Assigned(DualOrder_F)    then  FreeAndNil(DualOrder_F);
end;

function TCommon.GetAddMenuAmt(TableNo: Integer): Integer;
begin
  Result := 0;
  if (Common.Config.OverTimeMenu <> '') then
  begin
    DM.OpenQuery('select COME_TIME, '
                +'       Now(), '
                +'       TIMESTAMPDIFF(MINUTE, COME_TIME, Now()) '
                +'  from SL_ORDER_H '
                +' where DS_ORDER = ''T'' '
                +'   and CD_STORE =:P0 '
                +'   and NO_TABLE =:P1',
                [Common.Config.StoreCode,
                 TableNo]);

    Table.LapeTime := DM.Query.Fields[2].AsInteger;
    if (DM.Query.Fields[0].AsDateTime > 0) and (Config.OverTimeTime < DM.Query.Fields[2].AsInteger) then
      Result := (DM.Query.Fields[2].AsInteger - Config.OverTimeTime) div Config.OverTimeEach * Config.OverTimeAmt
    else
      Result := 0;

    //기준시간이 지났으면 다음 추가요금이 되기전에 추가요금을 발생한다
    if (GetOption(412)='1') and (Config.OverTimeTime < DM.Query.Fields[2].AsInteger) then
      Result := Result + Config.OverTimeAmt;
  end;
  DM.Query.Close;
end;

procedure TCommon.ClearDeliveryTel(aLine:Integer);
var I :Integer;
begin
  if (aLine >=0) and (aLine <= 4) then
  begin
    DeliveryTel[aLine].Status     := '';
    DeliveryTel[aLine].TelNo      := '';
    DeliveryTel[aLine].OrderNo    := '';
    DeliveryTel[aLine].OrderTime  := '';
    DeliveryTel[aLine].GoTime     := '';
    DeliveryTel[aLine].Cust       := '';
    DeliveryTel[aLine].Addr1      := '';
    DeliveryTel[aLine].Addr2      := '';
  end
  else
  begin
    For I := 1 to 4 do
    begin
      DeliveryTel[I].Status     := '';
      DeliveryTel[I].TelNo      := '';
      DeliveryTel[I].OrderNo    := '';
      DeliveryTel[I].OrderTime  := '';
      DeliveryTel[I].GoTime     := '';
      DeliveryTel[I].Cust       := '';
      DeliveryTel[I].Addr1      := '';
      DeliveryTel[I].Addr2      := '';
    end;
  end;
end;

procedure TCommon.GetDeliveryTelInfo(aTelNo: String);
var vLine :Integer;
begin
  //회선번호
  vLine  := StoI(Copy(aTelNo,2,1));
  //전화번호
  aTelNo := Copy(aTelNo,4,12);

  ClearDeliveryTel(vLine);
  //현재 배달주문된 고객인지 체크
  OpenQuery('select YMD_DELIVERY, '
           +'       NO_DELIVERY, '
           +'       DS_STEP , '
           +'       Date_Format(DT_ORDER, ''%H:%i'') AS ORDER_TIME,'
           +'       DT_DELIVERY, '
           +'       NM_NAME, ADDRESS1, ADDRESS2, '
           +'       AMT_ORDER '
           +'  from SL_DELIVERY '
           +' where CD_STORE  = :P0 '
           +'   and DS_STEP  IN (''N'',''O'',''D'') '
           +'   and (NO_TEL1 =:P1 or NO_TEL2 =:P1 or NO_TEL3=:P1 or NO_TEL4=:P1) '
           +' limit 1 ',
           [Config.StoreCode,
            aTelNo]);

  if not Query.Eof then
  begin
    DeliveryTel[vLine].Status     := Query.FieldByName('ds_step').AsString;
    DeliveryTel[vLine].TelNo      := SetTelephone(aTelNo);
    DeliveryTel[vLine].OrderNo    := Query.FieldByName('ymd_delivery').AsString+'-'+Query.FieldByName('no_delivery').AsString;
    DeliveryTel[vLine].OrderTime  := Query.FieldByName('order_time').AsString;
    DeliveryTel[vLine].GoTime     := Query.FieldByName('dt_delivery').AsString;;
    DeliveryTel[vLine].Cust       := Query.FieldByName('nm_name').AsString;
    DeliveryTel[vLine].Addr1      := Query.FieldByName('address1').AsString;
    DeliveryTel[vLine].Addr2      := Query.FieldByName('address2').AsString;
    Query.Close;
    Exit;
  end;

    //기존고객인지 신규고객인지 체크
  DM.StoredProc.StoredProcName := 'POS_SELECT_DELIVERY';
  DM.StoredProc.PrepareSQL;
  DM.StoredProc.ParamByName('_cd_store').AsString := Config.StoreCode;
  DM.StoredProc.ParamByName('_no_tel1').AsString  := aTelNo;
  DM.StoredProc.ParamByName('_no_tel2').AsString  := aTelNo;
  DM.StoredProc.ParamByName('_no_tel3').AsString  := aTelNo;
  DM.StoredProc.ParamByName('_no_tel4').AsString  := aTelNo;
  DM.StoredProc.ExecProc;

  if DM.StoredProc.Eof then
  begin
    DeliveryTel[vLine].Status := '0';
    DeliveryTel[vLine].TelNo  := SetTelephone(aTelNo);
    DeliveryTel[vLine].Cust   := '신규고객';
  end
  else
  begin
    DeliveryTel[vLine].Status := '1';
    DeliveryTel[vLine].TelNo  := SetTelephone(aTelNo);
    DeliveryTel[vLine].Cust   := DM.StoredProc.FieldByName('nm_name').AsString;
    DeliveryTel[vLine].Addr1  := DM.StoredProc.FieldByName('address1').AsString;
    DeliveryTel[vLine].Addr2  := DM.StoredProc.FieldByName('address2').AsString;
  end;
  DM.StoredProc.Close;
end;

function TCommon.GetCorner:Integer;                                                //금액이 존재하는 업장을 찾는다
var vIndex :Integer;
begin
  Result := -1;
  For vIndex := 0 to High(Corner) do
  begin
    if Corner[vIndex].SaleAmt > 0 then
    begin
      Result := vIndex;
      Break;
    end;
  end;
end;


function TCommon.SetCornerAmt:Integer;
  procedure SetCornerbyAmt(aCorner:String; aAmt:Integer);
  var I :Integer;
  begin
    For I := 0 to High(Corner) do
    begin
      if Corner[I].Code = aCorner then
      begin
        Corner[I].SaleAmt := Common.Corner[I].SaleAmt + aAmt;
        Break;
      end;
    end;
  end;
var vRow, vIndex, vCount :Integer;
    vError :Boolean;
begin
  Result  := 0;
  vCount  := 0;
  vError  := false;
  For vIndex := 0 to High(Corner) do
  begin
    Corner[vIndex].SaleAmt := 0;
    Corner[vIndex].NetAmt  := 0;
    Corner[vIndex].TaxAmt  := 0;
  end;

  For vRow := 0 to Summary_sGrd.RowCount-1 do
  begin
    vIndex := GetCornerIndex(Summary_sGrd.Cells[GDM_CORNER, vRow], '');

    if vIndex < 0 then
    begin
      vError := true;
      ErrBox('VAN 정보가 지정되지 않은 메뉴가'#13'있어 다중모드가 해제됩니다');
      Break;
      Exit;
    end;

    Corner[vIndex].SaleAmt := Corner[vIndex].SaleAmt + StoI(Summary_sGrd.Cells[GDM_AMT,        vRow])
                                                     - (StoI(Summary_sGrd.Cells[GDM_DC_MENU,    vRow])  * IfThen(Summary_sGrd.Cells[GDM_DS_MENU, vRow]='W',1,StoI(Summary_sGrd.Cells[GDM_QTY, vRow])) )
                                                     - StoI(Summary_sGrd.Cells[GDM_DC_RECEIPT, vRow])
                                                     - (StoI(Summary_sGrd.Cells[GDM_DC_SPC,     vRow]) * Ifthen(Summary_sGrd.Cells[GDM_DS_MENU, vRow] = 'W', 1,StoI(Summary_sGrd.Cells[GDM_QTY, vRow])) );

    if (Summary_sGrd.Cells[GDM_DS_TAX, vRow] = '1') then
      Corner[vIndex].NetAmt := Corner[vIndex].NetAmt + StoI(Summary_sGrd.Cells[GDM_AMT,        vRow])
                                                     - (StoI(Summary_sGrd.Cells[GDM_DC_MENU,    vRow])  * IfThen(Summary_sGrd.Cells[GDM_DS_MENU, vRow]='W',1,StoI(Summary_sGrd.Cells[GDM_QTY, vRow])) )
                                                     - StoI(Summary_sGrd.Cells[GDM_DC_RECEIPT, vRow])
                                                     - (StoI(Summary_sGrd.Cells[GDM_DC_SPC,     vRow]) * Ifthen(Summary_sGrd.Cells[GDM_DS_MENU, vRow] = 'W', 1,StoI(Summary_sGrd.Cells[GDM_QTY, vRow])) );
  end;

  if vError then
  begin
    Result := 0;
    Exit;
  end;

  for vIndex := 0 to High(Corner) do
  begin
    Corner[vIndex].TaxAmt := FtoI(hTrunc( Corner[vIndex].NetAmt / 11 ,1));
    if Corner[vIndex].SaleAmt > 0 then
      Result := Result + 1;
  end;
end;

function TCommon.GetCamCapture: Boolean;
begin
  try
    Capture_F := TCapture_F.Create(Application);
    if Capture_F.ShowModal = mrOK then
      Result := True
    else
      Result := False;
  finally
    FreeAndNil(Capture_F);
  end;
end;

function TCommon.SetSystemTimeSync:Boolean;
var vSystemTime: TSystemTime;
    vTimeZoneInfo: TTimeZoneInformation;
    vServerDate :TDateTime;
begin
  if IsDBServer then Exit;

  DM.OpenQuery('select Now() ',[]);
  vServerDate := DM.Query.Fields[0].AsDateTime;
  DM.CloudData.Close;

  Result := true;

  if (vServerDate < IncMinute(Now(),-5)) or (vServerDate > IncMinute(Now(), 5))  then
  begin
    GetTimeZoneInformation(vTimeZoneInfo);
    DateTimeToSystemTime(vServerDate + vTimeZoneInfo.Bias / 1440, vSystemTime);
    SetSystemTime(vSystemTime);
  end;
end;

procedure TCommon.Shutdown;
var
  Token: THandle;
  TokenPrivileges: TTokenPrivileges;
  PreviosPrivileges: ^TTokenPrivileges;
  nTmp: DWORD;
begin
  if not AskBox('시스템을 종료하시겠습니까?') then Exit;
  // 시스템을 종료한다
  if Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
    OpenProcessToken(GetCurrentProcess, TOKEN_ADJUST_PRIVILEGES + TOKEN_QUERY, Token);
    LookupPrivilegeValue('', 'SeShutdownPrivilege', TokenPrivileges.Privileges[0].Luid);
    TokenPrivileges.PrivilegeCount := 1;
    TokenPrivileges.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
    nTmp := 0;
    PreviosPrivileges := nil;
    AdjustTokenPrivileges(Token, False, TokenPrivileges, 16, PreviosPrivileges^, nTmp);
  end; // if Win32Platform = VER_PLATFORM_WIN32_NT then
  ExitWindowsEx( EWX_SHUTDOWN or EWX_POWEROFF, 0 );
  Application.Terminate;
end;

procedure TCommon.SetCornerCardInfo(aCorner: String);
var I, aIndex :Integer;
begin
  For I := 0 to High(Common.Corner) do
  begin
    if Common.Corner[I].Code = aCorner then
    begin
      aIndex := I;
      Break;
    end;
  end;

  Common.Config.van_Terid := Common.Corner[aIndex].VanTID;
  Common.Config.BizNo     := CtoC(Common.Corner[aIndex].BizNo);
  Common.Config.SerialNo  := Common.Corner[aIndex].VanSerial;
  Common.Config.Van_Tax   := Common.Corner[aIndex].VanTax;

  Config.ReceiptTitle[1] := '상호 : '+Common.Corner[aIndex].Name;
  Config.ReceiptTitle[2] := '사업자 : '+Common.Corner[aIndex].BizNo+' ('+Common.Corner[aIndex].Boss+' )';
  Config.ReceiptTitle[3] := '주소 : '+Common.Corner[aIndex].Addr;
  Config.ReceiptTitle[4] := '전화 : '+Common.Corner[aIndex].TelNo;
end;

function TCommon.GetCornerIndex(aCorner: String;aTID:String): Integer;
var vIndex :Integer;
begin
  Result := -1;
  if aTID = '' then
  begin
    for vIndex:= 0 to High(Common.Corner) do
    begin
      if Common.Corner[vIndex].Code = aCorner then
      begin
        Result := vIndex;
        Break;
      end;
    end;
  end
  else
  begin
    for vIndex:= 0 to High(Common.Corner) do
    begin
      if Common.Corner[vIndex].VanTID = aTID then
      begin
        Result := vIndex;
        Break;
      end;
    end;
  end;
end;

{ 웹서비스 관련 (2011.07.26 이승혁) }
procedure TCommon.WSSplit(const aValue: WideString; aSplitType: Integer; var aList: TStringList);
var
  vTemp    : WideString;
  vPos     : Integer;
  vSplitter: WideString;
begin
  aList.Clear;
  case (aSplitType) of
    0 : // 레코드
        vSplitter := splitRecord;
    1 : // 칼럼(레코드에 속한 칼럼)
        vSplitter := splitRecordAnsi;
    2 : // 칼럼(단독)
        vSplitter := splitColumn;
    3 : vSplitter := splitColumnAnsi;
  end;
  vTemp := aValue;
  repeat
    vPos := Pos(vSplitter, vTemp);
    if vPos > 0 then
    begin
      if aSplitType = 0 then
        aList.Add(WSReplace2(Copy(vTemp, 1, vPos-1)))
      else
        aList.Add(Copy(vTemp, 1, vPos-1));
      vTemp := Copy(vTemp, vPos+1, Length(vTemp));
    end
    else
    begin
      if aSplitType = 0 then
        aList.Add(WSReplace2(vTemp))
      else
        aList.Add(vTemp);
    end
  until vPos = 0;
end;


{ 웹서비스 관련 (2011.07.26 이승혁) }
function TCommon.WSReplace(const aValue: string): WideString;
var
  vIndex: Integer;
begin
  Result := '';
  for vIndex := 1 to Length(aValue) do
    if (aValue[vIndex] = splitRecordAnsi) then
      Result := Result + splitRecord
    else if (aValue[vIndex] = splitColumnAnsi) then
      Result := Result + splitColumn
    else
      Result := Result + aValue[vIndex];
end;


function TCommon.WSReplace2(const aValue: string): String;
var
  vIndex: Integer;
begin
  Result := '';
  for vIndex := 1 to Length(aValue) do
    if (String(aValue[vIndex]) = splitRecord) then
      Result := Result + splitRecordAnsi
    else if (String(aValue[vIndex]) = splitColumn) then
      Result := Result + splitColumnAnsi
    else
      Result := Result + aValue[vIndex];
end;

procedure TCommon.KitchenDataCopy(aKind:Integer=0);
var I,II :Integer;
begin
  case aKind of
    0 :
    begin
      For I := 0 to High(KitchenPrinter) do
      begin
        For II := 1 to 100 do
        BefKitchenPrinter[I].GroupSource[II] := KitchenPrinter[I].GroupSource[II];
        BefKitchenPrinter[I].Source          := KitchenPrinter[I].Source;
        BefKitchenPrinter[I].Data            := KitchenPrinter[I].Data;
        BefKitchenPrinter[I].Cancel          := KitchenPrinter[I].Cancel;
        BefKitchenPrinter[I].Corner          := KitchenPrinter[I].Corner;
        BefKitchenPrinter[I].OrderNo         := Table.OrderNo;
      end;
    end;
    1 :
    begin
      For I := 0 to High(KitchenPrinter) do
      begin
        For II := 1 to 100 do
        KitchenPrinter[I].GroupSource[II] := BefKitchenPrinter[I].GroupSource[II];
        KitchenPrinter[I].Source          := BefKitchenPrinter[I].Source;
        KitchenPrinter[I].Data            := BefKitchenPrinter[I].Data;
        KitchenPrinter[I].Cancel          := BefKitchenPrinter[I].Cancel;
        KitchenPrinter[I].Corner          := BefKitchenPrinter[I].Corner;
        Table.OrderNo                     := BefKitchenPrinter[I].OrderNo;
      end;
    end;
  end;
end;

function TCommon.GetPluNo:String;
begin
  Result := IfThen(Trim(Common.Config.PluNo)='', '01', Common.Config.PluNo);
end;

procedure TCommon.SaveKDSData(aTakeOut:Boolean);
var vRecList,
    vColList : TStringList;
    vSeq, vSeq1,
    vIndex,
    vColIndex,
    vTableNo :Integer;
    vIsKDS :Boolean;
    vStatus :String;
begin
  vIsKDS := false;
  for vIndex := 0 to High(Common.KitchenPrinter) do
    if Common.KitchenPrinter[vIndex].IsKDS then
    begin
      vIsKDS := true;
      Break;
    end;

  if not vIsKDS then Exit;

  try
    vRecList := TStringList.Create;
    vColList := TStringList.Create;

    OpenQuery('select Ifnull(max(SEQ),0) '
             +'  from SL_ORDER_KDS '
             +' where CD_STORE  =:P0'
             +'   and YMD_SALE  =:P1 ',
             [Common.Config.StoreCode,
              Common.WorkDate]);
    vSeq := Common.Query.Fields[0].AsInteger;
    Common.Query.Close;


    case StoI(GetOption(362)) of
      0 : vStatus := '0';     //조리대기
      1 : vStatus := '1';     //조리중
      2 : vStatus := '3';     //조리완료
      3 : vStatus := '1';     //렛츠오더 주문은 조리대기 그외는 조리중
    end;

    for vIndex := 0 to High(Common.KitchenPrinter) do
    begin
      if Common.KitchenPrinter[vIndex].IsKDS and (Common.KitchenPrinter[vIndex].Menu <> EmptyStr) then
      begin
        Common.WSSplit(Common.KitchenPrinter[vIndex].Menu, 1, vRecList);
        for vColIndex := 0 to vRecList.Count-1 do
        begin
          Common.WSSplit(vRecList[vColIndex], 3, vColList);
          if vColList.Count < 5 then Continue;
          //동일테이블에 같은 메뉴는 수량을 추가할때
          if GetOption(193)='1' then
          begin
            OpenQuery('select SEQ '
                     +'  from SL_ORDER_KDS '
                     +' where CD_STORE   =:P0 '
                     +'   and YMD_SALE   =:P1 '
                     +'   and CD_PRINTER =:P2 '
                     +'   and CD_MENU    =:P3 '
                     +'   and DS_STATUS  =:P4 ',
                     [Config.StoreCode,
                      WorkDate,
                      KitchenPrinter[vIndex].Code,
                      vColList[3],
                      vStatus]);

            if not Query.Eof then
            begin
              vSeq1 := Query.Fields[0].AsInteger;
              Query.Close;
              ExecQuery('update SL_ORDER_KDS '
                       +'   set QTY_ORDER = QTY_ORDER + :P3, '
                       +'       DT_ORDER  = Now() '
                       +' where CD_STORE   =:P0 '
                       +'   and YMD_SALE   =:P1 '
                       +'   and SEQ        =:P2 ',
                       [Config.StoreCode,
                        WorkDate,
                        vSeq1,
                        Ifthen(vColList[0]='C',StoI(vColList[5])*-1, StoI(vColList[5]))]);
              Continue;
            end
            else
            begin
              OpenQuery('select Ifnull(Max(NO_TABLE),0)+1 '
                       +'  from SL_ORDER_KDS '
                       +' where CD_STORE  =:P0'
                       +'   and YMD_SALE  =:P1 ',
                       [Common.Config.StoreCode,
                        Common.WorkDate]);

              vTableNo := Query.Fields[0].AsInteger;
              Query.Close;
            end;
          end
          else
            vTableNo := Table.Number;

          Inc(vSeq);
          ExecQuery('insert into SL_ORDER_KDS(CD_STORE, '
                   +'                         YMD_SALE, '
                   +'                         SEQ, '
                   +'                         NO_ORDER, '
                   +'                         CD_PRINTER, '
                   +'                         NO_TABLE, '
                   +'                         DS_ORDER, '
                   +'                         CD_MENU, '
                   +'                         CD_MENU1, '
                   +'                         NO_GROUP, '
                   +'                         NO_STEP, '
                   +'                         QTY_ORDER, '
                   +'                         PR_ORDER, '
                   +'                         NO_POS, '
                   +'                         CD_SAWON, '
                   +'                         DT_ORDER, '
                   +'                         MENU_MEMO, '
                   +'                         TABLE_MEMO, '
                   +'                         NO_CALL, '
                   +'                         DS_ORDER_TYPE, '
                   +'                         NO_RCP, '
                   +'                         NO_DELIVERY, '
                   +'                         DS_STATUS, '
                   +'                         CNT_CUSTOMER, '
                   +'                         YN_DOUBLE) '
                   +'                  Values(:P0, '
                   +'                         :P1, '
                   +'                         :P2, '
                   +'                         :P3, '
                   +'                         :P4, '
                   +'                         :P5, '
                   +'                         :P6, '
                   +'                         :P7, '
                   +'                         :P8, '
                   +'                         :P9, '
                   +'                         :P10, '
                   +'                         :P11, '
                   +'                         :P12, '
                   +'                         :P13, '
                   +'                         :P14, '
                   +'                         Now(), '
                   +'                         :P15, '
                   +'                         :P16, '
                   +'                         :P17, '
                   +'                         :P18, '
                   +'                         :P19, '
                   +'                         :P20, '
                   +'                         :P21, '
                   +'                         :P22, '
                   +'                         :P23) ',
                   [Config.StoreCode,
                    WorkDate,
                    vSeq,
                    Ifthen(GetOption(193)='1', vTableNo, Table.OrderNo),
                    KitchenPrinter[vIndex].Code,
                    vTableNo,
                    vColList[0],
                    vColList[3],
                    vColList[4],
                    StoI(vColList[1]),
                    StoI(vColList[2]),
                    StoI(vColList[5]),
                    StoI(vColList[6]),
                    Config.PosNo,
                    Config.UserCode,
                    vColList[7],
                    Table.Memo,
                    PreSent.CallNo,
                    vColList[8],
                    ifthen(aTakeOut,Present.RcpNo,''),
                    Table.DeliveryNo,
                    vStatus,
                    Table.CustomerCount,
                    vColList[9]]);
        end;
      end;
    end;
  finally
    vRecList.Free;
    vColList.Free;
  end;
end;

procedure TCommon.SetCustomerCount(aCount:Integer);
begin
  Table.CustomerCount := aCount;
  if not Assigned(Table.AgeCode) then Exit;

  if (Table.AgeCode.Count > 0) then
    Table.AgeCode.Strings[0] := Copy(Table.AgeCode.Strings[0],1,3) + FormatFloat('000', Table.CustomerCount)
  else
    Table.AgeCode.Add('001' + FormatFloat('000', Table.CustomerCount));
end;

//------------------------------------------------------------------------------
// Ini File 값 저장
function TCommon.SetIniFile(aSection, aIdent, aData: string): Boolean;
begin
  Result := false;
  with TIniFile.Create(ExtractFilePath(Application.ExeName)+filConfigIni) do
    try
      try
        WriteString(aSection, aIdent, aData);
        Result := true;
      except
      end;
    finally
      Free;
    end;
end;
function TCommon.SetIniFile(aSection, aIdent: string; aData: Integer): Boolean;
begin
  Result := false;
  with TIniFile.Create(ExtractFilePath(Application.ExeName)+filConfigIni) do
    try
      try
        WriteInteger(aSection, aIdent, aData);
        Result := true;
      except
      end;
    finally
      Free;
    end;
end;
function TCommon.SetIniFile(aSection, aIdent: string; aData: Boolean): Boolean;
begin
  Result := false;
  with TIniFile.Create(ExtractFilePath(Application.ExeName)+filConfigIni) do
    try
      try
        WriteBool(aSection, aIdent, aData);
        Result := true;
      except
      end;
    finally
      Free;
    end;
end;
//------------------------------------------------------------------------------
// Ini File 값 읽기
function TCommon.GetIniFile(aSection, aIdent, aDefault: string): string;
begin
  with TIniFile.Create(ExtractFilePath(Application.ExeName)+filConfigIni) do
    try
      Result := ReadString(aSection, aIdent, aDefault);
    finally
      Free;
    end;
end;
function TCommon.GetIniFile(aSection, aIdent: string; aDefault: Integer): Integer;
begin
  with TIniFile.Create(ExtractFilePath(Application.ExeName)+filConfigIni) do
    try
      Result := ReadInteger(aSection, aIdent, aDefault);
    finally
      Free;
    end;
end;
function TCommon.GetIniFile(aSection, aIdent: string; aDefault: Boolean): Boolean;
begin
  with TIniFile.Create(ExtractFilePath(Application.ExeName)+filConfigIni) do
    try
      Result := ReadBool(aSection, aIdent, aDefault);
    finally
      Free;
    end;
end;

function TCommon.GetCardNoFormat(aValue: String;aSave:Boolean=false): String;
var vTemp :String;
begin
  vTemp := Replace(aValue,'-','');
  if not aSave then
  begin
    case Length(vTemp) of
      16 : Result := FormatMaskText('!0000-0000-0000-0000;0;', vTemp);
      15 : Result := FormatMaskText('!0000-000000-00000;0;', vTemp);
      14 : Result := FormatMaskText('!0000-000000-0000;0;', vTemp);
      13 : Result := FormatMaskText('!000000-0000000;0;', vTemp);
      11 : Result := FormatMaskText('!000-0000-0000;0;', vTemp);
      else Result := vTemp;
    end;
  end
  else //저장시
  begin
    case Length(vTemp) of
      16 : Result := FormatMaskText('!0000-00**-****-****;0;', LeftStr(vTemp,6));
      15 : Result := FormatMaskText('!0000-00****-*****;0;',   LeftStr(vTemp,6));
      14 : Result := FormatMaskText('!0000-00****-****;0;',    LeftStr(vTemp,6));
      13 : Result := FormatMaskText('!000000-*******;0;',      LeftStr(vTemp,6));
      11 : Result := FormatMaskText('!000-****-0000;0;',      LeftStr(vTemp,3)+RightStr(vTemp,4));
      else
      begin
        if Pos('*',aValue) > 0 then
          Result := aValue
        else if Length(aValue) > 16 then
          Result := LeftStr(aValue, Length(aValue)-6)+'******'
        else
          Result := aValue;
      end;
    end;
  end;
end;

function TCommon.RunningProgram(aExeFileName: String): Boolean;
var
  Next     : BOOL;
  SHandle  : THandle;
  Process32: TProcessEntry32;
  ProcId   : DWORD;
begin
  Result := false;
  Process32.dwSize := SizeOf(TProcessEntry32);
  SHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);

  if Process32First(SHandle, Process32) then
  begin
    repeat
      Next := Process32Next(SHandle, Process32);
      if Next then
      begin
        GetWindowThreadProcessID(SHandle, @ProcId);
        if Process32.szExeFile = aExeFileName then
        begin
          ProcId  := DWORD(Process32.th32ProcessID);
          SHandle := OpenProcess(PROCESS_ALL_ACCESS, TRUE, ProcId);
          Result  := true;
          Break;
        end;
      end;
    until not Next;
  end;
  CloseHandle(SHandle);
end;

function TCommon.GetProgramHandle(aExeFileName:String):Integer;
var
  Next     : BOOL;
  SHandle  : THandle;
  Process32: TProcessEntry32;
  ProcId   : DWORD;
begin
  Result := -1;
  Process32.dwSize := SizeOf(TProcessEntry32);
  SHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);

  if Process32First(SHandle, Process32) then
  begin
    repeat
      Next := Process32Next(SHandle, Process32);
      if Next then
      begin
        GetWindowThreadProcessID(SHandle, @ProcId);
        if Process32.szExeFile = aExeFileName then
        begin
          ProcId  := DWORD(Process32.th32ProcessID);
          Result := OpenProcess(PROCESS_ALL_ACCESS, TRUE, ProcId);
          Break;
        end;
      end;
    until not Next;
  end;
  CloseHandle(SHandle);
end;


procedure TCommon.GroupGridTable(aGridTableView: TcxGridTableView; aKey,
  aTextIndex: Integer; aText: String; aCol: array of Integer);
var vIndex, vCol, vRowIndex, vCount, vRow :Integer;
    vSum, vTotal :array of Currency;
    vKeyText:String;
    vLoop   :Boolean;
label Loop;
begin
  SetLength(vSum,   High(aCol)+1);
  SetLength(vTotal, High(aCol)+1);
  for vIndex := 0 to High(vSum) do
  begin
    vSum[vIndex]    := 0;
    vTotal[vIndex]  := 0;
  end;
  vKeyText  := '999999999';
  vCount    := 0;
  aGridTableView.DataController.BeginUpdate;
  try
Loop:
    vLoop := false;
    with aGridTableView.DataController do
      for vIndex := vRow to RecordCount-1 do
      begin
        if (vKeyText = '999999999') or (Values[vIndex, aKey] = vKeyText) then
        begin
          if vCount > 0 then
          begin
            for vCol := 0 to aTextIndex do
              Values[vIndex, vCol]       := EmptyStr;
          end
          else
            vKeyText := Values[vIndex, aKey];

          Inc(vCount);
          for vCol := 0 to High(vSum) do
          begin
            vSum[vCol]   := vSum[vCol]   + Values[vIndex, aCol[vCol]];
            vTotal[vCol] := vTotal[vCol] + Values[vIndex, aCol[vCol]];
          end;
        end
        else
        begin
          vRowIndex := aGridTableView.DataController.InsertRecord(vIndex);
          Values[vRowIndex, aTextIndex] := aText;
          for vCol := 0 to High(vSum) do
          begin
            Values[vRowIndex, aCol[vCol]] := vSum[vCol];
            vSum[vCol] := 0;
          end;
          vCount := 0;
          vKeyText  := '999999999';
          vRow  := vIndex + 1;
          if RecordCount > vRow then
            vLoop := true;
          Break;
        end;
      end;
      if vLoop then goto Loop
      else
      begin
        aGridTableView.DataController.AppendRecord;
        vRowIndex := aGridTableView.DataController.RecordCount-1;
        aGridTableView.DataController.Values[vRowIndex, aTextIndex] := aText;
        for vCol := 0 to High(vSum) do
          aGridTableView.DataController.Values[vRowIndex, aCol[vCol]] := vSum[vCol];

        //총합계 추가
        aGridTableView.DataController.AppendRecord;
        vRowIndex := aGridTableView.DataController.RecordCount-1;
        aGridTableView.DataController.Values[vRowIndex, aTextIndex] := '     [ 합 계 ] ';
        for vCol := 0 to High(vSum) do
          aGridTableView.DataController.Values[vRowIndex, aCol[vCol]] := vTotal[vCol];
      end;
  finally
    aGridTableView.DataController.EndUpdate;
  end;
end;


function TCommon.SaveReadyAmt(aCashAmt:Currency;aCommit:Boolean):Boolean;
var vSeq, vCnt :Integer;
begin
  try
    OpenQuery('select Ifnull(Max(SEQ), (select Ifnull(MAX(SEQ),0)+1 '
             +'                           from SL_CASHIER_MGM as s'
             +'                          where CD_STORE 	=:P0 '
             +'                            and YMD_CLOSE	=:P1 '
             +'                            and NO_POS	    =:P2 '
             +'                            and CD_SAWON	  =:P3 '
             +'                            and YN_CLOSE	=''Y'')) '
             +'  from SL_CASHIER_MGM '
             +' where CD_STORE 	=:P0 '
             +'   and YMD_CLOSE	=:P1 '
             +'   and NO_POS	  =:P2 '
             +'   and CD_SAWON	=:P3 '
             +'   and YN_CLOSE	=''N'' ',
             [Config.StoreCode,
              WorkDate,
              Config.PosNo,
              Config.UserCode]);
    vSeq := Query.Fields[0].AsInteger;

    OpenQuery('select Count(*) '
             +'  from SL_CASHIER_MGM '
             +' where CD_STORE 	=:P0 '
             +'   and YMD_CLOSE	=:P1 '
             +'   and NO_POS	  =:P2 '
             +'   and CD_SAWON	=:P3 '
             +'   and SEQ     	=:P4 ',
             [Config.StoreCode,
              WorkDate,
              Config.PosNo,
              Config.UserCode,
              vSeq]);
    vCnt := Query.Fields[0].AsInteger;

    if vCnt = 0 then
    begin
      ExecQuery('insert into SL_CASHIER_MGM(CD_STORE, '
               +'		               					YMD_CLOSE, '
               +'		               					NO_POS, '
               +'		               					CD_SAWON, '
               +'		               					SEQ, '
               +'		               					AMT_READY, '
               +'		               					YN_CLOSE) '
               +'		                 values(:P0, '
               +'		               					:P1, '
               +'		               					:P2, '
               +'		               					:P3, '
               +'		               					:P4, '
               +'		               					:P5, '
               +'		               					''N'') ',
               [Config.StoreCode,
                WorkDate,
                Config.PosNo,
                Config.UserCode,
                vSeq,
                aCashAmt],aCommit);
    end
    else
    begin
      ExecQuery('update SL_CASHIER_MGM '
               +'   set AMT_READY = AMT_READY + :P5, '
               +'       DT_CHANGE = Now() '
               +' where CD_STORE 	=:P0 '
               +'   and YMD_CLOSE	=:P1 '
               +'   and NO_POS	  =:P2 '
               +'   and CD_SAWON	=:P3 '
               +'   and SEQ       =:P4 ',
               [Config.StoreCode,
                WorkDate,
                Config.PosNo,
                Config.UserCode,
                vSeq,
                aCashAmt],aCommit);

    end;
    Result := true;
  except
    on E: Exception do
    begin
      Common.WriteLog('SaveReadyAmt',E.Message);
      Common.ErrBox(E.Message);
      Result := false;
    end;
  end;
end;

function  TCommon.GetMemberCode:String;
begin
  Result := EmptyStr;
  DM.OpenCloud('select Ifnull(Max(CD_MEMBER),''0'') '
              +'  from MS_MEMBER '
              +' where CD_HEAD  = :P0 '
              +'   and CD_STORE = :P1'
              +'   and Length(CD_MEMBER) = 10 '
              +'   and Left(CD_MEMBER,:P3) =:P2 ',
             [Config.HeadStoreCode,
              Ifthen(GetHeadOption(5)='0',Config.StoreCode,StandardStore),
              Config.MemberNoPrefix,
              Length(Config.MemberNoPrefix)],Common.RestDBURL);

   if DM.CloudData.Eof and (DM.CloudData.Fields[0].AsString = '9999999999') then
   begin
     Common.MsgBox('회원번호를 자동으로 증가할 수 없습니다');
     Exit;
   end;

  if DM.CloudData.Eof or (DM.CloudData.Fields[0].AsString = '0') then
    Result := RPad(Config.MemberNoPrefix, 10, '0')
  else
    Result := DM.CloudData.Fields[0].AsString;

   Result := Config.MemberNoPrefix + LPad(IntToStr(StrToInt64(RightStr(Result,10-Length(Config.MemberNoPrefix)))+1), 10-Length(Config.MemberNoPrefix), '0');
   DM.CloudData.Close;
end;


function  TCommon.SaveMemberAdd(aNew:Boolean; aMemberNo, aName, aDsMember, aGender, aHomeTel, aMobileTel, aCardNo, aPost, aAddr1, aAddr2, aCashRcpNo, aCourse, aLocal,
aLunar, aTrust, aNews, aBirthDay, aDamdangCode, aRemark, aEtcTel1, aEtcTel2:String):Boolean;
var vMemberCode, vCode, vTemp :String;
    vPoint :Integer;
begin
  Result := false;
  try
    if aNew then
      vMemberCode := GetMemberCode
    else
      vMemberCode := aMemberNo;
    DM.ExecCloud(IfThen(aNew, 'insert into MS_MEMBER(CD_HEAD, '
                             +'                      CD_STORE, '
                             +'                      CD_MEMBER, '
                             +'                      NM_MEMBER, '
                             +'                      DS_SEX, '
                             +'                      DS_MEMBER, '
                             +'                      NO_CARD, '
                             +'                      YMD_ISU, '
                             +'                      YMD_BIRTH, '
                             +'                      YN_LUNAR, '
                             +'                      TEL_HOME, '
                             +'                      TEL_MOBILE, '
                             +'                      NO_POST, '
                             +'                      ADDR1, '
                             +'                      ADDR2, '
                             +'                      YN_NEWS, '
                             +'                      REMARK, '
                             +'                      NO_CASHRCP, '
                             +'                      CD_SAWON_CHG, '
                             +'                      CD_DAMDANG, '
                             +'                      DT_CHANGE, '
                             +'                      TEL_HOME_SHORT, '
                             +'                      TEL_MOBILE_SHORT, '
                             +'                      CHOSUNG, '
                             +'                      YMD_AGREE, '
                             +'                      CD_COURSE, '
                             +'                      CD_LOCAL, '
                             +'                      TEL_ETC1, '
                             +'                      TEL_ETC2, '
                             +'                      CD_STORE_JOIN, '
                             +'                      PRG_INSERT, '
                             +'                      PRG_CHANGE) '
                             +'              values (:P0, '
                             +'                      :P1, '
                             +'                      :P2, '
                             +'                      :P3, '
                             +'                      :P4, '
                             +'                      :P5, '
                             +'                      :P6, '
                             +'                       Date_Format(Now(),''%Y%m%d''), '
                             +'                      :P7, '
                             +'                      :P8, '
                             +'                       AES_Encrypt(:P9,71483), '
                             +'                       AES_Encrypt(:P10,71483), '
                             +'                      :P11, '
                             +'                      :P12, '
                             +'                      :P13, '
                             +'                      :P14, '
                             +'                      :P15, '
                             +'                      :P16, '
                             +'                      :P17, '
                             +'                      :P18, '
                             +'                       Now(), '
                             +'                       AES_Encrypt(Right(:P9,4),71483), '
                             +'                       AES_Encrypt(Right(:P10,4),71483), '
                             +'                       GetChosung(:P3), '
                             +'                       Date_Format(Now(),''%Y%m%d''), '
                             +'                       :P19, '
                             +'                       :P20, '
                             +'                       :P21, '
                             +'                       :P22, '
                             +'                       :P23, '
                             +'                       ''POS'', '
                             +'                       ''POS'');',
                              'update MS_MEMBER '
                             +'   set NM_MEMBER    = :P3, '
                             +'       DS_SEX       = :P4, '
                             +'       DS_MEMBER    = :P5,'
                             +'       NO_CARD      = :P6, '
                             +'       YMD_BIRTH    = case when :P7 ='''' then YMD_BIRTH else :P7 end, '
                             +'       YN_LUNAR     = case when :P8 = '''' then YN_LUNAR else :P8 end, '
                             +'       TEL_HOME     = AES_Encrypt(:P9,71483), '
                             +'       TEL_MOBILE   = AES_Encrypt(:P10,71483), '
                             +'       NO_POST      = NO_POST, '
                             +'       ADDR1        = :P12, '
                             +'       ADDR2        = :P13, '
                             +'       YN_NEWS      = case when :P14 = '''' then YN_NEWS else :P14 end, '
                             +'       REMARK       = :P15, '
                             +'       NO_CASHRCP   = :P16, '
                             +'       CD_SAWON_CHG = :P17, '
                             +'       CD_DAMDANG   = CD_DAMDANG, '
                             +'       DT_CHANGE    = Now(), '
                             +'       TEL_HOME_SHORT   = AES_Encrypt(Right(:P9,4),71483), '
                             +'       TEL_MOBILE_SHORT = AES_Encrypt(Right(:P10,4),71483),'
                             +'       CHOSUNG      =GetChosung(:P3), '
                             +'       CD_COURSE    =:P19, '
                             +'       CD_LOCAL     =:P20, '
                             +'       TEL_ETC1     =:P21, '
                             +'       TEL_ETC2     =:P22, '
                             +'       PRG_CHANGE   =''POS'' '
                             +' where CD_HEAD   =:P0 '
                             +'   and CD_STORE  =:P1 '
                             +'   and CD_MEMBER =:P2; '),
                             [Config.HeadStoreCode,
                              Ifthen(GetHeadOption(5)='0',Config.StoreCode,StandardStore),
                              vMemberCode,
                              aName,
                              aGender,
                              aDsMember,
                              aCardNo,
                              aBirthDay,
                              aLunar,
                              aHomeTel,
                              aMobileTel,
                              aPost,
                              aAddr1,
                              aAddr2,
                              aNews,
                              aRemark,
                              aCashRcpNo,
                              Common.Config.UserCode,
                              aDamdangCode,
                              aCourse,
                              aLocal,
                              aEtcTel1,
                              aEtcTel2,
                              Config.StoreCode],false,Common.RestDBURL);
    DM.ExecCloud('update MS_MEMBER_ETC '
                +'   set YN_TRUST  =:P3 '
                +' where CD_HEAD   =:P0 '
                +'   and CD_STORE  =:P1 '
                +'   and CD_MEMBER =:P2; ',
                [Config.HeadStoreCode,
                 Config.StoreCode,
                 vMemberCode,
                 aTrust],false,Common.RestDBURL);

    //회원가입시 포인트적립
    if aNew then
    begin
      DM.OpenCloud('select a.JOINPOINTCODE,  '
                  +'       Ifnull(b.NM_CODE2, 0) as OCCUR_POINT '
                  +'  from MS_STORE a left outer join '
                  +'       MS_CODE   b on a.CD_STORE      = b.CD_STORE '
                  +'                  and a.JOINPOINTCODE = b.CD_CODE '
                  +'                  and b.CD_KIND       = ''12'' '
                  +'                  and b.DS_STATUS     = ''0'' '
                  +' where a.CD_HEAD  =:P0 '
                  +'   and a.CD_STORE =:P1 ',
                  [Common.Config.HeadStoreCode,
                   Common.Config.StoreCode],Common.RestDBURL);

      if DM.CloudData.Fields[0].AsString <> '' then
      begin
        vCode  := DM.CloudData.Fields[0].AsString;
        vPoint := DM.CloudData.Fields[1].AsInteger;
        DM.CloudData.Close;

        DM.ExecCloud('insert into SL_POINT(CD_HEAD,'
                    +'                     CD_STORE, '
                    +'                     YMD_OCCUR, '
                    +'                     NO_POS, '
                    +'                     SEQ, '
                    +'                     CD_MEMBER, '
                    +'                     CD_CODE,'
                    +'                     AMT_CASH,'
                    +'                     PNT_CASH,'
                    +'                     AMT_CARD,'
                    +'                     PNT_CARD,'
                    +'                     AMT_CASHRCP,'
                    +'                     PNT_CASHRCP,'
                    +'                     REMARK,'
                    +'                     AMT_EXCLUDE,'
                    +'                     RCP_LINK, '
                    +'                     CD_SAWON_CHG,'
                    +'                     DT_CHANGE) '
                    +'              values(:P0, '
                    +'                     :P1, '
                    +'                     :P2, '
                    +'                     ''00'', '
                    +'                     (select ifnull(max(SEQ),0)+1 '
                    +'                        from SL_POINT as i'
                    +'                       where CD_HEAD  =:P0 '
                    +'                         and CD_STORE =:P1 '
                    +'                         and YMD_OCCUR=:P2 '
                    +'                         and NO_POS   =''00''), '
                    +'                     :P3, '
                    +'                     :P4, '
                    +'                      0, '
                    +'                     :P5, '
                    +'                      0, '
                    +'                      0, '
                    +'                      0, '
                    +'                      0, '
                    +'                     :P6, '
                    +'                      0, '
                    +'                     '''', '
                    +'                     :P7,'
                    +'                      Now());',
                    [Config.HeadStoreCode,
                     Config.StoreCode,
                     NowDate,
                     vMemberCode,
                     vCode,
                     vPoint,
                     '',
                     Config.UserCode],false,Common.RestDBURL);

      end;

      //회원가입 시 문자발송
      if (GetOption(367) = '1') and (aMobileTel <> '') then
      begin
        OpenQuery('select NM_CODE2 '
                 +'  from MS_CODE '
                 +' where CD_STORE  =:P0 '
                 +'   and CD_KIND   =''18'' '
                 +'   and NM_CODE3  =''2'' '
                 +'   and DS_STATUS = ''0'' '
                 +' limit 1 ',
                 [Config.StoreCode]);

        vTemp := Format('안녕하세요, %s님.'#13'%s에 회원가입이 완료되었습니다.'#13'진심으로 감사드립니다.',[Ifthen(aName='', aMobileTel,aName), Common.Config.StoreName]);
        if not Common.Query.Eof then
        begin
          vTemp := vTemp + #13 + #13 + Query.Fields[0].AsString;
          Common.KakaoSendMessage('M',[Format('%s -%s-',[vTemp, Common.Config.StoreName])],
                                aMobileTel);
        end;
        Query.Close;
      end;
    end;

    if not DM.ExecCloud(DM.TempSQL,[],true,Common.RestDBURL) then Exit;

    //서버에서 저장한 회원정보를 로컬디비에 다운로드
    //MS_MEMBER
    if GetHeadOption(5)='0' then
      DM.OpenCloud('select '+Format('''%s'' as CD_STORE, ',[Config.StoreCode])
                  +'       a.CD_MEMBER,a.NM_MEMBER,a.CHOSUNG,a.DS_SEX,a.DS_MEMBER,a.NO_CARD,a.CD_AGE,a.TEL_ETC1,a.TEL_ETC2,a.TEL_JOB,a.NO_POST,a.ADDR1,a.ADDR2,b.YN_TRUST,a.NM_EMAIL,'
                  +'       a.CD_STORE_JOIN,a.YN_NEWS,a.NO_CASHRCP,a.CD_DAMDANG,a.CD_LOCAL,a.CD_COURSE,b.TOTAL_POINT,a.DS_STATUS,a.REMARK,b.TOTAL_STAMP,a.YMD_BIRTH,a.YMD_MARRI,a.YMD_ISU,b.AMT_TRUST, '
                  +'       b.YMD_VISIT, b.CNT_VISIT, b.AMT_SALE, '
                  +'       AES_Decrypt(a.TEL_HOME,   71483) as TEL_HOME, '
                  +'       AES_Decrypt(a.TEL_MOBILE, 71483) as TEL_MOBILE '
                  +'  from MS_MEMBER a inner join '
                  +'       MS_MEMBER_ETC as b on b.CD_HEAD   = a.CD_HEAD '
                  +'                         and b.CD_STORE  = a.CD_STORE '
                  +'                         and b.CD_MEMBER = a.CD_MEMBER '
                  +' where a.CD_HEAD  =:P0 '
                  +'   and a.CD_STORE =:P1 '
                  +'   and a.CD_MEMBER =:P2 ',
                  [Config.HeadStoreCode,
                   Config.StoreCode,
                   vMemberCode],Common.RestDBURL)
   else
      DM.OpenCloud('select '+Format('''%s'' as CD_STORE, ',[Config.StoreCode])
                  +'       a.CD_MEMBER,a.NM_MEMBER,a.CHOSUNG,a.DS_SEX,a.DS_MEMBER,a.NO_CARD,a.CD_AGE,a.TEL_ETC1,a.TEL_ETC2,a.TEL_JOB,a.NO_POST,a.ADDR1,a.ADDR2,c.YN_TRUST,a.NM_EMAIL,'
                  +'       a.CD_STORE_JOIN,a.YN_NEWS,a.NO_CASHRCP,a.CD_DAMDANG,a.CD_LOCAL,a.CD_COURSE,b.TOTAL_POINT,a.DS_STATUS,a.REMARK,b.TOTAL_STAMP,a.YMD_BIRTH,a.YMD_MARRI,a.YMD_ISU,c.AMT_TRUST, '
                  +'       c.YMD_VISIT, c.CNT_VISIT, c.AMT_SALE, '
                  +'       AES_Decrypt(a.TEL_HOME,   71483) as TEL_HOME, '
                  +'       AES_Decrypt(a.TEL_MOBILE, 71483) as TEL_MOBILE '
                  +'  from MS_MEMBER a inner join '
                  +'       MS_MEMBER_ETC as b on b.CD_HEAD   = a.CD_HEAD '
                  +'                         and b.CD_STORE  = a.CD_STORE '
                  +'                         and b.CD_MEMBER = a.CD_MEMBER left outer join '
                  +'       MS_MEMBER_ETC as c on c.CD_HEAD   = a.CD_HEAD '
                  +'                         and c.CD_STORE  = :P3 '
                  +'                         and c.CD_MEMBER = a.CD_MEMBER '
                  +' where a.CD_HEAD   =:P0 '
                  +'   and a.CD_STORE  =:P1 '
                  +'   and a.CD_MEMBER =:P2 ',
                  [Config.HeadStoreCode,
                   StandardStore,
                   vMemberCode,
                   Config.StoreCode],Common.RestDBURL);

   vTemp := Format('delete from MS_MEMBER where CD_STORE =''%s'' and CD_MEMBER =''%s'';',[Common.Config.StoreCode, vMemberCode]);
   vTemp := vTemp + DM.GetCloudData('MS_MEMBER');
   if vTemp <> '' then
   begin
     DM.StoredProc.Close;
     DM.StoredProc.StoredProcName := 'MULTI_EXECUTE';
     DM.StoredProc.PrepareSQL;
     DM.StoredProc.ParamByName('_SQL').AsString := vTemp;
     DM.StoredProc.ExecProc;
     SelectMemberInfo(vMemberCode,'','');
   end;
   Result := true;
except
    on E: Exception do
    begin
      Common.WriteLog('SaveMemberAdd',E.Message);
      Common.ErrBox(E.Message+#13#13+'저장을 완료하지 못했습니다');
      Exit;
    end;
  end;

end;

procedure TCommon.SetPNGImage(aButton:TObject; aFileName:String);
var vPNG :TPNGImage;
begin
  try
    if FileExists(aFileName) then
      try
        vPNG := TPNGImage.Create;
        if aButton is TcxButton then
        begin
          vPNG.LoadFromFile(aFileName);
          TcxButton(aButton).Height := vPNG.Height;
          TcxButton(aButton).Width  := vPNG.Width;
          TcxButton(aButton).OptionsImage.Glyph.Assign(vPNG);
          TcxButton(aButton).Caption := '';
          TcxButton(aButton).SpeedButtonOptions.Transparent  := true;
        end
        else if aButton is TAdvSmoothButton then
        begin
          vPNG.LoadFromFile(aFileName);
          if (TAdvSmoothButton(aButton).Tag =99) or (Common.KioskConfig[13] = 0) then
          begin
            TAdvSmoothButton(aButton).Height := vPNG.Height;
            TAdvSmoothButton(aButton).Width  := vPNG.Width;
            TAdvSmoothButton(aButton).Caption := '';
            TAdvSmoothButton(aButton).Color   := clWhite;
            if TAdvSmoothButton(aButton).Tag <> 99 then
              TAdvSmoothButton(aButton).Appearance.Rounding   := 0;
            TAdvSmoothButton(aButton).Appearance.Layout     := blNone;
          end;
          TAdvSmoothButton(aButton).Picture.LoadFromFile(aFileName);
        end
        else if aButton is TImage then
        begin
          TImage(aButton).Picture.LoadFromFile(aFileName);
        end
        else if aButton is TcxImage then
        begin
          TcxImage(aButton).Picture.LoadFromFile(aFileName);
        end;
      finally
        vPNG.free;
      end;
  except
    MsgBox(Format('%s 화일'#13'PNG 형식이 올바르지 않습니다',[aFileName]));
  end;
end;

function TCommon.GetProcess(aFileName:String): Cardinal;
var
  vProcess32: TProcessEntry32;
  vHandle:    THandle;   // the handle of the Windows object
  vNext:         BOOL;
begin
  vProcess32.dwSize := SizeOf(TProcessEntry32);
  vHandle           := CreateToolHelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  Result            := 0;
  if Process32First(vHandle, vProcess32) then
  begin
    // 실행화일명 체크
    if UpperCase(vProcess32.szExeFile) = UpperCase(aFileName) then
    begin
      Result := vProcess32.th32ProcessID;
    end;

    repeat
      vNext := Process32Next(vHandle, vProcess32);
      if vNext then
      begin
        if UpperCase(vProcess32.szExeFile) = UpperCase(aFileName) then
        begin
          Result := vProcess32.th32ProcessID;
          Break;
        end;
      end;
    until not vNext;
    CloseHandle(vHandle);   // closes an open object handle
  end;
end;

function TCommon.isMemberCardNo(aCardNo: String): Boolean;
  function  GetCardNo(const S : String): String;        // 숫자와 알파벳만 골라낸다
  var vIndex :Integer;
  begin
     For vIndex := 1 to Length(S) do
     begin
       case S[vIndex] of
          #48..#57: Result := Result + S[vIndex];
          #65..#90: Result := Result + S[vIndex];
          #97..#122: Result := Result + S[vIndex];
       end;
     end;
  end;
var vTemp :String;
begin
  vTemp  := GetCardNo(aCardNo);
  //회원프리픽스하고 같으면
  if  (vTemp <> EmptyStr)
    and (((Length(vTemp) = Config.len_card)  and (Config.MemberPreFix = LeftStr(vTemp, Length(Config.MemberPreFix))) )
     or  ((Length(vTemp)  = Config.len_card2) and (Config.MemberPreFix2 = LeftStr(vTemp, Length(Config.MemberPreFix2))) ) ) then
    Result := true
  else
    Result := false;
end;

function TCommon.SMSSendMessage(aMessage, aRcvTel:String; aErrTitle: String):Boolean;
var vSendDate :String;
begin
  if aRcvTel = '' then
    aRcvTel := Config.StoreMobile[1];

  vSendDate := FormatDateTime('yyyy-mm-dd hh:nn:ss', now());
  Result := DM.ExecCloudProcedure(Format('CALL PROC_SMSSEND(''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ?) ',
                                        [Common.Config.StoreCode,
                                         aMessage,
                                         GetOnlyNumber(Config.StoreTel),
                                         GetOnlyNumber(aRcvTel),
                                         vSendDate]),aErrTitle);
end;

//aTemplate, aMessage, aRcvTel:String;
function TCommon.KaKaoSendMessage(aTemplate:String; aMessage: array of Variant; aRcvTel:String;aErrTitle:String):Boolean;
var vSendDate, vSubject, vMessage, vTemplate, vWaitCancelTime, vTempMsg :String;
    vIndex :Integer;
begin
  if (aRcvTel = '') and (Config.StoreMobile.Count > 0 ) then
    aRcvTel := Config.StoreMobile[0];

  vTempMsg := aMessage[0];

  if aTemplate = 'J' then
  begin
    vSubject  := '회원가입';
    vMessage  := vTempMsg;
    vTemplate := aTemplate;
  end
  else if aTemplate = 'L' then
  begin
    vSubject := '픽업 안내';
    vMessage := Config.StoreName+#13'고객님이 주문하신 메뉴가 준비되었습니다.'#13#13'카운터에서 픽업해 주세요.'#13#13'◎ 주문번호 : '+vTempMsg +#13#13'이용해 주셔서 감사합니다.';
    vTemplate := 'L';
    vSendDate := '';
  end
  else if (aTemplate = 'CL') or (aTemplate = 'CE') then
  begin
    vSubject := '픽업 안내';
    vMessage := Config.StoreName+#13'고객님이 주문하신 메뉴가 준비되었습니다.'#13#13'카운터에서 픽업해 주세요.'#13#13'◎ 호출번호 : '+vTempMsg +#13#13'이용해 주셔서 감사합니다.';
    vTemplate := aTemplate;
    vSendDate := '';
  end
  else if aTemplate = 'C2' then
  begin
    vSubject  := '픽업 안내';
    vMessage  := vTempMsg;
    vTemplate := aTemplate;
    vSendDate := '';
  end
  else if aTemplate = 'CN' then
  begin
    vSubject := '픽업 안내';
    vMessage := Config.StoreName+#13'고객님이 주문하신 메뉴가'#13'준비되었습니다.'#13#13+
                                    '아래 장소에서 픽업해 주세요'#13+
                                    '■ 픽업장소 : '+aMessage[1]+#13#13+'◎ 호출번호 : '+vTempMsg +#13#13'이용해 주셔서 감사합니다.';
    vTemplate := aTemplate;
    vSendDate := '';
  end

  else if aTemplate = 'P' then
  begin
    vSubject := 'POS 알림 메시지입니다';
    vMessage := 'POS 알림 메시지입니다'#13#13+vTempMsg+#13+Format('[%s]',[FormatDateTime(fmtDateTime, Now())])+ #13#13+Format('본 알림톡은 %s의 관리자에게만 보내는 서비스 입니다.',[Common.Config.StoreName]);
    vTemplate := 'P';
  end
  else if aTemplate = 'M' then
  begin
    vSubject := '회원가입 인증';
    vMessage := vTempMsg;
    vTemplate := 'M';
  end
  else if aTemplate = 'K' then
  begin
    vSubject := '키오스크 알림 메시지입니다';
    vMessage := '키오스크 알림 메시지입니다'#13#13+vTempMsg+#13+Format('[%s]',[FormatDateTime(fmtDateTime, Now())])+#13#13+Format('본 알림톡은 %s의 관리자에게만 보내는 서비스 입니다.',[Common.Config.StoreName]);
  end
  else if (aTemplate = 'WT') then
  begin
    vSubject  := '대기접수 안내';
    vTemplate := aTemplate;
  end
  else if (aTemplate = 'WN') then
  begin
    vSubject  := '대기접수 안내';
    vTemplate := aTemplate;
  end
  else if (aTemplate = 'WC') then
  begin
    case StoI(GetOption(309)) of
      0 : vWaitCancelTime := '5';
      1 : vWaitCancelTime := '10';
      2 : vWaitCancelTime := '15';
    end;
    vSubject  := '대기호출 안내';
    vMessage  := Config.StoreName+'에 지금 바로 입장해주세요!!'+#13#13
                +vWaitCancelTime+'분 동안 입장하지 않을경우, 대기접수가 자동 취소되며 다시 대기 등록을'
                +' 해 주셔야 하니 참고 부탁드립니다.'+#13#13
                +vTempMsg;
    vTemplate := aTemplate;
    vSendDate := '';
  end
  else if aTemplate = 'PN' then
  begin
    vSubject := '회원 포인트 적립/사용 안내';
    vMessage := Config.StoreName+#13#13
               +Member.Name+' 고객님'#13
               +'오늘도 이용해 주셔서 감사합니다.'#13#13
               +'■ 적립 포인트: '+aMessage[0]+' P'+#13
               +'■ 사용 포인트: '+aMessage[1]+' P'+#13
               +'■ 잔여 포인트: '+aMessage[2]+' P'+#13#13
               +'■ 매장 전화: '+SetTelephone(Config.StoreTel)+#13#13
               +'※ 이 메시지는 포인트 적립에 동의한 회원에게 발송되는 알림톡 입니다.';
  end
  else if aTemplate = 'O' then
  begin
    vSubject := '주문 접수 안내';
    vMessage := Common.Config.StoreName + #13+ aMessage[0];
  end
  else if aTemplate = 'O2' then
  begin
    vSubject := '주문 접수 안내';
    vMessage := Common.Config.StoreName + #13+ aMessage[0];
  end
  else if aTemplate = 'PT' then
  begin
    vSubject := '주문 접수 안내';
    vMessage := aMessage[0];
  end;

  vSendDate := FormatDateTime('yyyy-mm-dd hh:nn:ss', now());
  if aTemplate = 'K' then
  begin
    if Config.KioskKaKaoTel.Count = 0 then
    begin
//      ShowMessage('알림톡을 받을 전화번호가'#13'등록되어 있지 않습니다');
      Exit;
    end;
    for vIndex := 0 to Config.KioskKaKaoTel.Count-1 do
    begin
      if Config.KioskKaKaoTel[vIndex] = '' then Continue;

      Result := DM.ExecCloudProcedure(Format('CALL PROC_KAKAOSEND(''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ?) ',
                                            [Common.Config.StoreCode,
                                             'K',
                                             vSubject,
                                             vMessage,
                                             GetOnlyNumber(Config.StoreTel),
                                             GetOnlyNumber(Config.KioskKaKaoTel[vIndex]),
                                             vSendDate]), aErrTitle);
    end;
  end
  else if (aTemplate = 'PN') then
  begin
    Result := DM.ExecCloudProcedure(Format('CALL PROC_KAKAOSEND(''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ?) ',
                                          [Common.Config.StoreCode,
                                           'PN',
                                           vSubject,
                                           vMessage,
                                           GetOnlyNumber(Config.StoreTel),
                                           GetOnlyNumber(aRcvTel),
                                           vSendDate]), aErrTitle);

  end

  else if (aTemplate = 'WT') or (aTemplate = 'WN') then
  begin
    Result := DM.ExecCloudProcedure(Format('CALL PROC_WAIT_KAKAOSEND(''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'',''%s'',''%s'',''%s'',''%s'', ?) ',
                                          [Common.Config.StoreCode,
                                           Common.Config.StoreName,
                                           vTemplate,
                                           vSubject,
                                           aMessage[0],                      //대기번호
                                           aMessage[1],                      //대기인원
                                           aMessage[2],                      //대기팀
                                           aMessage[3],                      //대기시간
                                           aMessage[4],                      //렛츠오더URL
                                           GetOnlyNumber(Config.StoreTel),
                                           GetOnlyNumber(aRcvTel)]),
                                           aErrTitle);

  end
  else if aTemplate = 'O' then
  begin
    Result := DM.ExecCloudProcedure(Format('CALL PROC_LETSORDER_RECEIPT_KAKAOSEND(''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'' ,?) ',
                                   [Common.Config.StoreCode,
                                    vSubject,
                                    vMessage,
                                    aMessage[1], // aReceiptMsg,
                                    aMessage[2], //aReceiptNo,
                                    GetOnlyNumber(Common.Config.StoreTel),
                                    GetOnlyNumber(aRcvTel)]));

  end
  else if aTemplate = 'PT' then
  begin
    Result := DM.ExecCloudProcedure(Format('CALL PROC_PICKUP_RECEIPT_KAKAOSEND(''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'' ,?) ',
                                   [Common.Config.StoreCode,
                                    vSubject,
                                    vMessage,
                                    aMessage[1], //aReceiptMsg,
                                    aMessage[2], //aReceiptNo,
                                    GetOnlyNumber(Common.Config.StoreTel),
                                    GetOnlyNumber(aRcvTel)]));

  end
  else
  begin
    Result := DM.ExecCloudProcedure(Format('CALL PROC_KAKAOSEND(''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ?) ',
                                          [Common.Config.StoreCode,
                                           vTemplate,
                                           vSubject,
                                           vMessage,
                                           GetOnlyNumber(Config.StoreTel),
                                           GetOnlyNumber(aRcvTel),
                                           vSendDate]),  //예약일시
                                           aErrTitle);
  end;
end;

function TCommon.KioskLogFormat(aData: AnsiString): String;
var vIndex :Integer;
    vTemp  :String;
begin
  Result := EmptyStr;
  vTemp  := StringToHex(aData);
  for vIndex:=1 to Length(vTemp) div 2 do
    Result := Result + Format('%s ',[Copy(vTemp, vIndex*2-1, 2)]);

  Result := LowerCase(Result);
end;

function TCommon.PosAutoCloseOpen:Boolean;
var vResult,
    vWorkDate,
    vOpenDate,
    vLastDate :String;
begin
  Result       := false;
  vOpenDate := '';
  //개점일자를 구한다
  OpenQuery(Query, 'select Max(YMD_CLOSE) '
                  +'  from SL_POSCLOSE '
                  +' where CD_STORE	  =:P0 '
                  +'   and NO_POS     =:P1 '
                  +'   and DS_STATUS  =''O'' ',
                  [Config.StoreCode,
                   Config.PosNo]);

  if not Query.Eof then
  begin
    WorkDate  := Query.Fields[0].AsString;
    vWorkDate := WorkDate;
  end
  else
    WorkDate := '';
  Query.Close;

  //자동마감 시간이 12시 이전일때
  if (WorkDate <> '') and (GetOption(375) = '1') and (Config.PosCloseTime < FormatDateTime('hhnn', Now())) then
  begin
    if (Config.PosCloseTime <= '1200') and (WorkDate < FormatDateTime('yyyymmdd', Now())) then
    begin
      WorkDate := '';
    end
    else if (Config.PosCloseTime > '1200') and (WorkDate = FormatDateTime('yyyymmdd', Now())) then
    begin
      WorkDate := '';
    end;
  end
  else if (WorkDate <> '') and (GetOption(375) = '1') then
  begin
    if (Config.PosCloseTime <= '1200') and (WorkDate < FormatDateTime('yyyymmdd', IncDay(Now(),-1))) then
    begin
      WorkDate := '';
      vOpenDate := FormatDateTime('yyyymmdd', Now());
    end
    else if (Config.PosCloseTime > '1200') and (WorkDate < FormatDateTime('yyyymmdd', Now())) then
    begin
      WorkDate  := '';
      vOpenDate := FormatDateTime('yyyymmdd', Now());
    end;
  end
  else if (WorkDate <> '') and (GetOption(375) = '0') then
  begin
    if WorkDate < FormatDateTime('yyyymmdd', Now()) then
      WorkDate := '';
  end
  else if (WorkDate = '') and (GetOption(375) = '1') and (Config.PosCloseTime > '1200') then
  begin
    OpenQuery(Query, 'select Max(YMD_CLOSE) '
                    +'  from SL_POSCLOSE '
                    +' where CD_STORE	  =:P0 '
                    +'   and NO_POS     =:P1 '
                    +'   and DS_STATUS  =''C'' ',
                    [Config.StoreCode,
                     Config.PosNo]);

     if not Query.Eof then
      vLastDate := Query.Fields[0].AsString
    else
      vLastDate := '';
    Query.Close;

    if (vLastDate = '') or (vLastDate < FormatDateTime('yyyymmdd', Now())) then
      vOpenDate := FormatDateTime('yyyymmdd', Now());
  end;

  if WorkDate = '' then
  begin
    DM.StoredProc.StoredProcName := 'POS_SAVE_AUTO_CLOSE';
    DM.StoredProc.PrepareSQL;
    DM.StoredProc.ParamByName('_CD_STORE').Value    := Config.StoreCode;
    DM.StoredProc.ParamByName('_NO_POS').Value      := Config.PosNo;
    DM.StoredProc.ParamByName('_YMD_CLOSE').Value   := vWorkDate;
    DM.StoredProc.ExecProc;
    vResult := DM.StoredProc.ParamByName('_RESULT').Value;
    if vResult <> 'OK' then
    begin
      Common.WriteLog('work', '포스가 개점되지 않았습니다'+vResult);
      raise Exception.Create('포스가 개점되지 않았습니다'+vResult)
    end
    else
    begin
      if (GetOption(375) = '1') then
      begin
        if (Config.PosCloseTime <= '12:00') then
          WorkDate := FormatDateTime('yyyymmdd', Now())
        else
        begin
          if vOpenDate = '' then
            WorkDate := FormatDateTime('yyyymmdd', IncDay(Now(),1))
          else
            WorkDate := vOpenDate;
        end;
      end
      else
        WorkDate := FormatDateTime('yyyymmdd', Now());

      ExecQuery('insert into SL_POSCLOSE(CD_STORE, YMD_CLOSE, NO_POS, DT_CHANGE, DS_STATUS) '
               +'                 values(:P0, :P1, :P2, NULL, ''O'') '
               +'ON DUPLICATE KEY UPDATE DS_STATUS = ''O'', '
               +'                        DT_CHANGE = Now() ',
               [Config.StoreCode,
                WorkDate,
                Config.PosNo]);

      Common.OpenDate         := WorkDate;
      Common.WorkDate         := WorkDate;
      Common.WriteLog('work', Format('자동마감 :%s,%s',[vWorkDate,WorkDate]));

      //주문번호 초기화
      if (Common.Config.MainPosNo = Common.Config.PosNo) and (GetOption(43) = '1') then
        ExecQuery('delete '
                 +'  from MS_ORDERNO '
                 +' where CD_STORE =:P0 '
                 +'   and DS_NUMBER =''O'' '
                 +'   and NO_POS    =''00'' ',
                 [Common.Config.StoreCode]);

      if Config.OriginalPosNo = Config.PosNo then
        Common.LastCloseDate := vWorkDate;
      Result       := true;
    end;
  end;
end;

procedure TCommon.KioskTouchBeep(aCode: String);
begin
  if not Common.Config.IsKiosk or Config.notKioskTouch then Exit;

  PlaySound(nil, 0, SND_MEMORY or SND_ASYNC);
  PlaySound(PChar(aCode), Common.DllHandle, SND_RESOURCE or SND_ASYNC);
end;

function TCommon.KioskAutoOpen:Boolean;
  procedure GetOpenCheck;
  begin
    try
      DM.StoredProc.StoredProcName := 'POS_SELECT_OPENCHECK';
      DM.StoredProc.PrepareSQL;
      DM.StoredProc.ParamByName('_CD_STORE').Value := Config.StoreCode;
      DM.StoredProc.ParamByName('_NO_POS').Value   := Config.PosNo;
      DM.StoredProc.ExecProc;

      WorkDate             := NVL(DM.StoredProc.ParamByName('_YMD_OPEN').Value,'');
      OpenDate             := WorkDate;
      LastCloseDate        := NVL(DM.StoredProc.ParamByName('_YMD_CLOSE').Value,'');
      DM.StoredProc.Close;
    except
      on E: Exception do
      begin
        Common.WriteLog('GetOpenCheck',E.Message);
      end;
    end;
  end;
var vTemp,
    vOpenDate,
    vResult :String;
begin
  Result := false;
  GetOpenCheck;

  //키오스크가 메인포스일때
  if (GetOption(416) = '1') and (Config.MainPosNo = Config.PosNo) then
  begin
    if WorkDate < NowDate then
    begin
      try
        BeginTran;
        DM.StoredProc.StoredProcName := 'POS_SAVE_AUTO_CLOSE';
        DM.StoredProc.PrepareSQL;
        DM.StoredProc.ParamByName('_CD_STORE').Value := Common.Config.StoreCode;
        DM.StoredProc.ParamByName('_NO_POS').Value   := Common.Config.PosNo;
        DM.StoredProc.ExecProc;
        vResult := DM.StoredProc.ParamByName('_RESULT').Value;
        if vResult <> 'OK' then
          raise Exception.Create(vResult);



        if LastCloseDate < NowDate then
          vOpenDate := NowDate
        else
          vOpenDate := DtoS(IncDay(StoD(LastCloseDate),1));

        SetDayOpen(vOpenDate);
        WorkDate := vOpenDate;
        OpenDate := vOpenDate;
        CommitTran;
        GetOpenCheck;
        Common.WriteLog('work', Format('Kiosk 자동개점(%s, %s)',[WorkDate, Config.PosNo]));
        WriteLog('work', Format('로그인(%s)(%s)',[Common.Config.UserCode,GetFileVersion(Application.ExeName)]));
        Result := true;
      except
        on E: Exception do
        begin
          WriteLog('KioskAutoOpen',E.Message);
          Common.RollbackTran;
        end;
      end;
    end
    else
      Result := true;
  end
  //메인포스에 개점을 체크한다
  else if (GetOption(416) = '1') then
  begin
    OpenQuery('select Max(YMD_CLOSE) '
             +'  from SL_POSCLOSE '
             +' where CD_STORE  =:P0 '
             +'   and NO_POS    =:P1 '
             +'   and DS_STATUS =''O'' '
             +' order by YMD_CLOSE '
             +' limit 1 ',
             [Config.StoreCode,
              Config.MainPosNo]);
    //메인포스 개점일자와 키오스크 개점일자가 같으면 패스
    if not Query.Eof and (WorkDate <> '') and (Query.Fields[0].AsString <= WorkDate) then
    begin
      Result := true;
      Query.Close;
    end
    //메인포스보다 키오스크 개점일자가 이전일때
    else if not Query.Eof and ((WorkDate = '') or (Query.Fields[0].AsString > WorkDate)) then
    begin
      vOpenDate := Query.Fields[0].AsString;
      Query.Close;
      if (WorkDate <> '') then
        ExecQuery('delete '
                 +'  from SL_POSCLOSE '
                 +' where CD_STORE =:P0 '
                 +'   and NO_POS   =:P1 '
                 +'   and DS_STATUS = ''O'' '
                 +'   and YMD_CLOSE not in (select YMD_SALE '
                 +'                           from SL_SALE_H '
                 +'                          where CD_STORE =:P0 '
                 +'                            and NO_POS   =:P1 '
                 +'                            and YMD_SALE =:P2 '
                 +'                          group by YMD_SALE) ',
                 [Config.StoreCode,
                  Config.PosNo,
                  WorkDate]);

      DM.StoredProc.StoredProcName := 'POS_SAVE_AUTO_CLOSE';
      DM.StoredProc.PrepareSQL;
      DM.StoredProc.ParamByName('_CD_STORE').Value := Config.StoreCode;
      DM.StoredProc.ParamByName('_NO_POS').Value   := Config.PosNo;
      DM.StoredProc.ExecProc;
      vResult := DM.StoredProc.ParamByName('_RESULT').Value;
      if vResult <> 'OK' then
        raise Exception.Create(vResult);

      ExecQuery('insert into SL_POSCLOSE(CD_STORE, '
               +'                        YMD_CLOSE, '
               +'                        NO_POS, '
               +'                        DS_STATUS, '
               +'                        DT_INSERT, '
               +'                        DT_CHANGE) '
               +'                 values(:P0, '
               +'                        :P1, '
               +'                        :P2, '
               +'                        ''O'', '
               +'                        Now(), '
               +'                        NULL) '
               +'on duplicate key update DS_STATUS = ''O'' ',
               [Common.Config.StoreCode,
                vOpenDate,
                Common.Config.PosNo]);


      GetOpenCheck;
      Common.WriteLog('work', Format('Kiosk 자동개점(%s, %s, %s)',[WorkDate, Config.MainPosNo, Config.PosNo]));
      Result := true;
    end
    //메인포스가 개점이 안됐을때
    else if WorkDate = '' then
    begin
      Common.MsgBox(Format('메인포스(%s)를 먼저 개점해야합니다',[Config.MainPosNo]));
      Exit;
    end
    else
      Result := true;
  end
  //메인포스에서 마감할때 자동마감
  else if (GetOption(416) = '2') then
  begin
    OpenQuery('select Max(YMD_CLOSE) '
             +'  from SL_POSCLOSE '
             +' where CD_STORE  =:P0 '
             +'   and NO_POS    =:P1 '
             +'   and DS_STATUS =''O'' '
             +' order by YMD_CLOSE '
             +' limit 1 ',
             [Config.StoreCode,
              Config.MainPosNo]);
    if not Query.Eof then
       vOpenDate := Query.Fields[0].AsString
    else
       vOpenDate := '';
    Query.Close;

    //메인포스보다 개점일자가 작을때 '', '20250122'
    if (vOpenDate <> '') and ((WorkDate < vOpenDate) or (WorkDate = '')) then
    begin
      OpenQuery('select DS_STATUS '
               +'  from SL_POSCLOSE '
               +' where CD_STORE  =:P0 '
               +'   and NO_POS    =:P1 '
               +'   and YMD_CLOSE =:P2 ',
               [Config.StoreCode,
                Config.PosNo,
                vOpenDate]);


      if not Query.Eof  and (Query.Fields[0].AsString = 'O') then
      begin
        Query.Close;
        LastCloseDate := WorkDate;
        WorkDate      := vOpenDate;
        OpenDate      := vOpenDate;
        Result := true;
      end
      else
      begin
        Query.Close;
        ExecQuery('insert into SL_POSCLOSE(CD_STORE, '
                 +'                        YMD_CLOSE, '
                 +'                        NO_POS, '
                 +'                        DS_STATUS, '
                 +'                        DT_INSERT, '
                 +'                        DT_CHANGE) '
                 +'                 values(:P0, '
                 +'                        :P1, '
                 +'                        :P2, '
                 +'                        ''O'', '
                 +'                        Now(), '
                 +'                        NULL) '
                 +'on duplicate key update DS_STATUS = ''O'' ',
                 [Common.Config.StoreCode,
                  vOpenDate,
                  Common.Config.PosNo]);
        GetOpenCheck;
        Common.WriteLog('work', Format('Kiosk 자동개점(%s, %s, %s)',[WorkDate, Config.MainPosNo, Config.PosNo]));
        Result := true;
      end;
    end
    else if vOpenDate = '' then
    begin
      Common.MsgBox(Format('메인포스(%s)를 개점해야합니다',[Config.MainPosNo]));
      Exit;
    end
    else
      Result := true;
  end
  else
    Result := true;
end;

procedure TCommon.KillTask(ExeFileName: string);
var
  Next     : BOOL;
  SHandle  : THandle;
  Process32: TProcessEntry32;
  ProcId   : DWORD;
begin
  Process32.dwSize := SizeOf(TProcessEntry32);
  SHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);

  if Process32First(SHandle, Process32) then
  begin
    repeat
      Next := Process32Next(SHandle, Process32);
      if Next then
      begin
        GetWindowThreadProcessID(SHandle, @ProcId);
        if Process32.szExeFile = ExeFileName then
        begin
          ProcId  := DWORD(Process32.th32ProcessID);
          SHandle := OpenProcess(PROCESS_ALL_ACCESS, TRUE, ProcId);
          TerminateProcess(SHandle, 0);
        end;
      end;
    until not Next;
  end;
  CloseHandle(SHandle);
end;

function TCommon.GetTaskHandle(ExeFileName: string):THandle;
var
  Next     : BOOL;
  SHandle  : THandle;
  Process32: TProcessEntry32;
  ProcId   : DWORD;
begin
  Process32.dwSize := SizeOf(TProcessEntry32);
  SHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);

  if Process32First(SHandle, Process32) then
  begin
    repeat
      Next := Process32Next(SHandle, Process32);
      if Next then
      begin
        GetWindowThreadProcessID(SHandle, @ProcId);
        if Process32.szExeFile = ExeFileName then
        begin
          ProcId  := DWORD(Process32.th32ProcessID);
          SHandle := OpenProcess(PROCESS_ALL_ACCESS, TRUE, ProcId);
          Result  := SHandle;
//          TerminateProcess(SHandle, 0);
        end;
      end;
    until not Next;
  end;
  CloseHandle(SHandle);
end;

function TCommon.SavePrintData(aPrintCode, aPrintData, aDamdang, aPosNo,
  aOrderTime: String; aPerson, aOrderNo: Integer): Boolean;
var vSeq :Integer;
begin
  try
    //결제변경일때는 SL_SALE_PRT에 저장한다
    if (Common.OrderKind <> okChange) and not Common.Config.IsTakeOut then
    begin
      OpenQuery('select Ifnull(max(SEQ),0) +1 '
               +'  from SL_ORDER_PRT '
               +' where CD_STORE	  =:P0 '
               +'   and NO_TABLE	  =:P1 '
               +'   and DS_ORDER	  =:P2 '
               +'   and NO_ORDER   	=:P3 '
               +'   and CD_PRINTER	=:P4 ',
               [Common.Config.StoreCode,
                Common.Table.Number,
                Common.Table.OrderType,
                aOrderNo,
                aPrintCode]);
      vSeq := Query.Fields[0].AsInteger;
      Query.Close;

      ExecQuery('insert into SL_ORDER_PRT(CD_STORE, '
               +'                					NO_TABLE, '
               +'                					DS_ORDER, '
               +'                					NO_ORDER, '
               +'                					CD_PRINTER, '
               +'                					SEQ, '
               +'                					PRINT_DATA, '
               +'                					NO_PERSON, '
               +'                					NM_DAMDANG, '
               +'                					ORDER_TIME, '
               +'                					NO_POS) '
               +'           			 values(:P0, '
               +'                					:P1, '
               +'                					:P2, '
               +'                					:P3, '
               +'                					:P4, '
               +'                					:P5, '
               +'                					:P6, '
               +'                					:P7, '
               +'                					:P8, '
               +'                					:P9, '
               +'                					:P10) ',
               [Common.Config.StoreCode,
                Common.Table.Number,
                Common.Table.OrderType,
                aOrderNo,
                aPrintCode,
                vSeq,
                aPrintData,
                aPerson,
                aDamdang,
                aOrderTime,
                Common.Config.PosNo]);
    end
    else
    begin
      OpenQuery('select Ifnull(max(SEQ),0) +1 '
               +'  from SL_SALE_PRT '
               +' where CD_STORE	  =:P0 '
               +'   and YMD_SALE    =:P1 '
               +'   and NO_POS      =:P2 '
               +'   and NO_RCP      =:P3 '
               +'   and NO_TABLE	  =:P4 '
               +'   and DS_ORDER	  =:P5 '
               +'   and NO_ORDER   	=:P6 '
               +'   and CD_PRINTER	=:P7 ',
               [Common.Config.StoreCode,
                Common.WorkDate,
                Common.Config.PosNo,
                Common.PreSent.RcpNo,
                Common.Table.Number,
                Common.Table.OrderType,
                aOrderNo,
                aPrintCode]);
      vSeq := Query.Fields[0].AsInteger;
      Query.Close;

      ExecQuery('insert into SL_SALE_PRT(CD_STORE, '
               +'                        YMD_SALE, '
               +'                        NO_POS, '
               +'                        NO_RCP, '
               +'                   		 NO_TABLE, '
               +'                   		 DS_ORDER, '
               +'                   		 NO_ORDER, '
               +'                   		 CD_PRINTER, '
               +'                   		 SEQ, '
               +'                   		 PRINT_DATA, '
               +'                   		 NO_PERSON, '
               +'                   		 NM_DAMDANG, '
               +'                   		 ORDER_TIME) '
               +'        			    values(:P0, '
               +' '''+Common.WorkDate+''', '
               +' :P10, '
               +' '''+Common.PreSent.RcpNo+''', '
               +'                   		 :P1, '
               +'                   		 :P2, '
               +'                   		 :P3, '
               +'                   		 :P4, '
               +'                   		 :P5, '
               +'                   		 :P6, '
               +'                   		 :P7, '
               +'                   		 :P8, '
               +'                   		 :P9) ',
               [Common.Config.StoreCode,
                Common.Table.Number,
                Common.Table.OrderType,
                aOrderNo,
                aPrintCode,
                vSeq,
                aPrintData,
                aPerson,
                aDamdang,
                aOrderTime,
                Common.Config.PosNo]);
    end;
    Result := True;
  except
    on E: Exception do
    begin
      Common.WriteLog('SavePrintData',E.Message);
      Result := false;
    end;
  end;
end;

function TCommon.isWindows64 : Boolean;
var
  vKernelModule      : HModule;
  vSystemInfo        : TSystemInfo;
  GetNativeSystemInfo: procedure(var lpSystemInfo: TSystemInfo); stdcall;
begin
  vKernelModule := GetModuleHandle(kernel32);
  try
    GetNativeSystemInfo := GetProcAddress(vKernelModule, 'GetNativeSystemInfo');
    if Assigned(GetNativeSystemInfo) then
    begin
      GetNativeSystemInfo(vSystemInfo);
      Result := (vSystemInfo.wProcessorArchitecture = 9) or // PROCESSOR_ARCHITECTURE_AMT64
                (vSystemInfo.wProcessorArchitecture = 6);   // PROCESSOR_ARCHITECTURE_IA64
    end;
  finally
    FreeLibrary(vKernelModule);
  end;
end;

function TCommon.PGCardCancel(aRcpNo,aTID :String; aCardAmt :Integer;aPart:Boolean):Boolean;
var vRestClient         :TRestClient;
    vRestRequest        :TRestRequest;
    vRESTResponse       :TRESTResponse;
    vIndex              :Integer;
    vJSONObject         :TJSONObject;
    vJSONTableArray     :TJSONArray;
    vSendDate :String;
    vHash : THashSHA2;
    vHashData :String;
    vJSONData : TStringList;
    vData :String;
    vCancelPWD :String;
    vPGMid, vPGMidKey :String;
    vParams :String;
begin
  Result := false;
  if not AskBox('렛츠오더에서 결제한 카드를'#13'취소하시겠습니까?') then Exit;

  if Config.PG_Cancel <> '' then
  begin
    vCancelPWD := ShowNumberForm('취소 암호를 입력하세요',20,0,'');
    if Config.PG_Cancel <> vCancelPWD then
    begin
      MsgBox('취소 암호가 맞지 않습니다');
      Exit;
    end;
  end;

  vPGMid    := Config.PG_Mid;
  vPGMidKey := Config.PG_MidKey;

  //KIS PG
  if GetOption(453) = '0' then
  begin
    try
      vSendDate   := FormatDateTime('yyyymmddhhnnss',Now());
      vHashData   := vHash.GetHashString(vPGMid+vSendDate+IntToStr(aCardAmt)+vPGMidKey,SHA256);
      vJSONObject := TJSONObject.Create;
      vJSONObject.AddPair('payMethod',  TJSONString.Create('card'));
      vJSONObject.AddPair('tid', TJSONString.Create(aTID));
      vJSONObject.AddPair('mid', TJSONString.Create(vPGMid));
      vJSONObject.AddPair('canAmt', TJSONNumber.Create(aCardAmt));
      vJSONObject.AddPair('refundBankCd', TJSONString.Create(Config.PG_BankCode));   //환불은행코드
      vJSONObject.AddPair('efundAccnt', TJSONString.Create(Config.PG_BankNo));       //환불계좌번호
      vJSONObject.AddPair('refundNm', TJSONString.Create(Config.PG_BankOwner));      //환불예금주명


      vJSONObject.AddPair('canMsg', TJSONString.Create('고객요청'));
      if not aPart then
        vJSONObject.AddPair('partCanFlg', TJSONString.Create('0'))
      else
        vJSONObject.AddPair('partCanFlg', TJSONString.Create('1'));
      vJSONObject.AddPair('encData', TJSONString.Create(vHashData));
      vJSONObject.AddPair('ediDate', TJSONString.Create(vSendDate));

      vRestRequest := TRestRequest.Create(nil);
      vRestClient  := TRestClient.Create(nil);
      if vPGMid = 'kistest00m' then
        vRestClient.BaseURL := 'https://testapi.kispg.co.kr/v2/cancel'
      else
        vRestClient.BaseURL := 'https://api.kispg.co.kr/v2/cancel';
      vRESTResponse := TRESTResponse.Create(vRestRequest);

      vRestRequest.Client   := vRestClient;
      vRestRequest.Response := vRESTResponse;
      vRestRequest.Accept   := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
      vRestRequest.AcceptCharset := 'UTF-8, *;q=0.8';
      vRestRequest.Method   := TRESTRequestMethod.rmPOST;
      vRESTRequest.AcceptEncoding := 'UTF-8';

      WriteLog('work','렛츠오더 취소[요청(KIS)]'+vJSONObject.ToJSON);
      vRESTRequest.AddBody(vJSONObject.ToJSON, TRESTContentType.ctAPPLICATION_JSON);
      vRESTRequest.Execute;

      vData := vRESTResponse.JSONText;
      WriteLog('work','렛츠오더 취소[응답]'+vData);
      vJSONObject := TJSONObject.ParseJSONValue( vData ) as TJSONObject;

      if (vJSONObject.GetValue<String>('resultCd') = '2001') then
      begin
        InitCardRecord(Card);
        Card.Ds_Card    := 'P';
        Card.Ds_trd     := dtCancel;
        Card.PG_TID     := vJSONObject.GetValue<String>('tid')+FormatDateTime('hhnnss',Now());
        Card.ApprovalNo := vJSONObject.GetValue<String>('appNo');
        Card.Trd_Date   := LeftStr(vJSONObject.GetValue<String>('appDtm'),8);
        Card.Trd_Time   := Copy(vJSONObject.GetValue<String>('appDtm'),9,4);
        Card.Amt        := aCardAmt;
        Result := true;

        if GetOption(166)='1' then
          For vIndex := 0 to Common.Config.StoreMobile.Count -1 do
            if Length(Common.Config.StoreMobile[vIndex]) >= 9 then
              Common.KakaoSendMessage('P',['렛츠오더취소'#13+
                                      Format('[%s]%s',[Card.Nm_Card, FormatFloat(',0원',Card.Amt)])],Common.Config.StoreMobile[vIndex]);

      end
      else
      begin
        ErrBox(Format('렛츠오더 카드취소실패[%s]'+#13+'%s',[vJSONObject.GetValue<String>('resultCd'),vJSONObject.GetValue<String>('resultMsg')]));
      end;
    except
      on E: Exception do
      begin
        Result := False;
        WriteLog('work','렛츠오더 카드취소'+E.Message);
        ErrBox(Format('렛츠오더 카드취소실패'+#13'%s',[E.Message]));
      end;
    end;
  end
  else // Nice PG
  begin
    try
      vSendDate   := FormatDateTime('yyyymmddhhnnss',Now());
      vHashData   := vHash.GetHashString(vPGMid+IntToStr(aCardAmt)+vSendDate+vPGMidKey,SHA256);

      vRestRequest                := TRestRequest.Create(nil);
      vRestClient                 := TRestClient.Create(nil);
      vRestRequest.Client         := vRestClient;
      vRESTResponse               := TRESTResponse.Create(vRestRequest);
      vRestRequest.Response       := vRESTResponse;
      vRestClient.BaseURL         := 'https://webapi.nicepay.co.kr/webapi/cancel_process.jsp';
      vRestClient.ContentType     := 'application/x-www-form-urlencoded; charset=UTF-8;';
      vRestRequest.Accept         := 'application/json';
      vRestRequest.AcceptEncoding := 'EUC-KR';
      vRestRequest.AcceptCharset  := 'UTF-8';
      vRestRequest.Method         := TRESTRequestMethod.rmPOST;

      vParams := Format('?TID=%s',[aTID]);
      vParams := vParams + Format('&MID=%s',[vPGMid]);
      vParams := vParams + Format('&Moid=%s',[Config.StoreCode+aRcpNo+vSendDate]);
      vParams := vParams + Format('&CancelAmt=%s',[IntToStr(aCardAmt)]);
      vParams := vParams + Format('&CancelMsg=%s',['거래취소']);
      vParams := vParams + Format('&PartialCancelCode=%s',[Ifthen(aPart,'1','0')]);
      vParams := vParams + Format('&SignData=%s',[vHashData]);
      vParams := vParams + Format('&EdiDate=%s',[vSendDate]);

      vRestClient.BaseURL := vRestClient.BaseURL + vParams;
      WriteLog('work','렛츠오더 취소[요청(NICE)]'+vParams);
      vRESTRequest.Execute;

      vData := vRESTResponse.JSONText;
      WriteLog('work','렛츠오더 취소[응답]'+vData);
      vJSONObject := TJSONObject.ParseJSONValue( vData ) as TJSONObject;

      if (vJSONObject.GetValue<String>('ResultCode') = '2001') then
      begin
        InitCardRecord(Card);
        Card.Ds_Card    := 'P';
        Card.Ds_trd     := dtCancel;
        Card.PG_TID     := vJSONObject.GetValue<String>('TID')+FormatDateTime('hhnnss',Now());
        Card.ApprovalNo := vJSONObject.GetValue<String>('CancelNum');
        Card.Trd_Date   := vJSONObject.GetValue<String>('CancelDate');
        Card.Trd_Time   := LeftStr(vJSONObject.GetValue<String>('CancelTime'),4);
        Card.Amt        := StrToInt(vJSONObject.GetValue<String>('CancelAmt'));;
        Result := true;

        if GetOption(166)='1' then
          For vIndex := 0 to Common.Config.StoreMobile.Count -1 do
            if Length(Common.Config.StoreMobile[vIndex]) >= 9 then
              Common.KakaoSendMessage('P',['렛츠오더취소'#13+
                                      Format('[%s]%s',[Card.Nm_Card, FormatFloat(',0원',Card.Amt)])],Common.Config.StoreMobile[vIndex]);
      end
      else
      begin
        if AskBox(Format('렛츠오더 카드취소실패[%s]'+#13+'%s',[vJSONObject.GetValue<String>('ErrorCD'),vJSONObject.GetValue<String>('ResultMsg')])
                  +#13+'취소처리 하시겠습니까?') then
        begin
          MsgBox('나이스페이먼츠 관리에서 취소해야합니다');
          InitCardRecord(Card);
          Card.Ds_Card    := 'P';
          Card.Ds_trd     := dtCancel;
          Card.PG_TID     := '';
          Card.ApprovalNo := '';
          Card.Trd_Date   := FormatDateTime('yyyymmdd',Now());
          Card.Trd_Time   := FormatDateTime('hhnnss',Now());
          Card.Amt        := aCardAmt;;
          Result := true;
        end;
      end;
    except
      on E: Exception do
      begin
        Result := False;
        WriteLog('work','렛츠오더 카드취소'+E.Message);
        ErrBox(Format('렛츠오더 카드취소실패'+#13'%s',[E.Message]));
      end;
    end;
  end;
end;

procedure TCommon.BellCall(aCallNo:Integer;aKitchenName:String);
var vCallNo :Integer;
    vReceiptNo, vTelNo, vTemp, vStatus :String;
begin
  if aCallNo = 0 then
  begin
    vTemp   := Common.ShowNumberForm('호출번호를 입력하세요',4,9999,'');
    if vTemp = 'mrClose' then Exit;

    vCallNo := StoI(vTemp);
  end
  else
    vCallNo := aCallNo;

  if vCallNo = 0 then Exit;

  OpenQuery('select NO_RECEIPT, '
           +'       TEL_MOBILE, '
           +'       DS_STATUS '
           +'  from MS_ORDERNO '
           +' where CD_STORE  = :P0 '
           +'   and DS_NUMBER = ''C'' '
           +'   and NO_POS    = ''00'' '
           +'   and NO_ORDER  = :P1 ',
           [Common.Config.StoreCode,
            vCallNo]);

  if Common.Query.Eof then
  begin
    if aCallNo = 0 then
      Common.MsgBox('등록되지 않은 번호입니다'#13'번호를 확인해주세요');
    Common.Query.Close;
    Exit;
  end;

  vStatus := '';
  vReceiptNo := Common.Query.Fields[0].AsString;
  vTelNo     := Common.Query.Fields[1].AsString;
  vStatus    := Common.Query.Fields[2].AsString;
  Common.Query.Close;
  //렛츠오더 주문건일때
  if (vReceiptNo <> '') then
  begin
    OpenQuery('select Max(TEL_MOBILE) as TEL_MOBILE, '
             +'       NO_RECEIPT, '
             +'       DS_STATUS '
             +'  from SL_LETSORDER '
             +' where CD_STORE   =:P0 '
             +'   and NO_RECEIPT =:P1 ',
             [Common.Config.StoreCode,
              vReceiptNo]);
    if Common.Query.Eof then
    begin
      if aCallNo = 0 then
        Common.MsgBox('렛츠오더에 등록된 번호가 아닙니다'#13'번호를 확인해주세요');
      Common.Query.Close;
      Exit;
    end;
    vTelNo     := Common.Query.Fields[0].AsString;
    vStatus    := Common.Query.Fields[1].AsString;
    Common.Query.Close;
  end;

  if (Common.Config.DIDPickupPos <> '') and (aKitchenName = '') then
    aKitchenName := Common.Config.DIDPickupPos
  else if (Common.Config.DefaultPickUp <> '') and (aKitchenName = '') then
    aKitchenName := Common.Config.DefaultPickUp;

  //주방명이 없을때
  if (aKitchenName = '') and (vTelNo <> '') then
  begin
    if Common.KaKaoSendMessage('L', [IntToStr(vCallNo)+Ifthen(vStatus='2','(재호출)','')], GetOnlyNumber(vTelNo), '알림톡 호출실패') then
    begin
      if vReceiptNo <> '' then
        ExecQuery('update SL_LETSORDER '
                 +'   set DS_STATUS  = ''2'', '
                 +'       DT_PICKUP  = Now() '
                 +' where CD_STORE   = :P0 '
                 +'   and NO_RECEIPT = :P1 ',
                 [Common.Config.StoreCode,
                  vReceiptNo]);
    end;
    //DID와 알림톡 같이 발송
    if (GetOption(478) = '1') and (Common.Config.BellDev = 2) then
    begin
      ExecQuery('insert into MS_ORDERNO(CD_STORE, DS_NUMBER, NO_POS, NO_ORDER, PICKUP_POS, DT_CHANGE, TEL_MOBILE)'
               +'                 values(:P0, ''D'', ''00'', :P1, :P2, Now(), :P3)  '
               +'ON DUPLICATE KEY UPDATE DT_CHANGE = Now() ',
               [Common.Config.StoreCode,
                vCallNo,
                Common.Config.DIDPickupPos,
                GetOnlyNumber(vTelNo)]);
    end;
  end
  else if (aKitchenName <> '') and (vTelNo <> '') then
  begin
    if Common.KaKaoSendMessage('CN', [IntToStr(vCallNo)+Ifthen(vStatus='2','(재호출)',''),aKitchenName], GetOnlyNumber(vTelNo), '알림톡 호출실패') then
    begin
      if vReceiptNo <> '' then
        ExecQuery('update SL_LETSORDER '
                 +'   set DS_STATUS  = ''2'', '
                 +'       DT_PICKUP  = Now() '
                 +' where CD_STORE   =:P0 '
                 +'   and NO_RECEIPT = :P1 ',
                 [Common.Config.StoreCode,
                  vReceiptNo]);
    end;

    //DID와 알림톡 같이 발송
    if (GetOption(478) = '1') and (Common.Config.BellDev = 2) then
    begin
      ExecQuery('insert into MS_ORDERNO(CD_STORE, DS_NUMBER, NO_POS, NO_ORDER, PICKUP_POS, DT_CHANGE, TEL_MOBILE)'
               +'                 values(:P0, ''D'', ''00'', :P1, :P2, Now(), :P3)  '
               +'ON DUPLICATE KEY UPDATE DT_CHANGE = Now() ',
               [Common.Config.StoreCode,
                vCallNo,
                aKitchenName,
                GetOnlyNumber(vTelNo)]);
    end;
  end
  else if (Common.Config.BellPort > 0) and (vCallNo > 0) then
    Common.Device.CallBell(vCallNo)
  //DID
  else if Common.Config.BellDev = 2 then
  begin
    ExecQuery('insert into MS_ORDERNO(CD_STORE, DS_NUMBER, NO_POS, NO_ORDER, PICKUP_POS, DT_CHANGE, TEL_MOBILE)'
             +'                 values(:P0, ''D'', ''00'', :P1, :P2, Now(), :P3)  '
             +'ON DUPLICATE KEY UPDATE DT_CHANGE = Now() ',
             [Common.Config.StoreCode,
              vCallNo,
              Common.Config.DIDPickupPos,
              GetOnlyNumber(vTelNo)]);
  end;

  ExecQuery('update MS_ORDERNO '
           +'   set DS_STATUS = ''C'' '
           +' where CD_STORE  = :P0 '
           +'   and DS_NUMBER = ''C'' '
           +'   and NO_POS    = ''00'' '
           +'   and NO_ORDER  = :P1 ',
           [Common.Config.StoreCode,
            vCallNo]);
end;

procedure TCommon.SetButtonColor(aObject:TObject; aFixed:Boolean);
var vTemp :String;
    vColor :TColor;
begin
  if Common.Config.IsKiosk then
  begin
    with TIniFile.Create(AppPath+'Kiosk\KioskConfig.ini') do
    try
      vTemp := ReadString('공통', 'Color','');
    finally
      Free;
    end;

    if (vTemp = '') or aFixed then
    begin
      if GetOption(458) = '0' then
        Exit
      else if GetOption(458) = '1' then
        vColor := $00CC6600    //Blue
      else if GetOption(458) = '2' then
        vColor := clBlack
      else if GetOption(458) = '3' then
        vColor := $000000CC    //Red
      else if GetOption(458) = '4' then
        vColor := $00009900;   //Green
    end
    else vColor := StringToColor(vTemp);

    if aObject is TAdvSmoothButton then
    begin
      (aObject as TAdvSmoothButton).Color      := vColor;
      (aObject as TAdvSmoothButton).BevelColor := vColor;
    end
    else if aObject is TAdvSmoothToggleButton then
    begin
      (aObject as TAdvSmoothToggleButton).Color       := vColor;
      (aObject as TAdvSmoothToggleButton).BorderColor := vColor;
    end
    else if aObject is TPanel then
      (aObject as TPanel).Color       := vColor
    else if aObject is TcxLabel then
      (aObject as TcxLabel).Style.TextColor := vColor;
  end
  else
  begin
    if Common.Config.Style = 'D' then
    begin
      if aObject is TAdvGlassButton then
      begin
        (aObject as TAdvGlassButton).BackColor        := clBlack;
        (aObject as TAdvGlassButton).GlowColor        := clBlack;
        (aObject as TAdvGlassButton).ShineColor       := clBlack;
        (aObject as TAdvGlassButton).InnerBorderColor := clBlack;
      end
      else if aObject is TAdvSmoothToggleButton then
      begin
        (aObject as TAdvSmoothToggleButton).Color       := $00121212;
        if (aObject as TAdvSmoothToggleButton).Appearance.Rounding = 0 then
        begin
          (aObject as TAdvSmoothToggleButton).BorderInnerColor := clNone; //$00222222
          (aObject as TAdvSmoothToggleButton).BorderColor := clSilver; //$00222222
        end
        else
          (aObject as TAdvSmoothToggleButton).BorderColor := $00696969;
        (aObject as TAdvSmoothToggleButton).ColorDown   := $00121212;
      end
      else if aObject is TAdvSmoothButton then
      begin
        (aObject as TAdvSmoothButton).Color := $00252525;//$00121212;
        (aObject as TAdvSmoothButton).DisabledColor := $005A5A5A
      end
      else if aObject is TAdvShape then
      begin
        (aObject as TAdvShape).Appearance.Color   := $002D2D2D;
        (aObject as TAdvShape).Appearance.ColorTo := $002D2D2D;
      end;
    end
    else
    begin
      if aObject is TAdvSmoothButton then
      begin
        (aObject as TAdvSmoothButton).Color         := $006F3700;
        (aObject as TAdvSmoothButton).DisabledColor := $006F3700;
      end;
    end;
  end;
end;

procedure TCommon.SetKioskButton(aObject:TObject;aImageFile:String);
begin
  if aObject is TAdvSmoothToggleButton then
  begin
    (aObject as TAdvSmoothToggleButton).Appearance.Font.Name := Config.KioskDefaultFontName;
    (aObject as TAdvSmoothToggleButton).Appearance.Rounding  := Config.KioskButtonRound;
    if (aImageFile <> '') and  FileExists(Common.AppPath+'Kiosk\'+aImageFile+'.png') then
      (aObject as TAdvSmoothToggleButton).Picture.LoadFromFile(Common.AppPath+'Kiosk\'+aImageFile+'.png');
  end
  else if aObject is TAdvSmoothButton then
  begin
    (aObject as TAdvSmoothButton).Appearance.Font.Name := Config.KioskDefaultFontName;
    (aObject as TAdvSmoothButton).Appearance.Rounding  := Config.KioskButtonRound;
    if (aImageFile <> '') and FileExists(Common.AppPath+'Kiosk\'+aImageFile+'.png') then
      (aObject as TAdvSmoothButton).Picture.LoadFromFile(Common.AppPath+'Kiosk\'+aImageFile+'.png');
  end
  else if aObject is TcxLabel then
    (aObject as TcxLabel).Style.Font.Name := Config.KioskDefaultFontName;
end;

function TCommon.GetImageCollectionIndex(aMenuCode:String):Integer;
var vIndex :Integer;
begin
  Result := -1;
  //포장일때 포장이미지 적용
  for vIndex := 0 to MenuImageCollection.Items.Count-1 do
  begin
    if Common.Table.Packing = 'Y' then
    begin
      if MenuImageCollection.Items.Items[vIndex].Name = Format('Menu%s_packingItem',[aMenuCode]) then
      begin
        Result := vIndex;
        Break;
      end;
    end;
  end;

  if Result = -1 then
    for vIndex := 0 to MenuImageCollection.Items.Count-1 do
    begin
      if MenuImageCollection.Items.Items[vIndex].Name = Format('Menu%sItem',[aMenuCode]) then
      begin
        Result := vIndex;
        Break;
      end;
  end;
end;

function TCommon.GetInfoImageCollectionIndex(aMenuCode:String):Integer;
var vIndex :Integer;
begin
  Result := -1;
  for vIndex := 0 to MenuInfoImageCollection.Items.Count-1 do
  begin
    if MenuInfoImageCollection.Items.Items[vIndex].Name = Format('Menu%sItem',[aMenuCode]) then
    begin
      Result := vIndex;
      Break;
    end;
  end;
end;


function TCommon.FileDownLoad(aFileName, aPath: String): Boolean;
var vIdHTTP     : TIdHTTP;
    vFileStream: TMemoryStream;
    vRequest : TStringStream;
    vResponse :String;
begin
  Result := false;
  try
    vFileStream := TMemoryStream.Create;
    vIdHTTP     := TIdHTTP.Create(Application);
    vIdHTTP.HandleRedirects := true;
    vRequest    := TStringStream.Create;
    vIdHTTP.ConnectTimeout := 1000;
    if (aFileName = 'SmartAgent.exe') or (aFileName = 'OrangeTR.exe') then
      vIdHTTP.Request.CustomHeaders.AddValue('COMP_ID', '/FTP/Update/CloudOrange/FrontOffice/temp')
    else if (aFileName = 'libeay32.dll') or (aFileName = 'ssleay32.dll') then
      vIdHTTP.Request.CustomHeaders.AddValue('COMP_ID', '/FTP/Update/CloudOrange/BackOffice')
    else
      vIdHTTP.Request.CustomHeaders.AddValue('COMP_ID', '/FTP/Update/CloudOrange/FrontOffice');
    vIdHTTP.Request.CustomHeaders.AddValue('FILE_NAME', aFileName);
    vIdHTTP.Request.CustomHeaders.AddValue('JOB_GBN','T');
    vIdHTTP.ReadTimeout    := 10000;

    try
      vIdHTTP.Post('http://39.120.147.83:50280/Orange/Action_FileDown', vRequest, vFileStream );
    except
      Exit;
    end;
    vResponse := IntToStr(vIdHTTP.ResponseCode);
    if vResponse = '200' then
    begin
      vFileStream.SaveToFile(aPath+aFileName);
      Result := true;
    end;
  finally
    vIdHTTP.Disconnect;
    vFileStream.Free;
    vIdHTTP.Free;
  end;
end;

function TCommon.SendTabletMessage(aMsgType:String; aTableNo:Integer; aMsg:String):Boolean;
var vRestClient   :TRestClient;
    vRestRequest  :TRestRequest;
    vRESTResponse :TRESTResponse;
    vMsgObject,
    vJSONObject   :TJSONObject;
    vGUID : TGUID;
    vData :String;
begin
  try
    Result := false;
    vRestClient                := TRestClient.Create(nil);
    vRestRequest               := TRestRequest.Create(nil);
    vRESTResponse              := TRESTResponse.Create(vRestRequest);
    vRestRequest.Client        := vRestClient;
    vRestRequest.Response      := vRESTResponse;
    if LeftStr(Common.Config.StoreCode,2) = 'TT' then
      vRestClient.BaseURL        := Format('https://api-qa.letsorder.kr/api/v1/pos/groups/%s/stores/%s/table/%d/publish-message',
                                          [Common.Config.HeadStoreCode,
                                           Common.Config.StoreCode,
                                           aTableNo])
    else
      vRestClient.BaseURL        := Format('https://api-op.letsorder.kr/api/v1/pos/groups/%s/stores/%s/table/%d/publish-message',
                                          [Common.Config.HeadStoreCode,
                                           Common.Config.StoreCode,
                                           aTableNo]);

    vRestClient.ContentType    := 'application/x-www-form-urlencoded; charset=UTF-8;';
    vRestRequest.Accept        := 'application/json';
    vRestRequest.AcceptCharset := 'UTF-8';
    vRestRequest.Method        := TRESTRequestMethod.rmPOST;
    CoCreateGuid(vGUID);
    vRestRequest.Params.AddHeader('X-Message-Id', GUIDToString(vGUID));
    vMsgObject    := TJSONObject.Create;
    vMsgObject.AddPair('msg_type',    TJSONString.Create(aMsgType));
    vMsgObject.AddPair('msg_text',    TJSONString.Create(aMsg));
    vJSONObject    := TJSONObject.Create;
    vJSONObject.AddPair('publish_message',      vMsgObject);
    vRESTRequest.AddBody(vJSONObject.ToJSON, TRESTContentType.ctAPPLICATION_JSON);
    Common.WriteLog('work', Format('publish_message[request] %s',[aMsg]));
    try
      vRESTRequest.Execute;
    except
      Exit;
    end;

    if vRestRequest.Response.StatusCode <> 200 then
    begin
      Exit;
    end;
    vData := vRESTResponse.Content;
    vJSONObject := TJSONObject.ParseJSONValue( vData ) as TJSONObject;
    vData := vJSONObject.GetValue('response').ToJson;
    Result := true;
    Common.WriteLog('work', Format('publish_message[response] %s',[vData]));
  finally
    vRestClient.Disconnect;
    FreeAndNil(vRESTResponse);
    FreeAndNil(vRESTRequest);
    FreeAndNil(vRESTClient);
  end;
end;

function TCommon.LetsOrderAuth(aHeadStore:String):String;
var vRestClient   :TRestClient;
    vRestRequest  :TRestRequest;
    vRESTResponse :TRESTResponse;
    vMsgObject,
    vJSONObject   :TJSONObject;
    vGUID : TGUID;
    vURL,
    vData :String;
begin
  Result := '';
  if LeftStr(Common.Config.StoreCode,2) = 'TT' then
    vURL        := 'https://api-qa.letsorder.kr/api/v1/'
  else
    vURL        := 'https://api-op.letsorder.kr/api/v1/';

  try
    BlockInput(false);
    vRestClient                := TRestClient.Create(nil);
    vRestRequest               := TRestRequest.Create(nil);
    vRESTResponse              := TRESTResponse.Create(vRestRequest);
    vRestRequest.Client        := vRestClient;
    vRestRequest.Response      := vRESTResponse;
    vRestClient.BaseURL        := Format('%s/admin/login',[vURL]);
    vRestClient.ContentType    := 'application/x-www-form-urlencoded; charset=UTF-8;';
    vRestRequest.Accept        := 'application/json';
    vRestRequest.AcceptCharset := 'UTF-8';
    vRestRequest.Method        := TRESTRequestMethod.rmPOST;
    CoCreateGuid(vGUID);
    vRestRequest.Params.AddHeader('X-Message-Id', GUIDToString(vGUID));
    vJSONObject   := TJSONObject.Create;
    if Pos('api-op',vURL) > 0 then
    begin
      vJSONObject.AddPair('user_id',      TJSONString.Create('lets.order'));
      vJSONObject.AddPair('password',     TJSONString.Create('expos.retail!'));
    end
    else
    begin
      vJSONObject.AddPair('user_id',      TJSONString.Create('lets_order'));
      vJSONObject.AddPair('password',     TJSONString.Create('lge.retail'));
    end;
    vRESTRequest.AddBody(vJSONObject.ToJSON, TRESTContentType.ctAPPLICATION_JSON);

    try
      vRESTRequest.Execute;
    except
      Exit;
    end;

    if vRestRequest.Response.StatusCode <> 200 then
    begin
      Exit;
    end;
    vData := vRESTResponse.Content;
    vJSONObject := TJSONObject.ParseJSONValue( vData ) as TJSONObject;
    vData := vJSONObject.GetValue('response').ToJson;
    vJSONObject := TJSONObject.ParseJSONValue( vData ) as TJSONObject;
    Result := vJSONObject.GetValue('access_token').ToJson;
  finally
    vRestClient.Disconnect;
    FreeAndNil(vRESTResponse);
    FreeAndNil(vRESTRequest);
    FreeAndNil(vRESTClient);
  end;
end;

procedure TCommon.LogFilesDelete(aPath:String);
var vLogPath :String;
    vFiles   :TSearchRec;
    vRet     :Integer;
begin
  try
    vLogPath := ExtractFilePath(Application.ExeName)+Format('Log\%s\',[aPath]);
    vRet := FindFirst(vLogPath+'*.log',faAnyfile, vFiles);
    while vRet = 0 do
    begin
      if (Length(vFiles.Name)=12) and (MonthsBetween(Now(), StrToDate(FormatMaskText('0000-90-90;0;', LeftStr(vFiles.Name,8)))) >= 3) then
      begin
        if FileExists(vLogPath+vFiles.Name) then
          DeleteFile(vLogPath+vFiles.Name);
      end;
      vRet := FindNext(vFiles);
    end;
  except
  end;
end;

procedure TCommon.TextToSpeech(aText:String);
var vFileName, vFileNameWav :String;
    vSeq :Integer;
begin
  if Length(aText) < 5 then Exit;

  vFileName := '';
  OpenQuery('select TTS_FILE '
           +'  from ms_tts '
           +' where TTS_TEXT =:P0 ',
           [aText]);

  if not Query.Eof then
  begin
    vFileName := Query.Fields[0].AsString;
    Query.Close;

    if not FileExists(AppPath+'TTS\'+vFileName) then
      vFileName := '';
  end;

  if vFileName = '' then
  begin
    OpenQuery('select Ifnull(Max(TTS_SEQ),0) '
             +'  from ms_tts ',
             []);

    vSeq := Query.Fields[0].AsInteger;
    vFileName := FormatDateTime('yymmddhhnnss.wav',Now());

    SpeakCached_PlaySound_LeadSilence('AIzaSyCx810LMp0EZ2KGGMwzjy5tjAJK691QYQc',
                                         Common.AppPath,
                                         aText,
                                         Common.AppPath+'TTS\'+vFileName);

    ExecQuery('insert into ms_tts(TTS_TEXT, '
             +'                   TTS_FILE, '
             +'                   DT_INSERT) '
             +'            values(:P0, '
             +'                   :P1, '
             +'                   Now()) '
             +'on duplicate key update TTS_TEXT =:P0, '
             +'                        TTS_FILE =:P1 ',
             [aText,
              vFileName]);
  end;

  if vFileName <> '' then
  begin
    vFileNameWav := Replace(AppPath+'TTS\'+vFileName, '.wav','tmp.wav');
    CopyFile(PChar(AppPath+'TTS\'+vFileName), PChar(vFileNameWav), true);
    MciPlayWav(vFileNameWav);
  end;
end;



function  TCommon.GetPaPago(aText:String):String;  //en, cha, jpn
  function GetLanguData(aSource:String) : String;
  var vIndex :Integer;
  begin
    Result := '';
    for vIndex := 0 to LanguageData.Count-1 do
    begin
      if TLanguage(LanguageData.Items[vIndex]^).Korean = aSource then
      begin
        if Config.PosLanguage = 'EA' then
          Result := TLanguage(LanguageData.Items[vIndex]^).English
        else if Config.PosLanguage = 'CN' then
          Result := TLanguage(LanguageData.Items[vIndex]^).China
        else if Config.PosLanguage = 'JA' then
          Result := TLanguage(LanguageData.Items[vIndex]^).Japanese
        else if Config.PosLanguage = 'VI' then
          Result := TLanguage(LanguageData.Items[vIndex]^).Vitenam
        else if Config.PosLanguage = 'TH' then
          Result := TLanguage(LanguageData.Items[vIndex]^).Thai
        else if Config.PosLanguage = 'IN' then
          Result := TLanguage(LanguageData.Items[vIndex]^).Indo
        else if Config.PosLanguage = 'FR' then
          Result := TLanguage(LanguageData.Items[vIndex]^).French
        else if Config.PosLanguage = 'DE' then
          Result := TLanguage(LanguageData.Items[vIndex]^).German;
        Break;
      end;
    end;
  end;
  procedure SetLanguageData(aSource, aData:String);
  var vIndex :Integer;
      vResult :Boolean;
      vLanguage  :^TLanguage;
  begin
    vResult := false;
    for vIndex := 0 to LanguageData.Count-1 do
    begin
      if TLanguage(LanguageData.Items[vIndex]^).Korean = aSource then
      begin
        if Config.PosLanguage = 'EA' then
          TLanguage(LanguageData.Items[vIndex]^).English := aData
        else if Config.PosLanguage = 'CN' then
          TLanguage(LanguageData.Items[vIndex]^).China := aData
        else if Config.PosLanguage = 'JA' then
          TLanguage(LanguageData.Items[vIndex]^).Japanese := aData
        else if Config.PosLanguage = 'VI' then
          TLanguage(LanguageData.Items[vIndex]^).Vitenam := aData
        else if Config.PosLanguage = 'TH' then
          TLanguage(LanguageData.Items[vIndex]^).Thai := aData
        else if Config.PosLanguage = 'IN' then
          TLanguage(LanguageData.Items[vIndex]^).Indo := aData
        else if Config.PosLanguage = 'FR' then
          TLanguage(LanguageData.Items[vIndex]^).French := aData
        else if Config.PosLanguage = 'DE' then
          TLanguage(LanguageData.Items[vIndex]^).German := aData;

        vResult := true;
        Break;
      end;
    end;

    if not vResult then
    begin
      New(vLanguage);
      vLanguage.Korean := aSource;
      if Config.PosLanguage = 'EA' then
        vLanguage.English := aData
      else if Config.PosLanguage = 'CN' then
        vLanguage.China := aData
      else if Config.PosLanguage = 'JA' then
        vLanguage.Japanese := aData
      else if Config.PosLanguage = 'VI' then
        vLanguage.Vitenam := aData
      else if Config.PosLanguage = 'TH' then
        vLanguage.Thai := aData
      else if Config.PosLanguage = 'IN' then
        vLanguage.Indo := aData
      else if Config.PosLanguage = 'FR' then
        vLanguage.French := aData
      else if Config.PosLanguage = 'DE' then
        vLanguage.German := aData;

      LanguageData.Add(vlanguage);
    end;

  end;
var vRestClient   :TRestClient;
    vRestRequest  :TRestRequest;
    vRESTResponse :TRESTResponse;
    vJSONObject   :TJSONObject;
    vData, vSQL, vSQL2       :String;
begin
  Result := '';
  if (Config.PosLanguage = 'KO') or (Config.PosLanguage = '') or ((GetHeadOption(14)='0') and not Config.IsKiosk) or (aText = '') or (Common.RestDBURL = '') then
  begin
    Result := aText;
    Exit;
  end;

  if (Config.PosLanguage <> 'EA') and (Config.PosLanguage <> 'CN')  and (Config.PosLanguage <> 'JA')
   and (Config.PosLanguage <> 'VI') and (Config.PosLanguage <> 'TH') and (Config.PosLanguage <> 'IN') and (Config.PosLanguage <> 'FR') and (Config.PosLanguage <> 'DE') then
  begin
    Result := aText;
    Exit;
  end;

  if LanguageData.Count = 0 then
    DM.DownLanguage;

  Result := GetLanguData(aText);
  if (Result <> '') or not isLanguageTrans then Exit;

  try
    BlockInput(false);
    vRestClient                := TRestClient.Create(nil);
    vRestRequest               := TRestRequest.Create(nil);
    vRESTResponse              := TRESTResponse.Create(vRestRequest);
    vRestRequest.Client        := vRestClient;
    vRestRequest.Response      := vRESTResponse;
    vRestClient.BaseURL        := 'https://papago.apigw.ntruss.com/nmt/v1/translation';
    vRestClient.ContentType    := 'application/x-www-form-urlencoded; charset=UTF-8;';
    vRestRequest.Accept        := 'application/json';
    vRestRequest.AcceptCharset := 'UTF-8';
    vRestRequest.Method        := TRESTRequestMethod.rmPOST;
    vRestRequest.Params.AddHeader('X-NCP-APIGW-API-KEY-ID', 'suozss7cpc');
    vRestRequest.Params.AddHeader('X-NCP-APIGW-API-KEY','2XYN1guq9qFUykHJXIbdMMsFgnNEn3MWjBqgnEjX');

    vJSONObject    := TJSONObject.Create;
    vJSONObject.AddPair('source',    TJSONString.Create('ko'));
    if Config.PosLanguage = 'EA' then
    begin
      vJSONObject.AddPair('target',    TJSONString.Create('en'));
      vSQL    := 'insert into MS_LANGUAGES(KOREAN, ENGLISH) values (:P0, ''%s'') ON DUPLICATE KEY UPDATE ENGLISH = ''%s'' ';
      vSQL2   := 'insert into MS_LANGUAGES(CD_HEAD, CD_STORE, KOREAN, ENGLISH) values (:P0,:P1,:P2,:P3) ON DUPLICATE KEY UPDATE ENGLISH = :P3; ';
    end;
    if Config.PosLanguage = 'CN' then
    begin
      vJSONObject.AddPair('target',    TJSONString.Create('zh-CN'));
      vSQL    := 'insert into MS_LANGUAGES(KOREAN, CHINESE_SIMPLE) values (:P0, ''%s'') ON DUPLICATE KEY UPDATE CHINESE_SIMPLE = ''%s'' ';
      vSQL2   := 'insert into MS_LANGUAGES(CD_HEAD, CD_STORE, KOREAN, CHINESE_SIMPLE) values (:P0,:P1,:P2,:P3) ON DUPLICATE KEY UPDATE CHINESE_SIMPLE = :P3; ';
    end;
    if Config.PosLanguage = 'JA' then
    begin
      vJSONObject.AddPair('target',    TJSONString.Create('ja'));
      vSQL    := 'insert into MS_LANGUAGES(KOREAN, JAPANESE) values (:P0, ''%s'') ON DUPLICATE KEY UPDATE JAPANESE = ''%s'' ';
      vSQL2   := 'insert into MS_LANGUAGES(CD_HEAD, CD_STORE, KOREAN, JAPANESE) values (:P0,:P1,:P2,:P3) ON DUPLICATE KEY UPDATE JAPANESE = :P3; ';
    end;
    if Config.PosLanguage = 'VI' then
    begin
      vJSONObject.AddPair('target',    TJSONString.Create('vi'));
      vSQL    := 'insert into MS_LANGUAGES(KOREAN, VIETNAMESE) values (:P0, ''%s'') ON DUPLICATE KEY UPDATE VIETNAMESE = ''%s'' ';
      vSQL2   := 'insert into MS_LANGUAGES(CD_HEAD, CD_STORE, KOREAN, VIETNAMESE) values (:P0,:P1,:P2,:P3) ON DUPLICATE KEY UPDATE VIETNAMESE = :P3; ';
    end;
    if Config.PosLanguage = 'TH' then
    begin
      vJSONObject.AddPair('target',    TJSONString.Create('th'));
      vSQL    := 'insert into MS_LANGUAGES(KOREAN, THAI) values (:P0, ''%s'') ON DUPLICATE KEY UPDATE THAI = ''%s'' ';
      vSQL2   := 'insert into MS_LANGUAGES(CD_HEAD, CD_STORE, KOREAN, THAI) values (:P0,:P1,:P2,:P3) ON DUPLICATE KEY UPDATE THAI = :P3; ';
    end;
    if Config.PosLanguage = 'IN' then
    begin
      vJSONObject.AddPair('target',    TJSONString.Create('id'));
      vSQL    := 'insert into MS_LANGUAGES(KOREAN, INDONESIAN) values (:P0, ''%s'') ON DUPLICATE KEY UPDATE INDONESIAN = ''%s'' ';
      vSQL2   := 'insert into MS_LANGUAGES(CD_HEAD, CD_STORE, KOREAN, INDONESIAN) values (:P0,:P1,:P2,:P3) ON DUPLICATE KEY UPDATE INDONESIAN = :P3; ';
    end;
    if Config.PosLanguage = 'FR' then
    begin
      vJSONObject.AddPair('target',    TJSONString.Create('fr'));
      vSQL    := 'insert into MS_LANGUAGES(KOREAN, FRENCH) values (:P0, ''%s'') ON DUPLICATE KEY UPDATE FRENCH = ''%s'' ';
      vSQL2   := 'insert into MS_LANGUAGES(CD_HEAD, CD_STORE, KOREAN, FRENCH) values (:P0,:P1,:P2,:P3) ON DUPLICATE KEY UPDATE FRENCH = :P3; ';
    end;
    if Config.PosLanguage = 'DE' then
    begin
      vJSONObject.AddPair('target',    TJSONString.Create('de'));
      vSQL    := 'insert into MS_LANGUAGES(KOREAN, GERMAN) values (:P0, ''%s'') ON DUPLICATE KEY UPDATE GERMAN = ''%s'' ';
      vSQL2   := 'insert into MS_LANGUAGES(CD_HEAD, CD_STORE, KOREAN, GERMAN) values (:P0,:P1,:P2,:P3) ON DUPLICATE KEY UPDATE GERMAN = :P3; ';
    end;

    vJSONObject.AddPair('text',      TJSONString.Create(aText));
    vRESTRequest.AddBody(vJSONObject.ToJSON, TRESTContentType.ctAPPLICATION_JSON);
    try
      vRESTRequest.Execute;
    except
      Result := aText;
      Exit;
    end;

    if vRestRequest.Response.StatusCode <> 200 then
    begin
      Result := aText;
      Exit;
    end;
    vData := vRESTResponse.Content;
    vJSONObject := TJSONObject.ParseJSONValue( vData ) as TJSONObject;
    vData := vJSONObject.GetValue('message').ToJson;
    vJSONObject := TJSONObject.ParseJSONValue( vData ) as TJSONObject;
    vData := vJSONObject.GetValue('result').ToJson;
    vJSONObject := TJSONObject.ParseJSONValue( vData ) as TJSONObject;
    Result := vJSONObject.GetValue('translatedText').Value;

    FreeAndNil(vJSONObject);
    DM.ExecCloud(vSQL2,
                [Config.HeadStoreCode,
                 Ifthen(GetHeadOption(1)='0',Config.StoreCode,'00000000'), //체인이면 본사걸로 저장
                 aText,
                 Result],true,Common.RestDBURL);

    SetLanguageData(aText, Result);
  finally
    vRestClient.Disconnect;
    FreeAndNil(vRESTResponse);
    FreeAndNil(vRESTRequest);
    FreeAndNil(vRESTClient);
  end;
end;

procedure TCommon.DoModalBegin(Sender: TObject);
begin
  if Assigned(BackGroundScreen_F) then
    BackGroundScreen_F.Show;
end;

procedure TCommon.DoModalEnd(Sender: TObject);
begin
  if Assigned(BackGroundScreen_F) then
    BackGroundScreen_F.Close;
end;


procedure TCommon.DoModalReset;
begin
  if not Config.IsKiosk then Exit;

  if Assigned(BackGroundScreen_F) then
  begin
    BackGroundScreen_F.Close;
    BackGroundScreen_F.Show;
  end;
end;

procedure TCommon.DoModalClose;
begin
  if not Config.IsKiosk then Exit;

  if Assigned(BackGroundScreen_F) then
    BackGroundScreen_F.Close;
end;

end.





























