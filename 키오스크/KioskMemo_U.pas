unit KioskMemo_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxLabel, jpeg, ExtCtrls, IniFiles,
  MMSystem, AdvSmoothButton, AdvSmoothToggleButton;

type
  TKioskMemo_F = class(TForm)
    lblMemo: TcxLabel;
    CloseTimer: TTimer;
    obtnMemo1: TAdvSmoothButton;
    obtnMemo2: TAdvSmoothButton;
    obtnMemo3: TAdvSmoothButton;
    obtnMemo4: TAdvSmoothButton;
    obtnMemo5: TAdvSmoothButton;
    obtnMemo6: TAdvSmoothButton;
    obtnMemo7: TAdvSmoothButton;
    obtnMemo8: TAdvSmoothButton;
    obtnMemo9: TAdvSmoothButton;
    obtnMemo10: TAdvSmoothButton;
    obtnMemo11: TAdvSmoothButton;
    obtnMemo12: TAdvSmoothButton;
    btnConfirm: TAdvSmoothButton;
    CancelButton: TAdvSmoothToggleButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure obtnMemo1Click(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseTimerTimer(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    MenuCode :String;
    MemoStr  :String;
  end;

var
  KioskMemo_F: TKioskMemo_F;

implementation
uses Common_U, Order_U, GlobalFunc_U;
{$R *.dfm}

procedure TKioskMemo_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,0);
  Common.SetButtonColor(btnConfirm);
  Common.SetKioskButton(CancelButton, 'No');
  Common.SetKioskButton(btnConfirm, 'Yes');
end;

procedure TKioskMemo_F.FormShow(Sender: TObject);
var vIndex :Integer;
    vFontSize :Integer;
    vFontColor :TColor;
begin
  CloseTimer.Tag := 0;

  for vIndex := 1 to 12 do
    TAdvSmoothButton(FindComponent(Format('obtnMemo%d',[vIndex]))).Visible  := false;

  OpenQuery('select b.NM_CODE1 '
           +'  from MS_MENU_MEMO a inner join '
           +'       MS_CODE      b on a.CD_STORE = b.CD_STORE '
           +'                     and a.CD_MEMO  = b.CD_CODE '
           +'                     and b.CD_KIND  = ''18'' '
           +' where a.CD_STORE = :P0 '
           +'   and a.CD_MENU  = :P1 '
           +'   and b.DS_STATUS =''0'' '
           +'   and b.NM_CODE1  <> '''' '
           +' order by b.CD_CODE '
           +' limit 12 ',
           [Common.Config.StoreCode,
            MenuCode]);
  vIndex := 1;
  lblMemo.Caption := EmptyStr;
  lblMemo.Hint := EmptyStr;
  while not Common.Query.Eof do
  begin
    TAdvSmoothButton(FindComponent(Format('obtnMemo%d',[vIndex]))).Caption  := Common.GetPaPago(Common.Query.Fields[0].AsString);
    TAdvSmoothButton(FindComponent(Format('obtnMemo%d',[vIndex]))).Hint     := Common.Query.Fields[0].AsString;
    TAdvSmoothButton(FindComponent(Format('obtnMemo%d',[vIndex]))).Visible  := true;
    TAdvSmoothButton(FindComponent(Format('obtnMemo%d',[vIndex]))).Appearance.Font.Name := Common.Config.KioskDefaultFontName;
    TAdvSmoothButton(FindComponent(Format('obtnMemo%d',[vIndex]))).Tag      := 0;
    Inc(vIndex);
    Common.Query.Next;
  end;

  CancelButton.Caption := Common.GetPaPago('나가기');
  btnConfirm.Caption   := Common.GetPaPago('선택완료');
end;

procedure TKioskMemo_F.obtnMemo1Click(Sender: TObject);
var vIndex : Integer;
begin
  Common.KioskTouchBeep('kioskwave12');
  if (Sender as TAdvSmoothButton).Tag = 0 then
  begin
    if lblMemo.Caption = EmptyStr then
      lblMemo.Caption := (Sender as TAdvSmoothButton).Caption
    else
      lblMemo.Caption := lblMemo.Caption + Format('+%s',[(Sender as TAdvSmoothButton).Caption]);

    if lblMemo.Caption = EmptyStr then
      lblMemo.Hint := (Sender as TAdvSmoothButton).Hint
    else
      lblMemo.Hint := lblMemo.Hint + Format('+%s',[(Sender as TAdvSmoothButton).Hint]);

    (Sender as TAdvSmoothButton).BevelColor := clRed;
    (Sender as TAdvSmoothButton).Tag := 1;
  end
  else
  begin
    (Sender as TAdvSmoothButton).BevelColor := clBlack;
    (Sender as TAdvSmoothButton).Tag := 0;

    lblMemo.Caption := EmptyStr;
    for vIndex := 1 to 12 do
    begin
      if TAdvSmoothButton(FindComponent(Format('obtnMemo%d',[vIndex]))).Tag = 0 then Continue;

      if lblMemo.Caption = EmptyStr then
        lblMemo.Caption := TAdvSmoothButton(FindComponent(Format('obtnMemo%d',[vIndex]))).Caption
      else
        lblMemo.Caption := lblMemo.Caption + Format('+%s',[TAdvSmoothButton(FindComponent(Format('obtnMemo%d',[vIndex]))).Caption]);

      if lblMemo.Hint = EmptyStr then
        lblMemo.Hint := TAdvSmoothButton(FindComponent(Format('obtnMemo%d',[vIndex]))).Hint
      else
        lblMemo.Hint := lblMemo.Hint + Format('+%s',[TAdvSmoothButton(FindComponent(Format('obtnMemo%d',[vIndex]))).Hint]);


    end;
  end;
  btnConfirm.Visible := lblMemo.Caption <> EmptyStr;
end;

procedure TKioskMemo_F.btnConfirmClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  MemoStr := lblMemo.Caption;
  ModalResult := mrOK;
end;

procedure TKioskMemo_F.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CloseTimer.Enabled := false;
end;

procedure TKioskMemo_F.CancelButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  Close;
end;

procedure TKioskMemo_F.CloseTimerTimer(Sender: TObject);
begin
  CloseTimer.Tag := CloseTimer.Tag + 1;
  if CloseTimer.Tag > 60 then
  begin
    CloseTimer.Enabled := false;
    Close;
  end;
end;

end.
