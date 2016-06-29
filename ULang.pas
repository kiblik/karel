unit ULang;

interface
uses UUtils;

var _lMsgKarel_NoPic: string='';
    _lMsgCloseAppl : string ='';
    _lMsgErrorUnknownCmd : string = '';
    _lMsgErrorOpakuj : string = '';
    _lMsgErrorOpakujCislo : string = '';
    _lMsgErrorOpakujKrat : string ='';
    _lMsgErrorOpakujEnd : string ='';
    _lMsgErrorKym : string ='';
    _lMsgErrorKymJe : string = '';
    _lMsgErrorKymJezanie : string = '';
    _lMsgErrorKymRob : string ='';
    _lMsgErrorKymEnd : string ='';
    _lMsgErrorAk : string ='';
    _lMsgErrorAkJe : string = '';
    _lMsgErrorAkJezanie : string = '';
    _lMsgErrorAkTak : string = '';
    _lMsgErrorPresun : string ='';
    _lMsgErrorPrikaz : string ='';
    _lMsgErrorPolozF : string ='';
    _lMsgErrorPodmienka : string = '';
    _lPrikazEndCmd : string = '';
    _lInakCmd : string = '';
    _lAkEndCmd : string = '';
    _lTakCmd : string = '';
    _lKymEndCmd : string ='';
    _lRobCmd : string = '';
    _lJeCmd : string = '';
    _lNieCmd : string = '';
    _lKratCmd : string = '';
    _lKrokCmd : string = '';
    _lPolozCmd : string = '';
    _lZoberCmd : string = '';
    _lVlavoCmd : string = '';
    _lZmazCmd : string = '';
    _lOpakujCmd : string = '';
    _lOpakujEndCmd : string = '';
    _lPresunCmd : string = '';
    _lKymCmd : string = '';
    _lStojCmd : string = '';
    _lPomalyCmd : string = '';
    _lRychloCmd : string = '';
    _lAkCmd : string = '';
    _lTehlaCmd : string = '';
    _lStenaCmd : string = '';
    _lNahodaCmd : string = '';
    _lPrikazCmd : string = '';
    _lVolnoCmd : string = '';
    _lPoslednaFCmd : string = '';
    _lPodmienkaCmd : string = '';
    _lPodmienkaEndCmd : string = '';
    _lMsgErrorUnknownCnd : string= '';
    _lMsgSaveTitle : string='';
    _lMsgSaveError : string='';
    _lMsgOpenError : string ='';
    _lMsgNoSavedWarn : string = '';
    _lMsgNoSavedTitle : string='';
    _lMsgOpenTitle : string = '';
    _lMsgReadingError : string ='';
    _lMenuSubor : string ='';
    _lMenuNovyProjekt : string = '';
    _lMenuOtvoritProjekt : string = '';
    _lMenuUlozitProjekt : string = '';
    _lMenuNastavenia : string = '';
    _lMenuRozmeryMiestnosti : string = '';
    _lMenuPosunMiestnosti : string = '';
    _lMenuObmedzenieKarla : string = '';
    _lMenuLupa : string = '';
    _lMenuSlovnik : string = '';
    _lMenuMIKoniec : string = '';
    _lTBNew : string = '';
    _lTBOpen : string = '';
    _lTBSave : string = '';
    _lMenuJazyk : string = '';
    _lTBResize : string = '';
    _lTBMove : string = '';
    _lTBKarelLimit : string = '';
    _lTBCommands : string = '';
    _lBNewCaption : string = '';
    _lBDeleteCaption : string ='';
    _lBRenameCaption : string ='';
    _lNovyPrikaz : string = '';
    _lMsgZadajMeno : string = '';
    _lMsgErrorRezSlovo1 : string ='';
    _lMsgErrorRezSlovo2 : string ='';
    _lMsgErrorJednoSlovo : string ='';
    _lZmazatPrikaz : string = '';
    _lPremenovaniePrikazu : string = '';
    _lZadajMeno : string ='';
    _MsgErrorRovnakeMeno : string = '';
    _MsgErrorUzExistuje : string = '';
    _lRozmeryCaption : string = '';
    _lRozmeryLBCaption : string = '';
    _lRozmeryVyska : string ='';
    _lRozmerySirka : string ='';
    _lRozmeryDlzka : string ='';
    _lButtonNastav : string = '';
    _lButtonNenastav : string = '';
    _lMoveCaption : string = '';
    _lBStopCaption : string = '';
    _lLimitsCaption : string ='';
    _lLimitsVykrocit : string ='';
    _lLimitsSpomalit : string ='';
    _lZoomCaption : string ='';
    _lMsgErrorPresun2 : string = '';
    _lMsgStop : string ='';
    _lMsgErrorKrok : string ='';
    _lMsgErrorPolozPriStene : string = '';
    _lMsgErrorPolozVyska : string = '';
    _lMsgErrorZoberNietco : string ='';
    _lOznacCmd : string ='';
    _lOdznacCmd : string ='';
    _lZnackaCmd : string ='';
    _lErrorMsgPrikazZly : string ='';
    _lVysledokCnd : string = '';
    _lMsgErrorCnd : string = '';
    _lResultCmd : string ='';
    _lPravdaCmd : string ='';
    _lNepravdaCmd : string ='';
    _lPolozFCmd : string ='';
    _lYesButton : string ='';
    _lNoButton : string ='';
    _lCancelButton : string ='';
    _lMsgUkoncenieProgramu : string ='';
    _lMsgRunError : string ='';
    _lErrorMsgRuntime : string ='';
    _lMsgUkladanie : string ='';
    _lMsgNacitanie : string ='';
    _lMsgNeulozeny : string ='';
    _lSBZobrazZadanie : string = '';
    _lSBUpravZadanie: string = '';
    _lSBUpravPlochu: string = '';
    _lMIAddLevel: string = '';
    _lMIRemoveLevel: string = '';
    _lMIRenameLevel: string = '';
    _lLevelName: string = '';
    _lWriteLevelName: string = '';
    _lLevelNameCannotBeEmpty: string = '';
    _lCannotBeRemovedLastLevel: string = '';
    _lPozastavCmd: string = '';
    _lPokracujCmd: string = '';
    _lBPauseCaption: string = '';
    _lBContinueCaption: string = '';
	_lDebugWin: string = '';
    _lLastCmdDesc: string = '';
    _lNextCmdDesc: string = '';
    _lIterationDesc: string = '';
    _lStenaDesc: string = '';
    _lTehlaDesc: string = '';
    _lZnackaDesc: string = '';
    _lVolnoDesc: string = '';
    _lSBReset: string = '';
    _lBStop: string = '';
    _lBStep: string = '';
    _lBContinue: string = '';
    _lFPriamyRezim: string = '';

function GetOpakuj(var Cmd : string; var OK : Boolean) : TOpakuj;
function GetPresun(var Cmd : string; var OK : Boolean) : TPresun;
function GetKym(var Cmd : string; var OK : Boolean) : TKym;
function GetAk(var Cmd : string; var OK : Boolean) : TAk;
function GetPrikaz(CmdName : string; Lines : array of string; var OK : Boolean) : string;
function GetCond(Cond : array of string;var OK : Boolean) :TCond;
function GetPolozF(var Cmd : string; var OK : Boolean) :TPolozF;

implementation
uses Ui18n,SysUtils;

function GetCond(Cond : array of string;var OK : Boolean) :TCond;
var S : string;
    I : Integer;
begin
  Result.Cmds:='';
  S:='';
  OK:=False;
  for I:=0 to Length(Cond)-1 do S:=S+' '+Cond[I];
  UnSpace(S);
  if LowerCase(First(S))<>_lPodmienkaCmd then
    begin
      ErrorMsg:= _lMsgErrorPodmienka;
      Exit
    end;
  First(S);
  if Last(S)<>_lPodmienkaEndCmd then
    begin
      ErrorMsg:= _lMsgErrorPodmienka;
      Exit
    end;
  OK:=True;
  Result.Cmds:=S
end;

function GetOpakuj(var Cmd : string; var OK : Boolean) : TOpakuj;
var Iter,Pom : Integer;
    S : string;
begin
  Iter:=1;
  OK:=False;
  Result.Pocet:=0;
  Result.Commands:='';
  if Cmd='' then
    begin
      ErrorMsg:=_lMsgErrorOpakuj;
      Exit;
    end;
  {cislo}
  S:=First(Cmd);
  Val(S,Result.Pocet,Pom);
  if Pom>0 then
    begin
      ErrorMsg:=_lMsgErrorOpakujCislo;
      Exit
    end;
  S:=First(Cmd);
  if LowerCase(S)<>_lKratCmd then
    begin
      ErrorMsg:=_lMsgErrorOpakujKrat;
      Exit
    end;
  S:=First(Cmd);
  while  (Iter>0) and ((S<>'') or (Cmd<>'')) do
    begin
      if LowerCase(S)=_lOpakujCmd then Inc(Iter);
      if LowerCase(S)=_lOpakujEndCmd then Dec(Iter);
      if Iter>0 then
        begin
          Result.Commands:=Result.Commands+S+' ';
          S:=First(Cmd);
        end;
    end;
  if Iter>0 then
    begin
      ErrorMsg:=_lMsgErrorOpakujEnd;
      Exit;
    end;
  OK:=True;
  ErrorMsg:='';
end;

function GetKym(var Cmd : string; var OK : Boolean) : TKym;
var Iter : Integer;
    S : string;
begin
  Iter:=1;
  OK:=False;
  Result.Je:=True;
  Result.Cond:='';
  Result.Commands:='';
  if Cmd='' then
    begin
      ErrorMsg:=_lMsgErrorKym;
      Exit;
    end;
  {cislo}
  S:=LowerCase(First(Cmd));
    if (currentLang=lang_SK) then begin
       if (S<>_lJeCmd)and(S<>_lNieCmd) then
          begin
  	    ErrorMsg:=_lMsgErrorKymJe;
  	    Exit
          end;
        Result.Je:=True;
        if S=_lNieCmd then
        begin
          S:=LowerCase(First(Cmd));
  	  if S<>_lJeCmd then
  	  begin
  	       ErrorMsg:=_lMsgErrorKymJezanie;
  	       Exit
  	  end;
          Result.Je:=False;
        end;
        S:=LowerCase(First(Cmd));
  end
  else if (currentLang=lang_EN) then begin
         if (S<>_lJeCmd) then
         begin
              ErrorMsg:=_lMsgErrorKymJe;
  	    Exit
         end;
         Result.Je:=True;
         S:=LowerCase(First(Cmd));
         if S=_lNieCmd then
         begin
              S:=LowerCase(First(Cmd));
  	    Result.Je:=False;
         end;
  end;
  if BasicCnds.IndexOf(S)=-1 then S:='%'+S;
  Result.Cond:=S;
  S:=LowerCase(First(Cmd));
  if S<>_lRobCmd then
    begin
      ErrorMsg:=_lMsgErrorKymRob;
      Exit
    end;
  S:=First(Cmd);
  Result.Commands:='';
  while  (Iter>0) and ((S<>'') or (Cmd<>'')) do
    begin
      if LowerCase(S)=_lKymCmd then Inc(Iter);
      if LowerCase(S)=_lKymEndCmd then Dec(Iter);
      if Iter>0 then
        begin
          Result.Commands:=Result.Commands+S+' ';
          S:=First(Cmd);
        end;
    end;
  if Iter>0 then
    begin
      ErrorMsg:=_lMsgErrorKymEnd;
      Exit;
    end;
  OK:=True;
  ErrorMsg:='';
end;

function GetAk(var Cmd : string; var OK : Boolean) : TAk;
var Iter : Integer;
    S : string;
begin
  Iter:=1;
  OK:=False;
  Result.Je:=True;
  Result.Cond:='';
  Result.TrueCmd:='';
  Result.FalseCmd:='';
  if Cmd='' then
    begin
      ErrorMsg:=_lMsgErrorKym;
      Exit;
    end;
  {cislo}
  S:=LowerCase(First(Cmd));
  if (currentLang=lang_SK) then begin
     if (S<>_lJeCmd)and(S<>_lNieCmd) then
        begin
	  ErrorMsg:=_lMsgErrorKymJe;
	  Exit
        end;
      Result.Je:=True;
      if S=_lNieCmd then
      begin
        S:=LowerCase(First(Cmd));
	if S<>_lJeCmd then
	begin
	     ErrorMsg:=_lMsgErrorKymJezanie;
	     Exit
	end;
        Result.Je:=False;
      end;
      S:=LowerCase(First(Cmd));
  end
  else if (currentLang=lang_EN) then begin
       if (S<>_lJeCmd) then
       begin
            ErrorMsg:=_lMsgErrorKymJe;
	    Exit
       end;
       Result.Je:=True;
       S:=LowerCase(First(Cmd));
       if S=_lNieCmd then
       begin
            S:=LowerCase(First(Cmd));
	    Result.Je:=False;
       end;
  end;
  Result.Cond:=S;
  S:=LowerCase(First(Cmd));
  if S<>_lTakCmd then
    begin
      ErrorMsg:=_lMsgErrorAkTak;
      Exit
    end;
  S:=First(Cmd);
  while  (Iter>0) and ((S<>'') or (Cmd<>'')) do
    begin
      if LowerCase(S)=_lAkCmd then Inc(Iter);
      if (Iter=1)and(LowerCase(S)=_lInakCmd) then Dec(Iter);
      if LowerCase(S)=_lAkEndCmd then Dec(Iter);
      if Iter>0 then
        begin
          Result.TrueCmd:=Result.TrueCmd+S+' ';
          S:=First(Cmd);
        end;
    end;
  if Iter>0 then
    begin
      ErrorMsg:=_lMsgErrorAk;
      Exit;
    end;
  if LowerCase(S)=_lInakCmd then
    begin
      S:=First(Cmd);
      Iter:=1;
      while  (Iter>0) and ((S<>'') or (Cmd<>'')) do
        begin
          if LowerCase(S)=_lAkCmd then Inc(Iter);
          if LowerCase(S)=_lAkEndCmd then Dec(Iter);
          if Iter>0 then
            begin
              Result.FalseCmd:=Result.FalseCmd+S+' ';
              S:=First(Cmd);
            end;
        end;
      if Iter>0 then
        begin
          ErrorMsg:=_lMsgErrorAk;
          Exit;
        end;
    end;
  OK:=True;
  ErrorMsg:='';
end;

function GetPresun(var Cmd : string; var OK : Boolean) : TPresun;
var Pom : Integer;
      S : string;
begin
  OK:=False;
  ErrorMsg:=_lMsgErrorPresun;
  S:=First(Cmd);
  Val(S,Result.NX,Pom);
  if Pom <>0 then Exit;
  S:=First(Cmd);
  Val(S,Result.NY,Pom);
  if Pom<>0 then Exit;
  ErrorMsg:='';
  OK:=True;
end;

function GetPolozF(var Cmd : string; var OK : Boolean) : TPolozF;
var S : string;
begin
  S:=First(Cmd);
  if LowerCase(S)=_lNahodaCmd then
    begin
      if DefColors.Count=0 then Result.Color:=BrickColor
                           else Result.Color:=(DefColors.Objects[Random(DefColors.Count)] as TOColor).Color;
      OK:=True;
      Exit;
    end;
  if LowerCase(S)=_lPoslednaFCmd then
    begin
      Result.Color:=LastTakenColor;
      OK:=True;
      Exit
    end;
  if DefColors.IndexOf(S)=-1 then
    begin
      OK:=False;
      ErrorMsg:=_lMsgErrorPolozF;
    end
  else
    begin
      OK:=True;
      Result.Color:=(DefColors.Objects[DefColors.IndexOf(S)] as TOColor).Color;
    end;
end;

function GetPrikaz(CmdName : string; Lines : array of string; var OK : Boolean) : string;
var I : Integer;
    S,C : string;
begin
  OK:=False;
  S:='';
  for I:=0 to Length(Lines)-1 do S:=S+Lines[I]+' ';
  UnSpace(S);
  Result:='';
  C:=First(S);
  if (C<>_lPrikazCmd) and (C<>_lPodmienkaCmd) or(S='') then
    begin
      ErrorMsg:=_lMsgErrorPrikaz+CmdName;
      Exit
    end;
  C:=First(S);
  if (S='') then
    begin
      ErrorMsg:=_lMsgErrorPrikaz+CmdName;
      Exit
    end;
  C:=Last(S);
  if (C<>_lPrikazEndCmd) and (C<>_lPodmienkaEndCmd) then
    begin
      ErrorMsg:=_lMsgErrorPrikaz+CmdName;
      Exit
    end;
  Result:=S;
  OK:=True;
  {este treba odrezat koniec prikazu *prikaz}
end;

initialization
begin
     setLang(lang_EN);
end;

end.
