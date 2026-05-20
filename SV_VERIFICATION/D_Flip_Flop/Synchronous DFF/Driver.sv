class driver; 
  transaction tr;
  mailbox #(transaction) g2d;
  virtual d_if vif;
 
  function new(mailbox #(transaction) g2d,virtual d_if vif);
    this.g2d = g2d;
    this.vif  = vif;
  endfunction
 
  task run();
    
    repeat (30) begin
      g2d.get(tr);
      @(vif.drv_cb);
      vif.rst <= tr.rst;
      vif.d   <= tr.d;
      $display("[DRIVER]    rst=%0b d=%0b", tr.rst, tr.d);
    end

  endtask
 
endclass
