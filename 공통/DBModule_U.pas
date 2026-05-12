unit DBModule_U;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Registry,
  Dialogs,  DB, IniFiles, winsock, StrUtils, WinSvc, EncdDecd,
  DBAccess, Uni, MemDS, SQLServerUniProvider, UniProvider, ShlObj,
  DAScript, UniScript, MySQLUniProvider, Variants, dxmdaset, cxGridTableView,
  IPPeerClient, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  DCPcrypt2, DCPblockciphers, DCPrijndael, DCPBase64, DCPsha256, REST.Types;

type
  TDM = class(TDataModule)
    UniConnection: TUniConnection;
    UniQuery: TUniQuery;
    UPSSConnection: TUniConnection;
    UPSSQuery: TUniQuery;
    Script: TUniScript;
    StoredProc: TUniStoredProc;
    Query: TUniQuery;
    CloudData: TdxMemData;
    SQL: TUniSQL;
    QueryEx: TUniQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    function GetIPAddress: AnsiString;
    function ServiceGetStatus(sMachine, sService: PChar): DWORD;
  public
    lbError, CloudConnected :Boolean;  //오프라인 모드일때는 서버를 조회하지 않는다
    PosDBPath,
    ServerDBRoot :WideString;
    StoreCode,
    PosIP :String;
    TempSQL :String;
    Folder :String;
    function ConnectDB: Boolean;
    function OpenQuery(aSQL:string; aParam:Array of Variant):Integer;
    function OpenQueryEx(aSQL:string; aParam:Array of Variant):Integer;
    function UPSSConnect:Boolean;
    function ReadQuery(aQuery: TUniQuery; aGridTableView: TcxGridTableView; aMemData: TdxMemData = nil): Boolean;
    function ExecCloud(aSQL: string; aParam: array of Variant; aExecute: Boolean; aURL:String): Boolean;
    function OpenCloud(aSQL: string; aParam: array of Variant; aURL:String): Boolean;
    function GetCloudData(aTableName:String):String;
    function ExecCloudProcedure(aProcedure: string;aErrTitle:String=''): Boolean;
    procedure DownLanguage;

    //암호화
    function GetEncrypt(aURL,aData : String) : String;
  end;

var
  DM: TDM;
const
  andChar              = #$03B0;

implementation
uses Common_U, GlobalFunc_U, Const_U;
{$R *.dfm}

function TDM.ConnectDB: Boolean;
begin
  try
    if not UniConnection.Connected then
    begin
      with TIniFile.Create(ExtractFilePath(Application.ExeName)+'Config.INI') do
      try
        UniConnection.Server   := ReadString('공통','DB_IP','127.0.0.1');
        UniConnection.Username := ReadString('공통','DB_USER','expos');
        UniConnection.Port     := ReadInteger('공통','DB_PORT',3306);
        UniConnection.Password := 'expos4171!@#$';
        UniConnection.Open;
      finally
        free;
      end;
    end;
    Result := True;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar('데이터베이스와 연결할 수 없습니다.'#13#13'에러내용:'#13+E.Message),
                             'OrangePOS',
                              MB_ICONERROR);
      Result := False;
    end;
  end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
var vDBIP,
    vDBName,
    vUser : String;
    vPort : Integer;
    vHandle : THandle;
begin
  Folder := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));;
  if Folder = EmptyStr then
    Folder := String(GetRegistry(HKEY_CURRENT_USER, regPath, 'Path'));

  if Folder <> '' then
    SetRegistry(HKEY_CURRENT_USER, regPath, 'Path',Folder);


  TempSQL := '';
  //아이피가 변경됐을때를 대비 서버에서 아이피 체크

  UniConnection.Disconnect;
  with TIniFile.Create(Folder+'Config.ini') do
    try
      vDBName     := ReadString('공통','DB_NAME','orangepos');
      vDBIP       := ReadString('공통','DB_IP','127.0.0.1');
      vPort       := ReadInteger('공통','DB_PORT',3306);
      vUser       := ReadString('공통','DB_USER','expos');
      PosIP       := ReadString('POS','POS_IP','');
    finally
      free;
    end;

  if PosIP = '' then
    PosIP := GetIPAddress;

  try
    lbError                  := False;
    UniConnection.Server   := vDBIP;
    UniConnection.Port     := vPort;
    UniConnection.Database := vDBName;
    UniConnection.Username := vUser;
    UniConnection.Password := 'expos4171!@#$';
    UniConnection.Connect;

    OpenQuery('select CD_STORE '
             +'  from MS_STORE ',
             []);
    if Query.Eof then
    begin
      Query.Close;
      Application.MessageBox(PChar('포스DB에 매장정보가 없습니다'#13#13'TR에서 기초자료를 다운로드 먼저 해야합니다'),
                                   'OrangePOS',
                                    MB_ICONERROR);

      lbError := true;
      Exit;
    end
    else
      StoreCode := Query.Fields[0].AsString;
    Query.Close;
  except
    OpenCloud('select POSDB_IP '
             +'  from CUSTOMER '
             +' where CD_COMPANY  =:P0 '
             +'   and CD_CUSTOMER =:P1 ',
             [],'');

    if not CloudData.Eof then
    begin
      with TIniFile.Create(Folder+'Config.ini') do
        try
          WriteString('공통','DB_IP',CloudData.Fields[0].AsString);
        finally
          free;
        end;

      if vDBIP <> CloudData.Fields[0].AsString then
      begin
        Application.MessageBox(PChar('포스 DB IP가 재설정 되었습니다' +#13#13+
                                     '포스프로그램을 다시 실행해주세요.'),
                                     'OrangePOS',
                                      MB_OK);
        lbError := True;
        Exit;
      end;
      CloudData.Close;
    end;
    Application.MessageBox(PChar(Format('데이터베이스 연결실패' +#13#13+'[접속정보]%s-%s(%s)'+#13+
                                 '관리자에게 문의바랍니다.',[vDBName,vDBIP,vPort]) ),
                                 'OrangePOS',
                                  MB_ICONERROR);
    vHandle := FindWindow(nil, 'POSDemon');
    SendMessage(vHandle,WM_SYSCOMMAND,SC_CLOSE,0);
    lbError := True;
  end;
end;

procedure TDM.DownLanguage;
var vData,
    vResult,
    vColData,
    vRecord,
    vResponse :String;
    vIndex, vI, vJ :Integer;
    vRow, vCol, vFieldNameList, vFieldTypeList : TStringList;
    vField: TField;
    vURL, vDBName,
    vSQL, vTemp :String;
    vRESTRequest :TRESTRequest;
    vRESTClient  :TRESTClient;
    vRESTResponse :TRESTResponse;
    vItem : TRESTREquestParameter;
    vDataList :TStringList;
    vStream   :TStream;
    vLanguage  :^TLanguage;
begin
  try
    vSQL := Format('select KOREAN, ENGLISH, CHINESE_SIMPLE, JAPANESE, VIETNAMESE, THAI, INDONESIAN, FRENCH, GERMAN '
                  +'  from MS_LANGUAGES'
                  +' where CD_HEAD  =''%s'' '
                  +'   and CD_STORE =''%s'' ',
                 [Common.Config.HeadStoreCode,
                  Ifthen(GetHeadOption(1)='0',Common.Config.StoreCode,'00000000')]);

    vRESTClient   := TRESTClient.Create(nil);
    vURL    := CopyPos(Common.RestDBURL,'|',0);
    vDBName := CopyPos(Common.RestDBURL,'|',1);
    vRESTClient.BaseURL := vURL+'Action_Select';
    vRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    vRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
    vRESTClient.AcceptEncoding := 'UTF-8';
    vRESTRequest  := TRESTRequest.Create(nil);
    vRESTResponse := TRESTResponse.Create(nil);
    vRESTRequest.Response := vRESTResponse;
    vRESTRequest.Client   := vRESTClient;
    vRESTRequest.AcceptEncoding := 'UTF-8';
    vRESTRequest.Method         := rmPOST;
    vRestRequest.Params.AddItem('SQL',GetEncrypt(vRESTClient.BaseURL,vSQL), TRESTRequestParameterKind.pkREQUESTBODY, [], TRESTContentType.ctAPPLICATION_JSON);
    if vDBName <> '' then
      vRestRequest.Params.AddHeader('USER_DB',vDBName);
    try
      Screen.Cursor := crHourGlass;
      vRESTRequest.Execute;
    except
      on E: Exception do
      begin
        Screen.Cursor := crDefault;
        raise Exception.Create(e.Message);
        Exit;
      end;
    end;
    vDataList := TStringList.Create;
    vDataList.Clear;
    Screen.Cursor := crDefault;
    vRESTResponse.GetSimpleValue('RESULT',vResult);
    if Copy(vResult,1,5) = 'ERROR' then
    begin
      raise Exception.Create(CopyPos(vResult, splitColumn, 1));
      Exit;
    end;
    vRESTResponse.GetSimpleValue('DATA',vData);
    if vData = '' then Exit;

    vData := Replace(vData,'"','〃');     //아주중요 Split 오류
    vData := Replace(vData,'\','');
    vData := Replace(vData,'＇','''');
    vData := Replace(vData,andChar, '&');
    vData := Replace(vData, '#$D#$A',#$D#$A);

    Common.LanguageData.Clear;

    vRow := TStringList.Create;
    vCol := TStringList.Create;
    vRecord := '';
    try
      Split(vData, splitRecord, vRow);
      for vI := 0 to vRow.Count-1 do
      begin
        if vRow[vI] = '' then Continue;
        Split(vRow[vI], splitColumn, vCol);

        New(vLanguage);
        for vJ := 0 to vCol.Count-1 do
        begin
          vColData := Replace(vCol[vJ],'〃','"');
          case vJ of
            0 : vLanguage.Korean   := vColData;
            1 : vLanguage.English  := vColData;
            2 : vLanguage.China    := vColData;
            3 : vLanguage.Japanese := vColData;
            4 : vLanguage.Vitenam  := vColData;
            5 : vLanguage.Thai     := vColData;
            6 : vLanguage.Indo     := vColData;
            7 : vLanguage.French   := vColData;
            8 : vLanguage.German   := vColData;
          end;
        end;
        Common.LanguageData.Add(vLanguage);
      end;
    except
    end;
  finally
    vRESTClient.DisConnect;
    FreeAndNil(vRESTResponse);
    FreeAndNil(vRESTRequest);
    FreeAndNil(vRESTClient);

    if Assigned(vRow) then
      vRow.Free;
    if Assigned(vCol) then
      vCol.Free;
  end;
end;

function TDM.ExecCloud(aSQL: string; aParam: array of Variant;
  aExecute: Boolean; aURL:String): Boolean;
  function  ConvertSQL(aSQL: string; aParam: array of Variant): String;
  var  vIndex : Integer;
       vTemp,
       vSQL   : String;
  begin
    vSQL := aSQL;
    for vIndex := High(aParam) downto 0 do
    begin
      case VarType(aParam[vIndex]) of
        varInteger : vSQL := Replace(vSQL, Format(':P%d',[vIndex]), FormatFloat('#0',aParam[vIndex]));
        varDouble,
        varCurrency : vSQL := Replace(vSQL, Format(':P%d',[vIndex]), FormatFloat('#0.00',aParam[vIndex]));
        else
        begin
          vTemp := Replace(NVL(aParam[vIndex],''),'''','"');
          vTemp := Replace(vTemp, ';','');
          vSQL  := Replace(vSQL, Format(':P%d',[vIndex]), Format('''%s''',[vTemp]));
        end;
      end;
    end;
    Result := vSQL;
end;
var vResult,
    vURL, vDBName,
    vSQL :String;
    vRESTRequest :TRESTRequest;
    vRESTClient  :TRESTClient;
    vRESTResponse :TRESTResponse;
    vItem : TRESTREquestParameter;
begin
  Result := false;

  if High(aParam) > 0 then
  begin
    vSQL    := ConvertSQL(aSQL, aParam);
    TempSQL := TempSQL + vSQL;
  end
  else
  begin
    if TempSQL = aSQL then
      TempSQL := aSQL
    else
      TempSQL := TempSQL + aSQL;
  end;
  if TempSQL = '' then Exit;

  if not aExecute then
    Exit;

  vSQL := Replace(TempSQL, #9, '');
  vSQL := Replace(vSQL, '\''','\\''');
  vSQL := Replace(vSQL, #$D#$A, '#$D#$A');

  try
    vRESTClient   := TRESTClient.Create(nil);
    vURL    := CopyPos(aURL,'|',0);
    vDBName := CopyPos(aURL,'|',1);

    vRESTClient.BaseURL := vURL+'Action_Excute';
    vRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    vRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
    vRESTClient.AcceptEncoding := 'UTF-8';
    vRESTRequest  := TRESTRequest.Create(nil);
    vRESTResponse := TRESTResponse.Create(nil);
    vRESTRequest.Response := vRESTResponse;
    vRESTRequest.Client   := vRESTClient;
    vRESTRequest.AcceptEncoding := 'UTF-8';
    vRESTRequest.Method         := rmPOST;
    vRESTClient.ConnectTimeout  := 1000;
    vRESTClient.ReadTimeout     := 5000;
    vRestRequest.Params.AddItem('SQL',GetEncrypt(vRESTClient.BaseURL,vSQL), TRESTRequestParameterKind.pkREQUESTBODY, [], TRESTContentType.ctAPPLICATION_JSON);
    if vDBName <> '' then
      vRestRequest.Params.AddHeader('USER_DB',vDBName);
    try
      vRESTRequest.Execute;
      TempSQL := '';
    except
      on E: Exception do
      begin
        raise Exception.Create(E.Message);
        Exit;
      end;
    end;

    vRESTResponse.GetSimpleValue('RESULT',vResult);
    if Copy(vResult,1,5) = 'ERROR' then
    begin
      raise Exception.Create(CopyPos(vResult, splitColumn, 1));
      Exit;
    end;
    Result := true;
  finally
    if Assigned(vRESTClient) then
      vRESTClient.Disconnect;
    FreeAndNil(vRESTResponse);
    FreeAndNil(vRESTRequest);
    FreeAndNil(vRESTClient);
  end;
end;

//문자발송 시 사용으로 암호화하지 않는다
function TDM.ExecCloudProcedure(aProcedure: string;aErrTitle:String): Boolean;
var vURL, vDBName,
    vResult:String;
    vRESTRequest :TRESTRequest;
    vRESTClient  :TRESTClient;
    vRESTResponse :TRESTResponse;
    vItem : TRESTREquestParameter;
    vErrCount :Integer;
label Retry;
begin
  vErrCount := 0;
Retry:
  try
    vRESTClient   := TRESTClient.Create(nil);
    vRESTClient.BaseURL := jsonSMSURL+'Action_PCall';
    vRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    vRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
    vRESTClient.AcceptEncoding := 'UTF-8';
    vRESTRequest  := TRESTRequest.Create(nil);
    vRESTResponse := TRESTResponse.Create(nil);
    vRESTRequest.Response := vRESTResponse;
    vRESTRequest.Client   := vRESTClient;
    vRESTRequest.AcceptEncoding := 'UTF-8';
    vRESTRequest.Method         := rmPOST;
    vRESTClient.ConnectTimeout  := 3000;
    vRESTClient.ReadTimeout     := 3000;
    vRestRequest.Params.AddItem('SQL',GetEncrypt(vRESTClient.BaseURL,aProcedure), TRESTRequestParameterKind.pkREQUESTBODY, [], TRESTContentType.ctAPPLICATION_JSON);
    try
      Result := false;
      vRESTRequest.Execute;

      vRESTResponse.GetSimpleValue('RESULT',vResult);
      if Copy(vResult,1,5) = 'ERROR' then
      begin
        if aErrTitle <> '' then
          Common.MsgBox(aErrTitle + #13#13 +CopyPos(vResult, splitColumn, 1))
        else
          Common.WriteLog('Error', 'ExecCloudProcedure - '+ CopyPos(vResult, splitColumn, 1));
        Exit;
      end;
      Result := true;
    except
      on E: Exception do
      begin
        if (Pos('작업 시간을 초과했습니다', E.Message) > 0) and (vErrCount = 0) then
        begin
          Sleep(500);
          vErrCount := vErrCount + 1;
        end
        else
        begin
          if aErrTitle <> '' then
            Common.ErrBox(E.Message)
          else
            Common.WriteLog('Error', 'ExecCloudProcedure - '+ E.Message);
        end;
      end;
    end;
  finally
    if Assigned(vRESTClient) then
      vRESTClient.Disconnect;
    FreeAndNil(vRESTResponse);
    FreeAndNil(vRESTRequest);
    FreeAndNil(vRESTClient);
  end;

  if not Result and (vErrCount = 1) then
  begin
    vErrCount := vErrCount + 1;
    goto Retry;
  end;
end;

function TDM.GetCloudData(aTableName:String):String;
var vSQL,
    vTemp,
    vInsertSQL,
    vData :String;
    vCol, vCount :Integer;
begin
  Result := '';
  if CloudData.Eof then
  begin
    CloudData.Close;
    Exit;
  end;

  vData      := '';
  vInsertSQL := '';
  vCount := 0;
  for vCol := 0 to CloudData.FieldCount-1 do
    vInsertSQL := vInsertSQL + Format('%s,',[CloudData.Fields[vCol].FieldName]);
  vInsertSQL := 'insert into '+aTableName+'('+LeftStr(vInsertSQL,Length(vInsertSQL)-1)+') values ';

  while not CloudData.Eof do
  begin
    vSQL   := '';
    for vCol := 0 to CloudData.FieldCount-1 do
    begin
      case CloudData.Fields[vCol].DataType of
        DB.ftSmallint,
        DB.ftInteger,
        DB.ftWord,
        DB.ftShortint   :
        begin
          vSQL := vSQL + Format('%d,',[CloudData.Fields[vCol].AsInteger]);
        end;
        DB.ftFloat,
        DB.ftCurrency,
        DB.ftExtended   :
        begin
          vSQL := vSQL + Format('%s,',[FloatToStr(CloudData.Fields[vCol].AsCurrency)]);
        end;
        DB.ftDate,
        DB.ftTime,
        DB.ftDateTime    :
        begin
          if FormatDateTime('yyyymmdd',CloudData.Fields[vCol].AsDateTime) < '20000101' then
            vSQL := vSQL + 'null,'
          else
            vSQL := vSQL + Format('''%s'',',[FormatDateTime('yyyy-mm-dd hh:nn:ss',CloudData.Fields[vCol].AsDateTime)]);
        end;
        DB.ftBlob :
        begin
          vSQL := vSQL + Format('''%s'',',['']);
        end
        else
        begin
          vTemp := Replace(CloudData.Fields[vCol].AsString,';','');
          vSQL := vSQL + Format('''%s'',',[vTemp]);
        end;
      end;
    end;
    vSQL := '('+LeftStr(vSQL, Length(vSQL)-1) + '),';
    vData := vData + vSQL;
    Inc(vCount);
    if vCount > 500 then
    begin
      Result := Result + vInsertSQL + LeftStr(vData, Length(vData)-1) + ';';
      vCount := 0;
      vData  := '';
    end;
    CloudData.Next;
  end;
  if vCount > 0 then
    Result := Result + vInsertSQL + LeftStr(vData, Length(vData)-1) + ';';

  CloudData.Close;
end;

function TDM.GetIPAddress: AnsiString;
var
  vWSAData : TWSAData;
  vHostName: AnsiString;
  vHostEnt : pHostEnt;
begin
  WSAStartup(2, vWSAData);
  SetLength(vHostName, 255);
  GetHostName(PAnsiChar(vHostName), 255);
  SetLength(vHostName, StrLen(PAnsiChar(vHostName)));
  vHostEnt := GetHostByName(PAnsiChar(vHostName));

  if not Assigned(vHostEnt) then
    Result :='127.0.0.1'
  else
    with vHostEnt^ do
      Result := Format('%d.%d.%d.%d', [Byte(h_addr^[0]), Byte(h_addr^[1]), Byte(h_addr^[2]), Byte(h_addr^[3])]);
  WSACleanup;
end;

function TDM.ServiceGetStatus(sMachine, sService: PChar): DWORD;
var
SCManHandle, SvcHandle: SC_Handle;
SS: TServiceStatus;
dwStat: DWORD;
begin
  dwStat := 0;
  // Open service manager handle.
  SCManHandle := OpenSCManager(sMachine, nil, SC_MANAGER_CONNECT);
  if (SCManHandle > 0) then begin
     SvcHandle := OpenService(SCManHandle, sService, SERVICE_QUERY_STATUS);
     // if Service installed
     if (SvcHandle > 0) then begin
       // SS structure holds the service status (TServiceStatus);
       if (QueryServiceStatus(SvcHandle, SS)) then
         dwStat := ss.dwCurrentState;
       CloseServiceHandle(SvcHandle);
     end;
     CloseServiceHandle(SCManHandle);
  end;
  Result := dwStat;
end;

function TDM.OpenCloud(aSQL: string; aParam: array of Variant;
  aURL:String): Boolean;
var  vData,
    vFieldName,
    vFieldType,
    vResult,
    vResponse :String;
    vIndex, vI, vJ :Integer;
    vRow, vCol, vFieldNameList, vFieldTypeList : TStringList;
    vField: TField;
    vURL, vDBName,
    vSQL, vTemp :String;
    vRESTRequest :TRESTRequest;
    vRESTClient  :TRESTClient;
    vRESTResponse :TRESTResponse;
    vItem : TRESTREquestParameter;
begin
  Result := false;
  try
    vSQL := aSQL;
    for vIndex := High(aParam) downto 0 do
    begin
      case VarType(aParam[vIndex]) of
        varInteger,
        varDouble,
        varCurrency : vSQL := Replace(vSQL, Format(':P%d',[vIndex]), FormatFloat('#0',NVL(aParam[vIndex],0.0)));
        else
        begin
          vTemp := Replace(NVL(aParam[vIndex],''),'''','"');
          vTemp := Replace(vTemp, ';','');
          vSQL  := Replace(vSQL, Format(':P%d',[vIndex]), Format('''%s''',[vTemp]));
        end;
      end;
    end;

    CloudConnected := true;
    vRESTClient   := TRESTClient.Create(nil);
    vURL    := CopyPos(aURL,'|',0);
    vDBName := CopyPos(aURL,'|',1);

    vRESTClient.BaseURL := vURL+'Action_Select';
    vRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    vRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
    vRESTClient.AcceptEncoding := 'UTF-8';
    vRESTRequest  := TRESTRequest.Create(nil);
    vRESTResponse := TRESTResponse.Create(nil);
    vRESTRequest.Response := vRESTResponse;
    vRESTRequest.Client   := vRESTClient;
    vRESTRequest.AcceptEncoding := 'UTF-8';
    vRESTRequest.Method         := rmPOST;
    vRESTClient.ConnectTimeout  := 3000;
    vRESTClient.ReadTimeout     := 3000;
    vRestRequest.Params.AddItem('SQL',GetEncrypt(vRESTClient.BaseURL,vSQL), TRESTRequestParameterKind.pkREQUESTBODY, [], TRESTContentType.ctAPPLICATION_JSON);
    if vDBName <> '' then
      vRestRequest.Params.AddHeader('USER_DB',vDBName);
    try
      vRESTRequest.Execute;
    except
      on E: Exception do
      begin
        CloudConnected := false;
        Common.WriteLog('OpenCloud',E.Message);
        Exit;
      end;
    end;
    vRESTResponse.GetSimpleValue('RESULT',vResult);
    if (Copy(vResult,1,5) = 'ERROR') or (Copy(vResult,1,4) = 'null') then
    begin
      Common.WriteLog('OpenCloud',CopyPos(vResult, splitColumn, 1));
      Exit;
    end;
    vRESTResponse.GetSimpleValue('DATA',vData);
    if vData = '' then Exit;
    vRESTResponse.GetSimpleValue('FIELD_NAME', vFieldName);
    vRESTResponse.GetSimpleValue('FIELD_TYPE', vFieldType);

    vData := Replace(vData,'＇','''');
    vData := Replace(vData,andChar, '&');
    vData := StringReplace(vData,'#$D#$A',#$D#$A,[rfReplaceAll]); //Replace(vData, '#$D#$A',#$D#$A);

    //데이터셋에 필드구조를 만든다
    CloudData.Close;
    CloudData.Fields.Clear;
    vFieldNameList := TStringList.Create;
    Split(vFieldName, splitColumn, vFieldNameList);

    vFieldTypeList := TStringList.Create;
    Split(vFieldType, splitColumn, vFieldTypeList);

    for vIndex := 0 to vFieldNameList.Count-1 do
    begin
      if vFieldTypeList[vIndex] = 'S' then
      begin
        vField := TStringField.Create(CloudData);
        vField.Size := 1000;
      end
      else if vFieldTypeList[vIndex] = 'C' then
        vField := TCurrencyField.Create(CloudData)
      else if vFieldTypeList[vIndex] = 'D' then
        vField := TDateTimeField.Create(CloudData)
      else if vFieldTypeList[vIndex] = 'I' then
        vField := TIntegerField.Create(CloudData)
      else if vFieldTypeList[vIndex] = 'G' then
        vField := TGraphicField.Create(CloudData)
      else if vFieldTypeList[vIndex] = 'B' then
        vField := TBlobField.Create(CloudData);

      vField.FieldName := vFieldNameList[vIndex];
      vField.DataSet   := CloudData;
    end;

    vRow := TStringList.Create;
    vCol := TStringList.Create;
    CloudData.Open;
    Split(vData, splitRecord, vRow);
    for vI := 0 to vRow.Count-1 do
    begin
      Split(vRow[vI], splitColumn, vCol);

      CloudData.Append;
      for vJ := 0 to vCol.Count-1 do
      begin
        case CloudData.Fields[vJ].DataType of
          DB.ftSmallint,
          DB.ftInteger,
          DB.ftWord,
          DB.ftShortint   :
          begin
            if vCol[vJ] = 'null' then
              CloudData.Fields[vJ].AsInteger  := 0
            else
              CloudData.Fields[vJ].AsInteger  := StrToIntDef(vCol[vJ],0);
          end;
          DB.ftFloat,
          DB.ftCurrency,
          DB.ftExtended   :
          begin
            if (vCol[vJ] = 'null') or (vCol[vJ] = '') then
              CloudData.Fields[vJ].AsCurrency  := 0
            else
              CloudData.Fields[vJ].AsCurrency  := StrToCurr(vCol[vJ]);
          end;
          DB.ftDate,
          DB.ftTime,
          DB.ftDateTime    :
          begin
            if vCol[vJ] = 'null' then
              CloudData.Fields[vJ].AsString   := ''
            else
              CloudData.Fields[vJ].AsDateTime := StrToDateTime(vCol[vJ]);
          end;
          DB.ftBlob        : CloudData.Fields[vJ].AsBytes    := DecodeBase64(vCol[vJ]);
            else
            begin
              if vCol[vJ] = 'null' then
                CloudData.Fields[vJ].AsString   := ''
              else
                CloudData.Fields[vJ].AsString   := Replace(vCol[vJ],'''','');
            end;
        end;
      end;
    end;
    CloudData.Post;
    CloudData.First;
    Result := CloudData.RecordCount > 0;
  finally
    if Assigned(vRESTClient) then
      vRESTClient.Disconnect;
    FreeAndNil(vCol);
    FreeAndNil(vRow);
    FreeAndNil(vFieldTypeList);
    FreeAndNil(vFieldNameList);
    FreeAndNil(vRESTResponse);
    FreeAndNil(vRESTRequest);
    FreeAndNil(vRESTClient);
  end;

end;

function TDM.OpenQuery(aSQL: string; aParam: array of Variant): Integer;
  function  GetOnlyNumber(const S : AnsiString): AnsiString;        // 숫자만 골라낸다
  var nCnt :Integer;
  begin
     Result := EmptyStr;
     For nCnt := 1 to Length(S) do
     begin
       case S[nCnt] of
          #48..#57: Result := Result + S[nCnt];
       end;
     end;
  end;
var
   vIndex : Integer;
   vError : Boolean;
label ReTry;
begin
  vError := false;
ReTry:
  if not ConnectDB then Exit;
  with Query do
  begin
    Close;
    if aSQL <> EmptyStr then
    begin
      SQL.Clear;
      SQL.Text := aSQL;
    end;
    if Params.Count > 0 then
      for vIndex := 0 to Params.Count-1 do
        case VarType(aParam[StrToInt(GetOnlyNumber(Params[vIndex].Name))]) of
          varSmallint,
          varInteger,
          varByte     : Params[vIndex].AsInteger  := aParam[StrToInt(GetOnlyNumber(Params[vIndex].Name))];
          varSingle,
          varDouble,
          varCurrency : Params[vIndex].AsCurrency := aParam[StrToInt(GetOnlyNumber(Params[vIndex].Name))];
          varDate     : Params[vIndex].AsDateTime := aParam[StrToInt(GetOnlyNumber(Params[vIndex].Name))];
          else  Params[vIndex].AsString   := aParam[StrToInt(GetOnlyNumber(Params[vIndex].Name))];
        end;

    try
      Query.Open;
    except
      on E: Exception do
      begin
        if not vError and ((Pos('Cannot Connect to Server on Host', E.Message) > 0) or (Pos('Lost Connection to MySQL Server', E.Message) > 0) or (Pos('Access violation at address', E.Message) > 0)) then
        begin
          vError := true;
        end
        else
        begin
          Common.MsgBox(E.Message);
          UniConnection.Disconnect;
          vError := false;
        end;
      end;
    end;

    Result := RecordCount;
  end;

  if vError then
  begin
    Sleep(100);
    Goto ReTry;
  end;
end;

function TDM.OpenQueryEx(aSQL: string; aParam: array of Variant): Integer;
  function  GetOnlyNumber(const S : AnsiString): AnsiString;        // 숫자만 골라낸다
  var nCnt :Integer;
  begin
     Result := EmptyStr;
     For nCnt := 1 to Length(S) do
     begin
       case S[nCnt] of
          #48..#57: Result := Result + S[nCnt];
       end;
     end;
  end;
var
   vIndex : Integer;
   vError : Boolean;
label ReTry;
begin
  vError := false;
ReTry:
  if not ConnectDB then Exit;
  with QueryEx do
  begin
    Close;
    if aSQL <> EmptyStr then
    begin
      SQL.Clear;
      SQL.Text := aSQL;
    end;
    if Params.Count > 0 then
      for vIndex := 0 to Params.Count-1 do
        case VarType(aParam[StrToInt(GetOnlyNumber(Params[vIndex].Name))]) of
          varSmallint,
          varInteger,
          varByte     : Params[vIndex].AsInteger  := aParam[StrToInt(GetOnlyNumber(Params[vIndex].Name))];
          varSingle,
          varDouble,
          varCurrency : Params[vIndex].AsCurrency := aParam[StrToInt(GetOnlyNumber(Params[vIndex].Name))];
          varDate     : Params[vIndex].AsDateTime := aParam[StrToInt(GetOnlyNumber(Params[vIndex].Name))];
          else  Params[vIndex].AsString   := aParam[StrToInt(GetOnlyNumber(Params[vIndex].Name))];
        end;

    try
      QueryEx.Open;
    except
      on E: Exception do
      begin
        if not vError and ((Pos('Cannot Connect to Server on Host', E.Message) > 0) or (Pos('Lost Connection to MySQL Server', E.Message) > 0) or (Pos('Access violation at address', E.Message) > 0)) then
        begin
          vError := true;
        end
        else
        begin
          Common.MsgBox(E.Message);
          UniConnection.Disconnect;
          vError := false;
        end;
      end;
    end;

    Result := RecordCount;
  end;

  if vError then
  begin
    Sleep(100);
    Goto ReTry;
  end;
end;


function TDM.ReadQuery(aQuery: TUniQuery; aGridTableView: TcxGridTableView;
  aMemData: TdxMemData): Boolean;
var
  vIndex, vColumnIndex, vRow: Integer;
  vField: TField;
begin
  Result := false;
  Screen.Cursor := crSQLWait;
  if not ConnectDB then Exit;

  // 쿼리가 열려있을 때만 작업을 한다
  if aQuery.Active then
  begin
//  ShowMsg('자료를 불러오고 있습니다.', false, -1);
    aQuery.First;

    // 메모리 데이터 초기화
    if aMemData <> nil then
    begin
      if aMemData.Active then
        aMemData.Close;

      aMemData.Fields.Clear;
      for vIndex := 0 to aQuery.FieldCount-1 do
      begin
        case aQuery.Fields[vIndex].DataType of
          DB.ftSmallint,
          DB.ftInteger,
          DB.ftWord,
          DB.ftShortint :
            vField := TIntegerField.Create(aMemData);
          DB.ftFloat,
          DB.ftCurrency,
          DB.ftExtended :
            vField := TCurrencyField.Create(aMemData);
          DB.ftDate,
          DB.ftTime,
          DB.ftDateTime :
            vField := TDateTimeField.Create(aMemData);
          DB.ftGraphic :
            vField := TGraphicField.Create(aMemData);
          DB.ftBlob :
            vField := TBlobField.Create(aMemData);
          else
          begin
            vField := TStringField.Create(aMemData);
            vField.Size := aQuery.Fields[vIndex].Size;
          end;
        end;
        vField.FieldName := aQuery.Fields[vIndex].FieldName;
        vField.DataSet   := aMemData;
      end;
      aMemData.Open;
    end
    // 그리드 초기화
    else if aGridTableView <> nil then
      aGridTableView.DataController.RecordCount := 0;
    if aGridTableView <> nil then
      aGridTableView.BeginUpdate;

    vRow := 1;
    try
      try
        // 쿼리 값을 읽어 그리드에 보여준다
        while not aQuery.Eof do
        begin
          // 한 레코드 추가
          if aMemData <> nil then
            aMemData.Append
          else
            aGridTableView.DataController.AppendRecord;

          // 필드에 값 업데이트
          for vIndex := 0 to aQuery.FieldCount-1 do
            if aMemData <> nil then
            begin
              for vColumnIndex := 0 to aMemData.FieldCount-1 do
                if aMemData.Fields[vColumnIndex].FieldName = aQuery.Fields[vIndex].FieldName then
                begin
                  if UpperCase(aMemData.Fields[vIndex].FieldName) = 'ROWNUM' then
                    aMemData.Fields[vColumnIndex].Value := vRow
                  else
                    aMemData.Fields[vColumnIndex].Value := aQuery.Fields[vIndex].Value;
                  Break;
                end;
            end
            else
            begin
              for vColumnIndex := 0 to aGridTableView.ColumnCount-1 do
                if aGridTableView.Columns[vColumnIndex].DataBinding.FieldName = aQuery.Fields[vIndex].FieldName then
                begin
                  if UpperCase(aGridTableView.Columns[vColumnIndex].DataBinding.FieldName) = 'ROWNUM' then
                    aGridTableView.DataController.Values[aGridTableView.DataController.RecordCount-1, vColumnIndex] := vRow
                  else
                    aGridTableView.DataController.Values[aGridTableView.DataController.RecordCount-1, vColumnIndex] := aQuery.Fields[vIndex].Value;
                  Break;
                end;
            end;

          // 포스트
          if aMemData <> nil then
            aMemData.Post;

          Inc(vRow);
          aQuery.Next;
        end;
      except
      end;

      if aMemData <> nil then
        Result := aMemData.RecordCount > 0
      else
        Result := aGridTableView.DataController.RecordCount > 0;

    finally
      if aQuery.Active then
        aQuery.Close;
      if aGridTableView <> nil then
        aGridTableView.EndUpdate;
//    ShowMsg('조회가 완료 되었습니다.');
    end;
  end
  else
  begin
    if aMemData <> nil then
      aMemData.Close
    else
      aGridTableView.DataController.RecordCount := 0;
  end;
  Screen.Cursor := crDefault;
end;

function TDM.UPSSConnect:Boolean;
begin
  Result := false;
  if not FileExists('C:\Program Files\UPSS\DGPR.mdb') then Exit;

  try
    UPSSConnection.Connected    := false;
    UPSSConnection.Database     := 'C:\Program Files\UPSS\DGPR.mdb';
    UPSSConnection.LoginPrompt  := false;
    UPSSConnection.ProviderName := 'Access';
    UPSSConnection.Connected    := true;
    Result := true;
  except
    Result := false;
  end;
end;

//==============================================================================
//  AES 암호화
//------------------------------------------------------------------------------
function TDM.GetEncrypt(aURL, aData: string): string;
  function Base64EncodeBytes(const aInput: TBytes): TBytes;
  var
    vLen, vLen2: integer;
  begin
    vLen := Length(aInput);
    SetLength(result, (vLen + 2 div 3) * 4);
    vLen2 := Base64Encode(@aInput[0], @Result[0], vLen);
    SetLength(result, vLen2);
  end;
var
  vCipher: TDCP_rijndael;
  key, iv, src, dest, b64: TBytes;
  vIndex, vLen, vSize, vPad: integer;
const
  EncryptKey : Array[0..15] of Byte =  (  $F5, $92, $18, $BA, $E5, $CD, $2D, $7B,
        									   $21, $17, $A1, $68, $9B, $34, $9D, $09 );
	EncryptIV  : Array[0..15] of Byte = ($7B, $D4, $C9, $0E, $C0, $36, $60, $F4,
	        								   $6A, $13, $E8, $7A, $32, $99, $32, $FA );
begin
  if Pos('https', aURL)  > 0 then
  begin
    Result := aData;
    Exit;
  end;
  src := TEncoding.UTF8.GetBytes(aData);

  vCipher := TDCP_rijndael.Create(nil);
  try
    vCipher.CipherMode := cmCBC;
    vLen := Length(src);
    vSize := (vCipher.BlockSize div 8);
    vPad := vSize - (vLen mod vSize);
    Inc(vLen, vPad);
    SetLength(src, vLen);
    for vIndex := vPad downto 1 do
      src[vLen - vIndex] := vPad;

    SetLength(dest, vLen);
    vCipher.Init(encryptKey[0], 128, @encryptIV[0]);
    vCipher.Encrypt(src[0], dest[0], vLen);

    b64 := Base64EncodeBytes(dest);
    result := TEncoding.Default.GetString(b64);

  finally
    vCipher.Free;
  end;
end;
end.



