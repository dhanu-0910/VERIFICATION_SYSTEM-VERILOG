`include "d_if.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"
 
module d_ff_tb;
 
  logic clk;
 
  d_if vif (.clk(clk));
 
  environment env;
 
  d_ff dut (
    .clk (clk),
    .rst (vif.rst),
    .d   (vif.d),
    .q   (vif.q)
  );
 
  initial begin
    clk = 1'b0;
    forever #10 clk = ~clk;
  end
 
  initial begin
    $dumpfile("d_ff_tb.vcd");
    $dumpvars(0, d_ff_tb);
    env = new(vif);
    env.run();
    #20;
    $finish;
  end
 
endmodule
