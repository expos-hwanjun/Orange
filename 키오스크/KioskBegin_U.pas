unit KioskBegin_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OXSpeedButton, ExtCtrls, PNGImage, AdvSmoothButton, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxLabel;
type TSelectMode = (smTwo, smThree, smOrder); //2(매장이용, 포장), 3(매장이용, 전체포장, 일부포장)

type
  TKioskBegin_F = class(TForm)
    CloseTimer: TTimer;
    btnStore: TAdvSmoothButton;
    btnAllPacking: TAdvSmoothButton;
    btnPartPacking: TAdvSmoothButton;
    lblTitle: TcxLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnStoreClick(Sender: TObject);
    procedure btnAllPackingClick(Sender: TObject);
    procedure btnPartPackingClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FSelectMode :TSelectMode;
    procedure SetSelectMode(const Value: TSelectMode);
    property SelectMode:TSelectMode read FSelectMode write SetSelectMode;
  public
    SelMode :TSelectMode;
    ResultData :Integer; //0:매장이용, 1:전체포장, 2:일부포장, 3:주문(매장이용), 4:주문(포장)
  end;

var
  KioskBegin_F: TKioskBegin_F;

implementation
uses Common_U, Order_U, GlobalFunc_U;

{$R *.dfm}

procedure TKioskBegin_F.FormCreate(Sender: TObject);
var vFile :String;
begin
  Common.LogoCreate(Self,0);
  lblTitle.Caption := Common.GetPapago('이용 방법을 선택해 주세요');

  Common.SetButtonColor(btnStore);
  Common.SetButtonColor(btnPartPacking);

//  if FileExists(Common.AppPath+'\Kiosk\'+Common.Config.LanguagePath+'주문시작.png') then
//    vFile := Common.AppPath+'\Kiosk\'+Common.Config.LanguagePath+'주문시작.png'
//  else if GetOption(457) = '0' then
//    vFile := Common.AppPath+'\Kiosk\주문시작.png';
//
//  if (vFile <> '') and FileExists(vFile) then
//  begin
//    with TPicture.Create do
//    try
//      LoadFromFile(vFile);
//      Self.Width  := Width;
//      Self.Height := Height;
//    finally
//      Free;
//    end;
//
//    with TImage.Create(Self) do
//    begin
//      Parent := Self;
//      Stretch  := true;
//      Align  := alClient;
//      Picture.LoadFromFile(vFile);
//      SendToBack;
//    end;
//  end
//  else
//    Common.LogoCreate(Self,0);
end;

procedure TKioskBegin_F.SetSelectMode(const Value: TSelectMode);
var vGap :Integer;
begin
  FSelectMode := Value;
  case FSelectMode of
    smTwo, smOrder :
    begin
      btnStore.Caption      := Common.GetPaPago('매장이용');
      btnAllPacking.Caption := Common.GetPaPago('포장');
      btnPartPacking.Visible := false;

      //버튼 위치 조정
      btnStore.Width      := 370;
      btnAllPacking.Width := 370;
      vGap  := (Self.Width - btnStore.Width * 2) div 3;
      btnStore.Left      := vGap;
      btnAllPacking.Left := btnStore.Left + btnStore.Width + vGap;
    end;
    smThree:
    begin
      btnStore.Caption       := Common.GetPaPago('매장이용');
      btnAllPacking.Caption  := Common.GetPaPago('전체포장');
      btnPartPacking.Caption := Common.GetPaPago('일부포장');

      btnPartPacking.Visible := true;
      //버튼 위치 조정
      vGap  := (Self.Width - btnStore.Width * 3) div 4;
      btnStore.Left       := vGap;
      btnAllPacking.Left  := btnStore.Left + btnStore.Width + vGap;
      btnPartPacking.Left := btnAllPacking.Left + btnStore.Width + vGap;
    end;
  end;
end;

procedure TKioskBegin_F.btnStoreClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  case SelectMode of
    smTwo,
    smThree : ResultData := 0;
    smOrder : ResultData := 3;
  end;
  ModalResult := mrOK;
end;

procedure TKioskBegin_F.btnAllPackingClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  case SelectMode of
    smTwo,
    smThree : ResultData := 1;
    smOrder : ResultData := 4;
  end;
  ModalResult := mrOK;
end;

procedure TKioskBegin_F.btnPartPackingClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  case SelectMode of
    smTwo   : ResultData := 1;
    smThree : ResultData := 2;    
  end;
  ModalResult := mrOK;
end;

procedure TKioskBegin_F.FormShow(Sender: TObject);
begin
  SelectMode := SelMode;
  if SelectMode in [smTwo, smThree] then
  begin
    Common.KioskTouchBeep('kioskwave13');
    CloseTimer.Enabled := true;
  end;
end;

procedure TKioskBegin_F.CloseTimerTimer(Sender: TObject);
begin
  CloseTimer.Enabled := false;
  Close;
end;

procedure TKioskBegin_F.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CloseTimer.Enabled := false;
end;

end.
