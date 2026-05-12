unit GlobalFunc_U;

interface

uses Windows,SysUtils,Variants,Types,Grids,Dialogs, ExtCtrls, Graphics,
     Forms, Buttons, MaskUtils, Const_U, Math, Registry, winsock,
     IniFiles, StrUtils, Classes, StdCtrls, Controls, NB30, ActiveX, Comobj,
     UrlMon, Uni, ShellAPI, DateUtils, AdvCombo, cxDropDownEdit, System.JSON,
     Data.Bind.Components, Data.Bind.ObjectScope, EncdDecd,
     shlobj, Messages, Winapi.PsAPI, TlHelp32, System.Net.HttpClient,
     IdHTTP, IdSSLOpenSSL,  System.NetEncoding, System.Hash, MMSystem;

type
  TSunB = packed record
    s_b1, s_b2, s_b3, s_b4: byte;
  end;

  TSunW = packed record
    s_w1, s_w2: word;
  end;

type
  PIPAddr = ^TIPAddr;
  TIPAddr = record
    case integer of
      0: (S_un_b: TSunB);
      1: (S_un_w: TSunW);
      2: (S_addr: longword);
  end;
 IPAddr = TIPAddr;

type
  TWavFmt = record
    AudioFormat: Word;   // 1=PCM
    NumChannels: Word;
    SampleRate: Cardinal;
    ByteRate: Cardinal;
    BlockAlign: Word;
    BitsPerSample: Word;
  end;


TRAYDATA = packed record
   wnd: HWND;
   uID: UINT;
   uCallbackMessage: UINT;
   Reserved: array [0..1] of DWORD;
   hIcon: HICON;
  end;

  TBBUTTON = packed record
    iBitmap: Integer;
    idCommand: Integer;
    fsState: BYTE;
    fsStyle: BYTE;
    bReserved: array [0..1] of BYTE;    // padding for alignment
    dwData: Pointer;                    //DWORD_PTR;
    iString: Pointer;                   //INT_PTR;
  end;

  TBBUTTON64 = packed record
    iBitmap: Integer;
    idCommand: Integer;
    fsState: BYTE;
    fsStyle: BYTE;
    bReserved: array [0..5] of BYTE;    // padding for alignment  64bit
    dwData: Pointer;                    //DWORD_PTR;
    iString: Pointer;                   //INT_PTR;
  end;


   {  스트링 문자열 제어 }
   function LPad(const aStr: string; aLength: Integer; aPadChar: Char = ' '): string; //지정한 문자로 왼쪽에 채우기 ex)1 -> 00001
   function RPad(const aStr: string; aLength: Integer; aPadChar: Char = ' '): string; //지정한 문자로 오른쪽에 채우기 ex)1 -> 10000
   function LPadB(const aStr: AnsiString; aLength: Integer; aPadChar: AnsiChar = ' '): Ansistring; //지정한 문자로 왼쪽에 채우기 ex)1 -> 00001
   function RPadB(const aStr: AnsiString; aLength: Integer; aPadChar: AnsiChar = ' '): Ansistring; //지정한 문자로 오른쪽에 채우기 ex)1 -> 10000
   function BinToHex2(aBin: string): string;
   function TColorToHex(Color : TColor) : string;
   function DelChar(vsStr : AnsiString; vcDel : AnsiChar ) : AnsiString;  //변수값의 특정 Char 제거
   function StrToFlt(aValue:AnsiString; AChange :Double):Double;    //문자형를 실수형으로
   function FtoS(aValue:Currency):AnsiString;                       //실수형를 문자로
   function StoI(aValue:AnsiString):Integer;                        //문자형을 Integer로 공백때문에
   function StoF(aValue:AnsiString):Double;                         //문자형을 Float형으로
   function FtoI(aValue:Double):Integer;                        //실수를 Integer 형으로
   function StoD(aValue:AnsiString):TDateTime;
   function Dtos(const AValue:TDateTime): AnsiString;
   function CharCnt(S:String;C:Char):Integer;                   //문자갯수 Count
   function GetCharCount(aString:String; aChar :Char): Integer;
   function SCopy(S:AnsiString; F,L:Integer):AnsiString;
   function CopyAnsi(aValue:String; aFrom, aTo:Integer):AnsiString;
   function CtoC(S:AnsiString; Oldch:AnsiString='-'; NewCh :AnsiString='') :AnsiString;       //특정문다를 다른문자로 치환하기
   function Space(Len:Integer):AnsiString;                          //공백채우기,
   function CopyPos(aValue :String; aChar :Char; sPOS:Integer):String;
   function DateComp(D:AnsiString;S:Integer):AnsiString;                //날짜에서 해당일자만큼 빼기
   function AmtofCut(AValue:Double;aPos:Integer):Integer;                    //절사금액계산
   function LengthB(aValue:String):Integer;
   function CopyStr(const aStr: string; aIndex, aCount: Integer): string; overload;                       // 한글 Copy
   function CopyStr(const aStr: string; aCount: Integer): string; overload;
   function CopyStr(const aStr: Variant; aIndex, aCount: Integer): string; overload;
   function FillChr(aLen:Integer;aChar:AnsiChar=' '):AnsiString;

   function OpenQuery(var Query :TUniQuery; aSQL:AnsiString; aParam:Array of Variant):Integer;OverLoad;
   function OpenQuery(aSQL:AnsiString; aParam:Array of Variant):Integer;OverLoad;
   function ExecQuery(aSQL:AnsiString; aParam:array of Variant; aCommit:Boolean=false): Boolean;OverLoad;
   function ExecProcedure(aSQL:AnsiString; aParam:array of Variant; aCommit:Boolean=false):Boolean;


   function  IsDate(DStr: AnsiString): Boolean;     //일자형인지 체크
   function  IsTime(DStr: AnsiString): Boolean;     //일자형인지 체크
   function  DayToWeek(DStr:AnsiString):AnsiString;
   function  SetDateTime(Tmp:AnsiString):TDateTime;
   function  wyRound(nNum,nDcUnit : Integer) :Integer;
   function  hTrunc(nNum : Extended; nDec:Integer) :Extended;        //절사(금액, 자리수)
   function  hRound(nNum : Extended) :Integer;OverLoad;              //반올림
   function  hRound(x: Extended; d: Integer): Extended;OverLoad;
   procedure ActiveForm(sClass: AnsiString);
   function  OpenComport(Com:AnsiString):Boolean;         //comport 연결 및 사용여부 확인
   function  ReverseStr(SourceStr:AnsiString):AnsiString;     //문자열 반대로(로대반 열자문)
   function  DelSpace(SourceStr:AnsiString):AnsiString;       //문자열 (앞뒤만)공백제거
   function  gf_ExecProcess(ProgramName: AnsiString): Longint;   //다른어플로 파라메터 보낼때
   function  GetDefaultPrinter: AnsiString;                //기본프린터 가져오기
   function  SetTelephone(vStr :AnsiString):AnsiString;        //전화번호에 하이픈넣기
   function  GetGenderName(aGender:AnsiString):AnsiString;
   function  GetLockerName(aGender, aSize:String):String;
   function  GetFreeMemoryMB: Integer;

   function  StringToHex(const S : AnsiString): AnsiString;
   function  HexToString(const aHex : AnsiString) : AnsiString;
   function  Encrypt(const S: AnsiString; Key: Word): AnsiString; // 암호걸기
   function  Decrypt(const S: AnsiString; Key: Word): AnsiString; // 암호풀기
   function  GetOnlyNumber(const S : AnsiString; aSign:Boolean=false): AnsiString;        // 숫자만 골라낸다
   function  NVL(aValue,bValue:Variant):Variant;
   function  NullChange(const Input: string): string;

   function  GetFileVersion(aFileName:String; aFormat:Boolean=false):AnsiString;
   function  CheckJumin(No:AnsiString):Boolean;
   function  GetIPAddress: AnsiString;                       //IP주소 구하기
   function  GetPosIP: String;                       //IP주소 구하기
   function  Replace(aData, aSrc, aDst: AnsiString): AnsiString; OverLoad;
   function  Replace(aData, aSrc, aDst: String): String; OverLoad;
   function  CheckBizNo(aNumber: AnsiString): Boolean;  // 주민등록번호 이상유무 검사


   function  SetRegistry(aRootKey: HKEY; aKey, aValue:String; aData: Variant): Boolean;                    // 레지스트리 값 저장(SetKeyValue)
   function  SetRegistryBin(aRootKey: HKEY; aKey, aValue, aData: string): Boolean;                         // 레지스트리 값 저장(SetKeyValue)
   function  GetRegistry(aRootKey: HKEY; aKey, aValue: string; aDefault: string = ''): Variant;             // 레지스트리 값 읽기(GetKeyValue)
   function  CreateRegistry(aRootKey : HKEY; aKey, aValue : AnsiString; SetData : Variant): Boolean;
   function  DeleteRegistry(aRootKey : HKEY; aKey, aValue :AnsiString):Boolean;

   function  GetOption(aIndex: Integer; aDefaultValue: Char = '0'): Char;
   function  GetHeadOption(aIndex: Integer; aDefaultValue: Char = '0'): Char;
   function  GetUserOption(aIndex: Integer; aDefaultValue: Char = '0'): Char;
   procedure ExcuteProgram(aFileName:String;aParam:String='');
   function  StringToColorDef(aValue:AnsiString; aColor:TColor):TColor;
   function  Ping : boolean;
   procedure Split(const aStr: String; aSplitChar: Char; var aList: TStringList);
   function  LineFeed(aText:String;aType:Integer=0):String;
   function  GetDosOutput(aCommandLine: String; aWorkPath: String; aWait:Boolean=true): String;
   function  GetStrPointerIndex(aComBoBox:TcxComboBox; aValue:String):Integer;
   function  GetStrPointerData(aComBoBox:TcxComboBox):String;
   function  HexToBin2(aHex:String):String;
   function  StrToBin(aData:String):String;
   function  BinToStr(aData:String):String;
   function  GetBarCode(aCode:String):String;
   function  GetTicketNo(aTicketNo:String):String;

   function  OpenQuery(var Query :TUniQuery; aSQL:string; aParam:Array of Variant):Integer;OverLoad;
   function  OpenQuery(aSQL:string; aParam:Array of Variant):Integer;OverLoad;
   function  ExecQuery(var Query :TUniQuery; aSQL:string; aParam:array of Variant): Boolean;OverLoad;
   function  ExecQuery(aSQL:string; aParam:array of Variant): Boolean;OverLoad;
   function  ExecQueryEx(aSQL:string; aParam:array of Variant; aExecute:Boolean=false): Boolean;

   function  IsMobileNumber(aValue:String):Boolean;
   function  StrPas(const Str: PAnsiChar): AnsiString;
   function  GetMacAddress: Ansistring;                                                                    // 랜카드 MAC 어드래스 구하기
   function  GetSerialNo: string;                                                                          // 시리얼넘버 구하기
   procedure ExecuteProgram(afolder,aFileName,aParameter:String; aWait:Boolean=false);
   function  CheckComPort(aPort:Integer):Boolean;
   procedure SetComPortList(aComPortComboBox:TcxComboBox; aDefault:String='');
   procedure SetComPortListEx(aComPortComboBox:TcxComboBox; aDefault:String='');
   procedure ClearPanel(var aPanel:TPanel);
   function  GetWindowsPath(nCSIDL:Word): String;
   //TTS
   function IsRiffWav(const B: TBytes): Boolean;
   function Pcm16MonoToWavBytes(const Pcm: TBytes; SampleRate: Integer): TBytes;
   procedure SaveBytesToFile(const FileName: string; const Data: TBytes);
   function GoogleTTS_SaveAsWav_Indy(const ApiKey, Text, OutWavFile: string;
                                     const SampleRate: Integer = 24000;
                                     const VoiceName: string = 'ko-KR-Wavenet-A'
                                    ): Boolean;
   procedure AddLeadingSilenceToPcmWavFile(const InWav, OutWav: string; SampleRate, LeadMs: Integer);
   function TtsCacheFileName(const CacheDir, Text: string): string;
   procedure SpeakCached_PlaySound_LeadSilence(const ApiKey, CacheDir, Text, FileName: string);
   function ReadLE32(const B: TBytes; Offset: Integer): Cardinal;
   procedure WriteLE32(var B: TBytes; Offset: Integer; Value: Cardinal);
   procedure MciStop(const AliasName: string = 'tts');
   procedure MciPlayWav(const FileName: string; const AliasName: string = 'tts');
   function ReadU32LE(const B: TBytes; Off: Integer): Cardinal;
   function ReadU16LE(const B: TBytes; Off: Integer): Word;
   function PcmToStdWavBytes(const Pcm: TBytes; const Fmt: TWavFmt): TBytes;
   function RepackWavToStandardPcm(const InWav, OutWav: string): Boolean;

   function GetRustDeskPath: string;
   function IsRustDeskInstalled: Boolean;
   function IsProcessRunning(const ExeFileName: string): Boolean;
   function IsRustDeskRunning: Boolean;
   function RunRustDesk: Boolean;
   function EnsureRustDeskRunning: Boolean;

function IcmpCreateFile() : THandle; stdcall; external 'iphlpapi.dll';
function IcmpCloseHandle(icmpHandle: THandle) : Boolean; stdcall; external 'iphlpapi.dll';
function IcmpSendEcho (IcmpHandle : THandle; DestinationAddress : IPAddr;
    RequestData : Pointer; RequestSize : Smallint;
    RequestOptions : pointer;
    ReplyBuffer : Pointer;
    ReplySize : DWORD;
    Timeout : DWORD) : DWORD; stdcall; external 'icmp.dll';

const
  C1 = 73165;
  C2 = 56;
  HexaChar : array [0..15] of AnsiChar = ('0','1','2','3','4','5','6','7','8', '9','A','B','C','D','E','F');

implementation

uses Common_U, DBModule_U;

//------------------------------------------------------------------------------
// 문자열 앞을 원하는 문자로 채우기
function LPad(const aStr: string; aLength: Integer; aPadChar: Char): string;
var
  vIndex: Integer;
begin
  Result := aStr;
  if Length(aStr) < aLength then
    for vIndex := 0 to aLength-Length(aStr)-1 do
      Result := string(aPadChar)+Result;
end;

function RPad(const aStr: string; aLength: Integer; aPadChar: Char): string;
var
  vIndex: Integer;
begin
  Result := aStr;
  if Length(aStr) < aLength then
    for vIndex := 0 to aLength-Length(aStr)-1 do
      Result := Result+string(aPadChar);
end;

//------------------------------------------------------------------------------
// 문자열 앞을 원하는 문자로 채우기
function LPadB(const aStr: Ansistring; aLength: Integer; aPadChar: AnsiChar): Ansistring;
var
  vIndex: Integer;
begin
  Result := aStr;
  if LengthB(aStr) < aLength then
    for vIndex := 0 to aLength-LengthB(aStr)-1 do
      Result := Ansistring(aPadChar)+Result;
end;

function RPadB(const aStr: Ansistring; aLength: Integer; aPadChar: AnsiChar): Ansistring;
var
  vIndex: Integer;
begin
  Result := aStr;
  if LengthB(aStr) < aLength then
    for vIndex := 0 to aLength-LengthB(aStr)-1 do
      Result := Result+Ansistring(aPadChar);

  if LengthB(Result) > aLength then
    Result := SCopy(Result, 1, aLength);
end;

function BinToHex2(aBin: string): string;
const
  BinArray: array[0..15, 0..1] of string =
    (('0000', '0'), ('0001', '1'), ('0010', '2'), ('0011', '3'),
     ('0100', '4'), ('0101', '5'), ('0110', '6'), ('0111', '7'),
     ('1000', '8'), ('1001', '9'), ('1010', 'A'), ('1011', 'B'),
     ('1100', 'C'), ('1101', 'D'), ('1110', 'E'), ('1111', 'F'));
var
  Error: Boolean;
  j: Integer;
  BinPart: string;
begin
  Result:='';

  Error:=False;
  for j:=1 to Length(aBin) do
    if not (aBin[j] in ['0', '1']) then
    begin
      Error:=True;
      Break;
    end;

  if not Error then
  begin
    case Length(aBin) mod 4 of
      1: aBin:='000'+aBin;
      2: aBin:='00'+aBin;
      3: aBin:='0'+aBin;
    end;

    while Length(aBin)>0 do
    begin
      BinPart:=Copy(aBin, Length(aBin)-3, 4);
      Delete(aBin, Length(aBin)-3, 4);
      for j:=1 to 16 do
        if BinPart=BinArray[j-1, 0] then
          Result:=BinArray[j-1, 1]+Result;
    end;
  end;
end;

function TColorToHex(Color : TColor) : string;
begin
   Result :=
     IntToHex(GetRValue(Color), 2) +
     IntToHex(GetGValue(Color), 2) +
     IntToHex(GetBValue(Color), 2) ;
end;

function DelChar(vsStr : AnsiString; vcDel : AnsiChar ) : AnsiString;
begin
    while Pos(vcDel, vsStr) > 0 do
        Delete(vsStr, Pos(vcDel, vsStr), 1);
    Result := vsStr;
end;

//Currency형의 숫자를 문자로 변환
function FtoS(AValue:Currency):AnsiString;
begin
//   Result := FormatFloat('##0.##',RoundN(AValue,2));
   Result := FormatFloat('##0.##',AValue);
end;

//문자형을 Integer로 공백때문에
function StoI(aValue:AnsiString):Integer;
begin
  //GetOnlyNumber(aValue) 사용하면 안됨 - 금액일때 문제
  aValue := Replace(aValue, ',', EmptyStr);
  aValue := Trim(aValue);
  if (Length(AValue) > 9) or (aValue = '') then
    aValue := '0';
  try
    Result := StrToInt(aValue);
  except
    Result := 0;
  end
end;

//문자형을 Float로 공백때문에
function StoF(AValue:AnsiString):Double;
begin
   AValue := CtoC(AValue,',','');
   AValue := Trim(AValue);
   if AValue = '' then AValue := '0';
   Result := StrtoFloat(AValue);
end;

//실수를 Integer 형으로
function FtoI(AValue:Double):Integer;
var Tmp :AnsiString;
begin
 Result := Trunc(AValue);
// Result := StoI(Tmp);
end;

//문자를 날짜형으로
function StoD(AValue:AnsiString):TDatetime;
var vStr :AnsiString;
begin
  vStr := GetOnlyNumber(aValue);
  Insert('-', vStr, 5);
  Insert('-', vStr, 8);
  Result := StrToDate(vStr);
end;

function Dtos(const AValue: TDateTime): AnsiString;
var
  Year, Mon, day: word;
  cMon, cDay: String[2];
begin
  Result := '';
  if AValue = 0 then Exit;
  if not (DateToStr( AValue ) = '') then
  begin
     DecodeDate(AValue, Year, Mon, Day);
     if Mon < 10 then cMon := '0' + IntToStr(Mon) else cMon := IntToStr(Mon);
     if Day < 10 then cDay := '0' + IntToStr(Day) else cDay := IntToStr(Day);
     Result := IntToStr(Year) + cMon + cDay;
  end;
end;


function CharCnt(S:String;C:Char):Integer;                   //문자갯수 Count
var vIndex :Integer;
begin
  Result := 0;
  for vIndex := 1 to Length(S) do
  begin
    if S[vIndex] = C then
      Result := Result + 1;
  end;
end;

function GetCharCount(aString:String; aChar :Char): Integer;
begin
  Result := Length(aString) - Length(StringReplace(aString, aChar, '', [rfReplaceAll, rfIgnoreCase]));
end;

function SCopy(S:AnsiString; F,L:Integer):AnsiString;
var ST, ED :Integer;        //1,30
begin
   if F = 1 then ST := 1
   else
   begin
      case ByteType(S,F) of
         mbSingleByte : ST := F;
         mbLeadByte   : ST := F;
         mbTrailByte  : ST := F-1;
      end;
   end;

   case ByteType(S,ST+L-1) of
      mbSingleByte :  ED := L;
      mbLeadByte   :  ED := L-1;
      mbTrailByte  :  ED := L;
   end;

   Result := Copy(S,ST,ED);
end;

function CopyAnsi(aValue:String; aFrom, aTo:Integer):AnsiString;
var vResult :AnsiString;
begin
  vResult := aValue;
  vResult := Copy(vResult, aFrom, aTo);
  Result := vResult;
end;

////////////////////////////////////////////////////////////////////////////////
// Name         : StrToFlt
// Explanation  : AnsiString을 integer형으로 변환시 null 값을 지정한값으로 변환
// Parameter    : AValue,AChange: AValue값이 널일경우 AChange값으로 변환
// Return value :
// Example      :
////////////////////////////////////////////////////////////////////////////////
function StrToFlt(AValue:AnsiString; AChange :Double):Double;
var
  E: Integer;
begin
  Val(AValue, Result, E);
  if E <> 0 then Result := AChange;
end;

////////////////////////////////////////////////////////////////////////////////
// Name         : CtoC
// Explanation  : 특정문자를 다른문자로 치환한다
// Parameter    :
// Return value : AnsiString
// Example      : CtoC('1,000', ',','') -> 1000
////////////////////////////////////////////////////////////////////////////////
function CtoC(S:AnsiString; Oldch, NewCh :AnsiString) :AnsiString;
begin
  Result := StringReplace(S,Oldch,NewCh,[rfReplaceAll]);
end;

function Space(Len:Integer):AnsiString;
var I :Integer;
begin
  Result := '';
  For I := 1 to Len do
    Result := Result + ' ';
end;

function CopyPos(AValue :String; AChar :Char; sPOS:Integer):String;
var I :Integer;
begin
  if (AValue <> EmptyStr) and (AValue[Length(AValue)] <> AChar) then
    AValue := AValue + AChar;

  AValue := Replace(AValue, #255, '');
  For I := 1 to sPOS do
  begin
     Delete(AValue, 1, Pos(AChar, AValue));
  end;
  Result := Copy(AValue, 1, Pos(AChar, AValue)-1);
  AValue := EmptyStr;
end;


//날짜에서 해당일자만큼 더하기
function DateComp(D:AnsiString;S:Integer):AnsiString;
var ToDay : TDateTime;
begin
   Insert('-', D, 5);
   Insert('-', D, 8);
   ToDay  := StrToDate(D);
   Result := FormatDateTime('yyyymmdd',ToDay + S);
end;

function AmtofCut(AValue:Double;aPos:Integer):Integer;
begin
  Result := 0;
  case aPos of
    0 : Result := FtoI(AValue - (Int(AValue * 0.1) * 10));
    1 :
    begin
      if aValue > 100 then
        Result := StrToInt( RightStr( FtoS(AValue), 2) )
      else
        Result := 0;
    end;
    2 :
    begin
      if aValue > 1000 then
        Result := StrToInt( RightStr( FtoS(AValue), 3) )
      else
        Result := 0;
    end;
    3 :
    begin
      if aValue > 10000 then
        Result := StrToInt( RightStr( FtoS(AValue), 4) )
      else
        Result := 0;
    end;
  end;
end;

function LengthB(aValue:String):Integer;
begin
  Result := Length(AnsiString(aValue));
end;

//------------------------------------------------------------------------------
// 한글 Copy
// Copy로 끊는 마지막 글자가 한글일 경우 반이 짤려서 문제가 생기는 것 방지
function CopyStr(const aStr: string; aIndex, aCount: Integer): string;
var
  vStr   : AnsiString;
  vResult: AnsiString;
begin
  vStr := AnsiString(aStr);
  // 원하는 글자보다 한 글자 더 가져온다
  vResult := Copy(vStr, aIndex, aCount+1);
  // 마지막 글자가 한글 첫글자인지 확인한다
  if (Length(vResult) >= aCount) and (ByteType(vResult, aCount) = mbLeadByte) then
    Result := String(Copy(vResult, 1, aCount-1)+' ')
  else
    Result := String(Copy(vResult, 1, aCount));
end;
function CopyStr(const aStr: string; aCount: Integer): string;
var
  vStr: AnsiString;
begin
  // Count가 +면 앞쪽부터 자르기, -면 뒤쪽부터 자르기
  if aCount > 0 then
    Result := CopyStr(aStr, 1, aCount)
  else if aCount < 0 then
  begin
    vStr := AnsiString(aStr);
    if Length(vStr) > aCount then
      Result := CopyStr(aStr, Length(vStr)-aCount, aCount)
    else
      Result := aStr;
  end
  else
    Result := EmptyStr;
end;
function CopyStr(const aStr: Variant; aIndex, aCount: Integer): string;
var
  vStr: string;
begin
  try
    if aStr = null then
      vStr := EmptyStr
    else if (VarType(aStr) = varSmallint) or (VarType(aStr) = varInteger) or (VarType(aStr) = varByte) then
      vStr := IntToStr(Integer(aStr))
    else if (VarType(aStr) = varSingle) or (VarType(aStr) = varDouble) or (VarType(aStr) = varCurrency) then
      vStr := FloatToStr(Currency(aStr))
    else if VarType(aStr) = varDate then
      vStr := FormatDateTime('yyyy-mm-dd', TDateTime(aStr))
    else
      vStr := string(aStr);
  except
    vStr := EmptyStr;
  end;
  Result := CopyStr(vStr, aIndex, aCount);
end;

function FillChr(aLen:Integer;aChar:AnsiChar):AnsiString;
var I :Integer;
begin
  Result := '';
  For I := 1 to aLen do
    Result := Result + aChar;
end;


function OpenQuery(var Query :TUniQuery; aSQL:AnsiString; aParam:Array of Variant):Integer;
var
   vIndex : Integer;
begin
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
        case VarType(aParam[StoI(GetOnlyNumber(Params[vIndex].Name))]) of
          varSmallint,
          varInteger,
          varByte     : Params[vIndex].AsInteger  := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
          varSingle,
          varDouble,
          varCurrency : Params[vIndex].AsCurrency := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
          varDate     : Params[vIndex].AsDateTime := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
          else  Params[vIndex].AsString   := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
        end;

    Open;
    Result := RecordCount;
  end;
end;

function OpenQuery(aSQL:AnsiString; aParam:Array of Variant):Integer;
var
   vIndex : Integer;
begin
  with Common.Query do
  begin
    Close;
    if aSQL <> EmptyStr then
    begin
      SQL.Clear;
      SQL.Text := aSQL;
    end;
    if Params.Count > 0 then
      for vIndex := 0 to Params.Count-1 do
        case VarType(aParam[StoI(GetOnlyNumber(Params[vIndex].Name))]) of
          varSmallint,
          varInteger,
          varByte     : Params[vIndex].AsInteger  := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
          varSingle,
          varDouble,
          varCurrency : Params[vIndex].AsCurrency := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
          varDate     : Params[vIndex].AsDateTime := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
          else  Params[vIndex].AsString   := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
        end;

    Open;
    Result := RecordCount;
  end;
end;

function ExecQuery(aSQL:AnsiString; aParam:array of Variant; aCommit:Boolean=false): Boolean;
var
   vIndex : Integer;
begin
  with Common.UniSQL do
  begin
    if aCommit then
      Common.BeginTran;
    try
      if aSQL <> EmptyStr then
      begin
        SQL.Clear;
        SQL.Text := aSQL;
      end;
      if Params.Count > 0 then
        for vIndex := 0 to Params.Count-1 do
          case VarType(aParam[StoI(GetOnlyNumber(Params[vIndex].Name))]) of
            varSmallint,
            varInteger,
            varByte     : Params[vIndex].AsInteger  := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
            varSingle,
            varDouble,
            varCurrency : Params[vIndex].AsCurrency := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
            varDate     : Params[vIndex].AsDateTime := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
            else          Params[vIndex].AsString   := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
          end;

      Execute;
      Result := true;
      if aCommit then
        Common.CommitTran;
    except
      on E: Exception do
      begin
        if aCommit then
          Common.RollBackTran;
        Common.ErrBox(E.Message);
        raise;
      end;
    end;
  end;
end;

function ExecProcedure(aSQL:AnsiString; aParam:array of Variant; aCommit:Boolean):Boolean;
var
   vIndex : Integer;
begin
  with Common.Query do
  begin
    if aCommit then
      Common.BeginTran;
    try
      if aSQL <> EmptyStr then
      begin
        SQL.Clear;
        SQL.Text := aSQL;
      end;
      if Params.Count > 0 then
        for vIndex := 0 to Params.Count-1 do
          case VarType(aParam[StoI(GetOnlyNumber(Params[vIndex].Name))]) of
            varSmallint,
            varInteger,
            varByte     : Params[vIndex].AsInteger  := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
            varSingle,
            varDouble,
            varCurrency : Params[vIndex].AsCurrency := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
            varDate     : Params[vIndex].AsDateTime := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
            else          Params[vIndex].AsString   := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
          end;

      Execute;
      Result := true;
      if aCommit then
        Common.CommitTran;
    except
      on E: Exception do
      begin
        if aCommit then
          Common.RollBackTran;
        Common.ErrBox(E.Message);
        raise;
      end;
    end;
  end;
end;


function IsDate(DStr: AnsiString): Boolean;
var
  vStrDate: AnsiString;
begin
  Result := False;
  vStrDate := GetOnlyNumber(DStr);
  if (Copy(vStrDate, 6, 2) = '00') and (Copy(vStrDate, 9, 2) = '00') then Exit;

  if Length(vStrDate) < 8 then Exit;

  try
    Insert('-', vStrDate, 5);
    Insert('-', vStrDate, 8);
    StrToDate(vStrDate);
    if POS(' ',vStrDate) > 0 then Exit;
    Result := True;
  except
    Exit;
  end;
end;

function IsTime(DStr: AnsiString): Boolean;
begin
  Result := False;
  if (GetOnlyNumber(LeftStr(DStr, 2)) <> LeftStr(DStr, 2)) or (LeftStr(DStr, 2) < '00') or (LeftStr(DStr, 2) > '23') then Exit;
  if (GetOnlyNumber(RightStr(DStr, 2)) <> RightStr(DStr, 2)) or (RightStr(DStr, 2) < '00') or (RightStr(DStr, 2) > '59') then Exit;

  if Length(DStr) <> 5 then Exit;

  Result := true;
end;

function DayToWeek(DStr:AnsiString):AnsiString;
const Week :Array[1..7] of AnsiString = ('(일)','(월)','(화)','(수)','(목)','(금)','(토)');
begin
   Insert('-', DStr, 5);
   Insert('-', DStr, 8);
   Result := Week[DayOfWeek(StrToDate(DStr))];
end;

function SetDateTime(Tmp:AnsiString):TDateTime;
begin
   Tmp := StringReplace(Tmp,'-','',[rfReplaceAll]);
   Tmp := StringReplace(Tmp,':','',[rfReplaceAll]);
   Result := StrToDateTime(FormatMaskText('!0000-90-90 00:00;0; ', Tmp));
end;

//원하는 자리에서 절사
function hTrunc(nNum : Extended; nDec:Integer) :Extended;
var
  cTemp : AnsiString;
  nPos  : Integer;
begin
  cTemp := floatToStr(nNum);

  nPos := pos('.', cTemp);
  if nPos > 0 then
  begin
    cTemp := copy(cTemp,1,nPos+nDec-1);
  end;
    Result := StrToFloat(cTemp);
end;

//소수점이하 반올림
function hRound(nNum : Extended) :Integer;
var
  cTemp : AnsiString;
  nPos  : Integer;
  nRound : Extended;
begin
  nRound := 5 / Power(10,1);
  if nNum < 0 then
		cTemp := floatToStr(nNum-nRound)
  else
    cTemp := floatToStr(nNum+nRound);

  nPos := pos('.', cTemp);
  if nPos > 0 then
  begin
    cTemp := copy(cTemp,1,nPos-1);
  end;
    Result := StrToInt(cTemp);
end;

function wyRound(nNum,nDcUnit : Integer) :Integer;
var
  nMod  : Integer;
  nMok  : Integer;
  nLen  : AnsiString;
  nTmp, nVal  : Currency;
  nStr  : AnsiString;
begin
  if nNum >= nDcUnit then
  begin
     if (nNum mod nDcUnit) <> 0 then
     begin
        nTmp  := 100 / nNum; //100/400 - 0.25
        nVal  := nTmp * StoF( RPad('1',Length(IntToStr(nDcUnit))-1,'0') ) ; //0.25 * 10 = 2.5
        nStr  := FtoS(nVal * nNum); //0.25 * 400 = 1000
        if (( StoI(Copy(nStr,1, POS('.',nStr)-1)) mod nDcUnit) <> 0 ) then
        begin
           nLen := Copy(nStr,1, POS('.',nStr)-1);
           nMok := StoI( RPad('1',Length(nLen)+1,'0') );
        end
        else if (POS('.',nStr) = 0) and ( StoI(nStr) mod nDcUnit <> 0) then
        begin
           nMok := StoI( RPad('1',Length(nStr)+1,'0') );
        end
        else nMok := Round( nVal * nNum );

        //나눌 몫이 할인금액보다 크면 한자리를 뺀다
        if nMok > nNum then nMok := StoI( Copy(IntToStr(nMok),1,Length(IntToStr(nMok))-1) );
        nMod := nNum mod nDcUnit;
        nMok := nMok - nMod;
        if nMod > nDcUnit then Result := nNum + nMok
        else                   Result := nNum - nMod;
     end
     else Result := nNum;
  end
  else
  begin
//    Common.MessageBox('할인금액이 할인단위금액보다 작습니다');
    Result := 0;
  end;
end;

//원하는 자리에서 반올림
function hRound(x: Extended; d: Integer): Extended;
  const
    t: array [0..12] of int64 = (1, 10, 100, 1000, 10000, 100000,
        1000000, 10000000, 100000000, 1000000000, 10000000000,
        100000000000, 1000000000000);
begin
  if Abs(d) > 12 then
    raise ERangeError.Create('RoundN: 자리 값 범위는 -12..12 사이여야 함');
  if d = 0 then
    Result := Int(x) + Int(Frac(x) * 2)
  else if d < 0 then begin
    x := x * t[abs(d)];
    Result := (Int(x) + Int(Frac(x) * 2)) / t[abs(d)];
  end else begin  // d > 0
    x := x / t[d];
    Result := (Int(x) + Int(Frac(x) * 2)) * t[d];
  end;
end;

procedure ActiveForm(sClass: AnsiString);
var I : Integer;
    H : THandle;
begin
   //이미 생성되어있는지 찾는다.

  for I := 0 to Screen.CustomFormCount - 1 do begin
     if UpperCase('T' + Screen.CustomForms[I].Name) = UpperCase(sClass) then
     begin
        H := Screen.CustomForms[I].Handle;
        Break;
     end;
  end;

  if H <> 0 then begin    //생성되어있으면 최상위 윈도우로 만든다.
    if IsIconic(H) then ShowWindow(H, SW_SHOWNORMAL)
    else                BringWindowToTop(H);
  end;
end;

function OpenComport(Com:AnsiString):Boolean;
  var
  PrinterCom : THandle;
  PrnComDCB  : TDCB;
begin
    Result := False;
    try
    PrinterCom := CreateFile(PChar(Com),
                             GENERIC_READ,
                             0,
                             nil,
                             OPEN_EXISTING,
                             FILE_FLAG_OVERLAPPED,
                             0);

    if PrinterCom =INVALID_HANDLE_VALUE then
    begin
      Application.MessageBox(PChar(Com+' 을 Open 할 수 없습니다.             ' +#13+#13+
                             '기타 주변장치 및 프린터와 연결된 Port를 확인하십시오.   '),
                             'WEBPOS',
                             MB_ICONERROR);
      Exit;
    end;
    GetCommState(PrinterCom, PrnComDCB);
    With PrnComDCB do
    begin
      BaudRate := 9600;
//      BaudRate := 38400;
      ByteSize := 8;
      Parity   := NoParity;
      StopBits := OneStopBit;
      Flags    := DTR_CONTROL_DISABLE or RTS_CONTROL_DISABLE;
    end;
      SetCommState(PrinterCom, PrnComDCB);
      Result := True;
  finally
    CloseHandle(PrinterCom);
  end;
end;

function ReverseStr(SourceStr :AnsiString):AnsiString;
  var
  StrPos  : integer;
  ConStr  : AnsiString;
begin
    StrPos:= 1;
    while StrPos <= Length(SourceStr) do
    begin
      if Ord(SourceStr[StrPos]) > 128 then
      begin
         ConStr := Copy(SourceStr,StrPos,2) + ConStr;
         StrPos := StrPos+2;
      end
      else
      begin
         ConStr := Copy(SourceStr,StrPos,1) + ConStr;
         StrPos := StrPos + 1;
      end;
    end;
    Result := DelSpace(ConStr);
end;

function  DelSpace(SourceStr:AnsiString):AnsiString;
  var
   i,j,StrLen : integer;
begin
   StrLen := Length(SourceStr);
   for i:= StrLen downto 1 do
   begin
     if Ord(SourceStr[i]) = 32 then Delete(SourceStr,i,1)
     else
     begin
       StrLen := Length(SourceStr);
       While True do
       begin
         if Ord(SourceStr[1]) = 32 then Delete(SourceStr,1,1)
         else break;
       end;
       break;
     end; // end of else
   end; // end of for
   Result := SourceStr;   
end;

function gf_ExecProcess(ProgramName: AnsiString): Longint;
var
 StartInfo  : TStartupInfo;
 ProcInfo   : TProcessInformation;
begin
  GetStartupInfo(StartInfo);
  if CreateProcess(nil, pChar(ProgramName), nil, nil, false, 0, nil, nil, StartInfo, ProcInfo) then
      Result := ProcInfo.hProcess
  else
      Result := 0;
end;

function GetDefaultPrinter: AnsiString;
var
  ResStr: array[0..255] of Char;
begin
  GetProfileString('Windows', 'device', '', ResStr, 255);
  Result := String(ResStr);
end;

function  SetTelephone(vStr :AnsiString):AnsiString;        //전화번호에 하이픈넣기
var vTemp :AnsiString;
begin
  vTemp := CtoC(vStr,'-','');

  case Length(vTemp) of
     7 : Result := FormatMaskText('!000-0000;0; ',vTemp);
     8 : Result := FormatMaskText('!0000-0000;0; ',vTemp);
     9 : Result := FormatMaskText('!00-000-0000;0; ',vTemp);
    10 :
       begin
         if Copy(vTemp,1,2) = '02' then
            Result := FormatMaskText('!00-0000-0000;0; ',vTemp)
         else
            Result := FormatMaskText('!000-000-0000;0; ',vTemp);
       end;
    11 : Result := FormatMaskText('!000-0000-0000;0; ',vTemp);
    12 : Result := FormatMaskText('!0000-0000-0000;0; ',vTemp);
    else Result := vStr;
  end;
end;

function  GetGenderName(aGender:AnsiString):AnsiString;
begin
  if aGender = '0' then
    Result := '남자(대인)'
  else if aGender = '1' then
    Result := '남자(소인)'
  else if aGender = '2' then
    Result := '여자(대인)'
  else if aGender = '3' then
    Result := '여자(소인)';
end;

function  GetLockerName(aGender, aSize:String):String;
begin
  if aGender = 'M' then
  begin
    if GetOption(57) = '1' then
      Result := '남자'
    else
    begin
      if aSize = 'B' then
        Result := '남자(대인)'
      else if aSize = 'S' then
        Result := '남자(소인)';
    end;
  end
  else if aGender = 'W' then
  begin
    if GetOption(57) = '1' then
      Result := '여자'
    else
    begin
      if aSize = 'B' then
        Result := '여자(대인)'
      else if aSize = 'S' then
        Result := '여자(소인)';
    end;
  end;
end;

function GetFreeMemoryMB: Integer;
var
  MemStatus: TMemoryStatusEx;
const
  MB = 1024 * 1024;
begin
  // 구조체 초기화 및 크기 설정
  FillChar(MemStatus, SizeOf(TMemoryStatusEx), 0);
  MemStatus.dwLength := SizeOf(TMemoryStatusEx);

  if GlobalMemoryStatusEx(MemStatus) then
  begin
    // ullAvailPhys: 사용 가능한 실제 물리 메모리 (Bytes)
    Result := Trunc(MemStatus.ullAvailPhys / MB);
  end
  else
    Result := -1; // 호출 실패 시
end;


function StringToHex(const S : AnsiString): AnsiString;
var
 x: integer;
begin
 for x := 1 to Length(s) do
  result := result + IntToHex(Integer(s[x]),2);
end;

// Hexadecimal로 구성된 문자열을 Byte 데이터로 변환
function HexToString(const aHex : AnsiString) : AnsiString;
  function TransChar(AChar: AnsiChar): Integer;
  begin
    if AChar in ['0'..'9'] then
    Result := Ord(AChar) - Ord('0')
    else
    Result := 10 + Ord(AChar) - Ord('A');
  end;
var
  I : Integer;
  CharValue: Word;
begin
  Result := '';
  for I := 1 to Trunc(Length(aHex)/2) do begin
    Result := Result + ' ';
    CharValue := TransChar(aHex[2*I-1])*16 + TransChar(aHex[2*I]);
    Result[I] := AnsiChar(CharValue);
  end;
end;

// 암호걸기
function Encrypt(const S: AnsiString; Key: Word): AnsiString;
var
  //I: byte;
  I: Integer;
  FirstResult : AnsiString;
  Tmp  :Int64;
begin
   SetLength(FirstResult, Length(S)); // 문자열의 크기를 설정
   for I := 1 to Length(S) do
   begin

     FirstResult[I] := Ansichar(byte(S[I]) xor (Key shr 8));
     Tmp :=  (byte(FirstResult[I]) + Key) * C1 + (C1 Div C2);
     Key :=  StrToInt(Copy(IntToStr(Tmp),2,4));
   end;
   Result := StringToHex(FirstResult);
end;

// 암호풀기
function Decrypt(const S: AnsiString; Key: Word): AnsiString;
var
  I: Integer;
  FirstResult : AnsiString;
  Tmp  :Int64;
begin
   FirstResult := HexToString(S);
   SetLength( Result, Length(FirstResult) );
   for I := 1 to Length(FirstResult) do
   begin
     Result[I] := Ansichar(byte(FirstResult[I]) xor (Key shr 8));
     Tmp :=  (byte(FirstResult[I]) + Key) * C1 + (C1 Div C2);
     Key :=  StrToInt(Copy(IntToStr(Tmp),2,4));
   end;
end;


function  GetOnlyNumber(const S : AnsiString; aSign:Boolean): AnsiString;        // 숫자만 골라낸다
var nCnt :Integer;
begin
   Result := EmptyStr;
   if aSign then
   begin
     For nCnt := 1 to Length(S) do
     begin
       case S[nCnt] of
          #45,#48..#57: Result := Result + S[nCnt];
       end;
     end;
   end
   else
   begin
     For nCnt := 1 to Length(S) do
     begin
       case S[nCnt] of
          #48..#57: Result := Result + S[nCnt];
       end;
     end;
   end;
end;

function  NVL(aValue,bValue:Variant):Variant;
begin
  if aValue = Null then Result := bValue
  else                  Result := aValue;
end;

function NullChange(const Input: string): string;
var
  OutputLen, Index: Integer;
  C: Char;
begin
  SetLength(Result, Length(Input));
  OutputLen := 0;
  for Index := 1 to Length(Input) do
  begin
    C := Input[Index];
    if C <> #0 then
    begin
      inc(OutputLen);
      Result[OutputLen] := C;
    end
    else
    begin
      inc(OutputLen);
      Result[OutputLen] := splitRecord;
    end;
  end;
  SetLength(Result, OutputLen);
end;


function GetFileVersion(aFileName:String; aFormat:Boolean=false):AnsiString;
var
  vBufferSize : DWORD;
  vReserved   : DWORD;
  pBuffer      : pChar;
  lpFixedInfo  : PVSFixedFileInfo;
  nLen         : UINT;
begin
  Result  := '';

  if aFileName = '' then
    aFileName := Application.ExeName;

  vBufferSize := GetFileVersionInfoSize(PChar(aFileName), vReserved);

  if vBufferSize > 0 then begin
    GetMem(pBuffer, vBufferSize);
    try
      if Assigned(pBuffer) then begin
        if not GetFileVersionInfo(PChar(aFileName), vReserved, vBufferSize, pBuffer) then Exit;
        if not VerQueryValue(pBuffer, '\', pointer(lpFixedInfo), nLen) then Exit;

        if (aFileName = Application.ExeName) or aFormat then
          Result := Format('%.04d.%.02d.%.02d.%d', [Word(lpFixedInfo.dwFileVersionMS shr    16),
                                                    Word(lpFixedInfo.dwFileVersionMS and $FFFF),
                                                    Word(lpFixedInfo.dwFileVersionLS shr    16),
                                                    Word(lpFixedInfo.dwFileVersionLS and $FFFF)])
        else
          Result  := IntToStr(Word(lpFixedInfo.dwFileVersionMS shr 16))
                     +'.'+ IntToStr(Word(lpFixedInfo.dwFileVersionMS and $FFFF))
                     +'.'+ IntToStr(Word(lpFixedInfo.dwFileVersionLS shr 16))
                     +'.'+ IntToStr(Word(lpFixedInfo.dwFileVersionLS and $FFFF));
      end;
    finally
      FreeMem(pBuffer);
    end;
  end;
end;

function CheckJumin(No:AnsiString):Boolean;
const
   Weight : Packed Array [1..12] of Integer =
          ( 2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5 );
var
  Loop, Sum, Rest : Integer;
begin
  if Length(No) <> 13 then Result:= False
  else
    try
      Sum:= 0;
      for Loop:= 1 to  12 do
        Sum:= Sum + StrToInt(No[Loop])*Weight[Loop];
        Rest:= 11-(Sum Mod 11);
        if Rest = 11 then Rest:= 1;
        if Rest = 10 then Rest:= 0;
        Result:= AnsiChar(Rest+48) = No[13];
    except
      Result:= False;
    end;
end;

function GetIPAddress: AnsiString;
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

function GetPosIP: String;
begin
  Result  := Common.GetIniFile('POS', 'POS_IP'  ,     '');
  if Result <> '' then Exit;
  Result := GetIPAddress;
end;

function Replace(aData, aSrc, aDst: AnsiString): AnsiString;
var
  vIndex: Integer;
  vData: AnsiString;
begin
  Result := EmptyStr;
  vData  := aData;
  vIndex := Pos(aSrc, vData);
  while vIndex > 0 do
  begin
    Result := Result + Copy(vData, 1, vIndex-1) + aDst;
    vData  := Copy(vData, vIndex + LengthB(aSrc), LengthB(vData));
    vIndex := Pos(aSrc, vData);
  end; // while Index > 0 do
  if LengthB(vData) > 0 then
    Result := Result + vData;
end;

function Replace(aData, aSrc, aDst: String): String;
var
  vIndex: Integer;
  vData: String;
begin
  Result := '';//StringReplace(vData,aSrc,aDst,[rfReplaceAll]);
  vData  := aData;
  vIndex := Pos(aSrc, vData);
  while vIndex > 0 do
  begin
    Result := Result + Copy(vData, 1, vIndex-1) + aDst;
    vData  := Copy(vData, vIndex + Length(aSrc), Length(vData));
    vIndex := Pos(aSrc, vData);
  end; // while Index > 0 do
  if Length(vData) > 0 then
    Result := Result + vData;
end;

// 주민등록번호 이상유무 검사
function  CheckBizNo(aNumber: AnsiString): Boolean;
var
  TempStr: AnsiString;
  Index, LastDigit: Integer;
begin
  Result := False;

  TempStr :=  StringReplace(aNumber,'-','',[rfReplaceAll]);

  // 길이가 0일 경우(입력 안한 경우)
  if Length(TempStr) <> 10 then Exit;
  // 체크디지트 구하기
  LastDigit := StrToInt(TempStr[Length(TempStr)]);

  Index := StrToInt(TempStr[9]) * 5;
  Index := (Index div 10) + (Index mod 10);
  Index := Index +
           StrToInt(TempStr[1]) + StrToInt(TempStr[4]) + StrToInt(TempStr[7]) +
          (StrToInt(TempStr[2]) + StrToInt(TempStr[5]) + StrToInt(TempStr[8])) * 3 +
          (StrToInt(TempStr[3]) + StrToInt(TempStr[6])) * 7;
  Index := 10 - (Index mod 10);

  Result := (Index = LastDigit);
end;


//==============================================================================
// 레지스트리
//------------------------------------------------------------------------------
// 레지스트리 값 저장
function SetRegistry(aRootKey: HKEY; aKey, aValue:String; aData: Variant): Boolean;
begin
  Result := False;
  with TRegistry.Create do
    try
      RootKey := aRootKey;
      if OpenKey(aKey, True) then
      begin
        case VarType(aData) of
          varString,
          varUString  : WriteString(aValue,aData);
          varInteger,
          varByte     :  WriteInteger(aValue,aData);
        end;
        Result := True;
      end;
    finally
      Free;
    end;
end;
function SetRegistryBin(aRootKey: HKEY; aKey, aValue, aData: string): Boolean;
var vBuffer :String;
    vBufSize :Integer;
begin
  Result := False;
  with TRegistry.Create do
    try
      RootKey := aRootKey;
      if OpenKey(aKey, True) then
      begin
        vBuffer := aData;
        WriteBinaryData(aValue, vBuffer[1], Length(vBuffer));
        Result := True;
      end;
    finally
      Free;
    end;
end;


//------------------------------------------------------------------------------
// 레지스트리 값 읽기
function GetRegistry(aRootKey: HKEY; aKey, aValue, aDefault: string): Variant;
  function StrToHex(const aValue: string): string;
  var
    vIndex: Integer;
  const
    vHexaChar: array [0..15] of Char = ('0','1','2','3','4','5','6','7','8', '9','A','B','C','D','E','F');
  begin
    SetLength(Result, Length(aValue)*2);
    for vIndex := 0 to Length(aValue)-1 do
    begin
      Result[(vIndex*2)+1] := vHexaChar[Integer(aValue[vIndex+1]) shr   4];
      Result[(vIndex*2)+2] := vHexaChar[Integer(aValue[vIndex+1]) and $0F];
    end;
  end;
var vBuffer   : String;
    vBufSize :Integer;
begin
  Result := aDefault;
  with TRegistry.Create do
    try
      RootKey := aRootKey;
      if KeyExists(aKey) and OpenKey(aKey, False) and ValueExists(aValue) then
        try
          if GetDataType(aValue) = rdBinary then
          begin
            vBufSize := GetDataSize(aValue);

            Setlength(vBuffer, vBufSize);
            ReadBinaryData(aValue, vBuffer[1], vBufSize);
            Result := StrToHex(vBuffer);
          end
          else if GetDataType(aValue) = rdInteger then
            Result := ReadInteger(aValue)
          else if GetDataType(aValue) = rdString then
            Result := ReadString(aValue);
        except
        end;
    finally
      Free;
    end;
end;

{******************************************************************************}
{                                Registry Create                               }
{******************************************************************************}
function CreateRegistry(ARootKey : HKEY; aKey, aValue : AnsiString; SetData : Variant): Boolean;
var
  Registry: TRegistry;
begin
  Result := False;
  Registry := TRegistry.Create;
  try
    Registry.RootKey := ARootKey;
    Registry.CreateKey(aKey+'\');
    if Registry.OpenKey(aKey,True) then
    begin
      case VarType(SetData) of
        varString,
        varUString  : Registry.WriteString(aValue,SetData);
        else  Registry.WriteInteger(aValue,SetData);
      end;
      Result := True;
    end;
  finally
    Registry.Free;
  end;
end;

function  DeleteRegistry(aRootKey : HKEY; aKey, aValue:AnsiString):Boolean;
begin
  Result := False;
  with TRegistry.Create do
    try
      RootKey := aRootKey;
      if OpenKey(aKey, False)then
      begin
        DeleteValue(aValue);
        CloseKey;
      end;
        Result := True;
    finally
      Free;
    end;
end;


function GetOption(aIndex: Integer; aDefaultValue: Char = '0'): Char;
begin
  if Length(Common.Config.Options) >= aIndex then
  begin
    Result := Common.Config.Options[aIndex];
  end
  else
    Result := aDefaultValue;
end;

function GetHeadOption(aIndex: Integer; aDefaultValue: Char = '0'): Char;
begin
  if Length(Common.Config.HeadOptions) >= aIndex then
  begin
    Result := Common.Config.HeadOptions[aIndex];
  end
  else
    Result := aDefaultValue;
end;

function GetUserOption(aIndex: Integer; aDefaultValue: Char = '0'): Char;
begin
  if Length(Common.Config.UserWork) >= aIndex then
  begin
    Result := Common.Config.UserWork[aIndex];
  end
  else
    Result := aDefaultValue;
end;

procedure ExcuteProgram(aFileName,aParam:String);
  function AddFolderBackSlash(aFolderName: AnsiString): String;
  begin
    if (aFolderName <> EmptyStr) and (aFolderName[Length(aFolderName)] <> '\') then
      aFolderName := aFolderName + '\';
    Result := aFolderName;
  end;
var
  vShellExecuteInfo: TShellExecuteInfo;
  vProcessHandle   : DWORD;
begin
  if (Pos(':',aFileName) = 0) and (Pos('\',aFileName) = 0) then
    aFileName := AddFolderBackSlash(ExtractFileDir(Application.ExeName))+aFileName;
  FillChar(vShellExecuteInfo, Sizeof(vShellExecuteInfo), 0);
  with vShellExecuteInfo do
  begin
    cbSize       := Sizeof(vShellExecuteInfo);
    fMask        := SEE_MASK_NOCLOSEPROCESS or SEE_MASK_FLAG_DDEWAIT;
    wnd          := GetActiveWindow;
    lpVerb       := 'open';
    lpFile       := PChar(aFileName);
    lpParameters := PChar(aParam);
    nShow        := SW_HIDE;
  end;
  if not FileExists(aFileName) then Exit;
  // 프로그램을 실행한다
  if ShellExecuteEx(@vShellExecuteInfo) then
    vProcessHandle := vShellExecuteInfo.hProcess
  else
    Exit;
end;

function  StringToColorDef(aValue:AnsiString; aColor:TColor):TColor;
begin
  try
    if IsDebuggerPresent and (Length(aValue) < 8) then
      Result := aColor
    else
    begin
      if (aValue = '') then
        Result := aColor
      else
        Result := StringToColor(aValue);
    end;
  except
    Result := aColor;
  end;
end;

function Ping : boolean;
var
 vTemp :AnsiString;
 vCheckTime :TDateTime;
 vResult    :String;
 vOutFile   :TStringList;
 vIndex     :Integer;
begin
  result := false;
  vTemp := Common.GetIniFile('POS','PING FAIL','');
  if vTemp <> '' then
  begin
    vCheckTime := StrToDateTime(vTemp);
    if SecondsBetween( Now(), vCheckTime ) < 300 then
      Exit;
  end;

  vTemp := Common.GetIniFile('POS','PING CHECK','');
  if vTemp <> '' then
  begin
    vCheckTime := StrToDateTime(vTemp);
    if SecondsBetween( Now(), vCheckTime ) < 300 then
    begin
      Result := true;
      Exit;
    end;
  end;


  GetDosOutput(Format('ping www.expos.co.kr > %sTemp.txt',[Common.AppPath]),'');
  if FileExists(Format('%sTemp.txt',[Common.AppPath])) then
  try
    vOutFile := TStringList.Create;
    vOutFile.LoadFromFile(Format('%sTemp.txt',[Common.AppPath]));
    for vIndex := 0 to vOutFile.Count-1 do
    begin
      if Pos('TTL=',vOutFile.Strings[vIndex]) > 0 then
      begin
        Result := true;
        Break;
      end;
    end;
  finally
    vOutFile.Free;
    DeleteFile(Format('%sTemp.txt',[Common.AppPath]));
  end;

  if not Result then
  begin
    Common.SetIniFile('POS','PING FAIL', FormatDateTime('yyyy-mm-dd hh:nn:ss',now()));
    Common.SetIniFile('POS','PING CHECK','');
  end
  else
  begin
    Common.SetIniFile('POS','PING FAIL','');
    Common.SetIniFile('POS','PING CHECK', FormatDateTime('yyyy-mm-dd hh:nn:ss',now()));
  end;
end;

procedure Split(const aStr: String; aSplitChar: Char; var aList: TStringList);
begin
  aList.Clear;
  aList.Delimiter       := aSplitChar;
  aList.StrictDelimiter := True;
  aList.DelimitedText   := aStr;
end;

function LineFeed(aText:String;aType:Integer):String;
begin
  if Pos('|',aText) > 0 then
    Result := Replace(aText, '|', #13#10)
  else
    Result := Replace(aText, #$D, #13#10);
end;

function GetDosOutput(aCommandLine: String; aWorkPath: String; aWait:Boolean): String;
var
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  Buffer: array[0..255] of Char;
  BytesRead: Cardinal;
  WorkDir: string;
  Handle: Boolean;
  SystemPath : String;
begin
  SetLength(SystemPath, 256);
  GetSystemDirectory(PChar(SystemPath), 256);
  if aWorkPath = '' then
    WorkDir := SystemPath
  else
    WorkDir := aWorkPath;

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

    if aWait and Handle then
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

function GetStrPointerIndex(aComboBox: TcxComboBox; aValue: string): Integer;
var
  vIndex: Integer;
begin
  Result := -1;
  for vIndex := 0 to aComboBox.Properties.Items.Count-1 do
    if PStrPointer(aComboBox.Properties.Items.Objects[vIndex]).Data = aValue then
    begin
      Result := vIndex;
      Break;
    end;
end;

function  GetStrPointerData(aComBoBox:TcxComboBox):String;
begin
  if aComBoBox.ItemIndex >= 0 then
    result := PStrPointer(aComBoBox.Properties.Items.Objects[aComBoBox.ItemIndex]).Data
  else
    result := EmptyStr;
end;

//16진수를 2진수로
function HexToBin2(aHex: string): string;
const
  BCD: array [0..15] of string =
    ('0000', '0001', '0010', '0011', '0100', '0101', '0110', '0111',
    '1000', '1001', '1010', '1011', '1100', '1101', '1110', '1111');
var
  i: integer;
begin
  for i := Length(aHex) downto 1 do
    Result := BCD[StrToInt('$' + aHex[i])] + Result;
end;

function  StrToBin(aData:String):String;
var vSource,
    vResult :String;
begin
  vSource := StringToHex(aData);
  SetLength(vResult, Length(vSource) div 4);
  HexToBin(PWideChar(vSource), vResult[1], Length(vSource) div SizeOf(Char));
  Result := vResult;
end;

function  BinToStr(aData:String):String;
var vSource,
    vResult :String;
begin
  SetLength(vResult, Length(aData) * 4);
  BinToHex(aData[1], PWideChar(vResult), Length(aData) * SizeOf(Char));
  Result := HexToString(vResult);
end;


function GetBarcode(aCode: string): string;
  function UpcE2UpcA(aCode: string): string;
  begin
    if Length(aCode) = 7 then
      aCode := Copy(aCode, 1, 6)
    else if Length(aCode) = 8 then
      aCode := Copy(aCode, 2, 6);
    case aCode[6] of
      '0','1','2':
        Result := '0' + Copy(aCode, 1, 2) + aCode[6] + '0000' + Copy(aCode, 3, 3) + '0';
      '3':
        Result := '0' + Copy(aCode, 1, 3) + '00000' + Copy(aCode, 4, 2) + '0';
      '4':
        Result := '0' + Copy(aCode, 1, 4) + '00000' + aCode[5] + '0';
      else
        Result := '0' + Copy(aCode, 1, 5) + '0000' + aCode[6] + '0';
    end;
  end;
var
  vOdd, vEven: Integer;
  vUPCE: string;
begin
  // 바코드에 문자가 포함되어 있는지 확인
  aCode := GetOnlyNumber(aCode);

  // UPC-E 코드면 UPC-A로 바꿔서 체크디지트를 구한다
  if (Length(aCode) = 6) or (Length(aCode) = 7) or ((Length(aCode) = 8) and (aCode[1] = '0')) then
  begin
    vUPCE := aCode;
    aCode := UpcE2UpcA(aCode);
  end
  else
    vUPCE := EmptyStr;

  // 바코드 체크디지트 계산
  case Length(aCode) of
     8 : begin // EAN-8
           vOdd   := StrToInt(aCode[1])+StrToInt(aCode[3])+StrToInt(aCode[5])+StrToInt(aCode[7]);
           vEven  := StrToInt(aCode[2])+StrToInt(aCode[4])+StrToInt(aCode[6]);
           Result := Copy(aCode,1,7) + IntToStr((10 - ((vOdd*3 + vEven) mod 10)) mod 10);
         end;
    12 : begin // UPC-A
           vOdd   := StrToInt(aCode[1])+StrToInt(aCode[3])+StrToInt(aCode[5])+StrToInt(aCode[7])+StrToInt(aCode[ 9])+StrToInt(aCode[11]);
           vEven  := StrToInt(aCode[2])+StrToInt(aCode[4])+StrToInt(aCode[6])+StrToInt(aCode[8])+StrToInt(aCode[10]);
           Result := Copy(aCode,1,11) + IntToStr((10 - ((vOdd*3 + vEven) mod 10)) mod 10);
         end;
    13 : begin // EAN-13
           vOdd   := StrToInt(aCode[1])+StrToInt(aCode[3])+StrToInt(aCode[5])+StrToInt(aCode[7])+StrToInt(aCode[ 9])+StrToInt(aCode[11]);
           vEven  := StrToInt(aCode[2])+StrToInt(aCode[4])+StrToInt(aCode[6])+StrToInt(aCode[8])+StrToInt(aCode[10])+StrToInt(aCode[12]);
           Result := Copy(aCode,1,12) + IntToStr((10 - ((vOdd + vEven*3) mod 10)) mod 10);
         end;
    14 : begin // EAN-14, ITF-14 (Box)
           vOdd   := StrToInt(aCode[1])+StrToInt(aCode[3])+StrToInt(aCode[5])+StrToInt(aCode[7])+StrToInt(aCode[ 9])+StrToInt(aCode[11])+StrToInt(aCode[13]);
           vEven  := StrToInt(aCode[2])+StrToInt(aCode[4])+StrToInt(aCode[6])+StrToInt(aCode[8])+StrToInt(aCode[10])+StrToInt(aCode[12]);
           Result := Copy(aCode,1,13) + IntToStr((10 - ((vOdd*3 + vEven) mod 10)) mod 10);
         end;
    else       // 기타 (UPC-E는 체크디지트 계산이 되지 않는다)
         Result := aCode;
  end;
end;

function GetTicketNo(aTicketNo:String):String;
var vOdd, vEven: Integer;
begin
  Result := EmptyStr;

  if Length(aTicketNo) = 17 then
  begin
    vOdd   := StrToInt(aTicketNo[1])+StrToInt(aTicketNo[3])+StrToInt(aTicketNo[5])+StrToInt(aTicketNo[7])+StrToInt(aTicketNo[ 9])+StrToInt(aTicketNo[11])+StrToInt(aTicketNo[13])+StrToInt(aTicketNo[15])+StrToInt(aTicketNo[17]);
    vEven  := StrToInt(aTicketNo[2])+StrToInt(aTicketNo[4])+StrToInt(aTicketNo[6])+StrToInt(aTicketNo[8])+StrToInt(aTicketNo[10])+StrToInt(aTicketNo[12])+StrToInt(aTicketNo[14])+StrToInt(aTicketNo[16]);
    Result := Copy(aTicketNo,1,17) + IntToStr((10 - ((vOdd*3 + vEven) mod 10)) mod 10);
  end
  else
    Result := aTicketNo;
end;

function OpenQuery(var Query :TUniQuery; aSQL:string; aParam:Array of Variant):Integer;
var
   vIndex, vErrorCount : Integer;
   label retry;
begin
  if not DM.ConnectDB then Exit;
  vErrorCount := 0;
retry:
  try
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
          case VarType(aParam[StoI(GetOnlyNumber(Params[vIndex].Name))]) of
            varSmallint,
            varInteger,
            varByte     : Params[vIndex].AsInteger  := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
            varSingle,
            varDouble,
            varCurrency : Params[vIndex].AsCurrency := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
            varDate     : Params[vIndex].AsDateTime := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
            else  Params[vIndex].AsString   := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
          end;

      Open;
      Result := RecordCount;
      vErrorCount := 0;
    end;
  except
    on E: Exception do
    begin
      if Pos('Lost connection', E.Message) > 0 then
      begin
        DM.UniConnection.Disconnect;
        DM.UniConnection.Connect;
        Inc(vErrorCount);
      end;
    end;
  end;
  if vErrorCount = 1 then
    goto retry;
end;

function OpenQuery(aSQL:string; aParam:Array of Variant):Integer;
var
   vIndex, vErrorCount : Integer;
   label retry;
begin
  if not DM.ConnectDB then Exit;
  vErrorCount := 0;
retry:
  try
    with Common.Query do
    begin
      Close;
      if aSQL <> EmptyStr then
      begin
        SQL.Clear;
        SQL.Text := aSQL;
      end;
      if Params.Count > 0 then
        for vIndex := 0 to Params.Count-1 do
          case VarType(aParam[StoI(GetOnlyNumber(Params[vIndex].Name))]) of
            varSmallint,
            varInteger,
            varByte     : Params[vIndex].AsInteger  := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
            varSingle,
            varDouble,
            varCurrency : Params[vIndex].AsCurrency := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
            varDate     : Params[vIndex].AsDateTime := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
            else  Params[vIndex].AsString   := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
          end;

      Open;
      Result := RecordCount;
      vErrorCount := 0;
    end;
  except
    on E: Exception do
    begin
      if Pos('Lost connection', E.Message) > 0 then
      begin
        DM.UniConnection.Disconnect;
        DM.UniConnection.Connect;
        Inc(vErrorCount);
      end;
    end;
  end;
  if vErrorCount = 1 then
    goto retry;
end;

function ExecQuery(var Query :TUniQuery; aSQL:string; aParam:array of Variant): Boolean;
var
   vIndex, vErrorCount : Integer;
   label retry;
begin
  if not DM.ConnectDB then Exit;
  vErrorCount := 0;
retry:
  try
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
          case VarType(aParam[StoI(GetOnlyNumber(Params[vIndex].Name))]) of
            varSmallint,
            varInteger,
            varByte     : Params[vIndex].AsInteger  := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
            varSingle,
            varDouble,
            varCurrency : Params[vIndex].AsCurrency := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
            varDate     : Params[vIndex].AsDateTime := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
            else          Params[vIndex].AsString   := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
          end;

      Execute;
      Result := true;
      vErrorCount := 0;
    end;
  except
    on E: Exception do
    begin
      if Pos('Lost connection', E.Message) > 0 then
      begin
        DM.UniConnection.Disconnect;
        DM.UniConnection.Connect;
        Inc(vErrorCount);
      end;
    end;
  end;
  if vErrorCount = 1 then
    goto retry;
end;

function ExecQuery(aSQL:string; aParam:array of Variant): Boolean;
var
   vIndex, vErrorCount : Integer;
   label retry;
begin
  if not DM.ConnectDB then Exit;
  vErrorCount := 0;
retry:
  try
    with Common.UniSQL do
    begin
      if aSQL <> EmptyStr then
      begin
        SQL.Clear;
        SQL.Text := aSQL;
      end;
      if Params.Count > 0 then
        for vIndex := 0 to Params.Count-1 do
          case VarType(aParam[StoI(GetOnlyNumber(Params[vIndex].Name))]) of
            varSmallint,
            varInteger,
            varByte     : Params[vIndex].AsInteger  := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
            varSingle,
            varDouble,
            varCurrency : Params[vIndex].AsCurrency := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
            varDate     : Params[vIndex].AsDateTime := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
            else          Params[vIndex].AsString   := aParam[StoI(GetOnlyNumber(Params[vIndex].Name))];
          end;

      Execute;
      Result := true;
      vErrorCount := 0;
    end;
  except
    on E: Exception do
    begin
      if Pos('Lost connection', E.Message) > 0 then
      begin
        DM.UniConnection.Disconnect;
        DM.UniConnection.Connect;
        Inc(vErrorCount);
      end;
    end;
  end;
  if vErrorCount = 1 then
    goto retry;
end;

function  ExecQueryEx(aSQL:string; aParam:array of Variant; aExecute:Boolean=false): Boolean;
  function  SetParam(aSQL: string; aParam: array of Variant): String;
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
        varDate     : vSQL := Replace(vSQL, Format(':P%d',[vIndex]), Format('Cast(''%s'' as DateTime )',[FormatDateTime('yyyy-mm-dd hh:nn:ss',aParam[vIndex])]));
        else
        begin
          vTemp := Replace(NVL(aParam[vIndex],''),'''','＇');
          vTemp := Replace(vTemp, ';','');
          vSQL  := Replace(vSQL, Format(':P%d',[vIndex]), Format('''%s''',[vTemp]));
        end;
      end;
    end;
    Result := vSQL;
  end;
var vIndex, vErrorCount :Integer;
    vResult,
    vSQL :String;
    label retry;
begin
  Result := false;
  if High(aParam) >= 0 then
    vSQL := SetParam(aSQL, aParam)
  else
    vSQL := aSQL;
  Common.SQLBuffer := Common.SQLBuffer + vSQL;

  if not aExecute then
    Exit;

  vErrorCount := 0;
retry:
  try
    DM.StoredProc.StoredProcName := 'MULTI_EXECUTE';
    DM.StoredProc.PrepareSQL;
    DM.StoredProc.ParamByName('_SQL').AsString := Common.SQLBuffer;
    DM.StoredProc.ExecProc;
    vResult := DM.StoredProc.ParamByName('_RESULT').Value;
    if vResult <> 'OK' then
    begin
      Common.SQLBuffer := '';
      Common.ErrBox(vResult);
      Exit;
    end;
    Result := true;
    Common.SQLBuffer := '';
    vErrorCount := 0;
  except
    on E: Exception do
    begin
      if Pos('Lost connection', E.Message) > 0 then
      begin
        DM.UniConnection.Disconnect;
        DM.UniConnection.Connect;
        Inc(vErrorCount);
      end;
    end;
  end;
  if vErrorCount = 1 then
    goto retry;
end;

function IsMobileNumber(aValue:String):Boolean;
begin
  if (LeftStr(aValue,3) = '010') and (Length(aValue)=11) then
    Result := True
  else
    Result := False;
end;

function StrPas(const Str: PAnsiChar): AnsiString;
begin
  Result := Str;
end;

//------------------------------------------------------------------------------
// 랜카드 MAC 어드래스 구하기
function GetMacAddress: Ansistring;
  function GetMacAddress2: string;
  var
    vNCB          : PNCB;
    vAdapterStatus: PAdapterStatus;
    vReturnCode   : AnsiChar;
    vIndex        : Integer;
    vLen          : PlanaEnum;
    vSystemID     : string;
  begin
    Result    := '';
    vSystemID := '';
    GetMem(vNCB, SizeOf(TNCB));
    FillChar(vNCB^, SizeOf(TNCB), 0);
    GetMem(vLen, SizeOf(TLanaEnum));
    FillChar(vLen^, SizeOf(TLanaEnum), 0);
    GetMem(vAdapterStatus, SizeOf(TAdapterStatus));
    FillChar(vAdapterStatus^, SizeOf(TAdapterStatus), 0);
    vLen.Length      := Chr(0);
    vNCB.ncb_command := Chr(NCBEnum);
    vNCB.ncb_buffer  := Pointer(vLen);
    vNCB.ncb_length  := SizeOf(vLen);
    vIndex           := 0;
    repeat
      FillChar(vNCB^, SizeOf(TNCB), 0);
      vNCB.ncb_command  := Chr(NCBReset);
      vNCB.ncb_lana_num := vLen.lana[vIndex];
      FillChar(vNCB^, SizeOf(TNCB), 0);
      vNCB.ncb_command  := Chr(NCBAstat);
      vNCB.ncb_lana_num := vLen.lana[vIndex];
      vNCB.ncb_callname := '* ';
      vNCB.ncb_buffer   := Pointer(vAdapterStatus);
      vNCB.ncb_length   := SizeOf(TAdapterStatus);
      vReturnCode       := Netbios(vNCB);
      if (vReturnCode = Chr(0)) or (vReturnCode = Chr(6)) then
        vSystemID := IntToHex(Ord(vAdapterStatus.adapter_address[0]),2)+'-'+
                     IntToHex(Ord(vAdapterStatus.adapter_address[1]),2)+'-'+
                     IntToHex(Ord(vAdapterStatus.adapter_address[2]),2)+'-'+
                     IntToHex(Ord(vAdapterStatus.adapter_address[3]),2)+'-'+
                     IntToHex(Ord(vAdapterStatus.adapter_address[4]),2)+'-'+
                     IntToHex(Ord(vAdapterStatus.adapter_address[5]),2);
      Inc(vIndex);
    until (vIndex >= Ord(vLen.length)) or (vSystemID <> '00-00-00-00-00-00');
    FreeMem(vNCB);
    FreeMem(vAdapterStatus);
    FreeMem(vLen);
    Result := vSystemID;
  end;
var
  vBindObj : IDispatch;
  vNetAdapters,
  vWMIService : OleVariant;
  vIndex, vValue : LongWord;
  vEnumVar : IEnumvariant;
  vBindCtx : IBindCtx;
  vMoniker : IMoniker;
  vFileObj : WideString;
begin
  Result   := EmptyStr;
  try
    vFileObj := 'winmgmts:\\.\root\cimv2';
    OleCheck(CreateBindCtx(0, vBindCtx));
    OleCheck(MkParseDisplayNameEx(vBindCtx, PWideChar(vFileObj), vIndex, vMoniker));
    OleCheck(vMoniker.BindToObject(vBindCtx, nil, IUnknown, vBindObj));
    vWMIService  := vBindObj;
    vNetAdapters := vWMIService.ExecQuery('select * from Win32_NetworkAdapterConfiguration where IPEnabled = True');
    vEnumVar     := IUnknown(vNetAdapters._NewEnum) as IEnumVariant;
    while vEnumVar.Next(1, vNetAdapters, vValue) = 0 do
      if not VarIsNull(vNetAdapters.MACAddress) then
      begin
        Result := Replace(vNetAdapters.MACAddress, ':', '-');
        Break;
      end;
    vNetAdapters := Unassigned;
    vWMIService  := Unassigned;
  except
  end;
  if Result = EmptyStr then
    Result := GetMacAddress2;
end;

//------------------------------------------------------------------------------
// 시리얼 넘버 구하기
function GetSerialNo: string;
  // HDD 정보 구하기
  function GetIDEDiskInfo(var aModelNumber, aSerialNumber, aFirmware: string ): Integer;
  type
    TSrbIoControl = packed record
      HeaderLength: Cardinal;
      Signature   : array[0..7] of Char;
      Timeout     : Cardinal;
      ControlCode : Cardinal;
      ReturnCode  : Cardinal;
      Length      : Cardinal;
    end;

    TIDERegs = packed record
      bFeaturesReg    : Byte;
      bSectorCountReg : Byte;
      bSectorNumberReg: Byte;
      bCylLowReg      : Byte;
      bCylHighReg     : Byte;
      bDriveHeadReg   : Byte;
      bCommandReg     : Byte;
      bReserved       : Byte;
    end;

    TSendCmdInParams = packed record
      cBufferSize : DWord;
      irDriveRegs : TIDERegs;
      bDriveNumber: Byte;
      bReserved   : array[0..2] of Byte;
      dwReserved  : array[0..3] of DWord;
      bBuffer     : array[0..0] of Byte;
    end;
    PSendCmdInParams = ^TSendCmdInParams;

    TIdSector = packed record
      wGenConfig                : Word;
      wNumCyls                  : Word;
      wReserved                 : Word;
      wNumHeads                 : Word;
      wBytesPerTrack            : Word;
      wBytesPerSector           : Word;
      wSectorsPerTrack          : Word;
      wVendorUnique             : array[0.. 2] of Word;
      sSerialNumber             : array[0..19] of Char;
      wBufferType               : Word;
      wBufferSize               : Word;
      wECCSize                  : Word;
      sFirmwareRev              : array[0.. 7] of Char;
      sModelNumber              : array[0..39] of Char;
      wMoreVendorUnique         : Word;
      wDoubleWordIO             : Word;
      wCapabilities             : Word;
      wReserved1                : Word;
      wPIOTiming                : Word;
      wDMATiming                : Word;
      wBS                       : Word;
      wNumCurrentCyls           : Word;
      wNumCurrentHeads          : Word;
      wNumCurrentSectorsPerTrack: Word;
      ulCurrentSectorCapacity   : Cardinal;
      wMultSectorStuff          : Word;
      ulTotalAddressableSectors : Cardinal;
      wSingleWordDMA            : Word;
      wMultiWordDMA             : Word;
      bReserved                 : array[0..127] of Byte;
    end;
    PIdSector = ^TIdSector;

  const
    DataSize   = SizeOf(TSendCmdInParams)-1+512;
    BufferSize = SizeOf(TSrbIoControl)+DataSize;

  var
    vDisk         : THandle;
    vInData       : PSendCmdInParams;
    vOutData      : Pointer;
    vBytesReturned: DWord;
    vBuffer       : array[ 0..BufferSize-1 ] of Byte;
    vSrbIoControl : TSrbIoControl absolute vBuffer;

    procedure ChangeByte(var aData; aSize: Integer);
    var
      vP: PChar;
      vI: Integer;
      vC: Char;
    begin
      vP := @aData;
      for vI := 0 to (aSize shr 1)-1 do
      begin
        vC      := vP^;
        vP^     := (vP+1)^;
        (vP+1)^ := vC;
        Inc(vP, 2);
      end;
    end;

    function GetStringValue(var aData; aSize: Integer): string;
    type
      TCharArray = array[0..0] of Char;
    var
      vIndex: Integer;
    begin
      ChangeByte(aData, aSize);
      SetString(Result, TCharArray(aData), aSize);
      if Length(Result) > 0 then
        for vIndex := Length(Result) downto 1 do
          if Result[ vIndex ] <= ' ' then
            Delete(Result, vIndex, 1)
          else
            Break;
      if Length(Result) > 0 then
        for vIndex := 1 to Length(Result) do
          if Result[ 1 ] <= ' ' then
            Delete(Result, 1, 1)
          else
            Break;
    end;

    procedure GetIDEDiskInfoNT;
    begin
      vDisk := CreateFile('\\.\Scsi0:', GENERIC_READ or GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
      if vDisk = INVALID_HANDLE_VALUE then
        Exit;
      try
        vSrbIoControl.HeaderLength := SizeOf(TSrbIoControl);
        Move('SCSIDISK', vSrbIoControl.Signature, 8);
        vSrbIoControl.Timeout     := 2;
        vSrbIoControl.Length      := DataSize;
        vSrbIoControl.ControlCode := $1B0501;
        vInData                   := PSendCmdInParams(PChar(@vBuffer) + SizeOf(TSrbIoControl));
        vOutData                  := vInData;
        with vInData^ do
        begin
          cBufferSize  := 512;
          bDriveNumber := 0;
          with irDriveRegs do
          begin
            bFeaturesReg     := 0;
            bSectorCountReg  := 1;
            bSectorNumberReg := 1;
            bCylLowReg       := 0;
            bCylHighReg      := 0;
            bDriveHeadReg    := $A0;
            bCommandReg      := $EC;
          end;
        end;
        if not DeviceIoControl(vDisk, $4D008, @vBuffer, BufferSize, @vBuffer, BufferSize, vBytesReturned, nil) then
          Exit;
      finally
        CloseHandle(vDisk);
      end;
    end;

    procedure GetIDEDiskInfo9x;
    begin
      vDisk := CreateFile('\\.\SMARTVSD', 0, 0, nil, CREATE_NEW, 0, 0);
      if vDisk = INVALID_HANDLE_VALUE then
        Exit;
      try
        vInData  := PSendCmdInParams(@vBuffer);
        vOutData := PChar(@vInData^.bBuffer);
        with vInData^ do
        begin
          cBufferSize  := 512;
          bDriveNumber := 0;
          with irDriveRegs do
          begin
            bFeaturesReg     := 0;
            bSectorCountReg  := 1;
            bSectorNumberReg := 1;
            bCylLowReg       := 0;
            bCylHighReg      := 0;
            bDriveHeadReg    := $A0;
            bCommandReg      := $EC;
          end;
        end;
        if not DeviceIoControl(vDisk, $7C088, vInData, SizeOf( TSendCmdInParams ) - 1, vOutData, 528, vBytesReturned, nil) then
          Exit;
      finally
        CloseHandle( vDisk );
      end;
    end;
  begin
    Result := -1;
    FillChar(vBuffer, BufferSize, 0);

    case Win32Platform of
      VER_PLATFORM_WIN32_NT : GetIDEDiskInfoNT;
      else                    GetIDEDiskInfo9x;
    end;

    with PIdSector(PChar(vOutData)+16)^ do
    begin
      aModelNumber  := GetStringValue(sModelNumber,  SizeOf(sModelNumber ));
      aSerialNumber := GetStringValue(sSerialNumber, SizeOf(sSerialNumber));
      aFirmware     := GetStringValue(sFirmwareRev,  SizeOf(sFirmwareRev ))
    end;
    if aModelNumber = EmptyStr then
      Result := GetLastError;
  end;
const
  SEQ = 'EXTREMEPOS';
var
  vModelNumber, vSerialNumber, vFirmware, vH, vM: string;
  vReturn, vIndex:Integer;
begin
  Result := EmptyStr;
  vM     := Replace(GetMacAddress, '-', EmptyStr);
  if vM = EmptyStr then
    Exit;
  vReturn := GetIDEDiskInfo(vModelNumber, vSerialNumber, vFirmware);
  if vReturn = -1 then
  begin
    vSerialNumber := Replace(vSerialNumber, ' ', EmptyStr);
    // 하드시리얼번호가 12자리 이하이면
    if Length(vSerialNumber) < 12 then
      for vIndex := 1 to 12-Length(vSerialNumber) do
        vSerialNumber := vSerialNumber + SEQ[vIndex];
  end
  else
    vSerialNumber := SEQ;
  vH     := vSerialNumber;
  //           1     2     3     4     5     6     7     8     9     10    11     12
  Result := vH[1]+vM[1]+vH[3]+vM[3]+vH[5]+vM[5]+vH[7]+vM[7]+vH[9]+vM[9]+vH[10]+vM[11];
end;

procedure ExecuteProgram(afolder,aFileName,aParameter:String; aWait:Boolean);
  function AddFolderBackSlash(aFolderName: string): string;
  begin
    if (aFolderName <> EmptyStr) and (aFolderName[Length(aFolderName)] <> '\') then
      aFolderName := aFolderName + '\';
    Result := aFolderName;
  end;
var
  vShellExecuteInfo: TShellExecuteInfo;
  vProcessHandle   : DWORD;
begin
  if afolder = '' then
    aFileName := AddFolderBackSlash(ExtractFileDir(Application.ExeName))+ aFileName
  else
    aFileName := AddFolderBackSlash(afolder)+ aFileName;

  FillChar(vShellExecuteInfo, Sizeof(vShellExecuteInfo), 0);
  with vShellExecuteInfo do
  begin
    cbSize       := Sizeof(vShellExecuteInfo);
    fMask        := SEE_MASK_NOCLOSEPROCESS or SEE_MASK_FLAG_DDEWAIT;
    wnd          := GetActiveWindow;
    lpVerb       := 'open';
    lpFile       := PChar(aFileName);
    lpParameters := PChar(aParameter);
    nShow        := SW_SHOW;
  end;
  if not FileExists(aFileName) then Exit;

  // 프로그램을 실행한다
  if ShellExecuteEx(@vShellExecuteInfo) then
    vProcessHandle := vShellExecuteInfo.hProcess
  else
    Exit;


  if aWait then
    while WaitForSingleObject(vShellExecuteInfo.hProcess, 50) <> WAIT_OBJECT_0 do
      Application.ProcessMessages;
  CloseHandle(vProcessHandle);
end;

function  CheckComPort(aPort:Integer):Boolean;
var vReg : TRegistry;
    vTempList:TStringList;
    vIndex :Integer;
begin
  if aPort = 0 then
  begin
    Result := true;
    Exit;
  end;
  Result := false;
  vReg := TRegistry.Create;
  vTempList := TStringList.Create;
  try
    vReg.RootKey := HKEY_LOCAL_MACHINE;
    vReg.OpenKey('HARDWARE\DEVICEMAP\SERIALCOMM',false);
    vReg.GetValueNames (vTempList);

    for vIndex := 0 to vTempList.Count-1 do
    begin
      if LeftStr(vReg.ReadString(vTempList.Strings[vIndex]),3) <> 'COM' then Continue;
      if vReg.ReadString(vTempList.Strings[vIndex]) = 'COM'+IntToStr(aPort) then
      begin
        Result := true;
        Break;
      end;
    end;
  finally
    vReg.CloseKey;
    vReg.Free;
    vTempList.Free;
  end;
end;

procedure SetComPortList(aComPortComboBox:TcxComboBox; aDefault:String);
var vReg : TRegistry;
    vTempList:TStringList;
    vIndex :Integer;
    vCode: PStrPointer;
begin
  vReg := TRegistry.Create;
  vTempList := TStringList.Create;
  try
    vReg.RootKey := HKEY_LOCAL_MACHINE;
    vReg.OpenKey('HARDWARE\DEVICEMAP\SERIALCOMM',false);
    vReg.GetValueNames(vTempList);

    aComPortComboBox.Properties.Items.Clear;
    if aDefault <> '' then
    begin
      New(vCode);
      vCode^.Data := '0';
      if aDefault = '사용안함' then
        aComPortComboBox.Properties.Items.AddObject(Common.GetPaPago(aDefault), TObject(vCode))
      else
        aComPortComboBox.Properties.Items.AddObject(aDefault, TObject(vCode));
    end;
    for vIndex := 0 to vTempList.Count-1 do
    begin
      if LeftStr(vReg.ReadString(vTempList.Strings[vIndex]),3) <> 'COM' then Continue;
      if Pos('com0com',vTempList.Strings[vIndex]) > 0 then Continue;
      New(vCode);
      vCode^.Data := GetOnlyNumber(vReg.ReadString(vTempList.Strings[vIndex]));
      aComPortComboBox.Properties.Items.AddObject(vReg.ReadString(vTempList.Strings[vIndex]), TObject(vCode));
    end;
  finally
    aComPortComboBox.ItemIndex := 0;
    vReg.CloseKey;
    vReg.Free;
    vTempList.Free;
  end;
end;

procedure SetComPortListEx(aComPortComboBox:TcxComboBox; aDefault:String);
var vReg : TRegistry;
    vTempList:TStringList;
    vIndex :Integer;
    vCode: PStrPointer;
begin
  vReg := TRegistry.Create;
  vTempList := TStringList.Create;
  try
    vReg.RootKey := HKEY_LOCAL_MACHINE;
    vReg.OpenKey('HARDWARE\DEVICEMAP\SERIALCOMM',false);
    vReg.GetValueNames(vTempList);

    aComPortComboBox.Properties.Items.Clear;
    if aDefault <> '' then
    begin
      New(vCode);
      vCode^.Data := '0';
      if aDefault = '사용안함' then
        aComPortComboBox.Properties.Items.AddObject(Common.GetPaPago(aDefault), TObject(vCode))
      else
        aComPortComboBox.Properties.Items.AddObject(aDefault, TObject(vCode));

    end;
    for vIndex := 0 to vTempList.Count-1 do
    begin
      if LeftStr(vReg.ReadString(vTempList.Strings[vIndex]),3) <> 'COM' then Continue;
      if (Pos('com0com',vTempList.Strings[vIndex]) = 0) then Continue;
      New(vCode);
      vCode^.Data := GetOnlyNumber(vReg.ReadString(vTempList.Strings[vIndex]));
      aComPortComboBox.Properties.Items.AddObject(vReg.ReadString(vTempList.Strings[vIndex]), TObject(vCode));
    end;
  finally
    aComPortComboBox.ItemIndex := 0;
    vReg.CloseKey;
    vReg.Free;
    vTempList.Free;
  end;
end;

procedure ClearPanel(var aPanel : TPanel);
var I : Integer;
    FullRgn, ClientRgn, ControlRgn : THandle;
    Margin, MarginX, MarginY, X, Y : Integer;
begin
  Margin := (aPanel.Width - aPanel.ClientWidth) div 2;
  FullRgn := CreateRectRgn(0, 0, aPanel.Width, aPanel.Height);
  MarginX := Margin;
  MarginY := aPanel.Height - aPanel.ClientHeight - Margin;
  ClientRgn := CreateRectRgn(MarginX, MarginY, MarginX + aPanel.ClientWidth,
  MarginY + aPanel.ClientHeight);
  CombineRgn(FullRgn, FullRgn, ClientRgn, RGN_DIFF);
  for I:=0 to aPanel.ControlCount-1 do
  begin
    X := MarginX + aPanel.Controls[I].Left;
    Y := MarginY + aPanel.Controls[I].Top;
    ControlRgn := CreateRectRgn(X, Y, X + aPanel.Controls[I].Width,
    Y + aPanel.Controls[I].Height);
    CombineRgn(FullRgn, FullRgn, ControlRgn, RGN_OR);
  end;
  SetWindowRgn(aPanel.Handle, FullRgn, True);
end;

function GetWindowsPath(nCSIDL:Word): String;
var
  P: array [0..MAX_PATH] of Char;
begin
  if SHGetSpecialFolderPath(0, @P[0], nCSIDL, True) then Result := P
  else                                                   Result := '';
end;

function IsRiffWav(const B: TBytes): Boolean;
begin
  Result := (Length(B) >= 4) and (AnsiChar(B[0])='R') and (AnsiChar(B[1])='I') and
            (AnsiChar(B[2])='F') and (AnsiChar(B[3])='F');
end;

function Pcm16MonoToWavBytes(const Pcm: TBytes; SampleRate: Integer): TBytes;
const
  RIFF: array[0..3] of AnsiChar = ('R','I','F','F');
  WAVE: array[0..3] of AnsiChar = ('W','A','V','E');
  FMT_: array[0..3] of AnsiChar = ('f','m','t',' ');
  DATA: array[0..3] of AnsiChar = ('d','a','t','a');
var
  Mem: TMemoryStream;
  ChunkSize, Subchunk1Size, Subchunk2Size, ByteRate: Cardinal;
  AudioFormat, NumChannels, BitsPerSample: Word;
  BlockAlign: Word;
begin
  AudioFormat := 1;      // PCM
  NumChannels := 1;      // Mono
  BitsPerSample := 16;   // LINEAR16

  BlockAlign := NumChannels * (BitsPerSample div 8);
  ByteRate := Cardinal(SampleRate) * Cardinal(BlockAlign);

  Subchunk1Size := 16;
  Subchunk2Size := Length(Pcm);
  ChunkSize := 36 + Subchunk2Size;

  Mem := TMemoryStream.Create;
  try
    Mem.WriteBuffer(RIFF, SizeOf(RIFF));
    Mem.WriteBuffer(ChunkSize, SizeOf(ChunkSize));
    Mem.WriteBuffer(WAVE, SizeOf(WAVE));

    Mem.WriteBuffer(FMT_, SizeOf(FMT_));
    Mem.WriteBuffer(Subchunk1Size, SizeOf(Subchunk1Size));
    Mem.WriteBuffer(AudioFormat, SizeOf(AudioFormat));
    Mem.WriteBuffer(NumChannels, SizeOf(NumChannels));
    Mem.WriteBuffer(SampleRate, SizeOf(SampleRate));
    Mem.WriteBuffer(ByteRate, SizeOf(ByteRate));
    Mem.WriteBuffer(BlockAlign, SizeOf(BlockAlign));
    Mem.WriteBuffer(BitsPerSample, SizeOf(BitsPerSample));

    Mem.WriteBuffer(DATA, SizeOf(DATA));
    Mem.WriteBuffer(Subchunk2Size, SizeOf(Subchunk2Size));

    if Subchunk2Size > 0 then
      Mem.WriteBuffer(Pcm[0], Subchunk2Size);

    SetLength(Result, Mem.Size);
    Mem.Position := 0;
    Mem.ReadBuffer(Result[0], Mem.Size);
  finally
    Mem.Free;
  end;
end;

procedure SaveBytesToFile(const FileName: string; const Data: TBytes);
var
  FS: TFileStream;
begin
  FS := TFileStream.Create(FileName, fmCreate);
  try
    if Length(Data) > 0 then
      FS.WriteBuffer(Data[0], Length(Data));
  finally
    FS.Free;
  end;
end;

function GoogleTTS_SaveAsWav_Indy(
  const ApiKey, Text, OutWavFile: string;
  const SampleRate: Integer = 24000;
  const VoiceName: string = 'ko-KR-Wavenet-A'
): Boolean;
var
  vHttp: TIdHTTP;
  vSSL: TIdSSLIOHandlerSocketOpenSSL;
  Url: string;

  ReqJson: TJSONObject;
  ReqStream: TStringStream;
  RespStream: TStringStream;
  RespJson: TJSONObject;

  AudioBase64: string;
  RawBytes: TBytes;
  WavBytes: TBytes;
begin
  Result := False;

  Url := 'https://texttospeech.googleapis.com/v1/text:synthesize?key=' + ApiKey;

  vHttp := TIdHTTP.Create(nil);
  vSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  ReqStream := nil;
  RespStream := nil;
  RespJson := nil;

  try
    vHttp.IOHandler := vSSL;
    vHttp.Request.ContentType := 'application/json; charset=utf-8';

    // 요청 JSON
    ReqJson := TJSONObject.Create;
    try
      ReqJson.AddPair('input',TJSONObject.Create.AddPair('ssml','<speak><break time="300ms"/>'+Text+'</speak>'));
      ReqJson.AddPair('voice',TJSONObject.Create.AddPair('languageCode', 'ko-KR').AddPair('name', VoiceName));

      // ✅ LINEAR16 + 샘플레이트 고정
      ReqJson.AddPair('audioConfig',
        TJSONObject.Create
          .AddPair('audioEncoding', 'LINEAR16')
          .AddPair('sampleRateHertz', TJSONNumber.Create(SampleRate)));

      ReqStream := TStringStream.Create(ReqJson.ToJSON, TEncoding.UTF8);
    finally
      ReqJson.Free;
    end;

    RespStream := TStringStream.Create('', TEncoding.UTF8);
    try
      vHttp.Post(Url, ReqStream, RespStream);
    finally
      ReqStream.Free;
    end;

    // 응답 JSON 파싱
    RespJson := TJSONObject.ParseJSONValue(RespStream.DataString) as TJSONObject;
    try
      if (RespJson = nil) or (not RespJson.TryGetValue<string>('audioContent', AudioBase64)) then
        Exit(False);

      RawBytes := TNetEncoding.Base64.DecodeStringToBytes(AudioBase64);
      if Length(RawBytes) = 0 then
        Exit(False);

      // ✅ RIFF 헤더 있으면 그대로, 없으면 헤더 붙여 WAV로 변환
      if IsRiffWav(RawBytes) then
        WavBytes := RawBytes
      else
        WavBytes := Pcm16MonoToWavBytes(RawBytes, SampleRate);

      Sleep(100);
      SaveBytesToFile(OutWavFile, WavBytes);
      Result := True;
    finally
      RespJson.Free;
      RespStream.Free;
    end;

  finally
    vSSL.Free;
    vHttp.Free;
  end;
end;

procedure AddLeadingSilenceToPcmWavFile(const InWav, OutWav: string; SampleRate, LeadMs: Integer);
var
  InBytes, OutBytes: TBytes;
  DataSize, NewDataSize, ChunkSize: Cardinal;
  SilenceBytes: Integer;
  FS: TFileStream;
begin
  // 파일 읽기
  FS := TFileStream.Create(InWav, fmOpenRead or fmShareDenyWrite);
  try
    SetLength(InBytes, FS.Size);
    if FS.Size > 0 then
      FS.ReadBuffer(InBytes[0], FS.Size);
  finally
    FS.Free;
  end;

  // 최소 WAV 헤더 44 bytes 체크
  if Length(InBytes) < 44 then
    raise Exception.Create('WAV 파일이 너무 짧습니다.');

  // "RIFF" 체크
  if not ((AnsiChar(InBytes[0])='R') and (AnsiChar(InBytes[1])='I') and (AnsiChar(InBytes[2])='F') and (AnsiChar(InBytes[3])='F')) then
    raise Exception.Create('RIFF WAV가 아닙니다.');

  // 16bit mono 기준: 1샘플=2바이트
  SilenceBytes := (SampleRate * LeadMs div 1000) * 2;

  // data size (표준 PCM WAV는 보통 offset 40)
  DataSize := ReadLE32(InBytes, 40);
  NewDataSize := DataSize + Cardinal(SilenceBytes);
  ChunkSize := 36 + NewDataSize;

  // 출력 버퍼 만들기: 헤더(44) + 무음 + 기존 data
  SetLength(OutBytes, 44 + SilenceBytes + Integer(DataSize));

  // 헤더 복사
  Move(InBytes[0], OutBytes[0], 44);

  // 헤더 내 크기 갱신
  WriteLE32(OutBytes, 4, ChunkSize);
  WriteLE32(OutBytes, 40, NewDataSize);

  // 무음(0) 구간 채우기
  FillChar(OutBytes[44], SilenceBytes, 0);

  // 원본 PCM 데이터 복사 (원본 데이터 시작은 44로 가정)
  if DataSize > 0 then
    Move(InBytes[44], OutBytes[44 + SilenceBytes], DataSize);

  // 저장
  FS := TFileStream.Create(OutWav, fmCreate);
  try
    FS.WriteBuffer(OutBytes[0], Length(OutBytes));
  finally
    FS.Free;
  end;
end;

function TtsCacheFileName(const CacheDir, Text: string): string;
begin
  Result := IncludeTrailingPathDelimiter(CacheDir) +
            THashMD5.GetHashString(Text) + '.wav';
end;

procedure SpeakCached_PlaySound_LeadSilence(const ApiKey, CacheDir, Text, FileName: string);
var
  Fn, Tmp: string;
begin
  ForceDirectories(CacheDir);
  Fn := TtsCacheFileName(CacheDir, Text);

  if not FileExists(Fn) then
  begin
    Tmp := Fn + '.tmp';

    // 1) 먼저 Google TTS로 WAV 생성(Tmp)
    if not GoogleTTS_SaveAsWav_Indy(ApiKey, Text, Tmp, 24000) then
      raise Exception.Create('TTS 생성 실패');

    // 2) 앞 무음 500ms 붙여서 최종 FileName으로 저장
    AddLeadingSilenceToPcmWavFile(Tmp, FileName, 24000, 500);

    DeleteFile(PChar(Tmp));
    Sleep(100); // 파일 시스템 안정화
  end;
end;

function ReadLE32(const B: TBytes; Offset: Integer): Cardinal;
begin
  Result := Cardinal(B[Offset]) or (Cardinal(B[Offset+1]) shl 8) or
            (Cardinal(B[Offset+2]) shl 16) or (Cardinal(B[Offset+3]) shl 24);
end;

procedure WriteLE32(var B: TBytes; Offset: Integer; Value: Cardinal);
begin
  B[Offset]   := Byte(Value and $FF);
  B[Offset+1] := Byte((Value shr 8) and $FF);
  B[Offset+2] := Byte((Value shr 16) and $FF);
  B[Offset+3] := Byte((Value shr 24) and $FF);
end;



function ReadU32LE(const B: TBytes; Off: Integer): Cardinal;
begin
  Result := Cardinal(B[Off]) or (Cardinal(B[Off+1]) shl 8) or
            (Cardinal(B[Off+2]) shl 16) or (Cardinal(B[Off+3]) shl 24);
end;

function ReadU16LE(const B: TBytes; Off: Integer): Word;
begin
  Result := Word(B[Off]) or (Word(B[Off+1]) shl 8);
end;

function PcmToStdWavBytes(const Pcm: TBytes; const Fmt: TWavFmt): TBytes;
const
  RIFF: array[0..3] of AnsiChar = ('R','I','F','F');
  WAVE: array[0..3] of AnsiChar = ('W','A','V','E');
  FMT_: array[0..3] of AnsiChar = ('f','m','t',' ');
  DATA: array[0..3] of AnsiChar = ('d','a','t','a');
var
  Mem: TMemoryStream;
  ChunkSize, Sub1, Sub2: Cardinal;
begin
  Sub1 := 16;
  Sub2 := Length(Pcm);
  ChunkSize := 36 + Sub2;

  Mem := TMemoryStream.Create;
  try
    Mem.WriteBuffer(RIFF, 4);
    Mem.WriteBuffer(ChunkSize, 4);
    Mem.WriteBuffer(WAVE, 4);

    Mem.WriteBuffer(FMT_, 4);
    Mem.WriteBuffer(Sub1, 4);
    Mem.WriteBuffer(Fmt.AudioFormat, 2);
    Mem.WriteBuffer(Fmt.NumChannels, 2);
    Mem.WriteBuffer(Fmt.SampleRate, 4);
    Mem.WriteBuffer(Fmt.ByteRate, 4);
    Mem.WriteBuffer(Fmt.BlockAlign, 2);
    Mem.WriteBuffer(Fmt.BitsPerSample, 2);

    Mem.WriteBuffer(DATA, 4);
    Mem.WriteBuffer(Sub2, 4);

    if Sub2 > 0 then
      Mem.WriteBuffer(Pcm[0], Sub2);

    SetLength(Result, Mem.Size);
    Mem.Position := 0;
    Mem.ReadBuffer(Result[0], Mem.Size);
  finally
    Mem.Free;
  end;
end;

function RepackWavToStandardPcm(const InWav, OutWav: string): Boolean;
var
  InBytes: TBytes;
  FS: TFileStream;
  i, Posn: Integer;
  ChunkId: AnsiString;
  ChunkSize: Cardinal;
  Fmt: TWavFmt;
  HaveFmt, HaveData: Boolean;
  DataStart: Integer;
  DataSize: Cardinal;
  Pcm: TBytes;
  OutBytes: TBytes;
begin
  Result := False;
  HaveFmt := False;
  HaveData := False;
  DataStart := -1;
  DataSize := 0;

  FS := TFileStream.Create(InWav, fmOpenRead or fmShareDenyWrite);
  try
    SetLength(InBytes, FS.Size);
    if FS.Size > 0 then
      FS.ReadBuffer(InBytes[0], FS.Size);
  finally
    FS.Free;
  end;

  if Length(InBytes) < 12 then Exit;

  // RIFF/WAVE 확인
  if not ((AnsiChar(InBytes[0])='R') and (AnsiChar(InBytes[1])='I') and (AnsiChar(InBytes[2])='F') and (AnsiChar(InBytes[3])='F')) then Exit;
  if not ((AnsiChar(InBytes[8])='W') and (AnsiChar(InBytes[9])='A') and (AnsiChar(InBytes[10])='V') and (AnsiChar(InBytes[11])='E')) then Exit;

  // chunk scan 시작 (12부터)
  Posn := 12;
  while (Posn + 8) <= Length(InBytes) do
  begin
    SetString(ChunkId, PAnsiChar(@InBytes[Posn]), 4);
    ChunkSize := ReadU32LE(InBytes, Posn + 4);
    Inc(Posn, 8);

    if (Posn + Integer(ChunkSize)) > Length(InBytes) then Break;

    if ChunkId = 'fmt ' then
    begin
      if ChunkSize >= 16 then
      begin
        Fmt.AudioFormat   := ReadU16LE(InBytes, Posn + 0);
        Fmt.NumChannels   := ReadU16LE(InBytes, Posn + 2);
        Fmt.SampleRate    := ReadU32LE(InBytes, Posn + 4);
        Fmt.ByteRate      := ReadU32LE(InBytes, Posn + 8);
        Fmt.BlockAlign    := ReadU16LE(InBytes, Posn + 12);
        Fmt.BitsPerSample := ReadU16LE(InBytes, Posn + 14);
        HaveFmt := True;
      end;
    end
    else if ChunkId = 'data' then
    begin
      DataStart := Posn;
      DataSize := ChunkSize;
      HaveData := True;
    end;

    // chunks are word-aligned
    Inc(Posn, Integer(ChunkSize));
    if (ChunkSize and 1) = 1 then Inc(Posn);
    if HaveFmt and HaveData then Break;
  end;

  if not (HaveFmt and HaveData) then Exit;
  if Fmt.AudioFormat <> 1 then Exit; // PCM만 처리(지금 케이스)

  SetLength(Pcm, DataSize);
  if DataSize > 0 then
    Move(InBytes[DataStart], Pcm[0], DataSize);

  OutBytes := PcmToStdWavBytes(Pcm, Fmt);

  FS := TFileStream.Create(OutWav, fmCreate);
  try
    FS.WriteBuffer(OutBytes[0], Length(OutBytes));
  finally
    FS.Free;
  end;

  Result := True;
end;

procedure MciStop(const AliasName: string = 'tts');
begin
  mciSendString(PChar('stop ' + AliasName), nil, 0, 0);
  mciSendString(PChar('close ' + AliasName), nil, 0, 0);
end;

procedure MciPlayWav(const FileName: string; const AliasName: string = 'tts');
var
  Cmd: string;
begin
  // 이전 재생 정리
  MciStop(AliasName);
  // open
  Cmd := Format('open "%s" type waveaudio alias %s', [FileName, AliasName]);
  if mciSendString(PChar(Cmd), nil, 0, 0) <> 0 then
    raise Exception.Create('MCI open 실패');

  // play (notify 없이 비동기)
  Cmd := 'play ' + AliasName;
  if mciSendString(PChar(Cmd), nil, 0, 0) <> 0 then
  begin
    MciStop(AliasName);
    raise Exception.Create('MCI play 실패');
  end;
end;


function GetRustDeskPath: string;
begin
  if FileExists('C:\Program Files\RustDesk\rustdesk.exe') then
    Exit('C:\Program Files\RustDesk\rustdesk.exe');

  if FileExists('C:\Program Files (x86)\RustDesk\rustdesk.exe') then
    Exit('C:\Program Files (x86)\RustDesk\rustdesk.exe');

  Result := '';
end;

function IsRustDeskInstalled: Boolean;
begin
  Result := GetRustDeskPath <> '';
end;

function IsProcessRunning(const ExeFileName: string): Boolean;
var
  SnapShot: THandle;
  ProcEntry: TProcessEntry32;
begin
  Result := False;
  SnapShot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if SnapShot = INVALID_HANDLE_VALUE then
    Exit;

  try
    ProcEntry.dwSize := SizeOf(TProcessEntry32);
    if Process32First(SnapShot, ProcEntry) then
    begin
      repeat
        if SameText(ExtractFileName(ProcEntry.szExeFile), ExeFileName) then
        begin
          Result := True;
          Break;
        end;
      until not Process32Next(SnapShot, ProcEntry);
    end;
  finally
    CloseHandle(SnapShot);
  end;
end;

function IsRustDeskRunning: Boolean;
begin
  Result := IsProcessRunning('rustdesk.exe');
end;

function RunRustDesk: Boolean;
var
  RustDeskPath: string;
begin
  Result := False;
  RustDeskPath := GetRustDeskPath;
  if RustDeskPath = '' then
    Exit;

  Result := ShellExecute(0, 'open', PChar(RustDeskPath), nil, nil, SW_SHOWNORMAL) > 32;
end;

function EnsureRustDeskRunning: Boolean;
begin
  if not IsRustDeskInstalled then
    Exit(False);

  if not IsRustDeskRunning then
    Result := RunRustDesk
  else
    Result := True;
end;

end.
