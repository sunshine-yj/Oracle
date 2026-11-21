CREATE OR REPLACE PROCEDURE my_new_job_proc2 ( 
    p_job_id IN JOBS.JOB_ID%TYPE,
    p_job_title IN JOBS.JOB_TITLE%TYPE,
    p_min_sal IN JOBS.MIN_SALARY%TYPE,
    p_max_sal IN JOBS.MAX_SALARY%TYPE )
IS
BEGIN
    MERGE INTO jobs a
    USING (SELECT p_job_id AS job_id,
                  p_job_title AS job_title,
                  p_min_sal AS min_sal,
                  p_max_sal AS max_sal
    FROM dual) b
    ON (a.job_id = b.job_id)
    WHEN MATCHED THEN
    UPDATE SET a.job_title = b.job_title,
            a.min_salary = b.min_sal,
            a.max_salary = b.max_sal,
            a.update_date = SYSDATE
    WHEN NOT MATCHED THEN
    INSERT (a.job_id, a.job_title, a.min_salary, a.max_salary, a.create_date, a.update_date)
    VALUES (b.job_id, b.job_title, b.min_sal, b.max_sal, SYSDATE, SYSDATE);

    COMMIT;
END;
/

EXEC my_new_job_proc2('SM_JOB2', 'Sample JOB2', 1000, 5000);
SELECT * FROM jobs WHERE job_id = 'SM_JOB2';

EXEC my_new_job_proc2('SM_JOB2', 'Sample JOB2 수정', 2000, 6000);
SELECT * FROM jobs WHERE job_id = 'SM_JOB2';