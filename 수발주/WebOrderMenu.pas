unit WebOrderMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxCurrencyEdit,
  cxContainer, cxTextEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxClasses, cxGridCustomView, cxGrid, AdvGlowButton, Vcl.StdCtrls,
  Vcl.ExtCtrls, cxButtons, StrUtils, AdvSmoothButton;

type
  TWebOrderMenuForm = class(TForm)
    CloseButton: TcxButton;
    ConditionSearchLabel: TLabel;
    ConditionSearchEdit: TcxTextEdit;
    CaptionLabel: TLabel;
    CommentLabel: TLabel;
    Grid: TcxGrid;
    GridTableView: TcxGridTableView;
    GridTableViewGoodsClass: TcxGridColumn;
    GridTableViewGoodsCode: TcxGridColumn;
    GridTableViewGoodsName: TcxGridColumn;
    GridTableViewOrderUnit: TcxGridColumn;
    GridTableViewNepumQty: TcxGridColumn;
    GridTableViewKeepName: TcxGridColumn;
    GridTableViewOrderPrice: TcxGridColumn;
    GridTableViewOrderQty: TcxGridColumn;
    GridTableViewDsTax: TcxGridColumn;
    GridLevel: TcxGridLevel;
    StyleRepository: TcxStyleRepository;
    cxStyle41: TcxStyle;
    StyleHeader: TcxStyle;
    StyleFooter: TcxStyle;
    StyleLevel: TcxStyle;
    AddGrid: TcxGrid;
    AddGridTableView: TcxGridTableView;
    AddGridTableViewGoodsClass: TcxGridColumn;
    AddGridTableViewGoodsCode: TcxGridColumn;
    AddGridTableViewGoodsName: TcxGridColumn;
    AddGridTableViewOrderUnit: TcxGridColumn;
    AddGridTableViewNepumQty: TcxGridColumn;
    AddGridTableViewKeep: TcxGridColumn;
    AddGridTableViewOrderPrice: TcxGridColumn;
    AddGridTableViewOrderQty: TcxGridColumn;
    AddGridTableViewDsTax: TcxGridColumn;
    AddGridLevel: TcxGridLevel;
    SaveButton: TAdvSmoothButton;
    MenuDecButton: TAdvSmoothButton;
    MenuAddButton: TAdvSmoothButton;
    MenuSearchButton: TAdvSmoothButton;
    procedure CloseButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuSearchButtonClick(Sender: TObject);
    procedure ConditionSearchEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MenuAddButtonClick(Sender: TObject);
    procedure MenuDecButtonClick(Sender: TObject);
    procedure GridTableViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure AddGridTableViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
  public
    OrderLimitCode :String;
  end;

var
  WebOrderMenuForm: TWebOrderMenuForm;

implementation
uses Common_U, DBModule_U, GlobalFunc_U, Const_U;

{$R *.dfm}

procedure TWebOrderMenuForm.AddGridTableViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var vCol :Integer;
begin
  // 위 그리드 내용을 아래 그리드에 넣는다
  GridTableView.DataController.AppendRecord;
  for vCol := 0 to AddGridTableView.ColumnCount-1 do
    GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, vCol] := AddGridTableView.DataController.Values[AddGridTableView.DataController.GetFocusedRecordIndex,vCol];

  AddGridTableView.DataController.DeleteRecord(AddGridTableView.DataController.GetFocusedRecordIndex);
end;

procedure TWebOrderMenuForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TWebOrderMenuForm.ConditionSearchEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_Return then
    MenuSearchButton.Click;

end;

procedure TWebOrderMenuForm.FormCreate(Sender: TObject);
begin
  ClientWidth   := Common.Config.PosWidth;
  ClientHeight  := Common.Config.PosHeight;
  Common.LogoCreate(Self,1);
end;

procedure TWebOrderMenuForm.GridTableViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var vCol :Integer;
begin
  if AddGridTableView.DataController.FindRecordIndexByText(0, AddGridTableViewGoodsCode.Index, GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex,GridTableViewGoodsCode.Index], false, false, true) > -1 then
    Exit;

  // 위 그리드 내용을 아래 그리드에 넣는다
  AddGridTableView.DataController.AppendRecord;
  for vCol := 0 to GridTableView.ColumnCount-1 do
    AddGridTableView.DataController.Values[AddGridTableView.DataController.RecordCount-1, vCol] := GridTableView.DataController.Values[GridTableView.DataController.GetFocusedRecordIndex,vCol];

  AddGridTableView.DataController.Values[AddGridTableView.DataController.RecordCount-1, AddGridTableViewOrderQty.Index] := 1;

  GridTableView.DataController.DeleteRecord(GridTableView.DataController.GetFocusedRecordIndex);
end;

procedure TWebOrderMenuForm.MenuAddButtonClick(Sender: TObject);
var
  vRow, vCol, vCount: Integer;
begin
  vCount := 0;
  GridTableView.DataController.PostEditingData;

  AddGridTableView.BeginUpdate;

  for vRow := 0 to GridTableView.DataController.RecordCount-1 do
  begin
    if GridTableView.DataController.Values[vRow, GridTableViewOrderQty.Index] = 0 then Continue;

    // 아래 그리드에 같은 상품이 있으면 그냥 넘어간다
    if AddGridTableView.DataController.FindRecordIndexByText(0, AddGridTableViewGoodsCode.Index, GridTableView.DataController.Values[vRow, GridTableViewGoodsCode.Index], false, false, true) > -1 then
      Continue;

    // 위 그리드 내용을 아래 그리드에 넣는다
    AddGridTableView.DataController.AppendRecord;
    for vCol := 0 to GridTableView.ColumnCount-1 do
      AddGridTableView.DataController.Values[AddGridTableView.DataController.RecordCount-1, vCol] := GridTableView.DataController.Values[vRow, vCol];

    Inc(vCount);
  end;

  AddGridTableView.EndUpdate;
  for vRow := GridTableView.DataController.RecordCount-1 downto 0 do
    if GridTableView.DataController.Values[vRow, GridTableViewOrderQty.Index] <> 0 then
      GridTableView.DataController.DeleteRecord(vRow);

  if vCount = 0 then
    Exit;

  // 아래 그리드를 보여준다
  AddGrid.Visible  := true;
end;

procedure TWebOrderMenuForm.MenuDecButtonClick(Sender: TObject);
var vRow, vCol, vIndex :Integer;
begin
  GridTableView.BeginUpdate;

  for vRow := 0 to AddGridTableView.Controller.SelectedRowCount - 1 do
  begin
    // 위 그리드 내용을 아래 그리드에 넣는다
    GridTableView.DataController.AppendRecord;
    for vCol := 0 to GridTableView.ColumnCount-1 do
      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, vCol] := AddGridTableView.Controller.SelectedRows[vRow].Values[vCol];
  end;

  for vRow := AddGridTableView.Controller.SelectedRowCount - 1 downto 0 do
    AddGridTableView.DataController.DeleteRecord(AddGridTableView.Controller.SelectedRows[vRow].RecordIndex);

  GridTableView.EndUpdate;
end;

procedure TWebOrderMenuForm.MenuSearchButtonClick(Sender: TObject);
var
  vIndex  : Integer;
  vGoods  : String;
begin
  vGoods := '';
  for vIndex := 0 to AddGridTableView.DataController.RecordCount-1 do
    vGoods := vGoods + Format('''%s'',',[AddGridTableView.DataController.Values[vIndex, AddGridTableViewGoodsCode.Index]]);

  if vGoods <> '' then
    vGoods := Format(' and a.CD_GOODS not in (%s) ',[LeftStr(vGoods, Length(vGoods)-1)]);

  try
    Screen.Cursor := crHourGlass;
    DM.OpenCloud('select   c.NM_CODE1 as NM_CLASS, '
                +'         a.CD_GOODS, '
                +'         a.NM_GOODS, '
                +'         a.NM_UNIT, '
                +'         a.QTY_NEPUM, '
                +'         d.NM_CODE1 as NM_KEEP, '
                +'         a.PR_SALE, '
                +'         a.DS_TAX '
                +'  from   MS_GOODS as a left outer join '
                +Ifthen(OrderLimitCode <> '', ' MS_CODE  as b on b.CD_HEAD  = a.CD_HEAD '
                +'                      and b.CD_STORE = a.CD_STORE '
                +'                      and b.CD_KIND  = ''06'' '
                +Format('               and b.CD_CODE  = ''%s'' ',[OrderLimitCode])
                +'                      and Substring(b.NM_CODE2, DAYOFWEEK(Now()), 1) = ''1'' '
                +'                      and b.NM_CODE3 <= Date_Format(Now(), ''%H:%i'') '
                +'                      and b.NM_CODE4 >= Date_Format(Now(), ''%H:%i'') left outer join ','')
                +'         MS_CODE  as c on c.CD_HEAD  = a.CD_HEAD '
                +'                      and c.CD_STORE = a.CD_STORE '
                +'                      and c.CD_KIND  = ''04'' '
                +'                      and c.CD_CODE  = a.CD_CLASS left outer join '
                +'         MS_CODE  as d on d.CD_HEAD  = a.CD_HEAD '
                +'                      and d.CD_STORE = a.CD_STORE '
                +'                      and d.CD_KIND  = ''07'' '
                +'                      and d.CD_CODE  = a.CD_KEEP '
                +' where   a.CD_HEAD  = :P0 '
                +'   and   a.CD_STORE = :P1 '
                +'   and   a.NM_GOODS like ConCat(''%'',:P2,''%'') '
                +'   and   a.DS_STATUS    = ''Y'' '
                +vGoods
                +' order by a.NM_GOODS',
                 [Common.Config.HeadStoreCode,
                  StandardStore,
                  ConditionSearchEdit.Text],Common.RestDBURL);
    GridTableView.BeginUpdate;
    GridTableView.DataController.RecordCount := 0;
    while not DM.CloudData.Eof do
    begin
      GridTableView.DataController.AppendRecord;
      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewGoodsClass.Index]        := DM.CloudData.Fields[0].AsString;
      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewGoodsCode.Index]         := DM.CloudData.Fields[1].AsString;
      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewGoodsName.Index]         := DM.CloudData.Fields[2].AsString;
      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewOrderUnit.Index]         := DM.CloudData.Fields[3].AsString;
      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewNepumQty.Index]          := DM.CloudData.Fields[4].AsInteger;
      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewKeepName.Index]          := DM.CloudData.Fields[5].AsString;
      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewOrderQty.Index]          := 0;
      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewOrderPrice.Index]        := DM.CloudData.Fields[6].AsCurrency;
      GridTableView.DataController.Values[GridTableView.DataController.RecordCount-1, GridTableViewDsTax.Index]             := DM.CloudData.Fields[7].AsString;
      GridTableView.DataController.Post;
      DM.CloudData.Next;
    end;
  finally
    DM.CloudData.Close;
    GridTableView.EndUpdate;
    if GridTableView.DataController.RecordCount > 0 then
      Grid.SetFocus;
    Screen.Cursor := crDefault;
  end;
end;

end.
