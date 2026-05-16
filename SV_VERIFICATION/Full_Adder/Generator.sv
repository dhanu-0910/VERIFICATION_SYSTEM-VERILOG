class generator;
  mailbox g2d;

  function new(mailbox g2d);
    this.g2d = g2d;
  endfunction

  task run();
    transaction tr;
    repeat(20) begin
      tr = new();
      if (!tr.randomize())
        $display("Randomization failed");
      g2d.put(tr);
    end
  endtask
endclass
