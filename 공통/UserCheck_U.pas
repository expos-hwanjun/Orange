unit UserCheck_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, KeyPad_F, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus,
  cxButtons, dxGDIPlusClasses, Vcl.ExtCtrls, AdvGlassButton, cxTextEdit, cxLabel,
  AdvSmoothButton;

type
  TUserCheck_F = class(TForm)
    fmKeyPad1: TfmKeyPad;
    lbl_Name: TLabel;
    cxLabel1: TcxLabel;
    UserCodeEdit: TcxTextEdit;
    cxLabel2: TcxLabel;
    UserPwdEdit: TcxTextEdit;
    UserNameLabel: TLabel;
    MessageLabel: TLabel;
    Image3: TImage;
    CaptionLabel: TLabel;
    CloseButton: TcxButton;
    OkButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UserCodeEditEnter(Sender: TObject);
    procedure UserPwdEditPropertiesChange(Sender: TObject);
    procedure UserPwdEditKeyPress(Sender: TObject; var Key: Char);
    procedure UserCodeEditExit(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
  private
    EmpWork,
    PassWord :String;
  public
    aPOS :Integer;
  end;

var
  UserCheck_F: TUserCheck_F;

implementation
uses Common_U, GlobalFunc_U, Const_U;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TUserCheck_F.UserCodeEditEnter(Sender: TObject);
begin
  lbl_Name.Caption := '';
  UserPwdEdit.Clear;
  MessageLabel.Caption  := '';
end;

procedure TUserCheck_F.UserCodeEditExit(Sender: TObject);
var vTemp :String;
begin
  MessageLabel.Caption  := '';
  if UserCodeEdit.Text = '' then
  begin
    MessageLabel.Caption   := ' 사원번호를 입력하십시오.';
    Exit;
  end
  else
  begin
    try
      OpenQuery('select EMP_WORK, '
               +'       NM_SAWON, '
               +'       NO_PASSWORD '
               +'  from MS_SAWON '
               +' where CD_STORE =:P0 '
               +'   and CD_SAWON =:P1',
               [Common.Config.StoreCode,
                Trim(UserCodeEdit.Text)]);
       if Common.Query.RecordCount = 0 then
       begin
         UserCodeEdit.SetFocus;
         MessageLabel.Caption := '등록되어 있지 않은 사원번호입니다';
         Exit;
       end;
       EmpWork            := Common.Query.FieldByName('EMP_WORK').AsString;
       lbl_Name.Caption   := Common.Query.FieldByName('NM_SAWON').AsString;
       PassWord           := Decrypt(Common.Query.FieldByName('NO_PASSWORD').AsString, _CryptKey);
    finally
      Common.Query.Options.QueryRecCount := false;
    end;
  end;
  Common.Query.Close;
end;

procedure TUserCheck_F.UserPwdEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then OkButtonClick(OkButton);
end;

procedure TUserCheck_F.UserPwdEditPropertiesChange(Sender: TObject);
begin
  MessageLabel.Caption := '';
end;

procedure TUserCheck_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TUserCheck_F.OkButtonClick(Sender: TObject);
begin
  if PassWord <> UserPwdEdit.Text then
  begin
    UserPwdEdit.SetFocus;
    MessageLabel.Caption := '비밀번호가 일치하지 않습니다 ';
    Exit;
  end;

  if Copy(EmpWork,aPos,1) <> '1' then
  begin
    Common.ErrBox('권한이 없는 사용자입니다');
    Exit;
  end
  else ModalResult := mrOK;
end;

procedure TUserCheck_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(OkButton);
end;

procedure TUserCheck_F.FormShow(Sender: TObject);
begin
  BlockInput(false);
  UserCodeEdit.SetFocus;
  MessageLabel.Caption := '권한이 있는 사용자를 선택하세요';
end;

procedure TUserCheck_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F10  :  if (ActiveControl is TCustomEdit) then TCustomEdit(ActiveControl).Clear;
  end;
end;

end.
