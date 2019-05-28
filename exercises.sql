-- CHALLENGE_1
-- How can you retrieve all the information from the cd.facilities table?

SELECT * FROM cd.facilities;

------------------------------------------------------------------------------------

-- CHALLENGE_2
-- You want to print out a list of all of the facilities and their cost to 
-- members. How would you retrieve a list of only facility names and costs?

SELECT name, membercost
FROM cd.facilities;

------------------------------------------------------------------------------------

-- CHALLENGE_3
-- How can you produce a list of facilities that charge a fee to members?

SELECT * FROM cd.facilities
WHERE membercost > 0;

------------------------------------------------------------------------------------

-- CHALLENGE_4
-- How can you produce a list of facilities that charge a fee to members, 
-- and that fee is less than 1/50th of the monthly maintenance cost? Return 
-- the facid, facility name, member cost, and monthly maintenance of the facilities 
-- in question.

SELECT facid, name, membercost, monthlymaintenance
FROM cd.facilities
WHERE membercost < monthlymaintenance/50;

------------------------------------------------------------------------------------

-- CHALLENGE_5
-- How can you produce a list of all facilities with the word 'Tennis' in their 
-- name?

SELECT * FROM cd.facilities
WHERE name LIKE '%Tennis%';

------------------------------------------------------------------------------------

-- CHALLENGE_6
-- How can you retrieve the details of facilities with ID 1 and 5? Try to do it 
-- without using the OR operator.

SELECT * FROM cd.facilities
WHERE facid IN (1, 5);

------------------------------------------------------------------------------------

-- CHALLENGE_7
-- How can you produce a list of members who joined after the start of September 
-- 2012? Return the memid, surname, firstname, and joindate of the members in question.

SELECT memid, surname, firstname, joindate FROM cd.members
WHERE joindate >= '2012-09-01';

------------------------------------------------------------------------------------

-- CHALLENGE_8
-- How can you produce an ordered list of the first 10 surnames in the members table? 
-- The list must not contain duplicates.

SELECT DISTINCT(surname) FROM cd.members
ORDER BY surname
LIMIT 10;

------------------------------------------------------------------------------------

-- CHALLENGE_9
-- You'd like to get the signup date of your last member. How can you retrieve this 
-- information?

SELECT joindate FROM cd.members
ORDER BY joindate DESC
LIMIT 1;

-- Udemy Alternative Solution
SELECT MAX(joindate) AS latest 
FROM cd.members;

------------------------------------------------------------------------------------

-- CHALLENGE_10
-- Produce a count of the number of facilities that have a cost to guests of 10 or more.

SELECT COUNT(*) FROM cd.facilities
WHERE guestcost >= 10;

-- CHALLENGE_11
-- Produce a list of the total number of slots booked per facility in the month of 
-- September 2012. Produce an output table consisting of facility id and slots, sorted 
-- by the number of slots.

SELECT cd.bookings.facid, SUM(slots) AS total_slots
FROM cd.bookings
JOIN cd.facilities ON cd.facilities.facid = cd.bookings.facid
WHERE starttime BETWEEN '2012-09-01' AND '2012-09-30'
GROUP BY cd.bookings.facid 
ORDER BY total_slots;

-- Udemy Alternative Solution
SELECT facid, SUM(slots) AS "Total Slots" 
FROM cd.bookings 
WHERE starttime >= '2012-09-01' 
AND starttime < '2012-10-01' 
GROUP BY facid 
ORDER BY sum(slots);

-- CHALLENGE_12
-- Produce a list of facilities with more than 1000 slots booked. Produce an output 
-- table consisting of facility id and total slots, sorted by facility id.

SELECT cd.bookings.facid, SUM(slots) AS total_slots
FROM cd.bookings
JOIN cd.facilities ON cd.facilities.facid = cd.bookings.facid
GROUP BY cd.bookings.facid HAVING SUM(slots) > 1000
ORDER BY cd.bookings.facid;

-- CHALLENGE_13
-- How can you produce a list of the start times for bookings for tennis courts, for 
-- the date '2012-09-21'? Return a list of start time and facility name pairings, 
-- ordered by the time.

SELECT cd.facilities.facid, name, starttime
FROM cd.facilities
JOIN cd.bookings ON cd.bookings.facid = cd.facilities.facid
WHERE name ILIKE '%tennis court%'
AND starttime >= date '2012-09-21' 
AND starttime < date '2012-09-22'
ORDER BY starttime;

-- Udemy Alternative Solution
SELECT bks.starttime AS start, facs.name AS name 
FROM cd.facilities facs 
INNER JOIN cd.bookings bks ON facs.facid = bks.facid 
WHERE facs.facid IN (0,1) 
AND bks.starttime >= '2012-09-21' 
AND bks.starttime < '2012-09-22' 
ORDER BY bks.starttime;

-- CHALLENGE_14
-- How can you produce a list of the start times for bookings by members 
-- named 'David Farrell'?

SELECT cd.members.memid, firstname || ' ' || surname AS members, starttime
FROM cd.members
JOIN cd.bookings ON cd.bookings.memid = cd.members.memid
WHERE firstname = 'David' AND surname = 'Farrell';