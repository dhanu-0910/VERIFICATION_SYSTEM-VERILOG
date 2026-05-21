class driver; 
  transaction tr;
  mailbox #(transaction) g2d;
  virtual jc_if vif;
 
  function new(mailbox #(transaction) g2d,virtual jc_if vif);
    this.g2d = g2d;
    this.vif  = vif;
  endfunction
 
  task run();
    
    repeat (30) begin
      g2d.get(tr);
      @(vif.drv_cb);
      vif.rst <= tr.rst;
      $display("[DRIVER]    rst=%0b", tr.rst);
    end

  endtask
 
endclass
