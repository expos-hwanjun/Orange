unit CustomerInfo_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math, KeyPad_F, jpeg, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer,
  cxEdit, cxLabel, dxGDIPlusClasses, cxButtons, AdvGlassButton,
  AdvSmoothToggleButton, cxTextEdit, StrUtils, AdvSmoothButton;

type
  TCustomerInfo_F = class(TForm)
    fmKeyPad1: TfmKeyPad;
    TitleLabel: TLabel;
    CloseButton: TcxButton;
    MessageLabel: TLabel;
    Image3: TImage;
    CaptionLabel: TcxLabel;
    cxLabel1: TcxLabel;
    Image1: TImage;
    Image2: TImage;
    GuestLabel: TcxLabel;
    GuestEdit: TcxTextEdit;
    cxLabel3: TcxLabel;
    TotalCountLabel: TcxLabel;
    cxLabel2: TcxLabel;
    Age1Button: TAdvSmoothToggleButton;
    Age2Button: TAdvSmoothToggleButton;
    Age3Button: TAdvSmoothToggleButton;
    Age4Button: TAdvSmoothToggleButton;
    Age5Button: TAdvSmoothToggleButton;
    Age6Button: TAdvSmoothToggleButton;
    GuestType1Button: TAdvSmoothToggleButton;
    GuestType2Button: TAdvSmoothToggleButton;
    GuestType3Button: TAdvSmoothToggleButton;
    GuestType4Button: TAdvSmoothToggleButton;
    GuestType5Button: TAdvSmoothToggleButton;
    GuestType6Button: TAdvSmoothToggleButton;
    ConfirmButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_CustKeyPress(Sender: TObject; var Key: Char);
    procedure edt_CustChange(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure GuestType1ButtonClick(Sender: TObject);
    procedure Age1ButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    FCustCode :String;
    FAgeCode  :String;
  public
    { Public declarations }
  end;

var
  CustomerInfo_F: TCustomerInfo_F;

implementation
uses Common_U, GlobalFunc_U;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TCustomerInfo_F.FormCreate(Sender: TObject);
var vIndex :Integer;
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(ConfirmButton);

  for vIndex := 1 to 6 do
  begin
    TAdvSmoothToggleButton(FindComponent(Format('GuestType%dButton',[vIndex]))).Visible := False;
    TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Visible       := False;
  end;

  //객층버튼 셋팅
  OpenQuery('select * '
           +'  from MS_CODE '
           +' where CD_STORE  =:P0 '
           +'   and CD_KIND   = ''04'' '
           +'   and DS_STATUS = ''0'' '
           +' order by CD_CODE '
           +' limit 6 ',
           [Common.Config.StoreCode]);

  vIndex := 0;
  while not Common.Query.Eof do
  begin
    Inc(vIndex);
    TAdvSmoothToggleButton(FindComponent(Format('GuestType%dButton',[vIndex]))).Caption := Common.Query.FieldByName('nm_code1').AsString;
    TAdvSmoothToggleButton(FindComponent(Format('GuestType%dButton',[vIndex]))).Hint    := Common.Query.FieldByName('cd_code').AsString;
    TAdvSmoothToggleButton(FindComponent(Format('GuestType%dButton',[vIndex]))).Visible := True;
    Common.Query.Next;
  end;

  //연령대 버튼 셋팅
  OpenQuery('select * '
           +'  from MS_CODE '
           +' where CD_STORE  =:P0 '
           +'   and CD_KIND   =''14'' '
           +'   and DS_STATUS =''0'' '
           +' order by CD_CODE '
           +' limit 6 ',
           [Common.Config.StoreCode]);

  vIndex := 0;
  while not Common.Query.Eof do
  begin
    Inc(vIndex);
    TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Caption := Common.Query.FieldByName('nm_code1').AsString;
    TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Hint    := Common.Query.FieldByName('cd_code').AsString;
    TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Visible := True;
    Common.Query.Next;
  end;

  FCustCode := '';
  FAgeCode  := '';
end;

procedure TCustomerInfo_F.FormShow(Sender: TObject);
var vIndex, vCount :Integer;
begin
  BlockInput(false);
  //객층, 연령대 버튼에 이미지 적용
  for vIndex := 1 to 6 do
  begin
    TAdvSmoothToggleButton(FindComponent(Format('GuestType%dButton',[vIndex]))).Appearance.SimpleLayout := false;
    TAdvSmoothToggleButton(FindComponent(Format('GuestType%dButton',[vIndex]))).Down := false;
    TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Appearance.SimpleLayout := false;
    TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Down := false;
    TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Status.Caption := '';
  end;

  //선불제이면 클리어한다
  if Common.Config.IsTakeOut then
    for vIndex := 1 to 6 do
      Common.SetAgeInfo(TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Hint);

  //객층이 이전에 선택된게 있었으면 눌린이미지로 표시
  for vIndex := 1 to 6 do
    if TAdvSmoothToggleButton(FindComponent(Format('GuestType%dButton',[vIndex]))).Hint = Common.Table.CustCode then
    begin
      TAdvSmoothToggleButton(FindComponent(Format('GuestType%dButton',[vIndex]))).Appearance.SimpleLayout := True;
      TAdvSmoothToggleButton(FindComponent(Format('GuestType%dButton',[vIndex]))).Down := true;
      FCustCode := Common.Table.CustCode;
    end;

  for vIndex := 1 to 6 do
    if Common.GetCustomerAgeCount( TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Hint ) > 0 then
    begin
      TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Status.Caption := IntToStr(Common.GetCustomerAgeCount( TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Hint))+'명';
      TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Status.Visible := true;
    end;

  for vIndex := 1 to 6 do
    if Common.GetCustomerAgeCount( TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Hint ) > 0 then
    begin
      TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Appearance.SimpleLayout := True;
      TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Down := true;
      FAgeCode := TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Hint ;
      vCount   := Common.GetCustomerAgeCount( TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Hint );
      Break;
    end;

//  if FAgeCode = '' then FAgeCode := '001';

  if Common.AgeData.Count = 1 then
  begin
    GuestEdit.Text := '0';
    GuestEdit.Tag  := Common.Table.CustomerCount;
  end
  else
  begin
    GuestEdit.Text := IntToStr( Common.GetCustomerAgeCount(FAgeCode) );
    GuestEdit.Tag  := vCount;
  end;
  GuestEdit.SelectAll;
  TotalCountLabel.Caption := IntToStr(Common.Table.CustomerCount);

end;

procedure TCustomerInfo_F.GuestType1ButtonClick(Sender: TObject);
var vIndex :Integer;
begin
  for vIndex := 1 to 6 do
  begin
    TAdvSmoothToggleButton(FindComponent(Format('GuestType%dButton',[vIndex]))).Appearance.SimpleLayout := false;
    TAdvSmoothToggleButton(FindComponent(Format('GuestType%dButton',[vIndex]))).Down := false;
  end;

  (Sender as TAdvSmoothToggleButton).Appearance.SimpleLayout := true;
  (Sender as TAdvSmoothToggleButton).Down := true;

  FCustCode := (Sender as TAdvSmoothToggleButton).Hint;
end;

procedure TCustomerInfo_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  procedure CheckMaxValue(aKey:Word);
  var vTemp :String;
  begin
    vTemp := GuestEdit.Text + Chr(aKey);
    if GuestEdit.Properties.MaxLength >= Length(vTemp) then
      GuestEdit.Text := GuestEdit.Text + Chr(aKey);
  end;
begin
  case Key of
    27      :  begin GuestEdit.Clear; ModalResult := mrOK; end;
    VK_F10  :  GuestEdit.Clear;
    13      :  ConfirmButtonClick(nil);
  end;
end;

procedure TCustomerInfo_F.FormKeyPress(Sender: TObject; var Key: Char);
var vIndex :Integer;
begin
  if Key = #8 then
    GuestEdit.Text := LeftStr(GuestEdit.Text, Length(GuestEdit.Text)-1)
  else
  begin
    if Length(GuestEdit.Text) = 3 then
    begin
      Common.MsgBox('최대 3자리까지만 가능합니다');
      Exit;
    end;
    GuestEdit.Text := IntToStr(StrToIntDef(GuestEdit.Text+Key,0));
  end;

  if GuestEdit.Text = '' then
    GuestEdit.Text := '0';

  for vIndex := 1 to 6 do
  begin
    if TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Appearance.SimpleLayout then
    begin
      if GuestEdit.Text <> '' then
      begin
        TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Status.Caption := GuestEdit.Text+'명';
        TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Status.Visible := true;
      end
      else
      begin
        TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Status.Caption := '';
        TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Status.Visible := false;
      end;
    end;
  end;

end;

procedure TCustomerInfo_F.edt_CustKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then ConfirmButtonClick(nil);
end;

procedure TCustomerInfo_F.Age1ButtonClick(Sender: TObject);
var vIndex :Integer;
begin
  if FAgeCode <> EmptyStr then
    Common.SetCustomerAgeCount(FAgeCode+Lpad(GuestEdit.Text,3,'0') );

  for vIndex := 1 to 6 do
  begin
    TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Appearance.SimpleLayout := false;
    TAdvSmoothToggleButton(FindComponent(Format('Age%dButton',[vIndex]))).Down := false;
  end;

  (Sender as TAdvSmoothToggleButton).Appearance.SimpleLayout := true;
  (Sender as TAdvSmoothToggleButton).Down := true;
  FAgeCode := (Sender as TAdvSmoothToggleButton).Hint;
  if Common.GetCustomerAgeCount( (Sender as TAdvSmoothToggleButton).Hint) > 0 then
  begin
    GuestEdit.Text := IntToStr( Common.GetCustomerAgeCount( (Sender as TAdvSmoothToggleButton).Hint) );
    GuestEdit.Tag  := Common.GetCustomerAgeCount( (Sender as TAdvSmoothToggleButton).Hint);
  end
  else
  begin
    GuestEdit.Text := '';
    GuestEdit.Tag  := 0;
  end;
  GuestEdit.SelectAll;
  TotalCountLabel.Caption := IntToStr(Common.Table.CustomerCount);
  MessageLabel.Caption := '고객수를 입력하세요';
end;

procedure TCustomerInfo_F.CloseButtonClick(Sender: TObject);
begin                                     //고객 수 추정메뉴 기능을 사용합니다.
  if (Common.Table.CustomerCount = 0) and (GetOption(307) = '0') then
  begin
    Common.Table.CustomerCount := 1;
    if Common.AgeData.Count > 0 then
      Common.Table.AgeCode.Strings[0] := Copy(Common.Table.AgeCode.Strings[0],1,3) + FormatFloat('000', Common.Table.CustomerCount);
  end;
  Close;
end;

procedure TCustomerInfo_F.ConfirmButtonClick(Sender: TObject);
var vCount :Integer;
begin
  if GuestEdit.Text <> '0' then
  begin
    Common.Table.CustCode := FCustCode;
    vCount := StrToIntDef(GuestEdit.Text,0) - GuestEdit.Tag;
    if vCount <> 0 then
    begin
      Common.Table.CustomerCount := Common.Table.CustomerCount + vCount;
      TotalCountLabel.Caption    := IntToStr(Common.Table.CustomerCount);
    end;
    if StoI(TotalCountLabel.Caption) = 0 then
      GuestEdit.Text := '001';
    if FAgeCode <> EmptyStr then
      Common.SetCustomerAgeCount(FAgeCode+Lpad(GuestEdit.Text,3,'0') )
    else
      Common.Table.AgeCode.Strings[0] := Copy(Common.Table.AgeCode.Strings[0],1,3) + FormatFloat('000', Common.Table.CustomerCount);
    Common.Table.CustomerCount   := StrToIntDef(GetOnlyNumber(TotalCountLabel.Caption),1);
    if Common.Table.CustomerCount = 0 then
    begin
      Common.Table.CustomerCount := 1;
      if Common.AgeData.Count > 0 then
        Common.Table.AgeCode.Strings[0] := Copy(Common.Table.AgeCode.Strings[0],1,3) + FormatFloat('000', Common.Table.CustomerCount);
    end;
    Common.WriteLog('work', Format('고객수(%d명)',[Common.Table.CustomerCount]));
  end;
  ModalResult := mrOK;
end;

procedure TCustomerInfo_F.edt_CustChange(Sender: TObject);
begin
  Common.SetCustomerAgeCount(FAgeCode+Lpad(GuestEdit.Text,3,'0') );
  TotalCountLabel.Caption := IntToStr(Common.Table.CustomerCount);
end;

end.
