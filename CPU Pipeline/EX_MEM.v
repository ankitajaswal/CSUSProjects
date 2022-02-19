module EX_MEM(clk, reset, addrbranch, Aluresult, branch, R1holdop1, R1hold, R0hold, memWrite, regWrite, memToReg, Finbranch, Finresult, FwriteBack, FinR0, CmemWrite, CregWrite, CmemToReg, R1data, Cbranch, branched);

input clk, reset, memToReg, branch, branched;
input [1:0] memWrite, regWrite;
input [3:0] R1holdop1;
input [15:0] addrbranch, R1hold, Aluresult, R0hold;

output reg CmemToReg, Cbranch; 
output reg [1:0] CregWrite, CmemWrite;
output reg [3:0] FwriteBack;
output reg [15:0] Finresult, Finbranch, R1data, FinR0;

reg [4:0] waiting;

always@(negedge clk)
begin
	if(!reset)
	begin
		waiting<= 0;
		CregWrite<=0;
		CmemToReg<=0;
		CmemWrite<=0;
		Finresult<=16'hzzzz;
		Finbranch<=16'hzzzz;
		FwriteBack<=16'h0000;
		FinR0<=16'hzzzz;
	end

	if( branched == 0  )
	begin
		if(waiting==0)
		begin
			CregWrite<= regWrite;  
			CmemToReg<= memToReg;  
			CmemWrite<=memWrite; 
			Finresult<=Aluresult; 
			Finbranch<=addrbranch;
			R1data<= R1hold;
			FwriteBack<=R1holdop1;
			FinR0<=R0hold;
			Cbranch<=branch;
			waiting<=0;
		end
		else
		begin
			waiting<=0;
		end
	end
	else
	begin
		CregWrite<=0;
		CmemToReg<=0;
		CmemWrite<=0;
		Finresult<=16'hzzzz;
		Finbranch<=16'hzzzz;
		R1data <= 16'hzzzz;
		FwriteBack<=4'hz;
		FinR0<=16'hzzzz;
		Cbranch<=0;
		if( branched) 
			waiting<= 1;
		else
			waiting<=0;
	end
end

endmodule
