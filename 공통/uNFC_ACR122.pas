unit uNFC_ACR122;

interface

uses
  System.SysUtils, System.Classes, Winapi.Windows;

type
  TOnCardUID = procedure(const UID: string) of object;
  TOnLog = procedure(const Msg: string) of object;

procedure StartMonitor(AOnUID: TOnCardUID; AOnLog: TOnLog = nil);
procedure StopMonitor;

implementation

type
  SCARDCONTEXT = NativeUInt;
  SCARDHANDLE  = NativeUInt;

  PSCARD_READERSTATEW = ^SCARD_READERSTATEW;
  SCARD_READERSTATEW = record
    szReader: PWideChar;
    pvUserData: Pointer;
    dwCurrentState: DWORD;
    dwEventState: DWORD;
    cbAtr: DWORD;
    rgbAtr: array[0..35] of Byte;
  end;

  PSCARD_IO_REQUEST = ^SCARD_IO_REQUEST;
  SCARD_IO_REQUEST = record
    dwProtocol: DWORD;
    cbPciLength: DWORD;
  end;

const
  SCARD_S_SUCCESS       = 0;
  SCARD_SCOPE_USER      = 0;
  SCARD_SHARE_SHARED    = 2;
  SCARD_PROTOCOL_T0     = $0001;
  SCARD_PROTOCOL_T1     = $0002;
  SCARD_LEAVE_CARD      = 0;

  SCARD_STATE_UNAWARE   = $00000000;
  SCARD_STATE_EMPTY     = $00000010;
  SCARD_STATE_PRESENT   = $00000020;

function SCardEstablishContext(dwScope: DWORD; pvReserved1, pvReserved2: Pointer;
  out phContext: SCARDCONTEXT): LongInt; stdcall; external 'WinSCard.dll';

function SCardReleaseContext(hContext: SCARDCONTEXT): LongInt; stdcall; external 'WinSCard.dll';

function SCardListReaders(hContext: SCARDCONTEXT; mszGroups: PWideChar;
  mszReaders: PWideChar; var pcchReaders: DWORD): LongInt; stdcall; external 'WinSCard.dll' name 'SCardListReadersW';

function SCardConnect(hContext: SCARDCONTEXT; szReader: PWideChar; dwShareMode,
  dwPreferredProtocols: DWORD; out phCard: SCARDHANDLE;
  out pdwActiveProtocol: DWORD): LongInt; stdcall; external 'WinSCard.dll' name 'SCardConnectW';

function SCardDisconnect(hCard: SCARDHANDLE; dwDisposition: DWORD): LongInt; stdcall; external 'WinSCard.dll';

function SCardTransmit(hCard: SCARDHANDLE; pioSendPci: PSCARD_IO_REQUEST;
  pbSendBuffer: PByte; cbSendLength: DWORD; pioRecvPci: PSCARD_IO_REQUEST;
  pbRecvBuffer: PByte; var pcbRecvLength: DWORD): LongInt; stdcall; external 'WinSCard.dll';

function SCardGetStatusChange(hContext: SCARDCONTEXT; dwTimeout: DWORD;
  rgReaderStates: PSCARD_READERSTATEW; cReaders: DWORD): LongInt; stdcall; external 'WinSCard.dll' name 'SCardGetStatusChangeW';

var
  MonitorThread: TThread = nil;

type
  TNFCThread = class(TThread)
  private
    FOnUID: TOnCardUID;
//    FOnLog: TOnLog;
    FLastUID: string;
//    procedure Log(const S: string);
    function GetReader(hContext: SCARDCONTEXT): string;
    function ReadUID(hContext: SCARDCONTEXT; const Reader: string; out UID: string): Boolean;
  protected
    procedure Execute; override;
  public
    constructor Create(AOnUID: TOnCardUID);
  end;

{ Thread }

constructor TNFCThread.Create(AOnUID: TOnCardUID);
begin
  inherited Create(False);
  FreeOnTerminate := False;
  FOnUID := AOnUID;
end;

function TNFCThread.GetReader(hContext: SCARDCONTEXT): string;
var
  Len: DWORD;
  Buf: array of WideChar;
  P: PWideChar;
  S: string;
begin
  Result := '';

  SCardListReaders(hContext, nil, nil, Len);
  if Len = 0 then Exit;

  SetLength(Buf, Len);
  SCardListReaders(hContext, nil, PWideChar(Buf), Len);

  P := PWideChar(Buf);
  while P^ <> #0 do
  begin
    S := P;
    if Pos('ACR122', UpperCase(S)) > 0 then
      Exit(S);
    Inc(P, Length(S) + 1);
  end;

  Result := PWideChar(Buf);
end;

function TNFCThread.ReadUID(hContext: SCARDCONTEXT; const Reader: string; out UID: string): Boolean;
var
  Card: SCARDHANDLE;
  Proto: DWORD;
  SendBuf: array[0..4] of Byte;
  RecvBuf: array[0..255] of Byte;
  RecvLen: DWORD;
  SendPci: SCARD_IO_REQUEST;
  Ret: LongInt;
  I: Integer;
begin
  Result := False;
  UID := '';

  Ret := SCardConnect(hContext, PWideChar(Reader),
    SCARD_SHARE_SHARED,
    SCARD_PROTOCOL_T0 or SCARD_PROTOCOL_T1,
    Card, Proto);

  if Ret <> SCARD_S_SUCCESS then
  begin
//    Log(Format('SCardConnect fail: %.8x', [Ret]));
    Exit;
  end;

  try
    SendBuf[0] := $FF;
    SendBuf[1] := $CA;
    SendBuf[2] := $00;
    SendBuf[3] := $00;
    SendBuf[4] := $00;

    SendPci.dwProtocol := Proto;
    SendPci.cbPciLength := SizeOf(SCARD_IO_REQUEST);

    RecvLen := SizeOf(RecvBuf);

    Ret := SCardTransmit(Card, @SendPci, @SendBuf[0], 5, nil, @RecvBuf[0], RecvLen);
    if Ret <> SCARD_S_SUCCESS then
    begin
//      Log(Format('SCardTransmit fail: %.8x', [Ret]));
      Exit;
    end;

    if RecvLen < 2 then
    begin
//      Log('응답 길이 부족');
      Exit;
    end;

    if (RecvBuf[RecvLen-2] <> $90) or (RecvBuf[RecvLen-1] <> $00) then
    begin
//      Log(Format('APDU fail: SW=%2.2x%2.2x', [RecvBuf[RecvLen-2], RecvBuf[RecvLen-1]]));
      Exit;
    end;

    for I := 0 to RecvLen - 3 do
      UID := UID + IntToHex(RecvBuf[I], 2);

    Result := True;
  finally
    SCardDisconnect(Card, SCARD_LEAVE_CARD);
  end;
end;

procedure TNFCThread.Execute;
var
  ctx: SCARDCONTEXT;
  state: SCARD_READERSTATEW;
  reader: string;
  cardPresent: Boolean;
  uid: string;
begin
  if SCardEstablishContext(SCARD_SCOPE_USER, nil, nil, ctx) <> SCARD_S_SUCCESS then
  begin
//    Log('Context 실패');
    Exit;
  end;

  try
    reader := GetReader(ctx);
    if reader = '' then
    begin
//      Log('리더 없음');
      Exit;
    end;

//    Log('리더: ' + reader);

    ZeroMemory(@state, SizeOf(state));
    state.szReader := PWideChar(reader);
    state.dwCurrentState := SCARD_STATE_UNAWARE;

    cardPresent := False;

    while not Terminated do
    begin
      SCardGetStatusChange(ctx, 500, @state, 1);

      if ((state.dwEventState and SCARD_STATE_PRESENT) <> 0) and not cardPresent then
      begin
        cardPresent := True;

        if ReadUID(ctx, reader, uid) then
        begin
          if uid <> FLastUID then
          begin
            FLastUID := uid;
            if Assigned(FOnUID) then
              TThread.Queue(nil,
                procedure
                begin
                  FOnUID(uid);
                end);
          end;
        end;
      end;

      if ((state.dwEventState and SCARD_STATE_EMPTY) <> 0) and cardPresent then
      begin
        cardPresent := False;
        FLastUID := '';
      end;

      state.dwCurrentState := state.dwEventState;
    end;

  finally
    SCardReleaseContext(ctx);
  end;
end;

{ API }

procedure StartMonitor(AOnUID: TOnCardUID; AOnLog: TOnLog);
begin
  if Assigned(MonitorThread) then Exit;
  MonitorThread := TNFCThread.Create(AOnUID);
end;

procedure StopMonitor;
begin
  if Assigned(MonitorThread) then
  begin
    MonitorThread.Terminate;
    MonitorThread.WaitFor;
    FreeAndNil(MonitorThread);
  end;
end;

end.
