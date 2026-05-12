unit KioskItem_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxLabel, StdCtrls, AdvSmoothButton,
  DB, ExtCtrls, StrUtils, cxGroupBox, IniFiles, MMSystem, PNGImage,AdvSmoothToggleButton,
  AdvPanel;

type
  TItemInfo = record
    GroupBox     :TcxGroupBox;
    Item         :TcxLabel;
    Qty          :TcxLabel;
    AddButton    :TAdvSmoothToggleButton;
    CancelButton :TAdvSmoothToggleButton;
    Price        :TcxLabel;
  end;

type
  TKioskItem_F = class(TForm)
    MenuGroupBox: TcxGroupBox;
    CloseTimer: TTimer;
    OrderButton: TAdvSmoothButton;
    CancelButton: TAdvSmoothToggleButton;
    HeaderPanel: TAdvPanel;
    lblOrderAmt: TcxLabel;
    lblQty: TcxLabel;
    lblMenuName: TcxLabel;
    btnAdd: TAdvSmoothToggleButton;
    btnDec: TAdvSmoothToggleButton;
    MenuInfoLabel: TcxLabel;
    procedure FormShow(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDecClick(Sender: TObject);
    procedure OrderButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
  private
    SelectedCount: Integer;
    LimitCount :Integer;       //총주문가능 메뉴수량
    ItemMenu  : Array of TItemInfo;
    procedure SetDesign;
    procedure obtn_MenuAdd1Click(Sender: TObject);
    procedure obtn_MenuCancel1Click(Sender: TObject);
  public
    ItemCode  :String;
    ItemName  :String;
    ItemPrice :Integer;
    MenuPrice :Integer;
    MenuCode  :String;
  end;

var
  KioskItem_F: TKioskItem_F;

implementation
uses Common_U, Order_U, GlobalFunc_U, Const_U;
{$R *.dfm}
procedure TKioskItem_F.FormCreate(Sender: TObject);
var vIndex, vCount, vTop, vCollectionIndex :Integer;
begin
  if Common.Config.BarrierFreeMode = bfWheelChair then
  begin
    Self.Position := poDesigned;
    Self.Height   := Screen.Height - Common.Config.BarrierTop;
    Self.Top      := Common.Config.BarrierTop - 50;
  end;
  Common.SetButtonColor(OrderButton);

  Common.SetButtonColor(btnAdd,true);
  Common.SetButtonColor(btnDec,true);
  Common.SetKioskButton(CancelButton,'No');
  Common.SetKioskButton(OrderButton,'Yes');
  Common.SetKioskButton(lblMenuName);
  Common.SetKioskButton(MenuInfoLabel);

  HeaderPanel.Color         := $00FFC184;
  HeaderPanel.ColorMirror   := $00CC6600;
  HeaderPanel.ColorMirrorTo := $00F07800;
  HeaderPanel.ColorTo       := $00F07800;
  if GetOption(458) = '2' then
  begin
    HeaderPanel.Color         := $004C4C4C;
    HeaderPanel.ColorMirror   := $004C4C4C;
    HeaderPanel.ColorMirrorTo := $003B3B3B;
    HeaderPanel.ColorTo       := $003B3B3B;
  end
  else if GetOption(458) = '3' then
  begin
    HeaderPanel.Color         := $000000FB;
    HeaderPanel.ColorMirror   := $000000CC;
    HeaderPanel.ColorMirrorTo := $002222FF;
    HeaderPanel.ColorTo       := $002222FF;
  end
  else if GetOption(458) = '4' then
  begin
    HeaderPanel.Color         := $0059B300;
    HeaderPanel.ColorMirror   := $00448800;
    HeaderPanel.ColorMirrorTo := $00408000;
    HeaderPanel.ColorTo       := $00408000;
  end;

  vCollectionIndex := Common.GetInfoImageCollectionIndex(Common.Menu.cd_menu);
  if (RightStr(Common.Menu.menu_info,4) = '.jpg') and (vCollectionIndex >= 0) then
  begin
    HeaderPanel.Visible := false;
    with TImage.Create(Self) do
    begin
      Parent      := Self;
      Name        := 'MenuInfoImage';
      Left        := HeaderPanel.Left;
      Top         := HeaderPanel.Top;
      Width       := HeaderPanel.Width;
      Height      := HeaderPanel.Height;
      Picture.Assign(Common.MenuInfoImageCollection.Items.Items[vCollectionIndex].Picture.Graphic);
      Caption     := EmptyStr;
      SendToBack;
    end;
    btnDec.Parent      := TWinControl(TImage(FindComponent('MenuInfoImage')));
    lblQty.Parent      := TWinControl(TImage(FindComponent('MenuInfoImage')));
    btnAdd.Parent      := TWinControl(TImage(FindComponent('MenuInfoImage')));
    lblOrderAmt.Parent := TWinControl(TImage(FindComponent('MenuInfoImage')));
  end
  else
    MenuInfoLabel.Caption := Common.GetPapago(Common.Menu.menu_info);

  if GetOption(422) = '1' then
  begin
    btnAdd.Visible := false;
    lblQty.Visible := false;
    btnDec.Visible := false;
  end;
  Common.LogoCreate(Self,0);
end;

procedure TKioskItem_F.FormShow(Sender: TObject);
var vIndex :Integer;
begin
  if Common.KioskVoice and (Common.Config.BarrierFreeMode <> bfNone) then
    Common.TextToSpeech(Common.Menu.nm_menu+' 메뉴에 옵션을 선택하세요.')
  else
    Common.KioskTouchBeep('order');
  OrderButton.Caption   := Common.GetPapago('선택완료');
  CloseTimer.Tag := 0;
  CloseTimer.Enabled := true;
  OpenQuery('select NM_MENU_SHORT, '
           +'       QTY_SELECT '
           +'  from MS_MENU  '
           +' where CD_STORE = :P0 '
           +'   and CD_MENU  = :P1 ',
           [Common.Config.StoreCode,
            MenuCode]);

  lblMenuName.Caption  := Common.GetPaPago(Common.Query.Fields[0].AsString);
  OrderButton.Caption  := Common.GetPaPago('선택완료');
  CancelButton.Caption := Common.GetPaPago('처음으로');

  LimitCount          := Common.Query.Fields[1].AsInteger;
  Common.Query.Close;

  SelectedCount  := 0;
  ItemPrice      := 0;
  lblQty.Caption := '1';
  lblQty.Tag     := 1;
  lblOrderAmt.Caption := FormatFloat('￦ ,0',MenuPrice);
  for vIndex := 0 to High(ItemMenu) do
  begin
    ItemMenu[vIndex].GroupBox.Visible := false;
    ItemMenu[vIndex].Qty.Caption     := '0';
  end;

  OpenQuery('select b.CD_MENU, '
           +'       b.NM_MENU, '
           +'       b.NM_MENU_SHORT, '
           +'       case when b.DS_TAX = ''2'' then b.PR_SALE * 0.1 + b.PR_SALE else b.PR_SALE end as PR_SALE, '
           +'       b.QTY_SELECT '
           +'  from MS_MENU_ITEM a inner join '
           +'       MS_MENU      b on a.CD_STORE = b.CD_STORE and a.CD_ITEM = b.CD_MENU '
           +' where a.CD_STORE = :P0 '
           +'   and a.CD_MENU  = :P1 '
           +'   and b.YN_USE   = ''Y'' '
           +'   and b.DS_MENU_TYPE = ''I'' '
           +'   and SubString(b.CONFIG,8,1) = ''N'' '
           +Ifthen(Common.Table.Packing = 'Y', ' and SubString(b.CONFIG,10,1) <> ''Y'' ',' and SubString(b.CONFIG,10,1) <> ''S'' ')
           +' order by a.SEQ, a.CD_ITEM ',
           [Common.Config.StoreCode,
            MenuCode]);

  SetLength(ItemMenu, Common.Query.RecordCount);
  SetDesign;
  vIndex := 0;
  while not Common.Query.Eof do
  begin
    ItemMenu[vIndex].GroupBox.Visible := true;
    ItemMenu[vIndex].Item.Caption    := Common.GetPaPago(Common.Query.FieldByName('NM_MENU_SHORT').AsString);
    ItemMenu[vIndex].Item.Hint       := Common.Query.FieldByName('CD_MENU').AsString;
    ItemMenu[vIndex].Item.HelpKeyword  := Common.Query.FieldByName('NM_MENU_SHORT').AsString;
    ItemMenu[vIndex].Item.Tag        := Common.Query.FieldByName('QTY_SELECT').AsInteger;
    ItemMenu[vIndex].Price.Caption   := FormatFloat('￦ ,0', Common.Query.FieldByName('PR_SALE').AsCurrency);
    ItemMenu[vIndex].Price.Tag       := Common.Query.FieldByName('PR_SALE').AsInteger;
    ItemMenu[vIndex].Qty.Caption     := '0';
    Inc(vIndex);
    Common.Query.Next;
  end;
  Common.Query.Close;
end;

procedure TKioskItem_F.btnAddClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  lblQty.Tag     := lblQty.Tag + 1;
  lblQty.Caption := IntToStr(lblQty.Tag);
end;

procedure TKioskItem_F.btnDecClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  if lblQty.Tag = 1 then Exit;
  lblQty.Tag     := lblQty.Tag - 1;
  lblQty.Caption := IntToStr(lblQty.Tag);
end;

procedure TKioskItem_F.OrderButtonClick(Sender: TObject);
var vIndex, vIndex1 :Integer;
begin
  Common.KioskTouchBeep('kioskwave12');
  if not IsDebuggerPresent then
    BlockInput(true);
  try
    ItemCode := EmptyStr;
    ItemName := EmptyStr;
    vIndex1  := 1;
    for vIndex := 0 to High(ItemMenu) do
    begin
      if StrToIntDef(TcxLabel(FindComponent(Format('lbl_Qty%d',[vIndex]))).Caption,0) = 0 then Continue;

      ItemCode  := ItemCode  + Format('%s,%d|',[TcxLabel(FindComponent(Format('lbl_Item%d',[vIndex]))).Hint, 1]);
      ItemName  := ItemName  + Format('%s(%d)+',[TcxLabel(FindComponent(Format('lbl_Item%d',[vIndex]))).Caption, 1]);
      Order_F.ItemData[vIndex1].Code  := TcxLabel(FindComponent(Format('lbl_Item%d',[vIndex]))).Hint;
      Order_F.ItemData[vIndex1].Name  := TcxLabel(FindComponent(Format('lbl_Item%d',[vIndex]))).HelpKeyword;
      Order_F.ItemData[vIndex1].Price := TcxLabel(FindComponent(Format('lbl_Price%d',[vIndex]))).Tag;
      Order_F.ItemData[vIndex1].Qty   := 1;
      Inc(vIndex1);
    end;
    if (ItemName <> '') then Delete(ItemName, Length(ItemName), 1);
    if ItemCode = EmptyStr then
    begin
      if not Common.AskBox('아이템이 선택되지 않았습니다'+#13+'주문하시겠습니까?',5) then
        Exit;
    end;
    ModalResult := mrOK;
  finally
    BlockInput(false);
  end;
end;



procedure TKioskItem_F.obtn_MenuAdd1Click(Sender: TObject);
var vCount, vLimit :Integer;
begin
  Common.KioskTouchBeep('kioskwave11');
  BlockInput(true);
  try
    vCount := StrToInt(TcxLabel(FindComponent(Format('lbl_Qty%d',[(Sender as TAdvSmoothToggleButton).Tag]))).Caption);
    vLimit := TcxLabel(FindComponent(Format('lbl_Item%d',[(Sender as TAdvSmoothToggleButton).Tag]))).Tag;

    if (vLimit = vCount) and (vCount > 0) then
    begin
      Common.MsgBox(Format('%d 까지 선택이 가능합니다',[vLimit]));
      Exit;
    end;

    if (LimitCount = SelectedCount) and (LimitCount > 0) then
    begin
      Common.MsgBox(Format('전체 %d 까지 선택이 가능합니다',[LimitCount]));
      Exit;
    end;
    SelectedCount := SelectedCount + 1;
    TcxLabel(FindComponent(Format('lbl_Qty%d',[(Sender as TAdvSmoothToggleButton).Tag]))).Caption := IntToStr(vCount + 1);
    ItemPrice     := ItemPrice + TcxLabel(FindComponent(Format('lbl_Price%d',[(Sender as TAdvSmoothToggleButton).Tag]))).Tag;
    lblOrderAmt.Caption := FormatFloat('￦ ,0',MenuPrice+ItemPrice);
  finally
    BlockInput(false);
  end;
end;

procedure TKioskItem_F.obtn_MenuCancel1Click(Sender: TObject);
var vCount :Integer;
begin
  Common.KioskTouchBeep('kioskwave11');
  BlockInput(true);
  try
    vCount := StrToInt(TcxLabel(FindComponent(Format('lbl_Qty%d',[(Sender as TAdvSmoothToggleButton).Tag]))).Caption);

    if TcxLabel(FindComponent(Format('lbl_Qty%d',[(Sender as TAdvSmoothToggleButton).Tag]))).Caption = '0' then Exit;

    SelectedCount := SelectedCount - 1;
    ItemPrice     := ItemPrice - TcxLabel(FindComponent(Format('lbl_Price%d',[(Sender as TAdvSmoothToggleButton).Tag]))).Tag;
    lblOrderAmt.Caption := FormatFloat('￦ ,0',MenuPrice+ItemPrice);
    TcxLabel(FindComponent(Format('lbl_Qty%d',[(Sender as TAdvSmoothToggleButton).Tag]))).Caption := IntToStr(vCount - 1);
  finally
    BlockInput(false);
  end;
end;

procedure TKioskItem_F.SetDesign;
var vTop, vIndex, vHeight :Integer;
    vFontSize :Integer;
    vFontColor :TColor;
begin
  vTop       := 0;
  vFontSize  := 21;
  vFontColor := clBlack;
  if Self.Height > Order_F.KioskPanel.Height then
    Self.Height  := Order_F.KioskPanel.Height
  else if (High(ItemMenu) * 100) > 530  then
  begin
    if Screen.Height < Self.Height + ((High(ItemMenu) * 100) - 400) then
      Self.Height := Screen.Height
    else
      Self.Height := Self.Height + ((High(ItemMenu) * 100) - 400);
  end;

  vHeight := 60;
  for vIndex := 0 to High(ItemMenu) do
  begin
    //주문전체 그룹
    ItemMenu[vIndex].GroupBox := TcxGroupBox.Create(Self);
    ItemMenu[vIndex].GroupBox.Parent                 := MenuGroupBox;
    ItemMenu[vIndex].GroupBox.Style.BorderStyle      := ebsNone;
    ItemMenu[vIndex].GroupBox.Transparent            := true;
    ItemMenu[vIndex].GroupBox.Caption                := EmptyStr;
    ItemMenu[vIndex].GroupBox.PanelStyle.BorderWidth := 0;
    ItemMenu[vIndex].GroupBox.Width                  := MenuGroupBox.Width;
    ItemMenu[vIndex].GroupBox.Height                 := 100;
    ItemMenu[vIndex].GroupBox.Align                  := alNone;
    ItemMenu[vIndex].GroupBox.Visible                := false;
    ItemMenu[vIndex].GroupBox.Left                   := 0;
    ItemMenu[vIndex].GroupBox.Top                    := vTop;

    //아이템
    ItemMenu[vIndex].Item                  := TcxLabel.Create(Self);
    ItemMenu[vIndex].Item.Parent           := ItemMenu[vIndex].GroupBox;
    ItemMenu[vIndex].Item.Name             := Format('lbl_Item%d',[vIndex]);
    ItemMenu[vIndex].Item.AutoSize         := false;
    ItemMenu[vIndex].Item.Style.Font.Name  := Common.Config.KioskDefaultFontName;
    ItemMenu[vIndex].Item.Style.Font.Color := vFontColor;
    ItemMenu[vIndex].Item.Style.Font.Size  := vFontSize+10;
    ItemMenu[vIndex].Item.Transparent      := true;
    ItemMenu[vIndex].Item.Caption          := EmptyStr;
    ItemMenu[vIndex].Item.Top              := 0;
    ItemMenu[vIndex].Item.Left             := 0;
    ItemMenu[vIndex].Item.Height           := ItemMenu[vIndex].GroupBox.Height;
    ItemMenu[vIndex].Item.Width            := FtoI(MenuGroupBox.Width * 0.6);
    ItemMenu[vIndex].Item.Properties.Alignment.Vert := taVCenter;
    ItemMenu[vIndex].Item.Visible          := true;


    ItemMenu[vIndex].CancelButton := TAdvSmoothToggleButton.Create(Self);
    ItemMenu[vIndex].CancelButton.Parent           := ItemMenu[vIndex].GroupBox;
    ItemMenu[vIndex].CancelButton.Top              := 20;
    ItemMenu[vIndex].CancelButton.Left             := ItemMenu[vIndex].Item.Width + 5;
    ItemMenu[vIndex].CancelButton.Width            := vHeight;
    ItemMenu[vIndex].CancelButton.Height           := vHeight;
    ItemMenu[vIndex].CancelButton.BevelWidth       := -3;
    ItemMenu[vIndex].CancelButton.BorderColor      := clNone;
    ItemMenu[vIndex].CancelButton.BorderInnerColor := clNone;
    ItemMenu[vIndex].CancelButton.Caption          := '－';
    ItemMenu[vIndex].CancelButton.Color            := btnAdd.Color;
    ItemMenu[vIndex].CancelButton.Appearance.SimpleLayout := true;
    ItemMenu[vIndex].CancelButton.Appearance.ShiftDown    := 0;
    ItemMenu[vIndex].CancelButton.Appearance.Rounding := (vHeight) div 2;
    ItemMenu[vIndex].CancelButton.Appearance.Font.Name := Common.Config.KioskDefaultFontName;
    ItemMenu[vIndex].CancelButton.Appearance.Font.Size := vFontSize + 3;
    ItemMenu[vIndex].CancelButton.Appearance.Font.Color := clWhite;
    ItemMenu[vIndex].CancelButton.Appearance.Font.Style := [fsBold];
    ItemMenu[vIndex].CancelButton.Tag              := vIndex;
    ItemMenu[vIndex].CancelButton.OnClick          := obtn_MenuCancel1Click;
    ItemMenu[vIndex].CancelButton.AutoToggle       := false;
    ItemMenu[vIndex].CancelButton.ShowFocus        := false;
    ItemMenu[vIndex].CancelButton.TabStop := false;


    //수량
    ItemMenu[vIndex].Qty                           := TcxLabel.Create(Self);
    ItemMenu[vIndex].Qty.Parent                    := ItemMenu[vIndex].GroupBox;
    ItemMenu[vIndex].Qty.Name                      := Format('lbl_Qty%d',[vIndex]);
    ItemMenu[vIndex].Qty.AutoSize                  := false;
    ItemMenu[vIndex].Qty.Width                     := Trunc(MenuGroupBox.Width * 0.04);
    ItemMenu[vIndex].Qty.Height                    := ItemMenu[vIndex].GroupBox.Height;
    ItemMenu[vIndex].Qty.Style.Font.Name           := Common.Config.KioskDefaultFontName;
    ItemMenu[vIndex].Qty.Style.Font.Color          := vFontColor;
    ItemMenu[vIndex].Qty.Style.Font.Size           := vFontSize+5;
    ItemMenu[vIndex].Qty.Style.Font.Style          := [fsBold];
    ItemMenu[vIndex].Qty.Transparent               := true;
    ItemMenu[vIndex].Qty.Caption                   := EmptyStr;
    ItemMenu[vIndex].Qty.Top                       := 0;
    ItemMenu[vIndex].Qty.Left                      := ItemMenu[vIndex].Item.Width + ItemMenu[vIndex].GroupBox.Height-10;
    ItemMenu[vIndex].Qty.Properties.Alignment.Horz := taCenter;
    ItemMenu[vIndex].Qty.Properties.Alignment.Vert := taVCenter;
    ItemMenu[vIndex].Qty.Visible                   := true;

    ItemMenu[vIndex].AddButton := TAdvSmoothToggleButton.Create(Self);
    ItemMenu[vIndex].AddButton.Parent           := ItemMenu[vIndex].GroupBox;
    ItemMenu[vIndex].AddButton.Top              := 20;
    ItemMenu[vIndex].AddButton.Left             := ItemMenu[vIndex].Item.Width + 5 + ItemMenu[vIndex].GroupBox.Height + 5 + ItemMenu[vIndex].Qty.Width;
    ItemMenu[vIndex].AddButton.Width            := vHeight;
    ItemMenu[vIndex].AddButton.Height           := vHeight;
    ItemMenu[vIndex].AddButton.BevelWidth       := -3;
    ItemMenu[vIndex].AddButton.BorderColor      := clNone;
    ItemMenu[vIndex].AddButton.BorderInnerColor := clNone;
    ItemMenu[vIndex].AddButton.Caption          := '＋';
    ItemMenu[vIndex].AddButton.Color            := btnAdd.Color;
    ItemMenu[vIndex].AddButton.Appearance.SimpleLayout := true;
    ItemMenu[vIndex].AddButton.Appearance.ShiftDown    := 0;
    ItemMenu[vIndex].AddButton.Appearance.Rounding := (vHeight) div 2;
    ItemMenu[vIndex].AddButton.Appearance.Font.Name := Common.Config.KioskDefaultFontName;
    ItemMenu[vIndex].AddButton.Appearance.Font.Size := vFontSize + 3;
    ItemMenu[vIndex].AddButton.Appearance.Font.Color := clWhite;
    ItemMenu[vIndex].AddButton.Appearance.Font.Style := [fsBold];
    ItemMenu[vIndex].AddButton.Tag              := vIndex;
    ItemMenu[vIndex].AddButton.OnClick          := obtn_MenuAdd1Click;
    ItemMenu[vIndex].AddButton.AutoToggle       := false;
    ItemMenu[vIndex].AddButton.ShowFocus        := false;
    ItemMenu[vIndex].AddButton.TabStop := false;


    //아이템금액
    ItemMenu[vIndex].Price                  := TcxLabel.Create(Self);
    ItemMenu[vIndex].Price.Parent           := ItemMenu[vIndex].GroupBox;
    ItemMenu[vIndex].Price.Name             := Format('lbl_Price%d',[vIndex]);
    ItemMenu[vIndex].Price.AutoSize         := false;
    ItemMenu[vIndex].Price.Width            := FtoI(MenuGroupBox.Width * 0.17);
    ItemMenu[vIndex].Price.Height           := ItemMenu[vIndex].GroupBox.Height;
    ItemMenu[vIndex].Price.Style.Font.Name  := Common.Config.KioskDefaultFontName;
    ItemMenu[vIndex].Price.Style.Font.Color := vFontColor;
    ItemMenu[vIndex].Price.Style.Font.Size  := vFontSize+5;
    ItemMenu[vIndex].Price.Transparent      := true;
    ItemMenu[vIndex].Price.Caption          := EmptyStr;
    ItemMenu[vIndex].Price.Top              := 0;
    ItemMenu[vIndex].Price.Left             := ItemMenu[vIndex].AddButton.Left + ItemMenu[vIndex].AddButton.Width;
    ItemMenu[vIndex].Price.Properties.Alignment.Horz := taRightJustify;
    ItemMenu[vIndex].Price.Properties.Alignment.Vert := taVCenter;
    ItemMenu[vIndex].Price.Visible          := true;

    vTop := vTop + 80;
  end;
end;

procedure TKioskItem_F.CancelButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  Close;
end;

procedure TKioskItem_F.CloseTimerTimer(Sender: TObject);
begin
  CloseTimer.Tag := CloseTimer.Tag + 1;
  if CloseTimer.Tag > 60 then
  begin
    CloseTimer.Enabled := false;
    Close;
  end
  else
    CancelButton.Status.Caption := IntToStr(60-CloseTimer.Tag);
end;

end.
