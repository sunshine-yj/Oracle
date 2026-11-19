CREATE SEQUENCE ORDERS_SEQ
    INCREMENT BY 1
    START WITH 1000
    MINVALUE 1
    MAXVALUE 99999999
    NOCYCLE
    NOCACHE;


SELECT ORDERS_SEQ.NEXTVAL FROM dual;
SELECT ORDERS_SEQ.NEXTVAL FROM dual;


SELECT sequence_name, min_value, max_value, increment_by, last_number
FROM user_sequences
WHERE sequence_name = 'ORDERS_SEQ';