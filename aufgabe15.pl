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
paarverb(In,Rest) :- match(miteinander,In,Rest); 
match(zusammen,In,Rest); In=Rest.
artikel(In,Rest) :- match(ein,In,Rest); match(die,In,Rest); 
match(eine,In,Rest); match(der,In,Rest).
bezugswort(In,Rest) :- match(von,In,Rest).

beziehung(P1,P2,In,Antwort) :- 
(verheiratet(P1,P2), match(verheiratet,In,Rest),append([ja],Rest,Antwort));
(not(verheiratet(P1,P2)), match(verheiratet,In,Rest),append([nein],Rest,Antwort));
(verwandt(P1,P2), match(verwandt,In,Rest),append([ja],Rest,Antwort));
(not(verwandt(P1,P2)), match(verwandt,In,Rest),append([nein],Rest,Antwort));
(bruder(P1,P2), match(bruder,In,Rest),append([ja],Rest,Antwort));
(not(bruder(P1,P2)), match(bruder,In,Rest),append([nein],Rest,Antwort));
(schwester(P1,P2), match(schwester,In,Rest),append([ja],Rest,Antwort));
(not(schwester(P1,P2)), match(schwester,In,Rest),append([nein],Rest,Antwort)).

%istSatz(In,Rest) :- 

sindSatz(In,Antwort) :- 
numerus(In,R1), person(P1,R1,R2), aufzaehler(R2,R3), 
person(P2,R3,R4), paarverb(R4,R5), beziehung(P1,P2,R5,Antwort).

frage(Frage,Antwort) :- sindSatz(Frage,Antwort).
