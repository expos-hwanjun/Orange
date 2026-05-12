unit Splash_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Jpeg, ExtCtrls, GraphicEx, dxGDIPlusClasses,
  Vcl.WinXCtrls;

type
  TSplash_F = class(TForm)
    MessageLabel: TLabel;
    ActivityIndicator: TActivityIndicator;
    procedure FormDestroy(Sender: TObject);
  private
    DllHandle       : THandle;
    ResStream       : TResourceStream;
    JPEG            :TJPEGImage;
    { Private declarations }
  public
    procedure MsgSendToDemon;
  end;

var
  Splash_F     : TSplash_F;
implementation

{$R *.dfm}

procedure TSplash_F.FormDestroy(Sender: TObject);
var I :Integer;
    FullRgn, ClientRgn, ControlRgn :THandle;
    Margin, MarginX, MarginY, X, Y : Integer;
begin
  ActivityIndicator.Animate := true;
  Margin := (Self.Width - Self.ClientWidth) div 2;
  FullRgn := CreateRectRgn(0,0, Self.Width, Self.Height);
  MarginX := Margin;
  MarginY := Self.Height - Self.ClientHeight-Margin;
  ClientRgn := CreateRectRgn(MarginX, MarginY, MarginX + self.ClientWidth, MarginY + Self.ClientHeight);

  CombineRgn(FullRgn, FullRgn, ClientRgn, RGN_DIFF);
  for I := 0 to Self.ControlCount-1 do
  begin
    X := MarginX + Self.Controls[I].Left;
    Y := MarginY + Self.Controls[I].Top;
    ControlRgn := CreateRectRgn(X,Y,X+Self.Controls[I].Width,
                                    Y+Self.Controls[I].Height);

    CombineRgn(FullRgn, FullRgn, ControlRgn, RGN_OR);
  end;
  SetWindowRgn(Self.Handle, FullRgn, True);
end;

procedure TSplash_F.MsgSendToDemon;
var SendHWND : HWND;
    SelfHWND : HWND;
    sndData  : AnsiString;
    Data     : TCOPYDATASTRUCT;
    len      : Integer;
begin
   SelfHWND :=FindWindow (nil,'Splash_F');       //-- 보내는 프로그램 이름
   SendHWND := FindWindow(nil, 'POSDemon');      //-- 받는 프로그램 이름
   sndData := 'UPDATE';
   len := Length(sndData) + 1;
   if Len > 10 then
   begin
     Data.dwData:=0;
     Data.cbData:=len;
     Data.lpData:=pAnsiChar(sndData);

     SendMessage(SendHWND, WM_COPYDATA, SelfHWND, LPARAM(@Data));
   end;
end;

end.
