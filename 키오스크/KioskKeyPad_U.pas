unit KioskKeyPad_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxLabel, StrUtils,
  MaskUtils, MMSystem, cxImage, AdvSmoothButton, AdvSmoothToggleButton;

type
  TKioskKeyPad_F = class(TForm)
    KeyInLabel: TcxLabel;
    MessageLabel: TcxLabel;
    CloseTimer: TTimer;
    OKButton: TAdvSmoothButton;
    Num9Button: TAdvSmoothToggleButton;
    Num6Button: TAdvSmoothToggleButton;
    Num3Button: TAdvSmoothToggleButton;
    ClearButton: TAdvSmoothToggleButton;
    AdvSmoothToggleButton4: TAdvSmoothToggleButton;
    Num2Button: TAdvSmoothToggleButton;
    Num5Button: TAdvSmoothToggleButton;
    Num8Button: TAdvSmoothToggleButton;
    BSButton: TAdvSmoothToggleButton;
    Num1Button: TAdvSmoothToggleButton;
    Num4Button: TAdvSmoothToggleButton;
    Num7Button: TAdvSmoothToggleButton;
    CancelButton: TAdvSmoothToggleButton;
    AdvSmoothButton1: TAdvSmoothButton;
    Shape1: TShape;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NumBSButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure CloseTimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BSButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure Num1ButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    function  GetPhoneFormat(aStr :String):String;        //전화번호에 하이픈넣기
    function  GetPassword(aStr:String):String;
    procedure ScannerReadEvent(const S : String);
  public
    isPhoneNumber :Boolean;
    isPassword    :Boolean;
  end;

var
  KioskKeyPad_F: TKioskKeyPad_F;

implementation
uses Common_U, Const_U;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TKioskKeyPad_F.FormCreate(Sender: TObject);
var vIndex :Integer;
begin
  Common.LogoCreate(Self,0);
  if Common.Config.BarrierFreeMode = bfWheelChair then
  begin
    Self.Position := poDesigned;
    Self.Width    := 563;
    Self.Top      := Screen.Height - Self.Height;
    Self.Left     := Screen.Width div 2 - Self.ClientWidth div 2;
  end;

  Common.SetButtonColor(OKButton);
  Common.SetKioskButton(CancelButton);
  Common.SetKioskButton(OKButton);
  DoubleBuffered := true;
  isPassword := false;
end;

procedure TKioskKeyPad_F.FormShow(Sender: TObject);
begin
  BlockInput(false);
  MessageLabel.Caption := Common.GetPaPago(MessageLabel.Caption);
  OKButton.Caption     := Common.GetPaPago('확인');
  CancelButton.Caption := Common.GetPaPago('취소');
  Common.Device.OnScannerReadData := ScannerReadEvent;
  if isPhoneNumber then
  begin
    KeyInLabel.Hint    := '010';
    KeyInLabel.Caption := '010';
    Common.KioskTouchBeep('mobileno')
  end;
  CloseTimer.Tag := 0;
end;

procedure TKioskKeyPad_F.Num1ButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  KeyInLabel.Hint    := KeyInLabel.Hint + (Sender as TAdvSmoothToggleButton).Caption;
  if isPhoneNumber then
    KeyInLabel.Caption := GetPhoneFormat(KeyInLabel.Hint)
  else if isPassword then
    KeyInLabel.Caption := GetPassword(KeyInLabel.Hint)
  else
    KeyInLabel.Caption := KeyInLabel.Hint;
end;

procedure TKioskKeyPad_F.NumBSButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');

  KeyInLabel.Hint    := LeftStr(KeyInLabel.Hint, Length(KeyInLabel.Hint)-1);
  if isPhoneNumber then
    KeyInLabel.Caption := GetPhoneFormat(KeyInLabel.Hint)
  else if isPassword then
    KeyInLabel.Caption := GetPassword(KeyInLabel.Hint)
  else
    KeyInLabel.Caption := KeyInLabel.Hint;
end;

function  TKioskKeyPad_F.GetPhoneFormat(aStr :String):String;        //전화번호에 하이픈넣기
var vTemp :String;
begin
  vTemp := aStr;
  if Length(vTemp) < 16 then
    KeyInLabel.Style.Font.Size := 33
  else
    KeyInLabel.Style.Font.Size := 26;
  case Length(vTemp) of
     4 : Result := FormatMaskText('!000-0;0; ',vTemp);
     5 : Result := FormatMaskText('!000-00;0; ',vTemp);
     6 : Result := FormatMaskText('!000-000;0; ',vTemp);
     7 : Result := FormatMaskText('!000-0000;0; ',vTemp);
     8 : Result := FormatMaskText('!000-0000-0;0; ',vTemp);
     9 : Result := FormatMaskText('!000-0000-00;0; ',vTemp);
    11 : Result := FormatMaskText('!000-0000-0000;0; ',vTemp);
    16 : Result := FormatMaskText('!0000-0000-0000-0000;0; ',vTemp);
    else Result := aStr;
  end;
end;


function TKioskKeyPad_F.GetPassword(aStr: String): String;
var vIndex :Integer;
begin
  Result := EmptyStr;
  for vIndex := 1 to Length(aStr) do
    Result := Result + '*';
end;

procedure TKioskKeyPad_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    OKButtonClick(nil)
  else if Key = VK_ESCAPE then
    Close;
end;

procedure TKioskKeyPad_F.FormKeyPress(Sender: TObject; var Key: Char);
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

  if isPhoneNumber then
    KeyInLabel.Caption := GetPhoneFormat(KeyInLabel.Hint)
  else if isPassword then
    KeyInLabel.Caption := GetPassword(KeyInLabel.Hint)
  else
    KeyInLabel.Caption := KeyInLabel.Hint;
end;

procedure TKioskKeyPad_F.OKButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  ModalResult := mrOK;
end;

procedure TKioskKeyPad_F.BSButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');

  KeyInLabel.Hint    := LeftStr(KeyInLabel.Hint, Length(KeyInLabel.Hint)-1);
  if isPhoneNumber then
    KeyInLabel.Caption := GetPhoneFormat(KeyInLabel.Hint)
  else if isPassword then
    KeyInLabel.Caption := GetPassword(KeyInLabel.Hint)
  else
    KeyInLabel.Caption := KeyInLabel.Hint;
end;

procedure TKioskKeyPad_F.CancelButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  Close;
end;

procedure TKioskKeyPad_F.ClearButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  if isPhoneNumber then
  begin
    KeyInLabel.Hint    := '010';
    KeyInLabel.Caption := '010';
  end
  else
  begin
    KeyInLabel.Hint    := EmptyStr;
    KeyInLabel.Caption := EmptyStr;
  end;
end;

procedure TKioskKeyPad_F.CloseTimerTimer(Sender: TObject);
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

procedure TKioskKeyPad_F.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CloseTimer.Enabled := false;
end;

procedure TKioskKeyPad_F.ScannerReadEvent(const S: String);
begin
  KeyInLabel.Hint := S;
  KeyInLabel.Caption := KeyInLabel.Hint;
end;

end.



















