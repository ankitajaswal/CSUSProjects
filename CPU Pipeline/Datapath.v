module Datapath(clk, reset, result, extend, result_address, intout, mathR1, mathR2, Aluresult, op1, op2, Rout1, Rout2, CAluop, Finresult, mathA, MmemToReg, BmemToReg, CmemToReg, BregWrite, final, branchadd, plus2, stall, resume, Flocation, exHold, extended);

input clk, reset ;

output [15:0] result, result_address, intout, mathR1, mathR2, Aluresult, Rout1, Rout2, Finresult, mathA, branchadd, plus2, exHold, extended; 
output [3:0] op1, op2, CAluop, Flocation;
output [2:0] resume;
output [1:0] BregWrite;
output BmemToReg, MmemToReg, CmemToReg, final, stall;
wire [15:0]  moveALU, moveALU2, instruction;
wire [15:0] readout;
output [7:0] extend;
wire [3:0] Fwriteback, op1pass;
wire [1:0] CregWrite; 

wire [1:0] MregWrite, MmemWrite;
wire AluSrcA, AluSrcB, jump, branch, memToReg, proceed;
wire CAluSrcA, CAluSrcB, Cbranch, Mbranch; 
wire [1:0] regWrite, memWrite, signEx;
wire [1:0] CmemWrite;
wire [3:0] Aluop;

wire [15:0] current_address;
wire [15:0] immediate; 
wire [15:0] jumpadd, try;
wire [3:0] funct;
wire [15:0] joffset, read, R1data;
wire [15:0] holdR1, holdR2, saveR0, R0out, Finbranch, FinR0, branchCorrectly;

PC location(current_address, result_address, reset, clk, stall, resume);
IntMemory action(reset, result_address, instruction, stall, resume);

adder pcin(result_address, 2, plus2);

ID_IF fetch(clk, plus2 , instruction, intout, final, stall, resume);

Control_Unit control(reset, intout[15:12], intout[3:0], signEx, regWrite, memWrite, Aluop, AluSrcA, AluSrcB, memToReg, branch, jump, extra);


assign op1 = intout[11:8];
assign op2 = intout[7:4];
assign funct = intout[3:0];
assign joffset = {op1[3], op1[3], op1[3], op1[3], op1, op2, funct};
assign extend = {intout[7:0]};



assign jumpadd = joffset + plus2;

Sign_Extend big(extend, extended, signEx);
Register_File regFile(clk, op1, op2, result, saveR0, Rout1, Rout2, BregWrite, reset, extra, Flocation);

ID_EX ex_cute(clk, reset, Aluop, op1, AluSrcA, AluSrcB, branch, memToReg, regWrite, memWrite, Rout1, Rout2, extended, mathR1, mathR2, exHold, CAluop, CAluSrcA, CAluSrcB, Cbranch, CmemToReg, CregWrite, CmemWrite, op1pass, Aluresult, op2, R0out, proceed, Fwriteback, Finresult, plus2, branchCorrectly);


mux2to1 aluSrcB(mathR2, exHold, CAluSrcB, moveALU);
mux2to1 aluSrcA(mathR1, mathR2, CAluSrcA, moveALU2);

ALU math(CAluop, moveALU2, moveALU, R0out, Aluresult, proceed);

assign immediate = exHold<<1;
adder move(immediate, branchCorrectly, branchadd);
assign final = (Cbranch & proceed);
mux2to1 next(branchadd, plus2, final, try);
mux2to1 finally(try, jumpadd, jump, current_address);

EX_MEM cont(clk, reset, branchadd, Aluresult, Cbranch, op1pass, mathR1, R0out, CmemWrite, CregWrite, CmemToReg, Finbranch, Finresult, Fwriteback, FinR0, MmemWrite, MregWrite, MmemToReg, R1data, Mbranch, proceed);


Data_Mem memory(clk, reset, Finresult, R1data, MmemWrite, readout);

MEM_WB last(clk, reset, Finresult, readout, Fwriteback, FinR0, MregWrite, MmemToReg, read, Flocation, saveR0, BmemToReg, BregWrite, mathA);

mux2to1 Write(mathA, read, BmemToReg, result);

endmodule