unit DaumZipCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StrUtils, OleCtrls, SHDocVw, MSHTML;

type
  // HTML Element 이벤트 처리 클래스
  THTMLElementEvent = class(TInterfacedObject, IDispatch)
  private
    FOnEvent: TProcedure;
  protected
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
  public
    constructor Create(const OnEvent: TProcedure);
    property OnEvent: TProcedure read FOnEvent write FOnEvent;
  end;

type
  TDaumZipCodeForm = class(TForm)
    WebBrowser: TWebBrowser;
    procedure FormCreate(Sender: TObject);
    procedure WebBrowserDocumentComplete(ASender: TObject;
      const pDisp: IDispatch; const URL: OleVariant);
  private
    function  GetElementById(const aDoc: IDispatch; const aId: string): IDispatch;
    procedure Split(const aStr: WideString; aSplitter: WideString; var aList: TStringList);
  public
    FElement: IHTMLElement;
    FZip1, FZip2, FAddr1, FAddr2, FMessage: string;
  end;

function  ShowDaumZipCode(var aZip1, aZip2, aAddr1, aAddr2, aMessage: string): Boolean;
procedure OnPostInfoButtonClick;

var
  DaumZipCodeForm: TDaumZipCodeForm;


implementation

{$R *.dfm}

//==============================================================================
// 함수
//------------------------------------------------------------------------------
// 우편번호 폼 표시
function ShowDaumZipCode(var aZip1, aZip2, aAddr1, aAddr2, aMessage: string): Boolean;
begin
  Result          := false;
  DaumZipCodeForm := TDaumZipCodeForm.Create(Application);
  try
    if DaumZipCodeForm.ShowModal = mrOK then
    begin
      aZip1    := DaumZipCodeForm.FZip1;
      aZip2    := DaumZipCodeForm.FZip2;
      aAddr1   := DaumZipCodeForm.FAddr1;
      aAddr2   := DaumZipCodeForm.FAddr2;
      aMessage := DaumZipCodeForm.FMessage;
      Result   := true;
    end
    else
      aMessage := DaumZipCodeForm.FMessage;
  finally
    DaumZipCodeForm.Free;
  end;
end;
//------------------------------------------------------------------------------
// 웹페이지에서 우편번호 선택을 끝냈을 때
procedure OnPostInfoButtonClick;
var
  vStr : WideString;
  vList: TStringList;
begin
  if Assigned(DaumZipCodeForm) and Assigned(DaumZipCodeForm.FElement) then
    try
      vStr  := VarToStr(DaumZipCodeForm.FElement.getAttribute('Value', 0));
      vList := TStringList.Create;
      DaumZipCodeForm.Split(vStr, '†', vList);
      DaumZipCodeForm.FZip1       := IfThen(vList.Count > 1, vList[1], '');
      DaumZipCodeForm.FZip2       := IfThen(vList.Count > 2, vList[2], '');
      DaumZipCodeForm.FAddr1      := IfThen(vList.Count > 3, vList[3], '');
      DaumZipCodeForm.FAddr2      := IfThen(vList.Count > 4, vList[4], '');
      DaumZipCodeForm.FMessage    := IfThen(vList.Count > 0, vList[0], '');
      vList.Free;
      DaumZipCodeForm.ModalResult := mrOK;
    except
      on E: Exception do
      begin
        DaumZipCodeForm.FMessage    := '우편번호를 분석할 수 없습니다.'#13+E.Message;
        DaumZipCodeForm.ModalResult := mrCancel;
      end;
    end;
end;

//==============================================================================
// 폼
//------------------------------------------------------------------------------
// 폼을 만들 때
procedure TDaumZipCodeForm.FormCreate(Sender: TObject);
begin
  // 우편번호 페이지를 띄운다
  WebBrowser.Navigate('http://www.expos.co.kr:82/Extreme/IntranetFood/HelpCode/UniPost.htm');
end;
//------------------------------------------------------------------------------
// 웹브라우저에서 페이지 표시를 다 했을 때

//------------------------------------------------------------------------------
// HTML의 객체 찾기
function TDaumZipCodeForm.GetElementById(const aDoc: IDispatch; const aId: string): IDispatch;
var
  vDoc : IHTMLDocument2;
  vBody: IHTMLElement2;
  vTags: IHTMLElementCollection;
  vTag : IHTMLElement;
  vI   : Integer;
begin
  Result := nil;
  if not Supports(aDoc, IHTMLDocument2, vDoc) then
    raise Exception.Create('HTML 문서 형식이 잘못되었습니다.');
  if not Supports(vDoc.body, IHTMLElement2, vBody) then
    raise Exception.Create('HTML 문서에 <body> 태그가 없습니다.');
  vTags := vBody.getElementsByTagName('*');
  for vI := 0 to Pred(vTags.length) do
  begin
    vTag := vTags.item(vI, EmptyParam) as IHTMLElement;
    if AnsiSameText(vTag.id, 'postInfoHidden') then
    begin
      Result := vTag;
      Break;
    end;
  end;
end;
//------------------------------------------------------------------------------
// 문자열 구분자로 나누기
procedure TDaumZipCodeForm.Split(const aStr: WideString; aSplitter: WideString; var aList: TStringList);
var
  vTemp: WideString;
  vPos : Integer;
begin
  aList.Clear;
  vTemp := aStr;
  repeat
    vPos := Pos(aSplitter, vTemp);
    if vPos > 0 then
    begin
      aList.Add(Copy(vTemp, 1, vPos-1));
      vTemp := Copy(vTemp, vPos+Length(aSplitter), Length(vTemp));
    end
    else
      aList.Add(vTemp);
  until vPos = 0;
end;

procedure TDaumZipCodeForm.WebBrowserDocumentComplete(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
begin
  try
    FElement := GetElementById(WebBrowser.Document, 'postInfoHidden') as IHTMLElement;
    if Assigned(FElement) then
      FElement.onclick := THTMLElementEvent.Create(OnPostInfoButtonClick) as IDispatch;
  except
    on E: Exception do
    begin
      FMessage    := '우편번호 페이지를 읽을 수 없습니다.'#13+E.Message;
      ModalResult := mrCancel;
    end;
  end;

end;

//==============================================================================
// THTMLElementEvent
//------------------------------------------------------------------------------
constructor THTMLElementEvent.Create(const OnEvent: TProcedure);
begin
  inherited Create;
  FOnEvent := OnEvent;
end;
//------------------------------------------------------------------------------
function THTMLElementEvent.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;
//------------------------------------------------------------------------------
function THTMLElementEvent.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Result := E_NOTIMPL;
end;
//------------------------------------------------------------------------------
function THTMLElementEvent.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Result := E_NOTIMPL;
end;
//------------------------------------------------------------------------------
function THTMLElementEvent.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
  if DispID = 0{DISPID_VALUE} then
  begin
    if Assigned(FOnEvent) then
      FOnEvent;
    Result := S_OK;
  end
  else
    Result := E_NOTIMPL;
end;

end.
