unit SelfWaitInfo_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxLabel, AdvSmoothToggleButton,
  cxTextEdit, dxGDIPlusClasses, Vcl.ExtCtrls, KeyPad_F, AdvSmoothButton,
  Vcl.AppEvnts, StrUtils, cxCheckBox;

type
  TSelfWaitInfo_F = class(TForm)
    fmKeyPad1: TfmKeyPad;
    SaveButton: TAdvSmoothButton;
    ApplicationEvents: TApplicationEvents;
    Tmr_Wait: TTimer;
    GuestEdit: TcxTextEdit;
    TableKeyImage: TImage;
    GuestLabel: TcxLabel;
    cxLabel1: TcxLabel;
    Num_0: TAdvSmoothToggleButton;
    procedure FormCreate(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure Tmr_WaitTimer(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure Num_0Click(Sender: TObject);
    procedure fmKeyPad1Num_0Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SelfWaitInfo_F: TSelfWaitInfo_F;

implementation
uses Common_U, GlobalFunc_U, DB, DBModule_U, Const_U;

{$R *.dfm}

procedure TSelfWaitInfo_F.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  if (Msg.message = WM_KEYDOWN) or (Msg.message = WM_KEYUP) or (Msg.message = WM_LBUTTONDOWN)  then
    Tmr_Wait.Tag := 0;
end;

procedure TSelfWaitInfo_F.fmKeyPad1Num_0Click(Sender: TObject);
begin
  fmKeyPad1.Num_0Click(Sender);

end;

procedure TSelfWaitInfo_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,0);
  Tmr_Wait.Tag     := 0;
  Tmr_Wait.Enabled := true;
end;

procedure TSelfWaitInfo_F.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #8 then
    GuestEdit.Text := LeftStr(GuestEdit.Text,Length(GuestEdit.Text)-1)
  else
    GuestEdit.Text := GuestEdit.Text + Key;
end;

procedure TSelfWaitInfo_F.Num_0Click(Sender: TObject);
begin
  Close;
end;

procedure TSelfWaitInfo_F.SaveButtonClick(Sender: TObject);
begin
  if GuestEdit.Text = '' then
  begin
    Common.MsgBox('대기인원을 입력하세요');
    Exit;
  end;

  ModalResult := mrOK;
end;

procedure TSelfWaitInfo_F.Tmr_WaitTimer(Sender: TObject);
begin
  Tmr_Wait.Tag := Tmr_Wait.Tag + 1;
  if (Tmr_Wait.Tag > 120) then
    Close;
end;

end.
