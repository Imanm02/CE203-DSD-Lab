module four_bit_comparator(
    input wire [3:0] x,
    input wire [3:0] y,
    input wire in_gt,
    input wire in_eq,
    output wire o_gt,
    output wire o_eq
);

wire [2:0] o_eq_comps;
wire [2:0] o_gt_comps;

one_bit_comparator comp0(x[3], y[3], in_gt, in_eq, o_gt_comps[0], o_eq_comps[0]);
one_bit_comparator comp1(x[2], y[2], o_gt_comps[0], o_eq_comps[0], o_gt_comps[1], o_eq_comps[1]);
one_bit_comparator comp2(x[1], y[1], o_gt_comps[1], o_eq_comps[1], o_gt_comps[2], o_eq_comps[2]);
one_bit_comparator comp3(x[0], y[0], o_gt_comps[2], o_eq_comps[2], o_gt, o_eq);


endmodule 