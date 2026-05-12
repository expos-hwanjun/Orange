unit MenuSearch_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, StdCtrls,  MaskUtils, jpeg, DB,
  cxControls, cxContainer, cxEdit, cxLabel, cxTextEdit, cxMemo, StrUtils,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxCurrencyEdit,
  cxGridCustomTableView, cxGridTableView, cxGridCustomView, cxClasses,
  cxGridLevel, cxGrid, Menus, cxButtons, KeyPad_F, AdvGlassButton,
  dxGDIPlusClasses, AdvSmoothToggleButton, AdvShape, Math, AdvSmoothButton;
type
  TMenuSearch_F = class(TForm)
    sgr_Grid: TStringGrid;
    lblGoodsCode: TcxLabel;
    lblGoodsName: TcxLabel;
    lblUnit: TcxLabel;
    lblSalePrice: TcxLabel;
    lblBuyPrice: TcxLabel;
    lblTrdpl: TcxLabel;
    GridTitleShape: TAdvShape;
    CaptionLabel: TcxLabel;
    cxLabel1: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel8: TcxLabel;
    SearchEdit: TcxTextEdit;
    MessageLabel: TLabel;
    Image3: TImage;
    cxLabel9: TcxLabel;
    fmKeyPad: TfmKeyPad;
    GridPrevButton: TAdvGlassButton;
    GridNextButton: TAdvGlassButton;
    CloseButton: TcxButton;
    TitleLabel: TLabel;
    ConfirmButton: TAdvSmoothButton;
    ClearButton: TAdvSmoothButton;
    KeypadButton: TAdvSmoothButton;
    SearchButton: TAdvSmoothButton;
    AdvSmoothButton1: TAdvSmoothButton;
    AdvSmoothButton2: TAdvSmoothButton;
    AdvSmoothButton3: TAdvSmoothButton;
    AdvSmoothButton4: TAdvSmoothButton;
    AdvSmoothButton5: TAdvSmoothButton;
    AdvSmoothButton6: TAdvSmoothButton;
    AdvSmoothButton7: TAdvSmoothButton;
    AdvSmoothButton8: TAdvSmoothButton;
    AdvSmoothButton9: TAdvSmoothButton;
    AdvSmoothButton10: TAdvSmoothButton;
    AdvSmoothButton11: TAdvSmoothButton;
    AdvSmoothButton12: TAdvSmoothButton;
    AdvSmoothButton13: TAdvSmoothButton;
    AdvSmoothButton14: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure sgr_GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgr_GridClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure KeypadButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure GridPrevButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure ChosungButtonClick(Sender: TObject);
  private
    procedure ClearDisplayInfo;
    procedure ScannerReadEvent(const S : String);
  public
    GoodsCode :String;
    procedure SelectGoods(aChosung:Boolean=false);
  end;

var
  MenuSearch_F: TMenuSearch_F;

implementation
uses GlobalFunc_U, Common_U, Const_U, DBModule_U;
{$R *.dfm}

{ TForm2 }
procedure TMenuSearch_F.FormCreate(Sender: TObject);
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

  sgr_Grid.ColWidths[0] := 35;    //번호
  sgr_Grid.ColWidths[1] := 165;   //상품코드
  sgr_Grid.ColWidths[2] := 220;   //상품명
  sgr_Grid.ColWidths[3] := 150;   //상품명
  lblBuyPrice.Visible   := GetOption(331) = '1';
end;


procedure TMenuSearch_F.SearchButtonClick(Sender: TObject);
begin
  SelectGoods;
end;

procedure TMenuSearch_F.SelectGoods(aChosung:Boolean);
var vIndex :Integer;
    vSearchTxt :String;
begin
  if Trim(SearchEdit.Text) = '' then
  begin
    Common.ErrBox('검색어를 입력하세요');
    Exit;
  end;

  OpenQuery('select a.CD_MENU, '
           +'       a.NM_MENU, '
           +'       a.NM_SPEC, '
           +'       a.PR_BUY, '
           +Ifthen(GetOption(194)='1','GetSalePrice(a.CD_STORE, a.CD_MENU) as PR_SALE, ', 'a.PR_SALE, ')
           +'       a.CD_CLASS, '
           +'       b.NM_TRDPL, '
           +'       a.QTY_SAFETY '
           +'  from MS_MENU a left outer join '
           +'       MS_TRD  b on a.CD_STORE = b.CD_STORE and a.CD_TRDPL = b.CD_TRDPL '
           +' where a.CD_STORE   =:P0   '
           +'   and a.YN_USE     =''Y'' '
           +'   and ( (a.CD_MENU = :P1) or (a.NM_MENU like ConCat(''%'',:P1,''%'')) or (GetChosung(a.NM_MENU) like ConCat(''%'',:P1,''%'')) ) '
           +' order by a.NM_MENU ',
          [Common.Config.StoreCode,
           SearchEdit.Text]);
  Common.ClearGrid(sgr_Grid);
  if Common.Query.eof then
  begin
    Common.Query.Close;
    ClearDisplayInfo;
    Exit;
  end;
  SearchEdit.EditModified := false;

  with sgr_Grid do
  begin
    while not Common.Query.Eof do
    begin
      if Cells[0,0] <> '' then RowCount := RowCount + 1;

      Cells[0, RowCount-1] := IntToStr(RowCount);
      Cells[1, RowCount-1] := Common.Query.FieldByName('CD_MENU').AsString;
      Cells[2, RowCount-1] := Common.Query.FieldByName('NM_MENU').AsString;
      Cells[3, RowCount-1] := Common.Query.FieldByName('PR_SALE').AsString;
      Cells[4, RowCount-1] := Common.Query.FieldByName('PR_BUY').AsString;
      Cells[6, RowCount-1] := Common.Query.FieldByName('QTY_SAFETY').AsString;
      Cells[7, RowCount-1] := Common.Query.FieldByName('NM_TRDPL').AsString;
      Cells[8, RowCount-1] := Common.Query.FieldByName('CD_CLASS').AsString;
      Cells[9, RowCount-1] := Common.Query.FieldByName('NM_SPEC').AsString;
      Common.Query.Next;
    end;
    Common.Query.Close;
    sgr_GridClick(nil);
  end;

end;


procedure TMenuSearch_F.sgr_GridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var  vAlign : integer;
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
      0,1 :  vAlign  := 1; //가운데
      2   :  vAlign  := 0; //왼쪽
      3   : vAlign := 2; //우측정렬
   end;
   Common.Grid_Align(Sender, ACol, ARow, Rect, vAlign);
  // 숫자형 출력시 Format 형식   //
  case aCol of
    3: Common.Grid_DisplayFormat(Sender, aCol, aRow, Rect);
  end;
end;

procedure TMenuSearch_F.sgr_GridClick(Sender: TObject);
begin
  if (sgr_Grid.Cells[0,0] = '') then Exit;

  with sgr_Grid do
  begin
    lblGoodsCode.Caption  := Cells[1,  Row];
    lblGoodsName.Caption  := Cells[2,  Row];
    lblUnit.Caption       := Cells[9,  Row];
    lblSalePrice.Caption  := FormatFloat('#,0', StoI(Cells[3,  Row]))+'원';
    lblbuyPrice.Caption   := FormatFloat('#,0', StoI(Cells[4,  Row]))+'원';
    lblTrdpl.Caption      := Cells[7,  Row];
  end;
end;

procedure TMenuSearch_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_UP     : GridPrevButtonClick(GridPrevButton);
    VK_DOWN   : GridPrevButtonClick(GridPrevButton);
    VK_ESCAPE : CloseButton.Click;
    VK_RETURN : if (sgr_Grid.Cells[0,0] <> '') and not SearchEdit.EditModified then
                  ConfirmButtonClick(ConfirmButton)
                else
                  SearchButtonClick(SearchButton);
  end;
end;

procedure TMenuSearch_F.FormShow(Sender: TObject);
begin
  sgr_Grid.DefaultRowHeight := Ifthen(Common.Config.ListRowHeight=0, 28, Common.Config.ListRowHeight);
  Common.ClearGrid(sgr_Grid);
  SearchEdit.Clear;
  ClearDisplayInfo;
  Common.Device.OnScannerReadData := ScannerReadEvent;
end;

procedure TMenuSearch_F.GridPrevButtonClick(Sender: TObject);
begin
  if Sender = GridPrevButton then Common.RowPrev(sgr_Grid)
  else                       Common.RowNext(sgr_Grid);
end;

procedure TMenuSearch_F.KeypadButtonClick(Sender: TObject);
begin
  fmKeyPad.Top     := 277;
  fmKeyPad.Left    := 568;
  fmKeyPad.Visible := not fmKeyPad.Visible;
  SearchEdit.SetFocus;
end;

procedure TMenuSearch_F.ChosungButtonClick(Sender: TObject);
const
  vChar :Array[1..14] of String =('ㄱ','ㄴ','ㄷ','ㄹ','ㅁ','ㅂ','ㅅ','ㅇ','ㅈ','ㅊ','ㅋ','ㅌ','ㅍ','ㅎ');
begin
  SearchEdit.Text := SearchEdit.Text + vChar[(Sender as TAdvSmoothButton).Tag];
  SearchEdit.SelStart := Length(SearchEdit.Text);
  if Length(SearchEdit.Text) >= 2 then
  begin
    SelectGoods(true);
  end;
end;

procedure TMenuSearch_F.ClearButtonClick(Sender: TObject);
begin
  Common.ClearGrid(sgr_Grid);
  SearchEdit.Clear;
  SearchEdit.SetFocus;
end;

procedure TMenuSearch_F.ClearDisplayInfo;
begin
  lblGoodsCode.Caption  := '';
  lblGoodsName.Caption  := '';
  lblSalePrice.Caption  := '';
  lblbuyPrice.Caption   := '';
  lblTrdpl.Caption      := '';
end;

procedure TMenuSearch_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TMenuSearch_F.ConfirmButtonClick(Sender: TObject);
begin
  if (sgr_Grid.Cells[0,0] = '') then
  begin
    MessageLabel.Caption := '조회된 내역이 없습니다';
    Exit;
  end;
  GoodsCode := lblGoodsCode.Caption;
  ModalResult := mrOK;

end;

procedure TMenuSearch_F.ScannerReadEvent(const S: String);
begin
  SearchEdit.Text := S;
  SelectGoods;
end;

end.
