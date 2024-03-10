
`timescale 1ps/1ps
module lab01_TB(); //archivo para la simulacion

reg A_tb;
reg B_tb;
reg CI_tb;

wire S1_tb;
wire CO_tb;

lab01 uut(.A(A_tb),.B(B_tb),.CI(CI_tb),.S1(S1_tb),.CO(CO_tb));  //Se instancia el documento LAB para ponerlo bajo prueba
initial begin
A_tb = 0;
B_tb = 0;
CI_tb = 0;
#100 //cantiadad de unidades de tiempo que quiero que las variables esten en 0
A_tb = 0;
B_tb = 0;
CI_tb = 1;
#100
A_tb = 0;
B_tb = 1;
CI_tb = 0;
#100
A_tb = 0;
B_tb = 1;
CI_tb = 1;
#100
A_tb = 1;
B_tb = 0;
CI_tb = 0;
#100
A_tb = 1;
B_tb = 0;
CI_tb = 1;
#100
A_tb = 1;
B_tb = 1;
CI_tb = 0;
#100
A_tb = 1;
B_tb = 1;
CI_tb = 1;
#100 $stop;
end

endmodule