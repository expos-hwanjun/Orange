unit KioskPhoneKeyPad_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxLabel, StrUtils,
  MaskUtils, MMSystem, cxImage, AdvSmoothButton, AdvSmoothToggleButton,
  Vcl.StdCtrls, cxRadioGroup, cxCheckBox, dxGDIPlusClasses, cxClasses,
  Vcl.Menus, cxButtons, Vcl.Buttons;

type
  TKioskPhoneKeyPad_F = class(TForm)
    KeyInLabel: TcxLabel;
    MessageLabel: TcxLabel;
    CloseTimer: TTimer;
    OKButton: TAdvSmoothButton;
    CancelButton: TAdvSmoothToggleButton;
    Message1Label: TcxLabel;
    Message2Label: TcxLabel;
    Message3Label: TcxLabel;
    Shape1: TShape;
    ClearButton: TAdvSmoothButton;
    AgreeButton: TAdvSmoothButton;
    AgreeLabel: TcxLabel;
    ImageCollection: TcxImageCollection;
    ImageCollectionItem1: TcxImageCollectionItem;
    ImageCollectionItem2: TcxImageCollectionItem;
    CloseButton: TAdvSmoothButton;
    ShowTimer: TTimer;
    Num1Button: TAdvSmoothToggleButton;
    Num2Button: TAdvSmoothToggleButton;
    Num3Button: TAdvSmoothToggleButton;
    Num6Button: TAdvSmoothToggleButton;
    Num5Button: TAdvSmoothToggleButton;
    Num4Button: TAdvSmoothToggleButton;
    Num7Button: TAdvSmoothToggleButton;
    Num8Button: TAdvSmoothToggleButton;
    Num9Button: TAdvSmoothToggleButton;
    ZeroButton: TAdvSmoothToggleButton;
    Zero3Button: TAdvSmoothToggleButton;
    BSButton: TAdvSmoothToggleButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NumBSButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure CloseTimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BSButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure Num1ButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ClearButtonClick(Sender: TObject);
    procedure AgreeButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure ShowTimerTimer(Sender: TObject);
  private
    function  GetPhoneFormat(aStr :String):String;        //전화번호에 하이픈넣기
    function  GetPassword(aStr:String):String;
    procedure ScannerReadEvent(const S : String);
  public
  end;

var
  KioskPhoneKeyPad_F: TKioskPhoneKeyPad_F;

implementation
uses Common_U, GlobalFunc_U;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TKioskPhoneKeyPad_F.FormCreate(Sender: TObject);
var vIndex :Integer;
begin
  Common.LogoCreate(Self,0);
  Common.SetButtonColor(OKButton);

  Common.SetKioskButton(CancelButton,'No');
  Common.SetKioskButton(OKButton,'Yes');
  Common.SetKioskButton(MessageLabel);
  Common.SetKioskButton(Message1Label);
  Common.SetKioskButton(Message2Label);
  Common.SetKioskButton(Message3Label);

  DoubleBuffered := true;
end;

procedure TKioskPhoneKeyPad_F.FormShow(Sender: TObject);
begin
  BlockInput(false);
  MessageLabel.Caption := Common.GetPaPago(MessageLabel.Caption);
  OKButton.Caption     := Common.GetPaPago('확인');
  CancelButton.Caption := Common.GetPaPago('취소');
  Common.Device.OnScannerReadData := ScannerReadEvent;
  KeyInLabel.Hint    := '010';
  KeyInLabel.Caption := '010';
  Common.KioskTouchBeep('MobileNo');
  CloseTimer.Tag := 0;
  ShowTimer.Enabled  := true;
end;

procedure TKioskPhoneKeyPad_F.Num1ButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  KeyInLabel.Hint    := KeyInLabel.Hint + (Sender as TAdvSmoothToggleButton).Caption;
  KeyInLabel.Caption := GetPhoneFormat(KeyInLabel.Hint);
end;

procedure TKioskPhoneKeyPad_F.NumBSButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');

  KeyInLabel.Hint    := LeftStr(KeyInLabel.Hint, Length(KeyInLabel.Hint)-1);
  KeyInLabel.Caption := GetPhoneFormat(KeyInLabel.Hint);
end;

function  TKioskPhoneKeyPad_F.GetPhoneFormat(aStr :String):String;        //전화번호에 하이픈넣기
var vTemp :String;
begin
  vTemp := aStr;
  case Length(vTemp) of
     4 : Result := FormatMaskText('!000-0;0; ',vTemp);
     5 : Result := FormatMaskText('!000-00;0; ',vTemp);
     6 : Result := FormatMaskText('!000-000;0; ',vTemp);
     7 : Result := FormatMaskText('!000-0000;0; ',vTemp);
     8 : Result := FormatMaskText('!000-0000-0;0; ',vTemp);
     9 : Result := FormatMaskText('!000-0000-00;0; ',vTemp);
    10 : Result := FormatMaskText('!000-0000-000;0; ',vTemp);
    11 : Result := FormatMaskText('!000-0000-0000;0; ',vTemp);
    16 : Result := FormatMaskText('!0000-0000-0000-0000;0; ',vTemp);
    else Result := aStr;
  end;
end;


function TKioskPhoneKeyPad_F.GetPassword(aStr: String): String;
var vIndex :Integer;
begin
  Result := EmptyStr;
  for vIndex := 1 to Length(aStr) do
    Result := Result + '*';
end;

procedure TKioskPhoneKeyPad_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    OKButtonClick(nil)
  else if Key = VK_ESCAPE then
    Close;
end;

procedure TKioskPhoneKeyPad_F.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    OKButtonClick(nil);
    Exit;
  end;

  if Key = #8 then
    KeyInLabel.Hint    := LeftStr(KeyInLabel.Hint, Length(KeyInLabel.Hint)-1)
  else
    KeyInLabel.Hint    := KeyInLabel.Hint + Key;

  KeyInLabel.Caption := GetPhoneFormat(KeyInLabel.Hint);
end;

procedure TKioskPhoneKeyPad_F.OKButtonClick(Sender: TObject);
begin
  CloseTimer.Enabled := false;
  Common.KioskTouchBeep('kioskwave12');
  if not IsDebuggerPresent and (AgreeButton.Tag = 0) then
  begin
    CloseTimer.Enabled := true;
    Common.MsgBox('개인정보 수집동의를 해주세요');
    Exit;
  end;

  if not IsMobileNumber(GetOnlyNumber(KeyInLabel.Caption)) then
  begin
    CloseTimer.Enabled := true;
    Common.MsgBox('전화번호가 올바르지 않습니다');
    Exit;
  end;
  Common.WriteLog('work', Format('전화번호 : %s', [GetOnlyNumber(KeyInLabel.Caption)]));
  ModalResult := mrOK;
end;

procedure TKioskPhoneKeyPad_F.AgreeButtonClick(Sender: TObject);
begin
  if AgreeButton.Tag = 0 then
  begin
    AgreeButton.Tag := 1;
    AgreeButton.Picture.Assign(ImageCollection.Items[1].Picture.Graphic);
  end
  else
  begin
    AgreeButton.Tag := 0;
    AgreeButton.Picture.Assign(ImageCollection.Items[0].Picture.Graphic);
  end;
end;

procedure TKioskPhoneKeyPad_F.BSButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');

  KeyInLabel.Hint    := LeftStr(KeyInLabel.Hint, Length(KeyInLabel.Hint)-1);
  KeyInLabel.Caption := GetPhoneFormat(KeyInLabel.Hint);
end;

procedure TKioskPhoneKeyPad_F.CancelButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  ModalResult := mrNo;
end;

procedure TKioskPhoneKeyPad_F.ClearButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  KeyInLabel.Hint    := '010';
  KeyInLabel.Caption := '010';
end;

procedure TKioskPhoneKeyPad_F.CloseButtonClick(Sender: TObject);
begin
  if not Common.AskBox('휴대폰번호 입력없이'#13'주문 하시겠습니까?') then
  begin
     Common.DoModalClose;
     ModalResult := mrNo;
  end
  else
  begin
    Common.MsgBox('출력되는 영수증에 호출번호를'#13'꼭'#13'확인해주세요');
    ModalResult := mrYes;
  end;
end;

procedure TKioskPhoneKeyPad_F.CloseTimerTimer(Sender: TObject);
begin
  CloseTimer.Tag := CloseTimer.Tag + 1;
  if CloseTimer.Tag > 60 then
  begin
    CloseTimer.Enabled := false;
    Close;
  end
  else
    CancelButton.Status.Caption := IntToStr(60-CloseTimer.Tag);
end;

procedure TKioskPhoneKeyPad_F.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CloseTimer.Enabled := false;
end;

procedure TKioskPhoneKeyPad_F.ScannerReadEvent(const S: String);
begin
  KeyInLabel.Hint := S;
  KeyInLabel.Caption := KeyInLabel.Hint;
end;

procedure TKioskPhoneKeyPad_F.ShowTimerTimer(Sender: TObject);
begin
  if AgreeLabel.Style.TextColor = clBlack then
    AgreeLabel.Style.TextColor := clSkyBlue
  else
    AgreeLabel.Style.TextColor := clBlack;
end;

end.



















