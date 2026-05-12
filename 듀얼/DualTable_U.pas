unit DualTable_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, OleCtrls, ShockwaveFlashObjects_TLB, ActiveX, MPlayer,
  MMsystem;

type
  TDualTable_F = class(TForm)
    Panel1: TPanel;
    Swf: TShockwaveFlash;
    Swf_Tmr: TTimer;
    procedure Swf_TmrTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DualTable_F: TDualTable_F;
  FlashType        : String;
  FlashIndex       : Integer;
implementation
uses Common_U;
{$R *.dfm}

procedure TDualTable_F.Swf_TmrTimer(Sender: TObject);
  procedure FlashLoad(FileName: String);
  begin
     FlashType := UPPERCASE(Copy(FileName,Pos('.',FileName)+1,3));
     if FlashType = 'SWF' then
       Swf_Tmr.Interval := 500
     else if FlashType = 'JPG' then
       Swf_Tmr.Interval := 5000;

     if FileExists(Common.AppPath+'Swf\'+FileName) then
     begin
        Swf.Movie   := Common.AppPath+'Swf\'+FileName;
        if Common.FlashData.Count = 1 then Swf.Loop    := True
        else                               Swf.Loop    := False;
        Swf.Playing := True;
        Swf.DoObjectVerb(OLEIVERB_SHOW);
     end;
  end;
begin
   Swf_Tmr.Enabled := False;
   try
      if (Swf.IsPlaying) and (FlashType = 'SWF') then
      begin
        Swf_Tmr.Enabled := True;
        Exit;
      end;
      FlashIndex := FlashIndex + 1;
      if Common.FlashData.Count = FlashIndex then FlashIndex := 0;
      FlashLoad(Common.FlashData[FlashIndex]);
   except
   end;
   Swf_Tmr.Enabled := True;
end;

procedure TDualTable_F.FormCreate(Sender: TObject);
begin
  Swf.Stop;
  FlashIndex := -1;
  if Common.FlashData.Count > 0 then Swf_TmrTimer(nil);
  
  Swf_Tmr.Enabled := Common.FlashData.Count > 0;
end;

procedure TDualTable_F.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
