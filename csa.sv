module csa
#(
  parameter int width_p = 4
)
(
  input logic [width_p-1:0] x,
  input logic [width_p-1:0] y,
  input logic [width_p-1:0] z,
  output logic [width_p-1:0] s,
  output logic [width_p-1:0] c
);

  genvar i;
  generate
    for ( i = 0; i < width_p; i = i + 1 ) begin : csa_loop
      csa1b csa1b_i (.x(x[i]), .y(y[i]), .z(z[i]), .s(s[i]), .c(c[i]));
    end
  endgenerate

endmodule
