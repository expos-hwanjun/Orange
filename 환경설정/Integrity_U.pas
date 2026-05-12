unit Integrity_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxGridCustomTableView, cxGridTableView, cxGridCustomView,
  cxClasses, cxGridLevel, cxGrid, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, StdCtrls, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxNavigator, Vcl.Menus, dxGDIPlusClasses, Vcl.ExtCtrls, Vcl.WinXCalendars,
  cxButtons;

type
  TIntegrity_F = class(TForm)
    GridLevel: TcxGridLevel;
    Grid: TcxGrid;
    GridTableView: TcxGridTableView;
    GridTableViewColumn1: TcxGridColumn;
    GridTableViewColumn2: TcxGridColumn;
    GridTableViewColumn3: TcxGridColumn;
    TitleLabel: TLabel;
    CloseButton: TcxButton;
    SearchPicker: TCalendarPicker;
    MessageLabel: TLabel;
    Image3: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure SearchPickerChange(Sender: TObject);
  private
    procedure IntegrityCheckSearch;
  public
    { Public declarations }
  end;

var
  Integrity_F: TIntegrity_F;

implementation
uses Common_U, GlobalFunc_U;
{$R *.dfm}

procedure TIntegrity_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TIntegrity_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
end;

procedure TIntegrity_F.IntegrityCheckSearch;
begin
  OpenQuery('select DT_CHECK, '
           +'       DS_STATUS, '
           +'       REMARK '
           +'  from SL_INTEGRITY '
           +' where CD_STORE =:P0 '
           +'   and NO_POS   =:P1 '
           +'   and Date_Format(DT_CHECK, ''%Y%m%d'') = :P2 '
           +' order by DT_CHECK desc ',
           [Common.Config.StoreCode,
            Common.Config.PosNo,
            FormatDateTime('yyyymmdd', SearchPicker.Date)]);
  GridTableView.DataController.RecordCount := 0;
  GridTableView.DataController.BeginUpdate;
  while not Common.Query.Eof do
  begin
    GridTableView.DataController.AppendRecord;
    GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, 0] := Common.Query.Fields[0].AsString;
    GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, 1] := Common.Query.Fields[1].AsString;
    GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, 2] := Common.Query.Fields[2].AsString;
    Common.Query.Next;
  end;
  GridTableView.DataController.EndUpdate;
  Common.Query.Close;
end;

procedure TIntegrity_F.SearchPickerChange(Sender: TObject);
begin
  IntegrityCheckSearch;
end;

procedure TIntegrity_F.FormShow(Sender: TObject);
begin
  SearchPicker.Date := Now();
  IntegrityCheckSearch;
end;

end.
