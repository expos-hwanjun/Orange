unit OrderCancel_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxControls,
  cxContainer, cxEdit, cxLabel, cxTextEdit, PosButton, dxGDIPlusClasses,
  Vcl.ExtCtrls, AdvGlassButton, AdvSmoothButton;

type TCancelMode = (cmOrder, cmSale, cmTableMemo);  //주문취소, 매출취소, 테이블메모

type
  TOrderCancel_F = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TcxButton;
    MessageLabel: TLabel;
    Image3: TImage;
    Why1Button: TPosButton;
    Why2Button: TPosButton;
    Why3Button: TPosButton;
    Why4Button: TPosButton;
    Why5Button: TPosButton;
    Why6Button: TPosButton;
    Why7Button: TPosButton;
    Why8Button: TPosButton;
    Why9Button: TPosButton;
    Why10Button: TPosButton;
    Why11Button: TPosButton;
    Why12Button: TPosButton;
    Why13Button: TPosButton;
    Why14Button: TPosButton;
    Why15Button: TPosButton;
    InputEdit: TcxTextEdit;
    Image1: TImage;
    PrevButton: TPosButton;
    NextButton: TPosButton;
    ConfirmButton: TAdvSmoothButton;
    KeyBoardButton: TAdvSmoothButton;
    procedure CloseButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PrevButtonClick(Sender: TObject);
    procedure Why1ButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure KeyBoardButtonClick(Sender: TObject);
  private
    FCancelMode :TCancelMode;
    ButtonData  : Array of Array of String;
    ButtonPage:Integer;
    procedure SetButtonData;

    procedure SetCancelMode(const Value: TCancelMode);
    property CancelMode:TCancelMode read FCancelMode write SetCancelMode;
    procedure ShowVirtualKeyboard;
  public
    CanMode   :TCancelMode;
    TableMemo :String;
  end;

var
  OrderCancel_F: TOrderCancel_F;

implementation
uses Common_U, DBModule_U, Const_U, GlobalFunc_U;
{$R *.dfm}

procedure TOrderCancel_F.ConfirmButtonClick(Sender: TObject);
begin
  if Trim(InputEdit.Text) = '' then
  begin
    Common.MsgBox(CaptionLabel.Caption +'을 입력하세요');
    InputEdit.SetFocus;
    Exit;
  end;
  if CancelMode <> cmTableMemo then
    Common.WhyOrdercancel := InputEdit.Text
  else
    TableMemo := InputEdit.Text;
  ModalResult           := mrOK;
end;

procedure TOrderCancel_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(KeyBoardButton);
  Common.SetButtonColor(ConfirmButton);
end;

procedure TOrderCancel_F.FormShow(Sender: TObject);
begin
  CancelMode := CanMode;
end;

procedure TOrderCancel_F.KeyBoardButtonClick(Sender: TObject);
begin
  ShowVirtualKeyboard;
  InputEdit.SetFocus;
end;

procedure TOrderCancel_F.PrevButtonClick(Sender: TObject);
begin
  if Sender = PrevButton then ButtonPage := ButtonPage - 1
  else                        ButtonPage := ButtonPage + 1;
  SetButtonData;
end;

procedure TOrderCancel_F.SetButtonData;
var vIndex :Integer;
begin
  For vIndex := 1 to 15 do
  begin
    TPosButton(FindComponent(Format('Why%dButton',[vIndex]))).Hint         := '';
    TPosButton(FindComponent(Format('Why%dButton',[vIndex]))).Caption      := '';
    TPosButton(FindComponent(Format('Why%dButton',[vIndex]))).Visible      := false;
    TPosButton(FindComponent(Format('Why%dButton',[vIndex]))).Color        := Common.Config.PluMenuColor;
    TPosButton(FindComponent(Format('Why%dButton',[vIndex]))).BorderColor  := Common.Config.PluMenuBorderColor;
    TPosButton(FindComponent(Format('Why%dButton',[vIndex]))).BorderStyle  := pbsSingle;
    TPosButton(FindComponent(Format('Why%dButton',[vIndex]))).BorderInnerColor := clNone;
    TPosButton(FindComponent(Format('Why%dButton',[vIndex]))).Color        := Common.Config.PluMenuColor;
    TPosButton(FindComponent(Format('Why%dButton',[vIndex]))).Font         := Common.Config.PluMenuFont;
    TPosButton(FindComponent(Format('Why%dButton',[vIndex]))).Font.Size    := Common.Config.PluMenuFont.Size + 2;
  end;
  PrevButton.BorderInnerColor := clNone;
  NextButton.BorderInnerColor := clNone;

  For vIndex := 1  to 15 do
  begin
    if (((ButtonPage-1)*15) + vIndex ) > High(ButtonData)+1 then Continue;

    TPosButton(FindComponent(Format('Why%dButton',[vIndex]))).Hint    := ButtonData[((ButtonPage-1)*18+vIndex-1), 0];
    TPosButton(FindComponent(Format('Why%dButton',[vIndex]))).Caption := ButtonData[((ButtonPage-1)*18+vIndex-1), 1];
    TPosButton(FindComponent(Format('Why%dButton',[vIndex]))).Visible := True;
  end;
  PrevButton.Visible := ButtonPage > 1;

  PrevButton.Visible := ButtonPage > 1;
  NextButton.Visible := ButtonPage <= (High(ButtonData)+1) div 14;
end;

procedure TOrderCancel_F.SetCancelMode(const Value: TCancelMode);
var vKind :String;
    vIndex :Integer;
begin
  FCancelMode := Value;
  case FCancelMode of
    cmOrder :
    begin
      CaptionLabel.Caption   := '주문취소사유';
      MessageLabel.Caption := '주문취소 사유를 선택 또는 입력하세요';
      vKind := '08';
    end;
    cmSale  :
    begin
      CaptionLabel.Caption   := '매출취소사유';
      MessageLabel.Caption := '매출취소 사유를 선택 또는 입력하세요';
      vKind := '09';
    end;
    cmTableMemo :
    begin
      CaptionLabel.Caption   := '테이블메모';
      MessageLabel.Caption := '테이블 메모를 선택 또는 입력하세요';
      vKind := '24';
    end;
  end;

  DM.OpenQuery('select CD_CODE, '
              +'       NM_CODE1 '
              +'  from MS_CODE '
              +' where CD_STORE    =:P0 '
              +'   and CD_KIND     =:P1 '
              +'   and DS_STATUS   =''0'' '
              +' order by CD_CODE ',
              [Common.Config.StoreCode,
               vKind]);
  ButtonPage := 1;

  vIndex := 0;
  SetLength(ButtonData, DM.Query.RecordCount, 2);
  while not DM.Query.Eof do
  begin
    ButtonData[vIndex, 0] := DM.Query.FieldByName('CD_CODE').AsString;
    ButtonData[vIndex, 1] := DM.Query.FieldByName('NM_CODE1').AsString;
    DM.Query.Next;
    Inc(vIndex);
  end;
  DM.Query.Close;
  SetButtonData;
  InputEdit.Clear;
end;

procedure TOrderCancel_F.ShowVirtualKeyboard;
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

procedure TOrderCancel_F.Why1ButtonClick(Sender: TObject);
begin
  if CancelMode <> cmTableMemo then
    Common.WhyOrdercancel := (Sender as TPosButton).Caption
  else
    TableMemo := (Sender as TPosButton).Caption;
  ModalResult           := mrOK;
end;

procedure TOrderCancel_F.CloseButtonClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;


end.
