-- en este caso podemos devolver mas de un registro
-- usamos el FOR en vez de usar el OPEN - FETCH

-- Buscas los empleados que pertenecen al Department_id 60 y los muestra 
DECLARE

CURSOR ID_EMPLEADO IS
SELECT first_name,last_name,salary
          FROM EMPLOYEES
          WHERE department_id=60 ;
  BEGIN   
     FOR REMPLOYEES IN ID_EMPLEADO LOOP
      
      DBMS_OUTPUT.PUT_LINE('Nombre : '||REMPLOYEES.first_name    || '   Apellido :' ||' '||REMPLOYEES.last_name || ' '||'  Salario: ' ||REMPLOYEES.salary);
  
      END LOOP;
  exception 
    when no_data_found then
    DBMS_OUTPUT.PUT_LINE ('Error id no existe');
  
END;