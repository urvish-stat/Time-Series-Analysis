** Load Input files;
proc import datafile = "/folders/myfolders/EASTMANK.XLS"
   dbms = xls out = estman_kodak replace; sheet = "Data";
run;   

** Series plot for estman_kodak;
proc sgplot data = estman_kodak;
  series x = year y = real_revenue;
  xaxis ranges = (1970-2005);
quit;

** Fit the 3rd Order autoregressive model;
proc autoreg data = estman_kodak;
  model real_revenue = coded_year / nlag = 3;
quit;

** Fit the 2nd Order autoregressive model;
proc autoreg data = estman_kodak;
  model real_revenue = coded_year / nlag = 2;
quit;

  