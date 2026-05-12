unit Wait_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxLabel, Math, Vcl.Menus,
  cxButtons, dxGDIPlusClasses, Vcl.ExtCtrls, AdvGlassButton, PosButton,
  StrUtils, AdvSmoothButton;

type
  TWait_F = class(TForm)
    TeamCountLabel: TcxLabel;
    CaptionLabel: TLabel;
    CloseButton: TcxButton;
    Wait1Button: TPosButton;
    Wait2Button: TPosButton;
    Wait3Button: TPosButton;
    Wait4Button: TPosButton;
    Wait5Button: TPosButton;
    Wait6Button: TPosButton;
    Wait7Button: TPosButton;
    Wait8Button: TPosButton;
    Wait9Button: TPosButton;
    Wait10Button: TPosButton;
    Wait11Button: TPosButton;
    Wait12Button: TPosButton;
    Wait13Button: TPosButton;
    Wait14Button: TPosButton;
    Wait15Button: TPosButton;
    Wait16Button: TPosButton;
    Wait17Button: TPosButton;
    Wait18Button: TPosButton;
    Wait19Button: TPosButton;
    PriorButton: TPosButton;
    NextButton: TPosButton;
    MessageLabel: TLabel;
    Image3: TImage;
    AvgTimeLabel: TLabel;
    NewWaitButton: TAdvSmoothButton;
    WaitCancelButton: TAdvSmoothButton;
    InitWaitButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure Wait1ButtonClick(Sender: TObject);
    procedure NewWaitButtonClick(Sender: TObject);
    procedure WaitCancelButtonClick(Sender: TObject);
    procedure PriorButtonClick(Sender: TObject);
    procedure InitWaitButtonClick(Sender: TObject);
  private
    ButtonMaxCount :Integer;
    ButtonData      :Array of Array of String;
    ButtonPage :Integer;
    SelectedCount: Integer;
    CancelMode :Boolean;
    procedure SetWaitNumber;
    procedure SetButtonData;
  public
    isOrder :Boolean;          //렛츠오더로 주문했을때 테이블에 주문처리 가능여부(테이블폼에서 진입시에만 가능)
    WaitTableNo :Integer;
  end;

var
  Wait_F: TWait_F;

implementation
uses Common_U, GlobalFunc_U, DB, WaitInfo_U, DBModule_U, Const_U;
{$R *.dfm}

procedure TWait_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TWait_F.FormCreate(Sender: TObject);
var vIndex :Integer;
begin
  OnShow     := FormShow;
  CancelMode := false;
  isOrder    := false;
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(InitWaitButton);
  Common.SetButtonColor(WaitCancelButton);
  Common.SetButtonColor(NewWaitButton);
  for vIndex := 1 to 19 do
    TPosButton(FindComponent(Format('Wait%dButton',[vIndex]))).Visible := False;
end;

procedure TWait_F.FormShow(Sender: TObject);
begin
  SetWaitNumber;
  Common.SetLanguage(Self);
  PriorButton.Caption := Common.GetPaPago(PriorButton.Caption);
  NextButton.Caption  := Common.GetPaPago(NextButton.Caption);
end;

procedure TWait_F.InitWaitButtonClick(Sender: TObject);
var vIndex :Integer;
begin
  if not Common.AskBox('대기정보를 초기화하시겠습니까?') then Exit;

  OpenQuery('select a.WAIT_NUMBER, '
           +'       a.STATUS, '
           +'       Ifnull(b.AMT_ORDER,0) as AMT_ORDER, '
           +'       Ifnull(b.AMT_SALE,0) as AMT_SALE, '
           +'       b.NO_TABLE '
           +'  from SL_WAIT a left outer join '
           +'       SL_ORDER_H b on b.CD_STORE = a.CD_STORE '
           +'                   and b.NO_TABLE = a.NO_TABLE '
           +'                   and b.DS_ORDER = ''T'' '
           +' where a.CD_STORE =:P0 '
           +' order by a.WAIT_NUMBER ',
           [Common.Config.StoreCode]);
  while not Common.Query.Eof do
  begin
    if Common.Query.FieldByName('AMT_ORDER').AsInteger = 0 then
    begin
      ExecQuery('delete from SL_WAIT '
               +' where CD_STORE    =:P0'
               +'   and WAIT_NUMBER =:P1',
               [Common.Config.StoreCode,
                Common.Query.FieldByName('WAIT_NUMBER').AsInteger]);

      if (GetOption(286) = '1') then
        DM.ExecCloud('delete from WAITING '
                    +' where CD_CUSTOMER =:P0 '
                    +'   and WAIT_NUMBER =:P1;',
                    [Common.Config.StoreCode,
                     Common.Query.FieldByName('WAIT_NUMBER').AsInteger],true,jsonSMSURL);
    end;
    Common.Query.Next;
  end;
  Common.Query.Close;
  SetWaitNumber;
end;

procedure TWait_F.WaitCancelButtonClick(Sender: TObject);
begin
  if not CancelMode then
  begin
    CancelMode := true;
    MessageLabel.Caption := Common.GetPaPago('취소 할 대기번호를 선택하세요');
  end
  else
  begin
    CancelMode := false;
    MessageLabel.Caption := '';
  end;
end;

procedure TWait_F.NewWaitButtonClick(Sender: TObject);
var vCount,
    vTelNo :String;
    vWaitNumber,
    vTeamCount,
    vPersonCount,
    vWaitTime :Integer;
begin
  if GetOption(70) = '0' then
  begin
    if GetOption(286) = '0' then
    begin
      vCount := Common.ShowNumberForm('대기인원을 입력하세요',3,999,'1');
      if vCount = 'mrClose' then Exit;

    end
    else
    begin
      WaitInfo_F := TWaitInfo_F.Create(Application);
      try
        if WaitInfo_F.ShowModal <> mrOK then Exit;
        vCount    := WaitInfo_F.GuestEdit.Text;
        vTelNo    := WaitInfo_F.TelNo1Edit.Text+WaitInfo_F.TelNo2Edit.Text+WaitInfo_F.TelNo3Edit.Text;
        if not IsMobileNumber(vTelNo) then
        begin
          Common.MsgBox('전화번호가 올바르지 않습니다');
          Exit;
        end;
        OpenQuery('select Count(*) as CNT'
                 +'  from SL_WAIT '
                 +' where CD_STORE  =:P0 '
                 +'   and MOBILE_NO =:P1',
                 [Common.Config.StoreCode,
                  vTelNo]);
        if Common.Query.Fields[0].AsInteger  > 0 then
        begin
          Common.MsgBox('이미 대기 중인 전화번호입니다');
          Exit;
        end;
      finally
        Common.Query.Close;
        Application.ProcessMessages;
        FreeAndNil(WaitInfo_F);
      end;

    end;
  end
  else
    vCount := '1';

  if StoI(vCount) = 0 then Exit;

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


  Common.Device.WaitTicketPrint(vWaitNumber, StrToInt(vCount), 0, vTeamCount, vWaitTime, vTelNo);
  SetWaitNumber;
end;

procedure TWait_F.SetWaitNumber;
var vIndex,
    vTeam,
    vTime,
    vAvgTime,
    vPerson :Integer;
begin
  OpenQuery('select a.WAIT_NUMBER, '
           +'       a.PERSON_COUNT, '
           +'       a.KID_COUNT, '
           +'       case when a.STATUS = ''W'' then TIMESTAMPDIFF(MINUTE,  a.DT_INSERT, Now() ) '
           +'            else TIMESTAMPDIFF(MINUTE,  a.DT_CALL, Now() ) end as WAIT_TIME, '
           +'       a.MOBILE_NO, '
           +'       a.STATUS, '
           +'       Ifnull(b.AMT_ORDER,0) as AMT_ORDER, '
           +'       Ifnull(b.AMT_SALE,0) as AMT_SALE, '
           +'       b.NO_TABLE '
           +'  from SL_WAIT a left outer join '
           +'       SL_ORDER_H b on b.CD_STORE = a.CD_STORE '
           +'                   and b.NO_TABLE = a.NO_TABLE '
           +'                   and b.DS_ORDER = ''T'' '
           +' where a.CD_STORE =:P0 '
           +' order by a.WAIT_NUMBER ',
           [Common.Config.StoreCode]);

  ButtonMaxCount  := 0;
  vTeam           := 0;
  vPerson         := 0;
  while not Common.Query.Eof do
  begin
    ButtonMaxCount := ButtonMaxCount + 1;
    //호출한 대기는 제외
    if Common.Query.Fields[5].AsString = 'W' then
    begin
      vTeam    := vTeam + 1;
      vPerson  := vPerson + Common.Query.Fields[1].AsInteger;
    end;
    Common.Query.Next;
  end;


  SetLength(ButtonData, ButtonMaxCount, 7);
  ButtonPage := 1;

  Common.Query.First;
  vIndex := 0;
  while not Common.Query.Eof do
  begin
    ButtonData[vIndex, 0] := Common.Query.Fields[0].AsString;
    if Common.Query.Fields[2].AsInteger = 0 then
      ButtonData[vIndex, 1] := Common.Query.Fields[1].AsString   //인원수
    else
      ButtonData[vIndex, 1] := Format('%s(%d)',[Common.Query.Fields[1].AsString, Common.Query.Fields[2].AsInteger]);   //인원수

    ButtonData[vIndex, 2] := Common.Query.Fields[3].AsString;
    ButtonData[vIndex, 3] := SetTelephone(Common.Query.Fields[4].AsString);
    ButtonData[vIndex, 4] := Ifthen(Common.Query.Fields[5].AsString='W','','호출');
    if Common.Query.Fields[6].AsInteger > 0 then
      ButtonData[vIndex, 5] := '주문';
    if Common.Query.Fields[7].AsInteger > 0 then
      ButtonData[vIndex, 5] := '결제';
    ButtonData[vIndex, 6] := Common.Query.Fields[8].AsString;

    Inc(vIndex);
    Common.Query.Next;
  end;
  Common.Query.Close;

  DM.StoredProc.StoredProcName :='GET_WAIT';
  DM.StoredProc.PrepareSQL;
  DM.StoredProc.ParamByName('_CD_STORE'  ).AsString  := Common.Config.StoreCode;
  DM.StoredProc.ExecProc;

  vTeam := DM.StoredProc.ParamByName('_WAIT_TEAM').AsInteger;
  vTime := DM.StoredProc.ParamByName('_WAIT_TIME').AsInteger;
  vAvgTime := DM.StoredProc.ParamByName('_AVG_TIME').AsInteger;
  DM.StoredProc.Close;
  TeamCountLabel.Caption   := Format('%d팀 예상대기-%d분',[vTeam,vTime]);
  if vAvgTime > 60 then
    AvgTimeLabel.Caption      := Format('평균대기 - %d시간 %d분',[vAvgTime div 60, vAvgTime mod 60])
  else
    AvgTimeLabel.Caption      := Format('평균대기 - %d분',[vAvgTime]);

  SetButtonData;
end;

procedure TWait_F.Wait1ButtonClick(Sender: TObject);
begin
  if CancelMode then
  begin
    if not Common.AskBox('대기를 취소하시겠습니까?') then Exit;

    if ((Sender as TPosButton).Temp1 <> '') and ((Sender as TPosButton).Number.CenterString = '주문') then
    begin
      if Common.AskBox('대기상태에서 주문내역 있습니다'#13#13'주문내역을 삭제하시겠습니까?') then
      begin
        ExecQuery('delete from SL_ORDER_D '
                 +' where CD_STORE   =:P0 '
                 +'   and DS_ORDER   =''T'' '
                 +'   and NO_TABLE   =:P1;',
                 [Common.Config.StoreCode,
                  StrToInt((Sender as TPosButton).Temp1)],true);

      end;
    end;

    if ((Sender as TPosButton).Temp1 <> '') and ((Sender as TPosButton).Number.CenterString = '결제') then
    begin
      Common.MsgBox(Format('%s 테이블에 결제내역이 있습니다'#13'결제를 먼저 취소해야합니다',[(Sender as TPosButton).Temp1]));
      Exit;
    end;

    if (GetHeadOption(9) = '1') and ((Sender as TPosButton).Temp1 <> '') then
    begin
      ExecQuery('delete from SL_ORDER_H '
               +' where CD_STORE =:P0 '
               +'   and DS_ORDER =''T'' '
               +'   and NO_TABLE =:P1',
               [Common.Config.StoreCode,
                StrToInt((Sender as TPosButton).Temp1)], false);

      ExecQuery('delete from SL_ORDER_D '
               +' where CD_STORE =:P0 '
               +'   and DS_ORDER =''T'' '
               +'   and NO_TABLE =:P1',
               [Common.Config.StoreCode,
                StrToInt((Sender as TPosButton).Temp1)], false);

      ExecQuery('insert into TR_ORDER(CD_STORE, '
               +'                     GROUP_SEQ, '
               +'                     GROUP_STEP, '
               +'                     DS_ORDER, '
               +'                     NO_TABLE) '
               +'              values(:P0, '
               +'                     GetNextVal(''TR_ORDER''), '
               +'                     0, '
               +'                     ''T'', '
               +'                     :P1) ',
               [Common.Config.StoreCode,
                StrToInt((Sender as TPosButton).Temp1)], false);
    end;

    ExecQuery('delete from SL_WAIT '
             +' where CD_STORE    =:P0 '
             +'   and WAIT_NUMBER =:P1;',
             [Common.Config.StoreCode,
              StrToInt((Sender as TPosButton).Caption)],true);

    if (GetOption(286) = '1') then
      DM.ExecCloud('delete from WAITING '
                  +' where CD_CUSTOMER =:P0 '
                  +'   and WAIT_NUMBER =:P1;',
                  [Common.Config.StoreCode,
                  StrToInt((Sender as TPosButton).Caption)],true,jsonSMSURL);



  end
  else
  begin
    if (Sender as TPosButton).Number.RightString = '호출' then
    begin
      if not isOrder and ((Sender as TPosButton).Temp1 <> '') and ((Sender as TPosButton).Number.CenterString <> '') then
      begin
        Common.MsgBox('테이블관리에서 진입시 에만'#13'입장시 테이블 지정이 가능합니다');
        Exit;
      end;

      if not Common.AskBox('입장처리 하시겠습니까?') then Exit;
      //입장가능한 빈 테이블이 있는지 체크한다
      if ((Sender as TPosButton).Temp1 <> '') and ((Sender as TPosButton).Number.CenterString <> '') then
      begin
        try
          OpenQuery('select Count(*) '
                   +'  from MS_TABLE as a inner join '
                   +'        MS_CODE  b on b.CD_STORE = a.CD_STORE '
                   +'                  and b.CD_KIND  = ''03'' '
                   +'                  and b.CD_CODE  = a.CD_FLOOR '
                   +'                  and Ifnull(b.NM_CODE20,''N'') <> ''Y'' '
                   +' where a.CD_STORE = :P0 '
                   +'   and Ifnull(a.YN_PACKING,''N'')  <> ''Y'' '
                   +'   and Ifnull(a.YN_DELIVERY,''N'') <> ''Y'' '
                   +'   and a.NO_TABLE not in (select NO_TABLE '
                   +'                          from SL_ORDER_H '
                   +'                         where CD_STORE =:P0 '
                   +'                           and DS_ORDER = ''T'') ',
                   [Common.Config.StoreCode]);
          if Common.Query.Fields[0].AsInteger <= 0 then
          begin
            Common.MsgBox('입장 가능한 테이블이 없습니다');
            Exit;
          end;
        finally
          Common.Query.Close;
        end;

      end;




      ExecQuery('delete from SL_WAIT '
               +' where CD_STORE    =:P0 '
               +'   and WAIT_NUMBER =:P1; ',
               [Common.Config.StoreCode,
                StrToInt((Sender as TPosButton).Caption)],true);

      if (GetOption(286) = '1') then
        DM.ExecCloud('delete from WAITING '
                    +' where CD_CUSTOMER =:P0 '
                    +'   and WAIT_NUMBER =:P1;',
                    [Common.Config.StoreCode,
                     StrToInt((Sender as TPosButton).Caption)],true,jsonSMSURL);

      if ((Sender as TPosButton).Temp1 <> '') and ((Sender as TPosButton).Number.CenterString <> '') then
      begin
        WaitTableNo := StrToInt((Sender as TPosButton).Temp1);
        ModalResult := mrYes;
        Exit;
      end;
    end
    else
    begin
      //카카오 연동
      if (GetOption(286) = '1') then
        if not Common.KaKaoSendMessage('WC',
                                   [Format('▷대기번호: %s 번 ',[(Sender as TPosButton).Caption])+#13
                                   +Format('▷매장 전화번호: %s ',[Common.Config.StoreTel])],
                                    GetOnlyNumber((Sender as TPosButton).Bottom.LeftString), '▷알림톡 호출실패') then Exit;

      ExecQuery('update SL_WAIT '
               +'   set STATUS  = ''C'', '
               +'       DT_CALL = Now() '
               +' where CD_STORE    =:P0 '
               +'   and WAIT_NUMBER =:P1;',
               [Common.Config.StoreCode,
                StrToInt((Sender as TPosButton).Caption)],true);

      if (GetOption(286) = '1') then
        DM.ExecCloud('update WAITING '
                    +'   set STATUS  = ''C'', '
                    +'       DT_CALL = Now() '
                    +' where CD_CUSTOMER =:P0 '
                    +'   and WAIT_NUMBER =:P1;',
                    [Common.Config.StoreCode,
                     StrToInt((Sender as TPosButton).Caption)],true,jsonSMSURL);

    end;
  end;
  ButtonPage := 1;
  SetWaitNumber;
end;

procedure TWait_F.SetButtonData;
var vIndex :Integer;
begin
  For vIndex := 1 to 19 do
  begin
    TPosButton(FindComponent(Format('Wait%dButton',[vIndex]))).Caption             := '';
    TPosButton(FindComponent(Format('Wait%dButton',[vIndex]))).Number.NumberString := '';
    TPosButton(FindComponent(Format('Wait%dButton',[vIndex]))).Bottom.RightString  := '';
    TPosButton(FindComponent(Format('Wait%dButton',[vIndex]))).Number.RightString  := '';
    TPosButton(FindComponent(Format('Wait%dButton',[vIndex]))).Number.CenterString := '';
    TPosButton(FindComponent(Format('Wait%dButton',[vIndex]))).Bottom.LeftString   := '';
    TPosButton(FindComponent(Format('Wait%dButton',[vIndex]))).BorderInnerColor    := clBlack;
    TPosButton(FindComponent(Format('Wait%dButton',[vIndex]))).Temp1               := '';
    TPosButton(FindComponent(Format('Wait%dButton',[vIndex]))).Visible             := false;
  end;

  For vIndex := 1  to 19 do
  begin
    if (((ButtonPage-1)*19) + vIndex ) > High(ButtonData)+1 then Continue;

    TPosButton(FindComponent(Format('Wait%dButton',[vIndex]))).Caption              := ButtonData[((ButtonPage-1)*19) + vIndex-1, 0];
    TPosButton(FindComponent(Format('Wait%dButton',[vIndex]))).Bottom.RightString   := ButtonData[((ButtonPage-1)*19) + vIndex-1, 1]+'명';
    TPosButton(FindComponent(Format('Wait%dButton',[vIndex]))).Number.NumberString  := ButtonData[((ButtonPage-1)*19) + vIndex-1, 2]+'분';
    TPosButton(FindComponent(Format('Wait%dButton',[vIndex]))).Bottom.LeftString    := ButtonData[((ButtonPage-1)*19) + vIndex-1, 3];   //전화번호
    TPosButton(FindComponent(Format('Wait%dButton',[vIndex]))).Number.RightString   := ButtonData[((ButtonPage-1)*19) + vIndex-1, 4];
    if ButtonData[((ButtonPage-1)*19) + vIndex-1, 4] = '호출' then
       TPosButton(FindComponent(Format('Wait%dButton',[vIndex]))).BorderInnerColor := clRed;
    TPosButton(FindComponent(Format('Wait%dButton',[vIndex]))).Number.CenterString    := ButtonData[((ButtonPage-1)*19) + vIndex-1, 5];
    TPosButton(FindComponent(Format('Wait%dButton',[vIndex]))).Temp1                := ButtonData[((ButtonPage-1)*19) + vIndex-1, 6];

    TPosButton(FindComponent(Format('Wait%dButton',[vIndex]))).Visible              := true;
  end;
  PriorButton.Enabled := ButtonPage > 1;
  NextButton.Enabled  := ButtonPage <= (ButtonMaxCount div 19);

  PriorButton.Visible := ButtonPage > 1;
  NextButton.Visible  := ButtonPage > 1;
end;

procedure TWait_F.PriorButtonClick(Sender: TObject);
begin
  if Sender = PriorButton then ButtonPage := ButtonPage -1
  else if Sender = NextButton then ButtonPage := ButtonPage +1;

  SetButtonData;
end;

end.
