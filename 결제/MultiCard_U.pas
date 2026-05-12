{*
  다중사업자 VAN
  NICE, KIS, JTNET
*}
unit MultiCard_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit, cxLabel,
  dxGDIPlusClasses, Vcl.ExtCtrls, AdvGlassButton, Vcl.Grids, AdvShape,
  Vcl.StdCtrls, cxButtons, POSCard, StrUtils, DateUtils, AdvSmoothToggleButton, IniFiles,
  AdvSmoothButton, cxTextEdit, cxCurrencyEdit;

type
  TMultiCard_F = class(TForm)
    CloseButton: TcxButton;
    TitleLabel: TLabel;
    AdvShape1: TAdvShape;
    Van_sGrd: TStringGrid;
    Image3: TImage;
    lbl_Msg: TLabel;
    ApprovalButton: TAdvSmoothButton;
    cxLabel2: TcxLabel;
    ApprovalAmtEdit: TcxCurrencyEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Van_sGrdDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ApprovalButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure EasyPayButtonClick(Sender: TObject);
  private
    ErrMsg         :String;
    FUnionPass     :String;
    FisCatFallBack :Boolean;   //JTNET 카드이벤트에서 FallBack 발생시
    RequestSaleAmt :Integer;
    ClickTime      :TDateTime;
    ReUseSignFile  :String;    //서명 한번에 할때를 위해 저장해 놓는다
    function  ApprovalAction(aIndex:Integer):Boolean;
  public
    { Public declarations }
  end;

var
  MultiCard_F: TMultiCard_F;

implementation
uses Common_U, GlobalFunc_U, Const_U, Order_U, CardHalbu_U;

{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TMultiCard_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
//  Common.SetButtonColor(EasyPayButton);
  Common.SetButtonColor(AdvShape1);
  Common.SetButtonColor(ApprovalButton);
  with Van_sGrd do
  begin
     ColCount     := 6;
     ColWidths[0] := 220;
     ColWidths[1] := 90;
     ColWidths[2] := 160;
     ColWidths[3] := -1;
     ColWidths[4] := -1;
     ColWidths[5] := -1;   //SignData
  end;
  ClickTime := IncSecond(Now(), -2);
//  if (Common.Config.van_trd in [vanKoces, vanJtnet, vanKis]) or ((Common.Config.van_trd = vanKSNET) and (Common.Config.VanEasyPay = 'T')) then
//  begin
//    EasyPayButton.Visible := false;
//    ApprovalButton.Left   := Self.Width div 2 - ApprovalButton.Width div 2;
//  end;

  ReUseSignFile := '';
end;

procedure TMultiCard_F.FormShow(Sender: TObject);
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
    Van_sGrd.Cells[4,   Van_sGrd.RowCount-1] := '';
    Van_sGrd.Cells[5,   Van_sGrd.RowCount-1] := '';
    Common.Corner[vIndex].RowIndex           := Van_sGrd.RowCount-1;
    vTotAmt := vTotAmt + Common.Corner[vIndex].SaleAmt;
  end;
  ApprovalAmtEdit.Value := vTotAmt;
  BlockInput(false);
  Common.SetLanguage(Self);
end;


procedure TMultiCard_F.Van_sGrdDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var  vAlign:Integer;
begin
  TStringGrid(Sender).Canvas.Font.Size := 17;
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

function TMultiCard_F.ApprovalAction(aIndex:Integer): Boolean;
  function GetSignReUse:Boolean;
  var vIndex : Integer;
  begin
    Result := false;
    for vIndex := 0 to Van_sGrd.RowCount-1 do
    begin
      if (Van_sGrd.Cells[2,   vIndex] = '승인완료' ) and (StoI(Van_sGrd.Cells[1, vIndex]) > 50000) and (Van_sGrd.Cells[5,   vIndex] <> '' ) then
      begin
        Result := true;
        Break;
      end;
    end;
  end;
begin
  Result := False;
  with Common.ICCard do
  begin
    FocusHandle := Self.Handle;
    SvcAmt     := 0;
    Approval   := Common.Card.Ds_trd   = dtApproval;

    SaleDate   := FormatDateTime('yyyymmdd',Now());

    PosNo      := Common.Config.PosNo;
    CatPort    := StoI(Common.Config.ReceiptPrinterPort);
    if Common.Config.ReceiptPrinterBaudRate >=0 then
      CatBaudRate   := BAUDRATE[Common.Config.ReceiptPrinterBaudRate]
    else
      CatBaudRate   := 9600;
    Parent     := Self;

    if (VAN = vtSmartro) and (FUnionPass <> EmptyStr) then
    begin
      UnionPay := True;
    end;

    if Common.Config.ReceiptPrinterBaudRate >=0 then
      CatBaudRate   := BAUDRATE[Common.Config.ReceiptPrinterBaudRate]
    else
      CatBaudRate   := 9600;

    RealMode   := True;
    Approval   := Common.Card.Ds_trd   = dtApproval;
    if (GetOption(379) = '1') or (not Approval and (Common.Card.YN_CAT='Y')) then
      AppType := atCatCard
    else if GetOption(379) = '2' then
      AppType := atVCatCard
    else
      AppType    := atCard;

    KeyIn      := Common.Card.Type_Trd = '2';
    CardTrack2 := Common.Card.CardNoFull;

    LogPath    := Common.AppPath;
    Valid      := Common.Card.Valid;

    //Nice 가상단말기 사용시
    if Approval and (AppType = atVCatCard) and (VAN in [vtNice, vtJTNET]) then
    begin
      if Common.PreSent.CardAmt > 0 then
        SignReUse := GetSignReUse
      else
        SignReUse := false;
      if (Common.PreSent.CardAmt = 0) and (SaleAmt > 50000) then
        TotAmt := Common.PreSent.WRcvAmt
      else
        TotAmt := 0;
    end
    else if Approval and (AppType = atVCatCard) and (VAN = vtKIS) then
    begin
      if Common.PreSent.CardAmt > 0 then
        SignReUse := GetSignReUse
      else
        SignReUse := false;

      if SignReUse then
        CopyFile(PWideChar(ReUseSignFile), PWideChar(Common.AppPath+'sign.bmp'), false)
      else
        DeleteFile(ReUseSignFile);
    end;


    //취소시
    if not Approval then
    begin
      OrgAgreeNo  := Common.Card.OrgApprovalNo;
      OrgSaleDate := Common.Card.Trd_Date_Org;
    end;

    //Cat 단말기 연동시
    if AppType = atCatCard then
    begin
      Common.Device.SetPrintPort(false);
      Common.HideWaitForm;
      if FisCatFallBack then
        Common.ShowWaitForm('IC카드 리딩오류! MS로 읽혀주세요')
      else
        Common.ShowWaitForm('단말기에서 승인 중 입니다....'#13'(단말기 종료버튼을 누르면 취소됩니다)');
      FisCatFallBack := false;
      Common.WriteLog('work', Format('[카드]단말기 승인요청 - %d(%d)',[Common.ICCard.SaleAmt, Common.ICCard.VatAmt]));
      RequestSaleAmt := Common.ICCard.SaleAmt;
    end;

    //VCat 단말기 연동시
    if AppType = atVCatCard then
    begin
      Common.WriteLog('WriteLog', Format('[카드]가상켓 승인요청 - %d(%d)',[Common.ICCard.SaleAmt, Common.ICCard.VatAmt]));
      RequestSaleAmt := Common.ICCard.SaleAmt;
    end;

    Common.ICCard.MultiVan   := true;
    Common.ICCard.EasyPay    := ApprovalButton.Hint = 'M';

    Common.Device.SetPrintPort(false);
    if not Execute then
    begin
      Common.HideWaitForm;
      Common.Device.SetPrintPort(true);
      if AppType = atCatCard then
        Common.WriteLog('work', Format('[카드]승인실패 - %s',[Note]))
      else if AppType = atVCatCard then
        Common.WriteLog('work', Format('[카드]가상켓 승인실패 - %s',[Common.ICCard.Note]));

      lbl_Msg.Caption := Note;
      Result := False;
    end
    else
    begin
      Sleep(100);
      Application.ProcessMessages;
      Common.Device.SetPrintPort(true);
      if AppType = atCatCard then
      begin
        Common.WriteLog('work', Format('[카드]단말기 정상승인 - 카드번호[%s]승인번호[%s]승인금액[%d]',[Common.ICCard.CardNo, Common.ICCard.AgreeNo, Common.ICCard.AgreeAmt]));
        if RequestSaleAmt <> Common.ICCard.SaleAmt then
        begin
          Common.ErrBox(Format('포스에서 승인요청금액(%d)과'#13'단말기에서 실제 승인금액(%d)이 다릅니다'#13#13'반드시 관리대리점 확인바랍니다',[RequestSaleAmt, Common.ICCard.SaleAmt]));
        end;

        Common.Card.CardNo := CardNo;
        Common.HideWaitForm;
      end;

      if Approval and (AppType = atVCatCard) and (VAN = vtKIS) then
      begin
        if ImgFileName <> '' then
        begin
          CopyFile(PWideChar(ImgFileName), PWideChar(Common.AppPath+'reusesign.bmp'), false);
          ReUseSignFile := Common.AppPath+'reusesign.bmp';
        end;
      end;


      if (VAN=vtJTNET) and (not Approval) then
      else

      Common.Card.Ds_Card       := Ifthen(CardType='','C',CardType);
      Common.Card.CardNo        := Common.ICCard.CardNo;
      Common.Card.RealMode      := True;
      Common.Card.cd_buy        := CompCode;           // 매입사코드
      Common.Card.nm_buy        := CompName;           // 매입사이름
      Common.Card.Nm_Card       := BalgupsaName;       // 발급사이름
      Common.Card.ApprovalNo    := AgreeNo;            // 승인번호
      Common.Card.Halbu         := FormatFloat('00',Common.ICCard.HalbuMonth); // 할부개월
      Common.Card.Amt           := AgreeAmt;           // 승인금액
      Common.Card.DcAmt         := AgreeDcAmt;         // 할인금액
      Common.Card.TipAmt        := 0;                  // 봉사료금액
      Common.Card.VatAmt        := VatAmt;
      Common.Card.ChainPL       := KamaengNo;          // 가맹점번호
      Common.Card.Trd_Date      := AgreeDate;          // 승인일자
      Common.Card.Trd_Time      := AgreeTime;          // 승인시간
      Common.Card.ImgFile       := ImgFileName;        // 전자서명화일명
      Common.Card.BalanceAmt    := BalanceAmt;
      Common.Card.Yn_UnionPay   := 'N';
      Common.Card.YN_CAT        := YnCat;
      Common.Card.VanTID        := TerminalID;
      Common.Card.TransNo       := TransNo;
      Common.Card.PayCode       := PayCode;
      Common.Card.EasyPayNo     := EasyPayNo;
      Common.Card.DsDc          := DsDiscount;
      //토스일때
      if LeftStr(Common.Card.CardNo,7) = '7055000' then
        Common.Card.Nm_Card := '토스페이';

      Van_sGrd.Cells[2, Common.Corner[aIndex].RowIndex] := '승인완료';
      Van_sGrd.Cells[5, Common.Corner[aIndex].RowIndex] := ImgFileName;
      Common.WriteLog('work', Format('카드승인완료(승인번호%s 승인금액 %d)',[AgreeNo, AgreeAmt]));

      //카드봉사료
      Common.PreSent.TipAmt     := Common.PreSent.TipAmt +  Common.Card.TipAmt;
      Self.ErrMsg               := Note;
      Result := True;

      Common.CardInfoSave;
      Common.PreSent.CardAmt := Common.PreSent.CardAmt + Common.Card.Amt;
    end;
  end;
end;

procedure TMultiCard_F.ApprovalButtonClick(Sender: TObject);
var vIndex, vIndex2, vCount, vHalbu  :Integer;
    visHalbu :Boolean;
    vSignData :String;
begin
  if (GetOption(379) = atCat) and (Common.Config.ReceiptPrinterDev = 0) then
  begin
    Common.MsgBox('프린터가 설정되지 않았습니다');
    Exit;
  end;

  vCount     := 0;
  visHalbu   := false;
  vSignData  := '';
  for vIndex := 0 to Van_sGrd.RowCount-1 do
  begin
    if Van_sGrd.Cells[2, vIndex] = '승인대기' then
    begin
      vIndex2  := Common.GetCornerIndex(Van_sGrd.Cells[3, vIndex],'');
      if Common.Corner[vIndex2].SaleAmt > 50000 then
        visHalbu := true;
      Inc(vCount);
    end;
  end;

  if vCount = 0 then
  begin
    ModalResult := mrOK;
    Exit;
  end;

  if MilliSecondsBetween(Now(),ClickTime) < 1500 then Exit;
  ClickTime := now;

    //오만원이상은 할부개월 입력
  vHalbu := 0;
  if (Common.Card.Ds_trd = dtApproval) and visHalbu then
  begin
    Common.HideWaitForm;
    with TCardHalbu_F.Create(Self) do
    try
      ShowModal;
      vHalbu := Common.ICCard.HalbuMonth;
    finally
      Free;
    end;
  end;

  try
    ApprovalButton.Enabled := false;
    for vIndex := 0 to Van_sGrd.RowCount-1 do
    begin
      if Van_sGrd.Cells[2, vIndex] <> '승인대기' then Continue;
      with Common.ICCard do
      begin
        ClearAll;
        UnionPay   := false;
        Common.PreSent.CardSeq := Common.PreSent.CardSeq +1;
        vIndex2                := Common.GetCornerIndex(Van_sGrd.Cells[3, vIndex],'');
        Common.Card.Corner     := Common.Corner[vIndex2].Code;
        TerminalID             := Common.Corner[vIndex2].VanTID;
        BizNo                  := GetOnlyNumber(Common.Corner[vIndex].BizNo);
        SerialNo               := Common.Corner[vIndex2].VanSerial;
        SaleAmt                := Common.Corner[vIndex2].SaleAmt;
        VatAmt                 := Common.Corner[vIndex2].TaxAmt;
        if SaleAmt > 50000 then
          Common.ICCard.HalbuMonth := vHalbu
        else
          Common.ICCard.HalbuMonth := 0;

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
      lbl_Msg.Caption := '';
      Application.ProcessMessages;
      Common.WriteLog('work', Format('카드승인요청(TID-%s 금액 %d)',[Common.Corner[vIndex2].VanTid, Common.Corner[vIndex2].SaleAmt]));
      if not ApprovalAction(vIndex2) then
        Break;
    end;
    if Assigned(Order_F) and Order_F.Showing then
      Order_F.DisplayPresent;
    if Common.PreSent.WRcvAmt = 0 then
      ModalResult := mrOK;
  finally
    Common.HideWaitForm;
    ApprovalButton.Enabled := true;
  end;
end;

procedure TMultiCard_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TMultiCard_F.EasyPayButtonClick(Sender: TObject);
begin
  try
    ApprovalButton.Hint := 'M';
    ApprovalButtonClick(ApprovalButton);
  finally
    ApprovalButton.Hint := '';
  end;
end;

end.


