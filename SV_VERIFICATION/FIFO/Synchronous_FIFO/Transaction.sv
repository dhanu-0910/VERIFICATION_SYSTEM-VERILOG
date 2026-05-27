class transaction;
  parameter n=8;
  
  typedef enum{READ_ONLY,WRITE_ONLY,READ_WRITE,NO_READ_WRITE} mode;
  
  rand mode m;
  bit[n-1:0] din;
  rand bit r_en;
  rand bit w_en;
  rand bit rst;
  bit[n-1:0] dout;
  bit full; 
  bit empty;
  
  rand int duration;
  
  constraint c1{ 
    rst dist {0:=20,1:=1};
 
    duration inside {[16:20]};
               }
  
  constraint c2{
                if(m==READ_ONLY) {r_en==1;w_en==0;}
                if(m==WRITE_ONLY) {r_en==0;w_en==1;}
                if(m==READ_WRITE) {r_en==1;w_en==1;}
                if(m==NO_READ_WRITE) {r_en==0;w_en==0;} 
               }
  
  
endclass
