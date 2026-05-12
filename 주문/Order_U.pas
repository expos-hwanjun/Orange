
unit Order_U;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ExtCtrls, Grids, Math,   DB,
  Common_U, ActnList, MaskUtils, jpeg, Buttons, cxControls,
  cxContainer, cxEdit, cxLabel, POSCard, DateUtils, AdvGlassButton, PosButton,
  Menus, cxLookAndFeelPainters, MemDS, DBAccess, Uni, dxmdaset,
  cxGraphics, cxLookAndFeels, IdTCPClient, cxTextEdit, cxCurrencyEdit,
  cxImage, MMSystem, cxButtons, cxGroupBox, IniFiles, AppEvnts, System.Actions,
  cxCalendar, AdvShape, AdvPanel, dxGDIPlusClasses, AdvGlowButton,
  AdvSmoothToggleButton, ToolPanels, AdvLabel, idGlobal, nrclasses,
  AdvSmoothPanel, KeyPad_F, PNGImage, AdvSmoothButton, dxRatingControl,
  System.ImageList, Vcl.ImgList, cxClasses, GDIPFill, AdvTimePickerDropDown,
  AdvScrollBox, Winapi.DirectShow9, Winapi.DirectDraw, ActiveX, AdvBadge,
  MMDevApi, Vcl.ComCtrls, REST.Client, REST.Types, System.JSON, cxTrackBar,
  AudioEndpointVolume;
type
  TKioskOrderInfo = record
    GroupBox     :TPanel;
    MainMenu     :TcxLabel;
    MenuPrice    :TcxLabel;
    SubMenu      :TcxLabel;
    OrderQty     :TcxLabel;
    AddButton    :TAdvSmoothToggleButton;
    CancelButton :TAdvSmoothToggleButton;
  end;
  PKioskOrderInfo = ^TKioskOrderInfo;
type
  TPluClassData = record
    ClassCode       : String;
    ClassName       : String;
    Position        : Integer;
    Color           : TColor;
  end;
  PPluClassData = ^TPluClassData;
type
  TKioskButtonList = record
    GroupBox       :TAdvPanel;
    MenuImage      :TcxImage;
    EventImage     :TcxImage;
    DisableImage   :TcxImage;
    MenuName       :String;
    MenuCode       :String;
    MenuPrice      :String;
    MenuType       :String;
    isSoldOut      :Boolean;
    Qty            :TcxLabel;
    OrderTime      :TcxLabel;
    isPassWord     :Boolean;
  end;
  PKioskButtonList = ^TKioskButtonList;
type
  TPluMenuData = record
    ClassCode : String;
    MenuCode  : String;
    MenuNo    : String;
    MenuName  : String;
    SalePrice : Integer;
    MenuType  : String;
    Position  : Integer;
    Color     : TColor;
    SoldOut   : Boolean;
    SelectQty : Integer;
  end;
  PPluMenuData = ^TPluMenuData;
type TKioskClass = record
  Color           :TColor;
  DownColor       :TColor;
  BorderColor     :TColor;
  BorderDownColor :TColor;
  FontColor       :TColor;
  FontDownColor   :TColor;
  Round           :Integer;
end;
type TKioskVanMode  = (kvmOne, kvmMulti);

type
  TOrder_F = class(TForm)
    TmrMsg: TTimer;
    AccountActionList: TActionList;
    Act_Course: TAction;
    Act_OpenSet: TAction;
    Act_Card: TAction;
    Tmr_Card: TTimer;
    FunctionActionList: TActionList;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action5: TAction;
    Action6: TAction;
    Action7: TAction;
    Action8: TAction;
    Action9: TAction;
    Action10: TAction;
    Action11: TAction;
    Action12: TAction;
    Action13: TAction;
    Action14: TAction;
    lbl_Damdang: TLabel;
    Action15: TAction;
    Action16: TAction;
    Action17: TAction;
    Action18: TAction;
    Act_Check: TAction;
    Act_Trust: TAction;
    Act_Cash: TAction;
    Act_Point: TAction;
    Act_CashRcp: TAction;
    Action19: TAction;
    Action20: TAction;
    Cancel_sGrd: TStringGrid;
    Tmr_Acct: TTimer;
    Action21: TAction;
    Action22: TAction;
    lblPinCode: TLabel;
    Action38: TAction;
    Action23: TAction;
    Tmr_Start: TTimer;
    panPLU: TPanel;
    Tmr_Change: TTimer;
    OrderMenuLabel: TcxLabel;
    Tmr_MenuShow: TTimer;
    UniQuery: TUniQuery;
    Act_Gift: TAction;
    Action24: TAction;
    Action25: TAction;
    Action26: TAction;
    Action27: TAction;
    Action28: TAction;
    Tmr_Time: TTimer;
    Action29: TAction;
    Action30: TAction;
    Action31: TAction;
    Action32: TAction;
    Tmr_IC: TTimer;
    Action33: TAction;
    lbl_BeforeAcct: TLabel;
    Action34: TAction;
    Action35: TAction;
    Action36: TAction;
    Act_Enter: TAction;
    KioskWaitPanel: TPanel;
    Tmr_KioskWait: TTimer;
    ApplicationEvents: TApplicationEvents;
    panOrder: TcxGroupBox;
    ImgOrderAcct: TImage;
    lblTableInfo: TcxLabel;
    lblOrderAmt: TcxLabel;
    Action37: TAction;
    Tmr_KioskImageChange: TTimer;
    PluMenuPanel: TPanel;
    PluClassPanel: TPanel;
    PosNoLabel: TLabel;
    WorkDateLabel: TLabel;
    UserImage: TImage;
    OpenDateImage: TImage;
    MessageImage: TImage;
    Present_sGrd: TStringGrid;
    Main_sGrd: TStringGrid;
    GridTitleShape: TAdvShape;
    TitleLabel: TLabel;
    DuthPayLabel: TLabel;
    CloseButton: TcxButton;
    Act_Cancel: TAction;
    Act_Bank: TAction;
    Act_Etc: TAction;
    CardLogButton: TAdvGlassButton;
    PresnetPanel: TAdvSmoothPanel;
    TotalAmtLabel: TcxLabel;
    TotalDcAmtLabel: TcxLabel;
    WGetAmtLabel: TcxLabel;
    GetAmtLabel: TcxLabel;
    Bevel1: TBevel;
    GetCaptionLabel: TcxLabel;
    WGetCaptionLabel: TcxLabel;
    TotalDcCaptionLabel: TcxLabel;
    TotalCaptionLabel: TcxLabel;
    KioskPanel: TPanel;
    lbl_KioskClose: TcxLabel;
    KioskWrcvAmtLabel: TcxLabel;
    lbl_KioskOrderCount: TcxLabel;
    KioskPLUMenuPanel: TPanel;
    KioskDcAmtLabel: TcxLabel;
    KioskOrderAmtLabel: TcxLabel;
    KioskOrderMenuPanel: TPanel;
    AccountButtonPanel: TAdvSmoothPanel;
    FunctionButtonPanel: TAdvSmoothPanel;
    MemberInfoPanel: TAdvSmoothPanel;
    OrderTableLabel: TLabel;
    lbl_OrderCount: TLabel;
    LastVisitDatetLabel: TLabel;
    MemberNameLabel: TLabel;
    PointLabel: TLabel;
    KeyPadPanel: TAdvSmoothPanel;
    fmKeyPad: TfmKeyPad;
    InputEdit: TcxTextEdit;
    Action39: TAction;
    NoTransImage: TImage;
    NoTransLabel: TLabel;
    Action40: TAction;
    Action41: TAction;
    Act_AHeadPay: TAction;
    KioskPLUClassPanel: TAdvPanel;
    ImageCollection: TcxImageCollection;
    ImageCollectionRed0: TcxImageCollectionItem;
    ImageCollectionRed: TcxImageCollectionItem;
    ImageCollectionBlack: TcxImageCollectionItem;
    ImageCollectionBlack0: TcxImageCollectionItem;
    ImageCollectionBlue: TcxImageCollectionItem;
    ImageCollectionBlue0: TcxImageCollectionItem;
    KioskClassNextButton: TAdvSmoothToggleButton;
    KioskClassPriorButton: TAdvSmoothToggleButton;
    KioskInitButton: TAdvSmoothButton;
    KioskCallButton: TAdvSmoothButton;
    KisokStampButton: TAdvSmoothButton;
    KioskMemberJoinButton: TAdvSmoothButton;
    KioskTrustButton: TAdvSmoothButton;
    KioskPointUseButton: TAdvSmoothButton;
    KioskEasyPayButton: TAdvSmoothButton;
    KioskOrderButton: TAdvSmoothButton;
    KioskPointSearchButton: TAdvSmoothButton;
    KioskCashButton: TAdvSmoothButton;
    KioskCardButton: TAdvSmoothButton;
    Action42: TAction;
    Action43: TAction;
    Action44: TAction;
    Action45: TAction;
    ClockButton: TAdvSmoothToggleButton;
    Tmr_Clock: TTimer;
    KioskOrderMenuScrollBox: TAdvScrollBox;
    PrintOptionPanel: TAdvToolPanel;
    Shape1: TShape;
    cxGroupBox1: TcxGroupBox;
    CardPrintSplitOffButton: TAdvSmoothToggleButton;
    CardPrintSplitOnButton: TAdvSmoothToggleButton;
    MenuPrintGroupBox: TcxGroupBox;
    MenuPrintYesButton: TAdvSmoothToggleButton;
    MenuPrintNoButton: TAdvSmoothToggleButton;
    KitchenPrintGroupBox: TcxGroupBox;
    KitchenReceiptOnButton: TAdvSmoothToggleButton;
    KitchenReceiptOffButton: TAdvSmoothToggleButton;
    cxGroupBox4: TcxGroupBox;
    CardPrintAtOnceYesButton: TAdvSmoothToggleButton;
    CardPrintAtOnceNoButton: TAdvSmoothToggleButton;
    ReceiptPrintGroupBox: TcxGroupBox;
    ReceiptPrintYesButton: TAdvSmoothToggleButton;
    ReceiptPrintNoButton: TAdvSmoothToggleButton;
    BillPrintGroupBox: TcxGroupBox;
    BillPrintYesButton: TAdvSmoothToggleButton;
    BillPrintNoButton: TAdvSmoothToggleButton;
    PrintOptionButton: TAdvGlassButton;
    ReceiptPrintButton: TAdvGlassButton;
    BillPrintButton: TAdvGlassButton;
    KitchenPrintButton: TAdvGlassButton;
    MenuPrintButton: TAdvGlassButton;
    ReceiptPrintOnButton: TAdvGlassButton;
    BillPrintOnButton: TAdvGlassButton;
    KitchenPrintOnButton: TAdvGlassButton;
    MenuPrintOnButton: TAdvGlassButton;
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
    FunctionImageCollectionItem22: TcxImageCollectionItem;
    FunctionImageCollectionItem23: TcxImageCollectionItem;
    FunctionImageCollectionItem24: TcxImageCollectionItem;
    FunctionImageCollectionItem25: TcxImageCollectionItem;
    FunctionImageCollectionItem26: TcxImageCollectionItem;
    FunctionImageCollectionItem27: TcxImageCollectionItem;
    FunctionImageCollectionItem28: TcxImageCollectionItem;
    FunctionImageCollectionItem29: TcxImageCollectionItem;
    FunctionImageCollectionItem30: TcxImageCollectionItem;
    FunctionImageCollectionItem31: TcxImageCollectionItem;
    FunctionImageCollectionItem32: TcxImageCollectionItem;
    FunctionImageCollectionItem33: TcxImageCollectionItem;
    FunctionImageCollectionItem34: TcxImageCollectionItem;
    FunctionImageCollectionItem35: TcxImageCollectionItem;
    FunctionImageCollectionItem36: TcxImageCollectionItem;
    FunctionImageCollectionItem37: TcxImageCollectionItem;
    FunctionImageCollectionItem38: TcxImageCollectionItem;
    FunctionImageCollectionItem39: TcxImageCollectionItem;
    FunctionImageCollectionItem40: TcxImageCollectionItem;
    FunctionImageCollectionItem41: TcxImageCollectionItem;
    FunctionImageCollectionItem42: TcxImageCollectionItem;
    FunctionImageCollectionItem43: TcxImageCollectionItem;
    FunctionImageCollectionItem44: TcxImageCollectionItem;
    FunctionImageCollectionItem45: TcxImageCollectionItem;
    ImageCollectionItem1: TcxImageCollectionItem;
    ImageCollectionItem2: TcxImageCollectionItem;
    AcctImageCollection: TcxImageCollection;
    AcctImageCollectionItem1: TcxImageCollectionItem;
    AcctImageCollectionItem2: TcxImageCollectionItem;
    AcctImageCollectionItem3: TcxImageCollectionItem;
    AcctImageCollectionItem4: TcxImageCollectionItem;
    AcctImageCollectionItem5: TcxImageCollectionItem;
    AcctImageCollectionItem6: TcxImageCollectionItem;
    AcctImageCollectionItem7: TcxImageCollectionItem;
    AcctImageCollectionItem8: TcxImageCollectionItem;
    AcctImageCollectionItem9: TcxImageCollectionItem;
    AcctImageCollectionItem10: TcxImageCollectionItem;
    AcctImageCollectionItem11: TcxImageCollectionItem;
    AcctImageCollectionItem12: TcxImageCollectionItem;
    GroupTable_sGrd: TStringGrid;
    FlageCollection: TcxImageCollection;
    FlageCollectionItem1: TcxImageCollectionItem;
    FlageCollectionItem2: TcxImageCollectionItem;
    FlageCollectionItem4: TcxImageCollectionItem;
    KioskMenuPriorButton: TAdvSmoothToggleButton;
    KioskMenuNextButton: TAdvSmoothToggleButton;
    KioskMenuPageLabel: TcxLabel;
    AviTimer: TTimer;
    KioskStoreNameLabel: TcxLabel;
    KioskWaitImagePanel: TPanel;
    ImageCollectionItem3: TcxImageCollectionItem;
    Action46: TAction;
    FunctionImageCollectionItem46: TcxImageCollectionItem;
    Tmr_Close: TTimer;
    ImageCollectionItem4: TcxImageCollectionItem;
    ImageCollectionItem5: TcxImageCollectionItem;
    Tmr_KioskStart: TTimer;
    ImageCollectionIDiscount: TcxImageCollectionItem;
    BackButton: TAdvSmoothToggleButton;
    Act_EasyPay: TAction;
    AcctImageCollectionItem13: TcxImageCollectionItem;
    KioskWaitBottomPanel: TPanel;
    KioskLanguagePanel: TPanel;
    GermanButton: TAdvSmoothButton;
    ChinaButton: TAdvSmoothButton;
    JapanButton: TAdvSmoothButton;
    VitnamButton: TAdvSmoothButton;
    ThaiButton: TAdvSmoothButton;
    IndoButton: TAdvSmoothButton;
    FrenchButton: TAdvSmoothButton;
    UsaButton: TAdvSmoothButton;
    KioskStoreButton: TAdvSmoothButton;
    KioskTakeOutButton: TAdvSmoothButton;
    KoreaButton: TAdvSmoothButton;
    BadgeImageCollection: TcxImageCollection;
    BadgeImageCollectionItem1: TcxImageCollectionItem;
    BadgeImageCollectionItem2: TcxImageCollectionItem;
    BadgeImageCollectionItem3: TcxImageCollectionItem;
    ImageCollectionSoldOut: TcxImageCollectionItem;
    FlageCollectionItem5: TcxImageCollectionItem;
    FlageCollectionItem6: TcxImageCollectionItem;
    FlageCollectionItem7: TcxImageCollectionItem;
    FlageCollectionItem8: TcxImageCollectionItem;
    FlageCollectionItem9: TcxImageCollectionItem;
    FlageCollectionItem10: TcxImageCollectionItem;
    FlageCollectionItem11: TcxImageCollectionItem;
    FlageCollectionItem13: TcxImageCollectionItem;
    FlageCollectionItem14: TcxImageCollectionItem;
    FlageCollectionItem15: TcxImageCollectionItem;
    FlageCollectionItem16: TcxImageCollectionItem;
    FlageCollectionItem17: TcxImageCollectionItem;
    FlageCollectionItem18: TcxImageCollectionItem;
    KioskFlagButton: TAdvSmoothButton;
    FlagPanel: TPanel;
    Flag8Panel: TPanel;
    cxLabel2: TcxLabel;
    FlagGermanButton: TAdvSmoothButton;
    Flag0Panel: TPanel;
    FlagKoreaButton: TAdvSmoothButton;
    cxLabel1: TcxLabel;
    Flag4Panel: TPanel;
    cxLabel4: TcxLabel;
    FlagfVitnamButton: TAdvSmoothButton;
    Flag3Panel: TPanel;
    cxLabel5: TcxLabel;
    FlagJapanButton: TAdvSmoothButton;
    Flag2Panel: TPanel;
    cxLabel7: TcxLabel;
    FlagChinaButton: TAdvSmoothButton;
    Flag1Panel: TPanel;
    cxLabel8: TcxLabel;
    FlagUsaButton: TAdvSmoothButton;
    Flag5Panel: TPanel;
    cxLabel9: TcxLabel;
    FlagThaiButton: TAdvSmoothButton;
    Flag6Panel: TPanel;
    cxLabel10: TcxLabel;
    FlagIndoButton: TAdvSmoothButton;
    Flag7Panel: TPanel;
    cxLabel11: TcxLabel;
    FlagFrenchButton: TAdvSmoothButton;
    FlageCollectionItem19: TcxImageCollectionItem;
    FlageCollectionItem20: TcxImageCollectionItem;
    KioskWaitFlagButton: TcxButton;
    ImageCollectionDisable: TcxImageCollectionItem;
    Action47: TAction;
    FunctionImageCollectionItem47: TcxImageCollectionItem;
    DeliveryPanel: TAdvPanel;
    BadgeImageCollectionItem4: TcxImageCollectionItem;
    TableClearImage: TImage;
    DeliveryImageCollection: TcxImageCollection;
    DeliveryImageCollectionItem1: TcxImageCollectionItem;
    DeliveryImageCollectionItem2: TcxImageCollectionItem;
    DeliveryImageCollectionItem3: TcxImageCollectionItem;
    GroupOrderPanel: TAdvPanel;
    GroupOrder_sGrd: TStringGrid;
    GroupCloseButton: TcxButton;
    Action48: TAction;
    FunctionImageCollectionItem49: TcxImageCollectionItem;
    KioskBarrierfreeWheelChairButton: TAdvSmoothButton;
    FunctionImageCollectionItem48: TcxImageCollectionItem;
    Action49: TAction;
    Action50: TAction;
    Action51: TAction;
    FunctionImageCollectionItem50: TcxImageCollectionItem;
    FunctionImageCollectionItem51: TcxImageCollectionItem;
    Action52: TAction;
    FunctionImageCollectionItem52: TcxImageCollectionItem;
    KioskUseTypeButton: TAdvSmoothToggleButton;
    BadgeImageCollectionItem5: TcxImageCollectionItem;
    KioskWorkDateLabel: TAdvBadgeLabel;
    GridPriorButton: TAdvSmoothButton;
    GridNextButton: TAdvSmoothButton;
    CashRequestLabel: TLabel;
    KioskVoiceListenButton: TAdvSmoothButton;
    VolumePanel: TAdvPanel;
    VolumeTrackBar: TTrackBar;
    KioskVolumeUpButton: TAdvSmoothButton;
    KioskVolumeDownButton: TAdvSmoothButton;
    KioskBarrierfreeLowVisionButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure TmrMsgTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Act_CourseExecute(Sender: TObject);
    procedure Act_OpenSetExecute(Sender: TObject);
    procedure Present_sGrdDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Act_CardExecute(Sender: TObject);
    procedure Act_EnterExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Tmr_CardTimer(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure Action8Execute(Sender: TObject);
    procedure Action9Execute(Sender: TObject);
    procedure Action10Execute(Sender: TObject);
    procedure Action12Execute(Sender: TObject);
    procedure Action13Execute(Sender: TObject);
    procedure Action14Execute(Sender: TObject);
    procedure Action15Execute(Sender: TObject);
    procedure Action16Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action17Execute(Sender: TObject);
    procedure Action18Execute(Sender: TObject);
    procedure Action19Execute(Sender: TObject);
    procedure Action20Execute(Sender: TObject);
    procedure Act_TrustExecute(Sender: TObject);
    procedure Act_CheckExecute(Sender: TObject);
    procedure Act_PointExecute(Sender: TObject);
    procedure Act_CashExecute(Sender: TObject);
    procedure Act_CashRcpExecute(Sender: TObject);
    procedure Action21Execute(Sender: TObject);
    procedure Tmr_AcctTimer(Sender: TObject);
    procedure Action23Execute(Sender: TObject);
    procedure Action24Execute(Sender: TObject);
    procedure Action38Execute(Sender: TObject);
    procedure Action27Execute(Sender: TObject);
    procedure Tmr_StartTimer(Sender: TObject);
    procedure obtn_PluBackClick(Sender: TObject);
    procedure Tmr_ChangeTimer(Sender: TObject);
    procedure Tmr_MenuShowTimer(Sender: TObject);
    procedure Act_GiftExecute(Sender: TObject);
    procedure Action28Execute(Sender: TObject);
    procedure Action25Execute(Sender: TObject);
    procedure Action26Execute(Sender: TObject);
    procedure Action31Execute(Sender: TObject);
    procedure Tmr_TimeTimer(Sender: TObject);
    procedure Action32Execute(Sender: TObject);
    procedure Action30Execute(Sender: TObject);
    procedure Action36Execute(Sender: TObject);
    procedure Tmr_ICTimer(Sender: TObject);
    procedure Action33Execute(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Action34Execute(Sender: TObject);
    procedure obtn_KioskAdd1Click(Sender: TObject);
    procedure obtn_KioskCancel1Click(Sender: TObject);
    procedure obtn_KioskClass1Click(Sender: TObject);
    procedure lbl_KioskCloseClick(Sender: TObject);
    procedure KioskBeginImageClick(Sender: TObject);
    procedure Tmr_KioskWaitTimer(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG;
      var Handled: Boolean);
    procedure Action37Execute(Sender: TObject);
    procedure Tmr_KioskImageChangeTimer(Sender: TObject);
    procedure GridPriorButtonClick(Sender: TObject);
    procedure GridNextButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure Act_CancelExecute(Sender: TObject);
    procedure CardLogButtonClick(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure Action11Execute(Sender: TObject);
    procedure Action22Execute(Sender: TObject);
    procedure Act_BankExecute(Sender: TObject);
    procedure KioskCardButtonClick(Sender: TObject);
    procedure KioskCashButtonClick(Sender: TObject);
    procedure KioskTrustButtonClick(Sender: TObject);
    procedure KioskPointUseButtonClick(Sender: TObject);
    procedure KioskMemberJoinButtonClick(Sender: TObject);
    procedure KisokStampButtonClick(Sender: TObject);
    procedure KioskPointSearchButtonClick(Sender: TObject);
    procedure KioskOrderButtonClick(Sender: TObject);
    procedure KioskInitButtonClick(Sender: TObject);
    procedure KioskCallButtonClick(Sender: TObject);
    procedure KioskMenuNextButtonClick(Sender: TObject);
    procedure NoTransImageClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Action35Execute(Sender: TObject);
    procedure Action40Execute(Sender: TObject);
    procedure Action41Execute(Sender: TObject);
    procedure Action45Execute(Sender: TObject);
    procedure Action29Execute(Sender: TObject);
    procedure Tmr_ClockTimer(Sender: TObject);
    procedure ReceiptPrintYesButtonClick(Sender: TObject);
    procedure MenuPrintYesButtonClick(Sender: TObject);
    procedure PrintOptionButtonClick(Sender: TObject);
    procedure ReceiptPrintButtonClick(Sender: TObject);
    procedure ThaiButtonClick(Sender: TObject);
    procedure AviTimerTimer(Sender: TObject);
    procedure KioskStoreButtonClick(Sender: TObject);
    procedure KioskTakeOutButtonClick(Sender: TObject);
    procedure Action46Execute(Sender: TObject);
    procedure Tmr_KioskStartTimer(Sender: TObject);
    procedure BackButtonClick(Sender: TObject);
    procedure Act_EasyPayExecute(Sender: TObject);
    procedure KioskFlagButtonClick(Sender: TObject);
    procedure KioskTableClearButtonClick(Sender: TObject);
    procedure Action47Execute(Sender: TObject);
    procedure TableClearImageClick(Sender: TObject);
    procedure GroupTable_sGrdClick(Sender: TObject);
    procedure GroupOrderPanelCaptionClick(Sender: TObject);
    procedure GroupCloseButtonClick(Sender: TObject);
    procedure Action48Execute(Sender: TObject);
    procedure KioskBarrierfreeWheelChairButtonClick(Sender: TObject);
    procedure KioskZoomInButtonClick(Sender: TObject);
    procedure VolumeTrackBarChange(Sender: TObject);
    procedure Action49Execute(Sender: TObject);
    procedure Action50Execute(Sender: TObject);
    procedure Action51Execute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FWorkKind : TWorkKind;
    FKitchenPrintMode  :Boolean;
    FWorkState: TWorkState;
    FReceiptPrintMode  :TPrintMode;
    FBillPrintMode     :Boolean;
    FMenuPrintMode     :Boolean;
    FCardPrintMode     :Boolean;
    FSplitPrintMode    :Boolean;
  private
    AccountButton: array of array of TAdvSmoothButton;
    FunctionButton: array of array of TAdvSmoothButton;
    PluClassData : TList;
    PluClassButton :Array of TPosButton;
    PluClassPagaCount,     //한페이지에 버튼갯수
    PluClassMaxPage,       //최대페이지
    PluClassPage :Integer; //현재페이지
    PluMenuData  : TList;
    PluMenuButton :Array of TPosButton;
    PluMenuPagaCount,     //한페이지에 버튼갯수
    PluMenuMaxPage,       //최대페이지
    PluMenuPage :Integer; //현재페이지
    SaveMessageData:String;   //메세지저장
    OrgOrderAmt  :Integer;
    SvcWorkingAmt :Integer;                 //정상 주문을 서비스로 변경한 금액
    OrgSpcDcAmt  :Integer;
    IsEnter      :Boolean;
    SelectedClass:String;
    IsAcctChange :Boolean;
    RestoreSale   :String;
    RestoreQty,
    RestorePrice  :Integer;
    bRestore      :Boolean;
    bDouble       :Boolean;
    bGroupAddTime :Boolean;  //그룹디테일 추가요금
    OrgCashAmt,              //현금선결제
    OrgCardAmt :Integer;     //카드선결제
    FMemo         :String;   //주방메모(수량추가시 사용)
    ErrMsg        :String;
    IsExecuteCard :Boolean;
    ScaleData     :String;
    FIsLastTakeOut :Boolean;
    IsCutDc :Boolean;
    MainKitchen :String;
    UserWork :String;
    isKitchenPrint :Boolean;     //주방주문서 출력여부
    PLUClickTime,
    FunctionClickTime,
    AcctClickTime,
    ClickTime :TDateTime;
    Option60 :Char;
    LetsOrderButtonRow,
    LetsOrderButtonCol :Integer;
    SmartPadLastTimer :TDateTime;
    isCheckMobileNo :Boolean;     // 호출전화번호를 지정할때만 입력받기위함(버튼이 있으면동작)
    MobileFunctionButtonX,
    MobileFunctionButtonY : Integer;
    wsReadyApply :Boolean;
    LastFunctionAction :String;
    LastFunctionTime   :TDateTime;
    OrderCourseMenu  :Array of ^TCourseOrderMenu;
    KioskClass  :TKioskClass;
    KioskButtonList : Array of TKioskButtonList;
    KioskClassCode :String;  //선택된 PLU 분류코드
    KioskClassTotalPage,          //분류PLU 총페이지
    KioskClassCount,
    FKioskClassPage :Integer;      //분류PLU 현재 페이지
    KioskTotalPage,          //메뉴PLU 총페이지
    KioskMenuCount,
    FKioskPage :Integer;      //메뉴PLU 현재 페이지
    KioskOrderMenu : Array of TKioskOrderInfo;
    tmpKioskOrderMenu : Array of TKioskOrderInfo;
    KioskPluWidth,
    KioskPluHeight :Integer;
    KioskPluNo :String;
    DispenserData :String;
    KioskMainImageFileName,
    KioskChiarImageFileName,
    KioskVisionImageFileName :String;

    KisokWaitImage       :TImage;
    KioskBeginImageExist :Boolean;
    KioskBeginImageIndex :Integer;   //키오스크 판매대기 이미지 순번
    KioskBeginImageCount :Integer;
    KioskBeginImageChangeTime:Integer; //초
    KioskDefaultOrderType :Integer;  //0:매장이용, 1:포장
    KioskFlagAlwaysShow :Boolean; //키오스크 코스 수량적용 용
    KioskCourseQty,
    KioskCourseRow :Integer;
    FilterGraph: IGraphBuilder; // 필터그래프
    MediaControl: IMediaControl; // 동영상 재생, 정지, 제어
    VideoWindow: IVideoWindow; // 동영상을 재생할 윈도우
    MediaEvent: IMediaEventEx; // DSHOW 이벤트 제어
    AvailableDS: Boolean;
    BasicAudio      : IBasicAudio; // Volume/Balance control.
    isFirst : Boolean;
    isTouch : Boolean;
    VideoRenderOrgMethod: TWndMethod;
    function   GetGridMenuSeq:Integer;

    function   SelectMenu(aGubun:Integer;aDcMenu:Integer=0):Boolean;                               //메뉴조회(0:PLU, 1:저울, 2:보류복원)
    procedure  SetOrderMenu(aTable:Integer;aOrderType:String;aCashOrder:Boolean=false);
    function   Goods_QtyAdd(aAdd:Boolean=false):Boolean;                                           //상품수량 추가
    procedure  QtyChg_SGrdApply(aMenu,DsSale, aItem:String;aQty,aPrice,aMenuDc:Integer);           //상품수량 변경시 집계그리드 변경
    procedure  Goods_QtyDec(aMenu, aItem:String; aQty,aPrice,aMenuDc:Integer;aPrint,aService:String);           //상품수량 변경시 메인그리드 변경
    procedure  SummaryGrid_ItemAdd(vQty:String);                               //집계그리드에 상품추가
    procedure  AmtReCompute(AQty,ARow:integer);                                //상품수량 변경에 따른 합계금액 재계산
    procedure  SetRowSelect(const AKind:String = '-');                         //메인그리드에서 세트메뉴시 부속메뉴선택시 원메뉴로 선택되게
    procedure  SetRowNumber;                                                   //그리드에 순번보이기
    function   ShowOrderCancelForm:String;                                     //주문취소폼 보이기
    procedure  PreSentGridDisplay;
    procedure  DisplayMessage(aState:Integer;aMsg:String);                       //메세지출력 0:알림, 1:오류, 3:정보
    function   CheckGroupDetail:Boolean;
    function   CheckGroupType:Boolean;                                         //그룹서브이면 정산을 할수 없음
    function   CheckPresentChange(aType:Integer=0):Boolean;                    //입금조정 처리중인지 체크(0:결제변경시 메뉴수정못할때 , 1:결제변경시 메뉴수정가능할때)
    function   CheckSaleFinish:Boolean;                                        //정산이 완료됐는지 여부
    procedure  SetKitchenOrderData;                                            //주방주문서를 조합함
    function   SetAgeCode:String;                                              //연령대코드를 조합한다
    procedure  SaveAuditor(aType,aMenu:String; aQty, aPrice, aAmnt:Integer);
    procedure  SetWorkKind(AValue:TWorkKind);
    procedure  SetReceiptPrintMode(AValue:TPrintMode);
    procedure  SetBillPrintMode(AValue:Boolean);
    procedure  SetMenuPrintMode(AValue:Boolean);
    procedure  SetKitchenPrintMode(AValue:Boolean);
    procedure  SetCardPrintMode(aValue:Boolean);
    procedure  SetSplitPrintMode(aValue:Boolean);
    function   GetHoldCount:Integer;
    procedure  SetNoTransCount;
    function   SelfCashRcp(aSaleAmt:Integer):Boolean;
    procedure  SetCodeDc;
    function   CheckPrevAccount:Boolean;            //다른포스에서 선결제가 있는지 체크
    procedure  ReDrowGridTitle;
    procedure  CidReadEvent(const S: String);
    procedure  ScannerReadEvent(const S : String);
    procedure  SetWorkState(aValue:TWorkState);
    procedure  ExecCard(aEasyPay:Boolean=false);
    procedure  DeliveryButtonClick(Sender: TObject);
    procedure  PluClassButtonCreate;
    procedure  SetPluClassData;                   //PLU 분류데이터 설정
    procedure  ShowPluClassButton;                //PLU 분류버튼 보이기
    procedure  PluClassButtonClick(Sender: TObject);
    procedure  PluClassPriorButtonClick(Sender :TObject);
    procedure  PluClassNextButtonClick(Sender :TObject);
    procedure  PluMenuButtonCreate;
    procedure  SetPluMenuData(aClassCode:String);  //PLU 메뉴데이터 설정
    procedure  ShowPluMenuButton;                  //PLU 메뉴버튼 보이기
    procedure  PluMenuButtonClick(Sender: TObject);
    procedure  PluMenuPrevButtonClick(Sender :TObject);
    procedure  PluMenuNextButtonClick(Sender :TObject);
    procedure  AccountButtonClick(Sender: TObject);
    procedure  AccountButtonCreate;
    procedure  FunctionButtonCreate;
    procedure  FunctionButtonClick(Sender: TObject);
    procedure  FinishExecute(aLog:String; aMust:Boolean=false);
    procedure  FreePluClassList(AList: TList);
    procedure  FreePluMenuList(AList: TList);
    procedure  FreeCourseOrderDataList(AList: TList);
    function   GetMenuOrderCheck(aMenuCode:String):Boolean;


    procedure  OrderListView;
    procedure  KioskClassPLUCreate;
    procedure  KioskMenuPLUCreate;
    procedure  KioskMenuPlu1Click(Sender: TObject);
    procedure  KioskOrderMenuCreate;
    procedure  KioskSetClassPLU;
    procedure  KioskSetMenuPLU;
    procedure  SetKioskClassPage(AValue :Integer);
    procedure  SetKioskPage(AValue :Integer);
    function   GetKioskPLU(aCheck:Boolean=false):String;
    function   SetKioskCash:Boolean;
    function   KioskMemberSelect(aTelNo:String=''):Boolean;
    procedure  DispenderReset;
    procedure  DispenserReadEvent(const S : String);
    procedure  WMCopyData(var Msg:TWmCopyData); message WM_CopyData;
    procedure  SetKioskBeginImage;
    function   KioskTableSelect:Boolean;
    function   KioskCardExecute(aEasyPay:Boolean=false):Boolean;
    procedure  KioskMenuOrder;
    procedure  SetKioskMenuButtonStatus(aMenuCode, aQty:String);
    procedure  KioskOrderStart(aType:Integer);
    procedure  KioskTableCreate(aRefresh:Boolean=false);
    procedure  KioskTableClick(Sender: TObject);
    function   KioskMenuLimitCheck:Boolean;
    procedure  VideoRenderWndProc(var Msg: TMessage);
    function   SetupDs: Boolean;
    function   ShutDownDs: Boolean;
    procedure  SetVolume(value:Integer);
    function   GetVolume:Integer;
    procedure  WMDeviceChange(var Msg: TMessage); message WM_DEVICECHANGE;
    property   WorkState  :TWorkState         read FWorkState         write SetWorkState;
    property   HoldCount  :Integer            read GetHoldCount;
    property   ReceiptPrintMode  :TPrintMode  read FReceiptPrintMode  write SetReceiptPrintMode;          //영수증 출력여부
    property   BillPrintMode     :Boolean     read FBillPrintMode     write SetBillPrintMode;             //고객주문서 출력여부
    property   MenuPrintMode     :Boolean     read FMenuPrintMode     write SetMenuPrintMode;             //영수증에 메뉴 출력여부
    property   KitchenPrintMode  :Boolean     read FKitchenPrintMode  write SetKitchenPrintMode;          //주방주문서 출력여부
    property   CardPrintMode     :Boolean     read FCardPrintMode     write SetCardPrintMode;          //주방주문서 출력여부
    property   SplitPrintMode    :Boolean     read FSplitPrintMode     write SetSplitPrintMode;          //주방주문서 출력여부
    property   KioskClassPage    :Integer     read FKioskClassPage    write SetKioskClassPage;
    property   KioskPage :Integer             read FKioskPage         write SetKioskPage;
  public
    FMenuCode  : String;
    FMenuName  : String;
    FItemCode  : String;
    FMsrData   : String;
    FCardData  : String;
    FTipType   : String[1];
    FTipApply  : Integer;
    FInScaleData : Boolean;
    ItemData   : Array[1..50] of TItemMenu;
    FCidData   : String;
    isPLUReFlash :Boolean;
    CourseMenuCount :Integer;
    KioskStartKey :Integer;
    endpointvolume :IAudioEndpointVolume;
    procedure  GetItemMenu(aValue:String);
    procedure  MainGrid_add(aGrid:TStringGrid=nil);                            //메인그리드에 상품추가
    function   SaveDeliveryAmnt(aAccount:Boolean;aOrderAmt:Integer):String;
    function   OrderCancelDBApply(aKind:Integer=0):Boolean;                    //주문취소DB에 적용
    procedure  DisplayPresent;       //합계금액 Display
    property   WorkKind   :TWorkKind          read FWorkKind          write SetWorkKind;
  end;
var
  Order_F: TOrder_F;
const
  QtyBadge : array [0..14] of String = ('①','②','③','④','⑤','⑥','⑦','⑧','⑨','⑩','⑪','⑫','⑬','⑭','⑮');
  WM_GRAPHEVENT = WM_APP + 1;
implementation
uses GlobalFunc_U, Card_U, Check_U, OrderCancel_U, Discount_U,
     Course_U, OpenSet_U, Cash_U, DualOrder_U,
     KitchenMemo_U, StrUtils, Member_U,
     CustomerInfo_U, DBModule_U, Hold_U, MenuItem_U, Config_U, RcpChange_U,
     CardLog_U, DeliveryInfo_U, Delivery_U,
     MenuAdd_U, MenuSearch_U, DualOrder800_U,
     DeliveryNew_U, UPSS_U, Wait_U, Booking_U,
     TaxfreeD_U, KioskOrderConfirm_U, KioskItem_U, KioskCash_U,
     KioskCard_U, KioskKeyPad_U, KioskBillInfo_U, KioskTable_U, KioskMemo_U,
     KioskItem2_U, KioskMemberAdd_U, KioskCourse_U, KioskGroup_U,
     MenuSearch2_U, Table_U, KioskSign, Const_U, KioskEasyPay_U, LetsOrderTakeOut_U,
     AHeadChoose_U, LetsOrderSync_U, KioskCourse2_U, KioskCashReceipt_U,
     KioskPhoneKeyPad_U, KioskPhoneKeyPadBF_U, KioskPay_U, ToDaySaleQty_U;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';
procedure TOrder_F.FormCreate(Sender: TObject);
var vIndex,
    vWidth,
    vHeight,
    vTop,
    vLeft,
    vSize,
    vTempHeight,
    vGap,
    vStoreButtonTop,
    vTakeOutButtonTop,
    vStoreButtonLeft,
    vTakeOutButtonLeft,
    vFlag,
    vFlagLeft,
    vFlagTop,
    vCol,
    vRow :Integer;
    vDeviceEnumerator :IMMDeviceEnumerator;
    vDefaultDevice :IMMDevice;
    vImageFile :String;
begin
  isKitchenPrint                     := true;
  isPLUReFlash                       := false;
  Self.DoubleBuffered                := true;
  PLUClassPanel.DoubleBuffered       := true;
  PLUMenuPanel.DoubleBuffered        := true;
  FunctionButtonPanel.DoubleBuffered := true;
  AccountButtonPanel.DoubleBuffered  := true;
  KioskPanel.DoubleBuffered          := true;
  KioskWaitPanel.DoubleBuffered      := true;
  Main_sGrd.DoubleBuffered           := true;
  Present_sGrd.DoubleBuffered        := true;
  MemberInfoPanel.DoubleBuffered     := true;
  PresnetPanel.DoubleBuffered        := true;
  DeliveryPanel.DoubleBuffered       := true;
  GroupTable_sGrd.DoubleBuffered     := true;
  PrintOptionPanel.DoubleBuffered    := true;
  PrintOptionPanel.Visible           := false;
  wsReadyApply                       := true;
  LastFunctionTime                   := Now();
  Option60 := Common.Config.Options[60];
  UniQuery.Connection := DM.UniConnection;
  isCheckMobileNo := false;
  OnShow := FormShow;
  vTempHeight := 0;
  if (GetOption(414) = '0') and not Common.Config.IsKiosk then
  begin
    ReceiptPrintButton.Visible := true;
    BillPrintButton.Visible    := true;
    KitchenPrintButton.Visible := true;
    MenuPrintButton.Visible    := true;
    PrintOptionButton.Visible  := false;
  end
  else
  begin
    ReceiptPrintButton.Visible := false;
    BillPrintButton.Visible    := false;
    KitchenPrintButton.Visible := false;
    MenuPrintButton.Visible    := false;
    PrintOptionButton.Visible  := not Common.Config.IsKiosk;
  end;

  if not Common.Config.IsKiosk then
  begin
    ClientWidth   := Common.Config.PosWidth;
    ClientHeight  := Common.Config.PosHeight;
    Common.LogoCreate(Self,2);
    PluClassData := TList.Create;
    PluMenuData  := TList.Create;
    PluClassPage := 0;
    PluMenuPage  := 0;

    if Common.Config.Style = 'D' then
    begin
      Common.SetButtonColor(GridTitleShape);
      Common.SetButtonColor(GridPriorButton);
      Common.SetButtonColor(GridNextButton);
    end;

    for vIndex := 0 to ComponentCount-1 do
      if Components[vIndex] is TAdvGlassButton then
        Common.SetButtonColor((Components[vIndex] as TAdvGlassButton));


    PluClassPanel.Height := Common.Config.PluClassHeight;
    if Common.Config.PluClassX > 0 then
    begin
      //전체를 분류로 사용시
      if Common.Config.AllClassPLU then
      begin
        PluClassPanel.Height := Self.Height - PluClassPanel.Top - Common.Config.PanelHeight - 62;
        PluMenuPanel.Top     := PluClassPanel.Top;
        PluMenuPanel.Left    := PluClassPanel.Left;
        PluMenuPanel.Height  := PluClassPanel.Height;
        PluMenuPanel.Width   := PluClassPanel.Width;
        PluMenuPanel.Visible := false;
        BackButton.Visible   := false;
      end
      else
      begin
        PluMenuPanel.Top    := PluClassPanel.Top + Common.Config.PluClassHeight + 5;
        PluMenuPanel.Height := Self.Height - (PluClassPanel.Top + Common.Config.PluClassHeight) - Common.Config.PanelHeight - 62;
      end;
    end
    else
    begin
      PluMenuPanel.Top    := PluClassPanel.Top;
      PluMenuPanel.Height := Self.Height - PluClassPanel.Top - Common.Config.PanelHeight - 59;
    end;

    if Screen.PixelsPerInch = 96 then
      vSize := 12
    else if Screen.PixelsPerInch <= 120 then
      vSize := 11
    else if Screen.PixelsPerInch <= 150 then
      vSize := 9
    else if Screen.PixelsPerInch <= 180 then
      vSize := 8;
    Common.Config.TitleCaption := Format('<FONT color="#FFFFFF"  size="%d" face="맑은 고딕">%s</FONT>',[vSize,Common.Config.TitleCaption]);

    vWidth := 0;
    for vIndex := 1 to 4 do
      vWidth := vWidth + Common.Config.PanelWidth[vIndex];

    for vIndex := 1 to 4 do
    begin
      if Common.Config.PanelWidth[vIndex] = 0 then
        Common.Config.PanelWidth[vIndex] := Self.Width - vWidth - 18;
    end;

    vTop := Self.Height - Common.Config.PanelHeight - 55;
    vLeft := 8;
    PresnetPanel.Visible        := false;
    AccountButtonPanel.Visible  := false;
    FunctionButtonPanel.Visible := false;
    KeyPadPanel.Visible         := false;

    for vIndex := 1 to 4 do
      case StrToIntDef(Common.Config.PanelConfig[vIndex],0) of
        1 :
        begin
          PresnetPanel.Top    := vTop;
          PresnetPanel.Left   := vLeft;
          //주문포스일때 AccountButtonPanel.Visible (주문포스전용 디자인을 안했다는 가정)
          if (Common.PosType = ptOnlyOrder) and (StrToIntDef(Common.Config.PanelConfig[2],0) = 2) then
            PresnetPanel.Width  := Common.Config.PanelWidth[1] + Common.Config.PanelWidth[2] + 2
          else
            PresnetPanel.Width  := Common.Config.PanelWidth[1];
          PresnetPanel.Height := Common.Config.PanelHeight;
          vLeft := vLeft + PresnetPanel.Width + 1;

          if (Common.PosType = ptOnlyOrder) and (StrToIntDef(Common.Config.PanelConfig[2],0) = 2) then
          begin
            PresnetPanel.Height      := 100;
            PresnetPanel.Top         := vTop + Common.Config.PanelHeight - 100;
            vTempHeight              := Common.Config.PanelHeight - 100;;
            GetCaptionLabel.Visible  := false;
            GetAmtLabel.Visible      := false;
            TotalDcCaptionLabel.Visible      := false;
            Bevel1.Visible           := false;
            WGetCaptionLabel.Visible := false;
            WGetAmtLabel.Visible     := false;
            TotalDcAmtLabel.Visible      := false;

            TotalCaptionLabel.Width   := Common.Config.PanelWidth[1];
            TotalCaptionLabel.Height  := TotalCaptionLabel.Height + 10;
            TotalCaptionLabel.Caption   := '주문금액';
            TotalCaptionLabel.Style.Font.Size   := TotalCaptionLabel.Style.Font.Size + 15;
            TotalCaptionLabel.Top := 22;

            TotalAmtLabel.Left  := TotalCaptionLabel.Width +1;
            TotalAmtLabel.Width := PresnetPanel.Width - TotalCaptionLabel.Left - TotalCaptionLabel.Width-3;
            TotalAmtLabel.Height  := TotalAmtLabel.Height + 13;
            TotalAmtLabel.Style.Font.Size   := TotalAmtLabel.Style.Font.Size + 17;
            TotalAmtLabel.Top := 22;
          end
          else
          begin
            vSize := PresnetPanel.Width - 243;
            vSize := vSize div 30;
            TotalCaptionLabel.Style.Font.Size   := TotalCaptionLabel.Style.Font.Size   + vSize;
            TotalDcCaptionLabel.Style.Font.Size := TotalDcCaptionLabel.Style.Font.Size + vSize;
            GetCaptionLabel.Style.Font.Size     := GetCaptionLabel.Style.Font.Size     + vSize;
            WGetCaptionLabel.Style.Font.Size    := WGetCaptionLabel.Style.Font.Size    + vSize;

            TotalCaptionLabel.Width   := TotalCaptionLabel.Width   + vSize * 5;
            TotalDcCaptionLabel.Width := TotalDcCaptionLabel.Width + vSize * 5;
            GetCaptionLabel.Width     := GetCaptionLabel.Width     + vSize * 5;
            WGetCaptionLabel.Width    := WGetCaptionLabel.Width    + vSize * 5;

            TotalAmtLabel.Style.Font.Size   := TotalAmtLabel.Style.Font.Size   + vSize;
            TotalDcAmtLabel.Style.Font.Size := TotalDcAmtLabel.Style.Font.Size + vSize;
            GetAmtLabel.Style.Font.Size     := GetAmtLabel.Style.Font.Size     + vSize;
            WGetAmtLabel.Style.Font.Size    := WGetAmtLabel.Style.Font.Size    + vSize;
          end;
          WGetAmtLabel.Tag                := WGetAmtLabel.Style.Font.Size;
          PresnetPanel.Visible := true;
        end;
        2 :
        begin
          if Common.PosType <> ptOnlyOrder then
          begin
            AccountButtonPanel.Top    := vTop;
            if vIndex = 3 then
            begin
              AccountButtonPanel.Left   := vLeft + 5;
              AccountButtonPanel.Width  := Common.Config.PanelWidth[2]-3;
            end
            else
            begin
              AccountButtonPanel.Left   := vLeft;
              AccountButtonPanel.Width  := Common.Config.PanelWidth[2];
            end;
            AccountButtonPanel.Height := Common.Config.PanelHeight;
            vLeft := vLeft + Common.Config.PanelWidth[2] + 1;
            AccountButtonPanel.Visible := true;
          end;
        end;
        3 :
        begin
          FunctionButtonPanel.Top    := vTop;
          FunctionButtonPanel.Left   := vLeft;
          FunctionButtonPanel.Width  := Common.Config.PanelWidth[3];
          FunctionButtonPanel.Height := Common.Config.PanelHeight;
          vLeft := vLeft + Common.Config.PanelWidth[3] + 1;
          FunctionButtonPanel.Visible := true;
        end;
        4 :
        begin
          KeyPadPanel.Top    := vTop;
          KeyPadPanel.Left   := vLeft + 2 ;
          KeyPadPanel.Width  := Common.Config.PanelWidth[4]-2;
          KeyPadPanel.Height := Common.Config.PanelHeight;
          vLeft := vLeft + Common.Config.PanelWidth[4] + 1;
          KeyPadPanel.Visible := true;
          fmKeyPad.ParentBackground := true;
          vSize := PresnetPanel.Width - 171;
          vSize := vSize div 50;
          vWidth  := KeyPadPanel.Width  div 3 - 1;
          vHeight := KeyPadPanel.Height div 4 - 1;

          fmKeyPad.Num_BS.Width := vWidth;
          fmKeyPad.Num_Enter.Width := vWidth;
          fmKeyPad.Num_0.Width := vWidth;
          fmKeyPad.Num_1.Width := vWidth;
          fmKeyPad.Num_2.Width := vWidth;
          fmKeyPad.Num_3.Width := vWidth;
          fmKeyPad.Num_4.Width := vWidth;
          fmKeyPad.Num_5.Width := vWidth;
          fmKeyPad.Num_6.Width := vWidth;
          fmKeyPad.Num_7.Width := vWidth;
          fmKeyPad.Num_8.Width := vWidth;
          fmKeyPad.Num_9.Width := vWidth;

          fmKeyPad.Num_BS.Height := vHeight + 2;
          fmKeyPad.Num_Enter.Height := vHeight + 2;
          fmKeyPad.Num_0.Height := vHeight + 2;
          fmKeyPad.Num_1.Height := vHeight;
          fmKeyPad.Num_2.Height := vHeight;
          fmKeyPad.Num_3.Height := vHeight;
          fmKeyPad.Num_4.Height := vHeight;
          fmKeyPad.Num_5.Height := vHeight;
          fmKeyPad.Num_6.Height := vHeight;
          fmKeyPad.Num_7.Height := vHeight;
          fmKeyPad.Num_8.Height := vHeight;
          fmKeyPad.Num_9.Height := vHeight;

          fmKeyPad.Num_7.left := 0;
          fmKeyPad.Num_4.left := 0;
          fmKeyPad.Num_1.left := 0;
          fmKeyPad.Num_0.left := 0;

          fmKeyPad.Num_8.left  := vWidth + 1;
          fmKeyPad.Num_5.left  := vWidth + 1;
          fmKeyPad.Num_2.left  := vWidth + 1;
          fmKeyPad.Num_BS.left := vWidth + 1;

          fmKeyPad.Num_9.left  := vWidth*2 + 2;
          fmKeyPad.Num_6.left  := vWidth*2 + 2;
          fmKeyPad.Num_3.left  := vWidth*2 + 2;
          fmKeyPad.Num_Enter.left := vWidth*2 + 2;

          fmKeyPad.Num_7.Top := 0;
          fmKeyPad.Num_8.Top := 0;
          fmKeyPad.Num_9.Top := 0;

          fmKeyPad.Num_4.Top := vHeight + 1;
          fmKeyPad.Num_5.Top := vHeight + 1;
          fmKeyPad.Num_6.Top := vHeight + 1;

          fmKeyPad.Num_1.Top := vHeight*2 + 2;
          fmKeyPad.Num_2.Top := vHeight*2 + 2;
          fmKeyPad.Num_3.Top := vHeight*2 + 2;

          fmKeyPad.Num_0.Top := vHeight*3 + 3;
          fmKeyPad.Num_BS.Top := vHeight*3 + 3;
          fmKeyPad.Num_Enter.Top := vHeight*3 + 3;

          fmKeyPad.Num_0.Appearance.Font.Size :=  fmKeyPad.Num_0.Appearance.Font.Size + vSize;
          fmKeyPad.Num_1.Appearance.Font.Size :=  fmKeyPad.Num_1.Appearance.Font.Size + vSize;
          fmKeyPad.Num_2.Appearance.Font.Size :=  fmKeyPad.Num_2.Appearance.Font.Size + vSize;
          fmKeyPad.Num_3.Appearance.Font.Size :=  fmKeyPad.Num_3.Appearance.Font.Size + vSize;
          fmKeyPad.Num_4.Appearance.Font.Size :=  fmKeyPad.Num_4.Appearance.Font.Size + vSize;
          fmKeyPad.Num_5.Appearance.Font.Size :=  fmKeyPad.Num_5.Appearance.Font.Size + vSize;
          fmKeyPad.Num_6.Appearance.Font.Size :=  fmKeyPad.Num_6.Appearance.Font.Size + vSize;
          fmKeyPad.Num_7.Appearance.Font.Size :=  fmKeyPad.Num_7.Appearance.Font.Size + vSize;
          fmKeyPad.Num_8.Appearance.Font.Size :=  fmKeyPad.Num_8.Appearance.Font.Size + vSize;
          fmKeyPad.Num_9.Appearance.Font.Size :=  fmKeyPad.Num_9.Appearance.Font.Size + vSize;
          if Common.Config.Style = 'D' then
          begin
            Common.SetButtonColor(fmKeyPad.Num_0);
            Common.SetButtonColor(fmKeyPad.Num_1);
            Common.SetButtonColor(fmKeyPad.Num_2);
            Common.SetButtonColor(fmKeyPad.Num_3);
            Common.SetButtonColor(fmKeyPad.Num_4);
            Common.SetButtonColor(fmKeyPad.Num_5);
            Common.SetButtonColor(fmKeyPad.Num_6);
            Common.SetButtonColor(fmKeyPad.Num_7);
            Common.SetButtonColor(fmKeyPad.Num_8);
            Common.SetButtonColor(fmKeyPad.Num_9);
            Common.SetButtonColor(fmKeyPad.Num_BS);
            Common.SetButtonColor(fmKeyPad.Num_Enter);
          end;
        end;
      end;

    PluClassPanel.Left        := Self.Width - Common.Config.PluClassWidth - 10;
    PluMenuPanel.Left         := Self.Width - Common.Config.PluClassWidth - 10;
    PluClassPanel.Width       := Common.Config.PluClassWidth + 5;
    PluMenuPanel.Width        := Common.Config.PluClassWidth + 5;
    Main_sGrd.Width           := Self.Width - Main_sGrd.Left - GridNextButton.Width - Common.Config.PluClassWidth - 14;

    Main_sGrd.ColCount        := GDM_COLCOUNT;
    Main_sGrd.Height          := Self.Height - Main_sGrd.Top - Common.Config.PanelHeight - MemberInfoPanel.Height - 60 + vTempHeight;
    Main_sGrd.Tag             := Main_sGrd.Height;
    GridPriorButton.Left      := Main_sGrd.Left + Main_sGrd.Width + 3;
    GridNextButton.Left       := GridPriorButton.Left;
    GridTitleShape.Width      := Main_sGrd.Width + 2;
    GridTitleShape.ShapeWidth := Main_sGrd.Width + 2;

    GridPriorButton.Height    := (GridTitleShape.Height + Main_sGrd.Height) div 2 - 5;
    GridNextButton.Top        := GridPriorButton.Top + GridPriorButton.Height + 9;
    GridNextButton.Height     := GridPriorButton.Height;

    Cancel_sGrd.Top           := Main_sGrd.Top + Main_sGrd.Height - Cancel_sGrd.Height;
    Cancel_sGrd.Width         := Main_sGrd.Width;

    MemberInfoPanel.Top       := Main_sGrd.Top + Main_sGrd.Height + 2;
    Present_sGrd.Top          := MemberInfoPanel.Top;
    Present_sGrd.Width        := (Main_sGrd.Width + GridNextButton.Width + 8) div 2 - 51;
    MemberInfoPanel.Left      := Present_sGrd.Left + Present_sGrd.Width + 2;
    MemberInfoPanel.Width     := (Main_sGrd.Width + GridNextButton.Width + 8) div 2 + 11;
    OrderMenuLabel.Top        := Present_sGrd.Top;
    OrderMenuLabel.Left       := Main_sGrd.Left;
    OrderMenuLabel.Width      := Present_sGrd.Width + MemberInfoPanel.Width + 30;

    GroupTable_sGrd.Top             := Cancel_sGrd.Top;
    GroupTable_sGrd.Left            := Main_sGrd.Left;
    GroupTable_sGrd.Width           := Main_sGrd.Width;
    GroupTable_sGrd.Font.Size       := Common.Config.ListFontSize+2;

    OrderTableLabel.Font.Size := OrderTableLabel.Font.Size + (MemberInfoPanel.Width - 239) div 50;

    MessageImage.Top          := Self.Height - 41;
    OpenDateImage.Top         := Self.Height - 49;
    UserImage.Top             := Self.Height - 24;
    NoTransLabel.Top          := Self.Height - 24;
    NoTransImage.Top          := Self.Height - 24;

    WorkDateLabel.Top         := Self.Height - 46;
    PosNoLabel.Top            := Self.Height - 23;
    lbl_Damdang.Top           := Self.Height - 23;

    ClockButton.Left          := CloseButton.Left - 100;
    with TLabel.Create(Self) do
    begin
      Name        := 'MessageLabel';
      Parent      := Self;
      AutoSize    := false;
      Top         := Self.Height - 38;
      Left        := 66;
      Font.Name   := '맑은 고딕';
      Font.Color  := clWhite;
      Font.Size   := 14;
      Width       := 544;
      Height      := 28;
      Transparent := true;
    end;

    if PresnetPanel.Visible then
    begin
      with TAdvShape.Create(Self) do
      begin
        Name        := 'PresentShape';
        Parent      := Self;
        Top         := Present_sGrd.Top;
        Left        := 5;
        Height      := 129;
        Width       := 36;
        RotationAngle := 180;
        Rounding      := 1;
        Shape       := stRoundRect;
        ShapeHeight := 127;
        ShapeWidth  := 29;
        if Screen.PixelsPerInch = 96 then
           Text        := '<FONT color="#FFFFFF"  size="11" face="맑은 고딕">결<BR>제<BR>내<BR>역</FONT>'
        else if Screen.PixelsPerInch <= 120 then
          Text        := '<FONT color="#FFFFFF"  size="10" face="맑은 고딕">결<BR>제<BR>내<BR>역</FONT>'
        else if Screen.PixelsPerInch <= 150 then
          Text        := '<FONT color="#FFFFFF"  size="9" face="맑은 고딕">결<BR>제<BR>내<BR>역</FONT>'
        else if Screen.PixelsPerInch <= 180 then
          Text        := '<FONT color="#FFFFFF"  size="8" face="맑은 고딕">결<BR>제<BR>내<BR>역</FONT>';
        Scaled      := false;
        Appearance.Brush.Style := bsClear;
        Appearance.Direction := AdvShape.gdVertical;
        TextOffsetX  := 6;
        TextOffsetY  := 30;
        if Common.Config.Style = 'B' then
        begin
          Appearance.Color   := $00592D00;
          Appearance.ColorTo := $00AE5700;
        end
        else
        begin
          Appearance.Color   := $00121212;
          Appearance.ColorTo := $00121212;
        end;
        AutoSize    := false;
      end;
    end
    else
    begin
      Present_sGrd.Left := Main_sGrd.Left;
      Present_sGrd.Width   := 235;
    end;

    //결제버튼 생성
    try
      if AccountButtonPanel.Visible then
        AccountButtonCreate;
    except
      Common.ErrBox('AccountButtonCreate 생성오류'#13'포스 디자인을 확인하세요');
    end;
    //기능버튼 생성
    try
      FunctionButtonCreate;
    except
      Common.ErrBox('FunctionButtonCreate 생성오류'#13'포스 디자인을 확인하세요');
    end;
    //PLU분류버튼 생성
    try
      PluClassButtonCreate;
    except
      Common.ErrBox('PluClassButtonCreate 생성오류'#13'포스 디자인을 확인하세요');
    end;
    {PLU메뉴버튼 만들기}
    try
      PluMenuButtonCreate;
    except
      Common.ErrBox('PluMenuButtonCreate 생성오류'#13'포스 디자인을 확인하세요');
    end;
  end
  else
  begin
    ClockButton.Visible := false;
    Common.Device.OnDispenserReadData :=DispenserReadEvent;

    OpenQuery('select CD_CODE, '
             +'       NM_CODE1, '
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
             +'       NM_CODE15 '
             +'  from MS_CODE '
             +' where CD_STORE =:P0 '
             +'   and CD_KIND  =:P1 '
             +' order by CD_CODE ',
             [Common.Config.StoreCode,
              Common.Config.KioskType]);
    while not Common.Query.Eof do
    begin
      vIndex := StoI(Common.Query.Fields[0].AsString);
      case vIndex of
        1 :
        begin
          ClientWidth              := StoI(Common.Query.Fields[1].AsString);
          ClientHeight             := StoI(Common.Query.Fields[2].AsString);
          Width                    := StoI(Common.Query.Fields[1].AsString);
          Height                   := StoI(Common.Query.Fields[2].AsString);
          KioskPanel.Width         := StoI(Common.Query.Fields[1].AsString);
          KioskPanel.Height        := StoI(Common.Query.Fields[2].AsString);

          Common.KioskConfig[2]    := StrToIntDef(Common.Query.Fields[3].AsString,3);     //분류PLU 갯수
          Common.KioskConfig[3]    := StrToIntDef(Common.Query.Fields[4].AsString,4);     //메뉴PLU X
          Common.KioskConfig[4]    := StrToIntDef(Common.Query.Fields[5].AsString,5);     //메뉴PLU Y
          Common.KioskConfig[5]    := StrToIntDef(Common.Query.Fields[6].AsString,10);    //주문메뉴 표시갯수
          Common.KioskConfig[6]    := StrToIntDef(Common.Query.Fields[7].AsString,0);     //메뉴이미지 테두리 사용
          Common.KioskConfig[7]    := StrToIntDef(Common.Query.Fields[8].AsString,0);     //메뉴 테두리
          Common.KioskConfig[8]    := StrToIntDef(Common.Query.Fields[9].AsString,0);     //PLU 단가표시    무조건표시
          Common.KioskConfig[9]    := StrToIntDef(Common.Query.Fields[10].AsString,0);    //PLU 메뉴명표시  (사용안함)
          Common.KioskConfig[10]   := StrToIntDef(Common.Query.Fields[11].AsString,10);   //PLU 간격
          Common.KioskConfig[11]   := StrToIntDef(Common.Query.Fields[12].AsString,0);    //메뉴명 정렬(0:L, 1:C, 2:R)
          Common.KioskConfig[12]   := StrToIntDef(Common.Query.Fields[13].AsString,0);    //단가 정렬(0:L, 1:C, 2:R)
          Common.KioskConfig[13]   := StrToIntDef(Common.Query.Fields[14].AsString,0);    //기능버튼 아이콘 정렬(0:L, 1:C, 2:R)
          Common.KioskConfig[14]   := StrToIntDef(Common.Query.Fields[15].AsString,0);    //메뉴명 한줄띄우기

           //전체를 그룹메뉴로 사용할때
          if GetOption(428)='1' then
          begin
                                     //그룹표시 X(429) * Y(430)
            Common.KioskConfig[3]  := StrToIntDef(GetOption(429),Common.KioskConfig[3]);
            Common.KioskConfig[4]  := StrToIntDef(GetOption(430),Common.KioskConfig[4]);
            Common.KioskConfig[14] := Common.KioskConfig[3];
            Common.KioskConfig[15] := Common.KioskConfig[4];
          end;
          
          KioskClassCount := Ifthen(Common.KioskConfig[2]=0,1,Common.KioskConfig[2]);
          KioskMenuCount  := Common.KioskConfig[3] * Common.KioskConfig[4];
          if KioskMenuCount = 0 then
            KioskMenuCount := 1;
          SetLength(KioskOrderMenu,    Common.KioskConfig[5]);
          SetLength(tmpKioskOrderMenu, Common.KioskConfig[5]);
        end;
        2 :
        begin
          KioskPLUClassPanel.Left                      := StoI(Common.Query.Fields[1].AsString);
          KioskPLUClassPanel.Top                       := StoI(Common.Query.Fields[2].AsString);
          Common.Config.BarrierTop                     := KioskPLUClassPanel.Top;
          KioskPLUClassPanel.Width                     := StoI(Common.Query.Fields[3].AsString);
          KioskPLUClassPanel.Height                    := StoI(Common.Query.Fields[4].AsString);
          KioskPLUClassPanel.Visible                   := Common.Query.Fields[5].AsString = '0';
          KioskPLUClassPanel.Font.Name                 := Common.Query.Fields[6].AsString;
          KioskPLUClassPanel.Font.Size                 := StoI(Common.Query.Fields[8].AsString);
          if GetOption(458) = '0' then  //blue
          begin
            KioskPLUClassPanel.StatusBar.Color         := StringToColorDef(Common.Query.Fields[10].AsString,  $00D26900);
            KioskPLUClassPanel.StatusBar.ColorTo       := StringToColorDef(Common.Query.Fields[11].AsString,  $00D26900);
            KioskPLUClassPanel.Font.Color              := StringToColorDef(Common.Query.Fields[7].AsString, $004D9900);;
            KioskPLUClassPanel.CollapsColor            := StringToColorDef(Common.Query.Fields[9].AsString,   $004D9900);;
          end
          else if GetOption(458) = '1' then  //blue
          begin
            KioskPLUClassPanel.StatusBar.ColorTo       := $00D26900;
            KioskPLUClassPanel.StatusBar.Color         := clWhite;
            KioskPLUClassPanel.Font.Color              := clBlack;
            KioskPLUClassPanel.CollapsColor            := clWhite;
          end
          else if GetOption(458) = '2' then  //Black
          begin
            KioskPLUClassPanel.StatusBar.ColorTo       := clBlack;
            KioskPLUClassPanel.StatusBar.Color         := clWhite;
            KioskPLUClassPanel.Font.Color              := clBlack;
            KioskPLUClassPanel.CollapsColor            := clWhite;
          end
          else if GetOption(458) = '3' then  //Red
          begin
            KioskPLUClassPanel.StatusBar.ColorTo       := $000000CC;
            KioskPLUClassPanel.StatusBar.Color         := clWhite;
            KioskPLUClassPanel.Font.Color              := clBlack;
            KioskPLUClassPanel.CollapsColor            := clWhite;
          end
          else if GetOption(458) = '4' then  //Green
          begin
            KioskPLUClassPanel.StatusBar.ColorTo       := $00009900;
            KioskPLUClassPanel.StatusBar.Color         := clWhite;
            KioskPLUClassPanel.Font.Color              := clBlack;
            KioskPLUClassPanel.CollapsColor            := clWhite;
          end;
        end;
        3 :
        begin
          KioskPLUMenuPanel.Left                       := StoI(Common.Query.Fields[1].AsString);
          KioskPLUMenuPanel.Top                        := StoI(Common.Query.Fields[2].AsString);
          KioskPLUMenuPanel.Width                      := StoI(Common.Query.Fields[3].AsString);
          KioskPLUMenuPanel.Height                     := StoI(Common.Query.Fields[4].AsString);
          KioskPLUMenuPanel.Visible                    := Common.Query.Fields[5].AsString = '0';
          Common.KioskConfig[16]                       := KioskPLUMenuPanel.Width;
          Common.KioskConfig[17]                       := KioskPLUMenuPanel.Height;
          KioskPLUMenuPanel.Font.Name                  := Common.Query.Fields[6].AsString;
          KioskPLUMenuPanel.Font.Color                 := StringToColorDef(Common.Query.Fields[7].AsString, $004D9900);
          KioskPLUMenuPanel.Font.Size                  := StoI(Common.Query.Fields[8].AsString);
          if Common.Query.Fields[12].AsString = '1' then
            KioskPLUMenuPanel.Font.Style                 := [fsBold]
          else
            KioskPLUMenuPanel.Font.Style                 := [];
        end;
        4 : //영업일자
        begin
          KioskWorkDateLabel.Left                      := StoI(Common.Query.Fields[1].AsString);
          KioskWorkDateLabel.Top                       := StoI(Common.Query.Fields[2].AsString);
          KioskWorkDateLabel.Width                     := StoI(Common.Query.Fields[3].AsString);
          KioskWorkDateLabel.Height := Trunc(StoI(Common.Query.Fields[4].AsString) * 0.6);
          KioskWorkDateLabel.Font.Name      := Common.Query.Fields[6].AsString;
          KioskWorkDateLabel.Font.Color     := StringToColorDef(Common.Query.Fields[7].AsString, clBlack);
          KioskWorkDateLabel.Font.Size      := StoI(Common.Query.Fields[8].AsString);
          if Common.Query.Fields[12].AsString = '1' then
            KioskWorkDateLabel.Font.Style       := [fsBold];
        end;
        5 :  //전체취소
        begin
          KioskInitButton.Left                         := StoI(Common.Query.Fields[1].AsString);
          KioskInitButton.Top                          := StoI(Common.Query.Fields[2].AsString);
          KioskInitButton.Width                        := StoI(Common.Query.Fields[3].AsString);
          KioskInitButton.Height                       := StoI(Common.Query.Fields[4].AsString);
          KioskInitButton.Appearance.Font.Name         := Common.Query.Fields[6].AsString;
          KioskInitButton.Appearance.Font.Color        := StringToColorDef(Common.Query.Fields[7].AsString, clWhite);
          KioskInitButton.Appearance.Font.Size         := StoI(Common.Query.Fields[8].AsString);
          KioskInitButton.Color                        := StringToColorDef(Common.Query.Fields[9].AsString, clBlue);
          if Common.Query.Fields[15].AsString <> '' then
            KioskInitButton.Hint := Common.Query.Fields[15].AsString
          else
            KioskInitButton.Hint := '전체취소';

          if KioskInitButton.Color = clWhite then
            Common.SetButtonColor(KioskInitButton, true);
          if Common.Query.Fields[12].AsString = '1' then
            KioskInitButton.Appearance.Font.Style         := [fsBold]
          else
            KioskInitButton.Appearance.Font.Style         := [];

          case Common.KioskConfig[13] of
            0 : KioskInitButton.Picture := nil;
            1 : KioskInitButton.Appearance.Layout := blPictureTop;
            2 : KioskInitButton.Appearance.Layout := blPictureBottom;
            3 : KioskInitButton.Appearance.Layout := blPictureLeft;
            4 : KioskInitButton.Appearance.Layout := blPictureRight;
          end;
        end;
        6 :  //주문총수량
        begin
          lbl_KioskOrderCount.Left               := StoI(Common.Query.Fields[1].AsString);
          lbl_KioskOrderCount.Top                := StoI(Common.Query.Fields[2].AsString);
          lbl_KioskOrderCount.Width              := StoI(Common.Query.Fields[3].AsString);
          lbl_KioskOrderCount.Height             := StoI(Common.Query.Fields[4].AsString);
          lbl_KioskOrderCount.Visible            := Common.Query.Fields[5].AsString = '0';
          lbl_KioskOrderCount.Style.Font.Name    := Common.Query.Fields[6].AsString;
          lbl_KioskOrderCount.Style.Font.Color   := StringToColorDef(Common.Query.Fields[7].AsString, clWhite);
          lbl_KioskOrderCount.Style.Font.Size    := StoI(Common.Query.Fields[8].AsString);
          if Common.Query.Fields[12].AsString = '1' then
            lbl_KioskOrderCount.Style.Font.Style         := [fsBold]
          else
            lbl_KioskOrderCount.Style.Font.Style         := [];
        end;
        7 :  //주문메뉴
        begin
          KioskOrderMenuPanel.Left              := StoI(Common.Query.Fields[1].AsString);
          KioskOrderMenuPanel.Top               := StoI(Common.Query.Fields[2].AsString);
          KioskOrderMenuPanel.Width             := StoI(Common.Query.Fields[3].AsString);
          KioskOrderMenuPanel.Height            := StoI(Common.Query.Fields[4].AsString);
          KioskOrderMenuPanel.Font.Name         := Common.Query.Fields[6].AsString;
          KioskOrderMenuPanel.Font.Color        := StringToColorDef(Common.Query.Fields[7].AsString, clWhite);
          KioskOrderMenuPanel.Font.Size         := StoI(Common.Query.Fields[8].AsString);
          KioskOrderMenuPanel.Color             := clWhite;
          KioskOrderMenuPanel.Hint              := Common.Query.Fields[10].AsString;
          if Common.Query.Fields[12].AsString = '1' then
            KioskOrderMenuPanel.Font.Style         := [fsBold]
          else
            KioskOrderMenuPanel.Font.Style         := [];
        end;
        8 : //주문금액
        begin
          KioskWrcvAmtLabel.Left                 := StoI(Common.Query.Fields[1].AsString);
          KioskWrcvAmtLabel.Top                  := StoI(Common.Query.Fields[2].AsString);
          KioskWrcvAmtLabel.Width                := StoI(Common.Query.Fields[3].AsString);
          KioskWrcvAmtLabel.Height               := StoI(Common.Query.Fields[4].AsString);
          KioskWrcvAmtLabel.Style.Font.Name      := Common.Query.Fields[6].AsString;
          KioskWrcvAmtLabel.Style.Font.Color     := StringToColorDef(Common.Query.Fields[7].AsString, clWhite);
          KioskWrcvAmtLabel.Style.Font.Size      := StoI(Common.Query.Fields[8].AsString);
          if Common.Query.Fields[12].AsString = '1' then
            KioskWrcvAmtLabel.Style.Font.Style         := [fsBold]
          else
            KioskWrcvAmtLabel.Style.Font.Style         := [];
        end;
        9 :  //현금
        begin
          KioskCashButton.Left                    := StoI(Common.Query.Fields[1].AsString);
          KioskCashButton.Top                     := StoI(Common.Query.Fields[2].AsString);
          KioskCashButton.Width                   := StoI(Common.Query.Fields[3].AsString);
          KioskCashButton.Height                  := StoI(Common.Query.Fields[4].AsString);
          KioskCashButton.Visible                 := Common.Query.Fields[5].AsString = '0';
          KioskCashButton.Appearance.Font.Name               := Common.Query.Fields[6].AsString;
          KioskCashButton.Appearance.Font.Color              := StringToColorDef(Common.Query.Fields[7].AsString, clWhite);
          KioskCashButton.Appearance.Font.Size               := StoI(Common.Query.Fields[8].AsString);
          KioskCashButton.Color           := StringToColorDef(Common.Query.Fields[9].AsString, clBlue);
          if Common.Query.Fields[15].AsString <> '' then
            KioskCashButton.Hint := Common.Query.Fields[15].AsString
          else
            KioskCashButton.Hint := '현금결제';
          if KioskCashButton.Color = clWhite then
            Common.SetButtonColor(KioskCashButton, true);
          if Common.Query.Fields[12].AsString = '1' then
            KioskCashButton.Appearance.Font.Style         := [fsBold]
          else
            KioskCashButton.Appearance.Font.Style         := [];

          case Common.KioskConfig[13] of
            0 : KioskCashButton.Picture := nil;
            1 : KioskCashButton.Appearance.Layout := blPictureTop;
            2 : KioskCashButton.Appearance.Layout := blPictureBottom;
            3 : KioskCashButton.Appearance.Layout := blPictureLeft;
            4 : KioskCashButton.Appearance.Layout := blPictureRight;
          end;

        end;
        10 :  //신용카드
        begin
          KioskCardButton.Left                    := StoI(Common.Query.Fields[1].AsString);
          KioskCardButton.Top                     := StoI(Common.Query.Fields[2].AsString);
          KioskCardButton.Width                   := StoI(Common.Query.Fields[3].AsString);
          KioskCardButton.Height                  := StoI(Common.Query.Fields[4].AsString);
          KioskCardButton.Visible                 := Common.Query.Fields[5].AsString = '0';
          KioskCardButton.Appearance.Font.Name               := Common.Query.Fields[6].AsString;
          KioskCardButton.Appearance.Font.Color              := StringToColorDef(Common.Query.Fields[7].AsString, clWhite);
          KioskCardButton.Appearance.Font.Size               := StoI(Common.Query.Fields[8].AsString);
          KioskCardButton.Color           := StringToColorDef(Common.Query.Fields[9].AsString, clBlue);
          if Common.Query.Fields[15].AsString <> '' then
            KioskCardButton.Hint := Common.Query.Fields[15].AsString
          else
            KioskCardButton.Hint := '카드결제';

          if KioskCardButton.Color = clWhite then
            Common.SetButtonColor(KioskCardButton, true);
          if Common.Query.Fields[12].AsString = '1' then
            KioskCardButton.Appearance.Font.Style         := [fsBold]
          else
            KioskCardButton.Appearance.Font.Style         := [];

          case Common.KioskConfig[13] of
            0 : KioskCardButton.Picture := nil;
            1 : KioskCardButton.Appearance.Layout := blPictureTop;
            2 : KioskCardButton.Appearance.Layout := blPictureBottom;
            3 : KioskCardButton.Appearance.Layout := blPictureLeft;
            4 : KioskCardButton.Appearance.Layout := blPictureRight;
          end;
        end;
        11:  //직원호출
        begin
          KioskCallButton.Left                    := StoI(Common.Query.Fields[1].AsString);
          KioskCallButton.Top                     := StoI(Common.Query.Fields[2].AsString);
          KioskCallButton.Width                   := StoI(Common.Query.Fields[3].AsString);
          KioskCallButton.Height                  := StoI(Common.Query.Fields[4].AsString);
          KioskCallButton.Appearance.Font.Name    := Common.Query.Fields[6].AsString;
          KioskCallButton.Appearance.Font.Color   := StringToColorDef(Common.Query.Fields[7].AsString, clWhite);
          KioskCallButton.Appearance.Font.Size    := StoI(Common.Query.Fields[8].AsString);
          KioskCallButton.Visible                 := Common.Query.Fields[5].AsString = '0';
          KioskCallButton.Color           := StringToColorDef(Common.Query.Fields[9].AsString, clBlue);
          if Common.Query.Fields[15].AsString <> '' then
            KioskCallButton.Hint := Common.Query.Fields[15].AsString
          else
            KioskCallButton.Hint := '직원호출';

          if KioskCallButton.Color = clWhite then
            Common.SetButtonColor(KioskCallButton, true);
          if Common.Query.Fields[12].AsString = '1' then
            KioskCallButton.Appearance.Font.Style         := [fsBold]
          else
            KioskCallButton.Appearance.Font.Style         := [];

          case Common.KioskConfig[13] of
            0 : KioskCallButton.Picture := nil;
            1 : KioskCallButton.Appearance.Layout := blPictureTop;
            2 : KioskCallButton.Appearance.Layout := blPictureBottom;
            3 : KioskCallButton.Appearance.Layout := blPictureLeft;
            4 : KioskCallButton.Appearance.Layout := blPictureRight;
          end;
        end;
        12:  //회원가입
        begin
          KioskMemberJoinButton.Left              := StoI(Common.Query.Fields[1].AsString);
          KioskMemberJoinButton.Top               := StoI(Common.Query.Fields[2].AsString);
          KioskMemberJoinButton.Width             := StoI(Common.Query.Fields[3].AsString);
          KioskMemberJoinButton.Height            := StoI(Common.Query.Fields[4].AsString);
          KioskMemberJoinButton.Appearance.Font.Name         := Common.Query.Fields[6].AsString;
          KioskMemberJoinButton.Appearance.Font.Color        := StringToColorDef(Common.Query.Fields[7].AsString, clWhite);
          KioskMemberJoinButton.Appearance.Font.Size         := StoI(Common.Query.Fields[8].AsString);
          KioskMemberJoinButton.Visible           := Common.Query.Fields[5].AsString = '0';
          KioskMemberJoinButton.Color     := StringToColorDef(Common.Query.Fields[9].AsString, clBlue);
          if Common.Query.Fields[15].AsString <> '' then
            KioskMemberJoinButton.Hint := Common.Query.Fields[15].AsString
          else
            KioskMemberJoinButton.Hint := '회원가입';
          if KioskMemberJoinButton.Color = clWhite then
            Common.SetButtonColor(KioskMemberJoinButton, true);
          if Common.Query.Fields[12].AsString = '1' then
            KioskMemberJoinButton.Appearance.Font.Style         := [fsBold]
          else
            KioskMemberJoinButton.Appearance.Font.Style         := [];

          case Common.KioskConfig[13] of
            0 : KioskMemberJoinButton.Picture := nil;
            1 : KioskMemberJoinButton.Appearance.Layout := blPictureTop;
            2 : KioskMemberJoinButton.Appearance.Layout := blPictureBottom;
            3 : KioskMemberJoinButton.Appearance.Layout := blPictureLeft;
            4 : KioskMemberJoinButton.Appearance.Layout := blPictureRight;
          end;

        end;
        13 : //외상
        begin
          KioskTrustButton.Left                   := StoI(Common.Query.Fields[1].AsString);
          KioskTrustButton.Top                    := StoI(Common.Query.Fields[2].AsString);
          KioskTrustButton.Width                  := StoI(Common.Query.Fields[3].AsString);
          KioskTrustButton.Height                 := StoI(Common.Query.Fields[4].AsString);
          KioskTrustButton.Visible                := Common.Query.Fields[5].AsString = '0';
          KioskTrustButton.Appearance.Font.Name              := Common.Query.Fields[6].AsString;
          KioskTrustButton.Appearance.Font.Color             := StringToColorDef(Common.Query.Fields[7].AsString, clWhite);
          KioskTrustButton.Appearance.Font.Size              := StoI(Common.Query.Fields[8].AsString);
          KioskTrustButton.Color          := StringToColorDef(Common.Query.Fields[9].AsString, clBlue);
          if Common.Query.Fields[15].AsString <> '' then
            KioskTrustButton.Hint := Common.Query.Fields[15].AsString
          else
            KioskTrustButton.Hint := '외상결제';

          if KioskTrustButton.Color = clWhite then
            Common.SetButtonColor(KioskTrustButton, true);
          if Common.Query.Fields[12].AsString = '1' then
            KioskTrustButton.Appearance.Font.Style         := [fsBold]
          else
            KioskTrustButton.Appearance.Font.Style         := [];

          case Common.KioskConfig[13] of
            0 : KioskTrustButton.Picture := nil;
            1 : KioskTrustButton.Appearance.Layout := blPictureTop;
            2 : KioskTrustButton.Appearance.Layout := blPictureBottom;
            3 : KioskTrustButton.Appearance.Layout := blPictureLeft;
            4 : KioskTrustButton.Appearance.Layout := blPictureRight;
          end;

        end;
        14 : //메뉴 《
        begin
          KioskMenuPriorButton.Left                  := StoI(Common.Query.Fields[1].AsString);
          KioskMenuPriorButton.Top                   := StoI(Common.Query.Fields[2].AsString);
          KioskMenuPriorButton.Width                 := StoI(Common.Query.Fields[3].AsString);
          KioskMenuPriorButton.Height                := StoI(Common.Query.Fields[4].AsString);
          KioskMenuPriorButton.Visible               := Common.Query.Fields[5].AsString = '0';
          KioskMenuPriorButton.Appearance.Font.Name  := Common.Query.Fields[6].AsString;
          KioskMenuPriorButton.Appearance.Font.Color := StringToColorDef(Common.Query.Fields[7].AsString, clWhite);
          KioskMenuPriorButton.Appearance.Font.Size  := StoI(Common.Query.Fields[8].AsString);
//          KioskMenuPriorButton.BevelColor            := StringToColorDef(Common.Query.Fields[9].AsString, clWhite);
//          KioskMenuPriorButton.Color                 := StringToColorDef(Common.Query.Fields[9].AsString, clWhite);
          KioskMenuPriorButton.Appearance.SimpleLayout   := true;
          if Common.Query.Fields[12].AsString = '1' then
            KioskMenuPriorButton.Appearance.Font.Style         := [fsBold]
          else
            KioskMenuPriorButton.Appearance.Font.Style         := [fsBold];

          if GetOption(458) = '0' then
          begin
            KioskMenuPriorButton.BorderColor               := KioskMenuPriorButton.Color;
            KioskMenuPriorButton.BorderInnerColor          := KioskMenuPriorButton.Color;
            KioskMenuPriorButton.Appearance.Font.Color     := StringToColorDef(Common.Query.Fields[7].AsString, $004D9900);
          end
          else if GetOption(458) = '1' then  //blue
          begin
            KioskMenuPriorButton.BevelColor                := $00D26900;
            KioskMenuPriorButton.BorderColor               := $00D26900;
            KioskMenuPriorButton.BorderInnerColor          := clWhite;
            KioskMenuPriorButton.ColorDisabled             := clWhite;
            KioskMenuPriorButton.Appearance.Font.Color     := $00D26900;
          end
          else if GetOption(458) = '2' then  //Black
          begin
            KioskMenuPriorButton.BevelColor                := clBlack;
            KioskMenuPriorButton.BorderColor               := clBlack;
            KioskMenuPriorButton.BorderInnerColor          := clWhite;
            KioskMenuPriorButton.ColorDisabled             := clWhite;
            KioskMenuPriorButton.Appearance.Font.Color     := clBlack;
          end
          else if GetOption(458) = '3' then  //Red
          begin
            KioskMenuPriorButton.BevelColor                := $000000CC;
            KioskMenuPriorButton.BorderColor               := $000000CC;
            KioskMenuPriorButton.BorderInnerColor          := clWhite;
            KioskMenuPriorButton.Appearance.Font.Color     := $000000CC;
            KioskMenuPriorButton.ColorDisabled             := clWhite;
          end
          else if GetOption(458) = '4' then  //Red
          begin
            KioskMenuPriorButton.BevelColor                := $00009900;
            KioskMenuPriorButton.BorderColor               := $00009900;
            KioskMenuPriorButton.BorderInnerColor          := clWhite;
            KioskMenuPriorButton.ColorDisabled             := clWhite;
            KioskMenuPriorButton.Appearance.Font.Color     := $00009900;
          end;
        end;
        15 : //메뉴 《
        begin
          KioskMenuNextButton.Left                := StoI(Common.Query.Fields[1].AsString);
          KioskMenuNextButton.Top                 := StoI(Common.Query.Fields[2].AsString);
          KioskMenuNextButton.Width               := StoI(Common.Query.Fields[3].AsString);
          KioskMenuNextButton.Height              := StoI(Common.Query.Fields[4].AsString);
          KioskMenuNextButton.Visible             := Common.Query.Fields[5].AsString = '0';
          KioskMenuNextButton.Appearance.Font.Name  := Common.Query.Fields[6].AsString;
          KioskMenuNextButton.Appearance.Font.Size  := StoI(Common.Query.Fields[8].AsString);

          KioskMenuNextButton.Appearance.SimpleLayout   := true;
          if Common.Query.Fields[12].AsString = '1' then
            KioskMenuNextButton.Appearance.Font.Style         := [fsBold]
          else
            KioskMenuNextButton.Appearance.Font.Style         := [fsBold];

          if GetOption(458) = '0' then
          begin
            KioskMenuNextButton.BorderColor               := KioskMenuNextButton.Color;
            KioskMenuNextButton.BorderInnerColor          := KioskMenuNextButton.Color;
            KioskMenuNextButton.Appearance.Font.Color     := StringToColorDef(Common.Query.Fields[7].AsString, $004D9900);
            KioskMenuNextButton.ColorDisabled             := clWhite;
          end
          else if GetOption(458) = '1' then  //blue
          begin
            KioskMenuNextButton.BevelColor                := $00D26900;
            KioskMenuNextButton.BorderColor               := $00D26900;
            KioskMenuNextButton.BorderInnerColor          := clWhite;
            KioskMenuNextButton.ColorDisabled             := clWhite;
            KioskMenuNextButton.Appearance.Font.Color     := $00D26900;
          end
          else if GetOption(458) = '2' then  //Black
          begin
            KioskMenuNextButton.BevelColor                := clBlack;
            KioskMenuNextButton.BorderColor               := clBlack;
            KioskMenuNextButton.BorderInnerColor          := clWhite;
            KioskMenuNextButton.ColorDisabled             := clWhite;
            KioskMenuNextButton.Appearance.Font.Color     := clBlack;
          end
          else if GetOption(458) = '3' then  //Red
          begin
            KioskMenuNextButton.BevelColor                := $000000CC;
            KioskMenuNextButton.BorderColor               := $000000CC;
            KioskMenuNextButton.BorderInnerColor          := clWhite;
            KioskMenuNextButton.ColorDisabled             := clWhite;
            KioskMenuNextButton.Appearance.Font.Color     := $000000CC;
          end
          else if GetOption(458) = '4' then  //Red
          begin
            KioskMenuNextButton.BevelColor                := $00009900;
            KioskMenuNextButton.BorderColor               := $00009900;
            KioskMenuNextButton.BorderInnerColor          := clWhite;
            KioskMenuNextButton.Appearance.Font.Color     := $00009900;
            KioskMenuNextButton.ColorDisabled             := clWhite;
          end;
        end;
        16 : //메뉴 Page
        begin
          KioskMenuPageLabel.Left             := StoI(Common.Query.Fields[1].AsString);
          KioskMenuPageLabel.Top              := StoI(Common.Query.Fields[2].AsString);
          KioskMenuPageLabel.Width            := StoI(Common.Query.Fields[3].AsString);
          KioskMenuPageLabel.Height           := StoI(Common.Query.Fields[4].AsString);
          KioskMenuPageLabel.Visible          := Common.Query.Fields[5].AsString = '0';
          KioskMenuPageLabel.Style.Font.Name           := Common.Query.Fields[6].AsString;
          KioskMenuPageLabel.Style.Font.Color          := clBlack;
          KioskMenuPageLabel.Style.Font.Size           := StoI(Common.Query.Fields[8].AsString);
          if Common.Query.Fields[12].AsString = '1' then
            KioskMenuPageLabel.Style.Font.Style         := [fsBold]
          else
            KioskMenuPageLabel.Style.Font.Style         := [];
        end;
         17 : //분류 《
        begin
          KioskClassPriorButton.Left                      := StoI(Common.Query.Fields[1].AsString);
          KioskClassPriorButton.Top                       := KioskPLUClassPanel.Top;
          KioskClassPriorButton.Width                     := StoI(Common.Query.Fields[3].AsString);
          KioskClassPriorButton.Height                    := KioskPLUClassPanel.Height;
          KioskClassPriorButton.Visible                   := Common.Query.Fields[5].AsString = '0';
          KioskClassPriorButton.Appearance.Font.Name      := Common.Query.Fields[6].AsString;
          KioskClassPriorButton.Appearance.Font.Color     := StringToColorDef(Common.Query.Fields[7].AsString, $004D9900);
          KioskClassPriorButton.Appearance.Font.Size      := StoI(Common.Query.Fields[8].AsString);
          KioskClassPriorButton.Color                     := KioskPLUClassPanel.StatusBar.Color;
          KioskClassPriorButton.ColorDown                 := KioskPLUClassPanel.StatusBar.ColorTo;
          KioskClassPriorButton.ColorDisabled             := KioskPLUClassPanel.StatusBar.Color;
          KioskClassPriorButton.Appearance.SimpleLayout   := true;
          KioskClassPriorButton.Appearance.Spacing        := 1;
          KioskClassPriorButton.BevelWidth                := 0;
          if Common.Query.Fields[12].AsString = '1' then
            KioskClassPriorButton.Appearance.Font.Style         := [fsBold]
          else
            KioskClassPriorButton.Appearance.Font.Style         := [];

          if GetOption(458) = '0' then
          begin
            KioskClassPriorButton.BorderColor               := KioskClassPriorButton.Color;
            KioskClassPriorButton.BorderInnerColor          := KioskClassPriorButton.Color;
            KioskClassPriorButton.Appearance.Font.Color     := StringToColorDef(Common.Query.Fields[7].AsString, $004D9900);
          end
          else if GetOption(458) = '1' then  //blue
          begin
            KioskClassPriorButton.BorderColor               := $00D26900;
            KioskClassPriorButton.BorderInnerColor          := clWhite;
            KioskClassPriorButton.Appearance.Font.Color     := $00D26900;
            KioskClassPriorButton.ColorDisabled             := clWhite;
          end
          else if GetOption(458) = '2' then  //Black
          begin
            KioskClassPriorButton.BorderColor               := clBlack;
            KioskClassPriorButton.BorderInnerColor          := clWhite;
            KioskClassPriorButton.Appearance.Font.Color     := clBlack;
            KioskClassPriorButton.ColorDisabled             := clWhite;
          end
          else if GetOption(458) = '3' then  //Red
          begin
            KioskClassPriorButton.BorderColor               := $000000CC;
            KioskClassPriorButton.BorderInnerColor          := clWhite;
            KioskClassPriorButton.Appearance.Font.Color     := $000000CC;
            KioskClassPriorButton.ColorDisabled             := clWhite;
          end
          else if GetOption(458) = '4' then  //Red
          begin
            KioskClassPriorButton.BorderColor               := $00009900;
            KioskClassPriorButton.BorderInnerColor          := clWhite;
            KioskClassPriorButton.Appearance.Font.Color     := $00009900;
            KioskClassPriorButton.ColorDisabled             := clWhite;
          end;
        end;
        18 : //분류 《
        begin
          KioskClassNextButton.Left                      := StoI(Common.Query.Fields[1].AsString);
          KioskClassNextButton.Top                       := KioskPLUClassPanel.Top;
          KioskClassNextButton.Width                     := StoI(Common.Query.Fields[3].AsString);
          KioskClassNextButton.Height                    := KioskPLUClassPanel.Height;
          KioskClassNextButton.Visible                   := Common.Query.Fields[5].AsString = '0';
          KioskClassNextButton.Appearance.Font.Name      := Common.Query.Fields[6].AsString;
          KioskClassNextButton.Appearance.Font.Color     := StringToColorDef(Common.Query.Fields[7].AsString, $004D9900);
          KioskClassNextButton.Appearance.Font.Size      := StoI(Common.Query.Fields[8].AsString);
          KioskClassNextButton.Color                     := KioskPLUClassPanel.StatusBar.Color;
          KioskClassNextButton.ColorDown                := KioskPLUClassPanel.StatusBar.ColorTo;
          KioskClassNextButton.ColorDisabled             := KioskPLUClassPanel.StatusBar.Color;
          KioskClassNextButton.Appearance.SimpleLayout   := true;
          KioskClassNextButton.Appearance.Spacing        := 1;
          KioskClassNextButton.BevelWidth                := 0;
          if Common.Query.Fields[12].AsString = '1' then
            KioskClassNextButton.Appearance.Font.Style         := [fsBold]
          else
            KioskClassNextButton.Appearance.Font.Style         := [];

          if GetOption(458) = '0' then
          begin
            KioskClassNextButton.Appearance.Font.Color     := StringToColorDef(Common.Query.Fields[7].AsString, $004D9900);
            KioskClassNextButton.BorderColor               := KioskClassNextButton.Color;
            KioskClassNextButton.BorderInnerColor          := KioskClassNextButton.Color;
          end
          else if GetOption(458) = '1' then  //blue
          begin
            KioskClassNextButton.BorderColor               := $00D26900;
            KioskClassNextButton.BorderInnerColor          := clWhite;
            KioskClassNextButton.Appearance.Font.Color     := $00D26900;
            KioskClassNextButton.ColorDisabled             := clWhite;
          end
          else if GetOption(458) = '2' then  //Black
          begin
            KioskClassNextButton.BorderColor               := clBlack;
            KioskClassNextButton.BorderInnerColor          := clWhite;
            KioskClassNextButton.Appearance.Font.Color     := clBlack;
            KioskClassNextButton.ColorDisabled             := clWhite;
          end
          else if GetOption(458) = '3' then  //Red
          begin
            KioskClassNextButton.BorderColor               := $000000CC;
            KioskClassNextButton.BorderInnerColor          := clWhite;
            KioskClassNextButton.Appearance.Font.Color     := $000000CC;
            KioskClassNextButton.ColorDisabled             := clWhite;
          end
          else if GetOption(458) = '4' then  //Red
          begin
            KioskClassNextButton.BorderColor               := $00009900;
            KioskClassNextButton.BorderInnerColor          := clWhite;
            KioskClassNextButton.Appearance.Font.Color     := $00009900;
            KioskClassNextButton.ColorDisabled             := clWhite;
          end;
        end;
        19 : //포인트
        begin
          KioskPointUseButton.Left                   := StoI(Common.Query.Fields[1].AsString);
          KioskPointUseButton.Top                    := StoI(Common.Query.Fields[2].AsString);
          KioskPointUseButton.Width                  := StoI(Common.Query.Fields[3].AsString);
          KioskPointUseButton.Height                 := StoI(Common.Query.Fields[4].AsString);
          KioskPointUseButton.Visible                := Common.Query.Fields[5].AsString = '0';
          KioskPointUseButton.Appearance.Font.Name              := Common.Query.Fields[6].AsString;
          KioskPointUseButton.Appearance.Font.Color             := StringToColorDef(Common.Query.Fields[7].AsString, clWhite);
          KioskPointUseButton.Appearance.Font.Size              := StoI(Common.Query.Fields[8].AsString);
          KioskPointUseButton.Color              := StringToColorDef(Common.Query.Fields[9].AsString, clBlue);
          if Common.Query.Fields[15].AsString <> '' then
            KioskPointUseButton.Hint := Common.Query.Fields[15].AsString
          else
            KioskPointUseButton.Hint := '포인트사용';

          if KioskPointUseButton.Color = clWhite then
            Common.SetButtonColor(KioskPointUseButton, true);
          if Common.Query.Fields[12].AsString = '1' then
            KioskPointUseButton.Appearance.Font.Style         := [fsBold]
          else
            KioskPointUseButton.Appearance.Font.Style         := [];

          case Common.KioskConfig[13] of
            0 : KioskPointUseButton.Picture := nil;
            1 : KioskPointUseButton.Appearance.Layout := blPictureTop;
            2 : KioskPointUseButton.Appearance.Layout := blPictureBottom;
            3 : KioskPointUseButton.Appearance.Layout := blPictureLeft;
            4 : KioskPointUseButton.Appearance.Layout := blPictureRight;
          end;

        end;
        20 : //포인트/스템프조회
        begin
          KioskPointSearchButton.Left             := StoI(Common.Query.Fields[1].AsString);
          KioskPointSearchButton.Top              := StoI(Common.Query.Fields[2].AsString);
          KioskPointSearchButton.Width            := StoI(Common.Query.Fields[3].AsString);
          KioskPointSearchButton.Height           := StoI(Common.Query.Fields[4].AsString);
          KioskPointSearchButton.Visible          := Common.Query.Fields[5].AsString = '0';
          KioskPointSearchButton.Appearance.Font.Name        := Common.Query.Fields[6].AsString;
          KioskPointSearchButton.Appearance.Font.Color       := StringToColorDef(Common.Query.Fields[7].AsString, clWhite);
          KioskPointSearchButton.Appearance.Font.Size        := StoI(Common.Query.Fields[8].AsString);
          KioskPointSearchButton.Color            := StringToColorDef(Common.Query.Fields[9].AsString, clBlue);
          if Common.Query.Fields[15].AsString <> '' then
            KioskPointSearchButton.Hint := Common.Query.Fields[15].AsString
          else
            KioskPointSearchButton.Hint := '포인트조회';

          if KioskPointSearchButton.Color = clWhite then
            Common.SetButtonColor(KioskPointSearchButton, true);
          if Common.Query.Fields[12].AsString = '1' then
            KioskPointSearchButton.Appearance.Font.Style         := [fsBold]
          else
            KioskPointSearchButton.Appearance.Font.Style         := [];

          case Common.KioskConfig[13] of
            0 : KioskPointSearchButton.Picture := nil;
            1 : KioskPointSearchButton.Appearance.Layout := blPictureTop;
            2 : KioskPointSearchButton.Appearance.Layout := blPictureBottom;
            3 : KioskPointSearchButton.Appearance.Layout := blPictureLeft;
            4 : KioskPointSearchButton.Appearance.Layout := blPictureRight;
          end;
        end;
        21 : //주문
        begin
          KioskOrderButton.Left                   := StoI(Common.Query.Fields[1].AsString);
          KioskOrderButton.Top                    := StoI(Common.Query.Fields[2].AsString);
          KioskOrderButton.Width                  := StoI(Common.Query.Fields[3].AsString);
          KioskOrderButton.Height                 := StoI(Common.Query.Fields[4].AsString);
          KioskOrderButton.Visible                := Common.Query.Fields[5].AsString = '0';
          KioskOrderButton.Appearance.Font.Name              := Common.Query.Fields[6].AsString;
          KioskOrderButton.Appearance.Font.Color             := StringToColorDef(Common.Query.Fields[7].AsString, clWhite);
          KioskOrderButton.Appearance.Font.Size              := StoI(Common.Query.Fields[8].AsString);
          KioskOrderButton.Color                  := StringToColorDef(Common.Query.Fields[9].AsString, clBlue);
          if Common.Query.Fields[15].AsString <> '' then
            KioskOrderButton.Hint := Common.Query.Fields[15].AsString
          else
            KioskOrderButton.Hint := '주문';

          if KioskOrderButton.Color = clWhite then
            Common.SetButtonColor(KioskOrderButton, true);
          if Common.Query.Fields[12].AsString = '1' then
            KioskOrderButton.Appearance.Font.Style         := [fsBold]
          else
            KioskOrderButton.Appearance.Font.Style         := [];

          case Common.KioskConfig[13] of
            0 : KioskOrderButton.Picture := nil;
            1 : KioskOrderButton.Appearance.Layout := blPictureTop;
            2 : KioskOrderButton.Appearance.Layout := blPictureBottom;
            3 : KioskOrderButton.Appearance.Layout := blPictureLeft;
            4 : KioskOrderButton.Appearance.Layout := blPictureRight;
          end;

        end;
        22 : //스템프사용
        begin
          KisokStampButton.Left                := StoI(Common.Query.Fields[1].AsString);
          KisokStampButton.Top                 := StoI(Common.Query.Fields[2].AsString);
          KisokStampButton.Width               := StoI(Common.Query.Fields[3].AsString);
          KisokStampButton.Height              := StoI(Common.Query.Fields[4].AsString);
          KisokStampButton.Visible             := Common.Query.Fields[5].AsString = '0';
          KisokStampButton.Appearance.Font.Name           := Common.Query.Fields[6].AsString;
          KisokStampButton.Appearance.Font.Color          := StringToColorDef(Common.Query.Fields[7].AsString, clWhite);
          KisokStampButton.Appearance.Font.Size           := StoI(Common.Query.Fields[8].AsString);
          KisokStampButton.Color               := StringToColorDef(Common.Query.Fields[9].AsString, clBlue);
          if Common.Query.Fields[15].AsString <> '' then
            KisokStampButton.Hint := Common.Query.Fields[15].AsString
          else
            KisokStampButton.Hint := '스템프사용';

          if KisokStampButton.Color = clWhite then
            Common.SetButtonColor(KisokStampButton, true);
          if Common.Query.Fields[12].AsString = '1' then
            KisokStampButton.Appearance.Font.Style         := [fsBold]
          else
            KisokStampButton.Appearance.Font.Style         := [];

          case Common.KioskConfig[13] of
            0 : KisokStampButton.Picture := nil;
            1 : KisokStampButton.Appearance.Layout := blPictureTop;
            2 : KisokStampButton.Appearance.Layout := blPictureBottom;
            3 : KisokStampButton.Appearance.Layout := blPictureLeft;
            4 : KisokStampButton.Appearance.Layout := blPictureRight;
          end;

        end;
        23 : //할인금액
        begin
          KioskDcAmtLabel.Left                   := StoI(Common.Query.Fields[1].AsString);
          KioskDcAmtLabel.Top                    := StoI(Common.Query.Fields[2].AsString);
          KioskDcAmtLabel.Width                  := StoI(Common.Query.Fields[3].AsString);
          KioskDcAmtLabel.Height                 := StoI(Common.Query.Fields[4].AsString);
          KioskDcAmtLabel.Style.Font.Name        := Common.Query.Fields[6].AsString;
          KioskDcAmtLabel.Style.Font.Color       := StringToColorDef(Common.Query.Fields[7].AsString, clWhite);
          KioskDcAmtLabel.Style.Font.Size        := StoI(Common.Query.Fields[8].AsString);
          KioskDcAmtLabel.Visible             := Common.Query.Fields[5].AsString = '0';
          if Common.Query.Fields[12].AsString = '1' then
            KioskDcAmtLabel.Style.Font.Style         := [fsBold]
          else
            KioskDcAmtLabel.Style.Font.Style         := [];
        end;
        24 : //주문금액
        begin
          KioskOrderAmtLabel.Left                := StoI(Common.Query.Fields[1].AsString);
          KioskOrderAmtLabel.Top                 := StoI(Common.Query.Fields[2].AsString);
          KioskOrderAmtLabel.Width               := StoI(Common.Query.Fields[3].AsString);
          KioskOrderAmtLabel.Height              := StoI(Common.Query.Fields[4].AsString);
          KioskOrderAmtLabel.Style.Font.Name     := Common.Query.Fields[6].AsString;
          KioskOrderAmtLabel.Style.Font.Color    := StringToColorDef(Common.Query.Fields[7].AsString, clWhite);
          KioskOrderAmtLabel.Style.Font.Size     := StoI(Common.Query.Fields[8].AsString);
          KioskOrderAmtLabel.Visible             := Common.Query.Fields[5].AsString = '0';
          if Common.Query.Fields[12].AsString = '1' then
            KioskOrderAmtLabel.Style.Font.Style         := [fsBold]
          else
            KioskOrderAmtLabel.Style.Font.Style         := [];
        end;
        25 :  //간편결제
        begin
          KioskEasyPayButton.Left                    := StoI(Common.Query.Fields[1].AsString);
          KioskEasyPayButton.Top                     := StoI(Common.Query.Fields[2].AsString);
          KioskEasyPayButton.Width                   := StoI(Common.Query.Fields[3].AsString);
          KioskEasyPayButton.Height                  := StoI(Common.Query.Fields[4].AsString);
          KioskEasyPayButton.Visible                 := Common.Query.Fields[5].AsString = '0';
          KioskEasyPayButton.Appearance.Font.Name               := Common.Query.Fields[6].AsString;
          KioskEasyPayButton.Appearance.Font.Color              := StringToColorDef(Common.Query.Fields[7].AsString, clWhite);
          KioskEasyPayButton.Appearance.Font.Size               := StoI(Common.Query.Fields[8].AsString);
          KioskEasyPayButton.Color                   := StringToColorDef(Common.Query.Fields[9].AsString, clBlue);
          if Common.Query.Fields[15].AsString <> '' then
            KioskEasyPayButton.Hint := Common.Query.Fields[15].AsString
          else
            KioskEasyPayButton.Hint := '간편결제';

          if KioskEasyPayButton.Color = clWhite then
            Common.SetButtonColor(KioskEasyPayButton, true);
          if Common.Query.Fields[12].AsString = '1' then
            KioskEasyPayButton.Appearance.Font.Style         := [fsBold]
          else
            KioskEasyPayButton.Appearance.Font.Style         := [];

          case Common.KioskConfig[13] of
            0 : KioskEasyPayButton.Picture := nil;
            1 : KioskEasyPayButton.Appearance.Layout := blPictureTop;
            2 : KioskEasyPayButton.Appearance.Layout := blPictureBottom;
            3 : KioskEasyPayButton.Appearance.Layout := blPictureLeft;
            4 : KioskEasyPayButton.Appearance.Layout := blPictureRight;
          end;
        end;
        26 : //다국어
        begin
          KioskFlagButton.Left                    := StoI(Common.Query.Fields[1].AsString);
          KioskFlagButton.Top                     := StoI(Common.Query.Fields[2].AsString);
          if GetOption(485) = '0' then
          begin
            KioskFlagButton.Width      := 60;
            KioskFlagButton.Height     := 40;
            KioskWaitFlagButton.Width  := 60;
            KioskWaitFlagButton.Height := 40;
          end
          else
          begin
            KioskFlagButton.Width      := 92;
            KioskFlagButton.Height     := 62;
            KioskWaitFlagButton.Width  := 92;
            KioskWaitFlagButton.Height := 62;
          end;
          KioskFlagButton.Visible                 := (Common.Query.Fields[5].AsString = '0') and (GetOption(457) = '1');
          if KioskFlagButton.Visible then
            KioskFlagButton.Picture.Assign(FlageCollection.Items.Items[Ifthen(GetOption(485)='0',0,9)].Picture.Graphic);
          KioskWaitFlagButton.OptionsImage.Glyph.Assign(FlageCollection.Items.Items[Ifthen(GetOption(485)='0',0,9)].Picture.Graphic);
        end;
        27 : //확대축소
        begin
          KioskVoiceListenButton.Left                := StoI(Common.Query.Fields[1].AsString);
          KioskVoiceListenButton.Top                 := StoI(Common.Query.Fields[2].AsString);
          KioskVoiceListenButton.Width               := StoI(Common.Query.Fields[3].AsString);
          KioskVoiceListenButton.Height              := StoI(Common.Query.Fields[4].AsString);
          KioskVoiceListenButton.Visible             := Common.Query.Fields[5].AsString = '0';
          KioskVoiceListenButton.Appearance.Font.Name           := Common.Query.Fields[6].AsString;
          KioskVoiceListenButton.Appearance.Font.Color          := StringToColorDef(Common.Query.Fields[7].AsString, clWhite);
          KioskVoiceListenButton.Appearance.Font.Size           := StoI(Common.Query.Fields[8].AsString);
          KioskVoiceListenButton.Color               := StringToColorDef(Common.Query.Fields[9].AsString, clBlue);
          if Common.Query.Fields[15].AsString <> '' then
            KioskVoiceListenButton.Hint := Common.Query.Fields[15].AsString
          else
            KioskVoiceListenButton.Hint := '메뉴안내';

          if KioskVoiceListenButton.Color = clWhite then
            Common.SetButtonColor(KioskVoiceListenButton, true);
          if Common.Query.Fields[12].AsString = '1' then
            KioskVoiceListenButton.Appearance.Font.Style         := [fsBold]
          else
            KioskVoiceListenButton.Appearance.Font.Style         := [];

          case Common.KioskConfig[13] of
            0 : KioskVoiceListenButton.Picture := nil;
            1 : KioskVoiceListenButton.Appearance.Layout := blPictureTop;
            2 : KioskVoiceListenButton.Appearance.Layout := blPictureBottom;
            3 : KioskVoiceListenButton.Appearance.Layout := blPictureLeft;
            4 : KioskVoiceListenButton.Appearance.Layout := blPictureRight;
          end;
        end;
        28 : //볼륨조절
        begin
          VolumePanel.Left                := StoI(Common.Query.Fields[1].AsString);
          VolumePanel.Top                 := StoI(Common.Query.Fields[2].AsString);
          VolumePanel.Width               := StoI(Common.Query.Fields[3].AsString);
          VolumePanel.Height              := StoI(Common.Query.Fields[4].AsString);
          VolumePanel.Visible             := Common.Query.Fields[5].AsString = '0';
          KioskVolumeUpButton.Color       := StringToColorDef(Common.Query.Fields[9].AsString, clBlue);
          KioskVolumeDownButton.Color     := StringToColorDef(Common.Query.Fields[9].AsString, clBlue);
          if VolumePanel.Visible then
            GetVolume;
        end;
        31 :
        begin
          KioskUseTypeButton.Left                   := StoI(Common.Query.Fields[1].AsString);
          KioskUseTypeButton.Top                    := StoI(Common.Query.Fields[2].AsString);
          KioskUseTypeButton.Width                  := StoI(Common.Query.Fields[3].AsString);
          KioskUseTypeButton.Height                 := StoI(Common.Query.Fields[4].AsString);
          KioskUseTypeButton.Visible                := Common.Query.Fields[5].AsString = '0';
          KioskUseTypeButton.Appearance.Font.Name   := Common.Query.Fields[6].AsString;
          KioskUseTypeButton.Appearance.Font.Color  := StringToColorDef(Common.Query.Fields[7].AsString, clWhite);
          KioskUseTypeButton.Appearance.Font.Size   := StoI(Common.Query.Fields[8].AsString);
          KioskUseTypeButton.BorderColor            := StringToColorDef(Common.Query.Fields[9].AsString, clBlue);
        end;
      end;
      Common.Query.Next;
    end;
    Common.Query.Close;

    if VolumePanel.Visible then
      try
        EndpointVolume:=nil;
        CoCreateInstance(CLASS_IMMDeviceEnumerator, nil, CLSCTX_INPROC_SERVER, IID_IMMDeviceEnumerator, vDeviceEnumerator);
        vDeviceEnumerator.GetDefaultAudioEndpoint(eRender, eConsole, vDefaultDevice);
        vDefaultDevice.Activate(IID_IAudioEndpointVolume, CLSCTX_INPROC_SERVER, nil, endpointVolume);
      except
        Common.ErrBox('볼륨제어 설정 오류');
      end;

    KioskCashButton.Caption        := KioskCashButton.Hint;
    KioskCardButton.Caption        := KioskCardButton.Hint;
    KioskInitButton.Caption        := KioskInitButton.Hint;
    KioskCallButton.Caption        := KioskCallButton.Hint;
    KioskPointUseButton.Caption    := KioskPointUseButton.Hint;
    KioskPointSearchButton.Caption := KioskPointSearchButton.Hint;
    KisokStampButton.Caption       := KisokStampButton.Hint;
    KioskOrderButton.Caption       := KioskOrderButton.Hint;
    KioskEasyPayButton.Caption     := KioskEasyPayButton.Hint;
    KioskMemberJoinButton.Caption  := KioskMemberJoinButton.Hint;
  end;
  IsCutDc := True;

  if GetOption(300)='1' then
    OrderMenuLabel.Width := -1;

  ReceiptPrintGroupBox.Enabled   := GetOption(256) = '0';

  //푸드기능을 사용하지 않을때
  if GetOption(254) = '1' then
  begin
    BillPrintGroupBox.Enabled    := False;
    KitchenPrintGroupBox.Enabled := False;
    MenuPrintGroupBox.Enabled    := False;
  end;

  Left          := 0;
  SelectedClass := '00';

  {그리드 초기화}
  GridTitleShape.Text     :=Common.Config.TitleCaption;

  with Main_SGrd do
  begin
    DefaultRowHeight := Ifthen(Common.Config.ListRowHeight=0, 28, Common.Config.ListRowHeight);
    OnDrawCell := Common.GridDrawCell;
    ColWidths[GDM_NO       ] := Common.Config.TitleWidth[1] div 2; //순번
    ColWidths[GDM_TYPE     ] := Common.Config.TitleWidth[1] div 2; //메뉴타입
    ColWidths[GDM_NM_MENU  ] := Common.Config.TitleWidth[2];       //메뉴명
    ColWidths[GDM_VIEWQTY  ] := Common.Config.TitleWidth[3];       //수량
    ColWidths[GDM_VIEWPRICE] := Common.Config.TitleWidth[4];       //메뉴단가
    ColWidths[GDM_AMT      ] := Common.Config.TitleWidth[5];
    ColWidths[GDM_DC_MENU  ] := Common.Config.TitleWidth[6];     //할인단가
    ColWidths[GDM_CD_MENU  ] := -1;
    ColWidths[GDM_SEQ      ] := -1;
    ColWidths[GDM_DS_MENU  ] := -1;
    ColWidths[GDM_CD_MENU1 ] := -1;
  end;

  GroupOrderPanel.Top    := GridTitleShape.Top;
  GroupOrderPanel.Left   := PluClassPanel.Left;
  GroupOrderPanel.Width  := PluClassPanel.Width;
  GroupOrderPanel.Height := PluClassPanel.Height + PluMenuPanel.Height + 10;
  GroupOrder_sGrd.ColCount        := GDM_COLCOUNT;
  with GroupOrder_sGrd do
  begin
    DefaultRowHeight := 30;
    OnDrawCell := Common.GridDrawCell;
    ColWidths[GDM_NO       ] := 30; //순번
    ColWidths[GDM_TYPE     ] := 30; //메뉴타입
    ColWidths[GDM_NM_MENU  ] := 200 + (GroupOrderPanel.Width - 505);       //메뉴명
    ColWidths[GDM_VIEWQTY  ] := 60;       //수량
    ColWidths[GDM_VIEWPRICE] := 80;       //메뉴단가
    ColWidths[GDM_AMT      ] := 100;
    ColWidths[GDM_DC_MENU  ] := -1;     //할인단가
    ColWidths[GDM_CD_MENU  ] := -1;                              //메뉴코드
  end;

  with Cancel_sGrd do
  begin
    DefaultRowHeight := Ifthen(Common.Config.ListRowHeight=0, 28, Common.Config.ListRowHeight);
    OnDrawCell := Common.GridDrawCell;
    ColCount                 := GDM_COLCOUNT;

    ColWidths[GDM_NO       ] := Common.Config.TitleWidth[1] div 2; //순번
    ColWidths[GDM_TYPE     ] := Common.Config.TitleWidth[1] div 2; //메뉴타입
    ColWidths[GDM_NM_MENU  ] := Common.Config.TitleWidth[2];       //메뉴명
    ColWidths[GDM_VIEWQTY  ] := Common.Config.TitleWidth[3];       //수량
    ColWidths[GDM_VIEWPRICE] := Common.Config.TitleWidth[4];       //메뉴단가
    ColWidths[GDM_AMT      ] := Common.Config.TitleWidth[5];
    ColWidths[GDM_DC_MENU  ] := Common.Config.TitleWidth[6];       //할인단가

    Color                    := $00B3FFFF;
  end;

  with GroupTable_sGrd do
  begin
    DefaultRowHeight := Ifthen(Common.Config.ListRowHeight=0, 28, Common.Config.ListRowHeight);
    OnDrawCell := Common.GridDrawCell;
    ColCount                 := 2;

    ColWidths[0 ] := Trunc(GroupTable_sGrd.Width * 0.7);
    ColWidths[1 ] := Trunc(GroupTable_sGrd.Width * 0.3);
  end;

  {그리드 초기화}
  with Present_sGrd do
  begin
    ColCount             := GDP_COLCOUNT;
    ColWidths[GDP_KIND ] := Width div 2;    //구분
    ColWidths[GDP_AMT  ] := Width div 2-10;// 80;    //금액
    Font.Size            := Font.Size;
    if not PresnetPanel.Visible then
      DefaultRowHeight     := 40;
  end;

  if not Common.Config.IsKiosk then
  begin
    lbl_OrderCount.Visible := GetOption(36) = '1';

    IsEnter        := false;
    FIsLastTakeOut := false;
    bGroupAddTime  := false;
    MenuPrintGroupBox.Enabled := Common.PosType <> ptOnlyOrder;

    //위해상품차단 기능 사용할때
    if GetOption(371) = '1' then
    begin
      if not DM.UPSSConnect then
      begin
        Common.MsgBox('위해상품 판매차단 모듈이 잘못 설치되었습니다');
        Common.Config.Options[371] := '0';
        Exit;
      end
      else
        UPSS_F := TUPSS_F.Create(Self);
    end;
  end;

  //키오스크 일때
  KioskBeginImageExist := false;
  if Common.Config.IsKiosk then
  begin
    //메인이미지명
    if FileExists(Common.AppPath+'Kiosk\Order.jpg') then
      KioskMainImageFileName := 'Order.jpg'
    else if FileExists(Common.AppPath+'Kiosk\Order.png') then
      KioskMainImageFileName := 'Order.png';

    if FileExists(Common.AppPath+'Kiosk\OrderWheelChair.jpg') then
      KioskChiarImageFileName := 'OrderWheelChair.jpg'
    else if FileExists(Common.AppPath+'Kiosk\OrderWheelChair.png') then
      KioskChiarImageFileName := 'OrderWheelChair.png';

    if FileExists(Common.AppPath+'Kiosk\OrderLowVision.jpg') then
      KioskVisionImageFileName := 'OrderLowVision.jpg'
    else if FileExists(Common.AppPath+'Kiosk\OrderLowVision.png') then
      KioskVisionImageFileName := 'OrderLowVision.png';


    KioskPanel.Top  := 0;
    KioskPanel.Left := 0;
    if (Common.Config.BarrierFreeMode = bfWheelChair) and FileExists(Common.AppPath+'\Kiosk\'+KioskChiarImageFileName) then
      vImageFile := KioskChiarImageFileName
    else if (Common.Config.BarrierFreeMode = bfLowVision) and FileExists(Common.AppPath+'\Kiosk\'+KioskVisionImageFileName) then
      vImageFile := KioskVisionImageFileName
    else
      vImageFile := KioskMainImageFileName;

    if FileExists(Common.AppPath+'\Kiosk\'+vImageFile) then
    begin
      with TImage.Create(Self) do
      begin
        Parent      := KioskPanel;
        Name        := 'pan_kiosksale';
        Align       := alClient;
        Picture.LoadFromFile(Common.AppPath+'\Kiosk\'+vImageFile);
        Caption     := EmptyStr;
        SendToBack;
      end;
      KioskStoreNameLabel.Visible := false;
    end
    else
    begin
      KioskStoreNameLabel.Visible := true;
      KioskStoreNameLabel.Caption := Common.Config.StoreName;
    end;

    KioskBeginImageChangeTime := 10;
    //대기화면을 테이블 선택으로 사용시
    if (GetOption(426) = '5') and (Common.KioskWaitList.Count > 0) then
    begin
      KioskWaitPanel.Width   := Self.Width;
      KioskWaitPanel.Height  := Self.Height;
      KioskWaitPanel.Top     := 0;
      KioskWaitPanel.Left    := 0;

      KioskBeginImageCount   := 1;
      KioskBeginImageExist   := true;
      KioskBeginImageIndex   := 0;
      KioskWaitImagePanel.Visible       := true;
      KisokWaitImage := TImage.Create(self);
      KisokWaitImage.Parent := KioskWaitImagePanel;
      KisokWaitImage.Align  := alClient;
      KisokWaitImage.Stretch := true;
      if GetOption(477) = '1' then
        KisokWaitImage.OnClick := KioskStoreButtonClick
      else if GetOption(477) = '2' then
        KisokWaitImage.OnClick := KioskTakeOutButtonClick;
      KioskWaitBottomPanel.Visible := false;
    end
    else if (GetOption(424) <> '0') and (Common.KioskWaitList.Count > 0) and (Common.KioskWaitImage <> 'P') then
    begin
      KioskWaitPanel.Width   := Self.Width;
      KioskWaitPanel.Height  := Self.Height;
      KioskWaitPanel.Top     := 0;
      KioskWaitPanel.Left    := 0;
      KioskBeginImageCount   := 1;
      KioskBeginImageExist   := true;
      KioskWaitImagePanel.Visible       := true;
      VideoRenderOrgMethod   := KioskWaitImagePanel.WindowProc;
      KioskWaitImagePanel.WindowProc    := VideoRenderWndProc;


      isFirst := true;
      AviTimerTimer(nil);
    end
    else if (GetOption(424) <> '0') and (Common.KioskWaitList.Count > 0) then
    begin
      KioskWaitPanel.Width   := Self.Width;
      KioskWaitPanel.Height  := Self.Height;
      KioskWaitPanel.Top     := 0;
      KioskWaitPanel.Left    := 0;
      KioskWaitPanel.Visible := true;
      KioskWaitImagePanel.Align  := alClient;
      KioskWaitImagePanel.Width   := Self.Width;
      KioskWaitImagePanel.Height := Self.Height;

      KioskBeginImageCount   := Common.KioskWaitList.Count;
      KioskBeginImageExist := true;
      KioskBeginImageIndex := 0;
      KioskWaitImagePanel.Visible     := true;
      KisokWaitImage := TImage.Create(Self);
      KisokWaitImage.Parent := KioskWaitImagePanel;
      KisokWaitImage.Align  := alClient;
      KisokWaitImage.Width   := Self.Width;
      KisokWaitImage.Height := Self.Height;
      KisokWaitImage.Stretch := true;
      if GetOption(477) = '1' then
        KisokWaitImage.OnClick := KioskStoreButtonClick
      else if GetOption(477) = '2' then
        KisokWaitImage.OnClick := KioskTakeOutButtonClick;
      //화일이 없으면 다시 다운로드 받는다
      if not FileExists(Common.KioskWaitList.Strings[0]) then
        Common.SetIniFile('POS','KIOSK_DN','');

      Common.SetPNGImage(KisokWaitImage, Common.KioskWaitList.Strings[0]);
      if GetOption(424) = '0' then
        KioskWaitBottomPanel.Visible := false;
    end;

    with TIniFile.Create(Common.AppPath+'Kiosk\KioskConfig.ini') do
    try
      Common.Config.KioskDefaultFontName := ReadString('공통','FontName','맑은 고딕');
      Common.Config.KioskButtonRound     := ReadInteger('공통','Round', 40);
      Common.Config.KioskOrderPassWord   := ReadString('공통','주문비밀번호','');
      if Common.Config.KioskOrderPassWord = '' then
        WriteString('공통','주문비밀번호','$');

      if ReadString('주문대기','FontName','') = '' then
      begin
        WriteString('주문대기','FontName','맑은 고딕');
        WriteInteger('주문대기','FontSize',25);
        WriteInteger('주문대기','Width',300);
        WriteInteger('주문대기','Height',200);
        WriteInteger('주문대기','Round',0);
        WriteInteger('주문대기','Top', KioskWaitPanel.Height - 100);
        WriteInteger('주문대기','매장이용_Left',0);
        WriteInteger('주문대기','포장_Left',0);
        WriteInteger('주문대기','다국어_Left',0);
        WriteInteger('주문대기','다국어_Top',0);

        WriteString('주문대기','매장이용_Color','$00D26900');
        WriteString('주문대기','포장_Color','$003B3B3B');
        WriteString('배리어프리','모드', Ifthen(Common.isBFKiosk,'Y','N'));
      end;
      KioskStoreButton.Appearance.Font.Name   := ReadString('주문대기','FontName','맑은 고딕');
      KioskStoreButton.Appearance.Font.Size   := ReadInteger('주문대기','FontSize',25);
      KioskTakeOutButton.Appearance.Font.Name := ReadString('주문대기','FontName','맑은 고딕');
      KioskTakeOutButton.Appearance.Font.Size := ReadInteger('주문대기','FontSize',25);
      KioskStoreButton.Width                  := ReadInteger('주문대기','Width',300);
      KioskTakeOutButton.Width                := ReadInteger('주문대기','Width',300);

      KioskStoreButton.Height                 := ReadInteger('주문대기','Height',200);
      KioskTakeOutButton.Height               := ReadInteger('주문대기','Height',200);
      KioskStoreButton.Appearance.Rounding    := ReadInteger('주문대기','Round',0);
      KioskTakeOutButton.Appearance.Rounding  := ReadInteger('주문대기','Round',0);

      vTop                                    := ReadInteger('주문대기','Top',0);
      vStoreButtonTop                         := ReadInteger('주문대기','매장이용_Top',0);
      vTakeOutButtonTop                       := ReadInteger('주문대기','포장_Top',0);
      vStoreButtonLeft                        := ReadInteger('주문대기','매장이용_Left',0);
      vTakeOutButtonLeft                      := ReadInteger('주문대기','포장_Left',0);

      vFlagLeft                               := ReadInteger('주문대기','다국어_Left',0);
      vFlagTop                                := ReadInteger('주문대기','다국어_Top',0);
      KioskFlagAlwaysShow                     := ReadString('주문대기','다국어_Show','N') = 'Y';
      KioskStoreButton.Color                  := StringToColorDef(ReadString('주문대기','매장이용_Color','$00D26900'),$00D26900) ;
      KioskTakeOutButton.Color                := StringToColorDef(ReadString('주문대기','포장_Color','$003B3B3B'),$003B3B3B) ;

      //배리어프리
      KioskBarrierfreeWheelChairButton.Appearance.Font.Name := ReadString('배리어프리_저자세','FontName','맑은 고딕');
      KioskBarrierfreeWheelChairButton.Appearance.Font.Size := ReadInteger('배리어프리_저자세','FontSize',25);
      KioskBarrierfreeWheelChairButton.Appearance.Rounding  := ReadInteger('배리어프리_저자세','Round',0);
      KioskBarrierfreeWheelChairButton.Width                := ReadInteger('배리어프리_저자세','Width',250);
      KioskBarrierfreeWheelChairButton.Height               := ReadInteger('배리어프리_저자세','Height',165);
      KioskBarrierfreeWheelChairButton.Top                  := ReadInteger('배리어프리_저자세','Top',500);
      KioskBarrierfreeWheelChairButton.Left                 := ReadInteger('배리어프리_저자세','Left',10);
      KioskBarrierfreeWheelChairButton.Color                := StringToColorDef(ReadString('배리어프리_저자세','Color','$003B3B3B'),$003B3B3B) ;

      WriteString('배리어프리_저자세','FontName',KioskBarrierfreeWheelChairButton.Appearance.Font.Name);
      WriteInteger('배리어프리_저자세','FontSize',KioskBarrierfreeWheelChairButton.Appearance.Font.Size);
      WriteInteger('배리어프리_저자세','Round',KioskBarrierfreeWheelChairButton.Appearance.Rounding);
      WriteInteger('배리어프리_저자세','Width',KioskBarrierfreeWheelChairButton.Width);
      WriteInteger('배리어프리_저자세','Height',KioskBarrierfreeWheelChairButton.Height);
      WriteInteger('배리어프리_저자세','Top',KioskBarrierfreeWheelChairButton.Top);
      WriteInteger('배리어프리_저자세','Left',KioskBarrierfreeWheelChairButton.Left);
      WriteString('배리어프리_저자세','Color',ColorToString(KioskBarrierfreeWheelChairButton.Color));

      KioskBarrierfreeLowVisionButton.Appearance.Font.Name := ReadString('배리어프리_저시력','FontName','맑은 고딕');
      KioskBarrierfreeLowVisionButton.Appearance.Font.Size := ReadInteger('배리어프리_저시력','FontSize',25);
      KioskBarrierfreeLowVisionButton.Appearance.Rounding  := ReadInteger('배리어프리_저시력','Round',0);
      KioskBarrierfreeLowVisionButton.Width                := ReadInteger('배리어프리_저시력','Width',250);
      KioskBarrierfreeLowVisionButton.Height               := ReadInteger('배리어프리_저시력','Height',165);
      KioskBarrierfreeLowVisionButton.Top                  := ReadInteger('배리어프리_저시력','Top',500);
      KioskBarrierfreeLowVisionButton.Left                 := ReadInteger('배리어프리_저시력','Left',300);
      KioskBarrierfreeLowVisionButton.Color                := StringToColorDef(ReadString('배리어프리_저시력','Color','$003B3B3B'),$003B3B3B) ;

      WriteString('배리어프리_저시력','FontName',KioskBarrierfreeLowVisionButton.Appearance.Font.Name);
      WriteInteger('배리어프리_저시력','FontSize',KioskBarrierfreeLowVisionButton.Appearance.Font.Size);
      WriteInteger('배리어프리_저시력','Round',KioskBarrierfreeLowVisionButton.Appearance.Rounding);
      WriteInteger('배리어프리_저시력','Width',KioskBarrierfreeLowVisionButton.Width);
      WriteInteger('배리어프리_저시력','Height',KioskBarrierfreeLowVisionButton.Height);
      WriteInteger('배리어프리_저시력','Top',KioskBarrierfreeLowVisionButton.Top);
      WriteInteger('배리어프리_저시력','Left',KioskBarrierfreeLowVisionButton.Left);
      WriteString('배리어프리_저시력','Color',ColorToString(KioskBarrierfreeLowVisionButton.Color));
      
    finally
      free;
    end;

    if GetOption(488) = '1' then
      TableClearImage.Visible := true;

    //대기화면에서 테이블을 선택합니다.
    if (GetOption(426) = '5') and (Common.KioskWaitList.Count > 0) then
    begin
      KioskTableCreate;
      SetKioskBeginImage;
    end
    else if (GetOption(424) <> '0') and KioskBeginImageExist then
    begin
      //대기 AVI아니고 이미지일때
      if Common.KioskWaitImage = 'P' then
      begin
        KioskWaitBottomPanel.Visible := false;
        KioskStoreButton.Parent      := KioskWaitImagePanel;
        KioskTakeOutButton.Parent    := KioskWaitImagePanel;
        KioskBarrierfreeWheelChairButton.Parent    := KioskWaitImagePanel;
        KioskBarrierfreeLowVisionButton.Parent   := KioskWaitImagePanel;
        KioskStoreButton.Top         := vTop;
        KioskTakeOutButton.Top       := vTop;
        //다국어 버튼을 항상표시할때
        if KioskFlagAlwaysShow then
        begin
          KioskWaitFlagButton.Top      := vFlagTop;
          KioskWaitFlagButton.Left     := vFlagLeft;

          vFlag := 0;
          with TcxButton.Create(Self) do
          begin
            Parent  := KioskWaitPanel;
            Left    := vFlagLeft;
            Top     := vFlagTop;
            Width   := KioskWaitFlagButton.Width;
            Height  := KioskWaitFlagButton.Height;
            PaintStyle := bpsGlyph;
            SpeedButtonOptions.Flat := true;
            SpeedButtonOptions.Transparent := true;
            SpeedButtonOptions.CanBeFocused := false;
            SpeedButtonOptions.AllowAllUp   := true;
            LookAndFeel.Kind := lfFlat;
            LookAndFeel.NativeStyle := false;
            Color   := clWhite;
            Tag     := vFlag;
            OnClick := ThaiButtonClick;
            if GetOption(485) = '0' then
              OptionsImage.Glyph.Assign(FlageCollection.Items.Items[0].Picture.Graphic)
            else
              OptionsImage.Glyph.Assign(FlageCollection.Items.Items[9].Picture.Graphic);
          end;

          for vIndex := 1 to 8 do
          begin
            vFlag := vFlag + 1;

            if Copy(Common.Config.UseLanguage,vIndex,1) = '1' then
            begin
              vFlagLeft := vFlagLeft + KioskWaitFlagButton.Width + 3;
              with TcxButton.Create(Self) do
              begin
                Parent  := KioskWaitImagePanel;
                Left    := vFlagLeft;
                Top     := vFlagTop;
                Width   := KioskWaitFlagButton.Width;
                Height  := KioskWaitFlagButton.Height;
                PaintStyle := bpsGlyph;
                SpeedButtonOptions.Flat := true;
                SpeedButtonOptions.Transparent := true;
                SpeedButtonOptions.CanBeFocused := false;
                SpeedButtonOptions.AllowAllUp   := true;
                LookAndFeel.Kind := lfFlat;
                LookAndFeel.NativeStyle := false;
                Color   := clWhite;
                Tag     := vFlag;
                OnClick := ThaiButtonClick;
                if GetOption(485) = '0' then
                  OptionsImage.Glyph.Assign(FlageCollection.Items.Items[vFlag].Picture.Graphic)
                else
                  OptionsImage.Glyph.Assign(FlageCollection.Items.Items[vFlag+9].Picture.Graphic);
              end;
            end;
          end;
        end
        else
        begin
          KioskWaitFlagButton.Top      := vFlagTop;
          KioskWaitFlagButton.Left     := vFlagLeft;
          KioskWaitFlagButton.Visible  := false;
        end;
        KioskWaitFlagButton.Visible  := GetOption(457) = '1';
        //매장이용만 사용
        if GetOption(424) = '1' then
        begin
          if vStoreButtonLeft = 0 then
            KioskStoreButton.Left := (KioskWaitPanel.Width div 2) - (KioskStoreButton.Width div 2)
          else
            KioskStoreButton.Left := vStoreButtonLeft;

          KioskStoreButton.Caption   := '주문시작';
          KioskStoreButton.Hint      := '주문시작';
          KioskTakeOutButton.Visible := false;
        end
        //매장이용, 포장사용
        else if GetOption(424) = '2' then
        begin
          if vStoreButtonLeft = 0 then
          begin
            KioskStoreButton.Left   := (KioskWaitPanel.Width div 2) - ((KioskStoreButton.Width*2+100) div 2);
            KioskTakeOutButton.Left := KioskStoreButton.Left + KioskStoreButton.Width + 100;
          end
          else
          begin
            KioskStoreButton.Left   := vStoreButtonLeft;
            KioskTakeOutButton.Left := vTakeOutButtonLeft;
          end;
        end;
      end
      else
      begin
        KioskWaitBottomPanel.Height := Trunc(KioskWaitPanel.Height * 0.3);
        if GetOption(424) = '1' then
        begin
          if vStoreButtonLeft = 0 then
            KioskStoreButton.Left := (KioskWaitPanel.Width div 2) - (KioskStoreButton.Width div 2)
          else
            KioskStoreButton.Left := vStoreButtonLeft;

          KioskStoreButton.Width     := Trunc(KioskWaitPanel.Width * 0.5);
          KioskStoreButton.Caption   := '주문시작';
          KioskStoreButton.Hint      := '주문시작';
          KioskTakeOutButton.Visible := false;
        end
        else if GetOption(424) = '2' then
        begin
          if vStoreButtonLeft = 0 then
          begin
            KioskStoreButton.Left   := (KioskWaitPanel.Width div 2) - ((KioskStoreButton.Width*2+100) div 2);
            KioskTakeOutButton.Left := KioskStoreButton.Left + KioskStoreButton.Width + 100;
          end
          else
          begin
            KioskStoreButton.Left   := vStoreButtonLeft;
            KioskTakeOutButton.Left := vTakeOutButtonLeft;
          end;
        end;
        KioskStoreButton.Top        := vTop;
        KioskTakeOutButton.Top      := vTop;
      end;

      if (vStoreButtonTop > 0) and (vStoreButtonLeft > 0) then
      begin
        KioskStoreButton.Top        := vStoreButtonTop;
        KioskStoreButton.Left       := vStoreButtonLeft;
      end;
      if (vTakeOutButtonTop > 0) and (vTakeOutButtonLeft > 0) then
      begin
        KioskTakeOutButton.Top        := vTakeOutButtonTop;
        KioskTakeOutButton.Left       := vTakeOutButtonLeft;
      end;
    end;

    if GetOption(424) <> '0' then
    begin
      if FileExists(Common.AppPath+'Kiosk\배리어프리_저자세.png') then
        Common.SetPNGImage(KioskBarrierfreeWheelChairButton, Common.AppPath+'Kiosk\배리어프리_저자세.png');

      if FileExists(Common.AppPath+'Kiosk\배리어프리_저시력.png') then
        Common.SetPNGImage(KioskBarrierfreeLowVisionButton, Common.AppPath+'Kiosk\배리어프리_저시력.png');

      if FileExists(Common.AppPath+'Kiosk\매장이용.png') then
        Common.SetPNGImage(KioskStoreButton, Common.AppPath+'Kiosk\매장이용.png')
      else
      begin
        if Common.Config.KioskBegin1 = '' then
          Common.Config.KioskBegin1 := '먹고 갈게요';
        KioskStoreButton.Caption    := Common.Config.KioskBegin1;
      end;

      if FileExists(Common.AppPath+'Kiosk\포장.png') then
        Common.SetPNGImage(KioskTakeOutButton, Common.AppPath+'Kiosk\포장.png')
      else
      begin
        if Common.Config.KioskBegin2 = '' then
          Common.Config.KioskBegin2 := '포장해 갈게요';
        KioskTakeOutButton.Caption  := Common.Config.KioskBegin2;
      end;
    end
    else
    begin
      KioskStoreButton.Visible   := false;
      KioskTakeOutButton.Visible := false;
    end;

    //다국어기능 사용
    if (GetOption(457) = '1') and (Common.KioskWaitList.Count > 0) then
    begin
      if GetOption(485) = '0' then
      begin
        KioskLanguagePanel.Height := 60;
        vWidth     := 60;
        vHeight    := 40;
        vFlag      := 0;
      end
      else
      begin
        KioskLanguagePanel.Height := 100;
        vWidth     := 96;
        vHeight    := 70;
        vFlag      := 8;
      end;

      KioskLanguagePanel.Visible := true;
      if KioskFlagAlwaysShow then
      begin
        vTop   := 20;
        vLeft  := KioskWaitPanel.Width;
        if Copy(Common.Config.UseLanguage,8,1) = '1' then
        begin
          vLeft                := vLeft - vWidth;
          GermanButton.Picture.Assign(FlageCollection.Items.Items[8+vFlag].Picture.Graphic);
          GermanButton.Width   := vWidth;
          GermanButton.Height  := vHeight;
          GermanButton.Visible := true;
          GermanButton.Left    := vLeft;
          GermanButton.Top     := vTop;
        end
        else
          GermanButton.Visible := false;
        GermanButton.Tag := 8;

        if Copy(Common.Config.UseLanguage,7,1) = '1' then
        begin
          vLeft                := vLeft - vWidth;
          FrenchButton.Picture.Assign(FlageCollection.Items.Items[7+vFlag].Picture.Graphic);
          FrenchButton.Width   := vWidth;
          FrenchButton.Height  := vHeight;
          FrenchButton.Visible := true;
          FrenchButton.Left    := vLeft;
          FrenchButton.Top     := vTop;
        end
        else
          FrenchButton.Visible := false;
        FrenchButton.Tag := 7;
        if Copy(Common.Config.UseLanguage,6,1) = '1' then
        begin
          vLeft              := vLeft - vWidth;
          IndoButton.Picture.Assign(FlageCollection.Items.Items[6+vFlag].Picture.Graphic);
          IndoButton.Width   := vWidth;
          IndoButton.Height  := vHeight;
          IndoButton.Visible := true;
          IndoButton.Left    := vLeft;
          IndoButton.Top     := vTop;
        end
        else
          IndoButton.Visible := false;
        IndoButton.Tag := 6;
        if Copy(Common.Config.UseLanguage,5,1) = '1' then
        begin
          vLeft              := vLeft - vWidth;
          ThaiButton.Picture.Assign(FlageCollection.Items.Items[5+vFlag].Picture.Graphic);
          ThaiButton.Width   := vWidth;
          ThaiButton.Height  := vHeight;
          ThaiButton.Visible := true;
          ThaiButton.Left    := vLeft;
          ThaiButton.Top     := vTop;
        end
        else
          ThaiButton.Visible := false;
        ThaiButton.Tag := 5;
        if Copy(Common.Config.UseLanguage,4,1) = '1' then
        begin
          vLeft                := vLeft - vWidth;
          VitnamButton.Picture.Assign(FlageCollection.Items.Items[4+vFlag].Picture.Graphic);
          VitnamButton.Width   := vWidth;
          VitnamButton.Height  := vHeight;
          VitnamButton.Visible := true;
          VitnamButton.Left    := vLeft;
          VitnamButton.Top     := vTop;
        end
        else
          VitnamButton.Visible := false;
        VitnamButton.Tag := 4;
        if Copy(Common.Config.UseLanguage,3,1) = '1' then
        begin
          vLeft               := vLeft - vWidth;
          JapanButton.Picture.Assign(FlageCollection.Items.Items[3+vFlag].Picture.Graphic);
          JapanButton.Width   := vWidth;
          JapanButton.Height  := vHeight;
          JapanButton.Visible := true;
          JapanButton.Left    := vLeft;
          JapanButton.Top     := vTop;
        end
        else
          JapanButton.Visible := false;
        JapanButton.Tag := 3;

        if Copy(Common.Config.UseLanguage,2,1) = '1' then
        begin
          vLeft                 := vLeft - vWidth;
          ChinaButton.Picture.Assign(FlageCollection.Items.Items[2+vFlag].Picture.Graphic);
          ChinaButton.Width   := vWidth;
          ChinaButton.Height  := vHeight;
          ChinaButton.Visible := true;
          ChinaButton.Left    := vLeft;
          ChinaButton.Top     := vTop;
        end
        else
          ChinaButton.Visible := false;
        ChinaButton.Tag := 2;

        if Copy(Common.Config.UseLanguage,1,1) = '1' then
        begin
          vLeft             := vLeft - vWidth;
          UsaButton.Picture.Assign(FlageCollection.Items.Items[1+vFlag].Picture.Graphic);
          UsaButton.Width   := vWidth;
          UsaButton.Height  := vHeight;
          UsaButton.Visible := true;
          UsaButton.Left    := vLeft;
          UsaButton.Top     := vTop;
        end
        else
          UsaButton.Visible := false;
        UsaButton.Tag     := 1;

        vLeft             := vLeft - vWidth;
        KoreaButton.Picture.Assign(FlageCollection.Items.Items[0+vFlag].Picture.Graphic);
        KoreaButton.Width   := vWidth;
        KoreaButton.Height  := vHeight;
        KoreaButton.Visible := true;
        KoreaButton.Left    := vLeft;
        KoreaButton.Top     := vTop;
        KoreaButton.Tag     := 0;
      end
      else
      begin
        KioskWaitFlagButton.Visible := false;
        KioskLanguagePanel.Visible  := false;
      end;
    end
    else
    begin
      KioskWaitFlagButton.Visible := false;
      KioskLanguagePanel.Visible  := false;
    end;

    //스킨을 지정했어도 이미지 화일이 있으면 적용한다
    if Common.isBFChoose and (Common.Config.BarrierFreeMode = bfWheelChair) then
    begin
      Common.SetPNGImage(KioskCardButton, Common.AppPath+'Kiosk\저자세\카드.png');
      Common.SetPNGImage(KioskCashButton, Common.AppPath+'Kiosk\저자세\현금.png');
      Common.SetPNGImage(KioskPointUseButton, Common.AppPath+'Kiosk\저자세\포인트.png');
      Common.SetPNGImage(KioskPointSearchButton, Common.AppPath+'Kiosk\저자세\포인트조회.png');
      Common.SetPNGImage(KioskOrderButton, Common.AppPath+'Kiosk\저자세\주문.png');
      Common.SetPNGImage(KisokStampButton, Common.AppPath+'Kiosk\저자세\스템프사용.png');
      Common.SetPNGImage(KioskTrustButton, Common.AppPath+'Kiosk\저자세\외상.png');
      Common.SetPNGImage(KioskEasyPayButton, Common.AppPath+'Kiosk\저자세\간편결제.png');
      Common.SetPNGImage(KioskMemberJoinButton, Common.AppPath+'Kiosk\저자세\회원가입.png');
      Common.SetPNGImage(KioskInitButton, Common.AppPath+'Kiosk\저자세\전체취소.png');
      Common.SetPNGImage(KioskCallButton, Common.AppPath+'Kiosk\저자세\직원호출.png');
      Common.SetPNGImage(KioskVoiceListenButton, Common.AppPath+'Kiosk\저자세\음성안내.png');
    end
    else if Common.isBFChoose and (Common.Config.BarrierFreeMode = bfLowVision) then
    begin
      Common.SetPNGImage(KioskCardButton, Common.AppPath+'Kiosk\저시력\카드.png');
      Common.SetPNGImage(KioskCashButton, Common.AppPath+'Kiosk\저시력\현금.png');
      Common.SetPNGImage(KioskPointUseButton, Common.AppPath+'Kiosk\저시력\포인트.png');
      Common.SetPNGImage(KioskPointSearchButton, Common.AppPath+'Kiosk\저시력\포인트조회.png');
      Common.SetPNGImage(KioskOrderButton, Common.AppPath+'Kiosk\저시력\주문.png');
      Common.SetPNGImage(KisokStampButton, Common.AppPath+'Kiosk\저시력\스템프사용.png');
      Common.SetPNGImage(KioskTrustButton, Common.AppPath+'Kiosk\저시력\외상.png');
      Common.SetPNGImage(KioskEasyPayButton, Common.AppPath+'Kiosk\저시력\간편결제.png');
      Common.SetPNGImage(KioskMemberJoinButton, Common.AppPath+'Kiosk\저시력\회원가입.png');
      Common.SetPNGImage(KioskInitButton, Common.AppPath+'Kiosk\저시력\전체취소.png');
      Common.SetPNGImage(KioskCallButton, Common.AppPath+'Kiosk\저시력\직원호출.png');
      Common.SetPNGImage(KioskVoiceListenButton, Common.AppPath+'Kiosk\저시력\음성안내.png');
    end
    else
    begin
      Common.SetPNGImage(KioskCardButton, Common.AppPath+'Kiosk\카드.png');
      Common.SetPNGImage(KioskCashButton, Common.AppPath+'Kiosk\현금.png');
      Common.SetPNGImage(KioskPointUseButton, Common.AppPath+'Kiosk\포인트.png');
      Common.SetPNGImage(KioskPointSearchButton, Common.AppPath+'Kiosk\포인트조회.png');
      Common.SetPNGImage(KioskOrderButton, Common.AppPath+'Kiosk\주문.png');
      Common.SetPNGImage(KisokStampButton, Common.AppPath+'Kiosk\스템프사용.png');
      Common.SetPNGImage(KioskTrustButton, Common.AppPath+'Kiosk\외상.png');
      Common.SetPNGImage(KioskEasyPayButton, Common.AppPath+'Kiosk\간편결제.png');
      Common.SetPNGImage(KioskMemberJoinButton, Common.AppPath+'Kiosk\회원가입.png');
      Common.SetPNGImage(KioskInitButton, Common.AppPath+'Kiosk\전체취소.png');
      Common.SetPNGImage(KioskCallButton, Common.AppPath+'Kiosk\직원호출.png');
    end;

    KioskClassPLUCreate;
    KioskMenuPLUCreate;
    KioskOrderMenuCreate;
    KioskPanel.Visible := true;
  end
  else
  begin
    Common.SetLanguage(Self);
    PrintOptionPanel.Caption      := Common.GetPaPago(PrintOptionPanel.Caption);
    ReceiptPrintButton.Hint       := Common.GetPaPago(ReceiptPrintButton.Hint);
    BillPrintButton.Hint          := Common.GetPaPago(BillPrintButton.Hint);
    KitchenPrintButton.Hint       := Common.GetPaPago(KitchenPrintButton.Hint);
    MenuPrintButton.Hint          := Common.GetPaPago(MenuPrintButton.Hint);
  end;
end;

procedure TOrder_F.FormDestroy(Sender: TObject);
var vIndex : Integer;
begin
  if Assigned(PluClassData) then
  begin
    FreePluClassList(PluClassData);
    FreeAndNil(PluClassData);
  end;

  if Assigned(PluMenuData) then
  begin
    FreePluMenuList(PluMenuData);
    FreeAndNil(PluMenuData);
  end;

  for vIndex := Low(AccountButton) to High(AccountButton) do
    SetLength(AccountButton[vIndex], 0);
  SetLength(AccountButton, 0);

  for vIndex := Low(FunctionButton) to High(FunctionButton) do
    SetLength(FunctionButton[vIndex], 0);
  SetLength(FunctionButton, 0);
  SetLength(PluMenuButton, 0);
  SetLength(PluClassButton, 0);
 // FreeCourseOrderDataList(Common.CourseOrderMenu);
  SetLength(OrderCourseMenu, 0);
  SetLength(KioskButtonList, 0);
  SetLength(KioskOrderMenu, 0);
  SetLength(tmpKioskOrderMenu, 0);
  ShutDownDs;
end;

procedure TOrder_F.FormShow(Sender: TObject);
var
  vIndex, I, vRow, vQty, vCol, vLetsOrderAmt :Integer;
  vTemp, vClassCode :String;
  vMenuData :Array of Array of String;
begin
  Common.WriteLog('work', 'Order_F Show');
   //두번눌리는현상 방지
  Application.ProcessMessages;
  PLUClickTime      := IncSecond(Now,-3);
  FunctionClickTime := IncSecond(Now,-3);
  AcctClickTime     := IncSecond(Now,-3);
  ClickTime         := IncSecond(Now,-3);
  try
    if not Common.IsDebugMode then
      BlockInput(true);

    Main_sGrd.Height  := Main_sGrd.Tag;
    GroupOrderPanel.Visible := false;

    vLetsOrderAmt := 0;
    Common.Device.OnScannerReadData := nil;
    UserWork := Common.Config.UserWork;
    IsAcctChange := False;
    RestoreSale  := '';
    CardLogButton.Visible     := False;
    panPLU.Visible := False;
    OrgCashAmt := 0;
    OrgCardAmt := 0;

    if not Common.Config.IsKiosk and (GetOption(375) = '1') and (Common.PosType <> ptOnlyOrder) then
    begin
      if Common.PosAutoCloseOpen then
        WorkDateLabel.Caption   := FormatMaskText('!0000년 90월 90일;0; ',Common.WorkDate);
    end;

    KioskWorkDateLabel.Caption  := FormatDateTime('mm월dd일(ddd) ampm h:nn', Now());
    PosNoLabel.Caption          := Format('%s - %s',[Common.Config.PosNo, Common.PreSent.RcpNo]);
    WorkDateLabel.Caption       := FormatMaskText('!0000년 90월 90일;0; ',Common.WorkDate);
    lbl_Damdang.Caption         := '['+Common.Table.DamdangName+']';
    Common.ClearGrid(Cancel_SGrd);             //취소그리드초기화
    Cancel_SGrd.Visible := False;

    Common.ClearGrid(GroupTable_sGrd);
    GroupTable_sGrd.Visible := False;

    if Common.Table.DamdangName = EmptyStr then
      lbl_Damdang.Caption := EmptyStr;

    //분류를 사용하지 않을때
    if GetOption(35) = '0' then
     SelectedClass  := '01';

    //KIOSK 일때
    if Common.Config.IsKiosk then
    begin
      KioskClassCode := '01';
      KioskSetClassPLU;
      KioskSetMenuPLU;
      if Common.Config.IsKioskCash then
      begin
        OpenQuery('select KIOSK_1000, '
                 +'       KIOSK_100 '
                 +'  from MS_CODE '
                 +' where CD_STORE = :P0 '
                 +'   and CD_KIND  = ''01'' '
                 +'   and NM_CODE1 = :P1 '
                 +'   and NM_CODE3 = ''2'' ',
                 [Common.Config.StoreCode,
                  Common.Config.PosNo]);

        if not Common.Query.Eof then
        begin
          Common.Config.KioskAlram[0] := Common.Query.FieldByName('KIOSK_1000').AsInteger;
          Common.Config.KioskAlram[1] := Common.Query.FieldByName('KIOSK_100').AsInteger;
        end;
      end
      else
      begin
        Common.Config.KioskAlram[0] := 0;
        Common.Config.KioskAlram[1] := 0;
      end;
      Common.Query.Close;
      Tmr_KioskStart.Enabled := true;
    end
    else if FIsLastTakeOut then
    begin
      FIsLastTakeOut := False;
      SelectedClass  := '';
      SetPluClassData;
      ShowPluClassButton;
      SetPluMenuData('');
    end
    else if isPLUReFlash then
    begin
      vClassCode := Common.Config.PluNo;
      SetPluClassData;
      SetPluMenuData(vClassCode);
      PluMenuPage := 1;
    end
    else
    begin
      vClassCode := Common.Config.PluNo;
      if PluClassPage <> 1 then
      begin
        SetPluClassData;
        PluClassPage := 1;
      end;
      if Assigned(TPosButton(FindComponent('PLUClassPriorButton'))) then
      begin
        TPosButton(FindComponent('PLUClassPriorButton')).Enabled := false;
        TPosButton(FindComponent('PLUClassPriorButton')).Font.Color := Common.Config.PluClassDownFontColor;
        if PluClassPage = PluClassMaxPage then
        begin
          TPosButton(FindComponent('PLUClassNextButton')).Enabled := false;
          TPosButton(FindComponent('PLUClassNextButton')).Font.Color := Common.Config.PluClassDownFontColor;
        end
        else
        begin
          TPosButton(FindComponent('PLUClassNextButton')).Enabled := true;
          TPosButton(FindComponent('PLUClassNextButton')).Font.Color := Common.Config.PluClassFont.Color;
        end;
      end;

      ShowPluClassButton;
      if PluMenuPage <> 1 then
        PluMenuPage := 1;
    end;


    //사용할 봉사료 적용
    FTipType  := Common.Config.TipType;
    FTipApply := Common.Config.TipApply;
    if not Common.Config.IsKiosk and not Common.Config.IsTakeOut and (Common.Table.Number > 0) then
    begin
      //테이블주문이면
      if Common.Table.OrderType = 'T' then
      begin
        //테이블명을 사용하지 않을때
        if GetOption(25) = '0' then
        begin
          //층을 사용할때
          if GetOption(58) = '0' then
            OrderTableLabel.Caption     := Format('%s - %d',[Common.Table.FloorName, Common.Table.Number])
          else
            OrderTableLabel.Caption     := '테이블-'+IntToStr(Common.Table.Number);
        end
        else
        begin
          //층을 사용할때
          if GetOption(58) = '0' then
            OrderTableLabel.Caption     := Format('%s - %s',[Common.Table.FloorName, Common.Table.Name])
          else
            OrderTableLabel.Caption     := '테이블-'+Common.Table.Name;
        end;
      end
      else //배달주문일때
      begin
        OrderTableLabel.Caption     := '배달';
      end;

      //주문버튼이 있으면 Disable 시킨다
      for vRow := Low(FunctionButton) to High(FunctionButton) do
        for vCol := Low(FunctionButton[vRow]) to High(FunctionButton[vRow]) do
      begin
        if FunctionButton[vRow][vCol].Hint = '37' then  //예약
          FunctionButton[vRow][vCol].Enabled := true;
        if FunctionButton[vRow][vCol].Hint = '33' then  //예약
          FunctionButton[vRow][vCol].Enabled := false;
      end;
    end
    else
    begin
      OrderTableLabel.Caption     := 'TAKE OUT';
      Tmr_Time.Enabled        := true;
      //주문버튼이 있으면 Disable 시킨다
      for vRow := Low(FunctionButton) to High(FunctionButton) do
        for vCol := Low(FunctionButton[vRow]) to High(FunctionButton[vRow]) do
      begin
        if FunctionButton[vRow][vCol].Hint = '37' then  //예약
          FunctionButton[vRow][vCol].Enabled := false;
        if FunctionButton[vRow][vCol].Hint = '33' then  //예약
          FunctionButton[vRow][vCol].Enabled := true;
      end;

      if not (Common.OrderKind in [okChange, okSaleChange]) then
        WorkState := wsReady;
    end;

    //추가요금 기능을 사용하면 테이블정보에 입장시간을 표시한다
    if (Common.Config.OverTimeMenu <> '') and (Common.OrderKind in [okNew, okAppend]) then
    begin
      Common.GetAddMenuAmt(Common.Table.Number);
      if Common.Table.LapeTime > 60  then
        vTemp := Format('(%d:%d)',[(Common.Table.LapeTime) div 60, Common.Table.LapeTime  mod 60])
      else
        vTemp := Format('(%d분)',[Common.Table.LapeTime]);

      OrderTableLabel.Caption := Format('[%s]%s',[Replace(OrderTableLabel.Caption,' ',''), Common.Table.Time + vTemp]);
    end;

    if Common.Table.OrderType = 'D' then
      Common.WriteLog('work', Format('배달정보(%s-%s)', [LeftStr(Common.Table.DeliveryNo,8), RightStr(Common.Table.DeliveryNo,4)]))
    else if Common.OrderKind <> okChange then
    begin
      case Common.OrderKind of
        okNone        : vTemp := 'None';
        okNew         : vTemp := 'New';
        okAppend      : vTemp := 'Append';
        okSaleChange  : vTemp := 'SD';
        okDutchPay    : vTemp := 'D-B';
        okDutchPayEnd : vTemp := 'D-E';
        okDutchPayAll : vTemp := 'D-A';
        okBanpum      : vTemp := 'B';
        okCancel      : vTemp := 'Cancel';
        okChange      : vTemp := 'Change';
        else
          vTemp := '';
      end;
      Common.WriteLog('work', Format('테이블정보 - %s(%s)', [OrderTableLabel.Caption, vTemp]));
    end;

    CashRequestLabel.Visible := Common.Table.isCashOrder;
    lblTableInfo.Caption  := OrderTableLabel.Caption;
    Common.TableMode      := tbmNone;
    Common.Table.GroupAmt := 0;
    OrgOrderAmt           := 0;
    SvcWorkingAmt         := 0;
    OrgSpcDcAmt           := 0;
    Common.ClearGrid(Common.Cancel_SGrd);      //주문취소정보그리드초기화
    Common.WhyOrdercancel := EmptyStr;
    Common.ClearKitchenData;                   //주문서출력정보 초기화

    //단축메뉴 셋팅
    if GetOption(254)= '0' then
      TitleLabel.Caption := Common.GetPaPago('주문/정산')
    else
      TitleLabel.Caption := Common.GetPaPago('판매등록');

    //Void처리이면 영수증내역을 불러온다
    if Common.OrderKind = okChange then
    begin
      TitleLabel.Caption := Common.GetPaPago('결제변경');
      WorkState    := wsSale;
      IsAcctChange := True;
      if Common.PreSent.CashAmt < 0 then
        Common.PreSent.CashAmt := 0;
      Common.GridToGrid(Common.Summary_sGrd, Main_sGrd);
      for I := 0 to Common.Summary_sGrd.RowCount-1 do
      begin
        if Common.Summary_sGrd.Cells[GDM_DS_SALE, I] = 'D' then
          Common.Summary_sGrd.Cells[GDM_NM_MENU, I] := StringReplace(Common.Summary_sGrd.Cells[GDM_NM_MENU, I],Common.Config.ServiceTxt,'',[rfReplaceAll]);
      end;

      Common.PreSent.TotalAmt := Common.PreSent.TotalAmt;
      ReceiptPrintMode        := Common.SetPrintMode;
      SplitPrintMode          := GetOption(42) = '0';
      KitchenPrintMode        := GetOption(10) = '1';
      CardPrintMode           := GetOption(45) = '1';
      if GetOption(167) = '1' then
        BillPrintMode    := Common.SetBillPrintMode
      else
        BillPrintMode    := GetOption(11) = '1';

      MenuPrintMode := GetOption(68) = '0';

      DisplayPresent;
      HoldCount;
      IsAcctChange := False;
      //결제취소를 자동으로 실행한다

      vTemp := PreSent_sGrd.Cells[GDP_KIND,  PreSent_sGrd.RowCount-1];
      //결제변경시에는 자동으롤 취소하지 않는다
      if (GetOption(398)='0') and  (vTemp <> '포인트할인') and (vTemp <> '포인트결제') and (vTemp <> '쿠폰할인') then
      begin
        //카드건이 하나일때만 자동취소한다
        if Common.Card_SGrd.RowCount = 1 then
        begin
          Act_Cancel.Execute;                 //결제취소
          if Common.Config.IsKiosk and (Common.PreSent.CardAmt <> 0) then
          begin
            WorkState := wsReady;
            Common.OrderKind := okNew;
            Action20.Execute;                 //영수증관리
            RcpChange_F.ShowMode := fsmNone;
            Exit;
          end;
        end;
      end;
      DisplayPresent;
    end
    //판매전화
    else if Common.OrderKind = okSaleChange then
    begin
      vClassCode := Common.Config.PluNo;
      SetPluClassData;
      SetPluMenuData(vClassCode);
      PluMenuPage := 1;
//
//      SelectedClass := '00';
//      SetPluClassData;
//      SetPluMenuData(SelectedClass);
      WorkState := wsSale;
      IsAcctChange := True;
      Common.GridToGrid(Common.Summary_sGrd, Main_sGrd);
      For I := 0 to Common.Summary_sGrd.RowCount-1 do
      begin
        if Common.Summary_sGrd.Cells[GDM_DS_SALE, I] = 'D' then
          Common.Summary_sGrd.Cells[GDM_NM_MENU, I] := StringReplace(Common.Summary_sGrd.Cells[GDM_NM_MENU, I],Common.Config.ServiceTxt,'',[rfReplaceAll]);
      end;

      Common.SelectMemberInfo(Common.Member.Code,'','');
      Common.PreSent.TotalAmt := Common.PreSent.TotalAmt;
      ReceiptPrintMode := Common.SetPrintMode;
      SplitPrintMode   := GetOption(42) = '0';
      CardPrintMode    := GetOption(45) = '1';
      KitchenPrintMode := GetOption(10) = '1';
      if GetOption(167) = '1' then
        BillPrintMode    := Common.SetBillPrintMode
      else
        BillPrintMode    := GetOption(11) = '1';

      MenuPrintMode := GetOption(68) = '0';

      DisplayPresent;
      HoldCount;
      IsAcctChange := False;
      DisplayPresent;
      Common.OrderKind := okNew;
      Common.GetReceiptNo;
    end
    //주문추가이면
    else if (Common.OrderKind in [okAppend, okDutchPay, okDutchPayEnd, okDutchPayAll]) or (Common.Table.OrderType = 'D') or (Common.Table.GroupType = 'M') then
    begin
      WorkState := wsReady;
      SetOrderMenu(Common.Table.Number,
                   Common.Table.OrderType,
                   True);

      if Common.Table.OrderType = 'D' then
        Common.WriteLog('work', Format('배달금액 %d원', [Common.PreSent.TotalAmt]));
      with Main_sGrd, DM.UniQuery, Common.PreSent, Common do
      begin
        OrgOrderAmt := TotalAmt + CutDC;
        OrgSpcDcAmt := SpcDc;
      end;

      //추가요금 발생시
      if (Common.Config.OverTimeMenu <> '') and (Common.Table.OrderType='T') and not (Common.OrderKind in [okDutchPay, okDutchPayEnd, okDutchPayAll]) then
      begin
        if (GetOption(223) = '0') or (Common.Table.CustomerCount > 0) then
        begin
          RestorePrice := Common.GetAddMenuAmt(Common.Table.Number);
          if RestorePrice > 0 then
          begin
            FMenuCode    := Common.Config.OverTimeMenu;
            //고객수 별로 추가요금을 적용시
            if GetOption(223) = '1' then
              RestoreQty := Ifthen(Common.Table.CustomerCount=0,1,Common.Table.CustomerCount)
            else
              RestoreQty := 1;
            bRestore := true;
            SelectMenu(0);
            bRestore := false;
            Common.PreSent.AddMenuAmt := RestorePrice * RestoreQty;
          end;
          FMenuCode    := '';
          RestorePrice := 0;
          RestoreQty   := 0;
        end;
      end;

      Common.ClearGrid(GroupTable_sGrd);
      if (Common.Table.GroupType = 'M') and not (Common.OrderKind in [okDutchPay, okDutchPayEnd, okDutchPayAll])  then
      begin
        OpenQuery('select GetTableGroup(a.CD_STORE, a.NO_TABLE), '
                 +'       a.AMT_ORDER, '
                 +'       a.NO_TABLE, '
                 +'       a.CNT_PERSON, '
                 +'       b.NM_TABLE, '
                 +'       a.AMT_DC + a.DC_MENU + a.AMT_CODEDC as AMT_DC '
                 +'  from SL_ORDER_H a  inner join '
                 +'       MS_TABLE   b  on a.CD_STORE = b.CD_STORE and a.NO_TABLE = b.NO_TABLE '
                 +' where a.CD_STORE		    =:P0 '
                 +'   and b.NO_TABLE_GROUP 	=:P1 '
                 +'   and a.DS_ORDER        =:P2 '
                 +'   and b.NO_TABLE 	<> b.NO_TABLE_GROUP  '
                 +'   and b.NO_TABLE not in (select NO_TABLE '
                 +'                            from SL_SALE_H  '
                 +'                           where CD_STORE = b.CD_STORE '
                 +'                             and DS_SALE = ''M'') '
                 +' order by a.NO_TABLE ',
                 [Common.Config.StoreCode,
                  Common.Table.Number,
                  Common.Table.OrderType]);
        Common.Group_sGrd.HelpKeyword := '';
        while not Common.Query.Eof do
        begin
          Common.Group_sGrd.Tag  := Common.Query.Fields[2].AsInteger;
          Common.Group_sGrd.Hint := Common.Query.Fields[4].AsString;
          if Common.Query.Fields[5].AsInteger > 0 then
            Common.Group_sGrd.HelpKeyword := Common.Query.Fields[5].AsString;
          SetOrderMenu(Common.Query.Fields[2].AsInteger, 'T', false);
          //추가요금
          if (GetOption(223) = '0') or (Common.Query.Fields[3].AsInteger > 0) then
          begin
            RestorePrice := Common.GetAddMenuAmt(Common.Query.Fields[2].AsInteger);
            if RestorePrice > 0 then
            begin
              FMenuCode    := Common.Config.OverTimeMenu;
              //고객수 별로 추가요금을 적용시
              if GetOption(223) = '1' then
                RestoreQty := Ifthen(Common.Query.Fields[3].AsInteger=0,1,Common.Query.Fields[3].AsInteger)
              else
                RestoreQty := 1;
              bRestore      := true;
              bGroupAddTime := true;
              DM.OpenQuery('select * '
                          +'  from MS_MENU  '
                          +' where CD_STORE =:P0 '
                          +'   and CD_MENU  =:P1 ',
                         [Common.Config.StoreCode,
                          Common.Config.OverTimeMenu]);
              if not DM.Query.Eof then
              begin
                Common.Menu.cd_menu         := Common.Config.OverTimeMenu;
                Common.Menu.nm_menu         := DM.Query.FieldByName('NM_MENU_SHORT').AsString;
                Common.Menu.ds_menu         := DM.Query.FieldByName('DS_MENU_TYPE').AsString;
                Common.Menu.no_step         := 0;
                Common.Menu.cd_menu1        := '';
                Common.Menu.seq             := 1;
                Common.Menu.pr_sale         := RestorePrice;    //상품단가
                Common.Menu.qty_sale        := RestoreQty;
                Common.Menu.ds_tax          := DM.Query.FieldByName('DS_TAX').AsString;
                Common.Menu.yn_point        := Copy(DM.Query.FieldByName('CONFIG').AsString,2,1);
                Common.Menu.yn_point_limit  := Copy(DM.Query.FieldByName('CONFIG').AsString,9,1);
                MainGrid_add(Common.Group_sGrd);
                DM.Query.Close;
                bRestore      := false;
                bGroupAddTime := false;
              end;
            end;
            FMenuCode    := '';
            RestorePrice := 0;
            RestoreQty   := 0;
          end;

          //고객수 추정메뉴를 사용하면
          if GetOption(223) = '1' then
            vQty := Common.Query.Fields[3].AsInteger
          else
            vQty := 1;

          if vQty > 999 then
            vQty := 999;

          //가끔 알수없는 메모리풀 에러 발생
          if GroupTable_sGrd.RowCount > 100 then
            Common.ClearGrid(GroupTable_sGrd);

          if GroupTable_sGrd.Cells[0,0] <> '' then
            GroupTable_sGrd.RowCount := GroupTable_sGrd.RowCount + 1;
          GroupTable_sGrd.Cells[0, GroupTable_sGrd.RowCount-1] := ' '+Common.Query.Fields[0].AsString;
          GroupTable_sGrd.Cells[1, GroupTable_sGrd.RowCount-1] := FormatFloat('#,0 원 ',Common.Query.Fields[1].AsInteger + Common.GetAddMenuAmt(Common.Query.Fields[2].AsInteger)*vQty);
          GroupTable_sGrd.Cells[2, GroupTable_sGrd.RowCount-1] := Common.Query.Fields[2].AsString;

          Common.Query.Next;
        end;
        Common.Query.Close;
        if GroupTable_sGrd.RowCount > 0 then
        begin
          GroupTable_sGrd.Visible := True;
          Main_sGrd.Height := Main_sGrd.Height - GroupTable_sGrd.Height -1;
        end;
      end;

      Common.SelectMemberInfo(Common.Table.MemberCode,'','');

      Common.PreSent.CodeDcCode := Common.Table.DcCode;
      Common.PreSent.RcpDc_Rate := Common.Table.Dc_Rate;
      Common.PreSent.RcpDc      := Common.Table.Dc_Amt;
      Common.PreSent.MenuDc     := Common.Table.Dc_Menu;

      SetCodeDc;
      Common.PreSent.CodeDcAmt := Common.Table.Dc_CodeAmt;

      //레츠오더 사용시 결제내역있는지 체크
      if (GetHeadOption(9) = '1') and ((Common.Table.GroupType = 'M') or (Common.Table.GroupType = 'N')) then
      begin
        if (Common.Table.GroupType = 'M') then
          OpenQuery('select * '
                   +'  from SL_CARD_AHEAD  '
                   +' where CD_STORE =:P0 '
                   +'   and (DS_CARD  =''P'' or YN_LETSORDER = ''Y'') '
                   +'   and (NO_TABLE in (select NO_TABLE '
                   +'                      from MS_TABLE '
                   +'                     where CD_STORE = :P0 '
                   +'                       and NO_TABLE_GROUP =:P1) '
                   +'        or NO_TABLE =:P1) '
                   +'   and DS_TRD = ''A'' ',
                   [Common.Config.StoreCode,
                    Common.Table.Number])
        else
          OpenQuery('select * '
                   +'  from SL_CARD_AHEAD '
                   +' where CD_STORE =:P0 '
                   +'   and NO_TABLE =:P1 '
                   +'   and (DS_CARD  =''P'' or YN_LETSORDER = ''Y'') '
                   +'   and DS_TRD   =''A'' ',
                   [Common.Config.StoreCode,
                    Common.Table.Number]);

        if not Common.Query.Eof then
        begin
          while not Common.Query.Eof do
          begin
            InitCardRecord(Common.Card);
            Common.Card.Ds_Card     := Common.Query.FieldByName('DS_CARD').AsString;
            Common.Card.Ds_trd      := dtApproval;
            Common.Card.Type_Trd    := Common.Query.FieldByName('TYPE_TRD').AsString;
            Common.Card.CardNo      := Common.Query.FieldByName('NO_CARD').AsString;
            Common.Card.Nm_Card     := Common.Query.FieldByName('NM_CARDPL').AsString;
            Common.Card.nm_buy      := Common.Query.FieldByName('NM_CARD_BUY').AsString;
            Common.Card.Amt         := Common.Query.FieldByName('AMT_APPROVAL').AsInteger;
            Common.Card.VatAmt      := Common.Query.FieldByName('AMT_VAT').AsInteger;
            Common.Card.ApprovalNo  := Common.Query.FieldByName('NO_APPROVAL').AsString;
            Common.Card.Halbu       := Common.Query.FieldByName('TERM_HALBU').AsString;
            Common.Card.Trd_Date    := Common.Query.FieldByName('TRD_DATE').AsString;
            Common.Card.Trd_Time    := Common.Query.FieldByName('TRD_TIME').AsString;
            Common.Card.PG_TID      := Common.Query.FieldByName('PG_TID').AsString;
            Common.Card.CancelAmt   := Common.Query.FieldByName('AMT_CANCEL').AsInteger;
            Common.Card.OrgTableNo  := Common.Query.FieldByName('NO_TABLE_ORG').AsInteger;
            Common.Card.PayCode     := Common.Query.FieldByName('PAY_CODE').AsString;
            Common.Card.ChainPL     := Common.Query.FieldByName('NO_CHAINPL').AsString;
            Common.CardInfoSave(2);
            if Common.Query.FieldByName('DS_CARD').AsString = 'P' then
              Common.PreSent.LetsOrderAmt := Common.PreSent.LetsOrderAmt + Common.Card.Amt - Common.Card.CancelAmt
            else
              Common.PreSent.CardAmt := Common.PreSent.CardAmt + Common.Card.Amt - Common.Card.CancelAmt;

            vLetsOrderAmt := vLetsOrderAmt + Common.Card.Amt - Common.Card.CancelAmt;
            Common.Query.Next;
          end;
          Common.PreSent.AHeadPayAmt := vLetsOrderAmt;
          SmartPadLastTimer := Now();
          DisplayPresent;
        end;
        Common.Query.Close;
      end;

      //선결제 내역을 불러온다
      if ((Common.Table.GroupType = 'M') or (Common.Table.GroupType = 'N')) then
      begin
        Common.SetCardSale('',2);
        Common.SetCashSale('',1);
        OpenQuery('select AMT_CASH '
                 +'  from SL_ORDER_H '
                 +' where CD_STORE   =:P0 '
                 +'   and NO_TABLE   =:P1 '
                 +'   and DS_ORDER   =''T'' ',
                 [Common.Config.StoreCode,
                  Common.Table.Number]);
        Common.PreSent.AHeadCashAmt := Common.Query.Fields[0].AsInteger;
        Common.PreSent.CashAmt      := Common.PreSent.CashAmt     + Common.Query.Fields[0].AsInteger;
        Common.PreSent.AHeadPayAmt  := Common.PreSent.AHeadPayAmt + Common.Query.Fields[0].AsInteger;
        Common.Query.Close;
      end;
      SmartPadLastTimer := IncSecond(Now(), -5);
      DisplayPresent;

      if Common.Table.WaitTableNo <> 0 then
        Common.OrderKind := okNew;
      WorkState := wsSale;
      if (GetOption(148) = '1') and (vLetsOrderAmt > 0) and (Common.PreSent.WRcvAmt=0) and (Common.PreSent.TotalAmt > 0) then
      begin
        if Common.AskBox('레츠오더에서 결제가 완료되었습니다'#13'계산완료 하시겠습니까?') then
          Tmr_Start.Tag := 100
      end
      else if (vLetsOrderAmt > 0) then
        Common.MsgBox('렛츠오더에서 결제한 내역이 있습니다'#13+FormatFloat('[ ,0원 ]',vLetsOrderAmt));
    end
    else if Common.OrderKind = okBanpum then
    begin
      WorkState := wsReady;
      TitleLabel.Caption := '반품';
      Common.OrderKind  := okNew;
      For I := 0 to RcpChange_F.gvBanpum.DataController.RowCount-1 do
      begin
        FMenuCode    := RcpChange_F.gvBanpum.DataController.Values[I, 5];
        RestorePrice := RcpChange_F.gvBanpum.DataController.Values[I, 2];
        RestoreQty   := RcpChange_F.gvBanpum.DataController.Values[I, 1]*-1;
        SelectMenu(2);
      end;
      Common.OrderKind := okBanpum;
      WorkState := wsSale;
      RestorePrice := 0;
      RestoreQty   := 0;
      FMenuCode    := '';
      Common.Member.Code := NVL(RcpChange_F.GridTableView.DataController.Values[RcpChange_F.GridTableView.DataController.GetFocusedRecordIndex, RcpChange_F.GridTableViewMemberCode.Index],'');
      Common.SelectMemberInfo(Common.Member.Code,'','');
      DisplayPresent;
    end
    else
    begin
      WorkState := wsReady;
      //그룹마스터에 주문내역이 없으면 그룹마스터 적용안함
      if Common.Table.GroupType = 'M' then
        Common.Table.GroupType := 'N';
      //예약테이블일때 첫번째 주문일때
      if Common.Table.BookingNo <> '' then
      begin
        //예약회원
        OpenQuery('select CD_MEMBER '
                 +'  from SL_BOOKING '
                 +' where CD_STORE   =:P0 '
                 +'   and NO_BOOKING =:P1 ',
                 [Common.Config.StoreCode,
                  Common.Table.BookingNo]);
        if not Common.Query.Eof and (Common.Query.Fields[0].AsString <> '') then
        begin
          vTemp := Common.Query.Fields[0].AsString;
          Common.Query.Close;
          Common.SelectMemberInfo(vTemp, '','');
        end;

        //예약선급금
        if (Common.Table.BookingAmt > 0) and (Common.Config.BookingMenu <> '') then
        begin
          FMenuCode    := Common.Config.BookingMenu;
          RestorePrice := Common.Table.BookingAmt * -1;
          SelectMenu(2);
          FMenuCode    := '';
          RestorePrice := 0;
        end;

        //예약메뉴
        DM.Query.Options.QueryRecCount := true;
        DM.OpenQuery('select CD_MENU, '
                    +'       QTY_MENU '
                    +'  from SL_BOOKING_MENU '
                    +' where CD_STORE   =:P0 '
                    +'   and NO_BOOKING =:P1 '
                    +' order by SEQ ',
                    [Common.Config.StoreCode,
                     Common.Table.BookingNo]);
        if DM.Query.RecordCount > 0 then
        begin
          SetLength(vMenuData, DM.Query.RecordCount, 2);
          vIndex := 0;
          while not DM.Query.Eof do
          begin
            vMenuData[vIndex, 0] := DM.Query.FieldByName('CD_MENU').AsString;
            vMenuData[vIndex, 1] := DM.Query.FieldByName('QTY_MENU').AsString;
            Inc(vIndex);
            DM.Query.Next;
          end;
          DM.Query.Close;

          for vIndex := 0 to High(vMenuData) do
          begin
            FMenuCode    := vMenuData[vIndex, 0];
            RestoreQty   := StrToInt(vMenuData[vIndex, 1]);
            SelectMenu(2);
          end;
          RestoreQty   := 0;
          FMenuCode    := '';
        end;
        DM.Query.Options.QueryRecCount := false;

      end;
      //테이블기본메뉴
      if (Common.Table.OrderType = 'T') and (Common.Config.default_menu <> '') and not Common.Config.IsTakeOut then
      begin
        FMenuCode  := Common.Config.default_menu;
        RestoreQty := Common.Table.CustomerCount;
        SelectMenu(2);
        FMenuCode    := '';
        RestoreQty := 0;
      end;
    end;

    FMsrData   := EmptyStr;

    if Common.Table.OrderType = 'T' then
      Common.Device.OnCidReadData := CidReadEvent;

    Common.Device.OnScannerReadData := ScannerReadEvent;

    FInScaleData := True;

    if (Common.OrderKind = okAppend) and
       (not Common.Config.IsTakeOut) and
       (Common.PosType = ptAccount) and
       (Common.Table.OrderType='T') and
       (Common.PreSent.WRcvAmt + Ifthen(GetOption(160)='0',Common.PreSent.TipAmt,0) <> Common.Table.OrderAmt) and
       (Common.Table.GroupType <> 'M') and
       (Common.PreSent.CutDc = 0) and
       (Common.PreSent.LetsOrderAmt = 0) then
    begin
      Common.MsgBox('받을금액을 확인하세요'+#13#13+FormatFloat(',0', Common.PreSent.WRcvAmt)+' 원' );
    end;

    if (Common.OrderKind = okAppend) then
      Common.WriteLog('work', Format('주문금액- %s', [FormatFloat(',0', Common.PreSent.TotalAmt)]));

    //담당자별 사용권한 설정
    if Common.Table.DamdangCode <> EmptyStr then
    begin
      OpenQuery('select EMP_WORK '
               +'  from MS_SAWON '
               +' where CD_STORE =:P0 '
               +'   and CD_SAWON =:P1 ',
               [Common.Config.StoreCode,
                Common.Table.DamdangCode]);
      if not Common.Query.Eof then
        Common.Config.UserWork := Common.Query.Fields[0].AsString;
      Common.Query.Close;
    end;
    OrderMenuLabel.Visible := false;
    Common.PreSent.OrgRcvAmt := Common.PreSent.RcvAmt;

    if not Common.Config.IsKiosk then
    begin
      for vRow := Low(FunctionButton) to High(FunctionButton) do
        for vCol := Low(FunctionButton[vRow]) to High(FunctionButton[vRow]) do
      begin
        if FunctionButton[vRow][vCol].Hint = '37' then //주문
          FunctionButton[vRow][vCol].Enabled := not Common.Config.IsTakeOut and not (Common.OrderKind = okChange)
        else if FunctionButton[vRow][vCol].Hint = '33' then //예약
          FunctionButton[vRow][vCol].Enabled := Common.Config.IsTakeOut and not (Common.OrderKind = okChange)
        else if FunctionButton[vRow][vCol].Hint = '19' then //영수증관리
          FunctionButton[vRow][vCol].Enabled := Common.Config.IsTakeOut and not (Common.OrderKind = okChange);
      end;
    end;

    //테이블제에서 테이블 자동닫힘기능 사용시
    if not Common.Config.IsTakeOut and (GetOption(432) <> '0') then
      Tmr_KioskWait.Enabled := true;
  finally
    BlockInput(false);
    Common.Device.OnScannerReadData := ScannerReadEvent;
    Application.ProcessMessages;
    Tmr_Start.Enabled := True;
  end;
end;

procedure TOrder_F.FunctionButtonClick(Sender: TObject);
var vIndex, vTime :Integer;
    vPoint, vNowPoint :TPoint;
    vCode :String;
begin
  if Common.Config.IsKiosk then Exit;
  if ((Sender as TAdvSmoothButton).Hint <> '00') and ((Sender as TAdvSmoothButton).Hint <> '01') then
  begin
    if MilliSecondsBetween(Now(),FunctionClickTime) < 500 then Exit;
    FunctionClickTime := Now();
    (Sender as TAdvSmoothButton).Enabled := false;
  end;

  try
    (Sender as TAdvSmoothButton).Enabled := false;
    if WorkState = wsMagam then WorkState := wsReady;
    vCode := (Sender as TAdvSmoothButton).Hint;
    //주문버튼 두번클릭 방지(최소 3초)
    if (LastFunctionAction = '37') and (vCode = '37') and (MilliSecondsBetween(Now(),LastFunctionTime) < 3000) then
      Exit;

    for vIndex := 0 to FunctionActionList.ActionCount -1 do
    begin
       if TAction(FunctionActionList[vIndex]).Hint = vCode then
       begin
         LastFunctionAction := vCode;
         LastFunctionTime   := Now();

         if not Common.Config.IsTakeOut and Tmr_KioskWait.Enabled then
           Tmr_KioskWait.Enabled := false;

         Common.WriteLog('work', Format('FunctionButtonClick [%s][%s]', [(Sender as TAdvSmoothButton).Hint, TAction(FunctionActionList[vIndex]).Caption]));
         FunctionActionList[vIndex].Execute;
         Break;
       end;
    end;
  finally
    if not Self.ModalResult in [mrOK, mrCancel] then
    begin
      if Self.Showing and Self.Enabled and not Present_sGrd.Focused then
        Present_sGrd.SetFocus;
    end;
    (Sender as TAdvSmoothButton).Enabled := true;
  end;
end;


procedure TOrder_F.FunctionButtonCreate;
var vIndex, vIndex2, vRow, vCol, vX, vY, vMax, vLeft, vTop :Integer;
    vFont  :TFont;
    vColor, vBorderColor : TColor;
    vWidth, vHeight, vRound :Integer;
    vIcon :Integer;
    vShadow :Boolean;
begin
  vFont := TFont.Create;
  //기능버튼 설정정보를 읽어온다
  try
    OpenQuery('select NM_CODE1, '
             +'       NM_CODE2, '
             +'       NM_CODE3, '
             +'       NM_CODE4, '
             +'       NM_CODE5, '
             +'       NM_CODE6, '
             +'       NM_CODE7, '
             +'       NM_CODE8, '
             +'       NM_COdE9, '
             +'       NM_COdE10, '
             +'       NM_COdE11 '
             +'  from MS_CODE  '
             +' where CD_STORE = :P0 '
             +'   and CD_KIND  = :P1 '
             +'   and CD_CODE  = ''200'' '
             +' order by CD_CODE ',
             [Common.Config.StoreCode,
              Common.Config.DesignCode]);
    if not Common.Query.Eof then
    begin
      vX          := StrToIntDef(Common.Query.FieldByName('NM_CODE1').AsString,5);
      vY          := StrToIntDef(Common.Query.FieldByName('NM_CODE2').AsString,2);
      vColor      := StringToColor(Common.Query.FieldByName('NM_CODE3').AsString);
      vFont.Name  := Common.Query.FieldByName('NM_CODE4').AsString;
      vFont.Size  := StrToIntDef(Common.Query.FieldByName('NM_CODE5').AsString,10);
      if Common.Query.FieldByName('NM_CODE6').AsString = '1' then
        vFont.Style := [fsBold];
      vFont.Color := StringToColor(Common.Query.FieldByName('NM_CODE7').AsString);
      vIcon := Common.Query.FieldByName('NM_CODE8').AsInteger;
      vBorderColor := StringToColorDef(Common.Query.FieldByName('NM_CODE9').AsString, clBlack);
      vRound       := StrToIntDef(Common.Query.FieldByName('NM_CODE10').AsString, 0);
      vShadow      := Common.Query.FieldByName('NM_CODE11').AsString = 'Y';
    end;
  finally
    Common.Query.Close;
  end;

  vMax := 0;
  //결제버튼을 생성한다
  if (vX > 0) and (vY > 0) then
  begin
    vWidth  := FunctionButtonPanel.Width  div vX + Ifthen(vShadow,1,0);
    vHeight := FunctionButtonPanel.Height div vY + Ifthen(vShadow,1,0);
    // 버튼을 새로 만든다
    FunctionButtonPanel.Visible := false;
    SetLength(FunctionButton, vY);
    vTop := FunctionButtonPanel.Top;
    for vIndex := Low(FunctionButton) to High(FunctionButton) do
    begin
      SetLength(FunctionButton[vIndex], vX);
      vLeft := FunctionButtonPanel.Left;
      for vIndex2 := Low(FunctionButton[vIndex]) to High(FunctionButton[vIndex]) do
      begin
        FunctionButton[vIndex][vIndex2] := TAdvSmoothButton.Create(Self);
        FunctionButton[vIndex][vIndex2].Name        := 'FunctionButton'+FormatFloat('00', vIndex)+FormatFloat('00', vIndex2);
        FunctionButton[vIndex][vIndex2].DoubleBuffered := true;
        FunctionButton[vIndex][vIndex2].Parent      := Self;
        FunctionButton[vIndex][vIndex2].Color       := vColor;
        FunctionButton[vIndex][vIndex2].BevelColor  := vBorderColor;
        FunctionButton[vIndex][vIndex2].Appearance.SimpleLayout := true;
        FunctionButton[vIndex][vIndex2].Appearance.SimpleLayoutBorder := true;
        FunctionButton[vIndex][vIndex2].Appearance.Font := vFont;
        FunctionButton[vIndex][vIndex2].Appearance.Rounding := vRound;
        FunctionButton[vIndex][vIndex2].Appearance.PictureAlignment := taCenter;
        FunctionButton[vIndex][vIndex2].Caption     := EmptyStr;
        FunctionButton[vIndex][vIndex2].Cursor      := crHandPoint;
        FunctionButton[vIndex][vIndex2].Width       := vWidth;
        FunctionButton[vIndex][vIndex2].Height      := vHeight;
        FunctionButton[vIndex][vIndex2].Left        := vLeft;
        vLeft := vLeft + vWidth + Ifthen(vShadow,0,1);
        FunctionButton[vIndex][vIndex2].Top         := vTop;
        FunctionButton[vIndex][vIndex2].OnClick     := FunctionButtonClick;
        FunctionButton[vIndex][vIndex2].OnDblClick  := FunctionButtonClick;
        FunctionButton[vIndex][vIndex2].TabStop     := false;
        FunctionButton[vIndex][vIndex2].Hint        := 'XX';
        FunctionButton[vIndex][vIndex2].Shadow      := vShadow;
        FunctionButton[vIndex][vIndex2].Status.Appearance.Font.Color         := clWhite;
        FunctionButton[vIndex][vIndex2].Status.Appearance.Fill.Color         := clRed;
        FunctionButton[vIndex][vIndex2].Status.Appearance.Fill.ColorTo       := clRed;
        FunctionButton[vIndex][vIndex2].Status.Appearance.Fill.ColorMirror   := clRed;
        FunctionButton[vIndex][vIndex2].Status.Appearance.Fill.ColorMirrorTo := clRed;
        FunctionButton[vIndex][vIndex2].Status.Appearance.Glow               := false;
        if vIcon = 1 then
          FunctionButton[vIndex][vIndex2].Appearance.LayOut := blPictureLeft
        else
          FunctionButton[vIndex][vIndex2].Appearance.LayOut := blPictureTop;

        if vMax < (FunctionButton[vIndex][vIndex2].Left+vWidth) then
          vMax := FunctionButton[vIndex][vIndex2].Left+vWidth;
      end;
      vTop := vTop + vHeight + Ifthen(vShadow,0,1);
    end;

    FunctionButtonPanel.Width := vMax + 1;

    if Assigned(FunctionButton) and (Length(FunctionButton) > 0) then
    begin
      OpenQuery('select NM_CODE1, '
               +'       NM_CODE3, '
               +'       NM_CODE4, '
               +'       NM_CODE7, '
               +'       NM_CODE8, '
               +'       NM_CODE5, '   //Color
               +'       NM_CODE6, '    //
               +'       NM_CODE9 '
               +'  from MS_CODE  '
               +' where CD_STORE = :P0 '
               +'   and CD_KIND  = :P1 '
               +'   and CD_CODE  between ''201'' and ''299'' '
               +' order by CD_CODE ',
               [Common.Config.StoreCode,
                Common.Config.DesignCode]);
      LetsOrderButtonRow := -1;
      while not Common.Query.Eof do
      begin
        if Assigned(FunctionButton) and (Length(FunctionButton) > 0) then
        begin
          vRow := StoI(Common.Query.FieldByName('NM_CODE7').AsString);
          vCol := StoI(Common.Query.FieldByName('NM_CODE8').AsString);

          if (vY > vRow) and (vX > vCol) and  Assigned(FunctionButton[vRow, vCol]) then
          begin
            FunctionButton[vRow, vCol].Hint       := Common.Query.FieldByName('NM_CODE1').AsString;   //기능코드
            FunctionButton[vRow, vCol].Caption    := LineFeed(Common.Query.FieldByName('NM_CODE3').AsString,1);
            FunctionButton[vRow, vCol].Caption    := Common.GetPaPago(FunctionButton[vRow, vCol].Caption);

            FunctionButton[vRow, vCol].Color  := StringToColor(Common.Query.FieldByName('NM_CODE4').AsString);
            if Common.Query.FieldByName('NM_CODE5').AsString <> '' then
              FunctionButton[vRow, vCol].Appearance.Font.Color := StringToColor(Common.Query.FieldByName('NM_CODE5').AsString);
            if Common.Query.FieldByName('NM_CODE6').AsString = '1' then
              FunctionButton[vRow, vCol].Appearance.Font.Style := [fsBold];
            if vIcon > 0 then
              FunctionButton[vRow, vCol].Picture.Assign(FunctionImageCollection.Items[StoI(Common.Query.FieldByName('NM_CODE1').AsString)].Picture)//  := TAdvGlassButton(FindComponent(Format('Function%sButton',[Common.Query.FieldByName('NM_CODE1').AsString]))).Picture
            else
              FunctionButton[vRow, vCol].Picture := nil;

            //전화번호입력 버튼
            if FunctionButton[vRow, vCol].Hint = '47' then
            begin
              isCheckMobileNo := true;
              FunctionButton[vRow, vCol].Status.Visible := true;
              FunctionButton[vRow, vCol].Status.Caption := 'X';
              MobileFunctionButtonX := vRow;
              MobileFunctionButtonY := vCol;
            end;

            if StoI(Common.Query.FieldByName('NM_CODE9').AsString) >= 5 then
              FunctionButton[vRow, vCol].Appearance.Font.Size := Common.Query.FieldByName('NM_CODE9').AsInteger;
            if (FunctionButton[vRow, vCol].Hint = '40') and (LetsOrderButtonRow < 0) then
            begin
              LetsOrderButtonRow := vRow;
              LetsOrderButtonCol := vCol;
            end;
          end;
        end;
        Common.Query.Next;
      end;
      Common.Query.Close;
    end;
  end;

  //버튼 합치기(가로)
  for vRow := Low(FunctionButton) to High(FunctionButton) do
    for vCol := Low(FunctionButton[vRow]) to High(FunctionButton[vRow])-1 do
  begin
    if (FunctionButton[vRow][vCol].Hint = 'XX') or (FunctionButton[vRow][vCol].Tag = 1) then Continue;

    //다음버튼과 기능이 같을때
    if (FunctionButton[vRow][vCol].Hint = FunctionButton[vRow][vCol+1].Hint) then
    begin
      FunctionButton[vRow][vCol].Width  := FunctionButton[vRow][vCol].Width * 2 + Ifthen(vShadow,0,1);;
      FunctionButton[vRow][vCol+1].Tag    :=1;
      if vRow < High(FunctionButton) then
      begin
        if (FunctionButton[vRow][vCol].Hint = FunctionButton[vRow+1][vCol].Hint) and (FunctionButton[vRow+1][vCol].Hint = FunctionButton[vRow+1][vCol+1].Hint) then
        begin
          FunctionButton[vRow][vCol].Appearance.LayOut := blPictureTop;
          FunctionButton[vRow][vCol].Height  := FunctionButton[vRow][vCol].Height * 2 + Ifthen(vShadow,0,1); ;
          FunctionButton[vRow][vCol].Tag     := 1;
          FunctionButton[vRow+1][vCol].Tag   := 1;
          FunctionButton[vRow+1][vCol+1].Tag := 1;
        end
      end;
      FunctionButton[vRow][vCol].BringToFront;
      Continue;
    end;
  end;


  //버튼 합치기(세로)
  for vRow := Low(FunctionButton) to High(FunctionButton)-1 do
    for vCol := Low(FunctionButton[vRow]) to High(FunctionButton[vRow]) do
  begin
    if (FunctionButton[vRow][vCol].Hint = 'XX') or (FunctionButton[vRow][vCol].Tag = 1) then Continue;

    //다음버튼과 기능이 같을때
    if Assigned(FunctionButton[vRow+1, vCol]) and (FunctionButton[vRow][vCol].Hint = FunctionButton[vRow+1][vCol].Hint) then
    begin
      FunctionButton[vRow][vCol].Appearance.LayOut := blPictureTop;
      FunctionButton[vRow][vCol].Height  := FunctionButton[vRow][vCol].Height * 2 + Ifthen(vShadow,0,1); ;
      FunctionButton[vRow+1][vCol].Tag   :=1;
      FunctionButton[vRow][vCol].BringToFront;
      Continue;
    end;
  end;

  if Assigned(vFont) then vFont.Free;
end;

//**************************************************************************//
//                       폼 키다운 이벤트
//**************************************************************************//
procedure TOrder_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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
var lwKey :Word;
    vNumData :String;
begin
  if not Common.Config.IsKiosk then
  begin
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
      Exit;
    end;
  end;


   //정산 완료상태였을때 키값을 잠시 보관했다가 되돌림
   lwKey := Key;
   //마감 상태였으면 초기화한다
   if WorkState = wsMagam then WorkState := wsReady;
   Key := lwKey;

   //신용카드나 회원카드 MSR로 읽었을때
   case Key of
     8 :
     begin
       FMsrData := LeftStr(FMsrData, Length(FMsrData)-1);
       DisplayMessage(3, FMsrData);
       if KeyPadPanel.Visible then
       begin
         if (FMsrData <> '') then
         begin
           InputEdit.Visible := true;
           InputEdit.Text    := FMsrData;
           CashRequestLabel.Visible := false;
         end
         else
         begin
           CashRequestLabel.Visible := Common.Table.isCashOrder;
           InputEdit.Visible := false;
           InputEdit.Text    := '';
         end;
       end;
     end;
     13      :
     begin
       try
         //엔터시에 PLU버튼이 자동으로 눌려서(원인은 알수없음)
         IsEnter := True;
         if not Common.Config.IsKiosk then
         begin
           vNumData := GetCardNo(FMsrData);
           //회원프리픽스하고 같으면
           if Common.isMemberCardNo(vNumData) then
           begin
             Common.SelectMemberInfo('',vNumData,'');
             if Common.Member.Code = EmptyStr then
             begin
               Common.MsgBox(vNumData +#13#13+'등록되지 않은 회원카드입니다');
             end
             else
             begin
               if WorkState = wsReady then WorkState := wsSale;
               //테이블 담당자가 지정되어 있지 않을때는 회원의 담당자로 지정한다
               if (Common.Table.DamdangCode = EmptyStr) and (Common.Member.DamdangCode <> EmptyStr) then
               begin
                 Common.Table.DamdangCode := Common.Member.DamdangCode;
                 Common.Table.DamdangName := Common.Member.DamdangName;
                 lbl_Damdang.Caption      := '['+Common.Table.DamdangName+']';
               end;

               //회원기본메뉴
               if (Common.Config.MemberDefaultMenu <> '') and not GetMenuOrderCheck(Common.Config.MemberDefaultMenu) then
               begin
                 FMenuCode := Common.Config.MemberDefaultMenu;
                 SelectMenu(0);
               end;
               WorkState := wsSale;
               DisplayPresent;
               //회원조회 후 자동 외상결제
               if (GetOption(317) = '1') and (Common.Member.Yn_trust = 'Y') then
               begin
                 Act_Trust.Execute;
                 if not Common.Config.IsTakeOut and not Common.Config.IsKiosk then
                 begin
                   if Common.PreSent.WRcvAmt = 0 then
                   begin
                     Tmr_Acct.Tag     := 1;
                     Tmr_Acct.Enabled := true;
                   end;
                 end
               end;
             end;
           end
           //쿠폰
           else if ((Common.Config.CouponPrefix <> '') and (Common.Config.CouponLen > 0) and  (LeftStr(FMsrData, Length(Common.Config.CouponPrefix)) = Common.Config.CouponPrefix) and (Common.Config.CouponLen = Length(FMsrData)) )
                or ((Common.Config.HeadCouponPrefix <> '') and (Common.Config.HeadCouponLen>0) and (LeftStr(FMsrData, Length(Common.Config.HeadCouponPrefix)) = Common.Config.HeadCouponPrefix) and (Common.Config.HeadCouponLen = Length(FMsrData)) ) then
           begin
             FMenuCode := FMsrData;
             Action30.Execute;
           end
           //저울메뉴이면
           else if (Length(FMsrData) = 13) or (Length(FMsrData) = 16) or (Length(FMsrData) = 18) then
           begin
             FMenuCode := FMsrData;
             if LeftStr(FMenuCode,2) = Common.Config.ScalePrefix then SelectMenu(1)
             else                                                     SelectMenu(0);
           end
           //4자리 입력했을때 회원조회할때
           else if (Length(FMsrData) = 4) and (GetOption(322) = '1') and (Common.Member.Code = '') then
           begin
             Action12.Execute;
           end
           //주문화면에서 받은금액을 받을때
           else if (Common.PreSent.WRcvAmt <> 0) and (GetOption(376) = '1') and (Length(FMsrData) > 3) and (Length(FMsrData) <= 7) and (FMsrData = GetOnlyNumber(FMsrData)) and (StrToInt(FMsrData) mod 100 = 0) then
           begin
             Common.PreSent.CashAmt := Common.PreSent.CashAmt + StrToInt(FMsrData);
             DisplayPresent;
             if Common.PreSent.WRcvAmt = 0 then
               FinishExecute('1');
           end
           else if Length(FMsrData) > 0 then
           begin
             FMenuCode  := FMsrData;
             FMsrData   := '';
             SelectMenu(0);
           end
         end
         else
         begin
           if KioskWaitPanel.Left = 0 then
             KioskBeginImageClick(nil);

           vNumData := GetCardNo(FMsrData);
           if Common.isMemberCardNo(vNumData) then
           begin
             Common.SelectMemberInfo('',vNumData,'');
             if Common.Member.Code = EmptyStr then
             begin
               Common.MsgBox(vNumData +#13#13+'등록되지 않은 회원카드입니다');
             end
             else
             begin
               if (Common.Member.Name <> '') then
                 if not Common.AskBox(Format('%s 고객님이 맞습니까?'+#13#13+'이용금액 %s 원',[Common.Member.Name, FormatFloat(',0',Common.Member.CreditAmt) ])) then Exit;

               if (Common.Config.MemberDefaultMenu <> '') and not GetMenuOrderCheck(Common.Config.MemberDefaultMenu) then
               begin
                 FMenuCode := Common.Config.MemberDefaultMenu;
                 SelectMenu(0);
                 OrderListView;
               end;
               WorkState := wsSale;
               DisplayPresent;
               //회원조회 후 자동 외상결제
               if (GetOption(317) = '1') and (Common.Member.Yn_trust = 'Y') then
               begin
                 KioskTrustButtonClick(nil);
               end;
             end;
           end
           else if (Length(FMsrData) = 13) or (Length(FMsrData) = 16) or (Length(FMsrData) = 18) then
           begin
             FMenuCode := FMsrData;
             if LeftStr(FMenuCode,2) = Common.Config.ScalePrefix then SelectMenu(1)
             else                                                     SelectMenu(0);
             OrderListView;
           end
           else if Length(FMsrData) > 0 then
           begin
             FMenuCode  := FMsrData;
             FMsrData   := '';
             SelectMenu(0);
             OrderListView;
           end
         end;
       finally
         FMsrData := EmptyStr;
         InputEdit.Clear;
         InputEdit.Visible := false;
         IsEnter  := False;
       end;
     end;
     VK_UP     : GridPriorButtonClick(nil);
     VK_DOWN   : GridNextButtonClick(nil);
   end;
end;


procedure TOrder_F.FormActivate(Sender: TObject);
begin
  ReDrowGridTitle;
end;

procedure TOrder_F.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ReceiptPrintMode := Common.SetPrintMode;
  Common.Device.OnCidReadData := nil;
  Common.Config.UserWork      := UserWork;
  Tmr_KioskWait.Enabled       := false;
  Common.isKFTCDetect         := true;
  Common.KFTCDetectData     := '';
  KioskBillInfo_F := nil;
  if Option60 = '1' then
  begin
    Action35.Tag := 1;
    Action35.Execute;
  end;
end;

procedure TOrder_F.Present_sGrdDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var  vAlign:Integer;
begin
  if PresnetPanel.Visible then
    TStringGrid(Sender).Canvas.Font.Size := Common.Config.ListFontSize+1
  else
    TStringGrid(Sender).Canvas.Font.Size := Common.Config.ListFontSize+2;

  if gdSelected in State then
  begin
    TStringGrid(Sender).Canvas.Font.Color  := clWhite;
    TStringGrid(Sender).Canvas.Brush.Color := $00AE5700;
  end
  else
  begin
    TStringGrid(Sender).Canvas.Font.Color  := clBlack;
    TStringGrid(Sender).Canvas.Brush.Color := clWhite;
  end;

  case Acol of
    0 : vAlign := 0; //좌측
    1 : vAlign := 2; //우측정렬
  end;
  Common.Grid_Align(Sender, ACol, ARow, Rect, vAlign);
  //    숫자형 출력시 Format 형식   //
  case ACol of
    1: Common.Grid_DisplayFormat(Sender, ACol, ARow, Rect);
  end;
end;

procedure TOrder_F.PrintOptionButtonClick(Sender: TObject);
begin
  PrintOptionPanel.Top  := (Self.Height - PrintOptionPanel.Height) div 2;
  PrintOptionPanel.Left := (Self.Width - PrintOptionPanel.Width) div 2;
  PrintOptionPanel.Visible := not PrintOptionPanel.Visible;
  PrintOptionPanel.BringToFront;
end;

//**************************************************************************//
//                       각종메세지 보이기
//**************************************************************************//
procedure TOrder_F.DisplayMessage(aState: Integer; aMsg: String);
var vMsg :String;
begin
  if (aState = 0) and (Copy(TLabel(FindComponent('MessageLabel')).Caption,1,4) = '[오류]') then
  begin
    SaveMessageData  := '[알림] '+aMsg;
    Exit
  end;

  if Copy(TLabel(FindComponent('MessageLabel')).Caption,1,4) = '[알림]' then
    SaveMessageData         := TLabel(FindComponent('MessageLabel')).Caption;

  if aState <> 3 then
    FMsrData := '';

  if FMsrData = '' then
    InputEdit.Visible := false;
  case aState of
    0:
    begin
      vMsg    := '[알림] '+aMsg;
      TmrMsg.Enabled     := False;
    end;
    1:
    begin
      vMsg    := '[오류] '+aMsg;
      TmrMsg.Enabled     := True;
    end;
    2:
    begin
      vMsg    := '[정보] '+aMsg;
      TmrMsg.Enabled     := True;
    end;
    3 : vMsg  := aMsg;
  end;

  if Assigned(TLabel(FindComponent('MessageLabel'))) then
    TLabel(FindComponent('MessageLabel')).Destroy;

  with TLabel.Create(Self) do
  begin
    Name        := 'MessageLabel';
    Parent      := Self;
    AutoSize    := false;
    Top         := Self.Height - 38;
    Left        := 66;
    Font.Name   := '맑은 고딕';
    Font.Color  := clWhite;
    Font.Size   := 14;
    Width       := 544;
    Height      := 28;
    Transparent := true;
  end;
  if Assigned(TLabel(FindComponent('MessageLabel'))) then
    TLabel(FindComponent('MessageLabel')).Caption     := Common.GetPaPago(vMsg);

end;

//**************************************************************************//
//                       작업구분변경시 셋팅
//**************************************************************************//
procedure TOrder_F.SetWorkKind(AValue: TWorkKind);
begin
  //포장전용테이블일때는 무조건 포장으로 한다
  if (Common.Table.Packing = 'Y') and (AValue = wkSale) then
    FWorkKind := wkPacking
  else
    FWorkKind := AValue;
  Common.WorkKind := FWorkKind;
  case FWorkKind of
    wkSale    :
    begin
      DisplayMessage(0,'메뉴를 등록하세요.');
    end;
    wkPacking : DisplayMessage(0,'포장 메뉴를 등록하세요.');
    wkService : DisplayMessage(0,'서비스 메뉴를 등록하세요.');
    wkRefund  : DisplayMessage(0,'반품 메뉴를 등록하세요.');
  end;
end;

//**************************************************************************//
//                       작업상태변경시
//**************************************************************************//
procedure TOrder_F.SetWorkState(aValue: TWorkState);
begin
  FWorkState := aValue;
  Common.WorkState := aValue;
  case FWorkState of
    wsReady :
      begin
        if (Common.GetCardLog(False) <> '') then
        begin
          CardLogButton.Visible := True;
          Common.MsgBox('저장되지 않은 카드승인내역이 있습니다'+#13#13+'반드시 처리해야합니다');
        end
        else
          CardLogButton.Visible := False;

        InitPreSentRecord(Common.PreSent);         //시재초기화
        InitMemberRecord(Common.Member);           //회원정보초기화
        InitMenuRecord(Common.Menu);               //상품정보초기화
        InitCardRecord(Common.Card);               //신용카드정보초기화
        InitCashRcpRecord(Common.CashRcp);         //현금영수증정보초기화
        if Common.Config.IsKiosk then
          InitTableRecord(Common.KioskTable);

        Common.ClearGrid(Main_SGrd);               //메인그리드초기화
        if Common.OrderKind <> okSaleChange then
          Common.ClearGrid(Common.Summary_sGrd);     //집계그리드초기화
        Common.ClearGrid(Common.Temp_sGrd);        //집계그리드초기화
        Common.ClearGrid(Common.Group_sGrd);       //집계그리드초기화
        Common.ClearGrid(Common.Card_SGrd);        //카드정보그리드초기화
        Common.ClearGrid(Common.Cash_SGrd);        //현금영주증정보그리드초기화
        Common.ClearGrid(Common.UPlus_SGrd);       //유플러스할인정보그리드초기화
        Common.CustomerPrinter  := EmptyStr;
        Common.CustomerCancel   := EmptyStr;
        Common.OrderAmt         := 0;
        Common.Present.TotalAmt := Common.Table.GroupAmt;
        Common.ClearCornerData;
        InputEdit.Visible := false;
        //선불제방식일때는 고객수를 1로 한다
        if Common.Config.IsTakeOut and (Common.Table.OrderType <> 'D') then
        begin
          Common.Table.CustomerCount   := 1;
          Common.Table.CustCode := '';
          Common.Table.Date := Common.NowDate;
          Common.Table.Time := Copy(Common.NowTime,1,2) + ':' + Copy(Common.NowTime,3,2);
          Common.Table.DamdangCode := '';
          Common.Table.DamdangName := '';
        end;
        DisPlayPreSent;                            //시재화면에 보이기
        FMenuCode := EmptyStr;                     //입력에디트초기화
        FMsrData  := EmptyStr;
        InputEdit.Clear;
        ReceiptPrintMode := Common.SetPrintMode;
        SplitPrintMode   := GetOption(42) = '0';
        CardPrintMode    := GetOption(45) = '1';
        KitchenPrintMode := GetOption(10) = '1';
        //포스별로 출력여부를 설정한다고 했을때
        if GetOption(167) = '1' then
          BillPrintMode    := Common.SetBillPrintMode
        else
          BillPrintMode    := GetOption(11) = '1';
        //영수증에 메뉴출력여부
        MenuPrintMode := GetOption(68) = '0';

        WorkKind  := wkSale;
        if Common.Config.IsTakeOut and (Common.Table.OrderType <> 'D') then
          Common.ShowNormalDualScreen;
        Common.WhyOrdercancel := EmptyStr;
        DisplayMessage(0,'판매 대기 중 입니다.');
        //단축메뉴 초기화
        if Common.Config.IsKiosk then
        begin
          KioskPage    := 1;
          obtn_KioskClass1Click(nil);
        end
        else if not Common.Config.IsTakeOut then
          SetPluClassData;

        DuthPayLabel.Visible       := false;
        HoldCount;
        bRestore     := False;
        RestorePrice := 0;
        RestoreQty   := 0;
        bDouble      := False;
        FMemo        := '';
        if Trim(Common.Config.fixdcCode) <> '' then
          Common.Present.CodeDcCode := Common.Config.fixdcCode;
        SetCodeDc;

        Common.DeleteSignFile;
        SetNoTransCount;
        IsExecuteCard  := False;
        isKitchenPrint := true;
        lbl_BeforeAcct.Visible := false;
        Common.GetReceiptNo;
        PosNoLabel.Caption      := Format('%s - %s',[Common.Config.PosNo, Common.PreSent.RcpNo]);

        //다중모드 해제 원복
        if Option60 = '1' then
        begin
          Action35.Tag := 1;
          Action35.Execute;
        end;
        //다국어 버튼이 눌린상태
        if FlagPanel.Visible then
        begin
          KioskPanel.Enabled := true;
          FlagPanel.Visible  := false;
        end;
        if KioskFlagButton.Visible then
        begin
          KioskFlagButton.Picture.Assign(FlageCollection.Items.Items[Ifthen(GetOption(485)='0',0,9)].Picture.Graphic);
          ThaiButtonClick(FlagKoreaButton);
        end;

        KioskTrustButton.Status.Caption := '';
        KioskTrustButton.Status.Visible := false;

        KioskPointSearchButton.Status.Caption := '';
        KioskPointSearchButton.Status.Visible := false;

        Common.KioskVoice := false;
        KioskVoiceListenButton.Status.Visible := false;

        //계산전 호출전화번호 입력
        if isCheckMobileNo then
          FunctionButton[MobileFunctionButtonX, MobileFunctionButtonY].Status.Caption := 'X';
      end;
    wsSale:
      begin
        FMenuCode := EmptyStr;                     //입력에디트초기화
        if Common.Config.IsTakeOut then
          Common.ShowSaleDualScreen;
        DisPlayPreSent;                            //시재화면에 보이기
        DisplayMessage(0,'판매 중 입니다.');
      end;
    wsAcct:DisplayMessage(0,'정산 중 입니다.');
    wsMagam:
      begin
        IsExecuteCard  := False;
        InitCardRecord(Common.Card);               //신용카드정보초기화
        InitCashRcpRecord(Common.CashRcp);         //현금영수증정보초기화
        Common.ClearGrid(Common.Card_SGrd);        //카드정보그리드초기화
        Common.ClearGrid(Common.Cash_SGrd);        //현금영주증정보그리드초기화
        Common.IsCashierMgm := False;

        if Common.Config.IsTakeOut then
        begin
          wsReadyApply := false;
          PluClassPage := 1;
          ShowPluClassButton;
          wsReadyApply := true;
        end;

        if WorkState = wsReady then Exit;
        DisplayMessage(0,'정산이 완료되었습니다.');
        Main_sGrd.Refresh;
        //선불제일때 정산후 화면을 Clear 한다고 했을때는 듀얼정산화면을 클리어하지 않는다
        if (Common.Config.IsTakeOut) and (GetOption(159) = '1') then
          Common.ShowNormalDualScreen;
      end;
  end;
end;


procedure TOrder_F.ExecCard(aEasyPay:Boolean=false);
var vPoint, vNowPoint :TPoint;
    vInputAmt :Integer;
    vMessage :String;
begin
  if not Common.IsDebugMode then
    BlockInput(true);

  if (Common.PreSent.WRcvAmt = 0) then Exit;
  
  try
    Common.Device.OnScannerReadData := nil;
    if not CheckPrevAccount then Exit;
    if CheckSaleFinish then Exit;
    if (Common.Present.TotalAmt > 0) and (Common.Present.RcvAmt > 0) and (Common.PreSent.WRcvAmt = 0) then
    begin
      FinishExecute('2');
    end
    else
    begin
      if Common.PreSent.WRcvAmt = 0 then
      begin
        Common.ErrBox('받을금액이 없습니다');
        Exit;
      end;

      try
        if not Common.CheckAcctPos then Exit;
        if not CheckGroupType then Exit;
        if Common.Present.GiveAmt < 0 then
        begin
           Common.ErrBox('전체반품만 카드취소가 가능합니다');
           Exit;
        end;

        //신용카드 계산 시 자동절사 기능을 사용하지 않습니다
        if (GetOption(305) = '1') and (Common.PreSent.TotalDC = Common.PreSent.CutDc) then
        begin
          IsCutDc := False;
          DisplayPresent;{시재화면에 보이기}
        end;

        //신용카드를 사용하지 않는다고 설정했으면
        if GetOption(51) = '1' then
        begin
          Common.PreSent.CardAmt := Common.PreSent.WRcvAmt;
          DisplayPresent;{시재화면에 보이기}
          FinishExecute('3');
          Exit;
        end;

        //그룹마스터일때
        if not Common.Config.IsTakeOut and (Common.Table.GroupType = 'M') then
        begin
          if not CheckGroupDetail then Exit;
          if not Common.AskBox('그룹디테일까지 모두 정산됩니다'+#13#13+'계속하시겠습니까?') then Exit;

          Common.GridToGrid(Common.Summary_sGrd, Common.Temp_sGrd);
          Common.GridToGrid(Common.Group_sGrd, Common.Temp_sGrd, true);
          Common.TaxCalculation;
        end;

        InitCardRecord(Common.Card);
        //서명받으면서 터치를 계속하면 메뉴가 터치가 되서 안되도록 막음
        IsExecuteCard  := True;
        if (GetOption(376) = '1') and (Length(FMsrData) > 3) and (Length(FMsrData) <= 7) and (FMsrData = GetOnlyNumber(FMsrData)) and (StrToInt(FMsrData) < Common.PreSent.WRcvAmt) and (StrToInt(FMsrData) mod 100 = 0) then
        begin
          vInputAmt := StrToInt(FMsrData);
          FMsrData := EmptyStr;
          DisplayMessage(3, '');
        end
        else
          vInputAmt := 0;

        if Common.ShowCardForm(aEasyPay, true, vInputAmt) then
        begin
          if not Common.IsDebugMode and ((GetOption(379) <> '2') or (Common.Config.van_trd <> vanKICC)) then
            BlockInput(true);
          try
            if Self.Handle <> GetForeGroundWindow then
              SetForegroundWindow(Self.Handle);

            if (Common.ICCard.VAN <> vtKoces) and Present_sGrd.Enabled and not Common.Table.AHeadPay then
            begin
              GetCursorPos(vNowPoint);
              vPoint := Present_sGrd.ClientToScreen(Point(5,5));
              SetCursorPos(vPoint.X, vPoint.Y);
              mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
              mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
              SetCursorPos(vNowPoint.X, vNowPoint.Y);
            end;

            vMessage := Format('%s - 금액 %s',[Common.Card.Nm_Card, FormatFloat(',0원',Common.Card.Amt)]);
            InitCardRecord(Common.Card);
            DisplayPresent;{시재화면에 보이기}
            Common.IsWorking := False;
            if Common.Table.AHeadPay then
            begin
              Common.AHeadCardDataSave;
              Common.PreSent.AHeadPayAmt := Common.PreSent.CardAmt + Common.PreSent.CashAmt;
              CloseButtonClick(nil);
              Exit;
            end
            else
            begin
              //받을금액이 없으면 계산을 실행한다
              if (Common.PreSent.WRcvAmt = 0) then
              begin
                Common.WriteLog('work', '카드승인->정산시작');
                BlockInput(true);
                FinishExecute('4');
                //신용카드 승인 후 정산완료 시 승인내역 표시
                if GetOption(446) = '1' then
                begin
                  Common.ShowWaitForm('계산이 완료되었습니다'#13+vMessage, false);
                  Sleep(1000);
                  Common.HideWaitForm;
                end;
              end;

              if Assigned(Table_F) then
                Table_F.CardMsg := vMessage;

              if Common.PreSent.WRcvAmt > 0 then
                IsExecuteCard  := false;
            end;
          finally
            BlockInput(false);
          end;
        end
        else
        begin
          Common.Table.AHeadPay := false;
        end;

        KeyPreview       := True;
      finally
        IsCutDc          := True;
        ReDrowGridTitle;
        DisplayPresent;{시재화면에 보이기}
        FMsrData         := EmptyStr;
        FCardData        := EmptyStr;
      end;
    end;
  finally
    BlockInput(false);
    Common.isKFTCDetect   := true;
    Common.KFTCDetectData := '';
    IsExecuteCard         := False;
    Common.Device.OnScannerReadData := ScannerReadEvent;
  end;
end;

//**************************************************************************//
//                       메세지 타이머
//**************************************************************************//
procedure TOrder_F.TmrMsgTimer(Sender: TObject);
begin
  DisplayMessage(3, '');
  TmrMsg.Enabled     := False;
  DisplayMessage(3, SaveMessageData);;
end;

//**************************************************************************//
//                       시재내역보이기
//**************************************************************************//
procedure TOrder_F.DisplayPresent;
  function GetOrderCount:String;
  var vRow, vQty :Integer;
  begin
    vQty := 0;
    For vRow :=0 to Main_sGrd.RowCount-1 do
    begin
      if Main_sGrd.Cells[GDM_CD_MENU1, vRow] <> EmptyStr then Continue;
      if Main_sGrd.Cells[GDM_DS_MENU, vRow] = 'W' then
        vQty := vQty + 1
      else
        vQty := vQty + StoI(Main_sGrd.Cells[GDM_QTY, vRow]);
    end;
    Result := IntToStr(vQty);
  end;

  //할인제외상품 금액을 구한다
  function GetDcExistAmt:Integer;
  var vRow : Integer;
  begin
    Result := 0;
    if Main_sGrd.Cells[0,0] = '' then Exit;
    For vRow :=0 to Main_sGrd.RowCount-1 do
    begin
      //중복할인을 허용하지 않을때
      if GetOption(294) = '0' then
      begin
        //메뉴할인이나 회원할인을 한 메뉴는 제외한다
        if (Main_sGrd.Cells[GDM_YN_DC, vRow] = 'N') or (StoI(Main_sGrd.Cells[GDM_DC_MENU, vRow]) <> 0) or (StoI(Main_sGrd.Cells[GDM_DC_MEMBER, vRow]) <> 0) or (StoI(Main_sGrd.Cells[GDM_DC_STAMP, vRow]) <> 0) then
          Result := Result + StoI(Main_sGrd.Cells[GDM_AMT, vRow]);
      end
      else
      begin
        if (Main_sGrd.Cells[GDM_YN_DC, vRow] = 'N') then
          Result := Result + StoI(Main_sGrd.Cells[GDM_AMT, vRow]);
      end;
    end;
  end;

  procedure ReTotalAmtCalculation;
  var vTotalAmt, nRow :Integer;
  begin
    vTotalAmt := 0;
    if Common.Summary_sGrd.Cells[0,0] <> '' then
    For nRow := 0 to Common.Summary_sGrd.RowCount-1 do
    begin
      if Common.Summary_sGrd.Cells[GDM_DS_MENU,nRow] = 'W' then
      begin
         vTotalAmt := vTotalAmt + StoI(Common.Summary_sGrd.Cells[GDM_PR_SALE, nRow]);
         vTotalAmt := vTotalAmt + StoI(Common.Summary_sGrd.Cells[GDM_PR_ITEM,nRow]);
      end
      else
      begin
         vTotalAmt := vTotalAmt + StoI(Common.Summary_sGrd.Cells[GDM_QTY, nRow]) * StoI(Common.Summary_sGrd.Cells[GDM_PR_SALE, nRow]);
         vTotalAmt := vTotalAmt + StoI(Common.Summary_sGrd.Cells[GDM_QTY, nRow]) * Ifthen(Common.Summary_sGrd.Cells[GDM_DS_SALE,nRow]='D', 0, StoI(Common.Summary_sGrd.Cells[GDM_PR_ITEM,nRow]));
      end;
    end;

    if Common.PreSent.TotalAmt <> (vTotalAmt + Common.Table.GroupAmt) then
      Common.PreSent.TotalAmt := vTotalAmt + Common.Table.GroupAmt;
  end;
  function GetSummaryGridRow(aRow:Integer): Integer;
  var vRow:Integer;
  begin
     with Main_sGrd do
     begin
       For vRow := 0 to Common.Summary_sGrd.RowCount - 1 do
       begin
         if (Cells[GDM_CD_MENU, aRow] = Common.Summary_sGrd.Cells[GDM_CD_MENU, vRow])
           and (Cells[GDM_DS_SALE, aRow] = Common.Summary_sGrd.Cells[GDM_DS_SALE, vRow])
           and (Cells[GDM_PR_SALE, aRow] = Common.Summary_sGrd.Cells[GDM_PR_SALE, vRow])
           and (Common.Summary_sGrd.Cells[GDM_CD_MENU1, vRow] = '')
           then
         begin
              Result := vRow;
              Break;
         end;
       end;
     end;
  end;
  function GetCouponMenu(aMenu:String):Boolean;
  var vRow : Integer;
  begin
    Result := false;
    if Main_sGrd.Cells[0,0] = '' then Exit;
    For vRow :=0 to Main_sGrd.RowCount-1 do
    begin
      //주메뉴만 체크한다
      if (Main_sGrd.Cells[GDM_CD_MENU1, vRow] <> '') then Continue;

      if (Main_sGrd.Cells[GDM_CD_MENU, vRow] = aMenu) then
      begin
        Result := true;
        Break;
      end;
    end;
  end;
var liRow, vQty, vAmout, vSum, vDcRate, nRow : Integer;
    vTemp, Dcpr : Double;
    vSaveStamp :Integer;
    vDualMaster,
    vDualDetail :String;
begin
   ReTotalAmtCalculation;
   //회원정보보이기
   if Common.Member.nm_class <> '' then
     MemberNameLabel.Caption     := Format('%s [%s]',[Common.Member.Name, Common.Member.nm_class])
   else
     MemberNameLabel.Caption     := Common.Member.Name;

   if Common.Member.Code <> ''  then
     CashRequestLabel.Visible := false;

   if Common.Member.Code <> '' then
     LastVisitDatetLabel.Caption := Format('최종방문 : %s',[Replace(Common.Member.dt_visit,' ','')])
   else
     LastVisitDatetLabel.Caption := '';

   Common.PreSent.ExistDcAmt := GetDcExistAmt;

   if Common.Member.Code <> '' then
   begin
     if GetOption(21) = '0' then
       PointLabel.Caption   := Format('포 인 트 : %s 점',[FormatFloat('#,0',Common.Member.Point)])
     else
       PointLabel.Caption   := Format('[적립] %d개 [잔여] %d개', [Common.PreSent.SaveStamp-Common.PreSent.UseStamp, Common.Member.Stamp + Common.PreSent.SaveStamp - Common.PreSent.UseStamp]);

     if (Common.Member.DcType = '0') or (Common.Member.DcType = '2') then
     begin
       Common.PreSent.MemberDC := FtoI( hRound ((Common.Member.Dc_Rate / 100) * (Common.PreSent.TotalAmt-Common.PreSent.ExistDcAmt),0 ) );

       //할인율단위 계산
       if Common.Config.dc_unit > 0 then
         Common.PreSent.MemberDC := wyRound(FtoI(Common.PreSent.MemberDC), Common.Config.dc_unit);
     end
     //회원구분별 메뉴할인
     else if (Common.Member.DcType = '3') and (Common.Member.cd_class <> '') and (GetOption(251)='1') then
     begin
       Common.PreSent.MemberDc := 0;
       For liRow := 0 to Main_sGrd.RowCount-1 do
       begin
         if (Main_sGrd.Cells[GDM_DS_SALE, liRow] <> 'S') and (Main_sGrd.Cells[GDM_DS_SALE, liRow] <> 'P') then Continue;
         OpenQuery('select DC_RATE '
                  +'  from MS_MENU_DC '
                  +' where CD_STORE  =:P0 '
                  +'   and DS_MEMBER =:P1 '
                  +'   and CD_MENU   =:P2',
                  [Common.Config.StoreCode,
                   Common.Member.cd_class,
                   Main_sGrd.Cells[GDM_CD_MENU, liRow]]);

         if not Common.Query.Eof then
           vDcRate := Common.Query.Fields[0].AsInteger
         else
           vDcRate := 0;
         Common.Query.Close;

         if Main_sGrd.Cells[GDM_DS_MENU, liRow] = 'W' then
         begin
           vQty   := 1;
           vAmout := StoI(Main_sGrd.Cells[GDM_PR_SALE, liRow]);
         end
         else
         begin
           vQty := StoI(Main_sGrd.Cells[GDM_QTY, liRow]);
           vAmout := StoI(Main_sGrd.Cells[GDM_AMT, liRow]);
         end;

         Dcpr := FtoI( hRound( vDcRate / 100 * vAmout,0) );

         //할인율단위 계산
         if Common.Config.dc_unit > 0 then
           Dcpr := wyRound(FtoI(Dcpr), Common.Config.dc_unit);

         Main_sGrd.Cells[GDM_DC_MEMBER, liRow] := FtoS( Dcpr );

         nRow := GetSummaryGridRow(liRow);

         if Common.Summary_sGrd.Cells[GDM_DS_MENU, nRow] = 'W' then
         begin
           vQty   := 1;
           vAmout := StoI(Common.Summary_sGrd.Cells[GDM_PR_SALE, nRow]);
         end
         else
         begin
           vQty := StoI(Common.Summary_sGrd.Cells[GDM_QTY, nRow]);
           vAmout := StoI(Common.Summary_sGrd.Cells[GDM_AMT, nRow]);
         end;

         Dcpr := vDcRate / 100 * vAmout;

         //할인율단위 계산
         if Common.Config.dc_unit > 0 then
           Dcpr := wyRound(FtoI(Dcpr), Common.Config.dc_unit);

         Common.Summary_sGrd.Cells[GDM_DC_MEMBER, nRow] := FtoS( Dcpr );

         Common.PreSent.MemberDc := Common.PreSent.MemberDc + FtoI(Dcpr);
       end;
     end;
     //포인트사용제한상품금액
     Common.PreSent.ExistPointUseAmt := 0;
     For liRow := 0 to Main_sGrd.RowCount-1 do
     begin
       if Main_sGrd.Cells[GDM_YN_POINT_LIMIT, liRow] = 'Y' then
         Common.PreSent.ExistPointUseAmt := Common.PreSent.ExistPointUseAmt + StoI(Main_sGrd.Cells[GDM_AMT, liRow]);
     end;

     if (Common.PreSent.TotalAmt - Common.PreSent.ExistPointUseAmt) < Common.PreSent.UsePnt then
     begin
       Common.PreSent.PointDc  := 0;
       Common.PreSent.PointAmt := 0;
       Common.PreSent.UsePnt   := 0;
     end;

     //스템프 계산
     Common.Present.SaveStamp     := 0;
     //스템프를 사용했으면 적립해주지 않는다 (해당 메뉴만)
     if GetOption(21) = '1' then
     begin
       For liRow := 0 to Main_sGrd.RowCount-1 do
       begin
         if (Main_sGrd.Cells[GDM_DS_SALE, liRow] = 'D') or (Main_sGrd.Cells[GDM_CD_MENU1, liRow] <> '') then Continue;
         vQty := StoI(Main_sGrd.Cells[GDM_QTY, liRow]);
         //스템프를 사용한 메뉴일때는 적용수량을 1 뺀다(한영수증에 스템프는 한번만 사용가능하므로)
         if (StoI(Main_sGrd.Cells[GDM_USE_STAMP, liRow]) <> 0) and (vQty > 0) then
           vQty := vQty - 1;

         vSaveStamp := StoI(Main_sGrd.Cells[GDM_SAVE_STAMP_M, liRow]) * vQty;
         //키오스크일때 2배지급 옵션
         if ((GetOption(420)='1') and (Common.Present.LetsOrderAmt > 0)) or ((GetOption(285)='1') and Common.Config.IsKiosk) then
           vSaveStamp := vSaveStamp * 2;
         Main_sGrd.Cells[GDM_SAVE_STAMP, liRow] := IntToStr(vSaveStamp);
         Common.Present.SaveStamp     := Common.Present.SaveStamp + vSaveStamp ;
         nRow := GetSummaryGridRow(liRow);
         vQty := StoI(Common.Summary_sGrd.Cells[GDM_QTY, liRow]);
         Common.Summary_sGrd.Cells[GDM_SAVE_STAMP, nRow] := IntToStr(vSaveStamp);
       end;
       PointLabel.Caption   := Format('[적립] %d개 [잔여] %d개', [Common.PreSent.SaveStamp-Common.PreSent.UseStamp, Common.Member.Stamp + Common.PreSent.SaveStamp - Common.PreSent.UseStamp]);
       PointLabel.Caption   := Common.GetPaPago(PointLabel.Caption);
     end
     else
     begin
       Common.Present.SaveStamp := 0;
       Common.Present.UseStamp  := 0;
     end;
   end
   else
   begin
     Common.Present.SaveStamp := 0;
     Common.Present.UseStamp  := 0;
     Common.PreSent.ExistPointUseAmt := 0;
     Common.PreSent.MemberDC := 0;
     PointLabel.Caption         := '';
     MemberNameLabel.Caption    := '';
   end;

   Common.PreSent.MenuDc     := 0;
   Common.PreSent.ServiceAmt := 0;
   with Common.Summary_sGrd do
   begin
     For liRow := 0 to RowCount-1 do
     begin
       //메뉴할인금액
       if Cells[GDM_DS_MENU, liRow] = 'W' then vQty := 1
       else                                    vQty := StoI(Cells[GDM_QTY, liRow]);
       Common.PreSent.MenuDc := Common.PreSent.MenuDc + ( StoI(Cells[GDM_DC_MENU, liRow])
                                                        * vQty );
       //서비스금액
       if Cells[GDM_DS_SALE, liRow] = 'D' then
         Common.PreSent.ServiceAmt := Common.PreSent.ServiceAmt +  ( StoI(Cells[GDM_PR_SALE_ORG, liRow])
                                                                     * vQty );
     end;
   end;

   with Common.PreSent do
   begin
     if CouponSaleAmt <= TotalAmt then
     begin
       //쿠폰할인
       if CouponType = 'R' then
       begin
         CouponDc := FtoI( (TotalAmt-ExistDcAmt) / 100 * CouponRate);
         //할인율단위 계산
         if Common.Config.dc_unit > 0 then
           CouponDc := wyRound(CouponDc, Common.Config.dc_unit);

         if (CouponLimit > 0) and (CouponLimit < CouponDc) then
           CouponDc := CouponLimit;
       end;
     end
     else
     begin
        CouponNo   := '';
        CouponType := '';
        CouponRate := 0;
        CouponLimit:= 0;
        CouponDc := 0;
     end;

      if CouponMenu <> '' then
      begin
      end;

      //회원전용이었는데 회원판매가 아닐때
      if (CouponMember and (Common.Member.Code = '')) or ((CouponMenu <> '') and not GetCouponMenu(CouponMenu)) then
      begin
        CouponNo   := '';
        CouponType := '';
        CouponRate := 0;
        CouponLimit:= 0;
        CouponDc   := 0;
      end;

      //결제변경 시 할인을 사용할 수 있거나 결제변경이 아닐 때
      if (GetOption(298) = '0') or (Common.OrderKind <> okChange) then
      begin
        CodeDc := 0;
        if Trim(CodeDcCode) <> '' then
          //지정할인
          case StoI(CodeDcType) of
            0 :
            begin
             //할인율단위 계산
              CodeDc := FtoI( ((TotalAmt-ExistDcAmt) / 100) * CodeDcRate );
              if Common.Config.dc_unit > 0 then
                CodeDc := wyRound(FtoI(CodeDc), Common.Config.dc_unit);
            end;
            1 :
            begin
              //금액할인
              //기준금액이 0원이면 할인금액을 그냥할인해준다
              if (CodeDcStdAmt = 0) then
              begin
                if TotalAmt >= CodeDcAmt then CodeDc := CodeDcAmt;
              end
              else if (CodeDcStdAmt < 0) then
                CodeDc := CodeDcAmt
              else CodeDc := FtoI( (FtoI(TotalAmt-ExistDcAmt) div CodeDcStdAmt) * CodeDcAmt );
            end;
            2 :
            begin
              vSum := 0;
              with Common.Summary_sGrd do
              For liRow := 0 to RowCount-1 do
              begin
                if Cells[GDM_CD_CLASS, liRow] = Common.PreSent.CodeDcClass then
                  vSum := vSum + StoI(Cells[GDM_AMT, liRow]);
              end;
              CodeDc := FtoI( vSum / 100 * CodeDcRate );
            end;
          end;

        //전체할인
        if RcpDc_Rate > 0 then
        begin
           Dcpr := ( (TotalAmt-ExistDcAmt) / 100 ) * RcpDc_Rate;
           Dcpr := FtoI( hRound( Dcpr,0) );
           //할인율단위 계산
           if (Common.Config.dc_unit > 0) and (RcpDc_Rate <> 100) then
             Dcpr := wyRound(FtoI(Dcpr), Common.Config.dc_unit);

           RcpDc := FtoI( Dcpr );
        end;

        //신용카드 계산 시 자동절사 할인기능을 사용하지 않는다고 했을때
        if ((TotalAmt = CardAmt) and (GetOption(305) = '1')) or not IsCutDc then
          CutDc := 0
        else
          CutDc := AmtofCut(TotalAmt - (MenuDc + RcpDc + SpcDc + CodeDc + EventDc + CouponDc + MemberDc +VatDc + PointDc + UPlusDc + KaKaoDc + LetsOrderDc), StrToIntDef(GetOption(153),0));

//        if (GetOption(305) = '1') and (TotalDC = CutDc) and IsCutDc then
//          CutDc := 0;
      end;

      if GetOption(372)='0' then
        UsePnt := PointAmt;
      {할인금액 배분}
      Common.Allot_Dc(Common.Summary_sGrd);

     //봉사료 셋팅 - 결제변경 시에는 적용하지 않는다
     if ((GetOption(235) = '1') or (Common.OrderKind <> okChange)) and (GetOption(20) = '1') then
     begin
       if (GetOption(160) = '0') and (GetOption(289) = '0') then
       begin
         if (FTipType = '0') and ( (FTipApply > 0) or (Common.PreSent.SetTip > 0)) then
           TipAmt := Ifthen(SetTip = -1, FTipApply, SetTip)
         else if (FTipType = '1') and ( (FTipApply > 0) or (SetTip > 0)) then
         begin
           vTemp := (TotalAmt / 100 ) * Ifthen(SetTip = -1, FTipApply, SetTip);
           vTemp := FtoI( hRound( vTemp,0) );
           //할인율단위 계산
           if Common.Config.dc_unit > 0 then
             vTemp := wyRound(FtoI(vTemp), Common.Config.dc_unit);
           TipAmt := FtoI(vTemp);
         end
         else
           TipAmt := 0;
       end
       //메뉴에 봉사료가 포함해서 사용할때
       else
       begin
         with Common.Summary_sGrd do
         begin
           TipAmt := 0;
           For liRow := 0 to RowCount-1 do
           begin
              if Cells[GDM_DS_SALE, liRow] = 'D' then Continue;
              if Cells[GDM_DS_MENU, liRow] = 'W' then vQty := 1
              else                                    vQty := StoI(Cells[GDM_QTY, liRow]);

              if (StoI(Cells[GDM_DC_RECEIPT, liRow]) + StoI(Cells[GDM_DC_MENU, liRow])) <> 0 then
                vTemp := StoI(Cells[GDM_TIP, liRow]) - (StoI(Cells[GDM_TIP, liRow]) / StoI(Cells[GDM_PR_SALE, liRow]) * ((StoI(Cells[GDM_DC_RECEIPT, liRow]) / vQty) + StoI(Cells[GDM_DC_MENU, liRow])))
              else
                vTemp := StoI(Cells[GDM_TIP, liRow]);
              TipAmt := TipAmt + ( FtoI(vTemp) * vQty  );
           end;
         end;
       end;
     end;

     {현금봉사료는 총봉사료에서 카드봉사료를 뺀다}
     CashTipAmt := TipAmt - CardTipAmt;

     {할인합계금액}
     TotalDc  := MenuDc + RcpDc + SpcDc + CodeDc + EventDc + CouponDc + MemberDc + CutDc + VatDc + PointDc + TaxFreeDc + StampDc + UPlusDc + KaKaoDc + LetsOrderDc;

     {받은금액}
     RcvAmt   := CashAmt + CardAmt + TrustAmt + CheckAmt + GiftAmt + BankAmt + EtcAmt + PointAmt + LetsOrderAmt;

     {받을금액}
     WrcvAmt  := TotalAmt + Ifthen(GetOption(160)='0', TipAmt, 0) - TotalDc - RcvAmt;

     if WrcvAmt < 0 then
     begin
       if (CouponDc <> 0) and (TotalAmt < CouponDc) then
         CouponDc := CouponDc + WrcvAmt;
       if (RcpDc <> 0) and (TotalAmt < RcpDc) then
         RcpDc := RcpDc + WrcvAmt;

       TotalDc  := MenuDc + RcpDc + SpcDc + CodeDc + EventDc + CouponDc + MemberDc + CutDc + VatDc + PointDc + UPlusDc + KaKaoDc + LetsOrderDc;
       WrcvAmt  := TotalAmt + Ifthen(GetOption(160)='0', TipAmt, 0) - TotalDc - RcvAmt;
     end;

     if WrcvAmt < 0 then WrcvAmt := 0;

     {거스름돈}
     GiveAmt := RcvAmt - TotalAmt - ifthen(GetOption(160)='0', TipAmt, 0) + TotalDc;
     if GiveAmt < 0 then GiveAmt := 0;
  //   if GiveAmt < 0 then GiveAmt := ABS(GiveAmt);

     {순매출}
     SoonAmt := TotalAmt - TotalDc;

     //정산을하면 작업진행상태를 정산으로 바꿈
     if (RcvAmt > 0) and (Common.WorkState <> wsMagam) then WorkState := wsAcct;

     TotalAmtLabel.Caption   :=  FormatFloat('#,0',TotalAmt + ifthen(GetOption(160)='0', TipAmt,  0));             //합계금액
     lblOrderAmt.Caption     :=  TotalAmtLabel.Caption;
     TotalDcAmtLabel.Caption :=  FormatFloat('#,0',TotalDC);                       //할인금액
     WGetAmtLabel.Caption    :=  FormatFloat('#,0',WRcvAmt);                       //받을금액
     GetAmtLabel.Caption     :=  FormatFloat('#,0',IfThen(RcvAmt < 0, 0, RcvAmt)); //받은금액

     if WRcvAmt >= 1000000 then
       WGetAmtLabel.Style.Font.Size := TotalAmtLabel.Style.Font.Size
     else
       WGetAmtLabel.Style.Font.Size := WGetAmtLabel.Tag;

     if GiveAmt > 0 then
     begin
       GetCaptionLabel.Caption := Common.GetPaPago('거스름돈');
       GetAmtLabel.Caption     := FormatFloat('#,0',GiveAmt);
     end
     else GetCaptionLabel.Caption := Common.GetPaPago('받은금액');

     case Common.Config.DualSize of
       1 :
       begin
         if Assigned(DualOrder_F) then
           with DualOrder_F do
           begin
             if GroupOrderPanel.Visible then
               Common.GridToGrid(GroupOrder_sGrd, Dual_sGrd)
             else
               Common.GridToGrid(Main_sGrd, Dual_sGrd);
             //듀얼화면에 부메뉴를 표시하지 않을 때
             if (GetOption(350) = '1') or (GetOption(350) = '3') then
               for liRow := Dual_sGrd.RowCount-1 downto 0 do
               begin
                 if Dual_sGrd.Cells[GDM_NO, liRow] = '' then
                   Common.DeleteRow(Dual_sGrd, liRow);
               end;
             TotalAmtEdit.Value    := TotalAmt + ifthen(GetOption(160)='0', TipAmt, 0);
             DcAmtEdit.Value       := TotalDC;
             WGetAmtEdit.Value     := WRcvAmt;
             GetAmtEdit.Value      := RcvAmt;

             if Common.Member.Code = '' then
             begin
               Dual_sGrd.Height    := 596;
               MemberPanel.Visible := false;
             end
             else
             begin
               Dual_sGrd.Height    := 430;
               MemberPanel.Visible := true;
             end;

             MemberNameLabel.Caption := Common.Member.Name+'('+Common.Member.Code+')';
             TelNoLabel.Caption      := Common.Member.MobileTel;
             if WorkState = wsMagam then
             begin
               if OccurPnt <> 0 then
                 PointLabel.Caption := FormatFloat('#,0', OccurPnt) +' / '+FormatFloat('#,0', Common.Member.Point)+' 점'
               else
                 PointLabel.Caption := FormatFloat('#,0', Common.Member.Point-UsePnt)+' 점';
             end
             else
               PointLabel.Caption := FormatFloat('#,0', Common.Member.Point-UsePnt)+' 점';

             lblAddStamp.Caption   := Format('%d 개',[SaveStamp-UseStamp]);
             lblTotalStamp.Caption := Format('%d 개',[Common.Member.Stamp + SaveStamp - UseStamp]);
           end;
       end;
       2 :
       begin
         if Assigned(DualOrder800_F) then
           with DualOrder800_F do
           begin
             if GroupOrderPanel.Visible then
               Common.GridToGrid(GroupOrder_sGrd, Dual_sGrd)
             else
               Common.GridToGrid(Main_sGrd, Dual_sGrd);
             //듀얼화면에 부메뉴를 표시하지 않을 때
             if (GetOption(350) = '1') or (GetOption(350) = '3') then
               for liRow := Dual_sGrd.RowCount-1 downto 0 do
               begin
                 if Dual_sGrd.Cells[GDM_NO, liRow] = '' then
                   Common.DeleteRow(Dual_sGrd, liRow);
               end;


             TotalAmtEdit.Value   := TotalAmt + ifthen(GetOption(160)='0', TipAmt, 0);
             DcAmtEdit.Value      := TotalDC;
             WGetAmtEdit.Value    := WRcvAmt;
             GetAmtEdit.Value     := RcvAmt;

             if Common.Member.Code = '' then
             begin
               Dual_sGrd.Height    := 456;
               MemberPanel.Visible := false;
             end
             else
             begin
               Dual_sGrd.Height    := 301;
               MemberPanel.Visible := true;
             end;

             MemberNameLabel.Caption := Common.Member.Name+'('+Common.Member.Code+')';
             TelNoLabel.Caption      := Common.Member.MobileTel;
             if WorkState = wsMagam then
             begin
               if OccurPnt <> 0 then
                 PointLabel.Caption := FormatFloat('#,0', OccurPnt) +' / '+FormatFloat('#,0', Common.Member.Point)+' 점'
               else
                 PointLabel.Caption := FormatFloat('#,0', Common.Member.Point-UsePnt)+' 점';
             end
             else
               PointLabel.Caption      := FormatFloat('#,0', Common.Member.Point-UsePnt)+' 점';

             lblAddStamp.Caption   := Format('%d 개',[SaveStamp-UseStamp]);
             lblTotalStamp.Caption := Format('%d 개',[Common.Member.Stamp + SaveStamp - UseStamp]);
           end;
       end;
       //스마트 패드
       3 :
       begin
         if (MilliSecondsBetween(Now(), SmartPadLastTimer) > 100) or Common.Config.IsTakeOut then
         begin
           vDualMaster := Common.Config.PosNo + #9 +
                          Common.Config.UserName + #9 +
                          IntToStr(TotalAmt) + #9 +
                          IntToStr(TotalDC) + #9 +
                          IntToStr(WRcvAmt) + #9 +
                          IntToStr(RcvAmt) + #9 +
                          IntToStr(GiveAmt) + #9 +
                          Common.Member.Name + #9 +
                          Common.Member.Code + #9 +
                          Common.Member.nm_class + #9 +
                          IntToStr(Common.Member.Point) + #9 +
                          IntToStr(SaveStamp) + #9 +
                          IntToStr(Common.Member.Stamp + SaveStamp - UseStamp) + #9;
           if Main_sGrd.Cells[0,0] = '' then
             vDualDetail := EmptyStr
           else
             for liRow := 0 to Main_sGrd.RowCount-1 do
               vDualDetail := vDualDetail +
                              Main_sGrd.Cells[GDM_NO, liRow] + #9 +
                              Main_sGrd.Cells[GDM_NM_MENU, liRow] + #9 +
                              Main_sGrd.Cells[GDM_VIEWQTY, liRow] + #9 +
                              Main_sGrd.Cells[GDM_VIEWPRICE, liRow] + #9 +
                              Main_sGrd.Cells[GDM_AMT, liRow] + #10;
           Common.Device.SendToPad(#2+'dual'+#2+vDualMaster+#2+vDualDetail, false);
           SmartPadLastTimer := Now();
         end;
       end;
     end;
     PreSentGridDisplay;
     lbl_OrderCount.Caption := '('+GetOrderCount+')개';
     lbl_KioskOrderCount.Caption := GetOrderCount;
     if (Common.Config.PosLanguage = 'KO') or (Common.Config.PosLanguage = '') then
     begin
       KioskWrcvAmtLabel.Caption   := FormatFloat(',0 원',WRcvAmt);
       KioskDcAmtLabel.Caption     := FormatFloat(',0 원',TotalDc);
       KioskOrderAmtLabel.Caption  := FormatFloat(',0 원',TotalAmt);
     end
     else
     begin
       KioskWrcvAmtLabel.Caption   := FormatFloat('￦ ,0',WRcvAmt);
       KioskDcAmtLabel.Caption     := FormatFloat('￦ ,0',TotalDc);
       KioskOrderAmtLabel.Caption  := FormatFloat('￦ ,0',TotalAmt);
     end;
  end;
end;


//**************************************************************************//
//                       결제버튼 클릭 이벤트
//**************************************************************************//
procedure TOrder_F.AccountButtonClick(Sender: TObject);
var vIndex :Integer;
    vCode :String;
begin
  try
    BlockInput(true);
    if MilliSecondsBetween(Now(),AcctClickTime) < 1000 then Exit;
    AcctClickTime := Now;
    (Sender as TAdvSmoothButton).Enabled := false;
  finally
    BlockInput(false);
  end;

  try
    (Sender as TAdvSmoothButton).Enabled := false;
    PluMenuPanel.Enabled        := false;
    FunctionButtonPanel.Enabled := false;
    AccountButtonPanel.Enabled := false;
    if WorkState = wsMagam then WorkState := wsReady;
    vCode := (Sender as TAdvSmoothButton).Hint;

    For vIndex := 0 to AccountActionList.ActionCount -1 do
    begin
       if Taction(AccountActionList[vIndex]).Hint = vCode then
       begin
          Common.WriteLog('work', TAction(AccountActionList[vIndex]).Caption+' 버튼');
          //현금정산시 확인(받은금액 없을때)
          if (GetOption(486)='1') and (vCode = '00') and (Common.PreSent.RcvAmt = 0) and (Common.PreSent.WRcvAmt <> 0) then
          begin
            if not Common.AskBox(Format('%s 하시겠습니까?',[TAction(AccountActionList[vIndex]).Caption])) then
            begin
              Exit;
              Break;
            end;
          end;
          AccountActionList[vIndex].Execute;
          Break;
       end;
    end;
  finally
    try
      if Self.Showing and Self.Enabled and Present_sGrd.Visible then
        Present_sGrd.SetFocus;
      if Self.Showing and Self.Enabled and not Present_sGrd.Focused and Main_sGrd.Enabled then
        Main_sGrd.SetFocus;
    except
    end;
    (Sender as TAdvSmoothButton).Enabled := true;
    Sleep(100);
    PluMenuPanel.Enabled                := true;
    FunctionButtonPanel.Enabled         := true;
    AccountButtonPanel.Enabled         := true;
  end;
end;

procedure TOrder_F.AccountButtonCreate;
var vIndex, vIndex2, vRow, vCol, vX, vY, vLeft, vTop :Integer;
    vFont  :TFont;
    vColor, vBorderColor : TColor;
    vWidth, vHeight, vRound :Integer;
    vICon :Integer;
    vShadow :Boolean;
begin
  AccountButtonPanel.Visible := true;
  vFont := TFont.Create;
  //결제버튼 설정정보를 읽어온다
  try
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
             +'       NM_CODE11 '
             +'  from MS_CODE  '
             +' where CD_STORE = :P0 '
             +'   and CD_KIND  = :P1 '
             +'   and CD_CODE  = ''100'' '
             +' order by CD_CODE ',
             [Common.Config.StoreCode,
              Common.Config.DesignCode]);
    if not Common.Query.Eof then
    begin
      vX          := StrToIntDef(Common.Query.FieldByName('NM_CODE1').AsString,5);
      vY          := StrToIntDef(Common.Query.FieldByName('NM_CODE2').AsString,2);
      vColor      := StringToColor(Common.Query.FieldByName('NM_CODE3').AsString);
      vFont.Name  := Common.Query.FieldByName('NM_CODE4').AsString;
      vFont.Size  := StrToIntDef(Common.Query.FieldByName('NM_CODE5').AsString,10);
      if Common.Query.FieldByName('NM_CODE6').AsString = '1' then
        vFont.Style := [fsBold];
      vFont.Color := StringToColor(Common.Query.FieldByName('NM_CODE7').AsString);
      vICon := Common.Query.FieldByName('NM_CODE8').AsInteger;
      vBorderColor := StringToColorDef(Common.Query.FieldByName('NM_CODE9').AsString, clBlack);
      vRound       := StrToIntDef(Common.Query.FieldByName('NM_CODE10').AsString, 0);
      vShadow      := Common.Query.FieldByName('NM_CODE11').AsString = 'Y';
    end;
  finally
    Common.Query.Close;
  end;

  //결제버튼을 생성한다
  if (vX > 0) and (vY > 0) then
  begin
    vWidth  := AccountButtonPanel.Width  div vX + Ifthen(vShadow,1,0);
    vHeight := AccountButtonPanel.Height div vY + Ifthen(vShadow,1,0);

    // 버튼을 새로 만든다
    SetLength(AccountButton, vY);
    AccountButtonPanel.Visible := false;
    vTop := AccountButtonPanel.Top;
    for vIndex := Low(AccountButton) to High(AccountButton) do
    begin
      SetLength(AccountButton[vIndex], vX);
      vLeft := AccountButtonPanel.Left -1;
      for vIndex2 := Low(AccountButton[vIndex]) to High(AccountButton[vIndex]) do
      begin
        AccountButton[vIndex][vIndex2] := TAdvSmoothButton.Create(Self);
        AccountButton[vIndex][vIndex2].Name                          := 'AccountButton'+FormatFloat('00', vIndex)+FormatFloat('00', vIndex2);
        AccountButton[vIndex][vIndex2].DoubleBuffered                := true;
        AccountButton[vIndex][vIndex2].Parent                        := Self;
        AccountButton[vIndex][vIndex2].Color                         := vColor;
        AccountButton[vIndex][vIndex2].BevelColor                    := vBorderColor;
        AccountButton[vIndex][vIndex2].Appearance.SimpleLayout       := true;
        AccountButton[vIndex][vIndex2].Appearance.SimpleLayoutBorder := true;
        AccountButton[vIndex][vIndex2].Appearance.Rounding           := vRound;
        AccountButton[vIndex][vIndex2].Appearance.Font               := vFont;
        AccountButton[vIndex][vIndex2].Appearance.PictureAlignment   := taCenter;
        AccountButton[vIndex][vIndex2].Caption                       := EmptyStr;
        AccountButton[vIndex][vIndex2].Width                         := vWidth;
        AccountButton[vIndex][vIndex2].Height                        := vHeight;
        AccountButton[vIndex][vIndex2].Left                          := vLeft;
        vLeft := vLeft + vWidth + Ifthen(vShadow,0,1);
        AccountButton[vIndex][vIndex2].Top                           := AccountButtonPanel.Top + (vIndex * vHeight) + Ifthen(vShadow,0,(vIndex * 1));
        AccountButton[vIndex][vIndex2].OnClick                       := AccountButtonClick;
        AccountButton[vIndex][vIndex2].TabStop                       := false;
        AccountButton[vIndex][vIndex2].Hint                          := 'XX';
        AccountButton[vIndex][vIndex2].Shadow                        := vShadow;

        if vIcon = 1 then
          AccountButton[vIndex][vIndex2].Appearance.LayOut := blPictureLeft
        else
          AccountButton[vIndex][vIndex2].Appearance.LayOut := blPictureTop;
      end;
      vTop := vTop + vHeight + + Ifthen(vShadow,0,1);
    end;

    if Assigned(AccountButton) and (Length(AccountButton) > 0) then
    begin
      OpenQuery('select NM_CODE1, '
               +'       NM_CODE3, '
               +'       NM_CODE4, '
               +'       NM_CODE7, '
               +'       NM_CODE8, '
               +'       NM_CODE5, '
               +'       NM_CODE6, '
               +'       NM_CODE9 '
               +'  from MS_CODE  '
               +' where CD_STORE = :P0 '
               +'   and CD_KIND  = :P1 '
               +'   and CD_CODE  between ''101'' and ''199'' '
               +' order by CD_CODE ',
               [Common.Config.StoreCode,
                Common.Config.DesignCode]);
      while not Common.Query.Eof do
      begin
        if Common.Query.FieldByName('NM_CODE1').AsString <> '09' then
          if Assigned(AccountButton) and (Length(AccountButton) > 0) then
          begin
            vRow := StoI(Common.Query.FieldByName('NM_CODE7').AsString);
            vCol := StoI(Common.Query.FieldByName('NM_CODE8').AsString);
            if (vY > vRow) and (vX > vCol) and Assigned(AccountButton[vRow, vCol]) then
            begin
              AccountButton[vRow, vCol].Hint       := Common.Query.FieldByName('NM_CODE1').AsString;   //기능코드
              AccountButton[vRow, vCol].Caption    := LineFeed(Common.Query.FieldByName('NM_CODE3').AsString,1);
              AccountButton[vRow, vCol].Caption    := Common.GetPaPago(AccountButton[vRow, vCol].Caption);
              AccountButton[vRow, vCol].Color  := StringToColor(Common.Query.FieldByName('NM_CODE4').AsString);
//              AccountButton[vRow, vCol].ShineColor := StringToColor(Common.Query.FieldByName('NM_CODE4').AsString);
              if Common.Query.FieldByName('NM_CODE5').AsString <> '' then
                AccountButton[vRow, vCol].Appearance.Font.Color := StringToColor(Common.Query.FieldByName('NM_CODE5').AsString);
              if Common.Query.FieldByName('NM_CODE6').AsString = '1' then
                AccountButton[vRow, vCol].Appearance.Font.Style := [fsBold];
              if vIcon > 0 then
                AccountButton[vRow, vCol].Picture.Assign(AcctImageCollection.Items[StoI(Common.Query.FieldByName('NM_CODE1').AsString)].Picture);//     :=  TAdvGlassButton(FindComponent(Format('Acct%sButton',[Common.Query.FieldByName('NM_CODE1').AsString]))).Picture;;
              if StoI(Common.Query.FieldByName('NM_CODE9').AsString) >= 5 then
                AccountButton[vRow, vCol].Appearance.Font.Size := Common.Query.FieldByName('NM_CODE9').AsInteger;
            end;
          end;
        Common.Query.Next;
      end;
      Common.Query.Close;
    end;
  end;
  //버튼 합치기
  for vRow := Low(AccountButton) to High(AccountButton) do
    for vCol := Low(AccountButton[vRow]) to High(AccountButton[vRow])-1 do
  begin
    if (AccountButton[vRow][vCol].Hint = 'XX') or (AccountButton[vRow][vCol].Tag = 1) then Continue;

    //다음버튼과 기능이 같을때
    if (AccountButton[vRow][vCol].Hint = AccountButton[vRow][vCol+1].Hint) then
    begin
      AccountButton[vRow][vCol].Width  := AccountButton[vRow][vCol].Width * 2 + Ifthen(vShadow,0,1);
      AccountButton[vRow][vCol+1].Tag    :=1;
      if vRow < High(AccountButton) then
      begin
        if (AccountButton[vRow][vCol].Hint = AccountButton[vRow+1][vCol].Hint) and (AccountButton[vRow+1][vCol].Hint = AccountButton[vRow+1][vCol+1].Hint) then
        begin
          AccountButton[vRow][vCol].Appearance.LayOut := blPictureTop;
          AccountButton[vRow][vCol].Height  := AccountButton[vRow][vCol].Height * 2 + Ifthen(vShadow,0,1);
          AccountButton[vRow][vCol].Tag     := 1;
          AccountButton[vRow+1][vCol].Tag   := 1;
          AccountButton[vRow+1][vCol+1].Tag := 1;
        end
      end;
      AccountButton[vRow][vCol].BringToFront;
      Continue;
    end;
  end;

  //버튼 합치기(세로)
  for vRow := Low(AccountButton) to High(AccountButton)-1 do
    for vCol := Low(AccountButton[vRow]) to High(AccountButton[vRow]) do
  begin
    if (AccountButton[vRow][vCol].Hint = 'XX') or (AccountButton[vRow][vCol].Tag = 1) then Continue;

    //다음버튼과 기능이 같을때
    if Assigned(AccountButton[vRow+1][vCol]) and (AccountButton[vRow][vCol].Hint = AccountButton[vRow+1][vCol].Hint) then
    begin
      AccountButton[vRow][vCol].Appearance.LayOut := blPictureTop;
      AccountButton[vRow][vCol].Height  := AccountButton[vRow][vCol].Height * 2 + Ifthen(vShadow,0,1);
      AccountButton[vRow+1][vCol].Tag   :=1;
      AccountButton[vRow][vCol].BringToFront;
      Continue;
    end;
  end;

  if Assigned(vFont) then vFont.Free;
end;

//그리드에 순번구하기
function TOrder_F.GetGridMenuSeq:Integer;
var vIndex, vMax :Integer;
begin
  vMax := 0;
  for vIndex := 0 to Main_sGrd.RowCount-1 do
    if vMax <= StoI(Main_sGrd.Cells[GDM_SEQ, vIndex]) then
       vMax := StoI(Main_sGrd.Cells[GDM_SEQ, vIndex]) + 1;
  Result := vMax;
end;

//**************************************************************************//
//                          메뉴조회
//**************************************************************************//
function TOrder_F.SelectMenu(aGubun:Integer;aDcMenu:Integer):Boolean;
var nRow, I, vpr_sale_temp, vIndex :Integer;
    vTemp, vMenuCode: String;
    vWeight :Currency;
    vItemAmt :Integer;
    vIsItem :Boolean;
    vIsGridAdd :Boolean;
    vQuery :TUniQuery;
begin
  try
    Result  := false;
    vIsItem := false;
    if (GetOption(235) = '0') and not CheckPresentChange then Exit;

    Common.WriteLog('work', '메뉴주문-'+FMenuCode);
    case aGubun of
      0,2 : //PLU에서 실행 , 보류복원
      begin
        //바코드 스캔시 앞 사용자리 수
        if (Ord(GetOption(415)) > 4) then
          vMenuCode := LeftStr(FMenuCode, Ord(GetOption(415)))
        else
          vMenuCode := Trim(FMenuCode);
      end;
      1 : //저울형메뉴
      begin
        vMenuCode := Copy(FMenuCode,3,4);
      end;
    end;
    InitMenuRecord(Common.Menu);
    try
      vQuery := TUniQuery.Create(Application);
      vQuery.Connection := DM.UniConnection;

      vQuery.SQL.Text :='select t1.CD_MENU, '
                       +'       t1.NM_MENU, '
                       +'       t1.NM_MENU_SHORT, '
                       +'       t1.NM_MENU_KITCHEN, '
                       +'       t1.DS_MENU_TYPE as DS_MENU, '
                       +Ifthen(GetOption(194) = '1', 'GetSalePrice(t1.CD_STORE, t1.CD_MENU) as PR_SALE, ', ' Ifnull(t1.PR_SALE,0) as PR_SALE, ')
                       +'       t1.PR_SALE_DOUBLE, '
                       +'       t1.PR_TIP,'
                       +'       case when t1.PR_SALE_PACKING = 0 then t1.PR_SALE else t1.PR_SALE_PACKING end PR_SALE_PACKING , '
                       +'       t1.PR_SALE - t2.PR_SALE as DC_SPC, '
                       +'       case when t2.CD_MENU is null then '''' '
                       +'  	        else t2.NO_SPC '
                       +'       end as NO_SPC, '
                       +'       t1.DS_TAX, '
                       +'       t1.QTY_SELECT, '
                       +'       t1.CD_PRINTER, '
                       +'       t1.CONFIG, '
                       +'       t1.DS_KITCHEN, '
                       +'       t1.NO_GROUP, '
                       +'       t1.CD_CLASS, '
                       +'       t1.CD_CORNER, '
                       +'       t1.PR_BUY, '
                       +'       t1.PR_SALE_PROFIT, '
                       +'       t1.SAVE_STAMP, '
                       +'       t1.USE_STAMP, '
                       +'       t1.DS_STOCK, '
                       +'       t1.QTY_UNIT, '
                       +'       t1.CONFIG, '
                       +'       case when Ifnull(t1.ORDERTIME_FROM,''00:00'') ='''' then ''00:00'' else Ifnull(t1.ORDERTIME_FROM,''00:00'') end ORDERTIME_FROM, '
                       +'       case when Ifnull(t1.ORDERTIME_TO,''00:00'') ='''' then ''00:00'' else Ifnull(t1.ORDERTIME_TO,''00:00'') end ORDERTIME_TO, '
                       +'       t1.MENU_INFO '
                       +'  from MS_MENU t1 left outer join '
                       +'       ( select Max(b.NO_SPC) as NO_SPC, '
                       +'                a.CD_MENU, '
                       +'                a.PR_SALE '
                       +'  	       from MS_SPC_D a inner join '
                       +'               MS_SPC_H b on a.CD_STORE   = b.CD_STORE '
                       +'                         and a.NO_SPC     = b.NO_SPC '
                       +'          where a.CD_STORE   = :P0 '
                       +'            and b.DT_FROM   <= :P2 '
                       +'            and b.DT_TO     >= :P2 '
                       +'            and b.TIME_FROM <= :P3 '
                       +'            and b.TIME_TO   >= :P3 '
                       +'            and Substring(b.WEEKLY, DAYOFWEEK(Now()), 1) = ''1'' '
                       +'            and b.YN_USE    = ''Y'' '
                       +'            and a.YN_USE    = ''Y'' '
                       +'          group by a.CD_MENU, a.PR_SALE '
                       +'        ) t2 on t1.CD_MENU = t2.CD_MENU '
                       +' where t1.CD_STORE  = :P0 '
                       +'   and t1.CD_MENU   = :P1 '
                       +'   and t1.YN_USE    = ''Y'' ';
      vQuery.ParamByName('P0').AsString := Common.Config.StoreCode;
      vQuery.ParamByName('P1').AsString := vMenuCode;
      vQuery.ParamByName('P2').AsString := Common.Table.Date;
      vQuery.ParamByName('P3').AsString := Common.Table.Time;
      vQuery.Open;

      if vQuery.Eof then
      begin
        InitMenuRecord(Common.Menu);
        Common.Menu.dc_menu := aDcMenu;

        vQuery.Close;
        DisplayMessage(1,'['+vMenuCode+'] 등록되지 않은 메뉴입니다');
        if GetOption(330) = '2' then
          Common.Device.CashBoxOpen(1);

        if (GetOption(330) <> '0') and not Common.Config.IsKiosk then
        begin
          MenuAdd_F := TMenuAdd_F.Create(Self);
          try
            MenuAdd_F.Tag := 2;
            MenuAdd_F.lbl_MenuCode.Caption := vMenuCode;
            MenuAdd_F.isMenuAdd := true;
            MenuAdd_F.ShowModal;
          finally
            FreeAndNil(MenuAdd_F);
            ReDrowGridTitle;
            Common.Device.OnScannerReadData := ScannerReadEvent;
          end;
        end;
        Exit;
      end;

      if (vQuery.FieldByName('ORDERTIME_FROM').AsString <> '00:00') and (vQuery.FieldByName('ORDERTIME_TO').AsString <> '00:00') then
      begin
        if (FormatDateTime('hh:nn', Now()) < vQuery.FieldByName('ORDERTIME_FROM').AsString) or (FormatDateTime('hh:nn', Now()) > vQuery.FieldByName('ORDERTIME_TO').AsString) then
        begin
          vQuery.Close;
          Common.MsgBox('주문가능 시간이 아닙니다');
          Exit;
        end;
      end;

      if Copy(vQuery.FieldByName('CONFIG').AsString,8,1) = 'Y' then
      begin
        vQuery.Close;
        Common.MsgBox('일시 품절 된 메뉴입니다');
        Exit;
      end;

      if (WorkKind = wkPacking) and (Copy(vQuery.FieldByName('CONFIG').AsString,10,1) = 'Y') then
      begin
        vQuery.Close;
        Common.MsgBox('포장할 수 없는 메뉴입니다');
        Exit;
      end;


      Common.Menu.yn_kitchen := Ifthen(isKitchenPrint, 'Y', 'N');
      isKitchenPrint := true;

      //반품일때는 일반상품만 가능하도록 한다
      if (WorkKind = wkRefund) and not (vQuery.FieldByName('ds_menu').AsString[1] in ['N','W','G']) then
      begin
        Common.MsgBox('일반상품과 저울상품만 반품이 가능합니다');
        Exit;
      end;

      Common.Menu.ds_menu    := vQuery.FieldByName('ds_menu').AsString;
      Common.Menu.cd_menu    := Trim(vQuery.FieldByName('cd_menu').AsString);
      Common.Menu.pr_sale    := vQuery.FieldByName('pr_sale').AsInteger;
      Common.Menu.pr_sale_org:= Common.Menu.pr_sale;
      Common.Menu.pr_sale_db := vQuery.FieldByName('pr_sale_double').AsInteger;
      Common.Menu.pr_sale_packing := vQuery.FieldByName('pr_sale_packing').AsInteger;

      //봉사료금액을 사용한다고 했을때
      if GetOption(20) = '1' then
        Common.Menu.pr_tip     := vQuery.FieldByName('pr_tip').AsInteger;
      Common.Menu.yn_person  := Copy(vQuery.FieldByName('config').AsString,4,1);
      Common.Menu.pr_buy     := vQuery.FieldByName('pr_buy').AsInteger;
      Common.Menu.rt_profit  := vQuery.FieldByName('pr_sale_profit').AsCurrency;
      Common.Menu.yn_bill    := Copy(vQuery.FieldByName('config').AsString,5,1);
      Common.Menu.yn_ticket  := Copy(vQuery.FieldByName('config').AsString,7,1);;
      Common.Menu.nm_menu    := IfThen(vQuery.FieldByName('nm_menu_short').AsString = EmptyStr, vQuery.FieldByName('nm_menu').AsString, vQuery.FieldByName('nm_menu_short').AsString);
      Common.Menu.nm_menu_kitchen := vQuery.FieldByName('nm_menu_kitchen').AsString;
      Common.Menu.ds_stock   := vQuery.FieldByName('ds_stock').AsString;
      Common.Menu.qty_unit   := vQuery.FieldByName('qty_unit').AsInteger;
      if Common.KioskVoice and (Common.Menu.ds_menu = 'N') then
        Common.TextToSpeech(Common.Menu.nm_menu+'를 선택하셨습니다.');

      //추가요금 메뉴이면 추가시간을 표시한다
      if Common.Config.OverTimeMenu = Common.Menu.cd_menu then
      begin
        if (Common.Table.LapeTime - Common.Config.OverTimeTime) > 60  then
          vTemp := Format('(%d시간%d분)',[(Common.Table.LapeTime - Common.Config.OverTimeTime) div 60, (Common.Table.LapeTime - Common.Config.OverTimeTime)  mod 60])
        else if (Common.Table.LapeTime - Common.Config.OverTimeTime) > 0  then
          vTemp := Format('(%d분)',[(Common.Table.LapeTime - Common.Config.OverTimeTime)])
        else
          vTemp := EmptyStr;
        Common.Menu.nm_menu := Common.Menu.nm_menu + vTemp;
      end;
      Common.WriteLog('work', '메뉴주문-'+Common.Menu.nm_menu);

      //저울판매의 메뉴주문시
      if (aGubun = 1) and (FMenuName <> EmptyStr) then
        Common.Menu.nm_menu := FMenuName;
      Common.Menu.nm_menu_org:= Common.Menu.nm_menu;

      //주문확인 라벨
      if (aGubun = 0) and (GetOption(300)='0') then
      begin
        Tmr_MenuShow.Enabled  := false;
        OrderMenuLabel.Caption := Common.GetPaPago(Common.Menu.nm_menu);
        if LengthB(OrderMenuLabel.Caption) <= 10 then
          OrderMenuLabel.Style.Font.Size := 60
        else
          OrderMenuLabel.Style.Font.Size := 55 - Length(OrderMenuLabel.Caption);

        Tmr_MenuShow.Enabled  := true;
        OrderMenuLabel.Visible := true;
      end;

      Common.Menu.ds_tax     := vQuery.FieldByName('ds_tax').AsString;
      Common.Menu.ds_tax     := IntToStr(StrToIntDef(Common.Menu.ds_tax,1));
      Common.Menu.no_group   := vQuery.FieldByName('no_group').AsInteger;
      Common.Menu.ds_menu    := vQuery.FieldByName('ds_menu').AsString;
      Common.Menu.cd_class   := vQuery.FieldByName('cd_class').AsString;
      Common.Menu.corner     := vQuery.FieldByName('cd_corner').AsString;
      Common.Menu.save_stamp := vQuery.FieldByName('save_stamp').AsInteger;
      Common.Menu.use_stamp  := vQuery.FieldByName('use_stamp').AsInteger;
      Common.Menu.config     := vQuery.FieldByName('config').AsString;
      Common.Menu.menu_info  := vQuery.FieldByName('menu_info').AsString;
      Common.Menu.qty_select := vQuery.FieldByName('qty_select').AsInteger;

      if GetOption(57) = '1' then
      begin
        For I := 1 to High(ItemData) do
        begin
          ItemData[I].Code  := '';
          ItemData[I].Name  := '';
          ItemData[I].Price := 0;
          ItemData[I].Qty   := 0;
          ItemData[I].PrintMenuName  := '';
        end;
      end;

      //보류복원시에는 아이템 메뉴까지 정해져 있음으로 아이템 메뉴를 자동으로 조회한다
      if (GetOption(57) = '1') and (aGubun = 2) and (FItemCode <> '') then
      begin
        GetItemMenu(FItemCode);
        Common.Menu.ds_menu := 'I';
      end;

      //일반메뉴일때 등록된 아이템메뉴가 있는지 조회한다
      if (GetOption(57) = '1') and (Common.Menu.ds_menu = 'N') and (aGubun <> 2) then
      begin
        OpenQuery('select b.CD_MENU, '
                 +'       b.NM_MENU, '
                 +'       b.NM_MENU_SHORT, '
                 +Ifthen(GetOption(194)='1', ' case when b.DS_TAX = ''2'' then GetSalePrice(b.CD_STORE, b.CD_MENU) * 0.1 + GetSalePrice(b.CD_STORE, b.CD_MENU) else GetSalePrice(b.CD_STORE, b.CD_MENU) end as PR_SALE '
                                            ,' case when b.DS_TAX = ''2'' then b.PR_SALE * 0.1 + b.PR_SALE else b.PR_SALE end as PR_SALE ')
                 +'  from MS_MENU_ITEM a  inner join '
                 +'       MS_MENU      b  on b.CD_STORE = a.CD_STORE and b.CD_MENU = a.CD_ITEM '
                 +' where a.CD_STORE = :P0 '
                 +'   and a.CD_MENU  = :P1 '
                 +'   and b.YN_USE   = ''Y'' '
                 +'   and b.DS_MENU_TYPE = ''I'' '
                 +'order by a.CD_ITEM ',
                 [Common.Config.StoreCode,
                  vMenuCode]);

        if (not Common.Query.Eof) and (aGubun = 2) then
        begin
          if Goods_QtyAdd(true) then
          begin
            WorkKind := wkSale;
            Result   := true;
            Exit;
          end;
        end;
        if not Common.Query.Eof then
        begin
          try
            vIsItem := true;
            if not Assigned(MenuItem_F) then
              MenuItem_F      := TMenuItem_F.Create(Application);

            if not Common.Config.IsKiosk then
            begin
              MenuItem_F.MenuCode := vMenuCode;
              MenuItem_F.MaxCount := Common.Menu.qty_select;
            end
            else
            begin
              if GetOption(35) = '0' then
              begin
                if not Assigned(KioskItem_F) then
                  KioskItem_F      := TKioskItem_F.Create(Application);

                KioskItem_F.MenuCode  := vMenuCode;
                KioskItem_F.MenuPrice := Common.Menu.pr_sale;
              end
              else
              begin
                if not Assigned(KioskItem2_F) then
                  KioskItem2_F      := TKioskItem2_F.Create(Application);

                KioskItem2_F.ButtonHeight := KioskButtonList[0].GroupBox.Height;
                KioskItem2_F.ButtonWidth  := KioskButtonList[0].GroupBox.Width;
                KioskItem2_F.ButtonFont   := KioskPLUMenuPanel.Font;

                KioskItem2_F.MenuCode  := vMenuCode;
                KioskItem2_F.MenuPrice := Common.Menu.pr_sale;
              end;
            end;

            if Common.ShowMenuItemForm then
            begin
              ReDrowGridTitle;
              if not Common.Config.IsKiosk then
              begin
                if MenuItem_F.ItemName <> EmptyStr then // 아이템 선택 없이 확인 눌렀을 경우
                  Common.Menu.ds_menu := 'I'
                else
                  Common.Menu.ds_menu := 'N';

                Common.Menu.pr_item   := MenuItem_F.ItemPrice;
                Common.Menu.pr_sale   := Common.Menu.pr_sale;
                Common.Menu.nm_item   := MenuItem_F.ItemName;
                Common.Menu.cd_item   := MenuItem_F.ItemCode;
              end
              else if GetOption(35) = '0' then
              begin
                if KioskItem_F.ItemName <> EmptyStr then // 아이템 선택 없이 확인 눌렀을 경우
                  Common.Menu.ds_menu := 'I'
                else
                  Common.Menu.ds_menu := 'N';

                Common.Menu.pr_item   := KioskItem_F.ItemPrice;
                Common.Menu.nm_item   := KioskItem_F.ItemName;
                Common.Menu.cd_item   := KioskItem_F.ItemCode;
                RestoreQty            := KioskItem_F.lblQty.Tag;
                FreeAndNil(KioskItem_F);
              end
              else
              begin
                if KioskItem2_F.ItemName <> EmptyStr then // 아이템 선택 없이 확인 눌렀을 경우
                begin
                  Common.Menu.ds_menu    := 'I';
                  Common.Menu.pr_item    := KioskItem2_F.ItemPrice;
                  Common.Menu.nm_item    := KioskItem2_F.ItemName;
                  Common.Menu.cd_item    := KioskItem2_F.ItemCode;
                  RestoreQty := 1;
                end;
              end;
              Common.WriteLog('work',Format(' - 아이템 [ %s,%d ]',[Common.Menu.nm_item,Common.Menu.pr_item]));
            end
            else
            begin
              if Assigned(KioskItem_F) then
                FreeAndNil(KioskItem_F);

              ReDrowGridTitle;
              Exit;
            end;
          except
            on E: Exception do
              Common.WriteLog('아이템메뉴',E.Message);
          end;
        end;
        Common.Query.Close;
      end;

      if bDouble or bRestore then
      begin
        Common.Menu.pr_sale := RestorePrice;
        Common.Menu.pr_sale_org:= Common.Menu.pr_sale;
      end;

      //같은상품있을때 오픈단가메뉴가 아니면 같은메뉴가 있는지 체크
      if ((vQuery.FieldByName('pr_sale').AsInteger > 0 ) and (Common.Menu.ds_menu <> 'W') ) or
         ((vQuery.FieldByName('pr_sale').AsInteger = 0 ) and (Common.Menu.ds_menu <> 'W') ) or
         ((vQuery.FieldByName('pr_sale').AsInteger < 0 ) and (Common.Menu.ds_menu =  'N') ) then
      begin
        if (WorkKind <> wkRefund) and Goods_QtyAdd(aGubun = 2) then
        begin
          WorkKind := wkSale;
          Exit;
        end;
      end;

      Common.Menu.qty_select := vQuery.FieldByName('qty_select').AsInteger;
      Common.Menu.kitchen    := vQuery.FieldByName('cd_printer').AsString;
      MainKitchen := Common.Menu.Kitchen;
      Common.Menu.no_spc     := vQuery.FieldByName('no_spc').AsString;
      Common.Menu.dc_spc     :=  vQuery.FieldByName('dc_spc').AsInteger;
      if (aGubun = 2) and (Common.Menu.dc_spc > 0) and (RestoreQty > 0) then
        Common.Menu.dc_spc := Common.Menu.dc_spc * RestoreQty;

      if (Common.Menu.ds_menu =  'N') and (Common.Menu.qty_select > 1) and (Common.Menu.dc_spc > 0) then
        Common.Menu.dc_spc := Common.Menu.dc_spc div Common.Menu.qty_select;

      if Common.Config.dc_unit > 0 then
        Common.Menu.dc_spc := wyRound(FtoI(Common.Menu.dc_spc), Common.Config.dc_unit);
      Common.Menu.yn_dc      := Copy(vQuery.FieldByName('config').AsString,1,1);
      if (Common.Menu.yn_dc <> 'Y') and (Common.Menu.yn_dc <> 'N') then Common.Menu.yn_dc := 'Y';
      Common.Menu.yn_point   := Copy(vQuery.FieldByName('config').AsString,2,1);
      Common.Menu.yn_point_limit   := Copy(vQuery.FieldByName('config').AsString,9,1);
      Common.Menu.yn_rcp     := Copy(vQuery.FieldByName('config').AsString,3,1);
      Common.Menu.prt_kitchen:= vQuery.FieldByName('ds_kitchen').AsInteger;
      vQuery.Close;
    finally
      vQuery.Free;
    end;

    with Common.Menu do
    begin
      if RestorePrice <> 0  then pr_sale := RestorePrice;
      if RestoreSale <> '' then ds_sale := RestoreSale
      else
      begin
        case WorkKind of
          wkSale    : ds_sale := 'S';
          wkPacking :
          begin
            ds_sale := 'P';
            //3배확대할 때는 (포장)을 붙이지 않는다
            if GetOption(103) <> '3' then
              nm_menu := Common.Config.PackingTxt+nm_menu;
          end;
          wkService :
          begin
            ds_sale := 'D';
            pr_sale_org := pr_sale;
            pr_sale := 0 ;

            For I := 1 to High(ItemData) do
              ItemData[I].Price := 0;

            pr_item := 0;
          end;
          wkRefund :
          begin
            ds_sale := 'S';
          end;
        end;
      end;

      if (WorkKind = wkSale) and (ds_menu <> 'N')  and (ds_menu <> 'W') and (ds_menu <> 'G')and (pr_sale = 0) and (ds_menu <> 'I') and (ds_menu <> 'S') then
      begin
        Common.ErrBox('메뉴단가가 잘못되어 있습니다');
        InitMenuRecord(Common.Menu);
        FMenuCode := EmptyStr;
        Exit;
      end;

      //싯가메뉴일때는 메뉴금액을 입력받는다
      if (WorkKind in [wkSale, wkPacking, wkRefund]) and  (ds_menu = 'G') and (aGubun = 0) and (pr_sale = 0)  then
      begin
        vTemp := Common.ShowNumberForm('메뉴금액을 입력하세요',0,90000000,'0');
        if (vTemp = 'mrClose') or (StoI(vTemp)=0) then
        if pr_sale = 0 then
        begin
           InitMenuRecord(Common.Menu);
           FMenuCode := EmptyStr;
           Exit;
        end;
        pr_sale := StoI(vTemp);
        if Goods_QtyAdd(true) then
        begin
          WorkKind := wkSale;
          Exit;
        end;
      end;

      //중량형 상품이면 금액을 기준으로 중량을 계산한다
      if ((WorkKind = wkSale) or (WorkKind = wkPacking)) and  (ds_menu = 'W') and (aGubun = 0) and (GetOption(433) = '0') then
      begin
        if pr_sale = 0 then
        begin
          Common.ErrBox('메뉴정보에 100g당 판매단가가'+#13+'입력되어 있지 않습니다');
          InitMenuRecord(Common.Menu);
          FMenuCode := EmptyStr;
          Exit;
        end;

        vTemp := Common.ShowNumberForm('메뉴금액을 입력하세요',0,90000000,'0');
        if (vTemp = 'mrClose') or (StoI(vTemp) = 0)then
        begin
           InitMenuRecord(Common.Menu);
           FMenuCode := EmptyStr;
           Exit;
        end;
        vpr_sale_temp := StoI(vTemp);

        if vpr_sale_temp < (pr_sale / 10) then
        begin
          Common.ErrBox('10g 이하 금액으로 판매할 수 없습니다');
          InitMenuRecord(Common.Menu);
          FMenuCode := EmptyStr;
          Exit;
        end;

        pr_sale_std := pr_sale;
        pr_sale     := vpr_sale_temp;
        pr_sale_org := pr_sale;

        FMenuCode := FMenuCode + FormatFloat('00000'  ,hTrunc(pr_sale / IfThen(pr_sale_std=0,1,pr_sale_std), 3) * 100 );
        FMenuCode := FMenuCode + FormatFloat('000000' ,pr_sale );
      end
      else if ((WorkKind = wkSale) or (WorkKind = wkPacking)) and  (ds_menu = 'W') and (aGubun = 0) and (GetOption(433) = '1') then
      begin
        if pr_sale = 0 then
        begin
          Common.ErrBox('메뉴정보에 100g당 판매단가가'+#13+'입력되어 있지 않습니다');
          InitMenuRecord(Common.Menu);
          FMenuCode := EmptyStr;
          Exit;
        end;
        vTemp := Common.ShowNumberForm('중량(g)을 입력하세요',5,0,'0');

        if (vTemp = 'mrClose') or (StoI(vTemp)=0) then
        begin
           InitMenuRecord(Common.Menu);
           FMenuCode := EmptyStr;
           Exit;
        end;

        vWeight := StoI(vTemp);

        if vWeight < 10 then
        begin
          Common.ErrBox('10g 이하 금액으로 판매할 수 없습니다');
          InitMenuRecord(Common.Menu);
          FMenuCode := EmptyStr;
          Exit;
        end;

        pr_sale_std := pr_sale;
        pr_sale   := FtoI(vWeight / 100 * pr_sale);
        qty_sale  := FtoI(vWeight);
        pr_sale_org := pr_sale;
      end
      //저울에서 데이터를 받아서 처리할때는 메뉴정보의 판매단가를 기준판매가에 넣는다
      else if ((WorkKind = wkSale) or (WorkKind = wkPacking)) and  (ds_menu = 'W') and (aGubun = 1) then
      begin
        pr_sale_std := pr_sale;
      end;

        // 키오스크일때 매장이용에 곱빼기단가
      if Common.Config.IsKiosk and (WorkKind = wkSale) then
        pr_sale := pr_sale_org
        //키오스크일때 포장이면
      //포장전용테이블이면서 곱빼기금액을 포장으로 사용할때
      else if (ds_menu <> 'G') and (WorkKind <> wkService) and ((Common.Table.Packing = 'Y') or (WorkKind = wkPacking))  then
        pr_sale := pr_sale_packing;


      //부가세별도 메뉴일때
      if (ds_tax = '2') and (ds_menu <> 'W') then //and (aGubun <> 2) then
      begin
        if GetOption(289) = '0' then
        begin
          pr_sale_tax := FtoI((pr_sale-pr_tip) * 1.1) - (pr_sale-pr_tip);   //메뉴에 부가세
          pr_sale := FtoI((pr_sale-pr_tip) * 1.1)+pr_tip;                   //부가세를 더한다
        end
        else
        begin
          pr_sale_tax := FtoI((pr_sale) * 1.1) - (pr_sale);   //메뉴에 부가세
          pr_sale := FtoI((pr_sale) * 1.1);                   //부가세를 더한다

        end;
        pr_sale_db := FtoI(pr_sale_db * 1.1);                             //곱배기단가에도 부가세를 더한다
      end;

      //순번구하기(코스, 오픈단가메뉴 등)
      seq := GetGridMenuSeq;

      if RestoreQty <> 0 then
      begin
        qty_sale := RestoreQty;
        //매출조회에서 반품으로 했을때는 수량이 0보다 작음
        if RestoreQty < 0 then ds_sale := 'B';
      end
      else qty_sale := 1;

      //일반메뉴이면서 아이템을 사용하지 않을때 기본수량
      if (aGubun = 0) and not visItem and (WorkKind <> wkRefund) and (ds_menu = 'N') and (qty_select > 1) then
      begin
        qty_sale := qty_select;
        pr_sale  := pr_sale div qty_sale;
        pr_sale_std := pr_sale;
      end;

      // 중량형 상품일때는 중량과 단가를 계산후 그리드에 적용한다
      vIsGridAdd := false;
      if ds_menu <> 'W' then
      begin
        //중량형이 아니면서 저울바코드를 읽었을때
        if (aGubun = 1) and ((Length(FMenuCode)=13) or (Length(FMenuCode)=18)) then
        begin
          if Length(FMenuCode)=13 then
            pr_sale  := StoI( Copy(FMenuCode,7,6) )
          else if Length(FMenuCode)=18 then
            pr_sale  := StoI( Copy(FMenuCode,12,6) );
          qty_sale := 1;
        end;

        if WorkKind = wkRefund then
          qty_sale := qty_sale * -1;
        //키오스크일때 코스부메뉴에 단가를 사용할때
  //      if (ds_menu <> 'C') or not Common.Config.IsKiosk or (GetOption(23)='0') then
        if (ds_menu = 'C') and (GetOption(23) = '1') and (RestoreQty = 0) then
          Common.TempMenu := Common.Menu
         else if (RestoreQty > 0) or not (ds_menu[1] in ['C','O','S']) or ((ds_menu = 'C') and ((GetOption(23) = '0') and Common.Config.IsKiosk)) then
         begin
           MainGrid_add;
           vIsGridAdd := true;
         end;
      end;

      nRow := Main_sGrd.Row;
      //코스메뉴이면 상세메뉴를 입력받는다
      if (ds_menu = 'C') and (aGubun <> 2) then
      begin
        //코스부메뉴에 단가를 사용할때
        Common.CourseOrderMenu.Clear;
        Act_Course.Execute;
        if Act_Course.Tag = 0 then
        begin
          if Common.Config.IsKiosk and vIsGridAdd then
          begin
            Goods_QtyDec(Trim(Main_SGrd.Cells[GDM_CD_MENU,Main_SGrd.Row]),
                         Trim(Main_SGrd.Cells[GDM_CD_ITEM,   Main_SGrd.Row]),
                         -1,
                         StoI(Main_SGrd.Cells[GDM_PR_SALE, Main_SGrd.Row]),
                         StoI(Main_SGrd.Cells[GDM_DC_MENU, Main_SGrd.Row]),
                         'Y',
                         'N');
          end;
          Exit;
        end;

        if not Common.Config.IsKiosk and (GetOption(23)='1') then
        begin
          Common.TempMenu.amt_sale := Common.TempMenu.pr_sale;
          vItemAmt := 0;
          for vIndex := 0 to Common.CourseOrderMenu.Count-1 do
          begin
            vItemAmt := vItemAmt + (TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderQty * TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderPrice);
            Common.TempMenu.cd_item  := Common.TempMenu.cd_item +  Format('%s,%d|',[TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).MenuCode, TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderQty]);

            if TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderQty > 1 then
            begin
              if TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderPrice = 0 then
                Common.TempMenu.nm_item  := Common.TempMenu.nm_item + Format('-%s %d개'+#13,[TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).MenuName, TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderQty*Common.Menu.qty_sale])
              else
                Common.TempMenu.nm_item  := Common.TempMenu.nm_item + Format('-%s %d개 (%s원)'+#13,[TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).MenuName, TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderQty*Common.Menu.qty_sale, FormatFloat(',0',TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderPrice)]);
            end
            else
            begin
              if TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderPrice = 0 then
                Common.TempMenu.nm_item  := Common.TempMenu.nm_item + Format('-%s'+#13,[TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).MenuName])
              else
                Common.TempMenu.nm_item  := Common.TempMenu.nm_item + Format('-%s (%s원)'+#13,[TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).MenuName, FormatFloat(',0',TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderPrice)]);
            end;
          end;
          Common.Menu := Common.TempMenu;
          Common.Menu.pr_item := vItemAmt;
          Common.Menu.amt_sale := Common.Menu.amt_sale + vItemAmt;
          MainGrid_add;
          if Common.CourseOrderMenu.Count > 0 then
          begin
            Common.Menu.cd_item := '';
            for vIndex := 0 to Common.CourseOrderMenu.Count-1 do
            begin
              Common.Menu.no_step      := vIndex+1;
              Common.Menu.nm_menu      := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).MenuName;
              Common.Menu.cd_menu1     := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).MenuCode;
              Common.Menu.kitchen      := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).KitchenCode;
              Common.Menu.qty_sale     := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderQty;
              Common.Menu.qty_nepum    := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderQty;
              Common.Menu.pr_sale      := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderPrice;
              Common.Menu.pr_sale_org  := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderPrice;
              Common.Menu.nm_menu_kitchen := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).PrintMenuName;
              Common.Menu.amt_sale     := Common.Menu.qty_sale * Common.Menu.pr_sale;
              Common.Menu.pr_item      := 0;
              Common.Menu.dc_menu      := 0;
              Common.Menu.no_spc       := '';
              Common.Menu.dc_spc       := 0;

              MainGrid_add;
            end;
          end;
          SetRowSelect;
        end
        else if Common.Config.IsKiosk and (GetOption(23)='1') and (Common.CourseOrderMenu.Count > 0) then
        begin
          Common.TempMenu.amt_sale := Common.TempMenu.pr_sale;
          vItemAmt := 0;
          for vIndex := 0 to Common.CourseOrderMenu.Count-1 do
          begin
            vItemAmt := vItemAmt + (TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderQty * TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderPrice);
            Common.TempMenu.cd_item  := Common.TempMenu.cd_item +  Format('%s,%d|',[TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).MenuCode, TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderQty]);
            if  TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderQty > 1 then
            begin
              if TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderPrice = 0 then
                Common.TempMenu.nm_item  := Common.TempMenu.nm_item + Format('-%s %d개'+#13,[TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).MenuName, TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderQty*Common.Menu.qty_sale])
              else
                Common.TempMenu.nm_item  := Common.TempMenu.nm_item + Format('-%s %d개 (%s원)'+#13,[TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).MenuName, TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderQty*Common.Menu.qty_sale, FormatFloat(',0',TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderPrice)]);
            end
            else
            begin
              if TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderPrice = 0 then
                Common.TempMenu.nm_item  := Common.TempMenu.nm_item + Format('-%s'+#13,[TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).MenuName])
              else
                Common.TempMenu.nm_item  := Common.TempMenu.nm_item + Format('-%s (%s원)'+#13,[TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).MenuName, FormatFloat(',0',TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderPrice)]);
            end;
          end;
          Common.Menu := Common.TempMenu;
          Common.Menu.pr_item := vItemAmt;
          Common.Menu.amt_sale := Common.Menu.amt_sale + vItemAmt;
          MainGrid_add;
          Common.Menu.cd_item := '';

          for vIndex := 0 to Common.CourseOrderMenu.Count-1 do
          begin
            Common.Menu.no_step     := vIndex+1;
            Common.Menu.nm_menu     := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).MenuName;
            Common.Menu.cd_menu1    := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).MenuCode;
            Common.Menu.kitchen     := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).KitchenCode;
            Common.Menu.qty_sale    := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderQty;
            Common.Menu.qty_nepum   := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderQty;
            Common.Menu.pr_sale     := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderPrice;
            Common.Menu.pr_sale_org := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderPrice;
            Common.Menu.nm_menu_kitchen := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).PrintMenuName;
            Common.Menu.amt_sale    := Common.Menu.qty_sale * Common.Menu.pr_sale;
            Common.Menu.pr_item     := Common.Menu.pr_sale;
            Common.Menu.dc_menu     := 0;
            Common.Menu.no_spc      := '';
            Common.Menu.dc_spc      := 0;

            MainGrid_add;
          end;
          SetRowSelect;
        end;
      end
      else if (ds_menu = 'O') and (aGubun <> 2) then
        Act_OpenSet.Execute
      else if (ds_menu = 'W') then //(aGubun = 2)) then
      begin
        //저울형일때 13자리는 6자리+6자리+체크비트
        if aGubun <> 0 then
        begin
          case Length(FMenuCode) of
            13 :
            begin
              pr_sale  := StoI( Copy(FMenuCode,7,6) );
              qty_sale := FtoI( hTrunc(pr_sale / IfThen(pr_sale_std=0,1,pr_sale_std), 3)*100 );
            end;
            18  :
            begin
              qty_sale := StoI( Copy(FMenuCode, 7, 5));
              //중량이 0일때
              if qty_sale = 0 then
              begin
                qty_sale := FtoI( hTrunc(pr_sale / IfThen(pr_sale_std=0,1,pr_sale_std), 3)*100 );
              end;
              //100g단가
              pr_sale_org := FtoI(StoI( Copy(FMenuCode,12, 6)) / qty_sale * 100);
              pr_sale  := StoI( Copy(FMenuCode,12, 6));

              //100g단가가 총금액보다 클때는 100g단가를 총금액으로 변경한다
              if pr_sale_org > pr_sale then
                pr_sale_org := pr_sale;
            end;
          end;
        end
        else qty_sale := FtoI( hTrunc(pr_sale / IfThen(pr_sale_std=0,1,pr_sale_std), 3)*100 );

        if WorkKind = wkRefund then
          qty_sale := qty_sale * -1;
        MainGrid_add;
      end
      //세트메뉴일때 구성메뉴를 가져온다
      else if ds_menu = 'S' then
      begin
        OpenQuery('select t1.CD_MENU_SET, '
                 +'       t2.NM_MENU, '
                 +'       t1.QTY_SET, '
                 +'       t2.CD_PRINTER '
                 +'  from MS_MENU_SET t1 left outer join '
                 +'       MS_MENU     t2 on t1.CD_STORE     = t2.CD_STORE '
                 +'                     and t1.CD_MENU_SET  = t2.CD_MENU '
                 +' where t1.CD_STORE     =:P0 '
                 +'   and t1.CD_MENU      =:P1 '
                 +'   and t2.YN_USE       = ''Y'' '
                 +' order by t1.SEQ ',
                 [Common.Config.StoreCode,
                  cd_menu]);
        cd_item := '';
        while not Common.Query.Eof do
        begin
          cd_item := cd_item + Format('%s,%d|',[Common.Query.FieldByName('cd_menu_set').AsString,Common.Query.FieldByName('qty_set').AsInteger]);
          Common.Query.Next;
        end;
        MainGrid_add;
        cd_item := '';

        Common.Query.First;
        while not Common.Query.Eof do
        begin
          cd_menu1  := Common.Query.FieldByName('cd_menu_set').AsString;
          nm_menu   := Common.Query.FieldByName('nm_menu').AsString;
          qty_nepum := Common.Query.FieldByName('qty_set').AsInteger;
          kitchen   := Ifthen(GetOption(241)='1', Common.Query.FieldByName('cd_printer').AsString, MainKitchen);
          no_step   := no_step + 1;
          pr_sale   := 0;
          dc_spc    := 0;
          no_spc    := '';
          pr_sale_org := pr_sale;
          MainGrid_add;
          Common.Query.Next;
        end;
        Common.Query.Close;
        Main_sGrd.Row := nRow;
      end
      else if cd_item <> '' then
      begin
        For I := 1 to High(ItemData) do
        begin
          if ItemData[I].Code = '' then Continue;
          cd_item   := '';
          cd_menu1  := ItemData[I].Code;
          nm_menu   := ItemData[I].Name;
          qty_nepum := ItemData[I].Qty;
          no_step   := no_step + 1;
          pr_sale   := ItemData[I].Price;
          nm_menu_kitchen := ItemData[I].PrintMenuName;
          pr_item   := 0;
          pr_tip    := 0;
          dc_spc    := 0;
          no_spc    := '';
          pr_sale_org := pr_sale;
          MainGrid_add;
        end;
        Main_sGrd.Row := nRow;
      end;
    end;
    Result   := true;
    //메뉴레코드 초기화
    InitMenuRecord(Common.Menu);
    WorkState := wsSale;
    WorkKind  := wkSale;
    //키오스크시 코스메뉴 주문시 수량을 2이상으로 했을때
    if Common.Config.IsKiosk and (Common.CourseOrderMenu.Count > 0) and (KioskCourseQty > 1) then
    begin
      Main_sGrd.Row := KioskCourseRow;
      Goods_QtyDec(Trim(Main_sGrd.Cells[GDM_CD_MENU,  KioskCourseRow]),
                   Trim(Main_sGrd.Cells[GDM_CD_ITEM,  KioskCourseRow]),
                   KioskCourseQty-1,
                   StoI(Main_sGrd.Cells[GDM_PR_SALE, KioskCourseRow]),
                   StoI(Main_sGrd.Cells[GDM_DC_MENU, KioskCourseRow]),
                   'Y',
                   'N');
      KioskCourseQty := 0;
    end;
  finally
    RestoreQty := 0;
  end;
end;

procedure TOrder_F.SetOrderMenu(aTable:Integer;aOrderType:String;aCashOrder:Boolean);
  function GetDutchPayMenu(aMenu, aSeq:String):Integer;
  var vIndex :Integer;
  begin
    Result := -1;
    For vIndex := 0 to Common.DuthPay_sGrd.RowCount-1 do
    begin
      if (Common.DuthPay_sGrd.Cells[4, vIndex] = aMenu) and (Common.DuthPay_sGrd.Cells[5, vIndex] = aSeq) then
      begin
        Result := vIndex;
        Break;
      end;
    end;
  end;
var vRow :Integer;
    vQuery :TUniQuery;
    vStoreCode :String;
label CASHORDER;
begin
  try
    vQuery := TUniQuery.Create(Application);
    vQuery.Connection := DM.UniConnection;
    vStoreCode := Common.Config.StoreCode;

    CASHORDER:
    //기존주문내역을 불러온다
    with Main_sGrd, Common.PreSent, Common do
    begin
      vQuery.SQL.Text := 'select  a.CD_MENU, '
                        +'      	a.NM_MENU, '
                        +'        b.NM_MENU_KITCHEN, '
                        +'      	a.DS_MENU_TYPE, '
                        +'      	a.NO_STEP, '
                        +'      	a.CD_MENU1, '
                        +'      	a.SEQ, '
                        +'      	a.PR_SALE, '
                        +'        case when b.PR_SALE_PACKING = 0 then b.PR_SALE else b.PR_SALE_PACKING end PR_SALE_PACKING , '
                        +'      	a.QTY_ORDER, '
                        +'      	a.AMT_ORDER, '
                        +'        a.PR_ITEM, '
                        +'        a.CD_ITEM, '
                        +'        a.DS_SALE, '
                        +'        b.PR_TIP, '
                        +'        a.DS_TAX, '
                        +'        a.QTY_NEPUM, '
                        +'        b.CONFIG, '
                        +'        b.CD_PRINTER, '
                        +'        Date_Format(a.DT_CHANGE, ''%Y%m%d%H%i'') as DT_ORDER, '
                        +'        a.NO_SPC, '
                        +'        a.DC_SPC, '
                        +'        a.DC_MENU, '
                        +'        a.MEMO, '
                        +'        b.DS_KITCHEN, '
                        +'        b.NO_GROUP, '
                        +'        b.PR_SALE_DOUBLE, '
                        +'        a.PR_SALE_ORG, '
                        +'        Left(b.CD_CLASS, 2) as CD_CLASS, '
                        +'        b.CD_CORNER, '
                        +'        a.YN_DOUBLE, '
                        +'        b.PR_BUY, '
                        +'        b.PR_SALE_PROFIT, '
                        +'        a.CD_SERVICE, '
                        +'        b.SAVE_STAMP, '
                        +'        b.USE_STAMP '
                        +'  from SL_ORDER_D a  inner join '
                        +'       MS_MENU    b  on b.CD_STORE = :P3 '
                        +' 	                  and b.CD_MENU  = a.CD_MENU '
                        +' where a.CD_STORE =:P0 '
                        +'   and a.NO_TABLE =:P1 '
                        +'   and a.DS_ORDER =:P2 '
                        +Ifthen(GetOption(164) = '0', 'order by a.SEQ', 'order by b.BILL_SEQ, a.CD_MENU');
      vQuery.ParamByName('P0').AsString  := vStoreCode;
      vQuery.ParamByName('P1').AsInteger := aTable;
      vQuery.ParamByName('P2').AsString  := aOrderType;
      vQuery.ParamByName('P3').AsString  := Common.Config.StoreCode;
      vQuery.Open;

      while not vQuery.Eof do
      begin
        //더치페이일때 메뉴를 체크한다
        if Common.OrderKind in [okDutchPay,okDutchPayEnd] then
        begin
          vRow := GetDutchPayMenu(vQuery.FieldByName('CD_MENU').AsString,
                                  vQuery.FieldByName('SEQ').AsString);
          if vRow = -1 then
          begin
            vQuery.Next;
            Continue;
          end;
        end;
        InitMenuRecord(Common.Menu);
        Menu.cd_menu     := vQuery.FieldByName('CD_MENU').AsString;
        Menu.nm_menu     := vQuery.FieldByName('NM_MENU').AsString;
        Menu.nm_menu_kitchen := vQuery.FieldByName('NM_MENU_KITCHEN').AsString;
        Menu.ds_menu     := vQuery.FieldByName('DS_MENU_TYPE').AsString;
        Menu.no_step     := vQuery.FieldByName('NO_STEP').AsInteger;
        Menu.cd_menu1    := vQuery.FieldByName('CD_MENU1').AsString;
        Menu.seq         := vQuery.FieldByName('SEQ').AsInteger;
        Menu.pr_sale     := vQuery.FieldByName('PR_SALE').AsInteger;    //상품단가
        Menu.pr_sale_packing   := vQuery.FieldByName('PR_SALE_PACKING').AsInteger;    //상품단가
        Menu.pr_sale_org := Menu.pr_sale;
        Menu.pr_tip      := vQuery.FieldByName('PR_TIP').AsInteger;    //상품단가
        Menu.qty_nepum   := vQuery.FieldByName('QTY_NEPUM').AsInteger;
        if Common.OrderKind in [okDutchPay,okDutchPayEnd] then
          Menu.qty_sale  := StoI( Common.DuthPay_sGrd.Cells[7, vRow])
        else
          Menu.qty_sale  := vQuery.FieldByName('QTY_ORDER').AsInteger;
        Menu.Ds_Sale     := vQuery.FieldByName('DS_SALE').AsString;    //매출구분
        Menu.ds_tax      := vQuery.FieldByName('DS_TAX').AsString;
        Menu.kitchen     := vQuery.FieldByName('CD_PRINTER').AsString; //

        //부메뉴 설정 주방으로 출력시
        if (GetOption(241) = '1') and (Menu.cd_menu1 <> '') then
        begin
          DM.OpenQuery('select CD_PRINTER '
                      +'  from MS_MENU '
                      +' where CD_STORE =:P0 '
                      +'   and CD_MENU  =:P1 ',
                      [Common.Config.StoreCode,
                       Menu.cd_menu1]);
          if not DM.Query.Eof then
            Menu.kitchen     := DM.Query.FieldByName('CD_PRINTER').AsString;

          DM.Query.Close;
        end;

        Menu.no_spc      := vQuery.FieldByName('NO_SPC').AsString;     //행사번호
        Menu.dc_spc      := vQuery.FieldByName('DC_SPC').AsInteger;
        Menu.dc_menu     := vQuery.FieldByName('DC_MENU').AsInteger;
        Menu.memo        := vQuery.FieldByName('MEMO').AsString;     //행사번호
        Menu.dt_order    := vQuery.FieldByName('DT_ORDER').AsString; //주문시간
        Menu.yn_order    := Ifthen(vStoreCode = 'CASHTEMP','N','Y');
        Menu.yn_dc       := Copy(vQuery.FieldByName('CONFIG').AsString,1,1);     //할인여부
        Menu.yn_point    := Copy(vQuery.FieldByName('CONFIG').AsString,2,1);  //포인트적립여부
        Menu.yn_point_limit    := Copy(vQuery.FieldByName('CONFIG').AsString,9,1);  //
        Menu.yn_rcp      := Copy(vQuery.FieldByName('CONFIG').AsString,3,1);
        Menu.prt_kitchen := vQuery.FieldByName('DS_KITCHEN').AsInteger;
        Menu.no_group    := vQuery.FieldByName('NO_GROUP').AsInteger;
        Menu.pr_sale_db  := vQuery.FieldByName('PR_SALE_DOUBLE').AsInteger;
        Menu.pr_sale_org := vQuery.FieldByName('PR_SALE_ORG').AsInteger;
        Menu.pr_tip      := vQuery.FieldByName('PR_TIP').AsInteger;
        Menu.pr_item     := vQuery.FieldByName('PR_ITEM').AsInteger;
        Menu.cd_item     := vQuery.FieldByName('CD_ITEM').AsString;
        GetItemMenu(Menu.cd_item);
        Menu.cd_class    := vQuery.FieldByName('CD_CLASS').AsString;
        Menu.corner      := vQuery.FieldByName('CD_CORNER').AsString;
        Menu.change      := 'N';
        Menu.yn_double   := vQuery.FieldByName('YN_DOUBLE').AsString;
        Menu.yn_person   := Copy(vQuery.FieldByName('CONFIG').AsString,4,1);
        Menu.pr_buy      := vQuery.FieldByName('PR_BUY').AsInteger;
        Menu.rt_profit   := vQuery.FieldByName('PR_SALE_PROFIT').AsCurrency;
        Menu.cd_service  := vQuery.FieldByName('CD_SERVICE').AsString;
        Menu.yn_bill     := Copy(vQuery.FieldByName('CONFIG').AsString,5,1);
        Menu.yn_ticket   := Copy(vQuery.FieldByName('CONFIG').AsString,7,1);
        Menu.save_stamp  := vQuery.FieldByName('SAVE_STAMP').AsInteger;
        Menu.use_stamp   := vQuery.FieldByName('USE_STAMP').AsInteger;
        Menu.config      := vQuery.FieldByName('CONFIG').AsString;
        Menu.yn_cashtemp := Ifthen(vStoreCode = 'CASHTEMP','Y','N');
        if Common.Table.Number = aTable then
          MainGrid_add
        else
          MainGrid_add(Common.Group_sGrd);
        vQuery.Next;
      end;
      vQuery.Close;
    end;
    if aCashOrder and Common.Table.isCashOrder and (vStoreCode <> 'CASHTEMP') then
    begin
      vStoreCode := 'CASHTEMP';
      goto CASHORDER;
    end;
  finally
    vQuery.Close;
    vQuery.Free;
  end;
end;

//**************************************************************************//
//                       메인그리드에 추가
//**************************************************************************//
procedure TOrder_F.MainGrid_add(aGrid:TStringGrid);
var nQty :Integer;
begin
  if aGrid = nil then
    aGrid := Main_SGrd;
  {화면출력용 그리드에 Row추가}
  with aGrid do
  begin
    if Cells[0,0] <> '' then RowCount := RowCount + 1;
    if Common.Menu.no_step > 0 then Cells[GDM_NO         ,RowCount-1] := ''
    else                            Cells[GDM_NO         ,RowCount-1] := IntToStr(RowCount); //순번
    Cells[GDM_CD_MENU    ,RowCount-1] := Common.Menu.cd_menu;              //상품명
    Cells[GDM_NM_MENU    ,RowCount-1] := Common.Menu.nm_menu;              //상품명
    Cells[GDM_NM_MENU_KITCHEN  ,RowCount-1] := Common.Menu.nm_menu_kitchen;              //주방출력용
    if (Common.Menu.Ds_Sale = 'D') and (Common.Menu.no_step = 0) then
      Cells[GDM_NM_MENU    ,RowCount-1] := Cells[GDM_NM_MENU    ,RowCount-1] + Common.Config.ServiceTxt;
    if Common.Menu.ds_menu = 'N' then                                      //메뉴구분
      Cells[GDM_TYPE       ,RowCount-1] :=''
    else if (Common.Menu.ds_menu = 'W') then
      Cells[GDM_TYPE       ,RowCount-1] := 'ⓦ'
    else if (Common.Menu.ds_menu = 'S') and (Common.Menu.no_step = 0) then
      Cells[GDM_TYPE       ,RowCount-1] := 'ⓢ'
    else if (Common.Menu.ds_menu = 'S') and (Common.Menu.no_step > 0) then
      Cells[GDM_TYPE       ,RowCount-1] := '-'
    else if (Common.Menu.ds_menu = 'I') and (Common.Menu.no_step = 0) then
      Cells[GDM_TYPE       ,RowCount-1] := 'ⓘ'
    else if (Common.Menu.ds_menu = 'I') and (Common.Menu.no_step > 0) then
      Cells[GDM_TYPE       ,RowCount-1] := '-'
    else if (Common.Menu.ds_menu = 'O') and (Common.Menu.no_step > 0) then
      Cells[GDM_TYPE       ,RowCount-1] := '-'
    else if (Common.Menu.ds_menu = 'O') and (Common.Menu.no_step = 0) then
      Cells[GDM_TYPE       ,RowCount-1] := 'ⓞ'
    else if (Common.Menu.ds_menu = 'C') and (Common.Menu.no_step = 0) then
      Cells[GDM_TYPE       ,RowCount-1] := 'ⓒ'
    else if (Common.Menu.ds_menu = 'C') and (Common.Menu.no_step > 0) then
      Cells[GDM_TYPE       ,RowCount-1] := '-'
    else if (Common.Menu.ds_menu = 'G') and (Common.Menu.no_step = 0) then
      Cells[GDM_TYPE       ,RowCount-1] := 'ⓖ'
    else Cells[GDM_TYPE       ,RowCount-1] := IntToStr(Common.Menu.no_step);

    Cells[GDM_DS_MENU    ,RowCount-1] := Common.Menu.ds_menu;
    Cells[GDM_CD_MENU1   ,RowCount-1] := Common.Menu.cd_menu1;             //상품명
    Cells[GDM_SEQ        ,RowCount-1] := FToS(Common.Menu.seq);
    Cells[GDM_NO_STEP    ,RowCount-1] := FToS(Common.Menu.no_step);        //코스단계
    Cells[GDM_PR_SALE    ,RowCount-1] := FToS(Common.Menu.pr_sale);        //상품단가
    Cells[GDM_PR_SALE_ORG,RowCount-1] := FToS(Common.Menu.pr_sale_org);    //상품단가
    Cells[GDM_PR_SALE_DB ,RowCount-1] := FToS(Common.Menu.pr_sale_db);     //상품단가(곱빼기)
    Cells[GDM_PR_SALE_PACKING, RowCount-1] := FToS(Common.Menu.pr_sale_packing);     //상품단가(곱빼기)
    if (Common.Menu.qty_nepum > 1) and (Common.Menu.qty_sale = 1) then
      nQty := Common.Menu.qty_nepum
    else
      nQty := Common.Menu.qty_sale;
    Cells[GDM_VIEWQTY    ,RowCount-1] := Common.GetQtyReplace(Common.Menu.ds_menu, FtoS(nQty));                       //상품수량
    Cells[GDM_QTY        ,RowCount-1] := FtoS(nQty);                       //상품수량
    Cells[GDM_DC_MENU    ,RowCount-1] := IntToStr(Common.Menu.dc_menu);                              //메뉴할인
    if Common.Menu.ds_menu = 'W' then
    begin
      Cells[GDM_VIEWPRICE  ,RowCount-1] := FToS(Common.Menu.pr_sale_org);    //상품단가
      if Common.Menu.cd_menu1 = '' then
        Cells[GDM_AMT        ,RowCount-1] := FloatToStr(Common.Menu.pr_sale + Common.Menu.pr_item)  //금액
      else
        Cells[GDM_AMT        ,RowCount-1] := '0';
    end
    else
    begin
      Cells[GDM_VIEWPRICE  ,RowCount-1] := FToS(Common.Menu.pr_sale);    //상품단가
      if (Common.Menu.cd_menu1 = '') and ((Common.Menu.Ds_Sale = 'S') or (Common.Menu.Ds_Sale = 'P'))  then
        Cells[GDM_AMT        ,RowCount-1] := FloatToStr(nQty*(Common.Menu.pr_sale + Common.Menu.pr_item))  //금액
      else
        Cells[GDM_AMT        ,RowCount-1] := '0';
    end;
    Cells[GDM_DS_SALE    ,RowCount-1] := Common.Menu.Ds_Sale;              //매출구분
    Cells[GDM_DS_TAX     ,RowCount-1] := Common.Menu.ds_tax;               //세무구분
    Cells[GDM_YN_ORDER   ,RowCount-1] := 'N';                              //주문여부
    Cells[GDM_NEPUM      ,RowCount-1] := IntToStr(Common.Menu.qty_nepum);  //세트메뉴 구성수량
    Cells[GDM_KITCHEN    ,RowCount-1] := Common.Menu.kitchen;              //주방프린터
    Cells[GDM_NO_SPC     ,RowCount-1] := Common.Menu.no_spc;               //행사번호
    Cells[GDM_DC_SPC     ,RowCount-1] := IntToStr(Common.Menu.dc_spc);     //행사할인금액
    Cells[GDM_DT_ORDER   ,RowCount-1] := Common.Menu.dt_order;             //주문시간
    Cells[GDM_YN_ORDER   ,RowCount-1] := Common.Menu.yn_order;             //주방주문여부
    Cells[GDM_MEMO       ,RowCount-1] := Common.Menu.memo;                 //주방메모
    Cells[GDM_YN_DC      ,RowCount-1] := Common.Menu.yn_dc;                //할인여부
    Cells[GDM_YN_POINT   ,RowCount-1] := Common.Menu.yn_point;             //포인트적용여부
    Cells[GDM_YN_POINT_LIMIT   ,RowCount-1] := Common.Menu.yn_point_limit;             //포인트적용여부
    Cells[GDM_YN_RCP     ,RowCount-1] := Common.Menu.yn_rcp;               //영수증출력여부
    Cells[GDM_PRT_KITCHEN,RowCount-1] := IntToStr(Common.Menu.prt_kitchen);//
    Cells[GDM_NO_GROUP,   RowCount-1] := IntToStr(Common.Menu.no_group);   //메뉴그룹
    Cells[GDM_NM_MENU_ORG,RowCount-1] := Common.Menu.nm_menu_org;          //메뉴원래명
    Cells[GDM_CD_ITEM,    RowCount-1] := Common.Menu.cd_item;              //아이템코드
    Cells[GDM_NM_ITEM,    RowCount-1] := Common.Menu.nm_item;              //아이템명
    Cells[GDM_CHANGE,     RowCount-1] := Common.Menu.Change;               //변경여부
    Cells[GDM_TIP,        RowCount-1] := IntToStr(Common.Menu.pr_tip);     //봉사료
    Cells[GDM_PR_ITEM,    RowCount-1] := IntToStr(Common.Menu.pr_item);    //아이템금액
    Cells[GDM_CD_CLASS,   RowCount-1] := Common.Menu.cd_class;
    Cells[GDM_CORNER,     RowCount-1] := Common.Menu.corner;                //코너코드
    Cells[GDM_YN_DOUBLE,  RowCount-1] := Common.Menu.yn_double;             //곱빼기여부
    Cells[GDM_YN_PERSON,  RowCount-1] := Common.Menu.yn_person;             //고객수 추정메뉴
    Cells[GDM_PR_BUY,     RowCount-1] := IntToStr(Common.Menu.pr_buy);      //매입단가
    Cells[GDM_RT_PROFIT,  RowCount-1] := FtoS(Common.Menu.rt_profit);       //이익률
    Cells[GDM_CD_SERVICE, RowCount-1] := Common.Menu.cd_service;            //서비스사유
    Cells[GDM_YN_BILL,    RowCount-1] := Ifthen(Common.Menu.yn_bill='','Y',Common.Menu.yn_bill);  //고객주문서 출력여부
    Cells[GDM_YN_KITCHEN, RowCount-1] := Ifthen(Common.Menu.yn_kitchen='','Y',Common.Menu.yn_kitchen);  //주방주문서 출력여부
    Cells[GDM_YN_TICKET,  RowCount-1] := Ifthen(Common.Menu.yn_ticket='','N',Common.Menu.yn_ticket);  //식권 출력여부
    Cells[GDM_SAVE_STAMP_M, RowCount-1] := IntToStr(Common.Menu.Save_Stamp);
    Cells[GDM_USE_STAMP_M,  RowCount-1] := IntToStr(Common.Menu.Use_Stamp);
    Cells[GDM_DS_STOCK,   RowCount-1] := Common.Menu.ds_stock;
    Cells[GDM_QTY_UNIT,   RowCount-1] := IntToStr(Common.Menu.qty_unit);
    Cells[GDM_CONFIG,     RowCount-1] := Common.Menu.config;
    Cells[GDM_YN_CASHTEMP,RowCount-1] := Common.Menu.yn_cashtemp;
    Cells[GDM_QTY_SELECT, RowCount-1] := IntToStr(Common.Menu.qty_select);

    if aGrid = GroupOrder_sGrd then Exit;

    if aGrid = Main_SGrd then
      Cells[GDM_TABLENO, RowCount-1] := IntToStr(Common.Table.Number)
    else
      Cells[GDM_TABLENO, RowCount-1] := Ifthen(GetOption(25)='1', aGrid.Hint, IntToStr(aGrid.Tag));

    if Common.Menu.memo <> '' then
      Cells[GDM_NM_MENU,  RowCount-1] := Cells[GDM_NM_MENU,  RowCount-1] + Common.Menu.memo;
    Row := RowCount-1;

    if (Common.Menu.ds_menu ='N') or (Common.Menu.ds_menu ='P') or (Common.Menu.no_step = 0) then
    SetRowNumber;
    if aGrid = Main_SGrd then
      SummaryGrid_ItemAdd(Cells[GDM_QTY, RowCount-1])
    else if Common.Menu.cd_menu1 = '' then
    begin
      if Common.Menu.ds_menu = 'W' then
        Common.Table.GroupAmt := Common.Table.GroupAmt + (Common.Menu.pr_sale + Ifthen(Common.Menu.ds_sale='D',0, Common.Menu.pr_item))
      else
        Common.Table.GroupAmt := Common.Table.GroupAmt + (nQty * (Common.Menu.pr_sale + Ifthen(Common.Menu.ds_sale='D',0, Common.Menu.pr_item) - Common.Menu.dc_spc - Common.Menu.dc_menu));
    end;
  end;
end;

//**************************************************************************//
//                       집계그리드에 적용
//**************************************************************************//
procedure TOrder_F.SummaryGrid_ItemAdd(vQty:String);
var
  Cnt, AddRow : integer;
begin
   AddRow := -1;
   {Summary 그리드에 Row추가}
   with Common.Summary_sGrd, Common.Menu do
   begin
      if cd_menu1 <> '' then Exit;
        //이미 등록되어 있는지 체크 (수량도 같은 양수 또는 음수)
        for Cnt := 0 to RowCount-1 do
           if (Cells[GDM_CD_MENU,Cnt] = cd_menu)
              and ( ((StoF(Cells[GDM_QTY,Cnt]) > 0) and (qty_Sale > 0))
                   or ((StoF(Cells[GDM_QTY,Cnt]) < 0) and (qty_Sale < 0)) )
              and (StoF(Cells[GDM_PR_SALE,Cnt]) = pr_sale)
              and (Cells[GDM_DS_SALE,Cnt] = ds_Sale)
              and (Cells[GDM_CD_ITEM,  Cnt] = cd_item)
              and (Cells[GDM_DS_MENU,Cnt] <> 'W')
              and (StoI(Cells[GDM_DC_MENU, Cnt]) = dc_menu)
           then AddRow := Cnt;

      //상품 처음 입력
      if AddRow = -1 then
      begin
         if Cells[GDM_CD_MENU,0] <> '' then RowCount := RowCount + 1;
         AddRow := RowCount-1 ;

         Cells[GDM_NO         ,AddRow] := IntToStr(AddRow+1);  //순번
         Cells[GDM_CD_MENU    ,AddRow] := cd_menu;             //메뉴코드
         Cells[GDM_NM_MENU    ,AddRow] := nm_menu;             //메뉴명
         Cells[GDM_NM_MENU_KITCHEN    ,AddRow] := nm_menu_kitchen;             //메뉴명
         Cells[GDM_PR_SALE    ,AddRow] := FToS(pr_sale);       //메뉴단가
         if ds_menu = 'W' then
           Cells[GDM_VIEWPRICE  ,AddRow] := FToS(pr_sale_org)       //메뉴단가
         else
           Cells[GDM_VIEWPRICE  ,AddRow] := FToS(pr_sale);       //메뉴단가

         Cells[GDM_PR_SALE_ORG,AddRow] := FToS(pr_sale_org);   //메뉴단가
         Cells[GDM_PR_SALE_DB ,AddRow] := FToS(pr_sale_db);    //메뉴단가
         Cells[GDM_PR_SALE_PACKING ,AddRow] := FToS(pr_sale_packing);    //메뉴단가
         Cells[GDM_NO_STEP    ,AddRow] := FToS(no_step);       //코스단계
         Cells[GDM_VIEWQTY    ,AddRow] := Common.GetQtyReplace(ds_menu, vQty);    //상품수량
         Cells[GDM_AMT        ,AddRow] := '0';                 //금액
         Cells[GDM_DS_SALE    ,AddRow] := Ds_Sale;             //포스매출구분
         Cells[GDM_DS_MENU    ,AddRow] := ds_menu;             //메뉴구분
         Cells[GDM_DS_TAX     ,AddRow] := ds_tax;              //세무구분
         Cells[GDM_DC_MENU    ,AddRow] := FtoS(dc_Menu);       //단품할인금액
         Cells[GDM_DC_SPC     ,AddRow] := FtoS(dc_spc);        //단품할인금액
         Cells[GDM_NO_SPC     ,AddRow] := no_spc;              //단품할인금액
         Cells[GDM_NEPUM      ,AddRow] := FtoS(qty_nepum);     //세트구성수량
         Cells[GDM_NO_SPC     ,AddRow] := no_spc;              //행사번호
         Cells[GDM_DC_SPC     ,AddRow] := IntToStr(dc_spc);    //행사할인금액
         Cells[GDM_DC_RECEIPT ,AddRow] := '0';                 //영수증할인금액
         Cells[GDM_QTY        ,AddRow] := '0';                 //상품수량
         Cells[GDM_YN_DC      ,AddRow] := yn_dc;               //할인여부
         Cells[GDM_YN_POINT   ,AddRow] := yn_point;            //포인트적립여부
         Cells[GDM_YN_POINT_LIMIT   ,AddRow] := yn_point_limit;            //포인트적립여부
         Cells[GDM_YN_RCP     ,AddRow] := yn_rcp;              //영수증출력여부
         Cells[GDM_PRT_KITCHEN,AddRow] := IntToStr(prt_kitchen);
         Cells[GDM_NO_GROUP,   AddRow] := IntToStr(no_group);
         Cells[GDM_NM_MENU_ORG,AddRow] := nm_menu_org;         //메뉴원래명
         Cells[GDM_CD_ITEM,    AddRow] := cd_item;             //이이템코드
         Cells[GDM_NM_ITEM,    AddRow] := nm_item;             //이이템명
         Cells[GDM_CHANGE,     AddRow] := Change;              //변경여부
         Cells[GDM_TIP,        AddRow] := IntToStr(pr_tip);    //봉사료
         Cells[GDM_PR_ITEM,    AddRow] := IntToStr(pr_item);   //아이템금액
         Cells[GDM_CD_CLASS,   AddRow] := cd_class;
         Cells[GDM_CORNER,     AddRow] := corner;
         Cells[GDM_YN_DOUBLE,  AddRow] := yn_double;
         Cells[GDM_YN_PERSON,  AddRow] := yn_person;
         Cells[GDM_PR_BUY,     AddRow] := IntToStr(pr_buy);
         Cells[GDM_RT_PROFIT,  AddRow] := FtoS(rt_profit);
         Cells[GDM_CD_SERVICE,  AddRow] := cd_service;
         Cells[GDM_YN_BILL,     AddRow] := yn_bill;
         Cells[GDM_YN_TICKET,   AddRow] := yn_ticket;
         Cells[GDM_SAVE_STAMP_M,  AddRow] := IntToStr(save_stamp);
         Cells[GDM_USE_STAMP_M,   AddRow] := IntToStr(use_stamp);
         Cells[GDM_DS_STOCK,    AddRow] := ds_stock;
         Cells[GDM_QTY_UNIT,   AddRow] := IntToStr(qty_unit);
      end;

      Row := AddRow;

      AmtReCompute(StoI(vQty), Row);
   end;//with Common.Summary_sGrd do
end;

procedure TOrder_F.AmtReCompute(aQty, aRow: integer);
begin
  with Common.Summary_sGrd, Common.PreSent, Common do
  begin
    //수량변경
    Cells[GDM_QTY, ARow] := FtoS(StoI(Cells[GDM_QTY,ARow]) + aQty);

    //금액변경
    if Cells[GDM_DS_MENU,ARow] = 'W' then
    begin
      if aQty > 0 then
        Cells[GDM_AMT, aRow] := Cells[GDM_PR_SALE,aRow]
      else
      begin
        Cells[GDM_AMT, ARow]     := '-'+Cells[GDM_PR_SALE,aRow];
        Cells[GDM_PR_SALE, ARow] := '-'+Cells[GDM_PR_SALE,aRow];
      end;
    end
    else
      Cells[GDM_AMT, ARow] := IntToStr(StoI(Cells[GDM_QTY,aRow])* ( StoI(Cells[GDM_PR_SALE,aRow]) + Ifthen(Cells[GDM_DS_SALE,aRow]='D', 0, StoI(Cells[GDM_PR_ITEM,aRow])) ) );

    //단품할인금액 변경
    MenuDc               := MenuDc + FtoI(StoI(Cells[GDM_DC_MENU,ARow]) * aQty);

    //서비스이면 행사할인에서 제외한다
    if Cells[GDM_DS_SALE, ARow] <> 'D' then
      SpcDc                := SpcDc + FtoI(StoI(Cells[GDM_DC_SPC,aRow]) * aQty);

    if Cells[GDM_DS_MENU,ARow] = 'W' then
      TotalAmt           := TotalAmt + StoI(Cells[GDM_PR_SALE, aRow]) + Ifthen(Cells[GDM_DS_SALE,aRow]='D', 0, StoI(Cells[GDM_PR_ITEM,ARow]))
    else
      TotalAmt           := TotalAmt + ((StoI(Cells[GDM_PR_SALE, aRow])+ Ifthen(Cells[GDM_DS_SALE,aRow]='D', 0, StoI(Cells[GDM_PR_ITEM,ARow]))) * aQty); //합계금액

    Cells[GDM_VIEWQTY, ARow]     := Common.GetQtyReplace(Cells[GDM_DS_MENU,aRow], Cells[GDM_QTY, aRow]);   // 실제보이는 칼럼에 넣는다
    DisplayPresent;

  end;
end;

procedure TOrder_F.SetRowNumber;
var nRow, nNum :Integer;
begin
  nNum := 1;
  with Main_sGrd do
  begin
    if Cells[0,0] = '' then Exit;

    For nRow := 0 to RowCount-1 do
    begin
      if StoI(Cells[GDM_NO_STEP, nRow]) = 0 then
      begin
        Cells[GDM_NO, nRow] := IntToStr(nNum);
        Inc(nNum);
      end
      else
        Cells[GDM_NO, nRow] := '';
    end;
  end;
end;

//*************************************************************************//
//                          주문취소폼 보이기
//*************************************************************************//
function TOrder_F.ShowOrderCancelForm:String;
begin
  Result := '';
  try
    OrderCancel_F := TOrderCancel_F.Create(Self);       //주문취소폼 생성
    OrderCancel_F.CanMode := cmOrder;
    if OrderCancel_F.ShowModal = mrOK then
    begin
      Result := Common.WhyOrdercancel;
    end;
  finally
    FreeAndNil(OrderCancel_F);
  end;
end;

procedure TOrder_F.ShowPluClassButton;
var vButtonIndex, vIndex :Integer;
    vFirstButton :TPosButton;
    vPageCount :Integer;
begin
  if PluClassMaxPage > 1  then
    vPageCount := PluClassPagaCount
  else
    vPageCount := PluClassPagaCount;

  if Common.Config.IsKiosk then Exit;
  vFirstButton := nil;
  for vButtonIndex := Low(PluClassButton) to High(PluClassButton) do
  begin
    PluClassButton[vButtonIndex].Caption := EmptyStr;
    PluClassButton[vButtonIndex].Color   := Common.Config.PluClassColor;
    PluClassButton[vButtonIndex].Visible := false;

    PluClassButton[vButtonIndex].Temp1   := '';
    PluClassButton[vButtonIndex].Temp2   := ColorToString(Common.Config.PluClassColor);
    //위치에 맞는 데이터가 있을때
    for vIndex := 0 to PluClassData.Count-1 do
    begin
      if PluClassButton[vButtonIndex].Tag = (TPluClassData(PluClassData.Items[vIndex]^).Position - ((PluClassPage-1) * vPageCount)) then
      begin
        if vFirstButton = nil then
          vFirstButton := PluClassButton[vButtonIndex];

        PluClassButton[vButtonIndex].Visible := true;
        PluClassButton[vButtonIndex].Caption := LineFeed(TPluClassData(PluClassData.Items[vIndex]^).ClassName);
        PluClassButton[vButtonIndex].Temp1   := TPluClassData(PluClassData.Items[vIndex]^).ClassCode;
        PluClassButton[vButtonIndex].Color   := TPluClassData(PluClassData.Items[vIndex]^).Color;
        PluClassButton[vButtonIndex].Temp2   := ColorToString(TPluClassData(PluClassData.Items[vIndex]^).Color);
        Break;
      end;
    end;
  end;
  PluClassButtonClick(vFirstButton);
  if PluClassPage = PluClassMaxPage then
  begin
    if Assigned(TPosButton(FindComponent('PLUClassNextButton'))) then
    begin
      TPosButton(FindComponent('PLUClassNextButton')).Enabled    := false;
      TPosButton(FindComponent('PLUClassNextButton')).Font.Color := Common.Config.PluClassDownFontColor;
    end;
  end;

  if PluClassMaxPage = 1 then
  begin
    if Assigned(TPosButton(FindComponent('PLUClassPriorButton'))) then
    begin
      TPosButton(FindComponent('PLUClassPriorButton')).Visible := false;
      TPosButton(FindComponent('PLUClassNextButton')).Visible := false;
    end;
  end;
  if Common.Config.AllClassPLU then
    PluMenuPanel.Visible := false;
  Application.ProcessMessages;
end;

procedure TOrder_F.ShowPluMenuButton;
  function GetNextLineButton(aX,aY, aMenuCode:String):Integer;
  var vIndex :Integer;
      vLine  :String;
  begin
    vLine := IntToStr(StrToInt(aX)+1);
    Result := -1;
    for vIndex := Low(PluMenuButton) to High(PluMenuButton)-1 do
    begin
      if (vLine = PluMenuButton[vIndex].Temp5) and (aY = PluMenuButton[vIndex].Temp6) and (aMenuCode = PluMenuButton[vIndex].Temp1) and (aMenuCode = PluMenuButton[vIndex+1].Temp1) then
      begin
        PluMenuButton[vIndex].Temp9   := 'M';
        PluMenuButton[vIndex+1].Temp9 := 'M';
        Result := vIndex;
        Break;
      end;
    end;
  end;
  function GetNextLine2Button(aX,aY, aMenuCode:String):Integer;
  var vIndex :Integer;
      vLine  :String;
  begin
    vLine := IntToStr(StrToInt(aY)+1);
    Result := -1;
    for vIndex := Low(PluMenuButton) to High(PluMenuButton)-1 do
    begin
      //다음라인과  같고
      if (vLine = PluMenuButton[vIndex].Temp5) and (aX = PluMenuButton[vIndex].Temp6) and (aMenuCode = PluMenuButton[vIndex].Temp1) then
      begin
        PluMenuButton[vIndex].Temp9 := 'M';
        Result := vIndex;
        Break;
      end;
    end;
  end;
var vButtonIndex, vIndex1, vIndex :Integer;
begin
  for vButtonIndex := Low(PluMenuButton) to High(PluMenuButton) do
  begin
    PluMenuButton[vButtonIndex].Visible  := Common.Config.PluMenuEmptyShow;
    PluMenuButton[vButtonIndex].Caption  := EmptyStr;
    PluMenuButton[vButtonIndex].Number.NumberString := EmptyStr;
    PluMenuButton[vButtonIndex].Number.RightString  := EmptyStr;
    PluMenuButton[vButtonIndex].Number.Font.Color := Common.Config.PluMenuFont.Color;
    PluMenuButton[vButtonIndex].Temp1    := EmptyStr;
    PluMenuButton[vButtonIndex].Temp2    := EmptyStr;
    PluMenuButton[vButtonIndex].Temp3    := EmptyStr;
    PluMenuButton[vButtonIndex].Temp4    := EmptyStr;
    PluMenuButton[vButtonIndex].Color    := Common.Config.PluMenuColor;
    PluMenuButton[vButtonIndex].Font.Style := PluMenuButton[vButtonIndex].Font.Style - [fsItalic,fsStrikeOut];

    PluMenuButton[vButtonIndex].Bottom.RightString := EmptyStr;
    PluMenuButton[vButtonIndex].Width    := StrToInt(PluMenuButton[vButtonIndex].Temp7);
    PluMenuButton[vButtonIndex].Height   := StrToInt(PluMenuButton[vButtonIndex].Temp8);
    PluMenuButton[vButtonIndex].Temp9    := EmptyStr;   //버튼 합쳤다는 Flag
    //위치에 맞는 데이터가 있을때
    for vIndex := 0 to PluMenuData.Count-1 do
    begin
      if PluMenuButton[vButtonIndex].Tag = (TPluMenuData(PluMenuData.Items[vIndex]^).Position - ((PluMenuPage-1) * PluMenuPagaCount)) then
      begin
        PluMenuButton[vButtonIndex].Visible := true;
        PluMenuButton[vButtonIndex].Caption := LineFeed(TPluMenuData(PluMenuData.Items[vIndex]^).MenuName);
        PluMenuButton[vButtonIndex].Temp1   := TPluMenuData(PluMenuData.Items[vIndex]^).MenuCode;
        PluMenuButton[vButtonIndex].Temp2   := TPluMenuData(PluMenuData.Items[vIndex]^).MenuType;
        PluMenuButton[vButtonIndex].Temp3   := TPluMenuData(PluMenuData.Items[vIndex]^).MenuNo;
        PluMenuButton[vButtonIndex].Temp4   := IntToStr(TPluMenuData(PluMenuData.Items[vIndex]^).SelectQty);
        PluMenuButton[vButtonIndex].Color   := TPluMenuData(PluMenuData.Items[vIndex]^).Color;
        if TPluMenuData(PluMenuData.Items[vIndex]^).SoldOut then
        begin
          PluMenuButton[vButtonIndex].Number.RightString := '품절';
          PluMenuButton[vButtonIndex].Number.Font.Color  := clRed;
          PluMenuButton[vButtonIndex].Font.Style := PluMenuButton[vButtonIndex].Font.Style + [fsItalic,fsStrikeOut];
        end
        else
          PluMenuButton[vButtonIndex].Number.RightString := '';

        if Common.Config.PluMenuPriceShow then
          PluMenuButton[vButtonIndex].Bottom.RightString := FormatFloat('#,0',TPluMenuData(PluMenuData.Items[vIndex]^).SalePrice);
        if GetOption(247) = '1' then      // 메뉴번호 기능을 사용합니다.
          PluMenuButton[vButtonIndex].Number.NumberString := ifthen(TPluMenuData(PluMenuData.Items[vIndex]^).MenuNo='0','',TPluMenuData(PluMenuData.Items[vIndex]^).MenuNo);

         if TPluMenuData(PluMenuData.Items[vIndex]^).MenuType = 'P' then
           PluMenuButton[vButtonIndex].Bottom.RightString := '그룹';
        Break;
      end;
    end;
  end;

  //버튼 합치기
  for vIndex := Low(PluMenuButton) to High(PluMenuButton)-1 do
  begin
    if (PluMenuButton[vIndex].Temp1 = EmptyStr) or (PluMenuButton[vIndex].Temp9 = 'M') then Continue;
    //다음버튼과 메뉴코드가 같을때                                                    //같은 라인에 있을때
    if (PluMenuButton[vIndex].Temp1 = PluMenuButton[vIndex+1].Temp1) and (PluMenuButton[vIndex].Temp5 = PluMenuButton[vIndex+1].Temp5)  then
    begin
      //다음 라인버튼도 같은지 체크 (Y, X, 메뉴코드)
      vIndex1 := GetNextLineButton(PluMenuButton[vIndex].Temp5, PluMenuButton[vIndex].Temp6, PluMenuButton[vIndex].Temp1);

      //총 4개 버튼을 합친다
      if vIndex1 > 0 then
      begin
        PluMenuButton[vIndex].Width    := PluMenuButton[vIndex].Width * 2 + 2;
        PluMenuButton[vIndex].Height   := PluMenuButton[vIndex].Height * 2 + 2;
        PluMenuButton[vIndex+1].Temp9  := 'M';
      end
      else
      // 2개버튼을 합친다
      begin
        PluMenuButton[vIndex].Width    := PluMenuButton[vIndex].Width * 2 + 2;
        PluMenuButton[vIndex+1].Temp9  := 'M';
      end;
      PluMenuButton[vIndex].BringToFront;
      Continue;
    end
    else //세로 합치기
    begin
      vIndex1 := GetNextLine2Button(PluMenuButton[vIndex].Temp6, PluMenuButton[vIndex].Temp5, PluMenuButton[vIndex].Temp1);
      if vIndex1 > 0 then
      begin
        PluMenuButton[vIndex].Height    := PluMenuButton[vIndex].Height * 2 + 2;
        PluMenuButton[vIndex].Temp9  := 'M';
      end;
      PluMenuButton[vIndex].BringToFront;
      Continue;
    end;
  end;
  Application.ProcessMessages;

end;

//*************************************************************************//
//                  주문취소내역 DB에 저장(주문내역을 수정하는 것이고 취소내역에는 저장하지 않음)
//                  aKind : 0 - 주문, 1 - 그냥닫기, 2 - 정산시                          //
//*************************************************************************//
function  TOrder_F.OrderCancelDBApply(aKind:Integer):Boolean;
var vRow, vCnt, vSeq :Integer;
    vTable, vMenu :String;
    ErrFlag :String;
    vOrderDateTime :String;
begin
  Result := False;
  vOrderDateTime := '9999999999999';
  try
    with Common.Cancel_sGrd do
    begin
      //결제변경일때는 취소내역을 저장하지 않는다
      if (Cells[0,0] = '') or (Common.OrderKind = okChange) then
      begin
        Result := True;
        Exit;
      end;
      ErrFlag := '-0';

      if ((aKind <> 2) and (not Common.Config.IsTakeOut)) or (Common.Table.OrderType = 'D') then
      begin
        For vRow := 0 to RowCount-1 do
        begin
          if Cells[4, vRow] = 'N' then Continue;    //GDM_VIEWPRICE
          if Cells[7, vRow] <> '' then Continue;    //GDM_CD_MENU
          if Cells[0, vRow] = ''  then Continue;    //GDM_NO
          //정상을 서비스로 변경했다가 그냥 닫기를 했을때
          if (aKind = 1) and (Cells[GDM_SERVICE_CHG, vRow] = 'Y') then Continue;

          DM.StoredProc.StoredProcName := 'POS_SAVE_ORDER_CANCEL';
          DM.StoredProc.PrepareSQL;
          DM.StoredProc.ParamByName('_work_kind').AsInteger := aKind;
          DM.StoredProc.ParamByName('_cd_store').AsString   := Common.Config.StoreCode;
          DM.StoredProc.ParamByName('_no_table').AsInteger  := Common.Table.Number;
          DM.StoredProc.ParamByName('_ds_order').AsString   := Common.Table.OrderType;
          DM.StoredProc.ParamByName('_cd_menu').AsString    := Cells[0, vRow];
          DM.StoredProc.ParamByName('_seq').AsInteger       := StoI(Cells[5, vRow]);
          DM.StoredProc.ParamByName('_no_step').AsInteger   := StoI(Cells[6, vRow]);
          DM.StoredProc.ParamByName('_qty_order').AsInteger := StoI(Cells[1, vRow]);
          DM.StoredProc.ParamByName('_ymd_sale').AsString   := Common.WorkDate;
          DM.StoredProc.ExecProc;
        end;
      end;

      //선불제가 아니거나 배달주문일때
      if (not Common.Config.IsTakeOut) or (Common.Table.OrderType = 'D') then
      begin
      ///////////////////////////// 주문취소내역저장 ////////////////////////////////////
        ErrFlag := '-1';
        vMenu   := '';
        vCnt    := 0;
        For vRow := 0 to RowCount-1 do
        begin
          if Cells[0, vRow] = ''  then Continue;
          if (aKind = 1) and (Cells[GDM_SERVICE_CHG, vRow] = 'Y') then Continue;
          DM.OpenQuery('select ifnull(max(SEQ), 0 ) + 1 '
                      +' 	from SL_ORDER_C '
                      +' where CD_STORE	=:P0 '
                      +'   and NO_TABLE	=:P1 '
                      +'   and DS_ORDER	=:P2 ',
                      [Common.Config.StoreCode,
                       Common.Table.Number,
                       Common.Table.OrderType]);
          vSeq := DM.Query.Fields[0].AsInteger;

          ExecQuery('insert into SL_ORDER_C(CD_STORE, '
                   +'               				NO_TABLE, '
                   +'               				DS_ORDER, '
                   +'               				SEQ, '
                   +'               				CD_MENU, '
                   +'               				QTY_CANCEL, '
                   +'               				AMT_CANCEL, '
                   +'               				CANCEL_TXT, '
                   +'               				NO_POS, '
                   +'               				CD_SAWON, '
                   +'               				DT_ORDER, '
                   +'               				DT_CANCEL) '
                   +'           	 	 values(:P0, '
                   +'                       :P1, '
                   +'                       :P2, '
                   +'                       :P3, '
                   +'                       :P4, '
                   +'                       :P5, '
                   +'                       :P6, '
                   +'                       :P7, '
                   +'                       :P8, '
                   +'                       :P9, '
                   +'                       :P10, '
                   +'                       :P11)',
                   [Common.Config.StoreCode,
                    Common.Table.Number,
                    Common.Table.OrderType,
                    vSeq,
                    Cells[0,  vRow],
                    StoI(Cells[1, vRow]),
                    StoI(Cells[8, vRow]),
                    Cells[2, vRow],
                    Common.Config.PosNo,
                    Ifthen(Common.Table.DamdangCode = '', Common.Config.UserCode, Common.Table.DamdangCode),
                    Cells[3, vRow],
                    FormatDateTime('yyyymmddhhmm', now() )]);
          if Cells[3, vRow] <> '' then
          begin
            if Cells[3, vRow] < vOrderDateTime then
              vOrderDateTime := Cells[3, vRow];
            vMenu := vMenu + Format('%s(%s) [%s] ', [Cells[9, vRow], Cells[1, vRow], FormatMaskText('!90-90 00:00;0; ',RightStr(Cells[3, vRow],8))]);
            Inc(vCnt);
          end;
        end;  //  FormatMaskText('!0000-90-90 00:00;0; ',vOrderDateTime)

        //주문취소내역 SMS 전송
        if (GetOption(262) = '1') and (vCnt > 0) then
        begin
          //층을 사용할때
          if (GetOption(58) = '0') then
            vTable := Common.Table.FloorName+'-'+Common.Table.Name
          else
            vTable := Common.Table.Name;

          For vRow := 0 to Common.Config.StoreMobile.Count -1 do
            if Length(Common.Config.StoreMobile[vRow]) >= 9 then
              Common.KakaoSendMessage('P',['주문취소'#13+
                                      Format('[%s]%s',[vTable, vMenu ])],Common.Config.StoreMobile[vRow]);
        end;
      end;
    end;

    ErrFlag := '-2';
    if (aKind = 1) and (Common.CustomerCancel <> EmptyStr) then
    begin
      //주문로그에 저장
      Common.SavePrintData('000',
                           Common.CustomerCancel,
                           Ifthen(Common.Table.DamdangCode = '', Common.Config.UserName, Common.Table.DamdangName),
                           Common.Config.PosNo,
                           Common.NowDate+Common.NowTime,
                           Common.Table.CustomerCount,
                           0);
    end;

    Result := True;
  except
    on E: Exception do
      Common.WriteLog('OrderCancelDBApply'+ErrFlag,E.Message);
  end;
end;

//*************************************************************************//
//                          입금시재내역 보이기
//*************************************************************************//
procedure TOrder_F.PluClassButtonClick(Sender: TObject);
var vClassCode :String;
    vIndex :Integer;
begin
  //마감 상태였으면 초기화한다
  if wsReadyApply and (WorkState = wsMagam) then WorkState := wsReady;

  if Common.Config.PluClassX = 0 then
  begin
    SelectedClass := '01';
    SetPluMenuData(SelectedClass);
    Exit;
  end;

  if (Sender <> nil) and  ((Sender as TPosButton).Temp1 = '') then Exit;

  for vIndex := 0 to High(PluClassButton) do
  begin
    PluClassButton[vIndex].Color      := StringToColor(PluClassButton[vIndex].Temp2);
    PluClassButton[vIndex].Font.Color := Common.Config.PluClassFont.Color;
  end;

  if Sender <> nil then
  begin
    (Sender as TPosButton).Color      := Common.Config.PluClassDownColor;
    (Sender as TPosButton).Font.Color := Common.Config.PluClassDownFontColor;
    vClassCode := (Sender as TPosButton).Temp1;
  end
  else
    vClassCode := '';
  SelectedClass := vClassCode;
  if Common.Config.AllClassPLU and (Sender <> nil) and not Common.Config.IsKiosk then
  begin
    PluMenuPanel.Visible := true;
    BackButton.Visible   := true;
    PluMenuPanel.BringToFront;
  end;
  SetPluMenuData(vClassCode);
end;

procedure TOrder_F.PluClassButtonCreate;
var vWidth, vHeight, vX, vY, I, vClassCount, vTemp :Integer;
begin
  SetPluClassData;

  PluClassPagaCount := Common.Config.PluClassX * Common.Config.PluClassY;
  if PluClassPagaCount = 0 then
  begin
    PluClassPanel.Visible := false;
    Exit;
  end;

  if PluClassMaxPage > 1 then
    PluClassPagaCount := PluClassPagaCount - 1;
  SetLength(PluClassButton, PluClassPagaCount);

  vWidth  := PluClassPanel.Width  div Common.Config.PluClassX;
  vHeight := PluClassPanel.Height div Common.Config.PluClassY-1;
  I := 0;
  for vY := 0 to Common.Config.PluClassY-1 do
    for vX := 0 to Common.Config.PluClassX-1 do
    begin
      if PluClassPagaCount > I then
      begin
        PluClassButton[I] := TPosButton.Create(Self);
        with PluClassButton[I] do
        begin
          Name             := 'PluClassButton'+IntToStr(I);
          DoubleBuffered := true;
          TabStop          := false;
          Parent           := PluClassPanel;
          Width            := vWidth-2;
          Height           := vHeight;
          Left             := (vX * vWidth);
          Top              := (vY * vHeight) + (vY * 2);
          Caption          := EmptyStr;
          Color            := Common.Config.PluClassColor;
          BorderColor      := Common.Config.PluClassBorderColor;
          BorderStyle      := pbsSingle;
          BorderInnerColor := clNone;
          Temp2            := ColorToString(Common.Config.PluClassColor);
          Temp3            := ColorToString(Common.Config.PluClassColor);
          Font             := Common.Config.PluClassFont;
          Font.Size        := Font.Size;
          Cursor           := crHandPoint;
          OnClick          := PluClassButtonClick;
          Scaled           := false;
          Style            := bsRound;
          Tag              := I;
          Inc(I);
        end;
      end;
    end;

    if PluClassMaxPage > 1 then
    with TPosButton.Create(Self) do
    begin
      Name             := 'PLUClassPriorButton';
      Parent           := PluClassPanel;
      Width            := vWidth div 2 - 2;
      Height           := vHeight;
      Left             := PluClassButton[PluClassPagaCount-1].Left + vWidth;
      Top              := PluClassButton[PluClassPagaCount-1].Top;
      Caption          := '◀';
      Color            := Common.Config.PluClassColor;
      BorderColor      := Common.Config.PluClassBorderColor;
      BorderStyle      := pbsSingle;
      BorderInnerColor := clNone;
      Font             := Common.Config.PluClassFont;
      Font.Color       := Common.Config.PluClassDownFontColor;
      Font.Size        := Font.Size ;
      Cursor           := crHandPoint;
      OnClick          := PluClassPriorButtonClick;
      Visible          := PluClassMaxPage > 1;
      Scaled           := false;
      Enabled          := false;
    end;

    if PluClassMaxPage > 1 then
      with TPosButton.Create(Self) do
      begin
        Name        := 'PluClassNextButton';
        Parent      := PluClassPanel;
        Width       := vWidth div 2 - 2;
        Height      := vHeight;
        Left        := (PluClassButton[PluClassPagaCount-1].Left + vWidth) + (vWidth div 2);
        Top         := PluClassButton[PluClassPagaCount-1].Top;
        Caption     := '▶';
        Color       := Common.Config.PluClassColor;
        BorderColor      := Common.Config.PluClassBorderColor;
        BorderStyle      := pbsSingle;
        BorderInnerColor := clNone;
        Font        := Common.Config.PluClassFont;
        Font.Size        := Font.Size;
        Cursor      := crHandPoint;
        Scaled      := false;
        OnClick     := PluClassNextButtonClick;
        Visible     := PluClassMaxPage > 1;
        Enabled     := true;
      end;
end;

procedure TOrder_F.PluClassNextButtonClick(Sender: TObject);
begin
  PluClassPage := PluClassPage + 1;
  TPosButton(FindComponent('PLUClassPriorButton')).Enabled := true;
  TPosButton(FindComponent('PLUClassPriorButton')).Font.Color := Common.Config.PluClassFont.Color;

  if PluClassPage = PluClassMaxPage then
  begin
    TPosButton(FindComponent('PLUClassNextButton')).Enabled := false;
    TPosButton(FindComponent('PLUClassNextButton')).Font.Color := Common.Config.PluClassDownFontColor;
  end;
  ShowPluClassButton;
  if Common.Config.AllClassPLU then
    BackButton.Visible := false;
end;

procedure TOrder_F.PluClassPriorButtonClick(Sender: TObject);
begin
  PluClassPage := PluClassPage - 1;
  TPosButton(FindComponent('PLUClassNextButton')).Enabled := true;
  TPosButton(FindComponent('PLUClassNextButton')).Font.Color := Common.Config.PluClassFont.Color;


  if PluClassPage = 1 then
  begin
    TPosButton(FindComponent('PLUClassPriorButton')).Enabled := false;
    TPosButton(FindComponent('PLUClassPriorButton')).Font.Color := Common.Config.PluClassDownFontColor;
  end;
  ShowPluClassButton;
  if Common.Config.AllClassPLU then
    BackButton.Visible := false;
end;

procedure TOrder_F.PluMenuButtonClick(Sender: TObject);
  procedure SetKitchenMemo;
  begin
    //주문시 주방메모기능을 사용할 경우 (키오스크일때는 무조건)
    if (GetOption(156) = '1') or Common.Config.IsKiosk then
    begin
      if (Main_sGrd.Cells[GDM_DS_MENU, Main_sGrd.Row] <> 'N')
         and (Main_sGrd.Cells[GDM_DS_MENU, Main_sGrd.Row] <> 'G')
         and (Main_sGrd.Cells[GDM_DS_MENU, Main_sGrd.Row] <> 'W')  then
      begin
        Exit;
      end;

      OpenQuery('select count(*) CNT '
               +'  from MS_MENU_MEMO '
               +' where CD_STORE =:P0 '
               +'   and CD_MENU  =:P1',
               [Common.Config.StoreCode,
                Main_sGrd.Cells[GDM_CD_MENU, Main_sGrd.Row]]);

      if Common.Query.Eof then Exit;
      if Common.Query.Fields[0].AsInteger > 0 then
      begin
        Common.Query.Close;
        Action13.Execute;
      end;
    end;
  end;
var vOrderFinished :Boolean;
    vMenuCode,
    vMenuName :String;
    vTemp :String;
    vIndex :Integer;
label Loop;
begin
  if MilliSecondsBetween(Now(),PLUClickTime) < 10 then Exit;
  PLUClickTime := Now;

  if not Common.Config.IsTakeOut and Tmr_KioskWait.Enabled then
    Tmr_KioskWait.Enabled := false;

  if IsExecuteCard then Exit;
  try
    if StoI(FMsrData) > 1 then
      RestoreQty := StoI(FMsrData);

     //마감 상태였으면 초기화한다
    if Sender is TPosButton then
    begin
      vMenuCode := (Sender as TPosButton).Temp1;
      vMenuName := (Sender as TPosButton).Caption;
    end
    else if Sender = nil then
    begin
      vMenuCode := FMenuCode;
      vMenuName := FMenuName;
    end
    else
    begin
      if (Sender is TcxImage) then
        vIndex := (Sender as TcxImage).Tag
      else if (Sender is TcxLabel) then
        vIndex := (Sender as TcxLabel).Tag
      else if (Sender is TAdvPanel) then
        vIndex := (Sender as TAdvPanel).Tag
      else Exit;

      vMenuCode := KioskButtonList[vIndex].MenuCode;
      vMenuName := KioskButtonList[vIndex].MenuName
    end;


    if WorkState = wsMagam then WorkState := wsReady;

    FMenuCode := vMenuCode;
    if (IsEnter) and (SelectedClass = '01') then
    begin
      IsEnter := False;
      Exit;
    end;

    if FMenuCode = '' then Exit;

    if (Sender is TPosButton) and ((Sender as TPosButton).Number.RightString = '품절') then
    begin
      Common.MsgBox('일시 품절 된 메뉴입니다');
      Exit;
    end;


    //그룹메뉴일때
    if ((Sender is TcxButton) and (KioskButtonList[vIndex].MenuType = 'P')) or ((Sender is TPosButton) and ((Sender as TPosButton).Temp2 = 'P')) then
    begin
Loop:
      vTemp := (Sender as TPosButton).Temp4;
      if Common.ShowChooseForm('G', vMenuCode, FMenuCode, vTemp, vMenuName) then
      begin
        vOrderFinished := false;
        SelectMenu(0);
        SetKitchenMemo;
      end
      else
      begin
        vOrderFinished := true;
        SetKitchenMemo;
      end;
      ReDrowGridTitle;
      if not vOrderFinished then Goto Loop;
      Exit;
    end;

    SelectMenu(0);
    Main_sGrd.SetFocus;
    SetKitchenMemo;
  finally
    RestoreQty := 0;
    FMsrData   := '';
    if Common.Config.AllClassPLU then
      PluMenuPanel.Visible := false;

    if Present_sGrd.Visible then
      Present_sGrd.SetFocus
    else
      Main_sGrd.SetFocus;
  end;
end;

procedure TOrder_F.PluMenuButtonCreate;
var vWidth, vHeight, vX, vY, I :Integer;
begin
  PluMenuPagaCount := Common.Config.PluMenuX * Common.Config.PluMenuY;
  if PluMenuPagaCount = 0 then Exit;

  PluMenuPagaCount := PluMenuPagaCount - 1;
  SetLength(PluMenuButton, PluMenuPagaCount);

  vWidth  := PluMenuPanel.Width  div Common.Config.PluMenuX;
  vHeight := PluMenuPanel.Height div Common.Config.PluMenuY - 2 ;
  I := 0;
  for vY := 0 to (Common.Config.PluMenuY-1) do
    for vX := 0 to (Common.Config.PluMenuX-1) do
    begin
      if PluMenuPagaCount > I then
      begin
        PluMenuButton[I] := TPosButton.Create(Self);
        with PluMenuButton[I] do
        begin
          Name        := 'PluMenuButton'+IntToStr(I);
          DoubleBuffered := true;
          Parent      := PluMenuPanel;
          TabStop     := false;
          Width       := vWidth-2;
          Height      := vHeight;
          Left        := (vX * vWidth);// + (vX * 2);
          Top         := (vY * vHeight) + (vY * 2);
          Caption     := EmptyStr;
          Color       := Common.Config.PluMenuColor;
          BorderColor := Common.Config.PluMenuBorderColor;
          BorderStyle := pbsSingle;
          BorderInnerColor := clNone;
          Font        := Common.Config.PluMenuFont;
          Number.Height := Trunc(vHeight / 4);
          Number.Font.Color := Common.Config.PluMenuFont.Color;
          Number.Font.Name := Common.Config.PluMenuFont.Name;
          Number.Font.Size := Common.Config.PluMenuFont.Size-2 ;
          Bottom.Height := Trunc(vHeight / 4)+3;
          Bottom.Font := Common.Config.PluPriceFont;
          Cursor      := crHandPoint;
          Temp5       := IntToStr(vY);
          Temp6       := IntToStr(vX);
          Temp7       := IntToStr(vWidth-2);
          Temp8       := IntToStr(vHeight);
          OnClick     := PluMenuButtonClick;
          Style       := bsRound;
          Scaled      := false;
          Tag         := I;
          Inc(I);
        end;
      end;
    end;

  //PLU분류 이전페이지, 다음페이지 버튼을 생성한다
  with TPosButton.Create(Self) do
  begin
    Name        := 'PluMenuPrevButton';
    Parent      := PluMenuPanel;
    Width       := vWidth div 2 - 2;
    Height      := vHeight;
    Left        := PluMenuButton[PluMenuPagaCount-1].Left + vWidth;
    Top         := PluMenuButton[PluMenuPagaCount-1].Top;
    Caption     := '◀';
    Color       := Common.Config.PluMenuColor;
    BorderColor := Common.Config.PluMenuBorderColor;
    BorderStyle := pbsSingle;
    BorderInnerColor := clNone;
    Font        := Common.Config.PluMenuFont;
    Cursor      := crHandPoint;
    Scaled      := false;
    OnClick     := PluMenuPrevButtonClick;
    Enabled     := false;
  end;

  with TPosButton.Create(Self) do
  begin
    Name        := 'PluMenuNextButton';
    Parent      := PluMenuPanel;
    Width       := vWidth div 2 - 2;
    Height      := vHeight;
    Left        := (PluMenuButton[PluMenuPagaCount-1].Left + vWidth) + + (vWidth div 2);
    Top         := PluMenuButton[PluMenuPagaCount-1].Top;
    Caption     := '▶';
    Color       := Common.Config.PluMenuColor;
    BorderColor := Common.Config.PluMenuBorderColor;
    BorderStyle := pbsSingle;
    BorderInnerColor := clNone;
    Font        := Common.Config.PluMenuFont;
    Cursor      := crHandPoint;
    Scaled      := false;
    OnClick     := PluMenuNextButtonClick;
    Enabled     := false;
  end;
end;

procedure TOrder_F.PluMenuNextButtonClick(Sender: TObject);
begin
  PluMenuPage := PluMenuPage + 1;
  TPosButton(FindComponent('PLUMenuPrevButton')).Enabled := true;
  if PluMenuPage = PluMenuMaxPage then
    TPosButton(FindComponent('PLUMenuNextButton')).Enabled := false;
  ShowPluMenuButton;
end;

procedure TOrder_F.PluMenuPrevButtonClick(Sender: TObject);
begin
  PluMenuPage := PluMenuPage - 1;
  TPosButton(FindComponent('PLUMenuNextButton')).Enabled := true;
  if PluMenuPage = 1 then
    TPosButton(FindComponent('PLUMenuPrevButton')).Enabled := false;
  ShowPluMenuButton;
end;

procedure TOrder_F.PreSentGridDisplay;
  function CheckCardCancel(aApprovalNo, aAmtount:String):Boolean;
  var vRow :Integer;
  begin
    Result := False;
    For vRow := 0 to Common.Card_SGrd.RowCount-1 do
    begin
      if (Common.Card_sGrd.Cells[GDC_DS_TRD, vRow] = dtCancel) and
         (Common.Card_sGrd.Cells[GDC_AMT, vRow]    = aAmtount) and
         (Common.Card_sGrd.Cells[GDC_APPROVAL_ORG, vRow] = aApprovalNo) then
      begin
        Result := True;
        Break;
      end;
    end;
  end;
  procedure ItmAdd(Gbn,Idx:String;Amt:Integer;CardInfo:String;aRow:Integer);
  var vExist :Boolean;
      vIndex   :Integer;
  begin
     vExist := False;
     with Present_sGrd do
     begin
        {입금시재가 이미 존재하는지 체크}
        For vIndex := 0 to RowCount-1 do
        begin
          if CardInfo = '' then
          begin
            if (Gbn = Cells[GDP_KIND, vIndex]) and (IntToStr(Amt) = Cells[GDP_AMT, vIndex]) then
            begin
               vExist := True;
               Break;
            end;
          end
          else
          begin
            if (Gbn = Cells[GDP_KIND, vIndex]) and (CardInfo = Cells[GDP_CARDINFO, vIndex]) then
            begin
               vExist := True;
               Break;
            end;
          end;
        end;

        if vExist then
        begin
           Cells[GDP_AMT,   vIndex]       := FtoS(Amt);
           Cells[GDP_CHECK, vIndex]       := '1';
           Cells[GDP_CARD,  vIndex]       := idx;
           Cells[GDP_CARDINFO,  vIndex]   := CardInfo;
           Cells[GDP_ROW,       vIndex]   := IntToStr(aRow);
           Present_sGrd.Row              := vIndex;
        end
        else
        begin
           if Cells[0,0] <> '' then RowCount := RowCount + 1;
           Cells[GDP_KIND,      RowCount-1]   := Gbn;
           Cells[GDP_AMT,       RowCount-1]   := FtoS(Amt);
           Cells[GDP_CHECK,     RowCount-1]   := '1';
           Cells[GDP_CARD,      RowCount-1]   := idx;
           Cells[GDP_CARDINFO,  RowCount-1]   := CardInfo;
           Cells[GDP_ROW,       RowCount-1]   := IntToStr(aRow);
           Present_sGrd.Row := Present_sGrd.RowCount-1;
        end;
     end;
  end;
var vIndex : Integer;
    vTemp :  String;
begin
  Common.GridToGrid(Common.Summary_sGrd, Common.Temp_sGrd);
  Common.TaxCalculation;
  Common.ClearGrid(Present_sGrd);
  with Common.PreSent, Present_sGrd do
  begin
    //합계금액을 표시하지 않을때
    if not PresnetPanel.Visible then
      ItmAdd('합계금액', 'D', TotalAmt,'T', 0);

    if ( GetOption(84) = '1' ) and (TaxAmt <> 0) then ItmAdd('부가세',  ''  ,TaxAmt, 'T', 0 );
    if SpcDc     <> 0 then ItmAdd('행사할인',            '', SpcDc,     'D', 0 );
    if MenuDc    <> 0 then ItmAdd('메뉴할인',            '', MenuDc,    'D', 0 );
    if RcpDc     <> 0 then ItmAdd('영수증할인',          '', RcpDc,     'D', 0 );
    if MemberDc  <> 0 then ItmAdd('회원할인',            '', MemberDc,  'D', 0 );
    if VatDc     <> 0 then ItmAdd('부가세할인',          '', VatDc,     'D', 0 );
    if CodeDc    <> 0 then ItmAdd(Copy(CodeDcName,1,10), '', CodeDc,    'D', 0 );
    if TipAmt    <> 0 then ItmAdd('봉 사 료',            '', TipAmt,    'D', 0 );
    if EventDc   <> 0 then ItmAdd('이벤트할인',          '', EventDc,   'D', 0 );
    if CouponDc  <> 0 then ItmAdd('쿠폰할인',            '', CouponDc,  'D', 0 );
    if UPlusDc   <> 0 then ItmAdd('UPLUS 할인',          '', UPlusDc,   'D', 0 );
    if KaKaoDc   <> 0 then ItmAdd('카카오 할인',         '', KaKaoDc,   'D', 0 );
    if CutDc     <> 0 then ItmAdd('단차할인',            '', CutDc,     'D', 0 );
    if TaxFreeDc <> 0 then ItmAdd('Tax Refund',          '', TaxFreeDc, 'D', 0 );
    if StampDc   <> 0 then ItmAdd('스템프할인',          '', StampDc,   'D', 0 );

    if CheckAmt  <> 0 then ItmAdd('수표'    ,            '', CheckAmt,  'A', 0);
    if (CardAmt   <> 0) or (LetsOrderAmt <> 0) then
    begin
      if GetOption(51) = '1' then
      begin
        ItmAdd('카드(단말기)'    ,   '', CardAmt, 'A', 0);
      end
      else
      begin
        with Common.Card_SGrd do
        begin
          for vIndex := 0 to RowCount-1 do
          begin
            if Cells[GDC_DS_TRD, vIndex] = dtCancel then Continue;
            //이미취소된 건인지 체크
            if CheckCardCancel(Cells[GDC_NO_APPROVAL, vIndex], Cells[GDC_AMT, vIndex]) then Continue;

            if StoI(Cells[GDC_AMT, vIndex])-StoI(Cells[GDC_AMT_CANCEL, vIndex]) = 0 then Continue;

            if (Cells[GDC_YN_CAN, vIndex] = 'Y') then
            begin
              vTemp := Trim(Cells[GDC_NAME, vIndex]);
              if (Cells[GDC_DS_CARD, vIndex] <> atPG) and ((Cells[GDC_TYPE_TRD, vIndex] = atCat)) then
                 ItmAdd('카드(단말기)', IntToStr(vIndex)  ,StoI(Cells[GDC_AMT, vIndex]), Cells[GDC_NO_APPROVAL, vIndex], vIndex )
              else if Cells[GDC_DS_CARD, vIndex] = atPG then
              begin
                if StoI(Cells[GDC_AMT, vIndex])-StoI(Cells[GDC_AMT_CANCEL, vIndex]) > 0 then
                  ItmAdd('카드('+Copy(vTemp,1,2)+')',IntToStr(vIndex)  ,StoI(Cells[GDC_AMT, vIndex])-StoI(Cells[GDC_AMT_CANCEL, vIndex]), Cells[GDC_NO_APPROVAL, vIndex], vIndex );
              end
              else
                ItmAdd('카드('+Copy(vTemp,1,2)+')',IntToStr(vIndex)  ,StoI(Cells[GDC_AMT, vIndex]), Cells[GDC_NO_APPROVAL, vIndex], vIndex );
            end
          end;
        end;
      end;
    end;

    if GiftAmt      <> 0 then ItmAdd('상품권'   ,''    ,GiftAmt,  'A', 0);
    if PointDC      <> 0 then ItmAdd('포인트할인' ,''  ,PointDC,  'A', 0);
    if TrustAmt     <> 0 then ItmAdd('외상'     ,''    ,TrustAmt, 'A', 0);
    if CashAmt      <> 0 then ItmAdd('현금'     ,''    ,CashAmt,  'A', 0);
    if BankAmt      <> 0 then ItmAdd('계좌입금' ,''    ,BankAmt,  'A', 0);
    if PointAmt     <> 0 then ItmAdd('포인트결제',''   ,PointAmt, 'A', 0);
    if EtcAmt       <> 0 then ItmAdd('기타결제' ,''    ,EtcAmt,   'A', 0);

    {취소한 입금시재 삭제}
    vIndex := 0;
    while vIndex <= RowCount-1 do
    begin
      if Cells[GDP_CHECK, vIndex] = 'D' then
         Common.DeleteRow(Present_sGrd, vIndex)
      else Inc(vIndex);
    end;

    {입금취소를 했을때 사용}
    if Cells[0,0] <> '' then
      for vIndex := 0 to RowCount -1 do Cells[GDP_CHECK, vIndex] := 'D';

    Row := RowCount -1;
  end;
  Present_sGrd.Refresh;
end;

//*************************************************************************//
//                     같은메뉴가 이미 있을때 상품추가
//*************************************************************************//
function TOrder_F.Goods_QtyAdd(aAdd:Boolean): Boolean;
var liRow, liQty, nRow, tmpPrice  :Integer;
    lsSale:String;
begin
   Result := False;
   case WorkKind of
      wkSale    :
        begin
          lsSale   := 'S';
          liQty    := Ifthen(RestoreQty=0,1,RestoreQty);
        end;
      wkPacking :
        begin
          lsSale   := 'P';
          liQty    := Ifthen(RestoreQty=0,1,RestoreQty);
        end;
      wkService :
        begin
          lsSale   := 'D';
          liQty    := Ifthen(RestoreQty=0,1,RestoreQty);
        end;
      wkRefund :
        begin
          lsSale   := 'S';
          liQty    := Ifthen(RestoreQty=0,-1,RestoreQty);
        end;
   end;
   with Main_sGrd do
   begin
      //과세별도 메뉴일때는 부가세를 더한다
      if RestorePrice > 0 then
        tmpPrice := RestorePrice
      else if Common.Menu.ds_tax = '2' then
      begin
        tmpPrice := FtoI(Common.Menu.pr_sale * 1.1);
      end
      else
      begin
        if (Common.Table.Packing='Y') then
          tmpPrice := Common.Menu.pr_sale_packing
        else
          tmpPrice := Common.Menu.pr_sale;
      end;

      if WorkKind = wkService then tmpPrice := 0;

      For liRow :=0 to RowCount-1 do
      begin
         if bGroupAddTime then Continue;
         if not aAdd and Common.Config.IsTakeOut and  (StoI(Cells[GDM_DC_MENU,  liRow]) <> 0 ) then Continue;
         
         //메뉴코드가 같고, 매출구분이 같고, 주문이 아직 안되고, 코스메뉴가 아니면
         if (Cells[GDM_CD_MENU,  liRow] = FMenuCode) and
            (Cells[GDM_DS_SALE,  liRow] = lsSale)    and
            (Cells[GDM_PR_SALE,  liRow] = IntToStr(tmpPrice))    and
            (Cells[GDM_YN_ORDER, liRow] = 'N')       and
            (Cells[GDM_DS_MENU,  liRow] <> 'O')      and
            (Cells[GDM_DS_MENU,  liRow] <> 'C' )     and
            (Cells[GDM_DS_MENU,  liRow] <> 'I' )     and
            (Cells[GDM_DS_MENU,  liRow] = Common.Menu.ds_menu ) and
            (StoI(Cells[GDM_DC_MENU,  liRow]) = Common.Menu.dc_menu ) and
            (Cells[GDM_CD_ITEM,  liRow] = Common.Menu.cd_item ) and
            (Cells[GDM_MEMO,     liRow] = FMemo ) and
            ( ((StoI(Cells[GDM_QTY, liRow]) > 0) and (liQty > 0)) or ((StoI(Cells[GDM_QTY, liRow]) < 0) and (liQty < 0)) )  then
         begin
            {세트메뉴이면 구성메뉴의 수량도 모두 변경한다}
            if Cells[GDM_DS_MENU,  liRow] = 'S' then
            begin
              For nRow := liRow+1 to RowCount-1 do
              begin
                if (Cells[GDM_YN_ORDER, liRow] = Cells[GDM_YN_ORDER, nRow]) and
                   (Cells[GDM_CD_MENU,  liRow] = Cells[GDM_CD_MENU,  nRow]) and
                   (Cells[GDM_CD_MENU1, nRow] <> '') then
                begin
                  Cells[GDM_QTY, nRow] := IntToStr( StoI(Cells[GDM_QTY, nRow]) +
                                                    StoI(Cells[GDM_NEPUM, nRow]) );
                  Cells[GDM_VIEWQTY, nRow] := Cells[GDM_QTY, nRow];
                end;
              end;
            end;
            Cells[GDM_QTY,     liRow]     := IntToStr(StoI(Cells[GDM_QTY, liRow]) + liQty);                               //수량추가
            Cells[GDM_AMT,     liRow]     := IntToStr(StoI(Cells[GDM_QTY, liRow]) * StoI(Cells[GDM_PR_SALE, liRow])); //수량추가에 따른 금액변경
            QtyChg_SGrdApply(FMenuCode, lsSale, Cells[GDM_CD_ITEM, liRow],  liQty, StoI(Cells[GDM_PR_SALE, liRow]), StoI(Cells[GDM_DC_MENU, liRow]));
            Cells[GDM_VIEWQTY, liRow]     := Cells[GDM_QTY, liRow];   // 실제보이는 칼럼에 넣는다
            DisplayPresent;
            Result     := True;
            Row        := liRow;
            FMenuCode  := EmptyStr;
            Break;
         end;
      end;
   end;
end;

//*************************************************************************//
//                       수량변경시 집계그리드에 적용
//*************************************************************************//
procedure TOrder_F.QtyChg_SGrdApply(aMenu, DsSale, aItem: String; aQty,aPrice,aMenuDc: Integer);
var liRow : Integer;
begin
   {Summary 그리드 적용}
   with Common.Summary_sGrd, Common.PreSent do
   begin
        //집계용 그리드에서 상품을 찾는다
        for liRow := 0 to RowCount-1 do
           if (Trim(Cells[GDM_CD_MENU,liRow]) = aMenu)
              and (Trim(Cells[GDM_CD_ITEM,liRow]) = aItem)
              and (StoI(Cells[GDM_PR_SALE, liRow])=aPrice)
              and (StoI(Cells[GDM_DC_MENU, liRow])=aMenuDc)
              and (Cells[GDM_DS_SALE, liRow] = DsSale) then break;

        //수량이 0으로 변경되면
        if (SToF(Cells[GDM_QTY, liRow]) + aQty) = 0 then
        begin
           AmtReCompute(aQty,liRow);
           Common.DeleteRow(Common.Summary_sGrd,liRow);
        end
        else AmtReCompute(aQty, liRow);
   end;//with Common.Summary_sGrd do
   DisplayPresent;
end;

//*************************************************************************//
//                          코스메뉴 선택 폼 보이기
//*************************************************************************//
procedure TOrder_F.Act_CourseExecute(Sender: TObject);
  function GetRowIndex:Integer;
  var vIndex :Integer;
  begin
    if (GetOption(23)='0') or (Main_sGrd.Cells[0,0] = '') then
      Result := Main_sGrd.Row
    else
      Result := Main_sGrd.RowCount;
  end;
var vIndex, nRow, vRow :Integer;
    vCourse : TStringList;
    vOrderFinished :Boolean;
    vSelectedCourse :String;
    vOrderAmt :Integer;
    vItems :String;
    vOrderCourseMenu  :^TCourseOrderMenu;    //선택한 메뉴저장
begin
  vItems := '';
  if not Common.Config.IsKiosk then
  begin
    if not Assigned(Course_F) then
      Course_F       := TCourse_F.Create(Application);

    vOrderAmt := 0;
    Course_F.MenuName := Common.Menu.nm_menu;
    Common.DoModalReset;
    if Course_F.ShowModal = mrOK then
    begin
      Act_Course.Tag := 1;
      //부메뉴단가 적용안할때
      if GetOption(23) = '0' then
      begin
        vRow := Main_sGrd.Row;
        For nRow := 0 to Course_F.sgr_Grid.RowCount-1 do
        begin
          if StrToIntDef(Course_F.sgr_Grid.Cells[2, nRow],0) = 0 then Continue;
            vItems := vItems + Format('%s,%s|',[Course_F.sgr_Grid.Cells[3, nRow], Course_F.sgr_Grid.Cells[2, nRow]]);
        end;

        Common.Menu.cd_item := vItems;
        MainGrid_add;
        if vRow < Main_sGrd.Row then
          vRow := vRow + 1;

        Common.Menu.cd_item := '';

        For nRow := 0 to Course_F.sgr_Grid.RowCount-1 do
        begin
          if StrToIntDef(Course_F.sgr_Grid.Cells[2, nRow],0) = 0 then Continue;

          Common.Menu.no_step     := nRow+1;
          Common.Menu.nm_menu     := Course_F.sgr_Grid.Cells[1, nRow];
          Common.Menu.cd_menu1    := Course_F.sgr_Grid.Cells[3, nRow];
          Common.Menu.kitchen     := Ifthen(GetOption(241)='1', Course_F.sgr_Grid.Cells[4, nRow], MainKitchen);
          Common.Menu.nm_menu_kitchen := Course_F.sgr_Grid.Cells[8, nRow];
          Common.Menu.qty_sale    := StrToInt(Course_F.sgr_Grid.Cells[2, nRow]);
          Common.Menu.pr_sale     := 0;
          Common.Menu.pr_sale_org := 0;
          Common.Menu.dc_menu     := 0;
          Common.Menu.no_spc      := '';
          Common.Menu.dc_spc      := 0;
          MainGrid_add;
        end;
        Common.CourseOrderMenu.Count := Course_F.sgr_Grid.RowCount;
        Main_sGrd.Row := vRow;
      end
      else
      begin
        Common.CourseOrderMenu.Clear;
        vIndex := 0;
        if Course_F.OrderMenuCount > 0 then
        begin
          SetLength(OrderCourseMenu, Course_F.OrderMenuCount);
          for nRow := 0 to Course_F.sgr_Grid.RowCount-1 do
          begin
            if StrToIntDef(Course_F.sgr_Grid.Cells[2, nRow],0) = 0 then Continue;

            New(OrderCourseMenu[vIndex]);
            OrderCourseMenu[vIndex]^.Step       := nRow+1;
            OrderCourseMenu[vIndex]^.MenuCode   := Course_F.sgr_Grid.Cells[3, nRow];
            OrderCourseMenu[vIndex]^.MenuName   := Course_F.sgr_Grid.Cells[1, nRow];
            OrderCourseMenu[vIndex]^.OrderQty   := StrToInt(Course_F.sgr_Grid.Cells[2, nRow]);
            OrderCourseMenu[vIndex]^.KitchenCode:= Ifthen(GetOption(241)='1', Course_F.sgr_Grid.Cells[4, nRow], MainKitchen);
            OrderCourseMenu[vIndex]^.OrderPrice := StrToIntDef(Course_F.sgr_Grid.Cells[7, nRow],0);
            OrderCourseMenu[vIndex]^.PrintMenuName := Course_F.sgr_Grid.Cells[8, nRow];
            Common.CourseOrderMenu.Add(OrderCourseMenu[vIndex]);
          end;
        end;
      end;
    end
    else
      Act_Course.Tag := 0;
    Common.DoModalClose;

    ReDrowGridTitle;
  end
  //코스주문을 버튼 방식으로 사용합니다.
  else if (GetOption(293) = '0') then
  begin
    Common.CourseOrderMenu.Clear;
    try
      Common.DoModalReset;
      KioskCourseQty := 0;
      KioskCourse2_F := TKioskCourse2_F.Create(Self);
      if KioskCourse2_F.ShowModal = mrOK then
      begin
        Act_Course.Tag := 1;
        KioskCourseQty := StrToInt(KioskCourse2_F.lblQty.Caption);
        if Common.CourseOrderMenu.Count > 0 then
        begin
          Common.Menu.pr_sale := 0;
          if (GetOption(23)='0') or (Main_sGrd.Cells[0,0] = '') then
            vRow := Main_sGrd.Row
          else
            vRow := Main_sGrd.RowCount;
        end;

        For vIndex := 0 to Common.CourseOrderMenu.Count-1 do
        begin
          if TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderQty = 0 then Continue;

          Common.Menu.no_step         := vIndex+1;
          Common.Menu.nm_menu         := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).MenuName;
          Common.Menu.cd_menu1        := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).MenuCode;
          Common.Menu.kitchen         := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).KitchenCode;
          Common.Menu.qty_sale        := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderQty * KioskCourseQty;
          Common.Menu.qty_nepum       := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderQty * KioskCourseQty;
          Common.Menu.pr_sale         := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderPrice;
          Common.Menu.pr_sale_org     := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderPrice;
          Common.Menu.nm_menu_kitchen := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).PrintMenuName;
          Common.WriteLog('work', Format('%s %d',[Common.Menu.nm_menu, Common.Menu.qty_sale]));

          Common.Menu.dc_menu     := 0;
          Common.Menu.no_spc      := '';
          Common.Menu.dc_spc      := 0;

          //코스에 부메뉴에 대해 단가 적용여부
          if GetOption(23)='0' then
              MainGrid_add;
        end;

        //코스선택을 아무것도 안했을때
        if (Common.CourseOrderMenu.Count = 0) and (GetOption(23) = '1') then
        begin
          Common.Menu.qty_sale := KioskCourseQty;
          Common.Menu.Ds_Menu  := 'N';
          if not Goods_QtyAdd(true) then
            MainGrid_add;
        end;

        if (GetOption(23)='0') or (Main_sGrd.Cells[0,0] = '') then
          Main_sGrd.Row := vRow;

        KioskCourseRow  := vRow;
      end
      else
      begin
        Act_Course.Tag := 0;
        Common.CourseOrderMenu.Clear;
        Exit;
      end;
    finally
      FreeAndNil(KioskCourse2_F);
      Common.DoModalClose;
    end;
  end
  else
  begin
    Common.CourseOrderMenu.Clear;
    vCourse := TStringList.Create;
    try
      vCourse.Clear;
      DM.OpenQuery('select distinct a.NM_COURSE, '
                  +'       a.CNT_CHOOSE, '
                  +'       a.COURSE_SEQ, '
                  +'       b.CNT_MENU, '
                  +'       a.YN_DEFAULT, '
                  +'       a.DS_CHOOSE '
                  +'  from MS_COURSE as a left outer join '
                  +'      (select COURSE_SEQ, '
                  +'              Count(SEQ) as CNT_MENU '
                  +'         from MS_COURSE as a inner join '
                  +'              MS_MENU   as b on b.CD_STORE = a.CD_STORE '
                  +'                            and b.CD_MENU  = a.CD_MENU_COURSE '
                  +'        where a.CD_STORE =:P0 '
                  +'          and a.CD_MENU  =:P1 '
                  +'          and Substring(b.CONFIG,8,1) <> ''Y'' '
                  +Ifthen(Common.Table.Packing = 'Y', ' and SubString(b.CONFIG,10,1) <> ''Y'' ',' and SubString(b.CONFIG,10,1) <> ''S'' ')
                  +'          and b.YN_USE = ''Y'' '
                  +'        group by a.COURSE_SEQ ) as b on b.COURSE_SEQ = a.COURSE_SEQ '
                  +' where a.CD_STORE =:P0 '
                  +'   and a.CD_MENU  =:P1 '
                  +'   and b.CNT_MENU > 0 '
                  +' group by COURSE_SEQ '
                  +' order by a.COURSE_SEQ',
                  [Common.Config.StoreCode,
                   Common.Menu.cd_menu]);
      while not DM.Query.Eof do
      begin
        vCourse.Add(DM.Query.FieldByName('COURSE_SEQ').AsString + splitColumn
                   +DM.Query.FieldByName('CNT_CHOOSE').AsString + splitColumn
                   +DM.Query.FieldByName('NM_COURSE').AsString  + splitColumn
                   +DM.Query.FieldByName('YN_DEFAULT').AsString  + splitColumn
                   +DM.Query.FieldByName('DS_CHOOSE').AsString  + splitColumn
                   +DM.Query.FieldByName('CNT_MENU').AsString);
        DM.Query.Next;
      end;
      DM.Query.Close;

      vOrderFinished := true;
      Tmr_KioskWait.Enabled := false;
      vSelectedCourse := '';
      vRow := Main_sGrd.Row;
      for vIndex := 0 to vCourse.Count-1 do
      begin
        Common.DoModalReset;
        //기본선택 and 선택수량 가능수량 1  and 선택유형이 라디오
        if (CopyPos(vCourse.Strings[vIndex],SplitColumn, 3) = 'Y')
        and (CopyPos(vCourse.Strings[vIndex],SplitColumn,1) = '1')
        and (CopyPos(vCourse.Strings[vIndex],SplitColumn,4) = 'R')  then
          CourseMenuCount := 1
        else
          CourseMenuCount := 0;
        if CourseMenuCount = 0 then
        begin
          try
            KioskCourse_F := TKioskCourse_F.Create(Self);
            KioskCourse_F.ButtonWidth  := KioskButtonList[0].GroupBox.Width;
            KioskCourse_F.ButtonHeight := KioskButtonList[0].GroupBox.Height;
            KioskCourse_F.ButtonFont   := KioskPLUMenuPanel.Font;
            KioskCourse_F.CourseStep   := StrToInt(CopyPos(vCourse.Strings[vIndex],SplitColumn,0));
            KioskCourse_F.PossibleCount:= StrToInt(CopyPos(vCourse.Strings[vIndex],SplitColumn,1));
            KioskCourse_F.CouresName   := CopyPos(vCourse.Strings[vIndex],SplitColumn,2);
            KioskCourse_F.ChooseType   := CopyPos(vCourse.Strings[vIndex],SplitColumn,4);
            KioskCourse_F.SelectCount  := 0;
            KioskCourse_F.SelectedMenu := vSelectedCourse;
            KioskCourse_F.TotalCourseCount := vCourse.Count;
            KioskCourse_F.NowCourseIndex   := vIndex + 1;

            case KioskCourse_F.ShowModal of
              mrCancel :
              begin
                vOrderFinished := false;
                Common.CourseOrderMenu.Clear;
                Break;
              end;

              mrOK :
              begin
                if KioskCourse_F.SelectCount > 0 then
                  vSelectedCourse := vSelectedCourse + Format('【%s】 %s',[CopyPos(vCourse.Strings[vIndex],SplitColumn,2),  KioskCourse_F.SelectedMenu]) + #13;
              end;
            end;
          finally
            FreeAndNil(KioskCourse_F);
            Common.DoModalClose;
          end;
        end
        else
        begin
          OpenQuery('select t1.CD_MENU_COURSE as CD_MENU, '
                   +'       t2.CD_PRINTER, '
                   +'       t3.CD_PRINTER as CD_PRINTER1,'
                   +'       t2.NM_MENU_SHORT, '
                   +'       t2.NM_MENU_KITCHEN, '
                   +Ifthen(GetOption(194)='1','GetSalePrice(t1.CD_STORE, t1.CD_MENU_COURSE) as PR_SALE ', 't2.PR_SALE ')
                   +'  from MS_COURSE     t1 inner join '
                   +'       MS_MENU       t2 on t1.CD_STORE	=t2.CD_STORE and t1.CD_MENU_COURSE = t2.CD_MENU inner join '
                   +'       MS_MENU       t3 on t1.CD_STORE	=t3.CD_STORE and t1.CD_MENU	       = t3.CD_MENU '
                   +' where t1.CD_STORE	  =:P0 '
                   +'   and t1.CD_MENU  	=:P1 '
                   +'   and t1.COURSE_SEQ =:P2 '
                   +'   and t1.YN_DEFAULT = ''Y'' '
                   +'   and Substring(t2.CONFIG,8,1) <> ''Y'' '
                   +Ifthen(Common.Table.Packing = 'Y', ' and SubString(t2.CONFIG,10,1) <> ''Y'' ',' and SubString(t2.CONFIG,10,1) <> ''S'' ')
                   +'   and t2.YN_USE = ''Y'' '
                   +' order by t1.SEQ ',
                   [Common.Config.StoreCode,
                    Common.Menu.cd_menu,
                    StrToInt(CopyPos(vCourse.Strings[vIndex],SplitColumn,0))]);
          if not Common.Query.Eof then
          begin
            New(vOrderCourseMenu);
            vOrderCourseMenu^.Step     := StrToInt(CopyPos(vCourse.Strings[vIndex],SplitColumn,0));
            vOrderCourseMenu^.MenuCode := Common.Query.FieldByName('CD_MENU').AsString;
            vOrderCourseMenu^.MenuName := Common.Query.FieldByName('NM_MENU_SHORT').AsString;
            vOrderCourseMenu^.PrintMenuName := Common.Query.FieldByName('NM_MENU_KITCHEN').AsString;
            vOrderCourseMenu^.OrderQty := 1;
            vOrderCourseMenu^.OrderPrice := Ifthen(GetOption(23)='1', Common.Query.FieldByName('PR_SALE').AsInteger,0);
            if GetOption(241) = '0' then
              vOrderCourseMenu^.KitchenCode := Common.Query.FieldByName('CD_PRINTER').AsString
            else
              vOrderCourseMenu^.KitchenCode := Common.Query.FieldByName('CD_PRINTER1').AsString;

            Common.CourseOrderMenu.Add(vOrderCourseMenu);
          end;
          Common.Query.Close;
        end;
      end;
    finally
      vCourse.Free;
    end;

    if KioskBeginImageExist or (not KioskBeginImageExist and (GetOption(437) <> '0')) then
      Tmr_KioskWait.Enabled := true;
    if vOrderFinished then
    begin
      Act_Course.Tag := 1;
      if Common.CourseOrderMenu.Count > 0 then
      begin
        Common.Menu.pr_sale := 0;
        if (GetOption(23)='0') or (Main_sGrd.Cells[0,0] = '') then
          vRow := Main_sGrd.Row
        else
          vRow := Main_sGrd.RowCount;
      end;
      For vIndex := 0 to Common.CourseOrderMenu.Count-1 do
      begin
        Common.Menu.no_step  := vIndex+1;
        Common.Menu.nm_menu  := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).MenuName;
        Common.Menu.cd_menu1 := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).MenuCode;
        Common.Menu.kitchen  := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).KitchenCode;
        Common.Menu.qty_sale := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderQty;
        Common.Menu.qty_nepum := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).OrderQty;
        Common.Menu.nm_menu_kitchen := TCourseOrderMenu(Common.CourseOrderMenu.Items[vIndex]^).PrintMenuName;
        Common.Menu.dc_menu  := 0;
        Common.Menu.no_spc   := '';
        Common.Menu.dc_spc   := 0;
        Common.WriteLog('work', Format('%s %d',[Common.Menu.nm_menu, Common.Menu.qty_sale]));

        //코스에 부메뉴에 대해 단가 적용여부
        if GetOption(23)='0' then
          MainGrid_add;
      end;
      //코스선택을 아무것도 안했을때
      if Common.CourseOrderMenu.Count = 0 then
      begin
        Common.Menu.Ds_Menu := 'N';
        if not Goods_QtyAdd(true) then
          MainGrid_add;
      end;

      if (GetOption(23)='0') or (Main_sGrd.Cells[0,0] = '') then
        Main_sGrd.Row := vRow;
    end
    else
      Act_Course.Tag := 0;
  end;
end;

//*************************************************************************//
//                          수량변경 버튼 눌렀을때
//*************************************************************************//
procedure TOrder_F.Goods_QtyDec(aMenu, aItem: String; aQty,aPrice,aMenuDc:Integer;aPrint,aService:String);
var liRow, nRow : Integer;
    lsSale : String;
    vTemp  : String;
label go;
begin
   {Main 그리드에 수량, 금액 감소}
   with Main_SGrd do
   begin
      if (GetUserOption(8) <> '1') and (Cells[GDM_YN_ORDER, Row] = 'Y') and (aQty < 0) then
      begin
        if GetOption(172) = '0' then
        begin
          Common.ErrBox('주문을 취소할 권한이 없습니다');
          Exit;
        end
        else if not Common.CheckAuthority(8) then Exit;
      end;
      //주문취소 사유를 받는다
      if (GetOption(15) = '1') and (Cells[GDM_YN_ORDER, Row] = 'Y')  and (aQty < 0) and (aService = 'N') then
      begin
        if  ShowOrderCancelForm = '' then Exit;
      end;

      //주문이 완료됐던것만 취소할 때
      if Cells[GDM_YN_ORDER, Row] = 'Y' then
      if Cells[GDM_DS_MENU, Row] = 'W' then
        OrgOrderAmt := OrgOrderAmt - Abs(aPrice)
      else
        OrgOrderAmt := OrgOrderAmt - Abs(aQty * aPrice);

      //주방주문서출력 취소내역 저장
      if  (aQty < 0) and (Cells[GDM_YN_ORDER, Row] = 'Y') then
        Common.OrderCancelGridSave(Row, Abs(aQty), aPrint, aService);
      if Cells[GDM_DS_MENU, Row] = 'W' then vTemp := Cells[GDM_QTY, Row]
      else                                  vTemp := IntToStr(ABS(aQty));
      if (aQty < 0) and (aPrint = 'Y') then
        Common.Device.OrderCancel(Main_sGrd, Row, vTemp);

      lsSale := Cells[GDM_DS_SALE, Row];
      if (StoI(Cells[GDM_QTY, Row]) + aQty = 0) then
      begin
        liRow := Row;

go:
        For nRow := liRow+1 to RowCount-1 do
        begin
          if (Cells[GDM_YN_ORDER, liRow] = Cells[GDM_YN_ORDER, nRow]) and
             (Cells[GDM_CD_MENU,  liRow] = Cells[GDM_CD_MENU,  nRow]) and
             (Cells[GDM_DS_MENU,  liRow] = Cells[GDM_DS_MENU,  nRow]) and
             (Cells[GDM_DS_SALE,  liRow] = Cells[GDM_DS_SALE,  nRow]) and
             (Cells[GDM_DC_MENU,  liRow] = Cells[GDM_DC_MENU,  nRow]) and
             (Cells[GDM_SEQ,      liRow] = Cells[GDM_SEQ,      nRow]) then
          begin
            //주방주문서 취소내역 저장                    GDM_NEPUM
            if Cells[GDM_DS_MENU, nRow] = 'W' then vTemp := Cells[GDM_VIEWQTY, nRow]
            else                                   vTemp := IntToStr(ABS(aQty * StoI(Cells[GDM_NEPUM, nRow])) );
            if aPrint = 'Y' then
              Common.Device.OrderCancel(Main_sGrd, nRow, vTemp);
            Common.DeleteRow(Main_sGrd, nRow);
            goto go;
          end;
        end;
        Common.DeleteRow(Main_sGrd, liRow);
      end
      else
      begin
        liRow := Row;
        For nRow := liRow+1 to RowCount-1 do
        begin
          if (Cells[GDM_YN_ORDER, liRow] = Cells[GDM_YN_ORDER, nRow]) and
             (Cells[GDM_CD_MENU,  liRow] = Cells[GDM_CD_MENU,  nRow]) and
             (Cells[GDM_DS_MENU,  liRow] = Cells[GDM_DS_MENU,  nRow]) and
             (Cells[GDM_DS_SALE,  liRow] = Cells[GDM_DS_SALE,  nRow]) and
             (Cells[GDM_DC_MENU,  liRow] = Cells[GDM_DC_MENU,  nRow]) and
             (Cells[GDM_SEQ,      liRow] = Cells[GDM_SEQ,      nRow]) then
          begin
           //주방주문서 취소내역 저장
            if Cells[GDM_DS_MENU, nRow] = 'W' then vTemp := Cells[GDM_VIEWQTY, nRow]
            else                                   vTemp := IntToStr(ABS(aQty * StoI(Cells[GDM_NEPUM, nRow])) );

            if (aQty < 0) and (Cells[GDM_YN_ORDER, Row] = 'Y') then
              Common.Device.OrderCancel(Main_sGrd, nRow, vTemp);
            Cells[GDM_QTY, nRow]     := IntToStr( StoI(Cells[GDM_QTY, nRow]) +
                                                  StoI(Cells[GDM_NEPUM, nRow]) * aQty );
            //아이템메뉴이면 부메뉴에 금액을 수량에 맞게 반영한다
            if (Cells[GDM_DS_MENU,  liRow] = 'I') and (Cells[GDM_CD_MENU1,  nRow] <> '') then
              Cells[GDM_AMT,  nRow] := IntToStr(StoI(Cells[GDM_QTY, nRow]) * StoI(Cells[GDM_PR_SALE, nRow]));

            Cells[GDM_VIEWQTY, nRow] := Cells[GDM_QTY, nRow];
          end;
        end;
        Cells[GDM_QTY,     liRow] := IntToStr(StoI(Cells[GDM_QTY, liRow]) + aQty);                           //수량추가
        Cells[GDM_VIEWQTY, liRow] := Cells[GDM_QTY, liRow];
        Cells[GDM_AMT,     liRow] := IntToStr(StoI(Cells[GDM_QTY,liRow])* ( StoI(Cells[GDM_PR_SALE,liRow]) + Ifthen(Cells[GDM_DS_SALE,liRow]='D', 0, StoI(Cells[GDM_PR_ITEM,liRow])) ) );; //수량추가에 따른 금액변경
      end;
      SetRowNumber;
      SetRowSelect;
      if aQty < 0 then
        SaveAuditor('D',aMenu, aQty, aPrice, aQty*aPrice);
      QtyChg_SGrdApply(aMenu, lsSale, aItem,  aQty, aPrice, aMenuDc);
      Cells[GDM_VIEWQTY, liRow] := Common.GetQtyReplace(Cells[GDM_DS_MENU, liRow], Cells[GDM_QTY, liRow]);

      //스템프사용내역은 없앤다
      for liRow := 0 to Main_sGrd.RowCount-1 do
      begin
         Main_sGrd.Cells[GDM_DC_STAMP,  liRow] := '0';
         Main_sGrd.Cells[GDM_USE_STAMP, liRow] := '0';
      end;
      for liRow := 0 to Common.Summary_sGrd.RowCount-1 do
      begin
         Common.Summary_sGrd.Cells[GDM_DC_STAMP,  liRow] := '0';
         Common.Summary_sGrd.Cells[GDM_USE_STAMP, liRow] := '0';
      end;
      Common.PreSent.StampDc  := 0;
      Common.PreSent.UseStamp := 0;

      DisplayPresent;
   end;
   //총금액보다 영수증할인 금액이 클때 할인내역을 삭제한다
   if Common.PreSent.TotalAmt < Abs(Common.PreSent.RcpDc) then
   begin
     Common.PreSent.RcpDc      := 0;
     Common.PreSent.RcpDc_Rate := 0;
   end;

   //총금액보다 쿠폰할인 금액이 클때 할인내역을 삭제한다
   if Common.PreSent.TotalAmt < Abs(Common.PreSent.CouponDc) then
   begin
     Common.PreSent.CouponNo   := '';
     Common.PreSent.CouponType := '';
     Common.PreSent.CouponRate := 0;
     Common.PreSent.CouponLimit:= 0;
     Common.PreSent.CouponDc   := 0;
   end;
end;

//**************************************************************************//
//                       오픈세트 메뉴
//**************************************************************************//
procedure TOrder_F.Act_OpenSetExecute(Sender: TObject);
var vIndex, vRow :Integer;
    vItems :String;
begin
  if not Assigned(OpenSet_F) then
    OpenSet_F      := TOpenSet_F.Create(Application);

  vItems := '';
  if OpenSet_F.ShowModal = mrOK then
  begin
    vRow := Main_sGrd.Row;

    For vIndex := 0 to OpenSet_F.sgr_Grid.RowCount-1 do
      vItems := vItems + Format('%s,%s|',[OpenSet_F.sgr_Grid.Cells[3, vIndex], OpenSet_F.sgr_Grid.Cells[2, vIndex]]);

    Common.Menu.cd_item := vItems;
    MainGrid_add;

    Common.Menu.pr_sale := 0;
    For vIndex := 0 to OpenSet_F.sgr_Grid.RowCount-1 do
    begin
      Common.Menu.no_step   := StoI(OpenSet_F.sgr_Grid.Cells[0, vIndex]);
      Common.Menu.nm_menu   := OpenSet_F.sgr_Grid.Cells[1, vIndex];
      Common.Menu.cd_menu1  := OpenSet_F.sgr_Grid.Cells[3, vIndex];
      Common.Menu.qty_nepum := StoI(OpenSet_F.sgr_Grid.Cells[2, vIndex]);
      Common.Menu.kitchen   := Ifthen(GetOption(241)='1', OpenSet_F.sgr_Grid.Cells[4, vIndex], MainKitchen);
      Common.Menu.dc_menu   := 0;
      Common.Menu.no_spc    := '';
      Common.Menu.dc_spc    := 0;
      MainGrid_add;
    end;
    Main_sGrd.Row := vRow;
  end;
{  else
  begin
    Goods_QtyDec(Main_sGrd.Cells[GDM_CD_MENU,Main_sGrd.Row],
                 Main_sGrd.Cells[GDM_CD_ITEM,   Main_sGrd.Row],
                 -1,
                 StoI(Main_sGrd.Cells[GDM_PR_SALE,Main_sGrd.Row]),
                 StoI(Main_sGrd.Cells[GDM_DC_MENU,Main_sGrd.Row]),
                 'Y',
                 'N');
  end;
}
  ReDrowGridTitle;
end;

procedure TOrder_F.SetRowSelect(const AKind:String = '-');
var vRow :Integer;
begin
  with Main_sGrd do
  begin
    if Cells[0,0] = '' then Exit;
    if AKind = '-' then
    begin
      For vRow := Row downto 0 do
      begin
        if Cells[GDM_CD_MENU1, vRow] = '' then
        begin
          Row := vRow;
          Break;
        end;
      end;
    end
    else
    begin
      For vRow := Row to RowCount-1 do
      begin
        if Cells[GDM_CD_MENU1, vRow] = '' then
        begin
          Row := vRow;
          Break;
        end;
      end;
    end;
  end;
end;

procedure TOrder_F.CardLogButtonClick(Sender: TObject);
begin
  CardLog_F := TCardLog_F.Create(Self);
  try
    CardLog_F.ShowModal;
  finally
    FreeAndNil(CardLog_F);
  end;
end;

function TOrder_F.CheckGroupDetail:Boolean;
var vTemp :String;
begin
  if ((Common.Table.GroupType = 'M') and (Common.Table.BookingImg = '☎') and (Common.Table.BookingNo <> EmptyStr)) or
     ((Common.Table.GroupType = 'M') and (Common.Table.BookingImg = '') and (Common.Table.BookingNo = EmptyStr)) or
     ((Common.Table.GroupType <> 'M') and (Common.Table.BookingNo <> EmptyStr)) then
  begin
    OpenQuery('select ConCat(Cast(t1.NO_TABLE as Char), '' 테이블을 '' , t1.LAST_POS , '' 포스가 사용중입니다'') '
             +'  from SL_ORDER_H t1 inner join'
             +'     	(select CD_STORE, '
             +'               NO_TABLE '
             +'	         from MS_TABLE '
             +'	        where NO_TABLE <> NO_TABLE_GROUP '
             +'	          and NO_TABLE_GROUP = :P1 '
             +'       ) t2 on t1.CD_STORE    = t2.CD_STORE '
             +'           and t1.NO_TABLE    = t2.NO_TABLE '
             +' where t1.CD_STORE    = :P0 '
             +'   and t1.TABLE_STATE = ''Y'' '
             +'   and t1.DS_ORDER    = ''T'' ',
             [Common.Config.StoreCode,
              Common.Table.Number]);
    vTemp := EmptyStr;
    while not Common.Query.Eof do
    begin
      vTemp := vTemp + Common.Query.Fields[0].AsString + #13;
      Common.Query.Next;
    end;

    if vTemp <> EmptyStr then
    begin
      Common.ErrBox(vTemp);
      Result := False;
    end
    else Result := True;
  end
  else Result := True;
  Common.Query.Close;
end;

function TOrder_F.CheckGroupType: Boolean;
begin
  Result := False;
  if (Common.Table.GroupType <> 'M') and (Common.Table.GroupType <> 'N') and not Common.Config.IsKiosk then
  begin
    Common.ErrBox('그룹으로 지정된 테이블입니다'+#13#13+
                  '그룹마스터인  '+Common.Table.GroupType+' 테이블에서만'+#13+
                  '정산이 가능합니다' );
    Exit;
  end;
  Result := True;
end;

{------------------------------------------------------------------------------}
{ VOID 처리중인지 체크                                                         }
{------------------------------------------------------------------------------}
function TOrder_F.CheckPresentChange(aType:Integer=0):Boolean;
begin
  //결제변경 시 메뉴를 수정할 수 없을때
  if (GetOption(235) = '0') then
  begin
    if Common.OrderKind = okChange then
    begin
      Common.ErrBox('결제변경 중에는 사용할 수 없습니다');
      Result := False;
      Exit;
    end
    else if Common.OrderKind = okBanpum then
    begin
      Common.ErrBox('일부반품 중에는 사용할 수 없습니다');
      Result := False;
      Exit;
    end
    else Result := True;
  end
  else if aType = 1 then
  begin
    if Common.OrderKind = okChange then
    begin
      Result := True;
//      if Common.PreSent.RcvAmt > 0 then
//      begin
//        Common.ErrBox('결제변경 작업 중 에는 결제내역을'+#13+'먼저 취소해야합니다');
//        Result := False;
//        Exit;
//      end
//      else Result := True;
    end
    else if Common.OrderKind = okBanpum then
    begin
      Common.ErrBox('일부반품 작업 중 에는 사용할 수 없습니다');
      Result := False;
      Exit;
    end
    else Result := True;
  end;

  if Common.OrderKind in [okDutchPay, okDutchPayEnd, okDutchPayAll] then
  begin
    Common.ErrBox('더치페이 계산 중 에는 사용할 수 없습니다');
    Result := False;
  end
  else Result := True;

end;

//정산이 완료됐는지 여부
//**************************************************************************//
//                       정산이 완료 됐는지 여부 체크
//**************************************************************************//
function  TOrder_F.CheckSaleFinish:Boolean;
begin
  if WorkState = wsMagam then
  begin
    WorkState := wsReady;
    Result    := True;
  end
  else Result := False;
end;


procedure TOrder_F.Act_BankExecute(Sender: TObject);
var vRtn : String;
begin
  Common.WriteLog('work', '계좌입급');
  if Common.PreSent.WRcvAmt = 0 then
  begin
    Common.ErrBox('받을금액이 없습니다');
    Exit;
  end;

  if Common.Table.AHeadPay then
  begin
    Common.ErrBox('선결제는 신용카드만 가능합니다');
    Exit;
  end;

  vRtn := Common.ShowNumberForm('계좌입금 금액을 입력하세요', 0, 9000000, '0' );

  if vRtn = '' then Exit;

  Common.WriteLog('work', '주문정산-계좌입금('+vRtn+')');
  Common.PreSent.BankAmt := Common.PreSent.BankAmt + + StoI(vRtn);
  DisplayPresent;
  if Common.PreSent.WRcvAmt = 0 then
  begin
    if Common.AskBox('현금영수증을 발행하시겠습니까?') then
    begin
      if Common.ShowCashRcpForm(true, Common.PreSent.BankAmt) then
      begin
        //투밴을 사용하지 않거나 단말기 숭인일때
        if Common.CashRcp.Amt_Approval <> 0 then
        begin
          Common.PreSent.CashRcpAmt := Common.PreSent.CashRcpAmt + Common.CashRcp.Amt_Approval;
          Common.CashRcpInfoSave;
        end;
        InitCashRcpRecord(Common.CashRcp);
      end;
    end;
    FinishExecute('5');
  end;
end;

procedure TOrder_F.Act_CancelExecute(Sender: TObject);
  function Cancel_CashRcp(aCancelAmt:Integer):Boolean;
    function CheckCashCancel(vApprovalNo:String):Boolean;
    var vRow :Integer;
    begin
      Result := False;
      For vRow := 0 to Common.Cash_SGrd.RowCount-1 do
      begin
        if (Common.Cash_SGrd.Cells[GDR_DS_TRD, vRow] = dtCancel) and
           (Common.Cash_SGrd.Cells[GDR_APPROVAL_ORG, vRow] = vApprovalNo) then
        begin
          Result := True;
          Break;
        end;
      end;
    end;
  var vRow :Integer;
  begin
     Result := True;
     //현금영수증 승인이 있을때
     if Common.PreSent.CashRcpAmt = 0 then Exit;

     //현재시재가 취소후 받은금액이 현금영수증 금액보다 작은지
     if ( (Common.PreSent.CashAmt + Common.PreSent.CheckAmt + Common.PreSent.TrustAmt +
           Ifthen(GetOption(441)='0',Common.PreSent.GiftAmt,0) + Common.PreSent.BankAmt)
          - aCancelAmt ) >=  Common.PreSent.CashRcpAmt then Exit;

     if GetOption(51) = '1' then
     begin
       Common.PreSent.CashRcpAmt := 0;
     end
     else
     begin
       with Common.Cash_SGrd do
       For vRow := 0 to RowCount-1 do
       begin
         InitCashRcpRecord(Common.CashRcp);
          if Common.Cash_SGrd.Cells[GDR_YN_AHEAD, vRow] = 'Y' then
          begin
            Common.MsgBox('선결제는 취소할 수 없습니다');
            Exit;
          end;
         if Cells[GDR_DS_TRD, vRow] = dtCancel then Continue;
         if CheckCashCancel(Cells[GDR_NO_APPROVAL, vRow]) then Continue;
         Common.CashRcpInfoLoad(vRow);
         if Common.ShowCashRcpForm(False) then
         begin
           Common.PreSent.CashRcpAmt := Common.PreSent.CashRcpAmt - Common.CashRcp.Amt_Approval;
           if Common.CashRcp.Ds_Input <> 'O' then
             Common.CashRcpInfoSave;
         end
         else
         begin
           Common.ErrBox('현금영수증이 취소되지 않았습니다');
           Result := False;
           Exit;
         end; //if Common.ShowCashRcpForm('1') then
       end; //For liRow := 0 to RowCount-1 do
     end;
  end;
var
    vGrid :TStringGrid;
    vTemp, vType :String;
    vCancelAmt :String;
    vRow :Integer;
    vPartCancel :Boolean;
begin
   //마감 상태였으면 초기화한다
  if CheckSaleFinish then Exit;
  if not Common.CheckAcctPos then Exit;
  if not CheckGroupType then Exit;
  vGrid := TStringGrid.Create(Self);
  Common.GridToGrid(PreSent_sGrd, vGrid);
  vTemp := vGrid.Cells[GDP_KIND,  vGrid.Row];
  vType := vGrid.Cells[GDP_CARDINFO,  vGrid.Row];

  if (vType = 'D') and (vTemp = '쿠폰할인' ) then
  begin
    Common.PreSent.CouponNo  := '';
    Common.PreSent.CouponType:= '';
    Common.PreSent.CouponRate:= 0;
    Common.PreSent.CouponDc  := 0;
    Common.PreSent.CouponMember := false;
    Common.PreSent.CouponMenu   := '';
    DisplayPresent;
    Exit;
  end;

  if (vTemp = '')  or
     ( (vTemp <> '현금')
       and (vTemp <> '수표')
       and (vTemp <> '상품권')
       and (vTemp <> '외상')
       and (vTemp <> '포인트할인')
       and (Copy(vTemp,1,2) <> '카드')
       and (Copy(vTemp,1,2) <> '계좌')
       and (vTemp <> '포인트결제')
       and (Copy(vTemp,1,2) <> '기타')
       and (vTemp <> 'UPLUS 할인') ) then Exit;

  if vTemp = '현금'          then
  begin
    if Common.PreSent.AHeadCashAmt > 0 then
    begin
      Common.MsgBox('선결제는 취소할 수 없습니다');
      Exit;
    end;

    if not Cancel_CashRcp(StoI(vGrid.Cells[GDP_AMT, vGrid.Row])) then Exit;
    Common.Present.CashAmt  := Common.Present.CashAmt  - StoI(vGrid.Cells[GDP_AMT, vGrid.Row]);
  end
  else if vTemp = '포인트할인'     then
  begin
    Common.Present.PointDc := Common.Present.PointDc - StoI(vGrid.Cells[GDP_AMT, vGrid.Row]);
  end
  else if vTemp = '수표'     then
  begin
    if not Cancel_CashRcp(StoI(vGrid.Cells[GDP_AMT, vGrid.Row])) then Exit;
    Common.Present.CheckAmt := Common.Present.CheckAmt - StoI(vGrid.Cells[GDP_AMT, vGrid.Row]);
  end
  else if vTemp = '상품권'   then
  begin
    if not Cancel_CashRcp(StoI(vGrid.Cells[GDP_AMT, vGrid.Row])) then Exit;
    Common.Present.GiftAmt  := Common.Present.GiftAmt  - StoI(vGrid.Cells[GDP_AMT, vGrid.Row]);
  end
  else if vTemp = '외상'     then
  begin
    Common.Present.TrustAmt := Common.Present.TrustAmt - StoI(vGrid.Cells[GDP_AMT, vGrid.Row]);
    if Common.OrderKind = okChange then
      Common.Member.CreditAmt := Common.Member.CreditAmt - StoI(vGrid.Cells[GDP_AMT, vGrid.Row]);
  end
  else if vTemp = '계좌입금'   then
  begin
    if not Cancel_CashRcp(StoI(vGrid.Cells[GDP_AMT, vGrid.Row])) then Exit;
    Common.Present.BankAmt := Common.Present.BankAmt - StoI(vGrid.Cells[GDP_AMT, vGrid.Row]);
  end
  else if vTemp = '기타결제'   then
  begin
    Common.Present.EtcAmt := Common.Present.EtcAmt - StoI(vGrid.Cells[GDP_AMT, vGrid.Row]);
  end
  else if vTemp = '포인트결제'   then
  begin
    Common.Present.PointAmt := Common.Present.PointAmt - StoI(vGrid.Cells[GDP_AMT, vGrid.Row]);
  end
  else if vTemp = 'UPLUS 할인'   then
  begin
    if Common.UPlusInfoLoad(False) then
    begin
      if Common.ShowUPlusForm(False) then
      begin
        Common.PreSent.UPlusDc := 0;
        Common.ClearGrid(Common.UPlus_sGrd);
      end;
    end;
  end
  else if vTemp = '카카오 할인'   then
  begin
    Common.MsgBox('카카오할인은 임의로 취소할 수 없습니다');
    Exit;
  end
  else  //신용카드
  begin
    if GetOption(51) = '1' then
    begin
      Common.PreSent.CardAmt := 0;
    end
    else
    begin
//      vRow := StrToInt(vGrid.Cells[GDP_ROW,  vGrid.Row]);
      vRow := vGrid.Row;
      Common.CardInfoLoad(StoI(vGrid.Cells[GDP_CARD,  vRow]));

      if Common.Card_sGrd.Cells[GDC_DS_CARD, vRow] = 'P' then
      begin
        if (Common.OrderKind = okAppend) or (Common.OrderKind = okNew) then
        begin
          vCancelAmt := Common.ShowNumberForm('취소금액을 입력하세요', 0, StrToInt(Common.Card_sGrd.Cells[GDC_AMT, vRow])-StrToInt(Common.Card_sGrd.Cells[GDC_AMT_CANCEL, vRow]), '0');
          if (vCancelAmt = 'mrClose') or (vCancelAmt ='0') then Exit;
        end
        else
          vCancelAmt := Common.Card_sGrd.Cells[GDC_AMT, vRow];

        vPartCancel := vCancelAmt <> Common.Card_sGrd.Cells[GDC_AMT, vRow];

        if Common.PGCardCancel('',Common.Card_sGrd.Cells[GDC_PG_TID, vRow], StrToInt(vCancelAmt), vPartCancel) then
        begin
          Application.ProcessMessages;
          //선결제 취소일때
          if Common.Card_sGrd.Cells[GDC_YN_AHEAD, vRow] = 'Y' then
          begin
            if vPartCancel then
            begin
              ExecQuery('insert into SL_CARD_AHEAD(CD_STORE, '
                       +'                      	 	 NO_TABLE, '
                       +'                          DS_CARD, '
                       +'                          DS_TRD, '
                       +'                          TYPE_TRD, '
                       +'                          PG_TID, '
                       +'                      		 SEQ, '
                       +'                          NO_APPROVAL, '
                       +'                          AMT_APPROVAL, '
                       +'                      		 AMT_VAT, '
                       +'                          TRD_DATE, '
                       +'                      		 TRD_TIME, '
                       +'                      		 NO_CARD, '
                       +'                      		 NM_CARDPL, '
                       +'                          TERM_HALBU, '
                       +'                      		 DT_INSERT) '
                       +'                   VALUES(:P0, '       //    CD_STORE, '
                       +'                      		 :P1, '       //    NO_TABLE, '
                       +'                          ''P'', '
                       +'                          ''C'', '
                       +'                          :P2, '
                       +'                          :P3, '       //
                       +'                      		(select Ifnull(Max(SEQ), 0) + 1 '
                       +'                             from SL_CARD_AHEAD as s '
                       +'                            where CD_STORE	=:P0 '
                       +'	                             and NO_TABLE	=:P1), '
                       +'                      		 :P4, '      //    NO_APPORVAL, '
                       +'                      		 :P5, '      //    AMT_CARD, '
                       +'                      		 0, '        //
                       +'                      		 :P6, '      //    YMD_APPROVAL, '
                       +'                      		 :P7, '      //    TIME_APPROVAL, '
                       +'                      		 :P8, '      //    NO_CARD, '
                       +'                          :P9, '      //    NM_CARD, '
                       +'                          ''00'', '   //    HALBU
                       +'                      		 Now()) ',
                       [Common.Config.StoreCode,
                        Common.Table.Number,
                        Common.Card.Type_Trd,
                        Common.Card.PG_TID,
                        Common.Card.ApprovalNo,
                        Common.Card.Amt,
                        Common.Card.Trd_Date,
                        Common.Card.Trd_Time,
                        Common.Card_sGrd.Cells[GDC_CARDNO, vRow],
                        Common.Card_sGrd.Cells[GDC_NAME, vRow]]);

              Common.Card.Ds_Card       := 'P';
              Common.Card.Ds_trd        := dtCancel;
              Common.Card.Yn_Save       := 'Y';
              Common.Card.Type_Trd      := Common.Card_sGrd.Cells[GDC_TYPE_TRD, vRow];
              Common.Card.OrgApprovalNo := Common.Card_sGrd.Cells[GDC_APPROVAL_ORG, vRow];
              Common.Card.Nm_Card       := Common.Card_sGrd.Cells[GDC_NAME, vRow];
              Common.Card.CardNo        := Common.Card_sGrd.Cells[GDC_CARDNO, vRow];
              Common.Card.Trd_Date_Org  := Common.Card_sGrd.Cells[GDC_TRD_DATE, vRow];
              Common.Card.Halbu         := Common.Card_sGrd.Cells[GDC_HALBU, vRow];
              Common.CardInfoSave(2);
              Common.Card_sGrd.Cells[GDC_AMT_CANCEL, vRow] := IntToStr(Common.Card.Amt);

              ExecQuery('update SL_CARD_AHEAD '
                       +'   set AMT_CANCEL = AMT_CANCEL + :P3 '
                       +' where CD_STORE =:P0 '
                       +'   and NO_TABLE =:P1 '
                       +'   and PG_TID   =:P2 ',
                       [Common.Config.StoreCode,
                        Common.Table.Number,
                        Common.Card_sGrd.Cells[GDC_PG_TID, vRow],
                        Common.Card.Amt]);
            end;
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
                     +'                     0, '
                     +'                     ''A'', '
                     +'                     :P1, '
                     +'                     :P2, '
                     +'                     0, '
                     +'                     :P3, '
                     +'                     :P4, '
                     +'                     ''P'')',
                     [Common.Config.StoreCode,
                      Ifthen(StoI(Common.Card_sGrd.Cells[GDC_ORG_TABLENO, vRow]) > 0, StoI(Common.Card_sGrd.Cells[GDC_ORG_TABLENO, vRow]), Common.Table.Number),
                      Common.Card.PG_TID,
                      Common.Card_sGrd.Cells[GDC_NAME,   vRow],
                      Common.Card.Amt*-1]);

            Common.PreSent.LetsOrderAmt := Common.PreSent.LetsOrderAmt - Common.Card.Amt;

            if vPartCancel then
              Common.MsgBox('정상취소 되었습니다'#13#13'일부금액 취소 시에는 고객에게'#13'취소내역은 2,3일 이후에 전송됩니다')
            else
            begin
              //일부 취소가 아니면 레코드 삭제
              ExecQuery('delete '
                       +'  from SL_CARD_AHEAD '
                       +' where CD_STORE =:P0 '
                       +'   and NO_TABLE =:P1 '
                       +'   and PG_TID   =:P2 ',
                       [Common.Config.StoreCode,
                        Common.Table.Number,
                        Common.Card_sGrd.Cells[GDC_PG_TID, vRow]]);
              Common.DeleteRow(Common.Card_sGrd, vRow);
            end;
          end
          else
          begin
            Common.Card_sGrd.Cells[GDC_YN_CAN, vRow] := 'Y';
            Common.Card.CardNo         := Common.Card_sGrd.Cells[GDC_CARDNO, vRow];
            Common.Card.Nm_Card        := Common.Card_sGrd.Cells[GDC_NAME, vRow];
            Common.Card.OrgApprovalNo  := Common.Card_sGrd.Cells[GDC_NO_APPROVAL, vRow];
            Common.Card.Halbu          := Common.Card_sGrd.Cells[GDC_HALBU, vRow];
            Common.Card.Trd_Date_Org   := Common.Card_sGrd.Cells[GDC_TRD_DATE, vRow];
            Common.Card.VatAmt         := StrToInt(Common.Card_sGrd.Cells[GDC_VATAMT, vRow]);
            //취소한 내역은 그리드에서 삭제한다
            Common.DeleteRow(Common.Card_sGrd, vRow);

            Common.CardInfoSave;
            Common.PreSent.LetsOrderAmt     := Common.PreSent.LetsOrderAmt - Common.Card.Amt;
          end;
        end;
      end
      else
      begin
        if Common.Card_SGrd.Cells[GDC_YN_AHEAD, vRow] = 'Y' then
        begin
          Common.MsgBox('선결제는 취소할 수 없습니다');
          Exit;
        end;

        if Common.ShowCardForm(false, False) then
        begin
          //취소가 됐으면 저장은 안하도록...
          Common.Card_SGrd.Cells[GDC_YN_CAN, vRow] := 'N';
          Common.Card.Yn_Can   := 'N';
          Common.Card.Yn_Print := 'Y';
          Common.Card.Yn_Save  := 'Y';
          Common.CardInfoSave;
          Common.PreSent.CardAmt    := Common.PreSent.CardAmt    - Common.Card.Amt;
          Common.PreSent.CardTipAmt := Common.PreSent.CardTipAmt - Common.Card.TipAmt;
        end;
        Common.GetCardLog;
        InitCardRecord(Common.Card);
      end;
    end;
  end;
  DisplayPresent;
end;

procedure TOrder_F.Act_CardExecute(Sender: TObject);
begin
  ExecCard(false);
end;

//**************************************************************************//
//                         수표버튼
//**************************************************************************//
procedure TOrder_F.Act_CheckExecute(Sender: TObject);
begin
  //Kiosk 모드
  if Common.Config.IsKiosk then
  begin
    Common.ErrBox(Format('해당기능을 사용할 수 없습니다[%s]',['Act_CheckExecute']));
    Exit;
  end;

  if not CheckPrevAccount then Exit;
  if CheckSaleFinish then Exit;
  if Common.Table.AHeadPay then
  begin
    Common.ErrBox('선결제는 신용카드만 가능합니다');
    Exit;
  end;
  if not Common.CheckAcctPos then Exit;
  if not CheckGroupType then Exit;
  if Common.ShowCheckForm then DisplayPresent;
end;

//**************************************************************************//
//                         외상버튼
//**************************************************************************//
procedure TOrder_F.Act_TrustExecute(Sender: TObject);
var vRtn :String;
begin
  Common.WriteLog('work', '외상결제');

  //마감 상태였으면 초기화한다
  if CheckSaleFinish then Exit;

  if Common.IsWorking then Exit;
  Common.IsWorking := True;
  try
    if not CheckPrevAccount then Exit;
    if not Common.CheckAcctPos then Exit;
    if not CheckGroupType then Exit;
    if Common.Table.AHeadPay then
    begin
      Common.ErrBox('선결제는 현금과 신용카드만 가능합니다');
      Exit;
    end;

    //회원만 외상이 가능할때
    if GetOption(250) = '1' then
    begin
      if Common.Member.Code = '' then
      begin
        if Common.ShowMemberForm then
          DisplayPresent
        else
        begin
          Common.ErrBox('회원만 외상이 가능합니다');
          Exit;
        end;
      end;

      if Common.Member.Yn_trust = 'N' then                                 
      begin
        Common.ErrBox('외상을 할 수 없는 회원입니다');
        Exit;
      end;
    end;

    if (Common.PreSent.WRcvAmt = 0) and not Common.Config.IsKiosk then
    begin
      Common.ErrBox('받을금액이 없습니다');
      Exit;
    end;

    //외상결제 시 금액을 입력받을때
    if (GetOption(287) = '0') and not Common.Config.IsKiosk then
    begin
      if (Common.Member.Code = '') and not Common.AskBox('일반고객입니다'#13'외상으로 결제하시겠습니까?') then Exit;

      vRtn := Common.ShowNumberForm('외상금액을 입력하세요', 0, FtoI(Common.PreSent.WRcvAmt), FtoS(Common.PreSent.WRcvAmt) );
      if vRtn = 'mrClose' then Exit;
      //선충전 외상방식 일때
      if GetOption(292) = '1' then
      begin
        if (Common.Member.CreditAmt*-1) < (Common.PreSent.TrustAmt + StoI(vRtn))  then
        begin
          Common.ErrBox('선충전금액이 부족합니다');
          Exit;
        end;
      end;

      Common.PreSent.TrustAmt := Common.PreSent.TrustAmt + StoI(vRtn);
    end
    else
    begin
      if GetOption(292) = '1' then
      begin
        if (Common.Member.CreditAmt*-1) < (Common.PreSent.TrustAmt + Common.PreSent.WRcvAmt)  then
        begin
          Common.ErrBox('선충전금액이 부족합니다');
          Exit;
        end;
      end;

      Common.PreSent.TrustAmt := Common.PreSent.TrustAmt + Common.PreSent.WRcvAmt;
    end;

    DisplayPresent;
    Common.IsWorking := False;
    if Common.PreSent.WRcvAmt = 0 then
      FinishExecute('6');
  finally
    Common.IsWorking := False;
    BlockInput(false);
    Common.Device.OnScannerReadData := ScannerReadEvent;
  end;
end;

procedure TOrder_F.ReceiptPrintButtonClick(Sender: TObject);
begin
  if Sender = ReceiptPrintButton then
  begin
    if ReceiptPrintMode = pmPrint then
      ReceiptPrintYesButtonClick(ReceiptPrintNoButton)
    else
      ReceiptPrintYesButtonClick(ReceiptPrintYesButton);

    Common.WriteLog('work', Format('영수증 출력 %s',[Ifthen(ReceiptPrintMode = pmPrint,'Yes','No')]));
  end
  else if Sender = BillPrintButton then
  begin
    if BillPrintMode  then
      ReceiptPrintYesButtonClick(BillPrintNoButton)
    else
      ReceiptPrintYesButtonClick(BillPrintYesButton);
    Common.WriteLog('work', Format('고객주문서 출력 %s',[Ifthen(BillPrintMode,'Yes','No')]));
  end
  else if Sender = KitchenPrintButton then
  begin
    if KitchenPrintMode  then
      ReceiptPrintYesButtonClick(KitchenReceiptOffButton)
    else
      ReceiptPrintYesButtonClick(KitchenReceiptOnButton);
    Common.WriteLog('work', Format('주방주문서 출력 %s',[Ifthen(KitchenPrintMode,'Yes','No')]));
  end
  else if Sender = MenuPrintButton then
  begin
    if MenuPrintMode  then
      ReceiptPrintYesButtonClick(MenuPrintNoButton)
    else
      ReceiptPrintYesButtonClick(MenuPrintYesButton);
    Common.WriteLog('work', Format('영수증 메뉴 출력 %s',[Ifthen(MenuPrintMode,'Yes','No')]));
  end;
end;

procedure TOrder_F.ReceiptPrintYesButtonClick(Sender: TObject);
begin
  if Sender = ReceiptPrintYesButton then
    ReceiptPrintMode := pmPrint
  else if Sender = ReceiptPrintNoButton then
    ReceiptPrintMode := pmNoPrint
  else if Sender = MenuPrintYesButton then
    MenuPrintMode := true
  else if Sender = MenuPrintNoButton then
    MenuPrintMode := false
  else if Sender = KitchenReceiptOnButton then
    KitchenPrintMode := true
  else if Sender = KitchenReceiptOffButton then
    KitchenPrintMode := false
  else if Sender = BillPrintYesButton then
    BillPrintMode := true
  else if Sender = BillPrintNoButton then
    BillPrintMode := false
  else if Sender = CardPrintAtOnceYesButton then
    CardPrintMode := true
  else if Sender = CardPrintAtOnceNoButton then
    CardPrintMode := false
  else if Sender = CardPrintSplitOffButton then
    SplitPrintMode := true
  else if Sender = CardPrintSplitOnButton then
    SplitPrintMode := false;

  PrintOptionPanel.Visible := false;
end;

procedure TOrder_F.ReDrowGridTitle;
begin
  if Common.Config.IsKiosk then Exit;

  if Assigned(TAdvShape(FindComponent('GridTitleTempShape'))) then
    TAdvShape(FindComponent('GridTitleTempShape')).Destroy;

  with TAdvShape.Create(Self) do
  begin
    Name        := 'GridTitleTempShape';
    Parent      := Self;
    Top         := GridTitleShape.Top;
    Left        := GridTitleShape.Left;
    Height      := GridTitleShape.Height;
    Width       := GridTitleShape.Width;
    BackGround  := GridTitleShape.BackGround;
    Bevel       := GridTitleShape.Bevel;
    RotationAngle := GridTitleShape.RotationAngle;
    Rounding      := GridTitleShape.Rounding;
    Shape       := GridTitleShape.Shape;
    ShapeHeight := GridTitleShape.ShapeHeight;
    ShapeWidth  := GridTitleShape.ShapeWidth;
    Text        := GridTitleShape.Text;
    Appearance := GridTitleShape.Appearance;
    TextOffsetX  := GridTitleShape.TextOffsetX;
    TextOffsetY  := GridTitleShape.TextOffsetY;
    AutoSize    := false;
  end;
end;

procedure TOrder_F.MenuPrintYesButtonClick(Sender: TObject);
begin
end;

//**************************************************************************//
//                         포인트버튼
//**************************************************************************//
procedure TOrder_F.Act_PointExecute(Sender: TObject);
var vTemp, vKey :String;
    vPoint :Integer;
    vResult :String;
begin
  Common.WriteLog('work', '포인트결제');
   //마감 상태였으면 초기화한다
  if CheckSaleFinish then Exit;
  if Common.IsWorking then Exit;
  Common.IsWorking := True;
  try
    if not CheckPrevAccount then Exit;
    if not Common.CheckAcctPos then Exit;
    if not CheckGroupType then Exit;

    if (GetOption(306) = '1') and (Common.OrderKind = okChange) then
    begin
      Common.ErrBox('결제변경시 에는 포인트할인을 할 수 없습니다');
      Exit;
    end;

    if Common.Table.AHeadPay then
    begin
      Common.ErrBox('포인트는 선결제할 수 없습니다');
      Exit;
    end;

    if Common.Member.Code = '' then
    begin
      if Common.ShowMemberForm then
        DisplayPresent
      else
      begin
        Common.ErrBox('회원만 포인트 사용이 가능합니다');
        Exit;
      end;
    end
    else  if (Common.OrderKind = okChange) and ((Common.PreSent.OccurPnt > 0) or (Common.PreSent.UsePnt > 0)) then
    begin
      Common.ErrBox('포인트를 적립/사용한 영수증은'#13'포인트를 사용할 수 없습니다');
      Exit;
    end;

    if Common.Member.Point <= 0 then
    begin
      Common.ErrBox('잔여 포인트가 부족합니다');
      Exit;
    end;

    if Common.Config.pnt_min_use > Common.Member.Point then
    begin
      Common.ErrBox(Format('잔여포인트가 %d점 이상만'#13#13'사용이 가능합니다',[Common.Config.pnt_min_use]));
      Exit;
    end;

    if Common.PreSent.WRcvAmt = 0 then
    begin
      Common.ErrBox('받을금액이 없습니다');
      Exit;
    end;

    //포인트를 사용할때는 서버에서 현재포인트를 다시 조회한다
    try
      if DM.OpenCloud('select TOTAL_POINT '
                     +'  from MS_MEMBER_ETC '
                     +' where CD_HEAD   =:P0 '
                     +'   and CD_STORE  =:P1 '
                     +'   and CD_MEMBER =:P2 ',
                     [Common.Config.HeadStoreCode,
                      Ifthen(GetHeadOption(5)='0', Common.Config.StoreCode, StandardStore),
                      Common.Member.Code],Common.RestDBURL) then
      begin
        if not DM.CloudData.Eof then
        begin
          ExecQuery('update MS_MEMBER '
                   +'   set TOTAL_POINT = :P2 '
                   +' where CD_STORE  =:P0 '
                   +'   and CD_MEMBER =:P1 ',
                   [Common.Config.StoreCode,
                    Common.Member.Code,
                    DM.CloudData.Fields[0].AsInteger]);
          Common.Member.Point := DM.CloudData.Fields[0].AsInteger;
        end;
      end
      else
        Common.WriteLog('Act_PointExecute',Format('오프라인 시 포인트사용(%s-%d)',[Common.Member.Code,Common.Member.Point]));

    finally
      DM.CloudData.Close;
    end;

    if not Common.Config.IsKiosk then
    begin
      if Common.Member.Point <= Common.PreSent.WRcvAmt then
        vPoint := Common.Member.Point
      else
        vPoint := Common.PreSent.WRcvAmt;

      vTemp := Common.ShowNumberForm('사용 할 포인트를 입력하세요', 0, vPoint,IntToStr(vPoint));
      if vTemp = 'mrClose' then Exit;


      if Common.Member.Point < StoI(vTemp) then
      begin
        Common.ErrBox('포인트가 부족합니다');
        Exit;
      end;
    end
    else
      vTemp := IntToStr(Common.PreSent.WRcvAmt);

    if (GetOption(391)='0') and (Common.Config.pnt_min_use > StoI(vTemp)) then
    begin
      Common.ErrBox(Format('%d점 이상부터 사용이 가능합니다',[Common.Config.pnt_min_use]));
      Exit;
    end;

    if (Common.PreSent.TotalAmt - Common.PreSent.ExistPointUseAmt) < StoI(vTemp) then
    begin
      Common.ErrBox('포인트사용 제한 메뉴가 있습니다');
      Exit;
    end;

    Common.WriteLog('work', Format('포인트사용[%d, %d] - %s', [Common.Member.Point, StoI(vTemp), Common.Member.Code]));


    //포인트사용 시 휴대폰 본인확인기능
{    if GetOption(404) = '1' then
    begin
      while Length(vKey) <> 4 do
        vKey := IntToStr(Random(9999));

      vResult := Common.KakaoSendMessage('3'+#28+Common.Config.StoreCode+#28+
                                               GetOnlyNumber(Common.Member.MobileTel)+#28+
                                               GetOnlyNumber(Common.Config.StoreTel)+#28+
                                               Format('[%s]포인트사용 [%s] 인증번호입니다',[Common.Config.StoreName, vKey])+#28);
      if vResult <> '' then
      begin
        Common.ErrBox(vResult);
        Exit;
      end;

      if not Common.AskBox(Format('인증번호 [ %s ] 맞습니까?',[vKey])) then Exit;
    end;
}
    Common.PreSent.UsePnt   := StoI(vTemp);
    if GetOption(372) = '1' then
      Common.PreSent.PointDc  := StoI(vTemp)
    else
      Common.PreSent.PointAmt := StoI(vTemp);

    DisplayPresent;
    Common.IsWorking := False;
    if Common.PreSent.WRcvAmt = 0 then
      FinishExecute('7');
  finally
    Common.IsWorking := False;
    BlockInput(false);
    Common.Device.OnScannerReadData := ScannerReadEvent;
  end;
end;

//**************************************************************************//
//                         현금버튼
//**************************************************************************//
procedure TOrder_F.Act_CashExecute(Sender: TObject);
begin
  if Common.Config.IsKiosk then
  begin
    Common.ErrBox(Format('해당기능을 사용할 수 없습니다[%s]',['Act_CashExecute']));
    Exit;
  end;
  if Common.Table.AHeadPay then
  begin
    Common.ErrBox('선결제는 신용카드만 가능합니다');
    Exit;
  end;
   //마감 상태였으면 초기화한다
  if not CheckPrevAccount then Exit;
  if CheckSaleFinish then Exit;
  if Common.IsWorking then Exit;
  Common.IsWorking := True;
  try
    if not Common.CheckAcctPos then Exit;
    if Common.PreSent.WRcvAmt = 0 then
    begin
      Common.ErrBox('받을금액이 없습니다');
      Exit;
    end;
    if not CheckGroupType then Exit;
    Common.WriteLog('work', '복합결제');

    if Cash_F.ShowModal = mrAbort then
    begin
      //선결제버튼
      Common.IsWorking := False;
      Action22.Execute;
    end
    else
    begin
      Common.IsWorking := False;
      DisplayPresent;
      if Common.PreSent.WRcvAmt = 0 then
        FinishExecute('8');
    end;
  finally
    ReDrowGridTitle;
    Common.IsWorking := False;
    Common.Device.OnScannerReadData := ScannerReadEvent;
  end;
end;

//**************************************************************************//
//                         현금영수증
//**************************************************************************//
procedure TOrder_F.Act_CashRcpExecute(Sender: TObject);
var vPoint, vNowPoint :TPoint;
    vInputAmt :Integer;
begin
  if Common.Config.IsKiosk then
  begin
    Common.ErrBox(Format('해당기능을 사용할 수 없습니다[%s]',['Act_CashRcpExecute']));
    Exit;
  end;

  if CheckSaleFinish then Exit;
  if not CheckPrevAccount then Exit;
  if not Common.CheckAcctPos then Exit;
  if not CheckGroupType then Exit;

  InitCashRcpRecord(Common.CashRcp);

  if (Common.PreSent.WRcvAmt = 0) then
  begin
    Common.ErrBox('받을금액이 없습니다');
    Exit;
  end;
  Common.WriteLog('work', '현금영수증');

  //신용카드/현금영수증 기능을 사용하지 않는다고 설정했으면
  if GetOption(51) = '1' then
  begin
    Common.PreSent.CashAmt    := Common.PreSent.CashAmt    + Common.PreSent.WRcvAmt;
    Common.PreSent.CashRcpAmt := Common.PreSent.WRcvAmt;
    DisplayPresent;{시재화면에 보이기}
    FinishExecute('9');
    Exit;
  end;

  if (GetOption(376) = '1') and (Length(FMsrData) > 3) and (Length(FMsrData) <= 7) and (FMsrData = GetOnlyNumber(FMsrData)) and (StrToInt(FMsrData) mod 10 = 0) then
  begin
    vInputAmt := StrToInt(FMsrData);
    FMsrData  := EmptyStr;
    DisplayMessage(3, '');
  end
  else
    vInputAmt := 0;

  if Common.ShowCashRcpForm(true, vInputAmt) then
  begin
    if Present_sGrd.Enabled and not Common.Table.AHeadPay then
    begin
      GetCursorPos(vNowPoint);
      vPoint := Present_sGrd.ClientToScreen(Point(5,5));
      SetCursorPos(vPoint.X, vPoint.Y);
      mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
      mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
      SetCursorPos(vNowPoint.X, vNowPoint.Y);
    end;

    //선결제일때
    if Common.Table.AHeadPay then
    begin
//      Common.AHeadCardDataSave;
      if (Common.CashRcp.Amt_Approval <> 0) then
      begin
        Common.PreSent.CashRcpAmt := Common.PreSent.CashRcpAmt + Common.CashRcp.Amt_Approval;
        Common.CashRcpInfoSave;
      end;
      Common.AHeadCashDataSave;
      Common.PreSent.AHeadPayAmt  := Common.PreSent.CardAmt + Common.PreSent.CashRcpAmt;
      Common.PreSent.AHeadCashAmt := Common.PreSent.AHeadCashAmt + Common.PreSent.CashRcpAmt;
      CloseButtonClick(nil);
      Exit;
    end;


    if (Common.CashRcp.Amt_Approval <> 0) then
    begin
      Common.PreSent.CashAmt    := Common.PreSent.CashAmt    + Common.CashRcp.RcvAmt;
      Common.PreSent.CashRcpAmt := Common.PreSent.CashRcpAmt + Common.CashRcp.Amt_Approval;
      Common.CashRcpInfoSave;
    end;
    DisplayPresent;
    if (Common.PreSent.WRcvAmt = 0) then
      FinishExecute('10');
  end;
  ReDrowGridTitle;
end;

//**************************************************************************//
//                         현금정산버튼
//**************************************************************************//
procedure TOrder_F.Act_EasyPayExecute(Sender: TObject);
begin
  ExecCard(true);
end;

procedure TOrder_F.Act_EnterExecute(Sender: TObject);
begin
  FinishExecute('0');
end;

//**************************************************************************//
//                        주방 주문서 조합
//                 aKind : 1-저장, 0-저장하지 않는다
//**************************************************************************//
procedure TOrder_F.SetKitchenOrderData;
  function OrderCount(aCode:String):Integer;
  var vRow :Integer;
  begin
    Result := 0;
    if Common.Table.WaitTableNo > 0 then Exit;

    with Main_sGrd do
    For vRow := 0 to RowCount-1 do
    begin
      if (Cells[GDM_YN_ORDER, vRow] = 'Y') and (Cells[GDM_CD_MENU,  vRow] = aCode) then
        Result := Result + 1;
    end;
  end;
var vIndex, vQty, vPrSale, vCnt, I, II, vSeq :Integer;
    vTemp :String;
    vKetchenCode :String;
    aCustomerSubMenuPrint,
    aKitchenSubMenuPrint,
    vMaster, vPrtMaster, vBefKitchen, vMasterQty,
    vMasterKitchen :String;
begin
  vSeq := 0;
  with Main_sGrd do
  For vIndex := 0 to RowCount - 1 do
  begin
    vKetchenCode := Cells[GDM_KITCHEN, vIndex];
    //이미 주문된 메뉴, 주방에 출력하지 않는메뉴(서비스로 변경시 주문된 메뉴)는 패스
    if  (Cells[GDM_YN_ORDER, vIndex] = 'Y') or (Cells[GDM_YN_KITCHEN, vIndex] = 'N') then Continue;

    //추가메뉴일때 패스
    if Cells[GDM_CD_MENU, vIndex] = Common.Config.OverTimeMenu then Continue;

    //가끔 고객주문서에 수량이 잘못출력될때가 있어서 수량을 다시 구한다
    if Cells[GDM_DS_MENU, vIndex] <> 'W' then
      Cells[GDM_QTY,     vIndex] := Cells[GDM_VIEWQTY,     vIndex];

    //메뉴타입이 중량형이면 수량을 1로 한다
    if Cells[GDM_DS_MENU, vIndex] = 'W' then vQty := 1
    else vQty := StoI( Cells[GDM_QTY,     vIndex] );

    //메뉴정보 영수증출력여부
    aCustomerSubMenuPrint := Cells[GDM_YN_RCP, vIndex];

    Cells[GDM_NM_MENU, vIndex] := StringReplace(Cells[GDM_NM_MENU, vIndex], 'ⓒ','',[rfReplaceAll]);
    Cells[GDM_NM_MENU, vIndex] := StringReplace(Cells[GDM_NM_MENU, vIndex], 'ⓞ','',[rfReplaceAll]);
    Cells[GDM_NM_MENU, vIndex] := StringReplace(Cells[GDM_NM_MENU, vIndex], 'ⓘ','',[rfReplaceAll]);
    Cells[GDM_NM_MENU, vIndex] := StringReplace(Cells[GDM_NM_MENU, vIndex], 'ⓦ','',[rfReplaceAll]);
    Cells[GDM_NM_MENU, vIndex] := StringReplace(Cells[GDM_NM_MENU, vIndex], 'ⓖ','',[rfReplaceAll]);

    Cells[GDM_NM_MENU, vIndex] := StringReplace(Cells[GDM_NM_MENU, vIndex],
                                                Cells[GDM_MEMO, vIndex],
                                                '',
                                                [rfReplaceAll]);



    if Cells[GDM_DS_SALE, vIndex] = 'D' then
      Cells[GDM_NM_MENU, vIndex] := StringReplace(Cells[GDM_NM_MENU, vIndex],
                                                Common.Config.ServiceTxt,
                                                '',
                                                [rfReplaceAll]);

    // 세트,코스,오픈세트 출력 시 부메뉴 설정 주방으로 출력합니다
    if GetOption(241) = '1' then
    begin
      vPrtMaster := '';
      //부메뉴가 아닐때
      if Cells[GDM_CD_MENU1,    vIndex] = '' then
      begin
        vTemp  := Cells[GDM_TYPE,    vIndex] + Cells[GDM_NM_MENU, vIndex];
        //현재 테이블에 전에 주문한 메뉴이면 '추가'라고 붙여서 출력한다
        if OrderCount(Cells[GDM_CD_MENU, vIndex]) > 0 then
          vTemp := vTemp + '(추가)';

        aCustomerSubMenuPrint := 'Y';
        aKitchenSubMenuPrint  := 'Y';
      end
      else
      begin
        //부메뉴는 고객주문서에 출력하지 않을때
        if GetOption(338) = '1' then
          aCustomerSubMenuPrint := 'N'
        else
          aCustomerSubMenuPrint := 'Y';

        //부메뉴는 고객주문서에 출력하지 않을때
        if GetOption(354) = '1' then
          aKitchenSubMenuPrint := 'N'
        else
          aKitchenSubMenuPrint := 'Y';

        vTemp  := Cells[GDM_TYPE,    vIndex]+Cells[GDM_NM_MENU, vIndex];
      end;
    end
    else
    // 세트,코스,오픈세트 출력 시 부메뉴를 주메뉴 주방으로 출력합니다
    begin
      //부메뉴가 아닐때
      if (Cells[GDM_CD_MENU1,    vIndex] = '') and (Cells[GDM_DS_MENU, vIndex][1] in ['S','C','O']) then
      begin
        vMaster        := Cells[GDM_TYPE,    vIndex] + Cells[GDM_NM_MENU, vIndex];
        vMasterQty     := Cells[GDM_VIEWQTY, vIndex];
        vMasterKitchen := vKetchenCode;
        vPrtMaster     := vMaster;
        vSeq           := 0;

        vTemp  := Cells[GDM_TYPE,    vIndex] + Cells[GDM_NM_MENU, vIndex];
        //현재 테이블에 전에 주문한 메뉴이면 '추가'라고 붙여서 출력한다
        if OrderCount(Cells[GDM_CD_MENU, vIndex]) > 0 then
          vTemp := vTemp + '(추가)';

        aCustomerSubMenuPrint := 'Y';
        aKitchenSubMenuPrint  := 'Y';
      end
      else
      begin
        if (Cells[GDM_CD_MENU1,    vIndex] <> '') and (Cells[GDM_DS_MENU, vIndex][1] in ['S','C','O']) then
          vKetchenCode := vMasterKitchen;

        //부메뉴를 출력하지 않는다고 설정했을때 부메뉴이면 주방에 출력을 안하게 한다
        if (GetOption(354) = '1') and (Cells[GDM_CD_MENU1, vIndex] <> '') and (Cells[GDM_DS_MENU, vIndex][1] in ['S','C','O']) then
          vKetchenCode := '';

        //부메뉴가 아닐때
        if (Cells[GDM_CD_MENU1,    vIndex] = '') then
        begin
          vMaster    := '';
          vPrtMaster := '';
        end
        else Inc(vSeq);

        if (vPrtMaster <> '') and (vSeq > 1) then
          vPrtMaster := '';

        if (Cells[GDM_CD_MENU1,    vIndex] <> '') and (vBefKitchen <> Cells[GDM_KITCHEN, vIndex]) then
        begin
           vPrtMaster  := vMaster;
           vBefKitchen := Cells[GDM_KITCHEN, vIndex];
        end;
                                                    //부메뉴 출력안한다고 했을때(고객주문서)
        if (Cells[GDM_CD_MENU1,    vIndex] <> '') and (GetOption(338) = '1') then
          aCustomerSubMenuPrint := 'N'
        else
          aCustomerSubMenuPrint := 'Y';
                                                    //부메뉴 출력안한다고 했을때(주방주문서)
        if (Cells[GDM_CD_MENU1,    vIndex] <> '') and (GetOption(354) = '1') then
          aKitchenSubMenuPrint := 'N'
        else
          aKitchenSubMenuPrint := 'Y';

        vTemp  := Cells[GDM_TYPE,    vIndex] + Cells[GDM_NM_MENU, vIndex];
        //현재 테이블에 전에 주문한 메뉴이면 '추가'라고 붙여서 출력한다
        if OrderCount(Cells[GDM_CD_MENU, vIndex]) > 0 then
          vTemp := vTemp + '(추가)';
      end;
    end;

    vPrSale := StoI(Cells[GDM_PR_SALE, vIndex]);

    Common.Device.PrintKitchen(vKetchenCode,
                               vTemp,
                               Cells[GDM_CD_MENU1,    vIndex],
                               Cells[GDM_MEMO, vIndex],
                               Cells[GDM_VIEWQTY, vIndex],
                               IntToStr( (vPrSale -
                                          StoI( Cells[GDM_DC_SPC,  vIndex] ))
                                        * vQty),
                               Cells[GDM_DC_SPC,  vIndex],
                               Cells[GDM_PRT_KITCHEN, vIndex],
                               Cells[GDM_DS_MENU, vIndex],
                               Cells[GDM_DS_SALE, vIndex],
                               Cells[GDM_DS_TAX, vIndex],
                               Cells[GDM_CORNER, vIndex],
                               vPrtMaster,
                               vMasterQty,
                               Cells[GDM_CD_MENU,    vIndex],
                               StoI( Cells[GDM_NO_GROUP,  vIndex] ),
                               StoI( Cells[GDM_SEQ,       vIndex] ),
                               StoI( Cells[GDM_NO_STEP,   vIndex] ),
                               StoI( Cells[GDM_QTY,       vIndex] ),
                               aCustomerSubMenuPrint,
                               aKitchenSubMenuPrint,
                               Cells[GDM_YN_BILL, vIndex],
                               Cells[GDM_YN_DOUBLE, vIndex],
                               Cells[GDM_NM_MENU_KITCHEN, vIndex] );
  end; //For vIndex := 0 to RowCount - 1 do

  //메뉴별 낱장출력시 주메뉴 부메류를 합친다
  if GetOption(374) = '1' then
  begin
    For I := 0 to High(Common.KitchenPrinter) do
    begin
      for II := 0 to Common.KitchenPrinter[I].MenuList.Count-1 do
      begin
        Common.KitchenPrinter[I].Source := Common.KitchenPrinter[I].Source + Common.KitchenPrinter[I].MenuList.Strings[II] + #28;  //저장하기 위함
        vTemp := Common.Device.SetOrderPrintHeader(Common.KitchenPrinter[I].MenuList.Strings[II], I);
        Common.KitchenPrinter[I].Data := Common.KitchenPrinter[I].Data +
                                         Common.Device.PrinterCommendReplace(vTemp, Common.KitchenPrinter[I].Device,
                                            Common.KitchenPrinter[I].Col,
                                            Common.KitchenPrinter[I].BottomMargin );
      end;
    end;
  end;

  //주방주문서를 메뉴별로 출력하면서 그룹을 사용시 그룹으로 지정된 내역을 주방주문서 헤더를 만든다
  if (GetOption(9) = '1') and (GetOption(79) = '1') then
  begin
    For I := 0 to High(Common.KitchenPrinter) do
    begin
      For II := 1 to 100 do
      begin
        if Common.KitchenPrinter[I].GroupSource[II] = '' then Continue;

        vTemp := Common.Device.SetOrderPrintHeader(Common.KitchenPrinter[I].GroupSource[II], I);
        Common.KitchenPrinter[I].Data := Common.KitchenPrinter[I].Data +
                                         Common.Device.PrinterCommendReplace(vTemp,
                                                                             Common.KitchenPrinter[I].Device,
                                                                             Common.KitchenPrinter[I].Col,
                                                                             Common.KitchenPrinter[I].BottomMargin );
      end;
    end;
  end;

  if Common.Config.IsTakeOut and (Common.Table.OrderType <> 'D') then
    Exit;
  //출력내역을 DB에 저장한다
  if KitchenPrintMode then
    For vIndex := 0 to High(Common.KitchenPrinter) do
    begin
      vTemp := EmptyStr;

      if (GetOption(79) = '0') and (Common.KitchenPrinter[vIndex].Source = EmptyStr) then Continue;
      //낱장으로 인쇄한다고 설정을 안하면 구분자가 없기때문에 여기서 붙어준다
      if GetOption(9) = '0' then
        Common.KitchenPrinter[vIndex].Source := Common.KitchenPrinter[vIndex].Source + #28;

      vCnt := CharCnt(Common.KitchenPrinter[vIndex].Source, #28);

      For I := 0 to vCnt-1 do
      begin
        vTemp := CopyPos( Common.KitchenPrinter[vIndex].Source, #28, I);
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
            Common.WriteLog('Order007',E.Message);
          end;
        end;
      end;

      //그룹으로 묶인내용
      if (GetOption(79) = '1') then
      begin
        For I := 0 to High(Common.KitchenPrinter) do
        begin
          For II := 1 to 100 do
          begin
            if Common.KitchenPrinter[I].GroupSource[II] = EmptyStr then Continue;

            try
              Common.SavePrintData(Common.KitchenPrinter[I].Code,
                                   Common.KitchenPrinter[I].GroupSource[II],
                                   Common.Table.DamdangName,
                                   Common.Config.PosNo,
                                   Common.NowDate+Common.NowTime,
                                   Common.Table.CustomerCount,
                                   Common.Table.OrderNo);
            except
              on E: Exception do
              begin
                Common.WriteLog('Order008',E.Message);
              end;
            end;
          end;
        end;
      end;
    end;

  //주문로그에 저장
  if (Common.CustomerCancel + Common.CustomerPrinter = '') then Exit;
  try
    Common.SavePrintData('000',
                         Common.CustomerCancel + Common.CustomerPrinter,
                         Common.Table.DamdangName,
                         Common.Config.PosNo,
                         Common.NowDate+Common.NowTime,
                         Common.Table.CustomerCount,
                         Common.Table.OrderNo);
  except
    on E: Exception do
    begin
      Common.WriteLog('Order009',E.Message);
    end;
  end;
end;

function TOrder_F.SetAgeCode:String; //연령대코드를 조합한다
var I:Integer;
begin
  Result := EmptyStr;
  For I := 0 to Common.Table.AgeCode.Count-1 do
    if I < (Common.Table.AgeCode.Count-1) then
       Result := Result + Common.Table.AgeCode.Strings[I] + ','
    else
       Result := Result + Common.Table.AgeCode.Strings[I];
end;

procedure TOrder_F.SaveAuditor(aType, aMenu: String; aQty, aPrice,
  aAmnt: Integer);
const _SQL = 'insert into SL_SALE_C(CD_STORE, '
             +'                      YMD_SALE, '
             +'                      SEQ, '
             +'                      CD_MENU, '
             +'                      NO_TABLE, '
             +'                      QTY_CANCEL, '
             +'                      CANCEL_TXT, '
             +'                      NO_POS, '
             +'                      NO_RCP, '
             +'                      CD_SAWON,  '
             +'                      DT_ORDER, '
             +'                      DS_ORDER, '
             +'                      DT_CANCEL) '
             +'               Values(:P0, '
             +'                      :P1, '
             +'                      :P2, '
             +'                      :P3, '
             +'                      :P4, '
             +'                      :P5, '
             +'                      :P6, '
             +'                      :P7, '
             +'                      :P8, '
             +'                      :P9, '
             +'                      :P10, '
             +'                      :P11, '
             +'                      Date_Format(Now(), ''%Y%m%d%H%i'')) ';

var vIndex, vSeq :Integer;
begin
  with Main_sGrd, Common do
  begin
    OpenQuery('select ifnull(Max(SEQ),0)+1 '
             +'  from SL_SALE_C '
             +' where CD_STORE =:P0 '
             +'   and YMD_SALE =:P1 ',
             [Config.StoreCode,
              WorkDate]);
    vSeq := Query.Fields[0].AsInteger;

    //선불제일때
    if Common.Config.IsTakeOut and (Common.Table.OrderType <> 'D') then
    begin
      if aType = 'A' then
      begin
        if Cells[0,0] = '' then Exit;
        try
          BeginTran;
          For vIndex := 0 to RowCount-1 do
          begin
            if Cells[GDM_CD_MENU1, vIndex] <> '' then Continue;
            ExecQuery(_SQL,
                     [Config.StoreCode,
                      WorkDate,
                      vSeq,
                      Cells[GDM_CD_MENU, vIndex],
                      0,
                      StoI(Cells[GDM_QTY,     vIndex]),
                      '',
                      Config.PosNo,
                      WorkDate+Config.PosNo+Present.RcpNo,
                      Config.UserCode,
                      Cells[GDM_ORDERTIME, vIndex],
                      Common.Table.OrderType]);
            Inc(vSeq);
          end;
          CommitTran;
        except
          on E: Exception do
          begin
            RollbackTran;
            Common.WriteLog('SaveAuditor',E.Message);
            ErrBox(E.Message+#13#13+'주문취소내역을 저장하지 못했습니다');
          end;
        end;
      end
      else
      begin
        try
          ExecQuery(_SQL,
                   [Config.StoreCode,
                    WorkDate,
                    vSeq,
                    aMenu,
                    0,
                    Abs(aQty),
                    '',
                    Config.PosNo,
                    WorkDate+Config.PosNo+Present.RcpNo,
                    Config.UserCode,
                    '',
                    Common.Table.OrderType]);
        except
          on E: Exception do
          begin
            RollbackTran;
            Common.WriteLog('SaveAuditor',E.Message);
            ErrBox(E.Message+#13#13+'주문취소내역을 저장하지 못했습니다');
          end;
        end;
      end;
    end
    //결제변경일때
    else if Common.OrderKind = okChange then
    begin
      ExecQuery(_SQL,
               [Config.StoreCode,
                WorkDate,
                vSeq,
                aMenu,
                Table.Number,
                Abs(aQty),
                SCopy(WhyOrdercancel,1,100),
                Config.PosNo,
                WorkDate+Config.PosNo+Present.RcpNo,
                Config.UserCode,
                Cells[GDM_ORDERTIME, vIndex],
                Common.Table.OrderType]);
    end;
  end;
end;

function TOrder_F.SaveDeliveryAmnt(aAccount:Boolean;aOrderAmt:Integer):String;
var
  lsPayType: String;
  vTemp :String;
  I  :Integer;
begin
  if (GetOption(368) = '0') and not Assigned(DeliveryInfo_F) then Exit;
  if (GetOption(368) = '1') and not Assigned(DeliveryNew_F) then Exit;
  if Common.OrderKind = okChange then
  begin
    Result := '';
    Exit;
  end;
  vTemp := '';
  if Main_sGrd.Cells[0,0] <> '' then
    For I := 0 to Main_sGrd.RowCount do
      if (Main_sGrd.Cells[0,I] <> '') and (Main_sGrd.Cells[GDM_CD_MENU1,I] = '') then
        vTemp := vTemp + Main_sGrd.Cells[GDM_NM_MENU, I]+'('+ Main_sGrd.Cells[GDM_VIEWQTY, I]+') ';

  Result := vTemp;

  if (Common.PreSent.CashAmt > 0) and (Common.PreSent.CardAmt = 0) then
    lsPayType := '현금'
  else if (Common.PreSent.CardAmt > 0) and (Common.PreSent.CashAmt = 0) then
    lsPayType := '카드'
  else
    lsPayType := '복합';

  if GetOption(368) = '0' then
  begin
    DeliveryInfo_F.FOrderAmt := aOrderAmt;
    DeliveryInfo_F.FRowCount := Main_sGrd.RowCount;

    if Main_sGrd.Cells[0,0] = '' then DeliveryInfo_F.FOrderAmt := 0;
  end
  else if GetOption(368) = '1' then
    DeliveryNew_F.FOrderAmt := aOrderAmt;

  ExecQuery('update SL_DELIVERY '
           +'   set AMT_ORDER =:P3, '
           +'       ORDERMENU =:P4 '
           +Ifthen(aAccount,', PAYTYPE =:P5, AMT_SALE=:P3 ','')
           + 'where CD_STORE     =:P0 '
           +'   and YMD_DELIVERY =:P1 '
           +'   and NO_DELIVERY  =:P2 ',
           [Common.Config.StoreCode,
            LeftStr(Common.Table.DeliveryNo,8),
            RightStr(Common.Table.DeliveryNo,4),
            aOrderAmt,
            Scopy(vTemp, 1, 100),
            lsPayType]);
  Common.WriteLog('work', Format('배달저장(%s-%s) %d원',[LeftStr(Common.Table.DeliveryNo,8), RightStr(Common.Table.DeliveryNo,4), aOrderAmt]));
end;

//**************************************************************************//
//                       데몬에서 카드 데이터가 왔을때
//**************************************************************************//
procedure TOrder_F.Tmr_CardTimer(Sender: TObject);
var vKey :Word;
    vStr :String;
begin
  Tmr_Card.Enabled := False;
  vStr := GetOnlyNumber(FCardData);
  if (vStr <> '') and ( Length(vStr) = Common.Config.len_card ) then
  begin
    vKey := 13;
    FMsrData := vStr;
    FormKeyDown(nil, vKey, []);
    IsExecuteCard := False;
  end
  //신용카드기능사용여부
  else if GetOption(51) = '0' then
    Act_Card.Execute;
end;

//**************************************************************************//
//                          수량추가
//**************************************************************************//
procedure TOrder_F.Action1Execute(Sender: TObject);
var vMemo, vYnOrder:String;
    vWorkKind :TWorkKind;
    vQty :Integer;
begin
  try
     //마감 상태였으면 초기화한다
    if CheckSaleFinish then Exit;
    if Main_sGrd.Cells[0,0] = '' then Exit;
    if not CheckPresentChange(1) then Exit;

    if (StoI(Main_sGrd.Cells[GDM_NO_STEP, Main_sGrd.Row]) > 0) or
       (Main_sGrd.Cells[GDM_DS_MENU, Main_sGrd.Row] = 'W' ) or
       (Main_sGrd.Cells[GDM_CD_MENU, Main_sGrd.Row] = Common.Config.OverTimeMenu) then
    begin
      Common.ErrBox('수량을 추가할 수 없는 메뉴입니다');
      Exit;
    end;

    if ((StoI(Main_sGrd.Cells[GDM_NO_STEP, Main_sGrd.Row]) > 0) or
       (Main_sGrd.Cells[GDM_DS_MENU, Main_sGrd.Row] = 'C' ) or
       (Main_sGrd.Cells[GDM_DS_MENU, Main_sGrd.Row] = 'O' ) ) and
       (Main_sGrd.Cells[GDM_YN_ORDER, Main_sGrd.Row] = 'Y' ) then
    begin
      Common.ErrBox('수량을 추가할 수 없는 메뉴입니다');
      Exit;
    end;
    ClickTime         := IncSecond(Now,-3);

    //수량을 입력후 수량추가 후
    if StoI(FMsrData) > 1 then
    begin
      vQty := StoI(FMsrData);
      WorkKind := WorkKind;
      FMsrData := '';
    end
    else
      vQty := 1;

    RestoreQty := vQty;
    Common.WriteLog('work', Format('수량추가-%s[%d]',[Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row],vQty]));

    if ((Main_sGrd.Cells[GDM_DS_MENU,  Main_sGrd.Row] = 'N') or (Main_sGrd.Cells[GDM_DS_MENU,  Main_sGrd.Row] = 'S') or (Main_sGrd.Cells[GDM_DS_MENU,  Main_sGrd.Row] = 'C') or (Main_sGrd.Cells[GDM_DS_MENU,  Main_sGrd.Row] = 'O') or
       (Main_sGrd.Cells[GDM_DS_MENU,  Main_sGrd.Row] = 'I')) and (Main_sGrd.Cells[GDM_YN_ORDER, Main_sGrd.Row] = 'N') then
    begin
      Goods_QtyDec(Trim(Main_sGrd.Cells[GDM_CD_MENU,Main_sGrd.Row]),
                   Trim(Main_sGrd.Cells[GDM_CD_ITEM, Main_sGrd.Row]),
                   Ifthen(StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]) < 0 , vQty * -1, vQty),
                   StoI(Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row]),
                   StoI(Main_sGrd.Cells[GDM_DC_MENU, Main_sGrd.Row]),
                   'Y',
                   'N');
      Exit;
    end;

    FMenuCode := Main_sGrd.Cells[GDM_CD_MENU,  Main_sGrd.Row];
    if (Main_sGrd.Cells[GDM_DS_SALE,  Main_sGrd.Row] = 'S') then
      WorkKind := wkSale
    else if Main_sGrd.Cells[GDM_DS_SALE,  Main_sGrd.Row] = 'P' then
      WorkKind := wkPacking
    else if Main_sGrd.Cells[GDM_DS_SALE,  Main_sGrd.Row] = 'D' then
    begin
      WorkKind := wkService;
    end;

    vWorkKind := WorkKind;
    if Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row] = Main_sGrd.Cells[GDM_PR_SALE_DB, Main_sGrd.Row] then
    begin
      if StrToInt(Main_sGrd.Cells[GDM_PR_SALE_DB, Main_sGrd.Row]) > 0 then
      begin
        //부가세 별도일때는 부가세금액을 뺀다
        if Main_sGrd.Cells[GDM_DS_TAX, Main_sGrd.Row] = '2' then
          RestorePrice := FtoI(StrToInt(Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row]) / 1.1)
        else
          RestorePrice := StrToInt(Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row]);
  //      bDouble := True;      2021.8.16 왜 있는지 몰라서 제거
      end;
    end
    else if Main_sGrd.Cells[GDM_TYPE, Main_sGrd.Row] = 'ⓖ' then
    begin
      bRestore     := True;
      //부가세 별도일때는 부가세금액을 뺀다
      if Main_sGrd.Cells[GDM_DS_TAX, Main_sGrd.Row] = '2' then
        RestorePrice := FtoI(StrToInt(Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row]) / 1.1)
      else
        RestorePrice := StrToInt(Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row]);
    end
    else
      RestorePrice := 0;

    FMemo     := Main_sGrd.Cells[GDM_MEMO,     Main_sGrd.Row];
    vYnOrder  := Main_sGrd.Cells[GDM_YN_ORDER, Main_sGrd.Row];
    FItemCode := Main_sGrd.Cells[GDM_CD_ITEM,  Main_sGrd.Row];

    if StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]) < 0 then
      WorkKind :=  wkRefund;
  //  RestorePrice := StoI(Main_sGrd.Cells[GDM_PR_SALE,  Main_sGrd.Row]);
    SelectMenu(2, StoI(Main_sGrd.Cells[GDM_DC_MENU,  Main_sGrd.Row]));
  //  RestorePrice := 0;
    if bDouble then                                                                                      //337 포장 시 곱빼기 기능사용
      Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row] :=Ifthen(vWorkKind = wkPacking, Common.Config.PackingTxt,'')
                                                   +Main_sGrd.Cells[GDM_NM_MENU_ORG, Main_sGrd.Row]
                                                   +'(곱빼기)'
                                                   + Main_sGrd.Cells[GDM_CD_ITEM, Main_sGrd.Row]
                                                   + Main_sGrd.Cells[GDM_MEMO, Main_sGrd.Row];
    //주방메모가 있으면서 주문이 완료된 메뉴이면 주방메모를 넣는다
    if (FMemo <> '') and (vYnOrder = 'Y') then
    begin
      Main_sGrd.Cells[GDM_MEMO,    Main_sGrd.Row] := FMemo;
      Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row] := Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row] + FMemo;
    end;
  finally
    FMemo := '';
    bRestore     := False;
    bDouble      := False;
    RestorePrice := 0;
    RestoreQty   := 0;
  end;
end;

//**************************************************************************//
//                           수량빼기
//**************************************************************************//
procedure TOrder_F.Action2Execute(Sender: TObject);
var vQty :Integer;
begin

  if Main_sGrd.Cells[0,0] = '' then Exit;

  if not CheckPresentChange(1) then Exit;

  if (StoI(Main_sGrd.Cells[GDM_NO_STEP, Main_sGrd.Row]) > 0) or
     (Main_sGrd.Cells[GDM_DS_MENU, Main_sGrd.Row] = 'W' )then
  begin
    Common.ErrBox('수량을 뺄 수 없는 메뉴입니다');
    Exit;
  end;


  if Main_sGrd.Cells[GDM_CD_MENU, Main_sGrd.Row] = Common.Config.OverTimeMenu then
  begin
    Common.ErrBox('수량을 뺄 수 없는 메뉴입니다');
    Exit;
  end;

  if (StoI(FMsrData) > 1) and (StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]) >= StoI(FMsrData)) then
  begin
    vQty :=  StoI(FMsrData);
    FMsrData := '';
    WorkKind := WorkKind;
  end
  else if (StoI(FMsrData) > 1) and (StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]) < StoI(FMsrData)) then
  begin
    Common.MsgBox('수량을 다시 입력하세요');
    FMsrData := '';
    WorkKind := WorkKind;
  end
  else
    vQty := 1;


  if (GetOption(15) <> '2') and (Main_sGrd.Cells[GDM_YN_ORDER, Main_sGrd.Row] = 'Y') then
  begin
    if not Common.AskBox(Format('%d개 수량을'+#13+'주문 취소하시겠습니까?',[vQty])) then Exit;
  end;

  ClickTime         := IncSecond(Now,-3);
  Common.WriteLog('work', '수량빼기-'+Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row]);
  Goods_QtyDec(Trim(Main_SGrd.Cells[GDM_CD_MENU,Main_SGrd.Row]),
               Trim(Main_SGrd.Cells[GDM_CD_ITEM,   Main_SGrd.Row]),
               Ifthen(StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]) < 0 , vQty, vQty * -1),
               StoI(Main_SGrd.Cells[GDM_PR_SALE, Main_SGrd.Row]),
               StoI(Main_SGrd.Cells[GDM_DC_MENU, Main_SGrd.Row]),
               'Y',
               'N');
end;

//**************************************************************************//
//                           수량변경
//**************************************************************************//
procedure TOrder_F.Action3Execute(Sender: TObject);
var
   liQty :Integer;
   vMemo, vTemp :String;
begin
  if Main_sGrd.Cells[0,0] = '' then Exit;

  if not CheckPresentChange(1) then Exit;

  if (StoI(Main_sGrd.Cells[GDM_NO_STEP, Main_sGrd.Row]) > 0) or
     (Main_sGrd.Cells[GDM_DS_MENU, Main_sGrd.Row] = 'W' ) or
     (Main_sGrd.Cells[GDM_CD_MENU, Main_sGrd.Row] = Common.Config.OverTimeMenu) then
  begin
    Common.ErrBox('수량을 변경할 수 없는 메뉴입니다');
    Exit;
  end;

  if ((StoI(Main_sGrd.Cells[GDM_NO_STEP, Main_sGrd.Row]) > 0) or
     (Main_sGrd.Cells[GDM_DS_MENU, Main_sGrd.Row] = 'C' ) or
     (Main_sGrd.Cells[GDM_DS_MENU, Main_sGrd.Row] = 'O' ) ) and
     (Main_sGrd.Cells[GDM_YN_ORDER, Main_sGrd.Row] = 'Y' ) then
  begin
    Common.ErrBox('수량을 변경할 수 없는 메뉴입니다');
    Exit;
  end;

  with Main_sGrd do
  begin
    if Cells[0,0] = '' then Exit;

    if StoI(FMsrData) > 0 then
    begin
      liQty := StoI(FMsrData);
      WorkKind := WorkKind;
      FMsrData := '';
    end
    else
    begin
      vTemp := Common.ShowNumberForm('변경 할 수량을 입력하세요',0,9999);
      if vTemp = 'mrClose' then Exit;
      liQty := StoI(vTemp);
    end;
    if liQty = 0 then Exit;

    if StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]) < 0 then
      liQty := liQty * -1;

    //현재수량과 차를 계산(10 - 5)
    liQty := liQty - StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]);

    try
      if (Main_sGrd.Cells[GDM_YN_ORDER, Main_sGrd.Row] = 'Y') and (liQty < 0) then
      begin
        if not Common.AskBox(IntToStr( ABS(liQty) )+' 수량을'+#13+'주문 취소하시겠습니까?') then Exit;
        //전체 합계 및 그리드에 적용
        Goods_QtyDec(Trim(Cells[GDM_CD_MENU,Row]),
                     Trim(Cells[GDM_CD_ITEM,   Row]),
                     liQty,
                     StoI(Cells[GDM_PR_SALE, Row]),
                     StoI(Cells[GDM_DC_MENU, Row]),
                     'Y',
                     'N');
      end
      else if (Main_sGrd.Cells[GDM_YN_ORDER, Main_sGrd.Row] = 'Y') and (liQty > 0) then
      begin
        FMenuCode := Main_sGrd.Cells[GDM_CD_MENU, Main_sGrd.Row];
        vMemo     := Main_sGrd.Cells[GDM_MEMO,    Main_sGrd.Row];
        if Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row] = Main_sGrd.Cells[GDM_PR_SALE_DB, Main_sGrd.Row] then
        begin
          if Main_sGrd.Cells[GDM_YN_DOUBLE, Main_sGrd.Row] = 'Y' then
          begin
            RestorePrice := StrToInt(Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row]);
            bDouble := True;
          end;
        end
        else if Main_sGrd.Cells[GDM_TYPE, Main_sGrd.Row] = 'ⓖ' then
        begin
          bRestore     := True;
          RestorePrice := StrToInt(Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row])
        end
        else
          RestorePrice := 0;

        SelectMenu(2, StoI(Main_sGrd.Cells[GDM_DC_MENU,  Main_sGrd.Row]));
        if bDouble then
          Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row] :=Main_sGrd.Cells[GDM_NM_MENU_ORG, Main_sGrd.Row]
                                                       +'(곱빼기)'
                                                       + Main_sGrd.Cells[GDM_NM_ITEM, Main_sGrd.Row]
                                                       + Main_sGrd.Cells[GDM_MEMO, Main_sGrd.Row];
        bRestore := False;
        bDouble  := False;
        RestorePrice := 0;
        if vMemo <> '' then
        begin
          Main_sGrd.Cells[GDM_MEMO,    Main_sGrd.Row] := vMemo;
          Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row] := Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row] + vMemo;
        end;
        if liQty > 1 then
          Goods_QtyDec(Trim(Cells[GDM_CD_MENU,Row]),
                       Trim(Cells[GDM_CD_ITEM,   Row]),
                       liQty-1,
                       StoI(Cells[GDM_PR_SALE, Row]),
                       StoI(Cells[GDM_DC_MENU, Row]),
                       'Y',
                       'N');
      end
      else
        Goods_QtyDec(Trim(Cells[GDM_CD_MENU,Row]),
                     Trim(Cells[GDM_CD_ITEM,   Row]),
                     liQty,
                     StoI(Cells[GDM_PR_SALE, Row]),
                     StoI(Cells[GDM_DC_MENU, Row]),
                     'Y',
                     'N');
    finally
      bDouble := False;
    end;
  end;
end;

procedure TOrder_F.Action40Execute(Sender: TObject);
begin
  if Main_sGrd.RowCount = 0 then
  begin
    Common.ErrBox('주문 내역이 없습니다');
    Exit;
  end;
  Common.Device.Receipt_Ahead;
end;

procedure TOrder_F.Action41Execute(Sender: TObject);
begin
  LetsOrderTakeOut_F := TLetsOrderTakeOut_F.Create(Self);
  try
    LetsOrderTakeOut_F.ShowModal;
    if LetsOrderButtonRow >= 0 then
      FunctionButton[LetsOrderButtonRow, LetsOrderButtonCol].Picture.Assign(FunctionImageCollection.Items[40].Picture);

  finally
    FreeAndNil(LetsOrderTakeOut_F);
  end;
end;

procedure TOrder_F.Action45Execute(Sender: TObject);
begin
  LetsOrderSync_F := TLetsOrderSync_F.Create(Self);
  try
    LetsOrderSync_F.ShowModal;
  finally
    FreeAndNil(LetsOrderSync_F);
  end;
end;

procedure TOrder_F.Action46Execute(Sender: TObject);
begin
  ClickTime         := IncSecond(Now,-3);
  CloseButtonClick(CloseButton);
end;

procedure TOrder_F.Action47Execute(Sender: TObject);
var vIndex :Integer;
    vLeft, vTop :Integer;
var vHandle :THandle;
    vCount :Integer;
    vButton :Array of String;
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

  if vCount = 0 then Exit;

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

procedure TOrder_F.DeliveryButtonClick(Sender: TObject);
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
      ExecuteProgram('C:\BaeminRelay','bmrelay.exe','') ;
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

//**************************************************************************//
//                          지정 취소
//**************************************************************************//
procedure TOrder_F.Action4Execute(Sender: TObject);
var
   liQty, liRow, vTemp :Integer;
begin

  if Main_sGrd.Cells[0,0] = '' then Exit;

  if not CheckPresentChange(1) then Exit;

  if (StoI(Main_sGrd.Cells[GDM_NO_STEP, Main_sGrd.Row]) > 0) or
     (Main_sGrd.Cells[GDM_CD_MENU, Main_sGrd.Row] = Common.Config.OverTimeMenu) then
  begin
    Common.ErrBox('주문를 취소할 수 없는 메뉴입니다');
    Exit;
  end;

  {화면에 보여지는 그리드 적용}
  with Main_SGrd do
  begin
     if Cells[GDM_CD_MENU, Row] = '' then  exit;
     if (Sender <> nil) and not Common.Config.isKiosk and (GetOption(15) <> '2') and not Common.AskBox('주문를 취소하시겠습니까?') then Exit;
     liRow := Row;
     SetRowNumber;
     liQty := StoI(Cells[GDM_QTY, liRow]) * -1;
     Row   := liRow;
     Goods_QtyDec(Trim(Cells[GDM_CD_MENU,liRow]),
                 Trim(Cells[GDM_CD_ITEM,liRow]),
                 liQty,
                 StoI(Cells[GDM_PR_SALE,liRow]),
                 StoI(Cells[GDM_DC_MENU,liRow]),
                 'Y',
                 'N');

     {삭제후 10줄이상이면 로우를 화면을 위로 옮기기위함}
     if GroupTable_sGrd.Visible then vTemp := 7
     else                            vTemp :=10;
     if RowCount >= vTemp then
     begin
        Enabled    := False;
        ScrollBars := ssVertical;
        ScrollBars := ssNone;
        Enabled    := True;
     end;
     Main_SGrd.SetFocus;
  end;//with Main_SGrd do
  DisplayPresent;
end;

//**************************************************************************//
//                          전체서비스
//**************************************************************************//
procedure TOrder_F.Action50Execute(Sender: TObject);
var vIndex :Integer;
begin
  if not Common.Config.IsTakeOut then
  begin
    Common.MsgBox('선불매장에서만 사용이 가능합니다');
    Exit;
  end;
  if not CheckPresentChange then Exit;
  For vIndex := 0 to Main_sGrd.RowCount-1 do
  begin
    if Main_sGrd.Cells[GDM_DS_SALE, vIndex]  = 'D' then
    begin
      if (Pos(Common.Config.PackingTxt, Main_sGrd.Cells[GDM_NM_MENU, vIndex]) = 0) or (Main_sGrd.Cells[GDM_PR_SALE_PACKING, vIndex]='0') then
      begin
        Main_sGrd.Cells[GDM_DS_SALE, vIndex]   := 'S';
        Main_sGrd.Cells[GDM_PR_SALE, vIndex]   := Main_sGrd.Cells[GDM_PR_SALE_ORG, vIndex];
        Main_sGrd.Cells[GDM_VIEWPRICE, vIndex] := Main_sGrd.Cells[GDM_PR_SALE_ORG, vIndex];
      end
      else
      begin
        Main_sGrd.Cells[GDM_DS_SALE, vIndex]   := 'P';
        Main_sGrd.Cells[GDM_PR_SALE, vIndex]   := Main_sGrd.Cells[GDM_PR_SALE_PACKING, vIndex];
        Main_sGrd.Cells[GDM_VIEWPRICE, vIndex] := Main_sGrd.Cells[GDM_PR_SALE_PACKING, vIndex];
      end;
      Main_sGrd.Cells[GDM_AMT, vIndex]       := IntToStr(StoI(Main_sGrd.Cells[GDM_PR_SALE, vIndex]) * StoI(Main_sGrd.Cells[GDM_QTY, vIndex]));
      Main_sGrd.Cells[GDM_NM_MENU, vIndex]   := Replace(Main_sGrd.Cells[GDM_NM_MENU, vIndex], Common.Config.ServiceTxt, '');
    end
    else
    begin
      if Main_sGrd.Cells[GDM_DS_SALE, vIndex] = 'S' then
        Main_sGrd.Cells[GDM_NM_MENU, vIndex] := Main_sGrd.Cells[GDM_NM_MENU, vIndex]+Common.Config.ServiceTxt
      else if Main_sGrd.Cells[GDM_DS_SALE, vIndex] = 'P' then
      begin
        if Pos(Common.Config.ServiceTxt, Main_sGrd.Cells[GDM_NM_MENU, vIndex]) = 0 then
          Main_sGrd.Cells[GDM_NM_MENU, vIndex] := Main_sGrd.Cells[GDM_NM_MENU, vIndex]+Common.Config.ServiceTxt;
      end;
      Main_sGrd.Cells[GDM_DS_SALE, vIndex]   := 'D';
      Main_sGrd.Cells[GDM_PR_SALE, vIndex]   := '0';
      Main_sGrd.Cells[GDM_VIEWPRICE, vIndex] := '0';
      Main_sGrd.Cells[GDM_AMT, vIndex]       := '0';
    end;
  end;

  For vIndex := 0 to Common.Summary_sGrd.RowCount-1 do
  begin
    if Common.Summary_sGrd.Cells[GDM_DS_SALE, vIndex]  = 'D' then
    begin
      if (Pos(Common.Config.PackingTxt, Common.Summary_sGrd.Cells[GDM_NM_MENU, vIndex]) = 0) or (Common.Summary_sGrd.Cells[GDM_PR_SALE_PACKING, vIndex]='0') then
      begin
        Common.Summary_sGrd.Cells[GDM_DS_SALE, vIndex]   := 'S';
        Common.Summary_sGrd.Cells[GDM_PR_SALE, vIndex]   := Common.Summary_sGrd.Cells[GDM_PR_SALE_ORG, vIndex];
        Common.Summary_sGrd.Cells[GDM_VIEWPRICE, vIndex] := Common.Summary_sGrd.Cells[GDM_PR_SALE_ORG, vIndex];
      end
      else
      begin
        Common.Summary_sGrd.Cells[GDM_DS_SALE, vIndex]   := 'P';
        Common.Summary_sGrd.Cells[GDM_PR_SALE, vIndex]   := Common.Summary_sGrd.Cells[GDM_PR_SALE_PACKING, vIndex];
        Common.Summary_sGrd.Cells[GDM_VIEWPRICE, vIndex] := Common.Summary_sGrd.Cells[GDM_PR_SALE_PACKING, vIndex];
      end;
      Common.Summary_sGrd.Cells[GDM_AMT, vIndex]       := IntToStr(StoI(Common.Summary_sGrd.Cells[GDM_PR_SALE, vIndex]) * StoI(Common.Summary_sGrd.Cells[GDM_QTY, vIndex]));
      Common.Summary_sGrd.Cells[GDM_NM_MENU, vIndex]   := Replace(Common.Summary_sGrd.Cells[GDM_NM_MENU, vIndex], Common.Config.ServiceTxt, '');
    end
    else
    begin
      if Common.Summary_sGrd.Cells[GDM_DS_SALE, vIndex] = 'S' then
        Common.Summary_sGrd.Cells[GDM_NM_MENU, vIndex] := Common.Summary_sGrd.Cells[GDM_NM_MENU, vIndex]+Common.Config.ServiceTxt
      else if Common.Summary_sGrd.Cells[GDM_DS_SALE, vIndex] = 'P' then
      begin
        if Pos(Common.Config.ServiceTxt, Common.Summary_sGrd.Cells[GDM_NM_MENU, vIndex]) = 0 then
          Common.Summary_sGrd.Cells[GDM_NM_MENU, vIndex] := Common.Summary_sGrd.Cells[GDM_NM_MENU, vIndex]+Common.Config.ServiceTxt;
      end;
      Common.Summary_sGrd.Cells[GDM_DS_SALE, vIndex] := 'D';
      Common.Summary_sGrd.Cells[GDM_PR_SALE, vIndex] := '0';
      Common.Summary_sGrd.Cells[GDM_AMT, vIndex]     := '0';
    end;
  end;
  DisplayPresent;
end;

//**************************************************************************//
//                          전체포장
//**************************************************************************//
procedure TOrder_F.Action51Execute(Sender: TObject);
var vIndex :Integer;
begin
  if not Common.Config.IsTakeOut then
  begin
    Common.MsgBox('선불매장에서만 사용이 가능합니다');
    Exit;
  end;
  if not CheckPresentChange then Exit;

  For vIndex := 0 to Main_sGrd.RowCount-1 do
  begin
    if Main_sGrd.Cells[GDM_DS_SALE, vIndex] = 'S' then
    begin
      Main_sGrd.Cells[GDM_DS_SALE, vIndex] := 'P';
      if Main_sGrd.Cells[GDM_PR_SALE_PACKING, vIndex] <> '0' then
      begin
         Main_sGrd.Cells[GDM_PR_SALE, vIndex] := Main_sGrd.Cells[GDM_PR_SALE_PACKING, vIndex];
         Main_sGrd.Cells[GDM_AMT, vIndex]     := IntToStr(StoI(Main_sGrd.Cells[GDM_QTY, vIndex]) * StoI(Main_sGrd.Cells[GDM_PR_SALE, vIndex]));
      end;
      Main_sGrd.Cells[GDM_NM_MENU, vIndex] := Common.Config.PackingTxt+Main_sGrd.Cells[GDM_NM_MENU, vIndex];
    end
    else if Main_sGrd.Cells[GDM_DS_SALE, vIndex] = 'D' then
    begin
      if Pos(Common.Config.PackingTxt, Main_sGrd.Cells[GDM_NM_MENU, vIndex]) = 0 then
        Main_sGrd.Cells[GDM_NM_MENU, vIndex] := Common.Config.PackingTxt+Main_sGrd.Cells[GDM_NM_MENU, vIndex];
    end
    else if Main_sGrd.Cells[GDM_DS_SALE, vIndex] = 'P' then
    begin
      Main_sGrd.Cells[GDM_DS_SALE, vIndex] := 'S';
      if Main_sGrd.Cells[GDM_PR_SALE_PACKING, vIndex] <> '0' then
      begin
         Main_sGrd.Cells[GDM_PR_SALE, vIndex] := Main_sGrd.Cells[GDM_PR_SALE_ORG, vIndex];
         Main_sGrd.Cells[GDM_AMT, vIndex]     := IntToStr(StoI(Main_sGrd.Cells[GDM_QTY, vIndex]) * StoI(Main_sGrd.Cells[GDM_PR_SALE, vIndex]));
      end;
      Main_sGrd.Cells[GDM_NM_MENU, vIndex] := Replace(Main_sGrd.Cells[GDM_NM_MENU, vIndex],Common.Config.PackingTxt,'');
    end;
  end;

  For vIndex := 0 to Common.Summary_sGrd.RowCount-1 do
  begin
    if Common.Summary_sGrd.Cells[GDM_DS_SALE, vIndex] = 'S' then
    begin
      Common.Summary_sGrd.Cells[GDM_DS_SALE, vIndex] := 'P';
      if Common.Summary_sGrd.Cells[GDM_PR_SALE_PACKING, vIndex] <> '0' then
      begin
         Common.Summary_sGrd.Cells[GDM_PR_SALE, vIndex] := Common.Summary_sGrd.Cells[GDM_PR_SALE_PACKING, vIndex];
         Common.Summary_sGrd.Cells[GDM_AMT,     vIndex] := IntToStr(StoI(Common.Summary_sGrd.Cells[GDM_QTY, vIndex]) * StoI(Common.Summary_sGrd.Cells[GDM_PR_SALE, vIndex]));
      end;
      Common.Summary_sGrd.Cells[GDM_NM_MENU, vIndex] := Common.Config.PackingTxt+Common.Summary_sGrd.Cells[GDM_NM_MENU, vIndex];
    end
    else if Common.Summary_sGrd.Cells[GDM_DS_SALE, vIndex] = 'D' then
    begin
      if Pos(Common.Config.PackingTxt, Common.Summary_sGrd.Cells[GDM_NM_MENU, vIndex]) = 0 then
        Common.Summary_sGrd.Cells[GDM_NM_MENU, vIndex] := Common.Config.PackingTxt+Common.Summary_sGrd.Cells[GDM_NM_MENU, vIndex];
    end
    else if Common.Summary_sGrd.Cells[GDM_DS_SALE, vIndex] = 'P' then
    begin
      Common.Summary_sGrd.Cells[GDM_DS_SALE, vIndex] := 'S';
      if Common.Summary_sGrd.Cells[GDM_PR_SALE_PACKING, vIndex] <> '0' then
      begin
         Common.Summary_sGrd.Cells[GDM_PR_SALE, vIndex] := Common.Summary_sGrd.Cells[GDM_PR_SALE_ORG, vIndex];
         Common.Summary_sGrd.Cells[GDM_AMT,     vIndex] := IntToStr(StoI(Common.Summary_sGrd.Cells[GDM_QTY, vIndex]) * StoI(Common.Summary_sGrd.Cells[GDM_PR_SALE, vIndex]));
      end;
      Common.Summary_sGrd.Cells[GDM_NM_MENU, vIndex] := Replace(Common.Summary_sGrd.Cells[GDM_NM_MENU, vIndex],Common.Config.PackingTxt,'');
    end;

  end;
  DisplayPresent;
end;

//**************************************************************************//
//                          전체취소
//**************************************************************************//
procedure TOrder_F.Action5Execute(Sender: TObject);
var vIdx :Integer;
    vTemp :String;
begin
  if WorkState = wsReady then
  begin
    if Common.Config.AllClassPLU then
      PluMenuPanel.Visible := false;
    WorkKind := wkSale;

    //다국어 버튼이 눌린상태
    if FlagPanel.Visible then
    begin
      KioskPanel.Enabled := true;
      FlagPanel.Visible  := false;
    end;
    if KioskFlagButton.Visible then
    begin
      KioskFlagButton.Picture.Assign(FlageCollection.Items.Items[Ifthen(GetOption(485)='0',0,9)].Picture.Graphic);
      KioskWaitFlagButton.OptionsImage.Glyph.Assign(FlageCollection.Items.Items[Ifthen(GetOption(485)='0',0,9)].Picture.Graphic);
      ThaiButtonClick(FlagKoreaButton);
    end;

    Exit;
  end;

  if not CheckPresentChange then Exit;

  if (GetOption(235) = '1') and (Common.OrderKind = okChange) then
  begin
    Common.ErrBox('결제변경 작업 중 에는 사용할 수 없습니다');
    Exit;
  end;

  if Common.Present.AHeadPayAmt > 0 then
  begin
    Common.ErrBox('선결제 테이블은 전체취소를'#13'할 수 없습니다');
    Exit;
  end;

  if Common.Present.LetsOrderAmt > 0 then
  begin
    Common.ErrBox('렛츠오더에서 결제한 내역이 있는'#13'테이블은 전체취소 할 수 없습니다');
    Exit;
  end;

  if Common.PreSent.CardAmt > 0 then
  begin
    DisPlayMessage(1,'신용카드를 먼저 취소해야합니다');
    Exit;
  end;

  if OrgOrderAmt = 0 then
  begin
    if not Common.AskBox('현재 주문내역을'#13'모두 취소하시겠습니까?') then Exit;
  end
  else
  begin
    if GetUserOption(8) <> '1' then
    begin
      if GetOption(172) = '0' then
      begin
        Common.ErrBox('주문을 취소할 권한이 없습니다');
        Exit;
      end
      else if not Common.CheckAuthority(8) then Exit;
    end;

    if not Common.AskBox('전체취소를 하면 주문이 완료된 메뉴도'+#13+
                         '주문이 모두 취소됩니다'+#13#13+
                         '그래도 취소하시겠습니까?') then Exit;

    //주문취소 사유를 받는다
    if (GetOption(15) = '1') and (OrgOrderAmt > 0) then
    begin
      vTemp := ShowOrderCancelForm;
      if  vTemp = '' then
      begin
        Common.ErrBox('취소사유를 입력해야 합니다');
        Exit;
      end;
    end;
  end;

  if Common.PreSent.UPlusDc > 0 then
  begin
    Common.ErrBox('유플러스 할인을 먼저 취소하세요');
    Exit;
  end;

  //////////////////////////  감사저널에 저장  ///////////////////////////////
  For vIdx := 0 to Main_sGrd.RowCount-1 do
  begin
    Common.OrderCancelGridSave(vIdx, StoI( Main_sGrd.Cells[GDM_QTY, vIdx] ),'Y','N' );
    vTemp := Main_sGrd.Cells[GDM_VIEWQTY, vIdx];

    Common.Device.OrderCancel(Main_sGrd, vIdx, vTemp);
  end;
  Common.WriteLog('work', '전체취소');

  //감사저널 저장
  SaveAuditor('A','', 0, 0, 0);
  if Common.Config.IsTakeOut and (Common.Table.OrderType <> 'D') then
    Common.ClearGrid(Common.Cancel_sGrd);

  WorkState := wsReady;
end;

procedure TOrder_F.Action6Execute(Sender: TObject);
var vInData :String;
    vDcPr   :Double;
begin
   //마감 상태였으면 초기화한다
  if CheckSaleFinish then Exit;
  if not Common.CheckAcctPos then Exit;

  if (GetOption(298) = '1') and (Common.OrderKind = okChange) then
  begin
    Common.ErrBox('결제변경 시 할인 기능을'+#13#13+'사용 할 수 없습니다');
    Exit;
  end;

  case StoI(GetOption(246)) of
    0 :
    begin
      Discount_F := TDiscount_F.Create(Application);
      try
        Discount_F.Top    := Self.Top;
        Discount_F.Left   := Self.Left+GridPriorButton.Left+GridPriorButton.Width;
        Discount_F.Width  := Common.Config.PluClassWidth + 10;
        Discount_F.ShowModal;
      finally
        FreeAndNil(Discount_F);
        Common.Device.OnScannerReadData := ScannerReadEvent;
      end;
    end;
    1 :
    begin
      if Common.Present.CodeDcCode <> '' then
      begin
        Common.ErrBox('지정할인과 전체할인은 같이'+#13#13+'사용 할 수 없습니다');
        Exit;
      end;
      vInData := Common.ShowNumberForm('할인금액을 입력하세요',0,Common.PreSent.WRcvAmt+Common.PreSent.CutDc,'');
      if vInData = 'mrClose' then Exit;
      //전체할인금액을 받을금액 전부를 입력했다면 자동(단차)할인도 포함한 전체로 한다
      if StoI(vInData) = Common.PreSent.WRcvAmt then
        vInData := IntToStr(Common.PreSent.WRcvAmt+Common.PreSent.CutDc);
      if vInData = '' then Exit;

      if Common.PreSent.ExistDcAmt >= Common.Present.TotalAmt then
      begin
        Common.ErrBox('할인제외 금액이 '+#13#13+'주문금액보다 큽니다');
        Exit;
      end;
      Common.PreSent.RcpDc_Rate := 0;
      Common.PreSent.RcpDc := FtoI( StoI(vInData) );
      DisplayPresent;
    end;
    2 :
    begin
      if Common.Present.CodeDcCode <> '' then
      begin
        Common.ErrBox('지정할인과 전체할인은 같이'+#13#13+'사용 할 수 없습니다');
        Exit;
      end;
      vInData := Common.ShowNumberForm('할인율을 입력하세요',0,100,'');
      if vInData = 'mrClose' then Exit;

      if Common.PreSent.ExistDcAmt >= Common.Present.TotalAmt then
      begin
        Common.ErrBox('할인제외 금액이 '+#13#13+'주문금액보다 큽니다');
        Exit;
      end;
      Common.PreSent.RcpDc_Rate := 0;
      if StoI(vInData) > 0 then
      begin
        Common.PreSent.RcpDc_Rate := FtoI(StoI(vInData));
        vDcPr := ( (Common.Present.WRcvAmt + Common.PreSent.RcpDc ) / 100 ) * StoI(vInData);
        vDcPr := FtoI( hRound( vDcPr,0) );
        //할인율단위 계산
        if (Common.Config.dc_unit > 0) and (StoI(vInData) <> 100) then
          vDcPr := wyRound(FtoI(vDcPr), Common.Config.dc_unit);

        Common.PreSent.RcpDc := FtoI( vDcPr );
         //%할인을 할인금액으로 사용시
        if GetOption(366) = '1' then
          Common.PreSent.RcpDc_Rate := 0;
      end
      else Common.PreSent.RcpDc := 0;
      DisplayPresent;
    end;
  end;
end;

procedure TOrder_F.Action7Execute(Sender: TObject);
var vIndex :Integer;
begin
  Common.PrintBuffer.Clear;
  for vIndex := 0 to Common.BackupPrintBuffer.Count-1 do
    Common.PrintBuffer.Add(Common.BackupPrintBuffer.Strings[vIndex]);

  Common.Device.PrintPrinter(1);
end;

procedure TOrder_F.Action9Execute(Sender: TObject);
  function GetSummaryGridRow(aDsSale:String='S'): Integer;
  var vRow:Integer;
  begin
    Result := -1;
     with Main_sGrd, Common.Menu do
     begin
       For vRow := 0 to Common.Summary_sGrd.RowCount - 1 do
       begin
         if Common.Config.IsTakeOut then
         begin
           if (Cells[GDM_CD_MENU, Row] = Common.Summary_sGrd.Cells[GDM_CD_MENU, vRow])
             and (aDsSale = Common.Summary_sGrd.Cells[GDM_DS_SALE, vRow])
             and (Common.Summary_sGrd.Cells[GDM_CD_MENU1, vRow] = '')
             and (Cells[GDM_CD_ITEM, Row] = Common.Summary_sGrd.Cells[GDM_CD_ITEM, vRow])
             then
           begin
              Result := vRow;
              Break;
           end;
         end
         else
         begin
           if (Cells[GDM_CD_MENU, Main_sGrd.Row] = Common.Summary_sGrd.Cells[GDM_CD_MENU, vRow])
             and (aDsSale = Common.Summary_sGrd.Cells[GDM_DS_SALE, vRow])
             and ( ((Cells[GDM_YN_DOUBLE, Main_sGrd.Row] = 'N') and (Cells[GDM_PR_SALE_ORG, Row] = Common.Summary_sGrd.Cells[GDM_PR_SALE, vRow]))
                  or ((Cells[GDM_YN_DOUBLE, Main_sGrd.Row] = 'Y') and (Cells[GDM_PR_SALE_DB, Row] = Common.Summary_sGrd.Cells[GDM_PR_SALE, vRow]))
                  or ((Cells[GDM_DS_MENU, Main_sGrd.Row] = 'W') and (Cells[GDM_AMT, Row] = Common.Summary_sGrd.Cells[GDM_AMT, vRow]))  )
             and (Common.Summary_sGrd.Cells[GDM_CD_MENU1, vRow] = '')
             and (Cells[GDM_CD_ITEM, Main_sGrd.Row] = Common.Summary_sGrd.Cells[GDM_CD_ITEM, vRow])
             then
           begin
              Result := vRow;
              Break;
           end;
         end;
       end;
     end;
  end;

  function GetSummaryGridRow1: Integer;
  var vRow:Integer;
  begin
    Result := -1;
     with Main_sGrd do
     begin
       For vRow := 0 to Common.Summary_sGrd.RowCount - 1 do
       begin
         if (Cells[GDM_CD_MENU, Row]      = Common.Summary_sGrd.Cells[GDM_CD_MENU, vRow])
           and (Cells[GDM_CD_SERVICE, Row] = Common.Summary_sGrd.Cells[GDM_CD_SERVICE, vRow])  //서비스 사유가 같아야함
           and ('D' = Common.Summary_sGrd.Cells[GDM_DS_SALE, vRow])
           and (Common.Summary_sGrd.Cells[GDM_CD_MENU1, vRow] = '')
           and (Cells[GDM_CD_ITEM, Row] = Common.Summary_sGrd.Cells[GDM_CD_ITEM, vRow]) then
         begin
           Result := vRow;
           Break;
         end;
       end;
     end;
  end;


var liSRow, vIndex, Dcpr, ASalePr, vDcAmt, liRow, vBefRow :Integer;
    lsOrgDsOrder, lsDsMenu, vTemp :String;
    vApply, vApply1 :Boolean;   //vApply :서비스를 정상으로 변경 적용여부 , vApply1 :정상을 서비스를 변경 적용여부
    vServiceQty :String;
    vServiceCode,
    vOrgOrderAmt:String;
    vRowChange :Boolean;
    vOrder,
    vMenuCode  :String;
    vSeq,
    vCol,
    vSaleMenuRow,
    vSvcMenuRow :Integer;
    vRowList    :TStringList;
    visToService :Boolean;
    vServiceAmtStr :String;
    vOrgQty, vSvcSeq :Integer;
label go;
begin

  //TakeOut 이면서 포장을 서비스로 변경
  if Common.Config.IsTakeOut and (Main_sGrd.Cells[GDM_DS_SALE, Main_sGrd.Row] = 'P') then
  begin
    Main_sGrd.Cells[GDM_NM_MENU,   Main_sGrd.Row] := Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row]+Common.Config.ServiceTxt;
    Main_sGrd.Cells[GDM_DS_SALE,   Main_sGrd.Row] := 'D';
    Main_sGrd.Cells[GDM_PR_SALE,   Main_sGrd.Row] := '0';
    Main_sGrd.Cells[GDM_VIEWPRICE, Main_sGrd.Row] := '0';
    Main_sGrd.Cells[GDM_AMT,       Main_sGrd.Row] := '0';
    Main_sGrd.Cells[GDM_SVC,       Main_sGrd.Row] := 'Y';

    liSRow := GetSummaryGridRow('P');
    Common.Summary_sGrd.Cells[GDM_NM_MENU,   liSRow] := Common.Summary_sGrd.Cells[GDM_NM_MENU, liSRow]+Common.Config.ServiceTxt;
    Common.Summary_sGrd.Cells[GDM_DS_SALE,   liSRow] := 'D';
    Common.Summary_sGrd.Cells[GDM_PR_SALE,   liSRow] := '0';
    Common.Summary_sGrd.Cells[GDM_VIEWPRICE, liSRow] := '0';
    Common.Summary_sGrd.Cells[GDM_AMT,       liSRow] := '0';
    Common.Summary_sGrd.Cells[GDM_SVC,       liSRow] := 'Y';
    DisplayPresent;
    Exit;
  end;

  if Common.Config.IsTakeOut and (Main_sGrd.Cells[GDM_DS_SALE, Main_sGrd.Row] = 'S') then
  begin
    vOrgQty := StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]);
    if (Main_sGrd.Cells[GDM_DS_MENU, Main_sGrd.Row] = 'N') and (StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]) >= 2) then
    begin
      vServiceQty := Common.ShowNumberForm('서비스수량', 0, StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]), Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]);
      if StoI(vServiceQty) = 0 then Exit;

      if StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]) = StoI(vServiceQty) then
      begin
        Main_sGrd.Cells[GDM_NM_MENU,   Main_sGrd.Row] := Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row]+Common.Config.ServiceTxt;
        Main_sGrd.Cells[GDM_DS_SALE,   Main_sGrd.Row] := 'D';
        Main_sGrd.Cells[GDM_PR_SALE,   Main_sGrd.Row] := '0';
        Main_sGrd.Cells[GDM_VIEWPRICE, Main_sGrd.Row] := '0';
        Main_sGrd.Cells[GDM_AMT,       Main_sGrd.Row] := '0';
        Main_sGrd.Cells[GDM_SVC,       Main_sGrd.Row] := 'Y';

        liSRow := GetSummaryGridRow('S');
        Common.Summary_sGrd.Cells[GDM_NM_MENU,   liSRow] := Common.Summary_sGrd.Cells[GDM_NM_MENU, liSRow]+Common.Config.ServiceTxt;
        Common.Summary_sGrd.Cells[GDM_DS_SALE,   liSRow] := 'D';
        Common.Summary_sGrd.Cells[GDM_PR_SALE,   liSRow] := '0';
        Common.Summary_sGrd.Cells[GDM_VIEWPRICE, liSRow] := '0';
        Common.Summary_sGrd.Cells[GDM_AMT,       liSRow] := '0';
        Common.Summary_sGrd.Cells[GDM_SVC,       liSRow] := 'Y';
        DisplayPresent;
        Exit;
      end
      else
      begin
        //기존수량에서 서비스 수량을 뺀다
        Goods_QtyDec(Trim(Main_sGrd.Cells[GDM_CD_MENU,Main_sGrd.Row]),
                     Trim(Main_sGrd.Cells[GDM_CD_ITEM,   Main_sGrd.Row]),
                     StoI(vServiceQty)*-1,
                     StoI(Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row]),
                     StoI(Main_sGrd.Cells[GDM_DC_MENU, Main_sGrd.Row]),
                     'Y',
                     'Y');
        WorkKind  := wkService;
        FMsrData  := vServiceQty;
        FMenuCode := Main_sGrd.Cells[GDM_CD_MENU,   Main_sGrd.Row];
        FMenuName := Main_sGrd.Cells[GDM_NM_MENU,   Main_sGrd.Row];
        PluMenuButtonClick(nil);
        Exit;
      end;
    end
    else
    begin
      Main_sGrd.Cells[GDM_NM_MENU,   Main_sGrd.Row] := Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row]+Common.Config.ServiceTxt;
      Main_sGrd.Cells[GDM_DS_SALE,   Main_sGrd.Row] := 'D';
      Main_sGrd.Cells[GDM_PR_SALE,   Main_sGrd.Row] := '0';
      Main_sGrd.Cells[GDM_VIEWPRICE, Main_sGrd.Row] := '0';
      Main_sGrd.Cells[GDM_AMT,       Main_sGrd.Row] := '0';
      Main_sGrd.Cells[GDM_SVC,       Main_sGrd.Row] := 'Y';

      liSRow := GetSummaryGridRow('S');
      Common.Summary_sGrd.Cells[GDM_NM_MENU,   liSRow] := Common.Summary_sGrd.Cells[GDM_NM_MENU, liSRow]+Common.Config.ServiceTxt;
      Common.Summary_sGrd.Cells[GDM_DS_SALE,   liSRow] := 'D';
      Common.Summary_sGrd.Cells[GDM_PR_SALE,   liSRow] := '0';
      Common.Summary_sGrd.Cells[GDM_VIEWPRICE, liSRow] := '0';
      Common.Summary_sGrd.Cells[GDM_AMT,       liSRow] := '0';
      Common.Summary_sGrd.Cells[GDM_SVC,       liSRow] := 'Y';
      DisplayPresent;
      Exit;
    end;
  end;

  if Common.Config.IsTakeOut and (Main_sGrd.Cells[GDM_DS_SALE, Main_sGrd.Row] = 'D') then
  begin
    if (Pos(Common.Config.PackingTxt, Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row]) = 0) or (Main_sGrd.Cells[GDM_PR_SALE_PACKING, Main_sGrd.Row]='0') then
    begin
      FMenuCode := Main_sGrd.Cells[GDM_CD_MENU,   Main_sGrd.Row];
      FMenuName := Main_sGrd.Cells[GDM_NM_MENU,   Main_sGrd.Row];
      FMsrData  := Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row];
      Action4Execute(nil);
      PluMenuButtonClick(nil);
      Exit;

//      Main_sGrd.Cells[GDM_DS_SALE, Main_sGrd.Row]   := 'S';
//      Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row]   := Main_sGrd.Cells[GDM_PR_SALE_ORG, Main_sGrd.Row];
//      Main_sGrd.Cells[GDM_VIEWPRICE, Main_sGrd.Row] := Main_sGrd.Cells[GDM_PR_SALE_ORG, Main_sGrd.Row];
    end
    else
    begin
      Main_sGrd.Cells[GDM_DS_SALE, Main_sGrd.Row]   := 'P';
      Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row]   := Main_sGrd.Cells[GDM_PR_SALE_PACKING, Main_sGrd.Row];
      Main_sGrd.Cells[GDM_VIEWPRICE, Main_sGrd.Row] := Main_sGrd.Cells[GDM_PR_SALE_PACKING, Main_sGrd.Row];
    end;
    Main_sGrd.Cells[GDM_AMT, Main_sGrd.Row]       := IntToStr(StoI(Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row]) * StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]));
    Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row]   := Replace(Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row], Common.Config.ServiceTxt, '');
    Main_sGrd.Cells[GDM_SVC,       Main_sGrd.Row] := 'N';

    liSRow := GetSummaryGridRow('D');

    if (Pos(Common.Config.PackingTxt, Common.Summary_sGrd.Cells[GDM_NM_MENU, liSRow]) = 0) or (Common.Summary_sGrd.Cells[GDM_PR_SALE_PACKING, liSRow]='0') then
    begin
      Common.Summary_sGrd.Cells[GDM_DS_SALE, liSRow]   := 'S';
      Common.Summary_sGrd.Cells[GDM_PR_SALE, liSRow]   := Common.Summary_sGrd.Cells[GDM_PR_SALE_ORG, liSRow];
      Common.Summary_sGrd.Cells[GDM_VIEWPRICE, liSRow] := Common.Summary_sGrd.Cells[GDM_PR_SALE_ORG, liSRow];
    end
    else
    begin
      Common.Summary_sGrd.Cells[GDM_DS_SALE, liSRow]   := 'P';
      Common.Summary_sGrd.Cells[GDM_PR_SALE, liSRow]   := Common.Summary_sGrd.Cells[GDM_PR_SALE_PACKING, liSRow];
      Common.Summary_sGrd.Cells[GDM_VIEWPRICE, liSRow] := Common.Summary_sGrd.Cells[GDM_PR_SALE_PACKING, liSRow];
    end;
    Common.Summary_sGrd.Cells[GDM_AMT, liSRow]       := IntToStr(StoI(Common.Summary_sGrd.Cells[GDM_PR_SALE, liSRow]) * StoI(Common.Summary_sGrd.Cells[GDM_QTY, liSRow]));
    Common.Summary_sGrd.Cells[GDM_NM_MENU, liSRow]   := Replace(Common.Summary_sGrd.Cells[GDM_NM_MENU, liSRow], Common.Config.ServiceTxt, '');
    DisplayPresent;
    Exit;
  end;


  try
    visToService   := false;
    vRowChange     := false;
    vServiceAmtStr := '';
    //마감 상태였으면 초기화한다
    if not CheckPresentChange then Exit;
    if GetOption(71) = '0' then
    begin
      case WorkKind of
        wkService : WorkKind := wkSale;
        else
          WorkKind := wkService;
      end;
    end
    else
    //선주문 후서비스 방식
    begin
      vApply  := False;
      vApply1 := False;
      vBefRow := -1;

      with Main_sGrd do
      begin
        if Cells[0,0] = '' then
        begin
          Common.ErrBox('메뉴를 먼저 주문해야 합니다');
          Exit;
        end;

        if Cells[GDM_DS_SALE, Row] = 'B' then
        begin
          Common.ErrBox('반품메뉴에는 사용할 수 없습니다');
          Exit;
        end;

        if (StoI(Cells[GDM_NO_STEP, Row]) > 0) then
        begin
          Common.ErrBox('부메뉴에는 사용할 수 없습니다');
          Exit;
        end;

        if Cells[GDM_SVC, Row] = 'Y' then
        begin
          Common.ErrBox('다시 변경할 수 없습니다');
          Exit;
        end;

        lsOrgDsOrder := Cells[GDM_DS_SALE, Row];
        lsDsMenu     := Cells[GDM_DS_MENU, Row];

        if Cells[GDM_DS_SALE, Row] = 'P' then
        begin
          Common.ErrBox('포장메뉴에는 사용할 수 없습니다');
          FWorkKind       := wkSale;
          Common.WorkKind := wkSale;
          Exit;
        end;

        //서비스를 정상으로 바꿀때
        if Cells[GDM_DS_SALE, Row] = 'D' then
        begin
          if (Cells[GDM_SERVICE_CHG, Row] = 'Y') then
          begin
            Common.MsgBox('서비스로 변경한 메뉴는'#13'다시 변경할 수 없습니다');
            Exit;
          end;

          if (Cells[GDM_DS_MENU, Row] = 'W') then
          begin
            Common.MsgBox('저울상품은 서비스를 정상으로'#13'변경할 수 없습니다');
            Exit;
          end;

          liSRow := GetSummaryGridRow1;
          if Cells[GDM_YN_ORDER, Row] = 'Y' then
            if not Common.AskBox('서비스주문을 정상주문으로'+#13#13+'변경하시겠습니까?') then Exit;

          if Common.OrderKind <> okChange then
          begin
            if (StoI(Common.Summary_sGrd.Cells[GDM_QTY, liSRow]) - StoI(Cells[GDM_QTY, Row])) > 0 then
            begin
              //서비스상태의 수량을 하나 뺀다
              AmtReCompute(-StoI(Cells[GDM_QTY, Row]), liSRow);
              vApply1 := True;
            end;
            //집계그리드에서 현재 정상 상품의 Row 인덱스를 구한다
            vBefRow := GetSummaryGridRow;

            //정상상태의 메뉴가 존재하면
            if vBefRow > -1 then
            begin
              //정상 메뉴의 수량을 하나 추가
              AmtReCompute(StoI(Cells[GDM_QTY, Row]), vBefRow);
              //서비스 메뉴의 수량을 하나 뺀다
              AmtReCompute(-StoI(Cells[GDM_QTY, Row]), liSRow);
              //서비스 사유코드를 없앤다
              Cells[GDM_CD_SERVICE, Row] := EmptyStr;
              if Common.Summary_sGrd.Cells[GDM_QTY, liSRow] = '0' then Common.DeleteRow(Common.Summary_sGrd, liSRow);
              vApply1 := True;
            end
            else
            begin
              //집계그리드에 메뉴가 없으면 Row를 하나 추가한다
              Common.Summary_sGrd.RowCount := Common.Summary_sGrd.RowCount + 1;
              Common.Summary_sGrd.Rows[Common.Summary_sGrd.RowCount-1].Assign( Common.Summary_sGrd.Rows[liSRow]);
              Common.Summary_sGrd.Cells[GDM_QTY, Common.Summary_sGrd.RowCount-1]     := Cells[GDM_QTY, Row];
              //곱배기 메뉴가 아닐때
              if Cells[GDM_YN_DOUBLE, Row] = 'N' then
              begin
                Common.Summary_sGrd.Cells[GDM_PR_SALE,   Common.Summary_sGrd.RowCount-1] := Cells[GDM_PR_SALE_ORG, Row];
                Common.Summary_sGrd.Cells[GDM_VIEWPRICE, Common.Summary_sGrd.RowCount-1] := Cells[GDM_PR_SALE_ORG, Row];
              end
              else
              begin
                Common.Summary_sGrd.Cells[GDM_PR_SALE,   Common.Summary_sGrd.RowCount-1] := Cells[GDM_PR_SALE_DB, Row];
                Common.Summary_sGrd.Cells[GDM_VIEWPRICE, Common.Summary_sGrd.RowCount-1] := Cells[GDM_PR_SALE_DB, Row];
              end;
              Common.Summary_sGrd.Cells[GDM_AMT, Common.Summary_sGrd.RowCount-1]       := '0';
              Common.Summary_sGrd.Cells[GDM_DS_SALE, Common.Summary_sGrd.RowCount-1]   := 'S';
              AmtReCompute(-StoI(Cells[GDM_QTY, Row]), liSRow);
              if Common.Summary_sGrd.Cells[GDM_QTY, liSRow] = '0' then Common.DeleteRow(Common.Summary_sGrd, liSRow);
              vApply1 := True;
            end;
          end;

          Cells[GDM_DS_SALE, Row] := 'S';
          if Cells[GDM_YN_DOUBLE, Row] = 'N' then ASalePr := StoI(Cells[GDM_PR_SALE_ORG, Row])
          else                                    ASalePr := StoI(Cells[GDM_PR_SALE_DB, Row]);
          vDcAmt := StoI(Cells[GDM_DC_MENU, Row]);
        end
        else
        //정상을 서비스로 바꿀때
        begin
          visToService := true;
          liSRow := GetSummaryGridRow;
          vSaleMenuRow := Row;
          vSeq         := StoI(Cells[GDM_NO, Row]);
          if Cells[GDM_YN_ORDER, Row] = 'Y' then
            if not Common.AskBox(Format('"%s" 메뉴를'#13'서비스로 변경하시겠습니까?',[Cells[GDM_NM_MENU, Row]])) then Exit;

          //서비스사유코드
          if GetOption(342) = '1' then
          begin
            KitchenMemo_F := TKitchenMemo_F.Create(Self);
            try
              KitchenMemo_F.MemoType := mmService;

              if KitchenMemo_F.ShowModal = mrOK then
              begin
                vServiceCode := KitchenMemo_F.MemoStr;
              end;
            finally
              FreeAndNil(KitchenMemo_F);
            end;
          end;


          if (Cells[GDM_DS_MENU, Row] <> 'W') and (StoI(Cells[GDM_QTY, Row]) >= 2) then
          begin
            vServiceQty := Common.ShowNumberForm('서비스수량', 0, StoI(Cells[GDM_QTY, Row]), Cells[GDM_QTY, Row]);
            if StoI(vServiceQty) = 0 then Exit;
          end
          else if (Cells[GDM_DS_MENU, Row] = 'W') then
          begin
            vServiceQty    := Cells[GDM_QTY, Row];
            vServiceAmtStr := Cells[GDM_AMT, Row];
          end
          else
            vServiceQty := '1';

          //주문수량중에 일부만 서비스로 했을때
          if Cells[GDM_QTY, Row] <> vServiceQty then
          begin
            //기존수량에서 서비스 수량을 뺀다
            Goods_QtyDec(Trim(Cells[GDM_CD_MENU,Row]),
                         Trim(Cells[GDM_CD_ITEM,   Row]),
                         StoI(vServiceQty)*-1,
                         StoI(Cells[GDM_PR_SALE, Row]),
                         StoI(Cells[GDM_DC_MENU, Row]),
                         Ifthen((GetOption(396)='0') or (Cells[GDM_YN_ORDER,Row] = 'N'),'Y','N'),
                         'Y');
            //서비스수량만큰 신규주문을 한다
            WorkKind := wkService;
            RestoreQty := StoI(vServiceQty);
            FMenuCode  := Cells[GDM_CD_MENU, Row];
            FItemCode  := Cells[GDM_CD_ITEM, Row];
            isKitchenPrint := (GetOption(396)='0') or (Cells[GDM_YN_ORDER,Row] = 'N');
            if not SelectMenu(2) then Exit;
            //신규서비스에 서비스 사유코드를 지정한다
            Common.Summary_sGrd.Cells[GDM_CD_SERVICE, GetSummaryGridRow1] := vServiceCode;
            if vServiceAmtStr <> '' then
            begin
              Cells[GDM_PR_SALE_ORG, Row] := vServiceAmtStr;
              Common.Summary_sGrd.Cells[GDM_PR_SALE_ORG, GetSummaryGridRow1] := vServiceAmtStr;
            end;
            Cells[GDM_CD_SERVICE, Row]  := vServiceCode;
            Cells[GDM_SERVICE_CHG, Row] := 'Y';

            if (Cells[GDM_DS_MENU, Row] = 'C') or (Cells[GDM_DS_MENU, Row] = 'O') then
            begin
              For vIndex := vSaleMenuRow+1 to RowCount-1 do
              begin
                 if (Cells[GDM_YN_ORDER, vSaleMenuRow] = Cells[GDM_YN_ORDER, vIndex]) and
                    (Cells[GDM_CD_MENU,  vSaleMenuRow] = Cells[GDM_CD_MENU,  vIndex]) and
                    (Cells[GDM_DS_MENU,  vSaleMenuRow] = Cells[GDM_DS_MENU,  vIndex]) and
                    (Cells[GDM_DS_SALE,  vSaleMenuRow] = Cells[GDM_DS_SALE,  vIndex]) and
                    (Cells[GDM_DC_MENU,  vSaleMenuRow] = Cells[GDM_DC_MENU,  vIndex]) and
                    (Cells[GDM_SEQ,      vSaleMenuRow] = Cells[GDM_SEQ,      vIndex]) then
                 begin
                   Common.Menu.cd_menu  := Cells[GDM_CD_MENU, vIndex];
                   Common.Menu.ds_menu  := Cells[GDM_DS_MENU, vIndex];
                   Common.Menu.no_step  := StrToInt(Cells[GDM_NO_STEP, vIndex]);
                   Common.Menu.nm_menu  := Cells[GDM_NM_MENU, vIndex];
                   Common.Menu.cd_menu1 := Cells[GDM_CD_MENU1, vIndex];
                   Common.Menu.kitchen  := Cells[GDM_KITCHEN, vIndex];
                   Common.Menu.qty_sale := StrToInt(Cells[GDM_QTY, vIndex]) div StrToInt(Cells[GDM_QTY, vSaleMenuRow]) * RestoreQty;
                   Common.Menu.dc_menu  := 0;
                   Common.Menu.no_spc   := '';
                   Common.Menu.dc_spc   := 0;
                   MainGrid_add;
                 end;
              end;
            end;
            //서비스를 정상메뉴 아래로 옮길때
            if (Cells[GDM_YN_ORDER, vSaleMenuRow] = 'N') and (Cells[GDM_DS_MENU, Row] = 'N') then
            begin
              vSvcMenuRow := Main_sGrd.Row;
              vMenuCode   := Cells[GDM_CD_MENU, Row];
              vSvcSeq     := StrToInt(Cells[GDM_SEQ, vSaleMenuRow]);
              try
                vRowList := TStringList.Create;
                vRowList.Clear;
                //서비스추가한 Row Data 임시보관
                vRowList.Assign(Main_sGrd.Rows[vSvcMenuRow]);

                for vIndex := vSvcMenuRow downto vSaleMenuRow+1 do
                begin
                  Main_sGrd.Rows[vIndex] := Main_sGrd.Rows[vIndex-1];    //2 <- 1
                  if Cells[GDM_NO, vIndex] <> '' then
                    Cells[GDM_NO, vIndex] := IntToStr(StoI(Cells[GDM_NO, vIndex])+1);
                end;

                Main_sGrd.Rows[vSaleMenuRow+1] := vRowList;
                Main_sGrd.Cells[GDM_NO, vSaleMenuRow+1] := IntToStr(vSeq+1);
                Main_sGrd.Row := vSaleMenuRow+1;
                for vIndex := vSaleMenuRow+1 to RowCount-1 do
                begin
                  if vIndex = vSaleMenuRow+1 then
                    Cells[GDM_SEQ, vIndex] := IntToStr(vSvcSeq+1)
                  else
                    Cells[GDM_SEQ, vIndex] := IntToStr(StrToInt(Cells[GDM_SEQ, vIndex])+1);
                end;

              finally
                SetRowNumber;
                vRowList.Free;
              end;

              Exit;
            end
          end
          else //if StoI(Cells[GDM_QTY, Row]) = 1 then
          begin
//            vServiceQty := '1';
            //서비스수량만큰 신규주문을 한다
            WorkKind   := wkService;
            RestoreQty := StoI(vServiceQty);
            FMenuCode  := Cells[GDM_CD_MENU, Row];
            FItemCode  := Cells[GDM_CD_ITEM, Row];
            vOrgOrderAmt := Cells[GDM_PR_SALE, Row];
            vOrder       := Cells[GDM_YN_ORDER,Row];

            isKitchenPrint := (GetOption(396)='0') or (Cells[GDM_YN_ORDER,Row] = 'N');
            SelectMenu(2,0);
            Cells[GDM_AMT_ORG, Row] := vOrgOrderAmt;
            //신규서비스에 서비스 사유코드를 지정한다
            Common.Summary_sGrd.Cells[GDM_CD_SERVICE, GetSummaryGridRow1] := vServiceCode;
            if vServiceAmtStr <> '' then
            begin
              Cells[GDM_PR_SALE_ORG, Row] := vServiceAmtStr;
              Common.Summary_sGrd.Cells[GDM_PR_SALE_ORG, GetSummaryGridRow1] := vServiceAmtStr;
            end;
            Cells[GDM_CD_SERVICE, Row]  := vServiceCode;
            Cells[GDM_SERVICE_CHG, Row] := 'Y';
            if (vOrder = 'Y') and (Cells[GDM_DS_MENU, Row] = 'W') then
              Cells[GDM_YN_MUST, Row]    := 'Y';      //그냥 닫았을때 저장하기 위함
            if (Cells[GDM_DS_MENU, Row] = 'C') or (Cells[GDM_DS_MENU, Row] = 'O') then
            begin
              For vIndex := vSaleMenuRow+1 to RowCount-1 do
              begin
                 if (Cells[GDM_YN_ORDER, vSaleMenuRow] = Cells[GDM_YN_ORDER, vIndex]) and
                    (Cells[GDM_CD_MENU,  vSaleMenuRow] = Cells[GDM_CD_MENU,  vIndex]) and
                    (Cells[GDM_DS_MENU,  vSaleMenuRow] = Cells[GDM_DS_MENU,  vIndex]) and
                    (Cells[GDM_DS_SALE,  vSaleMenuRow] = Cells[GDM_DS_SALE,  vIndex]) and
                    (Cells[GDM_DC_MENU,  vSaleMenuRow] = Cells[GDM_DC_MENU,  vIndex]) and
                    (Cells[GDM_SEQ,      vSaleMenuRow] = Cells[GDM_SEQ,      vIndex]) then
                 begin
                   Common.Menu.cd_menu  := Cells[GDM_CD_MENU, vIndex];
                   Common.Menu.no_step  := StrToInt(Cells[GDM_NO_STEP, vIndex]);
                   Common.Menu.nm_menu  := Cells[GDM_NM_MENU, vIndex];
                   Common.Menu.cd_menu1 := Cells[GDM_CD_MENU1, vIndex];
                   Common.Menu.kitchen  := Cells[GDM_KITCHEN, vIndex];
                   Common.Menu.qty_sale := StrToInt(Cells[GDM_QTY, vIndex]);
                   Common.Menu.dc_menu  := 0;
                   Common.Menu.no_spc   := '';
                   Common.Menu.dc_spc   := 0;
                   MainGrid_add;
                 end;
              end;
            end;
            Row := vSaleMenuRow;
            //기존수량에서 서비스 수량을 뺀다
            Goods_QtyDec(Trim(Cells[GDM_CD_MENU, Row]),
                         Trim(Cells[GDM_CD_ITEM, Row]),
                         StoI(vServiceQty)*-1,
                         StoI(Cells[GDM_PR_SALE, Row]),
                         StoI(Cells[GDM_DC_MENU, Row]),
                         Ifthen((GetOption(396)='0') or (Cells[GDM_YN_ORDER,Row] = 'N'),'Y','N'),
                         'Y');
            Exit;
          end;

          //서비스메뉴를 찾는다
          vBefRow := GetSummaryGridRow1;

          if vBefRow > -1 then
          begin
            //Common.Summary_sGrd.Cells[GDM_QTY, vBefRow] := IntToStr(StoI(Common.Summary_sGrd.Cells[GDM_QTY, vBefRow]) + StoI(Cells[GDM_QTY, Row]));
          end
          else
          begin
            Common.Summary_sGrd.RowCount := Common.Summary_sGrd.RowCount + 1;
            Common.Summary_sGrd.Rows[Common.Summary_sGrd.RowCount-1].Assign( Common.Summary_sGrd.Rows[liSRow]);
            Common.Summary_sGrd.Cells[GDM_QTY, Common.Summary_sGrd.RowCount-1]     := vServiceQty;// Cells[GDM_QTY, Row];
            Common.Summary_sGrd.Cells[GDM_AMT, Common.Summary_sGrd.RowCount-1]     := '0';
            Common.Summary_sGrd.Cells[GDM_DC_MENU, Common.Summary_sGrd.RowCount-1] := '0';
            Common.Summary_sGrd.Cells[GDM_DS_SALE, Common.Summary_sGrd.RowCount-1] := 'D';
            Common.Summary_sGrd.Cells[GDM_PR_SALE, Common.Summary_sGrd.RowCount-1] := '0';
            Common.Summary_sGrd.Cells[GDM_CD_SERVICE, Common.Summary_sGrd.RowCount-1] := vServiceCode;
          end;
          vApply := True;
        end;

        Cells[GDM_PR_SALE, Row]   := IntToStr(ASalePr);
        Cells[GDM_VIEWPRICE, Row] := IntToStr(ASalePr);


        if Cells[GDM_DS_MENU, Row] = 'W' then
          Cells[GDM_AMT, Row]       := Cells[GDM_AMT_ORG, Row]
        else
          Cells[GDM_AMT, Row]       := IntToStr(ASalePr * StoI(Cells[GDM_QTY, Row]) );


        Cells[GDM_CHANGE, Row] := 'Y';
        Cells[GDM_SVC,    Row] := 'Y';

        liRow := Row;

        For vIndex := liRow+1 to RowCount-1 do
        begin
           if (Cells[GDM_YN_ORDER, liRow] = Cells[GDM_YN_ORDER, vIndex]) and
              (Cells[GDM_CD_MENU,  liRow] = Cells[GDM_CD_MENU,  vIndex]) and
              (Cells[GDM_DS_MENU,  liRow] = Cells[GDM_DS_MENU,  vIndex]) and
              (lsOrgDsOrder               = Cells[GDM_DS_SALE,  vIndex]) and
              (Cells[GDM_SEQ,      liRow] = Cells[GDM_SEQ,      vIndex]) then
           begin
             Cells[GDM_DS_SALE, vIndex] := Cells[GDM_DS_SALE, Row];
             Cells[GDM_CHANGE, vIndex] := 'Y';

             //아이템메뉴일 때 부메뉴들의 단가 처리
             if (lsDsMenu = 'I') and (Cells[GDM_CD_MENU1,  vIndex] <> '') then
             begin
               if Cells[GDM_DS_SALE, Row] = 'S' then
               begin
                 Cells[GDM_VIEWPRICE, vIndex] := Cells[GDM_PR_SALE_ORG, vIndex];
                 Cells[GDM_PR_SALE, vIndex]   := Cells[GDM_PR_SALE_ORG, vIndex];
                 if Cells[GDM_DS_MENU, liSRow] <> 'W' then
                 begin
                   Cells[GDM_AMT, vIndex]  := IntToStr(StoI(Cells[GDM_PR_SALE, vIndex]) * StoI(Cells[GDM_QTY, vIndex]));
                 end
                 else
                 begin
                   Cells[GDM_AMT, vIndex]  := Cells[GDM_PR_SALE, vIndex];
                 end;
               end
               else
               begin
                 Cells[GDM_VIEWPRICE, vIndex] := '0';
                 Cells[GDM_PR_SALE, vIndex]   := '0';
                 Cells[GDM_PR_ITEM, vIndex]   := '0';
                 Cells[GDM_AMT, vIndex]       := '0';
               end;
             end;
           end;
        end;

        //서비스를 정상, 정상을 서비스로 둘다 적용을 안했을때
        if (not vApply) and (not vApply1) then
        begin
          Common.Summary_sGrd.Cells[GDM_PR_SALE, liSRow]    := Cells[GDM_PR_SALE, Row];
          Common.Summary_sGrd.Cells[GDM_DS_SALE, liSRow]    := Cells[GDM_DS_SALE, Row];
          Common.Summary_sGrd.Cells[GDM_DC_MENU, liSRow]    := '0';
          Common.Summary_sGrd.Cells[GDM_CD_SERVICE, liSRow] := Cells[GDM_CD_SERVICE, Row];

          if Common.Summary_sGrd.Cells[GDM_DS_MENU, liSRow] = 'W' then
          begin
            Dcpr := StoI(Common.Summary_sGrd.Cells[GDM_AMT, liSRow]) + ASalePr;
            Common.Summary_sGrd.Cells[GDM_AMT, liSRow] := IntToStr(ASalePr);
          end
          else
          begin
            Dcpr := StoI(Common.Summary_sGrd.Cells[GDM_AMT, liSRow]) - (ASalePr *  StoI(Common.Summary_sGrd.Cells[GDM_QTY, liSRow]) );
            Common.Summary_sGrd.Cells[GDM_AMT, liSRow] := IntToStr(ASalePr *  StoI(Common.Summary_sGrd.Cells[GDM_QTY, liSRow]));
          end;
        end
        else
        begin
          if Common.Summary_sGrd.Cells[GDM_DS_MENU, liSRow] = 'W' then
          begin
            Dcpr := ASalePr;
          end
          else
          begin
            Dcpr := ASalePr *  StoI(Cells[GDM_QTY, Row]) ;
          end;
        end;

        //변경 후 상태
        if Cells[GDM_DS_SALE, Row] = 'S' then
        begin
          if not vApply then
            Common.Present.TotalAmt := Common.Present.TotalAmt + ABS(FtoI(Dcpr));
          Cells[GDM_NM_MENU, Row] := StringReplace(Cells[GDM_NM_MENU, Row], Common.Config.ServiceTxt, '', [rfReplaceAll]);

          //행사일때는 행사할인을 반영한다
          if StoI(Cells[GDM_DC_SPC, Row]) <> 0 then
            Common.PreSent.SpcDc  := Common.PreSent.SpcDc + ( StoI(Cells[GDM_DC_SPC, Row]) * StoI(Cells[GDM_QTY, Row]) );
        end
        else
        begin
          if not vApply then
            Common.Present.TotalAmt := Common.Present.TotalAmt - ABS(FtoI(Dcpr));
          if Pos(Common.Config.ServiceTxt, Cells[GDM_NM_MENU, Row]) = 0 then
            Cells[GDM_NM_MENU, Row] := Cells[GDM_NM_MENU, Row]+Common.Config.ServiceTxt;

          //행사일때는 행사할인금액을 제외한다
          if StoI(Cells[GDM_DC_SPC, Row]) <> 0 then
            Common.PreSent.SpcDc  := Common.PreSent.SpcDc - ( StoI(Cells[GDM_DC_SPC, Row]) * StoI(Cells[GDM_QTY, Row]) );

          //메뉴할인을 한 메뉴일때
          if StoI(Cells[GDM_DC_MENU, Row]) <> 0 then
          begin
            Common.PreSent.MenuDc   := Common.PreSent.MenuDc - ( StoI(Cells[GDM_DC_MENU, Row]) * StoI(Cells[GDM_QTY, Row]) );
            Cells[GDM_DC_MENU, Row] := '0';
          end;
        end;
      end;
      DisplayPresent;
    end;
  finally
    RestoreQty := 0;
  end;
end;

procedure TOrder_F.Action8Execute(Sender: TObject);
  function GetSummaryGridRow(aDsSale:String): Integer;
  var vRow:Integer;
  begin
    Result := -1;
     with Main_sGrd do
     begin
       For vRow := 0 to Common.Summary_sGrd.RowCount - 1 do
       begin
         if (Cells[GDM_CD_MENU, Row] = Common.Summary_sGrd.Cells[GDM_CD_MENU, vRow])
           and (Cells[GDM_PR_SALE, Row] = Common.Summary_sGrd.Cells[GDM_PR_SALE, vRow])
           and (aDsSale = Common.Summary_sGrd.Cells[GDM_DS_SALE, vRow])
           and (Common.Summary_sGrd.Cells[GDM_CD_MENU1, vRow] = '')
           and (Cells[GDM_DC_MENU, Row] = Common.Summary_sGrd.Cells[GDM_DC_MENU, vRow])
           then
         begin
           Result := vRow;
           Break;
         end;
       end;
     end;
  end;
var vRow, vBefRow, vPrice, Dcpr, vOrgAmt, vDcAmt, vOrgQty :Integer;
    vApply, vApply1 :Boolean;   //vApply :포장를 정상으로 변경 적용여부 , vApply1 :정상을 포장으로 변경 적용여부
    vPackingQty :String;
begin
  //마감 상태였으면 초기화한다
  if CheckSaleFinish then Exit;
  if Common.Table.Packing = 'Y' then
  begin
    Common.MsgBox('포장전용 테이블일때는 사용할 수 없습니다');
    Exit;
  end;

  if not CheckPresentChange then Exit;

  //TakeOut 이면서 서비스를 포장할때
  if Common.Config.IsTakeOut and (Main_sGrd.Cells[GDM_DS_SALE, Main_sGrd.Row] = 'D') then
  begin
    if Pos(Common.Config.PackingTxt,Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row]) = 0  then
      Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row] := Common.Config.PackingTxt+Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row]
    else
      Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row] := Replace(Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row],Common.Config.PackingTxt,'');

    vRow := GetSummaryGridRow('D');
    if Pos(Common.Config.PackingTxt, Common.Summary_sGrd.Cells[GDM_NM_MENU, vRow]) = 0  then
      Common.Summary_sGrd.Cells[GDM_NM_MENU, vRow] := Common.Config.PackingTxt+Common.Summary_sGrd.Cells[GDM_NM_MENU, vRow]
    else
      Common.Summary_sGrd.Cells[GDM_NM_MENU, vRow] := Replace(Common.Summary_sGrd.Cells[GDM_NM_MENU, vRow],Common.Config.PackingTxt,'');

    DisplayPresent;
    Exit;
  end
  else if Common.Config.IsTakeOut and (Main_sGrd.Cells[GDM_DS_SALE, Main_sGrd.Row] = 'P') then
  begin
    FMenuCode := Main_sGrd.Cells[GDM_CD_MENU,   Main_sGrd.Row];
    FMenuName := Main_sGrd.Cells[GDM_NM_MENU,   Main_sGrd.Row];
    FMsrData  := Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row];
    Action4Execute(nil);
    PluMenuButtonClick(nil);
    Exit;

//    Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row] := Replace(Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row],Common.Config.PackingTxt,'');
//    Main_sGrd.Cells[GDM_DS_SALE, Main_sGrd.Row] := 'S';
//    if Main_sGrd.Cells[GDM_PR_SALE_PACKING, Main_sGrd.Row] <> '0' then
//    begin
//       Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row] := Main_sGrd.Cells[GDM_PR_SALE_ORG, Main_sGrd.Row];
//       Main_sGrd.Cells[GDM_AMT, Main_sGrd.Row]     := IntToStr(StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]) * StoI(Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row]));
//    end;
//
//    vRow := GetSummaryGridRow('P');
//    Common.Summary_sGrd.Cells[GDM_NM_MENU, vRow] := Replace(Common.Summary_sGrd.Cells[GDM_NM_MENU, vRow],Common.Config.PackingTxt,'');
//    Common.Summary_sGrd.Cells[GDM_DS_SALE, vRow] := 'S';
//    if Common.Summary_sGrd.Cells[GDM_PR_SALE_PACKING, vRow] <> '0' then
//    begin
//       Common.Summary_sGrd.Cells[GDM_PR_SALE, vRow] := Common.Summary_sGrd.Cells[GDM_PR_SALE_ORG, vRow];
//       Common.Summary_sGrd.Cells[GDM_AMT,     vRow] := IntToStr(StoI(Common.Summary_sGrd.Cells[GDM_QTY, vRow]) * StoI(Common.Summary_sGrd.Cells[GDM_PR_SALE, vRow]));
//    end;
//    DisplayPresent;
//    Exit;
  end
  else if Common.Config.IsTakeOut and (Main_sGrd.Cells[GDM_DS_SALE, Main_sGrd.Row] = 'S') then
  begin
    vOrgQty := StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]);
    if (Main_sGrd.Cells[GDM_DS_MENU, Main_sGrd.Row] = 'N') and (StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]) >= 2) then
    begin
      vPackingQty := Common.ShowNumberForm('포장 수량', 0, StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]), Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]);
      if StoI(vPackingQty) = 0 then Exit;

      if StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]) = StoI(vPackingQty) then
      begin
        Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row] := Common.Config.PackingTxt + Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row];
        Main_sGrd.Cells[GDM_DS_SALE, Main_sGrd.Row] := 'P';
        if Main_sGrd.Cells[GDM_PR_SALE_PACKING, Main_sGrd.Row] <> '0' then
        begin
           Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row] := Main_sGrd.Cells[GDM_PR_SALE_PACKING, Main_sGrd.Row];
           Main_sGrd.Cells[GDM_AMT, Main_sGrd.Row]     := IntToStr(StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]) * StoI(Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row]));
        end;

        vRow := GetSummaryGridRow('S');
        Common.Summary_sGrd.Cells[GDM_NM_MENU, vRow] := Common.Config.PackingTxt + Common.Summary_sGrd.Cells[GDM_NM_MENU, vRow];
        Common.Summary_sGrd.Cells[GDM_DS_SALE, vRow] := 'P';
        if Common.Summary_sGrd.Cells[GDM_PR_SALE_PACKING, vRow] <> '0' then
        begin
           Common.Summary_sGrd.Cells[GDM_PR_SALE, vRow] := Common.Summary_sGrd.Cells[GDM_PR_SALE_PACKING, vRow];
           Common.Summary_sGrd.Cells[GDM_AMT,     vRow] := IntToStr(StoI(Common.Summary_sGrd.Cells[GDM_QTY, vRow]) * StoI(Common.Summary_sGrd.Cells[GDM_PR_SALE, vRow]));
        end;
        DisplayPresent;
        Exit;
      end
      else
      begin
        //기존수량에서 서비스 수량을 뺀다
        Goods_QtyDec(Trim(Main_sGrd.Cells[GDM_CD_MENU,Main_sGrd.Row]),
                     Trim(Main_sGrd.Cells[GDM_CD_ITEM,   Main_sGrd.Row]),
                     StoI(vPackingQty)*-1,
                     StoI(Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row]),
                     StoI(Main_sGrd.Cells[GDM_DC_MENU, Main_sGrd.Row]),
                     'Y',
                     'Y');
        WorkKind  := wkPacking;
        FMsrData  := vPackingQty;
        FMenuCode := Main_sGrd.Cells[GDM_CD_MENU,   Main_sGrd.Row];
        FMenuName := Main_sGrd.Cells[GDM_NM_MENU,   Main_sGrd.Row];
        PluMenuButtonClick(nil);
        Exit;
      end;
    end;
    Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row] := Common.Config.PackingTxt + Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row];
    Main_sGrd.Cells[GDM_DS_SALE, Main_sGrd.Row] := 'P';
    if Main_sGrd.Cells[GDM_PR_SALE_PACKING, Main_sGrd.Row] <> '0' then
    begin
       Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row] := Main_sGrd.Cells[GDM_PR_SALE_PACKING, Main_sGrd.Row];
       Main_sGrd.Cells[GDM_AMT, Main_sGrd.Row]     := IntToStr(StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]) * StoI(Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row]));
    end;

    vRow := GetSummaryGridRow('S');
    Common.Summary_sGrd.Cells[GDM_NM_MENU, vRow] := Common.Config.PackingTxt + Common.Summary_sGrd.Cells[GDM_NM_MENU, vRow];
    Common.Summary_sGrd.Cells[GDM_DS_SALE, vRow] := 'P';
    if Common.Summary_sGrd.Cells[GDM_PR_SALE_PACKING, vRow] <> '0' then
    begin
       Common.Summary_sGrd.Cells[GDM_PR_SALE, vRow] := Common.Summary_sGrd.Cells[GDM_PR_SALE_PACKING, vRow];
       Common.Summary_sGrd.Cells[GDM_AMT,     vRow] := IntToStr(StoI(Common.Summary_sGrd.Cells[GDM_QTY, vRow]) * StoI(Common.Summary_sGrd.Cells[GDM_PR_SALE, vRow]));
    end;
    DisplayPresent;
    Exit;
  end;


  //선주문 후 포장
  if GetOption(303) = '0' then
  begin
    case WorkKind of
      wkPacking : WorkKind := wkSale;
      else
        WorkKind := wkPacking;
    end;
  end
  else
  begin
    with Main_sGrd do
    begin
      if Cells[0,0] = '' then
      begin
        Common.ErrBox('메뉴를 먼저 주문해야 합니다');
        Exit;
      end;

      if Cells[GDM_DS_SALE, Row] = 'B' then
      begin
        Common.ErrBox('반품메뉴에는 사용할 수 없습니다');
        Exit;
      end;

      if (StoI(Cells[GDM_NO_STEP, Row]) > 0) then
      begin
        Common.ErrBox('부메뉴에는 사용할 수 없습니다');
        Exit;
      end;

      if Cells[GDM_YN_ORDER, Row] = 'Y' then
      begin
        Common.ErrBox('주문이 완료 된'#13'메뉴에는 사용할 수 없습니다');
        Exit;
      end;

      if Cells[GDM_YN_DOUBLE, Row] = 'Y' then
      begin
        Common.ErrBox('곱빼기 메뉴는 포장할 수 없습니다');
        Exit;
      end;

      vApply  := False;
      vApply1 := False;


      //포장을 정상으로 바꿀때
      if Cells[GDM_DS_SALE, Row] = 'P' then
      begin
        //집계그리드의 포장메뉴 인덱스를 구한다
        vRow := GetSummaryGridRow('P');
        if (vRow >=0) and ((StoI(Common.Summary_sGrd.Cells[GDM_QTY, vRow]) - StoI(Cells[GDM_QTY, Row])) > 0) then
        begin
          //포장상태의 수량을 하나 뺀다
          AmtReCompute(-StoI(Cells[GDM_QTY, Row]), vRow);
          vApply1 := True;
        end;
        //집계그리드에서 현재 정상 상품의 Row 인덱스를 구한다
        vBefRow := GetSummaryGridRow('S');
        //정상상태의 메뉴가 존재하면
        if vBefRow > -1 then
        begin
          //정상 메뉴의 수량을 하나 추가
          AmtReCompute(StoI(Cells[GDM_QTY, Row]), vBefRow);
          //포장 메뉴의 수량을 하나 뺀다
          AmtReCompute(-StoI(Cells[GDM_QTY, Row]), vRow);

          if Common.Summary_sGrd.Cells[GDM_QTY, vRow] = '0' then Common.DeleteRow(Common.Summary_sGrd, vRow);
          vApply1 := True;
        end
        else
        begin
          //집계그리드에 메뉴가 없으면 Row를 하나 추가한다
          Common.Summary_sGrd.RowCount := Common.Summary_sGrd.RowCount + 1;
          vRow := GetSummaryGridRow('P');
          Common.Summary_sGrd.Rows[Common.Summary_sGrd.RowCount-1].Assign( Common.Summary_sGrd.Rows[vRow]);
          Common.Summary_sGrd.Cells[GDM_DS_SALE, Common.Summary_sGrd.RowCount-1] := 'S';
          Common.Summary_sGrd.Cells[GDM_QTY,     Common.Summary_sGrd.RowCount-1] := '0';
          Common.Summary_sGrd.Cells[GDM_PR_SALE, Common.Summary_sGrd.RowCount-1] := Common.Summary_sGrd.Cells[GDM_PR_SALE_ORG, Common.Summary_sGrd.RowCount-1];
          //정상 메뉴의 수량을 추가
          AmtReCompute(StoI(Cells[GDM_QTY, Row]), Common.Summary_sGrd.RowCount-1);
          //정상 메뉴의 수량을 추가
          AmtReCompute(-StoI(Cells[GDM_QTY, Row]), vRow);

          if Common.Summary_sGrd.Cells[GDM_QTY, vRow] = '0' then
            Common.DeleteRow(Common.Summary_sGrd, vRow);

          vApply1 := True;
        end;
{
        //집계그리드의 포장메뉴 인덱스를 구한다
        vRow := GetPackingMenuSummaryGridRow('P');
        //포장 메뉴의 수량을 뺀다
        AmtReCompute(-StoI(Cells[GDM_QTY, Row]), vRow);
        if Common.Summary_sGrd.Cells[GDM_QTY, vRow] = '0' then Common.DeleteRow(Common.Summary_sGrd, vRow);
        Cells[GDM_DS_SALE, Row] := 'S';
        Cells[GDM_NM_MENU, Row] := Replace(Cells[GDM_NM_MENU, Row],Common.Config.PackingTxt,'');
        Common.Summary_sGrd.Cells[GDM_NM_MENU, vRow] := Cells[GDM_NM_MENU, Row];
}
        Cells[GDM_DS_SALE, Row] := 'S';
        vPrice := StoI(Cells[GDM_PR_SALE_ORG, Row]);
        vDcAmt := StoI(Cells[GDM_DC_MENU, Row]);
      end
      else
      begin
        if Copy(Cells[GDM_CONFIG, Row],10,1) = 'Y' then
        begin
          Common.ErrBox('포장할 수 없는 메뉴입니다');
          Exit;
        end;

        //집계그리드의 포장메뉴 인덱스를 구한다
        vRow := GetSummaryGridRow('P');
        if (vRow >=0) and ((StoI(Common.Summary_sGrd.Cells[GDM_QTY, vRow]) - StoI(Cells[GDM_QTY, Row])) > 0) then
        begin
          //정상메뉴를 찾는다
          vBefRow := GetSummaryGridRow('S');
          if vBefRow > -1 then
            Common.Summary_sGrd.Cells[GDM_QTY, vBefRow] := IntToStr(StoI(Common.Summary_sGrd.Cells[GDM_QTY, vBefRow]) + StoI(Cells[GDM_QTY, Row]))
          else
          begin
            //집계그리드에 메뉴가 없으면 Row를 하나 추가한다
            Common.Summary_sGrd.RowCount := Common.Summary_sGrd.RowCount + 1;
            vRow := GetSummaryGridRow('S');
            Common.Summary_sGrd.Rows[Common.Summary_sGrd.RowCount-1].Assign( Common.Summary_sGrd.Rows[vRow]);
            Common.Summary_sGrd.Cells[GDM_DS_SALE, Common.Summary_sGrd.RowCount-1] := 'P';
            Common.Summary_sGrd.Cells[GDM_QTY,     Common.Summary_sGrd.RowCount-1] := '0';
            //포장 메뉴의 수량을 추가
            AmtReCompute(StoI(Cells[GDM_QTY, vRow]), Common.Summary_sGrd.RowCount-1);

            if Common.Summary_sGrd.Cells[GDM_QTY, vRow] = '0' then
              Common.DeleteRow(Common.Summary_sGrd, vRow);
            vApply := True;
          end;
        end
        else
        begin
          if vRow = -1 then
            vRow := GetSummaryGridRow('S');
          Common.Summary_sGrd.Cells[GDM_DS_SALE,   vRow]   := 'P';
          Common.Summary_sGrd.Cells[GDM_PR_SALE,   vRow]   := Cells[GDM_PR_SALE_PACKING, Row];
          Common.Summary_sGrd.Cells[GDM_VIEWPRICE, vRow]   := Cells[GDM_PR_SALE_PACKING, Row];
        end;

        Cells[GDM_DS_SALE, Row] := 'P';
        vPrice := StoI(Cells[GDM_PR_SALE_PACKING, Row]);
        vDcAmt := StoI(Cells[GDM_DC_MENU, Row]);
      end;

      Cells[GDM_PR_SALE, Row]   := IntToStr(vPrice);
      Cells[GDM_VIEWPRICE, Row] := IntToStr(vPrice);

      if Cells[GDM_DS_MENU, Row] = 'W' then
        Cells[GDM_AMT, Row]       := IntToStr(vPrice)
      else
        Cells[GDM_AMT, Row]       := IntToStr(vPrice * StoI(Cells[GDM_QTY, Row]) );

      Cells[GDM_CHANGE, Row] := 'Y';

      vOrgAmt := StrToInt(Common.Summary_sGrd.Cells[GDM_AMT, vRow]);
      //포장를 정상, 정상을 포장로 둘다 적용을 안했을때
{      if (not vApply) and (not vApply1) then
      begin
        if Common.Summary_sGrd.Cells[GDM_DS_MENU, vRow] = 'W' then
        begin
          Dcpr := StoI(Common.Summary_sGrd.Cells[GDM_AMT, vRow]) + vPrice;
          Common.Summary_sGrd.Cells[GDM_AMT, vRow] := IntToStr(vPrice);
        end
        else
        begin
          Dcpr := StoI(Common.Summary_sGrd.Cells[GDM_AMT, vRow]) - (vPrice *  StoI(Common.Summary_sGrd.Cells[GDM_QTY, vRow]) );
          Common.Summary_sGrd.Cells[GDM_AMT, vRow] := IntToStr(vPrice *  StoI(Common.Summary_sGrd.Cells[GDM_QTY, vRow]));
        end;
      end
      else
      begin
        if Common.Summary_sGrd.Cells[GDM_DS_MENU, vRow] = 'W' then
          Dcpr := vPrice
        else
          Dcpr := vPrice *  StoI(Cells[GDM_QTY, Row]) ;
      end;
}
      if (not vApply) or (not vApply1) then
        Common.Present.TotalAmt := Common.Present.TotalAmt
                                 + StrToInt(Common.Summary_sGrd.Cells[GDM_AMT, vRow]) - vOrgAmt;

      //변경 후 상태
      if Cells[GDM_DS_SALE, Row] = 'P' then
      begin
        Cells[GDM_NM_MENU, Row] := Common.Config.PackingTxt+Cells[GDM_NM_MENU_ORG, Row]+Cells[GDM_MEMO, Row];
        Common.Summary_sGrd.Cells[GDM_NM_MENU, vRow] := Common.Config.PackingTxt+Cells[GDM_NM_MENU_ORG, Row];
      end
      else
      begin
        Cells[GDM_NM_MENU, Row] := Cells[GDM_NM_MENU_ORG, Row] + Cells[GDM_MEMO, Row];
        Common.Summary_sGrd.Cells[GDM_NM_MENU, vRow] := Cells[GDM_NM_MENU_ORG, Row];
      end;
    end;
  end;
  DisplayPresent;
end;

procedure TOrder_F.Action10Execute(Sender: TObject);
begin
  FMenuCode := Common.ShowNumberForm('바코드를 입력하세요',18);
  if FMenuCode = 'mrClose' then Exit;
  if (Length(FMenuCode) >= 4) then
  begin
    if LeftStr(FMenuCode,2) = Common.Config.ScalePrefix then SelectMenu(1)
    else                                                     SelectMenu(0);
  end
  else
    Common.MsgBox('최소 4자리 이상이어야 합니다');
end;

procedure TOrder_F.Action11Execute(Sender: TObject);
begin
  if not CheckPresentChange then Exit;
  Common.ShowCustomerInfo;
end;

procedure TOrder_F.Action12Execute(Sender: TObject);
begin
  try
    if Common.ShowMemberForm(FMsrData) then
    begin
      if WorkState = wsReady then WorkState := wsSale;
      DisplayPresent;
      //테이블 담당자가 지정되어 있지 않을때는 회원의 담당자로 지정한다
      if (Common.Table.DamdangCode = EmptyStr) and (Common.Member.DamdangCode <> EmptyStr) then
      begin
       Common.Table.DamdangCode := Common.Member.DamdangCode;
       Common.Table.DamdangName := Common.Member.DamdangName;
       lbl_Damdang.Caption      := '['+Common.Table.DamdangName+']';
      end;

      //회원기본메뉴
      if (Common.Config.MemberDefaultMenu <> '') and not GetMenuOrderCheck(Common.Config.MemberDefaultMenu) then
      begin
        FMenuCode := Common.Config.MemberDefaultMenu;
        SelectMenu(0);
      end;
      //회원조회 후 자동 외상결제
      if (GetOption(317) = '1') and (Common.Member.Yn_trust = 'Y') then
      begin
        Act_Trust.Execute;
        if not Common.Config.IsTakeOut and not Common.Config.IsKiosk then
        begin
          if Common.PreSent.WRcvAmt = 0 then
          begin
            Tmr_Acct.Tag     := 1;
            Tmr_Acct.Enabled := true;
          end;
        end
      end;
    end
    else
      DisplayPresent;
  finally
    Common.Device.OnScannerReadData := ScannerReadEvent;
  end;
end;

procedure TOrder_F.Action13Execute(Sender: TObject);
begin
  if Common.Config.IsKiosk then
  begin
    KioskMemo_F := TKioskMemo_F.Create(Self);
    try
      KioskMemo_F.MenuCode := Main_sGrd.Cells[GDM_CD_MENU, Main_sGrd.Row];
      if KioskMemo_F.ShowModal = mrOK then
      begin
        Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row] := StringReplace(Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row],
                                                                     '('+Main_sGrd.Cells[GDM_MEMO,    Main_sGrd.Row]+')',
                                                                     '',
                                                                     [rfReplaceAll]);
        Main_sGrd.Cells[GDM_MEMO,    Main_sGrd.Row] := '('+KioskMemo_F.MemoStr+')';
        Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row] := Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row] + Main_sGrd.Cells[GDM_MEMO, Main_sGrd.Row];
        Common.Menu.ds_menu := Main_sGrd.Cells[GDM_DS_MENU, Main_sGrd.Row];
        Common.Menu.cd_menu := Main_sGrd.Cells[GDM_CD_MENU, Main_sGrd.Row];
        Common.Menu.pr_sale := StoI(Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row]);
        Main_sGrd.Cells[GDM_SEQ, Main_sGrd.Row] := IntToStr(GetGridMenuSeq-1);
      end;
    finally
      FreeAndNil(KioskMemo_F);
    end;
    Exit;
  end;

  if Main_sGrd.Cells[0, 0] = '' then Exit;
  if Main_sGrd.Cells[GDM_YN_ORDER, Main_sGrd.Row] = 'Y' then
  begin
    Common.ErrBox('주문이 완료된 메뉴는 주방메모를'+#13#13+'할 수 없습니다');
    Exit;
  end;

  if (Main_sGrd.Cells[GDM_DS_MENU, Main_sGrd.Row][1] in ['C','S','O']) and (Main_sGrd.Cells[GDM_NO_STEP, Main_sGrd.Row] <> '0') then
//  if (Main_sGrd.Cells[GDM_DS_MENU, Main_sGrd.Row] <> 'N')
//     and (Main_sGrd.Cells[GDM_DS_MENU, Main_sGrd.Row] <> 'G')
//     and (Main_sGrd.Cells[GDM_DS_MENU, Main_sGrd.Row] <> 'W')  then
  begin
    Common.ErrBox('주방메모를 사용할 수 없는 메뉴입니다');
    Exit;
  end;

  KitchenMemo_F := TKitchenMemo_F.Create(Self);
  try
    KitchenMemo_F.MemoType := mmKitchenMemo;
    KitchenMemo_F.MenuCode := Main_sGrd.Cells[GDM_CD_MENU, Main_sGrd.Row];

    if KitchenMemo_F.ShowModal = mrOK then
    begin
      Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row] := StringReplace(Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row],
                                                                   '('+Main_sGrd.Cells[GDM_MEMO,    Main_sGrd.Row]+')',
                                                                   '',
                                                                   [rfReplaceAll]);
      Main_sGrd.Cells[GDM_MEMO,    Main_sGrd.Row] := '('+KitchenMemo_F.MemoStr+')';
      Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row] := Main_sGrd.Cells[GDM_NM_MENU, Main_sGrd.Row] + Main_sGrd.Cells[GDM_MEMO, Main_sGrd.Row];
      Common.Menu.ds_menu := Main_sGrd.Cells[GDM_DS_MENU, Main_sGrd.Row];
      Common.Menu.cd_menu := Main_sGrd.Cells[GDM_CD_MENU, Main_sGrd.Row]; //※
      Common.Menu.pr_sale := StoI(Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row]);
      Main_sGrd.Cells[GDM_SEQ, Main_sGrd.Row] := IntToStr(GetGridMenuSeq-1);
    end;
  finally
    FreeAndNil(KitchenMemo_F);
  end;
end;

procedure TOrder_F.Action14Execute(Sender: TObject);
begin
  if Common.ShowChooseForm('T','',Common.Table.DamdangCode, Common.Table.DamdangName) then
  begin
    lbl_Damdang.Caption := '['+Common.Table.DamdangName+']';
    if Common.Table.DamdangName = EmptyStr then
      lbl_Damdang.Caption := EmptyStr;
  end
  else
  begin
    Common.Table.DamdangCode := EmptyStr;
    Common.Table.DamdangName := EmptyStr;
    lbl_Damdang.Caption      := EmptyStr;
  end;
end;

procedure TOrder_F.Action15Execute(Sender: TObject);
var
  liRow :Integer;
begin
  if not Common.Config.IsTakeOut then
  begin
    Common.ErrBox('선불제에서만 사용이 가능합니다');
    Exit;
  end;

  case WorkState of
    wsReady :
       begin
          if HoldCount = 0 then Exit;
          Hold_F := THold_F.Create(Application);
          try
             if Hold_F.ShowModal = mrOk then
             begin
                Common.ShowWaitForm;
                Common.RestoreReserveData; //보류된 내역을 화면에 셋팅해준다
                DisPlayMessage(2,'보류내역을 조회 중입니다.');
                with Common.Hold_SGrd do
                begin
                   For liRow := 0 to RowCount-1 do
                   begin
                      if (Cells[GDH_DS_SALE, liRow] = 'P') then WorkKind  := wkPacking
                      else if (Cells[GDH_DS_SALE, liRow] = 'S') then WorkKind  := wkSale
                      else if (Cells[GDH_DS_SALE, liRow] = 'D') then WorkKind  := wkService;
                      RestoreQty          := StoI(Cells[GDH_QTY,   liRow]);
                      if RestoreQty < 0 then WorkKind  := wkRefund;
                      RestorePrice        := StoI(Cells[GDH_PRICE,liRow]);
                      FMenuCode           := Trim(Cells[GDH_CD_MENU, liRow]);
                      FItemCode           := Cells[GDH_ITEM, liRow];
                      SelectMenu(2);
                   end;
                end;
                Common.HideWaitForm;
                WorkState := wsSale;
                Common.SelectMemberInfo(Common.Member.Code,'','');
                DisplayPresent;
                WorkState := wsSale;       //작업상태를 매출 상태로 변경한다
                Common.GetReceiptNo;
                PosNoLabel.Caption      := Format('%s - %s',[Common.Config.PosNo,Common.PreSent.RcpNo]);
                HoldCount;
                RestoreQty    := 0;
                RestorePrice  := 0;
                FMenuCode     := '';
             end;
          finally
           FreeAndNil(Hold_F);
          end;
       end;
    wsSale :
       begin
          if not Common.Config.IsKiosk and ((Common.PreSent.TotalDc - Common.PreSent.CutDc) > 0) then
          begin
             if not Common.AskBox('할인은 보류해제시 다시 할인해야 합니다' +#13+'보류를 하시겠습니까?') then Exit;
          end;

          if Main_sGrd.Cells[0,0] = '' then Exit;
          Common.ShowWaitForm;
          if not Common.SaveReserveData then
          begin
             DisplayMessage(2,'보류가 되지 않았습니다.');
             Common.HideWaitForm;
             Exit;
          end;
          if Common.Config.IsKiosk or Common.AskBox('보류영수증을 출력하시겠습니까?') then
            Common.Device.ReservePrint;         //보류번호 출력
          WorkState := wsReady;                 //작업상태를 대기모드로 변경한다
          Common.HideWaitForm;
          DisplayMessage(2,'보류번호 : '+Common.RestoreNo);
          HoldCount;
       end;
    wsAcct : DisplayMessage(1,'정산 중에는 보류를 할 수 없습니다.');
  end;
end;

procedure TOrder_F.Action16Execute(Sender: TObject);
begin
  Common.Device.BefCustomerOrderPrint;
  Common.KitchenDataCopy(1);
  Common.Device.OrderPrint(false, true);
  Common.ClearKitchenData;
end;

procedure TOrder_F.Action17Execute(Sender: TObject);
begin
  try
    Common.ShowMemberAddForm;
  finally
    Common.Device.OnScannerReadData := ScannerReadEvent;
  end;
end;

procedure TOrder_F.Action18Execute(Sender: TObject);
begin
  if GetUserOption(7) = '0' then
  begin
    if GetOption(172) = '0' then
    begin
      Common.ErrBox('사용권한이 없습니다');
      Exit;
    end
    else if not Common.CheckAuthority(7) then Exit;
    Common.Device.CashBoxOpen;
  end
  else Common.Device.CashBoxOpen;
end;

procedure TOrder_F.SetReceiptPrintMode(AValue:TPrintMode);
begin
  FReceiptPrintMode    := AValue;
  Common.RealPrintMode := AValue;

  if GetOption(8) = '1' then
    ReceiptPrintGroupBox.Enabled := false
  else
  begin
    if FReceiptPrintMode = pmPrint then
    begin
      ReceiptPrintYesButton.Status.Caption := 'V';
      ReceiptPrintNoButton.Status.Caption  := '';
      ReceiptPrintButton.Picture := ReceiptPrintOnButton.Picture
    end
    else
    begin
      ReceiptPrintYesButton.Status.Caption := '';
      ReceiptPrintNoButton.Status.Caption  := 'V';
      ReceiptPrintButton.Picture := ReceiptPrintButton.PictureDisabled;
    end;
  end;
end;

procedure TOrder_F.SetBillPrintMode(AValue:Boolean);
begin
  FBillPrintMode := AValue;
  if FBillPrintMode then
  begin
    BillPrintYesButton.Status.Caption := 'V';
    BillPrintNoButton.Status.Caption  := '';
    BillPrintButton.Picture := BillPrintOnButton.Picture
  end
  else
  begin
    BillPrintYesButton.Status.Caption := '';
    BillPrintNoButton.Status.Caption  := 'V';
    BillPrintButton.Picture := BillPrintButton.PictureDisabled;
  end;
end;

procedure TOrder_F.SetMenuPrintMode(AValue:Boolean);
begin
  FMenuPrintMode := AValue;
  Common.MenuPrintMode := AValue;

  if FMenuPrintMode then
  begin
    MenuPrintYesButton.Status.Caption := 'V';
    MenuPrintNoButton.Status.Caption  := '';
    MenuPrintButton.Picture := MenuPrintOnButton.Picture
  end
  else
  begin
    MenuPrintYesButton.Status.Caption := '';
    MenuPrintNoButton.Status.Caption  := 'V';
    MenuPrintButton.Picture := MenuPrintButton.PictureDisabled;
  end;
end;

procedure TOrder_F.SetKitchenPrintMode(AValue: Boolean);
begin
  FKitchenPrintMode := AValue;

  if FKitchenPrintMode then
  begin
    KitchenReceiptOnButton.Status.Caption := 'V';
    KitchenReceiptOffButton.Status.Caption  := '';
    KitchenPrintButton.Picture := KitchenPrintOnButton.Picture
  end
  else
  begin
    KitchenReceiptOnButton.Status.Caption := '';
    KitchenReceiptOffButton.Status.Caption  := 'V';
    KitchenPrintButton.Picture := KitchenPrintButton.PictureDisabled;
  end;
end;

procedure TOrder_F.SetCardPrintMode(AValue: Boolean);
begin
  FCardPrintMode := AValue;

  if FCardPrintMode then
  begin
    CardPrintAtOnceYesButton.Status.Caption := 'V';
    CardPrintAtOnceNoButton.Status.Caption  := '';
    Common.CardPrintMode := cpmatOnce;
  end
  else
  begin
    CardPrintAtOnceYesButton.Status.Caption := '';
    CardPrintAtOnceNoButton.Status.Caption  := 'V';
    Common.CardPrintMode := cpmatAcct;
  end;
end;

procedure TOrder_F.SetSplitPrintMode(AValue: Boolean);
begin
  FSplitPrintMode := AValue;

  if FSplitPrintMode then
  begin
    CardPrintSplitOffButton.Status.Caption := 'V';
    CardPrintSplitOnButton.Status.Caption  := '';
    Common.SplitPrintMode := spmOnePage;
  end
  else
  begin
    CardPrintSplitOffButton.Status.Caption := '';
    CardPrintSplitOnButton.Status.Caption  := 'V';
    Common.SplitPrintMode := spmSplit;
  end;
end;

procedure TOrder_F.SetPluClassData;
var vPluClassData : ^TPluClassData;
    vPageCount, vMod    : Integer;
begin
  if Common.Config.IsKiosk then
  begin
    DM.OpenQuery('select Max(NO_POSITION) '
                +'  from MS_KIOSK_LARGE '
                +' where CD_STORE	=:P0 '
                +'	 and CD_GUBUN	=:P1 ',
                [Common.Config.StoreCode,
                 GetKioskPLU]);
    if not DM.Query.Eof then
    begin
      KioskClassTotalPage := DM.Query.Fields[0].AsInteger div KioskClassCount;
      if DM.Query.Fields[0].AsInteger mod KioskClassCount > 0 then
        KioskClassTotalPage := KioskClassTotalPage + 1;
      KioskClassPage := 1;
      DM.Query.Close;
    end;
    KioskPage := 1;
  end
  else if Common.Config.PluClassX > 0 then
  begin
    PluClassData.Clear;
    DM.OpenQuery('select * '
                +'  from MS_LARGE  '
                +' where CD_STORE =:P0 '
                +'   and CD_GUBUN =:P1 '
                +' order by NO_POSITION ',
                [Common.Config.StoreCode,
                 Common.Config.PluNo]);
    while not DM.Query.Eof do
    begin
      New(vPluClassData);
      vPluClassData^.ClassCode     := DM.Query.FieldByName('CD_LARGE').AsString;
      vPluClassData^.ClassName     := Common.GetPaPago(DM.Query.FieldByName('NM_LARGE').AsString);
      vPluClassData^.Position      := DM.Query.FieldByName('NO_POSITION').AsInteger-1;
      if DM.Query.FieldByName('COLOR').AsString = '' then
        vPluClassData^.Color := Common.Config.PluClassColor
      else
        vPluClassData^.Color         := StringToColor(DM.Query.FieldByName('COLOR').AsString);
      PluClassData.Add(vPluClassData);
      DM.Query.Next;
    end;
    DM.Query.Close;
    PluClassMaxPage := 1;
    if PluClassData.Count > 0 then
    begin
      //분류가 한페이지 일때
      if TPluClassData(PluClassData[PluClassData.Count-1]^).Position+1 <= (Common.Config.PluClassX * Common.Config.PluClassY) then
        PluClassMaxPage := 1
      else
      begin
        PluClassMaxPage := (TPluClassData(PluClassData[PluClassData.Count-1]^).Position) div ((Common.Config.PluClassX * Common.Config.PluClassY)-1);
        vMod            := (TPluClassData(PluClassData[PluClassData.Count-1]^).Position) mod ((Common.Config.PluClassX * Common.Config.PluClassY)-1);
        if PluClassMaxPage = 0 then
          PluClassMaxPage := 1
        else
        begin
          if (TPluClassData(PluClassData[PluClassData.Count-1]^).Position+1) <> (Common.Config.PluClassX * Common.Config.PluClassY) then
            if (vMod > 0) or ((TPluClassData(PluClassData[PluClassData.Count-1]^).Position+1) mod ((Common.Config.PluClassX * Common.Config.PluClassY)-1) > 0) then
              PluClassMaxPage := PluClassMaxPage + 1;
        end;
      end;
    end;
    if Common.Config.AllClassPLU then
    begin
      PluMenuPanel.Visible := false;
      BackButton.Visible   := false;
    end;
  end;
end;

procedure TOrder_F.SetPluMenuData(aClassCode: String);
var vPluMenuData : ^TPluMenuData;
    vButtonIndex :Integer;
begin
  if not KioskOrderMenuPanel.Visible then Exit;

  PluMenuData.Clear;
  DM.OpenQuery('select a.NO_POSITION, '
              +'		    a.CD_MENU, '
              +'		    a.NM_VIEW, '
              +Ifthen(GetOption(194)='1','GetSalePrice(b.CD_STORE, b.CD_MENU) as PR_SALE, ', 'ifnull(b.PR_SALE,0) as PR_SALE, ')
              +'			  a.COLOR, '
              +'        b.DS_MENU_TYPE, '
              +'        b.NO_MENU, '
              +'        b.CONFIG, '
              +'        case when b.QTY_SELECT = 0 then 1 else b.QTY_SELECT end as QTY_SELECT '
              +'	 from MS_SMALL a  inner join '
              +'	 		  MS_MENU  b  on b.CD_STORE = a.CD_STORE '
              +'                   and b.CD_MENU  = a.CD_MENU '
              +'	where a.CD_STORE =:P0 '
              +'	  and a.CD_GUBUN =:P1 '
              +'	  and a.CD_LARGE =:P2 '
              +Ifthen(Common.Table.Packing = 'Y', ' and SubString(b.CONFIG,10,1) <> ''Y'' ',' and SubString(b.CONFIG,10,1) <> ''S'' ')
              +'	order by a.NO_POSITION ',
              [Common.Config.StoreCode,
               Common.Config.PluNo,
               aClassCode]);
  while not DM.Query.Eof do
  begin
    New(vPluMenuData);
    vPluMenuData^.ClassCode := aClassCode;
    vPluMenuData^.MenuCode  := DM.Query.FieldByName('CD_MENU').AsString;
    vPluMenuData^.MenuName  := Common.GetPaPago(DM.Query.FieldByName('NM_VIEW').AsString);
    vPluMenuData^.SalePrice := DM.Query.FieldByName('PR_SALE').AsInteger;
    vPluMenuData^.MenuType  := DM.Query.FieldByName('DS_MENU_TYPE').AsString;
    vPluMenuData^.Position  := DM.Query.FieldByName('NO_POSITION').AsInteger-1;
    vPluMenuData^.MenuNo    := DM.Query.FieldByName('NO_MENU').AsString;
    vPluMenuData^.SoldOut    := Copy(DM.Query.FieldByName('CONFIG').AsString,8,1) = 'Y';
    vPluMenuData^.SelectQty  := DM.Query.FieldByName('QTY_SELECT').AsInteger;

    if DM.Query.FieldByName('COLOR').AsString = '' then
      vPluMenuData^.Color := Common.Config.PluMenuColor
    else
      vPluMenuData^.Color     := StringToColor(DM.Query.FieldByName('COLOR').AsString);
    PluMenuData.Add(vPluMenuData);
    DM.Query.Next;
  end;
  DM.Query.Close;
  PluMenuPage    := 1;
  PluMenuMaxPage := 0;
  if PluMenuData.Count > 0 then
  begin
    PluMenuMaxPage := (TPluMenuData(PluMenuData[PluMenuData.Count-1]^).Position+1) div ((Common.Config.PluMenuX * Common.Config.PluMenuY)-1);
    if (TPluMenuData(PluMenuData[PluMenuData.Count-1]^).Position+1) mod ((Common.Config.PluMenuX * Common.Config.PluMenuY)-1) > 0 then
      PluMenuMaxPage := PluMenuMaxPage + 1;
  end;

  if PluMenuData.Count = 0 then
  begin
    for vButtonIndex := Low(PluMenuButton) to High(PluMenuButton) do
    begin
      PluMenuButton[vButtonIndex].Caption  := EmptyStr;
      PluMenuButton[vButtonIndex].Number.NumberString := EmptyStr;
      PluMenuButton[vButtonIndex].Number.RightString  := EmptyStr;
      PluMenuButton[vButtonIndex].Temp1    := EmptyStr;
      PluMenuButton[vButtonIndex].Temp2    := EmptyStr;
      PluMenuButton[vButtonIndex].Temp3    := EmptyStr;
      PluMenuButton[vButtonIndex].Temp4    := EmptyStr;
      PluMenuButton[vButtonIndex].Color    := Common.Config.PluMenuColor;
      PluMenuButton[vButtonIndex].Bottom.RightString := EmptyStr;
      PluMenuButton[vButtonIndex].Width    := StrToInt(PluMenuButton[vButtonIndex].Temp6);
      PluMenuButton[vButtonIndex].Height   := StrToInt(PluMenuButton[vButtonIndex].Temp7);
      PluMenuButton[vButtonIndex].Temp9    := EmptyStr;   //버튼 합쳤다는 Flag
      PluMenuButton[vButtonIndex].Visible  := false;//Common.Config.PluMenuEmptyShow;
      PluMenuButton[vButtonIndex].BorderColor := Common.Config.PluMenuBorderColor;
      PluMenuButton[vButtonIndex].BorderStyle := pbsSingle;
      PluMenuButton[vButtonIndex].BorderInnerColor := clNone;
      PluMenuButton[vButtonIndex].Font.Style := PluMenuButton[vButtonIndex].Font.Style - [fsItalic,fsStrikeOut];
      PluMenuButton[vButtonIndex].BringToFront
    end;
    TPosButton(FindComponent('PluMenuPrevButton')).Visible := false;
    TPosButton(FindComponent('PLUMenuNextButton')).Visible := false;
    Exit;
  end;

  TPosButton(FindComponent('PluMenuPrevButton')).Visible := not Common.Config.PluMenuEmptyShow or (PluMenuMaxPage > 1);
  TPosButton(FindComponent('PLUMenuNextButton')).Visible := not Common.Config.PluMenuEmptyShow or (PluMenuMaxPage > 1);
  TPosButton(FindComponent('PLUMenuNextButton')).Enabled := PluMenuMaxPage > 1;
  ShowPluMenuButton;
end;

function TOrder_F.GetHoldCount: Integer;
begin
  if not Common.Config.IsTakeOut then
  begin
    if Common.PosType = ptAccount then
      PosNoLabel.Caption := Format('%s - %s',[Common.Config.PosNo,Common.PreSent.RcpNo]);
    Exit;
  end;
  //보류건수 count
  OpenQuery('select Count(*) cnt '
           +'  from SL_HOLD_H  '
           +' where CD_STORE   =:P0 '
           +Ifthen(GetOption(403)='0',' and NO_POS   =:P1 ','')
           +'   and YN_RESTORE =''N'' ',
           [Common.Config.StoreCode,
            Common.Config.PosNo]);
  Result := Common.Query.FieldbyName('Cnt').AsInteger;
  if Result > 0 then
    OrderTableLabel.Caption := Format('보류 - %d',[Result]);
  Common.Query.Close;
end;

procedure TOrder_F.SetNoTransCount;
begin
  //보류건수 count
  OpenQuery('select Count(*) '
           +'  from MS_UPLOAD  '
           +' where CD_STORE   =:P0 ',
           [Common.Config.StoreCode]);
  NoTransLabel.Caption := FormatFloat(',0건', Common.Query.Fields[0].AsInteger-Ifthen(Common.Table.Number > 0,1,0));
  Common.Query.Close;
end;

function TOrder_F.SelfCashRcp(aSaleAmt:Integer):Boolean;
begin
  Result := False;
  try
    if GetOption(379)='1' then
      Common.Device.SetPrintPort(false);
    with Common.ICCard, Common do
    begin
      FocusHandle := Self.Handle;
      ClearAll;
      case Config.van_trd of
         0 : VAN    := vtKOCES;
         1 : VAN    := vtDaou;
         2 : VAN    := vtNICE;
         3 : VAN    := vtKICC;
         4 : VAN    := vtKIS;
         5 : VAN    := vtKSNET;
         6 : VAN    := vtKCP;
         7 : VAN    := vtFDIK;
         8 : VAN    := vtJTNET;
         9 : VAN    := vtKFTC;
        10 : VAN    := vtSmartro;
        11 : VAN    := vtKOVAN;
        12 : VAN    := vtSPC;
      end;
      WorkDate   := Common.WorkDate;
      SaleDate   := FormatDateTime('yyyymmdd',Now());
      BizNo      := Common.Config.BizNo;
      TerminalID := Config.van_Terid;
      SerialNo   := Config.SerialNo;
      PosNo      := Config.PosNo;
      HalbuMonth := 0;
      KeyIn      := True;
      Common.CashRcp.CardNoFull := '0100001234';
      CardTrack2 := '0100001234';
      Approval   := true;
      CashRcp.Ds_Kind := '2';
      SaleAmt    := aSaleAmt;
      RealMode   := TerminalID <> 'cardtest';
      LogPath    := Common.AppPath;
      CatPort    := StoI(Common.Config.ReceiptPrinterPort);
      OrgAgreeNo    := '';
      OrgSaleDate   := '';

      if GetOption(379)='2' then
        AppType    := atVCatCash
      else if GetOption(379)='1' then
        AppType    := atCatCash
      else 
        AppType    := atCash;

      if not Execute then
      begin
        ErrMsg := Note;
        Result := False;
        Exit;
      end
      else
      begin
        CashRcp.CardNo        := '0100001234';
        CashRcp.No_Approval   := AgreeNo;        // 승인번호
        CashRcp.Amt_Approval  := AgreeAmt;       // 승인금액
        CashRcp.trd_date      := SaleDate;
        if (Common.PreSent.WRcvAmt > 0) then
        begin
          PreSent.CashRcpAmt := PreSent.CashRcpAmt + CashRcp.Amt_Approval;
          PreSent.CashAmt    := PreSent.CashAmt    + CashRcp.Amt_Approval;
        end;
        CashRcpInfoSave;
        DisplayPresent;
        Result := True;
      end;
    end;
  finally
    if GetOption(379)='1' then
      Common.Device.SetPrintPort(true);
  end;
end;

procedure TOrder_F.SetCodeDc;
begin
  if Trim(Common.PreSent.CodeDcCode) <> '' then
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
             +'   and CD_CODE  =:P1',
             [Common.Config.StoreCode,
              Common.PreSent.CodeDcCode ]);

    if not Common.Query.Eof then
    begin
      Common.PreSent.CodeDcName   := Common.Query.FieldByName('NM_CODE1').AsString;
      Common.PreSent.CodeDcType   := Common.Query.FieldByName('NM_CODE2').AsString;
      Common.PreSent.CodeDcRate   := Common.Query.FieldByName('NM_CODE3').AsCurrency;
      Common.PreSent.CodeDcStdAmt := Common.Query.FieldByName('NM_CODE4').AsInteger;
      Common.PreSent.CodeDcAmt    := Common.Query.FieldByName('NM_CODE5').AsInteger;
      Common.PreSent.CodeDcClass  := Common.Query.FieldByName('NM_CODE6').AsString;
    end;
    Common.Query.Close;
  end;
end;

procedure TOrder_F.GetItemMenu(aValue:String);
var I, Index :Integer;
    vList :TStringList;
    vQuery :TUniQuery;
begin
  vList := TStringList.Create;
  Split(aValue, '|', vList);
  Common.Menu.cd_item := EmptyStr;
  Common.Menu.nm_item := EmptyStr;
  Index := 1;
  try
    vQuery := TUniQuery.Create(Application);
    vQuery.Connection := DM.UniConnection;
    for Index := 0 to vList.Count-1 do
    begin
      if vList.Strings[Index] = '' then Continue;

      vQuery.Close;
      vQuery.SQL.Text := 'select NM_MENU_SHORT, '
                        +'       NM_MENU_KITCHEN, '
                        +Ifthen(GetOption(194)='1','GetSalePrice(CD_STORE, CD_MENU) as PR_SALE ', 'PR_SALE ')
                        +'  from MS_MENU '
                        +' where CD_STORE =:P0 '
                        +'   and CD_MENU  =:P1';
      vQuery.ParamByName('P0').AsString := Common.Config.StoreCode;
      vQuery.ParamByName('P1').AsString := Copy(vList.Strings[Index],1,Pos(',',vList.Strings[Index])-1);
      vQuery.Open;
      if not vQuery.Eof then
      begin
        ItemData[Index+1].Code  := Copy(vList.Strings[Index],1,Pos(',',vList.Strings[Index])-1);
        ItemData[Index+1].Name  := vQuery.FieldByName('nm_menu_short').AsString;
        ItemData[Index+1].PrintMenuName  := vQuery.FieldByName('NM_MENU_KITCHEN').AsString;
        ItemData[Index+1].Price := vQuery.FieldByName('pr_sale').AsInteger;
        ItemData[Index+1].Qty   := StrToInt(RightStr(vList.Strings[Index], Length(vList.Strings[Index]) - Pos(',',vList.Strings[Index])));
        Common.Menu.cd_item     := Common.Menu.cd_item + Format('%s,%d|',[ItemData[Index+1].Code, ItemData[Index+1].Qty]);
        if ItemData[Index+1].Qty > 1 then
        begin
          if vQuery.FieldByName('pr_sale').AsInteger = 0 then
            Common.Menu.nm_item     := Common.Menu.nm_item + Format(' -%s %d개'+#13,[ItemData[Index+1].Name, ItemData[Index+1].Qty*Common.Menu.qty_sale])
          else
            Common.Menu.nm_item     := Common.Menu.nm_item + Format(' -%s %d개 (%s)'+#13,[ItemData[Index+1].Name, ItemData[Index+1].Qty*Common.Menu.qty_sale, FormatFloat(',0원',ItemData[Index+1].Price)]);
        end
        else
        begin
          if vQuery.FieldByName('pr_sale').AsInteger = 0 then
            Common.Menu.nm_item     := Common.Menu.nm_item + Format(' -%s'+#13,[ItemData[Index+1].Name])
          else
            Common.Menu.nm_item     := Common.Menu.nm_item + Format(' -%s (%s)'+#13,[ItemData[Index+1].Name, FormatFloat(',0원',ItemData[Index+1].Price)]);
        end;
      end;
    end;
  finally
    vQuery.Close;
    vQuery.Free;
  end;
end;

procedure TOrder_F.ScannerReadEvent(const S: String);
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
var vNumData :String;
begin
   //마감 상태였으면 초기화한다
  if WorkState = wsMagam then WorkState := wsReady;

  if Common.Config.IsKiosk and (KioskWaitPanel.Left = 0) then
    KioskBeginImageClick(nil);

  FMenuCode := S;
  try
    if S <> Common.Device.NFCData then
      vNumData  := GetCardNo(S)
    else
      vNumData  := S;
    //회원프리픽스하고 같으면
    if Common.isMemberCardNo(vNumData) or (Common.Device.NFCData = vNumData) then
    begin
      Common.Device.NFCData := '';
      Common.SelectMemberInfo('',vNumData,'');
      if Common.Member.Code = EmptyStr then
      begin
        Common.ErrBox(FMsrData +#13#13+'등록되지 않은 회원카드입니다');
      end
      else
      begin
        if not Common.Config.IsKiosk then
        begin
          if WorkState = wsReady then WorkState := wsSale;
          //테이블 담당자가 지정되어 있지 않을때는 회원의 담당자로 지정한다
          if (Common.Table.DamdangCode = EmptyStr) and (Common.Member.DamdangCode <> EmptyStr) then
          begin
            Common.Table.DamdangCode := Common.Member.DamdangCode;
            Common.Table.DamdangName := Common.Member.DamdangName;
            lbl_Damdang.Caption      := '['+Common.Table.DamdangName+']';
          end;

          //회원기본메뉴
          if (Common.Config.MemberDefaultMenu <> '') and not GetMenuOrderCheck(Common.Config.MemberDefaultMenu) then
          begin
            FMenuCode := Common.Config.MemberDefaultMenu;
            SelectMenu(0);
          end;
          WorkState := wsSale;
          DisplayPresent;
          //회원조회 후 자동 외상결제
          if (GetOption(317) = '1') and (Common.Member.Yn_trust = 'Y') then
          begin
            Act_Trust.Execute;
            if not Common.Config.IsTakeOut and not Common.Config.IsKiosk then
            begin
              if Common.PreSent.WRcvAmt = 0 then
              begin
                Tmr_Acct.Tag     := 1;
                Tmr_Acct.Enabled := true;
              end;
            end
          end;
        end
        else
        begin
          if (Common.Member.Name <> '') then
            if not Common.AskBox(Format('%s 고객님이 맞습니까?'+#13#13+'이용금액 %s 원',[Common.Member.Name, FormatFloat(',0',Common.Member.CreditAmt) ])) then Exit;

          if (Common.Config.MemberDefaultMenu <> '') and not GetMenuOrderCheck(Common.Config.MemberDefaultMenu) then
          begin
            FMenuCode := Common.Config.MemberDefaultMenu;
            SelectMenu(0);
            OrderListView;
          end;
          if KioskTrustButton.Visible then
          begin
            KioskTrustButton.Status.Caption := Common.Member.Name;
            KioskTrustButton.Status.Visible := true;
          end;

          if KioskPointSearchButton.Visible then
          begin
            KioskPointSearchButton.Status.Caption := Common.Member.Name;
            KioskPointSearchButton.Status.Visible := true;
          end;

          WorkState := wsSale;
          DisplayPresent;
          //회원조회 후 자동 외상결제
          if (GetOption(317) = '1') and (Common.Member.Yn_trust = 'Y') then
          begin
            KioskTrustButtonClick(nil);
          end;

        end;
      end;
    end
    //저울메뉴이면
    else if (Length(FMenuCode) = 13) or (Length(FMenuCode) = 16) or (Length(FMenuCode) = 18) then
    begin
      if LeftStr(FMenuCode,2) = Common.Config.ScalePrefix then SelectMenu(1)
      else                                                     SelectMenu(0);
    end
    else if (Length(Common.Config.CouponPrefix)=2) and  (LeftStr(FMenuCode,2) = Common.Config.CouponPrefix) and (Length(FMenuCode) = 13) then
    begin
      Action30.Execute;
    end
    else SelectMenu(0);

    if Common.Config.IsKiosk then
      OrderListView;
  finally
    FMenuCode := '';
  end;
end;

procedure TOrder_F.Action19Execute(Sender: TObject);
  function GetSummaryGridRow: Integer;
  var vRow:Integer;
  begin
    Result := -1;
     with Main_sGrd, Common.Menu do
     begin
       For vRow := 0 to Common.Summary_sGrd.RowCount - 1 do
       begin
         if (Cells[GDM_CD_MENU, Row] = Common.Summary_sGrd.Cells[GDM_CD_MENU, vRow])
           and (Cells[GDM_DS_SALE, Row] = Common.Summary_sGrd.Cells[GDM_DS_SALE, vRow])
           and (Cells[GDM_PR_SALE, Row] = Common.Summary_sGrd.Cells[GDM_PR_SALE, vRow])
           and ('N' = Common.Summary_sGrd.Cells[GDM_YN_DOUBLE, vRow])
           and (Common.Summary_sGrd.Cells[GDM_CD_MENU1, vRow] = '')
           then
         begin
            Result := vRow;
            Break;
         end;
       end;
     end;
  end;

  function GetSummaryGridRow1: Integer;
  var vRow:Integer;
  begin
    Result := -1;
     with Main_sGrd do
     begin
       For vRow := 0 to Common.Summary_sGrd.RowCount - 1 do
       begin
         if (Cells[GDM_CD_MENU, Row] = Common.Summary_sGrd.Cells[GDM_CD_MENU, vRow])
           and (Cells[GDM_DS_SALE, Row] = Common.Summary_sGrd.Cells[GDM_DS_SALE, vRow])
           and (Cells[GDM_PR_SALE, Row] = Common.Summary_sGrd.Cells[GDM_PR_SALE, vRow])
           and ('Y' = Common.Summary_sGrd.Cells[GDM_YN_DOUBLE, vRow])
           and (Common.Summary_sGrd.Cells[GDM_CD_MENU1, vRow] = '')
           then
         begin
              Result := vRow;
              Break;
         end;
       end;
     end;
  end;

var liSRow, vIndex, Dcpr, vPrice, vBefRow :Integer;
    lsOrgDsOrder, lsDsMenu :String;
    vApply, vApply1 :Boolean;   //vApply :서비스를 정상으로 변경 적용여부 , vApply1 :정상을 서비스를 변경 적용여부
begin
  if Main_sGrd.Cells[0, 0] = '' then Exit;
  if Main_sGrd.Cells[GDM_YN_ORDER, Main_sGrd.Row] = 'Y' then
  begin
    Common.ErrBox('주문이 완료된 메뉴는 할 수 없습니다');
    Exit;
  end;

  with Main_sGrd do
  begin
    if StoI(Cells[GDM_PR_SALE_DB, Row]) = 0 then
    begin
      Common.ErrBox('곱빼기 금액이 입력되어 있지 않습니다');
      Exit;
    end;

    if Cells[GDM_DS_SALE, Row] = 'B' then
    begin
      Common.ErrBox('반품메뉴는 사용할 수 없습니다');
      Exit;
    end;

    if (StoI(Cells[GDM_NO_STEP, Row]) > 0) then
    begin
      Common.ErrBox('부메뉴에는 사용할 수 없습니다');
      Exit;
    end;

    if Cells[GDM_DS_SALE, Row] = 'D' then
    begin
      Common.ErrBox('서비스 메뉴에는 사용할 수 없습니다');
      Exit;
    end;

    if Cells[GDM_DS_SALE, Row] = 'P' then
    begin
      Common.ErrBox('포장 메뉴에는 사용할 수 없습니다');
      Exit;
    end;
//////////////////////////////////

    vApply  := False;
    vApply1 := False;
    vBefRow := -1;

    lsOrgDsOrder := Cells[GDM_DS_SALE, Row];
    lsDsMenu     := Cells[GDM_DS_MENU, Row];

    //곱빼기를 정상으로 바꿀때
    if Cells[GDM_YN_DOUBLE, Row] = 'Y' then
    begin
      liSRow := GetSummaryGridRow1;
      if Common.OrderKind <> okChange then
      begin
        if (StoI(Common.Summary_sGrd.Cells[GDM_QTY, liSRow]) - StoI(Cells[GDM_QTY, Row])) > 0 then
        begin
          //곱빼상태의 수량을 하나 뺀다
          AmtReCompute(-StoI(Cells[GDM_QTY, Row]), liSRow);
          vApply1 := True;
        end;
        //집계그리드에서 현재 정상 상품의 Row 인덱스를 구한다
        vBefRow := GetSummaryGridRow;
        //정상상태의 메뉴가 존재하면
        if vBefRow > -1 then
        begin
          //정상 메뉴의 수량을 하나 추가
          AmtReCompute(StoI(Cells[GDM_QTY, Row]), vBefRow);
          //서비스 메뉴의 수량을 하나 뺀다
          AmtReCompute(-StoI(Cells[GDM_QTY, Row]), liSRow);

          if Common.Summary_sGrd.Cells[GDM_QTY, liSRow] = '0' then Common.DeleteRow(Common.Summary_sGrd, liSRow);
          vApply1 := True;
        end
        else
        begin
          //집계그리드에 메뉴가 없으면 Row를 하나 추가한다
          Common.Summary_sGrd.RowCount := Common.Summary_sGrd.RowCount + 1;
          Common.Summary_sGrd.Rows[Common.Summary_sGrd.RowCount-1].Assign( Common.Summary_sGrd.Rows[liSRow]);
          Common.Summary_sGrd.Cells[GDM_QTY, Common.Summary_sGrd.RowCount-1]     := Cells[GDM_QTY, Row];
          Common.Summary_sGrd.Cells[GDM_PR_SALE,   Common.Summary_sGrd.RowCount-1] := Cells[GDM_PR_SALE_ORG, Row];
          Common.Summary_sGrd.Cells[GDM_VIEWPRICE, Common.Summary_sGrd.RowCount-1] := Cells[GDM_PR_SALE_ORG, Row];
          Common.Summary_sGrd.Cells[GDM_AMT, Common.Summary_sGrd.RowCount-1]       := '0';
          Common.Summary_sGrd.Cells[GDM_YN_DOUBLE, Common.Summary_sGrd.RowCount-1] := 'N';
          Common.PreSent.SpcDc   := Common.PreSent.SpcDc + StoI(Common.Summary_sGrd.Cells[GDM_DC_SPC,Common.Summary_sGrd.RowCount-1]) * StoI(Cells[GDM_QTY, Row]);

          AmtReCompute(-StoI(Cells[GDM_QTY, Row]), liSRow);
          if Common.Summary_sGrd.Cells[GDM_QTY, liSRow] = '0' then
            Common.DeleteRow(Common.Summary_sGrd, liSRow);
          vApply1 := True;
        end;
      end;

      Cells[GDM_YN_DOUBLE, Row] := 'N';
      vPrice := StoI(Cells[GDM_PR_SALE_ORG, Row]);
    end
    else
    //정상을 곱빼기로 바꿀때
    begin
      liSRow := GetSummaryGridRow;
      if (StoI(Common.Summary_sGrd.Cells[GDM_QTY, liSRow]) - StoI(Cells[GDM_QTY, Row])) > 0 then
      begin
        //서비스메뉴를 찾는다
        vBefRow := GetSummaryGridRow1;

        if vBefRow > -1 then
        begin
          Common.Summary_sGrd.Cells[GDM_QTY, vBefRow] := IntToStr(StoI(Common.Summary_sGrd.Cells[GDM_QTY, vBefRow]) + StoI(Cells[GDM_QTY, Row]));
        end
        else
        begin
          Common.Summary_sGrd.RowCount := Common.Summary_sGrd.RowCount + 1;
          Common.Summary_sGrd.Rows[Common.Summary_sGrd.RowCount-1].Assign( Common.Summary_sGrd.Rows[liSRow]);
          Common.Summary_sGrd.Cells[GDM_QTY,       Common.Summary_sGrd.RowCount-1] := Cells[GDM_QTY, Row];
          Common.Summary_sGrd.Cells[GDM_PR_SALE,   Common.Summary_sGrd.RowCount-1] := Cells[GDM_PR_SALE_DB, Row];
          Common.Summary_sGrd.Cells[GDM_VIEWPRICE, Common.Summary_sGrd.RowCount-1] := Cells[GDM_PR_SALE_DB, Row];
         if Common.Summary_sGrd.Cells[GDM_DS_MENU, Common.Summary_sGrd.RowCount-1] = 'W' then
           Common.Summary_sGrd.Cells[GDM_AMT,       Common.Summary_sGrd.RowCount-1] := Cells[GDM_PR_SALE_DB, Row]
         else
           Common.Summary_sGrd.Cells[GDM_AMT,       Common.Summary_sGrd.RowCount-1] := IntToStr( StoI(Cells[GDM_QTY, Row]) * StoI(Cells[GDM_PR_SALE_DB, Row]) );
          Common.Summary_sGrd.Cells[GDM_YN_DOUBLE, Common.Summary_sGrd.RowCount-1] := 'Y';
        end;
        AmtReCompute(-StoI(Cells[GDM_QTY, Row]), liSRow);
        if Common.Summary_sGrd.Cells[GDM_QTY, liSRow] = '0' then
          Common.DeleteRow(Common.Summary_sGrd, liSRow);
        vApply := True;
      end
      else
      begin
        Common.Summary_sGrd.Cells[GDM_YN_DOUBLE, liSRow]  := 'Y';
        Common.Summary_sGrd.Cells[GDM_PR_SALE,   liSRow]  := Cells[GDM_PR_SALE_DB, Row];
        Common.Summary_sGrd.Cells[GDM_VIEWPRICE,   liSRow] := Cells[GDM_PR_SALE_DB, Row];
      end;


      Cells[GDM_YN_DOUBLE, Row] := 'Y';
      vPrice := StoI(Cells[GDM_PR_SALE_DB, Row]);
    end;

    Cells[GDM_PR_SALE, Row]   := IntToStr(vPrice);
    Cells[GDM_VIEWPRICE, Row] := IntToStr(vPrice);

    if Cells[GDM_DS_MENU, Row] = 'W' then
      Cells[GDM_AMT, Row]       := IntToStr(vPrice)
    else
      Cells[GDM_AMT, Row]       := IntToStr(vPrice * StoI(Cells[GDM_QTY, Row]) );

    Cells[GDM_CHANGE, Row] := 'Y';

    //곱빼기를 정상, 정상을 곱빼기로 둘다 적용을 안했을때
    if (not vApply) and (not vApply1) then
    begin
      Common.Summary_sGrd.Cells[GDM_PR_SALE, liSRow]   := Cells[GDM_PR_SALE, Row];
      Common.Summary_sGrd.Cells[GDM_DS_SALE, liSRow]   := Cells[GDM_DS_SALE, Row];

      if Common.Summary_sGrd.Cells[GDM_DS_MENU, liSRow] = 'W' then
      begin
        Dcpr := StoI(Common.Summary_sGrd.Cells[GDM_AMT, liSRow]) + vPrice;
        Common.Summary_sGrd.Cells[GDM_AMT, liSRow] := IntToStr(vPrice);
      end
      else
      begin
        Dcpr := StoI(Common.Summary_sGrd.Cells[GDM_AMT, liSRow]) - (vPrice *  StoI(Common.Summary_sGrd.Cells[GDM_QTY, liSRow]) );
        Common.Summary_sGrd.Cells[GDM_AMT, liSRow] := IntToStr(vPrice *  StoI(Common.Summary_sGrd.Cells[GDM_QTY, liSRow]));
      end;
    end
    else
    begin
      if Common.Summary_sGrd.Cells[GDM_DS_MENU, liSRow] = 'W' then
        Dcpr := vPrice
      else
        Dcpr := vPrice *  StoI(Cells[GDM_QTY, Row]) ;
    end;

    //변경 후 상태
    if Cells[GDM_YN_DOUBLE, Row] = 'Y' then
    begin
      if not vApply then
        Common.Present.TotalAmt := Common.Present.TotalAmt + ABS(FtoI(Dcpr));

      Cells[GDM_NM_MENU, Row] := Cells[GDM_NM_MENU_ORG, Row]+'(곱빼기)'+ Cells[GDM_MEMO, Row];
      Common.Summary_sGrd.Cells[GDM_NM_MENU, liSRow] := Cells[GDM_NM_MENU_ORG, Row]+'(곱빼기)';
    end
    else
    begin
      if not vApply then
        Common.Present.TotalAmt := Common.Present.TotalAmt - ABS(FtoI(Dcpr));

      Cells[GDM_NM_MENU, Row] := Cells[GDM_NM_MENU_ORG, Row] + Cells[GDM_MEMO, Row];
      Common.Summary_sGrd.Cells[GDM_NM_MENU, liSRow] := Cells[GDM_NM_MENU_ORG, Row];
    end;
  end;
  DisplayPresent;
end;

procedure TOrder_F.Action20Execute(Sender: TObject);
var vOrgOrderKind : TOrderKind;
    vTemp :String;
begin
  if not Common.Config.IsTakeOut then
  begin
    Common.ErrBox('선불제에서만 사용이 가능합니다');
    Exit;
  end;

  if Common.WorkState <> wsReady then
  begin
    Common.ErrBox('현재작업을 완료 후에 다시 시도하세요');
    Exit;
  end;

  if not Common.Config.IsKiosk and (Common.Config.RcpSearchPwd <> '') then
  begin
    vTemp := Common.ShowNumberForm('패스워드를 입력하세요', 16);
    if vTemp = 'mrClose' then Exit;
    if (Common.Config.RcpSearchPwd <> vTemp) then

    Common.ErrBox('패스워드가 올바르지 않습니다');
    Exit;
  end;
  ModalResult := mrAbort;
end;

procedure TOrder_F.Action21Execute(Sender: TObject);
var vInData :String;
begin
  if GetOption(160) = '1' then
  begin
    Common.ErrBox('메뉴단가에 봉사료를 포함해서 사용할때는'+#13#13+'사용할 수 없습니다');
    Exit;
  end;

  if GetOption(289) = '1' then
  begin
    Common.ErrBox('메뉴에 봉사료금액을 입력해서 사용할때는'+#13#13+'사용할 수 없습니다');
    Exit;
  end;

  if FTipType = '0' then //금액형 봉사료
  begin
    vInData := Common.ShowNumberForm('봉사료 금액을 입력하세요',7, 0,'0');
    if vInData = 'mrClose' then Exit;
  end
  else
  begin
    vInData := Common.ShowNumberForm('봉사료 퍼센트(%)를 입력하세요',0,100,'0');
    if vInData = 'mrClose' then Exit;
  end;
  Common.Present.SetTip := StoI(vInData);
  DisplayPresent;
end;

procedure TOrder_F.Action22Execute(Sender: TObject);
var vIndex, vOrder, vBtn :Integer;
    vOption :Char;
    vRcvAmt :String;
begin
  if Common.PreSent.LetsOrderAmt > 0 then
  begin
    Common.ErrBox('레츠오더에서 결제한 테이블은'#13'선결제를 할 수 없습니다');
    Exit;
  end;

  if Common.PreSent.OrgRcvAmt < Common.PreSent.RcvAmt then
  begin
    Common.ErrBox('받은금액이 있으면 선결제를 할 수 없습니다');
    Exit;
  end;

  if not CheckGroupType then Exit;

  if Common.Config.IsTakeOut and (Common.Table.OrderType <> 'D') then
  begin
    Common.ErrBox('선불제에서는 사용할 수 없습니다');
    Exit;
  end;

  if (Common.Table.OrderType = 'D') then
  begin
    Common.ErrBox('배달주문 중에는 사용할 수 없습니다');
    Exit;
  end;

  if Common.PreSent.WRcvAmt = 0 then
  begin
    Common.ErrBox('받을 금액이 없습니다');
    Exit;
  end;

  if not CheckPresentChange then Exit;

  with TAHeadChoose_F.Create(Self) do
    try
      if ShowModal = mrOK then
      begin
        Common.Table.AHeadPay := true;
        vBtn := SelectBtn;
      end
      else
        Exit;
    finally
      Free;
    end;

  case vBtn of
    1 : Act_Card.Execute;
    2 : Act_CashRcp.Execute;
    3 : begin
          vRcvAmt := Common.ShowNumberForm('선결제 금액을 입력하세요', 0, Common.Present.WRcvAmt, IntToStr(Common.Present.WRcvAmt) );

          if vRcvAmt = 'mrClose' then
          begin
            Common.Table.AHeadPay := false;
            Exit;
          end;

          Common.PreSent.AHeadCashAmt := Common.PreSent.AHeadCashAmt + StrToInt(vRcvAmt);
          Common.PreSent.CashAmt      := Common.PreSent.CashAmt + StrToInt(vRcvAmt);
          Common.PreSent.AHeadPayAmt  := Common.PreSent.CardAmt + Common.PreSent.CashAmt;
          //렛츠오더에 결제내역 전송
          if GetHeadOption(9) = '1' then
          begin
            ExecQuery('insert into TR_ORDER(CD_STORE, '
                     +'                     GROUP_SEQ, '
                     +'                     GROUP_STEP, '
                     +'                     DS_ORDER, '
                     +'                     NO_TABLE, '
                     +'                     DS_AHEADPAY, '
                     +'                     NM_AHEADPAY, '
                     +'                     AMT_AHEADPAY, '
                     +'                     ORDER_DEVICE) '
                     +'              values(:P0, '
                     +'                     GetNextVal(''TR_ORDER''), '
                     +'                      0, '
                     +'                      ''A'', '
                     +'                      :P1, '
                     +'                      2, '
                     +'                      :P2, '
                     +'                      :P3, '
                     +'                      ''P'')',
                     [Common.Config.StoreCode,
                      Common.Table.Number,
                      '현금',
                      vRcvAmt]);
          end;

          CloseButtonClick(nil);
          Exit;

        end;

  end;
end;

function TOrder_F.CheckPrevAccount: Boolean;
begin
  Result := true;
  Exit;
  if (Common.Table.GroupType = 'M') and GroupTable_sGrd.Visible and ((Common.PreSent.TotalDC > 0) or (StoI(Common.Group_sGrd.HelpKeyword) > 0))
    and (GroupTable_sGrd.Cells[0,0] <> '') then
  begin
    Common.ErrBox('할인 시 그룹결제를 할 수 없습니다'#13#13'그룹해제 후 좌석을 합석하고'#13'결제해야합니다');
    Result := False;
  end
  else Result := True;
end;

//영수증관리
procedure TOrder_F.Tmr_AcctTimer(Sender: TObject);
begin
  Tmr_Acct.Enabled := False;
  if Tmr_Acct.Tag = 1 then
  begin
    Tmr_Acct.Tag := 0;
    Close;
  end
  else if (Common.PreSent.WRcvAmt = 0) then
    FinishExecute('11');
end;

procedure TOrder_F.Action23Execute(Sender: TObject);
var vTemp :String;
begin
  if CheckSaleFinish then Exit;
  vTemp := Common.ShowNumberForm('메뉴번호를 입력하세요',5,0,'');
  if vTemp = 'mrClose' then Exit;

  OpenQuery('select CD_MENU '
           +'  from MS_MENU '
           +' where CD_STORE=:P0 '
           +'   and NO_MENU =:P1 '
           +' limit 1 ',
           [Common.Config.StoreCode,
            StrToInt(vTemp)]);

  if not Common.Query.Eof then
  begin
    FMenuCode := Common.Query.Fields[0].AsString;
    Common.Query.Close;
    SelectMenu(0);
  end
  else Common.ErrBox('등록된 메뉴번호가 없습니다');
end;

procedure TOrder_F.Tmr_StartTimer(Sender: TObject);
begin
  Tmr_Start.Enabled  := False;
  Tmr_Start.Interval := 1;
  if Self.Showing and not Common.Config.IsKiosk then
    Present_sGrd.SetFocus;
  if ScaleData <> '' then
  begin
    Action25Execute(nil);
    Exit;
  end;

  if Common.Config.IsKiosk then
  begin
    SetPluClassData;
    OrderListView;
  end;

  if Tmr_Start.Tag = 100 then
  begin
    Tmr_Start.Tag := 0;
    FinishExecute('12');
  end;
end;

procedure TOrder_F.Action24Execute(Sender: TObject);
begin
  if GetOption(19) = '0' then
  begin
    Common.ErrBox('재고기능을 사용해야 사용이 가능합니다');
    Exit;
  end;

  MenuSearch_F := TMenuSearch_F.Create(Self);
  try
    if MenuSearch_F.ShowModal = mrOK then
    begin
      FMenuCode := MenuSearch_F.GoodsCode;
      SelectMenu(0);
    end;
  finally
    FreeAndNil(MenuSearch_F);
    Common.Device.OnScannerReadData := ScannerReadEvent;
  end;
end;

procedure TOrder_F.CidReadEvent(const S: String);
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
var vLine :Integer;
begin
  //고정TakeOut방식, 선불제이면서 배달기능을 사용할때
  if not Assigned(Table_F) and Common.Config.IsTakeOut and (GetOption(185) = '1') then
  begin
    if WorkState in [wsReady, wsMagam] then
    begin
      FCidData := S;
      Close;
      Exit;
    end;
  end;

  //전화가 왔을때(콜스타)
  if (S[1] = 'C') and (S[3] <> 'S') then
  begin
    //부재중전화 리스트에 저장
    Common.AddCidData(S);

    vLine := StrToInt(Copy(S,2,1));
//    FPopUp[vLine].Close(FPopUp[vLine].Caption);
    Common.ClearDeliveryTel(vLine);
//    FPopUp[vLine].PopupStartY := (vLine * 122)-122+16;
    Common.GetDeliveryTelInfo( S );
    //기주문건이면 부재중에서 삭제한다
    if (Common.DeliveryTel[vLine].Status <> '0') or (Common.DeliveryTel[vLine].Status <> '1') then
      DeleteCidData(S);

//    FPopUp[vLine].Title := Common.DeliveryTel[vLine].Cust + ' ['+Copy(S,2,1)+'회선]';
//    if (Common.DeliveryTel[vLine].Status = '0') or (Common.DeliveryTel[vLine].Status = '1') then
//      FPopUp[vLine].Text  := Common.DeliveryTel[vLine].TelNo + #13 +'(출력)'
//    else
//    begin
//      if Common.DeliveryTel[vLine].Status = 'N' then
//        FPopUp[vLine].Text  := Common.DeliveryTel[vLine].TelNo + #13 +'[미주문]'+#13+'(출력)'
//      else if Common.DeliveryTel[vLine].Status = 'O' then
//        FPopUp[vLine].Text  := Common.DeliveryTel[vLine].TelNo + #13 +'[주문]'+#13+'(출력)'
//      else if Common.DeliveryTel[vLine].Status = 'D' then
//        FPopUp[vLine].Text  := Common.DeliveryTel[vLine].TelNo + #13 +'[배달]'+#13+'(출력)';
//    end;
//    FPopUp[vLine].URL     := '';
//    FPopUp[vLine].TimeOut := 15;
//    FPopUp[vLine].ShowPopUp;
  end
   //전화를 받았을때(콜스타)
  else if (S[1] = 'C') and (S[3] = 'S') then
  begin
    //전화를 받으면 해당 팝업을 닫는다
//    vLine := StrToInt(Copy(S,2,1));
//    FPopUp[vLine].Close(FPopUp[vLine].Caption);
  end;
end;

procedure TOrder_F.CloseButtonClick(Sender: TObject);
  procedure PrintLogSave;
  var vIndex, I, II, vCnt :Integer;
      vGroupTxt, vTemp, vSource :String;
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

    //출력내역을 DB에 저장한다
    For vIndex := 0 to High(Common.KitchenPrinter) do
    begin
      if (Common.KitchenPrinter[vIndex].Cancel = EmptyStr) then Continue;

      //낱장으로 인쇄한다고 설정을 안하면 구분자가 없기때문에 여기서 붙어준다
      if GetOption(9) = '0' then
        vSource := CtoC(Common.KitchenPrinter[vIndex].Source,'∵','') + #28
      else
        vSource := CtoC(Common.KitchenPrinter[vIndex].Source,'∵','');

      vCnt := CharCnt(vSource, #28);

      For I := 0 to vCnt-1 do
      begin
        vTemp := CopyPos( vSource, #28, I);
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
            Common.WriteLog('CloseButton',E.Message);
          end;
        end;
      end;
    end;

    //그룹으로 묶인내용
    if (GetOption(79) = '1') then
    begin
      For vIndex := 0 to High(Common.KitchenPrinter) do
      begin
        For I := 1 to 100 do
        begin
          if Common.KitchenPrinter[vIndex].GroupSource[I] = EmptyStr then Continue;

          try
            Common.SavePrintData(Common.KitchenPrinter[vIndex].Code,
                                 CtoC(Common.KitchenPrinter[vIndex].GroupSource[I],'∵',''),
                                 Common.Table.DamdangName,
                                 Common.Config.PosNo,
                                 Common.NowDate+Common.NowTime,
                                 Common.Table.CustomerCount,
                                 Common.Table.OrderNo);
          except
            on E: Exception do
            begin
              Common.WriteLog('CloseButton',E.Message);
            end;
          end;
        end;
      end;
    end;
  end;
var vRow, vCnt, vCnt2, vOrderAmt :Integer;
    vErrMsg, vResult :String;
begin
  if (Sender <> nil) and (MilliSecondsBetween(Now(),ClickTime) < 500) then Exit;
  ClickTime := Now;

  if WorkState = wsMagam then WorkState := wsReady;
  if (Common.Table.WaitTableNo <> 0) and (Common.OrderKind = okNew) then
  begin
    if not Common.AskBox('대기중 주문한 내역이 모두 삭제됩니다.'#13'주문버튼을 클릭해야 저장됩니다'#13'계속 하시겠습니까?') then Exit;
  end;

  //현금요청 테이블일때
  if Common.Table.isCashOrder and (Common.PreSent.AHeadPayAmt > 0) and (Common.PreSent.AHeadPayAmt < Common.PreSent.RcvAmt)  then
  begin
    Common.ErrBox('결제를 완료해야합니다');
    Exit;
  end;

  if Common.Table.isCashOrder and (Common.PreSent.AHeadPayAmt > 0) then
  begin
    ModalResult := mrOK;
    Exit;
  end;

  if (Common.PreSent.LetsOrderAmt = 0) and (Common.PreSent.AHeadPayAmt = 0) and (Common.PreSent.RcvAmt <> 0) then
  begin
    Common.ErrBox('결제내역이 있습니다'+#13#13+'먼저 결제를 취소해야합니다');
    Exit;
  end;

  if Common.Table.AHeadPay then
  begin
    Action38.Execute;
    ModalResult := mrOK;
    Exit;
  end;

  vCnt := 0;
  //신용카드 승인내역이 있는지 체크
  for vRow := 0 to Common.Card_sGrd.RowCount-1 do
    if (Common.Card_sGrd.Cells[GDC_YN_SAVE, vRow] = 'Y') and (Common.Card_sGrd.Cells[GDC_YN_AHEAD, vRow] <> 'Y') and (Common.Card_sGrd.Cells[GDC_PG_TID, vRow] = '') then Inc(vCnt);

  if (vCnt > 0) and (Common.PreSent.RcvAmt > 0) then
  begin
    Common.MsgBox('신용카드 승인내역이 있습니다'+#13#13+
                  '정산을 완료해야 합니다');
    Exit;
  end;


  try
    if not Common.IsDebugMode and ((GetOption(379) <> '2') or (Common.Config.van_trd <> vanKICC)) then
      BlockInput(true);
    Common.Device.OnScannerReadData := nil;

    if Sender <> nil then
      Common.WriteLog('work', '주문폼 닫기');

    //렛츠오더에 결제내역만 있을때
    if (Main_sGrd.Cells[0, 0] = '') and (Common.PreSent.LetsOrderAmt > 0) then
    begin
      ExecQuery('update SL_ORDER_H '
               +'   set TABLE_STATE    =''N'' '
               +' where CD_STORE   =:P0 '
               +'   and NO_TABLE   =:P1 '
               +'   and DS_ORDER   =''T'' ',
               [Common.Config.StoreCode,
                Common.Table.Number]);
      ModalResult := mrOK;
      Exit;
    end;

    //입금조정일때
    if Common.OrderKind in [okChange, okBanpum] then
    begin
      vCnt := 0;
      //신용카드 승인내역이 있는지 체크
      for vRow := 0 to Common.Card_sGrd.RowCount-1 do
        if (Common.Card_sGrd.Cells[GDC_YN_SAVE, vRow] = 'Y') then Inc(vCnt);

      if vCnt > 0 then
      begin
        Common.MsgBox('신용카드 승인내역이 있습니다'+#13#13+
                      '정산을 완료해야 합니다');
        Exit;
      end;

      //현금영수증 승인내역이 있는지 체크
      for vRow := 0 to Common.Cash_sGrd.RowCount-1 do
        if Common.Cash_sGrd.Cells[GDR_YN_PRINT, vRow] = 'Y' then Inc(vCnt);

      if vCnt > 0 then
      begin
        Common.MsgBox('현금영수증 승인내역이 있습니다'+#13#13+
                      '정산을 완료해야 합니다');
        Exit;
      end;

      if (Common.PreSent.RcvAmt <> Common.PreSent.OrgRcvAmt) and (Common.PreSent.WRcvAmt > 0) then
      begin
        Common.MsgBox('받을금액이 남아 있습니다'+#13#13+
                      '정산을 완료해야 합니다');
        Exit;
      end;

      if RcpChange_F.ShowMode = fsmSale then
      begin
        LockWindowUpdate(Handle);
        Common.OrderKind := okNew;
        WorkState        := wsReady;
        Action20.Execute;
        LockWindowUpdate(0);
      end
      else Close;
      Exit;
    end;

    vCnt := 0;
    for vRow := 0 to Main_sGrd.RowCount-1 do
      if Main_sGrd.Cells[GDM_YN_ORDER, vRow] = 'Y' then Inc(vCnt);

    if (Common.OrderKind <> okNew) and  (Common.PreSent.AHeadPayAmt > 0) and (vCnt = 0) then
    begin
      Common.MsgBox('선결제가 있는 테이블일 때는'+#13#13+'메뉴를 모두 삭제 할 수 없습니다');
      Exit;
    end;

    if Common.PreSent.LetsOrderAmt > 0 then
      Common.ClearGrid(Common.Card_SGrd);

    if (Common.OrderKind in [okNew, okAppend]) and (Common.PreSent.UPlusDc > 0) then
    begin
      Common.ErrBox('유플러스 할인 시 정산을 완료해야합니다');
      Exit;
    end;

    vCnt := 0;
    if not Common.Config.IsKiosk then
      for vRow := 0 to Main_sGrd.RowCount-1 do
        if (Main_sGrd.Cells[GDM_YN_ORDER, vRow] = 'N')
          and (Main_sGrd.Cells[GDM_CD_MENU, vRow] <> Common.Config.OverTimeMenu)
          and (Main_sGrd.Cells[GDM_SERVICE_CHG, vRow] <> 'Y') then Inc(vCnt);

      vCnt2 := 0;
      for vRow := 0 to Main_sGrd.RowCount-1 do
        if (Main_sGrd.Cells[GDM_YN_CASHTEMP, vRow] = 'Y') then
          Inc(vCnt2);

      if vCnt > 0 then
      begin
        if Common.Table.isCashOrder then
        begin
          if (vCnt <> vCnt2) and not Common.AskBox('주문내역이 있습니다'+#13
                              +'주문내역이 저장되지 않습니다' + #13#13
                              +'계속하시겠습니까?') then

          begin
            Exit;
          end
          else
          begin
            ExecQuery('update SL_ORDER_H '
                     +'   set TABLE_STATE = ''O'' '
                     +' where CD_STORE =:P0 '
                     +'   and NO_TABLE =:P1 ',
                     [Common.Config.StoreCode,
                      Common.Table.Number]);
            Close;
            Exit;
          end;
        end
        else
        begin
          if not Common.AskBox('주문내역이 있습니다'+#13
                              +'주문내역이 저장되지 않습니다' + #13#13
                              +'계속하시겠습니까?') then
          begin
            Exit;
          end;
        end;
      end;

    for vRow := 0 to Main_sGrd.RowCount-1 do
    begin
      if Main_sGrd.Cells[0, 0] = '' then Break;
      if (Main_sGrd.Cells[GDM_YN_ORDER, vRow] = 'Y') then Continue;
      //주문내역을 주문취소내역에 저장한다
      Common.OrderCancelGridSave(vRow, Abs(StoI(Main_sGrd.Cells[GDM_QTY, vRow])),'Y','N' );
    end;

    //주문취소내역 저장
    if (Common.Config.IsTakeOut) and (Common.Table.OrderType <> 'D') then
      SaveAuditor('A','',0,0,0)
    else
    begin
//      if (Common.Cancel_sGrd.Cells[0,0] <> '') and (Sender <> nil) then
//      begin
//        vCnt := 0;
//        for vRow := 0 to Common.Cancel_sGrd.RowCount-1 do
//        begin
//          if (Common.Cancel_sGrd.Cells[4,vRow] = 'Y') and (Common.Cancel_sGrd.Cells[GDM_SERVICE_CHG,vRow] <> 'Y') then
//          begin
//            vCnt := 1;
//            Break;
//          end;
//        end;
//        if vCnt = 1 then
//          Common.MsgBox('기주문 취소내역은 저장됩니다');
//      end;
      OrderCancelDBApply(1);
    end;

    for vRow := 0 to Main_sGrd.RowCount-1 do
    begin
      if Main_sGrd.Cells[0, 0] = '' then Break;
      if Main_sGrd.Cells[GDM_YN_ORDER, vRow] = 'Y' then Continue;
      //주문내역을 주문취소내역에 저장한다
      Common.OrderCancelGridSave(vRow, Abs(StoI(Main_sGrd.Cells[GDM_QTY, vRow])),'Y','N');
    end;

    //렛츠오더에서 주문이나 결제가 있으면 테이블을 삭제하지 않는다
    if (Common.Table.OrderType = 'T') and (GetHeadOption(9) = '1') and (Common.OrderKind = okNew) then
    begin
      OpenQuery('select YN_LETSORDER '
               +'  from SL_ORDER_H '
               +' where CD_STORE =:P0 '
               +'   and DS_ORDER =''T'' '
               +'   and NO_TABLE =:P1',
               [Common.Config.StoreCode,
                Common.Table.Number]);

      if Common.Query.Fields[0].AsString = 'Y' then
        Common.OrderKind := okAppend;

      Common.Query.Close;
    end;


    Common.ShowWaitForm;
    try
      Common.DbConnect;
      Common.BeginTran;

      //주문번호채번
      Common.Table.OrderNo := Common.GetOrderNo(0);

      DM.StoredProc.StoredProcName := 'POS_SAVE_ORDER_D';
      DM.StoredProc.PrepareSQL;

      with Main_sGrd do
      if Cells[0,0] <> '' then
      For vRow := 0 to RowCount - 1 do
      begin
        if (Cells[GDM_YN_ORDER, vRow] = 'Y') or (Cells[GDM_YN_MUST, vRow] <> 'Y') then Continue;

        DM.StoredProc.Close;
        DM.StoredProc.ParamByName('_CD_STORE').AsString    := Common.Config.StoreCode;
        DM.StoredProc.ParamByName('_NO_TABLE').AsInteger   := Common.Table.Number;
        DM.StoredProc.ParamByName('_DS_ORDER').AsString    := Common.Table.OrderType;
        DM.StoredProc.ParamByName('_CD_MENU').AsString     := Cells[GDM_CD_MENU, vRow];
        DM.StoredProc.ParamByName('_SEQ').AsInteger        := StoI(Cells[GDM_SEQ, vRow]);
        DM.StoredProc.ParamByName('_NO_STEP').AsInteger    := StoI(Cells[GDM_NO_STEP, vRow]);
        DM.StoredProc.ParamByName('_NO_POS').AsString      := Common.Config.PosNo;
        DM.StoredProc.ParamByName('_DS_SALE').AsString     := Cells[GDM_DS_SALE, vRow];
        Cells[GDM_NM_MENU, vRow] := StringReplace(Cells[GDM_NM_MENU, vRow],
                                                  '('+Cells[GDM_MEMO, vRow]+')',
                                                  '',
                                                  [rfReplaceAll]);
        if Cells[GDM_DS_SALE, vRow] = 'D' then
          Cells[GDM_NM_MENU, vRow] := StringReplace(Cells[GDM_NM_MENU, vRow], Common.Config.ServiceTxt, '', [rfReplaceAll]);
        DM.StoredProc.ParamByName('_NM_MENU').AsString    := SCopy(Cells[GDM_NM_MENU, vRow], 1, 50);
        DM.StoredProc.ParamByName('_DS_MENU').AsString    := Cells[GDM_DS_MENU, vRow];
        DM.StoredProc.ParamByName('_CD_MENU1').AsString   := Cells[GDM_CD_MENU1, vRow];
        DM.StoredProc.ParamByName('_PR_SALE').AsInteger    := StoI(Cells[GDM_PR_SALE, vRow]);
        DM.StoredProc.ParamByName('_PR_SALE_ORG').AsInteger:= StoI(Cells[GDM_PR_SALE_ORG, vRow]);
        DM.StoredProc.ParamByName('_QTY_ORDER').AsInteger  := StoI(Cells[GDM_QTY, vRow]);
        if Cells[GDM_DS_MENU, vRow] = 'W' then
          DM.StoredProc.ParamByName('_AMT_ORDER').AsInteger  := StoI(Cells[GDM_PR_SALE, vRow])
        else
          DM.StoredProc.ParamByName('_AMT_ORDER').AsInteger  := StoI(Cells[GDM_PR_SALE, vRow])
                                                                      *StoI(Cells[GDM_QTY, vRow]);

        DM.StoredProc.ParamByName('_QTY_NEPUM').AsInteger := StoI(Cells[GDM_NEPUM, vRow]);
        DM.StoredProc.ParamByName('_PR_TIP').AsInteger    := Ifthen(GetOption(289)='0', StoI(Cells[GDM_TIP, vRow]),0);
        DM.StoredProc.ParamByName('_PR_ITEM').AsInteger   := StoI(Cells[GDM_PR_ITEM, vRow]);
        DM.StoredProc.ParamByName('_CD_ITEM').AsString    := Cells[GDM_CD_ITEM, vRow];
        DM.StoredProc.ParamByName('_DS_TAX').AsString     := Cells[GDM_DS_TAX, vRow];
        DM.StoredProc.ParamByName('_CD_PRINTER').AsString := Cells[GDM_KITCHEN, vRow];
        DM.StoredProc.ParamByName('_NO_SPC').AsString     := Cells[GDM_NO_SPC, vRow];
        DM.StoredProc.ParamByName('_DC_SPC').AsInteger    := StoI(Cells[GDM_DC_SPC, vRow]);
        DM.StoredProc.ParamByName('_DC_MENU').AsInteger   := StoI(Cells[GDM_DC_MENU, vRow]);
        DM.StoredProc.ParamByName('_MEMO').AsString       := Cells[GDM_MEMO,     vRow];
        DM.StoredProc.ParamByName('_CD_SERVICE').AsString := Cells[GDM_CD_SERVICE,   vRow];
        DM.StoredProc.ParamByName('_NO_ORDER').AsString   := IntToStr(Common.Table.OrderNo);

        if Cells[GDM_YN_MUST, vRow] = 'Y' then
          DM.StoredProc.ParamByName('_WORK_KIND').AsString  := 'I'
        else
          DM.StoredProc.ParamByName('_WORK_KIND').AsString  := 'U';
        DM.StoredProc.ExecProc;
      end;

      if not Common.Config.IsTakeOut then
      begin
        OpenQuery('select Sum(case when b.DS_MENU_TYPE = ''W'' then 1 else a.QTY_ORDER end * a.PR_SALE) '
                 +'  from SL_ORDER_D a inner join '
                 +'       MS_MENU    b on b.CD_STORE = a.CD_STORE '
                 +'                   and b.CD_MENU  = a.CD_MENU '
                 +' where a.CD_STORE = :P0 '
                 +'   and a.DS_ORDER = :P1 '
                 +'   and a.NO_TABLE = :P2 ',
                 [Common.Config.StoreCode,
                  Common.Table.OrderType,
                  Common.Table.Number]);
        vOrderAmt := Common.Query.Fields[0].AsInteger-Common.PreSent.TotalDC;
        Common.Query.Close;

        DM.StoredProc.StoredProcName := 'POS_SELECT_ORDER_H';
        DM.StoredProc.PrepareSQL;

        DM.StoredProc.Close;
        DM.StoredProc.ParamByName('_CD_STORE').AsString    := Common.Config.StoreCode;
        DM.StoredProc.ParamByName('_NO_TABLE').AsInteger   := Common.Table.Number;
        DM.StoredProc.ParamByName('_DS_ORDER').AsString    := Common.Table.OrderType;
        case Common.OrderKind of
          okNew    : DM.StoredProc.ParamByName('_TABLE_STATE').AsString := 'D';
          okAppend : DM.StoredProc.ParamByName('_TABLE_STATE').AsString := 'O';
          okDutchPay,
          okDutchPayAll : DM.StoredProc.ParamByName('_TABLE_STATE').AsString := 'K';
        end;
        DM.StoredProc.ParamByName('_AMT_ORDER').AsInteger   := vOrderAmt - Common.PreSent.AHeadPayAmt - Common.PreSent.LetsOrderAmt;
        DM.StoredProc.ParamByName('_AMT_CASH').AsInteger   := Common.PreSent.AHeadCashAmt;

        DM.StoredProc.ParamByName('_NO_POS').AsString      := Common.Config.PosNo;
        DM.StoredProc.ParamByName('_CD_MEMBER').AsString   := Common.Member.Code;
        DM.StoredProc.ParamByName('_NO_BOOKING').AsString  := Common.Table.BookingNo;
        DM.StoredProc.ParamByName('_CNT_PERSON').AsInteger := Common.Table.CustomerCount;
        DM.StoredProc.ParamByName('_CD_CUSTOMER').AsString := Common.Table.CustCode;

        DM.StoredProc.ParamByName('_CD_AGE').AsString      := SetAgeCode;
        DM.StoredProc.ParamByName('_CD_DAMDANG').AsString  := Common.Table.DamdangCode;
        DM.StoredProc.ParamByName('_CD_CODE').AsString     := Common.PreSent.CodeDcCode;
        DM.StoredProc.ParamByName('_RT_DC').AsCurrency     := Common.PreSent.RcpDc_Rate;
        DM.StoredProc.ParamByName('_AMT_DC').AsInteger     := Common.PreSent.RcpDc;
        DM.StoredProc.ParamByName('_AMT_CODEDC').AsInteger := Common.PreSent.CodeDcAmt;
        DM.StoredProc.ParamByName('_DC_MENU').AsInteger    := Common.PreSent.MenuDc;
        DM.StoredProc.ParamByName('_DS_CUST').AsString     := Common.Table.DsCust;
        DM.StoredProc.ParamByName('_MEMO_TXT').AsString    := Common.Table.Memo;
        if Common.Table.OrderNo > 0 then
          DM.StoredProc.ParamByName('_NO_ORDER').AsInteger   := Common.Table.OrderNo;
        DM.StoredProc.ExecProc;
        vResult := DM.StoredProc.ParamByName('_RESULT').AsString;
        DM.StoredProc.Close;
        if vResult <> 'OK' then
          raise Exception.Create(vResult);
      end;

      //렛츠오더 현금요청일때
      if Common.Table.isCashOrder then
        ExecQuery('delete from SL_ORDER_D '
                 +' where CD_STORE = ''CASHTEMP'' '
                 +'   and NO_TABLE =:P0',
                 [Common.Table.Number]);


      //렛츠오더 사용시 주문메뉴가 모두 삭제됐을때 SL_ORDER_H 삭제한다
      if not Common.Config.IsTakeOut and (Common.Table.OrderType = 'T') and (Common.OrderKind = okAppend) and (GetHeadOption(9) = '1') and (Common.Present.LetsOrderAmt = 0) then
      begin
        OpenQuery('select Count(*) '
                 +'  from SL_ORDER_D  '
                 +' where CD_STORE = :P0 '
                 +'   and DS_ORDER = :P1 '
                 +'   and NO_TABLE = :P2 ',
                 [Common.Config.StoreCode,
                  Common.Table.OrderType,
                  Common.Table.Number]);
        if Common.Query.Fields[0].AsInteger = 0 then
        begin
          ExecQuery('insert into TR_ORDER(CD_STORE, '
                   +'                     GROUP_SEQ, '
                   +'                     GROUP_STEP, '
                   +'                     DS_ORDER, '
                   +'                     NO_TABLE, '
                   +'                     ORDER_DEVICE) '
                   +'              values(:P0, '
                   +'                     GetNextVal(''TR_ORDER''), '
                   +'                      0, '
                   +'                      ''T'', '
                   +'                      :P1, '
                   +'                      ''P'')',
                   [Common.Config.StoreCode,
                    Common.Table.Number]);
        end;
        Common.Query.Close;
      end;

      Common.WriteLog('work', '주문닫기['+FormatFloat('#,0',vOrderAmt)+']');

      {예약석이었으면 예약상태로 변경}
      if (Common.Table.BookingNo <> '') and (Main_sGrd.Cells[0,0] = '') then
        ExecQuery('update SL_BOOKING '
                 +'   set YN_SALE    =''N'' '
                 +' where CD_STORE   =:P0 '
                 +'   and NO_BOOKING =:P1 ',
                 [Common.Config.StoreCode,
                  Common.Table.BookingNo]);

      //환경설정에서 고객주문서를 주문내역을 전체출력한다고 체크했으면
      if not Common.Table.isWaitTable and (Common.CustomerCancel <> EmptyStr) then
        Common.GetAllCustomerOrder;

//2025.12.17 태블릿에서 포스 사용중 주문시 출력이 오래될때 에러발생으로 Commit를 먼저하는걸로 변경
      if not Common.Table.isWaitTable then
      begin
        PrintLogSave;
        if KitchenPrintMode then
          Common.SaveKDSData(false);
        Common.CommitTran;
        Common.Device.OrderPrint(BillPrintMode, KitchenPrintMode);
      end
      else
        Common.CommitTran;
    except
      on E: Exception do
      begin
        Common.RollbackTran;
        Common.WriteLog('CloseButton',E.Message);
        if Pos('Lost connection to MySQL server during query', E.Message) > 0 then
          Common.DBConnectError := True
        else
          Common.DBConnectError := False;
        Common.ErrBox(E.Message);
      end;
    end;

    if (Common.Table.OrderType = 'D')  and (GetOption(368) = '0') then
    begin
      Common.GridToGrid(Main_sGrd, DeliveryInfo_F.Order_sGrd);
      SaveDeliveryAmnt(false, vOrderAmt);
      ModalResult := mrOK;
    end
    //그리드형 배달
    else if (Common.Table.OrderType = 'D') and (GetOption(368) = '1') then
    begin
      SaveDeliveryAmnt(false, vOrderAmt);
      ModalResult := mrOK;
    end;

    if Sender = nil then
      ModalResult := mrOK
    else
      Close;
  finally
    Tmr_KioskWait.Enabled := false;
    Common.HideWaitForm;
    Common.WriteLog('work', '주문닫기 완료');
    BlockInput(false);
    Common.Device.OnScannerReadData := ScannerReadEvent;
  end;
end;

procedure TOrder_F.NoTransImageClick(Sender: TObject);
begin
  Common.TRSendMessage('UPLOAD');
  Sleep(1000);
  SetNoTransCount;
end;

procedure TOrder_F.Action38Execute(Sender: TObject);
var vIndex, vIndex1, nCnt, vPerson, vTotalDC, vOrderAmt, vOldQty:Integer;
    ErrFlag, OrderMenu, vResult :String;
    vErrMsg :String;
    vSeq, vSubSeq, vResultSeq    :Integer;
    vError :Boolean;
begin
  try
    if not Common.IsDebugMode then
      BlockInput(True);
                                                               
    AccountButtonPanel.Enabled := false;
    Common.Device.OnScannerReadData := nil;
    if Common.Config.IsKiosk then
    begin
      Common.ErrBox(Format('해당기능을 사용할 수 없습니다[%s]',['Action38Execute']));
      Exit;
    end;

    if Common.Table.OrderType <> 'T' then
    begin
      //선불제이면서 결제타입을 4번으로 사용시는 주문버튼을 현금정산버튼으로 사용한다
      if Common.Config.IsTakeOut then
      begin
        if WorkState = wsMagam then WorkState := wsReady;
        FinishExecute('13');
        Exit;
      end
      else if Common.Config.IsTakeOut then
      begin
        if WorkState = wsMagam then WorkState := wsReady;
        Common.ErrBox('선불제 매장에서는 사용할 수 없습니다');
        Exit;
      end;
    end
    else
    begin
      nCnt := 0;
      For vIndex :=0 to Main_sGrd.RowCount-1 do
        if (Common.Table.WaitTableNo > 1) or ((Main_sGrd.Cells[GDM_YN_ORDER, vIndex] = 'N') or (Main_sGrd.Cells[GDM_CHANGE, vIndex] = 'Y')) then Inc(nCnt);

      if (nCnt = 0) and (Common.Cancel_sGrd.Cells[0,0] = '') and not Common.Table.AHeadPay and Common.Table.isCashOrder then
      begin
        Common.ErrBox('주문한 내역이 없습니다');
        Exit;
      end;

      if Common.PreSent.UPlusDc > 0 then
      begin
        Common.ErrBox('유플러스 할인 시 주문을 할 수 없습니다');
        Exit;
      end;
    end;

    if Common.OrderKind = okChange then
    begin
      Common.ErrBox('결제변경 시에는 사용할 수 없습니다');
      Exit;
    end;

    if Common.PreSent.UseStamp > 0 then
    begin
      if not Common.AskBox('사용한 스템프는 취소됩니다'#13'계속하시겠습니까?') then Exit;
      Common.PreSent.UseStamp := 0;
      DisplayPresent;
    end;

    nCnt    := 0;
    vPerson := 0;
    For vIndex :=0 to Main_sGrd.RowCount-1 do
    begin
      if Main_sGrd.Cells[GDM_YN_ORDER, vIndex] = 'N' then Inc(nCnt);

      //고객수추정메뉴 사용시
      if (GetOption(307) = '1') and (StrToIntDef(Main_sGrd.Cells[GDM_YN_PERSON, vIndex],0) > 0) then
      begin
        if Main_sGrd.Cells[GDM_DS_MENU, vIndex] = 'W' then
          vPerson := vPerson + 1
        else
          vPerson := vPerson + StoI(Main_sGrd.Cells[GDM_QTY, vIndex]) * StrToIntDef(Main_sGrd.Cells[GDM_YN_PERSON, vIndex],0);
      end;
    end;

    if (nCnt = 0) and (Common.Cancel_sGrd.Cells[0,0] <> '') and not Common.Table.isCashOrder then
    begin
      CloseButtonClick(nil);
      Exit;
    end;

    try
      if WorkState = wsMagam then
        WorkState := wsReady;
      ErrFlag := '-0';
      if not CheckPresentChange then Exit;

      if not Common.Table.AHeadPay and not Common.Table.isCashOrder then
      begin
        nCnt := 0;
        For vIndex :=0 to Main_sGrd.RowCount-1 do
          if (Main_sGrd.Cells[GDM_YN_ORDER, vIndex] = 'Y') or (Main_sGrd.Cells[GDM_CHANGE, vIndex] = 'Y') then Inc(nCnt);

        if nCnt = 0 then
        begin
          Common.ErrBox('주문한 내역이 없습니다');
          Exit;
        end;
      end;

      if Common.Table.isCashOrder and (Common.PreSent.AHeadPayAmt > 0) then
      begin
        Common.ErrBox('태블릿에서 현금요청 테이블에'#13'결제내역이 있을 때는'+#13+'주문을 할 수 없습니다');
        Exit;
      end;


      if (Common.PreSent.LetsOrderAmt = 0) and (Common.PreSent.AHeadPayAmt = 0) and (Common.PreSent.RcvAmt <> 0) then
      begin
        Common.ErrBox('결제내역이 있습니다'+#13#13+'먼저 결제를 취소해야합니다');
        Exit;
      end;

      //메뉴별 최소주문 수량체크
      vError := false;
      For vIndex :=0 to Main_sGrd.RowCount-1 do
      begin
        if (Main_sGrd.Cells[GDM_YN_ORDER, vIndex] = 'N') and (Copy(Main_sGrd.Cells[GDM_CONFIG, vIndex],14,1) <> '0') then
        begin
          if StoI(Copy(Main_sGrd.Cells[GDM_CONFIG, vIndex],14,1)) > StoI(Main_sGrd.Cells[GDM_QTY, vIndex]) then
          begin
            //이미 주문된 메뉴가 있는지 체크한다
            vOldQty := 0;
            for vIndex1 := 0 to Main_sGrd.RowCount-1 do
            begin
              if (Main_sGrd.Cells[GDM_YN_ORDER, vIndex1] = 'Y') and (Main_sGrd.Cells[GDM_CD_MENU, vIndex] = Main_sGrd.Cells[GDM_CD_MENU, vIndex1]) then
              begin
                vOldQty := StoI(Main_sGrd.Cells[GDM_QTY, vIndex1]);
                Break;
              end;
            end;

            if StoI(Copy(Main_sGrd.Cells[GDM_CONFIG, vIndex],14,1)) > (StoI(Main_sGrd.Cells[GDM_QTY, vIndex])+vOldQty) then
            begin
              if not Common.AskBox(Format('%s 메뉴는'#13'최소 주문수량이 %s 입니다'#13'주문 하시겠습니까?',[Main_sGrd.Cells[GDM_NM_MENU, vIndex],
                                                                                     Copy(Main_sGrd.Cells[GDM_CONFIG, vIndex],14,1)])) then
                vError := true;
              Break;
            end;
          end;
        end;
      end;

      if vError then Exit;

      try
        Common.BeginTran;
        OrderCancelDBApply;

        //고객수 추정메뉴 사용 시
        if (GetOption(307) = '1') and (Common.OrderKind = okNew) then
          Common.SetCustomerCount(vPerson);

        vOrderAmt := Common.Present.TotalAmt
                  - Common.PreSent.TotalDC
                  + Common.PreSent.CutDc
                  - Common.Table.GroupAmt
                  - Common.PreSent.AHeadPayAmt
                  - Common.PreSent.AddMenuAmt;

        //주문번호채번
        Common.Table.OrderNo := Common.GetOrderNo(1);

        if Common.Table.isCashOrder then
        begin
          OpenQuery('select Count(*) '
                   +'  from SL_ORDER_D  '
                   +' where CD_STORE = :P0 '
                   +'   and DS_ORDER = :P1 '
                   +'   and NO_TABLE = :P2 ',
                   [Common.Config.StoreCode,
                    Common.Table.OrderType,
                    Common.Table.Number]);
          if Common.Query.Fields[0].AsInteger = 0 then
          begin
            ExecQuery('insert into TR_ORDER(CD_STORE, '
                     +'                     GROUP_SEQ, '
                     +'                     GROUP_STEP, '
                     +'                     DS_ORDER, '
                     +'                     NO_TABLE, '
                     +'                     ORDER_DEVICE) '
                     +'              values(:P0, '
                     +'                     GetNextVal(''TR_ORDER''), '
                     +'                      0, '
                     +'                      ''T'', '
                     +'                      :P1, '
                     +'                      ''P'')',
                     [Common.Config.StoreCode,
                      Common.Table.Number]);
        end;
        end;


        ErrFlag := '-1';
        DM.StoredProc.StoredProcName := 'POS_SAVE_ORDER_D';
        DM.StoredProc.PrepareSQL;

        vResultSeq := -1;
        with Main_sGrd do
        For vIndex := 0 to RowCount - 1 do
        begin
          if ((Cells[GDM_YN_ORDER, vIndex] = 'Y') and (Cells[GDM_CHANGE, vIndex] = 'N')) then Continue;
          if (Cells[GDM_CD_MENU, vIndex] = Common.Config.OverTimeMenu) then Continue;
          //영수증에 출력하지 않는메뉴 저장하지 않을때
          if (GetOption(178) = '1') and (Cells[GDM_YN_RCP, vIndex] = 'N') then Continue;

          //주메뉴가 수량추가가 됐을때는 부메뉴는 패스한다
          if (Cells[GDM_DS_MENU, vIndex][1] in ['C','O','I','S']) and (Cells[GDM_CD_MENU1, vIndex] <> '') and (vResultSeq >= 0) then
            Continue;

          DM.StoredProc.Close;
          DM.StoredProc.ParamByName('_CD_STORE').AsString    := Common.Config.StoreCode;
          DM.StoredProc.ParamByName('_NO_TABLE').AsInteger   := Common.Table.Number;
          DM.StoredProc.ParamByName('_DS_ORDER').AsString    := Common.Table.OrderType;
          DM.StoredProc.ParamByName('_CD_MENU').AsString     := Cells[GDM_CD_MENU, vIndex];
          //코스, 오픈세트, 아이템 부메뉴일때는 프로시져에서 순번을 다시 채번한다
          if (Cells[GDM_DS_MENU, vIndex][1] in ['C','O','I','S']) and (Cells[GDM_CD_MENU1, vIndex] <> '') then
            DM.StoredProc.ParamByName('_SEQ').AsInteger := vSeq
          else
            DM.StoredProc.ParamByName('_SEQ').AsInteger      := StoI(Cells[GDM_SEQ, vIndex]);
          DM.StoredProc.ParamByName('_NO_STEP').AsInteger    := StoI(Cells[GDM_NO_STEP, vIndex]);
          DM.StoredProc.ParamByName('_NO_POS').AsString      := Common.Config.PosNo;
          DM.StoredProc.ParamByName('_DS_SALE').AsString     := Cells[GDM_DS_SALE, vIndex];
          Cells[GDM_NM_MENU, vIndex] := StringReplace(Cells[GDM_NM_MENU, vIndex], Cells[GDM_MEMO, vIndex], '', [rfReplaceAll]);
          if Cells[GDM_DS_SALE, vIndex] = 'D' then
            Cells[GDM_NM_MENU, vIndex] := StringReplace(Cells[GDM_NM_MENU, vIndex], Common.Config.ServiceTxt, '', [rfReplaceAll]);
          DM.StoredProc.ParamByName('_NM_MENU').AsString     := Copy(Cells[GDM_NM_MENU, vIndex], 1, 50);
          DM.StoredProc.ParamByName('_DS_MENU').AsString     := Cells[GDM_DS_MENU, vIndex];
          DM.StoredProc.ParamByName('_CD_MENU1').AsString    := Cells[GDM_CD_MENU1, vIndex];
          DM.StoredProc.ParamByName('_PR_SALE').AsInteger    := StoI(Cells[GDM_PR_SALE, vIndex]);
          DM.StoredProc.ParamByName('_PR_SALE_ORG').AsInteger:= StoI(Cells[GDM_PR_SALE_ORG, vIndex]);
          DM.StoredProc.ParamByName('_CD_MENU1').AsString    := Cells[GDM_CD_MENU1, vIndex];
          DM.StoredProc.ParamByName('_CD_ITEM').AsString     := Cells[GDM_CD_ITEM, vIndex];
          DM.StoredProc.ParamByName('_PR_TIP').AsInteger     := ifthen(GetOption(289) ='0',StoI(Cells[GDM_TIP, vIndex]),0);
          DM.StoredProc.ParamByName('_PR_ITEM').AsInteger    := StoI(Cells[GDM_PR_ITEM, vIndex]);
          DM.StoredProc.ParamByName('_QTY_ORDER').AsInteger  := StoI(Cells[GDM_QTY, vIndex]);
          if Cells[GDM_DS_MENU, vIndex] = 'W' then
            DM.StoredProc.ParamByName('_AMT_ORDER').AsInteger  := StoI(Cells[GDM_PR_SALE, vIndex])
          else
            DM.StoredProc.ParamByName('_AMT_ORDER').AsInteger  := StoI(Cells[GDM_AMT, vIndex]);
          DM.StoredProc.ParamByName('_QTY_NEPUM').AsInteger   := StoI(Cells[GDM_NEPUM, vIndex]);
          DM.StoredProc.ParamByName('_DS_TAX').AsString       := Cells[GDM_DS_TAX, vIndex];
          DM.StoredProc.ParamByName('_CD_PRINTER').AsString   := Cells[GDM_KITCHEN, vIndex];
          DM.StoredProc.ParamByName('_NO_SPC').AsString       := Cells[GDM_NO_SPC, vIndex];
          DM.StoredProc.ParamByName('_DC_SPC').AsInteger      := StoI(Cells[GDM_DC_SPC, vIndex]);
          DM.StoredProc.ParamByName('_DC_MENU').AsInteger     := StoI(Cells[GDM_DC_MENU, vIndex]);
          DM.StoredProc.ParamByName('_MEMO').AsString         := Cells[GDM_MEMO,     vIndex];
          DM.StoredProc.ParamByName('_YN_DOUBLE').AsString    := Cells[GDM_YN_DOUBLE,   vIndex];
          DM.StoredProc.ParamByName('_CD_SERVICE').AsString   := Cells[GDM_CD_SERVICE,   vIndex];
          DM.StoredProc.ParamByName('_NO_ORDER').AsString     := IntToStr(Common.Table.OrderNo);

          if (Cells[GDM_YN_ORDER, vIndex] = 'Y') and (Cells[GDM_CHANGE, vIndex] = 'Y') then
            DM.StoredProc.ParamByName('_WORK_KIND').AsString  := 'U'
          else
            DM.StoredProc.ParamByName('_WORK_KIND').AsString  := 'I';
          DM.StoredProc.ExecProc;
          vSeq       := DM.StoredProc.ParamByName('_SEQ').AsInteger;
          vResultSeq := DM.StoredProc.ParamByName('_RESULT_SEQ').AsInteger;
          Cells[GDM_SEQ, vIndex] := IntToStr(vSeq);
        end;

        DM.StoredProc.StoredProcName := 'POS_SELECT_ORDER_H';
        DM.StoredProc.PrepareSQL;

        DM.StoredProc.Close;
        DM.StoredProc.ParamByName('_CD_STORE').AsString    := Common.Config.StoreCode;
        DM.StoredProc.ParamByName('_NO_TABLE').AsInteger   := Common.Table.Number;
        DM.StoredProc.ParamByName('_DS_ORDER').AsString    := Common.Table.OrderType;
        DM.StoredProc.ParamByName('_TABLE_STATE').AsString := 'O';
        DM.StoredProc.ParamByName('_AMT_ORDER').AsInteger   := vOrderAmt;
        DM.StoredProc.ParamByName('_AMT_CASH').AsInteger   := Common.PreSent.AHeadCashAmt;

        DM.StoredProc.ParamByName('_NO_POS').AsString      := Common.Config.PosNo;
        DM.StoredProc.ParamByName('_CD_MEMBER').AsString   := Common.Member.Code;
        DM.StoredProc.ParamByName('_NO_BOOKING').AsString  := Common.Table.BookingNo;
        DM.StoredProc.ParamByName('_CNT_PERSON').AsInteger := Common.Table.CustomerCount;
        DM.StoredProc.ParamByName('_CD_CUSTOMER').AsString := Common.Table.CustCode;

        DM.StoredProc.ParamByName('_CD_AGE').AsString      := SetAgeCode;
        DM.StoredProc.ParamByName('_CD_DAMDANG').AsString  := Common.Table.DamdangCode;
        DM.StoredProc.ParamByName('_CD_CODE').AsString     := Common.PreSent.CodeDcCode;
        DM.StoredProc.ParamByName('_RT_DC').AsCurrency     := Common.PreSent.RcpDc_Rate;
        DM.StoredProc.ParamByName('_AMT_DC').AsInteger     := Common.PreSent.RcpDc;
        DM.StoredProc.ParamByName('_AMT_CODEDC').AsInteger := Common.PreSent.CodeDcAmt;
        DM.StoredProc.ParamByName('_DC_MENU').AsInteger    := Common.PreSent.MenuDc;
        DM.StoredProc.ParamByName('_DS_CUST').AsString     := Common.Table.DsCust;
        DM.StoredProc.ParamByName('_MEMO_TXT').AsString    := Common.Table.Memo;
        if Common.Table.OrderNo > 0 then
          DM.StoredProc.ParamByName('_NO_ORDER').AsInteger   := Common.Table.OrderNo;
        DM.StoredProc.ExecProc;
        vResult := DM.StoredProc.ParamByName('_RESULT').AsString;
        DM.StoredProc.Close;
        if vResult <> 'OK' then
          raise Exception.Create(vResult);

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

        //렛츠오더 현금요청일때
        if Common.Table.isCashOrder then
        begin
          ExecQuery('update SL_ORDER_H '
                   +'   set YN_CASHORDER = ''N'' '
                   +' where CD_STORE =:P0 '
                   +'   and NO_TABLE =:P1 ',
                   [Common.Config.StoreCode,
                    Common.Table.Number]);
          ExecQuery('delete from SL_ORDER_D '
                   +' where CD_STORE = ''CASHTEMP'' '
                   +'   and NO_TABLE =:P0',
                   [Common.Table.Number]);
        end;

        Common.CommitTran;
        Common.WriteLog('work', '주문['+FormatFloat('#,0',vOrderAmt)+']');
      except
        on E: Exception do
        begin
          Common.RollbackTran;
          Common.ClearKitchenData;
          Common.WriteLog('Order004'+ErrFlag,E.Message);
          if E.Message = '연결을 실패했습니다' then
            Common.DBConnectError := True
          else
            Common.DBConnectError := False;
          Common.ErrBox(E.Message+#13#13+'주문내역을 저장하지 못했습니다');
          Exit;
        end;
      end;


      //직전출력 결제 영수증 클리어
      Common.BackupPrintBuffer.Clear;

      if not Common.Table.isWaitTable then
      begin
        Common.WriteLog('work', '주문서 생성');
        SetKitchenOrderData;
      end;
      vTotalDC := Common.PreSent.TotalDC;
      //고객주문서 전체주문내역(마지막주문만 출력한다고 했을때 빼구
      if not Common.Table.isWaitTable and (Common.Table.OrderType <> 'D') and (GetOption(152) <> '1') and (Common.CustomerCancel + Common.CustomerPrinter <> '')  then
        Common.GetAllCustomerOrder;

      Common.PreSent.TotalDC := vTotalDC;
      //프린터 데몬에 주방주문서 내용 전송
      if not Common.Table.isWaitTable then
      begin
        Common.Device.OrderPrint((Common.Table.OrderType <> 'D') and BillPrintMode, KitchenPrintMode);
        //KDS 저장
        if KitchenPrintMode then
          Common.SaveKDSData(false);
      end;

      //배달주문일때
      if Common.Table.OrderType = 'D' then
      begin
        //테이블형태의 배달화면
        if GetOption(368) = '0' then
        begin
          Common.GridToGrid(Main_sGrd, DeliveryInfo_F.Order_sGrd);
          DeliveryInfo_F.lblOrderAmt.Caption := TotalAmtLabel.Caption + '원';
          DeliveryInfo_F.FDcAmount := Common.PreSent.TotalDC;
        end
        else if GetOption(368) = '1' then
        begin
          DeliveryNew_F.FDcAmount := Common.PreSent.TotalDC;
        end;
        OrderMenu := SaveDeliveryAmnt(false, vOrderAmt);

        //배달정보
        if Sender = Action31 then
          ModalResult := mrCancel
        else
          ModalResult := mrOK;
      end;
    finally
      Common.HideWaitForm;
    end;
    Common.WriteLog('work', '주문완료');
    ModalResult := mrOK;
  finally
    BlockInput(false);
    Common.Device.OnScannerReadData := ScannerReadEvent;
    AccountButtonPanel.Enabled := true;
    if Common.Config.IsTakeOut then
      Present_sGrd.SetFocus;
  end;
end;

procedure TOrder_F.Action27Execute(Sender: TObject);
begin
  try
    OrderCancel_F := TOrderCancel_F.Create(Self);          //주문취소폼 생성
    OrderCancel_F.CanMode := cmTableMemo;
    OrderCancel_F.InputEdit.Text := Common.Table.Memo;
    if OrderCancel_F.ShowModal = mrOK then
    begin
      Common.Table.Memo := OrderCancel_F.TableMemo;
    end;
  finally
    FreeAndNil(OrderCancel_F);
  end;
end;

procedure TOrder_F.obtn_PluBackClick(Sender: TObject);
begin
  panPLU.Visible := False;
end;

procedure TOrder_F.Tmr_ChangeTimer(Sender: TObject);
begin
  Tmr_Change.Enabled := False;
  Action20.Execute;
  RcpChange_F.ShowMode := fsmNone;
end;

procedure TOrder_F.Tmr_ClockTimer(Sender: TObject);
begin
  ClockButton.Caption   := FormatDateTime('hh:nn', Now());
end;

procedure TOrder_F.Tmr_MenuShowTimer(Sender: TObject);
begin
  ClockButton.Caption    := FormatDateTime('hh:nn', Now());
  Tmr_MenuShow.Enabled   := false;
  OrderMenuLabel.Visible := false;

  if PresnetPanel.Visible then
  begin
    if Assigned(TAdvShape(FindComponent('PresentShape'))) then
      TAdvShape(FindComponent('PresentShape')).Destroy;

    with TAdvShape.Create(Self) do
    begin
      Name        := 'PresentShape';
      Parent      := Self;
      Top         := Present_sGrd.Top;
      Left        := 5;
      Height      := 129;
      Width       := 36;
      RotationAngle := 180;
      Rounding      := 1;
      Shape       := stRoundRect;
      ShapeHeight := 127;
      ShapeWidth  := 29;
      if Screen.PixelsPerInch = 96 then
         Text        := '<FONT color="#FFFFFF"  size="11" face="맑은 고딕">결<BR>제<BR>내<BR>역</FONT>'
      else if Screen.PixelsPerInch <= 120 then
        Text        := '<FONT color="#FFFFFF"  size="10" face="맑은 고딕">결<BR>제<BR>내<BR>역</FONT>'
      else if Screen.PixelsPerInch <= 150 then
        Text        := '<FONT color="#FFFFFF"  size="9" face="맑은 고딕">결<BR>제<BR>내<BR>역</FONT>'
      else if Screen.PixelsPerInch <= 180 then
        Text        := '<FONT color="#FFFFFF"  size="8" face="맑은 고딕">결<BR>제<BR>내<BR>역</FONT>';

      Appearance.Brush.Style := bsClear;
      Appearance.Direction := AdvShape.gdVertical;
      TextOffsetX  := 6;
      TextOffsetY  := 30;
      if Common.Config.Style = 'B' then
      begin
        Appearance.Color   := $00592D00;
        Appearance.ColorTo := $00AE5700;
      end
      else
      begin
        Appearance.Color   := $00121212;
        Appearance.ColorTo := $00121212;
      end;
      AutoSize    := false;
    end;
  end;
end;

procedure TOrder_F.Act_GiftExecute(Sender: TObject);
var vRtn : String;
begin
  Common.WriteLog('work', '상품권결제');
  if Common.PreSent.WRcvAmt = 0 then
  begin
    Common.ErrBox('받을금액이 없습니다');
    Exit;
  end;

  if Common.Table.AHeadPay then
  begin
    Common.ErrBox('선결제는 신용카드만 가능합니다');
    Exit;
  end;

  vRtn := Common.ShowNumberForm('상품권금액을 입력하세요', 0, 9000000, '0' );

  if vRtn = 'mrClose' then Exit;

  Common.WriteLog('work', '주문정산-상품권('+vRtn+')');
  Common.PreSent.GiftAmt := Common.PreSent.GiftAmt + + StoI(vRtn);
  DisplayPresent;
  if Common.PreSent.WRcvAmt = 0 then
    FinishExecute('14');
end;

procedure TOrder_F.Action28Execute(Sender: TObject);
begin
  Wait_F := TWait_F.Create(Application);
  try
    Wait_F.ShowModal;
  finally
    Application.ProcessMessages;
    FreeAndNil(Wait_F);
  end;
end;

procedure TOrder_F.Action29Execute(Sender: TObject);
begin
  MenuAdd_F := TMenuAdd_F.Create(Self);
  try
    MenuAdd_F.isMenuAdd  := false;
    MenuAdd_F.WorkPluNo  := Common.Config.PluNo;
    MenuAdd_F.ShowModal;
  finally
    FreeAndNil(MenuAdd_F);
  end;
end;

procedure TOrder_F.Action25Execute(Sender: TObject);
begin
  Common.BellCall(0,'');
end;

procedure TOrder_F.Action26Execute(Sender: TObject);
begin
  if not Common.Config.IsTakeOut then
  begin
    Common.ErrBox('선불제일때만 사용이 가능합니다');
    Exit;
  end;
  if WorkKind <> wkRefund then
    WorkKind := wkRefund
  else if WorkKind = wkRefund then
    WorkKind := wkSale;
end;

procedure TOrder_F.Action31Execute(Sender: TObject);
begin
  if not Common.Config.IsTakeOut then
  begin
    Common.MsgBox('선불제 매장일때만 사용이 가능합니다');
    Exit;
  end;
  if Common.Table.OrderType = 'D' then
    Action38Execute(Action31)
  else
    Common.MsgBox('배달주문 중에만 사용이 가능합니다');
end;

procedure TOrder_F.Tmr_TimeTimer(Sender: TObject);
begin
  ClockButton.Caption    := FormatDateTime('hh:nn', Now());
   KioskWorkDateLabel.Caption  := FormatDateTime('mm월dd일(ddd) ampm h:nn', Now());
  if Tmr_KioskWait.Tag > 0 then
  begin
    if GetOption(437) = '1' then
      KioskWorkDateLabel.Badge  := IntToStr(30 - Tmr_KioskWait.Tag)
    else
      KioskWorkDateLabel.Badge  := IntToStr((StrToInt(GetOption(437))-1) * 60 - Tmr_KioskWait.Tag);
  end;


  if Common.Config.IsKiosk and not Common.isBFKiosk and (GetKioskPLU(true) <> KioskPluNo) then
  begin
    Tmr_Time.Enabled := false;
    try
      if not IsDebuggerPresent then
        BlockInput(true);
      Common.Device.OnScannerReadData := nil;
      SetPluClassData;
    finally
      BlockInput(false);
      Common.Device.OnScannerReadData := ScannerReadEvent;
    end;
    Tmr_Time.Enabled := true;
  end;
end;

procedure TOrder_F.Action32Execute(Sender: TObject);
  function Summary_Row: Integer;
  var vRow:Integer;
  begin
     with Order_F.Main_sGrd do
     begin
       For vRow := 0 to Common.Summary_sGrd.RowCount - 1 do
       begin
         if (Cells[GDM_CD_MENU, Row] = Common.Summary_sGrd.Cells[GDM_CD_MENU, vRow])
           and (Cells[GDM_DS_SALE, Row] = Common.Summary_sGrd.Cells[GDM_DS_SALE, vRow])
           and (Cells[GDM_DC_MENU, Row] = Common.Summary_sGrd.Cells[GDM_DC_MENU, vRow])
           and (Cells[GDM_PR_SALE, Row] = Common.Summary_sGrd.Cells[GDM_PR_SALE, vRow])
           and (Cells[GDM_CD_ITEM, Row] = Common.Summary_sGrd.Cells[GDM_CD_ITEM, vRow])
           and (Common.Summary_sGrd.Cells[GDM_CD_MENU1, vRow] = '')
           then
         begin
            Result := vRow;
            Break;
         end;
       end;
     end;
  end;
var
   DCPr, BefDc               :Double;
   liSmry, liRow :Integer;
   lsGood,lsPrSale,lsDsSale  :String;
   vChangePrice :String;
begin
  if Main_sGrd.Cells[0,0] = '' then Exit;
  vChangePrice := Common.ShowNumberForm('변경 할 단가를 입력하세요',7, 0,'');
  if vChangePrice = 'mrClose' then Exit;

  with Common, Main_sGrd do
  begin
    liSmry   := Summary_Row;
    if StoI(Cells[GDM_DC_MENU, liSmry]) > 0 then
    begin
      ErrBox('할인한 상품은 단가를 변경할 수 없습니다');
      Exit;
    end;

    if Cells[GDM_YN_RCP, liSmry] = 'N' then
    begin
      ErrBox('영수증에 출력하지 않는 메뉴는'#13'단가를 변경할 수 없습니다');
      Exit;
    end;
    lsGood   := Cells[GDM_CD_MENU, Row];
    lsPrSale := Cells[GDM_PR_SALE, Row];
    lsDsSale := Cells[GDM_DS_SALE, Row];
    //부가세별도 메뉴는 부가세 10%를 붙인다
    if Cells[GDM_DS_TAX, Row] = '2' then
      vChangePrice := FtoS(StoI(vChangePrice) * 1.1);
    For liRow := 0 to RowCount - 1 do
    begin
     if (lsGood = Cells[GDM_CD_MENU, liRow])
     and (lsPrSale = Cells[GDM_PR_SALE, liRow])
     and (lsDsSale = Cells[GDM_DS_SALE, liRow])
     and (Cells[GDM_CD_MENU1, liRow] = '' ) then
     begin
        Cells[GDM_VIEWPRICE, liRow] := vChangePrice;
        Cells[GDM_PR_SALE, liRow]   := vChangePrice;
        if Cells[GDM_DS_MENU, Row] = 'W' then
          Cells[GDM_AMT, Row]       := Cells[GDM_PR_SALE, liRow]
        else
        Cells[GDM_AMT, Row]       := IntToStr(StoI(vChangePrice) * StoI(Cells[GDM_QTY, liRow]) );
     end;
    end;
    Summary_sGrd.Cells[GDM_PR_SALE, liSmry] := vChangePrice;

    if Summary_sGrd.Cells[GDM_DS_MENU, liSmry] = 'W' then
    begin
     Dcpr := StoI(Summary_sGrd.Cells[GDM_AMT, liSmry]) - (StoI(vChangePrice) );
     Summary_sGrd.Cells[GDM_AMT, liSmry] := vChangePrice;
    end
    else
    begin
      Dcpr := StoI(Summary_sGrd.Cells[GDM_AMT, liSmry]) - (StoI(vChangePrice) *  StoI(Summary_sGrd.Cells[GDM_QTY, liSmry]) );
      Summary_sGrd.Cells[GDM_AMT, liSmry] := IntToStr(StoI(vChangePrice) *  StoI(Summary_sGrd.Cells[GDM_QTY, liSmry]));
      //상품정보의 판매단가를 변경한다
      if GetOption(332) = '1' then
      begin
        if DM.ExecCloud('update MS_MENU '
                    +'   set PR_SALE   =:P3, '
                    +'       PRG_CHANGE   =''POS'', '
                    +'       DT_CHANGE = Now() '
                    +' where CD_HEAD =:P0 '
                    +'   and CD_STORE =:P1 '
                    +'   and CD_MENU  =:P2;',
                    [Common.Config.HeadStoreCode,
                     Common.Config.StoreCode,
                     lsGood,
                     StoI(vChangePrice)],true,Common.RestDBURL) then
          ExecQuery('update MS_MENU '
                   +'   set PR_SALE  =:P2 '
                   +' where CD_STORE =:P0 '
                   +'   and CD_MENU  =:P1',
                   [Common.Config.StoreCode,
                    lsGood,
                    StoI(vChangePrice)]);
      end;
    end;

    Present.TotalAmt := Present.TotalAmt - FtoI(Dcpr);
    DisplayPresent;
  end;
end;

procedure TOrder_F.Action30Execute(Sender: TObject);
  function GetCouponMenu(aMenu:String):Boolean;
  var vRow : Integer;
  begin
    Result := false;
    if Main_sGrd.Cells[0,0] = '' then Exit;
    For vRow :=0 to Main_sGrd.RowCount-1 do
    begin
      //주메뉴만 체크한다
      if (Main_sGrd.Cells[GDM_CD_MENU1, vRow] <> '') then Continue;

      if (Main_sGrd.Cells[GDM_CD_MENU, vRow] = aMenu) then
      begin
        Result := true;
        Break;
      end;
    end;
  end;
var vCouponNo :String;
    vResult :Boolean;
    vResultStr :WideString;
    vDcType :WideString;
    vDcAmt  :Integer;
    vDcLimit :WideString;
    vMenuCode :WideString;
    vRemainQty:Integer;
    vMemberYN:WideString;
begin
  if Common.OrderKind = okChange then
  begin
    Common.ErrBox('결제변경 시에는 사용할 수 없습니다');
    Exit;
  end;

  if Common.OrderKind = okBanpum then
  begin
    Common.ErrBox('반품 시에는 사용할 수 없습니다');
    Exit;
  end;

  try
    vCouponNo := FMenuCode;
    if FMenuCode = EmptyStr then
    begin
      vCouponNo := Common.ShowNumberForm('쿠폰번호를 입력하세요',20);
      if vCouponNo = 'mrClose' then Exit;
    end;

    //영수증당 1장의 쿠폰만 사용가능
    if Common.PreSent.CouponNo <> '' then
    begin
      Common.ErrBox('쿠폰은 중복사용할 수 없습니다');
      Exit;
    end;

    if not DM.OpenCloud('select * '
                +'  from MS_COUPON '
                +' where CD_HEAD   =:P0 '
                +'   and CD_STORE  =:P1 '
                +'   and NO_COUPON =:P2 '
                +'   and DS_STATUS <> ''K'' ',
                [Common.Config.HeadStoreCode,
                 Common.Config.StoreCode,
                 vCouponNo],Common.RestDBURL) then Exit;

    if DM.CloudData.Eof then
    begin
      Common.ErrBox('발행되지 않은 쿠폰입니다');
      Exit;
    end
    else
    begin
      if DM.CloudData.FieldByName('DS_STATUS').AsString = '1' then
      begin
        Common.ErrBox(Format('이미 사용된 쿠폰입니다[%s]',[DM.CloudData.FieldByName('RCP_SALE').AsString]));
        Exit;
      end;
      if DM.CloudData.FieldByName('DS_STATUS').AsString = '2' then
      begin
        Common.ErrBox('폐기 된 쿠폰입니다');
        Exit;
      end;

      if (DM.CloudData.FieldByName('YMD_FROM').AsString <> '') and (DM.CloudData.FieldByName('YMD_TO').AsString <> '') then
      begin
        if DM.CloudData.FieldByName('YMD_FROM').AsString > FormatDateTime('yyyymmdd', now) then
        begin
          Common.ErrBox(Format('사용기간이 아직 안됐습니다[%s~%s]', [DM.CloudData.FieldByName('YMD_FROM').AsString, DM.CloudData.FieldByName('YMD_TO').AsString]));
          Exit;
        end;
        if DM.CloudData.FieldByName('YMD_TO').AsString < FormatDateTime('yyyymmdd', now) then
        begin
          Common.ErrBox(Format('사용기간이 지났습니다[%s~%s]', [DM.CloudData.FieldByName('YMD_FROM').AsString, DM.CloudData.FieldByName('YMD_TO').AsString]));
          Exit;
        end;
      end;

      if (DM.CloudData.FieldByName('DS_TARGET').AsString = 'M') and (Common.Member.Code = '') then
      begin
        Common.ErrBox('회원만 사용가능한 쿠폰입니다');
        Exit;
      end;

      if (DM.CloudData.FieldByName('DS_TARGET').AsString = 'M') and (DM.CloudData.FieldByName('CD_MEMBER').AsString <> Common.Member.Code) then
      begin
        Common.ErrBox('특정 회원만 사용가능한 쿠폰입니다');
        Exit;
      end;

      if DM.CloudData.FieldByName('AMT_SALE_MIN').AsInteger > Common.PreSent.TotalAmt then
      begin
        Common.ErrBox(Format('최소 %s이상 구매해야'#13'사용이 가능한 쿠폰입니다',[FormatFloat(',0원',DM.CloudData.FieldByName('AMT_SALE_MIN').AsInteger)]));
        Exit;
      end;
      Common.PreSent.CouponNo   := vCouponNo;
      Common.PreSent.CouponKind := DM.CloudData.FieldByName('DS_COUPON').AsString;
      Common.PreSent.CouponType := DM.CloudData.FieldByName('COUPON_TYPE').AsString;
      if Common.PreSent.CouponType = 'A' then
      begin
        Common.PreSent.CouponDc   := DM.CloudData.FieldByName('AMT_DC').AsInteger;
        Common.PreSent.CouponRate := 0;
      end
      else
      begin
        Common.PreSent.CouponDc   := 0;
        Common.PreSent.CouponRate := DM.CloudData.FieldByName('AMT_DC').AsInteger;
      end;
      Common.PreSent.CouponSaleAmt   := DM.CloudData.FieldByName('AMT_SALE_MIN').AsInteger;
      Common.PreSent.CouponLimit     := DM.CloudData.FieldByName('AMT_DC_MAX').AsInteger;
      Common.PreSent.CouponMenu      := DM.CloudData.FieldByName('CD_MENU').AsString;
      Common.PreSent.CouponMember    := DM.CloudData.FieldByName('DS_TARGET').AsString = 'M';
      Common.PreSent.CouponMemberNo  := DM.CloudData.FieldByName('CD_MEMBER').AsString;
      DisplayPresent;
    end;
  finally
    DM.CloudData.Close;
    FMenuCode := EmptyStr;
  end;
end;

procedure TOrder_F.Action36Execute(Sender: TObject);
  function GetSummaryGridRow: Integer;
  var vRow:Integer;
  begin
    Result := -1;
     with Main_sGrd, Common.Menu do
     begin
       For vRow := 0 to Common.Summary_sGrd.RowCount - 1 do
       begin
         if (Cells[GDM_CD_MENU, Row] = Common.Summary_sGrd.Cells[GDM_CD_MENU, vRow])
           and (Cells[GDM_DS_SALE, Row] = Common.Summary_sGrd.Cells[GDM_DS_SALE, vRow])
           and (Cells[GDM_PR_SALE, Row] = Common.Summary_sGrd.Cells[GDM_PR_SALE, vRow])
           and ('N' = Common.Summary_sGrd.Cells[GDM_YN_DOUBLE, vRow])
           and (Common.Summary_sGrd.Cells[GDM_CD_MENU1, vRow] = '')
           then
         begin
            Result := vRow;
            Break;
         end;
       end;
     end;
  end;
var vRow :Integer;
begin
  if Common.Member.Code = '' then
  begin
    if Common.ShowMemberForm then
      DisplayPresent
    else
    begin
      Exit;
    end;
  end;

  //스템프를 사용할때는 서버에서 현재스템프를 다시 조회한다
  try
    if not DM.OpenCloud('select TOTAL_STAMP '
                       +'  from MS_MEMBER_ETC '
                       +' where CD_HEAD   =:P0 '
                       +'   and CD_STORE  =:P1 '
                       +'   and CD_MEMBER =:P2 ',
                       [Common.Config.HeadStoreCode,
                        Ifthen(GetHeadOption(5)='0', Common.Config.StoreCode, StandardStore),
                        Common.Member.Code],Common.RestDBURL) then
    begin
      Common.ErrBox('서버와 오프라인 시에는'#13'스탬프를 사용할 수 없습니다');
      Exit;
    end;

    if not DM.CloudData.Eof then
    begin
      ExecQuery('update MS_MEMBER '
               +'   set TOTAL_STAMP = :P2 '
               +' where CD_STORE  =:P0 '
               +'   and CD_MEMBER =:P1 ',
               [Common.Config.StoreCode,
                Common.Member.Code,
                DM.CloudData.Fields[0].AsInteger]);
      Common.Member.Point := DM.CloudData.Fields[0].AsInteger;
    end;
  finally
    DM.CloudData.Close;
  end;

  //스템프 사용방식(메뉴별 할인)
  if GetOption(406)='0' then
  begin
    if (StoI(Main_sGrd.Cells[GDM_USE_STAMP_M, Main_sGrd.Row]) = 0) then
    begin
      Common.MsgBox('스템프를 사용할 수 없는 메뉴입니다');
      Exit;
    end;

    if (StoI(Main_sGrd.Cells[GDM_USE_STAMP,  Main_sGrd.Row]) <> 0) then
    begin
      Common.MsgBox('스템프는 한번만 사용이 가능합니다');
      Exit;
    end;

    if (StoI(Main_sGrd.Cells[GDM_USE_STAMP_M, Main_sGrd.Row]) * StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row])) > (Common.Member.Stamp-Common.PreSent.UseStamp) then
    begin
      Common.MsgBox(Format('스템프가 부족합니다'#13'메뉴 스템프[%d] - 보유 스템프[%d]',[StoI(Main_sGrd.Cells[GDM_USE_STAMP_M, Main_sGrd.Row]) * StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]), (Common.Member.Stamp-Common.PreSent.UseStamp)]));
      Exit;
    end;

    if Common.PreSent.WRcvAmt < (StoI(Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row]) * StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row])) then
    begin
      Common.MsgBox('받을금액이 부족합니다');
      Exit;
    end;

    Main_sGrd.Cells[GDM_DC_STAMP,  Main_sGrd.Row] := IntToStr(StoI(Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row]) * StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]));
    Main_sGrd.Cells[GDM_USE_STAMP, Main_sGrd.Row] := IntToStr(StoI(Main_sGrd.Cells[GDM_USE_STAMP_M, Main_sGrd.Row]) * StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]));
    Common.PreSent.StampDc  := Common.PreSent.StampDc + StoI(Main_sGrd.Cells[GDM_PR_SALE, Main_sGrd.Row]) * StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]);
    Common.PreSent.UseStamp := Common.PreSent.UseStamp + StoI(Main_sGrd.Cells[GDM_USE_STAMP_M, Main_sGrd.Row]) * StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]);
    vRow := GetSummaryGridRow;
    Common.Summary_sGrd.Cells[GDM_DC_STAMP, vRow]  := Main_sGrd.Cells[GDM_DC_STAMP, Main_sGrd.Row];
    Common.Summary_sGrd.Cells[GDM_USE_STAMP, vRow] := Main_sGrd.Cells[GDM_USE_STAMP, Main_sGrd.Row];
    DisplayPresent;
    Common.MsgBox(Format('스템프가 %d개 차감되었습니다',[Common.PreSent.UseStamp]));
  end
  //스템프 사용방식(금액 할인)
  else
  begin
    if (Main_sGrd.Cells[GDM_DS_SALE, Main_sGrd.Row] = 'D') or (Main_sGrd.Cells[GDM_CD_MENU1, Main_sGrd.Row] <> '') then
    begin
      Common.MsgBox('스템프를 사용할 수 없는 메뉴입니다');
      Exit;
    end;
    if Common.PreSent.WRcvAmt < Common.Config.SetStampDc then
    begin
      Common.MsgBox('받을금액이 부족합니다');
      Exit;
    end;
    if (Common.Member.Stamp-Common.PreSent.UseStamp) < Common.Config.SetStampCount then
    begin
      Common.MsgBox('스템프가 부족합니다');
      Exit;
    end;

    if StoI(Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row]) < ((StoI(Main_sGrd.Cells[GDM_USE_STAMP, Main_sGrd.Row]) div Common.Config.SetStampCount)+1) then
    begin
      Common.MsgBox('메뉴 수량보다 많이 사용할 수 없습니다');
      Exit;
    end;

    Main_sGrd.Cells[GDM_DC_STAMP,  Main_sGrd.Row]  := IntToStr(StoI(Main_sGrd.Cells[GDM_DC_STAMP,  Main_sGrd.Row]) + Common.Config.SetStampDc);
    Main_sGrd.Cells[GDM_USE_STAMP, Main_sGrd.Row]  := IntToStr(StoI(Main_sGrd.Cells[GDM_USE_STAMP, Main_sGrd.Row]) + Common.Config.SetStampCount);
    Common.PreSent.StampDc  := Common.PreSent.StampDc  + Common.Config.SetStampDc;
    Common.PreSent.UseStamp := Common.PreSent.UseStamp + Common.Config.SetStampCount;
    vRow := GetSummaryGridRow;
    Common.Summary_sGrd.Cells[GDM_DC_STAMP, vRow]  := IntToStr(StoI(Common.Summary_sGrd.Cells[GDM_DC_STAMP, vRow]) + Common.Config.SetStampDc);
    Common.Summary_sGrd.Cells[GDM_USE_STAMP, vRow] := IntToStr(StoI(Common.Summary_sGrd.Cells[GDM_USE_STAMP, vRow]) + Common.Config.SetStampCount);
    DisplayPresent;
  end;
end;

procedure TOrder_F.Tmr_ICTimer(Sender: TObject);
begin
  Tmr_IC.Enabled := false;
  if Common.PreSent.WRcvAmt > 0 then
  begin
    Act_Card.Execute;
    IsExecuteCard := False;
    Common.DetectData := EmptyStr;
  end
  else
  begin
    Common.DetectData := EmptyStr;
  end;
end;

procedure TOrder_F.Action33Execute(Sender: TObject);
var vCount :Integer;
    vTemp  :String;
begin
  if Common.Config.IsTakeOut and (Common.Table.OrderType <> 'D') then
  begin
    Common.ErrBox('선불제에서는 사용할 수 없습니다');
    Exit;
  end;

  if not (Common.OrderKind in [okNew,okAppend]) then
  begin
    Common.ErrBox('현재 상태에서는 할 수 없습니다');
    Exit;
  end;

  if Common.PreSent.TipAmt > 0 then
  begin
    Common.ErrBox('봉사료가 있으면 사용할 수 없습니다');
    Exit;
  end;

  vTemp := Common.ShowNumberForm('인원수를 입력하세요',0,99);
  if vTemp = 'mrClose' then Exit;
  vCount := StoI(vTemp);

  if vCount <= 1 then
  begin
    Common.PreSent.DutchPayAmt := 0;
    Exit;
  end;

  if (Common.PreSent.WRcvAmt div vCount) < 1000 then
  begin
    Common.ErrBox('1,000원미만으로 더치페이를 할 수 없습니다');
    Exit;
  end;

  Common.PreSent.DutchPayAmt := Common.PreSent.WRcvAmt div vCount;
  Common.PreSent.DutchPayAmt := Common.PreSent.DutchPayAmt - AmtofCut(Common.PreSent.DutchPayAmt,0);
  Common.MsgBox(Format('더치페이 금액은 %s 입니다',[FormatFloat('#,0원', Common.PreSent.DutchPayAmt)]));
  DuthPayLabel.Visible       := true;
  DuthPayLabel.Caption       := Format('%s[%d명]',[FormatFloat('#,0원', Common.PreSent.DutchPayAmt), vCount]);
end;

procedure TOrder_F.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if IsEnter then
  begin
    Key := #0;
    Exit;
  end;
  //마감 상태였으면 초기화한다
  if WorkState = wsMagam then WorkState := wsReady;
  if Key in ['0','1','2','3','4','5','6','7','8','9','=','?','-',';',
             'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
             'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'] then
  begin
    FMsrData := FMsrData + Key;
    if (FMsrData <> '') then
    begin
      InputEdit.Visible := true;
      InputEdit.Text    := FMsrData;
    end
    else
    begin
      InputEdit.Visible := false;
      InputEdit.Text    := '';
    end;
  end;
end;

procedure TOrder_F.Action34Execute(Sender: TObject);
begin
  Booking_F := TBooking_F.Create(self);
  Booking_F.WorkType := wtNone;
  try
    Booking_F.ShowModal;
  finally
    FreeAndNil(Booking_F);
  end;
end;

procedure TOrder_F.Action35Execute(Sender: TObject);
var vIndex, vIndex2 :Integer;
begin
  for vIndex := Low(FunctionButton) to High(FunctionButton) do
  begin
    for vIndex2 := Low(FunctionButton[vIndex]) to High(FunctionButton[vIndex]) do
    begin
      if FunctionButton[vIndex][vIndex2].Hint = Action35.Hint then
      begin
        if Action35.Tag = 0 then
        begin
          if not FunctionButton[vIndex][vIndex2].Picture.Empty then
            FunctionButton[vIndex][vIndex2].Picture.Assign(ImageCollection.Items[6].Picture)// := Function34Button.PictureDisabled
          else
            FunctionButton[vIndex][vIndex2].Caption := '다중모드(X)';
          Action35.Tag := 1;
          Common.Config.Options[60] := '0';
          Break;
        end
        else
        begin
          if not FunctionButton[vIndex][vIndex2].Picture.Empty then
            FunctionButton[vIndex][vIndex2].Picture.Assign(FunctionImageCollection.Items[34].Picture) // := Function34Button.Picture
          else
            FunctionButton[vIndex][vIndex2].Caption := '다중모드(O)';
          Action35.Tag := 0;
          Common.Config.Options[60] := '1';
          Break;
        end;
      end;
      ClickTime         := IncSecond(Now,-3);
    end;
  end;
end;

procedure TOrder_F.OrderListView;
  function GetMenuQty(aMenuCode:String):Integer;
  var vIndex :Integer;
  begin
    Result := 0;
    for vIndex := 0 to Main_sGrd.RowCount-1 do
    begin
      if (Main_sGrd.Cells[GDM_CD_MENU1, vIndex] = '') and (aMenuCode = Main_sGrd.Cells[GDM_CD_MENU, vIndex]) then
        Result := Result + StoI(Main_sGrd.Cells[GDM_QTY, vIndex]);
    end;

  end;
var vIndex, vRowIndex, vSeq,
    vSubMenuHeight :Integer;
    vPos: SmallInt;
begin
  for vIndex := 0 to High(KioskOrderMenu) do
  begin
    tmpKioskOrderMenu[vIndex].GroupBox.Visible    := KioskOrderMenu[vIndex].GroupBox.Visible;
    tmpKioskOrderMenu[vIndex].GroupBox.Height     := KioskOrderMenu[vIndex].GroupBox.Height;
    tmpKioskOrderMenu[vIndex].MainMenu.Caption    := KioskOrderMenu[vIndex].MainMenu.Caption;
    tmpKioskOrderMenu[vIndex].SubMenu.Height      := KioskOrderMenu[vIndex].SubMenu.Height;
    if GetOption(28) = '1' then
    begin
      tmpKioskOrderMenu[vIndex].MenuPrice.Visible   := KioskOrderMenu[vIndex].MenuPrice.Visible;
      tmpKioskOrderMenu[vIndex].MenuPrice.Caption   := KioskOrderMenu[vIndex].MenuPrice.Caption;
    end;
    tmpKioskOrderMenu[vIndex].SubMenu.Visible     := KioskOrderMenu[vIndex].SubMenu.Visible;
    tmpKioskOrderMenu[vIndex].SubMenu.Caption     := KioskOrderMenu[vIndex].SubMenu.Caption;
  end;


  vSubMenuHeight := (KioskOrderMenuPanel.Font.Size-4) * 2;
  for vIndex := 0 to High(tmpKioskOrderMenu) do
  begin
    tmpKioskOrderMenu[vIndex].GroupBox.Visible  := false;
    tmpKioskOrderMenu[vIndex].GroupBox.Height   := 0;
    tmpKioskOrderMenu[vIndex].MainMenu.Caption  := '';
    tmpKioskOrderMenu[vIndex].SubMenu.Height    := 0;
    tmpKioskOrderMenu[vIndex].SubMenu.Visible   := false;
    tmpKioskOrderMenu[vIndex].SubMenu.Caption   := EmptyStr;
    if GetOption(28) = '1' then
    begin
      tmpKioskOrderMenu[vIndex].MenuPrice.Visible   := false;
      tmpKioskOrderMenu[vIndex].MenuPrice.Caption   := EmptyStr;
    end;
  end;

  for vIndex := 0 to High(KioskButtonList) do
    KioskButtonList[vIndex].Qty.Caption := '';

  vIndex := -1;
  if Main_sGrd.Cells[0,0] <> '' then
    For vRowIndex := 0 to Main_sGrd.RowCount-1 do
    begin
      if vIndex >= High(tmpKioskOrderMenu) then Break;
      if Main_sGrd.Cells[GDM_CD_MENU1, vRowIndex] = '' then
      begin
        vIndex := vIndex+1;
        tmpKioskOrderMenu[vIndex].GroupBox.Visible  := true;
        tmpKioskOrderMenu[vIndex].AddButton.Visible    := true;
        tmpKioskOrderMenu[vIndex].AddButton.Tag        := vRowIndex;
        tmpKioskOrderMenu[vIndex].CancelButton.Visible := true;
        tmpKioskOrderMenu[vIndex].CancelButton.Tag     := vRowIndex;
        if LeftStr(Main_sGrd.Cells[GDM_NM_MENU, vRowIndex],6) = Common.Config.PackingTxt then
          tmpKioskOrderMenu[vIndex].MainMenu.Caption     := Common.GetPaPago(Replace(Main_sGrd.Cells[GDM_NM_MENU, vRowIndex],Common.Config.PackingTxt,''))
        else
          tmpKioskOrderMenu[vIndex].MainMenu.Caption     := Common.GetPaPago(Main_sGrd.Cells[GDM_NM_MENU, vRowIndex]);
        //주문 메뉴에 단가를 표시합니다.
        if GetOption(28) = '1' then
          tmpKioskOrderMenu[vIndex].MenuPrice.Caption  := FormatFloat('￦ ,0',StoI(Main_sGrd.Cells[GDM_VIEWPRICE, vRowIndex]));
        tmpKioskOrderMenu[vIndex].OrderQty.Caption     := Main_sGrd.Cells[GDM_VIEWQTY, vRowIndex];
        tmpKioskOrderMenu[vIndex].GroupBox.Height      := tmpKioskOrderMenu[vIndex].MainMenu.Height + 4;
        tmpKioskOrderMenu[vIndex].SubMenu.Caption      := '';
        tmpKioskOrderMenu[vIndex].SubMenu.Height       := 0;
        SetKioskMenuButtonStatus(Main_sGrd.Cells[GDM_CD_MENU, vRowIndex], IntToStr(GetMenuQty(Main_sGrd.Cells[GDM_CD_MENU, vRowIndex])));
      end
      else
      begin
        tmpKioskOrderMenu[vIndex].SubMenu.Height    := tmpKioskOrderMenu[vIndex].SubMenu.Height + vSubMenuHeight;

        if tmpKioskOrderMenu[vIndex].SubMenu.Caption <> '' then
        begin
          if (Main_sGrd.Cells[GDM_VIEWQTY, vRowIndex] = '1') and (StoI(Main_sGrd.Cells[GDM_VIEWPRICE, vRowIndex]) = 0) then
            tmpKioskOrderMenu[vIndex].SubMenu.Caption := Common.GetPaPago(tmpKioskOrderMenu[vIndex].SubMenu.Caption)+#13+Format('  %s ',[Common.GetPaPago(Main_sGrd.Cells[GDM_NM_MENU, vRowIndex])])
          else if (Main_sGrd.Cells[GDM_VIEWQTY, vRowIndex] = '1') and (StoI(Main_sGrd.Cells[GDM_VIEWPRICE, vRowIndex]) > 0) then
            tmpKioskOrderMenu[vIndex].SubMenu.Caption := Common.GetPaPago(tmpKioskOrderMenu[vIndex].SubMenu.Caption)+#13+Format('  %s  %s',[Common.GetPaPago(Main_sGrd.Cells[GDM_NM_MENU, vRowIndex]),FormatFloat('￦,0',StoI(Main_sGrd.Cells[GDM_VIEWPRICE, vRowIndex]))])
          else if (Main_sGrd.Cells[GDM_VIEWQTY, vRowIndex] <> '1') and (StoI(Main_sGrd.Cells[GDM_VIEWPRICE, vRowIndex]) = 0) then
            tmpKioskOrderMenu[vIndex].SubMenu.Caption := Common.GetPaPago(tmpKioskOrderMenu[vIndex].SubMenu.Caption)+#13+Format('  %s  ( %s )',[Common.GetPaPago(Main_sGrd.Cells[GDM_NM_MENU, vRowIndex]),Main_sGrd.Cells[GDM_VIEWQTY, vRowIndex]])
          else
            tmpKioskOrderMenu[vIndex].SubMenu.Caption := Common.GetPaPago(tmpKioskOrderMenu[vIndex].SubMenu.Caption)+#13+Format('  %s  ( %s ) %s',[Common.GetPaPago(Main_sGrd.Cells[GDM_NM_MENU, vRowIndex]),Main_sGrd.Cells[GDM_VIEWQTY, vRowIndex],FormatFloat('￦,0',StoI(Main_sGrd.Cells[GDM_VIEWPRICE, vRowIndex]))]);
        end
        else
        begin
          if (Main_sGrd.Cells[GDM_VIEWQTY, vRowIndex] = '1') and (StoI(Main_sGrd.Cells[GDM_VIEWPRICE, vRowIndex]) = 0) then
            tmpKioskOrderMenu[vIndex].SubMenu.Caption := Format('  %s ',[Common.GetPaPago(Main_sGrd.Cells[GDM_NM_MENU, vRowIndex])])
          else if (Main_sGrd.Cells[GDM_VIEWQTY, vRowIndex] = '1') and (StoI(Main_sGrd.Cells[GDM_VIEWPRICE, vRowIndex]) > 0) then
            tmpKioskOrderMenu[vIndex].SubMenu.Caption := Format('  %s  %s',[Common.GetPaPago(Main_sGrd.Cells[GDM_NM_MENU, vRowIndex]), FormatFloat('￦,0',StoI(Main_sGrd.Cells[GDM_VIEWPRICE, vRowIndex]))])
          else if (Main_sGrd.Cells[GDM_VIEWQTY, vRowIndex]<> '1') and (StoI(Main_sGrd.Cells[GDM_VIEWPRICE, vRowIndex]) = 0) then
            tmpKioskOrderMenu[vIndex].SubMenu.Caption := Format('  %s  ( %s )',[Common.GetPaPago(Main_sGrd.Cells[GDM_NM_MENU, vRowIndex]), Main_sGrd.Cells[GDM_VIEWQTY, vRowIndex]])
          else
            tmpKioskOrderMenu[vIndex].SubMenu.Caption := Format('  %s  ( %s ) %s',[Common.GetPaPago(Main_sGrd.Cells[GDM_NM_MENU, vRowIndex]),Main_sGrd.Cells[GDM_VIEWQTY, vRowIndex], FormatFloat('￦,0',StoI(Main_sGrd.Cells[GDM_VIEWPRICE, vRowIndex]))]) ;
        end;
        tmpKioskOrderMenu[vIndex].SubMenu.Visible   := true;
        tmpKioskOrderMenu[vIndex].GroupBox.Height   := tmpKioskOrderMenu[vIndex].MainMenu.Height + tmpKioskOrderMenu[vIndex].SubMenu.Height + 4;
      end;
    end;

  for vIndex := 0 to High(tmpKioskOrderMenu) do
  begin
    if  (KioskOrderMenu[vIndex].GroupBox.Height <> tmpKioskOrderMenu[vIndex].GroupBox.Height)
     or (KioskOrderMenu[vIndex].MainMenu.Caption <> tmpKioskOrderMenu[vIndex].MainMenu.Caption)
     or (KioskOrderMenu[vIndex].SubMenu.Height <> tmpKioskOrderMenu[vIndex].SubMenu.Height)
     or (KioskOrderMenu[vIndex].SubMenu.Caption <> tmpKioskOrderMenu[vIndex].SubMenu.Caption) then

    KioskOrderMenu[vIndex].GroupBox.Visible     := true;
    KioskOrderMenu[vIndex].AddButton.Visible    := true;
    KioskOrderMenu[vIndex].AddButton.Tag        := tmpKioskOrderMenu[vIndex].AddButton.Tag;
    KioskOrderMenu[vIndex].CancelButton.Visible := true;
    KioskOrderMenu[vIndex].CancelButton.Tag     := tmpKioskOrderMenu[vIndex].CancelButton.Tag;
    KioskOrderMenu[vIndex].GroupBox.Height      := tmpKioskOrderMenu[vIndex].GroupBox.Height;
    KioskOrderMenu[vIndex].MainMenu.Caption     := tmpKioskOrderMenu[vIndex].MainMenu.Caption;
    KioskOrderMenu[vIndex].SubMenu.Visible      := tmpKioskOrderMenu[vIndex].SubMenu.Visible;
    KioskOrderMenu[vIndex].SubMenu.Height       := tmpKioskOrderMenu[vIndex].SubMenu.Height;
    KioskOrderMenu[vIndex].SubMenu.Caption      := tmpKioskOrderMenu[vIndex].SubMenu.Caption;
    if GetOption(28) = '1' then
      KioskOrderMenu[vIndex].MenuPrice.Caption    := tmpKioskOrderMenu[vIndex].MenuPrice.Caption;
    KioskOrderMenu[vIndex].OrderQty.Caption     := tmpKioskOrderMenu[vIndex].OrderQty.Caption;
  end;
end;

procedure TOrder_F.KioskClassPLUCreate;
var vIndex,
    vIndex1,
    vHeight,
    vWidth,
    vX,
    vCount,
    vGap,
    vLeft  :Integer;
begin
  if not KioskPLUClassPanel.Visible then Exit;
  vX := Common.KioskConfig[2];
  vX := Ifthen(vX < 3, 3, vX);

  vWidth   := KioskPLUClassPanel.Width div vX - 15;
  vHeight  := KioskPLUClassPanel.Height;

  vCount     := 1;
  vGap       := 15;

  with TIniFile.Create(Common.AppPath+'Kiosk\KioskConfig.ini') do
    try
      if ReadString('주문', 'Class_Color', '') = '' then
      begin
        KioskClass.Color             := KioskPLUClassPanel.StatusBar.Color;
        KioskClass.DownColor         := KioskPLUClassPanel.StatusBar.ColorTo;
        KioskClass.BorderColor       := KioskPLUClassPanel.StatusBar.Color;
        KioskClass.BorderDownColor   := KioskPLUClassPanel.StatusBar.Color;
        KioskClass.FontColor         := KioskPLUClassPanel.Font.Color;
        KioskClass.FontDownColor     := KioskPLUClassPanel.CollapsColor;
        KioskClass.Round             := 30;
      end
      else
      begin
        KioskClass.Color             := StringToColor(ReadString('주문', 'Class_Color',ColorToString(KioskPLUClassPanel.StatusBar.Color)));
        KioskClass.DownColor         := StringToColor(ReadString('주문', 'Class_DownColor',ColorToString(KioskPLUClassPanel.StatusBar.ColorTo)));
        KioskClass.BorderColor       := StringToColor(ReadString('주문', 'Class_BorderColor',ColorToString(KioskPLUClassPanel.StatusBar.Color)));
        KioskClass.BorderDownColor   := StringToColor(ReadString('주문', 'Class_BorderDownColor',ColorToString(KioskPLUClassPanel.StatusBar.Color)));
        KioskClass.FontColor         := StringToColor(ReadString('주문', 'Class_FontColor',ColorToString(KioskPLUClassPanel.Font.Color)));
        KioskClass.FontDownColor     := StringToColor(ReadString('주문', 'Class_FontDownColor',ColorToString(KioskPLUClassPanel.CollapsColor)));
        KioskClass.Round             := ReadInteger('주문', 'Class_Round', 30);

        KioskClassPriorButton.Color                  := KioskClass.DownColor;
        KioskClassPriorButton.BorderColor            := KioskClass.BorderColor;
        KioskClassPriorButton.BorderInnerColor       := KioskClass.BorderColor;
        KioskClassPriorButton.Appearance.Font.Color  := KioskClass.FontColor;
        KioskClassPriorButton.ColorDisabled          := KioskClass.Color ;

        KioskClassNextButton.Color                   := KioskClass.DownColor;
        KioskClassNextButton.BorderColor             := KioskClass.BorderColor;
        KioskClassNextButton.BorderInnerColor        := KioskClass.BorderColor;
        KioskClassNextButton.Appearance.Font.Color   := KioskClass.FontColor;
        KioskClassNextButton.ColorDisabled           := KioskClass.Color ;

        KioskMenuPriorButton.Color                   := KioskClass.DownColor;
        KioskMenuPriorButton.BorderColor             := KioskClass.BorderColor;
        KioskMenuPriorButton.BorderInnerColor        := KioskClass.BorderColor;
        KioskMenuPriorButton.Appearance.Font.Color   := KioskClass.FontColor;
        KioskMenuPriorButton.ColorDisabled           := KioskClass.Color ;

        KioskMenuNextButton.Color                    := KioskClass.DownColor;
        KioskMenuNextButton.BorderColor              := KioskClass.BorderColor;
        KioskMenuNextButton.BorderInnerColor         := KioskClass.BorderColor;
        KioskMenuNextButton.Appearance.Font.Color    := KioskClass.FontColor;
        KioskMenuNextButton.ColorDisabled            := KioskClass.Color ;
      end;
    finally
      Free;
    end;

  vLeft := KioskPLUClassPanel.Left;
  For vIndex := 0 to vX-1 do
  begin
    with TAdvSmoothToggleButton.Create(Self) do
    begin
      Parent                  := KioskPanel;
      Left                    := vLeft;
      Top                     := KioskPLUClassPanel.Top;
      Height                  := vHeight;
      Width                   := vWidth;
      Name                    := Format('obtn_KioskClass%d',[vCount]);
      Caption                 := EmptyStr;
      Appearance.Font         := KioskPLUClassPanel.Font;
      Appearance.Font.Color   := KioskClass.FontColor;
      Appearance.Font.Style   := KioskPLUClassPanel.Font.Style;
      Appearance.FocusColor   := clWhite;
      Appearance.SimpleLayout := true;
      Appearance.Spacing      := 1;
      Appearance.Rounding     := KioskClass.Round;
      BevelWidth              := 0;
      ShowFocus               := false;
      Color                   := KioskClass.Color;
      ColorDown               := KioskClass.DownColor;
      BorderColor             := KioskClass.BorderColor;
      BorderInnerColor        := KioskClass.BorderColor;
      Tag                     := vCount;
      OnClick                 := obtn_KioskClass1Click;
      Inc(vCount);
    end;
    vLeft := vLeft + vWidth + 15;
  end;
  KioskPLUClassPanel.Width   := 0;
end;

procedure TOrder_F.KioskFlagButtonClick(Sender: TObject);
var vIndex, vHeight :Integer;
begin
  if KioskFlagAlwaysShow and (Sender = KioskWaitFlagButton) then
  begin
    ThaiButtonClick(KioskWaitFlagButton);
    Exit;
  end;
  FlagPanel.Visible  := true;
  FlagPanel.BringToFront;
  FlagKoreaButton.Picture.Assign(FlageCollection.Items.Items[9].Picture.Graphic);
  FlagUsaButton.Picture.Assign(FlageCollection.Items.Items[10].Picture.Graphic);
  FlagChinaButton.Picture.Assign(FlageCollection.Items.Items[11].Picture.Graphic);
  FlagJapanButton.Picture.Assign(FlageCollection.Items.Items[12].Picture.Graphic);
  FlagfVitnamButton.Picture.Assign(FlageCollection.Items.Items[13].Picture.Graphic);
  FlagThaiButton.Picture.Assign(FlageCollection.Items.Items[14].Picture.Graphic);
  FlagIndoButton.Picture.Assign(FlageCollection.Items.Items[15].Picture.Graphic);
  FlagFrenchButton.Picture.Assign(FlageCollection.Items.Items[16].Picture.Graphic);
  FlagGermanButton.Picture.Assign(FlageCollection.Items.Items[17].Picture.Graphic);

  Flag1Panel.Visible  := Copy(Common.Config.UseLanguage,1,1) = '1';
  Flag2Panel.Visible  := Copy(Common.Config.UseLanguage,2,1) = '1';
  Flag3Panel.Visible  := Copy(Common.Config.UseLanguage,3,1) = '1';
  Flag4Panel.Visible  := Copy(Common.Config.UseLanguage,4,1) = '1';
  Flag5Panel.Visible  := Copy(Common.Config.UseLanguage,5,1) = '1';
  Flag6Panel.Visible  := Copy(Common.Config.UseLanguage,6,1) = '1';
  Flag7Panel.Visible  := Copy(Common.Config.UseLanguage,7,1) = '1';
  Flag8Panel.Visible  := Copy(Common.Config.UseLanguage,8,1) = '1';

  vHeight := 0;
  for vIndex := 0 to 8 do
    if TPanel(FindComponent(Format('Flag%dPanel',[vIndex]))).Visible then
      vHeight := vHeight + 88;

  FlagPanel.Height    := vHeight;
  FlagPanel.Left      := KioskPanel.Width div 2  - FlagPanel.Width div 2;
  FlagPanel.Top       := KioskPanel.Height div 2 - FlagPanel.Height div 2;

  KioskPanel.Enabled := false;
end;

procedure TOrder_F.KioskMenuNextButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  if Assigned(KioskBillInfo_F) then
  begin
    if KioskBillInfo_F.Showing then
      KioskBillInfo_F.Hide;
  end;
  if (Sender = KioskClassPriorButton) then
    KioskClassPage := KioskClassPage - 1
  else if (Sender = KioskClassNextButton) then
    KioskClassPage := KioskClassPage + 1
  else if Sender = KioskMenuPriorButton then
    KioskPage := KioskPage - 1
  else if Sender = KioskMenuNextButton then
    KioskPage := KioskPage + 1;
end;

procedure TOrder_F.KioskMenuPLUCreate;
var vIndex,
    vIndex1,
    vHeight,
    vWidth,
    vX, vX1,
    vY, vY1,
    vCount,
    vBottomMagin  :Integer;
begin
  if not KioskPLUMenuPanel.Visible then Exit;

  vX := Common.KioskConfig[3];
  vY := Common.KioskConfig[4];

  vX := Ifthen(vX < 1, 1, vX);
  vY := Ifthen(vY < 1, 1, vY);

  vWidth  := KioskPLUMenuPanel.Width  div vX - (Common.KioskConfig[10] div 2);
  vHeight := KioskPLUMenuPanel.Height div vY - (Common.KioskConfig[10] div 2);

  KioskPluWidth  := vWidth;
  KioskPluHeight := vHeight;

  SetLength(KioskButtonList, KioskMenuCount);
  vCount := 0;
  For vIndex := 1 to vY do
  begin
    For vIndex1 := 1 to vX do
    begin
      KioskButtonList[vCount].GroupBox                   := TAdvPanel.Create(Self);
      KioskButtonList[vCount].GroupBox.Parent            := KioskPanel;
      KioskButtonList[vCount].GroupBox.Align             := alNone;
      KioskButtonList[vCount].GroupBox.BevelOuter        := bvNone;
      KioskButtonList[vCount].GroupBox.Color             := clWhite;
      KioskButtonList[vCount].GroupBox.BorderColor       := $00393939;
      KioskButtonList[vCount].GroupBox.TextVAlign        := tvaBottom;
      KioskButtonList[vCount].GroupBox.BorderWidth       := 0;

      KioskButtonList[vCount].GroupBox.Width             := vWidth;
      KioskButtonList[vCount].GroupBox.Height            := vHeight;
      KioskButtonList[vCount].GroupBox.Visible           := true;
      KioskButtonList[vCount].GroupBox.Top               := ((vIndex-1) * vHeight)  + (vIndex  * (Common.KioskConfig[10] div 2)) + KioskPLUMenuPanel.Top;
      KioskButtonList[vCount].GroupBox.Left              := ((vIndex1-1) * vWidth)  + (vIndex1 * (Common.KioskConfig[10] div 2)) + KioskPLUMenuPanel.Left;
      KioskButtonList[vCount].GroupBox.Name              := Format('obtn_KioskPlu%d',[vCount]);
      KioskButtonList[vCount].GroupBox.Visible           := true;
      KioskButtonList[vCount].GroupBox.OnDblClick        := KioskMenuPlu1Click;
      KioskButtonList[vCount].GroupBox.OnClick           := KioskMenuPlu1Click;
      KioskButtonList[vCount].MenuCode := '';
      KioskButtonList[vCount].GroupBox.Tag               := vCount;

      KioskButtonList[vCount].MenuImage                  := TcxImage.Create(Self);
      KioskButtonList[vCount].MenuImage.Parent           := KioskButtonList[vCount].GroupBox;
      KioskButtonList[vCount].MenuImage.Top              := 0;
      KioskButtonList[vCount].MenuImage.Left             := 0;
      KioskButtonList[vCount].MenuImage.Width            := vWidth-2;
      KioskButtonList[vCount].MenuImage.Height           := vHeight - Common.KioskConfig[8];
      if Common.KioskConfig[6] = 0 then
        KioskButtonList[vCount].MenuImage.Style.BorderStyle := ebsNone;
      KioskButtonList[vCount].MenuImage.Properties.FitMode := ifmStretch;
      KioskButtonList[vCount].MenuImage.Properties.GraphicClassName := 'TdxPNGImage';
      KioskButtonList[vCount].MenuImage.Visible          := true;
      KioskButtonList[vCount].MenuImage.Transparent      := true;
      KioskButtonList[vCount].MenuImage.Tag              := vCount;
      KioskButtonList[vCount].MenuImage.OnClick          := KioskMenuPlu1Click;
      KioskButtonList[vCount].MenuImage.Properties.PopupMenuLayout.MenuItems := [];
      KioskButtonList[vCount].MenuImage.Properties.ShowFocusRect := false;

      KioskButtonList[vCount].EventImage                     := TcxImage.Create(Self);
      KioskButtonList[vCount].EventImage.Parent              := KioskButtonList[vCount].GroupBox;
      KioskButtonList[vCount].EventImage.Top                 := 0;
      KioskButtonList[vCount].EventImage.Left                := 0;
      KioskButtonList[vCount].EventImage.Width               := 60;
      KioskButtonList[vCount].EventImage.Height              := 60;
      KioskButtonList[vCount].EventImage.Style.BorderStyle   := ebsNone;
      KioskButtonList[vCount].EventImage.Properties.FitMode  := ifmStretch;
      KioskButtonList[vCount].EventImage.Properties.GraphicClassName := 'TdxPNGImage';
      KioskButtonList[vCount].EventImage.Visible             := true;
      KioskButtonList[vCount].EventImage.Transparent         := true;
      KioskButtonList[vCount].EventImage.Tag                 := vCount;
      KioskButtonList[vCount].EventImage.OnClick             := KioskMenuPlu1Click;
      KioskButtonList[vCount].EventImage.Properties.PopupMenuLayout.MenuItems := [];
      KioskButtonList[vCount].EventImage.Properties.ShowFocusRect := false;

      KioskButtonList[vCount].DisableImage                  := TcxImage.Create(Self);
      KioskButtonList[vCount].DisableImage.Parent           := KioskButtonList[vCount].GroupBox;
      KioskButtonList[vCount].DisableImage.Top              := 0;
      KioskButtonList[vCount].DisableImage.Left             := 0;
      KioskButtonList[vCount].DisableImage.Width            := vWidth-2;
      KioskButtonList[vCount].DisableImage.Height           := vHeight - Common.KioskConfig[8];
      KioskButtonList[vCount].DisableImage.Style.BorderStyle := ebsNone;
      KioskButtonList[vCount].DisableImage.Properties.FitMode := ifmStretch;
      KioskButtonList[vCount].DisableImage.Properties.GraphicClassName := 'TdxPNGImage';
      KioskButtonList[vCount].DisableImage.Visible          := false;
      KioskButtonList[vCount].DisableImage.Transparent      := true;
      KioskButtonList[vCount].DisableImage.Tag              := vCount;
      KioskButtonList[vCount].DisableImage.OnClick          := KioskMenuPlu1Click;
      KioskButtonList[vCount].DisableImage.Properties.PopupMenuLayout.MenuItems := [];
      KioskButtonList[vCount].DisableImage.Properties.ShowFocusRect := false;

      KioskButtonList[vCount].Qty                            := TcxLabel.Create(Self);
      KioskButtonList[vCount].Qty.Parent                     := KioskButtonList[vCount].GroupBox;
      KioskButtonList[vCount].Qty.Top                        := 0;
      KioskButtonList[vCount].Qty.Left                       := vWidth-30;
      KioskButtonList[vCount].Qty.Caption                    := '';
      KioskButtonList[vCount].Qty.Style.Font.Size            := 18;
      KioskButtonList[vCount].Qty.Transparent                := true;
      KioskButtonList[vCount].Qty.Style.Font.Color           := KioskPLUMenuPanel.Font.Color;
      KioskButtonList[vCount].Qty.BringToFront;

      KioskButtonList[vCount].OrderTime                      := TcxLabel.Create(Self);
      KioskButtonList[vCount].OrderTime.Parent               := KioskButtonList[vCount].GroupBox;
      KioskButtonList[vCount].OrderTime.AutoSize             := false;
      KioskButtonList[vCount].OrderTime.Properties.Alignment.Horz := taCenter;
      KioskButtonList[vCount].OrderTime.Properties.Alignment.Vert := taVCenter;
      KioskButtonList[vCount].OrderTime.Top                  := 0;
      KioskButtonList[vCount].OrderTime.Left                 := 0;
      KioskButtonList[vCount].OrderTime.Width                := vWidth;
      KioskButtonList[vCount].OrderTime.Height               := vHeight - Common.KioskConfig[8];
      KioskButtonList[vCount].OrderTime.Caption              := '';
      KioskButtonList[vCount].OrderTime.Style.Font.Name      := KioskPLUMenuPanel.Font.Name;
      KioskButtonList[vCount].OrderTime.Style.Font.Size      := KioskPLUMenuPanel.Font.Size;
      KioskButtonList[vCount].OrderTime.Tag                  := vCount;
      KioskButtonList[vCount].OrderTime.Transparent          := true;
      KioskButtonList[vCount].OrderTime.Style.Font.Color     := KioskPLUMenuPanel.Font.Color;
      KioskButtonList[vCount].OrderTime.Style.Font.Style     := [fsBold];
      KioskButtonList[vCount].OrderTime.Visible              := false;
      KioskButtonList[vCount].OrderTime.OnClick              := KioskMenuPlu1Click;
      KioskButtonList[vCount].OrderTime.BringToFront;

      Inc(vCount);
    end;
  end;
  KioskPLUMenuPanel.Width := 0;
end;

procedure TOrder_F.KioskOrderButtonClick(Sender: TObject);
var vIndex :Integer;
    vCourseMenuExist :Boolean;
    vMenuName :String;
begin
  if MilliSecondsBetween(Now(),ClickTime) < 100 then Exit;
  ClickTime := Now;
  BlockInput(true);
  Common.Device.OnScannerReadData := nil;
  Common.KioskTouchBeep('kioskwave12');
  Common.WriteLog('work', '주문버튼');
  try
    Tmr_KioskWait.Enabled := false;
    if Main_sGrd.Cells[0,0] = '' then
    begin
      Common.MsgBox('주문을 먼저 해야합니다');
      Exit;
    end;
    vCourseMenuExist := false;
    for vIndex := 0 to Main_sGrd.RowCount-1 do
    begin
      if Main_sGrd.Cells[GDM_DS_MENU, vIndex] = 'C' then
      begin
        vCourseMenuExist := true;
        vMenuName        := Main_sGrd.Cells[GDM_NM_MENU, vIndex];
        Break;
      end;
    end;

    if vCourseMenuExist then
    begin
      Common.MsgBox('코스메뉴는 주문을 할 수 없습니다'#13+vMenuName);
      Exit;
    end;

    Action15Execute(nil);
    WorkState := wsReady;
    OrderListView;
  finally
    BlockInput(false);
    Common.Device.OnScannerReadData := ScannerReadEvent;
    if KioskBeginImageExist then
      SetKioskBeginImage;
    ThaiButtonClick(nil);
  end;
end;

procedure TOrder_F.KioskOrderMenuCreate;
var vIndex :Integer;
begin
  for vIndex := 0 to High(KioskOrderMenu) do
  begin
    //주문전체 그룹
    KioskOrderMenu[vIndex].GroupBox := TPanel.Create(Self);
    tmpKioskOrderMenu[vIndex].GroupBox := TPanel.Create(Self);
    KioskOrderMenu[vIndex].GroupBox.Parent            := KioskOrderMenuScrollBox;//KioskOrderMenuPanel;
    KioskOrderMenu[vIndex].GroupBox.Align             := alTop;
//    KioskOrderMenu[vIndex].GroupBox.BorderStyle       := 0;//bsNone;
    KioskOrderMenu[vIndex].GroupBox.ParentBackground  := true;
    KioskOrderMenu[vIndex].GroupBox.ParentColor       := true;
    KioskOrderMenu[vIndex].GroupBox.Caption           := EmptyStr;
    KioskOrderMenu[vIndex].GroupBox.Height            := 35;
    KioskOrderMenu[vIndex].GroupBox.BevelOuter        := bvNone;
    KioskOrderMenu[vIndex].GroupBox.Font.Name         := KioskOrderMenuPanel.Font.Name;
    KioskOrderMenu[vIndex].GroupBox.Font.Color        := KioskOrderMenuPanel.Font.Color;
    KioskOrderMenu[vIndex].GroupBox.Font.Size         := KioskOrderMenuPanel.Font.Size;
    KioskOrderMenu[vIndex].GroupBox.Visible           := false;

    //주메뉴
    KioskOrderMenu[vIndex].MainMenu                  := TcxLabel.Create(Self);
    tmpKioskOrderMenu[vIndex].MainMenu               := TcxLabel.Create(Self);
    KioskOrderMenu[vIndex].MainMenu.Parent           := KioskOrderMenu[vIndex].GroupBox;
    KioskOrderMenu[vIndex].MainMenu.Name             := Format('lbl_KioskMenu%d',[vIndex]);
    KioskOrderMenu[vIndex].MainMenu.AutoSize         := false;
    KioskOrderMenu[vIndex].MainMenu.Style.Font.Name  := KioskOrderMenuPanel.Font.Name;
    KioskOrderMenu[vIndex].MainMenu.Style.Font.Color := KioskOrderMenuPanel.Font.Color;
    KioskOrderMenu[vIndex].MainMenu.Style.Font.Size  := KioskOrderMenuPanel.Font.Size;
    KioskOrderMenu[vIndex].MainMenu.Style.TextStyle  := [fsBold];
    KioskOrderMenu[vIndex].MainMenu.Transparent      := true;
    KioskOrderMenu[vIndex].MainMenu.Properties.Alignment.Vert := taVCenter;
    KioskOrderMenu[vIndex].MainMenu.Caption          := EmptyStr;
    KioskOrderMenu[vIndex].MainMenu.Top              := 0;
    KioskOrderMenu[vIndex].MainMenu.Left             := 0;
    KioskOrderMenu[vIndex].MainMenu.Height           := KioskOrderMenuPanel.Font.Size * 2 + 5;
    tmpKioskOrderMenu[vIndex].MainMenu.Height        := KioskOrderMenuPanel.Font.Size * 2 + 5;
    if GetOption(28) = '0' then
      KioskOrderMenu[vIndex].MainMenu.Width            := Trunc(KioskOrderMenuScrollBox.Width * 0.75)
    else
      KioskOrderMenu[vIndex].MainMenu.Width            := Trunc(KioskOrderMenuScrollBox.Width * 0.50);

    //메뉴단가
    if GetOption(28) = '1' then
    begin
      KioskOrderMenu[vIndex].MenuPrice                  := TcxLabel.Create(Self);
      tmpKioskOrderMenu[vIndex].MenuPrice               := TcxLabel.Create(Self);
      KioskOrderMenu[vIndex].MenuPrice.Parent           := KioskOrderMenu[vIndex].GroupBox;
      KioskOrderMenu[vIndex].MenuPrice.Name             := Format('lbl_KioskMenuPrice%d',[vIndex]);
      KioskOrderMenu[vIndex].MenuPrice.Properties.Alignment.Horz := taRightJustify;
      KioskOrderMenu[vIndex].MenuPrice.Properties.Alignment.Vert := taVCenter;
      KioskOrderMenu[vIndex].MenuPrice.AutoSize         := false;
      KioskOrderMenu[vIndex].MenuPrice.Style.Font.Name  := KioskOrderMenuPanel.Font.Name;
      KioskOrderMenu[vIndex].MenuPrice.Style.Font.Color := StringToColorDef(KioskOrderMenuPanel.Hint, clBlue);
      KioskOrderMenu[vIndex].MenuPrice.Style.Font.Size  := KioskOrderMenuPanel.Font.Size;
      KioskOrderMenu[vIndex].MenuPrice.Style.TextStyle  := [fsBold];
      KioskOrderMenu[vIndex].MenuPrice.Transparent      := true;
      KioskOrderMenu[vIndex].MenuPrice.Caption          := EmptyStr;
      KioskOrderMenu[vIndex].MenuPrice.Top              := 0;
      KioskOrderMenu[vIndex].MenuPrice.Left             := Trunc(KioskOrderMenuScrollBox.Width * 0.50);
      KioskOrderMenu[vIndex].MenuPrice.Height           := KioskOrderMenuPanel.Font.Size * 2 + 5;
      KioskOrderMenu[vIndex].MenuPrice.Width            := Trunc(KioskOrderMenuScrollBox.Width * 0.25);
    end;

    //서브메뉴
    KioskOrderMenu[vIndex].SubMenu                  := TcxLabel.Create(Self);
    tmpKioskOrderMenu[vIndex].SubMenu               := TcxLabel.Create(Self);
    KioskOrderMenu[vIndex].SubMenu.Parent           := KioskOrderMenu[vIndex].GroupBox;
    KioskOrderMenu[vIndex].SubMenu.Name             := Format('lbl_KioskSubMenu%d',[vIndex]);
    KioskOrderMenu[vIndex].SubMenu.AutoSize         := false;
    KioskOrderMenu[vIndex].SubMenu.Style.Font.Name  := KioskOrderMenuPanel.Font.Name;
    KioskOrderMenu[vIndex].SubMenu.Style.Font.Color := KioskOrderMenuPanel.Font.Color;
    KioskOrderMenu[vIndex].SubMenu.Style.Font.Size  := KioskOrderMenuPanel.Font.Size-4;
    KioskOrderMenu[vIndex].SubMenu.Properties.Alignment.Vert := taVCenter;
    KioskOrderMenu[vIndex].SubMenu.Transparent      := true;
    KioskOrderMenu[vIndex].SubMenu.Caption          := EmptyStr;
    KioskOrderMenu[vIndex].SubMenu.Top              := KioskOrderMenu[vIndex].MainMenu.Height+1;
    KioskOrderMenu[vIndex].SubMenu.Left             := 0;
    KioskOrderMenu[vIndex].SubMenu.Height           := (KioskOrderMenuPanel.Font.Size-3) * 2 + 5;
    KioskOrderMenu[vIndex].SubMenu.Width            := FtoI(KioskOrderMenuPanel.Width * 0.7);
    KioskOrderMenu[vIndex].SubMenu.Visible          := false;


    KioskOrderMenu[vIndex].AddButton := TAdvSmoothToggleButton.Create(Self);
    tmpKioskOrderMenu[vIndex].AddButton := TAdvSmoothToggleButton.Create(Self);
    KioskOrderMenu[vIndex].AddButton.Parent           := KioskOrderMenu[vIndex].GroupBox;
    KioskOrderMenu[vIndex].AddButton.Top              := 2;
    KioskOrderMenu[vIndex].AddButton.Left             := KioskOrderMenuScrollBox.Width - KioskOrderMenuPanel.Font.Size * 2 - 5; //5은 스크롤대비
    KioskOrderMenu[vIndex].AddButton.Width            := KioskOrderMenuPanel.Font.Size * 2;
    KioskOrderMenu[vIndex].AddButton.Height           := KioskOrderMenuPanel.Font.Size * 2;
    KioskOrderMenu[vIndex].AddButton.BevelWidth       := 0;
    KioskOrderMenu[vIndex].AddButton.BorderColor      := clNone;
    KioskOrderMenu[vIndex].AddButton.BorderInnerColor := clNone;
    KioskOrderMenu[vIndex].AddButton.Caption          := '+';
    KioskOrderMenu[vIndex].AddButton.Color            := StringToColorDef(KioskOrderMenuPanel.Hint, clBlue);
    KioskOrderMenu[vIndex].AddButton.Appearance.SimpleLayout := true;
    KioskOrderMenu[vIndex].AddButton.Appearance.ShiftDown    := -3;
    KioskOrderMenu[vIndex].AddButton.Appearance.Font.Name := '맑은 고딕';
    KioskOrderMenu[vIndex].AddButton.Appearance.Font.Size := KioskOrderMenuPanel.Font.Size + 3;
    KioskOrderMenu[vIndex].AddButton.Appearance.Font.Color := clWhite;
    KioskOrderMenu[vIndex].AddButton.Appearance.Font.Style := [fsBold];
    KioskOrderMenu[vIndex].AddButton.Appearance.Rounding   := 10;
    KioskOrderMenu[vIndex].AddButton.Tag              := vIndex;
    KioskOrderMenu[vIndex].AddButton.OnClick          := obtn_KioskAdd1Click;
    KioskOrderMenu[vIndex].AddButton.AutoToggle       := false;
    KioskOrderMenu[vIndex].AddButton.ShowFocus        := false;
    KioskOrderMenu[vIndex].AddButton.TabStop          := false;

    //주문수량
    KioskOrderMenu[vIndex].OrderQty                  := TcxLabel.Create(Self);
    tmpKioskOrderMenu[vIndex].OrderQty               := TcxLabel.Create(Self);
    KioskOrderMenu[vIndex].OrderQty.Parent           := KioskOrderMenu[vIndex].GroupBox;
    KioskOrderMenu[vIndex].OrderQty.Name             := Format('lbl_KioskOrderQty%d',[vIndex]);
    KioskOrderMenu[vIndex].OrderQty.AutoSize         := false;
    KioskOrderMenu[vIndex].OrderQty.Width            := KioskOrderMenu[vIndex].AddButton.Width + 5;
    KioskOrderMenu[vIndex].OrderQty.Height           := KioskOrderMenuPanel.Font.Size * 2 + 5;
    KioskOrderMenu[vIndex].OrderQty.Style.Font.Name  := KioskOrderMenuPanel.Font.Name;
    KioskOrderMenu[vIndex].OrderQty.Style.Font.Color := StringToColorDef(KioskOrderMenuPanel.Hint, clBlue);
    KioskOrderMenu[vIndex].OrderQty.Style.Font.Size  := KioskOrderMenuPanel.Font.Size;
    KioskOrderMenu[vIndex].OrderQty.Style.TextStyle  := [fsBold];
    KioskOrderMenu[vIndex].OrderQty.Properties.Alignment.Horz := taCenter;
    KioskOrderMenu[vIndex].OrderQty.Properties.Alignment.Vert := taVCenter;
    KioskOrderMenu[vIndex].OrderQty.Transparent      := true;
    KioskOrderMenu[vIndex].OrderQty.Caption          := EmptyStr;
    KioskOrderMenu[vIndex].OrderQty.Top              := 0;
    KioskOrderMenu[vIndex].OrderQty.Left             := KioskOrderMenu[vIndex].AddButton.Left - (KioskOrderMenu[vIndex].AddButton.Width + 10);
    KioskOrderMenu[vIndex].OrderQty.Properties.Alignment.Horz := taCenter;


    KioskOrderMenu[vIndex].CancelButton := TAdvSmoothToggleButton.Create(Self);
    tmpKioskOrderMenu[vIndex].CancelButton := TAdvSmoothToggleButton.Create(Self);
    KioskOrderMenu[vIndex].CancelButton.Parent           := KioskOrderMenu[vIndex].GroupBox;
    KioskOrderMenu[vIndex].CancelButton.Top              := 2;
    KioskOrderMenu[vIndex].CancelButton.Left             := KioskOrderMenu[vIndex].OrderQty.Left - KioskOrderMenuPanel.Font.Size * 2;
    KioskOrderMenu[vIndex].CancelButton.Width            := KioskOrderMenuPanel.Font.Size * 2;
    KioskOrderMenu[vIndex].CancelButton.Height           := KioskOrderMenuPanel.Font.Size * 2;
    KioskOrderMenu[vIndex].CancelButton.BevelWidth       := 0;
    KioskOrderMenu[vIndex].CancelButton.BorderColor      := clNone;//clWhite;
    KioskOrderMenu[vIndex].CancelButton.BorderInnerColor := clNone;//clWhite;
    KioskOrderMenu[vIndex].CancelButton.Caption          := '-';
    KioskOrderMenu[vIndex].CancelButton.Color            := StringToColorDef(KioskOrderMenuPanel.Hint, clBlue);
    KioskOrderMenu[vIndex].CancelButton.Appearance.SimpleLayout := true;
    KioskOrderMenu[vIndex].CancelButton.Appearance.ShiftDown    := -3;
    KioskOrderMenu[vIndex].CancelButton.Appearance.Font.Name := '맑은 고딕';
    KioskOrderMenu[vIndex].CancelButton.Appearance.Font.Size := KioskOrderMenuPanel.Font.Size + 3;
    KioskOrderMenu[vIndex].CancelButton.Appearance.Font.Color := clWhite;
    KioskOrderMenu[vIndex].CancelButton.Appearance.Font.Style := [fsBold];
    KioskOrderMenu[vIndex].CancelButton.Appearance.Rounding   := 10;
    KioskOrderMenu[vIndex].CancelButton.Tag              := vIndex;
    KioskOrderMenu[vIndex].CancelButton.OnClick          := obtn_KioskCancel1Click;
    KioskOrderMenu[vIndex].CancelButton.AutoToggle       := false;
    KioskOrderMenu[vIndex].CancelButton.ShowFocus        := false;
    KioskOrderMenu[vIndex].CancelButton.TabStop := false;




  end;
end;

procedure TOrder_F.KioskPointSearchButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  if MilliSecondsBetween(Now(),ClickTime) < 100 then Exit;
  ClickTime := Now;
  Common.WriteLog('work', '포인트/스템프조회버튼');
  if Assigned(KioskBillInfo_F) then
  begin
    if KioskBillInfo_F.Showing then
      KioskBillInfo_F.Hide;
  end;

  try
    Tmr_KioskWait.Enabled := false;
    if (Common.Member.Code = '') then
    begin
      if not KioskMemberSelect then
      begin
        InitMemberRecord(Common.Member);
        Exit;
      end;
    end;

    if GetOption(21)='0' then
      Common.MsgBox(Format('%s 님의 포인트는'#13'%s 점 입니다',[Common.Member.Name, FormatFloat(',0',Common.Member.Point)]))
    else
      Common.MsgBox(Format('%s 님의 스템프는'#13'%d 개 입니다',[Common.Member.Name, Common.Member.Stamp]))
  finally
    if KioskBeginImageExist or (not KioskBeginImageExist and (GetOption(437) <> '0')) then
      Tmr_KioskWait.Enabled := true;
  end;
end;

procedure TOrder_F.KioskPointUseButtonClick(Sender: TObject);
begin
  if MilliSecondsBetween(Now(),ClickTime) < 100 then Exit;
  ClickTime := Now;
  if GetOption(21) = '1' then
  begin
    Common.MsgBox('스템프 사용매장은'#13#13'포인트를 사용할 수 없습니다');
    Exit;
  end;

  BlockInput(true);
  Common.Device.OnScannerReadData := nil;
  Common.KioskTouchBeep('kioskwave12');
  Common.WriteLog('work', '포인트결제버튼');
  if Assigned(KioskBillInfo_F) then
  begin
    if KioskBillInfo_F.Showing then
      KioskBillInfo_F.Hide;
  end;

  try
    if KioskBeginImageExist or (not KioskBeginImageExist and (GetOption(437) <> '0')) then
      Tmr_KioskWait.Enabled := true;
    if Main_sGrd.Cells[0,0] = '' then
    begin
      Common.MsgBox('메뉴를 먼저 주문하세요');
      Exit;
    end;

    if (Common.Member.Code = '') then
    begin
      if not KioskMemberSelect then
      begin
        InitMemberRecord(Common.Member);
        Exit;
      end;
    end;

    if Common.Config.pnt_min_use > Common.Member.Point then
    begin
      Common.ErrBox(Format('잔여포인트가 %d점 이상만'#13#13'사용이 가능합니다',[Common.Config.pnt_min_use]));
      Exit;
    end;

    if Common.Member.Point < Common.PreSent.WRcvAmt then
    begin
      Common.MsgBox('포인트가 부족합니다');
      Exit;
    end;

    KioskMenuOrder;

    if KioskDefaultOrderType = otTakeOut then
    begin
      Common.Table.Packing      := 'Y';
      Common.KioskTable.Packing := 'Y';
    end;
    if GetOption(425) = '0' then
    begin
      Common.DoModalReset;
      with TKioskOrderConfirm_F.Create(Self) do
        try
          TableUse   := (GetOption(426) = '1') and (KioskDefaultOrderType <> otTakeOut);
          AskPacking := GetOption(424) = '1';
          if ShowModal <> mrOK then Exit;
        finally
          Free;
          Common.DoModalClose;
        end;

      if GetOption(426) = '4' then
      begin
        Common.Table := Common.KioskTable;
        Common.Config.IsTakeOut := false;
      end;

      if ((GetOption(424) = '2') or (GetOption(424) = '3')) and (GetOption(426) = '2') and (KioskDefaultOrderType =otStore) then
      begin
        Common.Table := Common.KioskTable;
        Common.Config.IsTakeOut := false;
      end;
    end
    else if ((GetOption(426) = '1') and (KioskDefaultOrderType <> otTakeOut)) or (GetOption(426) = '3') then
    begin
      if not KioskTableSelect then Exit;
    end;
    if ((GetOption(424) = '2') or (GetOption(424) = '3')) and (GetOption(426) = '2') and (KioskDefaultOrderType = otStore) then
    begin
      Common.Table := Common.KioskTable;
      Common.Config.IsTakeOut := false;
    end
    else if GetOption(426) = '4' then
    begin
      Common.Table := Common.KioskTable;
      Common.Config.IsTakeOut := false;
    end;
    Act_Point.Execute;
    if Common.PreSent.WRcvAmt > 0 then Exit;

    //고객주문서 출력시
    if (GetOption(490)='1') or ((GetOption(311)='1') and (Common.PreSent.CallNo > 0)) then
    begin
      if not Assigned(KioskBillInfo_F) then
        Application.CreateForm(TKioskBillInfo_F, KioskBillInfo_F);
      KioskBillInfo_F.Show;
    end;
    Common.Config.IsTakeOut := true;
    WorkState := wsReady;
    OrderListView;
    if KioskBeginImageExist then
      SetKioskBeginImage;

    ThaiButtonClick(nil);

  finally
    if KioskBeginImageExist or (not KioskBeginImageExist and (GetOption(437) <> '0')) then
      Tmr_KioskWait.Enabled := true;
    BlockInput(false);
    Common.Device.OnScannerReadData := ScannerReadEvent;
  end;
end;

procedure TOrder_F.KioskSetClassPLU;
  function SetCaption(aValue:String):String;
  var vCount :Integer;
  begin
    vCount := Length(aValue) - Length(WideString(aValue));
    Result := EmptyStr;
    for vCount := 1 to vCount*2 do
      Result := Result + ' ';

    Result := Result + aValue;
  end;
var vIndex :Integer;
begin
  if not KioskPLUClassPanel.Visible then Exit;

  OpenQuery('select CD_LARGE, '
           +'			  NM_LARGE, '
           +'			  NO_POSITION '
           +'	 from MS_KIOSK_LARGE '
           +' where CD_STORE	=:P0 '
           +'		and CD_GUBUN	=:P1 '
           +'   and NO_POSITION between :P2 and :P3 '
           +' order by NO_POSITION',
           [Common.Config.StoreCode,
            GetKioskPLU,
            (KioskClassPage-1)*KioskClassCount+1,
            (KioskClassPage-1)*KioskClassCount+KioskClassCount]);
  for vIndex := 1 to KioskClassCount do
  begin
    TAdvSmoothToggleButton(FindComponent(Format('obtn_KioskClass%d',[vIndex]))).Caption := EmptyStr;
    TAdvSmoothToggleButton(FindComponent(Format('obtn_KioskClass%d',[vIndex]))).Hint    := EmptyStr;
  end;

  while not Common.Query.Eof do
  begin
    vIndex := Common.Query.FieldByName('NO_POSITION').AsInteger - (KioskClassPage-1)*KioskClassCount;
    TAdvSmoothToggleButton(FindComponent(Format('obtn_KioskClass%d',[vIndex]))).Caption := LineFeed(Common.GetPaPago(Common.Query.FieldByName('NM_LARGE').AsString));
    TAdvSmoothToggleButton(FindComponent(Format('obtn_KioskClass%d',[vIndex]))).Hint    := SetCaption(Common.Query.FieldByName('CD_LARGE').AsString);
    Common.Query.Next;
  end;
  Common.Query.Close;
end;

procedure TOrder_F.KioskSetMenuPLU;
  function GetMenuQty(aMenuCode:String):Integer;
  var vIndex :Integer;
  begin
    Result := 0;
    for vIndex := 0 to Main_sGrd.RowCount-1 do
    begin
      if (Main_sGrd.Cells[GDM_CD_MENU1, vIndex] = '') and (aMenuCode = Main_sGrd.Cells[GDM_CD_MENU, vIndex]) then
        Result := Result + StoI(Main_sGrd.Cells[GDM_QTY, vIndex]);
    end;
  end;

  var vIndex, vCount  :Integer;
    vStream    :TStream;
    vPosition  :Integer;
    vImgMenu   :String;
    vMenuName,
    vMenuPrice  :String;
    vSalePrice  :Integer;
    vEvent,
    vSoldOut    :Boolean;
    vMenuAling,
    vPriceAlign :String;
    vCollectionIndex,
    vFontSize :Integer;
    vMenuImage  :TPNGImage;
    vImage      :TImage;
begin
  OpenQuery('select a.CD_MENU, '
           +'       a.NM_VIEW, '
           +Ifthen(GetOption(194)='1','GetSalePrice(a.CD_STORE, a.CD_MENU) as PR_SALE, ', 'b.PR_SALE, ')
           +'       e.PR_SALE as PR_SALE_EVENT, '
           +'       b.PR_SALE_PACKING, '
           +'       a.NO_POSITION, '
           +'       b.CONFIG, '
           +'       b.DS_MENU_TYPE, '
           +'       e.NO_SPC, '
           +'       e.TIME_FROM, '
           +'       e.TIME_TO, '
           +'       Substring(e.WEEKLY, DAYOFWEEK(Now()), 1) as WEEK, '
           +'       b.ORDERTIME_FROM, '
           +'       b.ORDERTIME_TO '
           +'  from MS_KIOSK_SMALL a inner join '
           +'       MS_MENU       as b on b.CD_STORE = a.CD_STORE and b.CD_MENU = a.CD_MENU left outer join '
           +'       ( select Max(b.NO_SPC) as NO_SPC, '
           +'                a.CD_MENU, '
           +'                a.PR_SALE, '
           +'                b.TIME_FROM, '
           +'                b.TIME_TO, '
           +'                b.WEEKLY '
           +'  	       from MS_SPC_D a inner join '
           +'               MS_SPC_H b on a.CD_STORE   = b.CD_STORE '
           +'                         and a.NO_SPC     = b.NO_SPC '
           +'          where a.CD_STORE   = :P0 '
           +'            and b.DT_FROM   <= Date_Format(Now(), ''%Y%m%d'') '
           +'            and b.DT_TO     >= Date_Format(Now(), ''%Y%m%d'') '
           +'            and b.YN_USE    = ''Y'' '
           +'            and a.YN_USE    = ''Y'' '
           +'            and Substring(b.WEEKLY, DAYOFWEEK(Now()), 1) = ''1'' '
           +'          group by a.CD_MENU, a.PR_SALE '
           +'        ) e on a.CD_MENU = e.CD_MENU '
           +' where a.CD_STORE =:P0 '
           +'   and a.CD_GUBUN =:P1 '
           +'   and a.CD_LARGE =:P2 '
           +'   and a.NO_POSITION between :P3 and :P4 '
           +Ifthen(Common.Table.Packing = 'Y', ' and SubString(b.CONFIG,10,1) <> ''Y'' ',' and SubString(b.CONFIG,10,1) <> ''S'' ')
           +' order by NO_POSITION ',
           [Common.Config.StoreCode,
            GetKioskPLU,
            KioskClassCode,
            (KioskPage-1)*KioskMenuCount+1,
            (KioskPage-1)*KioskMenuCount+KioskMenuCount]);

  for vIndex := 0 to High(KioskButtonList) do
  begin
    KioskButtonList[vIndex].GroupBox.Visible     := false;
    KioskButtonList[vIndex].MenuCode             := '';
    KioskButtonList[vIndex].Qty.Caption          := '';
    KioskButtonList[vIndex].EventImage.Picture   := nil;
    KioskButtonList[vIndex].DisableImage.Picture := nil;
    KioskButtonList[vIndex].DisableImage.Visible := false;
    KioskButtonList[vIndex].OrderTime.Visible    := false;
    KioskButtonList[vIndex].isSoldOut            := false;
    KioskButtonList[vIndex].isPassWord           := false;
  end;

  while not Common.Query.Eof do
  begin
    vIndex := Common.Query.FieldByName('NO_POSITION').AsInteger - (KioskPage-1)*KioskMenuCount - 1;
    vSoldOut := false;
    vEvent   := false;
    KioskButtonList[vIndex].GroupBox.Visible  := true;

    case Common.KioskConfig[11] of
      0 : vMenuAling := 'left';
      1 : vMenuAling := 'center';
      2 : vMenuAling := 'right';
    end;

    case Common.KioskConfig[12] of
      0 : vPriceAlign := 'left';
      1 : vPriceAlign := 'center';
      2 : vPriceAlign := 'right';
    end;


    vMenuName := Common.GetPaPago(Replace(Common.Query.FieldByName('NM_VIEW').AsString,'|','<BR>'));

    vSalePrice := Common.Query.FieldByName('PR_SALE').AsInteger;
    if Copy(Common.Query.FieldByName('CONFIG').AsString,8,1)='Y' then
      vSoldOut := true
    else if Common.Query.FieldByName('NO_SPC').AsString <> '' then
    begin
      //행사 시간만체크해서 품절여부 반영
      if (Common.Query.FieldByName('TIME_FROM').AsString <= FormatDateTime('hh:nn',Now()))
        and (Common.Query.FieldByName('TIME_TO').AsString >= FormatDateTime('hh:nn',Now()))
        and (Common.Query.FieldByName('WEEK').AsString = '1') then
      begin
        vSalePrice := Common.Query.FieldByName('PR_SALE_EVENT').AsInteger;
        vEvent     := true;
      end
      else if GetOption(471) = '1' then
        vSoldOut := true;
    end;

    if (Common.Query.FieldByName('ORDERTIME_FROM').AsString <> '00:00') and (Common.Query.FieldByName('ORDERTIME_TO').AsString <> '00:00') then
    begin
      if (FormatDateTime('hh:nn', Now()) < Common.Query.FieldByName('ORDERTIME_FROM').AsString) or (FormatDateTime('hh:nn', Now()) > Common.Query.FieldByName('ORDERTIME_TO').AsString) then
      begin
        KioskButtonList[vIndex].OrderTime.Visible := true;
        KioskButtonList[vIndex].OrderTime.Caption := Format('주문가능시간'#13'%s ~ %s',[Common.Query.FieldByName('ORDERTIME_FROM').AsString, Common.Query.FieldByName('ORDERTIME_TO').AsString]);
      end;
    end;

    if Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'P' then
      vMenuPrice := '   '
    else
    begin
      if ((WorkKind = wkPacking) or (Common.Table.Packing = 'Y')) and (Common.Query.FieldByName('PR_SALE_PACKING').AsCurrency > 0) then
      begin
        //행사적용 시 포장단가에도 적용한다
        if vEvent then
          vMenuPrice    := FormatFloat('￦ ,0', Common.Query.FieldByName('PR_SALE_PACKING').AsCurrency - (Common.Query.FieldByName('PR_SALE').AsCurrency - Common.Query.FieldByName('PR_SALE_EVENT').AsCurrency))
        else
          vMenuPrice    := FormatFloat('￦ ,0', Common.Query.FieldByName('PR_SALE_PACKING').AsCurrency);
      end
      else
        vMenuPrice    := FormatFloat('￦ ,0', vSalePrice);
    end;

    KioskButtonList[vIndex].MenuCode         := Common.Query.FieldByName('CD_MENU').AsString;
    KioskButtonList[vIndex].MenuType         := Common.Query.FieldByName('DS_MENU_TYPE').AsString;
    KioskButtonList[vIndex].isPassWord       := Copy(Common.Query.FieldByName('CONFIG').AsString,18,1)='Y';

    KioskButtonList[vIndex].MenuName         := Replace(vMenuName,'<BR>',' ');
    KioskButtonList[vIndex].MenuPrice        := vMenuPrice;


    try
      vMenuImage   := TPNGImage.Create;
      vCollectionIndex := Common.GetImageCollectionIndex(Common.Query.FieldByName('CD_MENU').AsString);
      if vCollectionIndex >= 0 then
        KioskButtonList[vIndex].MenuImage.Picture.Assign(Common.MenuImageCollection.Items.Items[vCollectionIndex].Picture.Graphic)
      else
        KioskButtonList[vIndex].MenuImage.Picture.Assign(ImageCollection.Items.Items[8].Picture.Graphic);

      if vSoldOut or (Copy(Common.Query.FieldByName('CONFIG').AsString,13,1)='0') then
        KioskButtonList[vIndex].EventImage.Picture.Graphic := nil
      else if Copy(Common.Query.FieldByName('CONFIG').AsString,13,1)='R' then
      begin
        if FileExists(Common.AppPath+'Kiosk\Badge_R.png') then
        begin
          vMenuImage.LoadFromFile(Common.AppPath+'Kiosk\Badge_R.png');
          KioskButtonList[vIndex].EventImage.Height := vMenuImage.Height;
          KioskButtonList[vIndex].EventImage.Width  := vMenuImage.Width;
          KioskButtonList[vIndex].EventImage.Picture.LoadFromFile(Common.AppPath+'Kiosk\Badge_R.png');
        end
        else
          KioskButtonList[vIndex].EventImage.Picture.Assign(BadgeImageCollection.Items.Items[0].Picture.Graphic);
      end
      else if Copy(Common.Query.FieldByName('CONFIG').AsString,13,1)='H' then
      begin
        if FileExists(Common.AppPath+'Kiosk\Badge_H.png') then
        begin
          vMenuImage.LoadFromFile(Common.AppPath+'Kiosk\Badge_H.png');
          KioskButtonList[vIndex].EventImage.Height := vMenuImage.Height;
          KioskButtonList[vIndex].EventImage.Width  := vMenuImage.Width;
          KioskButtonList[vIndex].EventImage.Picture.LoadFromFile(Common.AppPath+'Kiosk\Badge_H.png');
        end
        else
          KioskButtonList[vIndex].EventImage.Picture.Assign(BadgeImageCollection.Items.Items[1].Picture.Graphic);
      end
      else if Copy(Common.Query.FieldByName('CONFIG').AsString,13,1)='N' then
      begin
        if FileExists(Common.AppPath+'Kiosk\Badge_N.png') then
        begin
          vMenuImage.LoadFromFile(Common.AppPath+'Kiosk\Badge_N.png');
          KioskButtonList[vIndex].EventImage.Height := vMenuImage.Height;
          KioskButtonList[vIndex].EventImage.Width  := vMenuImage.Width;
          KioskButtonList[vIndex].EventImage.Picture.LoadFromFile(Common.AppPath+'Kiosk\Badge_N.png');
        end
        else
          KioskButtonList[vIndex].EventImage.Picture.Assign(BadgeImageCollection.Items.Items[2].Picture.Graphic);
      end
      else if Copy(Common.Query.FieldByName('CONFIG').AsString,13,1)='T' then
      begin
        if FileExists(Common.AppPath+'Kiosk\Badge_T.png') then
        begin
          vMenuImage.LoadFromFile(Common.AppPath+'Kiosk\Badge_T.png');
          KioskButtonList[vIndex].EventImage.Height := vMenuImage.Height;
          KioskButtonList[vIndex].EventImage.Width  := vMenuImage.Width;
          KioskButtonList[vIndex].EventImage.Picture.LoadFromFile(Common.AppPath+'Kiosk\Badge_T.png');
        end
        else
          KioskButtonList[vIndex].EventImage.Picture.Assign(BadgeImageCollection.Items.Items[4].Picture.Graphic);
      end;

    finally
      vMenuImage.Free;
    end;
    if vEvent then
      KioskButtonList[vIndex].EventImage.Picture.Assign(ImageCollection.Items.Items[11].Picture.Graphic);

    //품절이면 주문가능시간을 표시하지 않는다
    if vSoldOut then
    begin
      KioskButtonList[vIndex].DisableImage.Picture.Assign(ImageCollectionDisable.Picture.Graphic);
      KioskButtonList[vIndex].DisableImage.Visible := true;
      KioskButtonList[vIndex].OrderTime.Visible := true;
      KioskButtonList[vIndex].OrderTime.Caption := 'SOLD OUT';
      KioskButtonList[vIndex].OrderTime.Style.Font.Size := KioskPLUMenuPanel.Font.Size + 10;
      KioskButtonList[vIndex].isSoldOut         := vSoldOut;
    end
    else if KioskButtonList[vIndex].OrderTime.Visible then
    begin
      KioskButtonList[vIndex].DisableImage.Picture.Assign(ImageCollectionDisable.Picture.Graphic);
      KioskButtonList[vIndex].DisableImage.Visible := true;
      KioskButtonList[vIndex].OrderTime.Style.Font.Size := KioskPLUMenuPanel.Font.Size + 5;
    end;

    if Common.Config.PosLanguage <> 'KO' then
      vFontSize := KioskPLUMenuPanel.Font.Size-5
    else
      vFontSize := KioskPLUMenuPanel.Font.Size;

    if vSalePrice = 0 then
      vMenuPrice := '';

    KioskButtonList[vIndex].MenuName := vMenuName;
    if not vEvent then
    begin
      if Common.KioskConfig[14] = 0 then
      begin
        KioskButtonList[vIndex].GroupBox.Text := Format('%s<FONT  size="%d" color="%s" face="%s"><P align="%s"></P>%s<BR><P   align="%s"><B>%s</B></P></FONT>%s',
                                                        [IfThen(vSoldOut,'<I>',''),
                                                         vFontSize,
                                                         ColorToString(KioskPLUMenuPanel.Font.Color),
                                                         KioskPLUMenuPanel.Font.Name,
                                                         vMenuAling,
                                                         vMenuName,
                                                         vPriceAlign,
                                                         vMenuPrice,
                                                         IfThen(vSoldOut,'</I>','')]);
      end
      else
      begin
        KioskButtonList[vIndex].GroupBox.Text := Format('%s<FONT  size="%d" color="%s" face="%s"><P align="%s"></P>%s<BR><BR><P   align="%s"><B>%s</B></P></FONT>%s',
                                                        [IfThen(vSoldOut,'<I>',''),
                                                         vFontSize,
                                                         ColorToString(KioskPLUMenuPanel.Font.Color),
                                                         KioskPLUMenuPanel.Font.Name,
                                                         vMenuAling,
                                                         vMenuName,
                                                         vPriceAlign,
                                                         vMenuPrice,
                                                         IfThen(vSoldOut,'</I>','')]);
      end;
    end
    else
    begin
      if Common.KioskConfig[14] = 0 then
      begin
        KioskButtonList[vIndex].GroupBox.Text := Format('%s<FONT  size="%d" color="%s" face="%s"><P align="%s"></P>%s<BR><FONT color="#FF0000"><P   align="%s"><B>%s</B></P></FONT>%s',
                                                        [IfThen(vSoldOut,'<I>',''),
                                                         vFontSize,
                                                         ColorToString(KioskPLUMenuPanel.Font.Color),
                                                         KioskPLUMenuPanel.Font.Name,
                                                         vMenuAling,
                                                         vMenuName,
                                                         vPriceAlign,
                                                         Common.GetPaPago('(행사)  ')+vMenuPrice,
                                                         IfThen(vSoldOut,'</I>','')]);
      end
      else
      begin
        KioskButtonList[vIndex].GroupBox.Text := Format('%s<FONT  size="%d" color="%s" face="%s"><P align="%s"></P>%s<BR><BR><FONT color="#FF0000"><P   align="%s"><B>%s</B></P></FONT>%s',
                                                        [IfThen(vSoldOut,'<I>',''),
                                                         vFontSize,
                                                         ColorToString(KioskPLUMenuPanel.Font.Color),
                                                         KioskPLUMenuPanel.Font.Name,
                                                         vMenuAling,
                                                         vMenuName,
                                                         vPriceAlign,
                                                         Common.GetPaPago('(행사)  ')+vMenuPrice,
                                                         IfThen(vSoldOut,'</I>','')]);
      end;
    end;

    Common.Query.Next;

  if Main_sGrd.Cells[0,0] <> '' then
    For vIndex := 0 to Main_sGrd.RowCount-1 do
      if Main_sGrd.Cells[GDM_CD_MENU1, vIndex] = '' then
        SetKioskMenuButtonStatus(Main_sGrd.Cells[GDM_CD_MENU, vIndex], IntToStr(GetMenuQty(Main_sGrd.Cells[GDM_CD_MENU, vIndex])));
  end;
end;

procedure TOrder_F.KioskStoreButtonClick(Sender: TObject);
begin
  //접근성 모드에서 선택시
  if Common.Config.BarrierFreeMode <> bfNone then
  begin
    KioskStartKey := 0;
    ModalResult := mrAbort;
  end
  else
  begin
    Common.WriteLog('work', KioskStoreButton.Hint);
    KioskOrderStart(0);
  end;
end;

procedure TOrder_F.obtn_KioskAdd1Click(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  Main_sGrd.Row := (Sender as TAdvSmoothToggleButton).Tag;
//  if (StoI(Main_sGrd.Cells[GDM_QTY_SELECT, Main_sGrd.Row]) > 1) then
//  begin
//    FMenuCode :=  Main_sGrd.Cells[GDM_CD_MENU, Main_sGrd.Row];
//    SelectMenu(0);
//  end
//  else
    Action1.Execute;
  OrderListView;
end;

procedure TOrder_F.obtn_KioskCancel1Click(Sender: TObject);
var vStampDc :Integer;
    vIndex   :Integer;
begin
  Common.KioskTouchBeep('kioskwave12');
  vStampDc := Common.PreSent.StampDc;

  Main_sGrd.Row := (Sender as TAdvSmoothToggleButton).Tag;

  if (Common.Config.IsKiosk and (Main_sGrd.Cells[GDM_DS_MENU, Main_sGrd.Row] = 'W' )) or
     ((StoI(Main_sGrd.Cells[GDM_QTY_SELECT, Main_sGrd.Row]) > 1) and  (Main_sGrd.Cells[GDM_QTY, Main_sGrd.Row] = Main_sGrd.Cells[GDM_QTY_SELECT, Main_sGrd.Row])) then
    Action4.Execute
  else if (StoI(Main_sGrd.Cells[GDM_QTY_SELECT, Main_sGrd.Row]) > 1) then
  begin
    FMsrData := Main_sGrd.Cells[GDM_QTY_SELECT, Main_sGrd.Row];
    Action2.Execute;
  end
  else
    Action2.Execute;

  OrderListView;
  if vStampDc > 0 then
    Common.MsgBox('스템프사용 내역도 취소되었습니다');

  if (Main_sGrd.Cells[0,0] = '') and (Common.PreSent.TotalAmt = 0) then
    WorkState := wsReady;
end;

///////////////////////////////////////////////////////////
/////////////  키오스크 분류PLU 클릭 시 ///////////////////
///////////////////////////////////////////////////////////
procedure TOrder_F.obtn_KioskClass1Click(Sender: TObject);
var vIndex     :Integer;
begin
  if Sender <> nil then
    Common.KioskTouchBeep('kioskwave12');

  if (Sender <> nil) and Assigned(KioskBillInfo_F) then
  begin
    if KioskBillInfo_F.Showing then
      KioskBillInfo_F.Hide;
  end;

  if (Common.KioskConfig[2] > 0) and KioskPLUClassPanel.Visible then
  begin
    if Sender = nil then
    begin
      KioskClassCode := TAdvSmoothToggleButton(FindComponent('obtn_KioskClass1')).Hint;
      for vIndex := 1 to Common.KioskConfig[2] do
      begin
        TAdvSmoothToggleButton(FindComponent(Format('obtn_KioskClass%d',[vIndex]))).Down                  := false;
        TAdvSmoothToggleButton(FindComponent(Format('obtn_KioskClass%d',[vIndex]))).Appearance.Font.Color := KioskClass.FontColor;
        TAdvSmoothToggleButton(FindComponent(Format('obtn_KioskClass%d',[vIndex]))).BorderColor           := KioskClass.BorderColor;
        TAdvSmoothToggleButton(FindComponent(Format('obtn_KioskClass%d',[vIndex]))).BorderInnerColor      := KioskClass.BorderColor;
      end;
      TAdvSmoothToggleButton(FindComponent('obtn_KioskClass1')).Down                  := true;
      TAdvSmoothToggleButton(FindComponent('obtn_KioskClass1')).Appearance.Font.Color := KioskClass.FontDownColor;
      TAdvSmoothToggleButton(FindComponent('obtn_KioskClass1')).BorderColor           := KioskClass.BorderDownColor;
      TAdvSmoothToggleButton(FindComponent('obtn_KioskClass1')).BorderInnerColor      := KioskClass.BorderDownColor;
    end
    else
    begin
      for vIndex := 1 to Common.KioskConfig[2] do
      begin
        TAdvSmoothToggleButton(FindComponent(Format('obtn_KioskClass%d',[vIndex]))).Down                  := false;
        TAdvSmoothToggleButton(FindComponent(Format('obtn_KioskClass%d',[vIndex]))).Appearance.Font.Color := KioskClass.FontColor;
        TAdvSmoothToggleButton(FindComponent(Format('obtn_KioskClass%d',[vIndex]))).BorderColor           := KioskClass.BorderColor;
        TAdvSmoothToggleButton(FindComponent(Format('obtn_KioskClass%d',[vIndex]))).BorderInnerColor      := KioskClass.BorderColor;
      end;

      KioskClassCode := (Sender as TAdvSmoothToggleButton).Hint;
      (Sender as TAdvSmoothToggleButton).Down := true;
      (Sender as TAdvSmoothToggleButton).Appearance.Font.Color := KioskClass.FontDownColor;

      (Sender as TAdvSmoothToggleButton).BorderColor      := KioskClass.BorderDownColor;
      (Sender as TAdvSmoothToggleButton).BorderInnerColor := KioskClass.BorderDownColor;
    end;
  end
  else
    KioskClassCode := '01';

  OpenQuery('select Max(NO_POSITION) '
           +'  from MS_KIOSK_SMALL '
           +' where CD_STORE =:P0 '
           +'   and CD_GUBUN =:P1 '
           +'   and CD_LARGE =:P2 ',
           [Common.Config.StoreCode,
            GetKioskPLU,
            KioskClassCode]);

  if not Common.Query.Eof then
  begin
    KioskTotalPage := Common.Query.Fields[0].AsInteger div KioskMenuCount;
    if Common.Query.Fields[0].AsInteger mod KioskMenuCount > 0 then
      KioskTotalPage := KioskTotalPage + 1;
    KioskPage  := 1;
  end
  else
  begin
    for vIndex := 0 to High(KioskButtonList) do
      KioskButtonList[vIndex].GroupBox.Visible := false;
  end;
end;

procedure TOrder_F.KioskMenuPlu1Click(Sender: TObject);
var vOrderFinished :Boolean;
    vIndex :Integer;
label Loop;
begin
  if (Sender is TcxImage) then
    vIndex := (Sender as TcxImage).Tag
  else if (Sender is TcxLabel) then
    vIndex := (Sender as TcxLabel).Tag
  else if (Sender is TGroupBox) then
    vIndex := (Sender as TGroupBox).Tag
  else if (Sender is TAdvPanel) then
    vIndex := (Sender as TAdvPanel).Tag
  else Exit;

  if KioskButtonList[vIndex].isSoldOut then
  begin
    if Sender <> nil then
      Common.KioskTouchBeep('kioskwave12');
    Common.MsgBox('일시 품절 된 메뉴입니다');
    Exit;
  end;

  if Assigned(KioskBillInfo_F) then
  begin
    if KioskBillInfo_F.Showing then
      KioskBillInfo_F.Hide;
  end;

  if KioskButtonList[vIndex].isPassWord and (Common.Config.KioskOrderPassWord <> '') then
  begin
    try
      Common.DoModalReset;
      Tmr_KioskWait.Enabled := false;
      KioskKeyPad_F := TKioskKeyPad_F.Create(Self);
      KioskKeyPad_F.MessageLabel.Caption := '주문 패스워드를 입력하세요';
      KioskKeyPad_F.isPassword           := true;
      try
        if KioskKeyPad_F.ShowModal <> mrOK then Exit;
        if Common.Config.KioskOrderPassWord <> KioskKeyPad_F.KeyInLabel.Hint then
        begin
          Common.ErrBox('패스워드가 올바르지 않습니다');
          Exit;
        end;
      finally
        FreeAndNil(KioskKeyPad_F);
        Common.DoModalClose;
        Common.Device.OnScannerReadData := ScannerReadEvent;
      end;
    finally
      Tmr_KioskWait.Enabled := true;
    end;
  end;

  //그룹메뉴일때
  if KioskButtonList[vIndex].MenuType = 'P' then
  begin
    Common.KioskTouchBeep('kioskwave12');
    try
      Self.Enabled := false;
      KioskGroup_F := TKioskGroup_F.Create(Self);
      KioskGroup_F.ButtonWidth  := KioskButtonList[0].GroupBox.Width;
      KioskGroup_F.ButtonHeight := KioskButtonList[0].GroupBox.Height;
      KioskGroup_F.MenuCode     := KioskButtonList[vIndex].MenuCode;
      KioskGroup_F.ButtonFont   := KioskPLUMenuPanel.Font;
      KioskGroup_F.GroupName    := KioskButtonList[vIndex].MenuName;
  Loop:
      if KioskGroup_F.ShowModal = mrOK then
      begin
        vOrderFinished := false;
        FMenuCode :=  KioskGroup_F.OrderMenuCode;
        SelectMenu(0);
        OrderListView;
      end
      else
        vOrderFinished := true;

      if not vOrderFinished then Goto Loop;
    finally
      Self.Enabled := true;
      FreeAndNil(KioskGroup_F);
    end;
  end
  else
  begin
    Common.KioskTouchBeep('kioskwave10');
    PluMenuButtonClick(Sender);
  end;
  OrderListView;
end;

procedure TOrder_F.SetKioskClassPage(AValue :Integer);
begin
  FKioskClassPage  := AValue;
  KioskSetClassPLU;
  obtn_KioskClass1Click(nil);

  if KioskClassNextButton.Visible then
  begin
    KioskClassPriorButton.Enabled  := FKioskClassPage > 1;
    if KioskClassPriorButton.Enabled then
    begin
      KioskClassPriorButton.Color := KioskPLUClassPanel.StatusBar.Color;
      KioskClassPriorButton.Appearance.Font.Color := KioskPLUClassPanel.Font.Color;
    end
    else
    begin
      KioskClassPriorButton.Color := KioskPLUClassPanel.StatusBar.ColorTo;
      KioskClassPriorButton.Appearance.Font.Color := KioskPLUClassPanel.CollapsColor;
    end;
    KioskClassNextButton.Enabled   := FKioskClassPage < KioskClassTotalPage;
    if KioskClassNextButton.Enabled then
    begin
      KioskClassNextButton.Color := KioskPLUClassPanel.StatusBar.Color;
      KioskClassNextButton.Appearance.Font.Color := KioskPLUClassPanel.Font.Color;
    end
    else
    begin
      KioskClassNextButton.Color := KioskPLUClassPanel.StatusBar.ColorTo;
      KioskClassNextButton.Appearance.Font.Color := KioskPLUClassPanel.CollapsColor;
    end;
  end;
end;

procedure TOrder_F.SetKioskMenuButtonStatus(aMenuCode, aQty: String);
var vIndex :Integer;
begin
  for vIndex := 0 to High(KioskButtonList) do
  begin
    if KioskButtonList[vIndex].MenuCode = aMenuCode then
    begin
      case StoI(aQty) of
        0 : KioskButtonList[vIndex].Qty.Caption := '';
        1..15 : KioskButtonList[vIndex].Qty.Caption := QtyBadge[StoI(aQty)-1];
        else
        KioskButtonList[vIndex].Qty.Caption := aQty;
      end;
      Break;
    end;
  end;
end;

procedure TOrder_F.KioskOrderStart(aType:Integer);
var vIndex :Integer;
    vIsTableSelected :Boolean;
label Loop1, Loop2;
begin
  Common.KioskTouchBeep('kioskwave12');
  if not Common.KioskAutoOpen then Exit;
Loop1:
  KioskWaitPanel.Left    := Self.Width * -1;
  Tmr_KioskWait.Tag      := 0;
  if KioskBeginImageExist or (not KioskBeginImageExist and (GetOption(437) <> '0')) then
    Tmr_KioskWait.Enabled  := true;
  Tmr_KioskImageChange.Enabled := false;
  KioskPanel.Enabled := true;
  case aType of
    0 :
    begin
      //매장이용/포장정보를 주방명으로 출력합니다
      if GetOption(417) = '1' then
      begin
        Common.Config.CustOrderTitle := '매장이용';
        for vIndex := 0 to High(Common.KitchenPrinter) do
          Common.KitchenPrinter[vIndex].Name := '매장이용';
      end;

      Common.Table.Packing := 'N';
      KioskUseTypeButton.Caption := '매장이용';
      Common.WriteLog('work', '매장이용');
      WorkKind := wkSale;
    end;
    1 :
    begin
      if GetOption(417) = '1' then
      begin
        Common.Config.CustOrderTitle :=  '포 장';
        for vIndex := 0 to High(Common.KitchenPrinter) do
          Common.KitchenPrinter[vIndex].Name := '포 장';
      end;

      InitTableRecord(Common.Table);
      InitTableRecord(Common.KioskTable);
      Common.Table.Packing := 'Y';
      KioskUseTypeButton.Caption := '포장';
      WorkKind := wkPacking;
      Common.WriteLog('work', '포장');
    end;
  end;

  if not Common.isBFKiosk and ((GetOption(424) = '2') or (GetOption(424) = '3')) and (GetOption(426) = '2') and (aType = 0) then
  begin
    InitTableRecord(Common.Table);
    InitTableRecord(Common.KioskTable);
    if KioskDefaultOrderType = otTakeOut then
      Common.Table.Packing := 'Y';
Loop2:
    vIsTableSelected := false;
    with TKioskTable_F.Create(Self) do
      try
        Width  := KioskWaitPanel.Width;
        Height := KioskWaitPanel.Height;
        case ShowModal of
          mrOK:
          begin
            Common.Config.IsTakeOut := true;
            InitTableRecord(Common.Table);
            InitTableRecord(Common.KioskTable);
            OpenQuery('select NM_CODE1, '
                     +'       GetTableName(:P0, :P1) as NM_TABLE '
                     +'  from MS_CODE  '
                     +' where CD_STORE =:P0 '
                     +'   and CD_KIND  =''03'' '
                     +'   and CD_CODE  =:P2 ',
                     [Common.Config.StoreCode,
                      TableNo,
                      Common.Table.Floor]);
            if not Common.Query.Eof then
            begin
              vIsTableSelected := true;
              Common.Table.FloorName  := Common.Query.Fields[0].AsString;
              Common.Table.Number     := TableNo;
              Common.Table.Name       := Common.Query.Fields[1].AsString;
              Common.Config.IsTakeOut := false;
              Common.KioskTable       := Common.Table;
              Common.WriteLog('work', Format('Table No : %d',[Common.KioskTable.Number]));
            end
            else
            begin
              Common.WriteLog('work', '선택한 테이블 존재하지 않습니다');
              Common.ErrBox('선택한 테이블 존재하지 않습니다');
              vIsTableSelected := true;
            end;
            Common.Query.Close;
          end;
          mrCancel :
          begin
            if KioskBeginImageExist then
              SetKioskBeginImage;
            if KioskBeginImageExist or (not KioskBeginImageExist and (GetOption(437) <> '0')) then
              Tmr_KioskWait.Enabled := true;
            Exit;
          end;
        end;
      finally
        Free;
      end;

    if  not vIsTableSelected then
    begin
      if Common.AskBox('테이블을 다시 선택하시겠습니까?') then
        Goto Loop2
      else
        Goto Loop1;
    end;
  end
  else if (GetOption(426) = '4') and (Common.Table.Packing <> 'Y') then
  begin
    InitTableRecord(Common.KioskTable);
    if not KioskTableSelect then
    begin
      if KioskBeginImageExist then
        SetKioskBeginImage;
      if KioskBeginImageExist or (not KioskBeginImageExist and (GetOption(437) <> '0')) then
        Tmr_KioskWait.Enabled := true;
    end
    else
    begin
      if GetOption(417) = '1' then
      begin
        Common.Config.CustOrderTitle := '매장이용';
        for vIndex := 0 to High(Common.KitchenPrinter) do
          Common.KitchenPrinter[vIndex].Name := '매장이용';
      end;
      Common.KioskTable       := Common.Table;
      KioskUseTypeButton.Caption := '매장이용';
      Common.Table.Packing    := 'N';
      WorkKind := wkSale;
    end;
  end;

  //다국어 사용시
  if (GetOption(457) = '1') or (GetOption(325) <> '0') then
    KioskSetClassPLU;
  KioskSetMenuPLU;
end;

procedure TOrder_F.KioskTableCreate(aRefresh:Boolean);
  procedure ButtonCreate(aTableNo, aTop, aLeft, aHeight,
    aWidth: Integer; aTableName, aFloorName, aHold:String);
  begin
    with TAdvSmoothButton.Create(Self) do
    begin
      Parent          := KioskWaitImagePanel;
      Top             := aTop;
      Left            := aLeft;
      Height          := aHeight;
      Width           := aWidth;
      Appearance.Rounding        := 10;
      Color           := clSilver;
      Bevel           := true;
      Shadow          := true;
      ClickDelay      := true;
      AllowTimer      := true;
      Appearance.GlowPercentage := 20;
      Appearance.Font.Size := 20;
      Appearance.Font.Color := clBlack;
      Appearance.Layout           := TGDIPButtonLayout.blNone;
      Appearance.PictureAlignment := taCenter;
      Appearance.SimpleLayoutBorder := true;
      Name            := Format('KioskTable_%d',[aTableNo]);
      Caption         := Ifthen(aHold = 'Y','이용중',aTableName);
      Tag             := aTableNo;
      ShowFocus       := false;
      OnClick         := KioskTableClick;
      Cursor          := crHandPoint;
      Hint            := aFloorName + splitColumn + aTableName;
      Visible         := true;
      BringToFront;
    end;
  end;
  procedure TableReflesh(aTableNo:Integer; aTableName, aHold :String);
  var vIndex :Integer;
  begin
    if not Assigned(TAdvSmoothButton(FindComponent(Format('KioskTable_%d',[aTableNo])))) then Exit;

    if (aHold = 'Y') and (TAdvSmoothButton(FindComponent(Format('KioskTable_%d',[aTableNo]))).Caption <> '이용중') then
      TAdvSmoothButton(FindComponent(Format('KioskTable_%d',[aTableNo]))).Caption := '이용중'
    else if (aHold = 'N') and (TAdvSmoothButton(FindComponent(Format('KioskTable_%d',[aTableNo]))).Caption = '이용중') then
      TAdvSmoothButton(FindComponent(Format('KioskTable_%d',[aTableNo]))).Caption := aTableName;
  end;
begin
  try
    OpenQuery('select a.NO_TABLE, '
             +'       b.NM_TABLE, '
             +'       a.NO_TOP, '
             +'       a.NO_LEFT, '
             +'       a.NO_HEIGHT, '
             +'       a.NO_WIDTH, '
             +'       c.NM_CODE1 as NM_FLOOR, '
             +'       b.YN_TABLEHOLD '
             +'  from MS_KIOSK_TABLE a inner join '
             +'       MS_TABLE    as b on b.CD_STORE = a.CD_STORE '
             +'                       and b.NO_TABLE = a.NO_TABLE inner join '
             +'       MS_CODE     as c on c.CD_STORE = a.CD_STORE '
             +'                       and c.CD_KIND  = ''03'' '
             +'                       and c.CD_CODE  = a.CD_FLOOR '
             +' where a.CD_STORE =:P0 '
             +'   and a.CD_FLOOR =:P1 ',
             [Common.Config.StoreCode,
              Ifthen(Common.Config.DefaultFloor='','001',Common.Config.DefaultFloor)]);
    while not Common.Query.Eof do
    begin
      if not aRefresh then
        ButtonCreate(Common.Query.FieldByName('NO_TABLE').AsInteger,
                     Common.Query.FieldByName('NO_TOP').AsInteger,
                     Common.Query.FieldByName('NO_LEFT').AsInteger,
                     Common.Query.FieldByName('NO_HEIGHT').AsInteger,
                     Common.Query.FieldByName('NO_WIDTH').AsInteger,
                     Common.Query.FieldByName('NM_TABLE').AsString,
                     Common.Query.FieldByName('NM_FLOOR').AsString,
                     Common.Query.FieldByName('YN_TABLEHOLD').AsString)
      else
        TableReflesh(Common.Query.FieldByName('NO_TABLE').AsInteger,
                     Common.Query.FieldByName('NM_TABLE').AsString,
                     Common.Query.FieldByName('YN_TABLEHOLD').AsString);
      Common.Query.Next;
    end;
  finally
    Common.Query.Close;
  end;

  ExecQuery('delete from SL_ORDER_LOG '
           +' where CD_STORE =:P0 '
           +'   and NO_POS   =:P1 ',
           [Common.Config.StoreCode,
            Common.Config.PosNo]);
end;

procedure TOrder_F.KioskTableClearButtonClick(Sender: TObject);
begin
  Common.DoModalReset;
  with TKioskTable_F.Create(Self) do
    try
      isClearMode := true;
      ShowModal;
    finally
      Free;
    end;
  Common.DoModalClose;
end;

procedure TOrder_F.KioskTableClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  if GetOption(488) = '1' then
  begin
    OpenQuery('select YN_TABLEHOLD '
             +'  from MS_TABLE '
             +' where CD_STORE  =:P0 '
             +'   and CD_FLOOR  =:P1 '
             +'   and NO_TABLE  =:P2 ',
             [Common.Config.StoreCode,
              Ifthen(Common.Config.DefaultFloor='','001',Common.Config.DefaultFloor),
              (Sender as TAdvSmoothButton).Tag]);
    if not Common.Query.Eof and (Common.Query.FieldByName('YN_TABLEHOLD').AsString = 'Y') then
    begin
      Common.Query.Close;
      Common.MsgBox('현재 사용중인 테이블입니다'#13'다른 테이블을 선택해주세요',5);
    end
    else
    begin
      Common.Query.Close;
      InitTableRecord(Common.Table);
      Common.Table.FloorName  := CopyPos((Sender as TAdvSmoothButton).Hint, splitColumn, 0);
      Common.Table.Number     := (Sender as TAdvSmoothButton).Tag;
      Common.Table.Name       := CopyPos((Sender as TAdvSmoothButton).Hint, splitColumn, 1);
      Common.Config.IsTakeOut := false;
      Common.KioskTable       := Common.Table;
      KioskBeginImageClick(nil);
    end;
  end
  else
  begin
    Common.Query.Close;
    InitTableRecord(Common.Table);
    Common.Table.FloorName  := CopyPos((Sender as TAdvSmoothButton).Hint, splitColumn, 0);
    Common.Table.Number     := (Sender as TAdvSmoothButton).Tag;
    Common.Table.Name       := CopyPos((Sender as TAdvSmoothButton).Hint, splitColumn, 1);
    Common.Config.IsTakeOut := false;
    Common.KioskTable       := Common.Table;
    KioskBeginImageClick(nil);
  end;

end;

function TOrder_F.KioskMenuLimitCheck:Boolean;
var vIndex, vLimitQty :Integer;
begin
  Result := false;
  For vIndex := 0 to Main_sGrd.RowCount-1 do
  begin
    if (Main_sGrd.Cells[GDM_CD_MENU1, vIndex] <> '') or (Copy(Main_sGrd.Cells[GDM_CONFIG, vIndex],17,1) = 'N') then Continue;

    OpenQuery('select QTY_SET '
             +'  from MS_MENU_SALEQTY '
             +' where CD_STORE =:P0 '
             +'   and YMD_SALE =:P1 '
             +'   and CD_MENU  =:P2 ',
             [Common.Config.StoreCode,
              Common.WorkDate,
              Main_sGrd.Cells[GDM_CD_MENU, vIndex]]);

    if not Common.Query.Eof then
    begin
      vLimitQty := Common.Query.Fields[0].AsInteger;
      Common.Query.Close;
      OpenQuery('select Ifnull(QTY_SALE,0)+Ifnull(QTY_ORDER,0) '
               +'  from ( '
               +'        select SUM(QTY_SALE) as QTY_SALE, '
               +'               0 as QTY_ORDER '
               +'          from sl_sale_d '
               +'         where CD_STORE = :P0 '
               +'           and YMD_SALE = :P1 '
               +'           and CD_MENU  = :P2 '
               +'           and DS_SALE <> ''V'' '
               +'        union all '
               +'        select 0, '
               +'               SUM(QTY_ORDER) as QTY_ORDER '
               +'          from sl_order_d '
               +'         where CD_STORE = :P0 '
               +'           and CD_MENU  = :P2 '
               +'       ) as t ',
               [Common.Config.StoreCode,
                Common.WorkDate,
                Main_sGrd.Cells[GDM_CD_MENU, vIndex]]);
      if not Common.Query.Eof and (vLimitQty < (Common.Query.Fields[0].AsInteger+StoI(Main_sGrd.Cells[GDM_QTY, vIndex])) ) then
      begin
        Common.MsgBox(Format('%s 메뉴의'#13'재고가 부족합니다'+#13'주문가능 수량 %d개',
                            [Main_sGrd.Cells[GDM_NM_MENU, vIndex],
                             vLimitQty - Common.Query.Fields[0].AsInteger]));
        Common.Query.Close;
        Exit;
        Break;
      end;
    end;
  end;
  Result := true;
end;


procedure TOrder_F.VideoRenderWndProc(var Msg: TMessage);
var
    iEventCode: LongInt;
    iParam1, iParam2: LONG_PTR;
begin
  case Msg.Msg of
    WM_GRAPHEVENT:
      begin
        MediaEvent.GetEvent(iEventCode, iParam1, iParam2,
          100 { dwTimeout } );
        // 미디어가 완료되거나 에러일때 처리
        if (iEventCode = EC_COMPLETE) or (iEventCode = 14) then // EC_USERABORT) then
          AviTimer.Enabled := true;


        MediaEvent.FreeEventParams(iEventCode, iParam1, iParam2);
      end;
  else
    VideoRenderOrgMethod(Msg);
  end;
end;

procedure TOrder_F.VolumeTrackBarChange(Sender: TObject);
begin
  SetMasterVolumePercent(VolumeTrackBar.Position);
end;

function TOrder_F.SetupDs: Boolean;
begin
  // DShow 를 초기화함
  Result := False;

  if Failed(CoCreateInstance(CLSID_FilterGraph, nil, CLSCTX_INPROC_SERVER,
    IID_IFilterGraph, FilterGraph)) then
      Exit; // 필터그래프를 생성한다.

  FilterGraph.QueryInterface(IID_IMediaControl, MediaControl);
  // 필터그래프의 인터페이스.
  FilterGraph.QueryInterface(IID_IVideoWindow, VideoWindow);

  if Failed(FilterGraph.QueryInterface(IID_IMediaEventEx, MediaEvent)) then
      Exit;
  if Failed(FilterGraph.QueryInterface(IID_IBasicAudio, BasicAudio)) then
      Exit;

  AvailableDS := true;
  Result := true;
end;

function TOrder_F.ShutDownDs: Boolean;
begin
  // DShow 를 해제
  if Assigned(MediaControl) then
      MediaControl.Stop;

  If Assigned(VideoWindow) then
  Begin
    VideoWindow.put_Visible(False);
    VideoWindow.put_Owner(0);
  End;

  VideoWindow  := nil;
  MediaControl := nil;
  MediaEvent   := nil;
  BasicAudio   := nil;
  FilterGraph  := nil;

  Result := true;
end;

procedure TOrder_F.SetVolume(Value: Integer);
var
    Vol : Integer;
begin
  // 볼륨 계산 0 은 최대 -10,000은 무음
  Vol := (100 - Value) * -100;
  BasicAudio.put_Volume(Vol);
end;

function TOrder_F.GetVolume: Integer;
begin
  VolumeTrackBar.Position := GetMasterVolumePercent;
end;

procedure TOrder_F.WMDeviceChange(var Msg: TMessage);
const DBT_DEVICEARRIVAL =$8000;
      DBT_DEVICEREMOVECOMPLETE = $8004;
begin
  if Msg.WParam = DBT_DEVICEARRIVAL then
  begin
    if KioskVoiceListenButton.Visible then
      KioskZoomInButtonClick(KioskVoiceListenButton)
  end
  else if Msg.WParam = DBT_DEVICEREMOVECOMPLETE then
  begin
    if KioskVoiceListenButton.Visible then
    begin
      Common.KioskVoice := false;
      KioskVoiceListenButton.Status.Visible := false;
    end;
  end;
end;

procedure TOrder_F.SetKioskPage(AValue :Integer);
var vIndex :Integer;
begin
  FKioskPage  := AValue;
  KioskMenuPageLabel.Caption := Format('%d / %d',[FKioskPage, KioskTotalPage]);
  KioskSetMenuPLU;

  if KioskMenuNextButton.Visible then
  begin
    KioskMenuPriorButton.Enabled := FKioskPage > 1;
    KioskMenuNextButton.Enabled := FKioskPage < KioskTotalPage;
  end;
end;

procedure TOrder_F.KioskInitButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  if MilliSecondsBetween(Now(),ClickTime) < 100 then Exit;
  ClickTime := Now;
  Common.WriteLog('work', '전체취소버튼');
  if Assigned(KioskBillInfo_F) then
  begin
    if KioskBillInfo_F.Showing then
      KioskBillInfo_F.Hide;
  end;
  try
    Tmr_KioskWait.Enabled := false;
    LockWindowUpdate(KioskPanel.Handle);
    if WorkState = wsReady then
      obtn_KioskClass1Click(nil);
    Action5.Execute;
    DisplayPresent;

    if Common.isBFKiosk and (Common.Config.BarrierFreeMode <> bfNone) then
    begin
      KioskStartKey := -1;
      Common.Config.BarrierFreeMode  := bfNone;
      Common.isBFChoose := false;
      ModalResult := mrAbort;
      Exit;
    end;

    Common.Config.KioskType := '84';
    Common.isBFChoose := false;
    if WorkState <> wsReady then Exit;

    SetPluClassData;

    OrderListView;
    if KioskBeginImageExist then
      SetKioskBeginImage;
    ThaiButtonClick(nil);
    KioskWorkDateLabel.Badge := '';
  finally
    LockWindowUpdate(0);
    if not Common.isBFKiosk and (KioskBeginImageExist or (not KioskBeginImageExist and (GetOption(437) <> '0'))) then
      Tmr_KioskWait.Enabled := true;
  end;
end;

function TOrder_F.GetKioskPLU(aCheck:Boolean): String;
var vTime :String;
begin
  vTime := FormatDateTime('hh:nn',now);
  if Common.Config.BarrierFreeMode = bfWheelChair then
  begin
    Result := FormatFloat('00', StrToInt(GetOption(387))+1);
    Exit;
  end
  else if Common.Config.BarrierFreeMode = bfLowVision then
  begin
    Result := FormatFloat('00', StrToInt(GetOption(388))+1);
    Exit;
  end;
       

  //키오스크 포장 시 PLU
  if GetOption(325) = '0' then
  begin
    with Common.Config do
    begin
      if (TimePLU[1,0] = '1') and (TimePLU[1,1] <= vTime) and (TimePLU[1,2] >= vTime) and (TimePLU[1,3] <> '') then
        Result := TimePLU[1,3]
      else if (TimePLU[2,0] = '1') and (TimePLU[2,1] <= vTime) and (TimePLU[2,2] >= vTime) and (TimePLU[2,3] <> '') then
        Result := TimePLU[2,3]
      else if (TimePLU[3,0] = '1') and (TimePLU[3,1] <= vTime) and (TimePLU[3,2] >= vTime) and (TimePLU[3,3] <> '') then
        Result := TimePLU[3,3]
      else
        Result := Ifthen(PluNo <> '', PluNo, '01');
    end;
    if not aCheck then
      KioskPluNo := Result;
  end
  else
  begin
    if Common.Table.Packing = 'N' then
    begin
      Result     := '01';
      KioskPluNo := Result;
    end
    else
    begin
      Result     := FormatFloat('00', StrToInt(GetOption(325))+1);
      KioskPluNo := Result;
    end;
  end;
end;

procedure TOrder_F.lbl_KioskCloseClick(Sender: TObject);
begin
  if IsDebuggerPresent then
  begin
    KioskCashButtonClick(KioskCashButton);
    Exit;
  end;
  Common.KioskTouchBeep('kioskwave12');
  lbl_KioskClose.Tag := lbl_KioskClose.Tag + 1;
  if lbl_KioskClose.Tag >= 3 then
  begin
    Tmr_KioskWait.Enabled := false;
    try
      if (Common.Config.KioskPwd <> '') then
      begin
        Common.DoModalReset;
        KioskKeyPad_F := TKioskKeyPad_F.Create(Self);
        KioskKeyPad_F.MessageLabel.Caption := '관리자 패스워드를 입력하세요';
        KioskKeyPad_F.isPassword           := true;
        try
          if KioskKeyPad_F.ShowModal <> mrOK then Exit;
          if Common.Config.KioskPwd <> KioskKeyPad_F.KeyInLabel.Hint then
          begin
            Common.ErrBox('패스워드가 올바르지 않습니다');
            lbl_KioskClose.Tag := 0;
            Exit;
          end;
        finally
          FreeAndNil(KioskKeyPad_F);
          Common.DoModalClose;
          Common.Device.OnScannerReadData := ScannerReadEvent;
        end;
      end;
    finally
      if KioskBeginImageExist or (not KioskBeginImageExist and (GetOption(437) <> '0')) then
      Tmr_KioskWait.Enabled := true;
    end;

    if Common.AskBox('종료하시겠습니까?') then
      CloseButtonClick(nil)
    else
    begin
      lbl_KioskClose.Tag := 0;
      if KioskBeginImageExist or (not KioskBeginImageExist and (GetOption(437) <> '0')) then
        Tmr_KioskWait.Enabled := true;
    end;
  end;
end;

function TOrder_F.SetKioskCash:Boolean;
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
begin
  if (Common.Config.KioskDispenserPort = 0) then
  begin
    Result := true;
    Exit;
  end;
  DispenserData := EmptyStr;
  //방출수량 조회
  vTemp := AnsiString(#$11#$04#$00#$00#$00#$00#$00#$00#$00#$00#$00);
  vTemp := AnsiChar(#$fe) +AnsiChar(Length(vTemp)+2)+vTemp;
  vFCC := Byte(vTemp[1]);
  for vIndex := 2 to Length(vTemp) do
    vFCC := vFCC xor Byte(vTemp[vIndex]);
  vTemp := vTemp + AnsiChar(vFCC);
  Common.Device.SendToDispenser(vTemp);
  vGetTime := GetTickCount;
  while (DispenserData = EmptyStr) and (vGetTime + 1000 > GetTickCount) do
    Application.ProcessMessages;

  if DispenserData = EmptyStr then
  begin
    Result := false;
    DispenderReset;
  end
  else
    Result := true;
end;

procedure TOrder_F.DispenserReadEvent(const S: String);
  //수신값이 한번에 여러건이 들어오는 경우가 있어서 최종것만 사용한다
  function GetReceiveData(aStr:String):String;
  var vIndex :Integer;
      vPos   :Integer;
  begin
    vPos := 1;
    for vIndex := 1 to Length(aStr) do
    begin
      if (StringToHex(aStr[vIndex])='18') and (vIndex >=3) and (StringToHex(aStr[vIndex-2])='fe') then
        vPos := vIndex-2;
    end;
    Result := Copy(aStr, vPos, Length(aStr)-vPos);
  end;
var vIndex :Integer;
    vBillCount,
    vCoinCount :Integer;
    vData :AnsiString;
begin
  vData := GetReceiveData(AnsiString(S));
  if (Length(vData) > 3) and (StringToHex(vData[3])='18') then
  begin
    if StringToHex(vData[4]) <> '00' then
      Exit
    else
    begin
      vBillCount := StrToInt('$'+StringToHex(vData[9])+StringToHex(vData[10]));
      vCoinCount := StrToInt('$'+StringToHex(vData[5])+StringToHex(vData[6]));

      if ((Common.Config.KioskAlram[0] - vBillCount) <= Common.Config.KioskAlram[4]) or ((Common.Config.KioskAlram[1] - vCoinCount) <= Common.Config.KioskAlram[5]) then
        Common.Config.KioskCashPause := true
      else
        Common.Config.KioskCashPause := false;

      if ((Common.Config.KioskAlram[2] > 0) and (Common.Config.KioskAlram[0]-Common.Config.KioskAlram[2] <= vBillCount))
      or ((Common.Config.KioskAlram[3] > 0) and (Common.Config.KioskAlram[1]-Common.Config.KioskAlram[3] <= vCoinCount)) then
      begin
        Common.KakaoSendMessage('K',['최소 거스름돈 보유금액 부족'+#13
                                +Format('천원 %d장, 백원 %d개',[vBillCount, vCoinCount])+#13
                                +FormatDateTime('yyyy-mm-dd hh:nn:ss', now())],'');
      end;

    end;
  end;
  DispenserData := S;
end;

procedure TOrder_F.DispenderReset;
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
begin
  DispenserData := EmptyStr;
  //방출기 리셋
  vTemp := AnsiString(#$10#$00#$03#$00#$00#$00#$00#$00#$00#$00#$00);
  vTemp := AnsiChar(#$fe) +AnsiChar(Length(vTemp)+2)+vTemp;
  vFCC := Byte(vTemp[1]);
  for vIndex := 2 to Length(vTemp) do
    vFCC := vFCC xor Byte(vTemp[vIndex]);
  vTemp := vTemp + AnsiChar(vFCC);
  Common.Device.SendToDispenser(vTemp);
  vGetTime := GetTickCount;
  while (DispenserData = EmptyStr) and (vGetTime + 1000 > GetTickCount) do
    Application.ProcessMessages;
end;

procedure TOrder_F.KioskMemberJoinButtonClick(Sender: TObject);
var vTelNo :String;
    vResult :TModalResult;
begin
  Common.KioskTouchBeep('kioskwave12');
//  if (GetOption(423) = '1') then
//  begin
//    Common.MsgBox('사용할 수 없는 기능입니다');
//    Exit;
//  end;

  try
    Tmr_KioskWait.Enabled := false;
    if Common.Config.BarrierFreeMode = bfWheelChair then
    begin
      KioskPhoneKeyPadBF_F := TKioskPhoneKeyPadBF_F.Create(Self);
      KioskPhoneKeyPadBF_F.Message1Label.Caption := '고객등록을 하시면 주문하신 메뉴에 대해'#13'포인트를 적립해드립니다';
      KioskPhoneKeyPadBF_F.Message1Label.Top     := KioskPhoneKeyPad_F.Message1Label.Top + 20;
      KioskPhoneKeyPadBF_F.Message2Label.Visible := false;
      KioskPhoneKeyPadBF_F.Message3Label.Visible := false;
      KioskPhoneKeyPadBF_F.CloseButton.Visible   := false;

      try
        Common.DoModalReset;
        vResult := KioskPhoneKeyPadBF_F.ShowModal;
        Common.DoModalClose;

        if vResult = mrNo then Exit;
        if vResult = mrOk then
          vTelNo := KioskPhoneKeyPadBF_F.KeyInLabel.Caption
        else
          vTelNo := '';
      finally
        FreeAndNil(KioskPhoneKeyPadBF_F);
        Common.DoModalClose;
        Common.Device.OnScannerReadData := ScannerReadEvent;
      end;
    end
    else
    begin
      KioskPhoneKeyPad_F := TKioskPhoneKeyPad_F.Create(Self);
      KioskPhoneKeyPad_F.Message1Label.Caption := '고객등록을 하시면 주문하신 메뉴에 대해'#13'포인트를 적립해드립니다';
      KioskPhoneKeyPad_F.Message1Label.Top     := KioskPhoneKeyPad_F.Message1Label.Top + 20;
      KioskPhoneKeyPad_F.Message2Label.Visible := false;
      KioskPhoneKeyPad_F.Message3Label.Visible := false;
      KioskPhoneKeyPad_F.CloseButton.Visible   := false;

      try
        Common.DoModalReset;
        vResult := KioskPhoneKeyPad_F.ShowModal;
        Common.DoModalClose;

        if vResult = mrNo then Exit;
        if vResult = mrOk then
          vTelNo := KioskPhoneKeyPad_F.KeyInLabel.Caption
        else
          vTelNo := '';
      finally
        FreeAndNil(KioskPhoneKeyPad_F);
        Common.DoModalClose;
        Common.Device.OnScannerReadData := ScannerReadEvent;
      end;
    end;

    if not IsMobileNumber(GetOnlyNumber(vTelNo)) then
    begin
      Common.ErrBox('전화번호를 정확히 입력하세요');
      Exit;
    end;

    if not Common.SaveMemberAdd(true,
                                '',
                                SetTelephone(vTelNo),
                                '001',
                                '0',
                                '',
                                GetOnlyNumber(vTelNo),
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                'N',
                                'N',
                                'Y',
                                '',
                                '',
                                'KIOSK 가입',
                                '',
                                '') then Exit;

    try
      Common.SelectMemberInfo('','',GetOnlyNumber(vTelNo));
      Common.MsgBox('회원가입이 정상 처리되었습니다');
    except
      on E: Exception do
      begin
        Common.WriteLog('MemberAdd001',E.Message);
        Common.ErrBox(E.Message+#13#13+'저장을 완료하지 못했습니다');
        Exit;
      end;
    end;
  finally
    if KioskBeginImageExist or (not KioskBeginImageExist and (GetOption(437) <> '0')) then
      Tmr_KioskWait.Enabled := true;
  end;
end;

function TOrder_F.KioskMemberSelect(aTelNo:String): Boolean;
var vCardNo, vTelNo :String;
begin
  Result := false;
  KioskKeyPad_F := TKioskKeyPad_F.Create(Self);
  KioskKeyPad_F.isPhoneNumber := GetOption(442) = '0';
  KioskKeyPad_F.isPassword    := false;
  if GetOption(442) = '0' then
    KioskKeyPad_F.MessageLabel.Caption := '전화번호를 입력하세요'
  else
    KioskKeyPad_F.MessageLabel.Caption := '카드번호 또는 전화번호를 입력하세요';
  try
    Common.DoModalReset;
    if KioskKeyPad_F.ShowModal <> mrOK then Exit;
    vTelNo := KioskKeyPad_F.KeyInLabel.Hint;
  finally
    FreeAndNil(KioskKeyPad_F);
    Common.DoModalClose;
    Common.Device.OnScannerReadData := ScannerReadEvent;
  end;

  if Common.Device.NFCData <> vTelNo then
    vTelNo := GetOnlyNumber(vTelNo);
  if (Length(vTelNo) < 9) and not Common.isMemberCardNo(vTelNo) and (Common.Device.NFCData <> vTelNo) then
  begin
    Common.MsgBox(Format('전화번호를 정확히 입력하세요'+#13'%s',[vTelNo]));
    Exit;
  end;

  if (aTelNo <> '') and (vTelNo <> GetOnlyNumber(Common.Member.MobileTel)) and (Common.Device.NFCData <> vTelNo) then
  begin
    Common.MsgBox(Format('주문 중인 회원이 아닙니다'+#13'%s',[vTelNo]));
    Exit;
  end;

  if Common.isMemberCardNo(vTelNo) or (Common.Device.NFCData = vTelNo) then
  begin
    vCardNo := vTelNo;
    vTelNo  := '';
    Common.Device.NFCData := '';
  end
  else
    vCardNo := '';

  Common.SelectMemberInfo('',vCardNo,vTelNo);
  if Common.Member.Code = '' then
  begin
    if (GetOption(421) = '1') then
    begin
      Common.DoModalReset;
      KioskMemberAdd_F := TKioskMemberAdd_F.Create(Self);
      if vTelNo <> '' then
        KioskMemberAdd_F.edt_Mobile.Text := SetTelephone(vTelNo);
      try
        if KioskMemberAdd_F.ShowModal <> mrOK then Exit;
      finally
        FreeAndNil(KioskMemberAdd_F);
        Common.DoModalClose;
      end;
    end
    else
    begin
      if vCardNo <> '' then
        vTelNo := vCardNo
      else
        vTelNo := SetTelephone(vTelNo);
      Common.MsgBox(Format('%s로'#13'등록된 회원이 없습니다',[vTelNo]));
    end;
  end
  else
  begin
    if not Common.AskBox(Format('%s 고객님이 맞습니까?',[Common.Member.Name])) then
    begin
      InitMemberRecord(Common.Member);
      Exit;
    end;
    Result    := true;
    WorkState := wsSale;
    DisplayPresent;
  end;
end;

procedure TOrder_F.KioskBarrierfreeWheelChairButtonClick(Sender: TObject);
begin
  if Sender = KioskBarrierfreeWheelChairButton then
    Common.Config.BarrierFreeMode := bfWheelChair
  else
    Common.Config.BarrierFreeMode := bfLowVision;
  Common.isBFChoose              := true;
  if KioskStoreButton.Visible and KioskTakeOutButton.Visible then
    Common.TextToSpeech('매장이용 또는 포장을 선택하세요. ')
  else if KioskStoreButton.Visible and not KioskTakeOutButton.Visible then
    KioskStoreButtonClick(KioskStoreButton)
  else if not KioskStoreButton.Visible and KioskTakeOutButton.Visible then
    KioskTakeOutButtonClick(KioskTakeOutButton)
  else
    KioskOrderStart(0);
  Tmr_KioskWait.Enabled := true;
end;

procedure TOrder_F.KioskBeginImageClick(Sender: TObject);
begin
  KioskOrderStart(0);
end;

procedure TOrder_F.Tmr_KioskWaitTimer(Sender: TObject);
var vTime :Integer;
begin
  if not Self.Active then Exit;

  if Common.Config.IsKiosk then
  begin
    if GetOption(437) = '0' then Exit;

    Tmr_KioskWait.Tag := Tmr_KioskWait.Tag + 1;
    if GetOption(437) = '1' then
      KioskWorkDateLabel.Badge  := IntToStr(30 - Tmr_KioskWait.Tag)
    else
      KioskWorkDateLabel.Badge  := IntToStr((StrToInt(GetOption(437))-1) * 60 - Tmr_KioskWait.Tag);
    KioskWorkDateLabel.BringToFront;

//대기화면에서 언어를 변경했을때 10초 지나면 다시 한국어로 바꾼다
    if (Common.Config.PosLanguage <> 'KO') and (Tmr_KioskWait.Tag > 10) and (KioskWaitPanel.Left = 0) then
      ThaiButtonClick(nil);


    //주문/결제 자동취소
    if GetOption(437) = '0' then Exit;
    case StoI(GetOption(437)) of
      1 : vTime := 30;
      2 : vTime := 60;
      3 : vTime := 120;
      4 : vTime := 180;
      5 : vTime := 240;
    end;
    if (vTime <= Tmr_KioskWait.Tag) then
    begin
      Tmr_KioskWait.Enabled := false;
      if not Common.AskBox('주문을 계속하시겠습니까?', 5) then
      begin
        Common.WriteLog('work', '전체취소(자동)');
        WorkState := wsReady;
        OrderListView;
        obtn_KioskClass1Click(nil);
        Tmr_KioskWait.Tag      := 0;
        if Common.KioskWaitImage = 'P' then
          KioskWaitPanel.Left := 0;
        if Common.Config.PosLanguage <> 'KO' then
          ThaiButtonClick(nil);
        Tmr_KioskWait.Enabled  := false;
        if KioskBeginImageExist then
        begin
          KioskPanel.Enabled := false;
          KioskWaitPanel.BringToFront
        end;
      end
      else
      begin
        Tmr_KioskWait.Tag     := 0;
        Tmr_KioskWait.Enabled := true;
      end;
    end;
  end
  else
  begin
    Tmr_KioskWait.Interval := 1000;
    Tmr_KioskWait.Tag := Tmr_KioskWait.Tag + 1;

    case StoI(GetOption(432)) of
      1 : vTime := 30;
      2 : vTime := 40;
      3 : vTime := 50;
      4 : vTime := 60;
      5 : vTime := 180;
    end;

    if (Tmr_KioskWait.Tag > vTime) then
    begin
      Tmr_KioskWait.Enabled := false;
      if not Common.AskBox('주문을 계속하시겠습니까?',5) then
      begin
        Tmr_KioskWait.Tag := 0;
        Common.WriteLog('work', '테이블 자동닫기');
        CloseButton.Click;
      end
      else
      begin
        Tmr_KioskWait.Tag     := 0;
      end;
    end;
  end;
end;

procedure TOrder_F.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
var vIndex, vCount, vCheckPos, vCheckCount :Integer;
    vPos : TPoint;
begin
  if Common.Config.IsKiosk then
  begin
    if (Msg.message = WM_LBUTTONDOWN)  then
    begin
      if (not KioskBeginImageExist and (GetOption(437) <> '0')) then
        Tmr_KioskWait.Enabled := true;

      Tmr_KioskWait.Tag := 0;
      isTouch           := true;
    end;
  end;
end;

procedure TOrder_F.AviTimerTimer(Sender: TObject);
var vFileName :String;
    WFileName: Array [0 .. 255] of WideChar;
    PFileName: PWideChar;
begin
  AviTimer.Enabled := false;
  StringToWideChar(Common.AppPath+'Kiosk\'+Common.KioskWaitImage, WFileName, 255);
  PFileName := @WFileName[0];

  // DSHOW 초기화
  if isFirst then
    ShutDownDs;

  // DSHOW 설정
  if SetupDs = False then
      Exit;

  isFirst := false;
  // 동영상 파일을 Render 하기
  if FilterGraph.RenderFile(PFileName, nil) = S_OK then
  begin
    // 영상을 플레이할 패널 지정 Screen = Panel
    VideoWindow.put_Owner(OAHWND(KioskWaitImagePanel.Handle));
    VideoWindow.put_WindowStyle(WS_CHILD or WS_CLIPSIBLINGS);
    VideoWindow.put_Width(KioskWaitImagePanel.Width);
    VideoWindow.put_Height(KioskWaitImagePanel.Height);
    VideoWindow.put_Top(0);
    VideoWindow.put_Left(0);

    // 이벤트 제어 연결하기
    MediaEvent.SetNotifyWindow(OAHWND(KioskWaitImagePanel.Handle),
      WM_GRAPHEVENT, 0);
    MediaEvent.SetNotifyFlags(0);

    // 재생
    MediaControl.Run;
    SetVolume(0);
  end;
end;

procedure TOrder_F.BackButtonClick(Sender: TObject);
begin
  PluMenuPanel.Visible := false;
  BackButton.Visible   := false;
end;

procedure TOrder_F.WMCopyData(var Msg:TWmCopyData);
begin
  FMenuCode := PAnsiChar(Msg.CopyDataStruct.lpData);
  if Copy(FMenuCode,1,16) = 'LetsOrderTakeOut' then
  begin
    if LetsOrderButtonRow >= 0 then
      FunctionButton[LetsOrderButtonRow, LetsOrderButtonCol].Picture.Assign(ImageCollection.Items[7].Picture);
    Exit;
  end
  else if (GetOption(488) = '1') and Common.Config.IsKiosk and (LeftStr(FMenuCode,5) = 'ORDER') then
  begin
    if (KioskWaitPanel.Left <> 0) then Exit;
    KioskTableCreate(true);
    Exit;
  end
  else if LeftStr(FMenuCode,5) = 'ORDER' then
    Exit;

  SelectMenu(0);
  OrderListView;
end;

procedure TOrder_F.Action37Execute(Sender: TObject);
var vOrderFinished :Boolean;
label Loop;
begin
   //마감 상태였으면 초기화한다
  if WorkState = wsMagam then WorkState := wsReady;

Loop:
  MenuSearch2_F := TMenuSearch2_F.Create(Self);
  if MenuSearch2_F.ShowModal = mrOK then
  begin
    vOrderFinished := false;
    FMenuCode :=  MenuSearch2_F.SelectCode;
    SelectMenu(0);
  end
  else
    vOrderFinished := true;

  if not vOrderFinished then Goto Loop;
  FreeAndNil(MenuSearch2_F);
  ReDrowGridTitle;
end;

procedure TOrder_F.SetKioskBeginImage;
var vIndex  :Integer;
label Loop;
begin
  while Assigned(KioskBillInfo_F) and KioskBillInfo_F.Showing do
    Application.ProcessMessages;

  if Common.KioskWaitImage <> 'P' then
  begin
    isFirst := true;
    AviTimerTimer(nil);
  end;

  if Common.KioskWaitImage = 'P' then
  begin
    Tmr_KioskWait.Enabled := false;
    //대기 이미지가 없을때
    if not KioskBeginImageExist then
    begin
      KioskWaitPanel.Left := 0;
      if GetOption(488) = '1' then
        KioskTableCreate(true);
      Tmr_KioskWait.Enabled  := false;
      KioskPanel.Enabled := false;
      Exit;
    end;
    Loop:
    if (KioskBeginImageIndex+1) < KioskBeginImageCount then
      KioskBeginImageIndex := KioskBeginImageIndex + 1
    else if (KioskBeginImageCount > 1) and ((KioskBeginImageIndex+1) = KioskBeginImageCount) then
      KioskBeginImageIndex := 0;

    if KioskBeginImageIndex = 0 then
      Common.SetPNGImage(KisokWaitImage, Common.KioskWaitList.Strings[0])
    else
    begin
      Common.SetPNGImage(KisokWaitImage, Common.KioskWaitList.Strings[KioskBeginImageIndex]);
    end;

    KisokWaitImage.SendToBack;
  end;

  KioskWaitPanel.Left := 0;
  if GetOption(488) = '1' then
    KioskTableCreate(true);

  KioskPanel.Enabled     := false;
  if Common.KioskWaitImage = 'P' then
    Tmr_KioskImageChange.Enabled := true;
end;

function TOrder_F.KioskTableSelect:Boolean;
label Loop;
begin
Loop:
  Result := False;
  if (GetOption(426) = '1') or (GetOption(426) = '2') then
  begin
    Common.MsgBox('이용하실 테이블을'#13+'먼저 잡고 주문해 주세요');
    Common.DoModalReset;
    with TKioskTable_F.Create(Self) do
      try
        case ShowModal of
          mrOK:
          begin
            InitTableRecord(Common.Table);
            OpenQuery('select NM_CODE1, '
                     +'       GetTableName(:P0, :P1) as NM_TABLE '
                     +'  from MS_CODE  '
                     +' where CD_STORE =:P0 '
                     +'   and CD_KIND  =''03'' '
                     +'   and CD_CODE  =:P2 ',
                     [Common.Config.StoreCode,
                      TableNo,
                      Common.Table.Floor]);
            if not Common.Query.Eof then
            begin
              Common.Table.FloorName  := Common.Query.Fields[0].AsString;
              Common.Table.Number     := TableNo;
              Common.Table.Name       := Common.Query.Fields[1].AsString;
              Common.Config.IsTakeOut := false;
              Result := true;
            end
            else
              Common.ErrBox('선택한 테이블 존재하지 않습니다');
            Common.Query.Close;
          end;
          mrCancel : Exit;
        end;
      finally
        Free;
      end;
    Common.DoModalClose;
  end
  else
  begin
   Common.DoModalReset;
    KioskKeyPad_F := TKioskKeyPad_F.Create(Self);
    KioskKeyPad_F.MessageLabel.Caption := '테이블 번호를 입력하세요';
    KioskKeyPad_F.isPassword           := false;
    try
      if KioskKeyPad_F.ShowModal <> mrOK then Exit;
      if KioskKeyPad_F.KeyInLabel.Hint <> '' then
      begin
        InitTableRecord(Common.Table);
        OpenQuery('select b.NM_CODE1, '
                 +'       a.NO_TABLE, '
                 +'       GetTableName(a.CD_STORE, a.NO_TABLE) as NM_TABLE, '
                 +'       a.YN_TABLEHOLD '
                 +'  from MS_TABLE as a inner join '
                 +'       MS_CODE  as b on b.CD_STORE = a.CD_STORE '
                 +'                    and b.CD_KIND  = ''03'' '
                 +'                    and b.CD_STORE = a.CD_FLOOR '
                 +' where a.CD_STORE =:P0 '
                 +'   and a.NO_TABLE =:P1 ',
                 [Common.Config.StoreCode,
                  KioskKeyPad_F.KeyInLabel.Hint]);
        if not Common.Query.Eof then
        begin
          if Common.Query.Fields[2].AsString = 'Y' then
          begin
            Result := false;
            Common.MsgBox('현재 사용중인 테이블입니다'#13'다른 테이블을 선택해주세요',5)
          end
          else
          begin
            Common.Table.FloorName  := Common.Query.Fields[0].AsString;
            Common.Table.Number     := Common.Query.Fields[1].AsInteger;
            Common.Table.Name       := Common.Query.Fields[2].AsString;
            Common.Config.IsTakeOut := false;
            Result := true;
          end;
        end
        else
        begin
          Result := false;
          Common.ErrBox('선택한 테이블 존재하지 않습니다');
        end;
      end
      else
      begin
        Result := false;
      end;
      Common.Query.Close;
    finally
      FreeAndNil(KioskKeyPad_F);
      Common.DoModalClose;
      Common.Device.OnScannerReadData := ScannerReadEvent;
    end;
  end;

  if not Result then
  begin
    if Common.AskBox('테이블을 다시 선택하시겠습니까?') then
      goto Loop;

    Exit;
  end;
end;

procedure TOrder_F.KioskCallButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  if Assigned(KioskBillInfo_F) then
  begin
    if KioskBillInfo_F.Showing then
      KioskBillInfo_F.Hide;
  end;

 if Common.KakaoSendMessage('K',['관리자호출'+#13
                         +Format('%s 키오스크에서'#13'관리자를 호출하였습니다',[Common.Config.PosNo])+#13
                         +FormatDateTime('yyyy-mm-dd hh:nn:ss', now())],'') then
  Common.MsgBox('관리자를 호출하였습니다'#13'잠시만 기다려 주세요');
end;

procedure TOrder_F.KioskCardButtonClick(Sender: TObject);
var vResult :TModalResult;
    vError :Boolean;
    vResultPay :Integer;
    vMsg, vMsg1, vMsg2, vMsg3, vMsg4, vMsg5, vMsg6 :String;
begin
  if MilliSecondsBetween(Now(),ClickTime) < 100 then Exit;
  ClickTime := Now;

  vError := true;
  if not IsDebuggerPresent then
    BlockInput(true);
  Common.Device.OnScannerReadData := nil;
  Common.KioskTouchBeep('kioskwave12');
  if Sender = KioskCardButton then
    Common.WriteLog('work', '카드결제버튼')
  else
    Common.WriteLog('work', '간편결제버튼');

  if Assigned(KioskBillInfo_F) then
  begin
    if KioskBillInfo_F.Showing then
      KioskBillInfo_F.Hide;
  end;

  try
    KioskPanel.Enabled    := false;
    Tmr_KioskWait.Enabled := false;
    if Main_sGrd.Cells[0,0] = '' then
    begin
      Common.MsgBox('메뉴를 먼저 주문하세요');
      Exit;
    end;
    Common.isFallBack := false;

    if (GetOption(379) = '1') then
    begin
      Common.MsgBox('단말기연동은 키오스크를 사용할 수 없습니다');
      Exit;
    end;

    if (GetOption(379) = '1') then
    begin
      Common.MsgBox('비보안은 키오스크를 사용할 수 없습니다');
      Exit;
    end;

    //당일재고 확인
    if GetOption(491) = '1' then
    begin
      if not KioskMenuLimitCheck then Exit;
    end;

    KioskMenuOrder;

    if (Common.Member.Code = '') and (GetOption(418) = '1') then
    begin
      if GetOption(21) = '1' then
      begin
        if Common.AskBox('스템프를 적립하시겠습니까?',10) then
          if not KioskMemberSelect then
          begin
            InitMemberRecord(Common.Member);
            Exit;
          end;    end
      else
      begin
        if Common.AskBox('포인트를 적립하시겠습니까?',10) then
          if not KioskMemberSelect then
          begin
            InitMemberRecord(Common.Member);
            Exit;
          end;
      end;
    end;

    //계산시 호출 전화번호를 입력 받을때
    if (GetOption(236) = '1') then
    begin
      if (Common.Member.MobileTel <> '') and Common.AskBox('동일번호로 알림톡을'#13'받으시겠습니까?') then
        Common.PreSent.CallTelNo := Common.Member.MobileTel
      else
      begin
        if Common.Config.BarrierFreeMode = bfWheelChair then
        begin
          KioskPhoneKeyPadBF_F := TKioskPhoneKeyPadBF_F.Create(Self);
          KioskPhoneKeyPadBF_F.MessageLabel.Caption  := Common.GetPaPago('휴대폰 번호 입력');
          KioskPhoneKeyPadBF_F.Message1Label.Caption := Common.GetPaPago('입력한 휴대폰 번호로 메뉴가 준비되면');
          KioskPhoneKeyPadBF_F.Message2Label.Caption := Common.GetPaPago('카카오톡/SMS');
          KioskPhoneKeyPadBF_F.Message3Label.Caption := Common.GetPaPago('로 알려드립니다.');
          KioskPhoneKeyPadBF_F.AgreeLabel.Caption    := Common.GetPaPago('개인정보 수집 및 이용동의');
          try
            Common.DoModalReset;
            vResult := KioskPhoneKeyPadBF_F.ShowModal;
            Common.DoModalClose;

            if vResult = mrNo then Exit;
            if vResult = mrOk then
              Common.PreSent.CallTelNo := KioskPhoneKeyPadBF_F.KeyInLabel.Hint
            else
              Common.PreSent.CallTelNo := '';
          finally
            FreeAndNil(KioskPhoneKeyPadBF_F);
            Common.Device.OnScannerReadData := ScannerReadEvent;
          end;
        end
        else
        begin
          KioskPhoneKeyPad_F := TKioskPhoneKeyPad_F.Create(Self);
          KioskPhoneKeyPad_F.MessageLabel.Caption  := Common.GetPaPago('휴대폰 번호 입력');
          KioskPhoneKeyPad_F.Message1Label.Caption := Common.GetPaPago('입력한 휴대폰 번호로 메뉴가 준비되면');
          KioskPhoneKeyPad_F.Message2Label.Caption := Common.GetPaPago('카카오톡/SMS');
          KioskPhoneKeyPad_F.Message3Label.Caption := Common.GetPaPago('로 알려드립니다.');
          KioskPhoneKeyPad_F.AgreeLabel.Caption    := Common.GetPaPago('개인정보 수집 및 이용동의');
          try
            Common.DoModalReset;
            vResult := KioskPhoneKeyPad_F.ShowModal;
            Common.DoModalClose;

            if vResult = mrNo then Exit;
            if vResult = mrOk then
              Common.PreSent.CallTelNo := KioskPhoneKeyPad_F.KeyInLabel.Hint
            else
              Common.PreSent.CallTelNo := '';
          finally
            FreeAndNil(KioskPhoneKeyPad_F);
            Common.Device.OnScannerReadData := ScannerReadEvent;
          end;
        end;
      end;

      if (GetOption(493) = '1') and (Common.PreSent.CallTelNo <> '') then
      begin
        with TIniFile.Create(Common.AppPath+'Kiosk\KioskConfig.ini') do
        try
          vMsg1 := ReadString('카카오확인','문구1','주문하신 메뉴가 준비되면');
          vMsg2 := ReadString('카카오확인','문구2','카카오 알림톡으로 안내해 드리겠습니다');
          vMsg3 := ReadString('카카오확인','문구3','');
          vMsg4 := ReadString('카카오확인','문구4','');
          vMsg5 := ReadString('카카오확인','문구5','');
          vMsg6 := ReadString('카카오확인','문구6','');

          WriteString('카카오확인','문구1',vMsg1);
          WriteString('카카오확인','문구2',vMsg2);
          WriteString('카카오확인','문구3',vMsg3);
          WriteString('카카오확인','문구4',vMsg4);
          WriteString('카카오확인','문구5',vMsg5);
          WriteString('카카오확인','문구6',vMsg6);
        finally
          Free;
        end;
        vMsg := vMsg1;
        if vMsg2 <> '' then
          vMsg := vMsg + #13 + vMsg2;
        if vMsg3 <> '' then
          vMsg := vMsg + #13 + vMsg3;
        if vMsg4 <> '' then
          vMsg := vMsg + #13 + vMsg4;
        if vMsg5 <> '' then
          vMsg := vMsg + #13 + vMsg5;
        if vMsg6 <> '' then
          vMsg := vMsg + #13 + vMsg6;
        Common.MsgBox(vMsg);
      end;
    end;

    if not IsDebuggerPresent then
      BlockInput(true);

    if KioskDefaultOrderType = otTakeOut then
    begin
      Common.Table.Packing      := 'Y';
      Common.KioskTable.Packing := 'Y';
    end;

    //당일재고 확인
    if GetOption(491) = '1' then
    begin
      if not KioskMenuLimitCheck then Exit;
    end;

    if GetOption(425) = '0' then
    begin
      KioskOrderConfirm_F := TKioskOrderConfirm_F.Create(Self);
      try
        KioskOrderConfirm_F.TableUse   := (GetOption(426) = '1') and (KioskDefaultOrderType <> otTakeOut);
        KioskOrderConfirm_F.AskPacking := GetOption(424) = '1';
        Common.DoModalReset;
        if KioskOrderConfirm_F.ShowModal <> mrOK then Exit;
      finally
        Common.DoModalClose;
        FreeAndNil(KioskOrderConfirm_F);
      end;

//424옵션
//0. 사용안함
//1. "주문하기" 사용
//2. "먹고갈게요", "포장해 갈게요"


// 426 옵션
//  0. 선택을 사용하지 않습니다
//  1. 주문 완료 시 선택합니다.
//  2. 주문 시작 시 선택합니다.(대기화면사용시)
//  3. 주문 완료 시 선택(테이블번호입력)
//  4. 주문 시작 시 선택.(대기화면사용시)(테이별번호 입력)
//  5. 대기화면에서 테이블을 선택합니다.

//      if GetOption(426) = '4' then
//      begin
//        Common.Table := Common.KioskTable;
//        Common.Config.IsTakeOut := false;
//      end;
//      //  키오스크에서 테이블 선택
//      if (GetOption(426) = '3') and (KioskDefaultOrderType = otStore) then
//      begin
//        Common.Table := Common.KioskTable;
//        Common.Config.IsTakeOut := false;
//      end;
    end
    else if (GetOption(424) = '0') and (((GetOption(426) = '1') and (KioskDefaultOrderType <> otTakeOut)) or (GetOption(426) = '3')) then
    begin
      if not KioskTableSelect then Exit;
    end
    else if (GetOption(424) = '0') and (GetOption(236) = '1') then
      Common.DoModalClose;

    if not IsDebuggerPresent then
      BlockInput(true);

    if Common.PreSent.TotalAmt = 0 then
      Exit;

    vResultPay := 0;
    if (GetOption(481)= '1') and (Sender <> KioskEasyPayButton) then
    begin
      with TKioskPay_F.Create(Self) do
        try
          Common.DoModalReset;
          if ShowModal <> mrOK then Exit;
          vResultPay := ResultPay;
        finally
          Common.DoModalClose;
          Free;
        end;
    end;

    if (vResultPay = 3) and (Common.PreSent.WRcvAmt > 0) then //현금결제
    begin
      Common.WriteLog('work', Format('현금결제(%d)',[Common.PreSent.TotalAmt]));
      if not SetKioskCash then
      begin
        Common.MsgBox('잔돈지급기에 문제가 있습니다'#13'잠시 후 다시 시도하세요');
        Exit;
      end;
      if Common.Config.KioskCashPause then
      begin
        Common.MsgBox('잔돈이 부족합니다'#13'신용카드로만 결제가 가능합니다');
        Exit;
      end;

      with TKioskCash_F.Create(Self) do
       try
         SaleAmt := Common.PreSent.WRcvAmt;
         if ShowModal <> mrOK then Exit;
       finally
         Common.Device.OnDispenserReadData :=DispenserReadEvent;
         Free;
       end;
    end
    else if (vResultPay = 2) or (Sender = KioskEasyPayButton) then
    begin
      Common.WriteLog('work', Format('간편결제(%d)',[Common.PreSent.TotalAmt]));
      if not KioskCardExecute(true) then
        Exit;
    end
    else
    begin
      Common.WriteLog('work', Format('신용카드(%d)',[Common.PreSent.TotalAmt]));
      if not KioskCardExecute then
        Exit;
    end;
    vError := false;
  finally
    KioskPanel.Enabled    := true;
    if vError then
    begin
      BlockInput(false);
      Common.Device.OnScannerReadData := ScannerReadEvent;
      Self.Enabled          := true;
      if KioskBeginImageExist or (not KioskBeginImageExist and (GetOption(437) <> '0')) then
        Tmr_KioskWait.Enabled := true;
    end;
    if vResultPay = 3 then
      DisplayPresent;
  end;

  try
    KioskPanel.Enabled    := false;
    FinishExecute('15');
    if Act_Enter.HelpKeyword = 'Error' then
      FinishExecute('16',true);

    //호출번호 기능을 사용하면서 호출번호가 있을때
    if (GetOption(490)='1') or ((GetOption(311)='1') and (Common.PreSent.CallNo > 0)) then
    begin
      if not Assigned(KioskBillInfo_F) then
        Application.CreateForm(TKioskBillInfo_F, KioskBillInfo_F);
      KioskBillInfo_F.Show;
    end;
    Common.Config.IsTakeOut := true;
    WorkState := wsReady;
    OrderListView;

    if KioskBeginImageExist then
      SetKioskBeginImage;

    ThaiButtonClick(nil);
  finally

    Common.Config.IsTakeOut := true;
    BlockInput(false);
    KioskPanel.Enabled      := true;
    Common.Device.OnScannerReadData := ScannerReadEvent;
  end;
end;

function TOrder_F.KioskCardExecute(aEasyPay:Boolean):Boolean;
var visTax :Boolean;
    vLoop :Boolean;
    vTaxRate :Currency;
label Loop;
begin
  Result := False;

  with Common.ICCard do
  begin
    FocusHandle := Self.Handle;
    ClearAll;
    KioskSound  := not aEasyPay;
    case Common.Config.van_trd of
      0 : VAN    := vtKOCES;
      1 : VAN    := vtDaou;
      2 : VAN    := vtNICE;
      3 : VAN    := vtKICC;
      4 : VAN    := vtKIS;
      5 : VAN    := vtKSNET;
      6 : VAN    := vtKCP;
      7 : VAN    := vtFDIK;
      8 : VAN    := vtJTNET;
      9 : VAN    := vtKFTC;
     10 : VAN    := vtSmartro;
     11 : VAN    := vtKOVAN;
     12 : VAN    := vtSPC;
    end;

    KioskPOS := Common.Config.IsKiosk;
    Approval   := true;

    //부가세를 아래에서 계산해야할지 말지
    visTax := false;
    SaleAmt    := Common.Present.WRcvAmt;
    SvcAmt     := Common.Present.TipAmt;

Loop:
  vLoop := false;

    Common.Card.Ds_Trd := dtApproval;
    case Common.Config.van_trd of
      0 : VAN    := vtKOCES;
      1 : VAN    := vtDaou;
      2 : VAN    := vtNICE;
      3 : VAN    := vtKICC;
      4 : VAN    := vtKIS;
      5 : VAN    := vtKSNET;
      6 : VAN    := vtKCP;
      7 : VAN    := vtFDIK;
      8 : VAN    := vtJTNET;
      9 : VAN    := vtKFTC;
     10 : VAN    := vtSmartro;
     11 : VAN    := vtKOVAN;
     12 : VAN    := vtSPC;
    end;
    Parent     := Self;
    KioskPOS   := true;
    Approval   := true;
    if GetOption(379) = '2' then
      AppType := atVCatCard
    else
      AppType    := atCard;
    WorkDate   := Common.WorkDate;
    SaleDate   := FormatDateTime('yyyymmdd',Now());
    TerminalID := Common.Config.van_Terid;
    BizNo      := GetOnlyNumber(Common.Config.BizNo);
    PosVer     := GetFileVersion(Application.ExeName);
    SerialNo   := Common.Config.SerialNo;
    PosNo      := Common.Config.PosNo;
    CatPort    := StoI(Common.Config.ReceiptPrinterPort);
    UnionPay   := false;
    CardTrack2 := Common.Card.CardNoFull;

    HalbuMonth := 0;

    LogPath    := Common.AppPath;
    Valid      := Common.Card.Valid;

    //합계금액과 받을금액이 같으면서 승인금액도 같을때
    if Approval and (GetOption(60) = '0') and (Common.PreSent.RcvAmt = 0) and (SaleAmt = Common.PreSent.WRcvAmt)
      and ((Common.PreSent.TotalAmt+Ifthen(GetOption(160)='0', Common.PreSent.TipAmt, 0) - Common.PreSent.TotalDc) = Common.PreSent.WRcvAmt) then
    begin
      VatAmt := Abs(Common.PreSent.TaxAmt);
    end
    else if not Approval then
      VatAmt := Abs(Common.Card.VatAmt)
    else if Approval and not visTax then
    begin
      //POS에 밴설정이 과세이거나 전체금액이 면세가 아닐때
      if (Common.PreSent.TaxAmt > 0) or ((GetOption(60) = '1') ) then
      begin
        if Approval and (Common.PreSent.RcvAmt = 0) and (SaleAmt = Common.PreSent.WRcvAmt)
          and ((Common.PreSent.TotalAmt+Ifthen(GetOption(160)='0', Common.PreSent.TipAmt, 0) - Common.PreSent.TotalDc) = Common.PreSent.WRcvAmt) then
          VatAmt := Common.PreSent.TaxAmt
        else
        begin
          vTaxRate := Common.PreSent.DutyAmt / (Common.PreSent.TotalAmt+ Ifthen(GetOption(160)='0', Common.PreSent.TipAmt, 0) - Common.PreSent.TotalDc);
          VatAmt   := FtoI(hTrunc( (SaleAmt * vTaxRate) / 11 ,1));
        end;
      end
      else
        VatAmt := 0;
    end;

    if GetOption(379) = vanVCat then
      AppType := atVCatCard
    else
      AppType    := atCard;

    if aEasyPay then
    begin
      try
        KioskEasyPay_F  := TKioskEasyPay_F.Create(Application);
        Common.DoModalReset;
        if KioskEasyPay_F.ShowModal <> mrOK then
          Exit;
        EasyPayCode := KioskEasyPay_F.PayCode;
        EasyPay     := true;
      finally
        Common.DoModalClose;
        FreeAndNil(KioskEasyPay_F);
      end;
    end
    else
      Common.KioskTouchBeep('CardIn');


    try
      if not Execute then
      begin
        if VAN in [vtSPC, vtKFTC] then
        begin
          if Assigned(KioskCard_F) then
          begin
            PlaySound(nil, 0, SND_MEMORY or SND_ASYNC);
            KioskCard_F.Close;
            FreeAndNil(KioskCard_F);
            Common.DoModalClose;
          end;
        end;
        if Note <> EmptyStr then
        begin
          if Common.AskBox(Note+#13+'다시 시도하시겠습니까?',10) then
          begin
            BlockInput(true);
            vLoop := true;
          end
          else
            Exit;
        end
        else
          Exit;
      end
      else
      begin
        Common.Card.Type_Trd := atSwipe;
        Common.Card.RealMode      := RealMode;
        Common.Card.Ds_Card       := Ifthen(CardType='','C',CardType);
        Common.Card.CardNo        := Common.ICCard.CardNo;
        Common.Card.cd_buy        := CompCode;       // 매입사코드
        Common.Card.nm_buy        := CompName;       // 매입사이름
        Common.Card.Nm_Card       := BalgupsaName;   // 발급사이름
        Common.Card.ApprovalNo    := AgreeNo;        // 승인번호
        Common.Card.Halbu         := FormatFloat('00',HalbuMonth); // 할부개월
        Common.Card.Amt           := AgreeAmt;       // 승인금액
        Common.Card.DcAmt         := AgreeDcAmt;
        Common.Card.TipAmt        := SvcAmt;         // SvcAmt;취소시에 봉사료금액을 안넣는 밴사가 있어서(키오스크는 승인만)
        Common.Card.VatAmt        := VatAmt;
        Common.Card.ChainPL       := KamaengNo;      // 가맹점번호
        Common.Card.Trd_Date      := AgreeDate;      // 승인일자
        Common.Card.Trd_Time      := AgreeTime;      // 승인시간
        Common.Card.ImgFile       := ImgFileName;    // 전자서명화일명
        Common.Card.Note          := Note;
        Common.Card.BalanceAmt    := BalanceAmt;
        Common.Card.Yn_UnionPay   := 'N';
        Common.Card.TransNo       := TransNo;
        Common.Card.PayCode       := PayCode;
        Common.Card.EasyPayNo     := EasyPayNo;
        Common.Card.DsDc          := DsDiscount;
        Common.WriteLog('work', Format('정상승인 - 카드번호[%s]승인번호[%s]승인금액[%d]',[Common.Card.CardNo, Common.Card.ApprovalNo, Common.Card.Amt]));
        //토스일때
        if LeftStr(Common.Card.CardNo,7) = '7055000' then
          Common.Card.Nm_Card := '토스페이';

        ErrMsg                    := Note;
        Result := True;

        Common.CardInfoSave;
        //카드봉사료
        Common.PreSent.CardTipAmt := Common.PreSent.CardTipAmt + SvcAmt;
        Common.PreSent.CashTipAmt := Common.PreSent.CashTipAmt - Common.PreSent.CardTipAmt;
        Common.PreSent.CardAmt    := Common.PreSent.CardAmt + Common.Card.Amt;
//        Common.PreSent.KaKaoDc    := Common.Card.DcAmt;
        DisplayPresent;
        PlaySound(nil, 0, SND_MEMORY or SND_ASYNC);
        PlaySound(PChar('FinishWave'), Common.DllHandle, SND_RESOURCE or SND_ASYNC);
      end;
    finally
    end;

    if vLoop then
      Goto Loop;
    ClearAll;

  end;
end;

procedure TOrder_F.KioskMenuOrder;
var vIndex :Integer;
    vExist :Boolean;
begin
  vExist := false;
  if Common.Config.KioskMustMenuCode <> '' then
  begin
    for vIndex := 0 to Common.Summary_sGrd.RowCount-1 do
    begin
      if Common.Summary_sGrd.Cells[GDM_CD_MENU, vIndex] = Common.Config.KioskMustMenuCode then
      begin
        vExist := true;
        Break;
      end;
    end;

    if not vExist and Common.AskBox(Format('%s 상품을 추가하시겠습니까?',[Common.Config.KioskMustMenuName])) then
    begin
      FMenuCode    := Common.Config.KioskMustMenuCode;
      SelectMenu(0);
      OrderListView;
    end;
  end;

end;

procedure TOrder_F.Tmr_KioskImageChangeTimer(Sender: TObject);
begin
  Tmr_KioskImageChange.Tag := Tmr_KioskImageChange.Tag + 1;
  if Tmr_KioskImageChange.Tag > KioskBeginImageChangeTime then
  begin
    SetKioskBeginImage;
    Tmr_KioskImageChange.Tag := 0;
  end;
end;

procedure TOrder_F.Tmr_KioskStartTimer(Sender: TObject);
begin
  Tmr_KioskStart.Enabled := false;
  if KioskBeginImageExist then
  begin
    SetKioskBeginImage;
    KioskWaitPanel.BringToFront
  end;

  //배리어프리 선택
  if Common.isBFKiosk and (Common.Config.BarrierFreeMode = bfNone) then
  begin
    KioskBarrierfreeWheelChairButton.Visible     := true;
    KioskBarrierfreeLowVisionButton.Visible    := true;
  end
  else if Common.isBFKiosk then
    KioskOrderStart(KioskStartKey);

  //배리어프리 선택시
//  if Self.Tag = 999 then
//    KioskOrderStart(KioskStartKey);
end;

procedure TOrder_F.GridNextButtonClick(Sender: TObject);
begin
  if Sender <> nil then
    Common.RowNext(Main_sGrd);
  SetRowSelect('+');
end;

procedure TOrder_F.GridPriorButtonClick(Sender: TObject);
begin
  if Sender <> nil then
    Common.RowPrev(Main_sGrd);
  SetRowSelect('-');
end;

procedure TOrder_F.GroupCloseButtonClick(Sender: TObject);
begin
  GroupOrderPanel.Visible := false;
  DisplayPresent;
end;

procedure TOrder_F.GroupOrderPanelCaptionClick(Sender: TObject);
begin
  GroupOrderPanel.Visible := false;
end;

procedure TOrder_F.GroupTable_sGrdClick(Sender: TObject);
var vTableNo :Integer;
var vRow :Integer;
    vQuery :TUniQuery;
begin
  if GroupOrderPanel.Visible and (StrToInt(GroupTable_sGrd.Cells[2, GroupTable_sGrd.Row]) = GroupOrderPanel.Tag) then
  begin
    DisplayPresent;
    GroupOrderPanel.Visible := false;
    Exit;
  end;

  vTableNo := StrToInt(GroupTable_sGrd.Cells[2, GroupTable_sGrd.Row]);
  GroupOrderPanel.Tag    := vTableNo;
  GroupOrderPanel.Caption.Text := Format('<P align="center"><FONT size="14"></FONT> %s 테이블 주문내역</P>',[GroupTable_sGrd.Cells[0, GroupTable_sGrd.Row]]);
  GroupOrderPanel.Visible := true;
  try
    vQuery := TUniQuery.Create(Application);
    vQuery.Connection := DM.UniConnection;

    //기존주문내역을 불러온다
    with Main_sGrd, Common.PreSent, Common do
    begin
      vQuery.SQL.Text := 'select  a.CD_MENU, '
                        +'      	a.NM_MENU, '
                        +'        b.NM_MENU_KITCHEN, '
                        +'      	a.DS_MENU_TYPE, '
                        +'      	a.NO_STEP, '
                        +'      	a.CD_MENU1, '
                        +'      	a.SEQ, '
                        +Ifthen(GetOption(194)='1','GetSalePrice(a.CD_STORE, a.CD_MENU) as PR_SALE, ', 'a.PR_SALE, ')
                        +'        case when b.PR_SALE_PACKING = 0 then b.PR_SALE else b.PR_SALE_PACKING end PR_SALE_PACKING , '
                        +'      	a.QTY_ORDER, '
                        +'      	a.AMT_ORDER, '
                        +'        a.PR_ITEM, '
                        +'        a.CD_ITEM, '
                        +'        a.DS_SALE, '
                        +'        b.PR_TIP, '
                        +'        a.DS_TAX, '
                        +'        a.QTY_NEPUM, '
                        +'        b.CONFIG, '
                        +'        b.CD_PRINTER, '
                        +'        Date_Format(a.DT_CHANGE, ''%Y%m%d%H%i'') as DT_ORDER, '
                        +'        a.NO_SPC, '
                        +'        a.DC_SPC, '
                        +'        a.DC_MENU, '
                        +'        a.MEMO, '
                        +'        b.DS_KITCHEN, '
                        +'        b.NO_GROUP, '
                        +'        b.PR_SALE_DOUBLE, '
                        +'        a.PR_SALE_ORG, '
                        +'        b.CD_CORNER, '
                        +'        a.YN_DOUBLE, '
                        +'        b.PR_BUY, '
                        +'        b.PR_SALE_PROFIT, '
                        +'        a.CD_SERVICE, '
                        +'        b.SAVE_STAMP, '
                        +'        b.USE_STAMP '
                        +'  from SL_ORDER_D a  inner join '
                        +'       MS_MENU    b  on b.CD_STORE = a.CD_STORE '
                        +' 	                  and b.CD_MENU  = a.CD_MENU '
                        +' where a.CD_STORE =:P0 '
                        +'   and a.NO_TABLE =:P1 '
                        +'   and a.DS_ORDER =:P2 '
                        +Ifthen(GetOption(164) = '0', 'order by a.SEQ', 'order by b.BILL_SEQ, a.CD_MENU');
      vQuery.ParamByName('P0').AsString  := Common.Config.StoreCode;
      vQuery.ParamByName('P1').AsInteger := vTableNo;
      vQuery.ParamByName('P2').AsString  := 'T';
      vQuery.Open;

      Common.ClearGrid(GroupOrder_sGrd);
      while not vQuery.Eof do
      begin
        InitMenuRecord(Common.Menu);
        Menu.cd_menu     := vQuery.FieldByName('CD_MENU').AsString;
        Menu.nm_menu     := vQuery.FieldByName('NM_MENU').AsString;
        Menu.ds_menu     := vQuery.FieldByName('DS_MENU_TYPE').AsString;
        Menu.no_step     := vQuery.FieldByName('NO_STEP').AsInteger;
        Menu.cd_menu1    := vQuery.FieldByName('CD_MENU1').AsString;
        Menu.seq         := vQuery.FieldByName('SEQ').AsInteger;
        Menu.pr_sale     := vQuery.FieldByName('PR_SALE').AsInteger;    //상품단가
        Menu.qty_sale    := vQuery.FieldByName('QTY_ORDER').AsInteger;

        MainGrid_add(GroupOrder_sGrd);
        vQuery.Next;
      end;
      vQuery.Close;
    end;
  finally
    InitMenuRecord(Common.Menu);
    DisplayPresent;
    vQuery.Close;
    vQuery.Free;
  end;
end;

procedure TOrder_F.KioskCashButtonClick(Sender: TObject);
var vError :Boolean;
    vResult :TModalResult;
begin
  if Sender <> nil then
    if MilliSecondsBetween(Now(),ClickTime) < 100 then Exit;

  ClickTime := Now;
  vError    := true;
  if not IsDebuggerPresent then
    BlockInput(true);
  Common.Device.OnScannerReadData := nil;
  if Sender <> nil then
    Common.KioskTouchBeep('kioskwave12');

  if Assigned(KioskBillInfo_F) then
  begin
    if KioskBillInfo_F.Showing then
      KioskBillInfo_F.Hide;
  end;

  Common.WriteLog('work', '현금결제버튼');

  try
    KioskPanel.Enabled    := false;

    Tmr_KioskWait.Enabled := false;
    if Main_sGrd.Cells[0,0] = '' then
    begin
      Common.MsgBox('메뉴를 먼저 주문하세요');
      Exit;
    end;

    //당일재고 확인
    if (Sender <> nil) and (GetOption(491) = '1') then
    begin
      if not KioskMenuLimitCheck then Exit;
    end;

    if Common.PreSent.WRcvAmt > 0 then
    begin
      if not SetKioskCash then
      begin
        Common.MsgBox('잔돈지급기에 문제가 있습니다'#13'잠시 후 다시 시도하세요');
        Exit;
      end;

      if Common.Config.KioskCashPause then
      begin
        Common.MsgBox('잔돈이 부족합니다'#13'신용카드로만 결제가 가능합니다');
        Exit;
      end;

      KioskMenuOrder;

      if (Common.Member.Code = '') and (GetOption(418) = '1') then
      begin
        if GetOption(21) = '1' then
        begin
          if Common.AskBox('스템프를 적립하시겠습니까?',10) then
            if not KioskMemberSelect then
            begin
              InitMemberRecord(Common.Member);
              Exit;
            end;
        end
        else
        begin
          if Common.AskBox('포인트를 적립하시겠습니까?',10) then
            if not KioskMemberSelect then
            begin
              InitMemberRecord(Common.Member);
              Exit;
            end;
        end;
      end;
    end;

    //계산시 호출 전화번호를 입력 받을때
    if (GetOption(236) = '1') then
    begin
      if Common.Member.MobileTel <> '' then
        Common.PreSent.CallTelNo := Common.Member.MobileTel
      else
      begin
        if Common.Config.BarrierFreeMode = bfWheelChair then
        begin
          KioskPhoneKeyPadBF_F := TKioskPhoneKeyPadBF_F.Create(Self);
          KioskPhoneKeyPadBF_F.MessageLabel.Caption  := Common.GetPaPago('휴대폰 번호 입력');
          KioskPhoneKeyPadBF_F.Message1Label.Caption := Common.GetPaPago('입력한 휴대폰 번호로 메뉴가 준비되면');
          KioskPhoneKeyPadBF_F.Message2Label.Caption := Common.GetPaPago('카카오톡/SMS');
          KioskPhoneKeyPadBF_F.Message3Label.Caption := Common.GetPaPago('로 알려드립니다.');
          KioskPhoneKeyPadBF_F.AgreeLabel.Caption    := Common.GetPaPago('개인정보 수집 및 이용동의');
          try
            Common.DoModalReset;
            vResult := KioskPhoneKeyPadBF_F.ShowModal;
            Common.DoModalClose;

            if vResult = mrNo then Exit;
            if vResult = mrOk then
              Common.PreSent.CallTelNo := KioskPhoneKeyPadBF_F.KeyInLabel.Hint
            else
              Common.PreSent.CallTelNo := '';
          finally
            FreeAndNil(KioskPhoneKeyPadBF_F);
            Common.Device.OnScannerReadData := ScannerReadEvent;
          end;
        end
        else
        begin
          KioskPhoneKeyPad_F := TKioskPhoneKeyPad_F.Create(Self);
          KioskPhoneKeyPad_F.MessageLabel.Caption  := Common.GetPaPago('휴대폰 번호 입력');
          KioskPhoneKeyPad_F.Message1Label.Caption := Common.GetPaPago('입력한 휴대폰 번호로 메뉴가 준비되면');
          KioskPhoneKeyPad_F.Message2Label.Caption := Common.GetPaPago('카카오톡/SMS');
          KioskPhoneKeyPad_F.Message3Label.Caption := Common.GetPaPago('로 알려드립니다.');
          KioskPhoneKeyPad_F.AgreeLabel.Caption    := Common.GetPaPago('개인정보 수집 및 이용동의');
          try
            Common.DoModalReset;
            vResult := KioskPhoneKeyPad_F.ShowModal;
            Common.DoModalClose;

            if vResult = mrNo then Exit;
            if vResult = mrOk then
              Common.PreSent.CallTelNo := KioskPhoneKeyPad_F.KeyInLabel.Hint
            else
              Common.PreSent.CallTelNo := '';
          finally
            FreeAndNil(KioskPhoneKeyPad_F);
            Common.Device.OnScannerReadData := ScannerReadEvent;
          end;
        end;
      end;
    end;

    if KioskDefaultOrderType = otTakeOut then
    begin
      Common.Table.Packing      := 'Y';
      Common.KioskTable.Packing := 'Y';
    end;
    if GetOption(425) = '0' then
    begin
      with TKioskOrderConfirm_F.Create(Self) do
        try
          TableUse   := (GetOption(426) = '1') and (KioskDefaultOrderType <> otTakeOut);
          AskPacking := GetOption(424) = '1'; //주문완료시 매장이용/포장 선택
          if ShowModal <> mrOK then Exit;
        finally
          if IsDebuggerPresent then
            BlockInput(false);
          Free;
        end;

      if GetOption(426) = '4' then
      begin
        Common.Table := Common.KioskTable;
        Common.Config.IsTakeOut := false;
      end;

      if ((GetOption(424) = '2') or (GetOption(424) = '3')) and (GetOption(426) = '2') and (KioskDefaultOrderType = otStore) then
      begin
        Common.Table := Common.KioskTable;
        Common.Config.IsTakeOut := false;
      end;
    end
    else if ((GetOption(426) = '1') and (KioskDefaultOrderType <> otTakeOut)) or (GetOption(426) = '3') then
    begin
      if not KioskTableSelect then Exit;
    end;
    if ((GetOption(424) = '2') or (GetOption(424) = '3')) and (GetOption(426) = '2') and (KioskDefaultOrderType = otStore) then
    begin
      Common.Table := Common.KioskTable;
      Common.Config.IsTakeOut := false;
    end
    else if GetOption(426) = '4' then
    begin
      Common.Table := Common.KioskTable;
      Common.Config.IsTakeOut := false;
    end;



  if Common.PreSent.WRcvAmt > 0 then
    with TKioskCash_F.Create(Self) do
     try
       SaleAmt := Common.PreSent.WRcvAmt;
       if ShowModal <> mrOK then Exit;
     finally
       Common.Device.OnDispenserReadData :=DispenserReadEvent;
       Free;
     end;

    vError := false;
  finally
    KioskPanel.Enabled    := true;
    Common.HideWaitForm;
    if vError then
    begin
      BlockInput(false);
    end;
    DisplayPresent;
  end;

  try
    KioskPanel.Enabled    := false;
    FinishExecute('15');
    if Act_Enter.HelpKeyword = 'Error' then
      FinishExecute('18',true);

    if (GetOption(490)='1') or ((GetOption(311)='1') and (Common.PreSent.CallNo > 0)) then
    begin
      if not Assigned(KioskBillInfo_F) then
        Application.CreateForm(TKioskBillInfo_F, KioskBillInfo_F);
      KioskBillInfo_F.Show;
    end;
    Common.Config.IsTakeOut := true;
    WorkState := wsReady;
    OrderListView;


    if KioskBeginImageExist then
      SetKioskBeginImage;
    ThaiButtonClick(nil);
  finally
    KioskPanel.Enabled    := true;
    if KioskBeginImageExist or (not KioskBeginImageExist and (GetOption(437) <> '0')) then
      Tmr_KioskWait.Enabled := true;
    BlockInput(false);
    Common.Device.OnScannerReadData := ScannerReadEvent;
  end;
end;

procedure TOrder_F.KioskTrustButtonClick(Sender: TObject);
  function GetTrustLimitMenu:String;
  var vIndex :integer;
  begin
    Result := '';
    for vIndex := 0 to Main_sGrd.RowCount-1 do
    begin
      if Copy(Main_sGrd.Cells[GDM_CONFIG, vIndex],10,1) = 'T' then
      begin
        Result := Main_sGrd.Cells[GDM_NM_MENU, vIndex];
        Break;
      end;
    end;
  end;
var vMenuName :String;
begin
  if MilliSecondsBetween(Now(),ClickTime) < 100 then Exit;
  ClickTime := Now;
  BlockInput(true);
  Common.Device.OnScannerReadData := nil;
  Common.KioskTouchBeep('kioskwave12');
  Common.WriteLog('work', '외상결제버튼');

  try
    KioskPanel.Enabled    := false;
    Tmr_KioskWait.Enabled := false;

    if (Main_sGrd.Cells[0,0] = '') and (Common.Config.MemberDefaultMenu = '') then
    begin
      Common.MsgBox('메뉴를 먼저 주문하세요');
      Exit;
    end;

    vMenuName := GetTrustLimitMenu;
    if vMenuName <> '' then
    begin
      Common.MsgBox(Format('%s 메뉴는'#13'외상할 수 없습니다',[vMenuName]));
      Exit;
    end;


    if (Common.Member.Code = '') then
    begin
      if not KioskMemberSelect then
      begin
        InitMemberRecord(Common.Member);
        Exit;
      end;

      if (Common.Config.MemberDefaultMenu <> '') and not GetMenuOrderCheck(Common.Config.MemberDefaultMenu) then
      begin
        FMenuCode := Common.Config.MemberDefaultMenu;
        SelectMenu(0);
      end;
    end;

    if Common.Member.Yn_trust = 'N' then
    begin
      Common.ErrBox('외상을 할 수 없는 회원입니다');
      Exit;
    end;

    KioskMenuOrder;

    if KioskDefaultOrderType = otTakeOut then
    begin
      Common.Table.Packing      := 'Y';
      Common.KioskTable.Packing := 'Y';
    end;
    if GetOption(425) = '0' then
    begin
      Common.DoModalReset;
      with TKioskOrderConfirm_F.Create(Self) do
        try
          TableUse   := (GetOption(426) = '1') and (KioskDefaultOrderType <> otTakeOut);
          AskPacking := GetOption(424) = '1';
          if ShowModal <> mrOK then
          begin
            BlockInput(false);
            Exit;
          end;
        finally
          Free;
          Common.DoModalClose;
        end;

      if GetOption(426) = '4' then
      begin
        Common.Table := Common.KioskTable;
        Common.Config.IsTakeOut := false;
      end;

      if ((GetOption(424) = '2') or (GetOption(424) = '3')) and (GetOption(426) = '2') and (KioskDefaultOrderType = otStore) then
      begin
        Common.Table := Common.KioskTable;
        Common.Config.IsTakeOut := false;
      end;
    end
    else if ((GetOption(426) = '1') and (KioskDefaultOrderType <> otTakeOut)) or (GetOption(426) = '3') then
    begin
      if not KioskTableSelect then Exit;
    end;
    if ((GetOption(424) = '2') or (GetOption(424) = '3')) and (GetOption(426) = '2') and (KioskDefaultOrderType = otStore) then
    begin
      Common.Table := Common.KioskTable;
      Common.Config.IsTakeOut := false;
    end
    else if GetOption(426) = '4' then
    begin
      Common.Table := Common.KioskTable;
      Common.Config.IsTakeOut := false;
    end;
  finally
    KioskPanel.Enabled    := true;
  end;

  try
    KioskPanel.Enabled    := false;

    Act_Trust.Execute;
    if Common.Present.WRcvAmt > 0 then
    begin
      KioskPanel.Enabled    := true;
      Exit;
    end;

    //고객주문서 출력시
    if (GetOption(490)='1') or ((GetOption(311)='1') and (Common.PreSent.CallNo > 0)) then
    begin
      if not Assigned(KioskBillInfo_F) then
        Application.CreateForm(TKioskBillInfo_F, KioskBillInfo_F);
      KioskBillInfo_F.Show;
    end;
    Common.Config.IsTakeOut := true;
    WorkState := wsReady;
    OrderListView;
    if KioskBeginImageExist then
      SetKioskBeginImage;
    ThaiButtonClick(nil);
  finally
    if KioskBeginImageExist or (not KioskBeginImageExist and (GetOption(437) <> '0')) then
      Tmr_KioskWait.Enabled := true;
     KioskPanel.Enabled    := true;
    BlockInput(false);
    Common.Device.OnScannerReadData := ScannerReadEvent;
  end;
end;

procedure TOrder_F.KioskZoomInButtonClick(Sender: TObject);
var vIndex, vCount :Integer;
begin
  if Sender = KioskVolumeUpButton then
  begin
    VolumeTrackBar.Position := VolumeTrackBar.Position + 5;
  end
  else if Sender = KioskVolumeDownButton then
  begin
    VolumeTrackBar.Position := VolumeTrackBar.Position - 5;
  end
  else if Sender = KioskVoiceListenButton then
  begin
    if Common.KioskVoice then
    begin
      Common.KioskVoice := false;
      KioskVoiceListenButton.Status.Visible := false;
    end
    else
    begin
      Common.KioskVoice := true;
      KioskVoiceListenButton.Status.Visible := true;
      Application.ProcessMessages;
      vCount := 0;
      isTouch := false;
      if Common.PreSent.TotalAmt > 0 then
         Common.TextToSpeech(Format('현재 주문금액은 %d 원 입니다.',[Common.PreSent.TotalAmt]))
      else
      begin
        for vIndex := 0 to High(KioskButtonList) do
        begin
          if KioskButtonList[vIndex].GroupBox.Visible and not KioskButtonList[vIndex].isSoldOut then
          begin
            Inc(vCount);
            if isTouch then Break;
            Common.TextToSpeech(KioskButtonList[vIndex].MenuName+' '+KioskButtonList[vIndex].MenuPrice);
            Sleep(2500);
          end;
        end;
        if vCount > 0 then
        begin
          Common.TextToSpeech('원하시는 메뉴를 주문해 주세요.');
        end;
      end;
    end;
  end;
end;

procedure TOrder_F.KisokStampButtonClick(Sender: TObject);
  function GetSummaryGridRow: Integer;
  var vRow:Integer;
  begin
    Result := -1;
     with Main_sGrd, Common.Menu do
     begin
       For vRow := 0 to Common.Summary_sGrd.RowCount - 1 do
       begin
         if (Cells[GDM_CD_MENU, Row] = Common.Summary_sGrd.Cells[GDM_CD_MENU, vRow])
           and (Cells[GDM_DS_SALE, Row] = Common.Summary_sGrd.Cells[GDM_DS_SALE, vRow])
           and (Cells[GDM_PR_SALE, Row] = Common.Summary_sGrd.Cells[GDM_PR_SALE, vRow])
           and ('N' = Common.Summary_sGrd.Cells[GDM_YN_DOUBLE, vRow])
           and (Common.Summary_sGrd.Cells[GDM_CD_MENU1, vRow] = '')
           then
         begin
            Result := vRow;
            Break;
         end;
       end;
     end;
  end;
var vIndex, vRow :Integer;
begin
  if MilliSecondsBetween(Now(),ClickTime) < 100 then Exit;
  ClickTime := Now;
  if GetOption(21) = '0' then
  begin
    Common.MsgBox('포인트 사용매장은'#13#13'스템프를 사용할 수 없습니다');
    Exit;
  end;
  Common.Device.OnScannerReadData := nil;
  Common.KioskTouchBeep('kioskwave12');
  Common.WriteLog('work', '스템프사용버튼');
  if Assigned(KioskBillInfo_F) then
  begin
    if KioskBillInfo_F.Showing then
      KioskBillInfo_F.Hide;
  end;

  //당일재고 확인
  if GetOption(491) = '1' then
  begin
    if not KioskMenuLimitCheck then Exit;
  end;

  try
    if KioskBeginImageExist or (not KioskBeginImageExist and (GetOption(437) <> '0')) then
      Tmr_KioskWait.Enabled := true;
    KioskPanel.Enabled    := false;
    if Main_sGrd.Cells[0,0] = '' then
    begin
      Common.MsgBox('스템프를 사용할 메뉴를 먼저 주문하세요');
      Exit;
    end;

    if GetOption(406)='0' then
    begin
      Common.MsgBox('스템프 사용방식을'#13#13'금액할인으로 변경해야합니다');
      Exit;
    end;

    if (Common.Member.Code = '') then
    begin
      if not KioskMemberSelect then
      begin
        InitMemberRecord(Common.Member);
        Exit;
      end;
    end;

    if Common.PreSent.WRcvAmt < Common.Config.SetStampDc then
    begin
      Common.MsgBox('받을금액이 부족합니다');
      Exit;
    end;

    if (Common.Member.Stamp-Common.PreSent.UseStamp) < Common.Config.SetStampCount then
    begin
      Common.MsgBox('스템프가 부족합니다');
      Exit;
    end;

    vRow := -1;
    for vIndex := 0 to Main_sGrd.RowCount-1 do
    begin
      if (Main_sGrd.Cells[GDM_DS_SALE, vIndex] = 'D') or (Main_sGrd.Cells[GDM_CD_MENU1, vIndex] <> '') then
        Continue;

      vRow := vIndex;
      Break;
    end;

    if vRow = -1 then
    begin
      Common.MsgBox('스템프를 사용할 수 있는 메뉴가 없습니다');
      Exit;
    end;

    Main_sGrd.Cells[GDM_DC_STAMP,  vRow]  := IntToStr(StoI(Main_sGrd.Cells[GDM_DC_STAMP,  vRow]) + Common.Config.SetStampDc);
    Main_sGrd.Cells[GDM_USE_STAMP, vRow]  := IntToStr(StoI(Main_sGrd.Cells[GDM_USE_STAMP, vRow]) + Common.Config.SetStampCount);
    Common.PreSent.StampDc  := Common.PreSent.StampDc  + Common.Config.SetStampDc;
    Common.PreSent.UseStamp := Common.PreSent.UseStamp + Common.Config.SetStampCount;
    vRow := GetSummaryGridRow;
    Common.Summary_sGrd.Cells[GDM_DC_STAMP, vRow]  := IntToStr(StoI(Common.Summary_sGrd.Cells[GDM_DC_STAMP, vRow]) + Common.Config.SetStampDc);
    Common.Summary_sGrd.Cells[GDM_USE_STAMP, vRow] := IntToStr(StoI(Common.Summary_sGrd.Cells[GDM_USE_STAMP, vRow]) + Common.Config.SetStampCount);

    DisplayPresent;
    Common.MsgBox(Format('스템프가 %d개 차감되었습니다',[Common.Config.SetStampCount]));

    KioskMenuOrder;

    DisplayPresent;
    if Common.PreSent.WRcvAmt = 0 then
      KioskCashButtonClick(nil)
    else
      OrderListView;
  finally
    Common.Device.OnScannerReadData := ScannerReadEvent;
    KioskPanel.Enabled := true;
  end;

end;

procedure TOrder_F.TableClearImageClick(Sender: TObject);
begin
  if (Common.Config.KioskPwd <> '') then
  begin
    Common.DoModalReset;
    KioskKeyPad_F := TKioskKeyPad_F.Create(Self);
    KioskKeyPad_F.MessageLabel.Caption := '관리자 패스워드를 입력하세요';
    KioskKeyPad_F.isPassword           := true;
    try
      if KioskKeyPad_F.ShowModal <> mrOK then Exit;
      if Common.Config.KioskPwd <> KioskKeyPad_F.KeyInLabel.Hint then
      begin
        Common.ErrBox('패스워드가 올바르지 않습니다');
        Exit;
      end;
    finally
      FreeAndNil(KioskKeyPad_F);
      Common.DoModalClose;
    end;
  end;

  Common.DoModalReset;
  with TKioskTable_F.Create(Self) do
    try
      Top    := 0;
      Left   := 0;
      Width  := KioskPanel.Width;
      Height := KioskPanel.Height;
      isClearMode := true;
      ShowModal;
    finally
      Free;
    end;
  KioskTableCreate(true);
  Common.DoModalClose;
end;

procedure TOrder_F.ThaiButtonClick(Sender: TObject);
var vTag, vFlag :Integer;
    vPath, vDefaultPath :String;
begin
  Tmr_KioskWait.Tag      := 0;
  vTag                   := 0;
  if KioskBeginImageExist then
    Tmr_KioskWait.Enabled    := false;
  if Sender = nil then
    vTag := 0
  else
  begin
    Common.KioskTouchBeep('kioskwave12');
    if Sender is TPanel then
      vTag := (Sender as TPanel).Tag
    else if Sender is TAdvSmoothButton then
      vTag := (Sender as TAdvSmoothButton).Tag
    else if Sender is TcxButton then
      vTag := (Sender as TcxButton).Tag
    else if Sender is TcxLabel then
      vTag := (Sender as TcxLabel).Tag;
  end;
  case vTag of
    0 : begin
          Common.Config.PosLanguage := 'KO';
          Common.Config.LanguagePath := '';
          vFlag := 9;
        end;
    1 : begin
          Common.Config.PosLanguage := 'EA';
          Common.Config.LanguagePath := '미국';
          vFlag := 10;
        end;
    2 : begin
          Common.Config.PosLanguage := 'CN';
          Common.Config.LanguagePath := '중국어';
          vFlag := 11;
        end;
    3 : begin
          Common.Config.PosLanguage := 'JA';
          Common.Config.LanguagePath := '일본';
          vFlag := 12;
        end;
    4 : begin
          Common.Config.PosLanguage := 'VI';
          Common.Config.LanguagePath := '베트남';
          vFlag := 13;
        end;
    5 : begin
          Common.Config.PosLanguage := 'TH';
          Common.Config.LanguagePath := '태국';
          vFlag := 14;
        end;
    6 : begin
          Common.Config.PosLanguage := 'IN';
          Common.Config.LanguagePath := '인도네시아';
          vFlag := 15;
        end;
    7 : begin
          Common.Config.PosLanguage := 'FR';
          Common.Config.LanguagePath := '프랑스';
          vFlag := 16;
        end;
    8 : begin
          Common.Config.PosLanguage := 'DE';
          Common.Config.LanguagePath := '독일';
          vFlag := 17;
        end;
  end;

  vDefaultPath := Common.AppPath+'Kiosk\';

  vPath := Common.AppPath+'Kiosk\'+Common.Config.LanguagePath;
  if (Common.Config.LanguagePath <> '') and  not DirectoryExists(vPath) then
    ForceDirectories(vPath);
  vPath := Common.AppPath+'Kiosk\'+Common.Config.LanguagePath+Ifthen(Common.Config.LanguagePath='','','\');

//  if Common.isBFChoose and (Common.Config.BarrierFreeMode = bfWheelChair) and FileExists(vDefaultPath+KioskChiarImageFileName) then
//    Common.SetPNGImage(TImage(FindComponent('pan_kiosksale')),vDefaultPath+KioskChiarImageFileName)
//  else if Common.isBFChoose and (Common.Config.BarrierFreeMode = bfLowVision) and FileExists(vDefaultPath+KioskVisionImageFileName) then
//    Common.SetPNGImage(TImage(FindComponent('pan_kiosksale')),vDefaultPath+KioskVisionImageFileName)
//  else if FileExists(vPath+KioskMainImageFileName) then
//    Common.SetPNGImage(TImage(FindComponent('pan_kiosksale')),vDefaultPath+KioskMainImageFileName);

  if FileExists(vPath+'현금.png') then
    Common.SetPNGImage(KioskCashButton, vPath+'현금.png')
  else if not FileExists(vDefaultPath+'현금.png') then
    KioskCashButton.Caption        := Common.GetPaPago(KioskCashButton.Hint);

  if FileExists(vPath+'카드.png') then
    Common.SetPNGImage(KioskCardButton, vPath+'카드.png')
  else if not FileExists(vDefaultPath+'카드.png') then
    KioskCardButton.Caption        := Common.GetPaPago(KioskCardButton.Hint);

  if FileExists(vPath+'전체취소.png') then
    Common.SetPNGImage(KioskInitButton, vPath+'전체취소.png')
  else if not FileExists(vDefaultPath+'전체취소.png') then
    KioskInitButton.Caption        := Common.GetPaPago(KioskInitButton.Hint);

  if FileExists(vPath+'직원호출.png') then
    Common.SetPNGImage(KioskCallButton, vPath+'직원호출.png')
  else if not FileExists(vDefaultPath+'직원호출.png') then
    KioskCallButton.Caption        := Common.GetPaPago(KioskCallButton.Hint);

  if FileExists(vPath+'포인트.png') then
    Common.SetPNGImage(KioskPointUseButton, vPath+'포인트.png')
  else if not FileExists(vDefaultPath+'포인트.png') then
    KioskPointUseButton.Caption        := Common.GetPaPago(KioskPointUseButton.Hint);

  if FileExists(vPath+'포인트조회.png') then
    Common.SetPNGImage(KioskPointSearchButton, vPath+'포인트조회.png')
  else if not FileExists(vDefaultPath+'포인트조회.png') then
    KioskPointSearchButton.Caption        := Common.GetPaPago(KioskPointSearchButton.Hint);

  if FileExists(vPath+'스템프사용.png') then
    Common.SetPNGImage(KisokStampButton, vPath+'스템프사용.png')
  else if not FileExists(vDefaultPath+'스템프사용.png') then
    KisokStampButton.Caption        := Common.GetPaPago(KisokStampButton.Hint);

  if FileExists(vPath+'주문.png') then
    Common.SetPNGImage(KioskOrderButton, vPath+'주문.png')
  else if not FileExists(vDefaultPath+'주문.png') then
    KioskOrderButton.Caption        := Common.GetPaPago(KioskOrderButton.Hint);

  if FileExists(vPath+'간편결제.png') then
    Common.SetPNGImage(KioskEasyPayButton, vPath+'간편결제.png')
  else if not FileExists(vDefaultPath+'간편결제.png') then
    KioskEasyPayButton.Caption        := Common.GetPaPago(KioskEasyPayButton.Hint);

  if FileExists(vPath+'회원가입.png') then
    Common.SetPNGImage(KioskMemberJoinButton, vPath+'회원가입.png')
  else if not FileExists(vDefaultPath+'회원가입.png') then
    KioskMemberJoinButton.Caption        := Common.GetPaPago(KioskMemberJoinButton.Hint);

  //다국어 버튼이 눌린상태
  if FlagPanel.Visible then
  begin
    KioskFlagButton.Picture.Assign(FlageCollection.Items.Items[vFlag-Ifthen(GetOption(485)='0',9,0)].Picture.Graphic);
    KioskPanel.Enabled := true;
    FlagPanel.Visible  := false;
  end;
  if not KioskFlagAlwaysShow then
    KioskWaitFlagButton.OptionsImage.Glyph.Assign(FlageCollection.Items.Items[vFlag-Ifthen(GetOption(485)='0',9,0)].Picture.Graphic);

  if (KioskWaitPanel.Left <> 0) then
  begin
    Tmr_KioskWait.Enabled     := true;
    KioskSetClassPLU;
    KioskSetMenuPLU;
    OrderListView;
  end;

  if GetOption(424) <> '0' then
  begin
    if FileExists(vPath+'매장이용.png') then
      Common.SetPNGImage(KioskStoreButton, vPath+'매장이용.png')
    else if not FileExists(vDefaultPath+'매장이용.png') then
    begin
      if Common.Config.KioskBegin1 = '' then
        Common.Config.KioskBegin1 := '먹고 갈게요';
      KioskStoreButton.Caption    := Common.GetPaPago(Common.Config.KioskBegin1);
    end;

    if FileExists(vPath+'포장.png') then
      Common.SetPNGImage(KioskTakeOutButton, vPath+'포장.png')
    else if not FileExists(vDefaultPath+'포장.png') then
    begin
      if Common.Config.KioskBegin2 = '' then
        Common.Config.KioskBegin2 := '포장해 갈게요';
      KioskTakeOutButton.Caption  := Common.GetPaPago(Common.Config.KioskBegin2);
    end;
  end;

  if KioskBeginImageExist or (not KioskBeginImageExist and (GetOption(437) <> '0')) then
    Tmr_KioskWait.Enabled     := true;
end;

procedure TOrder_F.KioskTakeOutButtonClick(Sender: TObject);
begin
  //접근성 모드에서 선택시
  if Common.Config.BarrierFreeMode <> bfNone then
  begin
    KioskStartKey := 1;
    ModalResult := mrAbort;
  end
  else
  begin
    Common.WriteLog('work', KioskTakeOutButton.Hint);
    KioskOrderStart(1);
  end;
end;

procedure TOrder_F.Action48Execute(Sender: TObject);
begin
  if FunctionButton[MobileFunctionButtonX, MobileFunctionButtonY].Status.Caption = 'X' then
  begin
    FunctionButton[MobileFunctionButtonX, MobileFunctionButtonY].Status.Caption := '';
    DisplayMessage(0,'호출 전화번호를 입력받습니다.');
  end
  else
  begin
    FunctionButton[MobileFunctionButtonX, MobileFunctionButtonY].Status.Caption := 'X';
    DisplayMessage(0,'호출 전화번호를 입력받지 않습니다.');
  end;
end;

procedure TOrder_F.Action49Execute(Sender: TObject);
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

procedure TOrder_F.FinishExecute(aLog:String; aMust:Boolean);
  procedure SetCornerOrderNo(aOrderNo:Integer);
  var I      :Integer;
      vFirst :Boolean;
  begin
    vFirst := True;
    For I:= 0 to High(Common.Corner) do
    begin
      if Common.Corner[I].OrderData = '' then Continue;
      //코너별로 주문번호를 다르게 사용할때
      if GetOption(269) = '0' then
      begin
        if vFirst then
          Common.Corner[I].OrderNo := aOrderNo
        else
          Common.Corner[I].OrderNo := Common.GetOrderNo(1);
        vFirst := False;
      end
      //코너별로 주문번호를 같게 출력할때
      else Common.Corner[I].OrderNo := aOrderNo;
    end;
  end;
var vWork, vTemp :String;
    vErrMsg,
    vMessage,
    vReceipt,
    vOrderMenu  :String;
    vResult  :String;
    vIsError :Boolean;
    vMax   :Integer;
    vIndex :Integer;
    vCallNo :String;
    vIsKDS  :Boolean;
    vNowDate,
    vOldOpenDate,
    vOldWorkDate :String;
    vSaleAmt :Integer;
label Retry, ReInput;
begin
  try
    if not (Common.OrderKind in [okChange, okCancel, okBanpum, okDutchPay, okDutchPayEnd]) and not Common.Config.IsKiosk then
      Common.GetReceiptNo;
    if Common.Table.AHeadPay then
    begin
      CloseButtonClick(nil);
      Exit;
    end;
    if not Common.IsDebugMode and ((GetOption(379) <> '2') or (Common.Config.van_trd <> vanKICC)) then
      BlockInput(true);
    Common.Device.OnScannerReadData := nil;
    //자동마감
    if not Common.Config.IsKiosk and (GetOption(375) = '1') and (Common.PosType <> ptOnlyOrder) then
    begin
      if Common.PosAutoCloseOpen then
      begin
        Common.GetReceiptNo;
        PosNoLabel.Caption      := Format('%s - %s',[Common.Config.PosNo,Common.PreSent.RcpNo]);
        WorkDateLabel.Caption   := FormatMaskText('!0000년 90월 90일;0; ',Common.WorkDate);
      end;
    end;

    if Common.Config.IsKiosk and (Common.PreSent.WRcvAmt <> 0) then
    begin
      Common.ErrBox(Format('해당 기능을 사용할 수 없습니다[%s - %d]',['Act_EnterExecute', Common.PreSent.WRcvAmt]));
      Exit;
    end;

    if Common.IsBusinessVersion then
      Common.MsgBox('(주)익스트림포스에서 제공한'+#13#13+'영업지원용 버젼입니다');

    if not (Common.OrderKind in [okChange, okCancel, okBanpum, okDutchPay, okDutchPayEnd]) and not Common.Config.IsKiosk then
    begin
      //결제 시 고객정보입력받음
      if GetOption(213) = '1' then
        Action11.Execute;
      //결제 시 담당자입력
      if (GetOption(259) = '1') and (Common.Table.DamdangCode = '') then
      begin
        Action14.Execute;
        if Common.Table.DamdangCode = '' then Exit;
      end;
    end;

    Tmr_Acct.Enabled := False;
    try
      vIsError := True;
      FMsrData   := EmptyStr;
      FMenuCode  := EmptyStr;
      FCardData  := EmptyStr;

       //마감 상태였으면 초기화한다
      if CheckSaleFinish then Exit;

      if not CheckPrevAccount then Exit;
      if not Common.CheckAcctPos then Exit;
      if not CheckGroupType then Exit;
      if (Common.Summary_sGrd.Cells[0,0] = '') and (GroupTable_sGrd.Cells[0,0] = '') then
      begin
        DisplayMessage(1,'매출내역이 없습니다');
        Exit;
      end;

      if not CheckGroupDetail then Exit;
      vTemp := TLabel(FindComponent('MessageLabel')).Caption;

      if (Common.Table.GroupType = 'M') and (Common.PreSent.WRcvAmt > 0) then
      begin
        if not Common.AskBox('그룹디테일까지 모두 정산됩니다'+#13#13+'계속하시겠습니까?') then Exit;
      end;

      if (Common.PreSent.TotalAmt > 0) and (Common.PreSent.CardAmt > Common.PreSent.TotalAmt) then
      begin
        if not Common.AskBox('주문금액이 카드승인 금액보다 적습니다'+#13'계속하시겠습니까?') then Exit;
      end;


      //현금영수증 자진발급을 사용할때(스타밴일때만
      //스타밴만 셋팅이 있는거 같음 (0,1,3,4,8,9)
      if (GetOption(169) = '1') and ((Common.PreSent.WRcvAmt > 0) or ((Common.PreSent.CashAmt > 0) and (Common.PreSent.CashRcpAmt = 0))) then
      begin
        if (Common.PreSent.WRcvAmt > 0) then
          vSaleAmt := Common.PreSent.CashAmt + Common.PreSent.WRcvAmt
        else
          vSaleAmt := Common.PreSent.CashAmt - Common.Present.GiveAmt;
        if not SelfCashRcp(vSaleAmt) then
          if not Common.AskBox('현금영수증 자진발급 에러!!!'+#13#13+ErrMsg+#13#13+'계속하시겠습니까?') then Exit;
      end
      //10만원 이상시 자진발급
      else if (GetOption(169) = '2') and ((Common.PreSent.WRcvAmt > 100000) or ((Common.PreSent.CashAmt > 100000) and (Common.PreSent.CashRcpAmt = 0))) then
      begin
        if (Common.PreSent.WRcvAmt > 0) then
          vSaleAmt := Common.PreSent.CashAmt + Common.PreSent.WRcvAmt
        else
          vSaleAmt := Common.PreSent.CashAmt - Common.Present.GiveAmt;
        if not SelfCashRcp(vSaleAmt) then
          if not Common.AskBox('현금영수증 자진발급 에러!!!'+#13#13+ErrMsg+#13#13+'계속하시겠습니까?') then Exit;
      end

      //무조건 현금영수증발행 한다고 했을때
      else if (GetOption(65) = '1') and (Common.PreSent.WRcvAmt > 0) and (Common.PreSent.CashRcpAmt = 0) then
      begin
        if Common.ShowCashRcpForm(True) then
        begin
          if (GetOption(60) = '0') and (Common.CashRcp.Ds_Input <> 'O') and (Common.CashRcp.Amt_Approval <> 0) then
          begin
            Common.PreSent.CashAmt    := Common.PreSent.CashAmt    + Common.CashRcp.RcvAmt;
            Common.PreSent.CashRcpAmt := Common.PreSent.CashRcpAmt + Common.CashRcp.Amt_Approval;
            Common.CashRcpInfoSave;
          end;
          DisplayPresent;
        end
        else if not Common.AskBox('현금영수증이 발행되지 않았습니다'+#13#13+'계속하시겠습니까?') then Exit;
      end
      else if (vTemp <> EmptyStr) and (vTemp = GetOnlyNumber(vTemp)) and Common.Config.IsTakeOut and (Common.PreSent.WRcvAmt > 0) then
      begin
        Common.PreSent.CashAmt    := Common.PreSent.CashAmt + StrToInt(vTemp);
        DisplayPresent;
        if Common.PreSent.WRcvAmt > 0 then Exit;
      end;

      Common.Device.BefCustomerOrder := '';

      //렛츠오더에서 승인금액이 더 많을때
      if (Common.PreSent.LetsOrderAmt > 0) and (Common.PreSent.LetsOrderAmt > Common.PreSent.TotalAmt) then
      begin
        Common.MsgBox('렛츠오더 결제금액이 주문금액보다 큽니다'#13'결제금액을 확인하세요');
        Exit;
      end;

      Common.WriteLog('work', Format('정산시작(%s) [%s]',[aLog, FormatFloat('#,0',Common.PreSent.TotalAmt)]));

      if (Common.PreSent.WRcvAmt <> 0) and (GetOption(376) = '1') and (Length(GetOnlyNumber(InputEdit.Text)) > 3) and (Length(GetOnlyNumber(InputEdit.Text)) <= 7) and (StrToInt(GetOnlyNumber(InputEdit.Text)) mod 100 = 0) then
      begin
         Common.PreSent.CashAmt := Common.PreSent.CashAmt + StrToInt(GetOnlyNumber(InputEdit.Text));
         DisplayPresent;
         if Common.PreSent.WRcvAmt > 0 then Exit;
      end;

      if Common.PreSent.WRcvAmt <> 0 then
        Common.PreSent.CashAmt := Common.PreSent.CashAmt + FtoI(Common.PreSent.WRcvAmt)
      else if (Common.PreSent.TotalAmt + ifthen(GetOption(160)='0', Common.PreSent.TipAmt, 0)) < 0 then
        Common.PreSent.CashAmt := FtoI(Common.PreSent.GiveAmt) * -1;

      DisplayPresent;

      //할인금액이 있는데 거스름돈이 있을 때 할인금액에서 거스름돈 부분을 뺀다
      //기준금액이 0원 이하일때
      if (Common.PreSent.CodeDc > 0) and (Common.PreSent.GiveAmt > 0) and (Common.PreSent.CodeDcStdAmt < 0) then
        Common.PreSent.CodeDcAmt := Common.PreSent.CodeDc - Common.PreSent.GiveAmt;

      DisplayPresent;

      if Common.PreSent.WRcvAmt <> 0 then Exit;
      if Common.OrderKind = okChange then
        vWork := 'C'
      else vWork := 'S';

      vTemp := '';
      try
        //추가주문이 있으면 주문번호를 채번한다
        if ((not Common.Config.IsAcctKitchenPrint) and (Common.OrderKind <> okChange)) then
          for vIndex := 0 to Main_sGrd.RowCount - 1 do
          begin
            if Main_sGrd.Cells[GDM_YN_ORDER, vIndex] = 'N' then
            begin
              Common.Table.OrderNo := Common.GetOrderNo(1);
              Break;
            end;
          end;

        SetKitchenOrderData;
        //고객주문서 전체주문내역
        if (Common.CustomerPrinter <> '') or (Common.CustomerCancel <> '') then
          Common.GetAllCustomerOrder(1);

        if ((Common.CustomerPrinter <> '') or (Common.CustomerCancel <> '')) and
           (Common.Table.OrderNo = 0) then
          Common.Table.OrderNo := Common.GetOrderNo(1);

        //호출벨을 연동해서 사용하지 않으면서 호출벨을 사용할때는 주문번호 대신 호출벨을 사용한다
        if not Common.Config.IsKiosk and (GetOption(311) = '1') and (GetOption(61) = '0') and (Common.OrderKind <> okChange) and (Common.Config.BellPort = 0) and (Common.Config.BellDev < 2) then
        begin
          vTemp := Common.ShowNumberForm('호출번호를 입력하세요',4,9999,'');
            Common.PreSent.CallNo := StoI(vTemp);

          if not Common.IsDebugMode and ((GetOption(379) <> '2') or (Common.Config.van_trd <> vanKICC))then
            BlockInput(true);
        end      //호출번호 기능을 사용합니다.                                  //계산완료 시 전화번호 입력                                                              //키오스크이면서 계산시 전화번호를 받을때
        else if ((GetOption(311) = '1') and (Common.OrderKind <> okChange) and ((GetOption(61) <> '0') or (Common.Config.BellPort > 0) or (Common.Config.BellDev = 2)) ) or (Common.Config.IsKiosk and (GetOption(236)='1')) then
        begin
          if not isCheckMobileNo or (isCheckMobileNo and (FunctionButton[MobileFunctionButtonX, MobileFunctionButtonY].Status.Caption = ''))  then
          begin
            if (GetOption(61) <> '0') and (Common.Config.BellPort = 0) and not Common.Config.IsKiosk then
            begin
  Retry:
              if Common.Config.SmartPad then
              begin
                Common.PadWaitForm('고객이 전화번호를 입력 중 입니다...',
                                   #2+'keypad'
                                  +#2+'3'
                                  +#2+'0'
                                  +#2+'호출 받으실 전화번호를 입력해주세요'
                                  +#2+'0'
                                  +#2+'60');

                if not IsMobileNumber(Common.PreSent.CallTelNo) then
                begin
                  Sleep(1000);
                  if Common.AskBox('전화번호가 올바르지 않습니다'#13'다시 입력하시겠습니까?') then
                    goto Retry
                  else
                    Common.PreSent.CallTelNo := '';
                end;
              end
              else
                Common.PreSent.CallTelNo := Common.ShowNumberForm('전화번호를 입력하세요',13,0,'010');

              if (Common.PreSent.CallTelNo = '') or (Common.PreSent.CallTelNo = 'mrClose') then
              begin
                if not Common.AskBox('전화번호가 입력되지 않으면'#13'알림톡이 발송되지 않습니다'#13'그냥 계산하시겠습니까?') then
                  goto Retry;
              end;
              if Common.PreSent.CallTelNo = 'mrClose' then
                Common.PreSent.CallTelNo := '';
            end;

            DM.StoredProc.StoredProcName :='GET_NUMBER';
            DM.StoredProc.PrepareSQL;
            DM.StoredProc.ParamByName('_CD_STORE'  ).AsString    := Common.Config.StoreCode;
            DM.StoredProc.ParamByName('_DS_NUMBER'  ).AsString   := 'C';
            DM.StoredProc.ParamByName('_NO_POS'  ).AsString      := '00';
            DM.StoredProc.ParamByName('_TEL_MOBILE'  ).AsString  := GetOnlyNumber(Common.PreSent.CallTelNo);
            DM.StoredProc.ParamByName('_PICKUP_POS'  ).AsString  := Common.Config.DIDPickupPos;
            DM.StoredProc.ParamByName('_NO_RECEIPT'  ).AsString  := '';
            DM.StoredProc.ParamByName('_NO_MAX'  ).AsString     := GetOption(304);
            DM.StoredProc.ExecProc;
            Common.PreSent.CallNo := DM.StoredProc.ParamByName('_NO_CALL').AsInteger;
            DM.StoredProc.Close;

            if Common.PreSent.CallTelNo = '' then
              Common.Device.SetBell(Common.PreSent.CallNo);
          end;
        end;

        if Common.Config.IsTakeOut and (Common.Table.OrderType <> 'D') then
        begin
          For vIndex := 0 to High(Common.KitchenPrinter) do
          begin
            if Common.KitchenPrinter[vIndex].Data = EmptyStr then Continue;
            try
              Common.SavePrintData(Common.KitchenPrinter[vIndex].Code,
                                   Common.KitchenPrinter[vIndex].Data,
                                   Common.Table.DamdangName,
                                   Common.Config.PosNo,
                                   Common.NowDate+Common.NowTime,
                                   Common.Table.CustomerCount,
                                   Common.Table.OrderNo);
            except
              on E: Exception do
              begin
                Common.WriteLog('Order007',E.Message);
              end;
            end;
          end;
        end;
      except
        on E: Exception do
        begin
          Common.WriteLog('Order010',E.Message);
        end;
      end;

      if (not Common.Config.IsAcctKitchenPrint) and (Common.OrderKind <> okChange) then
        //                               푸드코트기능 사용          고객주문서를 코너별로 출력
        if (Common.Config.IsTakeOut) and (GetOption(231) = '1') and (GetOption(233) = '1') then
        begin
          if Common.Table.OrderNo = 0 then
            Common.Table.OrderNo := Common.GetOrderNo(0);
          SetCornerOrderNo(Common.Table.OrderNo);
        end;

      //포장테이블이면 영수증에 주문번호를 출력
      if (Common.Table.Packing = 'Y') and (Common.OrderKind = okAppend) and (Common.Table.OrderNo = 0) then
      begin
        OpenQuery('select NO_ORDER '
                 +'  from SL_ORDER_H '
                 +' where CD_STORE =:P0 '
                 +'   and NO_TABLE =:P1 '
                 +'   and DS_ORDER =:P2 ',
                 [Common.Config.StoreCode,
                  Common.Table.Number,
                  Common.Table.OrderType]);

        if not Common.Query.Eof then
          Common.Table.OrderNo := StrToIntDef(Common.Query.Fields[0].AsString,0);

        Common.Query.Close;
      end;

      if not Common.SaleDataSave(vWork, vErrMsg) then
      begin
        Common.ErrBox(vErrMsg);
        DisplayMessage(1,'정산이 정상적으로 처리되지 않았습니다');
        Common.WriteLog('SaleDataSave','정산이 정상적으로 처리되지 않았습니다');
        Common.WorkState := wsAcct;
        Exit;
      end
      else
      begin
        if (Common.Member.Code <> '') and (GetOption(21) = '0') then
          PointLabel.Caption   := Format('포 인 트 : %s 점',[FormatFloat('#,0',Common.Member.Point)]);

        if Common.PreSent.SaveStamp > 0 then
          Common.MsgBox(Format('%d개 스템프가 적립되었습니다'#13'잔여 스템프 %d개',[Common.PreSent.SaveStamp, Common.Member.Stamp+Common.PreSent.SaveStamp-Common.PreSent.UseStamp]),3);

        vIsError := False;
        SetPluClassData;
        //고객,주방 주문서 출력
        if (not Common.Config.IsAcctKitchenPrint) and ((Common.OrderKind <> okChange) or (GetOption(408)='1'))  then
          Common.Device.OrderPrint(BillPrintMode, KitchenPrintMode);

        //계산테이블임을 표시한다(깜박이게 하기 위함)
        if not Common.Config.IsTakeOut and (Common.Table.OrderType = 'T') and (GetOption(360) <> '0') and (Common.OrderKind <> okDutchPay) then
        begin
          ExecQuery('update MS_TABLE '
                   +'   set DT_ACCT_LAST = Now() '
                   +' where CD_STORE  =:P0 '
                   +'   and NO_TABLE  =:P1 ',
                   [Common.Config.StoreCode,
                    Common.Table.Number]);
        end;

        //키오스크일때 주문 알림톡발송
        if (((GetOption(61) = '2') and not Common.Config.IsKiosk) or ((GetOption(470) = '1') and Common.Config.IsKiosk)) and (Common.PreSent.CallTelNo <> '') then
        begin
          vOrderMenu := '';
          vReceipt := '{C}{Z}  영  수  증'+#13#10+#13#10
                     +Format('상호 :%s',[Common.Config.StoreName])+#13#10
                     +Format('사업자번호:%s 대표자:%s',[Common.Config.BizNo,Common.Config.StoreBoss])+#13#10
                     +Format('주소 :%s',[Common.Config.StoreAddress])+#13#10
                     +Format('전화번호 :%s',[SetTelephone(Common.Config.StoreTel)])+#13#10
                     +Format('전표:%s-%s-%s',[Common.WorkDate, Common.Config.PosNo, Common.PreSent.RcpNo])+#13#10
                     +'=========================================='#13#10
                     +'        메    뉴        단가 수량     금액'#13#10
                     +'------------------------------------------'#13#10;

          with Main_sGrd do
            for vIndex := 0 to Main_sGrd.RowCount-1 do
            begin
              vOrderMenu := vOrderMenu + Format('%s (%s)',[Replace(Cells[GDM_NM_MENU, vIndex],Common.Config.PackingTxt,''), Cells[GDM_VIEWQTY, vIndex]]) + #13;

              if Cells[GDM_CD_MENU1, vIndex] = '' then
                vReceipt := vReceipt + RPadB(Replace(Cells[GDM_NM_MENU, vIndex],Common.Config.PackingTxt,''), 20, ' ')
                                     + LPadB(FormatFloat(',0',StoI(Cells[GDM_PR_SALE, vIndex])),8,' ')
                                     + LPadB(Cells[GDM_VIEWQTY, vIndex],5,' ')
                                     + LPadB(FormatFloat(',0',StoI(Cells[GDM_AMT, vIndex])),9,' ')+#13#10
              else
              begin
                if Cells[GDM_PR_SALE, vIndex] = '0' then
                  vTemp := LPadB(' ',8,' ')
                else
                  vTemp := LPadB(FormatFloat(',0',StoI(Cells[GDM_PR_SALE, vIndex])),8,' ');
                vReceipt := vReceipt + ' -'+RPadB(Replace(Cells[GDM_NM_MENU, vIndex],Common.Config.PackingTxt,''), 18, ' ')
                                     + vTemp
                                     + LPadB(Cells[GDM_VIEWQTY, vIndex],5,' ')
                                     + LPadB(FormatFloat(',0',StoI(Cells[GDM_AMT, vIndex])),9,' ')+#13#10;
              end;

            end;

          vMessage := Format('고객님이 주문하신 메뉴가'#13'접수 되었습니다.'#13#13'메뉴가 준비되는 대로 안내해 드리겠습니다.'
                             +#13#13'◎ 주문번호 : %d%S'#13'◎ 주문상품 : %s',[Common.PreSent.CallNo, Ifthen(Common.Config.DIDPickupPos='','','('+Common.Config.DIDPickupPos+')'), vOrderMenu]);


          vReceipt := vReceipt +'------------------------------------------'#13#10
                               +'{Y}합계금액'+LPadB(FormatFloat(',0',Common.PreSent.TotalAmt),34,' ')+#13#10;

          if Common.PreSent.CardAmt <> 0 then
            vReceipt := vReceipt +'      신용카드'+LPadB(FormatFloat('#,##0',Common.PreSent.CardAmt),28,' ')+#13#10;
          if Common.PreSent.LetsOrderAmt <> 0 then
            vReceipt := vReceipt +'      렛츠오더'+LPadB(FormatFloat('#,##0',Common.PreSent.LetsOrderAmt),28,' ')+#13#10;
          if Common.PreSent.CashAmt <> 0 then
            vReceipt := vReceipt +'      현    금'+LPadB(FormatFloat('#,##0',Common.PreSent.CashAmt),28,' ')+#13#10;
          if Common.PreSent.TrustAmt <> 0 then
            vReceipt := vReceipt +'      외    상'+LPadB(FormatFloat('#,##0',Common.PreSent.TrustAmt),28,' ')+#13#10;
          if Common.PreSent.GiftAmt <> 0 then
            vReceipt := vReceipt +'      상 품 권'+LPadB(FormatFloat('#,##0',Common.PreSent.GiftAmt),28,' ')+#13#10;
          if Common.PreSent.BankAmt <> 0 then
            vReceipt := vReceipt +'      계좌입금'+LPadB(FormatFloat('#,##0',Common.PreSent.BankAmt),28,' ')+#13#10;
          if Common.PreSent.PointAmt <> 0 then
            vReceipt := vReceipt +'      포 인 트'+LPadB(FormatFloat('#,##0',Common.PreSent.PointAmt),28,' ')+#13#10;
          if Common.PreSent.GiveAmt <> 0 then
            vReceipt := vReceipt    +'{Y}거스름돈'+LPadB(FormatFloat(',0',Common.PreSent.GiveAmt),34,' ')+#13#10;

          if Common.PreSent.TotalDC > 0 then
            vReceipt := vReceipt +'{Y}할인금액'+LPadB(FormatFloat(',0',Common.PreSent.TotalAmt),34,' ')+#13#10;

          if Common.Member.Code <> '' then
          begin
            vReceipt := vReceipt +'------------------------------------------'#13#10
                                 +Common.Member.Name+'님'#13#10;

            if (Common.PreSent.OccurPnt > 0) or (Common.PreSent.UsePnt > 0) then
            begin
              if Common.PreSent.OccurPnt > 0 then
                vReceipt := vReceipt + '    적립포인트'+LPadB(FormatFloat(',0',Common.PreSent.OccurPnt),28,' ')+#13#10;
              if Common.PreSent.UsePnt > 0 then
                vReceipt := vReceipt + '    사용포인트'+LPadB(FormatFloat(',0',Common.PreSent.UsePnt),28,' ')+#13#10;
              vReceipt := vReceipt + '    누계포인트'+LPadB(FormatFloat(',0',Common.Member.Point),28,' ')+#13#10;
            end;

            if (Common.PreSent.SaveStamp > 0) or (Common.PreSent.UseStamp > 0) then
            begin
              if Common.PreSent.SaveStamp > 0 then
                vReceipt := vReceipt + '    적립스템프'+LPadB(FormatFloat(',0',Common.PreSent.SaveStamp),28,' ')+#13#10;
              if Common.PreSent.UseStamp > 0 then
                vReceipt := vReceipt + '    사용스템프'+LPadB(FormatFloat(',0',Common.PreSent.UseStamp),28,' ')+#13#10;
              vReceipt := vReceipt + '    잔여스템프'+LPadB(FormatFloat(',0',Common.Member.Stamp+Common.PreSent.SaveStamp-Common.PreSent.UseStamp),28,' ')+#13#10;
            end;
          end;

          if (Common.PreSent.CardAmt > 0)  then
            with Common.Card_SGrd do
            begin
              vReceipt := vReceipt +'------------------------------------------'#13#10
                                   +'카드번호 : '+ Cells[GDC_CARDNO, 0] +#13#10
                                   +'카 드 사 : '+ Cells[GDC_NAME, 0] +#13#10
                                   +'승인번호 : '+ Cells[GDC_NO_APPROVAL, 0] + #13#10
                                   +'승인금액 : '+ FormatFloat(',0원',StoI(Cells[GDC_AMT, 0])) + #13#10
                                   +'=========================================='#13#10
            end;
          Common.KaKaoSendMessage('O',[vMessage, vReceipt, Common.WorkDate+Common.Config.PosNo+Common.PreSent.RcpNo],  Common.PreSent.CallTelNo);
        end;


        //테이블제이면 계산이 완료되면 주방모니터에 상태값을 완전완료로 변경한다
        if (not Common.Config.IsTakeOut or (Common.Table.OrderType = 'D')) and (Common.OrderKind <> okNew) then
        begin
          if GetOption(193)='0' then
          begin
            vIsKDS := false;
            for vIndex := 0 to High(Common.KitchenPrinter) do
              if Common.KitchenPrinter[vIndex].IsKDS then
              begin
                vIsKDS := true;
                Break;
              end;
            //0 주문, 1 조리 중, 2 취소, 3 조리 완료, 4 계산 완료, 5 취소 완료
            if vIsKDS then
            begin
              if Common.Table.OrderType = 'T' then
              begin
                ExecQuery('delete from SL_ORDER_KDS '
                         +' where CD_STORE  =:P0 '
                         +'   and YMD_SALE  =:P1 '
                         +'   and NO_TABLE  =:P2 ',
                         [Common.Config.StoreCode,
                          Common.WorkDate,
                          Common.Table.Number]);
              end
              else
              begin
                ExecQuery('delete from SL_ORDER_KDS '
                         +' where CD_STORE    =:P0 '
                         +'   and YMD_SALE    =:P1 '
                         +'   and NO_DELIVERY =:P2 ',
                         [Common.Config.StoreCode,
                          Common.WorkDate,
                          Common.Table.DeliveryNo]);
              end;
            end;
          end;
        end
        else if Common.Config.IsTakeOut or (Common.OrderKind = okNew) then
        begin
          //KDS에 저장
          if KitchenPrintMode then
            Common.SaveKDSData(true);
        end;

        //Void 처리중이면 종료
        case Common.OrderKind of
          okChange,
          okBanpum :
          begin
            if Common.Config.IsTakeOut then
            begin
              Common.OrderKind := okNew;
              WorkState := wsReady;
            end;
            Common.ClearKitchenData;                   //주문서출력정보 초기화
            case RcpChange_F.ShowMode of
              fsmNone : Close;
              fsmSale : Tmr_Change.Enabled := True;
            end;
            Exit;
          end;
          okDutchPay,
          okDutchPayEnd,
          okDutchPayAll:
          begin
            ModalResult := mrOK;
            Exit;
          end;
        end;
        //배달주문이면
        if Common.Table.OrderType = 'D' then
        begin
          if Assigned(DeliveryInfo_F) then
            DeliveryInfo_F.FOrderAmt := Common.PreSent.TotalAmt;
          if Assigned(DeliveryNew_F) then
            DeliveryNew_F.FOrderAmt := Common.PreSent.TotalAmt;
        end;

        WorkState   := wsMagam;

        //선불방식이 아니면 주문폼을 닫는다
        if not Common.Config.IsTakeOut and not Common.Config.IsKiosk then
        begin
          if Common.PreSent.GiveAmt > 0 then
            Common.MsgBox('정산이 완료됐습니다');
          Close;
        end
        else
        begin
          Common.KitchenDataCopy;
          Common.ClearKitchenData;                   //주문서출력정보 초기화
        end;

        //배달주문이면
        if Common.Table.OrderType = 'D' then
          ModalResult := mrYes;

      end;
    finally
      if not vIsError then
      begin
        Act_Enter.HelpKeyword := '';
        Common.WriteLog('work', Format('정산완료 [%s-%s-%s] %s원 (%s)',[Common.WorkDate,
                                                                        Common.Config.PosNo,
                                                                        Common.Present.RcpNo,FormatFloat('#,0',Common.PreSent.TotalAmt),
                                                                        Ifthen(Common.Config.IsTakeOut or (Common.Table.Packing = 'Y'), 'TakeOut',
                                                                               Format('Table %s%s',[Ifthen(GetOption(58)='0',Common.Table.FloorName+' - ',''),
                                                                                                    Ifthen(GetOption(25)='0',IntToStr(Common.Table.Number), Common.Table.Name)]))]));
        if (WorkState <> wsMagam) and (Common.WorkState = wsMagam) then
          WorkState := wsMagam;
        //선불제일때 정산후 화면을 Clear 한다고 했을때
        if not Common.Config.IsKiosk and Common.Config.IsTakeOut and (GetOption(159) = '1') and (Common.PreSent.GiveAmt = 0) then
        begin
          WorkState := wsReady;
          Common.ShowNormalDualScreen;
        end;

        if WorkState in [wsSale, wsAcct]  then
          Tmr_Acct.Enabled := True;
      end
      else
        Act_Enter.HelpKeyword := 'Error';
    end;
  finally
    if not Common.Config.IsKiosk then
      BlockInput(false);
    Common.Device.OnScannerReadData := ScannerReadEvent;
  end;
end;

procedure  TOrder_F.FreePluClassList(AList: TList);
var
  I: Integer;
begin
  for I := 0 to AList.Count - 1 do
    Dispose(PPluClassData(AList[I]));
  AList.Clear;
end;
procedure  TOrder_F.FreePluMenuList(AList: TList);
var
  I: Integer;
begin
  for I := 0 to AList.Count - 1 do
    Dispose(PPluMenuData(AList[I]));
  AList.Clear;
end;

procedure  TOrder_F.FreeCourseOrderDataList(AList: TList);
var
  I: Integer;
  P: ^TCourseOrderMenu;
begin
  if not Assigned(AList) then Exit;

//  for I := 0 to AList.Count - 1 do
//  begin
//    P := AList[I];
//    Dispose(Common.PCourseOrderMenu);
//  end;

  AList.Clear;
end;

function TOrder_F.GetMenuOrderCheck(aMenuCode:String):Boolean;
var vRow :Integer;
begin
  Result := false;
  For vRow :=0 to Main_sGrd.RowCount-1 do
  begin
    if Main_sGrd.Cells[GDM_CD_MENU, vRow] = aMenuCode then
    begin
      Result := true;
      Break;
    end;
  end;
end;

end.


















