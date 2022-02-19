/*
addressR is the address to the next instruction located in memory from PC
instruction will be the instruction sent out to be executed 
*/
module IntMemory( reset, addressR, instruction, stall, resume);

input reset;
input [2:0] resume;
input [15:0] addressR;

output reg stall;
output reg [15:0] instruction;

integer i;
reg [7:0] mem [65536:0];

always@(reset or addressR or resume)
begin
	if( !reset )
	begin
		stall<=0;
		mem[0] <= 8'h01;
		mem[1] <= 8'h2F;
		mem[2] <= 8'h01;
		mem[3] <= 8'h2E;
		mem[4] <= 8'h03;
		mem[5] <= 8'h4C;
		mem[6] <= 8'h03;
		mem[7] <= 8'h2D;
		mem[8] <= 8'h05;
		mem[9] <= 8'h61;
		mem[10] <= 8'h01;
		mem[11] <= 8'h52;
		mem[12] <= 8'h00;
		mem[13] <= 8'h0E;
		mem[14] <= 8'h04;
		mem[15] <= 8'h3A;
		mem[16] <= 8'h04;
		mem[17] <= 8'h2B;
		mem[18] <= 8'h06;
		mem[19] <= 8'h39;
		mem[20] <= 8'h06;
		mem[21] <= 8'h28;
		mem[22] <= 8'h67;
		mem[23] <= 8'h04;
		mem[24] <= 8'h0B;
		mem[25] <= 8'h1F;
		mem[26] <= 8'h47;
		mem[27] <= 8'h05;
		mem[28] <= 8'h0B;
		mem[29] <= 8'h2F;
		mem[30] <= 8'h57;
		mem[31] <= 8'h02;
		mem[32] <= 8'h01;
		mem[33] <= 8'h1F;
		mem[34] <= 8'h01;
		mem[35] <= 8'h1F;
		mem[36] <= 8'h88;
		mem[37] <= 8'h90; 
		mem[38] <= 8'h08;
		mem[39] <= 8'h8F;
		mem[40] <= 8'hB8;
		mem[41] <= 8'h92;
		mem[42] <= 8'h8A;
		mem[43] <= 8'h92;
		mem[44] <= 8'h0C;
		mem[45] <= 8'hCF;
		mem[46] <= 8'h0D;
		mem[47] <= 8'hDE;
		mem[48] <= 8'h0C;
		mem[49] <= 8'hDF;
		mem[50] <= 8'h0C;
		mem[51] <= 8'hDF;
		for(i=51; i < 65536; i=i+1)
			mem[i] <= 8'h00;
	end
	else
	begin

		if(instruction[15:12]==8 && resume<=1 )
		begin
			if( (mem[addressR][3:0] == instruction[11:8]) || (mem[(addressR+1)][3:0] == instruction[11:8]) || (mem[addressR][3:0] == instruction[7:4]) || (mem[(addressR+1)][3:0] == instruction[7:4]) )
			begin
				stall<=1;
				instruction<=16'hzzzz;
			end
			else if(resume==1 || resume==2)
			begin
				stall<=1;
				instruction<=16'hzzzz;
			end
			else
			begin
				stall<=0;
				instruction <= {mem[addressR], mem[(addressR+1)] };
			end
		end
		else
		begin
			if(resume==1 || resume==2)
			begin
				stall<=1;
				instruction<=16'hzzzz;
			end
			else
			begin
				stall<=0;
				instruction <= {mem[addressR], mem[(addressR+1)] };
			end
		end

	end
end
endmodule
