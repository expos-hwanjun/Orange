unit CashBook_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, DB, ADODB, jpeg, StrUtils,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxButtons,
  AdvGlassButton, AdvShape, dxGDIPlusClasses, Math, Vcl.WinXCalendars,
  AdvSmoothButton;

type
  TEditMode = (emNone, emNew, emEdit);

type
  TCashBook_F = class(TForm)
    sgr_Grid: TStringGrid;
    ADOProc_Save: TADOStoredProc;
    ADOProc_Card: TADOStoredProc;
    Label1: TLabel;
    CloseButton: TcxButton;
    GridTitleShape: TAdvShape;
    MessageLabel: TLabel;
    Image3: TImage;
    SaleDatePicker: TCalendarPicker;
    CashDrawerOpenButton: TAdvSmoothButton;
    AppendButton: TAdvSmoothButton;
    EditButton: TAdvSmoothButton;
    DeleteButton: TAdvSmoothButton;
    GridPrevButton: TAdvSmoothButton;
    GridNextButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure sgr_GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseButtonClick(Sender: TObject);
    procedure GridPrevButtonClick(Sender: TObject);
    procedure AppendButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure CashDrawerOpenButtonClick(Sender: TObject);
    procedure SaleDatePickerChange(Sender: TObject);
  private
    FEditMode : TEditMode;
    procedure SelectCashBook;
    function DeleteData:Boolean;
    function SaveData:Boolean;
    procedure SetEditMode(AValue:TEditMode);
    property EditMode :TEditMode read FEditMode write SetEditMode;
  public
    GiveList  : TStringList;
  end;

var
  CashBook_F: TCashBook_F;

implementation
uses Common_U, GlobalFunc_U, CashBookCode_U, NumPan_U, Const_U;
{$R *.dfm}

procedure TCashBook_F.FormCreate(Sender: TObject);
var vIndex, vSize :Integer;
begin
  Common.LogoCreate(Self,2);
  if Common.Config.Style = 'D' then
    Common.SetButtonColor(GridTitleShape);

  for vIndex := 0 to ComponentCount-1 do
    if Components[vIndex] is TAdvSmoothButton then
      Common.SetButtonColor((Components[vIndex] as TAdvSmoothButton));

  Common.SetButtonColor(GridPrevButton);
  Common.SetButtonColor(GridNextButton);

  sgr_Grid.ColWidths[0] := 33;    //번호
  sgr_Grid.ColWidths[1] := 222;   //출납명
  sgr_Grid.ColWidths[2] := 98;    //수입금액
  sgr_Grid.ColWidths[3] := 115;    //지출금액
  sgr_Grid.ColWidths[4] := 340;   //비고
  sgr_Grid.ColWidths[5] := -1;    //출납코드

  GiveList := TStringList.Create;
end;

procedure TCashBook_F.FormShow(Sender: TObject);
begin
  sgr_Grid.DefaultRowHeight := 35;
  SaleDatePicker.Date := StoD(Common.WorkDate);
end;

procedure TCashBook_F.GridPrevButtonClick(Sender: TObject);
begin
  if Sender = GridPrevButton then Common.RowPrev(sgr_Grid)
  else if Sender = GridNextButton then Common.RowNext(sgr_Grid);
end;

procedure TCashBook_F.sgr_GridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var  i_align : integer;
begin
  TStringGrid(Sender).Canvas.Font.Size := Common.Config.ListFontSize;
  if gdSelected in State then
  begin
    TStringGrid(Sender).Canvas.Font.Color  := clWhite;
    TStringGrid(Sender).Canvas.Brush.Color := $00FFA74F;
  end
  else
  begin
    TStringGrid(Sender).Canvas.Font.Color  := clBlack;
    TStringGrid(Sender).Canvas.Brush.Color := clWhite;
  end;

  case Acol of
     1,4 :  i_align  := 0; //좌측
     0   :  i_align  := 1; //가운데
     2,3 :  i_align  := 2; //우측
  end;
  Common.Grid_Align(Sender, ACol, ARow, Rect, i_align);
  // 숫자형 출력시 Format 형식   //
  case ACol of
    2,3: Common.Grid_DisplayFormat(Sender, ACol, ARow, Rect);
  end;
end;

////////////////////////////////////////////////////////////////////////////////
// Name         : obtn_AddClick
// Type         : Click Event
// Explanation  : 추가버튼 클릭시
////////////////////////////////////////////////////////////////////////////////
procedure TCashBook_F.SelectCashBook;
begin
  OpenQuery('select a.*, '
           +'       b.NM_CODE1, '
           +'       b.NM_CODE3 '
           +'  from SL_ACCT a inner join '
           +'       MS_CODE b on b.CD_STORE = a.CD_STORE and b.CD_CODE = a.CD_ACCT and b.CD_KIND = ''11'' '
           +' where a.CD_STORE  =:P0 '
           +'   and a.YMD_OCCUR =:P1 '
           +'   and a.NO_POS    =:P2 '
           +' order by a.DT_CHANGE ',
           [Common.Config.StoreCode,
            DtoS(SaleDatePicker.Date),
            Common.Config.PosNo]);
  with Common.Query, sgr_Grid do
    while not Eof do
    begin
      if Cells[0,0] <> '' then RowCount := RowCount + 1;

      Cells[0, RowCount-1] := IntToStr(RowCount);
      Cells[1, RowCount-1] := FieldByName('nm_code1').AsString;
      Cells[2, RowCount-1] := FieldByName('amt_payin').AsString;
      Cells[3, RowCount-1] := FieldByName('amt_out').AsString;
      Cells[4, RowCount-1] := FieldByName('remark').AsString+Ifthen(FieldByName('cd_member').AsString <> '',Format('[%s]',[FieldByName('cd_member').AsString]),'');
      Cells[5, RowCount-1] := FieldByName('cd_acct').AsString;
      Cells[6, RowCount-1] := FieldByName('no_acct').AsString;
      Cells[7, RowCount-1] := FieldByName('ds_acct').AsString;
      Cells[8, RowCount-1] := FieldByName('nm_code3').AsString;
      Cells[9, RowCount-1] := FieldByName('cd_member').AsString;
      Cells[10, RowCount-1] := FieldByName('NO_CLOSE').AsString;
      Next;
    end;

  EditMode := emNone;
  Common.SetLanguage(Self);
  InitMemberRecord(Common.Member);
end;

procedure TCashBook_F.SetEditMode(AValue: TEditMode);
var vTemp :String;
begin
  FEditMode := AValue;
  case FEditMode of
    emNone :
      begin
        EditButton.Enabled   := sgr_Grid.Cells[0,0] <> '';
        DeleteButton.Enabled := EditButton.Enabled;
      end;

    emNew  : if sgr_Grid.Cells[0,0] <> '' then sgr_Grid.RowCount := sgr_Grid.RowCount + 1;

    emEdit :
      begin
        if sgr_Grid.Cells[2, sgr_Grid.Row] <> '0' then
          vTemp := sgr_Grid.Cells[2, sgr_Grid.Row]
        else
          vTemp := sgr_Grid.Cells[3, sgr_Grid.Row];

        vTemp := Common.ShowNumberForm(sgr_Grid.Cells[1, sgr_Grid.Row], 8, 0, vTemp );

        if vTemp = 'mrClose' then Exit;

        
        if StoI(vTemp) = 0 then
        begin
          DeleteData;
          Common.DeleteRow(sgr_Grid, sgr_Grid.Row);
          Common.GridRefresh(sgr_Grid);
        end
        else if sgr_Grid.Cells[1, sgr_Grid.Row] <> vTemp then
        begin
          if sgr_Grid.Cells[2, sgr_Grid.Row] <> '0' then
            sgr_Grid.Cells[2, sgr_Grid.Row] := vTemp
          else
            sgr_Grid.Cells[3, sgr_Grid.Row] := vTemp;
          SaveData;  
        end;
        EditMode := emNone;
      end;
  end;
end;

procedure TCashBook_F.AppendButtonClick(Sender: TObject);
var vTemp, vType :String;
    nRow         :Integer;
begin
  Common.ClearGrid(Common.Card_SGrd);
  CashBookCode_F := TCashBookCode_F.Create(Application);
  try
    CashBookCode_F.WorkDate := DtoS(SaleDatePicker.Date);
    if CashBookCode_F.ShowModal = mrOK then
    begin
      EditMode := emNew;
      sgr_Grid.Cells[0, sgr_Grid.RowCount-1] := IntToStr(sgr_Grid.RowCount);
      sgr_Grid.Cells[1, sgr_Grid.RowCount-1] := CashBookCode_F.sgr_Grid.Cells[1, CashBookCode_F.sgr_Grid.Row];
      if CashBookCode_F.InButton.Appearance.SimpleLayout then
      begin
        sgr_Grid.Cells[2, sgr_Grid.RowCount-1] := FormatFloat('#0', CashBookCode_F.InputAmtEdit.Value);
        sgr_Grid.Cells[3, sgr_Grid.RowCount-1] := '0';
      end
      else
      begin
        sgr_Grid.Cells[2, sgr_Grid.RowCount-1] := '0';
        sgr_Grid.Cells[3, sgr_Grid.RowCount-1] := FormatFloat('#0', CashBookCode_F.InputAmtEdit.Value);
      end;
      sgr_Grid.Cells[4, sgr_Grid.RowCount-1] := CashBookCode_F.RemarkMemo.Text;
      sgr_Grid.Cells[5, sgr_Grid.RowCount-1] := CashBookCode_F.sgr_Grid.Cells[0, CashBookCode_F.sgr_Grid.Row];
      sgr_Grid.Cells[7, sgr_Grid.RowCount-1] := Ifthen(Common.Card_SGrd.Cells[0,0] = '', '0','1');
      sgr_Grid.Cells[8, sgr_Grid.RowCount-1] := CashBookCode_F.sgr_Grid.Cells[3, CashBookCode_F.sgr_Grid.Row];
      sgr_Grid.Cells[9, sgr_Grid.RowCount-1] := Common.Member.Code;
      sgr_Grid.Cells[10, sgr_Grid.RowCount-1] := '0';

      sgr_Grid.Row := sgr_Grid.RowCount-1;
    end
    else Exit;
  finally
    CashBookCode_F.Release;
    Common.Device.PrintData  := EmptyStr;
  end;

  if not SaveData then
    Common.DeleteRow(sgr_Grid, sgr_Grid.Row)
  else
    EditMode := emNone;
end;

procedure TCashBook_F.CashDrawerOpenButtonClick(Sender: TObject);
begin
  Common.Device.CashBoxOpen;
end;

procedure TCashBook_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TCashBook_F.DeleteButtonClick(Sender: TObject);
begin
  Common.ClearGrid(Common.Card_SGrd);
  if not Common.AskBox('출납내역을 삭제하시겠습니까?') then Exit;
  if sgr_Grid.Cells[10, sgr_Grid.Row] <> '0' then
  begin
    Common.ErrBox('마감된 내역은 수정할 수 없습니다');
    Exit;
  end;

  if not DeleteData then Exit;
  Common.DeleteRow(sgr_Grid, sgr_Grid.Row);
  Common.GridRefresh(sgr_Grid);
  EditMode := emNone;
end;

function TCashBook_F.DeleteData: Boolean;
var vRow :Integer;
begin
  //카드건이면 카드를 취소한다
  if sgr_Grid.Cells[7, sgr_Grid.Row] = '1' then
  begin
    Common.SetCardSale(DtoS(SaleDatePicker.Date)+Common.Config.PosNo+sgr_Grid.Cells[6, sgr_Grid.Row], 1);
    Common.CardInfoLoad(0);
    For vRow := 0 to Common.Card_SGrd.RowCount-1 do
      Common.Card_SGrd.Cells[GDC_YN_PRINT, vRow] := 'N';

    For vRow := 0 to Common.Card_SGrd.RowCount-1 do
      Common.Card_SGrd.Cells[GDC_YN_SAVE, vRow] := 'N';

    Common.CashBookCard := True;
    if Common.ShowCardForm(false, false) then
    begin
      //취소가 됐으면 저장은 안하도록...
      Common.Card_SGrd.Cells[GDC_YN_CAN, 0] := 'N';
      Common.Card.Yn_Can   := 'N';
      Common.Card.Yn_Print := 'Y';
      Common.Card.Yn_Save  := 'Y';
      Common.CardInfoSave(1);
    end
    else
    begin
      Result := False;
      Exit;
    end;
  end;
  ExecQueryEx('delete from SL_ACCT '
             +' where CD_STORE  =:P0 '
             +'   and YMD_OCCUR =:P1 '
             +'   and NO_POS    =:P2 '
             +'   and NO_ACCT   =:P3;',
             [Common.Config.StoreCode,
              DtoS(SaleDatePicker.Date),
              Common.Config.PosNo,
              sgr_Grid.Cells[6, sgr_Grid.Row]]);

  ExecQueryEx('delete from SL_ACCT_CARD '
             +' where CD_STORE =:P0 '
             +'   and YMD_SALE =:P1 '
             +'   and NO_POS   =:P2 '
             +'   AND NO_ACCT  =:P3;',
             [Common.Config.StoreCode,
              DtoS(SaleDatePicker.Date),
              Common.Config.PosNo,
              sgr_Grid.Cells[6, sgr_Grid.Row]]);

  //회원외상대금 삭제시 외상내역도 환원한다
  if sgr_Grid.Cells[8, sgr_Grid.Row] = '2' then
  begin
    ExecQueryEx('update SL_SALE_H '
               +'   set NO_ACCT_REF = '''' '
               +' where CD_STORE    =:P0 '
               +'   and NO_ACCT_REF =:P1;',
               [Common.Config.StoreCode,
                DtoS(SaleDatePicker.Date)+sgr_Grid.Cells[6, sgr_Grid.Row]]);
  end;

  //회원외상잔액에 반영한다
  if sgr_Grid.Cells[9, sgr_Grid.Row] <> '' then
    ExecQueryEx('update MS_MEMBER '
               +'   set AMT_TRUST = AMT_TRUST + :P2 '
               +' where CD_STORE  =:P0 '
               +'   and CD_MEMBER =:P1;',
               [Common.Config.StoreCode,
                sgr_Grid.Cells[9, sgr_Grid.Row],
                StoI(sgr_Grid.Cells[2, sgr_Grid.Row])]);

  Result := ExecQueryEx('',[],true);
end;

procedure TCashBook_F.EditButtonClick(Sender: TObject);
begin
  if sgr_Grid.Cells[10, sgr_Grid.Row] <> '0' then
  begin
    Common.ErrBox('마감된 내역은 수정할 수 없습니다');
    Exit;
  end;

  if sgr_Grid.Cells[8, sgr_Grid.Row] = '2' then
  begin
    Common.ErrBox('수정할 수 없는 출납입니다'+#13#13+'삭제 후 다시 하세요');
    Exit;
  end;

  if sgr_Grid.Cells[7, sgr_Grid.Row] = '1' then
  begin
    Common.ErrBox('카드로 받은 출납은 수정할 수 없습니다'+#13#13+'삭제 후 다시 하세요');
    Exit;
  end;

  EditMode := emEdit;
end;

procedure TCashBook_F.SaleDatePickerChange(Sender: TObject);
begin
  SelectCashBook;
end;

function TCashBook_F.SaveData: Boolean;
var Index, liRow :Integer;
    vBmp : TBitmap;
    FStream : TMemoryStream;
    vMenuTxt :String;
    vAcctNo  :String;
begin
  try
    Common.BeginTran;
    Result := True;
    if EditMode = emNew then
    begin
      OpenQuery('select LPad(Ifnull(Max(NO_ACCT),0)+1,3,''0'') '
               +'  from SL_ACCT '
               +' where CD_STORE  = :P0 '
               +'   and YMD_OCCUR = :P1 '
               +'   and NO_POS    = :P2 ',
               [Common.Config.StoreCode,
                DtoS(SaleDatePicker.Date),
                Common.Config.PosNo]);
      vAcctNo := Common.Query.Fields[0].AsString;
      sgr_Grid.Cells[6, sgr_Grid.Row] := vAcctNo;
      Common.Query.Close;
    end;

    ExecQuery(Ifthen(EditMode = emNew,
              'insert into SL_ACCT(CD_STORE, YMD_OCCUR, NO_POS, NO_ACCT, DS_ACCT, CD_ACCT, AMT_PAYIN, AMT_OUT, REMARK, CD_MEMBER, DT_CHANGE, CD_SAWON_CHG, DT_INSERT, AMT_DC) '
             +'            values (:P0, :P1, :P2, :P3, :P4, :P5, :P6, :P7, :P8, :P9,  Now(), :P10, Now(), 0) ',
              'update SL_ACCT '
             +'   set DS_ACCT      = :P4, '
             +'       CD_ACCT      = :P5, '
             +'       AMT_PAYIN    = :P6, '
             +'       AMT_OUT      = :P7, '
             +'       REMARK       = :P8, '
             +'       CD_MEMBER    = :P9, '
             +'       DT_CHANGE    = Now(), '
             +'       CD_SAWON_CHG =:P10 '
             +'where CD_STORE  =:P0 '
             +'  and YMD_OCCUR =:P1 '
             +'  and NO_POS    =:P2 '
             +'  and NO_ACCT   =:P3 '),
            [Common.Config.StoreCode,
             DtoS(SaleDatePicker.Date),
             Common.Config.PosNo,
             sgr_Grid.Cells[6, sgr_Grid.Row],
             Ifthen(Common.Card_SGrd.Cells[0,0] = '', '0','1'),
             sgr_Grid.Cells[5, sgr_Grid.Row],
             StoI(sgr_Grid.Cells[2, sgr_Grid.Row]),
             StoI(sgr_Grid.Cells[3, sgr_Grid.Row]),
             sgr_Grid.Cells[4, sgr_Grid.Row],
             sgr_Grid.Cells[9, sgr_Grid.Row],
             Common.Config.UserCode]);

    {신용카드}
    if Common.Card_SGrd.Cells[0,0] <> '' then
    begin
       For liRow := 0 to Common.Card_sGrd.RowCount -1 do
       begin
          With Common.Card_SGrd, Common do
          begin
             if Cells[GDC_YN_SAVE,liRow] = 'Y' then
             begin
                if not CardDataSave(DtoS(SaleDatePicker.Date),'A', vAcctNo, liRow) then
                  raise Exception.Create('신용카드 저장 중 에러');
             end;
          end; //With Card_SGrd, Common, ADO_Sale_Card do
       end; //For I:= 0...
       Common.GetCardLog;
    end; //if PreSent.CardAmt <> 0 then

    //회원외상잔액에 반영한다
    ExecQuery('update MS_MEMBER '
             +'   set AMT_TRUST = AMT_TRUST - :P2 '
             +' where CD_STORE  =:P0 '
             +'   and CD_MEMBER =:P1 ',
             [Common.Config.StoreCode,
              sgr_Grid.Cells[9, sgr_Grid.Row],
              StoI(sgr_Grid.Cells[2, sgr_Grid.Row])]);

    //회원외상대 입금이면 입금건에 현재 출납번호를 넣는다
    if sgr_Grid.Cells[8, sgr_Grid.Row] = '2' then
    begin
      For Index := 0 to GiveList.Count-1 do
        ExecQuery('update SL_SALE_H '
                 +'   set NO_ACCT_REF =:P4 '
                 +' where CD_STORE =:P0 '
                 +'   and YMD_SALE =:P1 '
                 +'   and NO_POS   =:P2 '
                 +'   and NO_RCP   =:P3',
                 [Common.Config.StoreCode,
                  Copy(GiveList.Strings[Index], 1, 8),
                  Copy(GiveList.Strings[Index], 9, 2),
                  Copy(GiveList.Strings[Index], 11, 4),
                  DtoS(SaleDatePicker.Date)+sgr_Grid.Cells[6, sgr_Grid.Row]]);

      vMenuTxt := Common.Config.SimpleRcpTxt;
      Common.Config.SimpleRcpTxt := '회원외상대금';
      if Common.Card_SGrd.Cells[0,0] = '' then
        Common.Device.PrintSimpluRcp(0, StoI(sgr_Grid.Cells[2, sgr_Grid.Row]))
      else
        Common.Device.PrintSimpluRcp(1, StoI(sgr_Grid.Cells[2, sgr_Grid.Row]));
      Common.Config.SimpleRcpTxt := vMenuTxt;
    end;
    Common.CommitTran;
    InitCardRecord(Common.Card);
  except
    on E: Exception do
    begin
      Common.WriteLog('CashBook002',E.Message);
      Common.RollbackTran;
      Result := False;
    end;
  end;
end;

procedure TCashBook_F.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Common.CashBookCard := False;
end;

end.
