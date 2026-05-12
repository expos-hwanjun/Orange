unit DeliveryAddr_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, cxLookAndFeelPainters, cxControls, cxContainer, cxEdit,
  cxLabel, ExtCtrls, StdCtrls,
  cxButtons, StrUtils, cxGraphics, cxLookAndFeels, AdvGlassButton,
  AdvSmoothToggleButton, dxGDIPlusClasses, PosButton, AdvSmoothButton;
type TAddrData = record
  code :String;
  addr :String;
end;

type TWorkStep = (wsOne, wsTwo, wsThree, wsFour);

type
  TDeliveryAddr_F = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TcxButton;
    AddressLabel: TcxLabel;
    Address1Button: TPosButton;
    Address2Button: TPosButton;
    Address3Button: TPosButton;
    Address4Button: TPosButton;
    Address5Button: TPosButton;
    Address6Button: TPosButton;
    Address7Button: TPosButton;
    Address8Button: TPosButton;
    Address9Button: TPosButton;
    Address10Button: TPosButton;
    Address11Button: TPosButton;
    Address12Button: TPosButton;
    Address13Button: TPosButton;
    Address14Button: TPosButton;
    Address15Button: TPosButton;
    Address16Button: TPosButton;
    Address17Button: TPosButton;
    Address18Button: TPosButton;
    Address19Button: TPosButton;
    Address20Button: TPosButton;
    PriorButton: TPosButton;
    NextButton: TPosButton;
    MessageLabel: TLabel;
    Image3: TImage;
    ConfirmButton: TAdvSmoothButton;
    PriorStepButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PriorStepButtonClick(Sender: TObject);
    procedure PriorButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure Address1ButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
  private
    AddrData :Array of TAddrData;
    FWorkStep :TWorkStep;
    Code1, Addr1,
    Code2, Addr2,
    Code3, Addr3,
    Code4, Addr4   :String;
    FPage :Integer;
    procedure SetLabelAddr;
    procedure SetButtonData;
    procedure SetWorkStep(const Value: TWorkStep);
    property WorkStep :TWorkStep read FWorkStep write SetWorkStep;
  public
    FAddress :String;
    CourseCode, CourseName,
    LocalCode, LocalName,
    DamdangCode, DamdangName :String;
  end;

var
  DeliveryAddr_F: TDeliveryAddr_F;

implementation
uses Common_U, GlobalFunc_U;
{$R *.dfm}

procedure TDeliveryAddr_F.PriorButtonClick(Sender: TObject);
begin
  if Sender = PriorButton then FPage := FPage - 1
  else                         FPage := FPage + 1;
  SetButtonData;
end;

procedure TDeliveryAddr_F.PriorStepButtonClick(Sender: TObject);
begin
  case WorkStep of
    wsTwo   : WorkStep := wsOne;
    wsThree : WorkStep := wsTwo;
    wsFour  : WorkStep := wsThree;
  end;
end;

procedure TDeliveryAddr_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,1);
  Common.SetButtonColor(PriorStepButton);
  Common.SetButtonColor(ConfirmButton);
  FPage := 1;
end;

procedure TDeliveryAddr_F.SetWorkStep(const Value: TWorkStep);
const SQL_1 = 'select CD_ADDR, NM_ADDR from MS_DELIVERY_ADDR where CD_STORE=:P0 and length(CD_ADDR)=2 order by CD_ADDR';
      SQL_2 = 'select substring(CD_ADDR,3,2) as CD_ADDR, NM_ADDR from MS_DELIVERY_ADDR where CD_STORE = :P0 and length(CD_ADDR)=4 and substring(CD_ADDR,1,2) =:P1 order by CD_ADDR';
      SQL_3 = 'select substring(CD_ADDR,5,2) as CD_ADDR, NM_ADDR from MS_DELIVERY_ADDR where CD_STORE = :P0 and length(CD_ADDR)=6 and substring(CD_ADDR,1,4) =:P1 order by CD_ADDR';
      SQL_4 = 'select substring(CD_ADDR,7,2) as CD_ADDR, NM_ADDR from MS_DELIVERY_ADDR where CD_STORE = :P0 and length(CD_ADDR)=8 and substring(CD_ADDR,1,6) =:P1 order by CD_ADDR';
var vIndex :Integer;
begin
  FWorkStep := Value;
  PriorStepButton.Enabled := True;
  Common.Query.Options.QueryRecCount := true;
  Common.Query.Close;
  case FWorkStep of
    wsOne   :
    begin
      OpenQuery(SQL_1,
               [Common.Config.StoreCode]);
      PriorStepButton.Enabled := False;
      Code2 := '';
      Addr2 := '';
      Code3 := '';
      Addr3 := '';
      Code4 := '';
      Addr4 := '';    end;
    wsTwo   :
    begin
      OpenQuery(SQL_2,
               [Common.Config.StoreCode,
                Code1]);
      Code3 := '';
      Addr3 := '';
      Code4 := '';
      Addr4 := '';
    end;
    wsThree :
    begin
      OpenQuery(SQL_3,
               [Common.Config.StoreCode,
                Code1+Code2]);
      Code4 := '';
      Addr4 := '';
    end;
    wsFour  :
    begin
      OpenQuery(SQL_4,
               [Common.Config.StoreCode,
                Code1+Code2+Code3]);
    end;
  end;

  SetLength(AddrData, Common.Query.RecordCount);
  vIndex := 0;
  while not Common.Query.Eof do
  begin
    AddrData[vIndex].code := Common.Query.FieldByName('CD_ADDR').AsString;
    AddrData[vIndex].addr := Common.Query.FieldByName('NM_ADDR').AsString;
    Common.Query.Next;
    Inc(vIndex);
  end;

  for vIndex := 1 to 20 do
  begin
    TPosButton(FindComponent(Format('Address%dButton',[vIndex]))).Caption := '';
    TPosButton(FindComponent(Format('Address%dButton',[vIndex]))).Hint    := '';
    TPosButton(FindComponent(Format('Address%dButton',[vIndex]))).Enabled := False;
  end;
  FPage := 1;
  SetButtonData;
  SetLabelAddr;
  Common.Query.Close;
  Common.Query.Options.QueryRecCount := false;
end;

procedure TDeliveryAddr_F.SetButtonData;
var vIndex, vMaxPage :Integer;
begin                                                                                           
  for vIndex := 1 to 20 do
  begin
    TPosButton(FindComponent(Format('Address%dButton',[vIndex]))).Caption := '';
    TPosButton(FindComponent(Format('Address%dButton',[vIndex]))).Hint    := '';
    TPosButton(FindComponent(Format('Address%dButton',[vIndex]))).Enabled := False;
  end;

  For vIndex := 1  to 20 do
  begin
    if ( ((FPage-1)*20) + vIndex-1 ) >=  (High(AddrData)+1) then Continue;
    TPosButton(FindComponent(Format('Address%dButton',[vIndex]))).Hint    := AddrData[((FPage-1)*20)+vIndex-1].Code;
    TPosButton(FindComponent(Format('Address%dButton',[vIndex]))).Caption := AddrData[((FPage-1)*20)+vIndex-1].Addr;
    TPosButton(FindComponent(Format('Address%dButton',[vIndex]))).Enabled := True;
  end;
  PriorButton.Visible := FPage > 1;

  PriorButton.Visible := FPage > 1;
  vMaxPage := ((High(AddrData)+1) div 20 );
  if ((High(AddrData)+1) mod 20 ) > 0 then
    vMaxPage := vMaxPage;
  NextButton.Visible := FPage < vMaxPage;
end;

procedure TDeliveryAddr_F.FormShow(Sender: TObject);
begin
  WorkStep := wsOne; 
end;

procedure TDeliveryAddr_F.Address1ButtonClick(Sender: TObject);
begin
  case WorkStep of
    wsOne :
    begin
      Code1    := (Sender as TPosButton).Hint;
      Addr1    := (Sender as TPosButton).Caption;
      WorkStep := wsTwo;
    end;
    wsTwo :
    begin
      Code2    := (Sender as TPosButton).Hint;
      Addr2    := (Sender as TPosButton).Caption;
      WorkStep := wsThree;
    end;
    wsThree :
    begin
      Code3    := (Sender as TPosButton).Hint;
      Addr3    := (Sender as TPosButton).Caption;
      WorkStep := wsFour;
    end;
    wsFour :
    begin
      Code4    := (Sender as TPosButton).Hint;
      Addr4    := (Sender as TPosButton).Caption;
      ModalResult := mrOK;
    end;
  end;
  SetLabelAddr;
end;

procedure TDeliveryAddr_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TDeliveryAddr_F.ConfirmButtonClick(Sender: TObject);
begin
  if FAddress = '' then Exit;
  OpenQuery('select CD_CODE, '
           +'       NM_CODE1 '
           +'  from MS_CODE '
           +' where CD_STORE =:P0 '
           +'   and CD_KIND = ''20'' '
           +'   and CD_CODE = (select CD_COURSE '
           +'                    from MS_DELIVERY_ADDR '
           +'                   where CD_STORE = :P0 '
           +'                     and CD_ADDR  = :P1) ',
           [Common.Config.StoreCode,
            Code1+Code2+Code3+Code4]);
  if not Common.Query.Eof then
  begin
    CourseCode := Common.Query.Fields[0].AsString;
    CourseName := Common.Query.Fields[1].AsString;
  end;

  OpenQuery('select CD_CODE, '
           +'       NM_CODE1 '
           +'  from MS_CODE '
           +' where CD_STORE =:P0 '
           +'   and CD_KIND = ''22'' '
           +'   and CD_CODE = (select CD_LOCAL '
           +'                    from MS_DELIVERY_ADDR '
           +'                   where CD_STORE = :P0 '
           +'                     and CD_ADDR  = :P1) ',
           [Common.Config.StoreCode,
            Code1+Code2+Code3+Code4]);
  if not Common.Query.Eof then
  begin
    LocalCode := Common.Query.Fields[0].AsString;
    LocalName := Common.Query.Fields[1].AsString;
  end;

  OpenQuery('select CD_SAWON, '
           +'       NM_SAWON '
           +'  from MS_SAWON '
           +' where CD_STORE =:P0 '
           +'   and CD_SAWON = (select CD_DAMDANG '
           +'                     from MS_DELIVERY_ADDR '
           +'                    where CD_STORE = :P0 '
           +'                      and CD_ADDR  = :P1) ',
           [Common.Config.StoreCode,
            Code1+Code2+Code3+Code4]);
  if not Common.Query.Eof then
  begin
    DamdangCode := Common.Query.Fields[0].AsString;
    DamdangName := Common.Query.Fields[1].AsString;
  end;

  ModalResult := mrOK;
end;

procedure TDeliveryAddr_F.SetLabelAddr;
begin
  FAddress := Addr1 +
              ifthen(Addr2 <> '', ' '+Addr2,'') +
              ifthen(Addr3 <> '', ' '+Addr3,'') +
              ifthen(Addr4 <> '', ' '+Addr4,'');
  AddressLabel.Caption := FAddress;

end;

procedure TDeliveryAddr_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then CloseButton.Click;
end;

end.
