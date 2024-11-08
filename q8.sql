-- THIS WORK WAS MY (OUR) OWN WORK. IT WAS WRITTEN WITHOUT CONSULTING
-- WORK WRITTEN BY OTHER STUDENTS OR COPIED FROM ONLINE RESOURCES.
-- Iris Qiao
SET search_path TO dimeDB;
(SELECT 'federal' as level, "contributor.gender", COUNT(*) AS count, AVG(contribution.amount) AS average_amount
FROM Contribution
WHERE seat LIKE 'federal%' AND "contributor.gender" IN ('M', 'F')
GROUP BY "contributor.gender")
UNION
(SELECT 'state' as level, "contributor.gender", COUNT(*) AS count, AVG(contribution.amount) AS average_amount
FROM Contribution
WHERE seat LIKE 'state%' AND "contributor.gender" IN ('M', 'F')
GROUP BY "contributor.gender")
UNION
(SELECT 'local' as level, "contributor.gender", COUNT(*) AS count, AVG(contribution.amount) AS average_amount
FROM Contribution
WHERE seat LIKE 'local%' AND "contributor.gender" IN ('M', 'F')
GROUP BY "contributor.gender")
ORDER BY level DESC, "contributor.gender" ASC;