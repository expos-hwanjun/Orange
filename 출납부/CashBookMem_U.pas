unit CashBookMem_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, KeyPad_F, StdCtrls, cxLabel, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxCurrencyEdit, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxButtons, AdvGlassButton,
  dxGDIPlusClasses, Vcl.ExtCtrls, AdvSmoothButton;

type
  TCashBookMem_F = class(TForm)
    fmKeyPad1: TfmKeyPad;
    lblCode: TcxLabel;
    lblName: TcxLabel;
    lblTitle: TLabel;
    CloseButton: TcxButton;
    cxLabel3: TcxLabel;
    TrustAmtEdit: TcxCurrencyEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    GetAmtEdit: TcxCurrencyEdit;
    AfterTrustAmtEdit: TcxCurrencyEdit;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    MessageLabel: TLabel;
    Image3: TImage;
    CardButton: TAdvSmoothButton;
    OkButton: TAdvSmoothButton;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure GetAmtEditPropertiesChange(Sender: TObject);
    procedure CardButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    Gubun :String; //C :출납무, M:회원조회
    WorkDate :String;
  end;

var
  CashBookMem_F: TCashBookMem_F;

implementation
uses Common_U, GlobalFunc_U, Const_U;
{$R *.dfm}



procedure TCashBookMem_F.FormCreate(Sender: TObject);
var vIndex :Integer;
begin
  Common.LogoCreate(Self,2);
  for vIndex := 0 to ComponentCount-1 do
    if Components[vIndex] is TAdvSmoothButton then
      Common.SetButtonColor((Components[vIndex] as TAdvSmoothButton));
end;

procedure TCashBookMem_F.FormShow(Sender: TObject);
var vTrustAmt :Integer;
begin
  //카드만
  if Gubun = 'C' then
  begin
    CardButton.Visible := true;
    CardButton.Caption := '카드';
    OkButton.Visible   := false;
    CardButton.Left    := 126;
  end
  else if Gubun = 'H' then
  begin
    CardButton.Visible := false;
    OkButton.Visible   := true;
    CardButton.Left    := 126;
  end
  else if Gubun = 'M' then //회원조회에서 대금결제
  begin
    CardButton.Visible := True;
    CardButton.Caption := '카드';
    CardButton.Left    := 53;
    OkButton.Visible   := true;
    OkButton.Left      := 216;
  end;
  lblCode.Caption := Common.Member.Code;
  lblName.Caption := Common.Member.Name;

  TrustAmtEdit.Value := Common.Member.CreditAmt;
  GetAmtEdit.Value  := 0;
  AfterTrustAmtEdit.Value := TrustAmtEdit.Value;
  Common.SetLanguage(Self);
end;

procedure TCashBookMem_F.GetAmtEditPropertiesChange(Sender: TObject);
begin
  AfterTrustAmtEdit.Value := TrustAmtEdit.Value - GetAmtEdit.Value;
end;

procedure TCashBookMem_F.OkButtonClick(Sender: TObject);
begin
  if GetAmtEdit.Value = 0 then
  begin
    Common.MsgBox('결제금액을 입력하세요');
    Exit;
  end;
  ModalResult := mrOK;
end;

procedure TCashBookMem_F.CardButtonClick(Sender: TObject);
var vCon :Char;
begin
  try
    InitCardRecord(Common.Card);
    GetAmtEdit.PostEditValue;
    GetAmtEdit.Properties.ReadOnly := true;
    Common.PreSent.WRcvAmt := GetAmtEdit.EditValue;
    vCon := GetOption(60);
    Common.CardPrintMode := cpmAtOnce;
    Common.Config.Options[60] := '0';
    Common.CashBookCard := True;
    if Common.ShowCardForm(false, True) then
    begin
      Common.CashBookCard := False;
      ModalResult := mrOK;
    end
    else
    begin
      Common.CashBookCard := False;
      GetAmtEdit.Properties.ReadOnly := false;
    end;
  finally
    Common.Config.Options[60] := vCon;
  end;
end;

procedure TCashBookMem_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TCashBookMem_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE : Close;
    VK_RETURN : OkButtonClick(nil);
    VK_F10  :  if (ActiveControl is TCustomEdit) then TCustomEdit(ActiveControl).Clear;
  end;
end;



end.
