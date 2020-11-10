
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