unit DeliveryInfo_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, cxControls, cxContainer, cxEdit, cxLabel,
  ExtCtrls, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxTextEdit, cxCurrencyEdit, cxGroupBox, DB, MemDS,
  DBAccess, Uni, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxClasses, cxGridCustomView, cxGrid, KeyPad_F,
  cxButtons, StrUtils,
  cxMemo, cxMaskEdit, cxDropDownEdit,
  Buttons,
  Common_U, DateUtils, cxNavigator, AdvGlassButton, AdvSmoothToggleButton,
  dxGDIPlusClasses, AdvShape, AdvSmoothButton, dxDateRanges,
  dxScrollbarAnnotations;

type TDeliveryStep = (dsNone, dsOrder, dsDelivery, dsAccount, dsDishReturn, dsCancel, dsHistory); //주문,배달,계산
type
  TDeliveryInfo_F = class(TForm)
    Sale_sGrd: TStringGrid;
    Order_sGrd: TStringGrid;
    lblOrderAmt: TcxLabel;
    RemarkMemo: TcxMemo;
    Timer1: TTimer;
    SaleHistoryPanel: TPanel;
    Shape1: TShape;
    cxLabel1: TcxLabel;
    btnHistoryClose: TcxButton;
    cxLabel4: TcxLabel;
    SaleRemarkMemo: TMemo;
    cxGrid1: TcxGrid;
    SaleTableView: TcxGridTableView;
    SaleTableViewSeq: TcxGridColumn;
    SaleTableViewMenu: TcxGridColumn;
    SaleTableViewQty: TcxGridColumn;
    SaleTableViewPrice: TcxGridColumn;
    SaleTableViewAmt: TcxGridColumn;
    cxGridLevel1: TcxGridLevel;
    DeliveryInfoPanel: TPanel;
    lblDeliveryNo: TcxLabel;
    lblOrderDate: TcxLabel;
    lblDeliveryStatus: TcxLabel;
    lblDeliveryDamdang: TcxLabel;
    edt_CustName: TcxTextEdit;
    edt_TelNo2: TcxTextEdit;
    edt_TelNo1: TcxTextEdit;
    edt_Address1: TcxTextEdit;
    edt_Address2: TcxTextEdit;
    RequestRemarkMemo: TcxMemo;
    edt_TelNo3: TcxTextEdit;
    edt_TelNo4: TcxTextEdit;
    lbl_Member: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    cxLabel9: TcxLabel;
    cxLabel10: TcxLabel;
    cxLabel11: TcxLabel;
    cxLabel12: TcxLabel;
    cxLabel13: TcxLabel;
    cxLabel14: TcxLabel;
    DeliveryButton: TAdvSmoothToggleButton;
    PackingButton: TAdvSmoothToggleButton;
    CourseButton: TAdvSmoothToggleButton;
    LocalButton: TAdvSmoothToggleButton;
    MapButton: TAdvSmoothToggleButton;
    CouponButton: TAdvSmoothToggleButton;
    PostButton: TAdvSmoothToggleButton;
    RequestItemButton: TAdvSmoothToggleButton;
    KeyPadButton: TAdvSmoothToggleButton;
    MemberSaveButton: TAdvSmoothToggleButton;
    MemberSearchButton: TAdvSmoothToggleButton;
    SearchButton: TAdvSmoothToggleButton;
    SaveButton: TAdvGlassButton;
    OrderButton: TAdvGlassButton;
    DeliveryGoButton: TAdvGlassButton;
    DishReturnButton: TAdvGlassButton;
    GridTitleShape: TAdvShape;
    AdvShape1: TAdvShape;
    cxLabel15: TcxLabel;
    cxLabel16: TcxLabel;
    cxLabel17: TcxLabel;
    TotalOrderAmtLabel: TcxLabel;
    TotalOrderCountLabel: TcxLabel;
    cxLabel18: TcxLabel;
    Image1: TImage;
    CaptionLabel: TLabel;
    ReprintButton: TAdvGlassButton;
    cxLabel19: TcxLabel;
    CloseButton: TcxButton;
    PrintButton: TAdvSmoothToggleButton;
    MessageImage: TImage;
    MessageLabel: TLabel;
    fmKeyPad: TfmKeyPad;
    PayButton: TAdvSmoothToggleButton;
    PayPanel: TPanel;
    CardButton: TAdvSmoothToggleButton;
    CashButton: TAdvSmoothToggleButton;
    CashRcpButton: TAdvSmoothToggleButton;
    EtcButton: TAdvSmoothToggleButton;
    PayFinishButton: TAdvSmoothToggleButton;
    procedure obtn_closeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Order_sGrdDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Sale_sGrdDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_CustNameEnter(Sender: TObject);
    procedure edt_TelNo2Exit(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Sale_sGrdDblClick(Sender: TObject);
    procedure btnHistoryCloseClick(Sender: TObject);
    procedure PostButtonClick(Sender: TObject);
    procedure CourseButtonClick(Sender: TObject);
    procedure LocalButtonClick(Sender: TObject);
    procedure DeliveryButtonClick(Sender: TObject);
    procedure MapButtonClick(Sender: TObject);
    procedure CouponButtonClick(Sender: TObject);
    procedure RequestItemButtonClick(Sender: TObject);
    procedure KeyPadButtonClick(Sender: TObject);
    procedure MemberSearchButtonClick(Sender: TObject);
    procedure MemberSaveButtonClick(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure OrderButtonClick(Sender: TObject);
    procedure DeliveryGoButtonClick(Sender: TObject);
    procedure DishReturnButtonClick(Sender: TObject);
    procedure ReprintButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure fmKeyPadDongButtonClick(Sender: TObject);
    procedure PayButtonClick(Sender: TObject);
    procedure CardButtonClick(Sender: TObject);
  private
    FMemberCode   :String;            //회원번호
    FBefOrderAmt  :Integer;           //직전 주문금액
    FBefRowCount  :Integer;
    FTableNo      :Integer;
    FBeforStep    :TDeliveryStep;    //직전 배달상태
    FDeliveryStep :TDeliveryStep;    //배달상태
    FDeliveryMan  :String;           //배달담당
    FRecallMan    :String;
    FDeliveryDate :TDateTime;
    FFocusedEdit  :TObject;
    isAutoOrder   :Boolean;
    isDeliveryReceiptPrint :Boolean;
    ClickTime :TDateTime;
    procedure ClearDeliveryData;
    procedure GetOrderMenu;
    procedure SetDeliveryHistory(Kind:Integer);
    function  DataSave(Sender: TObject=nil):Boolean;
    function  GetDeliveryMan:Boolean;
    function  GetRecallMan:Boolean;
    procedure DeleteDelivery;
    procedure SetUsePos(aValue:String);
    procedure CidReadEvent(const S : String);
    procedure SetDeliveryStep(const Value: TDeliveryStep);
    procedure SetMemberCode(AValue:String);
    property  DeliveryStep :TDeliveryStep  read FDeliveryStep write SetDeliveryStep;
    property  MemberCode   :String         read FMemberCode   write SetMemberCode;
  public
    FShowType     : TFormShowType;
    FFirstActive  : Boolean;
    FWorkType     : TWorkType;
    FDeliveryNo   :String;     //배달번호
    FTelephoeNo   :String;     //부재중전화번호
    FOrderAmt     :Integer;    //주문금액
    FRowCount     :Integer;
    FTelLine      :String;
    FDcAmount     :Integer;
    procedure SetDeliveryInfo;
  end;

var
  DeliveryInfo_F: TDeliveryInfo_F;

implementation
uses GlobalFunc_U, Const_U, Order_U, DeliveryAddr_U, Delivery_U,
  DBModule_U, RePrint_U, Math, Map_U;
{$R *.dfm}

procedure TDeliveryInfo_F.obtn_closeClick(Sender: TObject);
begin
  Close;
end;

procedure TDeliveryInfo_F.FormCreate(Sender: TObject);
var I, vIndex :Integer;
begin
  Common.LogoCreate(Self,2);
  for vIndex := 0 to ComponentCount-1 do
  begin
    if Components[vIndex] is TAdvGlassButton then
      Common.SetButtonColor((Components[vIndex] as TAdvGlassButton));
    if Components[vIndex] is TAdvSmoothToggleButton then
      Common.SetButtonColor((Components[vIndex] as TAdvSmoothToggleButton));
  end;
  if Common.Config.Style = 'D' then
  begin
    Common.SetButtonColor(GridTitleShape);
    Common.SetButtonColor(AdvShape1);
  end;

  Width  := 1024;
  Height := 768;

  with Order_SGrd do
  begin
     ColCount                 := GDM_COLCOUNT;
     ColWidths[GDM_NO         ] := 27;     //순번
     ColWidths[GDM_TYPE       ] := 27;     //메뉴타입
     ColWidths[GDM_NM_MENU    ] := 230;    //메뉴명
     ColWidths[GDM_VIEWQTY    ] := 62;     //수량
     ColWidths[GDM_VIEWPRICE  ] := 78;     //메뉴단가
     ColWidths[GDM_DC_MENU    ] := -1;     //할인단가
     ColWidths[GDM_AMT        ] := 90;     //판매금액
  end;

  with Sale_SGrd do
  begin
     ColCount                 := 6;
     ColWidths[0] := 85;     //구매일자
     ColWidths[1] := 315;    //메뉴
     ColWidths[2] := 65;     //결제방법
     ColWidths[3] := 48;     //쿠폰
     ColWidths[4] := 0;      //배달번호
     ColWidths[5] := 0;      //특이사항
  end;
  Common.ClearDeliveryTel;
  isAutoOrder := false;
  FWorkType := wtNew;
end;

procedure TDeliveryInfo_F.OrderButtonClick(Sender: TObject);
var Rtn :TModalResult;
begin
  if MilliSecondsBetween(Now(),ClickTime) < 1500 then Exit;
  ClickTime := Now;
  if (Trim(edt_TelNo1.Text) = ''  ) and
     (Trim(edt_TelNo2.Text) = ''  ) and
     (Trim(edt_TelNo3.Text) = ''  ) and
     (Trim(edt_TelNo4.Text) = ''  ) then
  begin
    Common.ErrBox('주문자 전화번호가 없습니다'+#13#13+'전화번호를 입력하세요');
    edt_CustName.SetFocus;
    Exit;
  end;

  //미주문 상태였으면 저장을 한다
  if DeliveryStep = dsNone then
  begin
    if (GetOption(392) <> '0') and (Sender = OrderButton) and (MemberCode = '')  then
    begin
      if (GetOption(392) = '2') or ((GetOption(392) = '1') and Common.AskBox('신규고객입니다'#13#13'회원으로 저장하시겠습니까?')) then
        MemberSaveButtonClick(nil);
    end;

    DataSave;
  end;
  InitTableRecord(Common.Table);
  Common.Table.Number     := FTableNo;
  Common.Config.IsTakeOut := false;
  Common.Table.OrderType  := 'D';
  Common.Table.GroupType  := 'N';
  Common.Table.Course     := CourseButton.Caption;
  Common.Table.Local      := LocalButton.Caption;
  Common.Table.Addr1      := edt_Address1.Text;
  Common.Table.Addr2      := edt_Address2.Text;
  if Trim(edt_TelNo1.Text) <> '' then
    Common.Table.DeliveryTel := edt_TelNo1.Text
  else if Trim(edt_TelNo2.Text) <> '' then
    Common.Table.DeliveryTel := edt_TelNo2.Text;

  Common.SetAgeInfo('');

  Common.Table.Date  := FormatDateTime('yyyymmdd',now());
  Common.Table.Time  := FormatDateTime('hh:nn',now());
  Common.Table.Name  := Ifthen(DeliveryButton.Appearance.SimpleLayout , '배달','포장') + '('+ FDeliveryNo + ')';
  OpenQuery('select CD_CODE, '
           +'       RT_DC, '
           +'       AMT_DC, '
           +'       DC_MENU, '
           +'       AMT_CODEDC,  '
           +'       (select Count(*) '
           +'          from SL_ORDER_D '
           +'         where CD_STORE = a.CD_STORE '
           +'           and NO_TABLE = a.NO_TABLE '
           +'           and DS_ORDER = ''D '') as ORDER_CNT '
           +'  from SL_ORDER_H as a '
           +' where CD_STORE =:P0 '
           +'   and NO_TABLE =:P1 '
           +'   and DS_ORDER =''D'' ',
           [Common.Config.StoreCode,
            Common.Table.Number]);
  if not Common.Query.Eof then
  begin
    Common.Table.DcCode      := Common.Query.FieldByName('CD_CODE').AsString;
    Common.Table.Dc_Rate     := Common.Query.FieldByName('RT_DC').AsInteger;
    Common.Table.Dc_Amt      := Common.Query.FieldByName('AMT_DC').AsInteger;
    Common.Table.Dc_Menu     := Common.Query.FieldByName('DC_MENU').AsInteger;
    Common.Table.Dc_CodeAmt  := Common.Query.FieldByName('AMT_CODEDC').AsInteger;
    if Common.Query.FieldByName('ORDER_CNT').AsInteger > 0 then
      Common.OrderKind         := okAppend
    else
      Common.OrderKind         := okNew;
    Common.Query.Close;
  end
  else
  begin
    ExecQuery('insert into SL_ORDER_H(CD_STORE, '
             +'	    	                NO_TABLE, '
             +'	    	                DS_ORDER, '
             +'	    	                TABLE_STATE, '
             +'	    	                LAST_POS) '
             +'                values(:P0, '
             +'	    	                :P1, '
             +'	    	                ''D'', '
             +'	    	                ''Y'', '
             +'	    	                :P2)',
             [Common.Config.StoreCode,
              Common.Table.Number,
              Common.Config.PosNo,
              Common.Config.UserCode]);
    Common.OrderKind         := okNew;
  end;

  Common.Table.DeliveryNo := FDeliveryNo;
  Order_F := TOrder_F.Create(self);
  FBefOrderAmt       := FOrderAmt;
  FBefRowCount       := FRowCount;
  Common.Table.MemberCode :=MemberCode;
  Common.ShowSaleDualScreen;
  try
    FBeforStep := DeliveryStep;
    Rtn := Order_F.ShowModal;
    case Rtn of
      mrOK,
      mrCancel : DeliveryStep := dsOrder;
      mrYes    : DeliveryStep := dsAccount;
    end;
    GetOrderMenu;
    if Rtn <> mrCancel then
      SaveButtonClick(nil);
    Application.ProcessMessages;
  finally
    FreeAndNil(Order_F);
    Common.WorkKind  := wkSale;
    Common.ClearKitchenData;
    Common.ShowNormalDualScreen;
  end;

  if ((Rtn <> mrCancel) and (GetOption(347) = '0')) or isAutoOrder then
  begin
    Timer1.Enabled := True;
    Close;
  end;
end;

procedure TDeliveryInfo_F.Order_sGrdDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var  i_align : integer;
begin
  TStringGrid(Sender).Canvas.Font.Size := 12;
  if gdSelected in State then
  begin
    TStringGrid(Sender).Canvas.Brush.Color := clWhite;
    TStringGrid(Sender).Canvas.Font.Color  := clBlack;
  end;
  case ACol of
    0,1 :  i_align  := 1; //가운데
    2   :  i_align  := 0; //좌측
    3..6:  i_align  := 2; //우측
  end;
  Common.Grid_Align(Sender, ACol, ARow, Rect, i_align);

  // 숫자형 출력시 Format 형식   //
  case ACol of
   4..6: Common.Grid_DisplayFormat(Sender, ACol, ARow, Rect);
  end;
end;

procedure TDeliveryInfo_F.PayButtonClick(Sender: TObject);
begin
  if PayPanel.Visible then
  begin
    payPanel.Visible := false;
    Exit;
  end
  else
  begin
    PayPanel.Top := PayButton.Top + PayButton.Height - PayPanel.Height;
    PayPanel.Left := PayButton.Left + PayButton.Width + 5;
    PayPanel.Visible := true;
  end;

end;

procedure TDeliveryInfo_F.PostButtonClick(Sender: TObject);
begin
  DeliveryAddr_F := TDeliveryAddr_F.Create(Application);
  try
    if DeliveryAddr_F.ShowModal = mrOK then
    begin
      edt_Address1.Text := DeliveryAddr_F.FAddress;
      if DeliveryAddr_F.CourseCode <> '' then
      begin
        CourseButton.Hint    := DeliveryAddr_F.CourseCode;
        CourseButton.Caption := DeliveryAddr_F.CourseName;
      end
      else
      begin
        CourseButton.Hint    := '';
        CourseButton.Caption := '';
      end;
      if DeliveryAddr_F.LocalCode <> '' then
      begin
        LocalButton.Hint    := DeliveryAddr_F.LocalCode;
        LocalButton.Caption := DeliveryAddr_F.LocalName;
      end
      else
      begin
        LocalButton.Hint    := '';
        LocalButton.Caption := '';
      end;
      if DeliveryAddr_F.DamdangCode <> '' then
      begin
        FDeliveryMan  := DeliveryAddr_F.DamdangCode;
        lblDeliveryDamdang.Caption := DeliveryAddr_F.DamdangName;
      end
      else
      begin
        FDeliveryMan  := '';
        lblDeliveryDamdang.Caption := '';
      end;
      edt_Address2.SetFocus;
    end;
  finally
    FreeAndNil(DeliveryAddr_F);
  end;
end;

procedure TDeliveryInfo_F.PrintButtonClick(Sender: TObject);
begin
  if not isDeliveryReceiptPrint then
    PrintButton.Caption := '출력함'
  else
    PrintButton.Caption := '출력안함';

  isDeliveryReceiptPrint := not isDeliveryReceiptPrint;
end;

procedure TDeliveryInfo_F.ReprintButtonClick(Sender: TObject);
begin
  RePrint_F := TRePrint_F.Create(Application);
  try
    Common.Table.Number     := FTableNo;
    Common.Table.Name       := '배달('+FDeliveryNo+')';
    Common.Table.DeliveryNo := FDeliveryNo;
    Common.Table.Course     := CourseButton.Caption;
    Common.Table.Local      := LocalButton.Caption;
    Common.Table.Addr1      := edt_Address1.Text;
    Common.Table.Addr2      := edt_Address2.Text;
    if Trim(edt_TelNo1.Text) <> '' then
      Common.Table.DeliveryTel := edt_TelNo1.Text
    else if Trim(edt_TelNo2.Text) <> '' then
      Common.Table.DeliveryTel := edt_TelNo2.Text;

    Common.Table.OrderType  := 'D';
    if RePrint_F.ShowModal = mrYesToAll then
      Common.Device.DeliveryPrint;
  finally
    FreeAndNil(RePrint_F);
  end;
end;

procedure TDeliveryInfo_F.RequestItemButtonClick(Sender: TObject);
var vCode, vName :String;
begin
if Common.ShowChooseForm('I','',vCode, vName) then
  begin
    RequestRemarkMemo.Text := RequestRemarkMemo.Text + Ifthen(RequestRemarkMemo.Text <> '', #13, '') + vName;
    RequestRemarkMemo.SetFocus;
    RequestRemarkMemo.SelStart := Length(RequestRemarkMemo.Text)+1;
  end;
end;

procedure TDeliveryInfo_F.Sale_sGrdDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var  i_align : integer;
begin
  case ACol of
     0 :  i_align  := 1; //가운데
     1 :  i_align  := 0; //좌측
     2,3 :  i_align  := 1; //가운데
  end;
  Common.Grid_Align(Sender, ACol, ARow, Rect, i_align);
end;


procedure TDeliveryInfo_F.SaveButtonClick(Sender: TObject);
var vIndex :Integer;
begin
  if (Trim(edt_TelNo1.Text) = ''  ) and
     (Trim(edt_TelNo2.Text) = ''  ) and
     (Trim(edt_TelNo3.Text) = ''  ) and
     (Trim(edt_TelNo4.Text) = ''  ) then
  begin
    Common.ErrBox('주문자 전화번호가 없습니다'+#13#13+'전화번호를 입력하세요');
    edt_CustName.SetFocus;
    Exit;
  end;

  if DataSave(Sender) then
  begin
    if (Sender = SaveButton) or (Sender = nil) then
      //배달전표 출력
      case DeliveryStep of
        dsOrder :
        begin
          //주문시 배달전표를 출력한다고
          if isDeliveryReceiptPrint and (GetOption(143) <> '0') and ((Sender = SaveButton) or (FBefOrderAmt < FOrderAmt) or (FBefRowCount < FRowCount)) then
          begin
            if (Sender <> SaveButton) and (FBeforStep = dsOrder) and (GetOption(279) = '0') then
            begin
              //배달전표에 주문내역을 출력하지 않을 때는 스탭이 바뀌지 않았을때는 출력여부를 물어본다
              if Common.AskBox('배달전표를 출력하시겠습니까?') then
                Common.Device.DeliveryPrint(StoI(GetOption(143)));
            end
            else if Sender <> SaveButton then
              Common.Device.DeliveryPrint(StoI(GetOption(143)))
            else if (Sender = SaveButton) and (Common.AskBox('배달전표를 출력하시겠습니까?')) then
              Common.Device.DeliveryPrint(StoI(GetOption(143)));
          end;

          //주문시 배달고객영수증을 출력한다고
          if (GetOption(186) = '1') and ((Sender = SaveButton) or (FBefOrderAmt < FOrderAmt) or (FBefRowCount < FRowCount)) then
          begin
            if Sender <> SaveButton then
              Common.Device.DeliveryReceiptPrint
            else if (Sender = SaveButton) and (Common.AskBox('배달영수증을 출력하시겠습니까?')) then
              Common.Device.DeliveryReceiptPrint;
          end;

        end;
        dsDelivery :
        begin
          //주문상태에서 배달로 바뀌었고 배달시 배달전표를 출력한다고 체크했을때
          if isDeliveryReceiptPrint and (GetOption(189) <> '0') and ((Sender = SaveButton) or (FBeforStep = dsOrder))  then
          begin
            if (Sender <> SaveButton) and (FBeforStep = dsDelivery) and (GetOption(279) = '0') then
            begin
              //배달전표에 주문내역을 출력하지 않을 때는 스탭이 바뀌지 않았을때는 출력여부를 물어본다
              if Common.AskBox('배달전표를 출력하시겠습니까?') then
              begin
                Common.Device.DeliveryPrint(StoI(GetOption(189)));
              end;
            end
            else if Sender <> SaveButton then
            begin
              Common.Device.DeliveryPrint(StoI(GetOption(189)));
            end
            else if (Sender = SaveButton) and (Common.AskBox('배달전표를 출력하시겠습니까?')) then
            begin
              Common.Device.DeliveryPrint(StoI(GetOption(189)));
            end;
          end;

          //배달시 배달고객영수증을 출력한다고
          if (GetOption(119) = '1') and ((Sender = SaveButton) or (FBeforStep = dsOrder)) then
          begin
            if Sender <> SaveButton then
              Common.Device.DeliveryReceiptPrint
            else if (Sender = SaveButton) and (Common.AskBox('배달영수증을 출력하시겠습니까?')) then
              Common.Device.DeliveryReceiptPrint;
          end;
        end;
        dsAccount :
        begin
          if isDeliveryReceiptPrint and (GetOption(145) <> '0') and ((Sender = SaveButton) or (FBeforStep <> dsAccount)) then
          begin
            if (Sender <> SaveButton) and (FBeforStep = dsAccount) and (GetOption(279) = '0') then
            begin
              //배달전표에 주문내역을 출력하지 않을 때는 스탭이 바뀌지 않았을때는 출력여부를 물어본다
              if Common.AskBox('배달전표를 출력하시겠습니까?') then
              begin
                Common.Device.DeliveryPrint(StoI(GetOption(145)));
              end;
            end
            else if Sender <> SaveButton then
            begin
              Common.Device.DeliveryPrint(StoI(GetOption(145)));
            end
            else if (Sender = SaveButton) and (Common.AskBox('배달전표를 출력하시겠습니까?')) then
            begin
                Common.Device.DeliveryPrint(StoI(GetOption(145)));
            end;
          end;

          //계산시 배달고객영수증을 출력한다고
          if (GetOption(190) = '1') and ((Sender = SaveButton) or (FBeforStep <> dsAccount)) then
          begin
            if Sender <> SaveButton then
              Common.Device.DeliveryReceiptPrint
            else if (Sender = SaveButton) and (Common.AskBox('배달영수증을 출력하시겠습니까?')) then
              Common.Device.DeliveryReceiptPrint;
          end;

        end;
      end;
  end;
end;

procedure TDeliveryInfo_F.SetDeliveryInfo;
  procedure ClearDeliveryInfo;
  begin
    lblDeliveryNo.Caption      := '';
    lblOrderDate.Caption       := '';
    lblDeliveryStatus.Caption  := '';
    lblDeliveryDamdang.Caption := '';
    edt_CustName.Clear;
    lbl_Member.Caption         := '';
    edt_Telno2.Clear;
    edt_TelNo1.Clear;
    edt_Telno3.Clear;
    edt_TelNo4.Clear;
    if GetOption(118) = '0' then
    begin
      DeliveryButton.Appearance.SimpleLayout := true;
      PackingButton.Appearance.SimpleLayout  := false;
    end
    else
    begin
      DeliveryButton.Appearance.SimpleLayout := false;
      PackingButton.Appearance.SimpleLayout  := true;
    end;

    edt_Address1.Clear;
    edt_Address2.Clear;
    RequestRemarkMemo.Clear;
    Common.ClearGrid(Order_sGrd);
    lblOrderAmt.Caption := '0 원';
    FDcAmount := 0;
    Common.ClearGrid(Sale_sGrd);
    RemarkMemo.Clear;
    TotalOrderCountLabel.Caption    := '';
    TotalOrderAmtLabel.Caption := '';
    CourseButton.Caption       := '';
    CourseButton.Hint          := '';
    LocalButton.Caption        := '';
    LocalButton.Hint           := '';
  end;
begin
  ClearDeliveryInfo;
  case FWorkType of
    wtNew    :
      begin
        MessageLabel.Caption      := '신규주문';
        lblOrderDate.Caption      := FormatDateTime('yyyy년 mm월 dd일 hh시 nn분', now());
        DeliveryStep              := dsNone;
        FDeliveryNo               := EmptyStr;
        if GetOption(395) = '0' then
        begin
          PayButton.Hint    := CardButton.Hint;
          PayButton.Caption := CardButton.Caption;
        end
        else
        begin
          PayButton.Hint    := CashButton.Hint;
          PayButton.Caption := CashButton.Caption;
        end;
        if FTelephoeNo <> '' then
        begin
         edt_TelNo1.Text := SetTelephone(FTelephoeNo);
          SearchButtonClick(nil);
        end;
        if Trim(Delivery_F.FDefaultAddr) <> EmptyStr then
          edt_Address1.Text := Delivery_F.FDefaultAddr;
        if GetOption(316) = '0' then
          edt_CustName.SetFocus
        else if Trim(edt_TelNo1.Text) = EmptyStr then
          edt_TelNo1.SetFocus
        else
          edt_Address1.SetFocus;

        FRowCount := 0;
      end;
    wtOutNew :
      begin
        MessageLabel.Caption      := '신규주문(부재중전화)';
        lblOrderDate.Caption      := FormatDateTime('yyyy년 mm월 dd일 hh시 nn분', now());
        edt_TelNo1.Text := SetTelephone(FTelephoeNo);
        DeliveryStep              := dsNone;
        FDeliveryNo               := EmptyStr;
        edt_Address1.Text         := Delivery_F.FDefaultAddr;
        if GetOption(395) = '0' then
        begin
          PayButton.Hint    := CardButton.Hint;
          PayButton.Caption := CardButton.Caption;
        end
        else
        begin
          PayButton.Hint    := CashButton.Hint;
          PayButton.Caption := CashButton.Caption;
        end;
        SearchButtonClick(nil);

        if (lbl_Member.Caption <> EmptyStr) and (GetOption(188) = '1') then
        begin
          FShowType := fstOrder;
          OrderButtonClick(nil);
        end
        else
        begin
          FRowCount := 0;
          if GetOption(316) = '0' then
            edt_CustName.SetFocus
          else if Trim(edt_TelNo1.Text) = EmptyStr then
            edt_TelNo1.SetFocus
          else
            edt_Address1.SetFocus;
        end;
      end;
    wtEdit   :
      begin
        OpenQuery('select a.*, '
                 +'       case a.DS_CUSTOMER when ''N'' then ''비회원'' else ConCat(''회원 ('',A.CD_MEMBER,'')'') end as DS_MEMBER, '
                 +'       a.NM_NAME as NM_CUSTOMER, '
                 +'       b.REMARK  as BIGO, '
                 +'	      case when a.CD_SAWON <> '''' then (select NM_SAWON '
                 +'                                            from MS_SAWON '
                 +'                                           where CD_STORE = a.CD_STORE '
                 +'                                             and CD_SAWON = a.CD_SAWON ) '
                 +'	      else '''' end DAMDANG, '
                 +'       GetCommonName(a.CD_STORE, 20, a.CD_COURSE) as NM_COURSE, '
                 +'       GetCommonName(a.CD_STORE, 22, a.CD_LOCAL)  as NM_LOCAL, '
                 +'       b.NO_CASHRCP '
                 +'  from SL_DELIVERY a  left outer join '
                 +'       MS_MEMBER   b  on a.CD_STORE = b.CD_STORE and a.CD_MEMBER = b.CD_MEMBER '
                 +' where a.CD_STORE      = :P0 '
                 +'   and a.YMD_DELIVERY  = :P1 '
                 +'   and a.NO_DELIVERY   = :P2 ',
                 [Common.Config.StoreCode,
                  LeftStr(FDeliveryNo,8),
                  RightStr(FDeliveryNo, 4)]);

        MessageLabel.Caption       := '배달수정';
        lblDeliveryNo.Caption      := LeftStr(FDeliveryNo,8)+'-'+RightStr(FDeliveryNo, 4);
        lblOrderDate.Caption       := FormatDateTime('yyyy년 mm월 dd일 hh시 nn분', NVL(Common.Query.FieldByName('dt_order').Value, now()));
        if Common.Query.FieldByName('dt_delivery').Value <> null then
          FDeliveryDate              := NVL(Common.Query.FieldByName('dt_delivery').Value, now());
        if (Common.Query.FieldByName('ds_step').AsString = 'N') or (Common.Query.FieldByName('ds_step').AsString = '') then
          DeliveryStep := dsNone
        else if Common.Query.FieldByName('ds_step').AsString = 'O' then
          DeliveryStep := dsOrder
        else if Common.Query.FieldByName('ds_step').AsString = 'D' then
          DeliveryStep := dsDelivery
        else if Common.Query.FieldByName('ds_step').AsString = 'A' then
          DeliveryStep := dsAccount;

        PayButton.Hint    := Common.Query.FieldByName('PAYTYPE').AsString;
        PayButton.Caption := Common.Query.FieldByName('PAYTYPE').AsString;
        if PayButton.Caption = '현영' then
          PayButton.Caption := '현금영수증';

        FDeliveryMan        := Common.Query.FieldByName('cd_sawon').AsString;
        lblDeliveryDamdang.Caption := Common.Query.FieldByName('Damdang').AsString;
        edt_CustName.Text   := Common.Query.FieldByName('nm_name').AsString;
        lbl_Member.Caption  := Common.Query.FieldByName('ds_member').AsString;
        edt_Telno1.Text     := SetTelephone(Common.Query.FieldByName('no_tel1').AsString);
        edt_TelNo2.Text     := SetTelephone(Common.Query.FieldByName('no_tel2').AsString);
        edt_Telno3.Text     := SetTelephone(Common.Query.FieldByName('no_tel3').AsString);
        edt_TelNo4.Text     := SetTelephone(Common.Query.FieldByName('no_tel4').AsString);
        if Common.Query.FieldByName('ds_order').AsString = 'D' then
        begin
          DeliveryButton.Appearance.SimpleLayout := true;
          PackingButton.Appearance.SimpleLayout  := false;
        end
        else
        begin
          DeliveryButton.Appearance.SimpleLayout := false;
          PackingButton.Appearance.SimpleLayout  := true;
        end;
        edt_Address1.Text   := Common.Query.FieldByName('address1').AsString;
        edt_Address2.Text   := Common.Query.FieldByName('address2').AsString;
        RequestRemarkMemo.Text     := Common.Query.FieldByName('remark').AsString;
        RemarkMemo.Text       := Common.Query.FieldByName('bigo').AsString;
        CouponButton.Caption   := FormatFloat('#0 매', Common.Query.FieldByName('coupon_cnt').AsInteger);
        CouponButton.Tag       := Common.Query.FieldByName('coupon_cnt').AsInteger;
        CourseButton.Caption   := Common.Query.FieldByName('nm_course').AsString;
        CourseButton.Hint      := Common.Query.FieldByName('cd_course').AsString;
        LocalButton.Caption    := Common.Query.FieldByName('nm_Local').AsString;
        LocalButton.Hint       := Common.Query.FieldByName('cd_Local').AsString;

        Common.Table.Course     := CourseButton.Caption;
        Common.Table.Local      := LocalButton.Caption;
        if Trim(edt_TelNo1.Text) <> '' then
          Common.Table.DeliveryTel := edt_TelNo1.Text
        else if Trim(edt_TelNo2.Text) <> '' then
          Common.Table.DeliveryTel := edt_TelNo2.Text;

        MemberCode :=  Common.Query.FieldByName('cd_member').AsString;
        FOrderAmt  :=  Common.Query.FieldByName('amt_order').AsInteger;
        FTableNo   :=  Common.Query.FieldByName('no_table').AsInteger;

        GetOrderMenu;
        SetDeliveryHistory(1);
        FRowCount := Order_sGrd.RowCount;
        Common.Query.Close;
      end;
  end;
end;

procedure TDeliveryInfo_F.GetOrderMenu;
var vSeq :Integer;
begin
  Common.ClearGrid(Order_sGrd);
  if DeliveryStep in [dsAccount, dsDishReturn] then
  begin
    FOrderAmt := 0;
    FDcAmount := 0;
    //기존주문내역을 불러온다
    with Order_sGrd do
    begin
      DM.OpenQuery('select a.CD_MENU, '
                  +'       c.NM_MENU, '
                  +'       a.QTY_SALE as QTY_ORDER, '
                  +'       a.PR_SALE, '
                  +'       c.PR_SALE as PR_SALE_ORG, '
                  +'       c.DS_MENU_TYPE, '
                  +'       a.AMT_SALE, '
                  +'       a.DC_TOT '
                  +'  from SL_SALE_D a  inner join '
                  +'       SL_SALE_H b  on a.CD_STORE    = b.CD_STORE '
                  +'                   and a.YMD_SALE    = b.YMD_SALE '
                  +'                   and a.NO_POS      = b.NO_POS '
                  +'                   and a.NO_RCP      = b.NO_RCP '
                  +'                   and b.NO_DELIVERY = :p1 inner join '
                  +'       MS_MENU   c  on a.CD_STORE = c.CD_STORE '
                  +'                   and a.CD_MENU  = c.CD_MENU '
                  +' where a.CD_STORE = :P0 ',
                  [Common.Config.StoreCode,
                   FDeliveryNo]);

      while not DM.Query.Eof do
      begin
        if Cells[0,0] <> '' then RowCount := RowCount+1;

        Cells[GDM_NO         ,RowCount-1] := IntToStr(RowCount);                 //순번
        Cells[GDM_CD_MENU    ,RowCount-1] := DM.Query.FieldByName('cd_menu').AsString;    //상품코드
        Cells[GDM_NM_MENU    ,RowCount-1] := DM.Query.FieldByName('nm_menu').AsString;    //상품명
        Cells[GDM_PR_SALE    ,RowCount-1] := DM.Query.FieldByName('pr_sale').AsString;    //상품단가
        Cells[GDM_VIEWQTY    ,RowCount-1] := Common.GetQtyReplace(DM.Query.FieldByName('ds_menu_type').AsString, DM.Query.FieldByName('qty_order').AsString);  //수량
        Cells[GDM_QTY        ,RowCount-1] := DM.Query.FieldByName('qty_order').AsString;   //수량

        if DM.Query.FieldByName('ds_menu_type').AsString = 'W' then
        begin
          Cells[GDM_VIEWPRICE  ,RowCount-1] := DM.Query.FieldByName('pr_sale_org').AsString;    //상품단가
        end
        else
        begin
          Cells[GDM_VIEWPRICE  ,RowCount-1] := DM.Query.FieldByName('pr_sale').AsString;    //상품단가
        end;
        Cells[GDM_TYPE       ,RowCount-1] := DM.Query.FieldByName('ds_menu_type').AsString;
        Cells[GDM_AMT        ,RowCount-1] := DM.Query.FieldByName('amt_sale').AsString;   //금액

        FOrderAmt := FOrderAmt + DM.Query.FieldByName('amt_sale').AsInteger - DM.Query.FieldByName('dc_tot').AsInteger;
        FDcAmount := FDcAmount + DM.Query.FieldByName('dc_tot').AsInteger;
        DM.Query.Next;
      end;
      DM.Query.Close;
    end;

    lblOrderAmt.Caption   := FormatFloat('#,0', FOrderAmt)+' 원';
  end
  else
  begin
    //기존주문내역을 불러온다
    with Order_sGrd do
    begin
      DM.OpenQuery('select a.CD_MENU, '
                 +'       a.NM_MENU, '
                 +'       a.DS_MENU_TYPE, '
                 +'       a.NO_STEP, '
                 +'       a.CD_MENU1, '
                 +'       a.SEQ, '
                 +'       a.PR_SALE, '
                 +'       a.QTY_ORDER, '
                 +'       a.AMT_ORDER, '
                 +'       Date_Format(a.DT_CHANGE, ''%Y-%m-%d %H:%i'') as DT_ORDER, '
                 +'       a.DS_SALE, '
                 +'       a.DS_TAX, '
                 +'       ifnull(a.CD_PRINTER, '''') as CD_PRINTER, '
                 +'       a.NO_SPC, '
                 +'       a.DC_SPC, '
                 +'       a.MEMO, '
                 +'       Substring(b.CONFIG,1,1) as YN_DC, '
                 +'       Substring(b.CONFIG,2,1) as YN_POINT, '
                 +'       Substring(b.CONFIG,3,1) as YN_RCP, '
                 +'       b.DS_KITCHEN, '
                 +'       b.NO_GROUP, '
                 +'       b.PR_SALE_DOUBLE, '
                 +'       b.PR_SALE as PR_SALE_ORG, '
                 +'       b.NM_MENU_SHORT '
                 +'  from SL_ORDER_D a inner join '
                 +'       MS_MENU    b on a.CD_STORE = b.CD_STORE and a.CD_MENU  = b.CD_MENU '
                 +' where a.CD_STORE =:P0 '
                 +'   and a.NO_TABLE =:P1 '
                 +'   and a.DS_ORDER =:P2 '
                 +' order by a.ORDERSEQ ',
                 [Common.Config.StoreCode,
                  FTableNo,
                  'D']);
      vSeq := 0;
      while not DM.Query.Eof do
      begin
        if Cells[0,0] <> '' then RowCount := RowCount+1;

        if DM.Query.FieldByName('no_step').AsInteger > 0 then
          Cells[GDM_NO         ,RowCount-1] := ''
        else
        begin
          Inc(vSeq);
          Cells[GDM_NO         ,RowCount-1] := IntToStr(vSeq);                             //순번
        end;
        Cells[GDM_CD_MENU    ,RowCount-1] := DM.Query.FieldByName('cd_menu').AsString;              //상품명
        Cells[GDM_NM_MENU    ,RowCount-1] := DM.Query.FieldByName('nm_menu').AsString;              //상품명
        if (DM.Query.FieldByName('ds_menu_type').AsString = 'N') or  (DM.Query.FieldByName('ds_menu_type').AsString = 'G') then                                      //메뉴구분
          Cells[GDM_TYPE       ,RowCount-1] :=''
        else if DM.Query.FieldByName('ds_menu_type').AsString = 'W' then                                      //메뉴구분
          Cells[GDM_TYPE       ,RowCount-1] :='ⓦ'
        else if (DM.Query.FieldByName('ds_menu_type').AsString = 'S') and (DM.Query.FieldByName('no_step').AsInteger = 0) then
          Cells[GDM_TYPE       ,RowCount-1] := 'ⓢ'
        else if (DM.Query.FieldByName('ds_menu_type').AsString = 'S') and (DM.Query.FieldByName('no_step').AsInteger > 0) then
          Cells[GDM_TYPE       ,RowCount-1] := '-'
        else if (DM.Query.FieldByName('ds_menu_type').AsString = 'O') and (DM.Query.FieldByName('no_step').AsInteger > 0) then
          Cells[GDM_TYPE       ,RowCount-1] := '-'
        else if (DM.Query.FieldByName('ds_menu_type').AsString = 'O') and (DM.Query.FieldByName('no_step').AsInteger = 0) then
          Cells[GDM_TYPE       ,RowCount-1] := 'ⓞ'
        else if (DM.Query.FieldByName('ds_menu_type').AsString = 'C') and (DM.Query.FieldByName('no_step').AsInteger = 0) then
          Cells[GDM_TYPE       ,RowCount-1] := 'ⓒ'
        else Cells[GDM_TYPE       ,RowCount-1] := IntToStr(DM.Query.FieldByName('no_step').AsInteger);

        Cells[GDM_DS_MENU    ,RowCount-1] := DM.Query.FieldByName('ds_menu_type').AsString;
        Cells[GDM_CD_MENU1   ,RowCount-1] := DM.Query.FieldByName('cd_menu1').AsString;   //상품명
        Cells[GDM_SEQ        ,RowCount-1] := DM.Query.FieldByName('seq').AsString;
        Cells[GDM_NO_STEP    ,RowCount-1] := DM.Query.FieldByName('no_step').AsString;    //코스단계
        Cells[GDM_PR_SALE    ,RowCount-1] := DM.Query.FieldByName('pr_sale').AsString;    //상품단가
        Cells[GDM_VIEWQTY    ,RowCount-1] := Common.GetQtyReplace(DM.Query.FieldByName('ds_menu_type').AsString,
                                                                  DM.Query.FieldByName('qty_order').AsString);
        if Common.Menu.ds_menu = 'W' then
        begin
          Cells[GDM_VIEWPRICE  ,RowCount-1] := DM.Query.FieldByName('pr_sale_org').AsString;    //상품단가
        end
        else
        begin
          Cells[GDM_VIEWPRICE  ,RowCount-1] := DM.Query.FieldByName('pr_sale').AsString;    //상품단가
        end;

        Cells[GDM_QTY        ,RowCount-1] := DM.Query.FieldByName('qty_order').AsString;
        Cells[GDM_AMT        ,RowCount-1] := DM.Query.FieldByName('amt_order').AsString;  //금액
        Cells[GDM_YN_ORDER   ,RowCount-1] := 'Y';   //상품명
        Cells[GDM_DT_ORDER   ,RowCount-1] := DM.Query.FieldByName('dt_order').AsString;
        Cells[GDM_PR_SALE_ORG,RowCount-1] := DM.Query.FieldByName('pr_sale_org').AsString;        //상품단가
        Cells[GDM_PR_SALE_DB ,RowCount-1] := DM.Query.FieldByName('pr_sale_double').AsString;     //상품단가(곱빼기)
        Cells[GDM_DC_MENU    ,RowCount-1] := '0';                              //메뉴할인
        Cells[GDM_DS_SALE    ,RowCount-1] := DM.Query.FieldByName('ds_sale').AsString;              //매출구분
        Cells[GDM_DS_TAX     ,RowCount-1] := DM.Query.FieldByName('ds_tax').AsString;               //세무구분
        Cells[GDM_KITCHEN    ,RowCount-1] := DM.Query.FieldByName('cd_printer').AsString;              //주방프린터
        Cells[GDM_NO_SPC     ,RowCount-1] := DM.Query.FieldByName('no_spc').AsString;               //행사번호
        Cells[GDM_DC_SPC     ,RowCount-1] := DM.Query.FieldByName('dc_spc').AsString;     //행사할인금액
        Cells[GDM_MEMO       ,RowCount-1] := DM.Query.FieldByName('memo').AsString;                 //주방메모
        Cells[GDM_YN_DC      ,RowCount-1] := DM.Query.FieldByName('yn_dc').AsString;                //할인여부
        Cells[GDM_YN_POINT   ,RowCount-1] := DM.Query.FieldByName('yn_point').AsString;             //포인트적용여부
        Cells[GDM_YN_RCP     ,RowCount-1] := DM.Query.FieldByName('yn_rcp').AsString;               //영수증출력여부
        Cells[GDM_PRT_KITCHEN,RowCount-1] := DM.Query.FieldByName('ds_kitchen').AsString;//
        Cells[GDM_NO_GROUP,   RowCount-1] := DM.Query.FieldByName('no_group').AsString;   //메뉴그룹
        Cells[GDM_NM_MENU_ORG,RowCount-1] := DM.Query.FieldByName('nm_menu_short').AsString;          //메뉴원래명
        Cells[GDM_CHANGE,     RowCount-1] := 'N';                                 //변경여부
        DM.Query.Next;
      end;
      DM.Query.Close;
      DM.OpenQuery('select AMT_ORDER,  '
                  +'       AMT_DC + AMT_CODEDC + DC_MENU as DC_TOT '
                  +'  from SL_ORDER_H '
                  +' where CD_STORE =:P0 '
                  +'   and NO_TABLE =:P1 '
                  +'   and DS_ORDER =''D'' ',
                  [Common.Config.StoreCode,
                   FTableNo]);
      lblOrderAmt.Caption := FormatFloat('#,0',DM.Query.FieldByName('amt_order').AsInteger)+' 원';  //금액
      FDcAmount := DM.Query.FieldByName('dc_tot').AsInteger;
      DM.Query.Close;
    end;
  end;
end;


function TDeliveryInfo_F.DataSave(Sender: TObject): Boolean;
var vResult :String;
begin
  try
    Result := False;
    Common.BeginTran;
    //신규주문시 고객명에 포커스를 위치하지 않을때 고객명이 없으면 주소를 고객명에 넣는다
    if (GetOption(377) = '1') and (Trim(edt_CustName.Text) = EmptyStr) then
      edt_CustName.Text := edt_Address1.Text;

    DM.StoredProc.StoredProcName :='POS_SAVE_DELIVERY';
    DM.StoredProc.PrepareSQL;
    DM.StoredProc.ParamByName('_cd_store').AsString     := Common.Config.StoreCode;
    DM.StoredProc.ParamByName('_no_delivery').AsString  := RightStr(FDeliveryNo,4);
    DM.StoredProc.ParamByName('_no_table').AsInteger    := FTableNo;
    DM.StoredProc.ParamByName('_no_pos').AsString       := Common.Config.PosNo;
    DM.StoredProc.ParamByName('_ds_order').AsString     := IfThen(DeliveryButton.Appearance.SimpleLayout, 'D','P');
    DM.StoredProc.ParamByName('_cd_member').AsString    := MemberCode;
    DM.StoredProc.ParamByName('_nm_name').AsString      := edt_CustName.Text;
    DM.StoredProc.ParamByName('_no_tel1').AsString      := CtoC(edt_TelNo1.Text);
    DM.StoredProc.ParamByName('_no_tel2').AsString      := CtoC(edt_TelNo2.Text);
    DM.StoredProc.ParamByName('_no_tel3').AsString      := CtoC(edt_TelNo3.Text);
    DM.StoredProc.ParamByName('_no_tel4').AsString      := CtoC(edt_TelNo4.Text);
    DM.StoredProc.ParamByName('_address1').AsString     := edt_Address1.Text;
    DM.StoredProc.ParamByName('_address2').AsString     := edt_Address2.Text;
    DM.StoredProc.ParamByName('_coupon_cnt').AsInteger  := CourseButton.Tag;
    DM.StoredProc.ParamByName('_cd_course').AsString    := CourseButton.Hint;
    DM.StoredProc.ParamByName('_cd_local').AsString     := LocalButton.Hint;
    DM.StoredProc.ParamByName('_tel_line').AsString     := FTelLine;
    DM.StoredProc.ParamByName('_remark').AsString       := RequestRemarkMemo.Text;
    DM.StoredProc.ParamByName('_paytype').AsString      := PayButton.Hint;
    case DeliveryStep of
      dsNone      : DM.StoredProc.ParamByName('_ds_step').Value := 'N';
      dsOrder     :
      begin
        DM.StoredProc.ParamByName('_ds_step').AsString  := 'O';
        DM.StoredProc.ParamByName('_dt_order').AsDate := Now;
      end;
      dsDelivery  :
      begin
        DM.StoredProc.ParamByName('_ds_step').AsString     := 'D';
        DM.StoredProc.ParamByName('_dt_delivery').AsDate := Now;
      end;
      dsAccount   : DM.StoredProc.ParamByName('_ds_step').AsString := 'A';
      dsDishReturn: DM.StoredProc.ParamByName('_ds_step').AsString := 'R';
    end;
    DM.StoredProc.ParamByName('_cd_sawon').AsString     := FDeliveryMan;
    DM.StoredProc.ParamByName('_recall_sawon').AsString := FRecallMan;
    DM.StoredProc.ParamByName('_amt_order').AsInteger   := FOrderAmt;
    if (FWorkType <> wtEdit) and (FDeliveryNo = '') then
    begin
      DM.StoredProc.ParamByName('_ymd_delivery').AsString := Common.WorkDate;
      DM.StoredProc.ParamByName('_work_kind').AsString    := 'I';
    end
    else
    begin
      DM.StoredProc.ParamByName('_ymd_delivery').AsString := LeftStr(FDeliveryNo,8);
      DM.StoredProc.ParamByName('_work_kind').AsString    := 'E';
    end;

    DM.StoredProc.ExecProc;
    vResult := DM.StoredProc.ParamByName('_RESULT').AsString;
    if vResult <> 'OK' then
      raise Exception.Create(vResult);
    if FWorkType <> wtEdit then
    begin
      FDeliveryNo           := Common.WorkDate + DM.StoredProc.ParamByName('_no_delivery').AsString;
      FTableNo              := DM.StoredProc.ParamByName('_no_table').AsInteger;
      lblDeliveryNo.Caption := Common.WorkDate+'-'+DM.StoredProc.ParamByName('_no_delivery').AsString;
    end;
    DM.StoredProc.Close;
    Common.CommitTran;
    Result := True;
  except
    on E: Exception do
    begin
      Common.RollbackTran;
      Common.WriteLog('Delivery001',E.Message);
      Common.ErrBox(E.Message+#13#13+'저장하지 못했습니다');
      Exit;
    end;
  end;

  //배달주문내역 저장 시 회원정보를 같이 저장한다고 했을때
  if (GetOption(364) = '1') and (MemberCode <> EmptyStr) and (Sender <> MemberSaveButton)  then
    MemberSaveButtonClick(nil);
end;

//////////////////////////////////////////////////
//           배달담당자조회
//////////////////////////////////////////////////
function TDeliveryInfo_F.GetDeliveryMan: Boolean;
begin
  Result := False;
  if Common.ShowChooseForm('D','',Common.DamdangCode,Common.DamdangName) then
  begin
    FDeliveryMan := Common.DamdangCode;
    lblDeliveryDamdang.Caption := Common.DamdangName;
    Result := True;
  end;
end;

//////////////////////////////////////////////////
//           그룻회수담당자 조회
//////////////////////////////////////////////////
function TDeliveryInfo_F.GetRecallMan: Boolean;
var vTemp :String;
begin
  Result := False;
  if Common.ShowChooseForm('D','',Common.DamdangCode,vTemp) then
  begin
    FRecallMan := Common.DamdangCode;
    Result := True;
  end;
end;

procedure TDeliveryInfo_F.SetDeliveryStep(const Value: TDeliveryStep);
begin
  FDeliveryStep := Value;
  case FDeliveryStep of
    dsNone        :
    begin
      lblDeliveryStatus.Caption := '미주문';
      SaveButton.Enabled           := True;
      OrderButton.Enabled          := True;
      DeliveryGoButton.Enabled     := False;
      DishReturnButton.Enabled     := False;
      ReprintButton.Enabled        := False;
    end;
    dsOrder       :
    begin
      lblDeliveryStatus.Caption := '주문';
      SaveButton.Enabled           := True;
      OrderButton.Enabled          := True;
      DeliveryGoButton.Enabled     := True;
      DishReturnButton.Enabled     := False;
      ReprintButton.Enabled        := True;
      FDeliveryMan              := '';
      lblDeliveryDamdang.Caption:= '';
    end;
    dsDelivery    :
    begin
      lblDeliveryStatus.Caption := '배달 '+FormatDateTime('yyyy-mm-dd hh:nn', FDeliveryDate);;
      SaveButton.Enabled           := True;
      OrderButton.Enabled          := True;
      DeliveryGoButton.Enabled     := True;
      DishReturnButton.Enabled     := False;
      ReprintButton.Enabled        := True;
    end;
    dsAccount     :
    begin
      lblDeliveryStatus.Caption := '계산';
      SaveButton.Enabled           := True;
      OrderButton.Enabled          := False;
      DeliveryGoButton.Enabled     := False;
      DishReturnButton.Enabled     := True;
      ReprintButton.Enabled        := False;
    end;
    dsDishReturn  :
    begin
      lblDeliveryStatus.Caption := '그룻회수';
      SaveButton.Enabled           := True;
      OrderButton.Enabled          := False;
      DeliveryGoButton.Enabled     := False;
      DishReturnButton.Enabled     := False;
      //그릇회수 시 담당자를 사용할때
      if GetOption(144) = '1' then
        GetRecallMan;
      ReprintButton.Enabled        := False;
    end;
    dsCancel      :
    begin
      lblDeliveryStatus.Caption := '취소';
      SaveButton.Enabled           := False;
      OrderButton.Enabled          := False;
      DeliveryGoButton.Enabled     := False;
      DishReturnButton.Enabled     := False;
      ReprintButton.Enabled        := False;
    end;
    dsHistory :
    begin
      SaveButton.Enabled           := False;
      OrderButton.Enabled          := False;
      DeliveryGoButton.Enabled     := False;
      DishReturnButton.Enabled     := False;
      ReprintButton.Enabled        := False;
    end;
  end;
end;

procedure TDeliveryInfo_F.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  if FShowType <> fstNone then Close;
end;

procedure TDeliveryInfo_F.FormActivate(Sender: TObject);
var vIdx :Integer;
    vTemp :String;
begin
  Application.ProcessMessages;
  if not FFirstActive then Exit;                       
  FFirstActive := False;
  case FShowType of
    fstNone  :
    begin
      SetDeliveryInfo;
      if FWorkType = wtEdit then SetUsePos(Common.Config.PosNo);
    end;
    fstOrder :
    begin
      Self.Hide;
      Application.ProcessMessages;
      SetDeliveryInfo;
      SetUsePos(Common.Config.PosNo);
      isAutoOrder := true;
      OrderButtonClick(nil);
      isAutoOrder := false;
    end;
    fstDelete :
    begin
      Self.Hide;
      Application.ProcessMessages;
      SetDeliveryInfo;
      Common.ClearKitchenData;                   //주문서출력정보 초기화
      if DeliveryStep = dsNone then
      begin
        DeleteDelivery;
        Timer1.Enabled := True;
      end
      else
      begin
        Order_F := TOrder_F.Create(self);
        try
          Order_F.FormShow(nil);
          Common.Table.Name := FDeliveryNo;
          Common.GridToGrid(Order_sGrd, Order_F.Main_sGrd);
          //////////////////////////  감사저널에 저장  ///////////////////////////////
          For vIdx := 0 to Order_F.Main_sGrd.RowCount-1 do
          begin
            Common.OrderCancelGridSave(vIdx, StoI( Order_F.Main_sGrd.Cells[GDM_QTY, vIdx] ),'Y','N' );
            vTemp := Order_F.Main_sGrd.Cells[GDM_VIEWQTY, vIdx];

            Common.Device.OrderCancel(Order_F.Main_sGrd, vIdx, vTemp);
          end;
          Order_F.OrderCancelDBApply(2);
        finally
          FreeAndNil(Order_F);
          Common.Device.OrderPrint(False, ((GetOption(10) ='1') and (GetOption(154)='0')));
          DeleteDelivery;
          Timer1.Enabled := True;
        end;
      end;
    end;
    fstDeliveryGo :
    begin
      Self.Hide;
      Application.ProcessMessages;
      SetDeliveryInfo;
      DeliveryGoButtonClick(nil);
      Timer1.Enabled := True;
    end;
    fstRePrint :
    begin
      Self.Hide;
      Application.ProcessMessages;
      SetDeliveryInfo;                              
      case DeliveryStep of
        dsOrder :
        begin
          if (StoI(GetOption(143)) > 0) then Common.Device.DeliveryPrint;
          if (StoI(GetOption(186)) > 0) then Common.Device.DeliveryReceiptPrint;
        end;
        dsDelivery :
        begin
          if (StoI(GetOption(189)) > 0) then Common.Device.DeliveryPrint;
          if (StoI(GetOption(119)) > 0) then Common.Device.DeliveryReceiptPrint;
        end;
        dsAccount :
        begin
          if (StoI(GetOption(145)) > 0) then Common.Device.DeliveryPrint;
          if (StoI(GetOption(190)) > 0) then Common.Device.DeliveryReceiptPrint;
        end;
      end;
      Timer1.Enabled := True;
    end;
    fstDishReturn :
    begin
      Self.Hide;
      Application.ProcessMessages;
      SetDeliveryInfo;
      DeliveryStep := dsDishReturn;
      SaveButtonClick(nil);
      Timer1.Enabled := True;
    end;
  end;
end;

procedure TDeliveryInfo_F.DeleteDelivery;
begin
  try
    Common.BeginTran;

    DM.StoredProc.StoredProcName :='SAVE_TABLE_CANCEL';
    DM.StoredProc.PrepareSQL;
    DM.StoredProc.ParamByName('_cd_store').Value  := Common.Config.StoreCode;
    DM.StoredProc.ParamByName('_ymd_sale').Value  := Common.WorkDate;
    DM.StoredProc.ParamByName('_v_no_table').Value:= FTableNo;
    DM.StoredProc.ParamByName('_no_rcp').Value    := '';
    DM.StoredProc.ParamByName('_ds_order').Value  := 'D';
    DM.StoredProc.ExecProc;

    if DeliveryStep = dsNone then
    begin
      //미주문상태에서 삭제하면 정말삭제한다
      ExecQuery('delete '
               +'  from SL_DELIVERY '
               +' where CD_STORE     =:P0 '
               +'   and YMD_DELIVERY =:P1 '
               +'   and NO_DELIVERY  =:P2 ',
               [Common.Config.StoreCode,
                LeftStr(FDeliveryNo,8),
                RightStr(FDeliveryNo,4)]);
    end
    else
    begin
      ExecQuery('update SL_DELIVERY '
               +'   set DS_STEP      =''C'' '
               +' where CD_STORE     =:P0 '
               +'   and YMD_DELIVERY =:P1 '
               +'   and NO_DELIVERY  =:P2 ',
               [Common.Config.StoreCode,
                LeftStr(FDeliveryNo,8),
                RightStr(FDeliveryNo,4)]);

    end;
    ExecQuery('delete '
             +'  from SL_ORDER_H '
             +' where CD_STORE =:P0 '
             +'   and NO_TABLE =:P1 '
             +'   and DS_ORDER = ''D'' ',
             [Common.Config.StoreCode,
              FTableNo ]);
    ExecQuery('delete '
             +'  from SL_ORDER_D '
             +' where CD_STORE =:P0 '
             +'   and NO_TABLE =:P1 '
             +'   and DS_ORDER = ''D'' ',
             [Common.Config.StoreCode,
              FTableNo ]);

    ExecQuery('delete '
             +'  from SL_ORDER_C '
             +' where CD_STORE =:P0 '
             +'   and NO_TABLE =:P1 '
             +'   and DS_ORDER = ''D'' ' ,
             [Common.Config.StoreCode,
              FTableNo ]);

    ExecQuery('delete '
             +'  from SL_ORDER_PRT '
             +' where CD_STORE =:P0 '
             +'   and NO_TABLE =:P1 '
             +'   and DS_ORDER = ''D'' ',
             [Common.Config.StoreCode,
              FTableNo ]);

    Common.CommitTran;
  except
    on E: Exception do
    begin
      Common.RollbackTran;
      Common.WriteLog('Delivery002',E.Message);
      Common.ErrBox(E.Message);
      Exit;
    end;
  end;
end;

procedure TDeliveryInfo_F.DeliveryButtonClick(Sender: TObject);
begin
  if Sender = DeliveryButton then
  begin
    DeliveryButton.Appearance.SimpleLayout := true;
    PackingButton.Appearance.SimpleLayout  := false;
  end
  else
  begin
    DeliveryButton.Appearance.SimpleLayout := false;
    PackingButton.Appearance.SimpleLayout  := true;
  end;
end;

procedure TDeliveryInfo_F.DeliveryGoButtonClick(Sender: TObject);
begin
  //배달담당자를 사용 시 배달담당자를 지정한다
  if (GetOption(120) = '0') and (not GetDeliveryMan) then
  begin
    if not Common.AskBox('배달담당자가 지정되지 않았습니다'+#13#13+'계속하시겠습니까?') then Exit;
  end;

  FBeforStep := DeliveryStep;

  FDeliveryDate := now();
  DeliveryStep  := dsDelivery;
  SaveButtonClick(nil);
end;

procedure TDeliveryInfo_F.DishReturnButtonClick(Sender: TObject);
begin
  DeliveryStep := dsDishReturn;
  SaveButtonClick(nil);
  Close;
end;

procedure TDeliveryInfo_F.SearchButtonClick(Sender: TObject);
var vIsSearch :Boolean;
    vWhere1,
    vWhere2 :String;
begin
  vIsSearch := false;
  if (edt_TelNo1.Text ='') and (edt_TelNo2.Text ='') and (edt_TelNo3.Text ='') and (edt_TelNo4.Text ='') then
  begin
    Common.ErrBox('전화번호를 입력하세요');
    edt_TelNo1.SetFocus;
    Exit;
  end;

  if Length(GetOnlyNumber(edt_TelNo1.Text)) >= 10 then
  begin
    vWhere1 := Format('''%s'',',[GetOnlyNumber(edt_TelNo1.Text)]);
    vWhere2 := Format('''%s'',',[GetOnlyNumber(edt_TelNo1.Text)]);
  end;

  if Length(GetOnlyNumber(edt_TelNo2.Text)) >= 10 then
  begin
    vWhere1 := vWhere1 + Format('''%s'',',[GetOnlyNumber(edt_TelNo2.Text)]);
    vWhere2 := vWhere2 + Format('''%s'',',[GetOnlyNumber(edt_TelNo2.Text)]);
  end;

  if Length(GetOnlyNumber(edt_TelNo3.Text)) >= 10 then
  begin
    vWhere1 := vWhere1 + Format('''%s'',',[GetOnlyNumber(edt_TelNo3.Text)]);
    vWhere2 := vWhere2 + Format('''%s'',',[GetOnlyNumber(edt_TelNo3.Text)]);
  end;

  if Length(GetOnlyNumber(edt_TelNo4.Text)) >= 10 then
  begin
    vWhere1 := vWhere1 + Format('''%s'',',[GetOnlyNumber(edt_TelNo4.Text)]);
    vWhere2 := vWhere2 + Format('''%s'',',[GetOnlyNumber(edt_TelNo4.Text)]);
  end;

  if vWhere1 <> '' then
    vWhere1 := Format(' a.TEL_MOBILE = %s or a.TEL_HOME = %s ',[LeftStr(vWhere1,Length(vWhere1)-1),LeftStr(vWhere1,Length(vWhere1)-1)]);
  if (vWhere1 <> '') and (vWhere2 <> '') then
    vWhere2 := Format(' or a.TEL_ETC1 = %s or a.TEL_ETC2 = %s ',[LeftStr(vWhere2,Length(vWhere2)-1),LeftStr(vWhere2,Length(vWhere2)-1)])
  else if (vWhere1 = '') and (vWhere2 <> '') then
    vWhere2 := Format(' a.TEL_ETC1 = %s or a.TEL_ETC2 = %s ',[LeftStr(vWhere2,Length(vWhere2)-1),LeftStr(vWhere2,Length(vWhere2)-1)]);

  if vWhere1+vWhere2 = '' then Exit;


  //회원여부 체크
  OpenQuery('select 1 as SEQ, '
           +' 		  a.CD_MEMBER, '
           +' 		  a.NM_MEMBER	as NM_NAME, '
           +' 		  a.TEL_MOBILE	as NO_TEL1, '
           +' 			a.TEL_HOME	as NO_TEL2, '
           +' 			a.TEL_ETC1	as NO_TEL3, '
           +' 			a.TEL_ETC2	as NO_TEL4, '
           +' 			a.ADDR1		as ADDRESS1, '
           +' 			a.ADDR2		as ADDRESS2, '
           +' 			a.REMARK, '
           +' 			a.CD_LOCAL, '
           +' 			b.NM_CODE1 as NM_LOCAL, '
           +' 			a.CD_COURSE, '
           +' 			c.NM_CODE1 as NM_COURSE '
           +'  from MS_MEMBER a left outer join '
           +'       MS_CODE   b on b.CD_STORE = a.CD_STORE and b.CD_KIND = ''22'' and b.CD_CODE = a.CD_LOCAL left outer join '
           +'       MS_CODE   c on c.CD_STORE = a.CD_STORE and c.CD_KIND = ''20'' and c.CD_CODE = a.CD_COURSE '
           +' where a.CD_STORE 	=:P0 '
           +'   and ('+vWhere1+vWhere2+')'
           +'   and a.DS_STATUS = ''0'' '
           +Ifthen(GetOnlyNumber(edt_TelNo1.Text)<>'',
           '	union all  '
           +'select 2 as SEQ, '
           +'	 	    a.CD_MEMBER, '
           +'	 	    a.NM_NAME, '
           +'	 	    a.NO_TEL1, '
           +'	 	    a.NO_TEL2, '
           +'	 	    a.NO_TEL3, '
           +'	 	    a.NO_TEL4, '
           +'	 	    a.ADDRESS1, '
           +'	 	    a.ADDRESS2, '
           +'	 	    '''' as REMARK, '
           +'	 	    a.CD_LOCAL, '
           +'	 		  b.NM_CODE1 as NM_LOCAL, '
           +'	 	    a.CD_COURSE, '
           +'	 		  c.NM_CODE1 as NM_COURSE '
           +'  from SL_DELIVERY a left outer join '
           +'       MS_CODE   b on b.CD_STORE = a.CD_STORE and b.CD_KIND = ''22'' and b.CD_CODE = a.CD_LOCAL left outer join '
           +'       MS_CODE   c on c.CD_STORE = a.CD_STORE and c.CD_KIND = ''20'' and c.CD_CODE = a.CD_COURSE '
           +' where a.CD_STORE 	= :P0 '
           +'   and ConCat(a.YMD_DELIVERY,a.NO_DELIVERY) = (select Max(ConCat(YMD_DELIVERY,NO_DELIVERY)) '
           +'                                                 from SL_DELIVERY '
           +'                                                where CD_STORE = :P0 '
           +'                                                  and NO_TEL1    = '''+GetOnlyNumber(edt_TelNo1.Text)+''')',
            '')
           +' order by 1 '
           +'  limit 1 ',
           [Common.Config.StoreCode]);

  MemberCode := EmptyStr;
  lbl_Member.Caption := EmptyStr;
  while not Common.Query.Eof do
  begin
    case Common.Query.FieldByName('seq').AsInteger of
      1 :
      begin
        MemberCode              := Common.Query.FieldByName('cd_member').AsString;
        lbl_Member.Caption      := IfThen(MemberCode = '', '비회원', '회원 (' + MemberCode + ')');
        edt_CustName.Text       := Common.Query.FieldByName('nm_name').AsString;
        edt_TelNo1.Text         := SetTelephone(Common.Query.FieldByName('no_tel1').AsString);
        edt_TelNo2.Text         := SetTelephone(Common.Query.FieldByName('no_tel2').AsString);
        edt_TelNo3.Text         := SetTelephone(Common.Query.FieldByName('no_tel3').AsString);
        edt_TelNo4.Text         := SetTelephone(Common.Query.FieldByName('no_tel4').AsString);
        edt_Address1.Text       := Common.Query.FieldByName('address1').AsString;
        edt_Address2.Text       := Common.Query.FieldByName('address2').AsString;
        RemarkMemo.Text         := Common.Query.FieldByName('remark').AsString;
        CourseButton.Caption    := Common.Query.FieldByName('nm_course').AsString;
        CourseButton.Hint       := Common.Query.FieldByName('cd_course').AsString;
        LocalButton.Caption     := Common.Query.FieldByName('nm_Local').AsString;
        LocalButton.Hint        := Common.Query.FieldByName('cd_Local').AsString;
        vIsSearch := true;
      end;
      2 :
      begin
        if MemberCode = EmptyStr then
        begin
          lbl_Member.Caption      := IfThen(MemberCode = '', '비회원', '회원 (' + MemberCode + ')');
          edt_CustName.Text       := Common.Query.FieldByName('nm_name').AsString;
          edt_TelNo1.Text         := SetTelephone(Common.Query.FieldByName('no_tel1').AsString);
          edt_TelNo2.Text         := SetTelephone(Common.Query.FieldByName('no_tel2').AsString);
          edt_TelNo3.Text         := SetTelephone(Common.Query.FieldByName('no_tel3').AsString);
          edt_TelNo4.Text         := SetTelephone(Common.Query.FieldByName('no_tel4').AsString);
          edt_Address1.Text       := Common.Query.FieldByName('address1').AsString;
          edt_Address2.Text       := Common.Query.FieldByName('address2').AsString;
          RemarkMemo.Text         := Common.Query.FieldByName('remark').AsString;
          CourseButton.Caption    := Common.Query.FieldByName('nm_course').AsString;
          CourseButton.Hint       := Common.Query.FieldByName('cd_course').AsString;
          LocalButton.Caption     := Common.Query.FieldByName('nm_Local').AsString;
          LocalButton.Hint        := Common.Query.FieldByName('cd_Local').AsString;
          vIsSearch := true;
        end;
      end;
    end;
    Common.Query.Next;
  end;

  if MemberCode <> EmptyStr then
  begin
    OpenQuery('select ifnull(Sum(T2.AMT_SALE), 0) as AMT_ORDER, '
             +'	      ifnull(MAX(YMD_SALE),'''') as YMD_LASTORDER, '
             +'   	  Count(T1.YMD_DELIVERY) as CNT_ORDER '
             +'  from SL_DELIVERY t1 inner join '
             +'       SL_SALE_H   t2 on t1.CD_STORE  = t2.CD_STORE '
             +'                     and t2.CD_MEMBER =:P1 '
             +'                     and ConCat(t1.YMD_DELIVERY,t1.NO_DELIVERY) = t2.NO_DELIVERY '
             +' where t1.CD_STORE  = :P0 '
             +'   and t1.CD_MEMBER = :P1 ',
             [Common.Config.StoreCode,
              MemberCode]);
  end
  else if Trim(CtoC(edt_TelNo1.Text)) <> EmptyStr then
  begin
    OpenQuery('select ifnull(SUM(T2.AMT_SALE),0) as AMT_ORDER, '
             +'	      MAX(T2.YMD_SALE) as YMD_LASTORDER, '
             +'   	  COUNT(*) as CNT_ORDER'
             +'  from SL_DELIVERY t1  inner join '
             +'       SL_SALE_H   t2  on t1.CD_STORE = t2.CD_STORE '
             +'                      and ifnull(t2.NO_DELIVERY,'''') <> '''' '
             +'                      and ConCat(t1.YMD_DELIVERY,t1.NO_DELIVERY) = t2.NO_DELIVERY '
             +' where t1.CD_STORE = :P0 '
             +'   and t1.NO_TEL1  = :P1 ',
             [Common.Config.StoreCode,
              CtoC(edt_TelNo1.Text)]);
  end;

  if not Common.Query.Eof then
  begin
    TotalOrderCountLabel.Caption  := NVL(Common.Query.FieldByName('CNT_ORDER').AsInteger,'');
    TotalOrderAmtLabel.Caption    := FormatFloat('#,0',Common.Query.FieldByName('amt_order').AsInteger);
  end;

  Common.Query.Close;

  if not vIsSearch then
  begin
    if (Sender = SearchButton) then
      Common.ErrBox(Format('조건에 맞는 자료가 없습니다'#13'(%s)',[edt_TelNo1.Text]));
    Exit;
  end;
  SetDeliveryHistory(0);
end;

procedure TDeliveryInfo_F.SetDeliveryHistory(Kind:Integer);
begin
  if (CtoC(edt_TelNo1.Text) = EmptyStr) and (MemberCode = '') then
  begin
    Common.ClearGrid(Sale_sGrd);
    Exit;
  end;

  OpenQuery('select 1 as SEQ, '
           +'		  	ifnull(SUM(AMT_ORDER), 0) as AMT_ORDER, '
           +'		  	0 as CNT, '
           +'		  	'''' as YMD_DELIVERY, '
           +'		  	'''' as ORDERMENU, '
           +'		  	'''' as PAYTYPE, '
           +'		  	0 as COUPON_CNT, '
           +'       '''' as DELIVERY_NO, '
           +'       '''' as REMARK '
           +'	 from SL_DELIVERY '
           +' where CD_STORE = :P0 '
           +'	  and DS_STEP in (''A'',''R'') '
           +'	  and YMD_DELIVERY >= Date_Format(DATE_ADD(Now(), INTERVAL -:P2 MONTH), ''%Y%m%d'') '
           +Ifthen(MemberCode = '',' and NO_TEL1 = :P1 ', ' and CD_MEMBER = :P1 ')
           +'union all '
           +'select 2, '
           +'		    0, '
           +'		    COUNT(*), '
           +'		    '''', '
           +'		    '''', '
           +'		    '''', '
           +'		    0, '
           +'       '''', '
           +'       '''' '
           +'	 from SL_DELIVERY '
           +' where CD_STORE = :P0 '
           +'	  and DS_STEP in (''A'',''R'') '
           +'	  and YMD_DELIVERY >= Date_Format(DATE_ADD(Now(), INTERVAL -:P2 MONTH), ''%Y%m%d'') '
           +Ifthen(MemberCode = '',' and NO_TEL1 = :P1 ', ' and CD_MEMBER = :P1 ')
           +'union all '
           +'select 3, '
           +'		    0, '
           +'		    0, '
           +'		    StoD(YMD_DELIVERY) YMD_DELIVERY, ORDERMENU, PAYTYPE, COUPON_CNT, '
           +'       ConCat(YMD_DELIVERY,NO_DELIVERY), '
           +'       REMARK '
           +'  from SL_DELIVERY '
           +' where CD_STORE = :P0 '
           +'		and DS_STEP in (''A'',''R'') '
           +'	  and YMD_DELIVERY >= Date_Format(DATE_ADD(Now(), INTERVAL -:P2 MONTH), ''%Y%m%d'') '
           +Ifthen(MemberCode = '',' and NO_TEL1 = :P1 ', ' and CD_MEMBER = :P1 ')
           +'order by 1, 4 desc ',
           [Common.Config.StoreCode,
            Ifthen(MemberCode = '', CtoC(edt_TelNo1.Text),MemberCode),
            3]);

  Common.ClearGrid(Sale_sGrd);
  while not Common.Query.Eof do
  begin
    case Common.Query.FieldByName('seq').AsInteger of
      1 : TotalOrderAmtLabel.Caption   := FormatFloat('#,0', NVL(Common.Query.FieldByName('AMT_ORDER').AsInteger,0)) +'원';
      2 : TotalOrderCountLabel.Caption := FormatFloat('#,0', NVL(Common.Query.FieldByName('CNT').AsInteger,0));
      3 :
      begin
        if Sale_sGrd.Cells[0,0] <> '' then Sale_sGrd.RowCount := Sale_sGrd.RowCount+1;

        Sale_sGrd.Cells[0, Sale_sGrd.RowCount-1] := Common.Query.FieldByName('ymd_delivery').AsString;
        Sale_sGrd.Cells[1, Sale_sGrd.RowCount-1] := Common.Query.FieldByName('ordermenu').AsString;
        Sale_sGrd.Cells[2, Sale_sGrd.RowCount-1] := Common.Query.FieldByName('paytype').AsString;
        Sale_sGrd.Cells[3, Sale_sGrd.RowCount-1] := Common.Query.FieldByName('coupon_cnt').AsString;
        Sale_sGrd.Cells[4, Sale_sGrd.RowCount-1] := Common.Query.FieldByName('delivery_no').AsString;
        Sale_sGrd.Cells[5, Sale_sGrd.RowCount-1] := Common.Query.FieldByName('remark').AsString;
      end;
    end;
    Common.Query.Next;
  end;
  Sale_sGrd.Enabled := Sale_sGrd.RowCount > 0;
  Common.Query.Close;
end;

procedure TDeliveryInfo_F.ClearDeliveryData;
begin
  MemberCode        := EmptyStr;  //회원번호
  FBefOrderAmt      := 0;         //직전 주문금액
  FTableNo          := 0;
  FBeforStep        := dsNone;    //직전 배달상태
  FDeliveryStep     := dsNone;    //배달상태
  FDeliveryMan      := EmptyStr;  //배달담당
  FRecallMan        := EmptyStr;
  FDeliveryDate     := 0;
  CouponButton.Caption := '0 매';
  CouponButton.Tag     := 0;
  CourseButton.Caption := '';
  CourseButton.Hint    := '';
end;

procedure TDeliveryInfo_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TDeliveryInfo_F.CouponButtonClick(Sender: TObject);
var vRtn :String;
begin
  vRtn := Common.ShowNumberForm('쿠폰매수를 입력하세요', 0,99,'0');
  if vRtn = 'mrClose' then Exit;

  CouponButton.Caption := FormatFloat('#0 매', StoI(vRtn));
  CouponButton.Tag     := StoI(vRtn);
end;

procedure TDeliveryInfo_F.CourseButtonClick(Sender: TObject);
var vCode, vName, vSql :String;
begin
  vSql := 'select CD_CODE, '
         +'       NM_CODE1 as NM_COURSE, '
         +'       0 as CNT_DELIVERY '
         +'  from MS_CODE '
         +' where CD_STORE =:P0 '
         +'   and CD_KIND =''20'' '
         +'   and DS_STATUS = ''0'' '
         +' order by CD_CODE';

  if Common.ShowChooseForm('C','', vCode, vName, vSql) then
  begin
    CourseButton.Caption := vName;
    CourseButton.Hint    := vCode;
    edt_Address1.SetFocus;
    edt_Address1.SetSelection(Length(edt_Address1.Text),1);
  end
  else
  begin
    LocalButton.Caption := '';
    LocalButton.Hint    := '';
  end;
  Common.Table.Course := CourseButton.Caption;
end;

procedure TDeliveryInfo_F.FormShow(Sender: TObject);
begin
  isAutoOrder := false;
  if Common.Config.Cid_Port > 0 then
    Common.Device.OnCidReadData :=CidReadEvent;
  ClearDeliveryData;
  fmKeyPad.Visible := False;
  isDeliveryReceiptPrint := true;
  ClickTime         := IncSecond(Now,-3);
end;

procedure TDeliveryInfo_F.SetUsePos(aValue: String);
begin
  ExecQuery('update SL_DELIVERY '
           +'   set USE_POSNO   =:P3 '
           +' where CD_STORE    =:P0 '
           +'   and YMD_DELIVERY=:P1 '
           +'   and NO_DELIVERY =:P2',
           [Common.Config.StoreCode,
            LeftStr(FDeliveryNo,8),
            RightStr(FDeliveryNo,4),
            aValue]);
end;

procedure TDeliveryInfo_F.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Common.Device.OnCidReadData := nil;
  SetUsePos('');
end;

procedure TDeliveryInfo_F.CardButtonClick(Sender: TObject);
begin
  PayButton.Hint    := (Sender as TAdvSmoothToggleButton).Hint;
  PayButton.Caption := (Sender as TAdvSmoothToggleButton).Caption;
  PayPanel.Visible  := false;
end;

procedure TDeliveryInfo_F.CidReadEvent(const S: String);
  function GetPopUpTop:Integer;
  var I :Integer;
  begin
    For I := 1 to 4 do
    begin
      if Common.DeliveryTel[I].Status = '' then
      begin
        Result := (I * 122)-122+16;
        Break;
      end;
    end;
  end;
  procedure DeleteCidData(S:String);
  var I :Integer;
  begin
    For I := 0 to Common.CidData.Count-1 do
    begin
      if Copy(S,4,12) = Copy(Common.CidData.Strings[I],1,12) then
      begin
        Common.CidData.Delete(I);
        Break;
      end;
    end;
  end;
var vLine :Integer;
begin
  if Length(Trim(S)) < 3 then Exit;

  //전화가 왔을때(콜스타)
  if (S[1] = 'C') and (S[3] <> 'S') then
  begin
    //부재중전화 리스트에 저장
    Common.AddCidData(S);

    vLine := StrToInt(Copy(S,2,1));
//    FPopUp[vLine].Close(FPopUp[vLine].Caption);
    Common.ClearDeliveryTel(vLine);
//    FPopUp[vLine].PopupStartY := (vLine * 122)-122+16;
    Common.GetDeliveryTelInfo( S );
    //기주문건이면 부재중에서 삭제한다
    if (Common.DeliveryTel[vLine].Status <> '0') or (Common.DeliveryTel[vLine].Status <> '1') then
      DeleteCidData(S);

//    FPopUp[vLine].Title := Common.DeliveryTel[vLine].Cust + ' ['+Copy(S,2,1)+'회선]';
//    if (Common.DeliveryTel[vLine].Status = '0') or (Common.DeliveryTel[vLine].Status = '1') then
//      FPopUp[vLine].Text  := Common.DeliveryTel[vLine].TelNo + #13 +'(출력)'
//    else
//    begin
//      if Common.DeliveryTel[vLine].Status = 'N' then
//        FPopUp[vLine].Text  := Common.DeliveryTel[vLine].TelNo + #13 +'[미주문]'+#13+'(출력)'
//      else if Common.DeliveryTel[vLine].Status = 'O' then
//        FPopUp[vLine].Text  := Common.DeliveryTel[vLine].TelNo + #13 +'[주문]'+#13+'(출력)'
//      else if Common.DeliveryTel[vLine].Status = 'D' then
//        FPopUp[vLine].Text  := Common.DeliveryTel[vLine].TelNo + #13 +'[배달]'+#13+'(출력)';
//    end;
//    FPopUp[vLine].URL     := '';
//    FPopUp[vLine].TimeOut := 15;
//    FPopUp[vLine].ShowPopUp;
  end
   //전화를 받았을때(콜스타)
  else if (S[1] = 'C') and (S[3] = 'S') then
  begin
    //전화를 받으면 해당 팝업을 닫는다
    vLine := StrToInt(Copy(S,2,1));
    try
//      FPopUp[vLine].Close(FPopUp[vLine].Caption);
    except
    end;
  end;

end;

procedure TDeliveryInfo_F.MapButtonClick(Sender: TObject);
begin
  if (Trim(edt_Address1.Text) = '') and (Trim(edt_Address2.Text) = '') then
  begin
    Common.ErrBox('주소가 없습니다');
    if edt_Address2.Enabled then
      edt_Address2.SetFocus;
    Exit;
  end;

  Common.MapCount := Common.MapCount + 1;
  Map_F := TMap_F.Create(Application);
  try
    Map_F.WebURL := edt_Address1.Text + edt_Address2.Text;
    Map_F.ShowModal;
  finally
    FreeAndNil(Map_F);
  end;
end;

procedure TDeliveryInfo_F.MemberSaveButtonClick(Sender: TObject);
var vMobileNo,
    vHomeNo :String;
    vDeliveryDate,
    vDeliveryNo :String;
    vSeq, vIndex   :Integer;
    vCode  :String;
    vPoint :Integer;
    vWhere1,
    vWhere2,
    vTemp :String;
begin
  for vIndex := 0 to ComponentCount-1 do
    if (Components[vIndex] is TcxTextEdit) then
      (Components[vIndex] as TcxTextEdit).PostEditValue;

  if (GetOption(377) = '1') and (Trim(edt_CustName.Text) = '') then
    edt_CustName.Text := edt_Address1.Text + Ifthen(edt_Address2.Text <> '', ' ' + edt_Address2.Text,'');

  if (GetOption(150) = '0') and (Trim(edt_CustName.Text) = '') then
  begin
    Common.ErrBox('회원명을 입력하세요');
    edt_CustName.SetFocus;
    Exit;
  end;

  if (Trim(edt_TelNo1.Text) = '') and (Trim(edt_TelNo2.Text) = '') then
  begin
    Common.ErrBox('전화번호를 입력하세요');
    edt_TelNo1.SetFocus;
    Exit;
  end;

  if (GetOption(150) = '0') and (Trim(edt_Address1.Text) = '') then
  begin
    Common.ErrBox('주소를 입력하세요');
    edt_Address1.SetFocus;
    Exit;
  end;

  try
    MemberSaveButton.Enabled := False;
    if CtoC(edt_TelNo1.Text) <> '' then
    begin
      vWhere1 := Format('''%s'',',[GetOnlyNumber(edt_TelNo1.Text)]);
      vWhere2 := Format('''%s'',',[GetOnlyNumber(edt_TelNo1.Text)]);
    end;

    if CtoC(edt_TelNo2.Text) <> '' then
    begin
      vWhere1 := vWhere1 + Format('''%s'',',[GetOnlyNumber(edt_TelNo2.Text)]);
      vWhere2 := vWhere2 + Format('''%s'',',[GetOnlyNumber(edt_TelNo2.Text)]);
    end;

    if CtoC(edt_TelNo3.Text) <> '' then
    begin
      vWhere1 := vWhere1 + Format('''%s'',',[GetOnlyNumber(edt_TelNo3.Text)]);
      vWhere2 := vWhere2 + Format('''%s'',',[GetOnlyNumber(edt_TelNo3.Text)]);
    end;

    if CtoC(edt_TelNo4.Text) <> '' then
    begin
      vWhere1 := vWhere1 + Format('''%s'',',[GetOnlyNumber(edt_TelNo4.Text)]);
      vWhere2 := vWhere2 + Format('''%s'',',[GetOnlyNumber(edt_TelNo4.Text)]);
    end;

    vWhere1 := '('+LeftStr(vWhere1,Length(vWhere1)-1)+')';
    vWhere2 := '('+LeftStr(vWhere2,Length(vWhere2)-1)+')';

    if MemberCode = '' then
    begin
      OpenQuery('select Count(*) '
               +'  from MS_MEMBER '
               +' where CD_STORE =:P0 '
               +'   and ( TEL_MOBILE in '+vWhere1
               +'		   or TEL_HOME  in '+vWhere1
               +'		   or TEL_ETC1  in '+vWhere2
               +'		   or TEL_ETC2  in '+vWhere2+' ) '
               +'   and DS_STATUS = ''0'' ',
                [Common.Config.StoreCode]);

      if Common.Query.Fields[0].AsInteger > 0 then
      begin
        Common.Query.Close;
        Common.ErrBox('이미 등록된 전화번호입니다');
        Exit;
      end;
      Common.Query.Close;
    end;

    if IsMobileNumber(GetOnlyNumber(edt_TelNo1.Text)) then
      vMobileNo := GetOnlyNumber(edt_TelNo1.Text)
    else
      vHomeNo := GetOnlyNumber(edt_TelNo1.Text);

    //신규주문시 고객명에 포커스를 위치하지 않을때 고객명이 없으면 주소를 고객명에 넣는다
    if (GetOption(377) = '1') and (Trim(edt_CustName.Text) = EmptyStr) then
      edt_CustName.Text := edt_Address1.Text;
    if MemberCode = '' then
    begin
      if not Common.SaveMemberAdd(true,                                  //aNew
                                  '',                                    //aMemberNo
                                  edt_CustName.Text,                     //aName
                                  Common.Member.cd_class,                //aDsMember
                                  '',                                   //aGender
                                  vHomeNo,                               //aHomeTel
                                  vMobileNo,                             //aMobileTel
                                  Common.Member.CardNo,                  //aCardNo
                                  '',                                    //aPost
                                  edt_Address1.Text,                     //aAddr1
                                  edt_Address2.Text,                     //aAddr2
                                  Common.Member.no_cashrcp,              //aCashRcpNo
                                  CourseButton.Hint,                     //aCourse
                                  LocalButton.Hint,                      //aLocal
                                  '',                                    //aLunar
                                  Common.Member.Yn_trust,                //aTrust
                                  '',                                    //aNews
                                  '',                                    //aBirthDay
                                  '',                                    //aDamdangCode
                                  RemarkMemo.Text,                       //aRemark
                                  GetOnlyNumber(edt_TelNo3.Text),        //aEtcTel1
                                  GetOnlyNumber(edt_TelNo4.Text)) then  //aEtcTel2
      Exit;

      //일반고객으로 판매된 배달내역을 회원으로 변경한다
      if Sale_sGrd.Cells[0,0] <> '' then
      begin
        ExecQuery('update SL_DELIVERY '
                 +'   set CD_MEMBER = :P2 '
                 +' where CD_STORE  = :P0 '
                 +'   and NO_TEL1   = :P1 '
                 +'   and CD_MEMBER = '''' ',
                 [Common.Config.StoreCode,
                  CtoC(edt_TelNo1.Text),
                  MemberCode]);
      end;
    end
    else
    begin
      if not Common.SaveMemberAdd(false,                                 //aNew
                                  MemberCode,                            //aMemberNo
                                  edt_CustName.Text,                     //aName
                                  Common.Member.cd_class,                //aDsMember
                                  '',                                    //aGender
                                  vHomeNo,                               //aHomeTel
                                  vMobileNo,                             //aMobileTel
                                  Common.Member.CardNo,                  //aCardNo
                                  '',                                    //aPost
                                  edt_Address1.Text,                     //aAddr1
                                  edt_Address2.Text,                     //aAddr2
                                  '',                                    //aCashRcpNo
                                  CourseButton.Hint,                     //aCourse
                                  LocalButton.Hint,                      //aLocal
                                  '',                                    //aLunar
                                  Common.Member.Yn_trust,                //aTrust
                                  '',                                    //aNews
                                  '',                                    //aBirthDay
                                  '',                                    //aDamdangCode
                                  RemarkMemo.Text,                       //aRemark
                                  GetOnlyNumber(edt_TelNo3.Text),        //aEtcTel1
                                  GetOnlyNumber(edt_TelNo4.Text)) then  //aEtcTel2
      Exit;


      OpenQuery('select YMD_DELIVERY, '
              +'			  NO_DELIVERY '
              +'	 from SL_DELIVERY '
              +'	where CD_STORE	=:P0 '
              +'		and CD_MEMBER =:P1 '
              +'	order by YMD_DELIVERY DESC, NO_DELIVERY desc '
              +'  limit 1 ',
              [Common.Config.StoreCode,
               MemberCode]);

      vDeliveryDate := Common.Query.Fields[0].AsString;
      vDeliveryNo   := Common.Query.Fields[1].AsString;
      Common.Query.Close;

      ExecQuery('update SL_DELIVERY '
               +'   set NO_TEL1		=:P4, '
               +'				NO_TEL2		=:P5, '
               +'				ADDRESS1	=:P6, '
               +'			  ADDRESS2	=:P7 '
               +'	where CD_STORE      =:P0 '
               +'   and CD_MEMBER   	=:P1 '
               +'		and YMD_DELIVERY	=:P2 '
               +'		and NO_DELIVERY 	=:P3 ',
               [Common.Config.StoreCode,
                MemberCode,
                vDeliveryDate,
                vDeliveryNo,
                GetOnlyNumber(edt_TelNo1.Text),
                GetOnlyNumber(edt_TelNo2.Text),
                edt_Address1.Text,
                edt_Address2.Text]);
    end;

    MemberCode         := Common.Member.Code;
    lbl_Member.Caption := '회원 ('+MemberCode+')';

    if Sender <> nil then
    begin
      Common.MsgBox('저장이 완료되었습니다');
      SaveButtonClick(MemberSaveButton);
    end;

  finally
    MemberSaveButton.Enabled := True;
  end;
end;

procedure TDeliveryInfo_F.MemberSearchButtonClick(Sender: TObject);
begin
  if Common.ShowMemberForm then
  begin
    MemberCode         := Common.Member.Code;
    lbl_Member.Caption := '회원 ('+MemberCode+')';
    edt_CustName.Text  := Common.Member.Name;
    edt_TelNo1.Text    := SetTelephone(Common.Member.MobileTel);
    edt_TelNo2.Text    := SetTelephone(Common.Member.HomeTel);
    edt_Address1.Text  := Common.Member.addr1;
    edt_Address2.Text  := Common.Member.addr2;
    RemarkMemo.Text    := Common.Member.Remark;

    //회원여부 체크
    OpenQuery('select TEL_ETC1, '
             +'       TEL_ETC2, '
             +'		    TEL_MOBILE	as NO_TEL1, '
             +'			  TEL_HOME	as NO_TEL2, '
             +'			  CD_LOCAL, '
             +'			  GetCommonName(:P0, ''22'', CD_LOCAL) as NM_LOCAL, '
             +'			  CD_COURSE, '
             +'			  GetCommonName(:P0, ''20'', CD_COURSE) as NM_COURSE, '
             +'       ADDR1, '
             +'       ADDR2, '
             +'       REMARK '
             +'	 from MS_MEMBER '
             +' where CD_STORE 	 =:P0 '
             +'   and CD_MEMBER  =:P1 '
             +'   and DS_STATUS  =''0'' ',
             [Common.Config.StoreCode,
              Common.Member.Code]);

    if not Common.Query.Eof then
    begin
      edt_TelNo3.Text         := SetTelephone(Common.Query.FieldByName('TEL_ETC1').AsString);
      edt_TelNo4.Text         := SetTelephone(Common.Query.FieldByName('TEL_ETC2').AsString);
      edt_TelNo1.Text         := SetTelephone(Common.Query.FieldByName('NO_TEL1').AsString);
      edt_TelNo2.Text         := SetTelephone(Common.Query.FieldByName('NO_TEL2').AsString);
      CourseButton.Caption    := Common.Query.FieldByName('NM_COURSE').AsString;
      CourseButton.Hint       := Common.Query.FieldByName('CD_COURSE').AsString;
      LocalButton.Caption     := Common.Query.FieldByName('NM_lOCAL').AsString;
      LocalButton.Hint        := Common.Query.FieldByName('CD_lOCAL').AsString;
      edt_Address1.Text       := Common.Query.FieldByName('ADDR1').AsString;
      edt_Address2.Text       := Common.Query.FieldByName('ADDR2').AsString;
      RemarkMemo.Text         := Common.Query.FieldByName('REMARK').AsString;
    end;
    Common.Query.Close;
    InitMemberRecord(Common.Member);
    SetDeliveryHistory(0);
  end;
end;

procedure TDeliveryInfo_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then CloseButton.Click;
  if (Key = VK_RETURN) then
  begin
    if edt_TelNo1.Focused and edt_TelNo1.EditModified then
    begin
      edt_TelNo1.Text := SetTelephone(edt_TelNo1.Text);
      SearchButtonClick(nil);
      edt_TelNo1.EditModified := False;
      SelectNext(TWinControl(ActiveControl), true,  true);
    end
    else if edt_TelNo1.Focused then
      SearchButtonClick(nil)
    else if not RequestRemarkMemo.Focused then
      SelectNext(TWinControl(ActiveControl), true,  true);
  end;

end;

procedure TDeliveryInfo_F.edt_CustNameEnter(Sender: TObject);
begin
  if (Sender is TcxTextEdit) then
    FFocusedEdit := (Sender as TcxTextEdit)
  else
    FFocusedEdit := (Sender as TcxMemo);
end;

procedure TDeliveryInfo_F.SetMemberCode(AValue: String);
begin
  FMemberCode := AValue;
  edt_TelNo2.Enabled := FMemberCode <> EmptyStr;
  edt_TelNo3.Enabled := FMemberCode <> EmptyStr;
  edt_TelNo4.Enabled := FMemberCode <> EmptyStr;
end;

procedure TDeliveryInfo_F.edt_TelNo2Exit(Sender: TObject);
begin
  (Sender as TcxTextEdit).Text := SetTelephone((Sender as TcxTextEdit).Text);
end;

procedure TDeliveryInfo_F.fmKeyPadDongButtonClick(Sender: TObject);
begin
  if (FFocusedEdit is TcxTextEdit) then
  begin
    TcxTextEdit(FFocusedEdit).Text := TcxTextEdit(FFocusedEdit).Text + (Sender as TAdvSmoothButton).Caption;
    TcxTextEdit(FFocusedEdit).SetFocus;
    TcxTextEdit(FFocusedEdit).SelStart := Length(TcxTextEdit(FFocusedEdit).Text)+1;
  end
  else if (FFocusedEdit is TcxMemo) then
  begin
    TcxMemo(FFocusedEdit).Text := TcxMemo(FFocusedEdit).Text + (Sender as TAdvSmoothButton).Caption;
    TcxMemo(FFocusedEdit).SetFocus;
    TcxMemo(FFocusedEdit).SelStart := Length(TcxMemo(FFocusedEdit).Text)+1;
  end;
end;

procedure TDeliveryInfo_F.KeyPadButtonClick(Sender: TObject);
begin
  fmKeyPad.Visible := not fmKeyPad.Visible;
  fmKeyPad.Top     := DeliveryInfoPanel.Top + KeyPadButton.Top;
  fmKeyPad.Left    := Order_sGrd.Left;
  if (FFocusedEdit is TcxTextEdit) then
    TcxTextEdit(FFocusedEdit).SetFocus
  else if (FFocusedEdit is TcxMemo) then
    TcxMemo(FFocusedEdit).SetFocus;
end;

procedure TDeliveryInfo_F.LocalButtonClick(Sender: TObject);
var vCode, vName :String;
begin
  if Common.ShowChooseForm('L','',vCode,vName) then
  begin
    LocalButton.Caption := vName;
    LocalButton.Hint    := vCode;
    edt_Address1.SetFocus;
    edt_Address1.SetSelection(Length(edt_Address1.Text),1);
  end
  else
  begin
    LocalButton.Caption := '';
    LocalButton.Hint    := '';
  end;
  Common.Table.Local := LocalButton.Caption;
end;

procedure TDeliveryInfo_F.FormResize(Sender: TObject);
begin
  SaleHistoryPanel.Top  := (Self.Height - SaleHistoryPanel.Height) div 2;
  SaleHistoryPanel.Left := (Self.Width  - SaleHistoryPanel.Width ) div 2;
end;

procedure TDeliveryInfo_F.Sale_sGrdDblClick(Sender: TObject);
begin
  if Sale_sGrd.Cells[4, Sale_sGrd.Row] = '' then Exit;

  SaleHistoryPanel.Visible   := true;
  DeliveryInfoPanel.Enabled  := false;
  CloseButton.Enabled         := false;
  FBeforStep                 := DeliveryStep;
  DeliveryStep               := dsHistory;
  OpenQuery('select m.NM_MENU, '
           +'       GetQty(s.DS_MENU_TYPE, s.QTY_SALE) as QTY_SALE, '
           +'       s.PR_SALE, '
           +'       s.AMT_SALE, '
           +'       s.SEQ, '
           +'       s.DS_SALE_TYPE, '
           +'       s.SEQ1 '
           +'  from ( '
           +'         select a.CD_STORE, '
           +'                b.CD_MENU, '
           +'                b.QTY_SALE, '
           +'                b.PR_SALE, '
           +'                b.AMT_SALE, '
           +'                b.DS_SALE_TYPE, '
           +'                b.SEQ, '
           +'                1 as SEQ1 '
           +'          from SL_SALE_H a inner join '
           +'               SL_SALE_D b on b.CD_STORE = a.CD_STORE '
           +'                          and b.YMD_SALE = a.YMD_SALE '
           +'                          and b.NO_POS   = a.NO_POS '
           +'                          and b.NO_RCP   = a.NO_RCP '
           +'         where a.CD_STORE    =:P0 '
           +'           and a.NO_DELIVERY =:P1 '
           +'         union all '
           +'         select a.CD_STORE, '
           +'                b.CD_MENU, '
           +'                b.QTY_SALE, '
           +'                0, '
           +'                0, '
           +'                '''', '
           +'                b.SEQ, '
           +'                2 as SEQ1 '
           +'          from SL_SALE_H a left outer join '
           +'               SL_SALE_S b on b.CD_STORE = a.CD_STORE '
           +'                          and b.YMD_SALE = a.YMD_SALE '
           +'                          and b.NO_POS   = a.NO_POS '
           +'                          and b.NO_RCP   = a.NO_RCP '
           +'         where a.CD_STORE    =:P0 '
           +'           and a.NO_DELIVERY =:P1 '
           +'       ) as s left outer join '
           +'       MS_MENU m on m.CD_STORE =s.CD_STORE and m.CD_MENU = s.CD_MENU '
           +' order by s.SEQ, s.SEQ1 ',
           [Common.Config.StoreCode,
            Sale_sGrd.Cells[4, Sale_sGrd.Row]]);
  SaleTableView.DataController.BeginUpdate;
  SaleTableView.DataController.RecordCount := 0;
  while not Common.Query.Eof do
  begin
    if Common.Query.FieldByName('SEQ1').AsString = '1' then
    begin
      SaleTableView.DataController.AppendRecord;
      SaleTableView.DataController.Values[SaleTableView.DataController.RecordCount-1, SaleTableViewSeq.Index]   := Common.Query.FieldByName('SEQ').AsString;
      SaleTableView.DataController.Values[SaleTableView.DataController.RecordCount-1, SaleTableViewMenu.Index]  := Common.Query.FieldByName('NM_MENU').AsString + Ifthen(Common.Query.FieldByName('DS_SALE_TYPE').AsString='D',Common.Config.ServiceTxt,'');
      SaleTableView.DataController.Values[SaleTableView.DataController.RecordCount-1, SaleTableViewQty.Index]   := Common.Query.FieldByName('QTY_SALE').AsString;
      SaleTableView.DataController.Values[SaleTableView.DataController.RecordCount-1, SaleTableViewPrice.Index] := Common.Query.FieldByName('PR_SALE').AsCurrency;
      SaleTableView.DataController.Values[SaleTableView.DataController.RecordCount-1, SaleTableViewAmt.Index]   := Common.Query.FieldByName('AMT_SALE').AsCurrency;
    end
    else if Common.Query.FieldByName('NM_MENU').AsString <> '' then
    begin
      SaleTableView.DataController.AppendRecord;
      SaleTableView.DataController.Values[SaleTableView.DataController.RecordCount-1, SaleTableViewSeq.Index]   := '-';
      SaleTableView.DataController.Values[SaleTableView.DataController.RecordCount-1, SaleTableViewMenu.Index]  := Common.Query.FieldByName('NM_MENU').AsString;
      SaleTableView.DataController.Values[SaleTableView.DataController.RecordCount-1, SaleTableViewQty.Index]   := Common.Query.FieldByName('QTY_SALE').AsString;
    end;
    Common.Query.Next;
  end;
  SaleTableView.DataController.EndUpdate;
  SaleRemarkMemo.Lines.Text := Sale_sGrd.Cells[5, Sale_sGrd.Row];

end;

procedure TDeliveryInfo_F.btnHistoryCloseClick(Sender: TObject);
begin
  SaleHistoryPanel.Visible   := false;
  CloseButton.Enabled         := true;
  DeliveryInfoPanel.Enabled  := true;
  DeliveryStep               := FBeforStep;
end;

end.
