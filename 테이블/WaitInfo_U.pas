unit WaitInfo_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, Vcl.StdCtrls, cxButtons, KeyPad_F,
  cxControls, cxContainer, cxEdit, AdvGlassButton, cxCurrencyEdit, cxTextEdit,
  cxLabel;

type
  TWaitInfo_F = class(TForm)
    fmKeyPad1: TfmKeyPad;
    CloseButton: TcxButton;
    cxLabel1: TcxLabel;
    MobileEdit: TcxTextEdit;
    cxLabel2: TcxLabel;
    ReadyAmtEdit: TcxCurrencyEdit;
    YesButton: TAdvGlassButton;
    TitleLabel: TLabel;
    procedure CloseButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WaitInfo_F: TWaitInfo_F;

implementation
uses Common_U, GlobalFunc_U;
{$R *.dfm}

procedure TWaitInfo_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TWaitInfo_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
end;

end.
