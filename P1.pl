regnet(dresden), regnet(pirna), regnet(meissen).
straße(hochschulstraße,dresden), straße(schloßstraße,pirna).
(straße(Y,X),nass(Y)) :- (stadt(X),regnet(X)).