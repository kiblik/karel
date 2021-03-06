unit UUtils;
interface
uses Graphics,Classes,Dialogs,Buttons;
type
  TBricks = array of array of array of TColor;
  TMarks = array of array of Boolean;
  T3DPoint = record
                X,Y,Z : Real;
              end;
  TCmd = class
           Lines : array of string;
           CaretPos : Integer;
    end;
  TOpakuj = record
              Pocet : Integer;
              Commands : string
            end;
  TPresun = record
              NX,NY : Integer;
            end;
  TKym = record
            Je : Boolean;
            Cond : string;
            Commands : string;
         end;
  TAk = record
          Je : Boolean;
          Cond : string;
          TrueCmd,FalseCmd : string;
        end;
  TCond = record
             Cmds : string;
          end;   
  TKarelLimit = record
                  Up : Integer;
                end;
  TColRect = record
             Points : array of T3DPoint;
             FgColor,BkColor : TColor
          end;
  TKarel = record
             Pos : TPoint;
             Limits : TKarelLimit;
             Orientation : Byte;
             Graphic : array[0..3] of array of TColRect;
           end;
  TLevel = record
             Name: String;
             RoomX,RoomY,RoomH : Integer;
             O : TPoint;
             Karel: TKarel;
             Zoom : Integer;
             Description: TStringList;
             Bricks : TBricks;
             Marks : TMarks;
             RequestBricks : TBricks;
             RequestMarks : TMarks;
             RequestKarel: TKarel;
             OrigBricks : TBricks;
             OrigMarks : TMarks;
             OrigKarel: TKarel;
           end;

  TCmdSet = set of Byte;
  TPolozF = record
              Color : TColor;
            end;
  TOColor = class
              Color : TColor;
            end;
  TColorStringList = class(TStringList)
    procedure AddColor(ColorName : string; Color : TColor);
   public
    destructor Destroy; override;
  end;

var    O,UX,UY,UZ : TPoint;
     BasicCmds,BasicCnds : TStringList;
     DefColors : TColorStringList;
     EndOfAppl : Boolean;
     ErrorMsg : string;
     Zoom : Integer;
     WasChanged : Boolean=False;
     BrickColor : TColor=clYellow;
     CondResult : Boolean=True;
     LastTakenColor : TColor=clYellow;

const DefO : TPoint = (X:0;Y:0);
      DefUX : TPoint = (X:10;Y:0);
      DefUZ : TPoint = (X:0;Y:5);
      DefUY : TPoint = (X:-5;Y:-5);
      DefRoomX =20;
      DefRoomY =10;
      DefRoomH =10;
      clNewCmd = clPurple;

      img_krok = 1;
      img_vlavo = 2;
      img_poloz = 3;
      img_zober = 4;

      Colors : array[0..15] of TColor =
       (clRed, clGreen, clYellow, clBlue, clWhite, clGray, clFuchsia, clTeal, clNavy, clMaroon, clLime, clOlive, clPurple, clSilver, clAqua, clBlack);
//      um_RefreshCmdList=wm_User+10;

procedure Konvertuj(Point3 : T3DPoint;var Point : TPoint);
procedure DrawLine(P1,P2 : T3DPoint; Canvas : TCanvas);
procedure DrawRect(P1,P2,P3,P4 : T3DPoint;Canvas : TCanvas);
procedure DrawTriangle(P1,P2,P3 : T3DPoint;Canvas : TCanvas);
procedure DrawNUhol(Pts : array of T3DPoint;X0,Y0,Z0:Integer;Canvas : TCanvas;const ZoomX : Integer=1;ZoomY : Integer=1;ZoomZ : Integer=1);
function MyMessageDlg(const Title : string; const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; DefButton : Integer; HelpCtx: Longint): Word;
function First(var Sentence : string) : string;
function Last(var Sentence : string) : string;
procedure UnSpace(var Sentence : string);
function Empty(Cmd : string) : Boolean;
procedure CenterText(Text : string;Canvas : TCanvas;var Rect : TRect);
procedure setUtilsLang();
implementation
uses ULang,SysUtils,StdCtrls;

procedure TColorStringList.AddColor(ColorName : string; Color : TColor);
var NColor : TOColor;
begin
  if IndexOf(ColorName)=-1 then
    begin
      NColor:=TOColor.Create;
      AddObject(ColorName,NColor)
    end
  else NColor:=Objects[IndexOf(ColorName)] as TOColor;
  NColor.Color:=Color;
end;

destructor TColorStringList.Destroy;
  var i:integer;
begin
  if(count > 0) then
    for i:=0 to Count-1 do
      Objects[i].Destroy;
  Clear;
end;

procedure CenterText(Text : string;Canvas : TCanvas;var Rect : TRect);
begin
  Rect.Left:=(Rect.Right-Rect.Left-Canvas.TextWidth(Text)) div 2 + Rect.Left;
  Rect.Right:=Rect.Left+Canvas.TextWidth(Text);
  Rect.Top:=(Rect.Bottom-Rect.Top-Canvas.TextHeight(Text)) div 2 + Rect.Top;
  Rect.Bottom:=Rect.Top+Canvas.TextHeight(Text);
end;

function MyMessageDlg(const Title : string; const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; DefButton : Integer; HelpCtx: Longint): Word;
var Cnt : Integer;
    Btn : TBitBtn;
    Lab : TLabel;
begin
  with CreateMessageDialog(Msg,DlgType,Buttons) do
    try
      Caption:=Title;
      HelpContext:=HelpCtx;
      for Cnt:=0 to ComponentCount-1 do
        begin
          if Components[Cnt] is TBitbtn then
            begin
              Btn:=TBitBtn(Components[Cnt]);
              Btn.Default :=Btn.ModalResult=DefButton;
              if Btn.Caption='&Yes' then Btn.Caption:=_lYesButton;
              if Btn.Caption='&No' then Btn.Caption:=_LNoButton;
              if Btn.Caption='Cancel' then Btn.Caption:=_lCancelButton;
              if Btn.Default then ActiveControl:=Btn;
            end;
          if Components[Cnt] is TLabel then
            begin
              Lab:=TLabel(Components[Cnt]);
              Lab.Font.Style:=[fsBold];
              Lab.Alignment:=taCenter;
              Lab.WordWrap:=True;
            end;
        end;
      Result:=ShowModal;
    finally
      Free;
    end;
end;

function Empty(Cmd : string) : Boolean;
begin
  while (Cmd<>'') and (Cmd[1]=' ') do Cmd:=Copy(Cmd,2,MaxInt);
  Result:=Cmd='';
end;
procedure Konvertuj(Point3 : T3DPoint;var Point : TPoint);
begin
  Point.X:=Round(Point3.X*UX.X+Point3.Y*UY.X)+O.X;
  Point.Y:=O.Y - Round(Point3.Z*UZ.Y+Point3.Y*UY.Y);
end;

procedure DrawNUhol(Pts : array of T3DPoint;X0,Y0,Z0 : Integer;Canvas : TCanvas;const ZoomX : Integer=1;ZoomY : Integer=1;ZoomZ : Integer=1);
var B : array of TPoint;
    I : Integer;
begin
  SetLength(B,Length(Pts));
  for I:=0 to Length(B)-1 do
    begin
      Pts[I].X:=Pts[I].X*ZoomX+X0;
      Pts[I].Y:=Pts[I].Y*ZoomY+Y0;
      Pts[I].Z:=Pts[I].Z*ZoomZ+Z0;
      Konvertuj(Pts[I],B[I]);
    end;
  Canvas.Polygon(B);
end;

procedure DrawRect(P1,P2,P3,P4 : T3DPoint;Canvas : TCanvas);
var B : array[1..4] of TPoint;
begin
  Konvertuj(P1,{%H-}B[1]);
  Konvertuj(P2,B[2]);
  Konvertuj(P3,B[3]);
  Konvertuj(P4,B[4]);
  Canvas.Polygon(B);
end;

procedure DrawTriangle(P1,P2,P3 : T3DPoint;Canvas : TCanvas);
var B : array[1..3] of TPoint;
begin
  Konvertuj(P1,{%H-}B[1]);
  Konvertuj(P2,B[2]);
  Konvertuj(P3,B[3]);
  Canvas.Polygon(B);
end;

procedure DrawLine(P1,P2 : T3DPoint; Canvas : TCanvas);
var NP1,NP2 : TPoint;
begin
  Konvertuj(P1,NP1{%H-});
  Konvertuj(P2,NP2{%H-});
  Canvas.MoveTo(NP1.X,NP1.Y);
  Canvas.LineTo(NP2.X,NP2.Y);
end;

function Last(var Sentence : string) : string;
var FW : string;
begin
  FW:='';
  while (Sentence<>'') and (Sentence[Length(Sentence)]<>' ') do
    begin
      FW:=Sentence[Length(Sentence)]+FW;
      Sentence:=Copy(Sentence,1,Length(Sentence)-1);
    end;
  Result:=FW;
  UnSpace(Sentence);
end;

function First(var Sentence : string) : string;
var FW : string;
begin
  FW:='';
  while (Length(Sentence)>0) and (Sentence[1]=' ')do Sentence:=Copy(Sentence,2,MaxInt);
  while (Length(Sentence)>0) and (Sentence[1]<>' ')do
    begin
      FW:=FW+Sentence[1];
      Sentence:=Copy(Sentence,2,MaxInt);
    end;
  while (Length(Sentence)>0) and (Sentence[1]=' ')do Sentence:=Copy(Sentence,2,MaxInt);
  First:=FW
end;

procedure UnSpace(var Sentence : string);
begin
  while Pos('  ',Sentence)>0 do
    begin
      Sentence:=Copy(Sentence,1,Pos('  ',Sentence)-1)+
                Copy(Sentence,Pos('  ',Sentence)+1,MaxInt);
    end;
  while (Length(Sentence)>0) and (Sentence[1]=' ') do
    Sentence:=Copy(Sentence,2,MaxInt);
  while (Length(Sentence)>0) and (Sentence[Length(Sentence)]=' ') do
    Sentence:=Copy(Sentence,1,Length(Sentence)-1);
end;

procedure setUtilsLang();
begin

  BasicCmds.Free;
  BasicCmds:=TStringList.Create;
  BasicCmds.Add(_lKrokCmd);
  BasicCmds.Add(_lPomalyCmd);
  BasicCmds.Add(_lRychloCmd);
  BasicCmds.Add(_lPolozCmd);
  BasicCmds.Add(_lZoberCmd);
  BasicCmds.Add(_lVlavoCmd);
  BasicCmds.Add(_lAkCmd);
  BasicCmds.Add(_lJeCmd);
  BasicCmds.Add(_lnieCmd);
  BasicCmds.Add(_ltakCmd);
  BasicCmds.Add(_linakCmd);
  BasicCmds.Add(_lAkEndCmd);
  BasicCmds.Add(_lOpakujCmd);
  BasicCmds.Add(_lKratCmd);
  BasicCmds.Add(_lOpakujEndCmd);
  BasicCmds.Add(_lkymCmd);
  BasicCmds.Add(_lrobCmd);
  BasicCmds.Add(_lKymEndCmd);
  BasicCmds.Add(_lPrikazCmd);
  BasicCmds.Add(_lPrikazEndCmd);
  BasicCmds.Add(_lzmazCmd);
  BasicCmds.Add(_lOznacCmd);
  BasicCmds.Add(_lOdznacCmd);
  BasicCmds.Add(_lPravdaCmd);
  BasicCmds.Add(_lNepravdaCmd);
  BasicCmds.Add(_lPodmienkaCmd);
  BasicCmds.Add(_lPodmienkaEndCmd);

  BasicCnds.Free;
  BasicCnds:=TStringList.Create;
  BasicCnds.Add(_lZnackaCmd);
  BasicCnds.Add(_ltehlaCmd);
  BasicCnds.Add(_lstenaCmd);
  BasicCnds.Add(_lvolnoCmd);
  BasicCnds.Add(_lnahodaCmd);
  BasicCnds.Add(_lZnackaCmd);
  BasicCnds.Add(_lVysledokCnd);
  BasicCnds.Add(_lResultCmd);

  EndOfAppl:=False;

end;

//var NColor : TOColor;
initialization
  DefColors:=TColorStringList.Create;
  Zoom:=3;
  WasChanged:=False;
  O:=DefO;
  UX.X:=Zoom*DefUX.X;
  UX.Y:=Zoom*DefUX.Y;
  UZ.X:=Zoom*DefUZ.X;
  UZ.Y:=Zoom*DefUZ.Y;
  UY.X:=Zoom*DefUY.X;
  UY.Y:=Zoom*DefUY.Y;

finalization
  BasicCmds.Free;
  BasicCnds.Free;
  DefColors.Free;
end.
