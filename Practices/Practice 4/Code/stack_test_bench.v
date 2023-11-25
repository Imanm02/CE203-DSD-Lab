module stack_tb();

	reg         clk = 0, reset = 0, push = 0, pop = 0;
	reg [3:0]   data_in;
	wire        full, empty;
	wire [3:0]  data_out;

stack st(
    .Clk(clk),
    .RstN(reset),
    .Push(push),
    .Pop(pop),
    .Data_In(data_in),
    .Data_Out(data_out),
    .Full(full),
    .Empty(empty)
);

always #10 clk = ~clk;

initial begin
    $monitor("data_out = %d, Full = %d, Empty = %d", data_out, full, empty);
    #20 reset = 1;
    push = 1;
    for (data_in = 2; data_in < 11; data_in = data_in + 1) begin
        #20;
    end
    push = 0;
    pop = 1;
    for (data_in = 0; data_in < 9; data_in = data_in + 1) begin
      #20;
    end
    push = 1;
    data_in = 7;
    #20;
    #20 reset = 0;
    #20;
    $stop;
end

endmodule