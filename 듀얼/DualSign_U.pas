unit DualSign_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxTextEdit, KeyPad_F, cxControls, cxContainer, cxEdit, cxLabel,
  ExtCtrls, Menus, cxLookAndFeelPainters, StdCtrls, cxButtons,
  TFlatPanelUnit, cxImage, cxGraphics, cxLookAndFeels;
//type
//  TFD_DisplayOption      = function (option, x, y:Integer): Integer; stdcall;

type
  TDualSign_F = class(TForm)
    lblSign: TcxLabel;
    fmKeyPad: TfmKeyPad;
    edt_Input: TcxTextEdit;
    ImgScreen: TcxImage;
    lblAmt: TcxLabel;
    Tmr_End: TTimer;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ImgScreenMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImgScreenMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Tmr_EndTimer(Sender: TObject);
    procedure edt_InputPropertiesChange(Sender: TObject);
    procedure fmKeyPadNum_EnterClick(Sender: TObject);
  private
    ScreenBmp : TBitmap;
  public
    procedure RequestSign;
    procedure RequestKeyPad;
    procedure GetSignData;
  end;

var
  DualSign_F: TDualSign_F;

implementation
uses Common_U, Card_U, CashRcp_U, GlobalFunc_U;
{$R *.dfm}
{ TDualSign_F }
procedure TDualSign_F.GetSignData;
var
  ScreenHandle: THandle;
  vScreenBmp: TBitmap;
  vSaveBmp  : TBitmap;
begin
  vScreenBmp := TBitmap.Create;
  vScreenBmp.Width  := ImgScreen.Width;
  vScreenBmp.Height := ImgScreen.Height;
  vScreenBmp.PixelFormat := pf1bit;

  ScreenHandle:= Canvas.Handle;
  try
    BitBlt( vScreenBmp.Canvas.Handle, 0, 0, ImgScreen.Width, ImgScreen.Height, ScreenHandle, 0, 0, SRCCOPY );
  finally
    ReleaseDC( 0, ScreenHandle );
  end;

  vSaveBmp := TBitmap.Create;
  vSaveBmp.PixelFormat := pf1bit;
  vSaveBmp.Width  := 90;
  vSaveBmp.Height := 50;
  vSaveBmp.Canvas.StretchDraw(vSaveBmp.Canvas.ClipRect, vScreenBmp );

  if not DirectoryExists(Common.AppPath+'CardLog') then
    CreateDir(Common.AppPath+'CardLog');
  vSaveBmp.SaveToFile(Common.AppPath+'CardLog\'+FormatDateTime('yyyymmdd', now)+'.bmp');
end;

procedure TDualSign_F.RequestKeyPad;
begin
  ImgScreen.Visible := False;
  edt_Input.Visible := True;
  fmKeyPad.Visible  := True;
  lblSign.Top       :=  50;
  lblSign.Caption   := '식별번호를 입력하세요...';
  lblSign.Visible   := True;
  edt_Input.SetFocus;
end;

procedure TDualSign_F.RequestSign;
begin
  lblSign.Top       := 212;
  lblSign.Caption   := '화면에 서명해주세요...';
  lblSign.Visible   := True;
  ImgScreen.Refresh;
  ImgScreen.Cursor  := ImgScreen.Cursor;
  Tmr_End.Enabled   := False;
end;

procedure TDualSign_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case Key of
     VK_F10  :  edt_Input.Clear;
  end;
end;

procedure TDualSign_F.ImgScreenMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Shift = [ssLeft] then
  begin
    lblSign.Visible  := False;
    ImgScreen.Canvas.MoveTo(X,Y);
    ImgScreen.Canvas.LineTo(X,Y);
    Card_F.ImgScreen.Canvas.MoveTo(X div 2,Y div 3);
    Card_F.ImgScreen.Canvas.LineTo(X div 2,Y div 3);
    Card_F.SignMode := snSign;
  end;
end;

procedure TDualSign_F.ImgScreenMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Shift = [ssLeft] then
  begin
    Tmr_End.Enabled := False;
    ImgScreen.Canvas.LineTo(X,Y);
    Card_F.ImgScreen.Canvas.LineTo(X div 2,Y div 3);
    //서명후 자동으로 승인처리한다고 했을때
    if Common.Config.Values[70] = '1' then
      Tmr_End.Enabled := True;
  end;
end;

procedure TDualSign_F.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(ScreenBmp);
  Action := caFree;
end;

procedure TDualSign_F.FormCreate(Sender: TObject);
begin
  ImgScreen.Canvas.Pen.Color := clBlack;
  ImgScreen.Canvas.Pen.Width := 2;
end;

procedure TDualSign_F.Tmr_EndTimer(Sender: TObject);
begin
  Tmr_End.Enabled := False;
  if FindForm('TCard_F') then
    Card_F.ApprovalExecute;
end;

procedure TDualSign_F.edt_InputPropertiesChange(Sender: TObject);
begin
  if FindForm('TCashrcp_F') then
    Cashrcp_F.edt_Number.Text := edt_Input.Text;
end;

procedure TDualSign_F.fmKeyPadNum_EnterClick(Sender: TObject);
begin
  if not FindForm('TCashrcp_F') then Exit;
  Cashrcp_F.Tmr_Approval.Enabled := True;
end;

end.
