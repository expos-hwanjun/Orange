unit KioskEasyPay_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxGDIPlusClasses, PosCard, jpeg, ExtCtrls, MMSystem,
  cxLabel, AdvSmoothToggleButton, IniFiles;
type
  TKioskEasyPay_F = class(TForm)
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    CloseTimer: TTimer;
    MessageLabel: TcxLabel;
    CancelButton: TAdvSmoothToggleButton;
    procedure MainImageClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CancelButtonClick(Sender: TObject);
  private
    procedure ScannerReadEvent(const S : String);
  public
    PayCode :String;
  end;

var
  KioskEasyPay_F: TKioskEasyPay_F;

implementation
uses Common_U, Const_U, GlobalFunc_U;
{$R *.dfm}

procedure TKioskEasyPay_F.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TKioskEasyPay_F.FormCreate(Sender: TObject);
var vFontName :String;
begin
  Common.LogoCreate(Self,0);
  Common.KioskTouchBeep('qrbarcode');

  if Common.Config.BarrierFreeMode = bfWheelChair then
  begin
    Self.Position := poDesigned;
    Self.ClientWidth    := 793;
    Self.Top      := ((Screen.Height - Common.Config.BarrierTop) div 2) - (Self.ClientHeight div 2) + Common.Config.BarrierTop;
    Self.Left     := Screen.Width div 2 - Self.ClientWidth div 2;
    MessageLabel.Caption := Common.GetPaPago('QR 또는 바코드를 읽혀주세요');
  end
  else
  begin
    if FileExists(Common.AppPath+'\Kiosk\간편결제화면.png') then
    begin
      MessageLabel.Visible := false;
      with TImage.Create(Self) do
      begin
        Parent := Self;
        Align := alClient;
        Picture.Bitmap.TransparentColor := clNone;
        Picture.LoadFromFile(Common.AppPath+'\Kiosk\간편결제화면.png');
        Transparent  := true;
        Self.Width   := Picture.Width;
        Self.Height  := Picture.Height;
        OnClick := MainImageClick;
        SendToBack;
      end;
    end
    else
      MessageLabel.Caption := Common.GetPaPago('QR 또는 바코드를 읽혀주세요');
  end;

  CancelButton.Caption   := Common.GetPaPago('아니오');

  with TIniFile.Create(Common.AppPath+'Kiosk\KioskConfig.ini') do
  try
    vFontName := ReadString('공통','FontName','맑은 고딕');
  finally
    Free;
  end;

  CancelButton.Appearance.Font.Name := vFontName;
  MessageLabel.Style.Font.Name      := vFontName;
end;

procedure TKioskEasyPay_F.FormShow(Sender: TObject);
begin
  BlockInput(false);
  Self.Top   := Trunc(Screen.Height / 2 - Self.Height / 2);
  Self.Left  := Trunc(Screen.Width / 2 - Self.Width / 2);
  Common.Device.OnScannerReadData := ScannerReadEvent;
end;


procedure TKioskEasyPay_F.MainImageClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  Close;
end;


procedure TKioskEasyPay_F.ScannerReadEvent(const S: String);
begin
  PayCode     := S;
  ModalResult := mrOK;
end;

procedure TKioskEasyPay_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    ModalResult := mrOK;
  end;
end;

procedure TKioskEasyPay_F.FormKeyPress(Sender: TObject; var Key: Char);
begin
  PayCode := PayCode + Key;
end;

procedure TKioskEasyPay_F.FormResize(Sender: TObject);
begin
  Self.Top   := Trunc(Screen.Height / 2 - Self.Height / 2);
  Self.Left  := Trunc(Screen.Width / 2 - Self.Width / 2);
end;

procedure TKioskEasyPay_F.CloseTimerTimer(Sender: TObject);
begin
  CloseTimer.Tag := CloseTimer.Tag + 1;
  if CloseTimer.Tag > 60 then
  begin
    CloseTimer.Enabled := false;
    MainImageClick(nil);
  end
  else
    CancelButton.Status.Caption := IntToStr(60-CloseTimer.Tag);
end;

end.
