interface dc_if(input clk);
  
  logic rst;
  logic [3:0]q;
  
  clocking drv_cb @(posedge clk);
    default input #1 output #0;
    output rst;
  endclocking
  
  clocking mon_cb @(posedge clk);
    default input #1 output #0;
    input q;
    input rst;
  endclocking
  
endinterface
