unit BookingTable_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Table_U, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus,
  System.ImageList, Vcl.ImgList, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  cxLabel, dxGDIPlusClasses, Vcl.StdCtrls, cxButtons, cxCalendar, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxColorComboBox, AdvGlassButton, cxClasses,
  AdvSmoothPanel, Vcl.Buttons, AdvTimePickerDropDown, AdvSmoothToggleButton,
  Data.DB, dxmdaset;

type
  TBookingTable_F = class(TTable_F)
    procedure CloseButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  BookingTable_F: TBookingTable_F;

implementation

{$R *.dfm}

procedure TBookingTable_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TBookingTable_F.FormShow(Sender: TObject);
var vIndex :Integer;
begin
  inherited;
  if FunctionPanelButton.Visible then
    FunctionPanelButton.Click;

  //예약버튼만 활성화 시킨다
  for vIndex := Low(FunctionButton) to High(FunctionButton) do
    FunctionButton[vIndex].Enabled := FunctionButton[vIndex].Hint = '05';

  MessageLabel.Caption := '예약테이블을 선택 후 [예약버튼]을 다시 클릭하면 테이블선택이 완료됩니다';
end;

end.
