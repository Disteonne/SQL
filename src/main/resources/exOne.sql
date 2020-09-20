//Первый пошел
CREATE TABLE one(
name VARCHAR(20),
last_name VARCHAR(20);
);

________________________________
ПЕРЕКРЕСТНОЕ СОЕДИНЕНИЕ
SELECT t.name_toy , b.name_boy  ИМЯ_ТАБЛ.ИМЯ_СТОЛБЦА
FROM toy AS t
CROSS JOIN
boys AS b;
________________________________
ВНУТРЕННЕЕ СОЕДИНЕНИЕ
ЭКВИВАЛЕНТНОЕ

SELECT boys.boy,toys.toy
FROM boys
INNER JOIN
toys
ON (WHERE) boys.toy_id=toys.toy_id;
____________     _______________
SELECT my_cont.email,prof.prof
FROM my_cont
INNER JOIN
prof
WHERE (ON) my_cont.prof_id=prof.prof_id;
____________     _______________
SELECT my_cont.first_name,my_cont.last_name,status.status
FROM my_cont
INNER JOIN
status
ON my_cont.status_id=status.status_id;
____________     _______________
НЕЭКВИВАЛЕНТНОЕ СОЕДИНЕНИЕ

SELECT boys.boy,toys.toy
FROM boys
INNER JOIN
toys
ON boys.toy_id<> toys.toy_id;
____________     _______________
ЕСТЕСТВЕННОЕ СОЕДИНЕНИЕ
SELECT boys.boy,toys.toy
FROM boys
NATURAL JOIN
toys;
________________________________