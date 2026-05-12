unit KioskCashReceiptBF_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, StdCtrls, AdvSmoothButton, cxLabel,
  ExtCtrls, StrUtils, MaskUtils, jpeg, PosCard, MMSystem, AdvSmoothToggleButton,
  Vcl.Buttons, dxGDIPlusClasses, cxClasses, AdvPanel;

type
  TKioskCashReceiptBF_F = class(TForm)
    OkButton: TAdvSmoothButton;
    CancelButton: TAdvSmoothToggleButton;
    Num9Button: TAdvSmoothToggleButton;
    Num6Button: TAdvSmoothToggleButton;
    Num3Button: TAdvSmoothToggleButton;
    ZeroButton: TAdvSmoothToggleButton;
    Num2Button: TAdvSmoothToggleButton;
    Num5Button: TAdvSmoothToggleButton;
    Num8Button: TAdvSmoothToggleButton;
    Num1Button: TAdvSmoothToggleButton;
    Num4Button: TAdvSmoothToggleButton;
    Num7Button: TAdvSmoothToggleButton;
    Zero3Button: TAdvSmoothToggleButton;
    AgreeButton: TAdvSmoothButton;
    AgreeLabel: TcxLabel;
    Shape1: TShape;
    KeyInLabel: TcxLabel;
    ClearButton: TAdvSmoothButton;
    ImageCollection: TcxImageCollection;
    ImageCollectionItem1: TcxImageCollectionItem;
    ImageCollectionItem2: TcxImageCollectionItem;
    HeaderPanel: TAdvPanel;
    lblTitle: TcxLabel;
    BSButton: TAdvSmoothToggleButton;
    procedure Num1ButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure obtn_cardClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure BSButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure AgreeLabelClick(Sender: TObject);
  private
    FDecryptData  :String;
    FEMVCardData  :String;
    function  GetPhoneFormat(vStr :String):String;        //전화번호에 하이픈넣기
    function  ApprovalAction:Boolean;
  public
    { Public declarations }
  end;

var
  KioskCashReceiptBF_F: TKioskCashReceiptBF_F;

implementation
uses Common_U, GlobalFunc_U, Const_U, KioskCard_U;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TKioskCashReceiptBF_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,0);

  Self.Position := poDesigned;
  Self.ClientHeight   := 847;
  Self.ClientWidth    := 1000;
  Self.Top      := Common.Config.BarrierTop;
  Self.Left     := Screen.Width div 2 - Self.ClientWidth div 2;

  Common.SetButtonColor(OkButton);
  Common.SetKioskButton(OkButton);
  Common.SetKioskButton(CancelButton);
end;


procedure TKioskCashReceiptBF_F.Num1ButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave11');
  KeyInLabel.Hint    := KeyInLabel.Hint + (Sender as TAdvSmoothToggleButton).Caption;
  KeyInLabel.Caption := GetPhoneFormat(KeyInLabel.Hint);
end;

function TKioskCashReceiptBF_F.GetPhoneFormat(vStr: String): String;
var vTemp :String;
begin
  if AgreeButton.Tag = 0 then
  begin
    if Copy(vStr,1,1) <> '0' then
    begin
      Result := vStr;
      Exit;
    end;

    vTemp := vStr;
    case Length(vTemp) of
       4 : Result := FormatMaskText('!000-0;0; ',vTemp);
       5 : Result := FormatMaskText('!000-00;0; ',vTemp);
       6 : Result := FormatMaskText('!000-000;0; ',vTemp);
       7 : Result := FormatMaskText('!000-0000;0; ',vTemp);
       8 : Result := FormatMaskText('!000-0000-0;0; ',vTemp);
       9 : Result := FormatMaskText('!000-0000-00;0; ',vTemp);
      11 : Result := FormatMaskText('!000-0000-0000;0; ',vTemp);
      else Result := vStr;
    end;
  end
  else
  begin
    vTemp := vStr;
    case Length(vTemp) of
       4 : Result := FormatMaskText('!000-0;0; ',vTemp);
       5 : Result := FormatMaskText('!000-00;0; ',vTemp);
       6 : Result := FormatMaskText('!000-00-0;0; ',vTemp);
       7 : Result := FormatMaskText('!000-00-00;0; ',vTemp);
       8 : Result := FormatMaskText('!000-00-000;0; ',vTemp);
       9 : Result := FormatMaskText('!000-00-0000;0; ',vTemp);
      10 : Result := FormatMaskText('!000-00-00000;0; ',vTemp);
      else Result := vStr;
    end;
  end;
end;


procedure TKioskCashReceiptBF_F.OkButtonClick(Sender: TObject);
begin
  try
    BlockInput(true);

    Common.KioskTouchBeep('kioskwave12');
    if KeyInLabel.Caption = EmptyStr then
    begin
      Common.MsgBox('식별번호를 입력 후 입력완료 버튼을 누르세요');
      Exit;
    end;

    Common.CashRcp.Ds_Input   := 'K';
    Common.CashRcp.CardNoFull := GetOnlyNumber(KeyInLabel.Caption);
    //소득공제
    if AgreeButton.Tag = 0 then
    begin
      if Length(Common.CashRcp.CardNoFull) = 13 then
        Common.CashRcp.Ds_Type := '2' //주민번호
      else
        Common.CashRcp.Ds_Type := '1'; //주민번호
    end
    else
    begin
      if Length(Common.CashRcp.CardNoFull)=10 then
        Common.CashRcp.Ds_Type := '3'
      else
        Common.CashRcp.Ds_Type := '1';
    end;

    if ApprovalAction then
      ModalResult := mrOK;
  finally
    BlockInput(false);
  end;
end;

procedure TKioskCashReceiptBF_F.obtn_cardClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  Common.CashRcp.Ds_Input   := 'S';
  Common.CashRcp.Ds_Type    := '0'; //키드번호
  if ApprovalAction then
    ModalResult := mrOK;
end;


procedure TKioskCashReceiptBF_F.AgreeLabelClick(Sender: TObject);
begin
  if AgreeButton.Tag = 0 then
  begin
    AgreeButton.Tag := 1;
    AgreeButton.Picture.Assign(ImageCollection.Items[1].Picture.Graphic);
  end
  else
  begin
    AgreeButton.Tag := 0;
    AgreeButton.Picture.Assign(ImageCollection.Items[0].Picture.Graphic);
  end;
end;

function TKioskCashReceiptBF_F.ApprovalAction: Boolean;
begin
  BlockInput(true);
  try
    Result := false;
    Common.CashRcp.Ds_Trd     := dtApproval;
    Common.CashRcp.Ds_Kind    := IntToStr(AgreeButton.Tag);
    with Common.ICCard, Common do
    begin
      FocusHandle := Self.Handle;
      ClearAll;
      if GetOption(379) = '2' then
        AppType := atVCatCash
      else
        AppType      := atCash;
      case Config.van_trd of
        0 : VAN   := vtKOCES;
        1 : VAN   := vtDaou;
        2 : VAN   := vtNICE;
        3 : VAN   := vtKICC;
        4 : VAN   := vtKIS;
        5 : VAN   := vtKSNET;
        6 : VAN   := vtKCP;
        7 : VAN   := vtFDIK;
        8 : VAN   := vtJTNET;
        9 : VAN   := vtKFTC;
       10 : VAN   := vtSmartro;
       11 : VAN   := vtKOVAN;
       12 : VAN   := vtSPC;
      end;
      SaleAmt     := Common.PreSent.WRcvAmt;
      VatAmt      := Abs(Common.PreSent.TaxAmt);

      WorkDate    := Common.WorkDate;
      SaleDate    := FormatDateTime('yyyymmdd',Now());
      BizNo       := Config.BizNo;
      TerminalID  := Config.van_Terid;
      Host        := Config.van_ip;
      Port        := Config.van_port;
      SerialNo    := Config.SerialNo;
      LogPath     := Common.AppPath;
      PosNo       := Config.PosNo;
      Parent      := Self;
      Approval    := CashRcp.Ds_trd     = dtApproval;
      CatPort     := StoI(Common.Config.ReceiptPrinterPort);
      RealMode    := True;
      KeyIn       := CashRcp.Ds_Input   = 'K';
      HalbuMonth  := StoI(CashRcp.Ds_Kind);
      CardTrack2  := Common.CashRcp.CardNoFull;
      if Execute then
      begin
        CashRcp.CardNo        := Replace(KeyInLabel.Caption,'-','');
        CashRcp.No_Approval   := AgreeNo;        // 승인번호
        CashRcp.Amt_Approval  := AgreeAmt;       // 승인금액
        CashRcp.trd_date      := SaleDate;
        CashRcp.trd_date_org  := OrgSaleDate;
        CashRcp.Approval_org  := OrgAgreeNo;
        CashRcp.VatAmt        := VatAmt;
        PreSent.CashRcpAmt    := CashRcp.Amt_Approval;
        CashRcpInfoSave;
        Result := true;
      end
      else
      begin
        Common.MsgBox('[승인실패]'+#13+Note);
      end;
    end;
  finally
    BlockInput(false);
  end;
end;

procedure TKioskCashReceiptBF_F.BSButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave11');
  KeyInLabel.Hint    := LeftStr(KeyInLabel.Hint, Length(KeyInLabel.Hint)-1);
  KeyInLabel.Caption := GetPhoneFormat(KeyInLabel.Hint);
end;

procedure TKioskCashReceiptBF_F.CancelButtonClick(Sender: TObject);
begin
  if not Common.AskBox('현금영수증이 발행되지 않았습니다'#13'계산을 완료하시겠습니까?') then
    Exit;
  ModalResult := mrOK;
end;

procedure TKioskCashReceiptBF_F.ClearButtonClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave11');
  KeyInLabel.Hint    := '010';
  KeyInLabel.Caption := '010';
end;

procedure TKioskCashReceiptBF_F.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Common.isCashRecieptCard := false;
end;

procedure TKioskCashReceiptBF_F.FormShow(Sender: TObject);
begin
  PlaySound(nil, 0, SND_MEMORY or SND_ASYNC);
  PlaySound(PChar('kioskwave3'), Common.DllHandle, SND_RESOURCE or SND_ASYNC);
end;

end.
