unit UnitEscPosQrData;

interface

uses
  System.SysUtils, System.Classes;

function BuildNaverQRData: TBytes;
function BytesToHex(const AData: TBytes): string;

implementation

const
  NAVER_URL: AnsiString =
    'https://nid.naver.com/nidlogin.login?realname=Y&svctype=262144&url=https://m.place.naver.com/my/checkin';

function Bytes(const Values: array of Byte): TBytes;
var
  I: Integer;
begin
  SetLength(Result, Length(Values));
  for I := 0 to High(Values) do
    Result[I] := Values[I];
end;

function AnsiToBytes(const S: AnsiString): TBytes;
var
  I: Integer;
begin
  SetLength(Result, Length(S));
  for I := 1 to Length(S) do
    Result[I - 1] := Byte(S[I]);
end;

function ConcatBytes(const Parts: array of TBytes): TBytes;
var
  Total, P, I: Integer;
begin
  Total := 0;
  for I := 0 to High(Parts) do
    Inc(Total, Length(Parts[I]));

  SetLength(Result, Total);
  P := 0;

  for I := 0 to High(Parts) do
  begin
    if Length(Parts[I]) > 0 then
    begin
      Move(Parts[I][0], Result[P], Length(Parts[I]));
      Inc(P, Length(Parts[I]));
    end;
  end;
end;

function BuildNaverQRData: TBytes;
begin
  Result := ConcatBytes([
    // 초기화
    Bytes([$1B, $40]),

    // 가운데 정렬
    Bytes([$1B, $61, $01]),

    // 텍스트
    AnsiToBytes('Naver Check-in'),
    Bytes([$0A, $0A]),

    // QR 모델 선택
    Bytes([$1D, $28, $6B, $04, $00, $31, $41, $32, $00]),

    // QR 크기
    Bytes([$1D, $28, $6B, $03, $00, $31, $43, $06]),

    // QR 에러 레벨 (M)
    Bytes([$1D, $28, $6B, $03, $00, $31, $45, $31]),

    // QR 데이터 저장
    // (길이 계산)
    Bytes([
      $1D, $28, $6B,
      Byte((Length(NAVER_URL) + 3) and $FF),
      Byte(((Length(NAVER_URL) + 3) shr 8) and $FF),
      $31, $50, $30
    ]),
    AnsiToBytes(NAVER_URL),

    // QR 출력
    Bytes([$1D, $28, $6B, $03, $00, $31, $51, $30]),

    // 줄바꿈
    Bytes([$0A, $0A]),

    AnsiToBytes('Scan QR'),
    Bytes([$0A, $0A, $0A]),

    // 컷팅
    Bytes([$1D, $56, $41, $00])
  ]);
end;

function BytesToHex(const AData: TBytes): string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to High(AData) do
    Result := Result + IntToHex(AData[I], 2) + ' ';
end;

end.
