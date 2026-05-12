unit AHeadPay_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, Data.DB, Data.Win.ADODB, AdvGlassButton,
  Vcl.StdCtrls, cxButtons, Vcl.Grids, dxGDIPlusClasses, Vcl.ExtCtrls, AdvShape,
  Math, StrUtils, AdvSmoothButton;

type
  TAHeadPay_F = class(TForm)
    Label1: TLabel;
    GridTitleShape: TAdvShape;
    MessageLabel: TLabel;
    Image3: TImage;
    sgr_Grid: TStringGrid;
    CloseButton: TcxButton;
    GridPrevButton: TAdvSmoothButton;
    GridNextButton: TAdvSmoothButton;
    procedure CloseButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sgr_GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure GridPrevButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AHeadPay_F: TAHeadPay_F;

implementation
uses Common_U, GlobalFunc_U, CashBookCode_U, NumPan_U, Const_U;

{$R *.dfm}

procedure TAHeadPay_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TAHeadPay_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(GridTitleShape);
  Common.SetButtonColor(GridPrevButton);
  Common.SetButtonColor(GridNextButton);

  sgr_Grid.ColWidths[0] := 50;    //테이블번호
  sgr_Grid.ColWidths[1] := 120;   //승인금액
  sgr_Grid.ColWidths[2] := 130;   //구분
  sgr_Grid.ColWidths[3] := 300;   //결제정보
  sgr_Grid.ColWidths[4] := 193;   //승인일시

end;

procedure TAHeadPay_F.FormShow(Sender: TObject);
begin
  sgr_Grid.DefaultRowHeight := Ifthen(Common.Config.ListRowHeight=0, 28, Common.Config.ListRowHeight);
  OpenQuery('select NM_TABLE, '
           +'       AMT_APPROVAL, '
           +'       DS_PAYMENT, '
           +'       PAYMENT_INFO, '
           +'       TRD_DATE, '
           +'       DT_INSERT '
           +'  from ('
           +'        select GetTableName(:P0, NO_TABLE) as NM_TABLE, '
           +'               AMT_APPROVAL, '
           +'               case when DS_CARD = ''P'' then ''렛츠오더'' else ''신용카드'' end  as DS_PAYMENT, '
           +'               ConCat(case when TYPE_TRD = ''C'' then ''단말기'' else NM_CARDPL end,'' '', NO_CARD) as PAYMENT_INFO, '
           +'               ConCat(StoD(TRD_DATE), '' '',Left(TRD_TIME,2),'':'',Right(TRD_TIME,2)) as TRD_DATE, '
           +'               DT_INSERT '
           +'          from SL_CARD_AHEAD '
           +'         where CD_STORE  =:P0 '
           +'        union all '
           +'        select GetTableName(:P0, NO_TABLE) as NM_TABLE, '
           +'               AMT_APPROVAL, '
           +'               ''현금영수증'', '
           +'               ConCat(''식별번호:'',NO_CARD), '
           +'               Date_Format(DT_INSERT, ''%Y-%m-%d %H:%i'') as TRD_DATE, '
           +'               DT_INSERT '
           +'          from SL_CASH_AHEAD '
           +'         where CD_STORE  =:P0 '
           +'        union all '
           +'        select GetTableName(:P0, NO_TABLE) as NM_TABLE, '
           +'               AMT_CASH, '
           +'               ''현금'', '
           +'               '''', '
           +'               '''', '
           +'               Now() '
           +'          from SL_ORDER_H '
           +'         where CD_STORE  =:P0 '
           +'           and AMT_CASH > 0 '
           +'        ) as t '
           +' order by NM_TABLE, DT_INSERT',
           [Common.Config.StoreCode]);
  with Common.Query, sgr_Grid do
    while not Eof do
    begin
      if Cells[0,0] <> '' then RowCount := RowCount + 1;

      Cells[0, RowCount-1] := FieldByName('NM_TABLE').AsString;
      Cells[1, RowCount-1] := FormatFloat(',0', FieldByName('AMT_APPROVAL').AsInteger);
      Cells[2, RowCount-1] := FieldByName('DS_PAYMENT').AsString;
      Cells[3, RowCount-1] := FieldByName('PAYMENT_INFO').AsString;
      Cells[4, RowCount-1] := FieldByName('TRD_DATE').AsString;
      Next;
    end;

  Common.Query.Close;
end;

procedure TAHeadPay_F.GridPrevButtonClick(Sender: TObject);
begin
  if Sender = GridPrevButton then Common.RowPrev(sgr_Grid)
  else                            Common.RowNext(sgr_Grid);
end;

procedure TAHeadPay_F.sgr_GridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
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
     3     :  i_align  := 0; //좌측
     0,2   :  i_align  := 1; //가운데
     1,4   :  i_align  := 2; //우측
  end;
  Common.Grid_Align(Sender, ACol, ARow, Rect, i_align);
  // 숫자형 출력시 Format 형식   //
end;

end.
