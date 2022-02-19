module PC(current_address, result_address, reset, clk, repeated, continue);

input 	[15:0] current_address;
input	reset, clk, repeated;

output reg [2:0] continue;
output reg	[15:0] result_address;

always@(negedge clk)
begin
 	if(!reset)
  begin
    result_address <= 16'h0000;
  end   
  else if(repeated)
  begin
    //Keep previous address because we need to stall
    //We are stalling for the load intstruction which is needed for the next instruction
    continue<= continue+1;
  end  
  else  
  begin
    continue<=0;
    result_address <= current_address;
  end

end

endmodule
