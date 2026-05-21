class generator;
  
  transaction tr;
  mailbox #(transaction) g2d;
 
  function new(mailbox #(transaction) g2d);
    this.g2d  = g2d;
  endfunction
 
  task run();
    repeat (30) begin
      tr = new();
      if (!tr.randomize())
        $display("[GENERATOR] ERROR: Randomization Failed"); 
      g2d.put(tr);
      $display("[GENERATOR] rst=%0b", tr.rst);
    end
  endtask
 
endclass
