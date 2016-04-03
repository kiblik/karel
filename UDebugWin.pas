unit UDebugWin;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, Ulang;

type

  { TDDebugWin }

  TDDebugWin = class(TForm)
    BStop: TBitBtn;
    BStep: TBitBtn;
    BContinue: TBitBtn;
    LIteration: TLabel;
    LLastCmd: TLabel;
    LNextCmd: TLabel;
    LStenaDesc: TLabel;
    LLastCmdDesc: TLabel;
    LNextCmdDesc: TLabel;
    LIterationDesc: TLabel;
    LStena: TLabel;
    LTehlaDesc: TLabel;
    LTehla: TLabel;
    LVolno: TLabel;
    LZnackaDesc: TLabel;
    LVolnoDesc: TLabel;
    LZnacka: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

implementation

{$R *.lfm}

{ TDDebugWin }

procedure TDDebugWin.FormCreate(Sender: TObject);
begin
  Caption:=_lDebugWin;
  LLastCmdDesc.Caption:=_lLastCmdDesc;
  LNextCmdDesc.Caption:=_lNextCmdDesc;
  LIterationDesc.Caption:=_lIterationDesc;
  LStenaDesc.Caption:=_lStenaDesc;
  LTehlaDesc.Caption:=_lTehlaDesc;
  LZnackaDesc.Caption:=_lZnackaDesc;
  LVolnoDesc.Caption:=_lVolnoDesc;
end;

end.

