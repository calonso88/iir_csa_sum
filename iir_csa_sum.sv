module iir_csa_sum
#(
  parameter int width_p = 16
)
(
  input logic rst_n,
  input logic clk,
  input logic [width_p-1:0] sample,
  output logic [width_p-1:0] iir_csa_sum_async,
  output logic [width_p-1:0] irr_csa_sum_r,
  output logic [width_p-1:0] iir_sum_async,
  output logic [width_p-1:0] iir_sum_r
);
  //----------------------------------------------------
  // Equation
  //  y[n] = x[n] + y[n-1]
  //----------------------------------------------------

  //----------------------------------------------------
  // IIR with CSA format for better timing performance
  //----------------------------------------------------
  logic [width_p-1:0] csa_sum_in;
  logic [width_p-1:0] csa_carry_in;
  logic [width_p-1:0] sum_next;
  logic [width_p-1:0] carry_next;
  logic [width_p-1:0] sum_r;
  logic [width_p-1:0] carry_r;

  assign csa_sum_in = sum_r;
  assign csa_carry_in = (carry_r << 1);

  csa #(
    .width_p(width_p)
  )
  csa_i0 (
    .x(sample),
	 .y(csa_sum_in),
	 .z(csa_carry_in),
	 .s(sum_next),
	 .c(carry_next)
  );

  always_ff@(posedge(clk), negedge(rst_n)) begin
    if (!rst_n) begin
      sum_r <= '0;
      carry_r <= '0;
    end
    else begin
      sum_r <= sum_next;
      carry_r <= carry_next;
    end
  end

  assign iir_csa_sum_async = (sum_next + (carry_next << 1));
  assign irr_csa_sum_r = (sum_r + (carry_r << 1));


  //----------------------------------------------------
  // IIR straigh-forward implementation
  //----------------------------------------------------
  logic [width_p-1:0] filter_next;
  logic [width_p-1:0] filter_r;

  assign filter_next = sample + filter_r;

  always_ff@(posedge(clk), negedge(rst_n)) begin
    if (!rst_n) begin
      filter_r <= '0;
    end
    else begin
      filter_r <= filter_next;
    end
  end

  assign iir_sum_async = filter_next;
  assign iir_sum_r = filter_r;

endmodule
