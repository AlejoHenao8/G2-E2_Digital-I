`include "seg7.v"
`timescale 1ps/1ps

module seg7_tb ();

   reg [3:0] BCD_tb;
   wire [6:0] SSeg_tb;

   seg7 uut(
      .BCD(BCD_tb),
      .SSeg(SSeg_tb)
   );

   initial begin
   BCD_tb = 4'b0000;
   #100;
   BCD_tb = 4'b0001;
   #100;
   BCD_tb = 4'b0010;
   #100;
   BCD_tb = 4'b0011;
   #100;
   BCD_tb = 4'b0100;
   #100;
   BCD_tb = 4'b0101;
   #100;
   BCD_tb = 4'b0110;
   #100;
   BCD_tb = 4'b0111;
   #100;
   BCD_tb = 4'b1000;
   #100;
   BCD_tb = 4'b1001;
   #100;
   end

   initial begin: TEST_CASE
      $dumpfile("seg7_tb.vcd");
      $dumpvars(-1,uut);
      #1000; 
      $finish;
  end
endmodule