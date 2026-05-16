class scoreboard;
  mailbox   m2s;
  reference r;

  function new(mailbox m2s);
    this.m2s = m2s;
    r = new();
  endfunction

  task run();
    transaction tr;
    bit actual_sum;
    bit actual_carry;

    repeat(20) begin
      m2s.get(tr);
      actual_sum   = tr.sum;
      actual_carry = tr.carry;
      r.expected_output(tr);
      $display("\n======================================================");
      $display("                SCOREBOARD REPORT                      ");
      $display("======================================================");      
      $display(" INPUT STIMULUS");
      $display(" -----------------------------------------------------");
      $display("   A   = %0b", tr.a);
      $display("   B   = %0b", tr.b);
      $display("   Cin = %0b", tr.cin);
      $display("\n EXPECTED OUTPUT (REFERENCE MODEL)");
      $display(" -----------------------------------------------------");
      $display("   Sum   = %0b", tr.sum);
      $display("   Carry = %0b", tr.carry);
      $display("\n ACTUAL OUTPUT (DUT)");
      $display(" -----------------------------------------------------");
      $display("   Sum   = %0b", actual_sum);
      $display("   Carry = %0b", actual_carry);
      $display("\n VERIFICATION STATUS");
      $display(" -----------------------------------------------------");
      if ((actual_sum === tr.sum) && 
          (actual_carry === tr.carry)) begin
        $display("    PASS : DUT Output Matches Reference Model");
      end
      else begin
        $display("    FAIL : Output Mismatch Detected");
      end
      $display("======================================================\n");
    end
  endtask
endclass
