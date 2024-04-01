module sumwdisplay(
  input [2:0] A, B,
  input CI,
  output [3:0] S_CO, // Salida concatenada de S y CO
  output [2:0] S,
  output CO,
  output [3:0] an,
  output reg [0:6] SSeg
);

  wire [1:0] C; // Acarreos internos
  
  // Concatenamos CO con S para formar S_CO
  assign S_CO = {CO, S};

  // Sumador de 3 bits
  lab03 uut(
    .A(A),
    .B(B),
    .CI(CI),
    .S(S),
    .CO(CO)
  );

  // Conexión al display de 7 segmentos
  seg7 display(
    .BCD(S_CO), // Conectamos la salida del sumador (S) al BCD del display
    .SSeg(SSeg), // Conectamos las salidas del display de 7 segmentos
    .an(an) // Conectamos la salida del display de 7 segmentos a los ánodos
  );

endmodule
