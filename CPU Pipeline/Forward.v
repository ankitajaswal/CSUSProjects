module Forward(clk, reset, signEx, regWrite, memWrite, ALUop, holdop1, holdop2, giveop1, giveop2, ALUSrcA, ALUSrcB, memToReg, branch, jump, extra, Rout1, Rout2, extend, extended, R0out, Aluresult, holdR1, holdR2, mathR1, mathR2, exRel, exHold, exMath, save, saveR0, CALUop, CregWrite, CsignEx, CmemWrite, CALUSrcA, CALUSrcB, CmemToReg, Cbranch, Cjump, R0, IF_ID, EX_MEM, Fwriteback, saveR1F, readout, givereadout, Finalresult, proceed);

input clk, reset, ALUSrcA, ALUSrcB, memToReg, branch, jump, extra, proceed;
input [1:0] signEx, regWrite, memWrite;
input [3:0] ALUop, holdop1, holdop2;
input [7:0] extend;
input [15:0] Rout1, Rout2, extended, R0out, Aluresult, readout, Finalresult;

output reg [1:0] CregWrite, CsignEx, CmemWrite;
output reg [3:0] CALUop, giveop1, giveop2, Fwriteback;
output reg CALUSrcA, CALUSrcB, CmemToReg, Cbranch, Cjump, R0;
output reg [7:0] exRel;
output reg [15:0] holdR1, holdR2, mathR1, mathR2, exHold, exMath, save, saveR0, saveR1F, givereadout; 
output [15:0] IF_ID, EX_MEM;
wire [15:0]  instruction, current_address, result_address;

//Pipeline signal declarations
/*
*IF_ID holds nextPC and makes sure word is realigned; if not realigned, source back to PC adder and realign
* move onto next stage
*ID_EX will check op1 and op2 and make sure they are non-zero; check to see if op2 is signEx, if not do that and *move onto the next stage
*EX_MEM will check ALUSrcA, ALUSrcB, branch, ALUop, jump 
* If jump - PC >> 2 and PC + 4;
*MEM_WB will check regWrite, memWrite, MemtoReg, 
*/
reg [15:0] IF_ID, ID_EX, EX_MEM, MEM_WB, exWait, Hold;
reg [15:0] R1save, R1savestg2, R1savestg3, save2;
reg [7:0] exStall;
reg [3:0] first, math, math2, math3, math4;
reg [3:0] writeback, writebackstage2, writebackstage3, writeback4;
reg [1:0] exSignW;
reg dependant, dependant2, dependant3, dependant4, finalde;

always@(negedge clk)
begin
	if(!reset)
	begin
		IF_ID=0;
		ID_EX=0;
		EX_MEM=0;
		MEM_WB = 0;
		first=0;
		Cjump = 1;
		Cbranch = 0;
	end

	if(first==0)
	begin
		giveop1 <= holdop1;
		giveop2 <= holdop2;
		writeback <= holdop1;
		IF_ID <= {extra, ALUop, signEx, regWrite, memWrite, ALUSrcA, ALUSrcB, memToReg, branch, jump };
		first <= first+1;
	end
	else
	begin
		if(proceed)
		begin
			IF_ID <={extra,ALUop, signEx, regWrite, memWrite, ALUSrcA, ALUSrcB, memToReg, branch, jump};
			ID_EX <= 0;
			EX_MEM <= 0;
			MEM_WB <= 0;
			CregWrite<=0;
			first=1;
		end
		else
		begin
			ID_EX <= IF_ID;
			EX_MEM <=ID_EX;
			MEM_WB <= EX_MEM;
			IF_ID <= {extra, ALUop, signEx, regWrite, memWrite, ALUSrcA, ALUSrcB, memToReg, branch, jump };
			if(first <= 6)
				first <= first+1;
		end
	end

	if(reset)
	begin
		if(first == 1)
		begin
			giveop1 <= holdop1;
			giveop2 <= holdop2;
			writeback <= holdop1;
			if(holdop1 == holdop2)
				dependant <= 1;
			else
				dependant<=0;
			exStall <= extend;
			Cjump <= {IF_ID[0]};
			CsignEx<= {IF_ID[10:9]};
		end
		else if(first == 2)
		begin
			exRel <= exStall;
			giveop1 <= holdop1;
			giveop2 <= holdop2;
			exRel <= exStall;
			exStall <= extend;
			writebackstage2 <= writeback;
			writeback <= holdop1;
			dependant2 <= dependant;
			if(holdop1 == holdop2)
				dependant <= 1;
			else
				dependant<=0;
			Cjump <= {IF_ID[0]};
			R0 <= {ID_EX[15]};
			CsignEx <= {IF_ID[10:9]};
			exWait <= extended;
			holdR1 <= Rout1;
			R1save <= Rout1;
			holdR2 <= Rout2;
		end
		else if(first == 3)
		begin
			writebackstage3 <= writebackstage2;
			writebackstage2 <= writeback;
			writeback <= holdop1;
			R1savestg2 <= R1save;
			dependant3 <= dependant2;
			dependant2 <= dependant;
			if(holdop1 == holdop2)
				dependant <= 1;
			else
				dependant<=0;
			exRel <= exStall;
			exHold <= exWait;
			exStall <= extend;
			giveop1 <= holdop1;
			giveop2 <= holdop2;
			mathR1 <= holdR1;
			mathR2 <= holdR2;
			exMath <= exHold;
			Cjump <= {IF_ID[0]};
			R0 <= {ID_EX[15]};
			CsignEx <= {IF_ID[10:9]};
			holdR1 <= Rout1;
			R1save <= Rout1;
			holdR2 <= Rout2;
			exWait <= extended;
			CALUSrcA <= {EX_MEM [4]};
			CALUSrcB <= {EX_MEM [3]};
			CALUop <= {EX_MEM[14:11]};
			math <= {EX_MEM[14:11]};
		end
		else if (first >= 4)
		begin
			Fwriteback <= writeback4;
			writeback4 <= writebackstage3;
			writebackstage3 <= writebackstage2;
			writebackstage2 <= writeback;
			writeback <= holdop1;
			saveR1F <= R1savestg2;
			R1savestg2 <= R1save;
			finalde <= dependant4;
			dependant4 <= dependant3;
			dependant3 <= dependant2;
			dependant2 <= dependant;
			if(holdop1 == holdop2)
				dependant <= 1;
			else
				dependant <= 0;

			givereadout<=readout;
			save <= save;
			save <=Aluresult;
			saveR0 <= R0out;
			exHold <= exWait;
			exRel <= exStall;
			exStall <= extend;
			giveop1 <= holdop1;
			giveop2 <= holdop2;
			
			if( writeback4 == writebackstage3 )
			begin
					if(CmemToReg ==0)
						mathR1 <=Finalresult;
					else
						mathR1 <= Aluresult;
			end
			else if( (Fwriteback == writebackstage3) && (CregWrite>=1)  )
				mathR1 <=save;
			else
				mathR1<=holdR1;


			if( dependant4 )
				if( writeback4 == writebackstage3)	
				begin			
					mathR2 <=Aluresult; 
				end
				else
					mathR2 <= holdR2;
			else
				mathR2 <= holdR2;
			
			exMath <= exHold;
			Cjump <= {IF_ID[0]};
			R0 <= {ID_EX[15]};
			CsignEx <= {IF_ID[10:9]};
			//if( (Fwriteback == writebackstage3) && (CregWrite>=1)  )
			//	holdR1 <=Aluresult;
			//else
				holdR1 <= Rout1;
			R1save <= holdR1;
			holdR2 <= Rout2;
			exWait <= extended;
			CALUSrcA <= {EX_MEM [4]};
			CALUSrcB <= {EX_MEM [3]};
			CALUop <= {EX_MEM[14:11]};
			Cbranch <= {EX_MEM[1]};
			CmemToReg <= {MEM_WB[2]};
			CregWrite <={MEM_WB[8:7]};

		end
		/*else if(first >= 4)
		begin
			giveop1 <= holdop1;
			giveop2 <= holdop2;
			saveR0 <= R0out;
			save <= Aluresult;
			mathR1 <= holdR1;
			mathR2 <= holdR2;
			exMath <= exHold;
			Cjump<={IF_ID[0]};
			R0 <= {ID_EX[15]};
			CsignEx <= {ID_EX[10:9]};
			holdR1 <= Rout1;
			holdR2 <= Rout2;
			exHold <= extend;
			CALUSrcA <= {EX_MEM [4]};
			CALUSrcB <= {EX_MEM [3]};
			CALUop <= {EX_MEM[14:11]};
			Cbranch <= {EX_MEM[1]};
			CmemToReg <= {MEM_WB[2]};
			CregWrite <={MEM_WB[8:7]};
		end*/
	end
end

endmodule
