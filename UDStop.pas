unit UDStop;

interface

uses LCLIntf, LCLType, SysUtils, Classes, Graphics, Forms, Controls,
  Buttons, ExtCtrls;

type

  { TDStop }

  TDStop = class(TForm)
    BStop: TBitBtn;
    BPause: TBitBtn;
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
//  Width:=160;
  BStop.Caption:=_LBStopCaption;
  BPause.Caption:=_LBPauseCaption;
end;


end.

