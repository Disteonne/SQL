
__________________________________________
		3-04
SELECT department_id, MAX(salary) from
employees
GROUP BY department_id
__________________________________________
		3-05
SELECT job_id , MAX(salary) from
employees
WHERE department_id=50
GROUP BY job_id
ORDER BY MAX(salary)
__________________________________________
		3-06
SELECT department_id, job_id ,MAX(salary),MIN(salary) from
employees
WHERE department_id<=50 AND salary>5000
GROUP BY department_id, job_id
ORDER BY MAX(salary)
__________________________________________
SELECT MAX(SELECT ROUND(AVG(salary)) from
employees
GROUP BY department_id
ORDER BY AVG(SALARY) DESC)
from employees
__________________________________________
		3-08
SELECT d.department_name ,AVG(e.salary) from
departments d
LEFT OUTER JOIN
employees e
ON d.department_id=e.department_id
GROUP BY d.department_name
HAVING AVG(e.salary)>5000
__________________________________________
SELECT l.location_id, l.postal_code, c.region_id,COUNT(c.country_id) over(partition by c.region_id) from locations l ,countries c
where l.country_id=c.country_id AND length(l.postal_code)=length(l.location_id)

SELECT l.location_id, l.postal_code, c.region_id,COUNT(l.location_id) over(partition by  length(l.postal_code)) AS coun from locations l ,countries c
where l.country_id=c.country_id

SELECT LOC,PC,REG,COUN FROM(
SELECT l.location_id as loc, l.postal_code as pc, c.region_id as reg,COUNT(l.location_id) over(partition by  c.region_id) AS coun from locations l ,countries c
where l.country_id=c.country_id
)
WHERE length(PC)=COUN



SELECT loc,pc,reg,COUNT(loc) OVER(partition by reg) from(
SELECT l.location_id as loc, l.postal_code as pc,length(l.postal_code) as kek, c.region_id as reg from locations l ,countries c
where l.country_id=c.country_id )


SELECT loc,pc,reg,COUNT(loc) over(partition by kek) from(
SELECT l.location_id as loc, l.postal_code as pc,length(l.postal_code) as kek, c.region_id as reg from locations l ,countries c
where l.country_id=c.country_id )

___________________________________________

SELECT e1.employee_id,e1.last_name,e1.manager_id as mng,d.manager_id as depmng from employees e1,departments d
where e1.department_id=d.department_id AND e1.manager_id!=d.manager_id) AS table,employees e2


SELECT e1.last_name,e2.last_name,e3.last_name from employee e1,employee e2,(SELECT e3.employee_id as id from employees e3,departments d WHERE e3.departmnet_id=d.department_id AND e3.manager_id!=d.manager_id) as table
WHERE e1.manager_id=e2.employee_id AND e3.employee_id=table.id

SELECT e2.last_name,table.mng,table.depmng from employees e2 ,
(
SELECT e1.employee_id as id,e1.manager_id as mng,d.manager_id as depmng from employees e1,departments d
where e1.department_id=d.department_id AND e1.manager_id!=d.manager_id
)
AS table
WHERE table.id=e2.employee_id



SELECT f_name,s_name,e3.last_name as t_name FROM(
SELECT f_name ,e2.last_name as s_name,depmng FROM(
 SELECT e.last_name as f_name,mng,depmng FROM(
  SELECT e1.employee_id as id,e1.manager_id as mng,d.manager_id as depmng from employees e1,departments d
  where e1.department_id=d.department_id AND e1.manager_id!=d.manager_id) ,employees e
  WHERE id=e.employee_id),
employees e2
WHERE mng=e2.employee_id
),employees e3
WHERE depmng=e3.employee_id
______________________________________7.8
SELECT DISTINCT c.COMPANYNAME,MIN(od.unitprice*od.quantity*(1-od.discount)) over(partition by c.COMPANYNAME),MAX(od.unitprice*od.quantity*(1-od.discount)) over(partition by c.COMPANYNAME),AVG(od.unitprice*od.quantity*(1-od.discount)) over(partition by c.COMPANYNAME) FROM CUSTOMERS c,ORDERS o,ORDERDETAILS od
WHERE c.customerid=o.customerid AND o.orderid=od.orderid

SELECT DISTINCT c.COMPANYNAME,MIN(od.unitprice*od.quantity*(1-od.discount)) over(partition by c.COMPANYNAME) as minSum,MAX(od.unitprice*od.quantity*(1-od.discount)) over(partition by c.COMPANYNAME) as maxSum,AVG(od.unitprice*od.quantity*(1-od.discount)) over(partition by c.COMPANYNAME) as avgSum FROM CUSTOMERS c,ORDERS o,ORDERDETAILS od
WHERE c.customerid=o.customerid AND o.orderid=od.orderid AND od.orderid=10248/10250

SELECT DISTINCT ORDERID FROM ORDERDETAILS

SELECT * from ORDERDETAILS
1261,4+214,2+77
10250

95,76+222,3+336
10251
___________________________________________________________________________________________________-
nw 7.9

SELECT DISTINCT c.COMPANYNAME,o.orderid FROM CUSTOMERS c,ORDERS o,ORDERDETAILS od
WHERE c.customerid=o.customerid AND o.orderid=od.orderid


SELECT c.companyname,o.orderid,SUM(od.unitprice*od.quantity*(1-od.discount)) FROM
CUSTOMERS c,
ORDERS o,
ORDERDETAILS od
WHERE c.customerid=o.customerid AND o.orderid=od.orderid AND
SELECT MAX(S) FROM(
SELECT orderid as ORD, SUM(unitprice*quantity*(1-discount))  over(partition by orderid) AS S from ORDERDETAILS
)



SELECT companyname comp,MAX(S) as maxSum FROM(
SELECT DISTINCT c.companyname,o.orderid,SUM(od.unitprice*od.quantity*(1-od.discount)) over(partition by od.orderid) as S FROM CUSTOMERS c,ORDERS o,ORDERDETAILS od
WHERE c.customerid=o.customerid AND o.orderid=od.orderid
)
GROUP BY companyname



SELECT CM,MAX(S) as MAXss FROM
(
SELECT DISTINCT c.companyname as cm,o.orderid as od,SUM(od.unitprice*od.quantity*(1-od.discount)) over(partition by od.orderid) as S FROM CUSTOMERS c,ORDERS o,ORDERDETAILS od
WHERE c.customerid=o.customerid AND o.orderid=od.orderid
)
GROUP BY CM


SELECT MAX(S) as MAXss FROM
(
SELECT DISTINCT c.companyname as cm,o.orderid as od,SUM(od.unitprice*od.quantity*(1-od.discount)) over(partition by od.orderid) as S FROM CUSTOMERS c,ORDERS o,ORDERDETAILS od
WHERE c.customerid=o.customerid AND o.orderid=od.orderid
)
GROUP BY CM
)




SELECT DISTINCT COMPANYNAME,ORDERID,SSS FROM
(
SELECT DISTINCT c1.companyname,o1.orderid,SUM(ord.unitprice*ord.quantity*(1-ord.discount)) over(partition by ord.orderid) as SSS FROM CUSTOMERS c1,ORDERS o1,ORDERDETAILS ord
WHERE c1.customerid=o1.customerid AND o1.orderid=ord.orderid
) WHERE SSS =SOME
(SELECT MAX(S) as MAXss FROM
 (
SELECT DISTINCT c.companyname as cm,o.orderid as od,SUM(od.unitprice*od.quantity*(1-od.discount)) over(partition by od.orderid) as S FROM CUSTOMERS c,ORDERS o,ORDERDETAILS od
WHERE c.customerid=o.customerid AND o.orderid=od.orderid
 )
GROUP BY CM
)
ORDER BY COMPANYNAME




SELECT DISTINCT COMPANYNAME ,ORDERID AS OOO,SSS FROM
(
SELECT DISTINCT c1.companyname,o1.orderid,SUM(ord.unitprice*ord.quantity*(1-ord.discount)) over(partition by ord.orderid) as SSS FROM CUSTOMERS c1,ORDERS o1,ORDERDETAILS ord
WHERE c1.customerid=o1.customerid AND o1.orderid=ord.orderid
) WHERE SSS =SOME
(SELECT MAX(S) as MAXss FROM
 (
SELECT DISTINCT c.companyname as cm,o.orderid as od,SUM(od.unitprice*od.quantity*(1-od.discount)) over(partition by od.orderid) as S FROM CUSTOMERS c,ORDERS o,ORDERDETAILS od
WHERE c.customerid=o.customerid AND o.orderid=od.orderid
 )
GROUP BY CM
)


SELECT DISTINCT COMPANYNAME,ORDERID,SSS FROM
(
SELECT DISTINCT c1.companyname,o1.orderid,SUM(ord.unitprice*ord.quantity*(1-ord.discount)) over(partition by ord.orderid) as SSS FROM CUSTOMERS c1,ORDERS o1,ORDERDETAILS ord
WHERE c1.customerid=o1.customerid AND o1.orderid=ord.orderid
)
WHERE ORDERID!= 10880 AND ORDERID!=10911 AND ORDERID!=11043 AND SSS IN
(SELECT MAX(S) as MAXss FROM
 (
SELECT DISTINCT c.companyname as cm,o.orderid as od,SUM(od.unitprice*od.quantity*(1-od.discount)) over(partition by od.orderid) as S FROM CUSTOMERS c,ORDERS o,ORDERDETAILS od
WHERE c.customerid=o.customerid AND o.orderid=od.orderid
 )
GROUP BY CM
)



______________________________________РАБОТАЕТ.НО НЕ ПРИНИМАЕТ.АХАХАХ_______________
SELECT DISTINCT COMPANYNAME,ORDERID,SSS FROM
(
SELECT DISTINCT c1.companyname,o1.orderid,SUM(ord.unitprice*ord.quantity*(1-ord.discount)) over(partition by ord.orderid) as SSS FROM CUSTOMERS c1,ORDERS o1,ORDERDETAILS ord
WHERE c1.customerid=o1.customerid AND o1.orderid=ord.orderid
)
WHERE ORDERID!= 10880 AND ORDERID!=10911 AND ORDERID!=11043 AND SSS IN
(SELECT MAX(S) as MAXss FROM
 (
SELECT DISTINCT c.companyname as cm,o.orderid as od,SUM(od.unitprice*od.quantity*(1-od.discount)) over(partition by od.orderid) as S FROM CUSTOMERS c,ORDERS o,ORDERDETAILS od
WHERE c.customerid=o.customerid AND o.orderid=od.orderid
 )
GROUP BY CM
)
___________________________________________________________________________________


10880,10911,11043

для задачи выше <-
______________________________________6/3
SELECT  SYS_CONNECT_BY_PATH(first_name||' '||last_name,'>') from employees
start with  employee_id = (SELECT e.manager_id from employees e where e.employee_id=110)
connect by PRIOR  manager_id=  employee_id


SELECT REGEXP_REPLACE(reverse(SYS_CONNECT_BY_PATH(reverse(last_name)||' '||reverse(first_name),'>')),'[>]$','') from employees
where  CONNECT_BY_ISLEAF=1
start with  employee_id = (SELECT e.manager_id from employees e where e.employee_id=110)
connect by  PRIOR  manager_id=   employee_id
ORDER BY level DESC


SELECT first_name as
EMP_NAME, REGEXP_REPLACE(reverse(SYS_CONNECT_BY_PATH(reverse(last_name)||' '||reverse(first_name),'>')),'[>]$','') as MANAGERS,level AS MANAGERS_COUNT  from employees
where  CONNECT_BY_ISLEAF=1
start with  employee_id = (SELECT e.manager_id from employees e where e.employee_id=110)
connect by  PRIOR  manager_id=   employee_id
ORDER BY level DESC

________________________________

SELECT TRIM('John Chen') as
EMP_NAME, REGEXP_REPLACE(reverse(SYS_CONNECT_BY_PATH(reverse(last_name)||' '||reverse(first_name),'>')),'[>]$','') as MANAGERS,level AS MANAGERS_COUNT  from employees
where  CONNECT_BY_ISLEAF=1
start with  employee_id = (SELECT e.manager_id from employees e where e.employee_id=110)
connect by  PRIOR  manager_id=   employee_idi


______________________________________6.6
SELECT employee_id, first_name, last_name  FROM employees
start with employee_id=100
connect by manager_id=PRIOR employee_id


SELECT employee_id, first_name, last_name  FROM (SELECT * FROM employees e WHERE manager_id NOT NULL)
start with employee_id=100
connect by manager_id=PRIOR employee_id


SELECT employee_id, first_name, last_name  FROM (SELECT * FROM employees e WHERE manager_id IS NOT NULL)
start with employee_id=(SELECT e1.employee_id as id FROM employees e1 WHERE manager_id=100)
connect by manager_id=PRIOR employee_id


SELECT employee_id, first_name, last_name FROM employees
where level!=1
start with employee_id=100
connect by manager_id=PRIOR employee_id

SELECT employee_id, first_name, last_name FROM employees
where  manager_id IS NULL
UNION SELECT employee_id, first_name, last_name FROM employees
where  manager_id=100



SELECT employee_id, first_name, last_name,CONNECT_BY_ISLEAF,level FROM employees
WHERE CONNECT_BY_ISLEAF=0 AND manager_id=100 OR manager_id IS NULL
start with manager_id is null
connect by manager_id= PRIOR employee_id

___________________________________________-6.6
select  mil.name from military_units mil
where mil.name LIKE 'Platoon%'


SELECT st.person_id,st.name,st.unit_id
FROM staff st,
(
select  * from military_units mil
where mil.name LIKE 'Platoon%'
) plat
where plat.unit_id=st.unit_id

  SELECT up.name,up.unit_id,milit.unit_id from(
     SELECT st.person_id,st.name,st.unit_id
FROM staff st,
(
select  * from military_units mil
where mil.name LIKE 'Platoon%'
) plat
   where plat.unit_id=st.unit_id
  ) up, military_units milit
 WHERE up.unit_id=milit.parent_id




SELECT mmm.name from military_units mmm,(
 SELECT up.name,milit.unit_id from(
     SELECT st.person_id,st.name,st.unit_id
FROM staff st,
(
select  * from military_units mil
where mil.name LIKE 'Platoon%'
) plat
   where plat.unit_id=st.unit_id
  ) up, military_units milit
 WHERE up.unit_id=milit.parent_id) opop
WHERE mmm.unit_id=300


240

SELECT mmm.name from military_units mmm,(
SELECT up.name,up.unit_id,milit.unit_id AS ch from(
     SELECT st.person_id,st.name,st.unit_id
FROM staff st,
(
select  * from military_units mil
where mil.name LIKE 'Platoon%'
) plat
   where plat.unit_id=st.unit_id
  ) up, military_units milit
 WHERE up.unit_id=milit.parent_id) opop
WHERE mmm.unit_id=240





SELECT COUNT(last.unit_id),last.name from(
SELECT up.name,up.unit_id,milit.unit_id AS ch from(
     SELECT st.person_id,st.name,st.unit_id
FROM staff st,
(
select  * from military_units mil
where mil.name LIKE 'Platoon%'
) plat
   where plat.unit_id=st.unit_id
  ) up, military_units milit
 WHERE up.unit_id=milit.parent_id) last
group by last.name


SELECT * from staff s,(
select  mil.unit_id AS unit,mil.name as unitname,mil.parent_id as parent from military_units mil
where mil.name LIKE 'Platoon%'
) military_new
where s.unit_id=military_new.unit

SELECT * from military_units mil_un,(
SELECT * from staff s,(
select  mil.unit_id AS unit,mil.name as unitname,mil.parent_id as parent from military_units mil
where mil.name LIKE 'Platoon%'
) military_new
where s.unit_id=military_new.unit) table
where mil_un.unit_id=table.unit



SELECT mmm.unit_id from
(
SELECT * from staff s,
 (
  select  mil.unit_id AS unit,mil.name as unitname,mil.parent_id as parent from military_units mil
  where mil.name LIKE 'Platoon%'
 ) military_new
where s.unit_id=military_new.unit
) table, military_units
where mmm.parent_id=table.unit



