module incubator(
    input signed [7:0] sensor,
    input clk,
    input reset,
    output reg cooler,
    output reg heater,
    output reg [3:0] fan_rps
);

// Local Parameters for temperature thresholds
parameter TEMP_LOW = 8'd15;
parameter TEMP_MID_LOW = 8'd25;
parameter TEMP_MID = 8'd35;
parameter TEMP_MID_HIGH = 8'd40;
parameter TEMP_HIGH = 8'd45;

always @(posedge clk or negedge reset) 
begin
    if (!reset) 
    begin
        cooler  <= 0;
        heater  <= 0;
        fan_rps <= 0;
    end 
    else 
    begin
        case({cooler, heater})
            2'b01:  // cooler is on
                case(fan_rps)
                    4'd4:
                        if (sensor < TEMP_MID) fan_rps <= 0;
                        else if (sensor > TEMP_MID_HIGH) fan_rps <= 4'd6;
                    4'd6:
                        if (sensor < TEMP_MID) fan_rps <= 4'd4;
                        else if (sensor > TEMP_HIGH) fan_rps <= 4'd8;
                    4'd8:
                        if (sensor < TEMP_MID_HIGH) fan_rps <= 4'd6;
                endcase
            2'b00:  // neither heater nor cooler is on
                if (sensor > TEMP_MID) 
                begin
                    cooler <= 1;
                    fan_rps <= 4'd4;
                end 
                else if (sensor < TEMP_LOW) 
                begin
                    heater <= 1;
                    cooler <= 0;
                end
            2'b10:  // heater is on
                if (sensor > TEMP_MID_LOW) 
                begin
                    heater <= 0;
                    cooler <= 0;
                end
        endcase
    end
end

endmodule 