unit MemberEdit_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, StdCtrls, cxRadioGroup, cxMaskEdit, cxDropDownEdit,
  cxTextEdit, cxControls, cxContainer, cxEdit, cxLabel, OXSpeedButton, ExtCtrls, StrUtils;

type
  TMemberEdit_F = class(TForm)
    obtn_close: TOXSpeedButton;
    lbl_MemberNo: TcxLabel;
    edt_MemberName: TcxTextEdit;
    edt_CardNo: TcxTextEdit;
    edt_Mobil: TcxTextEdit;
    edt_Class: TcxComboBox;
    edt_Home: TcxTextEdit;
    edt_Addr1: TcxTextEdit;
    edt_Addr2: TcxTextEdit;
    rbGender1: TcxRadioButton;
    rbGender2: TcxRadioButton;
    obtn_save: TOXSpeedButton;
    lblTitle: TLabel;
    procedure obtn_closeClick(Sender: TObject);
    procedure edt_MobilExit(Sender: TObject);
    procedure edt_CardNoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure obtn_saveClick(Sender: TObject);
  private
    function SendAspMemberData :Boolean;
  public
    { Public declarations }
  end;

var
  MemberEdit_F: TMemberEdit_F;

implementation
uses Common_U, GlobalFunc_U, Math, Service;
{$R *.dfm}
procedure TMemberEdit_F.FormCreate(Sender: TObject);
const SQL_TXT= 'select cd_code +'' - ''+nm_code1 from ms_code where cd_store=:p0 and cd_kind = ''05'' and ds_status = 0 order by cd_code ';
begin
  qyOpen(Common.qryPos, SQL_TXT, VarArrayof([Common.Config.StoreCode]));
  edt_Class.Properties.Items.Clear;
  while not Common.qryPos.Eof do
  begin
    edt_Class.Properties.Items.Add(Common.qryPos.Fields[0].AsString);
    Common.qryPos.Next;
  end;
  Common.ImageCreate(Self,'membereditform');
  Common.EventApply(Self);
end;

procedure TMemberEdit_F.obtn_closeClick(Sender: TObject);
begin
  Close;
end;

procedure TMemberEdit_F.edt_MobilExit(Sender: TObject);
begin
  (Sender as TcxTextEdit).Text := SetTelephone((Sender as TcxTextEdit).Text);
end;

procedure TMemberEdit_F.edt_CardNoExit(Sender: TObject);
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
begin
  inherited;
  if Trim(edt_CardNo.Text) = '' then Exit;
  
  if Length(edt_CardNo.Text) > 16 then
  begin
    if (edt_CardNo.Text[1] = ';') or (edt_CardNo.Text[1] = '?') or (edt_CardNo.Text[1] = '#') then
       edt_CardNo.Text    := Get2Track(Copy(edt_CardNo.Text,2,Pos('=',edt_CardNo.Text)-2))
    else edt_CardNo.Text  := Get2Track(Copy(edt_CardNo.Text,1,Pos('=',edt_CardNo.Text)-1));
  end
  else if (edt_CardNo.Text[1] = ';') or (edt_CardNo.Text[1] = '?') or (edt_CardNo.Text[1] = '#') then
  begin
    edt_CardNo.Text := ValueToNum(edt_CardNo.Text);
  end;
end;

procedure TMemberEdit_F.obtn_saveClick(Sender: TObject);
var vRtn :Integer;
begin
  try
    Common.qryPos.Close;
    Common.qryPos.SQL.Text := 'update ms_member set nm_member =:p0, '
                            + '                     ds_member =:p1, '
                            + '                     ds_sex    =:p2, '
                            + '                     no_card   =:p3, '
                            + '                     tel_mobil =:p4, '
                            + '                     tel_home  =:p5, '
                            + '                     addr1     =:p6, '
                            + '                     addr2     =:p7, '
                            + '                     ds_trans = 0   '
                            + ' where cd_store =:p8 and cd_member =:p9 ';
    Common.qryPos.Parameters.ParamByName('p0').Value := edt_MemberName.Text;
    Common.qryPos.Parameters.ParamByName('p1').Value := Copy(edt_Class.Text,1,3);
    Common.qryPos.Parameters.ParamByName('p2').Value := IfThen(rbGender1.Checked, 0, 1);
    Common.qryPos.Parameters.ParamByName('p3').Value := edt_CardNo.Text;
    Common.qryPos.Parameters.ParamByName('p4').Value := CtoC(edt_Mobil.Text,'-','');
    Common.qryPos.Parameters.ParamByName('p5').Value := CtoC(edt_Home.Text,'-','');
    Common.qryPos.Parameters.ParamByName('p6').Value := edt_Addr1.Text;
    Common.qryPos.Parameters.ParamByName('p7').Value := edt_Addr2.Text;
    Common.qryPos.Parameters.ParamByName('p8').Value := Common.Config.StoreCode;
    Common.qryPos.Parameters.ParamByName('p9').Value := lbl_MemberNo.Caption;
    vRtn := Common.qryPos.ExecSQL;
    //ASP통합회원을 사용하면서 내매장에 없을때
    if (vRtn = 0) and (Common.AspMemberCode <> 'XXX') then
    begin
      if SendAspMemberData then  ModalResult := mrOK;
    end
    else
      ModalResult := mrOK;
  except
    on E: Exception do
    begin
      Common.ErrorLogSave('MemberEdit',E.Message);
      Common.MessageBox(3,E.Message+#13#13+'저장을 완료하지 못했습니다');
    end;
  end;
end;

function TMemberEdit_F.SendAspMemberData :Boolean;
var vData, vResult: string;
begin
  Result := False;
  if not (Common.GetExtremePOSURL(1)) then Exit;
  vResult := EmptyStr;

  vData := lbl_MemberNo.Caption            + #9   //CD_MEMBER, '      
         + edt_MemberName.Text             + #9   //NM_MEMBER, '      
         + Copy(edt_Class.Text,1,3)        + #9   //DS_MEMBER, '      
         + edt_CardNo.Text                 + #9   //NO_CARD, '        
         + '{null}'                        + #9   //NO_JUMIN, '       
         + IfThen(rbGender1.Checked, '0', '1') + #9   //DS_SEX, '     
         + '{null}'                        + #9   //YMD_BIRTH, '      
         + '{null}'                        + #9   //YN_LUNAR, '       
         + '{null}'                        + #9   //YMD_MARRI, '      
         + CtoC(edt_Home.Text,'-','')      + #9   //TEL_HOME, '       
         + CtoC(edt_Mobil.Text,'-','')     + #9   //TEL_MOBIL, '      
         + '{null}'                        + #9   //NO_POST, '        
         + edt_Addr1.Text                  + #9   //ADDR1, '          
         + edt_Addr2.Text                  + #9   //ADDR2, '          
         + '{null}'                        + #9   //YMD_ISU, '        
         + '{null}'                        + #9   //TEL_JOB, '        
         + '{null}'                        + #9   //YN_TRUST, '       
         + '{null}'                        + #9   //NM_EMAIL, '       
         + '{null}'                        + #9   //YN_NEWS, '        
         + '0'                             + #9   //DS_STATUS, '      
         + Common.Config.UserCode          + #9                       
         + FormatDateTime('yyyymmddhhnnss', Now()) + #9               
         + '{null}'                        + #9
         + '{null}' ;
   try
     vResult := GetServiceSoap(false, Common.ServerURI).SetMemberData(Common.CompanyCode, Common.Config.CustomerNo, vData);
     if vResult <> EmptyStr then
     begin
       Common.MessageBox(3, vResult);
       Result := False;
     end
     else Result := True;
   except
     on E: Exception do
     begin
       Common.MessageBox(3, E.Message);
       Result := false;
     end;
   end;
end;

end.
