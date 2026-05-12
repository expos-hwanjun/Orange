unit UpdateNotice_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  Vcl.Menus, Vcl.StdCtrls, cxButtons, AdvScrollControl, AdvRichEditorBase,
  AdvRichEditor, Data.DB, cxControls, cxContainer, cxEdit, dxRatingControl,
  AdvGlassButton, cxLabel, Vcl.ExtCtrls;

type
  TUpdateNotice_F = class(TForm)
    CaptionLabel: TLabel;
    CloseButton: TcxButton;
    NoticesEditor: TAdvRichEditor;
    NoticePageRating: TdxRatingControl;
    NextButton: TAdvGlassButton;
    PriorButton: TAdvGlassButton;
    cxLabel1: TcxLabel;
    TitleLabel: TcxLabel;
    VersionLabel: TcxLabel;
    Shape2: TShape;
    NoticeDateLabel: TcxLabel;
    cxLabel2: TcxLabel;
    UpdateLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure PriorButtonClick(Sender: TObject);
    procedure NextButtonClick(Sender: TObject);
  private
    procedure ShowNotice;
  public
    UpdateDate :String;
  end;

var
  UpdateNotice_F: TUpdateNotice_F;

implementation
uses Common_U, DBModule_U, Const_U, GlobalFunc_U;
{$R *.dfm}

procedure TUpdateNotice_F.CloseButtonClick(Sender: TObject);
begin
  DM.CloudData.Close;
  Close;
end;

procedure TUpdateNotice_F.FormCreate(Sender: TObject);
begin
  Common.LogoCreate(Self,1);
end;

procedure TUpdateNotice_F.FormShow(Sender: TObject);
begin
  //업데이트 내역있는지 체크(최근 3일내에 업데이트 내역있으면 아이콘 변경), 포스에서는 최대 1개월 업데이트만 표시
  try
    DM.OpenCloud('select SEQ, '
                +'       NOTICE_DATA, '
                +'       NOTICE_TITLE, '
                +'       VERSION, '
                +'       DT_INSERT '
                +'  from UPDATE_NOTICE '
                +' where DS_SOLUTION  =:P0 '
                +'   and Date_Format(DT_INSERT,''%Y%m%d'') >= :P1 '
                +' order by SEQ desc ',
                ['O',
                 UpdateDate],RestBaseURL);
    if not DM.CloudData.Eof then
    begin
      NoticePageRating.Properties.ItemCount := DM.CloudData.RecordCount;
      NoticePageRating.Rating := 1;
      PriorButton.Enabled := false;
      ShowNotice;
    end;
  finally
//    DM.CloudData.Close;
  end;
end;

procedure TUpdateNotice_F.NextButtonClick(Sender: TObject);
begin
  if DM.CloudData.Active then
    DM.CloudData.Next;
  NoticePageRating.Rating := NoticePageRating.Rating + 1;;
  ShowNotice;
end;

procedure TUpdateNotice_F.PriorButtonClick(Sender: TObject);
begin
  if DM.CloudData.Active then
    DM.CloudData.Prior;
  NoticePageRating.Rating := NoticePageRating.Rating -1;
  ShowNotice;
end;

procedure TUpdateNotice_F.ShowNotice;
var vStream :TStream;
begin
  try
    vStream := TMemoryStream.Create;
    vStream := DM.CloudData.CreateBLOBStream(DM.CloudData.FieldByName('NOTICE_DATA'), bmRead);
    NoticesEditor.LoadFromStream(vStream);
    TitleLabel.Caption   := DM.CloudData.FieldByName('NOTICE_TITLE').AsString;
    NoticeDateLabel.Caption := FormatDateTime('yyyy-mm-dd hh:nn',DM.CloudData.FieldByName('DT_INSERT').AsDateTime);
    VersionLabel.Caption := 'Ver. '+DM.CloudData.FieldByName('VERSION').AsString;
    UpdateLabel.Visible := String(GetFileVersion(Application.ExeName)) < DM.CloudData.FieldByName('VERSION').AsString;

    PriorButton.Enabled  := DM.CloudData.RecNo > 1;
    NextButton.Enabled   := DM.CloudData.RecNo < DM.CloudData.RecordCount;
  finally
    vStream.Free;
  end;
end;

end.
