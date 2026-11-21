SET SERVEROUTPUT ON

DECLARE
    vn_base_num NUMBER := 3;
BEGIN
    FOR i IN 1..9
    LOOP
        DBMS_OUTPUT.PUT_LINE(vn_base_num || ' * ' || i || ' = ' || vn_base_num * i);
    END LOOP;
END;
/