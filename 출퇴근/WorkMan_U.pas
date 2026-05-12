unit WorkMan_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DB, ADODB, ExtCtrls, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxButtons, AdvGlassButton,
  dxGDIPlusClasses, AdvSmoothToggleButton;

type
  TWorkMan_F = class(TForm)
    Label1: TLabel;
    MessageLabel: TLabel;
    Image3: TImage;
    CloseButton: TcxButton;
    User0Button: TAdvSmoothToggleButton;
    User2Button: TAdvSmoothToggleButton;
    User3Button: TAdvSmoothToggleButton;
    User4Button: TAdvSmoothToggleButton;
    User5Button: TAdvSmoothToggleButton;
    User6Button: TAdvSmoothToggleButton;
    User7Button: TAdvSmoothToggleButton;
    User8Button: TAdvSmoothToggleButton;
    User9Button: TAdvSmoothToggleButton;
    User10Button: TAdvSmoothToggleButton;
    User11Button: TAdvSmoothToggleButton;
    User12Button: TAdvSmoothToggleButton;
    User13Button: TAdvSmoothToggleButton;
    User14Button: TAdvSmoothToggleButton;
    User15Button: TAdvSmoothToggleButton;
    User16Button: TAdvSmoothToggleButton;
    User17Button: TAdvSmoothToggleButton;
    User18Button: TAdvSmoothToggleButton;
    User19Button: TAdvSmoothToggleButton;
    User20Button: TAdvSmoothToggleButton;
    User21Button: TAdvSmoothToggleButton;
    User22Button: TAdvSmoothToggleButton;
    User23Button: TAdvSmoothToggleButton;
    User1Button: TAdvSmoothToggleButton;
    PrevButton: TAdvSmoothToggleButton;
    NextButton: TAdvSmoothToggleButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure obtn_ConfirmClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure User1ButtonClick(Sender: TObject);
    procedure PrevButtonClick(Sender: TObject);
  private
    ButtonMaxCount :Integer;
    ButtonData      :Array of Array of String;
    ButtonPage :Integer;

    FSqltext :String;
    procedure SetButtonData;
    procedure SelectData;
  public
    SelectCode,
    SelectName :String;
  end;

var
  WorkMan_F: TWorkMan_F;

implementation
uses Common_U, GlobalFunc_U;
{$R *.dfm}

procedure TWorkMan_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TWorkMan_F.FormCreate(Sender: TObject);
var vIndex :Integer;
begin
  Common.LogoCreate(Self,2);
  for vIndex := 0 to ComponentCount-1 do
    if Components[vIndex] is TAdvSmoothToggleButton then
      Common.SetButtonColor((Components[vIndex] as TAdvSmoothToggleButton));
end;

procedure TWorkMan_F.SelectData;
var vIndex :Integer;
begin
  OpenQuery('select a.CD_SAWON, '
           +'       a.NM_SAWON, '
           +'       b.TIME_IN '
           +'  from MS_SAWON a left outer join '
           +'      (select CD_SAWON, '
           +'              Ifnull(Date_Format(TIME_IN, ''%H:%i''),'''') as TIME_IN '
           +'         from SL_SAWONWORK '
           +'        where CD_STORE = :P0 '
           +'          and TIME_IN is not null '
           +'          and TIME_OUT is null '
           +'        group by CD_SAWON) as b on b.CD_SAWON = a.CD_SAWON '
           +' where a.CD_STORE =:P0 ',
           [Common.Config.StoreCode]);

  ButtonMaxCount := 0;
  while not Common.Query.Eof do
  begin
    ButtonMaxCount := ButtonMaxCount + 1;
    Common.Query.Next;
  end;

  SetLength(ButtonData, ButtonMaxCount, 3);
  ButtonPage := 1;

  Common.Query.First;
  vIndex := 0;
  while not Common.Query.Eof do
  begin
    ButtonData[vIndex, 0] := Common.Query.Fields[0].AsString;
    ButtonData[vIndex, 1] := Common.Query.Fields[1].AsString;
    ButtonData[vIndex, 2] := Common.Query.Fields[2].AsString;
    Inc(vIndex);
    Common.Query.Next;
  end;
  Common.Query.Close;
  SetButtonData;
end;


procedure TWorkMan_F.FormShow(Sender: TObject);
var vIndex :Integer;
begin
  For vIndex := 0 to 23 do
  begin
    TAdvSmoothToggleButton(FindComponent(Format('User%dButton',[vIndex]))).Caption := '';
    TAdvSmoothToggleButton(FindComponent(Format('User%dButton',[vIndex]))).Hint    := '';
  end;

  SelectData;
end;

procedure TWorkMan_F.obtn_ConfirmClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;


procedure TWorkMan_F.PrevButtonClick(Sender: TObject);
begin
  if Sender = PrevButton then ButtonPage := ButtonPage -1
  else if Sender = NextButton then ButtonPage := ButtonPage +1;

  SetButtonData;
end;

procedure TWorkMan_F.SetButtonData;
var vIndex :Integer;
begin
  For vIndex := 0 to 23 do
  begin
    TAdvSmoothToggleButton(FindComponent(Format('User%dButton',[vIndex]))).Caption := '';
    TAdvSmoothToggleButton(FindComponent(Format('User%dButton',[vIndex]))).Hint    := '';
    TAdvSmoothToggleButton(FindComponent(Format('User%dButton',[vIndex]))).Status.Visible := false;
  end;

  For vIndex := 0  to 23 do
  begin
    if ( ((ButtonPage-1)*24) + vIndex ) >= ButtonMaxCount then Continue;
    TAdvSmoothToggleButton(FindComponent(Format('User%dButton',[vIndex]))).Caption  := ButtonData[((ButtonPage-1)*24) + vIndex, 1];
    TAdvSmoothToggleButton(FindComponent(Format('User%dButton',[vIndex]))).Hint     := ButtonData[((ButtonPage-1)*24) + vIndex, 0];
    if (ButtonData[((ButtonPage-1)*24) + vIndex, 2] <> '')  then
    begin
      TAdvSmoothToggleButton(FindComponent(Format('User%dButton',[vIndex]))).Status.Visible := true;
      TAdvSmoothToggleButton(FindComponent(Format('User%dButton',[vIndex]))).Status.Caption := 'Ãâ±Ù';
    end;
  end;
  PrevButton.Enabled := ButtonPage > 1;
  NextButton.Enabled := ButtonPage <= (ButtonMaxCount div 24);
end;

procedure TWorkMan_F.User1ButtonClick(Sender: TObject);
begin
  if (Sender as TAdvSmoothToggleButton).Caption = '' then Exit;

  SelectCode := (Sender as TAdvSmoothToggleButton).Hint;
  SelectName := (Sender as TAdvSmoothToggleButton).Caption;
  ModalResult := mrOK;
end;

end.
