class driver; 
  transaction tr;
  mailbox #(transaction) g2d;
  virtual d_if vif;
  event done;
 
  function new(mailbox #(transaction) g2d,virtual d_if vif,event done);
    this.g2d = g2d;
    this.vif  = vif;
    this.done = done;
  endfunction
 
  task run();
    
    repeat (30) begin
      g2d.get(tr);
      @(vif.drv_cb);
      vif.drv_cb.rst <= tr.rst;
      vif.drv_cb.d   <= tr.d;
      $display("[DRIVER]    rst=%0b d=%0b", tr.rst, tr.d);
      ->done;
    end

  endtask
 
endclass
