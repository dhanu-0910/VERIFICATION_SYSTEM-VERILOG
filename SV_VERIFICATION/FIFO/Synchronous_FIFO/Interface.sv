interface fifo_if #(parameter n=8,d=16) (input clk);
  
  logic rst;
  logic [n-1:0] din;
  logic r_en;
  logic w_en;
  logic [n-1:0] dout;
  logic full;
  logic empty;
  
  clocking drv_cb @(posedge clk);
    default input #1 output #0;
    input dout,full,empty;
    output din,r_en,w_en,rst;
  endclocking
  
  clocking mon_cb @(posedge clk);
    default input #0 output #0;
    input dout,din,r_en,w_en,rst,full,empty;
  endclocking
  
endinterface
