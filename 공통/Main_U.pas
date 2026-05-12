{******************************************************************************
                 사용 포트
 POS        : 7007   SmartAgent
 Demon      : 7002, 7006, 7066
 TR         : 8005
 SmartAgent : 7004
 DID        : 7008

 ******************************************************************************}
 
unit Main_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MaskUtils, Grids,
  ExtCtrls, jpeg, GraphicEx, IniFiles, ShellAPI,
  IdTCPClient, Menus, cxControls, cxContainer, cxEdit,
  cxCheckBox, cxImage, MPlayer, cxLabel, StrUtils,
  cxButtons, cxTextEdit, cxCurrencyEdit, Winsock, idGlobal,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdTCPServer, IdContext,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, DAScript, UniScript,
  cxGraphics, cxLookAndFeels, POSCard, cxLookAndFeelPainters,
  dxGDIPlusClasses, Buttons, IdTCPConnection, IdHTTP, TlHelp32, IdSocketHandle, Sockets,
  cxMaskEdit, cxDropDownEdit, cxCalendar, MMSystem, IdCmdTCPClient,
  IdRawBase, IdRawClient, IdIcmpClient, System.ImageList, Vcl.ImgList, Data.DB,
  MemDS, DBAccess, Uni, AdvGlassButton, AdvScrollControl, AdvRichEditorBase,
  AdvRichEditor, AdvGlowButton, ToolPanels, shlobj, AdvSmartMessageBox, AdvPanel,
  frmshape, AdvBadge, System.Net.URLClient, System.Net.HttpClient, REST.Client,
  REST.Types, System.JSON, AdvSmoothPanel, AdvShape, AdvSmoothToggleButton,
  cxClasses, PNGImage, cxMemo, AdvSmoothButton, IdAntiFreezeBase,
  Vcl.IdAntiFreeze,  Vcl.ComCtrls, CPort, uNFC_ACR122;

//type
//  TBytes = array of byte;

type
  TMain_F = class(TForm)
    Tmr_Start: TTimer;
    IdHTTP: TIdHTTP;
    TR_Start: TTimer;
    MasterDownLoadButton: TcxButton;
    NoticesPanel: TAdvPanel;
    NoticesEditor: TAdvRichEditor;
    NoShowCheckBox: TcxCheckBox;
    NoticeCloseButton: TAdvGlowButton;
    OrderTimer: TTimer;
    RcpManagerTimer: TTimer;
    UpDateListButton: TcxButton;
    OrderButton: TAdvSmoothToggleButton;
    OpenButton: TAdvSmoothToggleButton;
    DepositButton: TAdvSmoothToggleButton;
    PosCloseButton: TAdvSmoothToggleButton;
    SaleReportButton: TAdvSmoothToggleButton;
    ConfigButton: TAdvSmoothToggleButton;
    CashBookButton: TAdvSmoothToggleButton;
    WorkButton: TAdvSmoothToggleButton;
    CloseButton: TAdvSmoothToggleButton;
    BottomShape: TAdvShape;
    AdvSmoothPanel1: TAdvSmoothPanel;
    Image2: TImage;
    Image1: TImage;
    Image3: TImage;
    Image4: TImage;
    ExposImage: TImage;
    PosNoLabel: TcxLabel;
    lbl_WorkDate: TcxLabel;
    lbl_CloseDate: TcxLabel;
    CashierLabel: TcxLabel;
    AdvSmoothPanel2: TAdvSmoothPanel;
    ServiceButton: TcxButton;
    VersionLabel: TLabel;
    CustomerNoLabel: TLabel;
    ChargeInfoButton: TcxButton;
    LicenseKeyLabel: TcxLabel;
    ImageCollection: TcxImageCollection;
    ImageCollectionItem1: TcxImageCollectionItem;
    NoticesEdit: TAdvRichEditor;
    Button1: TButton;
    Button2: TButton;
    ImageCollectionItem2: TcxImageCollectionItem;
    ComPort1: TComPort;
    StoreNameLabel: TcxLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StoreNameLabelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure Tmr_StartTimer(Sender: TObject);
    procedure obtn_KioskReadyClick(Sender: TObject);
    procedure OrderButtonClick(Sender: TObject);
    procedure OpenButtonClick(Sender: TObject);
    procedure DepositButtonClick(Sender: TObject);
    procedure CashBookButtonClick(Sender: TObject);
    procedure WorkButtonClick(Sender: TObject);
    procedure ConfigButtonClick(Sender: TObject);
    procedure PosCloseButtonClick(Sender: TObject);
    procedure SaleReportButtonClick(Sender: TObject);
    procedure ServiceButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure TR_StartTimer(Sender: TObject);
    procedure MasterDownLoadButtonClick(Sender: TObject);
    procedure UnhandledExceptionHandler(Sender: TObject; E: Exception);
    procedure NoShowCheckBoxPropertiesChange(Sender: TObject);
    procedure NoticeCloseButtonClick(Sender: TObject);
    procedure OrderTimerTimer(Sender: TObject);
    procedure RcpManagerTimerTimer(Sender: TObject);
    procedure UpDateListButtonClick(Sender: TObject);
    procedure lbl_WorkDateClick(Sender: TObject);
    procedure CustomerNoLabelClick(Sender: TObject);
    procedure ChargeInfoButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ExposImageClick(Sender: TObject);
    procedure CashierLabelClick(Sender: TObject);
  private
    ClickTime :TDateTime;
    IsWorking :Boolean;
    isDownLoad :Boolean;  //TR에서 다운로드 완료되면 적용해야할 지
    DispenserData :String;
    Volume   :Single;
    ServerStatus :Boolean;
    function  CheckUpdate:Boolean;
    function  CheckUser: Boolean;
    procedure ExtremeNotice;
    procedure WMCopyData(var Msg:TWmCopyData); message WM_CopyData;
    function  SetKioskCash:Boolean;
    procedure DispenderReset;
    procedure DispenserReadEvent(const S : String);
    procedure DualFilesDownLoad;
    procedure KioskFilesDownLoad;
    procedure CreateFlatRoundRgn;
    function  GetHttpURL:String;
    procedure SetVolume(NewVolume: DWORD);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    IsBrowser :Boolean;
    procedure  WndProc( var Message : TMessage ); override;
  end;

var
  Main_F: TMain_F;

procedure KFTC_ICDetect(aOutputData:PAnsiChar);stdcall;


implementation

uses Table_U, Open_U, Deposit_U, Common_U, Work_U, Config_U,
  PrinterStatus_U, Order_U, Card_U, GlobalFunc_U, CashierMgm_U,
  CashBook_U, RcpChange_U, DualOrder_U, CashRcp_U, Member_U,
  QuesMsg_U, DateUtils, SaleReport_U, DBModule_U, Login_U, Download_U,
  Delivery_U, Notice_U, Const_U, DeliveryNew_U, DeliveryInfo_U,
  MemberAdd_U, KioskReady_U, KioskCashierMgm_U, KioskKeyPad_U,
  UpdateNotice_U, WebOrder, LetsOrderCallList_U, BackGroundScreen;

{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure ExcludeRectRgn(var Rgn: HRGN; LeftRect, TopRect, RightRect, BottomRect: Integer);
var
  RgnEx: HRGN;
begin
  RgnEx := CreateRectRgn(LeftRect, TopRect, RightRect, BottomRect);
  CombineRgn(Rgn, Rgn, RgnEx, RGN_OR);
  DeleteObject(RgnEx);
end;

procedure TMain_F.UnhandledExceptionHandler(Sender: TObject; E: Exception);
const
  MethodName = 'UnhandledException';
begin
  Common.WriteLog('Error', MethodName + E.Message);
end;


procedure TMain_F.UpDateListButtonClick(Sender: TObject);
var vUpdateDate :String;
begin
  //업데이트 내역있는지 체크(최근 3일내에 업데이트 내역있으면 아이콘 변경), 포스에서는 최대 1개월 업데이트만 표시
  try
    DM.OpenCloud('select SEQ, '
                +'       DT_INSERT '
                +'  from UPDATE_NOTICE '
                +' where DS_SOLUTION  =:P0 '
                +' order by SEQ desc '
                +' limit 10 ',
                ['O'],RestBaseURL);
    if DM.CloudData.Eof then
    begin
      Common.MsgBox('업데이트 내역이 없습니다 ');
      Exit;
    end;
    vUpdateDate := FormatDateTime('yyyymmdd', DM.CloudData.Fields[1].AsDateTime);
  finally
    DM.Query.Close;
  end;


  UpdateNotice_F := TUpdateNotice_F.Create(Self);
  try
    UpdateNotice_F.UpdateDate := vUpdateDate;
    UpdateNotice_F.ShowModal;
    Application.ProcessMessages;
  finally
    FreeAndNil(UpdateNotice_F);
  end;

end;

procedure TMain_F.FormCreate(Sender: TObject);
  function GetPartnerTelNo:String;
  begin
    DM.OpenCloud('select b.TEL_OFFICE '
               +'   from CUSTOMER a inner join '
               +'  where PARTNER  b on b.CD_PARTNER = a.CD_PARTNER '
               +'    and CD_CUSTOMER =:P0 ',
               [Common.Config.StoreCode],RestBaseURL);
    if not DM.CloudData.Eof then
      Result := SetTelephone(DM.CloudData.Fields[0].AsString)
    else
      Result := '';
  end;
var vHandle :THandle;
    vReg    :Variant;
    vTemp   :String;
    vIndex     :Integer;
    vNotice,
    vFileName,
    vPartner :String;
    vStream :TStream;
    vPNGImage   : TPNGImage;
    vJPGImage   : TJPEGImage;
    vCollectionItem :TcxImageCollectionItem;
begin
  CreateFlatRoundRgn;
  Pointer((@Application.MainForm)^) := Main_F;
  if (ParamStr(1) <> 'DEMON') and CheckUpdate then
  begin
    vHandle := FindWindow(nil, 'POSDemon');
    if vHandle > 0 then
    begin
      with TIdTCPClient.Create(Application) do
      begin
        try
          try
            Host := '127.0.0.1';
            Port := 7066;
            ConnectTimeout := 500;
            Connect;
            Socket.WriteLnRFC('UPDATE' +#3, IndyTextEncoding_OSDefault);
          except
          end;
        finally
          Disconnect;
          Free;
        end;
      end;
    end
    else ExecuteProgram('','Demon.exe','');
    Self.OnShow := nil;
    Application.Terminate;
    Exit;
  end;

  try
    StrToDate('2023-02-13');
  except
    Common.ErrBox('시스템에 DateTime 형식이 올바르지 않습니다'#13'설정을 변경 후 다시 실행하세요 ');
    Tag := 1;
  end;


  Common.Config.Style := Common.GetIniFile('POS', 'Style','B');
  if (Common.Config.Style <> 'B') and (Common.Config.Style <> 'D') then
    Common.Config.Style := 'B';

  Common.isDebugMode := IsDebuggerPresent;
  NoticesPanel.Visible := false;
  if not IsDebuggerPresent then
    Application.OnException := UnhandledExceptionHandler;

  with TIniFile.Create(Common.AppPath+'Config.ini') do
    try
      Common.Config.ServerIP       := ReadString('공통','DB_IP','127.0.0.1');
    finally
      Free;
    end;

  if (Common.Config.ServerIP = '127.0.0.1') or (Common.Config.ServerIP = GetIPAddress) then
    Common.IsDBServer := true;

  if Common.IsDBServer and not FileExists(Common.AppPath+'OrangeTR.exe') then
    Common.FileDownLoad('OrangeTR.exe', Common.AppPath);


  OpenQuery('select CD_HEAD, CD_STORE, MAIN_POSNO, DS_STATUS, YMD_SETUP, NOW() as NOW_DATE, YMD_PAYEND, '
           +'   YMD_LASTCONNECT '
           +'  from MS_STORE '
           +' limit 1 ',
           []);
  if not Common.Query.Eof then
  begin
    Common.Config.HeadStoreCode := Common.Query.Fields[0].AsString;
    Common.Config.StoreCode     := Common.Query.Fields[1].AsString;
    Common.Config.MainPosNo     := Common.Query.Fields[2].AsString;
    //데모기간 체크
    if (Common.Query.FieldByName('DS_STATUS').AsString = 'D') and (Common.Query.FieldByName('YMD_SETUP').AsString <> '') then
    begin
      if DaysBetween(Common.Query.FieldByName('NOW_DATE').AsDateTime, StoD(Common.Query.FieldByName('YMD_SETUP').AsString)) > 15 then
      begin
        vTemp := GetPartnerTelNo;
        Common.ErrBox(Format('데모기간이 만료 되었습니다'#13#13'%s 로 문의해주세요',[Ifthen(vTemp='','1544-4171',vTemp)]));
        Application.Terminate;
        Exit;
      end;
      Common.MsgBox(Format('현재 데모용으로 사용 중입니다'#13#13'%s 까지 사용가능합니다',[FormatDateTime('yyyy년mm월dd일',IncDay(StoD(Common.Query.FieldByName('YMD_SETUP').AsString), 15))]));
    end
    else if Common.Query.FieldByName('DS_STATUS').AsString = 'E' then
    begin
      vTemp := GetPartnerTelNo;
      Common.ErrBox(Format('데모기간이 만료 되었습니다'#13#13'%s 로 문의해주세요',[Ifthen(vTemp='','1544-4171',vTemp)]));
      Application.Terminate;
      Exit;
    end
    else if Common.Query.FieldByName('DS_STATUS').AsString = '1' then
    begin
      vTemp := GetPartnerTelNo;
      Common.ErrBox(Format('계약해지 된 매장입니다'#13#13'%s 로 문의해주세요',[Ifthen(vTemp='','1544-4171',vTemp)]));
      Application.Terminate;
      Exit;
    end
    else if Common.Query.FieldByName('DS_STATUS').AsString = 'R' then
    begin
      vTemp := GetPartnerTelNo;
      Common.ErrBox(Format('계약해지 [요청] 매장입니다'#13#13'%s 로 문의해주세요',[Ifthen(vTemp='','1544-4171',vTemp)]));
      Application.Terminate;
      Exit;
    end
    else if Common.Query.FieldByName('DS_STATUS').AsString = '3' then
    begin
//      BusinessSupportLabel.Visible :=true;
      Common.ErrBox('영업지원용으로 실 매장에 사용할 수 없습니다');
//      BusinessSupportLabel.Caption := '영업지원용으로 실 매장에 사용할 수 없습니다';
    end;

    if (Common.Query.FieldByName('YMD_PAYEND').AsString <> '') and (Common.Query.FieldByName('YMD_PAYEND').AsString < FormatDateTime('yyyymmdd',Common.Query.FieldByName('NOW_DATE').AsDateTime) ) then
    begin
      Common.ErrBox(Format('구독기간이 만료되었습니다[%s]'#13'1544-4171에 문의주세요',[Common.Query.FieldByName('YMD_PAYEND').AsString]));
      Application.Terminate;
      Exit;
    end;

    if (Common.Query.FieldByName('YMD_LASTCONNECT').AsString <> '')  and (DaysBetween(Common.Query.FieldByName('NOW_DATE').AsDateTime, StoD(Common.Query.FieldByName('YMD_LASTCONNECT').AsString)) > 15) then
    begin
      Common.ErrBox('오프라인 모드로는 최대 15일까지만'#13'사용이 가능합니다,');
      Application.Terminate;
      Exit;
    end;

    Common.Query.Close;
  end
  else
  begin
    if not Common.RunningProgram('OrangeTR.exe') then
      ExecuteProgram('','OrangeTR.exe','');

    Common.ErrBox('가맹점 인증을 먼저 해야합니다');
    Application.Terminate;
    Exit;
  end;

  if Common.IsDBServer then
  begin
    isDownLoad := true;
    Common.TRSendMessage('ALLDOWNLOAD');
  end;

  vHandle := FindWindow(nil, 'POSDemon');
  if vHandle = 0 then
    ExecuteProgram('','Demon.exe','');

  // 로그인을 한다
  if not CheckUser then
  begin
    Self.OnShow := nil;
    Application.Terminate;
    Exit;
  end;


  //자동로그인일때는 서버상태 체크할 시간을 준다
  if Common.IsDBServer and Common.Config.AutoLogin then
    Sleep(1000);

  if Common.Config.IsKiosk then
  begin
    Application.CreateForm(TBackGroundScreen_F, BackGroundScreen_F);
    Application.OnModalBegin := Common.DoModalBegin;
    Application.OnModalEnd   := Common.DoModalEnd;
  end;

  if not Common.Config.IsKiosk then
    for vIndex := 0 to ComponentCount-1 do
      if Components[vIndex] is TAdvSmoothToggleButton then
        Common.SetButtonColor((Components[vIndex] as TAdvSmoothToggleButton));

  if Common.Config.IsKiosk then
    Common.Config.PosLanguage := 'KO';

  if Common.PosType = ptOnlyOrder then
    SaleReportButton.Enabled := false;

  Common.WriteLog('work',Format('로그인(%s),개점(%s)',[GetFileVersion(Application.ExeName), Common.WorkDate]));

//  if (GetHeadOption(9)='1') or Common.IsDBServer or (Common.GetIniFile('POS',  '스마트포스데몬',  false)) then
//  begin
//    DM.OpenCloud('select VERSION, FILENAME '
//                +'  from FILES_VERSION '
//                +' where FILENAME in (''SmartAgent.exe'',''OrangeTR.exe'') ',
//                [],RestBaseURL);
//
//    while not DM.CloudData.Eof do
//    begin
//      if not Common.IsDBServer and (DM.CloudData.Fields[1].AsString = 'OrangeTR.exe') then
//        DM.CloudData.Next;
//
//      if not DM.CloudData.Eof and (DM.CloudData.Fields[0].AsString > GetFileVersion(DM.CloudData.Fields[1].AsString,true)) then
//      begin
//        Common.KillTask(DM.CloudData.Fields[1].AsString);
//        Common.FileDownLoad(DM.CloudData.Fields[1].AsString,Common.AppPath);
//        ExecuteProgram('',DM.CloudData.Fields[1].AsString,'');
//      end;
//      DM.CloudData.Next;
//    end;
//  end;

  if Common.Config.IsKiosk then
  begin
    Common.Device.OnDispenserReadData :=DispenserReadEvent;
    WorkButton.Enabled := false;
    WorkButton.Appearance.Font.Style := [fsBold,fsItalic];
    WorkButton.Cursor  := crNo;
    if Common.Config.KioskDispenserPort = 0 then
    begin
      DepositButton.Enabled := false;
      DepositButton.Cursor  := crNo;
      DepositButton.Appearance.Font.Style := [fsBold,fsItalic];
    end;

    with TIniFile.Create(Common.AppPath+'Kiosk\KioskConfig.ini') do
    try
      Common.isBFKiosk := ReadString('배리어프리','모드','N') = 'Y';
    finally
      free;
    end;

    if not DirectoryExists(Common.AppPath+'TTS') then
      ForceDirectories(Common.AppPath+'TTS');

    CashBookButton.Caption := '영수증관리';
    //Kiosk일때는 이미지를 로컬에 화일로 변환해 놓는다
    try
      OpenQuery('select CD_MENU, '
               +'       FILE_NAME, '
               +'       IMG_MENU '
               +'  from MS_MENU_IMAGE '
               +' where CD_STORE =:P0 ',
               [Common.Config.StoreCode]);

      while not Common.Query.Eof do
      begin
        if Common.Query.FieldByName('IMG_MENU').AsString <> '' then
        begin
          if RightStr(Common.Query.FieldByName('FILE_NAME').AsString,3) = 'jpg' then
          begin
            vJPGImage   := TJPEGImage.Create;
            try
              try
                vStream := Common.Query.CreateBLOBStream(Common.Query.FieldByName('IMG_MENU'), bmRead);
                vJPGImage.LoadFromStream(vStream);
                vCollectionItem := Common.MenuImageCollection.Items.Add;
                vCollectionItem.Name := Format('Menu%sItem',[Common.Query.FieldByName('CD_MENU').AsString]);
                vTemp := Format('menu%s.jpg',[Common.Query.FieldByName('CD_MENU').AsString]);
                vJPGImage.SaveToFile(vTemp);
                vCollectionItem.Picture.LoadFromFile(vTemp);
                DeleteFile(vTemp);
              except
              end;
            finally
              vJPGImage.Free;
            end;
          end
          else
          begin
            vPNGImage   := TPNGImage.Create;
            try
              try
                vStream := Common.Query.CreateBLOBStream(Common.Query.FieldByName('IMG_MENU'), bmRead);
                vPNGImage.LoadFromStream(vStream);
                vCollectionItem := Common.MenuImageCollection.Items.Add;
                vCollectionItem.Name := Format('Menu%sItem',[Common.Query.FieldByName('CD_MENU').AsString]);
                vTemp := Format('menu%s.png',[Common.Query.FieldByName('CD_MENU').AsString]);
                vPNGImage.SaveToFile(vTemp);
                vCollectionItem.Picture.LoadFromFile(vTemp);
                DeleteFile(vTemp);
              except
              end;
            finally
              vPNGImage.Free;
            end;
          end;
        end;
        Common.Query.Next;
      end;
      Common.Query.Close;
    except
    end;
  end
  else
    lbl_CloseDate.Visible := Common.PosType <> ptOnlyOrder;

  //배달 선불제일때 프린터체크를 배달관리버튼으로 사용한다
  if Common.Config.IsTakeOut and (GetOption(185)= '1') and not Common.Config.IsKiosk then
  begin
    WorkButton.Picture.Assign(ImageCollectionItem1.Picture);
    WorkButton.Caption := '배달관리';
    WorkButton.Tag     := 1;
  end;

  Common.Device.DeviceSetup;

  IsWorking := False;
  IsBrowser := False;

  LicenseKeyLabel.Visible     := (GetOption(379)='0') or Common.Config.PosCatUse;

  if Common.Config.PosCatUse then
    LicenseKeyLabel.Caption  := '단말기연동';

  //차트를 표시를 위해 레지스트리 설정
  if Common.isWindows64 then
  begin
    vReg := GetRegistry(HKEY_LOCAL_MACHINE, 'SOFTWARE\WOW6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION', 'OrangePOS.exe');
    if (VarType(vReg) = varString) or (VarType(vReg) = varUString)   then
    begin
      try
        CreateRegistry(HKEY_LOCAL_MACHINE, 'SOFTWARE\WOW6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION','OrangePOS.exe', $000);
      except
        Common.ErrBox('관리자 권한으로 실행야합니다');
        Application.Terminate;
      end;
    end;
  end
  else
  begin
    vReg := GetRegistry(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION', 'OrangePOS.exe' );
    if (VarType(vReg) = varString) or (VarType(vReg) = varUString)   then
    begin
      try
        CreateRegistry(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION','OrangePOS.exe', $000);
      except
        Common.ErrBox('관리자 권한으로 실행야합니다');
        Application.Terminate;
      end;
    end;
  end;


  vReg := GetRegistry(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp', 'DefaultSecureProtocols');
  if String(vReg) = '' then
    SetRegistry(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp', 'DefaultSecureProtocols',  Integer(2560));

  //Rest TimeOut
  vReg := GetRegistry(HKEY_CURRENT_USER, 'SOFTWARE\Microsoft\Windows\CurrentVersion\InternetSettings', 'ConnectTimeOut');
  if String(vReg) = '' then
    SetRegistry(HKEY_CURRENT_USER, 'SOFTWARE\Microsoft\Windows\CurrentVersion\InternetSettings', 'ConnectTimeOut',  Integer(360000));
  vReg := GetRegistry(HKEY_CURRENT_USER, 'SOFTWARE\Microsoft\Windows\CurrentVersion\InternetSettings', 'SendTimeOut');
  if String(vReg) = '' then
    SetRegistry(HKEY_CURRENT_USER, 'SOFTWARE\Microsoft\Windows\CurrentVersion\InternetSettings', 'SendTimeOut',  Integer(360000));
  vReg := GetRegistry(HKEY_CURRENT_USER, 'SOFTWARE\Microsoft\Windows\CurrentVersion\InternetSettings', 'ReceiveTimeOut');
  if String(vReg) = '' then
    SetRegistry(HKEY_CURRENT_USER, 'SOFTWARE\Microsoft\Windows\CurrentVersion\InternetSettings', 'ReceiveTimeOut',  Integer(360000));
  vReg := GetRegistry(HKEY_CURRENT_USER, 'SOFTWARE\Microsoft\Windows\CurrentVersion\InternetSettings', 'KeepAliveTimeOut');
  if String(vReg) = '' then
    SetRegistry(HKEY_CURRENT_USER, 'SOFTWARE\Microsoft\Windows\CurrentVersion\InternetSettings', 'KeepAliveTimeOut',  Integer(360000));

  if Ping then
  begin
    DM.OpenCloud('select AMT_CHARGE - AMT_USE + AMT_FAILURE '
                                +'  from SMS_COUNT '
                                +' where CD_CUSTOMER =:P0 ',
                                [Common.Config.StoreCode],jsonSMSURL);

    if not DM.CloudData.Eof then
      ChargeInfoButton.Caption := Format('%12.12s',[FormatFloat(',0 원',DM.CloudData.Fields[0].AsInteger)]);

    DM.CloudData.Close;
  end
  else DM.CloudConnected := false;


  if DM.CloudConnected then
  begin
    DM.CloudData.Close;
    if not DM.OpenCloud('select a.CD_PARTNER, '
                +'       b.POS_NOTICE '
                +'  from CUSTOMER a inner join '
                +'       PARTNER  b on b.CD_PARTNER = a.CD_PARTNER '
                +' where a.CD_COMPANY  =:P0 '
                +'   and a.CD_CUSTOMER =:P1 ',
                [Common.Config.HeadStoreCode,
                 Common.Config.StoreCode],RestBaseURL) then Exit;

    //협력사에서 공지를 지정했을때
    if not DM.CloudData.Eof then
    begin
      vNotice  := DM.CloudData.FieldByName('POS_NOTICE').AsString;
      vPartner := DM.CloudData.FieldByName('CD_PARTNER').AsString;
    end;
    DM.CloudData.Close;

    if (vNotice = '0') or (vNotice = '') then
      vPartner := '0000';

    DM.OpenCloud('select CD_PARTNER, NOTICE_DATA '
                +'  from PARTNER_NOTICE   '
                +' where DS_SOLUTION = ''O'' '
                +'   and CD_PARTNER  = :P0 '
                +'   and YN_USE      = ''Y'' '
                +' order by SEQ desc '
                +' limit 1 ',
                [vPartner],RestBaseURL);
    if not DM.CloudData.Eof then
    begin
      try
//        vStream := TMemoryStream.Create;
        vStream := DM.CloudData.CreateBLOBStream(DM.CloudData.FieldByName('NOTICE_DATA'), bmRead);
        NoticesEdit.LoadFromStream(vStream);
      finally
        DM.CloudData.Close;
        vStream.Free;
      end;
    end;
  end;


  //3개월 지난 로그화일은 삭제한다
  Common.LogFilesDelete('Work');
  Common.LogFilesDelete('Error');
  Common.LogFilesDelete('Agent');
  Common.LogFilesDelete('CardLog');
  Common.LogFilesDelete('Demon');
  Common.LogFilesDelete('MQ');
end;

procedure TMain_F.FormShow(Sender: TObject);
var   vOSVersionInfoEx   : TOSVersionInfoEx;
begin
  //두번눌리는현상 방지
  ClickTime         := IncSecond(Now,-3);
  InitTableRecord(Common.Table);
  Common.isKFTCDetect := true;

  vOSVersionInfoEx.dwOSVersionInfoSize := SizeOf(TOSVersionInfoEx);
  if GetVersionEx(vOSVersionInfoEx) then
    if (vOSVersionInfoEx.dwPlatformId = VER_PLATFORM_WIN32_NT) and (vOSVersionInfoEx.dwMajorVersion >= 5) then
      Common.IsWindow7 := vOSVersionInfoEx.dwMajorVersion <> 10;

  Tmr_Start.Enabled := True;
end;

function TMain_F.GetHttpURL: String;
begin
  DM.OpenCloud('select a.ID_SERVER, '
              +'       b.HTTPS_DOMAIN, '
              +'       case when c.SERVICE_TYPE = ''S'' then b.HTTPS_PORT else b.HTTPS_PORT_DIST end HTTPS_PORT '
              +'  from COMPANY a inner join '
              +'       SERVER_LIST   as b on b.ID_SERVER = a.ID_SERVER inner join '
              +'       DATABASE_LIST as c on c.ID_SERVER = b.ID_SERVER and c.DB_SEQ = a.DB_SEQ '
              +' where a.CD_COMPANY  =:P0 ',
              [Common.Config.HeadStoreCode],RestBaseURL);

  Result :=  'http://www.exposcloud.co.kr:18009/Orange/';
  if not DM.CloudData.Eof then
  begin
    if DM.CloudData.Fields[0].AsString = '9999' then
      Result := 'http://www.exposcloud.co.kr:38009/Orange/'
    else if DM.CloudData.Fields[0].AsString = '9998' then
      Result := 'http://www.exposcloud.co.kr:38009/Orange/';
  end;
  DM.CloudData.Close;
end;

//**************************************************************************//
//                       출퇴근버튼 클릭 시
//**************************************************************************//
procedure TMain_F.OpenButtonClick(Sender: TObject);
begin
  if MilliSecondsBetween(Now(),ClickTime) < 1000 then Exit;
  ClickTime   := Now;

  if (Common.PosType = ptOnlyOrder) and  (not Common.CheckAcctPos) then Exit;
  Screen.Cursor := crHourGlass;
  if not Common.PosNo_Check then Exit;

  if not Common.Config.IsKiosk or (Common.Config.KioskDispenserPort = 0) then
  begin
    if Common.Config.IsKiosk then
    begin
      Common.KioskTouchBeep('kioskwave12');
      KioskKeyPad_F := TKioskKeyPad_F.Create(Self);
      KioskKeyPad_F.MessageLabel.Caption := '관리자 패스워드를 입력하세요';
      KioskKeyPad_F.isPassword           := true;
      try
        if KioskKeyPad_F.ShowModal <> mrOK then Exit;
        if Common.Config.KioskPwd <> KioskKeyPad_F.KeyInLabel.Hint then
        begin
          Common.ErrBox('패스워드가 올바르지 않습니다');
          Exit;
        end;
      finally
        FreeAndNil(KioskKeyPad_F);
      end;
    end;
    Open_F := TOpen_F.Create(Self);
    Open_F.Left := Trunc(Screen.Monitors[Common.PrimaryMonitors].Width / 2  - Open_F.Width / 2);
    Open_F.Top  := Trunc(Screen.Monitors[Common.PrimaryMonitors].Height / 2 - Open_F.Height / 2);
    try
      Open_F.ShowModal;
      Application.ProcessMessages;
    finally
      FreeAndNil(Open_F);
      FormActivate(nil);
      Screen.Cursor := crDefault;
    end;
  end
  else
  begin
    Common.KioskTouchBeep('kioskwave12');
    KioskKeyPad_F := TKioskKeyPad_F.Create(Self);
    KioskKeyPad_F.MessageLabel.Caption := '관리자 패스워드를 입력하세요';
    KioskKeyPad_F.isPassword           := true;
    try
      if KioskKeyPad_F.ShowModal <> mrOK then Exit;
      if Common.Config.KioskPwd <> KioskKeyPad_F.KeyInLabel.Hint then
      begin
        Common.ErrBox('패스워드가 올바르지 않습니다');
        Exit;
      end;
    finally
      FreeAndNil(KioskKeyPad_F);
    end;

    KioskReady_F := TKioskReady_F.Create(Self);
    KioskReady_F.Left := Trunc(Screen.Monitors[Common.PrimaryMonitors].Width / 2  - KioskReady_F.Width / 2);
    KioskReady_F.Top  := Trunc(Screen.Monitors[Common.PrimaryMonitors].Height / 2 - KioskReady_F.Height / 2);
    try
      KioskReady_F.ShowModal;
      Application.ProcessMessages;
    finally
      FreeAndNil(KioskReady_F);
      Common.Device.OnDispenserReadData :=DispenserReadEvent;
      SetKioskCash;
      FormActivate(nil);
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TMain_F.OrderButtonClick(Sender: TObject);
var vRcpManageMent :Boolean;
    vIndex:Integer;
    vExists :Boolean;
    vBarrierFree :Boolean;
    vKioskStartKey:Integer;
label BarriFreeMode;
begin
  if MilliSecondsBetween(Now(),ClickTime) < 500 then Exit;
  ClickTime      := Now;
  Common.Config.KioskType := '84';
  vBarrierFree   := false;
  vRcpManageMent := false;
  vKioskStartKey := -1;
  Common.Config.BarrierFreeMode  := bfNone;
  Common.isBFChoose := false;

  Common.HideWaitForm;
  if Common.Config.IsKiosk then
  begin
    Common.KioskTouchBeep('kioskwave12');
    OpenQuery('select CD_CODE '
             +'  from MS_CODE '
             +' where CD_STORE =:P0 '
             +'   and CD_KIND  =''84'' '
             +' order by CD_CODE ',
             [Common.Config.StoreCode]);
    if Common.Query.Eof then
    begin
      Common.Query.Close;
      Common.ErrBox('키오스크 디자인 정보가 없습니다');
      Exit;
    end;
    if not Common.KioskAutoOpen then Exit;
  end;

  Common.WorkDate := Common.OpenDate;
  if Trim(Common.Config.UserCode) = '' then
  begin
    Common.ErrBox('계산원 정보가 올바르지 않습니다'+#13#13+'포스를 다시 시작하세요');
    Exit;
  end;

  //자동마감
  if not Common.Config.IsKiosk and (GetOption(375) = '1') and (Common.PosType <> ptOnlyOrder) then
    Common.PosAutoCloseOpen;

  BarriFreeMode:

  try
    Screen.Cursor := crHourGlass;
    if not Common.isBFChoose then
    begin
      if not Common.PosNo_Check then Exit;

      if Common.Config.IsKiosk and (Common.WorkDate = '') then
      begin
        Common.ErrBox('개점을 먼저 해야합니다');
        Exit;
      end;

      if (Common.PosType = ptNotAccount) and (GetOption(46) = '1') then
      begin
        OpenQuery('select Count(*) cnt '
                 +'  from SL_POSCLOSE '
                 +' where CD_STORE  =:P0 '
                 +'   and NO_POS    =:P1 '
                 +'   and DS_STATUS =''O'' ',
                 [Common.Config.StoreCode,
                  Common.Config.PosNo]);

        if Common.Query.FieldByName('cnt').AsInteger = 0 then
        begin
          Common.Query.Close;
          Common.ErrBox('개점을 해야 주문을 할 수 있습니다');
          Exit;
        end;
        Common.Query.Close;
      end;

      //주방모니터 사용시 메인포스의 개점일자와 같은지 체크한다
      //개점일자가 다르면 주방모니터에 표시가 안됨
      vExists := false;
      for vIndex := 0 to High(Common.KitchenPrinter) do
      begin
        if Common.KitchenPrinter[vIndex].IsKDS then
        begin
          vExists := true;
          Break;
        end;
      end;


      if (Common.Config.MainPosNo <> Common.Config.PosNo) and (Common.PosType <> ptOnlyOrder) and vExists  then
      begin
        OpenQuery('select Max(YMD_CLOSE) '
                 +'  from SL_POSCLOSE '
                 +' where CD_STORE  =:P0 '
                 +'   and NO_POS    =:P1 '
                 +'   and DS_STATUS =''O'' ',
                 [Common.Config.StoreCode,
                  Common.Config.MainPosNo]);

        if (Common.Query.Fields[0].AsString = '') then
        begin
          Common.Query.Close;
          Common.MsgBox(Format('메인포스(%s)가 개점되지 않았습니다',[Common.Config.MainPosNo]));
          Exit;
        end;

        if Common.Query.Fields[0].AsString <> Common.WorkDate then
        begin
          Common.MsgBox(Format('메인포스(%s)와'#13'개점일자(%s) 다릅니다',[Common.Config.MainPosNo, Common.Query.Fields[0].AsString]));
          Common.Query.Close;
          Exit;
        end;
        Common.Query.Close;
      end;

      //스마트패드를 사용할때는 사용시간을 체크한다
      if Common.Config.SmartPad then
        Common.Device.SendToPad(#2+'time'+#2+''+#2, true);
    end;


    //테이블방식
    if not Common.Config.IsTakeOut and not Common.Config.IsKiosk then
    begin
      Table_F := TTable_F.Create(Self);
      Table_F.Top    := 0;
      Table_F.Left   := 0;
      try
//        Application.ProcessMessages;
        Self.Enabled := false;
        Table_F.ShowModal;
      finally
        Self.Enabled := true;
        try
          if Assigned(Order_F) then
            FreeAndNil(Order_F);
          FreeAndNil(Table_F);
        except
        end;
      end;
    end
    else {선불제 방식}
    begin
      if (Common.OrderKind <> okSaleChange) then
        Common.OrderKind := okNew;
      InitTableRecord(Common.Table);
      Common.ClearGrid(Common.Card_SGrd);        //카드그리드초기화
      InitCardRecord(Common.Card);               //신용카드정보초기화
      Common.ClearGrid(Common.Cash_SGrd);        //현금영수증그리드초기화

      if Common.isBFChoose and (Common.Config.BarrierFreeMode = bfWheelChair) then
        Common.Config.KioskType := '85'
      else if Common.isBFChoose and (Common.Config.BarrierFreeMode = bfLowVision) then
        Common.Config.KioskType := '86'
      else
        Common.Config.KioskType := '84';
      Order_F := TOrder_F.Create(Self);
      try
        if Common.Config.IsKiosk then
        begin
          Order_F.KioskStartKey := vKioskStartKey;
        end;
        if Order_F.ShowModal = mrAbort then
        begin
          vKioskStartKey := Order_F.KioskStartKey;
          Common.ShowWaitForm('잠시만 기다려 주세요');
          vRcpManageMent := true;
        end
        else
          vRcpManageMent := false;
      finally
        FreeAndNil(Order_F);
        Common.Device.OnDispenserReadData :=DispenserReadEvent;
        SetKioskCash;
      end;
    end;
    Application.ProcessMessages;
  finally
    //키오스크일때는 주문화면에서만 다국어를 적용한다
    if Common.Config.IsKiosk and (Common.Config.PosLanguage <> 'KO') then
    begin
      Common.Config.PosLanguage  := 'KO';
      Common.Config.LanguagePath := '';
    end;

    Common.Device.OnCidReadData := nil;
    Screen.Cursor := crDefault;
    if Common.WorkDate <> '' then
      lbl_WorkDate.Caption   := FormatMaskText('!0000년 90월 90일;0; ',Common.WorkDate)
    else
      lbl_WorkDate.Caption   := '개점안됨';

    if Common.LastCloseDate <> '' then
      lbl_CloseDate.Caption  := FormatMaskText('!0000년 90월 90일;0; ',Common.LastCloseDate)
    else
      lbl_CloseDate.Caption  := '마감내역없음';
  end;

  if vRcpManageMent then
  begin
    if Common.Config.IsKiosk then
      goto BarriFreeMode
    else
      RcpManagerTimer.Enabled := true;
  end
  else
  begin
    FormActivate(nil);
    Common.ShowNormalDualScreen;
  end;
end;

procedure TMain_F.OrderTimerTimer(Sender: TObject);
begin
  OrderTimer.Enabled := false;
  OrderButtonClick(nil);
end;

procedure TMain_F.PosCloseButtonClick(Sender: TObject);
var vTemp :String;
begin
  if MilliSecondsBetween(Now(),ClickTime) < 1000 then Exit;
  ClickTime   := Now;

  if (GetOption(29) <> '0') and (Common.Config.ClosePass <> '') then
  begin
    vTemp := Common.ShowNumberForm('패스워드를 입력하세요', 16);
    if vTemp = 'mrClose' then Exit;

    if Common.Config.ClosePass <> vTemp then
    begin
      Common.MsgBox('패스워드가 올바르지 않습니다');
      Exit;
    end;
  end;

  if Common.PosType = ptOnlyOrder then Exit;
  Common.WorkDate := Common.OpenDate;
  if not Common.Config.IsKiosk then
  begin
    try
      Screen.Cursor := crHourGlass;
      if GetUserOption(5) = '0' then
      begin
        if GetOption(172) = '0' then
        begin
          Common.ErrBox('마감업무가 지정된 사용자만'+#13#13+'사용이 가능합니다');
          Exit;
        end
        else
        begin
          if not Common.CheckAuthority(5) then Exit;
        end;
      end;
      if not Common.PosNo_Check then Exit;

      CashierMgm_F := TCashierMgm_F.Create(Self);
      try
        CashierMgm_F.ShowModal;
      finally
        FreeAndNil(CashierMgm_F);
      end;
    finally
      lbl_WorkDate.Caption   := FormatMaskText('!0000년 90월 90일;0; ',Common.WorkDate);
      lbl_CloseDate.Caption  := FormatMaskText('!0000년 90월 90일;0; ',Common.LastCloseDate);
      Screen.Cursor    := crDefault;
    end;
  end
  else
  begin
    try
      Screen.Cursor := crHourGlass;
      if not Common.PosNo_Check then Exit;

    Common.KioskTouchBeep('kioskwave12');
    KioskKeyPad_F := TKioskKeyPad_F.Create(Self);
    KioskKeyPad_F.MessageLabel.Caption := '관리자 패스워드를 입력하세요';
    KioskKeyPad_F.isPassword           := true;
    try
      if KioskKeyPad_F.ShowModal <> mrOK then Exit;
      if Common.Config.KioskPwd <> KioskKeyPad_F.KeyInLabel.Hint then
      begin
        Common.ErrBox('패스워드가 올바르지 않습니다');
        Exit;
      end;
    finally
      FreeAndNil(KioskKeyPad_F);
    end;

      KioskCashierMgm_F := TKioskCashierMgm_F.Create(Self);
      try
        KioskCashierMgm_F.ShowModal;
      finally
        FreeAndNil(KioskCashierMgm_F);
        Common.Device.OnDispenserReadData :=DispenserReadEvent;
        SetKioskCash;
      end;
    finally
      lbl_WorkDate.Caption   := FormatMaskText('!0000년 90월 90일;0; ',Common.WorkDate);
      lbl_CloseDate.Caption  := FormatMaskText('!0000년 90월 90일;0; ',Common.LastCloseDate);
      Screen.Cursor    := crDefault;
    end;
  end;
end;

procedure TMain_F.RcpManagerTimerTimer(Sender: TObject);
var vOption10 : Char;
begin
  //선불제에서 영수증관리
  RcpManagerTimer.Enabled := false;
  RcpChange_F := TRcpChange_F.Create(Self);
  try
    vOption10 := Common.Config.Options[10];
    Order_F := TOrder_F.Create(Self);

    RcpChange_F.ShowMode := fsmNone;
    RcpChange_F.ShowModal;
  finally
    Common.Config.Options[10] := vOption10;
    FreeAndNil(RcpChange_F);
    if Assigned(Order_F) then
      FreeAndNil(Order_F);

    OrderTimer.Enabled := true;
  end;
end;

// 데몬으로부터 메세지를 받는다 (신용카드 데이터)//
procedure TMain_F.WMCopyData(var Msg:TWmCopyData);
var
 vDevice :Integer;
 vData :AnsiString;
begin
  try
    SetString(vData, PAnsiChar(Msg.CopyDataStruct.lpData), Msg.CopyDataStruct.cbData);
    if LeftStr(vData,12) = 'ConfigChange' then
    begin
      if GetHeadOption(10) = '1' then Exit;
      if not Common.TRSendMessage('DOWNLOAD') then
        Exit;
      Common.ShowWaitForm('기초자료를 다운로드 합니다');
      Common.SelectStoreInfo;
      Common.HideWaitForm;
    end
    else if LeftStr(vData,4) = 'BELL' then
    begin
      Common.WriteLog('work', Format('WMCopyData-%s, %s, %s',[vData, CopyPos(vData,'|',1), CopyPos(vData,'|',2)]));
      Common.BellCall(StrToInt(CopyPos(vData,'|',1)), CopyPos(vData,'|',2));
    end
    else if Copy(vData,1,10) = 'DemonPrint' then
    begin
      vData := Copy(vData,11, Length(vData)-10);
      if Length(vData) < 20 then Exit;

      Common.Device.PrintData := vData;
      Common.Device.PrintPrinter;
    end
    else if Copy(vData,1,15) = 'LetsOrder_Print' then
    begin
      vData := Replace(vData, #0,'');
      vData := Copy(vData,16, Length(vData)-15);
      Common.Device.PrintData :=vData;
      try
        Common.LetsOrderPrint := true;
        Common.Device.PrintPrinter(rptLetsOrder);
      finally
        Common.LetsOrderPrint := false;
      end;
    end
    else if Copy(vData,1,17) = 'LetsOrder_Kitchen' then
    begin
      vData := Replace(vData, #0,'');
      vData := Copy(vData,18, Length(vData)-17);
      Common.Device.PrintData :=vData;
      try
        Common.LetsOrderPrint := true;
        Common.Device.PrintPrinter(0);
      finally
        Common.LetsOrderPrint := false;
      end;
    end
    else if (Copy(vData,1,17) = 'LetsOrder_Service') then
    begin
      //Table에 Hot Image
      if Assigned(Table_F) and Table_F.Active then
        Table_F.SetLetsOrderHotImage;

      vData := Replace(vData, #0,'');
      vData := Copy(vData,18, Length(vData)-17);
      if ((GetOption(83)='0') or  Common.Config.LetsOrderNoShow) and ((CopyPos(vData,#28,0) = '호출') or (CopyPos(vData,#28,0) = '주문')) then Exit;

      Common.HideLetsOrderServiceForm;
      Common.ShowLetsOrderServiceForm(vData);
    end
    else if Copy(vData,1,16) = 'LetsOrderTakeOut' then
    begin
      if Assigned(Order_F) and Order_F.Showing and Order_F.Active then Exit;

      vData := Replace(vData, #0,'');
      vData := Copy(vData,18, Length(vData)-17);
      Common.HideLetsOrderServiceForm;
      Common.ShowLetsOrderServiceForm(vData);
    end
    else if Copy(vData,1,13) = 'DownLoadFinsh' then
    begin
      if isDownLoad then
        Common.SelectStoreInfo;

      isDownLoad := false;
    end
    else if Copy(vData,1,7) = 'TRStart' then
    begin
      Common.KillTask('OrangeTR.exe');
      Sleep(1000);
      ExcuteProgram('OrangeTR.exe','pos');
    end
    else if (Length(vData) > 20) then
    begin
      Common.Device.PrintData := vData;
      Common.Device.PrintPrinter(rptLetsOrder);
    end;
  except
    on E: Exception do
      Common.WriteLog('Main_WMCopyData',E.Message);
  end;
end;

procedure TMain_F.WndProc(var Message: TMessage);
var vTemp :String;
begin
  if Common.isKFTCDetect and (Common.Config.van_trd = vanKFTC) and (Message.Msg = WM_USER + 10000) then
  begin
    Common.WriteLog('work', 'KFTCDetect');
    Common.isKFTCDetect := false;
    vTemp := IntToStr(Message.WParam);

    Common.KFTCDetectData := vTemp;
    if  Assigned(Card_F) and Card_F.Showing then
    begin
      if Card_F.ApprovalButton.Enabled then
      begin
        Card_F.isCardFormDetect   := true;
        Card_F.Tmr_Execute.Enabled := True;
      end
      else
        Common.isKFTCDetect := true;
    end
    else if Assigned(Order_F) and Order_F.Showing and Order_F.Active then
    begin
      Order_F.Tmr_Card.Enabled := True;
    end
    else
      Common.isKFTCDetect := true;
  end;
  inherited WndProc(Message);
end;

procedure TMain_F.WorkButtonClick(Sender: TObject);
begin
  if MilliSecondsBetween(Now(),ClickTime) < 1000 then Exit;
  ClickTime   := Now;
  try
    Screen.Cursor := crHourGlass;
    if not Common.PosNo_Check then Exit;

    if WorkButton.Tag = 0 then
    begin
      Work_F := TWork_F.Create(Self);
      try
        Work_F.ShowModal;
      finally
        FreeAndNil(Work_F);
      end;
    end
    else
    begin
      case Common.PosType of
        ptNotAccount :
        begin
           if (Trim(Common.WorkDate) = '') then
           begin
             Common.ErrBox('개점이 안됐습니다'+#13#13+'개점을 해야 사용할 수 있습니다');
             Exit;
           end;
        end;
      end;

      if GetOption(368) = '0' then
      begin
        Delivery_F := TDelivery_F.Create(Self);
        try
          Delivery_F.ShowModal;
        finally
          FreeAndNil(Delivery_F);
        end;
      end
      else
      begin
        DeliveryNew_F := TDeliveryNew_F.Create(Self);
        try
          DeliveryNew_F.ShowModal;
        finally
          FreeAndNil(DeliveryNew_F);
        end;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TMain_F.StoreNameLabelClick(Sender: TObject);
begin
  Common.LogoClick(nil);
end;

procedure TMain_F.MasterDownLoadButtonClick(Sender: TObject);
var    vGetTime :Cardinal;
begin
  if not Common.TRSendMessage('ALLDOWNLOAD') then
  begin
    Common.MsgBox('TR 접속오류');
    Exit;
  end;
  Common.ShowWaitForm('기초자료를 다운로드 합니다');
  isDownLoad := true;
  vGetTime := GetTickCount;
  //최대 5초까지 기다린다
  while isDownLoad and (vGetTime + 5000 > GetTickCount) do Application.ProcessMessages;
    Common.HideWaitForm;
end;

procedure TMain_F.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  try
    if not Common.AskBox('프로그램을'#13'종료하시겠습니까?') then
    begin
      CanClose := False;
      Exit;
    end;

    if Common.Config.PowerOff then
      Common.Shutdown;
  except
    CanClose := False
  end;
end;

procedure TMain_F.FormActivate(Sender: TObject);
var vTemp :String;
begin
  Common.WorkDate := Common.OpenDate;
  try
    CustomerNoLabel.Caption     := Format('고객번호 %s',[Common.Config.StoreCode]);
    VersionLabel.Caption        := Format('Ver. %s',[GetFileVersion(Application.ExeName)]);
    StoreNameLabel.Caption       := Common.GetPaPago(Common.Config.StoreName);
    if Length(StoreNameLabel.Caption) > 15 then
      StoreNameLabel.Style.Font.Size := 25;


    case Common.PosType of
      ptAccount,
      ptNotAccount : vTemp := Common.GetPaPago('정산포스');
      ptOnlyOrder :  vTemp := Common.GetPaPago('주문포스');
    end;

    PosNoLabel.Caption     := Format('%s - %s',[Common.Config.PosNo, vTemp]);
    CashierLabel.Caption   := Format('%s',[Common.Config.UserName]);
    lbl_WorkDate.Caption   := FormatMaskText('!0000년 90월 90일;0; ',Common.WorkDate);
    lbl_CloseDate.Caption  := FormatMaskText('!0000년 90월 90일;0; ',Common.LastCloseDate);

    if not Common.Config.IsKiosk then
      Common.SetLanguage(Self);
  except
    on E: Exception do
      Common.WriteLog('TMain_F.FormActivate',E.Message);
  end;
end;

procedure TMain_F.Tmr_StartTimer(Sender: TObject);
  function isFileDown(aFileName:String):String;
  var vErrCnt :Integer;
  label Loop;
  begin
    vErrCnt := 0;
    Result  := '';
    Loop:
    try
      IdHTTP.Head(aFileName);
      vErrCnt := 0;
    except
      Inc(vErrCnt);
    end;
    if (vErrCnt > 0) and (vErrCnt < 6) then
      Goto Loop;

    if vErrCnt > 0 then
      Result := '-1';
  end;
var Hnd :THandle;
    vTemp     :String;
    RcvData   :String;
    vNoticeNo : WideString;
    vFirstRow: Integer;
    vResult: Boolean;
    vParamsType,
    vResultStr: WideString;
    vServerVersion,
    vVersion  :String;
    vProcess32  :Cardinal;
    vProcess :THandle;
    vHTTPPath :String;
    vDsStore  :String;
    vFileStream: TMemoryStream;
    vStream :TStream;
    vPath :String;
    vReg    :Variant;
    vGetTime :Cardinal;
    vDiskSize :Currency;
begin
  Tmr_Start.Enabled := False;
  if not Common.IsDebugMode then
    BlockInput(true);

  try
    try
      Common.ShowWaitForm('프로그램을 시작하는 중입니다...');

      Common.isSupportLicense := LeftStr(Common.Config.StoreCode,2) = 'TT';

      if Common.Config.SmartPosDemon then
        ExcuteProgram(Common.AppPath+'SmartAgent.exe');

      if not Common.RunningProgram('Demon.exe') then
      begin
        Common.MsgBox('데몬이 실행되지 않았습니다'+#13#13+
                      '데몬이 실행되지 않으면 주방주문서가'+#13+
                      '출력되지 않습니다');
      end;

      //VCAT 프로그램 실행
      if (Common.PosType <> ptOnlyOrder) and (GetOption(379)='2') and (Common.Config.van_trd = vanKSNET) then
      begin
        if FileExists('C:\KSCAT\KSCAT.exe') then
        begin
         if not Common.RunningProgram('KSCAT.exe') then
            ExcuteProgram('C:\KSCAT\KSCAT.exe');
        end
        else
          Common.MsgBox('KSCAT이'#13'설치되지 않았습니다');
      end
      else if (Common.PosType <> ptOnlyOrder) and (GetOption(379)='2') and (Common.Config.van_trd = vanKOCES) then
      begin
        if FileExists('C:\Koces\KocesICPos\KocesICAutoUp.exe') then
        begin
          if not Common.RunningProgram('KocesICPos.exe') then
            ExcuteProgram('C:\Koces\KocesICPos\KocesICAutoUp.exe');
        end
        else if FileExists('C:\Koces\KocesICPos\KocesICPos.exe') then
        begin
          if not Common.RunningProgram('KocesICPos.exe') then
            ExcuteProgram('C:\Koces\KocesICPos\KocesICPos.exe');
        end
        else
          Common.MsgBox('KocesICPos가'#13'설치되지 않았습니다');
      end
      else if (Common.PosType <> ptOnlyOrder) and (GetOption(379)='2') and (Common.Config.van_trd = vanJTNET) then
      begin
        if FileExists('C:\JTNet\JTtPayDaemon.exe') then
        begin
          if not Common.RunningProgram('JTtPayDaemon.exe') then
            ExcuteProgram('C:\JTNet\JTtPayDaemon.exe');
        end
        else
          Common.MsgBox('JTtPayDaemon이'#13'설치되지 않았습니다');
      end
      else if (Common.PosType <> ptOnlyOrder) and (GetOption(379)='2') and (Common.Config.van_trd = vanKOVAN) then
      begin
        if FileExists('C:\KOVAN\VPos_PlusLite.exe') then
        begin
          if not Common.RunningProgram('VPos_PlusLite.exe') then
            ExcuteProgram('C:\KOVAN\VPos_PlusLite.exe');
        end
        else if FileExists('C:\KOVAN\VPos_Connector.exe') then
        begin
          if not Common.RunningProgram('VPos_Connector.exe') then
            ExcuteProgram('C:\KOVAN\VPos_Connector.exe');
        end
        else
          Common.MsgBox('VPOS가설치되지 않았습니다');
      end
      else if (Common.PosType <> ptOnlyOrder) and (GetOption(379)='2') and (Common.Config.van_trd = vanKIS) then
      begin
        if FileExists('C:\Program Files (x86)\KIS-NAGT\KIS-NAGT.exe') then
        begin
          if not Common.RunningProgram('KIS-NAGT.exe') then
            ExcuteProgram('C:\Program Files (x86)\KIS-NAGT\KIS-NAGT.exe');
        end
        else if FileExists('C:\Program Files\KIS-NAGT\KIS-NAGT.exe') then
        begin
          if not Common.RunningProgram('KIS-NAGT.exe') then
            ExcuteProgram('C:\Program Files\KIS-NAGT\KIS-NAGT.exe');
        end
        else
          Common.MsgBox('KIS Agent가'#13'설치되지 않았습니다');
      end
      else if (Common.PosType <> ptOnlyOrder) and (GetOption(379)='2') and (Common.Config.van_trd = vanFDIK) then
      begin
        Common.ICCard.VAN     := vtFDIK;
        Common.ICCard.AppType := atOnlyICInit;
        Common.ICCard.Execute;
      end
      else if (Common.PosType <> ptOnlyOrder) and (GetOption(379)='2') and (Common.Config.van_trd = vanDaou) then
      begin
        //투밴기능은 강제로 옵션을 해제한다
        Common.Config.Options[60] := '0';
        with TIniFile.Create(Common.AppPath+'SvkPosCfg.ini') do
          try
            WriteString('CONFIG', 'TERMINAL_ID', Common.Config.van_Terid);
            WriteString('CONFIG', 'REGIST_NUMB', GetOnlyNumber(Common.Config.BizNo));
            WriteString('CONFIG', 'SVK_SYSTEM', 'REAL');
            WriteString('CONFIG', 'AUTO_RUN',   'N');
            WriteString('CONFIG', 'HIDE_WINDOW', 'Y');
            if Common.Config.IsKiosk then
            begin
              WriteString('CONFIG', 'IS_KIOSK', 'N');
              WriteString('CONFIG', 'INTERNAL_SIGN', 'N');
              WriteString('CONFIG', 'VIRTUAL_SIGNPAD', 'Y');
            end;
          finally
            Free;
          end; // try .. finally ..

        if FileExists(Common.AppPath+'DaouVP.exe') then
        begin
          if not Common.RunningProgram('DaouVP.exe') then
            ExcuteProgram(Common.AppPath+'DaouVP.exe');
        end
        else
          Common.MsgBox('가상단말기 프로그램(DaouVP)이'#13'설치되지 않았습니다');
      end
      else if (Common.PosType <> ptOnlyOrder) and (GetOption(379)='2') and (Common.Config.van_trd = vanKICC) then
      begin
        if FileExists('C:\Kicc\EasyCardK\EasyCard.exe') then
        begin
          with TIniFile.Create('C:\Kicc\EasyCardK\SETUP\OPTION.ini') do
            try
              WriteString('SETUP', 'CHARSET', 'UTF-8');
            finally
              Free;
            end;

          if not Common.RunningProgram('EasyCard.exe') then
          begin
            ExcuteProgram('C:\Kicc\EasyCardK\EzStart.exe');
            ExcuteProgram('C:\Kicc\EzMSR2\EzStart.exe');
          end;
        end
        else
          Common.MsgBox('가상단말기 프로그램(EasyCard.exe)이'#13'설치되지 않았습니다');
      end
      else if (Common.PosType <> ptOnlyOrder) and (GetOption(379)='2') and (Common.Config.van_trd = vanKCP) then
      begin
        Common.ICCard.VAN     := vtKCP;
        Common.ICCard.AppType := atVCatCash;
        Common.ICCard.Execute;
      end
      else if (Common.PosType <> ptOnlyOrder) and (GetOption(379)='2') and (Common.Config.van_trd = vanSmartro) then
      begin
        if Common.isWindows64 then
          vReg := GetRegistry(HKEY_LOCAL_MACHINE, 'SOFTWARE\WOW6432Node\VCAT', 'PATH')
        else
          vReg := GetRegistry(HKEY_LOCAL_MACHINE, 'SOFTWARE\VCAT', 'PATH');

        if (VarType(vReg) = varString) or (VarType(vReg) = varUString)   then
          vPath := String(vReg);

        if (vPath <> '') and  FileExists(vPath+'VCatAutoRun.exe') then
        begin
          if not Common.RunningProgram('VCat.exe') then
            ExcuteProgram(vPath+'VCatAutoRun.exe');
        end
        else
          Common.MsgBox('가상단말기 프로그램(VCatRun.exe)이'#13'설치되지 않았습니다');
      end
      else if (Common.PosType <> ptOnlyOrder) and (GetOption(379)='2') and (Common.Config.van_trd = vanFDIK) then
      begin
        Common.ICCard.VAN     := vtFDIK;
        Common.ICCard.AppType := atOnlyICInit;
        Common.ICCard.Execute;
      end
      else if (Common.PosType <> ptOnlyOrder) and (GetOption(379)='2') and (Common.Config.van_trd = vanKFTC) then
      begin
          if not Common.RunningProgram('KFTCOneCAP.exe') then
            ExcuteProgram('C:\Program Files (x86)\KFTCOneCAP\KFTCOneCAP.exe');

        //멀티패드사용시(구형장비는 안됨)
        if Common.Config.VanEasyPay = 'M' then
        begin
          SetRegistry(HKEY_CURRENT_USER, 'SOFTWARE\KFTC_VAN\KFTCOneCAP\SERIALPORT', 'INTERLOCK', 'TRANSINFO');
          SetRegistry(HKEY_CURRENT_USER, 'SOFTWARE\KFTC_VAN\KFTCOneCAP\SERIALPORT', 'TRANS_TYPE', 'RQ');
        end;
        if GetRegistry(HKEY_CURRENT_USER, 'SOFTWARE\KFTC_VAN\KFTCOneCAP\SERIALPORT', 'COMPORT2') = '미사용' then
        begin
          SetRegistry(HKEY_CURRENT_USER, 'SOFTWARE\KFTC_VAN\KFTCOneCAP\SERIALPORT', 'CARD_DETECT', '0');
          SetRegistry(HKEY_CURRENT_USER, 'SOFTWARE\KFTC_VAN\KFTCOneCAP\SERIALPORT', 'DETECT_PROGRAM', 'PosMain_F');
          SetRegistry(HKEY_CURRENT_USER, 'SOFTWARE\KFTC_VAN\KFTCOneCAP\SERIALPORT', 'PORT_ALWAYSOPEN', '0');
        end;
      end
      else if (Common.PosType <> ptOnlyOrder) and (GetOption(379)='2') and (Common.Config.van_trd = vanSPC) then
      begin
        if FileExists('C:\Spc\SpcnVirtualPos.exe') then
        begin
          if not Common.RunningProgram('SpcnVirtualPos.exe') then
          begin
            with TIniFile.Create('C:\Spc\SpcnPosCfg.ini') do
              try
                WriteString('VIRTUAL_POS', 'AUTO_RUN', 'Y');
              finally
                Free;
              end;

            ExcuteProgram('C:\Spc\SpcnVirtualPos.exe');
          end;
        end
        else
          Common.MsgBox('가상단말기 프로그램이'#13'설치되지 않았습니다');
      end;

      //정산포스인데 개점을 하지 않았을때
      if not Common.Config.IsKiosk and (Common.PosType = ptNotAccount) then
      begin
        Common.HideWaitForm;
        OpenButtonClick(nil);
      end;

      //듀얼이미지 다운로드
      DualFilesDownLoad;
      KioskFilesDownLoad;

      //듀얼을 사용하면
      Common.ShowNormalDualScreen;

      if not Common.Config.IsKiosk and (Common.PosType = ptAccount) then
      begin
        if not Common.Config.AutoLogin and (Common.WorkDate <> Common.NowDate) then
          Common.MsgBox('시스템일자와 매출일자가 같지 않습니다');
      end;


      //TR을 실행시킨다(DB가 설치된 포스일때)
      if Common.IsDBServer then
      begin
        if FileExists(Common.AppPath+'Download\OrangeTR.exe') then
        begin
          Common.KillTask('OrangeTR.exe');
          CopyFile(PWideChar(Common.AppPath+'OrangeTR.exe'), PWideChar(Common.AppPath+'Download\OrangeTR.exe'), false);
          DeleteFile(PWideChar(Common.AppPath+'Download\OrangeTR.exe'));
        end;
        ExcuteProgram(Common.AppPath+'OrangeTR.exe');

        //TR 무조건 업데이트
        vFileStream := TMemoryStream.Create;
        with vFileStream do
          try
            vHTTPPath := 'http://www.xn--6j1b831b.kr:84/FTP\Update\CloudOrange\FrontOffice\';
            if not FileExists(Common.AppPath+'OrangeTR.exe') then
            begin
              vProcess32 := Common.GetProcess('ORANGETR.EXE');
              if vProcess32 > 0 then
              begin
                vProcess   := OpenProcess(PROCESS_ALL_ACCESS, TRUE, DWORD(vProcess32));
                if TerminateProcess(vProcess, 0) then
                begin
                  try
                    Common.ShowWaitForm('TR 프로그램을 업데이트 중입니다.... ');
                    DeleteFile(Common.AppPath+'OrangeTR.exe');
                    IdHTTP.Get(vHTTPPath+'OrangeTR.exe', vFileStream);
                    vFileStream.SaveToFile(Common.AppPath+'OrangeTR.exe');
                  finally
                    Common.HideWaitForm;
                  end;
                end;
              end
              else
              begin
                try
                  Common.ShowWaitForm('TR 프로그램을 업데이트 중입니다.... ');
                  if FileExists(Common.AppPath+'OrangeTR.exe') then
                    DeleteFile(Common.AppPath+'OrangeTR.exe');
                  if isFileDown(vHTTPPath+'OrangeTR.exe') <> '-1' then
                  begin
                    IdHTTP.Get(vHTTPPath+'OrangeTR.exe', vFileStream);
                    vFileStream.SaveToFile(Common.AppPath+'OrangeTR.exe');
                  end;
                finally
                  Common.HideWaitForm;
                end;
              end;
            end;
          finally
            Free;
          end; // try .. finally ..
          if not Common.RunningProgram('OrangeTR.exe') then
          begin
            Common.MsgBox('TR 실행되지 않았습니다'+#13#13+
                          '서버에 데이터 전송이 되지 않습니다');
          end;
          TR_Start.Enabled := true;

      end;

      OpenQuery('select Count(*) '
               +'  from MS_CODE '
               +' where CD_STORE =:P0 '
               +'   and CD_KIND  =''01'' '
               +'   and NM_CODE3 in (''0'',''1'',''2'') ',
               [Common.Config.StoreCode]);


      if (Common.Query.Fields[0].AsInteger > 1) and not Common.IsDebugMode then
      begin
        //나보다 상위버젼을 사용하는 포스가 있을때
        OpenQuery('select POS_VERSION '
                 +'  from MS_STORE '
                 +' where CD_STORE =:P0 ',
                 [Common.Config.StoreCode]);

        vTemp := Common.Query.Fields[0].AsString;
        if (CharCnt(vTemp,'.') = 3) and (Length(vTemp) < 12) then
        begin
          vTemp := vTemp+'.';
          vVersion := Format('%.04d.%.02d.%.02d.%d', [StoI(CopyPos(vTemp,'.',0)),
                                                      StoI(CopyPos(vTemp,'.',1)),
                                                      StoI(CopyPos(vTemp,'.',2)),
                                                      StoI(CopyPos(vTemp,'.',3))]);

          ExecQuery('update MS_STORE '
                   +'   set POS_VERSION =:P1 '
                   +' where CD_STORE    =:P0 ',
                   [Common.Config.StoreCode,
                    vVersion]);

          vTemp := vVersion;
        end;

        if vTemp > GetFileVersion(Application.ExeName) then
        begin
          Common.SetIniFile('POS','UPDATE', true);
          Common.SetIniFile('POW','UPDATE_PWD', '15444171');

          if Common.AskBox('다른포스가 상위버젼을 사용 중 입니다'+#13+'업데이트를 받으시겠습니까?') then
          begin
            ExecuteProgram('','Demon.exe','UPDATE');
            Application.Terminate;
            Exit;
          end;
        end;

        //내가 가장상위 버젼일때
        if Common.Query.Fields[0].AsString < GetFileVersion(Application.ExeName) then
        begin
          ExecQuery('update MS_STORE '
                   +'   set POS_VERSION =:P1 '
                   +' where CD_STORE    =:P0 ',
                   [Common.Config.StoreCode,
                    GetFileVersion(Application.ExeName)]);
        end;
      end;
      Common.Query.Close;

      OpenQuery('select * '
               +'  from MS_CODE '
               +' where CD_STORE =:P0 '
               +'   and CD_KIND = ''14'' '
               +'   and DS_STATUS = ''0'' '
               +' order by CD_CODE '
               +' limit 6 ',
               [Common.Config.StoreCode]);

      Common.AgeData.Clear;
      while not Common.Query.Eof do
      begin
        Common.AgeData.Add(Common.Query.FieldByName('cd_code').AsString+'000');
        Common.Query.Next;
      end;
      Common.Query.Close;

      if Common.AgeData.Count = 0 then
        Common.AgeData.Add('001000');

      Common.IsMainFormLoad := True;
    finally
      Common.HideWaitForm;
    end;

    if Common.Config.IsKiosk and Common.Config.IsKioskCash then
    begin
      OpenQuery('select KIOSK_1000, '
               +'       KIOSK_100 '
               +'  from MS_CODE '
               +' where CD_STORE = :P0 '
               +'   and CD_KIND  = ''01'' '
               +'   and NM_CODE1 = :P1 '
               +'   and NM_CODE3 = ''2'' ',
               [Common.Config.StoreCode,
                Common.Config.PosNo]);

      if not Common.Query.Eof then
      begin
        Common.Config.KioskAlram[0] := Common.Query.FieldByName('KIOSK_1000').AsInteger;
        Common.Config.KioskAlram[1] := Common.Query.FieldByName('KIOSK_100').AsInteger;
      end
      else
      begin
        Common.Config.KioskAlram[0] := 0;
        Common.Config.KioskAlram[1] := 0;
      end;
      Common.Query.Close;
      Sleep(1000);
      if Common.Config.KioskDispenserPort > 0 then
        SetKioskCash
      else
        Common.MsgBox('현금지급기 포트 설정안됨');
    end;

    //스마트패드를 사용할때는 사용시간을 체크한다
    if Common.Config.SmartPad then
      Common.Device.SendToPad(#2+'time'+#2+''+#2, true);

    //RustDesk 실행안되어 있으면 실행한다
    EnsureRustDeskRunning;

    ExtremeNotice;
  finally
    BlockInput(false);
  end;

  if Common.IsDBServer then
  begin
    vDiskSize := Round(DiskFree(0) / 1024 / 1024);

    if vDiskSize < 300 then
    begin
      Common.WriteLog('work', '디스크 여유공간을 확인해주세요('+FtoS(vDiskSize)+'MB)', true);
      Common.MsgBox('디스크 여유공간을 확인해주세요'+#13+'('+FtoS(vDiskSize)+'MB)');
    end;
  end;

  if not FileExists('libeay32.dll') then
    Common.FileDownLoad('libeay32.dll','');

  if not FileExists('ssleay32.dll') then
    Common.FileDownLoad('ssleay32.dll','');

  Common.TmrDemonCheck.Enabled := True;
  if (GetHeadOption(9)='1') and Common.IsDBServer then
    Common.SmartAgentTimer.Enabled := true;

  if Common.IsDBServer then
  begin
    BlockInput(true);
    Common.ShowWaitForm('기초자료를 다운로드 합니다');
    vGetTime := GetTickCount;
    //최대 5초까지 기다린다
    while isDownLoad and (vGetTime + 5000 > GetTickCount) do Application.ProcessMessages;
      Common.HideWaitForm;
    BlockInput(false);
  end;

  if not NoticesPanel.Visible and Common.Config.AutoLogin then
  begin
    Common.HideWaitForm;
    OrderTimer.Enabled := true;
  end;

end;

procedure TMain_F.TR_StartTimer(Sender: TObject);
begin
  TR_Start.Enabled := false;
  ExecuteProgram('','OrangeTR.exe','');
end;

procedure TMain_F.ExposImageClick(Sender: TObject);
var vURL :String;
begin
  vURL := 'https://expos.co.kr';
  if ShellExecute(self.WindowHandle,'open','chrome.exe', PWideChar(vURL), nil, SW_SHOW) < 0 then
    ShellExecute(self.WindowHandle,'open','msedge.exe', PWideChar(vURL), nil, SW_SHOW);
end;

procedure TMain_F.ExtremeNotice;
var vStream :TStream;
begin
  if not DM.CloudConnected then Exit;

  //업데이트 내역있는지 체크(최근 3일내에 업데이트 내역있으면 아이콘 변경), 포스에서는 최대 1개월 업데이트만 표시
  try
    DM.OpenCloud('select SEQ, '
                +'       NOTICE_TITLE, '
                +'       DT_INSERT '
                +'  from UPDATE_NOTICE '
                +' where DS_SOLUTION  =:P0 '
                +'   and DT_INSERT > DATE_ADD(Now(),INTERVAL -3 Day) '
                +' order by SEQ desc '
                +' limit 1 ',
                ['O'],RestBaseURL);
    if not DM.CloudData.Eof then
    begin
      UpDateListButton.OptionsImage.ImageIndex := 1;
      UpDateListButton.Hint    := '업데이트 내역이 있습니다';
    end;
  finally
    DM.CloudData.Close;
  end;
  // 공지사항
  if (GetHeadOption(1) = '1') and not Common.Config.IsKiosk then
  begin
    DM.OpenCloud('select SEQ, '
                +'       DS_SHOW, '
                +'       NOTICE_TEXT '
                +'  from MS_NOTICE '
                +' where CD_HEAD  =:P0 '
                +'   and CD_STORE =:P1 '
                +'   and DS_NOTICE in (''A'',''P'') '
                +'   and (DS_SHOW = ''R'' or (DS_SHOW = ''U''  and not Ifnull(SHOWN_POS,'''') like :P2)) '
                +'   and (ifnull(CD_STORE_NOTICE,'''') = '''' or CD_STORE_NOTICE like :P2) '
                +'   and YMD_FROM <= Date_Format(NOW(), ''%Y%m%d'') '
                +'   and YMD_TO >= Date_Format(NOW(), ''%Y%m%d'') '
                +'   and YN_SHOW = ''Y'' '
                +' order by YN_HOT, SEQ desc '
                +' limit 1 ',
                [Common.Config.HeadStoreCode,
                 StandardStore,
                 '%'+Common.Config.StoreCode+'%'],Common.RestDBURL);

    if not DM.CloudData.Eof then
    begin
      try
        NoticesPanel.Left := Self.Width div 2 - NoticesPanel.Width div 2;
        NoticesPanel.Top  := Self.Height div 2 - NoticesPanel.Height div 2;
        vStream := TMemoryStream.Create;
        NoticesPanel.Visible    := true;
        NoticesEditor.Tag       := DM.CloudData.FieldByName('SEQ').AsInteger;
        NoShowCheckBox.Visible  := DM.CloudData.FieldByName('DS_SHOW').AsString = 'U';
        vStream := DM.CloudData.CreateBLOBStream(DM.CloudData.FieldByName('NOTICE_TEXT'), bmRead);
        NoticesEditor.LoadFromStream(vStream);
        DM.Query.Close;
        Exit;
      finally
        vStream.Free;
      end;
    end;
    DM.Query.Close;
  end;
end;

procedure TMain_F.NoShowCheckBoxPropertiesChange(Sender: TObject);
begin
  DM.ExecCloud('update MS_NOTICE '
              +'   set SHOWN_POS = ConCat(Ifnull(SHOWN_POS,''''),'','',:P3), '
              +'       SHOWN_COUNT = SHOWN_COUNT + 1 '
              +' where CD_HEAD  =:P0 '
              +'   and CD_STORE =:P1 '
              +'   and SEQ      =:P2;',
              [Common.Config.HeadStoreCode,
               StandardStore,
               NoticesEditor.Tag,
               Common.Config.StoreCode],false,Common.RestDBURL);

  DM.ExecCloud('insert into MS_NOTICE_READ(CD_HEAD, '
              +'                           CD_STORE, '
              +'                           SEQ, '
              +'                           SEQ1, '
              +'                           DS_READ, '
              +'                           CD_STORE_READ, '
              +'                           CD_SAWON, '
              +'                           NO_POS, '
              +'                           YN_STOP, '
              +'                           MAC_ADDRESS, '
              +'                           IP_ADDRESS, '
              +'                           DT_READ) '
              +'                    Values(:P0, '
              +'                           :P1, '
              +'                           :P2, '
              +'                           (select Ifnull(Max(SEQ1),0)+1 '
              +'                              from MS_NOTICE_READ as s '
              +'                             where CD_HEAD  =:P0 '
              +'                               and CD_STORE =:P1 '
              +'                               and SEQ      =:P2), '
              +'                           ''P'', '
              +'                           :P3, '
              +'                           :P4, '
              +'                           :P5, '
              +'                           :P6, '
              +'                           :P7, '
              +'                           :P8, '
              +'                           Now());',
              [Common.Config.HeadStoreCode,
               StandardStore,
               NoticesEditor.Tag,
               Common.Config.StoreCode,
               Common.Config.UserCode,
               Common.Config.PosNo,
               'Y',
               GetMacAddress,
               GetIPAddress],true,Common.RestDBURL);

  NoticesPanel.Visible := false;

end;

procedure TMain_F.NoticeCloseButtonClick(Sender: TObject);
begin
  DM.ExecCloud('update MS_NOTICE '
              +'   set SHOWN_COUNT = SHOWN_COUNT + 1 '
              +' where CD_HEAD  =:P0 '
              +'   and CD_STORE =:P1 '
              +'   and SEQ      =:P2;',
              [Common.Config.HeadStoreCode,
               StandardStore,
               NoticesEditor.Tag],false,Common.RestDBURL);

  DM.ExecCloud('insert into MS_NOTICE_READ(CD_HEAD, '
              +'                           CD_STORE, '
              +'                           SEQ, '
              +'                           SEQ1, '
              +'                           DS_READ, '
              +'                           CD_STORE_READ, '
              +'                           CD_SAWON, '
              +'                           NO_POS, '
              +'                           MAC_ADDRESS, '
              +'                           IP_ADDRESS, '
              +'                           DT_READ) '
              +'                    Values(:P0, '
              +'                           :P1, '
              +'                           :P2, '
              +'                           (select Ifnull(Max(SEQ1),0)+1 '
              +'                              from MS_NOTICE_READ as s '
              +'                             where CD_HEAD  =:P0 '
              +'                               and CD_STORE =:P1 '
              +'                               and SEQ      =:P2), '
              +'                           ''P'', '
              +'                           :P3, '
              +'                           :P4, '
              +'                           :P5, '
              +'                           :P6, '
              +'                           :P7, '
              +'                           Now());',
              [Common.Config.HeadStoreCode,
               StandardStore,
               NoticesEditor.Tag,
               Common.Config.StoreCode,
               Common.Config.UserCode,
               Common.Config.PosNo,
               GetMacAddress,
               GetIPAddress],true,Common.RestDBURL);

  NoticesPanel.Visible := false;
end;

procedure TMain_F.lbl_WorkDateClick(Sender: TObject);
  var vOrderData :TStringList;
      vTemp :String;
      vIndex, vIndex2 :Integer;
      vOrderNo,
      vOrderDate,
      vTelNo,
      vAddr,
      vAddr1,
      vAddr2,
      vTableMemo :String;
      vOrderAmt,
      vCheckCount :Integer;
      vBeginIndex,
      vEndIndex,
      vSeq :Integer;
      vDeliveryNo :String;
      vTableNo :Integer;
      BaeminOrderMenu :TList;
      vMatchAmt :Integer;
      vMenuPosBegin,
      vMenuPosEnd  :Integer;
      vMainIndex,
      vStep :Integer;
      vPos, vPos2 :Integer;
      vPayType :String;
      vResult :String;
begin
  Exit;
  vOrderData := TStringList.Create;
  vOrderData.LoadFromFile('배민전표.log');
  vTemp := vOrderData.Text;

  vOrderData.Clear;
  vTemp := Replace(vTemp, #$A#$D, #$D);
  vTemp := Replace(vTemp, #$A,    #$D);
  while vTemp <> '' do
  begin
    vIndex := Pos(#$D,vTemp);
    if vIndex > 0 then
    begin
       vOrderData.Add(Copy(vTemp,1,vIndex-1));
       Delete(vTemp,1,vIndex);
    end
    else
    begin
       vOrderData.Add(vTemp);;
       vTemp :='';
    end;
  end;

  for vIndex := 0 to vOrderData.Count-1 do
  begin
    vOrderData.Strings[vIndex] := Replace(vOrderData.Strings[vIndex], #$A, '');
    vOrderData.Strings[vIndex] := Replace(vOrderData.Strings[vIndex], #$1B, '');
    vOrderData.Strings[vIndex] := Replace(vOrderData.Strings[vIndex], 'E'#1, '');
    vOrderData.Strings[vIndex] := Replace(vOrderData.Strings[vIndex], 'E'#0, '');
    vOrderData.Strings[vIndex] := Replace(vOrderData.Strings[vIndex], '!'#0, '');
    vOrderData.Strings[vIndex] := Replace(vOrderData.Strings[vIndex], '!'#$18, '');
  end;

  BaeminOrderMenu := TList.Create;
  BaeminOrderMenu.Clear;
  //배민 주문 헤더를 만든다
  vAddr1 := '';
  vAddr2 := '';
  for vIndex := 0 to vOrderData.Count-1 do
  begin
    if Pos('주문번호:', vOrderData.Strings[vIndex]) > 0 then
    begin
      vOrderNo   := Copy(vOrderData.Strings[vIndex],10,12);
      if vOrderData.Strings[vIndex+1] <> '' then
        vOrderDate := GetOnlyNumber(Copy(vOrderData.Strings[vIndex+1],1,20))
      else
        vOrderDate := GetOnlyNumber(Copy(vOrderData.Strings[vIndex+2],1,20));
      vOrderDate := FormatMaskText('!0000-00-00 00:00;0; ',vOrderDate);
    end;

    if (Pos('배달주소:', vOrderData.Strings[vIndex]) > 0) then
    begin
      vAddr1 := vOrderData.Strings[vIndex+2] ;
      //주소가 두줄일때
      if Pos('연락처:',vOrderData.Strings[vIndex+4]) = 0 then
      begin
        vAddr2 := vOrderData.Strings[vIndex+3];
      end;
      //42칼럼
      if Common.Config.PrintColum = 0 then
      begin
        vAddr1 := SCopy(vAddr, 1, 42);
        vAddr2 := SCopy(vAddr, 43, 42);
      end
      else
      begin
        vAddr1 := SCopy(vAddr, 1, 48);
        vAddr2 := SCopy(vAddr, 49, 48);
      end;
    end;

    if (Pos('연락처:', vOrderData.Strings[vIndex]) > 0) then
       vTelNo := GetOnlyNumber(vOrderData.Strings[vIndex+1]);

    if (Pos('요청사항:', vOrderData.Strings[vIndex]) > 0) then
    begin
       vTableMemo := Trim(vOrderData.Strings[vIndex+1])+#13;
       if (Pos('------------------', vOrderData.Strings[vIndex+2]) = 0) then
       begin
         vTableMemo := vTableMemo + Trim(vOrderData.Strings[vIndex+2])+#13;
           if (Pos('------------------', vOrderData.Strings[vIndex+3]) = 0) then
             vTableMemo := vTableMemo + Trim(vOrderData.Strings[vIndex+3])+#13;
       end;
    end;

    //메뉴를 찾는다
    if (Pos('메뉴명', vOrderData.Strings[vIndex]) > 0) and (Pos('수량', vOrderData.Strings[vIndex]) > 0) and (Pos('금액', vOrderData.Strings[vIndex]) > 0) then
      vMenuPosBegin := vIndex + 2;

    if (Pos('합계', vOrderData.Strings[vIndex]) > 0) then
    begin
      vOrderAmt   := StrToInt(GetOnlyNumber(RightStr(vOrderData.Strings[vIndex],7)));
      vMenuPosEnd := vIndex -2;
    end;

    if (Pos('(후불카드)', vOrderData.Strings[vIndex]) > 0) then
      vPayType := '카드';
    if (Pos('(후불현금)', vOrderData.Strings[vIndex]) > 0) then
      vPayType := '현금';
    if (Pos('(결제완료)', vOrderData.Strings[vIndex]) > 0) then
      vPayType := '결제완료';
  end;

end;

procedure TMain_F.ChargeInfoButtonClick(Sender: TObject);
begin
  Common.MsgBox(Format('문자충전 방법'#13'(국민은행) 761237-00-002974'#13'예금자에 %s 또는 %s 로 입금하시면 자동충전됩니다',
                      [Common.Config.StoreCode, Common.Config.StoreBizNo]));
end;

procedure KFTC_ICDetect(aOutputData:PAnsiChar);stdcall;
var vTemp, vSam :AnsiString;
    vPos  :Integer;
begin
  vTemp := aOutputData;
  Common.WriteLog('work', Format('KFTC_ICDetect [ %s ]', [vTemp]));
  //07 은 FallBack
  if CopyPos(vTemp,#28,0) = '07' then
  begin
    Common.MsgBox('카드정보를 읽지 못했습니다');
    Exit;
  end;

  if CopyPos(vTemp,#28,0) <> '00' then Exit;

  vSam  := CopyPos(vTemp,#28,3);

  vTemp := CopyPos(vTemp,#28,1);

  if not ((vTemp = '0') or (vTemp = '2') or (vTemp = '3') or (vTemp = '4') or (Pos('ENC', vSam) > 0)) then Exit;
  //삼성페이
  if Pos('ENC', vSam) > 0 then
  begin
    vPos := Pos('ENC', vSam);
    if  Copy(vTemp, vPos+3, 1) = ';' then Exit;
  end;

  //신용카드 폼이 떠있으면 빠져나간다
  if Assigned(Card_F) and Card_F.Showing and Card_F.Active then
  begin
    Common.DetectData        := vTemp;
    Card_F.isCardFormDetect  := true;
    Card_F.Tmr_IC.Enabled    := True;
    Exit;
  end;

  {주문폼에서 IC or MS을 읽었을때}
  if Assigned(Order_F) and Order_F.Showing and Order_F.Active then
  begin
    Common.DetectData := vTemp;
    Order_F.Tmr_IC.Enabled := True;
  end;
end;

procedure TMain_F.Button1Click(Sender: TObject);
var vRestClient   :TRestClient;
    vRestRequest  :TRestRequest;
    vRESTResponse :TRESTResponse;
    vJSONObject   :TJSONObject;
    vData :String;
    vHandle, vHandle2 :THandle;
var vReadData :AnsiString;
    vTableNo, vNotMathAmt, vIndex  :Integer;
    vDeliveryNo,
    vAddress,
    vTableMemo :String;
    vOrderMenu :TList;
    vOrderAmt,
    vCardAmt  :Integer;            //AIzaSyCx810LMp0EZ2KGGMwzjy5tjAJK691QYQc
begin
//  vOrderMenu := TList.Create;
//  Common.Device.SetDeliveryOrder('Y', vDeliveryNo, vOrderAmt, vCardAmt, cxMemo1.Text, vOrderMenu);
//  try
//    BlockInput(false);
//    vRestClient                := TRestClient.Create(nil);
//    vRestRequest               := TRestRequest.Create(nil);
//    vRESTResponse              := TRESTResponse.Create(vRestRequest);
//    vRestRequest.Client        := vRestClient;
//    vRestRequest.Response      := vRESTResponse;
//    vRestClient.BaseURL        := 'http://211.176.179.166:8001/api/pos/sendMessage';
//    vRestClient.ContentType    := 'application/x-www-form-urlencoded; charset=UTF-8;';
//    vRestRequest.Accept        := 'application/json';
//    vRestRequest.AcceptCharset := 'UTF-8';
//    vRestRequest.Method        := TRESTRequestMethod.rmPOST;
//    vJSONObject    := TJSONObject.Create;
//    vJSONObject.AddPair('storecode',    TJSONString.Create('store'));
//    vJSONObject.AddPair('tableno',    TJSONString.Create('1'));
//    vJSONObject.AddPair('chat',    TJSONString.Create('hi'));
//    vRESTRequest.AddBody(vJSONObject.ToJSON, TRESTContentType.ctAPPLICATION_JSON);
//    try
//      vRESTRequest.Execute;
//    except
//      Exit;
//    end;
//
//    if vRestRequest.Response.StatusCode <> 200 then
//    begin
//      Exit;
//    end;
//    vData := vRESTResponse.Content;
//    vJSONObject := TJSONObject.ParseJSONValue( vData ) as TJSONObject;
//    vData := vJSONObject.GetValue('result').ToJson;
//
//  finally
//    vRestClient.Disconnect;
//    FreeAndNil(vRESTResponse);
//    FreeAndNil(vRESTRequest);
//    FreeAndNil(vRESTClient);
//  end;
end;

procedure TMain_F.Button2Click(Sender: TObject);
var vRestClient   :TRestClient;
    vRestRequest  :TRestRequest;
    vRESTResponse :TRESTResponse;
    vObject  :TJSONObject;
    vConfigObject  :TJSONObject;
    vInputObject   :TJSONObject;
    vVoiceObject   :TJSONObject;
    vConfigArray   :TJSONArray;
    vConfigDetailObject  :TJSONObject;
    vJSonData :String;
    vData :String;
begin

    try
      vRestClient                := TRestClient.Create(nil);
      vRestRequest               := TRestRequest.Create(nil);
      vRESTResponse              := TRESTResponse.Create(vRestRequest);
      vRestRequest.Client        := vRestClient;
      vRestRequest.Response      := vRESTResponse;
      vRestClient.BaseURL        := 'https://texttospeech.googleapis.com/v1/text:synthesize';
      vRestClient.ContentType    := 'application/x-www-form-urlencoded; charset=UTF-8;';
      vRestRequest.Accept        := 'application/json';
      vRestRequest.AcceptCharset := 'UTF-8';
      vRestRequest.Method        := TRESTRequestMethod.rmPOST;
      vRestRequest.Params.AddHeader('X-Goog-User-Project','extremetts');
      vRestRequest.Params.AddHeader('Authorization','Bearer $(gcloud auth print-access-token)');

      vJSonData := '{ '
                  +'  "audioConfig": { '
                  +'     "audioEncoding": "LINEAR16" '
                  +'    }, '
                  +'  "input": { '
                  +'      "text": "%s" '
                  +'    },'
                  +'  "voice": { '
                  +'      "languageCode": "ko-KR", '
                  +'      "name": "ko-KR-Wavenet-C" '
                  +'    } '
                  +'} ';

      vJSonData := Format(vJSonData, ['콩나물국밥 1개, 참이슬 2개']);

      vObject := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(vJSonData),0) as TJSONObject;
      vRESTRequest.AddBody(vObject.ToJSON, TRESTContentType.ctAPPLICATION_JSON);
      ShowMessage(vObject.ToString);

      try
        vRESTRequest.Execute;
      except
        Exit;
      end;

      if vRestRequest.Response.StatusCode <> 200 then
      begin
        Exit;
      end;
      vData := vRESTResponse.Content;

    finally
      vRestClient.Disconnect;
      FreeAndNil(vRESTResponse);
      FreeAndNil(vRESTRequest);
      FreeAndNil(vRESTClient);
    end;
end;

procedure TMain_F.CashBookButtonClick(Sender: TObject);
begin
  if MilliSecondsBetween(Now(),ClickTime) < 1000 then Exit;
  ClickTime   := Now;
  if not Common.Config.IsKiosk then
  begin
    try
      Screen.Cursor := crHourGlass;
      if not Common.CheckAcctPos then Exit;
      if not Common.PosNo_Check  then Exit;

      CashBook_F := TCashBook_F.Create(Self);
      try
        CashBook_F.ShowModal;
      finally
        FreeAndNil(CashBook_F);
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  end
  else
  begin
    Common.KioskTouchBeep('kioskwave12');
    KioskKeyPad_F := TKioskKeyPad_F.Create(Self);
    KioskKeyPad_F.MessageLabel.Caption := '관리자 패스워드를 입력하세요';
    KioskKeyPad_F.isPassword           := true;
    try
      if KioskKeyPad_F.ShowModal <> mrOK then Exit;
      if Common.Config.KioskPwd <> KioskKeyPad_F.KeyInLabel.Hint then
      begin
        Common.ErrBox('패스워드가 올바르지 않습니다');
        Exit;
      end;
    finally
      FreeAndNil(KioskKeyPad_F);
    end;
    if not Common.KioskAutoOpen then Exit;

    RcpChange_F := TRcpChange_F.Create(Self);
    try
      Order_F := TOrder_F.Create(Self);

      RcpChange_F.ShowMode := fsmNone;
      RcpChange_F.ShowModal;
    finally
      FreeAndNil(RcpChange_F);
      if Assigned(Order_F) then
        FreeAndNil(Order_F);
    end;
  end;
end;

procedure TMain_F.CashierLabelClick(Sender: TObject);
begin
  GetHeadOption(9)
end;

function TMain_F.CheckUpdate: Boolean;
var vUpdate   :Boolean;
begin
  Result := False;

  //데몬이 실행한거면 다운을 안받는다
  if Paramstr(1) = 'DEMON' then Exit;

  vUpdate := Common.GetIniFile('POS','UPDATE', false) or (Common.GetIniFile('POS', 'UPDATE_PWD', '') = '15444171');

  if not vUpdate then Exit;
  Download_F := TDownload_F.Create(nil);
  try
    if Download_F.ShowModal= mrOK then
      Result := True;
  finally
    FreeAndNil(Download_F);
  end;
end;

function TMain_F.CheckUser: Boolean;
begin
  Result := false;

  // 외부에서 로그인 정보를 가져왔을 때는 로그인을 하지 않고 넘어간다
  if (ParamCount > 1) and (ParamStr(1) <> 'Updater') then
    Result := true
  // Login을 한다
  else
    with TLogin_F.Create(Self) do
      try
        if ShowModal = mrOK then
          Result := true;
        Application.ProcessMessages;
      finally
        Free;
      end;
end;

procedure TMain_F.ConfigButtonClick(Sender: TObject);
begin
  if MilliSecondsBetween(Now(),ClickTime) < 1000 then Exit;
  ClickTime   := Now;

  Common.WriteLog('work', '환경설정');
  Common.KioskTouchBeep('kioskwave12');
  //관리자만 변경가능할때
  if GetUserOption(6) = '0' then
  begin
    if GetOption(172) = '0' then
    begin
      Common.ErrBox('환경설정을 사용 할 권한이 없습니다');
      Exit;
    end
    else if not Common.CheckAuthority(6) then Exit;
  end;

  try
    Screen.Cursor := crHourGlass;
    Config_F := TConfig_F.Create(Self);
    Common.FreeDualScreen;
    try
      Config_F.ShowModal;
    finally
      FreeAndNil(Config_F);
      FormActivate(nil);
      Common.ShowNormalDualScreen;
    end;
  finally
    Common.Device.OnDispenserReadData := DispenserReadEvent;
    Screen.Cursor := crDefault;
  end;
end;

procedure TMain_F.CreateFlatRoundRgn;
const
  CORNER_SIZE = 20;
var
  Rgn: HRGN;
begin
  with BoundsRect do
  begin
    Rgn := CreateRoundRectRgn(0, 0, Right - Left + 1, Bottom - Top + 1, CORNER_SIZE, CORNER_SIZE);
    // exclude left-bottom corner
    ExcludeRectRgn(Rgn, 0, Bottom - Top - CORNER_SIZE div 2, CORNER_SIZE div 2, Bottom - Top + 1);
    // exclude right-bottom corner
    ExcludeRectRgn(Rgn, Right - Left - CORNER_SIZE div 2, Bottom - Top - CORNER_SIZE div 2, Right - Left , Bottom - Top);
  end;
  // the operating system owns the region, delete the Rgn only SetWindowRgn fails
  if SetWindowRgn(Handle, Rgn, True) = 0 then
    DeleteObject(Rgn);
end;

procedure TMain_F.CreateParams(var Params: TCreateParams);
const
  CS_DROPSHADOW = $00020000;
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP;
    WindowClass.Style := WindowClass.Style or CS_DROPSHADOW;
  end;
end;

procedure TMain_F.CustomerNoLabelClick(Sender: TObject);
begin
  try
    Screen.Cursor := crHourGlass;
    WebOrder_F := TWebOrder_F.Create(Self);
    try
      WebOrder_F.ShowModal;
    finally
      FreeAndNil(WebOrder_F);
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TMain_F.CloseButtonClick(Sender: TObject);
var vHnd :THandle;
begin
  Common.KioskTouchBeep('kioskwave12');
  //프로그램을 종료할때 다운로드폴더에 실행화일이 있으면 데몬을 종료한다
  if FileExists(ExtractFilePath(Application.ExeName)+'\OrangePOS_Down.exe') then
  begin
    vHnd := FindWindow(nil, 'POSDemon');
    if vHnd > 0 then
      with TIdTCPClient.Create(Application) do
      begin
        try
          try
            Host := '127.0.0.1';
            Port := 7066;
            ConnectTimeout := 500;
            Connect;
            Socket.WriteLnRFC('UPDATE' +#3, IndyTextEncoding_OSDefault);
          except
          end;
        finally
          try
            Disconnect(true);
            if Connected then
              Disconnect(true);
          except
          end;
          Free;
        end;
      end;

    SendMessage(vHnd,WM_USER+$3,0,0);
  end;
  Close;
end;

procedure TMain_F.obtn_KioskReadyClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  KioskKeyPad_F := TKioskKeyPad_F.Create(Self);
  KioskKeyPad_F.MessageLabel.Caption := '관리자 패스워드를 입력하세요';
  KioskKeyPad_F.isPassword           := true;
  try
    if KioskKeyPad_F.ShowModal <> mrOK then Exit;
    if Common.Config.KioskPwd <> KioskKeyPad_F.KeyInLabel.Hint then
    begin
      Common.ErrBox('패스워드가 올바르지 않습니다');
      Exit;
    end;
  finally
    FreeAndNil(KioskKeyPad_F);
  end;

  try
    Screen.Cursor := crHourGlass;
    KioskReady_F := TKioskReady_F.Create(Self);
    try
      KioskReady_F.ShowModal;
    finally
      FreeAndNil(KioskReady_F);
      Common.Device.OnDispenserReadData :=DispenserReadEvent;
      SetKioskCash;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TMain_F.DualFilesDownLoad;
var vIdHTTP     : TIdHTTP;
    vFileStream: TMemoryStream;
    vRequest : TStringStream;
    vResponse,
    vTemp,
    vHttpURL :String;
begin
  if Common.Config.DualSize = 0 then Exit;
  vTemp := Common.GetIniFile('POS','DUAL_DN','');
  if vTemp <> '' then
    vTemp := Format('and DT_CHANGE > Cast(''%s'' as DateTime) ',[vTemp]);

  try
    if not DirectoryExists(Common.AppPath+'Dual') then
      ForceDirectories(Common.AppPath+'Dual');

    vHttpURL := GetHttpURL;
    if vHttpURL = '' then Exit;

    OpenQuery('select NM_CODE1, '
             +'       NM_CODE2 '
             +'  from MS_CODE '
             +' where CD_STORE =:P0 '
             +'   and CD_KIND  =''96'' '
             +vTemp,
             [Common.Config.StoreCode]);
    Common.HideWaitForm;
    Common.ShowWaitForm('듀얼이미지를 다운로드 중입니다...');
    while not Common.Query.Eof do
    begin
      try
        vFileStream := TMemoryStream.Create;
        vIdHTTP     := TIdHTTP.Create(Self);
        vRequest    := TStringStream.Create;
        vIdHTTP.ConnectTimeout := 3000;
        vIdHTTP.ReadTimeout    := 5000;

        if not FileExists(Common.AppPath+'Dual\'+Common.Query.Fields[0].AsString) and (Trim(Common.Query.Fields[0].AsString) <>'') then
        begin
          if Common.Query.Fields[1].AsString = 'HEAD' then
            vIdHTTP.Request.CustomHeaders.AddValue('COMP_ID', Common.Config.HeadStoreCode)
          else
            vIdHTTP.Request.CustomHeaders.AddValue('COMP_ID', Format('%s/%s',[Common.Config.HeadStoreCode,Common.Config.StoreCode]));

          vIdHTTP.Request.CustomHeaders.AddValue('FILE_NAME', Common.Query.Fields[0].AsString);
          vIdHTTP.Request.CustomHeaders.AddValue('JOB_GBN','D');

          vIdHTTP.Post(vHttpURL+'Action_FileDown', vRequest, vFileStream );
          vResponse := IntToStr(vIdHTTP.ResponseCode);
          if vResponse = '200' then
            vFileStream.SaveToFile(Common.AppPath+'Dual\'+Common.Query.Fields[0].AsString);
        end;
      finally
        vIdHTTP.Disconnect;
        vFileStream.Free;
        vIdHTTP.Free;
      end;
      Common.Query.Next;
    end;
  finally
    Common.Query.Close;
    Common.HideWaitForm;
    Common.SetIniFile('POS','DUAL_DN', FormatDateTime('yyyy-mm-dd hh:nn:ss', Now()));
  end;
end;

procedure TMain_F.KioskFilesDownLoad;
var vIdHTTP     : TIdHTTP;
    vFileStream: TMemoryStream;
    vRequest : TStringStream;
    vResponse :String;
    vTemp     :String;
    vHttpURL  :String;
begin
  if not Common.Config.IsKiosk then Exit;

  vTemp := Common.GetIniFile('POS','KIOSK_DN','');
  if vTemp <> '' then
    vTemp := Format('and DT_CHANGE > Cast(''%s'' as DateTime) ',[vTemp]);

  try
    if not DirectoryExists(Common.AppPath+'Kiosk') then
      ForceDirectories(Common.AppPath+'Kiosk');

    vHttpURL := GetHttpURL;
    if vHttpURL = '' then Exit;

    OpenQuery('select NM_CODE1, '
             +'       NM_CODE2 '
             +'  from MS_CODE '
             +' where CD_STORE =:P0 '
             +'   and CD_KIND  =''97'' '
             +vTemp,
             [Common.Config.StoreCode]);
    Common.HideWaitForm;
    Common.ShowWaitForm('키오스크 이미지를 다운로드 중입니다...');
    while not Common.Query.Eof do
    begin
      try
        vFileStream := TMemoryStream.Create;
        vIdHTTP     := TIdHTTP.Create(Self);
        vRequest    := TStringStream.Create;
        vIdHTTP.ConnectTimeout := 3000;
        vIdHTTP.ReadTimeout    := 5000;

        if Trim(Common.Query.Fields[0].AsString) <> '' then
        begin
          if Common.Query.Fields[1].AsString = 'HEAD' then
            vIdHTTP.Request.CustomHeaders.AddValue('COMP_ID', Common.Config.HeadStoreCode)
          else
            vIdHTTP.Request.CustomHeaders.AddValue('COMP_ID', Format('%s/%s',[Common.Config.HeadStoreCode,Common.Config.StoreCode]));

          vIdHTTP.Request.CustomHeaders.AddValue('FILE_NAME', Common.Query.Fields[0].AsString);
          vIdHTTP.Request.CustomHeaders.AddValue('JOB_GBN','D');

          vIdHTTP.Post(vHttpURL+'Action_FileDown', vRequest, vFileStream );
          vResponse := IntToStr(vIdHTTP.ResponseCode);
          if vResponse = '200' then
          begin
            if FileExists(Common.AppPath+'Kiosk\'+Common.Query.Fields[0].AsString) then
              DeleteFile(Common.AppPath+'Kiosk\'+Common.Query.Fields[0].AsString);

            vFileStream.SaveToFile(Common.AppPath+'Kiosk\'+Common.Query.Fields[0].AsString);
          end;
        end;
      finally
        vIdHTTP.Disconnect;
        vFileStream.Free;
        vIdHTTP.Free;
        Sleep(500);
      end;
      Common.Query.Next;
    end;
  finally
    Common.Query.Close;
    Common.HideWaitForm;
    Common.SetIniFile('POS','KIOSK_DN', FormatDateTime('yyyy-mm-dd hh:nn:ss', Now()));
  end;
end;

procedure TMain_F.SaleReportButtonClick(Sender: TObject);
var vTemp :String;
begin
  if MilliSecondsBetween(Now(),ClickTime) < 1000 then Exit;
  ClickTime   := Now;
  try
    if Common.PosType = ptOnlyOrder then
    if not Common.CheckAcctPos(1) then Exit;

    if not Common.Config.IsKiosk and (Common.Config.ReportPwd <> '') then
    begin
      vTemp := Common.ShowNumberForm('패스워드를 입력하세요', 16);
      if vTemp = 'mrClose' then Exit;

      if Common.Config.ReportPwd <> vTemp then
      begin
        Common.ErrBox('패스워드가 올바르지 않습니다');
        Exit;
      end;
    end
    else if Common.Config.IsKiosk then
    begin
      Common.KioskTouchBeep('kioskwave12');
      KioskKeyPad_F := TKioskKeyPad_F.Create(Self);
      KioskKeyPad_F.MessageLabel.Caption := '관리자 패스워드를 입력하세요';
      KioskKeyPad_F.isPassword           := true;
      try
        if KioskKeyPad_F.ShowModal <> mrOK then Exit;
        if Common.Config.KioskPwd <> KioskKeyPad_F.KeyInLabel.Hint then
        begin
          Common.ErrBox('패스워드가 올바르지 않습니다');
          Exit;
        end;
      finally
        FreeAndNil(KioskKeyPad_F);
      end;
    end;

    Screen.Cursor := crHourGlass;

    if not Common.PosNo_Check then Exit;

    SaleReport_F := TSaleReport_F.Create(Self);
    try
      SaleReport_F.ShowModal;
    finally
      FreeAndNil(SaleReport_F);
      FormActivate(nil);
    end;
  finally
    Screen.Cursor    := crDefault;
  end;
end;

procedure TMain_F.ServiceButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  try
    ShellExecute(handle, 'open', pchar(Common.Config.HelpURL), '','', SW_Normal);
  except
  end;
end;

function TMain_F.SetKioskCash: Boolean;
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
begin
  if not Common.Config.IsKiosk or not Common.Config.IsKioskCash then Exit;

  DispenserData := EmptyStr;
  //방출수량 조회
  vTemp := AnsiString(#$11#$04#$00#$00#$00#$00#$00#$00#$00#$00#$00);
  vTemp := AnsiChar(#$fe) +AnsiChar(Length(vTemp)+2)+vTemp;
  vFCC := Byte(vTemp[1]);
  for vIndex := 2 to Length(vTemp) do
    vFCC := vFCC xor Byte(vTemp[vIndex]);
  vTemp := vTemp + AnsiChar(vFCC);
  Common.Device.SendToDispenser(vTemp);
  vGetTime := GetTickCount;
  while (DispenserData = EmptyStr) and (vGetTime + 1000 > GetTickCount) do
    Application.ProcessMessages;

  if DispenserData = EmptyStr then
  begin
    Result := false;
    DispenderReset;
  end
  else
    Result := true;
end;

procedure TMain_F.SetVolume(NewVolume: DWORD);
begin
  NewVolume:=MAKEWPARAM(NewVolume, NewVolume);
  waveOutSetVolume(0, NewVolume);
end;

procedure TMain_F.DispenserReadEvent(const S: String);
  //수신값이 한번에 여러건이 들어오는 경우가 있어서 최종것만 사용한다
  function GetReceiveData(aStr:String):String;
  var vIndex :Integer;
      vPos   :Integer;
  begin
    vPos := 1;
    for vIndex := 1 to Length(aStr) do
    begin
      if (StringToHex(aStr[vIndex])='18') and (vIndex >=3) and (StringToHex(aStr[vIndex-2])='fe') then
        vPos := vIndex-2;
    end;
    Result := Copy(aStr, vPos, Length(aStr)-vPos);
  end;
var vIndex :Integer;
    vBillCount,
    vCoinCount :Integer;
    vData :AnsiString;
begin
  vData := GetReceiveData(AnsiString(S));
  try
    if (Length(vData) > 3) and (StringToHex(vData[2])='18') then
    begin
      if StringToHex(S[3]) <> '00' then
        Exit
      else
      begin
        vBillCount := StrToInt('$'+StringToHex(vData[9])+StringToHex(vData[10]));
        vCoinCount := StrToInt('$'+StringToHex(vData[5])+StringToHex(vData[6]));

        if ((Common.Config.KioskAlram[0] - vBillCount) <= Common.Config.KioskAlram[4]) or ((Common.Config.KioskAlram[1] - vCoinCount) <= Common.Config.KioskAlram[5]) then
          Common.Config.KioskCashPause := true
        else
          Common.Config.KioskCashPause := false;

        if ((Common.Config.KioskAlram[2] > 0) and (Common.Config.KioskAlram[0]-Common.Config.KioskAlram[2] <= vBillCount))
        or ((Common.Config.KioskAlram[3] > 0) and (Common.Config.KioskAlram[1]-Common.Config.KioskAlram[3] <= vCoinCount)) then
        begin
          Common.KakaoSendMessage('K',['거스름돈이 잔돈부족합니다'+#13+
                                  Format('천원 %d장, 백원 %d개',[vBillCount, vCoinCount])],'');
        end;

      end;
    end;
  except
    on E: Exception do
      Common.WriteLog('DispenserReadEvent',E.Message +#13+vData);
  end;
  DispenserData := S;
end;

procedure TMain_F.DepositButtonClick(Sender: TObject);
begin
  if MilliSecondsBetween(Now(),ClickTime) < 1000 then Exit;
  ClickTime   := Now;
  try
    Screen.Cursor := crHourGlass;
    if not Common.CheckAcctPos then Exit;
    Deposit_F := TDeposit_F.Create(Self);
    try
      Deposit_F.ShowModal;
      Application.ProcessMessages;
    finally
      FreeAndNil(Deposit_F);
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TMain_F.DispenderReset;
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
begin
  DispenserData := EmptyStr;
  //방출기 리셋
  vTemp := AnsiString(#$10#$00#$03#$00#$00#$00#$00#$00#$00#$00#$00);
  vTemp := AnsiChar(#$fe) +AnsiChar(Length(vTemp)+2)+vTemp;
  vFCC := Byte(vTemp[1]);
  for vIndex := 2 to Length(vTemp) do
    vFCC := vFCC xor Byte(vTemp[vIndex]);
  vTemp := vTemp + AnsiChar(vFCC);
  Common.Device.SendToDispenser(vTemp);
  vGetTime := GetTickCount;
  while (DispenserData = EmptyStr) and (vGetTime + 1000 > GetTickCount) do
    Application.ProcessMessages;
end;

end.



















