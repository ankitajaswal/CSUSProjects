module ALU(funct, Rout1, Rout2, R0, result, branch);
input [3:0] funct;
input signed [15:0] Rout1, Rout2;
output signed [15:0] result, R0;
output reg branch;

reg [15:0] result, R0;
reg [15:0] tempA, tempB;
integer temp;

always@(*)
begin
	result = 0;
	R0 = 0;
	tempA=0;
	tempB=0;

	case(funct)

		4'b1111:
		begin
			result = Rout1+Rout2;
			branch = 1'b0;
		end 

		4'b1110:
		begin
			result = Rout1 - Rout2;
			branch = 1'b0;
		end

		4'b1101:
		begin
			result = (Rout1 & Rout2);
			branch = 1'b0;
		end

		4'b1100:
		begin
			result = (Rout1 | Rout2);
			branch = 1'b0;
		end

		4'b0001:
		begin
			{R0, result} = Rout1*Rout2;
			branch = 1'b0;
		end

		4'b0010:
		begin
			result = Rout1/Rout2;
			R0 = Rout1%Rout2;
			branch = 1'b0;
		end

        4'b1010:
		begin
			result = {Rout1<<Rout2};
			branch = 1'b0;
		end

		4'b1011:
		begin
			result = {Rout1>>Rout2};
			branch = 1'b0;
		end
		
		// Branch Less than
		4'b0011:
		begin
			if( Rout1 <  Rout2)
				branch = 1;
			else
				branch=0;
		end
		//Branch Greater than
		4'b0100:
		begin
			if( Rout1 > Rout2)
				branch=1;
			else
				branch=0;
		end
		//Branch Equal than
		4'b0101:
		begin
			if(Rout1 == Rout2)
				branch =1;
			else 
				branch = 0;
		end

		//Rotating Left
		4'b1000:
		begin
			branch = 1'b0;
			if(Rout2 >= 16)
				tempA = 16%Rout2;
			else
				tempA = Rout2;
			if(tempA == 0)
				result = Rout1;
			else if (tempA == 1)
			begin
				result ={Rout1[14:0], Rout1[15]};
			end
			else if (tempA == 2)
			begin
				result ={Rout1[13:0], Rout1[15:14]};
			end
			else if (tempA == 3)
			begin
				result ={Rout1[12:0], Rout1[15:13]};
			end
			else if (tempA == 4)
			begin
				result ={Rout1[11:0], Rout1[15:12]};
			end
			else if (tempA == 5)
			begin
				result ={Rout1[10:0], Rout1[15:11]};
			end
			else if (tempA == 6)
			begin
				result ={Rout1[9:0], Rout1[15:10]};
			end
			else if (tempA == 7)
			begin
				result ={Rout1[8:0], Rout1[15:9]};
			end
			else if (tempA == 8)
			begin
				result ={Rout1[7:0], Rout1[15:8]};
			end
			else if (tempA == 9)
			begin
				result ={Rout1[6:0], Rout1[15:7]};
			end
			else if (tempA == 10)
			begin
				result ={Rout1[5:0], Rout1[15:6]};
			end
			else if (tempA == 11)
			begin
				result ={Rout1[4:0], Rout1[15:5]};
			end
			else if (tempA == 12)
			begin
				result ={Rout1[3:0], Rout1[15:4]};
			end
			else if (tempA == 13)
			begin
				result ={Rout1[2:0], Rout1[15:3]};
			end
			else if (tempA == 14)
			begin
				result ={Rout1[1:0], Rout1[15:2]};
			end
			else if (tempA == 15)
			begin
				result ={Rout1[0], Rout1[15:1]};
			end
		end 
		// Rotating Right
		4'b1001:
		begin
			branch = 1'b0;
			if(Rout2 >= 16)
				tempA = Rout2%16;
			else
				tempA = Rout2;
			if(tempA == 0)
				result = Rout1;
			else if (tempA == 1)
			begin
				result ={Rout1[0], Rout1[15:1]};
			end
			else if (tempA == 2)
			begin
				result ={Rout1[1:0], Rout1[15:2]};
			end
			else if (tempA == 3)
			begin
				result ={Rout1[2:0], Rout1[15:3]};
			end
			else if (tempA == 4)
			begin
				result ={Rout1[3:0], Rout1[15:4]};
			end
			else if (tempA == 5)
			begin
				result ={Rout1[4:0], Rout1[15:5]};
			end
			else if (tempA == 6)
			begin
				result ={Rout1[5:0], Rout1[15:6]};
			end
			else if (tempA == 7)
			begin
				result ={Rout1[6:0], Rout1[15:7]};
			end
			else if (tempA == 8)
			begin
				result ={Rout1[7:0], Rout1[15:8]};
			end
			else if (tempA == 9)
			begin
				result ={Rout1[8:0], Rout1[15:9]};
			end
			else if (tempA == 10)
			begin
				result ={Rout1[9:0], Rout1[15:10]};
			end
			else if (tempA == 11)
			begin
				result ={Rout1[10:0], Rout1[15:11]};
			end
			else if (tempA == 12)
			begin
				result ={Rout1[11:0], Rout1[15:12]};
			end
			else if (tempA == 13)
			begin
				result ={Rout1[12:0], Rout1[15:13]};
			end
			else if (tempA == 14)
			begin
				result ={Rout1[13:0], Rout1[15:14]};
			end
			else if (tempA == 15)
			begin
				result ={Rout1[14:0], Rout1[15]};
			end
		end
    endcase
end

endmodule
