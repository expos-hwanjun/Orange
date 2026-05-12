unit CardLog_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxLookAndFeels, cxControls, cxContainer, cxEdit,
  cxLabel, IniFiles, ExtCtrls, cxGroupBox, cxGraphics,
  cxLookAndFeelPainters, cxClasses, AdvGlassButton;

type
  TCardLog_F = class(TForm)
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;                                          
    cxLabel4: TcxLabel;
    lblCardNo: TcxLabel;
    lblAgreeAmt: TcxLabel;
    lblCardName: TcxLabel;
    lblAgreeDate: TcxLabel;
    cxLookAndFeelController1: TcxLookAndFeelController;
    Shape1: TShape;
    cxGroupBox1: TcxGroupBox;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    DeleteButton: TAdvGlassButton;
    CloseButton: TAdvGlassButton;
    procedure FormShow(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CardLog_F: TCardLog_F;

implementation
uses GlobalFunc_U, Common_U, Const_U;
{$R *.dfm}

procedure TCardLog_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TCardLog_F.DeleteButtonClick(Sender: TObject);
begin
  if not Common.AskBox('로그내역을 삭제하시겠습니까?') then Exit;
  //카드승인을 저장하지 못한 내역이 있을때를 대비해서
  Common.SetIniFile('POS', 'CARDLOG', '');
  Close;
end;

procedure TCardLog_F.FormShow(Sender: TObject);
var vTemp :String;
begin
  //카드승인을 저장하지 못한 내역이 있을때를 대비해서
  vTemp := Common.GetIniFile('POS', 'CARDLOG', '');

  lblCardNo.Caption    := CopyPos(vTemp, '|', 1);
  lblAgreeAmt.Caption  := FormatFloat('#,0', StoI(CopyPos(vTemp, '|', 6)) );
  lblCardName.Caption  := CopyPos(vTemp, '|', 4);
  lblAgreeDate.Caption := CopyPos(vTemp, '|', 8)+CopyPos(vTemp, '|', 9);
end;
  
end.
