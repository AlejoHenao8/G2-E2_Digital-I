module lab01 (A,B,CI,S1,CO);
input A;
input B;
input CI;

output S1;
output CO;

wire X1; // salida de compuerta XOR 1
wire A1; // salida de compuerta AND 1
wire A2; // salida de compuerta AND 2

//Conexión de compuertas
assign X1 = A ^ B; 
assign A1 = A & B;
assign A2 = X1 & CI;
assign S1 = X1 ^ CI;
assign CO = A1 | A2;

endmodule

