unit Card_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ComCtrls, Buttons, ExtCtrls,
  ImgList, GraphicEx, OleCtrls, MaskUtils, IniFiles,
  POSCard, KeyPad_F, jpeg, Menus, cxLookAndFeelPainters, cxButtons,
  cxMaskEdit, cxButtonEdit, cxControls, cxContainer, MMSystem,
  cxEdit, cxTextEdit, cxCurrencyEdit, cxLookAndFeels, StrUtils, cxLabel,
  cxPC, cxCheckBox, cxGraphics, cxGroupBox, DateUtils, cxClasses,
  AdvSmoothToggleButton, AdvPageControl, AdvGlassButton, dxGDIPlusClasses,
  AdvSmoothButton, Vcl.WinXCtrls, Vcl.WinXPanels, AdvPanel;

type
  TCard_F = class(TForm)
    Tmr_Execute: TTimer;
    cxLookAndFeelController1: TcxLookAndFeelController;
    edtTemp: TEdit;
    Tmr_IC: TTimer;
    MainGroupBox: TcxGroupBox;
    Tmr_Enabled: TTimer;
    LogApprovalButton: TAdvGlassButton;
    MessageLabel: TLabel;
    Image3: TImage;
    TitleLabel: TLabel;
    CloseButton: TcxButton;
    ApprovalButton: TAdvSmoothButton;
    EasyPayButton: TAdvSmoothButton;
    CatApprovalButton: TAdvSmoothButton;
    ToggleSwitch: TToggleSwitch;
    UnionPayCheckBox: TcxCheckBox;
    cxLabel3: TcxLabel;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    ApprovalAmtEdit: TcxCurrencyEdit;
    cxLabel4: TcxLabel;
    TipAmtEdit: TcxCurrencyEdit;
    cxLabel5: TcxLabel;
    HalbuEdit: TcxTextEdit;
    GetAmtEdit: TcxCurrencyEdit;
    OrgCardNoLabel: TcxLabel;
    DcLabel: TcxLabel;
    DcAmtEdit: TcxCurrencyEdit;
    PosPanel: TAdvPanel;
    Chain1Button: TAdvSmoothButton;
    Chain2Button: TAdvSmoothButton;
    Chain3Button: TAdvSmoothButton;
    Chain4Button: TAdvSmoothButton;
    Chain5Button: TAdvSmoothButton;
    Chain6Button: TAdvSmoothButton;
    Chain7Button: TAdvSmoothButton;
    Chain8Button: TAdvSmoothButton;
    Chain9Button: TAdvSmoothButton;
    Chain10Button: TAdvSmoothButton;
    KeyBoardButton: TAdvSmoothButton;
    AdvSmoothButton1: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Tmr_ExecuteTimer(Sender: TObject);
    procedure Tmr_ICTimer(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Tmr_EnabledTimer(Sender: TObject);
    procedure Chain1ButtonClick(Sender: TObject);
    procedure GetAmtEditExit(Sender: TObject);
    procedure GetAmtEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure ApprovalAmtEditExit(Sender: TObject);
    procedure HalbuEditKeyPress(Sender: TObject; var Key: Char);
    procedure ApprovalButtonClick(Sender: TObject);
    procedure LogApprovalButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure PosTabShow(Sender: TObject);
    procedure PosPagerChange(Sender: TObject);
    procedure HalbuEditEnter(Sender: TObject);
    procedure HalbuEditExit(Sender: TObject);
    procedure ApprovalAmtEditKeyPress(Sender: TObject; var Key: Char);
    procedure EasyPayButtonClick(Sender: TObject);
    procedure ToggleSwitchClick(Sender: TObject);
  private
    ErrMsg    :String;
    FisCatFallBack :Boolean;   //JTNET 카드이벤트에서 FallBack 발생시
    FUnionPass :String;
    isExecute  :Boolean;
    ClickTime :TDateTime;
    function  ApprovalAction(aEasyPay:String=''):Boolean;  //aEasyPay  '':일반승인, 'M'-,멀티패드, 그외 스캐너입력
  public
    MsrData   :String;
    ICData    :String;
    isCardFormDetect  :Boolean;          //카드폼에서 감시됐는지 여부
    CashToAmount      :Integer;          //복합결제에서 넘어온 금액
    procedure  ApprovalExecute;
    procedure  WMCopyData(var Msg: TMessage);  message WM_COPYDATA;
  end;

var
  Card_F     :TCard_F;
implementation
uses Common_U, GlobalFunc_U, Const_U, Order_U, Math, EasyPay_U;


{$R *.dfm}
//****************************************************************************//
//                          폼생성시
//****************************************************************************//
procedure TCard_F.FormCreate(Sender: TObject);
var vIndex :Integer;
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(EasyPayButton);
  Common.SetButtonColor(ApprovalButton);
  Common.SetButtonColor(CatApprovalButton);
  Common.SetButtonColor(LogApprovalButton);
  CardPanel.ActiveCard := PosPager;
  isExecute := false;
  ToggleSwitch.Visible         := GetOption(494) = '0';
  if IsDebuggerPresent then
    ToggleSwitch.Visible         := true;

  CatApprovalButton.Visible := (GetOption(379) = '2') and (GetOption(495) = '1') and not Common.Config.PosCatUse;
  if GetOption(385) = '1' then
  begin
    fmKeyPad.Num_000.Visible := false;
    fmKeyPad.Num_00.Visible  := true;
    fmKeyPad.Num_00.Top      := fmKeyPad.Num_000.Top;
    fmKeyPad.Num_00.Left     := fmKeyPad.Num_000.Left;
  end;

  TipAmtEdit.Enabled := GetOption(20) = '1';

  OpenQuery('select NM_CODE1, '   //매입사명
           +'       NM_CODE2 '    //가맹점번호
           +'  from MS_CODE '
           +' where CD_KIND = ''06'' '
           +'   and DS_STATUS =''0'' '
           +'   and CD_STORE =:P0 '
           +' order by CD_CODE '
           +' limit 10 ',
           [Common.Config.StoreCode]);

  vIndex := 1;
  while not Common.Query.Eof do
  begin
    TAdvSmoothButton(FindComponent(Format('Chain%dButton',[vIndex]))).Caption := Common.Query.Fields[0].AsString;
    TAdvSmoothButton(FindComponent(Format('Chain%dButton',[vIndex]))).Hint    := Common.Query.Fields[1].AsString;
    TAdvSmoothButton(FindComponent(Format('Chain%dButton',[vIndex]))).Visible := true;
    Common.Query.Next;
    Inc(vIndex);
  end;
  Common.Query.Close;

  if vIndex = 1 then
  begin
    TAdvSmoothButton(FindComponent(Format('Chain%dButton',[vIndex]))).Caption := '단말기승인';
    TAdvSmoothButton(FindComponent(Format('Chain%dButton',[vIndex]))).Hint    := '0';
    TAdvSmoothButton(FindComponent(Format('Chain%dButton',[vIndex]))).Visible := true;
  end;

  //스타밴, KCP, JTNET만 은련카드 사용가능
  UnionPayCheckBox.Checked := false;
  UnionPayCheckBox.Visible := Common.Config.van_trd in [vanDaou,vanKCP,vanJTNET,vanKFTC,vanSPC];
  //단말기 연동일때는 은력카드를 사용가능
  if (GetOption(379) = '1') and (Common.Config.van_trd in [vanFDIK,vanSmartro,vanKOCES,vanSPC,vanKIS]) then
    UnionPayCheckBox.Visible := True;
  if (GetOption(379) = '2') and (Common.Config.van_trd in [vanKSNET,vanJTNET,vanKOVAN,vanNICE]) then
    UnionPayCheckBox.Visible := True;
  if ((GetOption(379)='0')) and (Common.Config.van_trd in [vanSmartro, vanKIS, vanJTNET]) then
    UnionPayCheckBox.Visible := True;


  EasyPayButton.Visible := Common.Config.VanEasyPay <> 'N';
  //금결원은 멀티패드사용하면 간편결제 통합
  if (Common.Config.van_trd in [vanKFTC, vanKOVAN]) and (GetOption(379)='2') then
    EasyPayButton.Caption := '제로페이';

  if (Common.Config.van_trd in [vanKoces, vanJtnet, vanKis, vanSmartro]) or ((Common.Config.van_trd = vanKSNET) and (Common.Config.VanEasyPay = 'T')) then
    EasyPayButton.Visible := false;

  EasyPayButton.Tag := Ifthen(EasyPayButton.Visible,0,1);

  FisCatFallBack      := false;
  FUnionPass          := EmptyStr;
  MainGroupBox.Top  := 0;
  MainGroupBox.Left := 0;
  CashToAmount      := 0;
  //두번눌리는현상 방지
  ClickTime         := IncSecond(Now,-3);
  Common.SetLanguage(Self);
end;

procedure TCard_F.FormShow(Sender: TObject);
var vTemp  :String;
    vIndex :Integer;
begin
  if not Common.IsDebugMode and ((GetOption(379) <> '2') or (Common.Config.van_trd <> vanKICC)) then
    BlockInput(true);
  try
    isCardFormDetect         := false;
    ApprovalAmtEdit.Enabled    := True;
    ApprovalButton.Visible    := True;

    if Assigned(Order_F) and Order_F.CardLogButton.Visible then
      LogApprovalButton.Visible :=  (Common.GetCardLog(False) <> '')
    else
      LogApprovalButton.Visible := false;
    OrgCardNoLabel.Caption := EmptyStr;
    //승인일때만 제휴카드 버튼을 보인다
    if Common.Card.Ds_trd = dtCancel then
    begin
      GetAmtEdit.Properties.ReadOnly       := True;
      ApprovalAmtEdit.Properties.ReadOnly  := True;
    end
    else
    begin
      GetAmtEdit.Properties.ReadOnly   := False;
      ApprovalAmtEdit.Properties.ReadOnly  := False;
    end;

    vTemp := MsrData;
    Common.IsAction := False;
    if Common.Card.Type_Trd <> atCAT then
      CardPanel.ActiveCard := PosPager;

    if Common.Card.Ds_trd = dtCancel then
    begin
      ApprovalButton.Caption           := '취소요청';
      ApprovalButton.Color             := $000000CC;
      OrgCardNoLabel.Visible    := true;
      if Common.Card.Ds_Card = 'E' then
        OrgCardNoLabel.Caption               := Format('[원승인카드 - %s]',['간편결제'])
      else if Common.Card.Ds_Card = 'Z' then
        OrgCardNoLabel.Caption               := Format('[원승인카드 - %s]',['제로페이'])
      else if Common.Card.Ds_Card = 'K' then
        OrgCardNoLabel.Caption               := Format('[원승인카드 - %s]',['카카오페이'])
      else
        OrgCardNoLabel.Caption               := Format('[원승인카드 - %s]',[Common.Card.CardNo]);

      GetAmtEdit.Properties.MaxValue   := Common.Card.Amt;
      GetAmtEdit.Value                 := Common.Card.Amt;
      DcAmtEdit.Value                  := Common.Card.DcAmt;
      TipAmtEdit.Value                 := Common.Card.TipAmt;;
      ApprovalAmtEdit.Value            := Common.Card.Amt;
      HalbuEdit.Text                   := Common.Card.Halbu;
      UnionPayCheckBox.Checked         := Common.Card.Yn_UnionPay = 'Y';

      if Common.Card.Type_Trd = atCat then
      begin
        CardPanel.ActiveCard           := CatPager;
        ApprovalButton.Visible         := false;
      end;
    end
    else
    begin
      MessageLabel.Caption             := '분할 승인을 원할 시 "승인금액" 입력 후 승인요청 하세요';
      ApprovalButton.Caption           := '승인요청';
      OrgCardNoLabel.Visible           := false;

      //승인금액을 받을금액으로 셋팅
      //더치페이일 경우
      if (Common.PreSent.DutchPayAmt > 0) and (Common.PreSent.TipAmt = 0) then
      begin
        if (Common.Present.WRcvAmt - Common.PreSent.DutchPayAmt) < Common.PreSent.DutchPayAmt then
          Common.PreSent.DutchPayAmt   := Common.Present.WRcvAmt;
        GetAmtEdit.Properties.MaxValue := Common.PreSent.DutchPayAmt;
        GetAmtEdit.Value               := Common.PreSent.DutchPayAmt;
        Common.Config.Options[45]      := '1';
      end
      //복합결제에서 넘어온 금액
      else if CashToAmount > 0 then
      begin
        GetAmtEdit.Properties.MaxValue   := Common.Present.WRcvAmt;
        GetAmtEdit.Value                 := CashToAmount;
      end
      else
      begin
        GetAmtEdit.Properties.MaxValue   := Common.Present.WRcvAmt-Common.PreSent.TipAmt;
        GetAmtEdit.Value                 := Common.PreSent.WRcvAmt-Common.PreSent.TipAmt;
      end;
      TipAmtEdit.Properties.MaxValue    := Common.PreSent.TipAmt;
      TipAmtEdit.Value                  := Common.PreSent.TipAmt;
      ApprovalAmtEdit.SetFocus;
      ApprovalAmtEdit.SelectAll;
    end;

    //봉사료를 사용하지 않으면 승인금액을 수정할 수 있게 하기위하여
    if GetOption(20) = '0' then
      ApprovalAmtEdit.Properties.MaxValue  := GetAmtEdit.Properties.MaxValue;

    //받을금액이 없으면 승인금액을 못입력하게 한다(MaxValue가 0은 모든값이 허용이라)
    GetAmtEdit.Properties.ReadOnly := GetAmtEdit.Properties.MaxValue = 0;
    TipAmtEdit.Enabled             := Common.PreSent.TipAmt > 0;
    GetAmtEditExit(GetAmtEdit);

    ApprovalButton.Status.Caption    := FormatFloat(',0원', ApprovalAmtEdit.Value);
    CatApprovalButton.Status.Caption := FormatFloat(',0원', ApprovalAmtEdit.Value);

    MsrData := vTemp;

    //푸드코트를 사용하면서 신용카드를 코너별로 사용시
    if (GetOption(231) = '1') and (GetOption(249) = '1') then
    begin
      GetAmtEdit.Enabled  := False;
      ApprovalAmtEdit.Enabled := False;
    end;

    //출납에서 카드승인시는 금액변경 못하게
    if Common.CashBookCard then
    begin
      GetAmtEdit.Enabled      := False;
      ApprovalAmtEdit.Enabled := False;
    end;

    //승인일때만 자동으로 승인버튼을 누른다
    if ((MsrData <> '') or (GetOption(379) <> '0')) and (Common.Card.Type_Trd <> atCat) then
    begin
      Tmr_Execute.Enabled := True;
      Exit;
    end
    else if MsrData = 'EayPay' then
    begin
      Tmr_Execute.Enabled := True;
      Exit;
    end
    else
      ApprovalButton.Enabled := true;
  finally
    BlockInput(false);
  end;
end;

procedure TCard_F.HalbuEditEnter(Sender: TObject);
begin
  HalbuEdit.SelectAll;
end;

procedure TCard_F.HalbuEditExit(Sender: TObject);
begin
  HalbuEdit.Text := LPad(HalbuEdit.Text,2,'0');
end;

procedure TCard_F.HalbuEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    ApprovalButtonClick(nil);
  end;
end;

procedure TCard_F.PosPagerChange(Sender: TObject);
begin
  Tmr_IC.Enabled         := false;
  ApprovalButton.Visible := CardPanel.ActiveCard = PosPager;

end;

procedure TCard_F.PosTabShow(Sender: TObject);
begin
  ApprovalAmtEdit.SetFocus;
  ApprovalAmtEdit.SelectAll;
  MessageLabel.Caption :=   '';
end;


//****************************************************************************//
//                          카드가맹점 선택화면 호출
//****************************************************************************//
function  TCard_F.ApprovalAction(aEasyPay:String):Boolean;
var vIndex :Integer;
    visTax :Boolean;
    vRequestSaleAmt :Integer;
    vCardPrintMode :Integer;
    vTemp :String;
    vPos  :Integer;
    vTaxRate :Currency;
begin
  Result := False;

  if (GetOption(379)='1') and (Common.Config.ReceiptPrinterDev = 0) then
  begin
    Common.MsgBox('프린터가 설정되지 않았습니다');
    Exit;
  end;
  with Common.ICCard do
  begin
    FocusHandle := Self.Handle;
    ClearAll;
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

    Approval   := Common.Card.Ds_trd   = dtApproval;

    //부가세를 아래에서 계산해야할지 말지
    visTax := false;

    //취소 시 다중사업자를 사용하면 해당 밴정보를 가져온다
    if not Approval and (GetOption(60) = '1') then
    begin
      vIndex := Common.GetCornerIndex('',Common.Card.VanTID);
      if vIndex >=0 then
      begin
        Common.Config.van_Terid := Common.Corner[vIndex].VanTid;
        Common.Config.SerialNo  := Common.Corner[vIndex].VanSerial;
        Common.Config.BizNo     := GetOnlyNumber(Common.Corner[vIndex].BizNo);

        TerminalID := Common.Config.van_Terid;
        SerialNo   := Common.Config.SerialNo;
        BizNo      := Common.Config.BizNo;
      end
      else
      begin
        TerminalID := Common.Config.van_Terid;
        BizNo      := GetOnlyNumber(Common.Config.BizNo);
        SerialNo   := Common.Config.SerialNo;
        SaleAmt    := FtoI(ApprovalAmtEdit.Value);
        SvcAmt     := FtoI(TipAmtEdit.Value);
      end;
      if VAN = vtKFTC then
      begin
        with TIniFile.Create(Common.AppPath+'kftc.ini') do
          try
            WriteBool(TerminalID, 'FIRST',      TRUE);
          finally
            Free;
          end; // try .. finally ..
      end;
    end
    else if (GetOption(60) = '1') and (Common.GetCorner >= 0) then
    begin
      vIndex := Common.GetCorner;
      Common.Config.van_Terid := Common.Corner[vIndex].VanTid;
      Common.Config.SerialNo  := Common.Corner[vIndex].VanSerial;
      Common.Config.BizNo     := GetOnlyNumber(Common.Corner[vIndex].BizNo);
      Common.Card.Corner      := Common.Corner[vIndex].Code;

      TerminalID := Common.Config.van_Terid;
      SerialNo   := Common.Config.SerialNo;
      BizNo      := Common.Config.BizNo;
      SaleAmt    := FtoI(ApprovalAmtEdit.Value);
      SvcAmt     := FtoI(TipAmtEdit.Value);
    end
    else
    begin
      TerminalID := Common.Config.van_Terid;
      BizNo      := GetOnlyNumber(Common.Config.BizNo);
      SerialNo   := Common.Config.SerialNo;
      SaleAmt    := FtoI(ApprovalAmtEdit.Value);
      SvcAmt     := FtoI(TipAmtEdit.Value);
    end;

    Common.ICCard.MultiVan   := GetOption(60) = '1';

    if not Approval then
      SaleAmt := FtoI(ApprovalAmtEdit.Value);


    //보안리더기를 사용하는데 단말기로 승인했을때는 단말기로 취소하도록 한다
    if not Approval and (Common.Card.Yn_Cat = 'Y') and (GetOption(379)<> '1')  then
      Common.Config.Options[379] := '1';

    WorkDate   := Common.WorkDate;
    SaleDate   := FormatDateTime('yyyymmdd',Now());
    PosVer     := GetFileVersion(Application.ExeName);
    PosNo      := Common.Config.PosNo;
    if Common.Config.ReceiptPrinterBaudRate >=0 then
      CatBaudRate   := BAUDRATE[Common.Config.ReceiptPrinterBaudRate]
    else
      CatBaudRate   := 9600;
    AgreeDcAmt   := Common.Card.DcAmt;
    UnionPay     := UnionPayCheckBox.Checked;
    //로그승인용 로그 저장여부
    CardLog      := GetOption(324) = '0';
    //현대M카드일때 할인제외금액
    DsDiscount   := Common.Card.DsDc;
    CatPort      := StoI(Common.Config.ReceiptPrinterPort);

    //금결원일때는 위에서 결정
    if VAN <> vtKFTC then
    begin
      if (aEasyPay = '') and (ApprovalButton.Tag = 0) then
      begin
        EasyPay     := false;
        EasyPayCode := '';
      end
      else if (aEasyPay = 'M') or (ApprovalButton.Tag = 1) then
      begin
        EasyPay     := true;
        EasyPayCode := '';
      end
      else if (aEasyPay <> '') and (ApprovalButton.Tag = 2) then
      begin
        EasyPay     := true;
        EasyPayCode := aEasyPay;
      end
      else
      begin
        EasyPay     := true;
        EasyPayCode := aEasyPay;
      end;
    end
    else
    begin
      //삼성페일때만
      if (Length(Common.KFTCDetectData) = 4) and (RightStr(Common.KFTCDetectData,1)='2') then
        DetectNo := LeftStr(Common.KFTCDetectData,1);
      EasyPay  := aEasyPay = 'M';
    end;

    PayCode       := Common.Card.PayCode;

    Parent     := Self;

    if (VAN = vtSmartro) and (FUnionPass <> EmptyStr) then
    begin
      UnionPay := True;
    end
    else if (VAN = vtJTNET) then
    begin
      if Common.Config.VanEasyPay = 'T' then
        EasyPay := true
      else
        EasyPay := false;
    end
    //KSNET 토스프론트일때
    else if (VAN = vtKSNET) and (Common.Config.VanEasyPay = 'T') then
    begin
      EasyPay := true;
      EasyPayCode := 'TC';
    end;


    RealMode   := True;

    //포인트카드번호가 없거나 취소모드일때는 현금으로
    AppType    := atCard;


    if GetOption(379) = '1' then
      AppType := atCatCard
    else if (GetOption(379) = '2') or (VAN in [vtKOCES, vtSmartro, vtNICE]) then
      AppType := atVCatCard;

    CardTrack2 := Common.Card.CardNoFull;
    HalbuMonth := StoI(HalbuEdit.Text);

    LogPath    := Common.AppPath;
    Valid      := Common.Card.Valid;

    //합계금액과 받을금액이 같으면서 승인금액도 같을때
    if Approval and (Common.PreSent.RcvAmt = 0) and (SaleAmt = Common.PreSent.WRcvAmt)
      and ((Common.PreSent.TotalAmt+Ifthen(GetOption(160)='0', Common.PreSent.TipAmt, 0) - Common.PreSent.TotalDc) = Common.PreSent.WRcvAmt) then
    begin
      VatAmt := Abs(Common.PreSent.TaxAmt);
    end
    else if Approval then
    begin
      //총금액에 과세메뉴 비율으 구한다  예 총 10,000원 과세8,000 면세 2,000
      //승인요청금액 5,000원
      vTaxRate := (Common.PreSent.DutyAmt+Common.PreSent.TaxAmt) / (Common.PreSent.TotalAmt+Ifthen(GetOption(160)='0', Common.PreSent.TipAmt, 0) - Common.PreSent.TotalDc);
      if vTaxRate < 0 then
        vTaxRate := 1;
      VatAmt   := FtoI(hTrunc( (SaleAmt * vTaxRate) / 11 ,1))
    end
    else if not Approval then
      VatAmt := Abs(Common.Card.VatAmt);

    //취소시
    if not Approval then
    begin
      OrgAgreeNo  := Common.Card.OrgApprovalNo;
      OrgSaleDate := Common.Card.Trd_Date_Org;
      CardType    := Common.Card.Ds_Card;
      TransNo     := Common.Card.TransNo;
      EasyPayNo   := Common.Card.EasyPayNo;

      if (VAN = vtFDIK) and ((Common.Card.Ds_Card = 'Z') or (Common.Card.Ds_Card = 'K') or (Common.Card.Ds_Card = 'S') or (Common.Card.Ds_Card = 'A')) then
        EasyPay := true;

      if ((VAN = vtKoces) and (EasyPayNo <> '')) or ((VAN = vtFDIK) and (Common.Card.Ds_Card = 'K')) then
      begin
        if not Common.AskBox('간편결제를 취소하시겠습니까?'#13'간편결제 취소는 QR리딩없이 진행됩니다') then
          Exit;
      end;
    end;

    //5만원이하 전자서명 사용안함
    NoCVM   := false;
    if (SaleAmt <= 50000) and not UnionPay then
    begin
      NoCVM   := true;
      Common.Card.Yn_NoCVM := 'Y';
    end;

    try
      if (GetOption(379) = '0') and (VAN = vtKFTC) then
      begin
        if not isCardFormDetect then
          Common.ShowWaitForm('IC카드를 넣어 주세요..',True)
        else
          Common.ShowWaitForm('승인요청 중 입니다',True);
      end;

      //Cat 단말기 연동시
      if GetOption(379) = '1' then
      begin
        Common.Device.SetPrintPort(false);
        if FisCatFallBack then
          Common.ShowWaitForm('IC카드 리딩오류! MS로 읽혀주세요',True)
        else if VAN = vtNice then
          Common.ShowWaitForm('단말기에 IC 카드를 넣어 주세요...',True)
        else
          Common.ShowWaitForm('단말기에서 승인 중 입니다....'#13'(단말기 종료버튼을 누르면 취소됩니다)');
        FisCatFallBack := false;
        Common.WriteLog('work', Format('[카드]단말기 승인요청 - %d(%d)',[Common.ICCard.SaleAmt, Common.ICCard.VatAmt]));
        vRequestSaleAmt := Common.ICCard.SaleAmt;
      end;

      //VCat 단말기 연동시
      if GetOption(379) = '2' then
      begin
        Common.WriteLog('work', Format('[카드]VCat 승인요청 - %d(%d)',[Common.ICCard.SaleAmt, Common.ICCard.VatAmt]));
        vRequestSaleAmt := Common.ICCard.SaleAmt;
      end;
      isExecute := false;

      if not Execute then
      begin
//        BlockInput(false);
        //다우 VCAT일때
        if (GetOption(379) = '2') and (VAN = vtDaou) then
          Sleep(300)
        else if GetOption(379) = '1' then
          Sleep(200);
        Application.ProcessMessages;
        if Self.Handle <> GetForeGroundWindow then
          SetForegroundWindow(Self.Handle);
        Common.HideWaitForm;
        if GetOption(379) = '1' then
        begin
          Common.WriteLog('work', Format('[카드]단말기 승인실패 - %s',[Common.ICCard.Note]));
          Common.Device.SetPrintPort(true);
        end;

        if GetOption(379) = '2' then
          Common.WriteLog('work', Format('[카드]VCat 승인실패 - %s',[Common.ICCard.Note]));

        if ((GetOption(379)='0')) and (VAN = vtKFTC) then
        begin
          Sleep(500);
          Common.ICCard.AppType := atOnlyICInit;
          Common.ICCard.Execute;
        end;
        Result := False;

        Common.Config.Options[379] := Common.Option_379;
        ErrMsg := Note;
        if not Approval and (GetOption(60) = '1') then
          ErrMsg := Format('%s[%s]',[ErrMsg,Common.Config.van_Terid]);
        Common.ErrBox(ErrMsg);
        ErrMsg := Replace(ErrMsg, #13, ' ');
        ApprovalButton.Visible := true;

        if (Common.ICCard.VAN = vtKSNET) and (Trim(Note) = '리더기 오류     미지원 기능') then
        begin
          Common.MsgBox('KSCAT 프로그램을 재시작합니다');
          KillTask('KSCAT.exe');
          ExcuteProgram('C:\KSCAT\KSCAT.exe');
        end;
      end
      else
      begin
        Common.Card.RealMode      := RealMode;
        if GetOption(379) = '2' then
          Common.Card.Type_Trd := atSwipe;

        Common.Card.Ds_Card       := Ifthen(CardType='','C',CardType);
        Common.Card.CardNo        := LeftStr(Common.ICCard.CardNo,30);

        Common.Card.cd_buy        := CompCode;       // 매입사코드
        Common.Card.nm_buy        := CompName;       // 매입사이름
        Common.Card.Nm_Card       := BalgupsaName;   // 발급사이름
        Common.Card.ApprovalNo    := AgreeNo;        // 승인번호
        Common.Card.Halbu         := FormatFloat('00',HalbuMonth); // 할부개월
        Common.Card.Amt           := AgreeAmt;       // 승인금액
        Common.Card.DcAmt         := AgreeDcAmt;     // 할인금액

        Common.Card.TipAmt        := TipAmtEdit.EditValue;// SvcAmt;취소시에 봉사료금액을 안넣는 밴사가 있어서
        Common.Card.VatAmt        := VatAmt;
        Common.Card.ChainPL       := KamaengNo;      // 가맹점번호
        Common.Card.Trd_Date      := AgreeDate;      // 승인일자
        Common.Card.Trd_Time      := AgreeTime;      // 승인시간
        Common.Card.ImgFile       := ImgFileName;    // 전자서명화일명
        Common.Card.Note          := Note;
        Common.Card.BalanceAmt    := BalanceAmt;
        Common.Card.Yn_UnionPay   := Ifthen(UnionPayCheckBox.Checked, 'Y','N');
        Common.Card.Yn_Cat        := YnCat;
        Common.Card.VanTID        := TerminalID;
        Common.Card.Yn_Print      := 'Y';
        Common.Card.TransNo       := TransNo;
        Common.Card.PayCode       := PayCode;
        Common.Card.EasyPayNo     := EasyPayNo;

        //카드봉사료
        Common.PreSent.CardTipAmt := Common.PreSent.CardTipAmt + SvcAmt;
        Common.PreSent.CashTipAmt := Common.PreSent.CashTipAmt - Common.PreSent.CardTipAmt;
        Common.PreSent.KaKaoDc    := Common.PreSent.KaKaoDc + Common.Card.DcAmt;
        ErrMsg                    := Note;
        if Approval then
        begin
          Common.CardInfoSave;
          Common.PreSent.CardAmt := Common.PreSent.CardAmt + Common.Card.Amt;
          try
            if Assigned(Order_F) and Order_F.Showing then Order_F.DisplayPresent;
          except
          end;
        end;
        Result := True;

        if (GetOption(379) = '2') and (VAN = vtDaou) then
          Sleep(300)
        else if GetOption(379) = '1' then
          Sleep(200);

        Application.ProcessMessages;
        if Self.Handle <> GetForeGroundWindow then
          SetForegroundWindow(Self.Handle);

        isExecute := true;
        Common.WriteLog('work', Format('[카드]정상승인 - 카드번호[%s]승인번호[%s]승인금액[%d]',[Common.ICCard.CardNo, Common.ICCard.AgreeNo, Common.ICCard.AgreeAmt]));
        if vRequestSaleAmt <> Common.ICCard.SaleAmt then
        begin
          Common.ErrBox(Format('포스에서 승인요청금액(%d)과'#13'단말기에서 실제 승인금액(%d)이 다릅니다'#13#13'반드시 관리대리점 확인바랍니다',[vRequestSaleAmt, Common.ICCard.SaleAmt]));
        end;
        if VAN = vtKOVAN then
          Sleep(1000);

        Common.Card.CardNo := Common.ICCard.CardNo;
        if GetOption(379) = '1' then
          Common.Device.SetPrintPort(true);

        Common.HideWaitForm;

        //카드제거 음성
        if (GetOption(55) = '1') and (GetOption(379) = '1') then
        begin
          PlaySound(nil, 0, SND_MEMORY or SND_ASYNC);
          PlaySound(PChar('finishwave'), Common.DllHandle, SND_RESOURCE or SND_ASYNC);
        end;

        Common.Config.Options[379] := Common.Option_379;

        //카드취소 시 문자발송
        if not Approval and (GetOption(229) = '1') then
        begin
          For vIndex := 0 to Common.Config.StoreMobile.Count-1 do
          begin
            if Length(Common.Config.StoreMobile[vIndex]) >= 9 then
            begin
              Common.KaKaoSendMessage('P',[Format('[카드취소] %d 원 (원승인일시 : %s) [%s]',[AgreeAmt, FormatMaskText('!0000-00-00 00:00;0;',AgreeDate+AgreeTime),FormatDateTime('mm월dd일hh시nn분', now()) ])],
                                    Common.Config.StoreMobile[vIndex]);
            end;
          end;
        end;
        Common.HideWaitForm;
      end;
    except
    end;
    ClearAll;
  end;
end;


procedure TCard_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var vKey :String;

begin
   case Key of
     VK_F10  : begin
                 if (ActiveControl is TCustomEdit) then TCustomEdit(ActiveControl).Clear;
               end;
     27      :  CloseButton.Click;
     48..57  :  vKey := chr(Key);
     96..105 :  vKey := chr(Key-48);
     else vKey := chr(Key);
   end;

  if Shift = [ssCtrl] then
    Key := 0;
end;

procedure TCard_F.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CashToAmount  := 0;
  Common.Config.Options[379] := Common.Option_379;
  Common.ICCard.ClearAll;
end;

//****************************************************************************//
//                          초기화버튼 클릭시
//****************************************************************************//
procedure TCard_F.Tmr_ExecuteTimer(Sender: TObject);
begin
  Tmr_Execute.Enabled := False;
  try
    if ((Common.Card.Ds_trd = dtApproval) and
      ( ((GetOption(63) = '1') and (GetAmtEdit.Value < 50000))
       or ((GetOption(63) = '2') and (GetAmtEdit.Value < 100000))
       or ((GetOption(63) = '3') and (GetAmtEdit.Value < 300000))
       or ((GetOption(63) = '4') and (GetAmtEdit.Value < 500000))
       or (Common.KFTCDetectData <> '')) ) or ((Common.Card.Ds_trd = dtCancel) and (GetOption(379) <> '0'))
       then
    begin
      if (Pos(#3,MsrData) > 0) and (Copy(MsrData,1,1) = '0') then
        FisCatFallBack := true;

      if EasyPayButton.Visible and (Common.Config.van_trd <> vanFDIK) and ((Common.Card.Ds_Card = 'Z') or (Common.Card.Ds_Card = 'K') or (Common.Card.Ds_Card = 'E') or (MsrData = 'EasyPay')) then
        EasyPayButtonClick(EasyPayButton)
      else
      begin
        ApprovalButtonClick(ApprovalButton);
        Common.KFTCDetectData := '';
      end;
    end
    else if MsrData = 'EasyPay' then
      EasyPayButtonClick(EasyPayButton);
    ApprovalButton.Enabled := true;
    ApprovalAmtEdit.SelectAll;
  finally
    Common.isKFTCDetect   := true;
    Common.KFTCDetectData := '';
  end;
end;


procedure TCard_F.LogApprovalButtonClick(Sender: TObject);
var vTemp :String;
begin
  if not Common.AskBox('로그로 승인처리하시겠습니까?') then Exit;
  vTemp := Common.GetCardLog(False);
  with Common.Card do
  begin
    CardNo      := CopyPos(vTemp, '|', 1);         //카드번호
    cd_buy      := CopyPos(vTemp, '|', 2);         //매입사코드
    nm_buy      := CopyPos(vTemp, '|', 3);         //매입사명
    Nm_Card     := CopyPos(vTemp, '|', 4);         //발급사명
    ApprovalNo  := CopyPos(vTemp, '|', 5);         //승인번호
    Amt         := StoI(CopyPos(vTemp, '|', 6));   //승인금액
    ChainPL     := CopyPos(vTemp, '|', 7);         //가맹점번호
    Trd_Date    := CopyPos(vTemp, '|', 8);         //승인일자
    Trd_Time    := CopyPos(vTemp, '|', 9);         //승인시간
    TipAmt      := StoI(CopyPos(vTemp, '|', 10));  //봉사료
    Halbu       := CopyPos(vTemp, '|', 11);        //할부기간
    Valid       := CopyPos(vTemp, '|', 12);        //유효기간
    Type_Trd    := 'S';
    ImgFile     := '';
  end;

  if Common.PreSent.WRcvAmt < Common.Card.Amt then
  begin
    Common.MsgBox('받을금액보다 로그의 금액이 큽니다');
    Exit;
  end;

  Common.CardInfoSave;
  Common.PreSent.CardAmt := Common.PreSent.CardAmt + Common.Card.Amt;
  if not Common.CashBookCard and Assigned(Order_F) and Order_F.Showing then Order_F.DisplayPresent;

  ModalResult := mrOK;
end;


procedure TCard_F.ApprovalAmtEditExit(Sender: TObject);
begin
  ApprovalAmtEdit.PostEditValue;
end;

procedure TCard_F.ApprovalAmtEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    HalbuEdit.SetFocus;
  end;
end;

procedure TCard_F.ApprovalButtonClick(Sender: TObject);
var Index :Integer;
    vError :Boolean;
    vTemp  :String;
    vTaxRate : Currency;
    vOption379 :Char;
begin
  if MilliSecondsBetween(Now(),ClickTime) < 1000 then Exit;
  try
    BlockInput(true);
    ClickTime := Now;
    vOption379 := Common.Config.Options[379];
    if Sender = CatApprovalButton then
      Common.Config.Options[379] := '1';
    MainGroupBox.Visible      := true;
    ApprovalButton.Enabled    := false;
    CatApprovalButton.Enabled := false;
    EasyPayButton.Enabled     := false;
    CloseButton.Enabled       := false;
    if (Common.Card.Ds_trd = dtApproval) and (Common.PreSent.WRcvAmt = 0) then
    begin
      MessageLabel.Caption := '승인금액이 없습니다';
      Exit;
    end;

    if (Sender <> nil) and (Common.Card.Ds_trd = dtApproval) then
      Common.Card.Ds_Card := 'C';
    Common.WriteLog('work', '카드승인['+FormatFloat('#,0',ApprovalAmtEdit.Value)+']');

    if Self.Enabled then
      edtTemp.SetFocus;
    if CardPanel.ActiveCard = PosPager then
    begin
      if ApprovalAmtEdit.Value  <= 0 then
      begin
        MessageLabel.Caption := '결제금액을 입력해 주십시오.';
        if ApprovalAmtEdit.Enabled then
          ApprovalAmtEdit.SetFocus;
        exit;
      end;

      MessageLabel.Caption := Common.GetPaPago('승인요청 중 입니다...잠시만 기다려주세요(최대30초)');
      try
        Screen.cursor  := crHourGlass;

        if ApprovalAction(ApprovalButton.Hint) then
        begin
          if (Common.PreSent.WRcvAmt = 0) or Common.CashBookCard then
            ModalResult := mrOK
          else
          begin
            GetAmtEdit.Value      := Common.PreSent.WRcvAmt;
            ApprovalAmtEdit.Value := Common.PreSent.WRcvAmt;
            ApprovalAmtEdit.Properties.MaxValue := Common.PreSent.WRcvAmt;
            ModalResult := mrOK;
          end;
        end
        else
        begin
          MessageLabel.Caption               := ErrMsg;
          Common.WriteLog('work', Format('Error:%s',[ErrMsg]));
        end;
      finally
        Screen.Cursor       := crDefault;
        ApprovalButton.Hint := '';
      end;
    end  //외부
    else
    begin
      if GetAmtEdit.Value  <= 0 then
      begin
        MessageLabel.Caption := Common.GetPaPago('결제금액을 입력해 주십시오.');
        Exit;
      end;

      //합계금액과 받을금액이 같으면서 승인금액도 같을때
      if (Common.Card.Ds_trd = dtApproval) and (Common.PreSent.WRcvAmt = GetAmtEdit.Value) and (Common.PreSent.RcvAmt = 0) then
      begin
        Common.Card.VatAmt := Abs(Common.PreSent.TaxAmt);
      end
      else if (Common.Card.Ds_trd = dtCancel) then
        Common.Card.VatAmt := Abs(Common.Card.VatAmt)
      else if (Common.Card.Ds_trd = dtApproval) then
      begin
        //과세일때는 부가세금액을을 계산한다
        vTaxRate := Common.PreSent.DutyAmt / Common.PreSent.RcvAmt;
        Common.Card.VatAmt   := FtoI(hTrunc( (ApprovalAmtEdit.Value * vTaxRate) / 11 ,1));
      end;

      Common.Card.Amt         := FtoI(ApprovalAmtEdit.Value);//승인금액
      Common.Card.TipAmt      := TipAmtEdit.EditValue;
      Common.Card.Type_Trd    := atCat;                     //거래유형
      Common.Card.Corner      := '000000';

      Common.PreSent.CardTipAmt := Common.Card.TipAmt;
      Common.PreSent.CashTipAmt := 0;

      if Common.Card.Ds_trd = dtApproval then
      begin
        try
          Common.CardInfoSave;
        except
        end;
        Common.PreSent.CardAmt := Common.PreSent.CardAmt + Common.Card.Amt;
        try
          if not Common.CashBookCard and Assigned(Order_F) and Order_F.Showing then Order_F.DisplayPresent;
        except
        end;
      end;
      ModalResult := mrOK;
    end;
  finally
    Common.Config.Options[379] := vOption379;
    BlockInput(false);
    ApprovalButton.Enabled    := true;
    CatApprovalButton.Enabled := true;
    EasyPayButton.Enabled     := true;
    CloseButton.Enabled       := true;
    Common.ICCard.ClearAll;
    Tmr_Enabled.Enabled := true;
  end;
end;

procedure TCard_F.ApprovalExecute;
begin
  ApprovalButtonClick(ApprovalButton);
end;

procedure TCard_F.Tmr_ICTimer(Sender: TObject);
begin
  Tmr_IC.Enabled := false;
  if isCardFormDetect or
     ((Common.DetectData <> '')
     and ( ((GetOption(63) = '1') and (GetAmtEdit.Value < 50000))
        or ((GetOption(63) = '2') and (GetAmtEdit.Value < 100000))
        or ((GetOption(63) = '3') and (GetAmtEdit.Value < 300000))
        or ((GetOption(63) = '4') and (GetAmtEdit.Value < 500000)) ))  then
    ApprovalButtonClick(nil);
  isCardFormDetect := false;
end;

procedure TCard_F.ToggleSwitchClick(Sender: TObject);
begin
  if ToggleSwitch.State = tssOn then
  begin
    MessageLabel.Caption     :=  Common.GetPapago('단말기에서 승인된 내역을 입력합니다(실제승인은 안됨)');
    CardPanel.ActiveCard     :=  CatPager;
    ApprovalButton.Visible   := false;
    EasyPayButton.Visible    := false;
    UnionPayCheckBox.Enabled := false;
    CatApprovalButton.Visible:= false;
  end
  else
  begin
    MessageLabel.Caption     :=  '';
    CardPanel.ActiveCard     :=  PosPager;
    ApprovalButton.Visible   := true;
    EasyPayButton.Visible    := EasyPayButton.Tag = 0;
    CatApprovalButton.Visible:= (GetOption(379) = '2') and (GetOption(495) = '1') and not Common.Config.PosCatUse;
    UnionPayCheckBox.Enabled := true;
  end;
end;

procedure TCard_F.GetAmtEditExit(Sender: TObject);
begin
  if Sender = nil then Exit;
  (Sender as TcxCurrencyEdit).PostEditValue;
  ApprovalAmtEdit.Value   := TipAmtEdit.Value + GetAmtEdit.Value;
  GetAmtEdit.EditModified := false;
end;

procedure TCard_F.GetAmtEditPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  if DisplayValue > (Sender as TcxCurrencyEdit).Properties.MaxValue then
  begin
    Error        := false;
    Common.ErrBox(Format('최대금액은 %s원 입니다',[FormatFloat(',0',GetAmtEdit.Properties.MaxValue)]));
    DisplayValue := GetAmtEdit.Properties.MaxValue;
    if CardPanel.ActiveCard = PosPager then
    begin
      (Sender as TcxCurrencyEdit).SelectAll;
      (Sender as TcxCurrencyEdit).SetFocus;
    end;
  end
  else if DisplayValue < (Sender as TcxCurrencyEdit).Properties.MinValue then
  begin
    Common.ErrBox(Format('최소금액은 %s원 입니다',[FormatFloat(',0',GetAmtEdit.Properties.MinValue)]));
    DisplayValue := GetAmtEdit.Properties.MinValue;
    Error        := false;
    if CardPanel.ActiveCard = PosPager then
    begin
      (Sender as TcxCurrencyEdit).SelectAll;
      (Sender as TcxCurrencyEdit).SetFocus;
    end;
  end;
  ApprovalButton.Status.Caption    := FormatFloat(',0원', (Sender as TcxCurrencyEdit).Value);
  CatApprovalButton.Status.Caption := FormatFloat(',0원', (Sender as TcxCurrencyEdit).Value);
end;

procedure TCard_F.CloseButtonClick(Sender: TObject);
begin
  Common.WriteLog('work', '카드(닫기)');
  ModalResult := mrCancel;
end;

procedure TCard_F.EasyPayButtonClick(Sender: TObject);
begin
  if MilliSecondsBetween(Now(),ClickTime) < 100 then Exit;
  Common.WriteLog('work', '카드승인(간편결제)['+FormatFloat('#,0',ApprovalAmtEdit.Value)+']');
  try
    ClickTime := Now;
    //멀티패드 사용
    if (Common.Config.VanEasyPay = 'M') or (Common.Config.van_trd = vanSPC) then
    begin
      ApprovalButton.Hint := 'M';
      ClickTime           := IncSecond(Now,-3);
      ApprovalButtonClick(ApprovalButton);
    end
    else  //스캐너사용
    begin
      with TEasyPay_F.Create(Self) do
      try
        if ShowModal <> mrOK then Exit;

        if Common.Config.van_trd = vanFDIK then
        begin
          ApprovalButton.Hint := BarCodeLabel.Caption;
          ApprovalButton.Tag  := 2;
          ApprovalButtonClick(ApprovalButton);
        end
        else
        begin
          ApprovalButton.Hint := Ifthen(BarCodeLabel.Caption='','M',BarCodeLabel.Caption);
          //KIS 일때 간편결제로 표시
          if (Common.Config.van_trd = vanKIS) and (GetOption(379)='2') and (ApprovalButton.Hint = '') then
            ApprovalButton.Tag := 1
          else
            ApprovalButton.Tag := 0;
          ApprovalButtonClick(ApprovalButton);
        end;
        ApprovalButton.Hint := '';
      finally
        Free;
      end;
    end;
  finally
    ApprovalButton.Hint := '';
    ApprovalButton.Tag  := 0;
  end;
end;

procedure TCard_F.WMCopyData(var Msg: TMessage);
begin
  Common.HideWaitForm;
  Common.ShowWaitForm('은련카드 비밀번호를 입력하세요'#13);
end;

procedure TCard_F.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if HalbuEdit.Focused and (Key in ['0','1','2','3','4','5','6','7','8','9']) then
  begin
    if HalbuEdit.SelLength > 0 then
      HalbuEdit.Clear;
    if (Length(HalbuEdit.Text + Key) > 2) then
      HalbuEdit.Text := '0'+Key;
  end;

  if GetAmtEdit.Focused and (Key in ['0','1','2','3','4','5','6','7','8','9']) then
  begin
    if GetAmtEdit.SelLength > 0 then
      GetAmtEdit.Clear;
    if (Length(GetAmtEdit.Text + Key) > 8) or (GetAmtEdit.Properties.MaxValue < StrToInt((FtoS(GetAmtEdit.Value) + Key))) then
    begin
      Key := #0;
      GetAmtEdit.Value := GetAmtEdit.Properties.MaxValue;
    end;
  end;

  if ApprovalAmtEdit.Focused and (Key in ['0','1','2','3','4','5','6','7','8','9']) then
  begin
    if ApprovalAmtEdit.SelLength > 0 then
      ApprovalAmtEdit.Clear;
    if (Length(ApprovalAmtEdit.Text + Key) > 8) or (GetAmtEdit.Properties.MaxValue < StrToInt((FtoS(ApprovalAmtEdit.Value) + Key))) then
    begin
      Key := #0;
      ApprovalAmtEdit.Value := GetAmtEdit.Properties.MaxValue;
      ApprovalAmtEdit.SelectAll;
    end;
  end;
end;

procedure TCard_F.Tmr_EnabledTimer(Sender: TObject);
begin
  Tmr_Enabled.Enabled  := false;
  MainGroupBox.Visible := false;
end;

procedure TCard_F.Chain1ButtonClick(Sender: TObject);
begin
  Common.MsgBox('반드시 단말기에서 승인을 받아야합니다'+#13+
                '실제 카드승인은 처리하지 않습니다');
  Common.Card.ChainPL     := (Sender as TAdvSmoothButton).Hint;         //가맹점번호
  Common.Card.Type_Trd    := atCAT;                     //거래유형
  if  Common.Card.Ds_trd = dtApproval then
  begin
    Common.Card.Amt         := FtoI(ApprovalAmtEdit.Value);//승인금액
    Common.CardInfoSave;
    if not Common.CashBookCard then
    begin
      Common.PreSent.CardAmt  := Common.PreSent.CardAmt + Common.Card.Amt;
      try
        if Assigned(Order_F) and Order_F.Showing then
          Order_F.DisplayPresent;
      except
      end;
    end;
  end;

  ModalResult := mrOK;
end;

end.





