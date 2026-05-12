unit WaitMsg_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, cxControls,
  cxContainer, cxEdit, cxLabel, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, PosCard, AdvSmoothButton, AdvGlassButton;

type
  TWaitMsg_F = class(TForm)
    Shape1: TShape;
    lblMsg: TcxLabel;
    CancelButton: TAdvSmoothButton;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    Msg :String;
    ShowButton :Boolean;
  end;

var
  WaitMsg_F: TWaitMsg_F;

implementation
uses Common_U, Const_U, GlobalFunc_U;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TWaitMsg_F.FormShow(Sender: TObject);
begin
  if not Assigned(Common) then Exit;
  Common.SetButtonColor(CancelButton);
  if Common.Config.isKiosk then
  begin
    Self.Width  := 600;
    lblMsg.Style.Font.Size := 25;
    CancelButton.Appearance.Font.Size := 15;
    CancelButton.Top     := 110;
    CancelButton.Left    := 200;
    CancelButton.Width   := 180;
    CancelButton.Height  := 65;
    CancelButton.Caption := '요청취소';
  end;

  CancelButton.Visible := ShowButton;

  if not ShowButton then
  begin
    if not Common.Config.isKiosk then
    begin
      Self.Height := 100;
      lblMsg.Top  := 2;
    end
    else
    begin
      Self.Height := 150;
      lblMsg.Top  := 30;
    end;
  end
  else
  begin
    BlockInput(false);
    if not Common.Config.isKiosk then
      Self.Height := 210
    else
      Self.Height := 250;
    lblMsg.Top  := 2;
  end;

  if Msg <> EmptyStr then
  begin
    lblMsg.Caption := Msg;
    Msg := EmptyStr;
  end
  else
    lblMsg.Caption  := Common.GetPapago('처리 중 입니다....'#13'잠시만 기다려 주세요');

  Msg := EmptyStr;
end;

procedure TWaitMsg_F.CancelButtonClick(Sender: TObject);
begin
  case Common.Config.van_trd of
    vanKFTC:
    begin
      if (GetOption(379)='0') then
      begin
        Common.ICCard.AppType    := atICInit;
        Common.ICCard.Execute;
      end;
    end;
    vanNice:
    begin
      if GetOption(379)='2' then
        Common.ICCard.CancelNiceVCat
      else if GetOption(379)='1' then
        Common.ICCard.CancelNiceCat;
    end;
  end;
  WaitMsg_F.Hide;
end;

procedure TWaitMsg_F.FormHide(Sender: TObject);
begin
  if not Assigned(Common) then Exit;

  lblMsg.Caption  := Common.GetPapago('처리 중 입니다....'#13'잠시만 기다려 주세요');
end;

end.

