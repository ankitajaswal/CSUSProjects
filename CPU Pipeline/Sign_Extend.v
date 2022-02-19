module Sign_Extend(extend, result, exSign);

input [1:0] exSign;
input signed [7:0] extend;
output signed [15:0] result;

reg signed [15:0] result;

always@(extend or exSign)
begin
	if(exSign == 2)
	begin
		result = {extend[3], extend[3], extend[3], extend[3], extend[3], extend[3], extend[3], extend[3], extend[3], extend[3], extend[3], extend[3], extend[3], extend[2:0]};
	end
	else if(exSign == 1)
	begin
		result = {extend[7], extend[7], extend[7], extend[7], extend[7], extend[7], extend[7], extend[7], extend[7], extend[7], extend[7], extend[7], extend[7], extend[6:4]};
	end
	else
		result = {extend[7], extend[7], extend[7], extend[7], extend[7], extend[7], extend[7], extend[7], extend[7],extend[6:0]};
end

endmodule