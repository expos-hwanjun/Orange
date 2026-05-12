unit KioskCourse_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, StdCtrls, Math, Common_U,
  IniFiles, PNGImage, StrUtils, cxLabel, cxGroupBox,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxRadioGroup, cxCheckGroup, AdvSmoothToggleButton, Vcl.Menus,
  cxButtons, AdvSmoothButton, AdvPanel, cxImage, AdvBadge, dxRatingControl,
  dxGDIPlusClasses, cxClasses, DateUtils;

type
  TKioskButtonList = record
    GroupBox       :TAdvPanel;
    MenuImage      :TcxImage;
    MenuName       :String;
    MenuCode       :String;
    MenuType       :String;
    isSoldOut      :Boolean;
    KitchenCode    :String;
    KitchenCode2   :String;
    isDefault      :Boolean;
    MenuPrice      :Integer;
    Badge          :TAdvBadgeLabel;
    PrintMenuName   :String;
  end;

type
  TKioskCourse_F = class(TForm)
    AutoCloseTimer: TTimer;
    CloseTimer: TTimer;
    NextButton: TAdvSmoothButton;
    CancelButton: TAdvSmoothToggleButton;
    CourseControl: TdxRatingControl;
    ImageCollection: TcxImageCollection;
    ImageCollectionItem1: TcxImageCollectionItem;
    ImageCollectionItem2: TcxImageCollectionItem;
    ImageCollectionItem3: TcxImageCollectionItem;
    ImageCollectionItem4: TcxImageCollectionItem;
    ImageCollectionItem5: TcxImageCollectionItem;
    ImageCollectionItem6: TcxImageCollectionItem;
    ImageCollectionItem7: TcxImageCollectionItem;
    ImageCollectionItem8: TcxImageCollectionItem;
    HeaderPanel: TAdvPanel;
    TitleLabel: TcxLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AutoCloseTimerTimer(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
    procedure NextButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    KioskButtonList : Array of TKioskButtonList;
    OrderCourseMenu  :Array of ^TCourseOrderMenu;    //선택한 메뉴저장
    isLoading :Boolean;
    ClickTime :TDateTime;
    OrgBttonHeight :Integer;
    FontSize :Integer;
    procedure MenuButtonClick(Sender: TObject);
  public
    CourseMenuCode,
    CourseStep,
    ButtonHeight,
    ButtonWidth :Integer;

    PossibleCount,
    SelectCount :Integer;
    CouresName :String;
    ButtonFont :TFont;
    ChooseType,
    SelectedMenu :String;
    TotalCourseCount,
    NowCourseIndex :Integer;
  end;

var
  KioskCourse_F: TKioskCourse_F;

implementation
uses GlobalFunc_U, Order_U, Const_U;
{$R *.dfm}

procedure TKioskCourse_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,0);
  ClickTime                   := IncSecond(Now,-3);
  Common.SetButtonColor(NextButton);

  Common.SetKioskButton(TitleLabel);
  Common.SetKioskButton(CancelButton,'No');
  Common.SetKioskButton(NextButton,'Yes');

  Self.Width   := Order_F.KioskPanel.Width-40;

  if Order_F.CourseMenuCount = 1 then
  begin
    Self.Tag          := Self.ClientHeight;
    Self.ClientHeight := 0;
    Exit;
  end
  else if Common.Config.BarrierFreeMode = bfWheelChair then
  begin
    Self.Position := poDesigned;
    Self.Height   := Screen.Height - Common.Config.BarrierTop;
    Self.Top      := Common.Config.BarrierTop - 50;
  end;

  HeaderPanel.Color         := $00FFC184;
  HeaderPanel.ColorMirror   := $00CC6600;
  HeaderPanel.ColorMirrorTo := $00F07800;
  HeaderPanel.ColorTo       := $00F07800;
  TitleLabel.Style.TextColor    := clWhite;

  if GetOption(458) = '1' then  //blue
  begin
    CourseControl.Properties.Glyph.Assign(ImageCollection.Items[3].Picture.Graphic);
    CourseControl.Properties.CheckedGlyph.Assign(ImageCollection.Items[2].Picture.Graphic);
  end
  else if GetOption(458) = '2' then  //Black
  begin
    HeaderPanel.Color         := $004C4C4C;
    HeaderPanel.ColorMirror   := $004C4C4C;
    HeaderPanel.ColorMirrorTo := $003B3B3B;
    HeaderPanel.ColorTo       := $003B3B3B;
    TitleLabel.Style.TextColor    := clWhite;
    CourseControl.Properties.Glyph.Assign(ImageCollection.Items[5].Picture.Graphic);
    CourseControl.Properties.CheckedGlyph.Assign(ImageCollection.Items[4].Picture.Graphic);
  end
  else if GetOption(458) = '3' then  //Red
  begin
    HeaderPanel.Color         := $000000FB;
    HeaderPanel.ColorMirror   := $000000CC;
    HeaderPanel.ColorMirrorTo := $002222FF;
    HeaderPanel.ColorTo       := $002222FF;
    TitleLabel.Style.TextColor    := clWhite;
    CourseControl.Properties.Glyph.Assign(ImageCollection.Items[1].Picture.Graphic);
    CourseControl.Properties.CheckedGlyph.Assign(ImageCollection.Items[0].Picture.Graphic);
  end
  else if GetOption(458) = '4' then  //Red
  begin
    HeaderPanel.Color         := $0059B300;
    HeaderPanel.ColorMirror   := $00448800;
    HeaderPanel.ColorMirrorTo := $00408000;
    HeaderPanel.ColorTo       := $00408000;
    TitleLabel.Style.TextColor    := clWhite;
    CourseControl.Properties.Glyph.Assign(ImageCollection.Items[7].Picture.Graphic);
    CourseControl.Properties.CheckedGlyph.Assign(ImageCollection.Items[6].Picture.Graphic);
  end;

  NextButton.Caption   := Common.GetPaPago('선택안함');
  CancelButton.Caption := Common.GetPaPago('처음으로');
end;

procedure TKioskCourse_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    NextButton.Click
  else if Key = VK_ESCAPE then
    CancelButton.Click;
end;

procedure TKioskCourse_F.FormShow(Sender: TObject);
var vIndex, vIndex1, vRow, vCol, vTop :Integer;
    vStream    :TStream;
    vButtonCount,
    vButtonHorCount,
    vBottonVerCount :Integer;
    vLeft, vGap, vWidth, vHeight     :Integer;
    vMenuName,
    vMenuPrice   :String;
    vBottomMagin :Integer;
    vColor       :String;
    vRadioItem   :TcxRadioGroupItem;
    vMenuAling,
    vPriceAlign :String;
    vCollectionIndex :Integer;
    vMenuImage  :TPNGImage;
begin
  OrgBttonHeight := ButtonHeight;
  with TIniFile.Create(Common.AppPath+'Kiosk\KioskConfig.ini') do
  try
    ButtonWidth      := ReadInteger('Course', 'ImageWidth',   ButtonWidth);
    ButtonHeight     := ReadInteger('Course', 'ImageHeight',  ButtonHeight);
    FontSize         := ReadInteger('Course', 'ImageFontSize',ButtonFont.Size);
    WriteInteger('Course', 'ImageWidth', ButtonWidth);
    WriteInteger('Course', 'ImageHeight', ButtonHeight);
    WriteInteger('Course', 'ImageFontSize', FontSize);
  finally
    Free
  end;

  CloseTimer.Tag := 0;

  CourseControl.Properties.ItemCount := TotalCourseCount;
  CourseControl.Rating               := NowCourseIndex;

  SetLength(OrderCourseMenu, PossibleCount);
  for vIndex := 0 to High(OrderCourseMenu) do
  begin
    New(OrderCourseMenu[vIndex]);
    OrderCourseMenu[vIndex]^.Step       := CourseStep;
    OrderCourseMenu[vIndex]^.MenuCode   := EmptyStr;
    OrderCourseMenu[vIndex]^.OrderQty   := 0;
    OrderCourseMenu[vIndex]^.OrderPrice := 0;
  end;

  if ChooseType = 'C' then
  begin
    NextButton.Caption := Common.GetPaPago('선택안함');
    vGap  := (Self.Width - NextButton.Width * 2) div 3;
    CancelButton.Left      := vGap;
    NextButton.Left := CancelButton.Left + CancelButton.Width + vGap;
  end
  else
  begin
    NextButton.Visible := false;
    NextButton.Width   := 0;
    NextButton.Height  := 0;
    CancelButton.Left := Self.Width div 2 - (CancelButton.Width div 2);
  end;

  if Order_F.CourseMenuCount = 0 then
  begin
    TitleLabel.Caption := Common.GetPaPago(Format('[ %s ] %d 개 선택이 가능합니다',[CouresName, PossibleCount]));

    OpenQuery('select Count(*) '
             +'  from MS_COURSE t1 inner join '
             +'       MS_MENU   t2 on t1.CD_STORE	=t2.CD_STORE and t1.CD_MENU_COURSE =t2.CD_MENU inner join '
             +'       MS_MENU   t3 on t1.CD_STORE	=t3.CD_STORE and t1.CD_MENU	  =t3.CD_MENU '
             +' where t1.CD_STORE	=:P0 '
             +'   and t1.CD_MENU  	=:P1 '
             +'   and t1.COURSE_SEQ =:P2 '
             +'   and Substring(t2.CONFIG,8,1) <> ''Y'' '
             +Ifthen(Common.Table.Packing = 'Y', ' and SubString(t2.CONFIG,10,1) <> ''Y'' ',' and SubString(t2.CONFIG,10,1) <> ''S'' ')
              +'   and t2.YN_USE = ''Y'' ',
             [Common.Config.StoreCode,
              Common.Menu.cd_menu,
              CourseStep]);
    vButtonCount := Common.Query.Fields[0].AsInteger;
    Common.Query.Close;
    if Common.KioskConfig[3] <= vButtonCount then
      Self.Width   := Order_F.KioskPanel.Width-40
    else if vButtonCount = (Common.KioskConfig[3]-1) then
      Self.Width   := Order_F.KioskPLUMenuPanel.Width-ButtonWidth - 40
    else if vButtonCount = (Common.KioskConfig[3]-2) then
      Self.Width   := Order_F.KioskPLUMenuPanel.Width-(ButtonWidth*2) - 40
    else if vButtonCount = (Common.KioskConfig[3]-3) then
      Self.Width   := Order_F.KioskPLUMenuPanel.Width-(ButtonWidth*3) - 40
    else if vButtonCount = (Common.KioskConfig[3]-4) then
      Self.Width   := Order_F.KioskPLUMenuPanel.Width-(ButtonWidth*4) - 40
    else
      Self.Width   := 800;

    if Self.Width < 800 then
      Self.Width := 800;

    if ChooseType = 'C' then
    begin
      NextButton.Caption := Common.GetPaPago('선택안함');
      vGap  := (Self.Width - NextButton.Width * 2) div 3;
      CancelButton.Left      := vGap;
      NextButton.Left := CancelButton.Left + CancelButton.Width + vGap;
    end
    else
    begin
      NextButton.Visible := false;
      NextButton.Width   := 0;
      NextButton.Height  := 0;
      CancelButton.Left := Self.Width div 2 - (CancelButton.Width div 2);
    end;

    vButtonHorCount := Self.Width div (ButtonWidth + 10);
    vBottonVerCount := (vButtonCount div vButtonHorCount) + ifthen(vButtonCount mod vButtonHorCount > 0, 1, 0);


    Self.Height     := (vBottonVerCount * ButtonHeight) + (vBottonVerCount * 20) + 350;
    Self.Top        := Trunc(Screen.Height / 2 - Self.Height / 2);
    SetLength(KioskButtonList, vButtonCount);
  end
  else
    SetLength(KioskButtonList, 1);

  vHeight := 0;
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
    KioskButtonList[vIndex].GroupBox.Height            := Ifthen((GetOption(23)='0') and (Common.KioskConfig[9] = 0), ButtonHeight + Common.KioskConfig[8], ButtonHeight);
    KioskButtonList[vIndex].GroupBox.Visible           := true;
    KioskButtonList[vIndex].GroupBox.Top               := 180;
    KioskButtonList[vIndex].GroupBox.Left              := 0;
    KioskButtonList[vIndex].GroupBox.Name              := Format('obtn_KioskItem%d',[vIndex]);
    KioskButtonList[vIndex].GroupBox.Visible           := true;
    KioskButtonList[vIndex].GroupBox.OnClick           := MenuButtonClick;
    KioskButtonList[vIndex].MenuCode := '';
    KioskButtonList[vIndex].GroupBox.Tag               := vIndex;

    KioskButtonList[vIndex].MenuImage                  := TcxImage.Create(Self);
    KioskButtonList[vIndex].MenuImage.Parent           := KioskButtonList[vIndex].GroupBox;
    KioskButtonList[vIndex].MenuImage.Top              := 0;
    KioskButtonList[vIndex].MenuImage.Left             := 0;
    KioskButtonList[vIndex].MenuImage.Width            := ButtonWidth-2;
    if OrgBttonHeight = ButtonHeight then
      KioskButtonList[vIndex].MenuImage.Height           := ButtonHeight - Common.KioskConfig[8]
    else
      KioskButtonList[vIndex].MenuImage.Height           := ButtonHeight - Trunc((ButtonHeight / OrgBttonHeight) * Common.KioskConfig[8]);

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


  OpenQuery('select t1.CD_MENU_COURSE as CD_MENU, '
           +'       t1.NM_COURSE, '
           +'       t2.CD_PRINTER, '
           +'       t3.CD_PRINTER as CD_PRINTER1,'
           +'       t1.YN_DEFAULT, '
           +'       t2.NM_MENU_SHORT, '
           +'       t2.CONFIG, '
           +'       t2.PR_SALE, '
           +'       t2.NM_MENU_KITCHEN '
           +'  from MS_COURSE     t1 inner join '
           +'       MS_MENU       t2 on t1.CD_STORE	=t2.CD_STORE and t1.CD_MENU_COURSE = t2.CD_MENU inner join '
           +'       MS_MENU       t3 on t1.CD_STORE	=t3.CD_STORE and t1.CD_MENU	       = t3.CD_MENU '
           +' where t1.CD_STORE	  =:P0 '
           +'   and t1.CD_MENU  	=:P1 '
           +'   and t1.COURSE_SEQ =:P2 '
           +'   and Substring(t2.CONFIG,8,1) <> ''Y'' '
           +Ifthen(Common.Table.Packing = 'Y', ' and SubString(t2.CONFIG,10,1) <> ''Y'' ',' and SubString(t2.CONFIG,10,1) <> ''S''')
           +'   and t2.YN_USE = ''Y'' '
           +' order by t1.SEQ ',
           [Common.Config.StoreCode,
            Common.Menu.cd_menu,
            CourseStep]);
  vIndex := 0;
  while not Common.Query.Eof do
  begin
    vMenuName  := Common.Query.FieldByName('NM_MENU_SHORT').AsString;
    vMenuPrice := Common.Query.FieldByName('PR_SALE').AsString;
    // 코스메뉴에 부메뉴의 단가를 적용합니다.
    if (vMenuPrice = '0') or (GetOption(23)='0') then
      vMenuPrice := ' '
    else
      vMenuPrice := FormatFloat('￦,0',StoI(vMenuPrice));

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

    KioskButtonList[vIndex].MenuCode    := Common.Query.FieldByName('CD_MENU').AsString;
    KioskButtonList[vIndex].MenuName    := vMenuName;

    if Order_F.CourseMenuCount = 0 then
    begin
      try
        vMenuImage   := TPNGImage.Create;
        vCollectionIndex := Common.GetImageCollectionIndex(Common.Query.FieldByName('CD_MENU').AsString);
        if vCollectionIndex >= 0 then
          KioskButtonList[vIndex].MenuImage.Picture.Assign(Common.MenuImageCollection.Items.Items[vCollectionIndex].Picture.Graphic)
        else
          KioskButtonList[vIndex].MenuImage.Picture.Assign(Order_F.ImageCollection.Items.Items[8].Picture.Graphic);
      finally
        vMenuImage.Free;
      end;
    end;

    if (Common.KioskConfig[14] = 0) and (vMenuPrice <> '') then
    begin
      KioskButtonList[vIndex].GroupBox.Text := Format('<FONT  size="%d" color="%s" face="%s"><P align="%s"></P>%s<BR><P   align="%s"><B>%s</B></P></FONT>',
                                                      [FontSize,
                                                       ColorToString(ButtonFont.Color),
                                                       ButtonFont.Name,
                                                       vMenuAling,
                                                       Common.GetPapago(vMenuName),
                                                       vPriceAlign,
                                                       vMenuPrice]);
    end
    else
    begin
      KioskButtonList[vIndex].GroupBox.Text := Format('<FONT  size="%d" color="%s" face="%s"><P align="%s"></P>%s<BR><BR><P   align="%s"><B>%s</B></P></FONT>',
                                                      [FontSize,
                                                       ColorToString(ButtonFont.Color),
                                                       ButtonFont.Name,
                                                       vMenuAling,
                                                       Common.GetPapago(vMenuName),
                                                       vPriceAlign,
                                                       vMenuPrice]);
    end;

    KioskButtonList[vIndex].MenuCode      := Common.Query.FieldByName('CD_MENU').AsString;
    KioskButtonList[vIndex].KitchenCode   := Common.Query.FieldByName('CD_PRINTER').AsString;
    KioskButtonList[vIndex].KitchenCode2  := Common.Query.FieldByName('CD_PRINTER1').AsString;
    KioskButtonList[vIndex].isDefault     := Common.Query.FieldByName('YN_DEFAULT').AsString = 'Y';
    KioskButtonList[vIndex].MenuPrice     := Common.Query.FieldByName('PR_SALE').AsInteger;
    KioskButtonList[vIndex].PrintMenuName := Common.Query.FieldByName('NM_MENU_KITCHEN').AsString;
    KioskButtonList[vIndex].isSoldOut     := false;
    Inc(vIndex);
    Common.Query.Next;
  end;
  Common.Query.Close;

  if Order_F.CourseMenuCount = 0 then
  begin
    if vButtonCount = 1 then
      KioskButtonList[0].GroupBox.Left := (Self.Width  - ButtonWidth ) div 2
    //한줄일때는 가운데정렬
    else if vButtonCount <= vButtonHorCount then
    begin
      vGap  := (Self.Width - ButtonWidth * vButtonCount) div (vButtonCount+1);
      KioskButtonList[0].GroupBox.Left := vGap;
      for vIndex := 1 to vButtonCount-1 do
        KioskButtonList[vIndex].GroupBox.Left := KioskButtonList[vIndex-1].GroupBox.Left + ButtonWidth + vGap
    end
    else
    begin
      vGap  := (Self.Width - ButtonWidth * vButtonHorCount) div (vButtonHorCount+1);
      vIndex := 0;
      for vCol := 1 to vBottonVerCount do
      begin
        vWidth := 0;
        for vRow := 1 to vButtonHorCount do
        begin
          if vIndex = vButtonCount then
            Break;

          KioskButtonList[vIndex].GroupBox.Top  := (vCol-1) * ButtonHeight + 150 + ((vCol-1) * 15);
          KioskButtonList[vIndex].GroupBox.Left := vWidth + vGap;
          vWidth := vWidth + ButtonWidth + vGap;
          Inc(vIndex);
        end;
      end;
    end;
  end;

  isLoading := true;
  //기본선택메뉴가 있을때
  for vIndex:= 0 to High(KioskButtonList) do
  begin
    if KioskButtonList[vIndex].isDefault then
      MenuButtonClick(KioskButtonList[vIndex].MenuImage);
  end;
  isLoading := false;
end;

procedure TKioskCourse_F.MenuButtonClick(Sender: TObject);
  function GetCourseIndex(aMenuCode:String):Integer;
  var vIndex :Integer;
  begin
    for vIndex := 0 to High(OrderCourseMenu) do
    begin
      if OrderCourseMenu[vIndex]^.MenuCode = aMenuCode then
      begin
        Result := vIndex;
        Break;
      end;
    end;

  end;
var vIndex, vIndex1, vCourseIndex :Integer;
    vExist :Boolean;
begin
  if not isLoading then
    Common.KioskTouchBeep('kioskwave12');

  if (Sender is TcxImage) then
    vIndex1 := (Sender as TcxImage).Tag
  else if (Sender is TcxLabel) then
    vIndex1 := (Sender as TcxLabel).Tag
  else if (Sender is TGroupBox) then
    vIndex1 := (Sender as TGroupBox).Tag
  else Exit;


  if not isLoading and (KioskButtonList[vIndex1].isDefault) and (PossibleCount = SelectCount) then
  begin
    ModalResult := mrOK;
    Exit;
  end;

  if PossibleCount = SelectCount then
  begin
    for vIndex  := 0 to High(KioskButtonList) do
      KioskButtonList[vIndex].Badge.Badge := '';

    SelectCount := 0;
  end;


  vCourseIndex := GetCourseIndex(KioskButtonList[vIndex1].MenuCode);
  //선택가능 수량이 한개일때
  if PossibleCount = 1 then
  begin
    if KioskButtonList[vIndex1].Badge.Badge = '' then
    begin
      KioskButtonList[vIndex1].Badge.Visible := true;
      KioskButtonList[vIndex1].Badge.Badge := '선택';
      SelectCount  := 1;
    end
    else
    begin
      KioskButtonList[vIndex1].Badge.Visible := false;
      KioskButtonList[vIndex1].Badge.Badge := '';
      SelectCount  := 0;
    end;
  end
  else
  begin
    if (ChooseType = 'C') or (ChooseType = 'Q') then
    begin
      if KioskButtonList[vIndex1].Badge.Badge = '' then
      begin
        KioskButtonList[vIndex1].Badge.Visible := true;
        KioskButtonList[vIndex1].Badge.Badge := '선택';
        SelectCount  := SelectCount + 1;
      end
      else
      begin
        KioskButtonList[vIndex1].Badge.Visible := false;
        KioskButtonList[vIndex1].Badge.Badge := '';
        SelectCount := SelectCount - 1;
      end;
    end
    else if ChooseType = 'R' then
    begin
      for vIndex := 0 to High(OrderCourseMenu) do
      begin
        OrderCourseMenu[vIndex]^.MenuCode   := EmptyStr;
        OrderCourseMenu[vIndex]^.OrderQty   := 0;
        OrderCourseMenu[vIndex]^.OrderPrice := 0;
      end;

      for vIndex := 0 to High(KioskButtonList) do
      begin
        KioskButtonList[vIndex].Badge.Visible := false;
        KioskButtonList[vIndex].Badge.Badge := '';
      end;

      KioskButtonList[vIndex1].Badge.Visible := true;
      KioskButtonList[vIndex1].Badge.Badge := '선택';
      SelectCount  := 1;
    end;
  end;

  //선택내역 리스트 Clear
  for vIndex := 0 to High(OrderCourseMenu) do
  begin
    OrderCourseMenu[vIndex]^.Step       := CourseStep;
    OrderCourseMenu[vIndex]^.MenuCode   := EmptyStr;
    OrderCourseMenu[vIndex]^.OrderQty   := 0;
    OrderCourseMenu[vIndex]^.OrderPrice := 0;
  end;

  vIndex1     := 0;
  SelectCount := 0;
  for vIndex  := 0 to High(KioskButtonList) do
  begin
    if KioskButtonList[vIndex].Badge.Badge = '선택' then
    begin
      OrderCourseMenu[vIndex1]^.MenuCode   := KioskButtonList[vIndex].MenuCode;
      OrderCourseMenu[vIndex1]^.MenuName   := KioskButtonList[vIndex].MenuName;
      OrderCourseMenu[vIndex1]^.PrintMenuName := KioskButtonList[vIndex].PrintMenuName;
      OrderCourseMenu[vIndex1]^.OrderQty   := 1;
      if GetOption(23)='1' then
       OrderCourseMenu[vIndex1]^.OrderPrice := KioskButtonList[vIndex].MenuPrice;
      // 세트,코스,오픈세트 출력 시 부메뉴를 설정 주방으로 출력합니다.
      if GetOption(241) = '0' then
        OrderCourseMenu[vIndex1]^.KitchenCode := KioskButtonList[vIndex].KitchenCode
      else
        OrderCourseMenu[vIndex1]^.KitchenCode := KioskButtonList[vIndex].KitchenCode2;

      Inc(vIndex1);
      Inc(SelectCount);
    end;

  end;

  SelectedMenu := '';
  if PossibleCount = SelectCount then
  begin
    for vIndex := 0 to High(OrderCourseMenu) do
    begin
      if OrderCourseMenu[vIndex]^.MenuCode <> EmptyStr then
      begin
        Common.CourseOrderMenu.Add(OrderCourseMenu[vIndex]);
        SelectedMenu := SelectedMenu + Ifthen(SelectedMenu='','',' / ')+ OrderCourseMenu[vIndex]^.MenuName + ' ';
      end;
    end;
    if not isLoading then
      ModalResult := mrOK
    else
      TitleLabel.Caption := Format('%s  [ %d / %d ]',[CouresName, SelectCount, PossibleCount]);
  end
  else
    TitleLabel.Caption := Format('%s  [ %d / %d ]',[CouresName, SelectCount, PossibleCount]);

  if SelectCount > 0 then
  begin
    NextButton.Caption   := Common.GetPaPago('선택완료');
    NextButton.Picture.Assign(Order_F.ImageCollection.Items.Items[10].Picture.Graphic);
    NextButton.Tag       := 1;
  end
  else
  begin
    NextButton.Caption   := Common.GetPaPago('선택안함');
    NextButton.Picture.Assign(Order_F.ImageCollection.Items.Items[9].Picture.Graphic);
    NextButton.Tag       := 0;
  end;
end;

procedure TKioskCourse_F.NextButtonClick(Sender: TObject);
var vIndex :Integer;
begin
  Common.KioskTouchBeep('kioskwave12');
  if MilliSecondsBetween(Now(),ClickTime) < 300 then Exit;
  ClickTime := Now;
  BlockInput(true);
  try
    if NextButton.Tag = 1 then
    begin
      for vIndex := 0 to High(OrderCourseMenu) do
      begin
        if OrderCourseMenu[vIndex]^.MenuCode <> EmptyStr then
        begin
          Common.CourseOrderMenu.Add(OrderCourseMenu[vIndex]);
          SelectedMenu := SelectedMenu + Ifthen(SelectedMenu='','',' / ')+ OrderCourseMenu[vIndex]^.MenuName + ' ';
        end;
      end;
    end;
    ModalResult := mrOK;
  finally
    BlockInput(false);
  end;
end;

procedure TKioskCourse_F.FormActivate(Sender: TObject);
begin
  if Common.KioskVoice then
    Common.TextToSpeech(Common.Menu.nm_menu+' 메뉴에 옵션을 선택하세요.')
  else
    Common.KioskTouchBeep('order');
end;

procedure TKioskCourse_F.FormClose(Sender: TObject;
  var Action: TCloseAction);
var vIndex :Integer;
begin
  CloseTimer.Enabled := false;
end;

procedure TKioskCourse_F.AutoCloseTimerTimer(Sender: TObject);
begin
  AutoCloseTimer.Enabled := false;
  ModalResult := mrOK;
end;

procedure TKioskCourse_F.CancelButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  ModalResult := mrCancel;
end;

procedure TKioskCourse_F.CloseTimerTimer(Sender: TObject);
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
