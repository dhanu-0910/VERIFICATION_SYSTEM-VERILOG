class environment;
 
  generator gen;
  driver drv;
  monitor mon;
  scoreboard scb;
 
  mailbox #(transaction) g2d;
  mailbox #(transaction) m2s;
 
 
  virtual d_if vif;
 
  function new(virtual d_if vif);
    this.vif = vif;
    g2d = new();
    m2s = new();
    gen = new(g2d);   
    drv = new(g2d, vif);
    mon = new(m2s, vif);
    scb = new(m2s);
  endfunction
 
  task run();
    fork
      gen.run();
      drv.run();
      mon.run();
      scb.run();
    join
  endtask
 
endclass
