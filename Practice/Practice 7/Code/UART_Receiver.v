module UART_Receiver (
    input sys_clk,
    input rx,                 // Received serial data
    output reg [6:0] data_out, // 7-bit received data
    output reg ready              // Data ready signal
);

localparam WAIT_START = 0, RECEIVE = 1, CHECK_PARITY = 2, CHECK_STOP = 3;
reg [2:0] state = WAIT_START, next_state;
reg [6:0] shift_reg;
reg parity_bit;
reg [2:0] bit_counter = 0;

always @(posedge sys_clk) begin
    state <= next_state;
end

always @(state, bit_counter, rx, shift_reg) begin
    next_state = state;
    data_out = shift_reg;
    ready = 0; // default

    case (state)
        WAIT_START: begin
            if (!rx) next_state = RECEIVE; // Start bit detected
            bit_counter = 0;
        end

        RECEIVE: begin
            shift_reg = shift_reg << 1;
            shift_reg[0] = rx;
            bit_counter = bit_counter + 1;
            if (bit_counter == 6) next_state = CHECK_PARITY;
        end
        
        CHECK_PARITY: begin
            parity_bit = ^shift_reg;
            if (parity_bit == rx) next_state = CHECK_STOP;
            else next_state = WAIT_START; // Parity error
        end
        
        CHECK_STOP: begin
            if (rx) begin
                next_state = WAIT_START;
                ready = 1; // Data is ready
            end else next_state = WAIT_START; // Framing error
        end
    endcase
end

endmodule 