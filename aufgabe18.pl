:- [idDfs].

adj(X,Y) :- adj0(X,Y); adj0(Y,X).
adj0(X,Y) :- member((X,Y), [
	(1,2), (2,3), (4,5),
	(2,7), (4,9), (5,10),
	(6,7), (7,8), (8,9),
	(7,12), (10,15),
	(13,14), (14,15),
	(11,16), (12,17), (14,19),(15,20),
	(17,18), (18,19),
	(19,24),
	(21,22), (22,23), (23,24), (24,25)
	]).

%blumen([3,17,20,21]).
%Frau(25).
%Mann = 7.

zweig(Start,Ziele,Weg,Depth) :-
	(length(Ziele,Y), Y == 0),writeln(Weg);
	subset(Weg,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25]),
	selectchk(AktZiel,Ziele,RestZiele),
	dlDfs(Start,AktZiel,[Start], Depth, ReturnPath),
	length(ReturnPath,D),
	select(_Dup,ReturnPath,RP),
	append(Weg,RP,L),
	zweig(AktZiel,RestZiele,L,Depth - D).


sammeln0(Start,Frau,Blumen,Weg,Depth) :-
	permutation(P,Blumen),append(P,[Frau],G),
	zweig(Start,G,Weg,Depth);
	writeln(Depth),
	sammeln0(Start,Frau,Blumen,Weg,Depth+1).

sammeln(Start,Frau,Blumen,Weg) :- sammeln0(Start,Frau,Blumen,Weg,1).