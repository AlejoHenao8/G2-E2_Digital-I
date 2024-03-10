//Computertas NOT, AND , OR , XOR

module compuertas(A,B,C,S1,S2,S3,S4); // Solo nombrar los archivos con caracteres alfanumericos 

input A;
input B;
input C;

output S1;
output S2;
output S3;
output S4;

assign S1 = A&B; // se asigna a S1 logica de AND 
assign S2 = ~C; // se asigna a S2 logica de not 

assign S3 = A||B; // se asigna a S3 logica OR
assign S4 = A^B; // se asigna a S4 logica de XOR

// S1 = AND(S1,A,B); asi tambien se puede hacer el AND

endmodule 
