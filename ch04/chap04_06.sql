SELECT cust_id,
       cust_name,
       cust_year_of_birth,
       CASE WHEN age < 10 THEN '10세 미만'
            WHEN age < 20 THEN '10대'
            WHEN age < 30 THEN '20대'
            WHEN age < 40 THEN '30대'
            WHEN age < 50 THEN '40대'
            WHEN age < 60 THEN '50대'
            WHEN age < 70 THEN '60대'
            WHEN age < 80 THEN '70대'
            WHEN age < 90 THEN '80대'
            WHEN age < 100 THEN '90대'
            ELSE '100세 이상'
       END AS 연령대
FROM (SELECT cust_id, cust_name, cust_year_of_birth, 
    TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - cust_year_of_birth AS age 
    FROM customers)
ORDER BY cust_id;