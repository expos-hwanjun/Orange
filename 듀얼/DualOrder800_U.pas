unit DualOrder800_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, Grids, OleCtrls, ActiveX,
  GraphicEx, Mask,cxControls, cxContainer, cxEdit, cxTextEdit, cxCurrencyEdit, cxLabel,
  MPlayer, IniFiles, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxGroupBox, dxGDIPlusClasses, AdvShape,
  Winapi.DirectShow9, Winapi.DirectDraw;

const
    WM_GRAPHEVENT = WM_APP + 2;

type
  TDualOrder800_F = class(TForm)
    Dual_sGrd: TStringGrid;
    DShowPanel: TPanel;
    ImageTimer: TTimer;
    News_Tmr: TTimer;
    MsgLabel: TcxLabel;
    GridTitleShape: TAdvShape;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    TotalAmtEdit: TcxCurrencyEdit;
    DcAmtEdit: TcxCurrencyEdit;
    WGetAmtEdit: TcxCurrencyEdit;
    GetAmtEdit: TcxCurrencyEdit;
    lbl_StoreName: TLabel;
    Image2: TImage;
    PosNolLabel: TLabel;
    AviTimer: TTimer;
    MemberPanel: TPanel;
    Image1: TImage;
    Label5: TLabel;
    MemberNameLabel: TcxLabel;
    TelNoLabel: TcxLabel;
    Label6: TLabel;
    Label10: TLabel;
    PointLabel: TcxLabel;
    lblTotalStamp1: TcxLabel;
    lblTotalStamp: TcxLabel;
    lblAddStamp: TcxLabel;
    lblAddStamp1: TcxLabel;
    Image3: TImage;
    lblStamp: TcxLabel;
    procedure FormCreate(Sender: TObject);
    procedure ImageTimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure News_TmrTimer(Sender: TObject);
    procedure AviTimerTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Dual_sGrdDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    FMemberName,
    FMemberPoint : TLabel;
    FLabelPoint :Integer;
    DelayTime:Integer;
    DualImage   :TImage;

    FilterGraph: IGraphBuilder; // 필터그래프
    MediaControl: IMediaControl; // 동영상 재생, 정지, 제어
    VideoWindow: IVideoWindow; // 동영상을 재생할 윈도우
    MediaEvent: IMediaEventEx; // DSHOW 이벤트 제어
    AvailableDS: Boolean;
    MediaLength: Double;
    BasicAudio      : IBasicAudio; // Volume/Balance control.
    isFirst : Boolean;

    // 서브 클래싱용
    VideoRenderOrgMethod: TWndMethod;
    procedure VideoRenderWndProc(var Msg: TMessage);

    Function SetupDs: Boolean;
    Function ShutDownDs: Boolean;
    procedure SetVolume(Value : Integer);
    Function  GetVolume:Integer;
  public
  end;

var
  DualOrder800_F: TDualOrder800_F;
  FileType  : String;
implementation
uses Common_U, GlobalFunc_U, Const_U;
{$R *.dfm}

procedure TDualOrder800_F.FormCreate(Sender: TObject);
begin
  if Screen.MonitorCount > 1 then
  begin
    Self.Top        := Screen.Monitors[1].Top;
    Self.Left       := Screen.Monitors[1].Left;
  end;
  Self.DefaultMonitor := dmDesktop;

  Common.LogoCreate(Self,2);
  CoInitialize(nil);

  DelayTime := Common.GetIniFile('DEVICE', '듀얼이미지',  5);
  if DelayTime = 0 then DelayTime := 5;

  Self.DoubleBuffered := True;
  {그리드 초기화}
  with Dual_SGrd do
  begin
     OnDrawCell := Common.GridDrawCell;
     ColCount                 := GDM_COLCOUNT;
     ColWidths[GDM_NO       ] := 33;    //순번
     ColWidths[GDM_TYPE     ] := -1;    //순번
     ColWidths[GDM_NM_MENU  ] := 200;   //메뉴명
     ColWidths[GDM_VIEWQTY  ] := 50;    //수량
     ColWidths[GDM_VIEWPRICE] := 85;    //메뉴단가
     ColWidths[GDM_DC_MENU  ] := -1;    //할인단가
     ColWidths[GDM_AMT      ] := 98;   //메뉴금액
     ColWidths[GDM_CD_MENU  ] := -1;
     ColWidths[GDM_SEQ      ] := -1;
     ColWidths[GDM_DS_MENU  ] := -1;
     ColWidths[GDM_CD_MENU1 ] := -1;
     DefaultRowHeight    := Common.Config.DualGridRowHeight;
  end;


  lbl_StoreName.Caption    := Common.Config.StoreName;
  PosNolLabel.Caption := Format('%s - %s',[Common.Config.PosNo,Common.Config.UserName]);
  FLabelPoint := 0;
  PointLabel.Visible     := GetOption(210) = '0';
  lblStamp.Visible       := GetOption(21) = '1';
  lblAddStamp.Visible    := GetOption(21) = '1';
  lblTotalStamp.Visible  := GetOption(21) = '1';
  lblAddStamp1.Visible   := GetOption(21) = '1';
  lblTotalStamp1.Visible := GetOption(21) = '1';

  VideoRenderOrgMethod := DShowPanel.WindowProc;
  DShowPanel.WindowProc := VideoRenderWndProc;

  if Common.DualData.Count > 0 then
  begin
    FileType := UPPERCASE(Copy(Common.DualData[0],Pos('.',Common.DualData[0])+1,3));
    if (FileType = 'JPG') or (FileType = 'PNG') then
    begin
      ImageTimerTimer(nil);
      ImageTimer.Enabled := true;
      ImageTimer.Tag := 1;
    end
    else
    begin
      isFirst := true;
      Common.DualIndex := -1;
      AviTimerTimer(nil);
    end;
  end;
end;

procedure TDualOrder800_F.FormDestroy(Sender: TObject);
begin
    // COM을 셧다운시킨다.
    CoUninitialize;
end;

function TDualOrder800_F.GetVolume: Integer;
var
    Vol : Integer;
begin
    // 볼륨 계산 0 은 최대 -10,000은 무음
    BasicAudio.get_Volume(Vol);
    Result := 100 - (Vol * -1);
end;

procedure TDualOrder800_F.AviTimerTimer(Sender: TObject);
var vFileName :String;
    WFileName: Array [0 .. 255] of WideChar;
    PFileName: PWideChar;
begin
  AviTimer.Enabled := false;

  if Common.DualData.Count = 0 then Exit;
  Common.DualIndex := Common.DualIndex + 1;
  if Common.DualData.Count = Common.DualIndex then
      Common.DualIndex := 0;
  vFileName := Common.DualData[Common.DualIndex];

  if FileExists(Common.AppPath+'Dual\'+vFileName) then
  begin
    StringToWideChar(Common.AppPath+'Dual\'+vFileName, WFileName, 255);
    PFileName := @WFileName[0];

    // DSHOW 초기화
    if isFirst then
      ShutDownDs;

    // DSHOW 설정
    if SetupDs = False then
        Exit;

    isFirst := false;
    // 동영상 파일을 Render 하기
    if FilterGraph.RenderFile(PFileName, nil) = S_OK then
    begin
      // 영상을 플레이할 패널 지정 Screen = Panel
      VideoWindow.put_Owner(OAHWND(DShowPanel.Handle));
      VideoWindow.put_WindowStyle(WS_CHILD or WS_CLIPSIBLINGS);
      VideoWindow.put_Width(DShowPanel.Width);
      VideoWindow.put_Height(DShowPanel.Height);
      VideoWindow.put_Top(0);
      VideoWindow.put_Left(0);

      // 이벤트 제어 연결하기
      MediaEvent.SetNotifyWindow(OAHWND(DShowPanel.Handle),
        WM_GRAPHEVENT, 0);
      MediaEvent.SetNotifyFlags(0);

      // 재생
      MediaControl.Run;
      SetVolume(0);
    end;
  end;
end;


procedure TDualOrder800_F.ImageTimerTimer(Sender: TObject);
var vFileName :String;
begin
  ImageTimer.Enabled := False;
  try
     if Common.DualData.Count = 0 then Exit;
     Common.DualIndex := Common.DualIndex + 1;
     if Common.DualData.Count = Common.DualIndex then
       Common.DualIndex := 0;
     vFileName := Common.DualData[Common.DualIndex];

    if not Assigned(DualImage) then
    begin
      ImageTimer.Interval := DelayTime * 1000;
      DualImage := TImage.Create(Self);
      DualImage.Parent := DShowPanel;
      DualImage.Stretch := true;
      DualImage.Align  := alClient;
    end;
    if FileExists(Common.AppPath+'Dual\'+vFileName) then
      DualImage.Picture.LoadFromFile(Common.AppPath+'Dual\'+vFileName);
  except
  end;
  ImageTimer.Enabled := True;
end;

procedure TDualOrder800_F.Dual_sGrdDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if Common.Member.Code = '' then
    Dual_sGrd.DefaultRowHeight    := Common.Config.DualGridRowHeight + 5
  else
    Dual_sGrd.DefaultRowHeight    := Common.Config.DualGridRowHeight;
end;

procedure TDualOrder800_F.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DShowPanel.WindowProc := VideoRenderOrgMethod;
  if Assigned(DualImage) then
    DualImage.Free;

  Action := caFree;
end;

procedure TDualOrder800_F.News_TmrTimer(Sender: TObject);
var I :Integer;
    vLabel :String;
begin
  News_Tmr.Enabled := False;
  if Common.Config.DualText = '' then Exit;
  FLabelPoint := FLabelPoint + 1;
  vLabel := Common.Config.DualText;
  if (Length(Common.Config.DualText)+85-FLabelPoint) <= 0 then FLabelPoint := 1;
  if FLabelPoint > 85 then
    vLabel := Copy(Common.Config.DualText,FLabelPoint-85,Length(Common.Config.DualText)-1);
  For I := 1 to 85-FLabelPoint do
    vLabel   := ' '+vLabel;
  MsgLabel.Caption := vLabel;
  News_Tmr.Enabled := True;
end;

function TDualOrder800_F.SetupDs: Boolean;
begin
  // DShow 를 초기화함
  Result := False;

  if Failed(CoCreateInstance(CLSID_FilterGraph, nil, CLSCTX_INPROC_SERVER,
    IID_IFilterGraph, FilterGraph)) then
      Exit; // 필터그래프를 생성한다.

  FilterGraph.QueryInterface(IID_IMediaControl, MediaControl);
  // 필터그래프의 인터페이스.
  FilterGraph.QueryInterface(IID_IVideoWindow, VideoWindow);

  // 동영상에 필요한 객체 생성
  if Failed(FilterGraph.QueryInterface(IID_IMediaEventEx, MediaEvent)) then
      Exit;
  if Failed(FilterGraph.QueryInterface(IID_IBasicAudio, BasicAudio)) then
      Exit;

  AvailableDS := true;
  Result := true;
end;

procedure TDualOrder800_F.SetVolume(Value: Integer);
var
    Vol : Integer;
begin
    // 볼륨 계산 0 은 최대 -10,000은 무음
    Vol := (100 - Value) * -100;
    BasicAudio.put_Volume(Vol);
end;

function TDualOrder800_F.ShutDownDs: Boolean;
begin
  // DShow 를 해제
  if Assigned(MediaControl) then
      MediaControl.Stop;

  If Assigned(VideoWindow) then
  Begin
    VideoWindow.put_Visible(False);
    VideoWindow.put_Owner(0);
  End;

  VideoWindow := nil;
  MediaControl := nil;
  MediaEvent := nil;
  BasicAudio := nil;
  FilterGraph := nil;

  Result := true;
end;

procedure TDualOrder800_F.VideoRenderWndProc(var Msg: TMessage);
var
    iEventCode: LongInt;
    iParam1, iParam2: LONG_PTR;
begin
  case Msg.Msg of
    WM_GRAPHEVENT:
      begin
        MediaEvent.GetEvent(iEventCode, iParam1, iParam2,
          100 { dwTimeout } );
        // 미디어가 완료되거나 에러일때 처리
        if (iEventCode = EC_COMPLETE) or (iEventCode = 14) then // EC_USERABORT) then
          AviTimer.Enabled := true;

        MediaEvent.FreeEventParams(iEventCode, iParam1, iParam2);
      end;
  else
    VideoRenderOrgMethod(Msg);
  end;
end;


end.
