class scoreboard;
 
  transaction tr_a;
  mailbox #(transaction) m2s;

 
  int pass_count = 0;
  int fail_count = 0;

  bit prev_rst = 1'b1;
  bit prev_d   = 1'b0;
 
  function new(mailbox #(transaction) m2s);
    this.m2s  = m2s;

  endfunction
 
  task run();
    bit exp_q;
 
    repeat (30) begin
      m2s.get(tr_a);
      if (prev_rst)
        exp_q = 1'b0;
      else
        exp_q = prev_d;
 
      prev_rst = tr_a.rst;
      prev_d   = tr_a.d;
 
      if (exp_q === tr_a.q) begin
        $display("[SCOREBOARD] PASS | prev_rst=%0b prev_d=%0b | exp_q=%0b act_q=%0b",
                 prev_rst, prev_d, exp_q, tr_a.q);
        pass_count++;
      end else begin
        $display("[SCOREBOARD] FAIL | prev_rst=%0b prev_d=%0b | exp_q=%0b act_q=%0b",
                 prev_rst, prev_d, exp_q, tr_a.q);
        fail_count++;
      end
 
      $display("------------------------------------------");
    end
 
    $display("\n========== SIMULATION SUMMARY ==========");
    $display("  PASS: %0d / 30", pass_count);
    $display("  FAIL: %0d / 30", fail_count);
    $display("=========================================\n");
  endtask
 
endclass
