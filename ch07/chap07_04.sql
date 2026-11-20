WITH region_sales AS (
    SELECT s.sales_month,
           cn.country_region,
           SUM(s.amount_sold) AS amount_sold
    FROM sales s, customers c, countries cn
    WHERE s.cust_id = c.cust_id
    AND c.country_id = cn.country_id
    GROUP BY s.sales_month, cn.country_region
),
ranked AS ( SELECT sales_month, country_region, amount_sold,
            RANK()OVER (PARTITION BY sales_month ORDER BY amount_sold) AS rnk
            FROM region_sales
)
SELECT sales_month AS 매출월,
       country_region AS "지역(대륙)",
       amount_sold AS 매출금액
FROM ranked
WHERE rnk = 1
ORDER BY sales_month;