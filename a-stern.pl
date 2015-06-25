% Heuristische Bewertungsfunktion
f([H|T],Y) :- g([H|T],Y1), h(H,Y2), Y is Y1+Y2.
g(L,Y) :- length(L,Y1), Y is Y1-1.
%h(X,Y) :- Y is 0. % Ändern! Hier muß eine Kostenschätzfunktion angegeben werden.

%% hs([H|T], Discovered) :-
%% 	goal(H);
%% 	findall(Node, (adj(H, Node), not(member(Node, Discovered))), NewNeighbors),
%% 	append(T, NewNeighbors, Queue),
%% 	append(Discovered, NewNeighbors, Dc),
%% 	fsort(Queue, SortedQ),
%% 	hs(SortedQ, Dc).

%Pfad statt Knoten
hs([[H|T]|Tail], Discovered, Goal, ReturnPath) :-
      H = Goal, reverse([H|T],ReturnPath);
      findall(Node, (adj(H, Node), not(member(Node, Discovered))), NewNeighbors),
      findall([New|[H|T]], member(New,NewNeighbors), NewPaths),
      append(Tail, NewPaths, Queue),
      append(Discovered, NewNeighbors, Dc),
      fsort(Queue, SortedQ),
	hs(SortedQ, Dc, Goal,ReturnPath).
	
% Sortieren der Liste gemäß der Werte von f
fsort(List, Sorted) :- 
        map_list_to_pairs(f, List, Pairs), 
        keysort(Pairs, SortedPairs), 
        pairs_values(SortedPairs, Sorted). 
