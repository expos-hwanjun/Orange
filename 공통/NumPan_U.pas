unit NumPan_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, OleCtrls,  
  KeyPad_F, jpeg, cxControls, cxContainer, cxEdit, cxTextEdit, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, StrUtils, cxLabel, Vcl.Menus, cxButtons,
  Vcl.Clipbrd, AdvSmoothButton;

type
  TNumPan_F = class(TForm)
    fmKeyPad1: TfmKeyPad;
    InputEdit: TcxTextEdit;
    CaptionLabel: TcxLabel;
    CloseButton: TcxButton;
    OkButton: TAdvSmoothButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure fmKeyPad1Num_EnterClick(Sender: TObject);
    procedure fmKeyPad1Num_BSClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure fmKeyPad1Num_8Click(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure fmKeyPad1Num_CLClick(Sender: TObject);
  private
    FMsrData   :String;
    IsFirstKey :Boolean;
    procedure CreateFlatRoundRgn;
  public
    FInitValue :String;
    FMaxValue  :Integer;
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  NumPan_F: TNumPan_F;

implementation
uses Common_U, GlobalFunc_U, MaskUtils;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure ExcludeRectRgn(var Rgn: HRGN; LeftRect, TopRect, RightRect, BottomRect: Integer);
var
  RgnEx: HRGN;
begin
  RgnEx := CreateRectRgn(LeftRect, TopRect, RightRect, BottomRect);
  CombineRgn(Rgn, Rgn, RgnEx, RGN_OR);
  DeleteObject(RgnEx);
end;

procedure TNumPan_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,3);
  Common.SetButtonColor(OKButton);
  if (Common.Config.Style = 'D') and not Common.Config.IsKiosk then
    OkButton.Color := $00121212;
  CreateFlatRoundRgn;
end;

procedure TNumPan_F.FormShow(Sender: TObject);
var vBool :Boolean;
    vIndex :Integer;
begin
  BlockInput(false);
  if GetOption(385) = '1' then
  begin
    fmKeyPad1.Num_000.Visible := false;
    fmKeyPad1.Num_00.Visible  := true;
    fmKeyPad1.Num_00.Top      := fmKeyPad1.Num_000.Top;
    fmKeyPad1.Num_00.Left     := fmKeyPad1.Num_000.Left;
  end;

  vBool := True;
  if (CaptionLabel.Caption = '패스워드를 입력하세요')  or (CaptionLabel.Caption = '관리자 암호를 입력하세요') then
  begin
    vBool := False;
    InputEdit.Properties.EchoMode     := eemPassword;
    InputEdit.Properties.PasswordChar := '*';
  end
  else
  begin
    InputEdit.Properties.EchoMode     := eemNormal;
    InputEdit.Properties.PasswordChar := #0;
  end;

  InputEdit.Clear;
  InputEdit.Properties.Alignment.Horz := taRightJustify;
  if (FInitValue <> '') then
  begin
    if FInitValue = '010' then
    begin
      InputEdit.Text := FInitValue+'-';
      InputEdit.Properties.Alignment.Horz := taCenter;
      vBool          := false;
    end
    else
    begin
      if (Common.KeyPadType <> 2) and (InputEdit.Properties.MaxLength <> 300) then
        InputEdit.Text := FormatFloat(Ifthen(Common.KeyPadType=0,',0','0.#'),StoF(FInitValue))
      else
      begin
        InputEdit.Properties.Alignment.Horz := taCenter;
        InputEdit.Text := FInitValue;
      end;
    end;
    InputEdit.SelectAll;
  end;
  if InputEdit.Properties.MaxLength = 0 then
    InputEdit.Properties.AssignedValues.MaxLength := False;
  if InputEdit.Properties.MaxValue = 0 then
    InputEdit.Properties.AssignedValues.MaxValue := False;

  FMsrData   := EmptyStr;
  IsFirstKey := vBool;
end;

procedure TNumPan_F.OKButtonClick(Sender: TObject);
  function Get2Track(AValue:String):String;
  var I   :Integer;
  begin
    if FInitValue = '010' then Exit;
     Result := '';
     For I:=1 to Length(AValue) do
     begin
        Case AValue[I] of
          #48..#57, #61: Result := Result + AValue[I];
        end;
     end;
  end;
begin
//  fmKeyPad1.Num_7Click(fmKeyPad1.Num_Enter);
  if InputEdit.Properties.MaxLength <> 300 then
  begin
    if (FInitValue = '010') and not IsMobileNumber(GetOnlyNumber(InputEdit.Text)) then
    begin
      if not Common.AskBox('전화번호가 올바르지 않습니다'#13'계속하시겠습니까?') then
        Exit;
      InputEdit.Text := '';
    end;
    ModalResult := mrOK;
  end
  else
  begin
    if Length(InputEdit.Text) < 20 then
      ModalResult := mrOK
    else
    begin
      InputEdit.Text := Get2Track(InputEdit.Text);
      if Pos('=',InputEdit.Text) > 0 then
        InputEdit.Text  := Copy(InputEdit.Text,1,Pos('=',InputEdit.Text)-1);
      ModalResult := mrOK
    end;
  end;
end;

procedure TNumPan_F.CloseButtonClick(Sender: TObject);
begin
  InputEdit.Text := '';
  Close;
end;

procedure TNumPan_F.CreateFlatRoundRgn;
const
  CORNER_SIZE = 10;
var
  Rgn: HRGN;
begin
  with BoundsRect do
  begin
    Rgn := CreateRoundRectRgn(0, 0, Right - Left + 1, Bottom - Top + 1, CORNER_SIZE, CORNER_SIZE);
    // exclude left-bottom corner
    ExcludeRectRgn(Rgn, 0, Bottom - Top - CORNER_SIZE div 2, CORNER_SIZE div 2, Bottom - Top + 1);
    // exclude right-bottom corner
    ExcludeRectRgn(Rgn, Right - Left - CORNER_SIZE div 2, Bottom - Top - CORNER_SIZE div 2, Right - Left , Bottom - Top);
  end;
  // the operating system owns the region, delete the Rgn only SetWindowRgn fails
  if SetWindowRgn(Handle, Rgn, True) = 0 then
    DeleteObject(Rgn);
end;

procedure TNumPan_F.CreateParams(var Params: TCreateParams);
const
  CS_DROPSHADOW = $00020000;
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP;
    WindowClass.Style := WindowClass.Style or CS_DROPSHADOW;
  end;
end;

procedure TNumPan_F.fmKeyPad1Num_8Click(Sender: TObject);
begin
  fmKeyPad1.Num_7Click(Sender);

end;

procedure TNumPan_F.fmKeyPad1Num_BSClick(Sender: TObject);
begin
  fmKeyPad1.Num_7Click(Sender);
end;

procedure TNumPan_F.fmKeyPad1Num_CLClick(Sender: TObject);
begin
  fmKeyPad1.Num_7Click(Sender);
end;

procedure TNumPan_F.fmKeyPad1Num_EnterClick(Sender: TObject);
begin
  fmKeyPad1.Num_7Click(Sender);

end;


procedure TNumPan_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  procedure CheckMaxValue(aKey:Word);
  var vTemp :Currency;
  begin
    if FInitValue = '010' then
    begin
      InputEdit.Text := InputEdit.Text + Chr(aKey);
      Exit;
    end;
    if (FMaxValue > 0) and (Length(GetOnlyNumber(InputEdit.Text)) = Length(IntToStr(FMaxValue)))  then Exit;

    vTemp := StoF(InputEdit.Text + Chr(aKey));
    if (FMaxValue > 0) and (FMaxValue < vTemp) and (Common.KeyPadType <> 2) then
      InputEdit.Text := FormatFloat(Ifthen(Common.KeyPadType=0,',0','0.#'),FMaxValue)
    else if (Length(InputEdit.Text + Chr(aKey)) <= InputEdit.Properties.MaxLength) or (InputEdit.Properties.MaxLength = 0) then
    begin
      if (FMaxValue > 0) and (Common.KeyPadType <> 2) then
        InputEdit.Text := FormatFloat(Ifthen(Common.KeyPadType=0,',0','0.#'), StoF(InputEdit.Text + Chr(aKey)))
      else
        InputEdit.Text := InputEdit.Text + Chr(aKey);
    end;
  end;
  function Get2Track(AValue:String):String;
  var I   :Integer;
  begin
    if FInitValue = '010' then Exit;
     Result := '';
     For I:=1 to Length(AValue) do
     begin
        Case AValue[I] of
          #48..#57, #61: Result := Result + AValue[I];
        end;
     end;
  end;
var vTemp :String;
begin
   if (Shift = [ssCtrl]) and (Key = Ord('V')) then
   begin
     InputEdit.Text := GetOnlyNumber(Clipboard.AsText);
     Exit;
   end;
   if IsFirstKey and (Key <> 13) then
   begin
     InputEdit.Text := '';
     IsFirstKey     := False;
   end;
   if InputEdit.Properties.MaxLength <> 300 then
   begin
     case Key of
         27      :  begin InputEdit.Clear; ModalResult := mrOK; end;
         48..57  :  CheckMaxValue(Key);
         96..105 :  CheckMaxValue(Key-48);
         8       :  InputEdit.Text := copy(InputEdit.Text, 1, Length(InputEdit.Text)-1);
         189,109 :  InputEdit.Text := InputEdit.Text + '-';
         110     :  InputEdit.Text := InputEdit.Text + '.';
         VK_F10  :  begin
                      if FInitValue = '010' then
                        InputEdit.Text := '010-'
                      else if FMaxValue > 0 then InputEdit.Text := '0' else InputEdit.Clear;
                    end;
         13      :
         begin
           if (FInitValue = '010') and not IsMobileNumber(GetOnlyNumber(InputEdit.Text)) then
           begin
             if not Common.AskBox('전화번호가 올바르지 않습니다'#13'계속하시겠습니까?') then
               Exit;
             InputEdit.Text := '';
           end;

           ModalResult := mrOK;
         end;
      end;
   end
   else
   begin
     case Key of
         27      :  begin InputEdit.Clear; ModalResult := mrOK; end;
         VK_F10  :  InputEdit.Clear;
         8       :  InputEdit.Text := copy(InputEdit.Text, 1, Length(InputEdit.Text)-1);
         13      :
                 begin
                   if Length(InputEdit.Text) < 20 then
                     ModalResult := mrOK
                   else
                   begin
                     InputEdit.Text := Get2Track(InputEdit.Text);
                     if Pos('=',InputEdit.Text) > 0 then
                        InputEdit.Text  := Copy(InputEdit.Text,1,Pos('=',InputEdit.Text)-1);
                     ModalResult := mrOK
                   end;
                 end;
         61,187  :  InputEdit.Text := InputEdit.Text + '=';
            110  :  InputEdit.Text := InputEdit.Text + '.';
         48..57  :  InputEdit.Text := InputEdit.Text + Chr(Key);
         96..105 :  InputEdit.Text := InputEdit.Text + Chr(Key-48);
     end;
  end;
  if FInitValue = '010' then
  begin
    vTemp := GetOnlyNumber(InputEdit.Text);
    case Length(vTemp) of
      3 : InputEdit.Text := FormatMaskText('!000-;0;',vTemp);
      4 : InputEdit.Text := FormatMaskText('!000-0;0;',vTemp);
      5 : InputEdit.Text := FormatMaskText('!000-00;0;',vTemp);
      6 : InputEdit.Text := FormatMaskText('!000-000;0;',vTemp);
      7 : InputEdit.Text := FormatMaskText('!000-0000;0;',vTemp);
      8 : InputEdit.Text := FormatMaskText('!000-0000-0;0;',vTemp);
      9 : InputEdit.Text := FormatMaskText('!000-0000-00;0;',vTemp);
     10 : InputEdit.Text := FormatMaskText('!000-0000-000;0;',vTemp);
     11 : InputEdit.Text := FormatMaskText('!000-0000-0000;0;',vTemp);
    end;
  end;
end;


end.

.
