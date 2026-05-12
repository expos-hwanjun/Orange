unit PosClose_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, OXSpeedButton, StdCtrls, DB, ADODB, MaskUtils,
  Math;

type
  TPosClose_F = class(TForm)
    lbl_Cash: TLabel;
    lbl_Check: TLabel;
    lbl_Card: TLabel;
    lbl_Point: TLabel;
    lbl_Sale: TLabel;
    lbl_PosNo: TLabel;
    lbl_WorkDate: TLabel;
    obtn_magam: TOXSpeedButton;
    obtn_MagamCan: TOXSpeedButton;
    lbl_Count: TLabel;
    lbl_Void: TLabel;
    lbl_Loss: TLabel;
    lbl_Dc: TLabel;
    lbl_lack: TLabel;
    ADOProc_PosSelect: TADOStoredProc;
    lbl_Trust: TLabel;
    lbl_Cashier: TLabel;
    ADOProc_PosSave: TADOStoredProc;
    lbl_TipAmt: TLabel;
    obtn_Cashbox: TOXSpeedButton;
    obtn_close: TOXSpeedButton;
    obtn_init: TOXSpeedButton;
    lbl_OrderNo: TLabel;
    procedure obtn_closeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure obtn_magamClick(Sender: TObject);
    procedure obtn_MagamCanClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure obtn_CashboxClick(Sender: TObject);
    procedure obtn_initClick(Sender: TObject);
  private
    FSTATUS : String;          //마감여부
    FNotClose :String;         //마감되지 않은계산원번호
    FMasterPOS :String;
    function CheckPosClose:Boolean;
    procedure SetLastOrderNo;
  public
    { Public declarations }
  end;

var
  PosClose_F: TPosClose_F;

implementation
uses Common_U, GlobalFunc_U;
{$R *.dfm}

procedure TPosClose_F.obtn_closeClick(Sender: TObject);
begin
  Close;
end;

procedure TPosClose_F.FormShow(Sender: TObject);
begin
  lbl_WorkDate.Caption    := FormatMaskText('!0000년 90월 90일;0; ',Common.WorkDate);
  lbl_PosNo.Caption       := Common.Config.PosNo;
  with ADOProc_Select, Common.Magam do
  begin
    Close;
    Parameters.ParamByName('@cd_store').Value       := Common.Config.StoreCode;
    Parameters.ParamByName('@ymd_close').Value      := Common.WorkDate;
    Parameters.ParamByName('@no_pos').Value         := Common.Config.PosNo;
    ExecProc;

    lbl_Cash.Caption     := FormatFloat('#,0', Parameters.ParamByName('@amt_cash').Value);
    lbl_Check.Caption    := FormatFloat('#,0', Parameters.ParamByName('@amt_check').Value);
    lbl_Card.Caption     := FormatFloat('#,0', Parameters.ParamByName('@amt_card').Value);
    lbl_TipAmt.Caption   := FormatFloat('#,0', Parameters.ParamByName('@amt_tip').Value);
    lbl_Point.Caption    := FormatFloat('#,0', Parameters.ParamByName('@amt_point').Value);
    lbl_Trust.Caption    := FormatFloat('#,0', Parameters.ParamByName('@amt_trust').Value);
    lbl_Loss.Caption     := FormatFloat('#,0', Parameters.ParamByName('@amt_Loss').Value);
    lbl_Sale.Caption     := FormatFloat('#,0', Parameters.ParamByName('@amt_sale').Value);
    lbl_Cashier.Caption  := FormatFloat('#,0', Parameters.ParamByName('@cnt_cashier').Value);
    lbl_Count.Caption    := FormatFloat('#,0', Parameters.ParamByName('@cnt_customer').Value);
    lbl_Void.Caption     := FormatFloat('#,0', Parameters.ParamByName('@amt_void').Value);
    lbl_Dc.Caption       := FormatFloat('#,0', Parameters.ParamByName('@dc_total').Value);
    lbl_Lack.Caption     := FormatFloat('#,0', Parameters.ParamByName('@amt_lack').Value);

    amt_sale             :=  Parameters.ParamByName('@amt_sale').Value;
    amt_tax              :=  Parameters.ParamByName('@amt_tax').Value;
    amt_cash             :=  Parameters.ParamByName('@amt_cash').Value;
    amt_card             :=  Parameters.ParamByName('@amt_card').Value;
    amt_trust            :=  Parameters.ParamByName('@amt_trust').Value;
    amt_point            :=  Parameters.ParamByName('@amt_point').Value;
    amt_check            :=  Parameters.ParamByName('@amt_check').Value;
    amt_gift             :=  Parameters.ParamByName('@amt_gift').Value;
    amt_loss             :=  Parameters.ParamByName('@amt_loss').Value;
    amt_cashtip          :=  Parameters.ParamByName('@amt_tip').Value;
    dc_tot               :=  Parameters.ParamByName('@dc_total').Value;
    cnt_cashier          :=  Parameters.ParamByName('@cnt_cashier').Value;
    cnt_customer         :=  Parameters.ParamByName('@cnt_customer').Value;
    amt_void             :=  Parameters.ParamByName('@amt_void').Value;
    amt_lack             :=  Parameters.ParamByName('@amt_lack').Value;
    amt_cashrcp          :=  Parameters.ParamByName('@amt_cashrcp').Value;
    FStatus              :=  Parameters.ParamByName('@ds_status').Value;
    FNotClose            :=  Parameters.ParamByName('@not_close').Value;
    Close;
  end;
  obtn_magam.Visible     := FStatus = 'O';

  //메인포스일때는 다른정산포스가 마감이 모두 마감되었는지 체크한다
  qyOpen(Common.qryPos, 'select no_pos from ms_store where cd_store =:cs',
         VarArrayof([Common.Config.StoreCode]));

  FMasterPOS := Common.qryPos.FieldByName('no_pos').AsString;

  lbl_OrderNo.Visible := FMasterPOS = Common.Config.PosNo;
  obtn_init.Visible   := FMasterPOS = Common.Config.PosNo;

  SetLastOrderNo;
end;

procedure TPosClose_F.obtn_magamClick(Sender: TObject);
  function GetHoldCount: Integer;
  const SQL_TXT = 'select count(*) cnt from sl_hold_h where cd_store =:cs and no_pos =:np and yn_restore = ''N'' ';
  begin
    Result := 0;
    if Common.Config.Values[16] = '0' then Exit;
    //보류건수 count
    qyOpen(Common.qryPos, SQL_TXT, VarArrayof([Common.Config.StoreCode,
                                               Common.Config.PosNo]));
    Result := Common.qryPos.FieldbyName('Cnt').AsInteger;
    Common.qryPos.Close;
  end;
var BillClear, WeatherCode :String;
    I :Integer;
begin
  if Common.IsWorking then Exit;

  if Common.Config.Values[29] = '1' then
  begin
    if Common.Config.UserPass <> Common.ShowNumberForm('패스워드를 입력하세요', 16) then
    begin
      Common.MessageBox('패스워드가 올바르지 않습니다');
      Exit;
    end;
  end;

  if FStatus = 'C' then
  begin
    Common.MessageBox('이미 포스마감이 완료됐습니다');
    Exit;
  end;

  if Common.WorkDate = '' then
  begin
    Common.MessageBox('개점이 안됐습니다');
    Exit;
  end;

  if FNotClose <> 'X' then
  begin
    Common.MessageBox(FNotClose+' 계산원이 마감되지 않았습니다'+#13#13+
                      '계산원마감을 먼저 해야합니다');
    Exit;

  end;
  if lbl_Cashier.Caption = '0' then
  begin
    Common.MessageBox('마감된 계산원이 없습니다');
    Exit;
  end;

  if not Common.MessageYNBox(mkHide, '포스마감을 하시겠습니까?') then Exit;

  if GetHoldCount > 0 then
  begin
    if not Common.MessageYNBox(mkShow,'보류내역이 있습니다'+#13#13+'계속 하시겠습니까?') then Exit;
  end;

  BillClear := '1';
  if FMasterPOS = Common.Config.PosNo then
  begin
    if not CheckPosClose then Exit;

    //메인포스 마감시 주문번호 초기화를 한다고 체크하지 않았을때는 마감할때 물어본다
    if Common.Config.Values[43] = '0' then
    begin
      if Common.MessageYNBox(mkShow, '주문번호를 초기화 하시겠습니까?') then
        BillClear := '0'
    end
    else BillClear := '0';

{    qyOpen(Common.qryPos, 'select nm_code1+''-''+nm_code2 from ms_code where cd_store=:p0 and cd_kind =''17'' order by cd_code',
                          VarArrayof([Common.Config.StoreCode]));

    if not Common.qryPos.Eof then
    begin
      WeatherCode := '001';
      //날씨 선택 폼 추가
    end;
}
  end;


  Common.ShowWaitForm;
  Common.IsWorking := True;
  try
    Common.BeginTran;

    with ADOProc_Save do
    begin
      Close;
      Parameters.ParamByName('@cd_store').Value       := Common.Config.StoreCode;
      Parameters.ParamByName('@ymd_close').Value      := Common.WorkDate;
      Parameters.ParamByName('@no_pos').Value         := Common.Config.PosNo;
      Parameters.ParamByName('@ds_orderno').Value     := BillClear;
      Parameters.ParamByName('@cd_weather').Value     := '001';//WeatherCode;
      Parameters.ParamByName('@work_kind').Value      := 'C';
      ExecProc;
    end;

    Common.CommitTran;
    SetLastOrderNo;
    Common.HideWaitForm;
  Except
    on E : Exception do
    begin
      Common.HideWaitForm;
      Common.RollbackTran;
      Common.IsWorking := False;
      Common.ErrorLogSave('PosClose001',E.Message);
      Common.MessageBox(E.Message+#13#13+'포스마감을 완료하지 못했습니다');
      Exit;
    end;
  end;

  For I := 1 to StoI(Common.Config.Values[75]) do
    Common.Device.PosClosePrint;
  Common.LastCloseDate := Common.WorkDate;
  Common.WorkDate      := '';
  Common.MessageBox('포스마감이 완료됐습니다');
  obtn_magam.Visible   := False;
  FStatus              := 'C';
  Common.PosType       := ptNotAccount;
  Common.IsWorking     := False;
end;

procedure TPosClose_F.obtn_MagamCanClick(Sender: TObject);
const SQL_TXT = 'select max(ymd_close) from sl_posclose where cd_store =:cs and no_pos=:np ';
var vTemp :String;
begin
  if not Common.MessageYNBox(mkShow, '포스마감을 취소하시겠습니까?') then Exit;

  if Common.Config.UserPass <> Common.ShowNumberForm('패스워드를 입력하세요', 6) then
  begin
    Common.MessageBox('패스워드가 올바르지 않습니다');
    Exit;
  end;  

  qyOpen(Common.qryPos, SQL_TXT, VarArrayof([Common.Config.StoreCode,
                                             Common.Config.PosNo]));


  vTemp := Common.qryPos.Fields[0].AsString;

  if vTemp = '' then
  begin
    Common.MessageBox('마감된 일자가 없습니다');
    Exit;
  end;

  if not Common.MessageYNBox(mkShow, '최종마감된 일자가 '+vTemp+ ' 입니다'+#13#13+
                         '마감을 취소하시겠습니까?') then Exit;
  try
    Common.BeginTran;
    with ADOProc_Save do
    begin
      Close;
      Parameters.ParamByName('@cd_store').Value    := Common.Config.StoreCode;
      Parameters.ParamByName('@ymd_close').Value   := vTemp;
      Parameters.ParamByName('@no_pos').Value      := Common.Config.PosNo;
      Parameters.ParamByName('@work_kind').Value   := 'X';
      ExecProc;

      if Parameters.ParamByName('@result').Value = 'Y' then
        raise Exception.Create('후방에서 일마감이 완료됐습니다')
      else if Parameters.ParamByName('@result').Value = 'X' then
        raise Exception.Create('포스마감이 안된 일자입니다')
      else if Parameters.ParamByName('@result').Value = 'M' then
        raise Exception.Create(vTemp+'일자 이후에 매출 또는 개점된'+#13#13+'내역이 있으면 마감을 취소할수 없습니다');
      Common.LastCloseDate := Parameters.ParamByName('@ymd_last').Value;
    end;
    Common.CommitTran;

    Common.WorkDate := vTemp;
    FStatus         := 'O';
    FormShow(nil);
    Common.MessageBox('마감이 취소되었습니다'+#13#13+'매출일자가 '+vTemp+'일로 변경되었습니다');
    Common.PosType  := ptAccount;
  except
    on E : Exception do
    begin
      Common.RollbackTran;
      Common.MessageBox(E.Message);
    end;
  end;
  ADOProc_Save.Close;
end;

procedure TPosClose_F.FormCreate(Sender: TObject);
begin
  Common.ImageCreate(Self,'poscloseform');
  Common.EventApply(Self);
end;

procedure TPosClose_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case Key of
     27      :  obtn_close.Click;
   end;
end;

procedure TPosClose_F.obtn_CashboxClick(Sender: TObject);
begin
  Common.Device.CashBoxOpen;
end;


function TPosClose_F.CheckPosClose:Boolean;
const SQL_TXT = 'select no_pos from sl_posclose where cd_store =:p0 and ymd_close=:p1 and ds_status =''O'' ';
begin
  Result := False;
  with Common do
  begin
    //마감되었는지 체크
    qyOpen(qryPos1, SQL_TXT, VarArrayof([Common.Config.StoreCode, Common.WorkDate]));

    if (not qryPos1.Eof) and (qryPos1.Fields[0].AsString <> Common.Config.PosNo) then
    begin
      Common.MessageBox(qryPos1.Fields[0].Asstring+#13+'포스의 마감이 되지않았습니다.');
      Exit;
    end;
  end;
  Result := True;
end;
procedure TPosClose_F.obtn_initClick(Sender: TObject);
begin
  if not Common.MessageYNBox(mkShow, '주문번호를 초기화 하시겠습니까??') then Exit;

  try
    Common.BeginTran;
    qyOpen(Common.qryPos, 'delete from ms_orderno where cd_store =:p0',
           VarArrayof([Common.Config.StoreCode]));

    SetLastOrderNo;
    Common.CommitTran;
  except
    on E: Exception do
    begin
      Common.RollbackTran;
      Common.ErrorLogSave('PosClose002',E.Message);
      Common.MessageBox(E.Message+#13#13+'작업을 완료하지 못했습니다');
      Exit;
    end;
  end;
end;

procedure TPosClose_F.SetLastOrderNo;
begin
  qyOpen(Common.qryPos, 'select max(no_order) from ms_orderno where cd_store =:p0',
         VarArrayof([Common.Config.StoreCode]));

  lbl_OrderNo.Caption := '주문번호-'+ Common.qryPos.Fields[0].AsString;
end;

end.
