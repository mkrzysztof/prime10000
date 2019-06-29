MODULE Test;
IMPORT E := ExtErato, Out;

BEGIN
     Out.Int(E.Erato(5000), 8);
     Out.Ln;
     Out.Flush;
END Test.
