:- [aufgabe8].

verwandt0(X,Y) :- kind(X,Y,_Z); kind(X,_Z,Y); 
	bruder(X,Y); schwester(X,Y); enkel(X,Y); onkel(X,Y); tante(X,Y).
verwandt(X,Y) :-  verwandt0(X,Y) ; verwandt0(Y,X).

verheiratet(X,Y) :- kind(_Z,X,Y) ; kind(_Z,Y,X).

person0(X) :- verwandt(X,_Y).

match(X,[X|Rest],Rest).

person(X,[X|Rest],Rest) :- person0(X).

paarverb(In,Rest) :- match(miteinander,In,Rest); 
match(zusammen,In,Rest); In=Rest.
artikel(In,Rest) :- match(ein,In,Rest); match(die,In,Rest); 
match(eine,In,Rest); match(der,In,Rest).
bezugswort(In,Rest) :- match(von,In,Rest).
beziehungswort(B,In,Rest) :- (match(bruder,In,Rest),B=[bruder]);(
match(schwester,In,Rest),B=[schwester]);(
match(verheiratet,In,Rest),B=[verheiratet]);(
match(verwandt,In,Rest),B=[verwandt]).

sindbeziehung(P1,P2,In,Antwort) :- 
(verheiratet(P1,P2), match(verheiratet,In,Rest),append([ja],Rest,Antwort));
(not(verheiratet(P1,P2)), match(verheiratet,In,Rest),append([nein],Rest,Antwort));
(verwandt(P1,P2), match(verwandt,In,Rest),append([ja],Rest,Antwort));
(not(verwandt(P1,P2)), match(verwandt,In,Rest),append([nein],Rest,Antwort));.
istbeziehung(P1,P2,In,Antwort) :-
(bruder(P1,P2), match(bruder,In,Rest),append([ja],Rest,Antwort));
(not(bruder(P1,P2)), match(bruder,In,Rest),append([nein],Rest,Antwort));
(schwester(P1,P2), match(schwester,In,Rest),append([ja],Rest,Antwort));
(not(schwester(P1,P2)), match(schwester,In,Rest),append([nein],Rest,Antwort)).

istSatz(In,Antwort) :- (match(ist,In,R1), person(P1,R1,R2), artikel(R2,R3),
beziehungswort(B,R3,R4), match(von,R4,R5), 
person(P2,R5,R6), istbeziehung(P1,P2,B,Antwort));
(match(ist,In,R1), person(P1,R1,R2), match(mit,R2,R3),
person(P2,R3,R6), sindbeziehung(P1,P2,B,Antwort)).

sindSatz(In,Antwort) :- 
match(sind,In,R1), person(P1,R1,R2), match(und,R2,R3), 
person(P2,R3,R4), paarverb(R4,R5), sindbeziehung(P1,P2,R5,Antwort).

frage(Frage,Antwort) :- sindSatz(Frage,Antwort); istSatz(Frage,Antwort).
