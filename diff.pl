:- [simplify].
diff(F,X,SDF) :- d0(F,X,DF),s(DF,SDF).
d0(X,X,1).
d0(C,X,0) :- atomic(C), C \== X.
d0(-F,X,-DF) :- d0(F,X,DF).
d0(C*F,X,C*DF) :- d0(C,X,0), d0(F,X,DF).
d0(F+G,X,DF+DG) :- d0(F,X,DF), d0(G,X,DG).
d0(F-G,X,DF-DG) :- d0(F,X,DF), d0(G,X,DG).
d0(X^N,X,N*X^N-1) :- d0(X,X,DF).

%(rekursiver Abstiegsparser)