module UARTSender (tx, busy, data, new_data, rstN, clk);

    output reg tx, busy;
    input [6:0] data;
    input new_data, rstN, clk;

    reg [2:0] state;
    reg [2:0] index_pointer;

    always @(posedge clk or negedge rstN) begin
        if (~rstN) begin
            state <= 0;
            index_pointer <= 0;
            tx <= 1;
            busy <= 0;
        end
        else begin
            if (state == 0 && new_data) begin
                state <= 1;
                index_pointer <= 0;
                busy <= 1;
            end
            else if (state == 1) begin
                state <= 2;
                tx <= 0;
            end
            else if (state == 2) begin
                state <= 3;
                tx <= ^data;
            end
            else if (state == 3) begin
                tx <= data[index_pointer];
                index_pointer <= index_pointer + 1;
                if (index_pointer == 6) begin
                    state <= 4;
                end
            end
            else if (state == 4) begin
                state <= 0;
                tx <= 1;
                busy <= 0;
            end
        end
    end
    
endmodule