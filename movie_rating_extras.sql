--1
SELECT name
FROM reviewer
WHERE rid IN

(
	SELECT rid FROM rating
WHERE mid = (
	SELECT mid
FROM movie
WHERE title = 'Gone with the Wind'
)
	);
  
  
--2
SELECT name, title, stars
FROM movie, reviewer, rating
WHERE movie.mid = rating.mid AND reviewer.rid = rating.rid
AND director = name;


--3
SELECT title
FROM movie
UNION
SELECT name
FROM reviewer
ORDER BY title;

--4
SELECT title
FROM movie
EXCEPT
SELECT title
FROM movie, rating, reviewer
WHERE movie.mid = rating.mid AND rating.rid = reviewer.rid
AND name = 'Chris Jackson';


--5 
SELECT DISTINCT re1.name, re2.name
FROM rating r1, rating r2, reviewer re1, reviewer re2
WHERE r1.mid = r2.mid AND r1.rid < r2.rid 
AND re1.rid = r1.rid AND re2.rid = r2.rid
ORDER BY re2.name, re1.name;


--6
SELECT name, title, stars
FROM rating, reviewer, movie
WHERE rating.rid = reviewer.rid AND movie.mid =rating.mid
AND stars =
(
SELECT min(stars)
FROM rating
);


--7

SELECT title, AVG(stars)
FROM movie, rating
WHERE movie.mid = rating.mid
GROUP BY title
ORDER BY AVG(stars) DESC, title;

--8

SELECT name
FROM reviewer
WHERE rid IN
(
SELECT DISTINCT rid
FROM rating r1
WHERE 3 <= (SELECT COUNT(*) FROM rating r2 WHERE r1.rid = r2.rid)
);


--9

SELECT title, director
FROM movie m1
WHERE 1 < (SELECT COUNT(*) FROM movie m2 WHERE m1.director = m2.director)
ORDER BY director, title;


--10

SELECT title, AVG(stars)
FROM rating, movie
WHERE rating.mid = movie.mid
GROUP BY title
HAVING AVG(stars) = 
(
SELECT max(avg_stars)
FROM (SELECT mid, AVG(stars) as avg_stars FROM rating
	 group by mid) AS rating_avg

);

--11
SELECT title, AVG(stars)
FROM rating, movie
WHERE rating.mid = movie.mid
GROUP BY title
HAVING AVG(stars) = 
(
SELECT min(avg_stars)
FROM (SELECT mid, AVG(stars) as avg_stars FROM rating
	 group by mid) AS rating_avg
);


--12


SELECT DISTINCT m1.director, m1.title, r1.stars
FROM movie m1, rating r1
WHERE m1.mid = r1.mid AND m1.director IS NOT NULL
AND r1.stars IN (
	
SELECT MAX(r2.stars) 
FROM movie m2, rating r2
WHERE m2.mid = r2.mid
AND m1.director = m2.director
AND m2.director IS NOT NULL
);



