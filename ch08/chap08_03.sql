SET SERVEROUTPUT ON


DECLARE
    vn_max_empno employees.employee_id%TYPE;
BEGIN
    SELECT MAX(employee_id)
    INTO vn_max_empno
    FROM employees;

    INSERT INTO employees (employee_id, emp_name, email, hire_date, department_id)
    VALUES (vn_max_empno + 1, 'Harrison Ford', 'HARRIS', SYSDATE, 50);

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('신규 사원번호: ' || (vn_max_empno + 1));
END;
/

SELECT employee_id, emp_name, email, hire_date, department_id
FROM employees
WHERE emp_name = 'Harrison Ford';