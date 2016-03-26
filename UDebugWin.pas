unit UDebugWin;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons;

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
  private
    { private declarations }
  public
    { public declarations }
  end;

implementation

{$R *.lfm}

{ TDDebugWin }




end.

