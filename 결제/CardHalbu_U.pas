unit CardHalbu_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvSmoothToggleButton;

type
  TCardHalbu_F = class(TForm)
    HalbuButton: TAdvSmoothToggleButton;
    AdvSmoothToggleButton1: TAdvSmoothToggleButton;
    AdvSmoothToggleButton2: TAdvSmoothToggleButton;
    AdvSmoothToggleButton3: TAdvSmoothToggleButton;
    AdvSmoothToggleButton4: TAdvSmoothToggleButton;
    procedure FormCreate(Sender: TObject);
    procedure HalbuButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  CardHalbu_F: TCardHalbu_F;

implementation
uses Common_U;
{$R *.dfm}

procedure TCardHalbu_F.HalbuButtonClick(Sender: TObject);
begin
  Common.ICCard.HalbuMonth := (Sender as TAdvSmoothToggleButton).Tag;
  ModalResult := mrOK;
end;

procedure TCardHalbu_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,0);
end;

end.
