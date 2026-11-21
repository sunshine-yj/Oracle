CREATE OR REPLACE FUNCTION my_initcap ( ps_str IN VARCHAR2 )
    RETURN VARCHAR2
    IS
    vs_temp VARCHAR2(4000) := ps_str;
    vs_ret  VARCHAR2(4000);
    vn_pos  NUMBER;
BEGIN
    LOOP
        EXIT WHEN vs_temp IS NULL;
        vn_pos := INSTR(vs_temp, ' ');

        IF vn_pos = 0 THEN
            vs_ret := vs_ret || UPPER(SUBSTR(vs_temp, 1, 1)) || LOWER(SUBSTR(vs_temp, 2));
            EXIT;
        ELSE
            vs_ret  := vs_ret || UPPER(SUBSTR(vs_temp, 1, 1)) || LOWER(SUBSTR(vs_temp, 2, vn_pos - 1));
            vs_temp := SUBSTR(vs_temp, vn_pos + 1);
        END IF;
    END LOOP;
    RETURN vs_ret;
END;
/

SELECT my_initcap('hello oracle pl/sql world') AS my_func,
INITCAP('hello oracle pl/sql world')    AS oracle_func
FROM dual;