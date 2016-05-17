program Karel;

uses
  Forms, Interfaces,
  UKarel in 'UKarel.pas' {Form1},
  UCmdForm in 'UcmdForm.pas';
 var
  Form1: TForm1;

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TCmdForm,CmdForm);
  Application.Run;
end.
