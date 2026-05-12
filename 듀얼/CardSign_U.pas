unit CardSign_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, cxLookAndFeelPainters, StdCtrls, cxButtons, ExtCtrls,
  TFlatPanelUnit, ImgList, cxControls, cxContainer, cxEdit,
  cxLabel, cxGraphics, cxLookAndFeels;

type
  TCardSign_F = class(TForm)
    FlatPanel2: TFlatPanel;
    btnConfirm: TcxButton;
    btnClose: TcxButton;
    cxButton1: TcxButton;
    ImgScreen: TImage;
    cxLabel1: TcxLabel;
    lblAmount: TcxLabel;
    lblCharge: TcxLabel;
    lblCount: TcxLabel;
    cxLabel3: TcxLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ImgScreenMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImgScreenMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure cxButton1Click(Sender: TObject);
    procedure ShowWindow1Click(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
  private
    ScreenBmp : TBitmap;
    SessionEnding: Boolean;

    procedure Capture;
    procedure WMHotkey(var Message:TWMHotkey); message WM_HOTKEY; //핫키 설정 Windows API
  public
    { Public declarations }
  end;

var
  CardSign_F: TCardSign_F;

implementation
uses Common_U;
{$R *.dfm}
procedure TCardSign_F.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TCardSign_F.Capture;
var
  ScreenHandle: THandle;
begin
  Canvas.Pen.Color := clBlack;
  Canvas.Pen.Width := 2;
  ScreenBmp := TBitmap.Create;
  ScreenBmp.Width  := ImgScreen.Width;
  ScreenBmp.Height := ImgScreen.Height;

  ScreenHandle:= ImgScreen.Canvas.Handle;
  try
    BitBlt( ScreenBmp.Canvas.Handle, 0, 0, ImgScreen.Width, ImgScreen.Height, ScreenHandle, 0, 0, SRCCOPY );
  finally
    ReleaseDC( 0, ScreenHandle );
  end;

  ImgScreen.Picture.Bitmap.Assign(ScreenBmp);
  DoubleBuffered := True;
end;

procedure TCardSign_F.WMHotkey(var Message: TWMHotkey);
begin
  Capture;
end;

procedure TCardSign_F.FormCreate(Sender: TObject);
begin
  //현재의 화면을 캡쳐해서 이미지에 저장시키는 작업.
  Capture;
  cxLabel1.Visible  := True;
  lblCharge.Visible  := True;
  cxLabel3.Visible  := True;
  lblAmount.Visible := True;
  lblCount.Visible  := True;
end;

procedure TCardSign_F.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(ScreenBmp);
end;

procedure TCardSign_F.ImgScreenMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Shift = [ssLeft] then
  begin
    cxLabel1.Visible  := False;
    lblCharge.Visible  := False;
    cxLabel3.Visible  := False;
    lblAmount.Visible := False;
    lblCount.Visible  := False;
    Canvas.MoveTo(X,Y);
    Canvas.LineTo(X,Y);
  end;
end;

procedure TCardSign_F.ImgScreenMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Shift = [ssLeft] then
    Canvas.LineTo(X,Y);
end;

procedure TCardSign_F.cxButton1Click(Sender: TObject);
begin
  ImgScreen.Refresh;
  Capture;
  cxLabel1.Visible  := True;
  lblCharge.Visible  := True;
  cxLabel3.Visible  := True;
  lblAmount.Visible := True;
  lblCount.Visible  := True;
end;

procedure TCardSign_F.ShowWindow1Click(Sender: TObject);
begin
  Capture;
end;

procedure TCardSign_F.btnConfirmClick(Sender: TObject);
var
  ScreenHandle: THandle;
  vScreenBmp: TBitmap;
  vSaveBmp  : TBitmap;
begin
  if cxLabel1.Visible then
  begin
    Common.MsgBox('서명을 해주세요');
    Exit;
  end;
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
  ModalResult := mrOK;
end;

end.
