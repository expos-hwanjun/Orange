unit BookingList_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxLabel, cxCurrencyEdit,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxControls, cxGridCustomView, cxGrid, VirtualCalendar, cxPC,
  cxContainer, ExtCtrls, Menus, DateUtils,
  cxLookAndFeelPainters, StdCtrls, cxButtons, SBPosButton, StrUtils,
  MemDS, DBAccess, Uni, cxLookAndFeels, cxPCdxBarPopupMenu, cxNavigator,
  AdvPageControl, Vcl.ComCtrls, AdvGlassButton, AdvSmoothCalendar, PosButton,
  Math, dxDateRanges, dxScrollbarAnnotations;

type
  TBtnSize = ^ButtonSize;
  ButtonSize = record
    Left         : Integer;
    Top          : Integer;
    Height       : Integer;
    Width        : Integer;
    Number       : Integer;
    Amount       : String;
    Name         : String;
    Row          : Integer;
    Col          : Integer;
  end;

type
  TBookingList_F = class(TForm)
    ReservePager: TAdvPageControl;
    CalendarTabSheet: TAdvTabSheet;
    DayTabSheet: TAdvTabSheet;
    Grid: TcxGrid;
    GridLevel: TcxGridLevel;
    TitleLabel: TLabel;
    CloseButton: TcxButton;
    PrevMonthButton: TAdvGlassButton;
    NextMonthButton: TAdvGlassButton;
    MonthLabel: TLabel;
    SumLabel: TcxLabel;
    SatLabel: TcxLabel;
    ThuLabel: TcxLabel;
    WedLabel: TcxLabel;
    TueLabel: TcxLabel;
    SunLabel: TcxLabel;
    MonLabel: TcxLabel;
    FriLabel: TcxLabel;
    GridTableView: TcxGridTableView;
    GridTableViewColumn1: TcxGridColumn;
    GridTableViewColumn2: TcxGridColumn;
    GridTableViewColumn3: TcxGridColumn;
    GridTableViewColumn4: TcxGridColumn;
    GridTableViewColumn5: TcxGridColumn;
    GridTableViewColumn6: TcxGridColumn;
    GridTableViewColumn7: TcxGridColumn;
    GridTableViewColumn8: TcxGridColumn;
    StyleRepository: TcxStyleRepository;
    cxStyle41: TcxStyle;
    StyleHeader: TcxStyle;
    StyleFooter: TcxStyle;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure PrevMonthButtonClick(Sender: TObject);
    procedure NextMonthButtonClick(Sender: TObject);
    procedure CalendarTabSheetResize(Sender: TObject);
    procedure DayTabSheetShow(Sender: TObject);
  private
    FSearchDate :TDateTime;
    vWeek      :Integer;
    BtnSize    :TBtnSize;

    DateButton: array[0..6] of array[0..7] of TPosButton;
    WeekCount : Integer;

    procedure ShowText;
    procedure DoSearch;
    procedure ButtonClick(Sender:TObject);

  public
    { Public declarations }
  end;

var
  BookingList_F: TBookingList_F;

implementation
uses Common_U, GlobalFunc_U, DBModule_U;
{$R *.dfm}

procedure TBookingList_F.FormCreate(Sender: TObject);
var
  vRow, vCol: Integer;
begin
  Common.LogoCreate(Self,1);
  // 날짜 버튼을 만든다
  for vRow := Low(DateButton) to High(DateButton) do
    for vCol := Low(DateButton[vRow]) to High(DateButton[vRow]) do
    begin
      DateButton[vRow, vCol] := TPosButton.Create(self);
      DateButton[vRow, vCol].Parent             := CalendarTabSheet;
      DateButton[vRow, vCol].Number.ShowNumber  := (vCol < 7) and (vRow < 6);
      DateButton[vRow, vCol].Number.Font.Name   := self.Font.Name;
      DateButton[vRow, vCol].Number.Font.Size   := self.Font.Size;
      DateButton[vRow, vCol].BorderStyle        := pbsNone;
      DateButton[vRow, vCol].BorderInnerColor   := clNone;
      DateButton[vRow, vCol].Number.Font.Style  := [fsBold];
      DateButton[vRow, vCol].Menu.Font.Name     := '맑은 고딕';
      DateButton[vRow, vCol].Menu.Font.Size := 9;
      DateButton[vRow, vCol].Color              := IfThen((vCol = 7) and (vRow = 6), $00ACACFF, IfThen((vCol = 7) or (vRow = 6), $00DFDFFF, $00EEEEEE));
      DateButton[vRow, vCol].Bottom.Font.Name   := '맑은 고딕';
      DateButton[vRow, vCol].Bottom.Font.Size   := 9;
    end;
  WeekCount := High(DateButton)+1;
end;

procedure TBookingList_F.PrevMonthButtonClick(Sender: TObject);
begin
  FSearchDate := IncMonth(FSearchDate,-1);
  MonthLabel.Caption      := FormatDateTime('yyyy-mm', FSearchDate);
  DoSearch;
end;

procedure TBookingList_F.NextMonthButtonClick(Sender: TObject);
begin
  FSearchDate         := IncMonth(FSearchDate,1);
  MonthLabel.Caption     := FormatDateTime('yyyy-mm', FSearchDate);
  DoSearch;

end;

procedure TBookingList_F.FormShow(Sender: TObject);
begin
  FSearchDate := Now();
  ReservePager.ActivePageIndex := 0;
  MonthLabel.Caption := FormatDateTime('yyyy-mm', FSearchDate);
  DoSearch;
end;


procedure TBookingList_F.ShowText;
var
  vRow, vCol, vTextCount: Integer;
  vProfitRate :String;
begin
  vTextCount := DateButton[0, 0].Width div 6 - 7;
  if vTextCount <= 0 then
    vTextCount := 10;

  // 날짜별 매출을 버튼에 표시한다
  for vRow := Low(DateButton) to High(DateButton) do
    for vCol := Low(DateButton[vRow]) to High(DateButton[vRow]) do
      if DateButton[vRow, vCol].Temp1 <> EmptyStr then
      begin
        DateButton[vRow, vCol].Menu.Name  := '전체'+#13+'방문'+#13+'미방문';
        DateButton[vRow, vCol].Menu.Qty   := DateButton[vRow, vCol].Temp1+#13
                                           + DateButton[vRow, vCol].Temp2+#13
                                           + DateButton[vRow, vCol].Temp3
      end
      else
      begin
        DateButton[vRow, vCol].Menu.Name   := EmptyStr;
        DateButton[vRow, vCol].Menu.Qty    := EmptyStr;
      end;
end;

procedure TBookingList_F.ButtonClick(Sender: TObject);
var vTemp :String;
begin
  vTemp := FormatDateTime('yyyymm',FSearchDate) + FormatFloat('00',(Sender as TPosButton).Number.Number);
  //선택된 일자의 색상을 변경한다
  FSearchDate := StoD(vTemp);

  ReservePager.ActivePageIndex := 1;
end;

procedure TBookingList_F.CalendarTabSheetResize(Sender: TObject);
var
  vRow, vCol, vWidth, vHeight, vTop: Integer;
begin
  inherited;

  // 제목 레이블 크기를 조정한다
  vWidth := (CalendarTabSheet.Width - 6 - 16) div 8;
  for vCol := 0 to ComponentCount-1 do
    if (Components[vCol] is TcxLabel) and (TcxLabel(Components[vCol]).Parent = CalendarTabSheet) then
    begin
      TcxLabel(Components[vCol]).Width := vWidth;
      TcxLabel(Components[vCol]).Left  := (TcxLabel(Components[vCol]).Tag - 1) * (vWidth + 2) + 3;
      TcxLabel(Components[vCol]).Top   := 1;
    end;

  // 날짜 버튼 크기를 조정한다
  vHeight := (CalendarTabSheet.Height - SunLabel.Top - SunLabel.Height - 6 - (WeekCount-1)*2) div WeekCount;
  vTop    := SunLabel.Top + SunLabel.Height - vHeight;
  if Assigned(DateButton[0, 0]) and (DateButton[0, 0] <> nil) then
  begin
    for vRow := Low(DateButton) to High(DateButton) do
      if DateButton[vRow, 0].Visible then
      begin
        Inc(vTop, vHeight + 2);
        for vCol := Low(DateButton[vRow]) to High(DateButton[vRow]) do
        begin
          DateButton[vRow, vCol].Width  := vWidth;
          DateButton[vRow, vCol].Left   := vCol * (vWidth + 2) + 3;
          DateButton[vRow, vCol].Height := vHeight;
          DateButton[vRow, vCol].Number.Height := Trunc(vHeight * 0.15);
          DateButton[vRow, vCol].Top    := vTop;
          DateButton[vRow, vCol].Bottom.Height := 0;
        end;
      end;
    // 매출 내용을 다시 표시한다
    ShowText;
  end;
end;

procedure TBookingList_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TBookingList_F.DayTabSheetShow(Sender: TObject);
begin
  OpenQuery('select Date_Format(DT_BOOKING, ''%Y-%m-%d'') as YMD_RESVRVE, '
           +'       case when NM_NAME = '''' then NM_NAME '
           +'                                  else ConCat(NM_NAME,''(회원)'') '
           +'       end as NM_GUEST, '
           +'       NO_TEL as TEL_MOBILE, '
           +'       Date_Format(DT_BOOKING, ''%H시%i분'') as RESVRVE_TIME, '
           +'       CNT_PERSON, '
           +'       AMT_BOOKING, '
           +'       case when YN_SALE = ''Y'' then ''방문'' else ''미방문'' end as YN_VISIT,  '
           +'       REMARK '
           +'  from SL_BOOKING  '
           +' where CD_STORE =:P0 '
           +'   and Date_Format(DT_BOOKING, ''%Y%m'') = Left(:P1,6) '
           +'order by DT_BOOKING ',
           [Common.Config.StoreCode,
            DtoS(FSearchDate)]);
  Common.OpenDataToGrid(Common.Query, GridTableView);
end;

procedure TBookingList_F.DoSearch;
var
  vStartWeekDay, vLastMonthEndDay, vThisMonthEndDay, vThisMonthStartWeekday, vThisMonthEndWeekday: Integer;
  vRow, vCol: Integer;
  vButton: TPosButton;
  vMonth : TDateTime;
begin
  vMonth := StrToDate(MonthLabel.Caption +'-01');
  // 지난 달의 말일을 구한다
  vLastMonthEndDay       := DayOf(EndOfTheMonth(IncMonth(vMonth, -1)));
  // 이번 달의 말일을 구한다
  vThisMonthEndDay       := DayOf(EndOfTheMonth(vMonth));
  // 첫주의 첫번째 날(일)을 구한다
  if DayOfTheWeek(StartOfTheMonth(vMonth)) = 1 then // 이번달 첫날이 월요일이면 무조건 전달 마지막날
    vStartWeekDay          := vLastMonthEndDay
  else // 이번달 첫날이 월요일이 아니면 그 주의 첫날-1 (델파이가 첫날을 일요일이 아닌 월요일로 구하므로)
    vStartWeekDay          := DayOf(StartOfTheWeek(StartOfTheMonth(vMonth) + IfThen(DayOfTheWeek(StartOfTheMonth(vMonth)) = 7, 1, 0))) - 1;
  // 이번 달의 첫날 요일을 구한다
  vThisMonthStartWeekday := IfThen(DayOfTheWeek(StartOfTheMonth(vMonth)) = 7, 0, DayOfTheWeek(StartOfTheMonth(vMonth)));
  // 이번 달의 마지막날 요일을 구한다
  vThisMonthEndWeekday   := IfThen(DayOfTheWeek(EndOfTheMonth(vMonth)) = 7, 0, DayOfTheWeek(EndOfTheMonth(vMonth)));

  // 날짜 버튼에 날짜를 표시한다
  for vRow := Low(DateButton) to High(DateButton)-1 do
    for vCol := Low(DateButton[vRow]) to High(DateButton[vRow])-1 do
    begin
      DateButton[vRow, vCol].Visible             := true;
      DateButton[vRow, vCol].Color               := $00EEEEEE;
      DateButton[vRow, vCol].Temp1               := EmptyStr;
      DateButton[vRow, vCol].Temp2               := EmptyStr;
      DateButton[vRow, vCol].Temp3               := EmptyStr;

      // 지난달 뒷날짜 표시(이번달 1일이 화요일일 경우 일,월요일에 해당하는 이전달 날짜 표시)
      if (vRow = 0) and (vStartWeekDay > 1) and (vStartWeekDay+vCol <= vLastMonthEndDay) then
      begin
        DateButton[vRow, vCol].Number.Number       := vStartWeekDay+vCol;
        DateButton[vRow, vCol].Number.Font.Color   := clGray;
        DateButton[vRow, vCol].Menu.Font.Color := clGray;
        DateButton[vRow, vCol].Hint                := Copy(DtoS(IncMonth(vMonth,-1)),1,6) + FormatFloat('00', DateButton[vRow, vCol].Number.Number);
      end
      // 이번달 날짜들 표시
      else if vRow*7+vCol+1-vThisMonthStartWeekday <= vThisMonthEndDay then
      begin
        DateButton[vRow, vCol].Number.Number       := vRow*7+vCol+1-vThisMonthStartWeekday;
        DateButton[vRow, vCol].Number.Font.Color   := IfThen(vCol = 0, clRed, IfThen(vCol = 6, clBlue, clBlack));
        DateButton[vRow, vCol].Menu.Font.Color := clBlack;
        DateButton[vRow, vCol].Hint                := Copy(DtoS(vMonth),1,6) + FormatFloat('00', DateButton[vRow, vCol].Number.Number);

        // 날짜가 조회 날짜면 색깔을 바꾼다
        if DateButton[vRow, vCol].Hint = DtoS(vMonth) then
          DateButton[vRow, vCol].Color        := $00CAF3BC;
      end
      // 화면을 벗어나는 버튼 숨기기(이번달이 총 4주일 경우 5, 6주에 해당하는 버튼 숨기기)
      else if (vCol-vThisMonthEndWeekday <= 0) or (not DateButton[vRow, 0].Visible) then
      begin
        DateButton[vRow, vCol].Visible             := false;
        DateButton[vRow, vCol].Hint                := EmptyStr;
      end
      // 다음달 시작날짜 표시(이번달 말일이 목요일일 경우 금,토요일에 해당하는 다음날 날짜 표시)
      else
      begin
        DateButton[vRow, vCol].Number.Number       := vCol-vThisMonthEndWeekday;
        DateButton[vRow, vCol].Number.Font.Color   := clGray;
        DateButton[vRow, vCol].Menu.Font.Color := clGray;
        DateButton[vRow, vCol].Hint                := Copy(DtoS(IncMonth(vMonth,1)),1,6) + FormatFloat('00', DateButton[vRow, vCol].Number.Number);
      end;
    end;
  DateButton[4, 7].Visible := DateButton[4, 0].Visible;
  DateButton[5, 7].Visible := DateButton[5, 0].Visible;
  WeekCount := IfThen(not DateButton[4, 0].Visible, 5, IfThen(not DateButton[5, 0].Visible, 6, 7));
  CalendarTabSheetResize(self);


  OpenQuery('select Date_Format(DT_BOOKING, ''%Y%m%d''), '
           +'       count(*), '
           +'       Sum(case when YN_SALE = ''Y'' then 1 else 0 end) as CNT_SALE, '
           +'       Sum(case when YN_SALE = ''N'' then 1 else 0 end) as CNT_NOSALE '
           +'  from SL_BOOKING  '
           +' where CD_STORE =:P0 '
           +'   and Date_Format(DT_BOOKING, ''%Y%m'') = :P1 '
           +' group by Date_Format(DT_BOOKING, ''%Y%m%d'') ',
           [Common.Config.StoreCode,
            GetOnlyNumber(MonthLabel.Caption)]);
  try
    while not Common.Query.Eof do
    begin
      // 날짜에 해당하는 버튼을 찾는다
      vButton := nil;
      for vRow := Low(DateButton) to High(DateButton)-1 do
        for vCol := Low(DateButton[vRow]) to High(DateButton[vRow])-1 do
          if DateButton[vRow, vCol].Hint = Common.Query.Fields[0].AsString then
          begin
            vButton := DateButton[vRow, vCol];
            vButton.OnClick := ButtonClick;
            vButton.Temp8 := vButton.Hint;
            break;
          end;
      if vButton <> nil then
      begin
        // 각 날짜별 매출을 구한다
        vButton.Temp1 := Common.Query.Fields[1].AsString; //총예약건수
        vButton.Temp2 := Common.Query.Fields[2].AsString; //방문
        vButton.Temp3 := Common.Query.Fields[3].AsString; //미방문
      end;

      Common.Query.Next;
    end;
  finally
    Common.Query.Close;
  end;

  // 주, 요일 합계를 구한다
  for vRow := Low(DateButton) to High(DateButton)-1 do
  begin
    DateButton[vRow, High(DateButton[vRow])].Temp1 := EmptyStr;
    DateButton[vRow, High(DateButton[vRow])].Temp2 := EmptyStr;
    DateButton[vRow, High(DateButton[vRow])].Temp3 := EmptyStr;
  end;

  for vCol := Low(DateButton[0]) to High(DateButton[0]) do
  begin
    DateButton[High(DateButton), vCol].Temp1       := EmptyStr;
    DateButton[High(DateButton), vCol].Temp2       := EmptyStr;
    DateButton[High(DateButton), vCol].Temp3       := EmptyStr;
  end;

  for vRow := Low(DateButton) to High(DateButton)-1 do
    for vCol := Low(DateButton[vRow]) to High(DateButton[vRow])-1 do
    begin
      if Copy(DtoS(vMonth),1,6) = LeftStr(DateButton[vRow, vCol].Hint,6) then
      begin
        DateButton[vRow, High(DateButton[vRow])].Temp1 := FloatToStr(StoF(DateButton[vRow, High(DateButton[vRow])].Temp1) + StoF(DateButton[vRow, vCol].Temp1));
        DateButton[vRow, High(DateButton[vRow])].Temp2 := FloatToStr(StoF(DateButton[vRow, High(DateButton[vRow])].Temp2) + StoF(DateButton[vRow, vCol].Temp2));
        DateButton[vRow, High(DateButton[vRow])].Temp3 := FloatToStr(StoF(DateButton[vRow, High(DateButton[vRow])].Temp3) + StoF(DateButton[vRow, vCol].Temp3));

        DateButton[High(DateButton), vCol].Temp1       := FloatToStr(StoF(DateButton[High(DateButton), vCol].Temp1)       + StoF(DateButton[vRow, vCol].Temp1));
        DateButton[High(DateButton), vCol].Temp2       := FloatToStr(StoF(DateButton[High(DateButton), vCol].Temp2)       + StoF(DateButton[vRow, vCol].Temp2));
        DateButton[High(DateButton), vCol].Temp3       := FloatToStr(StoF(DateButton[High(DateButton), vCol].Temp3)       + StoF(DateButton[vRow, vCol].Temp3));
      end;
    end;

  for vCol := Low(DateButton[0]) to High(DateButton[0])-1 do
  begin
    DateButton[High(DateButton), High(DateButton[vRow])].Temp1 := FloatToStr(StoF(DateButton[High(DateButton), High(DateButton[vRow])].Temp1) + StoF(DateButton[High(DateButton), vCol].Temp1));
    DateButton[High(DateButton), High(DateButton[vRow])].Temp2 := FloatToStr(StoF(DateButton[High(DateButton), High(DateButton[vRow])].Temp2) + StoF(DateButton[High(DateButton), vCol].Temp2));
    DateButton[High(DateButton), High(DateButton[vRow])].Temp3 := FloatToStr(StoF(DateButton[High(DateButton), High(DateButton[vRow])].Temp3) + StoF(DateButton[High(DateButton), vCol].Temp3));
  end;

  ShowText;
end;

end.
