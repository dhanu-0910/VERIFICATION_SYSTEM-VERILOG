class transaction;
  parameter n = 8;
  parameter d = 16;
 
  rand bit [n-1:0] din1, din2;
  randc bit [$clog2(d)-1:0] a1, a2;
  rand bit w_en1, w_en2;
  bit [n-1:0] dout1, dout2;
 
  constraint data_c { din1 > 0; din2 > 0; a2!=a1;}
  constraint we_c   { w_en1 dist {1:=10, 0:=10};
                     w_en2 dist {1:=10, 0:=10}; }
 
  function void display(string name);
    $display("----------------------------------------");
    $display("Time = %0t", $time);
    $display("[%s]", name);
    $display("ENABLE:  w_en1=%0d  w_en2=%0d",  w_en1, w_en2);
    $display("ADDRESS: a1=%0d     a2=%0d",      a1,    a2);
    $display("DATAIN:  din1=%0d   din2=%0d",    din1,  din2);
    $display("DATAOUT: dout1=%0d  dout2=%0d",   dout1, dout2);
    $display("----------------------------------------");
  endfunction
endclass
