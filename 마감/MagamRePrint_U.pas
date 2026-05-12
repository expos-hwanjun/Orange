unit MagamRePrint_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, StrUtils, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.ComCtrls, dxCore, cxDateUtils,
  Vcl.Menus, cxButtons, cxLabel, Vcl.WinXCalendars,
  dxGDIPlusClasses, Vcl.ExtCtrls, AdvGlowButton, AdvBadge, AdvGlassButton,
  AdvSmoothToggleButton;

type
  TMagamRePrint_F = class(TForm)
    Image1: TImage;
    CloseDatePicker: TCalendarPicker;
    cxLabel3: TcxLabel;
    Image4: TImage;
    Label1: TLabel;
    CloseButton: TcxButton;
    TitleLabel: TLabel;
    PosButton: TAdvGlassButton;
    Cashier1Button: TAdvSmoothToggleButton;
    Cashier2Button: TAdvSmoothToggleButton;
    Cashier3Button: TAdvSmoothToggleButton;
    Cashier4Button: TAdvSmoothToggleButton;
    Cashier5Button: TAdvSmoothToggleButton;
    Cashier6Button: TAdvSmoothToggleButton;
    Cashier7Button: TAdvSmoothToggleButton;
    Cashier8Button: TAdvSmoothToggleButton;
    procedure FormCreate(Sender: TObject);
    procedure Cashier1ButtonClick(Sender: TObject);
    procedure PosButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure CloseDatePickerChange(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  MagamRePrint_F: TMagamRePrint_F;

implementation
uses Common_U, GlobalFunc_U;
{$R *.dfm}

procedure TMagamRePrint_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
  CloseDatePicker.Date := now();
  Common.SetLanguage(Self);
end;

procedure TMagamRePrint_F.Cashier1ButtonClick(Sender: TObject);
var vSaleDate,
    vUserCode,
    vUserName :String;
    vOption74 :String;
begin
  OpenQuery('select a.*, '
           +'       b.NM_SAWON '
           +'  from SL_CASHIER_MGM a inner join '
           +'       MS_SAWON       b on a.CD_STORE =b.CD_STORE and a.CD_SAWON = b.CD_SAWON '
           +' where a.CD_STORE  =:P0 '
           +'   and a.YMD_CLOSE =:P1 '
           +'   and a.NO_POS    =:P2 '
           +'   and a.CD_SAWON  =:P3 '
           +'   and a.SEQ       =:P4',
            [Common.Config.StoreCode,
             DtoS(CloseDatePicker.Date),
             Common.Config.PosNo,
             (Sender as TAdvSmoothToggleButton).Hint,
             (Sender as TAdvSmoothToggleButton).Tag]);
  with Common.Magam,Common.Query do
  begin
    amt_tax        :=  FieldByName('AMT_TAX').AsInteger;
    amt_ready      :=  FieldByName('AMT_READY').AsInteger;
    amt_deposit    :=  FieldByName('AMT_MID').AsInteger;
    amt_acct_cash  :=  FieldByName('AMT_ACCT_CASH').AsInteger;
    amt_acct_card  :=  FieldByName('AMT_ACCT_CARD').AsInteger;
    amt_acct_out   :=  FieldByName('AMT_ACCT_OUT').AsInteger;
    amt_sale       :=  FieldByName('AMT_SALE').AsInteger;
    amt_letsorder  :=  FieldByName('AMT_LETSORDER').AsInteger;
    amt_cash       :=  FieldByName('AMT_CASH').AsInteger;
    cnt_card       :=  FieldByName('CNT_CARD').AsInteger;
    amt_card       :=  FieldByName('AMT_CARD').AsInteger;
    amt_trust      :=  FieldByName('AMT_TRUST').AsInteger;
    amt_check      :=  FieldByName('AMT_CHECK').AsInteger;
    amt_gift       :=  FieldByName('AMT_GIFT').AsInteger;
    amt_bank       :=  FieldByName('AMT_BANK').AsInteger;
    amt_etc        :=  FieldByName('AMT_ETC').AsInteger;
    amt_point      :=  FieldByName('AMT_POINT').AsInteger;
    amt_cashtip    :=  FieldByName('AMT_CASHTIP').AsInteger;
    amt_cardtip    :=  FieldByName('AMT_CARDTIP').AsInteger;
    amt_service    :=  FieldByName('AMT_SERVICE').AsInteger;
    dc_menu        :=  FieldByName('DC_MENU').AsInteger;
    dc_member      :=  FieldByName('DC_MEMBER').AsInteger;
    dc_code        :=  FieldByName('DC_CODE').AsInteger;
    dc_receipt     :=  FieldByName('DC_RECEIPT').AsInteger;
    dc_spc         :=  FieldByName('DC_SPC').AsInteger;
    dc_event       :=  FieldByName('DC_EVENT').AsInteger;
    dc_cut         :=  FieldByName('DC_CUT').AsInteger;
    dc_vat         :=  FieldByName('DC_VAT').AsInteger;
    dc_point       :=  FieldByName('DC_POINT').AsInteger;
    dc_taxfree     :=  FieldByName('DC_TAXFREE').AsInteger;
    dc_uplus       :=  FieldByName('DC_UPLUS').AsInteger;
    dc_kakao       :=  FieldByName('DC_KAKAO').AsInteger;
    dc_tot         :=  dc_menu + dc_member + dc_code + dc_receipt + + dc_spc + dc_event + dc_cut + dc_vat + dc_point + dc_taxfree + dc_uplus + dc_kakao;
    cnt_customer   :=  FieldByName('CNT_CUSTOMER').AsInteger;
    amt_average    :=  FieldByName('AMT_AVERAGE').AsInteger;
    amt_banpum     :=  FieldByName('AMT_BANPUM').AsInteger;
    cnt_void       :=  FieldByName('CNT_VOID').AsInteger;
    amt_void       :=  FieldByName('AMT_VOID').AsInteger;
    amt_cashrcp    :=  FieldByName('AMT_CASHRCP').AsInteger;
    amt_present    :=  amt_ready - amt_deposit + amt_acct_cash - amt_acct_out + amt_cash + amt_check + amt_cashtip;
    rcp_begin      :=  FieldByName('RCP_BEGIN').AsString;
    rcp_end        :=  FieldByName('RCP_END').AsString;
    _Check         :=  FieldByName('_CHECK').AsInteger;
    _50000         :=  FieldByName('_50000').AsInteger;
    _10000         :=  FieldByName('_10000').AsInteger;
    _5000          :=  FieldByName('_5000').AsInteger;
    _1000          :=  FieldByName('_1000').AsInteger;
    _500           :=  FieldByName('_500').AsInteger;
    _100           :=  FieldByName('_100').AsInteger;
    _50            :=  FieldByName('_50').AsInteger;
    _10            :=  FieldByName('_10').AsInteger;
    amt_lack       :=  FieldByName('AMT_LACK').AsInteger;

    try
      vSaleDate := Common.WorkDate;
      vUserCode := Common.Config.UserCode;
      vUserName := Common.Config.UserName;
      Common.WorkDate := DtoS(CloseDatePicker.Date);
      Common.Config.UserCode := FieldByName('CD_SAWON').AsString;
      Common.Config.UserName := FieldByName('NM_SAWON').AsString;
      vOption74 := '';
      if GetOption(74) = '0' then
      begin
        vOption74 := GetOption(74);
        Common.Config.Options[74] := '1';
      end;
      Common.Device.CashierClosePrint(IntToStr((Sender as TAdvSmoothToggleButton).Tag));
    finally
      if vOption74 <> '' then
        Common.Config.Options[74] := vOption74[1];

      Common.WorkDate := vSaleDate;
      Common.Config.UserCode := vUserCode;
      Common.Config.UserName := vUserName;
    end;
  end;
end;

procedure TMagamRePrint_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;


procedure TMagamRePrint_F.CloseDatePickerChange(Sender: TObject);
var vIndex :Integer;
begin
  For vIndex := 1 to 8 do
     TAdvSmoothToggleButton(FindComponent(Format('Cashier%dButton',[vIndex]))).Visible := False;

  OpenQuery('select a.CD_SAWON, '
           +'       b.NM_SAWON, '
           +'       Date_Format(a.DT_CHANGE, ''%Y-%m-%d %H:%i'') as DT_CHANGE, '
           +'       a.SEQ '
           +'  from SL_CASHIER_MGM a left outer join '
           +'       MS_SAWON       b on a.CD_STORE = b.CD_STORE and a.CD_SAWON = b.CD_SAWON '
           +' where a.CD_STORE  =:P0 '
           +'   and a.YMD_CLOSE =:P1 '
           +'   and a.NO_POS    =:P2 '
           +'   and a.YN_CLOSE = ''Y'' '
           +' order by a.DT_CHANGE '
           +' limit 8 ',
           [Common.Config.StoreCode,
            DtoS(CloseDatePicker.Date),
            Common.Config.PosNo]);

  vIndex := 1;
  while not Common.Query.Eof do
  begin
    TAdvSmoothToggleButton(FindComponent(Format('Cashier%dButton',[vIndex]))).Visible := True;
    TAdvSmoothToggleButton(FindComponent(Format('Cashier%dButton',[vIndex]))).Status.Caption  := Common.Query.FieldByName('nm_sawon').AsString;
    TAdvSmoothToggleButton(FindComponent(Format('Cashier%dButton',[vIndex]))).Caption := Common.Query.FieldByName('dt_change').AsString;
    TAdvSmoothToggleButton(FindComponent(Format('Cashier%dButton',[vIndex]))).Hint    := Common.Query.FieldByName('cd_sawon').AsString;
    TAdvSmoothToggleButton(FindComponent(Format('Cashier%dButton',[vIndex]))).Tag     := Common.Query.FieldByName('seq').AsInteger;
    Common.Query.Next;
    Inc(vIndex);
  end;

  OpenQuery('select * '
           +'  from SL_POSCLOSE '
           +' where CD_STORE  =:P0 '
           +'   and YMD_CLOSE =:P1 '
           +'   and DS_STATUS =''C'' '
           +'   and NO_POS    =:P2',
           [Common.Config.StoreCode,
            DtoS(CloseDatePicker.Date),
            Common.Config.PosNo]);
  PosButton.Visible := not Common.Query.Eof;
end;

procedure TMagamRePrint_F.PosButtonClick(Sender: TObject);
var OrgSaleDate :String;
    vOption75 :String;
begin
  OpenQuery('select * '
           +'  from SL_POSCLOSE '
           +' where CD_STORE  =:P0 '
           +'   and YMD_CLOSE =:P1 '
           +'   and NO_POS    =:P2',
           [Common.Config.StoreCode,
            DtoS(CloseDatePicker.Date),
            Common.Config.PosNo]);
  with Common.Magam,Common.Query do
  begin
    amt_sale      :=  FieldByName('AMT_SALE').AsInteger;
    amt_tax       :=  FieldByName('AMT_TAX').AsInteger;
    amt_letsorder :=  FieldByName('AMT_LETSORDER').AsInteger;
    amt_cash      :=  FieldByName('AMT_CASH').AsInteger;
    cnt_card      :=  FieldByName('CNT_CARD').AsInteger;
    amt_card      :=  FieldByName('AMT_CARD').AsInteger;
    amt_trust     :=  FieldByName('AMT_TRUST').AsInteger;
    amt_check     :=  FieldByName('AMT_CHECK').AsInteger;
    amt_gift      :=  FieldByName('AMT_GIFT').AsInteger;
    amt_bank      :=  FieldByName('AMT_BANK').AsInteger;
    amt_etc       :=  FieldByName('AMT_ETC').AsInteger;
    amt_point     :=  FieldByName('AMT_POINT').AsInteger;
    amt_cashtip   :=  FieldByName('AMT_TIP').AsInteger;
    dc_tot        :=  FieldByName('DC_MENU').AsInteger
                    + FieldByName('DC_MEMBER').AsInteger
                    + FieldByName('DC_CODE').AsInteger
                    + FieldByName('DC_RECEIPT').AsInteger
                    + FieldByName('DC_SPC').AsInteger
                    + FieldByName('DC_EVENT').AsInteger
                    + FieldByName('DC_CUT').AsInteger
                    + FieldByName('DC_VAT').AsInteger
                    + FieldByName('DC_POINT').AsInteger
                    + FieldByName('DC_TAXFREE').AsInteger
                    + FieldByName('DC_UPLUS').AsInteger
                    + FieldByName('DC_KAKAO').AsInteger;
    cnt_cashier   :=  FieldByName('CNT_CASHIER').AsInteger;
    cnt_customer  :=  FieldByName('CNT_CUSTOMER').AsInteger;
    amt_void      :=  FieldByName('AMT_VOID').AsInteger;
    amt_lack      :=  FieldByName('AMT_LACK').AsInteger;
    amt_cashrcp   :=  FieldByName('AMT_CASHRCP').AsInteger;
    amt_service   :=  FieldByName('AMT_SERVICE').AsInteger;

    try
      OrgSaleDate := Common.WorkDate;
      Common.WorkDate := DtoS(CloseDatePicker.Date);
      vOption75 := '';
      if GetOption(75) = '0' then
      begin
        vOption75 := GetOption(75);
        Common.Config.Options[75] := '1';
      end;
      Common.Device.PosClosePrint;
      //ÃÑ°ý¸¶°¨Á¤»ê¼­ Ãâ·Â
      if Common.Config.MainPosNo = Common.Config.PosNo then
      begin
         OpenQuery('select count(NO_POS)      as CNT, '
                  +'       sum(AMT_SALE)      as AMT_SALE, '
                  +'       sum(AMT_LETSORDER) as AMT_LETSORDER, '
                  +'       sum(AMT_SERVICE)  as AMT_SERVICE, '
                  +'       sum(AMT_TIP)      as AMT_TIP, '
                  +'       sum(AMT_TAX)      as AMT_TAX, '
                  +'       sum(AMT_CASH)     as AMT_CASH, '
                  +'       sum(AMT_CARD)     as AMT_CARD, '
                  +'       sum(AMT_CHECK)    as AMT_CHECK, '
                  +'       sum(AMT_TRUST)    as AMT_TRUST, '
                  +'       sum(AMT_GIFT)     as AMT_GIFT, '
                  +'       sum(AMT_BANK)     as AMT_BANK, '
                  +'       sum(AMT_ETC)      as AMT_ETC, '
                  +'       sum(AMT_POINT)    as AMT_POINT,'
                  +'       sum(CNT_CUSTOMER) as CNT_CUSTOMER, '
                  +'       sum(AMT_VOID)     as AMT_VOID, '
                  +'       sum(AMT_CASHRCP)  as AMT_CASHRCP, '
                  +'       sum(AMT_LACK)     as AMT_LACK, '
                  +'       sum(CNT_CARD)     as CNT_CARD, '
                  +'       sum(DC_MENU+DC_RECEIPT+DC_VAT+DC_MEMBER+DC_CODE+DC_SPC+DC_EVENT+DC_CUT+DC_POINT+DC_TAXFREE+DC_UPLUS+DC_KAKAO) as AMT_DC '
                  +'  from SL_POSCLOSE '
                  +' where DS_STATUS = ''C'' '
                  +'   and CD_STORE  =:P0 '
                  +'   and YMD_CLOSE =:P1 ',
                  [Common.Config.StoreCode,
                   Common.WorkDate]);

         if Common.Query.FieldByName('CNT').AsInteger > 1 then
         begin
           InitMagamRecord(Common.Magam);
           Common.Magam.amt_sale     :=  Common.Query.FieldByName('AMT_SALE').AsInteger;
           Common.Magam.amt_letsorder  :=  Common.Query.FieldByName('AMT_LETSORDER').AsInteger;
           Common.Magam.amt_tax      :=  Common.Query.FieldByName('AMT_TAX').AsInteger;
           Common.Magam.amt_cash     :=  Common.Query.FieldByName('AMT_CASH').AsInteger;
           Common.Magam.cnt_card     :=  Common.Query.FieldByName('CNT_CARD').AsInteger;
           Common.Magam.amt_card     :=  Common.Query.FieldByName('AMT_CARD').AsInteger;
           Common.Magam.amt_trust    :=  Common.Query.FieldByName('AMT_TRUST').AsInteger;
           Common.Magam.amt_check    :=  Common.Query.FieldByName('AMT_CHECK').AsInteger;
           Common.Magam.amt_gift     :=  Common.Query.FieldByName('AMT_GIFT').AsInteger;
           Common.Magam.amt_bank     :=  Common.Query.FieldByName('AMT_BANK').AsInteger;
           Common.Magam.amt_etc      :=  Common.Query.FieldByName('AMT_ETC').AsInteger;
           Common.Magam.amt_point    :=  Common.Query.FieldByName('AMT_POINT').AsInteger;
           Common.Magam.amt_cashtip  :=  Common.Query.FieldByName('AMT_TIP').AsInteger;
           Common.Magam.amt_service  :=  Common.Query.FieldByName('AMT_SERVICE').AsInteger;
           Common.Magam.dc_tot       :=  Common.Query.FieldByName('AMT_DC').AsInteger;
           Common.Magam.cnt_customer :=  Common.Query.FieldByName('CNT_CUSTOMER').AsInteger;
           Common.Magam.amt_void     :=  Common.Query.FieldByName('AMT_VOID').AsInteger;
           Common.Magam.amt_lack     :=  Common.Query.FieldByName('AMT_LACK').AsInteger;
           Common.Magam.amt_cashrcp  :=  Common.Query.FieldByName('AMT_CASHRCP').AsInteger;
           Common.Device.PosClosePrint(1);
         end;
      end;
    finally
      Common.Query.Close;
      Common.WorkDate := OrgSaleDate;
      if vOption75 <> '' then
        Common.Config.Options[75] := vOption75[1];
    end;
  end;
end;

end.
