module TopLevel(
    input sys_clk,
    input rx,
    output [6:0] data_out,
    output ready
);

    UART_Receiver u1 (
        .sys_clk(sys_clk),
        .rx(rx),
        .data_out(data_out),
        .ready(ready)
    );

endmodule 