unit KioskFinish_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, OXSpeedButton, cxLabel, AdvSmoothButton, ExtCtrls,
  MMSystem;

type
  TKioskFinish_F = class(TForm)
    obtn_yes: TOXSpeedButton;
    obtn_no: TOXSpeedButton;
    procedure obtn_YesClick(Sender: TObject);
    procedure obtn_NoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  KioskFinish_F: TKioskFinish_F;

implementation
uses Common_U;
{$R *.dfm}

procedure TKioskFinish_F.obtn_YesClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  ModalResult := mrOK;
end;

procedure TKioskFinish_F.obtn_NoClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  ModalResult := mrNo;
end;

procedure TKioskFinish_F.FormCreate(Sender: TObject);
var vGap,
    vWidth,
    vHeight :Integer;
begin
  if FileExists(Common.AppPath+'\Kiosk\결제완료배경.jpg') then
  begin
    with TImage.Create(Self) do
    begin
      Parent := Self;
      Picture.Bitmap.TransparentColor := clNone;
      Picture.LoadFromFile(Common.AppPath+'\Kiosk\결제완료배경.jpg');
      SendToBack;
      Self.ClientHeight := Picture.Height;
      Self.ClientWidth  := Picture.Width;
      Align             := alClient;
      Transparent       := true;
    end;
  end;

  if FileExists(Common.AppPath+'\Kiosk\예.jpg') then
  begin
    Common.SetOXSpeedButtonImage(obtn_yes, Common.AppPath+'\Kiosk\예.jpg');

    with TPicture.Create do
    try
      LoadFromFile(Common.AppPath+'\Kiosk\예.jpg');
      vWidth  := Width;
      vHeight := Height;
    finally
      Free;
    end;

    obtn_yes.Width  := vWidth;
    obtn_yes.Height := vHeight;
  end;

  if FileExists(Common.AppPath+'\Kiosk\아니오.jpg') then
  begin
    Common.SetOXSpeedButtonImage(obtn_no, Common.AppPath+'\Kiosk\아니오.jpg');

    with TPicture.Create do
    try
      LoadFromFile(Common.AppPath+'\Kiosk\아니오.jpg');
      vWidth  := Width;
      vHeight := Height;
    finally
      Free;
    end;

    obtn_no.Width  := vWidth;
    obtn_no.Height := vHeight;
  end;

  //버튼 위치 조정
  vGap  := (Self.Width - vWidth * 2) div 3;
  obtn_yes.Left      := vGap;
  obtn_no.Left := obtn_yes.Left + vWidth + vGap;
end;

end.
