interface d_if (input logic clk);
  logic rst;
  logic d;
  logic q;
 
  clocking drv_cb @(negedge clk);
    default input #1 output #0;
    output rst, d;
  endclocking
 
  clocking mon_cb @(posedge clk);
    default input #1 output #0;
    input q, rst, d;
  endclocking
 
endinterface
