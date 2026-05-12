unit MenuAdd_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Keyboard_U, cxCheckListBox, cxCheckBox, cxCurrencyEdit, cxLabel,
  cxControls, cxContainer, cxEdit, cxTextEdit, ExtCtrls, StdCtrls,
  Menus, cxLookAndFeelPainters, cxButtons,
  StrUtils, cxGraphics, cxMaskEdit, cxDropDownEdit, cxLookAndFeels,
  cxGroupBox, Math, AdvGlassButton, PosButton, dxGDIPlusClasses, Vcl.WinXCtrls,
  AdvSmoothButton, cxCustomListBox, cxMemo, AdvPanel;
type
  TMenuAdd_F = class(TKeyboard_F)
    edt_MenuName: TcxTextEdit;
    lbl_MenuCode: TcxLabel;
    lblMenuCode: TcxLabel;
    lblMenuName: TcxLabel;
    lblSalePrice: TcxLabel;
    lbkKitchen: TcxLabel;
    edt_MenuPrice: TcxCurrencyEdit;
    KitchenCheckListBox: TcxCheckListBox;
    lblMenuClass: TcxLabel;
    cbo_MenuClass: TcxComboBox;
    PluPanel: TcxGroupBox;
    panClass: TPanel;
    Label5: TLabel;
    Label1: TLabel;
    ClassPage: TcxCurrencyEdit;
    panMenu: TPanel;
    Label7: TLabel;
    MenuPage: TcxCurrencyEdit;
    Label2: TcxLabel;
    lbl_Msg: TLabel;
    Image3: TImage;
    MenuTypeLabel: TcxLabel;
    ClassPanel: TPanel;
    MenuPanel: TPanel;
    DcSwitch: TToggleSwitch;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    TaxSwithLabel: TcxLabel;
    cxLabel4: TcxLabel;
    PointSwitch: TToggleSwitch;
    TaxSwitch: TToggleSwitch;
    SoldOutSwitch: TToggleSwitch;
    SaveButton: TAdvSmoothButton;
    BageLabel: TcxLabel;
    BageComboBox: TcxComboBox;
    MenuInfoPanel: TAdvPanel;
    MenuInfoMemo: TcxMemo;
    MenuInfoSaveButton: TAdvSmoothButton;
    MenuInfoCancelButton: TAdvSmoothButton;
    MenuInfoButton: TAdvSmoothButton;
    KeyPadButton: TAdvSmoothButton;
    procedure obtn_closeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MenuInfoButtonClick(Sender: TObject);
    procedure MenuInfoCancelButtonClick(Sender: TObject);
    procedure MenuInfoSaveButtonClick(Sender: TObject);
    procedure KeyPadButtonClick(Sender: TObject);
  private
    ////////////////  PLU 관련 //////////////
    ClassButton :TPosButton;
    MenuButton  :TPosButton;

    ClassDefaultColor,                       //기본설정값
    ClassBorderColor,
    ClassDefaultDownColor,
    MenuDefaultColor,
    MenuBorderColor :TColor;
    ClassDefaultFont,
    MenuDefaultFont : TFont;
    ClassDefaultDownFontColor :TColor;
    ColorClipboard : TColor;

    PluClassX,
    PluClassY      : Integer;
    PluClassButton :Array of TPosButton;

    PluMenuX,
    PluMenuY      :Integer;
    PluMenuButton :Array of TPosButton;

    ClassCode   :String;
    PluPosition :Integer;

    isStandardPLU : Boolean;

    MenuConfig :String;
    procedure  PluClassButtonCreate;
    procedure  PluClassButtonClick(Sender: TObject);
    procedure  PluClassPrevButtonClick(Sender :TObject);

    procedure  PluMenuButtonCreate;
    procedure  PluMenuButtonClick(Sender: TObject);
    procedure  PluMenuPrevButtonClick(Sender :TObject);
    procedure  PluMenuButtonClear;
    procedure  ShowPosMode;

    procedure SetClassButton;
    procedure SetMenuButton;

    function  GetMenuCode: String;
    procedure ScannerReadEvent(const S : String);
  public
    isMenuAdd :Boolean;
    isSetSoldOut :Boolean;
    WorkPluNo :String;
  end;

var
  MenuAdd_F: TMenuAdd_F;

implementation
uses Common_U, GlobalFunc_U, DBModule_U, Const_U, DB;
{$R *.dfm}

procedure TMenuAdd_F.FormCreate(Sender: TObject);
var vIndex :Integer;
    vCode: PStrPointer;
begin
  inherited;
  Common.LogoCreate(Self,2);
  for vIndex := 0 to ComponentCount-1 do
    if Components[vIndex] is TAdvGlassButton then
      Common.SetButtonColor((Components[vIndex] as TAdvGlassButton));

  for vIndex := 0 to ComponentCount-1 do
    if Components[vIndex] is TAdvSmoothButton then
      Common.SetButtonColor((Components[vIndex] as TAdvSmoothButton));

  isSetSoldOut     := false;
  isStandardPLU    := GetHeadOption(2) = '1';
  ClassDefaultFont := TFont.Create;
  MenuDefaultFont  := TFont.Create;
  OnShow := FormShow;
  //푸드기능을 사용하지 않을때는 주방에 매입처를 표시한다
  if GetOption(254) = '1' then
  begin
    lbkKitchen.Visible          := false;
    KitchenCheckListBox.Visible := false;
  end;

  BageComboBox.Properties.Items.Clear;
  New(vCode);
  vCode^.Data := '0';
  BageComboBox.Properties.Items.AddObject('없음', TObject(vCode));
  New(vCode);
  vCode^.Data := 'R';
  BageComboBox.Properties.Items.AddObject('추천', TObject(vCode));
  New(vCode);
  vCode^.Data := 'H';
  BageComboBox.Properties.Items.AddObject('Hot', TObject(vCode));
  New(vCode);
  vCode^.Data := 'N';
  BageComboBox.Properties.Items.AddObject('신메뉴', TObject(vCode));
  New(vCode);
  vCode^.Data := 'T';
  BageComboBox.Properties.Items.AddObject('HIT', TObject(vCode));
end;

procedure TMenuAdd_F.obtn_closeClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TMenuAdd_F.FormShow(Sender: TObject);
var vIndex :Integer;
begin
  inherited;
  try
    OpenQuery('select CD_CODE, '
             +'       NM_CODE1, '
             +'       NM_CODE2, '
             +'       NM_CODE3, '
             +'       NM_CODE4, '
             +'       NM_CODE5, '
             +'       NM_CODE6, '
             +'       NM_CODE7, '
             +'       NM_CODE8, '
             +'       NM_CODE9, '
             +'       NM_CODE11, '
             +'       NM_CODE12, '
             +'       NM_CODE13 '
             +'  from MS_CODE '
             +' where CD_STORE = :P0 '
             +'   and CD_KIND  = ''87'' '
             +'   and CD_CODE  in (''001'',''002'') '
             +' order by CD_CODE ',
             [Common.Config.StoreCode]);
    while not Common.Query.Eof do
    begin
      if Common.Query.FieldByName('CD_CODE').AsString = '001' then
      begin
        PluClassX              := StrToIntDef(Common.Query.FieldByName('NM_CODE1').AsString,5);
        PluClassY              := StrToIntDef(Common.Query.FieldByName('NM_CODE2').AsString,2);

        ClassDefaultColor      := StringToColor(Common.Query.FieldByName('NM_CODE3').AsString);
        ClassDefaultFont.Name  := Common.Query.FieldByName('NM_CODE5').AsString;
        ClassDefaultFont.Color := StringToColor(Common.Query.FieldByName('NM_CODE8').AsString);
        ClassDefaultFont.Size  := StrToIntDef(Common.Query.FieldByName('NM_CODE6').AsString,10);
        ClassBorderColor       := StringToColor(Common.Query.FieldByName('NM_CODE13').AsString);
        if Common.Query.FieldByName('NM_CODE7').AsString  = '1' then
          ClassDefaultFont.Style := [fsBold];

        ClassDefaultDownColor     := StringToColor(Common.Query.FieldByName('NM_CODE4').AsString);
        ClassDefaultDownFontColor := StringToColor(Common.Query.FieldByName('NM_CODE9').AsString);
        ClassPanel.Height         := StrToIntDef(Common.Query.FieldByName('NM_CODE11').AsString,100);
        if ClassPanel.Height < 110 then
          ClassPanel.Height := 110;
      end
      else if Common.Query.FieldByName('CD_CODE').AsString = '002' then
      begin
        PluMenuX              := StrToIntDef(Common.Query.FieldByName('NM_CODE1').AsString,5);
        PluMenuY              := StrToIntDef(Common.Query.FieldByName('NM_CODE2').AsString,5);
        MenuDefaultColor      := StringToColor(Common.Query.FieldByName('NM_CODE3').AsString);
        MenuDefaultFont.Name  := Common.Query.FieldByName('NM_CODE4').AsString;
        MenuDefaultFont.Color := StringToColor(Common.Query.FieldByName('NM_CODE7').AsString);
        MenuDefaultFont.Size  := StrToIntDef(Common.Query.FieldByName('NM_CODE5').AsString,10);
        MenuBorderColor       := StringToColor(Common.Query.FieldByName('NM_CODE13').AsString);
        if Common.Query.FieldByName('NM_CODE6').AsString  = '1' then
          ClassDefaultFont.Style := [fsBold];
      end;
      Common.Query.Next;
    end;
  finally
    Common.Query.Close;
  end;

  if Common.Config.IsKiosk then
  begin
    OpenQuery('select NM_CODE3, '
             +'       NM_CODE4, '
             +'       NM_CODE5 '
             +'  from MS_CODE '
             +' where CD_STORE = :P0 '
             +'   and CD_KIND  = ''84'' '
             +' order by CD_CODE ',
             [Common.Config.StoreCode]);
    if not Common.Query.Eof then
    begin
      PluClassX   := StrToIntDef(Common.Query.FieldByName('NM_CODE3').AsString,5);
      PluClassY   := 1;
      PluMenuX    := StrToIntDef(Common.Query.FieldByName('NM_CODE4').AsString,5);
      PluMenuY    := StrToIntDef(Common.Query.FieldByName('NM_CODE5').AsString,5);
    end;
    Common.Query.Close;
  end;

  PluPanel.Top  := 60;
  PluPanel.Left := 23;

  PluClassButtonCreate;
  PluMenuButtonCreate;
  SetClassButton;
  PluClassButtonClick(TPosButton(FindComponent('ClassButton0')));

  //분류셋팅
  OpenQuery('select ConCat(CD_CLASS,''-'',NM_CLASS) as NM_CLASS '
           +'  from MS_MENU_CLASS '
           +' where CD_STORE  =:P0 '
           +'   and Length(CD_CLASS) = 2 '
           +' order by CD_CLASS ',
           [Common.Config.StoreCode]);
  cbo_MenuClass.Properties.Items.Clear;
  while not Common.Query.Eof do
  begin
    cbo_MenuClass.Properties.Items.Add(Common.Query.Fields[0].AsString);
    Common.Query.Next;
  end;
  Common.Query.Close;
  cbo_MenuClass.ItemIndex := 0;

  //주방프린터 셋팅
  OpenQuery('select ConCat(CD_CODE,''-'',NM_CODE1) as NM_POS '
           +'  from MS_CODE '
           +' where CD_STORE  =:P0 '
           +'   and CD_KIND   = ''02'' '
           +'   and DS_STATUS = ''0'' '
           +' order by CD_CODE ',
           [Common.Config.StoreCode]);
  KitchenCheckListBox.Clear;
  vIndex := 0;
  while not Common.Query.Eof do
  begin
    KitchenCheckListBox.Items.Add;
    KitchenCheckListBox.Items[vIndex].Text := Common.Query.Fields[0].AsString;
    Common.Query.Next;
    Inc(vIndex);
  end;
  Common.Query.Close;


  if isMenuAdd or (Tag in [1,2]) then
  begin
    PluPosition := -1;
    TaxSwitch.Visible  := true;
    TaxSwitch.State    := tssOn;
    if Tag <> 2 then
      PluPanel.Visible   := true;
    MenuInfoButton.Visible := false;
    edt_MenuName.SetFocus;
    if Tag <> 2 then
      lbl_Msg.Caption := '메뉴를 추가할 버튼을 선택하세요';
  end
  else
  begin
    if isSetSoldOut then
      CaptionLabel.Caption := '품절관리'
    else
      CaptionLabel.Caption := '메뉴수정';
    TaxSwithLabel.Visible  := false;
    TaxSwitch.Visible      := false;
    MenuTypeLabel.Visible  := true;
    PluPanel.Visible       := true;
    MenuInfoButton.Visible := GetHeadOption(9) = '1';

    if isSetSoldOut then
      lbl_Msg.Caption := '품절 할 메뉴를 선택하세요'
    else
      lbl_Msg.Caption := '수정 할 메뉴를 선택하세요';
  end;
  edt_MenuName.Enabled := isMenuAdd;
end;

function TMenuAdd_F.GetMenuCode: String;
var vSql :String;
    vResult   : Boolean;
    vTempData,
    vParamsType,
    vResultStr :WideString;
    vFirstRow :Integer;
    vMenuLength  :Integer;
begin
  OpenQuery('select SELFMENU_LEN '
           +'  from MS_STORE '
           +' where CD_STORE     =:P0 ',
           [Common.Config.StoreCode]);

  vMenuLength := Common.Query.Fields[0].AsInteger;
  Common.Query.Close;

  DM.OpenCloud('select IFNULL(MAX(CD_MENU), 0) + 1 CODE '
              +'  from MS_MENU '
              +' where CD_HEAD      =:P0 '
              +'   and CD_STORE     =:P1 '
              +'   and Length(CD_MENU) =:P2 ',
              [Common.Config.HeadStoreCode,
               Common.Config.StoreCode,
               vMenuLength],Common.RestDBURL);
  Result := LPad(DM.CloudData.FieldByName('CODE').AsString, vMenuLength, '0');
  DM.CloudData.Close;
end;

procedure TMenuAdd_F.KeyPadButtonClick(Sender: TObject);
var vPrice :String;
begin
  inherited;
  vPrice := Common.ShowNumberForm('단가를 입력하세요',9,0,edt_MenuPrice.Text);
  if vPrice = 'mrClose' then Exit;
  edt_MenuPrice.Text := vPrice;
  edt_MenuPrice.SetFocus;
end;

procedure TMenuAdd_F.MenuInfoButtonClick(Sender: TObject);
begin
  inherited;
  DM.OpenCloud('select MENU_INFO '
              +'  from MS_MENU_IMAGE '
              +' where CD_HEAD  =:P0 '
              +'   and CD_STORE =:P1 '
              +'   and CD_MENU  =:P2',
              [Common.Config.HeadStoreCode,
               Common.Config.StoreCode,
               lbl_MenuCode.Caption], Common.RestDBURL);
  if not DM.CloudData.Eof then
    MenuInfoMemo.Text := DM.CloudData.Fields[0].AsString
  else
    MenuInfoMemo.Clear;
  DM.CloudData.Close;
  MenuInfoPanel.Visible := true;
  MenuInfoMemo.SelStart := Length(MenuInfoMemo.Text)+1;
  MenuInfoMemo.SetFocus;
  MenuInfoPanel.Top     := Self.Height div 2 - MenuInfoPanel.Height div 2;
  MenuInfoPanel.Left    := Self.Width  div 2 - MenuInfoPanel.Width div 2;
end;

procedure TMenuAdd_F.MenuInfoCancelButtonClick(Sender: TObject);
begin
  inherited;
  MenuInfoPanel.Visible := false;
end;

procedure TMenuAdd_F.MenuInfoSaveButtonClick(Sender: TObject);
begin
  inherited;
  if DM.ExecCloud('insert into MS_MENU_IMAGE(CD_HEAD, '
                 +'                          CD_STORE, '
                 +'                          CD_MENU, '
                 +'                          MENU_INFO, '
                 +'                          DT_CHANGE, '
                 +'                          DT_INSERT) '
                 +'                  values(:P0, '
                 +'                         :P1, '
                 +'                         :P2, '
                 +'                         :P3, '
                 +'                          NOW(), '
                 +'                          NOW()) '
                 +'ON DUPLICATE KEY UPDATE '
                 +'       MENU_INFO         =:P3, '
                 +'       DT_CHANGE         = NOW(); ',
                 [Common.Config.HeadStoreCode,
                  Common.Config.StoreCode,
                  lbl_MenuCode.Caption,
                  MenuInfoMemo.Text],true,Common.RestDBURL) then
    MenuInfoPanel.Visible := false;
end;

procedure TMenuAdd_F.SetClassButton;
var vIndex, vBegin, vEnd :Integer;
begin
  vBegin   := (ClassPage.EditValue-1) * ((PluClassX * PluClassY)-1)+1;
  vEnd     := vBegin + PluClassX * PluClassY - 2;

  for vIndex := Low(PluClassButton) to High(PluClassButton) do
  begin
    PluClassButton[vIndex].Caption := IntToStr(TPosButton(FindComponent('ClassButton'+ IntToStr(vIndex))).Tag+1);
    PluClassButton[vIndex].Color   := ClassDefaultColor;
    PluClassButton[vIndex].Number.NumberString  := '';
    PluClassButton[vIndex].Temp1   := FormatFloat('00',vBegin+vIndex);
    PluClassButton[vIndex].Temp2   := '';
    PluClassButton[vIndex].Temp3   := 'N';
    PluClassButton[vIndex].Temp10  := '';
    PluClassButton[vIndex].Enabled := false;
  end;


  try
    OpenQuery('select NO_POSITION, '
             +'       CD_LARGE, '
             +'       NM_LARGE, '
             +'       COLOR '
             +'  from '+Ifthen(isSetSoldOut and (GetOption(403)='1'), ' MS_KIOSK_LARGE ',' MS_LARGE ')
             +' where CD_STORE =:P0 '
             +'   and CD_GUBUN =:P1 '
             +'   and NO_POSITION between :P2 and :P3 '
             +'  order by NO_POSITION ',
             [Common.Config.StoreCode,
              WorkPluNo,
              vBegin,
              vEnd]);

    while not Common.Query.Eof do
    begin
      if ClassPage.EditValue = 1 then
        vIndex := Common.Query.FieldByName('NO_POSITION').AsInteger
      else
        vIndex := Common.Query.FieldByName('NO_POSITION').AsInteger - vBegin + 1;

      PluClassButton[vIndex-1].Temp1   := Common.Query.FieldByName('CD_LARGE').AsString;
      PluClassButton[vIndex-1].Caption := LineFeed(Common.Query.FieldByName('NM_LARGE').AsString);
      PluClassButton[vIndex-1].Number.NumberString  := Common.Query.FieldByName('CD_LARGE').AsString;
      PluClassButton[vIndex-1].Temp2   := Common.Query.FieldByName('COLOR').AsString;
      if PluClassButton[vIndex-1].Temp2 <> '' then
        PluClassButton[vIndex-1].Color := StringToColor(PluClassButton[vIndex-1].Temp2);
      PluClassButton[vIndex-1].Enabled := PluClassButton[vIndex-1].Number.NumberString <> '';
      Common.Query.Next;
    end;
  finally
    Common.Query.Close;
  end;
  MenuPage.Value := 1;
end;

procedure TMenuAdd_F.SetMenuButton;
var vIndex, vBegin, vEnd :Integer;
begin
  vBegin   := Trunc((MenuPage.Value-1) * ((PluMenuX * PluMenuY)-1)+1);
  vEnd     := Trunc(vBegin + PluMenuX * PluMenuY - 2);

  PluMenuButtonClear;

  try
    OpenQuery('select a.NO_POSITION, '
             +'       a.CD_LARGE, '
             +'       a.CD_MENU, '
             +'       a.NM_VIEW, '
             +'       b.PR_SALE, '
             +'       a.COLOR, '
             +'       b.CONFIG, '
             +'       b.DS_MENU_TYPE '
             +'  from '+Ifthen(isSetSoldOut and (GetOption(403)='1'), ' MS_KIOSK_SMALL a inner join ',' MS_SMALL a inner join ')
             +'       MS_MENU  b on a.CD_STORE = b.CD_STORE and a.CD_MENU = b.CD_MENU '
             +' where a.CD_STORE  = :P0 '
             +'   and a.CD_GUBUN  = :P1 '
             +'   and a.CD_LARGE  = :P2 '
             +'   and a.NO_POSITION between :P3 and :P4 '
             +'order by a.NO_POSITION  ',
             [Common.Config.StoreCode,
              WorkPluNo,
              ClassCode,
              vBegin,
              vEnd]);
    while not Common.Query.Eof do
    begin
      if MenuPage.Value = 1 then
        vIndex := Common.Query.FieldByName('NO_POSITION').AsInteger
      else
        vIndex := Common.Query.FieldByName('NO_POSITION').AsInteger - vBegin + 1;


      PluMenuButton[vIndex-1].Temp1   := Common.Query.FieldByName('CD_MENU').AsString;
      PluMenuButton[vIndex-1].Caption := LineFeed(Common.Query.FieldByName('NM_VIEW').AsString);
      PluMenuButton[vIndex-1].Bottom.RightString := FormatFloat(',0', Common.Query.FieldByName('PR_SALE').AsInteger);
      if Common.Query.FieldByName('COLOR').AsString <> '' then
      begin
        PluMenuButton[vIndex-1].Color   := StringToColor(Common.Query.FieldByName('COLOR').AsString);
        PluMenuButton[vIndex-1].Temp2   := Common.Query.FieldByName('COLOR').AsString;        //저장시 사용
      end
      else
        PluMenuButton[vIndex-1].Temp2 := ColorToString(MenuDefaultColor);
      if Copy(Common.Query.FieldByName('CONFIG').AsString,8,1) = 'Y' then
      begin
        PluMenuButton[vIndex-1].Number.RightString := '품절';
        PluMenuButton[vIndex-1].Font.Style := [fsItalic, fsStrikeOut];
      end
      else
      begin
        PluMenuButton[vIndex-1].Font.Style := [];
      end;

      if Copy(Common.Query.FieldByName('CONFIG').AsString,13,1) = '0' then
        PluMenuButton[vIndex-1].Number.NumberString := ''
      else if Copy(Common.Query.FieldByName('CONFIG').AsString,13,1) = 'R' then
        PluMenuButton[vIndex-1].Number.NumberString := '추천'
      else if Copy(Common.Query.FieldByName('CONFIG').AsString,13,1) = 'H' then
        PluMenuButton[vIndex-1].Number.NumberString := 'HOT'
      else if Copy(Common.Query.FieldByName('CONFIG').AsString,13,1) = 'N' then
        PluMenuButton[vIndex-1].Number.NumberString := '신메뉴'
      else if Copy(Common.Query.FieldByName('CONFIG').AsString,13,1) = 'T' then
        PluMenuButton[vIndex-1].Number.NumberString := 'HIT';

      PluMenuButton[vIndex-1].Temp3    := Common.Query.FieldByName('DS_MENU_TYPE').AsString;
      if Common.Query.FieldByName('DS_MENU_TYPE').AsString = 'P' then
      begin
        PluMenuButton[vIndex-1].Bottom.LeftString  := '그룹';
        PluMenuButton[vIndex-1].Bottom.RightString := '';
      end;
      if isMenuAdd then
      begin
        PluMenuButton[vIndex-1].Enabled := false;
        PluMenuButton[vIndex-1].Color   := clSilver;
      end
      else
      begin
        PluMenuButton[vIndex-1].Enabled   := true;
      end;

      Common.Query.Next;
    end;
  finally
    Common.Query.Close;
  end;
  ShowPosMode;
end;

procedure TMenuAdd_F.ShowPosMode;
  function GetNextLineButton(aX,aY, aMenuCode:String):Integer;
  var vIndex :Integer;
      vLine  :String;
  begin
    vLine := IntToStr(StrToInt(aX)+1);
    Result := -1;
    for vIndex := Low(PluMenuButton) to High(PluMenuButton)-1 do
    begin
      if (vLine = PluMenuButton[vIndex].Temp4) and (aY = PluMenuButton[vIndex].Temp5) and (aMenuCode = PluMenuButton[vIndex].Temp1) and (aMenuCode = PluMenuButton[vIndex+1].Temp1) then
      begin
        PluMenuButton[vIndex].Temp8 := 'M';
        Result := vIndex;
        Break;
      end;
    end;
  end;
  function GetNextLine2Button(aX,aY, aMenuCode:String):Integer;
  var vIndex :Integer;
      vLine  :String;
  begin
    vLine := IntToStr(StrToInt(aY)+1);
    Result := -1;
    for vIndex := Low(PluMenuButton) to High(PluMenuButton)-1 do
    begin
      //다음라인과  같고
      if (vLine = PluMenuButton[vIndex].Temp4) and (aX = PluMenuButton[vIndex].Temp5) and (aMenuCode = PluMenuButton[vIndex].Temp1) then
      begin
        PluMenuButton[vIndex].Temp8 := 'M';
        Result := vIndex;
        Break;
      end;
    end;
  end;
var vIndex, vIndex1 :Integer;
begin
  for vIndex := Low(PluMenuButton) to High(PluMenuButton) do
  begin
    PluMenuButton[vIndex].Width    := StrToInt(PluMenuButton[vIndex].Temp6);
    PluMenuButton[vIndex].Height   := StrToInt(PluMenuButton[vIndex].Temp7);
    PluMenuButton[vIndex].Temp8    := EmptyStr;   //버튼 합쳤다는 Flag
  end;

  //버튼 합치기
  for vIndex := Low(PluMenuButton) to High(PluMenuButton)-1 do
  begin
    if (PluMenuButton[vIndex].Temp1 = EmptyStr) or (PluMenuButton[vIndex].Temp8 = 'M') or (PluMenuButton[vIndex].Temp3 = 'Y') then Continue;
    //다음버튼과 메뉴코드가 같을때                                                    //같은 라인에 있을때
    if (PluMenuButton[vIndex].Temp1 = PluMenuButton[vIndex+1].Temp1) and (PluMenuButton[vIndex].Temp4 = PluMenuButton[vIndex+1].Temp4)  then
    begin
      //다음 라인버튼도 같은지 체크 (Y, X, 메뉴코드)
      vIndex1 := GetNextLineButton(PluMenuButton[vIndex].Temp4, PluMenuButton[vIndex].Temp5, PluMenuButton[vIndex].Temp1);

      //총 4개 버튼을 합친다
      if vIndex1 > 0 then
      begin
        PluMenuButton[vIndex].Width    := PluMenuButton[vIndex].Width * 2 + 2;
        PluMenuButton[vIndex].Height   := PluMenuButton[vIndex].Height * 2 + 2;
        PluMenuButton[vIndex+1].Temp8  := 'M';
      end
      else
      // 2개버튼을 합친다
      begin
        PluMenuButton[vIndex].Width    := PluMenuButton[vIndex].Width * 2 +2;
        PluMenuButton[vIndex+1].Temp8  := 'M';
      end;
      PluMenuButton[vIndex].BringToFront;
      Continue;
    end
    else //세로 합치기
    begin
      vIndex1 := GetNextLine2Button(PluMenuButton[vIndex].Temp5, PluMenuButton[vIndex].Temp4, PluMenuButton[vIndex].Temp1);
      if vIndex1 > 0 then
      begin
        PluMenuButton[vIndex].Height    := PluMenuButton[vIndex].Height * 2 + 2;
        PluMenuButton[vIndex].Temp8  := 'M';
      end;
      PluMenuButton[vIndex].BringToFront;
      Continue;
    end;
  end;
end;

procedure TMenuAdd_F.CloseButtonClick(Sender: TObject);
begin
  if not isSetSoldOut and not PluPanel.Visible then
  begin
    PluPanel.Visible := true;
    SetMenuButton;
    if not isMenuAdd then
      lbl_Msg.Caption  := '수정할 메뉴를 선택해주세요'
    else
      lbl_Msg.Caption  := '등록할 버튼을 선택해주세요';

    Exit;
  end;
  ClassDefaultFont.Free;
  MenuDefaultFont.Free;

  if not isSetSoldOut then
    inherited
  else
    Close;
end;

procedure TMenuAdd_F.PluClassButtonClick(Sender: TObject);
var I :Integer;
    vPos,
    vPos1 :Integer;
    vFromCode,
    vToCode :String;
begin
  inherited;
  try
    For I := Low(PluClassButton) to High(PluClassButton) do
    begin
      if PluClassButton[I].Temp2 <> '' then
        PluClassButton[I].Color := StringToColor(PluClassButton[I].Temp2)
      else
        PluClassButton[I].Color      := ClassDefaultColor;
      PluClassButton[I].Font       := ClassDefaultFont
    end;

    (Sender as TPosButton).Color      := ClassDefaultDownColor;
    (Sender as TPosButton).Font.Color := ClassDefaultDownFontColor;

    ClassButton := Sender as TPosButton;

    ClassCode  := (ClassButton as TPosButton).Temp1;

    //PLU 메뉴버튼을 셋팅한다
    MenuPage.Value := 1;
    TPosButton(FindComponent('MenuPrevButton')).Enabled := false;
    SetMenuButton;

    MenuPanel.Enabled := ((ClassButton as TPosButton).Number.NumberString <> '') and ((ClassButton as TPosButton).Temp3 = 'N');
  finally
    Screen.Cursor := crDefault;
    Self.Enabled  := true;
  end;
end;

procedure TMenuAdd_F.PluClassButtonCreate;
var vWidth, vHeight, vX, vY, I :Integer;
begin
  SetLength(PluClassButton, PluClassX * PluClassY-1);

  vWidth  := ClassPanel.Width  div PluClassX;
  vHeight := ClassPanel.Height div PluClassY - 2 ;
  I := 0;
  for vY := 0 to (PluClassY-1) do
    for vX := 0 to (PluClassX-1) do
    begin
      if I > High(PluClassButton) then Continue;

      PluClassButton[I] := TPosButton.Create(Self);
      with PluClassButton[I] do
      begin
        Name        := Format('ClassButton%d',[I]);
        Parent      := ClassPanel;
        TabStop     := false;
        Width       := vWidth-2;
        Height      := vHeight;
//        PopupMenu   := ColorPopupMenu;
        Left        := (vX * vWidth);
        Top         := (vY * vHeight) + (vY * 2);
        Caption     := EmptyStr;
        Color       := ClassDefaultColor;
        BorderColor := ClassBorderColor;
        BorderStyle := pbsSingle;
        BorderInnerColor := clNone;
        Font        := ClassDefaultFont;
        Font.Style  := [fsBold];
        Number.Height     := Trunc(vHeight / 4);
        Number.Font.Color := ClassDefaultFont.Color;
        Number.Font.Name  := '맑은 고딕';
        Number.Font.Size  := ClassDefaultFont.Size-2;
        Bottom.Height    := Trunc(vHeight / 4)+3;
        Bottom.Font.Size := ClassDefaultFont.Size-2;
        Cursor           := crHandPoint;
        Style            := bsRound;
        OnClick          := PluClassButtonClick;
        Tag              := I;
        Inc(I);
      end;
    end;

  //PLU분류 이전페이지, 다음페이지 버튼을 생성한다
  with TPosButton.Create(Self) do
  begin
    Name        := 'ClassPrevButton';
    Parent      := ClassPanel;
    Width       := vWidth div 2 - 2;
    Height      := vHeight;
    Left        := PluClassButton[High(PluClassButton)].Left + vWidth;
    Top         := PluClassButton[High(PluClassButton)].Top;
    Caption     := '◀';
    Color       := ClassDefaultColor;
    BorderColor := ClassBorderColor;
    BorderStyle := pbsSingle;
    BorderInnerColor := clNone;
    Font        := ClassDefaultFont;
    Font.Style  := [fsBold];
    Cursor      := crHandPoint;
    Style       := bsRound;
    OnClick     := PluClassPrevButtonClick;
    Enabled     := true;
  end;

  with TPosButton.Create(Self) do
  begin
    Name        := 'ClassNextButton';
    Parent      := ClassPanel;
    Width       := vWidth div 2 - 2;
    Height      := vHeight;
    Left        := (PluClassButton[High(PluClassButton)].Left + vWidth) + + (vWidth div 2);
    Top         := PluClassButton[High(PluClassButton)].Top;
    Caption     := '▶';
    Color       := ClassDefaultColor;
    BorderColor := ClassBorderColor;
    BorderStyle := pbsSingle;
    BorderInnerColor := clNone;
    Font        := ClassDefaultFont;
    Font.Style  := [fsBold];
    Cursor      := crHandPoint;
    Style       := bsRound;
    OnClick     := PluClassPrevButtonClick;
    Enabled     := true;
  end;
end;

procedure TMenuAdd_F.PluClassPrevButtonClick(Sender: TObject);
begin
  if Sender = TPosButton(FindComponent('ClassNextButton'))  then
    ClassPage.Value := ClassPage.Value + 1
  else ClassPage.Value := ClassPage.Value - 1;

  TPosButton(FindComponent('ClassPrevButton')).Enabled     := ClassPage.Value > 1 ;

  SetClassButton;
  PluClassButtonClick(TPosButton(FindComponent('ClassButton0')));
end;

procedure TMenuAdd_F.PluMenuButtonClear;
var vIndex :Integer;
begin
  for vIndex := Low(PluMenuButton) to High(PluMenuButton) do
  begin
    PluMenuButton[vIndex].Number.NumberString := EmptyStr;
    PluMenuButton[vIndex].Enabled             := True;
    PluMenuButton[vIndex].Caption             := IntToStr(PluMenuButton[vIndex].Tag+1);
    PluMenuButton[vIndex].Color               := MenuDefaultColor;
    PluMenuButton[vIndex].Refresh;
    PluMenuButton[vIndex].Temp1               := '';
    PluMenuButton[vIndex].Temp2               := '';
    PluMenuButton[vIndex].Temp3               := 'N';
    PluMenuButton[vIndex].Bottom.RightString  := '';
    PluMenuButton[vIndex].Bottom.LeftString   := '';
    PluMenuButton[vIndex].Number.RightString  := '';
    PluMenuButton[vIndex].Visible             := true;
    if not isMenuAdd then
      PluMenuButton[vIndex].Enabled             := false;
  end;
end;

procedure TMenuAdd_F.PluMenuButtonClick(Sender: TObject);
  procedure SetPrinter(aCode: String);
    function FindPrinter(aCode: String): Integer;
    var i: Integer;
    begin
      Result := -1;
      for i := 0 to Pred(KitchenCheckListBox.Items.Count) do
        if Copy(KitchenCheckListBox.Items[i].Text, 1, 3) = aCode then
        begin
          Result := i;
          Break;
        end;
    end;
  var
    i, j: Integer;
  begin
    for i := 0 to Pred(KitchenCheckListBox.Items.Count) do
      KitchenCheckListBox.Items[i].Checked := False;

    while aCode <> '' do
    begin
       i := Pos(',', aCode);
       if i > 0 then
       begin
          j := FindPrinter(Copy(aCode, 1, Pred(i)));
          if j > -1 then
            KitchenCheckListBox.Items[j].Checked := True;
          Delete(aCode, 1, i);
       end
       else
       begin
          j := FindPrinter(aCode);
          if j > -1 then
            KitchenCheckListBox.Items[j].Checked := True;

          aCode :='';
       end;
    end;
  end;
  procedure SetMenuClass(aClass:String);
  var vIndex : Integer;
  begin
    For vIndex := 0 to cbo_MenuClass.Properties.Items.Count-1 do
    begin
      if LeftStr(cbo_MenuClass.Properties.Items.Strings[vIndex],2) = aClass then
      begin
        cbo_MenuClass.ItemIndex := vIndex;
        Break;
      end;
    end;
  end;
var vSoldOut,
    vOptions :String;
    vMenuCode,
    vMenuName :String;
begin
  inherited;
  //그룹메뉴일때
  if (Sender as TPosButton).Temp3 = 'P' then
  begin
    if Common.ShowChooseForm('G', (Sender as TPosButton).Temp1, vMenuCode, vMenuName, (Sender as TPosButton).Caption) then
    begin
      OpenQuery('select CONFIG '
               +'  from MS_MENU '
               +' where CD_STORE =:P0 '
               +'   and CD_MENU  =:P1 ',
               [Common.Config.StoreCode,
                vMenuCode]);
      vSoldOut := Ifthen(Copy(Common.Query.FieldByName('CONFIG').AsString,8,1)='Y','N','Y');
    end
    else
      Exit;
  end
  else
  begin
    vMenuCode := (Sender as TPosButton).Temp1;
    vMenuName := (Sender as TPosButton).Caption;
    vSoldOut  := Ifthen((Sender as TPosButton).Number.RightString='품절','N','Y');
  end;

  lbl_Msg.Caption := '';
  //키오스크 품절관리
  if isSetSoldOut then
  begin
    if vSoldOut = 'N' then
    begin
      if not Common.AskBox(Format('"%s"메뉴를'#13'품절해제 하시겠습니까?',[vMenuName])) then Exit;
    end
    else
    begin
      if not Common.AskBox(Format('"%s"메뉴를'#13'품절설정 하시겠습니까?',[vMenuName])) then Exit;
    end;

    DM.ExecCloud('update MS_MENU '
                +'   set PRG_CHANGE = ''POS'','
                +'       CONFIG        = StringPosReplace(CONFIG, 8, :P3), '
                +'       CD_SAWON_CHG  =:P4, '
                +'       DT_CHANGE     =Now() '
                +' where CD_HEAD  =:P0 '
                +'   and CD_STORE =:P1 '
                +'   and CD_MENU  =:P2; ',
                [Common.Config.HeadStoreCode,
                 Common.Config.StoreCode,
                 vMenuCode,
                 vSoldOut,
                 Common.Config.UserCode],true,Common.RestDBURL);

    ExecQuery('update MS_MENU '
                +'   set CONFIG    = StringPosReplace(CONFIG,8, :P2) '
                +' where CD_STORE  =:P0 '
                +'   and CD_MENU   =:P1; ',
                [Common.Config.StoreCode,
                 vMenuCode,
                 vSoldOut],true);

    if ((Sender as TPosButton).Temp3 <> 'P') and isSetSoldOut then
    begin
      (Sender as TPosButton).Number.RightString := Ifthen(vSoldOut = 'Y', '품절','');

      if vSoldOut = 'Y' then
        (Sender as TPosButton).Font.Style := [fsItalic, fsStrikeOut]
      else
        (Sender as TPosButton).Font.Style := [];
    end;
    Exit;
  end;

  if not isMenuAdd then
  begin
    OpenQuery('select NM_MENU, '
             +'       NM_MENU_SHORT, '
             +'       PR_SALE, '
             +'       CD_PRINTER, '
             +'       Left(CD_CLASS,2) as CD_CLASS, '
             +'       CONFIG, '
             +'       case DS_MENU_TYPE when ''N'' then ''일반'' when ''O'' then ''오픈세트'' when ''S'' then ''세트'' when ''C'' then ''코스'' when ''G'' then ''싯가'' when ''P'' then ''그룹'' end DS_MENU_TYPE,  '
             +'       OPTIONS '
             +'  from MS_MENU  '
             +' where CD_STORE =:P0 '
             +'   and CD_MENU  =:P1 ',
             [Common.Config.StoreCode,
              vMenuCode]);

    lbl_MenuCode.Caption := vMenuCode;
    edt_MenuName.Hint    := Common.Query.FieldByName('NM_MENU').AsString;
    edt_MenuName.Text    := Common.Query.FieldByName('NM_MENU_SHORT').AsString;
    edt_MenuPrice.Value  := Common.Query.FieldByName('PR_SALE').AsInteger;
    if Copy(Common.Query.FieldByName('CONFIG').AsString,1,1) = 'Y' then
      DcSwitch.State    := tssOn
    else
      DcSwitch.State    := tssOff;

    if Copy(Common.Query.FieldByName('CONFIG').AsString,2,1) = 'Y' then
      PointSwitch.State    := tssOn
    else
      PointSwitch.State    := tssOff;

    SetPrinter(Common.Query.FieldByName('CD_PRINTER').AsString);
    SetMenuClass(Common.Query.FieldByName('CD_CLASS').AsString);
    if Copy(Common.Query.FieldByName('CONFIG').AsString,8,1) = 'Y' then
      SoldOutSwitch.State    := tssOn
    else
      SoldOutSwitch.State    := tssOff;

    MenuTypeLabel.Caption  := Common.Query.FieldByName('DS_MENU_TYPE').AsString;
    MenuConfig             := Common.Query.FieldByName('CONFIG').AsString;
    BageComboBox.ItemIndex := GetStrPointerIndex(BageComboBox, Copy(MenuConfig,13,1));
    vOptions := LPad(Common.Query.FieldByName('OPTIONS').AsString,20,'0');

    if (vOptions[1]='1')  and (vOptions[2]='1')then
      edt_MenuPrice.Enabled := false
    else
      edt_MenuPrice.Enabled := true;

    edt_MenuName.EditModified := false;
    Common.Query.Close;

    if edt_MenuPrice.Enabled then
      edt_MenuPrice.SetFocus;
  end
  else
  begin
    lbl_MenuCode.Caption := GetMenuCode;
    edt_MenuName.SetFocus;
  end;
  if MenuPage.EditValue > 1 then
    PluPosition  := (Sender as TPosButton).Tag + ((MenuPage.EditValue -1) * PluMenuX * PluMenuY)
  else
    PluPosition   := (Sender as TPosButton).Tag + 1;

  PluPanel.Visible := false;
end;

procedure TMenuAdd_F.PluMenuButtonCreate;
var vWidth, vHeight, vX, vY, I :Integer;
begin
  SetLength(PluMenuButton, PluMenuX * PluMenuY-1);

  vWidth  := MenuPanel.Width  div PluMenuX;
  vHeight := MenuPanel.Height div PluMenuY - 2 ;
  I := 0;
  for vY := 0 to (PluMenuY-1) do
    for vX := 0 to (PluMenuX-1) do
    begin
      if I > High(PluMenuButton) then Continue;

      PluMenuButton[I] := TPosButton.Create(Self);
      with PluMenuButton[I] do
      begin
        Name        := Format('MenuButton%d',[I]);
        Parent      := MenuPanel;
        TabStop     := false;
        Width       := vWidth-2;
        Height      := vHeight;
//        PopupMenu   := ColorPopupMenu;
        Left        := (vX * vWidth);
        Top         := (vY * vHeight) + (vY * 2);
        Caption     := EmptyStr;
        Color       := MenuDefaultColor;
        BorderColor := MenuBorderColor;
        BorderStyle := pbsSingle;
        BorderInnerColor := clNone;
        Font        := MenuDefaultFont;
        Font.Style  := [fsBold];
        Number.Height     := Trunc(vHeight / 4);
        Number.Font.Color := MenuDefaultFont.Color;
        Number.Font.Name  := '맑은 고딕';
        Number.Font.Size  := MenuDefaultFont.Size-2;
        Number.Font.Color  := clRed;

        Bottom.Height    := Trunc(vHeight / 4)+3;
        Bottom.Font.Size := MenuDefaultFont.Size-2;
        Cursor           := crHandPoint;
        Temp4            := IntToStr(vY);
        Temp5            := IntToStr(vX);
        Temp6            := IntToStr(vWidth-2);
        Temp7            := IntToStr(vHeight);
        Style            := bsRound;
        OnClick          := PluMenuButtonClick;
        Tag              := I;
        Inc(I);
      end;
    end;

  //PLU분류 이전페이지, 다음페이지 버튼을 생성한다
  with TPosButton.Create(Self) do
  begin
    Name        := 'MenuPrevButton';
    Parent      := MenuPanel;
    Width       := vWidth div 2 - 2;
    Height      := vHeight;
    Left        := PluMenuButton[High(PluMenuButton)].Left + vWidth;
    Top         := PluMenuButton[High(PluMenuButton)].Top;
    Caption     := '◀';
    Color       := MenuDefaultColor;
    BorderColor := MenuBorderColor;
    BorderStyle := pbsSingle;
    BorderInnerColor := clNone;
    Font        := MenuDefaultFont;
    Font.Style  := [fsBold];
    Cursor      := crHandPoint;
    Style       := bsRound;
    OnClick     := PluMenuPrevButtonClick;
    Enabled     := true;
  end;

  with TPosButton.Create(Self) do
  begin
    Name        := 'MenuNextButton';
    Parent      := MenuPanel;
    Width       := vWidth div 2 - 2;
    Height      := vHeight;
    Left        := (PluMenuButton[High(PluMenuButton)].Left + vWidth) + + (vWidth div 2);
    Top         := PluMenuButton[High(PluMenuButton)].Top;
    Caption     := '▶';
    Color       := MenuDefaultColor;
    BorderColor := MenuBorderColor;
    BorderStyle := pbsSingle;
    BorderInnerColor := clNone;
    Font        := MenuDefaultFont;
    Font.Style  := [fsBold];
    Cursor      := crHandPoint;
    Style       := bsRound;
    OnClick     := PluMenuPrevButtonClick;
    Enabled     := true;
  end;
end;

procedure TMenuAdd_F.PluMenuPrevButtonClick(Sender: TObject);
begin
  if Sender = TPosButton(FindComponent('MenuNextButton')) then
    MenuPage.Value  := MenuPage.Value  + 1
  else
    MenuPage.Value  := MenuPage.Value  - 1;
  SetMenuButton;
  TPosButton(FindComponent('MenuPrevButton')).Enabled  := MenuPage.Value  > 1;
end;

procedure TMenuAdd_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_RETURN) then
  begin
    SelectNext(TWinControl(ActiveControl), true,  true);
  end;
end;

procedure TMenuAdd_F.SaveButtonClick(Sender: TObject);
var vIndex   :Integer;
    vKitchen :String;
    vSQL     :String;
    vConfig  :String;
begin
  inherited;
  for vIndex := 0 to ComponentCount-1 do
  begin
    if (Components[vIndex] is TcxTextEdit) then
      (Components[vIndex] as TcxTextEdit).PostEditValue;
    if (Components[vIndex] is TcxCurrencyEdit) then
      (Components[vIndex] as TcxCurrencyEdit).PostEditValue;
  end;

  if not isMenuAdd and (lbl_MenuCode.Caption = EmptyStr) then
  begin
    Common.ErrBox('수정할 메뉴가 지정되지 않았습니다');
    Exit;
  end;

  if edt_MenuName.Enabled and (Trim(edt_MenuName.EditingText) = EmptyStr) then
  begin
    Common.ErrBox('메뉴명을 입력하세요');
    edt_MenuName.SetFocus;
    Exit;
  end;

  if (MenuTypeLabel.Caption <> '그룹') and (edt_MenuPrice.Value = 0) then
  begin
    Common.ErrBox('판매단가를 입력하세요');
    if edt_MenuPrice.Enabled then
      edt_MenuPrice.SetFocus;
    Exit;
  end;

  if (PluPosition = -1) and (Tag <> 2) then
  begin
    if not Common.AskBox('PLU가 지정되지 않았습니다'#13#13'저장하시겠습니까?') then
      Exit;
  end
  else if not Common.AskBox('저장하시겠습니까?') then Exit;

  //주방 출력
  for vIndex := 0 to Pred(KitchenCheckListBox.Items.Count) do
  begin
    if vIndex > KitchenCheckListBox.Items.Count then Continue;
    if KitchenCheckListBox.Items[vIndex].Checked then
      vKitchen := vKitchen + Copy(KitchenCheckListBox.Items[vIndex].Text, 1, 3) + ',';
  end;
  if (vKitchen <> '') and (vKitchen[Length(vKitchen)]=',') then Delete(vKitchen,Length(vKitchen),1);


  try
    if isMenuAdd then
    begin
      vConfig := Ifthen(DcSwitch.State = tssOn, 'Y','N')
                +Ifthen(PointSwitch.State = tssOn, 'Y','N')
                +'Y'
                +'N'
                +'Y'
                +'N'
                +'N'
                +'N'
                +'N'
                +'N00'
                +GetStrPointerData(BageComboBox)
                +LPad('',17,'0');

      DM.ExecCloud('insert into MS_MENU(CD_HEAD, '
                  +'                    CD_STORE, '
                  +'                    CD_MENU, '
                  +'                    NM_MENU, '
                  +'                    NM_MENU_SHORT, '
                  +'                    DS_MENU_TYPE, '
                  +'                    CD_CLASS, '
                  +'                    PR_SALE, '
                  +'                    CONFIG, '
                  +'                    CD_PRINTER, '
                  +'                    DS_TAX, '
                  +'                    CD_SAWON_CHG,'
                  +'                    PRG_INSERT, '
                  +'                    PRG_CHANGE ) '
                  +'             values(:P0, '
                  +'                    :P1, '
                  +'                    :P2, '
                  +'                    :P3, '
                  +'                    :P3, '
                  +'                    ''N'', '
                  +'                    :P4, '
                  +'                    :P5, '
                  +'                    :P6, '
                  +'                    :P7, '
                  +'                    :P8, '
                  +'                    :P9, '
                  +'                    ''POS'','
                  +'                    ''POS'' ); ',
                 [Common.Config.HeadStoreCode,
                  Common.Config.StoreCode,
                  lbl_MenuCode.Caption,
                  edt_MenuName.EditingText,
                  LeftStr(cbo_MenuClass.Text,2),
                  edt_MenuPrice.EditingValue,
                  vConfig,
                  vKitchen,
                  Ifthen(TaxSwitch.State = tssOn, '1','0'),
                  Common.Config.UserCode],false,Common.RestDBURL);

      //PLU 저장
      if PluPosition >= 0 then
      begin
        DM.ExecCloud('delete from MS_SMALL '
                    +' where CD_HEAD     = :P0 '
                    +'   and CD_STORE    = :P1 '
                    +'   and CD_GUBUN    = :P2 '
                    +'   and CD_LARGE    = :P3 '
                    +'   and NO_POSITION = :P4; ',
                    [Common.Config.HeadStoreCode,
                     Common.Config.StoreCode,
                     WorkPluNo,
                     ClassCode,
                     PluPosition],false,Common.RestDBURL);

        DM.ExecCloud('insert into MS_SMALL(CD_HEAD, '
                    +'                     CD_STORE, '
                    +'                     CD_GUBUN, '
                    +'                     CD_LARGE, '
                    +'                     NO_POSITION, '
                    +'                     CD_MENU, '
                    +'                     COLOR, '
                    +'                     COLOR_HEX, '
                    +'                     NM_VIEW, '
                    +'                     CD_SAWON_CHG) '
                    +'             values(:P0, '
                    +'                    :P1, '
                    +'                    :P2, '
                    +'                    :P3, '
                    +'                    :P4, '
                    +'                    :P5, '
                    +'                    :P6, '
                    +'                    :P7, '
                    +'                    :P8, '
                    +'                    :P9); ',
                 [Common.Config.HeadStoreCode,
                  Common.Config.StoreCode,
                  WorkPluNo,
                  ClassCode,
                  PluPosition,
                  lbl_MenuCode.Caption,
                  ColorToString(Common.Config.PluMenuColor),
                  TColorToHex(Common.Config.PluMenuColor),
                  edt_MenuName.EditingText,
                  Common.Config.UserCode],false,Common.RestDBURL);
      end;
    end
    else
    begin
      vConfig := Ifthen(DcSwitch.State = tssOn, 'Y','N')
                +Ifthen(PointSwitch.State = tssOn, 'Y','N')
                +Copy(MenuConfig,3,5)
                +Ifthen(SoldOutSwitch.State = tssOn, 'Y','N')   //8
                +Copy(MenuConfig,9,4)
                +GetStrPointerData(BageComboBox)                //13
                +RightStr(MenuConfig,17);

      DM.ExecCloud('update MS_MENU '
                  +'   set NM_MENU       =:P3, '
                  +'       NM_MENU_SHORT =:P3, '
                  +'       CD_CLASS      =:P4, '
                  +'       PR_SALE       =:P5, '
                  +'       CONFIG        =:P6, '
                  +'       CD_PRINTER    =:P7, '
                  +'       PRG_CHANGE = ''POS'','
                  +'       CD_SAWON_CHG  =:P8, '
                  +'       DT_CHANGE     =Now() '
                  +' where CD_HEAD  =:P0 '
                  +'   and CD_STORE =:P1 '
                  +'   and CD_MENU  =:P2; ',
                  [Common.Config.HeadStoreCode,
                   Common.Config.StoreCode,
                   lbl_MenuCode.Caption,
                   edt_MenuName.EditingText,
                   LeftStr(cbo_MenuClass.Text,2),
                   edt_MenuPrice.EditingValue,
                   vConfig,
                   vKitchen,
                   Common.Config.UserCode],false,Common.RestDBURL);

      //메뉴명이 수정됐으면 PLU명 변경
      if edt_MenuName.EditModified then
      begin
        DM.ExecCloud('update '+Ifthen(Common.Config.IsKiosk, ' MS_KIOSK_SMALL ','MS_SMALL ')
                    +'   set NM_VIEW  =:P3 '
                    +' where CD_HEAD  =:P0 '
                    +'   and CD_STORE =:P1 '
                    +'   and CD_MENU  =:P2; ',
                    [Common.Config.HeadStoreCode,
                     Common.Config.StoreCode,
                     lbl_MenuCode.Caption,
                     edt_MenuName.EditingText],false,Common.RestDBURL);
      end;
    end;
    DM.ExecCloud(DM.TempSQL,[],true,Common.RestDBURL);

    DM.OpenCloud('select a.CD_STORE,a.CD_MENU,a.NM_MENU, a.NM_MENU_SHORT, a.NM_MENU_KITCHEN, a.CD_CLASS,a.DS_MENU_TYPE,a.QTY_SELECT,a.PR_SALE,a.PR_SALE_DOUBLE,a.PR_SALE_PROFIT,a.PR_TIP,a.PR_SALE_PACKING, a.DS_TAX, a.CONFIG, a.CD_PRINTER,a.NO_GROUP,'
                +'       a.DS_KITCHEN,a.BILL_SEQ,a.NO_MENU,a.CD_TRDPL,a.NM_SPEC,a.DS_STOCK,a.PR_BUY,a.CD_CORNER,a.QTY_UNIT,a.QTY_SAFETY,a.YN_USE,a.SAVE_STAMP,a.USE_STAMP,a.DS_ITEM, a.OPTIONS, a.ORDERTIME_FROM, a.ORDERTIME_TO, b.MENU_INFO, a.NM_MENU_TTS, '
                +'       a.PR_SALE_MON,a.PR_SALE_TUE,a.PR_SALE_WED,a.PR_SALE_THU,a.PR_SALE_FRI,a.PR_SALE_SAT,a.PR_SALE_SUN,a.PR_SALE_HOLIDAY '
                +'  from MS_MENU          a left outer join '
                +'       MS_MENU_IMAGE as b on b.CD_HEAD = a.CD_HEAD and b.CD_STORE = a.CD_STORE and b.CD_MENU = a.CD_MENU '
                +' where a.CD_HEAD  =:P0 '
                +'   and a.CD_STORE =:P1 '
                +'   and a.CD_MENU  =:P2 ',
                [Common.Config.HeadStoreCode,
                 Common.Config.StoreCode,
                 lbl_MenuCode.Caption],Common.RestDBURL);

    vSQL := Format('delete from MS_MENU where CD_STORE =''%s'' and CD_MENU =''%s''; ',[Common.Config.StoreCode, lbl_MenuCode.Caption]);
    vSQL := vSQL + DM.GetCloudData('MS_MENU');

    DM.OpenCloud('select CD_STORE, CD_GUBUN,CD_LARGE,NO_POSITION,CD_MENU,NM_VIEW,COLOR,COLOR_HEX'
                +'  from '+Ifthen(Common.Config.IsKiosk, ' MS_KIOSK_SMALL ','MS_SMALL ')
                +' where CD_HEAD  =:P0 '
                +'   and CD_STORE =:P1 '
                +'   and CD_MENU  =:P2 ',
                [Common.Config.HeadStoreCode,
                 Common.Config.StoreCode,
                 lbl_MenuCode.Caption],Common.RestDBURL);

    vSQL := vSQL + Format('delete from %s where CD_STORE =''%s'' and CD_MENU =''%s''; ',[Ifthen(Common.Config.IsKiosk, ' MS_KIOSK_SMALL ','MS_SMALL '), Common.Config.StoreCode, lbl_MenuCode.Caption]);
    vSQL := vSQL + DM.GetCloudData(Ifthen(Common.Config.IsKiosk, ' MS_KIOSK_SMALL ','MS_SMALL '));

    DM.StoredProc.StoredProcName := 'MULTI_EXECUTE';
    DM.StoredProc.PrepareSQL;
    DM.StoredProc.ParamByName('_SQL').AsString := vSQL;
    DM.StoredProc.ExecProc;
    PluPanel.Visible := true;

    SetMenuButton;
    if not isMenuAdd then
      lbl_Msg.Caption  := '수정할 메뉴를 선택해주세요'
    else
      lbl_Msg.Caption  := '등록할 버튼을 선택해주세요';

    if Tag = 2 then
      Close;
  except
    on E: Exception do
    begin
      Common.ErrBox(E.Message);
    end;
  end;
end;

procedure TMenuAdd_F.ScannerReadEvent(const S: String);
begin
  if not isMenuAdd then Exit;
  lbl_MenuCode.Caption := S;
  edt_MenuName.SetFocus;
end;

end.

