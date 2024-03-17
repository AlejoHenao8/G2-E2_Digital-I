`include "Sumador.v"
`timescale 1ps/1ps

module FA_tb;
   // Declarar las variables del testbench
   reg [3:0] A;
   reg [3:0] B;
   reg Ci;

   wire [3:0] Su;

   integer i;

   // Instanciar
   FA fa0 (.A (A), .B (B), .Ci (Ci), .Co (Co), .Su (Su));

   initial begin
      A <= 0;
      B <= 0;
      Ci <= 0;

      $monitor ("A=0x%h B=0x%h Ci=0x%h Co=0x%h Su=0x%h", A, B, Ci, Co, Su);

      for (i = 0;i < 5;i = i+1) begin
         #10 A <= $random;
             B <= $random;
               Ci <= $random;
      end
   end

   initial begin: TEST_CASE
      $dumpfile("Sumador.vcd");
      $dumpvars(-1,FA_tb);
      #60; 
      $finish;
  end

endmodule