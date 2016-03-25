unit UDMiestnost;

interface

uses LCLIntf, LCLType, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ComCtrls;

type
  TDMiestnost = class(TForm)
    GroupBox1: TGroupBox;
    LVyska: TLabel;
    LSirka: TLabel;
    LDlzka: TLabel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    BNastav: TBitBtn;
    BNenastav: TBitBtn;
    UDVyska: TUpDown;
    UDDlzka: TUpDown;
    UDSirka: TUpDown;
    EVyska: TEdit;
    EDlzka: TEdit;
    ESirka: TEdit;
    procedure UDVyskaClick(Sender: TObject; {%H-}Button: TUDBtnType);
    procedure UDDlzkaClick(Sender: TObject; {%H-}Button: TUDBtnType);
    procedure UDSirkaClick(Sender: TObject; {%H-}Button: TUDBtnType);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation
uses ULang;
{$R *.lfm}

procedure TDMiestnost.UDVyskaClick(Sender: TObject; Button: TUDBtnType);
begin
  EVyska.Text:=IntToStr(UDVyska.Position);
end;

procedure TDMiestnost.UDDlzkaClick(Sender: TObject; Button: TUDBtnType);
begin
  EDlzka.Text:=IntToStr(UDDlzka.Position);
end;

procedure TDMiestnost.UDSirkaClick(Sender: TObject; Button: TUDBtnType);
begin
  ESirka.Text:=IntToStr(UDSirka.Position);
end;

procedure TDMiestnost.FormCreate(Sender: TObject);
begin
  Caption:=_lRozmeryCaption;
  GroupBox1.Caption:=_lRozmeryLBCaption;
  LDlzka.Caption:=_lRozmeryDlzka;
  LSirka.Caption:=_lRozmerySirka;
  LVyska.Caption:=_lRozmeryVyska;
  BNastav.Caption:=_lButtonNastav;
  BNenastav.Caption:=_lButtonNenastav;
end;

end.

