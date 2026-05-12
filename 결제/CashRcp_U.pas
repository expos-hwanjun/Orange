//ToggleSwitch.State  tssOff(외부승인), tssOn(포스승인)
unit CashRcp_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, StrUtils,
  ExtCtrls,IniFiles, POSCard, GraphicEx, MaskUtils, KeyPad_F,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxCurrencyEdit, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, cxGroupBox, DateUtils, cxLabel,
  dxGDIPlusClasses, AdvGlowButton, AdvPageControl, Vcl.ComCtrls, AdvGlassButton,
  Vcl.Menus, cxButtons, System.ImageList, Vcl.ImgList, AdvSmoothToggleButton,
  AdvSmoothButton, Vcl.WinXCtrls, cxClasses;

type
  TCashRcp_F = class(TForm)
    fmKeyPad1: TfmKeyPad;
    Timer1: TTimer;
    Tmr_Approval: TTimer;
    Tmr_Msg: TTimer;
    edtTemp: TEdit;
    MainGroupBox: TcxGroupBox;
    Tmr_Enabled: TTimer;
    Tmr_Keyin: TTimer;
    MessageLabel: TLabel;
    MsgImage: TImage;
    cxLabel3: TcxLabel;
    ApprovalAmtEdit: TcxCurrencyEdit;
    cxLabel2: TcxLabel;
    ReceiveAmtEdit: TcxCurrencyEdit;
    RcvAmtLabel: TcxLabel;
    CloseButton: TcxButton;
    TitleLabel: TLabel;
    OrgNumberNoLabel: TcxLabel;
    OrgCardNoLabel: TcxLabel;
    ImageList1: TImageList;
    Tmr_Event: TTimer;
    PersonButton: TAdvSmoothToggleButton;
    BizButton: TAdvSmoothToggleButton;
    ApprovalButton: TAdvSmoothButton;
    PinPadButton: TAdvSmoothButton;
    ToggleSwitch: TToggleSwitch;
    NumberEdit: TcxTextEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure Tmr_ApprovalTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Tmr_EnabledTimer(Sender: TObject);
    procedure Tmr_KeyinTimer(Sender: TObject);
    procedure PinPadButtonClick(Sender: TObject);
    procedure ApprovalButtonClick(Sender: TObject);
    procedure NumberEditExit(Sender: TObject);
    procedure NumberEditEnter(Sender: TObject);
    procedure NumberEditKeyPress(Sender: TObject; var Key: Char);
    procedure ReceiveAmtEditExit(Sender: TObject);
    procedure ApprovalAmtEditExit(Sender: TObject);
    procedure ApprovalAmtEditKeyPress(Sender: TObject; var Key: Char);
    procedure ApprovalAmtEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure CloseButtonClick(Sender: TObject);
    procedure Num_010Click(Sender: TObject);
    procedure fmKeyPad1Num_BSClick(Sender: TObject);
    procedure PersonButtonClick(Sender: TObject);
    procedure ToggleSwitchClick(Sender: TObject);
  private
    ErrMsg :String;
    FDecryptData  :String;
    FEMVCardData  :String;
    isPinPad     :Boolean;   //JTNET VCAT 사용싱 핀패드 입력를 받기 위함
    ClickTime :TDateTime;
    function  GetGiftAmt:Integer;
    function  ApprovalAction:Boolean;
    procedure NumberSplit;
  public
    MsrData :String;
    procedure SetMsrData(aKind:Integer=0);  //Msr 데이터 조합
  end;

var
  CashRcp_F: TCashRcp_F;

implementation
uses Common_U, GlobalFunc_U, Const_U, Order_U, Math;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TCashRcp_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(PinPadButton);
  Common.SetButtonColor(ApprovalButton);
  ClickTime := IncSecond(Now(), -2);
end;

procedure TCashRcp_F.FormShow(Sender: TObject);
var vDsInput :String;
    vCardNo  :String;
begin
  Common.SetLanguage(Self);
  BlockInput(false);

  //두번눌리는현상 방지
  ClickTime         := IncSecond(Now,-3);

  vDsInput := Common.CashRcp.Ds_Input;
  if Common.CashRcp.Ds_Kind = '0' then
    PersonButtonClick(PersonButton)
  else
    PersonButtonClick(BizButton);


  PinPadButton.Visible := (GetOption(379) = '2') or Common.Config.SmartPad;
  //VCAT면 고객입력번튼 안보이게
  if (Common.Config.van_trd in [vanKIS, vanKFTC, vanSPC]) and (GetOption(379) = '2') and not Common.Config.SmartPad then
    PinPadButton.Visible := false;

  ReceiveAmtEdit.Properties.ReadOnly := false;
  NumberEdit.Clear;
  isPinPad := false;
  PinPadButton.Enabled := true;
  ToggleSwitch.Enabled := true;
  PinPadButton.Tag := 0;
  MessageLabel.Caption := EmptyStr;
  MsrData         := EmptyStr;
  FDecryptData    := EmptyStr;

   {최대금액에 받을금액까지만 가능하게함}
  if Common.CashRcp.Ds_Trd = dtApproval then
  begin
    ApprovalButton.Caption           := '승인요청';
    OrgCardNoLabel.Caption   := '';
    OrgCardNoLabel.Visible   := false;
    OrgNumberNoLabel.Visible := false;

    if (Common.PreSent.DutchPayAmt > 0) and (Common.PreSent.TipAmt = 0) then
    begin
      if (Common.Present.WRcvAmt - Common.PreSent.DutchPayAmt) < Common.PreSent.DutchPayAmt then
        Common.PreSent.DutchPayAmt := Common.Present.WRcvAmt;
      ApprovalAmtEdit.Properties.MaxValue  := Common.PreSent.DutchPayAmt;
      ApprovalAmtEdit.Value                := Common.PreSent.DutchPayAmt;
      ReceiveAmtEdit.Value               := Common.PreSent.DutchPayAmt;
    end
    else
    begin
      ApprovalAmtEdit.Properties.MaxValue := Common.PreSent.WRcvAmt+GetGiftAmt;
      if ReceiveAmtEdit.Value = 0 then
      begin
        ReceiveAmtEdit.Value              := Common.PreSent.WRcvAmt;
        ApprovalAmtEdit.Value               := Common.PreSent.WRcvAmt+GetGiftAmt;
      end
      else ApprovalAmtEdit.Value               := ReceiveAmtEdit.Value;

      ReceiveAmtEdit.Properties.ReadOnly := False;
      ApprovalAmtEdit.Properties.ReadOnly  := False;
    end;

    //투밴을 사용하거나 푸트코트를 사용할때는 금액을 수정하지 못한다
    if (GetOption(60) = '1')  or
       ((GetOption(231) = '1') and (GetOption(249) = '1')) then
      ApprovalAmtEdit.Properties.ReadOnly  := True;

    ToggleSwitch.State := tssOff;
    ToggleSwitchClick(nil);
    Common.CashRcp.Ds_Input := 'K';
    if GetOption(266) = '1' then
      NumberEdit.Text := Ifthen(Trim(Common.Member.no_cashrcp)='', Common.Member.MobileTel, Common.Member.no_cashrcp) ;
    NumberEdit.SetFocus;

    if (GetOption(400) = '1') then
    begin
      if (NumberEdit.Text = EmptyStr) and (GetOption(379) = '2') and (Common.Config.van_trd in [vanJTNET,vanNICE,vanDaou]) then
        Tmr_Keyin.Enabled := true
      else if (NumberEdit.Text = EmptyStr) and ((GetOption(379)='0')) and (Common.Config.van_trd in [vanKIS,vanSPC,vanSmartro,vanKFTC,vanJTNET]) then
      begin
        Tmr_Keyin.Enabled := true;
      end
      else
      begin
        Timer1.Tag     := 1;
        if not IsDebuggerPresent then
          Timer1.Enabled := True;
      end;
    end;
  end
  else //취소시
  begin
    ApprovalButton.Caption           := '취소요청';
    ApprovalButton.Color             := $000000CC;

    OrgCardNoLabel.Visible   := true;
    OrgNumberNoLabel.Visible := true;
    ApprovalAmtEdit.Properties.AssignedValues.MaxValue := False;
    ReceiveAmtEdit.Value     := Common.CashRcp.Amt_Approval;
    ApprovalAmtEdit.Value    := Common.CashRcp.Amt_Approval;
    ReceiveAmtEdit.Properties.ReadOnly := True;
    ApprovalAmtEdit.Properties.ReadOnly  := True;
    vCardNo  := Common.CashRcp.CardNo;
    Common.CashRcp.Ds_Input := vDsInput;
    if Common.CashRcp.Ds_Input = 'O' then
    begin
      ToggleSwitch.State   := tssOn;
      ToggleSwitch.Enabled := false;
    end
    else
      ToggleSwitch.State := tssOff;


    ToggleSwitchClick(nil);
    Common.CashRcp.Ds_Input := vDsInput;
    Common.CashRcp.CardNo   := vCardNo;

    OrgCardNoLabel.Caption := Common.CashRcp.CardNoFull;
    if Pos('*',Common.CashRcp.CardNoFull) = 0 then
    begin
      NumberEdit.Text := Common.CashRcp.CardNoFull;
      NumberEditExit(NumberEdit);
    end;

    if Pos('*',NumberEdit.Text) > 0 then
      NumberEdit.Clear;

    if Common.CashRcp.Ds_Input = 'S' then
    begin
      NumberEdit.Clear;
      NumberEdit.SetFocus;
    end;

    //개인용인지 사업자용으로 발행했었으면...
    if Common.CashRcp.Ds_Kind = '0' then
      PersonButtonClick(PersonButton)
    else
      PersonButtonClick(BizButton);

    //자진발급 취소이면 자동으로 한다
    if Common.CashRcp.Ds_Kind = '2' then
      Timer1.Enabled := True
    //자동승인요청
    else if (GetOption(400) = '1') and ((GetOnlyNumber(NumberEdit.Text) <> NumberEdit.Text) or (Length(GetOnlyNumber(NumberEdit.Text)) < 10)) then
    begin
      Timer1.Tag     := 1;
      Timer1.Enabled := True;
    end;
  end;

  ReceiveAmtEdit.Properties.ReadOnly := (GetOption(60) = '1') or (Common.CashRcp.Ds_Trd = dtCancel);
  ApprovalAmtEdit.Properties.ReadOnly  := (GetOption(60) = '1') or (Common.CashRcp.Ds_Trd = dtCancel);
end;

procedure TCashRcp_F.SetMsrData(aKind:Integer=0);  //Msr 데이터 조합
   function Get2Track(AValue:String):String;
   var I   :Integer;
   begin
      Result := '';
      For I:=1 to Length(AValue) do
      begin
         Case AValue[I] of
           #48..#57, #42, #61: Result := Result + AValue[I];
         end;
      end;
   end;
var
   vReadData : String;
begin
  if MsrData = EmptyStr then
    vReadData := CtoC(NumberEdit.Text,'-','')
  else
    vReadData := MsrData;

  if Length(vReadData) = 0 then Exit;
  if aKind = 0 then
  begin
    Common.CashRcp.CardNoFull := Get2Track(vReadData);
    {카드번호}
    Common.CashRcp.CardNo    := Get2Track(Copy(vReadData,2, Ifthen(Pos('=',vReadData)=0, Length(vReadData),Pos('=',vReadData)-2)));
    Common.CashRcp.Ds_Input   := 'S';
    NumberEdit.Text    := Common.CashRcp.CardNo;
    NumberSplit;
  end
  else
  begin
    Common.CashRcp.CardNoFull := Get2Track(vReadData);
    vReadData := Common.CashRcp.CardNoFull;
    ReceiveAmtEdit.SetFocus;
  end;
end;

function TCashRcp_F.GetGiftAmt:Integer;
begin
  if GetOption(441) = '1' then
    Result := 0
  else
    Result := Common.PreSent.GiftAmt;
end;


function TCashRcp_F.ApprovalAction: Boolean;
var visTax :Boolean;
    vKeyInData :String;
    vIndex :Integer;
begin
  Result := false;
  ApprovalAmtEdit.PostEditValue;
  ReceiveAmtEdit.PostEditValue;

  if (GetOption(379) = '1') and (Common.Config.ReceiptPrinterDev = 0) then
  begin
    Common.MsgBox('프린터가 설정되지 않았습니다');
    Exit;
  end;

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
      9 :
        begin
          //금결원일때 멀티패드를 사용한다고 설정하면 신전문을 사용
          if Common.Config.VanEasyPay = '1' then
            EasyPay := true;

          VAN    := vtKFTC;
        end;
     10 : VAN    := vtSmartro;
     11 : VAN    := vtKOVAN;
     12 : VAN    := vtSPC;
    end;

    visTax := False;

    //승인이면서 메뉴별  투밴사용시
    SaleAmt    := FtoI(ApprovalAmtEdit.Value);

    //합계금액과 받은금액이 같으면서 승인금액도 같을때
    if (Common.CashRcp.Ds_Trd = dtApproval ) and (Common.PreSent.RcvAmt = 0) and (SaleAmt = Common.PreSent.WRcvAmt) then
    begin
      VatAmt := Abs(Common.PreSent.TaxAmt);
      if (VatAmt * 11) > SaleAmt then
        VatAmt := FtoI(hTrunc( SaleAmt / 11 ,1));
    end
    //취소일때는 승인 시 부가세를 넣느다
    else if (Common.CashRcp.Ds_Trd = dtCancel ) then
      VatAmt := Abs(Common.CashRcp.VatAmt)
    else if (Common.CashRcp.Ds_Trd = dtApproval) and not visTax then
    begin
      if (Common.PreSent.TaxAmt > 0) then
      begin
        if Approval and (Common.PreSent.RcvAmt = 0) and (SaleAmt = Common.PreSent.WRcvAmt) then
          VatAmt := Common.PreSent.TaxAmt
       else
         VatAmt := FtoI(hTrunc( SaleAmt / 11 ,1));
      end
      else
        VatAmt := 0;
    end;

    Approval   := CashRcp.Ds_trd     = dtApproval;
    WorkDate    := Common.WorkDate;
    SaleDate    := FormatDateTime('yyyymmdd',Now());

    //취소 시 다중사업자를 사용하면 해당 밴정보를 가져온다
    if not Approval and (GetOption(60) = '1') then
    begin
      vIndex := Common.GetCornerIndex('',Common.CashRcp.VanTID);
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
      //다중사업자를 사용할때 금액이 있는 사업자를 찾는다
    else if (GetOption(60) = '1') and (Common.GetCorner >= 0) then
    begin
      vIndex := Common.GetCorner;
      Common.Config.van_Terid := Common.Corner[vIndex].VanTid;
      Common.Config.SerialNo  := Common.Corner[vIndex].VanSerial;
      Common.Config.BizNo     := GetOnlyNumber(Common.Corner[vIndex].BizNo);
      Common.CashRcp.Corner      := Common.Corner[vIndex].Code;

      TerminalID := Common.Config.van_Terid;
      SerialNo   := Common.Config.SerialNo;
      BizNo      := Common.Config.BizNo;
      SaleAmt    := FtoI(ApprovalAmtEdit.Value);
    end
    else
    begin
      TerminalID := Common.Config.van_Terid;
      BizNo      := GetOnlyNumber(Common.Config.BizNo);
      SerialNo   := Common.Config.SerialNo;
      SaleAmt    := FtoI(ApprovalAmtEdit.Value);
    end;


    Host        := Config.van_ip;
    Port        := Config.van_port;
    LogPath     := Common.AppPath;
    PosNo       := Config.PosNo;
    Parent      := Self;
    if Common.Config.ReceiptPrinterBaudRate >=0 then
      CatBaudRate   := BAUDRATE[Common.Config.ReceiptPrinterBaudRate]
    else
      CatBaudRate   := 9600;
    CatPort    := StoI(Common.Config.ReceiptPrinterPort);
    RealMode   := True;

    //단말기연동
    if (GetOption(379) = '1') and ((Trim(NumberEdit.Text) = '') or (VAN in [vtKOVAN,vtKIS,vtKFTC,vtJTNET])) then
      AppType := atCatCash
    else if (GetOption(379) = '2') and ((Trim(NumberEdit.Text) = '') or (VAN in [vtKSNET,vtKOCES,vtKOVAN,vtNICE,vtKCP,vtSmartro,vtDaou,vtJTNET,vtKIS,vtFDIK,vtKFTC])) then
      AppType := atVCatCash
    else
      AppType    := atCash;

    if Trim(NumberEdit.Text) = EmptyStr then
      CashRcp.Ds_Input  := 'S';

    KeyIn      := CashRcp.Ds_Input   = 'K';
    if VAN = vtKCP then
      KeyIn := True;
    // 자동발급이 아니면
    if CashRcp.Ds_Kind <> '2' then
    begin
      if PersonButton.Appearance.SimpleLayout then CashRcp.Ds_Kind := '0'
      else                                         CashRcp.Ds_Kind := '1';
    end;

    HalbuMonth := StoI(CashRcp.Ds_Kind);
    if (VAN <> vtDaou) and (CashRcp.Ds_Kind = '2') then
      HalbuMonth := 0;

    CardTrack2 := Common.CashRcp.CardNoFull;
    if isPinPad then
      CardTrack2 := 'PinPad';

    if not Approval then
    begin
      OrgAgreeNo    := Common.CashRcp.No_Approval;
      OrgSaleDate   := Common.CashRcp.trd_date;

      //스마트로 IC 보안은 제외
      if  (VAN <> vtSmartro) and (CardTrack2 <> GetOnlyNumber(CardTrack2)) and not isPinPad then
        CardTrack2 := EmptyStr;
    end
    else
    begin
      OrgAgreeNo    := '';
      OrgSaleDate   := '';
    end;

    //KCP는 번호만 받는다
    if VAN = vtKCP then
      CardTrack2 := CtoC(NumberEdit.Text,'-','');

    if GetOption(379) = '1' then
    begin
      Common.Device.SetPrintPort(false);
      Common.HideWaitForm;
      if VAN = vtNice then
        Common.ShowWaitForm('단말기에 IC 카드를 넣어 주세요...',True)
      else
        Common.ShowWaitForm('단말기에서 승인 중 입니다....'#13'(단말기 종료버튼을 누르면 취소됩니다)');
      Common.WriteLog('work', Format('[현금]승인요청 - %d',[Common.ICCard.SaleAmt]));
    end;

    vKeyInData := NumberEdit.Text;
    Common.ICCard.MultiVan   := GetOption(60) = '1';

    if not Execute then
    begin
      //다우 VCAT일때
      if (GetOption(379) = '2') and (VAN = vtDaou) then
        Sleep(300)
      else if (GetOption(379) = '1') or (GetOption(379) = '2') then
        Sleep(100);

      if AppType = atCatCash then
      begin
        Common.WriteLog('work', Format('[현금]승인실패 - %s',[Common.ICCard.Note]));
        Common.Device.SetPrintPort(true);
        Common.HideWaitForm;
      end;

      if (Common.ICCard.VAN = vtKSNET) and (Trim(Note) = '리더기 오류     미지원 기능') then
      begin
        Common.MsgBox('KSCAT 프로그램을 재시작합니다');
        KillTask('KSCAT.exe');
        ExcuteProgram('C:\KSCAT\KSCAT.exe');
      end;

      if Trim(Note) <> '[]' then
        ErrMsg := Trim(Note)
      else
        ErrMsg := '';
      if not isPinPad and (Trim(ErrMsg) <> '') then
        Common.MsgBox(ErrMsg);

      ErrMsg := Replace(ErrMsg, #13, ' ');
      Result := False;
    end
    else
    begin
      Sleep(100);

      if AppType in [atCatCash, atVCatCash] then
      begin
        Common.WriteLog('work', Format('[현금]정상승인 - 카드번호[%s]승인번호[%s]승인금액[%d]',[Common.ICCard.CardNo, Common.ICCard.AgreeNo, Common.ICCard.AgreeAmt]));
        if vKeyInData = '' then
          NumberEdit.Text  := Common.ICCard.CardNo;

        if (CardTrack2 = EmptyStr) and (Common.ICCard.CardNo <> GetOnlyNumber(NumberEdit.Text)) then
          CashRcp.Ds_Input := 'S'
        else
          CashRcp.Ds_Input := 'K';

        if (Common.Config.van_trd in [vanFDIK,vanKCP]) and (Common.ICCard.CardNo = '') then
        begin
          NumberEdit.Text      := CardTrack2;
          NumberSplit;
          Common.ICCard.CardNo := CardTrack2;
        end;

        if not (Common.Config.van_trd in [vanJTNET, vanFDIK, vanKCP, vanDaou, vanKFTC]) then
          NumberSplit;

        Common.Device.SetPrintPort(true);
        Common.HideWaitForm;
      end
      else if GetOption(379) = '1' then
      begin
        Common.Device.SetPrintPort(true);
        Common.HideWaitForm;
      end;

        if vKeyInData <> '' then
        CashRcp.CardNo        := GetOnlyNumber(NumberEdit.Text)
      else
        CashRcp.CardNo      := CardNo;
      CashRcp.No_Approval   := AgreeNo;        // 승인번호
      CashRcp.Amt_Approval  := AgreeAmt;       // 승인금액
      CashRcp.trd_date      := SaleDate;
      CashRcp.trd_date_org  := OrgSaleDate;
      CashRcp.Approval_org  := OrgAgreeNo;
      CashRcp.VatAmt        := VatAmt;
      CashRcp.Yn_Cat        := YnCat;
      ErrMsg                := Note;
      Result := True;
    end;
    if ((GetOption(379)='0')) and (VAN = vtKFTC) then
    begin
      Common.ICCard.AppType := atOnlyICInit;
      Common.ICCard.Execute;
    end;
  end;
end;

procedure TCashRcp_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case Key of
     VK_F10  :  if (ActiveControl is TCustomEdit) then TCustomEdit(ActiveControl).Clear;
     VK_F11  :  ApprovalAmtEdit.Properties.ReadOnly := False; //KSNET 처음거래시 1234원으로 승인을 해야하기때문
     27      :  CloseButtonClick(nil);
   end;
end;

procedure TCashRcp_F.NumberEditExit(Sender: TObject);
begin
  if (ToggleSwitch.State = tssOn) and (Sender = NumberEdit) then
  begin
    if (Length(NumberEdit.Text) > 16) then
    begin
      SetMsrData;
      Common.CashRcp.Ds_Input   := 'S';
      NumberSplit;
    end
    else if (Common.CashRcp.Ds_Input = 'K') or (NumberEdit.Text <> '') then
    begin
      Common.CashRcp.Ds_Input   := 'K';
      NumberEdit.Text           := GetOnlyNumber(NumberEdit.Text);
      Common.CashRcp.CardNoFull := NumberEdit.Text;
      Common.CashRcp.CardNo     := NumberEdit.Text;
      NumberSplit;
    end;
  end;
end;


procedure TCashRcp_F.NumberEditKeyPress(Sender: TObject; var Key: Char);
var vNumber : String;
begin
  if not ApprovalAmtEdit.Enabled and (Key = #13) then
    ApprovalButtonClick(nil)
  else if Key in ['0','1','2','3','4','5','6','7','8','9'] then
  begin
    vNumber := GetOnlyNumber(NumberEdit.Text);
    if Length(vNumber) < 12 then
    begin
      NumberEdit.Style.Font.Size := 18;
      case Length(vNumber) of
        3 : NumberEdit.Text  := vNumber+'-';
        4 : NumberEdit.Text  := Format('%s-%s',[LeftStr(vNumber,3),RightStr(vNumber,1)]);
        5 : NumberEdit.Text  := Format('%s-%s',[LeftStr(vNumber,3),RightStr(vNumber,2)]);
        6 : NumberEdit.Text  := Format('%s-%s',[LeftStr(vNumber,3),RightStr(vNumber,3)]);
        7 : NumberEdit.Text  := Format('%s-%s-',[LeftStr(vNumber,3),RightStr(vNumber,4)]);
        8 : NumberEdit.Text  := Format('%s-%s-%s',[LeftStr(vNumber,3),Copy(vNumber,4,4),RightStr(vNumber,1)]);
        9 : NumberEdit.Text  := Format('%s-%s-%s',[LeftStr(vNumber,3),Copy(vNumber,4,4),RightStr(vNumber,2)]);
        10 :
        begin
          if BizButton.Appearance.SimpleLayout  then
            NumberEdit.Text := Format('%s-%s-%s',[LeftStr(vNumber,3),Copy(vNumber,4,2),RightStr(vNumber,5)])    //사업자번호
          else
            NumberEdit.Text := Format('%s-%s-%s',[LeftStr(vNumber,3),Copy(vNumber,4,4),RightStr(vNumber,3)]);
        end;
        11 : NumberEdit.Text := Format('%s-%s-%s',[LeftStr(vNumber,3),Copy(vNumber,4,4),RightStr(vNumber,4)]);    //전화번호
      end;
      NumberEdit.SelStart := Length(NumberEdit.Text)+1;
    end
    else
    begin
      NumberEdit.Style.Font.Size := 15;
    end;
  end;
end;

procedure TCashRcp_F.NumberSplit;
begin
  NumberEdit.Text := GetOnlyNumber(NumberEdit.Text);
  case Length(NumberEdit.Text) of
    10 :
    begin
      if PersonButton.Appearance.SimpleLayout then
      begin
        NumberEdit.Text := FormatMaskText('!000-000-0000;0;', NumberEdit.Text);
        Common.CashRcp.Ds_Type := '1';
      end
      else
      begin
        if Copy(NumberEdit.Text,1,1) <> '0' then
        begin
          NumberEdit.Text := FormatMaskText('!000-00-00000;0;', NumberEdit.Text);
          Common.CashRcp.Ds_Type := '3';
        end
        else
        begin
          NumberEdit.Text := FormatMaskText('!000-000-0000;0;', NumberEdit.Text);
          Common.CashRcp.Ds_Type := '1';
        end;
      end;
    end;
    11 :
    begin
      NumberEdit.Text := FormatMaskText('!000-0000-0000;0;', NumberEdit.Text);
      Common.CashRcp.Ds_Type := '1';
    end;
    13 :
    begin
      NumberEdit.Text := FormatMaskText('!000000-0000000;0;', NumberEdit.Text);
      Common.CashRcp.Ds_Type := '2';
    end;
    16 :
    begin
      NumberEdit.Text := FormatMaskText('!0000-0000-0000-0000;0;', NumberEdit.Text);
      Common.CashRcp.Ds_Type := '0';
    end;
    18 :
    begin
      NumberEdit.Text := FormatMaskText('!0000-0000-0000-000000;0;', NumberEdit.Text);
      Common.CashRcp.Ds_Type := '0';
    end;
    else Common.CashRcp.Ds_Type := '0';
  end;

  if LeftStr(NumberEdit.Text,3) = '010' then
    Common.CashRcp.Ds_Type := '1';
end;

procedure TCashRcp_F.Num_010Click(Sender: TObject);
begin
  NumberEdit.Text := '010-';
  NumberEdit.SelStart := 5;
end;

procedure TCashRcp_F.NumberEditEnter(Sender: TObject);
begin
  if ToggleSwitch.State = tssOn then
    Common.CashRcp.Ds_Input   := 'S';
end;

procedure TCashRcp_F.PersonButtonClick(Sender: TObject);
begin
  if Sender = PersonButton then
  begin
    PersonButton.Appearance.SimpleLayout := true;
    PersonButton.Status.Visible          := true;
    BizButton.Appearance.SimpleLayout    := false;
    BizButton.Status.Visible             := false;
    PersonButton.Color := $00DF7000;
    BizButton.Color  := $00793D00;
  end
  else
  begin
    PersonButton.Appearance.SimpleLayout := false;
    PersonButton.Status.Visible          := false;
    BizButton.Appearance.SimpleLayout    := true;
    BizButton.Status.Visible             := true;
    PersonButton.Color := $00793D00;
    BizButton.Color  := $00DF7000;
  end;
  NumberEdit.SetFocus;
end;

procedure TCashRcp_F.PinPadButtonClick(Sender: TObject);
begin
  if MilliSecondsBetween(Now(),ClickTime) < 1500 then Exit;
  ClickTime := Now;
  try
    PinPadButton.Enabled := false;
    Common.WriteLog('work', '현금영수증 고객입력');
    if Common.Config.SmartPad then
    begin
      Common.PadWaitForm('고객이 식별번호를 입력 중 입니다...',
                         #2+'keypad'
                        +#2+'2'
                        +#2+'0'
                        +#2+'식별번호를 입력해주세요'
                        +#2+'0'
                        +#2+'60');
      Exit;
    end;
    //가상단말기
    if (GetOption(379) = '2') and (Common.Config.van_trd in [vanJTNET,vanNICE,vanDaou,vanKICC, vanKSNET, vanSmartro, vanKOVAN, vanKCP, vanKOCES, vanFDIK]) then
    begin
      isPinPad := true;
      ClickTime         := IncSecond(Now,-3);
      ApprovalButtonClick(ApprovalButton);
      isPinPad := false;
    end;
  finally
    PinPadButton.Enabled := true;
  end;
end;

procedure TCashRcp_F.ReceiveAmtEditExit(Sender: TObject);
begin
  ReceiveAmtEdit.PostEditValue;
  //받을금액이 승인금액보다 작을때
  if (ReceiveAmtEdit.Value+GetGiftAmt) < ApprovalAmtEdit.Value then
    ApprovalAmtEdit.Value := ReceiveAmtEdit.Value
  else if (ReceiveAmtEdit.Value > ApprovalAmtEdit.Value) and (ApprovalAmtEdit.Value = 0) then
    ApprovalAmtEdit.Value := ReceiveAmtEdit.Value;
  ReceiveAmtEdit.EditModified := false;
end;

procedure TCashRcp_F.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  if Timer1.Tag = 0 then
  begin
    NumberEdit.Text := '0100001234';
    Common.CashRcp.Ds_Input := 'K';
  end
  else Timer1.Tag := 1;
  ApprovalButtonClick(nil);
end;

procedure TCashRcp_F.ApprovalAmtEditExit(Sender: TObject);
begin
  ApprovalAmtEdit.PostEditValue;
  if ApprovalAmtEdit.Value > (ReceiveAmtEdit.Value+GetGiftAmt) then
    ReceiveAmtEdit.Value := ApprovalAmtEdit.Value;
  ApprovalAmtEdit.EditModified := false;
end;

procedure TCashRcp_F.ApprovalAmtEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    ApprovalButtonClick(nil);
end;

procedure TCashRcp_F.ApprovalAmtEditPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  if DisplayValue > (Sender as TcxCurrencyEdit).Properties.MaxValue then
  begin
    Common.ErrBox(Format('최대금액은 %s원 입니다',[FormatFloat(',0',(Sender as TcxCurrencyEdit).Properties.MaxValue)]));
    DisplayValue := (Sender as TcxCurrencyEdit).Properties.MaxValue;
    Error        := false;
    (Sender as TcxCurrencyEdit).SetFocus;
  end
  else if DisplayValue < (Sender as TcxCurrencyEdit).Properties.MinValue then
  begin
    Common.ErrBox(Format('최소금액은 %s원 입니다',[FormatFloat(',0',(Sender as TcxCurrencyEdit).Properties.MinValue)]));
    DisplayValue := (Sender as TcxCurrencyEdit).Properties.MinValue;
    Error        := false;
    (Sender as TcxCurrencyEdit).SetFocus;
  end;
end;

procedure TCashRcp_F.ApprovalButtonClick(Sender: TObject);
var vError :Boolean;
    vIndex  :Integer;
begin
  if not isPinPad and (MilliSecondsBetween(Now(),ClickTime) < 1500) then Exit;
  ClickTime := Now;

  try
    MainGroupBox.Top  := 0;
    MainGroupBox.Left := 0;

    if NumberEdit.Focused then
      NumberEditExit(NumberEdit);

    if ReceiveAmtEdit.EditModified then
      ReceiveAmtEditExit(nil);

    if ApprovalAmtEdit.EditModified then
      ApprovalAmtEditExit(nil);

    ReceiveAmtEdit.Properties.ReadOnly := true;
    Common.WriteLog('work', '현금영수증승인['+FormatFloat('#,0',ApprovalAmtEdit.Value)+']');
    edtTemp.SetFocus;
    if ApprovalAmtEdit.Value = 0 then
    begin
      Common.ErrBox('승인금액이 없습니다');
      Exit;
    end;

    if NumberEdit.Focused then NumberEditExit(NumberEdit);
    NumberSplit;
    Common.CashRcp.CardNoFull := GetOnlyNumber(NumberEdit.Text);

    //인터넷승인
    if ToggleSwitch.State = tssOff then
    begin
      ApprovalButton.Enabled := False;
      MessageLabel.Caption := Common.GetPaPago('승인요청 중 입니다 ... ');
      Application.ProcessMessages;

      if ApprovalAction then
      begin
        Common.WriteLog('work', '정상승인완료');

        Common.HideWaitForm;
        if Common.CashRcp.Ds_Trd = dtApproval then
        begin
          Common.CashRcp.Amt_Approval := FtoI(ApprovalAmtEdit.Value);
          Common.CashRcp.VatAmt       := FtoI(Common.CashRcp.VatAmt);
          Common.CashRcp.RcvAmt       := ReceiveAmtEdit.EditValue;
        end
        else
        begin
          Common.CashRcp.Amt_Approval := FtoI(ApprovalAmtEdit.Value);
          Common.CashRcp.VatAmt       := FtoI(Common.CashRcp.VatAmt);
        end;
        if Common.Table.AHeadPay then
          Common.CashRcpInfoSave;
        ModalResult := mrOK
      end
      else
      begin
        NumberEdit.SetFocus;
        MessageLabel.Caption               := ErrMsg;
        Common.WriteLog('work', Format('Error:%s',[ErrMsg]));
      end;
      ApprovalButton.Enabled         := True;
      Common.HideWaitForm;
    end
    //단말기승인입력
    else
    begin
      Common.CashRcp.Ds_Input := 'O';
      Common.WriteLog('work', '단말기승인');

      if ApprovalAmtEdit.Value  <= 0 then
      begin
        MessageLabel.Caption := Common.GetPaPago('승인금액이 없습니다');
        Exit;
      end;
      Common.CashRcp.Ds_Input    := 'O';
      Common.CashRcp.CardNo      := GetOnlyNumber(NumberEdit.Text);
      Common.CashRcp.Amt_Approval:= FtoI(ApprovalAmtEdit.Value);
      Common.CashRcp.Corner      := '000000';

      //합계금액과 받을금액이 같으면서 승인금액도 같을때
      if (Common.CashRcp.Ds_Trd = dtCancel ) and (Common.PreSent.RcvAmt = 0)
       and ((Common.PreSent.TotalAmt+Ifthen(GetOption(160)='0', Common.PreSent.TipAmt, 0) - Common.PreSent.TotalDc) = Common.PreSent.WRcvAmt) then
      begin
        Common.CashRcp.VatAmt := Abs(Common.PreSent.TaxAmt);
      end
      else if Common.CashRcp.Ds_Trd = dtApproval then
      begin
        if Common.PreSent.TaxAmt > 0  then
          Common.CashRcp.VatAmt := FtoI(hTrunc( ApprovalAmtEdit.Value / 11 ,1))
        else
          Common.CashRcp.VatAmt := 0;
      end;

      if Common.CashRcp.Ds_Trd = dtApproval then
      begin
        Common.CashRcp.Amt_Approval := FtoI(ApprovalAmtEdit.Value);
        Common.CashRcp.VatAmt       := FtoI(Common.CashRcp.VatAmt);
        Common.CashRcp.RcvAmt       := ReceiveAmtEdit.EditValue;
      end
      else
      begin
        Common.CashRcp.Amt_Approval := FtoI(ApprovalAmtEdit.Value);
        Common.CashRcp.VatAmt       := FtoI(Common.CashRcp.VatAmt);
      end;
//      Common.CashRcpInfoSave;
      ModalResult := mrOK;
    end;
  finally
    ReceiveAmtEdit.Properties.ReadOnly := false;
    Tmr_Enabled.Enabled := true;
  end;
end;


procedure TCashRcp_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TCashRcp_F.fmKeyPad1Num_BSClick(Sender: TObject);
begin
  NumberEdit.Properties.OnChange := nil;
  Keybd_Event(VK_BACK,VK_BACK, 0, 0);
  Tmr_Event.Enabled := true;
end;

procedure TCashRcp_F.Tmr_ApprovalTimer(Sender: TObject);
begin
  Tmr_Approval.Enabled := False;
  NumberEdit.SetFocus;
  ApprovalButtonClick(nil);
end;

procedure TCashRcp_F.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FDecryptData  :=#12;
  FEmvCardData  :=#12;
  FDecryptData  :=#3;
  FEmvCardData  :=#3;
  FDecryptData  :=EmptyStr;
  FEmvCardData  :=EmptyStr;
  Common.ICCard.ClearAll;
end;

procedure TCashRcp_F.Tmr_EnabledTimer(Sender: TObject);
begin
  Tmr_Enabled.Enabled := false;
  MainGroupBox.Left := -1000;
end;

procedure TCashRcp_F.Tmr_KeyinTimer(Sender: TObject);
begin
  Tmr_Keyin.Enabled := false;
  PinPadButtonClick(nil);
end;

procedure TCashRcp_F.ToggleSwitchClick(Sender: TObject);
begin
  //승인방법이 바뀔때는 식별번호와 Cashbag번호를 클리어한다
  if Common.CashRcp.Ds_Trd = dtApproval then
  begin
    Common.CashRcp.CardNo        := EmptyStr;
    Common.CashRcp.CardNoFull    := EmptyStr;
    NumberEdit.Clear;
  end;

  MessageLabel.Caption := EmptyStr;
  if ToggleSwitch.State = tssOff then
  begin
    Common.CashRcp.Ds_Input       := 'S';
    ApprovalButton.Status.Caption := '';
    MessageLabel.Caption          := '';
    PinPadButton.Enabled          := true;
  end
  else
  begin
    Common.CashRcp.Ds_Input       := 'O';
    ApprovalButton.Status.Caption := '외부승인 등록';
    PinPadButton.Enabled          := false;
    if Common.CashRcp.Ds_Trd = dtApproval then
      MessageLabel.Caption := Common.GetPaPago('외부에서 승인된 내역을 입력합니다(실제승인은 안됨)')
    else
      MessageLabel.Caption := Common.GetPaPago('외부 승인으로 승인한 내역 내역입니다');
  end;

  NumberEdit.SetFocus;
end;

end.

