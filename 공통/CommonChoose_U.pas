unit CommonChoose_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, cxLookAndFeelPainters, cxControls, cxContainer, cxEdit,
  cxLabel, ExtCtrls, StdCtrls,
  cxButtons, cxGraphics, cxLookAndFeels, AdvSmoothToggleButton, dxGDIPlusClasses,
  cxTextEdit, AdvGlassButton, StrUtils, PosButton, AdvSmoothButton;

type TSelectMode = (smDeliveryCourse, smDeliveryItem, smDeliveryLocal, smDeliveryMan, smTableDamdang, smMenuGroup, smKitchenMemo);  //배달코스, 배달아이템

type TButtonData  = record
  Code   : String;
  Name   : String;
  Count  : String;
  Count2 : String;
  State  : String;
  Price  : String;
  MenuType : String;
  SoldOut  : String;
end;
type
  TCommonChoose_F = class(TForm)
    MessageLabel: TLabel;
    Image3: TImage;
    CloseButton: TcxButton;
    CaptionLabel: TLabel;
    Choose1Button: TPosButton;
    Choose2Button: TPosButton;
    Choose3Button: TPosButton;
    Choose4Button: TPosButton;
    Choose5Button: TPosButton;
    Choose6Button: TPosButton;
    Choose7Button: TPosButton;
    Choose8Button: TPosButton;
    Choose9Button: TPosButton;
    Choose10Button: TPosButton;
    Choose11Button: TPosButton;
    Choose12Button: TPosButton;
    Choose13Button: TPosButton;
    Choose14Button: TPosButton;
    Choose15Button: TPosButton;
    Choose16Button: TPosButton;
    Choose17Button: TPosButton;
    Choose18Button: TPosButton;
    Choose19Button: TPosButton;
    Choose20Button: TPosButton;
    PriorButton: TPosButton;
    NextButton: TPosButton;
    CustInfoPanel: TPanel;
    Choose21Button: TPosButton;
    Choose22Button: TPosButton;
    Choose23Button: TPosButton;
    GuestAge1Button: TAdvSmoothToggleButton;
    GuestAge2Button: TAdvSmoothToggleButton;
    GuestAge3Button: TAdvSmoothToggleButton;
    GuestAge4Button: TAdvSmoothToggleButton;
    GuestAge5Button: TAdvSmoothToggleButton;
    GuestAge6Button: TAdvSmoothToggleButton;
    GuestType1Button: TAdvSmoothToggleButton;
    GuestType2Button: TAdvSmoothToggleButton;
    GuestType4Button: TAdvSmoothToggleButton;
    GuestType3Button: TAdvSmoothToggleButton;
    GuestType6Button: TAdvSmoothToggleButton;
    GuestType5Button: TAdvSmoothToggleButton;
    NewGuestButton: TAdvSmoothButton;
    OldGuestButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure PriorButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure Choose1ButtonClick(Sender: TObject);
    procedure GuestType1ButtonClick(Sender: TObject);
    procedure GuestAge1ButtonClick(Sender: TObject);
    procedure NewGuestButtonClick(Sender: TObject);
  private
    ButtonData :Array of TButtonData;
    FPage :Integer;
    FSelectMode : TSelectMode;
    CustCode,
    AgeCode :String;
    SelectedQty :Integer;
    procedure SetButtonData;
    procedure SetSelectMode(const Value: TSelectMode);
    property  SelectMode:TSelectMode read FSelectMode write SetSelectMode;
  public
    SqlText :String;
    strSelectMode :String; //C, I
    GroupMenuCode,
    GroupMenuName,
    SelectCode,
    SelectName :String;
    SelectQty  :String;  //그룹메뉴일때 선택 가능 메뉴(자동 종료 용)
  end;

var
  CommonChoose_F: TCommonChoose_F;

implementation
uses Common_U, GlobalFunc_U;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TCommonChoose_F.PriorButtonClick(Sender: TObject);
begin
  if Sender = PriorButton then FPage := FPage - 1
  else                         FPage := FPage + 1;
  SetButtonData;
end;

procedure TCommonChoose_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(NewGuestButton);
  Common.SetButtonColor(OldGuestButton);
  BlockInput(false);
  SelectedQty := 0;
end;

procedure TCommonChoose_F.Choose1ButtonClick(Sender: TObject);
var vHandle   :THandle;
    vSendData :AnsiString;
    vData     :TCopyDataStruct;
begin
  case SelectMode of
    smTableDamdang :
    begin
      //외식기능을 사용할때 고객유형, 연령대, 신규/기존을 반드시 선택하도록 한다
      if (GetOption(254) = '1') then
      begin
        if GetOption(14) = '2' then
        begin
          if (CustCode = '') and (Common.Table.CustCode = EmptyStr) then
          begin
            Common.ErrBox('고객유형을 선택하세요');
            Exit;
          end;

          if (AgeCode = '') and (Common.Table.AgeCode.Count = 0) then
          begin
            Common.ErrBox('연령대를 선택하세요');
            Exit;
          end;

          if Common.Table.DsCust = '' then
          begin
            Common.ErrBox('신규/단골 여부를 선택하세요');
            Exit;
          end;
        end;
      end;
    end;
    smMenuGroup :
    begin
      if not ((Sender as TPosButton).Temp2[1] in ['G','C','O']) and ((Sender as TPosButton).Temp1 = '0') then //and ((Sender as TPosButton).Temp4 = '0') then
      begin
        vHandle := FindWindow('TOrder_F', nil);
        if vHandle > 0 then
        begin
          vSendData    := (Sender as TPosButton).Hint;
          vData.dwData := 0;
          vData.cbData := Length(vSendData)+1;
          vData.lpData := PAnsiChar(vSendData);
          SendMessage(vHandle, WM_COPYDATA, Self.Handle, Integer(@vData));
        end;
        if FindWindow('TConfig_F', nil) = 0 then
        begin
          SelectedQty := SelectedQty + 1;
          if SelectedQty = StrToInt(SelectQty) then
            Close;
          Exit;
        end;
      end
    end;
  end;
  SelectCode   := (Sender as TPosButton).Hint;
  SelectName   := (Sender as TPosButton).Temp5;
  ModalResult := mrOK;
end;

procedure TCommonChoose_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TCommonChoose_F.SetButtonData;
var vIndex, vMaxPage, vCount :Integer;
begin
  if CustInfoPanel.Visible then
    vCount := 20
  else
    vCount := 23;

  For vIndex := 1 to vCount do
  begin
    TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Color   := Common.Config.PluMenuColor;
    TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Font    := Common.Config.PluMenuFont;
    TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Font.Style := [fsBold];
    TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).BorderStyle := pbsSingle;
    TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Caption := '';
    TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Hint    := '';
    TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Temp1   := '';
    TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Temp2   := '';
    TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Temp3   := '';
    TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Temp4   := '';
    TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Temp5   := '';
    TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Bottom.RightString := '';
    if SelectMode = smMenuGroup then
    begin
      TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Bottom.Height := Trunc(TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Height / 4)+3;
      TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Bottom.Font   := Common.Config.PluPriceFont;

      TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Number.Height     := Trunc(TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Height / 4);
      TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Number.Font.Color := Common.Config.PluMenuFont.Color;
      TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Number.Font.Name  := '맑은 고딕';
      TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Number.Font.Size  := Common.Config.PluMenuFont.Size-2;

    end;
    TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Visible := False;
  end;

  For vIndex := 1 to vCount do
  begin
    if (((FPage-1)*vCount) + vIndex)  > (High(ButtonData)+1) then Break;

    if Tag = 1 then
       TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Caption := Format('%s[%s]',[ButtonData[vIndex].Name,ButtonData[(FPage-1) * vCount+vIndex-1].Count])
    else
       TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Caption  := LineFeed(ButtonData[(FPage-1) * vCount+vIndex-1].Name);
    TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Hint    := ButtonData[(FPage-1) * vCount+vIndex-1].Code;
    TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Temp1   := ButtonData[(FPage-1) * vCount+vIndex-1].Count;      //아이템갯수
    TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Temp2   := ButtonData[(FPage-1) * vCount+vIndex-1].MenuType;   //메뉴구분
    TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Temp3   := ButtonData[(FPage-1) * vCount+vIndex-1].Price;      //판매단가
    TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Temp4   := ButtonData[(FPage-1) * vCount+vIndex-1].Count2;     //주방메모갯구
    TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Temp5   := ButtonData[(FPage-1) * vCount+vIndex-1].Name;       //SelectCode Resutl 용
    if SelectMode = smMenuGroup then
    begin
      TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Bottom.RightString := ButtonData[(FPage-1) * vCount+vIndex-1].Price;
      TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Number.RightString := ButtonData[(FPage-1) * vCount+vIndex-1].SoldOut;
    end;

    TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).BorderColor := Common.Config.PluMenuBorderColor;
    TPosButton(FindComponent(Format('Choose%dButton',[vIndex]))).Visible := True;
  end;

  PriorButton.Enabled := FPage > 1;
  //총페이지 구함
  vMaxPage := ((High(ButtonData)+1) div vCount );
  if ((High(ButtonData)+1) mod vCount ) > 0 then
    vMaxPage := vMaxPage + 1;
  NextButton.Enabled := FPage < vMaxPage ;
  PriorButton.Visible := vMaxPage > 1;
  NextButton.Visible  := vMaxPage > 1;
end;

procedure TCommonChoose_F.SetSelectMode(const Value: TSelectMode);
var vIndex :Integer;
begin
  FSelectMode := Value;
  CustInfoPanel.Visible := false;
  NewGuestButton.Visible := false;
  OldGuestButton.Visible := false;
  PriorButton.Height     := 57;
  NextButton.Height      := 57;

  Common.Query.Options.QueryRecCount := true;
  case FSelectMode of
    smDeliveryCourse :
    begin
      CaptionLabel.Caption   := '배달코스';
      MessageLabel.Caption   := '배달코스를 선택하세요';
      OpenQuery(SqlText,
                [Common.Config.StoreCode]);
      SetLength(ButtonData, Common.Query.RecordCount);
      vIndex := 0;
      while not Common.Query.Eof do
      begin
        ButtonData[vIndex].Code   := Common.Query.FieldByName('CD_CODE').AsString;
        ButtonData[vIndex].Name   := Common.Query.FieldByName('NM_COURSE').AsString;
        ButtonData[vIndex].Count  := Common.Query.FieldByName('CNT_DELIVERY').AsString;
        Common.Query.Next;
        Inc(vIndex);
      end;
    end;
    smDeliveryItem:
    begin
      CaptionLabel.Caption   := '배달아이템';
      MessageLabel.Caption   := '배달 아이템을 선택하세요';
      OpenQuery('select CD_CODE, '
               +'       NM_CODE1 '
               +'  from MS_CODE '
               +' where CD_STORE =:P0 '
               +'   and CD_KIND =''21'' '
               +'   and DS_STATUS = ''0'' '
               +' order by CD_CODE',
                [Common.Config.StoreCode]);
      SetLength(ButtonData, Common.Query.RecordCount);
      vIndex := 0;
      while not Common.Query.Eof do
      begin
        ButtonData[vIndex].Code   := Common.Query.FieldByName('CD_CODE').AsString;
        ButtonData[vIndex].Name   := Common.Query.FieldByName('NM_CODE1').AsString;
        Common.Query.Next;
        Inc(vIndex);
      end;
    end;
    smDeliveryLocal :
    begin
      CaptionLabel.Caption   := '배달지역';
      MessageLabel.Caption   := '배달지역을 선택하세요';
      OpenQuery('select CD_CODE, '
               +'       NM_CODE1 '
               +'  from MS_CODE '
               +' where CD_STORE =:P0 '
               +'   and CD_KIND =''22'' '
               +'   and DS_STATUS = ''0'' '
               +' order by CD_CODE',
                [Common.Config.StoreCode]);
      SetLength(ButtonData, Common.Query.RecordCount);
      vIndex := 0;
      while not Common.Query.Eof do
      begin
        ButtonData[vIndex].Code   := Common.Query.FieldByName('CD_CODE').AsString;
        ButtonData[vIndex].Name   := Common.Query.FieldByName('NM_CODE1').AsString;
        Common.Query.Next;
        Inc(vIndex);
      end;
    end;
    smDeliveryMan :
    begin
      CaptionLabel.Caption   := '배달담당자';
      MessageLabel.Caption   := '배달 담당자를 선택하세요';
      OpenQuery('select a.CD_SAWON, '
               +'       a.NM_SAWON, '
               +'       case when b.TIME_IN is null then ''미출근'' '
               +'            else case when (select count(*) '
               +'                              from SL_DELIVERY '
               +'                             where CD_STORE = a.CD_STORE '
               +'                               and CD_SAWON = a.CD_SAWON '
               +'                               and DS_STEP  = ''D'') > 0 then ''배달중'' '
               +'                                 else ''배달가능'' end '
               +'       end as STATE, '
               +'       '''', '
               +'       '''' '
               +' from MS_SAWON     a left outer join '
               +'      SL_SAWONWORK b on a.CD_STORE = b.CD_STORE '
               +'                    and a.CD_SAWON = b.CD_SAWON '
               +'                    and b.TIME_OUT is null '
               +'                    and b.SETTLE_OUT is null '
               +' where a.CD_STORE =:P0 '
               +'   and substring(a.EMP_WORK,4,1) = ''1'' '
               +' order by a.NM_SAWON ',
               [Common.Config.StoreCode]);
      SetLength(ButtonData, Common.Query.RecordCount);
      vIndex := 0;
      while not Common.Query.Eof do
      begin
        ButtonData[vIndex].Code   := Common.Query.FieldByName('CD_SAWON').AsString;
        ButtonData[vIndex].Name   := Common.Query.FieldByName('NM_SAWON').AsString;
        ButtonData[vIndex].State  := Common.Query.FieldByName('STATE').AsString;
        Common.Query.Next;
        Inc(vIndex);
      end;
    end;
    smTableDamdang :
    begin
      CaptionLabel.Caption   := '테이블담당자';
      MessageLabel.Caption   := '담당자를 선택하세요';
      if (GetOption(254) = '1') and (GetOption(14) = '2') then
      begin
        CustInfoPanel.Visible := true;
        CustInfoPanel.Top     := 472;
        CustInfoPanel.Left    := 16;
        for vIndex := 1 to 6 do
        begin
          TAdvSmoothToggleButton(FindComponent(Format('GuestType%dButton',[vIndex]))).Visible := False;
          TAdvSmoothToggleButton(FindComponent(Format('GuestAge%dButton',[vIndex]))).Visible  := False;
        end;

        //객층버튼 셋팅
        OpenQuery('select * '
                 +'  from MS_CODE '
                 +' where CD_STORE  =:P0 '
                 +'   and CD_KIND   = ''04'' '
                 +'   and DS_STATUS = ''0'' '
                 +' order by CD_CODE '
                 +' limit 6 ',
                 [Common.Config.StoreCode]);

        vIndex := 0;
        while not Common.Query.Eof do
        begin
          Inc(vIndex);
          TAdvSmoothToggleButton(FindComponent(Format('GuestType%dButton',[vIndex]))).Caption := Common.Query.FieldByName('nm_code1').AsString;
          TAdvSmoothToggleButton(FindComponent(Format('GuestType%dButton',[vIndex]))).Hint    := Common.Query.FieldByName('cd_code').AsString;
          TAdvSmoothToggleButton(FindComponent(Format('GuestType%dButton',[vIndex]))).Visible := True;
          Common.Query.Next;
        end;

        //연령대 버튼 셋팅
        OpenQuery('select * '
                 +'  from MS_CODE '
                 +' where CD_STORE  =:P0 '
                 +'   and CD_KIND   =''14'' '
                 +'   and DS_STATUS =''0'' '
                 +' order by CD_CODE '
                 +' limit 6 ',
                 [Common.Config.StoreCode]);

        vIndex := 0;
        while not Common.Query.Eof do
        begin
          Inc(vIndex);
          TAdvSmoothToggleButton(FindComponent(Format('GuestAge%dButton',[vIndex]))).Caption := Common.Query.FieldByName('nm_code1').AsString;
          TAdvSmoothToggleButton(FindComponent(Format('GuestAge%dButton',[vIndex]))).Hint    := Common.Query.FieldByName('cd_code').AsString;
          TAdvSmoothToggleButton(FindComponent(Format('GuestAge%dButton',[vIndex]))).Visible := True;
          Common.Query.Next;
        end;
        Common.Query.Close;
      end;

      if GetOption(95) = '0' then
        OpenQuery('select a.CD_SAWON, '
                 +'       a.NM_SAWON, '
                 +'       case  when b.TIME_IN is null then ''미출근'' '
                 +'             else ''주문가능'' end as STATE, '
                 +'       '''', '
                 +'       '''' '
                 +'  from MS_SAWON     a left outer join '
                 +'       SL_SAWONWORK b on a.CD_STORE = b.CD_STORE '
                 +'                    and a.CD_SAWON  = b.CD_SAWON '
                 +'                    and b.TIME_OUT   is null '
                 +'                    and b.SETTLE_OUT is null  '
                 +' where a.CD_STORE =:P0                         '
                 + Ifthen(GetOption(254)='0', ' and substring(a.EMP_WORK,3,1) = ''1'' ', '')
                 +' order by a.CD_SAWON ',
                 [Common.Config.StoreCode])
      else //출근한 사원만 지정
        OpenQuery('select a.CD_SAWON, '
                  +'       a.NM_SAWON, '
                  +'       ''주문가능'' STATE, '
                  +'       '''', '
                  +'       '''' '
                  +' from MS_SAWON     a inner join '
                  +'      SL_SAWONWORK b on a.CD_STORE = b.CD_STORE '
                  +'                    and a.CD_SAWON = b.CD_SAWON '
                  +'                    and b.TIME_OUT   is null '
                  +'                    and b.SETTLE_OUT is null  '
                  +' where a.CD_STORE =:P0                        '
                  + Ifthen(GetOption(254)='0', ' and substring(a.EMP_WORK,3,1) = ''1'' ', '')
                  +'   and b.TIME_IN is not null '
                  +' order by b.TIME_IN, a.CD_SAWON ',
                 [Common.Config.StoreCode]);

      SetLength(ButtonData, Common.Query.RecordCount);
      vIndex := 0;
      while not Common.Query.Eof do
      begin
        ButtonData[vIndex].Code   := Common.Query.FieldByName('CD_SAWON').AsString;
        ButtonData[vIndex].Name   := Common.Query.FieldByName('NM_SAWON').AsString;
        ButtonData[vIndex].State  := Common.Query.FieldByName('STATE').AsString;
        Common.Query.Next;
        Inc(vIndex);
      end;
    end;
    smMenuGroup :
    begin
      CaptionLabel.Caption  := GroupMenuName;
      MessageLabel.Caption  := '메뉴를 선택하세요';
      PriorButton.Height    := 75;
      NextButton.Height     := 75;

      OpenQuery('select t1.CD_MENU_SET as CD_MENU, '
               +'       t2.NM_MENU_SHORT, '
               +'       t2.PR_SALE, '
               +'       case when t2.DS_MENU_TYPE = ''N'' then (select Count(*) '
               +'                                                 from MS_MENU '
               +'                                                where CD_STORE =t1.CD_STORE '
               +'                                                  and CD_MENU  =t1.CD_MENU_SET '
               +'                                                  and DS_MENU_TYPE = ''I'' '
               +'                                                  and YN_USE   = ''Y'') '
               +'            else 0 end as ITEM_COUNT, '
               +'       (select count(*) CNT '
               +'          from MS_MENU_MEMO '
               +'         where CD_STORE =t1.CD_STORE '
               +'           and CD_MENU  =t1.CD_MENU_SET) as MEMO_COUNT, '
               +'       t2.DS_MENU_TYPE, '
               +'       t2.CONFIG '
               +'  from MS_MENU_GROUP t1 inner join '
               +'       MS_MENU   t2 on t1.CD_STORE	   = t2.CD_STORE '
               +'                   and t1.CD_MENU_SET = t2.CD_MENU  '
               +' where t1.CD_STORE	=:P0 '
               +'   and t1.CD_MENU  =:P1 '
               +' order by t1.SEQ ',
               [Common.Config.StoreCode,
                GroupMenuCode]);

      SetLength(ButtonData, Common.Query.RecordCount);
      vIndex := 0;
      while not Common.Query.Eof do
      begin
        ButtonData[vIndex].Code      := Common.Query.FieldByName('CD_MENU').AsString;
        ButtonData[vIndex].Name      := Common.Query.FieldByName('NM_MENU_SHORT').AsString;
        ButtonData[vIndex].Price     := FormatFloat(',0',Common.Query.FieldByName('PR_SALE').AsInteger);
        ButtonData[vIndex].Count     := Common.Query.FieldByName('ITEM_COUNT').AsString;
        ButtonData[vIndex].Count2    := Common.Query.FieldByName('MEMO_COUNT').AsString;
        ButtonData[vIndex].MenuType  := Common.Query.FieldByName('DS_MENU_TYPE').AsString;
        if Copy(Common.Query.FieldByName('CONFIG').AsString,8,1) = 'Y' then
          ButtonData[vIndex].SoldOut := '품절'
        else
          ButtonData[vIndex].SoldOut := '';

        Common.Query.Next;
        Inc(vIndex);
      end;
    end;
    smKitchenMemo:
    begin
      CaptionLabel.Caption  := '주방메모';
      MessageLabel.Caption  := '주방메모를 선택하세요';
      PriorButton.Height    := 75;
      NextButton.Height     := 75;
      OpenQuery('select b.NM_CODE1 '
               +'  from MS_MENU_MEMO a inner join '
               +'       MS_CODE      b on a.CD_STORE = b.CD_STORE '
               +'                     and a.CD_MEMO  = b.CD_CODE '
               +'                     and b.CD_KIND  = ''18'' '
               +' where a.CD_STORE = :P0 '
               +'   and a.CD_MENU  = :P1 '
               +'   and b.DS_STATUS =''0'' '
               +' order by b.CD_CODE ',
               [Common.Config.StoreCode,
                GroupMenuCode]);
      if Common.Query.Eof then
        OpenQuery('select NM_CODE1 '
                 +'  from MS_CODE '
                 +' where CD_STORE =:P0 '
                 +'   and CD_KIND = ''18'' '
                 +'   and DS_STATUS =''0'' '
                 +' order by CD_CODE ',
                 [Common.Config.StoreCode]);

      SetLength(ButtonData, Common.Query.RecordCount);
      vIndex := 0;
      while not Common.Query.Eof do
      begin
        ButtonData[vIndex].Code      := '';
        ButtonData[vIndex].Name      := Common.Query.FieldByName('NM_CODE1').AsString;
        ButtonData[vIndex].Price     := FormatFloat(',0',Common.Query.FieldByName('PR_SALE').AsInteger);
        ButtonData[vIndex].Count     := Common.Query.FieldByName('ITEM_COUNT').AsString;
        ButtonData[vIndex].Count2    := Common.Query.FieldByName('MEMO_COUNT').AsString;
        ButtonData[vIndex].MenuType  := Common.Query.FieldByName('DS_MENU_TYPE').AsString;
        Common.Query.Next;
        Inc(vIndex);
      end;

    end;
  end;
  Common.Query.Options.QueryRecCount := false;
  Choose21Button.Visible := not  CustInfoPanel.Visible;
  Choose22Button.Visible := not  CustInfoPanel.Visible;
  Choose23Button.Visible := not  CustInfoPanel.Visible;

  if Choose23Button.Visible then
  begin
    PriorButton.Height := Choose23Button.Height;
    NextButton.Height  := Choose23Button.Height;
  end
  else
  begin
    PriorButton.Height := 57;
    NextButton.Height  := 57;
  end;

  SetButtonData;
end;

procedure TCommonChoose_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then CloseButton.Click;
end;

procedure TCommonChoose_F.FormShow(Sender: TObject);
begin
  FPage := 1;
  if strSelectMode = 'C' then
    SelectMode := smDeliveryCourse
  else if strSelectMode = 'I' then
    SelectMode := smDeliveryItem
  else if strSelectMode = 'L' then
    SelectMode := smDeliveryLocal
  else if strSelectMode = 'D' then
    SelectMode := smDeliveryMan
  else if strSelectMode = 'T' then
    SelectMode := smTableDamdang
  else if strSelectMode = 'G' then
    SelectMode := smMenuGroup;

  CustCode := '';
  AgeCode  := '';
end;

procedure TCommonChoose_F.GuestAge1ButtonClick(Sender: TObject);
var vIndex :Integer;
begin
  for vIndex := 1 to 6 do
    TAdvSmoothToggleButton(FindComponent(Format('GuestAge%dButton',[vIndex]))).Appearance.SimpleLayout := false;

  (Sender as TAdvSmoothToggleButton).Appearance.SimpleLayout := true;
  AgeCode := (Sender as TAdvSmoothToggleButton).Hint;
end;

procedure TCommonChoose_F.GuestType1ButtonClick(Sender: TObject);
var vIndex :Integer;
begin
  for vIndex := 1 to 6 do
    TAdvSmoothToggleButton(FindComponent(Format('GuestType%dButton',[vIndex]))).Appearance.SimpleLayout := false;

  (Sender as TAdvSmoothToggleButton).Appearance.SimpleLayout := true;
  CustCode := (Sender as TAdvSmoothToggleButton).Hint;
end;

procedure TCommonChoose_F.NewGuestButtonClick(Sender: TObject);
begin
  NewGuestButton.Enabled := true;
  OldGuestButton.Enabled := true;
  (Sender as TAdvSmoothButton).Enabled := false;
  Common.Table.DsCust := (Sender as TAdvSmoothButton).Hint;
end;

end.
