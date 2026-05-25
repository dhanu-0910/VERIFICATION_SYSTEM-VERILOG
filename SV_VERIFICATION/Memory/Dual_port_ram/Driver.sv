class driver;
  transaction tr;
  mailbox #(transaction) g2d;
  virtual dp_if vif;
 
  function new(mailbox #(transaction) g2d, virtual dp_if vif);
    this.g2d = g2d;
    this.vif  = vif;
  endfunction
 
  task run();
    repeat(20) begin
      g2d.get(tr);
      @(vif.drv_cb);
      vif.drv_cb.din1 <= tr.din1;
      vif.drv_cb.din2 <= tr.din2;
      vif.drv_cb.a1 <= tr.a1;
      vif.drv_cb.a2 <= tr.a2;
      vif.drv_cb.w_en1 <= tr.w_en1;
      vif.drv_cb.w_en2 <= tr.w_en2;
      tr.display("DRIVER");
    end
  endtask
endclass
