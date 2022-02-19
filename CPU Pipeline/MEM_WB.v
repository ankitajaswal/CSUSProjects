module MEM_WB(clk, reset, Aluresult, memReadout, R1hold, R0hold, regWrite, memToReg, Finreadout, Fwriteback, R0result, CmemToReg, CregWrite, math);

input clk, reset,memToReg;
input [1:0] regWrite;
input [3:0] R1hold;
input [15:0] memReadout, R0hold, Aluresult;

output reg CmemToReg;
output reg [1:0] CregWrite;
output reg [3:0] Fwriteback;
output reg [15:0] Finreadout, R0result, math;

reg [4:0] waiting;
reg [5:0] index;
reg [6:0] controlSignals [6:0];

always@(negedge clk)
begin
	if(!reset)
	begin
		waiting<=0;
		CmemToReg<=0;
		CregWrite<=0;
		Finreadout<=16'hzzzz;
		Fwriteback<=16'hzzzz;
		R0result<= 16'hzzzz;
	end
	
	CmemToReg<=memToReg; 
	CregWrite<=regWrite; 
	Finreadout<=memReadout;
	Fwriteback<= R1hold; 
	R0result<= R0hold;
	math<=Aluresult;
end

endmodule
