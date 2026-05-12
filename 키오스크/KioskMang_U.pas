unit KioskMang_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OXSpeedButton, TFlatSpeedButtonUnit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxLabel,
  Menus, StdCtrls, cxButtons, AdvSmoothButton, ExtCtrls, jpeg;

type
  TKioskMang_F = class(TForm)
    obtn_Mang: TOXSpeedButton;
    obtn_Close: TOXSpeedButton;
    obtn_Cancel: TOXSpeedButton;
    procedure obtn_CloseClick(Sender: TObject);
    procedure obtn_CancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure obtn_MangClick(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  KioskMang_F: TKioskMang_F;

implementation
uses Common_U;
{$R *.dfm}

procedure TKioskMang_F.obtn_CloseClick(Sender: TObject);
begin
  ModalResult := mrAbort;
end;

procedure TKioskMang_F.obtn_CancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;
                                                                                                
procedure TKioskMang_F.FormShow(Sender: TObject);
begin
  if FileExists(Common.AppPath+'\Kiosk\관리자배경.jpg') then
  begin
    with TImage.Create(Self) do
    begin
      Parent := Self;
      Align := alClient;
      Picture.LoadFromFile(Common.AppPath+'\Kiosk\관리자배경.jpg');
      SendToBack;
    end;
  end;

  if FileExists(Common.AppPath+'\Kiosk\영수증관리.jpg') then
    Common.SetOXSpeedButtonImage(obtn_Mang, Common.AppPath+'\Kiosk\영수증관리.jpg');

  if FileExists(Common.AppPath+'\Kiosk\종료.jpg') then
    Common.SetOXSpeedButtonImage(obtn_Close, Common.AppPath+'\Kiosk\종료.jpg');

  if FileExists(Common.AppPath+'\Kiosk\취소.jpg') then
    Common.SetOXSpeedButtonImage(obtn_Cancel, Common.AppPath+'\Kiosk\취소.jpg');
end;

procedure TKioskMang_F.obtn_MangClick(Sender: TObject);
begin
  if Common.Config.RcpSearchPwd = EmptyStr then
  begin
    Common.MsgBox('관리자 암호가 설정되어 있지 않습니다');
    Exit;
  end;
  ModalResult := mrOK;
end;

end.
