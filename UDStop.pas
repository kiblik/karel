unit UDStop;

interface

uses LCLIntf, LCLType, LMessages, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls,Messages;

type

  { TDStop }

  TDStop = class(TForm)
    BStop: TBitBtn;
    BPause: TBitBtn;
    BStep: TBitBtn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation
uses ULang;
{$R *.lfm}

procedure TDStop.FormCreate(Sender: TObject);
begin
  Width:=240;
  BStop.Caption:=_LBStopCaption;
end;

end.
