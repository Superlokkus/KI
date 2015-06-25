% Spieler: Max: x, Min: o
other_player(x, o).
other_player(o, x).

% Freie Kästchen: f
free(f).

% Knoten haben die Form
% ([A,B,C,
%   D,E,F,
%   G,H,I], Player)
% wobei jedes Element eins aus {f,x,o} ist und Player der Spieler am Zug ist.
adj( ([H|T], P1), ([P1|T], P2) ) :- free(H), other_player(P1, P2).
adj( ([H|T], P1), ([H|U], P2) ) :- other_player(P1, P2), adj( (T, P1), (U, P2) ).
%MK Note: Das hier drüber ist nur dafür das die Stelle nicht am Anfang der Liste stehen muss
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

%MK Board minimax([o,o,x,f,x,f,o,x,f],x,V).
% adj(([o,o,x,f,x,f,o,x,f],x),([o,o,x,f,x,f,o,x,x],o)).
