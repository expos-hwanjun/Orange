unit KitchenMemo_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxLabel,
  AdvSmoothToggleButton, Vcl.Menus, dxGDIPlusClasses, cxButtons, AdvGlassButton,
  cxTextEdit, PosButton, AdvSmoothButton;

type TMemoMode = (mmKitchenMemo, mmService);  //주방메모, 서비스사유
//주방메모는 메모내용을 저장
//서비스사유는 사유코드를 저장

type
  TKitchenMemo_F = class(TForm)
    TitleLabel: TLabel;
    CloseButton: TcxButton;
    MessageLabel: TLabel;
    Image3: TImage;
    MemoEdit: TcxTextEdit;
    Image1: TImage;
    Memo1Button: TPosButton;
    Memo2Button: TPosButton;
    Memo3Button: TPosButton;
    Memo4Button: TPosButton;
    Memo5Button: TPosButton;
    Memo6Button: TPosButton;
    Memo7Button: TPosButton;
    Memo8Button: TPosButton;
    Memo9Button: TPosButton;
    Memo10Button: TPosButton;
    Memo11Button: TPosButton;
    Memo12Button: TPosButton;
    Memo13Button: TPosButton;
    Memo14Button: TPosButton;
    Memo15Button: TPosButton;
    Memo16Button: TPosButton;
    Memo17Button: TPosButton;
    Memo18Button: TPosButton;
    Memo19Button: TPosButton;
    Memo20Button: TPosButton;
    PriorButton: TPosButton;
    NextButton: TPosButton;
    ConfirmButton: TAdvSmoothButton;
    KeyBoardButton: TAdvSmoothButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure Memo1ButtonClick(Sender: TObject);
    procedure PriorButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure KeyBoardButtonClick(Sender: TObject);
  private
    ButtonMaxCount :Integer;
    ButtonData      :Array of Array of String;
    ButtonPage :Integer;
    FMemoMode : TMemoMode;
    SelectedCount: Integer;
    procedure SetButtonData;
    procedure SelectData;
    procedure SetMemoMode(const Value: TMemoMode);
    property  MemoMode:TMemoMode read FMemoMode write SetMemoMode;
    procedure ShowVirtualKeyboard;
  public
    MemoType :TMemoMode;
    MenuCode :String;
    MemoStr  :String;
  end;

var
  KitchenMemo_F: TKitchenMemo_F;

implementation
uses Common_U, GlobalFunc_U;
{$R *.dfm}

procedure TKitchenMemo_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TKitchenMemo_F.ConfirmButtonClick(Sender: TObject);
begin
  MemoStr := MemoEdit.Text;
  if MemoStr <> '' then
  begin
    Common.WriteLog('work', MemoStr);
    ModalResult := mrOK;
  end
  else Close;
end;

procedure TKitchenMemo_F.FormCreate(Sender: TObject);
var vIndex :Integer;
begin
  OnShow := FormShow;
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(KeyBoardButton);
  Common.SetButtonColor(ConfirmButton);
  for vIndex := 1 to 20 do
  begin
    TPosButton(FindComponent(Format('Memo%dButton',[vIndex]))).Visible          := False;
    TPosButton(FindComponent(Format('Memo%dButton',[vIndex]))).Color            := Common.Config.PluMenuColor;
    TPosButton(FindComponent(Format('Memo%dButton',[vIndex]))).BorderColor      := Common.Config.PluMenuBorderColor;
    TPosButton(FindComponent(Format('Memo%dButton',[vIndex]))).BorderStyle      := pbsSingle;
    TPosButton(FindComponent(Format('Memo%dButton',[vIndex]))).Font             := Common.Config.PluMenuFont;
    TPosButton(FindComponent(Format('Memo%dButton',[vIndex]))).Font.Size        := Common.Config.PluMenuFont.Size + 2;
    TPosButton(FindComponent(Format('Memo%dButton',[vIndex]))).BorderInnerColor := clNone;
    TPosButton(FindComponent(Format('Memo%dButton',[vIndex]))).Bottom.Font      := Common.Config.PluMenuFont;
  end;
  PriorButton.Color := Common.Config.PluMenuColor;
  PriorButton.Font  := Common.Config.PluMenuFont;
  PriorButton.BorderStyle := pbsSingle;
  PriorButton.BorderColor := Common.Config.PluMenuBorderColor;
  PriorButton.BorderInnerColor := clNone;
  NextButton.Color  := Common.Config.PluMenuColor;
  NextButton.Font   := Common.Config.PluMenuFont;
  NextButton.BorderStyle := pbsSingle;
  NextButton.BorderColor := Common.Config.PluMenuBorderColor;
  NextButton.BorderInnerColor := clNone;
end;

procedure TKitchenMemo_F.FormShow(Sender: TObject);
begin
  MemoMode := MemoType;
  SelectData;
end;

procedure TKitchenMemo_F.KeyBoardButtonClick(Sender: TObject);
begin
  ShowVirtualKeyboard;
  MemoEdit.SetFocus;
end;

procedure TKitchenMemo_F.Memo1ButtonClick(Sender: TObject);
var
  i: Integer;
  vIndex :Integer;
begin
  if (Sender as TPosButton).Caption = '' then Exit;

  vIndex := (Sender as TPosButton).Tag;
  case MemoMode of
    mmKitchenMemo :
    begin
      if (Sender as TPosButton).BorderColor <> clRed then
      begin
        if SelectedCount < 5 then
        begin
          (Sender as TPosButton).BorderColor := clRed;
          ButtonData[((ButtonPage-1)*20) + vIndex, 2] := '1';
          Inc(SelectedCount);
        end;
      end
      else
      begin
        (Sender as TPosButton).BorderColor := Common.Config.PluMenuBorderColor;
        ButtonData[((ButtonPage-1)*20) + vIndex, 2] := '0';
        Dec(SelectedCount);
      end;

      MemoEdit.Text := EmptyStr;
      MemoStr          := EmptyStr;
      for vIndex := 0 to High(ButtonData) do
      begin
        if ButtonData[vIndex, 2] = '1' then
          MemoStr  := MemoStr  + ButtonData[vIndex, 1] + '+';
      end;

      if (MemoStr <> EmptyStr)  then Delete(MemoStr, Length(MemoStr), 1);
      MemoEdit.Text := MemoStr;
      MemoStr := EmptyStr;
    end;
    mmService:
    begin
      MemoStr := (Sender as TPosButton).Hint;
      ModalResult := mrOK;
    end;
  end;
end;

procedure TKitchenMemo_F.SelectData;
var vIndex :Integer;
begin
  MemoStr := '';
  if MemoMode = mmKitchenMemo then
  begin
    OpenQuery('select b.NM_CODE1 '
             +'  from MS_MENU_MEMO a inner join '
             +'       MS_CODE      b on a.CD_STORE = b.CD_STORE '
             +'                     and a.CD_MEMO  = b.CD_CODE '
             +'                     and b.CD_KIND  = ''16'' '
             +' where a.CD_STORE = :P0 '
             +'   and a.CD_MENU  = :P1 '
             +'   and b.DS_STATUS =''0'' '
             +' order by b.CD_CODE ',
             [Common.Config.StoreCode,
              MenuCode]);
    if Common.Query.Eof then
      OpenQuery('select NM_CODE1 '
               +'  from MS_CODE '
               +' where CD_STORE =:P0 '
               +'   and CD_KIND = ''16'' '
               +'   and DS_STATUS =''0'' '
               +' order by CD_CODE ',
               [Common.Config.StoreCode]);
  end
  else if MemoMode = mmService then
  begin
    OpenQuery('select CD_CODE, '
             +'       NM_CODE1 '
             +'  from MS_CODE '
             +' where CD_STORE  =:P0 '
             +'   and CD_KIND   =''23'' '
             +'   and DS_STATUS =''0'' '
             +' order by CD_CODE ',
             [Common.Config.StoreCode]);
  end;

  ButtonMaxCount := 0;
  while not Common.Query.Eof do
  begin
    ButtonMaxCount := ButtonMaxCount + 1;
    Common.Query.Next;
  end;

  SetLength(ButtonData, ButtonMaxCount, 3);
  ButtonPage := 1;

  Common.Query.First;
  vIndex := 0;
  while not Common.Query.Eof do
  begin
    if MemoMode = mmService then
    begin
      ButtonData[vIndex, 0] := Common.Query.Fields[0].AsString;
      ButtonData[vIndex, 1] := Common.Query.Fields[1].AsString;
    end
    else
      ButtonData[vIndex, 1] := Common.Query.Fields[0].AsString;

    ButtonData[vIndex, 2] := '0';
    Inc(vIndex);
    Common.Query.Next;
  end;
  Common.Query.Close;
  SetButtonData;
end;

procedure TKitchenMemo_F.SetMemoMode(const Value: TMemoMode);
begin
  FMemoMode := Value;
  case FMemoMode of
    mmKitchenMemo : TitleLabel.Caption := '주방메모';
    mmService     :
    begin
      ConfirmButton.Visible := false;
      TitleLabel.Caption     := '서비스사유';
    end;
  end;
end;


procedure TKitchenMemo_F.ShowVirtualKeyboard;
  function FindTrayButtonWindow: THandle;
  var
    ShellTrayWnd: THandle;
    TrayNotifyWnd: THandle;
  begin
    Result := 0;
    ShellTrayWnd := FindWindow('Shell_TrayWnd', nil);
    if ShellTrayWnd > 0 then
    begin
      TrayNotifyWnd := FindWindowEx(ShellTrayWnd, 0, 'TrayNotifyWnd', nil);
      if TrayNotifyWnd > 0 then
      begin
        Result := FindWindowEx(TrayNotifyWnd, 0, 'TIPBand', nil);
      end;
    end;
  end;
var vHandle :THandle;
    SystemPath :String;
begin
//  Keybd_Event(VK_CONTROL, MapVirtualKey(VK_CONTROL, 0), 0, 0 );
//  Keybd_Event(VK_LWIN, MapVirtualKey(VK_LWIN, 0), 0, 0 );
//  Keybd_Event(Ord('O'), MapVirtualKey(Ord('O'), 0), 0, 0 );
//  Exit;
  if Common.isWindow7 then
  begin
    ExcuteProgram('c:\Windows\system32\osk.exe');
  end
  else
  begin
    vHandle := FindTrayButtonWindow;
    if vHandle > 0 then
    begin
      PostMessage(vHandle, WM_LBUTTONDOWN, MK_LBUTTON, $00010001);
      PostMessage(vHandle, WM_LBUTTONUP, 0, $00010001);
    end;
  end;
end;

procedure TKitchenMemo_F.SetButtonData;
var vIndex :Integer;
begin
  For vIndex := 1 to 20 do
  begin
    TPosButton(FindComponent(Format('Memo%dButton',[vIndex]))).Caption   := '';
    TPosButton(FindComponent(Format('Memo%dButton',[vIndex]))).Hint      := '';
    TPosButton(FindComponent(Format('Memo%dButton',[vIndex]))).Visible   := false;
    TPosButton(FindComponent(Format('Memo%dButton',[vIndex]))).BorderColor      := Common.Config.PluMenuBorderColor;
  end;

  For vIndex := 1  to 20 do
  begin
    if (((ButtonPage-1)*20) + vIndex)  > (High(ButtonData)+1) then Break;

    if MemoMode = mmService then
      TPosButton(FindComponent(Format('Memo%dButton',[vIndex]))).Hint    := ButtonData[((ButtonPage-1)*20) + vIndex-1, 0];
    TPosButton(FindComponent(Format('Memo%dButton',[vIndex]))).Caption   := ButtonData[((ButtonPage-1)*20) + vIndex-1, 1];
    TPosButton(FindComponent(Format('Memo%dButton',[vIndex]))).Visible   := true;
    if ButtonData[((ButtonPage-1)*20) + vIndex-1, 2] = '1' then
      TPosButton(FindComponent(Format('Memo%dButton',[vIndex]))).BorderColor      := clRed;

  end;
  PriorButton.Visible := ButtonPage > 1;
  NextButton.Visible  := ButtonPage  <= ((High(ButtonData)+1) div 19);
end;

procedure TKitchenMemo_F.PriorButtonClick(Sender: TObject);
begin
  if Sender = PriorButton then ButtonPage := ButtonPage -1
  else if Sender = NextButton then ButtonPage := ButtonPage +1;

  SetButtonData;
end;

end.
