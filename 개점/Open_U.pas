unit Open_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  StdCtrls, Mask, DB,  ExtCtrls, KeyPad_F, Menus,
  cxLookAndFeelPainters, cxButtons, DateUtils, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxCurrencyEdit, StrUtils, MemDS, DBAccess, Uni,
  cxGraphics, cxLookAndFeels, AdvGlassButton, dxGDIPlusClasses, cxLabel,
  cxMaskEdit, AdvPanel, AdvSmoothButton, MaskUtils;
type
    TWorkKind = (wkOpen, wkReady);
type
  TOpen_F = class(TForm)
    fmKeyPad1: TfmKeyPad;
    CloseTimer: TTimer;
    NowDateEdit: TcxMaskEdit;
    OpenDateEdit: TcxMaskEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    ReadyLabel: TcxLabel;
    MessageLabel: TLabel;
    Image3: TImage;
    CloseButton: TcxButton;
    TitleLabel: TLabel;
    ReadyPanel: TAdvPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    _50000Edit: TcxCurrencyEdit;
    _10000Edit: TcxCurrencyEdit;
    _5000Edit: TcxCurrencyEdit;
    _1000Edit: TcxCurrencyEdit;
    _500Edit: TcxCurrencyEdit;
    _100Edit: TcxCurrencyEdit;
    _50Edit: TcxCurrencyEdit;
    _10Edit: TcxCurrencyEdit;
    _TotalAmtEdit: TcxCurrencyEdit;
    _50000AmtEdit: TcxCurrencyEdit;
    _10000AmtEdit: TcxCurrencyEdit;
    _5000AmtEdit: TcxCurrencyEdit;
    _1000AmtEdit: TcxCurrencyEdit;
    _500AmtEdit: TcxCurrencyEdit;
    _100AmtEdit: TcxCurrencyEdit;
    _50AmtEdit: TcxCurrencyEdit;
    _10AmtEdit: TcxCurrencyEdit;
    SubtractButton: TcxButton;
    OpenCancelButton: TAdvSmoothButton;
    OkButton: TAdvSmoothButton;
    ReadyInButton: TAdvSmoothButton;
    OpenPriceButton: TAdvSmoothButton;
    CashDrawerOpenButton: TAdvSmoothButton;
    ReadySaveButton: TAdvSmoothButton;
    Subtract2Button: TcxButton;
    TotalAmtEdit: TcxCurrencyEdit;
    ReadyCloseButton: TcxButton;
    cxLabel3: TcxLabel;
    ReadyAmtEdit: TcxCurrencyEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
    procedure OpenCancelButtonClick(Sender: TObject);
    procedure CashDrawerOpenButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure OpenPriceButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure OpenDateEditExit(Sender: TObject);
    procedure SubtractButtonClick(Sender: TObject);
    procedure _50000EditExit(Sender: TObject);
    procedure ReadySaveButtonClick(Sender: TObject);
    procedure ReadyInButtonClick(Sender: TObject);
    procedure _50000EditPropertiesChange(Sender: TObject);
    procedure ReadyCloseButtonClick(Sender: TObject);
  private
    FWorkKind : TWorkKind;
    ClickTime :TDateTime;
    NowDateStr,
    OpenDateStr : String;
    procedure CashCompute;
    function  SavePosOpen:Boolean;
    procedure SetWorkKind(AValue:TWorkKind);
    property  WorkKind       :TWorkKind read FWorkKind       write SetWorkKind;
  public
    { Public declarations }
  end;

var
  Open_F: TOpen_F;

implementation
uses Common_U, GlobalFunc_U, OpenPrice_U, Math, DBModule_U, Const_U;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';


procedure TOpen_F.FormCreate(Sender: TObject);
var vIndex :Integer;
begin
  Common.LogoCreate(Self,2);
  if not Common.Config.IsKiosk then
  begin
    for vIndex := 0 to ComponentCount-1 do
      if Components[vIndex] is TAdvSmoothButton then
        Common.SetButtonColor((Components[vIndex] as TAdvSmoothButton));
   if Common.Config.Style = 'D' then
     ReadyPanel.Caption.Color := clBlack;
  end;
  if Common.Config.IsKiosk then
  begin
    ReadyLabel.Visible           := false;
    TotalAmtEdit.Visible         := false;
    Subtract2Button.Visible      := false;
    ReadyInButton.Visible        := false;
    OpenPriceButton.Visible      := false;
  end;
  NowDateEdit.Text  := Common.NowDate;
  OpenDateEdit.Text := Common.WorkDate;
  //두번눌리는현상 방지
  ClickTime         := IncSecond(Now,-3);
end;

procedure TOpen_F.FormShow(Sender: TObject);
begin
  BlockInput(false);
  Application.ProcessMessages;
  if Common.Config.IsKiosk then
    WorkKind := wkOpen
  else
    case Common.PosType of
      ptNotAccount :
      begin
        WorkKind := wkOpen;
        _TotalAmtEdit.Value := Common.Config.Amt_DefReady;
        TotalAmtEdit.Value  := Common.Config.Amt_DefReady;
        ReadyAmtEdit.Value  := 0;
      end;
      ptAccount    :  WorkKind := wkReady;
    end;
  if not Common.Config.IsKiosk then
    Common.SetLanguage(Self);
end;

function TOpen_F.SavePosOpen: Boolean;
begin
  try
    Common.BeginTran;
    ExecQuery('insert into SL_POSCLOSE(CD_STORE, '
             +'                        YMD_CLOSE, '
             +'                        NO_POS, '
             +'                        DS_STATUS) '
             +'                 values(:P0, '
             +'                        :P1, '
             +'                        :P2, '
             +'                        ''O'') ',
             [Common.Config.StoreCode,
              OpenDateStr,
              Common.Config.PosNo]);

    Common.CommitTran;
    Result := true;
  except
    on E: Exception do
    begin
      Common.RollbackTran;
      Common.WriteLog('SavePosOpen',E.Message);
      Common.ErrBox(E.Message);
      Result := false;
    end;
  end;
end;

procedure TOpen_F.SetWorkKind(AValue: TWorkKind);
var vTemp :String;
begin
  FWorkKind := AValue;
  case FWorkKind of
    wkOpen :
     begin
       OkButton.Visible         := true;
       OpenCancelButton.Visible := False;
       OpenPriceButton.Visible  := False;
       ReadyInButton.Visible    := false;
       TitleLabel.Caption       := Common.GetPaPago('개점');
       if (Common.PosType = ptNotAccount) or Common.Config.IsKiosk then
       begin
         OpenDateEdit.Enabled  := True;
         if not Common.Config.IsKiosk then
         begin
           _TotalAmtEdit.Value := Common.Config.Amt_DefReady;
           TotalAmtEdit.Value  := Common.Config.Amt_DefReady;
           ReadyAmtEdit.Value  := 0;
         end;

         if Common.WorkDate = '' then
         begin
           OpenQuery('select max(YMD_CLOSE) '
                    +'  from SL_POSCLOSE '
                    +' where CD_STORE =:P0 '
                    +'   and NO_POS   =:P1',
                    [Common.Config.StoreCode,
                     Common.Config.PosNo]);
           if not Common.Query.Eof then
           begin
             vTemp := Common.Query.Fields[0].AsString;
             if vTemp <> '' then
             begin
               if IncDay( StoD(vTemp), 1) < now () then
                 OpenDateEdit.Text     := NowDateEdit.Text
               else
                 OpenDateEdit.Text := DtoS(IncDay( StoD(vTemp), 1));
             end
             else OpenDateEdit.Text := NowDateEdit.Text;
           end
           else OpenDateEdit.Text     := NowDateEdit.Text;
         end
         else if Common.Config.IsKiosk then
         begin
           OkButton.Visible         := false;
           OpenCancelButton.Visible := true;
         end;

         if not Common.Config.IsKiosk then
           OpenDateEdit.SetFocus;
         OpenPriceButton.Enabled := false;
       end
       else
       begin
         OpenDateEdit.Enabled  := true;
       end;
     end;
     wkReady :
     begin
       OpenCancelButton.Visible := true;
       if not Common.Config.IsKiosk then
         OpenPriceButton.Visible := True;
       if not Common.Config.IsKiosk then
         CashDrawerOpenButton.Visible   := True;
       OpenQuery('select Ifnull(sum(AMT_READY),0) AMT_READY '
                +'  from SL_CASHIER_MGM '
                +' where CD_STORE =:P0 '
                +'   and YMD_CLOSE=:P1 '
                +'   and NO_POS   =:P2 '
                +'   and CD_SAWON =:P3 '
                +'   and YN_CLOSE = ''N'' ',
                [Common.Config.StoreCode,
                 Common.WorkDate,
                 Common.Config.PosNo,
                 Common.Config.UserCode]);
       ReadyAmtEdit.Value := Common.Query.Fields[0].AsInteger;
       TotalAmtEdit.Tag   := Common.Query.Fields[0].AsInteger;
       TotalAmtEdit.EditModified := false;
       Common.Query.Close;

       OpenDateEdit.Enabled     := false;
       TotalAmtEdit.Enabled     := true;
       Subtract2Button.Enabled  := true;
       OpenCancelButton.Visible := true;
       OkButton.Visible         := false;
       if not Common.Config.IsKiosk then
         ReadyInButton.Visible := true;
       OpenDateEdit.Enabled  := true;
       MessageLabel.Caption := Format(' %s로 개점 상태입니다. 준비금을 등록해주세요',[FormatMaskText('!0000년90월90일;0; ',Common.WorkDate)]);
     end;
  end;
end;

procedure TOpen_F.SubtractButtonClick(Sender: TObject);
begin
  if Sender = SubtractButton then
  begin
    _TotalAmtEdit.Value := _TotalAmtEdit.Value * -1;
    _TotalAmtEdit.SetFocus;
    _TotalAmtEdit.SelStart := Length(_TotalAmtEdit.Text);
  end
  else
  begin
    TotalAmtEdit.Value := TotalAmtEdit.Value * -1;
    TotalAmtEdit.EditModified := true;
    TotalAmtEdit.SetFocus;
    TotalAmtEdit.SelStart := Length(TotalAmtEdit.Text);
  end;
end;

procedure TOpen_F._50000EditExit(Sender: TObject);
begin
  if Sender = _50000Edit then
    _50000AmtEdit.Value := _50000Edit.Value * 50000
  else if Sender = _10000Edit then
    _10000AmtEdit.Value := _10000Edit.Value * 10000
  else if Sender = _10000Edit then
    _5000AmtEdit.Value := _5000Edit.Value * 5000
  else if Sender = _10000Edit then
    _1000AmtEdit.Value := _1000Edit.Value * 1000
  else if Sender = _500Edit then
    _500AmtEdit.Value := _500Edit.Value * 500
  else if Sender = _100Edit then
    _100AmtEdit.Value := _100Edit.Value * 100
  else if Sender = _50Edit then
    _50AmtEdit.Value := _50Edit.Value * 50
  else if Sender = _10Edit then
    _10AmtEdit.Value := _10Edit.Value * 10;
  CashCompute;
end;

procedure TOpen_F._50000EditPropertiesChange(Sender: TObject);
begin
  if Sender = _50000Edit then
    _50000AmtEdit.Value := _50000Edit.EditingValue * 50000
  else if Sender = _10000Edit then
    _10000AmtEdit.Value := _10000Edit.EditingValue * 10000
  else if Sender = _10000Edit then
    _5000AmtEdit.Value := _5000Edit.EditingValue * 5000
  else if Sender = _10000Edit then
    _1000AmtEdit.Value := _1000Edit.EditingValue * 1000
  else if Sender = _500Edit then
    _500AmtEdit.Value := _500Edit.EditingValue * 500
  else if Sender = _100Edit then
    _100AmtEdit.Value := _100Edit.EditingValue * 100
  else if Sender = _50Edit then
    _50AmtEdit.Value := _50Edit.EditingValue * 50
  else if Sender = _10Edit then
    _10AmtEdit.Value := _10Edit.EditingValue * 10;
  CashCompute;
end;

procedure TOpen_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case Key of
     VK_ESCAPE : CloseButton.Click;
     VK_UP   :  SelectNext(TWinControl(ActiveControl), false,  true);
     VK_DOWN,
     VK_RETURN :
     begin
       SelectNext(TWinControl(ActiveControl), true,  true);
       Key := 0;
     end;
   end;
end;

procedure TOpen_F.OkButtonClick(Sender: TObject);
var vTemp :String;
begin
  if MilliSecondsBetween(Now(),ClickTime) < 1500 then Exit;
  ClickTime := now;

  NowDateStr  := GetOnlyNumber(NowDateEdit.Text);
  OpenDateStr := GetOnlyNumber(OpenDateEdit.Text);
  case WorkKind of
    wkOpen :
      begin
        if not IsDate(OpenDateStr) then
        begin
          Common.MsgBox('개점일자를 정확히 입력하세요');
          Exit;
        end;

        if (IncDay(StoD(NowDateStr),-2) >= StoD(OpenDateStr))  then
        begin
          Common.ErrBox('시스템일자보다 2일전 일자로는'+#13#13+'개점할 수 없습니다');
          Exit;
        end;

        if ( IncDay(StoD(NowDateStr),2) <= StoD(OpenDateStr )) then
        begin
          Common.ErrBox('시스템일자보다 2일 이상 일자로는'+#13#13+'개점할 수 없습니다');
          Exit;
        end;

        if NowDateStr <> OpenDateStr then
        begin
          if not Common.AskBox('시스템일자와 개점일자가 같지 않습니다'+#13+'개점을 하시겠습니까?') then Exit;
        end;

        try
          OpenQuery('select DS_STATUS '
                   +'  from SL_POSCLOSE '
                   +' where CD_STORE  =:P0 '
                   +'   and YMD_CLOSE =:P1 '
                   +'   and NO_POS    =:P2 ',
                   [Common.Config.StoreCode,
                    OpenDateStr,
                    Common.Config.PosNo]);
          if Common.Query.Eof then
          begin
            Common.Query.Close;
            if not SavePosOpen then Exit;
          end
          else
          begin
            if Common.Query.Fields[0].AsString = 'C' then
            begin
              Common.Query.Close;
              Common.ErrBox('마감이 완료된 일자입니다');
              Exit;
            end
            else if (Common.Query.Fields[0].AsString = 'O') then
            begin
              OpenQuery('select StoD(YMD_CLOSE), '
                       +'       NO_POS '
                       +'  from SL_POSCLOSE '
                       +' where CD_STORE =:P0 '
                       +'   and YMD_CLOSE < :P1 '
                       +'   and DS_STATUS =''O'' '
                       +' limit 1 ',
                      [Common.Config.StoreCode,
                       OpenDateStr]);
              if not Common.Query.Eof then
              begin
                Common.Query.Close;
                Common.ErrBox(Format('%s일 %s포스가 마감되지 않았습니다'#13'마감 후에 개점을 해야합니다',[Common.Query.Fields[0].AsString,
                                                                                                          Common.Query.Fields[1].AsString]));
                Exit;
              end
              else
              begin
                Common.WorkDate := OpenDateStr;
                Common.OpenDate := Common.WorkDate;
                Common.ErrBox('개점된 일자입니다');
                Exit;
              end;
            end;
          end;
        except
          on E:Exception do
          begin
            Common.WriteLog('개점',E.Message);
            Common.ErrBox(E.Message+#13#13+'개점을 완료하지 못했습니다');
            Exit;
          end;
        end;
        Common.WorkDate := OpenDateStr;
        Common.OpenDate := Common.WorkDate;

        //기본준비금을 입력한다
        if (TotalAmtEdit.Value > 0) and not Common.Config.IsKiosk then
          if not Common.SaveReadyAmt(TotalAmtEdit.Value) then Exit;

        if not Common.Config.IsKiosk and (TotalAmtEdit.Value = 0) then
          WorkKind        := wkReady;
        Common.PosType  := ptAccount;
        Common.MsgBox('개점처리가 완료됐습니다');

        if Common.Config.IsKiosk then
        begin
          Close;
          Exit;
        end;


        //개점시 싯가금액 입력
        if (GetOption(239) = '1') then
          OpenPriceButtonClick(nil);

        if (TotalAmtEdit.Value > 0) or (GetOption(268)='1') then
          Close
        else if Common.Config.Amt_DefReady > 0 then
          Close
        else if not Common.AskBox('준비금을 입력하시겠습니까?') then
          Close
        else
          ReadyInButtonClick(nil);
      end;
  end;
end;

procedure TOpen_F.OpenCancelButtonClick(Sender: TObject);
begin
  if not Common.AskBox('개점을 취소하시겠습니까?') then Exit;
  OpenQuery('select count(*) cnt '
           +'  from SL_SALE_H '
           +' where CD_STORE =:P0 '
           +'   and YMD_SALE =:P1 '
           +'   and NO_POS   =:P2',
           [Common.Config.StoreCode,
            Common.WorkDate,
            Common.Config.PosNo]);

  if Common.Query.Fields[0].AsInteger > 0 then
  begin
    Common.ErrBox('매출내역이 있습니다'+#13#13+'매출내역이 있으면'#13'개점을 취소할 수 없습니다');
    Exit;
  end;

  ExecQuery('delete '
           +'  from SL_POSCLOSE '
           +' where CD_STORE  =:P0 '
           +'   and YMD_CLOSE =:P1 '
           +'   and NO_POS    =:P2',
           [Common.Config.StoreCode,
            Common.WorkDate,
            Common.Config.PosNo]);

  ExecQuery('delete '
           +'  from SL_CASHIER_MGM '
           +' where CD_STORE  =:P0 '
           +'   and YMD_CLOSE =:P1 '
           +'   and NO_POS    =:P2',
           [Common.Config.StoreCode,
            Common.WorkDate,
            Common.Config.PosNo]);
  if Common.PosType <> ptOnlyOrder then
    Common.PosType := ptNotAccount;
  WorkKind := wkOpen;
  Common.WorkDate  := '';
  Common.OpenDate  := '';
  TotalAmtEdit.Enabled    := false;
  Subtract2Button.Enabled := false;
  Common.MsgBox('개점이 취소되었습니다');
end;

procedure TOpen_F.OpenDateEditExit(Sender: TObject);
begin
  if not IsDate(GetOnlyNumber(OpenDateEdit.Text)) then
  begin
    Common.ErrBox('일자가 잘못 입력되었습니다.');
    OpenDateEdit.SetFocus;
  end;
end;

procedure TOpen_F.OpenPriceButtonClick(Sender: TObject);
begin
  OpenPrice_F := TOpenPrice_F.Create(Self);
  OpenPrice_F.Left := Trunc(Screen.Monitors[Common.PrimaryMonitors].Width / 2  - OpenPrice_F.Width / 2);
  OpenPrice_F.Top  := Trunc(Screen.Monitors[Common.PrimaryMonitors].Height / 2 - OpenPrice_F.Height / 2);
  try
    OpenPrice_F.ShowModal;
  finally
    FreeAndNil(OpenPrice_F);
  end;
end;

procedure TOpen_F.ReadyCloseButtonClick(Sender: TObject);
begin
  ReadyPanel.Visible := false;
end;

procedure TOpen_F.ReadyInButtonClick(Sender: TObject);
begin
  if not ReadyPanel.Visible then
  begin
    if not TotalAmtEdit.EditModified then
    begin
      ReadyPanel.Left := 5;
      ReadyPanel.Top  := 0;
      ReadyPanel.Visible := true;
      _TotalAmtEdit.SetFocus;
    end
    else
    begin
      if (TotalAmtEdit.Value > 0) and not Common.AskBox(Format('기존 준비금에 %s 추가합니다',[FormatFloat(',0원',TotalAmtEdit.Value)])) then Exit;

      _TotalAmtEdit.Value := TotalAmtEdit.Value;
      ReadySaveButtonClick(nil);
      Close;
    end;
  end
  else
    ReadyPanel.Visible := false;
end;

procedure TOpen_F.ReadySaveButtonClick(Sender: TObject);
begin
  if _TotalAmtEdit.EditingValue = 0 then
  begin
    Common.ErrBox('준비금 금액을 입력하세요');
    Exit;
  end;
  if (Sender <> nil) and (TotalAmtEdit.Tag > 0) and not Common.AskBox(Format('기존 준비금에 %s 추가합니다',[FormatFloat(',0원',_TotalAmtEdit.EditingValue)])) then Exit;

  if not Common.SaveReadyAmt(_TotalAmtEdit.EditingValue) then Exit;

  if Common.AskBox('준비금 영수증을'#13'출력하시겠습니까?') then
    Common.Device.Ready_Prt(_TotalAmtEdit.EditingValue, TotalAmtEdit.Tag);

  Close;
end;

procedure TOpen_F.CashCompute;
var
  vTotalAmt :Double;
begin
  _50000Edit.PostEditValue;
  _10000Edit.PostEditValue;
  _5000Edit.PostEditValue;
  _1000Edit.PostEditValue;
  _500Edit.PostEditValue;
  _100Edit.PostEditValue;
  _50Edit.PostEditValue;
  _10Edit.PostEditValue;

  vTotalAmt  :=  (_50000Edit.Value * 50000)
               + (_10000Edit.Value * 10000)
               + (_5000Edit.Value  * 5000)
               + (_1000Edit.Value  * 1000)
               + (_500Edit.Value   * 500)
               + (_100Edit.Value   * 100)
               + (_50Edit.Value    * 50)
               + (_10Edit.Value    * 10);

  _50000AmtEdit.Value         := _50000Edit.Value * 50000;
  _10000AmtEdit.Value         := _10000Edit.Value * 10000;
  _5000AmtEdit.Value          := _5000Edit.Value  * 5000;
  _1000AmtEdit.Value          := _1000Edit.Value  * 1000;
  _500AmtEdit.Value           := _500Edit.Value   * 500;
  _100AmtEdit.Value           := _100Edit.Value   * 100;
  _50AmtEdit.Value            := _50Edit.Value    * 50;
  _10AmtEdit.Value            := _10Edit.Value    * 10;
  _TotalAmtEdit.Value         := vTotalAmt;
end;

procedure TOpen_F.CashDrawerOpenButtonClick(Sender: TObject);
begin
  Common.Device.CashBoxOpen;
end;

procedure TOpen_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TOpen_F.CloseTimerTimer(Sender: TObject);
begin
  CloseTimer.Enabled := false;
  Close;
end;

end.
