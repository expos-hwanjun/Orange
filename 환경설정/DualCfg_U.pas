unit DualCfg_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Buttons,MaskUtils, StdCtrls, ExtCtrls, OXSpeedButton,
  GraphicEx, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus,
  dxGDIPlusClasses, AdvGlassButton, AdvShape, cxButtons;

type
  TDualCfg_F = class(TForm)
    Flash_sGrd: TStringGrid;
    OpenDialog1: TOpenDialog;
    TitleLabel: TLabel;
    CloseButton: TcxButton;
    GridTitleShape: TAdvShape;
    GridPriorButton: TAdvGlassButton;
    GridNextButton: TAdvGlassButton;
    AddButton: TAdvGlassButton;
    DeleteButton: TAdvGlassButton;
    SaveButton: TAdvGlassButton;
    MessageLabel: TLabel;
    Image3: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Flash_sGrdDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure CloseButtonClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure GridPriorButtonClick(Sender: TObject);
  private
    procedure FileLoad;
  public
    { Public declarations }
  end;

var
  DualCfg_F: TDualCfg_F;
const GDF_NO     = 0;
      GDF_FILE   = 1;

implementation
uses Common_U, GlobalFunc_U, DBModule_U;
{$R *.dfm}

procedure TDualCfg_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);

  with Flash_sGrd do
  begin
    ColCount              := 3;
    ColWidths[GDF_NO]     := 39;
    ColWidths[GDF_FILE]   := 250;
  end;
  if not DirectoryExists(Common.AppPath+'Dual') then
    CreateDir(Common.AppPath+'Dual');
  OpenDialog1.InitialDir := Common.AppPath+'Dual';
  FileLoad;
end;

procedure TDualCfg_F.GridPriorButtonClick(Sender: TObject);
begin
  if Sender = GridPriorButton then
    Common.RowPrev(Flash_sGrd)
  else
    Common.RowNext(Flash_sGrd);
end;

procedure TDualCfg_F.AddButtonClick(Sender: TObject);
var Files: TSearchRec;
    vIndex : Integer;
    vTemp : String;
begin
  if Not DirectoryExists(Common.AppPath+'\Dual') then
    CreateDir(Common.AppPath+'\Dual');

  if not OpenDialog1.Execute then exit;
  FindFirst(OpenDialog1.FileName,faArchive,Files);

  With Flash_sGrd do
  begin
    {화일이 존재하는지 체크}
    For vIndex := 0 to RowCount-1 do
      if Files.Name = Cells[GDF_FILE,  vIndex] then Exit;

    if Cells[0,0] <> '' then RowCount:= RowCount+1;
    Cells[GDF_NO,    RowCount-1] := IntTostr(RowCount);
    Cells[GDF_FILE,  RowCount-1] := Files.Name;
    Row := RowCount-1;
  end;
end;

procedure TDualCfg_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TDualCfg_F.DeleteButtonClick(Sender: TObject);
begin
  Common.DeleteRow(Flash_sGrd, Flash_sGrd.Row);
  Common.GridRefresh(Flash_sGrd);
end;

procedure TDualCfg_F.FileLoad;
begin
  with Flash_sGrd do
  begin
    OpenQuery('select NM_CODE1 '
             +'  from MS_CODE '
             +' where CD_STORE =:P0 '
             +'   and CD_KIND = ''96'' '
             +' order by CD_CODE ',
             [Common.Config.StoreCode]);
    Common.Query.First;
    While not Common.Query.Eof do
    begin
      if Cells[0,0] <> '' then RowCount := RowCount+1;
      Cells[GDF_NO,    RowCount-1] := IntToStr(RowCount);
      Cells[GDF_FILE,  RowCount-1] := Common.Query.FieldByName('NM_CODE1').AsString;
      Common.Query.Next;
    end;
  end;
end;

procedure TDualCfg_F.Flash_sGrdDrawCell(Sender: TObject; ACol,
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
    0 :  i_align := 1; //가운데
    1,2 :  i_align := 3; //좌측
  end;
  Common.Grid_Align(Sender, ACol, ARow, Rect, i_align);
end;

procedure TDualCfg_F.SaveButtonClick(Sender: TObject);
var vIndex : Integer;
    vSQL   : String;
begin
  DM.ExecCloud('delete from MS_CODE '
              +' where CD_HEAD  =:P0 '
              +'   and CD_STORE =:P1 '
              +'   and CD_KIND  =''96''; ',
              [Common.Config.HeadStoreCode,
               Common.Config.StoreCode],false);

  if Flash_sGrd.Cells[0,0] <> '' then
  begin
    For vIndex := 0 to Flash_sGrd.RowCount-1 do
    begin
      DM.ExecCloud('insert into MS_CODE(CD_HEAD, CD_STORE, CD_KIND, CD_CODE, NM_CODE1) '
                  +'             values(:P0, :P1, :P2, :P3, :P4);',
                  [Common.Config.HeadStoreCode,
                   Common.Config.StoreCode,
                   '96',
                   Lpad(IntToStr(vIndex+1),3,'0'),
                   Flash_sGrd.Cells[GDF_FILE,   vIndex]],false);
    end;
  end;

  if not DM.ExecCloud('',[],true) then
  begin
    Common.MsgBox('서버 접속 실패 !!!.'#13'잠시 후 다시 실행해 주십시오.');
    Exit;
  end;

  try
    vSQL := vSQL + Format('delete from MS_CODE where CD_STORE = ''%s'' and CD_KIND = ''96'';',[Common.Config.StoreCode]);

    DM.OpenCloud('select CD_STORE, CD_KIND, CD_CODE, NM_CODE1 '
                +'  from MS_CODE '
                +' where CD_HEAD    =:P0 '
                +'   and CD_STORE   =:P1 '
                +'   and CD_KIND  =''96'' ',
                [Common.Config.HeadStoreCode,
                 Common.Config.StoreCode]);

    vSQL := vSQL + DM.GetCloudData('MS_CODE');

    DM.StoredProc.StoredProcName := 'MULTI_EXECUTE';
    DM.StoredProc.Prepare;
    DM.StoredProc.ParamByName('@SQL').AsString := vSQL;
    DM.StoredProc.ExecProc;
  except
    on E: Exception do
    begin
      Common.WriteLog('SaveButtonClick',E.Message);
      Common.ErrBox(E.Message+#13#13+'저장하지 못했습니다');
      Exit;
    end;
  end;

  try
    Common.BeginTran;
    ExecQuery('delete from MS_CODE '
             +' where  CD_STORE =:P0 '
             +'   and  CD_KIND = ''96'' ',
             [Common.Config.StoreCode]);
    if Flash_sGrd.Cells[0,0] <> '' then
    begin
      For vIndex := 0 to Flash_sGrd.RowCount-1 do
      begin
        ExecQuery('insert into MS_CODE(CD_STORE, CD_KIND, CD_CODE, NM_CODE1) '
                 +'             values(:P0, :P1, :P2, :P3)',
                 [Common.Config.StoreCode,
                  '96',
                  Lpad(IntToStr(vIndex+1),3,'0'),
                  Flash_sGrd.Cells[GDF_FILE,   vIndex]]);
      end;
    end;
    Common.CommitTran;
  except
    on E: Exception do
    begin
      Common.RollbackTran;
      Common.ErrBox(E.Message);
      Exit;
    end;
  end;
  ModalResult := mrOK;
end;

end.
