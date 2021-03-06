unit UMyEditor;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type TLexInfo = class (TObject)
       Color : TColor;
       Style : TFontStyles;
       constructor Create(AColor : TColor; AStyle : TFontStyles);
     end;
type
  TMyEditor = class(TMemo)
  private
    LKey : Char;
    LLineCount: Integer;
    Lexemas : TStringList;
    Dnu,Start,Kresli : Boolean;
    procedure ReKeyPress(Sender : TObject;var Key : Char);
    procedure REKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
    procedure ReMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure REMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    { Private declarations }
  protected
    { Protected declarations }
  public
    procedure REChange(Sender : TObject);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    procedure CreateWnd;override;
    procedure AddKey(Lex : string; AColor : TColor; AStyle : TFontStyles);
    procedure LexFound(var Lex : string); virtual;
    procedure RemoveLexema(Lex : string); virtual;
    procedure MakeAll; //nanovo urobi cely obsah!
    { Public declarations }
  published
    property Align;
    property Alignment;
    property Color;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    { Published declarations }
  end;

procedure Register;

implementation
uses ULex;
procedure Register;
begin
  RegisterComponents('Custom', [TMyEditor]);
end;

procedure TMyEditor.LexFound(var Lex : string);
begin
end;


procedure TMyEditor.ReMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  LKey:=#1;
end;

procedure TMyEditor.REMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Modified:=False;
end;


procedure TMyEditor.CreateWnd;
begin
  inherited CreateWnd;
  Lines.Clear
end;

constructor TMyEditor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Start:=False;
  Kresli:=True;
  SetParent(AOwner as TWinControl);
  WordWrap:=False;
  ScrollBars:=ssBoth;
  Lexemas:=TStringList.Create;
  Dnu:=False;
  ControlStyle:=ControlStyle+[csDesignInteractive];
  OnChange:=REChange;
  OnKeyPress:=REKeyPress;
  OnKeyDown:=REKeyDown;
  OnMouseMove:=REMouseMove;
  OnMouseDown:=REMouseDown;

  LKey:=#0;
  LLineCount:=0;
{  with DefAttributes do
    begin
      Color:=clWindowText;
      Height:=16;
      Style:=[];
    end;}
  SelLength:=0;


end;

destructor TMyEditor.Destroy;
var I : Integer;
begin
  for I:=1 to Lexemas.Count do
    Lexemas.Objects[I-1].Free;
  Lexemas.Free;

  inherited Destroy;
end;

procedure TMyEditor.ReKeyPress(Sender : TObject;var Key : Char);
begin
  if LKey=#0 then LKey:=Key;
end;

procedure TMyEditor.REKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
begin
 LKey:=#0;
 case Key of
   46 : LKey:=#83;
   8  : LKey:=#8;
   45 : if ssShift in Shift then LKey:=#1;
 end;
 Start:=True;
end;

procedure TMyEditor.RemoveLexema(Lex : string);
var I : Integer;
begin
  if Lex='' then
    begin
      for I:=0 to Lexemas.Count-1 do Lexemas.Objects[I].Free;
      Lexemas.Clear;
    end
  else
    if Lexemas.IndexOf(Lex)>-1 then
      begin
        Lexemas.Objects[Lexemas.IndexOf(Lex)].Free;
        Lexemas.Delete(Lexemas.IndexOf(Lex));
      end;
end;

procedure TMyEditor.AddKey(Lex : string; AColor : TColor; AStyle : TFontStyles);
var Obj : TLexInfo;
begin
  if Lexemas.IndexOf(Lex)= -1 then
    begin
      Obj:=TLexInfo.Create(AColor,AStyle);
      Lexemas.AddObject(Lex,Obj);
    end
  else
    begin
      Obj:=TLexInfo(Lexemas.Objects[Lexemas.IndexOf(Lex)]);
      Obj.Color:=AColor;
      Obj.Style:=AStyle;
    end;
  if Lines.Count>0 then MakeAll;
end;


{
procedure MakeLine(Od : Integer);
var D : Integer;
    Koniec : Boolean;
    Lex : string;
    Obj : TLexInfo;
begin
  Lex:=DajSlovo(Od,D,Lines);
  if Lex='' then Exit;
  repeat
    SelStart:=Od-1;
    SelLength:=D;
    if Lexemas.IndexOf(Lex)>-1 then
      begin
        Obj:=TLexInfo(Lexemas.Objects[Lexemas.IndexOf(Lex)]);
        SelAttributes.Color:=Obj.Color;
        SelAttributes.Style:=Obj.Style;
      end
    else
      begin
        SelAttributes.Color:=DefAttributes.Color;
        SelAttributes.Style:=DefAttributes.Style;
      end;
    Od:=Od+D;
    Lex:=DajSlovo(Od,D,Lines);
    Koniec:=Lex='';
  until Koniec;
end;}

procedure TMyEditor.MakeAll; //nanovo urobi cely obsah!
var OldColor   : TColor;
    OldStyle   : TFontStyles;
         Obj   : TLexInfo;
    Koniec     : Boolean;
    Z,D,OldSel : Integer;
    Lex : string;
begin
  OldSel:=SelStart;
//  OldColor:=DefAttributes.Color;
//  OldStyle:=DefAttributes.Style;

  Z:=1;
  Lex:=DajLexemu(Z,D,Lines);
  LexFound(Lex);

  if Lex='' then Exit;
  repeat
    SelStart:=Z-1;
    SelLength:=D;
    if Lexemas.IndexOf(Lex)>-1 then
      begin
        Obj:=TLexInfo(Lexemas.Objects[Lexemas.IndexOf(Lex)]);
//        SelAttributes.Color:=Obj.Color;
//        SelAttributes.Style:=Obj.Style;
      end
    else
      begin
//        SelAttributes.Color:=OldColor;
//        SelAttributes.Style:=OldStyle;
      end;
    Z:=Z+D;
    Lex:=DajLexemu(Z,D,Lines);
    LexFound(Lex);
    Koniec:=Lex='';
  until Koniec;
  SelStart:=OldSel;
end;

procedure TMyEditor.REChange;
var OldColor : TColor;
    OldStyle : TFontStyles;
         Obj : TLexInfo;

 procedure Pismeno(var Od,Dl : Integer);
 var      Lex : string;
 begin
   {toto bude fungovat len ked napisem pismeno (nie pri prechodoch cez riadky) }
   Lex:=DajSlovo(Od,Dl,Lines);
   if Lex='' then Exit;
   LexFound(Lex);
   SelStart:=Od-1;
   SelLength:=Dl;

   if Lexemas.IndexOf(Lex)>-1 then
     begin
       Obj:=TLexInfo(Lexemas.Objects[Lexemas.IndexOf(Lex)]);
//       SelAttributes.Color:=Obj.Color;
//       SelAttributes.Style:=Obj.Style;
     end
   else
     begin
//       SelAttributes.Color:=OldColor;
//       SelAttributes.Style:=OldStyle;
     end;
 end;

var A : Integer;
    Z,OldSel,D : Integer;
    OldHideSelection : Boolean;
begin
  Z:=SelStart;
  OldSel:=SelStart;
//  OldColor:=DefAttributes.Color;
//  OldStyle:=DefAttributes.Style;
  OldHideSelection:=HideSelection;
  HideSelection:=True;

    {treba urobit predchadzajucu a nasledovnu lexemu}
  {if Key=delete or enter - ak sa pri entery nezmeni pocet riadkov - tak sa no to treba vykaslat,
   inak treba urobit sucasny - prve slovo a predchadzajuci posledne slovo
   pri delete - ak sa nezmeni pocet riadkov tak sa to spravi ako obycajny klaves
   inak tiez :) }
  case LKey of
  ' ': begin {treba navyse kuknut predchadzajuceho}
          A:=Z-1;
          Pismeno(A,D);
          Pismeno(Z,D);
        end;
  #13 : if LLineCount<Lines.Count then
            begin
              A:=Z+1;
              Pismeno(Z,D);
              Pismeno(A,D);
            end;
  #83,#8 : begin
          A:=Z+1;
          Pismeno(Z,D);
          Pismeno(A,D);
        end;
  #1 : begin
         MakeAll;
       end;
  else Pismeno(Z,D);
  end;
  LKey:=#0;
  {Re.SelectAll;
  RE.DefAttributes.Color := clWindowText;
  Re.SelLength:=0;}
  SelStart:=OldSel;
  SelLength:=0;
//  SelAttributes.Color:=OldColor;
//  SelAttributes.Style:=OldStyle;
  LLineCount:=Lines.Count;
  HideSelection:=OldHideSelection;
end;


constructor TLexInfo.Create(AColor : TColor; AStyle : TFontStyles);
begin
  inherited Create;
  Color:=AColor;
  Style:=AStyle;
end;


end.