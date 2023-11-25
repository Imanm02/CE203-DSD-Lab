module UARTReciever (data, new_data, correct_data, rx, rstN, clk);
    input rx, rstN, clk;
    output reg new_data, correct_data;
    output reg [6:0] data;

    reg [1:0] state;
    reg [2:0] index_pointer;
    reg parity;

    always @(posedge clk or negedge rstN) begin
        if (~rstN) begin
            state <= 0;
            index_pointer <= 0;
            data <= 0;
            new_data <= 1;
        end
        else begin
            if (state == 0 && rx == 0) begin
                state <= 1;
                index_pointer <= 0;
                data <= 0;
                new_data <= 1;
            end
            else if (state == 1) begin
                state <= 2;
                parity <= rx;
            end
            else if (state == 2) begin
                data[index_pointer] <= rx;
                index_pointer <= index_pointer + 1;
                if (index_pointer == 6) begin
                    state <= 3;
                end
            end
            else if (state == 3) begin
                correct_data <= (^data == parity);
                state <= 0;
                new_data <= 0;
            end
        end
    end

endmodule