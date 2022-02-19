module ID_IF(clk, next_address, instruction, intout, branched, stall, continue);

input clk, branched, stall;
input [2:0] continue;
input [15:0] next_address, instruction;

output reg [15:0] intout;

always@(negedge clk)
begin

	if(branched)
		intout<=16'hzzzz;

	else if( (stall) && (continue<=1))
	begin
		intout<=16'hzzzz;
	end

	else
	begin
		intout<=instruction;
	end
		
end

endmodule