SET SERVEROUTPUT ON

CREATE TABLE ch10_departments
AS
SELECT department_id, department_name
FROM departments;

ALTER TABLE ch10_departments ADD CONSTRAINTS pk_ch10_departments PRIMARY KEY (department_id);

CREATE OR REPLACE PROCEDURE ch10_iud_dep_proc ( 
    p_department_id IN ch10_departments.department_id%TYPE,
    p_department_name IN ch10_departments.department_name%TYPE,
    p_flag IN VARCHAR2 )
IS
BEGIN
    IF p_flag = 'I' THEN
        INSERT INTO ch10_departments (department_id, department_name)
        VALUES (p_department_id, p_department_name);
    ELSIF p_flag = 'U' THEN
        UPDATE ch10_departments
        SET department_name = p_department_name
        WHERE department_id = p_department_id;
    ELSIF p_flag = 'D' THEN
        DELETE ch10_departments
        WHERE department_id = p_department_id;
    END IF;

    COMMIT;
END;
/

EXEC ch10_iud_dep_proc(300, '신규부서', 'I');
EXEC ch10_iud_dep_proc(300, '신규부서(수정)', 'U');
SELECT * FROM ch10_departments WHERE department_id = 300;
EXEC ch10_iud_dep_proc(300, NULL, 'D');
SELECT * FROM ch10_departments WHERE department_id = 300;