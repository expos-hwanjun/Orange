unit KioskQuesMsg_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, OleCtrls, GraphicEx,
  cxControls, cxContainer, cxEdit, cxLabel, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, StrUtils, AdvSmoothButton, IniFiles, jpeg, MMSystem,
  Vcl.Menus, cxButtons, AdvSmoothToggleButton, dxGDIPlusClasses, cxClasses,
  cxImage;

type
  TKioskQuesMsg_F = class(TForm)
    CloseTimer: TTimer;
    Msg_lbl: TcxLabel;
    NoButton: TAdvSmoothToggleButton;
    YesButton: TAdvSmoothButton;
    ImageCollection: TcxImageCollection;
    ImageCollectionItem1: TcxImageCollectionItem;
    KatalkImage: TcxImage;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CloseTimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure YesButtonClick(Sender: TObject);
    procedure NoButtonClick(Sender: TObject);
  private
  public
    TimeOut   : Integer;
    MsgText   : String;
    FMsgState : Integer;
  end;

var
  KioskQuesMsg_F: TKioskQuesMsg_F;

implementation
uses Common_U, Const_U;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TKioskQuesMsg_F.FormCreate(Sender: TObject);
var vFontName :String;
begin
  if Common.Config.BarrierFreeMode = bfWheelChair then
  begin
    Self.Position := poDesigned;
    Self.ClientWidth    := 1000;
    Self.Top      := ((Screen.Height - Common.Config.BarrierTop) div 2) - (Self.ClientHeight div 2) + Common.Config.BarrierTop;
    Self.Left     := Screen.Width div 2 - Self.ClientWidth div 2;
  end
  else
  begin
    if FileExists(Common.AppPath+'\Kiosk\Message.png') then
    begin
      with TImage.Create(Self) do
      begin
        Parent      := Self;
        Name        := 'MainImage';
        Align       := alClient;
        Picture.LoadFromFile(Common.AppPath+'\Kiosk\Message.png');
        Caption     := EmptyStr;
        SendToBack;
      end;
      Msg_lbl.Transparent := true;
    end
    else
      Common.LogoCreate(Self,0);
  end;

  Common.SetButtonColor(YesButton);

  Common.SetKioskButton(YesButton,'Yes');
  Common.SetKioskButton(NoButton,'No');
  Common.SetKioskButton(Msg_lbl);

  YesButton.Caption  := Common.GetPaPago('예');
  NoButton.Caption   := Common.GetPaPago('아니오');

  with TIniFile.Create(Common.AppPath+'Kiosk\KioskConfig.ini') do
  try
    vFontName := ReadString('공통','FontName','맑은 고딕');
  finally
    Free;
  end;



  Msg_lbl.Style.Font.Name        := vFontName;
  YesButton.Appearance.Font.Name := vFontName;
  NoButton.Appearance.Font.Name  := vFontName;
end;

procedure TKioskQuesMsg_F.FormShow(Sender: TObject);
begin
  BlockInput(false);
  SetForegroundWindow(Handle);
  if NoButton.Visible then
    YesButton.Left    := 130
  else
    YesButton.Left    := (Self.Width - YesButton.Width) div 2;

  if TimeOut = 0 then
    TimeOut := 10;
  if Pos('카카오톡', msgText) > 0 then
    KatalkImage.Visible := true;

  CloseTimer.Tag := 0;
  {디스플레이될 메시지 내용 세팅}
  Msg_lbl.Caption    := Common.GetPaPago(msgText);
end;

procedure TKioskQuesMsg_F.NoButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  ModalResult := mrCancel;
end;

procedure TKioskQuesMsg_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case Key of
      VK_RETURN : YesButton.Click;
      VK_ESCAPE : NoButton.Click;
   end;
end;

procedure TKioskQuesMsg_F.YesButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  ModalResult := mrOK;
end;

procedure TKioskQuesMsg_F.CloseTimerTimer(Sender: TObject);
begin
  CloseTimer.Enabled := false;
  CloseTimer.Tag := CloseTimer.Tag + 1;
  if CloseTimer.Tag > TimeOut then
    Close
  else
  begin
    if NoButton.Visible then
      NoButton.Status.Caption := IntToStr(TimeOut-CloseTimer.Tag)
    else
      YesButton.Status.Caption := IntToStr(TimeOut-CloseTimer.Tag);

    CloseTimer.Enabled := true;
  end;
end;

procedure TKioskQuesMsg_F.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CloseTimer.Enabled := false;
end;

end.
