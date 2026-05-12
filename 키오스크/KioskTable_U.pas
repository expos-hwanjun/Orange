unit KioskTable_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StrUtils, Math, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, MMSystem,
  Vcl.Menus, Vcl.StdCtrls, cxButtons, AdvSmoothToggleButton, AdvSmoothButton,
  Vcl.Buttons, IniFiles;

type
  TKioskTable_F = class(TForm)
    CloseTimer: TTimer;
    CloseButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseButtonClick(Sender: TObject);
  private
    FontSize  :Integer;
    FontColor :TColor;
    procedure TableClick(Sender: TObject);
    procedure ButtonCreate(aTableNo, aTop, aLeft, aHeight, aWidth: Integer; aTableName, aHold:String);
  public
    TableNo :Integer;
    isClearMode :Boolean;
  end;

var
  KioskTable_F: TKioskTable_F;

implementation
uses Common_U, Const_U, GlobalFunc_U;
{$R *.dfm}
procedure BlockInput(ABlockInput : boolean); stdcall; external 'USER32.DLL';

procedure TKioskTable_F.ButtonCreate(aTableNo, aTop, aLeft, aHeight,
  aWidth: Integer; aTableName, aHold:String);
begin
  with TSpeedButton.Create(Self) do
  begin
    Parent                        := Self;
    Top                           := aTop;
    Left                          := aLeft;
    Height                        := aHeight;
    Width                         := aWidth;
    Flat                          := true;
    Tag                           := aTableNo;
    OnClick                       := TableClick;
    Cursor                        := crHandPoint;
    Hint                          := aHold;
    if (GetOption(488)='1') then
    begin
      Font.Name   := Common.Config.KioskDefaultFontName;
      Font.Size   := FontSize;
      Font.Color  := FontColor;
      if isClearMode then
      begin
        if aHold = 'Y' then
          Caption := '[테이블정리]'
        else
        begin
          Caption := aTableName;
          Enabled := false;
        end;
      end
      else
        Caption         := Ifthen(aHold = 'Y','이용중',aTableName);
    end;

    BringToFront;
  end;

//  with TAdvSmoothButton.Create(Application) do
//  begin
//    Parent                        := Self;
//    Top                           := aTop;
//    Left                          := aLeft;
//    Height                        := aHeight;
//    Width                         := aWidth;
//    Appearance.Rounding           := 10;
//    Color                         := $00D26900;//clSilver;
//    Bevel                         := false;
//    Shadow                        := false;
//    ClickDelay                    := true;
//    AllowTimer                    := true;
//    Appearance.GlowPercentage     := 20;
//    Appearance.GlowPercentage     := 10;
//    Appearance.Font.Size          := 25;
//    Appearance.Font.Color         := clWhite;
//    Appearance.SimpleLayout       := true;
//    Appearance.SimpleLayoutBorder := true;
//    Tag                           := aTableNo;
//    ShowFocus                     := false;
//    OnClick                       := TableClick;
//    Cursor                        := crHandPoint;
//    Hint                          := aHold;
//    if isClearMode then
//    begin
//      if aHold = 'Y' then
//        Caption := '[테이블정리]'
//      else
//      begin
//        Caption := aTableName;
//        Enabled := false;
//      end;
//    end
//    else
//      Caption         := Ifthen(aHold = 'Y','이용중',aTableName);
//
//    Cursor          := crHandPoint;
//    BringToFront;
//  end;
end;

procedure TKioskTable_F.FormCreate(Sender: TObject);
begin
  isClearMode := false;
  Common.SetButtonColor(CloseButton);
  with TIniFile.Create(Common.AppPath+'Kiosk\KioskConfig.ini') do
  try
    FontSize   := ReadInteger('Table','FontSize',25);
    FontColor  := StringToColorDef(ReadString('Table','FontColor', 'clWhite'),clWhite);
    WriteInteger('Table', 'FontSize', FontSize);
    WriteString('Table', 'FontColor', ColorToString(FontColor));
  finally
    Free;
  end;

end;

procedure TKioskTable_F.TableClick(Sender: TObject);
begin
  Common.KioskTouchBeep('kioskwave12');
  if (Sender as TSpeedButton).Tag > 0 then
  begin
    if isClearMode then
    begin
      ExecQuery('update MS_TABLE '
               +'   set YN_TABLEHOLD = ''N'' '
               +' where CD_STORE =:P0 '
               +'   and NO_TABLE =:P1',
               [Common.Config.StoreCode,
                (Sender as TSpeedButton).Tag]);
      Close;
    end
    else
    begin
      if (GetOption(488) = '1') and ((Sender as TSpeedButton).Caption = '이용중') then
        Common.MsgBox('현재 사용중인 테이블입니다'#13'다른 테이블을 선택해주세요',5)
      else
      begin
        TableNo     := (Sender as TSpeedButton).Tag;
        ModalResult := mrOK;
      end;
    end;
  end
  else ModalResult := mrNo;
end;

procedure TKioskTable_F.FormShow(Sender: TObject);
var vFileName : String;
begin

  BlockInput(false);
  vFileName := '';
  if (GetOption(426) = '5') and (Common.KioskWaitList.Count > 0) then
    vFileName := Common.KioskWaitList[0]
  else if FileExists(Common.AppPath+'\Kiosk\KioskTable.jpg') then
    vFileName := Common.AppPath+'\Kiosk\KioskTable.jpg'
  else if FileExists(Common.AppPath+'\Kiosk\KioskTable.png') then
    vFileName := Common.AppPath+'\Kiosk\KioskTable.png';
  if (vFileName <> '') and FileExists(vFileName) then
  begin
    with TImage.Create(Self) do
    begin
      Parent := Self;
      Picture.Bitmap.TransparentColor := clNone;
      Picture.LoadFromFile(vFileName);
      SendToBack;
      Align             := alClient;
      Transparent       := true;
    end;
  end;

  try
    OpenQuery('select a.NO_TABLE, '
             +'       b.NM_TABLE, '
             +'       a.NO_TOP, '
             +'       a.NO_LEFT, '
             +'       a.NO_HEIGHT, '
             +'       a.NO_WIDTH, '
             +'       b.YN_TABLEHOLD '
             +'  from MS_KIOSK_TABLE a inner join '
             +'       MS_TABLE       b on b.CD_STORE = a.CD_STORE '
             +'                       and b.NO_TABLE = a.NO_TABLE '
             +' where a.CD_STORE =:P0 ',
             [Common.Config.StoreCode]);

    if Common.Query.Eof then
    begin
      Common.MsgBox('설정된 테이블이 없습니다',5);
      CloseTimer.Interval := 100;
      CloseTimer.Enabled  := true;
      Exit;
    end;

    while not Common.Query.Eof do
    begin
      ButtonCreate(Common.Query.FieldByName('NO_TABLE').AsInteger,
                   Common.Query.FieldByName('NO_TOP').AsInteger,
                   Common.Query.FieldByName('NO_LEFT').AsInteger,
                   Common.Query.FieldByName('NO_HEIGHT').AsInteger,
                   Common.Query.FieldByName('NO_WIDTH').AsInteger,
                   Common.Query.FieldByName('NM_TABLE').AsString,
                   Common.Query.FieldByName('YN_TABLEHOLD').AsString);
      Common.Query.Next;
    end;
  finally
    Common.Query.Close;
  end;

  if not isClearMode then
  begin
    PlaySound(nil, 0, SND_MEMORY or SND_ASYNC);
    PlaySound(PChar('kioskwave9'), Common.DllHandle, SND_RESOURCE or SND_ASYNC);
  end;
end;

procedure TKioskTable_F.CloseButtonClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TKioskTable_F.CloseTimerTimer(Sender: TObject);
begin
  CloseTimer.Enabled := false;
  ModalResult := mrCancel;
end;

procedure TKioskTable_F.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CloseTimer.Enabled := false;
end;

end.
