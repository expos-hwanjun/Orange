unit Hold_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Buttons, ExtCtrls, GraphicEx,
  MaskUtils, jpeg, KeyPad_F, StrUtils, dxGDIPlusClasses, AdvShape, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, cxButtons, AdvGlassButton, cxLabel, cxTextEdit, AdvSmoothButton;

type
  THold_F = class(TForm)
    Hold_sGrd: TStringGrid;
    TitleLabel: TLabel;
    GridTitleShape: TAdvShape;
    MessageLabel: TLabel;
    Image3: TImage;
    GridPrevButton: TAdvGlassButton;
    GridNextButton: TAdvGlassButton;
    CloseButton: TcxButton;
    ConfirmButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Hold_sGrdDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure GridPrevButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  Hold_F: THold_F;

implementation
uses Common_U, GlobalFunc_U;
{$R *.dfm}

procedure THold_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure THold_F.ConfirmButtonClick(Sender: TObject);
begin
  with Hold_sGrd do
  begin
    Common.RestoreNo   := Cells[1, Row]; //보류번호
    Common.Member.Code := Cells[4, Row]; //회원번호
  end;
  ModalResult      := mrOK;
end;

procedure THold_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(GridTitleShape);
  Common.SetButtonColor(ConfirmButton);
  Common.SetButtonColor(GridPrevButton);
  Common.SetButtonColor(GridNextButton);
  with Hold_sGrd do
  begin
    ColCount     := 6;
    ColWidths[0] := 41;
    ColWidths[1] := 87;
    ColWidths[2] := 113;
    ColWidths[3] := 217;
    ColWidths[4] := -1;
    ColWidths[5] := -1;
  end;
end;

procedure THold_F.FormShow(Sender: TObject);
begin
  OpenQuery('select * '
           +'  from SL_HOLD_H '
           +' where CD_STORE =:P0 '
           +Ifthen(GetOption(403)='0',' and NO_POS   =:P1 ','')
           +'   and YN_RESTORE = ''N'' '
           +' order by NO_HOLD',
           [Common.Config.StoreCode,
            Common.Config.PosNo]);
  while not Common.Query.Eof do
  begin
    with Hold_sGrd do
    begin
      if Cells[0,0] <> '' then RowCount := RowCount + 1;

      Cells[0, RowCount-1] := IntToStr(RowCount);
      Cells[1, RowCount-1] := Common.Query.FieldByName('NO_POS').AsString+
                                     Common.Query.FieldByName('NO_HOLD').AsString;
      Cells[2, RowCount-1] := Common.Query.FieldByName('AMT_HOLD').AsString;
      Cells[3, RowCount-1] := FormatMaskText('!0000년90월90일 00:00;0; ',Common.Query.FieldByName('HOLD_TIME').AsString);
      Cells[4, RowCount-1] := Common.Query.FieldByName('CD_MEMBER').AsString;
      Common.Query.Next;
    end;
  end;
  Common.Query.Close;
end;

procedure THold_F.GridPrevButtonClick(Sender: TObject);
begin
  if Sender = GridPrevButton then Common.RowPrev(Hold_SGrd)
  else if Sender = GridNextButton  then Common.RowNext(Hold_SGrd);
end;

procedure THold_F.Hold_sGrdDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var  vAlign:Integer;
begin
  TStringGrid(Sender).Canvas.Font.Size := 13;
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
    0,1,3 : vAlign := 1; //가운데
    2     : vAlign := 2; //우측정렬
  end;
  Common.Grid_Align(Sender, ACol, ARow, Rect, vAlign);
  //    숫자형 출력시 Format 형식   //
  case ACol of
    2: Common.Grid_DisplayFormat(Sender, ACol, ARow, Rect);
  end;
end;

end.
