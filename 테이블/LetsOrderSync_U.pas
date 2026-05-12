unit LetsOrderSync_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, AdvScrollBox, cxScrollBox,
  Vcl.StdCtrls, cxButtons, cxContainer, cxEdit, cxTextEdit, cxMemo, MaskUtils,
  AdvGlassButton, AdvSmoothButton;

type
  TLetsOrderSync_F = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TcxButton;
    OrderDataMemo: TcxMemo;
    PrintButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  LetsOrderSync_F: TLetsOrderSync_F;

implementation
uses Common_U, DBModule_U, GlobalFunc_U;
{$R *.dfm}

procedure TLetsOrderSync_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TLetsOrderSync_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,1);
  Common.SetButtonColor(PrintButton);
end;

procedure TLetsOrderSync_F.FormShow(Sender: TObject);
begin
  OrderDataMemo.Lines.Clear;
  OpenQuery('select NO_ORDER, '
           +'       AES_Decrypt(TEL_MOBILE, 71483) as TEL_MOBILE, '
           +'       PRINT_DATA, '
           +'       ORDER_TIME '
           +'  from SL_ORDER_PRT '
           +' where CD_STORE    =:P0 '
           +'   and NO_TABLE	  =:P1 '
           +'   and DS_ORDER	  =''T'' '
           +'   and CD_PRINTER	=''LET'' '
           +' order by SEQ ',
           [Common.Config.StoreCode,
            Common.Table.Number]);
  OrderDataMemo.Lines.Clear;
  while not Common.Query.Eof do
  begin
    OrderDataMemo.Lines.Add(Format('주문시간 : %s',[FormatMaskText('!0000년90월90일 09시:09분;0; ',Common.Query.FieldByName('ORDER_TIME').AsString)]));
    OrderDataMemo.Lines.Add(Format('주문번호 : %s',[Common.Query.FieldByName('NO_ORDER').AsString]));
    OrderDataMemo.Lines.Add(Format('전화번호 : %s',[SetTelephone(Replace(Common.Query.FieldByName('TEL_MOBILE').AsString, '+82 ','0'))]));
    OrderDataMemo.Lines.Add('- 주문내역 -');
    OrderDataMemo.Lines.Add(Common.Query.FieldByName('PRINT_DATA').AsString);
    Common.Query.Next;
  end;
  Common.Query.Close;
  PrintButton.Enabled := OrderDataMemo.Text <> '';
end;

procedure TLetsOrderSync_F.PrintButtonClick(Sender: TObject);
begin
  if GetOption(25) = '0' then
    Common.Device.PrintData := Format('테이블  : %d',[Common.Table.Number]) + #13
  else
    Common.Device.PrintData := Format('테이블  : %s',[Common.Table.Name]) + #13;

  Common.Device.PrintData := Common.Device.PrintData + OrderDataMemo.Text;

  Common.Device.PrintPrinter(0);
end;

end.
