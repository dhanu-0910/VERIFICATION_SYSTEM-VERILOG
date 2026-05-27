
module sync_fifo #(parameter n=8,d=16)
  (
    input[n-1:0] din,
    input r_en,w_en,clk,rst,
    output reg [n-1:0] dout, 
    output full,empty
  );
  
  reg[n-1:0]mem[d-1:0];
  reg [$clog2(d):0] wptr,rptr;

  
  always@(posedge clk) begin
    if(rst) begin
      wptr<=0;
      dout<=0;
    end
   else begin
     if(w_en && !full) begin 
       mem[wptr[$clog2(d)-1:0]]<=din;
           wptr<=wptr+1;
       end
     else
         wptr<=wptr;
      end
   end

 always @(posedge clk) begin
  if(rst)
     rptr<=0;       
  else begin 
    if(r_en && !empty) begin
      dout<=mem[rptr[$clog2(d)-1:0]];
         rptr<=rptr+1;
        end
       else
         rptr<=rptr;
      end
   end
  
  assign empty=(wptr==rptr);
  
  assign full=((wptr[$clog2(d)-1:0]==rptr[$clog2(d)-1:0]) && (rptr[$clog2(d)]!=wptr[$clog2(d)]));
  
endmodule
