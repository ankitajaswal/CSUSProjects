/*This module is the control unit with signals to control the datapath
*ALU control signals are incorporated w/n this module
*/
module Control_Unit(reset, Op, Funct, signEx, regWrite, memWrite, ALUop, ALUSrcA, ALUSrcB, memToReg, branch, jump, extra);
	input reset;
    input [3:0] Op, Funct;
    output reg [1:0] regWrite, signEx, memWrite;
    output reg [3:0] ALUop, ctrlOp;
    output reg RegDest, ALUSrcA, ALUSrcB, memToReg, branch, jump, extra;

always @(Op or Funct)
begin
        // initialize all signals to 0
		if(reset == 1'b0)begin
			signEx = 2'b00;
			regWrite = 2'b00;
			memWrite = 2'b00;
			ALUop = 4'b0000;
			ALUSrcA = 1'b1;
			ALUSrcB = 1'b1;
			memToReg = 1'b1;
			branch = 0;
			extra=0;
			jump = 1;
		end
		//else 
        //begin
    	case(Op)
    		4'b0000: begin
                // Signed Addition Signal, Signed Subtraction Signal, And Signal, OR Signal
                if((Funct == 4'b1111) || (Funct == 4'b1110) || (Funct == 4'b1101) || (Funct == 4'b1100) ) begin
                    regWrite <= 1;
                    ALUop <= Funct;
                    ALUSrcB <= 1;
                    ALUSrcA <= 1;
                    memToReg <= 1;
                    branch <= 0;
                    extra <= 0;
                    jump <= 1;
                end

                //Signed Multiplication Signal, Signed Division Signal
                else if((Funct == 4'b0001) || (Funct == 4'b0010)) begin
					extra <= 0;
                    regWrite <= 2;
                    ALUSrcB <= 1;
                    ALUSrcA <= 1;
                    ALUop <= Funct;
                    memToReg <= 1;
                    branch <= 0;
                    jump <= 1;

                end

                // Shift Reg Left or Right, Rotating Right or Left
                else if((Funct == 4'b1010) || (Funct == 4'b1011) || (Funct == 4'b1001) || (Funct == 4'b1000) ) begin
                    regWrite <= 1;
                    RegDest <= 1;
                    ALUSrcA <= 1;
                    ALUSrcB <= 0;
                    ALUop <= Funct;
                    memToReg <= 1;
                    signEx <= 1;
                    branch <= 0;
                    extra <= 0;
                end

            end

            // Load signal
            4'b1000: begin
            	regWrite <= 1;
                memWrite <= 2;
                ALUSrcB <= 0;
                ALUSrcA <= 0;
                memToReg <= 0;
                signEx <= 2;
                jump <= 1;
                branch <= 0;
                ALUop <= 4'hF;
                extra <= 0;
            end

            // Store signal
            4'b1011: begin
                regWrite=0;
                memWrite <= 1;
                ALUSrcB <= 0;
                ALUSrcA <= 0;
                ALUop <= 4'hF;
                signEx <= 2;
                jump <= 1;
                branch <= 0;
                extra <= 0;
            end
			    

            // BLT signal
            4'b0100: begin
                regWrite <= 0;
                ALUSrcA <= 1;
                ALUSrcB <= 1;
                memWrite <= 0;
                branch <= 1;
                signEx <= 0;
                jump <= 1;
                ALUop <= 4'h3;
                extra <= 1;
            end

            // BGT signal
            4'b0101: begin
                regWrite <= 0;
                ALUSrcA <= 1;
                ALUSrcB <= 1;
                memWrite <= 0;
                branch <= 1;
                signEx <= 0;
                jump <= 1;
                ALUop <= 4'h4;
                extra <= 1;
            end

            // Beq Signal
            4'b0110: begin
                regWrite <= 0;
                ALUSrcA <= 1;
                ALUSrcB <= 1;
                memWrite <= 0;
                branch <= 1;
                signEx <= 0;
                jump <= 1;
                ALUop <= 4'h5;
                extra <= 1;
            end

            // Jump Signal
            4'b1100: begin
                regWrite <= 0;
                memWrite <= 0;
                jump <= 0;
                branch <= 0; 
            end

            // Halt Signal
            4'b0000: begin
            end
        endcase
        //end
end

endmodule
