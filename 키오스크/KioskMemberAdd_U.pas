unit KioskMemberAdd_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, AdvGlassButton, Vcl.StdCtrls,
  cxRadioGroup, cxGroupBox, cxLabel, cxTextEdit, jpeg, StrUtils, Math,
  Vcl.ExtCtrls, ShellAPI, AdvSmoothButton, AdvSmoothToggleButton,
  dxGDIPlusClasses, cxClasses;

type
  TKioskMemberAdd_F = class(TForm)
    edt_Mobile: TcxTextEdit;
    cxLabel2: TcxLabel;
    GenderGroupBox: TcxGroupBox;
    rdo_Gender: TcxRadioButton;
    rdo_GenderM: TcxRadioButton;
    edt_certifyNo: TcxTextEdit;
    lbl_certifyNo: TcxLabel;
    ConfirmButton: TAdvSmoothButton;
    obtn_certify: TAdvSmoothButton;
    CancelButton: TAdvSmoothToggleButton;
    CloseTimer: TTimer;
    MessageLabel: TcxLabel;
    AgreeButton: TAdvSmoothButton;
    AgreeLabel: TcxLabel;
    ImageCollection: TcxImageCollection;
    ImageCollectionItem1: TcxImageCollectionItem;
    ImageCollectionItem2: TcxImageCollectionItem;
    procedure FormCreate(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure obtn_certifyClick(Sender: TObject);
    procedure edt_MobileExit(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
    procedure AgreeLabelClick(Sender: TObject);
  private
    CertifyNo  :String;
  public
    { Public declarations }
  end;

var
  KioskMemberAdd_F: TKioskMemberAdd_F;

implementation
uses Common_U, GlobalFunc_U, KioskKeyPad_U, DBModule_U, Const_U;

{$R *.dfm}

procedure TKioskMemberAdd_F.AgreeLabelClick(Sender: TObject);
begin
  if AgreeButton.Tag = 0 then
  begin
    AgreeButton.Tag := 1;
    AgreeButton.Picture.Assign(ImageCollection.Items[1].Picture.Graphic);
  end
  else
  begin
    AgreeButton.Tag := 0;
    AgreeButton.Picture.Assign(ImageCollection.Items[0].Picture.Graphic);
  end;
end;

procedure TKioskMemberAdd_F.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TKioskMemberAdd_F.CloseTimerTimer(Sender: TObject);
begin
  CloseTimer.Tag := CloseTimer.Tag + 1;
  if CloseTimer.Tag > 60 then
  begin
    CloseTimer.Enabled := false;
    Close;
  end
  else
    CancelButton.Status.Caption := IntToStr(60-CloseTimer.Tag);
end;

procedure TKioskMemberAdd_F.ConfirmButtonClick(Sender: TObject);
var vTemp, vCode :String;
    vSeq, vPoint :Integer;
begin
  inherited;
  if (GetOption(423) = '1') and (edt_certifyNo.Text = '') then
  begin
    Common.ErrBox('휴대폰인증을 받아야합니다');
    Exit;
  end;

  if not IsMobileNumber(GetOnlyNumber(edt_mobile.Text)) then
  begin
    Common.ErrBox('전화번호를 정확히 입력하세요');
    edt_mobile.SetFocus;
    Exit;
  end;

  OpenQuery('select Count(*), '
           +'       Max(NM_MEMBER) '
           +'  from MS_MEMBER '
           +' where CD_STORE   =:P0 '
           +'   and TEL_MOBILE =:P1 ',
           [Common.Config.StoreCode,
            GetOnlyNumber(edt_mobile.Text)]);
  if Common.Query.Fields[0].AsInteger > 0 then
  begin
    Common.ErrBox('이미 가입 된 전화번호입니다');
    edt_mobile.SetFocus;
    Common.Query.Close;
    Exit;
  end;

  if not Common.SaveMemberAdd(true,
                              '',
                              SetTelephone(edt_mobile.Text),
                              '001',
                              Ifthen(rdo_Gender.Checked, '1','0'),
                              '',
                              GetOnlyNumber(edt_mobile.Text),
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              'N',
                              'N',
                              'Y',
                              '',
                              '',
                              'KIOSK 가입',
                              '',
                              '') then Exit;

  try
    Common.SelectMemberInfo('','',GetOnlyNumber(edt_Mobile.Text));
    Common.MsgBox('회원가입이 정상 처리되었습니다');
    ModalResult := mrOK;
  except
    on E: Exception do
    begin
      Common.WriteLog('MemberAdd001',E.Message);
      Common.ErrBox(E.Message+#13#13+'저장을 완료하지 못했습니다');
      Exit;
    end;
  end;

end;

procedure TKioskMemberAdd_F.edt_MobileExit(Sender: TObject);
begin
  edt_Mobile.Text := SetTelephone(edt_Mobile.Text);
end;

procedure TKioskMemberAdd_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,0);

  Common.SetButtonColor(ConfirmButton);
  Common.SetButtonColor(obtn_certify);

  lbl_certifyNo.Visible := GetOption(423) = '1';
  edt_certifyNo.Visible := GetOption(423) = '1';
  obtn_certify.Visible  := GetOption(423) = '1';
end;

procedure TKioskMemberAdd_F.FormShow(Sender: TObject);
begin
  GenderGroupBox.Caption := Common.GetPapago('성별');

  obtn_certify.Caption   := Common.GetPapago('인증요청');
  CancelButton.Caption   := Common.GetPapago('나가기');
  ConfirmButton.Caption  := Common.GetPapago('저장');
  CloseTimer.Tag         := 0;
end;

procedure TKioskMemberAdd_F.obtn_certifyClick(Sender: TObject);
var vResult   :Boolean;
label Loop;
begin
  inherited;
  if not (Length(GetOnlyNumber(edt_mobile.Text)) in [10,11]) or not IsMobileNumber(LeftStr(GetOnlyNumber(edt_mobile.Text),3)) then
  begin
    Common.ErrBox('전화번호를 정확히 입력하세요');
    edt_mobile.SetFocus;
    Exit;
  end;

  OpenQuery('select Count(*), '
           +'       Max(NM_MEMBER) '
           +'  from MS_MEMBER '
           +' where CD_STORE   =:P0 '
           +'   and TEL_MOBILE =:P1 ',
           [Common.Config.StoreCode,
            GetOnlyNumber(edt_mobile.Text)]);
  if Common.Query.Fields[0].AsInteger > 0 then
  begin
    Common.ErrBox('이미 가입 된 전화번호입니다');
    edt_mobile.SetFocus;
    Common.Query.Close;
    Exit;
  end;

  edt_certifyNo.Clear;
  while Length(CertifyNo) <> 4 do
    CertifyNo := IntToStr(Random(9999));

  vResult := Common.KaKaoSendMessage('M',[Format('%s에 회원가입 요청 메세지입니다'#13#13+'인증번호 %s',[Common.Config.StoreName, CertifyNo])],
                                     edt_mobile.Text);
  if not vResult then
  begin
    Common.ErrBox('인증번호 요청 문자 발송실패!!!');
    Exit;
  end;

  Common.MsgBox(Format('%s 카카오 알림톡으로 발송 된'#13'인증번호를 입력하세요',[edt_mobile.Text]));
Loop:
  KioskKeyPad_F := TKioskKeyPad_F.Create(Self);
  KioskKeyPad_F.MessageLabel.Caption := '인증번호를 입력하세요';
  KioskKeyPad_F.isPassword           := false;
  try
    if KioskKeyPad_F.ShowModal <> mrOK then Exit;
    if CertifyNo = KioskKeyPad_F.KeyInLabel.Hint then
      edt_certifyNo.Text := KioskKeyPad_F.KeyInLabel.Hint;
  finally
    KioskKeyPad_F.Free;
  end;
  if (edt_certifyNo.Text = EmptyStr) and Common.AskBox('인증번호가 맞지 않습니다'#13'다시 입력 하시겠습니까?') then
    goto Loop;
end;

end.
