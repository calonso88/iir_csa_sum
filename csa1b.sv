module csa1b
(
  input logic x,
  input logic y,
  input logic z,
  output logic s,
  output logic c
);
  
  full_adder fa1_i (
    .a(x),
	 .b(y),
	 .c_in(z),
	 .sum(s),
	 .c_out(c)
  );

endmodule
