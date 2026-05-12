unit UPSS_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxCurrencyEdit, cxTextEdit, StdCtrls,
  cxLabel, KeyPad_F, Vcl.Menus, cxButtons, AdvGlassButton;

type
  TUPSS_F = class(TForm)
    fmKeyPad1: TfmKeyPad;
    CommentLabel: TcxLabel;
    lblMenuName: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    cxLabel9: TcxLabel;
    cxLabel10: TcxLabel;
    cxLabel11: TcxLabel;
    cxLabel12: TcxLabel;
    cxLabel13: TcxLabel;
    GoodsNameEdit: TcxTextEdit;
    GoodsCodeEdit: TcxTextEdit;
    MakerNameEdit: TcxTextEdit;
    MakeDateEdit: TcxTextEdit;
    ExpiryDateEdit: TcxTextEdit;
    WhyEdit: TcxTextEdit;
    NotiyDateEdit: TcxTextEdit;
    StockQtyEdit: TcxCurrencyEdit;
    CaptionLabel: TLabel;
    CloseButton: TcxButton;
    ConfirmButton: TAdvGlassButton;
    CancelButton: TAdvGlassButton;
    SaleButton: TAdvGlassButton;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure SaleButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UPSS_F: TUPSS_F;

implementation
uses Common_U;
{$R *.dfm}

procedure TUPSS_F.CancelButtonClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TUPSS_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TUPSS_F.ConfirmButtonClick(Sender: TObject);
var vPrintData :String;
begin
  if StockQtyEdit.Value = 0 then
  begin
    Common.ErrBox('재고수량을 입력해야합니다');
    StockQtyEdit.SetFocus;
    Exit;
  end;

  Common.MsgBox(Format('위해상품 차단 조치완료하였습니다'#13'%s 상품을 지금 즉시 '#13'매장 및 창고에서 회수하여 매입처에 반품 하십시오',[GoodsNameEdit.Text]));

  vPrintData := EmptyStr;
  vPrintData := '상품코드 : '+GoodsCodeEdit.Text + #13
              + '상품이름 : '+GoodsNameEdit.Text + #13;
  if MakerNameEdit.Text <> EmptyStr then
    vPrintData := vPrintData + '제조업체 : '+MakerNameEdit.Text + #13;
  if MakeDateEdit.Text <> EmptyStr then
    vPrintData := vPrintData + '제조일자 : '+MakeDateEdit.Text + #13;
  if CommentLabel.Hint <> EmptyStr then
    vPrintData := vPrintData + '검사기관 : '+CommentLabel.Hint + #13;
  if WhyEdit.Text <> EmptyStr then
    vPrintData := vPrintData + '보고유형 : '+WhyEdit.Text + #13;

  vPrintData := vPrintData + '위 상품을 매장에서 즉시 회수하십시오'+ #13;
  Common.Device.PrintData := vPrintData;
  Common.Device.UPSSPrint;
  ModalResult := mrYes;
end;

procedure TUPSS_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,1);
end;

procedure TUPSS_F.SaleButtonClick(Sender: TObject);
var vMsg :String;
begin
  if (ExpiryDateEdit.Text = '') and (MakeDateEdit.Text = '') then
    Common.MsgBox('위해상품을 판매하면'#13'행정처분을 받을 수 있습니다')
  else
  begin
    vMsg := EmptyStr;
    if MakeDateEdit.Text <> '' then
      vMsg := Format('제조일자가 %s일 ',[MakeDateEdit.Text]);
    if ExpiryDateEdit.Text <> '' then
      vMsg := vMsg + Format('유통기한이 %s',[Trim(ExpiryDateEdit.Text)]);

    if vMsg <> EmptyStr then
      Common.MsgBox(Format('위해상품을 판매합니다'#13'%s 뒤인 '#13'상품은 판매할 수 있습니다',[vMsg]));
  end;
  ModalResult := mrOK;
end;

end.
