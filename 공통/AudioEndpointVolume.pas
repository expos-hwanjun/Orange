unit AudioEndpointVolume;

interface

uses
  Winapi.Windows,
  Winapi.ActiveX,
  System.SysUtils,
  System.Win.ComObj;

type
  EDataFlow = (
    eRender,
    eCapture,
    eAll,
    EDataFlow_enum_count
  );

  ERole = (
    eConsole,
    eMultimedia,
    eCommunications,
    ERole_enum_count
  );

  IMMDevice = interface(IUnknown)
    ['{D666063F-1587-4E43-81F1-B948E807363F}']
    function Activate(const iid: TGUID; dwClsCtx: DWORD; pActivationParams: Pointer;
      out ppInterface): HRESULT; stdcall;
    function OpenPropertyStore(stgmAccess: DWORD; out ppProperties): HRESULT; stdcall;
    function GetId(out ppstrId: PWideChar): HRESULT; stdcall;
    function GetState(out pdwState: DWORD): HRESULT; stdcall;
  end;

  IMMDeviceEnumerator = interface(IUnknown)
    ['{A95664D2-9614-4F35-A746-DE8DB63617E6}']
    function EnumAudioEndpoints(dataFlow: EDataFlow; dwStateMask: DWORD; out ppDevices): HRESULT; stdcall;
    function GetDefaultAudioEndpoint(dataFlow: EDataFlow; role: ERole; out ppEndpoint: IMMDevice): HRESULT; stdcall;
    function GetDevice(pwstrId: PWideChar; out ppDevice: IMMDevice): HRESULT; stdcall;
    function RegisterEndpointNotificationCallback(pClient: IUnknown): HRESULT; stdcall;
    function UnregisterEndpointNotificationCallback(pClient: IUnknown): HRESULT; stdcall;
  end;

  IAudioEndpointVolume = interface(IUnknown)
    ['{5CDF2C82-841E-4546-9722-0CF74078229A}']
    function RegisterControlChangeNotify(pNotify: IUnknown): HRESULT; stdcall;
    function UnregisterControlChangeNotify(pNotify: IUnknown): HRESULT; stdcall;
    function GetChannelCount(out pnChannelCount: UINT): HRESULT; stdcall;
    function SetMasterVolumeLevel(fLevelDB: Single; pguidEventContext: PGUID): HRESULT; stdcall;
    function SetMasterVolumeLevelScalar(fLevel: Single; pguidEventContext: PGUID): HRESULT; stdcall;
    function GetMasterVolumeLevel(out pfLevelDB: Single): HRESULT; stdcall;
    function GetMasterVolumeLevelScalar(out pfLevel: Single): HRESULT; stdcall;
    function SetChannelVolumeLevel(nChannel: UINT; fLevelDB: Single; pguidEventContext: PGUID): HRESULT; stdcall;
    function SetChannelVolumeLevelScalar(nChannel: UINT; fLevel: Single; pguidEventContext: PGUID): HRESULT; stdcall;
    function GetChannelVolumeLevel(nChannel: UINT; out pfLevelDB: Single): HRESULT; stdcall;
    function GetChannelVolumeLevelScalar(nChannel: UINT; out pfLevel: Single): HRESULT; stdcall;
    function SetMute(bMute: BOOL; pguidEventContext: PGUID): HRESULT; stdcall;
    function GetMute(out pbMute: BOOL): HRESULT; stdcall;
    function GetVolumeStepInfo(out pnStep: UINT; out pnStepCount: UINT): HRESULT; stdcall;
    function VolumeStepUp(pguidEventContext: PGUID): HRESULT; stdcall;
    function VolumeStepDown(pguidEventContext: PGUID): HRESULT; stdcall;
    function QueryHardwareSupport(out pdwHardwareSupportMask: DWORD): HRESULT; stdcall;
    function GetVolumeRange(out pflVolumeMindB, pflVolumeMaxdB, pflVolumeIncrementdB: Single): HRESULT; stdcall;
  end;

const
  CLASS_MMDeviceEnumerator: TGUID = '{BCDE0395-E52F-467C-8E3D-C4579291692E}';
  IID_IMMDeviceEnumerator: TGUID = '{A95664D2-9614-4F35-A746-DE8DB63617E6}';
  IID_IAudioEndpointVolume: TGUID = '{5CDF2C82-841E-4546-9722-0CF74078229A}';

function GetMasterVolumePercent: Integer;
procedure SetMasterVolumePercent(const APercent: Integer);
function GetMasterVolumeScalar: Single;
procedure SetMasterVolumeScalar(const AValue: Single);

function GetMasterMute: Boolean;
procedure SetMasterMute(const AMute: Boolean);

implementation

function CreateEndpointVolume: IAudioEndpointVolume;
var
  DeviceEnumerator: IMMDeviceEnumerator;
  Device: IMMDevice;
begin
  Result := nil;

  OleCheck(CoCreateInstance(CLASS_MMDeviceEnumerator, nil, CLSCTX_INPROC_SERVER,
    IID_IMMDeviceEnumerator, DeviceEnumerator));

  OleCheck(DeviceEnumerator.GetDefaultAudioEndpoint(eRender, eConsole, Device));
  OleCheck(Device.Activate(IID_IAudioEndpointVolume, CLSCTX_INPROC_SERVER, nil, Result));
end;

function ClampSingle(const AValue, AMin, AMax: Single): Single;
begin
  Result := AValue;
  if Result < AMin then
    Result := AMin;
  if Result > AMax then
    Result := AMax;
end;

function ClampInt(const AValue, AMin, AMax: Integer): Integer;
begin
  Result := AValue;
  if Result < AMin then
    Result := AMin;
  if Result > AMax then
    Result := AMax;
end;

function GetMasterVolumeScalar: Single;
var
  EndpointVolume: IAudioEndpointVolume;
begin
  CoInitialize(nil);
  try
    EndpointVolume := CreateEndpointVolume;
    OleCheck(EndpointVolume.GetMasterVolumeLevelScalar(Result));
  finally
    CoUninitialize;
  end;
end;

procedure SetMasterVolumeScalar(const AValue: Single);
var
  EndpointVolume: IAudioEndpointVolume;
  V: Single;
begin
  V := ClampSingle(AValue, 0.0, 1.0);

  CoInitialize(nil);
  try
    EndpointVolume := CreateEndpointVolume;
    OleCheck(EndpointVolume.SetMasterVolumeLevelScalar(V, nil));
  finally
    CoUninitialize;
  end;
end;

function GetMasterVolumePercent: Integer;
begin
  Result := Round(GetMasterVolumeScalar * 100);
end;

procedure SetMasterVolumePercent(const APercent: Integer);
begin
  SetMasterVolumeScalar(ClampInt(APercent, 0, 100) / 100.0);
end;

function GetMasterMute: Boolean;
var
  EndpointVolume: IAudioEndpointVolume;
  MuteValue: BOOL;
begin
  CoInitialize(nil);
  try
    EndpointVolume := CreateEndpointVolume;
    OleCheck(EndpointVolume.GetMute(MuteValue));
    Result := MuteValue;
  finally
    CoUninitialize;
  end;
end;

procedure SetMasterMute(const AMute: Boolean);
var
  EndpointVolume: IAudioEndpointVolume;
begin
  CoInitialize(nil);
  try
    EndpointVolume := CreateEndpointVolume;
    OleCheck(EndpointVolume.SetMute(AMute, nil));
  finally
    CoUninitialize;
  end;
end;

end.
