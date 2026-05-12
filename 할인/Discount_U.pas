unit Discount_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, Mask,
  DB, GraphicEx, jpeg, KeyPad_F, dxNavBarBase,
  dxNavBarCollns, dxNavBar, ActnList, System.Actions, AdvSmoothButton,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxButtons;

type
  TDiscountType = (dtMenuAmt, dtMenuPersent, dtAllAmt, dtAllPersent,
                   dtEvent, dtCode, dtPriceChg, dtTip);

type
  TDiscount_F = class(TForm)
    ActionList: TActionList;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action5: TAction;
    Action6: TAction;
    Action7: TAction;
    Action8: TAction;
    TitleLabel: TLabel;
    CloseButton: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure Action8Execute(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
  private
    DcButton      :Array of TAdvSmoothButton;
    CodeButton    :Array of TAdvSmoothButton;
    FInData :String;
    FDiscountType :TDiscountType;
    procedure  DcButtonClick(Sender: TObject);
    procedure  CodeButtonClick(Sender: TObject);
    function   CheckDcMenu:Boolean;
    procedure  ApplyDiscount;
    function   Summary_Row:Integer;
    procedure  SetDiscountType(AValue:TDiscountType);
    property DiscountType: TDiscountType read FDiscountType write SetDiscountType;
  public
    { Public declarations }
  end;

var
  Discount_F: TDiscount_F;

implementation
uses Common_U, GlobalFunc_U, Order_U, Const_U;
{$R *.dfm}

procedure TDiscount_F.FormCreate(Sender: TObject);
var vButtonCount, vIndex, vIndex1, vCount1, vCount2 :Integer;
    vTemp :String;
begin
  ClientWidth := Common.Config.PluClassWidth + 100;
  ClientHeight:= Common.Config.PosHeight;
  Common.LogoCreate(Self,2);
  vButtonCount := 0;
  For vIndex := 85 to 94 do
    if GetOption(vIndex) = '1' then Inc(vButtonCount);

  SetLength(DcButton, vButtonCount);

  vIndex1 := -1;
  vTemp := Copy(Common.Config.Options,85,8);

  For vIndex:= 1 to Length(vTemp) do
  begin
    if vTemp[vIndex] = '1' then
    begin
      Inc(vIndex1);
      DcButton[vIndex1]              := TAdvSmoothButton.Create(self);
      DcButton[vIndex1].Parent       := Self;
      DcButton[vIndex1].Top          := 60 + ((vIndex1)*78);
      DcButton[vIndex1].Left         := 18;
      DcButton[vIndex1].Height       := 69;
      DcButton[vIndex1].Width        := (Self.Width - 150) div 2;
      DcButton[vIndex1].Caption      := TAction(ActionList[vIndex-1]).Caption;
      DcButton[vIndex1].Tag          := TAction(ActionList[vIndex-1]).Index;
      DcButton[vIndex1].Color        := $00804000;
      DcButton[vIndex1].Shadow       := true;
      DcButton[vIndex1].TabStop      := false;
      DcButton[vIndex1].Cursor       := crHandPoint;
      DcButton[vIndex1].Appearance.Font.Name    := '맑은 고딕';
      DcButton[vIndex1].Appearance.Font.Size    := 18;
      DcButton[vIndex1].Appearance.Font.Color   := clWhite;
      DcButton[vIndex1].Appearance.Font.Style   := [fsBold];
      DcButton[vIndex1].Appearance.Rounding     := 5;
      DcButton[vIndex1].Appearance.SimpleLayout := true;
      DcButton[vIndex1].OnClick      := DcButtonClick;
      DcButton[vIndex1].Name         := 'obtn_Dc'+IntToStr(vIndex1);
      Common.SetButtonColor(DcButton[vIndex1]);
    end;
  end;


  OpenQuery('select CD_CODE, '
           +'       NM_CODE1, '
           +'       NM_CODE2, '
           +'       NM_CODE3, '
           +'       NM_CODE4, '
           +'       NM_CODE5, '
           +'       NM_CODE6, '
           +'       NM_CODE7 '
           +'  from MS_CODE '
           +' where CD_STORE  =:P0 '
           +'   and CD_KIND   =''07''  '
           +'   and DS_STATUS = 0 '
           +' order by CD_CODE '
           +' limit 8 ',
           [Common.Config.StoreCode]);
  vButtonCount := 0;
  while not Common.Query.Eof do
  begin
    Inc(vButtonCount);
    Common.Query.Next;
  end;

  SetLength(CodeButton, vButtonCount+2);
  vIndex  := 0;
  vCount1 := 0;
  vCount2 := 0;
  Common.Query.First;
  while not Common.Query.Eof do
  begin
    CodeButton[vIndex]              := TAdvSmoothButton.Create(self);
    CodeButton[vIndex].Parent       := Self;
    CodeButton[vIndex].Top          := 60 + ((vIndex)*78);
    CodeButton[vIndex].Left         := (Self.Width - 150) div 2 + 36 ;
    CodeButton[vIndex].Height       := 69;
    CodeButton[vIndex].Width        := (Self.Width - 150) div 2;
    CodeButton[vIndex].OnClick      := CodeButtonClick;
    CodeButton[vIndex].Name         := 'obtn_Code'+IntToStr(vIndex);
    CodeButton[vIndex].Color        := $00804000;
    CodeButton[vIndex].Shadow       := true;
    CodeButton[vIndex].TabStop      := false;
    CodeButton[vIndex].Cursor       := crHandPoint;
    CodeButton[vIndex].Appearance.Font.Name    := '맑은 고딕';
    CodeButton[vIndex].Appearance.Font.Size    := 18;
    CodeButton[vIndex].Appearance.Font.Color   := clWhite;
    CodeButton[vIndex].Appearance.Font.Style   := [fsBold];
    CodeButton[vIndex].Appearance.Rounding     := 5;
    CodeButton[vIndex].Appearance.SimpleLayout := true;
    CodeButton[vIndex].Caption      := Common.GetPaPago(Common.Query.FieldByName('nm_code1').AsString);  //할인명
    CodeButton[vIndex].HelpKeyword  := Common.Query.FieldByName('nm_code1').AsString;  //할인명
    CodeButton[vIndex].Hint         := '|'+Common.Query.FieldByName('cd_code').AsString         //할인코드
                                      +'|'+Common.Query.FieldByName('nm_code2').AsString         //할인구분(0:할인율, 1:금액, 2:메뉴분류)
                                      +'|'+Common.Query.FieldByName('nm_code3').AsString         //할인율
                                      +'|'+Common.Query.FieldByName('nm_code4').AsString         //기준금액
                                      +'|'+Common.Query.FieldByName('nm_code5').AsString         //할인금액
                                      +'|'+Common.Query.FieldByName('nm_code6').AsString         //할인금액
                                      +'|'+Common.Query.FieldByName('nm_code7').AsString+'|';    //지정메뉴

    if Common.Query.FieldByName('nm_code7').AsString = '1' then
    begin
      CodeButton[vIndex].Status.Caption := '선택메뉴';
      CodeButton[vIndex].Status.Visible := true;
      CodeButton[vIndex].Status.Appearance.Fill.Color := clBlue;
      CodeButton[vIndex].Status.Appearance.Font.Color := clWhite;
      CodeButton[vIndex].Status.Appearance.Font.Size  := 11;
      Inc(vCount2);
    end
    else if Common.Query.FieldByName('nm_code7').AsString = '2' then
    begin
      CodeButton[vIndex].Status.Caption := '전메뉴';
      CodeButton[vIndex].Status.Visible := true;
      CodeButton[vIndex].Status.Appearance.Fill.Color := clRed;
      CodeButton[vIndex].Status.Appearance.Font.Color := clWhite;
      CodeButton[vIndex].Status.Appearance.Font.Size  := 11;
      Inc(vCount2);
    end
    else
      Inc(vCount1);
    Common.Query.Next;
    Inc(vIndex);
  end;
  Common.Query.Close;

  // 할인코드가 있으면 할인취소 버튼을 만든다
  if vCount1 > 0 then
  begin
    CodeButton[vIndex]              := TAdvSmoothButton.Create(self);
    CodeButton[vIndex].Parent       := Self;
    CodeButton[vIndex].Top          := 60 + ((vIndex)*78);
    CodeButton[vIndex].Left         := (Self.Width - 150) div 2 + 36;
    CodeButton[vIndex].Height       := 69;
    CodeButton[vIndex].Width        := (Self.Width - 150) div 2;
    CodeButton[vIndex].OnClick      := CodeButtonClick;
    CodeButton[vIndex].Name         := 'obtn_dccancel';
    CodeButton[vIndex].Color        := $00804000;
    CodeButton[vIndex].Shadow       := true;
    CodeButton[vIndex].TabStop      := false;
    CodeButton[vIndex].Cursor       := crHandPoint;
    CodeButton[vIndex].Appearance.Font.Name    := '맑은 고딕';
    CodeButton[vIndex].Appearance.Font.Size    := 18;
    CodeButton[vIndex].Appearance.Font.Color   := clWhite;
    CodeButton[vIndex].Appearance.Font.Style   := [fsBold];
    CodeButton[vIndex].Appearance.Rounding     := 5;
    CodeButton[vIndex].Appearance.SimpleLayout := true;
    CodeButton[vIndex].Caption      := '할인취소';
    CodeButton[vIndex].Hint         := '|할인취소|';
    CodeButton[vIndex].Status.Caption := '지정할인';
    CodeButton[vIndex].Status.Visible := true;
    CodeButton[vIndex].Status.Appearance.Fill.Color := clRed;
    CodeButton[vIndex].Status.Appearance.Font.Color := clWhite;
    CodeButton[vIndex].Status.Appearance.Font.Size  := 11;
  end;

  if vCount2 > 0 then
  begin
    CodeButton[vIndex]              := TAdvSmoothButton.Create(self);
    CodeButton[vIndex].Parent       := Self;
    CodeButton[vIndex].Top          := 60 + ((vIndex)*78);
    CodeButton[vIndex].Left         := (Self.Width - 150) div 2 + 36;
    CodeButton[vIndex].Height       := 69;
    CodeButton[vIndex].Width        := (Self.Width - 150) div 2;
    CodeButton[vIndex].OnClick      := CodeButtonClick;
    CodeButton[vIndex].Name         := 'obtn_dccancel';
    CodeButton[vIndex].Color        := $00804000;
    CodeButton[vIndex].Shadow       := true;
    CodeButton[vIndex].TabStop      := false;
    CodeButton[vIndex].Cursor       := crHandPoint;
    CodeButton[vIndex].Appearance.Font.Name    := '맑은 고딕';
    CodeButton[vIndex].Appearance.Font.Size    := 18;
    CodeButton[vIndex].Appearance.Font.Color   := clWhite;
    CodeButton[vIndex].Appearance.Font.Style   := [fsBold];
    CodeButton[vIndex].Appearance.Rounding     := 5;
    CodeButton[vIndex].Appearance.SimpleLayout := true;
    CodeButton[vIndex].Caption      := '할인취소';
    CodeButton[vIndex].Hint         := '|할인취소|';
    CodeButton[vIndex].Status.Caption := '전메뉴';
    CodeButton[vIndex].Status.Visible := true;
    CodeButton[vIndex].Status.Appearance.Fill.Color := clRed;
    CodeButton[vIndex].Status.Appearance.Font.Color := clWhite;
    CodeButton[vIndex].Status.Appearance.Font.Size  := 11;
  end;

  for vIndex := 0 to ComponentCount-1 do
    if Components[vIndex] is TAdvSmoothButton then
      Common.SetButtonColor((Components[vIndex] as TAdvSmoothButton));

end;


procedure TDiscount_F.SetDiscountType(AValue: TDiscountType);
begin
  FDiscountType := AValue;
  ApplyDiscount;
end;

procedure TDiscount_F.ApplyDiscount;
   //메인그리드의 상품에 단품할인금액 보이기
   procedure GridApply(AValue:String);
   var nRow :Integer;
   begin
      with Order_F.Main_sGrd do
      begin
        For nRow := 0 to RowCount -1 do
          if (Cells[GDM_CD_MENU,   nRow] = Cells[GDM_CD_MENU,   Row]) and
             (Cells[GDM_DS_SALE, nRow]   = Cells[GDM_DS_SALE, Row]) and
             (Cells[GDM_DC_MENU, nRow]   = Cells[GDM_DC_MENU, Row]) and
             (Cells[GDM_PR_SALE, nRow]   = Cells[GDM_PR_SALE, Row]) and
             (Cells[GDM_CD_MENU1, nRow]  = '' ) then
           begin
             Cells[GDM_DC_MENU, nRow] := AValue;
             Cells[GDM_CHANGE,  nRow] := 'Y';
           end;
      end;
   end;
var
   DCPr, BefDc               :Double;
   liSmry, liRow :Integer;
   lsGood,lsPrSale,lsDsSale  :String;
begin
  try
   if not CheckDcMenu then Exit;

   with Order_F.Main_sGrd, Common do
     case DiscountType of
       dtMenuAmt :
         begin
           if StoI(FInData) > StoI(Cells[GDM_PR_SALE, Row]) then
           begin
              Common.ErrBox('상품단가보다 할인금액이 작아야합니다');
              Exit;
           end;
           liRow := Summary_Row;   //집계그리드의 Row찾기
           BefDc := StoI(Summary_sGrd.Cells[GDM_DC_MENU, liRow]);
           Dcpr  := StoI(FInData) - BefDc;
           Dcpr  := FtoI( hRound( Dcpr,0) );
           if StoI(FInData) = 0 then
           begin
              GridApply('0');
              Summary_sGrd.Cells[GDM_DC_MENU, liRow] := '0';
           end
           else
           begin
              GridApply(FtoS(Dcpr+BefDc));
              Summary_sGrd.Cells[GDM_DC_MENU, liRow] := FtoS(BefDc + Dcpr);
           end;

           PreSent.MenuDc := PreSent.MenuDc + (FtoI(Dcpr) * StoI(Summary_sGrd.Cells[GDM_QTY, liRow]));
         end;
       dtMenuPersent :  //메뉴 할인률로 할인
         begin
           liSmry := Summary_Row;
           if StoF(FInData) > 0 then
           begin
             Dcpr := (StoF(Cells[GDM_PR_SALE, Row]) / 100 ) * StoF(FInData);
             Dcpr := FtoI( hRound( Dcpr,0) );
             //할인율단위 계산
             if Common.Config.dc_unit > 0 then
               Dcpr := wyRound(FtoI(Dcpr), Config.dc_unit);
           end
           else Dcpr := 0;

           GridApply(FtoS(Dcpr));
           //집계그리드에 적용
           Summary_sGrd.Cells[GDM_DC_MENU, liSmry] := FtoS(Dcpr);

           Dcpr := StoI(Summary_sGrd.Cells[GDM_DC_MENU, liSmry]) * StoI(Summary_sGrd.Cells[GDM_QTY, liSmry]) - PreSent.MenuDc;
           PreSent.MenuDc := PreSent.MenuDc + FtoI(Dcpr);
         end;
       //전체금액할인
       dtAllAmt     :
       begin
         if PreSent.ExistDcAmt >= Present.TotalAmt then Exit;
         PreSent.RcpDc_Rate := 0;
         PreSent.RcpDc := FtoI( StoI(FInData) );
       end;
       //전체 %할인
       dtAllPersent :
         begin
           if PreSent.ExistDcAmt >= Present.TotalAmt then
           begin
             Common.ErrBox('할인제외금액이 총금액보다 큽니다');
             Exit;
           end;
           PreSent.RcpDc_Rate := 0;
           if StoF(FInData) > 0 then
           begin
             PreSent.RcpDc_Rate := StoF(FInData);
             Dcpr := ( (Present.WRcvAmt+Present.CutDc + PreSent.RcpDc ) / 100 ) * StoF(FInData);
             Dcpr := FtoI( hRound( Dcpr,0) );
             //할인율단위 계산
             if (Common.Config.dc_unit > 0) and (StoF(FInData) <> 100) then
               Dcpr := wyRound(FtoI(Dcpr), Config.dc_unit);

             PreSent.RcpDc := FtoI( Dcpr );
             //%할인을 할인금액으로 사용시
             if GetOption(366) = '1' then
               PreSent.RcpDc_Rate := 0;
           end
           else PreSent.RcpDc := 0;

         end;
       //단가변경
       dtPriceChg   :
         begin
           liSmry   := Summary_Row;
           if StoI(Cells[GDM_DC_MENU, liSmry]) > 0 then
           begin
             ErrBox('할인한 상품은 단가를 변경할 수 없습니다');
             Exit;
           end;

           if Cells[GDM_YN_RCP, liSmry] = 'N' then
           begin
             ErrBox('영수증에 출력하지 않는 메뉴는'#13'단가를 변경할 수 없습니다');
             Exit;
           end;
           lsGood   := Cells[GDM_CD_MENU, Row];
           lsPrSale := Cells[GDM_PR_SALE, Row];
           lsDsSale := Cells[GDM_DS_SALE, Row];
           //부가세별도 메뉴는 부가세 10%를 붙인다
           if Cells[GDM_DS_TAX, Row] = '2' then
             FInData := FtoS(StoI(FInData) * 1.1);
           For liRow := 0 to RowCount - 1 do
           begin
             if (lsGood = Cells[GDM_CD_MENU, liRow])
             and (lsPrSale = Cells[GDM_PR_SALE, liRow])
             and (lsDsSale = Cells[GDM_DS_SALE, liRow])
             and (Cells[GDM_CD_MENU1, liRow] = '' ) then
             begin
                Cells[GDM_VIEWPRICE, liRow] := FInData;
                Cells[GDM_PR_SALE, liRow]   := FInData;
                if Cells[GDM_DS_MENU, Row] = 'W' then
                  Cells[GDM_AMT, Row]       := Cells[GDM_PR_SALE, liRow]
                else
                Cells[GDM_AMT, Row]       := IntToStr(StoI(FInData) * StoI(Cells[GDM_QTY, liRow]) );
             end;
           end;
           Summary_sGrd.Cells[GDM_PR_SALE, liSmry] := FInData;

           if Summary_sGrd.Cells[GDM_DS_MENU, liSmry] = 'W' then
           begin
             Dcpr := StoI(Summary_sGrd.Cells[GDM_AMT, liSmry]) - (StoI(FInData) );
             Summary_sGrd.Cells[GDM_AMT, liSmry] := FInData;
           end
           else
           begin
             Dcpr := StoI(Summary_sGrd.Cells[GDM_AMT, liSmry]) - (StoI(FInData) *  StoI(Summary_sGrd.Cells[GDM_QTY, liSmry]) );
             Summary_sGrd.Cells[GDM_AMT, liSmry] := IntToStr(StoI(FInData) *  StoI(Summary_sGrd.Cells[GDM_QTY, liSmry]));
             //상품정보의 판매단가를 변경한다
             if GetOption(332) = '1' then
             begin
               ExecQuery('update MS_MENU '
                        +'   set PR_SALE  =:P2 '
                        +' where CD_STORE =:P0 '
                        +'   and CD_MENU  =:P1',
                        [Common.Config.StoreCode,
                         lsGood,
                         StoI(FInData)]);
             end;
           end;

           Present.TotalAmt := Present.TotalAmt - FtoI(Dcpr);
        end;
        dtTip :
        begin
           Present.SetTip := StoI(FInData);
        end;
    end;
  finally
    if CloseButton.Enabled then
    begin
      Order_F.DisplayPresent;
      Close;
    end;
  end;
end;

function TDiscount_F.Summary_Row: Integer;
var vRow:Integer;
begin
   with Order_F.Main_sGrd do
   begin
     For vRow := 0 to Common.Summary_sGrd.RowCount - 1 do
     begin
       if (Cells[GDM_CD_MENU, Row] = Common.Summary_sGrd.Cells[GDM_CD_MENU, vRow])
         and (Cells[GDM_DS_SALE, Row] = Common.Summary_sGrd.Cells[GDM_DS_SALE, vRow])
         and (Cells[GDM_DC_MENU, Row] = Common.Summary_sGrd.Cells[GDM_DC_MENU, vRow])
         and (Cells[GDM_PR_SALE, Row] = Common.Summary_sGrd.Cells[GDM_PR_SALE, vRow])
         and (Cells[GDM_CD_ITEM, Row] = Common.Summary_sGrd.Cells[GDM_CD_ITEM, vRow])
         and (Common.Summary_sGrd.Cells[GDM_CD_MENU1, vRow] = '')
         then
       begin
            Result := vRow;
            Break;
       end;
     end;
   end;
end;


function TDiscount_F.CheckDcMenu: Boolean;
begin
  Result := False;
  case FDiscountType of
    dtMenuAmt :
      begin
        if Order_F.Main_sGrd.Cells[GDM_CD_MENU1, Order_F.Main_sGrd.Row] <> '' then
        begin
          Common.ErrBox('할인할 수 없는 메뉴입니다.');
          Exit;
        end;

        if Order_F.Main_sGrd.Cells[GDM_DS_SALE, Order_F.Main_sGrd.Row] = 'D' then
        begin
          Common.ErrBox('서비스메뉴은 할인 할 수 없습니다.');
          Exit;
        end;
      end;
    dtMenuPersent :
      begin
        if Order_F.Main_sGrd.Cells[GDM_CD_MENU1, Order_F.Main_sGrd.Row] <> '' then
        begin
          Common.ErrBox('할인할 수 없는 메뉴입니다.');
          Exit;
        end;
        if Order_F.Main_sGrd.Cells[GDM_DS_SALE, Order_F.Main_sGrd.Row] = 'D' then
        begin
          Common.ErrBox('서비스메뉴는 할인 할 수 없습니다.');
          Exit;
        end;
      end;
    dtAllAmt :
      begin
        if (StoI(FInData) > 0) and ( Common.PreSent.WRcvAmt <= 0 ) then
        begin
          Common.ErrBox('받을금액이 없습니다.');
          Exit;
        end;
      end;
    dtAllPersent :
      begin
        if (StoF(FInData) > 0) and ( Common.PreSent.WRcvAmt <= 0 ) then
        begin
          Common.ErrBox('받을금액이 없습니다.');
          Exit;
        end;
      end;
    dtEvent    :
      begin
        if (StoI(FInData) > 0) and ( Common.PreSent.WRcvAmt <= 0 ) then
        begin
          Common.ErrBox('받을금액이 없습니다.');
          Exit;
        end;      
      end;
    dtPriceChg :
      begin
        if Order_F.Main_sGrd.Cells[GDM_DS_SALE, Order_F.Main_sGrd.Row] = 'D' then
        begin
          Common.ErrBox('서비스메뉴는 단가를 변경할 수 없습니다.');
          Exit;
        end;

        if Order_F.Main_sGrd.Cells[GDM_CD_MENU1, Order_F.Main_sGrd.Row] <> '' then
        begin
          Common.ErrBox('단가를 변경할 수 없는 메뉴입니다.');
          Exit;
        end;
      end;
  end;
  Result := True;
end;

procedure TDiscount_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TDiscount_F.Action1Execute(Sender: TObject);
begin
  Common.KeyPadType := 1;
  FInData := Common.ShowNumberForm('할인율을 입력하세요',0,100,'');
  if FInData = 'mrClose' then Exit;

  Common.KeyPadType := 0;
  if FInData <> '' then
    DiscountType := dtAllPersent;
end;

procedure TDiscount_F.Action2Execute(Sender: TObject);
begin
  if Common.Present.CodeDcCode <> '' then
  begin
    Common.ErrBox('지정할인과 전체할인은 같이'+#13#13+'사용 할 수 없습니다');
    Exit;
  end;
  FInData := Common.ShowNumberForm('할인금액을 입력하세요',0,Common.PreSent.WRcvAmt+Common.PreSent.CutDc,'');
  if FInData = 'mrClose' then Exit;
  //전체할인금액을 받을금액 전부를 입력했다면 자동(단차)할인도 포함한 전체로 한다
  if StoI(FInData) = Common.PreSent.WRcvAmt then
    FInData := IntToStr(Common.PreSent.WRcvAmt+Common.PreSent.CutDc);
  if FInData <> '' then
    DiscountType := dtAllAmt;
end;

procedure TDiscount_F.Action3Execute(Sender: TObject);
begin
  if Order_F.Main_sGrd.Cells[GDM_YN_DC, Order_F.Main_sGrd.Row] = 'N' then
  begin
    Common.ErrBox('할인을 할 수 없는 메뉴입니다');
    Exit;
  end;
  Common.KeyPadType := 1;
  FInData := Common.ShowNumberForm('할인율을 입력하세요',0,100,'');
  if FInData = 'mrClose' then Exit;
  Common.KeyPadType := 0;
  if FInData <> '' then
    DiscountType := dtMenuPersent;
end;

procedure TDiscount_F.Action4Execute(Sender: TObject);
begin
  if Order_F.Main_sGrd.Cells[GDM_YN_DC, Order_F.Main_sGrd.Row] = 'N' then
  begin
    Common.ErrBox('할인을 할 수 없는 메뉴입니다');
    Exit;
  end;
  FInData := Common.ShowNumberForm('할인금액을 입력하세요',0,StoI( Order_F.Main_sGrd.Cells[GDM_PR_SALE, Order_F.Main_sGrd.Row] ),'');
  if FInData = 'mrClose' then Exit;
  if FInData <> '' then
    DiscountType := dtMenuAmt;
end;

procedure TDiscount_F.Action5Execute(Sender: TObject);
begin
  if Common.PreSent.VatDc <> 0 then
    Common.PreSent.VatDc := 0
  else
  begin
    //할인율단위 계산
    if Common.Config.dc_unit > 0 then
      Common.PreSent.VatDc := wyRound(Common.PreSent.TaxAmt, Common.Config.dc_unit)
    else
      Common.PreSent.VatDc := Common.PreSent.TaxAmt;
  end;
  Order_F.DisplayPresent;
  Close;
end;

procedure TDiscount_F.Action6Execute(Sender: TObject);
begin
  FInData := Common.ShowNumberForm('변경 할 단가를 입력하세요',7, 0,'');
  if FInData = 'mrClose' then Exit;
  if FInData <> '' then
    DiscountType := dtPriceChg;
end;

procedure TDiscount_F.Action7Execute(Sender: TObject);
begin
  if GetOption(160) = '1' then
  begin
    Common.ErrBox('메뉴단가에 봉사료를 포함해서 사용할때는'+#13#13+'사용할 수 없습니다');
    Exit;
  end;

  if Order_F.FTipType = '0' then //금액형 봉사료
  begin
    FInData := Common.ShowNumberForm('봉사료 금액을 입력하세요',7,0,'');
    if FInData = 'mrClose' then Exit;
    if FInData <> '' then
      DiscountType := dtTip;
  end
  else
  begin
    FInData := Common.ShowNumberForm('봉사료 퍼센트(%)를 입력하세요',0,100,'');
    if FInData = 'mrClose' then Exit;
    if FInData <> '' then
      DiscountType := dtTip;
  end;
end;

procedure TDiscount_F.Action8Execute(Sender: TObject);
begin
  InitUPlusRecord(Common.Uplus);
  if Common.ShowUPlusForm(True) then
  begin
    Common.PreSent.UPlusDc := Common.UPlus.Dc_Amt;
    Order_F.DisplayPresent;
    Close;
  end;
end;

procedure TDiscount_F.DcButtonClick(Sender: TObject);
var vIndex :Integer;
begin
  vIndex := (Sender as TAdvSmoothButton).Tag;
  ActionList[vIndex].Execute;
end;

procedure TDiscount_F.CodeButtonClick(Sender: TObject);
  procedure ClearCodeDc;
  begin
    Common.Present.CodeDcCode   := '';
    Common.Present.CodeDcName   := '';
    Common.Present.CodeDcType   := '';
    Common.Present.CodeDcRate   := 0;
    Common.Present.CodeDcStdAmt := 0;
    Common.Present.CodeDcAmt    := 0;
  end;
var vRtn :String;
    vIndex :Integer;
begin
  if CopyPos((Sender as TAdvSmoothButton).Hint,'|',1) = '할인취소' then
  begin
    if (Sender as TAdvSmoothButton).Status.Caption = '지정할인' then
      ClearCodeDc
    else
    begin
      FInData := '0';
      CloseButton.Enabled := false;
      for vIndex := 0 to Order_F.Main_sGrd.RowCount-1 do
      begin
        Order_F.Main_sGrd.Row := vIndex;
        DiscountType := dtMenuPersent;
      end;
      Order_F.DisplayPresent;
    end;
  end
  else if CopyPos((Sender as TAdvSmoothButton).Hint,'|',7) = '1' then
  begin
    //메뉴할인율
    if CopyPos((Sender as TAdvSmoothButton).Hint,'|',2) = '0' then
    begin
      FInData := CopyPos((Sender as TAdvSmoothButton).Hint,'|',3);
      DiscountType := dtMenuPersent;
    end
    else if CopyPos((Sender as TAdvSmoothButton).Hint,'|',2) = '1' then
    begin
      FInData := CopyPos((Sender as TAdvSmoothButton).Hint,'|',5);
      DiscountType := dtMenuAmt;
    end;
  end
  else if CopyPos((Sender as TAdvSmoothButton).Hint,'|',7) = '2' then
  begin
    //메뉴할인율
    if CopyPos((Sender as TAdvSmoothButton).Hint,'|',2) = '0' then
    begin
      FInData := CopyPos((Sender as TAdvSmoothButton).Hint,'|',3);
      CloseButton.Enabled := false;
      for vIndex := 0 to Order_F.Main_sGrd.RowCount-1 do
      begin
        Order_F.Main_sGrd.Row := vIndex;
        DiscountType := dtMenuPersent;
      end;
      Order_F.DisplayPresent;
      Close;
    end
    else if CopyPos((Sender as TAdvSmoothButton).Hint,'|',2) = '1' then
    begin
      FInData := CopyPos((Sender as TAdvSmoothButton).Hint,'|',5);
      CloseButton.Enabled := false;
      for vIndex := 0 to Order_F.Main_sGrd.RowCount-1 do
      begin
        Order_F.Main_sGrd.Row := vIndex;
        DiscountType := dtMenuAmt;
      end;
      Order_F.DisplayPresent;
      Close;
    end;
  end
  else
  begin
    Common.Present.CodeDcCode   := CopyPos((Sender as TAdvSmoothButton).Hint,'|',1);
    Common.Present.CodeDcName   := (Sender as TAdvSmoothButton).HelpKeyword;
    Common.Present.CodeDcType   := CopyPos((Sender as TAdvSmoothButton).Hint,'|',2);
    //할인구분이 할인률이면서 할인률이 0 일때
    Common.Present.CodeDcRate   := StoF( CopyPos((Sender as TAdvSmoothButton).Hint,'|',3) );
    Common.Present.CodeDcStdAmt := StoI( CopyPos((Sender as TAdvSmoothButton).Hint,'|',4) );
    Common.Present.CodeDcAmt    := StoI( CopyPos((Sender as TAdvSmoothButton).Hint,'|',5) );
    Common.Present.CodeDcClass  := CopyPos((Sender as TAdvSmoothButton).Hint,'|',6);

    if (Common.Present.CodeDcType = '0') and (CopyPos((Sender as TAdvSmoothButton).Hint,'|',3) = '0') then
    begin
      vRtn := Common.ShowNumberForm('할인율을 입력하세요',0,100,'');
      if vRtn = 'mrClose' then Exit;

      if vRtn = '' then
      begin
        ClearCodeDc;
        Exit;
      end;
      Common.Present.CodeDcRate := StoF( vRtn );
    end;

    if (Common.Present.CodeDcType = '1') and (CopyPos((Sender as TAdvSmoothButton).Hint,'|',4) = '0') and (CopyPos((Sender as TAdvSmoothButton).Hint,'|',5) = '0') then
    begin
      vRtn := Common.ShowNumberForm('할인금액을 입력하세요',0, Common.PreSent.WRcvAmt,'');
      if vRtn = 'mrClose' then Exit;
      if vRtn = '' then
      begin
        ClearCodeDc;
        Exit;
      end;
      if (Common.PreSent.TotalAmt-Common.PreSent.ExistDcAmt+Common.PreSent.TotalDC)  < StoI( vRtn ) then
      begin
        Common.ErrBox('할인금액이 할인제외메뉴 금액보다 큽니다');
        Exit;
      end;
      Common.Present.CodeDcAmt := StoI( vRtn );
    end;

  end;
  Order_F.DisplayPresent;
  Close;
end;

end.
