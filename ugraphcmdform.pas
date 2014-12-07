unit ugraphcmdform;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, Grids,UUtils, ExtCtrls;

type
  TGraphCmdForm = class(TForm)
    Img: TImage;
    procedure FormCreate(Sender: TObject);
  private
     CmdTop : Integer;
     OK : Boolean;
     procedure DrawPrikaz(Iter : Integer;Cmd : string;Left,Right : Integer);
    { Private declarations }
  public
    procedure DrawCmd(CmdName,Cmd : string);

    { Public declarations }
  end;



implementation
uses ULang;
const CmdWidth = 35;
      CmdHeight=25;

procedure TGraphCmdForm.DrawCmd(CmdName,Cmd : string);
begin
  CmdTop:=10;
  OK:=True;
  Caption:=CmdName;
  Img.Canvas.Pen.Width:=2;
  Img.Canvas.Font.Size:=10;
  Img.Canvas.Pen.Color:=clWhite;
  Img.Canvas.FillRect(Img.ClientRect);
  DrawPrikaz(0,Cmd,0,Img.ClientWidth);
end;
                         
{$R *.lfm}
procedure TGraphCmdForm.DrawPrikaz(Iter : Integer;Cmd : string;Left,Right : Integer);
var FW : string;
    
    Mid : Integer;
    LocalTop : Integer;
    Rect : TRect;
    Opakuj : TOpakuj;
    Kym : TKym;
    Ak : TAk;

begin
  Img.Canvas.Pen.Color:=Colors[Iter mod 16];
  Mid:=(Left+Right) div 2;
  while OK and (Cmd<>'') do
    begin
      FW:=First(Cmd);
      if FW=_lOpakujCmd then
        begin
          Opakuj:=GetOpakuj(Cmd,OK);
          if OK then
            begin
              LocalTop:=CmdTop;
              Rect.Left:=Mid-CmdWidth;
              Rect.Top:=CmdTop;
              Rect.Right:=Mid+CmdWidth;
              Rect.Bottom:=CmdTop+CmdHeight;
              Img.Canvas.Ellipse(Rect);
              CenterText(IntToStr(Opakuj.Pocet),Img.Canvas,Rect);
              Img.Canvas.TextRect(Rect,Rect.Left,Rect.Top,IntToStr(Opakuj.Pocet));
              Img.Canvas.MoveTo(Mid+CmdWidth,CmdTop+CmdHeight div 2);
              Img.Canvas.LineTo((Mid+Right) div 2,CmdTop+CmdHeight div 2);
              Img.Canvas.LineTo((Mid+Right) div 2,CmdTop+CmdHeight div 2 + 5);
              Inc(CmdTop,CmdHeight div 2 + 5);
              DrawPrikaz(Iter+1,Opakuj.Commands,Mid,Right);
              Img.Canvas.Pen.Color:=Colors[Iter mod 16];
              Img.Canvas.MoveTo((Mid+Right) div 2,CmdTop);
              Img.Canvas.LineTo(Mid,CmdTop);
              Img.Canvas.MoveTo(Mid,LocalTop+CmdHeight);
              Img.Canvas.LineTo(Mid,CmdTop+5);
              Img.Canvas.Brush.Color:=clBlack;
              Img.Canvas.Ellipse(Mid-3,CmdTop-3,Mid+3,CmdTop+3);
              Img.Canvas.Brush.Color:=clWhite;
              Inc(CmdTop,5);
            end;
        end
      else if FW=_lKymCmd then
        begin
          Kym:=GetKym(Cmd,OK);
          if OK then
            begin
              LocalTop:=CmdTop;
              Rect.Left:=Mid-CmdWidth;
              Rect.Top:=CmdTop;
              Rect.Right:=Mid+2*CmdWidth div 3;
              Rect.Bottom:=CmdTop+CmdHeight;
              Img.Canvas.Polyline([Point(Rect.Left,Rect.Top),
                              Point(Rect.Right,Rect.Top),
                              Point(Rect.Right + CmdWidth div 3,Rect.Top+ CmdHeight div 2),
                              Point(Rect.Right,Rect.Bottom),
                              Point(Rect.Left,Rect.Bottom),
                              Point(Rect.Left,Rect.Top)]);
              CenterText(Kym.Cond,Img.Canvas,Rect);
              Img.Canvas.TextRect(Rect,Rect.Left,Rect.Top,Kym.Cond);
              Rect.Left:=Mid+2*CmdWidth div 3;;
              Rect.Right:=Rect.Right+CmdWidth div 3;
              if Kym.Je then FW:='+'
                        else FW:='-';
              CenterText(FW,Img.Canvas,Rect);
              Img.Canvas.TextRect(Rect,Rect.Left,Rect.Top,FW);
              Img.Canvas.MoveTo(Mid+CmdWidth,CmdTop+CmdHeight div 2);
              Img.Canvas.LineTo((Mid+Right) div 2,CmdTop+CmdHeight div 2);
              Img.Canvas.LineTo((Mid + Right) div 2,CmdTop+CmdHeight div 2 +5);
              Inc(CmdTop,CmdHeight div 2 +5);
              
              DrawPrikaz(Iter+1,Kym.Commands,Mid,Right);
              Img.Canvas.Pen.Color:=Colors[Iter mod 16];

              Img.Canvas.MoveTo((Mid+Right) div 2,CmdTop);
              Img.Canvas.LineTo(Mid,CmdTop);
              Img.Canvas.MoveTo(Mid,LocalTop+CmdHeight);
              Img.Canvas.LineTo(Mid,CmdTop+5);
              Img.Canvas.Brush.Color:=clBlack;
              Img.Canvas.Ellipse(Mid-3,CmdTop-3,Mid+3,CmdTop+3);
              Img.Canvas.Brush.Color:=clWhite;
            end;
        end
      else if FW=_lAkCmd then
        begin
          Ak:=GetAk(Cmd,OK);
          if OK then
            begin

              Rect.Left:=Mid-CmdWidth;
              Rect.Top:=CmdTop;
              Rect.Right:=Mid+CmdWidth;
              Rect.Bottom:=CmdTop+CmdHeight*2;
              Img.Canvas.Polyline([Point(Mid,Rect.Top),
                                   Point(Rect.Right,CmdTop+CmdHeight),
                                   Point(Mid,Rect.Bottom),
                                   Point(Rect.Left,CmdTop+CmdHeight),
                                   Point(Mid,Rect.Top)]);
              CenterText(Ak.Cond,Img.Canvas,Rect);
              Img.Canvas.TextRect(Rect,Rect.Left,Rect.Top,Ak.Cond);
              LocalTop:=CmdTop;
              Rect.Left:=Mid-CmdWidth;
              Rect.Top:=CmdTop;
              Rect.Right:=Mid+CmdWidth;
              Rect.Bottom:=CmdTop+CmdHeight;
              Img.Canvas.Font.Style:=[];
              Img.Canvas.Font.Size:=12;
              if Ak.TrueCmd<>'' then
                begin
                  Img.Canvas.TextOut(Rect.Right,CmdTop+CmdHeight-Img.Canvas.TextHeight('+'),'+');
                  Img.Canvas.Font.Style:=[];
                  Img.Canvas.Font.Size:=10;
                  Img.Canvas.MoveTo(Rect.Right,Rect.Bottom);
                  Img.Canvas.LineTo((Mid+Right) div 2,Rect.Bottom);
                  Img.Canvas.LineTo((Mid+Right) div 2,Rect.Bottom+5);
                  CmdTop:=Rect.Bottom+5;
                  DrawPrikaz(Iter+1,Ak.TrueCmd,Mid,Right);
                  Img.Canvas.Pen.Color:=Colors[Iter mod 16];
                  Img.Canvas.LineTo(Mid,CmdTop);
                  LocalTop:=CmdTop;
                end;
              if Ak.FalseCmd<>'' then
                begin
                  CmdTop:=Rect.Top;
                  Img.Canvas.TextOut(Rect.Left-2*Img.Canvas.TextWidth('-'),CmdTop+CmdHeight-Img.Canvas.TextHeight('+'),'-');
                  Img.Canvas.Font.Style:=[];
                  Img.Canvas.Font.Size:=10;
                  Img.Canvas.MoveTo(Rect.Left,Rect.Bottom);
                  Img.Canvas.LineTo((Mid+Left) div 2,Rect.Bottom);
                  Img.Canvas.LineTo((Mid+Left) div 2,Rect.Bottom+5);
                  CmdTop:=Rect.Bottom+5;
                  DrawPrikaz(Iter+1,Ak.FalseCmd,Left,Mid);
                  Img.Canvas.Pen.Color:=Colors[Iter mod 16];
                  Img.Canvas.LineTo(Mid,CmdTop);
                end;
              if LocalTop>CmdTop then CmdTop:=LocalTop;
              Img.Canvas.MoveTo(Mid,Rect.Bottom+CmdHeight);
              Img.Canvas.LineTo(Mid,CmdTop+5);
              Inc(CmdTop,5);
            end;
        end
      else
        begin
          Img.Canvas.MoveTo(Mid,CmdTop);
          Img.Canvas.LineTo(Mid,CmdTop+5);
          Inc(CmdTop,5);
          Rect.Left:=Mid-CmdWidth;
          Rect.Top:=CmdTop;
          Rect.Right:=Mid+CmdWidth;
          Rect.Bottom:=CmdTop+CmdHeight;
          Img.Canvas.Rectangle(Rect);
          Rect.Left:=Rect.Left+1;
          Rect.Top:=Rect.Top+1;
          Rect.Right:=Rect.Right-1;
          Rect.Bottom:=Rect.Bottom-1;
          CenterText(FW,Img.Canvas,Rect);
          Img.Canvas.TextRect(Rect,Rect.Left,Rect.Top,FW);
          Img.Canvas.MoveTo(Mid,CmdTop+CmdHeight);
          Img.Canvas.LineTo(Mid,CmdTop+CmdHeight+5);
          Inc(CmdTop,CmdHeight+5);
        end;
    end;

end;


procedure TGraphCmdForm.FormCreate(Sender: TObject);
begin
  Img.Left:=0;
  Img.Top:=0;
  Img.Width:=ClientWidth;
  Img.Height:=ClientHeight;
  Img.Canvas.FillRect(Img.ClientRect);
  CmdTop:=0;
end;

end.
