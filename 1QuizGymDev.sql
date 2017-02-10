connect hr/hr

GRANT EXECUTE ON DBMS_RLS TO hr

CREATE TABLE plch_employees (employee_id   INTEGER PRIMARY KEY, 
                              last_name     VARCHAR2 (100) )
--
BEGIN
   INSERT INTO plch_employees
        VALUES (1, 'Apple');

   INSERT INTO plch_employees
        VALUES (2, 'Orange');
COMMIT;
END;
/*La cláusula AUTHID, al ser incluida en programas almacenados, determina con qué 
derechos se ejecutará cada programa sobre los objetos en los que aplica
DEFINER opción es la típica en la cual, cuando se ejecuta un programa, se hace con 
los objetos e información del usuario propietario (owner). */
CREATE OR REPLACE PACKAGE plch_vpd AUTHID DEFINER
IS
   FUNCTION restrict_plch_employees (schema_in VARCHAR2, 
                                     NAME_IN   VARCHAR2)
      RETURN VARCHAR2;
END plch_vpd;

-- se crea el body del package
CREATE OR REPLACE PACKAGE BODY plch_vpd
IS
   FUNCTION restrict_plch_employees (schema_in VARCHAR2, 
                                     NAME_IN   VARCHAR2)
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN (CASE USER WHEN 'HR' THEN '1 = 1' ELSE '1 = 2' END);
   END;
END plch_vpd;

/*Crear y activar la política mendiante DBMS_RLS.ADD_POLICY, indicando la tabla 
en cuestión, así como la función que implementa la política, y en qué operaciones 
se activará dicha política (select, insert, update, delete):
*/
BEGIN
   DBMS_RLS.add_policy (
      object_schema     => 'HR',
      object_name       => 'plch_employees',
      policy_name       => 'plch_only_hr',
      function_schema   => 'HR',
      policy_function   => 'plch_vpd.restrict_plch_employees',
      statement_types   => 'SELECT,UPDATE,DELETE,INSERT',
      update_check      => TRUE);
END;
/
CREATE OR REPLACE FUNCTION plch_last_name_frc1 (employee_id_in IN INTEGER)
   RETURN VARCHAR2
   RESULT_CACHE  AUTHID DEFINER
IS
   l_name   plch_employees.last_name%TYPE;
BEGIN
   SELECT last_name
     INTO l_name
     FROM plch_employees
    WHERE employee_id = employee_id_in;

   RETURN l_name;
END plch_last_name_frc1;
/
CREATE OR REPLACE FUNCTION plch_last_name_frc2 ( employee_id_in   IN INTEGER, 
                                            user_in IN VARCHAR2 DEFAULT USER)
   RETURN VARCHAR2
   RESULT_CACHE AUTHID DEFINER
IS
   l_name   plch_employees.last_name%TYPE;
BEGIN
   SELECT last_name
     INTO l_name
     FROM plch_employees
    WHERE employee_id = employee_id_in;

   RETURN l_name;
END plch_last_name_frc2;
/
CREATE OR REPLACE PACKAGE plch_pkg AUTHID DEFINER
IS
   FUNCTION last_name (employee_id_in IN INTEGER)
      RETURN VARCHAR2;
END plch_pkg;
/
CREATE OR REPLACE PACKAGE BODY plch_pkg
IS
   FUNCTION last_name_frc (employee_id_in   IN INTEGER,
                           user_in          IN VARCHAR2)
      RETURN VARCHAR2
      RESULT_CACHE
   IS
      l_name   plch_employees.last_name%TYPE;
   BEGIN
      SELECT last_name
        INTO l_name
        FROM plch_employees
       WHERE employee_id = employee_id_in;

      RETURN l_name;
   END last_name_frc;

   FUNCTION last_name (employee_id_in IN INTEGER)
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN last_name_frc (employee_id_in, USER);
   END last_name;
END plch_pkg;
/
GRANT SELECT ON plch_employees TO scott
GRANT EXECUTE ON plch_last_name_frc1 TO scott
GRANT EXECUTE ON plch_last_name_frc2 TO scott
GRANT EXECUTE ON plch_pkg TO scott