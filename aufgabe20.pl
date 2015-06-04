:- [idDfs].

adj(X,Y) :- adj0(X,Y); adj0(Y,X).

ort(X) :- member(X,[berlin,dresden]).
adj0([STA,STM,SA,SM,ZA,ZM,Ort1], [STA,STM,SA,SM,ZA,ZM,Ort2]) :-
	number(STA),number(STM),number(SA),number(SM), number(ZA), number(ZM),
	ort(Ort1), ort(Ort2), (SA > 0; SM > 0). %Fahren

adj0([STA,STM,SA,SM,ZA,ZM,Ort], 
	[NSTA,NSTM,NSA,NSM,ZA,ZM,Ort]) :- 
	number(STA),number(STM),number(SA),number(SM), number(ZA), number(ZM),
	STA > 0, STM >0, ort(Ort),
	NSTA is STA-1,NSTM is STM-1,NSA is SA+1,NSM is SM+1. %Einsteigen Dual Start
adj0([STA,STM,SA,SM,ZA,ZM,Ort], 
	[STA,STM,NSA,NSM,NZA,NZM,Ort]) :- 
	number(STA),number(STM),number(SA),number(SM), number(ZA), number(ZM),
	SA >0, SM >0, ort(Ort),
	NSA is SA-1,NSM is SM-1,NZA is ZA+1,NZM is ZM+1. %Austeigen Dual Ziel
%adj0([STA,STM,SA,SM,ZA,ZM,Ort], [STA-1,STM-1,SA+1,SM+1,ZA,ZM,Ort]) :- 	 . %Einsteigen


goal([0,0,0,0,3,3,dresden]).
% Bedeutung Liste: [Anzahl Autonome StartOrt, Anzahl Finanzminister StartOrt,
% Anz. A. Smart, Anz. FM Smart, Anz. A. Ziel, Anz. FM Ziel, Ort Smart]
solution(Path) :- Start = [3,3,0,0,0,0,berlin], 
goal(Goal), idDfs(Start,Goal,Path).
 