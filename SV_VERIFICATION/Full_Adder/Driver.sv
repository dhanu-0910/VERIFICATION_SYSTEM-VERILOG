class driver;
  mailbox g2d;
  virtual fa_if vif;

  function new(virtual fa_if vif, mailbox g2d);
    this.vif = vif;
    this.g2d = g2d;
  endfunction

  task run();
    transaction tr;
    repeat(20) begin
      g2d.get(tr);
      vif.a = tr.a;
      vif.b = tr.b;
      vif.cin = tr.cin;
      #10;
    end
  endtask
endclass
