class monitor;  
  mailbox m2s;
  virtual fa_if vif;

  function new(virtual fa_if vif, mailbox m2s);
    this.vif = vif;
    this.m2s = m2s;
  endfunction

  task run();
    transaction tr;
    repeat(20) begin
      #1;            
      tr = new();
      tr.a = vif.a;
      tr.b = vif.b;
      tr.cin = vif.cin;
      tr.sum = vif.sum;
      tr.carry = vif.carry;
      m2s.put(tr);
      #9;           
    end
  endtask
endclass
