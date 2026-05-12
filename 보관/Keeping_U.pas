unit Keeping_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, StdCtrls, OXSpeedButton, MaskUtils, jpeg, DB,
  cxControls, cxContainer, cxEdit, cxLabel, cxTextEdit, cxMemo, StrUtils,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters;
type TSearchType = (stChosung, stNumber);
type
  TKeeping_F = class(TForm)
    OXSpeedButton1: TOXSpeedButton;
    obtn_1: TOXSpeedButton;
    obtn_2: TOXSpeedButton;
    obtn_3: TOXSpeedButton;
    obtn_4: TOXSpeedButton;
    obtn_5: TOXSpeedButton;
    obtn_6: TOXSpeedButton;
    obtn_7: TOXSpeedButton;
    obtn_8: TOXSpeedButton;
    obtn_9: TOXSpeedButton;
    obtn_10: TOXSpeedButton;
    obtn_11: TOXSpeedButton;
    obtn_12: TOXSpeedButton;
    obtn_13: TOXSpeedButton;
    obtn_14: TOXSpeedButton;
    OXSpeedButton16: TOXSpeedButton;
    edt_Input: TEdit;
    sgr_Grid: TStringGrid;
    lblMember: TLabel;
    lblTelNo: TLabel;
    lblDamdang: TLabel;
    lblMenu: TLabel;
    obtn_Prev: TOXSpeedButton;
    obtn_Next: TOXSpeedButton;
    obtn_close: TOXSpeedButton;
    img_gubun: TImage;
    obtn_Gubun: TOXSpeedButton;
    memRemark: TcxMemo;
    OXSpeedButton2: TOXSpeedButton;
    Label1: TLabel;
    OXSpeedButton3: TOXSpeedButton;
    obtn_append: TOXSpeedButton;
    obtn_Edit: TOXSpeedButton;
    obtn_Delete: TOXSpeedButton;
    obtn_sms: TOXSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure sgr_GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure OXSpeedButton1Click(Sender: TObject);
    procedure sgr_GridClick(Sender: TObject);
    procedure obtn_closeClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure obtn_PrevClick(Sender: TObject);
    procedure edt_InputKeyPress(Sender: TObject; var Key: Char);
    procedure obtn_1Click(Sender: TObject);
    procedure OXSpeedButton16Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure obtn_GubunClick(Sender: TObject);
    procedure obtn_appendClick(Sender: TObject);
    procedure obtn_DeleteClick(Sender: TObject);
    procedure obtn_EditClick(Sender: TObject);
    procedure OXSpeedButton3Click(Sender: TObject);
    procedure obtn_smsClick(Sender: TObject);
  private
    FSearchType : TSearchType;
    FMemberCode,
    FDamdangCode,
    FMenuCode :String;
    procedure ClearDisplayInfo;
    procedure SetSearchType(const Value: TSearchType);
    property SearchType :TSearchType read FSearchType write SetSearchType;
  public
    procedure SelectMember(aKind,aIndex:Integer);
  end;

var
  Keeping_F: TKeeping_F;

implementation
uses GlobalFunc_U, Common_U, Service, KeepingAdd_U;
{$R *.dfm}

{ TForm2 }
procedure TKeeping_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,2);
  sgr_Grid.ColWidths[0] := 40;    //¹øÈ£
  sgr_Grid.ColWidths[1] := 115;   //º¸°üÀÏÀÚ
  sgr_Grid.ColWidths[2] := 145;   //°í°´¸í
  sgr_Grid.ColWidths[3] := 50 ;   //°æ°úÀÏ
  sgr_Grid.ColWidths[4] := -1;   //ÈÞ´ëÆù
  sgr_Grid.ColWidths[5] := -1;   //ÈÞ´ëÆù
  sgr_Grid.ColWidths[6] := -1;   //ÈÞ´ëÆù
  sgr_Grid.ColWidths[7] := -1;   //ÈÞ´ëÆù
  sgr_Grid.ColWidths[8] := -1;   //ÈÞ´ëÆù
  sgr_Grid.ColWidths[9] := -1;   //¼ºº°
  sgr_Grid.ColWidths[10] := -1;   //ÁýÀüÈ­
end;


procedure TKeeping_F.SelectMember(aKind,aIndex:Integer);
   function Get2Track(AValue:String):String;
   var I   :Integer;
   begin
      Result := '';
      For I:=1 to Length(AValue) do
      begin
         Case AValue[I] of
           #48..#57, #61: Result := Result + AValue[I];
         end;
      end;
   end;
   function GetChar(S:String; aType:Integer=0):String;
   const
     nChar  :Array[1..14] of String =('¤¡','¤¤','¤§','¤©','¤±','¤²','¤µ','¤·','¤¸','¤º','¤»','¤¼','¤½','¤¾');
     nChar1 :Array[1..14] of String =('°¡','³ª','´Ù','¶ó','¸¶','¹Ù','»ç','¾Æ','ÀÚ','Â÷','Ä«','Å¸','ÆÄ','ÇÏ');
   var I :Integer;
   begin
     For I := 1 to 14 do
     begin
       if S = nChar[I] then
       begin
         if aType = 0 then
           Result := nChar1[I]
         else
         begin
           if I = 14 then Result := 'ÆR'
           else           Result := nChar1[I+1];
         end;
         Break;
       end;
     end;
   end;
const
  nChar :Array[1..14] of String =('°¡','³ª','´Ù','¶ó','¸¶','¹Ù','»ç','¾Æ','ÀÚ','Â÷','Ä«','Å¸','ÆÄ','ÇÏ');

  SQL_TXT = 'select  dbo.stod(ymd_keep) as keep_date, '
           +'        cust_name, '
           +'        DATEDIFF(day, convert(datetime, dbo.stod(ymd_keep)), getdate()) as lapseday, '
           +'        ymd_keep,no_keep  '
           +'   from sl_keeping '
           +'where cd_store   =:p0 and ds_status = ''0'' ';

  _SEARCH1 = '    and ( (ymd_keep+no_keep = :p1) or (cust_name like :p2) or (tel_mobil like :p3 )  )                                     '
            +'  order by ymd_keep, no_keep ';

  _SEARCH2 = '  and substring(cust_name,1,1) >= :p1 and substring(cust_name,1,1) < :p2   '
            +'  order by cust_name ';
  _SEARCH3 = '  and substring(cust_name,1,1) >= :p1 and substring(cust_name,1,1) < :p2   '
            +'  and substring(cust_name,2,1) >= :p3 and substring(cust_name,2,1) < :p4   '
            +'  order by cust_name ';
  _SEARCH4 = '  and substring(cust_name,1,1) >= :p1 and substring(cust_name,1,1) < :p2   '
            +'  and substring(cust_name,2,1) >= :p3 and substring(cust_name,2,1) < :p4   '
            +'  and substring(cust_name,3,1) >= :p5 and substring(cust_name,3,1) < :p6   '
            +'  order by cust_name ';

begin
  if Length(edt_Input.Text) > 16 then
  begin
    if (edt_Input.Text[1] = ';') or (edt_Input.Text[1] = '?') or (edt_Input.Text[1] = '#') then
       edt_Input.Text    := Get2Track(Copy(edt_Input.Text,2,Pos('=',edt_Input.Text)-2))
    else edt_Input.Text  := Get2Track(Copy(edt_Input.Text,1,Pos('=',edt_Input.Text)-1));
  end
  else if (Length(edt_Input.Text) > 0) and ((edt_Input.Text[1] = ';') or (edt_Input.Text[1] = '?') or (edt_Input.Text[1] = '#')) then
  begin
    edt_Input.Text := GetOnlyNumber(edt_Input.Text);
  end;

  if aKind = 0 then
  begin
     OpenQuery(SQL_TXT + _SEARCH1,
              [Common.Config.StoreCode,
               Copy(edt_Input.Text,1,11),
               '%'+edt_Input.Text+'%',
               '%'+Copy(edt_Input.Text,1,13)+'%']);
  end
  else
  begin
     case Length(edt_Input.Text) of
       2 : OpenQuery(SQL_TXT + _SEARCH2,
                    [Common.Config.StoreCode,
                     GetChar(Copy(edt_Input.Text,1,2)),
                     GetChar(Copy(edt_Input.Text,1,2),1) ]);
       4 : OpenQuery(SQL_TXT + _SEARCH3,
                    [Common.Config.StoreCode,
                     GetChar(Copy(edt_Input.Text,1,2)),
                     GetChar(Copy(edt_Input.Text,1,2),1),
                     GetChar(Copy(edt_Input.Text,3,2)),
                     GetChar(Copy(edt_Input.Text,3,2),1)]);
       6 : OpenQuery(SQL_TXT + _SEARCH4,
                    [Common.Config.StoreCode,
                     GetChar(Copy(edt_Input.Text,1,2)),
                     GetChar(Copy(edt_Input.Text,1,2),1),
                     GetChar(Copy(edt_Input.Text,3,2)),
                     GetChar(Copy(edt_Input.Text,3,2),1),
                     GetChar(Copy(edt_Input.Text,5,2)),
                     GetChar(Copy(edt_Input.Text,5,2),1)]);
       else Exit;
     end;
  end;

  Common.ClearGrid(sgr_Grid);
  obtn_Edit.Visible   := False;
  obtn_Delete.Visible := False;
  obtn_Sms.Visible    := False;
  if Common.qryPos.eof then
  begin
    Common.qryPos.Close;
    ClearDisplayInfo;
    if aKind = 0 then
    begin
      Common.ErrBox('Á¶°Ç¿¡ ¸Â´Â ÀÚ·á°¡ ¾ø½À´Ï´Ù');
      edt_Input.Clear;
    end;
    Exit;
  end;
  with sgr_Grid, Common.Query do
  begin
    obtn_Edit.Visible   := True;
    obtn_Delete.Visible := True;
    obtn_Sms.Visible    := True;

    while not Eof do
    begin
      if Cells[0,0] <> '' then RowCount := RowCount + 1;

      Cells[0, RowCount-1] := IntToStr(RowCount);
      Cells[1, RowCount-1] := FieldByName('keep_date').AsString;
      Cells[2, RowCount-1] := FieldByName('cust_name').AsString;
      Cells[3, RowCount-1] := FieldByName('lapseday').AsString;
      Cells[4, RowCount-1] := FieldByName('ymd_keep').AsString;
      Cells[5, RowCount-1] := FieldByName('no_keep').AsString;
      Next;
    end;
    sgr_GridClick(nil);
    if aKind = 0 then edt_Input.Clear;
  end;

end;


procedure TKeeping_F.sgr_GridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var  i_align : integer;
begin
   if gdSelected in State then
   begin
       TStringGrid(Sender).Canvas.Font.Color  := clWhite;
       TStringGrid(Sender).Canvas.Font.Style  := [fsBold];
       TStringGrid(Sender).Canvas.Brush.Color := $0076141E;
   end;

   case Acol of
      0,1,3 :  i_align  := 1; //°¡¿îµ¥
      2     :  i_align  := 0;
   end;
   Common.Grid_Align(Sender, ACol, ARow, Rect, i_align);
end;

procedure TKeeping_F.OXSpeedButton1Click(Sender: TObject);
var vDamdangCode, vTemp :String;
begin
  if (sgr_Grid.Cells[0,0] = '') then Exit;

  if Common.ShowChooseForm('T','',Common.DamdangCode,vTemp) then
    vDamdangCode := Common.DamdangCode
  else
    Exit;

  ExecQuery('update sl_keeping '
           +'   set ds_status = ''1'', '
           +'       sale_sawon =:p3, '
           +'       sale_date = getdate() '
           +' where cd_store =:p0 '
           +'   and ymd_keep =:p1 '
           +'   and no_keep  =:p2 ',
           [Common.Config.StoreCode,
            sgr_Grid.Cells[4,  sgr_Grid.Row],
            sgr_Grid.Cells[5,  sgr_Grid.Row],
            vDamdangCode]);

  Common.DeleteRow(sgr_Grid, sgr_Grid.Row);
  obtn_Edit.Visible   := sgr_Grid.Cells[0, 0] <> '';
  obtn_Delete.Visible := sgr_Grid.Cells[0, 0] <> '';
  obtn_Sms.Visible    := sgr_Grid.Cells[0, 0] <> '';
  sgr_GridClick(nil);
end;

procedure TKeeping_F.sgr_GridClick(Sender: TObject);
var FJpg    : TJPEGImage;
    FStream : TStream;
begin
  if (sgr_Grid.Cells[0,0] = '') then
  begin
    ClearDisplayInfo;
    Exit;
  end;
  with sgr_Grid do
  begin
    OpenQuery('select a.*, '
             +'       b.NM_MEMBER, '
             +'       c.NM_SAWON, '
             +'       d.NM_MENU '
             +'  from SL_KEEPING a left outer join '
             +'       MS_MEMBER  b on a.CD_STORE   = b.CD_STORE '
             +'                   and a.CD_MEMBER  = b.CD_MEMBER left outer join '
             +'       MS_SAWON   c on a.CD_STORE   = c.CD_STORE '
             +'                   and a.KEEP_SAWON = c.CD_SAWON Left outer join '
             +'       MS_MENU    d on a.CD_STORE   = d.CD_STORE '
             +'                   and a.CD_MENU    = d.CD_MENU '
             +' where a.CD_STORE    =:P0 '
             +'   and a.YMD_KEEP    =:P1 '
             +'   and a.NO_KEEP     =:P2 ',
             [Common.Config.StoreCode,
              Cells[4,  Row],
              Cells[5,  Row]]);

    FMemberCode := Common.Query.FieldByName('cd_member').AsString;
    if FMemberCode = '' then
      lblMember.Caption    := ''
    else
      lblMember.Caption    := Common.Query.FieldByName('nm_member').AsString+' ['+FMemberCode + ']';

    lblTelNo.Caption     := SetTelephone( Common.Query.FieldByName('tel_mobil').AsString );

    FDamdangCode         := Common.Query.FieldByName('keep_sawon').AsString;
    lblDamdang.Caption   := Common.Query.FieldByName('nm_sawon').AsString;
    FMenuCode            := Common.Query.FieldByName('cd_menu').AsString;
    lblMenu.Caption      := Common.Query.FieldByName('nm_menu').AsString;
    memRemark.Text       := Common.Query.FieldByName('remark').AsString;
    Common.Query.Close;
  end;
end;

procedure TKeeping_F.obtn_closeClick(Sender: TObject);
begin
  Close;
end;

procedure TKeeping_F.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F10    : edt_Input.Clear;
    VK_UP     : obtn_PrevClick(obtn_Prev);
    VK_DOWN   : obtn_PrevClick(obtn_Next);
  end;
end;

procedure TKeeping_F.obtn_PrevClick(Sender: TObject);
begin
  if Sender = obtn_Prev then Common.RowPrev(sgr_Grid)
  else                       Common.RowNext(sgr_Grid);
end;

procedure TKeeping_F.edt_InputKeyPress(Sender: TObject; var Key: Char);
begin
  if Key <> #13 then Exit;
  SelectMember(0,0);
end;

procedure TKeeping_F.obtn_1Click(Sender: TObject);
const
  nChar :Array[1..14] of String =('¤¡','¤¤','¤§','¤©','¤±','¤²','¤µ','¤·','¤¸','¤º','¤»','¤¼','¤½','¤¾');
begin
  case SearchType of
    stChosung :
    begin
      edt_Input.Text := edt_Input.Text + nChar[(Sender as TOXSpeedButton).Tag];
      edt_Input.SelStart := Length(edt_Input.Text);
      SelectMember(1, (Sender as TOXSpeedButton).Tag);
    end;
    stNumber  :
    begin
      case (Sender as TOXSpeedButton).Tag of
        1..5  : edt_Input.Text := edt_Input.Text + IntToStr((Sender as TOXSpeedButton).Tag);
          6,7 :
          begin
            if not edt_Input.Focused then
            begin
              edt_Input.SetFocus;
              edt_Input.SelStart := Length(edt_Input.Text);
            end;
            Keybd_Event(VK_BACK,VK_BACK, 0, 0);
          end;
        13,14 : edt_Input.Clear;
        8..11 : edt_Input.Text := edt_Input.Text + IntToStr((Sender as TOXSpeedButton).Tag-2);
           12 : edt_Input.Text := edt_Input.Text + '0';
      end;
      edt_Input.SelStart := Length(edt_Input.Text);
    end;
  end;
end;

procedure TKeeping_F.OXSpeedButton16Click(Sender: TObject);
begin
  SelectMember(0,0);
end;

procedure TKeeping_F.FormShow(Sender: TObject);
begin
  Common.ClearGrid(sgr_Grid);
  edt_Input.Clear;
  ClearDisplayInfo;
  SearchType := stChosung;
  Common.SetHangeulMode(True);
end;

procedure TKeeping_F.SetSearchType(const Value: TSearchType);
begin
  FSearchType := Value;
  case FSearchType of
    stChosung :
    begin
      Common.ImageApply(obtn_Gubun, 'obtn_number1','GIF');
      Common.ImageApply(img_gubun, 'pan_chosung','GIF');
    end;
    stNumber :
    begin
      Common.ImageApply(obtn_Gubun, 'obtn_chosung1','GIF');
      Common.ImageApply(img_gubun, 'pan_number','GIF');
    end;
  end;
end;

procedure TKeeping_F.obtn_GubunClick(Sender: TObject);
begin
  case SearchType of
    stChosung : SearchType := stNumber;
    stNumber  : SearchType := stChosung;
  end;
end;

procedure TKeeping_F.ClearDisplayInfo;
begin
  lblMember.Caption  := '';
  lblTelNo.Caption   := '';
  lblDamdang.Caption := '';
  lblMenu.Caption    := '';
  memRemark.Clear;
end;


procedure TKeeping_F.obtn_appendClick(Sender: TObject);
var KeepNo :String;
begin
  KeepingAdd_F := TKeepingAdd_F.Create(Application);
  try
    if KeepingAdd_F.ShowModal = mrOK then
    begin
      OpenQuery('select Max(NO_KEEP) '
               +'  from SL_KEEPING '
               +' where CD_STORE =:P0 '
               +'   and YMD_KEEP = Convert(varchar, GetDate(), 112) ',
               [Common.Config.StoreCode]);

      KeepNo := LPad(IntToStr(StoI(Common.Query.Fields[0].AsString)+1),3,'0');
      Common.Query.Close;

      ExecQuery('insert into sl_keeping (cd_store, ymd_keep, no_keep, cd_member, cust_name, tel_mobil, keep_sawon, cd_menu, remark, ds_status) '
               +'                 values(:p0, :p1, :p2, :p3, :p4, :p5, :p6, :p7, :p8, ''0'') ',
               [Common.Config.StoreCode,
                Common.NowDate,
                KeepNo,
                KeepingAdd_F.FMemberCode,
                KeepingAdd_F.edtCustName.Text,
                CtoC(KeepingAdd_F.edtTelNo.Text,'-',''),
                KeepingAdd_F.FDamdangCode,
                KeepingAdd_F.FMenuCode,
                KeepingAdd_F.meoRemark.Text]);

      obtn_Edit.Visible   := True;
      obtn_Delete.Visible := True;
      obtn_Sms.Visible    := True;

      with sgr_Grid do
      begin
        if Cells[0,0] <> '' then RowCount := RowCount + 1;

        Cells[0, RowCount-1] := IntToStr(RowCount);
        Cells[1, RowCount-1] := FormatDateTime('yyyy-mm-dd', now);
        Cells[2, RowCount-1] := KeepingAdd_F.edtCustName.Text;
        Cells[3, RowCount-1] := '0';
        Cells[4, RowCount-1] := Common.NowDate;
        Cells[5, RowCount-1] := KeepNo;
      end;
      sgr_GridClick(nil);
    end;
  finally
    FreeAndNil(KeepingAdd_F);
  end;
end;

procedure TKeeping_F.obtn_DeleteClick(Sender: TObject);
begin
  if StoI(sgr_Grid.Cells[3, sgr_Grid.Row]) > 0 then
  begin
    Common.ErrBox('º¸°üÀÏÀÌ 1ÀÏ ÀÌ»óÀº »èÁ¦ÇÒ ¼ö ¾ø½À´Ï´Ù');
    Exit;
  end;
  if not Common.AskBox('º¸°ü³»¿ªÀ» »èÁ¦ÇÏ½Ã°Ú½À´Ï±î?') then Exit;

  ExecQuery('delete '
           +'  from SL_KEEPING '
           +' where CD_STORE =:P0 '
           +'   and YMD_KEEP =:P1 '
           +'   and NO_KEEP  =:P2 ',
           [Common.Config.StoreCode,
            sgr_Grid.Cells[4, sgr_Grid.Row],
            sgr_Grid.Cells[5, sgr_Grid.Row]]);

  Common.DeleteRow(sgr_Grid, sgr_Grid.Row);
  obtn_Edit.Visible   := sgr_Grid.Cells[0, 0] <> '';
  obtn_Delete.Visible := sgr_Grid.Cells[0, 0] <> '';
  obtn_Sms.Visible    := sgr_Grid.Cells[0, 0] <> '';
  sgr_GridClick(nil);
end;

procedure TKeeping_F.obtn_EditClick(Sender: TObject);
begin
  KeepingAdd_F := TKeepingAdd_F.Create(Application);
  KeepingAdd_F.FMemberCode      := FMemberCode;
  KeepingAdd_F.edtCustName.Text := sgr_Grid.Cells[2,0];
  KeepingAdd_F.edtTelNo.Text    := lblTelNo.Caption;
  KeepingAdd_F.FDamdangCode     := FDamdangCode;
  KeepingAdd_F.edtDamdang.Text  := lblDamdang.Caption;
  KeepingAdd_F.FMenuCode        := FMenuCode;
  KeepingAdd_F.edtMenuName.Text := lblMenu.Caption;
  KeepingAdd_F.meoRemark.Text   := memRemark.Text;
  try
    if KeepingAdd_F.ShowModal = mrOK then
    begin
      ExecQuery('update SL_KEEPING '
               +'   set CUST_NAME =:P3, '
               +'       CD_MEMBER =:P4, '
               +'       TEL_MOBIL =:P5, '
               +'       KEEP_SAWON=:P6, '
               +'       CD_MENU   =:P7, '
               +'       REMARK    =:P8'
               +' where CD_STORE  =:P0 '
               +'   and YMD_KEEP  =:P1 '
               +'   and NO_KEEP   =:P2 ',
               [Common.Config.StoreCode,
                sgr_Grid.Cells[4, sgr_Grid.Row],
                sgr_Grid.Cells[5, sgr_Grid.Row],
                KeepingAdd_F.edtCustName.Text,
                KeepingAdd_F.FMemberCode,
                CtoC(KeepingAdd_F.edtTelNo.Text,'-',''),
                KeepingAdd_F.FDamdangCode,
                KeepingAdd_F.FMenuCode,
                KeepingAdd_F.meoRemark.Text]);
      sgr_GridClick(nil);
    end;
  finally
    FreeAndNil(KeepingAdd_F);
  end;
end;

procedure TKeeping_F.OXSpeedButton3Click(Sender: TObject);
var vDamdangCode, vTemp :String;
begin
  if (sgr_Grid.Cells[0,0] = '') then Exit;

  if Common.ShowChooseForm('T','',Common.DamdangCode,vTemp) then
    vDamdangCode := Common.DamdangCode
  else
    Exit;

  ExecQuery('update sl_keeping '
           +'   set ds_status = ''2'', '
           +'       sale_sawon=:p3, '
           +'       sale_date = getdate() '
           +' where cd_store =:p0 '
           +'   and ymd_keep =:p1 '
           +'   and no_keep  =:p2 ',
           [Common.Config.StoreCode,
            sgr_Grid.Cells[4, sgr_Grid.Row],
            sgr_Grid.Cells[5, sgr_Grid.Row],
            vDamdangCode]);

  Common.DeleteRow(sgr_Grid, sgr_Grid.Row);
  obtn_Edit.Visible   := sgr_Grid.Cells[0, 0] <> '';
  obtn_Delete.Visible := sgr_Grid.Cells[0, 0] <> '';
  obtn_Sms.Visible    := sgr_Grid.Cells[0, 0] <> '';
  sgr_GridClick(nil);
end;

procedure TKeeping_F.obtn_smsClick(Sender: TObject);
begin
  if lblTelNo.Caption <> '' then
    Common.SendSMSMessage('3'+#28+Common.Config.CustomerNo+#28+
                          GetOnlyNumber(lblTelNo.Caption)+#28+
                          GetOnlyNumber(Common.Config.StoreTel)+#28+
                          lblMenu.Caption +'(°¡/ÀÌ) ÅµÇÎµÇ¾ú½À´Ï´Ù ÅµÇÎ¹øÈ£ ['+sgr_Grid.Cells[4, sgr_Grid.Row]+sgr_Grid.Cells[5, sgr_Grid.Row] +']'+
                                ' -'+Common.Config.StoreName+'-'+#28
                          );

end;

end.                                                                                              
