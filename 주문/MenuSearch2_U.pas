unit MenuSearch2_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxLabel, cxTextEdit, ExtCtrls, StdCtrls,
  Vcl.Menus, cxButtons, AdvGlassButton, dxGDIPlusClasses,
  AdvSmoothToggleButton, PosButton, AdvSmoothButton, StrUtils;

type
  TMenuSearch2_F = class(TForm)
    MenuNameEdit: TcxTextEdit;
    TitleLabel: TLabel;
    MessageLabel: TLabel;
    Image3: TImage;
    CaptionLabel: TcxLabel;
    CloseButton: TcxButton;
    Menu1Button: TPosButton;
    Menu3Button: TPosButton;
    Menu4Button: TPosButton;
    Menu5Button: TPosButton;
    Menu6Button: TPosButton;
    Menu2Button: TPosButton;
    Menu8Button: TPosButton;
    Menu9Button: TPosButton;
    Menu10Button: TPosButton;
    Menu7Button: TPosButton;
    Menu11Button: TPosButton;
    Menu13Button: TPosButton;
    Menu14Button: TPosButton;
    Menu15Button: TPosButton;
    Menu16Button: TPosButton;
    Menu12Button: TPosButton;
    Menu18Button: TPosButton;
    Menu19Button: TPosButton;
    Menu20Button: TPosButton;
    Menu17Button: TPosButton;
    Menu21Button: TPosButton;
    Menu23Button: TPosButton;
    Menu24Button: TPosButton;
    Menu25Button: TPosButton;
    Menu22Button: TPosButton;
    SearchButton: TAdvSmoothButton;
    ClearButton: TAdvSmoothButton;
    AdvSmoothButton1: TAdvSmoothButton;
    AdvSmoothButton2: TAdvSmoothButton;
    AdvSmoothButton3: TAdvSmoothButton;
    AdvSmoothButton4: TAdvSmoothButton;
    AdvSmoothButton5: TAdvSmoothButton;
    AdvSmoothButton6: TAdvSmoothButton;
    AdvSmoothButton7: TAdvSmoothButton;
    AdvSmoothButton8: TAdvSmoothButton;
    AdvSmoothButton9: TAdvSmoothButton;
    AdvSmoothButton10: TAdvSmoothButton;
    AdvSmoothButton11: TAdvSmoothButton;
    AdvSmoothButton12: TAdvSmoothButton;
    AdvSmoothButton13: TAdvSmoothButton;
    AdvSmoothButton14: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuNameEditKeyPress(Sender: TObject; var Key: Char);
    procedure AdvSmoothToggleButton26Click(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure Menu1ButtonClick(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
  private
    ButtonMaxCount :Integer;
    ButtonData      :Array of Array of String;
    ButtonPage :Integer;
    procedure SetButtonData;
    procedure SelectData(aChosung:Boolean);
  public
    SelectCode,
    SelectName :String;
    isOnlySearch :Boolean;
  end;

var
  MenuSearch2_F: TMenuSearch2_F;

implementation
uses Common_U, GlobalFunc_U;

{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';
procedure TMenuSearch2_F.FormCreate(Sender: TObject);
var vIndex :Integer;
begin
  Common.LogoCreate(Self,2);
  for vIndex := 0 to ComponentCount-1 do
    if Components[vIndex] is TAdvSmoothButton then
      Common.SetButtonColor((Components[vIndex] as TAdvSmoothButton));

  isOnlySearch := false;
end;

procedure TMenuSearch2_F.SearchButtonClick(Sender: TObject);
begin
  if MenuNameEdit.Text <> '' then
    SelectData(false);
end;

procedure TMenuSearch2_F.SelectData(aChosung:Boolean);
var vIndex :Integer;
begin
  OpenQuery('select a.CD_MENU, '
           +'       ifnull(b.NM_MENU_SHORT, a.NM_MENU_SHORT) as NM_MENU_SHORT, '
           +Ifthen(GetOption(194)='1','GetSalePrice(a.CD_STORE, a.CD_MENU) as PR_SALE, ', 'a.PR_SALE, ')
           +'       case when a.DS_MENU_TYPE = ''N'' then (select Count(*) '
           +'                                                from MS_MENU '
           +'                                               where CD_STORE =a.CD_STORE '
           +'                                                 and CD_MENU  =a.CD_MENU '
           +'                                                 and DS_MENU_TYPE = ''I'' '
           +'                                                 and YN_USE   = ''Y'') '
           +'            else 0 end as ITEM_COUNT, '
           +'       (select count(*) CNT '
           +'          from MS_MENU_MEMO '
           +'         where CD_STORE = a.CD_STORE '
           +'           and CD_MENU  = a.CD_MENU) as MEMO_COUNT, '
           +'       a.DS_MENU_TYPE '
           +'  from MS_MENU as a left outer join '
           +'      (select CD_MENU, '
           +'              Max(NM_VIEW) as NM_MENU_SHORT '
           +'         from MS_SMALL '
           +'        where CD_STORE =:P0 '
           +'        group by CD_MENU) as b on b.CD_MENU = a.CD_MENU '
           +' where a.CD_STORE =:P0 '
           +'   and a.DS_MENU_TYPE <> ''P'' '
           +'   and ( (a.CD_MENU = :P1) or (a.NM_MENU like ConCat(''%'',:P1,''%'')) or (GetChosung(a.NM_MENU) like ConCat(''%'',:P1,''%'')) ) '
           +' order by a.NM_MENU '
           +' limit 31 ',
           [Common.Config.StoreCode,
            MenuNameEdit.Text]);

  ButtonMaxCount := 0;
  while not Common.Query.Eof do
  begin
    ButtonMaxCount := ButtonMaxCount + 1;
    Common.Query.Next;
  end;

  SetLength(ButtonData, ButtonMaxCount, 6);
  ButtonPage := 1;

  vIndex := 0;
  if ButtonMaxCount > 0 then
    Common.Query.First;

  while not Common.Query.Eof do
  begin
    ButtonData[vIndex, 0] := Common.Query.Fields[0].AsString;  //메뉴코드
    ButtonData[vIndex, 1] := Common.GetPaPago(Common.Query.Fields[1].AsString);  //메뉴이름
    ButtonData[vIndex, 2] := FormatFloat('#,0원',Common.Query.Fields[2].AsCurrency);  //판매단가
    ButtonData[vIndex, 3] := Common.Query.Fields[3].AsString;  //아이템수량
    ButtonData[vIndex, 4] := Common.Query.Fields[4].AsString;  //주방메모수량
    ButtonData[vIndex, 5] := Common.Query.Fields[5].AsString;  //메뉴구분
    Inc(vIndex);
    Common.Query.Next;
  end;
  Common.Query.Close;
  SetButtonData;
end;

procedure TMenuSearch2_F.SetButtonData;
var vIndex :Integer;
begin
  For vIndex := 1 to 25 do
  begin
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Caption            := '';
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Bottom.RightString := '';
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Hint               := '';
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Temp1              := '';
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Temp2              := '';
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Temp3              := '';
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Visible            := false;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Color              := Common.Config.PLUMenuColor;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).BorderColor        := Common.Config.PluMenuBorderColor;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).BorderStyle        := pbsSingle;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Font               := Common.Config.PLUMenuFont;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Font.Size        := Common.Config.PluMenuFont.Size + 1;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Bottom.Font      := Common.Config.PluMenuFont;

  end;

  For vIndex := 1  to 25 do
  begin
    if ( ((ButtonPage-1)*25) + vIndex ) > High(ButtonData)+1 then Continue;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Caption := LineFeed(ButtonData[((ButtonPage-1)*25) + vIndex-1, 1]);
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Bottom.RightString := ButtonData[((ButtonPage-1)*25) + vIndex-1, 2];     //판매단가
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Hint               := ButtonData[((ButtonPage-1)*25) + vIndex-1, 0];     //메뉴코드
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Temp1              := ButtonData[((ButtonPage-1)*25) + vIndex-1, 3];     //아이템수량
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Temp2              := ButtonData[((ButtonPage-1)*25) + vIndex-1, 4];     //주방메모수량
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Temp3              := ButtonData[((ButtonPage-1)*25) + vIndex-1, 5];     //메뉴구분
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Temp4              := ButtonData[((ButtonPage-1)*25) + vIndex-1, 1];     //Result 용
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Visible            := true;
  end;
//  obtn_Prev.Visible := ButtonPage > 1;
//  obtn_Next.Visible := ButtonPage <= (ButtonMaxCount div 30);
end;

procedure TMenuSearch2_F.FormShow(Sender: TObject);
var vIndex :Integer;
begin
  BlockInput(false);
  for vIndex := 1 to 25 do
  begin
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Visible          := False;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Color            := Common.Config.PluMenuColor;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).BorderColor      := Common.Config.PluMenuBorderColor;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).BorderStyle      := pbsSingle;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Font             := Common.Config.PluMenuFont;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Font.Size        := Common.Config.PluMenuFont.Size + 2;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).BorderInnerColor := clNone;
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Bottom.Font      := Common.Config.PluMenuFont;
  end;
  MenuNameEdit.Clear;
  ButtonPage := 1;
  SetButtonData;
  Common.SetLanguage(Self);
end;

procedure TMenuSearch2_F.Menu1ButtonClick(Sender: TObject);
var vHandle   :THandle;
    vSendData :AnsiString;
    vData     : TCopyDataStruct;
begin
  if (Sender as TPosButton).Caption = '' then Exit;              //아이템, 주방메모
  if not isOnlySearch and not ((Sender as TPosButton).Temp3[1] in ['G','C','O']) and ((Sender as TPosButton).Temp1 = '0') and ((Sender as TPosButton).Temp2 = '0') then
  begin
    vHandle := FindWindow('TOrder_F', nil);
    if vHandle > 0 then
    begin
      vSendData    := (Sender as TPosButton).Hint;
      vData.dwData := 0;
      vData.cbData := Length(vSendData)+1;
      vData.lpData := PAnsiChar(vSendData);
      SendMessage(vHandle, WM_COPYDATA, Self.Handle, Integer(@vData));
    end;
    MenuNameEdit.Clear;
    Exit;
  end
  else
  begin
    SelectCode := (Sender as TPosButton).Hint;
    SelectName := (Sender as TPosButton).Temp4;
    MenuNameEdit.Clear;
    ModalResult := mrOK;
  end;
end;

procedure TMenuSearch2_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TMenuSearch2_F.ClearButtonClick(Sender: TObject);
var vIndex :Integer;
begin
  MenuNameEdit.Clear;
  For vIndex := 1 to 25 do
  begin
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Caption            := '';
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Bottom.RightString := '';
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Hint               := '';
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Temp1              := '';
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Temp2              := '';
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Temp3              := '';
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Temp4              := '';
    TPosButton(FindComponent(Format('Menu%dButton',[vIndex]))).Visible            := false;
  end;
end;

procedure TMenuSearch2_F.AdvSmoothToggleButton26Click(Sender: TObject);
const
  vChar :Array[1..14] of String =('ㄱ','ㄴ','ㄷ','ㄹ','ㅁ','ㅂ','ㅅ','ㅇ','ㅈ','ㅊ','ㅋ','ㅌ','ㅍ','ㅎ');
begin
  MenuNameEdit.Text := MenuNameEdit.Text + vChar[(Sender as TAdvSmoothButton).Tag];
  MenuNameEdit.SelStart := Length(MenuNameEdit.Text);
  SelectData(true);
end;

procedure TMenuSearch2_F.MenuNameEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    SearchButton.Click;
end;

end.
