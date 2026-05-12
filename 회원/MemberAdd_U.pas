unit MemberAdd_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Keyboard_U, StdCtrls, GraphicEx, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxCheckBox, cxMemo, cxTextEdit, cxLabel,
  cxGraphics, cxMaskEdit, cxDropDownEdit, StrUtils, DB, Menus,
  cxLookAndFeelPainters, cxButtons, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxClasses, cxGridCustomView, cxGrid, IniFiles,
  cxLookAndFeels, DateUtils, Vcl.Touch.Keyboard, AdvGlassButton,
  AdvSmoothButton;

type
  TMemberAdd_F = class(TKeyboard_F)
    Label1: TLabel;
    chkTrust: TcxCheckBox;
    chkGender: TcxCheckBox;
    MemberCodeLabel: TcxLabel;
    CardNoEdit: TcxTextEdit;
    MobileEdit: TcxTextEdit;
    RemarkMemo: TcxMemo;
    MemberClassComboBox: TcxComboBox;
    HomeTelEdit: TcxTextEdit;
    edt_Addr1: TcxTextEdit;
    edt_Addr2: TcxTextEdit;
    edt_Birthday: TcxMaskEdit;
    chklunar: TcxCheckBox;
    chkSms: TcxCheckBox;
    edt_CashRcpNo: TcxTextEdit;
    lblMenuCode: TcxLabel;
    lblMenuName: TcxLabel;
    lblSalePrice: TcxLabel;
    lblMenuClass: TcxLabel;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    PostButton: TAdvGlassButton;
    cxLabel5: TcxLabel;
    MemberNameEdit: TcxTextEdit;
    SaveButton: TAdvSmoothButton;
    PinPadButton: TAdvGlassButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CardNoEditExit(Sender: TObject);
    procedure MobileEditExit(Sender: TObject);
    procedure MemberNameEditExit(Sender: TObject);
    procedure RemarkMemoEnter(Sender: TObject);
    procedure edt_Addr2Enter(Sender: TObject);
    procedure PinPadButtonClick(Sender: TObject);
    procedure PostButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure KeyBoardButtonClick(Sender: TObject);
    procedure MemberNameEditFocusChanged(Sender: TObject);
  private
    DamdangCode    :String;
    ClickTime :TDateTime;
    FocusObject :TObject;
    function  GetMemberCode: String;
    procedure ScannerReadEvent(const S : String);
  public
    IsNew :Boolean;
    JoinStore :String; //가입매장
    TelNo     :String;
  end;

var
  MemberAdd_F: TMemberAdd_F;

implementation
uses Common_U, GlobalFunc_U, DBModule_U, Const_U, UnitZipPopup;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TMemberAdd_F.FormCreate(Sender: TObject);
var
  vCode: PStrPointer;
  vIndex : Integer;
begin
  inherited;
  Common.LogoCreate(Self,1);
  Common.SetButtonColor(KeyBoardButton);
  Common.SetButtonColor(SaveButton);
  for vIndex := 0 to ComponentCount-1 do
    if Components[vIndex] is TAdvGlassButton then
      Common.SetButtonColor((Components[vIndex] as TAdvGlassButton));

  OnShow := FormShow;
  OpenQuery('select CD_CODE, '
           +'       NM_CODE1 '
           +'  from MS_CODE '
           +' where CD_STORE  =:P0 '
           +'   and CD_KIND   =''05'' '
           +'   and DS_STATUS =0 '
           +' order by CD_CODE ',
           [Common.Config.StoreCode]);
  MemberClassComboBox.Properties.Items.Clear;
  while not Common.Query.Eof do
  begin
    New(vCode);
    vCode^.Data := Common.Query.Fields[0].AsString;
    MemberClassComboBox.Properties.Items.AddObject(Common.Query.Fields[1].AsString, TObject(vCode));
    Common.Query.Next;
  end;
  Common.Query.Close;

  MemberClassComboBox.ItemIndex := 0;
  PinPadButton.Visible := Common.Config.SmartPad;
  TelNo := '';
end;

procedure TMemberAdd_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_RETURN) then
  begin
    if not RemarkMemo.Focused then
      SelectNext(TWinControl(ActiveControl), true,  true);
  end;
end;

procedure TMemberAdd_F.FormShow(Sender: TObject);
begin
  inherited;
  Common.Device.OnScannerReadData := ScannerReadEvent;

  if IsNew then
  begin
    MemberCodeLabel.Caption := GetMemberCode;

    CaptionLabel.Caption := '회원등록';

    MemberNameEdit.Clear;
    CardNoEdit.Clear;
    MobileEdit.Clear;
    HomeTelEdit.Clear;
    edt_CashRcpNo.Clear;
    RemarkMemo.Clear;
    edt_Addr1.Clear;
    edt_Addr2.Clear;
    edt_Birthday.Clear;
    MobileEdit.Text := TelNo;
  end
  else
    CaptionLabel.Caption := '회원수정';

  MemberNameEdit.EditModified := false;
  CardNoEdit.EditModified     := false;
  MobileEdit.EditModified     := false;

  chklunar.Visible := IsNew;
  //두번눌리는현상 방지
  ClickTime         := IncSecond(Now,-3);
  BlockInput(false);
  Common.SetLanguage(Self);
//  ShowVirtualKeyboard;
end;


procedure TMemberAdd_F.CardNoEditExit(Sender: TObject);
   function Get2Track(AValue:String):String;
   var I   :Integer;
   begin
      Result := '';
      For I:=1 to Length(AValue) do
      begin
         Case AValue[I] of
           #48..#57, #61: Result := Result + AValue[I];
         end;
      end;
   end;
begin
  inherited;
  if Trim((Sender as TcxTextEdit).Text) = '' then Exit;

  if Length((Sender as TcxTextEdit).Text) > 16 then
  begin
    if ((Sender as TcxTextEdit).Text[1] = ';') or ((Sender as TcxTextEdit).Text[1] = '?') or ((Sender as TcxTextEdit).Text[1] = '#') then
    begin
      if Pos('=',(Sender as TcxTextEdit).Text) > 0 then
        (Sender as TcxTextEdit).Text    := Get2Track(Copy((Sender as TcxTextEdit).Text,2,Pos('=',(Sender as TcxTextEdit).Text)-2))
      else
        (Sender as TcxTextEdit).Text    := GetOnlyNumber((Sender as TcxTextEdit).Text);
    end
    else
    begin
      if Pos('=',(Sender as TcxTextEdit).Text) > 0 then
        (Sender as TcxTextEdit).Text  := Get2Track(Copy((Sender as TcxTextEdit).Text,1,Pos('=',(Sender as TcxTextEdit).Text)-1))
      else
        (Sender as TcxTextEdit).Text    := GetOnlyNumber((Sender as TcxTextEdit).Text);
    end;
  end
  else if ((Sender as TcxTextEdit).Text[1] = ';') or ((Sender as TcxTextEdit).Text[1] = '?') or ((Sender as TcxTextEdit).Text[1] = '#') then
  begin
    (Sender as TcxTextEdit).Text := GetOnlyNumber((Sender as TcxTextEdit).Text);
  end;
end;

procedure TMemberAdd_F.MobileEditExit(Sender: TObject);
begin
  inherited;
  (Sender as TcxTextEdit).Text := SetTelephone((Sender as TcxTextEdit).Text);
end;

function TMemberAdd_F.GetMemberCode: String;
begin
  Result := EmptyStr;
  DM.OpenCloud('select Ifnull(Max(CD_MEMBER),''0'') '
              +'  from MS_MEMBER '
              +' where CD_HEAD  = :P0 '
              +'   and CD_STORE = :P1'
              +'   and Length(CD_MEMBER) = 10 '
              +'   and Left(CD_MEMBER,:P3) =:P2 ',
             [Common.Config.HeadStoreCode,
              Ifthen(GetHeadOption(5)='0',Common.Config.StoreCode,StandardStore),
              Common.Config.MemberNoPrefix,
              Length(Common.Config.MemberNoPrefix)],Common.RestDBURL);

   if not DM.CloudData.Eof and (DM.CloudData.Fields[0].AsString = '9999999999') then
   begin
     Common.MsgBox('회원번호를 자동으로 증가할 수 없습니다');
     Exit;
   end;

  if DM.CloudData.Eof or (DM.CloudData.Fields[0].AsString = '0') then
    Result := RPad(Common.Config.MemberNoPrefix, 10, '0')
  else
    Result := DM.CloudData.Fields[0].AsString;

   Result := Common.Config.MemberNoPrefix + LPad(IntToStr(StrToInt64(RightStr(Result,10-Length(Common.Config.MemberNoPrefix)))+1), 10-Length(Common.Config.MemberNoPrefix), '0');
   DM.CloudData.Close;
end;


procedure TMemberAdd_F.KeyBoardButtonClick(Sender: TObject);
begin
  inherited;
  if FocusObject is TcxTextEdit then
    (FocusObject as TcxTextEdit).SetFocus
  else if FocusObject is TcxMaskEdit then
    (FocusObject as TcxMaskEdit).SetFocus
  else if FocusObject is TcxMemo then
    (FocusObject as TcxMemo).SetFocus
  else if FocusObject is TcxCheckBox then
    (FocusObject as TcxCheckBox).SetFocus;
end;

procedure TMemberAdd_F.MemberNameEditExit(Sender: TObject);
begin
  inherited;
  Keybd_Event(VK_RETURN,VK_RETURN, 0, 0);
end;


procedure TMemberAdd_F.MemberNameEditFocusChanged(Sender: TObject);
begin
  inherited;
  FocusObject := Sender;
end;

procedure TMemberAdd_F.SaveButtonClick(Sender: TObject);
var vSeq   :Integer;
    vCode  :String;
    vPoint :Integer;
    vTemp  :String;
    vMobileNo :String;
begin
  inherited;
  if Length(MemberCodeLabel.Caption) <> 10 then
  begin
    Common.ErrBox('회원코드가 올바르지 않습니다');
    Exit;
  end;
  if (GetOption(150) = '0') and (Trim(MemberNameEdit.Text) = EmptyStr) then
  begin
    Common.ErrBox('회원명을 입력하세요');
    Exit;
  end;

  if IsNew and (Trim(MobileEdit.Text) = '' ) and (Trim(HomeTelEdit.Text) = '' ) then
  begin
    if (Trim(MemberNameEdit.Text) <> EmptyStr) then
    begin
      if not Common.AskBox('전화번호가 없습니다'#13'저장 하시겠습니까?') then Exit;
    end
    else
    begin
      Common.MsgBox('전화번호를 입력하세요');
      Exit;
    end;
  end;

  if (Trim(MemberNameEdit.Text) <> '') and MemberNameEdit.EditModified then
  begin
    DM.OpenCloud('select Count(*), '
                +'       GetPhoneNo(AES_Decrypt(Max(TEL_MOBILE),71483)) as TEL_MOBILE '
                +'  from MS_MEMBER '
                +' where CD_HEAD   =:P0 '
                +'   and CD_STORE  =:P1 '
                +'   and NM_MEMBER =:P2'
                +Ifthen(IsNew, '', ' and CD_MEMBER <> '''+MemberCodeLabel.Caption+''''),
                [Common.Config.HeadStoreCode,
                 Ifthen(GetHeadOption(5)='0',Common.Config.StoreCode,StandardStore),
                 MemberNameEdit.Text],Common.RestDBURL);
    if DM.CloudData.Fields[0].AsInteger > 0 then
    begin
      if not Common.AskBox(Format('이름이 같은 회원이 있습니다'#13'( %s )'#13'저장 하시겠습니까?',[DM.CloudData.Fields[1].AsString])) then
      begin
        DM.CloudData.Close;
        MemberNameEdit.SetFocus;
        Exit;
      end;
      DM.CloudData.Close;
    end;
  end;

  if (Trim(MobileEdit.Text) <> '') and MobileEdit.EditModified then
  begin
    DM.OpenCloud('select Count(*), '
                +'       Max(NM_MEMBER) '
                +'  from MS_MEMBER '
                +' where CD_HEAD    =:P0 '
                +'   and CD_STORE   =:P1 '
                +'   and TEL_MOBILE = AES_Encrypt(:P2,71483) '
                +Ifthen(IsNew, '', ' and CD_MEMBER <> '''+MemberCodeLabel.Caption+''''),
                [Common.Config.HeadStoreCode,
                 Ifthen(GetHeadOption(5)='0',Common.Config.StoreCode,StandardStore),
                 GetOnlyNumber(MobileEdit.Text)],Common.RestDBURL);
    if DM.CloudData.Fields[0].AsInteger > 0 then
    begin
      if not Common.AskBox(Format('이미 등록 된 전화번호입니다'#13'( %s )'#13'저장 하시겠습니까?',[DM.CloudData.Fields[1].AsString])) then
      begin
        DM.CloudData.Close;
        MobileEdit.SetFocus;
        Exit;
      end;
      DM.CloudData.Close;
    end;
  end;

  if (Trim(CardNoEdit.Text) <> '') and CardNoEdit.EditModified then
  begin
    DM.OpenCloud('select Count(*), '
                +'       Max(NM_MEMBER) '
                +'  from MS_MEMBER '
                +' where CD_HEAD    =:P0 '
                +'   and CD_STORE   =:P1 '
                +'   and NO_CARD    =:P2 '
                +Ifthen(IsNew, '', ' and CD_MEMBER <> '''+MemberCodeLabel.Caption+''''),
                [Common.Config.HeadStoreCode,
                 Ifthen(GetHeadOption(5)='0',Common.Config.StoreCode,StandardStore),
                 CardNoEdit.Text],Common.RestDBURL);
    if DM.CloudData.Fields[0].AsInteger > 0 then
    begin
      DM.CloudData.Close;
      Common.ErrBox('이미 등록 된 카드번호입니다');
      CardNoEdit.SetFocus;
      Exit;
    end;
  end;
  DM.CloudData.Close;
  chkTrust.PostEditValue;
  chkGender.PostEditValue;
  chkSms.PostEditValue;

  DamdangCode := EmptyStr;
  if GetOption(345) = '1' then
  begin
    Common.ShowChooseForm('T','',DamdangCode, vTemp);
  end;

  if Common.SaveMemberAdd(isNew,
                          MemberCodeLabel.Caption,
                          MemberNameEdit.Text,
                          GetStrPointerData(MemberClassComboBox),
                          Ifthen(chkGender.Checked, '0','1'),
                          GetOnlyNumber(HomeTelEdit.Text),
                          GetOnlyNumber(MobileEdit.Text),
                          CardNoEdit.Text,
                          PostButton.Hint,
                          SCopy(edt_Addr1.Text,1,40),
                          edt_Addr2.Text,
                          edt_CashRcpNo.Text,
                          '',
                          '',
                          Ifthen(chklunar.Checked, 'Y','N'),
                          Ifthen(chkTrust.Checked, 'Y','N'),
                          Ifthen(chkSms.Checked, 'Y','N'),
                          CtoC(edt_Birthday.Text,'-',''),
                          DamdangCode,
                          RemarkMemo.Text,
                          '',
                          '') then
  begin
    ModalResult := mrOK;
  end;
end;

procedure TMemberAdd_F.ScannerReadEvent(const S: String);
begin
  CardNoEdit.Text := S;
  Common.Device.NFCData := '';
end;

procedure TMemberAdd_F.PinPadButtonClick(Sender: TObject);
begin
  inherited;
  if MilliSecondsBetween(Now(),ClickTime) < 1500 then Exit;
  ClickTime := Now;
  if Common.Config.SmartPad then
  begin
    Common.PadWaitForm('고객이 전화번호를 입력 중 입니다...',
                       #2+'keypad'
                      +#2+'3'
                      +#2+'0'
                      +#2+'전화번호를 입력해주세요'
                      +#2+'0'
                      +#2+'60');
  end;
end;

procedure TMemberAdd_F.PostButtonClick(Sender: TObject);
var
  vZipNo, vRoadAddr, vJibunAddr: string;
begin
  inherited;
  if TFrmZipPopup.Execute(vZipNo, vRoadAddr, vJibunAddr) then
  begin
    PostButton.Hint := vZipNo;
    edt_Addr1.Text := vRoadAddr;
    edt_Addr2.Text := '';
    edt_Addr2.SetFocus;
  end;
end;

procedure TMemberAdd_F.RemarkMemoEnter(Sender: TObject);
begin
  inherited;
  RemarkMemo.SelStart := Length(RemarkMemo.Text)+1;
end;

procedure TMemberAdd_F.edt_Addr2Enter(Sender: TObject);
begin
  inherited;
  edt_Addr2.SelStart := Length(edt_Addr2.Text)+1;

end;

end.


