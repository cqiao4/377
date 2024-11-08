-- THIS WORK WAS MY (OUR) OWN WORK. IT WAS WRITTEN WITHOUT CONSULTING
-- WORK WRITTEN BY OTHER STUDENTS OR COPIED FROM ONLINE RESOURCES.
-- Iris Qiao
SET search_path TO dimeDB;
CREATE VIEW Top AS
(SELECT "bonica.cid", "most.recent.contributor.name" AS donor_name,  
(COALESCE("amount.1980", 0) + 
COALESCE("amount.1982", 0) + 
COALESCE("amount.1984", 0) + 
COALESCE("amount.1986", 0) + 
COALESCE("amount.1988", 0) + 
COALESCE("amount.1990", 0) + 
COALESCE("amount.1992", 0) + 
COALESCE("amount.1994", 0) + 
COALESCE("amount.1996", 0) + 
COALESCE("amount.1998", 0) + 
COALESCE("amount.2000", 0) + 
COALESCE("amount.2002", 0) + 
COALESCE("amount.2004", 0) + 
COALESCE("amount.2006", 0) + 
COALESCE("amount.2008", 0) + 
COALESCE("amount.2010", 0) + 
COALESCE("amount.2012", 0) + 
COALESCE("amount.2014", 0) + 
COALESCE("amount.2016", 0) + 
COALESCE("amount.2018", 0) + 
COALESCE("amount.2020", 0) + 
COALESCE("amount.2022", 0))  AS totalAmount
FROM Contributor
ORDER BY totalAmount DESC
LIMIT 3);

CREATE VIEW Amount AS 
(SELECT Contribution."bonica.cid", Top.donor_name, Contribution."bonica.rid", Contribution."recipient.name", SUM(Contribution.amount) AS amount
FROM Contribution JOIN Top 
ON Contribution."bonica.cid" = Top."bonica.cid" AND Contribution."recipient.type" = 'CAND'
GROUP BY Contribution."bonica.cid", Contribution."bonica.rid", Top.donor_name, Contribution."recipient.name");

CREATE VIEW Maxamount AS
(SELECT "bonica.cid", MAX(amount) AS max_amount
 FROM Amount
 GROUP BY "bonica.cid");

SELECT Top."bonica.cid", Top.donor_name, Amount."bonica.rid", Amount."recipient.name", Maxamount.max_amount
FROM Top LEFT JOIN Amount 
ON Top."bonica.cid" = Amount."bonica.cid"
LEFT JOIN Maxamount
ON Amount."bonica.cid" = Maxamount."bonica.cid"
WHERE Amount.amount =  Maxamount.max_amount OR (Amount.amount IS NULL AND Maxamount.max_amount IS NULL)
ORDER BY donor_name ASC, max_amount DESC;


