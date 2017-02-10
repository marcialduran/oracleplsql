SET serveroutput ON
DECLARE
  CURSOR emp_cur
  IS
    SELECT * FROM employees;
    TYPE employees_aat IS TABLE OF employees%rowtype;
    l_employees employees_aat;

BEGIN
    SELECT * BULK COLLECT INTO l_employees
    FROM employees;
    
    dbms_output.put_line(l_employees.count);
    
    FOR indx IN 1 .. l_employees.count
    LOOP
      NULL; --process_employees (l_employees(indx));
    END LOOP;
END;




