unit Tabling_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxControls,
  cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxLabel, cxCurrencyEdit, cxClasses, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridCustomView, cxGrid,
  dxGDIPlusClasses, Vcl.ExtCtrls, AdvGlassButton, AdvSmoothButton;

type
  TTabling_F = class(TForm)
    CloseButton: TcxButton;
    CaptionLabel: TLabel;
    TeamCountLabel: TcxLabel;
    Image3: TImage;
    MessageLabel: TLabel;
    Grid: TcxGrid;
    gvMaster1: TcxGridTableView;
    gvMaster1Column1: TcxGridColumn;
    gvMaster1Column2: TcxGridColumn;
    gvMaster1Column3: TcxGridColumn;
    gvMaster1Column4: TcxGridColumn;
    gvMaster1Column5: TcxGridColumn;
    gvMaster1Column6: TcxGridColumn;
    gvMaster1Column7: TcxGridColumn;
    gvMaster1Column8: TcxGridColumn;
    gvMaster1Column9: TcxGridColumn;
    gvMaster1Column10: TcxGridColumn;
    gvMaster1Column11: TcxGridColumn;
    gvMaster1Column12: TcxGridColumn;
    gvMaster1Column13: TcxGridColumn;
    gvMaster1Column14: TcxGridColumn;
    gvMaster1Column15: TcxGridColumn;
    gvMaster1Column16: TcxGridColumn;
    gvMaster1Column17: TcxGridColumn;
    gvMaster1Column18: TcxGridColumn;
    gvMaster1Column19: TcxGridColumn;
    gvMaster1Column20: TcxGridColumn;
    gvMaster1Column21: TcxGridColumn;
    gvMaster1Column22: TcxGridColumn;
    GridWaitView: TcxGridTableView;
    GridWaitViewRcpNo: TcxGridColumn;
    GridWaitViewGuestCount: TcxGridColumn;
    GridWaitViewMobileNo: TcxGridColumn;
    GridWaitViewWaitingTime: TcxGridColumn;
    GridWaitViewOrderMenu: TcxGridColumn;
    GridWaitViewStatus: TcxGridColumn;
    GridLevel: TcxGridLevel;
    StyleRepository: TcxStyleRepository;
    cxStyle1: TcxStyle;
    StyleHeader: TcxStyle;
    GridWaitViewRemark: TcxGridColumn;
    GridWaitViewWaitNumber: TcxGridColumn;
    WaitCallButton: TAdvSmoothButton;
    WaitCancelButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure GridWaitViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
  private
    procedure SetWaitNumber;
  public
    { Public declarations }
  end;

var
  Tabling_F: TTabling_F;

implementation
uses Common_U, GlobalFunc_U, DB;

{$R *.dfm}

{ TTabling_F }

procedure TTabling_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(WaitCancelButton);
  Common.SetButtonColor(WaitCallButton);
  if Common.Config.Style = 'D' then
     StyleHeader.Color := $00383838;
end;

procedure TTabling_F.GridWaitViewFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  if GridWaitView.DataController.RecordCount = 0 then
  begin
    WaitCancelButton.Enabled := false;
    WaitCallButton.Enabled   := false;
  end
  else
  begin
    WaitCancelButton.Enabled := true;
    WaitCallButton.Enabled   := true;

    if GridWaitView.DataController.Values[GridWaitView.DataController.GetFocusedRecordIndex, GridWaitViewStatus.Index] = '대기' then
    begin
      WaitCallButton.Caption := '호출';
    end;
  end;

end;

procedure TTabling_F.SetWaitNumber;
var vTeam, vCount :Integer;
begin
  OpenQuery('select a.WAIT_NUMBER, '
           +'       a.CNT_AUDLT, '
           +'       a.CNT_CHILD, '
           +'       a.TEL_MOBILE, '
           +'       Date_Format(a.DT_INSERT, ''%H:%i''), '
           +'       TIMESTAMPDIFF(MINUTE,  a.DT_INSERT, Now() )  as WAIT_TIME, '
           +'       case when b.CD_MENU is NULL then ''N'' else ''Y'' end YN_MENU, '
           +'       case a.DS_STATUS when ''0'' then ''대기'' when ''1'' then ''호출'' end DS_STATUS, '
           +'       a.REMARK '
           +'  from SL_WAIT      as a left outer join '
           +'      (select WAIT_NUMBER, '
           +'              CD_MENU '
           +'         from SL_WAIT_MENU '
           +'        where CD_STORE =:P0 '
           +'          and DS_STATUS in (''0'',''1'') '
           +'        group by WAIT_NUMBER '
           +'      ) as b on b.WAIT_NUMBER = a.WAIT_NUMBER '
           +' where a.CD_STORE =:P0 '
           +' order by a.WAIT_NUMBER ',
           [Common.Config.StoreCode]);

  vTeam   := 0;
  vCount  := 0;
  GridWaitView.DataController.RecordCount := 0;
  GridWaitView.DataController.BeginUpdate;
  while not Common.Query.Eof do
  begin
    vTeam          := vTeam + 1;
    vCount         := vCount + Common.Query.Fields[1].AsInteger + Common.Query.Fields[2].AsInteger;

    GridWaitView.DataController.AppendRecord;
    GridWaitView.DataController.Values[GridWaitView.DataController.RecordCount-1, 0] := IntToStr(GridWaitView.DataController.RecordCount);
    if (Common.Query.Fields[1].AsInteger > 0) and (Common.Query.Fields[2].AsInteger > 0) then
      GridWaitView.DataController.Values[GridWaitView.DataController.RecordCount-1, 1] := Format('성인-%d명, 유아-%d명',[Common.Query.Fields[1].AsInteger, Common.Query.Fields[2].AsInteger])
    else  if (Common.Query.Fields[1].AsInteger > 0) then
      GridWaitView.DataController.Values[GridWaitView.DataController.RecordCount-1, 1] := Format('성인-%d명',[Common.Query.Fields[1].AsInteger])
    else  if (Common.Query.Fields[2].AsInteger > 0) then
      GridWaitView.DataController.Values[GridWaitView.DataController.RecordCount-1, 1] := Format('유아-%d명',[Common.Query.Fields[2].AsInteger]);
    GridWaitView.DataController.Values[GridWaitView.DataController.RecordCount-1, 2] := SetTelephone(Common.Query.FieldByName('TEL_MOBILE').AsString);
    GridWaitView.DataController.Values[GridWaitView.DataController.RecordCount-1, 3] := Format('%d분',[Common.Query.FieldByName('WAIT_TIME').AsInteger]);
    GridWaitView.DataController.Values[GridWaitView.DataController.RecordCount-1, 4] := Common.Query.FieldByName('YN_MENU').AsString;
    GridWaitView.DataController.Values[GridWaitView.DataController.RecordCount-1, 5] := Common.Query.FieldByName('DS_STATUS').AsString;
    GridWaitView.DataController.Values[GridWaitView.DataController.RecordCount-1, 6] := Common.Query.FieldByName('REMARK').AsString;
    GridWaitView.DataController.Values[GridWaitView.DataController.RecordCount-1, 7] := Common.Query.FieldByName('WAIT_NUMBER').AsString;
    Common.Query.Next;
  end;
  GridWaitView.DataController.EndUpdate;
  Common.Query.Close;
  TeamCountLabel.Caption   := Format('%d팀-%d명',[vTeam,vCount]);
end;

end.
