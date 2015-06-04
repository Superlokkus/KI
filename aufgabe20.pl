:- [idDfs].

adj(X,Y) :- adj0(X,Y); adj0(Y,X).

ort(X) :- member(X,[berlin,dresden]).
adj0([STA,STM,SA,SM,ZA,ZM,Ort1], [STA,STM,SA,SM,ZA,ZM,Ort2]) :- 
	ort(Ort1), ort(Ort2), (SA > 0; SM > 0). %Fahren

adj0([STA,STM,SA,SM,ZA,ZM,Ort], [_ is STA-1,_ is STM-1,_ is SA+1,_ isSM+1,ZA,ZM,Ort]) :- 
	STA > 0, STM >0. %Einsteigen Dual Start
adj0([STA,STM,SA,SM,ZA,ZM,Ort], [STA,STM,_ is SA-1,_ is SM-1,_ is ZA+1,_ is ZM+1,Ort]) :- 
	SA >0, SM >0 . %Austeigen Dual Ziel
%adj0([STA,STM,SA,SM,ZA,ZM,Ort], [STA-1,STM-1,SA+1,SM+1,ZA,ZM,Ort]) :- 	 . %Einsteigen


goal([0,0,0,0,3,3,dresden]).
% Bedeutung Liste: [Anzahl Autonome StartOrt, Anzahl Finanzminister StartOrt,
% Anz. A. Smart, Anz. FM Smart, Anz. A. Ziel, Anz. FM Ziel, Ort Smart]
solution(Path) :- Start = [3,3,0,0,0,0,berlin], 
goal(Goal), idDfs(Start,Goal,Path).
 