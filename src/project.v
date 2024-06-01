/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_cm_1 (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  wire [7:0] mat01_out;
  wire [7:0] mat23_out;
  reg [7:0] out;

  assign uo_out = out;

  // All output pins must be assigned. If not used, assign to 0.
  //assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, uio_in[7:1], 1'b0};

  always @(posedge clk) begin
    if (!rst_n)
      out <= 8'd0;
    else if (uio_in[0]) begin
      out <= mat01_out;
    end else 
      out <= mat23_out;
  end

  custom_matrix mat0 (
    .in(ui_in[3:0]),
    .out(mat01_out[3:0])
  );

  custom_matrix mat1 (
    .in(ui_in[7:4]),
    .out(mat01_out[7:4])
  );

  custom_matrix mat2 (
    .in(ui_in[3:0]),
    .out(mat23_out[3:0])
  );

  custom_matrix mat3 (
    .in(ui_in[7:4]),
    .out(mat23_out[7:4])
  );


 //assign mat_out[1][7:0] = 8'd0;

endmodule
