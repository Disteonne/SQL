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
SELECT boys.boy,toys.toy
FROM boys
INNER JOIN
toys
ON (WHERE) boys.toy_id=toys.toy_id;
________________________________


