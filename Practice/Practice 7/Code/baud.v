`include "sender.v"
`include "reciever.v"

module BaudSender (tx, busy, data, new_data, rstN, clk);
    parameter CLOCK_RATE = 50000000;
    parameter BAUD_RATE = 115200;

    output tx, busy;
    input [6:0] data;
    input new_data, rstN, clk;

    reg tick;
    reg [31:0] counter;

    UARTSender sender(tx, busy, data, new_data, rstN, tick);

    always @(posedge clk) begin
        if (~rstN) begin
            tick <= 0;
        end
        else begin
            if (counter < CLOCK_RATE / BAUD_RATE) begin
                counter <= counter + 1;
            end
            else begin
                tick <= ~tick;
                counter <= 0;
            end
        end
    end
endmodule

module BaudReciever (data, new_data, correct_data, rx, rstN, clk);
    parameter CLOCK_RATE = 50000000;
    parameter BAUD_RATE = 115200;

    input rx, rstN, clk;
    output new_data, correct_data;
    output [6:0] data;

    reg tick;
    reg [31:0] counter;

    UARTReciever reciever(data, new_data, correct_data, rx, rstN, tick);

    always @(posedge clk) begin
        if (~rstN) begin
            tick <= 0;
        end
        else if (new_data) begin
            if (counter < CLOCK_RATE / BAUD_RATE) begin
                counter <= counter + 1;
            end
            else begin
                tick <= ~tick;
                counter <= 0;
            end
        end
    end
endmodule