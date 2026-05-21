class monitor;
  
  transaction tr;
  mailbox #(transaction) m2s;
  virtual jc_if vif;
 
  function new(mailbox #(transaction) m2s,virtual jc_if vif);
    this.m2s = m2s;
    this.vif  = vif;
  endfunction
 
  task run();
 
    repeat (30) begin
      tr = new();
      @(vif.mon_cb);
      tr.rst = vif.rst;
      tr.q = vif.q;
      m2s.put(tr);
      $display("[MONITOR]   rst=%0b q=%0b", tr.rst, tr.q);
    end
  endtask
 
endclass
