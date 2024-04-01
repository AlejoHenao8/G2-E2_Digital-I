`include "Sumador3.v"
`timescale 1ps/1ps

module Sumador3_tb ();

    reg [2:0] A_tb;
    reg [2:0] B_tb;
    reg Ci_tb;

    sum3b uut(
        .A(A_tb),
        .B(B_tb),
        .Ci(Ci_tb)
    );

    initial begin
        A_tb = 3'b000;
        B_tb = 3'b000;
        Ci_tb = 0;
        #1;
        A_tb = 3'b001;
        B_tb = 3'b001;
        Ci_tb = 0;
        #1;
        A_tb = 3'b010;
        B_tb = 3'b010;
        Ci_tb = 0;
        #1;
        A_tb = 3'b011;
        B_tb = 3'b011;
        Ci_tb = 0;
        #1;
        A_tb = 3'b100;
        B_tb = 3'b100;
        Ci_tb = 0;
        #1;
        A_tb = 3'b101;
        B_tb = 3'b101;
        Ci_tb = 0;
        #1;
        A_tb = 3'b110;
        B_tb = 3'b110;
        Ci_tb = 0;
        #1;
        A_tb = 3'b111;
        B_tb = 3'b111;
        Ci_tb = 0;
        #1;

    end

    initial begin: TEST_CASE
      $dumpfile("Sumador3_tb.vcd");
      $dumpvars(-1,uut);
      #18; 
      $finish;
    end

endmodule