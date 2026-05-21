class environment;
  
  generator g;
  driver d;
  monitor m;
  scoreboard s;
  
  mailbox #(transaction) g2d;
  mailbox #(transaction) m2s;
  
  
  virtual jc_if vif;
  
  function new(virtual jc_if vif);
    this.vif=vif;
    g2d=new();
    m2s=new();
    g=new(g2d);
    d=new(g2d,vif);
    m=new(m2s,vif);
    s=new(m2s);
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

  
    
  
  
