module Signtb;

reg [1:0] exSign;
reg signed [7:0] extend;

wire signed [15:0] result;

Sign_Extend test(extend, result, exSign);

initial
begin
	exSign = 2; extend=0;
	$monitor("At time %t, result = %h (%0d)",$time, result, result);
	#20
	exSign = 0; extend=-5;
	$monitor("At time %t, result = %h (%0d)",$time, result, result);
	#20
	$stop;
end

endmodule