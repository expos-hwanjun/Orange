unit Map_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxButtons, dxGDIPlusClasses,
  Vcl.ExtCtrls, StrUtils;

type
  TMap_F = class(TForm)
    WebBrowser: TWebBrowser;
    CloseButton: TcxButton;
    CaptionLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    WebURL :String;
  end;

var
  Map_F: TMap_F;

implementation
uses Common_U;
{$R *.dfm}

procedure TMap_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TMap_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,1);
  Width  := 1024;
  Height := 768;
end;

procedure TMap_F.FormShow(Sender: TObject);
begin
  WebBrowser.Navigate('http://food.expos.co.kr:82/Extreme/IntranetFood/Modul/MapView.aspx?address='+WebURL);
end;

end.
