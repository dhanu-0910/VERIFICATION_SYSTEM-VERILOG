`include "jc_if.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"

module johnson_counter_tb;
  
  bit clk=0;
  always #10 clk=~clk;
  
  jc_if vif(clk);
  
  environment env;
  
  johnson_counter dut(.clk(clk),.rst(vif.rst),.q(vif.q));
  
  initial begin
    $dumpfile("Johnson.vcd");
    $dumpvars(0,johnson_counter_tb);
    $display("                  ========================================================");
    $display("                              VERIFICATION OF JOHNSON COUNTER            ");
    $display("                  ========================================================");
    vif.rst=1;
    #20;
    env=new(vif);
    env.run();
    #1000;
    $finish;
  end
endmodule
