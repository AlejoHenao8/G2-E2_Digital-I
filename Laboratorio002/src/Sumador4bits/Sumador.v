module sum1b (a,b,ci,s,co);
input a;
input b;
input ci;

output s;
output co;

wire X1; // salida de compuerta XOR 1
wire A1; // salida de compuerta AND 1
wire A2; // salida de compuerta AND 2

//Conexión de compuertas
assign X1 = a ^ b; 
assign A1 = a & b;
assign A2 = X1 & ci;
assign s = X1 ^ ci;
assign co = A1 | A2;

endmodule
