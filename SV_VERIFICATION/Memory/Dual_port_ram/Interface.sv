interface dp_if #(parameter n=8, d=16) (input bit clk);
  logic [n-1:0] din1, din2;
  logic [$clog2(d)-1:0] a1, a2;
  logic w_en1, w_en2;
  logic [n-1:0] dout1, dout2;
 
  clocking drv_cb @(negedge clk);
    default input #1 output #0;
    output din1, din2, a1, a2, w_en1, w_en2;
    input  dout1, dout2;
  endclocking
 
  clocking mon_cb @(posedge clk);
    default input #0 output #0;
    input din1, din2, a1, a2, w_en1, w_en2;
    input dout1, dout2;
  endclocking
endinterface
