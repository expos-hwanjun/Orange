unit LetsOrderCallList_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, Data.DB, Data.Win.ADODB, AdvGlassButton,
  Vcl.StdCtrls, cxButtons, Vcl.Grids, dxGDIPlusClasses, Vcl.ExtCtrls, AdvShape,
  Math, StrUtils, AdvSmoothButton;

type
  TLetsOrderCallList_F = class(TForm)
    Label1: TLabel;
    GridTitleShape: TAdvShape;
    MessageLabel: TLabel;
    Image3: TImage;
    CloseButton: TcxButton;
    GridPrevButton: TAdvGlassButton;
    GridNextButton: TAdvGlassButton;
    sgr_sGrd: TStringGrid;
    ConfirmButton: TAdvSmoothButton;
    procedure CloseButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sgr_sGrdDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure GridPrevButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LetsOrderCallList_F: TLetsOrderCallList_F;

implementation
uses Common_U, GlobalFunc_U, CashBookCode_U, NumPan_U, Const_U;

{$R *.dfm}

procedure TLetsOrderCallList_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TLetsOrderCallList_F.ConfirmButtonClick(Sender: TObject);
begin
  if sgr_sGrd.Cells[0,sgr_sGrd.Row] = '' then Exit;

  ExecQuery('update SL_LETSORDER_CALL '
           +'   set DS_STATUS = ''1'' '
           +' where CD_STORE  =:P0 '
           +'   and YMD_CALL  =:P1 '
           +'   and SEQ       =:P2 ',
           [Common.Config.StoreCode,
            sgr_sGrd.Cells[4, sgr_sGrd.Row],
            StrToIntDef(sgr_sGrd.Cells[5, sgr_sGrd.Row],0)]);
  sgr_sGrd.Cells[1, sgr_sGrd.Row] := '확인';
end;

procedure TLetsOrderCallList_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(GridTitleShape);
  Common.SetButtonColor(GridPrevButton);
  Common.SetButtonColor(GridNextButton);

  sgr_sGrd.ColWidths[0] := 90;    //테이블번호
  sgr_sGrd.ColWidths[1] := 150;   //상태
  sgr_sGrd.ColWidths[2] := 450;   //호출내용
  sgr_sGrd.ColWidths[3] := 80;    //경과시간
  sgr_sGrd.ColWidths[4] := -1;    //YMD_CALL
  sgr_sGrd.ColWidths[5] := -1;    //SEQ

end;

procedure TLetsOrderCallList_F.FormShow(Sender: TObject);
begin
  sgr_sGrd.DefaultRowHeight := Ifthen(Common.Config.ListRowHeight=0, 28, Common.Config.ListRowHeight);
  OpenQuery('select GetTableName(:P0, NO_TABLE) as NM_TABLE, '
           +'       case when DS_STATUS = ''0'' then ''호출'' else ''확인'' end as DS_STATUS, '
           +'       TXT_CALL, '
           +'       TIMESTAMPDIFF(SECOND,  DT_CALL, Now() ) as LAPE_TIME, '
           +'       YMD_CALL, '
           +'       SEQ '
           +'  from SL_LETSORDER_CALL '
           +' where CD_STORE =:P0 '
           +'   and TIMESTAMPDIFF(MINUTE,  DT_CALL, Now() ) < 30 '
           +' order by ymd_call DESC, seq desc ',
           [Common.Config.StoreCode]);
  Common.ClearGrid(sgr_sGrd);
  with Common.Query, sgr_sGrd do
    while not Eof do
    begin
      if Cells[0,0] <> '' then RowCount := RowCount + 1;
      ConfirmButton.Enabled := true;

      Cells[0, RowCount-1] := FieldByName('NM_TABLE').AsString;
      Cells[1, RowCount-1] := FieldByName('DS_STATUS').AsString;
      Cells[2, RowCount-1] := FieldByName('TXT_CALL').AsString;
      if FieldByName('LAPE_TIME').AsInteger < 60 then
        Cells[3, RowCount-1] := FieldByName('LAPE_TIME').AsString+'초'
      else
        Cells[3, RowCount-1] := Format('%d분%d초',[FieldByName('LAPE_TIME').AsInteger div 60, FieldByName('LAPE_TIME').AsInteger mod 60]);
      Cells[4, RowCount-1] := FieldByName('YMD_CALL').AsString;
      Cells[5, RowCount-1] := FieldByName('SEQ').AsString;
      Next;
    end;

  Common.Query.Close;
end;

procedure TLetsOrderCallList_F.GridPrevButtonClick(Sender: TObject);
begin
  if Sender = GridPrevButton then Common.RowPrev(sgr_sGrd)
  else                            Common.RowNext(sgr_sGrd);
end;

procedure TLetsOrderCallList_F.sgr_sGrdDrawCell(Sender: TObject; ACol,
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
    if TStringGrid(Sender).Cells[1, aRow] = '호출' then
      TStringGrid(Sender).Canvas.Font.Color := clRed
    else
      TStringGrid(Sender).Canvas.Font.Color := clBlack;
    TStringGrid(Sender).Canvas.Brush.Color := clWhite;
  end;

  case Acol of
     2     :  i_align  := 0; //좌측
     0,1,3 :  i_align  := 1; //가운데
  end;
  Common.Grid_Align(Sender, ACol, ARow, Rect, i_align);
end;

end.
