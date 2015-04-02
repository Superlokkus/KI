regnet(dresden). 
regnet(pirna). 
regnet(meissen).
straße(hochschulstraße,dresden). 
straße(schloßstraße,pirna).
nass(Y) :- regnet(X),straße(Y, X).