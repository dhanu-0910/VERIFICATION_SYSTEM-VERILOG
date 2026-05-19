class transaction;
  
  rand bit rst;
  rand bit d;
  bit q; 
  constraint rst_dist_c { rst dist {1 := 20, 0 := 80}; }
  
endclass
 
