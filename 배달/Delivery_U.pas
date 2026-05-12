unit Delivery_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, cxLookAndFeelPainters, ExtCtrls,
  StdCtrls, cxButtons, cxControls,
  cxContainer, cxEdit, cxLabel, Grids, cxTextEdit, cxCurrencyEdit, DB,
  MaskUtils, StrUtils, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxPC, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, ShellAPI,
  cxGridDBTableView, cxGrid, cxGridBandedTableView, cxGridDBBandedTableView,
  MemDS, DBAccess, Uni, Common_U, cxLookAndFeels, cxPCdxBarPopupMenu, Math,
  cxGroupBox, dxBarBuiltInMenu, cxNavigator, Vcl.ComCtrls, dxCore, cxDateUtils,
  AdvGlassButton, PosButton, dxGDIPlusClasses, AdvSmoothToggleButton,
  Vcl.WinXCalendars, dxmdaset, AdvGlowButton, dxDateRanges,
  dxScrollbarAnnotations;

// 주문번호 - Temp1
// 고객명   - Number.LeftStr
// 주문시간 - Number.RightStr
// 상태     - Bottom.LeftStr
// 주문구분 - Bottom.CenterStr
// 배달담당 - Bottom.RightStr
// 주문메뉴 - Caption.Catption
// 주문금액 - Amount.Caption
// 테이블번호 - Number.Number
// 주문일자   - Temp2

type TMsnData = record
     Number :String;
     Date   :TDate;
end;


type
  TDeliveryData = record
    DeliveryNo :String;      //배달번호
    OrderDate  :String;      //주문일자
    TableNo    :Integer;     //테이블번호
    Customer   :String;      //고객명
    OrderTime  :String;      //주문시간
    OrderMenu  :String;      //주문메뉴
    OrderMenuQty :String;
    OrderAmt   :String;      //주문금액
    Step       :String;      //진행상태
    dsOrder    :String;      //배달or포장구분
    Damdang    :String;      //배달담당자
    TelNo1     :String;
    TelNo2     :String;
    TelNo3     :String;
    TelNo4     :String;
    Addr1      :String;
    Addr2      :String;
    PhoneNumber:String;      //부재중전화
    LapseTime  :String;
    LocalCode  :String;
    LocalName  :String;
    CourseCode :String;
    CourseName :String;
end;

type TCallStep     = (csNone, csCall);

type
  TDelivery_F = class(TForm)
    Timer1: TTimer;
    Timer2: TTimer;
    Tmr_Exec: TTimer;
    Notebook1: TNotebook;
    SubDataSource: TDataSource;
    cxPageControl1: TcxPageControl;
    DataSource: TDataSource;
    cxStyleRepository1: TcxStyleRepository;
    RedFontStyle: TcxStyle;
    Grid: TcxGrid;
    bvGridView: TcxGridDBBandedTableView;
    bvGridViewColumn1: TcxGridDBBandedColumn;
    bvGridViewColumn2: TcxGridDBBandedColumn;
    bvGridViewColumn3: TcxGridDBBandedColumn;
    bvGridViewStep: TcxGridDBBandedColumn;
    bvGridViewColumn5: TcxGridDBBandedColumn;
    bvGridViewOrderAmt: TcxGridDBBandedColumn;
    bvGridViewColumn7: TcxGridDBBandedColumn;
    bvGridViewColumn8: TcxGridDBBandedColumn;
    bvGridViewColumn9: TcxGridDBBandedColumn;
    bvGridViewColumn11: TcxGridDBBandedColumn;
    bvGridViewColumn12: TcxGridDBBandedColumn;
    bvGridViewColumn13: TcxGridDBBandedColumn;
    bvGridViewColumn14: TcxGridDBBandedColumn;
    bvGridViewColumn15: TcxGridDBBandedColumn;
    GridLevel1: TcxGridLevel;
    GridLevel2: TcxGridLevel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    BlueFontStyle: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle1: TcxStyle;
    panCall: TPanel;
    lblCallStatus: TcxLabel;
    lblCallNo: TcxLabel;
    lblCallCustName: TcxLabel;
    lblCallLine: TcxLabel;
    GridLevel3: TcxGridLevel;
    gvMenuGridView: TcxGridDBTableView;
    gvMenuGridViewMenuCode: TcxGridDBColumn;
    gvMenuGridViewMenuName: TcxGridDBColumn;
    gvMenuGridViewQty: TcxGridDBColumn;
    gvMenuGridViewPrice: TcxGridDBColumn;
    gvMenuGridViewSaleAmt: TcxGridDBColumn;
    bvGridViewColumn4: TcxGridDBBandedColumn;
    ButtonPanel: TPanel;
    NewButton: TAdvGlassButton;
    OrderButton: TAdvGlassButton;
    ReprintButton: TAdvGlassButton;
    DeliveryGoButton: TAdvGlassButton;
    DishReturnButton: TAdvGlassButton;
    DeleteButton: TAdvGlassButton;
    NotTelButton: TAdvGlassButton;
    DishListButton: TAdvGlassButton;
    DeliveryListButton: TAdvGlassButton;
    TakeOutButton: TAdvGlassButton;
    CaptionLabel: TLabel;
    Info1Panel: TPanel;
    OrderLabel: TLabel;
    Image1: TImage;
    Info1NameLabel: TLabel;
    CallCancelButton: TcxButton;
    Info2Panel: TPanel;
    DeliveryCountLabel: TLabel;
    Info2NameLabel: TLabel;
    MissedCallLabel: TLabel;
    MissedCallCountLabel: TLabel;
    CloseButton: TcxButton;
    FromDatePicker: TCalendarPicker;
    ToDatePicker: TCalendarPicker;
    SearchButton: TAdvGlassButton;
    TelGridView: TcxGridTableView;
    TelGridViewColumn1: TcxGridColumn;
    TelGridViewColumn2: TcxGridColumn;
    TelGridViewColumn3: TcxGridColumn;
    TelGridViewColumn4: TcxGridColumn;
    TablePanel: TPanel;
    MessageLabel: TLabel;
    MessageImage: TImage;
    lblPage: TLabel;
    PriorButton: TAdvGlassButton;
    NextButton: TAdvGlassButton;
    CashBoxOpenButton: TAdvGlassButton;
    RcpManagerTimer: TTimer;
    procedure obtn_closeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure Tmr_ExecTimer(Sender: TObject);
    procedure Notebook1PageChanged(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bvGridViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure dteToPropertiesChange(Sender: TObject);
    procedure imgCallClick(Sender: TObject);
    procedure NewButtonClick(Sender: TObject);
    procedure OrderButtonClick(Sender: TObject);
    procedure ReprintButtonClick(Sender: TObject);
    procedure DeliveryGoButtonClick(Sender: TObject);
    procedure DishReturnButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure NotTelButtonClick(Sender: TObject);
    procedure DishListButtonClick(Sender: TObject);
    procedure TakeOutButtonClick(Sender: TObject);
    procedure DeliveryListButtonClick(Sender: TObject);
    procedure CallCancelButtonClick(Sender: TObject);
    procedure PriorButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure CashBoxOpenButtonClick(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure RcpManagerTimerTimer(Sender: TObject);
  private
    FCallStep     : TCallStep;
    isTableCreated :Boolean;
    FXcnt,
    FYCnt,
    FNumberFontSize,
    FCaptionFontSize,
    FMenuFontSize,
    FAmountFontSize,
    FBottomFontSize:Integer;
    FColor1,             //미주문
    FColor2,             //주문
    FColor3,             //배달
    FColor4,             //계산완료
    FColor5,             //Border
    FColor6 : TColor;    //글자색상

    //페이지관련
    FPage      :Integer;

    CallTelNo  : String;
    MemData    : TdxMemData;
    SubMemData : TdxMemData;
    procedure TableCreate;                         //테이블생성
    procedure SetTableVisible;
    procedure SetDeliveryData(aMaxPage:Boolean=true);
    procedure SetOrderTable;                       //주문내역을 테이블에 표시한다
    procedure SetPage(const Value: Integer);
    property  Page :Integer read FPage write SetPage;
    procedure CidReadEvent(const S : String);
    function  GetUseCheck(aDeliveryNo:String):Boolean;
    function  GetDeliveryOrderDataIndex(aData: String): Integer;
    function  GetMaxPage:Integer;
    procedure SetCustomerInfo(aValue:String);
    procedure SetCallStep(AValue:TCallStep);
    property  CallStep     :TCallStep      read FCallStep     write SetCallStep;
  public
    DeliveryOrderData  : Array of TDeliveryData;
    DeliveryData  : Array of TDeliveryData;
    DishReturnList :TStringList;             //그릇회수리스트
    DishReturnPrintList:TStringList;         //그릇회수출력 리스트
    FDeliveryMode :TDeliveryMode;
    FCidTelNo     :String;
    FDeliveryNo   :String;  //전화가 왔을때 기존에 주문된 내역이 있는지 체크하기 위함
    FIndex        :Integer;
    FDefaultAddr  :String;
    procedure TableButtonClick(Sender :TObject);   //테이블 클릭이벤트
    procedure SetDeliveryMode(const Value: TDeliveryMode);
    property  DeliveryMode :TDeliveryMode read FDeliveryMode write SetDeliveryMode;
  end;

var
  Delivery_F: TDelivery_F;

implementation
uses Order_U, GlobalFunc_U, DeliveryInfo_U, DBModule_U, RcpChange_U;
{$R *.dfm}

procedure TDelivery_F.FormCreate(Sender: TObject);
var vTemp :String;
begin
  if Common.Config.DeliveryDisplay = '' then
  begin
    Self.Position := poOwnerFormCenter;
    Self.Top      := 0;
    Self.Left     := 0;
    Self.Width    := Screen.Width;
    Self.Height   := Screen.Height;
  end
  else
  begin
    vTemp := ','+Common.Config.DeliveryDisplay;
    Self.Top      := StoI(CopyPos(vTemp,',',1));
    Self.Left     := StoI(CopyPos(vTemp,',',2));
    Self.Width    := StoI(CopyPos(vTemp,',',3));
    Self.Height   := StoI(CopyPos(vTemp,',',4));

    Self.Width    := Ifthen(Self.Width > Screen.Width, Screen.Width, Self.Width);
    Self.Height   := Ifthen(Self.Height > Screen.Height, Screen.Height, Self.Height);
  end;

  Common.LogoCreate(Self,2);
  panCall.Top  := (Self.Height - panCall.Height) div 2 + Self.Top;
  panCall.Left := (Self.Width  - panCall.Width ) div 2 + Self.Left;
  MessageImage.Top          := Self.Height - 41;
  MessageLabel.Top          := Self.Height - 41;

  DeliveryInfo_F := TDeliveryInfo_F.Create(Application);

  DishReturnList := TStringList.Create;
  DishReturnPrintList := TStringList.Create;

  MemData    := TdxMemData.Create(Self);
  SubMemData := TdxMemData.Create(Self);
  DataSource.DataSet := MemData;
  SubDataSource.DataSet := SubMemData;

  isTableCreated := false;
end;

procedure TDelivery_F.FormShow(Sender: TObject);
var vIndex, vTop, vHeight, vCount, vIndex2, vPanelHeight, vGap :Integer;
begin
  Application.ProcessMessages;
  TablePanel.DoubleBuffered     := true;
  OrderLabel.Visible            := GetOption(290)='0';
  DeliveryCountLabel.Visible    := GetOption(290)='0';
  MissedCallCountLabel.Visible  := GetOption(290)='0';
  if GetOption(290) = '1' then
    bvGridView.DataController.Summary.FooterSummaryItems[0].Kind    := skNone;

  Notebook1.ActivePage := 'tbTable';
  OpenQuery('select * '
           +'  from MS_STORE '
           +' where CD_STORE =:P0',
           [Common.Config.StoreCode]);

  FXcnt           := Common.Query.FieldByName('delivery_x').AsInteger;
  FYCnt           := Common.Query.FieldByName('delivery_y').AsInteger;
  FNumberFontSize := Common.Query.FieldByName('delivery_number').AsInteger;
  FCaptionFontSize:= Common.Query.FieldByName('delivery_caption').AsInteger;     //부재중
  FMenuFontSize   := Common.Query.FieldByName('delivery_menu').AsInteger;        //주문시
  FAmountFontSize := Common.Query.FieldByName('delivery_amount').AsInteger;
  FBottomFontSize := Common.Query.FieldByName('delivery_bottom').AsInteger;
  FDefaultAddr    := Common.Query.FieldByName('delivery_defaddr').AsString;

  FColor1         := StringToColorDef(Common.Query.FieldByName('delivery_color1').AsString, $005353FF);
  FColor2         := StringToColorDef(Common.Query.FieldByName('delivery_color2').AsString, $005353FF);
  FColor3         := StringToColorDef(Common.Query.FieldByName('delivery_color3').AsString, $005353FF);
  FColor4         := StringToColorDef(Common.Query.FieldByName('delivery_color4').AsString, $005353FF);
  FColor5         := StringToColorDef(Common.Query.FieldByName('delivery_color5').AsString, clBlack);
  FColor6         := StringToColorDef(Common.Query.FieldByName('delivery_color6').AsString, clWhite);
  Common.Query.Close;

  //그룻회수기능을 사용할때만 회수리스트 버튼을 보인다
  if GetOption(56)='1' then
  begin
    DishReturnButton.Visible := True;
    DishListButton.Visible   := True;
    TakeOutButton.Visible := Common.Config.IsTakeOut;
  end
  else
  begin
    DishReturnButton.Visible := False;
    DishListButton.Visible   := False;
    TakeOutButton.Visible    := Common.Config.IsTakeOut;
  end;

  DeliveryMode := dmNone;
  Page := 1;

  if GetOption(56)='1' then
    vCount := 10
  else
    vCount := 8;

  vPanelHeight := 0;
  vHeight := (ButtonPanel.Height - 157) div vCount - 2;
  vTop    := 107;
  for vIndex := 0 to  ButtonPanel.ControlCount-1 do
  begin
    if ButtonPanel.Controls[vIndex] is TAdvGlassButton and TAdvGlassButton(ButtonPanel.Controls[vIndex]).Visible and (TAdvGlassButton(ButtonPanel.Controls[vIndex]).Tag > 0) then
    begin
      TAdvGlassButton(ButtonPanel.Controls[vIndex]).Top    := vTop;
      TAdvGlassButton(ButtonPanel.Controls[vIndex]).Height := vHeight;
      vPanelHeight := vTop + vHeight;
      vTop := vTop + vHeight + 2;
      if Self.Width > 1024 then
        TAdvGlassButton(ButtonPanel.Controls[vIndex]).Layout := TButtonLayout.blGlyphTop;
    end;
  end;

  vGap := ButtonPanel.Height - vPanelHeight - 60;
  for vIndex := 0 to  ButtonPanel.ControlCount-1 do
  begin
    if ButtonPanel.Controls[vIndex] is TAdvGlassButton and TAdvGlassButton(ButtonPanel.Controls[vIndex]).Visible and (TAdvGlassButton(ButtonPanel.Controls[vIndex]).Tag > 0) then
    begin
      TAdvGlassButton(ButtonPanel.Controls[vIndex]).Top    := TAdvGlassButton(ButtonPanel.Controls[vIndex]).Top + vGap;

      //다크모드
      if (GetOption(18) = '1') and (ButtonPanel.Controls[vIndex] is TAdvGlassButton)  then
      begin
        TAdvGlassButton(ButtonPanel.Controls[vIndex]).Font.Color       := clWhite;
        TAdvGlassButton(ButtonPanel.Controls[vIndex]).BackColor        := clBlack;
        TAdvGlassButton(ButtonPanel.Controls[vIndex]).InnerBorderColor := clBlack;
        TAdvGlassButton(ButtonPanel.Controls[vIndex]).OuterBorderColor := clBlack;
        TAdvGlassButton(ButtonPanel.Controls[vIndex]).ShineColor       := clBlack;
      end;
    end;
  end;

  if GetOption(18) = '1' then
  begin
    Info1Panel.Color := $00FF5959;
    Info2Panel.Color := $00FF5959;

    ButtonPanel.ParentBackground  := false;
    ButtonPanel.ParentColor       := false;
    ButtonPanel.Color             := clBlack;
    ButtonPanel.Font.Color        := clBlack;
    Info1NameLabel.Font.Color     := clWhite;
    Info2NameLabel.Font.Color     := clWhite;
    OrderLabel.Font.Color         := clWhite;
    DeliveryCountLabel.Font.Color := clWhite;
    MissedCallLabel.Font.Color      := clWhite;
    MissedCallCountLabel.Font.Color := clWhite;
    lblPage.Font.Color  := clWhite;
    PriorButton.Font.Color       := clWhite;
    PriorButton.BackColor        := clBlack;
    PriorButton.InnerBorderColor := clBlack;
    PriorButton.OuterBorderColor := clBlack;
    PriorButton.ShineColor       := clBlack;
    NextButton.Font.Color       := clWhite;
    NextButton.BackColor        := clBlack;
    NextButton.InnerBorderColor := clBlack;
    NextButton.OuterBorderColor := clBlack;
    NextButton.ShineColor       := clBlack;
  end;

  FromDatePicker.Date := StoD(Common.WorkDate);
  ToDatePicker.Date   := StoD(Common.WorkDate);

  Timer1.Enabled := true;

  if Common.Config.Cid_Port > 0 then
    Common.Device.OnCidReadData :=CidReadEvent;

end;

procedure TDelivery_F.obtn_closeClick(Sender: TObject);
begin
  Close;
end;

procedure TDelivery_F.TableCreate;
var vRow,
    vCol,
    vHeight,
    vWidth,
    vNumber  :Integer;
begin
  vHeight         := ((TablePanel.Height + FXcnt-5) div FYcnt) - 5;
  vWidth          := ((TablePanel.Width+FXcnt-5) div FXcnt)-5;

  vNumber := 1;
  LockWindowUpdate(Handle);
  try
    For vCol := 0 to FYcnt-1 do
    begin
      For vRow := 0 to FXcnt-1 do
      begin
        with TPosButton.Create(Self) do
        begin
           Parent            := TablePanel;
           Top               := (vCol  * vHeight) + (vCol+1) * 5;
           Left              := (vRow  * vWidth)  + (vRow+1) * 5;
           Height            := vHeight;
           Width             := vWidth;
           Name              := Format('TableButton%d',[vNumber]);
           Number.Height     := Trunc(vHeight * 0.15);
           Number.Number     := 0;
           Amount.Caption    := '';
           Number.ShowNumber := False;
           Style             := bsRound;
           BorderInnerColor  := clNone;
           BorderStyle       := pbsSingle;
           BorderColor       := FColor5;
           Onclick           := TableButtonClick;

           Font.Name         := '맑은 고딕';
           Font.Size         := FCaptionFontSize;
           Font.Color        := FColor6;

           Menu.Font.Name    := '맑은 고딕';
           Menu.Font.Color   := FColor6;
           Menu.Font.Size    := FMenuFontSize;

           Bottom.Font.Name  := '맑은 고딕';
           Bottom.Font.Color        := FColor6;
           Bottom.Font.Size  := FBottomFontSize;
           Bottom.Height     := Trunc(vHeight * 0.15);

           Amount.Font.Name  := '맑은 고딕';
           Amount.Font.Color        := FColor6;
           Amount.Font.Size  := FAmountFontSize;

           Number.Font.Name  := '맑은 고딕';
           Number.Font.Color        := FColor6;
           Number.Font.Size  := FNumberFontSize;

           //테이블 색상지정
           Color          := FColor1;
           Visible := true;
          Inc(vNumber);
        end;
      end;
    end;
  finally
    LockWindowUpdate(0);
  end;
end;

procedure TDelivery_F.TakeOutButtonClick(Sender: TObject);
var vCidData :String;
    vIsTackOut :Boolean;
begin
  case Common.PosType of
    ptOnlyOrder :
    begin
      Common.ErrBox('정산포스에서만 사용이 가능합니다');
      Exit;
    end;
    ptNotAccount :
    begin
       if (Trim(Common.WorkDate) = '') then
       begin
         Common.ErrBox('개점이 안됐습니다'+#13#13+'개점을 해야 사용할 수 있습니다');
         Exit;
       end;
    end;
  end;
  vIsTackOut := Common.Config.IsTakeOut;
  Common.Config.IsTakeOut := true;
  Common.OrderKind := okNew;
  InitTableRecord(Common.Table);
  Order_F := TOrder_F.Create(Application);
  try
    if Order_F.ShowModal = mrAbort then
    begin
      Common.ShowWaitForm('잠시만 기다려 주세요');
      RcpManagerTimer.Enabled := true;
    end;
  finally
    vCidData := Order_F.FCidData;
    FreeAndNil(Order_F);
    Common.Config.IsTakeOut := vIsTackOut;
    if Common.Config.Cid_Port > 0 then
      Common.Device.OnCidReadData :=CidReadEvent;

    if (Common.CidData.Count > 0) and (vCidData = '') then
    begin
      Tmr_Exec.Tag := 1;
      Tmr_Exec.Enabled := True;
    end;

    if vCidData <> '' then CidReadEvent(vCidData);
  end;
end;

procedure TDelivery_F.TableButtonClick(Sender: TObject);
  procedure DeleteReadyData(aData:String);
  var I :Integer;
  begin
    For I := 0 to Common.CidData.Count-1 do
    begin
      if Trim(Copy(Common.CidData.Strings[I],1,12)) = aData then
      begin
        Common.CidData.Delete(I);
        Break;
      end;
    end;
  end;
  function FindTableButton1:TPosButton;
  var nCnt :Integer;
  begin
    Result := nil;
    For nCnt := 0 to ComponentCount-1 do
    begin
      if (Components[nCnt] is TPosButton) and
         ( CtoC((Components[nCnt] as TPosButton).Temp3) = FCidTelNo ) then
      begin
        Result := (Components[nCnt] as TPosButton);
        Break;
      end;
    end;
  end;
  function FindTableButton2:TPosButton;
  var nCnt :Integer;
  begin
    Result := nil;
    For nCnt := 0 to ComponentCount-1 do
    begin
      if (Components[nCnt] is TPosButton) and
         ( (Components[nCnt] as TPosButton).Temp1 = FDeliveryNo ) then
      begin
        Result := (Components[nCnt] as TPosButton);
        Break;
      end;
    end;
  end;
var vTemp, vIndex :Integer;
    vDeliveryMode : TDeliveryMode;
begin
  if Common.WorkDate = EmptyStr then
  begin
    Common.ErrBox('개점이 안됐습니다'+#13#13+'개점을 해야 사용할 수 있습니다');
    Exit;
  end;

  DeliveryInfo_F.FFirstActive := True;
  case DeliveryMode of
    dmNone,
    dmNotTel :
    begin
      DeliveryInfo_F.FShowType   := fstNone;
      if Sender = nil then
      begin
        if FCidTelNo <> '' then Sender := FindTableButton1;
        if FDeliveryNo <> '' then
        begin
          vTemp := (FIndex+1) div (FXcnt * FYcnt) ;
          if ((FIndex+1) mod (FXcnt * FYcnt) ) > 0 then
            vTemp := vTemp + 1;
          Page := vTemp;

          SetOrderTable;
          Sender := FindTableButton2;
        end;

        FDeliveryNo := '';
        FIndex      := -1;
      end;

      //신규배달
      if (Sender = nil) then
      begin
        DeliveryInfo_F.FWorkType   := wtNew;
        DeliveryInfo_F.FOrderAmt   := 0;
        DeliveryInfo_F.FDeliveryNo := EmptyStr;
        DeliveryInfo_F.FTelephoeNo := FCidTelNo ;
        FCidTelNo := '';
      end
      else if (CallTelNo <> EmptyStr) or (Trim((Sender as TPosButton).Number.NumberString) = '못받은전화') then
      begin
        if CallTelNo <> EmptyStr then
          vIndex := GetDeliveryOrderDataIndex(GetOnlyNumber( Copy(CallTelNo,4, Length(CallTelNo)-15)))
        else
          vIndex := GetDeliveryOrderDataIndex(GetOnlyNumber( (Sender as TPosButton).Caption));
        //부재중전화 배달버튼을 클릭했을때
        if (vIndex >= 0) and ( (DeliveryOrderData[vIndex].Step ='주문') or (DeliveryOrderData[vIndex].Step ='배달') or (DeliveryOrderData[vIndex].Step ='계산')) then
        begin
          if not Common.AskBox('현재 '+DeliveryOrderData[vIndex].Step+'상태의 배달이 있습니다'+#13#13+'신규배달로 주문하시겠습니까?') then
          begin
            //다른포스에서 주문중인지 체크한다
            if not GetUseCheck((Sender as TPosButton).Temp1) then Exit;
            DeliveryInfo_F.FWorkType   := wtEdit;
            DeliveryInfo_F.FDeliveryNo := DeliveryOrderData[vIndex].DeliveryNo;
            Common.DeleteCidData(GetOnlyNumber((Sender as TPosButton).Caption));
            CallTelNo := EmptyStr;
          end
          else
          begin
            DeliveryInfo_F.FWorkType   := wtOutNew;
            DeliveryInfo_F.FOrderAmt   := 0;
            DeliveryInfo_F.FDeliveryNo := Ifthen(CallTelNo <> EmptyStr, RightStr(CallTelNo,12), (Sender as TPosButton).Temp1);
            DeliveryInfo_F.FTelephoeNo := Ifthen(CallTelNo <> EmptyStr, Copy(CallTelNo,4, Length(CallTelNo)-15), GetOnlyNumber( (Sender as TPosButton).Caption));
            DeliveryInfo_F.FTelLine    := Ifthen(CallTelNo <> EmptyStr, Copy(CallTelNo,2,1), (Sender as TPosButton).Bottom.RightString);
            if CallTelNo = EmptyStr then
              DeleteReadyData( GetOnlyNumber( (Sender as TPosButton).Caption));
            CallTelNo := EmptyStr;
          end;
        end
        else
        begin
            DeliveryInfo_F.FWorkType   := wtOutNew;
            DeliveryInfo_F.FOrderAmt   := 0;
            DeliveryInfo_F.FDeliveryNo := Ifthen(CallTelNo <> EmptyStr, RightStr(CallTelNo,12), (Sender as TPosButton).Temp1);
            DeliveryInfo_F.FTelephoeNo := Ifthen(CallTelNo <> EmptyStr, Copy(CallTelNo,4, Length(CallTelNo)-15), GetOnlyNumber( (Sender as TPosButton).Caption));
            DeliveryInfo_F.FTelLine    := Ifthen(CallTelNo <> EmptyStr, Copy(CallTelNo,2,1), (Sender as TPosButton).Bottom.RightString);
            if CallTelNo = EmptyStr then
              DeleteReadyData( GetOnlyNumber( (Sender as TPosButton).Caption));
            CallTelNo := EmptyStr;
        end;
      end
      else if ((Sender as TPosButton).Temp1  <> '') then
      //배달수정
      begin
        if not GetUseCheck((Sender as TPosButton).Temp1) then Exit;
        DeliveryInfo_F.FWorkType   := wtEdit;
        DeliveryInfo_F.FDeliveryNo := (Sender as TPosButton).Temp1;
      end
      else Exit;
      Common.Device.OnCidReadData := nil;
      DeliveryInfo_F.ShowModal;
    end;
    dmOrder :
    begin
      if not GetUseCheck((Sender as TPosButton).Temp1) then Exit;
      DeliveryInfo_F.FShowType   := fstOrder;
      DeliveryInfo_F.FWorkType   := wtEdit;
      DeliveryInfo_F.FDeliveryNo := (Sender as TPosButton).Temp1;
      Common.Device.OnCidReadData := nil;
      DeliveryInfo_F.ShowModal;
    end;
    dmDelete :
    begin
      if (Sender as TPosButton).Number.NumberString = '못받은전화' then
        DeleteReadyData( GetOnlyNumber( (Sender as TPosButton).Caption))
      else
      begin
        if not GetUseCheck((Sender as TPosButton).Temp1) then Exit;
        if Common.AskBox('주문을 취소하시겠습니까?') then
        begin
          DeliveryInfo_F.FShowType   := fstDelete;
          DeliveryInfo_F.FWorkType   := wtEdit;
          DeliveryInfo_F.FDeliveryNo := (Sender as TPosButton).Temp1;
          DeliveryInfo_F.ShowModal;
        end;
      end;
    end;
    dmDelivery :
    begin
      if not GetUseCheck((Sender as TPosButton).Temp1) then Exit;
      DeliveryInfo_F.FShowType   := fstDeliveryGo;
      DeliveryInfo_F.FWorkType   := wtEdit;
      DeliveryInfo_F.FDeliveryNo := (Sender as TPosButton).Temp1;
      Common.Device.OnCidReadData := nil;
      DeliveryInfo_F.ShowModal;
    end;
    dmDishReturn :
    begin
      if not GetUseCheck((Sender as TPosButton).Temp1) then Exit;

      if DishReturnList.IndexOf((Sender as TPosButton).Temp1) >= 0 then
        DishReturnList.Delete(DishReturnList.IndexOf((Sender as TPosButton).Temp1))
      else
        DishReturnList.Add((Sender as TPosButton).Temp1);

      DeliveryMode := dmDishReturn;
    end;
    dmDishReturnPrint :
    begin
      //회수리스트 출력시에는 체크하지 않는다
//      if not GetUseCheck((Sender as TPosButton).Temp1) then Exit;

      if DishReturnPrintList.IndexOf((Sender as TPosButton).Temp1) >= 0 then
        DishReturnPrintList.Delete(DishReturnPrintList.IndexOf((Sender as TPosButton).Temp1))
      else
        DishReturnPrintList.Add((Sender as TPosButton).Temp1);

      DeliveryMode := dmDishReturnPrint;
    end;
    dmReprint :
    begin
      DeliveryInfo_F.FShowType   := fstRePrint;
      DeliveryInfo_F.FWorkType   := wtEdit;
      DeliveryInfo_F.FDeliveryNo := (Sender as TPosButton).Temp1;
      Common.Device.OnCidReadData := nil;
      DeliveryInfo_F.ShowModal;
    end;
  end;
  if Self.Handle <> GetForeGroundWindow then
    SetForegroundWindow(Self.Handle);

  if (DeliveryMode <> dmDishReturn) and (DeliveryMode <> dmDishReturnPrint) then
  begin
    vDeliveryMode := DeliveryMode;
    DeliveryMode := dmNone;
    if vDeliveryMode in [dmDelivery, dmDelete, dmDishReturn] then
      SetDeliveryData(false)
    else
      SetDeliveryData;
  end;
  
  if Common.Config.Cid_Port > 0 then
    Common.Device.OnCidReadData :=CidReadEvent;
end;

procedure TDelivery_F.SetDeliveryMode(const Value: TDeliveryMode);
begin
  FDeliveryMode := Value;
  case FDeliveryMode of
    dmNone       : MessageLabel.Caption := '';
    dmOrder      : MessageLabel.Caption := '주문할 배달을 선택하세요';
    dmReprint    : MessageLabel.Caption := '배달전표를 출력 할 배달을 선택하세요';
    dmDelivery   : MessageLabel.Caption := '출발 할 배달을 선택하세요';
    dmDelete     : MessageLabel.Caption := '삭제 할 배달을 선택하세요';
    dmDishReturn : MessageLabel.Caption := '그릇회수 할 배달을 선택하세요';
    dmDishReturnPrint : MessageLabel.Caption := '그릇회수리스트를 출력 할 배달을 선택 후 다시 회수리트를 클릭하세요';
    dmNotTel     : MessageLabel.Caption := '못받은 전화를 선택하면 신규배달로 주문이 됩니다';
  end;
  SetTableVisible;
end;

procedure TDelivery_F.SetTableVisible;
var vIndex :Integer;
begin
  case DeliveryMode of
    dmNone :
      begin
        For vIndex := 0 to ComponentCount-1 do
        if (Components[vIndex] is TPosButton) and
           ( (Components[vIndex] as TPosButton).Parent = TablePanel ) then  //빈테이블이 었으면 그냥통과
        begin
          (Components[vIndex] as TPosButton).Bottom.CenterString := Trim(Replace((Components[vIndex] as TPosButton).Bottom.CenterString,'[',''));
          (Components[vIndex] as TPosButton).Bottom.CenterString := Trim(Replace((Components[vIndex] as TPosButton).Bottom.CenterString,']',''));
          (Components[vIndex] as TPosButton).Visible    := True;
        end;
      end;
    dmOrder   :
      begin
        For vIndex := 0 to ComponentCount-1 do
        if (Components[vIndex] is TPosButton) and
           ( ( Trim((Components[vIndex] as TPosButton).Bottom.LeftString) = '계산') or ( (Components[vIndex] as TPosButton).Temp1 = '') ) and
           ( (Components[vIndex] as TPosButton).Parent = TablePanel ) then  //빈테이블이 었으면 그냥통과
        begin
          (Components[vIndex] as TPosButton).Visible    := False;
        end;
      end;
    dmReprint :
      begin
        For vIndex := 0 to ComponentCount-1 do
        if (Components[vIndex] is TPosButton) and
           ( (Components[vIndex] as TPosButton).Temp1 = '') and
           ( (Components[vIndex] as TPosButton).Parent = TablePanel ) then  //빈테이블이 었으면 그냥통과
        begin
          (Components[vIndex] as TPosButton).Visible    := False;
        end;
      end;
    dmDelivery :
      begin
        For vIndex := 0 to ComponentCount-1 do
        if (Components[vIndex] is TPosButton) and
           ( ( Trim((Components[vIndex] as TPosButton).Bottom.LeftString) <> '주문') or ( (Components[vIndex] as TPosButton).Temp1 = '') ) and
           ( (Components[vIndex] as TPosButton).Parent = TablePanel ) then  //빈테이블이 었으면 그냥통과
        begin
          (Components[vIndex] as TPosButton).Visible    := False;
        end;
      end;
    dmDelete :
      begin
        For vIndex := 0 to ComponentCount-1 do
        if (Components[vIndex] is TPosButton) and
           ( ( Trim((Components[vIndex] as TPosButton).Bottom.LeftString) = '계산') or ( (Components[vIndex] as TPosButton).Temp1 = '') ) and
           ( (Components[vIndex] as TPosButton).Parent = TablePanel ) then
        begin
          (Components[vIndex] as TPosButton).Visible    := False;
        end;
      end;
    dmDishReturn, dmDishReturnPrint :
      begin
        For vIndex := 0 to ComponentCount-1 do
        begin
          if (Components[vIndex] is TPosButton) and
             ( ( Trim((Components[vIndex] as TPosButton).Bottom.LeftString) <> '계산') or ( (Components[vIndex] as TPosButton).Temp1 = '') ) and
             ( (Components[vIndex] as TPosButton).Parent = TablePanel ) then  //빈테이블이 었으면 그냥통과
          begin
            (Components[vIndex] as TPosButton).Visible    := False;
          end
          else if (Components[vIndex] is TPosButton) and
             ( ( Trim((Components[vIndex] as TPosButton).Bottom.LeftString) = '계산') or ( (Components[vIndex] as TPosButton).Temp1 = '') ) and
             ( (Components[vIndex] as TPosButton).Parent = TablePanel ) then  //빈테이블이 었으면 그냥통과
          begin
            (Components[vIndex] as TPosButton).Bottom.CenterString := Trim(Replace((Components[vIndex] as TPosButton).Bottom.CenterString,'[',''));
            (Components[vIndex] as TPosButton).Bottom.CenterString := Trim(Replace((Components[vIndex] as TPosButton).Bottom.CenterString,']',''));
            if (DeliveryMode = dmDishReturn) and (DishReturnList.IndexOf((Components[vIndex] as TPosButton).Temp1) >= 0) then
              (Components[vIndex] as TPosButton).Bottom.CenterString := Format('[ %s ]', [(Components[vIndex] as TPosButton).Bottom.CenterString]);
            if (DeliveryMode = dmDishReturnPrint) and (DishReturnPrintList.IndexOf((Components[vIndex] as TPosButton).Temp1) >= 0) then
              (Components[vIndex] as TPosButton).Bottom.CenterString := Format('[ %s ]', [(Components[vIndex] as TPosButton).Bottom.CenterString]);
          end;
        end;
      end;
  end;
end;

procedure TDelivery_F.DeleteButtonClick(Sender: TObject);
begin
  Notebook1.ActivePage := 'tbTable';
  FCidTelNo   := '';
  FDeliveryNo := '';
  case DeliveryMode of
    dmDelete : DeliveryMode := dmNone;
    else       DeliveryMode := dmDelete;
  end;
end;

procedure TDelivery_F.DeliveryGoButtonClick(Sender: TObject);
begin
  Notebook1.ActivePage := 'tbTable';
  FCidTelNo   := '';
  FDeliveryNo := '';
  case DeliveryMode of
    dmNone     : DeliveryMode := dmDelivery;
    dmDelivery : DeliveryMode := dmNone;
  end;
end;

procedure TDelivery_F.DeliveryListButtonClick(Sender: TObject);
begin
  if Notebook1.ActivePage = 'tbTable' then
    Notebook1.ActivePage := 'tbGrid'
  else
    Notebook1.ActivePage := 'tbTable';
end;

procedure TDelivery_F.DishListButtonClick(Sender: TObject);
var vIndex :Integer;
    vCode, vTemp, vSql  :String;
begin
  //그릇회수리스트를 건건이 선택방식
  if GetOption(397) = '1' then
  begin
    case DeliveryMode of
      dmNone       :
      begin
        DishReturnPrintList.Clear;
        DeliveryMode := dmDishReturnPrint;
      end;
      dmDishReturnPrint :
      begin
        vTemp := EmptyStr;
        For vIndex := 0 to DishReturnPrintList.Count-1 do
          vTemp := vTemp + Format('''%s'',',[DishReturnPrintList.Strings[vIndex]]);

        if vTemp = EmptyStr then Exit;

        vTemp := Format(' and a.YMD_DELIVERY+a.NO_DELIVERY in (%s) ',[LeftStr(vTemp, Length(vTemp)-1)]);
        Common.Device.DeliveryDishRetrunListPrint(vTemp);
        if (GetOption(380) = '1') and Common.AskBox('출력 된 회수리스트 배달을'#13#13'그릇회수 완료로 처리하시겠습니까?') then
        begin
          try
            ExecQuery('update SL_DELIVERY '
                     +'   set DS_STEP  =''R'' '
                     +' where CD_STORE =:P0 '
                     +Replace(vTemp, 'a.',''),
                     [Common.Config.StoreCode]);
            DishReturnPrintList.Clear;
          except
            on E: Exception do
            begin
              Common.RollbackTran;
              Common.WriteLog('Delivery001',E.Message);
              Common.ErrBox(E.Message);
            end;
          end;
        end;
        DishReturnPrintList.Clear;
        DeliveryMode := dmNone;
      end;
    end;
  end
  else
  begin
    OpenQuery('select Count(*) '
             +'  from SL_DELIVERY '
             +' where CD_STORE =:P0 '
             +'   and DS_ORDER =''D'' '
             +'   and DS_STEP  =''A'' '
             +'   and Length(CD_COURSE) = 3 ',
             [Common.Config.StoreCode]);

    if Common.Query.Fields[0].AsInteger > 0 then
    begin
      vSql := 'select ''A'' as CD_CODE, '
             +'       ''전체'' as NM_COURSE, '
             +'       Count(*) as CNT_DELIVERY '
             +'  from SL_DELIVERY '
             +' where CD_STORE =:P0 '
             +'   and DS_ORDER =''D'' '
             +'   and DS_STEP  =''A'' '
             +' union all '
             +'select a.CD_COURSE, '
             +'       ifnull(Max(b.NM_CODE1),''미지정'') as NM_COURSE, '
             +'       Count(*) as CNT_DELIVERY '
             +'  from SL_DELIVERY a  left outer join '
             +'       MS_CODE     b  on a.CD_STORE = b.CD_STORE and a.CD_COURSE = b.CD_CODE and b.CD_KIND = ''20'' '
             +' where a.CD_STORE =:P0 '
             +'   and a.DS_ORDER = ''D'' '
             +'   and a.DS_STEP  = ''A'' '
             +' group by a.CD_COURSE ';

      if Common.ShowChooseForm('C','', vCode, vTemp, vSql) then
      begin
        if Common.Device.DeliveryDishRetrunListPrint(vCode) then
        begin
          if (GetOption(380) = '1') and Common.AskBox('출력 된 회수리스트 배달을'#13#13'그릇회수 완료로 처리하시겠습니까?') then
          begin
            try
              if vCode <> 'A' then
                vTemp := Format(' and ifnull(CD_COURSE,'''') = ''%s'' ',[vCode])
              else
                vTemp := EmptyStr;

              ExecQuery('update SL_DELIVERY '
                       +'   set DS_STEP  =''R'' '
                       +' where CD_STORE =:P0 '
                       +'   and DS_ORDER =''D'' '
                       +'   and DS_STEP  =''A'' '
                       +vTemp,
                       [Common.Config.StoreCode]);
              SetDeliveryData;
              DeliveryMode := dmNone;
            except
              on E: Exception do
              begin
                Common.WriteLog('Delivery002',E.Message);
                Common.ErrBox(E.Message);
              end;
            end;
          end;
        end;
      end;
    end
    else
    begin
      if Common.Device.DeliveryDishRetrunListPrint('A') then
      begin
        if (GetOption(380) = '1') and Common.AskBox('출력 된 회수리스트 배달을'#13#13'그릇회수 완료로 처리하시겠습니까?') then
        begin
          try
            ExecQuery('update SL_DELIVERY '
                     +'   set DS_STEP  =''R'' '
                     +' where CD_STORE =:P0 '
                     +'   and DS_ORDER =''D'' '
                     +'   and DS_STEP  =''A'' ',
                     [Common.Config.StoreCode]);
            SetDeliveryData;
            DeliveryMode := dmNone;
          except
            on E: Exception do
            begin
              Common.WriteLog('Delivery003',E.Message);
              Common.ErrBox(E.Message);
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TDelivery_F.DishReturnButtonClick(Sender: TObject);
  function GetRecallMan: String;
  var vTemp :String;
  begin
    Result := EmptyStr;
    if Common.ShowChooseForm('D','',Common.DamdangCode, vTemp) then
    begin
      Result := Common.DamdangCode;
    end;
  end;
var vIndex :Integer;
    vTemp  :String;
begin
  Notebook1.ActivePage := 'tbTable';
  FCidTelNo   := '';
  FDeliveryNo := '';
  case DeliveryMode of
    dmNone       :
    begin
      DishReturnList.Clear;
      DeliveryMode := dmDishReturn;
    end;
    dmDishReturn :
    begin
      if DishReturnList.Count = 0 then
        DeliveryMode := dmNone
      else
      begin
        //그릇회수 시 담당자를 사용할때
        if GetOption(144) = '1' then
        begin
          vTemp := GetRecallMan;
          if vTemp = EmptyStr then
          begin
            Common.ErrBox('그릇회수담당자가 지정되지 않았습니다');
            Exit;
          end;
        end;

        try
          Common.BeginTran;
          For vIndex := 0 to DishReturnList.Count-1 do
          begin
            ExecQuery('update SL_DELIVERY '
                     +'   set RECALL_SAWON =:P2, '
                     +'       DS_STEP      =''R'' '
                     +' where CD_STORE =:P0 '
                     +'   and ConCat(YMD_DELIVERY,NO_DELIVERY) =:P1 ',
                     [Common.Config.StoreCode,
                      DishReturnList.Strings[vIndex],
                      vTemp]);
          end;
          Common.CommitTran;
        except
          on E: Exception do
          begin
            Common.RollbackTran;
            Common.WriteLog('Delivery003',E.Message);
            Common.ErrBox(E.Message);
            Exit;
          end;
        end;
        DeliveryMode := dmNone;
        SetDeliveryData(false);
        SetOrderTable;
      end;
    end;
  end;
end;

procedure TDelivery_F.OrderButtonClick(Sender: TObject);
begin
  Notebook1.ActivePage := 'tbTable';
  FCidTelNo   := '';
  FDeliveryNo := '';
  case DeliveryMode of
    dmNone    : DeliveryMode := dmOrder;
    dmOrder   : DeliveryMode := dmNone;
  end;
end;

procedure TDelivery_F.PriorButtonClick(Sender: TObject);
begin
  if Sender = PriorButton then Page := Page - 1
  else                         Page := Page + 1;
end;

procedure TDelivery_F.RcpManagerTimerTimer(Sender: TObject);
begin
  //선불제에서 영수증관리
  RcpManagerTimer.Enabled := false;
  RcpChange_F := TRcpChange_F.Create(Self);
  try
    Order_F := TOrder_F.Create(Self);

    RcpChange_F.ShowMode := fsmNone;
    RcpChange_F.ShowModal;
  finally
    FreeAndNil(RcpChange_F);
    if Assigned(Order_F) then
      FreeAndNil(Order_F);

    TakeOutButtonClick(TakeOutButton);
  end;
end;

procedure TDelivery_F.ReprintButtonClick(Sender: TObject);
begin
  Notebook1.ActivePage := 'tbTable';
  FCidTelNo   := '';
  FDeliveryNo := '';
  case DeliveryMode of
    dmNone    : DeliveryMode := dmReprint;
    dmReprint : DeliveryMode := dmNone;
  end;
end;

procedure TDelivery_F.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Common.Config.Cid_Port > 0 then
    Common.Device.OnCidReadData := nil;

  FreeAndNil(DishReturnList);
  FreeAndNil(DishReturnPrintList);
  FreeAndNil(DeliveryInfo_F);
end;

procedure TDelivery_F.SetDeliveryData(aMaxPage:Boolean);
  function SetOrderMenu(aTableNo:Integer; var aMenuName, aMenuQty:String):String;
  begin
    DM.OpenQuery('select a.NM_MENU, '
                +'		   GetQty(a.DS_MENU_TYPE, a.QTY_ORDER) as QTY_SALE '
                +'  from '
                +'      (select case when t1.DS_SALE = ''D'' then ConCat(t1.NM_MENU,:P2) '
                +'                                                  else t1.NM_MENU '
                +'      		    end as NM_MENU, '
                +'      			  t1.DS_MENU_TYPE, '
                +'      			  t1.QTY_ORDER '
                +'      	 from SL_ORDER_D t1 inner join '
                +'      	      MS_MENU    t2  on t1.CD_STORE = t2.CD_STORE and t1.CD_MENU = t2.CD_MENU '
                +'        where t1.DS_ORDER =''D'' '
                +'      	  and t1.CD_STORE	=:P0 '
                +'      	  and t1.NO_TABLE	=:P1 '
                +'      	  and t1.NO_STEP	=0 '
                +'      	order by t1.ORDERSEQ, t1.CD_MENU '
                +' ) a',
                [Common.Config.StoreCode,
                 aTableNo,
                 Common.Config.ServiceTxt]);
    Result    := EmptyStr;
    aMenuName := EmptyStr;
    aMenuQty  := EmptyStr;
    while not DM.Query.Eof do
    begin
      aMenuName := aMenuName + DM.Query.Fields[0].AsString + #13;
      aMenuQty := aMenuQty   + DM.Query.Fields[1].AsString + #13;
      DM.Query.Next;
    end;
    DM.Query.Close;
  end;
var vIndex, I :Integer;
    OrderCnt,    OrderAmt,
    DeliveryCnt, DeliveryAmt,
    ReturnCnt,   ReturnAmt,
    OutTelCnt :Integer;
    vWhere :String;
begin
// GetOption(56) 그릇회수기능을 사용합니다.
  OpenQuery('select a.YMD_DELIVERY, '
           +'       a.NO_DELIVERY, '
           +'       case a.DS_ORDER when ''D'' THEN ''배달'' when ''P'' THEN ''포장'' end as NM_ORDER, '
           +'       a.DS_STEP, '
           +'       case a.DS_STEP when ''N'' then ''미주문'' when ''O'' THEN ''주문'' when ''D'' then ''배달'' when ''A'' then ''계산'' end as NM_STEP, '
           +'       Date_Format(a.DT_ORDER, ''%H:%i'') as ORDER_TIME, '
           +'       a.DT_ORDER, '
           +'       a.DT_DELIVERY, '
           +'       case a.DS_CUSTOMER when ''N'' then ''비회원'' else a.CD_MEMBER end as DS_MEMBER, '
           +'       a.NM_NAME as NM_CUSTOMER, '
           //그릇회수 기능
           +Ifthen(GetOption(56)='1',' case when a.DS_STEP = ''A'' and a.DS_ORDER = ''D'' then d.AMT_SALE else b.AMT_ORDER end as AMT_ORDER, ',
                                                ' b.AMT_ORDER, ')
           +'	      case when a.CD_SAWON <> '''' then (select NM_SAWON '
           +'                                            from MS_SAWON '
           +'                                           where CD_STORE =a.CD_STORE '
           +'                                             and CD_SAWON =a.CD_SAWON ) '
           +'	                                   else '''' end DAMDANG, '
           +'       b.NO_TABLE, '
           +'       a.NO_TEL1, '
           +'       a.NO_TEL2, '
           +'       a.NO_TEL3, '
           +'       a.NO_TEL4, '
           +'       a.ADDRESS1, '
           +'       a.ADDRESS2, '
           +'       TIMESTAMPDIFF(MINUTE,  a.DT_ORDER, Now() ) as LAPSE_TIME, '
           +'       a.CD_LOCAL, '
           +'       GetCommonName(a.CD_STORE, ''22'', a.CD_LOCAL) as NM_LOCAL, '
           +'       a.CD_COURSE, '
           +'       GetCommonName(a.CD_STORE, ''20'', a.CD_COURSE) as NM_COURSE '
           +'  from SL_DELIVERY a  left outer join '
           +'       SL_ORDER_H  b  on b.CD_STORE = a.CD_STORE and b.NO_TABLE  = a.NO_TABLE and b.DS_ORDER = ''D'' left outer join '
           +'       MS_MEMBER   c  on c.CD_STORE = a.CD_STORE and c.CD_MEMBER = a.CD_MEMBER '
           +Ifthen(GetOption(56)='1','left outer join SL_SALE_H d on d.CD_STORE = a.CD_STORE and d.NO_DELIVERY = ConCat(a.YMD_DELIVERY,a.NO_DELIVERY) ','')
           +' where a.CD_STORE  = :P0 '
           +Ifthen(GetOption(56)='1','and a.DS_STEP in (''N'',''O'',''D'',''A'') order by a.YMD_DELIVERY, a.NO_DELIVERY ', 'and a.DS_STEP in (''N'',''O'',''D'') order by a.YMD_DELIVERY, a.NO_DELIVERY '),
           [Common.Config.StoreCode]);

    //부재중 모드일때는 기존배달건은 DeliveryData에 저장하지 않으므로 크키를 할당하지 않는다
  if DeliveryMode <> dmNotTel then
    SetLength(DeliveryData, Common.Query.RecordCount+Common.CidData.Count);
  SetLength(DeliveryOrderData, Common.Query.RecordCount);


  vIndex := 0;

  OrderCnt    := 0; OrderAmt    := 0;
  DeliveryCnt := 0; DeliveryAmt := 0;
  ReturnCnt   := 0; ReturnAmt   := 0;
  OutTelCnt   := 0;
  while not Common.Query.Eof do
  begin
    DeliveryOrderData[vIndex].DeliveryNo := Common.Query.FieldByName('ymd_delivery').AsString + Common.Query.FieldByName('no_delivery').AsString;
    DeliveryOrderData[vIndex].OrderDate  := FormatDateTime('yyyymmdd', Common.Query.FieldByName('dt_order').Value);
    DeliveryOrderData[vIndex].TableNo    := Common.Query.FieldByName('no_table').AsInteger;
    DeliveryOrderData[vIndex].Customer   := Common.Query.FieldByName('nm_customer').AsString;
    DeliveryOrderData[vIndex].OrderTime  := Common.Query.FieldByName('order_time').AsString;
    DeliveryOrderData[vIndex].TelNo1     := Common.Query.FieldByName('no_tel1').AsString;
    DeliveryOrderData[vIndex].TelNo2     := Common.Query.FieldByName('no_tel2').AsString;
    DeliveryOrderData[vIndex].TelNo3     := Common.Query.FieldByName('no_tel3').AsString;
    DeliveryOrderData[vIndex].TelNo4     := Common.Query.FieldByName('no_tel4').AsString;
    DeliveryOrderData[vIndex].Addr1      := Common.Query.FieldByName('address1').AsString;
    DeliveryOrderData[vIndex].Addr2      := Common.Query.FieldByName('address2').AsString;
    DeliveryOrderData[vIndex].LocalCode  := Common.Query.FieldByName('cd_local').AsString;
    DeliveryOrderData[vIndex].LocalName  := Common.Query.FieldByName('nm_local').AsString;
    DeliveryOrderData[vIndex].CourseCode := Common.Query.FieldByName('cd_course').AsString;
    DeliveryOrderData[vIndex].CourseName := Common.Query.FieldByName('nm_course').AsString;

    Inc(OrderCnt);
    OrderAmt := OrderAmt + Common.Query.FieldByName('amt_order').AsInteger;

    if Common.Query.FieldByName('nm_step').AsString = '배달' then
    begin
      Inc(DeliveryCnt);
      DeliveryAmt := DeliveryAmt + Common.Query.FieldByName('amt_order').AsInteger;
    end;
    if Common.Query.FieldByName('nm_step').AsString = '계산' then
    begin
      Inc(ReturnCnt);
      DeliveryAmt := DeliveryAmt + Common.Query.FieldByName('amt_order').AsInteger;
    end;

    if Common.Query.FieldByName('nm_step').AsString = '계산' then
    begin
      //계산이 완료된 배달은 메뉴내역을 보여주지 않는다 (넘느려서)
      DeliveryOrderData[vIndex].OrderMenu := '';
      DeliveryOrderData[vIndex].OrderMenuQty := '';
      DeliveryOrderData[vIndex].TableNo   := 1;
    end
    else
      SetOrderMenu(Common.Query.FieldByName('no_table').AsInteger, DeliveryOrderData[vIndex].OrderMenu, DeliveryOrderData[vIndex].OrderMenuQty);

    DeliveryOrderData[vIndex].OrderAmt    := FormatFloat(',0', Common.Query.FieldByName('amt_order').AsInteger)+'원';
    DeliveryOrderData[vIndex].Step        := Common.Query.FieldByName('nm_step').AsString;
    DeliveryOrderData[vIndex].dsOrder     := Common.Query.FieldByName('nm_order').AsString;
    DeliveryOrderData[vIndex].Damdang     := Common.Query.FieldByName('damdang').AsString;
    DeliveryOrderData[vIndex].LapseTime   := Common.Query.FieldByName('Lapse_Time').AsString + '분';
    Inc(vIndex);
    Common.Query.Next;
  end;
  Common.Query.Close;

  if DeliveryMode <> dmNotTel then
  begin
    For vIndex := 0 to High(DeliveryOrderData) do
      DeliveryData[vIndex] := DeliveryOrderData[vIndex];
  end
  else
  begin
    SetLength(DeliveryData, Common.CidData.Count);
    vIndex := 0;
  end;


  For I := 0 to Common.CidData.Count-1 do
  begin
    if Trim(Copy(Common.CidData.Strings[I],1,12)) <> '' then
    begin
      vWhere := Format('''%s'' ',[Trim(Copy(Common.CidData.Strings[I],1,12))]);
    end;

    OpenQuery('select 1 as SEQ, '
             +'		   CD_MEMBER, '
             +'		   NM_MEMBER	as NM_NAME, '
             +'		   TEL_MOBILE	as NO_TEL1, '
             +'			 TEL_HOME	as NO_TEL2, '
             +'			 TEL_ETC1	as NO_TEL3, '
             +'			 TEL_ETC2	as NO_TEL4, '
             +'			 ADDR1		as ADDRESS1, '
             +'			 ADDR2		as ADDRESS2, '
             +'			 REMARK, '
             +'			 CD_LOCAL, '
             +'			 GetCommonName(:P0, ''22'', CD_LOCAL) as NM_LOCAL, '
             +'			 CD_COURSE, '
             +'			 GetCommonName(:P0, ''20'', CD_COURSE) as NM_COURSE, '
             +'       0 as AMT_ORDER, '
             +'       '''' as YMD_LASTORDER, '
             +'       0 as CNT_ORDER '
             +'	from MS_MEMBER  '
             +' where CD_STORE 	=:P0 '
             +' 	 and ( TEL_MOBILE = '+vWhere
             +'		   or TEL_HOME  = '+vWhere
             +'		   or TEL_ETC1  = '+vWhere
             +'		   or TEL_ETC2  = '+vWhere+' ) '
             +'  and DS_STATUS = ''0'' '
             +'	union all  '
             +'select 2 as SEQ, '
             +'		   CD_MEMBER, '
             +'		   NM_NAME, '
             +'		   NO_TEL1, '
             +'		   NO_TEL2, '
             +'		   NO_TEL3, '
             +'		   NO_TEL4, '
             +'		   ADDRESS1, '
             +'		   ADDRESS2, '
             +'		   '''' as REMARK, '
             +'		   CD_LOCAL, '
             +'		   GetCommonName(:P0, ''22'', CD_LOCAL) as NM_LOCAL, '
             +'		   CD_COURSE, '
             +'		   GetCommonName(:P0, ''20'', CD_COURSE) as NM_COURSE, '
             +'       0, '
             +'       '''', '
             +'       0 '
             +'  from SL_DELIVERY '
             +' where CD_STORE 	= :P0 '
             +'	 and NO_TEL1    = :P1 '
             +' limit 1 ',
             [Common.Config.StoreCode,
              Trim(Copy(Common.CidData.Strings[I],1,12))]);

    DeliveryData[vIndex].DeliveryNo := Trim(Copy(Common.CidData.Strings[I],30,12));  //주문중인 배달일때
    DeliveryData[vIndex].OrderDate  := '';
    DeliveryData[vIndex].Customer   := '못받은전화';
    DeliveryData[vIndex].OrderTime  := Trim(Copy(Common.CidData.Strings[I],24,5));
    DeliveryData[vIndex].PhoneNumber:= SetTelephone(Trim(Copy(Common.CidData.Strings[I],1,12)));
    DeliveryData[vIndex].TableNo    := 0;
    if Trim(Copy(Common.CidData.Strings[I],29,1)) = '0' then
      DeliveryData[vIndex].Damdang    := ''
    else
      DeliveryData[vIndex].Damdang    := Trim(Copy(Common.CidData.Strings[I],29,1))+'회선';
    DeliveryData[vIndex].OrderMenu  := '';
    DeliveryData[vIndex].OrderMenuQty  := '';
    DeliveryData[vIndex].dsOrder    := Trim(Copy(Common.CidData.Strings[I],42,8));
    DeliveryData[vIndex].OrderAmt   := '';
    DeliveryData[vIndex].TelNo1     := '';
    DeliveryData[vIndex].TelNo2     := '';
    DeliveryData[vIndex].TelNo3     := '';
    DeliveryData[vIndex].TelNo4     := '';
    DeliveryData[vIndex].LocalCode  := '';
    DeliveryData[vIndex].LocalName  := '';
    DeliveryData[vIndex].CourseCode := '';
    DeliveryData[vIndex].CourseName := '';

    if not Common.Query.Eof then
      DeliveryData[vIndex].Step := Common.Query.FieldByName('nm_name').AsString
    else
      DeliveryData[vIndex].Step := '신규고객';
    Common.Query.Close;
    Inc(vIndex);
  end;
  OrderLabel.Caption    := Format('%s원[%d]',[FormatFloat('#,0', OrderAmt), OrderCnt]);
  DeliveryCountLabel.Caption := FormatFloat('#,0건', DeliveryCnt);
//  lblReturn.Caption   := '미회수 '+FormatFloat('#,0건', ReturnCnt)+Ifthen(ReturnAmt > 0, '-'+FormatFloat('#,0원', ReturnAmt),'');
  MissedCallCountLabel.Caption   := FormatFloat('#,0건', Common.CidData.Count);

  if aMaxPage then
    Page := GetMaxPage;
  SetOrderTable;
end;

procedure TDelivery_F.SetOrderTable;
  procedure TableButtonClear;
  var vIndex :Integer;
  begin
    For vIndex := 0 to ComponentCount-1 do
    begin
      if (Components[vIndex] is TPosButton) and
         ( (Components[vIndex] as TPosButton).Parent = TablePanel ) then
      begin
        (Components[vIndex] as TPosButton).Temp1               := '';
        (Components[vIndex] as TPosButton).Temp2               := '';
        (Components[vIndex] as TPosButton).Temp3               := '';
        (Components[vIndex] as TPosButton).Temp4               := '';
        (Components[vIndex] as TPosButton).Temp5               := '';
        (Components[vIndex] as TPosButton).Temp6               := '';
        (Components[vIndex] as TPosButton).Temp7               := '';
        (Components[vIndex] as TPosButton).Number.NumberString := '';
        (Components[vIndex] as TPosButton).Number.Number       := 0;
        (Components[vIndex] as TPosButton).Number.RightString  := '';
        (Components[vIndex] as TPosButton).Number.CenterString := '';
        (Components[vIndex] as TPosButton).Caption             := '';
        (Components[vIndex] as TPosButton).Menu.Name           := '';
        (Components[vIndex] as TPosButton).Menu.Qty            := '';
        (Components[vIndex] as TPosButton).Amount.Caption      := '';
        (Components[vIndex] as TPosButton).Bottom.LeftString   := '';
        (Components[vIndex] as TPosButton).Bottom.CenterString := '';
        (Components[vIndex] as TPosButton).Bottom.RightString  := '';
        (Components[vIndex] as TPosButton).Number.ShowNumber   := False;
        (Components[vIndex] as TPosButton).Color               := FColor1;// $00C08000;
      end;
    end;
  end;

  function FindTableButton(AButtonName:String):TPosButton;
  var nCnt :Integer;
  begin
    Result := nil;
    For nCnt := 0 to ComponentCount-1 do
    begin
      if (Components[nCnt] is TPosButton) and
         ( (Components[nCnt] as TPosButton).Name = AButtonName ) then
      begin
        Result := (Components[nCnt] as TPosButton);
        Break;
      end;
    end;
  end;
  function GetNotTelData(aValue:String):Boolean;
  var I :Integer;
  begin
    Result := False;
    For I := 0 to Common.CidData.Count-1 do
    begin
      if Trim(Copy(Common.CidData.Strings[I],1,12)) = aValue then
      begin
        Result := True;
        Break;
      end;
    end;
  end;

var vIndex, nMax, nTmp :Integer;
    CurButton: TPosButton;
begin
  TableButtonClear;

  nMax := FXcnt * FYcnt;
  For vIndex := (Page-1) * nMax to ((Page-1) * nMax) + nMax-1 do
  begin
    if vIndex > High(DeliveryData) then
    begin
//      CurButton := FindTableButton( 'TableButton'+IntToStr(vIndex+1-((Page-1) * nMax)) );
//      if CurButton <> nil then
//        CurButton.Color := FColor1;
      Break;
    end;
    CurButton := FindTableButton( 'TableButton'+IntToStr(vIndex+1-((Page-1) * nMax)) );

    if DeliveryData[vIndex].Customer <> '못받은전화' then
    begin
      if (not GetNotTelData(DeliveryData[vIndex].TelNo1)) or
         (not GetNotTelData(DeliveryData[vIndex].TelNo2)) or
         (not GetNotTelData(DeliveryData[vIndex].TelNo3)) or
         (not GetNotTelData(DeliveryData[vIndex].TelNo4)) then
      begin
        CurButton.Bottom.Color        := $0040FF00;
        CurButton.Color               := $00DAB79E;
      end
      else
      begin
        CurButton.Bottom.Color   := $005353FF;
        CurButton.Color          := $005353FF;
      end;
    end
    else
    begin
      CurButton.Caption := DeliveryData[vIndex].PhoneNumber;
      CurButton.Bottom.Color        := $005353FF;
    end;

    CurButton.Temp1               := DeliveryData[vIndex].DeliveryNo;
    CurButton.Temp2               := DeliveryData[vIndex].OrderDate;
    CurButton.Number.Number       := DeliveryData[vIndex].TableNo;
    CurButton.Number.NumberString := ' '+DeliveryData[vIndex].Customer;
    CurButton.Number.CenterString := RightStr(DeliveryData[vIndex].DeliveryNo,4);
    CurButton.Number.RightString  := DeliveryData[vIndex].OrderTime+' ';
    //경과시간 표시
    if GetOption(295) = '1' then
      CurButton.Number.RightString := CurButton.Number.RightString + '('+DeliveryData[vIndex].LapseTime+')';
    CurButton.Menu.Name    := '';
    CurButton.Menu.Qty    := '';

    if CurButton.Color = $00DAB79E then
    begin
      if DeliveryData[vIndex].Step = '미주문' then
      begin
        CurButton.Color   := FColor1;
        CurButton.Font.Size := FCaptionFontSize;
      end
      else if DeliveryData[vIndex].Step = '주문' then
      begin
        CurButton.Color := FColor2;
        CurButton.Font.Size := FMenuFontSize;
      end
      else if DeliveryData[vIndex].Step = '배달' then
      begin
        CurButton.Color := FColor3;
        CurButton.Font.Size := FMenuFontSize;
      end
      else if DeliveryData[vIndex].Step = '계산' then
      begin
        CurButton.Color := FColor4;
        CurButton.Font.Size := FMenuFontSize;
      end;
    end;
    //테이블에 표시할 내용
    CurButton.Amount.Caption      := DeliveryData[vIndex].OrderAmt;
    case StoI(GetOption(187)) of
      1 :  //메뉴
      begin
        if DeliveryData[vIndex].Customer <> '못받은전화' then
        begin
          CurButton.Menu.Name    := DeliveryData[vIndex].OrderMenu;
          CurButton.Menu.Qty     := DeliveryData[vIndex].OrderMenuQty;
        end;
      end;
      2 :  //주소
      begin
        if DeliveryData[vIndex].Customer <> '못받은전화' then
          CurButton.Caption    := DeliveryData[vIndex].Addr1 +#13+DeliveryData[vIndex].Addr2;
        CurButton.Menu.Name := '';
        CurButton.Menu.Qty  := '';
      end;
      3 :  //고객명
      begin
        CurButton.Caption    := DeliveryData[vIndex].Customer;
        if DeliveryData[vIndex].Customer <> '못받은전화' then
        begin
          CurButton.Number.NumberString := LeftStr(DeliveryData[vIndex].DeliveryNo,8)+'-'+RightStr(DeliveryData[vIndex].DeliveryNo,4);
          CurButton.Number.CenterString := '';
        end;

        CurButton.Menu.Name := '';
        CurButton.Menu.Qty  := '';
      end;
      4 : //전화번호
      begin
        if DeliveryData[vIndex].Customer <> '못받은전화' then
        begin
          if DeliveryData[vIndex].TelNo1 <> '' then
            CurButton.Caption    := SetTelephone(DeliveryData[vIndex].TelNo1)
          else if DeliveryData[vIndex].TelNo2 <> '' then
            CurButton.Caption    := SetTelephone(DeliveryData[vIndex].TelNo2)
          else if DeliveryData[vIndex].TelNo3 <> '' then
            CurButton.Caption    := SetTelephone(DeliveryData[vIndex].TelNo3)
          else if DeliveryData[vIndex].TelNo4 <> '' then
            CurButton.Caption    := SetTelephone(DeliveryData[vIndex].TelNo4);

          CurButton.Menu.Name := '';
          CurButton.Menu.Qty  := '';
        end;
      end;
      5 : // 주소+전화번호
      begin
        if DeliveryData[vIndex].Customer <> '못받은전화' then
        begin
          CurButton.Caption   := DeliveryData[vIndex].Addr1 +#13+DeliveryData[vIndex].Addr2+#13;
          if DeliveryData[vIndex].TelNo1 <> '' then
            CurButton.Caption    := CurButton.Caption + '['+SetTelephone(DeliveryData[vIndex].TelNo1)+']'
          else if DeliveryData[vIndex].TelNo2 <> '' then
            CurButton.Caption    := CurButton.Caption + '['+SetTelephone(DeliveryData[vIndex].TelNo2)+']'
          else if DeliveryData[vIndex].TelNo3 <> '' then
            CurButton.Caption    := CurButton.Caption + '['+SetTelephone(DeliveryData[vIndex].TelNo3)+']'
          else if DeliveryData[vIndex].TelNo4 <> '' then
            CurButton.Caption    := CurButton.Caption + '['+SetTelephone(DeliveryData[vIndex].TelNo4)+']';

          CurButton.Menu.Name := '';
          CurButton.Menu.Qty  := '';
        end;
      end;
      6 : // 메뉴 + 전화번호
      begin
        if DeliveryData[vIndex].Customer <> '못받은전화' then
        begin
          CurButton.Menu.Name    := DeliveryData[vIndex].OrderMenu;
          CurButton.Menu.Qty     := DeliveryData[vIndex].OrderMenuQty;
          if DeliveryData[vIndex].TelNo1 <> '' then
            CurButton.Amount.Caption    := SetTelephone(DeliveryData[vIndex].TelNo1)
          else if DeliveryData[vIndex].TelNo2 <> '' then
            CurButton.Amount.Caption    := SetTelephone(DeliveryData[vIndex].TelNo2)
          else if DeliveryData[vIndex].TelNo3 <> '' then
            CurButton.Amount.Caption    := SetTelephone(DeliveryData[vIndex].TelNo3)
          else if DeliveryData[vIndex].TelNo4 <> '' then
            CurButton.Amount.Caption    := SetTelephone(DeliveryData[vIndex].TelNo4);
        end;
      end;

    end;

    CurButton.Bottom.LeftString   := ' '+DeliveryData[vIndex].Step;
    CurButton.Bottom.CenterString := DeliveryData[vIndex].dsOrder;
    CurButton.Bottom.RightString  := DeliveryData[vIndex].Damdang +' ';
    CurButton.Temp3               := DeliveryData[vIndex].PhoneNumber;
    CurButton.Temp4               := DeliveryData[vIndex].TelNo1;;
    CurButton.Temp5               := DeliveryData[vIndex].TelNo2;;
    CurButton.Temp6               := DeliveryData[vIndex].TelNo3;;
    CurButton.Temp7               := DeliveryData[vIndex].TelNo4;;
  end;
  PriorButton.Enabled := Page > 1;
  //총페이지 구함
  nTmp := ((High(DeliveryData)+1) div nMax );
  if ((High(DeliveryData)+1) mod nMax ) > 0 then
    nTmp := nTmp + 1;
  NextButton.Enabled := Page < nTmp ;
end;

procedure TDelivery_F.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  if not isTableCreated then
    TableCreate;
  isTableCreated := true;
  SetDeliveryData;
  if FCidTelNo <> '' then
  begin
    CidReadEvent( FCidTelNo );
  end;
end;

procedure TDelivery_F.SetPage(const Value: Integer);
begin
  FPage := Value;
  lblPage.Caption := IntToStr(FPage);
  SetOrderTable;
end;

procedure TDelivery_F.Tmr_ExecTimer(Sender: TObject);
  function FindTableButton2:TPosButton;
  var vIndex :Integer;
  begin
    Result := nil;
    For vIndex := 0 to ComponentCount-1 do
    begin
      if (Components[vIndex] is TPosButton) and
         ( (Components[vIndex] as TPosButton).Temp1 = FDeliveryNo ) then
      begin
        Result := (Components[vIndex] as TPosButton);
        Break;
      end;
    end;
  end;
var nTmp  :Integer;
    TmpButton :TPosButton;
begin
  Notebook1.ActivePage := 'tbTable';
  Tmr_Exec.Enabled := False;

  case Tmr_Exec.Tag of
    0 : TableButtonClick(nil);
    1 : NotTelButtonClick(nil);
    2 : //주문중인 전화번호이면 기존배달테이블의 색상을 변경한다
    begin
      nTmp := (FIndex+1) div (FXcnt * FYcnt) ;
      if ((FIndex+1) mod (FXcnt * FYcnt) ) > 0 then
        nTmp := nTmp + 1;
      Page := nTmp;
      TmpButton := FindTableButton2;
      TmpButton.Bottom.Color   := $005353FF;
      TmpButton.Color          := $005353FF;
    end;
  end;
end;

procedure TDelivery_F.CallCancelButtonClick(Sender: TObject);
begin
  CallStep := csNone;
end;

procedure TDelivery_F.CashBoxOpenButtonClick(Sender: TObject);
begin
  Common.Device.CashBoxOpen;
end;

procedure TDelivery_F.CidReadEvent(const S: String);
  function FindTableButton(aDeliveryNo:String):TPosButton;
  var vIndex :Integer;
  begin
    Result := nil;
    For vIndex := 0 to ComponentCount-1 do
    begin
      if (Components[vIndex] is TPosButton) and
         ( (Components[vIndex] as TPosButton).Temp1 = aDeliveryNo ) then
      begin
        Result := (Components[vIndex] as TPosButton);
        Break;
      end;
    end;
  end;
var vIndex :Integer;
    vTelNo,
    vDeliveryStep :String;
begin
   if Notebook1.ActivePage = 'tbGrid' then
     Notebook1.ActivePage := 'tbTable';

   vTelNo := Copy(S,4, Length(S)-3);
   vIndex := GetDeliveryOrderDataIndex(Copy(S,4, Length(S)-3));
   if CallStep = csNone then
     lblCallLine.Caption  := Format('[ %s회선 ]',[Copy(S,2,1)]);

   //전화가 왔을때(콜스타)
   if (S[1] = 'C') and (S[3] = 'I') then
   begin
     //전화를 아직 안받았는데 또 전화가 왔을때
     if CallStep = csCall then
     begin
       Common.AddCidData( S, FDeliveryNo);
       SetDeliveryData;
       Exit;
     end;

     //부재중리스트에 있으면 삭제한다
     Common.DeleteCidData(Copy(S,4, Length(S)-3));

     //주문된 배달내역에 있는 전화번호인지 체크한다
     if vIndex >= 0 then
     begin
       FDeliveryNo             := DeliveryOrderData[vIndex].DeliveryNo;
       vDeliveryStep           := DeliveryOrderData[vIndex].Step;
       lblCallCustName.Caption := DeliveryOrderData[vIndex].Customer;
       if vDeliveryStep <> '부재중' then
         lblCallStatus.Caption   := Format('[%s] 상태의 고객',[vDeliveryStep])
       else if lblCallCustName.Caption <> EmptyStr then
         lblCallStatus.Caption := '신규주문'
       else
         lblCallStatus.Caption :='신규고객';
       lblCallNo.Caption       := SetTelephone(vTelNo);
     end
     else
     begin
       SetCustomerInfo(vTelNo);
       lblCallNo.Caption       := SetTelephone(vTelNo);
       FDeliveryNo := EmptyStr;
     end;

     Common.AddCidData( S, FDeliveryNo);
     SetDeliveryData;
     CallStep := csCall;

//     Tmr_Exec.Tag := 1;
//     Tmr_Exec.Enabled := True;
   end
   //전화를 받았을때(콜스타)
   else if (S[1] = 'C') and (S[3] = 'S') then
   begin
     //신규배달전화일때
     if (vIndex < 0) then
     begin
       Common.DeleteCidData(vTelNo);
       FCidTelNo := Copy(S,4, Length(S)-3);
       Tmr_Exec.Tag := 0;
       Tmr_Exec.Enabled := True;
       CallStep := csNone;
     end
     else if (DeliveryOrderData[vIndex].Step ='주문') or (DeliveryOrderData[vIndex].Step ='배달') or (DeliveryOrderData[vIndex].Step ='계산') then
     begin
       CallStep := csNone;
       Common.DeleteCidData(vTelNo);
       CallTelNo := S + DeliveryOrderData[vIndex].DeliveryNo;
       TableButtonClick(FindTableButton(DeliveryOrderData[vIndex].DeliveryNo));
     end;
   end
   else if (S[3] = 'E') or (S[3] = 'A') then
   begin
     CallStep := csNone;
     SetDeliveryData;
   end;
end;

procedure TDelivery_F.CloseButtonClick(Sender: TObject);
begin
  if Notebook1.ActivePage = 'tbGrid' then
  begin
    Notebook1.ActivePage := 'tbTable';
  end
  else
    Close;
end;

procedure TDelivery_F.NewButtonClick(Sender: TObject);
begin
  if Common.WorkDate = EmptyStr then
  begin
    Common.ErrBox('개점이 안됐습니다'+#13#13+'개점을 해야 사용할 수 있습니다');
    Exit;
  end;
  if DeliveryMode <> dmNone then Exit;
  Notebook1.ActivePage := 'tbTable';
  FCidTelNo   := '';
  FDeliveryNo := '';
  TableButtonClick(nil);
end;

procedure TDelivery_F.Notebook1PageChanged(Sender: TObject);
begin
  if Notebook1.ActivePage = 'tbGrid' then
  begin
    Grid.Width := Notebook1.Width;
    SearchButtonClick(nil);
  end;
end;

procedure TDelivery_F.NotTelButtonClick(Sender: TObject);
begin
  Notebook1.ActivePage := 'tbTable';
  FCidTelNo   := '';
  FDeliveryNo := '';
  case DeliveryMode of
    dmNone   :
    begin
      DeliveryMode := dmNotTel;
      SetDeliveryData;
    end;
    dmNotTel :
    begin
      DeliveryMode := dmNone;
      SetDeliveryData;
    end;
  end;
end;

procedure TDelivery_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then CloseButton.Click;

  if Shift = [ssCtrl] then
  begin
    if Key = Ord('T') then
    begin
      CidReadEvent('C1I01011112222');
      Common.AddCidData('C1I01011112222');
    end;
    if Key = Ord('S') then
      CidReadEvent('C1S01011112222');
    if Key = Ord('A') then
      CidReadEvent('C1A');
  end;
end;

function TDelivery_F.GetUseCheck(aDeliveryNo: String): Boolean;
begin
  OpenQuery('select USE_POSNO '
           +'  from SL_DELIVERY '
           +' where CD_STORE     =:P0 '
           +'   and YMD_DELIVERY =:P1 '
           +'   and NO_DELIVERY  =:P2 ',
           [Common.Config.StoreCode,
            LeftStr(aDeliveryNo,8),
            RightStr(aDeliveryNo,4)]);

  if (Common.Query.Fields[0].AsString <> Common.Config.PosNo) and (Common.Query.Fields[0].AsString <> '') then
  begin
    Common.ErrBox(Common.Query.Fields[0].AsString+'번 포스에서 사용 중 입니다');
    Result := False;
  end
  else Result := True;

  Common.Query.Close;
end;

function TDelivery_F.GetDeliveryOrderDataIndex(aData: String): Integer;
var I :Integer;
begin
  Result := -1;
  For I := 0 to High(DeliveryOrderData) do
  begin
    if ((DeliveryOrderData[I].Step = '미주문') or
        (DeliveryOrderData[I].Step = '주문') or
        (DeliveryOrderData[I].Step = '배달') )
     and
       ((DeliveryOrderData[I].TelNo1 = aData) or
       (DeliveryOrderData[I].TelNo2 = aData) or
       (DeliveryOrderData[I].TelNo3 = aData) or
       (DeliveryOrderData[I].TelNo4 = aData))  then
    begin
      Result := I;
      Break;
    end;
  end;
end;

procedure TDelivery_F.bvGridViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  if AItem = nil then Exit;
  if (ARecord.Values[bvGridViewStep.Index] = '매출취소') or (ARecord.Values[bvGridViewStep.Index] = '주문취소') then
    AStyle := RedFontStyle
  else if (ARecord.Values[bvGridViewStep.Index] = '미주문') then
    AStyle := BlueFontStyle;

end;

function TDelivery_F.GetMaxPage: Integer;
var vMax :Integer;
begin
  vMax := FXcnt * FYcnt;

  Result := ((High(DeliveryData)+1) div vMax );
  if ((High(DeliveryData)+1) mod vMax ) > 0 then
    Result := Result + 1;

  if Result = 0 then
    Result := 1;
end;

procedure TDelivery_F.dteToPropertiesChange(Sender: TObject);
begin
  if (Sender = FromDatePicker) and (FromDatePicker.Date > ToDatePicker.Date) then
    ToDatePicker.Date := FromDatePicker.Date
  else if (Sender = ToDatePicker) and (FromDatePicker.Date > ToDatePicker.Date) then
    FromDatePicker.Date := ToDatePicker.Date;
end;

procedure TDelivery_F.SearchButtonClick(Sender: TObject);
var vIndex :Integer;
begin
  OpenQuery('select StoDW(a.YMD_DELIVERY) AS YMD_DELIVERY, '
           +'       a.NO_DELIVERY as DELIVERYNO, '
           +'       case a.DS_ORDER when ''D'' then ''배달'' '
           +'                                  when ''P'' THEN ''포장'' '
           +'       end as DS_ORDER, '
           +'       case a.DS_STEP when ''A'' then ''정산완료'' '
           +'                      when ''O'' then ''주문'' '
           +'                      when ''D'' then ''배달 중''  '
           +'                      when ''C'' then ''주문취소'' '
           +'                      when ''R'' then ''그릇회수'' '
           +'                      when ''N'' then ''미주문'' '
           +'                      when ''V'' then ''매출취소'' '
           +'       end as DS_STEP, '
           +'       case when a.DS_STEP in (''A'',''R'',''V'') then ifnull(d.AMT_SALE,0) else ifnull(a.AMT_ORDER,0) end as AMT_ORDER, '
           +'       a.NM_NAME, '
           +'       case when a.NO_TEL1 <> '''' then GetPhoneNo(a.NO_TEL1) '
           +'            else case when a.NO_TEL2 <> '''' then GetPhoneNo(a.NO_TEL2) '
           +'                      else case when a.NO_TEL3 <> '''' then GetPhoneNo(a.NO_TEL3) '
           +'                                else case when a.NO_TEL4 <> '''' then GetPhoneNo(a.NO_TEL4) '
           +'                                     end '
           +'                           end '
           +'                  end '
           +'       end as NO_TEL1,'
           +'       ConCat(a.ADDRESS1,'' '',ADDRESS2) as ADDR, '
           +'       b.NM_SAWON, '
           +'       c.NM_SAWON AS RECALL_SAWON, '
           +'       GetCommonName(a.CD_STORE, ''22'', a.CD_LOCAL) AS LOCAL, '
           +'       GetCommonName(a.CD_STORE, ''20'', a.CD_COURSE) AS COURSE, '
           +'       a.COUPON_CNT, '
           +'       case  a.PAYTYPE when ''CARD'' then ''카드'' when ''CASH'' then ''현금'' when ''ETC'' then ''복합'' else a.PAYTYPE end as PAYTYPE, '
           +'       ConCat(d.YMD_SALE,''-'',d.NO_POS,''-'',d.NO_RCP) as NO_RCP, '
           +'       ConCat(a.YMD_DELIVERY,a.NO_DELIVERY) as LINK '
           +'  from SL_DELIVERY a  left outer join '
           +'       MS_SAWON    b  on a.CD_STORE = b.CD_STORE '
           +'                     and a.CD_SAWON = b.CD_SAWON left outer join '
           +'       MS_SAWON    c  on a.CD_STORE = c.CD_STORE '
           +'                     and a.RECALL_SAWON = c.CD_SAWON left outer join '
           +'       SL_SALE_H   d  on a.CD_STORE = d.CD_STORE '
           +'                     and Length(d.NO_DELIVERY) = 12 '
           +'                     and ConCat(a.YMD_DELIVERY,a.NO_DELIVERY) = d.NO_DELIVERY  '
           +' where a.CD_STORE      = :P0 '
           +'   and a.YMD_DELIVERY BETWEEN :P1 AND :P2 '
           +' order by a.YMD_DELIVERY, a.NO_DELIVERY ',
           [Common.Config.StoreCode,
            DtoS(FromDatePicker.Date),
            DtoS(ToDatePicker.Date)]);

  DM.ReadQuery(Common.Query, nil, MemData);

  OpenQuery('select a.CD_MENU, '
           +'       c.NM_MENU, '
           +'      a.QTY_SALE, '
           +'      a.PR_SALE, '
           +'      a.AMT_SALE, '
           +'      b.NO_DELIVERY as LINK '
           +' from SL_SALE_D   a  inner join '
           +'      SL_SALE_H   b  on a.CD_STORE = b.CD_STORE '
           +'                    and a.YMD_SALE = b.YMD_SALE '
           +'                    and a.NO_POS   = b.NO_POS '
           +'                    and a.NO_RCP   = b.NO_RCP '
           +'                    and Length(b.NO_DELIVERY) = 12 left outer join '
           +'      MS_MENU     c  on a.CD_STORE = c.CD_STORE '
           +'                    and a.CD_MENU  = c.CD_MENU inner join '
           +'      SL_DELIVERY d  on b.CD_STORE = d.CD_STORE '
           +'                    and b.NO_DELIVERY = ConCat(d.YMD_DELIVERY,d.NO_DELIVERY) '
           +'                    and d.DS_STEP not in (''C'',''V'') '
           +'where a.CD_STORE =:P0 '
           +'  and a.YMD_SALE between :P1 and :P2 '
           +'order by d.YMD_DELIVERY, d.NO_DELIVERY ',
           [Common.Config.StoreCode,
            DtoS(FromDatePicker.Date),
            DtoS(ToDatePicker.Date)]);

  DM.ReadQuery(Common.Query, nil, SubMemData);


  if GetOption(290) = '0' then
  begin
    bvGridView.DataController.Summary.FooterSummaryValues[0] := 0;
    For vIndex := 0 to bvGridView.DataController.RecordCount-1 do
    begin
      if (bvGridView.DataController.Values[vIndex, bvGridViewStep.Index] <> '매출취소') and (bvGridView.DataController.Values[vIndex, bvGridViewStep.Index] <> '주문취소') and (bvGridView.DataController.Values[vIndex, bvGridViewStep.Index] <> '미주문') then
        bvGridView.DataController.Summary.FooterSummaryValues[0] := bvGridView.DataController.Summary.FooterSummaryValues[0] + bvGridView.DataController.Values[vIndex, bvGridViewOrderAmt.Index];
    end;
  end;

  OpenQuery('select  GetPhoneNo(t1.NO_TEL) as NO_TEL, '
           +'        t1.DT_CALL, '
           +'        case t1.DS_ORDER when ''미주문'' then ''미주문'' else ''주문'' end as DS_ORDER, '
           +'        case t1.DS_ORDER when ''미주문'' then ifnull((select NM_NAME '
           +'        				                                   	    from SL_DELIVERY '
           +'        				                                    	 where CD_STORE = t1.CD_STORE '
           +'        				                                         and ((NO_TEL1 = t1.NO_TEL) or (NO_TEL2 = t1.NO_TEL) or (NO_TEL3 = t1.NO_TEL) or (NO_TEL4 = t1.NO_TEL)) '
           +'                                                       limit 1) ,''신규고객'') '
           +'        			                             else t1.DS_ORDER end as NM_CUST '
           +'  from ( '
           +'        select a.CD_STORE, '
           +'               a.SEQ, '
           +'               a.NO_TEL, '
           +'             	a.DT_CALL, '
           +'               ifnull((select NM_NAME '
           +'        		              from SL_DELIVERY '
           +'        		             where CD_STORE = a.CD_STORE '
           +'        		               and ((NO_TEL1 = a.NO_TEL) or (NO_TEL2 = a.NO_TEL) or (NO_TEL3 = a.NO_TEL) or (NO_TEL4 = a.NO_TEL)) '
           +'        		               and (DT_ORDER between a.DT_CALL and Date_add(a.DT_CALL, INTERVAL 10 MINUTE)) '
           +'                        limit 1),''미주문'') as DS_ORDER, '
           +'              	a.NO_LINE  '
           +'          from SL_CID_LOG a '
           +'         where a.CD_STORE =:P0 '
           +'           and Date_Format(a.DT_CALL, ''%Y%m%d'') between :P1 and :P2 '
           +'        ) t1 '
           +' order by t1.seq ',
           [Common.Config.StoreCode,
            DtoS(FromDatePicker.Date),
            DtoS(ToDatePicker.Date)]);

  DM.ReadQuery(Common.Query, TelGridView);

end;

procedure TDelivery_F.SetCallStep(AValue: TCallStep);
begin
  FCallStep := AValue;
  case FCallStep of
    csNone :
    begin
      panCall.Visible         := false;
      Notebook1.Enabled       := true;
      ButtonPanel.Enabled       := true;
    end;
    csCall :
    begin
      panCall.Visible         := true;
      Notebook1.Enabled       := false;
      ButtonPanel.Enabled       := false;
    end;
  end;
end;

procedure TDelivery_F.SetCustomerInfo(aValue: String);
begin
  OpenQuery('select 1 as SEQ, '
           +'		    NM_MEMBER	AS NM_NAME, '
           +'       CD_MEMBER, '
           +'			  ADDR1		as ADDRESS1, '
           +'			  ADDR2		as ADDRESS2 '
           +'	 from MS_MEMBER  '
           +' where CD_STORE 	=:P0 '
           +' 	and ( TEL_MOBILE = :P1'
           +'		   or TEL_HOME  = :P1'
           +'		   or TEL_ETC1  = :P1'
           +'		   or TEL_ETC2  = :P1 ) '
           +'  and DS_STATUS = ''0'' '
           +'	union all  '
           +'select 2 as SEQ, '
           +'		    NM_NAME, '
           +'       '''', '
           +'		    ADDRESS1, '
           +'		    ADDRESS2 '
           +'  from SL_DELIVERY '
           +' where CD_STORE 	= :P0 '
           +'	  and NO_TEL1   = :P1 '
           +' limit 1 ',
           [Common.Config.StoreCode,
            aValue]);

  if not Common.Query.Eof then
  begin
    lblCallStatus.Caption   := '신규주문';
    lblCallCustName.Caption := Common.Query.FieldByName('NM_NAME').AsString;
    lblCallCustName.Hint    := Common.Query.FieldByName('CD_MEMBER').AsString;
  end
  else
  begin
    lblCallStatus.Caption   := '신규고객';
    lblCallCustName.Caption := EmptyStr;
    lblCallCustName.Hint    := '';
  end;
  Common.Query.Close;
end;

procedure TDelivery_F.imgCallClick(Sender: TObject);
begin
  CidReadEvent('C'+GetOnlyNumber(lblCallLine.Caption)+'S'+GetOnlyNumber(lblCallNo.Caption));
end;

end.

