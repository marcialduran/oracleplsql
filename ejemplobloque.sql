DECLARE
-- la variable pueden ser cualquiera seguido de tabla.nombre de columna 
--%TYPE es usado cuando usted se refiere son las columnas individuales
pcountry_id countries.country_id%TYPE;
pcountry_name countries.country_name%TYPE;
pregion_id countries.region_id%TYPE;

BEGIN
      SELECT country_id,country_name,region_id 
      INTO pcountry_id,pcountry_name,pregion_id 
      FROM countries 
      WHERE COUNTRY_id = 'AR';
dbms_output.put_line(pcountry_id || '-' ||pcountry_name|| '-'||pregion_id);

exception
when no_data_found then
    RAISE_APPLICATION_ERROR(-20000,'Error no hay datos ');
when OTHERS then
    RAISE_APPLICATION_ERROR(-20000, 'Error de codigo '); 

END;