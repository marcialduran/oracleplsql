CREATE OR REPLACE PACKAGE plch_counter
AS
--
g_update  PLS_INTEGER;
g_insert  PLS_INTEGER;
--
END;
/

CREATE TABLE plch_test
  (id     NUMBER
  ,value  NUMBER
  )
/

CREATE OR REPLACE TRIGGER plch_test_asi
AFTER INSERT
ON plch_test
BEGIN
  plch_counter.g_insert :=  plch_counter.g_insert + 1;
END;
/

CREATE OR REPLACE TRIGGER plch_test_asu
AFTER UPDATE
ON plch_test
BEGIN
  plch_counter.g_update :=  plch_counter.g_update + 1;
END;
/


--Which choice shows the text that will be displayed on my screen after executing the following block?

DECLARE
  TYPE ta_number IS TABLE OF NUMBER;
  a_number  ta_number :=  ta_number(1,2,3);
BEGIN
  plch_counter.g_insert :=  0;
  plch_counter.g_update :=  0;
  --
  FORALL i_ins IN 1..a_number.COUNT
    INSERT INTO plch_test
      (id
      ,value
      )
    VALUES
      (a_number(i_ins)
      ,10
      );
  --
  FORALL i_upd IN 1..a_number.COUNT
    UPDATE  plch_test
    SET     value   = a_number(i_upd) * 10
    WHERE   id      = a_number(i_upd);
  --
  dbms_output.put_line
    ( 'Ins = '||plch_counter.g_insert
    ||' Upd = '||plch_counter.g_update
    );
END;
/

-- resultado ins=1 upd=3
