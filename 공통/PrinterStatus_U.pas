unit PrinterStatus_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, StrUtils, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxGDIPlusClasses, cxButtons;

type
  TPrinterStatus_F = class(TForm)
    meo_Printer: TMemo;
    Timer1: TTimer;
    IdTCPClient1: TIdTCPClient;
    TitleLabel: TLabel;
    CloseButton: TcxButton;
    Image3: TImage;
    MessageLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrinterStatus_F: TPrinterStatus_F;

implementation
uses Common_U;
{$R *.dfm}

procedure TPrinterStatus_F.FormShow(Sender: TObject);
begin
  Timer1.Enabled := True;
end;

procedure TPrinterStatus_F.Timer1Timer(Sender: TObject);
var vIdx :Integer;
    vRtn :String;
begin
  Timer1.Enabled := False;
  Screen.Cursor := crHourGlass;
  meo_Printer.Clear;
  CloseButton.Enabled := false;
  with Common.Device do
  begin
    For vIdx := 0 to High(Common.KitchenPrinter) do
    begin
      if Common.KitchenPrinter[vIdx].IsKDS then Continue;

      meo_Printer.Lines.Add(Common.KitchenPrinter[vIdx].Name+' 프린터 상태체크 중...');
      Application.ProcessMessages;
      vRtn := OrderSend('0',
                         Common.KitchenPrinter[vIdx].Code,
                         '',
                         Common.KitchenPrinter[vIdx].IP,
                         ifThen(Common.KitchenPrinter[vIdx].Port = 'E',
                                Common.KitchenPrinter[vIdx].EthernetIP,
                                Common.KitchenPrinter[vIdx].Port)
                         );
      if vRtn = 'OK' then
        meo_Printer.Lines.Strings[meo_Printer.Lines.Count-1] := '[주방]'+(Common.KitchenPrinter[vIdx].Name +' 정상')
      else if vRtn = 'Connect Error' then
        meo_Printer.Lines.Strings[meo_Printer.Lines.Count-1] := '[주방]'+(Common.KitchenPrinter[vIdx].Name +' '+vRtn)
      else
        meo_Printer.Lines.Strings[meo_Printer.Lines.Count-1] :=('[주방]'+Common.KitchenPrinter[vIdx].Name +' '+ vRtn  );
      Application.ProcessMessages;
    end;

    if (Common.Config.ReceiptPrinterDev > 0) and (not Common.Config.RcpToKitchen) then
    begin
      if Common.Config.ReceiptPrinterPort = '0' then
        meo_Printer.Lines.Add('영수증프린터-LPT프린터는 상태를 체크할 수 없습니다')
      else
      begin
        meo_Printer.Lines.Add('영수증 프린터 상태체크 중...');
        Application.ProcessMessages;
        vRtn := Common.Device.PrinterCheck;
        if vRtn = '' then
          meo_Printer.Lines.Strings[meo_Printer.Lines.Count-1] := '[영수증] 프린터 정상'
        else
          meo_Printer.Lines.Strings[meo_Printer.Lines.Count-1] := '[영수증] '+vRtn;
      end;
    end;
    meo_Printer.Lines.Add('');
    meo_Printer.Lines.Add(' 프린터 상태체크가 완료되었습니다.');
  end;
  Screen.Cursor := crDefault;
  CloseButton.Enabled := True;
end;

procedure TPrinterStatus_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TPrinterStatus_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
end;

end.
