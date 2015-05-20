:- [aufgabe8].

verwandt0(X,Y) :- kind(X,Y,_Z); kind(X,_Z,Y); 
	bruder(X,Y); schwester(X,Y); enkel(X,Y); onkel(X,Y); tante(X,Y).
verwandt(X,Y) :-  verwandt0(X,Y) ; verwandt0(Y,X).

verheiratet(X,Y) :- kind(_Z,X,Y) ; kind(_Z,Y,X).

person0(X) :- verwandt(X,_Y).

match(X,[X|Rest],Rest).

person(X,[X|Rest],Rest) :- person0(X).

numerus(In,Rest) :- match(sind,In,Rest); match(ist,In,Rest).
aufzaehler(In,Rest) :- match(und,In,Rest).
paarverb(In,Rest) :- match(miteinander,In,Rest); match(zusammen,In,Rest).

beziehung(P1,P2,In,Rest) :- 
(verheiratet(P1,P2), match(verheiratet,In,Rest)).

sindSatz(In,Rest) :- 
numerus(In,R1), person(P1,R1,R2), aufzaehler(R2,R3), 
person(P2,R3,R4), paarverb(R4,R5), beziehung(P1,P2,R5,Rest).
frage(In,Rest) :- sindSatz(In,Rest).
