unit BookingDate_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, OXSpeedButton, Mask, Grids, Calendar,
  SBPosButton, cxLabel, cxEdit, StrUtils, PlannerCal, AdvDateTimePicker,
  Vcl.ComCtrls, AdvSmoothTimeLine;
type
  TBtnSize = ^ButtonSize;
  ButtonSize = record
    Left         : Integer;
    Top          : Integer;
    Height       : Integer;
    Width        : Integer;
    Number       : Integer;
    Name         : String;
    Row          : Integer;
    Col          : Integer;
  end;

type
  TBookingDate_F = class(TForm)
    medt_time: TMaskEdit;
    obtn_halftime: TOXSpeedButton;
    obtn_confirm: TOXSpeedButton;
    obtn_ampm: TOXSpeedButton;
    fbtn_time5: TOXSpeedButton;
    fbtn_time4: TOXSpeedButton;
    fbtn_time2: TOXSpeedButton;
    fbtn_time1: TOXSpeedButton;
    fbtn_time11: TOXSpeedButton;
    fbtn_time10: TOXSpeedButton;
    fbtn_time8: TOXSpeedButton;
    fbtn_time7: TOXSpeedButton;
    fbtn_time12: TOXSpeedButton;
    fbtn_time3: TOXSpeedButton;
    fbtn_time9: TOXSpeedButton;
    fbtn_time6: TOXSpeedButton;
    obtn_close: TOXSpeedButton;
    lblTitle: TLabel;
    Calendar: TPlannerCalendar;
    AdvSmoothTimeLine1: TAdvSmoothTimeLine;
    TimePicker: TDateTimePicker;
    AdvDateTimePicker1: TAdvDateTimePicker;
    procedure obtn_closeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure fbtn_time12Click(Sender: TObject);
    procedure obtn_halftimeClick(Sender: TObject);
    procedure obtn_confirmClick(Sender: TObject);
    procedure obtn_ampmClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    vWeek      :Integer;
    BtnSize    :TBtnSize;
    FTimeMode :Boolean; //True - AM, False -PM
    procedure SetCalender(aDate:TDateTime);
    procedure ButtonClear;
    procedure ButtonClick(Sender:TObject);
  public
    FDateTime :String;
  end;

var
  BookingDate_F: TBookingDate_F;

implementation
uses Common_U, GlobalFunc_U;
{$R *.dfm}

procedure TBookingDate_F.obtn_closeClick(Sender: TObject);
begin
  Close;
end;

procedure TBookingDate_F.FormCreate(Sender: TObject);
begin
  Common.ImageCreate(Self,'bookingdateform');
  Common.EventApply(Self);
end;

procedure TBookingDate_F.fbtn_time12Click(Sender: TObject);
begin
  medt_time.Text := Lpad( (Sender as TOXSpeedButton).Caption, 2,'0')+':00';
end;

procedure TBookingDate_F.obtn_halftimeClick(Sender: TObject);
begin
  medt_time.Text := Lpad( Copy(medt_time.Text,1,2) + ':30', 5, '0');
end;

procedure TBookingDate_F.obtn_confirmClick(Sender: TObject);
begin
  if Length(lbl_Date.Caption) <> 10 then
  begin
    Common.ErrBox('예약일자를 선택하세요');
    Exit;
  end;
  if Trim(medt_time.Text) = ':' then
  begin
    Common.ErrBox('예약시간을 입력하세요');
    Exit;
  end;
  ModalResult := mrOK;
end;

procedure TBookingDate_F.obtn_ampmClick(Sender: TObject);
var vIdx :Integer;
begin
  For vIdx := 1 to 12 do
    if FTimeMode then
      TOXSpeedButton(FindComponent('fbtn_time'+IntToStr(vIdx))).Caption := IntToStr(vIdx)
    else
    begin
      if vIdx < 12 then
        TOXSpeedButton(FindComponent('fbtn_time'+IntToStr(vIdx))).Caption := IntToStr(vIdx+12)
      else
        TOXSpeedButton(FindComponent('fbtn_time'+IntToStr(vIdx))).Caption := '0';
    end;

  FTimeMode := not FTimeMode;
end;

procedure TBookingDate_F.FormShow(Sender: TObject);
var vIndex :Integer;
begin
  if FDateTime = '' then FDateTime := FormatDateTime('yyyy-mm-dd hh:mm', now);
  lbl_Date.Caption  := LeftStr(FDateTime,7);
  SetCalender(StoD(GetOnlyNumber(LeftStr(FDateTime,10))));
  lbl_Date.Caption  := LeftStr(FDateTime,10);
  medt_time.Text    := Copy(FDateTime, 12, 5);

  For vIndex := 0 to ComponentCount-1 do
  begin
    if (Components[vIndex] is TSBPosButton) and ((Components[vIndex] as TSBPosButton).Parent = panMain) then
    begin
      if (Components[vIndex] as TSBPosButton).Number.Number = StrToInt(RightStr(lbl_Date.Caption,2)) then
      begin
        (Components[vIndex] as TSBPosButton).Color.Face := $00DFDFFF;
        Break;
      end;
    end;
  end;
  if StoI(Copy(FDateTime, 12, 2)) < 12 then FTimeMode := True
  else                                      FTimeMode := False;
  obtn_ampmClick(nil);
end;

procedure TBookingDate_F.ButtonClear;
var nCnt :Integer;
label go;
begin
  go:
  For nCnt := 0 to ComponentCount-1 do
  begin
    if (Components[nCnt] is TSBPosButton) and ((Components[nCnt] as TSBPosButton).Parent = panMain) then
    begin
      (Components[nCnt] as TSBPosButton).Free;
      Goto go;
    end;

    if (Components[nCnt] is TcxLabel) and ((Components[nCnt] as TcxLabel).Parent = panMain) then
    begin
      (Components[nCnt] as TcxLabel).Free;
      Goto go;
    end;
  end;
end;

procedure TBookingDate_F.SetCalender(aDate:TDateTime);
    procedure ButtonCreate(AValue:TBtnSize; nDay:Integer);
    var
      TableButton : TSBPosButton;
    begin
      TableButton := TSBPosButton.Create(Self);

      with TableButton do
      begin
         Parent            := panMain;
         Top               := AValue^.Top;
         Left              := AValue^.Left;
         Height            := AValue^.Height;
         Width             := AValue^.Width;
         Number.Number     := nDay;
         Number.ShowNumber := nDay > 0;
         Number.Font.Size  := 10;
         Number.Font.Style := [fsBold];
         case AValue^.Col of
           0 :
           begin
             Number.Font.Color := clRed;
             MenuName.Font.Color := clRed;
           end;
           6 :
           begin
             Number.Font.Color := clBlue;
             MenuName.Font.Color := clBlue;
           end;
         end;
         MenuName.Font.Size := 10;
         MenuName.Font.Name := '굴림체';

         Temp1 := IntToStr(AValue^.Row);
         Temp2 := IntToStr(AValue^.Col);

         //테이블 색상지정
         Color.Face          := clWhite;
         Color.Shadow        := clWhite;
         Color.Border        := $00DDDDDD;
         Color.Highlight     := clWhite;
         OnClick := ButtonClick;
         Refresh;
      end;
    end;

var vDate  :TDateTime;
    vMonth :String;
    vDay,
    vFirstWeek :Integer;
    nLoop,
    nLoop1,
    nHeight,
    nWidth,
    nNum,
    nDay,
    nTmp  :Integer;
    cxLabel : TcxLabel;
const Week  :Array[0..6] of String =('일요일','월요일','화요일','수요일','목요일','금요일','토요일');
begin
  vDate  := IncMonth(aDate);
  vMonth := FormatDateTime('yyyy-mm', vDate) +'-01';

  OpenQuery('select (datepart(day, dateadd(dd,-1,convert(datetime, :p0)) ) + (datepart(weekday, convert(datetime, :p1))-1))  /  7 + '
           +'        case when ((datepart(day, dateadd(dd,-1,convert(datetime, :p0)) ) + (datepart(day, dateadd(dd,-1,convert(datetime, :p1))))  -1) % 7 ) = 0 then 0 else 1 end, '
           +'        datepart(day,dateadd(dd,-1,convert(datetime, :p0))),   '
           +'        datepart(weekday, convert(datetime, :p1)) ',
           [vMonth,
            Copy(DtoS(aDate),1,4)+'-'+Copy(DtoS(aDate),5,2)+'-01']);

  vWeek      := Common.Query.Fields[0].AsInteger;
  vDay       := Common.Query.Fields[1].AsInteger;
  vFirstWeek := Common.Query.Fields[2].AsInteger;
  Common.Query.Close;

  nHeight         := ((panMain.Height -22) div (vWeek+1)) - 1;
  nWidth          := ((panMain.Width  + 2 ) div 7)-1;

  ButtonClear;
  For nLoop1 := 0 to 6 do
  begin
    cxLabel := TcxLabel.Create(Self);
    with cxLabel do
    begin
      Parent    := panMain;
      AutoSize  := False;
      Top       := 1;
      Left      := (nLoop1  * nWidth)  + (nLoop1 * 1);
      Height    := 29;
      Width     := nWidth;
      Name      := 'lbl_Week'+IntToStr(nLoop1);
      Caption   := Week[nLoop1];
      Properties.Alignment.Horz := taCenter;
      Properties.Alignment.Vert := taVCenter;
      Style.BorderStyle := ebsOffice11;
      Style.Font.Size   := 10;
      Style.Color := $00F3B89E;
    end;
  end;

  nDay := 0;
  nNum := 1;
  For nLoop := 0 to vWeek do
  begin
    For nLoop1 := 0 to 6 do
    begin
      New(BtnSize);
      BtnSize^.Row    := nLoop;
      BtnSize^.Col    := nLoop1;
      BtnSize^.Height := nHeight;
      BtnSize^.Width  := nWidth;
      BtnSize^.Left   := (nLoop1  * nWidth)  + (nLoop1 * 1);
      BtnSize^.Top    := 30 + (nLoop   * nHeight) + (nLoop  * 1);
      BtnSize^.Number := nNum;
      if (nNum >= vFirstWeek) then
      begin
        Inc(nDay);
      end;
      if (vDay < nDay) then
        nTmp := 0
      else
        nTmp := nDay;
      ButtonCreate(BtnSize, nTmp);
      Inc(nNum);
    end;
  end;
end;

procedure TBookingDate_F.ButtonClick(Sender: TObject);
var vIndex :Integer;
begin
  if TSBPosButton(Sender).Number.Number = 0 then Exit;
  lbl_Date.Caption := Format('%s-%s',[LeftStr(lbl_Date.Caption,7),FormatFloat('00', TSBPosButton(Sender).Number.Number)]);

  For vIndex := 0 to ComponentCount-1 do
  begin
    if (Components[vIndex] is TSBPosButton) and ((Components[vIndex] as TSBPosButton).Parent = panMain) then
    begin
      (Components[vIndex] as TSBPosButton).Color.Face := clWhite;
    end;
  end;
  TSBPosButton(Sender).Color.Face := $00DFDFFF;
end;

end.
