SET SERVEROUTPUT ON
DECLARE

CURSOR  C_ORIGEN IS
        SELECT * FROM ARINDA2;
   


          
BEGIN
      FOR R_ORIGEN IN C_ORIGEN LOOP
      
      INSERT INTO ARINDA1 (SELECT * FROM ARINDA2);
      -- DELETE arindamerge WHERE CODIGO=R_ORIGEN.CODIGO; 
      -- funciona elimina
           
      END LOOP;
EXCEPTION
 when no_data_found then
    DBMS_OUTPUT.PUT_LINE ('SE PUEDE INSERTAR TODO');
      


END;