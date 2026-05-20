 class scoreboard;

   transaction tr_a;
   mailbox #(transaction) m2s;

   int pass_count = 0;
   int fail_count = 0;
   int test_count = 0;

   function new(mailbox #(transaction) m2s);
     this.m2s = m2s;
   endfunction


   task run();
     bit exp_q;
     string result;

     repeat (30) begin

       m2s.get(tr_a);
       test_count++;

	   if(tr_a.rst)
         exp_q=1'b0;
       else
         exp_q = tr_a.d;

       if(exp_q === tr_a.q) begin
         result = "PASS";
         pass_count++;
       end
       else begin
         result = "FAIL";
         fail_count++;
       end

       $display("\n==================================================");
       $display("              DFF SCOREBOARD REPORT");
       $display("==================================================");
       $display(" Test Case         : %0d", test_count);
       $display(" Current DUT Out   : q=%0b", tr_a.q);
       $display(" Expected Output   : q=%0b", exp_q);
       $display(" Status            : %s", result);
       $display(" Running Score     : PASS=%0d | FAIL=%0d",
                pass_count, fail_count);
       $display("==================================================\n");

     end

     $display("\n");
     $display("##################################################");
     $display("#            FINAL VERIFICATION SUMMARY          #");
     $display("##################################################");
     $display("                Total Tests : %0d", test_count);
     $display("                Passed      : %0d", pass_count);
     $display("                Failed      : %0d", fail_count);

     if(fail_count == 0)
       $display("          RESULT      : ALL TESTS PASSED");
     else
       $display("          RESULT      : MISMATCH DETECTED");

     $display("##################################################\n");

   endtask

 endclass
