module test(output random); 

reg signed [7:0] sensor; 
reg clock = 0; 
reg reset = 0; 
wire cooler; 
wire heater; 
wire [3:0] rps; 

// Connect the redesigned incubator module
incubator u_incubator( 
    .sensor(sensor), 
    .clk(clock), 
    .reset(reset), 
    .cooler(cooler), 
    .heater(heater), 
    .fan_rps(rps) 
); 

integer i; 
initial begin 
    clock = 0; 
    reset = 0; 
    sensor = -10; 
    #10 reset = 1; 

    for (i=-10; i<61; i=i+1) begin 
        #10 sensor = i; 
    end 

    for (i=60; i>=-10; i=i-1) begin 
        #10 sensor = i; 
    end 
end 

always #5 clock = ~clock; 

initial 
    $monitor("sensor: %d, reset: %d, cooler: %d, heater: %d, rps: %d", sensor, reset, cooler, heater, rps); 

endmodule 