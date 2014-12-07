unit UStack;

{$MODE Delphi}

interface
uses Classes;
type TItem = string;

     TStack = class
        procedure Push(NItem : TItem);
        function Pop : TItem;
        function IsEmpty : Boolean;
        procedure Clear;
        private
          Stack : array of TItem;
     end;

implementation



function TStack.IsEmpty:Boolean;
begin
  Result:=Length(Stack)=0
end;

procedure TStack.Push(NItem : TItem);
begin
  SetLength(Stack,Length(Stack)+1);
  Stack[Length(Stack)-1]:=NItem;
end;

function TStack.Pop : string;
begin
  Result:='';
  if IsEmpty then Exit;
  Result:=Stack[Length(Stack)-1];
  SetLength(Stack,Length(Stack)-1);
end;

procedure TStack.Clear;
begin
  SetLength(Stack,0);
end;



end.
