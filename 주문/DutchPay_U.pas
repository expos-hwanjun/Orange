unit DutchPay_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, cxControls, cxContainer, cxEdit, cxLabel,
  DB, Common_U, StrUtils, StdCtrls, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Math, Vcl.Menus, cxButtons, PosButton,
  dxGDIPlusClasses, Vcl.ExtCtrls, AdvShape, AdvGlassButton, AdvSmoothButton,
  AdvSmoothToggleButton;
type TDutchPayMode = (dmNone, dmAllot, dmAcct, dmEnd);
type
  TDutchPay_F = class(TForm)
    sgr_Grid1: TStringGrid;
    sgr_Grid2: TStringGrid;
    lblNumber: TcxLabel;
    lblTotalAmt: TcxLabel;
    lblEachAmt: TcxLabel;
    TitleLabel: TLabel;
    CloseButton: TcxButton;
    GridTitleShape: TAdvShape;
    MessageLabel: TLabel;
    Image3: TImage;
    CaptionLabel: TcxLabel;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    AdvShape1: TAdvShape;
    DutchPay0Button: TAdvSmoothButton;
    DutchPay1Button: TAdvSmoothButton;
    DutchPay2Button: TAdvSmoothButton;
    DutchPay3Button: TAdvSmoothButton;
    DutchPay4Button: TAdvSmoothButton;
    GetButton: TAdvSmoothToggleButton;
    LeftMoveButton: TAdvSmoothButton;
    RightMoveButton: TAdvSmoothButton;
    GuestChangeButton: TAdvSmoothButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sgr_Grid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CloseButtonClick(Sender: TObject);
    procedure AllGetButtonClick(Sender: TObject);
    procedure GetButtonClick(Sender: TObject);
    procedure LeftMoveButtonClick(Sender: TObject);
    procedure RightMoveButtonClick(Sender: TObject);
    procedure GuestChangeButtonClick(Sender: TObject);
    procedure DutchPay0ButtonClick(Sender: TObject);
  private
    FDutchPayMode  :TDutchPayMode;
    FTotalAmt     :Integer;    //테이블총금액
    FMenuTotCount :Integer;    //테이블 총메뉴수
    FDutchAmt     :Integer;    //1명당 금액
    FCount :Integer;    //더치페이인원
    FIndex :Integer;    //더치페이계산 인덱스
    FDutchPayList :Array of TStringGrid;
    FAcctCount : Integer;   //계산이 완료된 건
    procedure AllotMenu;
    function GetMenuRow(aGrid:TStringGrid; aMenuCode, aPrice:String):Integer;
    procedure SetDutchPayIndex(vIndex:Integer);
    procedure MenuMove(aGrid, bGrid :TStringGrid; aRow:Integer);
    function  SetTableMenuDelete:Boolean;
    procedure SetDutchPayMode(const Value: TDutchPayMode);
    property  DutchPayMode :TDutchPayMode read FDutchPayMode write SetDutchPayMode;
  public
  end;

var
  DutchPay_F: TDutchPay_F;

implementation
uses GlobalFunc_U, Order_U, Const_U, DBModule_U;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TDutchPay_F.FormCreate(Sender: TObject);
var vSize :Integer;
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(GridTitleShape);
  Common.SetButtonColor(AdvShape1);
  Common.SetButtonColor(RightMoveButton);
  Common.SetButtonColor(LeftMoveButton);
  Common.SetButtonColor(GuestChangeButton);

  if Screen.PixelsPerInch = 96 then
    vSize := 11
  else if Screen.PixelsPerInch <= 120 then
    vSize := 10
  else if Screen.PixelsPerInch <= 150 then
    vSize := 9
  else if Screen.PixelsPerInch <= 180 then
    vSize := 8;


  //그리드 칼럼크기 셋팅
  sgr_Grid1.ColWidths[0] := 190;
  sgr_Grid1.ColWidths[1] := 45;
  sgr_Grid1.ColWidths[2] := 85;
  sgr_Grid1.ColWidths[3] := 93;
  sgr_Grid1.ColWidths[4] := -1;
  sgr_Grid1.ColWidths[5] := -1;
  sgr_Grid1.ColWidths[6] := -1;
  sgr_Grid1.ColWidths[7] := -1;
  sgr_Grid1.Font.Size    := 14;
  GridTitleShape.Text := Format('<FONT color="#FFFFFF"  size="%d" face="맑은 고딕">       메뉴명                       수량          단가          금액</FONT>',[vSize]);

  AdvShape1.Text      := Format('<FONT color="#FFFFFF"  size="%d" face="맑은 고딕">       메뉴명                       수량          단가          금액</FONT>',[vSize]);

  sgr_Grid2.ColWidths[0] := 190;
  sgr_Grid2.ColWidths[1] := 45;
  sgr_Grid2.ColWidths[2] := 85;
  sgr_Grid2.ColWidths[3] := 93;
  sgr_Grid2.ColWidths[4] := -1;
  sgr_Grid2.ColWidths[5] := -1;
  sgr_Grid2.ColWidths[6] := -1;
  sgr_Grid2.ColWidths[7] := -1;
  sgr_Grid2.Font.Size    := 14;
  FIndex     := -1;
  FAcctCount := 0;
end;

procedure TDutchPay_F.FormShow(Sender: TObject);
begin
  BlockInput(false);
  OpenQuery('select Date_Format(COME_TIME, ''%Y%m%d''), '
           +'       Date_Format(COME_TIME, ''%H%i'') '
           +'  from SL_ORDER_H '
           +' where CD_STORE =:P0 '
           +'   and NO_TABLE =:P1 '
           +'   and DS_ORDER = ''T'' ',
           [Common.Config.StoreCode,
            Common.Table.Number]);

  Common.Table.Date        := Common.Query.Fields[0].AsString;
  Common.Table.Time        := Common.Query.Fields[1].AsString;

  OpenQuery('select NM_MENU, '
           +'       QTY_ORDER, '
           +'       PR_SALE, '
           +'       AMT_ORDER, '
           +'       CD_MENU, '
           +'       SEQ, '
           +'       DS_MENU_TYPE, '
           +'       DS_TAX, '
           +'       YN_RCP, '
           +'       DS_SALE, '
           +'       PR_ITEM, '
           +'       PR_SALE_ORG '
           +'  from '
           +'      (select case a.DS_SALE when ''D'' then ConCat(a.NM_MENU,:P2) '
           +'                                        else a.NM_MENU '
           +'              end as NM_MENU, '
           +'              a.QTY_ORDER, '
           +'              a.PR_SALE, '
           +'              a.AMT_ORDER, '
           +'              a.CD_MENU, '
           +'              a.SEQ, '
           +'              b.DS_MENU_TYPE, '
           +'              b.DS_TAX, '
           +'              Substring(b.CONFIG,3,1) as YN_RCP, '
           +'              a.DS_SALE, '
           +'              a.PR_ITEM, '
           +'              b.PR_SALE as PR_SALE_ORG,'
           +'              case when b.DS_MENU_TYPE = ''W'' then AMT_ORDER else a.PR_SALE end as PRICE_SEQ '
           +'         from SL_ORDER_D a inner join '
           +'              MS_MENU    b on b.CD_STORE = a.CD_STORE and b.CD_MENU = a.CD_MENU '
           +'        where a.CD_STORE =:P0 '
           +'          and a.NO_TABLE =:P1 '
           +'          and a.CD_MENU1 = '''' '
           +'          and a.DS_ORDER   =''T'' '
           +'    ) t '
           +'   order by PRICE_SEQ desc ',
           [Common.Config.StoreCode,
            Common.Table.Number,
            Common.Config.ServiceTxt]);

  FMenuTotCount := 0;
  while not Common.Query.Eof do
  begin
    if sgr_Grid1.Cells[0,0] <> '' then sgr_Grid1.RowCount := sgr_Grid1.RowCount + 1;
    sgr_Grid1.Cells[0, sgr_Grid1.RowCount-1] := Common.Query.FieldbyName('NM_MENU').AsString ;
    sgr_Grid1.Cells[1, sgr_Grid1.RowCount-1] := Common.GetQtyReplace(Common.Query.FieldbyName('DS_MENU_TYPE').AsString, Common.Query.FieldbyName('QTY_ORDER').AsString);                       //상품수량
    if Common.Query.FieldbyName('DS_MENU_TYPE').AsString = 'W' then
      sgr_Grid1.Cells[2, sgr_Grid1.RowCount-1] := Common.Query.FieldbyName('PR_SALE_ORG').AsString
    else
      sgr_Grid1.Cells[2, sgr_Grid1.RowCount-1] := Common.Query.FieldbyName('PR_SALE').AsString;
    sgr_Grid1.Cells[3, sgr_Grid1.RowCount-1] := Common.Query.FieldbyName('AMT_ORDER').AsString;
    sgr_Grid1.Cells[4, sgr_Grid1.RowCount-1] := Common.Query.FieldbyName('CD_MENU').AsString;
    sgr_Grid1.Cells[5, sgr_Grid1.RowCount-1] := Common.Query.FieldbyName('SEQ').AsString;
    sgr_Grid1.Cells[6, sgr_Grid1.RowCount-1] := Common.Query.FieldbyName('DS_MENU_TYPE').AsString;
    sgr_Grid1.Cells[7, sgr_Grid1.RowCount-1] := Common.Query.FieldbyName('QTY_ORDER').AsString;
    sgr_Grid1.Cells[8, sgr_Grid1.RowCount-1] := Common.Query.FieldbyName('YN_RCP').AsString;
    sgr_Grid1.Cells[9, sgr_Grid1.RowCount-1] := Common.Query.FieldbyName('DS_TAX').AsString;
    sgr_Grid1.Cells[10,sgr_Grid1.RowCount-1] := Common.Query.FieldbyName('DS_SALE').AsString;
    sgr_Grid1.Cells[11,sgr_Grid1.RowCount-1] := Common.Query.FieldbyName('PR_ITEM').AsString;
    sgr_Grid1.Cells[12,sgr_Grid1.RowCount-1] := Common.Query.FieldbyName('PR_SALE').AsString;
    if Common.Query.FieldbyName('DS_MENU_TYPE').AsString = 'W' then
      FMenuTotCount := FMenuTotCount + 1
    else
      FMenuTotCount := FMenuTotCount + Common.Query.FieldbyName('QTY_ORDER').AsInteger;
    Common.Query.Next;
  end;
  Common.Query.Close;

  FTotalAmt := Common.Table.OrderAmt;
  lblTotalAmt.Caption := FormatFloat('#,0', FTotalAmt)+'원';
  DutchPayMode := dmNone;
  if (GetOption(401) = '0') and (FMenuTotCount > 1) then
    GuestChangeButtonClick(nil);
end;

procedure TDutchPay_F.sgr_Grid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var  vAlign : integer;
begin
  TStringGrid(Sender).Canvas.Font.Size := TStringGrid(Sender).Font.Size;
  if gdSelected in State then
  begin
    TStringGrid(Sender).Canvas.Font.Color  := clWhite;
    TStringGrid(Sender).Canvas.Brush.Color := $00AE5700;
  end
  else
  begin
    TStringGrid(Sender).Canvas.Brush.Color := clWhite;;
    TStringGrid(Sender).Canvas.Font.Color  := clBlack;
  end;

  case Acol of
     0    :  vAlign  := 0; //왼쪽
     1..3 :  vAlign  := 2; //오른쪽
  end;
  Common.Grid_Align(Sender, ACol, ARow, Rect, vAlign);
  // 숫자형 출력시 Format 형식   //
  case ACol of
    2,3: Common.Grid_DisplayFormat(Sender, ACol, ARow, Rect);
  end;
end;

procedure TDutchPay_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TDutchPay_F.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if DutchPayMode = dmAcct then
  begin
    if Common.AskBox('더치페이 작업 완료되지 않았습니다'+#13#13+'그래도 닫으시겠습니까?') then
    begin
      if SetTableMenuDelete then
        CanClose := True
      else
        CanClose := False;
    end
    else CanClose := False;
  end;
end;

procedure TDutchPay_F.AllGetButtonClick(Sender: TObject);
  procedure SetDutchPayData(aIndex:Integer);
  var nRow :Integer;
  begin
    Common.ClearGrid(Common.Summary_sGrd);
    InitPreSentRecord(Common.PreSent);
    For nRow := 0 to FDutchPayList[aIndex].RowCount-1 do
    begin
      if Common.Summary_sGrd.Cells[0,0] <> '' then Common.Summary_sGrd.RowCount := Common.Summary_sGrd.RowCount+1;
      Common.Summary_sGrd.Cells[0,             Common.Summary_sGrd.RowCount-1] := IntToStr(Common.Summary_sGrd.RowCount);
      Common.Summary_sGrd.Cells[GDM_NM_MENU,   Common.Summary_sGrd.RowCount-1] := FDutchPayList[aIndex].Cells[0, nRow];
      Common.Summary_sGrd.Cells[GDM_VIEWQTY,   Common.Summary_sGrd.RowCount-1] := FDutchPayList[aIndex].Cells[1, nRow];
      Common.Summary_sGrd.Cells[GDM_PR_SALE,   Common.Summary_sGrd.RowCount-1] := FDutchPayList[aIndex].Cells[12, nRow];
      Common.Summary_sGrd.Cells[GDM_CD_MENU,   Common.Summary_sGrd.RowCount-1] := FDutchPayList[aIndex].Cells[4, nRow];
      Common.Summary_sGrd.Cells[GDM_AMT,       Common.Summary_sGrd.RowCount-1] := FDutchPayList[aIndex].Cells[3, nRow];
      Common.Summary_sGrd.Cells[GDM_DS_MENU,   Common.Summary_sGrd.RowCount-1] := FDutchPayList[aIndex].Cells[6, nRow];
      Common.Summary_sGrd.Cells[GDM_QTY,       Common.Summary_sGrd.RowCount-1] := FDutchPayList[aIndex].Cells[7, nRow];
      Common.Summary_sGrd.Cells[GDM_YN_RCP,    Common.Summary_sGrd.RowCount-1] := FDutchPayList[aIndex].Cells[8, nRow];
      Common.Summary_sGrd.Cells[GDM_DS_TAX,    Common.Summary_sGrd.RowCount-1] := FDutchPayList[aIndex].Cells[9, nRow];
      Common.Summary_sGrd.Cells[GDM_DS_SALE,   Common.Summary_sGrd.RowCount-1] := FDutchPayList[aIndex].Cells[10,nRow];
      Common.Summary_sGrd.Cells[GDM_PR_ITEM,   Common.Summary_sGrd.RowCount-1] := FDutchPayList[aIndex].Cells[11,nRow];
      Common.Summary_sGrd.Cells[GDM_VIEWPRICE, Common.Summary_sGrd.RowCount-1] := FDutchPayList[aIndex].Cells[2, nRow];
    end;
    Common.GridToGrid(Common.Summary_sGrd, Common.Temp_sGrd);
    Common.TaxCalculation;
    Common.PreSent.TotalAmt := StrToInt(TAdvSmoothButton(FindComponent(Format('DutchPay%dButton',[aIndex]))).Hint);
    Common.PreSent.CashAmt  := Common.PreSent.TotalAmt;
    Common.PreSent.RcvAmt   := Common.PreSent.CashAmt;
    Common.PreSent.WRcvAmt  := 0;
  end;
var vIndex :Integer;
    vRcpNo :String;
begin
  Common.GridToGrid( FDutchPayList[FIndex], Common.DuthPay_sGrd);
  Order_F := TOrder_F.Create(Self);
  Common.OrderKind := okDutchPayAll;
  try
    if Order_F.ShowModal = mrOK then
    begin
      vRcpNo := Common.PreSent.RcpNo;
      For vIndex := 0 to FCount-1 do
      begin
        if StrToInt(TAdvSmoothButton(FindComponent(Format('DutchPay%dButton',[vIndex]))).Hint) = 0 then Continue;
        SetDutchPayData(vIndex);
        Common.PreSent.RcpNo := vRcpNo+'('+IntToStr(vIndex+1)+')';
        Common.Device.Receipt_Print('P');
      end;
      FIndex := -1;
      DutchPayMode := dmEnd;
      Close;
    end;
  finally
    FreeAndNil(Order_F);
    //테이블을 사용 상태로 변경한다
    ExecQuery('update SL_ORDER_H '
             +'   set TABLE_STATE = ''Y'' '
             +' where CD_STORE=:P0 '
             +'   and NO_TABLE=:P1',
             [Common.Config.StoreCode,
              Common.Table.Number]);
  end;
end;

procedure TDutchPay_F.AllotMenu;
  procedure SetAllotMenu(vIndex:Integer);
  var nRow :Integer;
  begin
    For nRow := 0 to sgr_Grid1.RowCount -1 do
    begin
      MenuMove(sgr_Grid1, FDutchPayList[vIndex], sgr_Grid1.Row);
      Break;
    end;
  end;
var vIndex :Integer;
begin
  //인원지정시 자동배분
  if GetOption(401) = '0' then
  begin
    vIndex := 0;
    while sgr_Grid1.Cells[0,0] <> '' do
    begin
      if vIndex >= FCount then vIndex := 0;
      SetAllotMenu(vIndex);
      Inc(vIndex);
    end;
  end
  else
  begin
    For vIndex := 0 to FCount-1 do
      SetAllotMenu(vIndex);
  end;

  For vIndex := 0 to FCount-1 do
    SetDutchPayIndex(vIndex);
end;

procedure TDutchPay_F.GetButtonClick(Sender: TObject);
  procedure SetDutchPay;
  var vIndex :Integer;
  begin
    if sgr_Grid1.Cells[0,0] = '' then
    begin
      Common.OrderKind := okDutchPayEnd;
      for vIndex := 0 to 4 do
      begin
        //현재 계산중인건 제외
        if vIndex = FIndex then Continue;
        if TAdvSmoothButton(FindComponent(Format('DutchPay%dButton',[vIndex]))).Visible
          and  TAdvSmoothButton(FindComponent(Format('DutchPay%dButton',[vIndex]))).Enabled
          and  (TAdvSmoothButton(FindComponent(Format('DutchPay%dButton',[vIndex]))).Hint <> '0') then
          begin
            Common.OrderKind := okDutchPay;
            Break;
          end;
      end;
    end
    else Common.OrderKind := okDutchPay;

  end;
begin
  if sgr_Grid2.Cells[0,0] = '' then Exit;
  if FIndex = -1 then
  begin
    Common.ErrBox('결제 할 인원을 선택하세요');
    Exit;
  end;
  Common.GridToGrid( FDutchPayList[FIndex], Common.DuthPay_sGrd);
  Order_F := TOrder_F.Create(Self);
  if GetOption(401) = '1' then
    SetDutchPay
  else
  begin
    if FAcctCount < FCount-1 then
      Common.OrderKind := okDutchPay
    else
      Common.OrderKind := okDutchPayEnd;
  end;

  try
    if Order_F.ShowModal = mrOK then
    begin
      TAdvSmoothButton(FindComponent(Format('DutchPay%dButton',[FIndex]))).Enabled := False;
      TAdvSmoothButton(FindComponent(Format('DutchPay%dButton',[FIndex]))).Color   := $00D8D8D8;
      TAdvSmoothButton(FindComponent(Format('DutchPay%dButton',[FIndex]))).Status.Caption := '계산완료';
      TAdvSmoothButton(FindComponent(Format('DutchPay%dButton',[FIndex]))).Status.Appearance.Fill.Color := clRed;
      TAdvSmoothButton(FindComponent(Format('DutchPay%dButton',[FIndex]))).Status.Visible := true;
//      Common.ClearGrid(FDutchPayList[FIndex]);
      Common.ClearGrid(sgr_Grid2);
      DutchPayMode := dmAcct;
      Inc(FAcctCount);
      if FIndex < High(FDutchPayList) then
        DutchPay0ButtonClick(TAdvSmoothButton(FindComponent(Format('DutchPay%dButton',[FIndex+1]))))
      else
        FIndex := -1;

      if Common.OrderKind = okDutchPayEnd then
      begin
        DutchPayMode := dmEnd;
        Close;
      end;
    end;
  finally
    FreeAndNil(Order_F);
    //테이블을 사용 상태로 변경한다
    ExecQuery('update SL_ORDER_H '
             +'   set TABLE_STATE = ''Y'' '
             +' where CD_STORE=:P0 '
             +'   and NO_TABLE=:P1',
             [Common.Config.StoreCode,
              Common.Table.Number]);
  end;
end;

function TDutchPay_F.GetMenuRow(aGrid:TStringGrid; aMenuCode, aPrice: String): Integer;
var nRow :Integer;
begin
  Result := -1;
  if aGrid.Cells[0, 0] = '' then Exit;
  For nRow := 0 to aGrid.RowCount-1 do
  begin
    if (aGrid.Cells[4, nRow] = aMenuCode) and
       (aGrid.Cells[2, nRow] = aPrice) then
    begin
      Result := nRow;
      Break;
    end;
  end;
end;

procedure TDutchPay_F.GuestChangeButtonClick(Sender: TObject);
var vTemp :String;
    vIndex :Integer;
begin
  if Sender <> nil then
  begin
    if FMenuTotCount = 1 then
    begin
      Common.ErrBox('메뉴수량이 최소 2개 이상이어야 합니다');
      Exit;
    end;

    if FMenuTotCount > 5 then
      vTemp := Common.ShowNumberForm('더치페이 인원을 입력하세요',1,5,'')
    else
      vTemp := Common.ShowNumberForm('더치페이 인원을 입력하세요',1,FMenuTotCount,'');

    if (vTemp = 'mrClose') or (StoI(vTemp) = 0) then Exit;
    FCount := StoI(vTemp);
  end
  else
  begin
    FCount := Ifthen(FMenuTotCount > 5, 5, FMenuTotCount);
  end;

  SetLength(FDutchPayList, FCount);
  For vIndex := 0 to FCount-1 do
  begin
    FDutchPayList[vIndex] := TStringGrid.Create(Application);
    FDutchPayList[vIndex].ColCount := 13;
    Common.ClearGrid(FDutchPayList[vIndex]);
  end;

  AllotMenu;
  lblNumber.Caption := Format('%s 명', [IntToStr(FCount)]) ;
  DutchPay0ButtonClick(DutchPay0Button);
  DutchPayMode := dmAllot;
end;

procedure TDutchPay_F.LeftMoveButtonClick(Sender: TObject);
var vIndex, vRow, vCount :Integer;
    vEmpty :Boolean;
begin
  vEmpty := False;
  if sgr_Grid2.Cells[0, sgr_Grid2.Row] = '' then Exit;
  //더치페이 인원지정 시 메뉴를 자동 배분하지 않습니다.
  if GetOption(401)='0' then
  begin
    if sgr_Grid2.Cells[6, sgr_Grid2.Row] <> 'W' then
    begin
      if (sgr_Grid2.RowCount = 1) and (sgr_Grid2.Cells[1, sgr_Grid2.Row] = '1') then
      begin
        if not Common.AskBox('메뉴를 모두 빼면'#13'다시 추가할 수 없습니다'+#13#13+'계속하시겠습니까?') then Exit;
        vEmpty := True;
      end;
    end
    else
    begin
      if (sgr_Grid2.RowCount = 1) then
      begin
        if not Common.AskBox('메뉴를 모두 빼면'#13'다시 추가할 수 없습니다'+#13#13+'계속하시겠습니까?') then Exit;
        vEmpty := True;
      end;
    end;
  end;

  vRow := sgr_Grid2.Row;
  MenuMove(FDutchPayList[FIndex], sgr_Grid1, sgr_Grid2.Row);
  Common.GridToGrid( FDutchPayList[FIndex ], sgr_Grid2);
  SetDutchPayIndex(FIndex);

  vEmpty := sgr_Grid2.Cells[0,0] = '';

  if (sgr_Grid2.RowCount > vRow) and not vEmpty then
    sgr_Grid2.Row := vRow;

  DutchPayMode := dmAllot;
  if vEmpty and (GetOption(401) = '0') then
  begin
    FCount := FCount -1;
    TAdvSmoothButton(FindComponent(Format('DutchPay%dButton',[FIndex]))).Visible := False;
    LeftMoveButton.Visible     := False;
    RightMoveButton.Visible    := False;
//    AllGetButton.Visible       := False;
    GetButton.Visible          := False;
    vCount := 0;
    for vIndex := 0 to 4 do
    begin
      if TAdvSmoothButton(FindComponent(Format('DutchPay%dButton',[vIndex]))).Visible then
        Inc(vCount);
    end;
    GuestChangeButton.Visible := vCount = 0;
  end;
end;

procedure TDutchPay_F.SetDutchPayIndex(vIndex: Integer);
var nRow, vQty, vAmt :Integer;
begin
  vQty := 0; vAmt := 0;
  For nRow := 0 to FDutchPayList[vIndex].RowCount-1 do
  begin
    if FDutchPayList[vIndex].Cells[6, nRow] <> 'W' then
      vQty := vQty + StoI(FDutchPayList[vIndex].Cells[1, nRow])
    else
      vQty := vQty + 1;

    vAmt := vAmt + StoI(FDutchPayList[vIndex].Cells[3, nRow]);
  end;

  TAdvSmoothButton(FindComponent(Format('DutchPay%dButton',[vIndex]))).Visible    := True;
  TAdvSmoothButton(FindComponent(Format('DutchPay%dButton',[vIndex]))).Caption    := FormatFloat('#,0', vAmt);
  TAdvSmoothButton(FindComponent(Format('DutchPay%dButton',[vIndex]))).Hint       := IntToStr(vAmt);
end;

procedure TDutchPay_F.MenuMove(aGrid, bGrid: TStringGrid; aRow: Integer);
var vRow :Integer;
begin
  if aGrid.Cells[6, aRow] <> 'W' then
  begin
    vRow := GetMenuRow(bGrid, aGrid.Cells[4, aRow], aGrid.Cells[2, aRow]);
    if vRow = -1 then
    begin
      if bGrid.Cells[0,0] <> '' then bGrid.RowCount := bGrid.RowCount+1;
      bGrid.Cells[0, bGrid.RowCount-1] := aGrid.Cells[0, aRow];
      bGrid.Cells[1, bGrid.RowCount-1] := '1';
      bGrid.Cells[2, bGrid.RowCount-1] := aGrid.Cells[2, aRow];
      bGrid.Cells[3, bGrid.RowCount-1] := aGrid.Cells[2, aRow];
      bGrid.Cells[4, bGrid.RowCount-1] := aGrid.Cells[4, aRow];
      bGrid.Cells[5, bGrid.RowCount-1] := aGrid.Cells[5, aRow];
      bGrid.Cells[6, bGrid.RowCount-1] := aGrid.Cells[6, aRow];
      bGrid.Cells[7, bGrid.RowCount-1] := bGrid.Cells[1, bGrid.RowCount-1];
      bGrid.Cells[8, bGrid.RowCount-1] := aGrid.Cells[8, aRow];
      bGrid.Cells[9, bGrid.RowCount-1] := aGrid.Cells[9, aRow];
      bGrid.Cells[10, bGrid.RowCount-1] := aGrid.Cells[10, aRow];
      bGrid.Cells[11, bGrid.RowCount-1] := aGrid.Cells[11, aRow];
      bGrid.Cells[12, bGrid.RowCount-1] := aGrid.Cells[12, aRow];
      //수량이 1 이었으면 Row를 지운다
      if aGrid.Cells[1, aRow] = '1' then
      begin
        Common.DeleteRow(aGrid, aRow);
      end
      else
      begin
        aGrid.Cells[1, aRow] := IntToStr( StoI(aGrid.Cells[1, aRow])-1);
        aGrid.Cells[7, aRow] := IntToStr( StoI(aGrid.Cells[7, aRow])-1);
        aGrid.Cells[3, aRow] := IntToStr( StoI(aGrid.Cells[1, aRow]) * StoI(aGrid.Cells[2, aRow]));
      end;
    end
    else
    begin
      bGrid.Cells[0, vRow] := aGrid.Cells[0, aRow];
      bGrid.Cells[1, vRow] := IntToStr(StoI(bGrid.Cells[1, vRow]) + 1);
      bGrid.Cells[2, vRow] := aGrid.Cells[2, aRow];
      bGrid.Cells[3, vRow] := IntToStr(StoI(bGrid.Cells[1, vRow]) * StoI(aGrid.Cells[2, aRow]));
      bGrid.Cells[4, vRow] := aGrid.Cells[4, aRow];
      bGrid.Cells[5, vRow] := aGrid.Cells[5, aRow];
      bGrid.Cells[6, vRow] := aGrid.Cells[6, aRow];
      bGrid.Cells[7, vRow] := bGrid.Cells[1, vRow];
      bGrid.Cells[8, vRow] := bGrid.Cells[8, vRow];
      bGrid.Cells[9, vRow] := bGrid.Cells[9, vRow];
      bGrid.Cells[10, vRow] := bGrid.Cells[10, vRow];
      bGrid.Cells[11, vRow] := bGrid.Cells[11, vRow];
      bGrid.Cells[12, vRow] := bGrid.Cells[12, vRow];
      //수량이 1 이었으면 Row를 지운다
      if aGrid.Cells[1, aRow] = '1' then
      begin
        Common.DeleteRow(aGrid, aRow);
      end
      else
      begin
        aGrid.Cells[1, aRow] := IntToStr( StoI(aGrid.Cells[1, aRow])-1);
        aGrid.Cells[7, aRow] := IntToStr( StoI(aGrid.Cells[7, aRow])-1);
        aGrid.Cells[3, aRow] := IntToStr( StoI(aGrid.Cells[1, aRow]) * StoI(aGrid.Cells[2, aRow]));
      end;
    end;
  end
  else
  begin
    if bGrid.Cells[0,0] <> '' then bGrid.RowCount := bGrid.RowCount+1;
    bGrid.Cells[0, bGrid.RowCount-1]  := aGrid.Cells[0, aRow];
    bGrid.Cells[1, bGrid.RowCount-1]  := aGrid.Cells[1, aRow];
    bGrid.Cells[2, bGrid.RowCount-1]  := aGrid.Cells[2, aRow];
    bGrid.Cells[3, bGrid.RowCount-1]  := aGrid.Cells[3, aRow];
    bGrid.Cells[4, bGrid.RowCount-1]  := aGrid.Cells[4, aRow];
    bGrid.Cells[5, bGrid.RowCount-1]  := aGrid.Cells[5, aRow];
    bGrid.Cells[6, bGrid.RowCount-1]  := aGrid.Cells[6, aRow];
    bGrid.Cells[7, bGrid.RowCount-1]  := aGrid.Cells[7, aRow];
    bGrid.Cells[8, bGrid.RowCount-1]  := aGrid.Cells[8, aRow];
    bGrid.Cells[9, bGrid.RowCount-1]  := aGrid.Cells[9, aRow];
    bGrid.Cells[10, bGrid.RowCount-1] := aGrid.Cells[10, aRow];
    bGrid.Cells[11, bGrid.RowCount-1] := aGrid.Cells[11, aRow];
    bGrid.Cells[12, bGrid.RowCount-1] := aGrid.Cells[12, aRow];
    Common.DeleteRow(aGrid, aRow);
  end;
end;

procedure TDutchPay_F.SetDutchPayMode(const Value: TDutchPayMode);
begin
  case FDutchPayMode of
    dmAcct :
    begin
      if Value = dmEnd then FDutchPayMode := Value
      else                  FDutchPayMode := dmAcct;
    end;
    else FDutchPayMode := Value;
  end;

  case FDutchPayMode of
    dmNone :
    begin
      GuestChangeButton.Visible  := True;
      LeftMoveButton.Visible     := False;
      RightMoveButton.Visible    := False;
//      AllGetButton.Visible       := False;
      GetButton.Visible          := False;
    end;
    dmAllot :
    begin
      GuestChangeButton.Visible  := False;
      LeftMoveButton.Visible     := True;
      RightMoveButton.Visible    := sgr_Grid1.Cells[0,0] <> '';
//      AllGetButton.Visible       := sgr_Grid1.Cells[0,0] = '';
      if GetOption(401) = '1' then
        GetButton.Visible    := sgr_Grid2.Cells[0,0] <> ''
      else
        GetButton.Visible    := sgr_Grid1.Cells[0,0] = '';
    end;
    dmAcct :
    begin
      GuestChangeButton.Visible  := False;
      LeftMoveButton.Visible     := sgr_Grid2.Cells[0,0] <> '';
      RightMoveButton.Visible    := sgr_Grid1.Cells[0,0] <> '';
//      AllGetButton.Visible       := False;
      if GetOption(401) = '1' then
        GetButton.Visible    := sgr_Grid2.Cells[0,0] <> ''
      else
        GetButton.Visible    := sgr_Grid1.Cells[0,0] = '';
    end;
    dmEnd : Close;
  end;
end;

procedure TDutchPay_F.RightMoveButtonClick(Sender: TObject);
begin
  if sgr_Grid1.Cells[0, sgr_Grid1.Row] = '' then Exit;

  MenuMove(sgr_Grid1, FDutchPayList[FIndex], sgr_Grid1.Row);
  Common.GridToGrid( FDutchPayList[FIndex ], sgr_Grid2);
  SetDutchPayIndex(FIndex);
  DutchPayMode := dmAllot;
end;

procedure TDutchPay_F.DutchPay0ButtonClick(Sender: TObject);
var vIndex :Integer;
begin
 Common.GridToGrid( FDutchPayList[ (Sender as TAdvSmoothButton).Tag ], sgr_Grid2);
 lblEachAmt.Caption := (Sender as TAdvSmoothButton).Caption + '원';
 FIndex := (Sender as TAdvSmoothButton).Tag;
 For vIndex := 0 to 4 do
 begin
   if TAdvSmoothButton(FindComponent(Format('DutchPay%dButton',[vIndex]))).Enabled then
   begin
     TAdvSmoothButton(FindComponent(Format('DutchPay%dButton',[vIndex]))).Color       := $00D76B00;
     TAdvSmoothButton(FindComponent(Format('DutchPay%dButton',[vIndex]))).Status.Visible := false;
   end;
 end;

 (Sender as TAdvSmoothButton).Color := $00A2A2A2;
 (Sender as TAdvSmoothButton).Status.Caption := '선택';
 (Sender as TAdvSmoothButton).Status.Appearance.Fill.Color := $00D76B00;
 (Sender as TAdvSmoothButton).Status.Visible := true;
 DutchPayMode := dmAllot;

end;

function TDutchPay_F.SetTableMenuDelete: Boolean;
var vIndex, vRow, vAmt :Integer;
begin
  Result := False;
  vAmt   := 0;
  Common.BeginTran;
  try
    For vIndex := 0 to 4 do
    begin
      if (TAdvSmoothButton(FindComponent(Format('DutchPay%dButton',[vIndex]))).Enabled) or (not TAdvSmoothButton(FindComponent(Format('DutchPay%dButton',[vIndex]))).Visible) then Continue;
      For vRow := 0 to FDutchPayList[vIndex].RowCount-1 do
      begin
        DM.StoredProc.StoredProcName := 'POS_SAVE_ORDER_CANCEL';
        DM.StoredProc.PrepareSQL;
        DM.StoredProc.ParamByName('_work_kind').Value := 0;
        DM.StoredProc.ParamByName('_cd_store').Value  := Common.Config.StoreCode;
        DM.StoredProc.ParamByName('_no_table').Value  := Common.Table.Number;
        DM.StoredProc.ParamByName('_ds_order').Value  := 'T';
        DM.StoredProc.ParamByName('_cd_menu').Value   := FDutchPayList[vIndex].Cells[4, vRow];
        DM.StoredProc.ParamByName('_seq').Value       := StoI(FDutchPayList[vIndex].Cells[5, vRow]);
        DM.StoredProc.ParamByName('_no_step').Value   := 0;
        DM.StoredProc.ParamByName('_qty_order').Value := StoI(FDutchPayList[vIndex].Cells[7, vRow]);
        DM.StoredProc.ExecProc;
        vAmt := vAmt + StoI(FDutchPayList[vIndex].Cells[3, vRow]);
      end;
    end;
    ExecQuery('update SL_ORDER_H '
             +'   set AMT_ORDER = AMT_ORDER-:P2 '
             +' where CD_STORE=:P0 '
             +'   and NO_TABLE=:P1 '
             +'   and DS_ORDER=''T'' ',
             [Common.Config.StoreCode,
              Common.Table.Number,
              vAmt]);
    Common.CommitTran;
    Result := True;
  except
    on E: Exception do
    begin
      Common.ErrBox(E.Message);
      Common.WriteLog('SetTableMenuDelete',E.Message);
      Common.RollbackTran;
    end;
  end;
end;

procedure TDutchPay_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    27      :  CloseButton.Click;
  end;
end;

end.
