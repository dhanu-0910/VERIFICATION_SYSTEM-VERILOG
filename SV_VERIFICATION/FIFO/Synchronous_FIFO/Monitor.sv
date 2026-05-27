class monitor;
  
  mailbox #(transaction) m2s;
  transaction tr;
  virtual fifo_if vif;
  
  function new(mailbox #(transaction) m2s,virtual fifo_if vif);
    this.m2s=m2s;
    this.vif=vif;
  endfunction
  
  task run();
    begin
      forever begin
        tr=new();
        
        @(vif.mon_cb);

        tr.din=vif.mon_cb.din;
        tr.rst=vif.mon_cb.rst;
        tr.r_en=vif.mon_cb.r_en;
        tr.w_en=vif.mon_cb.w_en;
        tr.dout=vif.mon_cb.dout;
        tr.full=vif.mon_cb.full;
        tr.empty=vif.mon_cb.empty;
        m2s.put(tr);
        $display("[time=%0t] MONITOR:  |reset=%b | read_enable=%b | write_enable=%b | din=%d | ",$time, tr.rst,tr.r_en,tr.w_en,tr.din);
      end
    end
  endtask
endclass
