unit Notice_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw;

type
  TNotice_F = class(TForm)
    WebBrowser: TWebBrowser;
    procedure FormShow(Sender: TObject);
    procedure WebBrowserQuit(Sender: TObject);
  private
    { Private declarations }
  public
    WebURL :String;
  end;

var
  Notice_F: TNotice_F;

implementation

{$R *.dfm}

procedure TNotice_F.FormShow(Sender: TObject);
begin
  WebBrowser.Navigate(WebURL);
end;

procedure TNotice_F.WebBrowserQuit(Sender: TObject);
begin
  Close;
end;

end.
