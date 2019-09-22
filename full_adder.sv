module full_adder
(
  input logic a,
  input logic b,
  input logic c_in,
  output logic sum,
  output logic c_out
);

  logic sum_ha1;
  logic carry_ha1;
  logic sum_ha2;
  logic carry_ha2;
  
  half_adder ha1_i (
    .a(a),
	 .b(b),
	 .sum(sum_ha1),
	 .carry(carry_ha1)
  );
  
  half_adder ha2_i (
    .a(sum_ha1),
	 .b(c_in),
	 .sum(sum_ha2),
	 .carry(carry_ha2)
  );
  
  assign sum = sum_ha2;
  assign c_out = carry_ha1 | carry_ha2;
 
endmodule
