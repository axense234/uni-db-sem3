-- some db

-- all missions with diff lvl > 5
SELECT * FROM Missions WHERE difficulty > 5

-- names, descs, diff lvl 1-7
-- SELECT [name], [desc] from Missions WHERE difficulty >= 1 AND difficulty <= 7
SELECT [name], [desc] from Missions WHERE difficulty BETWEEN 1 AND 7

-- spy ids with an undercover task for mission 100
-- eliminate dups
SELECT DISTINCT Spies.id, Spies.real_name FROM Spies, Tasks WHERE Tasks.undercover = 1 and Spies.id = Tasks.spy_id


-- aliases
SELECT DISTINCT Spies.id, Spies.real_name FROM Spies S, Tasks T WHERE T.undercover = 1 and S.id = T.spy_id

-- select all spies where their names start with a and contains at least 4 chars
-- compute their bmi and if they are over 18 or not

SELECT over18 = age - 18, weight/(height * height) AS BMI,
age * 2
FROM Spies S
WHERE S.codeName LIKE 'A___%' 

-- set operations (UNION, INTERSECT, EXCEPT)

-- ids of the spies which are older than 20 and have a task assigned for mission 100

SELECT S.id from Spies S
WHERE S.age > 20
UNION
SELECT T.spyId from Tasks T
WHERE T.mid = 100


-- ids of the spies who have a task assigned in an online mission and another task assigned to mission 100
SELECT T.spyId
FROM Missions M, Tasks T
WHERE M.location = 'ONLINE' AND M.mid = T.mid
INTERSECT
SELECT Tasks.spyId
FROM Tasks
WHERE Tasks.mid = 100


-- in, exists, any, all
-- find the real names of the spies who have not been assigned a task for mission with id 200
SELECT RealName FROM Spies S
WHERE id NOT IN (
	SELECT T.spyId FROM Tasks T
	WHERE T.mid = 200
)

SELECT RealName FROM Spies S
WHERE NOT EXISTS (
	SELECT spyId FROM Tasks T
	WHERE T.mid = 200 AND S.id = T.spyId
)


-- find all spies who are older than some spy named Alex
SELECT * FROM Spies S1
WHERE S.age > ANY (SELECT age FROM Spies S2 WHERE S2.codeName LIKE '%Alex%')

-- find the spies who have the age greater than all the spies named Alex
SELECT * FROM Spies S1
WHERE S.age > ALL (SELECT age FROM Spies S2 WHERE S2.codeName = 'Alex')


-- joins
-- innerjoin (INNER JOIN ... ON ...)
-- left outer join (LEFT OUTER JOIN ... ON ...)
-- right outer join (RIGHT OUTER JOIN ... ON ...)
-- full outer join (FULL OTER JOIN ... ON ...)


-- aggregation operators:
-- COUNT (*)
-- COUNT (A)
-- SUM/AVG/ ([DISTINCT] A)
-- MIN (A)
-- MAX (A)


SELECT COUNT(DISTINCT location)*3
from Missions

-- find the description of the most difficult mission
SELECT * FROM Missions
WHERE difficulty = (SELECT MAX(difficulty) from Missions)