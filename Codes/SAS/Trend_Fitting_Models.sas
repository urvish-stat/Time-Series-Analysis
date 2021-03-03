** Load the Input file;
proc import datafile = "/folders/myfolders/EASTMANK.XLS"
  out = eastman_revenue(keep = year real_revenue) replace dbms = xls; sheet = "Data";
run;

** Plot the time-series;
proc sgplot data = eastman_revenue;
  series x = year y = real_revenue;
  xaxis ranges = (1970-2005);
  yaxis ranges = (0-25);  
quit;

** Get the coded year, quadratic and exponential variables;
data eastman_revenue;
  set eastman_revenue;
  coded_year = _N_ - 1;
  coded_year_square = coded_year**2;
  log_real_revenue = log(real_revenue);
run;  

** Trend Models;
ods graphics ooff;
proc reg data = eastman_revenue;
  Linear_Trend_Model: model real_revenue = coded_year; 
  Quadratic_Trend_Model: model real_revenue = coded_year coded_year_square;
  Exponential_Trend_Model: model log_real_revenue = coded_year;
quit;

proc sgplot data = eastman_revenue;
  reg y = real_revenue x = coded_year / lineattrs = (color = 'red');
  title "Linear Trend Model";
quit;

proc sgplot data = eastman_revenue;
  reg y = real_revenue x = coded_year / degree = 2 lineattrs = (color = 'red');
  title "Quadratic Trend Model";
quit;

proc sgplot data = eastman_revenue;
  reg y = log_real_revenue x = coded_year / lineattrs = (color = 'red');
  title "Exponential Trend Model";
quit;

  

  
  