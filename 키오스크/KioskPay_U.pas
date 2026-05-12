unit KioskPay_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvSmoothToggleButton, AdvSmoothButton,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxLabel, Vcl.ExtCtrls, AdvPanel, AdvShape;

type
  TKioskPay_F = class(TForm)
    KioskCardButton: TAdvSmoothButton;
    CancelButton: TAdvSmoothToggleButton;
    CloseTimer: TTimer;
    KioskCashButton: TAdvSmoothButton;
    KioskEasyPayButton: TAdvSmoothButton;
    HeaderPanel: TAdvPanel;
    lblTitle: TcxLabel;
    procedure FormCreate(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure KioskCardButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    ResultPay :Integer;
  end;

var
  KioskPay_F: TKioskPay_F;

implementation
uses Common_U, GlobalFunc_U, Const_U;
{$R *.dfm}

procedure TKioskPay_F.CancelButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  CloseTimer.Enabled := false;
  Close;
end;

procedure TKioskPay_F.CloseTimerTimer(Sender: TObject);
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

procedure TKioskPay_F.FormCreate(Sender: TObject);
begin
  BlockInput(false);
  Common.LogoCreate(Self,0);

  if Common.Config.BarrierFreeMode = bfWheelChair then
  begin
    Self.Position := poDesigned;
    Self.ClientWidth    := 1000;
    Self.Top      := ((Screen.Height - Common.Config.BarrierTop) div 2) - (Self.ClientHeight div 2) + Common.Config.BarrierTop;
    Self.Left     := Screen.Width div 2 - Self.ClientWidth div 2;
  end;

  HeaderPanel.Color         := $00FFC184;
  HeaderPanel.ColorMirror   := $00CC6600;
  HeaderPanel.ColorMirrorTo := $00F07800;
  HeaderPanel.ColorTo       := $00F07800;
  lblTitle.Style.TextColor    := clWhite;

  if GetOption(458) = '2' then
  begin
    HeaderPanel.Color         := $004C4C4C;
    HeaderPanel.ColorMirror   := $004C4C4C;
    HeaderPanel.ColorMirrorTo := $003B3B3B;
    HeaderPanel.ColorTo       := $003B3B3B;
    lblTitle.Style.TextColor    := clWhite;
  end
  else if GetOption(458) = '3' then
  begin
    HeaderPanel.Color         := $000000FB;
    HeaderPanel.ColorMirror   := $000000CC;
    HeaderPanel.ColorMirrorTo := $002222FF;
    HeaderPanel.ColorTo       := $002222FF;
    lblTitle.Style.TextColor    := clWhite;
  end
  else if GetOption(458) = '4' then
  begin
    HeaderPanel.Color         := $0059B300;
    HeaderPanel.ColorMirror   := $00448800;
    HeaderPanel.ColorMirrorTo := $00408000;
    HeaderPanel.ColorTo       := $00408000;
    lblTitle.Style.TextColor    := clWhite;
  end;

  Common.SetButtonColor(KioskCashButton);
  Common.SetButtonColor(KioskCardButton);
  Common.SetButtonColor(KioskEasyPayButton);

  Common.SetKioskButton(KioskCashButton);
  Common.SetKioskButton(KioskCardButton);
  Common.SetKioskButton(KioskEasyPayButton);
  Common.SetKioskButton(CancelButton);

  if not Common.Config.IsKioskCash then
  begin
     Self.ClientHeight       := 700;
     KioskEasyPayButton.Top  := KioskCashButton.Top;
     KioskEasyPayButton.Left := KioskCashButton.Left;
     KioskCashButton.Visible := false;
  end;


  KioskCashButton.Caption     := Common.GetPaPago('현금결제');
  KioskEasyPayButton.Caption  := Common.GetPaPago('간편결제');
  KioskCardButton.Caption     := Common.GetPaPago('신용카드');
  CancelButton.Caption        := Common.GetPaPago('나가기');
end;

procedure TKioskPay_F.FormShow(Sender: TObject);
begin
  CloseTimer.Tag := 0;
  CloseTimer.Enabled := true;
end;

procedure TKioskPay_F.KioskCardButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  CloseTimer.Enabled := false;
  ResultPay   := (Sender as TAdvSmoothButton).Tag;
  ModalResult := mrOK;
end;

end.
