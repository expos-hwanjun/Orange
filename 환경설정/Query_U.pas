unit Query_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit,
  AdvGlassButton, dxGDIPlusClasses, Vcl.ExtCtrls, cxTextEdit, cxMemo,
  Vcl.StdCtrls, cxButtons, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGrid, AdvOfficePager, dxmdaset,
  cxCurrencyEdit, Data.DB, AdvOfficePagerStylers, dxDateRanges,
  dxScrollbarAnnotations;

type
  TQuery_F = class(TForm)
    CloseButton: TcxButton;
    TitleLabel: TLabel;
    Image4: TImage;
    MessageLabel: TLabel;
    ExcuteButton: TAdvGlassButton;
    QueryPager: TAdvOfficePager;
    QueryPagerQuery: TAdvOfficePage;
    QueryPagerQueryMemo: TcxMemo;
    QueryPagerScript: TAdvOfficePage;
    QueryPagerScriptMemo: TcxMemo;
    Grid: TcxGrid;
    GridView: TcxGridTableView;
    GridLevel: TcxGridLevel;
    AdvOfficePagerOfficeStyler1: TAdvOfficePagerOfficeStyler;
    StyleRepository: TcxStyleRepository;
    cxStyle41: TcxStyle;
    StyleHeader: TcxStyle;
    StyleFooter: TcxStyle;
    StyleLevel: TcxStyle;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure ExcuteButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure SetGridColumns;
  public
    { Public declarations }
  end;

var
  Query_F: TQuery_F;

implementation
uses Common_U, GlobalFunc_U, Const_U, DBModule_U, ComObj, Math;

{$R *.dfm}

procedure TQuery_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TQuery_F.ExcuteButtonClick(Sender: TObject);
var
  vSqlText: string;
  vIndex  : Integer;
begin
  if QueryPager.ActivePageIndex = 0 then
  begin
    vSqlText := Trim(QueryPagerQueryMemo.SelText);
    if vSqlText = EmptyStr then
      vSqlText := Replace(QueryPagerQueryMemo.Text, #$D#$A, ' ');
    if vSqlText = EmptyStr then
    begin
      MessageLabel.Caption :='실행할 쿼리가 없습니다.';
      Exit;
    end;

    // Select
    if UpperCase(Copy(vSqlText, 1, 1)) = 'S' then
    begin
      try
        MessageLabel.Caption :='조회 중입니다.';
        DM.ConnectDB;
        DM.Query.SQL.Text := vSqlText;
        DM.Query.Open;
        SetGridColumns;
        // 쿼리를 읽어 그리드에 보여준다(쓰레드)
        DM.ReadQuery(DM.Query, GridView);
      except
        on E: Exception do
        begin
          MessageLabel.Caption :=E.Message;
        end;
      end;
    end

    // DML
    else
    begin
      MessageLabel.Caption :='실행 중입니다.';
      try
        DM.ConnectDB; // 연결 종료는 커밋, 롤백 버튼을 누를 때
        DM.SQL.SQL.Text := vSqlText;
        DM.SQL.Execute;
        MessageLabel.Caption :='실행 완료';
      except
        on E: Exception do
        begin
          MessageLabel.Caption :=E.Message;
        end;
      end;
    end;
  end

  // 스크립트 실행
  else
  begin
    DM.ConnectDB;
    try
      with TStringList.Create do
        try
          vSqlText := Trim(QueryPagerScriptMemo.SelText);
          if vSqlText = EmptyStr then
            for vIndex := 0 to QueryPagerScriptMemo.Lines.Count-1 do
            begin
              if UpperCase(Trim(QueryPagerScriptMemo.Lines.Strings[vIndex])) <> 'GO' then
                Add(QueryPagerScriptMemo.Lines.Strings[vIndex])
              else
              begin
                DM.Script.SQL.Text := Text;
                DM.Script.Execute;
                Clear;
              end;
            end
          else
          begin
            DM.Script.SQL.Text := vSqlText;
            DM.Script.Execute;
          end;
        finally
          Free;
        end;
      MessageLabel.Caption :='모든 스크립트 실행 완료.';
    except
      on E: Exception do
      begin
        MessageLabel.Caption :=E.Message;
      end;
    end;
  end;
end;

procedure TQuery_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
end;

procedure TQuery_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F9 then
    ExcuteButton.Click;
end;

procedure TQuery_F.SetGridColumns;
var
  vIndex :Integer;
begin
  if not DM.Query.Active then
    Exit;
  GridView.ClearItems;
  if not DM.Query.Eof then
    for vIndex := 0 to DM.Query.FieldCount-1 do
    begin
      GridView.CreateColumn;
      GridView.Columns[GridView.ColumnCount-1].Caption               := DM.Query.Fields[vIndex].FieldName;
      GridView.Columns[GridView.ColumnCount-1].DataBinding.FieldName := DM.Query.Fields[vIndex].FieldName; // 필드명
      if DM.Query.Fields[vIndex].DataType in [ftInteger, ftFloat] then
      begin
        GridView.Columns[GridView.ColumnCount-1].PropertiesClassName       := 'TcxCurrencyEditProperties';
        GridView.Columns[GridView.ColumnCount-1].Properties.Alignment.Horz := taRightJustify;
        GridView.Columns[GridView.ColumnCount-1].Options.Filtering         := False;
        TcxCustomCurrencyEditProperties(GridView.Columns[GridView.ColumnCount-1].Properties).DisplayFormat  := '0,';
      end;
    end;
end;

end.
