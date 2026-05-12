unit KioskCash_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, AdvSmoothButton, cxLabel, ExtCtrls, jpeg,
  cxTextEdit, cxCurrencyEdit, DateUtils, MMSystem, StdCtrls,
  AdvSmoothToggleButton, dxGDIPlusClasses, cxImage, AdvPanel, StrUtils;

type TCloseMode = (cmClose, cmGetClose, cmPayClose, cmPayError, cmGetError); //입금없이 종료, 입금중, 지급중,  입금중 종료, 지급(거스름돈), 방출중 오류발생시  중 종류

type
  TKioskCash_F = class(TForm)
    EmitTimer: TTimer;
    lblSaleAmt: TcxLabel;
    lblGetAmt: TcxLabel;
    lblWillGetAmt: TcxLabel;
    lblPayStatus: TcxLabel;
    panMsg: TPanel;
    lblMsg1: TcxLabel;
    Shape1: TShape;
    EmitCheckTimer: TTimer;
    CloseTimer: TTimer;
    obtn_PayAmt: TAdvSmoothButton;
    cxImage1: TcxImage;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    CancelButton: TAdvSmoothToggleButton;
    HeaderPanel: TAdvPanel;
    lblTitle: TcxLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EmitTimerTimer(Sender: TObject);
    procedure EmitCheckTimerTimer(Sender: TObject);
    procedure obtn_PayAmtClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseTimerTimer(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
  private
    WillGetAmt,               //받을금액
    ChangeAmt,                //거스름돈
    PayAmt     :Integer;      //거스름돈 지급금액
    EjectAmt,                 //입급취소시 방출금액
    StopGetAmt,
    StopPayAmt :Integer;
    DispenserData :String;
    EmitData : Array[0..100] of Integer;
    EmitIndex : Integer;
    LastDateTime:TDateTime;   // 마지막으로 데이터를 받은 일시
    CloseMode  :TCloseMode;
    CancelMode :Boolean;
    PayCount :Integer;
    ClickTime :TDateTime;
    CancelTryCount :Integer;  //입금취소 요청횟수
    procedure DispenserReadEvent(const S : String);
    procedure CashInput;
    procedure CashEmit(aImitAmt:Integer=0);
    procedure CashInputStop(aWait:Boolean=false);
    procedure CashReceipt;
    procedure DispenderReset;
    procedure CashCancel(aEjectAmt:Integer);
  public
    SaleAmt : Integer;
    GetAmt  : Integer;                   //받은금액
  end;

var
  KioskCash_F: TKioskCash_F;

implementation
uses Common_U, Device_U, GlobalFunc_U, KioskCashReceipt_U, KioskCashReceiptBF_U,
     KioskKeyPad_U, Const_U;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TKioskCash_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,0);
  if Common.Config.BarrierFreeMode = bfWheelChair then
  begin
    Self.Position := poDesigned;
    Self.ClientHeight   := 867;
    Self.ClientWidth    := 1000;
    Self.Top      := Common.Config.BarrierTop;
    Self.Left     := Screen.Width div 2 - Self.ClientWidth div 2;
  end;

  Common.SetButtonColor(obtn_PayAmt);
  Common.SetKioskButton(obtn_PayAmt);
  Common.SetKioskButton(CancelButton);
end;

procedure TKioskCash_F.FormShow(Sender: TObject);
begin
  ClickTime         := IncSecond(Now,-3);
  BlockInput(false);
  CloseMode  := cmClose;
  CancelMode := false;
  Common.Device.OnDispenserReadData :=DispenserReadEvent;
  lblSaleAmt.Caption    := FormatFloat(',0',SaleAmt);
  lblWillGetAmt.Caption := lblSaleAmt.Caption;
  CashInputStop(true);
  PayAmt := 0;
  CashInput;
  EmitCheckTimer.Enabled := true;
  PayCount       := 0;
  CancelTryCount := 0;
end;

procedure TKioskCash_F.DispenserReadEvent(const S: String);
  //수신값이 한번에 여러건이 들어오는 경우가 있어서 최종것만 사용한다
  function GetReceiveData(aStr:String):String;
  var vIndex :Integer;
      vPos   :Integer;
  begin
    vPos := 1;
    for vIndex := 1 to Length(aStr) do
    begin
      if (StringToHex(aStr[vIndex])='13') and (vIndex >=3) and (StringToHex(aStr[vIndex-2])='fe') then
        vPos := vIndex-2;
    end;
    Result := Copy(aStr, vPos, Length(aStr)-vPos);
  end;
var vIndex :Integer;
    vBillCount,
    vCoinCount :Integer;
    vBinStr1, vBinStr2 :String;
    vData :String;
begin
  LastDateTime  := Now;
  DispenserData := S;
  vData         := GetReceiveData(AnsiString(S));
  if (Length(vData) > 3) and (StringToHex(vData[2])='13') then
  begin
    vCoinCount := StrToInt('$'+StringToHex(vData[11]));
    vBillCount := StrToInt('$'+StringToHex(vData[13]));
    //입금작업 모드 EmitTimer.Tag = 0
    if (EmitTimer.Tag = 0) then
    begin
      //일정시간이 지나 취소버튼이 보이는 상태에서 입금했을때
      if obtn_PayAmt.Visible then
        EmitCheckTimer.Enabled := true;
      obtn_PayAmt.Visible := false;

      //응답값에 Error 값이 있는지 체크한다
      vBinStr1 := HexToBin2(StringToHex(vData[3]));
      if (Copy(vBinStr1,3,2) <> '00')  then
      begin
        panMsg.Visible := true;
        lblMsg1.Caption  := '지폐 투입기 오류!!! 관리자에게 연락하세요!!! ';
        CloseMode       := cmGetError;
        Common.SetPNGImage(obtn_PayAmt, Common.AppPath+'\Kiosk\거스름돈지급.png');
        obtn_PayAmt.Visible := true;
        CashInputStop;
        Common.MsgBox('지폐 투입기 오류!!!'+#13+'관리자에게 연락하세요!!!',0);
      end;
//      GetAmt := Common.KioskCash.inAmount;

      GetAmt := StrToInt('$'+StringToHex(vData[5])) * 100;
      GetAmt := GetAmt + StrToInt('$'+StringToHex(vData[6])) * 500;
      GetAmt := GetAmt + StrToInt('$'+StringToHex(vData[7])) * 1000;
      GetAmt := GetAmt + StrToInt('$'+StringToHex(vData[8])) * 5000;
      GetAmt := GetAmt + StrToInt('$'+StringToHex(vData[9])) * 10000;
      GetAmt := GetAmt + StrToInt('$'+StringToHex(vData[10])) * 50000;


      ChangeAmt  := GetAmt - SaleAmt;
      if GetAmt > 0 then
        CancelButton.Visible := false;

      if ((GetAmt > SaleAmt) or (GetAmt = SaleAmt)) and (ChangeAmt = 0) then
      begin
        CashInputStop;  //입금중지
        lblGetAmt.Caption      := FormatFloat(',0',GetAmt);         //입금금액
        lblWillGetAmt.Caption := '0';
        EmitCheckTimer.Enabled := false;
        CashReceipt;
        Exit;
      end;
    end
    else if  (EmitTimer.Tag = 2) or (vCoinCount+vBillCount > 0)  then
    begin
      //응답값에 Error 값이 있는지 체크한다
      vBinStr1 := HexToBin2(StringToHex(vData[3]));
      vBinStr2 := HexToBin2(StringToHex(vData[4]));
      if (Copy(vBinStr1,2,1) = '1')  then
      begin
        panMsg.Visible := true;
        lblMsg1.Caption := '동전 지급기 오류!!! 관리자에게 연락하세요!!!';
        CloseMode       := cmPayError;
        Common.SetPNGImage(obtn_PayAmt, Common.AppPath+'\Kiosk\거스름돈지급.png');
        obtn_PayAmt.Visible := true;
        Common.MsgBox('동전 지급기 오류!!!'+#13+'관리자에게 연락하세요!!!',0);
      end
      //지폐 지급중에 에러만 체크한다(2022.4.19)
      else if (vBillCount < (ChangeAmt div 1000)) and (Copy(vBinStr2,8,1) = '1') then
      begin
        panMsg.Visible := true;
        lblMsg1.Caption := '지폐 지급기 오류!!! 관리자에게 연락하세요!!!';
        CloseMode       := cmPayError;
        Common.SetPNGImage(obtn_PayAmt, Common.AppPath+'\Kiosk\거스름돈지급.png');
        obtn_PayAmt.Visible := true;
        Common.MsgBox('지폐 지급기 오류!!!'+#13+'관리자에게 연락하세요!!!',0);
      end;
//      PayAmt := Common.KioskCash.outAmount;

      EmitData[EmitIndex] := StrToInt('$'+StringToHex(vData[11])) * 100;
      EmitData[EmitIndex] := EmitData[EmitIndex] + StrToInt('$'+StringToHex(vData[13])) * 1000;
      PayAmt := 0;
      for vIndex := 0 to High(EmitData) do
        PayAmt := PayAmt + EmitData[vIndex];

      if not CancelMode then
      begin
        if ChangeAmt = PayAmt then
        begin
          if ChangeAmt > 0 then
          begin
            lblPayStatus.Visible  := true;
            lblPayStatus.Caption  := Format('%s / %s [거스름돈]',[FormatFloat(',0',PayAmt), FormatFloat(',0',ChangeAmt)]);
          end;
          EmitCheckTimer.Enabled := false;
          lblWillGetAmt.Caption := '0';
          CashReceipt;
          Exit;
        end;
      end
      else
      begin
        if GetAmt = PayAmt then
        begin
          lblPayStatus.Visible  := true;
          lblPayStatus.Caption  := Format('%s / %s [반환금액]',[FormatFloat(',0',PayAmt), FormatFloat(',0',GetAmt)]);
          EmitCheckTimer.Enabled := false;
          lblWillGetAmt.Caption := '0';
          Close;
          Exit;
        end;
        lblPayStatus.Visible  := true;
        lblPayStatus.Caption  := Format('%s / %s [반환금액]',[FormatFloat(',0',PayAmt), FormatFloat(',0',GetAmt)]);
      end;
    end;

    if not CancelMode then
    begin
      ChangeAmt  := GetAmt - SaleAmt;
      lblGetAmt.Caption     := FormatFloat(',0',GetAmt);         //입금금액
      if SaleAmt-GetAmt > 0 then
        lblWillGetAmt.Caption := FormatFloat(',0',SaleAmt-GetAmt) //남은금액
      else
        lblWillGetAmt.Caption := '0';

      if ChangeAmt > 0 then
      begin
        obtn_PayAmt.Caption := '거스름돈 지급';
        obtn_PayAmt.Visible := true;

        lblPayStatus.Visible  := true;
        lblPayStatus.Caption  := Format('%s / %s [거스름돈]',[FormatFloat(',0',PayAmt), FormatFloat(',0',ChangeAmt)]);
      end
      else if GetAmt > 0 then
      begin
        obtn_PayAmt.Caption := '입금취소';
        obtn_PayAmt.Visible := true;
      end;

      if (EmitTimer.Tag = 0) and (GetAmt > 0) and (GetAmt >= SaleAmt) then
      begin
        EmitCheckTimer.Enabled := false;
        EmitTimer.Tag     := 1;
        EmitTimer.Enabled := true;
      end;
    end;
  end;
  DispenserData := S;
end;

procedure TKioskCash_F.CashInput;
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
begin
  InitKioskCashRecord(Common.KioskCash);
  DispenserData := EmptyStr;
  for vIndex := 0 to High(EmitData) do
    EmitData[vIndex] := 0;
  EmitIndex := 0;
  //지폐만 투입(투입, 방출 클리어)
//  vTemp := AnsiString(#$10#$09#$00#$00#$00#$00#$00#$00#$00#$00#$00);    //1,4 => 1001 => 09
  //동전도 투입
  vTemp := AnsiString(#$10#$0d#$00#$00#$00#$00#$00#$00#$00#$00#$00);  //1,2,4 => 1101 =>13
  vTemp := AnsiChar(#$fe) +AnsiChar(Length(vTemp)+2)+vTemp;
  vFCC := Byte(vTemp[1]);
  for vIndex := 2 to Length(vTemp) do
    vFCC := vFCC xor Byte(vTemp[vIndex]);
  vTemp := vTemp + AnsiChar(vFCC);
  Common.Device.SendToDispenser(vTemp);
  EmitTimer.Tag := 0;
  vGetTime := GetTickCount;
  while (DispenserData = EmptyStr) and (vGetTime + 1000 > GetTickCount) do
    Application.ProcessMessages;

  if DispenserData = EmptyStr then
  begin
    CashInputStop;
    panMsg.Visible     := true;
    CancelButton.Visible := true;
    lblMsg1.Caption    := '죄송합니다(장비에서 응답없음) 관리자에게 문의하세요';
    Exit;
  end;

  PlaySound(nil, 0, SND_MEMORY or SND_ASYNC);
  PlaySound(PChar('kioskwave6'), Common.DllHandle, SND_RESOURCE or SND_ASYNC);
end;

procedure TKioskCash_F.CashInputStop(aWait:Boolean);
var vTemp  :AnsiString;
    vIndex :Integer;
    vFCC: Byte;
    vGetTime :Cardinal;
begin

  DispenserData := EmptyStr;
  //입금중지
  vTemp := AnsiString(#$10#$08#$00#$00#$00#$00#$00#$00#$00#$00#$00);
  vTemp := AnsiChar(#$fe) +AnsiChar(Length(vTemp)+2)+vTemp;
  vFCC := Byte(vTemp[1]);
  for vIndex := 2 to Length(vTemp) do
    vFCC := vFCC xor Byte(vTemp[vIndex]);
  vTemp := vTemp + AnsiChar(vFCC);
  Common.Device.SendToDispenser(vTemp);
  if aWait then
  begin
    vGetTime := GetTickCount;
    while (DispenserData = EmptyStr) and (vGetTime + 3000 > GetTickCount) do
      Application.ProcessMessages;
  end;
end;

procedure TKioskCash_F.CancelButtonClick(Sender: TObject);
begin
  if not Common.AskBox('현금입금을 취소하시겠스니까?') then Exit;
  if GetAmt > 0 then Exit;
  Close;
end;

procedure TKioskCash_F.CashEmit(aImitAmt:Integer);
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
    vBillCount,
    vCoinCount :Integer;
begin
  panMsg.Visible := false;
  if aImitAmt = 0 then
  begin
    if ChangeAmt = PayAmt then
    begin
      Common.MsgBox('지급 할 금액이 없습니다');
      Exit;
    end;

    vBillCount := (ChangeAmt - PayAmt) div 1000;
    vCoinCount := (ChangeAmt - PayAmt) mod 1000 div 100;
//    vCoinCount := ((ChangeAmt - PayAmt) - (vBillCount * 1000)) div 100;
  end
  else
  begin
    vBillCount := aImitAmt div 1000;
    vCoinCount := (aImitAmt - (vBillCount * 1000)) div 100;
  end;
  if (vBillCount < 0) or (vCoinCount < 0) then Exit;
  EmitIndex := EmitIndex + 1;

  //방출 중에 에러가 난상태에서 다시 방출할때
  if EmitIndex > 1 then
  begin
    Sleep(1000);
    Common.WriteLog('work', Format('거스름돈 지급 중 에러 % 초기화',[Ifthen(vBillCount > 0, 'BD1','HP1')]));

    DispenserData := EmptyStr;
    //초기화(동전/지폐)
    EmitTimer.Tag     := 3;
    //지페가 남았으면
    if vBillCount > 0 then
      vTemp := AnsiString(#$10#$00#$01#$00#$00#$00#$00#$00#$00#$00#$00)            //HP1 리셋
    else
      vTemp := AnsiString(#$10#$00#$02#$00#$00#$00#$00#$00#$00#$00#$00);           //BD1 리셋
    vTemp := AnsiChar(#$fe) +AnsiChar(Length(vTemp)+2)+vTemp;
    vFCC := Byte(vTemp[1]);
    for vIndex := 2 to Length(vTemp) do
      vFCC := vFCC xor Byte(vTemp[vIndex]);
    vTemp := vTemp + AnsiChar(vFCC);
    EmitCheckTimer.Enabled := false;
    panMsg.Visible     := true;
    lblMsg1.Caption    := '장비를 초기화 합니다 잠시만 기다려 주세요...';

    Common.Device.SendToDispenser(vTemp);
    vGetTime := GetTickCount;
    while (vGetTime + 5000 > GetTickCount) do
      Application.ProcessMessages;
    EmitCheckTimer.Enabled := true;
    panMsg.Visible := false;
  end;

  EmitTimer.Tag     := 2;
  DispenserData := EmptyStr;
  //방출
  Common.WriteLog('work', Format('거스름돈 지급 B-%d, C-%d',[vBillCount,vCoinCount]));

  vTemp := AnsiString(#$12+AnsiChar(vCoinCount)+#$00+AnsiChar(vBillCount)+#$00#$00#$00#$00#$00#$00#$00);
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
    panMsg.Visible     := true;
    lblMsg1.Caption    := '죄송합니다(장비에서 응답없음) 관리자에게 문의하세요';
    Common.KakaoSendMessage('K',['잔돈지급기 동작오류'+#13+
                            '현금입금요청 -장비에서 응답이 없습니다'],'');

    CloseMode       := cmPayError;
    Common.SetPNGImage(obtn_PayAmt, Common.AppPath+'\Kiosk\거스름돈지급.png');
    obtn_PayAmt.Visible := true;
    Common.MsgBox('지폐 지급기 오류!!!'+#13+'관리자에게 연락하세요!!!',0);
  end;
end;

procedure TKioskCash_F.EmitTimerTimer(Sender: TObject);
begin
  EmitTimer.Enabled := false;
  case EmitTimer.Tag of
    1 : begin
          Sleep(10);
          CashInputStop;
          Sleep(10);
          if ChangeAmt > 0 then
          begin
            PlaySound(nil, 0, SND_MEMORY or SND_ASYNC);
            PlaySound(PChar('kioskwave1'), Common.DllHandle, SND_RESOURCE or SND_ASYNC);

            EmitTimer.Tag     := 2;
            EmitTimer.Enabled := true;
          end;
        end;
    2 : begin
          Common.ShowWaitForm('거스름돈을 지급합니다'#13'잠시만 기다리세요');
          CashEmit;
          EmitCheckTimer.Tag     := 0;
          EmitCheckTimer.Enabled := true;
        end;
  end;
end;

procedure TKioskCash_F.CashReceipt;
var vTemp  :AnsiString;
    vIndex :Integer;
    vFCC: Byte;
    vGetTime :Cardinal;
begin
  //잔돈 알람
  if (Common.Config.KioskAlram[0] > 0) or (Common.Config.KioskAlram[1] > 0) then
  begin
    DispenserData := EmptyStr;
    //입금중지
    vTemp := AnsiString(#$10#$08#$00#$00#$00#$00#$00#$00#$00#$00#$00);
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

  if (GetOption(411) = '1') then
  begin
    PlaySound(nil, 0, SND_MEMORY or SND_ASYNC);
    PlaySound(PChar('kioskwave5'), Common.DllHandle, SND_RESOURCE or SND_ASYNC);
  end;

  if (GetOption(411) = '1') and (Common.AskBox('현금영수증을 발급하시겠습니까?',5)) then
  begin
    Common.PreSent.CashAmt := GetAmt;
    if Common.Config.BarrierFreeMode = bfWheelChair then
    begin
      KioskCashReceiptBF_F := TKioskCashReceiptBF_F.Create(Self);
      try
        if KioskCashReceiptBF_F.ShowModal = mrOK then
          ModalResult := mrOK;
      finally
        KioskCashReceiptBF_F.Free;
      end;
    end
    else
    begin
      KioskCashReceipt_F := TKioskCashReceipt_F.Create(Self);
      try
        if KioskCashReceipt_F.ShowModal = mrOK then
          ModalResult := mrOK;
      finally
        KioskCashReceipt_F.Free;
      end;
    end;
  end
  else
  begin
    Common.PreSent.CashAmt := GetAmt;
    ModalResult := mrOK;
  end;
end;

procedure TKioskCash_F.EmitCheckTimerTimer(Sender: TObject);
begin
  //데이터를 받고 있는 상태일때
  if SecondsBetween(Now, LastDateTime) < 3 then Exit;
  //거스름돈이 모두 다 지급되었을때
  EmitCheckTimer.Tag := EmitCheckTimer.Tag + 1;
  if (EmitCheckTimer.Tag > 2) and (ChangeAmt > 0) then
  begin
    Common.HideWaitForm;
    CloseMode := cmPayClose;
    PlaySound(nil, 0, SND_MEMORY or SND_ASYNC);
    PlaySound(PChar('kioskwave2'), Common.DllHandle, SND_RESOURCE or SND_ASYNC);

    EmitCheckTimer.Enabled := false;
    panMsg.Visible      := true;
    lblMsg1.Caption     := '죄송합니다(장비에서 응답없음) 관리자에게 문의하세요 ';
    Common.SetPNGImage(obtn_PayAmt, Common.AppPath+'\Kiosk\거스름돈지급.png');
    obtn_PayAmt.Tag     := 1;
    obtn_PayAmt.Visible := true;
    Common.KakaoSendMessage('K',['거스름돈지급오류'+#13
                            +Format('거스름돈 %d 중 %d 지급',[ChangeAmt, PayAmt])],'');
  end
  else //
  begin
    if SecondsBetween(Now, LastDateTime) < 5 then Exit;
    if GetAmt = 0 then
       Common.SetPNGImage(obtn_PayAmt, Common.AppPath+'\Kiosk\현금결제_취소.png')
    else
      Common.SetPNGImage(obtn_PayAmt, Common.AppPath+'\Kiosk\현금결제_취소.png');

    Common.HideWaitForm;
//    obtn_PayAmt.Visible := true;
//    obtn_PayAmt.Enabled := true;
    //일부금액을 받았을때
    if GetAmt = 0 then
      CloseMode := cmClose
    else if PayAmt = 0 then
      CloseMode := cmGetClose;
  end;
end;

procedure TKioskCash_F.obtn_PayAmtClick(Sender: TObject);
var vGetAmt, vChangeAmt : Integer;
begin
  if MilliSecondsBetween(Now(),ClickTime) < 1500 then Exit;
  ClickTime := Now;
//  BlockInput(true);
  try
    Common.KioskTouchBeep('kioskwave12');
    obtn_PayAmt.Enabled := false;
    case CloseMode of
      cmClose:
      begin
        Common.WriteLog('work', '취소버튼 클릭');
        Common.ShowWaitForm('입금을 취소합니다'#13'잠시만 기다리세요');
        obtn_PayAmt.Visible    := false;
        EmitCheckTimer.Enabled := false;
        CashCancel(GetAmt-PayAmt);
        Exit;
      end;
      cmPayClose : //거스름돈 지급을 다시 시도한다
      begin
        Common.WriteLog('work', '거스름돈지급 버튼 클릭');
        KioskKeyPad_F := TKioskKeyPad_F.Create(Self);
        KioskKeyPad_F.MessageLabel.Caption := '관리자 패스워드를 입력하세요';
        KioskKeyPad_F.isPassword           := true;
        try
          if KioskKeyPad_F.ShowModal <> mrOK then Exit;
          if Common.Config.KioskPwd <> KioskKeyPad_F.KeyInLabel.Hint then
          begin
            obtn_PayAmt.Enabled := true;
            Common.ErrBox('패스워드가 올바르지 않습니다');
            Exit;
          end;
        finally
          KioskKeyPad_F.Free;
        end;

        Common.ShowWaitForm('거스름돈을 지급합니다'#13'잠시만 기다리세요');
        EmitCheckTimer.Enabled := false;
        LastDateTime           := now;
        EmitTimer.Tag          := 0;
        PayCount               := PayCount + 1;
        obtn_PayAmt.Visible    := false;
        CashEmit;
        EmitCheckTimer.Tag     := 0;
        EmitCheckTimer.Enabled := true;
      end;
      cmGetClose :
      begin
        CancelTryCount := CancelTryCount + 1;
        if CancelTryCount > 1 then
        begin
          CancelTryCount := 0;
          CloseMode := cmGetError;
          EmitCheckTimer.Enabled := false;
          panMsg.Visible      := true;
          lblMsg1.Caption     := '죄송합니다(장비에서 응답없음) 관리자에게 문의하세요';
          obtn_PayAmt.Tag     := 1;
          obtn_PayAmt.Enabled := true;
          obtn_PayAmt.Visible := true;
          Common.KakaoSendMessage('K',['잔돈지급기 동작오류'+#13+
                                  '입금취소요청 -장비에서 응답이 없습니다'],'');
          Exit;
        end;
        if Common.AskBox('입금을 취소하시겠습니까?') then
        begin
          obtn_PayAmt.Visible    := false;
          EmitCheckTimer.Enabled := false;
          Common.ShowWaitForm('입금을 취소합니다'#13'잠시만 기다리세요');
          StopGetAmt := GetAmt;
          CloseTimer.Tag      := 3;
          CloseTimer.Enabled  := true;
          Exit;
        end
        else
        begin
          EmitCheckTimer.Tag     := 0;
          obtn_PayAmt.Visible    := true;
          EmitCheckTimer.Enabled := true;
        end;
      end;
      cmGetError :
      begin
        KioskKeyPad_F := TKioskKeyPad_F.Create(Self);
        KioskKeyPad_F.MessageLabel.Caption := '관리자 패스워드를 입력하세요';
        KioskKeyPad_F.isPassword           := true;
        try
          if KioskKeyPad_F.ShowModal <> mrOK then Exit;
          if Common.Config.KioskPwd <> KioskKeyPad_F.KeyInLabel.Hint then
          begin
            obtn_PayAmt.Enabled := true;
            Common.ErrBox('패스워드가 올바르지 않습니다');
            Exit;
          end;
        finally
          KioskKeyPad_F.Free;
        end;
        //방출기를 초기화한다
        DispenderReset;

        if Common.AskBox('입금을 취소하시겠습니까?') then
        begin
          obtn_PayAmt.Visible    := false;
          EmitCheckTimer.Enabled := false;
          CashCancel(GetAmt-PayAmt);
          Exit;
        end
        else
        begin
          EmitCheckTimer.Tag     := 0;
          obtn_PayAmt.Visible    := true;
          EmitCheckTimer.Enabled := true;
        end;
      end;
      cmPayError :
      begin
        Common.WriteLog('work', '거스름돈지급 버튼 클릭');
        KioskKeyPad_F := TKioskKeyPad_F.Create(Self);
        KioskKeyPad_F.MessageLabel.Caption := '관리자 패스워드를 입력하세요';
        KioskKeyPad_F.isPassword           := true;
        try
          if KioskKeyPad_F.ShowModal <> mrOK then Exit;
          if Common.Config.KioskPwd <> KioskKeyPad_F.KeyInLabel.Hint then
          begin
            obtn_PayAmt.Enabled := true;
            Common.ErrBox('패스워드가 올바르지 않습니다');
            Exit;
          end;
        finally
          KioskKeyPad_F.Free;
        end;

        DispenderReset;
        Common.ShowWaitForm('거스름돈을 지급합니다'#13'잠시만 기다리세요');
        EmitCheckTimer.Enabled := false;
        LastDateTime           := now;
        EmitTimer.Tag          := 0;
        PayCount               := PayCount + 1;
        obtn_PayAmt.Visible    := false;
        CashEmit;
        EmitCheckTimer.Tag     := 0;
        EmitCheckTimer.Enabled := true;
      end;
    end;
    obtn_PayAmt.Enabled := true;
  finally
    obtn_PayAmt.Enabled := true;
    BlockInput(false);
  end;
end;

procedure TKioskCash_F.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Common.Device.FDispenserBuff := EmptyStr;
  CloseTimer.Enabled := false;
  if CancelMode then
    Common.HideWaitForm;
end;

procedure TKioskCash_F.DispenderReset;
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
begin
  DispenserData := EmptyStr;
  Common.Device.FDispenserBuff := EmptyStr;
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

procedure TKioskCash_F.CloseTimerTimer(Sender: TObject);
var vGetAmt, vChangeAmt : Integer;
begin
  CloseTimer.Enabled := false;
  case CloseMode of
    cmClose :
    begin
      if (CloseTimer.Tag > 2) or (GetAmt > 0) then
      begin
        Common.HideWaitForm;
        if GetAmt > 0 then
        begin
          CashInput;
          obtn_PayAmt.Visible    := false;
          EmitCheckTimer.Enabled := true;
        end
        else
          Close;
      end
      else
      begin
        CloseTimer.Tag     := CloseTimer.Tag + 1;
        CloseTimer.Enabled := true;
      end;
    end;
    cmGetClose, cmGetError :
    begin
      if (CloseTimer.Tag > 2) then
      begin
        Common.HideWaitForm;
        if StopGetAmt <> GetAmt then
        begin
          CashInput;
          obtn_PayAmt.Visible    := false;
          EmitCheckTimer.Enabled := true;
        end
        else
        begin
          vGetAmt    := GetAmt-PayAmt;
          vChangeAmt := ChangeAmt;
          if (vGetAmt > 0) and (vChangeAmt <> 0) then
          begin
            CashInputStop;
            lblMsg1.Caption := '입금금액을 반환합니다. 잠시만 기다리세요...';
            CancelMode := true;
            CashEmit(vGetAmt);
            LastDateTime := Now();
            EmitCheckTimer.Enabled := true;
          end
          else if obtn_PayAmt.Tag = 0 then
          begin
            CashInputStop;
            Close;
          end
        end;
      end
      else
      begin
        CloseTimer.Tag     := CloseTimer.Tag + 1;
        CloseTimer.Enabled := true;
      end;
    end;
  end;
end;

procedure TKioskCash_F.CashCancel(aEjectAmt: Integer);
begin
  CashInputStop;
  lblMsg1.Caption := '입금금액을 반환합니다. 잠시만 기다리세요...';
  CancelMode := true;
  CashEmit(aEjectAmt);
end;
end.





