unit Check_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls, Buttons, ExtCtrls, 
  POSCard, GraphicEx, KeyPad_F, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, AdvGlassButton,
  cxMaskEdit, cxLabel, cxTextEdit, dxGDIPlusClasses, Vcl.Menus, cxButtons,
  AdvSmoothButton;
type
  TCheck_F = class(TForm)
    fmKeyPad1: TfmKeyPad;
    Shape1: TShape;
    Image1: TImage;
    Number1Edit: TcxTextEdit;
    Number2Edit: TcxTextEdit;
    Number3Edit: TcxTextEdit;
    Number4Edit: TcxTextEdit;
    Number5Edit: TcxTextEdit;
    cxLabel1: TcxLabel;
    Number6Edit: TcxTextEdit;
    cxLabel2: TcxLabel;
    IssueDateEdit: TcxMaskEdit;
    TitleLabel: TLabel;
    cxButton1: TcxButton;
    Image3: TImage;
    MessageLabel: TLabel;
    GetButton: TAdvSmoothButton;
    SearchButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GetButtonClick(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure Number1EditKeyPress(Sender: TObject; var Key: Char);
    procedure Number4EditPropertiesChange(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  private
    function ApprovalAction: String;
  public
    { Public declarations }
  end;

var
  Check_F: TCheck_F;

implementation
uses Common_U, GlobalFunc_U;
{$R *.dfm}

procedure TCheck_F.cxButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TCheck_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(SearchButton);
  Common.SetButtonColor(GetButton);
end;

function TCheck_F.ApprovalAction: String;
begin
  with Common.ICCard, Common do
  begin
    FocusHandle := Self.Handle;
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

    if Common.Config.van_Terid= 'cardtest' then
      RealMode := False
    else
      RealMode   := True;
    TerminalID := Common.Config.van_Terid;
    BizNo      := Common.Config.BizNo;
    Host       := Common.Config.van_ip;
    Port       := Common.Config.van_port;
    SaleDate   := FormatDateTime('yyyymmdd',Now());
    SerialNo   := Common.Config.SerialNo;
    PosNo      := Common.Config.PosNo;
    KeyIn      := True;
    if (GetOption(379) = '2') and (VAN in [vtKSNET, vtJTNET, vtNICE, vtKOVAN, vtKOCES, vtDaou]) then
      AppType := atVCatCheck
    else
      AppType    := atCheck;

    CardTrack2 := Number1Edit.Text +         //수표번호(8)
                  Number2Edit.Text +         //은행코드(2)
                  Number3Edit.Text +         //지점코드(4)
                  Number4Edit.Text +         //권종(2)
                  Copy(IssueDateEdit.Text,3,6)+ //발행일자(6)
                  Number6Edit.Text;          //계좌일련번호(14)
                  
    SaleAmt    := StrToInt(Number5Edit.Text);
    LogPath    := Common.AppPath;

    Execute;
    Result := Note;
  end;
end;

procedure TCheck_F.SearchButtonClick(Sender: TObject);
const MSG = '수표번호를 정확히 입력하세요';
var vTemp :String;
begin
   if Trim(Number1Edit.Text) = '' then
   begin
     Common.ErrBox(MSG);
     Number1Edit.SetFocus;
     Exit;
   end;
   if Trim(Number2Edit.Text) = '' then
   begin
     Common.ErrBox(MSG);
     Number2Edit.SetFocus;
     Exit;
   end;
   if Trim(Number3Edit.Text) = '' then
   begin
     Common.ErrBox(MSG);
     Number3Edit.SetFocus;
     Exit;
   end;
   if Trim(Number4Edit.Text) = '' then
   begin
     Common.ErrBox(MSG);
     Number4Edit.SetFocus;
     Exit;
   end;
   if Trim(Number5Edit.Text) = '' then
   begin
     Common.ErrBox(MSG);
     Number5Edit.SetFocus;
     Exit;
   end;

   Application.ProcessMessages;
   Common.ShowWaitForm;
   vTemp := ApprovalAction;
   Common.HideWaitForm;
   Common.MsgBox(vTemp);
end;


procedure TCheck_F.FormShow(Sender: TObject);
begin
  Number1Edit.Clear;
  Number2Edit.Clear;
  Number3Edit.Clear;
  Number4Edit.Clear;
  Number6Edit.Clear;
  IssueDateEdit.Clear;
end;

procedure TCheck_F.GetButtonClick(Sender: TObject);
begin
  if StrToIntDef(Number5Edit.Text,0) = 0 then
  begin
    Common.ErrBox('수표금액을 입력하세요');
    Number6Edit.SetFocus;
    Exit;
  end;
  Common.PreSent.CheckAmt := Common.PreSent.CheckAmt + StrToInt(Number5Edit.Text);
  ModalResult := mrOK;
end;

procedure TCheck_F.Number1EditKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    '0'..'9' :
    if TcxTextEdit(Sender).Properties.MaxLength = (Length(TcxTextEdit(Sender).Text)+1) then
    begin
      SelectNext(ActiveControl as tWinControl, True,True);
    end;
  end;
end;

procedure TCheck_F.Number4EditPropertiesChange(Sender: TObject);
  procedure SetEdit;
  begin
    Number5Edit.Properties.ReadOnly  := True;
    Number5Edit.TabStop              := False;
    Number5Edit.Style.Color          := clMoneyGreen;
    IssueDateEdit.SetFocus;
  end;
begin
  inherited;
  if Length(Number4Edit.Text) = 2 then
  begin
    case StrToInt(Number4Edit.Text) of
      13 : begin SetEdit; Number5Edit.Text := '0000100000'; end;
      14 : begin SetEdit; Number5Edit.Text := '0000300000'; end;
      15 : begin SetEdit; Number5Edit.Text := '0000500000'; end;
      16 : begin SetEdit; Number5Edit.Text := '0001000000'; end;
      19 :
      begin
        Number5Edit.Properties.ReadOnly   := False;
        Number5Edit.TabStop               := True;
        Number5Edit.Style.Color           := clWhite;
        Number5Edit.SetFocus;
      end;
      else
      begin
        Common.ErrBox('수표권종을 잘못입력했습니다');
        Number4Edit.SetFocus;
      end;
    end;
  end
  else Number5Edit.Clear;
end;

end.
