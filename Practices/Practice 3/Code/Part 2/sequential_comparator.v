module sequential_comparator (
    input x,
    input y,
    input reset,
    input clk,
    output o_gt,
    output o_lt
);
    wire o_gt_not, o_lt_not, i_gt, i_lt;
    
    // Create the flip flops
    assign o_gt = ~(o_gt_not & ~(i_gt & clk));
    assign o_gt_not = ~(o_gt & ~(~i_gt & clk));
    assign o_lt = ~(o_lt_not & ~(i_lt & clk));
    assign o_lt_not = ~(o_lt & ~(~i_lt & clk));

    // Assign the inputs of flop flops
    assign i_gt = (~reset) & (o_gt | ((~i_lt) & (x > y)));
    assign i_lt = (~reset) & (o_lt | ((~i_gt) & (x < y)));

endmodule 