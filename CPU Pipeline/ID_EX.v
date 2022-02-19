module ID_EX(clk, reset, Aluop, op1, AluSrcA, AluSrcB, branch, memToReg, regWrite, memWrite, R1hold, R2hold, extended, mathR1, mathR2, exPass, CAluop, CAluSrcA, CAluSrcB, Cbranch, CmemToReg, CregWrite, CmemWrite, op1pass, FutureAluresult, op2, R0out, branched, Fwriteback, Finresults, addr, branchcorrectly);

input clk, reset, AluSrcA, AluSrcB, branch, memToReg, branched;
input [1:0]  regWrite, memWrite;
input [3:0] Aluop, op1, op2, Fwriteback;
input [15:0] R1hold, R2hold, extended, FutureAluresult, R0out, Finresults, addr;

output reg CAluSrcA, CAluSrcB, Cbranch,CmemToReg;
output reg [1:0] CmemWrite, CregWrite;
output reg [3:0] CAluop, op1pass;
output reg [15:0] mathR1, mathR2, exPass, branchcorrectly;

reg [15:0] op2pass;
reg [4:0] index;
reg [35:0] controlsignal [8:0];
reg [15:0] processEX [8:0];
reg [5:0] empty;
reg [5:0] access, temp;


always@(negedge clk)
begin
	if( (!reset) || (branched==1) )
	begin
		index <=0;
		empty<=0;
	end
	else
	begin
		processEX[index]<=extended;
		controlsignal[index]<={addr, op2, op1, Aluop, memWrite, regWrite, memToReg, AluSrcA, AluSrcB, branch};
		index<=index+1;
		if(empty < 6)
			empty<=empty+1;
	end
	if( empty < 1)
	begin
		//do nothing wait

		CAluSrcA<=1'bz;
		CAluSrcB<=1'bz; 
		Cbranch<=0;
		CmemWrite<=0;
		CmemToReg<=0; 
		CregWrite<=0;
		CAluop<=4'hz;
		mathR1<=16'hzzzz;
		mathR2<=16'hzzzz; 
		exPass<=16'hzzzz;
		op1pass<= 4'hz;
		op2pass<=4'hz;
	end
	else
	begin
		if( (index+1) > 7  )
		begin
			access<=index;
			index<=0;
		end
		else
			access<=index-0;
		if(index == 0)
			temp<=6;
		else
			temp<=index-1;

		CAluSrcA<= controlsignal[access][2];
		CAluSrcB<=controlsignal[access][1]; 
		
		Cbranch<=branch;
		CmemWrite<=memWrite;
		CmemToReg<=memToReg; 
		CregWrite<=regWrite;

		Cbranch<=controlsignal[access][0];
		CmemWrite<=controlsignal[access][7:6];
		CmemToReg<=controlsignal[access][3]; 
		CregWrite<=controlsignal[access][5:4];
		
		if( op1pass == controlsignal[access][15:12])
			mathR1<=FutureAluresult;

		else if( (controlsignal[access][15:12] == 0) && ( (CAluop == 1) || (CAluop ==2) ) )
			mathR1<=R0out;
		
		else if( (controlsignal[access][15:12]==Fwriteback) && (controlsignal[access][11:8] != 3) && (controlsignal[access][11:8] != 5) && (controlsignal[access][11:8] != 4 ) )
			mathR1<=Finresults;

		else
			mathR1<= R1hold; 

		if(controlsignal[access][19:16] == op1pass)
			mathR2<=FutureAluresult;
		
		else if((controlsignal[access][19:16]==0) && ( (CAluop == 1) || (CAluop ==2) ) )
			mathR2<=R0out;

		else if( (controlsignal[access][19:16]==Fwriteback) )
			mathR2<=Finresults;

		else
			mathR2<= R2hold; 

		CAluop<=controlsignal[access][11:8];
		exPass<= processEX[access];
		branchcorrectly<=controlsignal[temp][35:20];
		op1pass<=controlsignal[access][15:12];
		op2pass<=controlsignal[access][19:16];
	end

end

endmodule