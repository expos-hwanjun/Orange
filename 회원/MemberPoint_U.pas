unit MemberPoint_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, KeyPad_F, StdCtrls, cxLabel, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxCurrencyEdit, ExtCtrls, cxMemo,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, StrUtils, Vcl.Menus,
  AdvGlassButton, PosButton, AdvSmoothToggleButton, cxButtons, dxGDIPlusClasses,
  AdvSmoothButton;

type TWorkKind = (wkNone, wkOccur, wkUse);
type
  TMemberPoint_F = class(TForm)
    edtPoint: TcxCurrencyEdit;
    edtOccur: TcxCurrencyEdit;
    edtUse: TcxCurrencyEdit;
    lblCode: TcxLabel;
    lblName: TcxLabel;
    lblWhy: TcxLabel;
    lblCardNo: TcxLabel;
    PointPanel: TPanel;
    meRemark: TcxMemo;
    CaptionLabel: TLabel;
    CloseButton: TcxButton;
    lblMenuCode: TcxLabel;
    lblMenuName: TcxLabel;
    KeepPointLabel: TcxLabel;
    lblMenuClass: TcxLabel;
    AddPointButton: TAdvSmoothToggleButton;
    UsePointButton: TAdvSmoothToggleButton;
    Point1Button: TPosButton;
    Point2Button: TPosButton;
    Point3Button: TPosButton;
    Point4Button: TPosButton;
    Point5Button: TPosButton;
    Point6Button: TPosButton;
    Point7Button: TPosButton;
    Point8Button: TPosButton;
    Point9Button: TPosButton;
    PriorButton: TPosButton;
    NextButton: TPosButton;
    MessageLabel: TLabel;
    Image3: TImage;
    SavePointLabel: TcxLabel;
    UsePointLabel: TcxLabel;
    cxLabel3: TcxLabel;
    fmKeyPad: TfmKeyPad;
    SaveButton: TAdvSmoothButton;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure AddPointButtonClick(Sender: TObject);
    procedure UsePointButtonClick(Sender: TObject);
    procedure Point1ButtonClick(Sender: TObject);
    procedure PriorButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
  private
    ButtonMaxCount :Integer;
    ButtonData      :Array of Array of String;
    ButtonPage :Integer;
    FWorkKind  :TWorkKind;
    FCode      :String;
    procedure SetButtonData;
    procedure DisplayData;
    procedure SetWorkKind(const Value: TWorkKind);
    property  WorkKind :TWorkKind read FWorkKind write SetWorkKind;
  public
  end;

var
  MemberPoint_F: TMemberPoint_F;

implementation
uses Common_U, GlobalFunc_U, DB, DBModule_U, Const_U;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TMemberPoint_F.FormShow(Sender: TObject);
var I :Integer;
begin
  lblWhy.Caption := '';
  if GetOption(21) = '1' then
  begin
    CaptionLabel.Caption := '스템프 적립/사용';

    KeepPointLabel.Caption := '보유스템프';
    SavePointLabel.Caption := '적립스템프';
    UsePointLabel.Caption  := '사용스템프';
  end;
  fmKeyPad.Top  := 181;
  fmKeyPad.Left := 381;

  WorkKind := wkOccur;
  Common.SetLanguage(Self);
end;

procedure TMemberPoint_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE : Close;
    VK_RETURN : SaveButtonClick(nil);
    VK_F10  :  if (ActiveControl is TCustomEdit) then TCustomEdit(ActiveControl).Clear;
  end;
end;

procedure TMemberPoint_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(SaveButton);
end;

procedure TMemberPoint_F.AddPointButtonClick(Sender: TObject);
begin
  if lblCode.Caption = '' then
  begin
    Common.ErrBox('회원을 먼저 조회하세요');
    Exit;
  end;
  if (WorkKind = wkOccur) and (PointPanel.Visible) then Exit;
  WorkKind := wkOccur;
end;

procedure TMemberPoint_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TMemberPoint_F.SaveButtonClick(Sender: TObject);
begin
  try
    if not Common.IsDebugMode then
      BlockInput(true);
    Common.SetButtonColor(SaveButton);
    if (edtOccur.Value = 0) and (edtUse.Value = 0) then
    begin
      Common.ErrBox(Format('%s를 입력하세요',[Ifthen(GetOption(21)='0','포인트','스템프')]));
      Exit;
    end;
    case WorkKind of
      wkOccur :
      begin
        try
          if GetOption(21) = '0' then
          begin
            if (edtOccur.Value > 1000000) and not Common.AskBox('적립포인트가 맞습니까?') then
               Exit;
             DM.ExecCloud('insert into SL_POINT(CD_HEAD,'
                         +'                     CD_STORE, '
                         +'                     YMD_OCCUR, '
                         +'                     NO_POS, '
                         +'                     SEQ, '
                         +'                     CD_MEMBER, '
                         +'                     CD_CODE,'
                         +'                     AMT_CASH,'
                         +'                     PNT_CASH,'
                         +'                     AMT_CARD,'
                         +'                     PNT_CARD,'
                         +'                     AMT_CASHRCP,'
                         +'                     PNT_CASHRCP,'
                         +'                     PNT_ADD, '
                         +'                     REMARK,'
                         +'                     AMT_EXCLUDE,'
                         +'                     RCP_LINK, '
                         +'                     CD_SAWON_CHG,'
                         +'                     DT_CHANGE) '
                         +'              values(:P0, '
                         +'                     :P1, '
                         +'                     :P2, '
                         +'                     :P3, '
                         +'                     (select ifnull(max(SEQ),0)+1 '
                         +'                        from SL_POINT as i'
                         +'                       where CD_HEAD  =:P0 '
                         +'                         and CD_STORE =:P1 '
                         +'                         and YMD_OCCUR=:P2 '
                         +'                         and NO_POS   =:P3), '
                         +'                     :P4, '
                         +'                     :P5, '
                         +'                      0, '
                         +'                     :P6, '
                         +'                      0, '
                         +'                      0, '
                         +'                      0, '
                         +'                      0, '
                         +'                     :P6, '
                         +'                     :P7, '
                         +'                      0, '
                         +'                     '''', '
                         +'                     :P8,'
                         +'                      Now());',
                         [Common.Config.HeadStoreCode,
                          Common.Config.StoreCode,
                          Common.NowDate,
                          '00',
                          lblCode.Caption,
                          FCode,
                          edtOccur.EditingValue,
                          meRemark.Text + Format('%s 포스에서 적립',[Common.Config.PosNo]),
                          Common.Config.UserCode],true,Common.RestDBURL);
          end
          else
          begin
            DM.ExecCloud('insert into SL_POINT(CD_HEAD,'
                        +'                     CD_STORE, '
                        +'                     YMD_OCCUR, '
                        +'                     NO_POS, '
                        +'                     SEQ, '
                        +'                     CD_MEMBER, '
                        +'                     CD_CODE, '
                        +'                     STAMP_ADD, '
                         +'                    REMARK,'
                        +'                     CD_SAWON_CHG, '
                        +'                     DT_CHANGE) '
                        +'             values( :P0, '
                        +'                     :P1, '
                        +'                     :P2, '
                        +'                     :P3, '
                        +'                     (select ifnull(max(SEQ),0)+1 '
                        +'                        from SL_POINT as i'
                        +'                       where CD_HEAD  =:P0 '
                        +'                         and CD_STORE =:P1 '
                        +'                         and YMD_OCCUR=:P2 '
                        +'                         and NO_POS   =:P3), '
                        +'                     :P4, '
                        +'                     :P5, '
                        +'                     :P6, '
                        +'                     :P7, '
                        +'                     :P8, '
                        +'                     Now()) ',
                        [Common.Config.HeadStoreCode,
                          Common.Config.StoreCode,
                          Common.NowDate,
                          '00',
                          lblCode.Caption,
                          FCode,
                          edtOccur.EditingValue,
                          meRemark.Text + Format('%s 포스에서 적립',[Common.Config.PosNo]),
                          Common.Config.UserCode],true,Common.RestDBURL);
          end;

          Common.MsgBox(Format('%s가 정상 적립되었습니다',[Ifthen(GetOption(21)='0','포인트','스템프')]));
        except
          on E: Exception do
          begin
            Common.ErrBox(E.Message);
            Exit;
          end;
        end;
      end;
      wkUse :
      begin
        if edtPoint.Value < edtUse.Value then
        begin
          Common.ErrBox(Format('%s가 부족합니다',[Ifthen(GetOption(21)='0','포인트','스템프')]));
          Exit;
        end;
        try
          if GetOption(21) = '0' then
          begin
            if (edtUse.Value > 1000000) and not Common.AskBox('사용포인트가 맞습니까?') then
              Exit;

            DM.ExecCloud('insert into SL_POINT(CD_HEAD, '
                        +'                     CD_STORE, '
                        +'                     YMD_OCCUR, '
                        +'                     NO_POS, '
                        +'                     SEQ, '
                        +'                     CD_MEMBER, '
                        +'                     CD_CODE,'
                        +'                     PNT_USE,'
                        +'                     REMARK, '
                        +'                     RCP_LINK, '
                        +'                     CD_SAWON_CHG,'
                        +'                     DT_CHANGE) '
                        +'              values(:P0, '
                        +'                     :P1, '
                        +'                     :P2, '
                        +'                     :P3, '
                        +'                    (select ifnull(max(SEQ),0)+1 '
                        +'                       from SL_POINT as i'
                        +'                      where CD_HEAD  =:P0 '
                        +'                        and CD_STORE =:P1 '
                        +'                        and YMD_OCCUR=:P2 '
                        +'                        and NO_POS   =:P3), '
                        +'                     :P4, '
                        +'                     :P5, '
                        +'                     :P6, '
                        +'                     :P7, '
                        +'                     '''', '
                        +'                     :P8, '
                        +'                     Now());',
                        [Common.Config.HeadStoreCode,
                         Common.Config.StoreCode,
                         Common.NowDate,
                         '00',
                         lblCode.Caption,
                         FCode,
                         edtUse.EditingValue,
                         meRemark.Text +Format('%s 포스에서 사용',[Common.Config.PosNo]),
                         Common.Config.UserCode],true,Common.RestDBURL);

          end
          else
          begin
            DM.ExecCloud('insert into SL_POINT(CD_HEAD,'
                        +'                     CD_STORE, '
                        +'                     YMD_OCCUR, '
                        +'                     NO_POS, '
                        +'                     SEQ, '
                        +'                     CD_MEMBER, '
                        +'                     CD_CODE, '
                        +'                     STAMP_USE, '
                         +'                    REMARK,'
                        +'                     CD_SAWON_CHG, '
                        +'                     DT_CHANGE) '
                        +'             values( :P0, '
                        +'                     :P1, '
                        +'                     :P2, '
                        +'                     :P3, '
                        +'                     (select ifnull(max(SEQ),0)+1 '
                        +'                        from SL_POINT as i'
                        +'                       where CD_HEAD  =:P0 '
                        +'                         and CD_STORE =:P1 '
                        +'                         and YMD_OCCUR=:P2 '
                        +'                         and NO_POS   =:P3), '
                        +'                     :P4, '
                        +'                     :P5, '
                        +'                     :P6, '
                        +'                     :P7, '
                        +'                     :P8, '
                        +'                     Now()) ',
                        [Common.Config.HeadStoreCode,
                          Common.Config.StoreCode,
                          Common.NowDate,
                          '00',
                          lblCode.Caption,
                          FCode,
                          edtUse.EditingValue,
                          meRemark.Text + Format('%s 포스에서 사용',[Common.Config.PosNo]),
                          Common.Config.UserCode],true,Common.RestDBURL);

          end;
          Common.MsgBox(Format('%s가 정상 사용되었습니다',[Ifthen(GetOption(21)='0','포인트','스템프')]));
        except
          on E: Exception do
          begin
            Common.ErrBox(E.Message);
            Exit;
          end;
        end;
      end;
    end;

    DM.OpenCloud('select TOTAL_POINT, '
                +'       TOTAL_STAMP '
                +'  from MS_MEMBER_ETC '
                +' where CD_HEAD   =:P0 '
                +'   and CD_STORE  =:P1 '
                +'   and CD_MEMBER =:P2 ',
                [Common.Config.HeadStoreCode,
                 Ifthen(GetHeadOption(5)='0',Common.Config.StoreCode,StandardStore),
                 lblCode.Caption],Common.RestDBURL);
    if not DM.CloudData.Eof then
    begin
      ExecQuery('update MS_MEMBER '
               +'   set TOTAL_POINT = :P2, '
               +'       TOTAL_STAMP = :P3 '
               +' where CD_STORE  =:P0 '
               +'   and CD_MEMBER =:P1 ',
               [Common.Config.StoreCode,
                lblCode.Caption,
                DM.CloudData.Fields[0].AsInteger,
                DM.CloudData.Fields[1].AsInteger]);
    end;
    DM.CloudData.Close;
    ModalResult := mrOK;
  finally
    BlockInput(false);
  end;
end;

procedure TMemberPoint_F.SetButtonData;
var Index :Integer;
begin
  PointPanel.Visible := True;
  ButtonPage := 1;

  OpenQuery('select CD_CODE, '
           +'       NM_CODE1, '
           +'       NM_CODE2 '
           +'  from MS_CODE '
           +' where CD_STORE =:P0 '
           +'   and CD_KIND  =:P1 '
           +'   and CD_CODE <> ''000'' '
           +'   and DS_STATUS = ''0'' '
           +' order by CD_CODE ',
           [Common.Config.StoreCode,
            Ifthen(WorkKind = wkOccur,'12','13')]);

  ButtonMaxCount := 0;
  while not Common.Query.Eof do
  begin
    ButtonMaxCount := ButtonMaxCount + 1;
    Common.Query.Next;
  end;

  SetLength(ButtonData, ButtonMaxCount, 3);

  Common.Query.First;
  Index := 0;
  while not Common.Query.Eof do
  begin
    ButtonData[Index, 0] := Common.Query.Fields[0].AsString;
    ButtonData[Index, 1] := Common.Query.Fields[1].AsString;
    ButtonData[Index, 2] := Common.Query.Fields[2].AsString;
    Inc(Index);
    Common.Query.Next;
  end;
  Common.Query.Close;
  DisplayData;
  if Point1Button.Caption <> '' then
    Point1ButtonClick(Point1Button);
end;

procedure TMemberPoint_F.DisplayData;
var vIndex :Integer;
begin
  For vIndex := 1 to 9 do
  begin
    TPosButton(FindComponent(Format('Point%dButton',[vIndex]))).Caption            := '';
    TPosButton(FindComponent(Format('Point%dButton',[vIndex]))).Bottom.RightString := '';
    TPosButton(FindComponent(Format('Point%dButton',[vIndex]))).Hint               := '';
    TPosButton(FindComponent(Format('Point%dButton',[vIndex]))).Visible            := false;
  end;

  For vIndex := 1  to 9 do
  begin
    if ( ((ButtonPage-1)*9) + vIndex ) > (High(ButtonData)+1) then Continue;
    TPosButton(FindComponent(Format('Point%dButton',[vIndex]))).Caption            := ButtonData[((ButtonPage-1)*9) + vIndex-1, 1];
    TPosButton(FindComponent(Format('Point%dButton',[vIndex]))).Bottom.RightString := ButtonData[((ButtonPage-1)*9) + vIndex-1, 2];
    TPosButton(FindComponent(Format('Point%dButton',[vIndex]))).Hint               := ButtonData[((ButtonPage-1)*9) + vIndex-1, 0];
    TPosButton(FindComponent(Format('Point%dButton',[vIndex]))).Visible            := true;
  end;
  PriorButton.Visible := ButtonPage > 1;
  NextButton.Visible  := ButtonPage <= ((High(ButtonData)+1) div 9);
end;

procedure TMemberPoint_F.Point1ButtonClick(Sender: TObject);
begin
  if (Sender as TPosButton).Caption = '' then Exit;
  PointPanel.Visible := False;
  fmKeyPad.Visible   := true;
  case WorkKind of
    wkOccur :
    begin
      edtOccur.Properties.ReadOnly := false;
      edtOccur.Value := StrToInt((Sender as TPosButton).Bottom.RightString);
      edtOccur.Properties.ReadOnly := edtOccur.Value > 0;
      edtOccur.SetFocus;
      FCode := (Sender as TPosButton).Hint;
    end;
    wkUse   :
    begin
      edtUse.Properties.ReadOnly := false;
      edtUse.Value   := StrToInt((Sender as TPosButton).Bottom.RightString);
      edtUse.Properties.ReadOnly := edtUse.Value > 0;
      edtUse.SetFocus;
      FCode := (Sender as TPosButton).Hint;
    end;
  end;
  lblWhy.Caption := (Sender as TPosButton).Caption;

end;

procedure TMemberPoint_F.PriorButtonClick(Sender: TObject);
begin
  if Sender = PriorButton then ButtonPage := ButtonPage -1
  else if Sender = NextButton then ButtonPage := ButtonPage +1;

  DisplayData;
end;

procedure TMemberPoint_F.SetWorkKind(const Value: TWorkKind);
begin
  FWorkKind := Value;
  case FWorkKind of
    wkNone  :
    begin
      FCode := '';
      PointPanel.Visible := true;
      PointPanel.Enabled := false;
      edtOccur.Enabled   := false;
      edtUse.Enabled     := false;
      meRemark.Enabled   := false;
    end;
    wkOccur :
    begin
      PointPanel.Visible := true;
      fmKeyPad.Visible   := false;
      edtOccur.Enabled   := true;
      edtUse.Enabled     := true;
      meRemark.Enabled   := true;
      AddPointButton.Appearance.SimpleLayout := true;
      AddPointButton.Status.Visible          := true;
      UsePointButton.Appearance.SimpleLayout := false;
      UsePointButton.Status.Visible          := false;
      AddPointButton.Color                   := $00DF7000;
      UsePointButton.Color                   := $00793D00;

//
//      AddPointButton.Appearance.SimpleLayout := true;
//      UsePointButton.Appearance.SimpleLayout := false;
      edtUse.Value := 0;
      edtUse.Properties.ReadOnly   := True;
      edtOccur.Properties.ReadOnly := True;
      CaptionLabel.Caption := Format('회원 %s 적립',[Ifthen(GetOption(21)='0','포인트','스템프')]);
      lblWhy.Caption   := '';
      SetButtonData;
      MessageLabel.Caption := '적립 사유를 선택하세요';
    end;
    wkUse   :
    begin
      PointPanel.Visible := true;
      fmKeyPad.Visible   := false;
      edtOccur.Enabled   := true;
      edtUse.Enabled     := true;
      meRemark.Enabled   := true;
      AddPointButton.Appearance.SimpleLayout := false;
      AddPointButton.Status.Visible          := false;
      UsePointButton.Appearance.SimpleLayout := true;
      UsePointButton.Status.Visible          := true;
      AddPointButton.Color := $00793D00;
      UsePointButton.Color  := $00DF7000;

//      AddPointButton.Appearance.SimpleLayout := false;
//      UsePointButton.Appearance.SimpleLayout := true;
      edtOccur.Value := 0;
      edtOccur.Properties.ReadOnly := True;
      edtUse.Properties.ReadOnly   := True;
      CaptionLabel.Caption := Format('회원 %s 사용',[Ifthen(GetOption(21)='0','포인트','스템프')]);
      lblWhy.Caption   := '';
      SetButtonData;
      MessageLabel.Caption := '사용 사유를 선택하세요';
    end;
  end;
end;
procedure TMemberPoint_F.UsePointButtonClick(Sender: TObject);
begin
  if lblCode.Caption = '' then
  begin
    Common.ErrBox('회원을 먼저 조회하세요');
    Exit;
  end;
  if (WorkKind = wkUse)   and (PointPanel.Visible) then Exit;
  WorkKind := wkUse;
end;

end.
