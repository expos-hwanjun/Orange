unit ToDaySaleQty_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxLabel, cxCurrencyEdit, AdvSmoothButton,
  cxClasses, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridCustomView, cxGrid, Vcl.Menus, Vcl.StdCtrls, cxButtons,
  dxGDIPlusClasses, Vcl.ExtCtrls, AdvGlassButton, KeyPad_F, Math, StrUtils;

type
  TToDaySaleQty_F = class(TForm)
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
    GridTableView: TcxGridTableView;
    GridTableViewRcpNo: TcxGridColumn;
    GridTableViewMenuCode: TcxGridColumn;
    GridTableViewMenuName: TcxGridColumn;
    GridTableViewSetQty: TcxGridColumn;
    GridTableViewSaleQty: TcxGridColumn;
    GridTableViewStockQty: TcxGridColumn;
    GridLevel: TcxGridLevel;
    StyleRepository: TcxStyleRepository;
    StyleHeader: TcxStyle;
    StyleFontBold: TcxStyle;
    fmKeyPad1: TfmKeyPad;
    ConfirmButton: TAdvSmoothButton;
    MessageLabel: TLabel;
    Image3: TImage;
    TitleLabel: TLabel;
    CloseButton: TcxButton;
    GridEndButton: TAdvGlassButton;
    GridFirstButton: TAdvGlassButton;
    GridNextButton: TAdvGlassButton;
    GridPrevButton: TAdvGlassButton;
    StyleFontGray: TcxStyle;
    GridTableViewisDefault: TcxGridColumn;
    procedure GridPrevButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure GridTableViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridTableViewSetQtyPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure GridTableViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure GridTableViewSetQtyStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  private
    isRowChange :Boolean;
  public
    { Public declarations }
  end;

var
  ToDaySaleQty_F: TToDaySaleQty_F;

implementation
uses Common_U, GlobalFunc_U, DBModule_U;
{$R *.dfm}

procedure TToDaySaleQty_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TToDaySaleQty_F.ConfirmButtonClick(Sender: TObject);
var vIndex :Integer;
    visDefault :Boolean;
begin
  visDefault := false;
  for vIndex := 0 to GridTableView.DataController.RecordCount-1 do
  begin
    if GridTableView.DataController.Values[vIndex, GridTableViewisDefault.Index] = 'Y' then
    begin
      visDefault := true;
      Break;
    end;
  end;

  if visDefault then
  begin
    if not Common.AskBox('이전 등록 수량을'#13'오늘 수량으로 저장하시겠습니까?') then
    begin
      for vIndex := 0 to GridTableView.DataController.RecordCount-1 do
      begin
        if GridTableView.DataController.Values[vIndex, GridTableViewisDefault.Index] = 'Y' then
           GridTableView.DataController.Values[vIndex, GridTableViewSetQty.Index] := 0;
      end;
    end;
  end;

  try
    Common.BeginTran;
    ExecQuery('delete from MS_MENU_SALEQTY '
             +' where CD_STORE =:P0 '
             +'   and YMD_SALE =:P1 ',
             [Common.Config.StoreCode,
              Common.WorkDate]);
    for vIndex := 0 to GridTableView.DataController.RecordCount-1 do
    begin
      if NVL(GridTableView.DataController.Values[vIndex, GridTableViewSetQty.Index],0) = 0 then Continue;

      ExecQuery('insert into MS_MENU_SALEQTY(CD_STORE, YMD_SALE, CD_MENU, QTY_SET) '
               +'                     values(:P0, :P1, :P2, :P3) '
               +'on duplicate key update QTY_SET = :P3 ',
               [Common.Config.StoreCode,
                Common.WorkDate,
                GridTableView.DataController.Values[vIndex, GridTableViewMenuCode.Index],
                GridTableView.DataController.Values[vIndex, GridTableViewSetQty.Index]]);

      ExecQuery('update MS_MENU '
               +'   set CONFIG = StringPosReplace(CONFIG,8,:P2) '
               +' where CD_STORE = :P0 '
               +'   and CD_MENU  = :P1 ',
               [Common.Config.StoreCode,
                GridTableView.DataController.Values[vIndex, GridTableViewMenuCode.Index],
                Ifthen(GridTableView.DataController.Values[vIndex, GridTableViewStockQty.Index] > 0, 'N','Y')]);
    end;
    Common.CommitTran;
  except
    on E:Exception do
    begin
      Common.RollbackTran;
      Common.WriteLog('당일 판매수량 설정',E.Message);
      Common.ErrBox(E.Message);
      Exit;
    end;
  end;
  Close;
end;

procedure TToDaySaleQty_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(GridPrevButton);
  Common.SetButtonColor(GridNextButton);
  Common.SetButtonColor(ConfirmButton);
    if (Common.Config.Style = 'D') and not Common.Config.IsKiosk then
  begin
    StyleHeader.Color             := $00383838;
  end;

  if GetOption(385) = '1' then
  begin
    fmKeyPad1.Num_000.Visible := false;
    fmKeyPad1.Num_00.Visible  := true;
    fmKeyPad1.Num_00.Top      := fmKeyPad1.Num_000.Top;
    fmKeyPad1.Num_00.Left     := fmKeyPad1.Num_000.Left;
  end;

  IsRowChange := True;

end;

procedure TToDaySaleQty_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    13 : GridTableView.DataController.GotoNext;
  end;
end;

procedure TToDaySaleQty_F.FormShow(Sender: TObject);
begin
  OpenQuery('select '''' as ROWNUM, '
           +'       a.CD_MENU, '
           +'       a.NM_MENU, '
           +'       Ifnull(b.QTY_SET,Ifnull(e.QTY_SET,0)) as QTY_SET,  '
           +'       Ifnull(c.QTY_SALE,0)+Ifnull(d.QTY_ORDER,0) as QTY_SALE, '
           +'       Ifnull(b.QTY_SET,0) - Ifnull(c.QTY_SALE,0)-Ifnull(d.QTY_ORDER,0) as QTY_STOCK, '
           +'       case when b.QTY_SET is null and e.QTY_SET is not null then ''Y'' else ''N'' end YN_DEFAULT '
           +'  from MS_MENU a left outer join '
           +'       MS_MENU_SALEQTY as b on b.YMD_SALE =:P1 '
           +'                           and b.CD_MENU  = a.CD_MENU left outer join '
           +'      (select CD_MENU, '
           +'              SUM(QTY_SALE) as QTY_SALE '
           +'         from SL_SALE_D '
           +'        where CD_STORE =:P0 '
           +'          and YMD_SALE =:P1 '
           +'          and DS_SALE <> ''V'' '
           +'        group by CD_MENU) as c on c.CD_MENU = a.CD_MENU left outer join '
           +'      (select CD_MENU, '
           +'              SUM(QTY_ORDER) as QTY_ORDER '
           +'         from SL_ORDER_D '
           +'        where CD_STORE =:P0 '
           +'       group by CD_MENU) as d on d.CD_MENU = a.CD_MENU left outer join '
           +'       MS_MENU_SALEQTY as e on e.CD_STORE = a.CD_STORE '
           +'                           and e.CD_MENU  = a.CD_MENU '
           +'                           and e.YMD_SALE = :P2 '
           +' where a.CD_STORE     =:P0 '
           +'   and SubString(a.CONFIG,17,1) = ''Y'' '
           +' order by a.CD_MENU     ',
           [Common.Config.StoreCode,
            Common.WorkDate,
            Common.LastCloseDate]);
  DM.ReadQuery(Common.Query, GridTableView);
  GridTableView.Controller.FocusedColumn := GridTableViewSetQty;
  Grid.SetFocus;
end;

procedure TToDaySaleQty_F.GridPrevButtonClick(Sender: TObject);
begin
  if Sender = GridFirstButton then
  begin
    if GridTableView.Controller.FocusedRowIndex >= 10 then
      GridTableView.Controller.FocusedRowIndex :=  GridTableView.Controller.FocusedRowIndex - 10
    else
      GridTableView.DataController.GotoFirst;
  end
  else if Sender = GridPrevButton then GridTableView.DataController.GotoPrev
  else if Sender = GridEndButton then
  begin
    if GridTableView.Controller.FocusedRowIndex + 10 <= GridTableView.DataController.RecordCount then
      GridTableView.Controller.FocusedRowIndex :=  GridTableView.Controller.FocusedRowIndex + 10
    else
      GridTableView.DataController.GotoLast;
  end
  else if Sender = GridNextButton then GridTableView.DataController.GotoNext;
end;

procedure TToDaySaleQty_F.GridTableViewCellClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  IsRowChange := True;
end;

procedure TToDaySaleQty_F.GridTableViewFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  GridTableView.Controller.FocusedColumn := GridTableViewSetQty;
  Grid.SetFocus;
end;

procedure TToDaySaleQty_F.GridTableViewSetQtyPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewStockQty.Index]  := Currency(DisplayValue) - GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewSaleQty.Index];
  GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex, GridTableViewisDefault.Index] := 'N';
end;

procedure TToDaySaleQty_F.GridTableViewSetQtyStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if ARecord.Values[GridTableViewisDefault.Index] = 'Y' then
    AStyle := styleFontGray;
end;

end.
