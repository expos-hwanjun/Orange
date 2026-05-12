unit Keyboard_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls, GraphicEx, Imm, ShellAPI,
  Vcl.Touch.Keyboard, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  Vcl.Menus, cxButtons, AdvGlassButton, AdvSmoothButton;

type
  TKeyboard_F = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TcxButton;
    KeyBoardButton: TAdvSmoothButton;
    procedure obtn_closeClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure KeyBoardButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  protected
    procedure ShowVirtualKeyboard;
  end;

var
  Keyboard_F: TKeyboard_F;

implementation
uses Common_U, GlobalFunc_U;
{$R *.dfm}

procedure TKeyboard_F.obtn_closeClick(Sender: TObject);
begin
  Close;
end;

procedure TKeyboard_F.ShowVirtualKeyboard;
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
    end
    else Common.MsgBox('TaskBar에 터치 키보드 단추 표시를 활성화하세요');
  end;
end;

procedure TKeyboard_F.CloseButtonClick(Sender: TObject);
begin
  if Common.isWindow7 then
    Common.KillTask('osk.exe');
  Close;
end;

procedure TKeyboard_F.FormCreate(Sender: TObject);
begin
  Common.SetButtonColor(KeyBoardButton);
end;

procedure TKeyboard_F.KeyBoardButtonClick(Sender: TObject);
begin
  ShowVirtualKeyboard;
end;


end.

