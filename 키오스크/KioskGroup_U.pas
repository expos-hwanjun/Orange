unit KioskGroup_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, DB, StdCtrls, Math, IniFiles,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxGroupBox, PNGImage, Vcl.Menus, cxButtons,
  dxRatingControl, AdvSmoothButton, cxLabel, GDIPFill, cxImage,
  AdvPanel, AdvSmoothToggleButton, dxGDIPlusClasses, cxClasses, StrUtils;

type
  TKioskButtonList = record
    GroupBox       :TAdvPanel;
    MenuImage      :TcxImage;
    DisableImage   :TcxImage;
    EventImage     :TcxImage;
    MenuCode       :String;
    MenuType       :String;
    isSoldOut      :Boolean;
    ItemCount      :Integer;
    MemoCount      :Integer;
    isDefault      :Boolean;
    MenuPrice      :Integer;
    OrderTime      :TcxLabel;
  end;

type
  TKioskGroup_F = class(TForm)
    TmrClose: TTimer;
    CloseTimer: TTimer;
    CancelButton: TAdvSmoothToggleButton;
    KioskMenuPriorButton: TAdvSmoothToggleButton;
    KioskMenuNextButton: TAdvSmoothToggleButton;
    KioskMenuPageLabel: TcxLabel;
    HeaderPanel: TAdvPanel;
    lblTitle: TcxLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TmrCloseTimer(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure KioskMenuPriorButtonClick(Sender: TObject);
  private
    KioskButtonList : Array of TKioskButtonList;
    FixX,
    FixY,
    MaxPage,
    FPage :Integer;
    procedure MenuButtonClick(Sender: TObject);
    procedure SetMenuButton;
    procedure SetPage(AValue :Integer);
    property  Page :Integer  read FPage         write SetPage;
  public
    GroupName :String;
    ButtonHeight,
    ButtonWidth :Integer;
    MenuCode,
    OrderMenuCode :String;
    ButtonFont :TFont;
  end;

var
  KioskGroup_F: TKioskGroup_F;

implementation
uses Common_U, GlobalFunc_U, Order_U;
{$R *.dfm}

procedure TKioskGroup_F.FormCreate(Sender: TObject);
var vGap :Integer;
begin
  Self.Width   := Order_F.KioskPanel.Width-40;
  Self.Height  := Order_F.KioskPanel.Height;
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

  Common.LogoCreate(Self,0);
  Common.SetKioskButton(lblTitle);
  Common.SetKioskButton(CancelButton,'No');

  Common.SetLanguage(Self);
end;

procedure TKioskGroup_F.FormShow(Sender: TObject);
var vIndex, vRow, vCol :Integer;
    vStream    :TStream;
    vButtonCount,
    vButtonHorCount,
    vBottonVerCount :Integer;
    vLeft,vGap, vWidth  :Integer;
    vMenuName,
    vMenuPrice  :String;
    vBottomMagin :Integer;
    vX, vY :Integer;
    vSalePrice  :Integer;
    vEvent,
    vSoldOut    :Boolean;
    vMenuAling,
    vPriceAlign :String;
    vCollectionIndex :Integer;
    vMenuImage  :TPNGImage;
begin
  CloseTimer.Tag       := 0;
  lblTitle.Caption     := GroupName;
  CancelButton.Caption := Common.GetPapago('나가기');


  if GetOption(428)='1' then
  begin
    vX := Common.KioskConfig[14];
    vY := Common.KioskConfig[15];

    vX := Ifthen(vX < 1, 1, vX);
    vY := Ifthen(vY < 1, 1, vY);

    ButtonWidth  := Common.KioskConfig[16] div vX - (Common.KioskConfig[10] div 2);
    ButtonHeight := Common.KioskConfig[17] div vY - (Common.KioskConfig[10] div 2);
  end;

  OpenQuery('select Count(*) '
           +'  from MS_MENU_GROUP t1 inner join '
           +'       MS_MENU       t2 on t1.CD_STORE	   =t2.CD_STORE '
           +'                       and t1.CD_MENU_SET =t2.CD_MENU '
           +' where t1.CD_STORE	=:P0 '
           +'   and t1.CD_MENU  =:P1 '
           +'   and t2.YN_USE   =''Y'' '
           +'   and SubString(t2.CONFIG,8,1) = ''N'' '
           +Ifthen(Common.Table.Packing = 'Y', ' and SubString(t2.CONFIG,10,1) <> ''Y'' ',' and SubString(t2.CONFIG,10,1) <> ''S'' '),
           [Common.Config.StoreCode,
            MenuCode]);
  vButtonCount := Common.Query.Fields[0].AsInteger;
  if vButtonCount = 0 then
  begin
    TmrClose.Enabled := true;
    Exit;
  end;
  Common.Query.Close;

  FixX := StrToInt(GetOption(439));
  FixY := StrToInt(GetOption(440));

  if (FixX = 0) or (FixY = 0) then
    Common.Config.Options[438] := '0';

  if GetOption(438) = '0' then
  begin
    vButtonHorCount := Self.Width div (ButtonWidth + 10);
    vBottonVerCount := (vButtonCount div vButtonHorCount) + ifthen(vButtonCount mod vButtonHorCount > 0, 1, 0);
    Self.Height     := (vBottonVerCount * ButtonHeight) + (vBottonVerCount * 20) + 200 + CancelButton.Height + 20;
    Self.Top        := Trunc(Screen.Height / 2 - Self.Height / 2);
  end
  else
  begin
    MaxPage :=  vButtonCount div (FixX * FixY);
    if vButtonCount mod (FixX * FixY) > 0 then
      MaxPage := MaxPage + 1;
    vButtonCount    := FixX * FixY;
    vButtonHorCount := FixX;
    vBottonVerCount := FixY;
    KioskMenuPriorButton.Visible    := true;
    KioskMenuNextButton.Visible     := true;
    KioskMenuPageLabel.Visible      := true;
    Self.Height     := (vBottonVerCount * ButtonHeight) + (vBottonVerCount * 20) + 200 + CancelButton.Height + KioskMenuPriorButton.Height + 20;

    KioskMenuPriorButton.Top    := Self.Height - CancelButton.Height - KioskMenuPriorButton.Height - 30;
    KioskMenuNextButton.Top     := KioskMenuPriorButton.Top;
    KioskMenuPageLabel.Top      := KioskMenuPriorButton.Top;

    KioskMenuPriorButton.Left   := 20;
    KioskMenuNextButton.Left    := Self.Width - KioskMenuNextButton.Width - 20;
    KioskMenuPageLabel.Left     :=  (Self.Width  - KioskMenuPageLabel.Width ) div 2;
  end;


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

    KioskButtonList[vIndex].EventImage                  := TcxImage.Create(Self);
    KioskButtonList[vIndex].EventImage.Parent           := KioskButtonList[vIndex].GroupBox;
    KioskButtonList[vIndex].EventImage.Top              := 0;
    KioskButtonList[vIndex].EventImage.Left             := 0;
    KioskButtonList[vIndex].EventImage.Width            := 50;
    KioskButtonList[vIndex].EventImage.Height           := 50;
    KioskButtonList[vIndex].EventImage.Style.BorderStyle := ebsNone;
    KioskButtonList[vIndex].EventImage.Properties.FitMode := ifmStretch;
    KioskButtonList[vIndex].EventImage.Properties.GraphicClassName := 'TdxPNGImage';
    KioskButtonList[vIndex].EventImage.Visible          := true;
    KioskButtonList[vIndex].EventImage.Transparent      := true;
    KioskButtonList[vIndex].EventImage.Tag              := vIndex;
    KioskButtonList[vIndex].EventImage.OnClick          := MenuButtonClick;
    KioskButtonList[vIndex].EventImage.Properties.PopupMenuLayout.MenuItems := [];
    KioskButtonList[vIndex].EventImage.Properties.ShowFocusRect := false;

    KioskButtonList[vIndex].DisableImage                  := TcxImage.Create(Self);
    KioskButtonList[vIndex].DisableImage.Parent           := KioskButtonList[vIndex].GroupBox;
    KioskButtonList[vIndex].DisableImage.Top              := 0;
    KioskButtonList[vIndex].DisableImage.Left             := 0;
    KioskButtonList[vIndex].DisableImage.Width            := ButtonWidth-2;
    KioskButtonList[vIndex].DisableImage.Height           := ButtonHeight - Common.KioskConfig[8];
    KioskButtonList[vIndex].DisableImage.Style.BorderStyle := ebsNone;
    KioskButtonList[vIndex].DisableImage.Properties.FitMode := ifmStretch;
    KioskButtonList[vIndex].DisableImage.Properties.GraphicClassName := 'TdxPNGImage';
    KioskButtonList[vIndex].DisableImage.Visible          := false;
    KioskButtonList[vIndex].DisableImage.Transparent      := true;
    KioskButtonList[vIndex].DisableImage.Tag              := vIndex;
    KioskButtonList[vIndex].DisableImage.OnClick          := MenuButtonClick;
    KioskButtonList[vIndex].DisableImage.Properties.PopupMenuLayout.MenuItems := [];
    KioskButtonList[vIndex].DisableImage.Properties.ShowFocusRect := false;

    KioskButtonList[vIndex].OrderTime                      := TcxLabel.Create(Self);
    KioskButtonList[vIndex].OrderTime.Parent               := KioskButtonList[vIndex].GroupBox;
    KioskButtonList[vIndex].OrderTime.AutoSize             := false;
    KioskButtonList[vIndex].OrderTime.Properties.Alignment.Horz := taCenter;
    KioskButtonList[vIndex].OrderTime.Properties.Alignment.Vert := taVCenter;
    KioskButtonList[vIndex].OrderTime.Top                  := 0;
    KioskButtonList[vIndex].OrderTime.Left                 := 0;
    KioskButtonList[vIndex].OrderTime.Width                := ButtonWidth;
    KioskButtonList[vIndex].OrderTime.Height               := ButtonHeight - Common.KioskConfig[8];
    KioskButtonList[vIndex].OrderTime.Caption              := '';
    KioskButtonList[vIndex].OrderTime.Style.Font.Name      := Order_F.KioskPLUMenuPanel.Font.Name;
    KioskButtonList[vIndex].OrderTime.Style.Font.Size      := Order_F.KioskPLUMenuPanel.Font.Size;
    KioskButtonList[vIndex].OrderTime.Tag                  := vIndex;
    KioskButtonList[vIndex].OrderTime.Transparent          := true;
    KioskButtonList[vIndex].OrderTime.Style.Font.Color     := Order_F.KioskPLUMenuPanel.Font.Color;
    KioskButtonList[vIndex].OrderTime.Style.Font.Style     := [fsBold];
    KioskButtonList[vIndex].OrderTime.Properties.LabelStyle := cxlsLowered;
    KioskButtonList[vIndex].OrderTime.Visible              := false;
    KioskButtonList[vIndex].OrderTime.OnClick              := MenuButtonClick;
    KioskButtonList[vIndex].OrderTime.BringToFront;

  end;

  //그룹메뉴 표시방식
  if GetOption(438) = '1' then
  begin
    vGap  := (Self.Width - ButtonWidth * vButtonHorCount) div (vButtonHorCount+1);
    if vGap < 0 then
      vGap := 5;
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

    Page := 1;
    Exit;
  end;

  OpenQuery('select t1.CD_MENU_SET as CD_MENU, '
           +'       t2.NM_MENU_SHORT, '
           +'       t2.CONFIG, '
           +'       case when t2.DS_MENU_TYPE = ''N'' then ifnull(t4.ITEM_COUNT,0) '
           +'            else 0 end as ITEM_COUNT, '
           +'       ifnull(t3.MEMO_COUNT,0) as MEMO_COUNT, '
           +'       t2.PR_SALE, '
           +'       t2.PR_SALE_PACKING, '
           +'       e.PR_SALE as PR_SALE_EVENT, '
           +'       e.NO_SPC, '
           +'       e.TIME_FROM, '
           +'       e.TIME_TO, '
           +'       t2.ORDERTIME_FROM, '
           +'       t2.ORDERTIME_TO '
           +'  from MS_MENU_GROUP t1 left outer join '
           +'       MS_MENU       t2 on t1.CD_STORE	   = t2.CD_STORE '
           +'                       and t1.CD_MENU_SET = t2.CD_MENU left outer join '
           +'      (select CD_MENU, '
           +'              Count(*) as MEMO_COUNT '
           +'         from MS_MENU_MEMO  '
           +'        where CD_STORE =:P0 '
           +'        group by CD_MENU ) as t3 on t1.CD_MENU_SET = t3.CD_MENU left outer join '
           +'      (select CD_MENU, '
           +'              Count(*) as ITEM_COUNT '
           +'         from MS_MENU  '
           +'        where CD_STORE     = :P0 '
           +'          and DS_MENU_TYPE = ''I'' '
           +'          and SubString(CONFIG,8,1) = ''N'' '
           +'          and YN_USE       = ''Y'' '
           +'        group by CD_MENU ) as t4 on t1.CD_MENU_SET = t4.CD_MENU left outer join '
           +'       ( select Max(b.NO_SPC) as NO_SPC, '
           +'                a.CD_MENU, '
           +'                a.PR_SALE, '
           +'                b.TIME_FROM, '
           +'                b.TIME_TO, '
           +'                b.WEEKLY '
           +'  	       from MS_SPC_D a inner join '
           +'               MS_SPC_H b on a.CD_STORE   = b.CD_STORE '
           +'                         and a.NO_SPC     = b.NO_SPC '
           +'          where a.CD_STORE   = :P0 '
           +'            and b.DT_FROM   <= Date_Format(Now(), ''%Y%m%d'') '
           +'            and b.DT_TO     >= Date_Format(Now(), ''%Y%m%d'') '
           +'            and b.YN_USE    = ''Y'' '
           +'            and a.YN_USE    = ''Y'' '
           +'          group by a.CD_MENU, a.PR_SALE '
           +'        ) e on t1.CD_MENU_SET = e.CD_MENU '
           +' where t1.CD_STORE	=:P0 '
           +'   and t1.CD_MENU  =:P1 '
           +'   and SubString(t2.CONFIG,8,1) = ''N'' '
           +' order by t1.SEQ ',
           [Common.Config.StoreCode,
            MenuCode]);
  vIndex := 0;
  while not Common.Query.Eof do
  begin
    vMenuName  := Common.Query.FieldByName('NM_MENU_SHORT').AsString;
    vSalePrice := Common.Query.FieldByName('PR_SALE').AsInteger;
    vEvent     := false;
    vSoldOut   := false;

    if Common.Query.FieldByName('NO_SPC').AsString <> '' then
    begin
      //행사 시간만체크해서 품절여부 반영
      if (Common.Query.FieldByName('TIME_FROM').AsString <= FormatDateTime('hh:nn',Now()))
        and (Common.Query.FieldByName('TIME_TO').AsString >= FormatDateTime('hh:nn',Now()))
        and (Common.Query.FieldByName('WEEK').AsString = '1') then
      begin
        vSalePrice := Common.Query.FieldByName('PR_SALE_EVENT').AsInteger;
        vEvent     := true;
      end
      else if GetOption(471) = '1' then
        vSoldOut := true;
    end
    else if Copy(Common.Query.FieldByName('CONFIG').AsString,8,1)='Y' then
      vSoldOut := true;

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

    if (Common.Query.FieldByName('ORDERTIME_FROM').AsString <> '00:00') and (Common.Query.FieldByName('ORDERTIME_TO').AsString <> '00:00') then
    begin
      if (FormatDateTime('hh:nn', Now()) < Common.Query.FieldByName('ORDERTIME_FROM').AsString) or (FormatDateTime('hh:nn', Now()) > Common.Query.FieldByName('ORDERTIME_TO').AsString) then
      begin
        KioskButtonList[vIndex].OrderTime.Visible := true;
        KioskButtonList[vIndex].OrderTime.Caption := Format('주문가능시간'#13'%s ~ %s',[Common.Query.FieldByName('ORDERTIME_FROM').AsString, Common.Query.FieldByName('ORDERTIME_TO').AsString]);
      end;
    end;

    KioskButtonList[vIndex].MenuCode := Common.Query.FieldByName('CD_MENU').AsString;
    vCollectionIndex := Common.GetImageCollectionIndex(Common.Query.FieldByName('CD_MENU').AsString);
    if vCollectionIndex >= 0 then
      KioskButtonList[vIndex].MenuImage.Picture.Assign(Common.MenuImageCollection.Items.Items[vCollectionIndex].Picture.Graphic)
    else
      KioskButtonList[vIndex].MenuImage.Picture.Assign(Order_F.ImageCollection.Items.Items[8].Picture.Graphic);


    if vSoldOut or (Copy(Common.Query.FieldByName('CONFIG').AsString,13,1)='0') then
      KioskButtonList[vIndex].EventImage.Picture.Graphic := nil
    else if Copy(Common.Query.FieldByName('CONFIG').AsString,13,1)='R' then
    begin
      if FileExists(Common.AppPath+'Kiosk\Badge_R.png') then
      begin
        vMenuImage.LoadFromFile(Common.AppPath+'Kiosk\Badge_R.png');
        KioskButtonList[vIndex].EventImage.Height := vMenuImage.Height;
        KioskButtonList[vIndex].EventImage.Width  := vMenuImage.Width;
        KioskButtonList[vIndex].EventImage.Picture.LoadFromFile(Common.AppPath+'Kiosk\Badge_R.png');
      end
      else
        KioskButtonList[vIndex].EventImage.Picture.Assign(Order_F.BadgeImageCollection.Items.Items[0].Picture.Graphic);
    end
    else if Copy(Common.Query.FieldByName('CONFIG').AsString,13,1)='H' then
    begin
      if FileExists(Common.AppPath+'Kiosk\Badge_H.png') then
      begin
        vMenuImage.LoadFromFile(Common.AppPath+'Kiosk\Badge_H.png');
        KioskButtonList[vIndex].EventImage.Height := vMenuImage.Height;
        KioskButtonList[vIndex].EventImage.Width  := vMenuImage.Width;
        KioskButtonList[vIndex].EventImage.Picture.LoadFromFile(Common.AppPath+'Kiosk\Badge_H.png');
      end
      else
        KioskButtonList[vIndex].EventImage.Picture.Assign(Order_F.BadgeImageCollection.Items.Items[1].Picture.Graphic);
    end
    else if Copy(Common.Query.FieldByName('CONFIG').AsString,13,1)='N' then
    begin
      if FileExists(Common.AppPath+'Kiosk\Badge_N.png') then
      begin
        vMenuImage.LoadFromFile(Common.AppPath+'Kiosk\Badge_N.png');
        KioskButtonList[vIndex].EventImage.Height := vMenuImage.Height;
        KioskButtonList[vIndex].EventImage.Width  := vMenuImage.Width;
        KioskButtonList[vIndex].EventImage.Picture.LoadFromFile(Common.AppPath+'Kiosk\Badge_N.png');
      end
      else
        KioskButtonList[vIndex].EventImage.Picture.Assign(Order_F.BadgeImageCollection.Items.Items[2].Picture.Graphic);
    end
    else if Copy(Common.Query.FieldByName('CONFIG').AsString,13,1)='T' then
    begin
      if FileExists(Common.AppPath+'Kiosk\Badge_T.png') then
      begin
        vMenuImage.LoadFromFile(Common.AppPath+'Kiosk\Badge_T.png');
        KioskButtonList[vIndex].EventImage.Height := vMenuImage.Height;
        KioskButtonList[vIndex].EventImage.Width  := vMenuImage.Width;
        KioskButtonList[vIndex].EventImage.Picture.LoadFromFile(Common.AppPath+'Kiosk\Badge_T.png');
      end
      else
        KioskButtonList[vIndex].EventImage.Picture.Assign(Order_F.BadgeImageCollection.Items.Items[4].Picture.Graphic);
    end;


    //품절이면 주문가능시간을 표시하지 않는다
    if vSoldOut then
    begin
      KioskButtonList[vIndex].DisableImage.Picture.Assign(Order_F.ImageCollectionDisable.Picture.Graphic);
      KioskButtonList[vIndex].DisableImage.Visible := true;
      KioskButtonList[vIndex].OrderTime.Visible := true;
      KioskButtonList[vIndex].OrderTime.Caption := 'SOLD OUT';
      KioskButtonList[vIndex].OrderTime.Style.Font.Size := Order_F.KioskPLUMenuPanel.Font.Size + 10;
      KioskButtonList[vIndex].isSoldOut         := vSoldOut;
    end
    else if KioskButtonList[vIndex].OrderTime.Visible then
    begin
      KioskButtonList[vIndex].DisableImage.Picture.Assign(Order_F.ImageCollectionDisable.Picture.Graphic);
      KioskButtonList[vIndex].DisableImage.Visible := true;
      KioskButtonList[vIndex].OrderTime.Style.Font.Size := Order_F.KioskPLUMenuPanel.Font.Size + 5;
    end;
    if vEvent then
      KioskButtonList[vIndex].EventImage.Picture.Assign(Order_F.ImageCollection.Items.Items[11].Picture.Graphic);

    if ((Common.WorkKind = wkPacking) or (Common.Table.Packing = 'Y')) and (Common.Query.FieldByName('PR_SALE_PACKING').AsCurrency > 0) then
    begin
      //행사적용 시 포장단가에도 적용한다
      if vEvent then
        vMenuPrice    := FormatFloat('￦ ,0', Common.Query.FieldByName('PR_SALE_PACKING').AsCurrency - (Common.Query.FieldByName('PR_SALE').AsCurrency - Common.Query.FieldByName('PR_SALE_EVENT').AsCurrency))
      else
        vMenuPrice    := FormatFloat('￦ ,0', Common.Query.FieldByName('PR_SALE_PACKING').AsCurrency);
    end
    else
      vMenuPrice    := FormatFloat('￦ ,0', vSalePrice);


    if not vEvent then
    begin
      if Common.KioskConfig[14] = 0 then
      begin
        KioskButtonList[vIndex].GroupBox.Text := Format('<FONT  size="%d" color="%s" face="%s"><P align="%s"></P>%s<BR><P   align="%s"><B>%s</B></P></FONT>',
                                                        [Order_F.KioskPLUMenuPanel.Font.Size,
                                                         ColorToString(Order_F.KioskPLUMenuPanel.Font.Color),
                                                         Order_F.KioskPLUMenuPanel.Font.Name,
                                                         vMenuAling,
                                                         Replace(vMenuName,'|','<BR>'),
                                                         vPriceAlign,
                                                         vMenuPrice]);
      end
      else
      begin
        KioskButtonList[vIndex].GroupBox.Text := Format('<FONT  size="%d" color="%s" face="%s"><P align="%s"></P>%s<BR><BR><P   align="%s"><B>%s</B></P></FONT>',
                                                        [Order_F.KioskPLUMenuPanel.Font.Size,
                                                         ColorToString(Order_F.KioskPLUMenuPanel.Font.Color),
                                                         Order_F.KioskPLUMenuPanel.Font.Name,
                                                         vMenuAling,
                                                         Replace(vMenuName,'|','<BR>'),
                                                         vPriceAlign,
                                                         vMenuPrice]);
      end;
    end
    else
    begin
      if Common.KioskConfig[14] = 0 then
      begin
        KioskButtonList[vIndex].GroupBox.Text := Format('<FONT  size="%d" color="%s" face="%s"><P align="%s"></P>%s<BR><FONT color="#FF0000"><P   align="%s"><B>%s</B></P></FONT>',
                                                        [Order_F.KioskPLUMenuPanel.Font.Size,
                                                         ColorToString(Order_F.KioskPLUMenuPanel.Font.Color),
                                                         Order_F.KioskPLUMenuPanel.Font.Name,
                                                         vMenuAling,
                                                         Replace(vMenuName,'|','<BR>'),
                                                         vPriceAlign,
                                                         Common.GetPaPago('(행사)  ')+vMenuPrice]);
      end
      else
      begin
        KioskButtonList[vIndex].GroupBox.Text := Format('<FONT  size="%d" color="%s" face="%s"><P align="%s"></P>%s<BR><BR><FONT color="#FF0000"><P   align="%s"><B>%s</B></P></FONT>',
                                                        [Order_F.KioskPLUMenuPanel.Font.Size,
                                                         ColorToString(Order_F.KioskPLUMenuPanel.Font.Color),
                                                         Order_F.KioskPLUMenuPanel.Font.Name,
                                                         vMenuAling,
                                                         Replace(vMenuName,'|','<BR>'),
                                                         vPriceAlign,
                                                         Common.GetPaPago('(행사)  ')+vMenuPrice]);
      end;
    end;


    KioskButtonList[vIndex].isSoldOut := vSoldOut;

    KioskButtonList[vIndex].MenuCode      := Common.Query.FieldByName('CD_MENU').AsString;
    KioskButtonList[vIndex].ItemCount     := Common.Query.FieldByName('ITEM_COUNT').AsInteger;
    KioskButtonList[vIndex].MemoCount     := Common.Query.FieldByName('MEMO_COUNT').AsInteger;
    Inc(vIndex);
    Common.Query.Next;
  end;
  Common.Query.Close;

  if vButtonCount = 1 then
    KioskButtonList[0].GroupBox.Left := (Self.Width  - ButtonWidth ) div 2
  //한줄일때는 가운데정렬
  else if vButtonCount <= vButtonHorCount then
  begin
    vGap  := (Self.Width - ButtonWidth * vButtonCount) div (vButtonCount+1);
    KioskButtonList[0].GroupBox.Left := vGap;
    for vIndex := 1 to vButtonCount-1 do
      KioskButtonList[vIndex].GroupBox.Left := KioskButtonList[vIndex-1].GroupBox.Left + ButtonWidth + vGap;
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
  CancelButton.Left := Self.Width div 2 - CancelButton.Width div 2;
end;

procedure TKioskGroup_F.KioskMenuPriorButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');

  if Sender = KioskMenuPriorButton then
    Page := Page - 1
  else if Sender = KioskMenuNextButton then
    Page := Page + 1;

end;

procedure TKioskGroup_F.MenuButtonClick(Sender: TObject);
var vHandle   :THandle;
    vSendData :AnsiString;
    vData     : TCopyDataStruct;
    vIndex    : Integer;
begin
  Common.KioskTouchBeep('kioskwave10');
  if (Sender is TcxImage) then
    vIndex := (Sender as TcxImage).Tag
  else if (Sender is TcxLabel) then
    vIndex := (Sender as TcxLabel).Tag
  else if (Sender is TGroupBox) then
    vIndex := (Sender as TGroupBox).Tag
  else Exit;

  if KioskButtonList[vIndex].isSoldOut then
  begin
    Common.MsgBox('일시 품절된 메뉴입니다');
    Exit;
  end;

  if (KioskButtonList[vIndex].ItemCount = 0) and (KioskButtonList[vIndex].MemoCount = 0) then
  begin
    Common.KioskTouchBeep('kioskwave10');
    vHandle := FindWindow('TOrder_F', nil);
    if vHandle > 0 then
    begin
      vSendData    := KioskButtonList[vIndex].MenuCode;;
      vData.dwData := 0;
      vData.cbData := Length(vSendData)+1;
      vData.lpData := PAnsiChar(vSendData);
      SendMessage(vHandle, WM_COPYDATA, Self.Handle, Integer(@vData));
    end;
  end
  else
  begin
    Common.KioskTouchBeep('kioskwave12');
    OrderMenuCode := KioskButtonList[vIndex].MenuCode;
    ModalResult := mrOK;
  end;
  TmrClose.Enabled := true;
end;

procedure TKioskGroup_F.FormClose(Sender: TObject;
  var Action: TCloseAction);
var vIndex :Integer;
begin
  CloseTimer.Enabled := false;
end;

procedure TKioskGroup_F.TmrCloseTimer(Sender: TObject);
begin
  TmrClose.Enabled := false;
  Close;
end;

procedure TKioskGroup_F.CancelButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  Close;
end;

procedure TKioskGroup_F.CloseTimerTimer(Sender: TObject);
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

procedure TKioskGroup_F.SetPage(AValue: Integer);
var vIndex :Integer;
begin
  FPage  := AValue;
  KioskMenuPageLabel.Caption := Format('%d / %d',[FPage, MaxPage]);
  SetMenuButton;

  if KioskMenuNextButton.Visible then
  begin
    KioskMenuPriorButton.Enabled := FPage > 1;
    KioskMenuNextButton.Enabled := FPage < MaxPage;
  end;
end;

procedure TKioskGroup_F.SetMenuButton;
var vIndex,
    vCount :Integer;
    vMenuName,
    vMenuPrice  :String;
    vStream    :TStream;
    vMenuImage :TPNGImage;
    vMenuAling,
    vPriceAlign :String;
begin
  for vIndex := 0 to High(KioskButtonList) do
    KioskButtonList[vIndex].GroupBox.Visible := false;

  OpenQuery('select t1.CD_MENU_SET as CD_MENU, '
           +'       t2.NM_MENU_SHORT, '
           +'       i.IMG_MENU, '
           +'       t2.CONFIG, '
           +'       case when t2.DS_MENU_TYPE = ''N'' then ifnull(t4.ITEM_COUNT,0) '
           +'            else 0 end as ITEM_COUNT, '
           +'       ifnull(t3.MEMO_COUNT,0) as MEMO_COUNT, '
           +'       t2.PR_SALE, '
           +'       t5.KIOSK_SOLDOUT_IMAGE as SOLDOUT_IMAGE '
           +'  from MS_MENU_GROUP t1 inner join '
           +'       MS_MENU_IMAGE i  on t1.CD_STORE = i.CD_STORE and t1.CD_MENU_SET = i.CD_MENU inner join '
           +'       MS_MENU       t2 on t1.CD_STORE	  = t2.CD_STORE '
           +'                       and t1.CD_MENU_SET = t2.CD_MENU left outer join '
           +'      (select CD_MENU, '
           +'              Count(*) as MEMO_COUNT '
           +'         from MS_MENU_MEMO  '
           +'        where CD_STORE =:P0 '
           +'        group by CD_MENU ) as t3 on t1.CD_MENU_SET = t3.CD_MENU left outer join '
           +'      (select CD_MENU, '
           +'              Count(*) as ITEM_COUNT '
           +'         from MS_MENU  '
           +'        where CD_STORE     = :P0 '
           +'          and DS_MENU_TYPE = ''I'' '
           +'          and YN_USE       = ''Y'' '
           +'        group by CD_MENU ) as t4 on t1.CD_MENU_SET = t4.CD_MENU left outer join '
           +'       MS_STORE      t5 on t5.CD_STORE = t1.CD_STORE '
           +' where t1.CD_STORE	=:P0 '
           +'   and t1.CD_MENU  =:P1 '
           +'   and SubString(t2.CONFIG,8,1) = ''N'' '
           +' order by t1.SEQ ',
           [Common.Config.StoreCode,
            MenuCode]);
  vIndex := 0;
  vCount := 0;

  while not Common.Query.Eof do
  begin
    Inc(vCount);
    if (vCount >= ((FixX * FixY)*(Page-1))+1) and (vCount <= (FixX * FixY)*(Page)) then
    begin
      vMenuName := Common.Query.FieldByName('NM_MENU_SHORT').AsString;
      vMenuPrice := FormatFloat('#,0원', Common.Query.FieldByName('PR_SALE').AsCurrency);

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

      if Common.KioskConfig[9] = 1 then
      begin
        KioskButtonList[vIndex].GroupBox.Text := Format('<FONT  size="%d" face="%s"><P align="%s"></P>%s<BR><P   align="%s">%s</P></FONT>',
                                                        [Order_F.KioskPLUMenuPanel.Font.Size,
                                                         Order_F.KioskPLUMenuPanel.Font.Name,
                                                         vMenuAling,
                                                         Common.GetPapago(vMenuName),
                                                         vPriceAlign,
                                                         vMenuPrice]);
      end
      else
      begin
        KioskButtonList[vIndex].GroupBox.Text := Format('<FONT  size="%d" face="%s"><P   align="%s">%s</P></FONT>',
                                                        [Order_F.KioskPLUMenuPanel.Font.Size,
                                                         Order_F.KioskPLUMenuPanel.Font.Name,
                                                         vPriceAlign,
                                                         vMenuPrice]);
      end;



      KioskButtonList[vIndex].MenuCode         := Common.Query.FieldByName('CD_MENU').AsString;

      if (Copy(Common.Query.FieldByName('CONFIG').AsString,8,1)='N') and (Common.Query.FieldByName('IMG_MENU').AsString <> '') then
      begin
        vStream := Common.Query.CreateBLOBStream(Common.Query.FieldByName('IMG_MENU'), bmRead);
        try
         vMenuImage   := TPNGImage.Create;
         vMenuImage.LoadFromStream(vStream);
          KioskButtonList[vIndex].MenuImage.Picture.Assign(vMenuImage);
        finally
          vStream.Free;
          vMenuImage.Free;
        end;
      end
      else
      begin
        KioskButtonList[vIndex].MenuImage.Picture.Assign(Order_F.ImageCollection.Items.Items[8].Picture.Graphic);;
      end;

      KioskButtonList[vIndex].isSoldOut := Copy(Common.Query.FieldByName('CONFIG').AsString,8,1)='Y';


      KioskButtonList[vIndex].MenuCode      := Common.Query.FieldByName('CD_MENU').AsString;
      KioskButtonList[vIndex].ItemCount     := Common.Query.FieldByName('ITEM_COUNT').AsInteger;
      KioskButtonList[vIndex].MemoCount     := Common.Query.FieldByName('MEMO_COUNT').AsInteger;
      KioskButtonList[vIndex].GroupBox.Visible := true;
      Inc(vIndex);
    end;
    Common.Query.Next;
  end;
  Common.Query.Close;

end;

end.
