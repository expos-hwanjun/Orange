unit KioskCashierMgm_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CashierMgm_U, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, DAScript, UniScript, DB,
  MemDS, DBAccess, Uni, cxTextEdit, cxCurrencyEdit, KeyPad_F,
  StdCtrls, jpeg, ExtCtrls, MMSystem, Vcl.Menus, cxButtons,
  AdvGlassButton, cxLabel, dxGDIPlusClasses, AdvShape, AdvSmoothToggleButton,
  AdvSmoothButton;

type
  TKioskCashierMgm_F = class(TCashierMgm_F)
    CustomerCountEdit: TcxCurrencyEdit;
    CustomerAvgEdit: TcxCurrencyEdit;
    Ready1000AmtEdit: TcxCurrencyEdit;
    Ready100AmtEdit: TcxCurrencyEdit;
    Emit1000AmtEdit: TcxCurrencyEdit;
    Emit100AmtEdit: TcxCurrencyEdit;
    _1000CountEdit: TcxCurrencyEdit;
    _100CountEdit: TcxCurrencyEdit;
    GetAmtEdit: TcxCurrencyEdit;
    EmitTimer: TTimer;
    cxLabel17: TcxLabel;
    cxLabel18: TcxLabel;
    cxLabel19: TcxLabel;
    cxLabel20: TcxLabel;
    cxLabel21: TcxLabel;
    cxLabel22: TcxLabel;
    cxLabel23: TcxLabel;
    cxLabel24: TcxLabel;
    cxLabel25: TcxLabel;
    cxLabel26: TcxLabel;
    cxLabel27: TcxLabel;
    cxLabel28: TcxLabel;
    cxLabel29: TcxLabel;
    cxLabel30: TcxLabel;
    cxLabel31: TcxLabel;
    cxLabel32: TcxLabel;
    cxLabel33: TcxLabel;
    cxLabel34: TcxLabel;
    cxLabel35: TcxLabel;
    cxLabel36: TcxLabel;
    cxLabel37: TcxLabel;
    cxLabel38: TcxLabel;
    cxLabel39: TcxLabel;
    cxLabel40: TcxLabel;
    cxLabel41: TcxLabel;
    cxLabel42: TcxLabel;
    cxLabel43: TcxLabel;
    cxLabel44: TcxLabel;
    Image1: TImage;
    Image2: TImage;
    EmitButton: TAdvSmoothToggleButton;
    Image4: TImage;
    AdvShape4: TAdvShape;
    AdvShape5: TAdvShape;
    EmitSearchButton: TAdvSmoothToggleButton;
    Out1000AmtEdit: TcxCurrencyEdit;
    Out100AmtEdit: TcxCurrencyEdit;
    cxLabel45: TcxLabel;
    cxLabel46: TcxLabel;
    cxLabel47: TcxLabel;
    cxLabel48: TcxLabel;
    Image5: TImage;
    Image6: TImage;
    Image8: TImage;
    cxLabel49: TcxLabel;
    procedure FormShow(Sender: TObject);
    procedure EmitSearchButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EmitButtonClick(Sender: TObject);
    procedure obtn_cashiercloseClick(Sender: TObject);
    procedure EmitTimerTimer(Sender: TObject);
  private
    isBillEmit:Boolean;
    DispenserData :String;
    procedure DispenderReset;
    procedure GetInputAmt;
    procedure DispenserReadEvent(const S : String);
  public
    { Public declarations }
  end;

var
  KioskCashierMgm_F: TKioskCashierMgm_F;

implementation
uses Common_U, GlobalFunc_U, Math, DBModule_U, Const_U, KioskKeyPad_U;

{$R *.dfm}

procedure TKioskCashierMgm_F.DispenserReadEvent(const S: String);
var v10000Count,
    v5000Count,
    v1000Count,
    vBillCount,
    vCoinCount :Integer;
    vTemp :AnsiString;
begin
  vTemp := AnsiString(S);
  if (Length(vTemp) > 3) and (StringToHex(vTemp[2])='18') then
  begin
    if StringToHex(vTemp[3]) <> '00' then
    begin
      Common.ErrBox('방출기 오류');
    end
    else
    begin
      Emit100AmtEdit.Value  := StrToInt('$'+StringToHex(vTemp[5])+StringToHex(vTemp[6])) * 100;
      Emit1000AmtEdit.Value := StrToInt('$'+StringToHex(vTemp[11])+StringToHex(vTemp[10])) * 1000;

      _1000AmtEdit.Value := Ready1000AmtEdit.Value - Emit1000AmtEdit.Value;
      _100AmtEdit.Value  := Ready100AmtEdit.Value - Emit100AmtEdit.Value;

      _1000CountEdit.Value := FtoI(_1000AmtEdit.Value) div 1000;
      _100CountEdit.Value  := FtoI(_100AmtEdit.Value) div 100;
    end;
  end
  //일괄방출수량 조회
  else if (Length(S) > 3) and (StringToHex(vTemp[2])='16') then
  begin
    if (EmitTimer.Tag = 0) and isBillEmit then
    begin
      DispenserData     := S;
      EmitTimer.Tag     := 1;
      EmitTimer.Enabled := true;
      Exit;
    end;
    vBillCount := StrToInt('$'+StringToHex(vTemp[9])+StringToHex(vTemp[10]));
    vCoinCount := StrToInt('$'+StringToHex(vTemp[5])+StringToHex(vTemp[6]));

    Out1000AmtEdit.Value := vBillCount * 1000;
    Out100AmtEdit.Value  := vCoinCount * 100;
    MessageLabel.Caption := Format('방출이 완료되었습니다 [천원 %d장, 백원 %d개]',[vBillCount, vCoinCount]);
  end
  //투입누계
  else if (Length(S) > 3) and (StringToHex(vTemp[2])='17') then
  begin
    if StringToHex(vTemp[3]) = '00' then
    begin
      v1000Count  := StrToInt('$'+StringToHex(vTemp[9])+StringToHex(vTemp[10]));
      v5000Count  := StrToInt('$'+StringToHex(vTemp[11])+StringToHex(vTemp[12]));
      v10000Count := StrToInt('$'+StringToHex(vTemp[13])+StringToHex(vTemp[14]));

      GetAmtEdit.Value := (v10000Count*10000) + (v5000Count*5000) + (v1000Count*1000);
    end;
  end;

  DispenserData := S;
{

  if (Length(S) > 3) and (StringToHex(S[3])='18') then
  begin
    if StringToHex(S[4]) <> '00' then
    begin
      Common.ErrBox('방출기 오류');
    end
    else
    begin
      Emit100AmtEdit.Value  := StrToInt('$'+StringToHex(S[6])+StringToHex(S[7])) * 100;
      Emit1000AmtEdit.Value := StrToInt('$'+StringToHex(S[10])+StringToHex(S[11])) * 1000;

      _1000AmtEdit.Value := Ready1000AmtEdit.Value - Emit1000AmtEdit.Value;
      _100AmtEdit.Value  := Ready100AmtEdit.Value - Emit100AmtEdit.Value;

      _1000CountEdit.Value := FtoI(_1000AmtEdit.Value) div 1000;
      _100CountEdit.Value  := FtoI(_100AmtEdit.Value) div 100;
    end;
  end
  //일괄방출수량 조회
  else if (Length(S) > 3) and (StringToHex(S[3])='16') then
  begin
    if (EmitTimer.Tag = 0) and isBillEmit then
    begin
      DispenserData     := S;
      EmitTimer.Tag     := 1;
      EmitTimer.Enabled := true;
      Exit;
    end;
    vBillCount := StrToInt('$'+StringToHex(S[10])+StringToHex(S[11]));
    vCoinCount := StrToInt('$'+StringToHex(S[6])+StringToHex(S[7]));

    MessageLabel.Caption := ' 방출이 완료되었습니다';
    Common.MsgBox(Format('천원 %d장, 백원 %d개',[vBillCount, vCoinCount]));
    MessageLabel.Caption := Format('천원 %d장, 백원 %d개',[vBillCount, vCoinCount]);
  end
  //투입누계
  else if (Length(S) > 3) and (StringToHex(S[3])='17') then
  begin
    if StringToHex(S[4]) = '00' then
    begin
      v1000Count  := StrToInt('$'+StringToHex(S[10])+StringToHex(S[11]));
      v5000Count  := StrToInt('$'+StringToHex(S[12])+StringToHex(S[13]));
      v10000Count := StrToInt('$'+StringToHex(S[14])+StringToHex(S[15]));

      GetAmtEdit.Value := (v10000Count*10000) + (v5000Count*5000) + (v1000Count*1000);
    end;
  end;

  DispenserData := S;
}
end;

procedure TKioskCashierMgm_F.FormShow(Sender: TObject);
begin
  inherited;
  isBillEmit := false;
  Common.Device.OnDispenserReadData :=DispenserReadEvent;
  SaleAmtEdit.Text  := SaleAmtEdit.Text;
  CardAmtEdit.Text  := CardAmtEdit.Text;
  CashAmtEdit.Text  := CashAmtEdit.Text;
  TrustAmtEdit.Text := TrustAmtEdit.Text;
  PointAmtEdit.Text := PointAmtEdit.Text;

  CustomerCountEdit.Text := GuestCountEdit.Text;
  CustomerAvgEdit.Text   := GuestAvgAmtEdit.Text;

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
      Ready1000AmtEdit.Value   := Common.Query.FieldByName('KIOSK_1000').AsInteger * 1000;
      Ready100AmtEdit.Value    := Common.Query.FieldByName('KIOSK_100').AsInteger * 100;
    end;
    EmitButton.Visible       := true;
    EmitSearchButton.Visible := true;
    if Common.Config.KioskDispenserPort > 0 then
      EmitSearchButtonClick(nil);
  end;
  Common.Query.Close;
  CashierColseButton.Visible := True;
end;

procedure TKioskCashierMgm_F.EmitSearchButtonClick(Sender: TObject);
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
begin
  if Sender <> nil then
    Common.KioskTouchBeep('kioskwave12');

  Out1000AmtEdit.Value := 0;
  Out100AmtEdit.Value  := 0;

  Emit100AmtEdit.Value  := 0;
  Emit1000AmtEdit.Value := 0;

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
    Common.ErrBox('방출기 응답없음');
    Exit;
  end;
  GetInputAmt;
end;

procedure TKioskCashierMgm_F.FormCreate(Sender: TObject);
begin
  inherited;
  Common.LogoCreate(Self,2);
end;

procedure TKioskCashierMgm_F.EmitButtonClick(Sender: TObject);
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
begin
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

  EmitTimer.Tag  := 0;
  isBillEmit     := true;
  MessageLabel.Caption := '지폐를 방출 중입니다...';
  DispenserData := EmptyStr;
  //일괄방출
//  vTemp := #$12#$00#$00#$00#$00#$00#$00#$00#$01#$00#$00;
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
    Common.ErrBox('지폐방출기 응답없음');
    Exit;
  end;
end;

procedure TKioskCashierMgm_F.obtn_cashiercloseClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  if Common.WorkDate = '' then
  begin
    Common.MsgBox('개점이 되지 않았습니다');
    Exit;
  end;
  inherited;
end;

procedure TKioskCashierMgm_F.GetInputAmt;
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
begin
  DispenserData := EmptyStr;
  //투입누계수량 조회
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
end;

procedure TKioskCashierMgm_F.EmitTimerTimer(Sender: TObject);
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
begin
  inherited;
  EmitTimer.Enabled := false;
  DispenderReset;
  Sleep(5000);
  MessageLabel.Caption := '동전을 방출 중입니다...';
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
  isBillEmit := false;
end;

procedure TKioskCashierMgm_F.DispenderReset;
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
begin
  MessageLabel.Caption := '방출기를 초기화 중입니다...';
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

end.
