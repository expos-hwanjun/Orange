unit CashBookCode_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, cxControls,
  cxContainer, cxEdit, cxTextEdit, Menus, cxLookAndFeelPainters, cxButtons,
  cxMemo, KeyPad_F, cxCurrencyEdit, cxGraphics, cxLookAndFeels, AdvGlassButton,
  AdvShape, cxLabel, dxGDIPlusClasses, AdvGlowButton, StrUtils,
  AdvSmoothToggleButton, AdvSmoothButton;

type
  TCashBookCode_F = class(TForm)
    fmKeyPad1: TfmKeyPad;
    RemarkMemo: TcxMemo;
    Label1: TLabel;
    CloseButton: TcxButton;
    GridTitleShape: TAdvShape;
    cxLabel3: TcxLabel;
    InPutAmtEdit: TcxCurrencyEdit;
    MessageLabel: TLabel;
    Image3: TImage;
    sgr_Grid: TStringGrid;
    CodeAppendButton: TAdvGlassButton;
    InButton: TAdvSmoothToggleButton;
    OutButton: TAdvSmoothToggleButton;
    CardButton: TAdvSmoothButton;
    CashButton: TAdvSmoothButton;
    AdvSmoothButton1: TAdvSmoothButton;
    AdvSmoothButton2: TAdvSmoothButton;
    AdvSmoothButton3: TAdvSmoothButton;
    AdvSmoothButton4: TAdvSmoothButton;
    AdvSmoothButton5: TAdvSmoothButton;
    AdvSmoothButton6: TAdvSmoothButton;
    AdvSmoothButton7: TAdvSmoothButton;
    AdvSmoothButton8: TAdvSmoothButton;
    AdvSmoothButton9: TAdvSmoothButton;
    AdvSmoothButton10: TAdvSmoothButton;
    AdvSmoothButton11: TAdvSmoothButton;
    AdvSmoothButton12: TAdvSmoothButton;
    AdvSmoothButton13: TAdvSmoothButton;
    AdvSmoothButton14: TAdvSmoothButton;
    GridPrevButton: TAdvSmoothButton;
    GridNextButton: TAdvSmoothButton;
    procedure FormCreate(Sender: TObject);
    procedure sgr_GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sgr_GridClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseButtonClick(Sender: TObject);
    procedure GridPrevButtonClick(Sender: TObject);
    procedure CodeAppendButtonClick(Sender: TObject);
    procedure CardButtonClick(Sender: TObject);
    procedure InButtonClick(Sender: TObject);
    procedure AdvGlassButton1Click(Sender: TObject);
  private
    procedure SelectCode(aKind:Integer; aValue: String);
  public
    WorkDate :String;
  end;

var
  CashBookCode_F: TCashBookCode_F;

implementation
uses Common_U, GlobalFunc_U, CashBook_U, CashBookMem_U, Const_U, DBModule_U;
{$R *.dfm}

procedure TCashBookCode_F.FormCreate(Sender: TObject);
var vIndex :Integer;
begin
  Common.LogoCreate(Self,2);
  if Common.Config.Style = 'D' then
    Common.SetButtonColor(GridTitleShape);

  for vIndex := 0 to ComponentCount-1 do
  begin
    if Components[vIndex] is TAdvSmoothButton then
      Common.SetButtonColor((Components[vIndex] as TAdvSmoothButton));

    if Components[vIndex] is TAdvGlassButton then
      Common.SetButtonColor((Components[vIndex] as TAdvGlassButton));
  end;

  sgr_Grid.ColWidths[0] := 80;
  sgr_Grid.ColWidths[1] := 395;
  sgr_Grid.ColWidths[2] := 80;
  sgr_Grid.ColWidths[3] := 115;
end;

procedure TCashBookCode_F.sgr_GridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var  i_align : integer;
begin
  TStringGrid(Sender).Canvas.Font.Size := Common.Config.ListFontSize;
  if gdSelected in State then
  begin
    TStringGrid(Sender).Canvas.Font.Color  := clWhite;
    TStringGrid(Sender).Canvas.Brush.Color := $00FFA74F;
  end
  else
  begin
    TStringGrid(Sender).Canvas.Font.Color  := clBlack;
    TStringGrid(Sender).Canvas.Brush.Color := clWhite;
  end;
  case Acol of
     1 :  i_align  := 0; //ÁÂÃø
     0,2 :  i_align  := 1; //°¡¿îµ¥
     3 :  i_align  := 2;
  end;
  Common.Grid_Align(Sender, ACol, ARow, Rect, i_align);
  // ¼ýÀÚÇü Ãâ·Â½Ã Format Çü½Ä   //
  case ACol of
    3: Common.Grid_DisplayFormat(Sender, ACol, ARow, Rect);
  end;
end;

procedure TCashBookCode_F.FormShow(Sender: TObject);
begin
  InButtonClick(OutButton);
  Common.SetLanguage(Self);
end;

procedure TCashBookCode_F.GridPrevButtonClick(Sender: TObject);
begin
  if Sender = GridPrevButton then Common.RowPrev(sgr_Grid)
  else if Sender = GridNextButton  then Common.RowNext(sgr_Grid);
end;

procedure TCashBookCode_F.InButtonClick(Sender: TObject);
begin
  if Sender = InButton then
  begin
    CardButton.Enabled := True;
    SelectCode(1,'0');
    MessageLabel.Caption := Common.GetPaPago('¼öÀÔ±Ý¾×À» ÀÔ·ÂÇÏ¼¼¿ä');

    InButton.Appearance.SimpleLayout := true;
    InButton.Status.Visible          := true;
    OutButton.Appearance.SimpleLayout    := false;
    OutButton.Status.Visible             := false;
    InButton.Color := $00DF7000;
    OutButton.Color  := $00793D00;
  end
  else
  begin
    CardButton.Enabled := False;
    SelectCode(1,'1');
    MessageLabel.Caption := Common.GetPapago('ÁöÃâ±Ý¾×À» ÀÔ·ÂÇÏ¼¼¿ä');

    InButton.Appearance.SimpleLayout := false;
    InButton.Status.Visible          := false;
    OutButton.Appearance.SimpleLayout    := true;
    OutButton.Status.Visible             := true;
    InButton.Color := $00793D00;
    OutButton.Color  := $00DF7000;
  end;
end;

procedure TCashBookCode_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE : Close;
    VK_F10  :  if not InPutAmtEdit.Focused and not RemarkMemo.Focused then
                 InPutAmtEdit.Value := 0
               else if (ActiveControl is TCustomEdit) then
                 TCustomEdit(ActiveControl).Clear;
    8       :  if not InPutAmtEdit.Focused and not RemarkMemo.Focused then
                 InPutAmtEdit.Value := StrToIntDef(Copy(IntToStr(InPutAmtEdit.EditValue), 1, Length(IntToStr(InPutAmtEdit.EditValue))-1),0);
    13      :  CardButtonClick(CashButton);
    48..57  :  if not InPutAmtEdit.Focused and not RemarkMemo.Focused then
                 InPutAmtEdit.Value := StrToInt(IntToStr(InPutAmtEdit.EditValue) + Chr(Key));
    96..105 :  if not InPutAmtEdit.Focused and not RemarkMemo.Focused then
                 InPutAmtEdit.Value := StrToInt(IntToStr(InPutAmtEdit.EditValue) + Chr(Key-48));
   end;
end;

procedure TCashBookCode_F.SelectCode(aKind:Integer; aValue: String);
const
  nChar :Array[1..15] of String =('°¡','³ª','´Ù','¶ó','¸¶','¹Ù','»ç','¾Æ','ÀÚ','Â÷','Ä«','Å¸','ÆÄ','ÇÏ','ÆR');
var vTemp :String;
begin
  if aKind = 1 then
    OpenQuery('select CD_CODE, '
             +'       NM_CODE1, '
             +'       case when NM_CODE2 = ''0'' then ''¼öÀÔ'' '
             +'            else ''ÁöÃâ'' '
             +'       end as NM_CODE2, '
             +'       NM_CODE3 '
             +'  from MS_CODE '
             +' where CD_STORE =:P0 '
             +'   and CD_KIND =''11'' '
             +'   and NM_CODE2 =:P1 '
             +'   and NM_CODE3 IN '+Ifthen(aValue='0', '(''0'', ''1'', ''2'') ','(''0'',''1'')' )
             +'   and DS_STATUS = ''0'' '
             +' order by CD_CODE ',
             [Common.Config.StoreCode,
              aValue])
  else
  begin
    if InButton.Appearance.SimpleLayout then
      vTemp := '0'
    else
      vTemp := '1';
    OpenQuery('select CD_CODE, '
             +'       NM_CODE1, '
             +'       case when NM_CODE2 = ''0'' then ''¼öÀÔ'' '
             +'            else ''ÁöÃâ'' '
             +'       end as NM_CODE2, '
             +'       NM_CODE3 '
             +'  from MS_CODE '
             +' where CD_STORE =:P0    '
             +'   and CD_KIND =''11'' '
             +'   and NM_CODE2 =:P1 '
             +'   and NM_CODE3 IN '+Ifthen(aValue='0', '(''0'', ''1'', ''2'') ','(''0'',''1'')' )
             +'   and substring(NM_CODE1,1,1) >= :P2 '
             +'   and substring(NM_CODE1,1,1) <  :P3 '
             +'   and DS_STATUS =''0'' '
             +' order by CD_CODE ',
             [Common.Config.StoreCode,
              vTemp,
              nChar[StrToInt(aValue)],
              nChar[StrToInt(aValue)+1]]);
  end;

  Common.ClearGrid(sgr_Grid);
  while not Common.Query.Eof do
  begin
    if sgr_Grid.Cells[0,0] <> '' then sgr_Grid.RowCount := sgr_Grid.RowCount + 1;
    sgr_Grid.Cells[0, sgr_Grid.RowCount-1] := Common.Query.FieldByName('cd_code').AsString;
    sgr_Grid.Cells[1, sgr_Grid.RowCount-1] := Common.Query.FieldByName('nm_code1').AsString;
    sgr_Grid.Cells[2, sgr_Grid.RowCount-1] := Common.Query.FieldByName('nm_code2').AsString;
    sgr_Grid.Cells[3, sgr_Grid.RowCount-1] := Common.Query.FieldByName('nm_code3').AsString;
    Common.Query.Next;
  end;
  Common.Query.Close;
  CashButton.Enabled := sgr_Grid.Cells[0,0] <> '';
  RemarkMemo.Clear;
end;

procedure TCashBookCode_F.AdvGlassButton1Click(Sender: TObject);
begin
  SelectCode(2, IntToStr((Sender as TAdvSmoothButton).Tag) );
end;

procedure TCashBookCode_F.CardButtonClick(Sender: TObject);
var tmpVanNo :Integer;
    vCon     :String;
    vInData  :String;
begin
  if sgr_Grid.Cells[0, 0] = '' then Exit;

  if sgr_Grid.Cells[3, sgr_Grid.Row] = '2' then
  begin
    if Common.ShowMemberForm('CASHBOOK') then
    begin
      CashBookMem_F := TCashBookMem_F.Create(Self);
      try
        CashBookMem_F.Gubun    := Ifthen(Sender = CardButton, 'C','H');
        CashBookMem_F.WorkDate := WorkDate;
        if CashBookMem_F.ShowModal <> mrOK then Exit;
        ModalResult := mrOK;
        InPutAmtEdit.Value := CashBookMem_F.GetAmtEdit.EditValue;
      finally
        FreeAndNil(CashBookMem_F);
      end;
    end
    else Exit;
  end
  else
  begin
    RemarkMemo.SetFocus;
    if InputAmtEdit.Value = 0 then
    begin
      Common.ErrBox('Ãâ³³±Ý¾×À» ÀÔ·ÂÇÏ¼¼¿ä');
      InputAmtEdit.SetFocus;
    end
    else
    begin
      if Sender = CashButton then
        ModalResult := mrOK
      else if Sender = CardButton then
      begin
        Common.PreSent.WRcvAmt := InputAmtEdit.EditValue;
        vCon := GetOption(60);
        Common.Config.Options[60] := '0';
        Common.CashBookCard := True;
        InitCardRecord(Common.Card);
        if Common.ShowCardForm(false, true, InPutAmtEdit.EditValue) then
        begin
          Common.Config.Options[60] := vCon[1];
          Common.CashBookCard := False;
          ModalResult := mrOK;
        end
        else
        begin
          Common.Config.Options[60] := vCon[1];
          Common.CashBookCard := False;
          Exit;
        end;
      end;
    end;
  end;
end;

procedure TCashBookCode_F.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TCashBookCode_F.CodeAppendButtonClick(Sender: TObject);
var vTemp, vSQL :String;
begin
  if RemarkMemo.Text = '' then
  begin
    Common.ErrBox('ºñ°í¶õ¿¡ Ãâ³³¸íÀ» ÀÔ·ÂÇÏ¼¼¿ä');
    Exit;
  end;

  if InButton.Appearance.SimpleLayout then vTemp := '0' else vTemp := '1';
  DM.CloudData.Close;
  DM.ExecCloud('insert into MS_CODE(CD_HEAD, '
              +'                    CD_STORE, '
              +'                    CD_KIND, '
              +'                    CD_CODE, '
              +'                    NM_CODE1, '
              +'                    NM_CODE2, '
              +'                    NM_CODE3, '
              +'                    DS_STATUS) '
              +'             values(:P0, '
              +'                    :P1, '
              +'                    ''11'', '
              +'                    (select Lpad(Cast(Ifnull(Max(CD_CODE),''0'') AS INT)+1, 3,''0'') '
              +'                       from MS_CODE as c '
              +'                      where CD_HEAD  =:P0 '
              +'                        and CD_STORE =:P1 '
              +'                        and CD_KIND  =''11''), '
              +'                    :P2, '
              +'                    :P3, '
              +'                    ''0'', '
              +'                    ''0'' );' ,
              [Common.Config.HeadStoreCode,
               Common.Config.StoreCode,
               RemarkMemo.Text,
               vTemp],true,Common.RestDBURL);

  DM.OpenCloud('select CD_STORE,CD_KIND,CD_CODE,NM_CODE1,NM_CODE2,NM_CODE3,DS_STATUS '
              +'  from MS_CODE '
              +' where CD_HEAD  =:P0 '
              +'   and CD_STORE =:P1 '
              +'   and CD_KIND  =''11'' ',
              [Common.Config.HeadStoreCode,
               Common.Config.StoreCode],Common.RestDBURL);

  vSQL := Format('delete from MS_CODE where CD_STORE =''%s'' and CD_KIND =''11''; ',[Common.Config.StoreCode]);
  vSQL := vSQL + DM.GetCloudData('MS_CODE');

  DM.StoredProc.StoredProcName := 'MULTI_EXECUTE';
  DM.StoredProc.PrepareSQL;
  DM.StoredProc.ParamByName('_SQL').AsString := vSQL;
  DM.StoredProc.ExecProc;


  SelectCode(1, vTemp);
  RemarkMemo.Clear;
  Common.MsgBox('Ãâ³³ÄÚµå°¡ Á¤»ó Ãß°¡µÇ¾ú½À´Ï´Ù');
end;

procedure TCashBookCode_F.sgr_GridClick(Sender: TObject);
begin
  InputAmtEdit.SetFocus;
  RemarkMemo.Clear;
end;

procedure TCashBookCode_F.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Common.CashBookCard := False;
end;

end.
