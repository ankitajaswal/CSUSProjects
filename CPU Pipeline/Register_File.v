/*
op1 is the address for the Read port 1
op2 is the address for the Read port 2
dataW is the data which will get written back into a register
outR1 and outR2 are the registers getting read out of the register file
regWrite is a control signal input to enable data to be written into the register file
reset to initialize the register file
*/
module Register_File(clk, op1, op2, dataW, R0, outR1, outR2, regWrite, reset, Rout, FWriteback);

input clk, reset, Rout;
input [1:0] regWrite;
input [3:0] op1, op2, FWriteback;
input [15:0] dataW, R0;

output reg [15:0] outR1, outR2;

reg [15:0] registerFile [15:0];
reg [15:0] temp;	

always@(negedge clk)
begin

	//we initialize the array with values or reset them to these specific values
	if(!reset)
	begin
		registerFile[0] <= 16'h0000;
		registerFile[1] <= 16'h0F00;
		registerFile[2] <= 16'h0050;
		registerFile[3] <= 16'hFF0F;
		registerFile[4] <= 16'hF0FF;
		registerFile[5] <= 16'h0040;
		registerFile[6] <= 16'h0024;
		registerFile[7] <= 16'h00FF;
		registerFile[8] <= 16'hAAAA;
		registerFile[9] <= 16'h0000;
		registerFile[10] <= 16'h0000;
		registerFile[11] <= 16'h0000;
		registerFile[12] <= 16'hFFFF;
		registerFile[13] <= 16'h0002;
		registerFile[14] <= 16'h0000;
		registerFile[15] <= 16'h0000;
	end
	else
	begin
		//We will check the enable signal to read data into the register file or read out the current
		//registers specified by op1 and op2
		temp = registerFile[op1];
		if(regWrite == 1)
		begin
			registerFile[FWriteback] <= dataW;
		end
		else if (regWrite == 2)
		begin
			registerFile[0] <= R0;
			registerFile[FWriteback] <= dataW;
		end

		outR1 <= registerFile[op1];
		outR2 <= registerFile[op2];
		
		if (Rout == 1)
		begin
			outR1 <= registerFile[op1];
			outR2 <= registerFile[0];
		end
		else if(FWriteback == op1)
		begin
			outR1 <= dataW;
			if(FWriteback == op2)
				outR2<=dataW;
		end
		else if(FWriteback == op2)
			outR2 <= dataW;
	end

	//if( (op1 == op2) && (Rout != 1) )
		//outR2 <= outR1;
end

endmodule