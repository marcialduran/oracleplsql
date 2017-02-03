-- funcion que eleva numero al cuadrado si es 0 regresa error

CREATE OR REPLACE FUNCTION hr_f_numerocuadrado(n number)
RETURN CHAR
is
numero VARCHAR2(3);

BEGIN
  if n > 0
    then numero:=n**2; 
  elsif n = 0 THEN
      RETURN ('Error numero tiene que ser mayor que cero');
  end if; 
return(nvl(numero,0));
END;



