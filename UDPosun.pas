unit UDPosun;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TDRoomMove = class(TForm)
    BRight: TBitBtn;
    BUp: TBitBtn;
    BDown: TBitBtn;
    BLeft: TBitBtn;
    BOK: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BOKClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation
uses ULang;
{$R *.dfm}

procedure TDRoomMove.FormCreate(Sender: TObject);
var Rgn : HRgn;
begin
  Width:=110;

  Caption:=_lMoveCaption;
  BLeft.Left:=0;
  BLeft.Top:=(ClientHeight-BLeft.Height) div 2;
  BRight.Top:=BLeft.Top;
  BRight.Left:=(ClientWidth-BRight.Width);
  BUp.Top:=0;
  BUp.Left:=(ClientWidth-BUp.Width) div 2;
  BDown.Left:=BUp.Left;
  BDown.Top:=ClientHeight-BUp.Height;
  BOK.Left:=(ClientWidth-BOK.Width) div 2;
  BOK.Top:=(ClientHeight-BOK.Height) div 2;
  BOK.Default:=True;
  //BorderStyle:=bsNone;
  //Rgn:=CreateEllipticRgn(0,0,Width,Height);
  //SetWindowRgn(Handle,Rgn,True);

end;

procedure TDRoomMove.BOKClick(Sender: TObject);
begin
  Close
end;

procedure TDRoomMove.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#27 then Close
end;

end.
