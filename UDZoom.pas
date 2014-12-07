unit UDZoom;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TDZoom = class(TForm)
    SBSize: TScrollBar;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation
uses ULang;
{$R *.dfm}

procedure TDZoom.FormCreate(Sender: TObject);
begin
  Caption:=_lZoomCaption;
end;

end.
