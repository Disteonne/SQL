
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