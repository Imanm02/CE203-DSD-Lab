module BoothMultiplierTestbench();
    
    reg clk, str;
    reg [3:0] multiplicand, multiplier;

    wire valid;
    wire [7:0] result;

    BoothMultiplier boothMultiplier (
        .multiplicand(multiplicand), .multiplier(multiplier),
        .valid(valid), .clk(clk), .str(str), .result(result)
    );

    initial
    clk = 1;

    always begin
        #5 clk = ~clk;
    end

    initial begin
        str <= 1;
        multiplicand = 4;
        multiplier = 5;
        #10;
        str <= 0;
    end

    always @(posedge valid) begin
        #20;
    str <= 1;
    multiplicand <= {$random};
    multiplier <= {$random};
        #10;
    str <= 0;
        $display("%d * %d = %d", multiplicand, multiplier, result);
    end

endmodule