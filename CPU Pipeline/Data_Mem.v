module Data_Mem(clk, reset, addr, wdata, memWrite, readout);

integer i;

input [15:0] addr, wdata;
input [1:0] memWrite;
input clk, reset;

output reg [15:0] readout;

reg [7:0] temp;
reg [7:0] mem [65536:0];
 

always@(negedge clk)
begin
	readout = {mem[addr], mem[(addr+1)]} ;
	if (!reset)
	begin
		for(i=0; i<65536; i= i+1)
		begin
			mem[i] <= 0;
		end
		mem[0]<=8'h2B;
		mem[1]<=8'hCD;
	end
	else
	begin
		temp= addr+1;
		if(memWrite == 1)
		begin
			mem[addr] <= {wdata[15:8]};
			mem[temp] <= {wdata[7:0]};
			readout = 16'hzzzz ;
		end
	end
end

endmodule
