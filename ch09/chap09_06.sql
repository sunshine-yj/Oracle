SET SERVEROUTPUT ON


CREATE TABLE ch09_departments AS
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, PARENT_ID
FROM DEPARTMENTS;

CREATE OR REPLACE PROCEDURE my_dept_manage_proc ( 
    p_department_id IN ch09_departments.department_id%TYPE,
    p_department_name IN ch09_departments.department_name%TYPE,
    p_parent_id IN ch09_departments.parent_id%TYPE,
    p_flag IN VARCHAR2 )
IS
    vn_emp_cnt NUMBER := 0;
BEGIN
    IF LOWER(p_flag) = 'upsert' THEN
        MERGE INTO ch09_departments a
        USING ( SELECT p_department_id AS department_id,
                      p_department_name AS department_name,
                      p_parent_id AS parent_id
        FROM dual) b
        ON (a.department_id = b.department_id)
        WHEN MATCHED THEN
        UPDATE SET a.department_name = b.department_name,
              a.parent_id = b.parent_id
        WHEN NOT MATCHED THEN
              INSERT (a.department_id, a.department_name, a.parent_id)
              VALUES (b.department_id, b.department_name, b.parent_id);
        DBMS_OUTPUT.PUT_LINE(p_department_id || '번 부서 upsert 완료');

    ELSIF LOWER(p_flag) = 'delete' THEN
        SELECT COUNT(*)
        INTO vn_emp_cnt
        FROM employees
        WHERE department_id = p_department_id;

        IF vn_emp_cnt > 0 THEN
            DBMS_OUTPUT.PUT_LINE('경고: ' || p_department_id || '번 부서에 사원이 ' || vn_emp_cnt || '명 있어 삭제할 수 없습니다.');
            RETURN;
        END IF;

        DELETE ch09_departments
        WHERE department_id = p_department_id;
        DBMS_OUTPUT.PUT_LINE(p_department_id || '번 부서 삭제 완료');
    ELSE
        DBMS_OUTPUT.PUT_LINE('동작 flag는 upsert 또는 delete만 가능합니다.');
    END IF;

    COMMIT;
END;
/

EXEC my_dept_manage_proc(300, '테스트부서', 10, 'upsert');
EXEC my_dept_manage_proc(300, '테스트부서2', 10, 'upsert');
EXEC my_dept_manage_proc(60, NULL, NULL, 'delete');
EXEC my_dept_manage_proc(300, NULL, NULL, 'delete');

SELECT * FROM ch09_departments WHERE department_id IN (60, 300);