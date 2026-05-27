class driver;
  
  transaction tr;
  virtual fifo_if vif;
  mailbox #(transaction) g2d;
  event done;
  
  bit[7:0]din;
  
  function new(mailbox #(transaction) g2d,virtual fifo_if vif,event done);
    this.g2d=g2d;
    this.vif=vif;
    this.done=done;
  endfunction
  
  task run();
    begin
      forever begin 
        tr=new();
        g2d.get(tr);
        repeat(tr.duration)begin
          @(vif.drv_cb);
          din=$urandom_range(0,255);
          
          vif.drv_cb.din<=din;
          
          vif.drv_cb.r_en<=tr.r_en;
          vif.drv_cb.w_en<=tr.w_en;
          vif.drv_cb.rst<=tr.rst;
          #1;
          $display("[time=%0t] DRIVER:   |reset=%b | read_enable=%b | write_enable=%b | din=%0d ",$time, tr.rst,tr.r_en,tr.w_en,din);
        end
        ->done;
      end
    end
  endtask
  
endclass
  
