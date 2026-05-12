unit Cash_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ExtCtrls, KeyPad_F, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxCurrencyEdit, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, StrUtils, DateUtils,
  AdvSmoothToggleButton, cxLabel, Vcl.Menus, cxButtons, dxGDIPlusClasses,
  AdvGlassButton, AdvSmoothButton;

type
  TCash_F = class(TForm)
    fmKeyPad1: TfmKeyPad;
    cxLabel3: TcxLabel;
    GetAmtLabel: TcxLabel;
    InputEdit: TcxCurrencyEdit;
    cxLabel1: TcxLabel;
    lbl_Msg: TLabel;
    Image3: TImage;
    TitleLabel: TLabel;
    CloseButton: TcxButton;
    GetAmt1Button: TAdvSmoothButton;
    GetAmt2Button: TAdvSmoothButton;
    GetAmt3Button: TAdvSmoothButton;
    GetAmt4Button: TAdvSmoothButton;
    cxLabel2: TcxLabel;
    AHeadButton: TAdvSmoothButton;
    EasyPayButton: TAdvSmoothButton;
    CashRcpButton: TAdvSmoothButton;
    GiftButton: TAdvSmoothButton;
    TrustButton: TAdvSmoothButton;
    PointButton: TAdvSmoothButton;
    CardButton: TAdvSmoothButton;
    BankButton: TAdvSmoothButton;
    CheckButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure GetAmt1ButtonClick(Sender: TObject);
    procedure BankButtonClick(Sender: TObject);
    procedure CashRcpButtonClick(Sender: TObject);
    procedure GiftButtonClick(Sender: TObject);
    procedure PointButtonClick(Sender: TObject);
    procedure TrustButtonClick(Sender: TObject);
    procedure CardButtonClick(Sender: TObject);
    procedure CheckButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure EasyPayButtonClick(Sender: TObject);
    procedure AHeadButtonClick(Sender: TObject);
  private
    BtnList :TStringList;
    ClickTime :TDateTime;
    procedure CashApply;
    procedure SetWillTakeAmount;
  public
    FInputAmt :Integer;
  end;

var
  Cash_F: TCash_F;

implementation
uses Common_U, CashRcp_U, GlobalFunc_U, Order_U, Card_U, DBModule_U, Const_U;
{$R *.dfm}

////////////////////////////////////////////////////////////////////////////////
//                 Form Create Event
////////////////////////////////////////////////////////////////////////////////
procedure TCash_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(AHeadButton);
  Common.SetButtonColor(CashRcpButton);
  Common.SetButtonColor(EasyPayButton);
  Common.SetButtonColor(GiftButton);
  Common.SetButtonColor(TrustButton);
  Common.SetButtonColor(PointButton);
  Common.SetButtonColor(CardButton);
  Common.SetButtonColor(BankButton);
  Common.SetButtonColor(CheckButton);

  if GetOption(385) = '1' then
  begin
    fmKeyPad1.Num_000.Visible := false;
    fmKeyPad1.Num_00.Visible  := true;
    fmKeyPad1.Num_00.Top      := fmKeyPad1.Num_000.Top;
    fmKeyPad1.Num_00.Left     := fmKeyPad1.Num_000.Left;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//                 Form Show Event
////////////////////////////////////////////////////////////////////////////////
procedure TCash_F.FormShow(Sender: TObject);
var vTemp :String;
    vTop, vCount  :Integer;
begin
  InputEdit.Clear;
  GetAmtLabel.Caption := FormatFloat('#,0',Common.PreSent.WRcvAmt);

  //사용결제수단에따 버튼 보이고 안보이고
  vTemp := HexToBin2(GetOption(383))+HexToBin2(GetOption(384));
  PointButton.Visible    := vTemp[2] = '1';
  TrustButton.Visible    := vTemp[3] = '1';
  CheckButton.Visible    := vTemp[6] = '1';
  BankButton.Visible     := vTemp[4] = '1';
  GiftButton.Visible     := vTemp[1] = '1';

  EasyPayButton.Visible := Common.Config.VanEasyPay <> 'N';
  //금결원은 멀티패드사용하면 간편결제 통합
  if (Common.Config.van_trd = vanKFTC) and (GetOption(379)='0') then
    EasyPayButton.Visible := false
  else if (Common.Config.van_trd in [vanKFTC, vanKOVAN]) and (GetOption(379)='2') then
    EasyPayButton.Caption := '제로페이';

  if (Common.Config.van_trd in [vanKoces, vanJtnet, vanKis, vanSmartro]) or ((Common.Config.van_trd = vanKSNET) and (Common.Config.VanEasyPay = 'T')) then
    EasyPayButton.Visible := false;

  AHeadButton.Visible    := not Common.Table.AHeadPay;


  vTop   := 428;
  vCount := 1;
  if EasyPayButton.Visible then
  begin
    EasyPayButton.Top := vTop;
    vTop := vTop - 78;
    Inc(vCount);
  end;
  if TrustButton.Visible then
  begin
    TrustButton.Top := vTop;
    vTop := vTop - 78;
    Inc(vCount);
  end;
  if PointButton.Visible then
  begin
    PointButton.Top := vTop;
    vTop := vTop - 78;
    Inc(vCount);
  end;
  if GiftButton.Visible then
  begin
    GiftButton.Top := vTop;
    vTop := vTop - 78;
    Inc(vCount);
  end;
  if CashRcpButton.Visible then
  begin
    CashRcpButton.Top := vTop;
    vTop := vTop - 78;
    Inc(vCount);
  end;
  if AHeadButton.Visible then
  begin
    AHeadButton.Top := vTop;
    vTop := vTop - 78;
    Inc(vCount);
  end;

  if vCount < 6  then
  begin
    BankButton.Left := AHeadButton.Left;
    BankButton.Top := vTop;
  end;

  //신용카드결제 시 절사할인을 사용하지 않을때
  if GetOption(305) = '1' then
    CardButton.Enabled := false;

  SetWillTakeAmount;
  Common.SetLanguage(Self);

  //두번눌리는현상 방지
  ClickTime         := IncSecond(Now,-3);
end;

procedure TCash_F.GetAmt1ButtonClick(Sender: TObject);
begin
  if MilliSecondsBetween(Now(),ClickTime) < 1500 then Exit;
  ClickTime := Now;
  InputEdit.Value := (Sender as TAdvSmoothButton).Tag;
  Common.WriteLog('work', '복합결제-현금('+InputEdit.Text+')');
  CashApply;
end;

procedure TCash_F.GiftButtonClick(Sender: TObject);
var vRtn :String;
begin
  if MilliSecondsBetween(Now(),ClickTime) < 1500 then Exit;
  ClickTime := Now;
  if Common.PreSent.WRcvAmt = 0 then
  begin
    Common.ErrBox('받을금액이 없습니다');
    Exit;
  end;
  if Common.Table.AHeadPay then
  begin
    Common.ErrBox('선결제는 현금과 신용카드만 가능합니다');
    Exit;
  end;
  if InputEdit.Text = '' then
  begin
    vRtn := Common.ShowNumberForm('상품권금액을 입력하세요', 0, 9000000, '0' );

    if vRtn = 'mrClose' then Exit;
  end
  else vRtn := InputEdit.Text;

  Common.WriteLog('work', '복합결제-상품권('+vRtn+')');
  Common.PreSent.GiftAmt := Common.PreSent.GiftAmt + + StoI(vRtn);
  Order_F.DisplayPresent;
  GetAmtLabel.Caption := FormatFloat('#,0',Common.PreSent.WRcvAmt);
  InputEdit.Value := 0;
  SetWillTakeAmount;

  if Common.PreSent.WRcvAmt = 0 then
    ModalResult      := mrOK
  else
    InputEdit.Clear;
end;

////////////////////////////////////////////////////////////////////////////////
//                 FormKeyDown Event
////////////////////////////////////////////////////////////////////////////////
procedure TCash_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    48..57  :
    begin
      InputEdit.Text := InputEdit.Text + chr(Key);
      Application.ProcessMessages;
    end;
    96..105 :
    begin
      if Length(IntToStr(Common.PreSent.WRcvAmt)) < (Length(FloatToStr(InputEdit.Value))-1) then Exit;
      InputEdit.Text := InputEdit.Text + chr(Key-48);
      Application.ProcessMessages;
    end;
    8       :  InputEdit.Text := Copy(InputEdit.Text, 1, Length(InputEdit.Text)-1);
    13 :
      begin
        Application.ProcessMessages;
        if (Common.PreSent.WRcvAmt = 0) and (InputEdit.EditValue > 0) then
        begin
           Common.ErrBox('받을금액이 없습니다');
           Exit;
        end;

        if InputEdit.EditValue > 0 then CashApply
        else                            ModalResult := mrCancel;
      end;
    27 : ModalResult := mrCancel;
    VK_F10  : InputEdit.Clear;
  end;
  InputEdit.Text := FormatFloat('#,0', NVL(InputEdit.EditValue,0));
end;

////////////////////////////////////////////////////////////////////////////////
//                 현금공통 적용 procedure
////////////////////////////////////////////////////////////////////////////////
procedure TCash_F.CardButtonClick(Sender: TObject);
var vAmount :Integer;
begin
  if MilliSecondsBetween(Now(),ClickTime) < 1500 then Exit;
  ClickTime := Now;
  Common.WriteLog('work', '복합결제-신용카드('+InputEdit.Text+')');
  if InputEdit.Value > 0 then
    vAmount := InputEdit.EditValue
  else
    vAmount := 0;

  if GetOption(51) = '1' then
  begin
    Common.PreSent.CardAmt := Common.PreSent.CardAmt + vAmount;
    Order_F.DisplayPresent;
    if Common.PreSent.WRcvAmt = 0 then
      ModalResult      := mrOK
    else
      InputEdit.Clear;
  end
  else
  begin
    //다중사업자일때 금액이 있으면 다중을 해제한다
    if (GetOption(60) = '1') and (vAmount <> Common.PreSent.WRcvAmt) then
      Common.Config.Options[60] := '0';

    if Common.ShowCardForm(false, true, vAmount) then
    begin
      InitCardRecord(Common.Card);
      Order_F.DisplayPresent;
      GetAmtLabel.Caption := FormatFloat('#,0',Common.PreSent.WRcvAmt);
      InputEdit.Value := 0;
      SetWillTakeAmount;
      if Common.PreSent.WRcvAmt = 0 then
        ModalResult      := mrOK
      else
        InputEdit.Clear;
    end;
  end;
end;

procedure TCash_F.CashApply;
begin
  //현금처리를 했을때 받을금액이 없고 현금영수증을 발행하지 않았을때
  if (GetOption(65) = '1')
     and (Common.PreSent.WRcvAmt - FtoI(InputEdit.EditValue) <= 0)
     and (Common.CashRcp.Amt_Approval = 0)
     and (Common.PreSent.WRcvAmt >= 1) then
  begin
     ClickTime    := IncSecond(Now,-2);
     CashRcpButtonClick(CashRcpButton);
  end
  else
  begin
    Common.PreSent.CashAmt := Common.PreSent.CashAmt + FtoI(InputEdit.EditValue);
    ModalResult      := mrOK;
  end;
end;

procedure TCash_F.AHeadButtonClick(Sender: TObject);
begin
  Common.WriteLog('work', '복합결제-선결제');
  ModalResult := mrAbort;
end;

procedure TCash_F.BankButtonClick(Sender: TObject);
var vRtn :String;
begin
  if MilliSecondsBetween(Now(),ClickTime) < 1500 then Exit;
  ClickTime := Now;
  if Common.PreSent.WRcvAmt = 0 then
  begin
    Common.ErrBox('받을금액이 없습니다');
    Exit;
  end;
  if Common.Table.AHeadPay then
  begin
    Common.ErrBox('선결제는 현금과 신용카드만 가능합니다');
    Exit;
  end;

  if InputEdit.Text = '' then
  begin
    vRtn := Common.ShowNumberForm('계좌입금 금액을 입력하세요', 0, 9000000, IntToStr(Common.PreSent.WRcvAmt) );

    if vRtn = 'mrClose' then Exit;
  end
  else vRtn := InputEdit.Text;

  Common.WriteLog('work', '복합결제-계좌입금('+vRtn+')');
  Common.PreSent.BankAmt := Common.PreSent.BankAmt + + StoI(vRtn);
  Order_F.DisplayPresent;
  GetAmtLabel.Caption := FormatFloat('#,0',Common.PreSent.WRcvAmt);
  InputEdit.Value := 0;
  SetWillTakeAmount;

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
    ModalResult      := mrOK;
  end
  else
    InputEdit.Clear;
end;

procedure TCash_F.CashRcpButtonClick(Sender: TObject);
begin
  if MilliSecondsBetween(Now(),ClickTime) < 1500 then Exit;
  ClickTime := Now;
  InitCashRcpRecord(Common.CashRcp);
  if Common.PreSent.WRcvAmt = 0 then
  begin
    Common.ErrBox('받을금액이 없습니다');
    Exit;
  end;

  Common.WriteLog('work', '복합결제-현금영수증('+InputEdit.Text+')');

  //신용카드/현금영수증 기능을 사용하지 않는다고 설정했으면
  if GetOption(51) = '1' then
  begin
    Common.PreSent.CashRcpAmt := Common.PreSent.WRcvAmt;
    ModalResult      := mrOK;
    Exit;
  end;

  if Common.ShowCashRcpForm(true, NVL(InputEdit.EditValue,0)) then
  begin
    //투밴을 사용하지 않거나 단말기 숭인일때
    if Common.CashRcp.Amt_Approval <> 0 then
    begin
      Common.PreSent.CashAmt    := Common.PreSent.CashAmt + Common.CashRcp.RcvAmt;
      Common.PreSent.CashRcpAmt := Common.PreSent.CashRcpAmt + Common.CashRcp.Amt_Approval;
      Common.CashRcpInfoSave;
    end;
    InitCashRcpRecord(Common.CashRcp);
    ModalResult      := mrOK;
  end
  else
  begin
    if (Integer(NVL(InputEdit.EditValue,0)) > 0) and (Common.AskBox('현금영수증을 발행하지 못했습니다'+#13#13+'계속하시겠습니까?')) then
    begin
      Common.PreSent.CashAmt := Common.PreSent.CashAmt + Integer(NVL(InputEdit.EditValue,0));
      ModalResult      := mrOK;
    end;
  end;
end;

procedure TCash_F.CheckButtonClick(Sender: TObject);
begin
  if Common.Table.AHeadPay then
  begin
    Common.Errbox('선결제는 현금과 신용카드만 가능합니다');
    Exit;
  end;

  if Common.PreSent.WRcvAmt = 0 then
  begin
    Common.ErrBox('받을금액이 없습니다');
    Exit;
  end;
  Common.WriteLog('work', '복합결제-수표('+InputEdit.Text+')');
  if Common.ShowCheckForm then
  begin
    Order_F.DisplayPresent;
    Close;
  end;
end;

procedure TCash_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TCash_F.EasyPayButtonClick(Sender: TObject);
var vAmount :Integer;
    vOption60 :Char;
begin
  if MilliSecondsBetween(Now(),ClickTime) < 1500 then Exit;
  try
    Common.WriteLog('work', '복합결제-간편결제('+InputEdit.Text+')');
    //잠시 다중사업자를 사용안하는 걸로 바꿘다
    vOption60 := GetOption(60);
    Common.Config.Options[60] := '0';
    ClickTime := Now;
    if InputEdit.Value > 0 then
      vAmount := InputEdit.EditValue
    else
      vAmount := 0;

    if Common.ShowCardForm(true, True,vAmount) then
    begin
      InitCardRecord(Common.Card);
      Order_F.DisplayPresent;
      GetAmtLabel.Caption := FormatFloat('#,0',Common.PreSent.WRcvAmt);
      InputEdit.Value := 0;
      SetWillTakeAmount;
      if Common.PreSent.WRcvAmt = 0 then
        ModalResult      := mrOK
      else
        InputEdit.Clear;
    end;
  finally
    Common.Config.Options[60] := vOption60;
  end;
end;

procedure TCash_F.SetWillTakeAmount;
var aTemp, vIndex :Integer;
begin
  BtnList := TStringList.Create;
  //받을금액
  aTemp := Common.PreSent.WRcvAmt;
  if aTemp <=  5000 then
  begin
    if aTemp <= 500 then begin BtnList.Add('500'); BtnList.Add('1000'); end
    else if aTemp <= 1000 then BtnList.Add('1000')
    else if aTemp <= 1500 then begin BtnList.Add('1500'); BtnList.Add('2000'); end
    else if aTemp <= 2000 then BtnList.Add('2000')
    else if aTemp <= 2500 then begin BtnList.Add('2500'); BtnList.Add('3000'); end
    else if aTemp <= 3000 then BtnList.Add('3000')
    else if aTemp <= 3500 then begin BtnList.Add('3500'); BtnList.Add('4000'); end
    else if aTemp <= 4000 then BtnList.Add('4000')
    else if aTemp <= 4500 then BtnList.Add('4500');
    BtnList.Add('5000');
    BtnList.Add('10000');
    BtnList.Add('50000');
  end
  else if aTemp <= 10000 then
  begin
    if aTemp <= 5500 then begin BtnList.Add('5500'); BtnList.Add('6000'); end
    else if aTemp <= 6000 then BtnList.Add('6000')
    else if aTemp <= 6500 then begin BtnList.Add('6500'); BtnList.Add('7000'); end
    else if aTemp <= 7000 then BtnList.Add('7000')
    else if aTemp <= 7500 then begin BtnList.Add('7500'); BtnList.Add('8000'); end
    else if aTemp <= 8000 then BtnList.Add('8000')
    else if aTemp <= 8500 then begin BtnList.Add('8500'); BtnList.Add('9000'); end
    else if aTemp <= 9000 then BtnList.Add('9000')
    else if aTemp <= 9500 then BtnList.Add('9500');
    BtnList.Add('10000');
    BtnList.Add('50000');
  end
  else if aTemp <= 15000 then
  begin
    if aTemp <= 10500 then begin BtnList.Add('10500'); BtnList.Add('11000'); end
    else if aTemp <= 11000 then BtnList.Add('11000')
    else if aTemp <= 11500 then begin BtnList.Add('11500'); BtnList.Add('12000'); end
    else if aTemp <= 12000 then BtnList.Add('12000')
    else if aTemp <= 12500 then begin BtnList.Add('12500'); BtnList.Add('13000'); end
    else if aTemp <= 13000 then BtnList.Add('13000')
    else if aTemp <= 13500 then begin BtnList.Add('13500'); BtnList.Add('14000'); end
    else if aTemp <= 14000 then BtnList.Add('14000')
    else if aTemp <= 14500 then BtnList.Add('14500');
    BtnList.Add('15000');
    BtnList.Add('20000');
    BtnList.Add('50000');
  end
  else if aTemp <= 20000 then
  begin
    if aTemp <= 15500 then begin BtnList.Add('15500'); BtnList.Add('16000'); end
    else if aTemp <= 16000 then BtnList.Add('16000')
    else if aTemp <= 16500 then begin BtnList.Add('16500'); BtnList.Add('17000'); end
    else if aTemp <= 17000 then BtnList.Add('17000')
    else if aTemp <= 17500 then begin BtnList.Add('17500'); BtnList.Add('18000'); end
    else if aTemp <= 18000 then BtnList.Add('18000')
    else if aTemp <= 18500 then begin BtnList.Add('18500'); BtnList.Add('19000'); end
    else if aTemp <= 19000 then BtnList.Add('19000')
    else if aTemp <= 19500 then BtnList.Add('19500');
    BtnList.Add('20000');
    BtnList.Add('50000');
  end
  else if aTemp <= 100000 then
  begin
    if aTemp <= 25000 then begin BtnList.Add('25000'); BtnList.Add('30000'); end
    else if aTemp <= 30000 then BtnList.Add('30000')
    else if aTemp <= 35000 then begin BtnList.Add('35000'); BtnList.Add('40000'); end
    else if aTemp <= 40000 then BtnList.Add('40000')
    else if aTemp <= 45000 then begin BtnList.Add('45000'); end
    else if aTemp <= 50000 then //
    else if aTemp <= 55000 then begin BtnList.Add('55000'); BtnList.Add('60000'); end
    else if aTemp <= 60000 then BtnList.Add('60000')
    else if aTemp <= 65000 then begin BtnList.Add('65000'); BtnList.Add('70000'); end
    else if aTemp <= 70000 then BtnList.Add('70000')
    else if aTemp <= 75000 then begin BtnList.Add('75000'); BtnList.Add('80000'); end
    else if aTemp <= 80000 then BtnList.Add('80000')
    else if aTemp <= 85000 then begin BtnList.Add('85000'); BtnList.Add('90000'); end
    else if aTemp <= 90000 then BtnList.Add('90000')
    else if aTemp <= 95000 then  BtnList.Add('95000');

    if (aTemp >= 1000) and (aTemp < 5000) then
      BtnList.Add('5000');

    if (aTemp >= 1000) and (aTemp < 10000) then
    begin
      BtnList.Add('10000');
      BtnList.Add('50000');
      BtnList.Add('100000');
    end;

    if (aTemp >= 10000) and (aTemp <= 100000) then
    begin
      if aTemp <= 50000 then BtnList.Add('50000');
      BtnList.Add('100000');
    end;
  end
  else
  begin
     BtnList.Add(IntToStr(aTemp));
     BtnList.Add(IntToStr(((aTemp div 100000)+1)* 100000));
  end;

  For vIndex := 1 to 4 do
    TAdvSmoothButton(FindComponent(Format('GetAmt%dButton',[vIndex]))).Visible := False;

  For vIndex := 1 to BtnList.Count do
  begin
    if vIndex >= 5 then Continue;
    TAdvSmoothButton(FindComponent(Format('GetAmt%dButton',[vIndex]))).Visible := True;
    TAdvSmoothButton(FindComponent(Format('GetAmt%dButton',[vIndex]))).Caption := FormatFloat('#,0', StoI(BtnList.Strings[vIndex-1]) ) +'원' ;
    TAdvSmoothButton(FindComponent(Format('GetAmt%dButton',[vIndex]))).Tag     := StoI(BtnList.Strings[vIndex-1]);
  end;
end;

procedure TCash_F.TrustButtonClick(Sender: TObject);
var vRtn :String;
begin
  if MilliSecondsBetween(Now(),ClickTime) < 1500 then Exit;
  ClickTime := Now;
  if Common.Table.AHeadPay then
  begin
    Common.ErrBox('선결제는 현금과 신용카드만 가능합니다');
    Exit;
  end;
  if (GetOption(250) = '1') and (Common.Member.Code = '') then
  begin
    if Common.ShowMemberForm then
      Order_F.DisplayPresent
    else
    begin
      Common.ErrBox('회원만 외상이 가능합니다');
      Exit;
    end;
  end;

  GetAmtLabel.Caption := FormatFloat('#,0',Common.PreSent.WRcvAmt);
  if (GetOption(250) = '1') and (Common.Member.Yn_trust = 'N') then
  begin
    Common.ErrBox('외상을 할 수 없는 회원입니다');
    Exit;
  end;

  if Common.PreSent.WRcvAmt = 0 then
  begin
    Common.ErrBox('받을금액이 없습니다');
    Exit;
  end;

  if (GetOption(287) = '0') then
  begin
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

  Common.WriteLog('work', '복합결제-외상('+IntToStr(Common.PreSent.TrustAmt)+')');
  Order_F.DisplayPresent;
  GetAmtLabel.Caption := FormatFloat('#,0',Common.PreSent.WRcvAmt);
  InputEdit.Value := 0;
  SetWillTakeAmount;
  if Common.PreSent.WRcvAmt = 0 then
    ModalResult      := mrOK
  else
    InputEdit.Clear;
end;

procedure TCash_F.PointButtonClick(Sender: TObject);
var vTemp, vKey :String;
    vPoint :Integer;
    vResult :Boolean;
begin
  if MilliSecondsBetween(Now(),ClickTime) < 1500 then Exit;
  ClickTime := Now;
  if Common.Table.AHeadPay then
  begin
    Common.ErrBox('선결제는 현금과 신용카드만 가능합니다');
    Exit;
  end;

  if Common.Member.Code = '' then
  begin
    if Common.ShowMemberForm then
      Order_F.DisplayPresent
    else
    begin
      Common.ErrBox('회원만 포인트 사용이 가능합니다');
      Exit;
    end;
  end
  else if (Common.OrderKind = okChange) and ((Common.PreSent.OccurPnt > 0) or (Common.PreSent.UsePnt > 0)) then
  begin
    Common.ErrBox('포인트를 적립/사용한 영수증은'#13'포인트를 사용할 수 없습니다');
    Exit;
  end;

  if (GetOption(306) = '1') and (Common.OrderKind = okChange) then
  begin
    Common.ErrBox('결제변경 시에는 포인트 할인을 할 수 없습니다');
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
      Common.WriteLog('PointButtonClick',Format('오프라인 시 포인트사용(%s-%d)',[Common.Member.Code,Common.Member.Point]));
  finally
    DM.CloudData.Close;
  end;

  GetAmtLabel.Caption := FormatFloat('#,0',Common.PreSent.WRcvAmt);
  if Common.Member.Point <= 0 then
  begin
    Common.ErrBox('잔여포인트가 부족합니다');
    Exit;
  end;

  if Common.Member.Point <= Common.PreSent.WRcvAmt then
    vPoint := Common.Member.Point
  else
    vPoint := Common.PreSent.WRcvAmt;

  vTemp := Common.ShowNumberForm('결제금액을 입력하세요', 0, vPoint, FtoS(vPoint));
  if vTemp = 'mrClose' then Exit;
  if Common.Config.pnt_min_use > Common.Member.Point then
  begin
    Common.ErrBox(Format('잔여포인트가 %d점 이상만'#13#13'사용이 가능합니다',[Common.Config.pnt_min_use]));
    Exit;
  end;

  if Common.Member.Point < StoI(vTemp) then
  begin
    Common.ErrBox('잔여포인트가 부족합니다');
    Exit;
  end;

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
  if GetOption(404) = '1' then
  begin
    while Length(vKey) <> 4 do
      vKey := IntToStr(Random(9999));
    vResult := Common.SMSSendMessage(Format('[%s]포인트사용 [%s] 인증번호입니다',[Common.Config.StoreName, vKey]),
                                     Common.Member.MobileTel);
    if not vResult then
    begin
      Common.ErrBox('인증번호 발송 실패!!!');
      Exit;
    end;

    if not Common.AskBox(Format('인증번호 [ %s ] 맞습니까?',[vKey])) then Exit;
  end;

  Common.WriteLog('work', '복합결제-포인트('+vTemp+')');
  Common.PreSent.UsePnt   := StoI(vTemp);
  if (GetOption(372)='1') then
    Common.PreSent.PointDc := StoI(vTemp)
  else
    Common.PreSent.PointAmt := StoI(vTemp);

  Order_F.DisplayPresent;
  GetAmtLabel.Caption := FormatFloat('#,0',Common.PreSent.WRcvAmt);
  InputEdit.Value := 0;
  SetWillTakeAmount;
  if Common.PreSent.WRcvAmt = 0 then
    ModalResult      := mrOK
  else
    InputEdit.Clear;
end;

end.
