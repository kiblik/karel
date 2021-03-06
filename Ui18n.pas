unit Ui18n;

interface

type TLang = (lang_SK,lang_EN);

var currentLang : TLang;
  
procedure setLang(lang: TLang);

implementation
uses SysUtils,ULang,UUtils;

procedure setLangSK;
begin
    currentLang := lang_SK;
    _lMsgKarel_NoPic:='Nenašiel som obrázok Karla! Karel nebude zobrazený!';
    _lMsgCloseAppl :='Projekt bol zmenený a nie je uložený. Mám napriek tomu program ukončiť?';
    _lMsgErrorUnknownCmd := 'Nepoznám príkaz ';
    _lMsgErrorOpakuj := 'Chybná štruktúra príkazu opakuj';
    _lMsgErrorOpakujCislo := 'za slovom opakuj by malo nasledovať číslo';
    _lMsgErrorOpakujKrat :='chýba slovo ''krat'' v štruktúre príkazu opakuj';
    _lMsgErrorOpakujEnd :='chybná štruktúra príkazu opakuj - nenašiel som ukončenie';
    _lMsgErrorKym :='chybná štruktúra príkazu kym';
    _lMsgErrorKymJe := 'za slovom kym musí nasledovať "je" alebo "nie je"';
    _lMsgErrorKymJezanie := 'za slovom nie musí nasledovať "je"';
    _lMsgErrorKymRob :='očakával som slovo rob';
    _lMsgErrorKymEnd :='chybná štruktúra príkazu kym - nenašiel som ukončenie';
    _lMsgErrorAk :='chybná štruktúra príkazu ak';
    _lMsgErrorAkJe := 'za slovom ak musí nasledovať "je" alebo "nie je"';
    _lMsgErrorAkJezanie := 'za slovom nie musí nasledovať "je"';
    _lMsgErrorAkTak := 'očakával som slovo tak';
    _lMsgErrorPresun :='Za príkazom presun očakávam dve čísla';
    _lMsgErrorPrikaz :='Chybná štruktúra príkazu ';
    _lMsgErrorPolozF :='Za príkazom polozf som očakával farbu.';
    _lMsgErrorPodmienka := 'Chybna štruktúra podmienky';
    _lPrikazEndCmd := '*prikaz';
    _lInakCmd := 'inak';
    _lAkEndCmd := '*ak';
    _lTakCmd := 'tak';
    _lKymEndCmd :='*kym';
    _lRobCmd := 'rob';
    _lJeCmd := 'je';
    _lNieCmd := 'nie';
    _lKratCmd := 'krat';
    _lKrokCmd := 'krok';
    _lPolozCmd := 'poloz';
    _lZoberCmd := 'zober';
    _lVlavoCmd := 'vlavo';
    _lZmazCmd := 'zmaz';
    _lOpakujCmd := 'opakuj';
    _lOpakujEndCmd := '*opakuj';
    _lPresunCmd := 'presun';
    _lKymCmd := 'kym';
    _lStojCmd := 'stoj';
    _lPomalyCmd := 'pomaly';
    _lRychloCmd := 'rychlo';
    _lAkCmd := 'ak';
    _lTehlaCmd := 'tehla';
    _lStenaCmd := 'stena';
    _lNahodaCmd := 'nahoda';
    _lPrikazCmd := 'prikaz';
    _lVolnoCmd := 'volno';
    _lPoslednaFCmd := 'poslednaf';
    _lPodmienkaCmd := 'podmienka';
    _lPodmienkaEndCmd := '*podmienka';
    _lMsgErrorUnknownCnd := 'Nepoznám podmienku ';
    _lMsgSaveTitle :='Uložnie projektu';
    _lMsgSaveError :='Chyba pri ukladaní súboru.';
    _lMsgOpenError :='Chybný formát súboru.';
    _lMsgNoSavedWarn := 'Aktuálny projekt bude vymazaný. Mám pokračovať?';
    _lMsgNoSavedTitle :='Neuložný projekt';
    _lMsgOpenTitle := 'Otvorenie projektu.';
    _lMsgReadingError :='Problém s otvorením súboru';
    _lMenuSubor :='Projekt';
    _lMenuNovyProjekt := 'Nový projekt';
    _lMenuOtvoritProjekt := 'Otvoriť projekt';
    _lMenuUlozitProjekt := 'Uložiť projekt';
    _lMenuNastavenia := 'Nastavenia';
    _lMenuRozmeryMiestnosti := 'Rozmery miestnosti';
    _lMenuPosunMiestnosti := 'Posun miestnosti';
    _lMenuObmedzenieKarla := 'Obmedzenia Karla';
    _lMenuLupa := 'Zväčšenie/zmenšenie';
    _lMenuSlovnik := 'Príkazy Karla';
    _lMenuMIKoniec := 'Ukončenie programu';
    _lTBNew := 'Nový projekt';
    _lTBOpen := 'Otvoriť projekt';
    _lTBSave := 'Uložiť projekt';
    _lMenuJazyk := 'Jazyk';
    _lTBResize := 'Zmeniť rozmery miestnosti';
    _lTBMove := 'Posunúť miestnosť';
    _lTBKarelLimit := 'Nastaviť rôzne obmedzenia Karla';
    _lTBZoom := 'Zväčšiť a zmenšiť miestnost';
    _lTBCommands := 'Otvoriť slovník s príkazmi Karla';
    _lBNewCaption := 'Nový'#13'príkaz';
    _lBDeleteCaption :='Zmaž'#13'príkaz';
    _lBRenameCaption :='Premenuj'#13'príkaz';
    _lNovyPrikaz := 'Nový príkaz';
    _lMsgZadajMeno := 'Zadaj meno nového príkazu';
    _lMsgErrorRezSlovo1 :=' nemôžeš použiť ako meno príkazu. ';
    _lMsgErrorRezSlovo2 :=' je zakladný príkaz alebo je jeho súčasťou.';
    _lMsgErrorJednoSlovo :='Meno príkazu musí byť jedno slovo (bez medzier)';
    _lZmazatPrikaz := 'Mám zmazať príkaz';
    _lPremenovaniePrikazu := 'Premenovanie príkazu ';
    _lZadajMeno :='Zadaj nové meno príkazu:';
    _MsgErrorRovnakeMeno := 'Pôvodné a nové meno su rovnaké.';
    _MsgErrorUzExistuje := 'Nemôžem zmeniť meno na meno už existujúceho príkazu';
    _lRozmeryCaption := 'Nastavenie rozmerov miestnosti';
    _lRozmeryLBCaption := 'Rozmery miestnosti';
    _lRozmeryVyska :='Výška';
    _lRozmerySirka :='Šírka';
    _lRozmeryDlzka :='Dĺžka';
    _lButtonNastav := 'Nastaviť';
    _lButtonNenastav := 'Zrušiť';
    _lMoveCaption := 'Klikaj na šípky';
    _lBStopCaption := 'zastavenie'#13#10'programu';
    _lLimitsCaption :='Obmedzenia Karla';
    _lLimitsVykrocit :='Počet tehál, na ktoré vie Karel vykročiť';
    _lLimitsSpomalit :='Rýchlosť Karla';
    _lZoomCaption :='Klikni na šípky na okrajoch posuvníka';
    _lMsgErrorPresun2 := 'Nesprávne súradnice za príkazom presun';
    _lMsgStop :='program zastavený';
    _lMsgErrorKrok :='Karel nemá voľno, nemôže urobiť krok.';
    _lMsgErrorPolozPriStene := 'Karel stojí pred stenou, nemá kam položiť tehlu.';
    _lMsgErrorPolozVyska := 'Karel nemôže položiť tehlu vyššie ako je výška miestnosti.';
    _lMsgErrorZoberNietco :='Pred Karlom nie je žiadna tehla na zobratie.';
    _lOznacCmd :='oznac';
    _lOdznacCmd :='odznac';
    _lZnackaCmd :='znacka';
    _lErrorMsgPrikazZly :='Nesprávny formát príkazu';
    _lVysledokCnd := 'vysledok';
    _lMsgErrorCnd := 'Problém so spracovaním podmienky';
    _lResultCmd :='vysledok';
    _lPravdaCmd :='pravda';
    _lNepravdaCmd :='nepravda';
    _lPolozFCmd :='polozf';
    _lYesButton :='Án&o';
    _lNoButton :='&Nie';
    _lCancelButton :='&Zrušiť';
    _lMsgUkoncenieProgramu :='Ukončenie programu';
    _lMsgRunError :='Chyba pri spustení programu.';
    _lErrorMsgRuntime :='Chyba v programe';
    _lMsgUkladanie :='Ukladanie projektu';
    _lMsgNacitanie :='Načítanie projektu';
    _lMsgNeulozeny :='Neuložený projekt';
    _lSBZobrazZadanie := 'Zobraz zadanie';
    _lSBUpravZadanie:= 'Uprav zadanie';
    _lSBUpravPlochu:= 'Uprav plochu';
    _lMIAddLevel:= 'Pridaj zadanie';
    _lMIRemoveLevel:= 'Odstráň zadanie';
    _lMIRenameLevel:= 'Premenuj zadanie';
    _lLevelName:= 'Názov zadania';
    _lWriteLevelName:= 'Napíš názov zadania';
    _lLevelNameCannotBeEmpty:= 'Názov zadania nemôže byť prázdny';
    _lCannotBeRemovedLastLevel:= 'Posledný level nemôže byť zmazaný';
    _lPozastavCmd:= 'pozastav';
    _lPokracujCmd:= 'pokracuj';
    _lBPauseCaption:= 'Pozastav';
    _lBContinueCaption:= 'Pokračuj';
	_lDebugWin:= 'Ladenie';
    _lLastCmdDesc:= 'Posledný príkaz';
    _lNextCmdDesc:= 'Nasledujúcu príkaz';
    _lIterationDesc := 'Zostavajúci počet opakovaní';
    _lStenaDesc:= 'je stena';
    _lTehlaDesc:= 'je tehla';
    _lZnackaDesc:= 'je značka';
    _lVolnoDesc:= 'je voľno';
    _lSBReset:= 'Obnov zadanie';
    _lBStop:= 'Zastav';
    _lBStep:= 'Ďalší príkaz';
    _lBContinue:= 'Pokračuj';
    _lFPriamyRezim:= 'Priamy režim';
end;

procedure setLangEN;
begin
    currentLang := lang_EN;
    _lMsgKarel_NoPic:='Could not find picture of Karel! Karel will not be displayed!';
    _lMsgCloseAppl :='The project was changed and is not saved. Exit anyway?';
    _lMsgErrorUnknownCmd := 'Unknown command ';
    _lMsgErrorOpakuj := 'Bad structure of the command repeat';
    _lMsgErrorOpakujCislo := 'A number should follow the word repeat';
    _lMsgErrorOpakujKrat :='Missing word ''times'' in the structure of repeat command';
    _lMsgErrorOpakujEnd :='Bad structure of the command repeat - could not find termination statement';
    _lMsgErrorKym :='Bad structure of the command while';
    _lMsgErrorKymJe := 'The word while must be followed by either "is" or "is not"';
	
    _lMsgErrorKymJezanie := 'za slovom nie musí nasledovať "je"';
    _lMsgErrorKymRob :='The word ''do'' was expected';
	
    _lMsgErrorKymEnd :='Bad structure of the command while - could not find termination statement';
    _lMsgErrorAk :='Bad structure of the command if';
    _lMsgErrorAkJe := 'The word if must be followed by either "is" or "is not"';
	
    _lMsgErrorAkJezanie := 'za slovom nie musí nasledovať "je"';
	
    _lMsgErrorAkTak := 'The word ''then'' was expected';
    _lMsgErrorPresun :='Two numbers expected after the move command';
    _lMsgErrorPrikaz :='Bad command structure.';
    _lMsgErrorPolozF :='Colour expected after the command putc.';
    _lMsgErrorPodmienka := 'Bad condition structure.';
    _lPrikazEndCmd := '*command';
    _lInakCmd := 'else';
    _lAkEndCmd := '*if';
    _lTakCmd := 'then';
    _lKymEndCmd :='*while';
    _lRobCmd := 'do';
    _lJeCmd := 'is';
    _lNieCmd := 'not';
    _lKratCmd := 'times';
    _lKrokCmd := 'step';
    _lPolozCmd := 'put';
    _lZoberCmd := 'take';
    _lVlavoCmd := 'left';
    _lZmazCmd := 'clear';
    _lOpakujCmd := 'repeat';
    _lOpakujEndCmd := '*repeat';
    _lPresunCmd := 'move';
    _lKymCmd := 'while';
    _lStojCmd := 'stop';
    _lPomalyCmd := 'slowly';
    _lRychloCmd := 'fast';
    _lAkCmd := 'if';
    _lTehlaCmd := 'brick';
    _lStenaCmd := 'wall';
    _lNahodaCmd := 'random';
    _lPrikazCmd := 'command';
    _lVolnoCmd := 'free';
    _lPoslednaFCmd := 'lastc';
    _lPodmienkaCmd := 'condition';
    _lPodmienkaEndCmd := '*condition';
    _lMsgErrorUnknownCnd := 'Unknown condition ';
    _lMsgSaveTitle :='Save project';
    _lMsgSaveError :='Error has occurred while saving file.';
    _lMsgOpenError :='Wrong file format.';
    _lMsgNoSavedWarn := 'Current project will be deleted. Do you want to continue?';
    _lMsgNoSavedTitle :='Unsaved project';
    _lMsgOpenTitle := 'Open project';
    _lMsgReadingError :='Error has occurred while opening file.';
    _lMenuSubor :='Project';
    _lMenuNovyProjekt := 'New project';
    _lMenuOtvoritProjekt := 'Open project';
    _lMenuUlozitProjekt := 'Save project';
    _lMenuNastavenia := 'Settings';
    _lMenuRozmeryMiestnosti := 'Dimensions of the room';
    _lMenuPosunMiestnosti := 'Room''s shift';
    _lMenuObmedzenieKarla := 'Karel''s restrictions';
    _lMenuLupa := 'Shrink/Enlarge';
    _lMenuSlovnik := 'Karel''s commands';
    _lMenuMIKoniec := 'Exit program';
    _lTBNew := 'New project';
    _lTBOpen := 'Open project';
    _lTBSave := 'Save project';
	_lMenuJazyk := 'Language';
    _lTBResize := 'Change dimensions of the room';
    _lTBMove := 'Shift the room';
    _lTBKarelLimit := 'Set Karel''s various restrictions';
    _lTBZoom := 'Zoom in and zoom out room';
    _lTBCommands := 'Open a dictionary with Karel''s commands';
    _lBNewCaption := 'New'#13'command';
    _lBDeleteCaption :='Delete'#13'command';
    _lBRenameCaption :='Rename'#13'command';
    _lNovyPrikaz := 'New command';
    _lMsgZadajMeno := 'Enter a name for the new command';
    _lMsgErrorRezSlovo1 :=' can''t be used as a name of a command. ';
    _lMsgErrorRezSlovo2 :=' is a basic command or a part of one.';
    _lMsgErrorJednoSlovo :='Name of a command must be one word (without spaces)';
    _lZmazatPrikaz := 'Delete command?';
    _lPremenovaniePrikazu := 'Renaming command ';
    _lZadajMeno :='Enter the new name of the command:';
    _MsgErrorRovnakeMeno := 'The original and the new name are the same.';
    _MsgErrorUzExistuje := 'Can''t change name to the name of an existing command.';
    _lRozmeryCaption := 'Set room''s dimensions';
    _lRozmeryLBCaption := 'Room''s dimensions';
    _lRozmeryVyska :='Height';
    _lRozmerySirka :='Width';
    _lRozmeryDlzka :='Length';
    _lButtonNastav := 'Set';
    _lButtonNenastav := 'Cancel';
    _lMoveCaption := 'Click on the arrows';
    _lBStopCaption := 'Stop'#13#10'the program';
    _lLimitsCaption :='Karel''s restrictions';
    _lLimitsVykrocit :='Number of the bricks Karel can climb over';
    _lLimitsSpomalit :='Karel''s speed';
    _lZoomCaption :='Click on the arrows at the edge of the scroll bar';
    _lMsgErrorPresun2 := 'Bad coordinates after move command';
    _lMsgStop :='program stopped';
    _lMsgErrorKrok :='Karel does not have free space to step forwared.';
    _lMsgErrorPolozPriStene := 'Karel is standing in front of a wall, he has no space to put down a brick.';
    _lMsgErrorPolozVyska := 'Karel can''t place brick higher than is the height of the room.';
    _lMsgErrorZoberNietco :='There is no brick to take in front of Karel.';
    _lOznacCmd :='mark';
    _lOdznacCmd :='unmark';
    _lZnackaCmd :='marker';
    _lErrorMsgPrikazZly :='Bad command format';
    _lVysledokCnd := 'result';
    _lMsgErrorCnd := 'Problem with condition processing';
    _lResultCmd :='result';
    _lPravdaCmd :='true';
    _lNepravdaCmd :='false';
    _lPolozFCmd :='putc';
    _lYesButton :='&Yes';
    _lNoButton :='&No';
    _lCancelButton :='&Cancel';
    _lMsgUkoncenieProgramu :='Exit program';
    _lMsgRunError :='Error has occured while starting the program.';
    _lErrorMsgRuntime :='Runtime error.';
    _lMsgUkladanie :='Saving project';
    _lMsgNacitanie :='Loading project';
    _lMsgNeulozeny :='Unsaved project';
    _lSBZobrazZadanie := 'Show task';
    _lSBUpravZadanie:= 'Edit task';
    _lSBUpravPlochu:= 'Edit surface';
    _lMIAddLevel:= 'Add task';
    _lMIRemoveLevel:= 'Delete task';
    _lMIRenameLevel:= 'Rename task';
    _lLevelName:= 'Name of the task';
    _lWriteLevelName:= 'Enter the name of the task';
    _lLevelNameCannotBeEmpty:= 'Name of the task can''t be empty';
    _lCannotBeRemovedLastLevel:= 'Last level can''t be removed.';
    _lPozastavCmd:= 'pause';
    _lPokracujCmd:= 'continue';
    _lBPauseCaption:= 'Pause';
    _lBContinueCaption:= 'Continue';
    _lDebugWin:= 'Debugging';
    _lLastCmdDesc:= 'Last command';
    _lNextCmdDesc:= 'Next command';
    _lIterationDesc := 'Remaining iteration count';
    _lStenaDesc:= 'is wall';
    _lTehlaDesc:= 'is brick';
    _lZnackaDesc:= 'is marker';
    _lVolnoDesc:= 'is free';
    _lSBReset:= 'Refresh task';
    _lBStop:= 'Stop';
    _lBStep:= 'Next command';
    _lBContinue:= 'Continue';
    _lFPriamyRezim:= 'Direct mode';
end;

procedure setLang(lang: TLang);
begin
  case lang of
       lang_SK: setLangSK;
       lang_EN: setLangEN;
  else
	//Nemalo by nikdy nastat
    Raise Exception.Create('Internal Error: Unknown Language code');
  end;
  setUtilsLang();
end;

end.
