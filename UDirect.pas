unit UDirect;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons, Ulang;

type

  { TDirectForm }

  TDirectForm = class(TForm)
    SBkrok: TSpeedButton;
    SBodznac: TSpeedButton;
    SBzober: TSpeedButton;
    SBvlavo: TSpeedButton;
    SBoznac: TSpeedButton;
    SBpoloz: TSpeedButton;
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

implementation

{$R *.lfm}

{ TDirectForm }

procedure TDirectForm.FormCreate(Sender: TObject);
begin
  SBkrok.Caption:=_lKrokCmd;
  SBvlavo.Caption:=_lVlavoCmd;
  SBzober.Caption:=_lZoberCmd;
  SBpoloz.Caption:=_lPolozCmd;
  SBoznac.Caption:=_lOznacCmd;
  SBodznac.Caption:=_lOdznacCmd;
end;

end.

