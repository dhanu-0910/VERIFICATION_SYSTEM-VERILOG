class generator;
  transaction tr;
  mailbox #(transaction) g2d;
 
  function new(mailbox #(transaction) g2d);
    this.g2d = g2d;
  endfunction
 
  task run();
    repeat(20) begin
      tr = new();
      if (tr.randomize())
        g2d.put(tr);
      else                
        $display("Randomization Failed");
      tr.display("GENERATOR");
    end
  endtask
endclass
