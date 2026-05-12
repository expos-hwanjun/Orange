unit KeyPad_F;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, StrUtils, Vcl.Buttons, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, Vcl.StdCtrls,
  Vcl.ImgList, dxSkinsCore, AdvSmoothButton;

type
  TfmKeyPad = class(TFrame)
    Num_7: TAdvSmoothButton;
    Num_8: TAdvSmoothButton;
    Num_9: TAdvSmoothButton;
    Num_4: TAdvSmoothButton;
    Num_5: TAdvSmoothButton;
    Num_6: TAdvSmoothButton;
    Num_1: TAdvSmoothButton;
    Num_2: TAdvSmoothButton;
    Num_3: TAdvSmoothButton;
    Num_0: TAdvSmoothButton;
    Num_BS: TAdvSmoothButton;
    Num_Enter: TAdvSmoothButton;
    Num_010: TAdvSmoothButton;
    Num_00: TAdvSmoothButton;
    Num_000: TAdvSmoothButton;
    DongButton: TAdvSmoothButton;
    HoButton: TAdvSmoothButton;
    MinusButton: TAdvSmoothButton;
    Num_CL: TAdvSmoothButton;
    procedure Num_7Click(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure Num_0Click(Sender: TObject);
    procedure Num_010Click(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation
uses Common_U, GlobalFunc_U;
{$R *.dfm}


constructor TfmKeyPad.Create(AOwner: TComponent);
var vIndex :Integer;
begin
  inherited;
  if (Common.Config.Style = 'D') and not Common.Config.IsKiosk then
  begin
    for vIndex := 0 to ComponentCount-1 do
    begin
      if Components[vIndex] is TAdvSmoothButton then
        (Components[vIndex] as TAdvSmoothButton).Color               := $00121212;
    end;
  end;
end;

procedure TfmKeyPad.FrameResize(Sender: TObject);
var vWidth, vHeight, vTop, vLeft, vIndex :Integer;
begin
  Exit;
  vWidth  := Self.Width  div 3 -1;
  vHeight := Self.Height div 4 -1;

  Num_7.Left := 0;
  Num_8.Left := vWidth + 1;
  Num_9.Left := vWidth * 2 + 2;
  Num_7.Top := 0;
  Num_8.Top := 0;
  Num_9.Top := 0;

  Num_4.Left := 0;
  Num_5.Left := vWidth + 1;
  Num_6.Left := vWidth * 2 + 2;
  Num_4.Top := vHeight + 1;
  Num_5.Top := vHeight + 1;
  Num_6.Top := vHeight + 1;

  Num_1.Left := 0;
  Num_2.Left := vWidth + 1;
  Num_3.Left := vWidth * 2 + 2;
  Num_1.Top := vHeight * 2 + 2;
  Num_2.Top := vHeight * 2 + 2;
  Num_3.Top := vHeight * 2 + 2;

  Num_0.Left     := 0;
  Num_BS.Left    := vWidth + 1;
  Num_Enter.Left := vWidth * 2 + 2;
  Num_0.Top      := vHeight * 3 + 3;
  Num_BS.Top     := vHeight * 3 + 3;
  Num_Enter.Top  := vHeight * 3 + 3;

  for vIndex := 0 to ComponentCount-1 do
  begin
    if Components[vIndex] is TAdvSmoothButton then
    begin
      (Components[vIndex] as TAdvSmoothButton).Width  := vWidth;
      (Components[vIndex] as TAdvSmoothButton).Height := vHeight;
    end;
  end;
  ParentBackground := true;
end;

procedure TfmKeyPad.Num_010Click(Sender: TObject);
begin
  Keybd_Event(VK_NUMPAD0,VK_NUMPAD0, 0, 0);
  Keybd_Event(VK_NUMPAD1,VK_NUMPAD1, 0, 0);
  Keybd_Event(VK_NUMPAD0,VK_NUMPAD0, 0, 0);
end;

procedure TfmKeyPad.Num_0Click(Sender: TObject);
begin
  Keybd_Event(VK_NUMPAD0,VK_NUMPAD0, 0, 0);
end;

procedure TfmKeyPad.Num_7Click(Sender: TObject);
   procedure NumApply(I:Integer);
   const VK_Key : Array[0..14] of Word = (VK_NUMPAD0,VK_NUMPAD1,VK_NUMPAD2,VK_NUMPAD3,VK_NUMPAD4
                                         ,VK_NUMPAD5,VK_NUMPAD6,VK_NUMPAD7,VK_NUMPAD8,VK_NUMPAD9
                                         ,VK_RETURN,VK_BACK, VK_F10, VK_DECIMAL, vk_Subtract);
   begin
      Keybd_Event(VK_Key[I],VK_Key[I], 0, 0);
   end;
begin



   if ((Sender as TAdvSmoothButton).Name = 'Num_Enter') then NumApply(10)
   else if ((Sender as TAdvSmoothButton).Name = 'Num_BS')  then NumApply(11)
   else if ((Sender as TAdvSmoothButton).Name = 'Num_CL')  then NumApply(12)
   else if ((Sender as TAdvSmoothButton).Name = 'Num_00') then
   begin
     Keybd_Event(VK_NUMPAD0,VK_NUMPAD0, 0, 0);
     Application.ProcessMessages;
     Keybd_Event(VK_NUMPAD0,VK_NUMPAD0, 0, 0);
     Application.ProcessMessages;
   end
   else if ((Sender as TAdvSmoothButton).Name = 'Num_000') then
   begin
     Keybd_Event(VK_NUMPAD0,VK_NUMPAD0, 0, 0);
     Application.ProcessMessages;
     Sleep(10);
     Keybd_Event(VK_NUMPAD0,VK_NUMPAD0, 0, 0);
     Application.ProcessMessages;
     Sleep(10);
     Keybd_Event(VK_NUMPAD0,VK_NUMPAD0, 0, 0);
     Application.ProcessMessages;
   end
   else
   begin
     NumApply(StrToInt(Copy((Sender as TAdvSmoothButton).Name,5,1)));
   end;

end;

end.
