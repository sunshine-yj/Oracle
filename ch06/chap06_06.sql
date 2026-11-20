SELECT emp.years,
CASE WHEN emp.amount_sold = sale.max_sold THEN '최대' ELSE '최소' END AS 구분,
        emp.employee_id,
        e.emp_name,
        emp.amount_sold
FROM ( SELECT SUBSTR(s.sales_month, 1, 4) AS years,
        s.employee_id,
        SUM(s.amount_sold) AS amount_sold
        FROM sales s, customers c, countries cn
        WHERE s.cust_id = c.cust_id
        AND c.country_id = cn.country_id
        AND cn.country_name = 'Italy'
        GROUP BY SUBSTR(s.sales_month, 1, 4), s.employee_id ) emp,
        ( SELECT years,
        MAX(amount_sold) AS max_sold,
        MIN(amount_sold) AS min_sold
        FROM ( SELECT SUBSTR(s.sales_month, 1, 4) AS years,
                s.employee_id,
                SUM(s.amount_sold) AS amount_sold
                FROM sales s, customers c, countries cn
                WHERE s.cust_id = c.cust_id
                AND c.country_id = cn.country_id
                AND cn.country_name = 'Italy'
                GROUP BY SUBSTR(s.sales_month, 1, 4), s.employee_id )
        GROUP BY years 
        ) sale,
       employees e
WHERE emp.years = sale.years
AND (emp.amount_sold = sale.max_sold OR emp.amount_sold = sale.min_sold)
AND emp.employee_id = e.employee_id
ORDER BY emp.years, 구분;