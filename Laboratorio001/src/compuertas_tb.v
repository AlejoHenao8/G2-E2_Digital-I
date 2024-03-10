`include "compuertas.v"
`timescale 1ps/1ps


module compuertas_tb();


reg A_tb;
reg B_tb;
reg C_tb;

wire S1_tb;
wire S2_tb;
wire S3_tb;
wire S4_tb;


compuertas uut(A_tb,B_tb,C_tb,S1_tb,S2_tb,S3_tb,S4_tb);


initial begin // IDEA DEL LAB ES PROBAR TODOS LOS CASOS ADN TIENE 4 NOT SOLO 2

A_tb = 0;

B_tb = 0;

C_tb = 0;

#100;

A_tb = 0;

B_tb = 1;

C_tb = 1;

#100;

A_tb = 1;

B_tb = 0;

C_tb = 0;

#100;

A_tb = 1;

B_tb = 1;

C_tb = 0;
#100;
end

initial begin: TEST_CASE
    $dumpfile("compuertas.vcd");
    $dumpvars(-1,uut);
    #600; $finish;
end


endmodule 
