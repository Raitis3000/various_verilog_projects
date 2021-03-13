module sound_top(input osc_CLK, output reg pin20, input mute);

parameter clkdivider = 50000000/440/2;

reg [24:0] tone;
always @(posedge osc_CLK) tone <= tone+1;

reg [15:0] counter;
always @(posedge osc_CLK) if(counter==0) counter <= (tone[24] ? clkdivider-1 : clkdivider/2-1); else counter <= counter-1;

always @(posedge osc_CLK) if((counter==0)&(mute == 0)) pin20 <= ~pin20;

endmodule
