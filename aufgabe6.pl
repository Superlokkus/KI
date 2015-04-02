amerikaner(jim).
achsedesboesen(iran).
feindderusa(X) :- achsedesboesen(X).
zentrifuge(skolem1).
besitz(skolem1,iran).
verkauft(X,jim,iran) :- zentrifuge(X), besitz(X,iran).
strafbar(X) :- amerikaner(X),zentrifuge(Y),feindderusa(Z),verkauft(Y,X,Z).