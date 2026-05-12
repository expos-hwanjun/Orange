unit OpenPrice_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, cxLookAndFeelPainters, StdCtrls,
  cxButtons, KeyPad_F, Grids, Winsock, cxGraphics, cxLookAndFeels,
  AdvGlassButton, dxGDIPlusClasses, Vcl.ExtCtrls, AdvShape, AdvSmoothButton;

type
  TOpenPrice_F = class(TForm)
    Main_sGrd: TStringGrid;
    fmKeyPad1: TfmKeyPad;
    GridTitleShape: TAdvShape;
    MessageLabel: TLabel;
    Image3: TImage;
    TitleLabel: TLabel;
    CloseButton: TcxButton;
    ConfirmButton: TAdvSmoothButton;
    GridPrevButton: TAdvSmoothButton;
    GridNextButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure Main_sGrdDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Main_sGrdClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure GridPrevButtonClick(Sender: TObject);
  private
    IsRowChange :Boolean;
  public
    { Public declarations }
  end;

var
  OpenPrice_F: TOpenPrice_F;

implementation
uses Common_U, GlobalFunc_U, DBModule_U;

{$R *.dfm}
procedure TOpenPrice_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TOpenPrice_F.ConfirmButtonClick(Sender: TObject);
var vIndex :Integer;
begin
  try
    DM.TempSQL := '';
    Common.BeginTran;
    for vIndex := 0 to Main_sGrd.RowCount-1 do
    begin
      ExecQuery('update MS_MENU '
               +'   set PR_SALE = :P2 '
               +' where CD_STORE =:P0 '
               +'   and CD_MENU  =:P1',
               [Common.Config.StoreCode,
                Main_sGrd.Cells[0, vIndex],
                StoI(Main_sGrd.Cells[2, vIndex])]);

      DM.ExecCloud('update MS_MENU '
                  +'   set PR_SALE    = :P3, '
                  +'       PRG_CHANGE = ''POS'' '
                  +' where CD_HEAD  = :P0 '
                  +'   and CD_STORE = :P1 '
                  +'   and CD_MENU  = :P2;',
                  [Common.Config.HeadStoreCode,
                   Common.Config.StoreCode,
                   Main_sGrd.Cells[0, vIndex],
                   StoI(Main_sGrd.Cells[2, vIndex])],false,Common.RestDBURL);
    end;
    Common.CommitTran;
    DM.ExecCloud(DM.TempSQL,[],true,Common.RestDBURL);
  except
    on E:Exception do
    begin
      Common.RollbackTran;
      Common.WriteLog('싯가설정',E.Message);
      Common.ErrBox(E.Message+#13#13+'저장을 완료하지 못했습니다');
      Exit;
    end;
  end;
  ModalResult := mrOK;
end;

procedure TOpenPrice_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
  Common.SetButtonColor(GridTitleShape);
  Common.SetButtonColor(GridPrevButton);
  Common.SetButtonColor(GridNextButton);
  Common.SetButtonColor(ConfirmButton);
  with Main_SGrd do
  begin
    ColCount     := 3;
    ColWidths[0] := 90;   //상품코드
    ColWidths[1] := 260;  //상품명
    ColWidths[2] := 103;  //판매금액
  end;
  if GetOption(385) = '1' then
  begin
    fmKeyPad1.Num_000.Visible := false;
    fmKeyPad1.Num_00.Visible  := true;
    fmKeyPad1.Num_00.Top      := fmKeyPad1.Num_000.Top;
    fmKeyPad1.Num_00.Left     := fmKeyPad1.Num_000.Left;
  end;

  IsRowChange := True;
end;

procedure TOpenPrice_F.Main_sGrdDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var  i_align:Integer;
begin
  TStringGrid(Sender).Canvas.Font.Size := 13;
  if gdSelected in State then
  begin
    TStringGrid(Sender).Canvas.Font.Color  := clWhite;
    TStringGrid(Sender).Canvas.Brush.Color := $00AE5700;
  end
  else
  begin
    TStringGrid(Sender).Canvas.Brush.Color := clWhite;;
    TStringGrid(Sender).Canvas.Font.Color  := clBlack;
  end;

  case Acol of
    0   : i_align := 1; //가운데
    1   : i_align := 0; //왼쪽
    2   : i_align := 2; //우측정렬
  end;
  Common.Grid_Align(Sender, ACol, ARow, Rect, i_align);
  //    숫자형 출력시 Format 형식   //
  case ACol of
    2: Common.Grid_DisplayFormat(Sender, ACol, ARow, Rect);
  end;
end;

procedure TOpenPrice_F.FormShow(Sender: TObject);
begin
  OpenQuery('select CD_MENU, '
           +'       NM_MENU, '
           +'       PR_SALE  '
           +'  from MS_MENU  '
           +' where CD_STORE     =:P0 '
           +'   and DS_MENU_TYPE =''G'' '
           +' order by CD_MENU     ',
           [Common.Config.StoreCode]);
  while not Common.Query.Eof do
  begin
    if Main_sGrd.Cells[0,0] <> '' then Main_sGrd.RowCount := Main_sGrd.RowCount + 1;

    Main_sGrd.Cells[0, Main_sGrd.RowCount-1] := Common.Query.Fields[0].AsString;
    Main_sGrd.Cells[1, Main_sGrd.RowCount-1] := Common.Query.Fields[1].AsString;
    Main_sGrd.Cells[2, Main_sGrd.RowCount-1] := Common.Query.Fields[2].AsString;
    Common.Query.Next;
  end;
  Common.SetLanguage(Self);
end;

procedure TOpenPrice_F.GridPrevButtonClick(Sender: TObject);
begin
  if Sender = GridPrevButton then Common.RowPrev(Main_SGrd)
  else                            Common.RowNext(Main_SGrd);
end;

procedure TOpenPrice_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Main_sGrd.Cells[0,0] = '' then Exit;
  case Key of
    13 : Common.RowNext(Main_SGrd);
    48..57  :
    begin
      //Row가 바뀌었을때
      if IsRowChange then
      begin
        Main_sGrd.Cells[2, Main_sGrd.Row] := Chr(Key);
        IsRowChange := False;
      end
      else
      begin
        Main_sGrd.Cells[2, Main_sGrd.Row] := IntToStr(StrToIntDef(Main_sGrd.Cells[2, Main_sGrd.Row] + Chr(Key),0));
      end;
    end;
    96..105 :
      //Row가 바뀌었을때
      if IsRowChange then
      begin
        Main_sGrd.Cells[2, Main_sGrd.Row] := Chr(Key-48);
        IsRowChange := False;
      end
      else
      begin
        Main_sGrd.Cells[2, Main_sGrd.Row] := IntToStr(StrToIntDef(Main_sGrd.Cells[2, Main_sGrd.Row] + Chr(Key-48),0));
      end;
    VK_F10  :
    begin
      Main_sGrd.Cells[2, Main_sGrd.Row] := '0';
      IsRowChange := True;
    end;
    VK_BACK :
    begin
      if Length(Main_sGrd.Cells[2, Main_sGrd.Row]) <= 1 then
        Main_sGrd.Cells[2, Main_sGrd.Row] := '0'
      else
        Main_sGrd.Cells[2, Main_sGrd.Row] := Copy(Main_sGrd.Cells[2, Main_sGrd.Row], 1, Length(Main_sGrd.Cells[2, Main_sGrd.Row])-1);
    end;
  end;
end;

procedure TOpenPrice_F.Main_sGrdClick(Sender: TObject);
begin
  IsRowChange := True;
end;

end.
