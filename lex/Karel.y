%{
	unit UKarel;
	uses Ui18n,yacclib,lexlib;
	procedure yyerror(s:string);
	begin
		ShowMessage(s);
	end;
	var tree:TAst;
%}

%start start
%token <String> VAR_STRING
%token <Interger> NUM
%%


%%
{$include lexer.pas}

procedure GetAst(code: string)
begin
	yyparse();
end;