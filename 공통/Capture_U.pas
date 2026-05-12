unit Capture_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, cxLookAndFeelPainters, StdCtrls, cxButtons,
  jpeg, Buttons, cxGraphics, cxLookAndFeels, dxSkinsCore,
  dxSkinsDefaultPainters, cxControls, dxCameraControl, cxContainer, cxEdit,
  cxImage, AdvGlassButton;

type
  TCapture_F = class(TForm)
    Cam: TdxCameraControl;
    CaptureImage: TcxImage;
    CaptureButton: TAdvGlassButton;
    CloseButton: TAdvGlassButton;
    Label1: TLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CaptureButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure CamStateChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
  end;

var
  Capture_F: TCapture_F;

implementation
uses Common_U, GlobalFunc_U, Const_U;
{$R *.dfm}

procedure TCapture_F.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TCapture_F.CamStateChanged(Sender: TObject);
begin
  CaptureButton.Enabled :=Cam.State = ccsRunning;
end;

procedure TCapture_F.CaptureButtonClick(Sender: TObject);
begin
  Cam.Capture;
  CaptureImage.Picture.Assign(Cam.CapturedBitmap);
  CaptureImage.Visible := true;
  CaptureImage.Picture.SaveToFile(Common.AppPath+'Capture.bmp');
  ModalResult := mrOK;
end;

procedure TCapture_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TCapture_F.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Cam.Active := false;
end;

procedure TCapture_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self);
end;

procedure TCapture_F.FormShow(Sender: TObject);
begin
  try
    Cam.Active := true;
  except
    if FileExists(Common.AppPath+'Capture.bmp') then
      DeleteFile(Common.AppPath+'Capture.bmp');
    Common.MsgBox('웹캠이 정상 동작하지 않습니다');
    ModalResult := mrOK;
  end;
end;

end.
