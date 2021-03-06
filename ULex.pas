unit ULex;

interface
uses Classes;
function DajLexemu(var Pos, Len : Integer; Text : TStrings) : string;
function DajSlovo(var Pos, Len : Integer; Text : TStrings) : string;
//funkcia vrati lexemu, kde sa nachadza pos a upravy pos na zac a len na dlzku lexemy

implementation
const Separators = [' ',';'];

function DajSlovo(var Pos, Len : Integer; Text : TStrings) : string;
var AR,Sum,Z,LP : Integer;
    S : string;
begin
  AR:=0;
  Sum:=0;
  Result:='';
  if Text.Count=0 then Exit;
  if Pos=0 then Pos:=1;

  while (Sum<Pos) and (AR<Text.Count) do
    begin
      Inc(AR);
      Sum:=Sum+Length(Text.Strings[AR-1])+1;
    end;
  if Sum<Pos then Exit; //pociatocna pozicia je vacsia ako dlzka textu...

  S:=Text.Strings[AR-1];
  Sum:=Sum-Length(S)- 1;
  if S='' then {prazdny riadok - koncim} Exit;
  LP:=Pos-Sum;
  {asi bude treba dec LP o jedno}


  while  (LP>1) and (S[LP]<>' ') do Dec(LP);
  if S[LP]=' ' then Inc(LP);
  Z:=LP;

  while (LP<=Length(S)) and (S[LP]<>' ') do Inc(LP);
  if LP<=Length(S) then Dec(LP);
  Result:=Copy(S,Z,LP-Z+1);
  Len:=Length(Result);
  Pos:=Z+Sum;
end;

function DajLexemu(var Pos, Len : Integer; Text : TStrings) : string;
var
    Sum,Stav,AR,LP : Integer; //cislo aktualneho riadku
    S,Res : string;
    Koniec : Boolean;
begin
  DajLexemu:='';
  if Text.Count=0 then Exit; //editor je uplne prazdny
  AR:=0;
  Sum:=0;

  while (Sum-1<Pos) and (AR<Text.Count) do
    begin
      Inc(AR);
      Sum:=Sum+Length(Text.Strings[AR-1])+1;//+1
    end;
  if Sum<Pos then Exit; //pociatocna pozicia je vacsia ako dlzka textu...

  S:=Text.Strings[AR-1];
  Sum:=Sum-Length(S)- 1;
  LP:=Pos-Sum;
  if LP<=0 then LP:=1;
  Res:='';

  Koniec:=False;
  Stav:=1;

  while not Koniec do
    begin
      case Stav of
          1 : begin
                if (LP>Length(Text.Strings[AR-1]))and
                   (AR=Text.Count) then {ziadna lexema} Koniec:=True;
                if (LP>Length(Text.Strings[AR-1])) then
                  begin  //treba prejst na dalsi riadok
                    Sum:=Sum+Length(Text.Strings[AR-1]) + 1;
                    Inc(AR);
                    LP:=1;
                  end
                else
                if Text.Strings[AR-1][LP]<>' ' then
                  begin
                    Stav:=2;
                    Res:=Text.Strings[AR-1][LP];
                  end;
              end;
          2 : if (LP>Length(Text.Strings[AR-1])) then Koniec:=True
              else
                if Text.Strings[AR-1][LP]=' ' then Koniec:=True
                else Res:=Res+Text.Strings[AR-1][LP];
      end;
      Inc(LP);
    end;
  Result:=Res;
  if Res='' then Exit;
  Pos:=Sum+LP-Length(Res)-1;
  Len:=Length(Res);
end;

end.
