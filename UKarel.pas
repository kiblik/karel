unit UKarel;

//nejdu parametre - padne na deleteproject - treba dat if
//obcas padne na sipke dole v command line
interface

uses
  LCLIntf, LCLType, SysUtils, Variants, Classes,
  Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UUtils, Menus, UcmdForm, UStack, ComCtrls,
  Buttons, UDStop, FileUtil, UDebugWin, UDirect;

const
  version = '2.99';

type

  { TForm1 }

  TForm1 = class(TForm)
    EInput: TEdit;
    Img: TImage;
    LBLevelList: TListBox;
    Jazyk1: TMenuItem;
    LEng1: TMenuItem;
    LSk1: TMenuItem;
    MIAddLevel: TMenuItem;
    MIRemoveLevel: TMenuItem;
    MIRenameLevel: TMenuItem;
    MLevelDescription: TMemo;
    PMLevelEdit: TPopupMenu;
    SBRequest: TSpeedButton;
    SBReset: TSpeedButton;
    Timer1: TTimer;
    ILMainMenu: TImageList;

    Rozmerymiestnosti1: TMenuItem;
    ObmedzenieKarla1: TMenuItem;
    Lupa1: TMenuItem;
    MainMenu: TMainMenu;
    Subor1: TMenuItem;
    Novyprojekt1: TMenuItem;
    Otvoritprojekt1: TMenuItem;
    Ulozitprojekt1: TMenuItem;
    Nastavenia1: TMenuItem;
    Slovnik1: TMenuItem;
    Posunmiestnosti1: TMenuItem;
    ToolBar1: TToolBar;
    TBNew: TToolButton;
    TBOpen: TToolButton;
    TBSave: TToolButton;
    ToolButton2: TToolButton;
    TBResize: TToolButton;
    TBMove: TToolButton;
    TBKarelLimit: TToolButton;
    TBZoom: TToolButton;
    ToolButton7: TToolButton;
    TBCommands: TToolButton;
    MIKoniec: TMenuItem;
    MHistory: TMemo;
    TBCmdList: TToolButton;
    N1: TMenuItem;
    LVersion: TLabel;
    procedure LBLevelListClick(Sender: TObject);
    procedure LBLevelListMouseDown(Sender: TObject; Button: TMouseButton;
      {%H-}Shift: TShiftState; X, Y: Integer);
    procedure LEng1Click(Sender: TObject);
    procedure LSk1Click(Sender: TObject);
    procedure MIAddLevelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EInputKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var {%H-}Action: TCloseAction);
    procedure MIRemoveLevelClick(Sender: TObject);
    procedure MIRenameLevelClick(Sender: TObject);
    procedure MLevelDescriptionKeyUp(Sender: TObject; var {%H-}Key: Word;
      {%H-}Shift: TShiftState);
    procedure SBRequestClick(Sender: TObject);
    procedure SBResetClick(Sender: TObject);
    procedure Slovnik1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure EInputKeyDown(Sender: TObject; var Key: word; {%H-}Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure BStopClick(Sender: TObject);
    procedure BPauseClick(Sender: TObject);
    procedure BStepClick(Sender: TObject);
    procedure BContinueClick(Sender: TObject);
    procedure BDebugCloseWrapper(Sender: TObject; var {%H-}CloseAction: TCloseAction);
    procedure Rozmerymiestnosti1Click(Sender: TObject);
    procedure Posunmiestnosti1Click(Sender: TObject);
    procedure ObmedzenieKarla1Click(Sender: TObject);
    procedure Lupa1Click(Sender: TObject);
    procedure Novyprojekt1Click(Sender: TObject);
    procedure MIKoniecClick(Sender: TObject);
    procedure OtvorPojektClick(Sender: TObject);
    procedure SaveProjectClick(Sender: TObject);
    procedure TBCmdListClick(Sender: TObject);
    procedure Otvoritprojekt1Click(Sender: TObject);
    procedure Ulozitprojekt1Click(Sender: TObject);

  private
    Levels: array of TLevel;
    LevelID: integer;
    Bricks: TBricks;
    Marks: TMarks;
    RequestBricks: TBricks;
    RequestMarks: TMarks;
    OrigBricks: TBricks;
    OrigMarks: TMarks;
    Karel: TKarel;
    RequestKarel: TKarel;
    OrigKarel: TKarel;
    RoomX, RoomY, RoomH: integer;
    //  CmdForm: TCmdForm;
    Stack: TStack;
    ELine: integer;
    DStop: TDStop;
    DDebugWin: TDDebugWin;
    ShowGraphic: boolean;
    LHistory: array of string;
    admin: boolean;
    editingRequest: boolean;
    Pause: boolean;
    Iteracia: integer;
    DirectForm: TDirectForm;

    procedure DrawAxis;
    procedure ReDrawAll(const FromY: integer = 0);
    procedure DrawColumn(X, Y: integer);
    procedure DrawKarel(X, Y, Z: integer);
    procedure RunCommand(Cmd: string);
    procedure CmdKrok(Sender: TObject = nil);
    procedure CmdPoloz(var OK: boolean);
    procedure CmdZober(var OK: boolean);
    procedure CmdVlavo(Sender: TObject = nil);
    procedure CmdZmaz;
    procedure CmdPresun(NX, NY: integer);
    function CmdCond(Condition: string; var OK: boolean): boolean;
    procedure CmdStoj;
    procedure CmdPomaly;
    procedure CmdRychlo;
    procedure CmdOznac(Sender: TObject = nil);
    procedure CmdOdznac(Sender: TObject = nil);
    procedure CmdPozastav;
    procedure CmdPokracuj;
    procedure CmdPolozF(Info: TPolozF; var OK: boolean);
    procedure BeginProgram;
    procedure EndProgram;
    procedure DeleteProject;
    procedure ReadKarelPts;
    function JeVolno: boolean;
    function JeStena: boolean;
    procedure ReadKarelIni;
    procedure saveLevel;
    procedure loadlevel(levelnumber:integer);
    procedure startAdmin;
    procedure wrapperpoloz(Sender: TObject);
    procedure wrapperzober(Sender: TObject);
    procedure reloadLang();
  public
    procedure RoomMoveClick(Sender: TObject);
    procedure ZoomChange(Sender: TObject);
    procedure otvor(filename: string);
    { Public declarations }
  end;


implementation

{$R *.lfm}
uses UDMiestnost, UDPosun, UDLimits, UDZoom, ULang, Ui18n;

procedure TForm1.reloadLang();
begin
  Subor1.Caption := _lMenuSubor;
  NovyProjekt1.Caption := _lMenuNovyProjekt;
  OtvoritProjekt1.Caption := _lMenuOtvoritProjekt;
  UlozitProjekt1.Caption := _lMenuUlozitProjekt;
  Nastavenia1.Caption := _lMenuNastavenia;
  RozmeryMiestnosti1.Caption := _lMenuRozmeryMiestnosti;
  PosunMiestnosti1.Caption := _lMenuPosunMiestnosti;
  ObmedzenieKarla1.Caption := _lMenuObmedzenieKarla;
  Lupa1.Caption := _lMenuLupa;
  Slovnik1.Caption := _lMenuSlovnik;
  MIKoniec.Caption := _lMenuMIKoniec;
  TBNew.Hint := _lTBNew;
  TBOpen.Hint := _lTBOpen;
  TBSave.Hint := _lTBSave;
  TBResize.Hint := _lTBResize;
  TBMove.Hint := _lTBMove;
  TBKarelLimit.Hint := _lTBKarelLimit;
  TBZoom.Hint := _lTBKarelLimit;
  TBCommands.Hint := _lTBCommands;
  SBRequest.Caption:= _lSBZobrazZadanie;
  MIAddLevel.Caption := _lMIAddLevel;
  MIRemoveLevel.Caption := _lMIRemoveLevel;
  MIRenameLevel.Caption := _lMIRenameLevel;
  Jazyk1.Caption:=_lMenuJazyk;
  SBReset.Caption:= _lSBReset;
  DStop.reloadLang;
  DDebugWin.reloadLang;
  if(cmdform <> nil) then
    CmdForm.reloadLang;
end;

procedure TForm1.ReadKarelIni;
var
  T: TextFile;
  Line: string;

  procedure NacitajFarby;
  var
    M: string;
    R, G, B: byte;
    E, P: integer;
  begin
    repeat
      ReadLn(T, Line);
      if LowerCase(Line) <> '*colors' then
      begin
        P := 0;
        M := LowerCase(First(Line));
        Val(First(Line), R, E);
        Inc(P, E);
        Val(First(Line), G, E);
        Inc(P, E);
        Val(Line, B, E);
        Inc(P, E);
        if P = 0 then
          DefColors.AddColor(M, RGB(R, G, B));
      end
    until LowerCase(Line) = '*colors';
  end;
  procedure NacitajJazyk;
  begin
    ReadLn(T,Line);
    Line:=LowerCase(line);
    if(line='sk') then
      setLang(lang_sk)
    else if (line='en') then
      setLang(lang_en);
  end;

begin
  if not FileExists('karel.ini') then
    Exit;
  AssignFile(T, 'karel.ini');
  Reset(T);
  Line:='';
  while not EOF(T) do
  begin
    ReadLn(T, Line);
    if LowerCase(Line) = 'colors' then
      NacitajFarby;
    if LowerCase(Line) = 'lang' then
      NacitajJazyk;
  end;
  CloseFile(T);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  X, Y: integer;
begin
  LVersion.Caption := 'v' + version;
  ReadKarelIni;


  Randomize;
  ShowGraphic := True;
  DoubleBuffered := True;
  Left := (Screen.Width - Width) div 2;
  Top := (Screen.Height - Height) div 2;

  Stack := TStack.Create;
  DStop := TDStop.Create(self);
  DStop.BStop.OnClick := BStopClick;
  DStop.BPause.OnClick:= BPauseClick;
  DStop.Left := Left + (Width - DStop.Width) div 2;
  DStop.Top := Top;
  DStop.Hide;

  DDebugWin := TDDebugWin.Create(self);
  DDebugWin.BContinue.OnClick:= BContinueClick;
  DDebugWin.BStep.OnClick:= BStepClick;
  DDebugWin.BStop.OnClick:= BStopClick;
  DDebugWin.OnClose := BDebugCloseWrapper;
  DDebugWin.Hide;

  reloadLang;
  EInput.Text := '';
  ELine := 0;
  MHistory.Clear;

  MLevelDescription.Top := 0;

  Img.Left := 0;
  Img.Top := 0;
  Img.Width := ClientWidth;
  Img.Height := ClientHeight - MHistory.Height - EInput.Height;

  O.X := 150;
  O.Y := Img.Height div 2;
  RoomX := DefRoomX;
  RoomY := DefRoomY;
  RoomH := DefRoomH;

  DrawAxis;

  SetLength(Bricks, RoomX, RoomY);
  SetLength(Marks, RoomX, RoomY);
  SetLength(RequestBricks, RoomX, RoomY);
  SetLength(RequestMarks, RoomX, RoomY);
  SetLength(OrigBricks, RoomX, RoomY);
  SetLength(OrigMarks, RoomX, RoomY);

  for X := 0 to RoomX - 1 do
    for Y := 0 to RoomY - 1 do
    begin
      Bricks[X, Y] := nil;
      Marks[X, Y] := False;
      RequestBricks[X, Y] := nil;
      RequestMarks[X, Y] := False;
      OrigBricks[X, Y] := nil;
      OrigMarks[X, Y] := False;
    end;
  Karel.Pos.X := 0;
  Karel.Pos.Y := 0;
  Karel.Orientation := 0;
  Karel.Limits.Up := 1;

  ReadKarelPts;

  RequestKarel := Karel; //set default values
  OrigKarel := Karel;

  DrawKarel(Karel.Pos.X, Karel.Pos.Y, 0);
  WasChanged := False;
  SetLength(LHistory, 1);
  LHistory[0] := '';

  FormResize(self);
  DeleteProject;

  if paramcount > 0 then
    otvor(ParamStr(1));


end;

procedure TForm1.LBLevelListClick(Sender: TObject);
begin
  if(LBLevelList.ItemIndex <> -1) then begin
    loadlevel(LBLevelList.ItemIndex);
  end;
end;


// toto je skaredy hnustny kod inspirovany examplom z netu, len aby sa dalo right clickom mazat a premenovavat
procedure TForm1.LBLevelListMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  MousePos      : TPoint;
  OverItemIndex : integer;
begin

  MousePos.x := X;
  MousePos.y := Y;

  if Button = mbRight then
    begin
      OverItemIndex := LBLevelList.ItemAtPos(MousePos,False);
      LBLevelList.ItemIndex:=OverItemIndex;
    end;
end;

procedure TForm1.LEng1Click(Sender: TObject);
begin
  setLang(lang_EN);
  reloadLang;
end;

procedure TForm1.LSk1Click(Sender: TObject);
begin
  setLang(lang_SK);
  reloadLang;
end;

// koniec skaredeho hnusneho kodu - ok, skaredy je aj dalej, ale aspon nerobi taku magiu ako toto

procedure TForm1.MIAddLevelClick(Sender: TObject);
  var newname:string;
      X,Y: integer;
begin
  newname:=InputBox(_lLevelName, _lWriteLevelName, '');
  If name = '' then
    showmessage(_lLevelNameCannotBeEmpty)
  else begin
    LevelID:=high(Levels);
    if (LBLevelList.Items.Count <> 0) then begin // some level is in list
      SetLength(Levels, Length(Levels)+1);
      LevelID:=high(Levels);
      Levels[LevelID].Description := TStringList.Create;
      MLevelDescription.Lines.Assign(Levels[LevelID].Description);
      O.X := 150;
      O.Y := Img.Height div 2;
      RoomX := 20;
      RoomY := 10;
      RoomH := 10;
      SetLength(Bricks, RoomX, RoomY);
      SetLength(Marks, RoomX, RoomY);
      SetLength(RequestBricks, RoomX, RoomY);
      SetLength(RequestMarks, RoomX, RoomY);
      SetLength(OrigBricks, RoomX, RoomY);
      SetLength(OrigMarks, RoomX, RoomY);
      for X := 0 to RoomX - 1 do
        for Y := 0 to RoomY - 1 do
        begin
          Bricks[X, Y] := nil;
          Marks[X, Y] := False;
          RequestBricks[X, Y] := nil;
          RequestMarks[X, Y] := False;
          OrigBricks[X, Y] := nil;
          OrigMarks[X, Y] := False;
        end;
      Karel.Pos.X := 0;
      Karel.Pos.Y := 0;
      Karel.Orientation := 0;
      Karel.Limits.Up := 1;
      RequestKarel := Karel;
      OrigKarel := Karel;
      saveLevel;
      ReDrawAll;
    end;
    LBLevelList.Items.Append(newname);
    Levels[LevelID].Name := newname;
  end;
  LBLevelList.ItemIndex:=LevelID;
  LBLevelListClick(self);
end;


procedure TForm1.ReadKarelPts;
var
  F: TextFile;

  function GetLine(var S: string): boolean;
  begin
    S := '';
    Result := False;
    if EOF(F) then
      Exit;
    ReadLn(F, S);
    UnSpace(S);
    while not EOF(F) and (S <> '') and (S[1] = ';') do
    begin
      ReadLn(F, S);
      UnSpace(S);
    end;
    Result := S <> '';
  end;

var
  S: string = '';
  FN: string;
  Phase, Rects, I, J, Vert, KK: integer;
  DecSep: char;
  FGCol, BkCol: TColor;
begin
  DecSep := DefaultFormatSettings.DecimalSeparator;
  DefaultFormatSettings.DecimalSeparator := '.';
  FN := ParamStr(0);
  BkCol := clWhite;
  FgCol := clBlack;
  if Pos(DirectorySeparator, FN) <> 0 then
  begin
    while FN[Length(FN)] <> DirectorySeparator do
      FN := Copy(FN, 1, Length(FN) - 1);
    FN := FN + 'pics' + DirectorySeparator + 'karel.pts';
  end
  else
    FN := 'pics' + DirectorySeparator + 'karel.pts';
  if not FileExists(FN) then
  begin
    MyMessageDlg(_lMsgRunError, _lMsgKarel_NoPic, mtWarning, [mbOK], mrOk, 0);
    Exit;
  end;
  AssignFile(F, FN);
  Reset(F);
  for KK := 0 to 3 do
  begin
    GetLine(S); //cislo fazy;
    Phase := StrToInt(S);
    GetLine(S);
    Rects := StrToInt(S);
    SetLength(Karel.Graphic[Phase], Rects);
    for I := 0 to Rects - 1 do
    begin
      GetLine(S);
      Vert := StrToInt(First(S));//pocet vrcholov nuholnika
      SetLength(Karel.Graphic[Phase, I].Points, Vert);
      if S <> '' then
      begin
        FgCol := StrToInt(First(S));
        BkCol := StrToInt(First(S));
      end;
      Karel.Graphic[Phase, I].FgColor := FgCol;
      Karel.Graphic[Phase, I].BkColor := BkCol;
      for J := 0 to Vert - 1 do
      begin
        GetLine(S);
        Karel.Graphic[Phase, I].Points[J].X := StrToFloat(First(S));
        Karel.Graphic[Phase, I].Points[J].Y := StrToFloat(First(S));
        Karel.Graphic[Phase, I].Points[J].Z := StrToFloat(First(S));
      end;
    end;
  end;
  CloseFile(F);
  DefaultFormatSettings.DecimalSeparator := DecSep;
end;

procedure TForm1.EInputKeyPress(Sender: TObject; var Key: char);
var
  S: string;
begin
  if Key <> #13 then
    Exit;
  S := EInput.Text;
  EInput.Clear;
  UnSpace(S);
  if S = '' then
    Exit;
  if S <> LHistory[Length(LHistory) - 1] then
  begin
    SetLength(LHistory, Length(LHistory) + 1);
    LHistory[Length(LHistory) - 1] := S;
  end;
  ELine := Length(LHistory);
  MHistory.Lines.Add(S);
  CmdForm.Close;
  ShowGraphic := True;
  WasChanged := True;
  RunCommand(S);
  Key := #0;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
  var i:integer;
begin
  for i:=0 to length(Levels)-1 do
    Levels[i].Description.Free;
  CmdForm.Free;
  Stack.Free;
  DStop.Free;
  DDebugWin.Free;
end;

procedure TForm1.MIRenameLevelClick(Sender: TObject);
var
  newname: string;
begin
  newname:=Levels[LBLevelList.ItemIndex].Name;
  newname:=InputBox(_lLevelName, _lWriteLevelName, newname);
  If name = '' then
    showmessage(_lLevelNameCannotBeEmpty)
  else begin
    Levels[LBLevelList.ItemIndex].Name:=newname;
    LBLevelList.Items.Strings[LBLevelList.ItemIndex]:=newname;
  end;
end;

procedure TForm1.MIRemoveLevelClick(Sender: TObject);
  var
      i:integer;
begin
  if LBLevelList.Count = 1 then
    ShowMessage(_lCannotBeRemovedLastLevel)
  else begin
    levels[LBLevelList.ItemIndex].Description.free;
    for i:=LBLevelList.ItemIndex to high(levels)-1 do
      levels[i]:=levels[i+1];
    SetLength(levels, Length(Levels)-1);
    LBLevelList.Items.Delete(LBLevelList.ItemIndex);
    LBLevelList.ItemIndex := 0;
    LBLevelListClick(self);
  end
end;

procedure TForm1.MLevelDescriptionKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Levels[LevelID].Description.Assign(MLevelDescription.Lines); // save old description
end;

procedure TForm1.SBRequestClick(Sender: TObject);
  procedure swapBricks;
    var tmpBricks: TBricks;
  begin
    tmpBricks := Bricks;
    Bricks := RequestBricks;
    RequestBricks := tmpBricks;
  end;
  procedure swapMarks;
    var tmpMarks: TMarks;
  begin
    tmpMarks := Marks;
    Marks := RequestMarks;
    RequestMarks := tmpMarks;
  end;
  procedure swapKarels;
    var tmpKarel: TKarel;
  begin
    tmpKarel := Karel;
    Karel := RequestKarel;
    RequestKarel := tmpKarel;
  end;
  var RequestForm : TForm;
      RequestImg : TImage;
begin
  if admin then begin
    if editingRequest then begin;
      SBRequest.Caption:=_lSBUpravZadanie;
    end
    else begin
      SBRequest.Caption:=_lSBUpravPlochu;
    end;
    editingRequest:=not editingRequest;
    swapBricks;
    swapMarks;
    swapKarels;
    ReDrawAll;
  end
  else begin
    RequestForm := TForm.Create(Self);
    with RequestForm do begin
      Width:=Img.Width;
      Height:=Img.Height;
      Left := (Screen.Width - Width) div 2;
      Top := (Screen.Height - Height) div 2;
      RequestImg := TImage.Create(RequestForm);
      with RequestImg do begin
        Parent:=RequestForm;
        Top:=0;
        left:=0;
        Width:=Img.Width;
        Height:=Img.Width;
      end;
      // Skarede a pritom elegantne
      swapKarels;
      swapBricks;
      swapMarks;
      ReDrawAll;
      RequestImg.Canvas.CopyRect(img.ClientRect, img.Canvas, img.ClientRect);
      swapKarels;
      swapBricks;
      swapMarks;
      ReDrawAll;
      ShowModal;
    end;
  end;
end;

procedure TForm1.SBResetClick(Sender: TObject);
  var xk,yk,zk:integer;
begin
  Karel := OrigKarel;
  for xk:= 0 to RoomX-1 do
    for yk:= 0 to RoomY-1 do begin
      Marks[xk,yk] := OrigMarks[xk,yk];
    SetLength(Bricks[xk,yk],length(OrigBricks[xk,yk]));
      for zk:=0 to length(OrigBricks[xk,yk])-1 do
        Bricks[xk,yk,zk] := OrigBricks[xk,yk,zk];
    end;
  ReDrawAll;
end;

procedure TForm1.SaveProjectClick(Sender: TObject);
var
  DSave: TSaveDialog;
  F: TextFile;
  BW: boolean;
  I, J, K, L: integer;
  Cmd: TCmd;
  OCol: TOColor;
begin
  saveLevel;
  DSave := TSaveDialog.Create(self);
  DSave.DefaultExt := 'kpf';
  DSave.Filter := 'Karel project file (*.kpf)|*.kpf|All files (*.*)|*.*';
  DSave.Options := [ofOverwritePrompt, ofPathMustExist];
  DSave.Title := _lMsgSaveTitle;
  if not DSave.Execute then
  begin
    DSave.Free;
    Exit;
  end;
  Caption := DSave.FileName;
  AssignFile(F, DSave.FileName);
  try
    ReWrite(F);
    WriteLn(F, 'ver=', version);
    for L := 0 to high(Levels) do
    begin
      WriteLn(F, 'level ', Levels[L].Name);
      if Levels[L].Description.Capacity > 0 then
      begin
        WriteLn(F, 'description');
        for I := 0 to Levels[L].Description.Count - 1 do
          WriteLn(F, Levels[L].Description.ValueFromIndex[I]);
        WriteLn(F, '*description');
      end;
      WriteLn(F, 'roomx=', Levels[L].RoomX);
      WriteLn(F, 'roomy=', Levels[L].RoomY);
      WriteLn(F, 'roomh=', Levels[L].RoomH);
      WriteLn(F, 'OX=', Levels[L].O.X);
      WriteLn(F, 'OY=', Levels[L].O.Y);
      WriteLn(F, 'karelx=', Levels[L].Karel.Pos.X);
      WriteLn(F, 'karely=', Levels[L].Karel.Pos.y);
      WriteLn(F, 'karelo=', Levels[L].Karel.Orientation);
      WriteLn(F, 'klimitup=', Levels[L].Karel.Limits.Up);
      WriteLn(F, 'zoom=', Levels[L].Zoom);
      WriteLn(F, 'reqkarelx=', Levels[L].RequestKarel.Pos.X);
      WriteLn(F, 'reqkarely=', Levels[L].RequestKarel.Pos.y);
      WriteLn(F, 'reqkarelo=', Levels[L].RequestKarel.Orientation);
      BW := False;
      for I := 0 to Levels[L].RoomX - 1 do
        for J := 0 to Levels[L].RoomY - 1 do
          if Length(Levels[L].Bricks[I, J]) > 0 then
          begin
            if not BW then
            begin
              BW := True;
              WriteLn(F, 'bricks');
            end;
            Write(F, I, ' ', J);
            for K := 0 to Length(Levels[L].Bricks[I, J]) - 1 do
              Write(F, ' ', Levels[L].Bricks[I, J, K]);
            WriteLn(F);
          end;
      if BW then
        WriteLn(F, '*bricks');
      BW := False;
      for I := 0 to Levels[L].RoomX - 1 do
        for J := 0 to Levels[L].RoomY - 1 do
          if Levels[L].Marks[I, J] then
          begin
            if not BW then
            begin
              BW := True;
              WriteLn(F, 'marks');
            end;
            WriteLn(F, I, ' ', J);
          end;
      if BW then
        WriteLn(F, '*marks');
      BW := False;
      for I := 0 to Levels[L].RoomX - 1 do
        for J := 0 to Levels[L].RoomY - 1 do
          if Length(Levels[L].Bricks[I, J]) > 0 then
          begin
            if not BW then
            begin
              BW := True;
              WriteLn(F, 'reqbricks');
            end;
            Write(F, I, ' ', J);
            for K := 0 to Length(Levels[L].Bricks[I, J]) - 1 do
              Write(F, ' ', Levels[L].Bricks[I, J, K]);
            WriteLn(F);
          end;
      if BW then
        WriteLn(F, '*reqbricks');
      BW := False;
      for I := 0 to Levels[L].RoomX - 1 do
        for J := 0 to Levels[L].RoomY - 1 do
          if Levels[L].Marks[I, J] then
          begin
            if not BW then
            begin
              BW := True;
              WriteLn(F, 'reqmarks');
            end;
            WriteLn(F, I, ' ', J);
          end;
      if BW then
        WriteLn(F, '*reqmarks');

      WriteLn(F, '*level');
    end; // docital som jeden level
    if CmdForm.CmdList.Count > 0 then
      WriteLn(F, 'cmds');
    for I := 0 to CmdForm.CmdList.Count - 1 do
    begin
      Cmd := CmdForm.CmdList.Items.Objects[I] as TCmd;
      WriteLn(F, CmdForm.CmdList.Items[I], ' ', Length(Cmd.Lines));
      for J := 0 to Length(Cmd.Lines) - 1 do
        WriteLn(F, Cmd.Lines[J]);
    end;
    if CmdForm.CmdList.Count > 0 then
      WriteLn(F, '*cmds');

    if DefColors.Count > 0 then
      WriteLn(F, 'colors');

    for I := 0 to DefColors.Count - 1 do
    begin
      OCol := (DefColors.Objects[I] as TOColor);
      WriteLn(F, DefColors.Strings[I], ' ', GetRValue(OCol.Color), ' ',
        GetGValue(OCol.Color), ' ', GetBValue(OCol.Color));
    end;
    if DefColors.Count > 0 then
      WriteLn(F, '*colors');

    CloseFile(F);
    WasChanged := False;//by Vybo :-)
  except
    MyMessageDlg(_lMsgUkladanie, _lMsgSaveError, mtError, [mbOK], mrOk, 0);
  end;

end;

procedure TForm1.Slovnik1Click(Sender: TObject);
begin
  CmdForm.Position := poScreenCenter;
  CmdForm.Show;
  CmdForm.HLEdit.SetFocus;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if WasChanged and (MyMessageDlg(_lMsgUkoncenieProgramu, _lMsgCloseAppl,
    mtWarning, [mbYes, mbNo], mrNo, 0) <> mrYes) then
    CanClose := False
  else
    EndOfAppl := True;
end;

procedure TForm1.TBCmdListClick(Sender: TObject);
begin

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if not Timer1.Enabled then
    Exit;
  if Stack.IsEmpty then
    EndProgram
  else
    RunCommand(Stack.Pop);
end;

procedure TForm1.EInputKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  case Key of
    vk_Up:
    begin
      if ELine > 1 then
        Dec(Eline);
      EInput.Text := LHistory[ELine];
      Key := vk_End;
    end;
    vk_Down:
    begin
      Inc(ELine);
      if ELine >= Length(LHistory) then
        ELine := high(LHistory);
      EInput.Text := LHistory[ELine];
      Key := vk_End;
    end;
    VK_PAUSE :
      startAdmin;
  end;
end;

procedure TForm1.FormResize(Sender: TObject);
const
  rightBar = 200; // sirka praveho baneru v percentach
  rightBarRatio = 2; // pomer zadania ku zoznamu levelov
  questbuttonheight = 30; // vyslka speedbuttonu zadanie
begin
  EInput.Left := 0;
  EInput.Top := ClientHeight - EInput.Height;
  EInput.Width := ClientWidth;

  MHistory.Left := 0;
  Mhistory.Top := ClientHeight - MHistory.Height - EInput.Height;
  MHistory.Width := ClientWidth;

  MLevelDescription.Left := ClientWidth - rightBar;
  MLevelDescription.Width := rightBar;
  MLevelDescription.Height := (ClientHeight - MHistory.Height - EInput.Height) div
    rightBarRatio - questbuttonheight;

  SBRequest.Left := ClientWidth - rightBar;
  SBRequest.Width := rightBar;
  SBRequest.Height:= questbuttonheight;
  SBRequest.Top := (ClientHeight - MHistory.Height - EInput.Height) div
    rightBarRatio - questbuttonheight;


  LBLevelList.Top := (ClientHeight - MHistory.Height - EInput.Height) div rightBarRatio+ questbuttonheight;
  LBLevelList.Left := ClientWidth - rightBar;
  LBLevelList.Width := rightBar;
  LBLevelList.Height := (ClientHeight - MHistory.Height - EInput.Height) div rightBarRatio- questbuttonheight;

  SBReset.Left:=ClientWidth - rightBar;
  SBReset.Width := rightBar;
  SBReset.Height:= questbuttonheight;
  SBReset.Top := (ClientHeight - MHistory.Height - EInput.Height) div rightBarRatio;

  SBRequest.Height:= questbuttonheight;
  SBRequest.Top := (ClientHeight - MHistory.Height - EInput.Height) div
    rightBarRatio - questbuttonheight;

  Img.Width := ClientWidth - rightBar;
  Img.Height := ClientHeight - MHistory.Height - EInput.Height;
  Img.Canvas.Brush.Color := clRed;
  Img.Canvas.FillRect(Img.ClientRect);

  Img.Picture.Graphic.Width := ClientWidth;
  Img.Picture.Graphic.Height := ClientHeight;

  LVersion.Left := MLevelDescription.Left - LVersion.Width - 10;

  ReDrawAll;
end;

procedure TForm1.BStopClick(Sender: TObject);
begin
  EndProgram;
  Stack.Clear;
end;

procedure TForm1.BPauseClick(Sender: TObject);
begin
  CmdPozastav;
end;

procedure TForm1.BContinueClick(Sender: TObject);
begin
  DDebugWin.Hide;
  DStop.Show;
  CmdPokracuj;
end;

procedure TForm1.BDebugCloseWrapper(Sender: TObject; var CloseAction: TCloseAction);
begin
  BContinueClick(Sender);
end;

procedure TForm1.BStepClick(Sender: TObject);
begin
  if Stack.IsEmpty then
    EndProgram
  else
    RunCommand(Stack.Pop);
  ReDrawAll;
end;

procedure TForm1.RoomMoveClick(Sender: TObject);
begin
  case (Sender as TBitBtn).Tag of
    0: Inc(O.X, 10);
    1: Dec(O.Y, 10);
    2: Dec(O.X, 10);
    3: Inc(O.Y, 10);
  end;
  RedrawAll;
  WasChanged := True;
end;

procedure TForm1.DrawAxis;
var
  X, Y: T3DPoint;
  I: integer;
begin
  Img.Canvas.Pen.Color := clBlack;
  X.X := 0;
  X.Y := 0;
  X.Z := 0;
  Y := X;
  Y.X := RoomX;
  Img.Canvas.Pen.Width := 2;
  DrawLine(X, Y, Img.Canvas);
  Y := X;
  Y.Z := RoomH;
  DrawLine(X, Y, Img.Canvas);
  Y := X;
  Y.Y := RoomY;
  DrawLine(X, Y, Img.Canvas);
  Img.Canvas.Pen.Width := 1;
  Img.Canvas.Pen.Style := psDot;
  for I := 1 to RoomY do
  begin
    X.X := 0;
    X.Y := I;
    X.Z := 0;
    Y := X;
    Y.X := RoomX;
    DrawLine(X, Y, Img.Canvas);
  end;
  for I := 1 to RoomX do
  begin
    X.X := I;
    X.Y := 0;
    X.Z := 0;
    Y := X;
    Y.Y := RoomY;
    DrawLine(X, Y, Img.Canvas);
  end;
end;

procedure TForm1.ReDrawAll(const FromY: integer = 0);
var
  X, Y: integer;
begin
  if not ShowGraphic then
    Exit;
  if FromY = 0 then
  begin
    Img.Canvas.Brush.Color := clWhite;
    Img.Canvas.FillRect(Img.ClientRect);
    DrawAxis;
  end;
  for Y := FromY to RoomY - 1 do
    for X := 0 to RoomX - 1 do
    begin
      DrawColumn(X, Y);
      if (Karel.Pos.X = X) and (Karel.Pos.Y = Y) then
        DrawKarel(X, Y, Length(Bricks[X, Y]));
    end;

end;

procedure TForm1.DrawKarel(X, Y, Z: integer);
var
  I: integer;
begin
  Img.Canvas.Pen.Width := 1;
  Img.Canvas.Pen.Style := psSolid;
  for I := 0 to Length(Karel.Graphic[Karel.Orientation]) - 1 do
  begin
    Img.Canvas.Pen.Color := Karel.Graphic[Karel.Orientation, I].FgColor;
    Img.Canvas.Brush.Color := Karel.Graphic[Karel.Orientation, I].BkColor;
    DrawNuhol(Karel.Graphic[Karel.Orientation, I].Points, X, Y, Z, Img.Canvas, 1, 1, 2);
  end;
end;

procedure TForm1.DrawColumn(X, Y: integer);
var
  Num, Z, CT, Od: integer;
  P1, P2, P3, P4: T3DPoint;
begin
  Num := Length(Bricks[X, Y]) - 1;
  if Num >= 0 then
  begin
    CT := 0;
    Od := 0;
    repeat
      while (CT <= Num) and (Bricks[X, Y, Od] = Bricks[X, Y, CT]) do
        Inc(CT);

      Img.Canvas.Brush.Color := Bricks[X, Y, Od];
      Img.Canvas.Pen.Style := psSolid;
      Img.Canvas.Pen.Width := 1;
      Img.Canvas.Pen.Color := clBlack;
      P1.X := X;
      P1.Y := Y + 1;
      P1.Z := Od;
      P2.X := X + 1;
      P2.Y := Y + 1;
      P2.Z := Od;
      P3.X := X + 1;
      P3.Y := Y + 1;
      P3.Z := CT;
      P4.X := X;
      P4.Y := Y + 1;
      P4.Z := CT;
      DrawRect(P1, P2, P3, P4, Img.Canvas);
      P1.X := X + 1;
      P1.Y := Y + 1;
      P1.Z := Od;
      P2.X := X + 1;
      P2.Y := Y;
      P2.Z := Od;
      P3.X := X + 1;
      P3.Y := Y;
      P3.Z := CT;
      P4.X := X + 1;
      P4.Y := Y + 1;
      P4.Z := CT;
      DrawRect(P1, P2, P3, P4, Img.Canvas);
      P1.X := X;
      P1.Y := Y + 1;
      P1.Z := CT;
      P2.X := X + 1;
      P2.Y := Y + 1;
      P2.Z := CT;
      P3.X := X + 1;
      P3.Y := Y;
      P3.Z := CT;
      P4.X := X;
      P4.Y := Y;
      P4.Z := CT;
      DrawRect(P1, P2, P3, P4, Img.Canvas);
      for Z := Od to CT - 1 do
      begin
        P1.X := X;
        P1.Y := Y + 1;
        P1.Z := Z;
        P2 := P1;
        P2.X := X + 1;
        DrawLine(P1, P2, Img.Canvas);
        P1.X := X + 1;
        P1.Y := Y + 1;
        P1.Z := Z;
        P2 := P1;
        P2.Y := Y;
        DrawLine(P1, P2, Img.Canvas);
      end;
      Od := CT;
    until CT > Num;
  end;

  if Marks[X, Y] then
  begin
    Img.Canvas.Pen.Width := 2;
    Img.Canvas.Pen.Color := clRed;
    P1.X := X + 0.2 - 0.5;
    P1.Y := Y + 0.2 - 1;
    P1.Z := Num;
    P2.X := X + 0.8 - 0.5;
    P2.Y := Y + 0.8 - 1;
    P2.Z := Num;
    DrawLine(P1, P2, Img.Canvas);
    P1.X := X + 0.8 - 0.5;
    P1.Y := Y + 0.2 - 1;
    P1.Z := Num;
    P2.X := X + 0.2 - 0.5;
    P2.Y := Y + 0.8 - 1;
    P2.Z := Num;
    DrawLine(P1, P2, Img.Canvas);
  end;
end;

procedure TForm1.RunCommand(Cmd: string);
var
  FW, Back, BackOld: string;
  OK, KymCond, AkCond: boolean;
  Opakuj: TOpakuj;
  Presun: TPresun;
  Kym: TKym;
  Ak: TAk;
  PomCmd: TCmd;
  Cond: TCond;
  II: integer;
  PolozF: TPolozF;
  PomCmdStr: string;
begin
  PomCmdStr:=Cmd;
  repeat
    UnSpace(Cmd);
    FW := LowerCase(First(Cmd));
    OK := False;
    ErrorMsg := _lMsgErrorUnknownCmd + FW;
    if FW = _lKrokCmd then
      if JeVolno then
      begin
        CmdKrok;
        OK := True;
        if Cmd <> '' then
          Stack.Push(Cmd);
      end
      else
        ErrorMsg := _LMsgErrorKrok;
    if FW = _lPolozCmd then
    begin
      CmdPoloz(OK);
      if OK and (Cmd <> '') then
        Stack.Push(Cmd);
    end;
    if FW = _lZoberCmd then
    begin
      CmdZober(OK);
      if OK and (Cmd <> '') then
        Stack.Push(Cmd);
    end;
    if FW = _lVlavoCmd then
    begin
      CmdVlavo;
      OK := True;
      if Cmd <> '' then
        Stack.Push(Cmd);
    end;
    if FW = _lZmazCmd then
    begin
      CmdZmaz;
      OK := True;
      if Cmd <> '' then
        Stack.Push(Cmd);
    end;
    if FW = _lPravdaCmd then
    begin
      CondResult := True;
      OK := True;
      if Cmd <> '' then
        Stack.Push(Cmd);
    end;
    if FW = _lNepravdaCmd then
    begin
      CondResult := False;
      OK := True;
      if Cmd <> '' then
        Stack.Push(Cmd);
    end;
    if FW = _lOpakujCmd then
    begin
      Opakuj := GetOpakuj(Cmd, OK);
      if OK then
      begin
        if Cmd <> '' then
          Stack.Push(Cmd);
        if Opakuj.Commands <> '' then
        begin
          if Opakuj.Pocet > 1 then
            Stack.Push(_lOpakujCmd + ' ' + IntToStr(Opakuj.Pocet - 1) +
              ' ' + _lKratCmd + ' ' + Opakuj.Commands + ' ' + _lOpakujEndCmd);
          if (Opakuj.Pocet <> 0) then
            Stack.Push(Opakuj.Commands);
        end;
      end;
      Iteracia:=Opakuj.Pocet;
    end;
    if FW = _lPresunCmd then
    begin
      Presun := GetPresun(Cmd, OK);
      if OK then
      begin
        if (Presun.NX >= 0) and (Presun.NX < RoomX) and (Presun.NY >= 0) and
          (Presun.NY < RoomY) then
          CmdPresun(Presun.NX, Presun.NY)
        else
        begin
          ErrorMsg := _lMsgErrorPresun2;
          OK := False;
        end;
      end;
    end;
    if FW = _lKymCmd then
    begin
      Kym := GetKym(Cmd, OK);
      if CmdForm.CmdList.Items.IndexOf(Kym.Cond) > -1 then
        Kym.Cond := '%' + Kym.Cond;
      if OK then
        if Kym.Cond[1] = '%' then
        begin
          Kym.Cond := Copy(Kym.Cond, 2, MaxInt);
          II := CmdForm.CmdList.Items.IndexOf(Kym.Cond);
          if II = -1 then
            OK := False
          else
            Cond := GetCond((CmdForm.CmdList.Items.Objects[II] as TCmd).Lines, OK);
          if OK then
          begin
            if Cmd <> '' then
              Stack.Push(Cmd);
            if not Kym.Je then
              Back := _lKymCmd + ' ' + _lNieCmd + ' ' + _lJeCmd
            else
              Back := _lKymCmd + ' ' + _lJeCmd;

            BackOld := Back + ' ' + Kym.Cond + ' ' + _lRobCmd + ' ' + Kym.Commands +
              ' ' + _lKymEndCmd;
            Back := Back + ' ' + _lResultCmd + ' ' + _lRobCmd + ' ' + Kym.Commands +
              ' ' + _lKymEndCmd;
            {hokus pokus:-)}
            if Kym.Je then
              BackOld := _lAkCmd + ' ' + _lJeCmd + ' ' + _lResultCmd + ' ' + _lTakCmd + ' ' + BackOld + ' ' + _lAkEndCmd
            else
              BackOld := _lAkCmd + ' ' + _lNieCmd + ' ' + _lJeCmd + ' ' + _lResultCmd + ' ' + _lTakCmd + ' ' +
                BackOld + ' ' + _lAkEndCmd;
            Stack.Push(BackOld);
            Back := _lAkCmd + ' ';
            if not Kym.Je then
              Back := Back + _lNieCmd + ' ';
            Back := Back + _lJeCmd + ' ' + _lResultCmd + ' ' + _lTakCmd +
              ' ' + Kym.Commands + ' ' + _lAkEndCmd;
            Stack.Push(Back);
            Stack.Push(Cond.Cmds);
          end
          else
            ErrorMsg := _lMsgErrorCnd + ' "' + Kym.Cond + '".';
        end
        else
        begin
          KymCond := False;
          if OK then
            KymCond := CmdCond(Kym.Cond, OK);
          if OK then
          begin
            if Cmd <> '' then
              Stack.Push(Cmd);
            if not (KymCond xor Kym.Je) then
            begin
              if not Kym.Je then
                Back := _lKymCmd + ' ' + _lNieCmd + ' ' + _lJeCmd
              else
                Back := _lKymCmd + ' ' + _lJeCmd;
              Back := Back + ' ' + Kym.Cond + ' ' + _lRobCmd + ' ' +
                Kym.Commands + ' ' + _lKymEndCmd;
              Stack.Push(Back);
              if Kym.Commands <> '' then
                Stack.Push(Kym.Commands);
            end;
          end
          else
            ErrorMsg := _lMsgErrorCnd + ' "' + Kym.Cond + '".';
        end;
    end;
    if FW = _lStojCmd then
    begin
      CmdStoj;
      OK := True;
    end;
    if FW = _lPomalyCmd then
    begin
      CmdPomaly;
      OK := True;
      if Cmd <> '' then
        Stack.Push(Cmd);
    end;
    if FW = _lRychloCmd then
    begin
      CmdRychlo;
      OK := True;
      if Cmd <> '' then
        Stack.Push(Cmd);
    end;
    if FW = _lOznacCmd then
    begin
      CmdOznac;
      OK := True;
      if Cmd <> '' then
        Stack.Push(Cmd);
    end;
    if FW = _lOdznacCmd then
    begin
      CmdOdznac;
      OK := True;
      if Cmd <> '' then
        Stack.Push(Cmd);
    end;
    if FW = _lPozastavCmd then
    begin
      CmdPozastav;
      OK := True;
      if Cmd <> '' then
        Stack.Push(Cmd);
    end;
    if FW = _lAkCmd then
    begin
      Ak := GetAk(Cmd, OK);
      if CmdForm.CmdList.Items.IndexOf(Ak.Cond) > -1 then
        Ak.Cond := '%' + Ak.Cond;
      if OK then
        if Ak.Cond[1] = '%' then
        begin
          Ak.Cond := Copy(Ak.Cond, 2, MaxInt);
          II := CmdForm.CmdList.Items.IndexOf(Ak.Cond);
          if II = -1 then
            OK := False
          else
            Cond := GetCond((CmdForm.CmdList.Items.Objects[II] as TCmd).Lines, OK);
          if OK then
          begin
            if Cmd <> '' then
              Stack.Push(Cmd);
            Back := _lAkCmd + ' ';
            if not Ak.Je then
              Back := Back + _lNieCmd + ' ';
            Back := Back + _lJeCmd + ' ' + _lResultCmd + ' ' + _lTakCmd + ' ';
            Back := Back + Ak.TrueCmd;
            if Ak.FalseCmd <> '' then
              Back := Back + ' ' + _lInakCmd + ' ' + Ak.FalseCmd;
            Back := Back + ' ' + _lAkEndCmd;
            Stack.Push(Back);
            Stack.Push(Cond.Cmds);
          end;
        end
        else
        begin
          AkCond := False;
          if OK then
            AkCond := CmdCond(Ak.Cond, OK);
          if OK then
          begin
            if Cmd <> '' then
              Stack.Push(Cmd);
            if not (AkCond xor Ak.Je) then
              if Ak.TrueCmd <> '' then
                Stack.Push(Ak.TrueCmd)
              else
            else
            if Ak.FalseCmd <> '' then
              Stack.Push(Ak.FalseCmd);
          end;
        end;
    end;
    if FW = _lPolozFCmd then
    begin
      PolozF := GetPolozF(Cmd, OK);
      if OK then
        CmdPolozF(PolozF, OK);
      if OK and (Cmd <> '') then
        Stack.Push(Cmd);
    end;
    if CmdForm.CmdList.Items.IndexOf(FW) <> -1 then
    begin
      if Cmd <> '' then
        Stack.Push(Cmd);
      PomCmd := CmdForm.CmdList.Items.Objects[CmdForm.CmdList.Items.IndexOf(FW)] as TCmd;
      Back := GetPrikaz(FW, PomCmd.Lines, OK);
      if OK then
        Stack.Push(Back)
      else
        ErrorMsg := _lErrorMsgPrikazZly + ' "' + FW + '".';
    end;
    if BasicCnds.IndexOf(FW) > -1 then
    begin
      ErrorMsg := FW + ' je podmienka a je pouzita na nespravnom mieste.';
      OK := False;
    end;
    if not OK then
    begin
      EndProgram;
      Stack.Clear;
      MHistory.Lines.Add('!!! ' + ErrorMsg + '. !!!');
      MyMessageDlg(_lErrorMsgRuntime,ErrorMsg,mtError,[mbOK],mrOK,0);
      Exit;
    end;
    if ((not Stack.IsEmpty) and Pause) then
      break;
    if not Stack.IsEmpty and not Timer1.Enabled then
      BeginProgram;
    if not ShowGraphic then
    begin
      Cmd := Stack.Pop;
      Application.ProcessMessages;
    end;
  until ShowGraphic or (Cmd = '') or Pause;
  If Pause then begin
    If CmdCond(_lStenaCmd,OK) then
      DDebugWin.LStena.Caption := _lPravdaCmd
    else
      DDebugWin.LStena.Caption := _lNepravdaCmd;
    If CmdCond(_lVolnoCmd,OK) then
      DDebugWin.LVolno.Caption := _lPravdaCmd
    else
      DDebugWin.LVolno.Caption := _lNepravdaCmd;
    If CmdCond(_lTehlaCmd,OK) then
      DDebugWin.LTehla.Caption := _lPravdaCmd
    else
      DDebugWin.LTehla.Caption := _lNepravdaCmd;
    If CmdCond(_lZnackaCmd,OK) then
      DDebugWin.LZnacka.Caption := _lPravdaCmd
    else
      DDebugWin.LZnacka.Caption := _lNepravdaCmd;
    DDebugWin.LLastCmd.Caption:=First(PomCmdStr);  // vyuzivame, ze sme si na zaciatku odlozili obsah Cmd
    if not Stack.IsEmpty then begin
      PomCmdStr := Stack.Pop;
      Stack.Push(PomCmdStr);
      DDebugWin.LNextCmd.Caption:=First(PomCmdStr);
    end;
    DDebugWin.LIteration.Caption:=inttostr(Iteracia);
  end;

  if Stack.IsEmpty then
    EndProgram;
end;

procedure TForm1.BeginProgram;
var
  I: integer;
begin
  if ShowGraphic then
    Timer1.Enabled := True;
  DStop.Visible := True;
  EInput.Enabled := False;
  for I := 0 to MainMenu.Items.Count - 1 do
    MainMenu.Items[I].Enabled := False;
  for I := 0 to ToolBar1.ButtonCount - 1 do
    ToolBar1.Buttons[I].Enabled := False;
end;

procedure TForm1.EndProgram;
var
  I: integer;
begin
  Timer1.Enabled := False;
  DStop.Visible := False;
  DDebugWin.Visible := False;
  EInput.Enabled := True;
  EInput.SetFocus;
  Pause:=false;
  for I := 0 to MainMenu.Items.Count - 1 do
    MainMenu.Items[I].Enabled := True;
//  if not ShowGraphic then
//  begin
    ShowGraphic := True;
    RedrawAll;
//  end;
  for I := 0 to ToolBar1.ButtonCount - 1 do
    ToolBar1.Buttons[I].Enabled := True;
end;

procedure TForm1.CmdKrok(Sender: TObject = nil);
begin
  case Karel.Orientation of
    0: if RoomX > Karel.Pos.X + 1 then
        Inc(Karel.Pos.X);
    1: if Karel.Pos.Y > 0 then
        Dec(Karel.Pos.Y);
    2: if Karel.Pos.X > 0 then
        Dec(Karel.Pos.X);
    3: if RoomY > Karel.Pos.Y + 1 then
        Inc(Karel.Pos.Y);
  end;
  ReDrawAll;
end;

procedure TForm1.CmdPolozF(Info: TPolozF; var OK: boolean);
var
  TX, TY: integer;
begin
  OK := False;
  if JeStena then
  begin
    ErrorMsg := _lMsgErrorPolozPriStene;
    Exit;
  end;
  TX := Karel.Pos.X;
  TY := Karel.Pos.Y;
  case Karel.Orientation of
    0: Inc(TX);
    1: Dec(TY);
    2: Dec(TX);
    3: Inc(TY);
  end;
  if Length(Bricks[TX, TY]) = RoomH then
  begin
    ErrorMsg := _lMsgErrorPolozVyska;
    Exit;
  end;

  SetLength(Bricks[TX, TY], Length(Bricks[TX, TY]) + 1);
  Bricks[TX, TY, Length(Bricks[TX, TY]) - 1] := Info.Color;

  OK := True;
  ReDrawAll;
end;

procedure TForm1.CmdPoloz(var OK: boolean);
var
  TX, TY: integer;
begin
  OK := False;
  if JeStena then
  begin
    ErrorMsg := _lMsgErrorPolozPriStene;
    Exit;
  end;
  TX := Karel.Pos.X;
  TY := Karel.Pos.Y;
  case Karel.Orientation of
    0: Inc(TX);
    1: Dec(TY);
    2: Dec(TX);
    3: Inc(TY);
  end;
  if Length(Bricks[TX, TY]) = RoomH then
  begin
    ErrorMsg := _lMsgErrorPolozVyska;
    Exit;
  end;

  SetLength(Bricks[TX, TY], Length(Bricks[TX, TY]) + 1);
  Bricks[TX, TY, Length(Bricks[TX, TY]) - 1] := BrickColor;

  OK := True;
  ReDrawAll;
end;

procedure TForm1.CmdZober(var OK: boolean);
var
  TX, TY: integer;
begin
  OK := False;
  if JeStena then
  begin
    ErrorMsg := _lMsgErrorZoberNietco;
    Exit;
  end;
  TX := Karel.Pos.X;
  TY := Karel.Pos.Y;
  case Karel.Orientation of
    0: Inc(TX);
    1: Dec(TY);
    2: Dec(TX);
    3: Inc(TY);
  end;
  if Length(Bricks[TX, TY]) = 0 then
  begin
    ErrorMsg := _lMsgErrorZoberNietco;
    Exit;
  end;
  OK := True;
  LastTakenColor := Bricks[TX, TY, Length(Bricks[TX, TY]) - 1];
  SetLength(Bricks[TX, TY], Length(Bricks[TX, TY]) - 1);
  ReDrawAll;
end;

procedure TForm1.CmdVlavo;
begin
  Karel.Orientation := (Karel.Orientation + 1) mod 4;
  ReDrawAll;
end;

procedure TForm1.CmdZmaz;
var
  X, Y: integer;
begin
  for X := 0 to RoomX - 1 do
    for Y := 0 to RoomY - 1 do
    begin
      Bricks[X, Y] := nil;
      Marks[X, Y] := False;
    end;
  RedrawAll;
end;

procedure TForm1.CmdPresun(NX, NY: integer);
begin
  Karel.Pos.X := NX;
  Karel.Pos.Y := NY;
  ReDrawAll;
end;

function TForm1.JeVolno: boolean;
var
  NX, NY: integer;
begin
  Result := False;
  if JeStena then
    Exit;
  NX := Karel.Pos.X;
  NY := Karel.Pos.Y;
  case Karel.Orientation of
    0: Inc(NX);
    1: Dec(NY);
    2: Dec(NX);
    3: Inc(NY)
  end;
  Result := (Length(Bricks[NX, NY]) - Length(Bricks[Karel.Pos.X, Karel.Pos.Y])) <=
    Karel.Limits.Up;
end;

function TForm1.JeStena: boolean;
begin
  Result := (Karel.Orientation = 0) and (Karel.Pos.X = RoomX - 1) or
    (Karel.Orientation = 1) and (Karel.Pos.Y = 0) or (Karel.Orientation = 2) and
    (Karel.Pos.X = 0) or (Karel.Orientation = 3) and (Karel.Pos.Y = RoomY - 1);
end;

function TForm1.CmdCond(Condition: string; var OK: boolean): boolean;
begin
  OK := True;
  Result := False;
  ErrorMsg := '';
  if Condition = _lTehlaCmd then
  begin
    Result := (Karel.Orientation = 0) and (Karel.Pos.X < RoomX - 1) and
      (Length(Bricks[Karel.Pos.X + 1, Karel.Pos.Y]) > 0) or (Karel.Orientation = 1) and
      (Karel.Pos.Y > 0) and (Length(Bricks[Karel.Pos.X, Karel.Pos.Y - 1]) > 0) or
      (Karel.Orientation = 2) and (Karel.Pos.X > 0) and
      (Length(Bricks[Karel.Pos.X - 1, Karel.Pos.Y]) > 0) or (Karel.Orientation = 3) and
      (Karel.Pos.Y < RoomY - 1) and (Length(Bricks[Karel.Pos.X, Karel.Pos.Y + 1]) > 0);
    Exit;
  end;
  if Condition = _lStenaCmd then
  begin
    Result := JeStena;
    Exit;
  end;
  if Condition = _lNahodaCmd then
  begin
    Result := Random(2) = 1;
    Exit;
  end;
  if Condition = _lVolnoCmd then
  begin
    Result := JeVolno;
    Exit;
  end;
  if Condition = _lZnackaCmd then
  begin
    Result := Marks[Karel.Pos.X, Karel.Pos.Y];
    Exit;
  end;
  if Condition = _lResultCmd then
  begin
    Result := CondResult;
    Exit;
  end;
  ErrorMsg := _lMsgErrorUnknownCnd + Condition;
  OK := False;
end;

procedure TForm1.CmdStoj;
begin
  EndProgram;
  Stack.Clear;
end;

procedure TForm1.CmdPomaly;
begin
  ShowGraphic := True;
  Timer1.Enabled := True;
  RedrawAll;
end;

procedure TForm1.CmdRychlo;
begin
  ShowGraphic := False;
  Timer1.Enabled := False;
end;

procedure TForm1.CmdOznac;
begin
  Marks[Karel.Pos.X, Karel.Pos.Y] := True;
  RedrawAll;
end;

procedure TForm1.CmdOdznac;
begin
  Marks[Karel.Pos.X, Karel.Pos.Y] := False;
  RedrawAll;
end;

procedure TForm1.CmdPozastav;
begin
  Pause:=true;
  Timer1.Enabled:=false;
  DDebugWin.Show;
  DStop.Hide;
end;

procedure TForm1.CmdPokracuj;
begin
  Pause:=false;
  Timer1.Enabled:=true;
end;

procedure TForm1.Rozmerymiestnosti1Click(Sender: TObject);
var
  MyDialog: TDMiestnost;
begin
  MyDialog := TDMiestnost.Create(self);
  MyDialog.EVyska.Text := IntToStr(RoomH);
  MyDialog.EDlzka.Text := IntToStr(RoomX);
  MyDialog.ESirka.Text := IntToStr(RoomY);
  MyDialog.UDVyska.Position := RoomH;
  MyDialog.UDDlzka.Position := RoomX;
  MyDialog.UDSirka.Position := RoomY;
  if MyDialog.ShowModal <> mrOk then
  begin
    MyDialog.Free;
    Exit;
  end;
  RoomX := MyDialog.UDDlzka.Position;
  RoomY := MyDialog.UDSirka.Position;
  RoomH := MyDialog.UDVyska.Position;
  SetLength(Bricks, RoomX, RoomY);
  SetLength(Marks, RoomX, RoomY);
  SetLength(RequestBricks, RoomX, RoomY);
  SetLength(RequestMarks, RoomX, RoomY);
  SetLength(OrigBricks, RoomX, RoomY);
  SetLength(OrigMarks, RoomX, RoomY);

  if (Karel.Pos.X >= RoomX) or (Karel.Pos.Y >= RoomY) then
  begin
    Karel.Pos.X := 0;
    Karel.Pos.Y := 0;
  end;
  if (RequestKarel.Pos.X >= RoomX) or (RequestKarel.Pos.Y >= RoomY) then
  begin
    RequestKarel.Pos.X := 0;
    RequestKarel.Pos.Y := 0;
  end;
  if (OrigKarel.Pos.X >= RoomX) or (OrigKarel.Pos.Y >= RoomY) then
  begin
    OrigKarel.Pos.X := 0;
    OrigKarel.Pos.Y := 0;
  end;
  RedrawAll;
  MyDialog.Free;
  WasChanged := True;
end;

procedure TForm1.Posunmiestnosti1Click(Sender: TObject);
var
  MyDialog: TDRoomMove;
begin
  MyDialog := TDRoomMove.Create(self);
  MyDialog.BRight.OnClick := RoomMoveClick;
  MyDialog.BUp.OnClick := RoomMoveClick;
  MyDialog.BDown.OnClick := RoomMoveClick;
  MyDialog.BLeft.OnClick := RoomMoveClick;
  MyDialog.ShowModal;
  MyDialog.Free;
end;

procedure TForm1.ObmedzenieKarla1Click(Sender: TObject);
var
  MyDialog: TDLimitKarel;
begin
  MyDialog := TDLimitKarel.Create(self);
  MyDialog.EUp.Text := IntToStr(Karel.Limits.Up);
  MyDialog.SBTimer.Position := 1000 div (Timer1.Interval * 10);
  if MyDialog.ShowModal = mrOk then
  begin
    Karel.Limits.Up := StrToInt(MyDialog.EUp.Text);
    Timer1.Interval := 1000 div (MyDialog.SBTimer.Position * 10);
    WasChanged := True;
  end;
  MyDialog.Free;
end;

procedure TForm1.OtvorPojektClick(Sender: TObject);

var
  DOpen: TOpenDialog;
begin
  if WasChanged and (MyMessageDlg(_lMsgNeulozeny, _lMsgNoSavedWarn,
    mtWarning, [mbYes, mbNo, mbCancel], mrCancel, 0) <> mrYes) then
    Exit;
  DOpen := TOpenDialog.Create(self);
  DOpen.DefaultExt := 'kpf';
  DOpen.Filter := 'Karel project file (*.kpf)|*.kpf|All files (*.*)|*.*';
  DOpen.Options := [ofOverwritePrompt, ofPathMustExist, ofFileMustExist];
  DOpen.Title := _lMsgOpenTitle;
  if not DOpen.Execute then
  begin
    DOpen.Free;
    Exit;
  end;
  otvor(DOpen.FileName);
  DOpen.Free;
end;

procedure TForm1.otvor(filename: string);
var
  F: TextFile;
  Status: byte;
  PR, CR: integer; {pocet riadkov}
  Cmd: TCmd;
  OKFile: boolean;
  firstlevel: boolean;

  procedure swapBricks;
    var tmpBricks: TBricks;
  begin
    tmpBricks := Bricks;
    Bricks := RequestBricks;
    RequestBricks := tmpBricks;
  end;
  procedure swapMarks;
    var tmpMarks: TMarks;
  begin
    tmpMarks := Marks;
    Marks := RequestMarks;
    RequestMarks := tmpMarks;
  end;

  procedure Spracuj2_2(S: string);
  var
    LS, PS, C1, C2: string;
    I: integer;
  begin
    case Status of
      0:
      begin  // reading level
        LS := Copy(S, 1, Pos('=', S) - 1);
        PS := Copy(S, Pos('=', S) + 1, MaxInt);
        if LS = 'roomx' then
        begin
          RoomX := StrToInt(PS);
          SetLength(Bricks, RoomX, RoomY);
          SetLength(Marks, RoomX, RoomY);
          SetLength(RequestBricks, RoomX, RoomY);
          SetLength(RequestMarks, RoomX, RoomY);
          SetLength(OrigBricks, RoomX, RoomY);
          SetLength(OrigMarks, RoomX, RoomY);
        end;
        if LS = 'roomy' then
        begin
          RoomY := StrToInt(PS);
          SetLength(Bricks, RoomX, RoomY);
          SetLength(Marks, RoomX, RoomY);
          SetLength(RequestBricks, RoomX, RoomY);
          SetLength(RequestMarks, RoomX, RoomY);
          SetLength(OrigBricks, RoomX, RoomY);
          SetLength(OrigMarks, RoomX, RoomY);
        end;
        if LS = 'roomh' then
          RoomH := StrToInt(PS);
        if LS = 'OX' then
          O.X := StrToInt(PS);
        if LS = 'OY' then
          O.Y := StrToInt(PS);
        if LS = 'klimitup' then begin
          Karel.Limits.Up := StrToInt(PS);
          RequestKarel.Limits.Up := StrToInt(PS);
          OrigKarel.Limits.Up := StrToInt(PS);
        end;
        if LS = 'karelx' then begin
          Karel.Pos.X := StrToInt(PS);
          OrigKarel.Pos.X := StrToInt(PS);
        end;
        if LS = 'karely' then begin
          Karel.Pos.Y := StrToInt(PS);
          OrigKarel.Pos.Y := StrToInt(PS);
        end;
        if LS = 'karelo' then begin
          Karel.Orientation := StrToInt(PS);
          OrigKarel.Orientation := StrToInt(PS);
        end;
        if LS = 'reqkarelx' then
          RequestKarel.Pos.X := StrToInt(PS);
        if LS = 'reqkarely' then
          RequestKarel.Pos.Y := StrToInt(PS);
        if LS = 'reqkarelo' then
          RequestKarel.Orientation := StrToInt(PS);
        if LS = 'zoom' then
        begin
          Zoom := StrToInt(PS);
          UX.X := Zoom * DefUX.X;
          UX.Y := Zoom * DefUX.Y;
          UZ.X := Zoom * DefUZ.X;
          UZ.Y := Zoom * DefUZ.Y;
          UY.X := Zoom * DefUY.X;
          UY.Y := Zoom * DefUY.Y;
        end;
        if PS = 'bricks'  then
          Status := 1;
        if PS = 'marks' then
          Status := 2;
        if PS = 'reqbricks' then begin
          Status := 1;
          swapBricks;
        end;
        if PS = 'reqmarks' then begin
          Status := 2;
          swapMarks;
        end;
        if PS = 'description' then
          Status := 7;
        if PS = '*level' then
        begin
          Status := 6;
          LevelID := high(Levels);
          saveLevel;
        end;
      end;
      1:
      begin  // reading bricks
        UnSpace(S);
        if S = '*bricks' then
        begin
          Status := 0;
          Exit;
        end;
        if S = '*reqbricks' then
        begin
          Status := 0;
          swapBricks;
          Exit;
        end;
        C1 := First(S);
        C2 := First(S);
        UnSpace(S);
        repeat
          SetLength(Bricks[StrToInt(C1), StrToInt(C2)], Length(
            Bricks[StrToInt(C1), StrToInt(C2)]) + 1);
          Bricks[StrToInt(C1), StrToInt(C2), Length(
            Bricks[StrToInt(C1), StrToInt(C2)]) - 1] := StrToInt(First(S));
          SetLength(OrigBricks[StrToInt(C1), StrToInt(C2)], Length(
            Bricks[StrToInt(C1), StrToInt(C2)]));
          OrigBricks[StrToInt(C1), StrToInt(C2), Length(
            OrigBricks[StrToInt(C1), StrToInt(C2)]) - 1] :=
          Bricks[StrToInt(C1), StrToInt(C2), Length(
            OrigBricks[StrToInt(C1), StrToInt(C2)]) - 1];
          UnSpace(S);
        until S = '';
      end;
      2:
      begin  // reading marks
        Unspace(S);
        if S = '*marks' then
        begin
          Status := 0;
          Exit;
        end;
        if S = '*reqmarks' then
        begin
          Status := 0;
          swapMarks;
          Exit;
        end;
        I := 1;
        while S[I] <> ' ' do
          Inc(I);
        C1 := Copy(S, 1, I - 1);
        C2 := Copy(S, I + 1, MaxInt);
        Marks[StrToInt(C1), StrToInt(C2)] := True;
        OrigMarks[StrToInt(C1), StrToInt(C2)] := True;
      end;
      3:
      begin  // closing cmds
        UnSpace(S);
        if S = '*cmds' then
        begin
          Status := 6;
          Exit;
        end;
        LS := Copy(S, 1, Pos(' ', S) - 1);
        PS := Copy(S, Pos(' ', S) + 1, MaxInt);
        PR := StrToInt(PS);
        CR := 0;
        Cmd := TCmd.Create;
        SetLength(Cmd.Lines, PR);
        if CmdForm <> nil then
          CmdForm.CmdList.AddItem(LS, Cmd);
        Status := 4;
      end;
      4:
      begin // reading cmds
        Cmd.Lines[CR] := S;
        Inc(CR);
        if CR = PR then
          Status := 3;
      end;
      5:
      begin // reading colors
        UnSpace(S);
        if S = '*colors' then
        begin
          Status := 6;
          Exit;
        end;
        LS := Copy(S, 1, Pos(' ', S) - 1);
        PS := Copy(S, Pos(' ', S) + 1, MaxInt);
        DefColors.AddColor(LS, RGB(StrToInt(First(PS)), StrToInt(
          First(PS)), StrToInt(First(PS))));
      end;
      6:
      begin // reading main
        LS := Copy(S, 1, Pos('=', S) - 1);
        PS := Copy(S, Pos('=', S) + 1, MaxInt);
        if PS = 'cmds' then
        begin
          Status := 3;
          if CmdForm <> nil then
            CmdForm.CmdList.Clear;
        end;
        if PS = 'colors' then
          Status := 5;
        LS := Copy(S, 1, Pos(' ', S) - 1);
        PS := Copy(S, Pos(' ', S) + 1, MaxInt);
        if LS = 'level' then
        begin
          if not firstLevel then begin // first level wasn't readed yet
            setlength(levels, 1);
            firstlevel:=true;
          end
          else
            SetLength(Levels, Length(Levels) + 1);
          Levels[high(Levels)].Name := PS;
          Levels[high(Levels)].Description := TStringList.Create;
          MLevelDescription.Lines.Assign(Levels[high(Levels)].Description);
          LBLevelList.Items.Append(PS);
          Status := 0;
        end;
      end;
      7:
      begin // reading level description
        UnSpace(S);
        if S = '*description' then
        begin
          Status := 0;
          Exit;
        end;
        MLevelDescription.Lines.Add(S);
      end;
    end;
  end;

  procedure Spracuj2_1(S: string);
  var
    LS, PS: string;
  begin
    case Status of
      0:
      begin // reading level
        LS := Copy(S, 1, Pos('=', S) - 1);
        PS := Copy(S, Pos('=', S) + 1, MaxInt);
        if LS = 'roomx' then
        begin
          RoomX := StrToInt(PS);
          SetLength(Bricks, RoomX, RoomY);
          SetLength(Marks, RoomX, RoomY);
          SetLength(RequestBricks, RoomX, RoomY);
          SetLength(RequestMarks, RoomX, RoomY);
          SetLength(OrigBricks, RoomX, RoomY);
          SetLength(OrigMarks, RoomX, RoomY);
        end;
        if LS = 'roomy' then
        begin
          RoomY := StrToInt(PS);
          SetLength(Bricks, RoomX, RoomY);
          SetLength(Marks, RoomX, RoomY);
          SetLength(RequestBricks, RoomX, RoomY);
          SetLength(RequestMarks, RoomX, RoomY);
          SetLength(OrigBricks, RoomX, RoomY);
          SetLength(OrigMarks, RoomX, RoomY);
        end;
        if LS = 'roomh' then
          RoomH := StrToInt(PS);
        if LS = 'OX' then
          O.X := StrToInt(PS);
        if LS = 'OY' then
          O.Y := StrToInt(PS);
        if LS = 'klimitup' then begin
          Karel.Limits.Up := StrToInt(PS);
          OrigKarel.Limits.Up := StrToInt(PS);
        end;
        if LS = 'karelx' then begin
          Karel.Pos.X := StrToInt(PS);
          OrigKarel.Pos.X := StrToInt(PS);
        end;
        if LS = 'karely' then begin
          Karel.Pos.Y := StrToInt(PS);
          OrigKarel.Pos.Y := StrToInt(PS);
        end;
        if LS = 'karelo' then begin
          Karel.Orientation := StrToInt(PS);
          OrigKarel.Orientation := StrToInt(PS);
        end;
        if LS = 'zoom' then
        begin
          Zoom := StrToInt(PS);
          UX.X := Zoom * DefUX.X;
          UX.Y := Zoom * DefUX.Y;
          UZ.X := Zoom * DefUZ.X;
          UZ.Y := Zoom * DefUZ.Y;
          UY.X := Zoom * DefUY.X;
          UY.Y := Zoom * DefUY.Y;
        end;
        if PS = 'bricks' then
          Status := 1;
        if PS = 'cmds' then
        begin
          Status := 3;
          if CmdForm <> nil then
            CmdForm.CmdList.Clear;
        end;
        if PS = 'marks' then
          Status := 2;
        if PS = 'colors' then
          Status := 5;
      end;
      1: Spracuj2_2(S);           // reading bricks
      2: Spracuj2_2(S);          // reading marks
      3:
      begin  // closing cmds
        UnSpace(S);
        if S = '*cmds' then
        begin
          Status := 0;
          Exit;
        end;
        Spracuj2_2(S); // jedine co je ine, do akeho stavu sa clovek vracia po nacitani prikazov.
      end;

      4: Spracuj2_2(S);   // reading cmds
      5:
      begin // reading colors
        UnSpace(S);
        if S = '*colors' then
        begin
          Status := 0;
          Exit;
        end;
        LS := Copy(S, 1, Pos(' ', S) - 1);
        PS := Copy(S, Pos(' ', S) + 1, MaxInt);
        DefColors.AddColor(LS, RGB(StrToInt(First(PS)), StrToInt(
          First(PS)), StrToInt(First(PS))));
      end;
      6,7:
      begin
        MyMessageDlg(_lMsgNacitanie, _lMsgOpenError, mtError, [mbOK], mrOk, 0);
        OKFile := False;
      end;

    end;
  end;

  procedure Spracuj2_0(S: string);
  var
    C1, C2, C3: string;
    I, J: integer;
  begin
    case Status of
      0: Spracuj2_1(S);   // reading level
      // jediny problem moze vzniknut, ak by vo verzii 2.0 bolo slovo colors. dajme tomu, ze sa to nestane
      1:              // reading bricks
      begin
        UnSpace(S);
        if S = '*bricks' then
        begin
          Status := 0;
          Exit;
        end;
        I := 1;
        while S[I] <> ' ' do
          Inc(I);
        C1 := Copy(S, 1, I - 1);
        S := Copy(S, I + 1, MaxInt);
        I := 1;
        while S[I] <> ' ' do
          Inc(I);
        C2 := Copy(S, 1, I - 1);
        C3 := Copy(S, I + 1, MaxInt);
        SetLength(Bricks[StrToInt(C1), StrToInt(C2)], StrToInt(C3));
        for J := 0 to StrToInt(C3) - 1 do
          Bricks[StrToInt(C1), StrToInt(C2), J] := BrickColor;
      end;
      2: Spracuj2_1(S); // reading marks
      3: Spracuj2_1(S);  // closing cmds
      4: Spracuj2_1(S);  // reading cmds
      5, 6, 7:
      begin
        MyMessageDlg(_lMsgNacitanie, _lMsgOpenError, mtError, [mbOK], mrOk, 0);
        OKFile := False;
      end;
    end;
  end;

var
  S: string;
  I: integer;
  LS, PS: string;
begin
  Status := 0;
  DeleteProject;
  OKFile := True;
  firstlevel:= false; // first level wasn't readed yet
  AssignFile(F, filename);
  try
    Reset(F);
    ReadLn(F, S);
    LS := Copy(S, 1, Pos('=', S) - 1);
    PS := Copy(S, Pos('=', S) + 1, MaxInt);
    if LowerCase(LS) <> 'ver' then
      OKFile := False
    else
    begin
      if PS = '2.2' then
        Status := 6;
      while not EOF(F) and OKFile do
      begin
        ReadLn(F, S);
        if PS = '2.0' then
          Spracuj2_0(S);
        if PS = '2.1' then
          Spracuj2_1(S);
        if PS = '2.2' then
          Spracuj2_2(S);
      end;
    end;
    CloseFile(F);

  except
    MyMessageDlg(_lMsgNacitanie, _lMsgReadingError, mtError, [mbOK], mrOk, 0);
    Exit;
  end;
  if (LBLevelList.Count > 0) then begin
    LBLevelList.ItemIndex:=0;
    LBLevelListClick(self);
  end;
  if CmdForm <> nil then
    CmdForm.Caption := '';
  if (CmdForm = nil) or (CmdForm.CmdList.Count = 0) then
    Exit;
  CmdForm.CmdList.ItemIndex := 0;
  Cmd := CmdForm.CmdList.Items.Objects[0] as TCmd;
  CmdForm.HLEdit.Enabled := True;
  CmdForm.HLEdit.Clear;
  for I := 0 to Length(Cmd.Lines) - 1 do
    CmdForm.HLEdit.Lines.Add(Cmd.Lines[I]);
  CmdForm.LastItem := 0;
  Caption := filename;

  WasChanged := False;
  CmdForm.Caption := _lPrikazCmd + ' ' + CmdForm.CmdList.Items[0];

  ReDrawAll;
end;

procedure TForm1.Lupa1Click(Sender: TObject);
var
  MyDialog: TDZoom;
begin
  MyDialog := TDZoom.Create(self);
  MyDialog.SBSize.Position := Zoom;
  MyDialog.SBSize.OnChange := ZoomChange;
  MyDialog.ShowModal;

  MyDialog.Free;
end;

procedure TForm1.ZoomChange(Sender: TObject);
begin
  Zoom := (Sender as TScrollBar).Position;
  UX.X := Zoom * DefUX.X;
  UX.Y := Zoom * DefUX.Y;
  UZ.X := Zoom * DefUZ.X;
  UZ.Y := Zoom * DefUZ.Y;
  UY.X := Zoom * DefUY.X;
  UY.Y := Zoom * DefUY.Y;
  ReDrawAll;
  WasChanged := True;
end;

procedure TForm1.DeleteProject;
var
  I, J: integer;
begin
  if CmdForm <> nil then
  begin
    for I := 0 to CmdForm.CmdList.Count - 1 do
      CmdForm.CmdList.Items.Objects[I].Free;
    CmdForm.CmdList.Clear;
    CmdForm.HLEdit.Clear;
    CmdForm.HLEdit.Enabled := False;
    CmdForm.Caption := '';
  end;
  RoomX := DefRoomX;
  RoomY := DefRoomY;
  RoomH := DefRoomH;
  SetLength(Bricks, RoomX, RoomY);
  SetLength(Marks, RoomX, RoomY);
  SetLength(RequestBricks, RoomX, RoomY);
  SetLength(RequestMarks, RoomX, RoomY);
  SetLength(OrigBricks, RoomX, RoomY);
  SetLength(OrigMarks, RoomX, RoomY);
  for I := 0 to RoomX - 1 do
    for J := 0 to RoomY - 1 do
    begin
      Bricks[I, J] := nil;
      Marks[I, J] := False;
      RequestBricks[I, J] := nil;
      RequestMarks[I, J] := False;
      OrigBricks[I, J] := nil;
      OrigMarks[I, J] := False;
    end;
  Karel.Pos.X := 0;
  Karel.Pos.Y := 0;
  Karel.Orientation := 0;
  RequestKarel := Karel;
  OrigKarel:= Karel;
  if Length(Levels) > 1 then
    for I := 0 to high(Levels) do
      FreeAndNil(Levels[I].Description);
  MLevelDescription.Lines.Clear;
  LBLevelList.Items.Clear;
  SetLength(Levels, 1);
  LevelID:=0;
  saveLevel;
  RedrawAll;
  Caption := _lMsgNoSavedTitle;
  if CmdForm <> nil then
    CmdForm.LastItem := -1;
end;

procedure TForm1.Novyprojekt1Click(Sender: TObject);
begin
  if WasChanged and (MyMessageDlg(_lMsgNeulozeny, _lMsgNoSavedWarn,
    mtWarning, [mbYes, mbNo, mbCancel], mrCancel, 0) <> mrYes) then
    Exit;
  DeleteProject;
  WasChanged := False;
  Pause:=false;
end;

procedure TForm1.MIKoniecClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Otvoritprojekt1Click(Sender: TObject);

begin
  OtvorPojektClick(Sender);
end;

procedure TForm1.Ulozitprojekt1Click(Sender: TObject);
begin
  SaveProjectClick(Sender);
end;

procedure TForm1.saveLevel;
begin

  Levels[LevelID].RoomX := RoomX;
  Levels[LevelID].RoomY := RoomY;
  Levels[LevelID].RoomH := RoomH;
  Levels[LevelID].O := O;
  Levels[LevelID].Karel := Karel;
  Levels[LevelID].RequestKarel := RequestKarel;
  Levels[LevelID].OrigKarel := OrigKarel;
  Levels[LevelID].Zoom := Zoom;
  Levels[LevelID].Bricks := Bricks;
  Levels[LevelID].Marks := Marks;
  Levels[LevelID].RequestBricks := RequestBricks;
  Levels[LevelID].RequestMarks := RequestMarks;
  Levels[LevelID].OrigBricks := OrigBricks;
  Levels[LevelID].OrigMarks := OrigMarks;
  if Levels[LevelID].Description = nil then
    Levels[LevelID].Description := TStringList.Create;
  Levels[LevelID].Description.Assign(MLevelDescription.Lines);
end;
procedure TForm1.loadlevel(levelnumber:integer);
begin
  LevelID:=levelnumber;
  RoomX:=Levels[LevelID].RoomX;
  RoomY:=Levels[LevelID].RoomY;
  RoomH:=Levels[LevelID].RoomH;
  O:=Levels[LevelID].O;
  Karel := Levels[LevelID].Karel;
  RequestKarel := Levels[LevelID].RequestKarel;
  OrigKarel := Levels[LevelID].OrigKarel;
  Zoom := Levels[LevelID].Zoom;
  Bricks := Levels[LevelID].Bricks;
  Marks := Levels[LevelID].Marks;
  RequestBricks := Levels[LevelID].RequestBricks;
  RequestMarks := Levels[LevelID].RequestMarks;
  OrigBricks := Levels[LevelID].OrigBricks;
  OrigMarks := Levels[LevelID].OrigMarks;
  MLevelDescription.Lines.Assign(Levels[LevelID].Description);
  ReDrawAll;
end;
procedure TForm1.wrapperpoloz(Sender: TObject);
  var localOK:boolean = false;
begin
  CmdPoloz(localOK);
end;
procedure TForm1.wrapperzober(Sender: TObject);
  var localOK:boolean = false;
begin
  CmdZober(localOK);
end;

procedure TForm1.startAdmin;

begin
  MLevelDescription.Enabled:=true;
  SBRequest.Enabled:=true;
  SBRequest.Caption:=_lSBUpravZadanie;
  LBLevelList.PopupMenu:=PMLevelEdit;
  admin:=true;

  DirectForm := TDirectForm.Create(self);
  DirectForm.SBkrok.OnClick:=Cmdkrok;
  DirectForm.SBvlavo.OnClick:=Cmdvlavo;
  DirectForm.SBoznac.OnClick:=Cmdoznac;
  DirectForm.SBodznac.OnClick:=Cmdodznac;
  DirectForm.SBpoloz.OnClick:=wrapperpoloz;
  DirectForm.SBzober.OnClick:=wrapperzober;

  DirectForm.Show;
end;



end.

