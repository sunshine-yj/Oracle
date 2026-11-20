SELECT department_id,
       SUBSTR(MAX(SYS_CONNECT_BY_PATH(emp_name, ',')), 2) AS empnames
FROM ( SELECT emp_name,
            department_id,
            ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY emp_name) AS rn
        FROM employees
        WHERE department_id IS NOT NULL )
START WITH rn = 1
CONNECT BY PRIOR rn = rn - 1
AND PRIOR department_id = department_id
GROUP BY department_id
ORDER BY department_id;