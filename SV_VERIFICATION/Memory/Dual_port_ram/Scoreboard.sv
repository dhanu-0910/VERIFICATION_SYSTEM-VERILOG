class scoreboard;
  parameter n = 8;
  parameter d = 16;
 
  transaction tr;
  mailbox #(transaction) m2s;
 
  bit [n-1:0] mem [d-1:0];
  bit [n-1:0] exp_dout1;
  bit [n-1:0] exp_dout2;
 
  int test_count;
  int pass_count;
  int fail_count;
 
  function new(mailbox #(transaction) m2s);
    this.m2s = m2s;
  endfunction
 
  task run();
    repeat(20) begin
      m2s.get(tr);
      test_count++;
      
	  //Port 1
      if (tr.w_en1)
        mem[tr.a1] = tr.din1;
      else
        exp_dout1  = mem[tr.a1];
 
      //PORT 2
      if (tr.w_en2 && !(tr.w_en1 && (tr.a1 == tr.a2)))
        mem[tr.a2] = tr.din2;
      else
        exp_dout2  = mem[tr.a2];
      
      // Check PORT1 on READ only
      if (!tr.w_en1) begin
        if (exp_dout1 == tr.dout1) begin
          $display("[SCOREBOARD] PORT1 PASS  exp=%0d  got=%0d", exp_dout1, tr.dout1);
          pass_count++;
        end else begin
          $display("[SCOREBOARD] PORT1 FAIL  exp=%0d  got=%0d", exp_dout1, tr.dout1);
          fail_count++;
        end
      end
 
      // Check PORT2 on READ only
      if (!(tr.w_en2 && !(tr.w_en1 && tr.a1 == tr.a2))) begin
        if (exp_dout2 == tr.dout2) begin
          $display("[SCOREBOARD] PORT2 PASS  exp=%0d  got=%0d", exp_dout2, tr.dout2);
          pass_count++;
        end else begin
          $display("[SCOREBOARD] PORT2 FAIL  exp=%0d  got=%0d", exp_dout2, tr.dout2);
          fail_count++;
        end
      end
    end
 
    $display("\n========================================================");
    $display("                 FINAL OUTPUT SUMMARY                   ");
    $display("========================================================");
    $display(" TOTAL TESTS  : %0d", test_count);
    $display(" PASSED TESTS : %0d", pass_count);
    $display(" FAILED TESTS : %0d", fail_count);
    $display("========================================================");
    if (fail_count == 0)
      $display(" RESULT : ALL TESTCASES PASSED SUCCESSFULLY ");
    else
      $display(" RESULT : SOME TESTCASES FAILED ");
    $display("========================================================");
  endtask
endclass
