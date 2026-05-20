class monitor;
  
  transaction tr;
  mailbox #(transaction) m2s;
  virtual d_if vif;
 
  function new(mailbox #(transaction) m2s,virtual d_if vif);
    this.m2s = m2s;
    this.vif  = vif;
  endfunction
 
  task run();
 
    repeat (30) begin
      tr = new();
      @(vif.mon_cb);
      tr.rst = vif.rst;
      tr.d = vif.d;
      tr.q = vif.q;
      m2s.put(tr);
      $display("[MONITOR]   rst=%0b d=%0b q=%0b", tr.rst, tr.d, tr.q);
    end
  endtask
 
endclass
