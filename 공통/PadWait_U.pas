unit PadWait_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, cxControls,
  cxContainer, cxEdit, cxLabel, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, PosCard, AdvSmoothButton, AdvGlassButton;

type
  TPadWait_F = class(TForm)
    Shape1: TShape;
    lblMsg: TcxLabel;
    EndTimer: TTimer;
    StartTimer: TTimer;
    cxLabel1: TcxLabel;
    CancelButton: TAdvSmoothButton;
    procedure FormShow(Sender: TObject);
    procedure EndTimerTimer(Sender: TObject);
    procedure StartTimerTimer(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    Msg     :String;
    SendMsg :String;
  end;

var
  PadWait_F: TPadWait_F;

implementation
uses Common_U, Const_U, GlobalFunc_U, Member_U, CashRcp_U, MemberAdd_U;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TPadWait_F.FormShow(Sender: TObject);
begin
  Common.SetButtonColor(CancelButton);
  CancelButton.Visible := true;
  BlockInput(false);
  lblMsg.Caption := Msg;
  Msg := EmptyStr;
end;

procedure TPadWait_F.CancelButtonClick(Sender: TObject);
begin
  try
    Common.Device.SendToPad(#2+'cancel'+#2);
    if Assigned(MemberAdd_F) and MemberAdd_F.Showing then
    begin
      MemberAdd_F.PinPadButton.Tag := 0;
    end
    else if Assigned(Member_F) and Member_F.Showing then
    begin
      Member_F.PinPadButton.Tag := 0;
    end;
  except
  end;
  Close;
end;

procedure TPadWait_F.EndTimerTimer(Sender: TObject);
begin
  EndTimer.Enabled := false;
  Close;
end;

procedure TPadWait_F.StartTimerTimer(Sender: TObject);
begin
  StartTimer.Enabled := false;
  if not Common.Device.SendToPad(SendMsg) then
    Close;
end;

end.

















