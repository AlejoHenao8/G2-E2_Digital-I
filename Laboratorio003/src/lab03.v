module lab03(A, B, CI, S, CO);
  input [2:0] A, B;
  input CI;
  output [2:0] S;
  output CO;

  wire [1:0] C; // Acarreos internos

  // Sumadores de 1 bit
  lab01 sum1bit0 (.A(A[0]), .B(B[0]), .CI(CI), .S1(S[0]), .CO(C[0]));
  lab01 sum1bit1 (.A(A[1]), .B(B[1]), .CI(C[0]), .S1(S[1]), .CO(C[1]));
  lab01 sum1bit2 (.A(A[2]), .B(B[2]), .CI(C[1]), .S1(S[2]), .CO(CO));
endmodule