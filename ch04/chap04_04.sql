SELECT cust_id,
       cust_name,
       cust_main_phone_number,
       TRANSLATE(cust_main_phone_number, '0123456789', 'acielsfkqm') AS enc_phone_number
FROM customers
ORDER BY cust_id;