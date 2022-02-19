module mux2to1(A, B, s, out);

input s;
input [15:0] A, B;

output reg [15:0] out;

always@(A or B or s)
begin
	if(s)
		out=A;
	else
		out=B;
end

endmodule