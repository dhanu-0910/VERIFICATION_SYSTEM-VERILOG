`include "dp_if.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"
 
module tb;
  parameter n = 8;
  parameter d = 16;
 
  bit clk;
  always #5 clk = ~clk;
  dp_if   vif(clk);          
 
  dual_port #(n,d) dut (.clk(clk), .din1(vif.din1), .din2(vif.din2), .a1(vif.a1), .a2(vif.a2), .w_en1(vif.w_en1), .w_en2(vif.w_en2), .dout1(vif.dout1), .dout2(vif.dout2));
 
  environment env;           
 
  initial begin
    clk=0;#10;
    $display("                                        ******************************************************");
    $display("                                                    VERIFICATION OF DUAL PORT RAM             ");
    $display("                                        ******************************************************");
    env = new(vif);
    env.run();
    #500;
    $finish;
  end
endmodule
