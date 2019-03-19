MODULE DataType;

  (* GrowingTable is dynamic table [0..MaxIndex] OF LONGINT *)
  CONST
    maxElems = 200000;
    maxElems2 = 1000000;
  TYPE
    GrowingTable* = RECORD
      length-: LONGINT;
      elements: ARRAY maxElems OF LONGINT;
    END;
    (* ShiftTable is dynamic table [lowIndex..highIndex] OF LONGINT *)
    ShiftTable* = RECORD
        lowIndex-, highIndex-: LONGINT;
        elements: ARRAY maxElems2 OF BOOLEAN;
    END;
    
  PROCEDURE GrowingTableINIT*(VAR growTab: GrowingTable);
  BEGIN
      growTab.length := 0;
  END GrowingTableINIT;
  
  PROCEDURE AddElement*(VAR growTab: GrowingTable; element: LONGINT);
  BEGIN
      growTab.elements[growTab.length] := element;
      INC(growTab.length);
  END AddElement;

  PROCEDURE LastElement*(VAR growTab: GrowingTable): LONGINT;
  BEGIN
    RETURN growTab.elements[growTab.length - 1];
  END LastElement;
  
  PROCEDURE GrowingTableGET*(VAR growTab: GrowingTable; 
    index: LONGINT): LONGINT;
  BEGIN
      RETURN growTab.elements[index];
  END GrowingTableGET;
  
  PROCEDURE GrowingTablePUT*(VAR growTab: GrowingTable; 
                             index: LONGINT; e: LONGINT);
  BEGIN
      growTab.elements[index] := e;
  END GrowingTablePUT;

 
 PROCEDURE ShiftTableINIT*(VAR table: ShiftTable; 
                           lowIndex, highIndex: LONGINT);
 VAR
     i: LONGINT;
 BEGIN
     table.lowIndex := lowIndex;
     table.highIndex := highIndex;
     FOR i := 0 TO highIndex - lowIndex DO table.elements[i] := TRUE; END;
 END ShiftTableINIT;
 
 PROCEDURE ShiftTableGET*(VAR table: ShiftTable; index: LONGINT): BOOLEAN;
 BEGIN
     RETURN table.elements[index - table.lowIndex];
 END ShiftTableGET;
 
 PROCEDURE ShiftTablePUT*(VAR table: ShiftTable; index: LONGINT; e: BOOLEAN);
 BEGIN
     ASSERT(index - table.lowIndex < maxElems);
     table.elements[index - table.lowIndex] := e;
 END ShiftTablePUT;
    

END DataType.
