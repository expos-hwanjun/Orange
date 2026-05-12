unit AID_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvGlassButton, StdCtrls, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxButtons;

type
  TAID_F = class(TForm)
    lblTitle: TLabel;
    CloseButton: TcxButton;
    AID1Button: TAdvGlassButton;
    AID2Button: TAdvGlassButton;
    AID3Button: TAdvGlassButton;
    AID4Button: TAdvGlassButton;
    AID5Button: TAdvGlassButton;
    AID6Button: TAdvGlassButton;
    AID7Button: TAdvGlassButton;
    AID8Button: TAdvGlassButton;
    AID9Button: TAdvGlassButton;
    AID10Button: TAdvGlassButton;
    MessageLabel: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure obtn_AID1Click(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    AIDCount:Integer;
    AIDData :String;
    AID     :String;
  end;

var
  AID_F: TAID_F;

implementation
uses Common_U, GlobalFunc_U;

{$R *.dfm}

procedure TAID_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TAID_F.FormCreate(Sender: TObject);
var I :Integer;
begin
  OnShow := FormShow;
  Common.LogoCreate(Self,2);
end;

procedure TAID_F.FormShow(Sender: TObject);
var vIndex :Integer;
begin
  for vIndex := 1 to 10 do
    TAdvGlassButton(FindComponent(Format('AID%dButton',[vIndex]))).Visible := false;

  for vIndex := 0 to AIDCount-1 do
  begin
    TAdvGlassButton(FindComponent(Format('AID%dButton',[vIndex]))).Visible := true;
    TAdvGlassButton(FindComponent(Format('AID%dButton',[vIndex]))).Caption := Copy(AIDData,vIndex*16+1, 16);
  end;
end;

procedure TAID_F.obtn_AID1Click(Sender: TObject);
begin
  AID := IntToStr((Sender as TAdvGlassButton).Tag);
  ModalResult := mrOK;
end;

end.
