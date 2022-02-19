module Datapathtb;

reg clk, reset, AluScrA, AluSrcB, memToReg, jump, branch, nest;
reg [1:0] regWrite, exSign, memWrite;
reg [3:0] Aluop;
wire [3:0] op1, op2;
wire [7:0] extend;
wire [15:0] result, result_address, moveALU, moveALU2, Rout1, Rout2;

Datapath test(clk, reset, result, result_address, AluScrA, AluSrcB, memToReg, jump, branch, regWrite, exSign, memWrite, Aluop, nest, op1, op2, moveALU, moveALU2, Rout1, Rout2, extend);

always#10 clk= ~clk;

initial
begin
	clk=1; reset=0; AluSrcB=1; AluScrA=1; memToReg=1; jump= 1; branch=0;
	Aluop = 4'hF;
	#20
	reset=1;
	#20
	$monitor("At time %t, address = %h(%0d), op1 = %h(%0d), op2 = %h(%0d), reg1 = %h (%0d), reg2 = %h (%0d), Rout = %h(%0d), Rout2 = %h (%0d), result = %h (%0d)",$time, result_address, result_address, op1, op1, op2, op2, moveALU2, moveALU2, moveALU, moveALU, Rout1, Rout1, Rout2, Rout2, result, result);
	#20
	regWrite=1;
	nest=1; 
	#20
	nest=0;	regWrite=0; Aluop = 4'hE;
	#40
	regWrite =1;
	nest=1; 
	$monitor("At time %t, address = %h(%0d), op1 =%h (%0d), op2 = %h(%0d), result = %h (%0d)",$time, result_address, result_address,op1, op1, op2, op2, result, result);
	#20
	nest=0; regWrite=0; Aluop=4'hC;
	#40
	regWrite=1;
	nest =1; 
	$monitor("At time %t, address = %h(%0d), op1 =%h (%0d), op2 = %h(%0d), Rout = %h(%0d), Rout2 = %h (%0d),result = %h (%0d)",$time, result_address, result_address,op1, op1, op2, op2, Rout1, Rout1, Rout2, Rout2, result, result);
	#20
	regWrite=0;
	nest=0; Aluop=4'hD;
	#40
	regWrite=1;
	nest=1;
	$monitor("At time %t, address = %h(%0d), op1 =%h (%0d), op2 = %h(%0d), result = %h (%0d)",$time, result_address, result_address,op1, op1, op2, op2, result, result);
	#20
	regWrite=0;
	nest=0; Aluop = 1;
	#40
	regWrite=2;
	nest=1;
	$monitor("At time %t, address = %h(%0d), op1 =%h (%0d), op2 = %h(%0d), result = %h (%0d)",$time, result_address, result_address,op1, op1, op2, op2, result, result);
	#20
	regWrite=0;
	nest=0; Aluop=2;
	#40
	regWrite=2;
	nest=1;
	$monitor("At time %t, address = %h(%0d), op1 =%h (%0d), op2 = %h(%0d), Rout = %h(%0d), Rout2 = %h (%0d),result = %h (%0d)",$time, result_address, result_address,op1, op1, op2, op2, Rout1, Rout1, Rout2, Rout2, result, result);
	#20
	regWrite=0;
	nest=0; Aluop=4'hE;
	#40
	regWrite=1;
	nest=1;
	$monitor("At time %t, address = %h(%0d), op1 =%h (%0d), op2 = %h(%0d), Rout = %h(%0d), Rout2 = %h (%0d),result = %h (%0d)",$time, result_address, result_address,op1, op1, op2, op2, Rout1, Rout1, Rout2, Rout2, result, result);
	#20
	regWrite=0;
	nest=0; exSign=1; AluSrcB=0; AluScrA=1; Aluop= 4'hA; memToReg=1;
	#40
	regWrite=1;
	nest=1;
	$monitor("At time %t, address = %h(%0d), op1 =%h (%0d), op2 = %h(%0d), result = %h (%0d)",$time, result_address, result_address,op1, op1, op2, op2, result, result);
	#20
	regWrite=0;
	nest=0; Aluop = 4'hB;
	#40
	regWrite=1;
	nest=1;
	$monitor("At time %t, address = %h(%0d), op1 =%h (%0d), op2 = %h(%0d), result = %h (%0d)",$time, result_address, result_address,op1, op1, op2, op2, result, result);
	#20
	regWrite=0;
	nest=0; Aluop = 4'h9;
	#40
	regWrite=1;
	nest=1;
	$monitor("At time %t, address = %h(%0d), op1 =%h (%0d), op2 = %h(%0d), result = %h (%0d)",$time, result_address, result_address,op1, op1, op2, op2, result, result);
	#20
	regWrite=0;
	nest=0; Aluop = 4'h8;
	#40
	regWrite=1;
	nest=1;
	$monitor("At time %t, address = %h(%0d), op1 =%h (%0d), op2 = %h(%0d), result = %h (%0d)",$time, result_address, result_address,op1, op1, op2, op2, result, result);
	#20
	regWrite=3;
	nest=0; Aluop=4'h5; AluScrA=1; AluSrcB=1; branch = 1; jump=1;
	#40
	nest=1;
	$monitor("At time %t, address = %h(%0d), op1 =%h (%0d), op2 = %h(%0d), result = %h (%0d)",$time, result_address, result_address,op1, op1, op2, op2, result, result);
	#20
	regWrite=0;
	nest=0; Aluop = 4'hF; AluScrA=1; AluSrcB=1; branch=0; jump=1; memToReg=1;
	#40
	regWrite=1;
	nest=1;
	$monitor("At time %t, address = %h(%0d), op1 =%h (%0d), op2 = %h(%0d), result = %h (%0d)",$time, result_address, result_address,op1, op1, op2, op2, result, result);
	#20
	regWrite=3;
	nest=0; Aluop=4'h3; AluScrA=1; AluSrcB=1; branch = 1; jump=1;
	#40
	nest=1;
	$monitor("At time %t, address = %h(%0d), op1 =%h (%0d), op2 = %h(%0d), result = %h (%0d)",$time, result_address, result_address,op1, op1, op2, op2, result, result);
	#20
	regWrite=0;
	nest=0; Aluop=4'hF; branch=0; 
	#40
	regWrite=1;
	nest=1;
	$monitor("At time %t, address = %h(%0d), op1 =%h (%0d), op2 = %h(%0d), result = %h (%0d)",$time, result_address, result_address,op1, op1, op2, op2, result, result);
	#20
	regWrite=3;
	nest=0; Aluop=4'h4; branch=1;
	#40
	nest=1;
	$monitor("At time %t, address = %h(%0d), op1 =%h (%0d), op2 = %h(%0d), result = %h (%0d)",$time, result_address, result_address,op1, op1, op2, op2, result, result);
	#20
	regWrite=0;
	nest=0; Aluop=4'hF; branch=0;
	#40
	regWrite=1;
	nest=1;
	$monitor("At time %t, address = %h(%0d), op1 =%h (%0d), op2 = %h(%0d), result = %h (%0d)",$time, result_address, result_address,op1, op1, op2, op2, result, result);
	#20
	regWrite=0;
	nest=0; Aluop=4'hF; 
	#40
	regWrite=1;
	nest=1; 
	$monitor("At time %t, address = %h(%0d), op1 =%h (%0d), op2 = %h(%0d), result = %h (%0d)",$time, result_address, result_address,op1, op1, op2, op2, result, result);
	#20
	regWrite=0;
	nest=0; exSign=2; AluSrcB=0; AluScrA=0; Aluop=4'hF; memToReg=0; memWrite=2;
	#60
	regWrite=1;
	nest=1;
	$monitor("At time %t, address = %h(%0d), op1 = %h(%0d), op2 = %h(%0d), reg1 = %h (%0d), reg2 = %h (%0d), Rout = %h(%0d), Rout2 = %h (%0d), result = %h (%0d), extend = %h(%d) ",$time, result_address, result_address, op1, op1, op2, op2, moveALU2, moveALU2, moveALU, moveALU, Rout1, Rout1, Rout2, Rout2, result, result, extend, extend);
	#20
	regWrite=0;
	nest=0; exSign=2; Aluop=4'hF; AluScrA=1; AluSrcB=1; memToReg=1; memWrite=0;
	#40
	regWrite=1;
	nest=1;
	$monitor("At time %t, address = %h(%0d), op1 =%h (%0d), op2 = %h(%0d), result = %h (%0d)",$time, result_address, result_address,op1, op1, op2, op2, result, result);
	#20
	regWrite=0;
	nest=0; Aluop=4'hF; exSign=2; AluScrA=0; AluSrcB=0;
	#60
	memWrite=1;
	nest=1;
	$monitor("At time %t, address = %h(%0d), op1 =%h (%0d), op2 = %h(%0d), result = %h (%0d)",$time, result_address, result_address,op1, op1, op2, op2, result, result);
	#20
	nest=0; memWrite=2'b10; Aluop=4'hF; memToReg=0;
	#60
	regWrite=1;
	nest=1;
	$monitor("At time %t, address = %h(%0d), op1 =%h (%0d), op2 = %h(%0d), result = %h (%0d)",$time, result_address, result_address,op1, op1, op2, op2, result, result);
	#20
	nest=0; AluScrA=1; AluSrcB=1; Aluop=4'hF; memToReg=1; 
	#40
	regWrite=1;
	nest=1; 
	$monitor("At time %t, address = %h(%0d), op1 =%h (%0d), op2 = %h(%0d), result = %h (%0d)",$time, result_address, result_address,op1, op1, op2, op2, result, result);
	#20
	regWrite=0;
	nest = 0; Aluop= 4'hE;
	#40
	regWrite=1;
	nest=1;
	$monitor("At time %t, address = %h(%0d), op1 =%h (%0d), op2 = %h(%0d), result = %h (%0d)",$time, result_address, result_address,op1, op1, op2, op2, result, result);
	#20
	regWrite=0;
	nest=0; Aluop=4'hF; AluScrA=1; AluSrcB=1; memToReg=1;
	#40
	regWrite=1;
	nest=1
	$monitor("At time %t, address = %h(%0d), op1 =%h (%0d), op2 = %h(%0d), result = %h (%0d)",$time, result_address, result_address,op1, op1, op2, op2, result, result);
	#20
	regWrite=0;
	$stop;
end

endmodule