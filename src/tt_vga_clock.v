`default_nettype none
module tt_um_vga_clock (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    vga_clock vga_clock (
    .clk        (clk), 
    .reset_n    (rst_n),
    // inputs
    .adj_hrs    (ui_in[0]),
    .adj_min    (ui_in[1]),
    .adj_sec    (ui_in[2]),
    // outputs
    .hsync      (uo_out[0]),
    .vsync      (uo_out[1]),
    .rrggbb     (uo_out[7:2])
    );

endmodule
