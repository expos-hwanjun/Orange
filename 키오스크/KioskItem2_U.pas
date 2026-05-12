unit KioskItem2_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, DB, Math, IniFiles, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxLabel, PNGImage, Vcl.Menus, Vcl.StdCtrls, AdvSmoothButton,
  GDIPFill, cxButtons, cxImage, AdvSmoothToggleButton, AdvPanel, AdvBadge,
  StrUtils;

type
  TKioskButtonList = record
    GroupBox       :TAdvPanel;
    MenuImage      :TcxImage;
    MenuName       :String;     //번역전 메뉴명
    ViewMenuName   :String;     //번역후 메뉴명
    Price          :String;
    MenuCode       :String;
    MenuType       :String;
    isSoldOut      :Boolean;
    Badge          :TAdvBadgeLabel;
  end;

type
  TKioskItem2_F = class(TForm)
    CloseTimer: TTimer;
    OKButton: TAdvSmoothButton;
    CancelButton: TAdvSmoothToggleButton;
    HeaderPanel: TAdvPanel;
    lblTitle: TcxLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseTimerTimer(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    KioskButtonList : Array of TKioskButtonList;
    SelectedCount: Integer;
    LimitCount :Integer;       //총주문가능 메뉴수량
    procedure MenuButtonClick(Sender: TObject);
  public
    ButtonHeight,
    ButtonWidth :Integer;
    ItemCode  :String;
    ItemName  :String;
    ItemPrice :Integer;
    MenuPrice :Integer;
    MenuCode :String;
    ButtonFont :TFont;
    Badge          :TAdvBadgeLabel;
  end;

var
  KioskItem2_F: TKioskItem2_F;

implementation
uses Common_U, GlobalFunc_U, Order_U, Const_U;
{$R *.dfm}

procedure TKioskItem2_F.FormCreate(Sender: TObject);
var vWidth, vHeight, vGap :Integer;
begin
  Self.Width   := Order_F.KioskPanel.Width-50;
  if Common.Config.BarrierFreeMode = bfWheelChair then
  begin
    Self.Position := poDesigned;
    Self.Height   := Screen.Height - Common.Config.BarrierTop;
    Self.Top      := Common.Config.BarrierTop - 50;
  end
  else
    Self.Height  := Order_F.KioskPanel.Height;
  Common.LogoCreate(Self,0);

  HeaderPanel.Color         := $00FFC184;
  HeaderPanel.ColorMirror   := $00CC6600;
  HeaderPanel.ColorMirrorTo := $00F07800;
  HeaderPanel.ColorTo       := $00F07800;
  lblTitle.Style.TextColor    := clWhite;
  if GetOption(458) = '2' then
  begin
    HeaderPanel.Color         := $004C4C4C;
    HeaderPanel.ColorMirror   := $004C4C4C;
    HeaderPanel.ColorMirrorTo := $003B3B3B;
    HeaderPanel.ColorTo       := $003B3B3B;
    lblTitle.Style.TextColor    := clWhite;
  end
  else if GetOption(458) = '3' then
  begin
    HeaderPanel.Color         := $000000FB;
    HeaderPanel.ColorMirror   := $000000CC;
    HeaderPanel.ColorMirrorTo := $002222FF;
    HeaderPanel.ColorTo       := $002222FF;
    lblTitle.Style.TextColor    := clWhite;
  end
  else if GetOption(458) = '4' then
  begin
    HeaderPanel.Color         := $0059B300;
    HeaderPanel.ColorMirror   := $00448800;
    HeaderPanel.ColorMirrorTo := $00408000;
    HeaderPanel.ColorTo       := $00408000;
    lblTitle.Style.TextColor    := clWhite;
  end;

  Common.SetButtonColor(OkButton);

  Common.SetKioskButton(lblTitle);
  Common.SetKioskButton(CancelButton,'No');
  Common.SetKioskButton(OKButton,'Yes');

  ButtonFont := TFont.Create;

  vGap  := (Self.Width - OkButton.Width * 2) div 3;
  CancelButton.Left      := vGap;
  OkButton.Left := CancelButton.Left + CancelButton.Width + vGap;
end;

procedure TKioskItem2_F.OKButtonClick(Sender: TObject);
var vIndex, vIndex1 :Integer;
begin
  BlockInput(true);
  Common.KioskTouchBeep('kioskwave12');
  Common.WriteLog('work', 'Kiosk-Item2-주문완료');
  try
    if SelectedCount = 0 then
    begin
      if not Common.AskBox('아이템이 선택되지 않았습니다'+#13+'주문하시겠습니까?',5) then
        Exit;
    end;

    ItemCode  := EmptyStr;
    ItemName  := EmptyStr;
    ItemPrice := 0;
    vIndex1   := 1;
    for vIndex:= 0 to High(KioskButtonList) do
    begin
      if KioskButtonList[vIndex].Badge.Badge <> '선택' then Continue;

      ItemCode  := ItemCode  + Format('%s,%d|',[KioskButtonList[vIndex].MenuCode, 1]);
      ItemName  := ItemName  + Format('%s(%d)+',[KioskButtonList[vIndex].MenuName, 1]);
      ItemPrice := ItemPrice + StrToInt(GetOnlyNumber(KioskButtonList[vIndex].Price));
      Order_F.ItemData[vIndex1].Code  := KioskButtonList[vIndex].MenuCode;
      Order_F.ItemData[vIndex1].Name  := KioskButtonList[vIndex].MenuName;
      Order_F.ItemData[vIndex1].Price := StrToInt(GetOnlyNumber(KioskButtonList[vIndex].Price));
      Order_F.ItemData[vIndex1].Qty   := 1;
      Inc(vIndex1);
    end;
    if (ItemName <> '') then Delete(ItemName, Length(ItemName), 1);
    ModalResult := mrOK;
  finally
    BlockInput(false);
  end;
end;

procedure TKioskItem2_F.FormShow(Sender: TObject);
var vIndex, vRow, vCol, vGap, vLeft2 :Integer;
    vStream    :TStream;
    vBottomMagin,
    vButtonCount,
    vButtonHorCount,
    vBottonVerCount :Integer;
    vLeft      :Integer;
    vFontSize  :Integer;
    vMenuName,
    vMenuPrice  :String;
    vColor      :String;
    vMenuAling,
    vPriceAlign :String;
    vCollectionIndex :Integer;
    vMenuImage  :TPNGImage;
begin
  try
    CloseTimer.Tag     := 0;
    CloseTimer.Enabled := true;
    OpenQuery('select QTY_SELECT '
             +'  from MS_MENU  '
             +' where CD_STORE = :P0 '
             +'   and CD_MENU  = :P1 ',
             [Common.Config.StoreCode,
              MenuCode]);

    LimitCount          := Common.Query.Fields[0].AsInteger;
    Common.Query.Close;
    if LimitCount > 0 then
      lblTitle.Caption := Common.GetPaPago(Format('%d 개 선택이 가능합니다', [LimitCount]))
    else
      lblTitle.Caption := Common.GetPaPago('원하는 아이템을 선택하세요');

    OKButton.Caption := Common.GetPapago('주문완료');
    CancelButton.Caption := Common.GetPapago('처음으로');

    SelectedCount  := 0;
    if vFontSize = 0 then
      vFontSize := ButtonFont.Size;

    OpenQuery('select Count(*) '
             +'  from MS_MENU_ITEM   a inner join '
             +'       MS_MENU        b on a.CD_STORE = b.CD_STORE and a.CD_ITEM = b.CD_MENU '
             +' where a.CD_STORE = :P0 '
             +'   and a.CD_MENU  = :P1 '
             +'   and b.YN_USE   = ''Y'' '
             +'   and b.DS_MENU_TYPE = ''I'' '
             +'   and SubString(b.CONFIG,8,1) = ''N'' '
             +Ifthen(Common.Table.Packing = 'Y', ' and SubString(b.CONFIG,10,1) <> ''Y'' ',' and SubString(b.CONFIG,10,1) <> ''S'' '),
             [Common.Config.StoreCode,
              MenuCode]);
    vButtonCount := Common.Query.Fields[0].AsInteger;
    Common.Query.Close;

    vButtonHorCount := Self.Width div (ButtonWidth + 10);
    vBottonVerCount := (vButtonCount div vButtonHorCount) + ifthen(vButtonCount mod vButtonHorCount > 0, 1, 0);
    Self.Height     := (vBottonVerCount * ButtonHeight) + (vBottonVerCount * 20) + 250;
    Self.Top        := Trunc(Screen.Height / 2 - Self.Height / 2);

    Self.Height     := Self.Height + OKButton.Height + 20;

    SetLength(KioskButtonList, vButtonCount);

    for vIndex := 0 to High(KioskButtonList) do
    begin
      KioskButtonList[vIndex].GroupBox := TAdvPanel.Create(Self);
      KioskButtonList[vIndex].GroupBox.Parent            := Self;
      KioskButtonList[vIndex].GroupBox.Align             := alNone;
      KioskButtonList[vIndex].GroupBox.BevelOuter        := bvNone;
      KioskButtonList[vIndex].GroupBox.Color             := clWhite;
      KioskButtonList[vIndex].GroupBox.BorderColor       := $00393939;
      KioskButtonList[vIndex].GroupBox.TextVAlign        := tvaBottom;
      KioskButtonList[vIndex].GroupBox.BorderWidth       := 0;

      KioskButtonList[vIndex].GroupBox.Width             := ButtonWidth;
      KioskButtonList[vIndex].GroupBox.Height            := ButtonHeight;
      KioskButtonList[vIndex].GroupBox.Visible           := true;
      KioskButtonList[vIndex].GroupBox.Top               := 150;
      KioskButtonList[vIndex].GroupBox.Left              := 0;
      KioskButtonList[vIndex].GroupBox.Name              := Format('obtn_KioskItem%d',[vIndex]);
      KioskButtonList[vIndex].GroupBox.Visible           := true;
      KioskButtonList[vIndex].GroupBox.OnClick           := MenuButtonClick;
      KioskButtonList[vIndex].MenuCode := '';
      KioskButtonList[vIndex].GroupBox.Tag               := vIndex;

      KioskButtonList[vIndex].MenuImage                   := TcxImage.Create(Self);
      KioskButtonList[vIndex].MenuImage.Parent           := KioskButtonList[vIndex].GroupBox;
      KioskButtonList[vIndex].MenuImage.Top              := 0;
      KioskButtonList[vIndex].MenuImage.Left             := 0;
      KioskButtonList[vIndex].MenuImage.Width            := ButtonWidth-2;
      KioskButtonList[vIndex].MenuImage.Height           := ButtonHeight - Common.KioskConfig[8];
      if Common.KioskConfig[6] = 0 then
        KioskButtonList[vIndex].MenuImage.Style.BorderStyle := ebsNone;
      KioskButtonList[vIndex].MenuImage.Properties.FitMode := ifmStretch;
      KioskButtonList[vIndex].MenuImage.Properties.GraphicClassName := 'TdxPNGImage';
      KioskButtonList[vIndex].MenuImage.Visible          := true;
      KioskButtonList[vIndex].MenuImage.Transparent      := true;
      KioskButtonList[vIndex].MenuImage.Tag              := vIndex;
      KioskButtonList[vIndex].MenuImage.OnClick          := MenuButtonClick;
      KioskButtonList[vIndex].MenuImage.Properties.PopupMenuLayout.MenuItems := [];
      KioskButtonList[vIndex].MenuImage.Properties.ShowFocusRect := false;

      KioskButtonList[vIndex].Badge                   := TAdvBadgeLabel.Create(Self);
      KioskButtonList[vIndex].Badge.Parent            := KioskButtonList[vIndex].GroupBox;
      KioskButtonList[vIndex].Badge.Top   := 15;
      KioskButtonList[vIndex].Badge.Left  := ButtonWidth -30;
      KioskButtonList[vIndex].Badge.Caption := '';
      KioskButtonList[vIndex].Badge.Visible := false;
      KioskButtonList[vIndex].Badge.BringToFront;
    end;

    OpenQuery('select b.CD_MENU, '
             +'       b.NM_MENU, '
             +'       b.NM_MENU_SHORT, '
             +'       case when b.DS_TAX = ''2'' then b.PR_SALE * 0.1 + b.PR_SALE else b.PR_SALE end as PR_SALE, '
             +'       b.QTY_SELECT '  //선택 후 뺄수가 없어서 기능을 사용하지 않음
             +'  from MS_MENU_ITEM a inner join '
             +'       MS_MENU      b on a.CD_STORE = b.CD_STORE and a.CD_ITEM = b.CD_MENU '//left outer join '
             +' where a.CD_STORE = :P0 '
             +'   and a.CD_MENU  = :P1 '
             +'   and b.YN_USE   = ''Y'' '
             +'   and b.DS_MENU_TYPE = ''I'' '
             +'   and SubString(b.CONFIG,8,1) = ''N'' '
             +Ifthen(Common.Table.Packing = 'Y', ' and SubString(b.CONFIG,10,1) <> ''Y'' ',' and SubString(b.CONFIG,10,1) <> ''S'' ')
             +'order by a.SEQ, a.CD_ITEM ',
             [Common.Config.StoreCode,
              MenuCode]);
    vIndex := 0;
    while not Common.Query.Eof do
    begin
      vMenuName  := Common.Query.FieldByName('NM_MENU_SHORT').AsString;
      vMenuPrice := FormatFloat('￦#,0', Common.Query.FieldByName('PR_SALE').AsCurrency);

      case Common.KioskConfig[11] of
        0 : vMenuAling := 'left';
        1 : vMenuAling := 'center';
        2 : vMenuAling := 'right';
      end;

      case Common.KioskConfig[12] of
        0 : vPriceAlign := 'left';
        1 : vPriceAlign := 'center';
        2 : vPriceAlign := 'right';
      end;


      KioskButtonList[vIndex].MenuCode         := Common.Query.FieldByName('CD_MENU').AsString;
      if Common.KioskConfig[9] = 1 then
      begin
        KioskButtonList[vIndex].GroupBox.Text := Format('<FONT  size="%d" color="%s" face="%s"><P align="%s"></P>%s<BR><P   align="%s"><B>%s</B></P></FONT>',
                                                        [Order_F.KioskPLUMenuPanel.Font.Size,
                                                         ColorToString(Order_F.KioskPLUMenuPanel.Font.Color),
                                                         Order_F.KioskPLUMenuPanel.Font.Name,
                                                         vMenuAling,
                                                         Common.GetPapago(vMenuName),
                                                         vPriceAlign,
                                                         vMenuPrice]);
      end
      else
      begin
        KioskButtonList[vIndex].GroupBox.Text := Format('<FONT  size="%d" color="%s" face="%s"><P   align="%s">%s</P></FONT>',
                                                        [Order_F.KioskPLUMenuPanel.Font.Size,
                                                         ColorToString(Order_F.KioskPLUMenuPanel.Font.Color),
                                                         Order_F.KioskPLUMenuPanel.Font.Name,
                                                         vPriceAlign,
                                                         vMenuPrice]);
      end;


      KioskButtonList[vIndex].ViewMenuName := Common.GetPapago(vMenuName);
      KioskButtonList[vIndex].MenuName     := vMenuName;;
      KioskButtonList[vIndex].Price        := vMenuPrice;
      vCollectionIndex := Common.GetImageCollectionIndex(Common.Query.FieldByName('CD_MENU').AsString);
      if vCollectionIndex >= 0 then
        KioskButtonList[vIndex].MenuImage.Picture.Assign(Common.MenuImageCollection.Items.Items[vCollectionIndex].Picture.Graphic)
      else
        KioskButtonList[vIndex].MenuImage.Picture.Assign(Order_F.ImageCollection.Items.Items[8].Picture.Graphic);

//      if Common.Query.FieldByName('IMG_MENU').AsString <> '' then
//      begin
//
//        vStream := Common.Query.CreateBLOBStream(Common.Query.FieldByName('IMG_MENU'), bmRead);
//        try
//         vMenuImage   := TPNGImage.Create;
//         vMenuImage.LoadFromStream(vStream);
//          KioskButtonList[vIndex].MenuImage.Picture.Assign(vMenuImage);
//        finally
//          vStream.Free;
//          vMenuImage.Free;
//        end;
//      end
//      else
//      begin
//        KioskButtonList[vIndex].MenuImage.Picture.Assign(Order_F.ImageCollection.Items.Items[8].Picture.Graphic);;
//      end;
      Inc(vIndex);
      Common.Query.Next;
    end;
    Common.Query.Close;

    if vButtonCount = 1 then
      KioskButtonList[0].GroupBox.Left := (Self.Width  - ButtonWidth ) div 2
    //한줄일때는 가운데정렬
    else if vButtonCount <= vButtonHorCount then
    begin
      vLeft := (Self.Width div vButtonCount) - ButtonWidth;
      KioskButtonList[0].GroupBox.Left := vLeft - 5;
      for vIndex := 1 to vButtonCount-1 do
        KioskButtonList[vIndex].GroupBox.Left := KioskButtonList[vIndex-1].GroupBox.Left + ButtonWidth + 5
    end
    else
    begin
      vLeft  := (Self.Width div vButtonHorCount) - ButtonWidth;
      vGap   :=  (Self.Width  - (ButtonWidth * vButtonHorCount) - vLeft) div vButtonHorCount -15;
      vIndex := 0;
      for vCol := 1 to vBottonVerCount do
        for vRow := 1 to vButtonHorCount do
        begin
          if vIndex = vButtonCount then
            Break;

          KioskButtonList[vIndex].GroupBox.Top  := (vCol-1) * ButtonHeight + 130 + ((vCol-1) * 15);
          //1 열일때
          if vButtonHorCount = 1 then
           KioskButtonList[vIndex].GroupBox.Left := (Self.Width  - ButtonWidth ) div 2
          else
            KioskButtonList[vIndex].GroupBox.Left :=  (vRow-1) * ButtonWidth + vLeft + ((vRow-1) * vGap) ;
          Inc(vIndex);
        end;
    end;
  except
    on E: Exception do
      Common.WriteLog('KioskItem',E.Message);
  end;
end;

procedure TKioskItem2_F.MenuButtonClick(Sender: TObject);
var vIndex, vIndex1, vIndex2 :Integer;
begin
  Common.KioskTouchBeep('kioskwave12');
  BlockInput(true);
  try
    if (Sender is TcxImage) then
      vIndex2 := (Sender as TcxImage).Tag
    else if (Sender is TcxLabel) then
      vIndex2 := (Sender as TcxLabel).Tag
    else if (Sender is TAdvPanel) then
      vIndex2 := (Sender as TAdvPanel).Tag
    else Exit;

    if KioskButtonList[vIndex2].Badge.Badge = '' then
    begin
      KioskButtonList[vIndex2].Badge.Visible := true;
      KioskButtonList[vIndex2].Badge.Badge   := '선택';

      SelectedCount := SelectedCount + 1;
      if LimitCount = SelectedCount then
      begin
        ItemCode  := EmptyStr;
        ItemName  := EmptyStr;
        ItemPrice := 0;
        vIndex1  := 1;
        for vIndex:= 0 to High(KioskButtonList) do
        begin
          if KioskButtonList[vIndex].Badge.Badge <> '선택' then Continue;

          ItemCode  := ItemCode  + Format('%s,%d|',[KioskButtonList[vIndex].MenuCode, 1]);
          ItemName  := ItemName  + Format('%s(%d)+',[KioskButtonList[vIndex].MenuName, 1]);
          ItemPrice := ItemPrice + StrToInt(GetOnlyNumber(KioskButtonList[vIndex].Price));
          Order_F.ItemData[vIndex1].Code  := KioskButtonList[vIndex].MenuCode;
          Order_F.ItemData[vIndex1].Name  := KioskButtonList[vIndex].ViewMenuName;
          Order_F.ItemData[vIndex1].Price :=  StrToInt(GetOnlyNumber(KioskButtonList[vIndex].Price));
          Order_F.ItemData[vIndex1].Qty   := 1;
          Inc(vIndex1);
        end;
        if (ItemName <> '') then Delete(ItemName, Length(ItemName), 1);
        ModalResult := mrOK;
      end;
    end
    else
    begin
      SelectedCount := SelectedCount - 1;
      KioskButtonList[vIndex2].Badge.Badge := '';
      KioskButtonList[vIndex2].Badge.Visible := false;
    end;
  finally
    BlockInput(false);
  end;
end;

procedure TKioskItem2_F.FormActivate(Sender: TObject);
begin
  if Common.KioskVoice then
    Common.TextToSpeech(Common.Menu.nm_menu+' 메뉴에 옵션을 선택하세요.')
  else
    Common.KioskTouchBeep('order');
end;

procedure TKioskItem2_F.FormClose(Sender: TObject;
  var Action: TCloseAction);
var vIndex :Integer;
begin
  for vIndex:= 0 to High(KioskButtonList) do
    KioskButtonList[vIndex].GroupBox.Free;
  CloseTimer.Enabled := false;
end;

procedure TKioskItem2_F.CancelButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  Close;
end;

procedure TKioskItem2_F.CloseTimerTimer(Sender: TObject);
begin
  CloseTimer.Tag := CloseTimer.Tag + 1;
  if CloseTimer.Tag > 60 then
  begin
    CloseTimer.Enabled := false;
    CloseTimer.Tag     := 0;
    Close;
  end
  else
    CancelButton.Status.Caption := IntToStr(60-CloseTimer.Tag);
end;

end.
