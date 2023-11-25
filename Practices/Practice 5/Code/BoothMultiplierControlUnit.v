module BoothMultiplierControlUnit(
    input [3:0] multiplier,
    input clk, str,            
    output valid, load, arth, shiftRight,
    output [2:0] booth_bits
);

    reg [3:0] current_state, next_state;
    reg [2:0] counter;

    assign load = current_state[0];
    assign arth = current_state[1];
    assign shiftRight = current_state[2];
    assign valid = current_state[3];

    always @(current_state, counter) begin
        next_state <= 0;
        if (current_state[0])
            next_state[1] <= 1'b1;
        if (current_state[1])
            next_state[2] <= 1'b1;
        if (current_state[2]) begin
            if (counter > booth_bits)
                next_state[1] <= 1'b1;
            else 
                next_state[3] <= 1'b1;
        end
        if (current_state[3])
            next_state[3] <= 1'b1;
    end


    always @(posedge clk) begin
        if (str) begin
            current_state <= 1;
            counter <= 4;
        end else begin
            current_state <= next_state;
            if (current_state[2])
                counter <= counter - booth_bits;
            end
    end

    wire [3:0] diffrences = (multiplier ^ (multiplier >> 1)) | (1'b1 << (4 - 1'b1));
    reg [2:0] rightMost;

    integer i;
    always @(*) begin
        rightMost = 0;
        for (i = 1; i <= 4; i = i + 1) begin
            if (diffrences[i - 1] && !rightMost)
                rightMost = i;
        end
    end

    assign booth_bits = (counter > rightMost) ? rightMost : counter;

endmodule