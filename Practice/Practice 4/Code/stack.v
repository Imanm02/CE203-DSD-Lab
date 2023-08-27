module stack(input Clk, input RstN, input [3:0] Data_In, input Push, input Pop, output reg [3:0] Data_Out, output reg Full, output reg Empty);

	reg [3:0] mem [7:0];
	reg [3:0] pointer = 0;

	always @(posedge Clk or negedge RstN)
	begin
		if (~RstN)
			pointer = 0;
		else if (Push == 1 & Full == 0)
		begin
			mem[pointer] = Data_In;
			pointer = pointer + 1;
		end
		else if (Pop == 1 & Empty == 0)
		begin
			Data_Out = mem[pointer-1];
			pointer = pointer - 1;
			end
		Full = ~|(pointer ^ 8);
		Empty = ~|pointer;
	end
endmodule