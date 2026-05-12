unit Download_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdFTP, IniFiles, GraphicEx, IdFTPCommon,
  ShellAPI, StrUtils, Menus, cxLookAndFeelPainters, cxButtons,
  cxLookAndFeels, cxControls, cxPC, cxTextEdit, cxMemo,
  cxContainer, cxEdit, cxProgressBar, IdWhois, DB, IdExplicitTLSClientServerBase,
  IdAntiFreezeBase, IdAntiFreeze, IdHTTP,   WinSock, idGlobal,
  cxLabel, Registry, jpeg, cxGraphics, cxClasses, AdvGlassButton,
  AdvSmoothToggleButton, Vcl.WinXCtrls, PosButton, dxGDIPlusClasses, TLHelp32,
  AdvSmoothButton, cxImage;

type
  TFileInfo = record
  Name : String;
  Date : String;
  Size : integer;
  Kind : String;
  Path : String;
end;

type
  TFilePath = (FilePos,Dll,Data,Sys,None);

type
  TFtpStatus = (ftWork,ftAbort,ftConn);

type
  TdsProgram = (dpOrange, dpSportCenter);

type
  TDownload_F = class(TForm)
    CloseTimer: TTimer;
    cxLookAndFeelController1: TcxLookAndFeelController;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    IdAntiFreeze1: TIdAntiFreeze;
    IdHTTP: TIdHTTP;
    Message1Label: TcxLabel;
    panPassWord: TPanel;
    edtPassword: TcxTextEdit;
    StartTimer: TTimer;
    Num_7: TAdvSmoothToggleButton;
    Num_8: TAdvSmoothToggleButton;
    Num_9: TAdvSmoothToggleButton;
    Num_4: TAdvSmoothToggleButton;
    Num_5: TAdvSmoothToggleButton;
    Num_6: TAdvSmoothToggleButton;
    Num_1: TAdvSmoothToggleButton;
    Num_2: TAdvSmoothToggleButton;
    Num_3: TAdvSmoothToggleButton;
    Num_0: TAdvSmoothToggleButton;
    Num_Enter: TAdvSmoothToggleButton;
    Num_BS: TAdvSmoothToggleButton;
    Message2Label: TcxLabel;
    WorkPanel: TPanel;
    MessageLabel: TLabel;
    ActivityIndicator: TActivityIndicator;
    cxLabel3: TcxLabel;
    CallCancelButton: TcxButton;
    Shape5: TShape;
    UpdateButton: TAdvSmoothButton;
    CancelButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseTimerTimer(Sender: TObject);
    procedure IdHTTPWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Integer);
    procedure IdHTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Integer);
    procedure IdHTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure cxButton11Click(Sender: TObject);
    procedure edtPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure StartTimerTimer(Sender: TObject);
    procedure Num_7Click(Sender: TObject);
    procedure Num_BSClick(Sender: TObject);
    procedure Num_EnterClick(Sender: TObject);
    procedure UpdateButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure CallCancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    dsProgram : TdsProgram;
    AppPath    : String;
    DownPath   : String;
    SystemPath : String;
    Files      : TFileInfo;
    FtpStatus  : TFtpStatus;
    FileList   : TStringList;
    UP_ini     : Tinifile;
    DN_ini     : Tinifile;
    bDownLoad  : Boolean;
    DelFile    : String;
    CopyFileName : Array of String;
    ExecDown   : Boolean;
    FileCount  : Integer;
    fsServerPath :String;
    fsProgram    :String;
    fsURL        :String;
    function  GetFilePath(FileName:String):TFilePath;
    procedure ExecDownload;
    function  FileDownload:Boolean;
    function  GetDosOutput(aCommandLine: string): string;
    procedure KillTask(ExeFileName: string);
  public
  end;

var
  Download_F: TDownload_F;
implementation                                                       
const
  fsUpInfoFile    = 'UP_FileInfo.ini';
  fsDnInfoFile    = 'DN_FileInfo.ini';
  fsDownLoading   = 'DownLoading';
  filDemon        = 'Demon.exe';
  filTR           = 'OrangeTR.exe';
  filAgent        = 'SmartAgent.exe';
  iniDownloadInfo = 'DOWNLOADINFO';
  iniUploadDate   = 'UPLOADDATE';

{$R *.dfm}
procedure TDownload_F.FormCreate(Sender: TObject);
var vTemp :String;
begin
  WorkPanel.Top  := 0;
  WorkPanel.Left := 0;
  WorkPanel.Height  := 275;
  WorkPanel.Width   := 430;
  panPassWord.Top   := 0;

  Self.ClientWidth   := panPassWord.Width;
  Self.ClientHeight  := panPassWord.Height;


  AppPath  := ExtractFilePath(Application.ExeName);
  SetLength(SystemPath, 256);
  GetSystemDirectory(PChar(SystemPath), 256);

  with TIniFile.Create(AppPath+'CONFIG.INI') do
    try
      if Application.Title = 'OrangePOS' then dsProgram := dpOrange
      else if Application.Title = 'CenterPOS' then dsProgram := dpSportCenter;
    finally
      Free;
    end;

  if (RightStr(UpperCase(Application.ExeName),13) <> 'ORANGEPOS.EXE' ) and
     (RightStr(UpperCase(Application.ExeName),13) <> 'CENTERPOS.EXE' ) then
  begin
    CloseTimer.Tag := 0;
    CloseTimer.Enabled := True;
    Exit;
  end;

  fsURL := 'http://www.xn--6j1b831b.kr:84/';
  case dsProgram of
    dpOrange :
    begin
      fsServerPath  := 'FTP\Update\CloudOrange\FrontOffice\';
      fsProgram     := 'OrangePOS.exe';
    end;
    dpSportCenter:
    begin
      fsServerPath  := 'FTP\Update\SportsCenter\FrontOffice\';
      fsProgram     := 'CenterPOS.exe';
    end;
  end;
  DownPath := AppPath+'Download\';
  ExecDown    := False;
  FileCount   := 0;
  StartTimer.Enabled := true;
end;

procedure TDownload_F.FormShow(Sender: TObject);
begin
end;

//**************************************************************************//
//                           다운받을 PATH를 구한다
//**************************************************************************//
function TDownload_F.GetFilePath(FileName:String):TFilePath;
  var
  vPath : String;
  ini  : Tinifile;
begin
  ini := Tinifile.Create(DownPath+fsUpInfoFile);
  vPath := LowerCase(ini.ReadString('UPLOADINFO',FileName,'0'));

  if      vPath = 'app'     then  Result := FilePos
  else if vPath = 'dll'     then  Result := Dll
  else if vPath = 'dat'     then  Result := Data
  else if vPath = 'sys'     then  Result := Sys
  else Result := None;

end;


//**************************************************************************//
//                           취소버튼 클릭시
//**************************************************************************//
procedure TDownload_F.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.ProcessMessages;
end;

//**************************************************************************//
//                           업데이트버튼 클릭시
//**************************************************************************//
procedure TDownload_F.ExecDownload;
  //aWork H:Head, G:Get;
  function FileDown(aWork, aFileName:String):String;
  var vErrCnt :Integer;
  label Loop;
  begin
    vErrCnt := 0;
    Result  := '';
    Loop:
    try
      if aWork = 'H' then
        IdHTTP.Head(aFileName)
      else
        Result := IdHTTP.Get(aFileName);
      vErrCnt := 0;
    except
      Inc(vErrCnt);
    end;
    if (vErrCnt > 0) and (vErrCnt < 6) then
      Goto Loop;

    if vErrCnt > 0 then
      Result := '-1';
  end;
var I, vIndex :Integer;
    DownLoadTime,vTemp : String;
    MemStream: TMemoryStream;
    vStringList  :TStringList;
    vCopyPath,
    vFileName    :String;
begin
  try
    IdHTTP.ReadTimeout    := 500;
    IdHTTP.ConnectTimeout := 500;
    FileList     := TStringlist.Create;
    try
      //다운받을 디렉토리가 없으면 생성
      if Not DirectoryExists(DownPath) then ForceDirectories(DownPath);

      vStringList := TStringList.Create;

      with TStringList.Create do
        try
          Text := FileDown('G',fsURL+fsServerPath+fsUpInfoFile);
          if Text <> '-1' then
          begin
            SaveToFile(DownPath+fsUpInfoFile);
            UP_ini := Tinifile.Create(DownPath+fsUpInfoFile);
            DN_ini := Tinifile.Create(DownPath+fsDNInfoFile);
            FileList.LoadFromFile(DownPath+fsUpInfoFile);
          end;
        finally
          Free;
        end; // try .. finally ..

        //업데이트할 화일이 있는지 체크한다
        if not ExecDown then
        begin
          //공통화일을 다운받는다
          UP_ini.ReadSectionValues(iniUploadDate, vStringList);
          For vIndex := 0 to vStringList.Count-1 do
          begin
            vFileName := LeftStr(vStringList.Strings[vIndex], Pos('=',vStringList.Strings[vIndex])-1);
            DownLoadTime := UP_ini.ReadString(iniUploadDate, vFileName ,'0');
            //정상적으로 다운로드가 완료되지 않을 화일이 있을때
            if DN_ini.ReadString(iniDownloadInfo, vFileName, '0') = fsDownLoading then
              DN_ini.WriteString(iniDownloadInfo, vFileName, '0');

            if (StrToFloat(DownLoadTime) <= StrToFloat(DN_ini.ReadString(iniDownloadInfo, vFileName,'0'))) then Continue;

            //화일이 실제 있는지 체크한다
            try
              if FileDown('H',fsURL+fsServerPath+vFileName) = '-1' then
              begin
                DN_ini.WriteString(iniDownloadInfo,vFileName, DownLoadTime);
                Continue;
              end;
            except
              DN_ini.WriteString(iniDownloadInfo,vFileName, DownLoadTime);
              Continue;
            end;
            ExecDown := True;

            FileCount := FileCount + 1;
          end;
          Message1Label.Visible    := ExecDown;
          UpdateButton.Visible     := ExecDown;
          Exit;
        end;

        //실제 화일을 다운로드 받는다
        IdHTTP.ReadTimeout := 0;
        vStringList.Clear;
        UP_ini.ReadSectionValues(iniUploadDate, vStringList);
        For vIndex := 0 to vStringList.Count-1 do
        begin
          vFileName := LeftStr(vStringList.Strings[vIndex], Pos('=',vStringList.Strings[vIndex])-1);
          DownLoadTime := UP_ini.ReadString(iniUploadDate, vFileName ,'0');
          if (StrToFloat(DownLoadTime) <= StrToFloat(DN_ini.ReadString(iniDownloadInfo, vFileName,'0'))) then Continue;

          if Pos(Application.Title, vFileName) = 0 then
          begin
            KillTask(vFileName);
            Sleep(500);
          end;

          FtpStatus  := ftWork;
          DN_ini.WriteString(iniDownloadInfo, vFileName, fsDownLoading);
          MemStream := TMemoryStream.Create;
          with MemStream do
            try
              FileDown('H',fsURL+fsServerPath+vFileName);
              if Text <> '-1' then
              begin
                //화일크기를 알아낸다
                Files.Size := IdHTTP.Response.ContentLength;
                IdHTTP.Get(fsURL+fsServerPath+vFileName, MemStream);
                if Pos(Application.Title, vFileName) > 0 then
                begin
                  if fsProgram  = 'OrangePOS.exe' then
                  begin
                    KillTask('Demon.exe');
                    SaveToFile('OrangePOS_Down.exe');
                  end
                  else
                    SaveToFile(DownPath+vFileName);
                end
                else
                begin
                  case GetFilePath(vFileName) of
                    FilePos : vCopyPath := AppPath;
                    Dll     : vCopyPath := AppPath+'Dll\';
                    Data    : vCopyPath := AppPath+'Data\';
                    Sys     : vCopyPath := SystemPath;
                  end;
                  SaveToFile(vCopyPath+vFileName);
                end;
              end;
            finally
              Free;
            end; // try .. finally ..

            if FtpStatus = ftAbort then Exit;
            DN_ini.WriteString(iniDownloadInfo,vFileName,DownLoadTime);
            Sleep(100);
        end;
    except
    end;
  finally
    FileList.Free;
//    ReadyFileCopy;
  end;
end;

procedure TDownload_F.CallCancelButtonClick(Sender: TObject);
begin
  Self.Height := 262;
  Self.Width  := 425;
  panPassWord.Visible := false;
end;

procedure TDownload_F.CancelButtonClick(Sender: TObject);
begin
  FtpStatus := ftAbort;
  Close;
end;

procedure TDownload_F.CloseTimerTimer(Sender: TObject);
begin
  CloseTimer.Enabled := false;
  if CloseTimer.Tag = 1 then ModalResult := mrOK
  else                       ModalResult := mrCancel;
end;

//**************************************************************************//
//                           화일을 다운받는 중
//**************************************************************************//
procedure TDownload_F.IdHTTPWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Integer);
begin
  Application.ProcessMessages;
end;

//**************************************************************************//
//                           화일다운받기 시작
//**************************************************************************//
procedure TDownload_F.IdHTTPWorkBegin(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCountMax: Integer);
begin
  WorkPanel.Visible := true;
  WorkPanel.Height  := 205;
  WorkPanel.Width   := 360;
  WorkPanel.BringToFront;
  MessageLabel.Caption := '업데이트 중 입니다...';
end;

//**************************************************************************//
//                           화일다운을 완료후
//**************************************************************************//
procedure TDownload_F.IdHTTPWorkEnd(ASender: TObject;
  AWorkMode: TWorkMode);
begin
  case FtpStatus of
    ftWork :begin
              FtpStatus             := ftConn;
            end;
    ftAbort:begin
              if FileExists(DownPath+Files.Name) then
              begin
                DelFile := Files.Name;
                WorkPanel.Visible := false;
              end;
            end;
  end;
  Application.ProcessMessages;
end;

procedure TDownload_F.Num_7Click(Sender: TObject);
begin
  edtPassWord.Text := edtPassWord.Text + (Sender as TAdvSmoothToggleButton).Caption;
  edtPassWord.SelStart := Length(edtPassWord.Text);
//  lblMessage.Caption := EmptyStr;
end;

procedure TDownload_F.Num_BSClick(Sender: TObject);
begin
  Keybd_Event(VK_BACK, VK_BACK, 0, 0);
end;

procedure TDownload_F.Num_EnterClick(Sender: TObject);
begin
  if edtPassword.Text <> '15444171' then
    edtPassword.Clear
  else
  begin
    //업데이트를 하고나면 자동으로 계속 못하도록 한다
    with TIniFile.Create(AppPath+'Config.ini') do
      try
        DeleteKey('POS', 'UPDATE_PWD');
        WriteBool('POS', 'UPDATE', False);
      finally
        Free;
      end; // try .. finally .

    panPassWord.Visible := false;
    Self.ClientHeight := 275;
    Self.ClientWidth  := 430;
    MessageLabel.Caption := '업데이트 중입니다....';
    WorkPanel.Visible := true;
    Application.ProcessMessages;
    if FileDownload then ModalResult := mrOK
    else                 ModalResult := mrCancel;
  end;

end;

procedure TDownload_F.cxButton11Click(Sender: TObject);
begin
  edtPassWord.Clear;
end;

function TDownload_F.FileDownload:Boolean;
begin
  Result := false;
  UpdateButton.Visible     := False;
  Application.ProcessMessages;
  ExecDownload;
  Result := bDownLoad;
end;

procedure TDownload_F.edtPasswordKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Num_Enter.Click;
end;

procedure TDownload_F.StartTimerTimer(Sender: TObject);
var vPwd :String;
    vResult :String;
begin
  Self.ClientHeight := 275;
  Self.ClientWidth  := 430;
  StartTimer.Enabled := false;
  CancelButton.Visible  := false;
  vResult := GetDosOutput('ping www.expos.co.kr');

  if Pos('TTL=',vResult) = 0 then
  begin
    with TIniFile.Create(AppPath+'CONFIG.INI') do                                          
      try
        WriteString('POS','PING FAIL', FormatDateTime('yyyy-mm-dd hh:nn:ss',now()));
      finally
        Free;
      end;
    CloseTimer.Enabled := True;
    Exit;
  end
  else
  begin
    with TIniFile.Create(AppPath+'CONFIG.INI') do
      try
        WriteString('POS','PING CHECK', FormatDateTime('yyyy-mm-dd hh:nn:ss',now()));
      finally
        Free;
      end;
  end;

  try
    //다운로드할 내역이 있는지 체크한다
    ExecDownload;
  except
  end;
  CancelButton.Visible  := true;

  //다운로드할 내역이 없으면 그냥 폼을 닫는다
  if not ExecDown then
    CloseTimer.Enabled := True
  else if (dsProgram = dpOrange) then
  begin
    WorkPanel.Visible     := false;
    UpdateButton.Visible  := true;
    CancelButton.Visible  := true;
    Message1Label.Visible := true;
    Message2Label.Visible := true;
    ClientWidth           := 425;
    ClientHeight          := 262;
    Self.Resize;

    with TIniFile.Create(AppPath+'Config.ini') do
      try
        vPwd := ReadString('POS', 'UPDATE_PWD','');
      finally
        Free;
      end; // try .. finally ..
    if vPwd = '15444171' then
      UpdateButtonClick(nil);
  end;
end;

procedure TDownload_F.UpdateButtonClick(Sender: TObject);
var vStr :String;
begin
  if Sender <> nil then
  begin
    panPassWord.Left   := 0;
    panPassWord.Top    := 0;
    Self.ClientWidth   := panPassWord.Width;
    Self.ClientHeight  := panPassWord.Height;
    Self.Refresh;
    panPassWord.Visible := true;
    edtPassword.Clear;
    edtPassword.SetFocus;
  end
  else if Sender = nil then
  begin
    WorkPanel.Left   := 0;
    WorkPanel.Top    := 0;
    Self.ClientWidth   := WorkPanel.Width;
    Self.ClientHeight  := WorkPanel.Height;
    WorkPanel.BringToFront;
    WorkPanel.Visible  := true;
    FileDownload;
    CloseTimer.Tag := 1;
    CloseTimer.Enabled := true;
  end;
end;

function TDownload_F.GetDosOutput(aCommandLine: string): string;
var
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  Buffer: array[0..255] of AnsiChar;
  BytesRead: Cardinal;
  WorkDir: string;
  Handle: Boolean;
begin
  SetLength(WorkDir, 256);
  GetSystemDirectory(PChar(WorkDir), 256);

  Result := '';
  with SA do begin
    nLength := SizeOf(SA);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;
  CreatePipe(StdOutPipeRead, StdOutPipeWrite, @SA, 0);
  try
    with SI do
    begin
      FillChar(SI, SizeOf(SI), 0);
      cb := SizeOf(SI);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE); // don't redirect stdin
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;
    Handle := CreateProcess(nil, PChar('cmd.exe /C ' + aCommandLine),
                            nil, nil, True, 0, nil,
                            PChar(WorkDir), SI, PI);
    CloseHandle(StdOutPipeWrite);
    if Handle then
      try
        repeat
          WasOK := ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil);
          if BytesRead > 0 then
          begin
            Buffer[BytesRead] := #0;
            Result := Result + Buffer;
          end;
        until not WasOK or (BytesRead = 0);
        WaitForSingleObject(PI.hProcess, INFINITE);
      finally
        CloseHandle(PI.hThread);
        CloseHandle(PI.hProcess);
      end;
  finally
    CloseHandle(StdOutPipeRead);
  end;
end;

procedure TDownload_F.KillTask(ExeFileName: string);
var
  Next     : BOOL;
  SHandle  : THandle;
  Process32: TProcessEntry32;
  ProcId   : DWORD;
begin
  Process32.dwSize := SizeOf(TProcessEntry32);
  SHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);

  if Process32First(SHandle, Process32) then
  begin
    repeat
      Next := Process32Next(SHandle, Process32);
      if Next then
      begin
        GetWindowThreadProcessID(SHandle, @ProcId);
        if Process32.szExeFile = ExeFileName then
        begin
          ProcId  := DWORD(Process32.th32ProcessID);
          SHandle := OpenProcess(PROCESS_ALL_ACCESS, TRUE, ProcId);
          TerminateProcess(SHandle, 0);
        end;
      end;
    until not Next;
  end;
  CloseHandle(SHandle);
end;

end.
