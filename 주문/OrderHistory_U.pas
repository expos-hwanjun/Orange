unit OrderHistory_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxLabel, cxCurrencyEdit, Vcl.Menus,
  Vcl.StdCtrls, AdvGlassButton, AdvSmoothButton, cxButtons, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridCustomView, cxGrid, cxClasses,
  AdvSmoothToggleButton, StrUtils, Vcl.ExtCtrls, dxDateRanges,
  dxScrollbarAnnotations;

type
  TOrderHistory_F = class(TForm)
    StyleRepository: TcxStyleRepository;
    StyleFontRed: TcxStyle;
    StyleHeader: TcxStyle;
    cxStyle2: TcxStyle;
    Grid: TcxGrid;
    GridTableView1: TcxGridTableView;
    GridTableView1TableName: TcxGridColumn;
    GridTableView1LapeTime: TcxGridColumn;
    GridTableView1OrderMenu: TcxGridColumn;
    GridTableView: TcxGridTableView;
    GridLevel: TcxGridLevel;
    GridTableViewOrderDate: TcxGridColumn;
    GridTableViewMenuName: TcxGridColumn;
    GridTableViewOrderQty: TcxGridColumn;
    GridTableViewTableNo: TcxGridColumn;
    GridTableViewPosNo: TcxGridColumn;
    CloseButton: TcxButton;
    MenuSearchButton: TAdvSmoothButton;
    Minute5Button: TAdvSmoothButton;
    Minute10Button: TAdvSmoothButton;
    Minute15Button: TAdvSmoothButton;
    Minute20Button: TAdvSmoothButton;
    FullButton: TAdvSmoothButton;
    PosButton: TAdvSmoothButton;
    LetsOrderButton: TAdvSmoothButton;
    GridPrevButton: TAdvGlassButton;
    GridNextButton: TAdvGlassButton;
    TitleLabel: TLabel;
    GridTableViewOrderNo: TcxGridColumn;
    CashbyButton: TAdvSmoothToggleButton;
    TableByButton: TAdvSmoothToggleButton;
    GridTableView1TableNo: TcxGridColumn;
    GridTableView1OrderNo: TcxGridColumn;
    DetailOrderButton: TAdvSmoothToggleButton;
    DetailTimer: TTimer;
    procedure CloseButtonClick(Sender: TObject);
    procedure Minute5ButtonClick(Sender: TObject);
    procedure FullButtonClick(Sender: TObject);
    procedure MenuSearchButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GridPrevButtonClick(Sender: TObject);
    procedure GridTableViewStylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      var AStyle: TcxStyle);
    procedure CashbyButtonClick(Sender: TObject);
    procedure DetailOrderButtonClick(Sender: TObject);
    procedure GridTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure DetailTimerTimer(Sender: TObject);
  private
    isFormShow :Boolean;
    TableNo,
    OrderNo :Integer;
  public
    procedure SelectOrderMenu;
  end;

var
  OrderHistory_F: TOrderHistory_F;

implementation
uses DBModule_U, Common_U, GlobalFunc_U, MenuSearch2_U, Const_U;
{$R *.dfm}

procedure TOrderHistory_F.CashbyButtonClick(Sender: TObject);
begin
  if Sender = CashbyButton then
  begin
    CashbyButton.Appearance.SimpleLayout     := true;
    CashbyButton.Status.Visible              := true;
    TableByButton.Appearance.SimpleLayout    := false;
    TableByButton.Status.Visible             := false;
    CashbyButton.Color                       := $00DF7000;
    TableByButton.Color                      := $00793D00;
    MenuSearchButton.Caption                 := '메뉴조회';
    GridLevel.GridView                       := GridTableView;
    SelectOrderMenu;
    DetailOrderButton.Visible                := false;
  end
  else
  begin
    TableByButton.Appearance.SimpleLayout    := true;
    TableByButton.Status.Visible             := true;
    CashbyButton.Appearance.SimpleLayout     := false;
    CashbyButton.Status.Visible              := false;
    TableByButton.Color                      := $00DF7000;
    CashbyButton.Color                       := $00793D00;
    MenuSearchButton.Caption                 := '주문확인';
    GridLevel.GridView                       := GridTableView1;
    SelectOrderMenu;
    DetailOrderButton.Visible                := true;
  end;
end;

procedure TOrderHistory_F.CloseButtonClick(Sender: TObject);
begin
  Common.SetIniFile(iniPos, '주문이력',Ifthen(TableByButton.Appearance.SimpleLayout,'Y','N'));
  Close;
end;

procedure TOrderHistory_F.DetailOrderButtonClick(Sender: TObject);
begin
  if GridTableView1.DataController.GetFocusedRecordIndex < 0 then Exit;
  TableNo := GridTableView1.DataController.Values[GridTableView1.DataController.GetFocusedRecordIndex, GridTableView1TableNo.Index];
  OrderNo := GridTableView1.DataController.Values[GridTableView1.DataController.GetFocusedRecordIndex, GridTableView1OrderNo.Index];
  CashbyButtonClick(CashbyButton);
  TableNo := -1;
  OrderNo := -1;
end;

procedure TOrderHistory_F.DetailTimerTimer(Sender: TObject);
begin
  DetailTimer.Enabled := false;
  DetailOrderButtonClick(nil);
end;

procedure TOrderHistory_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,1);
  Common.SetButtonColor(Minute5Button);
  Common.SetButtonColor(Minute10Button);
  Common.SetButtonColor(Minute15Button);
  Common.SetButtonColor(Minute20Button);
  Common.SetButtonColor(MenuSearchButton);
  if Common.Config.Style = 'D' then
    StyleHeader.Color :=  $00121212;
  isFormShow := false;
  TableNo := -1;
  OrderNo := -1;
end;

procedure TOrderHistory_F.FormShow(Sender: TObject);
begin
  Minute5ButtonClick(Minute20Button);
  if Common.GetIniFile(iniPos, '주문이력','N') = 'N' then
    CashbyButtonClick(CashbyButton)
  else
    CashbyButtonClick(TableByButton);

  isFormShow := True;
end;

procedure TOrderHistory_F.FullButtonClick(Sender: TObject);
begin
  FullButton.Status.Visible      := false;
  PosButton.Status.Visible       := false;
  LetsOrderButton.Status.Visible := false;
  (Sender as TAdvSmoothButton).Status.Visible := true;
  SelectOrderMenu;
end;

procedure TOrderHistory_F.GridPrevButtonClick(Sender: TObject);
begin
  if GridLevel.GridView = GridTableView then
  begin
    if Sender = GridPrevButton then GridTableView.DataController.GotoPrev
    else if Sender = GridNextButton then GridTableView.DataController.GotoNext;
  end
  else
  begin
    if Sender = GridPrevButton then GridTableView1.DataController.GotoPrev
    else if Sender = GridNextButton then GridTableView1.DataController.GotoNext;
  end;
end;

procedure TOrderHistory_F.GridTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  DetailTimer.Enabled := true;
end;

procedure TOrderHistory_F.GridTableViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if ARecord.Values[2] < 0 then
    AStyle := styleFontRed;
end;

procedure TOrderHistory_F.MenuSearchButtonClick(Sender: TObject);
begin
  if CashbyButton.Appearance.SimpleLayout then
  begin
    MenuSearch2_F := TMenuSearch2_F.Create(Self);
    try
      MenuSearch2_F.isOnlySearch := true;
      if MenuSearch2_F.ShowModal = mrOK then
      begin
        MenuSearchButton.Status.Visible := true;
        MenuSearchButton.Status.Caption := MenuSearch2_F.SelectName;
        MenuSearchButton.Hint           := MenuSearch2_F.SelectCode;
      end
      else
      begin
        MenuSearchButton.Status.Visible := false;
        MenuSearchButton.Status.Caption := '';
        MenuSearchButton.Hint           := '';
      end;
    finally
      MenuSearch2_F.Free;
    end;
    SelectOrderMenu;
  end
  else
  begin
    if GridTableView1.DataController.GetFocusedRecordIndex < 0 then
    begin
      Common.MsgBox('삭제할 테이블을 선택하세요');
      Exit;
    end;
    ExecQuery('update SL_ORDER_HIST '
             +'   set DS_STATUS  = ''C'', '
             +'       DT_CONFIRM = Now() '
             +' where CD_STORE =:P0 '
             +'   and NO_TABLE =:P1 '
             +'   and NO_ORDER =:P2 ',
             [Common.Config.StoreCode,
              GridTableView1.DataController.Values[GridTableView1.DataController.GetFocusedRecordIndex, GridTableView1TableNo.Index],
              GridTableView1.DataController.Values[GridTableView1.DataController.GetFocusedRecordIndex, GridTableView1OrderNo.Index]]);
    GridTableView1.DataController.DeleteRecord(GridTableView1.DataController.GetFocusedRecordIndex);
  end;
end;

procedure TOrderHistory_F.Minute5ButtonClick(Sender: TObject);
begin
  Minute5Button.Status.Visible  := false;
  Minute10Button.Status.Visible := false;
  Minute15Button.Status.Visible := false;
  Minute20Button.Status.Visible := false;

  (Sender as TAdvSmoothButton).Status.Visible := true;
  if not isFormShow then Exit;
  SelectOrderMenu;
end;

procedure TOrderHistory_F.SelectOrderMenu;
var vWhere, vMenu :String;
    vMinute, vIndex :Integer;
begin
  if Minute5Button.Status.Visible then
    vMinute := 5
  else if Minute10Button.Status.Visible then
    vMinute := 10
  else if Minute15Button.Status.Visible then
    vMinute := 15
  else if Minute20Button.Status.Visible then
    vMinute := 20;

  vWhere := '';
  if PosButton.Status.Visible then
    vWhere := ' and a.DS_ORDER = ''P'' '
  else if LetsOrderButton.Status.Visible then
    vWhere := ' and a.DS_ORDER = ''L'' ';

  if MenuSearchButton.Status.Visible then
    vWhere := vWhere + Format(' and a.CD_MENU = ''%s'' ',[MenuSearchButton.Hint]);

  if CashbyButton.Appearance.SimpleLayout then
  begin
    if TableNo = -1 then
      OpenQuery('select GetTableName(a.CD_STORE, a.NO_TABLE), '
               +'       b.NM_MENU_SHORT,  '
               +'       a.QTY_ORDER, '
               +'       ConCat(a.NO_POS,'' - '',a.DS_ORDER), '
               +'       a.NO_ORDER, '
               +'       Date_Format(a.DT_ORDER, ''%H:%i:%s'') '
               +'  from SL_ORDER_HIST as a inner join '
               +'       MS_MENU       as b on b.CD_STORE = a.CD_STORE '
               +'                         and b.CD_MENU  = a.CD_MENU '
               +' where a.CD_STORE =:P0 '
               +'   and TIMESTAMPDIFF(minute,  a.DT_ORDER, NOW() ) <= :P1 '
               +vWhere
               +' order by a.DT_ORDER desc ',
               [Common.Config.StoreCode,
                vMinute])
    else
      OpenQuery('select GetTableName(a.CD_STORE, a.NO_TABLE), '
               +'       b.NM_MENU_SHORT,  '
               +'       a.QTY_ORDER, '
               +'       ConCat(a.NO_POS,'' - '',a.DS_ORDER), '
               +'       a.NO_ORDER, '
               +'       Date_Format(a.DT_ORDER, ''%H:%i:%s'') '
               +'  from SL_ORDER_HIST as a inner join '
               +'       MS_MENU       as b on b.CD_STORE = a.CD_STORE '
               +'                         and b.CD_MENU  = a.CD_MENU '
               +' where a.CD_STORE =:P0 '
               +'   and TIMESTAMPDIFF(minute,  a.DT_ORDER, NOW() ) <= :P1 '
               +'   and a.NO_TABLE =:P2 '
               +'   and a.NO_ORDER =:P3 '
               +vWhere
               +' order by a.DT_ORDER desc ',
               [Common.Config.StoreCode,
                vMinute,
                TableNo,
                OrderNo]);


    GridTableView.DataController.RecordCount := 0;
    GridTableView.DataController.BeginUpdate;
    while not Common.Query.Eof do
    begin
      GridTableView.DataController.AppendRecord;
      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, 0] := Common.Query.Fields[0].AsString;
      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, 1] := Common.Query.Fields[1].AsString;
      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, 2] := Common.Query.Fields[2].AsInteger;
      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, 3] := Common.Query.Fields[3].AsString;
      if Common.Query.Fields[2].AsInteger > 0 then
        GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, 4] := Common.Query.Fields[4].AsString;
      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, 5] := Common.Query.Fields[5].AsString;
      Common.Query.Next;
    end;
    GridTableView.DataController.EndUpdate;
    Common.Query.Close;
  end
  else
  begin
    OpenQuery('select GetTableName(a.CD_STORE, a.NO_TABLE) as NM_TABLE, '
             +'       a.NO_ORDER,  '
             +'		  	TIMESTAMPDIFF(MINUTE,  a.DT_ORDER, Now() ) as LAPSE_TIME, '
             +'       a.DS_ORDER, '
             +'       a.NO_TABLE '
             +'  from SL_ORDER_HIST as a '
             +' where a.CD_STORE =:P0 '
             +'   and TIMESTAMPDIFF(minute,  a.DT_ORDER, NOW() ) <= :P1 '
             +vWhere
             +'   and a.DS_STATUS = ''O'' '
             +' group by a.NO_TABLE, a.NO_ORDER '
             +' order by a.DT_ORDER desc ',
             [Common.Config.StoreCode,
              vMinute]);
    DM.ReadQuery(Common.Query, GridTableView1);
    GridTableView1.DataController.BeginUpdate;
    for vIndex := 0 to GridTableView1.DataController.RecordCount-1 do
    begin
      OpenQuery('select b.NM_MENU_SHORT as NM_MENU, '
               +'       a.QTY_ORDER '
               +'  from SL_ORDER_HIST as a inner join '
               +'       MS_MENU       as b on b.CD_STORE = a.CD_STORE '
               +'                         and b.CD_MENU  = a.CD_MENU '
               +' where a.CD_STORE  =:P0 '
               +'   and a.NO_TABLE =:P1 '
               +'   and a.NO_ORDER  =:P2 ',
               [Common.Config.StoreCode,
                GridTableView1.DataController.Values[vIndex, GridTableView1TableNo.Index],
                GridTableView1.DataController.Values[vIndex, GridTableView1OrderNo.Index]]);
      vMenu := '';
      while not Common.Query.Eof do
      begin
        vMenu := vMenu + Format('%s(%d)',[Common.Query.FieldByName('NM_MENU').AsString,
                                          Common.Query.FieldByName('QTY_ORDER').AsInteger]);
        Common.Query.Next;
      end;
      Common.Query.Close;
      GridTableView1.DataController.Values[vIndex, GridTableView1OrderMenu.Index] := vMenu;
    end;
    GridTableView1.DataController.EndUpdate;
  end;
end;

end.
