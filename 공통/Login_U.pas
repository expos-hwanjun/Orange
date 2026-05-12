unit Login_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons, ExtCtrls, jpeg,
  GraphicEx, DB, IdBaseComponent, IdComponent,  StrUtils,
  IdTCPConnection, IdTCPClient, IdFTP, DateUtils, IniFiles, KeyPad_F,
  cxControls, cxContainer, cxEdit, cxCheckBox, MemDS, DBAccess, Uni,
  IdGlobal, OleCtrls, MaskUtils, IdCustomTCPServer, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons, dxGDIPlusClasses,
  AdvGlassButton, cxTextEdit, cxLabel, AdvSmoothButton, AdvSmoothToggleButton;

type
  TLogin_F = class(TForm)
    lbl_Name: TLabel;
    fmKeyPad1: TfmKeyPad;
    CaptionLabel: TLabel;
    Timer1: TTimer;
    KioskTimer: TTimer;
    UserNameLabel: TcxLabel;
    edt_UserID: TcxTextEdit;
    PasswordLabel: TcxLabel;
    edt_PassWord: TcxTextEdit;
    PassWordChangePanel: TPanel;
    edt_befpass: TcxTextEdit;
    edt_newpass: TcxTextEdit;
    edt_newconfirm: TcxTextEdit;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    CloseButton: TcxButton;
    MessageLabel: TLabel;
    Image3: TImage;
    LogInTimer: TTimer;
    OkButton: TAdvSmoothButton;
    PWDChangeButton: TAdvSmoothButton;
    PassWordChangeButton: TAdvSmoothButton;
    CancelButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_UserIDExit(Sender: TObject);
    procedure edt_UserIDEnter(Sender: TObject);
    procedure edt_PassWordKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edt_befpassExit(Sender: TObject);
    procedure edt_newconfirmKeyPress(Sender: TObject; var Key: Char);
    procedure edt_PassWordChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure KioskTimerTimer(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure PWDChangeButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure PassWordChangeButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure LogInTimerTimer(Sender: TObject);
    procedure edt_UserIDKeyPress(Sender: TObject; var Key: Char);
  private
    IsError :Boolean;
    function GetPosOpenCheck :Boolean;
  public
    { Public declarations }
  end;

var                                        
  Login_F: TLogin_F;
implementation
uses Common_U, GlobalFunc_U, DBModule_U, Const_U, IdIOHandler;
{$R *.dfm}

procedure TLogin_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(OkButton);
  Common.SetButtonColor(PassWordChangeButton);
  Common.SetButtonColor(CancelButton);
  Common.SetButtonColor(PWDChangeButton);
end;

procedure TLogin_F.edt_UserIDEnter(Sender: TObject);
begin
  lbl_Name.Caption := '';
  edt_PassWord.Clear;
  MessageLabel.Caption  := '';
  PWDChangeButton.Visible := False;
end;

procedure TLogin_F.edt_UserIDExit(Sender: TObject);
var vTemp :String;
begin
  MessageLabel.Caption  := '';
  if edt_UserID.Text = '' then
  begin
     MessageLabel.Caption   := ' 사원번호를 입력하십시오.';
     Exit;
  end
  else
  begin
    edt_UserID.Text := Lpad(edt_UserID.Text,6,'0');
    DM.Query.Options.QueryRecCount := true;
    try
      DM.OpenQuery('select * '
                  +' from MS_SAWON '
                  +'where CD_STORE =:P0 '
                  +'  and CD_SAWON =:P1',
                  [Common.Config.StoreCode,
                   Trim(edt_UserID.Text)]);
      if DM.Query.RecordCount = 0 then
      begin
        if Sender = nil then
          edt_UserID.Clear;

        edt_UserID.SetFocus;
        MessageLabel.Caption := '등록되어 있지 않은 사원번호입니다';
        Exit;
      end;
      vTemp := DM.Query.FieldByName('emp_work').AsString;
      if Copy(vTemp,1,2) = '00' then
      begin
        edt_UserID.SetFocus;
        MessageLabel.Caption := '주문 및 정산 권한이 없는 사용자입니다';
        Exit;
      end;

      lbl_Name.Caption         := DM.Query.FieldByName('nm_sawon').AsString;
      Common.Config.UserName   := DM.Query.FieldByName('nm_sawon').AsString;
      Common.Config.UserPass   := Decrypt(DM.Query.FieldByName('no_password').AsString, _CryptKey);
      Common.Config.UserGrade  := DM.Query.FieldByName('cd_grade').AsString;
      Common.Config.UserWork   := DM.Query.FieldByName('emp_work').AsString;
      Common.Config.LoginUserWork := DM.Query.FieldByName('emp_work').AsString;
      Common.Config.UserCode   := edt_UserID.Text;
      DM.Query.Close;
      PWDChangeButton.Visible := True;
    finally
      DM.Query.Options.QueryRecCount := false;
      DM.Query.Close;
    end;

    //키오스크일때는 자동로그인을 안한다
    if Common.GetIniFile('POS', '자동로그인', False) and not Common.Config.IsKiosk then
    begin
      edt_PassWord.Text := Decrypt(Common.GetIniFile('POS', '로그인암호',''), _CryptKey);
      if Common.Config.UserPass = edt_PassWord.Text then
        LogInTimer.Enabled := true
      else
        Common.Config.AutoLogin := false;
    end;
  end;
end;

procedure TLogin_F.edt_UserIDKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Char(Ord(VK_RETURN))) or (Key = Char(Ord(VK_ESCAPE))) then
    Key := #0;
end;

procedure TLogin_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN : begin
                  if edt_UserID.Focused then
                  begin
                    edt_PassWord.SetFocus;
                    Key := 0;
                  end;
                end;
    VK_F10  :  if (ActiveControl is TCustomEdit) then TCustomEdit(ActiveControl).Clear;
  end;
end;

function TLogin_F.GetPosOpenCheck:Boolean;
begin
  Result := False;
  //매장환경정보 셋팅
  Common.SelectStoreInfo;
//  DM.StoredProc.UnPrepare;
  DM.StoredProc.Close;
  DM.StoredProc.StoredProcName := 'POS_SELECT_OPENCHECK';
  DM.StoredProc.PrepareSQL;
  DM.StoredProc.Params.ParamByName('_CD_STORE').Value := Common.Config.StoreCode;
  DM.StoredProc.Params.ParamByName('_NO_POS').Value   := Common.Config.PosNo;
//  DM.StoredProc.ParamByName('_CD_STORE').Value := Common.Config.StoreCode;
//  DM.StoredProc.ParamByName('_NO_POS').Value   := Common.Config.PosNo;
  DM.StoredProc.ExecProc;

  Common.WorkDate             := NVL(DM.StoredProc.Params.ParamByName('_YMD_OPEN').Value,'');
  Common.OpenDate             := Common.WorkDate;
  Common.LastCloseDate        := NVL(DM.StoredProc.Params.ParamByName('_YMD_CLOSE').Value,'');

  if ((Common.PosType = ptAccount) and (DM.StoredProc.Params.ParamByName('_POS_TYPE').Value = 'O')) or ( (Trim(Common.WorkDate)= '') and (Common.PosType = ptAccount)) then
    Common.PosType := ptNotAccount;
  DM.StoredProc.Close;

  //주문포스이면서 개점된 포스가 없을때
  if (Common.PosType = ptOnlyOrder) and (Common.WorkDate = '') then
  begin
    Common.ErrBox('개점된 포스가 없습니다'+#13#13+
                  '주문포스는 개점된 포스가'+#13+
                  '있어야 사용할 수 있습니다');
    Exit;
  end;
  Result := true;
end;

procedure TLogin_F.edt_PassWordKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Char(Ord(VK_ESCAPE))) then
    Key := #0;
  if Key = #13 then
  begin
    Key := #0;
    OkButtonClick(OkButton);
  end;
end;

procedure TLogin_F.FormShow(Sender: TObject);
  function GetPOSUserName:String;
  var vUserName: Array [0..127] of char;
      vLen :DWORD;
      vIndex :Integer;
  begin
    vLen := Sizeof(vUserName);
    GetUserName(vUserName, vLen);
    Result := EmptyStr;
    For vIndex := 0 to vLen-2 do
      Result := Result + vUserName[vIndex];
  end;
var vFileName:String;
    vHandle :THandle;
    vPosType,
    vCode17,
    vCode16:String;
begin
  IsError := False;
  Application.ProcessMessages;
  Common.SetIniFile('POS','Mutex',0);
  Common.SetIniFile('POS','PING FAIL','');

  PassWordChangePanel.Top  := 191;
  PassWordChangePanel.Left := 31;

  if (GetIPAddress = Common.GetIniFile(iniCommon, iniDBIP, '127.0.0.1')) or (Common.GetIniFile(iniCommon, iniDBIP, '127.0.0.1') = '127.0.0.1') then
  begin
    vHandle := FindWindow('TOrangeTRMainForm', nil);
    if vHandle <> 0 then
    begin
      if GetHeadOption(10) <> '1' then
        Common.TRSendMessage('DOWNLOAD');
    end
    else
      ExecuteProgram('','OrangeTR.exe','');
  end;

  vFileName := ExtractFileName(Application.ExeName);
  if (Application.Title = 'OrnagePOS') and (UpperCase(vFileName) <> 'ORANGEPOS.EXE') then
  begin
    Common.ErrBox('바탕화면 바로가기 아이콘에 '+#13#13+'대상화일이 잘못 지정되었습니다');
    Application.Terminate;
    Exit;
  end;
  Application.ProcessMessages;
  ////////////////////     포스번호       //////////////////////

  Common.Config.PosIP := GetPosIP;
  Common.Query.Options.QueryRecCount := false;
  OpenQuery('select a.NM_CODE1, '
           +'       a.NM_CODE3 as POS_TYPE, '
           +'       a.NM_CODE13, '
           +'       b.OPTIONS, '
           +'       a.NM_CODE17, '
           +'       a.NM_CODE15, '    //디자인
           +'       a.NM_CODE16, '    //PLU
           +'       a.NM_CODE19, '    //Kisok Design
           +'       a.NM_CODE20, '     //Kiosk PLU
           +'      (select NM_CODE19 from MS_CODE as c where CD_STORE =:P0 and CD_KIND = ''01'' and NM_CODE3 = ''7'' limit 1) as LETSORDER_CALL '
           +'  from MS_CODE  as a inner join '
           +'       MS_STORE as b on b.CD_STORE = a.CD_STORE '
           +' where a.CD_STORE =:P0 '
           +'   and ( replace(a.NM_CODE2, '' '','''') =:P1 or (a.NM_CODE4 <> '''' and upper(a.NM_CODE4) =''$$'') ) '
           +'   and a.CD_KIND   = ''01'' '
           +'   and a.DS_STATUS = ''0'' ',
           [Common.Config.StoreCode,
            DM.PosIP]);

  if not Common.Query.Eof then
  begin
    Common.Config.Options   := Common.Query.FieldByName('OPTIONS').AsString;
    vPosType := Common.Query.FieldByName('POS_TYPE').AsString;
    vCode17  := Common.Query.FieldByName('NM_CODE17').AsString;
    vCode16  := Common.Query.FieldByName('NM_CODE16').AsString;
    Common.Config.LetsOrderCall  := Common.Query.FieldByName('LETSORDER_CALL').AsString;
    Common.GetIni;
    Common.Config.UserPass := '$$$$$$$$';

    if Common.Config.PosNo = EmptyStr then
      Common.Config.PosNo        := Common.Query.FieldByName('NM_CODE1').AsString;
    if (Length(Common.Config.PosNo) <> 2)  then
    begin
      Common.ErrBox(Common.Config.PosNo+' 잘못된 포스번호입니다');
      IsError := True;
      Application.Terminate;
      Exit;
    end;

    if not Common.IsDebugMode and (Common.Config.ServerIP <> '127.0.0.1') and (GetIPAddress <> Common.Config.ServerIP) and (GetPosIP <> GetIPAddress) then
    begin
      Common.ErrBox(Format('POS IP가 올바르지 않습니다(%s)',[GetPosIP]));
      IsError := True;
      Application.Terminate;
      Exit;
    end;

    if (vPosType = '0') or (vPosType = '2') then
      Common.POSType := ptAccount
    else
      Common.PosType := ptOnlyOrder;

    Common.Config.DesignCode    := IntToStr(86+StrToIntDef(Common.Query.FieldByName('NM_CODE15').AsString,1));
    Common.Config.PluNo         := Common.Query.FieldByName('NM_CODE16').AsString;

    if Common.Config.PluNo = '' then
      Common.Config.PluNo := '01';

    if Common.Config.DesignCode = '' then
      Common.Config.DesignCode := '87';

    Common.Config.OriginalPosNo := Common.Config.PosNo;


    //키오스크일때
    if (vPosType = '2') and (GetOption(403)='1') then
    begin
      Common.Config.IsTakeOut := true;
      Common.Config.IsKiosk   := true;
      Common.Config.PluNo     := vCode16;
      if Common.Config.PluNo = '' then
        Common.Config.PluNo := '01';
      if Length(vCode17) = 6 then
      begin
        edt_UserID.Text        := vCode17;
        Common.Config.UserCode := vCode17;
        Common.Query.Close;
        edt_UserIDExit(nil);
      end
      else
      begin
        edt_UserID.Text        := Common.Config.EndUser;
        edt_UserIDExit(nil);
      end;

      Common.Query.Close;
//      //현금사용하는 키오스크인지 여부
//      OpenQuery('select NM_CODE5 '
//               +'  from MS_CODE '
//               +' where CD_STORE =:P0 '
//               +'   and CD_KIND  =''84'' '
//               +'   and CD_CODE  =''009'' ',
//               [Common.Config.StoreCode]);
//
//      if not Common.Query.Eof and (Common.Query.FieldByName('NM_CODE5').AsString = '0') then
//        Common.Config.IsKioskCash := true
//      else
//        Common.Config.IsKioskCash := false;

      if Length(vCode17) = 6 then
      begin
        Self.Width := 0;
        Common.SelectStoreInfo;
        KioskTimer.Enabled := True;
        Exit;
      end;
    end
    else
    begin
      //매장운영방식이 가변이면 포스설정으로 사용한다
      if GetOption(16) = '2' then
        Common.Config.IsTakeOut := Common.Query.FieldByName('NM_CODE13').AsString = '1'
      else
        Common.Config.IsTakeOut := GetOption(16) = '1';

      edt_UserID.Text        := Common.Config.EndUser;
      edt_UserIDExit(nil);
    end;
  end
  else
  begin
    Common.ErrBox(Common.Config.StoreCode+'매장에 '+
                  Common.Config.PosIP+' IP로'+#13+'등록된 포스가 없습니다'#13'TR 다운로드를 확인하세요');
    Application.Terminate;
    IsError := True;
    Exit;
  end;
  Common.Query.Close;

  Common.SelectStoreInfo;

  if Length(edt_UserID.Text) = 6 then
    Timer1.Enabled := True
  else
    edt_UserID.SelectAll;
end;

procedure TLogin_F.OkButtonClick(Sender: TObject);
var vOpenDate, vResult :String;
    vIndex :Integer;
begin
  //master 패스워드를 변경하지 않았을때는 사용 못하도록
  if not IsDebuggerPresent and (Common.Config.UserPass <> edt_Password.Text) and (edt_Password.Text <> 'passkey') then
  begin
    edt_PassWord.SetFocus;
    MessageLabel.Caption := '비밀번호가 일치하지 않습니다 ';
    Exit;
  end;

  Common.IsDBServer := (Common.Config.ServerIP = '127.0.0.1') or (Common.Config.ServerIP = Common.Config.PosIP);
  if Common.IsDebugMode then
    Common.IsDBServer :=false;

  if Common.Config.IsKiosk then
  begin
    KioskTimer.Enabled := True;
    Exit;
  end;

  try
    Common.ShowWaitForm('사용자를 확인 중 입니다....');
    Common.SelectStoreInfo;

    //개점/마감을 자동으로 할때
    if (GetOption(129) = '1') and not (Common.PosType in [ptOnlyOrder]) and not Common.Config.IsKiosk then
    begin
      try
        Common.BeginTran;
        //Common.WorkDate 이전 마감되지 않은 매출은 마감하지 않는다
        DM.StoredProc.StoredProcName := 'POS_SAVE_AUTO_CLOSE';
        DM.StoredProc.PrepareSQL;
        DM.StoredProc.ParamByName('_CD_STORE').AsString := Common.Config.StoreCode;
        DM.StoredProc.ParamByName('_NO_POS').Value   := Common.Config.PosNo;
        DM.StoredProc.ExecProc;
        vResult := DM.StoredProc.ParamByName('_RESULT').Value;
        if vResult <> 'OK' then
          raise Exception.Create(vResult);

        //개점만 있고 판매가 없는 일자는 개점을 취소한다
        ExecQuery('delete '
                 +'  from SL_POSCLOSE '
                 +' where CD_STORE =:P0 '
                 +'   and NO_POS   =:P1 '
                 +'   and DS_STATUS = ''O'' '
                 +'   and YMD_CLOSE < Date_Format(Now(), ''%Y%m%d'') '
                 +'   and YMD_CLOSE not in (select YMD_SALE '
                 +'                           from SL_SALE_H '
                 +'                          where CD_STORE =:P0 '
                 +'                            and NO_POS   =:P1 '
                 +'                            and YMD_SALE < Date_Format(Now(), ''%Y%m%d'') '
                 +'                          group by YMD_SALE) ',
                 [Common.Config.StoreCode,
                  Common.Config.PosNo]);

        //주문/배달상태를 계산완료로 수정한다                               //그룻회수기능을 사용하지 않을때
        if (Common.Config.MainPosNo = Common.Config.PosNo) and (GetOption(284) = '1') and (GetOption(56) = '0') then
        begin
          ExecQuery('update SL_DELIVERY set DS_STEP=''A'' where CD_STORE =:p0 and DS_STEP in (''O'',''D'')', [Common.Config.StoreCode]);
          ExecQuery('delete from SL_ORDER_H   where CD_STORE =:P0 and DS_ORDER =''D''', [Common.Config.StoreCode]);
          ExecQuery('delete from SL_ORDER_D   where CD_STORE =:P0 and DS_ORDER =''D''', [Common.Config.StoreCode]);
          ExecQuery('delete from SL_ORDER_C   where CD_STORE =:P0 and DS_ORDER =''D''', [Common.Config.StoreCode]);
          ExecQuery('delete from SL_ORDER_PRT where CD_STORE =:P0 and DS_ORDER =''D''', [Common.Config.StoreCode]);
        end;

        GetPosOpenCheck;
        if Common.NowDate <> Common.WorkDate then
        begin
          if Common.LastCloseDate < Common.NowDate then
            vOpenDate := Common.NowDate
          else
            vOpenDate := DtoS(IncDay(StoD(Common.LastCloseDate),1));

//          if Common.WorkDate = '' then
//            ExecQuery('insert into SL_POSCLOSE(CD_STORE, '
//                     +'                        YMD_CLOSE, '
//                     +'                        NO_POS, '
//                     +'                        DS_STATUS) '
//                     +'                 values(:P0, '
//                     +'                        :P1, '
//                     +'                        :P2, '
//                     +'                        ''O'') ',
//                     [Common.Config.StoreCode,
//                      vOpenDate,
//                      Common.Config.PosNo]);

          if vOpenDate <> Common.WorkDate then
            Common.SetDayOpen(vOpenDate);
          Common.WorkDate := vOpenDate;
          Common.OpenDate := vOpenDate;
          Common.PosType  := ptAccount;
        end;
        Common.WriteLog('work', Format('로그인(%s)(%s)',[Common.Config.UserCode,GetFileVersion(Application.ExeName)]));
        Common.CommitTran;
      except
        on E: Exception do
        begin
          Common.HideWaitForm;
          Common.WriteLog('OkButtonClick',E.Message);
          Common.RollbackTran;
        end;
      end;
    end;

    For vIndex := 0 to Screen.MonitorCount-1 do
      if Screen.Monitors[vIndex].Primary then
        Common.PrimaryMonitors := vIndex;

    Common.SetSystemTimeSync;

    if GetPosOpenCheck then
    begin
      Common.SetIniFile('POS','최종사용자',edt_UserID.Text);
      ModalResult := mrOK;
    end
    else
      ModalResult := mrCancel;
  finally
    Common.HideWaitForm;
  end;
end;

procedure TLogin_F.PassWordChangeButtonClick(Sender: TObject);
begin
  if edt_newpass.Text <> edt_newconfirm.Text then
  begin
    MessageLabel.Caption := '신규비밀번호와 비밀번호확인 번호가 다릅니다';
    edt_newconfirm.SetFocus;
  end;

  if Length(edt_newconfirm.Text) < 1 then
  begin
    MessageLabel.Caption := '비밀번호는 1자리 이상이어야 합니다';
    edt_newpass.Clear;
    edt_newconfirm.Clear;
    edt_newpass.SetFocus;
    Exit;
  end;

  try
    DM.ExecCloud('update MS_SAWON '
                +'   set NO_PASSWORD =:P3 '
                +' where CD_HEAD  =:P0 '
                +'   and CD_STORE =:P1 '
                +'   and CD_SAWON =:P2; ',
                [Common.Config.HeadStoreCode,
                 Common.Config.StoreCode,
                 edt_UserID.Text,
                 Encrypt(edt_newpass.Text, _CryptKey)],true,Common.RestDBURL);

    ExecQuery('update MS_SAWON '
            +'   set NO_PASSWORD =:P2 '
            +' where CD_STORE    =:P0 '
            +'   and CD_SAWON    =:P1 ',
            [Common.Config.StoreCode,
             edt_UserID.Text,
             Encrypt(edt_newpass.Text, _CryptKey)]);
    Common.WriteLog('work', Format('암호변경(%s)',[edt_UserID.Text]));
    Common.Config.UserPass := edt_newconfirm.Text;
    PWDChangeButtonClick(nil);
  except
    on E: Exception do
    begin
      Common.ErrBox(E.Message);
    end;
  end;

end;

procedure TLogin_F.PWDChangeButtonClick(Sender: TObject);
begin
  PassWordChangePanel.Visible   := not PassWordChangePanel.Visible;
  edt_UserID.Enabled   := not PassWordChangePanel.Visible;
  edt_PassWord.Enabled := not PassWordChangePanel.Visible;
  MessageLabel.Caption := EmptyStr;
  edt_befpass.Clear;
  edt_newpass.Clear;
  edt_newconfirm.Clear;
  if PassWordChangePanel.Visible then edt_befpass.SetFocus
  else                                edt_PassWord.SetFocus;
end;

procedure TLogin_F.CancelButtonClick(Sender: TObject);
begin
  edt_UserID.Enabled   := true;
  edt_PassWord.Enabled := true;
  edt_UserID.Clear;
  edt_UserID.SetFocus;
  PassWordChangePanel.Visible := false;
end;

procedure TLogin_F.CloseButtonClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TLogin_F.edt_befpassExit(Sender: TObject);
begin
  if not PassWordChangePanel.Visible then Exit;
  if edt_befpass.Text <> Common.Config.UserPass then
  begin
    MessageLabel.Caption := '현재 비밀번호와 다릅니다';
    edt_befpass.SetFocus;
  end
  else
    MessageLabel.Caption := EmptyStr;
end;

procedure TLogin_F.edt_newconfirmKeyPress(Sender: TObject; var Key: Char);
begin
  if Key <> #13 then Exit;
  PassWordChangeButtonClick(PassWordChangeButton);
end;

procedure TLogin_F.edt_PassWordChange(Sender: TObject);
begin
  MessageLabel.Caption := '';
end;

procedure TLogin_F.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  if edt_PassWord.Enabled then
    edt_PassWord.SetFocus;
end;

procedure TLogin_F.KioskTimerTimer(Sender: TObject);
var vIndex :Integer;
begin
  KioskTimer.Enabled := false;
  Common.SelectStoreInfo;

  For vIndex := 0 to Screen.MonitorCount-1 do
    if Screen.Monitors[vIndex].Primary then
      Common.PrimaryMonitors := vIndex;

  Common.SetSystemTimeSync;
  //매장환경정보 셋팅
  Common.SelectStoreInfo;

  //키오스크 개점/마감 자동으로 할때
  if Common.KioskAutoOpen then
    ModalResult := mrOK
  else
    ModalResult := mrCancel;
end;

procedure TLogin_F.LogInTimerTimer(Sender: TObject);
begin
  LogInTimer.Enabled := false;
  OkButtonClick(OkButton);
end;

end.





