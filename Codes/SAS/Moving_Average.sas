** Load Input files;
proc import datafile = "/folders/myfolders/EASTMANK.XLS"
   dbms = xls out = estman_kodak replace; sheet = "Data";
run;   

proc import datafile = "/folders/myfolders/CABOT.XLS"
   dbms = xls out = cabot replace; sheet = "Data";
run;  

** Series plot for estman_kodak;
proc sgplot data = estman_kodak;
  series x = year y = real_revenue;
  xaxis ranges = (1970-2005);
quit;

** Series plot for Cabot corp.;
proc sgplot data = cabot;
  series x = year y = revenue;
  xaxis values = (1980 to 2000 by 5);
  yaxis values = (0 to 2500 by 500);
  title "Cabot Corp. Revenue";
quit;

** Get the Moving Average for Cabot Corp. revenues;
proc expand data = cabot out = cabot_ma method = none;
  convert revenue = MA_3 / transform = (cmovave = 3);
  convert revenue = MA_7 / transform = (cmovave = 7);
run;
  
** Plot the Moving Averages;  
proc sgplot data = cabot_ma;
  series x = year y = revenue; 
  series x = year y = MA_3;
  series x = year y = MA_7;
  xaxis values = (1980 to 2000 by 5);
  yaxis values = (0 to 2500 by 500);
  title "Moving Averages for Cabot Corp Revenues";
quit;



