`include "Sumador.v"

module sum4b(A, B, Ci, S, Co);

input [3:0] A;
input [3:0] B;
input Ci;
output [3:0] S;   
output Co;

wire C1,C2,C3;

sum1b sum0(.a(A[0]), .b(B[0]), .ci(Ci),.s(S[0]), .co(C1));
sum1b sum1(.a(A[1]), .b(B[1]), .ci(C1), .s(S[1]), .co(C2));
sum1b sum2(.a(A[2]), .b(B[2]), .ci(C2), .s(S[2]), .co(C3));
sum1b sum3(.a(A[3]), .b(B[3]), .ci(C3), .s(S[3]), .co(Co));

endmodule
