unit BookingMenu_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit,
  Grids, DB, ExtCtrls, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxButtons, AdvGlassButton, dxGDIPlusClasses,
  cxLabel, AdvShape, Math, AdvSmoothButton;

type
  TBookingMenu_F = class(TForm)
    Booking_sGrd: TStringGrid;
    Menu_sGrd: TStringGrid;
    CloseButton: TcxButton;
    TitleLabel: TLabel;
    GridTitleShape: TAdvShape;
    AdvShape1: TAdvShape;
    CaptionLabel: TcxLabel;
    InputEdit: TcxTextEdit;
    Image3: TImage;
    MessageLabel: TLabel;
    GridPrevButton: TAdvGlassButton;
    GridNextButton: TAdvGlassButton;
    AddButton: TAdvSmoothButton;
    DeleteButton: TAdvSmoothButton;
    ConfirmButton: TAdvSmoothButton;
    SearchButton: TAdvSmoothButton;
    procedure Menu_sGrdDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure GridPrevButtonClick(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure Menu_sGrdDblClick(Sender: TObject);
    procedure Booking_sGrdDblClick(Sender: TObject);
    procedure InputEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SelectMenuMaster;
  public
    { Public declarations }
  end;

var
  BookingMenu_F: TBookingMenu_F;

implementation
uses Common_U, GlobalFunc_U;
{$R *.dfm}

procedure TBookingMenu_F.Menu_sGrdDblClick(Sender: TObject);
begin
  AddButtonClick(nil);
end;

procedure TBookingMenu_F.Menu_sGrdDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
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
      0    :  vAlign  := 0; //왼쪽정렬
      1    :  vAlign  := 2; //가운데
   end;
   Common.Grid_Align(Sender, ACol, ARow, Rect, vAlign);
   // 숫자형 출력시 Format 형식   //
   case ACol of
     1: Common.Grid_DisplayFormat(Sender, ACol, ARow, Rect);
   end;
end;

procedure TBookingMenu_F.AddButtonClick(Sender: TObject);
  function CheckMenu(aMenu:String):Integer;
  var nRow :Integer;
  begin
    Result := -1;
    For nRow := 0 to Booking_sGrd.RowCount-1 do
    begin
      if Booking_sGrd.Cells[2, nRow] = aMenu then
      begin
        Result := nRow;
        Break;
      end;
    end;
  end;
var vRtn : String;
    vRow : Integer;
begin
  if Menu_sGrd.Cells[0, Menu_sGrd.Row] = '' then Exit;

  vRtn := Common.ShowNumberForm('예약 수량을 입력하세요',0,999,'0');

  if (vRtn = 'mrClose') or (vRtn = '0') then Exit;

  //메뉴가 이미 있는지 체크한다
  vRow := CheckMenu(Menu_sGrd.Cells[2, Menu_sGrd.Row]);

  if (Booking_sGrd.Cells[0,0] <> '') and (vRow = -1) then Booking_sGrd.RowCount := Booking_sGrd.RowCount + 1;

  if vRow = -1 then vRow := Booking_sGrd.RowCount-1;

  Booking_sGrd.Cells[0, vRow] := Menu_sGrd.Cells[0, Menu_sGrd.Row];
  Booking_sGrd.Cells[1, vRow] := vRtn;
  Booking_sGrd.Cells[2, vRow] := Menu_sGrd.Cells[2, Menu_sGrd.Row];
  Booking_sGrd.Row  := vRow;
  DeleteButton.Visible := True;
end;

procedure TBookingMenu_F.Booking_sGrdDblClick(Sender: TObject);
begin
  DeleteButtonClick(nil);
end;

procedure TBookingMenu_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TBookingMenu_F.ConfirmButtonClick(Sender: TObject);
begin
  if Booking_sGrd.Cells[0,0] = '' then
  begin
    Common.ErrBox('예약메뉴가 없습니다');
    Exit;
  end;
  ModalResult := mrOK;
end;

procedure TBookingMenu_F.DeleteButtonClick(Sender: TObject);
begin
  if Booking_sGrd.Cells[0,Booking_sGrd.Row] = '' then Exit;

  Common.DeleteRow(Booking_sGrd, Booking_sGrd.Row);

  DeleteButton.Visible := Booking_sGrd.Cells[0,0] <> '';
end;

procedure TBookingMenu_F.FormCreate(Sender: TObject);
var vIndex :Integer;
begin
  Common.LogoCreate(Self,2);

  if Common.Config.Style = 'D' then
  begin
    Common.SetButtonColor(GridTitleShape);
    Common.SetButtonColor(AdvShape1);
  end;

  for vIndex := 0 to ComponentCount-1 do
    if Components[vIndex] is TAdvGlassButton then
      Common.SetButtonColor((Components[vIndex] as TAdvGlassButton));


  Menu_sGrd.DefaultRowHeight := Ifthen(Common.Config.ListRowHeight=0, 28, Common.Config.ListRowHeight);
  Menu_sGrd.ColWidths[0]    := 232;
  Menu_sGrd.ColWidths[1]    := 110;

  Booking_sGrd.DefaultRowHeight := Ifthen(Common.Config.ListRowHeight=0, 28, Common.Config.ListRowHeight);
  Booking_sGrd.ColWidths[0] := 232;
  Booking_sGrd.ColWidths[1] := 110;
end;

procedure TBookingMenu_F.SearchButtonClick(Sender: TObject);
begin
  SelectMenuMaster;
end;

procedure TBookingMenu_F.SelectMenuMaster;
begin
  OpenQuery('select NM_MENU_SHORT, '
           +'       Cast(PR_SALE as Char) as PR_SALE, '
           +'       CD_MENU '
           +'  from MS_MENU '
           +' where CD_STORE  =:P0'
           +'   and DS_MENU_TYPE in (''N'',''S'') '
           +'   and NM_MENU like :P1 '
           +'   and YN_USE    = ''Y'' '
           +' order by NM_MENU_SHORT ',
           [Common.Config.StoreCode,
            '%'+InputEdit.Text+'%']);

  Common.OpenDataToGrid(Common.Query, Menu_sGrd);
  Common.Query.Close;
  AddButton.Visible := Menu_sGrd.Cells[0,0] <> '';
end;

procedure TBookingMenu_F.FormShow(Sender: TObject);
begin
  InputEdit.Clear;
  SelectMenuMaster;
  DeleteButton.Visible := Booking_sGrd.Cells[0,0] <> '';
end;

procedure TBookingMenu_F.GridPrevButtonClick(Sender: TObject);
begin
  if Sender = GridPrevButton then Common.RowPrev(Menu_sGrd)
  else                            Common.RowNext(Menu_sGrd);
end;

procedure TBookingMenu_F.InputEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
   SearchButtonClick(nil);
end;

end.
