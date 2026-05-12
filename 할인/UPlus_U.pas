unit UPlus_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, POSCard, StdCtrls, Mask, ExtCtrls, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxCurrencyEdit, KeyPad_F, cxLabel,
  Common_U, StrUtils, MaskUtils, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack,
  IdSSL, IdSSLOpenSSL, Vcl.Menus, cxButtons, AdvGlassButton, dxGDIPlusClasses,
  AdvSmoothToggleButton;

type TApprovalUplus = function (aJoinCode,aCardNo:PWideChar; aSaleAmt, aDcAmt:Integer; var aResponse:PWideChar):integer; stdcall;
type TCancelUplus   = function (aJoinCode,aCardNo,aApprovalNo:PWideChar; aDcAmt:Integer; var aResponse:PWideChar):integer; stdcall;
type TSearchUplus   = function (aJoinCode,aCardNo:PWideChar; aSaleAmt, aDcAmt:Integer; var aResponse:PWideChar):integer; stdcall;

type
  TUPlus_F = class(TForm)
    cedt_Amt: TcxCurrencyEdit;
    fmKeyPad1: TfmKeyPad;
    lbl_Kind: TcxLabel;
    edt_CardNo: TcxTextEdit;
    IdHTTP: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    lbl_JoinNo: TcxLabel;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    TitleLabel: TLabel;
    CloseButton: TcxButton;
    ApprovalButton: TAdvGlassButton;
    SearchButton: TAdvGlassButton;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    MessageLabel: TLabel;
    Image3: TImage;
    procedure FormShow(Sender: TObject);
    procedure edt_CardNoEnter(Sender: TObject);
    procedure cedt_AmtKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_CardNoExit(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure ApprovalButtonClick(Sender: TObject);
  private
    ErrMsg,
    Note      :String;
    procedure SetMsrData;  //Msr 데이터 조합
    procedure ScannerReadEvent(const S : String);
  public
  end;

var
  UPlus_F: TUPlus_F;

implementation
uses GlobalFunc_U, Const_U, Math;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TUPlus_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
end;

procedure TUPlus_F.FormShow(Sender: TObject);
begin
  Common.Device.OnScannerReadData := ScannerReadEvent;
  lbl_JoinNo.Caption := Format('제휴점코드 [ %s ]',[Common.Config.UplusJoinCode]);
  edt_CardNo.Clear;
  if Common.UPlus.ds_trd = dtApproval then
  begin
    edt_CardNo.Text := '';
    cedt_Amt.Value  := Common.PreSent.WRcvAmt;
  end
  else
  begin
    edt_CardNo.Text := Common.UPlus.CardNo;
    cedt_Amt.Value  := Common.UPlus.AgreeAmt;
  end;

  MessageLabel.Caption := EmptyStr;
  edt_CardNo.SetFocus;
end;

procedure TUPlus_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TUPlus_F.edt_CardNoEnter(Sender: TObject);
begin
  if Common.UPlus.Ds_Trd = dtApproval then
    edt_CardNo.Clear;
  MessageLabel.Caption := EmptyStr;
end;

procedure TUPlus_F.ApprovalButtonClick(Sender: TObject);
var vApprovalUplus :TApprovalUplus;
    vCancelUplus   :TCancelUplus;
    vSearchUplus   :TSearchUplus;
    vHandle :THandle;
    vGetData :PWideChar;
    vTemp    :String;
    vReturn  :Integer;
begin
  if Common.Config.UplusJoinCode = '' then
  begin
    Common.MsgBox('제휴점코드가 등록되지 않았습니다'#13'매장정보에서 제휴점코드를 등록하세요');
    Exit;
  end;
  BlockInput(true);
  Common.ShowWaitForm;
  try
    vHandle     := LoadLibrary(PChar(Common.AppPath+'\dll\UplusDll.dll'));
    vGetData := '';
    @vApprovalUplus  := GetProcAddress(vHandle, 'ApprovalUplus');
    @vCancelUplus    := GetProcAddress(vHandle, 'CancelUplus');
    @vSearchUplus    := GetProcAddress(vHandle, 'SearchUplus');

    if not Assigned(@vApprovalUplus) then
    begin
      Common.MsgBox('UplusDll.dll 파일을 불러올 수 없습니다');
      Exit;
    end;
    if Sender = ApprovalButton then
    begin
      if Common.UPlus.ds_trd = dtApproval then
      begin
        vReturn := vApprovalUplus(PWideChar(WideString(Common.Config.UplusJoinCode)), PWideChar(WideString(GetOnlyNumber(edt_CardNo.Text))), Common.PreSent.WRcvAmt, Common.PreSent.WRcvAmt, vGetData);
        vTemp := vGetData;
        if vReturn < 0 then
        begin
          Common.MsgBox(vTemp+#13+'문의전화 1544-0197(평일 9~18시)');
          Exit;
        end;
        Common.UPlus.CardNo    := edt_CardNo.Text;
        Common.UPlus.TelmflwNo := CopyPos(vTemp,'|',1);
        Common.UPlus.AgreeDate := CopyPos(vTemp,'|',2);
        Common.UPlus.AgreeNo   := CopyPos(vTemp,'|',3);
        Common.UPlus.Dc_Amt    := StrToInt(CopyPos(vTemp,'|',4));
        Common.UPlus.AgreeAmt  := Common.PreSent.WRcvAmt;
        Common.UPlusInfoSave;
        ModalResult := mrOK;
      end
      else
      begin
        vReturn := vCancelUplus(PWideChar(WideString(Common.Config.UplusJoinCode)), PWideChar(WideString(GetOnlyNumber(edt_CardNo.Text))), PWideChar(WideString(Common.UPlus.OrgAgreeNo)),Common.UPlus.AgreeAmt, vGetData);
        vTemp := vGetData;
        if vReturn < 0 then
        begin
          Common.MsgBox(vTemp+#13+'문의전화 1544-0197(평일 9~18시)');
          Exit;
        end;
        Common.UPlus.CardNo    := edt_CardNo.Text;
        Common.UPlus.TelmflwNo := CopyPos(vTemp,'|',1);
        Common.UPlus.AgreeDate := FormatDateTime('yyyymmddhhmmss',now());
        Common.UPlus.AgreeNo   := '';
        Common.UPlus.Dc_Amt    := Common.UPlus.Dc_Amt * -1;
        Common.UPlus.pnt_rest  := 0;
        Common.UPlusInfoSave;
        ModalResult := mrOK;
      end;
    end
    else
    begin
      vReturn := vSearchUplus(PWideChar(WideString(Common.Config.UplusJoinCode)), PWideChar(WideString(GetOnlyNumber(edt_CardNo.Text))), Common.PreSent.WRcvAmt,Common.PreSent.WRcvAmt, vGetData);
      vTemp := vGetData;
      if vReturn < 0 then
        Common.MsgBox(vTemp+#13+'문의전화 1544-0197(평일 9~18시)')
      else
        Common.MsgBox(Format('할인금액 %s원, 잔여한도 %s원'#13'잔여사용횟수(일/월)(%d회/%d회)',
                            [FormatFloat(',0',StrToInt(CopyPos(vTemp,'|',1))),
                             FormatFloat(',0',StrToInt(CopyPos(vTemp,'|',2))),
                             StrToInt(CopyPos(vTemp,'|',3)),
                             StrToInt(CopyPos(vTemp,'|',4))]));
    end;
  finally
    FreeLibrary(vHandle);
    Common.HideWaitForm;
    BlockInput(false);
  end;
end;

procedure TUPlus_F.cedt_AmtKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then ApprovalButtonClick(nil);
end;

procedure TUPlus_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case Key of
     VK_F10  :  if (ActiveControl is TCustomEdit) then TCustomEdit(ActiveControl).Clear;
     27      :  CloseButton.Click;
   end;
end;

procedure TUPlus_F.ScannerReadEvent(const S: String);
begin
  edt_CardNo.Text := S;
end;

procedure TUPlus_F.edt_CardNoExit(Sender: TObject);
begin
  if edt_CardNo.Text <> EmptyStr then SetMsrData;
end;

procedure TUPlus_F.SetMsrData;
   function Get2Track(AValue:String):String;
   var I   :Integer;
   begin
      Result := '';
      For I:=1 to Length(AValue) do
      begin
         Case AValue[I] of
           #48..#57, #61: Result := Result + AValue[I];
         end;
      end;
   end;
var
   vReadData:String;
begin
   vReadData := GetOnlyNumber(edt_CardNo.Text);

   if Length(vReadData) = 0 then Exit;
   vReadData := Get2Track(vReadData);

   if (vReadData[1] = ';') or (vReadData[1] = '?') or (vReadData[1] = '#') then
     Common.UPlus.CardNo := Get2Track(Copy(vReadData,2,Pos('=',vReadData)-2))
   else if Pos('=',vReadData) > 0 then
     Common.UPlus.CardNo := Get2Track(Copy(vReadData,1,Pos('=',vReadData)-1))
   else
     Common.UPlus.CardNo := CtoC(edt_CardNo.Text,'-','');

   if Length(Common.UPlus.CardNo) = 16 then
     edt_CardNo.Text := FormatMaskText('!0000-0000-0000-0000;0;',Common.UPlus.CardNo)
   else
     edt_CardNo.Text    := Common.UPlus.CardNo;
   cedt_Amt.SetFocus;
end;

end.

