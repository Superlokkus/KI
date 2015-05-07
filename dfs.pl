

% Tiefensuche - alle besuchten Knoten werden gespeichert
dfs1([H|T], Discovered) :-
	goal(H);
	findall(Node, (adj(H, Node), not(member(Node, Discovered))), NewNeighbors),
	append(NewNeighbors, T, Stack), % Unterschied zu bfs
	append(Discovered, NewNeighbors, Dc),
	write('Stack: '), writeln(Stack), % zur Illustration
	dfs1(Stack, Dc).
	
% Tiefensuche - ohne expliziten Stack, besuchte Knoten werden nicht gespeichert
dfs2(Node) :-
	goal(Node);
	adj(Node, Neighbor),
	dfs2(Neighbor).

% Tiefensuche - ohne expliziten Stack, Knoten auf aktuellem Pfad werden gespeichert
dfs3(Node, Path) :-
	goal(Node);
	adj(Node, NewNeighbor), not(member(NewNeighbor,Path)),
	write('Knoten: '), writeln(NewNeighbor), % zur Illustration
	dfs3(NewNeighbor, [NewNeighbor|Path]).

% Wie dfs3, gefundener ReturnPath wird zurückgegeben
dfs4(Node, Path, ReturnPath) :-
	goal(Node), reverse(Path, ReturnPath);
	adj(Node,NewNeighbor), not(member(NewNeighbor,Path)),
	dfs4(NewNeighbor, [NewNeighbor|Path], ReturnPath).