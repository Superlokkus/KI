% Spieler: Max: x, Min: o
other_player(x, o).
other_player(o, x).

% Freie Kästchen: f
free(f).

% Kann ich Kästchen momentan belegen?
belegbar(K,S) :- free(K), (S == []; not(nth0(0,S,f))).

% Knoten haben die Form ([C1,C2,C3,C4,C5], Player),
%wobei C1,C2,C3,C4,C5 die Spalten des Bretts sind und
% jedes Element eins aus {f,x,o} ist bei dem Player der Spieler am Zug ist.


adj( ([[K|S]|B], P1), ([[P1|S]|B], P2) ) :- belegbar(K,S), other_player(P1, P2),!.%Elementweise
adj( ([[S|T]|B], P1), ([[S|U]|B], P2) ) :- other_player(P1, P2), adj( ([T|B], P1), ([U|B], P2) ),!. %Nicht nur oberstes Element
adj( ([S|T], P1), ([S|U], P2) ) :- other_player(P1, P2), adj( (T, P1), (U, P2) ).%Spalten durchprobieren

% Alle Kästchen angekreuzt
full([]).
full([[H|_T]|B]) :- not(free(H)), full(B).%Prüft ob erste Zeile belegt

%I 1 bis 10 Zeilen
test_row0(Board,I,A) :- flatten(Board,FB),
				I1 is I+5*0, I2 is I+5*1,
				I3 is I+5*2, I4 is I+5*3,
				nth1(I1,FB,A), nth1(I2,FB,A),
				nth1(I3,FB,A), nth1(I4,FB,A).
test_row(Board,A) :- test_row0(Board,1,A); test_row0(Board,2,A);
	test_row0(Board,3,A); test_row0(Board,4,A); test_row0(Board,5,A); test_row0(Board,6,A); test_row0(Board,7,A); test_row0(Board,8,A); test_row0(Board,9,A); test_row0(Board,10,A).

test_diagp0(Board,I,A) :- flatten(Board,FB),
				I1 is I+5*0, I2 is I+5*1+1,
				I3 is I+5*2+2, I4 is I+5*3+3,
				nth1(I1,FB,A), nth1(I2,FB,A),
				nth1(I3,FB,A), nth1(I4,FB,A).
test_diagp(Board,A) :- test_diagp0(Board,1,A); test_diagp0(Board,2,A);
	test_diagp0(Board,6,A); test_diagp0(Board,7,A).
test_diagn0(Board,I,A) :- flatten(Board,FB),
				I1 is I+5*0, I2 is I+5*1-1,
				I3 is I+5*2-2, I4 is I+5*3-3,
				nth1(I1,FB,A), nth1(I2,FB,A),
				nth1(I3,FB,A), nth1(I4,FB,A).
test_diagn(Board,A) :- test_diagn0(Board,5,A); test_diagn0(Board,4,A);
	test_diagn0(Board,9,A); test_diagn0(Board,10,A).

utility(Board, U) :-
	((
		member([_,A,A,A,A],Board);
		member([A,A,A,A,_],Board);
		test_row(Board,A);
		test_diagp(Board,A);
		test_diagn(Board,A)
	),
	 (A == x, U is 1;
	  A == o, U is -1)
	);
	full(Board), U is 0. % Unentschieden

minimax(Board, Player, Value) :-
	utility(Board, Value);
	(findall(V, (adj( (Board, Player), (NextBoard, OtherPlayer) ), minimax(NextBoard, OtherPlayer, V)), Values),
	 (Player == x, max_list(Values, Value);
	  Player == o, min_list(Values, Value))
	).

% adj(([[f,f,f,f,f],[x,o,o,o,x],[f,f,x,x,o],[f,f,o,x,x],[f,f,f,f,f]],o),([[f,f,f,f,f],[x,o,o,o,x],[f,o,x,x,o],[f,f,o,x,x],[f,f,f,f,f]],x)).
% utility([[f,x,o,x,o],[f,o,x,o,x],[f,o,x,o,x],[f,f,f,f,x],[f,o,x,o,x]],U).
%Erster Test
% minimax([[f,f,f,f,f],[x,o,o,o,x],[f,f,x,x,o],[f,f,o,x,x],[f,f,f,f,f]],o,U).

%Zweiter Test
% x, 1
% minimax([[f,x,o,x,o],[f,o,x,o,x],[f,o,x,o,x],[f,f,f,f,f],[f,o,x,o,x]],x,U).
% o, -1
% % minimax([[f,x,o,x,o],[f,o,x,o,x],[f,o,x,o,x],[f,f,f,f,f],[f,o,x,o,x]],o,U).
