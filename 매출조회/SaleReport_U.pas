unit SaleReport_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, StdCtrls, cxButtons, cxPC,
  cxControls, cxLookAndFeels, cxLabel, cxCurrencyEdit, cxStyles,
  cxCustomData, cxGraphics, DB, cxDBData, cxGridLevel, cxGridChartView,
  cxGridDBChartView, cxClasses, cxGridCustomView, cxGrid, cxFilter, cxData,
  cxDataStorage,  ExtCtrls, StrUtils, cxProgressBar,  MemDS,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCardView, cxGridBandedTableView, Math, PosButton, SHDocVw,
  DBAccess, Uni, cxPCdxBarPopupMenu, dxBarBuiltInMenu, cxNavigator,
  Vcl.ComCtrls, dxCore, cxDateUtils, AdvGlassButton, ActiveX, AdvPageControl,
  dxDateRanges, dxScrollbarAnnotations;

type
  TSaleReport_F = class(TForm)
    SearchDateEdit: TcxDateEdit;
    SearchButton: TAdvGlassButton;
    PrintButton: TAdvGlassButton;
    StyleRepository: TcxStyleRepository;
    cxStyle41: TcxStyle;
    StyleHeader: TcxStyle;
    ReportPager: TAdvPageControl;
    TotalTabSheet: TAdvTabSheet;
    MenuTabSheet: TAdvTabSheet;
    CalenderTab: TAdvTabSheet;
    TimeTabSheet: TAdvTabSheet;
    CancelTabSheet: TAdvTabSheet;
    edtNow9: TcxCurrencyEdit;
    edtNow8: TcxCurrencyEdit;
    edtNow2: TcxCurrencyEdit;
    edtNow3: TcxCurrencyEdit;
    edtNow7: TcxCurrencyEdit;
    edtNow6: TcxCurrencyEdit;
    edtNow5: TcxCurrencyEdit;
    edtNow4: TcxCurrencyEdit;
    edtNow1: TcxCurrencyEdit;
    txtNow: TcxTextEdit;
    edtBefDay9: TcxCurrencyEdit;
    edtBefDay8: TcxCurrencyEdit;
    edtBefDay2: TcxCurrencyEdit;
    edtBefDay3: TcxCurrencyEdit;
    edtBefDay7: TcxCurrencyEdit;
    edtBefDay6: TcxCurrencyEdit;
    edtBefDay5: TcxCurrencyEdit;
    edtBefDay4: TcxCurrencyEdit;
    edtBefDay1: TcxCurrencyEdit;
    txtBefDay: TcxTextEdit;
    lblNow1: TcxTextEdit;
    lblNow4: TcxTextEdit;
    lblNow5: TcxTextEdit;
    lblNow6: TcxTextEdit;
    lblNow7: TcxTextEdit;
    txtBefWeek: TcxTextEdit;
    cxTextEdit24: TcxTextEdit;
    edtBefWeek1: TcxCurrencyEdit;
    edtBefWeek4: TcxCurrencyEdit;
    edtBefWeek5: TcxCurrencyEdit;
    edtBefWeek6: TcxCurrencyEdit;
    edtBefWeek7: TcxCurrencyEdit;
    txtBefMonth: TcxTextEdit;
    edtBefMonth1: TcxCurrencyEdit;
    edtBefMonth4: TcxCurrencyEdit;
    edtBefMonth5: TcxCurrencyEdit;
    edtBefMonth6: TcxCurrencyEdit;
    edtBefMonth7: TcxCurrencyEdit;
    lblNow3: TcxTextEdit;
    edtBefWeek3: TcxCurrencyEdit;
    edtBefMonth3: TcxCurrencyEdit;
    cxLabel2: TcxLabel;
    txtWeek1: TcxTextEdit;
    txtWeek3: TcxTextEdit;
    txtWeek4: TcxTextEdit;
    txtWeek5: TcxTextEdit;
    txtWeek6: TcxTextEdit;
    edtWeek1: TcxCurrencyEdit;
    edtWeek3: TcxCurrencyEdit;
    edtWeek4: TcxCurrencyEdit;
    edtWeek5: TcxCurrencyEdit;
    edtWeek6: TcxCurrencyEdit;
    txtWeek2: TcxTextEdit;
    edtWeek2: TcxCurrencyEdit;
    txtWeek7: TcxTextEdit;
    edtWeek7: TcxCurrencyEdit;
    edtWeekPer1: TcxCurrencyEdit;
    edtWeekPer3: TcxCurrencyEdit;
    edtWeekPer4: TcxCurrencyEdit;
    edtWeekPer5: TcxCurrencyEdit;
    edtWeekPer6: TcxCurrencyEdit;
    edtWeekPer2: TcxCurrencyEdit;
    edtWeekPer7: TcxCurrencyEdit;
    lblNow2: TcxTextEdit;
    edtBefWeek2: TcxCurrencyEdit;
    edtBefMonth2: TcxCurrencyEdit;
    cxLabel1: TcxLabel;
    cxTextEdit6: TcxTextEdit;
    cxTextEdit7: TcxTextEdit;
    cxTextEdit8: TcxTextEdit;
    edtOrderAmt: TcxCurrencyEdit;
    edtTotalAmt: TcxCurrencyEdit;
    edtTable: TcxTextEdit;
    PayPanel: TPanel;
    ClassPanel: TPanel;
    lblNow8: TcxTextEdit;
    edtBefWeek8: TcxCurrencyEdit;
    edtBefMonth8: TcxCurrencyEdit;
    lblNow9: TcxTextEdit;
    edtBefWeek9: TcxCurrencyEdit;
    edtBefMonth9: TcxCurrencyEdit;
    edtNow10: TcxCurrencyEdit;
    edtBefDay10: TcxCurrencyEdit;
    lblNow10: TcxTextEdit;
    edtBefWeek10: TcxCurrencyEdit;
    edtBefMonth10: TcxCurrencyEdit;
    cxGrid: TcxGrid;
    MenuGridView: TcxGridTableView;
    MenuGridViewMenuCode: TcxGridColumn;
    MenuGridViewMenuName: TcxGridColumn;
    MenuGridViewSaleQty: TcxGridColumn;
    MenuGridViewTotAmt: TcxGridColumn;
    MenuGridViewDcAmt: TcxGridColumn;
    MenuGridViewSaleAmt: TcxGridColumn;
    MenuGridViewVatAmt: TcxGridColumn;
    MenuGridViewSoonAmt: TcxGridColumn;
    cxGridLevel2: TcxGridLevel;
    MenuPanel: TPanel;
    cxGrid1: TcxGrid;
    bvGridView: TcxGridBandedTableView;
    bvGridViewColumn1: TcxGridBandedColumn;
    bvGridViewColumn2: TcxGridBandedColumn;
    bvGridViewColumn3: TcxGridBandedColumn;
    bvGridViewColumn4: TcxGridBandedColumn;
    bvGridViewColumn5: TcxGridBandedColumn;
    bvGridViewColumn6: TcxGridBandedColumn;
    bvGridViewColumn7: TcxGridBandedColumn;
    bvGridViewColumn8: TcxGridBandedColumn;
    bvGridViewColumn9: TcxGridBandedColumn;
    bvGridViewColumn10: TcxGridBandedColumn;
    bvGridViewColumn11: TcxGridBandedColumn;
    bvGridViewColumn12: TcxGridBandedColumn;
    bvGridViewColumn13: TcxGridBandedColumn;
    bvGridViewColumn14: TcxGridBandedColumn;
    bvGridViewColumn15: TcxGridBandedColumn;
    bvGridViewColumn16: TcxGridBandedColumn;
    bvGridViewColumn17: TcxGridBandedColumn;
    bvGridViewColumn18: TcxGridBandedColumn;
    bvGridViewColumn19: TcxGridBandedColumn;
    bvGridViewColumn20: TcxGridBandedColumn;
    bvGridViewColumn21: TcxGridBandedColumn;
    bvGridViewColumn22: TcxGridBandedColumn;
    bvGridViewColumn23: TcxGridBandedColumn;
    bvGridViewRate: TcxGridBandedColumn;
    bvGridView1: TcxGridBandedTableView;
    bvGridView1Column1: TcxGridBandedColumn;
    bvGridView1Column2: TcxGridBandedColumn;
    bvGridView1Column3: TcxGridBandedColumn;
    bvGridView1Column4: TcxGridBandedColumn;
    bvGridView1Column5: TcxGridBandedColumn;
    bvGridView1Column6: TcxGridBandedColumn;
    bvGridView1Column7: TcxGridBandedColumn;
    bvGridView1Column8: TcxGridBandedColumn;
    bvGridView1Column9: TcxGridBandedColumn;
    bvGridView1Column10: TcxGridBandedColumn;
    bvGridView1Column11: TcxGridBandedColumn;
    bvGridView1Column12: TcxGridBandedColumn;
    bvGridView1Column13: TcxGridBandedColumn;
    bvGridView1Column14: TcxGridBandedColumn;
    bvGridView1Column15: TcxGridBandedColumn;
    bvGridView1Column16: TcxGridBandedColumn;
    bvGridView1Column17: TcxGridBandedColumn;
    bvGridView1Column18: TcxGridBandedColumn;
    bvGridView1Column19: TcxGridBandedColumn;
    bvGridView1Column20: TcxGridBandedColumn;
    bvGridView1Column21: TcxGridBandedColumn;
    bvGridView1Column22: TcxGridBandedColumn;
    bvGridView1Column23: TcxGridBandedColumn;
    bvGridView1Rate: TcxGridBandedColumn;
    cxGridLevel3: TcxGridLevel;
    cxGridLevel4: TcxGridLevel;
    cxGrid3: TcxGrid;
    CancelGridView: TcxGridTableView;
    CancelGridViewMenuCode: TcxGridColumn;
    CancelGridViewMenuName: TcxGridColumn;
    CancelGridViewQty: TcxGridColumn;
    CancelGridViewOrderTime: TcxGridColumn;
    CancelGridViewCancelTime: TcxGridColumn;
    CancelGridViewUseTable: TcxGridColumn;
    CancelGridViewWhy: TcxGridColumn;
    CancelGridViewPosNo: TcxGridColumn;
    cxGridLevel5: TcxGridLevel;
    CloseButton: TcxButton;
    TitleLabel: TLabel;
    StyleFooter: TcxStyle;
    SunLabel: TcxLabel;
    MonLabel: TcxLabel;
    TueLabel: TcxLabel;
    WedLabel: TcxLabel;
    ThuLabel: TcxLabel;
    FriLabel: TcxLabel;
    SatLabel: TcxLabel;
    SumLabel: TcxLabel;
    StyleLevel: TcxStyle;
    MonthTabSheet: TAdvTabSheet;
    MonthGrid: TcxGrid;
    MonthGridView: TcxGridTableView;
    MonthGridViewMonth: TcxGridColumn;
    MonthGridViewTotAmt: TcxGridColumn;
    MonthGridViewDcAmt: TcxGridColumn;
    MonthGridViewServiceAmt: TcxGridColumn;
    MonthGridViewSaleAmt: TcxGridColumn;
    MonthGridViewVatAmt: TcxGridColumn;
    MonthGridViewNetAmt: TcxGridColumn;
    MonthGridViewDutyFreeAmt: TcxGridColumn;
    MonthGridLevel: TcxGridLevel;
    YearCompareTabSheet: TAdvTabSheet;
    YearGrid: TcxGrid;
    YearGridView: TcxGridTableView;
    YearGridViewColumn1: TcxGridColumn;
    YearGridViewColumn2: TcxGridColumn;
    YearGridViewColumn3: TcxGridColumn;
    YearGridViewColumn4: TcxGridColumn;
    YearGridViewColumn5: TcxGridColumn;
    YearGridViewColumn6: TcxGridColumn;
    YearGridViewColumn7: TcxGridColumn;
    YearGridViewColumn8: TcxGridColumn;
    YearGridViewColumn9: TcxGridColumn;
    YearGridViewColumn10: TcxGridColumn;
    YearGridViewColumn11: TcxGridColumn;
    YearGridViewColumn12: TcxGridColumn;
    YearGridViewColumn13: TcxGridColumn;
    YearGridViewColumn14: TcxGridColumn;
    YearGridLevel: TcxGridLevel;
    YearPanel: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ReportPagerChange(Sender: TObject);
    procedure SearchDateEditPropertiesChange(Sender: TObject);
  private
    vWeek      :Integer;
    PayChart,
    ClassChart,
    MenuChart,
    YearChart: TWebBrowser;
    isLoading : Boolean;

    DateButton: array[0..6] of array[0..7] of TPosButton;
    WeekCount : Integer;
    SaleName  : String;

    procedure SetCalender;
    procedure ShowText;
    procedure ClearEdit;
    procedure ShowChart(aWebBrowser:TWebBrowser; aChartName, aChartType, aChartData :String);
  public
    PayList :TStringList;
  end;

var
  SaleReport_F: TSaleReport_F;

implementation
uses Common_U, GlobalFunc_U, DateUtils, DBModule_U, Const_U;
{$R *.dfm}

procedure TSaleReport_F.FormCreate(Sender: TObject);
var
  vRow, vCol: Integer;
begin
  Common.LogoCreate(Self,1);

  Width  := 1024;
  Height := 768;

  // 차트를 만든다
  PayChart       := TWebBrowser.Create(Self);
  TWinControl(PayChart).Parent := PayPanel;
  PayChart.Align := alClient;

  // 차트를 만든다
  ClassChart       := TWebBrowser.Create(Self);
  TWinControl(ClassChart).Parent := ClassPanel;
  ClassChart.Align := alClient;

  // 차트를 만든다
  MenuChart       := TWebBrowser.Create(Self);
  TWinControl(MenuChart).Parent := MenuPanel;
  MenuChart.Align := alClient;

  YearChart       := TWebBrowser.Create(Self);
  TWinControl(YearChart).Parent := YearPanel;
  YearChart.Align := alClient;

  PayList := TStringList.Create;

  if Common.Config.IsTakeOut then
  begin
    cxTextEdit6.Text := '매출금액';
    cxTextEdit7.Text := '고 객 수';
    cxTextEdit8.Text := '객 단 가';
  end;

  // 날짜 버튼을 만든다
  for vRow := Low(DateButton) to High(DateButton) do
    for vCol := Low(DateButton[vRow]) to High(DateButton[vRow]) do
    begin
      DateButton[vRow, vCol] := TPosButton.Create(self);
      DateButton[vRow, vCol].Parent             := CalenderTab;
      DateButton[vRow, vCol].Number.Font.Name   := '맑은 고딕';
      DateButton[vRow, vCol].Number.Font.Size   := 10;
      DateButton[vRow, vCol].Number.Font.Style  := [fsBold];
      DateButton[vRow, vCol].Menu.Font.Name     := '맑은 고딕';
      DateButton[vRow, vCol].Menu.Font.Size     := 11;
      DateButton[vRow, vCol].Amount.Font.Size   := 1;
      DateButton[vRow, vCol].Color              := IfThen((vCol = 7) and (vRow = 6), $00FFD277, IfThen((vCol = 7) or (vRow = 6), $00FFE7B3, clWhite));
      DateButton[vRow, vCol].Bottom.Font.Name   := '맑은 고딕';
      DateButton[vRow, vCol].Bottom.Font.Size   := 9;
      DateButton[vRow, vCol].BorderColor        := clBlack;
      DateButton[vRow, vCol].BorderStyle        := pbsSingle;
    end;

  WeekCount := High(DateButton)+1;

  txtBefMonth.Text := Format('전월(%s)',[FormatDateTime('yyyy-mm-dd',IncMonth(SearchDateEdit.Date, -1))]);
  txtBefWeek.Text  := Format('전주(%s)',[FormatDateTime('yyyy-mm-dd',IncWeek(SearchDateEdit.Date, -1))]);
  txtBefDay.Text   := Format('전일(%s)',[FormatDateTime('yyyy-mm-dd',IncDay(SearchDateEdit.Date, -1))]);
  txtNow.Text      := Format('금일(%s)',[FormatDateTime('yyyy-mm-dd',SearchDateEdit.Date)]);

  txtWeek1.Text    := FormatDateTime('mm-dd',IncDay(SearchDateEdit.Date, -6))+DayToWeek(DtoS(IncDay(SearchDateEdit.Date, -6)));
  txtWeek2.Text    := FormatDateTime('mm-dd',IncDay(SearchDateEdit.Date, -5))+DayToWeek(DtoS(IncDay(SearchDateEdit.Date, -5)));
  txtWeek3.Text    := FormatDateTime('mm-dd',IncDay(SearchDateEdit.Date, -4))+DayToWeek(DtoS(IncDay(SearchDateEdit.Date, -4)));
  txtWeek4.Text    := FormatDateTime('mm-dd',IncDay(SearchDateEdit.Date, -3))+DayToWeek(DtoS(IncDay(SearchDateEdit.Date, -3)));
  txtWeek5.Text    := FormatDateTime('mm-dd',IncDay(SearchDateEdit.Date, -2))+DayToWeek(DtoS(IncDay(SearchDateEdit.Date, -2)));
  txtWeek6.Text    := FormatDateTime('mm-dd',IncDay(SearchDateEdit.Date, -1))+DayToWeek(DtoS(IncDay(SearchDateEdit.Date, -1)));
  txtWeek7.Text    := FormatDateTime('mm-dd',SearchDateEdit.Date)+DayToWeek(DtoS(SearchDateEdit.Date));


  if GetOption(389) = '1' then
    SaleName := '외상'
  else
    SaleName := '현영';
end;

procedure TSaleReport_F.FormDestroy(Sender: TObject);
begin
  PayChart.Free;
  ClassChart.Free;
  MenuChart.Free;
  YearChart.Free;
end;

procedure TSaleReport_F.ClearEdit;
var I :Integer;
begin
  for I := 0 to ComponentCount-1 do
     if Components[I] is TcxCurrencyEdit then TcxCurrencyEdit(Components[I]).Value := 0;
end;

procedure TSaleReport_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TSaleReport_F.ReportPagerChange(Sender: TObject);
begin
  ClearEdit;
  PrintButton.Visible := False;
  case ReportPager.ActivePageIndex of
    0 :
      begin
        txtBefMonth.Text := Format('전월(%s)',[FormatDateTime('yyyy-mm-dd',IncMonth(SearchDateEdit.Date, -1))]);
        txtBefWeek.Text  := Format('전주(%s)',[FormatDateTime('yyyy-mm-dd',IncWeek(SearchDateEdit.Date, -1))]);
        txtBefDay.Text   := Format('전일(%s)',[FormatDateTime('yyyy-mm-dd',IncDay(SearchDateEdit.Date, -1))]);
        txtNow.Text      := Format('금일(%s)',[FormatDateTime('yyyy-mm-dd',SearchDateEdit.Date)]);

        txtWeek1.Text    := FormatDateTime('mm-dd',IncDay(SearchDateEdit.Date, -6))+DayToWeek(DtoS(IncDay(SearchDateEdit.Date, -6)));
        txtWeek2.Text    := FormatDateTime('mm-dd',IncDay(SearchDateEdit.Date, -5))+DayToWeek(DtoS(IncDay(SearchDateEdit.Date, -5)));
        txtWeek3.Text    := FormatDateTime('mm-dd',IncDay(SearchDateEdit.Date, -4))+DayToWeek(DtoS(IncDay(SearchDateEdit.Date, -4)));
        txtWeek4.Text    := FormatDateTime('mm-dd',IncDay(SearchDateEdit.Date, -3))+DayToWeek(DtoS(IncDay(SearchDateEdit.Date, -3)));
        txtWeek5.Text    := FormatDateTime('mm-dd',IncDay(SearchDateEdit.Date, -2))+DayToWeek(DtoS(IncDay(SearchDateEdit.Date, -2)));
        txtWeek6.Text    := FormatDateTime('mm-dd',IncDay(SearchDateEdit.Date, -1))+DayToWeek(DtoS(IncDay(SearchDateEdit.Date, -1)));
        txtWeek7.Text    := FormatDateTime('mm-dd',SearchDateEdit.Date)+DayToWeek(DtoS(SearchDateEdit.Date));
        PrintButton.Visible := True;
      end;
    1,4,5,6 : PrintButton.Visible := True;
  end;
  if isLoading then Exit;
  SearchButtonClick(nil);

end;

procedure TSaleReport_F.SearchButtonClick(Sender: TObject);
var I              :Integer;
    TotWeek        : Double;
    vPosButton     : TPosButton;
    vName          : String;
    PosList        : TStringList;
    TotCol, bnd, col : Integer;
    PosNo          : String;
    vIndex         : Integer;
    vChart01,
    vChart02,
    vChart03,
    vChartXml      : String;
    vBefStockSql,
    vStockSql    :String;
    vSql :String;
    vCol1, vCol2 : Integer;

    vCol, vRow :Integer;
    vMaxSaleAmt, vMinSaleAmt: Currency;
    vButton, vMaxButton, vMinButton: TPosButton;
begin
  case ReportPager.ActivePageIndex of
    0 :
    begin
      OpenQuery('select a.YMD_SALE, '
               +'       Sum(a.AMT_SALE) as AMT_SALE, '
               +'       Sum(a.AMT_TAX) as AMT_TAX, '
               +'       Sum(case when Ifnull(b.YN_PACKING,''N'')=''Y'' or Ifnull(a.NO_DELIVERY,'''') <> '''' then a.AMT_SALE else 0 end) as AMT_DELIVERY,  '
               +'       Sum(a.AMT_DUTY+AMT_TAX-a.AMT_DUTYFREE) as AMT_DUTY, '
               +'       Sum(a.AMT_DUTYFREE) as AMT_DUTYFREE, '
               +'       Sum(a.CNT_PERSON) as SALE_CNT, '
               +'       case when Sum(a.CNT_PERSON) = 0 then Sum(a.AMT_SALE) else DivInt(Sum(a.AMT_SALE),Sum(a.CNT_PERSON)) end as AMT_AVG, '
               +'       Sum(a.AMT_SALE+a.DC_TOT+a.AMT_SERVICE) as AMT_TOT, '
               +'       Sum(a.DC_TOT) as AMT_DC, '
               +'       Sum(a.AMT_SERVICE) as AMT_SERVICE '
               +'  from SL_SALE_H as a left outer join '
               +'       MS_TABLE  as b on b.CD_STORE = a.CD_STORE '
               +'                     and b.NO_TABLE = a.NO_TABLE '
               +'                     and b.NO_TABLE > 0 '
               +' where a.CD_STORE =:P0 '
               +'   and a.YMD_SALE in (:P1, :P2, :P3, :P4) '
               +'   and a.DS_SALE <> ''V'' '
               +' group by a.YMD_SALE ',
               [Common.Config.StoreCode,
                DtoS(IncMonth(SearchDateEdit.Date, -1)),
                DtoS(IncWeek(SearchDateEdit.Date,  -1)),
                DtoS(IncDay(SearchDateEdit.Date,   -1)),
                DtoS(SearchDateEdit.Date)]);

        while not Common.Query.Eof do
        begin
          if Common.Query.FieldByName('YMD_SALE').AsString = DtoS(IncMonth(SearchDateEdit.Date, -1)) then
          begin
            edtBefMonth1.Value := Common.Query.Fields[1].AsInteger;
            edtBefMonth2.Value := Common.Query.Fields[2].AsInteger;
            edtBefMonth3.Value := Common.Query.Fields[3].AsInteger;
            edtBefMonth4.Value := Common.Query.Fields[4].AsInteger;
            edtBefMonth5.Value := Common.Query.Fields[5].AsInteger;
            edtBefMonth6.Value := Common.Query.Fields[6].AsInteger;
            edtBefMonth7.Value := Common.Query.Fields[7].AsInteger;
            edtBefMonth8.Value := Common.Query.Fields[8].AsInteger;
            edtBefMonth9.Value := Common.Query.Fields[9].AsInteger;
            edtBefMonth10.Value := Common.Query.Fields[10].AsInteger;
          end
          else if Common.Query.FieldByName('YMD_SALE').AsString = DtoS(IncWeek(SearchDateEdit.Date, -1)) then
          begin
            edtBefWeek1.Value := Common.Query.Fields[1].AsInteger;
            edtBefWeek2.Value := Common.Query.Fields[2].AsInteger;
            edtBefWeek3.Value := Common.Query.Fields[3].AsInteger;
            edtBefWeek4.Value := Common.Query.Fields[4].AsInteger;
            edtBefWeek5.Value := Common.Query.Fields[5].AsInteger;
            edtBefWeek6.Value := Common.Query.Fields[6].AsInteger;
            edtBefWeek7.Value := Common.Query.Fields[7].AsInteger;
            edtBefWeek8.Value := Common.Query.Fields[8].AsInteger;
            edtBefWeek9.Value := Common.Query.Fields[9].AsInteger;
            edtBefWeek10.Value := Common.Query.Fields[10].AsInteger;
          end
          else if Common.Query.FieldByName('YMD_SALE').AsString = DtoS(IncDay(SearchDateEdit.Date, -1)) then
          begin
            edtBefDay1.Value := Common.Query.Fields[1].AsInteger;
            edtBefDay2.Value := Common.Query.Fields[2].AsInteger;
            edtBefDay3.Value := Common.Query.Fields[3].AsInteger;
            edtBefDay4.Value := Common.Query.Fields[4].AsInteger;
            edtBefDay5.Value := Common.Query.Fields[5].AsInteger;
            edtBefDay6.Value := Common.Query.Fields[6].AsInteger;
            edtBefDay7.Value := Common.Query.Fields[7].AsInteger;
            edtBefDay8.Value := Common.Query.Fields[8].AsInteger;
            edtBefDay9.Value := Common.Query.Fields[9].AsInteger;
            edtBefDay10.Value := Common.Query.Fields[10].AsInteger;
          end
          else if Common.Query.FieldByName('YMD_SALE').AsString = DtoS(SearchDateEdit.Date) then
          begin
            edtNow1.Value := Common.Query.Fields[1].AsInteger;
            edtNow2.Value := Common.Query.Fields[2].AsInteger;
            edtNow3.Value := Common.Query.Fields[3].AsInteger;
            edtNow4.Value := Common.Query.Fields[4].AsInteger;
            edtNow5.Value := Common.Query.Fields[5].AsInteger;
            edtNow6.Value := Common.Query.Fields[6].AsInteger;
            edtNow7.Value := Common.Query.Fields[7].AsInteger;
            edtNow8.Value := Common.Query.Fields[8].AsInteger;
            edtNow9.Value := Common.Query.Fields[9].AsInteger;
            edtNow10.Value := Common.Query.Fields[10].AsInteger;
          end;
          Common.Query.Next;
        end;

        Common.Query.Close;
        OpenQuery('select YMD_SALE, '
                 +'       Sum(AMT_SALE) as AMT_SALE '
                 +'  from SL_SALE_H '
                 +' where CD_STORE =:p0 '
                 +'   and YMD_SALE in (:P1, :P2, :P3, :P4, :P5, :P6, :P7) '
                 +'   and DS_SALE <> ''V'' '
                 +' group by YMD_SALE '
                 +' order by YMD_SALE ',
                 [Common.Config.StoreCode,
                  DtoS(IncDay(SearchDateEdit.Date, -6)),
                  DtoS(IncDay(SearchDateEdit.Date, -5)),
                  DtoS(IncDay(SearchDateEdit.Date, -4)),
                  DtoS(IncDay(SearchDateEdit.Date, -3)),
                  DtoS(IncDay(SearchDateEdit.Date, -2)),
                  DtoS(IncDay(SearchDateEdit.Date, -1)),
                  DtoS(SearchDateEdit.Date)]);

        while not Common.Query.Eof do
        begin
          if Common.Query.FieldByName('YMD_SALE').AsString = DtoS(IncDay(SearchDateEdit.Date, -6)) then
          begin
            edtWeek1.Value := Common.Query.Fields[1].AsInteger;
          end
          else if Common.Query.FieldByName('YMD_SALE').AsString = DtoS(IncDay(SearchDateEdit.Date, -5)) then
          begin
            edtWeek2.Value := Common.Query.Fields[1].AsInteger;
          end
          else if Common.Query.FieldByName('YMD_SALE').AsString = DtoS(IncDay(SearchDateEdit.Date, -4)) then
          begin
            edtWeek3.Value := Common.Query.Fields[1].AsInteger;
          end
          else if Common.Query.FieldByName('YMD_SALE').AsString = DtoS(IncDay(SearchDateEdit.Date, -3)) then
          begin
            edtWeek4.Value := Common.Query.Fields[1].AsInteger;
          end
          else if Common.Query.FieldByName('YMD_SALE').AsString = DtoS(IncDay(SearchDateEdit.Date, -2)) then
          begin
            edtWeek5.Value := Common.Query.Fields[1].AsInteger;
          end
          else if Common.Query.FieldByName('YMD_SALE').AsString = DtoS(IncDay(SearchDateEdit.Date, -1)) then
          begin
            edtWeek6.Value := Common.Query.Fields[1].AsInteger;
          end
          else if Common.Query.FieldByName('YMD_SALE').AsString = DtoS(SearchDateEdit.Date) then
          begin
            edtWeek7.Value := Common.Query.Fields[1].AsInteger;
          end;
          Common.Query.Next;
        end;

        // 요일별 매출
        TotWeek := edtWeek1.Value + edtWeek2.Value + edtWeek3.Value + edtWeek4.Value + edtWeek5.Value + edtWeek6.Value + edtWeek7.Value;
        TotWeek := Ifthen(TotWeek=0, 1, TotWeek);
        edtWeekPer1.Value := edtWeek1.Value / TotWeek * 100;
        edtWeekPer2.Value := edtWeek2.Value / TotWeek * 100;
        edtWeekPer3.Value := edtWeek3.Value / TotWeek * 100;
        edtWeekPer4.Value := edtWeek4.Value / TotWeek * 100;
        edtWeekPer5.Value := edtWeek5.Value / TotWeek * 100;
        edtWeekPer6.Value := edtWeek6.Value / TotWeek * 100;
        edtWeekPer7.Value := edtWeek7.Value / TotWeek * 100;

        OpenQuery('select t1.NAME, t1.AMOUNT '
                 +'  from ( '
                 +'      select ConCat(''현금'',''('',Cast(COUNT(*) as Char),'')'') as NAME, '
                 +'             SUM(AMT_CASH-AMT_CASHRCP) as AMOUNT '
                 +'        from SL_SALE_H '
                 +'       where DS_SALE <> ''V'' '
                 +'         and CD_STORE =:P0 '
                 +'         and YMD_SALE =:P1 '
                 +'         and (AMT_CASH-AMT_CASHRCP) <> 0 '
                 +'union all '
                 +'select ConCat(''현금영수증'',''('',Cast(COUNT(*) as Char),'')'') as NAME, '
                 +'       SUM(AMT_CASHRCP) as AMOUNT '
                 +'  from SL_SALE_H '
                 +' where DS_SALE <> ''V'' '
                 +'   and CD_STORE =:P0 '
                 +'   and YMD_SALE =:P1 '
                 +'   and AMT_CASHRCP <> 0 '
                 +'union all  '
                 +'select ConCat(''신용카드'',''('',Cast(COUNT(*) as Char),'')'') as NAME, '
                 +'       SUM(AMT_CARD) as AMOUNT '
                 +'  from SL_SALE_H '
                 +' where DS_SALE <> ''V'' '
                 +'   and CD_STORE =:P0 '
                 +'   and YMD_SALE =:P1 '
                 +'   and AMT_CARD <> 0 '
                 +'union all  '
                 +'select ConCat(''렛츠오더'',''('',Cast(COUNT(*) as Char),'')'') as NAME, '
                 +'       SUM(AMT_LETSORDER) as AMOUNT '
                 +'  from SL_SALE_H '
                 +' where DS_SALE <> ''V'' '
                 +'   and CD_STORE =:P0 '
                 +'   and YMD_SALE =:P1 '
                 +'   and AMT_LETSORDER <> 0 '
                 +'union all '
                 +'select ConCat(''상품권'',''('',Cast(COUNT(*) as Char),'')'') as NAME, '
                 +'       SUM(AMT_GIFT) as AMOUNT '
                 +'  from SL_SALE_H '
                 +' where DS_SALE <> ''V'' '
                 +'   and CD_STORE =:P0 '
                 +'   and YMD_SALE =:P1 '
                 +'   and AMT_GIFT <> 0 '
                 +'union all '
                 +'select ConCat(''외상'',''('',Cast(COUNT(*) as Char),'')'') as NAME, '
                 +'       SUM(AMT_TRUST) as AMOUNT '
                 +'  from SL_SALE_H '
                 +' where DS_SALE <> ''V'' '
                 +'   and CD_STORE =:P0 '
                 +'   and YMD_SALE =:P1 '
                 +'   and AMT_TRUST <> 0 '
                 +'union all '
                 +'select ConCat(''계좌입금'',''('',Cast(COUNT(*) as Char),'')'') as NAME, '
                 +'       SUM(AMT_BANK) as AMOUNT '
                 +'  from SL_SALE_H '
                 +' where DS_SALE <> ''V'' '
                 +'   and CD_STORE =:P0 '
                 +'   and YMD_SALE =:P1 '
                 +'   and AMT_BANK <> 0 '
                 +'union all '
                 +'select ConCat(''기타금액'',''('',Cast(COUNT(*) as Char),'')'') as NAME, '
                 +'       SUM(AMT_ETC) as AMOUNT '
                 +'  from SL_SALE_H '
                 +' where DS_SALE <> ''V'' '
                 +'   and CD_STORE =:P0 '
                 +'   and YMD_SALE =:P1 '
                 +'   and AMT_ETC <> 0 '
                 +'union all '
                 +'select ConCat(''포인트'',''('',Cast(COUNT(*) as Char),'')'') as NAME, '
                 +'       SUM(AMT_POINT) as AMOUNT '
                 +'  from SL_SALE_H '
                 +' where DS_SALE <> ''V'' '
                 +'   and CD_STORE =:P0 '
                 +'   and YMD_SALE =:P1 '
                 +'   and AMT_POINT <> 0 '
                 +') t1 '
                 +'where t1.AMOUNT > 0 ',
                 [Common.Config.StoreCode,
                  DtoS(SearchDateEdit.Date)]);


        // 챠트로 표시
        vChartXml := '<chart caption=''거래종별 매출'' formatNumberScale=''0'' decimalPrecision=''0'' palettecolors=''FF0000, 008ED6, F6BD0F, 588526, 008E8E, 8BBA00, A186BE, AFD8F8, FF8E46, D64646, 8E468E, B3AA00'' '
                      +'basefont=''맑은 고딕'' captionfontsize=''14'' subcaptionfontsize=''14'' subcaptionfontbold=''0'' placevaluesinside=''1'' rotatevalues=''1'' '
                      +'showshadow=''0'' divlinecolor=''#999999'' divlinedashed=''1'' divlinethickness=''1'' divlinedashlen=''1'' divlinegaplen=''1'' canvasbgcolor=''#ffffff''>';

        PayList.Clear;
        while not Common.Query.Eof do
        begin
          vChartXml := vChartXml + '<set label="'+Common.Query.Fields[0].AsString+'" value="'+Common.Query.Fields[1].AsString+'" />';
          if Common.Config.PrintColum = 1 then
            PayList.Add(Space(9)+RPadB(Common.Query.Fields[0].AsString,20,' ') + LPadB(FormatFloat('#,0', Common.Query.Fields[1].AsInteger),17,' '))
          else
            PayList.Add(Space(3)+RPadB(Common.Query.Fields[0].AsString,20,' ') + LPadB(FormatFloat('#,0', Common.Query.Fields[1].AsInteger),17,' '));
          Common.Query.Next;
        end;
        vChartXml := vChartXml + '</chart>';
        ShowChart(PayChart, 'PayChart', 'pie3d', vChartXml);


        // 챠트로 표시(푸드코트가아니면 분류별)
        if (GetOption(231) = '0') then
        begin
          vChartXml := '<chart caption=''분류별 매출'' formatNumberScale=''0'' decimalPrecision=''0'' palettecolors=''FF0000, 008ED6, F6BD0F, 588526, 008E8E, 8BBA00, A186BE, AFD8F8, FF8E46, D64646, 8E468E, B3AA00'' '
                        +'basefont=''맑은 고딕'' captionfontsize=''14'' subcaptionfontsize=''14'' subcaptionfontbold=''0'' placevaluesinside=''1'' rotatevalues=''1'' '
                        +'showshadow=''0'' divlinecolor=''#999999'' divlinedashed=''1'' divlinethickness=''1'' divlinedashlen=''1'' divlinegaplen=''1'' canvasbgcolor=''#ffffff''>';

          OpenQuery('select b.NM_CLASS, '
                   +'       Sum(a.AMT_SALE) AMT_SALE '
                   +'  from	( '
                   +'        select Left(b.CD_CLASS,2) as CD_CLASS, '
                   +'               Sum(a.AMT_SALE-a.DC_TOT) as AMT_SALE '
                   +'          from SL_SALE_D a left outer join '
                   +'               MS_MENU   b on b.CD_STORE = a.CD_STORE '
                   +'                          and b.CD_MENU  = a.CD_MENU '
                   +'         where a.CD_STORE =:P0 '
                   +'           and a.YMD_SALE =:P1 '
                   +'           and a.DS_SALE <> ''V'' '
                   +'         group by Left(b.CD_CLASS,2) '
                   +'       ) a left outer join '
                   +'       MS_MENU_CLASS b on b.CD_STORE =:P0 and Left(b.CD_CLASS,2) = a.CD_CLASS and Length(b.CD_CLASS) = 2 '
                   +'  group by b.NM_CLASS ',
                   [Common.Config.StoreCode,
                    DtoS(SearchDateEdit.Date)]);

        end
        else
        begin
          vChartXml := '<chart caption=''코너별 매출'' formatNumberScale=''0'' decimalPrecision=''0'' palettecolors=''FF0000, 008ED6, F6BD0F, 588526, 008E8E, 8BBA00, A186BE, AFD8F8, FF8E46, D64646, 8E468E, B3AA00'' '
                        +'basefont=''맑은 고딕'' captionfontsize=''14'' subcaptionfontsize=''14'' subcaptionfontbold=''0'' placevaluesinside=''1'' rotatevalues=''1'' '
                        +'showshadow=''0'' divlinecolor=''#999999'' divlinedashed=''1'' divlinethickness=''1'' divlinedashlen=''1'' divlinegaplen=''1'' canvasbgcolor=''#ffffff''>';
          OpenQuery('select Max(c.NM_TRDPL) as NM_CORNER, '
                   +'       Sum(s.AMT_SALE) as AMT_SALE, '
                   +'       c.CD_TRDPL '
                   +'  from (select CD_TRDPL, '
                   +'             NM_TRDPL '
                   +'        from MS_TRD '
                   +'       where CD_STORE =:P0 '
                   +'         and DS_TRDPL =''C'' '
                   +'       union all '
                   +'       select ''''          as CD_TRDPL, '
                   +'             ''코너미지정'' as NM_TRDPL ) as c left outer join '
                   +'       (select ifnull(g.CD_CORNER, '''') as CD_CORNER, '
                   +'             Sum(d.AMT_SALE - d.DC_TOT) as AMT_SALE '
                   +'        from SL_SALE_D      as d left outer join '
                   +'             MS_MENU        as g on d.CD_STORE = g.CD_STORE and d.CD_MENU = g.CD_MENU  '
                   +'       where d.CD_STORE =:P0 '
                   +'         and d.YMD_SALE =:P1 '
                   +'         and d.DS_SALE <> ''V'' '
                   +'       group by g.CD_CORNER) s on c.CD_TRDPL = s.CD_CORNER '
                   +' group by c.CD_TRDPL '
                   +'order by c.CD_TRDPL ',
                   [Common.Config.StoreCode,
                    DtoS(SearchDateEdit.Date)]);
        end;
        while not Common.Query.Eof do
        begin
          vChartXml := vChartXml + '<set label="'+Common.Query.Fields[0].AsString+'" value="'+Common.Query.Fields[1].AsString+'" />';
          Common.Query.Next;
        end;
        Common.Query.Close;
        vChartXml := vChartXml + '</chart>';
        ShowChart(ClassChart, 'ClassChart', 'column3d', vChartXml);

        //테이블 주문 현황
        if not Common.Config.IsTakeOut then
        begin
          OpenQuery('select a.CNT_TABLE, '
                   +'       b.USE_TABLE, '
                   +'       b.AMT_ORDER, '
                   +'       b.CNT_PERSON '
                   +'  from (select COUNT(NO_TABLE) as CNT_TABLE '
                   +'	         from MS_TABLE a '
                   +'	        where CD_STORE = :P0 '
                   +'	          and SEQ      = 0 '
                   +'       ) a, '
                   +'	     (select sum(case DS_ORDER WHEN ''T'' then 1 when ''D'' then 0 end) as USE_TABLE, '
                   +'		           ifnull(sum(CNT_PERSON), 0) as CNT_PERSON, '
                   +'	           	 ifnull(sum(AMT_ORDER), 0)  as AMT_ORDER '
                   +'	        from SL_ORDER_H '
                   +'        where CD_STORE = :p0 '
                   +'	      ) b ',
                   [Common.Config.StoreCode]);

          edtOrderAmt.Value := Common.Query.FieldByName('amt_order').Value;
          //조회일자가 개점일자와 같으면 총금액에 주문금액을 합한다
          edtTotalAmt.Value := edtNow1.Value + Ifthen(DtoS(SearchDateEdit.Date) = Common.WorkDate, edtOrderAmt.Value, 0);
          edtTable.Text     := Common.Query.FieldByName('use_table').AsString +' / '+ Common.Query.FieldByName('cnt_table').AsString+' ('+Common.Query.FieldByName('cnt_person').AsString+')';
        end
        else
        begin
          edtOrderAmt.Text  := edtNow1.Text;
          edtTotalAmt.Text  := edtNow6.Text;
          edtTable.Text     := edtNow7.Text;
        end;
        Common.Query.Close;
    end;
    1 : // 메뉴별 매출
    begin
        OpenQuery('select a.CD_MENU, '
                 +'       Max(b.NM_MENU) as NM_MENU, '
                 +'       GetQty(b.DS_MENU_TYPE, SUM(a.QTY_SALE) ) as QTY_SALE, '
                 +'       SUM(a.AMT_SALE) as AMT_TOT, '
                 +'       SUM(Ifnull(a.DC_TOT,0)) as AMT_DC, '
                 +'       SUM(a.AMT_SALE)-Sum(Ifnull(a.DC_TOT,0)) as AMT_SALE, '
                 +'       SUM(a.AMT_VAT) as AMT_VAT, '
                 +'       SUM(a.AMT_SALE)-Sum(a.AMT_VAT)-Sum(Ifnull(a.DC_TOT,0)) as AMT_SOON '
                 +'  from SL_SALE_D a inner join '
                 +'       MS_MENU   b on b.CD_STORE = a.CD_STORE and b.CD_MENU = a.CD_MENU '
                 +' where a.CD_STORE = :P0 '
                 +'   and a.YMD_SALE = :P1 '
                 +'   and a.DS_SALE <> ''V'' '
                 +' group by a.CD_MENU, b.DS_MENU_TYPE '
                 +' order by a.CD_MENU ',
                 [Common.Config.StoreCode,
                  DtoS(SearchDateEdit.Date)]);
        DM.ReadQuery(Common.Query, MenuGridView);


        OpenQuery('select ConCat(c.NM_MENU_SHORT, ''('',GetQty(c.DS_MENU_TYPE, Sum(a.QTY_SALE) ) ,'')''), '
                 +'	      Sum(ifnull(a.AMT_SALE,0)) as AMT_SALE '
                 +'  from SL_SALE_D a inner join '
                 +'       SL_SALE_H b on a.CD_STORE = b.CD_STORE '
                 +'                  and a.YMD_SALE = b.YMD_SALE '
                 +'                  and a.NO_POS   = b.NO_POS '
                 +'                  and a.NO_RCP   = b.NO_RCP '
                 +'                  and b.DS_SALE <> ''V'' inner join '
                 +'       MS_MENU   c on a.CD_STORE = c.CD_STORE '
                 +'                  and a.CD_MENU  = c.CD_MENU '
                 +' where a.CD_STORE = :P0 '
                 +'   and a.YMD_SALE = :P1 '
                 +' group by c.NM_MENU_SHORT, c.DS_MENU_TYPE '
                 +' order by Sum(a.AMT_SALE) DESC '
                 +' limit 30 ',
                 [Common.Config.StoreCode,
                  DtoS(SearchDateEdit.Date)]);

        // 챠트로 표시
        vChartXml := '<chart caption=''메뉴별 매출'' formatNumberScale=''0'' decimalPrecision=''0'' palettecolors=''FF0000, 008ED6, F6BD0F, 588526, 008E8E, 8BBA00, A186BE, AFD8F8, FF8E46, D64646, 8E468E, B3AA00'' '
                      +'basefont=''맑은 고딕'' captionfontsize=''14'' subcaptionfontsize=''14'' subcaptionfontbold=''0'' placevaluesinside=''1'' rotatevalues=''1'' '
                      +'showshadow=''0'' divlinecolor=''#999999'' divlinedashed=''1'' divlinethickness=''1'' divlinedashlen=''1'' divlinegaplen=''1'' canvasbgcolor=''#ffffff''>';
        while not Common.Query.Eof do
        begin
          vChartXml := vChartXml + '<set name="'+Replace(Common.Query.Fields[0].AsString,'"','')+'" value="'+Common.Query.Fields[1].AsString+'" />';
          Common.Query.Next;
        end;
        Common.Query.Close;
        vChartXml := vChartXml + '</chart>';
        ShowChart(MenuChart, 'MenuChart', 'column3d', vChartXml);
    end;
    2 : //카렌더매출
    begin
       SetCalender;

       OpenQuery('select a.YMD_SALE, '
                +'       a.DAY, '
                +'       a.CNT_PERSON, '
                +'       a.AMT_SALE, '
                +'       a.AMT_CASH, '
                +'       a.AMT_CARD, '
                +Ifthen(GetHeadOption(9)='1',' a.AMT_LETSORDER, ',' a.AMT_CASHRCP, ')
                +'       ifnull(b.AMT_ACCT,0) as AMT_ACCT  '
                +'  from (select YMD_SALE, '
                +'               SUBSTRING(YMD_SALE,7,2) as DAY, '
                +'               SUM(cnt_person) as CNT_PERSON, '
                +'               ifnull(SUM(AMT_SALE),0) as AMT_SALE, '
                +'               ifnull(SUM(AMT_CASH+AMT_CHECK+AMT_BANK),0) as AMT_CASH, '
                +'               ifnull(SUM(AMT_CARD),0) as AMT_CARD, '
                +'               ifnull(SUM(AMT_LETSORDER),0) as AMT_LETSORDER '
                +'          from SL_SALE_H '
                +'         where CD_STORE = :P0 '
                +'           and DS_SALE <> ''V'' '
                +'           and YMD_SALE between :P1 and :P2 '
                +'        group by YMD_SALE ) as a left outer join '
                +'       (select YMD_OCCUR, '
                +'               ifnull(SUM(AMT_PAYIN-AMT_OUT),0) as AMT_ACCT '
                +'          from SL_ACCT '
                +'         where CD_STORE =:P0 '
                +'           and DS_ACCT = ''0'' '
                +'           and YMD_OCCUR between :P1 and :P2 '
                +'         group by YMD_OCCUR '
                +'       ) b on a.YMD_SALE = b.YMD_OCCUR '
                +'order by 1 ',
                [Common.Config.StoreCode,
                 Copy(DtoS(IncMonth(SearchDateEdit.Date,-1)),1,6)+'23',
                 Copy(DtoS(IncMonth(SearchDateEdit.Date   )),1,6)+'06']);

       vMaxSaleAmt := 0;
       vMinSaleAmt := 0;
       vMaxButton  := nil;
       vMinButton  := nil;


       while not Common.Query.Eof do
       begin
          // 날짜에 해당하는 버튼을 찾는다
          vButton := nil;
          for vRow := Low(DateButton) to High(DateButton)-1 do
            for vCol := Low(DateButton[vRow]) to High(DateButton[vRow])-1 do
              if DateButton[vRow, vCol].Hint = Common.Query.Fields[0].AsString then
              begin
                vButton := DateButton[vRow, vCol];
                vButton.Temp8 := vButton.Hint;
                break;
              end;
          if vButton <> nil then
          begin

            // 최대 최소 매출 날짜를 구한다
            if vMaxSaleAmt < Common.Query.Fields[3].AsCurrency then
            begin
              vMaxSaleAmt := Common.Query.Fields[3].AsCurrency;
              vMaxButton  := vButton;
            end;
            if vMinSaleAmt > Common.Query.Fields[3].AsCurrency then
            begin
              vMinSaleAmt := Common.Query.Fields[3].AsCurrency;
              vMinButton  := vButton;
            end;

            // 각 날짜별 매출을 구한다
            vButton.Temp1 := Common.Query.Fields[2].AsString;
            vButton.Temp2 := Common.Query.Fields[3].AsString;
            vButton.Temp3 := Common.Query.Fields[4].AsString;
            vButton.Temp4 := Common.Query.Fields[5].AsString;
            vButton.Temp5 := Common.Query.Fields[6].AsString;
            vButton.Temp6 := Common.Query.Fields[7].AsString;
          end;
          Common.Query.Next;
       end;
       Common.Query.Close;


       // 주, 요일 합계를 구한다
       for vRow := Low(DateButton) to High(DateButton)-1 do
       begin
         DateButton[vRow, High(DateButton[vRow])].Temp1 := EmptyStr;
         DateButton[vRow, High(DateButton[vRow])].Temp2 := EmptyStr;
         DateButton[vRow, High(DateButton[vRow])].Temp3 := EmptyStr;
         DateButton[vRow, High(DateButton[vRow])].Temp4 := EmptyStr;
         DateButton[vRow, High(DateButton[vRow])].Temp5 := EmptyStr;
         DateButton[vRow, High(DateButton[vRow])].Temp6 := EmptyStr;
         DateButton[vRow, High(DateButton[vRow])].Temp7 := EmptyStr;
       end;

       for vCol := Low(DateButton[0]) to High(DateButton[0]) do
       begin
         DateButton[High(DateButton), vCol].Temp1       := EmptyStr;
         DateButton[High(DateButton), vCol].Temp2       := EmptyStr;
         DateButton[High(DateButton), vCol].Temp3       := EmptyStr;
         DateButton[High(DateButton), vCol].Temp4       := EmptyStr;
         DateButton[High(DateButton), vCol].Temp5       := EmptyStr;
         DateButton[High(DateButton), vCol].Temp6       := EmptyStr;
         DateButton[High(DateButton), vCol].Temp7       := EmptyStr;
       end;

       for vRow := Low(DateButton) to High(DateButton)-1 do
         for vCol := Low(DateButton[vRow]) to High(DateButton[vRow])-1 do
         begin
           if Copy(DtoS(SearchDateEdit.Date),1,6) = LeftStr(DateButton[vRow, vCol].Hint,6) then
           begin
             DateButton[vRow, High(DateButton[vRow])].Temp1 := FloatToStr(StoF(DateButton[vRow, High(DateButton[vRow])].Temp1) + StoF(DateButton[vRow, vCol].Temp1));
             DateButton[vRow, High(DateButton[vRow])].Temp2 := FloatToStr(StoF(DateButton[vRow, High(DateButton[vRow])].Temp2) + StoF(DateButton[vRow, vCol].Temp2));
             DateButton[vRow, High(DateButton[vRow])].Temp3 := FloatToStr(StoF(DateButton[vRow, High(DateButton[vRow])].Temp3) + StoF(DateButton[vRow, vCol].Temp3));
             DateButton[vRow, High(DateButton[vRow])].Temp4 := FloatToStr(StoF(DateButton[vRow, High(DateButton[vRow])].Temp4) + StoF(DateButton[vRow, vCol].Temp4));
             DateButton[vRow, High(DateButton[vRow])].Temp5 := FloatToStr(StoF(DateButton[vRow, High(DateButton[vRow])].Temp5) + StoF(DateButton[vRow, vCol].Temp5));
             DateButton[vRow, High(DateButton[vRow])].Temp6 := FloatToStr(StoF(DateButton[vRow, High(DateButton[vRow])].Temp6) + StoF(DateButton[vRow, vCol].Temp6));
             DateButton[vRow, High(DateButton[vRow])].Temp7 := FloatToStr(StoF(DateButton[vRow, High(DateButton[vRow])].Temp7) + Ifthen(DateButton[vRow, vCol].Temp2=EmptyStr,0,1) );

             DateButton[High(DateButton), vCol].Temp1       := FloatToStr(StoF(DateButton[High(DateButton), vCol].Temp1)       + StoF(DateButton[vRow, vCol].Temp1));
             DateButton[High(DateButton), vCol].Temp2       := FloatToStr(StoF(DateButton[High(DateButton), vCol].Temp2)       + StoF(DateButton[vRow, vCol].Temp2));
             DateButton[High(DateButton), vCol].Temp3       := FloatToStr(StoF(DateButton[High(DateButton), vCol].Temp3)       + StoF(DateButton[vRow, vCol].Temp3));
             DateButton[High(DateButton), vCol].Temp4       := FloatToStr(StoF(DateButton[High(DateButton), vCol].Temp4)       + StoF(DateButton[vRow, vCol].Temp4));
             DateButton[High(DateButton), vCol].Temp5       := FloatToStr(StoF(DateButton[High(DateButton), vCol].Temp5)       + StoF(DateButton[vRow, vCol].Temp5));
             DateButton[High(DateButton), vCol].Temp6       := FloatToStr(StoF(DateButton[High(DateButton), vCol].Temp6)       + StoF(DateButton[vRow, vCol].Temp6));
             DateButton[High(DateButton), vCol].Temp7       := FloatToStr(StoF(DateButton[High(DateButton), vCol].Temp7)       + Ifthen(DateButton[vRow, vCol].Temp2=EmptyStr,0,1) );
           end;
         end;

       for vCol := Low(DateButton[0]) to High(DateButton[0])-1 do
       begin
         DateButton[High(DateButton), High(DateButton[vRow])].Temp1 := FloatToStr(StoF(DateButton[High(DateButton), High(DateButton[vRow])].Temp1) + StoF(DateButton[High(DateButton), vCol].Temp1));
         DateButton[High(DateButton), High(DateButton[vRow])].Temp2 := FloatToStr(StoF(DateButton[High(DateButton), High(DateButton[vRow])].Temp2) + StoF(DateButton[High(DateButton), vCol].Temp2));
         DateButton[High(DateButton), High(DateButton[vRow])].Temp3 := FloatToStr(StoF(DateButton[High(DateButton), High(DateButton[vRow])].Temp3) + StoF(DateButton[High(DateButton), vCol].Temp3));
         DateButton[High(DateButton), High(DateButton[vRow])].Temp4 := FloatToStr(StoF(DateButton[High(DateButton), High(DateButton[vRow])].Temp4) + StoF(DateButton[High(DateButton), vCol].Temp4));
         DateButton[High(DateButton), High(DateButton[vRow])].Temp5 := FloatToStr(StoF(DateButton[High(DateButton), High(DateButton[vRow])].Temp5) + StoF(DateButton[High(DateButton), vCol].Temp5));
         DateButton[High(DateButton), High(DateButton[vRow])].Temp6 := FloatToStr(StoF(DateButton[High(DateButton), High(DateButton[vRow])].Temp6) + StoF(DateButton[High(DateButton), vCol].Temp6));
         DateButton[High(DateButton), High(DateButton[vRow])].Temp7 := FloatToStr(StoF(DateButton[High(DateButton), High(DateButton[vRow])].Temp7) + StoF(DateButton[High(DateButton), vCol].Temp7));
       end;

       ShowText;
    end;
    3 : //시간대별매출
    begin
      PosList := TStringList.Create;
      PosList.Clear;

      OpenQuery('select NM_CODE1, '
               +'       ConCat(NM_CODE4,''('',NM_CODE1,'')'') as NO_POS '
               +'  from MS_CODE '
               +' where CD_STORE =:P0 '
               +'   and CD_KIND  =''01'' '
               +'   and NM_CODE3 in (''0'',''2'',''7'') '
               +' order by CD_CODE ',
               [Common.Config.StoreCode]);

      //주문시간기준
      with bvGridView do
      begin
        for I := 1 to Bands.Count-1 do Bands.Items[I].Visible := False;

        bnd := 0;
        col := 0;
        while not Common.Query.eof do
        begin
          Inc(bnd);
          Bands.Items[bnd].Visible := True;
          Bands.Items[bnd].Caption := Common.Query.Fields[1].AsString;

          Inc(col);
          Columns[col].Visible     := true;
          Columns[col].Width       := 95;

          Inc(col);
          Columns[col].Visible     := true;
          Columns[col].Width       := 60;

          PosList.Add(Common.Query.Fields[0].AsString);
          Common.Query.Next;
        end;
        Inc(bnd);
        Bands.Items[bnd].Visible := True;
        Bands.Items[bnd].Caption := '합계';

        Inc(col);
        TotCol := Col;   //합계매출금액
        Columns[col].Visible                     := true;
        Inc(col);
        Columns[col].Visible                     := true;
        vCol1 := Col-1;

        bvGridViewRate.Position.BandIndex := bnd;
        bvGridViewRate.Index              := col+1;
      end;

      //퇴장시간기준
      with bvGridView1 do
      begin
        For I := 1 to Bands.Count-1 do Bands.Items[I].Visible := False;

        bnd := 0;
        col := 0;
        Common.Query.First;
        while not Common.Query.eof do
        begin
          Inc(bnd);
          Bands.Items[bnd].Visible := True;
          Bands.Items[bnd].Caption := Common.Query.Fields[1].AsString;

          Inc(col);
          Columns[col].Visible     := true;
          Columns[col].Width       := 95;

          Inc(col);
          Columns[col].Visible     := true;
          Columns[col].Width       := 60;

          Common.Query.Next;
        end;
        Inc(bnd);
        Bands.Items[bnd].Visible := True;
        Bands.Items[bnd].Caption := '합계';

        Inc(col);
        TotCol := Col;   //합계매출금액
        Columns[col].Visible                     := true;
        Inc(col);
        Columns[col].Visible                     := true;
        vCol2 := Col-1;


        bvGridView1Rate.Position.BandIndex := bnd;
        bvGridView1Rate.Index              := col+1;
      end;

      //퇴장시간기준
      for I := 0 to PosList.Count - 1 do
      begin
        PosNo := PosList.Strings[I];
        vSql := vSql + Format('Sum(case when s.NO_POS = ''%s'' then s.AMT_SALE   else 0 end) as AMT_%s, ',[PosNo,PosNo])
                     + Format('Sum(case when s.NO_POS = ''%s'' then s.CNT_CUST   else 0 end) as QTY_%s, ',[PosNo,PosNo]);
      end;

      OpenQuery('select   Max(c.NM_CODE1) as TIME_ZONE, '
               +vSQL
               +'         ifnull(Sum(s.AMT_SALE),0) as AMT_SALE, '
               +'         ifnull(Sum(s.CNT_CUST),0) as CNT_CUST, '
               +'         0 as AMT_CUST '
               +'from     MS_CODE as c left outer join '
               +'        (select   h.CD_STORE, '
               +'                  h.NO_POS, '
               +'                  h.CD_TIME as CD_CODE, '
               +'                  Sum(h.AMT_SALE) as AMT_SALE, '
               +'                  Sum(h.CNT_PERSON) as CNT_CUST '
               +'         from     SL_SALE_H as h '
               +'         where    h.CD_STORE = :P0 '
               +'           and    h.YMD_SALE = :P1 '
               +'           and    h.DS_SALE <> ''V'' '
               +'         group by h.CD_STORE, h.NO_POS, h.CD_TIME) as s on c.CD_STORE = s.CD_STORE '
               +'                                                       and c.CD_CODE  = s.CD_CODE '
               +'where    c.CD_STORE  = :P0 '
               +'  and    c.CD_KIND   = ''15'' '
               +'  and    c.DS_STATUS = ''0'' '
               +'group by c.CD_CODE '
               +'order by c.CD_CODE ',
               [Common.Config.StoreCode,
                DtoS(SearchDateEdit.Date)]);
      Common.OpenDataToGrid(Common.Query, bvGridView);
      if bvGridView.DataController.Summary.FooterSummaryValues[vCol1-1] <> 0 then
      begin
        bvGridView.DataController.BeginUpdate;
        for vIndex := 0 to bvGridView.DataController.RecordCount-1 do
          bvGridView.DataController.Values[vIndex, bvGridViewRate.Index] := Extended(bvGridView.DataController.Values[vIndex, vCol1]) / bvGridView.DataController.Summary.FooterSummaryValues[vCol1-1] * 100;
        bvGridView.DataController.EndUpdate;
      end;
      //입장시간 기준
      vSql := '';
      for I := 0 to PosList.Count - 1 do
      begin
        PosNo := PosList.Strings[I];
        vSql := vSql + Format('Sum(case when s.NO_POS = ''%s'' then s.AMT_SALE   else 0 end) as AMT_%s, ',[PosNo,PosNo])
                     + Format('Sum(case when s.NO_POS = ''%s'' then s.CNT_CUST   else 0 end) as QTY_%s, ',[PosNo,PosNo]);
      end;

      OpenQuery('select   Max(c.NM_CODE1) as TIME_ZONE, '
               +vSQL
               +'         ifnull(Sum(s.AMT_SALE),0) as AMT_SALE, '
               +'         ifnull(Sum(s.CNT_CUST),0) as CNT_CUST, '
               +'         0 as AMT_CUST '
               +'from     MS_CODE as c left outer join '
               +'        (select   h.CD_STORE, '
               +'                  h.NO_POS, '
               +'                  GetBetweenTime(h.CD_STORE,h.COME_TIME) as CD_CODE, '
               +'                  Sum(h.AMT_SALE) as AMT_SALE, '
               +'                  Sum(h.CNT_PERSON) as CNT_CUST '
               +'         from     SL_SALE_H as h '
               +'         where    h.CD_STORE = :P0 '
               +'           and    h.YMD_SALE = :P1 '
               +'           and    h.DS_SALE <> ''V'' '
               +'         group by h.CD_STORE, '
               +'                  h.NO_POS, '
               +'                  GetBetweenTime(h.CD_STORE,h.COME_TIME)) as s on c.CD_STORE = s.CD_STORE '
               +'                                                               and c.CD_CODE  = s.CD_CODE '
               +'where    c.CD_STORE  = :P0 '
               +'  and    c.CD_KIND   = ''15'' '
               +'  and    c.DS_STATUS = ''0'' '
               +'group by c.CD_CODE '
               +'order by c.CD_CODE ',
               [Common.Config.StoreCode,
                DtoS(SearchDateEdit.Date)]);
      Common.OpenDataToGrid(Common.Query, bvGridView1);
      if bvGridView1.DataController.Summary.FooterSummaryValues[vCol1-1] <> 0 then
      begin
        bvGridView1.DataController.BeginUpdate;
        for vIndex := 0 to bvGridView1.DataController.RecordCount-1 do
          bvGridView1.DataController.Values[vIndex, bvGridView1Rate.Index] := Extended(bvGridView.DataController.Values[vIndex, vCol1]) / bvGridView1.DataController.Summary.FooterSummaryValues[vCol2-1] * 100;
        bvGridView1.DataController.EndUpdate;
      end;

    end;
    4 : //취소현황
    begin
      OpenQuery('select a.CD_MENU, '
               +'       b.NM_MENU, '
               +'       StoD(a.DT_ORDER)  as DT_ORDER, '
               +'       StoD(a.DT_CANCEL) as DT_CANCEL, '
               +'       GetCommonName(a.CD_STORE, ''03'', d.CD_FLOOR) as NM_FLOOR, '
               +'       case when a.DS_ORDER = ''D'' then ''배달'' '
               +'            when a.NO_TABLE = 0     then ''TakeOut'' '
               +'       else GetTableName(a.CD_STORE, a.NO_TABLE) end as NM_TABLE, '
               +'       a.QTY_CANCEL, '
               +'       a.CANCEL_TXT, '
               +'       a.NO_POS '
               +' from  SL_SALE_C a left outer join '
               +'       MS_MENU   b on a.CD_STORE = b.CD_STORE '
               +'                  and a.CD_MENU  = b.CD_MENU  left outer join  '
               +'       MS_TABLE  d on a.CD_STORE = d.CD_STORE '
               +'                  and a.NO_TABLE = d.NO_TABLE '
               +'where a.CD_STORE = :P0 '
               +'  and a.YMD_SALE = :P1 '
               +'order by a.DT_CANCEL ',
               [Common.Config.StoreCode,
                FormatDateTime('yyyymmdd', SearchDateEdit.Date)]);
      DM.ReadQuery(Common.Query, CancelGridView);
    end;
    5 : //월별매출
    begin
      DM.OpenCloud('select ConCat(Left(YMD_SALE,4),''-'',SubString(YMD_SALE,5,2),''월'') as YM_SALE, '
                  +'       Sum(AMT_SALE + DC_TOT + AMT_SERVICE) as AMT_TOTAL, '
                  +'       Sum(DC_TOT)   as DC_TOT, '
                  +'       Sum(AMT_SERVICE) as AMT_SERVICE, '
                  +'       Sum(AMT_SALE) as AMT_SALE, '
                  +'       DivInt(Sum(AMT_SALE-AMT_DUTYFREE), 11)  as AMT_TAX, '
                  +'       Sum(AMT_SALE-AMT_DUTYFREE) as AMT_NET, '
                  +'       Sum(AMT_DUTYFREE)  as AMT_SALE_DUTYFREE '
                  +'  from SL_SALE_H_SUM '
                  +' where CD_HEAD  =:P0 '
                  +'   and CD_STORE =:P1 '
                  +'   and YMD_SALE BETWEEN :P2 and :P3 ' //DATE_FORMAT(NOW(), ''%Y0101'') AND DATE_FORMAT(NOW(), ''%Y1231'') '
                  +' group by Left(YMD_SALE,6) '
                  +' order by 1 ',
                   [Common.Config.HeadStoreCode,
                    Common.Config.StoreCode,
                    FormatDateTime('yyyymmdd', IncYear(SearchDateEdit.Date,-1)),
                    FormatDateTime('yyyymmdd', SearchDateEdit.Date)],Common.RestDBURL);
      MonthGridView.DataController.RecordCount := 0;
      MonthGridView.DataController.BeginUpdate;
      while not DM.CloudData.Eof do
      begin
        MonthGridView.DataController.AppendRecord;
        MonthGridView.DataController.Values[MonthGridView.DataController.RecordCount-1, 0] := DM.CloudData.Fields[0].AsString;
        MonthGridView.DataController.Values[MonthGridView.DataController.RecordCount-1, 1] := DM.CloudData.Fields[1].AsCurrency;
        MonthGridView.DataController.Values[MonthGridView.DataController.RecordCount-1, 2] := DM.CloudData.Fields[2].AsCurrency;
        MonthGridView.DataController.Values[MonthGridView.DataController.RecordCount-1, 3] := DM.CloudData.Fields[3].AsCurrency;
        MonthGridView.DataController.Values[MonthGridView.DataController.RecordCount-1, 4] := DM.CloudData.Fields[4].AsCurrency;
        MonthGridView.DataController.Values[MonthGridView.DataController.RecordCount-1, 5] := DM.CloudData.Fields[5].AsCurrency;
        MonthGridView.DataController.Values[MonthGridView.DataController.RecordCount-1, 6] := DM.CloudData.Fields[6].AsCurrency;
        MonthGridView.DataController.Values[MonthGridView.DataController.RecordCount-1, 7] := DM.CloudData.Fields[7].AsCurrency;
        DM.CloudData.Next;
      end;
      DM.CloudData.Close;
      MonthGridView.DataController.EndUpdate;
    end;
    6 : //전년대비 매출
    begin
      DM.OpenCloud('select Left(YMD_SALE,4) as YEAR, '
                  +'       SUM(JAN_AMT) AS JAN_AMT, '
                  +'       SUM(FEB_AMT) AS FEB_AMT, '
                  +'       SUM(MAR_AMT) AS MAR_AMT, '
                  +'       SUM(APR_AMT) AS APR_AMT, '
                  +'       SUM(MAY_AMT) AS MAY_AMT, '
                  +'       SUM(JUN_AMT) AS JUN_AMT, '
                  +'       SUM(JUL_AMT) AS JUL_AMT, '
                  +'       SUM(AUG_AMT) AS AUG_AMT, '
                  +'       SUM(SEP_AMT) AS SEP_AMT, '
                  +'       SUM(OCT_AMT) AS OCT_AMT, '
                  +'       SUM(NOV_AMT) AS NOV_AMT, '
                  +'       SUM(DEC_AMT) AS DEC_AMT, '
                  +'       SUM(TOT_AMT) AS TOT_AMT '
                  +'  from (select YMD_SALE,'
                  +'               case when SubString(YMD_SALE,5,2) = ''01'' then AMT_SALE else 0 end as JAN_AMT, '
                  +'               case when SubString(YMD_SALE,5,2) = ''02'' then AMT_SALE else 0 end as FEB_AMT, '
                  +'               case when SubString(YMD_SALE,5,2) = ''03'' then AMT_SALE else 0 end as MAR_AMT, '
                  +'               case when SubString(YMD_SALE,5,2) = ''04'' then AMT_SALE else 0 end as APR_AMT, '
                  +'               case when SubString(YMD_SALE,5,2) = ''05'' then AMT_SALE else 0 end as MAY_AMT, '
                  +'               case when SubString(YMD_SALE,5,2) = ''06'' then AMT_SALE else 0 end as JUN_AMT, '
                  +'               case when SubString(YMD_SALE,5,2) = ''07'' then AMT_SALE else 0 end as JUL_AMT, '
                  +'               case when SubString(YMD_SALE,5,2) = ''08'' then AMT_SALE else 0 end as AUG_AMT, '
                  +'               case when SubString(YMD_SALE,5,2) = ''09'' then AMT_SALE else 0 end as SEP_AMT, '
                  +'               case when SubString(YMD_SALE,5,2) = ''10'' then AMT_SALE else 0 end as OCT_AMT, '
                  +'               case when SubString(YMD_SALE,5,2) = ''11'' then AMT_SALE else 0 end as NOV_AMT, '
                  +'               case when SubString(YMD_SALE,5,2) = ''12'' then AMT_SALE else 0 end as DEC_AMT, '
                  +'               AMT_SALE as TOT_AMT '
                  +'          from SL_SALE_H_SUM  '
                  +'         where CD_HEAD  =:P0 '
                  +'           and CD_STORE =:P1 '
                  +'           and YMD_SALE between :P2 and :P3 '
                  +'        ) as t '
                  +' group by Left(t.YMD_SALE,4) '
                  +' order by 1 ',
                   [Common.Config.HeadStoreCode,
                    Common.Config.StoreCode,
                    FormatDateTime('yyyy0101', IncYear(SearchDateEdit.Date,-1)),
                    FormatDateTime('yyyy1231', SearchDateEdit.Date)],Common.RestDBURL);

      YearGridView.DataController.RecordCount := 0;
      YearGridView.DataController.BeginUpdate;
      vIndex := 1;
      while not DM.CloudData.Eof do
      begin
        YearGridView.DataController.AppendRecord;
        YearGridView.DataController.Values[YearGridView.DataController.RecordCount-1, 0]  := DM.CloudData.Fields[0].AsString;
        YearGridView.DataController.Values[YearGridView.DataController.RecordCount-1, 1]  := DM.CloudData.Fields[1].AsCurrency;
        YearGridView.DataController.Values[YearGridView.DataController.RecordCount-1, 2]  := DM.CloudData.Fields[2].AsCurrency;
        YearGridView.DataController.Values[YearGridView.DataController.RecordCount-1, 3]  := DM.CloudData.Fields[3].AsCurrency;
        YearGridView.DataController.Values[YearGridView.DataController.RecordCount-1, 4]  := DM.CloudData.Fields[4].AsCurrency;
        YearGridView.DataController.Values[YearGridView.DataController.RecordCount-1, 5]  := DM.CloudData.Fields[5].AsCurrency;
        YearGridView.DataController.Values[YearGridView.DataController.RecordCount-1, 6]  := DM.CloudData.Fields[6].AsCurrency;
        YearGridView.DataController.Values[YearGridView.DataController.RecordCount-1, 7]  := DM.CloudData.Fields[7].AsCurrency;
        YearGridView.DataController.Values[YearGridView.DataController.RecordCount-1, 8]  := DM.CloudData.Fields[8].AsCurrency;
        YearGridView.DataController.Values[YearGridView.DataController.RecordCount-1, 9]  := DM.CloudData.Fields[9].AsCurrency;
        YearGridView.DataController.Values[YearGridView.DataController.RecordCount-1, 10] := DM.CloudData.Fields[10].AsCurrency;
        YearGridView.DataController.Values[YearGridView.DataController.RecordCount-1, 11] := DM.CloudData.Fields[11].AsCurrency;
        YearGridView.DataController.Values[YearGridView.DataController.RecordCount-1, 12] := DM.CloudData.Fields[12].AsCurrency;
        YearGridView.DataController.Values[YearGridView.DataController.RecordCount-1, 13] := DM.CloudData.Fields[13].AsCurrency;
        DM.CloudData.Next;
      end;
      DM.CloudData.Close;
      YearGridView.DataController.EndUpdate;

      if YearGridView.DataController.RecordCount < 2 then Exit;


      vChartXml := '<chart caption=''전년대비매출(단위:천원)'' xAxisName=''월'' yAxisName=''매출금액'' showValues="1" divLineDecimalPrecision="1" limitsDecimalPrecision="1" formatNumberScale="0">';//showValues=''0'' numberprefix= ''''>';

      vChart01 := '  <categories>  ';
      vChart02 := Format('  <dataset seriesName="%s">  ',[FormatDateTime('yyyy년', IncYear(SearchDateEdit.Date,-1))]);
      vChart03 := Format('  <dataset seriesName="%s">  ',[FormatDateTime('yyyy년', SearchDateEdit.Date)]);

      for vIndex := 1 to 12 do
        vChart01 := vChart01 + Format('  <category label="%s" />  ',[YearGridView.Columns[vIndex].Caption]);
      vChart01 := vChart01 + '  </categories>  ';

      for vCol := 1 to 12 do
        begin
          vChart02 := vChart02 + Format('  <set value="%d" />  ',[FtoI(YearGridView.DataController.Values[0, vCol] / 1000)]);
          vChart03 := vChart03 + Format('  <set value="%d" />  ',[FtoI(YearGridView.DataController.Values[1, vCol] / 1000)]);
        end;

      vChart02 := vChart02 + '  </dataset>  ';
      vChart03 := vChart03 + '  </dataset>  ';


      vChartXml := vChartXml + vChart01 + vChart02 + vChart03;
      vChartXml := vChartXml + '</chart>';
      ShowChart(YearChart, 'YearChart', 'mscombi3d', vChartXml);
    end;
  end;
end;

procedure TSaleReport_F.SearchDateEditPropertiesChange(Sender: TObject);
var vIndex :Integer;
begin
  SearchDateEdit.PostEditValue;
  txtBefMonth.Text := Format('전월(%s)',[FormatDateTime('yyyy-mm-dd',IncMonth(SearchDateEdit.CurrentDate, -1))]);
  txtBefWeek.Text  := Format('전주(%s)',[FormatDateTime('yyyy-mm-dd',IncWeek(SearchDateEdit.CurrentDate, -1))]);
  txtBefDay.Text   := Format('전일(%s)',[FormatDateTime('yyyy-mm-dd',IncDay(SearchDateEdit.CurrentDate, -1))]);
  txtNow.Text      := Format('금일(%s)',[FormatDateTime('yyyy-mm-dd',SearchDateEdit.CurrentDate)]);

  txtWeek1.Text    := FormatDateTime('mm-dd',IncDay(SearchDateEdit.CurrentDate, -6))+DayToWeek(DtoS(IncDay(SearchDateEdit.CurrentDate, -6)));
  txtWeek2.Text    := FormatDateTime('mm-dd',IncDay(SearchDateEdit.CurrentDate, -5))+DayToWeek(DtoS(IncDay(SearchDateEdit.CurrentDate, -5)));
  txtWeek3.Text    := FormatDateTime('mm-dd',IncDay(SearchDateEdit.CurrentDate, -4))+DayToWeek(DtoS(IncDay(SearchDateEdit.CurrentDate, -4)));
  txtWeek4.Text    := FormatDateTime('mm-dd',IncDay(SearchDateEdit.CurrentDate, -3))+DayToWeek(DtoS(IncDay(SearchDateEdit.CurrentDate, -3)));
  txtWeek5.Text    := FormatDateTime('mm-dd',IncDay(SearchDateEdit.CurrentDate, -2))+DayToWeek(DtoS(IncDay(SearchDateEdit.CurrentDate, -2)));
  txtWeek6.Text    := FormatDateTime('mm-dd',IncDay(SearchDateEdit.CurrentDate, -1))+DayToWeek(DtoS(IncDay(SearchDateEdit.CurrentDate, -1)));
  txtWeek7.Text    := FormatDateTime('mm-dd',SearchDateEdit.CurrentDate)+DayToWeek(DtoS(SearchDateEdit.CurrentDate));

  for vIndex := 1 to 7 do
  begin
    TcxCurrencyEdit(FindComponent(Format('edtWeek%d',[vIndex]))).Value    := 0;
    TcxCurrencyEdit(FindComponent(Format('edtWeekPer%d',[vIndex]))).Value := 0;
  end;

  SearchButtonClick(nil);
end;

procedure TSaleReport_F.SetCalender;
var
  vStartWeekDay, vLastMonthEndDay, vThisMonthEndDay, vThisMonthStartWeekday, vThisMonthEndWeekday: Integer;
  vRow, vCol: Integer;
begin
  // 지난 달의 말일을 구한다
  vLastMonthEndDay       := DayOf(EndOfTheMonth(IncMonth(SearchDateEdit.CurrentDate, -1)));
  // 이번 달의 말일을 구한다
  vThisMonthEndDay       := DayOf(EndOfTheMonth(SearchDateEdit.CurrentDate));
  // 첫주의 첫번째 날(일)을 구한다
  if DayOfTheWeek(StartOfTheMonth(SearchDateEdit.CurrentDate)) = 1 then // 이번달 첫날이 월요일이면 무조건 전달 마지막날
    vStartWeekDay          := vLastMonthEndDay
  else // 이번달 첫날이 월요일이 아니면 그 주의 첫날-1 (델파이가 첫날을 일요일이 아닌 월요일로 구하므로)
    vStartWeekDay          := DayOf(StartOfTheWeek(StartOfTheMonth(SearchDateEdit.CurrentDate) + IfThen(DayOfTheWeek(StartOfTheMonth(SearchDateEdit.CurrentDate)) = 7, 1, 0))) - 1;
  // 이번 달의 첫날 요일을 구한다
  vThisMonthStartWeekday := IfThen(DayOfTheWeek(StartOfTheMonth(SearchDateEdit.CurrentDate)) = 7, 0, DayOfTheWeek(StartOfTheMonth(SearchDateEdit.CurrentDate)));
  // 이번 달의 마지막날 요일을 구한다
  vThisMonthEndWeekday   := IfThen(DayOfTheWeek(EndOfTheMonth(SearchDateEdit.CurrentDate)) = 7, 0, DayOfTheWeek(EndOfTheMonth(SearchDateEdit.CurrentDate)));

  // 날짜 버튼에 날짜를 표시한다
  for vRow := Low(DateButton) to High(DateButton)-1 do
    for vCol := Low(DateButton[vRow]) to High(DateButton[vRow])-1 do
    begin
      DateButton[vRow, vCol].Visible             := true;
      DateButton[vRow, vCol].Color               := clWhite;
      DateButton[vRow, vCol].Temp1               := EmptyStr;
      DateButton[vRow, vCol].Temp2               := EmptyStr;
      DateButton[vRow, vCol].Temp3               := EmptyStr;
      DateButton[vRow, vCol].Temp4               := EmptyStr;
      DateButton[vRow, vCol].Temp5               := EmptyStr;
      DateButton[vRow, vCol].Temp6               := EmptyStr;
      DateButton[vRow, vCol].Temp7               := EmptyStr;
      DateButton[vRow, vCol].Temp8               := EmptyStr;
      DateButton[vRow, vCol].Temp9               := EmptyStr;
      DateButton[vRow, vCol].Number.CenterString := EmptyStr;
      DateButton[vRow, vCol].Number.RightString  := EmptyStr;
      DateButton[vRow, vCol].Number.ShowNumber   := true;
      DateButton[vRow, vCol].Bottom.Height       := 0;

      // 지난달 뒷날짜 표시(이번달 1일이 화요일일 경우 일,월요일에 해당하는 이전달 날짜 표시)
      if (vRow = 0) and (vStartWeekDay > 1) and (vStartWeekDay+vCol <= vLastMonthEndDay) then
      begin
        DateButton[vRow, vCol].Number.Number       := vStartWeekDay+vCol;
        DateButton[vRow, vCol].Number.Font.Color   := clGray;
        DateButton[vRow, vCol].Menu.Font.Color     := clGray;
        DateButton[vRow, vCol].Hint                := Copy(DtoS(IncMonth(SearchDateEdit.CurrentDate,-1)),1,6) + FormatFloat('00', DateButton[vRow, vCol].Number.Number);
      end
      // 이번달 날짜들 표시
      else if vRow*7+vCol+1-vThisMonthStartWeekday <= vThisMonthEndDay then
      begin
        DateButton[vRow, vCol].Number.Number       := vRow*7+vCol+1-vThisMonthStartWeekday;
        DateButton[vRow, vCol].Number.Font.Color   := IfThen(vCol = 0, clRed, IfThen(vCol = 6, clBlue, clBlack));
        DateButton[vRow, vCol].Menu.Font.Color     := clBlack;
        DateButton[vRow, vCol].Hint                := Copy(DtoS(SearchDateEdit.CurrentDate),1,6) + FormatFloat('00', DateButton[vRow, vCol].Number.Number);
      end
      // 화면을 벗어나는 버튼 숨기기(이번달이 총 4주일 경우 5, 6주에 해당하는 버튼 숨기기)
      else if (vCol-vThisMonthEndWeekday <= 0) or (not DateButton[vRow, 0].Visible) then
      begin
        DateButton[vRow, vCol].Visible             := false;
        DateButton[vRow, vCol].Hint                := '';
      end
      // 다음달 시작날짜 표시(이번달 말일이 목요일일 경우 금,토요일에 해pass당하는 다음날 날짜 표시)
      else
      begin
        DateButton[vRow, vCol].Number.Number       := vCol-vThisMonthEndWeekday;
        DateButton[vRow, vCol].Number.Font.Color   := clGray;
        DateButton[vRow, vCol].Menu.Font.Color     := clGray;
        DateButton[vRow, vCol].Hint                := Copy(DtoS(IncMonth(SearchDateEdit.CurrentDate,1)),1,6) + FormatFloat('00', DateButton[vRow, vCol].Number.Number);
      end;
    end;
  DateButton[4, 7].Visible := DateButton[4, 0].Visible;
  DateButton[5, 7].Visible := DateButton[5, 0].Visible;
  WeekCount := IfThen(not DateButton[4, 0].Visible, 5, IfThen(not DateButton[5, 0].Visible, 6, 7));
end;

procedure TSaleReport_F.FormShow(Sender: TObject);
begin
  isLoading := true;

  //개점이 안됐으면 시스템일자
  if Common.WorkDate <> '' then
    SearchDateEdit.Date := StoD(Common.WorkDate)
  else if Common.LastCloseDate <> '' then
    SearchDateEdit.Date := StoD(Common.LastCloseDate)
  else
    SearchDateEdit.Date := Now();

  ReportPager.ActivePageIndex := 0;
  ReportPagerChange(nil);
  isLoading := false;
  SearchButton.Click;
end;

procedure TSaleReport_F.PrintButtonClick(Sender: TObject);
var vTemp :String;
begin
  case ReportPager.ActivePageIndex of
    0 :
    begin
      Common.Device.SaleReportPrint(nil, ReportPager.ActivePageIndex,FormatDateTime('yyyy"년" m"월" d"일"',SearchDateEdit.Date));
    end;
    1 :
    begin
      if MenuGridView.DataController.RecordCount = 0 then Exit;
      Common.Device.SaleReportPrint(MenuGridView, ReportPager.ActivePageIndex, FormatDateTime('yyyy"년" m"월" d"일"',SearchDateEdit.Date));
    end;
    4 : //취소내역
    begin
      vTemp := Common.WorkDate;
      try
        Common.WorkDate := FormatDateTime('yyyymmdd', SearchDateEdit.Date);

        Common.Device.OrderCancelPrint;
        Common.Device.SaleCancelPrint;
      finally
        Common.WorkDate := vTemp;
      end;
    end;
    5 :
    begin
      if MonthGridView.DataController.RecordCount = 0 then Exit;
      Common.Device.SaleReportPrint(MonthGridView, ReportPager.ActivePageIndex, FormatDateTime('yyyy"년"',SearchDateEdit.Date));
    end;
    6 :
    begin
      if YearGridView.DataController.RecordCount < 2 then Exit;
      Common.Device.SaleReportPrint(YearGridView, ReportPager.ActivePageIndex, FormatDateTime('yyyy"년"',SearchDateEdit.Date));
    end;
  end;
end;

procedure TSaleReport_F.ShowChart(aWebBrowser:TWebBrowser; aChartName, aChartType, aChartData :String);
var vHTML :TStringList;
    vStream: TMemoryStream;
begin
  try
    aWebBrowser.Hint := aChartData;
    vHTML := TStringList.Create;
    vHTML.Add('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> ');
    vHTML.Add('<html xmlns="http://www.w3.org/1999/xhtml"> ');
    vHTML.Add('<head> ');
    vHTML.Add('<meta name="viewport" content="width=device-width, initial-scale=1.0" /> ');
    vHTML.Add('<title>Chart 그래프  </title> ');
    vHTML.Add('<script type="text/javascript" src="https://food.expos.co.kr:8443/Extreme/IntranetFood/Chart6/js/fusioncharts.js"></script> ');
    vHTML.Add('<script type="text/javascript"> ');
    vHTML.Add(' Column3DChart   = "column3d";       //막대3차원');
    vHTML.Add(' Pie2DChart      = "pie2d";          //파이2차원');    vHTML.Add(' Pie3DChart      = "pie3d";          //파이3차원');
    vHTML.Add(' LineChart       = "line";           //선형 ');
    vHTML.Add(' MSColumn3DChart = "mscolumn3d";     //묶음막대3차원');
    vHTML.Add(' MSColumn2DLine  = "mscombi2d";      //막대+선형 2차원');
    vHTML.Add(' MSColumn3DLine  = "mscolumnline3d"; //막대+선형 2차원');
    vHTML.Add(' Bar2DChart      = "bar2d";          //바2차원');
    vHTML.Add(' MSBar2D         = "msbar2d";        //묶음바2차원');
    vHTML.Add(' MSBar3D         = "msbar3d";        //묶음바3차원');
    vHTML.Add(' MSCombiDY2D     = "mscombidy2d";    //선형,막대,영역 혼합 차트');
    vHTML.Add(Format('_chartType="%s", ',[aChartType]));
    vHTML.Add(Format('_height="%d";',[aWebBrowser.Height-Ifthen(aWebBrowser.Height > 300, 90,0)]));
    vHTML.Add(Format('_width="%d",',[aWebBrowser.Width-30]));
    vHTML.Add(Format('_dataSource="%s";',[Replace(aChartData,'"','''')]));
    vHTML.Add(' function GetChart(chartType, chartId, width, height, chartTarget, dataSource, dataFormat ) ');
    vHTML.Add('{ ');
    vHTML.Add('chartType = chartType ? chartType : document.form1.chartType.value; ');
    vHTML.Add('chartId = chartId ? chartId : document.form1.chartId.value; ');
    vHTML.Add('width = width ? width : document.form1.width.value; ');
    vHTML.Add('height = height ? height : document.form1.height.value; ');
    vHTML.Add('chartTarget = chartTarget ? chartTarget : document.form1.chartTarget.value; ');
    vHTML.Add('dataSource = dataSource ? dataSource : document.form1.dataSource.value; ');
    vHTML.Add('dataFormat = dataFormat ? dataFormat : document.form1.dataFormat.value; ');
    vHTML.Add(' FusionCharts && FusionCharts.ready(function () { ');
    vHTML.Add('    if (FusionCharts(chartId) ) { ');
    vHTML.Add('      //FusionCharts(chartId).dispose(); ');
    vHTML.Add('      FusionCharts(chartId).setXMLData(chartXMLNoFlash(dataSource)); ');
    vHTML.Add('    } else ');
    vHTML.Add('       try { ');
    vHTML.Add('         var mychart = new FusionCharts({ ');
    vHTML.Add('          "id" : chartId,');
    vHTML.Add('          "type" : chartType, ');
    vHTML.Add('          "renderAt" : "chartdiv", ');
    vHTML.Add('          "width" : width, ');
    vHTML.Add('          "height" : height, ');
    vHTML.Add('          "dataFormat" : "xml", ');
    vHTML.Add('          "dataSource" : dataSource ');
    vHTML.Add('          }).render(); ');
    vHTML.Add('        } catch(e) { ');
    vHTML.Add('          FusionCharts(chartId).setXMLData(dataSource); ');
    vHTML.Add('        } ');
    vHTML.Add('  }); ');
    vHTML.Add('} ');
    vHTML.Add('function LoadPage() ');
    vHTML.Add('{ ');
    vHTML.Add('//GetChart();');
    vHTML.Add('} ');
    vHTML.Add('</script> ');
    vHTML.Add('</head> ');
    vHTML.Add('<body onload="LoadPage();"> ');
    vHTML.Add('<form name="form1" method="post" action="" id="form1"> ');
    vHTML.Add('<div id="chartdiv" style="text-align:center;margin-bottom:8px;"> ');
    vHTML.Add('<div id=''chartId_1_div'' > ');
    vHTML.Add('Chart... ');
    vHTML.Add('</div> ');
    vHTML.Add('<script type="text/javascript"> ');
    vHTML.Add('FusionCharts && FusionCharts.ready(function () { ');
    vHTML.Add('if (FusionCharts("chartId_1") ) FusionCharts("chartId_1").dispose(); ');
    vHTML.Add('var colorArray = ["FF0000", "008ED6", "F6BD0F", "588526", "008E8E", "8BBA00", "A186BE", "AFD8F8", "FF8E46", "D64646", "8E468E", "B3AA00"];');
    vHTML.Add('var chart_chartId_1 = new FusionCharts({ ');
    vHTML.Add('"id" : "chartId_1", ');
    vHTML.Add('"type" : _chartType, ');
    vHTML.Add('"renderAt" : "chartId_1_div", ');
    vHTML.Add('"width" : _width, ');
    vHTML.Add('"height" : _height, ');
    vHTML.Add('"dataFormat" : "xml", ');
    vHTML.Add('"dataSource" : _dataSource ');
    vHTML.Add('}).render(); ');
    vHTML.Add('}); ');
    vHTML.Add('</script> ');
    vHTML.Add('</div> ');
    vHTML.Add('    </form> ');
    vHTML.Add('</body> ');
    vHTML.Add('</html> ');
    vHTML.Text := UTF8String(vHTML.Text);

//    vHTML.SaveToFile(ExtractFilePath(Application.ExeName)+aChartName+'.html');
//    aWebBrowser.Navigate('file://'+ExtractFilePath(Application.ExeName)+aChartName+'.html');
    aWebBrowser.Navigate('about:blank');
    while aWebBrowser.ReadyState <> READYSTATE_COMPLETE do
    begin
      Sleep(5);
      Application.ProcessMessages;
    end;
    vStream := TMemoryStream.Create;
    vHTML.SaveToStream(vStream);
    vStream.Seek(0,0);
    (aWebBrowser.Document as IPersistStreamInit).Load(
      TStreamAdapter.Create(vStream));
  finally
    vStream.Free;
    vHTML.Free;
  end;
end;


procedure TSaleReport_F.ShowText;
var
  vRow, vCol, vWidth, vHeight, vTop, vFontSize: Integer;
  vProfitRate :String;
begin
  // 제목 레이블 크기를 조정한다
  vWidth := (CalenderTab.Width - 6 - 16) div 8;
  for vCol := 0 to ComponentCount-1 do
    if (Components[vCol] is TcxLabel) and (TcxLabel(Components[vCol]).Parent = CalenderTab) then
    begin
      TcxLabel(Components[vCol]).Width := vWidth;
      TcxLabel(Components[vCol]).Left  := (TcxLabel(Components[vCol]).Tag - 1) * (vWidth + 2)+3 ;
      TcxLabel(Components[vCol]).Top   := 2;
    end;

  if WeekCount = 7 then
    vFontSize := 8
  else
    vFontSize := 9;


  // 날짜 버튼 크기를 조정한다
  vHeight := (CalenderTab.Height - SunLabel.Top - SunLabel.Height - 6 - (WeekCount-1)*2) div WeekCount + 1;
  vTop    := SunLabel.Top + SunLabel.Height - vHeight;
  if Assigned(DateButton[0, 0]) and (DateButton[0, 0] <> nil) then
  begin
    for vRow := Low(DateButton) to High(DateButton) do
      if DateButton[vRow, 0].Visible then
      begin
        Inc(vTop, vHeight + 2);
        for vCol := Low(DateButton[vRow]) to High(DateButton[vRow]) do
        begin
          if WeekCount = 7 then
          begin
            DateButton[vRow, vCol].Number.Height := Trunc(vHeight * 0.12);
            DateButton[vRow, vCol].Number.Font.Size := 7;
          end
          else
          begin
            DateButton[vRow, vCol].Number.Height := Trunc(vHeight * 0.15);
            DateButton[vRow, vCol].Number.Font.Size := 9;
          end;
          DateButton[vRow, vCol].Width          := vWidth;
          DateButton[vRow, vCol].Left           := vCol * (vWidth + 2)+3;
          DateButton[vRow, vCol].Height         := vHeight;
          DateButton[vRow, vCol].Top            := vTop;
          DateButton[vRow, vCol].Menu.Font.Size := vFontSize;
          DateButton[vRow, vCol].Bottom.Height  := 0;
        end;
      end;
  end;

  // 날짜별 매출을 버튼에 표시한다
  for vRow := Low(DateButton) to High(DateButton) do
    for vCol := Low(DateButton[vRow]) to High(DateButton[vRow]) do
      if DateButton[vRow, vCol].Temp1 <> EmptyStr then
      begin
        DateButton[vRow, vCol].Number.RightString := DateButton[vRow, vCol].Temp1+'명';
        if GetHeadOption(9) = '1' then
        begin
          DateButton[vRow, vCol].Menu.Name   := '매출'+#13+
                                                '현금'+#13+
                                                '카드'+#13+
                                                Ifthen(GetHeadOption(9)='1','렛츠','현영')+#13+
                                                ifthen((vRow = High(DateButton)) or (vCol = High(DateButton[vRow])),'평균'+#13,'')+
                                                '출납';

          DateButton[vRow, vCol].Menu.Qty   := FormatFloat(',0', StoF(DateButton[vRow, vCol].Temp2))+#13+
                                               FormatFloat(',0', StoF(DateButton[vRow, vCol].Temp3))+#13+
                                               FormatFloat(',0', StoF(DateButton[vRow, vCol].Temp4))+#13+
                                               FormatFloat(',0', StoF(DateButton[vRow, vCol].Temp5))+#13+
                                               ifthen((vRow = High(DateButton)) or (vCol = High(DateButton[vRow])),FormatFloat(',0', StoF(DateButton[vRow, vCol].Temp2) / Ifthen(StoF(DateButton[vRow, vCol].Temp7)=0,1,StoF(DateButton[vRow, vCol].Temp7)) )+#13,'')+
                                               FormatFloat(',0', StoF(DateButton[vRow, vCol].Temp6));
        end
        else
        begin
          DateButton[vRow, vCol].Menu.Name   := '매출'+#13+
                                                '현금'+#13+
                                                '카드'+#13+
                                                ifthen((vRow = High(DateButton)) or (vCol = High(DateButton[vRow])),'평균'+#13,'')+
                                                '출납';

          DateButton[vRow, vCol].Menu.Qty   := FormatFloat(',0', StoF(DateButton[vRow, vCol].Temp2))+#13+
                                               FormatFloat(',0', StoF(DateButton[vRow, vCol].Temp3))+#13+
                                               FormatFloat(',0', StoF(DateButton[vRow, vCol].Temp4))+#13+
                                               ifthen((vRow = High(DateButton)) or (vCol = High(DateButton[vRow])),FormatFloat(',0', StoF(DateButton[vRow, vCol].Temp2) / Ifthen(StoF(DateButton[vRow, vCol].Temp7)=0,1,StoF(DateButton[vRow, vCol].Temp7)) )+#13,'')+
                                               FormatFloat(',0', StoF(DateButton[vRow, vCol].Temp6));

        end;
      end
      else
      begin
        DateButton[vRow, vCol].Number.RightString := EmptyStr;
        DateButton[vRow, vCol].Menu.Name          := EmptyStr;
        DateButton[vRow, vCol].Menu.Qty           := EmptyStr;
        DateButton[vRow, vCol].Bottom.LeftString  := EmptyStr;
        DateButton[vRow, vCol].Bottom.RightString := EmptyStr;
      end;
end;

end.

































