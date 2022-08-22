
-- Display all countries with their capitals
SELECT ct.Name AS "Країна", cp.Name AS "Столиця" 
FROM Country ct
JOIN Capital cp ON ct.CountryId = cp.CountryId

-- Display all countries with their nations
SELECT c.Name AS "Країна", n.Name AS "Нація" FROM Nation n
JOIN NationCountry nc ON nc.NationId = n.NationId
JOIN Country c ON c.CountryId = nc.CountryId

-- Display all historical events whose name starts with the letter 'П'
SELECT * FROM HistoricalEvent
WHERE "Name" LIKE N'п%'  

-- Display all leadings whose name starts with the letter from the range 'К'-'М' and has at least 5 symbols
SELECT * FROM Leading
WHERE "Name" LIKE N'[К-М]____%'

-- Display all historical events whose year of begin is between 1660 and 1770, inclusive
SELECT * FROM HistoricalEvent
WHERE YEAR(StartDate) BETWEEN 1660 AND 1770

-- Display all historical events whose year of end is between Jan 1, 1600 and Apr 25, 1800
SELECT * FROM HistoricalEvent
WHERE EndDate BETWEEN '1600-01-01' AND '1800-04-25'

-- Display the minimum and maximum date of the event from the Reform table 
SELECT MIN(EventDate) AS "min_date", 
MAX(EventDate) AS "max_date" FROM Reform

-- Display the number of entries in the Nation table where year of origin is less than 1600 
SELECT COUNT(*) AS "cnt" FROM Nation
WHERE YEAR(StartDateExistence)<1600

-- Display the name of countries and the number of their historical periods
SELECT c."Name", COUNT(*) AS "cnt" FROM Country c
JOIN HistoricalPeriodCountry h ON 
h.CountryId=c.CountryId
GROUP BY c."Name"

-- Display the name of countries and the number of the reforms that they carried out
SELECT c."Name", COUNT(*) AS "cnt" FROM Country c
JOIN ReformCountry rc ON 
rc.ReformId=c.CountryId
GROUP BY c."Name"

-- Display the name of countries that had only one capital
SELECT "Name" FROM Country
WHERE "Name" = ANY
(SELECT ct.Name FROM Country ct
JOIN Capital cp ON ct.CountryId=cp.CountryId
GROUP BY ct.Name
HAVING COUNT(*)=1)

-- Display the identifiers of countries that have the historical periods with the year of beginning date equals 1558
SELECT CountryId FROM Country 
WHERE CountryId = ALL (
SELECT CountryId FROM HistoricalPeriodCountry hpc
JOIN HistoricalPeriod hp ON hp.HistoricalPeriodId = hpc.HistoricalPeriodId
WHERE YEAR(StartDate) = 1558
)

-- Display all countries whose name of capital contains the letter 'a'
SELECT * FROM Country ct
WHERE ct.CountryId IN
(SELECT CountryId FROM Capital cp
WHERE ct.CountryId=cp.CountryId AND 
cp.Name LIKE N'%а%')


-- Display all countries whose historical period took place within the 17th century
SELECT c.Name FROM Country c
WHERE c.CountryId IN
(SELECT CountryId FROM HistoricalPeriod hp
JOIN HistoricalPeriodCountry hpc 
ON hpc.HistoricalPeriodId=hp.HistoricalPeriodId
WHERE hpc.CountryId=c.CountryId AND 
YEAR(hp.StartDate)>=1600 AND YEAR(hp.EndDate)<=1700)


-- Display the names of all historical figures whose date of ativity is not within the 1600s - 1700s
SELECT "Name" FROM HistoricalFigure
WHERE (YEAR(StartDateActivity) NOT BETWEEN 1600 AND 1700)
AND (YEAR(EndDateActivity) NOT BETWEEN 1600 AND 1700)


-- Display all the names of nations that have already ceased to exist
SELECT "Name" FROM Nation
WHERE EndDateExistence IS NOT NULL


-- Display all the names of nations that have already ceased to exist and which have not yet
SELECT "Name", N'Припинили своє існування' AS "exist" FROM Nation
WHERE EndDateExistence IS NOT NULL
UNION
SELECT "Name", N'Не припинили своє існування' AS "exist" FROM Nation
WHERE EndDateExistence IS NULL

-- Display all the names of the reforms that were conducted in the 1500s, 1700s and 1800s 
SELECT "Name", N'1500-ті роки' AS "Years" FROM Reform
WHERE YEAR(EventDate)>=1500 AND YEAR(EventDate)<1600
UNION
SELECT "Name", N'1700-ті роки' AS "Years" FROM Reform
WHERE YEAR(EventDate)>=1700 AND YEAR(EventDate)<1800
UNION
SELECT "Name", N'1800-ті роки' AS "Years" FROM Reform
WHERE YEAR(EventDate)>=1800 AND YEAR(EventDate)<1900


-- Increment year of date existance of capital fot country that began its existance in 1993 in the month of January
UPDATE Capital
SET StartYear = StartYear+1
WHERE CountryId IN (
SELECT CountryId FROM Country
WHERE YEAR(StartDate)=1993 AND MONTH(StartDate)=1)


-- Add 2 monthes to the date of the end of reign of the leading whose country has a 'Президентсько-парламентська республіка' as a type of governing  
UPDATE Leading
SET EndDateReign = DATEADD(MONTH, 2, EndDateReign)
WHERE CountryId IN (
SELECT CountryId FROM Country
WHERE TypeGoverning = N'Президентсько-парламентська республіка')


