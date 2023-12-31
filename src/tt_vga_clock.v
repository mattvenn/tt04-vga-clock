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

    assign uio_out[7:1] = 7'b0;
    assign uio_oe  = 8'b000_0001;

    (* keep *) wire inv_in_no_touch_ = ui_in[4];
    (* keep *) wire inv_out_no_touch_;
    assign uio_out[0] = inv_out_no_touch_;

    sky130_fd_sc_hd__inv_1 inverter_no_touch_ (
        .A          (inv_in_no_touch_),
        .Y          (inv_out_no_touch_)
    );

    wire [1:0] R;
    wire [1:0] G;
    wire [1:0] B;
    wire hsync, vsync;

    // https://tinytapeout.com/specs/pinouts/#common-peripherals
    assign uo_out[0] = R[1];
    assign uo_out[1] = G[1];
    assign uo_out[2] = B[1];
    assign uo_out[3] = vsync;
    assign uo_out[4] = R[0];
    assign uo_out[5] = G[0];
    assign uo_out[6] = B[0];
    assign uo_out[7] = hsync;

    vga_clock vga_clock (
    .clk        (clk), 
    .reset_n    (rst_n),
    // inputs
    .adj_hrs    (ui_in[0]),
    .adj_min    (ui_in[1]),
    .adj_sec    (ui_in[2]),
    // outputs
    .hsync      (hsync),
    .vsync      (vsync),
    .rrggbb     ({R,G,B})
    );

endmodule
