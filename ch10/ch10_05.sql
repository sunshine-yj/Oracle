SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE ch10_iud_dep_proc ( 
    p_department_id IN ch10_departments.department_id%TYPE,
    p_department_name IN ch10_departments.department_name%TYPE,
    p_flag IN VARCHAR2 )
IS
    vn_emp_cnt NUMBER := 0;
    e_emp_exists EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_emp_exists, -20000);
BEGIN
    IF p_flag = 'I' THEN
        INSERT INTO ch10_departments (department_id, department_name)
        VALUES (p_department_id, p_department_name);
    ELSIF p_flag = 'U' THEN
        UPDATE ch10_departments
        SET department_name = p_department_name
        WHERE department_id   = p_department_id;
    ELSIF p_flag = 'D' THEN
        SELECT COUNT(*)
        INTO vn_emp_cnt
        FROM employees
        WHERE department_id = p_department_id;

        IF vn_emp_cnt > 0 THEN
            RAISE e_emp_exists;
        END IF;

        DELETE ch10_departments
        WHERE department_id = p_department_id;
    END IF;

    COMMIT;

EXCEPTION
    WHEN e_emp_exists THEN
        DBMS_OUTPUT.PUT_LINE('예외코드 ' || SQLCODE || ': ' || p_department_id || '번 부서에 사원이 있어 삭제할 수 없습니다.');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('오류: ' || SQLCODE || ' - ' || SQLERRM);
        ROLLBACK;
END;
/

EXEC ch10_iud_dep_proc (60, NULL, 'D');