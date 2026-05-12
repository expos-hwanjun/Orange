unit Course_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DB, jpeg, Math,
  AdvSmoothToggleButton, AdvShape, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxGDIPlusClasses, AdvGlassButton, cxButtons,
  PosButton, Common_U, AdvSmoothButton;

type
  TCourse_F = class(TForm)
    sgr_Grid: TStringGrid;
    lbl_Step: TLabel;
    GridTitleShape: TAdvShape;
    CloseButton: TcxButton;
    MessageLabel: TLabel;
    Image3: TImage;
    TitleLabel: TLabel;
    Menu1Button: TPosButton;
    Menu2Button: TPosButton;
    Menu3Button: TPosButton;
    Menu4Button: TPosButton;
    Menu5Button: TPosButton;
    Menu6Button: TPosButton;
    Menu7Button: TPosButton;
    Menu8Button: TPosButton;
    Menu9Button: TPosButton;
    Menu10Button: TPosButton;
    Menu11Button: TPosButton;
    Menu12Button: TPosButton;
    Menu13Button: TPosButton;
    Menu14Button: TPosButton;
    Menu15Button: TPosButton;
    Menu16Button: TPosButton;
    Menu17Button: TPosButton;
    PriorButton: TPosButton;
    NextButton: TPosButton;
    Shape1: TShape;
    Step1Button: TAdvSmoothToggleButton;
    Step2Button: TAdvSmoothToggleButton;
    Step3Button: TAdvSmoothToggleButton;
    Step4Button: TAdvSmoothToggleButton;
    Step5Button: TAdvSmoothToggleButton;
    Step6Button: TAdvSmoothToggleButton;
    Step7Button: TAdvSmoothToggleButton;
    ApprovalButton: TAdvSmoothButton;
    DeleteButton: TAdvSmoothButton;
    GridNextButton: TAdvSmoothButton;
    GridPriorButton: TAdvSmoothButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sgr_GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgr_GridClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Step1ButtonClick(Sender: TObject);
    procedure Menu1ButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure ApprovalButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure PriorButtonClick(Sender: TObject);
    procedure GridPriorButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    CourseButton :TAdvSmoothToggleButton;
    OrderCourseMenu  :Array of ^TCourseOrderMenu;
    MenuButton   :TPosButton;
    MenuData  : Array of Array of String;
    MenuCount,
    MenuPage   :Integer;
    isGetData :Boolean;
    isLoading,
    isDeleteing :Boolean;
    isDefaultEnable :Boolean;     //기본주문 적용여부
    procedure GetMenuData(vStep:Integer);
    procedure SetMenuDisplay;
    procedure GridSort;
    procedure SetStatusColor;
  public
    MenuName :String;
    OrderMenuCount :Integer;
  end;

var
  Course_F: TCourse_F;
  TempGrid:TStringGrid;
const
  CUR_STEP    = 0;
  CUR_NAME    = 1;
  CUR_QTY     = 2;
  CUR_CODE    = 3;
  CUR_KITCHEN = 4;
  CUR_STEPNO  = 5;
  CUR_BUTTON  = 6;
  CUR_PRICE   = 7;
  CUR_PRINTMENU= 8;


implementation
uses GlobalFunc_U, StrUtils, DBModule_U;
{$R *.dfm}

procedure TCourse_F.PriorButtonClick(Sender: TObject);
begin
  if Sender = PriorButton then MenuPage := MenuPage - 1
  else                         MenuPage := MenuPage + 1;
  SetMenuDisplay
end;

procedure TCourse_F.ApprovalButtonClick(Sender: TObject);
begin
  if sgr_Grid.Cells[0,0] = '' then
  begin
    OrderMenuCount := 0;
    if not Common.AskBox('추가 주문한 메뉴가 없습니다'#13'주문 하겠습니까?') then
      Exit;
  end
  else
    OrderMenuCount := sgr_Grid.RowCount;

  ModalResult := mrOK;
end;

procedure TCourse_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TCourse_F.FormCreate(Sender: TObject);
var vIndex :Integer;
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(GridTitleShape);
  Common.SetButtonColor(ApprovalButton);
  Common.SetButtonColor(GridPriorButton);
  Common.SetButtonColor(GridNextButton);

  with sgr_Grid do
  begin
     ColCount               := 9;
     ColWidths[CUR_STEP   ] := 130;  //단계
     ColWidths[CUR_NAME   ] := 241; //메뉴명
     ColWidths[CUR_QTY    ] := 50;  //수량
  end;
  TempGrid          := TStringGrid.Create(Application);
  TempGrid.ColCount := 9;
  TempGrid.RowCount := 0;
  MenuButton  := TPosButton.Create(Self);
  isGetData   := true;
  isDeleteing := false;
end;

procedure TCourse_F.FormDestroy(Sender: TObject);
begin
  SetLength(OrderCourseMenu, 0);
  SetLength(MenuData, 0, 0);
end;

procedure TCourse_F.FormShow(Sender: TObject);
var vStep, vIndex :Integer;
begin
  isLoading := true;
  TitleLabel.Caption := Common.GetPaPago(Format('코스메뉴 [%s]',[MenuName]));
  Common.SetLanguage(Self);
  PriorButton.Caption := Common.GetPaPago(PriorButton.Caption);
  NextButton.Caption  := Common.GetPaPago(NextButton.Caption);

  for vIndex := 1 to 7 do
    TAdvSmoothToggleButton(FindComponent(Format('Step%dButton',[vIndex]))).Visible := false;
  for vIndex := 1 to 17 do
  begin
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Color         := Common.Config.PluMenuColor;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).BorderInnerColor := Common.Config.PluMenuColor;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).BorderColor   := Common.Config.PluMenuBorderColor;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).BorderStyle   := pbsSingle;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Font          := Common.Config.PluMenuFont;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Font.Size     := Common.Config.PluMenuFont.Size;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Bottom.Font   := Common.Config.PluPriceFont;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Bottom.Height := Trunc(TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Height / 4)+3;
  end;

  PriorButton.Color            := Common.Config.PluMenuColor;
  PriorButton.BorderInnerColor := Common.Config.PluMenuColor;
  PriorButton.BorderColor      := Common.Config.PluMenuBorderColor;
  PriorButton.Font             := Common.Config.PluMenuFont;

  NextButton.Color             := Common.Config.PluMenuColor;
  NextButton.BorderInnerColor  := Common.Config.PluMenuColor;
  NextButton.BorderColor       := Common.Config.PluMenuBorderColor;
  NextButton.Font              := Common.Config.PluMenuFont;


  Common.ClearGrid(sgr_Grid);

  DM.OpenQuery('select distinct t1.NM_COURSE, '
              +'       t1.CNT_CHOOSE, '
              +'       t1.COURSE_SEQ '
              +'  from MS_COURSE  as t1 inner join '
              +'      (select a.COURSE_SEQ, '
              +'              Count(*) as CNT_MENU '
              +'         from MS_COURSE as a inner join '
              +'              MS_MENU   as b on b.CD_STORE = a.CD_STORE '
              +'                            and b.CD_MENU  = a.CD_MENU_COURSE '
              +'        where a.CD_STORE = :P0 '
              +'          and a.CD_MENU  = :P1 '
              +'          and Substring(b.CONFIG,8,1) <> ''Y'' '
              +Ifthen(Common.Table.Packing = 'Y', ' and SubString(b.CONFIG,10,1) <> ''Y'' ',' and SubString(b.CONFIG,10,1) <> ''S'' ')
              +'          and b.YN_USE = ''Y'' '
              +'        group by a.COURSE_SEQ) as t2 on t2.COURSE_SEQ = t1.COURSE_SEQ '
              +' where t1.CD_STORE =:P0 '
              +'   and t1.CD_MENU  =:P1 '
              +'   and t2.CNT_MENU > 0 '
              +' order by t1.COURSE_SEQ',
              [Common.Config.StoreCode,
               Common.Menu.cd_menu]);

  vStep := 1;
  while not DM.Query.Eof do
  begin
    TAdvSmoothToggleButton(FindComponent(Format('Step%dButton',[vStep]))).Caption            := Common.GetPaPago(DM.Query.FieldByName('NM_COURSE').AsString);
    TAdvSmoothToggleButton(FindComponent(Format('Step%dButton',[vStep]))).Status.Caption     := '0/'+DM.Query.FieldByName('CNT_CHOOSE').AsString;
    TAdvSmoothToggleButton(FindComponent(Format('Step%dButton',[vStep]))).Appearance.ImageIndex  := DM.Query.FieldByName('CNT_CHOOSE').AsInteger;      //선택가능수량
    TAdvSmoothToggleButton(FindComponent(Format('Step%dButton',[vStep]))).HelpContext        := 0;                                                     //선택수량
    TAdvSmoothToggleButton(FindComponent(Format('Step%dButton',[vStep]))).Tag                := DM.Query.FieldByName('COURSE_SEQ').AsInteger;
    TAdvSmoothToggleButton(FindComponent(Format('Step%dButton',[vStep]))).Visible            := True;
    TAdvSmoothToggleButton(FindComponent(Format('Step%dButton',[vStep]))).Hint               := 'N';
    DM.Query.Next;
    Inc(vStep);
    //최대 8단계까지
    if vStep = 8 then Break;
  end;
  DM.Query.Close;

  isDefaultEnable := true;
  for vIndex := 1 to vStep-1 do
    Step1ButtonClick(TAdvSmoothToggleButton(FindComponent(Format('Step%dButton',[vIndex]))));

  isDefaultEnable := false;
  //선택 할 첫번째 코스에 위치한다
  for vIndex := 1 to vStep-1 do
    if TAdvSmoothToggleButton(FindComponent(Format('Step%dButton',[vIndex]))).Appearance.ImageIndex > TAdvSmoothToggleButton(FindComponent(Format('Step%dButton',[vIndex]))).HelpContext then
    begin
      Step1ButtonClick(TAdvSmoothToggleButton(FindComponent(Format('Step%dButton',[vIndex]))));
      Break;
    end;

  isLoading := false;
end;

procedure TCourse_F.GetMenuData(vStep:Integer);
var vIndex :Integer;
begin
  isGetData := false;
  try
    DM.OpenQuery('select t1.CD_MENU_COURSE as CD_MENU, '
                +'       t1.NM_MENU_COURSE, '
                +'       t1.COURSE_SEQ, '
                +'       t2.CD_PRINTER, '
                +'       t3.CD_PRINTER AS CD_PRINTER1,'
                +'       t1.COLOR, '
                +'       t1.YN_DEFAULT, '
                +'       t2.NM_MENU_SHORT, '
                +'       t2.NM_MENU_KITCHEN, '
                +Ifthen(GetOption(194)='1','GetSalePrice(t1.CD_STORE, t1.CD_MENU_COURSE) as PR_SALE ', 't2.PR_SALE ')
                +'  from MS_COURSE t1 inner join '
                +'       MS_MENU   t2 on t1.CD_STORE	=t2.CD_STORE and t1.CD_MENU_COURSE =t2.CD_MENU inner join '
                +'       MS_MENU   t3 on t1.CD_STORE	=t3.CD_STORE and t1.CD_MENU	  =t3.CD_MENU '
                +' where t1.CD_STORE	 =:P0 '
                +'   and t1.CD_MENU  	 =:P1 '
                +'   and t1.COURSE_SEQ  =:P2 '
                +'   and Substring(t2.CONFIG,8,1) <> ''Y'' '
                +'   and t2.YN_USE = ''Y'' '
                +Ifthen(Common.Table.Packing = 'Y', ' and SubString(t2.CONFIG,10,1) <> ''Y'' ',' and SubString(t2.CONFIG,10,1) <> ''S'' ')
                +' order by t1.SEQ ',
                [Common.Config.StoreCode,
                 Common.Menu.cd_menu,
                 vStep]);

    MenuPage    := 1;
    MenuCount   := DM.Query.RecordCount;

    vIndex := 0;
    SetLength(MenuData, MenuCount, 9);
    while not DM.Query.Eof do
    begin
      MenuData[vIndex, 0] := DM.Query.FieldByName('CD_MENU').AsString;
      MenuData[vIndex, 1] := DM.Query.FieldByName('COURSE_SEQ').AsString;
      if GetOption(241) = '0' then
        MenuData[vIndex, 2] := DM.Query.FieldByName('CD_PRINTER1').AsString
      else
        MenuData[vIndex, 2] := DM.Query.FieldByName('CD_PRINTER').AsString;

      MenuData[vIndex, 4] := Common.GetPaPago(DM.Query.FieldByName('NM_MENU_SHORT').AsString);
      MenuData[vIndex, 5] := DM.Query.FieldByName('NM_MENU_SHORT').AsString;
      MenuData[vIndex, 6] := DM.Query.FieldByName('COLOR').AsString;
      MenuData[vIndex, 7] := DM.Query.FieldByName('PR_SALE').AsString;
      MenuData[vIndex, 8] := DM.Query.FieldByName('NM_MENU_KITCHEN').AsString;

      if (CourseButton.HelpContext < CourseButton.Appearance.ImageIndex) and (DM.Query.FieldByName('YN_DEFAULT').AsString = 'Y') and not isDeleteing then
      begin
        MenuButton.Caption := MenuData[vIndex, 4];
        MenuButton.Temp1   := MenuData[vIndex, 0];
        MenuButton.Temp2   := MenuData[vIndex, 2];
        MenuButton.Temp3   := MenuData[vIndex, 5];
        MenuButton.Temp4   := MenuData[vIndex, 7];
        MenuButton.Temp5   := MenuData[vIndex, 8];
        if isDefaultEnable then
          Menu1ButtonClick(MenuButton);
      end;
      DM.Query.Next;
      Inc(vIndex);
    end;
    DM.Query.Close;
    SetMenuDisplay;
  finally
    isGetData := true;
  end;
end;

procedure TCourse_F.SetMenuDisplay;
var vIndex, vIndex2 :Integer;
begin
  For vIndex := (MenuPage-1) * 17 to ((MenuPage-1) * 17) + 16 do
  begin
    vIndex2 := vIndex - ((MenuPage-1) * 17);
    if (vIndex <= MenuCount-1) and (MenuData[vIndex, 0] <> '') then
    begin
      TPosButton(FindComponent(Format('Menu%dButton',[vIndex2+1]))).Temp1   := MenuData[vIndex, 0];
      TPosButton(FindComponent(Format('Menu%dButton',[vIndex2+1]))).Temp2   := MenuData[vIndex, 2];
      TPosButton(FindComponent(Format('Menu%dButton',[vIndex2+1]))).Temp3   := MenuData[vIndex, 5];
      TPosButton(FindComponent(Format('Menu%dButton',[vIndex2+1]))).Color   := StringToColor(MenuData[vIndex, 6]);
      TPosButton(FindComponent(Format('Menu%dButton',[vIndex2+1]))).Temp4   := MenuData[vIndex, 7];
      TPosButton(FindComponent(Format('Menu%dButton',[vIndex2+1]))).Temp5   := MenuData[vIndex, 8];
      TPosButton(FindComponent(Format('Menu%dButton',[vIndex2+1]))).Caption := LineFeed(MenuData[vIndex, 4]);
      TPosButton(FindComponent(Format('Menu%dButton',[vIndex2+1]))).Visible := True;
      if GetOption(23) = '1' then
        TPosButton(FindComponent(Format('Menu%dButton',[vIndex2+1]))).Bottom.RightString := FormatFloat(',0원',StrToInt(MenuData[vIndex, 7]));

    end
    else
    begin
      TPosButton(FindComponent(Format('Menu%dButton',[vIndex2+1]))).Temp1   := '';
      TPosButton(FindComponent(Format('Menu%dButton',[vIndex2+1]))).Temp2   := '';
      TPosButton(FindComponent(Format('Menu%dButton',[vIndex2+1]))).Temp3   := '';
      TPosButton(FindComponent(Format('Menu%dButton',[vIndex2+1]))).Temp4   := '';
      TPosButton(FindComponent(Format('Menu%dButton',[vIndex2+1]))).Temp5   := '';
      TPosButton(FindComponent(Format('Menu%dButton',[vIndex2+1]))).Caption := '';
      TPosButton(FindComponent(Format('Menu%dButton',[vIndex2+1]))).Visible := False;
      TPosButton(FindComponent(Format('Menu%dButton',[vIndex2+1]))).Bottom.RightString := '';
    end;
  end;
  if MenuCount <= 17 then
  begin
    PriorButton.Visible := false;
    NextButton.Visible  := false;
  end
  else
  begin
    PriorButton.Visible := true;
    NextButton.Visible  := true;
    GridPriorButton.Enabled := MenuPage > 1;
    //총페이지 구함
    vIndex2 := (MenuCount div 17 );
    if (MenuCount mod 17 ) > 0 then
      vIndex2 := vIndex2 + 1;
    NextButton.Enabled := MenuPage < vIndex2 ;
    PriorButton.Enabled := vIndex2 > 1;
    NextButton.Enabled  := vIndex2 > 1;
  end;
end;

procedure TCourse_F.SetStatusColor;
var vIndex, vCount :Integer;
begin
  vCount := 0;
  for vIndex := 1 to 7 do
  begin
    if TAdvSmoothToggleButton(FindComponent(Format('Step%dButton',[vIndex]))).HelpContext = TAdvSmoothToggleButton(FindComponent(Format('Step%dButton',[vIndex]))).Appearance.ImageIndex then
      TAdvSmoothToggleButton(FindComponent(Format('Step%dButton',[vIndex]))).Status.Appearance.Fill.Color := clSkyBlue
    else if TAdvSmoothToggleButton(FindComponent(Format('Step%dButton',[vIndex]))).Visible then
    begin
      TAdvSmoothToggleButton(FindComponent(Format('Step%dButton',[vIndex]))).Status.Appearance.Fill.Color := clRed;
      Inc(vCount);
    end;
  end;

  if not isLoading and (vCount = 0) then
  begin
    MessageLabel.Caption := Common.GetPaPago('메뉴를 모두 선택하셨습니다');
    ApprovalButtonClick(ApprovalButton);
  end;
end;

{삭제버튼 클릭 시}
procedure TCourse_F.sgr_GridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var  i_align : integer;
begin
  TStringGrid(Sender).Canvas.Font.Size := 14;
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
      1   :  i_align  := 0; //좌측
   end;
   Common.Grid_Align(Sender, ACol, ARow, Rect, i_align);
end;

procedure TCourse_F.Step1ButtonClick(Sender: TObject);
var vIndex :Integer;
begin
  for vIndex := 1 to 7 do
  begin
    TAdvSmoothToggleButton(FindComponent(Format('Step%dButton',[vIndex]))).Appearance.SimpleLayout := false;
    TAdvSmoothToggleButton(FindComponent(Format('Step%dButton',[vIndex]))).Down := false;
  end;

  (Sender as TAdvSmoothToggleButton).Appearance.SimpleLayout := true;
  (Sender as TAdvSmoothToggleButton).Down := true;

  CourseButton     := (Sender as TAdvSmoothToggleButton);
  CourseButton.Tag := (Sender as TAdvSmoothToggleButton).Tag;
  if isGetData then
    GetMenuData( (Sender as TAdvSmoothToggleButton).Tag);
  (Sender as TAdvSmoothToggleButton).Hint := 'Y';
  DeleteButton.Enabled   := sgr_Grid.Cells[0,0] <> '';

  MessageLabel.Caption := CourseButton.Caption +Common.GetPaPago(' 단계 메뉴를 선택하세요');
end;

{이전단계 버튼 클릭시}
procedure TCourse_F.sgr_GridClick(Sender: TObject);
begin
  if sgr_Grid.Cells[0,0] = '' then Exit;
end;

procedure TCourse_F.GridPriorButtonClick(Sender: TObject);
begin
  if Sender = GridPriorButton then Common.RowPrev(sgr_Grid)
  else                             Common.RowNext(sgr_Grid);
end;

procedure TCourse_F.GridSort;
var I,J :Integer;
begin
  Common.ClearGrid(TempGrid);
  for I := 0 to sgr_Grid.RowCount-2 do
    for J := I+1 to sgr_Grid.RowCount-1 do
    begin
      if StrToInt(sgr_Grid.Cells[5,I]) > StrToInt(sgr_Grid.Cells[5,J]) then
      begin
        TempGrid.Rows[0].Assign( sgr_Grid.Rows[I]);
        sgr_Grid.Rows[I].Assign( sgr_Grid.Rows[J]);
        sgr_Grid.Rows[J].Assign( TempGrid.Rows[0]);
      end;
    end;
end;

procedure TCourse_F.Menu1ButtonClick(Sender: TObject);
  {현재 단계의 메뉴가 존재하는지 체크}
  function GetMenuExist(AValue:String):Integer;
  var vIndex :Integer;
  begin
    Result := -1;
    for vIndex := 0 to sgr_Grid.RowCount-1 do
      if (sgr_Grid.Cells[CUR_STEP, vIndex]+sgr_Grid.Cells[CUR_CODE, vIndex]) = AValue then
      begin
        Result := vIndex;
        Break;
      end;
  end;
var vIndex ,
    vStep :Integer;
begin
  if CourseButton = nil then Exit;

  if not isLoading and (CourseButton.HelpContext >= CourseButton.Appearance.ImageIndex) then
  begin
    Common.ErrBox('가능수량을 모두 선택했습니다');
    Exit;
  end;

  with sgr_Grid do
  begin
    {Row 추가}
    vIndex := GetMenuExist( CourseButton.Caption + (Sender as TPosButton).Temp1 );
    if (Cells[0,0] = '') or (vIndex = -1)  then
    begin
      if Cells[0,0] <> '' then RowCount := RowCount + 1;
      Cells[CUR_STEP    ,RowCount-1] := Copy(CourseButton.Caption,1,6);       //단계
      Cells[CUR_NAME    ,RowCount-1] := (Sender as TPosButton).Temp3;  //메뉴명
      Cells[CUR_QTY     ,RowCount-1] := '1';                             //수량
      Cells[CUR_CODE    ,RowCount-1] := (Sender as TPosButton).Temp1;    //메뉴코드
      Cells[CUR_KITCHEN ,RowCount-1] := (Sender as TPosButton).Temp2;    //주방프린터
      Cells[CUR_STEPNO  ,RowCount-1] := IntToStr(CourseButton.Tag);
      Cells[CUR_BUTTON  ,RowCount-1] := CourseButton.Name;
      Cells[CUR_PRICE   ,RowCount-1] := (Sender as TPosButton).Temp4;    //단가
      Cells[CUR_PRINTMENU   ,RowCount-1] := (Sender as TPosButton).Temp5;    //단가
      Row  := RowCount - 1;
      CourseButton.HelpContext := CourseButton.HelpContext + 1;
      CourseButton.Status.Caption := Format('%d/%d',[CourseButton.HelpContext, CourseButton.Appearance.ImageIndex]);
      vIndex := Row;
    end
    else if vIndex >= 0 then
    begin
      Cells[CUR_QTY   ,vIndex]      := IntToStr( StrToInt(Cells[CUR_QTY   ,vIndex])+1 );
      CourseButton.HelpContext      := CourseButton.HelpContext + 1;
      CourseButton.Status.Caption   := Format('%d/%d',[CourseButton.HelpContext, CourseButton.Appearance.ImageIndex]);
    end;
  end;
  GridSort;
  sgr_Grid.Row := vIndex;
  DeleteButton.Enabled := sgr_Grid.Cells[0,0] <> '';
  //선택가능 메뉴를 모두 선택했으면 다음 단계로 넘어간다
  if CourseButton.HelpContext = CourseButton.Appearance.ImageIndex then
  begin
    vStep := StoI(Copy(CourseButton.Name,5,1))+1;
    if (vStep < 8) and TAdvSmoothToggleButton(FindComponent(Format('Step%dButton',[vStep]))).Visible then
      Step1ButtonClick(TAdvSmoothToggleButton(FindComponent(Format('Step%dButton',[vStep]))));
  end;
  SetStatusColor;
end;

procedure TCourse_F.DeleteButtonClick(Sender: TObject);
var vButton :String;
begin
  if not Assigned(TAdvSmoothToggleButton(FindComponent(sgr_Grid.Cells[CUR_BUTTON, sgr_Grid.Row]))) then Exit;

  TAdvSmoothToggleButton(FindComponent(sgr_Grid.Cells[CUR_BUTTON, sgr_Grid.Row])).HelpContext := TAdvSmoothToggleButton(FindComponent(sgr_Grid.Cells[CUR_BUTTON, sgr_Grid.Row])).HelpContext
                                                                                                         -StrToInt(sgr_Grid.Cells[CUR_QTY, sgr_Grid.Row]);
  TAdvSmoothToggleButton(FindComponent(sgr_Grid.Cells[CUR_BUTTON, sgr_Grid.Row])).Status.Caption := Format('%d/%d',[TAdvSmoothToggleButton(FindComponent(sgr_Grid.Cells[CUR_BUTTON, sgr_Grid.Row])).HelpContext,
                                                                                                                    TAdvSmoothToggleButton(FindComponent(sgr_Grid.Cells[CUR_BUTTON, sgr_Grid.Row])).Appearance.ImageIndex]);

  isLoading := true;
  isDeleteing := true;
  try
    vButton := sgr_Grid.Cells[CUR_BUTTON, sgr_Grid.Row];
    Common.DeleteRow(sgr_Grid, sgr_Grid.Row);
    Step1ButtonClick(TAdvSmoothToggleButton(FindComponent(vButton)));
    DeleteButton.Enabled := sgr_Grid.Cells[0,0] <> '';
    SetStatusColor;
  finally
    isLoading   := false;
    isDeleteing := false;
  end;
end;

procedure TCourse_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then CloseButton.Click;
end;

end.
