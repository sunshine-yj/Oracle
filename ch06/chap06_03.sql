SELECT a.employee_id, a.emp_name, b.job_id, b.department_id
FROM employees a, job_history b
WHERE a.employee_id = b.employee_id(+)
    AND b.department_id(+) IN (10, 20);

SELECT a.employee_id, a.emp_name, b.job_id, b.department_id
FROM employees a, job_history b
WHERE a.employee_id = b.employee_id(+)
    AND b.department_id(+) IN (10);