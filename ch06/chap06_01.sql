SELECT a.employee_id AS 사번,
    a.emp_name AS 사원명,
    c.job_title AS job명칭,
    b.start_date AS job시작일자,
    b.end_date AS job종료일자,
    d.department_name AS job수행부서명
FROM employees a,
    job_history b,
    jobs c,
    departments d
WHERE a.employee_id = b.employee_id
    AND b.job_id = c.job_id
    AND b.department_id = d.department_id
    AND a.employee_id   = 101
ORDER BY b.start_date;