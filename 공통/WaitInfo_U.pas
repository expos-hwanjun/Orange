unit WaitInfo_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, OleCtrls,  
  KeyPad_F, jpeg, cxControls, cxContainer, cxEdit, cxTextEdit, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, StrUtils, cxLabel, Vcl.Menus, cxButtons,
  Vcl.Clipbrd, AdvGlassButton, AdvSmoothToggleButton, dxGDIPlusClasses;

type
  TWaitInfo_F = class(TForm)
    fmKeyPad1: TfmKeyPad;
    TelNo1Edit: TcxTextEdit;
    CloseButton: TcxButton;
    GuestLabel: TcxLabel;
    GuestEdit: TcxTextEdit;
    ConfirmButton: TAdvGlassButton;
    TelNo2Edit: TcxTextEdit;
    TelNo3Edit: TcxTextEdit;
    Age1Button: TAdvSmoothToggleButton;
    AdvSmoothToggleButton1: TAdvSmoothToggleButton;
    AdvSmoothToggleButton2: TAdvSmoothToggleButton;
    AdvSmoothToggleButton3: TAdvSmoothToggleButton;
    AdvSmoothToggleButton4: TAdvSmoothToggleButton;
    AdvSmoothToggleButton5: TAdvSmoothToggleButton;
    AdvSmoothToggleButton6: TAdvSmoothToggleButton;
    AdvSmoothToggleButton7: TAdvSmoothToggleButton;
    AddButton: TAdvSmoothToggleButton;
    DecButton: TAdvSmoothToggleButton;
    TableKeyImage: TImage;
    AdvSmoothToggleButton8: TAdvSmoothToggleButton;
    AdvSmoothToggleButton9: TAdvSmoothToggleButton;
    Label1: TLabel;
    MessageLabel: TLabel;
    Image3: TImage;
    AdvSmoothToggleButton10: TAdvSmoothToggleButton;
    AdvSmoothToggleButton11: TAdvSmoothToggleButton;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure Age1ButtonClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure DecButtonClick(Sender: TObject);
    procedure TelNo2EditPropertiesChange(Sender: TObject);
    procedure TelNo3EditPropertiesChange(Sender: TObject);
    procedure fmKeyPad1Num_010Click(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
  private
  public
  end;

var
  WaitInfo_F: TWaitInfo_F;

implementation
uses Common_U, GlobalFunc_U, MaskUtils;
{$R *.dfm}


procedure TWaitInfo_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
end;


procedure TWaitInfo_F.TelNo2EditPropertiesChange(Sender: TObject);
begin
  if Length(TelNo2Edit.Text) = 4 then
    TelNo3Edit.SetFocus;
end;

procedure TWaitInfo_F.TelNo3EditPropertiesChange(Sender: TObject);
begin
  if Length(TelNo3Edit.Text) = 4 then
    ConfirmButton.SetFocus;
end;

procedure TWaitInfo_F.AddButtonClick(Sender: TObject);
begin
  GuestEdit.Text := IntToStr(StoI(GuestEdit.Text)+1);
  TelNo2Edit.SetFocus;
end;

procedure TWaitInfo_F.Age1ButtonClick(Sender: TObject);
begin
  GuestEdit.Text := IntToStr((Sender as TAdvSmoothToggleButton).Tag);
  TelNo2Edit.SetFocus;
end;

procedure TWaitInfo_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TWaitInfo_F.ConfirmButtonClick(Sender: TObject);
begin
  if GuestEdit.Text = '' then
  begin
    Common.MsgBox('대기인원을 입력하세요');
    Exit;
  end;
  ModalResult := mrOK;
end;


procedure TWaitInfo_F.DecButtonClick(Sender: TObject);
begin
  if StoI(GuestEdit.Text) = 0 then Exit;
  GuestEdit.Text := IntToStr(StoI(GuestEdit.Text)-1);
  TelNo2Edit.SetFocus;
end;

procedure TWaitInfo_F.fmKeyPad1Num_010Click(Sender: TObject);
begin
//  fmKeyPad1.Num_010Click(Sender);
  TelNo1Edit.Text := '010';
  TelNo2Edit.SetFocus;
end;

end.

.
