%{
%}

%%

ak			return(CMD_IF); 
\*ak		return(E_IF);
opakuj		return(CMD_REPEAT);
\*opakuj	return(E_REPEAT);
prikaz		return(CMD);
\*prikaz	return(E_CMD);
inak		return(CMD_ELSE);
tak			return(CMD_THEN);
kym			return(CMD_WHILE);
\*kym		return(E_WHILE);
rob			return(CMD_DO);
je			return(IS);
nie			return(CMD_NOT);
krat		return(TIMES);
krok		return(STEP);
poloz		return(PUT);
zober		return(PICK);
vlavo		return(LEFT);
zmaz		return(CLEAR);
presun		return(MOVE);
stoj		return(STOP);
pomaly		return(SLOWLY);
rychlo		return(FAST);
tehla		return(BRICK);
stena		return(WALL);
nahoda		return(RANDOM);
volno		return(FREE);
poslednaf	return(LASTC);
podmienka	return(COND);
\*podmienka	return(E_COND);
oznac		return(MARK);
odznac		return(UNMARK);
znacka		return(MARKER);
vysledok	return(RESULT);
pravda		return(TRUE);
nepravda	return(FALSE);
polozf		return(PUTC);
[a-zA-Z]    begin yylval.yyString:=yyText; return(VAR_STRING); end;
[0-9]+		begin yylval.yyInteger:=StrToInt(yyText); return(NUM); end;
[ \t]		;
.			yyError(_lMsgErrorUnknownCmd);

%%