class monitor;
  transaction tr;
  mailbox #(transaction) m2s;
  virtual dp_if vif;
 
  function new(mailbox #(transaction) m2s, virtual dp_if vif);
    this.m2s = m2s;
    this.vif  = vif;
  endfunction
 
  task run();
    repeat(20) begin
      tr = new();
      
      @(vif.mon_cb);
      tr.din1 = vif.mon_cb.din1;
      tr.din2 = vif.mon_cb.din2;
      tr.a1 = vif.mon_cb.a1;
      tr.a2 = vif.mon_cb.a2;
      tr.w_en1 = vif.mon_cb.w_en1;
      tr.w_en2 = vif.mon_cb.w_en2;
      tr.dout1 = vif.mon_cb.dout1;
      tr.dout2 = vif.mon_cb.dout2;
 
      m2s.put(tr);
      tr.display("MONITOR");
    end
  endtask
endclass
