SELECT TO_CHAR(hire_date, 'YYYY') AS 입사년도,
    COUNT(*) AS 사원수
FROM employees
GROUP BY TO_CHAR(hire_date, 'YYYY')
ORDER BY 1;