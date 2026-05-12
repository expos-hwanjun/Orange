unit KioskOrderConfirm_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, ExtCtrls, AdvSmoothButton, cxGroupBox, cxLabel,
  StdCtrls, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxCurrencyEdit, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxClasses, cxGridCustomView, cxGrid, Grids, cxTextEdit,
  cxMemo, cxRichEdit, IniFiles, MMSystem, AdvShape, AdvSmoothToggleButton,
  dxGDIPlusClasses, cxImage, Math, AdvPanel;

type
  TOrderInfo = record
    GroupBox     :TPanel;
    MainMenu     :TcxLabel;
    SubMenu      :TcxLabel;
    OrderQty     :TcxLabel;
    OrderAmt     :TcxLabel;
  end;

type
  TKioskOrderConfirm_F = class(TForm)
    CloseTimer: TTimer;
    MenuGroupBox: TPanel;
    Panel1: TPanel;
    lblOrderAmt: TcxLabel;
    lblOrderQty: TcxLabel;
    lblAddStamp: TcxLabel;
    lblTotalStamp: TcxLabel;
    lblAddStampCount: TcxLabel;
    lblTotalStampCount: TcxLabel;
    CancelButton: TAdvSmoothToggleButton;
    OKButton: TAdvSmoothButton;
    lblDcAmtLable: TcxLabel;
    lblDcAmt: TcxLabel;
    HeaderPanel: TAdvPanel;
    lblTitle: TcxLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    KioskOrderMenu : Array of TOrderInfo;
    procedure SetOrderMenu;
  public
    AskPacking :Boolean;
    TableUse   :Boolean;
  end;

var
  KioskOrderConfirm_F: TKioskOrderConfirm_F;

implementation                                                                
uses Common_U, Const_U, Order_U, GlobalFunc_U, KioskTable_U;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TKioskOrderConfirm_F.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BlockInput(true);
end;

procedure TKioskOrderConfirm_F.FormCreate(Sender: TObject);
var vIndex, vCount :Integer;
    vFontSize :Integer;
begin
  DoubleBuffered := true;
  if Common.Config.BarrierFreeMode = bfWheelChair then
  begin
    Self.Position := poDesigned;
    Self.Width    := 1000;
    Self.Height   := Screen.Height - Common.Config.BarrierTop;
    Self.Top      := Common.Config.BarrierTop - 50;
    Self.Left     := Screen.Width div 2 - Self.ClientWidth div 2;
  end
  else
    Self.ClientHeight := Order_F.Height - Ifthen(Order_F.Height >= 1900, 400, 10);

  Common.LogoCreate(Self,0);
  Common.SetButtonColor(OKButton);

  HeaderPanel.Color         := $00FFC184;
  HeaderPanel.ColorMirror   := $00CC6600;
  HeaderPanel.ColorMirrorTo := $00F07800;
  HeaderPanel.ColorTo       := $00F07800;
  lblTitle.Style.TextColor    := clWhite;
  if GetOption(458) = '2' then
  begin
    HeaderPanel.Color         := $004C4C4C;
    HeaderPanel.ColorMirror   := $004C4C4C;
    HeaderPanel.ColorMirrorTo := $003B3B3B;
    HeaderPanel.ColorTo       := $003B3B3B;
    lblTitle.Style.TextColor    := clWhite;
  end
  else if GetOption(458) = '3' then
  begin
    HeaderPanel.Color         := $000000FB;
    HeaderPanel.ColorMirror   := $000000CC;
    HeaderPanel.ColorMirrorTo := $002222FF;
    HeaderPanel.ColorTo       := $002222FF;
    lblTitle.Style.TextColor    := clWhite;
  end
  else if GetOption(458) = '4' then
  begin
    HeaderPanel.Color         := $0059B300;
    HeaderPanel.ColorMirror   := $00448800;
    HeaderPanel.ColorMirrorTo := $00408000;
    HeaderPanel.ColorTo       := $00408000;
    lblTitle.Style.TextColor    := clWhite;
  end;

  SetLength(KioskOrderMenu, 20);
  vFontSize := 30;
  for vIndex := 0 to High(KioskOrderMenu) do
  begin
    //주문전체 그룹
    KioskOrderMenu[vIndex].GroupBox := TPanel.Create(Self);
    KioskOrderMenu[vIndex].GroupBox.Parent            := MenuGroupBox;
    KioskOrderMenu[vIndex].GroupBox.Align             := alTop;
    KioskOrderMenu[vIndex].GroupBox.BevelOuter        := bvNone;
    KioskOrderMenu[vIndex].GroupBox.ParentColor       := true;
    KioskOrderMenu[vIndex].GroupBox.Caption           := EmptyStr;
    KioskOrderMenu[vIndex].GroupBox.Height            := 60;

    //주메뉴
    KioskOrderMenu[vIndex].MainMenu                  := TcxLabel.Create(Self);
    KioskOrderMenu[vIndex].MainMenu.Parent           := KioskOrderMenu[vIndex].GroupBox;
    KioskOrderMenu[vIndex].MainMenu.Name             := Format('lbl_KioskMenu%d',[vIndex]);
    KioskOrderMenu[vIndex].MainMenu.AutoSize         := false;
    KioskOrderMenu[vIndex].MainMenu.Style.Font.Name  := Common.Config.KioskDefaultFontName;
    KioskOrderMenu[vIndex].MainMenu.Style.TextColor  := clBlack;
    KioskOrderMenu[vIndex].MainMenu.Style.Font.Size  := vFontSize;
    KioskOrderMenu[vIndex].MainMenu.Style.TextStyle  := [fsBold];
    KioskOrderMenu[vIndex].MainMenu.Transparent      := true;
    KioskOrderMenu[vIndex].MainMenu.Caption          := EmptyStr;
    KioskOrderMenu[vIndex].MainMenu.Top              := 0;
    KioskOrderMenu[vIndex].MainMenu.Left             := 18;
    KioskOrderMenu[vIndex].MainMenu.Height           := 57;
    KioskOrderMenu[vIndex].MainMenu.Width            := 570;

    //서브메뉴
    KioskOrderMenu[vIndex].SubMenu                  := TcxLabel.Create(Self);
    KioskOrderMenu[vIndex].SubMenu.Parent           := KioskOrderMenu[vIndex].GroupBox;
    KioskOrderMenu[vIndex].SubMenu.Name             := Format('lbl_KioskSubMenu%d',[vIndex]);
    KioskOrderMenu[vIndex].SubMenu.AutoSize         := false;
    KioskOrderMenu[vIndex].SubMenu.Style.Font.Name  := Common.Config.KioskDefaultFontName;
    KioskOrderMenu[vIndex].SubMenu.Style.TextColor  := clBlack;
    KioskOrderMenu[vIndex].SubMenu.Style.Font.Size  := vFontSize-2;
    KioskOrderMenu[vIndex].SubMenu.Transparent      := true;
    KioskOrderMenu[vIndex].SubMenu.Caption          := EmptyStr;
    KioskOrderMenu[vIndex].SubMenu.Top              := KioskOrderMenu[vIndex].MainMenu.Height;
    KioskOrderMenu[vIndex].SubMenu.Left             := 20;
    KioskOrderMenu[vIndex].SubMenu.Height           := 55;
    KioskOrderMenu[vIndex].SubMenu.Width            := 570;
    KioskOrderMenu[vIndex].SubMenu.Visible          := false;

    //주문수량
    KioskOrderMenu[vIndex].OrderQty                  := TcxLabel.Create(Self);
    KioskOrderMenu[vIndex].OrderQty.Parent           := KioskOrderMenu[vIndex].GroupBox;
    KioskOrderMenu[vIndex].OrderQty.Name             := Format('lbl_KioskOrderQty%d',[vIndex]);
    KioskOrderMenu[vIndex].OrderQty.AutoSize         := false;
    KioskOrderMenu[vIndex].OrderQty.Width            := 100;
    KioskOrderMenu[vIndex].OrderQty.Style.Font.Name  := Common.Config.KioskDefaultFontName;
    KioskOrderMenu[vIndex].OrderQty.Style.TextColor  := clBlack;
    KioskOrderMenu[vIndex].OrderQty.Style.Font.Size  := vFontSize;
    KioskOrderMenu[vIndex].OrderQty.Style.TextStyle  := [fsBold];
    KioskOrderMenu[vIndex].OrderQty.Transparent      := true;
    KioskOrderMenu[vIndex].OrderQty.Caption          := EmptyStr;
    KioskOrderMenu[vIndex].OrderQty.Top              := 1;
    KioskOrderMenu[vIndex].OrderQty.Left             := 670;
    KioskOrderMenu[vIndex].OrderQty.Height           := 57;
    KioskOrderMenu[vIndex].OrderQty.Properties.Alignment.Horz := taCenter;

    //주문금액
    KioskOrderMenu[vIndex].OrderAmt                  := TcxLabel.Create(Self);
    KioskOrderMenu[vIndex].OrderAmt.Parent           := KioskOrderMenu[vIndex].GroupBox;
    KioskOrderMenu[vIndex].OrderAmt.Name             := Format('lbl_KioskOrderAmt%d',[vIndex]);
    KioskOrderMenu[vIndex].OrderAmt.AutoSize         := false;
    KioskOrderMenu[vIndex].OrderAmt.Width            := 190;
    KioskOrderMenu[vIndex].OrderAmt.Style.Font.Name  := Common.Config.KioskDefaultFontName;
    KioskOrderMenu[vIndex].OrderAmt.Style.TextColor  := clBlack;
    KioskOrderMenu[vIndex].OrderAmt.Style.Font.Size  := vFontSize;
    KioskOrderMenu[vIndex].OrderAmt.Style.TextStyle  := [fsBold];
    KioskOrderMenu[vIndex].OrderAmt.Transparent      := true;
    KioskOrderMenu[vIndex].OrderAmt.Caption          := EmptyStr;
    KioskOrderMenu[vIndex].OrderAmt.Top              := 1;
    KioskOrderMenu[vIndex].OrderAmt.Left             := 770;
    KioskOrderMenu[vIndex].OrderAmt.Height           := 57;
    KioskOrderMenu[vIndex].OrderAmt.Properties.Alignment.Horz := taRightJustify;
  end;
end;

procedure TKioskOrderConfirm_F.FormShow(Sender: TObject);
var vIndex,
    vIndex1 :Integer;
begin
  Common.WriteLog('work', '주문확인-Show-begin');
  PlaySound(nil, 0, SND_MEMORY or SND_ASYNC);
  PlaySound(PChar('kioskwave8'), Common.DllHandle, SND_RESOURCE or SND_ASYNC);

  SetOrderMenu;
  Common.SetKioskButton(lblTitle);
  Common.SetKioskButton(lblAddStamp);
  Common.SetKioskButton(lblTotalStamp);
  Common.SetKioskButton(lblDcAmtLable);
  Common.SetKioskButton(CancelButton,'No');
  Common.SetKioskButton(OkButton,'Yes');

  lblDcAmt.Caption    := FormatFloat(',0 원',Common.PreSent.TotalDc);
  lblOrderAmt.Caption := FormatFloat(',0 원',Common.PreSent.WRcvAmt);
  lblOrderQty.Caption := GetOnlyNumber(Order_F.lbl_OrderCount.Caption) + '개';

  CancelButton.Caption    := Common.GetPaPago('나가기');
  OKButton.Caption        := Common.GetPaPago('주문확인');
  lblTitle.Caption        := Common.GetPaPago('주문하신 메뉴를 확인해주세요');
  lblAddStamp.Caption     := Common.GetPaPago('금회스템프');
  lblTotalStamp.Caption   := Common.GetPaPago('누적스템프');
  lblDcAmtLable.Caption   := Common.GetPaPago('할인금액');

  if GetOption(21)='0' then
  begin
    lblAddStamp.Visible        := false;
    lblAddStampCount.Visible   := false;
    lblTotalStamp.Visible      := false;
    lblTotalStampCount.Visible := false;
  end
  else
  begin
    lblAddStampCount.Caption   := Format('%d 개',[Common.PreSent.SaveStamp]);
    lblTotalStampCount.Caption := Format('%d 개',[Common.Member.Stamp+Common.PreSent.SaveStamp-Common.PreSent.UseStamp]);
  end;
  BlockInput(false);
  CloseTimer.Tag := 0;
  CloseTimer.Enabled := true;
  Common.WriteLog('work', '주문확인-Show-End');
end;

procedure TKioskOrderConfirm_F.OKButtonClick(Sender: TObject);
var vIndex : Integer;
    vIsTableSelected :Boolean;
label Loop;
begin
  BlockInput(true);
  Common.KioskTouchBeep('kioskwave12');
  if TableUse then
  begin
Loop:
    vIsTableSelected := false;
    with TKioskTable_F.Create(Self) do
      try
        case ShowModal of
          mrOK:
          begin
            InitTableRecord(Common.Table);
            OpenQuery('select NM_CODE1, '
                     +'       GetTableName(:P0, :P1) as NM_TABLE '
                     +'  from MS_CODE  '
                     +' where CD_STORE =:P0 '
                     +'   and CD_KIND  =''03'' '
                     +'   and CD_CODE  =:P2 ',
                     [Common.Config.StoreCode,
                      TableNo,
                      Common.Table.Floor]);
            if not Common.Query.Eof then
            begin
              Common.Table.FloorName  := Common.Query.Fields[0].AsString;
              Common.Table.Number     := TableNo;
              Common.Table.Name       := Common.Query.Fields[1].AsString;
              Common.Config.IsTakeOut := false;
              vIsTableSelected        := true;
            end
            else
              Common.ErrBox('선택한 테이블 존재하지 않습니다');
            Common.Query.Close;
          end;
          mrCancel : Exit;
        end;
      finally
        Free;
        BlockInput(false);
      end;

    if not vIsTableSelected then
    begin
      if Common.AskBox('테이블을 다시 선택하시겠습니까?',10) then
        goto Loop;

      if Common.AskBox('포장으로 이용하시겠습니까?',10) then
        Common.Config.IsTakeOut := true
      else
      begin
        BlockInput(false);
        Exit;
      end;
    end;
  end;
  BlockInput(false);
  ModalResult :=mrOK;
end;

procedure TKioskOrderConfirm_F.SetOrderMenu;
var vIndex, vRowIndex :Integer;
    vHeight :Integer;
    vTotHeight :Integer;
begin
  Common.WriteLog('work', '주문확인-SetOrderMenu-Begin');
  try
    for vIndex := 0 to High(KioskOrderMenu) do
    begin
      KioskOrderMenu[vIndex].GroupBox.Height     := 0;
      KioskOrderMenu[vIndex].SubMenu.Visible     := false;
    end;

    vIndex     := -1;
    with Order_F do
      if Main_sGrd.Cells[0,0] <> '' then
        For vRowIndex := 0 to Main_sGrd.RowCount-1 do
        begin
          if vIndex >= High(KioskOrderMenu) then Break;
          if Main_sGrd.Cells[GDM_CD_MENU1, vRowIndex] = '' then
          begin
            vIndex := vIndex+1;
            KioskOrderMenu[vIndex].MainMenu.Caption     := Common.GetPaPago(Main_sGrd.Cells[GDM_NM_MENU, vRowIndex]);
            KioskOrderMenu[vIndex].OrderQty.Caption     := Main_sGrd.Cells[GDM_VIEWQTY, vRowIndex];
            KioskOrderMenu[vIndex].OrderAmt.Caption     := FormatFloat(',0 원', StoI(Order_F.Main_sGrd.Cells[GDM_AMT, vRowIndex])
                                                                              - StoI(Order_F.Main_sGrd.Cells[GDM_DC_MENU, vRowIndex])
                                                                              - StoI(Order_F.Main_sGrd.Cells[GDM_DC_SPC, vRowIndex]));
            KioskOrderMenu[vIndex].GroupBox.Height      := KioskOrderMenu[vIndex].MainMenu.Height + 4;
            vHeight := KioskOrderMenu[vIndex].SubMenu.Height;
          end
          else
          begin
            if KioskOrderMenu[vIndex].SubMenu.Caption <> '' then
            begin
              if (Main_sGrd.Cells[GDM_VIEWQTY, vRowIndex] = '1') and (StoI(Main_sGrd.Cells[GDM_AMT, vRowIndex]) = 0) then
                KioskOrderMenu[vIndex].SubMenu.Caption := Common.GetPaPago(KioskOrderMenu[vIndex].SubMenu.Caption)+#13+Format('  %s ',[Common.GetPapago(Main_sGrd.Cells[GDM_NM_MENU, vRowIndex])])
              else if (Main_sGrd.Cells[GDM_VIEWQTY, vRowIndex] = '1') and (StoI(Main_sGrd.Cells[GDM_AMT, vRowIndex]) > 0) then
                KioskOrderMenu[vIndex].SubMenu.Caption := Common.GetPaPago(KioskOrderMenu[vIndex].SubMenu.Caption)+#13+Format('  %s   %s',[Common.GetPapago(Main_sGrd.Cells[GDM_NM_MENU, vRowIndex]), FormatFloat(',0 원',StoI(Main_sGrd.Cells[GDM_AMT, vRowIndex]))])
              else
                KioskOrderMenu[vIndex].SubMenu.Caption := Common.GetPaPago(KioskOrderMenu[vIndex].SubMenu.Caption)+#13+Format('  %s ( %s개 ) %s',[Common.GetPapago(Main_sGrd.Cells[GDM_NM_MENU, vRowIndex]),Main_sGrd.Cells[GDM_VIEWQTY, vRowIndex], FormatFloat(',0 원',StoI(Main_sGrd.Cells[GDM_AMT, vRowIndex]))]);
              KioskOrderMenu[vIndex].SubMenu.Height  := KioskOrderMenu[vIndex].SubMenu.Height + vHeight;
            end
            else
            begin
              if (Main_sGrd.Cells[GDM_VIEWQTY, vRowIndex] = '1') and (StoI(Main_sGrd.Cells[GDM_AMT, vRowIndex]) = 0) then
                KioskOrderMenu[vIndex].SubMenu.Caption := Format('  %s ',[Common.GetPaPago(Main_sGrd.Cells[GDM_NM_MENU, vRowIndex])])
              else if (Main_sGrd.Cells[GDM_VIEWQTY, vRowIndex] = '1') and (StoI(Main_sGrd.Cells[GDM_AMT, vRowIndex]) > 0) then
                KioskOrderMenu[vIndex].SubMenu.Caption := Format('  %s  %s',[Common.GetPaPago(Main_sGrd.Cells[GDM_NM_MENU, vRowIndex]), FormatFloat(',0 원',StoI(Main_sGrd.Cells[GDM_AMT, vRowIndex]))])
              else
                KioskOrderMenu[vIndex].SubMenu.Caption := Format('  %s ( %s개 ) %s',[Common.GetPaPago(Main_sGrd.Cells[GDM_NM_MENU, vRowIndex]),Main_sGrd.Cells[GDM_VIEWQTY, vRowIndex], FormatFloat(',0 원',StoI(Main_sGrd.Cells[GDM_AMT, vRowIndex]))]) ;
            end;
            KioskOrderMenu[vIndex].SubMenu.Visible   := true;
            KioskOrderMenu[vIndex].GroupBox.Height   := KioskOrderMenu[vIndex].MainMenu.Height + KioskOrderMenu[vIndex].SubMenu.Height + 4;
          end;
        end;

    vTotHeight := 0;
    for vIndex := 0 to High(KioskOrderMenu) do
      vTotHeight := vTotHeight + KioskOrderMenu[vIndex].GroupBox.Height;

    if vTotHeight < (Self.Height - 700) then
      Self.ClientHeight := vTotHeight + 700
    else
      Self.ClientHeight := Order_F.ClientHeight - 50;

    Common.WriteLog('work', '주문확인-SetOrderMenu-End');
  except
  end;
end;

procedure TKioskOrderConfirm_F.CancelButtonClick(Sender: TObject);
begin
  PlaySound(nil, 0, SND_MEMORY or SND_ASYNC);
  PlaySound(PChar('kioskwave12'), Common.DllHandle, SND_RESOURCE or SND_ASYNC);
  Close;
end;

procedure TKioskOrderConfirm_F.CloseTimerTimer(Sender: TObject);
begin
  CloseTimer.Tag := CloseTimer.Tag + 1;
  if CloseTimer.Tag > 60 then
  begin
    CloseTimer.Enabled := false;
    Close;
  end
  else
    CancelButton.Status.Caption := IntToStr(60-CloseTimer.Tag);
end;

end.
