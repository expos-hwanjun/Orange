unit Deposit_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ExtCtrls, DB,
  KeyPad_F, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxCurrencyEdit, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  cxButtons, cxLabel, AdvGlassButton, dxGDIPlusClasses, AdvSmoothButton;

type
  TDeposit_F = class(TForm)
    fmKeyPad1: TfmKeyPad;
    DepositAmtEdit: TcxCurrencyEdit;
    cxLabel2: TcxLabel;
    TotalDepositAmtLabel: TcxLabel;
    cxLabel3: TcxLabel;
    CloseButton: TcxButton;
    Image3: TImage;
    MessageLabel: TLabel;
    TitleLabel: TLabel;
    OkButton: TAdvSmoothButton;
    CashDrawerOpenButton: TAdvSmoothButton;
    SubtractButton: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cedt_CheckKeyPress(Sender: TObject; var Key: Char);
    procedure OkButtonClick(Sender: TObject);
    procedure CashDrawerOpenButtonClick(Sender: TObject);
    procedure SubtractButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Deposit_F: TDeposit_F;

implementation
uses Common_U, GlobalFunc_U, DBModule_U, Const_U;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TDeposit_F.FormCreate(Sender: TObject);
begin
  BlockInput(false);
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(CashDrawerOpenButton);
  Common.SetButtonColor(OkButton);
  if GetOption(385) = '1' then
  begin
    fmKeyPad1.Num_000.Visible := false;
    fmKeyPad1.Num_00.Visible  := true;
    fmKeyPad1.Num_00.Top      := fmKeyPad1.Num_000.Top;
    fmKeyPad1.Num_00.Left     := fmKeyPad1.Num_000.Left;
  end;
end;

procedure TDeposit_F.FormShow(Sender: TObject);
begin
  OpenQuery('select AMT_MID_CASH '
           +'  from SL_CASHIER_MGM '
           +' where CD_STORE =:P0 '
           +'   and YMD_CLOSE=:P1 '
           +'   and NO_POS   =:P2 '
           +'   and CD_SAWON =:P3 '
           +'   and YN_CLOSE =''N'' ',
           [Common.Config.StoreCode,
            Common.WorkDate,
            Common.Config.PosNo,
            Common.Config.UserCode]);

  TotalDepositAmtLabel.Caption := FormatFloat('#,0', Common.Query.Fields[0].AsInteger);
  Common.Query.Close;

  if not Common.Config.IsKiosk then
    Common.SetLanguage(Self);
  DepositAmtEdit.SetFocus;
end;

procedure TDeposit_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE : CloseButton.Click;
    VK_F10  :  if (ActiveControl is TCustomEdit) then TCustomEdit(ActiveControl).Clear;
  end;
end;

procedure TDeposit_F.OkButtonClick(Sender: TObject);
var vSeq, vCnt :Integer;
begin
  DepositAmtEdit.PostEditValue;
  if (DepositAmtEdit.Value) = 0 then
  begin
    Common.ErrBox('중간출금 금액을 입력하세요');
    Exit;
  end;

  try
    OpenQuery('select Ifnull(Max(SEQ), (select Ifnull(MAX(SEQ),0)+1 '
             +'                           from SL_CASHIER_MGM '
             +'                          where CD_STORE 	=:P0 '
             +'                            and YMD_CLOSE	=:P1 '
             +'                            and NO_POS	    =:P2 '
             +'                            and CD_SAWON	  =:P3 '
             +'                            and YN_CLOSE	=''Y'')) '
             +'  from SL_CASHIER_MGM '
             +' where CD_STORE 	=:P0 '
             +'   and YMD_CLOSE	=:P1 '
             +'   and NO_POS	  =:P2 '
             +'   and CD_SAWON	=:P3 '
             +'   and YN_CLOSE	=''N'' ',
             [Common.Config.StoreCode,
              Common.WorkDate,
              Common.Config.PosNo,
              Common.Config.UserCode]);
    vSeq := Common.Query.Fields[0].AsInteger;

    OpenQuery('select Count(*) '
             +'  from SL_CASHIER_MGM '
             +' where CD_STORE 	=:P0 '
             +'   and YMD_CLOSE	=:P1 '
             +'   and NO_POS	  =:P2 '
             +'   and CD_SAWON	=:P3 '
             +'   and SEQ     	=:P4 ',
             [Common.Config.StoreCode,
              Common.WorkDate,
              Common.Config.PosNo,
              Common.Config.UserCode,
              vSeq]);
    vCnt := Common.Query.Fields[0].AsInteger;

    if vCnt = 0 then
    begin
      ExecQuery('insert into SL_CASHIER_MGM(CD_STORE, '
               +'		               					YMD_CLOSE, '
               +'		               					NO_POS, '
               +'		               					CD_SAWON, '
               +'		               					SEQ, '
               +'		               					AMT_MID_CASH, '
               +'                           AMT_MID, '
               +'		               					YN_CLOSE) '
               +'		                 values(:P0, '
               +'		               					:P1, '
               +'		               					:P2, '
               +'		               					:P3, '
               +'		               					:P4, '
               +'		               					:P5, '
               +'                           :P5, '
               +'		               					''N'') ',
               [Common.Config.StoreCode,
                Common.WorkDate,
                Common.Config.PosNo,
                Common.Config.UserCode,
                vSeq,
                DepositAmtEdit.Value,
                0],true);
    end
    else
    begin
      ExecQuery('update SL_CASHIER_MGM '
               +'   set AMT_MID_CASH  = AMT_MID_CASH  + :P5, '
               +'       AMT_MID       = AMT_MID + :P5, '
               +'       DT_CHANGE = Now() '
               +' where CD_STORE 	=:P0 '
               +'   and YMD_CLOSE	=:P1 '
               +'   and NO_POS	  =:P2 '
               +'   and CD_SAWON	=:P3 '
               +'   and SEQ       =:P4 ',
               [Common.Config.StoreCode,
                Common.WorkDate,
                Common.Config.PosNo,
                Common.Config.UserCode,
                vSeq,
                DepositAmtEdit.Value],true);

    end;
    Common.WriteLog('work', Format('중간출금 [%s]',[DepositAmtEdit.Text]));

    Common.Device.DepositPrint(DepositAmtEdit.Value,
                               StoI(GetOnlyNumber(TotalDepositAmtLabel.Caption)));
    Close;
  except
    on E: Exception do
    begin
      Common.WriteLog('중간출금',E.Message);
      Common.ErrBox(E.Message);
    end;
  end;
end;

procedure TDeposit_F.SubtractButtonClick(Sender: TObject);
begin
  DepositAmtEdit.Value := DepositAmtEdit.Value * -1;
  DepositAmtEdit.SetFocus;
  DepositAmtEdit.SelStart := Length(DepositAmtEdit.Text);
end;

procedure TDeposit_F.CashDrawerOpenButtonClick(Sender: TObject);
begin
  Common.Device.CashBoxOpen;
end;

procedure TDeposit_F.cedt_CheckKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then OkButtonClick(nil);
end;

procedure TDeposit_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

end.

