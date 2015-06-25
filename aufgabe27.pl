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


adj( ([[K|S]|B], P1), ([[P1|S]|B], P2) ) :- belegbar(K,S), other_player(P1, P2).%Elementweise
adj( ([[S|T]|B], P1), ([[S|U]|B], P2) ) :- other_player(P1, P2), adj( ([T|B], P1), ([U|B], P2) ). %Nicht nur oberstes Element
adj( ([S|T], P1), ([S|U], P2) ) :- other_player(P1, P2), adj( (T, P1), (U, P2) ).%Spalten durchprobieren

% Alle Kästchen angekreuzt
full([]).
full([H|T]) :- not(free(H)), full(T).

utility(Board, U) :-
	(member(Board, [[A,A,A, _,_,_, _,_,_], [_,_,_, A,A,A, _,_,_], [_,_,_, _,_,_, A,A,A],
					[A,_,_, A,_,_, A,_,_], [_,A,_, _,A,_, _,A,_], [_,_,A, _,_,A, _,_,A],
					[A,_,_, _,A,_, _,_,A], [_,_,A, _,A,_, A,_,_]]),
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
%([[f,f,f,f,f],[x,o,o,o,x],[f,f,x,x,o],[f,f,o,x,x],[f,f,f,f,f]],o)
