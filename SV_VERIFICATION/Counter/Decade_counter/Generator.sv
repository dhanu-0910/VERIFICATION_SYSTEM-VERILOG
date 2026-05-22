class generator;
  
  mailbox #(transaction) g2d;  
  transaction tr;
  
  function new(mailbox #(transaction) g2d);
    this.g2d=g2d;
  endfunction
  
  task run();
    repeat(20) begin
      tr=new();
      if(!tr.randomize())
        $display("Randomization Failed");
      g2d.put(tr);
      $display("[GENERATOR] rst=%0d ",tr.rst);
    end
  endtask
  
endclass
    
  
