object DualTable_F: TDualTable_F
  Left = 1688
  Top = -2
  BorderStyle = bsNone
  Caption = 'DualTable_F'
  ClientHeight = 561
  ClientWidth = 804
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 804
    Height = 561
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Swf: TShockwaveFlash
      Left = 0
      Top = 0
      Width = 804
      Height = 561
      Align = alClient
      TabOrder = 0
      ControlData = {
        675566550009000019530000FB39000008000200000000000800040000002000
        00000800040000002000000008000E000000570069006E0064006F0077000000
        0800060000002D00310000000800060000002D003100000008000A0000004800
        690067006800000008000200000000000800060000002D003100000008000000
        00000800020000000000080010000000530068006F00770041006C006C000000
        0800040000003000000008000400000030000000080002000000000008000000
        000008000200000000000D000000000000000000000000000000000008000400
        0000310000000800040000003000000008000000000008000400000030000000
        08000800000061006C006C00000008000C000000660061006C00730065000000}
    end
  end
  object Swf_Tmr: TTimer
    Interval = 500
    OnTimer = Swf_TmrTimer
    Left = 352
    Top = 120
  end
end
