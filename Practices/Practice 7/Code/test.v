`include "baud.v"

`timescale 1ps/1ps
module Tester();

    reg send_clk, rec_clk, rstN, send_new_data;
    reg [6:0] send_data;

    wire tx, busy, rec_new_data, correct_data;
    wire [6:0] rec_data;

    BaudReciever reciever (rec_data, rec_new_data, correct_data, tx, rstN, rec_clk);

    BaudSender sender (tx, busy, send_data, send_new_data, rstN, send_clk);

    always begin
        #1
        send_clk = ~send_clk;
        #1
        rec_clk = ~rec_clk;
        if (correct_data == 1) begin
            send_new_data = 0;
        end
    end

    initial begin
        send_clk = 0;
        rec_clk = 0;
        send_data = 7'b1011001;
        rstN = 0;
        send_new_data = 1;
        #1000
        rstN = 1;
        $monitor("%d %d", tx, busy);
    end
endmodule

