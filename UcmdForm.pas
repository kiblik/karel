unit UcmdForm;

interface

uses
  LCLIntf, LCLType, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Menus, UGraphCmdForm;

type
  TCmdForm = class(TForm)
    CmdList: TListBox;

    BNew: TSpeedButton;
    BDelete: TSpeedButton;
    BRename: TSpeedButton;
    IL: TImageList;
    BGrapCmd: TBitBtn;
    HLEdit: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure BNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure HLEditChange(Sender: TObject);
    procedure HLEditKeyPress(Sender: TObject; var Key: Char);
    procedure CmdListClick(Sender: TObject);
    procedure BDeleteClick(Sender: TObject);
    procedure BRenameClick(Sender: TObject);
    procedure CmdListDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure BGrapCmdClick(Sender: TObject);
  private
    EOL : Boolean;
    OldChange : TNotifyEvent;
    OldKeyPressed : TKeyPressEvent;
    function GetLine : Integer;
//    function CheckCmd(Cmd : array of string) : Boolean;
    { Private declarations }
  public
    LastItem : Integer;
    GraphCmdForm : TGraphCmdForm;
 //   HLEdit: TMemo;
    procedure ResetLexemas;

    { Public declarations }
  end;

var CmdForm: TCmdForm;

implementation
uses UUtils,ULang;
{$R *.lfm}
(*
function TCmdForm.CheckCmd(Cmd : array of string):Boolean;
  function PrikazOK(var S:string) : Boolean;forward;
  function CmdOK (S : string) : Boolean;
  var FCmd : string;
  begin
    Result:=True;
    FCmd:=First(S);
    if FCmd='prikaz' then Result:=PrikazOK(S);
    if FCmd='opakuj' then Result:=OpakujOK(S);
    if FCmd='ak' then Result:=AkOK(S);
    if FCmd='kym' then Result:=KymOK(S);
  end;
  function PrikazOK(var S:string) : Boolean;
  begin
    First(S);
    Last(S);
    Result:=CmdOK(S);
  end;
  function OpakujOK(var S:string) : Boolean;
  var Pom : string;
  begin
    Result:=True;
    Pom:=First(S);
    while Result and (Pom<>'*opakuj') do

  end;

var S : string;
    I : Integer;
begin
  Result:=False;
  S:='';
  for I:=0 to Length(Cmd)-1 do S:=S+' '+Cmd;
  Unspace(S);
  Result:=CmdOK(S);
end;
*)

procedure TCmdForm.FormCreate(Sender: TObject);
begin
  Caption:=_lMenuSlovnik;
{  HLEdit:=TMemo.Create(self);//Tmyeditor
  HLEdit.Parent:=self;
  HLEdit.Name:='memo';}
  HLEdit.Left:=125;
  HLEdit.Top:=52;
  HLEdit.Width:=420;
  HLEdit.Height:=333;
  HLEdit.Font.Size:=12;
  HLEdit.Font.Name:='Courier New';
  LastItem:=-1;
  OldChange:=HlEdit.OnChange;
  OldKeyPressed:=HlEdit.OnKeyPress;
 // HlEdit.OnChange:=HlEditChange;
 // HlEdit.OnKeyPress:=HLEditKeyPress;
  HlEdit.Clear;

{  for I:=0 to BasicCmds.Count-1 do
    HlEdit.AddKey(BasicCmds[I],clRed,[]);

  for I:=0 to BasicCnds.Count-1 do
    HlEdit.AddKey(BasicCnds[I],clGreen,[]);}
  BNew.Caption:=_lBNewCaption;
  BDelete.Caption:=_lBDeleteCaption;
  BRename.Caption:=_lBRenameCaption;
  BDelete.Glyph.TransparentColor:=clWhite;
  BDelete.Glyph.Transparent:=True;
  DoubleBuffered:=True;
  GraphCmdForm:=TGraphCmdForm.Create(self);
end;

procedure TCmdForm.ResetLexemas;
begin
{  HlEdit.RemoveLexema('');
  for I:=0 to BasicCmds.Count-1 do
    HlEdit.AddKey(BasicCmds[I],clRed,[]);

  for I:=0 to BasicCnds.Count-1 do
    HlEdit.AddKey(BasicCnds[I],clGreen,[]);}

end;

procedure TCmdForm.BNewClick(Sender: TObject);
var NName : string = '';
    NCmd,OCmd : TCmd;
    I : Integer;
begin
  if not InputQuery(_lNovyPrikaz,_lZadajMeno,NName) then Exit;
  if Pos(' ',NName)>0 then
    begin
      MessageDlg(_lMsgErrorJednoSlovo,mtError,[mbOK],0);
      Exit
    end;
  if (BasicCmds.IndexOf(NName)<>-1) or (BasicCnds.IndexOf(NName)<>-1) then
    begin
      MessageDlg(NName+_lMsgErrorRezSlovo1+NName+_lMsgErrorRezSlovo2,mtError,[mbOK],0);
      Exit
    end;
  if (NName='')or(Pos(' ',NName)>0) then
    begin
      MessageDlg(_lMsgErrorJednoSlovo,mtError,[mbOK],0);
      Exit
   end;

  if LastItem<>-1 then
    begin
      OCmd:=CmdList.Items.Objects[LastItem] as TCmd;
      SetLength(OCmd.Lines,HLEdit.Lines.Count);
      for I:=0 to HLedit.Lines.Count-1 do
        OCmd.Lines[I]:=HLedit.Lines[I];
      OCmd.CaretPos:=HlEdit.SelStart;
    end;
  HlEdit.Clear;
  if CmdList.Items.IndexOf(NName)=-1 then
    begin
      NCmd := TCmd.Create;
      NCmd.Lines:=nil;
      CmdList.AddItem(NName,NCmd);
      SetLength(NCmd.Lines,3);
      NCmd.Lines[0]:=_lPrikazCmd+' '+NName;
      NCmd.Lines[1]:='  ';
      NCmd.Lines[2]:=_lPrikazEndCmd;
      for I:=0 to Length(NCmd.Lines)-1 do
        HlEdit.Lines.Add(NCmd.Lines[I]);
      HlEdit.SelStart:=3+Length(NCmd.Lines[0]);
//      HlEdit.MakeAll;
//      PostMessage(Parent.Handle,um_RefreshCmdList,0,0);
    end
  else
    begin
      NCmd:=CmdList.Items.Objects[CmdList.Items.IndexOf(NName)] as TCmd;
      for I:=0 to Length(NCmd.Lines)-1 do
        HlEdit.Lines.Add(NCmd.Lines[I]);
      HlEdit.SelStart:=NCmd.CaretPos;
    end;
  CmdList.ItemIndex:=CmdList.Items.IndexOf(NName);
  LastItem:=CmdList.ItemIndex;
  HlEdit.Enabled:=True;
  HlEdit.SetFocus;
  WasChanged:=True;
//  HlEdit.AddKey(NName,clNewCmd,[]);
  Caption:=_lPrikazCmd+' '+NName;
end;

procedure TCmdForm.FormClose(Sender: TObject; var Action: TCloseAction);
var I : Integer;
begin
  for I:=0 to CmdList.Count-1 do CmdList.Items.Objects[I].Free;
  GraphCmdForm.Free;
end;

procedure TCmdForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var I : Integer;
    Cmd : TCmd;
begin
  CanClose:=EndOfAppl;
  if not EndOfAppl then Hide;
  if CmdList.ItemIndex=-1 then Exit;
  Cmd:=CmdList.Items.Objects[CmdList.ItemIndex] as TCmd;
  SetLength(Cmd.Lines,HlEdit.Lines.Count);
  for I:=0 to HlEdit.Lines.Count-1 do
    Cmd.Lines[I]:=HlEdit.Lines[I];
end;

function TCmdForm.GetLine:Integer;
var Sum,AL : Integer;
begin
  AL:=0;
  Sum:=0;
  while Sum<HlEdit.SelStart do
    begin
      Sum:=Sum+Length(HlEdit.Lines[AL])+2;
      Inc(AL)
    end;
  Result:=AL;
end;

procedure TCmdForm.HLEditChange(Sender: TObject);
var SC,AL,I : Integer;
    S : string;
begin
  if EOL then
    begin
      EOL:=False;
      AL:=GetLine;
      SC:=1;
      while (SC<Length(HLEdit.Lines[AL-1])) and (HLedit.Lines[AL-1][SC]=' ') do Inc(SC);
      S:='';
      for I:=1 to SC-1 do S:=S+' ';
      HlEdit.Lines[AL]:=S+HlEdit.Lines[AL];
    end;
  OldChange(Sender);
  WasChanged:=True;
end;

procedure TCmdForm.HLEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    begin
      EOL:=True;
      HLEditChange(sender)
    end;
  OldKeyPressed(Sender,Key);
  WasChanged:=True;          
end;

procedure TCmdForm.CmdListClick(Sender: TObject);
var I : Integer;
    Cmd : TCmd;
begin
  if (LastItem=CmdList.ItemIndex) or (LastItem=-1) then Exit;
  Cmd:=CmdList.Items.Objects[LastItem] as TCmd;
  SetLength(Cmd.Lines,HlEdit.Lines.Count);
  for I:=0 to HlEdit.Lines.Count-1 do
    Cmd.Lines[I]:=HlEdit.Lines[I];
//  showmessage('caret');
  Cmd.CaretPos:=HlEdit.SelStart;
  HlEdit.Clear;
  if CmdList.ItemIndex=-1 then
    begin
      HlEdit.Enabled:=False;
      Caption:='';
      Exit
    end;
  Cmd:=CmdList.Items.Objects[CmdList.ItemIndex] as TCmd;
  for I:=0 to Length(Cmd.Lines)-1 do
    HlEdit.Lines.Add(Cmd.Lines[I]);
//  HlEdit.MakeAll;
  HlEdit.SelStart:=Cmd.CaretPos;
  LastItem:=CmdList.ItemIndex;
  HlEdit.SetFocus;
  Caption:=_lPrikazCmd+' '+CmdList.Items[CmdList.ItemIndex];
end;

procedure TCmdForm.BDeleteClick(Sender: TObject);
var II : Integer;
    Cmd : TCmd;
begin
  II:=CmdList.ItemIndex;
  if II=-1 then Exit;
  if MessageDlg(_lZmazatPrikaz+' "'+CmdList.Items[II]+'"?',mtConfirmation,[mbYes,mbNo],0)<>mrYes then Exit;
//  HlEdit.RemoveLexema(CmdList.Items[II]);
  CmdList.Items.Objects[II].Free;
  CmdList.Items.Delete(II);
  WasChanged:=True;
  HlEdit.Clear;
  Dec(II);
  if (II=-1)and(CmdList.Count=0) then
    begin
      LastItem:=-1;
      HlEdit.Enabled:=False;
      Caption:='';
    end
  else
    begin
      if II=-1 then II:=0;
      CmdList.ItemIndex:=II;
      LastItem:=II;
      Cmd:=CmdList.Items.Objects[II] as TCmd;
      for II:=0 to Length(Cmd.Lines)-1 do
        HlEdit.Lines.Add(Cmd.Lines[II]);
//      HlEdit.MakeAll;
      Caption:=CmdList.Items[CmdList.ItemIndex];
      HlEdit.SelStart:=Cmd.CaretPos;
    end;
end;

procedure TCmdForm.BRenameClick(Sender: TObject);
var NName : string = '';
    OName: string;
       CR : Integer;
     Cmd : TCmd;
begin
  if CmdList.ItemIndex=-1 then Exit;
  OName:=CmdList.Items[CmdList.ItemIndex];
  if not InputQuery(_lPremenovaniePrikazu+OName,_lZadajMeno,NName) then Exit;
  if NName=OName then
    begin
      MessageDlg(_MsgErrorRovnakeMeno,mtInformation,[mbOK],0);
      Exit
    end;
  if (BasicCmds.IndexOf(NName)<>-1) or (BasicCnds.IndexOf(NName)<>-1) then
    begin
      MessageDlg(NName+_lMsgErrorRezSlovo1+NName+_lMsgErrorRezSlovo1,mtError,[mbOK],0);
      Exit
    end;
  if (NName='')or(Pos(' ',NName)>0) then
    begin
      MessageDlg(_lMsgErrorJednoSlovo,mtError,[mbOK],0);
      Exit
   end;
  if CmdList.Items.IndexOf(NName)<>-1 then
    begin
      MessageDlg(_MsgErrorUzExistuje,mtError,[mbOK],0);
      Exit
    end;
  CmdList.Items[CmdList.ItemIndex]:=NName;
  Cmd:=CmdList.Items.Objects[CmdList.ItemIndex] as TCmd;
{  HlEdit.RemoveLexema(OName);
  HlEdit.AddKey(NName,clNewCmd,[]);}
  {ulozime obsah prikazu}
  SetLength(Cmd.Lines,HlEdit.Lines.Count);
  for CR:=0 to HlEdit.Lines.Count-1 do
    Cmd.Lines[CR]:=HlEdit.Lines[CR];

  CR:=0;

  while (CR>-1) and (CR<Length(Cmd.Lines)) do
    if Empty(Cmd.Lines[CR]) then Inc(CR)
    else
      begin
        if Pos(OName,Cmd.Lines[CR])<>0 then
          Cmd.Lines[CR]:=Copy(Cmd.Lines[CR],1,Pos(OName,Cmd.Lines[CR])-1)+NName+
                         Copy(Cmd.Lines[CR],Pos(OName,Cmd.Lines[CR])+Length(OName),MaxInt);
          HlEdit.Lines[CR]:=Cmd.Lines[CR];
//          HlEdit.MakeAll;
        CR:=-1;
      end;
  WasChanged:=True;
  Caption:=_lPrikazCmd+' '+NName;
end;

procedure TCmdForm.CmdListDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var Flags : Longint = 0;
    MyRect : TRect;
    OldBK,oldFg : TColor;
begin
  OldBk:=CmdList.Canvas.Brush.Color;
  OldFg:=CmdList.Canvas.Pen.Color;
  CmdList.Canvas.Pen.Color:=clWhite;
  CmdList.Canvas.Pen.Style:=psSolid;
  CmdList.Canvas.Brush.Color:=clWhite;
  CmdList.Canvas.FillRect(Rect);

  CmdList.Canvas.Pen.Color:=OldFg;;
  CmdList.Canvas.Brush.Color:=OldBk;

  MyRect:=Rect;
  Dec(MyRect.Right,10);
  CmdList.Canvas.FillRect(MyRect);
  if Index<CmdList.Count then
    begin
//      Flags:=DrawTextBiDiModeFlags(DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX);
      DrawText(CmdList.Canvas.Handle,PChar(CmdList.Items[Index]),Length(CmdList.Items[Index]),Rect,Flags);
    end;

end;

procedure TCmdForm.BGrapCmdClick(Sender: TObject);
var Cmd : TCmd;
    OK : Boolean = false;
    I : Integer;
begin
  if CmdList.ItemIndex=-1 then Exit;

  Cmd:=CmdList.Items.Objects[CmdList.ItemIndex] as TCmd;
  SetLength(Cmd.Lines,HlEdit.Lines.Count);
  for I:=0 to HlEdit.Lines.Count-1 do
    Cmd.Lines[I]:=HlEdit.Lines[I];

  with GraphCmdForm do
    begin
      Show;
      DrawCmd(CmdList.Items[CmdList.ItemIndex],GetPrikaz('',Cmd.Lines,OK));
    end;
end;

end.

