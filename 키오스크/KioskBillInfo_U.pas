unit KioskBillInfo_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxGDIPlusClasses, cxImage, PosCard, jpeg, cxLabel,
  ExtCtrls, Inifiles, MMSystem, PNGImage, StrUtils;
type
  TKioskBillInfo_F = class(TForm)
    OrderNoLabel: TcxLabel;
    CloseTimer: TTimer;
    Msg2Label: TcxLabel;
    LogoImage: TcxImage;
    Msg1Label: TcxLabel;
    OrderTypeLabel: TcxLabel;
    Msg3Label: TcxLabel;
    Msg4Label: TcxLabel;
    procedure MainImageClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
  end;

var
  KioskBillInfo_F: TKioskBillInfo_F;

implementation
uses Common_U, Const_U, GlobalFunc_U;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TKioskBillInfo_F.MainImageClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  CloseTimer.Enabled := false;
  Close;
end;

procedure TKioskBillInfo_F.FormCreate(Sender: TObject);
var vColor,
    vMsg1,
    vMsg2,
    vMsg3,
    vMsg4 :String;
    vPNG :TPNGImage;
    vWidth :Integer;
begin
  Common.LogoCreate(Self,0);
  if FileExists(Common.AppPath+'Kiosk\Logo.png') then
  begin
    vPNG := TPNGImage.Create;
    try
      vPNG.LoadFromFile(Common.AppPath+'Kiosk\Logo.png');
      vWidth := vPNG.Width;
    finally
      vPNG.Free;
    end;
    LogoImage.AutoSize := true;
    LogoImage.Picture.Graphic.LoadFromFile(Common.AppPath+'Kiosk\Logo.png');
    LogoImage.Left := Self.Width div 2 - LogoImage.Width div 2;
  end;

  with TIniFile.Create(Common.AppPath+'Kiosk\KioskConfig.ini') do
    try
      vColor := ReadString('주문완료', 'FontColor', '');
      vMsg1  := ReadString('주문완료', '메세지1', '매장이용/포장 주문이 완료 되었습니다');
      vMsg2  := ReadString('주문완료', '메세지2', '주문하신 메뉴가 준비되면');
      vMsg3  := ReadString('주문완료', '메세지3', '안내해 드리겠습니다');
      vMsg4  := ReadString('주문완료', '메세지4', '');
      if vColor = '' then
      WriteString('주문완료', 'FontColor', '$00373737');
    finally
      Free;
    end;

  if vColor <> '' then
  begin
    Msg1Label.Style.TextColor      := StringToColor(vColor);
    Msg2Label.Style.TextColor      := StringToColor(vColor);
    Msg3Label.Style.TextColor      := StringToColor(vColor);
    Msg4Label.Style.TextColor      := StringToColor(vColor);
    OrderTypeLabel.Style.TextColor := StringToColor(vColor);
    OrderNoLabel.Style.TextColor   := StringToColor(vColor);
  end;

  if  Pos('매장이용/포장', vMsg1) > 0 then
    vMsg1 := Replace(vMsg1, '매장이용/포장', Ifthen(Common.Table.Packing='Y','[포장]','[매장이용]'));

  Msg1Label.Caption := Common.GetPaPago(vMsg1);
  Msg2Label.Caption := Common.GetPaPago(vMsg2);
  Msg3Label.Caption := Common.GetPaPago(vMsg3);
  Msg4Label.Caption := Common.GetPaPago(vMsg4);


  Msg1Label.Style.Font.Name      := Common.Config.KioskDefaultFontName;
  Msg2Label.Style.Font.Name      := Common.Config.KioskDefaultFontName;
  Msg3Label.Style.Font.Name      := Common.Config.KioskDefaultFontName;
  Msg4Label.Style.Font.Name      := Common.Config.KioskDefaultFontName;
  OrderTypeLabel.Style.Font.Name := Common.Config.KioskDefaultFontName;

  if (GetOption(311)='1') and (Common.PreSent.CallNo > 0) then
  begin
    OrderTypeLabel.Caption := '호출번호';
    OrderNoLabel.Caption := IntToStr(Common.PreSent.CallNo);
  end
  else
  begin
    OrderTypeLabel.Caption := '주문번호';
    OrderNoLabel.Caption := IntToStr(Common.Table.OrderNo);
  end;

  OrderNoLabel.Caption := IntToStr(Common.PreSent.CallNo);
  OrderTypeLabel.Caption := Common.GetPaPago(OrderTypeLabel.Caption);
end;

procedure TKioskBillInfo_F.CloseTimerTimer(Sender: TObject);
begin
  CloseTimer.Tag := CloseTimer.Tag + 1;
  if CloseTimer.Tag < 5 then Exit;

  CloseTimer.Enabled := false;
  Close;
end;

procedure TKioskBillInfo_F.FormShow(Sender: TObject);
begin
  BlockInput(false);
  CloseTimer.Tag     := 0;
  CloseTimer.Enabled := true;
end;

procedure TKioskBillInfo_F.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CloseTimer.Enabled := false;
end;

end.
