unit OpenSet_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ExtCtrls, Grids, StdCtrls, GraphicEx, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, cxButtons, cxLabel, AdvGlassButton, dxGDIPlusClasses, PosButton,
  AdvShape, AdvSmoothButton;

type
  TOpenSet_F = class(TForm)
    sgr_Grid: TStringGrid;
    lbl_Step: TLabel;
    GridTitleShape: TAdvShape;
    Menu1Button: TPosButton;
    Menu3Button: TPosButton;
    Menu2Button: TPosButton;
    Menu5Button: TPosButton;
    Menu6Button: TPosButton;
    Menu4Button: TPosButton;
    Menu8Button: TPosButton;
    Menu9Button: TPosButton;
    Menu7Button: TPosButton;
    Menu11Button: TPosButton;
    Menu12Button: TPosButton;
    Menu10Button: TPosButton;
    Menu14Button: TPosButton;
    Menu15Button: TPosButton;
    Menu13Button: TPosButton;
    Menu17Button: TPosButton;
    Menu16Button: TPosButton;
    PriorButton: TPosButton;
    NextButton: TPosButton;
    MessageLabel: TLabel;
    Image3: TImage;
    MenuNameLabel: TcxLabel;
    CloseButton: TcxButton;
    TitleLabel: TLabel;
    CountLabel: TcxLabel;
    ConfirmButton: TAdvSmoothButton;
    DeleteButton: TAdvSmoothButton;
    GridPrevButton: TAdvSmoothButton;
    GridNextButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sgr_GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure PriorButtonClick(Sender: TObject);
    procedure GridPrevButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure Menu1ButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
  private
    MenuData  : Array of Array of String;
    ButtonMaxCount,
    ButtonPage,
    SelectMenuCount:Integer;
    procedure SetButtonData;
  public
    { Public declarations }
  end;

var
  OpenSet_F: TOpenSet_F;

implementation
uses Common_U, GlobalFunc_U, DBModule_U;
{$R *.dfm}

procedure TOpenSet_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(GridTitleShape);
  Common.SetButtonColor(GridPrevButton);
  Common.SetButtonColor(GridNextButton);
  Common.SetButtonColor(DeleteButton);
  Common.SetButtonColor(ConfirmButton);
  with sgr_Grid do
  begin
     ColCount     := 4;
     ColWidths[0] := 38;  //순번
     ColWidths[1] := 238; //메뉴명
     ColWidths[2] := 55;  //수량
  end;
end;

procedure TOpenSet_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TOpenSet_F.ConfirmButtonClick(Sender: TObject);
begin
  if Sender = ConfirmButton then
  begin
    if Common.Menu.qty_select > SelectMenuCount then
    begin
      if not Common.AskBox('선택할 수 있는 메뉴가 남았습니다'+#13#13+
                           '메뉴선택을 완료하시겠습니까?') then Exit;
    end;
    ModalResult := mrOK
  end
  else Close;
end;

procedure TOpenSet_F.DeleteButtonClick(Sender: TObject);
var vIndex :Integer;
begin
  SelectMenuCount := SelectMenuCount - StoI(sgr_Grid.Cells[2,sgr_Grid.Row]);
  Common.DeleteRow(sgr_Grid, sgr_Grid.Row);
  DeleteButton.Enabled := sgr_Grid.Cells[0,0] <> '';

  if DeleteButton.Enabled then
  For vIndex :=0 to sgr_Grid.RowCount-1 do
    sgr_Grid.Cells[0, vIndex] := IntToStr(vIndex+1);

  ConfirmButton.Enabled := SelectMenuCount > 0;
end;

procedure TOpenSet_F.FormShow(Sender: TObject);
var vIndex : Integer;
begin
  Common.ClearGrid(sgr_Grid);
  MenuNameLabel.Caption := Common.Menu.nm_menu;
  CountLabel.Caption    := Format('최대 %d개',[Common.Menu.qty_select]);
  SelectMenuCount       := 0;
  DeleteButton.Enabled  := False;
  ConfirmButton.Enabled := False;

  for vIndex := 1 to 17 do
  begin
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Visible          := False;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Color            := Common.Config.PluMenuColor;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).BorderColor      := Common.Config.PluMenuBorderColor;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).BorderStyle      := pbsSingle;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Font             := Common.Config.PluMenuFont;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Font.Size        := Common.Config.PluMenuFont.Size + 2;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).BorderInnerColor := clNone;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Bottom.Font      := Common.Config.PluMenuFont;
  end;
  PriorButton.Color := Common.Config.PluMenuColor;
  PriorButton.Font  := Common.Config.PluMenuFont;
  NextButton.Color  := Common.Config.PluMenuColor;
  NextButton.Font   := Common.Config.PluMenuFont;


  DM.Query.Options.QueryRecCount := true;
  DM.OpenQuery('select t1.CD_MENU_SET AS CD_MENU, '
              +'       t2.NM_MENU, '
              +'       t1.QTY_SET, '
              +'       t2.CD_PRINTER, '
              +'       t1.COLOR '
              +'  from MS_MENU_OPEN t1 inner join '
              +'       MS_MENU      t2 on t1.CD_STORE    = t2.CD_STORE '
              +'                      and t1.CD_MENU_SET = t2.CD_MENU '
              +' where t1.CD_STORE    =:P0 '
              +'   and t1.CD_MENU     =:P1 '
              +' order by t1.SEQ ',
              [Common.Config.StoreCode,
               Common.Menu.cd_menu]);
  ButtonMaxCount   := DM.Query.RecordCount;
  ButtonPage := 1;

  vIndex := 0;
  SetLength(MenuData, ButtonMaxCount,5 );
  while not DM.Query.Eof do
  begin
    MenuData[vIndex, 0] := DM.Query.FieldByName('CD_MENU').AsString;
    MenuData[vIndex, 1] := Common.GetPaPago(DM.Query.FieldByName('NM_MENU').AsString);
    MenuData[vIndex, 2] := DM.Query.FieldByName('QTY_SET').AsString;
    MenuData[vIndex, 3] := DM.Query.FieldByName('CD_PRINTER').AsString;
    MenuData[vIndex, 4] := DM.Query.FieldByName('COLOR').AsString;
    DM.Query.Next;
    Inc(vIndex);
  end;
  DM.Query.Close;
  DM.Query.Options.QueryRecCount := false;
  SetButtonData;
  Common.SetLanguage(Self);
end;

procedure TOpenSet_F.GridPrevButtonClick(Sender: TObject);
begin
  if Sender = GridPrevButton then Common.RowPrev(sgr_Grid)
  else if Sender = GridNextButton then Common.RowNext(sgr_Grid);
end;

procedure TOpenSet_F.Menu1ButtonClick(Sender: TObject);
  function GetRecordIndex(aMenuCode:String):Integer;
  var vIndex : Integer;
  begin
    Result := -1;
    for vIndex := 0 to sgr_Grid.RowCount-1 do
    begin
      if sgr_Grid.Cells[3, vIndex] = aMenuCode then
      begin
        Result := vIndex;
        Break;
      end;
    end;
  end;
var vRowIndex :Integer;
begin
  if SelectMenuCount = Common.Menu.qty_select then
  begin
    Common.ErrBox('메뉴를 모두 선택하셨습니다');
    Exit;
  end;

  vRowIndex := GetRecordIndex((Sender as TPosButton).Hint);
  if vRowIndex < 0 then
  begin
    with sgr_Grid do
    begin
      if Cells[0,0] <> '' then RowCount := RowCount + 1;
      Cells[0  ,RowCount-1]  := IntToStr(RowCount);                 //번호
      Cells[1  ,RowCount-1]  := (Sender as TPosButton).Caption; //메뉴명
      Cells[2  ,RowCount-1]  := IntToStr( (Sender as TPosButton).Tag );    //메뉴수량
      Cells[3  ,RowCount-1]  := (Sender as TPosButton).Hint;    //메뉴코드
      Cells[4  ,RowCount-1]  := (Sender as TPosButton).Temp1;    //메뉴코드
      Row := RowCount - 1;
    end;
  end
  else
  begin
    sgr_Grid.Cells[2, vRowIndex] := IntToStr(StoI(sgr_Grid.Cells[2, vRowIndex]) + (Sender as TPosButton).Tag);
    sgr_Grid.Row := vRowIndex;
  end;
  SelectMenuCount      := SelectMenuCount + 1;  //선택한 메뉴수량 추가
  DeleteButton.Enabled := True;
  ConfirmButton.Enabled := True;
end;

procedure TOpenSet_F.SetButtonData;
var vIndex :Integer;
begin
  For vIndex := 1 to 17 do
  begin
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Hint    := '';
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Caption := '';
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Tag     := 0;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Temp1   := '';
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Visible := false;
  end;

  For vIndex := 1  to 17 do
  begin
    if ( ((ButtonPage-1)*17) + vIndex ) > High(MenuData)+1 then Continue;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Hint    := MenuData[((ButtonPage-1)*17+vIndex-1), 0];
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Caption := MenuData[((ButtonPage-1)*17+vIndex-1), 1];
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Tag     := StoI(MenuData[((ButtonPage-1)*17+vIndex-1), 2]);
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Temp1   := MenuData[((ButtonPage-1)*17+vIndex-1), 3];
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Color   := StringToColorDef(MenuData[((ButtonPage-1)*17+vIndex-1), 4],Common.Config.PluMenuColor);
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Visible := True;
  end;
  PriorButton.Visible := ButtonPage > 1;

  PriorButton.Visible := ButtonPage > 1;
  NextButton.Visible := ButtonPage <= (ButtonMaxCount div 17);
end;

procedure TOpenSet_F.PriorButtonClick(Sender: TObject);
begin
  if Sender = PriorButton then ButtonPage := ButtonPage - 1
  else                        ButtonPage := ButtonPage + 1;
  SetButtonData;
end;

procedure TOpenSet_F.sgr_GridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var  i_align : integer;
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
    0,2 :  i_align  := 1; //가운데
     1 :  i_align  := 0; //좌측
  end;
  Common.Grid_Align(Sender, ACol, ARow, Rect, i_align);
end;

end.
