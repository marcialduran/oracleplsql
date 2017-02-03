-- 2 CURSORES PARA AGRUPAR LOS EMPLEADOS CON IGUAL JOB_ID

DECLARE

CURSOR C_DEPARTMENT_ID IS
      SELECT DISTINCT job_id
      FROM EMPLOYEES;

CURSOR ID_EMPLEADO (PJOB_ID VARCHAR2) IS
SELECT first_name,last_name,salary
          FROM EMPLOYEES
          WHERE JOB_ID=PJOB_ID ;
  BEGIN   
      FOR R_DEPARTMENT_ID IN C_DEPARTMENT_ID LOOP
      DBMS_OUTPUT.PUT_LINE ( '');
      DBMS_OUTPUT.PUT_LINE ( R_DEPARTMENT_ID.JOB_ID );
      FOR REMPLOYEES IN ID_EMPLEADO(R_DEPARTMENT_ID.JOB_ID) LOOP  
      DBMS_OUTPUT.PUT_LINE('Nombre : '||REMPLOYEES.first_name    || '   Apellido :' ||' '||REMPLOYEES.last_name || ' '||'  Salario: ' ||REMPLOYEES.salary);
  
      END LOOP;
    END LOOP;
  exception 
    when no_data_found then
    DBMS_OUTPUT.PUT_LINE ('Error id no existe');
  
END;