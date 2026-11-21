CREATE OR REPLACE FUNCTION my_last_day ( ps_dt IN VARCHAR2 )
RETURN VARCHAR2
IS
    vd_date DATE;
BEGIN
    vd_date := TO_DATE(ps_dt, 'YYYYMMDD');
    RETURN TO_CHAR(ADD_MONTHS(TRUNC(vd_date, 'MM'), 1) - 1, 'YYYYMMDD');
END;
/

SELECT my_last_day('20261119') AS my_func,
       TO_CHAR(LAST_DAY(TO_DATE('20261119', 'YYYYMMDD')), 'YYYYMMDD') AS oracle_func,
       my_last_day('20240215') AS leap_year
FROM dual;