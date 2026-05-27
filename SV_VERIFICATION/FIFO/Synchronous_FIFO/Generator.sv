class generator;
  
  mailbox #(transaction) g2d;
  transaction tr;
  event done;
  
  function new(mailbox #(transaction) g2d,event done);
    this.g2d=g2d;
    this.done=done;
  endfunction
  
  task run();
    begin
      repeat(20)begin
        tr=new();
        tr.randomize();
        g2d.put(tr);
        $display("[time=%0t] GENERATOR:   |reset=%b | read_enable=%b | write_enable=%b  ",$time, tr.rst,tr.r_en,tr.w_en);
        @(done);
      end
    end
  endtask
  
endclass
