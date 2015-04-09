sohn(robert,wilhelm,frieda).
sohn(thomas,winfried,elke).
sohn(jan,robert,sandra).
sohn(jens,robert,sandra).
sohn(tim,jens,heike).
tochter(sandra,kurt,lisa).
tochter(christine,hans,paula).
tochter(eva,thomas,christine).
tochter(julia,robert,sandra).
tochter(jutta,robert,sandra).
tochter(anne,jan,eva).
tochter(anke,jan,eva).


kind(X,Y,Z) :- sohn(X,Y,Z) ; tochter(X,Y,Z).
bruder(X,Y) :- sohn(X,Z1,Z2), kind(Y,Z1,Z2), X\== Y.
schwester(X,Y) :- tochter(X,Z1,Z2), kind(Y,Z1,Z2), X\== Y.
enkel(EN,E1) :- kind(EN,K1,K2), kind(K1,E1,E2), kind(K2,E1,E2).
onkel(B1,K) :- bruder(B1,E1), kind(K,E1,E2).
tante(B1,K) :- schwester(B1,E1), kind(K,E1,E2).
