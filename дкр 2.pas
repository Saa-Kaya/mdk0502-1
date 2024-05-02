program Queue;

uses crt;

type PNode = ^Node;
     Node = record
       data: integer;
       next: PNode;
     end;
type TQueue = record
       head, tail: PNode;
       Cnt : Integer; 
     end;
     
var
  staticQueue: array[1..5] of integer;
  dynamicQueue: TQueue;
  choice, value, headd, taill: integer;


//Динамическая структура     
procedure PushTail( var Q: TQueue; x: integer );
var NewNode: PNode;
begin
  New(NewNode);
  NewNode^.data := x;
  NewNode^.next := nil;
  if Q.tail <> nil then
    Q.tail^.next := NewNode;
  Q.tail := NewNode; 
  if Q.head = nil then Q.head := Q.tail;
end;

function Pop ( var Q: TQueue ): integer;
var top: PNode;
begin
  if Q.head = nil then begin
    Result := MaxInt;
    Exit;
  end;
  top := Q.head;
  Result := top^.data;
  Q.head := top^.next;
  if Q.head = nil then Q.tail := nil;
  Dispose(top);
end;

//Статическая структура
procedure Enqueue(value: integer);
begin
  taill := taill + 1;
  staticQueue[taill] := value;
end;

function Dequeue: integer;
begin
  if headd = taill then
    raise Exception.Create('Очередь пуста');

  headd := headd + 1;
  Result := staticQueue[headd];
end;

begin

  repeat
    writeln('1. Добавить в очередь (динамическая структура)');
    writeln('2. Удалить из очереди (динамическая структура)');
    writeln('3. Добавить в очередь (статическая структура)');
    writeln('4. Удалить из очереди (статическая структура)');
    writeln('5. Выход');
    write('Введите число (1-5): ');
    readln(choice);

    case choice of
      1:
      begin
        write('Введите значение: ');
        readln(value);
        PushTail(dynamicQueue, value);
      end;
      2:
      begin
        writeln('Удалённое значение: ', Pop(dynamicQueue));
      end;
      3:
      begin
        write('Введите значение: ');
        readln(value);
        Enqueue(value);        
      end;
      4:
      begin
        writeln('Удалённое значение: ', Dequeue); 
      end;
      5: writeln('Выход...');
    else
      writeln('Некорректное значение. Повторите попытку.');
    end;
  until choice = 5;
end.