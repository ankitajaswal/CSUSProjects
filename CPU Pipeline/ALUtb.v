module ALUtb;

reg [3:0] funct;
reg signed [15:0] Rout1, Rout2;
wire signed [15:0] result, R0;
wire branch;

ALU test(funct, Rout1, Rout2, R0, result, branch);

initial 
begin
	Rout1=16'haaaa; Rout2=16'haaaa; funct =4'hF;
	$monitor("At time %t, result = %h (%0d)",$time, result, result);
	#20;
	Rout1=-5; Rout2=2; funct =4'hE;
	$monitor("At time %t, result = %h (%0d)",$time, result, result);
	#20
	Rout1=5; Rout2=7; funct =4'hD;
	$monitor("At time %t, result = %h (%0d)",$time, result, result);
	#20
	Rout1=5; Rout2=8; funct =4'hC;
	$monitor("At time %t, result = %h (%0d)",$time, result, result);
	#20
	$monitor("At time %t, R0 = %h (%d), result = %h (%0d)",$time, R0, R0, result, result);
	Rout1=5; Rout2=4; funct =4'h1;
	#20
	$monitor("At time %t, R0 = %h (%d), result = %h (%0d)",$time, R0, R0, result, result);
	Rout1=5; Rout2=4; funct =4'h2;
	#20
	$monitor("At time %t, R0 = %h (%d), result = %h (%0d)",$time, R0, R0, result, result);
	Rout1=5; Rout2=4; funct =4'hA;
	#20
	$monitor("At time %t, R0 = %h (%d), result = %h (%0d)",$time, R0, R0, result, result);
	Rout1=5; Rout2=4; funct =4'hB;
	#20
	$monitor("At time %t, R0 = %h (%d), result = %h (%0d)",$time, R0, R0, result, result);
	Rout1=5; Rout2=4; funct =4'h8;
	#20
	$monitor("At time %t, R0 = %h (%d), result = %h (%0d)",$time, R0, R0, result, result);
	Rout1=5; Rout2=4; funct =4'h9;
	#20
	$monitor("At time %t, R0 = %h (%d), result = %h (%0d)",$time, R0, R0, result, result);
	Rout1=5; Rout2=16; funct =4'h9;
	#20
	$monitor("At time %t, R0 = %h (%d), result = %h (%0d)",$time, R0, R0, result, result);
	Rout1=5; Rout2=18; funct =4'h9;
	#20
	$stop;
end

endmodule