`include "fa_interface.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "reference.sv"
`include "scoreboard.sv"
`include "environment.sv"

module full_adder_tb;

  environment env;
  fa_if vif();

  full_adder dut (.a(vif.a),.b (vif.b),.cin(vif.cin),.sum(vif.sum),.carry(vif.carry));

  initial begin
    env = new(vif);
    env.run();
    #1000;
    $finish;
  end

endmodule
