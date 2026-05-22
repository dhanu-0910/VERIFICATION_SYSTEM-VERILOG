`include "dc_if.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"

module decade_counter_tb;
  
  bit clk=0;
  always #10 clk=~clk;
  
  dc_if vif(clk);
  
  environment env;
  
  decade_counter dut(.clk(clk),.rst(vif.rst),.q(vif.q));
  
  initial begin
    $dumpfile("Decade.vcd");
    $dumpvars(0,decade_counter_tb);
    $display("                  ========================================================");
    $display("                              VERIFICATION OF DECADE COUNTER            ");
    $display("                  ========================================================");
    vif.rst=1;
    #20;
    env=new(vif);
    env.run();
    #1000;
    $finish;
  end
endmodule
