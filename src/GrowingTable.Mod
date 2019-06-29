MODULE GrowingTable;
IMPORT Out;
  (* GrowingTable is dynamic table [0..MaxIndex] OF LONGINT *)
  CONST
    maxElems = 200000;
    
  TYPE
    Message = RECORD END;
    GetMsg* = RECORD (Message)
      index*: LONGINT;
      out*: LONGINT;
    END;
    AddMsg* = RECORD (Message)
      element*: LONGINT;
    END;
    
    GrowingTable* = POINTER TO GrowingTableDesc;
    Handler = PROCEDURE(g: GrowingTable; VAR msg: Message);
    GrowingTableDesc* = RECORD
      length-: LONGINT;
      elements: ARRAY maxElems OF LONGINT;
      handle*: Handler;
    END;

    PROCEDURE Get(t: GrowingTable; VAR msg: GetMsg);
    BEGIN
	msg.out := t.elements[msg.index];
    END Get;
      
    PROCEDURE Put (growTab: GrowingTable; index, e: LONGINT);
      BEGIN
        growTab.elements[index] := e;
      END Put;
    
    PROCEDURE Add(t: GrowingTable; VAR msg: AddMsg);
    BEGIN
        Put(t, t.length, msg.element); INC(t^.length);
    END Add;

    PROCEDURE HandleTable(t: GrowingTable; VAR msg: Message);
    BEGIN
       IF msg IS GetMsg THEN
           Get(t, msg(GetMsg));
       ELSIF msg IS AddMsg THEN
           Add(t, msg(AddMsg));
       ELSE
           HALT(100);
       END;
    END HandleTable;

    PROCEDURE New*(): GrowingTable;
    VAR
       retValue: GrowingTable;
    BEGIN
       NEW(retValue);
       retValue.length := 0;
       retValue.handle := HandleTable;
    RETURN retValue; END New;

END GrowingTable.
