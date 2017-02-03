-- Cuando se utiliza el into en el cursor solo devuelve una linea

DECLARE
pfirst_name employees.first_name%type;
plast_name employees.last_name%type;
psalary employees.salary%type;

BEGIN
SELECT first_name,last_name,salary
          into pfirst_name,plast_name,psalary
          FROM EMPLOYEES
          WHERE employee_id =100;
     
     if sql%found then
      
      DBMS_OUTPUT.PUT_LINE('Nombre : '||pfirst_name|| 
                           'Apellido :' ||' '||plast_name || ' '||'Salario: ' ||psalary);
  
      END if;
  exception 
    when no_data_found then
    DBMS_OUTPUT.PUT_LINE ('Error id no existe');
  
END;