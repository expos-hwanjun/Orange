unit SelfWait_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxLabel, AdvSmoothToggleButton,
  Vcl.ExtCtrls, cxTextEdit, AdvSmoothButton, KeyPad_F, Vcl.AppEvnts, cxCheckBox;

type
  TSelfWait_F = class(TForm)
    TeamCountLabel: TcxLabel;
    ReflashTimer: TTimer;
    WaitFinishLabel: TcxLabel;
    Timer1: TTimer;
    fmKeyPad: TfmKeyPad;
    SaveButton: TAdvSmoothButton;
    PhoneNumberPanel: TPanel;
    TelNo3Edit: TcxTextEdit;
    TelNo2Edit: TcxTextEdit;
    TelNo1Edit: TcxTextEdit;
    Tmr_Wait: TTimer;
    ApplicationEvents: TApplicationEvents;
    AdultButton: TAdvSmoothToggleButton;
    KidButton: TAdvSmoothToggleButton;
    AuthCheckBox: TcxCheckBox;
    procedure TeamCountLabelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ReflashTimerTimer(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TelNo3EditPropertiesChange(Sender: TObject);
    procedure TelNo2EditPropertiesChange(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure Tmr_WaitTimer(Sender: TObject);
    procedure fmKeyPadNum_010Click(Sender: TObject);
    procedure AdultButtonClick(Sender: TObject);
  private
    procedure SetWaitNumber;
  public
    { Public declarations }
  end;

var
  SelfWait_F: TSelfWait_F;

implementation
uses Common_U, GlobalFunc_U, DB, DBModule_U, Const_U, SelfWaitInfo_U;
{$R *.dfm}

{ TSelfWait_F }

procedure TSelfWait_F.AdultButtonClick(Sender: TObject);
begin
  WaitFinishLabel.Visible := false;

  SelfWaitInfo_F := TSelfWaitInfo_F.Create(Self);
  try
    SaveButton.Visible := false;
    if SelfWaitInfo_F.ShowModal <> mrOK then
    begin
      SetWaitNumber;
      TelNo2Edit.SetFocus;
      Exit;
    end;
    if Sender = AdultButton then
    begin
      AdultButton.Tag  := StrToIntDef(SelfWaitInfo_F.GuestEdit.Text,0);
      AdultButton.Status.Caption := SelfWaitInfo_F.GuestEdit.Text+'명';
    end
    else
    begin
      KidButton.Tag  := StrToIntDef(SelfWaitInfo_F.GuestEdit.Text,0);
      KidButton.Status.Caption := SelfWaitInfo_F.GuestEdit.Text+'명';
    end;
  finally
    FreeAndNil(SelfWaitInfo_F);
    SaveButton.Visible := true;
  end;
end;

procedure TSelfWait_F.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  if (Msg.message = WM_KEYDOWN) or (Msg.message = WM_KEYUP) or (Msg.message = WM_LBUTTONDOWN)  then
    Tmr_Wait.Tag := 0;
end;

procedure TSelfWait_F.fmKeyPadNum_010Click(Sender: TObject);
begin
  TelNo2Edit.Clear;
  TelNo3Edit.Clear;
  TelNo2Edit.SetFocus;
end;

procedure TSelfWait_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,0);
  Tmr_Wait.Tag     := 0;
  Tmr_Wait.Enabled := true;
end;

procedure TSelfWait_F.FormResize(Sender: TObject);
begin
  fmKeyPad.Left := Self.Width div 2  - fmKeyPad.Width div 2;
  fmKeyPad.Top  := Self.Height div 2 - fmKeyPad.Height div 2;

  PhoneNumberPanel.Left := fmKeyPad.Left;
  PhoneNumberPanel.Top  := fmKeyPad.Top - PhoneNumberPanel.Height - 30;

  SaveButton.Left := fmKeyPad.Left  + fmKeyPad.Width + 100;;
  SaveButton.Top  := fmKeyPad.Top   + fmKeyPad.Height - SaveButton.Height - 10;

  KidButton.Left  := fmKeyPad.Left  + fmKeyPad.Width + 100;;
  KidButton.Top  := fmKeyPad.Top   + fmKeyPad.Height - KidButton.Height - SaveButton.Height - 20;

  AdultButton.Left  := fmKeyPad.Left  + fmKeyPad.Width + 100;;
  AdultButton.Top  := fmKeyPad.Top   + fmKeyPad.Height - AdultButton.Height - SaveButton.Height - KidButton.Height -  30;

  TeamCountLabel.Left := Self.Width div 2  - TeamCountLabel.Width div 2;
  TeamCountLabel.Top  := PhoneNumberPanel.Top - TeamCountLabel.Height - 100;

  AuthCheckBox.Left := Self.Width div 2  - AuthCheckBox.Width div 2;
  AuthCheckBox.Top  := SaveButton.Top + SaveButton.Height + 60;

  WaitFinishLabel.Left := Self.Width div 2  - WaitFinishLabel.Width div 2;
  WaitFinishLabel.Top  := SaveButton.Top + SaveButton.Height + 110;
end;

procedure TSelfWait_F.FormShow(Sender: TObject);
begin
  SetWaitNumber;
end;

procedure TSelfWait_F.ReflashTimerTimer(Sender: TObject);
begin
  ReflashTimer.Enabled := false;
  SetWaitNumber;
  ReflashTimer.Enabled := true;
end;

procedure TSelfWait_F.SaveButtonClick(Sender: TObject);
var vTelNo :String;
    vWaitNumber,
    vTeamCount,
    vPersonCount,
    vWaitTime :Integer;
begin
  if not AuthCheckBox.Checked then
  begin
    Common.MsgBox('대기정보 일림톡 발송을 위해'#13#13'개인정보 활용에 동의를 해야합니다');
    Exit;
  end;

  if not IsMobileNumber(TelNo1Edit.Text+TelNo2Edit.Text+TelNo3Edit.Text) then
  begin
    Common.MsgBox('전화번호가 올바르지 않습니다');
    if TelNo1Edit.Text <> '010' then
      TelNo1Edit.SetFocus;

    if Length(TelNo2Edit.Text) <> 4 then
      TelNo2Edit.SetFocus;

    if Length(TelNo3Edit.Text) <> 4 then
      TelNo3Edit.SetFocus;

    TelNo2Edit.SetFocus;
    Exit;
  end;

  if AdultButton.Tag + KidButton.Tag = 0 then
  begin
    Common.MsgBox('대기인원을 입력하세요');
    Exit;
  end;

  try
    OpenQuery('select Count(*) as CNT'
             +'  from SL_WAIT '
             +' where CD_STORE  =:P0 '
             +'   and MOBILE_NO =:P1',
             [Common.Config.StoreCode,
              TelNo1Edit.Text+TelNo2Edit.Text+TelNo3Edit.Text]);
    if Common.Query.Fields[0].AsInteger  > 0 then
    begin
      Common.Query.Close;
      Common.MsgBox('이미 대기 중인 전화번호입니다');
      Exit;
    end;
  finally
    Common.Query.Close;
  end;

  vTelNo    := TelNo1Edit.Text+TelNo2Edit.Text+TelNo3Edit.Text;
  vWaitTime := 0;

  OpenQuery('select ifnull(Max(WAIT_NUMBER),0)+1 as WAIT_NUMBER '
           +'  from SL_WAIT '
           +' where CD_STORE =:P0 ',
           [Common.Config.StoreCode]);

  vWaitNumber  := Common.Query.Fields[0].AsInteger;
  Common.Query.Close;

  DM.StoredProc.StoredProcName :='GET_WAIT';
  DM.StoredProc.PrepareSQL;
  DM.StoredProc.ParamByName('_CD_STORE'  ).AsString  := Common.Config.StoreCode;
  DM.StoredProc.ExecProc;

  vTeamCount := DM.StoredProc.ParamByName('_WAIT_TEAM').AsInteger;
  vWaitTime  := DM.StoredProc.ParamByName('_WAIT_TIME').AsInteger;
  DM.StoredProc.Close;


  if Common.Device.WaitTicketPrint(vWaitNumber, AdultButton.Tag + KidButton.Tag, KidButton.Tag, vTeamCount, vWaitTime, vTelNo) then
  begin
    SetWaitNumber;

    AdultButton.Tag            := 0;
    AdultButton.Status.Caption :='0명';
    KidButton.Tag              := 0;
    KidButton.Status.Caption   :='0명';

    AuthCheckBox.Checked    := false;
    WaitFinishLabel.Visible := true;
    Timer1.Enabled          := true;
    TelNo2Edit.Clear;
    TelNo3Edit.Clear;
    TelNo2Edit.SetFocus;
  end;
end;

procedure TSelfWait_F.SetWaitNumber;
var vIndex,
    vTeam,
    vPerson :Integer;
begin
  OpenQuery('select WAIT_NUMBER, '
           +'       PERSON_COUNT, '
           +'       Date_Format(DT_INSERT, ''%H:%i''), '
           +'       case when STATUS = ''W'' then TIMESTAMPDIFF(MINUTE,  DT_INSERT, Now() ) '
           +'            else TIMESTAMPDIFF(MINUTE,  DT_CALL, Now() ) end as WAIT_TIME, '
           +'       MOBILE_NO, '
           +'       STATUS '
           +'  from SL_WAIT '
           +' where CD_STORE =:P0 '
           +' order by WAIT_NUMBER ',
           [Common.Config.StoreCode]);

  vTeam           := 0;
  vPerson         := 0;
  while not Common.Query.Eof do
  begin
    //호출한 대기는 제외
    if Common.Query.Fields[5].AsString = 'W' then
    begin
      vTeam    := vTeam + 1;
      vPerson  := vPerson + Common.Query.Fields[1].AsInteger;
    end;
    Common.Query.Next;
  end;
  Common.Query.Close;
  if vTeam = 0 then
    TeamCountLabel.Caption   := '대기인원 없음'
  else
    TeamCountLabel.Caption   := Format('대기인원 %d팀-%d명',[vTeam,vPerson]);
end;

procedure TSelfWait_F.TeamCountLabelClick(Sender: TObject);
begin
  TeamCountLabel.Tag := TeamCountLabel.Tag + 1;
  if TeamCountLabel.Tag >= 3 then
  begin
    if (Common.Config.UserPass <> '') and (Common.Config.UserPass <> Common.ShowNumberForm('패스워드를 입력하세요', 16)) then
    begin
      Common.ErrBox('패스워드가 올바르지 않습니다');
      Exit;
    end;

    if Common.AskBox('종료하시겠습니까?') then
      Close
    else
      TeamCountLabel.Tag := 0;
  end;

end;

procedure TSelfWait_F.TelNo2EditPropertiesChange(Sender: TObject);
begin
  if Length(TelNo2Edit.Text) = 4 then
    TelNo3Edit.SetFocus;
end;

procedure TSelfWait_F.TelNo3EditPropertiesChange(Sender: TObject);
begin
  if Length(TelNo3Edit.Text) = 0 then
  begin
    TelNo2Edit.SetFocus;
    TelNo2Edit.SelStart  := 4;
  end;
end;

procedure TSelfWait_F.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := false;
  WaitFinishLabel.Visible := false;
end;

procedure TSelfWait_F.Tmr_WaitTimer(Sender: TObject);
begin
  Tmr_Wait.Tag := Tmr_Wait.Tag + 1;
  if (Tmr_Wait.Tag > 120) then
  begin
    AdultButton.Tag            := 0;
    AdultButton.Status.Caption :='0명';
    KidButton.Tag              := 0;
    KidButton.Status.Caption   :='0명';

    AuthCheckBox.Checked    := false;
    WaitFinishLabel.Visible := true;
    TelNo2Edit.Clear;
    TelNo3Edit.Clear;
    TelNo2Edit.SetFocus;
  end;
end;

end.
