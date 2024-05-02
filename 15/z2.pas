program z2;

type
  PNode = ^Node;
  Node = record   
    word: string[40]; 
    counter: integer;   
    next: PNode; 
  end;

  
var
  F: Text;
  count: integer;
  Head, a, pp: PNode;
  str: string;

//Считывание одного слова из файла
function TakeWord ( F: Text ) : string;
var c: char;
begin
  count := 1;
  Result := ''; 
  c := ' ';  
  while not eof(F) and (c <= ' ') do 
    read(F, c);    
  while not eof(F) and (c > ' ') do begin
    Result := Result + c;
    read(F, c);
  end;
end;

//Поиск в списке
function Find(Head: PNode; NewWord: string): PNode;
var
  pp: PNode;
begin
  pp := Head;
  while (pp <> nil) and (NewWord <> pp^.word) do 
    pp := pp^.next;
  Result := pp;
end;

//Поиск места для слова
function FindPlace(Head: PNode; NewWord: string): PNode;
var pp: PNode;
begin
  pp := Head;
  while (pp <> nil) and (NewWord > pp^.word) do
    pp := pp^.next;
  Result := pp;

end;

//Создание узла
function CreateNode(NewWord: string): PNode;
var NewNode: PNode;
begin
  New(NewNode);
  NewNode^.word := NewWord;
  NewNode^.counter := 1;
  NewNode^.next := nil;
  Result := NewNode;
end;

//Добавление узел в начало списка
procedure AddFirst ( var Head: PNode; NewNode: PNode );
begin
  NewNode^.next := Head;
  Head := NewNode;
end;

//Добавить узел в конец списка
procedure AddAfter(var p: PNode; NewNode: PNode);
begin
  NewNode^.next := p^.next;
  p^.next := NewNode;
end;

//Добавить узел перед заданным
procedure AddBefore(var Head: PNode; p, NewNode: PNode);
var pp: PNode;
begin
  pp := Head;
  if p = Head then
    AddFirst ( Head, NewNode )  
  else begin
    while (pp <> nil)  and  (pp^.next <> p) do 
      pp := pp^.next;
    if pp <> nil then AddAfter ( pp, NewNode ); 
  end;
end;


begin
 assign(F, 'input.txt');
 reset(F);
 Head := nil;
 AddFirst(Head, CreateNode(TakeWord(F)));
 count := 1;
 while not eof(F) do begin
   count += 1; 
   str := TakeWord(F);
   a := Find(Head, str);
   if  a  = nil then
    begin
      AddBefore(Head, FindPlace(Head, str), CreateNode(str));
      count += 1;
    end
    else
      a^.counter += 1;
  end;
  Close(F);
   pp := Head; 
  while pp <> nil do
  begin
    writeln(pp^.word, ' - ', pp^.counter);
    pp := pp^.next;        
  end;
 end.
 