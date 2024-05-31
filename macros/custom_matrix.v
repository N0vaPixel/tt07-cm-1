/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module custom_matrix (
  `ifdef USE_POWER_PINS
    inout VPWR,
    inout VGND,
`endif
    input  wire [3:0] in,
    output wire [3:0] out
);

  assign out[0] = in[0];
  assign out[1] = in[1];
  assign out[2] = in[2];
  assign out[3] = in[3];

endmodule
