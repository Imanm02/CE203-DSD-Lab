module BoothMultiplierDatapath(
    input [3:0] multiplicand, multiplier,
    input shiftRight, load, arth,
    input [2:0] booth_bits,
    input clk,
    output reg [3:0] result, new_multiplier
);

    reg LSB;
    reg [3:0] temp_multiplicand;

    always @(posedge clk) begin
        if (load) begin
            temp_multiplicand <= multiplicand;
            result <= 0;
            new_multiplier <= multiplier;
            LSB <= 0;
        end else if (arth) begin
            if (new_multiplier[0] == 1 && LSB == 0)
                result <= result - temp_multiplicand;
            else if (new_multiplier[0] == 0 && LSB == 1)
                result <= result + temp_multiplicand;
        end else if (shiftRight) begin
            {result, new_multiplier, LSB} <= $signed({result, new_multiplier, LSB}) >>> booth_bits;
        end
    end

endmodule