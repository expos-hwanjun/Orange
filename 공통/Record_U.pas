{메뉴정보}
  TMenu = record                  { 메 뉴 }
    cd_menu      :String[100];  //메뉴코드
    nm_menu      :String;       //메뉴명
    nm_menu_org  :String;
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
    yn_rcp       :String;
    prt_kitchen  :Integer;
    no_group     :Integer;      //주방주문서 메뉴별 인쇄시 메뉴그룹
    change       :String;
    pr_tip       :Integer;
    ds_item      :String;
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
     DeliveryNo  : String[12];  //배달번호
     SaleRcp     : String;       //선결제 영수증번호(매출일자(8)+포스번호(2)+영수증번호(4)
     IsBeforeAccount :Boolean;   //선결제여부
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
    OldRcpNo     : String;                  // 원영수증번호(거래조회 후 재발시 사용);
    RcpNo        : String;                  // 영수증번호
    CardSeq      : Integer;                 // 신용카드승인시 사용
    CashSeq      : Integer;                 // 현금영수증승인시 사용
    GoodQty      : Integer;                 // 품목건수

    MenuDc       : Integer;                 // 단품할인
    MemberDc     : Integer;                 // 회원할인
    RcpDc        : Integer;                 // 전체금액 할인
    EnuriDc      : Integer;                 // 에누리할인
    SpcDc        : Integer;                 // 행사할인금액
    CodeDc       : Integer;                 // 지정할인
    EventDc      : Integer;                 // 이벤트 할인
    CouponNo     : String;                  // 쿠폰번호
    CouponType   : String;                  // 쿠폰유형(A:금액형쿠폰, R:%할인쿠폰)
    CouponRate   : Integer;                 // 쿠폰할인율
    CouponDc     : Integer;                 // 쿠폰할인금액
    CouponMember : Boolean;                 // 회원전용여부
    CouponLimit  : Integer;                 // 쿠폰할인 최대 금액
    CouponMenu   : String;                  // 쿠폰적용메뉴
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
    KbankDc      : Integer;                 // 광주은행카드할인
    MCardDc      : Integer;                 // 현대 M카드할인
    KTDc         : Integer;
    OhPointDc    : Integer;
    TaxFreeDc    : Integer;
    StampDc      : Integer;
    UPlusDc      : Integer;
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
    ZeroPayAmt   : Integer;                 // 제로페이 결제금액
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
    CashRcpAmt   : Integer;                 // 현금영수증승인금액
    CashRcvAmt   : Integer;                 // 현금영수증 받은금액

    CardCancel   : Double;                  // 취소카드합계
    CashCancel   : Double;                  // 현금지불액

    WRcvAmt      : Integer;                 // 받을 금액
    GiveAmt      : Integer;                 // 거스름돈
    ReadyChk     : Boolean;
    CardSign     : Boolean;

    SaleTime     : String;                  //재출력 시 사용
    SaleDate     : TDateTime;
    CallNo       : Integer;                 //호출번호
    //발행쿠폰 정보
    CouponNo_Issue :String;
    CouponName_Issue:String;
    CouponType_Issue:String;
    CouponAmt_Issue :Integer;
    CouponFromDate_Issue,
    CouponToDate_Issue :String;

    DutchPayAmt : Integer;
    //키오스크 티켓(식권)출력 데이터
    TicketPrintData :TStringList;           //영수증번호(20170814010001) #28 메뉴명 #28 시작번호 #28 끝번호
  end;

  {카드}
  TCard = record
     Ds_Card      : String;                  //카드구분 (C:신용카드, I:현금IC카드  
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
     No_Approval  : String;                  //승인번호
     Approval_Org : String;                  //승인번호(취소시 당초 승인번호)
     No_OrgUnique : String;                  //스마트로 거래일련번호
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
     DsDc         : String;
     Yn_UnionPay  : String;                  //은련카드여부
     BalanceAmt   : String;                  //선불카드 잔액(출력여부를 몰라 String 타입으로 사용한다)
     Yn_NoCVM     : String;                  //5만원이하 무서명
     Yn_Cat       : String;                  //보안리더기 사용시 단말기에서 승인여부
     VanTID       : String;
  end;

  {현금영수증}
  TCashRcp = record
     Ds_Trd       : String;                  //거래구분(1:승인, 2:취소)
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
     no_van       : Integer;                 //밴구분(0:OneVan, 1:TwoVan)
     Corner       : String;
     RcvAmt       : Integer;                 //받은금액
     Yn_Cat       : String;
     VanTid       : String;
  end;

  TKTPoint = record
    ds_trd        : String;                  //거래구분(1:승인, 2취소)
    CardNo        : String;                  //카드번호
    AgreeAmt      : Integer;                 //승인금액
    Dc_Amt        : Integer;                 //할인금액
    chailpl       : String;                  //가맹점번호
    AgreeDate     : String;                  //승인일자
    AgreeNo       : String;                  //승인번호
    OrgAgreeDate  : String;                  //원승인일자
    OrgAgreeNo    : String;                  //원승인번호
    pnt_rest      : Integer;                 //잔여포인트
    yn_can        : String[1];
    yn_print     : String[1];               //출력여부
    yn_save       : String[1];               //저장여부
  end;

  TOhPoint = record
    ds_trd        : String;                  //거래구분(1:승인, 2취소)
    CardNo        : String;                  //카드번호
    AgreeAmt      : Integer;                 //승인금액
    Dc_Amt        : Integer;                 //할인금액
    chailpl       : String;                  //가맹점번호
    AgreeDate     : String;                  //승인일자
    AgreeNo       : String;                  //승인번호
    OrgAgreeDate  : String;                  //원승인일자
    OrgAgreeNo    : String;                  //원승인번호
    pnt_rest      : Integer;                 //잔여포인트
    yn_can        : String[1];
    yn_print     : String[1];                //출력여부
    yn_save       : String[1];               //저장여부
  end;

  TUPlus = record
    ds_trd        : String;                  //거래구분(1:승인, 2취소)
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
     CardNo     : String;
     MobileTel  : String;                    //연락처
     HomeTel    : String;
     dt_birth   : String;                    //생일
     dt_visit   : String;                    //최종방문일
     Dc_Rate    : Integer;                   //할인율
     OrgOccurPoint :Integer;
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
  end;

  TConfig = record
     HeadStoreCode : String;
     StoreCode     : String[8];    //매장코드
     StoreName     : String;       //매장명
     StoreBizNo    : String;
     StoreAddress  : String;
     StoreBoss     : String;
     IsTakeOut     : Boolean;
     StoreTel      : String;
     StoreMobile   : Array[1..5] of String;
     CustomerNo    : String;
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
     AutoStart     : Boolean;
     StartTime     : Integer;
     SmSTime       : Integer;
     AutoLogin     : Boolean;      //자동로그인

     UserCode      : String[6];    //로그인한 사원 ID
     UserName      : String;       //로그인한 사원 이름
     UserPass      : String;       //로그인한 사원 패스워드
     UserGrade     : String;       //사용자 등급
     LoginUserWork : String;
     UserWork      : String;       //담당업무
     EndUser       : String;

     RcpToKitchen  : Boolean;      //영수증프린터 내역을 주방프린터와 같이 사용
     KitchenIndex  : Integer;      //주방프린터의 순번
     Rcp_Dev       : Integer;      //영수증프린터 기종
     Rcp_Port      : Integer;      //영수증프린터 포트(0 사용안함, 1..6 com, 7-LPT)
     PrintBottomMargin :Integer;   //영수증프린터 하단여백
     Rcp_BaudRate  : Integer;
     Rcp_Check     : Boolean;      //영수증프린터 출력전 체크
     ScalePort     : Integer;      //저울포트
     LinkPort      : Integer;
     Link2Port     : Integer;
     ScalePort1    : Integer;      //저울포트
     Cid_Port      : Integer;      //CID포트
     DemonCid_Port : Integer;
     Check_Port    : Integer;      //수표인식기
     HandScannerPort  : Integer;      //스캐너포트
     FixScannerPort   : Integer;
     TableKeyPort  : Integer;      //테이블키포트
     LabelPrinterPort:Integer;
     PassPortPort  : Integer;      //여권리더기
     BellPort      : Integer;      //진동벨 포트
     LinkPrinterCode :String;
     Link2PrinterCode :String;
     CustPrinterCode :String;      //고객주문서 출력프린터코드
     CustPrinter2Code :String;      //고객주문서 출력프린터코드 (두번째)
     DeliveryPrinterCode:String;   //배달전표 출력프린터코드
     BaeminKitchPrint :Boolean;    //배달의민족 주문시 주방출력
     DeliveryReceiptPrinterCode:String; //배달 고객영수증 출력프린터 코드
     DeliveryDisplay :String;
     IsFloorFix    : Boolean;
     DualSize      : Integer;      //듀얼해상도(0:800X600, 1:800X480)
     DualMode      : Integer;      //듀얼모드(0:일반, 1:판매화면 안보임)
     DualText      : String;
     ICReaderPort  : Integer;
     ICReaderBaudRate:Integer;
     PrintColum    : Integer;      //0:42칼럼, 1:48칼럼

     pnt_min_use   : Integer;      //최소사용포인트
     Options       : String;
     HeadOptions   : String;       //표준 환경설정

     PosCatUse     : Boolean;      //보안 방식일때 이포스만 단말기 연동으로 사용할때
     IsCardOut     : Boolean;      //단말기승인시 (True-가맹점번호만 입력)
     van_trd       : Integer;      //밴사
     van_Terid     : String;       //밴사터미널 ID
     BizNo         : String;       //사업자번호
     van_ip        : String;       //밴사IP
     van_port      : Integer;      //밴사PORT
     EtcSign       : Boolean;      //전자서명 사용여부(KIS밴만 가능)
     EtcSignPort   : Integer;      //전자서명패드연결포트
     Van_Pass      : AnsiString;   //금융결제원밴사용시 암호
     SerialNo      : AnsiString;   //Koces 사용시 단말기 시리얼번호
     van_tax       : Integer;      //Tid별 과세구분(0:과세, 1:면세)
     Van_Dev       : String;
     VanWorkingKey : String;                      //금융결제원 WorkingKey

     ReceiptTitle  : Array[1..4] of String;       //영수증타이틀
     rcp_end       : Array[1..8] of String;       //영수증끝메세지
     dual_msg      : Array[1..8] of String;       //듀얼메세지
     card_end      : Array[1..5] of String;
     delivery_end  : Array[1..5] of String;

     PluNo         : String[2];    //PLU구분
     PluNo1        : String[2];    //PLU구분(선불제)
     PluNo2        : String[2];    //PLU구분(배달)
     ListFontSize  : Integer;
     ListRowHeight : Integer;
     PluFontSize   : Integer;
     DualGridFontSize : Integer;
     DualGridRowHeight: Integer;
     fixdcCode     : String;
     dc_unit       : Integer;      //할인률 할인단위
     len_card      : Integer;      //회원카드 길이
     PreFix        : String;       //회원카드프리픽스
     len_card2     : Integer;      //회원카드 길이
     PreFix2       : String;       //회원카드프리픽스
     Red_Hour      : Integer;      //테이블색상을 변경할 입장시간

     TipType       : String[1];
     TipApply      : Integer;
     TipMenu       : String;
     TipTax        : String;

     BalancePrefix : String;       //저울바코드프리픽스
     CustOrderTitle: String;
     KitchenPrintTitle :String;    //주방주문서 타이틀
     ReportPwd     : String;
     RcpSearchPwd  : String;
     SimpleRcpTxt  : String;
     CustRcpEnd    : Array of String;
     ReadyTelCount : Integer;
     BookingMenu   : String;
     CouponPrefix  : String;

     Amt_DefReady  : Integer;      //기본준비금

     AutoUpdate    : Boolean;
     IsAcctKitchenPrint :Boolean;  //계산시 주방주문서를 출력할지 여부
     ReceiptLogPrint :Boolean;

     OverTimeTime   :Integer;
     OverTimeMenu   :String;
     OverTimeEach   :Integer;
     OverTimeAmt    :Integer;

     LogoClickExec   : Integer;     //0 : 디비연결, 1: 도움말, 2: 바탕화면
     IsLableView     : Boolean;     //저울판매에 라벨보기
     ScaleOrderPrint : Boolean;     //저울판매 주문일대 고객/주방주문서 출력여부(Fals:출력, True:출력안함)
     OrderAutoPrint  : Boolean;     //저울에서 주문 시 라벨자동출력
     WeightAutoPrint : Boolean;     //수동판매 시 중량을 입력하면 라벨을 출력합니다
     LabelPrintButton: Boolean;     //라벨출력버튼을 큰버튼으로 사용합니다
     ScaleFontSize   : Integer;
     Scalebowl1      : Integer;
     Scalebowl2      : Integer;
     Scalebowl3      : Integer;
     ScaleMenuStandardWeight: Integer;
     ScaleDev        : Integer;

     default_menu    : String;      //테이블에 기본메뉴

     MenuName        : AnsiString;
     TableName       : AnsiString;
     DamdangName     : AnsiString;

     PowerOff        : Boolean;
     KBankDcRate     : Integer;     //광주은행할인율
     MCardDcRate     : Integer;

     AcctSMSMessage  : String;      //계산시 문자메세지 내용

     KtTid           : String;
     KtUbms          : String;

     MemberDefaultMenu : String;
     BookingTime     : Integer;
     BookingEnd      : Integer;

     SmartOrangTimeOut :Integer;
     FixPhoneNo      : String;
     SetStampDc      : Integer;
     SetStampCount   : Integer;

     SmartPosDemon   : Boolean;
     SmartPad        : Boolean;

     //키오스크관련
     IsKiosk       : Boolean;
     IsKioskCash   : Boolean;      //현금을 사용하는 키오스크인지여부
     KioskGubun    : String;
     KioskPwd      : String;
     KioskDispenserPort :Integer;
     KioskAlarm    : Array[0..5] of Integer;   //키오스크 알람(0:1000원 준비금, 1:100원 준비금 2:1000원 방출수량, 3:100원 방출수량, 4:1000원 중지, 5:100원 중지)
     KioskCashPause: Boolean;     // 잔돈부족으로 현금 일시중지(true :중지, false: 정상)
     notKioskTouch    : Boolean;
     TimePLU         : Array[1..3,  0..3] of String;

     UplusJoinCode   : String;
     BaeminMenuCode  : String;


     PosWidth,
     PosHeight       : Integer;
     DesignCode      : String;
     PluCode         : String;

     PluClassColor : TColor;
     PluMenuColor  : TColor;
     PluClassDownColor :TColor;
     PluClassDownFontColor :TColor;

     PluMenuFont,
     PluClassFont  : TFont;

     PluClassHeight,
     PluClassWidth,
     PluClassX,
     PluClassY,
     PluMenuX,
     PluMenuY :Integer;

    //하단 판넬 설정값
     PanelConfig  :String;
     PanelWidth : array [1..4] of Integer;
     PanelHeight : Integer;
     TitleCaption : String;
     TitleWidth : array [1..6] of Integer;
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
     amt_zeropay    : Integer;   //제로페이
     amt_check      : Integer;   //수표매출
     amt_gift       : Integer;   //상품권매출
     amt_bank       : Integer;   //계좌입금
     amt_point      : Integer;   //포인트결제
     amt_etc        : Integer;   //기타금액
     amt_cashtip    : Integer;   //현금봉사료
     amt_cardtip    : Integer;   //카드봉사료
     amt_service    : Integer;   //서비스금액
     dc_menu        : Integer;   //메뉴할인
     dc_member      : Integer;   //회원할인
     dc_code        : Integer;   //지정할인
     dc_receipt     : Integer;   //영수증전체할인
     dc_enuri       : Integer;   //에누리할인
     dc_spc         : Integer;   //행사할인
     dc_event       : Integer;   //영수증번호 행사할인
     dc_cut         : Integer;
     dc_vat         : Integer;   //부가세할인
     dc_point       : Integer;
     dc_kbank       : Integer;
     dc_mcard       : Integer;
     dc_kt          : Integer;
     dc_ohpoint     : Integer;
     dc_coupon      : Integer;
     dc_taxfree     : Integer;
     dc_stamp       : Integer;
     dc_uplus       : Integer;
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
  end;

  TFloor = record
     Code        : String;       //층코드
     Number      : Integer;      //테이블 Number Font 크기
     Caption     : Integer;      //테이블 Caption Font 크기
     Amount      : Integer;      //테이블 Amount Font 크기
     Bottom      : Integer;      //테이블 Buttom Font 크기
     Corner      : String;
  end;

  TItemMenu = record
    Code      : String;
    Name      : String;
    Price     : Integer;
    Qty       : Integer;
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
     VanPWD     :String;       //밴패스워드
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

  TDeliveryOrderMenu = record
    MenuCode      :String;
    Qty           :Integer;
    ItemCode      :String;
    ItemPrice     :Integer;
    ItemMenu      :String;
  end;

  TCourseOrderMenu = record
    Step        : Integer;
    MenuName    : String;
    MenuCode    : String;
    KitchenCode : String;
    OrderQty    : Integer;
  end;

