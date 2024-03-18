`include "Sumador4.v"
`timescale 1ps/1ps

module Sumador4_tb ();

    reg [3:0] A_tb;
    reg [3:0] B_tb;
    reg Ci_tb;

    sum4b uut(
        .A(A_tb),
        .B(B_tb),
        .Ci(Ci_tb)
    );

    initial begin
        A_tb = 4'b0000;
        B_tb = 4'b0000;
        Ci_tb = 0;
        #1;
        A_tb = 4'b0001;
        B_tb = 4'b0001;
        Ci_tb = 0;
        #1;
        A_tb = 4'b0010;
        B_tb = 4'b0010;
        Ci_tb = 0;
        #1;
        A_tb = 4'b0011;
        B_tb = 4'b0011;
        Ci_tb = 0;
        #1;
        A_tb = 4'b0100;
        B_tb = 4'b0100;
        Ci_tb = 0;
        #1;
        A_tb = 4'b0101;
        B_tb = 4'b0101;
        Ci_tb = 0;
        #1;
        A_tb = 4'b0110;
        B_tb = 4'b0110;
        Ci_tb = 0;
        #1;
        A_tb = 4'b0111;
        B_tb = 4'b0111;
        Ci_tb = 0;
        #1;
        A_tb = 4'b1000;
        B_tb = 4'b1000;
        Ci_tb = 0;
        #1;
        A_tb = 4'b1001;
        B_tb = 4'b1001;
        Ci_tb = 0;
        #1;
        A_tb = 4'b1010;
        B_tb = 4'b1010;
        Ci_tb = 0;
        #1;
        A_tb = 4'b1011;
        B_tb = 4'b1011;
        Ci_tb = 0;
        #1;
        A_tb = 4'b1100;
        B_tb = 4'b1100;
        Ci_tb = 0;
        #1;
        A_tb = 4'b1101;
        B_tb = 4'b1101;
        Ci_tb = 0;
        #1;
        A_tb = 4'b1110;
        B_tb = 4'b1110;
        Ci_tb = 0;
        #1;
        A_tb = 4'b1111;
        B_tb = 4'b1111;
        Ci_tb = 0;
        #1;
    end

    initial begin: TEST_CASE
      $dumpfile("Sumador4_tb.vcd");
      $dumpvars(-1,uut);
      #18; 
      $finish;
    end

endmodule