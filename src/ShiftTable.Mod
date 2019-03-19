MODULE ShiftTable;

  CONST
    maxElems = 10000;
  TYPE
    ShiftTable* = RECORD
      lowIndex-, highIndex-: LONGINT;
      elements: ARRAY maxElems OF BOOLEAN;
    END (* record *);

  PROCEDURE Put* (VAR table: ShiftTable; index: LONGINT; e: BOOLEAN);
  BEGIN
      ASSERT(index >= table.lowIndex);
      ASSERT(index <= table.highIndex); 
      table.elements[index - table.lowIndex] := e;
    END Put;
      
  PROCEDURE Init* (VAR table: ShiftTable; lowIndex,highIndex: LONGINT);
  VAR
    i: LONGINT;
    BEGIN
      table.lowIndex := lowIndex; table.highIndex := highIndex;
      FOR i := lowIndex TO highIndex  DO
        Put(table, i, TRUE);
      END (* for *);
    END Init;
  
  PROCEDURE Get* (VAR table: ShiftTable; index: LONGINT): BOOLEAN;
    BEGIN
      RETURN table.elements[index - table.lowIndex];
    END Get;
  
  
END ShiftTable.
