unit UnitZipPopup;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  System.JSON, System.Net.URLClient, System.Net.HttpClient,
  System.NetEncoding,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  AdvGlowButton, AdvSmoothToggleButton;

type
  TFrmZipPopup = class(TForm)
    lvResult: TListView;
    edtKeyword: TcxTextEdit;
    SearchButton: TAdvSmoothToggleButton;
    OKButton: TAdvSmoothToggleButton;
    CloseButton: TAdvSmoothToggleButton;
    procedure FormCreate(Sender: TObject);
    procedure lvResultDblClick(Sender: TObject);
    procedure edtKeywordKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OKButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
  private
    FConfmKey: string;
    FZipNo: string;
    FRoadAddr: string;
    FJibunAddr: string;
    procedure InitListView;
    procedure SearchAddress(const AKeyword: string);
    function HttpGet(const AUrl: string): string;
    function SelectCurrentItem: Boolean;
  public
    class function Execute(out AZipNo, ARoadAddr, AJibunAddr: string): Boolean;
  end;

implementation

{$R *.dfm}

class function TFrmZipPopup.Execute(out AZipNo, ARoadAddr, AJibunAddr: string): Boolean;
var
  Frm: TFrmZipPopup;
begin
  Result := False;
  AZipNo := '';
  ARoadAddr := '';
  AJibunAddr := '';

  Frm := TFrmZipPopup.Create(nil);
  try
    if Frm.ShowModal = mrOk then
    begin
      AZipNo := Frm.FZipNo;
      ARoadAddr := Frm.FRoadAddr;
      AJibunAddr := Frm.FJibunAddr;
      Result := True;
    end;
  finally
    Frm.Free;
  end;
end;

procedure TFrmZipPopup.FormCreate(Sender: TObject);
begin
  // 발급받은 승인키로 변경
  FConfmKey := 'U01TX0FVVEgyMDI2MDQwOTEwMDEwNTExNzg3Nzg=';

  Position := poScreenCenter;
  BorderStyle := bsDialog;
  Caption := '우편번호 조회';

  InitListView;
end;

procedure TFrmZipPopup.InitListView;
begin
  lvResult.ViewStyle := vsReport;
  lvResult.ReadOnly := True;
  lvResult.RowSelect := True;
  lvResult.HideSelection := False;
  lvResult.MultiSelect := False;
  lvResult.Columns.Clear;

  with lvResult.Columns.Add do
  begin
    Caption := '우편번호';
    Width := 90;
  end;

  with lvResult.Columns.Add do
  begin
    Caption := '도로명주소';
    Width := 450;
  end;
end;

function TFrmZipPopup.HttpGet(const AUrl: string): string;
var
  Http: THTTPClient;
  Resp: IHTTPResponse;
begin
  Http := THTTPClient.Create;
  try
    Http.ConnectionTimeout := 5000;
    Http.ResponseTimeout := 10000;

    Resp := Http.Get(AUrl);

    if Resp.StatusCode <> 200 then
      raise Exception.CreateFmt('HTTP 오류: %d %s', [Resp.StatusCode, Resp.StatusText]);

    Result := Resp.ContentAsString(TEncoding.UTF8);
  finally
    Http.Free;
  end;
end;

procedure TFrmZipPopup.SearchAddress(const AKeyword: string);
const
  BASE_URL = 'https://business.juso.go.kr/addrlink/addrLinkApi.do';
var
  Url: string;
  JsonText: string;
  RootObj: TJSONObject;
  ResultsObj: TJSONObject;
  CommonObj: TJSONObject;
  JusoValue: TJSONValue;
  JusoArray: TJSONArray;
  I: Integer;
  Item: TListItem;
  ErrorCode: string;
  ErrorMessage: string;
  ZipNo: string;
  RoadAddr: string;
  JibunAddr: string;
begin
  lvResult.Items.BeginUpdate;
  try
    lvResult.Items.Clear;

    Url :=
      BASE_URL +
      '?confmKey=' + TNetEncoding.URL.Encode(FConfmKey) +
      '&currentPage=1' +
      '&countPerPage=20' +
      '&keyword=' + TNetEncoding.URL.Encode(AKeyword) +
      '&resultType=json';

    JsonText := HttpGet(Url);

    RootObj := TJSONObject.ParseJSONValue(JsonText) as TJSONObject;
    try
      if RootObj = nil then
        raise Exception.Create('JSON 파싱 실패');

      ResultsObj := RootObj.GetValue<TJSONObject>('results');
      if ResultsObj = nil then
        raise Exception.Create('results 노드 없음');

      CommonObj := ResultsObj.GetValue<TJSONObject>('common');
      if CommonObj = nil then
        raise Exception.Create('common 노드 없음');

      ErrorCode := CommonObj.GetValue<string>('errorCode', '');
      ErrorMessage := CommonObj.GetValue<string>('errorMessage', '');

      if ErrorCode <> '0' then
        raise Exception.CreateFmt('API 오류 [%s] %s', [ErrorCode, ErrorMessage]);

      JusoValue := ResultsObj.GetValue('juso');
      if (JusoValue = nil) or (JusoValue is TJSONNull) then
      begin
//        AddLog('검색 결과 없음');
        Exit;
      end;

      if not (JusoValue is TJSONArray) then
        raise Exception.Create('juso 배열 형식 아님');

      JusoArray := TJSONArray(JusoValue);

      for I := 0 to JusoArray.Count - 1 do
      begin
        ZipNo := TJSONObject(JusoArray.Items[I]).GetValue<string>('zipNo', '');
        RoadAddr := TJSONObject(JusoArray.Items[I]).GetValue<string>('roadAddr', '');
//        JibunAddr := TJSONObject(JusoArray.Items[I]).GetValue<string>('jibunAddr', '');

        Item := lvResult.Items.Add;
        Item.Caption := ZipNo;
        Item.SubItems.Add(RoadAddr);
//        Item.SubItems.Add(JibunAddr);
      end;

      if lvResult.Items.Count > 0 then
      begin
        lvResult.ItemIndex := 0;
        lvResult.Selected := lvResult.Items[0];
      end;
    finally
      RootObj.Free;
    end;
  finally
    lvResult.Items.EndUpdate;
  end;
end;

procedure TFrmZipPopup.SearchButtonClick(Sender: TObject);
begin
  if Trim(edtKeyword.Text) = '' then
  begin
    MessageDlg('검색어를 입력하세요.', mtWarning, [mbOK], 0);
    edtKeyword.SetFocus;
    Exit;
  end;

  try
    SearchAddress(Trim(edtKeyword.Text));
  except
    on E: Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;

procedure TFrmZipPopup.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmZipPopup.edtKeywordKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    SearchButtonClick(SearchButton);
  end;
end;

function TFrmZipPopup.SelectCurrentItem: Boolean;
begin
  Result := Assigned(lvResult.Selected);

  if not Result then
  begin
    MessageDlg('목록에서 주소를 선택하세요.', mtWarning, [mbOK], 0);
    Exit;
  end;

  FZipNo := lvResult.Selected.Caption;
  FRoadAddr := '';
  FJibunAddr := '';

  if lvResult.Selected.SubItems.Count > 0 then
    FRoadAddr := lvResult.Selected.SubItems[0];

  if lvResult.Selected.SubItems.Count > 1 then
    FJibunAddr := lvResult.Selected.SubItems[1];
end;

procedure TFrmZipPopup.lvResultDblClick(Sender: TObject);
begin
  if SelectCurrentItem then
    ModalResult := mrOk;
end;

procedure TFrmZipPopup.OKButtonClick(Sender: TObject);
begin
  if SelectCurrentItem then
    ModalResult := mrOk;
end;

end.