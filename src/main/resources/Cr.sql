
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