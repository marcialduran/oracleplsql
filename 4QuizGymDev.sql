CREATE TABLE plch_employees
(
   employee_id     INTEGER,
   salary          NUMBER,
   department_id   INTEGER
)
/

BEGIN
   INSERT INTO plch_employees VALUES (100, 200, 100);
   INSERT INTO plch_employees VALUES (200, 300, 200);
   INSERT INTO plch_employees VALUES (300, 400, 200);
   INSERT INTO plch_employees VALUES (400, 500, 200);
   COMMIT;
END;
/


CREATE OR REPLACE PROCEDURE plch_bulk_update (
   department_id_in   IN PLS_INTEGER,
   limit_in           IN PLS_INTEGER DEFAULT 100)
IS
   CURSOR rows_cur
   IS
      SELECT employee_id, salary
        FROM plch_employees
       WHERE department_id = department_id_in;

   TYPE rows_t IS TABLE OF rows_cur%ROWTYPE;

   l_rows   rows_t;
BEGIN
   OPEN rows_cur;

   LOOP
      FETCH rows_cur BULK COLLECT INTO l_rows
         LIMIT limit_in;

      /*FORALL*/
      FORALL indx IN l_rows.FIRST .. l_rows.LAST
   UPDATE plch_employees
      SET salary = l_rows (indx).salary * 2
    WHERE employee_id = l_rows (indx).employee_id;


      EXIT WHEN rows_cur%NOTFOUND;
   END LOOP;

   DBMS_OUTPUT.put_line ('Rows updated!');
END plch_bulk_update;
/

BEGIN
   plch_bulk_update (200, 2);
END;