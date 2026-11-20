CREATE TABLE ex3_3 (
       employee_id NUMBER,
       bonus_amt   NUMBER DEFAULT 0 
);

DELETE ex3_3;

INSERT INTO ex3_3 (employee_id)
SELECT e.employee_id
FROM employees e, sales s
WHERE e.employee_id = s.employee_id
AND s.SALES_MONTH BETWEEN '200010' AND '200012'
GROUP BY e.employee_id;

COMMIT;

MERGE INTO ex3_3 d
USING (SELECT employee_id, salary, manager_id
FROM employees
WHERE manager_id = 145) b
ON (d.employee_id = b.employee_id)
WHEN MATCHED THEN
UPDATE SET d.bonus_amt = d.bonus_amt + b.salary * 0.01
WHEN NOT MATCHED THEN
INSERT (d.employee_id, d.bonus_amt)
VALUES (b.employee_id, b.salary * 0.005);