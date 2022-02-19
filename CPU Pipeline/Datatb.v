module Datatb;

reg [15:0] addr, wdata;
reg clk, reset, read, write;

wire [15:0] readout;

Data_Mem test(clk, reset, addr, wdata, read, write, readout);

always#10 clk=~clk;

initial 
begin
	reset=1; clk=0; addr=0; wdata=0; read=0; write=0;
	#20
	reset=0; read=1;
	$monitor("At time %t, readout = %h (%0d)",$time, readout, readout);
	#20
	read=1; addr=1;
	$monitor("At time %t, readout = %h (%0d)",$time, readout, readout);
	#20
	addr=50;
	$monitor("At time %t, readout = %h (%0d)",$time, readout, readout);
	#20
	addr=1; read=0; wdata=5; write=1;
	$monitor("At time %t, readout = %h (%0d)",$time, readout, readout); 
	#20
	wdata=0; read=1; write=0;
	$monitor("At time %t, readout = %h (%0d)",$time, readout, readout);
	$stop;
end

endmodule
