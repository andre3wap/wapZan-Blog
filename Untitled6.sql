DECLARE
  rec_counter NUMBER := 0;
  i NUMBER;
  TYPE emp_tbl IS TABLE OF EMPLOYEES%ROWTYPE;
  emp_tblbk emp_tbl := emp_tbl();
  CURSOR emp_tbln IS SELECT * FROM EMPLOYEES;
  
BEGIN
  FOR emp_array IN emp_tbln loop
    rec_counter := rec_counter +1;
    i := rec_counter;
    emp_tblbk.EXTEND;
    emp_tblbk(i).FIRSTNAME := emp_array.FIRSTNAME;
    emp_tblbk(i).LASTNAME := emp_array.LASTNAME;
    emp_tblbk(i).JOBTITLE := emp_array.JOBTITLE;
    ---DBMS_OUTPUT.PUT_LINE(emp_tblbk(i).FIRSTNAME); 
  END LOOP;
  
  FORALL cnt IN 1..i
  INSERT /*+append_values*/ INTO employees_bk
  (FIRSTNAME, LASTNAME, JOBTITLE)
  VALUES
  (emp_tblbk(cnt).FIRSTNAME, emp_tblbk(cnt).LASTNAME, emp_tblbk(cnt).JOBTITLE);
  
END;