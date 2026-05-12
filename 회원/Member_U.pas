unit Member_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, StdCtrls, MaskUtils, jpeg, DB,
  cxControls, cxContainer, cxEdit, cxLabel, cxTextEdit, cxMemo, StrUtils,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxCurrencyEdit, Menus, cxLookAndFeelPainters, cxButtons, IdTCPClient,
  cxLookAndFeels, KeyPad_F, AdvSmoothButton,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdTCPServer, IdContext,
  IdTCPConnection, DateUtils, AdvShape, AdvGlassButton, dxGDIPlusClasses,
  ToolPanels, Math, System.Bluetooth, System.Bluetooth.Components;

type
  TMember_F = class(TForm)
    sgr_Grid: TStringGrid;
    memRemark: TcxMemo;
    lblName: TcxLabel;
    lblClass: TcxLabel;
    lblCardNo: TcxLabel;
    lblTel: TcxLabel;
    lblVisit: TcxLabel;
    lblPoint: TcxLabel;
    lblAddr1: TcxLabel;
    lblJoinStore: TcxLabel;
    lblMemorial: TcxLabel;
    lblAddr2: TcxLabel;
    fmKeyPad: TfmKeyPad;
    panSale: TPanel;
    sgr_Sale: TStringGrid;
    meoMenu: TcxMemo;
    lblDamdang: TcxLabel;
    Tmr_Search: TTimer;
    GridTitleShape: TAdvShape;
    CaptionLabel: TLabel;
    CloseButton: TcxButton;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    cxLabel8: TcxLabel;
    SearchEdit: TcxTextEdit;
    PinPadButton: TAdvGlassButton;
    KeypadButton: TAdvGlassButton;
    MemberRemarkButton: TAdvGlassButton;
    SaleLogButton: TAdvGlassButton;
    ClearButton: TAdvGlassButton;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel7: TcxLabel;
    cxLabel9: TcxLabel;
    HideButton: TAdvGlassButton;
    HidePanel: TAdvToolPanel;
    Shape2: TShape;
    MemberAddButton: TAdvGlassButton;
    MemberEditButton: TAdvGlassButton;
    PointButton: TAdvGlassButton;
    TrustGetButton: TAdvGlassButton;
    MessageLabel: TLabel;
    Image3: TImage;
    OkButton: TAdvSmoothButton;
    SearchButton: TAdvSmoothButton;
    AdvSmoothButton1: TAdvSmoothButton;
    AdvSmoothButton2: TAdvSmoothButton;
    AdvSmoothButton3: TAdvSmoothButton;
    AdvSmoothButton4: TAdvSmoothButton;
    AdvSmoothButton5: TAdvSmoothButton;
    AdvSmoothButton6: TAdvSmoothButton;
    AdvSmoothButton7: TAdvSmoothButton;
    AdvSmoothButton8: TAdvSmoothButton;
    AdvSmoothButton9: TAdvSmoothButton;
    AdvSmoothButton10: TAdvSmoothButton;
    AdvSmoothButton11: TAdvSmoothButton;
    AdvSmoothButton12: TAdvSmoothButton;
    AdvSmoothButton13: TAdvSmoothButton;
    AdvSmoothButton14: TAdvSmoothButton;
    GridPriorButton: TAdvSmoothButton;
    GridNextButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure sgr_GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgr_GridClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure sgr_SaleClick(Sender: TObject);
    procedure sgr_SaleDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure MemberAddButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Tmr_SearchTimer(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure GridPriorButtonClick(Sender: TObject);
    procedure ChosungButtonClick(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure PinPadButtonClick(Sender: TObject);
    procedure KeypadButtonClick(Sender: TObject);
    procedure MemberEditButtonClick(Sender: TObject);
    procedure PointButtonClick(Sender: TObject);
    procedure SaleLogButtonClick(Sender: TObject);
    procedure MemberRemarkButtonClick(Sender: TObject);
    procedure TrustGetButtonClick(Sender: TObject);
    procedure HideButtonClick(Sender: TObject);
    procedure SearchEditKeyPress(Sender: TObject; var Key: Char);
    procedure ClearButtonClick(Sender: TObject);
  private
    FIsLocalSearch :Boolean;
    ClickTime :TDateTime;
    isPadSearch :Boolean;
    isPadShow   :Boolean;
    procedure ClearDisplayInfo;
    procedure TableKeyReadEvent(const S : String);
    procedure ScannerReadEvent(const S : String);
  public
    PhoneNo :String;
    procedure SelectMember(aKind,aIndex:Integer);
  end;

var
  Member_F: TMember_F;

implementation
uses GlobalFunc_U, Common_U, cxDropDownEdit,
  MemberPoint_U, MemberAdd_U, CashBookMem_U, Const_U, Order_U;
{$R *.dfm}

{ TForm2 }
procedure TMember_F.FormCreate(Sender: TObject);
var vIndex :Integer;
begin
  Width  := 1024;
  Height := 768;
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(GridTitleShape);
  Common.SetButtonColor(SearchButton);
  Common.SetButtonColor(OkButton);

  for vIndex := 0 to ComponentCount-1 do
  begin
    if Components[vIndex] is TAdvGlassButton then
      Common.SetButtonColor((Components[vIndex] as TAdvGlassButton));
    if Components[vIndex] is TAdvSmoothButton then
      Common.SetButtonColor((Components[vIndex] as TAdvSmoothButton));
  end;

  PinPadButton.Enabled := Common.Config.SmartPad;

  sgr_Grid.ColWidths[0]  := 50;   //번호
  sgr_Grid.ColWidths[1]  := 140;  //회원코드
  sgr_Grid.ColWidths[2]  := 200;  //회원명
  sgr_Grid.ColWidths[3]  := -1;   //성별
  sgr_Grid.ColWidths[4]  := -1;   //휴대폰
  sgr_Grid.ColWidths[5]  := -1;   //휴대폰
  sgr_Grid.ColWidths[6]  := -1;   //휴대폰
  sgr_Grid.ColWidths[7]  := -1;   //휴대폰
  sgr_Grid.ColWidths[8]  := -1;   //휴대폰
  sgr_Grid.ColWidths[9]  := 78;   //성별
  sgr_Grid.ColWidths[10] := -1;   //집전화

  sgr_Sale.ColWidths[0]  := 115;
  sgr_Sale.ColWidths[1]  := 80;
  sgr_Sale.ColWidths[2]  := 50;
  sgr_Sale.ColWidths[3]  := -1;

  //푸드기능을 사용하지 않으면 담당자를 보인다
  if GetOption(254) = '1' then
    meoMenu.Height := 152;
end;


procedure TMember_F.SelectMember(aKind,aIndex:Integer);
   function Get2Track(AValue:String):String;
   var I   :Integer;
   begin
      Result := '';
      For I:=1 to Length(AValue) do
      begin
         Case AValue[I] of
           #48..#57, #61: Result := Result + AValue[I];
         end;
      end;
   end;
const
  nChar :Array[1..14] of String =('가','나','다','라','마','바','사','아','자','차','카','타','파','하');
var vReSearch:Boolean;
label LocalSearch;
begin
  if isPadShow then
    Common.Device.SendToPad(#2+'member'+#2+#2);

  isPadShow := false;
  fmKeyPad.Visible := false;
  if Length(SearchEdit.Text) > 16 then
  begin
    if (SearchEdit.Text[1] = ';') or (SearchEdit.Text[1] = '?') or (SearchEdit.Text[1] = '#') then
    begin
      if Pos('=',SearchEdit.Text) > 0 then
        SearchEdit.Text    := Get2Track(Copy(SearchEdit.Text,2,Pos('=',SearchEdit.Text)-2))
      else
        SearchEdit.Text    := GetOnlyNumber(SearchEdit.Text);
    end
    else
    begin
      if Pos('=',SearchEdit.Text) > 0 then
        SearchEdit.Text  := Get2Track(Copy(SearchEdit.Text,1,Pos('=',SearchEdit.Text)-1))
      else
        SearchEdit.Text    := GetOnlyNumber(SearchEdit.Text);
    end;
  end
  else if (Length(SearchEdit.Text) > 0) and ((SearchEdit.Text[1] = ';') or (SearchEdit.Text[1] = '?') or (SearchEdit.Text[1] = '#')) then
  begin
    SearchEdit.Text := GetOnlyNumber(SearchEdit.Text);
  end;

  FIsLocalSearch := False;
  LocalSearch:
  vReSearch      := false;
  try
    Common.ShowWaitForm;
    OpenQuery('select a.CD_MEMBER, '
             +'       a.NM_MEMBER, '
             +'       a.DS_MEMBER as CD_CLASS, '
             +'       c.NM_CODE1  as DS_MEMBER, '
             +'       c.NM_CODE2  as DC_RATE, '
             +'       c.NM_CODE17 as DC_TYPE, '
             +'       case a.DS_SEX when ''0'' then ''남자'' else ''여자'' end GENDER, '
             +'       a.NO_CARD, '
             +'       a.TEL_MOBILE, '
             +'       a.TEL_HOME, '
             +'       Substring(a.YMD_BIRTH,5,4) as BIRTHDAY, '
             +'       a.YMD_BIRTH, '
             +'       a.YMD_MARRI, a.YMD_ISU, '
             +'       a.YMD_VISIT, a.CNT_VISIT, '
             +'       a.YN_TRUST, '
             +'       a.TOTAL_POINT, '
             +'       a.REMARK, '
             +'       a.ADDR1, '
             +'       a.ADDR2, '
             +'       a.NO_CASHRCP, '
             +'       a.YN_NEWS, '
             +'       a.NO_POST,  '
             +'       a.CD_DAMDANG, '
             +'       d.NM_SAWON, '
             +'       a.TOTAL_STAMP, '
             +'       a.AMT_TRUST, '
             +'       a.CD_AGE '
             +'  from MS_MEMBER a left outer join '
             +'       MS_CODE   c on a.CD_STORE = c.CD_STORE and a.DS_MEMBER  = c.CD_CODE and c.CD_KIND = ''05'' left outer join '
             +'       MS_SAWON  d on a.CD_STORE = d.CD_STORE and a.CD_DAMDANG = d.CD_SAWON '
             +' where a.CD_STORE   =:P0 '
             +'   and a.DS_STATUS  =''0'' '
             +'   and ( (a.CD_MEMBER = :P1 ) '
             +'      or (a.NM_MEMBER like :P2) '
             +'      or (a.NO_CARD      = :P3) '
             +'      or (a.CHOSUNG    like  :P4 ) '
             +'      or (a.TEL_MOBILE like :P5 ) '
             +'      or (a.TEL_HOME like  :P5 ) '
             +'      or (a.TEL_ETC1 like  :P5 ) '
             +'      or (a.TEL_ETC2 like  :P5 ) '
             +'      or (a.NO_CASHRCP like :P5 ))'
             +' order by a.NM_MEMBER ',
             [Common.Config.StoreCode,
              Copy(SearchEdit.Text,1,10),
              '%'+SearchEdit.Text+'%',
              SearchEdit.Text,
              SearchEdit.Text+'%',
              '%'+SearchEdit.Text]);

    Common.ClearGrid(sgr_Grid);
    if Common.Query.Eof then
    begin
      Common.Query.Close;
      ClearDisplayInfo;
      if aKind = 0 then
      begin
        Common.HideWaitForm;
        if Common.AskBox('조건에 맞는 회원이 없습니다'#13'신규회원으로 등록하시겠습니까?') then
        begin
          try
            Common.WriteLog('work', '회원등록');
            if Common.ShowMemberAddForm(SearchEdit.Text) then
              vReSearch := true;
          finally
            Common.Device.OnScannerReadData := ScannerReadEvent;
          end;
        end;
        SearchEdit.SelectAll;
        SearchEdit.SetFocus;
      end;
      Exit;
    end;

    with sgr_Grid, Common.Query do
    begin
      while not Common.Query.Eof do
      begin
        if Cells[0,0] <> '' then RowCount := RowCount + 1;

        Cells[0, RowCount-1] := IntToStr(RowCount);
        Cells[1, RowCount-1] := FieldByName('CD_MEMBER').AsString;
        Cells[2, RowCount-1] := FieldByName('NM_MEMBER').AsString;
        Cells[3, RowCount-1] := SetTelephone(FieldByName('TEL_MOBILE').AsString);
        if (FieldByName('TEL_MOBILE').AsString = '') and (FieldByName('TEL_HOME').AsString <> '') then
           Cells[3, RowCount-1] :=  SetTelephone(FieldByName('TEL_HOME').AsString);

        //전화번호 가운데 자리를 *로 표시한다
        if GetOption(297) = '1' then
          case Length(GetOnlyNumber(Cells[3, RowCount-1])) of
            10 : Cells[3, RowCount-1] := LeftStr(Cells[3, RowCount-1],3)+'-***-'+RightStr(Cells[3, RowCount-1],4);
            11 : Cells[3, RowCount-1] := LeftStr(Cells[3, RowCount-1],3)+'-****-'+RightStr(Cells[3, RowCount-1],4);
            12 : Cells[3, RowCount-1] := LeftStr(Cells[3, RowCount-1],4)+'-****-'+RightStr(Cells[3, RowCount-1],4);
          end;

        Cells[4, RowCount-1] := FormatMaskText('!0000년 90월 90일;0; ',FieldByName('YMD_VISIT').AsString) + '[' + FieldByName('cnt_visit').AsString + '회방문] ';
        if Trim(FieldByName('BIRTHDAY').AsString) <> '' then
          Cells[5, RowCount-1] := '생일 - '+FormatMaskText('!90월 90일;0; ',FieldByName('BIRTHDAY').AsString)+' ';
        if Trim(FieldByName('YMD_MARRI').AsString) <> '' then
          Cells[5, RowCount-1] := Cells[5, RowCount-1] +'('+FormatMaskText('!!0000년90월90일;0;',FieldByName('YMD_MARRI').AsString) +')';
        Cells[6, RowCount-1] := FieldByName('YN_TRUST').AsString;
        Cells[7, RowCount-1] := FieldByName('TOTAL_POINT').AsString;
        Cells[8, RowCount-1] := FieldByName('DS_MEMBER').AsString;
        Cells[9, RowCount-1] := FieldByName('GENDER').AsString;
        Cells[10,RowCount-1] := FieldByName('NO_CARD').AsString;
        Cells[11,RowCount-1] := FieldByName('DC_RATE').AsString;
        Cells[12,RowCount-1] := FormatMaskText('!0000년 90월 90일;0; ',FieldByName('YMD_ISU').AsString);
        Cells[13,RowCount-1] := FieldByName('REMARK').AsString;
        Cells[14,RowCount-1] := FormatFloat('#,0',StrToIntDef(FieldByName('TOTAL_POINT').AsString,0)) +'점, ';
        if FieldByName('YN_TRUST').AsString='Y' then
          Cells[14,RowCount-1] := Cells[14,RowCount-1] + '[외상가능]'
        else
          Cells[14,RowCount-1] := Cells[14,RowCount-1] + '[외상안됨]';

        Cells[15, RowCount-1] := SetTelephone(FieldByName('TEL_HOME').AsString);
        Cells[16, RowCount-1] := FieldByName('ADDR1').AsString;
        Cells[17, RowCount-1] := FieldByName('ADDR2').AsString;
        Cells[18, RowCount-1] := FieldByName('CD_CLASS').AsString;
        Cells[19, RowCount-1] := Common.Config.StoreName;
        Cells[20, RowCount-1] := FieldByName('DC_TYPE').AsString;
        Cells[21, RowCount-1] := FieldByName('NO_CASHRCP').AsString;
        Cells[22, RowCount-1] := SetTelephone(FieldByName('TEL_MOBILE').AsString);
        Cells[23, RowCount-1] := FieldByName('BIRTHDAY').AsString+ ' 가입일자['+FormatMaskText('!0000-90-90일;0; ',FieldByName('YMD_ISU').AsString)+']';
        Cells[24, RowCount-1] := FieldByName('YN_NEWS').AsString;
        Cells[25, RowCount-1] := FieldByName('AMT_TRUST').AsString;
        Cells[26, RowCount-1] := FieldByName('NO_POST').AsString;
        Cells[27, RowCount-1] := FieldByName('YMD_BIRTH').AsString;
        Cells[28, RowCount-1] := FieldByName('CD_DAMDANG').AsString;
        Cells[29, RowCount-1] := FieldByName('NM_SAWON').AsString;
        Cells[30, RowCount-1] := Common.Config.StoreCode;
        Cells[31, RowCount-1] := FieldByName('TOTAL_STAMP').AsString;
        Cells[32, RowCount-1] := FieldByName('CD_AGE').AsString;
        Next;
      end;
    end;
    Common.Query.Close;
  finally
    Common.HideWaitForm;
  end;

  if vReSearch then
    goto LocalSearch;

  sgr_GridClick(nil);
  if aKind = 0 then SearchEdit.Clear;
end;


procedure TMember_F.sgr_GridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var  vAlign : integer;
begin
  TStringGrid(Sender).Canvas.Font.Size := Common.Config.ListFontSize;;
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
    0,1,9 :  vAlign  := 1; //가운데
    2     :  vAlign  := 0;
  end;
  Common.Grid_Align(Sender, ACol, ARow, Rect, vAlign);
end;

procedure TMember_F.ChosungButtonClick(Sender: TObject);
const
  vChar :Array[1..14] of String =('ㄱ','ㄴ','ㄷ','ㄹ','ㅁ','ㅂ','ㅅ','ㅇ','ㅈ','ㅊ','ㅋ','ㅌ','ㅍ','ㅎ');
begin
  fmKeyPad.Visible := false;
  SearchEdit.Text := SearchEdit.Text + vChar[(Sender as TAdvSmoothButton).Tag];
  SearchEdit.SelStart := Length(SearchEdit.Text);
  if Length(SearchEdit.Text) >= 2 then
    SelectMember(1, (Sender as TAdvSmoothButton).Tag);
end;

procedure TMember_F.sgr_GridClick(Sender: TObject);
var vJpg    : TJPEGImage;
    vStream : TStream;
    vStampStr :String;
begin
  MemberEditButton.Visible  := False;
  PointButton.Visible := False;
  if (sgr_Grid.Cells[0,0] = '') then Exit;
  MemberEditButton.Visible  := True;
  PointButton.Visible    := True;
  TrustGetButton.Visible := true;
  with sgr_Grid do
  begin
    lblName.Caption      := Cells[2,  Row];
    if Cells[20, Row] = '1' then lblName.Caption := lblName.Caption;
    lblCardNo.Caption    := Cells[10, Row];
    lblClass.Caption     := Cells[8, Row];
    lblJoinStore.Caption := Cells[19, Row];
    lblTel.Caption       := Cells[3,  Row] + Ifthen(Cells[15, Row] <> '', '['+Cells[15, Row]+']');
    lblMemorial.Caption  := Cells[5,  Row];
    lblVisit.Caption     := Cells[4,  Row];

    if GetOption(292) = '0' then
    begin
      if GetOption(21)='0' then
        lblPoint.Caption     := Format('%s 잔액:%s',[Cells[14, Row], FormatFloat(',0원', StoI(Cells[25, Row]))])
      else
        lblPoint.Caption     := Format('%s 잔액:%d 스템프[%d]',[Cells[14, Row], StoI(Cells[25, Row]), StoI(Cells[31, Row])]);
    end
    else
    begin
      if GetOption(21)='0' then
        lblPoint.Caption     := Format('%s 충전잔액:%s',[Cells[14, Row], FormatFloat(',0원', StoI(Cells[25, Row])*-1)])
      else
        lblPoint.Caption     := Format('%s 충전잔액:%d 스템프[%d]',[Cells[14, Row], StoI(Cells[25, Row])*-1, StoI(Cells[31, Row])]);
    end;

    lblAddr1.Caption     := Cells[16, Row];
    lblAddr2.Caption     := Cells[17, Row];
    memRemark.Text       := Cells[13, Row];
    if Cells[29, Row] <> EmptyStr then
      lblClass.Caption     := lblClass.Caption + Format('[%s]',[ Cells[29, Row]]);
  end;
  Common.Query.Close;
  Common.ClearGrid(sgr_Sale);
  meoMenu.Clear;
  if panSale.Visible then
    SaleLogButtonClick(nil);
  //스마트패드에서 입력 후 조회 했을 때 패드에 회원정보를 표시해준다
  if isPadSearch and (sgr_Grid.RowCount=1) then
  begin
    //스템프 사용조건
    if GetOption(406)='1' then
      vStampStr := Format('%d 장에 %s 원 할인',[Common.Config.SetStampCount, FormatFloat(',0',Common.Config.SetStampDc)])
    else
    begin
      vStampStr := Common.GetIniFile('POS','스템프사용','');
      if vStampStr = '' then
        Common.SetIniFile('POS','스템프사용','');
    end;

    Common.Device.SendToPad(#2+'member'
                           +#2+sgr_Grid.Cells[2,  sgr_Grid.Row]
                           +#9+sgr_Grid.Cells[1,  sgr_Grid.Row]
                           +#9+sgr_Grid.Cells[8,  sgr_Grid.Row]
                           +#9+sgr_Grid.Cells[7,  sgr_Grid.Row]
                           +#9+sgr_Grid.Cells[31,  sgr_Grid.Row]
                           +#9+vStampStr
                           +#9+sgr_Grid.Cells[3,  sgr_Grid.Row]
                           +#9+sgr_Grid.Cells[24, sgr_Grid.Row]);
    isPadShow := true;
  end;
end;

procedure TMember_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F10    : SearchEdit.Clear;
    VK_UP     : GridPriorButtonClick(GridPriorButton);
    VK_DOWN   : GridPriorButtonClick(GridNextButton);
    VK_RETURN : if not SearchEdit.Focused then OkButtonClick(OkButton);
  end;
end;

procedure TMember_F.OkButtonClick(Sender: TObject);
begin
  if (sgr_Grid.Cells[0,0] = '') then
  begin
    if Common.Member.Code <> EmptyStr then
    begin
      InitMemberRecord(Common.Member);
      Common.PreSent.PointDc  := 0;
      Common.PreSent.UsePnt   := 0;
      Common.PreSent.OccurPnt := 0;
      ModalResult := mrOK;
      Exit;
    end
    else
    begin
      Common.MsgBox('조회된 내역이 없습니다');
      Exit;
    end;
  end;

  if Common.Member.Code <> sgr_Grid.Cells[1, sgr_Grid.Row] then
  begin
    InitMemberRecord(Common.Member);
    Common.PreSent.PointDc  := 0;
    Common.PreSent.UsePnt   := 0;
    Common.PreSent.OccurPnt := 0;
  end;

  Common.Member.Code        := sgr_Grid.Cells[1, sgr_Grid.Row];
  Common.Member.Name        := sgr_Grid.Cells[2, sgr_Grid.Row];
  Common.Member.MobileTel   := sgr_Grid.Cells[3, sgr_Grid.Row];
  Common.Member.HomeTel     := sgr_Grid.Cells[15, sgr_Grid.Row];
  Common.Member.dt_visit    := sgr_Grid.Cells[4, sgr_Grid.Row];
  Common.Member.yn_trust    := sgr_Grid.Cells[6, sgr_Grid.Row];
  Common.Member.Point       := StoI(sgr_Grid.Cells[7, sgr_Grid.Row]);
  Common.Member.nm_class    := sgr_Grid.Cells[8, sgr_Grid.Row];
  Common.Member.CardNo      := sgr_Grid.Cells[10, sgr_Grid.Row];
  Common.Member.dc_rate     := StoI(sgr_Grid.Cells[11, sgr_Grid.Row]);
  Common.Member.Remark      := sgr_Grid.Cells[13, sgr_Grid.Row];
  Common.Member.addr1       := sgr_Grid.Cells[16, sgr_Grid.Row];
  Common.Member.addr2       := sgr_Grid.Cells[17, sgr_Grid.Row];
  Common.Member.cd_class    := sgr_Grid.Cells[18, sgr_Grid.Row];
  Common.Member.no_cashrcp  := sgr_Grid.Cells[21, sgr_Grid.Row];
  Common.Member.MobileTelFull  := sgr_Grid.Cells[22, sgr_Grid.Row];
  Common.Member.DamdangCode := sgr_Grid.Cells[28, sgr_Grid.Row];
  Common.Member.DamdangName := sgr_Grid.Cells[29, sgr_Grid.Row];
  Common.Member.Stamp       := StoI(sgr_Grid.Cells[31, sgr_Grid.Row]);
  Common.Member.CreditAmt   := StoI(sgr_Grid.Cells[25, sgr_Grid.Row]);
  Common.Member.DcType      := sgr_Grid.Cells[20, sgr_Grid.Row];
  Common.Member.AgeCode     := sgr_Grid.Cells[32, sgr_Grid.Row];

  Common.WriteLog('work', Format('회원조회[%d, %d] - %s', [Common.Member.Point, Common.Member.CreditAmt, Common.Member.Code]));
  ModalResult := mrOK;
end;

procedure TMember_F.PinPadButtonClick(Sender: TObject);
begin
  if MilliSecondsBetween(Now(),ClickTime) < 500 then Exit;
  ClickTime := Now;

  if Common.Config.SmartPad then
  begin
    Common.PadWaitForm('고객이 전화번호를 입력 중 입니다...',
                       #2+'keypad'
                      +#2+'3'
                      +#2+'0'
                      +#2+'전화번호를 입력해주세요'
                      +#2+'0'
                      +#2+'60');
  end;
end;

procedure TMember_F.PointButtonClick(Sender: TObject);
begin
  try
    if GetUserOption(9) <> '1' then
    begin
      if GetOption(172) = '0' then
      begin
        Common.ErrBox('사용 권한이 없습니다');
        Exit;
      end
      else
      begin
        if not Common.CheckAuthority(9) then Exit;
      end;
    end;

    if Common.PreSent.PointDc > 0 then
    begin
      Common.ErrBox(Format('%s 할인 중에는 임의 사용을 할수 없습니다',[Ifthen(GetOption(21)='0','포인트','스템프')]));
      Exit;
    end;

    MemberPoint_F := TMemberPoint_F.Create(Application);
    try
      MemberPoint_F.lblCode.Caption   := sgr_Grid.Cells[1, sgr_Grid.Row];
      MemberPoint_F.lblName.Caption   := sgr_Grid.Cells[2, sgr_Grid.Row];
      MemberPoint_F.lblCardNo.Caption := lblCardNo.Caption;
      if GetOption(21) = '0' then
        MemberPoint_F.edtPoint.Value    := StrToIntDef(sgr_Grid.Cells[7, sgr_Grid.Row],0)
      else
        MemberPoint_F.edtPoint.Value    := StrToIntDef(sgr_Grid.Cells[31, sgr_Grid.Row],0);

      // 통합회원 사용시 적립 또는 사용을했으면 포인트를 다시 구한다
      if MemberPoint_F.ShowModal = mrOK then
      begin
        Close;
      end;
    finally
      FreeAndNil(MemberPoint_F);
    end;
  finally
    HidePanel.Visible := false;
  end;
end;

procedure TMember_F.FormShow(Sender: TObject);
begin
  sgr_Grid.DefaultRowHeight := Ifthen(Common.Config.ListRowHeight=0, 28, Common.Config.ListRowHeight);
  Common.ClearGrid(sgr_Grid);
  Common.ClearGrid(sgr_Sale);
  meoMenu.Clear;
  SearchEdit.Clear;
  HidePanel.Visible := false;
  if GetOption(21) = '1' then
    PointButton.Caption := Common.GetPapago('스템프적립/사용');
  ClearDisplayInfo;

  FIsLocalSearch := False;
  Common.Device.OnScannerReadData := ScannerReadEvent;
  if (GetOption(386) = '1') then
  begin
    fmKeyPad.Visible := false;
    KeypadButtonClick(nil);
  end;


  if PhoneNo <> EmptyStr then
  begin
    SearchEdit.Text := PhoneNo;
    PhoneNo        := EmptyStr;
    SelectMember(0,0);
    if sgr_Grid.Cells[0,0] <> '' then
      sgr_Grid.SetFocus;

    isPadSearch := false;
    //두번눌리는현상 방지
    ClickTime         := IncSecond(Now,-3);

  end
  else
  begin
    SearchEdit.SetFocus;
    isPadSearch := false;
    //두번눌리는현상 방지
    ClickTime         := IncSecond(Now,-3);
    if Common.Config.SmartPad then
    begin
      Tmr_Search.Tag     := 1;
      Tmr_Search.Enabled := true;
    end;
  end;
  Common.SetLanguage(Self);
end;

procedure TMember_F.GridPriorButtonClick(Sender: TObject);
begin
  if Sender = GridPriorButton then Common.RowPrev(sgr_Grid)
  else                             Common.RowNext(sgr_Grid);
end;

procedure TMember_F.HideButtonClick(Sender: TObject);
begin
  if HidePanel.Visible then
  begin
    HidePanel.Visible := false;
  end
  else
  begin
    HidePanel.Top     := 292;
    HidePanel.Left    := 457;
    HidePanel.Visible := true;
    SearchEdit.SetFocus;
  end;

end;

procedure TMember_F.KeypadButtonClick(Sender: TObject);
begin
  if fmKeyPad.Visible then
  begin
    fmKeyPad.Visible := false;
    SearchEdit.SetFocus;
  end
  else
  begin
    fmKeyPad.Top     := 270;
    fmKeyPad.Left    := 455;
    fmKeyPad.Visible := true;
    SearchEdit.SetFocus;
  end;
end;

procedure TMember_F.ClearButtonClick(Sender: TObject);
begin
  SearchEdit.Clear;
  SearchEdit.SetFocus;
end;

procedure TMember_F.ClearDisplayInfo;
begin
  lblName.Caption      := '';
  lblClass.Caption     := '';
  lblJoinStore.Caption := '';
  lblCardNo.Caption    := '';
  lblTel.Caption       := '';
  lblMemorial.Caption  := '';
  lblVisit.Caption     := '';
  lblPoint.Caption     := '';
  lblAddr1.Caption     := '';
  lblAddr2.Caption     := '';
  memRemark.Clear;
  MemberEditButton.Visible := False;
  PointButton.Visible      := False;
  TrustGetButton.Visible   := False;
end;

procedure TMember_F.CloseButtonClick(Sender: TObject);
var vIndex :Integer;
begin
  if Assigned(Order_F) then
  begin
    if (Common.Member.Code <> '') and Common.AskBox('회원판매를 취소하시겠습니까?') then
    begin
      InitMemberRecord(Common.Member);
      Common.Present.PointAmt := 0;
      Common.Present.PointDc  := 0;
      Common.Present.UsePnt   := 0;
      Common.Present.OccurPnt := 0;
      Common.PreSent.StampDc  := 0;
      for vIndex := 0 to Order_F.Main_sGrd.RowCount-1 do
      begin
        Order_F.Main_sGrd.Cells[GDM_DC_STAMP,  vIndex]  := '0';
        Order_F.Main_sGrd.Cells[GDM_USE_STAMP, vIndex]  := '0';
      end;
      for vIndex := 0 to Common.Summary_sGrd.RowCount-1 do
      begin
        Common.Summary_sGrd.Cells[GDM_DC_STAMP,  vIndex]  := '0';
        Common.Summary_sGrd.Cells[GDM_USE_STAMP, vIndex]  := '0';
      end;
    end;
  end;
  Close;
end;

procedure TMember_F.SearchButtonClick(Sender: TObject);
begin
  SelectMember(0,0);
  isPadSearch := false;
end;

procedure TMember_F.SearchEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key <> #13 then Exit;
  if sgr_Grid.Cells[0,0] = '' then
    SelectMember(0,0)
  else
    OkButtonClick(OkButton);
end;

procedure TMember_F.SaleLogButtonClick(Sender: TObject);
begin
  panSale.Visible := True;
  if sgr_Grid.Cells[0,0] = '' then Exit;
  //푸드기능을 사용하지 않을때는 담당자를 표시한다
  if (StrToInt(GetOption(14)) > 1) or (GetOption(259) = '1') or (GetOption(254) = '1') then
    OpenQuery('select StoDW(a.YMD_SALE), '
             +'       a.AMT_SALE, '
             +'       b.NM_SAWON, '
             +'       a.YMD_SALE '
             +'  from SL_SALE_H a left outer join '
             +'       MS_SAWON  b on b.CD_STORE = a.CD_STORE and b.CD_SAWON = a.CD_DAMDANG '
             +' where a.CD_STORE  = :P0 '
             +'   and a.DS_SALE  <> ''V'' '
             +'   and a.CD_MEMBER = :P1 '
             +' order by a.YMD_SALE desc '
             +' limit 10 ',
             [Common.Config.StoreCode,
              sgr_Grid.Cells[1, sgr_Grid.Row] ])
  else
    OpenQuery('select StoDW(YMD_SALE), '
             +'      Sum(AMT_SALE), '
             +'      ConCat(Cast(Count(NO_RCP) as Char),''회''), '
             +'      YMD_SALE '
             +'  from SL_SALE_H  '
             +' where CD_STORE  = :P0 '
             +'   and DS_SALE  <> ''V'' '
             +'   and CD_MEMBER = :P1 '
             +' group by YMD_SALE '
             +' order by YMD_SALE desc '
             +' limit 10 ',
             [Common.Config.StoreCode,
              sgr_Grid.Cells[1, sgr_Grid.Row] ]);
  Common.ClearGrid(sgr_Sale);
  meoMenu.Clear;
  while not Common.Query.Eof do
  begin
    if sgr_Sale.Cells[0,0] <> '' then sgr_Sale.RowCount := sgr_Sale.RowCount + 1;
    sgr_Sale.Cells[0, sgr_Sale.RowCount-1] := Common.Query.Fields[0].AsString;
    sgr_Sale.Cells[1, sgr_Sale.RowCount-1] := FormatFloat('#,0', Common.Query.Fields[1].AsInteger);
    sgr_Sale.Cells[2, sgr_Sale.RowCount-1] := Common.Query.Fields[2].AsString;
    sgr_Sale.Cells[3, sgr_Sale.RowCount-1] := Common.Query.Fields[3].AsString;
    Common.Query.Next;
  end;
  Common.Query.Close;
  sgr_SaleClick(nil);
end;

procedure TMember_F.sgr_SaleClick(Sender: TObject);
begin
  if sgr_Sale.Cells[0,0] = '' then Exit;
  OpenQuery('select c.DS_MENU_TYPE, '
           +'       c.NM_MENU, '
           +'       Sum(a.QTY_SALE) as QTY_SALE, '
           +'       d.NM_SAWON'
           +'  from SL_SALE_D a inner join '
           +'       SL_SALE_H b on a.CD_STORE   = b.CD_STORE '
           +'                  and a.YMD_SALE   = b.YMD_SALE '
           +'                  and a.NO_POS     = b.NO_POS '
           +'                  and a.NO_RCP     = b.NO_RCP inner join '
           +'       MS_MENU   c on a.CD_STORE   = c.CD_STORE '
           +'                  and a.CD_MENU    = c.CD_MENU left outer join '
           +'       MS_SAWON  d on b.CD_STORE   = d.CD_STORE '
           +'                  and b.CD_DAMDANG = d.CD_SAWON '
           +' where a.CD_STORE  =:P0 '
           +'   and b.CD_MEMBER =:P1 '
           +'   and a.YMD_SALE  =:P2 '
           +'   and b.DS_SALE <> ''V'' '
           +'group by c.DS_MENU_TYPE, c.NM_MENU, d.NM_SAWON ',
           [Common.Config.StoreCode,
            sgr_Grid.Cells[1, sgr_Grid.Row],
            sgr_Sale.Cells[3, sgr_Sale.Row] ]);
  meoMenu.Clear;
  lblDamdang.Clear;
  lblDamdang.Tag := 0;
  while not Common.Query.Eof do
  begin
    meoMenu.Lines.Add(Format('%s (%s)',[Common.Query.Fields[1].AsString,
                      Common.GetQtyReplace(Common.Query.Fields[0].AsString, Common.Query.Fields[2].AsString)]));
    if lblDamdang.Tag = 0 then
    begin
      lblDamdang.Caption := Common.Query.Fields[3].AsString;
      lblDamdang.Tag     := 1;
    end;
    Common.Query.Next;
  end;
end;

procedure TMember_F.sgr_SaleDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var  i_align : integer;
begin
  TStringGrid(Sender).Canvas.Font.Size := 12;
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
      0,2 :  i_align  := 1; //가운데
      1   :  i_align  := 2;
   end;
   Common.Grid_Align(Sender, ACol, ARow, Rect, i_align);
end;

procedure TMember_F.ScannerReadEvent(const S: String);
begin
  SearchEdit.Text := S;
  SelectMember(0,0);
  Common.Device.NFCData := '';
end;

procedure TMember_F.TrustGetButtonClick(Sender: TObject);
var vMember : TMember;
    vAmount,
    vSeq,
    vRow  : Integer;
    vAcctNo,
    vAcctCode : String;
begin
  try
    if Common.WorkState = wsAcct then
    begin
      Common.ErrBox('결제 중에는 사용 할 수 없습니다');
      Exit;
    end;

    if sgr_Grid.Cells[1, sgr_Grid.Row] = '' then
    begin
      Common.ErrBox('회원을 먼저 조회 해야합니다');
      Exit;
    end;

    vMember := Common.Member;
    Common.Member.Code      := sgr_Grid.Cells[1, sgr_Grid.Row];
    Common.Member.Name      := sgr_Grid.Cells[2, sgr_Grid.Row];
    Common.Member.CreditAmt := StoI(sgr_Grid.Cells[25, sgr_Grid.Row]);

    CashBookMem_F := TCashBookMem_F.Create(Application);
      try
        CashBookMem_F.Gubun := 'M';
        if CashBookMem_F.ShowModal = mrOK then
        begin
          vAmount := CashBookMem_F.GetAmtEdit.EditValue;
          // 마지막 순번을 구한다 (삭제 후 순번을 구하는 것이 좋으나 SQL의 버그 때문에 순번부터 구한다)
          OpenQuery('select Max(NO_ACCT) as NO_ACCT '
                   +'  from SL_ACCT '
                   +' where CD_STORE  = :P0 '
                   +'   and YMD_OCCUR = :P1 '
                   +'   and NO_POS    = :P2 ',
                    [Common.Config.StoreCode,
                     Common.WorkDate,
                     Common.Config.PosNo]);
          if (Common.Query.Eof) or (Common.Query.Fields[0].AsString = EmptyStr) then
            vSeq := 0
          else
            vSeq := StoI(Common.Query.Fields[0].AsString);
          Common.Query.Close;
          vAcctNo := FormatFloat('000', vSeq+1);

          OpenQuery('select Min(CD_CODE) as CD_CODE '
                   +'  from MS_CODE '
                   +' where CD_STORE  = :P0 '
                   +'   and CD_KIND   = ''11'' '
                   +'   and NM_CODE3  = ''2'' '
                   +'   and DS_STATUS = ''0'' ',
                   [Common.Config.StoreCode]);
          if (Common.Query.Eof) or (Common.Query.Fields[0].AsString = EmptyStr) then
          begin
            Common.ErrBox('출납코드에 회원외상 결제코드가 없습니다');
            Exit
          end
          else
            vAcctCode := Common.Query.Fields[0].AsString;
          Common.Query.Close;

          try
            Common.BeginTran;
            ExecQuery('insert into SL_ACCT(CD_STORE, '
                     +'                    YMD_OCCUR, '
                     +'                    NO_POS, '
                     +'                    NO_ACCT, '
                     +'                    DS_ACCT, '
                     +'                    CD_ACCT, '
                     +'                    CD_MEMBER, '
                     +'                    AMT_PAYIN, '
                     +'                    AMT_OUT, '
                     +'                    CD_SAWON_CHG, '
                     +'                    DT_INSERT, '
                     +'                    DT_CHANGE)'
                     +'           values (:P0, '
                     +'                   :P1, '
                     +'                   :P2, '
                     +'                   :P3, '
                     +'                   :P4, '
                     +'                   :P5, '
                     +'                   :P6, '
                     +'                   :P7, '
                     +'                   0, '
                     +'                   :P8, '
                     +'                   Now(), '
                     +'                   Now())',
                     [Common.Config.StoreCode,
                      Common.WorkDate,
                      Common.Config.PosNo,
                      vAcctNo,
                      Ifthen(Common.Card_SGrd.Cells[0,0]='', '0', '1'),
                      vAcctCode,
                      Common.Member.Code,
                      vAmount,
                      Common.Config.UserCode]);
            //신용카드승인내역 저장
            if Common.Card_SGrd.Cells[0,0] <> '' then
            begin
               For vRow := 0 to Common.Card_sGrd.RowCount -1 do
               begin
                  With Common.Card_SGrd, Common do
                  begin
                     if Cells[GDC_YN_SAVE,vRow] = 'Y' then
                     begin
                        if not CardDataSave(Common.WorkDate,'A', vAcctNo, vRow) then
                          raise Exception.Create('신용카드 저장 중 에러');
                     end;
                  end; //With Card_SGrd, Common, ADO_Sale_Card do
               end; //For I:= 0...
               Common.GetCardLog;
            end; //if PreSent.CardAmt <> 0 then

            ExecQuery('update MS_MEMBER '
                     +'   set AMT_TRUST = AMT_TRUST - :P2 '
                     +' where CD_STORE  =:P0 '
                     +'   and CD_MEMBER =:P1 ',
                     [Common.Config.StoreCode,
                      Common.Member.Code,
                      vAmount]);

            sgr_Grid.Cells[25, sgr_Grid.Row] := IntToStr(StoI(sgr_Grid.Cells[25, sgr_Grid.Row]) - vAmount);
            Common.CommitTran;
            Common.Device.MemberTrustReceivePrint(vAmount);
            Common.MsgBox('외상결제가 정상 저장되었습니다');
          except
            on E: Exception do
            begin
              Common.WriteLog('Member001',E.Message);
              Common.RollbackTran;
              Common.ErrBox(E.Message);
            end;
          end;
        end;
      finally
        FreeAndNil(CashBookMem_F);
        InitCardRecord(Common.Card);
        Common.Member := vMember;
        Common.PreSent.CardAmt := 0;
        if Assigned(Order_F) then
          Order_F.DisplayPresent;
      end;
  finally
    HidePanel.Visible := false;
  end;
end;

procedure TMember_F.MemberAddButtonClick(Sender: TObject);
begin
  try
    Common.WriteLog('work', '회원등록');
    Common.ShowMemberAddForm;
  finally
    Common.Device.OnScannerReadData := ScannerReadEvent;

    HidePanel.Visible := false;

    SearchEdit.SetFocus;
  end;
end;

procedure TMember_F.MemberEditButtonClick(Sender: TObject);
var vIndex : Integer;
    vTemp  : String;
begin
  MemberAdd_F := TMemberAdd_F.Create(Self);
  MemberAdd_F.IsNew := false;
  MemberAdd_F.JoinStore            := sgr_Grid.Cells[30, sgr_Grid.Row];
  MemberAdd_F.MemberCodeLabel.Caption := sgr_Grid.Cells[1, sgr_Grid.Row];
  MemberAdd_F.MemberNameEdit.Text  := sgr_Grid.Cells[2, sgr_Grid.Row];
  MemberAdd_F.chkGender.Checked    := sgr_Grid.Cells[9, sgr_Grid.Row] = '남자';
  MemberAdd_F.MemberClassComboBox.ItemIndex := GetStrPointerIndex(MemberAdd_F.MemberClassComboBox, sgr_Grid.Cells[18, sgr_Grid.Row]);
  MemberAdd_F.CardNoEdit.Text      := lblCardNo.Caption;
  MemberAdd_F.MobileEdit.Text      := sgr_Grid.Cells[22, sgr_Grid.Row];
  MemberAdd_F.HomeTelEdit.Text        := sgr_Grid.Cells[15, sgr_Grid.Row];
  MemberAdd_F.chkTrust.Checked     := sgr_Grid.Cells[6,  sgr_Grid.Row] = 'Y';
  MemberAdd_F.chkSMS.Checked       := sgr_Grid.Cells[24, sgr_Grid.Row] = 'Y';
  MemberAdd_F.chklunar.Checked     := sgr_Grid.Cells[25, sgr_Grid.Row] = 'Y';
  MemberAdd_F.RemarkMemo.Text      := memRemark.Text;
  MemberAdd_F.PostButton.Hint      := sgr_Grid.Cells[26, sgr_Grid.Row];
  MemberAdd_F.edt_Addr1.Text       := lblAddr1.Caption;
  MemberAdd_F.edt_Addr2.Text       := lblAddr2.Caption;
  MemberAdd_F.edt_Birthday.Text    := GetOnlyNumber(sgr_Grid.Cells[27, sgr_Grid.Row]);
  MemberAdd_F.edt_CashRcpNo.Text   := sgr_Grid.Cells[21, sgr_Grid.Row];
  try
    if MemberAdd_F.ShowModal = mrOK then
    begin
      sgr_Grid.Cells[2, sgr_Grid.Row]  := MemberAdd_F.MemberNameEdit.Text;
      sgr_Grid.Cells[8, sgr_Grid.Row]  := Copy(MemberAdd_F.MemberClassComboBox.Text,7,Length(MemberAdd_F.MemberClassComboBox.Text)-6);
      sgr_Grid.Cells[10, sgr_Grid.Row] := MemberAdd_F.CardNoEdit.Text;
      if GetOption(297) = '1' then
      begin
        vTemp := GetOnlyNumber(MemberAdd_F.MobileEdit.Text);
        case Length(vTemp) of
          10 : vTemp := LeftStr(vTemp,3)+'-***-'+RightStr(vTemp,4);
          11 : vTemp := LeftStr(vTemp,3)+'-****-'+RightStr(vTemp,4);
          else vTemp := SetTelephone(vTemp);
        end;
        sgr_Grid.Cells[3,  sgr_Grid.Row] := vTemp;
      end
      else
        sgr_Grid.Cells[3,  sgr_Grid.Row] := MemberAdd_F.MobileEdit.Text;
      sgr_Grid.Cells[22, sgr_Grid.Row] := MemberAdd_F.MobileEdit.Text;
      sgr_Grid.Cells[15, sgr_Grid.Row] := MemberAdd_F.HomeTelEdit.Text;
      sgr_Grid.Cells[9,  sgr_Grid.Row] := IfThen(MemberAdd_F.chkGender.Checked, '남자', '여자');
      sgr_Grid.Cells[16, sgr_Grid.Row] := MemberAdd_F.edt_Addr1.Text;
      sgr_Grid.Cells[17, sgr_Grid.Row] := MemberAdd_F.edt_Addr2.Text;
      sgr_Grid.Cells[18, sgr_Grid.Row] := GetStrPointerData(MemberAdd_F.MemberClassComboBox);
      sgr_Grid.Cells[13, sgr_Grid.Row] := MemberAdd_F.RemarkMemo.Text;
      sgr_Grid.Cells[6,  sgr_Grid.Row] := Ifthen(MemberAdd_F.chkTrust.Checked, 'Y','N');
      sgr_Grid.Cells[21, sgr_Grid.Row] := MemberAdd_F.edt_CashRcpNo.Text;
      sgr_GridClick(nil);
    end;
  finally
    MemberAdd_F.IsNew := true;
    FreeAndNil(MemberAdd_F);
    HidePanel.Visible := false;
  end;
end;

procedure TMember_F.MemberRemarkButtonClick(Sender: TObject);
begin
  panSale.Visible := False;
  if sgr_Grid.Cells[0,0] = '' then Exit;
  memRemark.Text  := sgr_Grid.Cells[13, sgr_Grid.Row];
end;

procedure TMember_F.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if isPadShow then
    Common.Device.SendToPad(#2+'member'+#2+'3'+#2);
end;

procedure TMember_F.TableKeyReadEvent(const S: String);
begin
  //회원프리픽스하고 같으면
  if Common.isMemberCardNo(S) then
  begin
    SearchEdit.Text := S;
    SelectMember(0,0);
  end;
end;

procedure TMember_F.Tmr_SearchTimer(Sender: TObject);
begin
  Tmr_Search.Enabled := false;
  if Tmr_Search.Tag = 0 then
  begin
    isPadSearch        := true;
    SearchButtonClick(nil);
  end
  else
  begin
    Tmr_Search.Tag := 0;
    PinPadButtonClick(nil);
  end;
end;

end.




