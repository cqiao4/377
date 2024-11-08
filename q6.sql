-- THIS WORK WAS MY (OUR) OWN WORK. IT WAS WRITTEN WITHOUT CONSULTING
-- WORK WRITTEN BY OTHER STUDENTS OR COPIED FROM ONLINE RESOURCES.
-- Iris Qiao
SET search_path TO dimeDB;
CREATE VIEW Never AS(
(SELECT "bonica.rid"
FROM Vote
WHERE "sponsor" = 1 ) 
EXCEPT
(SELECT "bonica.rid"
FROM Vote 
WHERE "sponsor" = 1 AND "vote.choice" = 6));

SELECT Never."bonica.rid", Vote.party, COUNT(*) AS numbills
FROM Never JOIN Vote
ON Never."bonica.rid" = Vote."bonica.rid"
WHERE "sponsor" = 1
GROUP BY Never."bonica.rid", Vote.party 
ORDER BY numbills DESC;

