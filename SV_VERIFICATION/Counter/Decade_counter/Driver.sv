class driver;
  
  mailbox #(transaction) g2d;
  transaction tr;
  virtual dc_if vif;
  
  function new(mailbox #(transaction) g2d,virtual dc_if vif);
    this.g2d=g2d;
    this.vif=vif;
  endfunction
  
  task run();
    repeat(20) begin
      g2d.get(tr);
      @(vif.drv_cb);
      vif.rst<=tr.rst;
      $display("[DRIVER] rst=%0d",tr.rst); 
    end
    
  endtask
endclass
