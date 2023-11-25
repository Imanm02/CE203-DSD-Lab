module BoothMultiplier(
    input wire [3:0] multiplicand, multiplier,
    input clk, str,
    output wire [7:0] result,
    output valid
);

    wire shiftRight, load, arth;
    wire [2:0] booth_bits;

    BoothMultiplierDatapath datapath(
        .multiplicand(multiplicand), .multiplier(multiplier),
        .shiftRight(shiftRight), .load(load), .arth(arth),
        .booth_bits(booth_bits), .clk(clk),
        .result(result [7:4]), .new_multiplier(result [3:0])
    );

    BoothMultiplierControlUnit control(
        .multiplier(result[3:0]), .clk(clk), .str(str),
        .valid(valid), .load(load), .arth(arth), .shiftRight(shiftRight),
        .booth_bits(booth_bits)
    );

endmodule