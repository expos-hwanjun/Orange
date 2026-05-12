unit Work_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB,
  MaskUtils, KeyPad_F, Menus, cxLookAndFeelPainters, cxButtons,
  cxControls, cxContainer, cxEdit, cxImage, MemDS,
  DBAccess, Uni, cxGraphics, cxLookAndFeels, AdvGlassButton, cxTextEdit, cxLabel,
  dxGDIPlusClasses, StrUtils, AdvSmoothButton, PNGImage, EncdDecd;

type
    TWorkKind = (wkNone, wkIn, wkOut, wkEnd);
type
  TWork_F = class(TForm)
    fmKeyPad1: TfmKeyPad;
    lblTitle: TLabel;
    CloseButton: TcxButton;
    cxLabel1: TcxLabel;
    UserIDEdit: TcxTextEdit;
    UserNameEdit: TcxLabel;
    cxLabel2: TcxLabel;
    InTimeEdit: TcxTextEdit;
    cxLabel3: TcxLabel;
    OutTimeEdit: TcxTextEdit;
    MessageLabel: TLabel;
    Image3: TImage;
    lbl_NowTime: TcxLabel;
    WorkButton: TAdvSmoothButton;
    SearchButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure UserIDEditPropertiesChange(Sender: TObject);
    procedure UserIDEditKeyPress(Sender: TObject; var Key: Char);
    procedure SearchButtonClick(Sender: TObject);
    procedure WorkButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FWorkKind : TWorkKind;
    FIsImage  : Boolean;
    ImgPhoto  : TImage;
    procedure GetImageCapture;
    procedure SetWorkKind(AValue:TWorkKind);
    property  WorkKind       :TWorkKind read FWorkKind  write SetWorkKind;
  public
    { Public declarations }
  end;

var
  Work_F: TWork_F;

implementation
uses Common_U, GlobalFunc_U, Capture_U, DBModule_U, WorkMan_U;
{$R *.dfm}

procedure TWork_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(WorkButton);
  Common.SetButtonColor(SearchButton);
  ImgPhoto := TImage.Create(Self);
end;

procedure TWork_F.FormDestroy(Sender: TObject);
begin
  ImgPhoto.Free;
end;

procedure TWork_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case Key of
     VK_F10  :  if (ActiveControl is TCustomEdit) then TCustomEdit(ActiveControl).Clear;
   end;
end;

procedure TWork_F.SearchButtonClick(Sender: TObject);
var vKey :Char;
begin
  WorkMan_F := TWorkMan_F.Create(Self);
  try
    if WorkMan_F.ShowModal = mrOk then
    begin
      vKey := #13;
      UserIDEdit.Text := WorkMan_F.SelectCode;
      UserIDEditKeyPress(UserIDEdit, vKey);
    end;
  finally
    FreeAndNil(WorkMan_F);
  end;

end;

procedure TWork_F.SetWorkKind(AValue: TWorkKind);
begin
  FWorkKind := AValue;
  lbl_NowTime.Caption := FormatMaskText('!0000년 90월 90일 00:00;0; ',Common.NowDate+Common.NowTime);
  Application.ProcessMessages;
  case FWorkKind of
    wkNone :
     begin
       UserNameEdit.Caption := '';
       InTimeEdit.Clear;
       OutTimeEdit.Clear;
       WorkButton.Visible         := False;
       InTimeEdit.Enabled         := False;
       OutTimeEdit.Enabled        := False;
     end;
     wkIn :
     begin
       WorkButton.Visible          := True;
       WorkButton.Caption         := '출 근';
       InTimeEdit.Enabled         := True;
       OutTimeEdit.Enabled        := False;
       if InTimeEdit.Enabled then InTimeEdit.SetFocus;
     end;
     wkOut:
     begin
       WorkButton.Visible         := True;
       WorkButton.Caption         := '퇴 근';
       InTimeEdit.Enabled         := False;
       OutTimeEdit.Enabled        := True;
       if InTimeEdit.Enabled then OutTimeEdit.SetFocus;
     end;
     wkEnd:
     begin
       WorkButton.Visible         := False;
       InTimeEdit.Enabled         := False;
       OutTimeEdit.Enabled        := False;
       if InTimeEdit.Enabled then UserIDEdit.SetFocus;
     end;
  end;
  MessageLabel.Caption := '';
end;

procedure TWork_F.UserIDEditKeyPress(Sender: TObject; var Key: Char);
var vInDate :TDateTime;
begin
  if Key <> #13 then Exit;
  case WorkKind of
    wkEnd :
    begin
      UserIDEdit.Clear;
      WorkKind := wkNone;
    end;
    wkNone:
    begin
      UserIDEdit.Text := LPad(UserIDEdit.Text,6,'0');
      if Trim(UserIDEdit.Text) = EmptyStr then
      begin
        Common.ErrBox('사원번호가 올바르지 않습니다');
        if UserIDEdit.Enabled then
          UserIDEdit.SetFocus;
        Exit;
      end;

      OpenQuery('select NM_SAWON '
               +'  from MS_SAWON '
               +' where CD_STORE =:P0 '
               +'   and CD_SAWON =:P1 ',
               [Common.Config.StoreCode,
                UserIDEdit.Text]);
      if Common.Query.Eof then
      begin
        Common.ErrBox('사원번호가 올바르지 않습니다');
        if UserIDEdit.Enabled then
          UserIDEdit.SetFocus;
        Exit;
      end;


      DM.OpenCloud('select TIME_IN '
                  +'  from SL_SAWONWORK '
                  +' where CD_HEAD  =:P0 '
                  +'   and CD_STORE =:P1 '
                  +'   and CD_SAWON =:P2 '
                  +'   and TIME_OUT is null '
                  +'   and SETTLE_OUT is null '
                  +' order by SETTLE_IN desc '
                  +' limit 1 ',
                  [Common.Config.HeadStoreCode,
                   Common.Config.StoreCode,
                   UserIDEdit.Text],Common.RestDBURL);
      if DM.CloudData.Eof then
      begin
        DM.CloudData.Close;
        DM.OpenCloud('select b.NM_SAWON, '
                    +'       Ifnull(Date_Format(a.TIME_IN, ''%H:%i''),'''') as TIME_IN, '
                    +'       Ifnull(Date_Format(a.TIME_OUT, ''%H:%i''),'''') as TIME_OUT '
                    +'  from SL_SAWONWORK a inner join '
                    +'       MS_SAWON     b on b.CD_HEAD  = a.CD_HEAD '
                    +'                     and b.CD_STORE = a.CD_STORE '
                    +'                     and b.CD_SAWON = a.CD_SAWON '
                    +' where a.CD_HEAD  =:P0 '
                    +'   and a.CD_STORE =:P1 '
                    +'   and a.CD_SAWON =:P2 '
                    +'   and Date_Format(a.SETTLE_IN, ''%Y%m%d'') = Date_Format(Now(), ''%Y%m%d'') ',
                    [Common.Config.HeadStoreCode,
                     Common.Config.StoreCode,
                     UserIDEdit.Text],Common.RestDBURL);
        if not DM.CloudData.Eof then
        begin
          UserNameEdit.Caption := DM.CloudData.FieldByName('NM_SAWON').AsString;
          InTimeEdit.Text      := DM.CloudData.FieldByName('TIME_IN').AsString;
          OutTimeEdit.Text     := DM.CloudData.FieldByName('TIME_OUT').AsString;
          DM.CloudData.Close;
        end
        else
        begin
          OpenQuery('select NM_SAWON '
                   +'  from MS_SAWON '
                   +' where CD_STORE =:P0 '
                   +'   and CD_SAWON =:P1 ',
                   [Common.Config.StoreCode,
                    UserIDEdit.Text]);

          UserNameEdit.Caption := Common.Query.FieldByName('NM_SAWON').AsString;
          InTimeEdit.Text      := EmptyStr;
          OutTimeEdit.Text     := EmptyStr;
          Common.Query.Close;
        end;
      end
      else
      begin
        vInDate := DM.CloudData.FieldByName('TIME_IN').AsDateTime;
        DM.CloudData.Close;
        DM.OpenCloud('select a.NM_SAWON, '
                    +'       Ifnull(Date_Format(b.TIME_IN, ''%H:%i''),'''') as TIME_IN, '
                    +'       Ifnull(Date_Format(b.TIME_OUT, ''%H:%i''),'''') as TIME_OUT '
                    +'  from MS_SAWON      a left outer join '
                    +'       SL_SAWONWORK  b on b.CD_HEAD  = a.CD_HEAD '
                    +'                      and b.CD_STORE = a.CD_STORE '
                    +'                      and b.CD_SAWON = a.CD_SAWON '
                    +'                      and Date_Format(b.TIME_IN, ''%Y%m%d%H%i'')  =:P3 '
                    +' where a.CD_HEAD  =:P0 '
                    +'   and a.CD_STORE =:P1 '
                    +'   and a.CD_SAWON =:P2 ',
                    [Common.Config.HeadStoreCode,
                     Common.Config.StoreCode,
                     UserIDEdit.Text,
                     FormatDateTime('yyyymmddhhnn', vInDate)],Common.RestDBURL);

        UserNameEdit.Caption := DM.CloudData.FieldByName('NM_SAWON').AsString;
        InTimeEdit.Text      := DM.CloudData.FieldByName('TIME_IN').AsString;
        OutTimeEdit.Text     := DM.CloudData.FieldByName('TIME_OUT').AsString;
        DM.CloudData.Close;
      end;

      if (InTimeEdit.Text <> '') and (OutTimeEdit.Text <> '') then
        WorkKind := wkEnd
      else if InTimeEdit.Text = ''       then
      begin
        WorkKind         := wkIn;
        GetImageCapture;
      end
      else if OutTimeEdit.Text = '' then
      begin
        WorkKind         := wkOut;
        GetImageCapture;
      end;
    end;
    wkIn,
    wkOut : WorkButtonClick(WorkButton);
  end;
end;

procedure TWork_F.UserIDEditPropertiesChange(Sender: TObject);
begin
  WorkKind := wkNone;
end;

procedure TWork_F.WorkButtonClick(Sender: TObject);
var vStream  : TMemoryStream;
    vPNG     : TPNGImage;
    vPayCode : String;
    vInDate  : TDateTime;
begin
  try
    UserIDEdit.Enabled := false;
    if (GetOption(265) = '1') and not FIsImage then
    begin
      if not Common.AskBox('사원 이미지가 저장되지 않았습니다'+#13#13+'계속하시겠습니까?') then Exit;
    end;
    OpenQuery('select CD_TIME_PAY '
             +'  from MS_SAWON '
             +' where CD_STORE =:P0 '
             +'   and CD_SAWON =:P1 ',
             [Common.Config.StoreCode,
              UserIDEdit.Text]);
    if not Common.Query.Eof then
      vPayCode := Common.Query.Fields[0].AsString
    else
      vPayCode := EmptyStr;

    case WorkKind of
     wkIn :
       begin
         if Trim(UserIDEdit.Text) = EmptyStr then
         begin
           Common.ErrBox('사원번호가 올바르지 않습니다');
           if UserIDEdit.Enabled then UserIDEdit.SetFocus;
           Exit;
         end;

         try
           try
             vPNG     := TPNGImage.Create;
             vStream  := TMemoryStream.Create;
             vPNG.Assign(ImgPhoto.Picture.Graphic);
             vPNG.SaveToStream ( vStream );
             DM.ExecCloud('insert into SL_SAWONWORK(CD_HEAD, '
                         +'                         CD_STORE, '
                         +'                         CD_SAWON, '
                         +'                         TIME_IN, '
                         +'                         SETTLE_IN, '
                         +'                         NO_POS, '
                         +'                         IMG_IN, '
                         +'                         CD_TIME, '
                         +'                         IP_ADDRESS) '
                         +'                  values(:P0, '
                         +'                         :P1, '
                         +'                         :P2, '
                         +'                         Now(), '
                         +'                         Now(), '
                         +'                         :P3, '
                         +'                         :P4, '
                         +'                         :P5, '
                         +'                         :P6);',
                         [Common.Config.HeadStoreCode,
                          Common.Config.StoreCode,
                          UserIDEdit.Text,
                          Common.Config.PosNo,
                          EncodeBase64(vStream.Memory, vStream.Size),
                          vPayCode,
                          Common.Config.PosIP],true,Common.RestDBURL);
           finally
             vStream.Free;
             vPNG.Free;
           end;

           InTimeEdit.Text := FormatMaskText('!00:00;0; ',Common.NowTime);
           WorkKind := wkEnd;
           MessageLabel.Caption := '출근점각이 완료되었습니다';
         except
           on E: Exception do
           begin
             Common.ErrBox(E.Message+#13#13+'저장을 완료하지 못했습니다');
           end;
         end;
       end;
     wkOut:
       begin
         if Trim(UserIDEdit.Text) = EmptyStr then
         begin
           Common.ErrBox('사원번호가 올바르지 않습니다');
           if UserIDEdit.Enabled then UserIDEdit.SetFocus;
           Exit;
         end;
         try
           DM.OpenCloud('select TIME_IN, '
                       +'       TIMESTAMPDIFF(MINUTE, TIME_IN, Now()) '
                       +'  from SL_SAWONWORK '
                       +' where CD_HEAD  =:P0 '
                       +'   and CD_STORE =:P1 '
                       +'   and CD_SAWON =:P2 '
                       +'   and TIME_OUT is null '
                       +'   and SETTLE_OUT is null '
                       +' order by SETTLE_IN desc '
                       +' limit 1 ',
                       [Common.Config.HeadStoreCode,
                        Common.Config.StoreCode,
                        UserIDEdit.Text],Common.RestDBURL);

           if DM.CloudData.Fields[1].AsInteger < 30 then
           begin
             DM.CloudData.Close;
             Common.ErrBox('근무시간이 30분이 이상이어야 합니다');
             Exit;
           end
           else
           begin
             vInDate := DM.CloudData.Fields[0].AsDateTime;
             DM.CloudData.Close;

             try
               vPNG     := TPNGImage.Create;
               vStream  := TMemoryStream.Create;
               vPNG.Assign(ImgPhoto.Picture.Graphic);
               vPNG.SaveToStream ( vStream );
               DM.ExecCloud('update SL_SAWONWORK '
                           +'   set TIME_OUT   = Now(), '
                           +'       SETTLE_OUT = Now(), '
                           +'       IMG_OUT    = :P4, '
                           +'       CD_TIME    = :P5 '
                           +' where CD_HEAD  =:P0 '
                           +'   and CD_STORE =:P1 '
                           +'   and CD_SAWON =:P2 '
                           +'   and Date_Format(TIME_IN, ''%Y%m%d%H%i'') =:P3;',
                          [Common.Config.HeadStoreCode,
                           Common.Config.StoreCode,
                           UserIDEdit.Text,
                           FormatDateTime('yyyymmddhhnn', vInDate),
                           EncodeBase64(vStream.Memory, vStream.Size),
                           vPayCode],true,Common.RestDBURL);
             finally
               vStream.Free;
               vPNG.Free;
             end;
           end;
           OutTimeEdit.Text := FormatMaskText('!00:00;0; ',Common.NowTime);
           WorkKind := wkEnd;
           MessageLabel.Caption := '퇴근점각이 완료되었습니다';
         except
           on E: Exception do
           begin
             Common.ErrBox(E.Message+#13#13+'저장을 완료하지 못했습니다');
           end;
         end;
       end;
    end;
  finally
    UserIDEdit.Enabled := true;
  end;
end;

procedure TWork_F.FormShow(Sender: TObject);
begin
  Common.SetSystemTimeSync;
  WorkKind := wkNone;
  Common.SetLanguage(Self);
end;

procedure TWork_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;


procedure TWork_F.GetImageCapture;
begin
  FIsImage := False;
  if GetOption(265) = '0' then Exit;
  if Common.GetCamCapture then
  begin
    if FileExists(Common.AppPath+'Capture.bmp') then
    begin
      ImgPhoto.Picture.LoadFromFile(Common.AppPath+'Capture.bmp');
      FIsImage := True;
    end
    else
      FIsImage := False;
  end
  else
  begin
    WorkKind := wkNone;
    UserIDEdit.Clear;
  end;
end;

end.
