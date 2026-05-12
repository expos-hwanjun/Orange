unit KeepingAdd_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Keyboard_U, Menus, cxLookAndFeelPainters, cxMemo, StdCtrls,
  cxButtons, cxControls, cxContainer, cxEdit, cxTextEdit, ExtCtrls,
  OXSpeedButton, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxLookAndFeels, cxGridCustomTableView, cxGridTableView,
  cxGridCustomView, cxClasses, cxGridLevel, cxGrid, cxLabel, cxNavigator;

type
  TKeepingAdd_F = class(TKeyboard_F)
    edtCustName: TcxTextEdit;
    edtTelNo: TcxTextEdit;
    edtDamdang: TcxTextEdit;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    edtMenu: TcxTextEdit;
    obtn_save: TOXSpeedButton;
    meoRemark: TcxMemo;
    obtn_close: TOXSpeedButton;
    panMenu: TPanel;
    GridLevel: TcxGridLevel;
    Grid: TcxGrid;
    gvGridView: TcxGridTableView;
    gvGridViewColumn1: TcxGridColumn;
    gvGridViewColumn2: TcxGridColumn;
    cxLookAndFeelController1: TcxLookAndFeelController;
    cxButton3: TcxButton;
    cxButton4: TcxButton;
    edtMenuName: TcxTextEdit;
    cxButton5: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure obtn_closeClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure edtTelNoExit(Sender: TObject);
    procedure obtn_saveClick(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
    procedure gvGridViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
  public
    FMemberCode  :String;
    FDamdangCode :String;
    FMenuCode    :String;
  end;

var
  KeepingAdd_F: TKeepingAdd_F;

implementation
uses Common_U, GlobalFunc_U;
{$R *.dfm}

procedure TKeepingAdd_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
  inherited;
end;

procedure TKeepingAdd_F.obtn_closeClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TKeepingAdd_F.cxButton1Click(Sender: TObject);
begin
  inherited;
  if Common.ShowChooseForm('T','',Common.DamdangCode,Common.DamdangName) then
  begin
    FDamdangCode    := Common.DamdangCode;
    edtDamdang.Text := Common.DamdangName;
    edtMenu.SetFocus;
  end;
end;

procedure TKeepingAdd_F.cxButton2Click(Sender: TObject);
begin
  inherited;
  if Common.ShowMemberForm then
  begin
    FMemberCode        := Common.Member.Code;
    edtCustName.Text   := Common.Member.Name;
    edtTelNo.Text      := SetTelephone(Common.Member.MobileTel);
    if edtTelNo.Text <> '' then edtDamdang.SetFocus
    else edtTelNo.SetFocus;
  end;
end;

procedure TKeepingAdd_F.edtTelNoExit(Sender: TObject);
begin
  inherited;
  edtTelNo.Text := SetTelephone(edtTelNo.Text)
end;

procedure TKeepingAdd_F.obtn_saveClick(Sender: TObject);
begin
  inherited;
  if edtCustName.Text = '' then
  begin
    Common.ErrBox('고객명을 입력하세요');
    edtCustName.SetFocus;
    Exit;
  end;

  if edtTelNo.Text = '' then
  begin
    Common.ErrBox('전화번호를 입력하세요');
    edtTelNo.SetFocus;
    Exit;
  end;

  if edtDamdang.Text = '' then
  begin
    Common.ErrBox('담당자를 입력하세요');
    edtDamdang.SetFocus;
    Exit;
  end;

  if edtMenuName.Text = '' then
  begin
    Common.ErrBox('보관메뉴를 입력하세요');
    edtMenu.SetFocus;
    Exit;
  end;

  ModalResult := mrOK;
end;

procedure TKeepingAdd_F.cxButton3Click(Sender: TObject);
begin
  inherited;
  panMenu.Visible   := True;
  cxButton4.Visible := True;
  cxButton5.Visible := True;

  Common.qryPos.Close;
  Common.qryPos.SQL.Text := 'select CD_MENU, '
                           +'       NM_MENU '
                           +'  from MS_MENU '
                           +' where CD_STORE =:P0 '
                           +'   and (CD_MENU =:P1 or NM_MENU like :p2) '
                           +'   and yn_keeping = ''Y'' order by nm_menu ';
  Common.qryPos.ParamByName('p0').AsString := Common.Config.StoreCode;
  Common.qryPos.ParamByName('p1').AsString := edtMenu.Text;
  Common.qryPos.ParamByName('p2').AsString := '%'+edtMenu.Text+'%';
  Common.qryPos.Open;

  Common.OpenDataToGrid(Common.qryPos, gvGridView);
  Common.qryPos.Close;
end;

procedure TKeepingAdd_F.cxButton4Click(Sender: TObject);
begin
  inherited;
  panMenu.Visible   := False;
  cxButton4.Visible := False;
  cxButton5.Visible := False;
end;

procedure TKeepingAdd_F.cxButton5Click(Sender: TObject);
begin
  inherited;
  if gvGridView.DataController.RowCount = 0 then Exit;

  FMenuCode        := gvGridView.DataController.Values[gvGridView.DataController.GetFocusedRecordIndex, 0];
  edtMenuName.Text := gvGridView.DataController.Values[gvGridView.DataController.GetFocusedRecordIndex, 1];
  edtMenu.Clear;
  cxButton4Click(nil);
end;

procedure TKeepingAdd_F.gvGridViewCellDblClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  if gvGridView.DataController.RowCount = 0 then Exit;

  FMenuCode        := gvGridView.DataController.Values[gvGridView.DataController.GetFocusedRecordIndex, 0];
  edtMenuName.Text := gvGridView.DataController.Values[gvGridView.DataController.GetFocusedRecordIndex, 1];
  edtMenu.Clear;
  cxButton4Click(nil);
end;

end.
