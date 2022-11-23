`default_nettype none
// update this to the name of your module
module wrapped_vga_clock(
`ifdef USE_POWER_PINS
    inout vdd,	// User area 1 1.8V supply
    inout vss,	// User area 1 digital ground
`endif
    // interface as user_proj_example.v
    input wire wb_clk_i,
    input wire wb_rst_i,

    // Logic Analyzer Signals
    // only provide first 32 bits to reduce wiring congestion

    input  wire [`MPRJ_IO_PADS-1:0] io_in,
    output wire [`MPRJ_IO_PADS-1:0] io_out,
    output wire [`MPRJ_IO_PADS-1:0] io_oeb,

);

    // permanently set oeb so that outputs are always enabled: 0 is output, 1 is high-impedance
    assign io_oeb = {`MPRJ_IO_PADS{1'b0}};

    wire reset = ! wb_rst_i;

    vga_clock vga_clock(
        .clk(wb_clk_i),
        .reset_n(reset),
        .adj_hrs(io_in[8]),
        .adj_min(io_in[9]),
        .adj_sec(io_in[10]),
        .hsync(io_out[11]),
        .vsync(io_out[12]),
        .rrggbb(io_out[18:13])
        );

endmodule 
`default_nettype wire
