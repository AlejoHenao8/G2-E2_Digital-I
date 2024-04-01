module seg7 (BCD, SSeg, an);

  input [2:0] BCD;
  output reg [0:6] SSeg;
  output [2:0] an;
  
  assign an = 4'b1110;


always @ ( * ) begin
  case (BCD)

                         // abcdefg
         3'b000: SSeg = 7'b0000001; // "0"  
	 3'b001: SSeg = 7'b1001111; // "1" 
	 3'b010: SSeg = 7'b0010010; // "2" 
	 3'b011: SSeg = 7'b0000110; // "3" 
	 3'b100: SSeg = 7'b1001100; // "4" 
	 3'b101: SSeg = 7'b0100100; // "5" 
	 3'b110: SSeg = 7'b0100000; // "6" 
	 3'b111: SSeg = 7'b0001111; // "7" 
    default:
    SSeg = 0;
  endcase
end

endmodule
