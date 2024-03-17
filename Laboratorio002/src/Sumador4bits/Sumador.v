module FA (
   input [3:0] A,
   input [3:0] B,
   input Ci,
   output Co,
   output [3:0] Su
);

   assign {Co, Su} = A+B+Ci;

endmodule
