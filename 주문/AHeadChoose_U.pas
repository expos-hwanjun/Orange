unit AHeadChoose_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, Vcl.StdCtrls, cxButtons, AdvGlassButton,
  dxGDIPlusClasses, Vcl.ExtCtrls, AdvSmoothButton;

type
  TAHeadChoose_F = class(TForm)
    CloseButton: TcxButton;
    TitleLabel: TLabel;
    lbl_Msg: TLabel;
    Image3: TImage;
    CardButton: TAdvSmoothButton;
    CashRcpButton: TAdvSmoothButton;
    CashButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure CardButtonClick(Sender: TObject);
    procedure CashRcpButtonClick(Sender: TObject);
    procedure CashButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    SelectBtn :Integer;
  end;

var
  AHeadChoose_F: TAHeadChoose_F;

implementation
uses Common_U;
{$R *.dfm}

procedure TAHeadChoose_F.CardButtonClick(Sender: TObject);
begin
  SelectBtn := 1;
  ModalResult := mrOK;
end;

procedure TAHeadChoose_F.CashButtonClick(Sender: TObject);
begin
  SelectBtn := 3;
  ModalResult := mrOK;

end;

procedure TAHeadChoose_F.CashRcpButtonClick(Sender: TObject);
begin
  SelectBtn := 2;
  ModalResult := mrOK;

end;

procedure TAHeadChoose_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TAHeadChoose_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(CardButton);
  Common.SetButtonColor(CashRcpButton);
  Common.SetButtonColor(CashButton);
end;

end.
