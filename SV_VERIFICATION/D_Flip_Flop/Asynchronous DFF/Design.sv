module d_ff (input  logic clk,input  logic d,input  logic rst,output logic q);
  
  always @(posedge clk or posedge rst) begin
    if (rst)
      q <= 1'b0;
    else
      q <= d;
  end
  
endmodule 
