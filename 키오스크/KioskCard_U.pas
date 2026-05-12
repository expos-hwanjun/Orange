unit KioskCard_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxGDIPlusClasses, PosCard, jpeg, ExtCtrls, MMSystem,
  cxClasses, cxImage;
type
  TKioskCard_F = class(TForm)
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    TimeOutTimer: TTimer;
    ImageCollection: TcxImageCollection;
    ImageCollectionItem1: TcxImageCollectionItem;
    ImageCollectionItem2: TcxImageCollectionItem;
    procedure MainImageClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure TimeOutTimerTimer(Sender: TObject);
  private
  public
  end;

var
  KioskCard_F: TKioskCard_F;

implementation
uses Common_U, Const_U, GlobalFunc_U;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TKioskCard_F.FormCreate(Sender: TObject);
begin
  if not Common.isFallBack then
  begin
    PlaySound(nil, 0, SND_MEMORY or SND_ASYNC);
    PlaySound(PChar('CardWave'), Common.DllHandle, SND_RESOURCE or SND_ASYNC);

    with TcxImage.Create(Self) do
    begin
      Parent := Self;
      Align := alClient;
      Picture.Bitmap.TransparentColor := clNone;
      if FileExists(Common.AppPath+'\Kiosk\신용카드화면.png') then
        Picture.LoadFromFile(Common.AppPath+'\Kiosk\신용카드화면.png')
      else
        Picture.Assign(ImageCollection.Items[0].Picture);
//      Transparent  := true;
      Self.Width   := Picture.Width;
      Self.Height  := Picture.Height;
      OnClick      := MainImageClick;
      SendToBack;
    end;
  end
  else
  begin
    PlaySound(nil, 0, SND_MEMORY or SND_ASYNC);
    if Common.isCashRecieptCard then
      PlaySound(PChar('kioskwave4'), Common.DllHandle, SND_RESOURCE or SND_ASYNC)
    else
      PlaySound(PChar('FallBackWave'), Common.DllHandle, SND_RESOURCE or SND_ASYNC);

    with TcxImage.Create(Self) do
    begin
      Parent := Self;
      Align := alClient;
      if FileExists(Common.AppPath+'\Kiosk\FallBack.png') then
        Picture.LoadFromFile(Common.AppPath+'\Kiosk\FallBack.png')
      else
        Picture.Assign(ImageCollection.Items[1].Picture);

      Self.Width   := Picture.Width;
      Self.Height  := Picture.Height;
      OnClick := MainImageClick;
      SendToBack;
      TimeOutTimer.Tag     :=  0;
      TimeOutTimer.Enabled := true;
    end;
  end;
end;

procedure TKioskCard_F.FormShow(Sender: TObject);
begin
  BlockInput(false);
  Self.Top   := Trunc(Screen.Height / 2 - Self.Height / 2);
  Self.Left  := Trunc(Screen.Width / 2 - Self.Width / 2);
end;


procedure TKioskCard_F.MainImageClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  case Common.Config.van_trd of
    vanKFTC:
    begin
      Common.ICCard.AppType    := atICInit;
      Common.ICCard.Execute;
    end;
    vanNice:
    begin
      if GetOption(379)='2' then
        Common.ICCard.CancelNiceVCat;
    end;
    vanJTNET, vanKSNET:
    begin
      Keybd_Event(VK_ESCAPE, VK_ESCAPE, 0, 0);
    end;
  end;
  Close;
end;


procedure TKioskCard_F.FormResize(Sender: TObject);
begin
  Self.Top   := Trunc(Screen.Height / 2 - Self.Height / 2);
  Self.Left  := Trunc(Screen.Width / 2 - Self.Width / 2);
end;

procedure TKioskCard_F.TimeOutTimerTimer(Sender: TObject);
begin
  TimeOutTimer.Enabled := false;
  if TimeOutTimer.Tag > 60 then
  begin
    MainImageClick(nil);
  end
  else
  begin
     TimeOutTimer.Tag     :=  TimeOutTimer.Tag + 1;
     TimeOutTimer.Enabled := true;
  end;
end;

end.
