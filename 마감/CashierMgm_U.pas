unit CashierMgm_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, DB, GraphicEx,
  KeyPad_F, Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxCurrencyEdit, IdTCPClient, DAScript,
  UniScript, MemDS, DBAccess, Uni, Math, StrUtils, cxGraphics,
  cxLookAndFeels, IniFiles, DateUtils, MaskUtils, dxGDIPlusClasses,
  AdvGlassButton, cxLabel, AdvShape, idGlobal, nrclasses,
  AdvSmoothButton, AdvSmoothToggleButton;

type
  TCashierMgm_F = class(TForm)
    fmKeyPad1: TfmKeyPad;
    UniScript: TUniScript;
    AdvShape1: TAdvShape;
    cxLabel3: TcxLabel;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    cxLabel9: TcxLabel;
    cxLabel10: TcxLabel;
    cxLabel11: TcxLabel;
    cxLabel12: TcxLabel;
    ReadyAmtEdit: TcxCurrencyEdit;
    DepositAmtEdit: TcxCurrencyEdit;
    CashBookInAmtEdit: TcxCurrencyEdit;
    CashBookOutAmtEdit: TcxCurrencyEdit;
    CashAmtEdit: TcxCurrencyEdit;
    PresentAmtEdit: TcxCurrencyEdit;
    cxLabel13: TcxLabel;
    CashTipAmtEdit: TcxCurrencyEdit;
    CardAmtEdit: TcxCurrencyEdit;
    TrustAmtEdit: TcxCurrencyEdit;
    PointAmtEdit: TcxCurrencyEdit;
    BankAmtEdit: TcxCurrencyEdit;
    SaleAmtEdit: TcxCurrencyEdit;
    cxLabel14: TcxLabel;
    CardTipAmtEdit: TcxCurrencyEdit;
    cxLabel15: TcxLabel;
    GiftAmtEdit: TcxCurrencyEdit;
    AdvShape2: TAdvShape;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    _CheckAmtEdit: TcxCurrencyEdit;
    _50000Edit: TcxCurrencyEdit;
    _10000Edit: TcxCurrencyEdit;
    _5000Edit: TcxCurrencyEdit;
    _1000Edit: TcxCurrencyEdit;
    _500Edit: TcxCurrencyEdit;
    _100Edit: TcxCurrencyEdit;
    _50Edit: TcxCurrencyEdit;
    _10Edit: TcxCurrencyEdit;
    _TotalAmtEdit: TcxCurrencyEdit;
    LackAmtEdit: TcxCurrencyEdit;
    _50000AmtEdit: TcxCurrencyEdit;
    _10000AmtEdit: TcxCurrencyEdit;
    _5000AmtEdit: TcxCurrencyEdit;
    _1000AmtEdit: TcxCurrencyEdit;
    _500AmtEdit: TcxCurrencyEdit;
    _100AmtEdit: TcxCurrencyEdit;
    _50AmtEdit: TcxCurrencyEdit;
    _10AmtEdit: TcxCurrencyEdit;
    AdvShape3: TAdvShape;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    GuestCountEdit: TcxCurrencyEdit;
    GuestAvgAmtEdit: TcxCurrencyEdit;
    DcAmtEdit: TcxCurrencyEdit;
    BanpumAmtEdit: TcxCurrencyEdit;
    Label1: TLabel;
    VoidAmtEdit: TcxCurrencyEdit;
    VoidCountEdit: TcxCurrencyEdit;
    TitleLabel: TLabel;
    Image3: TImage;
    MessageLabel: TLabel;
    CloseButton: TcxButton;
    cxLabel16: TcxLabel;
    CashBookInCardAmtEdit: TcxCurrencyEdit;
    cxLabel6: TcxLabel;
    LetsOrderAmtEdit: TcxCurrencyEdit;
    PosCloseButton: TAdvSmoothButton;
    ReprintButton: TAdvSmoothButton;
    CashierColseButton: TAdvSmoothButton;
    CashBoxOpenButton: TAdvSmoothButton;
    CloseCancelButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure cedt_checkExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure _CheckAmtEditExit(Sender: TObject);
    procedure ReprintButtonClick(Sender: TObject);
    procedure CashBoxOpenButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure CloseCancelButtonClick(Sender: TObject);
    procedure PosCloseButtonClick(Sender: TObject);
    procedure CashierColseButtonClick(Sender: TObject);
    procedure _CheckAmtEditPropertiesChange(Sender: TObject);
    procedure _CheckAmtEditKeyPress(Sender: TObject; var Key: Char);
  private
    FSTATUS : String;          //마감여부
    FNotClose :String;         //마감되지 않은계산원번호
    FNoClose,
    FReceiptCount   :Integer;
    ClickTime :TDateTime;
    function CheckPosClose:Boolean;
    procedure CashCompute;
    procedure ButtonEnable;
  public
  end;

var
  CashierMgm_F: TCashierMgm_F;

implementation
uses Common_U, GlobalFunc_U, MagamRePrint_U, Const_U,
  IdTCPConnection, DBModule_U;
{$R *.dfm}

procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TCashierMgm_F.FormCreate(Sender: TObject);
var vIndex :Integer;
begin
  if Common.Config.IsKiosk then Exit;
  Common.LogoCreate(Self,2);
  for vIndex := 0 to ComponentCount-1 do
    if Components[vIndex] is TAdvSmoothButton then
      Common.SetButtonColor((Components[vIndex] as TAdvSmoothButton));

  Width  := 1024;
  Height := 768;
  MessageLabel.Caption := Format('개점일자 : %s-%s-%s',[LeftStr(Common.WorkDate,4), Copy(Common.WorkDate,5,2), RightStr(Common.WorkDate,2)]);
end;

procedure TCashierMgm_F.FormShow(Sender: TObject);
begin
  InitMagamRecord(Common.Magam);
  Common.SetLanguage(Self);

  if (GetOption(173) = '1') then
  begin
    ReadyAmtEdit.Visible          := False;
    DepositAmtEdit.Visible        := False;
    CashBookInAmtEdit.Visible     := False;
    CashBookInCardAmtEdit.Visible := False;
    CashBookOutAmtEdit.Visible    := False;
    CashAmtEdit.Visible           := False;
    CashTipAmtEdit.Visible        := False;
    PresentAmtEdit.Visible        := False;
    CardAmtEdit.Visible           := False;
    CardTipAmtEdit.Visible        := False;
    TrustAmtEdit.Visible          := False;
    GiftAmtEdit.Visible           := False;
    BankAmtEdit.Visible           := False;
    LetsOrderAmtEdit.Visible      := False;
    PointAmtEdit.Visible          := False;
    SaleAmtEdit.Visible           := False;
    GuestCountEdit.Visible        := False;
    GuestAvgAmtEdit.Visible       := False;
    DcAmtEdit.Visible             := False;
    BanpumAmtEdit.Visible         := False;
    VoidCountEdit.Visible         := False;
    VoidAmtEdit.Visible           := False;
    LackAmtEdit.Visible           := False;
  end;

  //마감시재를 입력하지 않을때
  if GetOption(349) = '1' then
  begin
    _CheckAmtEdit.Enabled   := false;
    _50000Edit.Enabled      := false;
    _10000Edit.Enabled      := false;
    _5000Edit.Enabled       := false;
    _1000Edit.Enabled       := false;
    _500Edit.Enabled        := false;
    _100Edit.Enabled        := false;
    _50Edit.Enabled         := false;
    _10Edit.Enabled         := false;
    _TotalAmtEdit.Visible   := false;
  end;
  DM.StoredProc.Close;
  DM.StoredProc.StoredProcName := 'POS_SELECT_CASHIER_MGM';
  DM.StoredProc.PrepareSQL;
  with DM.StoredProc, Common.Magam do
  begin
    Params.ParamByName('_cd_store').Value  := Common.Config.StoreCode;
    Params.ParamByName('_ymd_close').Value := Common.WorkDate;
    Params.ParamByName('_no_pos').Value    := Common.Config.PosNo;
    Params.ParamByName('_cd_sawon').Value  := Common.Config.UserCode;
    Params.ParamByName('_amt_ready').Value := 0;
    Params.ParamByName('_amt_void').Value  := 0;
    Params.ParamByName('_cnt_customer').Value := 0;
    ExecProc;

    ReadyAmtEdit.Value          := ParamByName('_amt_ready').Value;             //log_bin_trust_function_creator
    DepositAmtEdit.Value        := ParamByName('_amt_mid').Value;
    CashBookInAmtEdit.Value     := ParamByName('_amt_acct_cash').Value;
    CashBookInCardAmtEdit.Value := ParamByName('_amt_acct_card').Value;
    CashBookOutAmtEdit.Value    := ParamByName('_amt_acct_out').Value;
    CashAmtEdit.Value           := ParamByName('_amt_cash').Value + ParamByName('_amt_check').Value;
    CashTipAmtEdit.Value        := ParamByName('_amt_cashtip').Value;
    PresentAmtEdit.Value        := ParamByName('_amt_present').Value;
    CardAmtEdit.Value           := ParamByName('_amt_card').Value;
    CardTipAmtEdit.Value        := ParamByName('_amt_cardtip').Value;
    TrustAmtEdit.Value          := ParamByName('_amt_trust').Value;
    GiftAmtEdit.Value           := ParamByName('_amt_Gift').Value;
    BankAmtEdit.Value           := ParamByName('_amt_Bank').Value;
    LetsOrderAmtEdit.Value      := ParamByName('_amt_letsorder').Value;
    PointAmtEdit.Value          := ParamByName('_amt_Point').Value;
    SaleAmtEdit.Value           := ParamByName('_amt_sale').Value;
    GuestCountEdit.Value        := ParamByName('_cnt_customer').Value;
    GuestAvgAmtEdit.Value       := ParamByName('_amt_average').Value;
    DcAmtEdit.Value             := ParamByName('_dc_total').Value;
    BanpumAmtEdit.Value         := ParamByName('_amt_banpum').Value;
    VoidCountEdit.Value         := ParamByName('_cnt_void').Value;
    VoidAmtEdit.Value           := ParamByName('_amt_void').Value;
    LackAmtEdit.Value           := ParamByName('_amt_void').Value;

    amt_tax                  :=  ParamByName('_amt_tax').Value;
    amt_ready                :=  ParamByName('_amt_ready').Value;
    amt_deposit              :=  ParamByName('_amt_mid').Value;
    amt_acct_cash            :=  ParamByName('_amt_acct_cash').Value;
    amt_acct_card            :=  ParamByName('_amt_acct_card').Value;
    amt_acct_out             :=  ParamByName('_amt_acct_out').Value;
    amt_sale                 :=  ParamByName('_amt_sale').Value;
    amt_cash                 :=  ParamByName('_amt_cash').Value;
    cnt_card                 :=  ParamByName('_cnt_card').Value;
    amt_card                 :=  ParamByName('_amt_card').Value;
    amt_trust                :=  ParamByName('_amt_trust').Value;
    amt_check                :=  ParamByName('_amt_check').Value;
    amt_gift                 :=  ParamByName('_amt_gift').Value;
    amt_bank                 :=  ParamByName('_amt_bank').Value;
    amt_etc                  :=  ParamByName('_amt_etc').Value;
    amt_letsorder            :=  ParamByName('_amt_letsorder').Value;
    amt_point                :=  ParamByName('_amt_point').Value;
    dc_coupon                :=  ParamByName('_dc_coupon').Value;
    amt_cashtip              :=  ParamByName('_amt_cashtip').Value;
    amt_cardtip              :=  ParamByName('_amt_cardtip').Value;
    amt_service              :=  ParamByName('_amt_service').Value;
    dc_menu                  :=  ParamByName('_dc_menu').Value;
    dc_member                :=  ParamByName('_dc_member').Value;
    dc_code                  :=  ParamByName('_dc_code').Value;
    dc_receipt               :=  ParamByName('_dc_receipt').Value;
    dc_spc                   :=  ParamByName('_dc_spc').Value;
    dc_event                 :=  ParamByName('_dc_event').Value;
    dc_cut                   :=  ParamByName('_dc_cut').Value;
    dc_vat                   :=  ParamByName('_dc_vat').Value;
    dc_point                 :=  ParamByName('_dc_point').Value;
    dc_taxfree               :=  ParamByName('_dc_taxfree').Value;
    dc_stamp                 :=  ParamByName('_dc_stamp').Value;
    dc_uplus                 :=  ParamByName('_dc_uplus').Value;
    dc_kakao                 :=  ParamByName('_dc_kakao').Value;
    dc_tot                   :=  ParamByName('_dc_total').Value;
    cnt_customer             :=  ParamByName('_cnt_customer').Value;
    amt_average              :=  ParamByName('_amt_average').Value;
    amt_banpum               :=  ParamByName('_amt_banpum').Value;
    cnt_void                 :=  ParamByName('_cnt_void').Value;
    amt_void                 :=  ParamByName('_amt_void').Value;
    amt_cashrcp              :=  ParamByName('_amt_cashrcp').Value;
    amt_present              :=  ParamByName('_amt_present').Value;
    rcp_begin                :=  ParamByName('_rcp_begin').Value;
    rcp_end                  :=  ParamByName('_rcp_end').Value;
    DM.StoredProc.Close;
  end;

  CashCompute;

  OpenQuery('select Count(*) '
           +'  from SL_SALE_H '
           +'	where CD_STORE	=:P0 '
           +'	  and YMD_SALE	=:P1 '
           +'	  and NO_POS	  =:P2 '
           +'	  and CD_SAWON	=:P3 '
           +'	  and DS_SALE	<> ''M'' '
           +'	  and NO_CLOSE	=0 ',
           [Common.Config.StoreCode,
            Common.WorkDate,
            Common.Config.PosNo,
            Common.Config.UserCode]);

  FReceiptCount := Common.Query.Fields[0].AsInteger;
  ButtonEnable;
  if (Tag = 0) and (GetOption(349) = '0') then
    _CheckAmtEdit.SetFocus;
  ClickTime         := IncSecond(Now,-3);
end;

procedure TCashierMgm_F.CashBoxOpenButtonClick(Sender: TObject);
begin
  Common.Device.CashBoxOpen;
end;

procedure TCashierMgm_F.CashCompute;
var
  vCash :Double;
begin
  _CheckAmtEdit.PostEditValue;
  _50000Edit.PostEditValue;
  _10000Edit.PostEditValue;
  _5000Edit.PostEditValue;
  _1000Edit.PostEditValue;
  _500Edit.PostEditValue;
  _100Edit.PostEditValue;
  _50Edit.PostEditValue;
  _10Edit.PostEditValue;

  vCash  :=  _CheckAmtEdit.Value
           + (_50000Edit.Value * 50000)
           + (_10000Edit.Value * 10000)
           + (_5000Edit.Value  * 5000)
           + (_1000Edit.Value  * 1000)
           + (_500Edit.Value   * 500)
           + (_100Edit.Value   * 100)
           + (_50Edit.Value    * 50)
           + (_10Edit.Value    * 10);

  _50000AmtEdit.Value         := _50000Edit.Value * 50000;
  _10000AmtEdit.Value         := _10000Edit.Value * 10000;
  _5000AmtEdit.Value          := _5000Edit.Value  * 5000;
  _1000AmtEdit.Value          := _1000Edit.Value  * 1000;
  _500AmtEdit.Value           := _500Edit.Value   * 500;
  _100AmtEdit.Value           := _100Edit.Value   * 100;
  _50AmtEdit.Value            := _50Edit.Value    * 50;
  _10AmtEdit.Value            := _10Edit.Value    * 10;
  _TotalAmtEdit.Value         := vCash;

  LackAmtEdit.Value    := vCash - PresentAmtEdit.Value;
end;

procedure TCashierMgm_F.CashierColseButtonClick(Sender: TObject);
  function GetHoldCount: Integer;
  begin
    Result := 0;
    if not Common.Config.IsTakeOut then Exit;
    //보류건수 count
    OpenQuery('select Count(*) CNT '
             +'  from SL_HOLD_H '
             +' where CD_STORE =:P0 '
             +'   and NO_POS   =:P1 '
             +'   and YN_RESTORE = ''N'' ',
             [Common.Config.StoreCode,
              Common.Config.PosNo]);
    Result := Common.Query.FieldbyName('Cnt').AsInteger;
    Common.Query.Close;
  end;
var I :Integer;
    vError :Boolean;
    vResult :String;
begin
  if MilliSecondsBetween(Now(),ClickTime) < 500 then Exit;
  if not CashierColseButton.Visible then Exit;
  ClickTime := Now;
  try
    if not Common.IsDebugMode then
      BlockInput(true);
    CashierColseButton.Visible := false;
    vError := true;
    CashCompute;
    if (FReceiptCount = 0) and (VoidCountEdit.Value = 0) and (ReadyAmtEdit.Value = 0) then
    begin
      if not Common.AskBox('매출내역이 없습니다'+#13+'마감 하시겠습니까?') then
        Exit;
    end;

    if not Common.Config.IsKiosk then
    begin
      Common.Magam.order_table := '';
      OpenQuery('select Count(*), '
               +'       Ifnull(Sum(AMT_ORDER),0) '
               +'  from SL_ORDER_H '
               +' where CD_STORE =:P0',
               [Common.Config.StoreCode]);
      if not Common.Query.Eof and (Common.Query.Fields[0].AsInteger > 0) then
      begin
        Common.Magam.order_table := FormatFloat(',0', Common.Query.Fields[1].AsInteger)+'[ '+Common.Query.Fields[0].AsString + ' ]';
        if not Common.AskBox('주문 중 인 테이블이 있습니다'+#13#13+'마감 하시겠습니까?') then Exit;
        BlockInput(true);
      end;

      if GetHoldCount > 0 then
      begin
        if not Common.AskBox('보류내역이 있습니다'+#13#13+'마감 하시겠습니까?') then Exit;
        BlockInput(true);
      end;

      OpenQuery('select NO_TABLE '
               +'  from SL_CARD_AHEAD '
               +' where CD_STORE =:P0 '
               +'union all '
               +'select NO_TABLE '
               +'  from SL_CASH_AHEAD '
               +' where CD_STORE =:P0 '
               +'union all '
               +'select NO_TABLE '
               +'  from SL_ORDER_H '
               +' where CD_STORE =:P0 '
               +'   and DS_ORDER = ''T'' '
               +'   and AMT_CASH > 0 ',
               [Common.Config.StoreCode]);

      if not Common.Query.Eof then
      begin
        if not Common.AskBox('선결제 내역이 있습니다'+#13#13+'마감 하시겠습니까?') then Exit;
        BlockInput(true);
      end;
      Common.Query.Close;
    end;

    Common.ShowWaitForm;
    DM.StoredProc.StoredProcName := 'POS_SAVE_CASHIER_MGM';
    DM.StoredProc.PrepareSQL;

    with DM.StoredProc, Common.Magam do
    begin
      _Check    := _CheckAmtEdit.EditValue;
      _50000    := _50000AmtEdit.EditValue;
      _10000    := _10000AmtEdit.EditValue;
      _5000     := _5000AmtEdit.EditValue;
      _1000     := _1000AmtEdit.EditValue;
      _500      := _500AmtEdit.EditValue;
      _100      := _100AmtEdit.EditValue;
      _50       := _50AmtEdit.EditValue;
      _10       := _10AmtEdit.EditValue;
      amt_input := _TotalAmtEdit.EditValue;
      amt_lack  := LackAmtEdit.EditValue;

      try
        Common.BeginTran;
        Close;
        ParamByName('_cd_store').Value       := Common.Config.StoreCode;
        ParamByName('_ymd_close').Value      := Common.WorkDate;
        ParamByName('_no_pos').Value         := Common.Config.PosNo;
        ParamByName('_cd_sawon').Value       := Common.Config.UserCode;
        ParamByName('_amt_acct_cash').Value  := amt_acct_cash;
        ParamByName('_amt_acct_card').Value  := amt_acct_card;
        ParamByName('_amt_acct_out').Value   := amt_acct_out;
        ParamByName('_amt_sale').Value       := amt_sale;
        ParamByName('_amt_tax').Value        := amt_tax;
        ParamByName('_amt_cash').Value       := amt_cash;
        ParamByName('_cnt_card').Value       := cnt_card;
        ParamByName('_amt_card').Value       := amt_card;
        ParamByName('_amt_trust').Value      := amt_trust;
        ParamByName('_amt_check').Value      := amt_check;
        ParamByName('_amt_gift').Value       := amt_gift;
        ParamByName('_amt_trust').Value      := amt_trust;
        ParamByName('_amt_bank').Value       := amt_bank;
        ParamByName('_amt_etc').Value        := amt_etc;
        ParamByName('_amt_letsorder').Value  := amt_letsorder;
        ParamByName('_amt_point').Value      := amt_point;
        ParamByName('_dc_coupon').Value      := dc_coupon;
        ParamByName('_amt_cashtip').Value    := amt_cashtip;
        ParamByName('_amt_cardtip').Value    := amt_cardtip;
        ParamByName('_amt_service').Value    := amt_service;
        ParamByName('_dc_menu').Value        := dc_menu;
        ParamByName('_dc_member').Value      := dc_member;
        ParamByName('_dc_code').Value        := dc_code;
        ParamByName('_dc_receipt').Value     := dc_receipt;
        ParamByName('_dc_spc').Value         := dc_spc;
        ParamByName('_dc_event').Value       := dc_event;
        ParamByName('_dc_cut').Value         := dc_cut;
        ParamByName('_dc_vat').Value         := dc_vat;
        ParamByName('_dc_point').Value       := dc_point;
        ParamByName('_dc_taxfree').Value     := dc_taxfree;
        ParamByName('_dc_stamp').Value       := dc_stamp;
        ParamByName('_dc_uplus').AsInteger   := dc_uplus;
        ParamByName('_dc_kakao').AsInteger   := dc_kakao;
        ParamByName('_dc_letsorder').AsInteger := dc_letsorder;
        ParamByName('_amt_banpum').Value     := amt_banpum;
        ParamByName('_cnt_void').Value       := cnt_void;
        ParamByName('_amt_void').Value       := amt_void;
        ParamByName('_cnt_customer').Value   := cnt_customer;
        ParamByName('_amt_average').Value    := amt_average;
        ParamByName('_amt_lack').Value       := amt_lack;
        ParamByName('_amt_cashrcp').Value    := amt_cashrcp;
        ParamByName('_rcp_begin').Value      := rcp_begin;
        ParamByName('_rcp_end').Value        := rcp_end;
        ParamByName('__check').Value         := _Check;
        ParamByName('__50000').Value         := _50000;
        ParamByName('__10000').Value         := _10000;
        ParamByName('__5000').Value          := _5000;
        ParamByName('__1000').Value          := _1000;
        ParamByName('__500').Value           := _500;
        ParamByName('__100').Value           := _100;
        ParamByName('__50').Value            := _50;
        ParamByName('__10').Value            := _10;
        ExecProc;
        vResult := ParamByName('_RESULT').AsString;
        if vResult <> 'OK' then
          raise Exception.Create(vResult);

        FNoClose := ParamByName('_seq').Value;
        Common.CommitTran;
        Common.HideWaitForm;
        Common.WriteLog('work','계산원마감 ['+Common.Config.UserCode+']');
        Common.MsgBox('계산원마감이 완료됐습니다');
      except
        on E: Exception do
        begin
          Common.HideWaitForm;
          Common.RollbackTran;
          Common.WriteLog('CashierMgm001',E.Message);
          Common.ErrBox(E.Message+#13#13+'마감을 완료하지 못했습니다');
          Exit;
        end;
      end;
    end;

    vError := false;
    Common.Device.CashierClosePrint(IntToStr(FNoClose));
    //계산원마감 시 자동 포스마감 사용할때
    if (GetOption(123) = '1') or Common.Config.IsKiosk or ((GetOption(375) = '1') and (Common.Config.PosCloseTime < Common.GetNowTime)) then
      PosCloseButtonClick(nil);
    FormShow(nil);
  finally
    if vError then
      CashierColseButton.Visible := true;
    Common.TRSendMessage;
    BlockInput(false);
  end;
end;

procedure TCashierMgm_F.cedt_checkExit(Sender: TObject);
begin
  CashCompute;
end;


procedure TCashierMgm_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case Key of
     VK_F10  :  if (ActiveControl is TCustomEdit) then TCustomEdit(ActiveControl).Clear;
     27      :  CloseButton.Click;
     VK_UP   :  SelectNext(TWinControl(ActiveControl), false,  true);
     VK_DOWN,
     VK_RETURN :  SelectNext(TWinControl(ActiveControl), true,  true);
   end;
end;

procedure TCashierMgm_F.ButtonEnable;
begin
  if (FReceiptCount = 0) and (VoidCountEdit.Value = 0) and (ReadyAmtEdit.Value = 0) then
  begin
    CashierColseButton.Visible := False;
    CloseCancelButton.Visible  := True;
    PosCloseButton.Visible     := True;
  end
  else
  begin
    CashierColseButton.Visible := True;
    CloseCancelButton.Visible  := False;
    PosCloseButton.Visible     := False;
  end;
end;

function TCashierMgm_F.CheckPosClose: Boolean;
begin
  Result := False;
  //마감되었는지 체크
  OpenQuery('select a.NO_POS '
           +'  from SL_POSCLOSE a inner join '
           +'       MS_CODE  as b on b.CD_STORE = b.CD_STORE '
           +'                    and b.CD_KIND  = ''01'' '
           +'                    and b.NM_CODE1 = a.NO_POS '
           +'                    and b.NM_CODE3 = ''0'' '
           +' where a.CD_STORE =:P0 '
           +'   and a.YMD_CLOSE=:P1 '
           +'   and a.DS_STATUS =''O'' ',
           [Common.Config.StoreCode,
            Common.WorkDate]);

  if (not Common.Query.Eof) and (Common.Query.Fields[0].AsString <> Common.Config.PosNo) then
  begin
    Common.ErrBox(Common.Query.Fields[0].Asstring+#13+'포스의 마감이 되지 않았습니다.');
    Common.Query.Close;
    Exit;
  end;
  Result := True;
end;

procedure TCashierMgm_F.CloseButtonClick(Sender: TObject);
begin
  Common.HideWaitForm;
  Close;
end;

procedure TCashierMgm_F.CloseCancelButtonClick(Sender: TObject);
var vTemp :String;
begin
  if GetUserOption(5) = '0' then
  begin
    if GetOption(172) = '0' then
    begin
      Common.ErrBox('포스마감업무가 지정된 사용자만'+#13#13+'사용이 가능합니다');
      Exit;
    end
    else if not Common.CheckAuthority(5) then Exit;
  end;

  if not Common.AskBox('포스마감을 취소하시겠습니까?') then Exit;

  vTemp := Common.ShowNumberForm('패스워드를 입력하세요', 16);
  if vTemp = 'mrClose' then Exit;
  if Common.Config.UserPass <> vTemp then
  begin
    Common.ErrBox('패스워드가 올바르지 않습니다');
    Exit;
  end;

  OpenQuery('select max(YMD_CLOSE) '
           +'  from SL_POSCLOSE '
           +' where CD_STORE =:P0 '
           +'   and NO_POS   =:P1 ',
           [Common.Config.StoreCode,
            Common.Config.PosNo]);

  vTemp := Common.Query.Fields[0].AsString;

  if vTemp = '' then
  begin
    Common.ErrBox('마감된 일자가 없습니다');
    Exit;
  end;

  if not Common.AskBox('최종마감된 일자가 '+vTemp+ ' 입니다'+#13#13+
                       '마감을 취소하시겠습니까?') then Exit;
  try
    Common.BeginTran;
    DM.StoredProc.StoredProcName := 'POS_SAVE_POS_MGM';
    DM.StoredProc.PrepareSQL;
    with DM.StoredProc do
    begin
      Close;
      ParamByName('_cd_store').Value    := Common.Config.StoreCode;
      ParamByName('_ymd_close').Value   := vTemp;
      ParamByName('_no_pos').Value      := Common.Config.PosNo;
      ParamByName('_work_kind').Value   := 'X';
      ExecProc;

      if ParamByName('_result').Value = 'Y' then
        raise Exception.Create('후방에서 일마감이 완료됐습니다')
      else if ParamByName('_result').Value = 'X' then
        raise Exception.Create('포스마감이 안된 일자입니다')
      else if ParamByName('_result').Value = 'M' then
        raise Exception.Create(vTemp+'일자 이후에 매출 또는 개점된'+#13#13+'내역이 있으면 마감을 취소할수 없습니다');
      Common.LastCloseDate := ParamByName('_ymd_last').Value;

      if (GetHeadOption(9) = '1') and (Common.Config.MainPosNo = Common.Config.PosNo) then
      begin
        OpenQuery('select NM_CODE1 '
                 +'  from MS_CODE '
                 +' where CD_STORE =:P0 '
                 +'   and CD_KIND  =''01'' '
                 +'   and NM_CODE3 = ''7'' '
                 +' limit 1 ',
                 [Common.Config.StoreCode]);
        if not Common.Query.Eof then
        begin
          ParamByName('_cd_store').Value    := Common.Config.StoreCode;
          ParamByName('_ymd_close').Value   := vTemp;
          ParamByName('_no_pos').Value      :=  Common.Query.Fields[0].AsString;
          ParamByName('_work_kind').Value   := 'X';
          ExecProc;
        end;
        Common.Query.Close;
      end;
    end;
    Common.CommitTran;

    Common.WorkDate := vTemp;
    Common.OpenDate := vTemp;
    FStatus         := 'O';
    FormShow(nil);
    if Common.WorkDate <> '' then
    begin
      Common.MsgBox('마감이 취소되었습니다'+#13#13+'매출일자가 '+vTemp+'일로 변경되었습니다');
      Common.PosType  := ptAccount;
    end
    else
    begin
      Common.MsgBox('마감이 취소되었습니다');
      Common.PosType  := ptNotAccount;
    end;
  except
    on E : Exception do
    begin
      Common.RollbackTran;
      Common.ErrBox(E.Message);
      Exit;
    end;
  end;
  DM.StoredProc.Close;
  Close;
end;

procedure TCashierMgm_F._CheckAmtEditExit(Sender: TObject);
begin
  if Sender = _50000Edit then
    _50000AmtEdit.Value := _50000Edit.Value * 50000
  else if Sender = _10000Edit then
    _10000AmtEdit.Value := _10000Edit.Value * 10000
  else if Sender = _10000Edit then
    _5000AmtEdit.Value := _5000Edit.Value * 5000
  else if Sender = _10000Edit then
    _1000AmtEdit.Value := _1000Edit.Value * 1000
  else if Sender = _500Edit then
    _500AmtEdit.Value := _500Edit.Value * 500
  else if Sender = _100Edit then
    _100AmtEdit.Value := _100Edit.Value * 100
  else if Sender = _50Edit then
    _50AmtEdit.Value := _50Edit.Value * 50
  else if Sender = _10Edit then
    _10AmtEdit.Value := _10Edit.Value * 10;
  CashCompute;
end;

procedure TCashierMgm_F._CheckAmtEditKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Char(Ord(VK_RETURN))) or (Key = Char(Ord(VK_ESCAPE))) then
    Key := #0;
end;

procedure TCashierMgm_F._CheckAmtEditPropertiesChange(Sender: TObject);
begin
  if Sender = _50000Edit then
    _50000AmtEdit.Value := _50000Edit.EditingValue * 50000
  else if Sender = _10000Edit then
    _10000AmtEdit.Value := _10000Edit.EditingValue * 10000
  else if Sender = _10000Edit then
    _5000AmtEdit.Value := _5000Edit.EditingValue * 5000
  else if Sender = _10000Edit then
    _1000AmtEdit.Value := _1000Edit.EditingValue * 1000
  else if Sender = _500Edit then
    _500AmtEdit.Value := _500Edit.EditingValue * 500
  else if Sender = _100Edit then
    _100AmtEdit.Value := _100Edit.EditingValue * 100
  else if Sender = _50Edit then
    _50AmtEdit.Value := _50Edit.EditingValue * 50
  else if Sender = _10Edit then
    _10AmtEdit.Value := _10Edit.EditingValue * 10;
  CashCompute;
end;

procedure TCashierMgm_F.PosCloseButtonClick(Sender: TObject);
  function GetHoldCount: Integer;
  begin
    Result := 0;
    if not Common.Config.IsTakeOut then Exit;
    //보류건수 count
    OpenQuery('select count(*) CNT '
             +'  from SL_HOLD_H '
             +' where CD_STORE =:P0 '
             +'   and NO_POS   =:P1 '
             +'   and YN_RESTORE = ''N'' ',
             [Common.Config.StoreCode,
              Common.Config.PosNo]);
    Result := Common.Query.FieldbyName('Cnt').AsInteger;
    Common.Query.Close;
  end;
var BillClear,
    BackupFileName :String;
    I :Integer;
    vResult : Boolean;
    vTemp   : String;
    vCount  : Integer;
    vRet    : Integer;
    vFiles  : TSearchRec;
    vLogPath : String;
    vGetTime :Cardinal;
    vLetsOrderPosNo:String;
label Loop;
begin
  if (Sender <> nil) and (MilliSecondsBetween(Now(),ClickTime) < 1500) then Exit;
  ClickTime := Now;

  try
    if not Common.IsDebugMode then
      BlockInput(true);

    if not Common.Config.IsKiosk then
    begin
      if GetOption(29) = '1' then
      begin
        vTemp := Common.ShowNumberForm('패스워드를 입력하세요', 16);
        if vTemp = 'mrClose' then Exit;

        if Common.Config.UserPass <> vTemp then
        begin
          Common.ErrBox('패스워드가 올바르지 않습니다');
          Exit;
        end;
      end;

      //마감시 패스워드를
      if (GetOption(29) = '2') and (Common.Config.ClosePass <> EmptyStr) then
      begin
        vTemp := Common.ShowNumberForm('패스워드를 입력하세요', 16);
        if vTemp = 'mrClose' then Exit;

        if Common.Config.ClosePass <> vTemp then
        begin
          Common.ErrBox('패스워드가 올바르지 않습니다');
          Exit;
        end;
      end;

      OpenQuery('select count(*) '
               +'  from SL_ORDER_H '
               +' where CD_STORE =:P0',
               [Common.Config.StoreCode]);
      if Common.Query.Fields[0].AsInteger > 0 then
      begin
        if not Common.AskBox('주문 중 인 테이블이 있습니다'+#13#13+'마감 하시겠습니까?') then Exit;
      end;
      Common.Query.Close;
    end
    else
    begin
      if GetOption(416) = '2' then
      begin
        Common.ErrBox('메인포스 마감시 같이 자동마감됩니다');
        Exit;
      end;
    end;

    DM.StoredProc.StoredProcName := 'POS_SELECT_POS_MGM';
    DM.StoredProc.PrepareSQL;
    with DM.StoredProc, Common.Magam do
    begin
      Close;
      ParamByName('_CD_STORE').Value       := Common.Config.StoreCode;
      ParamByName('_YMD_CLOSE').Value      := Common.WorkDate;
      ParamByName('_NO_POS').Value         := Common.Config.PosNo;
      ExecProc;

      amt_sale             :=  ParamByName('_AMT_SALE').Value;
      amt_tax              :=  ParamByName('_AMT_TAX').Value;
      amt_cash             :=  ParamByName('_AMT_CASH').Value;
      cnt_card             :=  ParamByName('_CNT_CARD').Value;
      amt_card             :=  ParamByName('_AMT_CARD').Value;
      amt_trust            :=  ParamByName('_AMT_TRUST').Value;
      amt_check            :=  ParamByName('_AMT_CHECK').Value;
      amt_gift             :=  ParamByName('_AMT_GIFT').Value;
      amt_bank             :=  ParamByName('_AMT_BANK').Value;
      amt_point            :=  ParamByName('_AMT_POINT').Value;
      amt_etc              :=  ParamByName('_AMT_ETC').Value;
      amt_letsorder        :=  ParamByName('_AMT_LETSORDER').Value;
      amt_cashtip          :=  ParamByName('_AMT_TIP').Value;
      amt_cardtip          :=  0; //ParamByName('AMT_TIP').Value에 카드봉사료도 포함되 있음
      amt_service          :=  ParamByName('_AMT_SERVICE').Value;
      dc_tot               :=  ParamByName('_DC_TOTAL').Value;
      cnt_cashier          :=  ParamByName('_CNT_CASHIER').Value;
      cnt_customer         :=  ParamByName('_CNT_CUSTOMER').Value;
      amt_void             :=  ParamByName('_AMT_VOID').Value;
      amt_lack             :=  ParamByName('_AMT_LACK').Value;
      amt_cashrcp          :=  ParamByName('_AMT_CASHRCP').Value;
      FStatus              :=  ParamByName('_DS_STATUS').Value;
      FNotClose            :=  ParamByName('_NOT_CLOSE').Value;
      Close;
    end;

    if FStatus = 'C' then
    begin
      Common.ErrBox('이미 포스마감이 완료됐습니다');
      Exit;
    end;

    if Common.WorkDate = '' then
    begin
      Common.ErrBox('개점이 안됐습니다');
      Exit;
    end;

    if FNotClose <> 'X' then
    begin
      Common.ErrBox(FNotClose+' 계산원이 마감되지 않았습니다'+#13#13+
                              '계산원마감을 먼저 해야합니다');
      Exit;
    end;

    if Common.Magam.cnt_cashier = 0 then
    begin
      if not Common.AskBox('마감된 계산원이 없습니다'+#13#13+'계속 하시겠습니까?') then Exit;
      BlockInput(true);
    end;


    if GetHoldCount > 0 then
    begin
      if not Common.AskBox('보류내역이 있습니다'+#13#13+'계속 하시겠습니까?') then Exit;
      BlockInput(true);
    end;

    BillClear := '1';
    if Common.Config.MainPosNo = Common.Config.PosNo then
    begin
      if not CheckPosClose then Exit;

      //메인포스 마감시 주문번호 초기화를 한다고 체크하지 않았을때는 마감할때 물어본다
      if GetOption(43) = '0' then
      begin
        if Common.AskBox('주문번호를 초기화 하시겠습니까?') then
          BillClear := '0'
      end
      else BillClear := '0';
      BlockInput(true);

      if GetOption(200) = '1' then
        ExecQuery('delete from SL_WAIT '
                 +' where CD_STORE =:P0',
                 [Common.Config.StoreCode]);

    end;
    Common.ShowWaitForm;
    try
      Common.BeginTran;

      DM.StoredProc.StoredProcName := 'POS_SAVE_POS_MGM';
      DM.StoredProc.PrepareSQL;
      with DM.StoredProc do
      begin
        Close;
        ParamByName('_cd_store').Value       := Common.Config.StoreCode;
        ParamByName('_ymd_close').Value      := Common.WorkDate;
        ParamByName('_no_pos').Value         := Common.Config.PosNo;
        ParamByName('_ds_orderno').Value     := BillClear;
        ParamByName('_work_kind').Value      := 'C';
        ExecProc;
      end;

      if BillClear = '0' then
        ExecQuery('delete '
                 +'  from MS_ORDERNO '
                 +' where CD_STORE =:P0 '
                 +'   and DS_NUMBER =''O'' '
                 +'   and NO_POS    =''00'' ',
                 [Common.Config.StoreCode]);

      //주문/배달상태를 계산완료로 수정한다                               //그룻회수기능을 사용하지 않을때
      if (Common.Config.MainPosNo = Common.Config.PosNo) and (GetOption(284) = '1') and (GetOption(56) = '0') then
      begin
        ExecQuery('update SL_DELIVERY set DS_STEP=''A'' where CD_STORE =:P0 and DS_STEP in (''O'',''D'')', [Common.Config.StoreCode]);
        ExecQuery('delete from SL_ORDER_H   where CD_STORE =:P0 and DS_ORDER =''D''', [Common.Config.StoreCode]);
        ExecQuery('delete from SL_ORDER_D   where CD_STORE =:P0 and DS_ORDER =''D''', [Common.Config.StoreCode]);
        ExecQuery('delete from SL_ORDER_C   where CD_STORE =:P0 and DS_ORDER =''D''', [Common.Config.StoreCode]);
        ExecQuery('delete from SL_ORDER_PRT where CD_STORE =:P0 and DS_ORDER =''D''', [Common.Config.StoreCode]);
      end;

      Common.CommitTran;
      Common.WriteLog('work','포스마감 ['+Common.Config.PosNo+']');

      if (Common.Config.MainPosNo = Common.Config.PosNo) then
      begin
        //메인포스 마감시 키오스크도 자동마감 시
        if GetOption(416) = '2' then
        begin
          Common.MsgBox('키오스크도 마감됩니다'#13'키오스를 모두 종료해주세요');
          OpenQuery('select NM_CODE1 '
                   +'  from MS_CODE '
                   +' where CD_STORE =:P0 '
                   +'   and CD_KIND  =''01'' '
                   +'   and NM_CODE3 = ''2'' ',
                   [Common.Config.StoreCode]);
          while not Common.Query.Eof do
          begin
            DM.StoredProc.StoredProcName := 'POS_SAVE_AUTO_CLOSE';
            DM.StoredProc.PrepareSQL;
            DM.StoredProc.ParamByName('_CD_STORE').Value  := Common.Config.StoreCode;
            DM.StoredProc.ParamByName('_NO_POS').Value    := Common.Query.Fields[0].AsString;
            DM.StoredProc.ParamByName('_YMD_CLOSE').Value := Common.WorkDate;
            DM.StoredProc.ExecProc;
            vTemp := DM.StoredProc.ParamByName('_RESULT').Value;
            if vTemp = 'OK' then
              Common.WriteLog('work','키오스크 마감 ['+Common.Query.Fields[0].AsString+']')
            else
              Common.WriteLog('work','키오스크 마감 오류 ['+vTemp+']');
            Common.Query.Next;
          end;
          Common.Query.Close;
        end;


        //렛츠오더 선불제 사용시 주문전용이 아니면 마감
        if (GetHeadOption(9) = '1') and (GetOption(94) <> '3') then
        begin
          OpenQuery('select NM_CODE1 '
                   +'  from MS_CODE '
                   +' where CD_STORE =:P0 '
                   +'   and CD_KIND  =''01'' '
                   +'   and NM_CODE3 = ''7'' ',
                   [Common.Config.StoreCode]);
          if not Common.Query.Eof then
          begin
            DM.StoredProc.StoredProcName := 'POS_SAVE_AUTO_CLOSE';
            DM.StoredProc.PrepareSQL;
            DM.StoredProc.ParamByName('_CD_STORE').Value  := Common.Config.StoreCode;
            DM.StoredProc.ParamByName('_NO_POS').Value    := Common.Query.Fields[0].AsString;
            DM.StoredProc.ParamByName('_YMD_CLOSE').Value := Common.WorkDate;
            DM.StoredProc.ExecProc;
            vTemp := DM.StoredProc.ParamByName('_RESULT').Value;
            if vTemp = 'OK' then
              Common.WriteLog('work','렛츠오더 마감 ['+Common.Query.Fields[0].AsString+']')
            else
              Common.WriteLog('work','렛츠오더 마감 오류 ['+vTemp+']');
          end;
          Common.Query.Close;
        end;

        OpenQuery('select Sum(AMT_SALE), '
                 +'       Sum(AMT_CASH), '
                 +'       Sum(AMT_CARD), '
                 +'       Sum(CNT_CARD), '
                 +'       Sum(AMT_CASHRCP), '
                 +'       Sum(CNT_CUSTOMER), '
                 +'       Sum(AMT_VOID), '
                 +'       (select Count(*) from SL_SALE_H  where CD_STORE =:P0 and YMD_SALE =:P1 and DS_SALE = ''V'') as CNT_VOID, '
                 +'       (select Count(*) from SL_SALE_C  where CD_STORE =:P0 and YMD_SALE =:P1 and ifnull(DT_ORDER,'''') <> '''') as CNT_CANCEL '
                 +'  from SL_POSCLOSE  '
                 +' where CD_STORE  =:P0 '
                 +'   and YMD_CLOSE =:P1',
                 [Common.Config.StoreCode,
                  Common.WorkDate]);
        //문자발송                                   cust_id, ymd_close, amt_sale, amt_cash, amt_card, cnt_card, amt_cashrcp, cnt_customer
        if (GetOption(139) = '1') then
          For I := 0 to Common.Config.StoreMobile.Count -1 do
          begin
            if Common.Config.StoreMobile[I] = '' then Continue;

            Loop:
            vResult := Common.KakaoSendMessage('P',['포스마감내역'#13#13+Format('매출:%s 현금:%s 카드:%s 매출취소:%s(%d건) 주문취소:%d건[%s]',[FormatFloat('#,0', Common.Query.Fields[0].AsInteger),
                                                                                                                       FormatFloat('#,0', Common.Query.Fields[1].AsInteger),
                                                                                                                       FormatFloat('#,0', Common.Query.Fields[2].AsInteger),
                                                                                                                       FormatFloat('#,0', Common.Query.Fields[6].AsInteger),
                                                                                                                       Common.Query.Fields[7].AsInteger,
                                                                                                                       Common.Query.Fields[8].AsInteger,
                                                                                                                       FormatDateTime('hh:nn', now())])],
                                                Common.Config.StoreMobile[I]);

            if not vResult and Common.AskBox('마감문자를 발송하지 못했습니다'+#13+'다시 시도하시겠습니까?') then
              Goto Loop;
          end;
        Common.Query.Close;
      end;

      Common.TRSendMessage;
      Common.HideWaitForm;
    Except
      on E : Exception do
      begin
        Common.HideWaitForm;
        Common.RollbackTran;
        Common.WriteLog('PosClose001',E.Message);
        Common.ErrBox(E.Message+#13#13+'포스마감을 완료하지 못했습니다');
        Exit;
      end;
    end;

    Common.Device.PosClosePrint;

    if Common.Config.MainPosNo = Common.Config.PosNo  then
    begin
       OpenQuery('select Count(no_pos)     as CNT, '
                +'       Sum(AMT_SALE)     as AMT_SALE, '
                +'       Sum(AMT_SERVICE)  as AMT_SERVICE, '
                +'       Sum(AMT_TIP)      as AMT_TIP, '
                +'       Sum(AMT_TAX)      as AMT_TAX, '
                +'       Sum(AMT_CASH)     as AMT_CASH, '
                +'       Sum(AMT_CARD)     as AMT_CARD, '
                +'       Sum(AMT_CHECK)    as AMT_CHECK, '
                +'       Sum(AMT_TRUST)    as AMT_TRUST, '
                +'       Sum(AMT_GIFT)     as AMT_GIFT, '
                +'       Sum(AMT_BANK)     as AMT_BANK, '
                +'       Sum(AMT_ETC)      as AMT_ETC, '
                +'       Sum(AMT_LETSORDER) as AMT_LETSORDER, '
                +'       Sum(AMT_POINT)    as AMT_POINT,'
                +'       Sum(CNT_CUSTOMER) as CNT_CUSTOMER, '
                +'       Sum(AMT_VOID)     as AMT_VOID, '
                +'       Sum(AMT_CASHRCP)  as AMT_CASHRCP, '
                +'       Sum(AMT_LACK)     as AMT_LACK, '
                +'       Sum(CNT_CARD)     as CNT_CARD, '
                +'       Sum(DC_MENU+DC_RECEIPT+DC_VAT+DC_MEMBER+DC_CODE+DC_SPC+DC_EVENT+DC_CUT+DC_POINT+DC_KAKAO+DC_COUPON+DC_TAXFREE+DC_STAMP+DC_LETSORDER) as AMT_DC '
                +'  from SL_POSCLOSE '
                +' where DS_STATUS = ''C'' '
                +'   and CD_STORE  =:P0 '
                +'   and YMD_CLOSE =:P1 ',
                [Common.Config.StoreCode,
                 Common.WorkDate]);

       if (Common.Query.FieldByName('cnt').AsInteger > 1) and (Common.AskBox('총괄정산서를 출력하시겠습니까?')) then
       begin
         InitMagamRecord(Common.Magam);
         Common.Magam.amt_sale             :=  Common.Query.FieldByName('amt_sale').AsInteger;
         Common.Magam.amt_tax              :=  Common.Query.FieldByName('amt_tax').AsInteger;
         Common.Magam.amt_cash             :=  Common.Query.FieldByName('amt_cash').AsInteger;
         Common.Magam.cnt_card             :=  Common.Query.FieldByName('cnt_card').AsInteger;
         Common.Magam.amt_card             :=  Common.Query.FieldByName('amt_card').AsInteger;
         Common.Magam.amt_trust            :=  Common.Query.FieldByName('amt_trust').AsInteger;
         Common.Magam.amt_check            :=  Common.Query.FieldByName('amt_check').AsInteger;
         Common.Magam.amt_gift             :=  Common.Query.FieldByName('amt_gift').AsInteger;
         Common.Magam.amt_bank             :=  Common.Query.FieldByName('amt_bank').AsInteger;
         Common.Magam.amt_point            :=  Common.Query.FieldByName('amt_point').AsInteger;
         Common.Magam.amt_etc              :=  Common.Query.FieldByName('amt_etc').AsInteger;
         Common.Magam.amt_letsorder        :=  Common.Query.FieldByName('amt_letsorder').AsInteger;
         Common.Magam.amt_cashtip          :=  Common.Query.FieldByName('amt_tip').AsInteger;
         Common.Magam.amt_service          :=  Common.Query.FieldByName('amt_service').AsInteger;
         Common.Magam.dc_tot               :=  Common.Query.FieldByName('amt_dc').AsInteger;
         Common.Magam.cnt_customer         :=  Common.Query.FieldByName('cnt_customer').AsInteger;
         Common.Magam.amt_void             :=  Common.Query.FieldByName('amt_void').AsInteger;
         Common.Magam.amt_lack             :=  Common.Query.FieldByName('amt_lack').AsInteger;
         Common.Magam.amt_cashrcp          :=  Common.Query.FieldByName('amt_cashrcp').AsInteger;
         Common.Device.PosClosePrint(1);
       end;
       Common.Query.Close;
    end;

    ExecQuery('delete from SL_DELIVERY '
             +' where CD_STORE =:P0 '
             +'   and ((DS_STEP  = ''N'') or (ifnull(YMD_DELIVERY,'''') ='''') ) ',
             [Common.Config.StoreCode]);

    Common.MsgBox('포스마감이 완료됐습니다');
    Common.TRSendMessage('CLOSE');
    Common.PosType       := ptNotAccount;

    //3개월이 지난 로그화일은 삭제한다
    try
      vLogPath := Common.AppPath+'Log\CardLog\'+Common.Config.van_Terid;
      vRet := FindFirst(vLogPath+'*.log',faAnyfile, vFiles);
      while vRet = 0 do
      begin
        if IsDate(LeftStr(vFiles.Name,8)) and (MonthsBetween(Now(), StrToDate(FormatMaskText('0000-90-90;0;', LeftStr(vFiles.Name,8)))) >= 3) then
        begin
          if FileExists(vLogPath+vFiles.Name) then
            DeleteFile(vLogPath+vFiles.Name);
        end;
        vRet := FindNext(vFiles);
      end;
    except
    end;

    Screen.Cursor  := crDefault;

    Common.LastCloseDate := Common.WorkDate;
    Common.WorkDate      := '';
    Common.OpenDate      := '';
    with TIniFile.Create(Common.AppPath+_INIFILENAME) do
     try
       vTemp := ReadString('POS', '포스마감후실행','');
       if vTemp <> EmptyStr then
       begin
         vTemp := Common.AppPath+vTemp;
         WinExec(PAnsiChar(vTemp),SW_SHOW);
       end;
     finally
       free;
     end;
  finally
    BlockInput(false);
  end;
  Close;
end;

procedure TCashierMgm_F.ReprintButtonClick(Sender: TObject);
begin
  MagamRePrint_F := TMagamRePrint_F.Create(Self);
  try
    MagamRePrint_F.ShowModal;
  finally
    FreeAndNil(MagamRePrint_F);
  end;
  FormShow(nil);
end;


end.


