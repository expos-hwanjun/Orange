unit KioskRcpChange_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RcpChange_U, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxLabel, cxCurrencyEdit, cxCalendar, DB, cxDBData,
  cxContainer, Menus, ExtCtrls, ActnList, MemDS, DBAccess, Uni, cxClasses,
  StdCtrls, cxButtons, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxGridLevel,
  cxGridDBTableView, cxGridCustomTableView, cxGridTableView,
  cxGridCustomView, cxGrid, OXSpeedButton, jpeg, IniFiles, MMSystem,
  cxNavigator, System.Actions, AdvSmoothToggleButton, cxGroupBox,
  Vcl.WinXCalendars, AdvGlassButton, ToolPanels, AdvShape, dxGDIPlusClasses;

type
  TKioskRcpChange_F = class(TRcpChange_F)
    PointButton: TOXSpeedButton;
    CashRcpButton: TOXSpeedButton;
    RePrintButton: TOXSpeedButton;
    VoidButton: TOXSpeedButton;
    AllSearchButton: TOXSpeedButton;
    obtn_close: TOXSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure Action8Execute(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure Action9Execute(Sender: TObject);
    procedure obtn_CloseClick(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  KioskRcpChange_F: TKioskRcpChange_F;

implementation
uses Common_U;
{$R *.dfm}

procedure TKioskRcpChange_F.FormCreate(Sender: TObject);
begin
  inherited;
  if FileExists(Common.AppPath+'\Kiosk\영수증관리.png') then
  begin
    with TImage.Create(Self) do
    begin
      Parent := Self;
      Align := alClient;
      Picture.LoadFromFile(Common.AppPath+'\Kiosk\영수증관리.png');
      SendToBack;
    end;
  end;

  if FileExists(Common.AppPath+'\Kiosk\닫기.png') then
    Common.SetPNGImage(obtn_close, Common.AppPath+'\Kiosk\닫기.png');

  with TIniFile.Create(ExtractFilePath(Application.ExeName)+'Kiosk\KioskConfig.ini') do
    try
      Self.Height := ReadInteger('판매관리', 'Height', 768);
    finally
      Free;
    end;

  PointButton.Caption   := '';
  CashRcpButton.Caption := '';
  RePrintButton.Caption := '';
  VoidButton.Caption    := '';
end;

procedure TKioskRcpChange_F.Action4Execute(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  inherited;
end;

procedure TKioskRcpChange_F.Action5Execute(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  inherited;
end;

procedure TKioskRcpChange_F.Action8Execute(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  inherited;
end;

procedure TKioskRcpChange_F.Action7Execute(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  inherited;
end;

procedure TKioskRcpChange_F.Action9Execute(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  inherited;
end;

procedure TKioskRcpChange_F.obtn_CloseClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  inherited;
end;

end.
