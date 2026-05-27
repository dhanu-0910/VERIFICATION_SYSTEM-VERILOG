`include "transaction.sv"
`include "interface.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"

module testbench();
  
  parameter n = 8;
  parameter d = 16;
  
  reg clk=0;
  always #5 clk=~clk;
  
    
  fifo_if vif(clk);
  sync_fifo #(.n(8),.d(16)) dut(.clk(clk),.rst(vif.rst),.din(vif.din),.r_en(vif.r_en),.w_en(vif.w_en),.dout(vif.dout),.full(vif.full),.empty(vif.empty));
  
  environment env;
 
  initial begin
    $dumpfile("Output.vcd");
    $dumpvars(0,testbench);
    $display("******************************************************************************");
    $display("                          SYNCHRONOUS FIFO IN SV                   ");
    $display("******************************************************************************");
    vif.rst=1;
    #10;
    env=new(vif);
    env.run();
   end
  
endmodule
