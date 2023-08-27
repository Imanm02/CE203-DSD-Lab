module testbench;
reg sys_clk = 0;
always #5 sys_clk = ~sys_clk; // Clock frequency

reg reset = 1;
initial #10 reset = 0;

reg load;
reg [6:0] transmitter_data;
wire tx;
reg rx;
wire [6:0] receiver_data_out;
wire receiver_ready;

UART_Transmitter tx_module (
    .sys_clk(sys_clk),
    .reset(reset),
    .load(load),
    .data_in(transmitter_data),
    .tx(tx)
);


UART_Receiver rx_module (
    .sys_clk(sys_clk),
    .rx(rx),
    .data_out(receiver_data_out),
    .ready(receiver_ready)
);

initial begin
    load = 0;
    #20 transmitter_data = 7'b1010101; load = 1;
    #10 load = 0;
    #20 rx = tx;
end

endmodule 