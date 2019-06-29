(* extended version of Eratostenes' algorithm *)
MODULE ExtErato;
  IMPORT
    ST := ShiftTable, GT := GrowingTable, Out;
    
  PROCEDURE EliminateMult(primes: GT.GrowingTable; 
                          VAR candidates: ST.ShiftTable);
  (** output:
    candidates[k] = FALSE where k = j * p; j= 2,3... p in primes *)
  VAR
    i: LONGINT;
    low, high: LONGINT;
    getMsg: GT.GetMsg;
    PROCEDURE EliminateMultP(low, high, prime: LONGINT);
    VAR
      j: LONGINT;
    BEGIN
       FOR j := low TO high DO
          IF (j MOD prime) = 0 THEN ST.Put(candidates, j, FALSE); END;
       END;
    END EliminateMultP;
  BEGIN
    low := candidates.lowIndex; high := candidates.highIndex;
    FOR i := 0 TO primes.length - 1 DO
      getMsg.index := i; primes.handle(primes, getMsg);
      EliminateMultP(low, high, getMsg.out);
    END;
  END EliminateMult;


  PROCEDURE EliminateMultP(VAR candidates: ST.ShiftTable; p: LONGINT);
  VAR
    j, m: LONGINT;
    PROCEDURE MultP(k: LONGINT): LONGINT; BEGIN RETURN p*p + p*k; END MultP;
  BEGIN
    IF p <= candidates.highIndex/p THEN
      j := 0;
      m := MultP(j);
      WHILE m <= candidates.highIndex DO
        ST.Put(candidates, m, FALSE);
        INC(j);
        m := MultP(j);
      END;
    END;
  END EliminateMultP;
  
  PROCEDURE LocalSieve(VAR candidates: ST.ShiftTable);
  (** *)
  VAR
    p: LONGINT;
    low, high: LONGINT;
  BEGIN
    low := candidates.lowIndex; high := candidates.highIndex;
    FOR p := low TO high DO
      IF ST.Get(candidates, p) THEN 
        EliminateMultP(candidates, p)
      END;
    END;
  END LocalSieve;
  
  PROCEDURE AddPrimeNumbers(primes: GT.GrowingTable;
                            VAR candidates: ST.ShiftTable);
  VAR
    low, high, i: LONGINT;
    addMsg: GT.AddMsg;
  BEGIN
    low := candidates.lowIndex; high := candidates.highIndex;
    FOR i := low TO high DO
      IF ST.Get(candidates, i) THEN
          addMsg.element := i; primes.handle(primes, addMsg)
      END;
    END;
  END AddPrimeNumbers;
  
  PROCEDURE PartErato(VAR primes: GT.GrowingTable; 
                      VAR candidates: ST.ShiftTable);
  (* add to primes finding all prime number with candidates *)
  BEGIN
    EliminateMult(primes, candidates);
    LocalSieve(candidates);
    AddPrimeNumbers(primes, candidates);
  END PartErato;
  
  PROCEDURE Erato*(nthNumber: LONGINT): LONGINT;
  (** produce n-th prime number *)
  CONST
    PART = 9000;
  VAR
    primes: GT.GrowingTable;
    candidates: ST.ShiftTable;
    start, stop: LONGINT;
    retValue: LONGINT;
    addMsg: GT.AddMsg;
    getMsg: GT.GetMsg;
  BEGIN
    primes := GT.New();
    addMsg.element := 2; primes.handle(primes, addMsg);
    start := 2; stop := start + PART;
    WHILE primes.length <= nthNumber DO
      ST.Init(candidates, start, stop);
      PartErato(primes, candidates);
      start := stop + 1; stop := start + PART;
    END;
    getMsg.index := nthNumber - 1; primes.handle(primes, getMsg);
    retValue := getMsg.out;
    RETURN retValue;
  END Erato;
END ExtErato.
