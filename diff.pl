%consult(simplify.pl).
diff(X,X,1).
diff(C,X,0) :- atomic(C), C \== X.
diff(-F,X,-DF) :- diff(F,X,DF).
diff(C*F,X,C*DF) :- diff(C,X,0), diff(F,X,DF).
diff(F+G,X,DF+DG) :- diff(F,X,DF), diff(G,X,DG).
diff(F-G,X,DF-DG) :- diff(F,X,DF), diff(G,X,DG).