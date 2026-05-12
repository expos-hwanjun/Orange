unit QuesMsg_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, OleCtrls, GraphicEx,
  cxControls, cxContainer, cxEdit, cxLabel, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, StrUtils, AdvGlassButton, frmshape,
  AdvSmoothToggleButton, AdvSmoothButton, dxGDIPlusClasses, cxImage;

type
  TQuesMsg_F = class(TForm)
    CloseTimer: TTimer;
    AskTimer: TTimer;
    MessageLabel: TcxLabel;
    OutLineShape: TShape;
    YesButton: TAdvSmoothButton;
    NoButton: TAdvSmoothButton;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CloseTimerTimer(Sender: TObject);
    procedure AskTimerTimer(Sender: TObject);
    procedure NoButtonClick(Sender: TObject);
    procedure YesButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    CloseTime :Integer;
    isPadAsk  :Boolean;
  public
    MsgText   : String;
    TimeOut   : Integer;
  end;
var
  QuesMsg_F: TQuesMsg_F;

implementation
uses Common_U, Const_U, Main_U;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TQuesMsg_F.FormShow(Sender: TObject);
begin
  BlockInput(false);
  {디스플레이될 메시지 내용 세팅}
  MessageLabel.Caption   := Common.GetPapago(msgText);
  if (msgText = '정산이 완료됐습니다') then
  begin
    TimeOut        := 3;
    CloseTime      := 0;
    CloseTimer.Enabled := True;
    MessageLabel.Caption := Common.GetPapago(msgText) + #13#13+ '( 3 )';
  end
  else if TimeOut > 0 then
  begin
    CloseTime      := 0;
    CloseTimer.Enabled := True;
    MessageLabel.Caption := Common.GetPapago(msgText) + #13#13+ Format('( %d )',[TimeOut]);
  end;

  if msgText = '영수증을 출력하시겠습니까?' then
    isPadAsk := true
  else
    isPadAsk := false;

  YesButton.Caption := Common.GetPaPago(YesButton.Caption);
  NoButton.Caption  := Common.GetPaPago(NoButton.Caption);

//  if Assigned(Main_F) then
//  begin
//    with TImage.Create(Self) do
//    begin
//      Parent := Self;
//      Top    := 1;
//      Left   := 1;
//      Height := 49;
//      Width  := 119;
//      Picture.Assign(Main_F.ImageCollection.Items.Items[1].Picture.Graphic);
//      BringToFront;
//      Refresh;
//    end;
//  end;
  SetForegroundWindow(Handle);
end;

procedure TQuesMsg_F.NoButtonClick(Sender: TObject);
begin
   ModalResult := mrCancel;
   if Common.Config.SmartPad and isPadAsk then
     Common.Device.SendToPad(#2+'cancel'+#2+'N');
end;

procedure TQuesMsg_F.FormCreate(Sender: TObject);
begin
  Common.SetButtonColor(YesButton);
//  Common.SetButtonColor(NoButton);
end;

procedure TQuesMsg_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN : YesButtonClick(YesButton);
    VK_ESCAPE : NoButtonClick(NoButton);
  end;
end;

procedure TQuesMsg_F.CloseTimerTimer(Sender: TObject);
begin
  Inc(CloseTime);
  if CloseTime > TimeOut then
     Close;
  MessageLabel.Caption := Common.GetPapago(msgText) + #13#13+ '( '+IntToStr(TimeOut-CloseTime)+' )';
end;

procedure TQuesMsg_F.YesButtonClick(Sender: TObject);
begin
  ModalResult := mrOK;
  if Common.Config.SmartPad and isPadAsk then
    Common.Device.SendToPad(#2+'cancel'+#2+'N');
end;

procedure TQuesMsg_F.AskTimerTimer(Sender: TObject);
begin
  AskTimer.Enabled := false;
  if AskTimer.Tag = 0 then
    ModalResult := mrOK
  else
    ModalResult := mrCancel;
end;

end.




