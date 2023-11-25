module one_bit_comparator(
    x,
    y, 
    in_gt,
    in_eq, 
    o_gt, 
    o_eq
);

input x, y, in_gt, in_eq;
output o_eq, o_gt; 

assign o_eq = (x == y) & in_eq;
assign o_gt = (in_gt) | (in_eq & (x > y));

endmodule 