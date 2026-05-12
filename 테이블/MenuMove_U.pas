{******************************************************************************

                 Copyright (c) 2007 ExtremePOS

 * Unit Name   : MenuMove_U.pas
 * Purpose     : 메뉴이동 모듈
 * Make Date   : 2007/07/28
 * Programming : 김 환 준
 * History     :
 ******************************************************************************}
unit MenuMove_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls, DB, Common_U,
  DateUtils, StrUtils, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  Vcl.Menus, cxControls, cxContainer, cxEdit, dxGDIPlusClasses, cxLabel,
  cxButtons, AdvGlassButton, AdvShape, AdvSmoothButton;

type
  TMenuMove_F = class(TForm)
    sgr_Grid1: TStringGrid;
    sgr_Grid2: TStringGrid;
    GridTitleShape: TAdvShape;
    AdvShape1: TAdvShape;
    FromPriorButton: TAdvGlassButton;
    FromNextButton: TAdvGlassButton;
    ToPriorButton: TAdvGlassButton;
    ToNextButton: TAdvGlassButton;
    CaptionLabel: TLabel;
    CloseButton: TcxButton;
    FromTableLabel: TcxLabel;
    ToTableLabel: TcxLabel;
    MessageLabel: TLabel;
    Image3: TImage;
    ConfirmButton: TAdvSmoothButton;
    RightMoveButton: TAdvSmoothButton;
    LeftMoveButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sgr_Grid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FromPriorButtonClick(Sender: TObject);
    procedure ToPriorButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure RightMoveButtonClick(Sender: TObject);
    procedure LeftMoveButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
  private
    FIsWork   :Boolean;
    sgr_Temp1 :TStringGrid;
    sgr_Temp2 :TStringGrid;
    procedure MenuMove(FGrid, TGrid:TStringGrid);
    procedure MenuQtyDec(aGrid: TStringGrid);
  public
    FromTable,
    ToTable   :TTable;
  end;

var
  MenuMove_F: TMenuMove_F;

implementation
uses GlobalFunc_U, DBModule_U, Table_U;
const gxSeq      = 0;
      gxMenuName = 1;
      gxOrderQty = 2;
      gxMenuCode = 3;
      gxMenuSeq  = 4;
      gxMenuStep = 5;
      gxMenuMemo = 6;
      gxMenuType = 7;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TMenuMove_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TMenuMove_F.ConfirmButtonClick(Sender: TObject);
  function MenuMoveSave(aGrid :TStringGrid; aKind, aFromTable, aToTable :Integer):Boolean;
  var vRow  :Integer;
      vTemp,
      vResult  :String;
  begin
    //빠지는 메뉴내역을 저장한다
    Result := False;
    For vRow := 0 to aGrid.RowCount-1 do
    begin
      {조회한 내역이면 통과}
      if aGrid.Cells[6, vRow] = 'S' then Continue;
      if aGrid.Cells[0,0]     = ''  then Continue;

      try
        DM.StoredProc.StoredProcName := 'POS_SAVE_MENU_MOVE';
        DM.StoredProc.PrepareSQL;
        DM.StoredProc.ParamByName('_CD_STORE').Value := Common.Config.StoreCode;
        DM.StoredProc.ParamByName('_WORK_KIND').Value := aKind;
        DM.StoredProc.ParamByName('_NO_POS').AsString      := Common.Config.PosNo;
        DM.StoredProc.ParamByName('_FROM_TABLE').AsInteger := aFromTable;
        DM.StoredProc.ParamByName('_TO_TABLE').AsInteger   := aToTable;
        DM.StoredProc.ParamByName('_CD_MENU').AsString     := aGrid.Cells[3, vRow];
        DM.StoredProc.ParamByName('_SEQ').AsInteger        := StoI(aGrid.Cells[4, vRow]);
        DM.StoredProc.ParamByName('_NO_STEP').AsInteger    := StoI(aGrid.Cells[5, vRow]);
        DM.StoredProc.ParamByName('_QTY_MOVE').AsInteger   := StoI(aGrid.Cells[2, vRow]);
        DM.StoredProc.ParamByName('_DS_SALE').AsString     := aGrid.Cells[9, vRow];
        DM.StoredProc.ParamByName('_DS_MENU').AsString     := aGrid.Cells[8, vRow];
        DM.StoredProc.ParamByName('_CD_ITEM').AsString     := aGrid.Cells[17, vRow];
        DM.StoredProc.ParamByName('_CD_SERVICE').AsString  := aGrid.Cells[18, vRow];
        if Common.AgeData.Count > 0 then
          vTemp :='00101'
        else
          vTemp := '';
        DM.StoredProc.ParamByName('_CD_AGE').Value     := vTemp;
        DM.StoredProc.ExecProc;
        vResult := DM.StoredProc.ParamByName('_RESULT').Value;
        if vResult <> 'OK' then
          raise Exception.Create(vResult);

        Result := true;
      except
        on E: Exception do
        begin
          Common.WriteLog('MenuMove001',E.Message);
          Common.ErrBox(E.Message+#13#13+'저장을 완료하지 못했습니다');
          Exit;
        end;
      end;
    end;
    Result := True;
  end;
begin
  if FIsWork then Exit;


  try
    FIsWork := True;
    //추가요금 사용 시 이동할 테이블의 입장시간을 체크한다
    if (sgr_Grid1.Cells[0,0] = '') and (Common.GetAddMenuAmt(Common.Table.Number) > 0) then
    begin
      if not Common.AskBox('추가요금이 있는 테이블입니다'+#13+'계속 하시겠습니까?') then
      begin
        Exit;
      end;
    end;

    try
      Common.BeginTran;
      ExecQuery('update SL_ORDER_H '
               +'   set TABLE_STATE = ''O'', '
               +'       LAST_POS    = :P3 '
               +' where CD_STORE =:P0 '
               +'   and NO_TABLE in (:P1,:P2) ',
               [Common.Config.StoreCode,
                Table_F.ToTable.Number,
                Table_F.FromTable.Number,
                Common.Config.PosNo]);

      //옮겨진 테이블에 메뉴를 더한다
      if not MenuMoveSave(sgr_Grid1, 1, ToTable.Number, FromTable.Number) then
        raise Exception.Create('');

      if not MenuMoveSave(sgr_Grid2, 1, FromTable.Number, ToTable.Number) then
        raise Exception.Create('');
      if sgr_Temp1.Cells[0,0] <> '' then
        if not MenuMoveSave(sgr_Temp1, 0, FromTable.Number, FromTable.Number) then
          raise Exception.Create('');
      if sgr_Temp2.Cells[0,0] <> '' then
        if not MenuMoveSave(sgr_Temp2, 0, ToTable.Number, ToTable.Number) then
          raise Exception.Create('');

      //주방주문서 출력
      Table_F.FromTable := ToTable;
      Table_F.ToTable   := FromTable;
      Common.Device.TableWork(sgr_Grid1,1);

      Table_F.FromTable := FromTable;
      Table_F.ToTable   := ToTable;
      Common.Device.TableWork(sgr_Grid2,0);

      ExecQuery('update SL_ORDER_H '
               +'   set AMT_ORDER = (select sum(case when b.DS_MENU_TYPE = ''W'' then 1 else a.QTY_ORDER end * (a.PR_SALE - a.DC_MENU)) '
               +'                     from SL_ORDER_D a inner join '
               +'                          MS_MENU    b on a.CD_STORE = b.CD_STORE and a.CD_MENU = b.CD_MENU '
               +'                    where a.CD_STORE =:P0 '
               +'                      and a.NO_TABLE =:P1 '
               +'                      and a.DS_ORDER = ''T'')  '
               +' where CD_STORE =:p0 '
               +'   and NO_TABLE =:p1 '
               +'   and DS_ORDER = ''T'' ',
               [Common.Config.StoreCode,
                Table_F.FromTable.Number]);

      ExecQuery('update SL_ORDER_H '
               +'   set AMT_ORDER = (select sum(case when b.DS_MENU_TYPE = ''W'' then 1 else a.QTY_ORDER end * (a.PR_SALE - a.DC_MENU)) '
               +'                      from SL_ORDER_D a inner join '
               +'                           MS_MENU    b on a.CD_STORE = b.CD_STORE and a.CD_MENU = b.CD_MENU '
               +'                     where a.CD_STORE =:P0 '
               +'                       and a.NO_TABLE =:P1 '
               +'                       and a.DS_ORDER = ''T'')  '
               +' where CD_STORE =:P0 '
               +'   and NO_TABLE =:P1 '
               +'   and DS_ORDER = ''T'' ',
               [Common.Config.StoreCode,
                Table_F.ToTable.Number]);

      Common.CommitTran;
      Common.MsgBox('메뉴이동를 저장했습니다');
      Close;
    except
      on E: Exception do
      begin
        Common.RollbackTran;
        Common.WriteLog('MenuMove002',E.Message);
        Common.ErrBox('메뉴이동를 저장하지 못했습니다');
      end;
    end;
  finally
    ExecQuery('update SL_ORDER_H '
             +'   set TABLE_STATE = ''N'' '
             +' where CD_STORE =:P0 '
             +'   and NO_TABLE in (:P1,:P2) ',
             [Common.Config.StoreCode,
              Table_F.ToTable.Number,
              Table_F.FromTable.Number]);

    Common.HideWaitForm;
    FIsWork := False;
  end;
end;

procedure TMenuMove_F.FormCreate(Sender: TObject);
var vIndex, vSize :Integer;
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(GridTitleShape);
  Common.SetButtonColor(AdvShape1);
  Common.SetButtonColor(ConfirmButton);

  for vIndex := 0 to ComponentCount-1 do
    if Components[vIndex] is TAdvGlassButton then
      Common.SetButtonColor((Components[vIndex] as TAdvGlassButton));


  if Screen.PixelsPerInch = 96 then
    vSize := 11
  else if Screen.PixelsPerInch <= 120 then
    vSize := 10
  else if Screen.PixelsPerInch <= 150 then
    vSize := 9
  else if Screen.PixelsPerInch <= 180 then
    vSize := 8;

  sgr_Temp1   := TStringGrid.Create(Self);
  sgr_Temp2   := TStringGrid.Create(Self);

  sgr_Temp1.ColCount     := 21;
  sgr_Temp1.RowCount     := 0;
  sgr_Temp2.ColCount     := 21;
  sgr_Temp2.RowCount     := 0;
  sgr_Grid1.ColCount     := 21;
  sgr_Grid2.ColCount     := 21;

  //그리드 칼럼크기 셋팅
  sgr_Grid1.ColWidths[0] := 37;
  sgr_Grid1.ColWidths[1] := 200;
  sgr_Grid1.ColWidths[2] := 60;
  sgr_Grid1.Font.Size    := 12;

  sgr_Grid2.ColWidths[0] := 37;
  sgr_Grid2.ColWidths[1] := 200;
  sgr_Grid2.ColWidths[2] := 60;
  sgr_Grid2.Font.Size    := 12;

  GridTitleShape.Text := Format('<FONT color="#FFFFFF"  size="%d" face="맑은 고딕">No                메뉴명                    수량 </FONT>',[vSize]);
  AdvShape1.Text      := Format('<FONT color="#FFFFFF"  size="%d" face="맑은 고딕">No                메뉴명                    수량 </FONT>',[vSize]);

  for vIndex := 3 to 20 do
  begin
    sgr_Grid1.ColWidths[vIndex] := -1;
    sgr_Grid2.ColWidths[vIndex] := -1;
  end;
  FIsWork := False;
end;

procedure TMenuMove_F.FormShow(Sender: TObject);
begin
  BlockInput(false);
  if Common.Config.Options[25] = '0' then
  begin
    FromTableLabel.Caption := IntToStr(FromTable.Number)+' 번 테이블';
    ToTableLabel.Caption   := IntToStr(ToTable.Number)  +' 번 테이블';
  end
  else
  begin
    FromTableLabel.Caption := FromTable.Name+' 번 테이블';
    ToTableLabel.Caption   := ToTable.Name  +' 번 테이블';
  end;
  OpenQuery('select case a.DS_SALE when ''D'' then ConCat(a.NM_MENU,:P2) '
           +'                            else a.NM_MENU '
           +'       end as NM_MENU, '                                                     //0
           +'       a.QTY_ORDER, '                                                        //1
           +'       a.CD_MENU, '                                                          //2
           +'       a.SEQ, '                                                              //3
           +'       a.NO_STEP, '                                                          //4
           +'       a.CD_PRINTER, '                                                       //5
           +'       a.DS_MENU_TYPE, '                                                     //6
           +'       a.DS_SALE, '                                                          //7
           +'       a.MEMO, '                                                             //8
           +'       b.DS_KITCHEN, '                                                       //9
           +'       b.NO_GROUP, '                                                         //10
           +'       a.AMT_ORDER, '                                                        //11
           +'       a.DC_SPC, '                                                           //12
           +'       a.DS_TAX, '                                                           //13
           +'       a.CD_MENU1, '                                                         //14
           +'       a.CD_ITEM, '                                                          //15
           +'       a.CD_SERVICE, '                                                       //16
           +'       Substring(b.CONFIG,5,1) as YN_BILL, '                                 //17
           +'       a.YN_DOUBLE, '                                                        //18
           +'       b.NM_MENU_KITCHEN '                                                   //19
           +'  from SL_ORDER_D a inner join '
           +'       MS_MENU    b on a.CD_STORE = b.CD_STORE and a.CD_MENU = b.CD_MENU '
           +' where a.CD_STORE = :P0 '
           +'   and a.NO_TABLE = :P1 '
           +'   and a.CD_MENU1 = '''' '
           +'   and a.DS_ORDER   =''T'' ',
           [Common.Config.StoreCode,
            FromTable.Number,
            Common.Config.ServiceTxt]);

  while not Common.Query.Eof do
  begin
    if sgr_Grid1.Cells[0,0] <> '' then sgr_Grid1.RowCount := sgr_Grid1.RowCount + 1;
    sgr_Grid1.Cells[0, sgr_Grid1.RowCount-1] := IntToStr(sgr_Grid1.RowCount);
    sgr_Grid1.Cells[1, sgr_Grid1.RowCount-1] := Common.Query.Fields[0].AsString +' '+Common.Query.Fields[8].AsString; //메뉴명
    sgr_Grid1.Cells[2, sgr_Grid1.RowCount-1] := Common.Query.Fields[1].AsString;                              //수량
    sgr_Grid1.Cells[3, sgr_Grid1.RowCount-1] := Common.Query.Fields[2].AsString;                              //메뉴코드
    sgr_Grid1.Cells[4, sgr_Grid1.RowCount-1] := Common.Query.Fields[3].AsString;                              //순번
    sgr_Grid1.Cells[5, sgr_Grid1.RowCount-1] := Common.Query.Fields[4].AsString;                              //no_step
    sgr_Grid1.Cells[6, sgr_Grid1.RowCount-1] := 'S';
    sgr_Grid1.Cells[7, sgr_Grid1.RowCount-1] := Common.Query.Fields[5].AsString;                              //cd_printer
    sgr_Grid1.Cells[8, sgr_Grid1.RowCount-1] := Common.Query.Fields[6].AsString;                              //ds_menu_type
    sgr_Grid1.Cells[9, sgr_Grid1.RowCount-1] := Common.Query.Fields[7].AsString;                              //ds_sale
    sgr_Grid1.Cells[10,sgr_Grid1.RowCount-1] := Common.Query.Fields[8].AsString;                              //memo
    sgr_Grid1.Cells[11,sgr_Grid1.RowCount-1] := Common.Query.Fields[9].AsString;                              //ds_kitchen
    sgr_Grid1.Cells[12,sgr_Grid1.RowCount-1] := Common.Query.Fields[10].AsString;                             //no_group
    sgr_Grid1.Cells[13,sgr_Grid1.RowCount-1] := Common.Query.Fields[11].AsString;                             //amt_order
    sgr_Grid1.Cells[14,sgr_Grid1.RowCount-1] := Common.Query.Fields[12].AsString;                             //dc_spc
    sgr_Grid1.Cells[15,sgr_Grid1.RowCount-1] := Common.Query.Fields[13].AsString;                             //ds_tax
    sgr_Grid1.Cells[16,sgr_Grid1.RowCount-1] := Common.Query.Fields[14].AsString;                             //cd_menu1
    sgr_Grid1.Cells[17,sgr_Grid1.RowCount-1] := Common.Query.Fields[15].AsString;                             //cd_item
    sgr_Grid1.Cells[18,sgr_Grid1.RowCount-1] := Common.Query.Fields[16].AsString;                             //cd_service
    sgr_Grid1.Cells[19,sgr_Grid1.RowCount-1] := Common.Query.Fields[17].AsString;                             //yn_bill
    sgr_Grid1.Cells[20,sgr_Grid1.RowCount-1] := Common.Query.Fields[18].AsString;                             //yn_double
    sgr_Grid1.Cells[21,sgr_Grid1.RowCount-1] := Common.Query.Fields[19].AsString;                             //nm_menu_kitchen
    Common.Query.Next;
  end;

  OpenQuery('select case a.DS_SALE when ''D'' then ConCat(a.NM_MENU,:P2) '
           +'                            else a.NM_MENU '
           +'       end as NM_MENU, '                                           //0
           +'       a.QTY_ORDER, '                                              //1
           +'       a.CD_MENU, '                                                //2
           +'       a.SEQ, '                                                    //3
           +'       a.NO_STEP, '                                                //4
           +'       a.CD_PRINTER, '                                             //5
           +'       a.DS_MENU_TYPE, '                                           //6
           +'       a.DS_SALE, '                                                //7
           +'       a.MEMO, '                                                   //8
           +'       b.DS_KITCHEN, '                                             //9
           +'       b.NO_GROUP, '                                               //10
           +'       a.AMT_ORDER, '                                              //11
           +'       a.DC_SPC, '                                                 //12
           +'       a.DS_TAX, '                                                 //13
           +'       a.CD_MENU1, '                                               //14
           +'       a.CD_ITEM, '                                                //15
           +'       a.CD_SERVICE, '                                             //16
           +'       Substring(b.CONFIG,5,1) as YN_BILL, '                       //17
           +'       a.YN_DOUBLE, '                                              //18
           +'       b.NM_MENU_KITCHEN '                                         //19
           +'  from SL_ORDER_D a inner join '
           +'       MS_MENU    b on a.CD_STORE = b.CD_STORE and a.CD_MENU = b.CD_MENU '
           +' where a.CD_STORE = :P0 '
           +'   and a.NO_TABLE = :P1 '
           +'   and a.CD_MENU1 = '''' '
           +'   and a.DS_ORDER   =''T'' ',
           [Common.Config.StoreCode,
            ToTable.Number,
            Common.Config.ServiceTxt]);

  while not Common.Query.Eof do
  begin
    if sgr_Grid2.Cells[0,0] <> '' then sgr_Grid2.RowCount := sgr_Grid2.RowCount + 1;
    sgr_Grid2.Cells[0, sgr_Grid2.RowCount-1] := IntToStr(sgr_Grid2.RowCount);
    sgr_Grid2.Cells[1, sgr_Grid2.RowCount-1] := Common.Query.Fields[0].AsString +' '+Common.Query.Fields[8].AsString;
    sgr_Grid2.Cells[2, sgr_Grid2.RowCount-1] := Common.Query.Fields[1].AsString;
    sgr_Grid2.Cells[3, sgr_Grid2.RowCount-1] := Common.Query.Fields[2].AsString;
    sgr_Grid2.Cells[4, sgr_Grid2.RowCount-1] := Common.Query.Fields[3].AsString;
    sgr_Grid2.Cells[5, sgr_Grid2.RowCount-1] := Common.Query.Fields[4].AsString;
    sgr_Grid2.Cells[6, sgr_Grid2.RowCount-1] := 'S';
    sgr_Grid2.Cells[7, sgr_Grid2.RowCount-1] := Common.Query.Fields[5].AsString;
    sgr_Grid2.Cells[8, sgr_Grid2.RowCount-1] := Common.Query.Fields[6].AsString;
    sgr_Grid2.Cells[9, sgr_Grid2.RowCount-1] := Common.Query.Fields[7].AsString;
    sgr_Grid2.Cells[10,sgr_Grid2.RowCount-1] := Common.Query.Fields[8].AsString;
    sgr_Grid2.Cells[11,sgr_Grid2.RowCount-1] := Common.Query.Fields[9].AsString;
    sgr_Grid2.Cells[12,sgr_Grid2.RowCount-1] := Common.Query.Fields[10].AsString;
    sgr_Grid2.Cells[13,sgr_Grid2.RowCount-1] := Common.Query.Fields[11].AsString;
    sgr_Grid2.Cells[14,sgr_Grid2.RowCount-1] := Common.Query.Fields[12].AsString;
    sgr_Grid2.Cells[15,sgr_Grid2.RowCount-1] := Common.Query.Fields[13].AsString;                             //ds_tax
    sgr_Grid2.Cells[16,sgr_Grid2.RowCount-1] := Common.Query.Fields[14].AsString;                             //cd_menu1
    sgr_Grid2.Cells[17,sgr_Grid2.RowCount-1] := Common.Query.Fields[15].AsString;                             //cd_menu1
    sgr_Grid2.Cells[18,sgr_Grid2.RowCount-1] := Common.Query.Fields[16].AsString;                             //cd_menu1
    sgr_Grid2.Cells[19,sgr_Grid2.RowCount-1] := Common.Query.Fields[17].AsString;
    sgr_Grid2.Cells[20,sgr_Grid2.RowCount-1] := Common.Query.Fields[18].AsString;
    sgr_Grid2.Cells[21,sgr_Grid2.RowCount-1] := Common.Query.Fields[19].AsString;
    Common.Query.Next;
  end;
  Common.Query.Close;
end;

procedure TMenuMove_F.FromPriorButtonClick(Sender: TObject);
begin
  if Sender = FromPriorButton then Common.RowPrev(sgr_Grid1)
  else                             Common.RowNext(sgr_Grid1);
end;

procedure TMenuMove_F.LeftMoveButtonClick(Sender: TObject);
begin
  if sgr_Grid2.Cells[0, 0] = '' then Exit;
  if sgr_Grid2.Cells[6, sgr_Grid2.Row] = 'A' then
  begin
    Common.ErrBox('이동된 메뉴는 다시 이동할 수 없습니다.'+#13+#13+
                  '화면을 종료 후 다시 시도하세요');
    Exit;
  end;

  {원테이블에서 빠진메뉴내역 임시그리드 저장}
  MenuMove(sgr_Grid2, sgr_Temp2);
  {메뉴를 옮긴다}
  MenuMove(sgr_Grid2, sgr_Grid1);
end;

procedure TMenuMove_F.sgr_Grid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var  i_align : integer;
begin
  TStringGrid(Sender).Canvas.Font.Size := TStringGrid(Sender).Font.Size;
  if gdSelected in State then
  begin
    TStringGrid(Sender).Canvas.Font.Color  := clWhite;
    TStringGrid(Sender).Canvas.Font.Style  := [fsBold];
    TStringGrid(Sender).Canvas.Brush.Color := $00FFA74F;
  end
  else
  begin
    TStringGrid(Sender).Canvas.Font.Color  := clBlack;
    TStringGrid(Sender).Canvas.Font.Style  := [fsBold];
    TStringGrid(Sender).Canvas.Brush.Color := clWhite;
  end;

   case Acol of
      0,2    :  i_align  := 1; //가운데
      1    :  i_align  := 0; //왼쪽
//      2    :  i_align  := 2; //오른쪽
   end;
   Common.Grid_Align(Sender, ACol, ARow, Rect, i_align);
end;

procedure TMenuMove_F.ToPriorButtonClick(Sender: TObject);
begin
  if Sender = ToPriorButton then Common.RowPrev(sgr_Grid2)
  else                           Common.RowNext(sgr_Grid2);
end;

procedure TMenuMove_F.MenuMove(FGrid, TGrid: TStringGrid);
var vRow :Integer;
begin
  with TGrid do
  begin
    For vRow := 0 to RowCount-1 do
    begin
      {조회한 내역이면 통과}
      if Cells[6, vRow] = 'S' then Continue;

      {먼저 이동한 내역이 있으면 거기에 수량만 추가}
      if (Cells[3, vRow] = FGrid.Cells[3, FGrid.Row]) and
         (Cells[4, vRow] = FGrid.Cells[4, FGrid.Row]) and
         (Cells[5, vRow] = FGrid.Cells[5, FGrid.Row]) then
      begin
        Cells[2, vRow] := IntToStr ( StoI( Cells[2, vRow] ) + 1 );
        Row            := vRow;
        if (TGrid.Name = 'sgr_Grid1') or (TGrid.Name = 'sgr_Grid2') then
          MenuQtyDec(FGrid);
        Exit;
        Break;
      end;
    end;

    {처음 이동하는 메뉴일때}
    if Cells[0,0] <> '' then RowCount := RowCount + 1;

    TGrid.Rows[RowCount-1].Assign( FGrid.Rows[FGrid.Row]);
    Cells[0, RowCount-1] := IntToStr(RowCount);
    //중량형메뉴이면 모두이동
    if FGrid.Cells[8, FGrid.Row] = 'W' then
       Cells[2, RowCount-1] := FGrid.Cells[2, FGrid.Row]
    else
       Cells[2, RowCount-1] := '1';
    Cells[6, RowCount-1]  := 'A';
    Cells[8, RowCount-1]  := FGrid.Cells[8, FGrid.Row];
    Cells[10, RowCount-1] := FGrid.Cells[10, FGrid.Row];
    Cells[11, RowCount-1] := FGrid.Cells[11, FGrid.Row];
    Cells[12, RowCount-1] := FGrid.Cells[12, FGrid.Row];
    Cells[13, RowCount-1] := FGrid.Cells[13, FGrid.Row];
    Cells[14, RowCount-1] := FGrid.Cells[14, FGrid.Row];
    Cells[15, RowCount-1] := FGrid.Cells[15, FGrid.Row];
    Cells[16, RowCount-1] := FGrid.Cells[16, FGrid.Row];
    Cells[17, RowCount-1] := FGrid.Cells[17, FGrid.Row];
    Cells[18, RowCount-1] := FGrid.Cells[18, FGrid.Row];
    Cells[19, RowCount-1] := FGrid.Cells[19, FGrid.Row];
    Cells[20, RowCount-1] := FGrid.Cells[20, FGrid.Row];
    Cells[21, RowCount-1] := FGrid.Cells[21, FGrid.Row];
    Row  := RowCount-1;
    if (TGrid.Name = 'sgr_Grid1') or (TGrid.Name = 'sgr_Grid2') then
      MenuQtyDec(FGrid);
  end;
end;

procedure TMenuMove_F.MenuQtyDec(aGrid: TStringGrid);
begin
  with aGrid do
  begin
    if (Cells[2, Row] = '1') or (Cells[8, Row] = 'W') then
    begin
      Common.DeleteRow(aGrid, Row);
      Common.GridRefresh(aGrid);
    end
    else
      Cells[2, Row] := IntToStr ( StoI( Cells[2, Row] ) - 1 );
  end;
end;

procedure TMenuMove_F.RightMoveButtonClick(Sender: TObject);
begin
  if sgr_Grid1.Cells[0,0] = '' then Exit;
  if sgr_Grid1.Cells[6, sgr_Grid1.Row] = 'A' then
  begin
    Common.ErrBox('이동된 메뉴는 다시 이동할 수 없습니다.'+#13+#13+
                  '화면을 종료 후 다시 시도하세요');
    Exit;
  end;

  {원테이블에서 빠진메뉴내역 임시그리드 저장}
  MenuMove(sgr_Grid1, sgr_Temp1);
  {메뉴를 옮긴다}
  MenuMove(sgr_Grid1, sgr_Grid2);
end;

end.
