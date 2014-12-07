unit UDLimits;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, ComCtrls;

type
  TDLimitKarel = class(TForm)
    BNastav: TBitBtn;
    BNenastav: TBitBtn;
    EUp: TEdit;
    LVykrocit: TLabel;
    LSpomalit: TLabel;
    SBTimer: TScrollBar;
    BMinus: TBitBtn;
    BPlus: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BMinusClick(Sender: TObject);
    procedure BPlusClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses ULang;
{$R *.dfm}

procedure TDLimitKarel.FormCreate(Sender: TObject);
begin
  EUp.Text:='1';
  Caption:=_lLimitsCaption;
  LVykrocit.Caption:=_lLimitsVykrocit;
  LSpomalit.Caption:=_lLimitsSpomalit;
  BNastav.Caption:=_lButtonNastav;
  BNenastav.Caption:=_lButtonNenastav;
end;

procedure TDLimitKarel.BMinusClick(Sender: TObject);
begin
  if EUp.Text='1' then Exit;
  EUp.Text:=IntToStr(StrToInt(EUp.Text)-1);
end;

procedure TDLimitKarel.BPlusClick(Sender: TObject);
begin
  EUp.Text:=IntToStr(StrToInt(EUp.Text)+1);
end;

end.
