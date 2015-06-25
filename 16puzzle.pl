:- ['16puzzle-adj'].
%:- [idas].%Auskommentieren für astern
:- ['a-stern']. %Einkommentieren für astern

%Cityblock Distanz 
h0(A,B,X) :- A1 is A-1, B1 is B-1, H = abs((div(A1,4))-(div(B1,4))), V = abs((A1 mod 4)-(B1 mod 4)), X is H+V.

h(Board, HD) :-
        flatten(Board, B),
        goal(GoalB), flatten(GoalB,G),
        maplist(h0, B, G, Diffs),
        sumlist(Diffs, HD), !.

%solution(Board, Sol) :- goal(G), idas(Board, G, Sol). %Auskommentieren für astern
solution(Board, Sol) :- goal(G), hs([[Board]],[], G, Sol). %Einkommentieren für astern

%Problem: Out of global stack mit astern selbst mit set_prolog_stack(local,limit(10**10)).

% solution([[1,16,3,4], [5,2,7,8], [9,6,10,12], [13,14,11,15]], Sol), print(Sol).
% solution([[2,1,3,10], [13,9,5,4], [8,14,7,11], [12,15,6,16]], Sol), print(Sol).