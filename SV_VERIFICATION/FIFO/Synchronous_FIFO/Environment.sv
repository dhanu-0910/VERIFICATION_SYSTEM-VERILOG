class environment;
  
  mailbox #(transaction) g2d;
  mailbox #(transaction) m2s;
  
  virtual fifo_if vif;
  
  generator g;
  driver d;
  monitor m;
  scoreboard s;
  
  event done;
  
  real per;

  function new(virtual fifo_if vif);
    
    this.vif=vif;
    
    g2d=new();
    m2s=new();
    
    g=new(g2d,done);
    d=new(g2d,vif,done);
    m=new(m2s,vif);
    s=new(m2s);
    
  endfunction
  
  task run();
    begin
        fork
            g.run();
            d.run();
            m.run();
            s.run();
        join_any
        
          
          per=(s.pass/s.total)*100;
          
          $display("#####################################################");
          $display("     TEST_CASES= %0d",s.total);
          $display("     PASSED= %0d",s.pass);
          $display("     FAILED= %0d",s.fail);
          $display("     SUCCESS RATE= %0f",per);
          $display("#####################################################");
          #1;
          $finish;
    end
  endtask
  
endclass
