unit EasyPay_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ExtCtrls, AdvGlassButton,
  cxLabel, AdvSmoothButton;

type
  TEasyPay_F = class(TForm)
    MessageLabel: TcxLabel;
    OutLineShape: TShape;
    BarCodeLabel: TcxLabel;
    FDKPanel: TPanel;
    KaoPayButton: TAdvSmoothButton;
    ZeroPayButton: TAdvSmoothButton;
    SSGPayButton: TAdvSmoothButton;
    AriPayButton: TAdvSmoothButton;
    CancelButton: TAdvSmoothButton;
    cxLabel1: TcxLabel;
    NoButton: TAdvSmoothButton;
    YesButton: TAdvSmoothButton;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure YesButtonClick(Sender: TObject);
    procedure NoButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure KaoPayButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
  private
    procedure  ScannerReadEvent(const S : String);
  public
    { Public declarations }
  end;

var
  EasyPay_F: TEasyPay_F;

implementation
uses Common_U, Const_U;
{$R *.dfm}

procedure TEasyPay_F.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TEasyPay_F.FormCreate(Sender: TObject);
begin
  if Common.Config.van_trd = vanFDIK then
  begin
    FDKPanel.Left    := 4;
    FDKPanel.Top     := 4;
    FDKPanel.Visible := true;
  end;
end;

procedure TEasyPay_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    YesButtonClick(nil);
end;

procedure TEasyPay_F.FormKeyPress(Sender: TObject; var Key: Char);
begin
  BarCodeLabel.Caption := BarCodeLabel.Caption + Key;
end;

procedure TEasyPay_F.FormShow(Sender: TObject);
begin
  Common.Device.OnScannerReadData := ScannerReadEvent;
end;

procedure TEasyPay_F.KaoPayButtonClick(Sender: TObject);
begin
  BarCodeLabel.Caption := (Sender as TAdvSmoothButton).Hint;
  ModalResult := mrOK;
end;

procedure TEasyPay_F.NoButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TEasyPay_F.ScannerReadEvent(const S: String);
begin
  BarCodeLabel.Caption := S;
  ModalResult := mrOK;
end;

procedure TEasyPay_F.YesButtonClick(Sender: TObject);
begin
  ModalResult := mrOK;
//  if BarCodeLabel.Caption <> '' then
//    ModalResult := mrOK
//  else
//    Close;
end;
end.



