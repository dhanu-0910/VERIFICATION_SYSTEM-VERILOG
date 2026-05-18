class generator;
  
  transaction tr;
  mailbox #(transaction) g2d;
  event done;
 
  function new(mailbox #(transaction) g2d,event done);
    this.g2d  = g2d;
    this.done = done;
  endfunction
 
  task run();
    repeat (30) begin
      tr = new();
      if (!tr.randomize())
        $display("[GENERATOR] ERROR: Randomization Failed"); 
      g2d.put(tr);
      $display("[GENERATOR] rst=%0b d=%0b", tr.rst, tr.d);
      @(done);
    end
  endtask
 
endclass
