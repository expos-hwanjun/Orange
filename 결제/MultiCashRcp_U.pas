unit MultiCashRcp_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit, cxLabel,
  dxGDIPlusClasses, Vcl.ExtCtrls, AdvGlassButton, Vcl.Grids, AdvShape,
  Vcl.StdCtrls, cxButtons, PosCard, StrUtils, MaskUtils, AdvGlowButton,
  cxTextEdit, KeyPad_F, Math, DateUtils, AdvSmoothToggleButton, AdvSmoothButton;

type
  TMultiCashRcp_F = class(TForm)
    CloseButton: TcxButton;
    Label1: TLabel;
    AdvShape1: TAdvShape;
    Van_sGrd: TStringGrid;
    Image3: TImage;
    MessageLabel: TLabel;
    cxLabel3: TcxLabel;
    TotalAmtLabel: TcxLabel;
    fmKeyPad1: TfmKeyPad;
    NumberEdit: TcxTextEdit;
    PersonButton: TAdvSmoothToggleButton;
    BizButton: TAdvSmoothToggleButton;
    ApprovalButton: TAdvSmoothButton;
    InitButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Van_sGrdDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ApprovalButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure InitButtonClick(Sender: TObject);
    procedure NumberEditKeyPress(Sender: TObject; var Key: Char);
    procedure fmKeyPad1Num_00Click(Sender: TObject);
    procedure PersonButtonClick(Sender: TObject);
  private
    isPinPad       :Boolean;
    MsrData        :String;
    ErrMsg         :String;
    FUnionPass     :String;
    FisCatFallBack :Boolean;   //JTNET 카드이벤트에서 FallBack 발생시
    RequestSaleAmt :Integer;
    ClickTime      :TDateTime;
    function  ApprovalAction(aIndex:Integer):Boolean;
    procedure NumberSplit;
  public
    { Public declarations }
  end;

var
  MultiCashRcp_F: TMultiCashRcp_F;

implementation
uses Common_U, GlobalFunc_U, Const_U, Order_U;

{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TMultiCashRcp_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(InitButton);
  Common.SetButtonColor(ApprovalButton);
  Common.SetButtonColor(AdvShape1);
  with Van_sGrd do
  begin
    ColCount     := 5;
    ColWidths[0] := 200;
    ColWidths[1] := 95;
    ColWidths[2] := 80;
    ColWidths[3] := -1;
    ColWidths[4] := -1;
  end;
  ClickTime := IncSecond(Now(), -2);
end;

procedure TMultiCashRcp_F.FormShow(Sender: TObject);
var vIndex  :Integer;
    vTotAmt :Integer;
begin
  Common.SetCornerAmt;
  vTotAmt := 0;
  Common.ClearGrid(Van_sGrd);
  for vIndex := 0 to High(Common.Corner) do
  begin
    if Common.Corner[vIndex].SaleAmt = 0 then Continue;
    if Van_sGrd.Cells[0,0] <> '' then
      Van_sGrd.RowCount :=  Van_sGrd.RowCount + 1;
    Van_sGrd.Cells[0,   Van_sGrd.RowCount-1] := Common.Corner[vIndex].Name;
    Van_sGrd.Cells[1,   Van_sGrd.RowCount-1] := IntToStr(Common.Corner[vIndex].SaleAmt);
    Van_sGrd.Cells[2,   Van_sGrd.RowCount-1] := '승인대기';
    Van_sGrd.Cells[3,   Van_sGrd.RowCount-1] := Common.Corner[vIndex].Code;
    Common.Corner[vIndex].RowIndex              := Van_sGrd.RowCount-1;
    vTotAmt := vTotAmt + Common.Corner[vIndex].SaleAmt;
  end;
  TotalAmtLabel.Caption := FormatFloat(',0',vTotAmt);
  PersonButtonClick(PersonButton);
  Common.CashRcp.Ds_Input       := 'K';
  Common.SetLanguage(Self);
  NumberEdit.SetFocus;
end;

procedure TMultiCashRcp_F.InitButtonClick(Sender: TObject);
begin
  Common.CashRcp.CardNoFull := EmptyStr;
  Common.CashRcp.CardNo     := EmptyStr;

  NumberEdit.Clear;
  MessageLabel.Caption := '';
  NumberEdit.SetFocus;

  //NICE 가상단말기 일때
  if (Sender <> nil) and (GetOption(153)='2') and (Common.Config.van_trd = vanNICE) then
    Common.ICCard.CancelNiceVCat;
end;

procedure TMultiCashRcp_F.NumberEditKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then ApprovalButtonClick(nil);
end;

procedure TMultiCashRcp_F.NumberSplit;
begin
  NumberEdit.Text := GetOnlyNumber(NumberEdit.Text);
  case Length(NumberEdit.Text) of
    10 :
    begin
      if PersonButton.Appearance.SimpleLayout then
      begin
        NumberEdit.Text := FormatMaskText('!000-000-0000;0;', NumberEdit.Text);
        Common.CashRcp.Ds_Type := '1';
      end
      else
      begin
        if Copy(NumberEdit.Text,1,1) <> '0' then
        begin
          NumberEdit.Text := FormatMaskText('!000-00-00000;0;', NumberEdit.Text);
          Common.CashRcp.Ds_Type := '3';
        end
        else
        begin
          NumberEdit.Text := FormatMaskText('!000-000-0000;0;', NumberEdit.Text);
          Common.CashRcp.Ds_Type := '1';
        end;
      end;
    end;
    11 :
    begin
      NumberEdit.Text := FormatMaskText('!000-0000-0000;0;', NumberEdit.Text);
      Common.CashRcp.Ds_Type := '1';
    end;
    13 :
    begin
      NumberEdit.Text := FormatMaskText('!000000-0000000;0;', NumberEdit.Text);
      Common.CashRcp.Ds_Type := '2';
    end;
    16 :
    begin
      NumberEdit.Text := FormatMaskText('!0000-0000-0000-0000;0;', NumberEdit.Text);
      Common.CashRcp.Ds_Type := '0';
    end;
    18 :
    begin
      NumberEdit.Text := FormatMaskText('!0000-0000-0000-000000;0;', NumberEdit.Text);
      Common.CashRcp.Ds_Type := '0';
    end;
    else Common.CashRcp.Ds_Type := '0';
  end;
end;

procedure TMultiCashRcp_F.PersonButtonClick(Sender: TObject);
begin
  if Sender = PersonButton then
  begin
    PersonButton.Appearance.SimpleLayout := true;
    PersonButton.Status.Visible          := true;
    BizButton.Appearance.SimpleLayout    := false;
    BizButton.Status.Visible             := false;
    PersonButton.Color := $00DF7000;
    BizButton.Color  := $00793D00;
  end
  else
  begin
    PersonButton.Appearance.SimpleLayout := false;
    PersonButton.Status.Visible          := false;
    BizButton.Appearance.SimpleLayout    := true;
    BizButton.Status.Visible             := true;
    PersonButton.Color := $00793D00;
    BizButton.Color  := $00DF7000;
  end;
  NumberEdit.SetFocus;
end;

procedure TMultiCashRcp_F.Van_sGrdDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var  vAlign:Integer;
begin
  TStringGrid(Sender).Canvas.Font.Size := 15;
  TStringGrid(Sender).Canvas.Font.Color  := clBlack;
  TStringGrid(Sender).Canvas.Brush.Color := clWhite;

  case Acol of
    0 : vAlign := 0; //좌측
    2 : vAlign := 1; //가운데
    1 : vAlign := 2; //우측정렬
  end;
  Common.Grid_Align(Sender, aCol, aRow, Rect, vAlign);
  //    숫자형 출력시 Format 형식   //
  case ACol of
    1: Common.Grid_DisplayFormat(Sender, aCol, aRow, Rect);
  end;
end;

function TMultiCashRcp_F.ApprovalAction(aIndex:Integer): Boolean;
var vDsInput,
    vCardNoFull :String;
begin
  with Common.ICCard, Common do
  begin
    FocusHandle := Self.Handle;
    case Config.van_trd of
      0 : VAN    := vtKOCES;
      1 : VAN    := vtDaou;
      2 : VAN    := vtNICE;
      3 : VAN    := vtKICC;
      4 : VAN    := vtKIS;
      5 : VAN    := vtKSNET;
      6 : VAN    := vtKCP;
      7 : VAN    := vtFDIK;
      8 : VAN    := vtJTNET;
      9 : VAN    := vtKFTC;
     10 : VAN    := vtSmartro;
     11 : VAN    := vtKOVAN;
     12 : VAN    := vtSPC;
    end;

    Approval   := CashRcp.Ds_trd = dtApproval;
    SaleDate   := FormatDateTime('yyyymmdd',Now());
    PosNo      := Common.Config.PosNo;
    CatPort    := StoI(Common.Config.ReceiptPrinterPort);

    Parent     := Self;
    if Common.Config.ReceiptPrinterBaudRate >=0 then
      CatBaudRate   := BAUDRATE[Common.Config.ReceiptPrinterBaudRate]
    else
      CatBaudRate   := 9600;

    RealMode   := True;
    Approval   := CashRcp.Ds_trd     = dtApproval;
    if (GetOption(379) = '1') and ((Trim(NumberEdit.Text) = '') or (VAN in [vtKOVAN, vtKIS, vtKFTC])) then
      AppType := atCatCash
    else if (GetOption(379) = '2') and ((Trim(NumberEdit.Text) = '') or (VAN in [vtKSNET,vtKOCES,vtJTNET,vtKOVAN,vtNICE,vtDaou,vtFDIK,vtKCP])) then
      AppType := atVCatCash
    else
      AppType    := atCash;

    if Trim(NumberEdit.Text) = '' then
      CashRcp.Ds_Input          := 'S'
    else
      CashRcp.CardNoFull := NumberEdit.Text;

    KeyIn      := CashRcp.Ds_Input   = 'K';
    if VAN = vtKCP then KeyIn := True;
    if PersonButton.Appearance.SimpleLayout then CashRcp.Ds_Kind := '0'
    else                                         CashRcp.Ds_Kind := '1';

    HalbuMonth := StoI(CashRcp.Ds_Kind);
    CardTrack2 := Common.CashRcp.CardNoFull;
    if isPinPad then
      CardTrack2 := 'PinPad';

    if not Approval then
    begin
      OrgAgreeNo    := Common.CashRcp.No_Approval;
      OrgSaleDate   := Common.CashRcp.trd_date;
      if VAN <> vtKIS then
        CardTrack2    := EmptyStr;
    end
    else
    begin
      OrgAgreeNo    := '';
      OrgSaleDate   := '';
    end;

    //KCP는 번호만 받는다
    if VAN = vtKCP then
      CardTrack2 := CtoC(NumberEdit.Text,'-','');
    LogPath    := Common.AppPath;

    if AppType = atCatCash then
      Common.WriteLog('work', Format('[현금]승인요청 - %d',[SaleAmt]));

    MultiVan                 := true;

    if not Execute then
    begin
      Common.HideWaitForm;
      if AppType = atCatCash then
        Common.WriteLog('work', Format('[현금]승인실패 - %s',[Note]));

      if (GetOption(379)='0') and (VAN = vtKFTC) then
      begin
        Sleep(500);
        Common.ICCard.AppType := atICInit;
        Common.ICCard.Execute;
      end;
      ErrMsg := Note;
      Common.ErrBox(Note);
      Result := False;
    end
    else
    begin
      if AppType in [atCatCash, atVCatCash] then
      begin
        Common.WriteLog('work', Format('[현금]정상승인 - 카드번호[%s]승인번호[%s]승인금액[%d]',[CardNo, AgreeNo, AgreeAmt]));
        Common.ICCard.CardNo   := CardNo;
        if (CardTrack2 = EmptyStr) and (Common.ICCard.CardNo <> GetOnlyNumber(NumberEdit.Text)) then
          CashRcp.Ds_Input := 'S'
        else
          CashRcp.Ds_Input := 'K';

       if (Common.Config.van_trd in [vanFDIK,vanKCP]) and (Common.ICCard.CardNo = '') then
       begin
         Common.CashRcp.Ds_Type := '1';
         Common.ICCard.CardNo   := CardTrack2;
       end;

        if VAN = vtKOVAN then
          Sleep(1000);

        Common.HideWaitForm;
      end
      else if ((GetOption(379)='0')) and (Common.Config.van_trd in [vanSmartro, vanKIS, vanJTNET]) then
      begin
        NumberEdit.Text  := Common.ICCard.CardNo;
        if Pos('*',Common.ICCard.CardNo) > 0 then
          CashRcp.Ds_Input := 'S';

        if not Approval and (Common.ICCard.CardNo = '') then
        begin
          Common.HideWaitForm;
          ErrMsg := '식별번호 오류 다시 시도하세요';
          Result := False;
          Exit;
        end;
      end
      else if ((GetOption(379)='0')) and (Common.Config.van_trd = vanKFTC) then
      begin
        NumberEdit.Text        := CardTrack2;
        Common.CashRcp.Ds_Type := '1';
        Common.ICCard.CardNo   := CardTrack2;
      end;

      CashRcp.CardNo        := CardNo;
      CashRcp.No_Approval   := AgreeNo;        // 승인번호
      CashRcp.Amt_Approval  := AgreeAmt;       // 승인금액
      CashRcp.VatAmt        := VatAmt;
      CashRcp.trd_date      := SaleDate;
      CashRcp.VanTID        := TerminalID;
      Van_sGrd.Cells[2, Common.Corner[aIndex].RowIndex] := '승인완료';
      Common.WriteLog('work', Format('현금영수증 승인완료(승인번호%s 승인금액 %d)',[AgreeNo, AgreeAmt]));

      Common.PreSent.CashAmt    := Common.PreSent.CashAmt   + CashRcp.Amt_Approval;
      Common.PreSent.CashRcpAmt := Common.PreSent.CashRcpAmt + CashRcp.Amt_Approval;
      vDsInput    := Common.CashRcp.Ds_Input;
      vCardNoFull := Common.CashRcp.CardNoFull;
      Common.CashRcpInfoSave;
      Common.CashRcp.Ds_Input   := vDsInput;
      Common.CashRcp.CardNoFull := vCardNoFull;
      Common.HideWaitForm;
      Result := True;
      if ((GetOption(379)='0')) and (Common.Config.van_trd = vanKFTC) then
      begin
        Common.ICCard.AppType := atICInit;
        Common.ICCard.Execute;
      end;

    end;
  end;
end;

procedure TMultiCashRcp_F.ApprovalButtonClick(Sender: TObject);
var vIndex, vIndex2, vCount :Integer;
begin
  if (GetOption(379) = '1') and (Common.Config.ReceiptPrinterDev = 0) then
  begin
    Common.MsgBox('프린터가 설정되지 않았습니다');
    Exit;
  end;

  vCount := 0;
  for vIndex := 0 to Van_sGrd.RowCount-1 do
  begin
    if Van_sGrd.Cells[2, vIndex] = '승인대기' then
      Inc(vCount);
  end;

  if vCount = 0 then
  begin
    ModalResult := mrOK;
    Exit;
  end;

  if MilliSecondsBetween(Now(),ClickTime) < 1500 then Exit;
  ClickTime := now;
  if GetOnlyNumber(NumberEdit.Text) = '' then
    Common.ShowWaitForm('카드를 읽혀 주세요', True);

  try
    if GetOption(379)='1' then
      Common.Device.SetPrintPort(false)
    else if GetOnlyNumber(NumberEdit.Text) = '' then
    begin
      Common.CashRcp.Ds_Input       := 'S';
      Common.ShowWaitForm('카드를 읽혀 주세요', True);
    end
    else
    begin
      Common.CashRcp.Ds_Input       := 'K';
      Common.ShowWaitForm('승인요청 중 입니다 ... ');
    end;

    if (Common.Config.van_trd = vanKIS) and (GetOption(379)='0') then
      Common.Device.SetPrintPort(false);

    ApprovalButton.Enabled := false;
    for vIndex := 0 to Van_sGrd.RowCount-1 do
    begin
      if Van_sGrd.Cells[2, vIndex] <> '승인대기' then Continue;
      with Common.ICCard do
      begin
        ClearAll;
        UnionPay   := false;
        Common.PreSent.CashSeq := Common.PreSent.CashSeq +1;
        vIndex2    := Common.GetCornerIndex(Van_sGrd.Cells[3, vIndex],'');
        Common.CashRcp.Corner := Common.Corner[vIndex2].Code;
        TerminalID := Common.Corner[vIndex2].VanTID;
        BizNo      := GetOnlyNumber(Common.Corner[vIndex].BizNo);
        SerialNo   := Common.Corner[vIndex2].VanSerial;
        SaleAmt    := Common.Corner[vIndex2].SaleAmt;
        VatAmt     := Common.Corner[vIndex2].TaxAmt;

        case Common.Config.van_trd of
          0 : VAN    := vtKOCES;
          1 : VAN    := vtDaou;
          2 : VAN    := vtNICE;
          3 : VAN    := vtKICC;
          4 : VAN    := vtKIS;
          5 : VAN    := vtKSNET;
          6 : VAN    := vtKCP;
          7 : VAN    := vtFDIK;
          8 : VAN    := vtJTNET;
          9 : VAN    := vtKFTC;
         10 : VAN    := vtSmartro;
         11 : VAN    := vtKOVAN;
         12 : VAN    := vtSPC;
        end;
      end;
      MessageLabel.Caption := '';
      Application.ProcessMessages;
      Common.WriteLog('work', Format('현금영수증 승인요청(TID-%s 금액 %d)',[Common.Corner[vIndex2].VanTid, Common.Corner[vIndex2].SaleAmt]));
      if not ApprovalAction(vIndex2) then
        Break;
    end;
    if Assigned(Order_F) and Order_F.Showing then Order_F.DisplayPresent;
    if Common.PreSent.WRcvAmt = 0 then
      ModalResult := mrOK;
  finally
    ApprovalButton.Enabled := true;
    if (Common.Config.van_trd = vanKIS) and (GetOption(379)='0') then
      Common.Device.SetPrintPort(true);
  end;
end;

procedure TMultiCashRcp_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TMultiCashRcp_F.fmKeyPad1Num_00Click(Sender: TObject);
begin
  NumberEdit.Text := NumberEdit.Text + '010';
  NumberEdit.SetFocus;
  NumberEdit.SelStart := Length(NumberEdit.Text);
end;

end.




