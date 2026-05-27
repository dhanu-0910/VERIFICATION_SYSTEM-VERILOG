class scoreboard;
  
  parameter n=8;
  parameter d=16;
  
  
  mailbox #(transaction) m2s;
  transaction tr;
  
  function new(mailbox #(transaction) m2s);
    this.m2s=m2s;
  endfunction
  
  bit [n-1:0] expected_dout;
  reg[n-1:0]mem[d-1:0];
  reg [$clog2(d):0] wptr,rptr;
  bit full=0,empty=1;
  
  int total,pass,fail;
  
  task run();
    begin
      forever begin
        tr=new();
        m2s.get(tr);
        
        total++;
        
        if(tr.rst)begin
          expected_dout=0;
          wptr=0;
          rptr=0;
          empty=1;
          full=0;
        end
        else begin
          if(tr.w_en && ! full)begin
            mem[wptr[$clog2(d)-1:0]]=tr.din;
            wptr=wptr+1;
          end
          else
            wptr=wptr;
          
          if(tr.r_en && !empty)begin
            expected_dout=mem[rptr[$clog2(d)-1:0]];
            rptr=rptr+1;
          end
          else
            rptr=rptr;
        end
        empty= wptr==rptr;
          
        full=((wptr[$clog2(d)-1:0]==rptr[$clog2(d)-1:0]) && (rptr[$clog2(d)]!=wptr[$clog2(d)]));

        if(expected_dout==tr.dout && full==tr.full && empty==tr.empty)begin
          $display("[time=%0t] SCOREBOARD",$time);
          $display("=>|PASS|<=");
          $display("Expected_out= %0d Actual_out= %0d",expected_dout,tr.dout);
          $display("Expected_empty= %0d Actual_Empty= %0d",empty,tr.empty);
          $display("Expected_full= %0d Actual_Full= %0d",full,tr.full);
          $display("--------------------------------------------------------------------------------");
          pass++;
        end
        else begin
          $display("[time=%0t] SCOREBOARD",$time);
          $display("=>|FAIL|<=");
          $display("Expected_out= %0d Actual_out= %0d",expected_dout,tr.dout);
          $display("Expected_empty= %0d Actual_Empty= %0d",empty,tr.empty);
          $display("Expected_full= %0d Actual_Full= %0d",full,tr.full);
          $display("--------------------------------------------------------------------------------");
          fail++;
        end
      end
    end
  endtask
  
endclass
