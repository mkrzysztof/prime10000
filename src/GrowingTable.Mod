MODULE GrowingTable;

  (* GrowingTable is dynamic table [0..MaxIndex] OF LONGINT *)
  CONST
    maxElems = 200000;
    
  TYPE
    GrowingTable* = RECORD
      length-: LONGINT;
      elements: ARRAY maxElems OF LONGINT;
    END;
    
    PROCEDURE Init* (VAR growTab: GrowingTable);
      BEGIN
        growTab.length := 0;
      END Init;
      
    PROCEDURE Get* (VAR growTab: GrowingTable; index: LONGINT): LONGINT;
      BEGIN
        RETURN growTab.elements[index];
      END Get;
      
    PROCEDURE Put (VAR growTab: GrowingTable; index, e: LONGINT);
      BEGIN
        growTab.elements[index] := e;
      END Put;
    
    PROCEDURE Add* (VAR growTab: GrowingTable; element: LONGINT);
      BEGIN
        Put(growTab, growTab.length, element); INC(growTab.length);
      END Add;

END GrowingTable.
