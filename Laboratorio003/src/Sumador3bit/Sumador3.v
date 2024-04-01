`include "Sumador.v"

module sum3b(A, B, Ci, S, Co);

input [2:0] A;
input [2:0] B;
input Ci;
output [2:0] S;   
output Co;

wire C1,C2;

sum1b sum0(.a(A[0]), .b(B[0]), .ci(Ci),.s(S[0]), .co(C1));
sum1b sum1(.a(A[1]), .b(B[1]), .ci(C1), .s(S[1]), .co(C2));
sum1b sum2(.a(A[2]), .b(B[2]), .ci(C2), .s(S[2]), .co(Co));


endmodule
