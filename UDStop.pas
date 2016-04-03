unit UDStop;

interface

uses LCLIntf, LCLType, LMessages, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls,Messages;

type

  { TDStop }

  TDStop = class(TForm)
    BStop: TBitBtn;
    BPause: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure reloadLang;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation
uses ULang;
{$R *.lfm}

procedure TDStop.reloadLang;
begin
  BStop.Caption :=_LBStopCaption;
  BPause.Caption := _lBPauseCaption;
end;

procedure TDStop.FormCreate(Sender: TObject);
begin
  Width:=240;
  reloadLang;
end;


end.

