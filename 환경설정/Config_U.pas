unit Config_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxContainer, cxEdit, cxCheckBox, cxGraphics,
  KeyPad_F, StdCtrls, ExtCtrls, cxLabel, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, Mask, cxGroupBox, cxPC, IdTCPClient,
  cxLookAndFeels, cxRadioGroup, IniFiles, cxSpinEdit, StrUtils,
  cxCurrencyEdit, Menus, cxLookAndFeelPainters, cxButtons, cxCheckComboBox,
  cxMemo, cxPCdxBarPopupMenu, PosCard, DB, cxTimeEdit, IdBaseComponent,
  IdComponent, IdTCPConnection, IdHTTP, dxBarBuiltInMenu, cxClasses,
  dxGDIPlusClasses, AdvPageControl, Vcl.ComCtrls, AdvGlassButton, EncdDecd,
  ToolPanels, AdvSmoothToggleButton, System.ImageList, Vcl.ImgList, DelphiZXingQRCode,
  AdvPanel, IdGlobal, AdvSmoothButton, dxCore, dxColorEdit, cxFontNameComboBox,
  Vcl.WinXCtrls, cxColorComboBox, cxImage, REST.Types, REST.Client, System.JSON,
  System.NetEncoding, AdvBadge, cxImageList, DAScript, UniScript, Clipbrd, System.IOUtils,
  Winapi.ShellAPI, Winapi.ShlObj, Winapi.ActiveX;

type
  TBaeminOrderMenu = record
  Code :String;
  Item :String;
  Step :Integer;
  Name :String;
  Memo,
  ClassCode,
  DsTax,
  MenuType :String;
  Qty :Integer;
  Price,
  Amount :Integer;
  TotalItem :String;
end;
type
  TConfig_F = class(TForm)
    cxLookAndFeelController1: TcxLookAndFeelController;
    fmKeyPad1: TfmKeyPad;
    Timer1: TTimer;
    Timer2: TTimer;
    EmitTimer: TTimer;
    IdHTTP: TIdHTTP;
    ConfigPager: TAdvPageControl;
    GenTabSheet: TAdvTabSheet;
    DeviceTabSheet: TAdvTabSheet;
    DeliveryTabSheet: TAdvTabSheet;
    chkReceiptPrint: TcxCheckBox;
    chkAcctBillPrint: TcxCheckBox;
    chkAutoUpdate: TcxCheckBox;
    cxLabel15: TcxLabel;
    edt_Server: TcxTextEdit;
    lblAvailFloor: TcxLabel;
    chkOrderReceiptPrint: TcxCheckBox;
    chkPowerOff: TcxCheckBox;
    AvailFloorComboBox: TcxCheckComboBox;
    lblDefaultFloor: TcxLabel;
    DefaultFloorComboBox: TcxComboBox;
    SmartPosCheckBox: TcxCheckBox;
    chkAutoLogin: TcxCheckBox;
    SmartPadCheckBox: TcxCheckBox;
    PluGroupBox: TcxGroupBox;
    PluFrom1TimeEdit: TcxTimeEdit;
    PluTo1TimeEdit: TcxTimeEdit;
    cxLabel25: TcxLabel;
    PluFrom2TimeEdit: TcxTimeEdit;
    PluTo2TimeEdit: TcxTimeEdit;
    cxLabel26: TcxLabel;
    PluFrom3TimeEdit: TcxTimeEdit;
    PluTo3TimeEdit: TcxTimeEdit;
    cxLabel31: TcxLabel;
    edtPluNo1: TcxTextEdit;
    cxLabel33: TcxLabel;
    edtPluNo2: TcxTextEdit;
    cxLabel35: TcxLabel;
    edtPluNo3: TcxTextEdit;
    cxLabel41: TcxLabel;
    chkPluUse1: TcxCheckBox;
    chkPluUse2: TcxCheckBox;
    chkPluUse3: TcxCheckBox;
    EtcDeviceGroupBox: TcxGroupBox;
    cxLabel11: TcxLabel;
    cboCID: TcxComboBox;
    cxLabel14: TcxLabel;
    cboScanner: TcxComboBox;
    cxLabel24: TcxLabel;
    cboLabelPrinter: TcxComboBox;
    cboDualSize: TcxComboBox;
    cxLabel28: TcxLabel;
    cxLabel32: TcxLabel;
    edtDualText: TcxTextEdit;
    cxLabel40: TcxLabel;
    BellPortComboBox: TcxComboBox;
    chkDualMode: TcxCheckBox;
    lblDualImage: TcxLabel;
    DualImageChangeEdit: TcxCurrencyEdit;
    lblDualImage2: TcxLabel;
    cboKioskBell: TcxComboBox;
    chkKioskTouch: TcxCheckBox;
    cboKioskLabelPrinter: TcxComboBox;
    LabelPrinterLabel: TcxLabel;
    cxLabel58: TcxLabel;
    cxLabel22: TcxLabel;
    cboDeliveryPrint: TcxComboBox;
    cxLabel43: TcxLabel;
    DeliveryCustomerComboBox: TcxComboBox;
    lblFixPhoneNo: TcxLabel;
    edtFixPhoneNo: TcxTextEdit;
    EtcTabSheet: TAdvTabSheet;
    CustomerPrintLabel: TcxLabel;
    cboCustomerPosition: TcxComboBox;
    cxLabel49: TcxLabel;
    Image4: TImage;
    MessageLabel: TLabel;
    TitleLabel: TLabel;
    CloseButton: TcxButton;
    FixScannerComboBox: TcxComboBox;
    cxLabel5: TcxLabel;
    HandScannerComboBox: TcxComboBox;
    cxLabel6: TcxLabel;
    cxLabel8: TcxLabel;
    DeliveryDisplayComboBox: TcxComboBox;
    DeliveryDisplayEdit: TcxTextEdit;
    DeliveryDisplayLabel: TcxLabel;
    MenuEditButton: TAdvSmoothToggleButton;
    CallNumberInitButton: TAdvSmoothToggleButton;
    WaitNumberInitButton: TAdvSmoothToggleButton;
    TableOrderInitButton: TAdvSmoothToggleButton;
    DeliveryOrderInitButton: TAdvSmoothToggleButton;
    SoldOutButton: TAdvSmoothToggleButton;
    MenuAddButton: TAdvSmoothToggleButton;
    cboCustomerPosition2: TcxComboBox;
    BellDevComboBox: TcxComboBox;
    QueryButton: TAdvSmoothToggleButton;
    LetsOrderShowCheckBox: TcxCheckBox;
    cxLabel10: TcxLabel;
    cxImageList1: TcxImageList;
    LanguageComboBox: TcxComboBox;
    LanguageLabel: TcxLabel;
    PluChoosePanel: TAdvPanel;
    DIDShotDownButton: TAdvSmoothToggleButton;
    DIDRebootButton: TAdvSmoothToggleButton;
    DIDCheckButton: TAdvSmoothToggleButton;
    PrinterCheckButton: TAdvSmoothToggleButton;
    ConfirmButton: TAdvSmoothButton;
    PickupPosLabel: TcxLabel;
    PickupPosEdit: TcxTextEdit;
    KioskTabSheet: TAdvTabSheet;
    cxGroupBox3: TcxGroupBox;
    cxLabel17: TcxLabel;
    cxLabel20: TcxLabel;
    KioskWaitLangesShowSwitch: TToggleSwitch;
    KioskWaitLangesTopEdit: TcxSpinEdit;
    cxLabel37: TcxLabel;
    KioskWaitLangesLeftEdit: TcxSpinEdit;
    cxGroupBox5: TcxGroupBox;
    cxLabel13: TcxLabel;
    KioskWaitButtonTopEdit: TcxSpinEdit;
    cxLabel18: TcxLabel;
    cxLabel19: TcxLabel;
    KioskWaitButtonWidthEdit: TcxSpinEdit;
    cxLabel39: TcxLabel;
    KioskWaitButtonHeightEdit: TcxSpinEdit;
    KioskWaitStoreButtonEdit: TcxSpinEdit;
    cxLabel38: TcxLabel;
    KioskWaitPackingButtonEdit: TcxSpinEdit;
    CommonGroupBox: TcxGroupBox;
    KioskFontNameComboBox: TcxFontNameComboBox;
    cxLabel21: TcxLabel;
    cxLabel34: TcxLabel;
    KioskRoundEdit: TcxSpinEdit;
    cxLabel42: TcxLabel;
    KioskWaitStoreButtonColorEdit: TdxColorEdit;
    cxLabel45: TcxLabel;
    KioskWaitPackingButtonColorEdit: TdxColorEdit;
    cxLabel27: TcxLabel;
    KioskWaitButtonFontSizeEdit: TcxSpinEdit;
    KioskCourseGroupBox: TcxGroupBox;
    cxLabel36: TcxLabel;
    cxLabel46: TcxLabel;
    cxLabel53: TcxLabel;
    cxLabel54: TcxLabel;
    cxLabel55: TcxLabel;
    KioskCourseImageViewSwitch: TToggleSwitch;
    KioskButtonColorLabel: TcxLabel;
    KioskColorEdit: TdxColorEdit;
    KioskCourseGroupIconColorComboBox: TcxComboBox;
    KioskCourseItemIconColorComboBox: TcxComboBox;
    KioskCourseGroupFontColorComboBox: TcxComboBox;
    KioskCourseItemFontColorComboBox: TcxComboBox;
    KioskTab2Sheet: TAdvTabSheet;
    cxGroupBox4: TcxGroupBox;
    cxLabel30: TcxLabel;
    cxLabel52: TcxLabel;
    cxLabel59: TcxLabel;
    cxLabel60: TcxLabel;
    KioskBill1Edit: TcxTextEdit;
    KioskBill2Edit: TcxTextEdit;
    KioskBill3Edit: TcxTextEdit;
    KioskBill4Edit: TcxTextEdit;
    cxLabel50: TcxLabel;
    KioskFontBillColorEdit: TdxColorEdit;
    LogoImage: TcxImage;
    LetsOrderGroupBox: TcxGroupBox;
    LetsOrderCloseButton: TAdvSmoothToggleButton;
    LetsOrderOpenButton: TAdvSmoothToggleButton;
    TestMemo: TMemo;
    TestButton: TButton;
    SetSaleQtyButton: TAdvSmoothToggleButton;
    cxGroupBox1: TcxGroupBox;
    ReceiptPrinterComboBox: TcxComboBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel; 
    BaudRateCombobox: TcxComboBox;
    cxLabel4: TcxLabel;
    KitchenPrinterLinkCheckBox: TcxCheckBox;
    ReceiptPrinterCheckCheckBox: TcxCheckBox;
    cboPrintColum: TcxComboBox;
    cxLabel7: TcxLabel;
    PrintBottomMarginEdit: TcxCurrencyEdit;
    ReceiptPrinterPortComboBox: TcxComboBox;
    cxGroupBox2: TcxGroupBox;
    LinkPrintComboBox: TcxComboBox;
    cxLabel51: TcxLabel;
    LinkPortComboBox: TcxComboBox;
    Link2PrintComboBox: TcxComboBox;
    cxLabel16: TcxLabel;
    LinkPort2ComboBox: TcxComboBox;
    Link3PrintComboBox: TcxComboBox;
    cxLabel3: TcxLabel;
    LinkPort3ComboBox: TcxComboBox;
    Link4PrintComboBox: TcxComboBox;
    cxLabel12: TcxLabel;
    LinkPort4ComboBox: TcxComboBox;
    SmpartPadTestButton: TAdvSmoothToggleButton;
    SmartPadIPLabel: TcxLabel;
    cxGroupBox6: TcxGroupBox;
    cxLabel23: TcxLabel;
    DispenserComboBox: TcxComboBox;
    KioskStatusButton: TAdvSmoothToggleButton;
    cxGroupBox7: TcxGroupBox;
    cxLabel57: TcxLabel;
    cxLabel61: TcxLabel;
    lbl1000: TcxLabel;
    lbl100: TcxLabel;
    KioskCashCheckButton: TAdvSmoothToggleButton;
    cxLabel62: TcxLabel;
    KioskPickupPosEdit: TcxTextEdit;
    KioskBellDevComboBox: TcxComboBox;
    CatUsedCheckBox: TcxCheckBox;
    cxLabel44: TcxLabel;
    LinkOrder1Switch: TToggleSwitch;
    LinkOrder2Switch: TToggleSwitch;
    LinkOrder3Switch: TToggleSwitch;
    cxLabel9: TcxLabel;
    TableKeyComboBox: TcxComboBox;
    NewLetsOrderButton: TAdvSmoothToggleButton;
    Script: TUniScript;
    RustRegButton: TAdvSmoothToggleButton;
    ConfigRestoreButton: TAdvSmoothToggleButton;
    PosAutoStartCheckBox: TcxCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure KitchenPrinterLinkCheckBoxClick(Sender: TObject);
    procedure cedt_Rcp_portChange(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure cboLabelPrinterPropertiesChange(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure btnPrinterSyncClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure MenuAddButtonClick(Sender: TObject);
    procedure MenuEditButtonClick(Sender: TObject);
    procedure CallNumberInitButtonClick(Sender: TObject);
    procedure WaitNumberInitButtonClick(Sender: TObject);
    procedure IntegrityCheckListButtonClick(Sender: TObject);
    procedure DeliveryDisplayComboBoxPropertiesChange(Sender: TObject);
    procedure TableOrderInitButtonClick(Sender: TObject);
    procedure DeliveryOrderInitButtonClick(Sender: TObject);
    procedure SoldOutButtonClick(Sender: TObject);
    procedure ReceiptPrinterComboBoxPropertiesChange(Sender: TObject);
    procedure AvailFloorComboBoxPropertiesEditValueChanged(Sender: TObject);
    procedure ConfigRestoreButtonClick(Sender: TObject);
    procedure LetsOrderCloseButtonClick(Sender: TObject);
    procedure CustomerPrintLabelClick(Sender: TObject);
    procedure QueryButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure DIDShotDownButtonClick(Sender: TObject);
    procedure BellDevComboBoxPropertiesChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PrinterCheckButtonClick(Sender: TObject);
    procedure KioskButtonColorLabelClick(Sender: TObject);
    procedure EtcTabSheetShow(Sender: TObject);
    procedure TestButtonClick(Sender: TObject);
    function  SetDeliveryOrder(aCompany:String; var aDeliveryNo:String; var aOrderAmt:Integer; var aCardAmt:Integer; aValue: String; var aOrderMenu:TList):Boolean;
    procedure SetSaleQtyButtonClick(Sender: TObject);
    procedure KioskStatusButtonClick(Sender: TObject);
    procedure KioskCashCheckButtonClick(Sender: TObject);
    procedure NewLetsOrderButtonClick(Sender: TObject);
    procedure cxLabel10Click(Sender: TObject);
    procedure RustRegButtonClick(Sender: TObject);
  private
    IsFormShowing : Boolean;
    SelectButton :String;
    FCheck :Boolean;
    DispenserData :String;
    EmitData : Array[0..100] of Integer;
    EmitIndex : Integer;
    procedure SetRcpPrinter;
    procedure PluButtonClick(Sender:TObject);
    function   SetKioskCash:Boolean;
    procedure  DispenserStauts;
    procedure  DispenderReset;
    procedure  DispenserReadEvent(const S : String);
  public
    { Public declarations }
  end;
 
 
var
  Config_F: TConfig_F;

implementation
uses Common_U, GlobalFunc_U, Const_U, DBModule_U, ComObj, Math,
  MenuAdd_U, Integrity_U, Main_U, KioskKeyPad_U, Query_U, PrinterStatus_U,
  ToDaySaleQty_U;

{$R *.dfm}
procedure TConfig_F.FormCreate(Sender: TObject);
var vIndex :Integer;
begin
  Common.Device.OnDispenserReadData :=DispenserReadEvent;
  if not Common.Config.IsKiosk then
  begin
    Common.SetButtonColor(ConfirmButton);
    Common.SetButtonColor(ConfigRestoreButton);
    for vIndex := 0 to ComponentCount-1 do
      if Components[vIndex] is TAdvSmoothToggleButton then
        Common.SetButtonColor((Components[vIndex] as TAdvSmoothToggleButton));
  end;

  TestButton.Visible := IsDebuggerPresent;
end;

procedure TConfig_F.FormShow(Sender: TObject);
 function GetCustomerPrinter(aComboBox:TcxComboBox; aCode:String):Integer;
 var I :Integer;
 begin
    if aCode = '' then
      Result := 0
    else
      for I := 0 to aComboBox.Properties.Items.Count-1 do
      begin
        if LeftStr(aComboBox.Properties.Items[I],3) = aCode then
        begin
          Result := I;
          Break;
        end;
      end;
 end;
 function GetFloorIndex(aCode:String):Integer;
 var I : Integer;
 begin
    Result := -1;
    For I := 0 to AvailFloorComboBox.Properties.Items.Count-1 do
    begin
      if AvailFloorComboBox.Properties.Items.Items[I].ShortDescription = aCode then
      begin
        Result := I;
        Break;
      end;
    end;
 end;
var
  I, vIndex :Integer;
  vTemp  :String;
  vFloor :String;
  vCode: PStrPointer;
begin
  Common.LogoCreate(Self,2);
  SetComPortList(ReceiptPrinterPortComboBox,'LPT');
  if Common.Config.ReceiptPrinterPort = 'E' then
  begin
    New(vCode);
    vCode^.Data := 'E';
    ReceiptPrinterPortComboBox.Properties.Items.AddObject('ÀÌ´õ³Ý', TObject(vCode));
  end;
  SetComPortList(cboCID, '»ç¿ë¾ÈÇÔ');
  SetComPortList(cboScanner, '»ç¿ë¾ÈÇÔ');
  SetComPortList(TableKeyComboBox, '»ç¿ë¾ÈÇÔ');
  SetComPortList(BellPortComboBox, '»ç¿ë¾ÈÇÔ');
  SetComPortList(cboLabelPrinter,'LPT');
  SetComPortList(cboKioskLabelPrinter,'LPT');

  SetComPortList(DispenserComboBox, '»ç¿ë¾ÈÇÔ');
  SetComPortList(cboKioskLabelPrinter, 'LPT');
  SetComPortList(cboKioskBell, '»ç¿ë¾ÈÇÔ');
  SetComPortList(FixScannerComboBox, '»ç¿ë¾ÈÇÔ');
  SetComPortList(HandScannerComboBox, '»ç¿ë¾ÈÇÔ');

  SetComPortListEx(LinkPortComboBox, '»ç¿ë¾ÈÇÔ');
  SetComPortListEx(LinkPort2ComboBox, '»ç¿ë¾ÈÇÔ');
  SetComPortListEx(LinkPort3ComboBox, '»ç¿ë¾ÈÇÔ');
  SetComPortListEx(LinkPort4ComboBox, '»ç¿ë¾ÈÇÔ');

  LanguageComboBox.Properties.Items.Clear;
  New(vCode);
  vCode^.Data := 'KO';
  LanguageComboBox.Properties.Items.AddObject('ÇÑ±¹¾î(Korean)', TObject(vCode));
  New(vCode);
  vCode^.Data := 'EA';
  LanguageComboBox.Properties.Items.AddObject('¿µ¾î(English)', TObject(vCode));
  New(vCode);
  vCode^.Data := 'CN';
  LanguageComboBox.Properties.Items.AddObject('Áß±¹¾î(Chinese)', TObject(vCode));
  New(vCode);
  vCode^.Data := 'JA';
  LanguageComboBox.Properties.Items.AddObject('ÀÏº»¾î(Japanes)', TObject(vCode));
  New(vCode);
  vCode^.Data := 'VI';
  LanguageComboBox.Properties.Items.AddObject('¹èÆ®³²¾î(Vietnamese)', TObject(vCode));
  New(vCode);
  vCode^.Data := 'TH';
  LanguageComboBox.Properties.Items.AddObject('ÅÂ±¹¾î(Thai)', TObject(vCode));
  New(vCode);
  vCode^.Data := 'IN';
  LanguageComboBox.Properties.Items.AddObject('ÀÎµµ³×½Ã¾Æ(Indo)', TObject(vCode));
  New(vCode);
  vCode^.Data := 'FR';
  LanguageComboBox.Properties.Items.AddObject('ÇÁ¶û½º¾î(French)', TObject(vCode));
  New(vCode);
  vCode^.Data := 'DE';
  LanguageComboBox.Properties.Items.AddObject('µ¶ÀÏ¾î(German)', TObject(vCode));

  LanguageComboBox.ItemIndex := 0;

  if (GetHeadOption(14) = '0') or Common.Config.IsKiosk then
    LanguageComboBox.Properties.ReadOnly := true;

  LanguageLabel.Visible := LanguageComboBox.Properties.ReadOnly = true;

   //Å°¿À½ºÅ©°ü·Ã
//  EtcTabSheet.TabVisible      := not Common.Config.IsKiosk;
//  lblAvailFloor.Visible         := not Common.Config.IsKiosk;
//  AvailFloorComboBox.Visible    := not Common.Config.IsKiosk;
  EtcDeviceGroupBox.Visible     := not Common.Config.IsKiosk;

  PluChoosePanel.Visible := false;

  ConfigPager.ActivePageIndex := 0;
  IsFormShowing := true;
  SetSaleQtyButton.Visible := GetOption(491) = '1';

  KitchenPrinterLinkCheckBox.Visible := GetOption(254) = '0';
  //ÇØ»óµµ 1024 * 768 ÀÏ¶§´Â Å×ÀÌºí±â´É¹öÆ° 2°³ ¾Èº¸ÀÌ°Ô
  CallNumberInitButton.Visible := GetOption(311)='1';
  MenuAddButton.Enabled        := (GetOption(363)='0') and ((GetHeadOption(2) = '0') or (GetHeadOption(2) = '1'));
  MenuEditButton.Enabled       := (GetOption(363)='0') and ((GetHeadOption(2) = '0') or (GetHeadOption(2) = '1'));
  DeliveryTabSheet.TabVisible  := (GetOption(185) = '1') and not Common.Config.IsKiosk;


  OpenQuery('select CD_CODE, '
           +'       NM_CODE1, '
           +'       @@VERSION '
           +'  from MS_CODE '
           +' where CD_STORE  =:P0 '
           +'   and CD_KIND   =''03'' '
           +'   and DS_STATUS =0 '
           +' order by CD_CODE',
            [Common.Config.StoreCode]);

  AvailFloorComboBox.Enabled := False;
  AvailFloorComboBox.Properties.Items.Clear;
  AvailFloorComboBox.Properties.Items.AddCheckItem('ÀüÃ¼','000');

  while not Common.Query.Eof do
  begin
    AvailFloorComboBox.Properties.Items.AddCheckItem(Common.Query.Fields[1].AsString, Common.Query.Fields[0].AsString);
    edt_Server.Hint := Common.Query.Fields[2].AsString;
    Common.Query.Next;
  end;
  Common.Query.Close;


  if GetHeadOption(9) = '1' then
  begin
    LetsOrderGroupBox.Visible := true;
    OpenQuery('select DS_STATUS '
             +'  from MS_FIX '
             +' where CD_STORE  =:P0 ',
              [Common.Config.StoreCode]);

    if not Common.Query.Eof then
    begin
      if Common.Query.Fields[0].AsString = 'B' then
      begin
        LetsOrderGroupBox.Caption := '·¿Ã÷¿À´õ(¿µ¾÷Áß)';
      end
      else if Common.Query.Fields[0].AsString = 'E' then
      begin
        LetsOrderGroupBox.Caption := '·¿Ã÷¿À´õ(ÁÖ¹®¸¶°¨)';
      end;
    end
    else
    begin
      LetsOrderGroupBox.Caption := '·¿Ã÷¿À´õ';
    end;
    Common.Query.Close;
  end;


  cboCustomerPosition.Properties.Items.Clear;
  cboCustomerPosition2.Properties.Items.Clear;
  cboDeliveryPrint.Properties.Items.Clear;
  DeliveryCustomerComboBox.Properties.Items.Clear;
  LinkPrintComboBox.Properties.Items.Clear;
  Link2PrintComboBox.Properties.Items.Clear;
  Link3PrintComboBox.Properties.Items.Clear;
  Link4PrintComboBox.Properties.Items.Clear;
  New(vCode);
  vCode^.Data := '';
  cboCustomerPosition2.Properties.Items.AddObject('»ç¿ë¾ÈÇÔ', TObject(vCode));
  New(vCode);
  vCode^.Data := '000';
  cboCustomerPosition.Properties.Items.AddObject('¿µ¼öÁõÇÁ¸°ÅÍ', TObject(vCode));
  cboCustomerPosition2.Properties.Items.AddObject('¿µ¼öÁõÇÁ¸°ÅÍ', TObject(vCode));
  cboDeliveryPrint.Properties.Items.AddObject('¿µ¼öÁõÇÁ¸°ÅÍ', TObject(vCode));
  DeliveryCustomerComboBox.Properties.Items.AddObject('¿µ¼öÁõÇÁ¸°ÅÍ', TObject(vCode));
  LinkPrintComboBox.Properties.Items.AddObject('¿µ¼öÁõÇÁ¸°ÅÍ', TObject(vCode));
  Link2PrintComboBox.Properties.Items.AddObject('¿µ¼öÁõÇÁ¸°ÅÍ', TObject(vCode));
  Link3PrintComboBox.Properties.Items.AddObject('¿µ¼öÁõÇÁ¸°ÅÍ', TObject(vCode));
  Link4PrintComboBox.Properties.Items.AddObject('¿µ¼öÁõÇÁ¸°ÅÍ', TObject(vCode));

  for vIndex := High(Common.KitchenPrinter) downto 0 do
  begin
    New(vCode);
    vCode^.Data := Common.KitchenPrinter[vIndex].Code;
    cboCustomerPosition.Properties.Items.AddObject(Common.KitchenPrinter[vIndex].Name, TObject(vCode));
    cboCustomerPosition2.Properties.Items.AddObject(Common.KitchenPrinter[vINdex].Name, TObject(vCode));
    cboDeliveryPrint.Properties.Items.AddObject(Common.KitchenPrinter[vIndex].Name, TObject(vCode));
    DeliveryCustomerComboBox.Properties.Items.AddObject(Common.KitchenPrinter[vIndex].Name, TObject(vCode));
    LinkPrintComboBox.Properties.Items.AddObject(Common.KitchenPrinter[vIndex].Name, TObject(vCode));
    Link2PrintComboBox.Properties.Items.AddObject(Common.KitchenPrinter[vIndex].Name, TObject(vCode));
    Link3PrintComboBox.Properties.Items.AddObject(Common.KitchenPrinter[vIndex].Name, TObject(vCode));
    Link4PrintComboBox.Properties.Items.AddObject(Common.KitchenPrinter[vIndex].Name, TObject(vCode));
  end;

  with Common.Config do
  begin
    //ÀÏ¹Ý ÅÇ
    edt_Server.Text        := ServerIP;                      //¼­¹öIP
    vFloor := EmptyStr;
    vFloor := AvailFloor;
    while vFloor <> '' do
    begin
      I := Pos(',',vFloor);
      if (I > 0) then
      begin
        vIndex := GetFloorIndex(Copy(vFloor,1,I-1));
        if vIndex >= 0 then
           AvailFloorComboBox.SetItemState(vIndex, cbsChecked);
        Delete(vFloor,1,I);
      end
      else
      begin
        vIndex := GetFloorIndex(vFloor);
        if vIndex >= 0 then
           AvailFloorComboBox.SetItemState(vIndex, cbsChecked);
        vFloor :='';
      end;
    end;

    AvailFloorComboBox.Enabled := True;
    AvailFloorComboBoxPropertiesEditValueChanged(nil);

    For I := 0 to DefaultFloorComboBox.Properties.Items.Count - 1 do
    begin
      if PStrPointer(DefaultFloorComboBox.Properties.Items.Objects[I])^.Data = DefaultFloor then
      begin
        DefaultFloorComboBox.ItemIndex := I;
        Break;
      end;
    end;


    chkReceiptPrint.Checked  := Common.SetPrintMode = pmNoPrint;   //¿µ¼öÁõ Ãâ·Â¿©ºÎ
    chkOrderReceiptPrint.Enabled   := GetOption(167) = '1';
    chkOrderReceiptPrint.Checked   := not Common.SetBillPrintMode;
    chkAcctBillPrint.Checked := IsAcctKitchenPrint;
    chkAutoUpdate.Checked    := AutoUpdate;
    chkPowerOff.Checked      := PowerOff;
    chkAutoLogin.checked     := AutoLogin;
    PosAutoStartCheckBox.Checked := AutoStart = 'Y';

    cboScanner.ItemIndex             := GetStrPointerIndex(cboScanner, IntToStr(HandScannerPort));
    TableKeyComboBox.ItemIndex       := GetStrPointerIndex(TableKeyComboBox, IntToStr(TableKeyPort));
    HandScannerComboBox.ItemIndex    := GetStrPointerIndex(HandScannerComboBox, IntToStr(HandScannerPort));
    FixScannerComboBox.ItemIndex     := GetStrPointerIndex(FixScannerComboBox, IntToStr(FixScannerPort));
    cboLabelPrinter.ItemIndex        := GetStrPointerIndex(cboLabelPrinter, IntToStr(LabelPrinterPort));
    cboKioskLabelPrinter.ItemIndex   := GetStrPointerIndex(cboKioskLabelPrinter, IntToStr(LabelPrinterPort));
    DispenserComboBox.ItemIndex      := GetStrPointerIndex(DispenserComboBox, IntToStr(KioskDispenserPort));
    chkKioskTouch.Checked            := notKioskTouch;
    BellPortComboBox.ItemIndex       := GetStrPointerIndex(BellPortComboBox, IntToStr(BellPort));
    BellDevComboBox.ItemIndex        := BellDev;
    KioskBellDevComboBox.ItemIndex   := BellDev;;
    if BellDevComboBox.ItemIndex = 2 then
    begin
      DIDShotDownButton.Visible := true;
      DIDReBootButton.Visible   := true;
    end;

    cboKioskBell.ItemIndex           := GetStrPointerIndex(cboKioskBell, IntToStr(BellPort));;

    cboPrintColum.ItemIndex := PrintColum;
    SmartPosCheckBox.Checked     := SmartPosDemon;
    SmartPadCheckBox.Checked     := SmartPad;
    if SmartPadCheckBox.Checked then
    begin
      SmartPadIPLabel.Hint := Common.GetIniFile(iniPOS, '½º¸¶Æ®ÆÐµåIP','');
      if SmartPadIPLabel.Hint <> '' then
        SmartPadIPLabel.Caption := Format('(%s)',[SmartPadIPLabel.Hint]);
//      SmpartPadTestButton.Visible := true;
    end;

    LetsOrderShowCheckBox.Checked    := LetsOrderNoShow;

    //ÁÖº¯±â±â ÅÇ
    KitchenPrinterLinkCheckBox.Checked := RcpToKitchen;
    SetRcpPrinter;
    FCheck := False;

    ReceiptPrinterComboBox.ItemIndex     := ReceiptPrinterDev;
    FCheck                               := True;
    ReceiptPrinterPortComboBox.ItemIndex := GetStrPointerIndex(ReceiptPrinterPortComboBox, ReceiptPrinterPort);
    PrintBottomMarginEdit.Value          := PrintBottomMargin;
    BaudRateCombobox.ItemIndex           := ReceiptPrinterBaudRate;
    ReceiptPrinterCheckCheckBox.Checked  := ReceiptPrinterCheck;
    LinkPortComboBox.ItemIndex           := GetStrPointerIndex(LinkPortComboBox, IntToStr(Common.DeliveryLinkPrinter[0].InComPort));
    LinkPort2ComboBox.ItemIndex          := GetStrPointerIndex(LinkPort2ComboBox, IntToStr(Common.DeliveryLinkPrinter[1].InComPort));
    LinkPort3ComboBox.ItemIndex          := GetStrPointerIndex(LinkPort3ComboBox, IntToStr(Common.DeliveryLinkPrinter[2].InComPort));
    LinkPort4ComboBox.ItemIndex          := GetStrPointerIndex(LinkPort4ComboBox, IntToStr(Common.DeliveryLinkPrinter[3].InComPort));
    cboCustomerPosition.ItemIndex        := GetStrPointerIndex(cboCustomerPosition, CustPrinterCode);
    cboCustomerPosition2.ItemIndex       := GetStrPointerIndex(cboCustomerPosition2, CustPrinter2Code);
    cboDeliveryPrint.ItemIndex           := GetStrPointerIndex(cboDeliveryPrint, DeliveryPrinterCode);
    DeliveryCustomerComboBox.ItemIndex   := GetStrPointerIndex(DeliveryCustomerComboBox, DeliveryReceiptPrinterCode);
    LinkPrintComboBox.ItemIndex          := GetStrPointerIndex(LinkPrintComboBox,  Common.DeliveryLinkPrinter[0].OutComPort);
    Link2PrintComboBox.ItemIndex         := GetStrPointerIndex(Link2PrintComboBox, Common.DeliveryLinkPrinter[1].OutComPort);
    Link3PrintComboBox.ItemIndex         := GetStrPointerIndex(Link3PrintComboBox, Common.DeliveryLinkPrinter[2].OutComPort);
    Link4PrintComboBox.ItemIndex         := GetStrPointerIndex(Link4PrintComboBox, Common.DeliveryLinkPrinter[3].OutComPort);

    if Common.DeliveryLinkPrinter[0].Collection = 'Y' then
      LinkOrder1Switch.State := tssOn
    else
      LinkOrder1Switch.State := tssOff;
    if Common.DeliveryLinkPrinter[1].Collection = 'Y' then
      LinkOrder2Switch.State := tssOn
    else
      LinkOrder2Switch.State := tssOff;
    if Common.DeliveryLinkPrinter[2].Collection = 'Y' then
      LinkOrder3Switch.State := tssOn
    else
      LinkOrder3Switch.State := tssOff;

    if DeliveryDisplay = '' then
    begin
      DeliveryDisplayComboBox.ItemIndex := 0;
      DeliveryDisplayEdit.Text          := '';
      DeliveryDisplayEdit.Visible       := false;
      DeliveryDisplayLabel.Visible      := false;
    end
    else
    begin
      DeliveryDisplayComboBox.ItemIndex := 1;
      DeliveryDisplayEdit.Text          := DeliveryDisplay;
      DeliveryDisplayEdit.Visible       := true;
      DeliveryDisplayLabel.Visible      := true;
    end;
    PickUpPosEdit.Text      :=  DIDPickupPos;
    KioskPickUpPosEdit.Text :=  DIDPickupPos;

    cboDualSize.ItemIndex    := DualSize;
    chkDualMode.Checked      := DualMode = 1;
    edtDualText.Text         := DualText;
    ReceiptPrinterComboBoxPropertiesChange(nil);

    cboCid.ItemIndex         := GetStrPointerIndex(cboCid, IntToStr(Cid_Port));

    edtFixPhoneNo.Text       := FixPhoneNo;
    LanguageComboBox.ItemIndex := GetStrPointerIndex(LanguageComboBox, Common.Config.PosLanguage);

    chkPluUse1.Checked       := TimePlu[1,0] = '1';
    PluFrom1TimeEdit.Text    := TimePlu[1,1];
    PluTo1TimeEdit.Text      := TimePlu[1,2];
    edtPluNo1.Text           := TimePlu[1,3];
    chkPluUse2.Checked       := TimePlu[2,0] = '1';
    PluFrom2TimeEdit.Text    := TimePlu[2,1];
    PluTo2TimeEdit.Text      := TimePlu[2,2];
    edtPluNo2.Text           := TimePlu[2,3];
    chkPluUse3.Checked       := TimePlu[3,0] = '1';
    PluFrom3TimeEdit.Text    := TimePlu[3,1];
    PluTo3TimeEdit.Text      := TimePlu[3,2];
    edtPluNo3.Text           := TimePlu[3,3];
  end;

  if GetOption(427) = '1' then
  begin
    KitchenPrinterLinkCheckBox.Checked := false;
    KitchenPrinterLinkCheckBox.Visible := false;
  end;

  if GetOption(8) = '1' then
  begin
    chkReceiptPrint.Checked := false;
    chkReceiptPrint.Enabled := false;
  end;

  if (GetHeadOption(9) = '0') or (GetOption(352)='0') then
  begin
    LetsOrderShowCheckBox.Visible := false;
    LetsOrderShowCheckBox.Checked := false;
  end;

  if Common.Config.IsKiosk then
    cboCID.ItemIndex          := 0;

  DualImageChangeEdit.Value := Common.GetIniFile('DEVICE', 'µà¾óÀÌ¹ÌÁö', 5);
  IsFormShowing   := false;
  SelectButton := '0';

  //Å°¿À½ºÅ©ÀÏ¶§
  if Common.Config.IsKiosk then
  begin
    KioskTabSheet.TabVisible  := true;
    KioskTab2Sheet.TabVisible := true;
    KioskCourseGroupBox.Visible := (GetOption(293) = '0');
    with TIniFile.Create(Common.AppPath+'Kiosk\KioskConfig.ini') do
    try
      KioskColorEdit.ColorValue      := StringToColorDef(ReadString('°øÅë','Color', 'clNone'),clNone);;
      KioskRoundEdit.Value           := ReadInteger('°øÅë','Round', 40);
      KioskFontNameComboBox.FontName := ReadString('°øÅë','FontName','¸¼Àº °íµñ');
      if GetOption(457) = '1' then
      begin
        if ReadString('ÁÖ¹®´ë±â','´Ù±¹¾î_Show','N') = 'Y' then
          KioskWaitLangesShowSwitch.State := tssOn
        else
          KioskWaitLangesShowSwitch.State := tssOff;
      end
      else
      begin
        KioskWaitLangesShowSwitch.Enabled := false;
        KioskWaitLangesShowSwitch.State   := tssOff;
      end;
      KioskWaitLangesTopEdit.Value      := ReadInteger('ÁÖ¹®´ë±â','´Ù±¹¾î_Top',0);
      KioskWaitLangesLeftEdit.Value     := ReadInteger('ÁÖ¹®´ë±â','´Ù±¹¾î_Left',0);
      KioskWaitButtonTopEdit.Value      := ReadInteger('ÁÖ¹®´ë±â','Top',0);
      KioskWaitStoreButtonEdit.Value    := ReadInteger('ÁÖ¹®´ë±â','¸ÅÀåÀÌ¿ë_Left',0);
      KioskWaitPackingButtonEdit.Value  := ReadInteger('ÁÖ¹®´ë±â','Æ÷Àå_Left',0);
      KioskWaitButtonWidthEdit.Value    := ReadInteger('ÁÖ¹®´ë±â','Width',300);
      KioskWaitButtonHeightEdit.Value   := ReadInteger('ÁÖ¹®´ë±â','Height',200);
      KioskWaitStoreButtonColorEdit.ColorValue   := StringToColorDef(ReadString('ÁÖ¹®´ë±â','¸ÅÀåÀÌ¿ë_Color','$00D26900'),$00D26900) ;
      KioskWaitPackingButtonColorEdit.ColorValue := StringToColorDef(ReadString('ÁÖ¹®´ë±â','Æ÷Àå_Color','$003B3B3B'),$003B3B3B) ;

      KioskCourseGroupIconColorComboBox.ItemIndex := KioskCourseGroupIconColorComboBox.Properties.Items.IndexOf(ReadString('Course', 'GroupIcon','clblue'));
      KioskCourseItemIconColorComboBox.ItemIndex  := KioskCourseItemIconColorComboBox.Properties.Items.IndexOf(ReadString('Course', 'ItemIcon','clblue'));
      KioskCourseGroupFontColorComboBox.ItemIndex := KioskCourseGroupFontColorComboBox.Properties.Items.IndexOf(ReadString('Course', 'GroupFontColor','clblue'));
      KioskCourseItemFontColorComboBox.ItemIndex  := KioskCourseItemFontColorComboBox.Properties.Items.IndexOf(ReadString('Course', 'ItemFontColor','clblue'));

      if ReadString('Course', 'ImageView', 'N') = 'Y' then
        KioskCourseImageViewSwitch.State := tssOn
      else
        KioskCourseImageViewSwitch.State := tssOff;


      KioskFontBillColorEdit.ColorValue := StringToColorDef(ReadString('ÁÖ¹®¿Ï·á', 'FontColor', '$00373737'), $00373737);
      KioskBill1Edit.Text                := ReadString('ÁÖ¹®¿Ï·á', '¸Þ¼¼Áö1','ÁÖ¹®ÀÌ ¿Ï·á µÇ¾ú½À´Ï´Ù');
      KioskBill2Edit.Text                := ReadString('ÁÖ¹®¿Ï·á', '¸Þ¼¼Áö2','ÁÖ¹®ÇÏ½Å ¸Þ´º°¡ ÁØºñµÇ¸é');
      KioskBill3Edit.Text                := ReadString('ÁÖ¹®¿Ï·á', '¸Þ¼¼Áö3','¾È³»ÇØ µå¸®°Ú½À´Ï´Ù');
      KioskBill4Edit.Text                := ReadString('ÁÖ¹®¿Ï·á', '¸Þ¼¼Áö4','');

      if FileExists(Common.AppPath+'Kiosk\Logo.png') then
      begin
        LogoImage.AutoSize := true;
        LogoImage.Picture.Graphic.LoadFromFile(Common.AppPath+'Kiosk\Logo.png');
      end;
    finally
      free;
    end;
  end
  else
  begin
    KioskTabSheet.TabVisible  := false;
    KioskTab2Sheet.TabVisible := false;
    Common.SetLanguage(Self);
  end;
end;

procedure TConfig_F.MenuAddButtonClick(Sender: TObject);
begin
  if GetHeadOption(2) = '1' then
  begin
    Common.MsgBox('Ç¥ÁØ PLU¸¦ »ç¿ëÇÏ´Â ¸ÅÀåÀº'#13'Æ÷½º¿¡ ¸Þ´º¸¦ µî·ÏÇÒ ¼ö ¾ø½À´Ï´Ù');
    Exit;
  end;
  MenuAdd_F := TMenuAdd_F.Create(Self);
  try
    MenuAdd_F.isMenuAdd := true;
    MenuAdd_F.WorkPluNo  := Common.Config.PluNo;
    MenuAdd_F.ShowModal;
  finally
    FreeAndNil(MenuAdd_F);
  end;
end;

procedure TConfig_F.MenuEditButtonClick(Sender: TObject);
begin
  MenuAdd_F := TMenuAdd_F.Create(Self);
  try
    MenuAdd_F.isMenuAdd  := false;
    MenuAdd_F.WorkPluNo  := Common.Config.PluNo;
    MenuAdd_F.ShowModal;
  finally
    FreeAndNil(MenuAdd_F);
  end;
end;

procedure TConfig_F.NewLetsOrderButtonClick(Sender: TObject);
begin
  try
    Common.ShowWaitForm('½Å±Ô ·¿Ã÷¿À´õ¸¦ Àû¿ë ÁßÀÔ´Ï´Ù');
    Script.Connection := DM.UniConnection;
    Script.Execute;
    Common.KillTask('LetsOrderMQ.exe');
    Common.KillTask('SmartAgent.exe');
    Common.KillTask('OrangeTR.exe');
    Sleep(1000);
    Common.FileDownLoad('LetsOrderMQ.exe',     Common.AppPath);
    Common.FileDownLoad('MySql.Data.dll',      Common.AppPath);
    Common.FileDownLoad('RabbitMQ.Client.dll', Common.AppPath);
    Common.FileDownLoad('SmartAgent.exe',     Common.AppPath);
    Common.FileDownLoad('OrangeTR.exe',     Common.AppPath);
    Common.HideWaitForm;
    Common.MsgBox('ÀÛ¾÷ÀÌ ¿Ï·á µÇ¾ú½À´Ï´Ù');
    ExcuteProgram(Common.AppPath+'OrangeTR.exe');
    ExcuteProgram(Common.AppPath+'SmartAgent.exe');
  except
    on E: Exception do
    begin
      Common.HideWaitForm;
      Common.ErrBox('ÀÛ¾÷À» ¿Ï·áÇÏÁö ¸øÇß½À´Ï´Ù.'#13+E.Message);
    end;
  end;
end;

procedure TConfig_F.PluButtonClick(Sender: TObject);
var vPluNo :String;
begin
  vPluNo := (Sender as TAdvGlassButton).Hint;
  PluChoosePanel.Visible    := false;
  MenuAdd_F := TMenuAdd_F.Create(Self);
  try
    MenuAdd_F.isMenuAdd    := false;
    MenuAdd_F.isSetSoldOut := true;
    MenuAdd_F.WorkPluNo    := vPluNo;
    MenuAdd_F.ShowModal;
  finally
    FreeAndNil(MenuAdd_F);
  end;
end;

procedure TConfig_F.PrinterCheckButtonClick(Sender: TObject);
begin
  PrinterStatus_F := TPrinterStatus_F.Create(Self);
  try
    PrinterStatus_F.ShowModal;
  finally
    FreeAndNil(PrinterStatus_F);
  end;
end;

procedure TConfig_F.QueryButtonClick(Sender: TObject);
begin
  with TQuery_F.Create(Self) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TConfig_F.ReceiptPrinterComboBoxPropertiesChange(Sender: TObject);
begin
  ReceiptPrinterPortComboBox.Enabled := (ReceiptPrinterComboBox.ItemIndex > 0) and (ReceiptPrinterComboBox.Enabled) ;
  ReceiptPrinterCheckCheckBox.Enabled  := (ReceiptPrinterComboBox.ItemIndex > 0) and (ReceiptPrinterPortComboBox.ItemIndex > 0 ) and (ReceiptPrinterComboBox.Enabled) ;
end;

procedure TConfig_F.RustRegButtonClick(Sender: TObject);
var vID, vVersion, vFileName, vTemp :String;
    vBatch :TStringList;
begin
  vVersion := TOSVersion.ToString;
  if Pos('64-bit', vVersion) > 0 then
    vFileName := 'rustdesk.exe'
  else
    vFileName := 'rustdesk32.exe';

  if not FileExists(Common.AppPath+vFileName) then
    Common.FileDownLoad(vFileName, Common.AppPath);

  try
    vBatch     := TStringList.Create;
    vBatch.Clear;
    vBatch.Add('@echo off');
    if not IsRustDeskInstalled then
    begin
      if Pos('64-bit', vVersion) > 0 then
      begin
        vBatch.Add('rustdesk.exe --silent-install');
      end
      else
      begin
        vBatch.Add('rustdesk32.exe --silent-install');
      end;
      vBatch.Add('echo RustDesk ¼³Ä¡Áß ÀÔ´Ï´Ù. Àå½Ã¸¸ ±â´Ù·ÁÁÖ¼¼¿ä');
      vBatch.Add('timeout /t 10 /nobreak > nul');
      vBatch.Add('echo ¼­ºñ½º¸¦ µî·ÏÇÕ´Ï´Ù.');
    end;
    if Pos('64-bit', vVersion) > 0 then
    begin
      vBatch.Add('rustdesk.exe --install-service');
      vBatch.Add('taskkill /f /im rustdesk.exe');
    end
    else
    begin
      vBatch.Add('rustdesk32.exe --install-service');
      vBatch.Add('taskkill /f /im rustdesk32.exe');
      Common.SetIniFile(iniPos, 'key', '2R58m01LXoreavzEmQolsBCl9RYY1gQqnvYKMMNAaPw=');
    end;
    vBatch.Add('rustdesk --tray');
    vBatch.SaveToFile(Common.AppPath+'rust.bat');
    ExecuteProgram(Common.AppPath,'rust.bat', '',true);
    DeleteFile(Common.AppPath+'rust.bat');
  finally
    vBatch.Free;
  end;
  Clipboard.Clear;
  Clipboard.AsText := '9JSP3BVYB5UTNtUW25WcRdWMZllU5w2QCNHbvFVbFpndhVmcvhFTxATb4UjUyIiOikXZrJCLiIiOikGchJCLiI3au82YuM3bwhXZuc3d3JiOikXYsVmciwiIytmLvNmLz9Gc4VmL3d3diojI0N3boJye';
  ExecuteProgram('C:\Program Files\RustDesk\','rustdesk.exe','',true);

  vID := '';
  DM.OpenCloud('select NM_CODE21 '
              +'  from MS_CODE '
              +' where CD_HEAD = :P0 '
              +'   and CD_STORE =:P1 '
              +'   and CD_KIND  = ''01'' '
              +'   and NM_CODE1 =:P2 ',
              [Common.Config.HeadStoreCode,
               Common.Config.StoreCode,
               Common.Config.PosNo], Common.RestDBURL );
  if not DM.CloudData.Eof then
    vID := DM.CloudData.Fields[0].AsString;
  DM.CloudData.Close;

  vID := Common.ShowNumberForm('¿ø°ÝID¸¦ ÀÔ·ÂÇÏ¼¼¿ä',300,0,vID);
  if Common.Config.IsKiosk then
    Common.DoModalClose;

  if (vID = '') or (vID = 'mrClose') then Exit;

  DM.ExecCloud('update MS_CODE '
              +'   set NM_CODE21 =:P3 '
              +' where CD_HEAD = :P0 '
              +'   and CD_STORE =:P1 '
              +'   and CD_KIND  = ''01'' '
              +'   and NM_CODE1 =:P2 ',
              [Common.Config.HeadStoreCode,
               Common.Config.StoreCode,
               Common.Config.PosNo,
               GetOnlyNumber(vID)],true, Common.RestDBURL);

end;

procedure TConfig_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F10  :  if (ActiveControl is TCustomEdit) then TCustomEdit(ActiveControl).Clear;
    13      : ConfirmButtonClick(ConfirmButton);
    27      : CloseButton.Click;
  end;
end;

procedure TConfig_F.KioskButtonColorLabelClick(Sender: TObject);
begin
  KioskColorEdit.ColorValue := clNone;
end;

procedure TConfig_F.KioskCashCheckButtonClick(Sender: TObject);
begin
  if DispenserComboBox.ItemIndex > 0 then
  begin
    Common.Config.KioskDispenserPort             := StrToIntDef(GetStrPointerData(DispenserComboBox),0);
    Common.Device.DispenserPortOpen;
    MessageLabel.Caption := 'ÀÔÃâ±Ý±â ÀÜ¿©¼ö·® Ã¼Å© Áß...';
    SetKioskCash;
  end;
end;

procedure TConfig_F.KioskStatusButtonClick(Sender: TObject);
begin
  if IsDebuggerPresent or (DispenserComboBox.ItemIndex > 0) then
  begin
    Common.Config.KioskDispenserPort             := StrToIntDef(GetStrPointerData(DispenserComboBox),0);
    Common.Device.DispenserPortOpen;
    MessageLabel.Caption := 'ÀÔÃâ±Ý±â »óÅÂ Ã¼Å© Áß...';
    DispenserStauts;
  end;
end;

procedure TConfig_F.KitchenPrinterLinkCheckBoxClick(Sender: TObject);
var vIndex :Integer;
    vCode: PStrPointer;
begin
  if KitchenPrinterLinkCheckBox.Checked then
  begin
    //ÁÖ¹æÇÁ¸°ÅÍ¿¡ ÇöÀçÆ÷½º¹øÈ£·Î µî·ÏµÈ°Ô ÀÖ´ÂÁö Ã¼Å©
    vIndex := Common.GetKitchenIndex(1, 1, Common.Config.PosIP);
    if  vIndex = -1 then
    begin
      if not IsFormShowing then
        Common.ErrBox('ÇöÀç Æ÷½º¿¡ ¼³Á¤µÈ ÁÖ¹æÇÁ¸°ÅÍ°¡'+#13+'¾ø½À´Ï´Ù');
      KitchenPrinterLinkCheckBox.Checked   := False;
      Common.Config.RcpToKitchen := False;
    end
    else
    begin
      if (Common.KitchenPrinter[vIndex].Port = 'E') and (GetStrPointerIndex(ReceiptPrinterPortComboBox,'E') < 0) then
      begin
        New(vCode);
        vCode^.Data := 'E';
        ReceiptPrinterPortComboBox.Properties.Items.AddObject('ÀÌ´õ³Ý', TObject(vCode));
      end;

      ReceiptPrinterComboBox.ItemIndex      := Common.KitchenPrinter[vIndex].Device;
      ReceiptPrinterPortComboBox.ItemIndex  := GetStrPointerIndex(ReceiptPrinterPortComboBox, Common.KitchenPrinter[vIndex].Port);
      BaudRateCombobox.ItemIndex := Common.KitchenPrinter[vIndex].BaudRate-1;
      Common.Config.KitchenIndex := vIndex;
      cboPrintColum.ItemIndex    := Common.KitchenPrinter[vIndex].Col;
    end;
  end
  else
  begin
    if GetStrPointerIndex(ReceiptPrinterPortComboBox,'E') >= 0 then
    begin
      ReceiptPrinterPortComboBox.Properties.Items.Delete(ReceiptPrinterPortComboBox.Properties.Items.Count-1);
      ReceiptPrinterPortComboBox.ItemIndex := 0;
    end;
  end;
  SetRcpPrinter;
end;

procedure TConfig_F.LetsOrderCloseButtonClick(Sender: TObject);
begin
  ExecQuery('insert into TR_ORDER(CD_STORE, '
           +'                     GROUP_SEQ, '
           +'                     GROUP_STEP, '
           +'                     DS_ORDER, '
           +'                     NO_TABLE) '
           +'              values(:P0, '
           +'                     GetNextVal(''TR_ORDER''), '
           +'                     0, '
           +Ifthen(Sender=LetsOrderOpenButton,'''B'',','''E'',')
           +'                     0)',
           [Common.Config.StoreCode]);

end;
procedure TConfig_F.SetRcpPrinter;
begin
  ReceiptPrinterComboBox.Enabled     := not KitchenPrinterLinkCheckBox.Checked;
  ReceiptPrinterPortComboBox.Enabled := ReceiptPrinterComboBox.Enabled;
  ReceiptPrinterComboBoxPropertiesChange(nil);
end;

procedure TConfig_F.SetSaleQtyButtonClick(Sender: TObject);
begin
  if Common.WorkDate = '' then
  begin
    Common.ErrBox('°³Á¡À» ¸ÕÀú ÇØ¾ßÇÕ´Ï´Ù');
    Exit;
  end;

  ToDaySaleQty_F := TToDaySaleQty_F.Create(Self);
  try
    ToDaySaleQty_F.ShowModal;
  finally
    FreeAndNil(ToDaySaleQty_F);
  end;
end;

procedure TConfig_F.SoldOutButtonClick(Sender: TObject);
var vPluNo :String;
    vIndex :Integer;
    vLeft, vTop :Integer;
label Loop;
begin
  if PluChoosePanel.Visible then
  begin
    PluChoosePanel.Visible := false;
    Exit;
  end;

  Loop:
    for vIndex := 0 to PluChoosePanel.ControlCount-1 do
      if PluChoosePanel.Controls[vIndex] is TAdvGlassButton then
      begin
        (PluChoosePanel.Controls[vIndex] as TAdvGlassButton).Free;
        Goto Loop;
      end;


  if GetOption(403) = '1' then
  begin
    try
      DM.OpenQuery('select CD_GUBUN  '
                  +'  from MS_KIOSK_LARGE '
                  +' where CD_STORE = :P0 '
                  +' group by CD_GUBUN '
                  +' order by 1 ',
                  [Common.Config.StoreCode]);

      if DM.Query.Eof then
      begin
        Common.MsgBox('µî·ÏµÈ Å°¿À½ºÅ© PLU°¡ ¾ø½À´Ï´Ù');
        Exit;
      end;

      if DM.Query.RecordCount > 1 then
      begin
        vTop   := 60;
        vLeft  := 64;
        vIndex := 0;
        PluChoosePanel.Width := 305;

        while not DM.Query.Eof do
        begin
          if vTop > 500 then
          begin
            Inc(vIndex);
            vTop  := 60;
            vLeft := (64 + 200) + ((vIndex-1)*200);
            PluChoosePanel.Width := PluChoosePanel.Width + 200;
          end;

          with TAdvGlassButton.Create(Self) do
          begin
            Parent    := PluChoosePanel;
            Top       := vTop;
            Left      := vLeft;
            Height    := 50;
            Width     := 180;
            Font.Name := '¸¼Àº °íµñ';
            Font.Size := 13;
            Font.Color := clWhite;
            BackColor  := $00592D00;
            ShineColor := $00592D00;
            OnClick   := PluButtonClick;
            Caption   := DM.Query.Fields[0].AsString;
            Hint      := DM.Query.Fields[0].AsString;
            vTop    := vTop + 65;
          end;
          DM.Query.Next;
        end;
        PluChoosePanel.Height := vTop+5 ;
        if PluChoosePanel.Height < 350 then
          PluChoosePanel.Height := 350;

        PluChoosePanel.Top  := (Self.Height - PluChoosePanel.Height) div 2;
        PluChoosePanel.Left := (Self.Width  - PluChoosePanel.Width ) div 2;
        PluChoosePanel.Visible := true;
        Exit;
      end
      else
        vPluNo := DM.Query.Fields[0].AsString
    finally
      DM.Query.Close;
    end;
  end
  else
    vPluNo := Common.Config.PluNo;

  MenuAdd_F := TMenuAdd_F.Create(Self);
  try
    MenuAdd_F.isMenuAdd    := false;
    MenuAdd_F.isSetSoldOut := true;
    MenuAdd_F.WorkPluNo    := vPluNo;
    MenuAdd_F.ShowModal;
  finally
    FreeAndNil(MenuAdd_F);
  end;
end;


procedure TConfig_F.cedt_Rcp_portChange(Sender: TObject);
begin
  ReceiptPrinterComboBoxPropertiesChange(nil);
end;

procedure TConfig_F.ConfigRestoreButtonClick(Sender: TObject);
var vDBIP,
    vDBName,
    vPort,
    vUser,
    vPosIP,
    vLicenseNo,
    vLicenseKey    : String;
    vStream    : TStream;
    vLastUser,
    vLTD       : String;
begin
  if not Common.AskBox('Æ÷½º È¯°æ¼³Á¤ ³»¿ªÀ» º¹¿øÇÏ½Ã°Ú½À´Ï±î?') then Exit;

  with TIniFile.Create(ExtractFilePath(Application.ExeName)+'Config.ini') do
    try
      vDBName     := ReadString('°øÅë','DB_NAME','orangepos');
      vDBIP       := ReadString('°øÅë','DB_IP','127.0.0.1');
      vPort       := StringReplace(ReadString('°øÅë','DB_PORT','4171'),' ','',[rfReplaceAll]);
      vUser       := ReadString('°øÅë','DB_USER','expos');
      vPosIP      := ReadString('POS','POS_IP','');
      vLicenseKey := ReadString('°øÅë','LicenseKey','');
      vLicenseNo  := Decrypt(vLicenseKey, 2843);
      vLTD        := ReadString('POS', 'LDT', '');
      vLastUser   := ReadString('POS', 'ÃÖÁ¾»ç¿ëÀÚ', '');
    finally
      free;
    end;

  OpenQuery('select CONFIG, '
           +'       ifnull(CONFIG,''X'') as I '
           +'  from MS_CODE '
           +' where CD_STORE =:P0 '
           +'   and CD_KIND  =''01'' '
           +'   and replace(NM_CODE2, '' '','''') =:P1 ',
           [Common.Config.StoreCode,
            Common.Config.PosIP]);
  if Common.Query.Eof or (Common.Query.RecordCount > 1) or (Common.Query.FieldByName('I').AsString = 'X') then
  begin
    Common.Query.Close;
    Common.MsgBox('º¹¿ø ÇÒ ÀúÀåµÈ ³»¿ªÀÌ ¾ø½À´Ï´Ù');
    Exit;
  end;

  vStream := Common.Query.CreateBLOBStream(Common.Query.FieldByName('CONFIG'), bmRead);
  with TFileStream.Create(ExtractFilePath(Application.ExeName)+'Config.ini', fmCreate) do
    try
      CopyFrom(vStream, vStream.Size)
    finally
      Free
    end;
  Common.Query.Close;

  with TIniFile.Create(ExtractFilePath(Application.ExeName)+'Config.ini') do
    try
      WriteString('°øÅë','DB_NAME',vDBName);
      WriteString('°øÅë','DB_IP',vDBIP);
      WriteString('°øÅë','DB_PORT',vPort);

      if vLicenseKey <> '' then
        WriteString('°øÅë','LicenseKey',vLicenseKey);

      if vUser <> 'expos' then
        WriteString('°øÅë','DB_USER',vUser)
      else
        DeleteKey('°øÅë','DB_USER');

      if vPosIP <> '' then
        WriteString('POS','POS_IP',vPosIP)
      else
        DeleteKey('POS', 'POS_IP');

      if vLastUser <> '' then
        WriteString('POS','ÃÖÁ¾»ç¿ëÀÚ',vLastUser)
      else
        DeleteKey('POS', 'ÃÖÁ¾»ç¿ëÀÚ');


      if vLTD <> '' then
        WriteString('POS','LTD',vLTD);
    finally
      free;
    end;

  Common.GetIni;
  FormShow(nil);
  Common.MsgBox('º¹¿øÀÌ ¿Ï·áµÇ¾ú½À´Ï´Ù');
end;

procedure TConfig_F.ConfirmButtonClick(Sender: TObject);
var
   vIndex :Integer;
   Tmp :Variant;
   vStream : TMemoryStream;
   vTemp   : String;
   vPath   : String;
begin
  //°ü¸®ÀÚ¸¸ º¯°æ°¡´ÉÇÒ¶§
  try
    ConfirmButton.Enabled := false;
    MessageLabel.Caption  := Common.GetPaPago('º¯°æ³»¿ªÀ» ÀúÀåÁß ÀÔ´Ï´Ù.... Àá½Ã¸¸ ±â´Ù·ÁÁÖ¼¼¿ä');
    Application.ProcessMessages;
    if GetUserOption(6) = '0' then
    begin
      if GetOption(172) = '0' then
      begin
        Common.ErrBox('È¯°æ¼³Á¤À» º¯°æ ÇÒ ±ÇÇÑÀÌ ¾ø½À´Ï´Ù');
        Exit;
      end
      else if not Common.CheckAuthority(6) then Exit;
    end;

    //KICC ´Ü¸»±â ¿¬µ¿ÀÏ¶§ ±âÁ¾Ã¼Å©
    if (GetOption(379) = '1') and (Common.Config.van_trd = vanKICC) and (ReceiptPrinterComboBox.ItemIndex = 10) then
    begin
      Common.ErrBox('KICC ´Ü¸»±â ¿¬µ¿ÀÏ¶§´Â »ç¿ëÇÒ ¼ö ¾ø´Â'+#13#13+'ÇÁ¸°ÅÍ ±âÁ¾ÀÔ´Ï´Ù');
      Exit;
    end;

    if DeliveryTabSheet.TabVisible and DeliveryDisplayEdit.Visible then
    begin
      if CharCnt(DeliveryDisplayEdit.Text,',') <> 3 then
      begin
        ConfigPager.ActivePage := DeliveryTabSheet;
        DeliveryDisplayEdit.SetFocus;
        Common.ErrBox('¹è´ÞÈ­¸é ÇØ»óµµ°¡ ¿Ã¹Ù¸£Áö ¾Ê½À´Ï´Ù');
        Exit;
      end;

      vTemp := ','+DeliveryDisplayEdit.Text;
      if StoI(CopyPOs(vTEmp,',',3)) < 1024  then
      begin
        ConfigPager.ActivePage := DeliveryTabSheet;
        DeliveryDisplayEdit.SetFocus;
        Common.ErrBox('¹è´ÞÈ­¸é ÇØ»óµµ ³ÐÀÌ´Â ÃÖ¼Ò 1024 ÀÌ»óÀÌ¾î¾ß ÇÕ´Ï´Ù');
        Exit;
      end;
      if StoI(CopyPOs(vTEmp,',',4)) < 768  then
      begin
        ConfigPager.ActivePage := DeliveryTabSheet;
        DeliveryDisplayEdit.SetFocus;
        Common.ErrBox('¹è´ÞÈ­¸é ÇØ»óµµ ³ôÀÌ´Â ÃÖ¼Ò 768 ÀÌ»óÀÌ¾î¾ß ÇÕ´Ï´Ù');
        Exit;
      end;
    end;

    if GetStrPointerData(LanguageComboBox) <> Common.Config.PosLanguage then
    begin
      Common.MsgBox('Æ÷½º¸¦ ´Ù½Ã ½ÇÇàÇØ¾ß'#13'¼³Á¤¾ð¾î·Î Àû¿ëµË´Ï´Ù');
      Common.SetIniFile('POS','Language', GetStrPointerData(LanguageComboBox));
    end;


    with Common.Config, Common do
    begin
      //ÀÏ¹Ý ÅÇ
      AvailFloor     := EmptyStr;
      For vIndex := 0 to AvailFloorComboBox.Properties.Items.Count -1 do
      begin
        if AvailFloorComboBox.GetItemState(vIndex) = cbsChecked then
           AvailFloor := AvailFloor + AvailFloorComboBox.Properties.Items.Items[vIndex].ShortDescription + ',';
      end;

      if RightStr(AvailFloor,1) = ',' then AvailFloor := Copy(AvailFloor,1,Length(AvailFloor)-1);

      if DefaultFloorComboBox.ItemIndex >= 0 then
        DefaultFloor := GetStrPointerData(DefaultFloorComboBox);

      if (DefaultFloor = '') and (LeftStr(AvailFloor,3) <> '000') then
        DefaultFloor := LeftStr(AvailFloor,3);

      if chkReceiptPrint.Checked then SetPrintMode := pmNoPrint
      else                            SetPrintMode := pmPrint;
      Common.SetBillPrintMode := not chkOrderReceiptPrint.Checked;
      RealPrintMode := SetPrintMode;
      IsAcctKitchenPrint := chkAcctBillPrint.Checked;
      AutoUpdate    := chkAutoUpdate.Checked;
      PowerOff      := chkPowerOff.Checked;
      AutoLogin     := chkAutoLogin.Checked;
      SmartPosDemon := SmartPosCheckBox.Checked;
      SmartPad      := SmartPadCheckBox.Checked;
      LetsOrderNoShow := LetsOrderShowCheckBox.Checked;

      if not Common.Config.IsKiosk then
        HandScannerPort  := StrToIntDef(GetStrPointerData(cboScanner),0)
      else
        HandScannerPort  := StrToIntDef(GetStrPointerData(HandScannerComboBox),0);

      FixScannerPort := StrToIntDef(GetStrPointerData(FixScannerComboBox),0);
      TableKeyPort   := StrToIntDef(GetStrPointerData(TableKeyComboBox),0);

      //ÁÖº¯±â±â ÅÇ
      RcpToKitchen                   := KitchenPrinterLinkCheckBox.Checked;
      ReceiptPrinterDev              := ReceiptPrinterComboBox.ItemIndex;
      ReceiptPrinterPort             := GetStrPointerData(ReceiptPrinterPortComboBox);
      PrintBottomMargin              := Integer(PrintBottomMarginEdit.EditingValue);
      ReceiptPrinterBaudRate         := BaudRateCombobox.ItemIndex;
      ReceiptPrinterCheck            := ReceiptPrinterCheckCheckBox.Checked;
      DIDPickupPos                   := Ifthen(Common.Config.IsKiosk, KioskPickUpPosEdit.Text, PickUpPosEdit.Text);

      CustPrinterCode                := GetStrPointerData(cboCustomerPosition);
      Common.DeliveryLinkPrinter[0].InComPort := StrToIntDef(GetStrPointerData(LinkPortComboBox),0);
      Common.DeliveryLinkPrinter[1].InComPort := StrToIntDef(GetStrPointerData(LinkPort2ComboBox),0);
      Common.DeliveryLinkPrinter[2].InComPort := StrToIntDef(GetStrPointerData(LinkPort3ComboBox),0);
      Common.DeliveryLinkPrinter[3].InComPort := StrToIntDef(GetStrPointerData(LinkPort4ComboBox),0);
      CustPrinter2Code               := GetStrPointerData(cboCustomerPosition2);

      DeliveryPrinterCode            := GetStrPointerData(cboDeliveryPrint);
      DeliveryReceiptPrinterCode     := GetStrPointerData(DeliveryCustomerComboBox);
      Common.DeliveryLinkPrinter[0].OutComPort  := GetStrPointerData(LinkPrintComboBox);
      Common.DeliveryLinkPrinter[1].OutComPort  := GetStrPointerData(Link2PrintComboBox);
      Common.DeliveryLinkPrinter[2].OutComPort  := GetStrPointerData(Link3PrintComboBox);
      Common.DeliveryLinkPrinter[3].OutComPort  := GetStrPointerData(Link4PrintComboBox);

      Common.DeliveryLinkPrinter[0].Collection := Ifthen (LinkOrder1Switch.State = tssOn, 'Y','N');
      Common.DeliveryLinkPrinter[1].Collection := Ifthen (LinkOrder2Switch.State = tssOn, 'Y','N');
      Common.DeliveryLinkPrinter[2].Collection := Ifthen (LinkOrder3Switch.State = tssOn, 'Y','N');

      DeliveryDisplay                := DeliveryDisplayEdit.Text;
      DualSize                       := cboDualSize.ItemIndex;
      DualMode                       := Ifthen(chkDualMode.Checked, 1,0);
      DualText                       := edtDualText.Text;

      Cid_Port                       := StrToIntDef(GetStrPointerData(cboCid),0);
      LabelPrinterPort               := StrToIntDef(GetStrPointerData(cboLabelPrinter),0);
      LabelPrinterPort               := StrToIntDef(GetStrPointerData(cboKioskLabelPrinter),0);
      KioskDispenserPort             := StrToIntDef(GetStrPointerData(DispenserComboBox),0);
      IsKioskCash                    := KioskDispenserPort > 0;

      notKioskTouch                  := chkKioskTouch.Checked;
      PosCatUse                      := CatUsedCheckBox.Checked;
      AutoStart                      := Ifthen(PosAutoStartCheckBox.Checked, 'Y','N');

      if PosCatUse then
        Options[379] := '1'
      else
        Options[379] := Option_379;

      BellPort     := StrToIntDef(GetStrPointerData(BellPortComboBox),0);
      BellDev      := Ifthen(Common.Config.IsKiosk, KioskBellDevComboBox.ItemIndex, BellDevComboBox.ItemIndex);
      if Common.Config.IsKiosk then
        BellPort     := StrToIntDef(GetStrPointerData(cboKioskBell),0);
      PrintColum   := cboPrintColum.ItemIndex;
      FixPhoneNo  := edtFixPhoneNo.Text;

      TimePlu[1,0] := Ifthen(chkPluUse1.Checked, '1','0');
      TimePlu[1,1] := PluFrom1TimeEdit.Text;
      TimePlu[1,2] := PluTo1TimeEdit.Text;
      TimePlu[1,3] := edtPluNo1.Text;
      TimePlu[2,0] := Ifthen(chkPluUse2.Checked, '1','0');
      TimePlu[2,1] := PluFrom2TimeEdit.Text;
      TimePlu[2,2] := PluTo2TimeEdit.Text;
      TimePlu[2,3] := edtPluNo2.Text;
      TimePlu[3,0] := Ifthen(chkPluUse3.Checked, '1','0');
      TimePlu[3,1] := PluFrom3TimeEdit.Text;
      TimePlu[3,2] := PluTo3TimeEdit.Text;
      TimePlu[3,3] := edtPluNo3.Text;
    end;

    if chkAutoLogin.Checked then
      Common.SetIniFile('POS', '·Î±×ÀÎ¾ÏÈ£', Encrypt(Common.Config.UserPass, _CryptKey))
    else
      Common.SetIniFile('POS', '·Î±×ÀÎ¾ÏÈ£', '');

    Common.SetIni;

  //Å°¿À½ºÅ©ÀÏ¶§
  if Common.Config.IsKiosk then
  begin
    with TIniFile.Create(Common.AppPath+'Kiosk\KioskConfig.ini') do
    try
      if KioskColorEdit.ColorValue = clNone then
        WriteString('°øÅë','Color', '')
      else
        WriteString('°øÅë','Color', ColorToString(KioskColorEdit.ColorValue));

      WriteString('°øÅë','FontName', KioskFontNameComboBox.FontName);
      WriteInteger('°øÅë','Round',   KioskRoundEdit.Value);
      if KioskWaitLangesShowSwitch.State = tssOn then
        WriteString('ÁÖ¹®´ë±â','´Ù±¹¾î_Show','Y')
      else
        WriteString('ÁÖ¹®´ë±â','´Ù±¹¾î_Show','N');

      WriteInteger('ÁÖ¹®´ë±â','´Ù±¹¾î_Top',KioskWaitLangesTopEdit.Value);
      WriteInteger('ÁÖ¹®´ë±â','´Ù±¹¾î_Left',KioskWaitLangesLeftEdit.Value);
      WriteInteger('ÁÖ¹®´ë±â','Top',KioskWaitButtonTopEdit.Value);
      WriteInteger('ÁÖ¹®´ë±â','¸ÅÀåÀÌ¿ë_Left',KioskWaitStoreButtonEdit.Value);
      WriteInteger('ÁÖ¹®´ë±â','Æ÷Àå_Left',KioskWaitPackingButtonEdit.Value);
      WriteInteger('ÁÖ¹®´ë±â','Width',KioskWaitButtonWidthEdit.Value);
      WriteInteger('ÁÖ¹®´ë±â','Height', KioskWaitButtonHeightEdit.Value);
      WriteString('ÁÖ¹®´ë±â','¸ÅÀåÀÌ¿ë_Color',ColorToString(KioskWaitStoreButtonColorEdit.ColorValue));
      WriteString('ÁÖ¹®´ë±â','Æ÷Àå_Color',ColorToString(KioskWaitPackingButtonColorEdit.ColorValue));

      WriteString('Course', 'GroupIcon',KioskCourseGroupIconColorComboBox.Text);
      WriteString('Course', 'ItemIcon',KioskCourseItemIconColorComboBox.Text);
      WriteString('Course', 'GroupFontColor',KioskCourseGroupFontColorComboBox.Text);
      WriteString('Course', 'ItemFontColor',KioskCourseItemFontColorComboBox.Text);

      if KioskCourseImageViewSwitch.State = tssOn then
        WriteString('Course','ImageView','Y')
      else
        WriteString('Course','ImageView','N');

      WriteString('ÁÖ¹®¿Ï·á', 'FontColor', ColorToString(KioskFontBillColorEdit.ColorValue));
      WriteString('ÁÖ¹®¿Ï·á', '¸Þ¼¼Áö1', KioskBill1Edit.Text);
      WriteString('ÁÖ¹®¿Ï·á', '¸Þ¼¼Áö2', KioskBill2Edit.Text);
      WriteString('ÁÖ¹®¿Ï·á', '¸Þ¼¼Áö3', KioskBill3Edit.Text);
      WriteString('ÁÖ¹®¿Ï·á', '¸Þ¼¼Áö4', KioskBill4Edit.Text);

    finally
      free;
    end;
  end;

    if not Common.IsDebugMode then
    begin
      vStream := TMemoryStream.Create;
      try
        Common.Query.SQL.Text := 'update MS_CODE '
                                +'   set CONFIG    = :P2 '
                                +' where CD_STORE  = :P0 '
                                +'   and CD_KIND   = ''01'' '
                                +'   and NM_CODE1  = :P1 ';
        Common.Query.ParamByName('P0').Value := Common.Config.StoreCode;
        Common.Query.ParamByName('P1').Value := Common.Config.PosNo;
        vStream.LoadFromFile(Common.AppPath+_INIFILENAME);
        Common.Query.ParamByName('P2').LoadFromStream(vStream, ftBlob);
        Common.Query.Execute;

        try
          DM.ExecCloud('update MS_CODE '
                      +'   set CONFIG    =:P3 '
                      +' where CD_HEAD   =:P0 '
                      +'   and CD_STORE  =:P1 '
                      +'   and CD_KIND   =''01'' '
                      +'   and NM_CODE1  =:P2; ',
                     [Common.Config.HeadStoreCode,
                      Common.Config.StoreCode,
                      Common.Config.PosNo,
                      EncodeBase64(vStream.Memory, vStream.Size)],true,Common.RestDBURL);
        except
        end;
      finally
        vStream.Free;
      end;
    end;

    if PosAutoStartCheckBox.Checked then
    begin
      if String(GetRegistry(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows\CurrentVersion\Run', 'pos')) = '' then
        CreateRegistry(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows\CurrentVersion\Run','pos', Format('%sOrangePos.exe',[Common.AppPath]));
    end
    else
    begin
      if String(GetRegistry(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows\CurrentVersion\Run', 'pos')) <> '' then
        DeleteRegistry(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows\CurrentVersion\Run', 'pos');
    end;

    Common.SetIniFile('DEVICE','µà¾óÀÌ¹ÌÁö', DualImageChangeEdit.Text);

    if SmartPosCheckBox.Checked or SmartPadCheckBox.Checked then
    begin
      Common.SetIniFile('POS',  '½º¸¶Æ®Æ÷½ºµ¥¸ó', true);
      ExcuteProgram('SmartAgent.exe');
    end
    else
      Common.SetIniFile('POS',  '½º¸¶Æ®Æ÷½ºµ¥¸ó', false);

    Common.Device.DeviceSetup;
    Close;
  finally
    ConfirmButton.Enabled := true;
    MessageLabel.Caption  := '';
  end;
end;

procedure TConfig_F.CustomerPrintLabelClick(Sender: TObject);
begin
  if CustomerPrintLabel.Tag = 3 then
  begin
    QueryButton.Visible    := true;
    CustomerPrintLabel.Tag := 0;
  end
  else
    CustomerPrintLabel.Tag := CustomerPrintLabel.Tag + 1;
end;

procedure TConfig_F.cxLabel10Click(Sender: TObject);
begin
  if cxLabel10.Tag = 3 then
  begin
    NewLetsOrderButton.Visible    := true;
    cxLabel10.Tag := 0;
  end
  else
    cxLabel10.Tag := cxLabel10.Tag + 1;

end;

procedure TConfig_F.DeliveryDisplayComboBoxPropertiesChange(Sender: TObject);
begin
  DeliveryDisplayLabel.Visible := DeliveryDisplayComboBox.ItemIndex = 1;
  DeliveryDisplayEdit.Visible  := DeliveryDisplayComboBox.ItemIndex = 1;
  if (DeliveryDisplayComboBox.ItemIndex = 1) and (DeliveryDisplayEdit.Text = '') then
    DeliveryDisplayEdit.Text := '0,0,1024,768'
  else if DeliveryDisplayComboBox.ItemIndex = 0 then
    DeliveryDisplayEdit.Clear;
end;

procedure TConfig_F.DeliveryOrderInitButtonClick(Sender: TObject);
begin
  if not Common.AskBox('ÇöÀç ¹è´ÞÁÖ¹® ³»¿ªÀ» »èÁ¦ÇÏ½Ã°Ú½À´Ï±î?.') then
    Exit;

  if not Common.AskBox('»èÁ¦ µÈ ÀÚ·á´Â º¹±¸ÇÒ ¼ö ¾ø½À´Ï´Ù.'+#13+'Á¤¸» »èÁ¦ÇÏ½Ã°Ú½À´Ï±î?') then
    Exit;

  try
    Common.BeginTran;
    ExecQuery('delete from SL_ORDER_H   where DS_ORDER = ''D'' ',[], false);
    ExecQuery('delete from SL_ORDER_D   where DS_ORDER = ''D'' ',[], false);
    ExecQuery('delete from SL_ORDER_C   where DS_ORDER = ''D'' ',[], false);
    ExecQuery('delete from SL_ORDER_PRT where DS_ORDER = ''D'' ',[], false);
    ExecQuery('delete from SL_ORDER_KDS where DS_ORDER = ''D'' ',[], false);
    ExecQuery('delete from SL_DELIVERY where DS_STEP not in (''A'',''R'',''C'') ',[], false);

    ExecQuery('delete '
             +'  from MS_UPLOAD '
             +' where CD_STORE =:P0 '
             +'   and NM_TABLE = ''SL_ORDER_H'' '
             +'   and YMD_SALE = :P1 '
             +'   and PK       = ''D'' ',
             [Common.Config.StoreCode,
              FormatDateTime('yyyymmdd', Now())],false);
    ExecQuery('delete '
             +'  from MS_UPLOAD '
             +' where CD_STORE =:P0 '
             +'   and NM_TABLE = ''SL_ORDER_D'' '
             +'   and YMD_SALE = :P1 '
             +'   and PK       = ''D'' ',
             [Common.Config.StoreCode,
              FormatDateTime('yyyymmdd', Now())],false);

    ExecQuery('insert into MS_UPLOAD(CD_STORE, '
             +'                      NM_TABLE, '
             +'                      YMD_SALE, '
             +'                      PK, '
             +'                      DS_STATUS, '
             +'                      SQL_TEXT, '
             +'                      DT_INSERT) '
             +'              values (:P0, '
             +'                      ''SL_ORDER_H'', '
             +'                       :P1, '
             +'                      ''D'', '
             +'                      ''U'', '
             +Format(' ''delete from SL_ORDER_H where CD_HEAD = ''''%s'''' and CD_STORE = ''''%s'''' and DS_ORDER = ''''D'''' '', ',
                    [Common.Config.HeadStoreCode,Common.Config.StoreCode,
                     Common.Config.HeadStoreCode,Common.Config.StoreCode])
			  		 +'                      Now()) ',
             [Common.Config.StoreCode,
              FormatDateTime('yyyymmdd', Now())],false);

    ExecQuery('insert into MS_UPLOAD(CD_STORE, '
                   +'                      NM_TABLE, '
                   +'                      YMD_SALE, '
                   +'                      PK, '
                   +'                      DS_STATUS, '
                   +'                      SQL_TEXT, '
                   +'                      DT_INSERT) '
                   +'              values (:P0, '
                   +'                      ''SL_ORDER_D'', '
                   +'                      :P1, '
                   +'                      ''D'', '
                   +'                      ''U'', '
                   +Format(' ''delete from SL_ORDER_D where CD_HEAD = ''''%s'''' and CD_STORE = ''''%s'''' and DS_ORDER = ''''D'''' '', ',
                          [Common.Config.HeadStoreCode,Common.Config.StoreCode,
                           Common.Config.HeadStoreCode,Common.Config.StoreCode])
			  		       +'                      Now()) ',
                   [Common.Config.StoreCode,
                    FormatDateTime('yyyymmdd', Now())],false);

    Common.CommitTran;
    MessageLabel.Caption := 'ÀÚ·á°¡ »èÁ¦µÇ¾ú½À´Ï´Ù.';
  except
    on E: Exception do
    begin
      Common.RollbackTran;
      Common.ErrBox('ÀÛ¾÷À» ¿Ï·áÇÏÁö ¸øÇß½À´Ï´Ù.'#13+E.Message);
      Exit;
    end;
  end;
end;

procedure TConfig_F.DIDShotDownButtonClick(Sender: TObject);
var vTemp :String;
begin
  if Sender = DIDShotDownButton then
    if not Common.AskBox('DID Àü¿øÀ» Á¾·áÇÏ½Ã°Ú½À±î?') then Exit;

  if Sender = DIDRebootButton then
    if not Common.AskBox('DID¸¦ Àç½ÃÀÛ ÇÏ½Ã°Ú½À´Ï±î?') then Exit;

  if Sender = DIDShotDownButton then
    vTemp := 'PowerOff'
  else if Sender = DIDRebootButton then
    vTemp := 'ReBoot'
  else
    vTemp := 'Check';

  OpenQuery('select NM_CODE2 '
           +'  from MS_CODE '
           +' where CD_STORE =:P0 '
           +'   and CD_KIND  =''01'' '
           +'   and NM_CODE3 =''6'' '
           +'   and DS_STATUS = ''0'' ',
           [Common.Config.StoreCode]);
  while not Common.Query.Eof do
  begin
    with TIdTCPClient.Create(Application) do
    begin
      try
        try
          Host := Common.Query.Fields[0].AsString;
          Port := 7008;
          ConnectTimeout := 500;
          Connect;
          Socket.WriteLnRFC(vTemp +#3, IndyTextEncoding_OSDefault);
          if vTemp = 'Check' then
          begin
            vTemp := Socket.ReadLn(#3,IndyTextEncoding_OSDefault);
            Common.MsgBox(Format('½ÇÇà Áß ÀÔ´Ï´Ù'#13'Ver %s',[vTemp]));
          end;
        except
          Common.MsgBox('DID°¡ ½ÇÇà ÁßÀÌ ¾Æ´Õ´Ï´Ù');
        end;
      finally
        try
          Disconnect(true);
          if Connected then
            Disconnect(true);
        except
        end;
        Free;
      end;
    end;

    Common.Query.Next;
  end;
  Common.Query.Close;
end;

procedure TConfig_F.EtcTabSheetShow(Sender: TObject);
var vRestClient   :TRestClient;
    vRestRequest  :TRestRequest;
    vRESTResponse :TRESTResponse;
    vJSONObject,
    vJsonData   :TJSONObject;
    vGUID : TGUID;
    vToken, vURL, vTemp, vData : String;
    vPos :Integer;
begin
  if GetHeadOption(9) = '1' then
  begin
    vToken := Common.LetsOrderAuth(Common.Config.HeadStoreCode);
    vToken := 'Bearer '+Replace(vToken,'"','');

    try
      if LeftStr(Common.Config.StoreCode,2) = 'TT' then
        vURL        := Format('https://api-qa.letsorder.kr/api/v1/s2s/groups/%s/stores/%s/store',
                             [Common.Config.HeadStoreCode,
                              LowerCase(Common.Config.StoreCode)])
      else
        vURL        := Format('https://api-op.letsorder.kr/api/v1/s2s/groups/%s/stores/%s/store',
                             [Common.Config.HeadStoreCode,
                              LowerCase(Common.Config.StoreCode)]);

      Screen.Cursor := crHourGlass;
      vRestRequest := TRestRequest.Create(nil);
      vRestClient  := TRestClient.Create(nil);
      vRESTClient.Accept         := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
      vRESTClient.AcceptCharset  := 'UTF-8, *;q=0.8';
      vRESTClient.AcceptEncoding := 'UTF-8';
      vRestClient.BaseURL := vURL;
      CoCreateGuid(vGUID);
      vRestRequest.Params.AddHeader('X-Message-Id', GUIDToString(vGUID));
      vRestRequest.Params.AddHeader('Authorization', vToken);
      vRestRequest.URLAlreadyEncoded := true;

      vRESTResponse         := TRESTResponse.Create(vRestRequest);
      vRestRequest.Client   := vRestClient;
      vRestRequest.Response := vRESTResponse;
      vRestRequest.Method   := TRESTRequestMethod.rmGET;
      vRESTRequest.Execute;
      if vRestRequest.Response.StatusCode <> 200 then
      begin
        Common.MsgBox('·¿Ã÷¿À´õ Á¶È¸ ½ÇÆÐ!!!'+#13+IntToStr(vRestRequest.Response.StatusCode));
        Exit
      end;

      vData := vRESTResponse.Content;

      vPos := Pos('"store_status"', vData);
      vTemp := Copy(vData, vPos+16, 4);
      if vTemp = 'open' then
        LetsOrderGroupBox.Caption := '·¿Ã÷¿À´õ(°³Á¡)'
      else
        LetsOrderGroupBox.Caption := '·¿Ã÷¿À´õ(¸¶°¨)';
//      vJSONObject := TJSONObject.ParseJSONValue( vData ) as TJSONObject;
//      vJSONObject.TryGetValue<String>('response', vTemp);
//      vJsonData := TJSONObject.ParseJSONValue( vTemp ) as TJSONObject;
//      vTemp := vJsonData.GetValue<String>('store_status');

    finally
      vRestClient.Disconnect;
      FreeAndNil(vRESTResponse);
      FreeAndNil(vRESTRequest);
      FreeAndNil(vRESTClient);
      Screen.Cursor := crDefault;
    end;
  end;


  if GetOption(403) = '0' then
    SoldOutButton.Caption := 'Ç°Àý°ü¸®';
end;

procedure TConfig_F.IntegrityCheckListButtonClick(Sender: TObject);
begin
  Integrity_F := TIntegrity_F.Create(Self);
  try
    Integrity_F.ShowModal;
  finally
    FreeAndNil(Integrity_F);
  end;
end;

procedure TConfig_F.CallNumberInitButtonClick(Sender: TObject);
begin
  if not Common.AskBox('È£Ãâ¹øÈ£¸¦ ÃÊ±âÈ­ ÇÏ½Ã°Ú½À´Ï±î?') then Exit;

  if Common.Config.BellDev = 2 then
  begin
    ExecQuery('delete from MS_ORDERNO '
             +' where CD_STORE  =:P0 '
             +'   and DS_NUMBER in (''D'',''C'') '
             +'   and NO_POS    in (''00'',''99'') ',
             [Common.Config.StoreCode]);
  end
  else
  begin
    ExecQuery('delete from MS_ORDERNO '
             +' where CD_STORE  =:P0 '
             +'   and DS_NUMBER =''C'' '
             +'   and (NO_POS = ''99'' or NO_POS    =:P1) ',
             [Common.Config.StoreCode,
              Ifthen(GetOption(352)='0','00',Common.Config.PosNo)]);
    Common.Device.SetBell(0);
  end;
  MessageLabel.Caption := 'È£Ãâ¹øÈ£°¡ ÃÊ±âÈ­ µÇ¾ú½À´Ï´Ù';
end;

procedure TConfig_F.CancelButtonClick(Sender: TObject);
begin
  ConfigPager.Enabled := true;
end;

procedure TConfig_F.cboLabelPrinterPropertiesChange(Sender: TObject);
begin
  cboKioskLabelPrinter.ItemIndex := cboLabelPrinter.ItemIndex;
end;

procedure TConfig_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TConfig_F.TableOrderInitButtonClick(Sender: TObject);
var vTemp :String;
begin
  if not Common.AskBox('ÇöÀç Å×ÀÌºí¿¡ ÁÖ¹®³»¿ªÀ»'#13'»èÁ¦ÇÏ½Ã°Ú½À´Ï±î?') then
    Exit;

  try
    OpenQuery('select NO_TABLE '
             +'  from SL_CARD_AHEAD '
             +' where CD_STORE = :P0 '
             +'union all '
             +'select NO_TABLE '
             +'  from SL_CASH_AHEAD '
             +' where CD_STORE = :P0 ',
             [Common.Config.StoreCode]);
    if not Common.Query.Eof then
    begin
      Common.MsgBox('¼±°áÁ¦ ³»¿ªÀÌ ÀÖÀ¸¸é »èÁ¦ÇÒ ¼ö ¾ø½À´Ï´Ù');
      Exit;
    end;
  finally
    Common.Query.Close;
  end;

  if not Common.AskBox('»èÁ¦ µÈ ÀÚ·á´Â º¹±¸ÇÒ ¼ö ¾ø½À´Ï´Ù.'+#13+'Á¤¸» »èÁ¦ÇÏ½Ã°Ú½À´Ï±î?') then
    Exit;

  try
    Common.BeginTran;
    if GetHeadOption(9) = '1' then
    begin
      ExecQuery('insert into TR_ORDER(CD_STORE, '
               +'                     GROUP_SEQ, '
               +'                     GROUP_STEP, '
               +'                     DS_ORDER, '
               +'                     NO_TABLE) '
               +'              select CD_STORE, '
               +'                     GetNextVal(''TR_ORDER''), '
               +'                     0, '
               +'                     ''A'', '
               +'                     NO_TABLE '
               +'                from MS_TABLE '
               +'               where CD_STORE = :P0 '
               +'                 and SEQ      = 0 ',
               [Common.Config.StoreCode], false);
      ExecQuery('insert into TR_ORDER(CD_STORE, '
               +'                     GROUP_SEQ, '
               +'                     GROUP_STEP, '
               +'                     DS_ORDER, '
               +'                     NO_TABLE) '
               +'              select CD_STORE, '
               +'                     GetNextVal(''TR_ORDER''), '
               +'                     0, '
               +'                     ''T'', '
               +'                     NO_TABLE '
               +'                from MS_TABLE '
               +'               where CD_STORE = :P0 '
               +'                 and SEQ      = 0 ',
               [Common.Config.StoreCode], false);
    end;

    ExecQuery('delete from SL_ORDER_H   where DS_ORDER = ''T'' ',[], false);
    ExecQuery('delete from SL_ORDER_D   where DS_ORDER = ''T'' ',[], false);
    ExecQuery('delete from SL_ORDER_C   where DS_ORDER = ''T'' ',[], false);
    ExecQuery('delete from SL_ORDER_PRT where DS_ORDER = ''T'' ',[], false);
    ExecQuery('delete from SL_ORDER_KDS where DS_ORDER = ''T'' ',[], false);
    ExecQuery('delete from  MS_UPLOAD '
             +' where CD_STORE =:P0 '
             +'   and NM_TABLE = ''SL_ORDER_H'' '
             +'   and YMD_SALE = :P1 '
             +'   and PK       = ''T'' ',
             [Common.Config.StoreCode,
              FormatDateTime('yyyymmdd', Now())],false);
    ExecQuery('delete from MS_UPLOAD '
             +' where CD_STORE =:P0 '
             +'   and NM_TABLE = ''SL_ORDER_D'' '
             +'   and YMD_SALE = :P1 '
             +'   and PK       = ''T'' ',
             [Common.Config.StoreCode,
              FormatDateTime('yyyymmdd', Now())],false);

    ExecQuery('insert into MS_UPLOAD(CD_STORE, '
             +'                      NM_TABLE, '
             +'                      YMD_SALE, '
             +'                      PK, '
             +'                      DS_STATUS, '
             +'                      SQL_TEXT, '
             +'                      DT_INSERT) '
             +'              values (:P0, '
             +'                      ''SL_ORDER_H'', '
             +'                      :P1, '
             +'                      ''T'', '
             +'                      ''U'', '
             +Format('''delete from SL_ORDER_H where CD_HEAD = ''''%s'''' and CD_STORE = ''''%s'''' and DS_ORDER = ''''T'''' '', ',
                    [Common.Config.HeadStoreCode,Common.Config.StoreCode,
                     Common.Config.HeadStoreCode,Common.Config.StoreCode])
			  		 +'                      Now()) ',
             [Common.Config.StoreCode,
              FormatDateTime('yyyymmdd', Now())],false);

    ExecQuery('insert into MS_UPLOAD(CD_STORE, '
             +'                      NM_TABLE, '
             +'                      YMD_SALE, '
             +'                      PK, '
             +'                      DS_STATUS, '
             +'                      SQL_TEXT, '
             +'                      DT_INSERT) '
             +'              values (:P0, '
             +'                      ''SL_ORDER_D'', '
             +'                      :P1, '
             +'                      ''T'', '
             +'                      ''U'', '
             +Format(' ''delete from SL_ORDER_D where CD_HEAD = ''''%s'''' and CD_STORE = ''''%s'''' and DS_ORDER = ''''T'''' '', ',
                    [Common.Config.HeadStoreCode,Common.Config.StoreCode,
                     Common.Config.HeadStoreCode,Common.Config.StoreCode])
			  		 +'                      Now()) ',
             [Common.Config.StoreCode,
              FormatDateTime('yyyymmdd', Now())],false);

    Common.CommitTran;
    MessageLabel.Caption := 'ÀÚ·á°¡ »èÁ¦µÇ¾ú½À´Ï´Ù.';
  except
    on E: Exception do
    begin
      Common.RollbackTran;
      Common.ErrBox('ÀÛ¾÷À» ¿Ï·áÇÏÁö ¸øÇß½À´Ï´Ù.'#13+E.Message);
      Exit;
    end;
  end;

end;

procedure TConfig_F.Timer2Timer(Sender: TObject);
begin
  Timer2.Enabled := false;
  Common.HideWaitForm;
end;

procedure TConfig_F.WaitNumberInitButtonClick(Sender: TObject);
begin
  if not Common.AskBox('´ë±âÁ¤º¸¸¦ ÃÊ±âÈ­ÇÏ½Ã°Ú½À´Ï±î?') then Exit;

  ExecQuery('delete from SL_WAIT '
           +' where CD_STORE =:P0',
           [Common.Config.StoreCode]);
  MessageLabel.Caption := '´ë±â¹øÈ£°¡ ÃÊ±âÈ­ µÇ¾ú½À´Ï´Ù';
end;

procedure TConfig_F.AvailFloorComboBoxPropertiesEditValueChanged(
  Sender: TObject);
var
  vCode  :PStrPointer;
  I      :Integer;
  vFloor :String;
begin
  if not AvailFloorComboBox.Enabled then Exit;

  vFloor     := EmptyStr;
  For I := 0 to AvailFloorComboBox.Properties.Items.Count -1 do
  begin
    if AvailFloorComboBox.GetItemState(I) = cbsChecked then
      vFloor := vFloor + AvailFloorComboBox.Properties.Items.Items[I].ShortDescription + ',';
  end;

  if RightStr(vFloor,1) = ',' then vFloor := Copy(vFloor,1,Length(vFloor)-1);

  if vFloor = EmptyStr then vFloor := '000';
  if LeftStr(vFloor,3) = '000' then
    OpenQuery('select CD_CODE, '
             +'       NM_CODE1 '
             +'  from MS_CODE '
             +' where CD_STORE =:P0 '
             +'   and CD_KIND  = ''03'' '
             +'   and DS_STATUS=0 '
             +' order by CD_CODE',
              [Common.Config.StoreCode])
  else
    OpenQuery('select CD_CODE, '
             +'       NM_CODE1 '
             +'  from MS_CODE '
             +' where CD_STORE =:P0 '
             +'   and CD_KIND  = ''03'' '
             +'   and CD_CODE in ('''+StringReplace(vFloor,',',''',''',[rfReplaceAll])+''')'
             +'   and DS_STATUS=0 '
             +' order by CD_CODE',
             [Common.Config.StoreCode]);

  DefaultFloorComboBox.Properties.Items.Clear;
  while not Common.Query.Eof do
  begin
    New(vCode);
    vCode^.Data := Common.Query.Fields[0].AsString;
    DefaultFloorComboBox.Properties.Items.AddObject(Common.Query.Fields[1].AsString, TObject(vCode));
    Common.Query.Next;
  end;
  DefaultFloorComboBox.ItemIndex := 0;
  Common.Query.Close;

end;

procedure TConfig_F.BellDevComboBoxPropertiesChange(Sender: TObject);
begin
  DIDShotDownButton.Visible := BellDevComboBox.ItemIndex = 2;
  DIDReBootButton.Visible   := BellDevComboBox.ItemIndex = 2;
  DIDCheckButton.Visible    := BellDevComboBox.ItemIndex = 2;
end;

procedure TConfig_F.btnPrinterSyncClick(Sender: TObject);
var vTemp :Variant;
    vHTTPPath :String;
    vFileStream :TMemoryStream;
    vFilePath   :String;
begin
  vFilePath := GetEnvironmentVariable('ProgramFiles');
  vFilePath := vFilePath+'\TCP COM Bridge\';
  if not FileExists(vFilePath+'tcpcom.exe') then
  begin
    if Common.AskBox('ÇÁ¸°ÅÍ ¿¬µ¿ ÇÁ·Î±×·¥ÀÌ ¼³Ä¡µÇ¾î ÀÖÁö ¾Ê½À´Ï´Ù'+#13+'ÇÁ·Î±×·¥À» ¼³Ä¡ÇÏ½Ã°Ú½À´Ï±î?') then
    begin
      vHTTPPath := 'http://www.xn--6j1b831b.kr:84/FTP\Update\Orange2\Setup\';
      vFileStream := TMemoryStream.Create;
      IdHTTP.Get(vHTTPPath+'tcp-com-bridge.exe', vFileStream);
      vFileStream.SaveToFile(Common.AppPath+'tcp-com-bridge.exe');
      ExcuteProgram(Common.AppPath+'tcp-com-bridge.exe');
    end;
  end;

  Common.SetIniFile('DEVICE', '¿¬°áÇÁ¸°ÅÍÆ÷Æ®', GetStrPointerData(ReceiptPrinterPortComboBox));
  Common.SetIniFile('DEVICE', '¿¬°áÇÁ¸°ÅÍ¼Óµµ', GetOnlyNumber(Copy(BaudRateCombobox.Text,4,6)));
end;

procedure TConfig_F.TestButtonClick(Sender: TObject);
var vReadData :AnsiString;
    vIndex,
    vCardAmt,
    vOrderAmt   :Integer;
    vDeliveryNo :String;
    vOrderMenu :TList;
begin
  vOrderMenu := TList.Create;
  SetDeliveryOrder('Y', vDeliveryNo, vOrderAmt, vCardAmt, TestMemo.Text, vOrderMenu);
end;


function TConfig_F.SetDeliveryOrder(aCompany: String; var aDeliveryNo: String;
  var aOrderAmt, aCardAmt: Integer; aValue: String;
  var aOrderMenu: TList): Boolean;
var vIndex, vIndex2, vMenuPosBegin, vMenuPosEnd, vPos, vPos2 :Integer;
    vReversStr :String;
    vTemp:String;

    vMenuList :^TBaeminOrderMenu;

    vMatchAmt :Integer;

    vOrderData: TArray<string>;

    vDcAmt,

    vDeliveryDcAmt,        //¹è´ÞºñÇÒÀÎ

    vDeliveryAmt :Integer; //¹è´Þ·á

    vYogiYoType  :String;  //D:±âº», M:Áß°£Å©±â

begin

  Result := false;

  vTemp      := aValue;
  if aCompany = 'C' then
  begin
    //ÁÖ¹®¼­ Å¸ÀÌÆ²  coupang eats    ! [¸ÅÀå¿ë]
    vTemp := Replace(vTemp, #$D#$A, splitColumn);
    vTemp := Replace(vTemp, 'a','');
    vTemp := Replace(vTemp, '!','');
    vTemp := Replace(vTemp, '!','');
    vTemp := Replace(vTemp, #$A, '');
    vTemp := Replace(vTemp, #$1B#$40, '');
    vTemp := Replace(vTemp, #$1D, '');
    vTemp := Replace(vTemp, #$1B'E'#1, '');
    vTemp := Replace(vTemp, #$1B'E'#0, '');
    vTemp := Replace(vTemp, #$1B'E', '');
    vTemp := Replace(vTemp, #$1B'i', '');
    vTemp := Replace(vTemp, #$1B, '');
    vTemp := Replace(vTemp, 'E'#1, '');
    vTemp := Replace(vTemp, 'E'#0, '');
    vTemp := Replace(vTemp, '!'#0, '');
    vTemp := Replace(vTemp, '!'#1, '');
    vTemp := Replace(vTemp, '! ', '');
    vTemp := Replace(vTemp, '!'#$18, '');
    vTemp := Replace(vTemp, #$D, '');
    vTemp := Replace(vTemp, 'a'#0, '');
    vTemp := Replace(vTemp, '!'#$11, '');
  end
  else if aCompany = 'Y' then
  begin
    if not Common.Device.GetSplitData(Common.DeliverySplit.YogiYoTitle, vTemp) then
      Exit;

    if Pos('ÁÖ ¹® ¹ø È£ :', vTemp) > 0 then
      vYogiYoType := 'M'
    else
      vYogiYoType := 'D';

    if vYogiYoType = 'D' then
    begin
      vTemp := Replace(vTemp, #$D#$A, splitColumn);
      vTemp := Replace(vTemp, #0, '');
      vTemp := Replace(vTemp, #$A, '');
      vTemp := Replace(vTemp, #$1B#$40, '');
      vTemp := Replace(vTemp, #$1D, '');
      vTemp := Replace(vTemp, #$1B'E'#1, '');
      vTemp := Replace(vTemp, #$1B'E'#0, '');
      vTemp := Replace(vTemp, #$1B'E', '');
      vTemp := Replace(vTemp, #$1B'i', '');
      vTemp := Replace(vTemp, #$1B, '');
      vTemp := Replace(vTemp, 'E'#1, '');
      vTemp := Replace(vTemp, 'E'#0, '');
      vTemp := Replace(vTemp, '!'#0, '');
      vTemp := Replace(vTemp, '!'#1, '');
      vTemp := Replace(vTemp, '! ', '');
      vTemp := Replace(vTemp, '!'#$18, '');
      vTemp := Replace(vTemp, #$D, '');
      vTemp := Replace(vTemp, 'a'#0, '');
      vTemp := Replace(vTemp, '!'#$11, '');
      vTemp := Replace(vTemp, '2a!MB', '');
      vTemp := Replace(vTemp, '2a  M B ', '');
      vTemp := Replace(vTemp, '!0a'#1, '');
      vTemp := Replace(vTemp, 'B'#1, '');
    end
    else
    begin
      vTemp := Replace(vTemp, #$D#$A, splitColumn);
      vTemp := Replace(vTemp, '2a E ! M B !0Ea', '');
      vTemp := Replace(vTemp, '2a E ! M B ', '');
      vTemp := Replace(vTemp, 'E!', '');
      vTemp := Replace(vTemp, ' !0Ea', '');
      vTemp := Replace(vTemp, 'E', '');
      vTemp := Replace(vTemp, #0, '');
      vTemp := Replace(vTemp, #$A, '');
      vTemp := Replace(vTemp, #$1B#$40, '');
      vTemp := Replace(vTemp, #$1D, '');
      vTemp := Replace(vTemp, #$1B'E'#1, '');
      vTemp := Replace(vTemp, #$1B'E'#0, '');
      vTemp := Replace(vTemp, #$1B'E', '');
      vTemp := Replace(vTemp, #$1B'i', '');
      vTemp := Replace(vTemp, #$1B, '');
      vTemp := Replace(vTemp, 'E'#1, '');
      vTemp := Replace(vTemp, 'E'#0, '');
      vTemp := Replace(vTemp, '!'#0, '');
      vTemp := Replace(vTemp, '!'#1, '');
      vTemp := Replace(vTemp, '! ', '');
      vTemp := Replace(vTemp, '!'#$18, '');
      vTemp := Replace(vTemp, #$D, '');
      vTemp := Replace(vTemp, 'a'#0, '');
      vTemp := Replace(vTemp, '!'#$11, '');
      vTemp := Replace(vTemp, '2a!MB', '');
      vTemp := Replace(vTemp, '2a  M B ', '');
      vTemp := Replace(vTemp, '!0a'#1, '');
      vTemp := Replace(vTemp, 'B'#1, '');
    end;
  end
  else if aCompany = 'B' then
  begin
    vTemp := Replace(vTemp, #$A#$D, splitColumn);
    vTemp := Replace(vTemp, 'a','');
    vTemp := Replace(vTemp, '!','');
    vTemp := Replace(vTemp, '!','');
    vTemp := Replace(vTemp, #$A, '');
    vTemp := Replace(vTemp, #$1B#$40, '');
    vTemp := Replace(vTemp, #$1D, '');
    vTemp := Replace(vTemp, #$1B'E'#1, '');
    vTemp := Replace(vTemp, #$1B'E'#0, '');
    vTemp := Replace(vTemp, #$1B'E', '');
    vTemp := Replace(vTemp, #$1B'i', '');
    vTemp := Replace(vTemp, #$1B, '');
    vTemp := Replace(vTemp, 'E'#1, '');
    vTemp := Replace(vTemp, 'E'#0, '');
    vTemp := Replace(vTemp, '!'#0, '');
    vTemp := Replace(vTemp, '!'#1, '');
    vTemp := Replace(vTemp, '! ', '');
    vTemp := Replace(vTemp, '!'#$18, '');
    vTemp := Replace(vTemp, #$D, '');
    vTemp := Replace(vTemp, '¦¦', '');
    vTemp := Replace(vTemp, '¦£', '');
    vTemp := Replace(vTemp, '¦¤', '');
    vOrderData := vTemp.Split([splitColumn]);
  end;


  vOrderData := vTemp.Split([splitColumn]);

  vDeliveryAmt := 0;
  vDcAmt       := 0;
  aCardAmt     := 0;

  if (aCompany = 'C') then
  begin
    if (Pos('[°í°´¿ë]',vTemp) > 0) then
      Exit;
  end;

  for vIndex := 0 to Length(vOrderData)-1 do
  begin
    if Trim(vOrderData[vIndex]) = '' then Continue;

    if aCompany = 'C' then
    begin
      if Common.Device.GetSplitData(Common.DeliverySplit.CoupangDeliveryNo, vOrderData[vIndex]) or (Pos('[¸ÅÀå¿ë]', vOrderData[vIndex]) > 0) then
        aDeliveryNo   :=Trim(vOrderData[vIndex+2]);

      //ÄíÆÄÀÌÃ÷ÀÏ¶§
      if Common.Device.GetSplitData(Common.DeliverySplit.CoupangTotAmt, vOrderData[vIndex]) or (Pos('ÁÖ¹®±Ý¾×', vOrderData[vIndex]) > 0) then
      begin
        aOrderAmt   := StrToIntDef(GetOnlyNumber(RightStr(vOrderData[vIndex],7)),0);
        aCardAmt    := aOrderAmt;
        vMenuPosEnd := vIndex -2;
      end;

      //ÄíÆÎÀÌÃ÷ ¸Þ´º
      if (Pos('¸Þ´º', vOrderData[vIndex]) > 0) and (Pos('¼ö·®', vOrderData[vIndex]) > 0) and (Pos('±Ý¾×', vOrderData[vIndex]) > 0) then
        vMenuPosBegin := vIndex + 2;

    end
    else if aCompany = 'B' then
    begin
      if Common.Device.GetSplitData(Common.DeliverySplit.BaeminDeliveryNo, vOrderData[vIndex]) then //or (Pos('ÁÖ¹®¹øÈ£:', vOrderData[vIndex]) > 0) then
        aDeliveryNo   := CopyAnsi(vOrderData[vIndex],10,12);

      //¸Þ´º¸¦ Ã£´Â´Ù
      if (Pos('¸Þ´º¸í', vOrderData[vIndex]) > 0) and (Pos('¼ö·®', vOrderData[vIndex]) > 0) and (Pos('±Ý¾×', vOrderData[vIndex]) > 0) then
        vMenuPosBegin := vIndex + 2;

      if Common.Device.GetSplitData(Common.DeliverySplit.BaeminTotAmt, vOrderData[vIndex]) then // or (Pos('ÃÑ °áÁ¦±Ý¾×', vOrderData[vIndex]) > 0) or (Pos('¸¸³ª¼­°áÁ¦', vOrderData[vIndex]) > 0) then
      begin
        aOrderAmt   := StrToInt(GetOnlyNumber(RightStr(vOrderData[vIndex],7)));
        vMenuPosEnd := vIndex -2;
      end;
    end
    else
    begin
      //±âº»±ÛÀÚÅ©±â
      if vYogiYoType = 'D' then
      begin
        if (Common.Device.GetSplitData(Common.DeliverySplit.YogiyoDeliveryNo, vOrderData[vIndex]) or (Pos('ÁÖ¹®¹øÈ£:', vOrderData[vIndex]) > 0)) and (Pos('#', vOrderData[vIndex]) = 0)  then
          aDeliveryNo   := CopyAnsi(vOrderData[vIndex],12,20);

        if Common.Device.GetSplitData(Common.DeliverySplit.YogiyoTotAmt, vOrderData[vIndex]) or (Pos('ÇÕ°è:', vOrderData[vIndex]) > 0) then
        begin
          aOrderAmt   := StrToInt(GetOnlyNumber(RightStr(vOrderData[vIndex],18)));
          aCardAmt    := aOrderAmt;
          vMenuPosEnd := vIndex -2;
        end;

        //¿ä±â¿ä ¸Þ´º
        if (Pos('¸Þ´º¸í', vOrderData[vIndex]) > 0) and (Pos('¼ö·®', vOrderData[vIndex]) > 0) and (Pos('°¡°Ý', vOrderData[vIndex]) > 0) then
          vMenuPosBegin := vIndex + 2;
      end
      else if vYogiYoType = 'M' then
      begin
        if (Common.Device.GetSplitData(Common.DeliverySplit.YogiyoDeliveryNo, vOrderData[vIndex]) or (Pos('ÁÖ¹® ¹øÈ£:', vOrderData[vIndex]) > 0)) and (Pos('#', vOrderData[vIndex]) = 0)  then
          aDeliveryNo   := GetOnlyNumber(CopyAnsi(vOrderData[vIndex],15,40));

        if Common.Device.GetSplitData(Common.DeliverySplit.YogiyoTotAmt, vOrderData[vIndex]) or (Pos('ÇÕ °è :', vOrderData[vIndex]) > 0) then
        begin
          aOrderAmt   := StrToInt(GetOnlyNumber(RightStr(vOrderData[vIndex],18)));
          aCardAmt    := aOrderAmt;
          vMenuPosEnd := vIndex -2;
        end;

        //¿ä±â¿ä ¸Þ´º
        vTemp := Replace(vOrderData[vIndex],' ','');
        if (Pos('¸Þ´º¸í', vTemp) > 0) and (Pos('¼ö·®', vTemp) > 0) and (Pos('°¡°Ý', vTemp) > 0) then
          vMenuPosBegin := vIndex + 2;
      end;
    end;
  end;

  for vIndex := vMenuPosBegin to vMenuPosEnd do
  begin
    New(vMenuList);
    vMenuList^.Code   := '';
    vMenuList^.Item   := '';
    vMenuList^.TotalItem := '';
    vMenuList^.Step   := 0;
    vReversStr := ReverseString(Trim(vOrderData[vIndex]));
    //ÁÖ¹®¸Þ´º°¡ ÇÑÁÙÀÏ¶§
    if aCompany = 'C' then   //ÄíÆÎÀÏ¶§
    begin
      if (vOrderData[vIndex] <> '') and (GetOnlyNumber(RightStr(vOrderData[vIndex],3)) = RightStr(vOrderData[vIndex],3)) then
      begin
        if Copy(Trim(vOrderData[vIndex]),1,1) = '+' then
          vMenuList^.Name   := Trim(CopyAnsi(Trim(vOrderData[vIndex]),1,26))
        else
          vMenuList^.Name   := Trim(CopyAnsi(Trim(vOrderData[vIndex]),1,28));
        vMenuList^.Memo   := '';
        vMenuList^.Qty    := StrToIntDef(GetOnlyNumber(LeftStr(RightStr(Trim(vOrderData[vIndex]),12),3)),1);//   StrToIntDef(GetOnlyNumber(CopyAnsi(vOrderData[vIndex],29,3)),1);
        vMenuList^.Amount := StrToIntDef(GetOnlyNumber(RightStr(Trim(vOrderData[vIndex]),9)),0);
        vMenuList^.Price  := vMenuList^.Amount div Ifthen(vMenuList^.Qty=0,1,vMenuList^.Qty);
      end;
    end
    else if aCompany = 'Y' then
    begin
      if vYogiYoType = 'D' then
      begin
        if (vOrderData[vIndex] <> '') and (GetOnlyNumber(RightStr(vOrderData[vIndex],3)) = RightStr(vOrderData[vIndex],3)) then
        begin
          if Copy(vOrderData[vIndex],1,1) = '-' then
            vMenuList^.Name   := Trim(CopyAnsi(vOrderData[vIndex],3,24))
          else
            vMenuList^.Name   := Trim(CopyAnsi(vOrderData[vIndex],1,26));
          vMenuList^.Memo   := '';
          vMenuList^.Qty    := StrToIntDef(GetOnlyNumber(LeftStr(RightStr(vOrderData[vIndex],15),4)),1);// StrToIntDef(GetOnlyNumber(CopyAnsi(vOrderData[vIndex],28,4)),1);
          vMenuList^.Amount := StrToIntDef(GetOnlyNumber(RightStr(vOrderData[vIndex],11)),0); // StrToIntDef(GetOnlyNumber(CopyAnsi(vOrderData[vIndex],32,11)),0);
          vMenuList^.Price  := vMenuList^.Amount div Ifthen(vMenuList^.Qty=0,1,vMenuList^.Qty);
        end;
      end
      else
      begin
        vTemp := Replace(vOrderData[vIndex],' ','');
        if (vTemp <> '') and (GetOnlyNumber(RightStr(vTemp,3)) = RightStr(vTemp,3)) then
        begin
          if Copy(vOrderData[vIndex],1,1) = '-' then
            vMenuList^.Name   := Trim(CopyAnsi(vOrderData[vIndex],3,24))
          else
            vMenuList^.Name   := Replace(Trim(CopyAnsi(vOrderData[vIndex],1,30)),' ','');
          vMenuList^.Memo   := '';
          vMenuList^.Qty    := StrToIntDef(GetOnlyNumber(LeftStr(RightStr(vOrderData[vIndex],32),6)),1);// StrToIntDef(GetOnlyNumber(CopyAnsi(vOrderData[vIndex],28,4)),1);
          vMenuList^.Amount := StrToIntDef(GetOnlyNumber(RightStr(vOrderData[vIndex],15)),0); // StrToIntDef(GetOnlyNumber(CopyAnsi(vOrderData[vIndex],32,11)),0);
          vMenuList^.Price  := vMenuList^.Amount div Ifthen(vMenuList^.Qty=0,1,vMenuList^.Qty);
        end;

      end;
    end
    else if aCompany = 'B' then
    begin
      //ÁÖ¹®¸Þ´º°¡ ÇÑÁÙÀÏ¶§
      if (vOrderData[vIndex] <> '') and (GetOnlyNumber(RightStr(vOrderData[vIndex],3)) = RightStr(vOrderData[vIndex],3)) then
      begin
        vMenuList^.Name   := Trim(CopyAnsi(vOrderData[vIndex],1,25));
        vMenuList^.Qty    := StrToIntDef(GetOnlyNumber(CopyAnsi(Trim(vOrderData[vIndex]),27,3)),1);
        vMenuList^.Amount := StrToIntDef(GetOnlyNumber(RightStr(Trim(vOrderData[vIndex]),13)),0);
        vMenuList^.Price  := vMenuList^.Amount div Ifthen(vMenuList^.Qty=0,1,vMenuList^.Qty);
        vPos := vIndex;
      end
      else if vOrderData[vIndex] <> '' then
      begin
        vMenuList^.Name   := vOrderData[vIndex];
        vMenuList^.Qty    := StrToIntDef(GetOnlyNumber(CopyAnsi(Trim(vOrderData[vIndex+1]),27,3)),1);
        vMenuList^.Amount := StrToIntDef(GetOnlyNumber(RightStr(Trim(vOrderData[vIndex+1]),13)),0);
        vMenuList^.Price  := vMenuList^.Amount div Ifthen(vMenuList^.Qty=0,1,vMenuList^.Qty);
        vPos := vIndex + 1;
      end;
      vPos2 := vPos;

      aOrderMenu.Add(vMenuList);
      //¾ÆÀÌÅÛ ºÎ¸Þ´ºµµ ¸Þ´ºÁ¤º¸¿¡ Ãß°¡ÇÑ´Ù
      for vIndex2 := 1 to 10 do
        if (vPos2+vIndex2 < vMenuPosEnd) and (CopyAnsi(Trim(vOrderData[vPos2+vIndex2]),2,1) = '+') and (Pos('0¿ø)',Trim(vOrderData[vPos2+vIndex2])) > 0) then
        begin
          New(vMenuList);
          vMenuList^.Code        := '';
          vMenuList^.Item        := '';
          vMenuList^.Step        := 0;
          vMenuList^.TotalItem   := '';
          //ºÎ¸Þ´º´Â ¼ö·®°ú ±Ý¾× ¾ø¾î ÀüºÎ¸¦ ¸Þ´º¸íÀ¸·Î Ã³¸®ÇÑ´Ù
          vMenuList^.Name   := Trim(CopyAnsi(Trim(vOrderData[vPos2+vIndex2]),3,50));
          vMenuList^.Qty    := 1;
          vMenuList^.Amount := 0;
          vMenuList^.Price  := 0;
          aOrderMenu.Add(vMenuList);
        end
        else Break;
    end;
    aOrderMenu.Add(vMenuList);
  end;
end;

procedure TConfig_F.DispenserStauts;
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
begin
  DispenserData := EmptyStr;
  //»óÅÂÃ¼Å©
  vTemp := AnsiString(#$11#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00);
  vTemp := AnsiChar(#$fe) +AnsiChar(Length(vTemp)+2)+vTemp;
  vFCC := Byte(vTemp[1]);
  for vIndex := 2 to Length(vTemp) do
    vFCC := vFCC xor Byte(vTemp[vIndex]);
  vTemp := vTemp + AnsiChar(vFCC);
  Common.Device.SendToDispenser(vTemp);
  vGetTime := GetTickCount;
  while (DispenserData = EmptyStr) and (vGetTime + 1000 > GetTickCount) do
    Application.ProcessMessages;

  if DispenserData = EmptyStr then
    MessageLabel.Caption := 'ÀÔÃâ±Ý±â ÀÀ´ä¾øÀ½';
end;

procedure TConfig_F.DispenderReset;
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
begin
  DispenserData := EmptyStr;
  //¹æÃâ±â ¸®¼Â
  vTemp := AnsiString(#$10#$00#$04#$00#$00#$00#$00#$00#$00#$00#$00);
  vTemp := AnsiChar(#$fe) +AnsiChar(Length(vTemp)+2)+vTemp;
  vFCC := Byte(vTemp[1]);
  for vIndex := 2 to Length(vTemp) do
    vFCC := vFCC xor Byte(vTemp[vIndex]);
  vTemp := vTemp + AnsiChar(vFCC);
  Common.Device.SendToDispenser(vTemp);
  vGetTime := GetTickCount;
  while (DispenserData = EmptyStr) and (vGetTime + 1000 > GetTickCount) do
    Application.ProcessMessages;
end;

function TConfig_F.SetKioskCash: Boolean;
var vTemp  :AnsiString;
    vIndex :Integer;
    vGetTime :Cardinal;
    vFCC: Byte;
begin
  DispenserData := EmptyStr;
  //¹æÃâ¼ö·® Ã¼Å©
  vTemp := AnsiString(#$11#$04#$00#$00#$00#$00#$00#$00#$00#$00#$00);
  vTemp := AnsiChar(#$fe) +AnsiChar(Length(vTemp)+2)+vTemp;
  vFCC := Byte(vTemp[1]);
  for vIndex := 2 to Length(vTemp) do
    vFCC := vFCC xor Byte(vTemp[vIndex]);
  vTemp := vTemp + AnsiChar(vFCC);
  Common.Device.SendToDispenser(vTemp);
  vGetTime := GetTickCount;
  while (DispenserData = EmptyStr) and (vGetTime + 1000 > GetTickCount) do
    Application.ProcessMessages;

  if DispenserData = EmptyStr then
    MessageLabel.Caption := 'ÀÔÃâ±Ý±â ÀÀ´ä¾øÀ½';

end;

procedure TConfig_F.DispenserReadEvent(const S: String);
  //¼ö½Å°ªÀÌ ÇÑ¹ø¿¡ ¿©·¯°ÇÀÌ µé¾î¿À´Â °æ¿ì°¡ ÀÖ¾î¼­ ÃÖÁ¾°Í¸¸ »ç¿ëÇÑ´Ù
  function GetReceiveData(aStr:String):String;
  var vIndex :Integer;
      vPos   :Integer;
  begin
    vPos := 1;
    for vIndex := 1 to Length(aStr) do
    begin
      if (StringToHex(aStr[vIndex])='18') and (vIndex >=3) and (StringToHex(aStr[vIndex-2])='fe') then
        vPos := vIndex-2;
    end;
    Result := Copy(aStr, vPos, Length(aStr)-vPos);
  end;
var vIndex :Integer;
    vBillCount,
    vCoinCount :Integer;
    vData :AnsiString;
begin
  vData := GetReceiveData(AnsiString(S));
  if (Length(vData) > 3) and (StringToHex(vData[2])='18') then
  begin
    if StringToHex(vData[3]) <> '00' then
      Exit
    else
    begin
      vBillCount := StrToIntDef('$'+StringToHex(vData[9])+StringToHex(vData[10]),0);
      vCoinCount := StrToIntDef('$'+StringToHex(vData[5])+StringToHex(vData[6]),0);

      if ((Common.Config.KioskAlram[0] - vBillCount) <= Common.Config.KioskAlram[4]) or ((Common.Config.KioskAlram[1] - vCoinCount) <= Common.Config.KioskAlram[5]) then
        Common.Config.KioskCashPause := true
      else
        Common.Config.KioskCashPause := false;

      lbl1000.Caption := FormatFloat(',0°³',vBillCount);
      lbl100.Caption  := FormatFloat(',0°³',vCoinCount);
      MessageLabel.Caption := 'Ã¼Å© ¿Ï·á';
      Application.ProcessMessages;

      if ((Common.Config.KioskAlram[2] > 0) and (Common.Config.KioskAlram[0]-Common.Config.KioskAlram[2] <= vBillCount))
      or ((Common.Config.KioskAlram[3] > 0) and (Common.Config.KioskAlram[1]-Common.Config.KioskAlram[3] <= vCoinCount)) then
      begin
        Common.MsgBox('ÃÖ¼Ò °Å½º¸§µ· º¸À¯±Ý¾× ºÎÁ·'+#13
                     +Format('Ãµ¿ø %dÀå, ¹é¿ø %d°³',[vBillCount, vCoinCount]));
      end;
    end;
  end
  else if (Length(vData) > 3) and (StringToHex(vData[2])='13') then
  begin
    if StringToHex(vData[3]) = '00' then
      MessageLabel.Caption := 'ÀÔÃâ±Ý±â »óÅÂ Á¤»ó'
    else
      MessageLabel.Caption := 'ÀÔÃâ±Ý±â ¿À·ù';

  end;
  DispenserData := S;
end;
end.


