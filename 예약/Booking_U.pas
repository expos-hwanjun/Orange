unit Booking_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, ExtCtrls, StdCtrls, Menus, StrUtils,
  cxLookAndFeelPainters, cxButtons, cxLookAndFeels, cxControls, cxPC,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxGraphics, cxPCdxBarPopupMenu, dxBarBuiltInMenu, Vcl.ComCtrls, dxCore,
  cxDateUtils, cxClasses, dxGDIPlusClasses, cxLabel, Vcl.WinXCalendars, AdvShape,
  AdvGlassButton, ToolPanels, Math, AdvSmoothButton;

type TWorkType = (wtNone, wtNew, wtEdit);

type
  TBooking_F = class(TForm)
    sgr_Grid: TStringGrid;
    cxLookAndFeelController1: TcxLookAndFeelController;
    GridTitleShape: TAdvShape;
    TitleLabel: TLabel;
    CloseButton: TcxButton;
    ReservePicker: TCalendarPicker;
    cxLabel3: TcxLabel;
    Image3: TImage;
    MessageLabel: TLabel;
    PrintPanel: TAdvToolPanel;
    Shape2: TShape;
    NewButton: TAdvSmoothButton;
    CancelButton: TAdvSmoothButton;
    EditButton: TAdvSmoothButton;
    VisitButton: TAdvSmoothButton;
    ListButton: TAdvSmoothButton;
    PrintButton: TAdvSmoothButton;
    AllPrintButton: TAdvSmoothButton;
    SelecteDayPrintButton: TAdvSmoothButton;
    SelectReservePrintButton: TAdvSmoothButton;
    GridPrevButton: TAdvSmoothButton;
    GridNextButton: TAdvSmoothButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sgr_GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure ReservePickerChange(Sender: TObject);
    procedure AllPrintButtonClick(Sender: TObject);
    procedure VisitButtonClick(Sender: TObject);
    procedure ListButtonClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure NewButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure GridPrevButtonClick(Sender: TObject);
  private
    FSortKind : Integer;  //소트 0,1:번호, 2,3:예약자, 4,5:예약일시
    procedure SelectBooking;
    function  GetBookingTable:String;
  public
    WorkType :TWorkType;
    BeforeDateTime : TDateTime;
  end;

var
  Booking_F: TBooking_F;

implementation

uses BookingInput_U, Common_U, GlobalFunc_U, DateUtils, BookingList_U, Const_U,
  DBModule_U;

{$R *.dfm}
procedure TBooking_F.FormCreate(Sender: TObject);
var vIndex :Integer;
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(GridTitleShape);

  for vIndex := 0 to ComponentCount-1 do
  begin
    if Components[vIndex] is TAdvGlassButton then
      Common.SetButtonColor((Components[vIndex] as TAdvGlassButton));
    if Components[vIndex] is TAdvSmoothButton then
      Common.SetButtonColor((Components[vIndex] as TAdvSmoothButton));
  end;

  BookingInput_F := TBookingInput_F.Create(Self);
  sgr_Grid.DefaultRowHeight := Ifthen(Common.Config.ListRowHeight=0, 28, Common.Config.ListRowHeight);
  sgr_Grid.ColWidths[0] := 50;
  sgr_Grid.ColWidths[1] := 190;
  sgr_Grid.ColWidths[2] := 280;
  sgr_Grid.ColWidths[3] := 200;
  sgr_Grid.ColWidths[4] := 150;
  sgr_Grid.ColWidths[5] := 100;
  sgr_Grid.ColWidths[6] := 0;
  FSortKind := 0;
end;

procedure TBooking_F.FormShow(Sender: TObject);
begin
  Common.Device.OnCidReadData := nil;
  ReservePicker.Date := now;
  PrintPanel.Visible := false;
  SelectBooking;
end;


procedure TBooking_F.sgr_GridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var  vAlign : integer;
begin
  TStringGrid(Sender).Canvas.Font.Size := Common.Config.ListFontSize;;
  if gdSelected in State then
  begin
    TStringGrid(Sender).Canvas.Font.Color  := clWhite;
    TStringGrid(Sender).Canvas.Brush.Color := $00AE5700;
  end
  else
  begin
    TStringGrid(Sender).Canvas.Brush.Color := clWhite;;
    TStringGrid(Sender).Canvas.Font.Color  := clBlack;
  end;

  case Acol of
     1 : vAlign  := 0;
     0,2,3,4,5 :  vAlign  := 1; //가운데
  end;
  Common.Grid_Align(Sender, ACol, ARow, Rect, vAlign);
end;

procedure TBooking_F.VisitButtonClick(Sender: TObject);
begin
  if sgr_Grid.Cells[0,0] = '' then Exit;
  if not Common.AskBox('방문 처리하시겠습니까?') then Exit;

  if ExecQueryEx('update SL_BOOKING '
               +'   set YN_SALE   = ''Y'', '
               +'       DT_CHANGE = Now() '
               +' where CD_STORE   =:P0 '
               +'   and NO_BOOKING =:P1 ',
               [Common.Config.StoreCode,
                sgr_Grid.Cells[8, sgr_Grid.Row]],true) then
    Common.DeleteRow(sgr_Grid, sgr_Grid.Row);
end;

procedure TBooking_F.FormActivate(Sender: TObject);
begin
  case WorkType of
    wtNew  : NewButtonClick(nil);
    wtEdit : EditButtonClick(nil);
  end;
end;


procedure TBooking_F.PrintButtonClick(Sender: TObject);
begin
  FormResize(nil);
  if sgr_Grid.Cells[0,0] = '' then Exit;
  if PrintPanel.Visible then
  begin
    PrintPanel.Visible := False;
    Exit;
  end
  else
    PrintPanel.Visible := True;
end;

procedure TBooking_F.ReservePickerChange(Sender: TObject);
begin
  SelectBooking;
end;

procedure TBooking_F.SelectBooking;
var vSql :String;
begin
  if WorkType = wtNone then
  begin
    case FSortKind of
      0 : vSql := 'order by NO_BOOKING';
      1 : vSql := 'order by NO_BOOKING desc';
      2 : vSql := 'order by NM_NAME';
      3 : vSql := 'order by NM_NAME desc';
      4 : vSql := 'order by DT_BOOKING';
      5 : vSql := 'order by DT_BOOKING desc';
    end;

    Common.ClearGrid(sgr_Grid);
    OpenQuery('select CD_MEMBER, '
             +'       NM_NAME, '
             +'       NO_TEL, '
             +'       DT_BOOKING, '
             +'       CNT_PERSON, '
             +'       REMARK, '
             +'       NO_BOOKING, '
             +'       NO_TABLE, '
             +'       AMT_BOOKING, '
             +'       CAR_TIME, '
             +'       NO_SMS '
             +'  from SL_BOOKING '
             +' where CD_STORE =:P0 '
             +'   and YN_SALE = ''N'' '
             +'   and Date_Format(DT_BOOKING, ''%Y%m%d'') =:P1 '
             +'order by NO_BOOKING',
             [Common.Config.StoreCode,
             DtoS(ReservePicker.Date)]);

    while not Common.Query.Eof do
    begin
      if sgr_Grid.Cells[0,0] <> '' then sgr_Grid.RowCount := sgr_Grid.RowCount + 1;
      sgr_Grid.Cells[0, sgr_Grid.RowCount-1] := IntToStr(sgr_Grid.RowCount);
      sgr_Grid.Cells[1, sgr_Grid.RowCount-1] := Common.Query.Fields[1].AsString; //예약자명
      sgr_Grid.Cells[2, sgr_Grid.RowCount-1] := FormatDateTime(fmtDateTime, Common.Query.Fields[3].AsDateTime); //예약일시
      sgr_Grid.Cells[3, sgr_Grid.RowCount-1] := SetTelephone(Common.Query.Fields[2].AsString); //연락처
      //테이블번호
      DM.OpenQuery('select GetTableName(CD_STORE, NO_TABLE) '
                  +'  from SL_BOOKING_TABLE '
                  +' where CD_STORE   =:P0 '
                  +'   and NO_BOOKING =:P1 '
                  +' order by NO_TABLE',
                  [Common.Config.StoreCode,
                   Common.Query.Fields[6].AsString]);
      while not DM.Query.Eof do
      begin
        sgr_Grid.Cells[4, sgr_Grid.RowCount-1] := sgr_Grid.Cells[4, sgr_Grid.RowCount-1]+ DM.Query.Fields[0].AsString +',';
        DM.Query.Next;
      end;
      if RightStr(sgr_Grid.Cells[4, sgr_Grid.RowCount-1],1) = ',' then
        sgr_Grid.Cells[4, sgr_Grid.RowCount-1] := LeftStr(sgr_Grid.Cells[4, sgr_Grid.RowCount-1], Length(sgr_Grid.Cells[4, sgr_Grid.RowCount-1])-1);
      DM.Query.Close;

      sgr_Grid.Cells[5, sgr_Grid.RowCount-1] := Common.Query.Fields[4].AsString; //인원
      sgr_Grid.Cells[6, sgr_Grid.RowCount-1] := Common.Query.Fields[0].AsString; //회원번호
      sgr_Grid.Cells[7, sgr_Grid.RowCount-1] := Common.Query.Fields[5].AsString; //비고
      sgr_Grid.Cells[8, sgr_Grid.RowCount-1] := Common.Query.Fields[6].AsString;
      sgr_Grid.Cells[9, sgr_Grid.RowCount-1] := Common.Query.Fields[7].AsString;
      sgr_Grid.Cells[10, sgr_Grid.RowCount-1] := Common.Query.Fields[8].AsString; //예약금액
      sgr_Grid.Cells[11, sgr_Grid.RowCount-1] := Common.Query.Fields[9].AsString; //차량지원시간
      sgr_Grid.Cells[12, sgr_Grid.RowCount-1] := Common.Query.Fields[10].AsString; //SMS 예약번호
      sgr_Grid.Cells[13, sgr_Grid.RowCount-1] := FormatDateTime(fmtDateTime, Common.Query.Fields[3].AsDateTime); //예약일시
      Common.Query.Next;
    end;
    Common.Query.Close;
  end;
  sgr_Grid.SetFocus;
end;

procedure TBooking_F.AllPrintButtonClick(Sender: TObject);
begin
  if Sender = AllPrintButton then
    Common.Device.BookingPrint(0, '')
  else if Sender = SelecteDayPrintButton then
    Common.Device.BookingPrint(1, sgr_Grid.Cells[2, sgr_Grid.Row])
  else if Sender = SelectReservePrintButton then
    Common.Device.BookingPrint(2, sgr_Grid.Cells[8, sgr_Grid.Row]);

  PrintPanel.Visible := False;
end;

procedure TBooking_F.CancelButtonClick(Sender: TObject);
var vSQL :String;
begin
  if not Common.AskBox('예약을 삭제하시겠습니까?') then Exit;

  try
    OpenQuery('select NO_TEL, '
             +'       Date_Format(DT_BOOKING, ''%Y-%m-%d %H:%i'') DT_BOOKING '
             +'  from SL_BOOKING '
             +' where CD_STORE  =:P0 '
             +'   and NO_BOOKING =:P1 ',
             [Common.Config.StoreCode,
              sgr_Grid.Cells[8, sgr_Grid.Row] ]);

{    Common.SendSMSMessage('C'+#28+Common.Config.StoreCode+#28+
                          GetOnlyNumber(Common.Query.Fields[0].AsString)+#28+ //고객전화번호
                          GetOnlyNumber(Common.Config.StoreTel)+#28+                        //매장전화번호
                          #28+
                          FormatDateTime('yyyymmddhhnnss', IncMinute(StrToDateTime(Common.Query.Fields[1].AsString+':00'), Common.Config.SmSTime*-1 )) +#28  //변경 전 예약일시
                          );
}
    vSQL := Format('delete from SL_BOOKING where CD_HEAD = ''%s'' and CD_STORE =''%s'' and NO_BOOKING =''%s''; ',[Common.Config.HeadStoreCode, Common.Config.StoreCode, sgr_Grid.Cells[8, sgr_Grid.Row]]);
    vSQL := vSQL +  Format('delete from SL_BOOKING_MENU where CD_HEAD = ''%s'' and CD_STORE =''%s'' and NO_BOOKING =''%s''; ',[Common.Config.HeadStoreCode, Common.Config.StoreCode, sgr_Grid.Cells[8, sgr_Grid.Row]]);
    vSQL := vSQL + Format('delete from SL_BOOKING_TABLE where CD_HEAD = ''%s'' and CD_STORE =''%s'' and NO_BOOKING =''%s''; ',[Common.Config.HeadStoreCode, Common.Config.StoreCode, sgr_Grid.Cells[8, sgr_Grid.Row]]);

     if not DM.ExecCloud(vSQL,[],true,Common.RestDBURL) then
      raise Exception.Create('서버 접속 실패 !!!.'#13'잠시 후 다시 실행해 주십시오.');


    vSQL := Format('delete from SL_BOOKING where CD_STORE =''%s'' and NO_BOOKING =''%s''; ',[Common.Config.StoreCode, sgr_Grid.Cells[8, sgr_Grid.Row]]);
    vSQL := vSQL +  Format('delete from SL_BOOKING_MENU where CD_STORE =''%s'' and NO_BOOKING =''%s''; ',[Common.Config.StoreCode, sgr_Grid.Cells[8, sgr_Grid.Row]]);
    vSQL := vSQL + Format('delete from SL_BOOKING_TABLE where CD_STORE =''%s'' and NO_BOOKING =''%s''; ',[Common.Config.StoreCode, sgr_Grid.Cells[8, sgr_Grid.Row]]);

    DM.StoredProc.StoredProcName := 'MULTI_EXECUTE';
    DM.StoredProc.PrepareSQL;
    DM.StoredProc.ParamByName('_SQL').AsString := vSQL;
    DM.StoredProc.ExecProc;

    Common.DeleteRow(sgr_Grid, sgr_Grid.Row);
    Common.GridRefresh(sgr_Grid);
  except
    on E: Exception do
    begin
      Common.WriteLog('Booking002',E.Message);
      Common.ErrBox('예약을 삭제하지 못했습니다');
    end;
  end;
end;

procedure TBooking_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TBooking_F.EditButtonClick(Sender: TObject);
var mrResult, vRow, vIndex :Integer;
    SmsNo, BookingNo    :String;
    vDateTime :TDateTime;
    vSQL :String;
begin
  if sgr_Grid.Cells[0,0] = '' then Exit;
  with BookingInput_F do
  begin

    //테이블 조회 후 여기에 들어왔을때
    if WorkType = wtEdit then
    begin
      ReserveTableEdit.Text := GetBookingTable;
    end
    else
    begin
      Common.BookingTableNo.Clear;
      OpenQuery('select NO_TABLE '
               +'  from SL_BOOKING_TABLE '
               +' where CD_STORE   =:P0 '
               +'   and NO_BOOKING =:P1 '
               +'  order by NO_TABLE ',
               [Common.Config.StoreCode,
                sgr_Grid.Cells[8, sgr_Grid.Row]]);
      while not Common.Query.Eof do
      begin
        Common.BookingTableNo.Add(Common.Query.Fields[0].AsString);
        Common.Query.Next;
      end;
      Common.Query.Close;

      MemberCodeEdit.Text  := sgr_Grid.Cells[6, sgr_Grid.Row];
      GuestNameEdit.Text    := sgr_Grid.Cells[1, sgr_Grid.Row];
      ReserveDateTime.DateTime  := StrToDateTime(sgr_Grid.Cells[2, sgr_Grid.Row]);
      MobileNoEdit.Text     := sgr_Grid.Cells[3, sgr_Grid.Row];
      ReserveTableEdit.Text := sgr_Grid.Cells[4, sgr_Grid.Row];
      ReserveCountEdit.Value := StoI(sgr_Grid.Cells[5, sgr_Grid.Row]);
      RemarkMemo.Lines.Clear;
      RemarkMemo.Lines.Add(sgr_Grid.Cells[7, sgr_Grid.Row]);
      ReserveAmtEdit.Value := StoI(sgr_Grid.Cells[10, sgr_Grid.Row]);
      OpenQuery('select b.NM_MENU_SHORT, '
               +'       Cast(a.QTY_MENU as Char), '
               +'       a.CD_MENU '
               +'  from SL_BOOKING_MENU a inner join '
               +'       MS_MENU         b on a.CD_STORE = b.CD_STORE and a.CD_MENU = b.CD_MENU '
               +' where a.CD_STORE   =:P0 '
               +'   and a.NO_BOOKING =:P1 '
               +' order by a.SEQ ',
               [Common.Config.StoreCode,
                sgr_Grid.Cells[8, sgr_Grid.Row]]);
      Common.OpenDataToGrid(Common.Query, BookingInput_F.FMenu_sGrd);
    end;

    mrResult :=BookingInput_F.ShowModal;
    WorkType := wtEdit;
    case mrResult of
      mrYes : Self.ModalResult := mrYes;
      mrOK  :
      begin
        try
          vDateTime := ReserveDateTime.DateTime;

          DM.ExecCloud('update SL_BOOKING '
                      +'   set CD_MEMBER   = :P3, '
                      +'       NM_NAME     = :P4, '
                      +'       NO_TEL      = :P5, '
                      +'       DT_BOOKING  = Cast(:P6 as DateTime), '
                      +'       CNT_PERSON  = :P7, '
                      +'       AMT_BOOKING = :P8, '
                      +'       REMARK      = :P9 '
                      +' where CD_HEAD    =:P0 '
                      +'   and CD_STORE   =:P1 '
                      +'   and NO_BOOKING =:P2;',
                      [Common.Config.HeadStoreCode,
                       Common.Config.StoreCode,
                       sgr_Grid.Cells[8, sgr_Grid.Row],
                       MemberCodeEdit.Text,
                       GuestNameEdit.Text,
                       MobileNoEdit.Text,
                       FormatDateTime('yyyy-mm-dd hh:nn:ss',ReserveDateTime.DateTime),
                       NVL(ReserveCountEdit.EditingValue,0),
                       NVL(ReserveAmtEdit.EditingValue,0),
                       RemarkMemo.Text],false,Common.RestDBURL);

          //예약메뉴저장
          BookingNo := sgr_Grid.Cells[8, sgr_Grid.Row];
          DM.ExecCloud('delete '
                      +'  from SL_BOOKING_MENU '
                      +' where CD_HEAD    =:P0 '
                      +'   and CD_STORE   =:P1 '
                      +'   and NO_BOOKING =:P2;',
                      [Common.Config.HeadStoreCode,
                       Common.Config.StoreCode,
                       BookingNo],false,Common.RestDBURL);

          if FMenu_sGrd.Cells[0,0] <> '' then
          begin
            For vIndex := 0 to FMenu_sGrd.RowCount-1 do
            begin
              DM.ExecCloud('insert into SL_BOOKING_MENU(CD_HEAD, CD_STORE, NO_BOOKING, CD_MENU, QTY_MENU, SEQ) '
                          +'                     values(:P0, :P1, :P2, :P3, :P4, :P5);',
                          [Common.Config.HeadStoreCode,
                           Common.Config.StoreCode,
                           BookingNo,
                           FMenu_sGrd.Cells[2, vIndex],
                           FMenu_sGrd.Cells[1, vIndex],
                           vIndex+1],false,Common.RestDBURL);
            end;
          end;

          DM.ExecCloud('delete '
                      +'  from SL_BOOKING_TABLE '
                      +' where CD_HEAD    =:P0 '
                      +'   and CD_STORE   =:P1 '
                      +'   and NO_BOOKING =:P2;',
                      [Common.Config.HeadStoreCode,
                       Common.Config.StoreCode,
                       BookingNo],false,Common.RestDBURL);

          For vIndex := 0 to Common.BookingTableNo.Count-1 do
            DM.ExecCloud('insert into SL_BOOKING_TABLE(CD_HEAD, CD_STORE, NO_BOOKING, NO_TABLE) '
                        +'                      values(:P0, :P1, :P2, :P3);',
                        [Common.Config.HeadStoreCode,
                         Common.Config.StoreCode,
                         BookingNo,
                         StrToInt(Common.BookingTableNo.Strings[vIndex])],false,Common.RestDBURL);

          if not DM.ExecCloud(DM.TempSQL,[],true,Common.RestDBURL) then
            raise Exception.Create('서버 접속 실패 !!!.'#13'잠시 후 다시 실행해 주십시오.');

          //LocalDB에 다운로드 받는다
          DM.OpenCloud('select CD_STORE,NO_BOOKING,CD_MEMBER,NM_NAME,DT_BOOKING,NO_TABLE,NO_TEL,CNT_PERSON,AMT_BOOKING,CAR_TIME,CAR_CONFIRM,NO_SMS,YN_SALE,CD_DAMDANG,REMARK,DT_INSERT,DT_CHANGE '
                      +'  from SL_BOOKING  '
                      +' where CD_HEAD  =:P0 '
                      +'   and CD_STORE =:P1 '
                      +'   and NO_BOOKING =:P2 ',
                      [Common.Config.HeadStoreCode,
                       Common.Config.StoreCode,
                       BookingNo],Common.RestDBURL);

          vSQL := Format('delete from SL_BOOKING where CD_STORE =''%s'' and NO_BOOKING =''%s''; ',[Common.Config.StoreCode, BookingNo]);
          vSQL := vSQL + DM.GetCloudData('SL_BOOKING');

          DM.OpenCloud('select CD_STORE,NO_BOOKING,CD_MENU, QTY_MENU, SEQ '
                      +'  from SL_BOOKING_MENU '
                      +' where CD_HEAD    =:P0 '
                      +'   and CD_STORE   =:P1 '
                      +'   and NO_BOOKING =:P2 ',
                      [Common.Config.HeadStoreCode,
                       Common.Config.StoreCode,
                       BookingNo],Common.RestDBURL);

          vSQL := vSQL + Format('delete from SL_BOOKING_MENU where CD_STORE =''%s'' and NO_BOOKING =''%s''; ',[Common.Config.StoreCode, BookingNo]);
          vSQL := vSQL + DM.GetCloudData('SL_BOOKING_MENU');

              //SL_BOOKING_TABLE
          DM.OpenCloud('select CD_STORE,NO_BOOKING,NO_TABLE '
                      +'  from SL_BOOKING_TABLE '
                      +' where CD_HEAD    =:P0 '
                      +'   and CD_STORE   =:P1 '
                      +'   and NO_BOOKING =:P2 ',
                      [Common.Config.HeadStoreCode,
                       Common.Config.StoreCode,
                       BookingNo],Common.RestDBURL);

          vSQL := vSQL + Format('delete from SL_BOOKING_TABLE where CD_STORE =''%s'' and NO_BOOKING =''%s''; ',[Common.Config.StoreCode, BookingNo]);
          vSQL := vSQL + DM.GetCloudData('SL_BOOKING_TABLE');

          DM.StoredProc.StoredProcName := 'MULTI_EXECUTE';
          DM.StoredProc.PrepareSQL;
          DM.StoredProc.ParamByName('_SQL').AsString := vSQL;
          DM.StoredProc.ExecProc;
        except
          on E: Exception do
          begin
            Common.WriteLog('Booking001',E.Message);
            Common.ErrBox(E.Message+#13#13+'저장하지 못했습니다');
            WorkType := wtNone;
            Exit;
          end;
        end;

        WorkType := wtNone;
        vRow := sgr_Grid.Row;
        SelectBooking;
        if vRow < sgr_Grid.RowCount then
          sgr_Grid.Row := vRow;
      end;
      else WorkType := wtNone;
    end; //case mrResult of
  end;
end;

procedure TBooking_F.FormResize(Sender: TObject);
begin
  PrintPanel.Left := Trunc(Self.Width / 2 - PrintPanel.Width / 2);
  PrintPanel.Top  := Trunc(Self.Height / 2 - PrintPanel.Height / 2);
end;

function TBooking_F.GetBookingTable: String;
var vIndex :Integer;
begin
  if (GetOption(25) = '1') then
  begin
    For vIndex := 0 to Common.BookingTableNo.Count-1 do
    begin
      OpenQuery('select NM_TABLE '
               +'  from MS_TABLE '
               +' where CD_STORE =:P0 '
               +'   and NO_TABLE =:P1',
               [Common.Config.StoreCode,
                StrToInt(Common.BookingTableNo.Strings[vIndex])]);
      Result := Result + Common.Query.Fields[0].AsString +',';
    end;

    if RightStr(Result,1) = ',' then
      Result := LeftStr(Result, Length(Result)-1);
  end
  else
  begin
    for vIndex := 0 to Common.BookingTableNo.Count-1 do
    begin
      Result := Result + Common.BookingTableNo.Strings[vIndex]+',';
    end;
    if RightStr(Result,1) = ',' then
      Result := LeftStr(Result, Length(Result)-1);
  end;
end;

procedure TBooking_F.GridPrevButtonClick(Sender: TObject);
begin
  if Sender = GridPrevButton then Common.RowPrev(sgr_Grid)
  else                            Common.RowNext(sgr_Grid);
end;

procedure TBooking_F.ListButtonClick(Sender: TObject);
begin
  BookingList_F := TBookingList_F.Create(Self);
  try
    BookingList_F.ShowModal;
  finally
    FreeAndNil(BookingList_F);
  end;
end;

procedure TBooking_F.NewButtonClick(Sender: TObject);
var mrResult, nRow :Integer;
    SmsNo, vBookingNo,
    vBookingMemo    :String;
    vDateTime :TDateTime;
    vSQL :String;
    vTableNo :String;
begin
  OpenQuery('select BOOKING_SMS_MEMO '
           +'  from MS_STORE '
           +' where CD_STORE =:P0 ',
           [Common.Config.StoreCode]);
  vBookingMemo := Common.Query.Fields[0].AsString;
  Common.BookingTableNo.Clear;

  with BookingInput_F do
  begin
    //테이블 조회 후 여기에 들어왔을때
    if WorkType = wtNew then
    begin
      ReserveTableEdit.Text := '';
    end
    else
    begin
      MemberCodeEdit.Clear;
      GuestNameEdit.Clear;
      ReserveDateTime.DateTime := Now();
      MobileNoEdit.Clear;
      ReserveTableEdit.Clear;
      ReserveCountEdit.Value := 1;
      ReserveAmtEdit.Value := 0;
      RemarkMemo.Lines.Clear;
      Common.ClearGrid(BookingInput_F.FMenu_sGrd);
    end;

    mrResult :=BookingInput_F.ShowModal;
    WorkType := wtNew;
    case mrResult of
      mrYes : Self.ModalResult := mrYes;
      mrOK  :
      begin
        try
          SmsNo := '';
          DM.OpenCloud('select ConCat(Date_Format(Now(),''%Y%m%d''),Ifnull(Max(NO_BOOKING),''000'')) '
                      +'  from SL_BOOKING '
                      +' where CD_HEAD  =:P0 '
                      +'   and CD_STORE =:P1 '
                      +'   and Left(NO_BOOKING,8) = Date_Format(Now(),''%Y%m%d'') ',
                      [Common.Config.HeadStoreCode,
                       Common.Config.StoreCode],Common.RestDBURL);

          vBookingNo := LeftStr(DM.CloudData.Fields[0].AsString,8) + FormatFloat('000', StrToInt(RightStr(DM.CloudData.Fields[0].AsString,3)) + 1);

          DM.ExecCloud('insert into SL_BOOKING(CD_HEAD, '
                      +'                       CD_STORE, '
                      +'                       NO_BOOKING, '
                      +'                       CD_MEMBER, '
                      +'                       NM_NAME, '
                      +'                       NO_TEL, '
                      +'                       DT_BOOKING, '
                      +'                       CNT_PERSON, '
                      +'                       AMT_BOOKING, '
                      +'                       REMARK, '
                      +'                       NO_POS '
                      +'                       ) '
                      +'                VALUES(:P0, '
                      +'                       :P1, '
                      +'                       :P2, '
                      +'                       :P3, '
                      +'                       :P4, '
                      +'                       :P5, '
                      +'                       Cast(:P6 as DateTime), '
                      +'                       :P7, '
                      +'                       :P8, '
                      +'                       :P9, '
                      +'                       :P10); ',
                      [Common.Config.HeadStoreCode,
                       Common.Config.StoreCode,
                       vBookingNo,
                       MemberCodeEdit.Text,
                       GuestNameEdit.Text,
                       MobileNoEdit.Text,
                       FormatDateTime('yyyy-mm-dd hh:nn:ss',ReserveDateTime.DateTime),
                       NVL(ReserveCountEdit.EditingValue,0),
                       NVL(ReserveAmtEdit.EditingValue,0),
                       RemarkMemo.Text,
                       Common.Config.PosNo],false,Common.RestDBURL);

          //예약메뉴저장
          if FMenu_sGrd.Cells[0,0] <> '' then
          begin
            For nRow := 0 to FMenu_sGrd.RowCount-1 do
            begin
              DM.ExecCloud('insert into SL_BOOKING_MENU(CD_HEAD, CD_STORE, NO_BOOKING, CD_MENU, QTY_MENU, SEQ) '
                          +'                     values(:P0, :P1, :P2, :P3, :P4, :P5);',
                          [Common.Config.HeadStoreCode,
                           Common.Config.StoreCode,
                           vBookingNo,
                           FMenu_sGrd.Cells[2, nRow],
                           FMenu_sGrd.Cells[1, nRow],
                           nRow+1 ],false,Common.RestDBURL);
            end;
          end;

          DM.ExecCloud('delete from SL_BOOKING_TABLE '
                      +' where CD_HEAD    =:P0 '
                      +'   and CD_STORE   =:P1 '
                      +'   and NO_BOOKING =:P2;',
                      [Common.Config.HeadStoreCode,
                       Common.Config.StoreCode,
                       vBookingNo],false,Common.RestDBURL);

          For nRow := 0 to Common.BookingTableNo.Count-1 do
            DM.ExecCloud('insert into SL_BOOKING_TABLE(CD_HEAD, CD_STORE, NO_BOOKING, NO_TABLE) '
                        +'                      values(:P0, :P1, :P2, :P3);',
                        [Common.Config.HeadStoreCode,
                         Common.Config.StoreCode,
                         vBookingNo,
                         StrToInt(Common.BookingTableNo.Strings[nRow])],false,Common.RestDBURL);


          if not DM.ExecCloud(DM.TempSQL,[],true,Common.RestDBURL) then
            raise Exception.Create('서버 접속 실패 !!!.'#13'잠시 후 다시 실행해 주십시오.');

          //LocalDB에 다운로드 받는다
          DM.OpenCloud('select CD_STORE,NO_BOOKING,CD_MEMBER,NM_NAME,DT_BOOKING,NO_TABLE,NO_TEL,CNT_PERSON,AMT_BOOKING,CAR_TIME,CAR_CONFIRM,NO_SMS,YN_SALE,CD_DAMDANG,REMARK,DT_INSERT,DT_CHANGE '
                      +'  from SL_BOOKING  '
                      +' where CD_HEAD  =:P0 '
                      +'   and CD_STORE =:P1 '
                      +'   and NO_BOOKING =:P2 ',
                      [Common.Config.HeadStoreCode,
                       Common.Config.StoreCode,
                       vBookingNo],Common.RestDBURL);

          vSQL := vSQL + DM.GetCloudData('SL_BOOKING');

          DM.OpenCloud('select CD_STORE,NO_BOOKING,CD_MENU, QTY_MENU, SEQ '
                      +'  from SL_BOOKING_MENU '
                      +' where CD_HEAD    =:P0 '
                      +'   and CD_STORE   =:P1 '
                      +'   and NO_BOOKING =:P2 ',
                      [Common.Config.HeadStoreCode,
                       Common.Config.StoreCode,
                       vBookingNo],Common.RestDBURL);

          vSQL := vSQL + DM.GetCloudData('SL_BOOKING_MENU');

              //SL_BOOKING_TABLE
          DM.OpenCloud('select CD_STORE,NO_BOOKING,NO_TABLE '
                      +'  from SL_BOOKING_TABLE '
                      +' where CD_HEAD    =:P0 '
                      +'   and CD_STORE   =:P1 '
                      +'   and NO_BOOKING =:P2 ',
                      [Common.Config.HeadStoreCode,
                       Common.Config.StoreCode,
                       vBookingNo],Common.RestDBURL);

          vSQL := vSQL + DM.GetCloudData('SL_BOOKING_TABLE');

          DM.StoredProc.StoredProcName := 'MULTI_EXECUTE';
          DM.StoredProc.PrepareSQL;
          DM.StoredProc.ParamByName('_SQL').AsString := vSQL;
          DM.StoredProc.ExecProc;
          Common.BookingTableNo.Clear;
        except
          on E: Exception do
          begin
            Common.WriteLog('Booking003',E.Message);
            Common.ErrBox(E.Message+#13#13+'저장하지 못했습니다');
            WorkType := wtNone;
            Exit;
          end;
        end;

        if sgr_Grid.Cells[0,0] <> '' then sgr_Grid.RowCount := sgr_Grid.RowCount + 1;
        sgr_Grid.Cells[0, sgr_Grid.RowCount-1] := IntToStr(sgr_Grid.RowCount);
        sgr_Grid.Cells[1, sgr_Grid.RowCount-1] := GuestNameEdit.Text;
        sgr_Grid.Cells[2, sgr_Grid.RowCount-1] := FormatDateTime(fmtDateTime, ReserveDateTime.DateTime);
        sgr_Grid.Cells[3, sgr_Grid.RowCount-1] := MobileNoEdit.Text;
        sgr_Grid.Cells[4, sgr_Grid.RowCount-1] := ReserveTableEdit.Text;   //테이블번호
        sgr_Grid.Cells[5, sgr_Grid.RowCount-1] := ReserveCountEdit.Text;   //인원
        sgr_Grid.Cells[6, sgr_Grid.RowCount-1] := MemberCodeEdit.Text;    //회원번호
        sgr_Grid.Cells[7, sgr_Grid.RowCount-1] := RemarkMemo.Text;    //비고
        sgr_Grid.Cells[9, sgr_Grid.RowCount-1] := ''; //테이블번호
        sgr_Grid.Cells[8, sgr_Grid.RowCount-1] := vBookingNo;          //예약번호
        sgr_Grid.Cells[10,sgr_Grid.RowCount-1] := ReserveAmtEdit.Text; //예약금액
        sgr_Grid.Row := sgr_Grid.RowCount-1;
        WorkType := wtNone;
      end;
      else WorkType := wtNone;
    end; //case mrResult of
  end;
end;

end.
