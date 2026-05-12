unit MenuItem_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, jpeg, ExtCtrls, StdCtrls, StrUtils, Menus,
  cxLookAndFeelPainters, cxButtons, cxGraphics, cxLookAndFeels, cxControls,
  cxContainer, cxEdit, cxLabel, AdvSmoothToggleButton, cxTextEdit,
  AdvGlassButton, dxGDIPlusClasses, cxCurrencyEdit, PosButton, AdvSmoothButton;

type
  TMenuItem_F = class(TForm)
    CloseButton: TcxButton;
    TitleLabel: TLabel;
    SalePriceEdit: TcxCurrencyEdit;
    ItemAmtEdit: TcxCurrencyEdit;
    TotalAmtEdit: TcxCurrencyEdit;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    MessageLabel: TLabel;
    Image3: TImage;
    Image2: TImage;
    SelectedItemEdit: TcxTextEdit;
    Item1Button: TPosButton;
    Item2Button: TPosButton;
    Item3Button: TPosButton;
    Item4Button: TPosButton;
    Item5Button: TPosButton;
    Item6Button: TPosButton;
    Item7Button: TPosButton;
    Item8Button: TPosButton;
    Item9Button: TPosButton;
    Item10Button: TPosButton;
    Item11Button: TPosButton;
    Item12Button: TPosButton;
    PriorButton: TPosButton;
    NextButton: TPosButton;
    ConfirmButton: TAdvSmoothButton;
    InitButton: TAdvSmoothButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure Item1ButtonClick(Sender: TObject);
    procedure PriorButtonClick(Sender: TObject);
    procedure InitButtonClick(Sender: TObject);
  private
    SelectedCount: Integer;
    ButtonMaxCount :Integer;
    ButtonData      :Array of Array of String;
    ButtonPage  :Integer;
    ButtonCount :Integer;
    procedure SetButtonData;
  public
    MaxCount :Integer;       //총주문가능 메뉴수량
    ItemCode  :String;
    ItemName  :String;
    ItemPrice :Integer;
    MenuCode  :String;
  end;

var
  MenuItem_F: TMenuItem_F;

implementation

uses Common_U, Order_U, GlobalFunc_U, Uni, DBModule_U;

{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';
procedure TMenuItem_F.FormCreate(Sender: TObject);
var vIndex :Integer;
begin
  OnShow := FormShow;
  Common.LogoCreate(Self,2);
  for vIndex := 0 to ComponentCount-1 do
    if Components[vIndex] is TAdvSmoothButton then
      Common.SetButtonColor((Components[vIndex] as TAdvSmoothButton));
  BlockInput(false);
end;

procedure TMenuItem_F.FormShow(Sender: TObject);
var vIndex :Integer;
begin
  for vIndex := 1 to 12 do
  begin
    TPosButton(FindComponent(Format('Item%dButton',[vIndex]))).Visible          := False;
    TPosButton(FindComponent(Format('Item%dButton',[vIndex]))).Color            := Common.Config.PluMenuColor;
    TPosButton(FindComponent(Format('Item%dButton',[vIndex]))).BorderInnerColor := Common.Config.PluMenuColor;
    TPosButton(FindComponent(Format('Item%dButton',[vIndex]))).BorderColor      := Common.Config.PluMenuBorderColor;
    TPosButton(FindComponent(Format('Item%dButton',[vIndex]))).BorderStyle      := pbsSingle;
    TPosButton(FindComponent(Format('Item%dButton',[vIndex]))).Font             := Common.Config.PluMenuFont;
    TPosButton(FindComponent(Format('Item%dButton',[vIndex]))).Font.Size        := Common.Config.PluMenuFont.Size + 2;
    TPosButton(FindComponent(Format('Item%dButton',[vIndex]))).BorderInnerColor := clNone;
    TPosButton(FindComponent(Format('Item%dButton',[vIndex]))).Bottom.Font      := Common.Config.PluMenuFont;
  end;

  PriorButton.Color            := Common.Config.PluMenuColor;
  PriorButton.BorderInnerColor := Common.Config.PluMenuColor;
  PriorButton.BorderColor      := Common.Config.PluMenuBorderColor;
  PriorButton.Font             := Common.Config.PluMenuFont;

  NextButton.Color             := Common.Config.PluMenuColor;
  NextButton.BorderInnerColor  := Common.Config.PluMenuColor;
  NextButton.BorderColor       := Common.Config.PluMenuBorderColor;
  NextButton.Font              := Common.Config.PluMenuFont;

  try
    SelectedCount := 0;

    ItemCode  := EmptyStr;
    ItemName  := EmptyStr;
    ItemPrice := 0;
    TitleLabel.Caption   := Common.Menu.nm_menu;
    SelectedItemEdit.Clear;
    SalePriceEdit.Value    := Common.Menu.pr_sale;
    ItemAmtEdit.Value      := 0;
    TotalAmtEdit.Value     := ItemPrice + Common.Menu.pr_sale;

    MessageLabel.Caption := Common.GetPapago(Format('아이템을 선택해주세요(최대 %d개)',[MaxCount]));

    DM.OpenQuery('select b.CD_MENU, '
                +'       b.NM_MENU_SHORT, '
                +'       b.NM_MENU_KITCHEN, '
                +'       case when b.DS_TAX = ''2'' then b.PR_SALE * 0.1 + b.PR_SALE else b.PR_SALE end as PR_SALE, '
                +'       b.QTY_SELECT '
                +'  from MS_MENU_ITEM a inner join '
                +'       MS_MENU      b on a.CD_STORE = b.CD_STORE '
                +'                     and a.CD_ITEM  = b.CD_MENU '
                +' where a.CD_STORE = :P0 '
                +'   and a.CD_MENU  = :P1 '
                +'   and b.YN_USE   = ''Y'' '
                +'   and b.DS_MENU_TYPE = ''I'' '
                +'   and Substring(b.CONFIG,8,1) <> ''Y'' '
                +Ifthen(Common.Table.Packing = 'Y', ' and SubString(b.CONFIG,10,1) <> ''Y'' ',' and SubString(b.CONFIG,10,1) <> ''S'' ')
                +' order by a.SEQ, a.CD_ITEM ',
                [Common.Config.StoreCode,
                 MenuCode]);

    ButtonMaxCount := DM.Query.RecordCount;
    SetLength(ButtonData, ButtonMaxCount, 7);
    ButtonPage := 1;
    vIndex := 0;
    while not DM.Query.Eof do
    begin
      ButtonData[vIndex, 0] := DM.Query.FieldByName('CD_MENU').AsString;            //메뉴코드
      ButtonData[vIndex, 1] := Common.GetPapago(DM.Query.FieldByName('NM_MENU_SHORT').AsString);      //아이템명
      ButtonData[vIndex, 2] := DM.Query.FieldByName('PR_SALE').AsString;            //판패단가
      ButtonData[vIndex, 3] := 'N';
      ButtonData[vIndex, 4] := '0';                                                      //추가추량
      ButtonData[vIndex, 5] := DM.Query.FieldByName('QTY_SELECT').AsString;         //추가가능수량
      ButtonData[vIndex, 6] := DM.Query.FieldByName('NM_MENU_KITCHEN').AsString;
      Inc(vIndex);
      DM.Query.Next;
    end;
    DM.Query.Close;
    PriorButton.Visible := vIndex > 12;
    NextButton.Visible := vIndex > 12;

    if not NextButton.Visible then
      SelectedItemEdit.Width := 478;
  finally
    SetButtonData;
  end;
  Common.SetLanguage(Self);
end;

procedure TMenuItem_F.CloseButtonClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;


procedure TMenuItem_F.SetButtonData;
var vIndex :Integer;
begin
  For vIndex := 1 to 12 do
  begin
    TPosButton(FindComponent(Format('Item%dButton',[vIndex]))).Caption := '';
    TPosButton(FindComponent(Format('Item%dButton',[vIndex]))).Hint    := '';
    TPosButton(FindComponent(Format('Item%dButton',[vIndex]))).Visible := False;
    TPosButton(FindComponent(Format('Item%dButton',[vIndex]))).Tag := 0;
  end;

  For vIndex := 1  to 12 do
  begin
    if ( ((ButtonPage-1)*12) + vIndex ) > High(ButtonData)+1 then Continue;
    TPosButton(FindComponent(Format('Item%dButton',[vIndex]))).Hint              := ButtonData[((ButtonPage-1)*12) + vIndex-1, 0];
    TPosButton(FindComponent(Format('Item%dButton',[vIndex]))).Caption           := ButtonData[((ButtonPage-1)*12) + vIndex-1, 1];
    TPosButton(FindComponent(Format('Item%dButton',[vIndex]))).Bottom.RightString := FormatFloat('#,0원',StrToInt(ButtonData[((ButtonPage-1)*12) + vIndex-1, 2]));  //판매단가
    TPosButton(FindComponent(Format('Item%dButton',[vIndex]))).HelpContext       := StrToInt(ButtonData[((ButtonPage-1)*12) + vIndex-1, 4]);
    TPosButton(FindComponent(Format('Item%dButton',[vIndex]))).Visible           := true;
    TPosButton(FindComponent(Format('Item%dButton',[vIndex]))).Temp1             := ButtonData[((ButtonPage-1)*12) + vIndex-1, 6];
    if ButtonData[((ButtonPage-1)*(ButtonCount+1)) + vIndex-1, 3] = 'Y' then
     TPosButton(FindComponent(Format('Item%dButton',[vIndex]))).BorderInnerColor := clRed
    else
     TPosButton(FindComponent(Format('Item%dButton',[vIndex]))).BorderInnerColor := clWhite;

    TPosButton(FindComponent(Format('Item%dButton',[vIndex]))).Tag := ((ButtonPage-1)*12) + vIndex-1;
  end;
  PriorButton.Visible := ButtonPage > 1;

  PriorButton.Visible := ButtonPage > 1;
  NextButton.Visible := ButtonPage <= (ButtonMaxCount div 12);
end;


procedure TMenuItem_F.PriorButtonClick(Sender: TObject);
begin
  if Sender = PriorButton then ButtonPage := ButtonPage -1
  else if Sender = NextButton then ButtonPage := ButtonPage +1;

  SetButtonData;

end;

procedure TMenuItem_F.InitButtonClick(Sender: TObject);
var vIndex :Integer;
begin
  SelectedItemEdit.Clear;
  for vIndex := 1 to 12 do
    TPosButton(FindComponent(Format('Item%dButton',[vIndex]))).BorderInnerColor := clWhite;

  for vIndex := 0 to High(ButtonData) do
  begin
    ButtonData[vIndex, 3] := 'N';
    ButtonData[vIndex, 4] := '0';
  end;

end;

procedure TMenuItem_F.Item1ButtonClick(Sender: TObject);
var
  vIndex :Integer;
  vIndex2 :Integer;
  vCount :Integer;
begin
  vIndex :=(Sender as TPosButton).Tag;


  ButtonData[vIndex, 3] := 'Y';
  if StoI(ButtonData[vIndex, 4]) = 0 then
  begin
    if (ButtonData[vIndex, 3] = 'N') and (SelectedCount = 10) then
    begin
      Common.MsgBox('아이템은 10개까지 선택이 가능합니다');
      Exit;
    end;
    Inc(SelectedCount);
  end;

  vCount := 0;
  for vIndex2 := 0 to High(ButtonData) do
    vCount := vCount + StoI(ButtonData[vIndex2, 4]);

  Inc(vCount);

  //한아이템당 최대 주문 수량체크
  if ( (StoI(ButtonData[vIndex, 5]) > 0) and (StoI(ButtonData[vIndex, 5]) < StoI(ButtonData[vIndex, 4])+1)) then
  begin
    Common.MsgBox(Format('%s 개까지 주문이 가능합니다', [ButtonData[vIndex, 5]]));
    Exit;
  end;

  if ( (MaxCount > 0) and (MaxCount < vCount) ) then
  begin
    Common.MsgBox(Format('전체 %d 개까지 주문이 가능합니다', [MaxCount]));
    if StoI(ButtonData[vIndex, 4]) = 0 then
    begin
      ButtonData[vIndex, 3] := 'N';
      ButtonData[vIndex, 4] := '0';
      Dec(SelectedCount);
    end;
    Exit;
  end;

  ButtonData[vIndex, 4] := IntToStr(StoI(ButtonData[vIndex, 4])+1);
  (Sender as TPosButton).BorderInnerColor := clRed;

  ItemCode  := EmptyStr;
  ItemPrice := 0;
  ItemName  := EmptyStr;
  SelectedItemEdit.Clear;

  For vIndex := 1 to High(Order_F.ItemData) do
  begin
    Order_F.ItemData[vIndex].Code  := '';
    Order_F.ItemData[vIndex].Name  := '';
    Order_F.ItemData[vIndex].Price := 0;
    Order_F.ItemData[vIndex].Qty   := 0;
    Order_F.ItemData[vIndex].PrintMenuName  := '';
  end;

  for vIndex := 0 to High(ButtonData) do
  begin
    if ButtonData[vIndex, 3] = 'N' then Continue;

    ItemCode  := ItemCode  + Format('%s,%s|',[ButtonData[vIndex, 0], ButtonData[vIndex, 4]]);

    ItemPrice := ItemPrice + (StrToInt(ButtonData[vIndex, 2]) * StrToInt(ButtonData[vIndex, 4]) );
    ItemName  := ItemName  + Format('%s(%s)+',[ButtonData[vIndex, 1], ButtonData[vIndex, 4]]);

    Order_F.ItemData[vIndex+1].Code  := ButtonData[vIndex, 0];
    Order_F.ItemData[vIndex+1].Name  := ButtonData[vIndex, 1];
    Order_F.ItemData[vIndex+1].Price := StrToInt(ButtonData[vIndex, 2]);
    Order_F.ItemData[vIndex+1].Qty   := StrToInt(ButtonData[vIndex, 4]);
    Order_F.ItemData[vIndex+1].PrintMenuName := ButtonData[vIndex, 6];
  end;

  if (ItemName <> '') then Delete(ItemName, Length(ItemName), 1);

  SelectedItemEdit.Text  := ItemName;

  SalePriceEdit.Value    := Common.Menu.pr_sale;
  ItemAmtEdit.Value      := ItemPrice;
  TotalAmtEdit.Value     := ItemPrice + Common.Menu.pr_sale;
end;


procedure TMenuItem_F.ConfirmButtonClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;


end.
