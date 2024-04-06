`timescale 1ps/1ps

module lab03_tb();

  reg [2:0] A_tb; // Entradas de 3 bits
  reg [2:0] B_tb;
  reg CI_tb;

  wire [2:0] S_tb; // Salidas de 3 bits
  wire CO_tb;

  lab03 uut(
    .A(A_tb),
    .B(B_tb),
    .CI(CI_tb),
    .S(S_tb),
    .CO(CO_tb)
  ); // Instancia del sumador de 3 bits

  initial begin
  A_tb = 3'b000;
  B_tb = 3'b000;
  CI_tb = 0;
  #100;
  A_tb = 3'b001;
  B_tb = 3'b001;
  CI_tb = 0;
  #100;
  A_tb = 3'b010;
  B_tb = 3'b010;
  CI_tb = 0;
  #100;
  A_tb = 3'b011;
  B_tb = 3'b011;
  CI_tb = 0;
  #100;
  A_tb = 3'b100;
  B_tb = 3'b100;
  CI_tb = 0;
  #100;
  A_tb = 3'b101;
  B_tb = 3'b101;
  CI_tb = 0;
  #100;
  A_tb = 3'b110;
  B_tb = 3'b110;
  CI_tb = 0;
  #100;
  A_tb = 3'b111;
  B_tb = 3'b111;
  CI_tb = 0;
  #100;
  end

  initial begin: TEST_CASE
    $dumpfile("lab03_tb.vcd");
    $dumpvars(-1,uut);
    #900; 
    $finish;
  end

endmodule