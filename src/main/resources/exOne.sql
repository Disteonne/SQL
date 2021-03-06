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
ВСТРОЕННЫЕ ЗАПРОСЫ

SELECT mc.last_name,mc.first_name,mc.phone
FROM my_cont AS mc
NATURAL INNER
job_des AS jd
WHERE jd.title='Разработчик'
AND jd.salary<105000;
____________     _______________
SELECT mc.last_name,mc.first_name,mc.phone,jc.title
FROM my_cont AS mc
NATURAL INNER
job_des AS jd
WHERE jd.title IN(SELECT title FROM job_list);
____________     _______________
SELECT mc.f_n,mc.l_n,jc.salary
FROM my_cont mc
NATURAL JOIN
job_current jc
WHERE jc.salary>(
SELECT jc.salary
FROM my_cont mc
NATURAL JOIN
job_current jc
WHERE email='andy@mail.ru');

________________________________
ВНЕШНЕЕ ЛЕВОЕ СОЕДИНЕНИЕ

SELECT g.girl,t.toy
FROM girls g  <---ЛЕВАЯ
LEFT OUTER JOIN
toys t <--- ПРАВАЯ
ON girls.toy_id=toys.toy_id;

-Какие данные соотв. таблице girls из табл. toy при условии ON

SELECT g.girl,t.toy
FROM toys t  <---ЛЕВАЯ
LEFT OUTER JOIN
girls g <--- ПРАВАЯ
ON girls.toy_id=toys.toy_id;

-Какие данные соотв. таблице toys из табл. girls при условии ON
____________      _______________
ВНЕШНЕЕ ПРАВОЕ СОЕДИНЕНИЕ

SELECT g.girl,t.toy
FROM girls g  <---ПРАВАЯ
RIGHT OUTER JOIN
toys t <--- ЛЕВАЯ
ON girls.toy_id=toys.toy_id;

-Какие данные соотв. таблице girls из табл. toy при условии ON

SELECT g.girl,t.toy
FROM toys t  <---ПРАВАЯ
RIGHT OUTER JOIN
girls g <--- ЛЕВАЯ
ON girls.toy_id=toys.toy_id;

-Какие данные соотв. таблице toys из табл. girls при условии ON
____________      _______________
СЛЕДУЮЩИЕ ЗАПРОСЫ ИДЕНТИЧНЫ

SELECT g.girl,t.toy
FROM girls g  <---ПРАВАЯ
RIGHT OUTER JOIN
toys t <--- ЛЕВАЯ
ON girls.toy_id=toys.toy_id;

          И

SELECT g.girl,t.toy
FROM toys t  <---ЛЕВАЯ
LEFT OUTER JOIN
girls g <--- ПРАВАЯ
ON girls.toy_id=toys.toy_id;

