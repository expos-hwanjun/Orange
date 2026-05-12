unit RePrint_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, MaskUtils, DB,
  ComCtrls, cxRadioGroup, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  Vcl.Menus, cxButtons, AdvSmoothToggleButton, PosButton, AdvGlassButton,
  dxGDIPlusClasses, AdvSmoothButton;

type
  TWorkKind = (wkCustomer, wkKitchen);

type
  TRePrint_F = class(TForm)
    Label1: TLabel;
    lbl_OrderTime: TLabel;
    PreviewPanel: TPanel;
    Memo1: TRichEdit;
    rdo_rast: TcxRadioButton;
    rdo_all: TcxRadioButton;
    CaptionLabel: TLabel;
    CloseButton: TcxButton;
    PrintCheckButton: TAdvGlassButton;
    MessageLabel: TLabel;
    Image3: TImage;
    CustomerButton: TAdvSmoothToggleButton;
    KitchenButton: TAdvSmoothToggleButton;
    Kitchen1Button: TAdvSmoothToggleButton;
    Kitchen2Button: TAdvSmoothToggleButton;
    Kitchen3Button: TAdvSmoothToggleButton;
    Kitchen4Button: TAdvSmoothToggleButton;
    Kitchen5Button: TAdvSmoothToggleButton;
    Kitchen6Button: TAdvSmoothToggleButton;
    Kitchen7Button: TAdvSmoothToggleButton;
    Kitchen8Button: TAdvSmoothToggleButton;
    PrintButton: TAdvSmoothButton;
    CancelButton: TAdvSmoothButton;
    procedure FormShow(Sender: TObject);
    procedure obtn_Kitchen1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rdo_rastClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure Kitchen1ButtonClick(Sender: TObject);
    procedure CustomerButtonClick(Sender: TObject);
    procedure KitchenButtonClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure PrintCheckButtonClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    FWorkKind : TWorkKind;
    procedure SetWorkKind(const Value: TWorkKind);
    property WorkKind :TWorkKind read FWorkKind write SetWorkKind;
  public
    { Public declarations }
  end;

var
  RePrint_F: TRePrint_F;

implementation
uses Common_U, GlobalFunc_U, PrinterStatus_U, Const_U;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TRePrint_F.CancelButtonClick(Sender: TObject);
begin
  PreviewPanel.Visible := False;
  Common.CustomerPrinter := EmptyStr;
end;

procedure TRePrint_F.CloseButtonClick(Sender: TObject);
var vIndex, I :Integer;
begin
  //주방주문서 데이터 클리어
  For vIndex := 0 to High(Common.KitChenPrinter) do
  begin
    For I := 1 to 100 do
      Common.KitchenPrinter[vIndex].GroupSource[I] := EmptyStr;
    Common.KitchenPrinter[vIndex].Source      := EmptyStr;
    Common.KitchenPrinter[vIndex].Data        := EmptyStr;
    Common.KitchenPrinter[vIndex].Cancel      := EmptyStr;
  end;
  Common.CustomerPrinter := EmptyStr;
  Close;
end;

procedure TRePrint_F.CustomerButtonClick(Sender: TObject);
begin
  if Common.Table.OrderType = 'T' then
    WorkKind := wkCustomer
  else
    ModalResult := mrYesToAll;
end;

procedure TRePrint_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(PrintButton);
end;

procedure TRePrint_F.FormResize(Sender: TObject);
begin
  PreviewPanel.Top  := 0;
  PreviewPanel.Left := 0;
end;

procedure TRePrint_F.FormShow(Sender: TObject);
begin
  BlockInput(false);
  if Common.Table.OrderType = 'T' then
  begin
    CustomerButton.Caption := '고객주문서';
    WorkKind := wkCustomer;
  end
  else
  begin
    WorkKind := wkKitchen;
    CustomerButton.Caption := '배달전표';
  end;
end;

procedure TRePrint_F.Kitchen1ButtonClick(Sender: TObject);
var vTemp, vTemp1, vPrintData, vBefGubun, vTemp2 :AnsiString;
    vOrderNo, vCol :Integer;
begin
  vCol := Common.Config.PrintColum;
  try
    case WorkKind of
      wkCustomer :   //고객주문서
      begin
        Common.CustomerPrinter := EmptyStr;
        Common.CustomerCancel  := EmptyStr;
        InitPreSentRecord(Common.Present);
        if Sender = Kitchen1Button then
        begin
          PreviewPanel.Visible := True;
          PreviewPanel.Top     := 0;
          PreviewPanel.Left    := 0;
          OpenQuery('select ''1'' GUBUN, '
                   +'       PRINT_DATA as NM_MENU, '
                   +'       '''' as DS_MENU_TYPE, '
                   +'       '''' as QTY_CANCEL, '
                   +'       0 as AMT_CANCEL, '
                   +'       ORDER_TIME, '
                   +'       NO_ORDER, '
                   +'       NO_PERSON, '
                   +'       NM_DAMDANG, '
                   +'       ifnull(NO_POS,'''') as NO_POS, '
                   +'       Date_Format(DT_CHANGE, ''%Y-%m-%d %H:%i'') as DT_CHANGE, '
                   +'       YN_LETSORDER '
                   +'  from SL_ORDER_PRT '
                   +' where CD_STORE =:P0 '
                   +'   and NO_TABLE =:P1 '
                   +'   and DS_ORDER =:P2 '
                   +'   and CD_PRINTER = ''000'' '
                   +'union all '
                   +'select ''2'' GUBUN, '
                   +'       b.NM_MENU , '
                   +'       b.DS_MENU_TYPE, '
                   +'       a.QTY_CANCEL, '
                   +'       a.AMT_CANCEL, '
                   +'       a.DT_CANCEL as ORDER_TIME, '
                   +'       0 as NO_ORDER, '
                   +'       0 as NO_PERSON, '
                   +'       '''' as NM_DAMDANGL, '
                   +'       a.NO_POS, '
                   +'       Date_Format(DT_CHANGE, ''%Y-%m-%d %H:%i'') as DT_CHANGE, '
                   +'       ''N'' '
                   +'  from SL_ORDER_C a inner join '
                   +'       MS_MENU    b on a.CD_STORE = b.CD_STORE and a.CD_MENU = b.CD_MENU '
                   +' where a.CD_STORE = :P0 '
                   +'   and a.DT_ORDER = '''' '
                   +'   and a.NO_TABLE = :P1 '
                   +'   and a.DS_ORDER = :P2 '
                   +' order by 11 ',
                   [Common.Config.StoreCode,
                    Common.Table.Number,
                    Common.Table.OrderType]);

          Common.ClearKitchenData;
          vPrintData := EmptyStr;
          vBefGubun  := '0';
          vTemp1     := '';
          Memo1.Clear;
          while not Common.Query.Eof do
          begin
            if Common.Query.FieldByName('gubun').AsString = '1' then
            begin
              if Common.Query.FieldByName('YN_LETSORDER').AsString = 'Y' then
                vTemp2 := '[L]'
              else
                vTemp2 := '';
              Memo1.Lines.Add('');
              vPrintData   := vPrintData  + Trim(RpadB('[주문시간] '+ FormatMaskText('!0000년90월90일 09시:09분;0; ',Common.Query.FieldByName('order_time').AsString)+vTemp2,42,' '))+#13;
              Memo1.Lines.Add(Rpad('주문시간 : '+ FormatMaskText('!0000년90월90일 09시:09분;0; ',Common.Query.FieldByName('order_time').AsString)+vTemp2,42,' '));
              vPrintData   := vPrintData  + Trim(RpadB('주문번호 : '+Common.Query.FieldByName('no_pos').AsString+'-'+Common.Query.FieldByName('no_order').AsString ,42,' '))+#13;
              Memo1.Lines.Add(Rpad('주문번호 : '+Common.Query.FieldByName('no_pos').AsString+'-'+Common.Query.FieldByName('no_order').AsString ,42,' '));
              if Common.Config.Options[37] = '1' then
              begin
                vPrintData   := vPrintData  + Rpad('주문담당 : '+Common.Query.FieldByName('nm_damdang').AsString ,42,' ')+#13;
                Memo1.Lines.Add(Rpad('주문담당 : '+Common.Query.FieldByName('nm_damdang').AsString ,42,' '));
              end;
              vPrintData   := vPrintData  + Trim(Replace(Common.Query.FieldByName('NM_MENU').AsString,#13,''))+#13;
              Memo1.Lines.Add(Common.Query.FieldByName('NM_MENU').AsString);
              vBefGubun    := '1';
            end
            else
            begin
              if (vTemp1 <> Common.Query.FieldByName('order_time').AsString) then
              begin
                vPrintData   := vPrintData  + #13;
                Memo1.Lines.Add('');
                vPrintData   := vPrintData  + Trim(Rpad('주문않고취소 ('+ FormatMaskText('!0000년90월90일 09시:09분;0; ',Common.Query.FieldByName('order_time').AsString)+')',42,' '))+#13;
                Memo1.Lines.Add(Rpad('주문않고취소 ('+ FormatMaskText('!0000년90월90일 09시:09분;0; ',Common.Query.FieldByName('order_time').AsString)+')',42,' '));
                vPrintData   := vPrintData  + Trim(Rpad('포스번호 : '+ Common.Query.FieldByName('no_pos').AsString,42,' '))+#13;
                Memo1.Lines.Add(Rpad('포스번호 : '+ Common.Query.FieldByName('no_pos').AsString,42,' '));

              end;
              vTemp1:= Common.Query.FieldByName('order_time').AsString;
              vTemp := RPadB(Common.Query.FieldByName('nm_menu').AsString,27,' ');
              vTemp := vTemp + LPadB(Common.GetQtyReplace(Common.Query.FieldByName('ds_menu_type').AsString,
                                                         Common.Query.FieldByName('qty_cancel').AsString),4,' ');
              vTemp := vTemp + LPadB(FormatFloat('#,0',Common.Query.FieldByName('amt_cancel').AsInteger),11, ' ')+#13;
              vPrintData   := vPrintData  + Trim(Replace(vTemp,#13,''));
              Memo1.Lines.Add(Replace(vTemp,#13,''));
              vBefGubun    := '2';
            end;
            Common.Query.Next;
          end;
          Common.Query.Close;
          Common.GetAllCustomerOrder(2);
          vPrintData :=  vPrintData
//                        + rptLF+rptLF
                        + rptOneLine+#13
                        + '               최종주문내역               '+#13
                        + rptOneLine+#13;

          Memo1.Lines.Add('');
          Memo1.Lines.Add(LPad('',42+vCol,'-'));
          Memo1.Lines.Add('               최종주문내역               ');
          Memo1.Lines.Add(LPad('',42+vCol,'-'));
          vPrintData := vPrintData + Common.CustomerPrinter;
          Memo1.Lines.Add(Common.CustomerPrinter);
          Common.CustomerPrinter := vPrintData ;

          Memo1.Lines.Add(LPadB('',42+vCol,'-'));
          if Common.OrderDutyFreeAmt <> 0 then
            Memo1.Lines.Add('              면세금액'+ LPadB(FormatFloat('#,0', Common.OrderDutyFreeAmt),20+vCol, ' ')) ;
          if Common.OrderDutyAmt <> 0 then
            Memo1.Lines.Add('              과세금액'+ LPadB(FormatFloat('#,0', Common.OrderDutyAmt),20+vCol, ' ')) ;
          if Common.OrderVatAmt <> 0 then
            Memo1.Lines.Add('            부가세금액'+ LPadB(FormatFloat('#,0', Common.OrderVatAmt),20+vCol, ' ')) ;
          if Common.Present.TotalDC <> 0 then
            Memo1.Lines.Add('              할인금액'+ LPadB(FormatFloat('#,0', Common.PreSent.TotalDC),20+vCol, ' ') );
          Memo1.Lines.Add('          주문합계금액'+ LPadB(FormatFloat('#,0', Common.OrderAmt),20+vCol, ' ')) ;
          Memo1.Lines.Add(LPadB('',42+vCol,'='));
        end
        //최종고객주문서 재출력
        else if Sender = Kitchen2Button then
        begin
          if Common.Table.GroupType = 'M' then
          begin
            if Common.AskBox('그룹디테일 주문내역까지'+#13#13+'출력 하시겠습니까?') then
              Common.GetAllCustomerOrder(3)
            else
              Common.GetAllCustomerOrder(2);
          end
          else
            Common.GetAllCustomerOrder(2);

          Common.Present.CutDc   := AmtofCut(Common.OrderAmt, StrToInt(GetOption(153)));
          Common.PreSent.TotalDC := Common.PreSent.TotalDC + Common.Present.CutDc;

          OpenQuery('select a.CD_DAMDANG, '
                   +'       b.NM_SAWON, '
                   +'       a.CNT_PERSON, '
                   +'       a.CD_AGE '
                   +'  from SL_ORDER_H a inner join '
                   +'       MS_SAWON b on b.CD_STORE = a.CD_STORE and b.CD_SAWON = a.CD_DAMDANG '
                   +' where a.CD_STORE   =:P0 '
                   +'   and a.NO_TABLE   =:P1',
                   [Common.Config.StoreCode,
                    Common.Table.Number]);
          if not Common.Query.Eof then
          begin
            Common.Table.DamdangCode := Common.Query.Fields[0].AsString;
            Common.Table.DamdangName := Common.Query.Fields[1].AsString;
          end;
          Common.Query.Close;
          OpenQuery('select CNT_PERSON, '
                   +'       CD_AGE, '
                   +'       NO_ORDER '
                   +'  from SL_ORDER_H '
                   +' where CD_STORE =:P0 '
                   +'   and NO_TABLE =:P1',
                   [Common.Config.StoreCode,
                    Common.Table.Number]);
          vOrderNo := Common.Table.OrderNo;
          if not Common.Query.Eof then
          begin
            Common.Table.CustomerCount      := Common.Query.Fields[0].AsInteger;
            Common.SetAgeInfo( Common.Query.Fields[1].AsString );
            Common.Table.OrderNo            := Common.Query.Fields[2].AsInteger;
          end;
          Common.Query.Close;

          Common.TableMode := tbmNone;
          Common.Device.CustomerOrderPrint(0,0);
          Common.Table.OrderNo := vOrderNo;
          Common.CustomerPrintLast    := False;
          MessageLabel.Caption    := '고객 주문서를 출력했습니다';
        end;
      end;
      wkKitchen  :
      begin
        if High(Common.KitchenPrinter) < (Sender as TAdvSmoothToggleButton).Tag then Exit;
        Common.OrderRePrint := True;
        vTemp := Common.KitchenPrinter[(Sender as TAdvSmoothToggleButton).Tag].Data;
        vTemp1 := StringReplace( Common.KitchenPrinter[(Sender as TAdvSmoothToggleButton).Tag].Data, '주방주문서','[ 재인쇄 ]',[rfReplaceAll]);
        Common.Device.KitchenOrderPrint( (Sender as TAdvSmoothToggleButton).Tag );
        Common.KitchenPrinter[(Sender as TAdvSmoothToggleButton).Tag].Data := vTemp;
        Common.OrderRePrint := False;
        MessageLabel.Caption    := '주방 주문서를 출력했습니다';
      end;
    end;
  finally
  end;
end;

procedure TRePrint_F.KitchenButtonClick(Sender: TObject);
begin
  WorkKind := wkKitchen;
end;

procedure TRePrint_F.obtn_Kitchen1Click(Sender: TObject);
begin
end;

  //고객용 주문서
procedure TRePrint_F.SetWorkKind(const Value: TWorkKind);
var vIndex :Integer;
    vTemp, vBefPrt:String;
begin
  FWorkKind := Value;
  case FWorkKind of
    wkCustomer:
    begin
      MessageLabel.Caption    := '고객주문서를 출력합니다';
      CustomerButton.Visible := False;
      KitchenButton.Visible   := True;
      rdo_rast.Visible        := False;
      rdo_all.Visible         := False;
      For vIndex := 1 to 8 do
        TAdvSmoothToggleButton(FindComponent(Format('Kitchen%dButton',[vIndex]))).Visible := False;
      Kitchen1Button.Visible := True;
      Kitchen1Button.Caption := '주문로그출력';
      Kitchen2Button.Visible := True;
      Kitchen2Button.Caption := '주문서재출력';
    end;
    wkKitchen:
    begin
      MessageLabel.Caption    := '주방주문서를 출력합니다';
      CustomerButton.Visible := True;
      KitchenButton.Visible   := False;
      rdo_rast.Visible        := True;
      rdo_all.Visible         := True;

      with Common do
      begin
        TableMode := tbmNone;

        //메뉴별로 지정된 주방프린터에 주문데이터를 분배한다
        if rdo_rast.Checked then
        begin
          OpenQuery('select a.CD_PRINTER, '
                   +'       a.PRINT_DATA, '
                   +'       a.ORDER_TIME, '
                   +'       a.NO_ORDER,'
                   +'       a.NO_PERSON, '
                   +'       a.NM_DAMDANG '
                   +'  from SL_ORDER_PRT a '
                   +' where a.CD_STORE =:P0 '
                   +'   and a.NO_TABLE =:P1 '
                   +'   and a.DS_ORDER =:P2 '
                   +'   and (a.CD_PRINTER <> ''000'') and (a.CD_PRINTER <> ''LET'') '
                   +'   and a.NO_ORDER = (select Max(NO_ORDER) '
                   +'                       from SL_ORDER_PRT '
                   +'                      where CD_STORE =a.CD_STORE '
                   +'                        and NO_TABLE =a.NO_TABLE '
                   +'                        and CD_PRINTER <> ''000'') '
                   +' order by a.CD_PRINTER, a.DT_CHANGE ',
                   [Config.StoreCode,
                    Table.Number,
                    Table.OrderType]);

          ClearKitchenData;
          while not Common.Query.Eof do
          begin
            Table.OrderNo       := Common.Query.FieldByName('no_order').AsInteger;
            Table.CustomerCount := Common.Query.FieldByName('no_person').AsInteger;
            Table.DamdangName   := Common.Query.FieldByName('nm_damdang').AsString;
            vIndex := GetKitchenIndex(0, 1, Common.Query.FieldByName('cd_printer').AsString);

            //메뉴별로 주문서 낱장인쇄시
            if (vIndex >= 0) and (Config.Options[9] = '1') then
            begin
              vTemp := Device.SetOrderPrintHeader(Common.Query.FieldByName('print_data').AsString, vIndex);
              KitchenPrinter[vIndex].Data := KitchenPrinter[vIndex].Data +
                                             Device.PrinterCommendReplace(vTemp,
                                                                          KitchenPrinter[vIndex].Device,
                                                                          KitchenPrinter[vIndex].Col,
                                                                          KitchenPrinter[vIndex].BottomMargin );
            end
            else if vIndex >= 0 then
            begin

              vTemp := Device.SetOrderPrintHeader(Common.Query.FieldByName('print_data').AsString, vIndex);
              KitchenPrinter[vIndex].Data := Device.PrinterCommendReplace(vTemp,
                                                                          KitchenPrinter[vIndex].Device,
                                                                          KitchenPrinter[vIndex].Col,
                                                                          KitchenPrinter[vIndex].BottomMargin );
            end;
            KitchenPrinter[vIndex].Cancel := EmptyStr;

            lbl_OrderTime.Caption := FormatMaskText('!0000-90-90 00:00;0; ',Common.Query.FieldByName('Order_Time').AsString);
            Common.Query.Next;
          end;

          For vIndex := 1 to 8 do
            TAdvSmoothToggleButton(FindComponent(Format('Kitchen%dButton',[vIndex]))).Visible := False;

          For vIndex := 0 to High(KitChenPrinter) do
          begin
            TAdvSmoothToggleButton(FindComponent(Format('Kitchen%dButton',[vIndex+1]))).Caption := KitchenPrinter[vIndex].Name;
            TAdvSmoothToggleButton(FindComponent(Format('Kitchen%dButton',[vIndex+1]))).Visible := KitChenPrinter[vIndex].Data <> EmptyStr;
            TAdvSmoothToggleButton(FindComponent(Format('Kitchen%dButton',[vIndex+1]))).Tag     := vIndex;
          end;
        end
        else
        begin
          OpenQuery('select CD_PRINTER, '
                   +'       PRINT_DATA, '
                   +'       ORDER_TIME, '
                   +'       NO_ORDER,'
                   +'       NO_PERSON, '
                   +'       NM_DAMDANG '
                   +'  from SL_ORDER_PRT  '
                   +' where CD_STORE =:P0 '
                   +'   and NO_TABLE =:P1 '
                   +'   and DS_ORDER =:P2  '
                   +'   and CD_PRINTER <> ''000'' '
                   +'   and CD_PRINTER <> ''LET'' '
                   +' order by CD_PRINTER, DT_CHANGE ',
                   [Config.StoreCode,
                    Table.Number,
                    Table.OrderType]);

          ClearKitchenData;
          vBefPrt := '';
          while not Common.Query.Eof do
          begin
            Table.OrderNo       := Common.Query.FieldByName('no_order').AsInteger;
            Table.CustomerCount := Common.Query.FieldByName('no_person').AsInteger;
            Table.DamdangName   := Common.Query.FieldByName('nm_damdang').AsString;
            vBefPrt             := Common.Query.FieldByName('cd_printer').AsString;
            vIndex := GetKitchenIndex(0, 1, Common.Query.FieldByName('cd_printer').AsString);
            vTemp  := Common.Query.FieldByName('print_data').AsString;
            lbl_OrderTime.Caption := FormatMaskText('!0000-90-90 00:00;0; ',Common.Query.FieldByName('Order_Time').AsString);
            Common.Query.Next;

            //메뉴별로 주문서 낱장인쇄시
            if Config.Options[9] = '1' then
            begin
              vTemp := Device.SetOrderPrintHeader(vTemp, vIndex);
              KitchenPrinter[vIndex].Data := KitchenPrinter[vIndex].Data +
                                             Device.PrinterCommendReplace(vTemp,
                                                                          KitchenPrinter[vIndex].Device,
                                                                          KitchenPrinter[vIndex].Col,
                                                                          KitchenPrinter[vIndex].BottomMargin );
            end
            else
              KitchenPrinter[vIndex].Data := KitchenPrinter[vIndex].Data + vTemp;

            //마지막이 아니면서 다음데이터하고 같은지
            if ((Common.Query.Eof) or (vBefPrt <> Common.Query.FieldByName('cd_printer').AsString)) and
               (Config.Options[9] = '0')  then
            begin
              vTemp := Device.SetOrderPrintHeader(KitchenPrinter[vIndex].Data, vIndex);
              KitchenPrinter[vIndex].Data := Device.PrinterCommendReplace(vTemp,
                                                                          KitchenPrinter[vIndex].Device,
                                                                          KitchenPrinter[vIndex].Col,
                                                                          KitchenPrinter[vIndex].BottomMargin );
              KitchenPrinter[vIndex].Cancel := EmptyStr;
            end;
          end;
          Common.Query.Close;

          For vIndex := 1 to 8 do
            TAdvSmoothToggleButton(FindComponent(Format('Kitchen%dButton',[vIndex]))).Visible := False;

          For vIndex := 0 to High(KitChenPrinter) do
          begin
            TAdvSmoothToggleButton(FindComponent(Format('Kitchen%dButton',[vIndex+1]))).Caption := KitchenPrinter[vIndex].Name;
            TAdvSmoothToggleButton(FindComponent(Format('Kitchen%dButton',[vIndex+1]))).Visible := KitChenPrinter[vIndex].Data <> EmptyStr;
            TAdvSmoothToggleButton(FindComponent(Format('Kitchen%dButton',[vIndex+1]))).Tag     := vIndex;
          end;
        end;
      end;//with Common do
    end;
  end;
end;

procedure TRePrint_F.rdo_rastClick(Sender: TObject);
begin
  WorkKind := wkKitchen;
end;

procedure TRePrint_F.PrintButtonClick(Sender: TObject);
var vOrderNo :Integer;
    vTemp :String;
begin
  Common.OrderRePrint := True;
  vOrderNo := Common.Table.OrderNo;
  Common.Table.OrderNo := 0;
  Common.TableMode := tbmNone;
  vTemp := Common.CustomerPrinter;
  Common.Device.CustomerOrderPrint(0,0);
  Common.CustomerPrinter := vTemp;
  Common.Table.OrderNo := vOrderNo;
  Common.OrderRePrint := False;
end;

procedure TRePrint_F.PrintCheckButtonClick(Sender: TObject);
begin
  PrinterStatus_F := TPrinterStatus_F.Create(Self);
  try
    PrinterStatus_F.ShowModal;
  finally
    PrinterStatus_F.Release;
  end;
end;

end.
