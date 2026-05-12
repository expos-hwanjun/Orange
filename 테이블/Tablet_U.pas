unit Tablet_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxControls,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxLabel, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridCustomView, cxGrid, cxClasses, cxContainer, AdvGlassButton,
  dxWheelPicker, dxNumericWheelPicker, dxDateTimeWheelPicker, AdvSmoothButton,
  Vcl.ExtCtrls, dxGDIPlusClasses, AdvSmoothToggleButton, GDIPFill, Math, StrUtils,
  DateUtils, cxTextEdit, cxMaskEdit, cxSpinEdit, cxGroupBox, cxRadioGroup,
  AdvPanel, DelphiZXingQRCode, Vcl.WinXCalendars, cxCheckBox, MaskUtils, Data.DB,
  cxTimeEdit, Vcl.WinXCtrls, IdMultiPartFormData, IdHttp, BtnListB, System.JSON,
  AdvGlowButton,REST.Client,REST.Types, cxImage, ActiveX, CurvyControls,
  AdvGroupBox;

type
  TFloor = record
     Code        : String;       //층코드
     Name        : String;       //층명
     NumberSize  : Integer;      //테이블 Number Font 크기
     CaptionSize : Integer;      //테이블 Caption Font 크기
     TableNumberSize :Integer; //테이블 미주문시 테이블번호크기
     Color       : TColor;
     FontColor   : TColor;
  end;

type
  TTablet_F = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TcxButton;
    ImageCollection: TcxImageCollection;
    ImageCollectionItem1: TcxImageCollectionItem;
    ImageCollectionItem2: TcxImageCollectionItem;
    ImageCollectionItem3: TcxImageCollectionItem;
    ImageCollectionItem4: TcxImageCollectionItem;
    ImageCollectionItem5: TcxImageCollectionItem;
    TablePanel: TPanel;
    AdvSmoothButton2: TAdvSmoothButton;
    FloorPanel: TPanel;
    AdvSmoothButton1: TAdvSmoothButton;
    FloorDownButton: TAdvSmoothToggleButton;
    FloorUpButton: TAdvSmoothToggleButton;
    ImageCollectionItem6: TcxImageCollectionItem;
    ImageCollectionItem7: TcxImageCollectionItem;
    ImageCollectionItem8: TcxImageCollectionItem;
    SchedulePanel: TAdvPanel;
    CalendarView: TCalendarView;
    ConfirmButton: TAdvSmoothButton;
    CancelButton: TAdvSmoothButton;
    TabletWorkPanel: TAdvPanel;
    TableWorkCloseButton: TAdvGlowButton;
    AppRestartButton: TAdvGlowButton;
    PowerOffButton: TAdvGlowButton;
    BatteryStatusButton: TcxButton;
    ManagementButton: TcxButton;
    WaitTimer: TTimer;
    TabletManagementPanel: TAdvPanel;
    AllAppRestartButton: TAdvGlowButton;
    AllPowerOffButton: TAdvGlowButton;
    MenuUpdateButton: TAdvGlowButton;
    AdvGroupBox1: TAdvGroupBox;
    PaintBox: TPaintBox;
    QRPasswordEdit: TcxLabel;
    AuthNoEdit: TcxLabel;
    OnOffGroupBox: TAdvGroupBox;
    Label219: TLabel;
    Label220: TLabel;
    SunCheckBox: TcxCheckBox;
    MonCheckBox: TcxCheckBox;
    WedCheckBox: TcxCheckBox;
    TueCheckBox: TcxCheckBox;
    ThuCheckBox: TcxCheckBox;
    FriCheckBox: TcxCheckBox;
    SatCheckBox: TcxCheckBox;
    PowerOnTimeEdit: TcxTimeEdit;
    PowerOffTimeEdit: TcxTimeEdit;
    AllAppUpdateButton: TAdvGlowButton;
    AppUpdateButton: TAdvGlowButton;
    TimeManagementButton: TAdvGlowButton;
    ManageCloseButton: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure TableWorkCloseButtonClick(Sender: TObject);
    procedure AppRestartButtonClick(Sender: TObject);
    procedure BatteryStatusButtonClick(Sender: TObject);
    procedure ManagementButtonClick(Sender: TObject);
    procedure WaitTimerTimer(Sender: TObject);
    procedure MenuUpdateButtonClick(Sender: TObject);
    procedure AllPowerOffButtonClick(Sender: TObject);
    procedure AllAppRestartButtonClick(Sender: TObject);
    procedure TimeManagementButtonClick(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
    procedure AllAppUpdateButtonClick(Sender: TObject);
    procedure ManageCloseButtonClick(Sender: TObject);
  private
    FloorData : Array of TFloor;
    FloorButton   : array of TAdvSmoothToggleButton;
    FloorMaxCount,
    FloorButtonCount,
    FloorPageCount,
    FFloorPage,                                   //층 페이지번호
    FTablePageCount :Integer;
    FloorCode :String;
    DayOff    :String;
    QRCodeBitmap: TBitmap;
    AgentIP :String;

    SelectTableNo :Integer;
    Wifi_SID, Wifi_PWD, ShoppingCart :String;
    procedure TableCreate(aFloor:String);                         //테이블생성
    procedure SetFloorPage(AValue :Integer);
    procedure FloorButtonCreate;
    procedure SetFloorButton;
    procedure FloorButtonClick(Sender: TObject);
    procedure TabletButtonClick(Sender:TObject);
    property  FloorPage :Integer          read FFloorPage       write SetFloorPage;
    procedure SetQR;
  public
    FloorButtonHeight,
    FloorWidth : Integer;
  end;

var
  Tablet_F: TTablet_F;

implementation
uses Common_U, DBModule_U, GlobalFunc_U, Const_U;

{$R *.dfm}
procedure TTablet_F.FormCreate(Sender: TObject);
begin
  ClientWidth   := Common.Config.PosWidth;
  ClientHeight  := Common.Config.PosHeight;
  Common.LogoCreate(Self,1);
  FloorPanel.Enabled := not Common.Config.IsFloorFix;
  QRCodeBitmap    := TBitmap.Create;
end;

procedure TTablet_F.FormShow(Sender: TObject);
begin
  TablePanel.Width  := Self.Width  -  FloorWidth - 15;
  TablePanel.Height := Self.Height - TablePanel.Top  - 7;
  TablePanel.Left   :=  5;
  //층을 사용하면서 하단에 기능버튼 표시
  FloorPanel.Height    := Self.Height - FloorPanel.Top - 57;
  if Common.SendTabletMessage('cmd', 0, 'status') then
    ExecQuery('update MS_TABLE set TABLET_CHARGE = '''', TABLET_BATTERY = null, TABLET_WIFI = null',[]);
  WaitTimer.Enabled := true;
end;

procedure TTablet_F.WaitTimerTimer(Sender: TObject);
var vGetTime  : Cardinal;
    vExists   : Boolean;
begin
  WaitTimer.Enabled := false;
  vGetTime := GetTickCount;
  vExists  := false;
  while (vGetTime + 3000 > GetTickCount) and not vExists do
  begin
    Common.ShowWaitForm('태블릿 상태를 조회 중입니다');
    OpenQuery('select Count(*) '
             +'  from MS_TABLE '
             +' where CD_STORE =:P0 '
             +'   and TABLET_BATTERY > 0 ',
             [Common.Config.StoreCode]);
    if Common.Query.Fields[0].AsInteger > 0 then
    begin
      vExists := true;
      Sleep(1000);
      Common.Query.Close;
    end
    else
    begin
      Sleep(500);
      Common.Query.Close;
    end;
  end;

  Common.HideWaitForm;
  FloorButtonCreate;
end;


procedure TTablet_F.BatteryStatusButtonClick(Sender: TObject);
begin
  TableCreate(FloorCode);
end;

procedure TTablet_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TTablet_F.FloorButtonClick(Sender: TObject);
var vIndex, vFloorIndex :Integer;
begin
  if Sender <> nil then
  begin
    vFloorIndex := ((FloorPage-1)*FloorButtonCount)+(Sender as TAdvSmoothToggleButton).Tag;
    if (Sender as TAdvSmoothToggleButton).Caption = EmptyStr then Exit;

    for vIndex := Low(FloorButton) to High(FloorButton) do
    begin
      FloorButton[vIndex].Down       := false;
      FloorButton[vIndex].Appearance.Font.Color := clBlack;
    end;

    FloorButton[vFloorIndex].Down       := true;
    FloorButton[vFloorIndex].Appearance.Font.Color := clWhite;
  end;

  TableCreate(FloorButton[vFloorIndex].Hint);
end;

procedure TTablet_F.FloorButtonCreate;
var vIndex,
    vTop :Integer;
begin
  Common.Table.Floor := '000';
  OpenQuery('select * '
           +'  from MS_CODE  '
           +' where CD_STORE=:P0 '
           +'   and CD_KIND = ''03'' '
           +'   and DS_STATUS=0 '
           +' order by CD_CODE',
           [Common.Config.StoreCode]);

  SetLength(FloorData, Common.Query.RecordCount);
  vIndex := 0;
  while not Common.Query.Eof do
  begin
    FloorData[vIndex].Code        := Common.Query.FieldByName('CD_CODE').AsString;
    FloorData[vIndex].Name        := Common.Query.FieldByName('NM_CODE1').AsString;
    FloorData[vIndex].NumberSize  := StrToIntDef(Common.Query.FieldByName('NM_CODE2').AsString,6);
    FloorData[vIndex].CaptionSize := StrToIntDef(Common.Query.FieldByName('NM_CODE3').AsString,6);
    FloorData[vIndex].Color       := $00D26900;//Common.Query.FieldByName('NM_CODE7').AsString;
    FloorData[vIndex].FontColor   := clWhite;// Common.Query.FieldByName('NM_CODE9').AsString;
    FloorData[vIndex].TableNumberSize  := StrToIntDef(Common.Query.FieldByName('NM_CODE10').AsString,11);
    if FloorData[vIndex].TableNumberSize > 100 then
      FloorData[vIndex].TableNumberSize := 11;



    if FloorData[vIndex].NumberSize  > 20 then Common.FloorData[vIndex].NumberSize  := 9;
    if FloorData[vIndex].CaptionSize > 20 then Common.FloorData[vIndex].CaptionSize := 9;
    Common.Query.Next;
    Inc(vIndex);
  end;
  Common.Query.Close;

  FloorPanel.Width    := FloorWidth;
  FloorPanel.Left     := Self.Width - FloorWidth - 7;

  if GetOption(58) = '1' then
  begin
    FloorUpButton.Visible   := false;
    FloorDownButton.Visible := false;
    FloorPanel.Visible      := false;
    TablePanel.Width        := Self.Width  - 13;
    TableCreate('001');
    Exit;
  end;


  FloorMaxCount := High(FloorData)+1;

  //한페이지 이내일때 이전 다음버튼 안보이게
  if (FloorPanel.Height div  (FloorButtonHeight+2)) >= FloorMaxCount then
  begin
    FloorButtonCount        := FloorPanel.Height div  (FloorButtonHeight+2);
    FloorUpButton.Visible   := false;
    FloorDownButton.Visible := false;
  end
  else
  begin
    FloorUpButton.Visible   := true;
    FloorDownButton.Visible := true;
    //한페이지에 표시버튼 갯수
    FloorButtonCount := FloorPanel.Height  div  (FloorButtonHeight+2);
    //층총 페이지 계산
    FloorPageCount := FloorMaxCount div FloorButtonCount;
    if (FloorMaxCount Mod FloorButtonCount) > 0 then
      FloorPageCount := FloorPageCount + 1;

    if FloorPageCount > 1 then
      FloorButtonCount := FloorButtonCount - 1;

    FloorUpButton.Height    := FloorButtonHeight;
    FloorDownButton.Height  := FloorButtonHeight;

    FloorUpButton.Top     := FloorPanel.Height - FloorUpButton.Height -1;
    FloorDownButton.Top   := FloorPanel.Height - FloorUpButton.Height -1;
    FloorUpButton.Width   := FloorPanel.Width div 2 - 1;
    FloorDownButton.Width := FloorPanel.Width div 2 - 1;
    FloorDownButton.Left  := FloorUpButton.Left + FloorUpButton.Width;
  end;

  SetLength(FloorButton, FloorButtonCount);
  vTop := 2;
  for vIndex := Low(FloorButton) to High(FloorButton) do
  begin
    FloorButton[vIndex] := TAdvSmoothToggleButton.Create(Self);
    with FloorButton[vIndex] do
    begin
      Name        := Format('Floor%dButton',[vIndex]);
      Parent      := FloorPanel;
      Color       := clWhite;
      BorderColor := $00D26900;
      BorderInnerColor := $00D26900;
      ColorDown   := $00D26900;
      BevelWidth  := 0;
      Appearance.SimpleLayout := true;

      Font.Name   := '맑은 고딕';
      Font.Size   := 20;
      Cursor      := crHandPoint;
      Top         := vTop;
      Width       := FloorPanel.Width-2;
      Height      := FloorButtonHeight;
      Left        := 0;
      Tag         := vIndex;
      OnClick     := FloorButtonClick;
      Visible     := false;
      vTop        := vTop + FloorButtonHeight + 1;
    end;
  end;

  if FloorPageCount > 1 then
  begin
    FloorUpButton.Visible   := true;
    FloorDownButton.Visible := true;
  end;
  FloorPage := 1;

end;

procedure TTablet_F.SetFloorButton;
var vIndex :Integer;
    vBtton :TAdvSmoothToggleButton;
    vFirst :Boolean;
begin
  vFirst :=true;
  For vIndex := 0 to FloorButtonCount-1 do
  begin
    TAdvSmoothToggleButton(FindComponent(Format('Floor%dButton',[vIndex]))).Hint    := '';
    TAdvSmoothToggleButton(FindComponent(Format('Floor%dButton',[vIndex]))).Caption := '';
    TAdvSmoothToggleButton(FindComponent(Format('Floor%dButton',[vIndex]))).Visible := false;
  end;

  For vIndex := 0  to FloorButtonCount-1 do
  begin
    if ( ((FloorPage-1)*FloorButtonCount) + vIndex ) >= FloorMaxCount then Continue;
    if vFirst then
    begin
      vBtton := TAdvSmoothToggleButton(FindComponent(Format('Floor%dButton',[vIndex])));
      vFirst := false;
    end;

    TAdvSmoothToggleButton(FindComponent(Format('Floor%dButton',[vIndex]))).Hint    := Common.FloorData[((FloorPage-1)*FloorButtonCount)+vIndex].Code;
    TAdvSmoothToggleButton(FindComponent(Format('Floor%dButton',[vIndex]))).Caption := Common.FloorData[((FloorPage-1)*FloorButtonCount)+vIndex].Name;
    TAdvSmoothToggleButton(FindComponent(Format('Floor%dButton',[vIndex]))).Visible := true;
  end;

  //바뀐 페이지에 선택된 테이블이 있는지 체크한다
  FloorButtonClick(vBtton);
end;

procedure TTablet_F.SetFloorPage(AValue: Integer);
begin
  FFloorPage              := AValue;
  FloorUpButton.Enabled   := FloorPage > 1;
  FloorDownButton.Enabled := FloorPage < FloorPageCount;
  SetFloorButton;
end;

procedure TTablet_F.SetQR;
var
  vQRCode: TDelphiZXingQRCode;
  vRow, vColumn: Integer;
  vTarget,
  vURL :String;
begin
  vQRCode := TDelphiZXingQRCode.Create;
  try
    if LeftStr(Common.Config.StoreCode,2) = 'TT' then
      vTarget := 'qa'
    else
      vTarget := '';

    vURL := Format('{"HeadStore":"%s","StoreCode":"%s","Server":"%s","Password":"%s","AuthCode":"%s"}',
                  [Common.Config.HeadStoreCode, Common.Config.StoreCode, vTarget, QRPasswordEdit.Caption,AuthNoEdit.Caption]);
    vQRCode.Data := vURL;

    vQRCode.Encoding := TQRCodeEncoding(0);
    vQRCode.QuietZone := 4;
    QRCodeBitmap.SetSize(vQRCode.Rows, vQRCode.Columns);
    for vRow := 0 to vQRCode.Rows - 1 do
    begin
      for vColumn := 0 to vQRCode.Columns - 1 do
      begin
        if (vQRCode.IsBlack[vRow, vColumn]) then
        begin
          QRCodeBitmap.Canvas.Pixels[vColumn, vRow] := clBlack;
        end else
        begin
          QRCodeBitmap.Canvas.Pixels[vColumn, vRow] := clWhite;
        end;
      end;
    end;
  finally
    vQRCode.Free;
  end;
  PaintBox.Repaint;
end;

procedure TTablet_F.TableCreate(aFloor:String);
  procedure TableButtonDelete;
  var vIndex :Integer;
  label go;
  begin
    go:
    For vIndex := 0 to ComponentCount-1 do
    begin
      if (Components[vIndex] is TAdvSmoothButton) and
         ( (Components[vIndex] as TAdvSmoothButton).Parent = TablePanel ) then
      begin
        (Components[vIndex] as TAdvSmoothButton).Free;
        Goto go;
      end;
    end;
  end;
var
    vTableButton :TAdvSmoothButton;
    vLogin :String;
begin
  //층이 없을때
  if High(FloorData) < 0 then Exit;
  FloorCode := aFloor;
  //기존 테이블 버튼 모두삭제
  TableButtonDelete;
  //저장된 테이블 내역 불러오기
  try
    DM.OpenCloud('select NO_TABLE, '
                +'       DT_LOGIN '
                +'  from TABLET_AUTH '
                +' where CD_COMPANY  =:P0 '
                +'   and CD_CUSTOMER =:P1 '
                +'   and Date_Format(Now(), ''%Y%m%d'') = Date_Format(DT_LOGIN, ''%Y%m%d'') ',
                [Common.Config.HeadStoreCode,
                 Common.Config.StoreCode], RestBaseURL);

    OpenQuery('select SEQ, '
             +'       NO_TOP, '
             +'       NO_LEFT, '
             +'       NO_HEIGHT, '
             +'       NO_WIDTH, '
             +'       NO_TABLE, '
             +'       NM_TABLE, '
             +'       TABLET_CHARGE, '
             +'       Ifnull(TABLET_BATTERY,-1) as TABLET_BATTERY, '
             +'       Ifnull(TABLET_WIFI,0) as TABLET_WIFI, '
             +'       YN_TABLET, '
             +'       case when Date_Format(TABLET_SYNC, ''%Y%m%d'') =  Date_Format(Now(), ''%Y%m%d'') then ''Y'' else ''N'' end as YN_LOGIN, '
             +'       Ifnull(TIMESTAMPDIFF(MINUTE,  TABLET_SYNC, Now() ),1000) as TABLET_SYNC '
             +'  from MS_TABLE   '
             +' where CD_STORE =:P0 '
             +'   and CD_FLOOR =:P1 '
             +'   and SEQ      =0 '
             +'   and YN_PACKING = ''N'' '
             +'   and YN_TABLET <> ''N'' '
             +' order by NO_TABLE ',
             [Common.Config.StoreCode,
              aFloor]);
  except
    on E: Exception do
    begin
      Common.WriteLog('TableCreate',E.Message);
      Common.ErrBox(E.Message);
      Exit;
    end;
  end;

  FTablePageCount := 1;
  while not Common.Query.Eof do
  begin
//    vLogin := Common.Query.FieldByName('YN_LOGIN').AsString;
//    //인증서버에만 로그인정보가 있을때
//    if not DM.CloudData.Eof and (vLogin = 'N') and DM.CloudData.Locate('NO_TABLE', Common.Query.FieldByName('NO_TABLE').AsString, [loCaseInsensitive]) then
//    begin
//      ExecQuery('update MS_TABLE '
//               +'  set TABLET_SYNC = :P2 '// Cast(:P2 as DateTime) '
//               +'where CD_STORE =:P0 '
//               +'  and NO_TABLE =:P1 ',
//               [Common.Config.StoreCode,
//                Common.Query.FieldByName('NO_TABLE').AsInteger,
//                DM.CloudData.FieldByName('DT_LOGIN').AsDateTime]);
//      vLogin := 'Y';
//    end;

    vTableButton := TAdvSmoothButton.Create(Self);
    with vTableButton do
    begin
      if Common.Query.FieldByName('SEQ').AsInteger = 0 then
        Name             := Format('Table%d',[Common.Query.FieldByName('NO_TABLE').AsInteger])
      else
        Name             := Format('Wall%d',[Common.Query.FieldByName('SEQ').AsInteger]);


      Parent           := TablePanel;

      Status.Visible := true;
      Status.Appearance.Fill.Color   := clWhite;
      Status.Appearance.Fill.ColorTo := clWhite;
      Status.Appearance.Fill.BorderColor := clGray;
      Status.Appearance.Font.Color   := clBlack;
      Status.Appearance.Font.Size    := 15;
      Status.Appearance.Font.Name    := '맑은 고딕';

      Appearance.Font.Size  := 20;

      if GetOption(25) = '1' then
      begin
        Status.Caption := Common.Query.FieldByName('NM_TABLE').AsString;

        if Status.Caption = '' then
          Status.Caption := Common.Query.FieldByName('NO_TABLE').AsString;
      end
      else
        Status.Caption := Common.Query.FieldByName('NO_TABLE').AsString;

      Tag                 := Common.Query.FieldByName('NO_TABLE').AsInteger;
      Top                 := Common.Query.FieldByName('NO_TOP').AsInteger;
      Left                := Common.Query.FieldByName('NO_LEFT').AsInteger;
      Height              := Common.Query.FieldByName('NO_HEIGHT').AsInteger;
      Width               := Common.Query.FieldByName('NO_WIDTH').AsInteger;

      Appearance.Layout             := blPictureTop;
      Appearance.PictureAlignment   := taCenter;
      Appearance.SimpleLayout       := true;
      Status.Appearance.Fill.PicturePosition := TFillPicturePosition.ppCustom;
      if (Common.Query.FieldByName('TABLET_WIFI').AsInteger = 0) or (Common.Query.FieldByName('TABLET_WIFI').AsInteger > 70) then
        Status.Appearance.Fill.Picture.Assign(ImageCollection.Items.Items[0].Picture.Graphic)
      else
        Status.Appearance.Fill.Picture.Assign(ImageCollection.Items.Items[1].Picture.Graphic);

      //배터리 이미지
      Color     := $00DDFFDD;
      Caption   := Format('%d%%',[Common.Query.FieldByName('TABLET_BATTERY').AsInteger]);
      if Common.Query.FieldByName('YN_TABLET').AsString = 'N' then
      begin
        Picture := nil;// Assign(ImageCollection.Items.Items[5].Picture.Graphic);
        Status.Appearance.Fill.Picture := nil;
        Appearance.Font.Size    := 12;
        Color     := clGray;
        Caption   := '미설치';
      end
      else if Common.Query.FieldByName('YN_TABLET').AsString = 'B' then
      begin
        Picture.Assign(ImageCollection.Items.Items[5].Picture.Graphic);
        Status.Appearance.Fill.Picture := nil;
        Appearance.Font.Size    := 12;
        Color     := clGray;
        Caption   := '고장';
      end
      else if Common.Query.FieldByName('TABLET_BATTERY').AsInteger = -1 then
      begin
        Caption   := 'OffLine';
        Picture.Assign(ImageCollection.Items.Items[5].Picture.Graphic);
        Color     := $006666FF;
        Status.Appearance.Fill.Picture := nil;
      end
      else if Common.Query.FieldByName('TABLET_BATTERY').AsInteger = 100 then
      begin
        if Common.Query.FieldByName('TABLET_CHARGE').AsString = 'Y' then
          Picture.Assign(ImageCollection.Items.Items[6].Picture.Graphic)
        else
          Picture.Assign(ImageCollection.Items.Items[2].Picture.Graphic);
      end
      else if (Common.Query.FieldByName('TABLET_BATTERY').AsInteger > 50) and  (Common.Query.FieldByName('TABLET_BATTERY').AsInteger < 100) then
      begin
        if Common.Query.FieldByName('TABLET_CHARGE').AsString = 'Y' then
          Picture.Assign(ImageCollection.Items.Items[6].Picture.Graphic)
        else
          Picture.Assign(ImageCollection.Items.Items[3].Picture.Graphic);
      end
      else if (Common.Query.FieldByName('TABLET_BATTERY').AsInteger > 0) and  (Common.Query.FieldByName('TABLET_BATTERY').AsInteger < 50) then
      begin
        if Common.Query.FieldByName('TABLET_CHARGE').AsString = 'Y' then
          Picture.Assign(ImageCollection.Items.Items[4].Picture.Graphic)
        else
          Picture.Assign(ImageCollection.Items.Items[7].Picture.Graphic);
        Color     := $009999FF;
      end;

      ShowFocus := false;
      Shadow    := true;

      //원형테이블일때는 가로 세로 중 작은 거에 1/2
      if Appearance.Rounding = 50 then
      begin
        if Height < Width then
          Appearance.Rounding := (Height-16) div 2
        else
          Appearance.Rounding := (Width-16) div 2;
      end;
      OnClick := TabletButtonClick;
    end;
    Common.Query.Next;
  end;
  Common.Query.Close;
  DM.CloudData.Close;

  DM.OpenCloud('select a.NO_TABLE, '
              +'       a.NO_UUID '
              +'  from TABLET_AUTH a INNER join '
              +'      (select Max(DT_LOGIN) as DT_LOGIN, '
              +'              NO_TABLE '
              +'         from TABLET_AUTH '
              +'        where CD_COMPANY  =:P0 '
              +'          and CD_CUSTOMER =:P1 '
              +'        group by NO_TABLE) as b ON b.NO_TABLE = a.NO_TABLE '
              +'                               and b.DT_LOGIN = a.DT_LOGIN '
              +' where a.CD_COMPANY  =:P0 '
              +'   and a.CD_CUSTOMER =:P1 '
              +'   and a.YN_RESTART  =''Y'' ',
             [Common.Config.HeadStoreCode,
              Common.Config.StoreCode], RestBaseURL);

  while not DM.CloudData.Eof do
  begin
    TAdvSmoothButton(FindComponent(Format('Table%d',[DM.CloudData.FieldByName('NO_TABLE').AsInteger]))).Caption := TAdvSmoothButton(FindComponent(Format('Table%d',[DM.CloudData.FieldByName('NO_TABLE').AsInteger]))).Caption + '(R)';
    DM.CloudData.Next;
  end;
  DM.CloudData.Close;

end;

procedure TTablet_F.TabletButtonClick(Sender: TObject);
begin
  TabletWorkPanel.Top     := Self.Height div 2 - TabletWorkPanel.Height div 2;
  TabletWorkPanel.Left    := Self.Width div 2 - TabletWorkPanel.Width div 2;
  TabletWorkPanel.Visible := true;
  SelectTableNo := (Sender as TAdvSmoothButton).Tag;
end;

procedure TTablet_F.TableWorkCloseButtonClick(Sender: TObject);
begin
  TabletWorkPanel.Visible := false;
end;

procedure TTablet_F.TimeManagementButtonClick(Sender: TObject);
var vWeek, vSchedule :String;
    vJsonObject : TJSONObject;
begin
  vWeek := Ifthen(MonCheckBox.Checked,'1','0')
         + Ifthen(TueCheckBox.Checked,'1','0')
         + Ifthen(WedCheckBox.Checked,'1','0')
         + Ifthen(ThuCheckBox.Checked,'1','0')
         + Ifthen(FriCheckBox.Checked,'1','0')
         + Ifthen(SatCheckBox.Checked,'1','0')
         + Ifthen(SunCheckBox.Checked,'1','0');

  //요일이 지정됐으면 최소시간을 체크한다
  if vWeek <> '0000000' then
  begin
    if Abs(MinutesBetween(PowerOnTimeEdit.Time, PowerOffTimeEdit.Time)) < 1 then
    begin
      Common.MsgBox('전원 ON/OFF 예약은 최소 1분 이상이어합니다');
      Exit;
    end;
  end;                           //   10.10.20.3 /10.10.20.254/255.2552.255.0 168.126.63.1

  vJSONObject := TJSONObject.Create;
  vJSONObject.AddPair('power_week',  TJSONString.Create(vWeek));
  vJSONObject.AddPair('poweron_time',  TJSONString.Create(PowerOnTimeEdit.Text));
  vJSONObject.AddPair('poweroff_time',  TJSONString.Create(PowerOffTimeEdit.Text));
  vJSONObject.AddPair('holiday',  TJSONString.Create(DayOff));
  vJSONObject.AddPair('wifi_sid',  TJSONString.Create(Wifi_SID));
  vJSONObject.AddPair('wifi_pwd',  TJSONString.Create(Wifi_PWD));
  vJSONObject.AddPair('shoppingcart',  TJSONString.Create(ShoppingCart));
  vJSONObject.AddPair('pos_ip',  TJSONString.Create(AgentIP));

  DM.ExecCloud('update MS_STORE_ETC '
              +'   set TABLET_SCHEDULE =:P2 '
              +' where CD_HEAD  =:P0 '
              +'   and CD_STORE =:P1; '
              +'update MS_STORE '
              +'   set DT_CHANGE =Now() '
              +' where CD_HEAD  =:P0 '
              +'   and CD_STORE =:P1; ',
              [Common.Config.HeadStoreCode,
               Common.Config.StoreCode,
               vJSONObject.ToJSON],true, Common.RestDBURL);
  vSchedule := Format('week:%s,on:%s,off:%s',[vWeek,PowerOnTimeEdit.Text,PowerOffTimeEdit.Text]);
  Common.SendTabletMessage('schedule', 0, vSchedule);
end;

procedure TTablet_F.ManageCloseButtonClick(Sender: TObject);
begin
  TabletManagementPanel.Visible := false;
end;

procedure TTablet_F.ManagementButtonClick(Sender: TObject);
var vJsonObject : TJSONObject;
    vTemp :String;
    vRetryCount :Integer;
label retry;
begin
  vRetryCount := 0;
retry:
  DM.OpenCloud('select TABLET_SCHEDULE, '
              +'       SubStr(RegExp_Replace(Upper(To_Base64(Aes_Encrypt(:P1,71483))), ''[^0-9A-Z]'', ''''), 1, 4) as AUTH_NO, '
              +'       QR_PASSWORD '
              +'  from MS_STORE_ETC '
              +' where CD_HEAD  =:P0 '
              +'   and CD_STORE =:P1 ',
              [Common.Config.HeadStoreCode,
               Common.Config.StoreCode],Common.RestDBURL);
  AuthNoEdit.Caption := '';
  if not DM.CloudData.Eof then
  begin
    vJSONObject               := TJSONObject.ParseJSONValue( DM.CloudData.FieldByName('TABLET_SCHEDULE').AsString ) as TJSONObject;

    vJSONObject.TryGetValue<String>('power_week', vTemp);
    MonCheckBox.Checked := Copy(vTemp,1,1) = '1';
    TueCheckBox.Checked := Copy(vTemp,2,1) = '1';
    WedCheckBox.Checked := Copy(vTemp,3,1) = '1';
    ThuCheckBox.Checked := Copy(vTemp,4,1) = '1';
    FriCheckBox.Checked := Copy(vTemp,5,1) = '1';
    SatCheckBox.Checked := Copy(vTemp,6,1) = '1';
    SunCheckBox.Checked := Copy(vTemp,7,1) = '1';

    vJSONObject.TryGetValue<String>('poweron_time', vTemp);
    if vTemp = '' then
      PowerOnTimeEdit.Text  := '00:00'
    else
      PowerOnTimeEdit.Text  := vTemp;

    vJSONObject.TryGetValue<String>('poweroff_time', vTemp);
    if vTemp = '' then
      PowerOffTimeEdit.Text  := '00:00'
    else
      PowerOffTimeEdit.Text  := vTemp;

    vJSONObject.TryGetValue<String>('poweroff_time', vTemp);
    if vTemp = '' then
      PowerOffTimeEdit.Text  := '00:00'
    else
      PowerOffTimeEdit.Text  := vTemp;

    vJSONObject.TryGetValue<String>('wifi_sid', Wifi_SID);
    vJSONObject.TryGetValue<String>('wifi_pwd', Wifi_PWD);
    vJSONObject.TryGetValue<String>('shoppingcart', ShoppingCart);
    vJSONObject.TryGetValue<String>('holiday', DayOff);
    vJSONObject.TryGetValue<String>('pos_ip', AgentIP);
    AuthNoEdit.Caption     := DM.CloudData.Fields[1].AsString;
    QRPasswordEdit.Caption := DM.CloudData.Fields[2].AsString;
    DM.CloudData.Close;
  end;
  if (AuthNoEdit.Caption = '') and (vRetryCount < 2) then
  begin
    DM.CloudData.Close;
    Inc(vRetryCount);
    goto retry;
  end;
  if AuthNoEdit.Caption <> '' then
    SetQR;
  TabletManagementPanel.Left    := Self.Width div 2 - TabletManagementPanel.Width div 2;
  TabletManagementPanel.Top     := Self.Height div 2 - TabletManagementPanel.Height div 2;
  TabletManagementPanel.Visible := true;
end;

procedure TTablet_F.MenuUpdateButtonClick(Sender: TObject);
begin
  if Common.SendTabletMessage('cmd', 0,  'menu-update') then
    Common.MsgBox('전송이 완료되었습니다');
end;

procedure TTablet_F.PaintBoxPaint(Sender: TObject);
var
  Scale: Double;
begin
  PaintBox.Canvas.Brush.Color := clWhite;
  PaintBox.Canvas.FillRect(Rect(0, 0, PaintBox.Width, PaintBox.Height));
  if ((QRCodeBitmap.Width > 0) and (QRCodeBitmap.Height > 0)) then
  begin
    if (PaintBox.Width < PaintBox.Height) then
    begin
      Scale := PaintBox.Width / QRCodeBitmap.Width;
    end else
    begin
      Scale := PaintBox.Height / QRCodeBitmap.Height;
    end;
    PaintBox.Canvas.StretchDraw(Rect(0, 0, Trunc(Scale * QRCodeBitmap.Width), Trunc(Scale * QRCodeBitmap.Height)), QRCodeBitmap);
  end;
end;

procedure TTablet_F.AllAppRestartButtonClick(Sender: TObject);
begin
  if Common.SendTabletMessage('cmd', 0,  'app-restart') then
    Common.MsgBox('전송이 완료되었습니다');
end;

procedure TTablet_F.AllAppUpdateButtonClick(Sender: TObject);
begin
  if not Common.AskBox('전 태블릿 앱을 업데이트'+#13+'하시겠습니까?') then Exit;
  if Common.SendTabletMessage('cmd',0, 'app-update') then
    Common.MsgBox('전송이 완료되었습니다');
end;

procedure TTablet_F.AllPowerOffButtonClick(Sender: TObject);
begin
  if not Common.AskBox('전 태블릿 전원을'#13'종료하시겠습니까?') then Exit;
  if Common.SendTabletMessage('cmd',0, 'power-off') then
    Common.MsgBox('전송이 완료되었습니다');
end;

procedure TTablet_F.AppRestartButtonClick(Sender: TObject);
begin
  if Sender = AppRestartButton then
    Common.SendTabletMessage('cmd', SelectTableNo,  'app-restart')
  else if Sender = PowerOffButton then
    Common.SendTabletMessage('cmd', SelectTableNo, 'power-off')
  else if Sender = AppUpdateButton then
    Common.SendTabletMessage('cmd', SelectTableNo, 'app-update');

  TabletWorkPanel.Visible := false;
end;


end.
