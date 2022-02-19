module pipetb;

reg clk, reset;

wire [15:0] result, mathA, result_address, moveALU, moveALU2, Rout1, Rout2, intout, Aluresult, Finresult, EX_MEM, exHold, mathR1, mathR2, readout, branchaddr, plus2, extended;
wire [7:0] extend;
wire [3:0] op1, op2, CALUop, Fwriteback, Aluop, Flocation, op1pass;
wire [1:0] CexSign, CregWrite, regWrite;
wire [2:0] resume;
wire CmemToReg, CAluSrcA, CAluSrcB, MmemToReg, memToReg, final, stall;

Datapath pipeline(clk, reset, result, extend, result_address, intout, mathR1, mathR2, Aluresult, op1, op2, Rout1, Rout2, CALUop, Finresult, mathA, memToReg, MmemToReg, CmemToReg, regWrite, final, branchaddr, plus2, stall, resume, Flocation, exHold, extended);


always#10 clk = ~clk;
initial
begin
	$monitor("At time %t, address = %h(%0d), instruction = %h, result = %h(%0d) \nop1=%h(%0d), op2=%h(%d), Rout1=%h, Rout2=%h\nmathR1=%h(%0d), mathR2=%h(%0d), Aluresult= %h(%0d) CALUop = %h(%0d)\nFinresult=%h(%0d) mathA=%h(%0d) CmemToReg=%h MmemToReg=%h BmemToReg= %h\nregWrite=%h branched=%h branchedaddr=%h(%0d) plus2=%h(%0d) stall=%h resume=%h\n extended=%h(%0d)\n",$time, result_address, result_address, intout, result, result, op1, op1, op2, op2, Rout1, Rout2, mathR1, mathR1, mathR2, mathR2, Aluresult, Aluresult, CALUop, CALUop, Finresult, Finresult, mathA, mathA, CmemToReg, memToReg, MmemToReg, regWrite, final, branchaddr, branchaddr, plus2, plus2, stall, resume, exHold, exHold);
	clk=1; reset=0;
	#20
	reset=1;
	#760
	$stop;
end

endmodule
