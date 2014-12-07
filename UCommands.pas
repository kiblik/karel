unit UCommands;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, UMyEditor;

type
  TFCommands = class(TForm)
    ListBox1: TListBox;
    MyEditor1: TMyEditor;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

end.
