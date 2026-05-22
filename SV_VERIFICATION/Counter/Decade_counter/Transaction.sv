class transaction;

  rand bit rst;
  bit [3:0]q;
  constraint rst_c {rst dist {1:=20, 0:=80};}
  
endclass
