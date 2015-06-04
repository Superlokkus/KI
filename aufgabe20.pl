:- [idDfs].

adj(X,Y) :- adj0(X,Y); adj0(Y,X).

ort(X) :- member(X,[berlin,dresden]).

adj0([STA,STM,SA,SM,ZA,ZM,Ort1], [STA,STM,SA,SM,ZA,ZM,Ort2]) :-
	number(STA),number(STM),number(SA),number(SM), number(ZA), number(ZM),
	ort(Ort1), ort(Ort2), (SA > 0; SM > 0). %Fahren

adj0([STA,STM,SA,SM,ZA,ZM,Ort], 
	[NSTA,NSTM,NSA,NSM,NZA,NZM,Ort]) :- 
	number(STA),number(STM),number(SA),number(SM), number(ZA), number(ZM),number(NSA),number(NSM),
	start(Ort), 
	(
		STA > 0,
		NSTA is STA -1,
		NSA is SA +1,
		NSM = SM,
		NSTM = STM,
		ZA = NZA,
		ZM = NZM
	),(NSA + NSM) =< 2,
	(NSTA =< NSTM; NSTM =:= 0), (NSA =< NSM; NSM =:=0), (NZA =< NZM; NZM =:=0)
	. %Einsteigen Start A
adj0([STA,STM,SA,SM,ZA,ZM,Ort], 
	[NSTA,NSTM,NSA,NSM,NZA,NZM,Ort]) :- 
	number(STA),number(STM),number(SA),number(SM), number(ZA), number(ZM),number(NSA),number(NSM),
	start(Ort),
	(
		STM > 0,
		NSTM is STM -1,
		NSM is SM +1,
		NSA = SA,
		NSTA = STA,
		ZA = NZA,
		ZM = NZM
	),(NSA + NSM) =< 2,
	(NSTA =< NSTM; NSTM =:= 0), (NSA =< NSM; NSM =:=0), (NZA =< NZM; NZM =:=0). %Einsteigen Start M

adj0([STA,STM,SA,SM,ZA,ZM,Ort], 
	[NSTA,NSTM,NSA,NSM,NZA,NZM,Ort]) :- 
	number(STA),number(STM),number(SA),number(SM), number(ZA), number(ZM),number(NSA),number(NSM),
	ziel(Ort),
	(
		SA > 0,
		NZA is ZA + 1,
		NSA is SA -1,
		NZM = ZM,
		SM  = NSM,
		STA = NSTA,
		STM = NSTM
	), (NSA + NSM) =< 2,
	(NSTA =< NSTM; NSTM =:= 0), (NSA =< NSM; NSM =:=0), (NZA =< NZM; NZM =:=0).
	 			%Aussteigen ziel A
adj0([STA,STM,SA,SM,ZA,ZM,Ort], 
	[NSTA,NSTM,NSA,NSM,NZA,NZM,Ort]) :- 
	number(STA),number(STM),number(SA),number(SM), number(ZA), number(ZM),number(NSA),number(NSM),
	ziel(Ort),
	(
		SM > 0,
		NZM is ZM + 1,
		NSM is SM -1,
		NZM = ZM,
		SM  = NSM,
		STA = NSTA,
		STM = NSTM
	), (NSA + NSM) =< 2,
	(NSTA =< NSTM; NSTM =:= 0), (NSA =< NSM; NSM =:=0), (NZA =< NZM; NZM =:=0).
	 			%Aussteigen ziel M

adj0([STA,STM,SA,SM,ZA,ZM,Ort], 
	[NSTA,NSTM,NSA,NSM,NZA,NZM,Ort]) :- 
	number(STA),number(STM),number(SA),number(SM), number(ZA), number(ZM),number(NSA),number(NSM),
	start(Ort),
	(
		SA > 0,
		NSTA is STA +1,
		NSA is SA -1,
		NSM = SM,
		NSTM = STM,
		ZA = NZA,
		ZM = NZM
	),(NSA + NSM) =< 2,
	(NSTA =< NSTM; NSTM =:= 0), (NSA =< NSM; NSM =:=0), (NZA =< NZM; NZM =:=0). %Aussteigen Start A
adj0([STA,STM,SA,SM,ZA,ZM,Ort], 
	[NSTA,NSTM,NSA,NSM,NZA,NZM,Ort]) :- 
	number(STA),number(STM),number(SA),number(SM), number(ZA), number(ZM),number(NSA),number(NSM),
	start(Ort),
	(
		SM > 0,
		NSTM is STM +1,
		NSM is SM -1,
		NSA = SA,
		NSTA = STA,
		ZA = NZA,
		ZM = NZM
	),(NSA + NSM) =< 2,
	(NSTA =< NSTM; NSTM =:= 0), (NSA =< NSM; NSM =:=0), (NZA =< NZM; NZM =:=0). %Aussteigen Start M

adj0([STA,STM,SA,SM,ZA,ZM,Ort], 
	[NSTA,NSTM,NSA,NSM,NZA,NZM,Ort]) :- 
	number(STA),number(STM),number(SA),number(SM), number(ZA), number(ZM),number(NSA),number(NSM),
	ziel(Ort),
	(
		ZA > 0,
		NZA is ZA - 1,
		NSA is SA +1,
		NZM = ZM,
		SM  = NSM,
		STA = NSTA,
		STM = NSTM
	),(NSA + NSM) =< 2,
	(NSTA =< NSTM; NSTM =:= 0), (NSA =< NSM; NSM =:=0), (NZA =< NZM; NZM =:=0).
	 			%Einsteigen ziel A
adj0([STA,STM,SA,SM,ZA,ZM,Ort], 
	[NSTA,NSTM,NSA,NSM,NZA,NZM,Ort]) :- 
	number(STA),number(STM),number(SA),number(SM), number(ZA), number(ZM),number(NSA),number(NSM),
	ziel(Ort),
	(
		ZM > 0,
		NZM is ZM - 1,
		NSM is SM +1,
		NZM = ZM,
		SM  = NSM,
		STA = NSTA,
		STM = NSTM
	),(NSA + NSM) =< 2,
	(NSTA =< NSTM; NSTM =:= 0), (NSA =< NSM; NSM =:=0), (NZA =< NZM; NZM =:=0).
	 			%Einsteigen ziel M

ziel(dresden).
start(berlin).

%ausgang [3,3,0,0,0,0,berlin] 
%ziel [0,0,0,0,3,3,dresden] 
%solution([3,3,0,0,0,0,berlin],[0,0,0,0,3,3,dresden],X).
%(STA > 0, NSTA is STA -1, NSA is SA +1);
%		(STM > 0, NSTM is STM -1, NSM is SM +1)

% Bedeutung Liste: [Anzahl Autonome StartOrt, Anzahl Finanzminister StartOrt,
% Anz. A. Smart, Anz. FM Smart, Anz. A. Ziel, Anz. FM Ziel, Ort Smart]
solution(Ausgang,Ziel,Path) :- idDfs(Ausgang,Ziel,Path).
