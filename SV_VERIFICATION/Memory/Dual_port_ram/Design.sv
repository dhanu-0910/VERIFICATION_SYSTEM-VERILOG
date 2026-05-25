module dual_port #(parameter n=8, d=16) (input clk, input  [n-1:0] din1, din2, input  [$clog2(d)-1:0] a1,  a2,input w_en1, w_en2,output logic [n-1:0]dout1, dout2);
  reg [n-1:0] mem [d-1:0];
 
  always @(posedge clk) begin
    if (w_en1)  
      mem[a1] <= din1;
    else
      dout1   <= mem[a1];
  end
 
  always @(posedge clk) begin
    if (w_en2 && !(w_en1 && a1 == a2))
      mem[a2] <= din2;
    else        
      dout2   <= mem[a2];
  end
endmodule
