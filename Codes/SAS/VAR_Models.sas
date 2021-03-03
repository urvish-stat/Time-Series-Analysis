data var_data;
  infile "/folders/myfolders/VAR_Model_Data.txt";
  input year $ M1 $ R P GDP $ @@;
  M1 = compress(M1, ",");
  GDP = compress(GDP, ",");
run;

data var_data;
  set var_data;
  M1 = M1*1;
  GDP = GDP*1;
run;

proc export data = var_data outfile = "/folders/myfolders/VAR_Model_Data.xlsx"
  dbms = xlsx;
run;
  
  
