class environment;
  generator  g;
  driver     d;
  monitor    m;
  scoreboard s;

  mailbox g2d;
  mailbox m2s;

  virtual fa_if vif;

  function new(virtual fa_if vif);
    this.vif = vif;
    g2d = new();   
    m2s = new();
    g   = new(g2d);
    d   = new(vif, g2d);
    m   = new(vif, m2s);
    s   = new(m2s);
  endfunction

  task run();
    fork
      g.run();
      d.run();
      m.run();
      s.run();
    join
  endtask
endclass
