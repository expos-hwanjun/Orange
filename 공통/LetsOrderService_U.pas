unit LetsOrderService_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, cxControls,
  cxContainer, cxEdit, cxLabel, cxGraphics, cxLookAndFeels, Uni,
  cxLookAndFeelPainters, PosCard, AdvSmoothButton, AdvGlassButton, AdvShape,
  MMSystem, dxGDIPlusClasses, cxImage, DateUtils;

type
  TLetsOrderService_F = class(TForm)
    Shape1: TShape;
    TableNoLabel: TcxLabel;
    TitleLabel: TLabel;
    ServiceMessageLabel: TcxLabel;
    LogoImage: TImage;
    TitelShape: TAdvShape;
    MenuNameLabel: TcxLabel;
    MenuQtyLabel: TcxLabel;
    CloseTimer: TTimer;
    ReceiptNoLabel: TLabel;
    ElapsedTimer: TTimer;
    YesButton: TAdvSmoothButton;
    CallListButton: TAdvSmoothButton;
    procedure FormShow(Sender: TObject);
    procedure YesButtonClick(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
    procedure ElapsedTimerTimer(Sender: TObject);
    procedure CallListButtonClick(Sender: TObject);
  private
    AutoCloseMinute :Integer;
    CallTime :TDateTime;
    ElapsedTime :Integer;
    MsgTxt  :String;
  public
    Msg :String;
  end;

var
  LetsOrderService_F: TLetsOrderService_F;

implementation
uses Common_U, Const_U, GlobalFunc_U, DBModule_U, LetsOrderCallList_U;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TLetsOrderService_F.CallListButtonClick(Sender: TObject);
begin
  YesButtonClick(nil);
  LetsOrderCallList_F := TLetsOrderCallList_F.Create(Self);
  try
    LetsOrderCallList_F.ShowModal;
  finally
    FreeAndNil(LetsOrderCallList_F);
  end;
end;

procedure TLetsOrderService_F.CloseTimerTimer(Sender: TObject);
begin
  CloseTimer.Tag := CloseTimer.Tag + 1;
  if CloseTimer.tag >= AutoCloseMinute then
  begin
    CloseTimer.Enabled     := false;
    ElapsedTimer.Enabled   := false;
    LetsOrderService_F.Hide;
  end
  else
    YesButton.Status.Caption := IntToStr(AutoCloseMinute - CloseTimer.Tag);
end;

procedure TLetsOrderService_F.ElapsedTimerTimer(Sender: TObject);
begin
  ElapsedTime := ElapsedTime + 1;
end;

procedure TLetsOrderService_F.FormShow(Sender: TObject);
var vTableName :String;
    vQuery  : TUniQuery;
begin
  BlockInput(false);
  if not Assigned(Common) then Exit;

  if not Assigned(LetsOrderCallList_F) then
    CallListButton.Visible := true
  else
    CallListButton.Visible := false;

  if Common.Config.Style = 'D' then
  begin
    Common.SetButtonColor(TitelShape);
    Common.SetButtonColor(YesButton);
    Common.SetButtonColor(YesButton);
  end;

  if FileExists(ExtractFilePath(Application.ExeName)+'dll\Logo.png') then
    LogoImage.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'dll\Logo.png');

  if (CopyPos(Msg,#28,0) = '호출') then
  begin
    try
      vQuery := TUniQuery.Create(Self);
      vQuery.Connection := dm.UniConnection;
      vQuery.SQL.Text := 'select a.NM_TABLE, '
                        +'       b.NM_CODE1 '
                        +'  from MS_TABLE a inner join '
                        +'       MS_CODE  b on a.CD_STORE = b.CD_STORE '
                        +'                 and b.CD_KIND  = ''03'' '
                        +'                 and a.CD_FLOOR = b.CD_CODE '
                        +' where a.CD_STORE =:P0  '
                        +'   and a.NO_TABLE =:P1';
      vQuery.ParamByName('P0').AsString  := Common.Config.StoreCode;
      vQuery.ParamByName('P1').AsInteger := StrToInt(GetOnlyNumber(CopyPos(Msg,#28,1)));
      vQuery.Open;
      vTableName := Format('%s - %s ',[vQuery.Fields[1].AsString, vQuery.Fields[0].AsString]);

    finally
      vQuery.Close;
      vQuery.Free;
    end;
  end
  else
    vTableName := CopyPos(Msg,#28,1);

  TableNoLabel.Visible        := true;
  CloseTimer.Enabled          := true;
  TitelShape.ShapeWidth       := Self.Width;
  TitleLabel.Caption          := '렛츠오더';
  TableNoLabel.Caption        := vTableName;
  CallTime                    := Now();
  ElapsedTime                 := 0;
  ElapsedTimer.Enabled        := true;
  ReceiptNoLabel.Caption      := '';
  MenuNameLabel.Top           := 144;
  MenuQtyLabel.Top            := 144;
  MenuNameLabel.Height        := 221;
  MenuQtyLabel.Height         := 221;
  if CopyPos(Msg,#28,0) = '호출' then
  begin
    Common.WriteLog('work',Format('렛츠오더호출[%s]-%s',[vTableName, CopyPos(Msg,#28,2)]));
    ServiceMessageLabel.Caption := CopyPos(Msg,#28,2);
    ServiceMessageLabel.Top     := 144;
    ServiceMessageLabel.Left    := 18;
    ServiceMessageLabel.Visible := true;
    ServiceMessageLabel.Height  := 219;
    ServiceMessageLabel.Width   := 551;
    MenuNameLabel.Visible       := false;
    MenuQtyLabel.Visible        := false;
//    Application.ProcessMessages;
    if (not Common.IsDBServer or (Common.Config.LetsOrderCall = '0')) and FileExists(ExtractFilePath(Application.ExeName)+'\Dll\LetsOrder_Call.wav') then
      sndPlaySound(PChar(ExtractFilePath(Application.ExeName)+'\Dll\LetsOrder_Call.wav'), SND_NODEFAULT or SND_ASYNC);

    MsgTxt := Msg;
  end
  else
  begin
    if CopyPos(Msg,#28,0) = '결제' then
    begin
      TableNoLabel.visible         := false;
      ReceiptNoLabel.Caption       := CopyPos(Msg,#28,1);
      MenuNameLabel.Top            := 59;
      MenuQtyLabel.Top             := 59;
      MenuNameLabel.Height         := 306;
      MenuQtyLabel.Height          := 306;
    end
    else if CopyPos(Msg,#28,0) = '온라인' then
    begin
      ReceiptNoLabel.Caption       := CopyPos(Msg,#28,1);
      TableNoLabel.visible         := true;
      TableNoLabel.Caption         := '온라인 주문'
    end
    else
    begin
      if (not Common.IsDBServer or (Common.Config.LetsOrderCall = '0')) and FileExists(ExtractFilePath(Application.ExeName)+'\Dll\LetsOrder_Order.wav') then
        sndPlaySound(PChar(ExtractFilePath(Application.ExeName)+'\Dll\LetsOrder_Order.wav'), SND_NODEFAULT or SND_ASYNC);
    end;
    ServiceMessageLabel.Visible := false;
    MenuNameLabel.Caption := CopyPos(Msg,#28,2);
    MenuQtyLabel.Caption  := CopyPos(Msg,#28,3);
    MenuNameLabel.Top     := 144;
    MenuNameLabel.Left    := 18;
    MenuNameLabel.Visible := true;
    MenuNameLabel.Height  := 219;
    MenuNameLabel.Width   := 446;
    MenuQtyLabel.Top      := 144;
    MenuQtyLabel.Left     := 473;
    MenuQtyLabel.Visible  := true;
    MenuQtyLabel.Height   := 219;
    MenuQtyLabel.Width    := 86;
  end;

  CloseTimer.Enabled := false;
  CloseTimer.Tag     := 0;
  YesButton.Status.Caption := '';
  if GetOption(83) = '1' then
    AutoCloseMinute     := 10
  else if GetOption(83) = '2' then
    AutoCloseMinute     := 20
  else if GetOption(83) = '3' then
    AutoCloseMinute     := 30;
  if GetOption(83) <> '4' then
    CloseTimer.Enabled  := true;
end;

procedure TLetsOrderService_F.YesButtonClick(Sender: TObject);
begin
  ElapsedTimer.Enabled        := false;
  Common.WriteLog('work', MsgTxt);
  if CopyPos(MsgTxt,#28,0) = '호출' then
    ExecQuery('update SL_LETSORDER_CALL inner join '
             +'      (select YMD_CALL, '
             +'              SEQ '
             +'         from SL_LETSORDER_CALL '
             +'        where CD_STORE = :P0 '
             +'          and NO_TABLE = :P1 '
             +'          and TXT_CALL = :P2 '
             +'       order by YMD_CALL desc, SEQ desc '
             +'       limit 1) as t on t.YMD_CALL = SL_LETSORDER_CALL.YMD_CALL '
             +'                    and t.SEQ      = SL_LETSORDER_CALL.SEQ '
             +'   set SL_LETSORDER_CALL.DS_STATUS = ''1'' '
             +' where SL_LETSORDER_CALL.CD_STORE  = :P0 ',
             [Common.Config.StoreCode,
              StrToInt(GetOnlyNumber(CopyPos(MsgTxt,#28,1))),
              CopyPos(MsgTxt,#28,2)]);

  CloseTimer.Enabled := false;
  LetsOrderService_F.Hide;
end;

end.

