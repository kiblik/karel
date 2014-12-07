unit ULang;

{$MODE Delphi}

interface
uses UUtils;
var _lMsgKarel_NoPic: string='Nenaiel som obrázok Karla! Karel nebude zobrazený!';
    _lMsgCloseAppl : string ='Projekt bol zmenený a nie je uloený. Mám napriek tomu program ukonèi?';
    _lMsgErrorUnknownCmd : string = 'Nepoznám príkaz ';
    _lMsgErrorOpakuj : string = 'Chybná truktúra príkazu opakuj';
    _lMsgErrorOpakujCislo : string = 'za slovom opakuj by malo nasledova èíslo';
    _lMsgErrorOpakujKrat : string ='chýba slovo ''krat'' v truktúre príkazu opakuj';
    _lMsgErrorOpakujEnd : string ='chybná truktúra príkazu opakuj - nenaiel som ukonèenie';
    _lMsgErrorKym : string ='chybná truktúra príkazu kym';
    _lMsgErrorKymJe : string = 'za slovom kym musí nasledova "je" alebo "nie je"';
    _lMsgErrorKymJezanie : string = 'za slovom nie musí nasledova "je"';
    _lMsgErrorKymRob : string ='oèakával som slovo rob';
    _lMsgErrorKymEnd : string ='chybná truktúra príkazu kym - nenaiel som ukonèenie';
    _lMsgErrorAk : string ='chybná truktúra príkazu ak';
    _lMsgErrorAkJe : string = 'za slovom ak musí nasledova "je" alebo "nie je"';
    _lMsgErrorAkJezanie : string = 'za slovom nie musí nasledova "je"';
    _lMsgErrorAkTak : string = 'oèakával som slovo tak';
    _lMsgErrorPresun : string ='Za príkazom presun oèakávam dve èísla';
    _lMsgErrorPrikaz : string ='Chybná truktúra príkazu ';
    _lMsgErrorPolozF : string ='Za príkazom polozf som oèakával farbu.';
    _lPrikazEndCmd : string = '*prikaz';
    _lInakCmd : string = 'inak';
    _lAkEndCmd : string = '*ak';
    _lTakCmd : string = 'tak';
    _lKymEndCmd : string ='*kym';
    _lRobCmd : string = 'rob';
    _lJeCmd : string = 'je';
    _lNieCmd : string = 'nie';
    _lKratCmd : string = 'krat';
    _lKrokCmd : string = 'krok';
    _lPolozCmd : string = 'poloz';
    _lZoberCmd : string = 'zober';
    _lVlavoCmd : string = 'vlavo';
    _lZmazCmd : string = 'zmaz';
    _lOpakujCmd : string = 'opakuj';
    _lOpakujEndCmd : string = '*opakuj';
    _lPresunCmd : string = 'presun';
    _lKymCmd : string = 'kym';
    _lStojCmd : string = 'stoj';
    _lPomalyCmd : string = 'pomaly';
    _lRychloCmd : string = 'rychlo';
    _lAkCmd : string = 'ak';
    _lTehlaCmd : string = 'tehla';
    _lStenaCmd : string = 'stena';
    _lNahodaCmd : string = 'nahoda';
    _lPrikazCmd : string = 'prikaz';
    _lVolnoCmd : string = 'volno';
    _lMsgErrorUnknownCnd : string= 'Nepoznám podmienku ';
    _lMsgSaveTitle : string='Uloenie projektu';
    _lMsgSaveError : string='Chyba pri ukladaní súboru.';
    _lMsgOpenError : string ='Chybný formát súboru.';
    _lMsgNoSavedWarn : string = 'Aktuálny projekt bude vymazaný. Mám pokraèova?';
    _lMsgNoSavedTitle : string='Neuloený projekt';
    _lMsgOpenTitle : string = 'Otvorenie projektu.';
    _lMsgReadingError : string ='Problém s otvorením súboru';
    _lMenuSubor : string ='Projekt';
    _lMenuNovyProjekt : string = 'Nový projekt';
    _lMenuOtvoritProjekt : string = 'Otvori projekt';
    _lMenuUlozitProjekt : string = 'Uloi projekt';
    _lMenuNastavenia : string = 'Nastavenia';
    _lMenuRozmeryMiestnosti : string = 'Rozmery miestnosti';
    _lMenuPosunMiestnosti : string = 'Posun miestnosti';
    _lMenuObmedzenieKarla : string = 'Obmedzenia Karla';
    _lMenuLupa : string = 'Zväèenie/zmenenie';
    _lMenuSlovnik : string = 'Príkazy Karla';
    _lMenuMIKoniec : string = 'Ukonèenie programu';
    _lTBNew : string = 'Nový projekt';
    _lTBOpen : string = 'Otvori projekt';
    _lTBSave : string = 'Uloi projekt';
    _lTBResize : string = 'Zmeni rozmery miestnosti';
    _lTBMove : string = 'Posunú miestnos';
    _lTBKarelLimit : string = 'Nastavi rôzne obmedzenia Karla';
    _lTBCommands : string = 'Otvori slovník s príkazmi Karla';
    _lBNewCaption : string = 'Nový'#13'príkaz';
    _lBDeleteCaption : string ='Zma'#13'príkaz';
    _lBRenameCaption : string ='Premenuj'#13'príkaz';
    _lNovyPrikaz : string = 'Nový príkaz';
    _lMsgZadajMeno : string = 'Zadaj meno nového príkazu';
    _lMsgErrorRezSlovo1 : string =' nemôe poui ako meno príkazu. ';
    _lMsgErrorRezSlovo2 : string =' je zakladný príkaz alebo je jeho súèasou.';
    _lMsgErrorJednoSlovo : string ='Meno príkazu musí by jedno slovo (bez medzier)';
    _lZmazatPrikaz : string = 'Mám zmaza príkaz';
    _lPremenovaniePrikazu : string = 'Premenovanie príkazu ';
    _lZadajMeno : string ='Zadaj nové meno príkazu:';
    _MsgErrorRovnakeMeno : string = 'Pôvodné a nové meno su rovnaké.';
    _MsgErrorUzExistuje : string = 'Nemôem zmeni meno na meno u existujúceho príkazu';
    _lRozmeryCaption : string = 'Nastavenie rozmerov miestnosti';
    _lRozmeryLBCaption : string = 'Rozmery miestnosti';
    _lRozmeryVyska : string ='Výka';
    _lRozmerySirka : string ='írka';
    _lRozmeryDlzka : string ='Dåka';
    _lButtonNastav : string = 'Nastavi';
    _lButtonNenastav : string = 'Zrui';
    _lMoveCaption : string = 'Klikaj na ípky';
    _lBStopCaption : string = 'zastavenie'#13#10'programu';
    _lLimitsCaption : string ='Obmedzenia Karla';
    _lLimitsVykrocit : string ='Poèet tehál, na ktoré vie Karel vykroèi';
    _lLimitsSpomalit : string ='Rýchlos Karla';
    _lZoomCaption : string ='Klikni na ípky na okrajoch posuvníka';
    _lMsgErrorPresun2 : string = 'Nesprávne súradnice za príkazom presun';
    _lMsgStop : string ='program zastavený';
    _lMsgErrorKrok : string ='Karel nemá vo¾no, nemôe urobi krok.';
    _lMsgErrorPolozPriStene : string = 'Karel stojí pred stenou, nemá kam poloi tehlu.';
    _lMsgErrorPolozVyska : string = 'Karel nemôe poloi tehlu vyie ako je výka miestnosti.';
    _lMsgErrorZoberNietco : string ='Pred Karlom nie je iadna tehla na zobratie.';
    _lOznacCmd : string ='oznac';
    _lOdznacCmd : string ='odznac';
    _lZnackaCmd : string ='znacka';
    _lPodmienkaCmd : string ='podmienka';
    _lErrorMsgPrikazZly : string ='Nesprávny formát príkazu';
    _lVysledokCnd : string = 'vysledok';
    _lMsgErrorCnd : string = 'Problém so spracovaním podmienky';
    _lPodmienkaEndCmd : string = '*podmienka';
    _lResultCmd : string ='vysledok';
    _lPravdaCmd : string ='pravda';
    _lNepravdaCmd : string ='nepravda';
    _lPolozFCmd : string ='polozf';
    _lYesButton : string ='Án&o';
    _lNoButton : string ='&Nie';
    _lCancelButton : string ='&Zrui';
    _lMsgUkoncenieProgramu : string ='Ukonèenie programu';
    _lMsgRunError : string ='Chyba pri spustení programu.';
    _lErrorMsgRuntime : string ='Chyba v programe';
    _lMsgUkladanie : string ='Ukladanie projektu';
    _lMsgNacitanie : string ='Naèítanie projektu';
    _lMsgNeulozeny : string ='Neuloený projekt';

function GetOpakuj(var Cmd : string; var OK : Boolean) : TOpakuj;
function GetPresun(var Cmd : string; var OK : Boolean) : TPresun;
function GetKym(var Cmd : string; var OK : Boolean) : TKym;
function GetAk(var Cmd : string; var OK : Boolean) : TAk;
function GetPrikaz(CmdName : string; Lines : array of string; var OK : Boolean) : string;
function GetCond(Cond : array of string;var OK : Boolean) :TCond;
function GetPolozF(var Cmd : string; var OK : Boolean) :TPolozF;

implementation
uses SysUtils;

function GetCond(Cond : array of string;var OK : Boolean) :TCond;
var S : string;
    I : Integer;
begin
  Result.Cmds:='';
  S:='';
  OK:=False;
  for I:=0 to Length(Cond)-1 do S:=S+' '+Cond[I];
  UnSpace(S);
  if LowerCase(First(S))<>'podmienka' then
    begin
      ErrorMsg:='Chybna truktúra podmienky';
      Exit
    end;
  First(S);
  if Last(S)<>'*podmienka' then
    begin
      ErrorMsg:='Chybná truktúra podmienky';
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
  if (S<>_lJeCmd)and(S<>_lNieCmd) then
    begin
      ErrorMsg:=_lMsgErrorAkJe;
      Exit
    end;
  Result.Je:=True;
  if S=_lNieCmd then
    begin
      S:=LowerCase(First(Cmd));
      if S<>_lJeCmd then
        begin
          ErrorMsg:=_lMsgErrorAkJezanie;
          Exit
        end;
      Result.Je:=False;
    end;
  S:=LowerCase(First(Cmd));
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
  if LowerCase(S)='nahoda' then
    begin
      if DefColors.Count=0 then Result.Color:=BrickColor
                           else Result.Color:=(DefColors.Objects[Random(DefColors.Count)] as TOColor).Color;
      OK:=True;
      Exit;
    end;
  if LowerCase(S)='poslednaf' then
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


end.
