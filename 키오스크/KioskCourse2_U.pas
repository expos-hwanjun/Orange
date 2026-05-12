unit KioskCourse2_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, Vcl.ExtCtrls, AdvToolBar,
  AdvToolBarStylers, cxClasses, DBAccess, Uni, Data.DB, MemDS, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGrid, cxTextEdit,
  cxDropDownEdit, cxLabel, cxMaskEdit, cxCalendar, AdvGlowButton, AdvSplitter,
  cxGroupBox, Vcl.Buttons, cxCurrencyEdit, cxCheckBox, StrUtils,
  JPEG, Vcl.StdCtrls, Vcl.Menus, cxButtons, IdTCPClient, IdGlobal, Vcl.ComCtrls,
  dxCore, cxDateUtils, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxNavigator, PosButton, Math, IdBaseComponent, IdComponent, IdTCPConnection,
  IdHTTP, dxmdaset, IPPeerClient, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, PNGImage, dxBarBuiltInMenu, cxPC, IniFiles, cxImage,
  AdvSmoothToggleButton, Vcl.ExtDlgs, AdvScrollBox, dxGDIPlusClasses, AdvSmoothButton,
  Common_U, AdvPanel, DateUtils;


type
  TMenuInfo = record
    GroupBox        :TPanel;
    ControlImage    :TAdvSmoothButton;
    Control2Image   :TAdvSmoothButton;
    MenuImage       :TcxImage;
    MenuCode        :String;
    MenuName        :TcxLabel;
    Price           :TcxLabel;
    OrderQty        :TcxLabel;
    OrderAmt        :TcxLabel;
    Qty,
    OrderPrice      :Integer;
    KitchenCode     :String;
    PrintMenuName   :String;
  end;

type
  TCourse = record
    GroupBox   :TAdvPanel;
    GroupImage :TcxImage;
    CourseSeq  :Integer;
    ChooseType :String;   //R 라디오버튼, C:체크박스, M:멀티
    MenuInfo   :Array of TMenuInfo;
    ChooseQty  :Integer; //최대주문수량
  end;

type
  TKioskCourse2_F = class(TForm)
    CheckBoxImageCollection: TcxImageCollection;
    UnCheckImage: TcxImageCollectionItem;
    CheckImage: TcxImageCollectionItem;
    RadioImageCollection: TcxImageCollection;
    RaidoImageCollectionItem1: TcxImageCollectionItem;
    RaidoImageCollectionItem2: TcxImageCollectionItem;
    QtyImageCollection: TcxImageCollection;
    QtyImageCollectionItem1: TcxImageCollectionItem;
    QtyImageCollectionItem2: TcxImageCollectionItem;
    OrderButton: TAdvSmoothButton;
    CancelButton: TAdvSmoothToggleButton;
    MainPanel: TAdvScrollBox;
    CloseTimer: TTimer;
    GroupImageCollection: TcxImageCollection;
    GroupImageMax: TcxImageCollectionItem;
    GroupImageMin: TcxImageCollectionItem;
    RadioImageCollectionItem1: TcxImageCollectionItem;
    RadioImageCollectionItem2: TcxImageCollectionItem;
    QtyImageCollectionItem3: TcxImageCollectionItem;
    QtyImageCollectionItem4: TcxImageCollectionItem;
    CheckBoxImageCollectionItem1: TcxImageCollectionItem;
    CheckBoxImageCollectionItem2: TcxImageCollectionItem;
    GroupImageCollectionItem1: TcxImageCollectionItem;
    CheckBoxImageCollectionItem3: TcxImageCollectionItem;
    CheckBoxImageCollectionItem4: TcxImageCollectionItem;
    RadioImageCollectionItem3: TcxImageCollectionItem;
    RadioImageCollectionItem4: TcxImageCollectionItem;
    QtyImageCollectionItem5: TcxImageCollectionItem;
    QtyImageCollectionItem6: TcxImageCollectionItem;
    GroupImageCollectionItem2: TcxImageCollectionItem;
    CheckBoxImageCollectionItem5: TcxImageCollectionItem;
    CheckBoxImageCollectionItem6: TcxImageCollectionItem;
    RadioImageCollectionItem5: TcxImageCollectionItem;
    RadioImageCollectionItem6: TcxImageCollectionItem;
    QtyImageCollectionItem7: TcxImageCollectionItem;
    QtyImageCollectionItem8: TcxImageCollectionItem;
    HeaderPanel: TAdvPanel;
    lblOrderAmt: TcxLabel;
    lblQty: TcxLabel;
    lblMenuName: TcxLabel;
    btnAdd: TAdvSmoothToggleButton;
    btnDec: TAdvSmoothToggleButton;
    MenuInfoLabel: TcxLabel;
    procedure FormCreate(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure RadioBoxClick(Sender: TObject);
    procedure QtyButtonClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDecClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure OrderButtonClick(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    KioskCourse : Array of TCourse;
    OrderCourseMenu  :Array of ^TCourseOrderMenu;
    GroupIconColor,                  //그룹 아이콘
    ItemIconColor,                   //아이템 아이콘 색
    GroupFontColor,                  //그룹 폰트
    ItemFontColor  :String;          //아이콘 폰트
    ImageView      :String;
    ClickTime :TDateTime;
    procedure SetCourseMenu;
    function  GetImageIndex(aIndex:Integer):Integer;
  public
    { Public declarations }
  end;

var
  KioskCourse2_F: TKioskCourse2_F;

implementation
uses GlobalFunc_U, Order_U, DBModule_U, Const_U;

{$R *.dfm}

{ TKioskCourse2_F }
procedure TKioskCourse2_F.FormActivate(Sender: TObject);
begin
  if Common.KioskVoice then
    Common.TextToSpeech(Common.Menu.nm_menu+' 메뉴에 옵션을 선택하세요.')
  else
    Common.KioskTouchBeep('order');
end;

procedure TKioskCourse2_F.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseTimer.Enabled := false;
end;

procedure TKioskCourse2_F.FormCreate(Sender: TObject);
var vIndex, vCollectionIndex :Integer;
    vCaption :String;
begin
  Common.LogoCreate(Self,0);

  with TIniFile.Create(Common.AppPath+'Kiosk\KioskConfig.ini') do
  try
    GroupIconColor := ReadString('Course', 'GroupIcon','');
    ItemIconColor  := ReadString('Course', 'ItemIcon','');
    GroupFontColor := ReadString('Course', 'GroupFontColor','');
    ItemFontColor  := ReadString('Course', 'ItemFontColor','');
    ImageView      := ReadString('Course', 'ImageView', 'N');
  finally
    Free
  end;

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

  Common.SetButtonColor(btnAdd,true);
  Common.SetButtonColor(btnDec,true);
  Common.SetButtonColor(OrderButton);

  Common.SetKioskButton(CancelButton,'No');
  Common.SetKioskButton(OrderButton,'Yes');
  Common.SetKioskButton(lblMenuName);
  Common.SetKioskButton(MenuInfoLabel);
  Common.SetKioskButton(lblOrderAmt);

  //베리어프리 모드일때
  if Common.Config.BarrierFreeMode = bfWheelChair then
  begin
    Self.Position := poDesigned;
    Self.ClientHeight   := Screen.Height - Common.Config.BarrierTop;
    Self.ClientWidth    := 1021;
    Self.Top      := Common.Config.BarrierTop - 50;
    Self.Left     := Screen.Width div 2 - Self.ClientWidth div 2;
    MainPanel.Width := 988;
  end
  else
    Self.ClientHeight := Order_F.KioskPanel.Height - 50;

  lblMenuName.Caption := Common.GetPapago(Common.Menu.nm_menu);
  lblOrderAmt.Caption := FormatFloat('￦ ,0',Common.Menu.pr_sale);

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

  DM.OpenQuery('select distinct t1.NM_COURSE, '
              +'       t1.CNT_CHOOSE, '
              +'       t1.COURSE_SEQ, '
              +'       t1.DS_CHOOSE '
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
  SetLength(KioskCourse, DM.Query.RecordCount);

  vIndex := 0;
  while not DM.Query.eof do
  begin
    KioskCourse[vIndex].GroupBox                   := TAdvPanel.Create(Self);
    KioskCourse[vIndex].GroupBox.Parent            := MainPanel;
    KioskCourse[vIndex].GroupBox.Color             := clWhite;
    KioskCourse[vIndex].GroupBox.CollapsColor      := clWhite;
    KioskCourse[vIndex].GroupBox.Align             := alTop;
    KioskCourse[vIndex].GroupBox.BevelOuter        := bvNone;
    KioskCourse[vIndex].GroupBox.ParentColor       := true;
    KioskCourse[vIndex].GroupBox.BorderColor       := clNone;
    KioskCourse[vIndex].GroupBox.Caption.Height    := 50;
    KioskCourse[vIndex].GroupBox.Caption.Color     := clWhite;
    KioskCourse[vIndex].GroupBox.Caption.TopIndent := 3;
    KioskCourse[vIndex].GroupBox.Caption.Font.Name := Common.Config.KioskDefaultFontName;
    KioskCourse[vIndex].GroupBox.Caption.Font.Size := 25;
    KioskCourse[vIndex].GroupBox.Caption.Font.Style := [fsBold];
    KioskCourse[vIndex].GroupBox.Hint               := DM.Query.FieldByName('NM_COURSE').AsString;
    KioskCourse[vIndex].GroupBox.Caption.Visible   := true;
    KioskCourse[vIndex].GroupBox.Left              := 50;
    KioskCourse[vIndex].GroupBox.Width             := Self.ClientWidth - 100;
    KioskCourse[vIndex].GroupBox.Height            := 0;
    KioskCourse[vIndex].GroupBox.DoubleBuffered    := true;

    KioskCourse[vIndex].GroupImage                 := TcxImage.Create(Self);
    KioskCourse[vIndex].GroupImage.Parent          := KioskCourse[vIndex].GroupBox;
    KioskCourse[vIndex].GroupImage.Left            := 0;
    KioskCourse[vIndex].GroupImage.Top             := 2;
    KioskCourse[vIndex].GroupImage.Style.BorderStyle := ebsNone;
    KioskCourse[vIndex].GroupImage.Height          := 50;
    KioskCourse[vIndex].GroupImage.Width           := 50;

    if GroupIconColor = '' then
    begin
      if (GetOption(458) = '2') then  //Black
        KioskCourse[vIndex].GroupImage.Picture.Assign(GroupImageCollection.Items[1].Picture.Graphic)
      else if (GetOption(458) = '3') then  //Red
        KioskCourse[vIndex].GroupImage.Picture.Assign(GroupImageCollection.Items[2].Picture.Graphic)
      else if (GetOption(458) = '4') then  //Green
        KioskCourse[vIndex].GroupImage.Picture.Assign(GroupImageCollection.Items[3].Picture.Graphic)
      else
        KioskCourse[vIndex].GroupImage.Picture.Assign(GroupImageCollection.Items[0].Picture.Graphic);
    end
    else
    begin
      if (GroupIconColor = 'clBlack') then  //Black
        KioskCourse[vIndex].GroupImage.Picture.Assign(GroupImageCollection.Items[1].Picture.Graphic)
      else if (GroupIconColor = 'clRed') then  //Red
        KioskCourse[vIndex].GroupImage.Picture.Assign(GroupImageCollection.Items[2].Picture.Graphic)
      else if (GroupIconColor = 'clGreen') then  //Green
        KioskCourse[vIndex].GroupImage.Picture.Assign(GroupImageCollection.Items[3].Picture.Graphic)
      else
        KioskCourse[vIndex].GroupImage.Picture.Assign(GroupImageCollection.Items[0].Picture.Graphic);
    end;

    if DM.Query.FieldByName('DS_CHOOSE').AsString = 'R' then
      vCaption    := '  '+Common.GetPapago(DM.Query.FieldByName('NM_COURSE').AsString)
    else
      vCaption          := Common.GetPapago(Format('  %s [최대 %d개]',[DM.Query.FieldByName('NM_COURSE').AsString, DM.Query.FieldByName('CNT_CHOOSE').AsInteger]));


    if GroupFontColor = '' then
      KioskCourse[vIndex].GroupBox.Caption.Text :=Format('<FONT  size="%d" face="%s"><P   align="%s">   %s</P></FONT>',
                                                        [28,
                                                         Common.Config.KioskDefaultFontName,
                                                         'left',
                                                         vCaption])
    else
      KioskCourse[vIndex].GroupBox.Caption.Text :=Format('<FONT  size="%d" color="%s" face="%s"><P   align="%s">   %s</P></FONT>',
                                                        [28,
                                                         GroupFontColor,
                                                         Common.Config.KioskDefaultFontName,
                                                         'left',
                                                         vCaption]);


    KioskCourse[vIndex].GroupBox.Caption.MinMaxCaption := False;

    KioskCourse[vIndex].CourseSeq  := DM.Query.FieldByName('COURSE_SEQ').AsInteger;
    KioskCourse[vIndex].ChooseQty  := DM.Query.FieldByName('CNT_CHOOSE').AsInteger;
    KioskCourse[vIndex].ChooseType := DM.Query.FieldByName('DS_CHOOSE').AsString;
    DM.Query.Next;
    Inc(vIndex);
  end;
  DM.Query.Close;
  SetCourseMenu;
end;

procedure TKioskCourse2_F.FormDestroy(Sender: TObject);
var vIndex :Integer;
begin
  for vIndex := Low(KioskCourse) to High(KioskCourse) do
    SetLength(KioskCourse[vIndex].MenuInfo, 0);

  SetLength(OrderCourseMenu, 0);
end;

procedure TKioskCourse2_F.FormShow(Sender: TObject);
begin
  ClickTime                   := IncSecond(Now,-3);
  CloseTimer.Tag              := 0;
  CancelButton.Status.Caption := '';
  MainPanel.Visible := true;
end;

procedure TKioskCourse2_F.CancelButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  Close;
end;

procedure TKioskCourse2_F.SetCourseMenu;
var vIndex, vIndex2, vHeight, vTop, vLeft, vTotalHeight, vItemTop :Integer;
    vMenuImage  :TPNGImage;
    vStream    :TStream;
    vFontColor :TColor;
begin
  if ItemFontColor = '' then
    vFontColor := clBlack
  else
    vFontColor := StringToColorDef(ItemFontColor, clBlack);

  vTotalHeight := 0;
  vItemTop     := 10;
  for vIndex := 0 to High(KioskCourse) do
  begin
    DM.OpenQuery('select t1.CD_MENU_COURSE as CD_MENU, '
                +'       t1.COURSE_SEQ, '
                +'       t2.CD_PRINTER, '
                +'       t3.CD_PRINTER AS CD_PRINTER1,'
                +'       t1.COLOR, '
                +'       t1.YN_DEFAULT, '
                +'       t2.NM_MENU_SHORT, '
                +'       t2.PR_SALE, '
                +'       t4.IMG_MENU, '
                +'       t2.NM_MENU_KITCHEN '
                +'  from MS_COURSE     t1 inner join '
                +'       MS_MENU       t2 on t1.CD_STORE	=t2.CD_STORE and t1.CD_MENU_COURSE =t2.CD_MENU inner join '
                +'       MS_MENU       t3 on t1.CD_STORE	=t3.CD_STORE and t1.CD_MENU = t3.CD_MENU left outer join '
                +'       MS_MENU_IMAGE t4 on t2.CD_STORE	=t4.CD_STORE and t2.CD_MENU = t4.CD_MENU '
                +' where t1.CD_STORE	  =:P0 '
                +'   and t1.CD_MENU  	  =:P1 '
                +'   and t1.COURSE_SEQ  =:P2 '
                +'   and Substring(t2.CONFIG,8,1) <> ''Y'' '
                +Ifthen(Common.Table.Packing = 'Y', ' and SubString(t2.CONFIG,10,1) <> ''Y'' ',' and SubString(t2.CONFIG,10,1) <> ''S'' ')
                +'   and t2.YN_USE = ''Y'' '
                +' order by t1.SEQ ',
                [Common.Config.StoreCode,
                 Common.Menu.cd_menu,
                 KioskCourse[vIndex].CourseSeq]);

    SetLength(KioskCourse[vIndex].MenuInfo, DM.Query.RecordCount);
    vIndex2    := 0;
    vTop       := 0;
    KioskCourse[vIndex].GroupBox.Height := 50;      //GroupBox Caption 기본 Height
    vHeight  := 65;
    while not DM.Query.Eof do
    begin
      vLeft := 10;
      vTop  := vTop + 60;
      KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox                   := TPanel.Create(Self);
      KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox.DoubleBuffered    := true;
      KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox.Parent            := KioskCourse[vIndex].GroupBox;
      KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox.BevelOuter        := bvNone;
      KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox.ParentColor       := true;
      KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox.Caption           := EmptyStr;
      KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox.Top               := vTop;
      KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox.Left              := 0;
      KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox.Width             := KioskCourse[vIndex].GroupBox.Width + 70;
      KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox.Height            := vHeight;
      KioskCourse[vIndex].GroupBox.Height                              := KioskCourse[vIndex].GroupBox.Height + vHeight;

      //이미지1
      if KioskCourse[vIndex].ChooseType <> 'Q' then
      begin
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage                  := TAdvSmoothButton.Create(Self);
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Parent           := KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox;
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Top              := 12;
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Left             := vLeft;
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Width            := 40;
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Height           := 40;
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Appearance.PictureAlignment := taCenter;
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Appearance.SimpleLayout := true;
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Color            := clWhite;
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.AutoSizeToPicture := true;
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Tag              := 0;
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Hint             := IntToStr(vIndex);
        if KioskCourse[vIndex].ChooseType = 'C' then
        begin
          if DM.Query.FieldByName('YN_DEFAULT').AsString = 'Y' then
          begin
            KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Tag := 1;
            KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Picture.Assign(CheckBoxImageCollection.Items[GetImageIndex(1)].Picture.Graphic);
          end
          else
            KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Picture.Assign(CheckBoxImageCollection.Items[GetImageIndex(0)].Picture.Graphic);
          KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.OnClick := CheckBoxClick;
        end
        else if KioskCourse[vIndex].ChooseType = 'R' then
        begin
          if DM.Query.FieldByName('YN_DEFAULT').AsString = 'Y' then
          begin
            KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Tag := 1;
            KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Picture.Assign(RadioImageCollection.Items[GetImageIndex(1)].Picture.Graphic);
          end
          else
            KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Picture.Assign(RadioImageCollection.Items[GetImageIndex(0)].Picture.Graphic);
          KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.OnClick := RadioBoxClick;
        end;
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Appearance.FocusColor := clWhite;

        vLeft := vLeft + 50;
        if ImageView = 'Y' then
        begin
          //메뉴이미지
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage                  := TcxImage.Create(Self);
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Parent           := KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox;
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Top              := vItemTop-5;
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Left             := vLeft;
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Width            := vHeight;
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Height           := vHeight;
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Style.BorderStyle := ebsNone;
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Properties.FitMode := ifmStretch;
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Properties.GraphicClassName := 'TdxPNGImage';
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Visible          := true;
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Transparent      := true;
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Tag              := vIndex;
          if KioskCourse[vIndex].ChooseType = 'C' then
            KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.OnClick          := CheckBoxClick
          else
            KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.OnClick          := RadioBoxClick;

          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Properties.PopupMenuLayout.MenuItems := [];
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Properties.ShowFocusRect := false;

          if DM.Query.FieldByName('IMG_MENU').AsString <> '' then
          begin
            vMenuImage   := TPNGImage.Create;
            vStream := DM.Query.CreateBLOBStream(DM.Query.FieldByName('IMG_MENU'), bmRead);
            vMenuImage.LoadFromStream(vStream);
            try
              KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Picture.Assign(vMenuImage);
            finally
              vStream.Free;
              vMenuImage.Free;
            end;
          end
          else
            KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Picture.Assign(Order_F.ImageCollection.Items.Items[8].Picture.Graphic);

          vLeft := vLeft + 60;
        end;
        //메뉴명
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName                  := TcxLabel.Create(Self);
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Parent           := KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox;
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Align            := alNone;
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.AutoSize         := false;
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Style.Font.Name  := Common.Config.KioskDefaultFontName;
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Style.TextColor  := vFontColor;
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Style.Font.Size  := 25;
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Transparent      := true;
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Caption          := Common.GetPaPago(DM.Query.FieldByName('NM_MENU_SHORT').AsString);
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Hint             := DM.Query.FieldByName('NM_MENU_SHORT').AsString;
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Top              := vItemTop;
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Left             := vLeft;
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Height           := vHeight;
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Width            := Trunc(KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox.Width * 0.7) - vHeight;
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Properties.WordWrap := true;
        if KioskCourse[vIndex].ChooseType = 'C' then
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.OnClick := CheckBoxClick
        else
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.OnClick := RadioBoxClick;


        //단가
        vLeft := vLeft + Trunc(KioskCourse[vIndex].GroupBox.Width * 0.7);
        vLeft := vLeft + Trunc(KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox.Width * 0.7);
        KioskCourse[vIndex].MenuInfo[vIndex2].Price                  := TcxLabel.Create(Self);
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Parent           := KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox;
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Align            := alNone;
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.AutoSize         := false;
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Style.Font.Name  := Common.Config.KioskDefaultFontName;
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Style.TextColor  := vFontColor;
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Style.Font.Size  := 25;
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Style.Font.Style := [fsBold];
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Properties.Alignment.Horz := taRightJustify;
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Transparent      := true;
        if GetOption(23)='1' then
          KioskCourse[vIndex].MenuInfo[vIndex2].Price.Caption          := Ifthen(DM.Query.FieldByName('PR_SALE').AsInteger=0,'', FormatFloat('￦,0',DM.Query.FieldByName('PR_SALE').AsInteger))
        else
          KioskCourse[vIndex].MenuInfo[vIndex2].Price.Caption          := '';//FormatFloat(',0원',0);
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Top              := vItemTop;
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Left             := 750;//vLeft;
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Height           := vHeight;
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Width            := 200;//KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox.Width - vLeft;
      end
      else if KioskCourse[vIndex].ChooseType = 'Q' then
      begin
        // - 이미지
        KioskCourse[vIndex].MenuInfo[vIndex2].Control2Image                  := TAdvSmoothButton.Create(Self);
        KioskCourse[vIndex].MenuInfo[vIndex2].Control2Image.Parent           := KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox;
        KioskCourse[vIndex].MenuInfo[vIndex2].Control2Image.Top              := 12;
        KioskCourse[vIndex].MenuInfo[vIndex2].Control2Image.Left             := vLeft;
        KioskCourse[vIndex].MenuInfo[vIndex2].Control2Image.Width            := 40;
        KioskCourse[vIndex].MenuInfo[vIndex2].Control2Image.Height           := 40;
        KioskCourse[vIndex].MenuInfo[vIndex2].Control2Image.Appearance.PictureAlignment := taCenter;
        KioskCourse[vIndex].MenuInfo[vIndex2].Control2Image.Appearance.SimpleLayout := true;
        KioskCourse[vIndex].MenuInfo[vIndex2].Control2Image.Color            := clWhite;
        KioskCourse[vIndex].MenuInfo[vIndex2].Control2Image.Tag              := -1;
        KioskCourse[vIndex].MenuInfo[vIndex2].Control2Image.Hint             := IntToStr(vIndex);
        KioskCourse[vIndex].MenuInfo[vIndex2].Control2Image.Picture.Assign(QtyImageCollection.Items[GetImageIndex(1)].Picture.Graphic);
        KioskCourse[vIndex].MenuInfo[vIndex2].Control2Image.OnClick          := QtyButtonClick;
        KioskCourse[vIndex].MenuInfo[vIndex2].Control2Image.Name             := Format('DecQty%d_%d',[vIndex,vIndex2]);

        //수량
        vLeft := vLeft + 50;
        KioskCourse[vIndex].MenuInfo[vIndex2].OrderQty                  := TcxLabel.Create(Self);
        KioskCourse[vIndex].MenuInfo[vIndex2].OrderQty.Parent           := KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox;
        KioskCourse[vIndex].MenuInfo[vIndex2].OrderQty.Align            := alNone;
        KioskCourse[vIndex].MenuInfo[vIndex2].OrderQty.AutoSize         := false;
        KioskCourse[vIndex].MenuInfo[vIndex2].OrderQty.Name             := Format('OrderQty%d_%d',[vIndex,vIndex2]);
        KioskCourse[vIndex].MenuInfo[vIndex2].OrderQty.Style.Font.Name  := Common.Config.KioskDefaultFontName;
        KioskCourse[vIndex].MenuInfo[vIndex2].OrderQty.Style.TextColor  := vFontColor;
        KioskCourse[vIndex].MenuInfo[vIndex2].OrderQty.Style.Font.Size  := 25;
        KioskCourse[vIndex].MenuInfo[vIndex2].OrderQty.Style.TextStyle  := [fsBold];
        KioskCourse[vIndex].MenuInfo[vIndex2].OrderQty.Properties.Alignment.Horz := TcxEditHorzAlignment.taCenter;
        KioskCourse[vIndex].MenuInfo[vIndex2].OrderQty.Transparent      := true;
        KioskCourse[vIndex].MenuInfo[vIndex2].OrderQty.Caption          := '0';
        KioskCourse[vIndex].MenuInfo[vIndex2].OrderQty.Top              := vItemTop;
        KioskCourse[vIndex].MenuInfo[vIndex2].OrderQty.Left             := vLeft-3;
        KioskCourse[vIndex].MenuInfo[vIndex2].OrderQty.Height           := vHeight;
        KioskCourse[vIndex].MenuInfo[vIndex2].OrderQty.Width            := 50;
        KioskCourse[vIndex].MenuInfo[vIndex2].OrderQty.Tag              := 0;
        KioskCourse[vIndex].MenuInfo[vIndex2].OrderQty.Hint             := 'Qty';

        // + 이미지
        vLeft := vLeft + 50;
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage                  := TAdvSmoothButton.Create(Self);
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Parent           := KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox;
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Top              := 12;
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Left             := vLeft;
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Width            := 40;
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Height           := 40;
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Appearance.PictureAlignment := taCenter;
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Appearance.SimpleLayout := true;
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Color            := clWhite;
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Tag              := 1;
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Hint             := IntToStr(vIndex);
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Picture.Assign(QtyImageCollection.Items[GetImageIndex(0)].Picture.Graphic);
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.OnClick          := QtyButtonClick;
        KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Name             := Format('AddQty%d_%d',[vIndex,vIndex2]);

        vLeft := vLeft + 50;
        if ImageView = 'Y' then
        begin
          //메뉴이미지
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage                  := TcxImage.Create(Self);
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Parent           := KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox;
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Top              := vItemTop-5;
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Left             := vLeft;
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Width            := vHeight;
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Height           := vHeight;
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Style.BorderStyle := ebsNone;
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Properties.FitMode := ifmStretch;
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Properties.GraphicClassName := 'TdxPNGImage';
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Visible          := true;
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Transparent      := true;
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Tag              := vIndex;
          if KioskCourse[vIndex].ChooseType = 'C' then
            KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.OnClick          := CheckBoxClick
          else
            KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.OnClick          := RadioBoxClick;

          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Properties.PopupMenuLayout.MenuItems := [];
          KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Properties.ShowFocusRect := false;

          if DM.Query.FieldByName('IMG_MENU').AsString <> '' then
          begin
            vMenuImage   := TPNGImage.Create;
            vStream := DM.Query.CreateBLOBStream(DM.Query.FieldByName('IMG_MENU'), bmRead);
            vMenuImage.LoadFromStream(vStream);
            try
              KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Picture.Assign(vMenuImage);
            finally
              vStream.Free;
              vMenuImage.Free;
            end;
          end
          else
            KioskCourse[vIndex].MenuInfo[vIndex2].MenuImage.Picture.Assign(Order_F.ImageCollection.Items.Items[8].Picture.Graphic);

          vLeft := vLeft + 60;
        end;

        //메뉴명
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName                  := TcxLabel.Create(Self);
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Parent           := KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox;
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Align            := alNone;
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.AutoSize         := false;
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Style.Font.Name  := Common.Config.KioskDefaultFontName;
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Style.TextColor  := vFontColor;
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Style.Font.Size  := 25;
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Transparent      := true;
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Caption          := Common.GetPaPago(DM.Query.FieldByName('NM_MENU_SHORT').AsString);
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Hint             := DM.Query.FieldByName('NM_MENU_SHORT').AsString;
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Top              := vItemTop;
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Left             := vLeft;
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Height           := vHeight;
        KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Width            := Trunc(KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox.Width * 0.7) - vHeight;

        //단가
        vLeft := vLeft + Trunc(KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox.Width * 0.7);
        KioskCourse[vIndex].MenuInfo[vIndex2].Price                  := TcxLabel.Create(Self);
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Parent           := KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox;
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Align            := alNone;
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.AutoSize         := false;
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Style.Font.Name  := Common.Config.KioskDefaultFontName;
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Style.TextColor  := vFontColor;
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Style.Font.Size  := 25;
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Style.Font.Style := [fsBold];
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Properties.Alignment.Horz := taRightJustify;
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Transparent      := true;
        if GetOption(23)='1' then
          KioskCourse[vIndex].MenuInfo[vIndex2].Price.Caption          := Ifthen(DM.Query.FieldByName('PR_SALE').AsInteger=0,'', FormatFloat('￦,0',DM.Query.FieldByName('PR_SALE').AsInteger))
        else
          KioskCourse[vIndex].MenuInfo[vIndex2].Price.Caption          := '';//FormatFloat(',0원',0);
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Top              := vItemTop;
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Left             := 750;//vLeft;
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Height           := vHeight;
        KioskCourse[vIndex].MenuInfo[vIndex2].Price.Width            := 200;//KioskCourse[vIndex].MenuInfo[vIndex2].GroupBox.Width - vLeft;
      end;
      KioskCourse[vIndex].MenuInfo[vIndex2].MenuCode := DM.Query.FieldByName('CD_MENU').AsString;
      KioskCourse[vIndex].MenuInfo[vIndex2].PrintMenuName             := DM.Query.FieldByName('NM_MENU_KITCHEN').AsString;
     // 세트,코스,오픈세트 출력 시 부메뉴를 설정 주방으로 출력합니다.
      if GetOption(241) = '0' then
        KioskCourse[vIndex].MenuInfo[vIndex2].KitchenCode := DM.Query.FieldByName('CD_PRINTER').AsString
      else
        KioskCourse[vIndex].MenuInfo[vIndex2].KitchenCode := DM.Query.FieldByName('CD_PRINTER1').AsString;

      if GetOption(23)='0' then
        KioskCourse[vIndex].MenuInfo[vIndex2].OrderPrice  := 0
      else
        KioskCourse[vIndex].MenuInfo[vIndex2].OrderPrice  := DM.Query.FieldByName('PR_SALE').AsInteger;
      DM.Query.Next;

      KioskCourse[vIndex].GroupBox.Height  := vTop + 100;       //다음 그룹과 Gap
      KioskCourse[vIndex].GroupBox.Tag     := KioskCourse[vIndex].GroupBox.Height;
      Inc(vIndex2);
    end;
    //Self.ClientHeight 값을 알기위해서
    vTotalHeight := vTotalHeight + KioskCourse[vIndex].GroupBox.Height;
    DM.Query.Close;
  end;

  if (Self.Height - 500) > vTotalHeight then
    Self.ClientHeight := vTotalHeight + 500;


  OrderButton.Caption  := Common.GetPaPago('주문완료');
  CancelButton.Caption := Common.GetPaPago('처음으로');
  OrderButton.BringToFront;
  CancelButton.BringToFront;
end;

procedure TKioskCourse2_F.OrderButtonClick(Sender: TObject);
var vIndex, vIndex2, vStep, vCount, vCourseIndex :Integer;
    vOrderLog :String;
begin
  Common.KioskTouchBeep('kioskwave12');
  if MilliSecondsBetween(Now(),ClickTime) < 500 then Exit;
  ClickTime := Now;
  if not IsDebuggerPresent then
    BlockInput(true);
  try
    Common.WriteLog('work', 'Kiosk-Course2-주문완료');
    //필수선택여부 체크
    for vIndex := 0 to High(KioskCourse) do
    begin
      if KioskCourse[vIndex].ChooseType = 'R' then
      begin
        vCount := 0;
        for vIndex2 := 0 to High(KioskCourse[vIndex].MenuInfo) do
        begin
          if KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Tag = 1 then
            Inc(vCount);
        end;

        if vCount = 0 then
        begin
          Common.MsgBox(Format('%s'#13'옵션이 선택되지 않았습니다',[KioskCourse[vIndex].GroupBox.Hint]));
          Exit;
        end;
      end;
    end;

    //선택코스 전체를 카운팅한다
    vCount := 0;
    for vIndex := 0 to High(KioskCourse) do
    begin
      if KioskCourse[vIndex].ChooseType = 'R' then
        Inc(vCount)
      else if KioskCourse[vIndex].ChooseType = 'C' then
      begin
        for vIndex2 := 0 to High(KioskCourse[vIndex].MenuInfo) do
        begin
          if KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Tag = 1 then
            Inc(vCount);
        end;
      end
      else if KioskCourse[vIndex].ChooseType = 'Q' then
      begin
        for vIndex2 := 0 to High(KioskCourse[vIndex].MenuInfo) do
        begin
          if StrToIntDef(KioskCourse[vIndex].MenuInfo[vIndex2].OrderQty.Caption,0) > 0 then
            vCount := vCount + StrToIntDef(KioskCourse[vIndex].MenuInfo[vIndex2].OrderQty.Caption,0);
        end;
      end;
    end;
    vOrderLog := '';
    SetLength(OrderCourseMenu, vCount);
    vCourseIndex := -1;
    vStep := 1;
    for vIndex := 0 to High(KioskCourse) do
    begin
      if KioskCourse[vIndex].ChooseType = 'R' then
      begin
        Inc(vCourseIndex);
        New(OrderCourseMenu[vCourseIndex]);
        OrderCourseMenu[vCourseIndex]^.Step         := vStep;
        Inc(vStep);
        for vIndex2 := 0 to High(KioskCourse[vIndex].MenuInfo) do
        begin
          if KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Tag = 1 then
          begin
            OrderCourseMenu[vCourseIndex]^.MenuName     := KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Hint;
            OrderCourseMenu[vCourseIndex]^.MenuCode     := KioskCourse[vIndex].MenuInfo[vIndex2].MenuCode;
            OrderCourseMenu[vCourseIndex]^.OrderQty     := 1;
            OrderCourseMenu[vCourseIndex]^.OrderPrice   := KioskCourse[vIndex].MenuInfo[vIndex2].OrderPrice;
            OrderCourseMenu[vCourseIndex]^.KitchenCode  := KioskCourse[vIndex].MenuInfo[vIndex2].KitchenCode;
            OrderCourseMenu[vCourseIndex]^.PrintMenuName := KioskCourse[vIndex].MenuInfo[vIndex2].PrintMenuName;
            Common.CourseOrderMenu.Add(OrderCourseMenu[vCourseIndex]);
          end;
        end;
      end
      else if KioskCourse[vIndex].ChooseType = 'C' then
      begin
        for vIndex2 := 0 to High(KioskCourse[vIndex].MenuInfo) do
        begin
          if KioskCourse[vIndex].MenuInfo[vIndex2].ControlImage.Tag = 1 then
          begin
            Inc(vCourseIndex);
            New(OrderCourseMenu[vCourseIndex]);
            OrderCourseMenu[vCourseIndex]^.Step         := vStep;
            Inc(vStep);
            OrderCourseMenu[vCourseIndex]^.MenuName     := KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Hint;
            OrderCourseMenu[vCourseIndex]^.MenuCode     := KioskCourse[vIndex].MenuInfo[vIndex2].MenuCode;
            OrderCourseMenu[vCourseIndex]^.OrderQty     := 1;
            OrderCourseMenu[vCourseIndex]^.OrderPrice   := KioskCourse[vIndex].MenuInfo[vIndex2].OrderPrice;
            OrderCourseMenu[vCourseIndex]^.KitchenCode  := KioskCourse[vIndex].MenuInfo[vIndex2].KitchenCode;
            OrderCourseMenu[vCourseIndex]^.PrintMenuName  := KioskCourse[vIndex].MenuInfo[vIndex2].PrintMenuName;
            Common.CourseOrderMenu.Add(OrderCourseMenu[vCourseIndex]);
          end;
        end;
      end
      else if KioskCourse[vIndex].ChooseType = 'Q' then
      begin
        for vIndex2 := 0 to High(KioskCourse[vIndex].MenuInfo) do
        begin
          if StrToIntDef(KioskCourse[vIndex].MenuInfo[vIndex2].OrderQty.Caption,0) > 0 then
          begin
            Inc(vCourseIndex);
            New(OrderCourseMenu[vCourseIndex]);
            OrderCourseMenu[vCourseIndex]^.Step         := vStep;
            Inc(vStep);
            OrderCourseMenu[vCourseIndex]^.MenuName     := KioskCourse[vIndex].MenuInfo[vIndex2].MenuName.Hint;
            OrderCourseMenu[vCourseIndex]^.MenuCode     := KioskCourse[vIndex].MenuInfo[vIndex2].MenuCode;
            OrderCourseMenu[vCourseIndex]^.OrderQty     := StrToIntDef(KioskCourse[vIndex].MenuInfo[vIndex2].OrderQty.Caption,0);
            OrderCourseMenu[vCourseIndex]^.OrderPrice   := KioskCourse[vIndex].MenuInfo[vIndex2].OrderPrice;
            OrderCourseMenu[vCourseIndex]^.KitchenCode  := KioskCourse[vIndex].MenuInfo[vIndex2].KitchenCode;
            OrderCourseMenu[vCourseIndex]^.PrintMenuName  := KioskCourse[vIndex].MenuInfo[vIndex2].PrintMenuName;
            Common.CourseOrderMenu.Add(OrderCourseMenu[vCourseIndex]);
          end;
        end;
      end;
    end;
    Common.WriteLog('work', vOrderLog);
    ModalResult := mrOK;
  finally
    BlockInput(false);
  end;
end;

procedure TKioskCourse2_F.btnAddClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  lblQty.Tag     := lblQty.Tag + 1;
  lblQty.Caption := IntToStr(lblQty.Tag);
end;

procedure TKioskCourse2_F.btnDecClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  if lblQty.Tag = 1 then Exit;
  lblQty.Tag     := lblQty.Tag - 1;
  lblQty.Caption := IntToStr(lblQty.Tag);
end;

procedure TKioskCourse2_F.CheckBoxClick(Sender: TObject);
var vIndex, vIndex2, vGroupIndex, vCount :Integer;
    vButton :TAdvSmoothButton;
    vPanel  :TPanel;
begin
  if MilliSecondsBetween(Now(),ClickTime) < 300 then Exit;
  Common.KioskTouchBeep('kioskwave12');
  ClickTime := Now;
  BlockInput(true);
  try

    if (Sender is TcxLabel) then
    begin
      vPanel := TPanel((Sender as TcxLabel).Parent);
      for vIndex := 0 to vPanel.ControlCount-1 do
      begin
        if (vPanel.Controls[vIndex] is TAdvSmoothButton) then
        begin
          vButton := TAdvSmoothButton(vPanel.Controls[vIndex]);
          Break;
        end;
      end;
    end
    else if (Sender is TcxImage) then
    begin
      vPanel := TPanel((Sender as TcxImage).Parent);
      for vIndex := 0 to vPanel.ControlCount-1 do
      begin
        if (vPanel.Controls[vIndex] is TAdvSmoothButton) then
        begin
          vButton := TAdvSmoothButton(vPanel.Controls[vIndex]);
          Break;
        end;
      end;
    end
    else
      vButton := (Sender as TAdvSmoothButton);

    if vButton.Tag = 0 then
    begin
      //선택가능수량 체크
      vGroupIndex := StrToInt(vButton.Hint);
      if KioskCourse[vGroupIndex].ChooseQty > 0 then
      begin
        vCount      := 0;
        for vIndex := 0 to KioskCourse[vGroupIndex].GroupBox.ControlCount-1 do
        begin
          if KioskCourse[vGroupIndex].GroupBox.Controls[vIndex] is TPanel then
          begin
            for vIndex2 := 0 to TPanel(KioskCourse[vGroupIndex].GroupBox.Controls[vIndex]).ControlCount-1 do
            begin
              if (TPanel(KioskCourse[vGroupIndex].GroupBox.Controls[vIndex]).Controls[vIndex2] is TAdvSmoothButton) and (((TPanel(KioskCourse[vGroupIndex].GroupBox.Controls[vIndex]).Controls[vIndex2]) as TAdvSmoothButton).Tag = 1) then
                Inc(vCount);
            end;
          end;
        end;

        if vCount = KioskCourse[vGroupIndex].ChooseQty then
        begin
          Common.MsgBox(Format('최대 %d 까지 선택 가능합니다',[vCount]));
          Exit;
        end;
      end;

      vButton.Picture.Assign(CheckBoxImageCollection.Items[GetImageIndex(1)].Picture.Graphic);
      Sleep(3);
      vButton.Tag := 1;
    end
    else
    begin
      vButton.Picture.Assign(CheckBoxImageCollection.Items[GetImageIndex(0)].Picture.Graphic);
      Sleep(3);
      vButton.Tag := 0;
    end;
  finally
    BlockInput(false);
  end;
end;

procedure TKioskCourse2_F.CloseTimerTimer(Sender: TObject);
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

procedure TKioskCourse2_F.RadioBoxClick(Sender: TObject);
var vIndex, vIndex2, vGroupIndex, vCount :Integer;
    vButton :TAdvSmoothButton;
    vPanel  :TPanel;
begin
  if MilliSecondsBetween(Now(),ClickTime) < 300 then Exit;
  Common.KioskTouchBeep('kioskwave12');
  ClickTime := Now;
  BlockInput(true);
  try
    if (Sender is TcxLabel) then
    begin
      vPanel := TPanel((Sender as TcxLabel).Parent);
      for vIndex := 0 to vPanel.ControlCount-1 do
      begin
        if (vPanel.Controls[vIndex] is TAdvSmoothButton) then
        begin
          vButton := TAdvSmoothButton(vPanel.Controls[vIndex]);
          Break;
        end;
      end;
    end
    else if (Sender is TcxImage) then
    begin
      vPanel := TPanel((Sender as TcxImage).Parent);
      for vIndex := 0 to vPanel.ControlCount-1 do
      begin
        if (vPanel.Controls[vIndex] is TAdvSmoothButton) then
        begin
          vButton := TAdvSmoothButton(vPanel.Controls[vIndex]);
          Break;
        end;
      end;
    end
    else
      vButton := (Sender as TAdvSmoothButton);

    if vButton.Tag = 0 then
    begin
      vGroupIndex := StrToInt(vButton.Hint);
      for vIndex := 0 to KioskCourse[vGroupIndex].GroupBox.ControlCount-1 do
      begin
        if KioskCourse[vGroupIndex].GroupBox.Controls[vIndex] is TPanel then
        begin
          for vIndex2 := 0 to TPanel(KioskCourse[vGroupIndex].GroupBox.Controls[vIndex]).ControlCount-1 do
          begin
            if TPanel(KioskCourse[vGroupIndex].GroupBox.Controls[vIndex]).Controls[vIndex2] is TAdvSmoothButton then
            begin
              TAdvSmoothButton(TPanel(KioskCourse[vGroupIndex].GroupBox.Controls[vIndex]).Controls[vIndex2]).Picture.Assign(RadioImageCollection.Items[GetImageIndex(0)].Picture.Graphic);
              TAdvSmoothButton(TPanel(KioskCourse[vGroupIndex].GroupBox.Controls[vIndex]).Controls[vIndex2]).Tag := 0;
            end;
          end;
        end;
      end;
      vButton.Picture.Assign(RadioImageCollection.Items[GetImageIndex(1)].Picture.Graphic);
      vButton.Tag := 1;
    end
    else
    begin
      Exit;
      vCount := 0;
      vGroupIndex := StrToInt(vButton.Hint);
      for vIndex := 0 to KioskCourse[vGroupIndex].GroupBox.ControlCount-1 do
      begin
        if KioskCourse[vGroupIndex].GroupBox.Controls[vIndex] is TPanel then
        begin
          for vIndex2 := 0 to TPanel(KioskCourse[vGroupIndex].GroupBox.Controls[vIndex]).ControlCount-1 do
          begin
            if TPanel(KioskCourse[vGroupIndex].GroupBox.Controls[vIndex]).Controls[vIndex2] is TAdvSmoothButton then
            begin
              if TAdvSmoothButton(TPanel(KioskCourse[vGroupIndex].GroupBox.Controls[vIndex]).Controls[vIndex2]).Tag = 1 then
                Inc(vCount);
            end;
          end;
        end;
      end;

      if vCount = 1 then Exit;

      vButton.Picture.Assign(RadioImageCollection.Items[GetImageIndex(0)].Picture.Graphic);
      vButton.Tag := 0;
    end;
  finally
    BlockInput(false);
  end;
end;

procedure TKioskCourse2_F.QtyButtonClick(Sender: TObject);
var vIndex, vIndex2, vGroupIndex, vCount :Integer;
    vPanel :TPanel;
    vName :String;
begin
  //최대 수량체크
  Common.KioskTouchBeep('kioskwave12');
  BlockInput(true);
  try
    if (Sender as TAdvSmoothButton).Tag = 1 then
    begin
      vGroupIndex := StrToInt((Sender as TAdvSmoothButton).Hint);
      if KioskCourse[vGroupIndex].ChooseQty > 0 then
      begin
        vCount := 0;
        for vIndex := 0 to KioskCourse[vGroupIndex].GroupBox.ControlCount-1 do
        begin
          if KioskCourse[vGroupIndex].GroupBox.Controls[vIndex] is TPanel then
          begin
            for vIndex2 := 0 to TPanel(KioskCourse[vGroupIndex].GroupBox.Controls[vIndex]).ControlCount-1 do
            begin
              if (TPanel(KioskCourse[vGroupIndex].GroupBox.Controls[vIndex]).Controls[vIndex2] is TcxLabel) and ((TPanel(KioskCourse[vGroupIndex].GroupBox.Controls[vIndex]).Controls[vIndex2] as TcxLabel).Hint = 'Qty') then
                vCount := vCount + StrToIntDef((TPanel(KioskCourse[vGroupIndex].GroupBox.Controls[vIndex]).Controls[vIndex2] as TcxLabel).Caption,0);
            end;
          end;
        end;

        if vCount = KioskCourse[vGroupIndex].ChooseQty then
        begin
          Common.MsgBox(Format('최대 %d 까지 선택 가능합니다',[vCount]));
          Exit;
        end;
      end;
    end;

    vPanel := TPanel((Sender as TAdvSmoothButton).Parent);
    for vIndex := 0 to vPanel.ControlCount-1 do
    begin
      if (vPanel.Controls[vIndex] is TcxLabel) and ((vPanel.Controls[vIndex] as TcxLabel).Hint = 'Qty') then
      begin
        if StrToIntDef((vPanel.Controls[vIndex] as TcxLabel).Caption,0) + (Sender as TAdvSmoothButton).Tag >= 0 then
        begin
          (vPanel.Controls[vIndex] as TcxLabel).Caption := IntToStr(StrToIntDef((vPanel.Controls[vIndex] as TcxLabel).Caption,0) + (Sender as TAdvSmoothButton).Tag);
        end;
      end;
    end;
  finally
    BlockInput(false);
  end;
end;

function TKioskCourse2_F.GetImageIndex(aIndex:Integer): Integer;
begin
  if ItemIconColor = '' then
  begin
    if (GetOption(458) = '2') then  //Black
      Result := Ifthen(aIndex=0,2,3)
    else if (GetOption(458) = '3') then  //Red
      Result := Ifthen(aIndex=0,4,5)
    else if (GetOption(458) = '4') then  //Green
      Result := Ifthen(aIndex=0,6,7)
    else
      Result := Ifthen(aIndex=0,0,1);
  end
  else
  begin
    if (ItemIconColor = 'clBlack') then  //Black
      Result := Ifthen(aIndex=0,2,3)
    else if (ItemIconColor = 'clRed') then  //Red
      Result := Ifthen(aIndex=0,4,5)
    else if (ItemIconColor = 'clGreen') then  //Green
      Result := Ifthen(aIndex=0,6,7)
    else
      Result := Ifthen(aIndex=0,0,1);
  end;
end;

end.
