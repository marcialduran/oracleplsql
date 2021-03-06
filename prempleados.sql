CREATE OR REPLACE Procedure prd_datosempleados (pid EMPLOYEES.EMPLOYEE_ID%TYPE)
AS

PFIRST_NAME     VARCHAR2(20);
PLAST_NAME      VARCHAR2(20);
PEMAIL          VARCHAR2(25);
PPHONE_NUMBER   VARCHAR2(20);
PHIRE_DATE      DATE;
PJOB_ID          VARCHAR2(10);
PSALARY          NUMBER(8,2);
PCOMMISSION_PCT  NUMBER(2,2);
PMANAGER_ID      NUMBER(6,0);
PDEPARTMENT_ID   NUMBER(4,0);

BEGIN
    SELECT  FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID
            ,DEPARTMENT_ID
    INTO    PFIRST_NAME,PLAST_NAME,PEMAIL,PPHONE_NUMBER,PHIRE_DATE,PJOB_ID,PSALARY,PCOMMISSION_PCT,PMANAGER_ID
            ,PDEPARTMENT_ID
    FROM    EMPLOYEES
    WHERE   EMPLOYEE_ID=PID;
    
dbms_output.put_line(PFIRST_NAME || '-' ||PLAST_NAME|| '-'||PDEPARTMENT_ID);




END;
