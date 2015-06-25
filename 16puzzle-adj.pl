% Leerstelle in Zeile verschieben
sr( [16,A,B,C], [A,16,B,C]).
sr( [A,16,B,C], [A,B,16,C]).
sr( [A,B,16,C], [A,B,C,16]).
shiftr(X,Y) :- sr(X,Y); sr(Y,X).

adjr( [X,  R2, R3, R4], [Y,  R2, R3, R4]) :- shiftr(X, Y).
adjr( [R1, X,  R3, R4], [R1, Y,  R3, R4]) :- shiftr(X, Y).
adjr( [R1, R2,  X, R4], [R1, R2,  Y, R4]) :- shiftr(X, Y).
adjr( [R1, R2,  R3, X], [R1, R2,  R3, Y]) :- shiftr(X, Y).

% Leerstelle in Spalte verschieben
adjc( [[A1,B1,C1,D1], [E1,F1,G1,H1], [I1,J1,K1,L1], [M1,N1,O1,P1]],
      [[A2,B2,C2,D2], [E2,F2,G2,H2], [I2,J2,K2,L2], [M2,N2,O2,P2]] ) :-
        adjr( [[A1,E1,I1,M1], [B1,F1,J1,N1], [C1,G1,K1,O1], [D1,H1,L1,P1]],
              [[A2,E2,I2,M2], [B2,F2,J2,N2], [C2,G2,K2,O2], [D2,H2,L2,P2]] ).

% Leerstelle in Zeile oder Spalte verschieben
adj(Board1, Board2) :-
        adjr(Board1, Board2);
        adjc(Board1, Board2).

% Zielstellung
goal( [[ 1, 2, 3, 4],
       [ 5, 6, 7, 8],
       [ 9,10,11,12],
       [13,14,15,16]] ).

% Pretty-Printer
printB(Board) :- maplist(writeln, Board), write('\n').
print(Boards) :- maplist(printB, Boards).