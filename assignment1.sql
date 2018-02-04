#IS 362 Assignment 1: SQL and Tableau (Review)
#Part 1. SQL and NULLs
#Part 2. Comparing Performance in Tableau


# How many airplanes have listed speeds? What is the minimum listed speed and the maximum listed speed?
#Ans. Planes listed speed = 23; Min Air Speed = 90; Max Air Speed = 432

SELECT count(speed) AS 'Planes listed speed',
min(speed) AS 'Min Air Speed',
max(speed) AS 'Max Air Speed'
FROM planes;

#What is the total distance flown by all of the planes in January 2013?

SELECT SUM(distance) AS 'Distance by all planes in January 2013'
FROM flights
WHERE year = 2013 AND month = 1;

# What is the total distance flown by all of the planes in January 2013 where the tailnum is missing?

SELECT SUM(distance) AS 'Distance by all planes in January 2013 with No Tail Number'
FROM flights
WHERE year = 2013 AND month = 1 AND tailnum is NULL;

# What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer? (Inner Join)

SELECT planes.manufacturer,SUM(distance)
FROM flights
INNER JOIN planes
ON flights.tailnum = planes.tailnum
WHERE  flights.year = 2013 AND flights.month = 7 AND flights.day = 5
GROUP BY planes.manufacturer;

#What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer? (Left Outer Join)
#
SELECT planes.manufacturer,SUM(distance)
FROM flights
LEFT OUTER JOIN planes
ON flights.tailnum = planes.tailnum
WHERE  flights.year = 2013 AND flights.month = 7 AND flights.day = 5
GROUP BY planes.manufacturer;

# What carrier had the shortest air time in 2013 order by carrier name?
# JetBlue = 30

SELECT  airlines.name, air_time AS 'shortest airtime'
FROM flights
INNER JOIN planes ON flights.tailnum = planes.tailnum
INNER JOIN airlines ON flights.carrier = airlines.carrier
where planes.year = 2013 AND air_time is NOT NULL
ORDER BY air_time ASC limit 10;


#Part 2. Comparing Performance in Tableau

#Plane carrier's longest distance at three NYC airports

SELECT flights.year, planes.model, flights.carrier, flights.tailnum, planes.manufacturer, flights.origin, sum(distance)
INTO OUTFILE  '/Users/Marek/Development/School/IS362CSV/Assignment1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM flights
INNER JOIN planes ON flights.tailnum = planes.tailnum
WHERE planes.year = 2013
group by flights.year, planes.model, flights.carrier, flights.tailnum, planes.manufacturer, flights.origin, distance
order by flights.origin;






















