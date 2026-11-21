CREATE TABLE ch09_dept (
    DEPARTMENT_ID NUMBER,
    DEPARTMENT_NAME VARCHAR2(100),
    LEVELS NUMBER
);

CREATE OR REPLACE PROCEDURE my_hier_dept_proc
IS
BEGIN
DELETE ch09_dept;

INSERT INTO ch09_dept (department_id, department_name, levels)
SELECT department_id,
    LPAD(' ', 3 * (LEVEL - 1)) || department_name,
    LEVEL
FROM departments
START WITH parent_id IS NULL
CONNECT BY PRIOR department_id = parent_id;

COMMIT;
END;
/

EXEC my_hier_dept_proc;

SELECT * FROM ch09_dept;