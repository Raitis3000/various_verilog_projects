module police_siren(input osc_CLK, output reg pin20, input mute);

reg [23:0] tone;
always @(posedge osc_CLK) tone <= tone+1;

wire [6:0] ramp = (tone[23] ? tone[22:16] : ~tone[22:16]);
wire [15:0] clkdivider = {2'b01, ramp, 7'b0000000};

reg [15:0] counter;

always @(posedge osc_CLK) if(counter==0) counter <= clkdivider; else counter <= counter-1;

always @(posedge osc_CLK) if((counter==0)&(mute == 0)) pin20 <= ~pin20;

endmodule
