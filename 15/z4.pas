program z4;
type
  NodePtr = ^Node;
  Node = record
    data: Integer;
    next: NodePtr;
  end;
  
var
  head, current: NodePtr;
  max, min, i: Integer;

procedure AddNode(var head: NodePtr; value: Integer);
var
  newNode, p: NodePtr;
begin
  New(newNode);
  newNode^.data := value;
  newNode^.next := nil;
  
  if head = nil then
  begin
    head := newNode;
  end
  else
  begin
    p := head;
    while p^.next <> nil do
    begin
      p := p^.next;
    end;
    p^.next := newNode;
  end;
end;

procedure LinkedList(head: NodePtr);
var
  pp: NodePtr;
begin
  pp := head;
  while pp <> nil do
  begin
    writeln(pp^.data);
    pp := pp^.next;
  end;
end;

procedure FindMinMax(head: NodePtr; var max, min: Integer);
var
  p: NodePtr;
begin
  p := head;
  max := p^.data;
  min := p^.data;
  
  while p <> nil do
  begin
    if p^.data > max then
    begin
      max := p^.data;
    end;
    if p^.data < min then
    begin
      min := p^.data;
    end;
    p := p^.next;
  end;
end;

begin

  Randomize;
  for i := 1 to 10 do
  begin
    AddNode(head, random(10));
  end;
  
  FindMinMax(head, max, min);

  writeln('Полный список:');
  LinkedList(head);
  
  writeln('Максимальный элемент в списке: ', max);
  writeln('Минимальный элемент в списке: ', min);
end.
