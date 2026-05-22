 class scoreboard;

  mailbox #(transaction) m2s;
  transaction tr;

  bit [3:0] exp_q;

  int testcount, passcount, failcount;

  function new(mailbox #(transaction) m2s);
    this.m2s  = m2s;
  endfunction

  task run();

    $display("\n");

    repeat(20) begin

      m2s.get(tr);
      testcount++;
      
      if(tr.rst)
        exp_q = 4'b0000;
      else if(exp_q==4'b1001)
        exp_q = 4'b0000;
      else
        exp_q = exp_q + 1'b1;

      $display("--------------------------------------------------------");
      $display("[TESTCASE %0d]", testcount);
      $display("--------------------------------------------------------");
      $display(" RESET       : %0d", tr.rst);
      $display(" EXPECTED_Q  : %04b", exp_q);
      $display(" ACTUAL_Q    : %04b", tr.q);

      if(tr.q == exp_q) begin
        $display(" STATUS      : PASS");
        passcount++;
      end
      else begin
        $display(" STATUS      : FAIL");
        failcount++;
      end

      $display("--------------------------------------------------------");

    end

    $display("\n");
    $display("========================================================");
    $display("                 FINAL OUTPUT SUMMARY                   ");
    $display("========================================================");
    $display(" TOTAL TESTS  : %0d", testcount);
    $display(" PASSED TESTS : %0d", passcount);
    $display(" FAILED TESTS : %0d", failcount);
    $display("========================================================");

    if(failcount == 0)
      $display(" RESULT : ALL TESTCASES PASSED SUCCESSFULLY ");
    else
      $display(" RESULT : SOME TESTCASES FAILED ");

    $display("========================================================");

  endtask

endclass
