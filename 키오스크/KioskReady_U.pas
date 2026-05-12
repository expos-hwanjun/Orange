unit KioskReady_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, KeyPad_F, StdCtrls, cxButtons,
  cxLabel, cxTextEdit, cxCurrencyEdit, cxGroupBox, cxMemo, jpeg, ExtCtrls,
  cxMaskEdit, cxDropDownEdit, cxCalendar, DateUtils, MMSystem, Vcl.ComCtrls,
  dxCore, cxDateUtils, AdvSmoothToggleButton, dxGDIPlusClasses, AdvShape;

type
  TKioskReady_F = class(TForm)
    lbl1000E: TcxLabel;
    lbl100E: TcxLabel;
    lbl1000: TcxLabel;
    lbl100: TcxLabel;
    OpenDate: TcxDateEdit;
    OpenLabel: TcxLabel;
    lblGetAmt: TcxLabel;
    ResetTimer: TTimer;
    KioskReadyGetCountSearchButton: TAdvSmoothToggleButton;
    KioskReadyResetButton: TAdvSmoothToggleButton;
    KioskReadyGetCountInitButton: TAdvSmoothToggleButton;
    KioskReadyBillButton: TAdvSmoothToggleButton;
    KioskReadyCoinButton: TAdvSmoothToggleButton;
    KioskBatchEmitSarchButton: TAdvSmoothToggleButton;
    cxLabel1: TcxLabel;
    AdvShape1: TAdvShape;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    Image4: TImage;
    MessageLabel: TLabel;
    TitleLabel: TLabel;
    cxLabel8: TcxLabel;
    cxLabel9: TcxLabel;
    cxLabel10: TcxLabel;
    cxLabel11: TcxLabel;
    Image1: TImage;
    Image5: TImage;
    Ready1000Button: TAdvSmoothToggleButton;
    Ready100Button: TAdvSmoothToggleButton;
    KioskReadyGiveCountSearchButton: TAdvSmoothToggleButton;
    KioskReadyGiveCountInitButton: TAdvSmoothToggleButton;
    SearchTimer: TTimer;
    CloseButton: TcxButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OpenDatePropertiesPopup(Sender: TObject);
    procedure OpenDatePropertiesCloseUp(Sender: TObject);
    procedure ResetTimerTimer(Sender: TObject);
    procedure KioskReadyGetCountSearchButtonClick(Sender: TObject);
    procedure KioskReadyResetButtonClick(Sender: TObject);
    procedure KioskReadyGetCountInitButtonClick(Sender: TObject);
    procedure KioskReadyBillButtonClick(Sender: TObject);
    procedure KioskReadyCoinButtonClick(Sender: TObject);
    procedure KioskBatchEmitSarchButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure Ready1000ButtonClick(Sender: TObject);
    procedure KioskReadyGiveCountSearchButtonClick(Sender: TObject);
    procedure KioskReadyGiveCountInitButtonClick(Sender: TObject);
    procedure SearchTimerTimer(Sender: TObject);
  private
    CloseSeq :Integer;
    DispenserData :String;
    ClickTime :TDateTime;
    procedure GetReadyAmt;
    procedure GetCount(aType:String);//I:입금, O:방출
    procedure DispenserReadEvent(const S : String);
  public
    { Public declarations }
  end;

var
  KioskReady_F: TKioskReady_F;

implementation
uses Common_U, GlobalFunc_U, Math, DBModule_U, Const_U, KioskKeyPad_U;
{$R *.dfm}
procedure TKioskReady_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
end;

procedure TKioskReady_F.FormShow(Sender: TObject);
begin
  Common.Device.OnDispenserReadData :=DispenserReadEvent;
  ClickTime         := IncSecond(Now,-3);
  //키오스크 개점 자동으로 할때
  Common.KioskAutoOpen;
  
  if Common.WorkDate = '' then
  begin
    OpenDate.Properties.ReadOnly := false;
    OpenLabel.Visible := true;
    OpenDate.Clear;
    Exit;
  end
  else
  begin
    OpenDate.Properties.ReadOnly := true;
    OpenDate.Date := StoD(Common.WorkDate);
    GetReadyAmt;
  end;
end;

procedure TKioskReady_F.CloseButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  if Common.Config.IsKioskCash and ((Common.Config.KioskAlram[0] = 0) or (Common.Config.KioskAlram[1] = 0)) then
  begin
    if not Common.AskBox('준비금 금액이 없습니다'#13'계속하시겠습니까?') then Exit;
  end;
  Close;
end;

procedure TKioskReady_F.DispenserReadEvent(const S: String);
  function FormatLog(S: String): String;
  var vIndex :Integer;
  begin
    Result := EmptyStr;
    for vIndex:=1 to Length(S) div 2 do
      Result := Result + Format('%s ',[Copy(S, vIndex*2-1, 2)]);

    Result := LowerCase(Result);
  end;
  //수신값이 한번에 여러건이 들어오는 경우가 있어서 최종것만 사용한다
  function GetReceiveData(aStr:String):String;
  var vIndex :Integer;
      vPos   :Integer;
  begin
    vPos := 1;
    for vIndex := 1 to Length(aStr) do
    begin
      if ((StringToHex(aStr[vIndex])='16') or (StringToHex(aStr[vIndex])='18')) and (vIndex >=3) and (StringToHex(aStr[vIndex-2])='fe') then
        vPos := vIndex-2;
    end;
    Result := Copy(aStr, vPos, Length(aStr)-vPos);
  end;

var vIndex :Integer;
    vBillCount,
    vCoinCount,
    v10000Count,
    v5000Count,
    v1000Count :Integer;
    vData :AnsiString;
begin
  vData := GetReceiveData(AnsiString(S));
  if (Length(vData) > 3) and (StringToHex(vData[2])='18') then
  begin
    if StringToHex(vData[3]) <> '00' then
    begin
      MessageLabel.Caption := ' 방출기 오류';
    end
    else
    begin
      vBillCount := StrToInt('$'+StringToHex(vData[9])+StringToHex(vData[10]));
      vCoinCount := StrToInt('$'+StringToHex(vData[5])+StringToHex(vData[6]));

      lbl100E.Caption  := FormatFloat(',0개',    StrToInt('$'+StringToHex(vData[5])+StringToHex(vData[6])) );
      lbl100E.Tag      := StrToInt('$'+StringToHex(vData[5])+StringToHex(vData[6]));
      lbl1000E.Caption := FormatFloat(',0개', StrToInt('$'+StringToHex(vData[9])+StringToHex(vData[10])) );
      lbl1000E.Tag     := StrToInt('$'+StringToHex(vData[9])+StringToHex(vData[10]));
      lbl1000.Caption  := FormatFloat(',0개', Ready1000Button.Tag - lbl1000E.Tag);
      lbl100.Caption  := FormatFloat(',0개', Ready100Button.Tag - lbl100E.Tag);

      if (vBillCount >= Common.Config.KioskAlram[4]) or (vCoinCount >= Common.Config.KioskAlram[5]) then
        Common.Config.KioskCashPause := true
      else
        Common.Config.KioskCashPause := false;

      if ((Common.Config.KioskAlram[2] > 0) and (Common.Config.KioskAlram[0]-Common.Config.KioskAlram[2] <= vBillCount))
      or ((Common.Config.KioskAlram[3] > 0) and (Common.Config.KioskAlram[1]-Common.Config.KioskAlram[3] <= vCoinCount)) then
      begin
        Common.KakaoSendMessage('K',['거스름돈이 부족합니다'+#13+
                                Format('천원 %d장, 백원 %d개',[vBillCount, vCoinCount])],'');
      end;

    end;
  end
  //일괄방출수량 조회
  else if (Length(S) > 3) and (StringToHex(vData[2])='16') then
  begin
    vBillCount := StrToInt('$'+StringToHex(vData[9])+StringToHex(vData[10]));
    vCoinCount := StrToInt('$'+StringToHex(vData[5])+StringToHex(vData[6]));

    MessageLabel.Caption := ' 방출이 완료되었습니다';
    Common.MsgBox(Format('천원 %d장, 백원 %d개',[vBillCount, vCoinCount]));
    ResetTimer.Enabled := true;
  end
  //투입누계
  else if (Length(S) > 3) and (StringToHex(vData[2])='17') then
  begin
    if StringToHex(vData[3]) = '00' then
    begin
      v1000Count  := StrToInt('$'+StringToHex(vData[9])+StringToHex(vData[10]));
      v5000Count  := StrToInt('$'+StringToHex(vData[11])+StringToHex(vData[12]));
      v10000Count := StrToInt('$'+StringToHex(vData[13])+StringToHex(vData[14]));

      lblGetAmt.Caption := FormatFloat('#,0 원', (v10000Count*10000) + (v5000Count*5000) + (v1000Count*1000));
    end;
  end;
  DispenserData := S;
end;

procedure TKioskReady_F.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Common.KeyPadType := 0;
end;

procedure TKioskReady_F.GetReadyAmt;
begin
  Ready1000Button.Enabled := true;
  Ready100Button.Enabled  := true;
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

    Ready1000Button.Tag     := Common.Query.FieldByName('KIOSK_1000').AsInteger ;
    Ready1000Button.Caption := Format('%d 개',[Ready1000Button.Tag]);
    Ready100Button.Tag      := Common.Query.FieldByName('KIOSK_100').AsInteger;
    Ready100Button.Caption  := Format('%d 개',[Ready100Button.Tag]);
    Common.Query.Close;
  end
  else
  begin
    Ready1000Button.Tag     := 0 ;
    Ready1000Button.Caption := Format('%d 개',[Ready1000Button.Tag]);
    Ready100Button.Tag      := 0;
    Ready100Button.Caption  := Format('%d 개',[Ready100Button.Tag]);
  end;

  ClickTime         := IncSecond(Now,-3);
  KioskReadyGiveCountSearchButtonClick(nil);
  MessageLabel.Caption := ' 입금누계를 조회 중 입니다...';
  SearchTimer.Enabled := true;
end;

procedure TKioskReady_F.KioskBatchEmitSarchButtonClick(Sender: TObject);
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
begin
  if Sender <> nil then
    Common.KioskTouchBeep('kioskwave12');

  if MilliSecondsBetween(Now(),ClickTime) < 1500 then Exit;
  ClickTime := Now;
  Common.MsgBox('조회가 안되면 "방출기초기화" 후'#13'다시 시도하세요');
  DispenserData := EmptyStr;
  //일괄방출수량 조회
  vTemp := AnsiString(#$11#$01#$00#$00#$00#$00#$00#$00#$00#$00#$00);
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
    MessageLabel.Caption := ' 현금지급기 응답없음';
    Exit;
  end;
end;

procedure TKioskReady_F.KioskReadyBillButtonClick(Sender: TObject);
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
begin
  if Sender <> nil then
    Common.KioskTouchBeep('kioskwave12');


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
    KioskKeyPad_F.Free;
  end;

  Common.WriteLog('work', '지폐일괄방출 클릭');
  Common.MsgBox('방출이 안되면 "방출기초기화" 후'#13'다시 시도하세요');
  KioskBatchEmitSarchButton.Visible := false;
  MessageLabel.Caption := ' 지폐를 일괄 방출 중입니다...';
  DispenserData := EmptyStr;
  //지폐 일괄방출
  vTemp := AnsiString(#$12#$00#$00#$00#$00#$00#$00#$00#$01#$00#$00);
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
    MessageLabel.Caption := ' 현금지급기 응답없음';
    Exit;
  end
  else
  begin
    KioskBatchEmitSarchButton.Visible := true;
  end;
end;

procedure TKioskReady_F.KioskReadyCoinButtonClick(Sender: TObject);
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
begin
  if Sender <> nil then
    Common.KioskTouchBeep('kioskwave12');
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
    KioskKeyPad_F.Free;
  end;

  Common.WriteLog('work', '동전일괄방출 클릭');
  Common.MsgBox('방출이 안되면 "방출기초기화" 후'#13'다시 시도하세요');
  KioskBatchEmitSarchButton.Visible := false;
  MessageLabel.Caption := ' 동전을 일괄 방출 중입니다...';
  DispenserData := EmptyStr;
  //동전 일괄방출
  vTemp := AnsiString(#$12#$00#$00#$00#$00#$00#$01#$00#$00#$00#$00);
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
    MessageLabel.Caption := ' 현금지급기 응답없음';
    Exit;
  end
  else
  begin
    KioskBatchEmitSarchButton.Visible := true;
  end;
end;

procedure TKioskReady_F.KioskReadyGetCountInitButtonClick(Sender: TObject);
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
begin
  if Sender <> nil then
    Common.KioskTouchBeep('kioskwave12');

  if MilliSecondsBetween(Now(),ClickTime) < 1000 then Exit;
  ClickTime := Now;
  DispenserData := EmptyStr;
  //입금 누계수량클리어
  vTemp := AnsiString(#$10#$00#$10#$00#$00#$00#$00#$00#$00#$00#$00);       //(9)누계매수clear
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
    MessageLabel.Caption := ' 현금지급기 응답없음';
    Exit;
  end
  else
  begin
    MessageLabel.Caption := ' 입금/방출 누계수량 정상 초기화';
    ClickTime         := IncSecond(Now,-3);
    KioskReadyGetCountSearchButtonClick(nil);
  end;
end;

procedure TKioskReady_F.KioskReadyGetCountSearchButtonClick(Sender: TObject);
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
begin
  if Sender <> nil then
    Common.KioskTouchBeep('kioskwave12');

  if MilliSecondsBetween(Now(),ClickTime) < 1500 then Exit;
  ClickTime := Now;
  DispenserData := EmptyStr;
  //입금누계수량 조회
  vTemp := AnsiString(#$11#$02#$00#$00#$00#$00#$00#$00#$00#$00#$00);
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
    MessageLabel.Caption := ' 현금지급기 응답없음';
    Exit;
  end
  else if Sender <> nil then
    MessageLabel.Caption := ' 정상 조회 완료';

//  GetCount('I');
end;

procedure TKioskReady_F.KioskReadyGiveCountInitButtonClick(Sender: TObject);
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
begin
  if Sender <> nil then
    Common.KioskTouchBeep('kioskwave12');

  if MilliSecondsBetween(Now(),ClickTime) < 1000 then Exit;
  ClickTime := Now;
  DispenserData := EmptyStr;
  //출금 누계수량클리어
  vTemp := AnsiString(#$10#$10#$00#$00#$00#$00#$00#$00#$00#$00#$00);       //(5)투출금Clear
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
    MessageLabel.Caption := ' 현금지급기 응답없음';
    Exit;
  end
  else
  begin
    MessageLabel.Caption := ' 입금/방출 누계수량 정상 초기화';
    ClickTime         := IncSecond(Now,-3);
    KioskReadyGiveCountSearchButtonClick(nil);
  end;
end;

procedure TKioskReady_F.KioskReadyGiveCountSearchButtonClick(Sender: TObject);
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
begin
  if Sender <> nil then
    Common.KioskTouchBeep('kioskwave12');

  if MilliSecondsBetween(Now(),ClickTime) < 1500 then Exit;
  ClickTime := Now;
  DispenserData := EmptyStr;
  //방출누계 조회
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
    MessageLabel.Caption := ' 현금지급기 응답없음';
    Exit;
  end
  else if Sender <> nil then
    MessageLabel.Caption := ' 정상 조회 완료';

//  GetCount('O');
end;

procedure TKioskReady_F.KioskReadyResetButtonClick(Sender: TObject);
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
begin
  MessageLabel.Caption := EmptyStr;
  if Sender <> nil then
    Common.KioskTouchBeep('kioskwave12');

  if MilliSecondsBetween(Now(),ClickTime) < 1500 then Exit;
  ClickTime := Now;
  MessageLabel.Caption := ' 방출기를 초기화 중입니다... (최대 5초)';

  DispenserData := EmptyStr;
  //방출기 리셋(방출기#1)
  vTemp := AnsiString(#$10#$00#$17#$00#$00#$00#$00#$00#$00#$00#$00);
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
    MessageLabel.Caption := ' 현금지급기 응답없음';
    Exit;
  end;
  MessageLabel.Caption := '';
end;

procedure TKioskReady_F.OpenDatePropertiesPopup(Sender: TObject);
var vTemp :String;
begin
  if OpenDate.Properties.ReadOnly then Exit;
  Common.KioskTouchBeep('kioskwave12');
  OpenDate.Properties.ReadOnly := false;
  OpenQuery('select max(YMD_CLOSE) '
           +'  from SL_POSCLOSE '
           +' where CD_STORE =:P0 '
           +'   and NO_POS   =:P1',
           [Common.Config.StoreCode,
            Common.Config.PosNo]);
  if not Common.Query.Eof then
  begin
    vTemp := Common.Query.Fields[0].AsString;
    if vTemp <> '' then
    begin
      if IncDay( StoD(vTemp), 1) < now () then
        OpenDate.Date := Now
      else
        OpenDate.Date := IncDay( StoD(vTemp), 1);
    end
    else OpenDate.Date := Now;
  end
  else OpenDate.Date := Now;
end;

procedure TKioskReady_F.OpenDatePropertiesCloseUp(Sender: TObject);
begin
  OpenDate.Properties.ReadOnly := true;
  if GetOnlyNumber(OpenDate.Text) = Common.WorkDate then Exit;
  if not Common.AskBox(Format('%s 일자로 개점하시겠습니까?',[OpenDate.Text])) then Exit;

  OpenQuery('select DS_STATUS '
           +'  from SL_POSCLOSE '
           +' where CD_STORE  =:P0 '
           +'   and YMD_CLOSE =:P1 '
           +'   and NO_POS    =:P2 ',
           [Common.Config.StoreCode,
            DtoS(OpenDate.Date),
            Common.Config.PosNo]);
  if not Common.Query.Eof then
  begin
    if Common.Query.Fields[0].AsString = 'C' then
      Common.ErrBox('이미 마감 된 일자입니다')
    else
      Common.ErrBox('이미 개점 된 일자입니다');
    Exit;
  end;

  //메인포스가 이전일자에 마감안한 일자가 있는지 체크한다
  OpenQuery('select StoDW(Max(YMD_CLOSE)) '
           +'  from SL_POSCLOSE '
           +' where CD_STORE =:P0 '
           +'   and NO_POS   =:P1 '
           +'   and DS_STATUS = ''O'' '
           +'   and YMD_CLOSE < :P2 ',
           [Common.Config.StoreCode,
            Common.Config.MainPosNo,
            DtoS(OpenDate.Date)]);
  if not Common.Query.Eof and (Common.Query.Fields[0].AsString <> '') then
  begin
    Common.MsgBox(Format('%s포스 %s일자를'#13'먼저 마감해야합니다',[Common.Config.MainPosNo, Common.Query.Fields[0].AsString]));
    Common.Query.Close;
    Common.WorkDate := '';
    Common.OpenDate := '';
    Exit;
  end;

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
           +'                        null) ',
           [Common.Config.StoreCode,
            DtoS(OpenDate.Date),
            Common.Config.PosNo]);
  Common.WorkDate := DtoS(OpenDate.Date);
  Common.OpenDate := DtoS(OpenDate.Date);
  OpenLabel.Visible := false;
  GetReadyAmt;
end;

procedure TKioskReady_F.GetCount(aType:String);
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
begin
  lblGetAmt.Caption := '0 원';
  DispenserData := EmptyStr;
  //투입누계수량 조회
  if aType = 'I' then
    vTemp := AnsiString(#$11#$02#$00#$00#$00#$00#$00#$00#$00#$00#$00)
  else
    vTemp := AnsiString(#$11#$08#$00#$00#$00#$00#$00#$00#$00#$00#$00);
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

procedure TKioskReady_F.Ready1000ButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  KioskKeyPad_F := TKioskKeyPad_F.Create(Self);
  KioskKeyPad_F.MessageLabel.Caption := '준비금 수량을 입력하세요';
  try
    if KioskKeyPad_F.ShowModal <> mrOK then Exit;
    if KioskKeyPad_F.KeyInLabel.Hint = '' then Exit;
    (Sender as TAdvSmoothToggleButton).Tag  := StrToIntDef(KioskKeyPad_F.KeyInLabel.Hint,0);
    (Sender as TAdvSmoothToggleButton).Caption := Format('%d 개',[(Sender as TAdvSmoothToggleButton).Tag]);
  finally
    KioskKeyPad_F.Free;
  end;

  if DM.ExecCloud('update MS_CODE '
                 +'   set KIOSK_1000 = :P3, '
                 +'       KIOSK_100  = :P4 '
                 +' where CD_HEAD  = :P0 '
                 +'   and CD_STORE = :P1 '
                 +'   and CD_KIND  = ''01'' '
                 +'   and NM_CODE1 = :P2 '
                 +'   and NM_CODE3 = ''2'';',
                 [Common.Config.HeadStoreCode,
                  Common.Config.StoreCode,
                  Common.Config.PosNo,
                  Ready1000Button.Tag,
                  Ready100Button.Tag],true,Common.RestDBURL) then

    ExecQuery('update MS_CODE '
             +'   set KIOSK_1000 = :P2, '
             +'       KIOSK_100  = :P3 '
             +' where CD_STORE = :P0 '
             +'   and CD_KIND  = ''01'' '
             +'   and NM_CODE1 = :P1 '
             +'   and NM_CODE3 = ''2''',
             [Common.Config.StoreCode,
              Common.Config.PosNo,
              Ready1000Button.Tag,
              Ready100Button.Tag]);

  Common.Config.KioskAlram[0] := Ready1000Button.Tag;
  Common.Config.KioskAlram[1] := Ready100Button.Tag;

  lbl100.Caption  := FormatFloat(',0개',    Ready100Button.Tag - StrToInt(GetOnlyNumber(lbl100E.Caption)) );
  lbl1000.Caption := FormatFloat(',0개',    Ready1000Button.Tag - StrToInt(GetOnlyNumber(lbl1000E.Caption)) );


  ClickTime         := IncSecond(Now,-3);
//  KioskReadyGetCountSearchButtonClick(nil);

end;

procedure TKioskReady_F.ResetTimerTimer(Sender: TObject);
begin
  ResetTimer.Enabled := false;
  KioskReadyResetButtonClick(nil);
end;

procedure TKioskReady_F.SearchTimerTimer(Sender: TObject);
begin
  SearchTimer.Enabled := false;
  KioskReadyGetCountSearchButtonClick(nil);
  MessageLabel.Caption := '';
end;

end.
