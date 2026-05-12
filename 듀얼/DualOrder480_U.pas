unit DualOrder480_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, Grids, OleCtrls, ActiveX,
  ShockwaveFlashObjects_TLB, GraphicEx, Mask, 
  cxControls, cxContainer, cxEdit, cxTextEdit, cxCurrencyEdit, cxLabel,
  MPlayer, KeyPad_F, ImgList, IniFiles, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, cxGroupBox;

type
  TDualOrder480_F = class(TForm)
    Swf_Tmr: TTimer;
    ImgList: TImageList;
    Dual_sGrd: TStringGrid;
    CurrencyEdit1: TcxCurrencyEdit;
    CurrencyEdit3: TcxCurrencyEdit;
    CurrencyEdit2: TcxCurrencyEdit;
    Panel1: TPanel;
    Swf: TShockwaveFlash;
    panNews: TcxGroupBox;
    lblName: TcxLabel;
    lblAddr: TcxLabel;
    panScale: TcxGroupBox;
    imgDualScale: TImage;
    lblPincode: TcxLabel;
    lblGrade: TcxLabel;
    lblOrigin: TcxLabel;
    lblButcheryDay: TcxLabel;
    lblPrice: TcxLabel;
    lblKeep: TcxLabel;
    lblMenuName: TcxLabel;
    lblAmt: TcxLabel;
    lblWeight: TcxLabel;
    procedure FormCreate(Sender: TObject);
    procedure Swf_TmrTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FMemberName,
    FMemberPoint : TLabel;
    DelayTime :Integer;
    procedure FlashLoad(FileName:String);
  public
    IsDoObjectVerb : Boolean;  
  end;

var
  DualOrder480_F: TDualOrder480_F;
  FlashType  : String;
implementation
uses Common_U, GlobalFunc_U, Const_U;
{$R *.dfm}

procedure TDualOrder480_F.FormCreate(Sender: TObject);
begin
  Common.ImageCreate(Self,'dualorder480form');
  Common.EventApply(Self);

  DelayTime := Common.GetIniFile('DEVICE', '듀얼이미지',  5);
  if DelayTime = 0 then DelayTime := 5;

  if GetOption(177) = '0' then
  begin
    if Common.Config.ScalePort > 0 then
      Common.ImageApply(imgDualScale, 'imgDualScale1', 'GIF');
      
    panScale.Top  := 265;
    panScale.Left := 6;
    imgDualScale.Height := 195;
    panScale.Height     := 210;
    lblPrice.Visible := false;
  end
  else
  begin
    Common.ImageApply(imgDualScale, 'imgDualScale', 'GIF');
    panScale.Top  := 7;
    panScale.Left := 6;
  end;
  IsDoObjectVerb      := True;
  {그리드 초기화}
  with Dual_SGrd do
  begin
     OnDrawCell := Common.GridDrawCell;
     ColCount                 := GDM_COLCOUNT;
     ColWidths[GDM_NO       ] := 33;    //순번
     ColWidths[GDM_TYPE     ] := -1;    //순번
     ColWidths[GDM_NM_MENU  ] := 273;   //메뉴명
     ColWidths[GDM_VIEWQTY  ] := 50;    //수량
     ColWidths[GDM_VIEWPRICE] := 117;   //메뉴단가
     ColWidths[GDM_DC_MENU  ] := -1;    //할인단가
     ColWidths[GDM_AMT      ] := -1;    //메뉴금액
     DefaultRowHeight    := Common.Config.DualGridRowHeight;
     Font.Size           := Common.Config.DualGridFontSize;
  end;

  Swf.Stop;
  if Common.FlashData.Count > 0 then Swf_TmrTimer(nil);
  Swf_Tmr.Enabled := Common.FlashData.Count > 0;
  Swf.Visible     := Swf_Tmr.Enabled;
end;

procedure TDualOrder480_F.FlashLoad(FileName: String);
begin
   FlashType := UPPERCASE(Copy(FileName,Pos('.',FileName)+1,3));
   if FlashType = 'SWF' then
     Swf_Tmr.Interval := 500
   else if FlashType = 'JPG' then
     Swf_Tmr.Interval := DelayTime * 1000;

   if FileExists(Common.AppPath+'Swf\'+FileName) then
   begin
      Swf.Movie   := Common.AppPath+'Swf\'+FileName;
      if Common.FlashData.Count = 1 then Swf.Loop    := True
      else                               Swf.Loop    := False;
      Swf.Playing := True;
      if IsDoObjectVerb then
      begin
        Swf.DoObjectVerb(OLEIVERB_SHOW);
        IsDoObjectVerb := False;
      end;
   end;
end;

procedure TDualOrder480_F.Swf_TmrTimer(Sender: TObject);
begin
   Swf_Tmr.Enabled := False;
   try
      if (Swf.IsPlaying) and (FlashType = 'SWF') then
      begin
        Swf_Tmr.Enabled := True;
        Exit;
      end;
      Common.FlashIndex := Common.FlashIndex + 1;
      if Common.FlashData.Count = Common.FlashIndex then Common.FlashIndex := 0;
      FlashLoad(Common.FlashData[Common.FlashIndex]);
   except
   end;
   Swf_Tmr.Enabled := True;
end;

procedure TDualOrder480_F.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;


end.


