unit KitchenMemo2_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Keyboard_U, StdCtrls, OXSpeedButton, Grids, ExtCtrls, GraphicEx,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, cxMemo, Vcl.Touch.Keyboard;

type
  TKitchenMemo2_F = class(TKeyboard_F)
    obtn_Prev: TOXSpeedButton;
    obtn_Next: TOXSpeedButton;
    obtn_confirm: TOXSpeedButton;
    sgr_Grid: TStringGrid;
    obtn_close: TOXSpeedButton;
    lblTitle: TLabel;
    meo_Memo: TcxMemo;
    procedure FormShow(Sender: TObject);
    procedure sgr_GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sgr_GridClick(Sender: TObject);
    procedure obtn_confirmClick(Sender: TObject);
    procedure obtn_PrevClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure obtn_closeClick(Sender: TObject);
  private
    procedure SelectData;
  public
    MenuCode :String;
    MemoStr  :String;
  end;

var
  KitchenMemo2_F: TKitchenMemo2_F;

implementation
uses Common_U, GlobalFunc_U;
{$R *.dfm}
procedure TKitchenMemo2_F.FormCreate(Sender: TObject);
begin
  Common.ImageCreate(Self,'KitchenMemo2Form');

  sgr_Grid.ColWidths[0] := 100;  //메모코드
  sgr_Grid.ColWidths[1] := 300;  //주방메모명
  OnShow := FormShow;
  inherited;
end;

procedure TKitchenMemo2_F.FormShow(Sender: TObject);
begin
  inherited;
  SelectData;
end;

procedure TKitchenMemo2_F.sgr_GridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var  i_align : integer;
begin
   if gdSelected in State then
   begin
       TStringGrid(Sender).Canvas.Font.Color  := clWhite;
       TStringGrid(Sender).Canvas.Font.Style  := [fsBold];
       TStringGrid(Sender).Canvas.Brush.Color := $00BD0000;
   end;

   case Acol of
      0 :  i_align  := 1; //가운데
      1 :  i_align  := 0; //좌측
   end;
   Common.Grid_Align(Sender, ACol, ARow, Rect, i_align);
end;

procedure TKitchenMemo2_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
   case Key of
     VK_F10 : if (ActiveControl is TCustomEdit) then TCustomEdit(ActiveControl).Clear;
     27     : obtn_close.Click;
    end;
end;

procedure TKitchenMemo2_F.sgr_GridClick(Sender: TObject);
begin
  inherited;
  if sgr_Grid.Cells[0,0] = '' then Exit;

  meo_Memo.Text := sgr_Grid.Cells[1, sgr_Grid.Row];
end;

procedure TKitchenMemo2_F.obtn_confirmClick(Sender: TObject);
begin
  inherited;
  Keybd_Event(VK_RIGHT,VK_RIGHT, 0, 0);
  if Trim(meo_Memo.Text) = '' then
  begin
    Common.ErrBox('주방메모를 입력하세요');
    Exit;
  end;
  MemoStr     := meo_Memo.EditingText;
  ModalResult := mrOK;
end;

procedure TKitchenMemo2_F.obtn_PrevClick(Sender: TObject);
begin
  inherited;
  if Sender = obtn_Prev then Common.RowPrev(sgr_Grid)
  else                       Common.RowNext(sgr_Grid);
end;

procedure TKitchenMemo2_F.obtn_closeClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TKitchenMemo2_F.SelectData;
begin
  MemoStr := '';
  Common.ClearGrid(sgr_Grid);
  OpenQuery('select b.CD_CODE, '
           +'       b.NM_CODE1 '
           +'  from MS_MENU_MEMO a inner join  '
           +'       MS_CODE      b on b.CD_STORE  = a.CD_STORE '
           +'                     and b.CD_KIND   = ''18'' '
           +'                     and b.CD_CODE   = a.CD_MEMO '
           +'                     and b.DS_STATUS = ''0'' '
           +' where a.CD_STORE = :P0 '
           +'   and a.CD_MENU  = :P1 '
           +' order by b.CD_CODE ',
           [Common.Config.StoreCode,
            MenuCode]);

  if not Common.Query.Eof then
  begin
    while not Common.Query.Eof do
    begin
      if sgr_Grid.Cells[0,0] <> '' then
        sgr_Grid.RowCount := sgr_Grid.RowCount + 1;
      sgr_Grid.Cells[0, sgr_Grid.RowCount-1] := Common.Query.Fields[0].AsString;
      sgr_Grid.Cells[1, sgr_Grid.RowCount-1] := Common.Query.Fields[1].AsString;
      Common.Query.Next;
    end;
  end
  else
  begin
    OpenQuery('select CD_CODE, '
             +'       NM_CODE1 '
             +'  from MS_CODE '
             +' where CD_STORE  =:P0 '
             +'   and CD_KIND   = ''18'' '
             +'   and DS_STATUS =''0'' '
             +' order by CD_CODE ',
             [Common.Config.StoreCode]);
    while not Common.Query.Eof do
    begin
      if sgr_Grid.Cells[0,0] <> '' then
        sgr_Grid.RowCount := sgr_Grid.RowCount + 1;
      sgr_Grid.Cells[0, sgr_Grid.RowCount-1] := Common.Query.Fields[0].AsString;
      sgr_Grid.Cells[1, sgr_Grid.RowCount-1] := Common.Query.Fields[1].AsString;
      Common.Query.Next;
    end;
  end;
  Common.Query.Close;
end;

end.
