unit UDStop;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls,Messages;

type
  TDStop = class(TForm)
    BStop: TBitBtn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation
uses ULang;
{$R *.dfm}

procedure TDStop.FormCreate(Sender: TObject);
begin
  Width:=80;
  BStop.Caption:=_LBStopCaption;
end;

end.
