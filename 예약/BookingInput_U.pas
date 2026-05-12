unit BookingInput_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask,
  ExtCtrls, Grids, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxCurrencyEdit, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  Vcl.ComCtrls, AdvDateTimePicker, Vcl.Menus, cxButtons, cxMemo, cxLabel,
  AdvGlassButton, dxGDIPlusClasses, StrUtils, DateUtils, dxWheelPicker,
  dxNumericWheelPicker, dxDateTimeWheelPicker, AdvSmoothTimeLine,
  AdvSmoothButton;

type
  TBookingInput_F = class(TForm)
    lbl_Mode: TLabel;
    lbl_Shift: TLabel;
    MemberCodeEdit: TcxTextEdit;
    CaptionLabel: TcxLabel;
    GuestNameEdit: TcxTextEdit;
    MobileNoEdit: TcxTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    ReserveTableEdit: TcxTextEdit;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    ReserveCountEdit: TcxCurrencyEdit;
    cxLabel6: TcxLabel;
    ReserveAmtEdit: TcxCurrencyEdit;
    cxLabel8: TcxLabel;
    RemarkMemo: TcxMemo;
    cxLabel9: TcxLabel;
    cxLabel11: TcxLabel;
    CloseButton: TcxButton;
    TitleLabel: TLabel;
    MemberSearchButton: TAdvGlassButton;
    TableSearchButton: TAdvGlassButton;
    MenuSearchButton: TAdvGlassButton;
    Image3: TImage;
    MessageLabel: TLabel;
    ReserveDateTime: TdxDateTimeWheelPicker;
    ConfirmButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure MemberSearchButtonClick(Sender: TObject);
    procedure MobileNoEditExit(Sender: TObject);
    procedure TableSearchButtonClick(Sender: TObject);
    procedure MenuSearchButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    function  GetBookingTable:String;
  public
    FMenu_sGrd :TStringGrid;
  end;

var
  BookingInput_F: TBookingInput_F;

implementation
uses Common_U, GlobalFunc_U, Member_U, BookingTable_U, Table_U,
  BookingMenu_U;
{$R *.dfm}
procedure TBookingInput_F.FormCreate(Sender: TObject);
var vIndex :Integer;
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(ConfirmButton);
  for vIndex := 0 to ComponentCount-1 do
    if Components[vIndex] is TAdvGlassButton then
      Common.SetButtonColor((Components[vIndex] as TAdvGlassButton));

  FMenu_sGrd := TStringGrid.Create(Application);
end;

procedure TBookingInput_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not RemarkMemo.Focused then
  begin
    if (Key = VK_RETURN) or (Key = VK_DOWN) then
      SelectNext(TWinControl(ActiveControl), true,  true)
    else if Key = VK_UP then
      SelectNext(TWinControl(ActiveControl), false,  true);
  end;
end;

procedure TBookingInput_F.TableSearchButtonClick(Sender: TObject);
var vIndex :Integer;
    vBookingTableNo,
    vBookingTableName : TStringList;
begin
  BookingTable_F := TBookingTable_F.Create(self);
  try
    vBookingTableNo := TStringList.Create;
    vBookingTableNo := Common.BookingTableNo;

    //    Common.BookingTableList.Clear;
    if BookingTable_F.ShowModal = mrYes then
      ReserveTableEdit.Text := GetBookingTable
    else
      Common.BookingTableNo   := vBookingTableNo;
  finally
    FreeAndNil(BookingTable_F);
  end;

//  Common.IsWorking := False;
//  ModalResult := mrYes;
end;

procedure TBookingInput_F.MenuSearchButtonClick(Sender: TObject);
begin
  BookingMenu_F := TBookingMenu_F.Create(Self);
  try
    Common.GridToGrid(FMenu_sGrd, BookingMenu_F.Booking_sGrd);
    if BookingMenu_F.ShowModal = mrOK then
      Common.GridToGrid(BookingMenu_F.Booking_sGrd, FMenu_sGrd);
  finally
    FreeAndNil(BookingMenu_F);
  end;
end;

procedure TBookingInput_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TBookingInput_F.ConfirmButtonClick(Sender: TObject);
begin
  if Trim(GuestNameEdit.Text) = EmptyStr then
  begin
    Common.ErrBox('예약자명을 입력하세요');
    GuestNameEdit.SetFocus;
    Exit;
  end;

  if Trim(MobileNoEdit.Text) = EmptyStr then
  begin
    Common.ErrBox('연락처를 입력하세요');
    MobileNoEdit.SetFocus;
    Exit;
  end;

  if ReserveDateTime.DateTime < IncMinute(Now(), 10) then
  begin
    Common.ErrBox('예약시간이 최소 10분 이후이여야합니다');
    Exit;
  end;

  if ReserveCountEdit.EditingValue = 0 then
  begin
    Common.ErrBox('예약 인원을 입력하세요');
    ReserveCountEdit.SetFocus;
    Exit;
  end;

  ModalResult := mrOK;
end;

procedure TBookingInput_F.FormShow(Sender: TObject);
begin
  GuestNameEdit.SetFocus;
  TableSearchButton.Visible := not Common.Config.IsTakeOut;
  MenuSearchButton.Visible  := not Common.Config.IsTakeOut;
  ReserveTableEdit.Enabled  := not Common.Config.IsTakeOut;
end;

function TBookingInput_F.GetBookingTable: String;
var vIndex :Integer;
begin
  if (GetOption(25) = '1') then
  begin
    For vIndex := 0 to Common.BookingTableNo.Count-1 do
    begin
      OpenQuery('select NM_TABLE '
               +'  from MS_TABLE '
               +' where CD_STORE =:P0 '
               +'   and NO_TABLE =:P1',
               [Common.Config.StoreCode,
                StrToInt(Common.BookingTableNo.Strings[vIndex])]);
      Result := Result + Common.Query.Fields[0].AsString +',';
    end;

    if RightStr(Result,1) = ',' then
      Result := LeftStr(Result, Length(Result)-1);
  end
  else
  begin
    for vIndex := 0 to Common.BookingTableNo.Count-1 do
    begin
      Result := Result + Common.BookingTableNo.Strings[vIndex]+',';
    end;
    if RightStr(Result,1) = ',' then
      Result := LeftStr(Result, Length(Result)-1);
  end;

end;

procedure TBookingInput_F.MemberSearchButtonClick(Sender: TObject);
begin
  if Common.ShowMemberForm then
  begin
    MemberCodeEdit.Text  := Common.Member.Code;
    GuestNameEdit.Text   := Common.Member.Name;
    MobileNoEdit.Text    := Common.Member.MobileTel;
  end;
end;

procedure TBookingInput_F.MobileNoEditExit(Sender: TObject);
begin
  MobileNoEdit.Text := SetTelephone(MobileNoEdit.Text);
end;

end.
