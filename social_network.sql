--1
SELECT h1.name
FROM highschooler h1, highschooler h2, friend 
WHERE friend.id1 =h1.id AND friend.id2 = h2.id AND h2.name = 'Gabriel';

--2
SELECT h1.name, h1.grade, h2.name, h2.grade
FROM likes, highschooler h1, highschooler h2
WHERE likes.id1 = h1.id AND likes.id2 = h2.id AND h1.grade -h2.grade >= 2;

--3
SELECT h1.name, h1.grade, h2.name, h2.grade
FROM likes l1, likes l2, highschooler h1, highschooler h2
WHERE l1.id1 = h1.id AND l1.id2 = h2.id AND l1.id2 =l2.id1 AND h1.name < h2.name
AND l1.id1 = l2.id2
ORDER BY h1.name;

--4
SELECT name, grade
FROM highschooler
WHERE NOT EXISTS (SELECT * FROM likes WHERE likes.id1 = highschooler.id OR likes.id2 = highschooler.id); 

--5
SELECT h1.name, h1.grade, h2.name, h2.grade
FROM likes, highschooler h1, highschooler h2
WHERE likes.id1 =h1.id AND likes.id2 = h2.id
AND h2.id NOT IN (SELECT id1 FROM likes);

--6
SELECT DISTINCT h1.name, h1.grade
FROM friend f1, highschooler h1, highschooler h2
WHERE h1.id = f1.id1 AND h2.id =f1.id2 AND h1.grade = h2.grade
AND NOT EXISTS (SELECT * FROM friend f2, highschooler h3 WHERE f2.id2 = h3.id AND h1.grade != h3.grade AND f2.id1 = h1.id)
ORDER BY h1.grade, h1.name;

--7
SELECT h1.name, h1.grade, h2.name, h2.grade, h3.name, h3.grade
FROM likes, highschooler h1, highschooler h2, friend f1, friend f2, highschooler h3
WHERE likes.id1 = h1.id AND likes.id2= h2.id AND h1.id = f1.id1 AND f1.id2 = f2.id1 AND f2.id2 = h2.id AND h3.id = f2.id1
AND likes.id1 NOT IN (SELECT id1 FROM friend WHERE id2 =likes.id2);

--8
SELECT DISTINCT (SELECT COUNT(*) FROM highschooler) - 
(SELECT COUNT(DISTINCT(name))
FROM highschooler)
FROM highschooler;


