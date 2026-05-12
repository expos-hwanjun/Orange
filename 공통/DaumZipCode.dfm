object DaumZipCodeForm: TDaumZipCodeForm
  Left = 336
  Top = 125
  BorderStyle = bsDialog
  Caption = #50864#54200#48264#54840
  ClientHeight = 500
  ClientWidth = 500
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object WebBrowser: TWebBrowser
    Left = -12
    Top = -17
    Width = 666
    Height = 680
    TabOrder = 0
    OnDocumentComplete = WebBrowserDocumentComplete
    ControlData = {
      4C000000D5440000484600000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
end
