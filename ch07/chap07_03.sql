WITH basis AS (
    SELECT TRUNC((TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - c.cust_year_of_birth) / 10) * 10 AS age_grp,
           s.amount_sold
    FROM sales s, customers c
    WHERE s.cust_id = c.cust_id
    AND s.sales_month = '200112'
)
SELECT age_grp || '대' AS 연령대,
       SUM(amount_sold) AS 매출금액
FROM basis
GROUP BY age_grp
ORDER BY age_grp;