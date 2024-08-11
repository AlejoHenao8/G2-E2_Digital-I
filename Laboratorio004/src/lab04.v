module lab04(
    input clk,               // Reloj de entrada (de 50 MHz)
    input rst,               // Reset
    input switch1,           // Switch para cambiar a décimas de segundo
    input switch2,           // Switch para cambiar a centésimas de segundo
    input switch3,           // Switch para cambiar a milésimas de segundo
    output reg [6:0] seg,    // Señales para los segmentos a-g
    output reg [3:0] an      

parameter cont_1s = 50000000;     // Valor de cont para generar 1 Hz a partir de un reloj de 50 MHz
parameter cont_100ms = 5000000;   // Valor de cont para generar 10 Hz (décimas de segundo) a partir de un reloj de 50 MHz
parameter cont_10ms = 500000;     // Valor de cont para generar 100 Hz (centésimas de segundo) a partir de un reloj de 50 MHz
parameter cont_1ms = 50000;       // Valor de cont para generar 1 kHz (milésimas de segundo) a partir de un reloj de 50 MHz
localparam WIDTH = $clog2(cont_1s); // Ancho del contador calculado en función del cont más grande
reg [WIDTH-1:0] counter;          // Contador para dividir la frecuencia

reg [1:0] mode;                   // 00: segundos, 01: décimas de segundo, 10: centésimas de segundo, 11: milésimas de segundo
reg clk_mode;                     // Señal de reloj para el modo actual
reg [13:0] seg_counter;           // Contador de 14 bits
reg [1:0] digit_select;           // Selección del dígito activo (0-3)

// Función para cambiar de modo
always @(posedge clk or posedge rst) begin
    if (rst) begin
        mode <= 2'b00;
    end else begin
        case ({switch3, switch2, switch1})
            3'b001: mode <= 2'b01; // Décimas de segundo
            3'b010: mode <= 2'b10; // Centésimas de segundo
            3'b100: mode <= 2'b11; // Milésimas de segundo
            default: mode <= 2'b00; // Segundos
        endcase
    end
end

// Divisor de frecuencia según el modo
always @(posedge clk or posedge rst) begin
    if (rst) begin
        counter <= 'd0;
        clk_mode <= 0;
    end else begin
        case (mode)
            2'b00: begin // Segundos
                if (counter == cont_1s - 1) begin
                    counter <= 'd0;
                    clk_mode <= 1;
                end else begin
                    counter <= counter + 1;
                    clk_mode <= 0;
                end
            end
            2'b01: begin // Décimas de segundo
                if (counter == cont_100ms - 1) begin
                    counter <= 'd0;
                    clk_mode <= 1;
                end else begin
                    counter <= counter + 1;
                    clk_mode <= 0;
                end
            end
            2'b10: begin // Centésimas de segundo
                if (counter == cont_10ms - 1) begin
                    counter <= 'd0;
                    clk_mode <= 1;
                end else begin
                    counter <= counter + 1;
                    clk_mode <= 0;
                end
            end
            2'b11: begin // Milésimas de segundo
                if (counter == cont_1ms - 1) begin
                    counter <= 'd0;
                    clk_mode <= 1;
                end else begin
                    counter <= counter + 1;
                    clk_mode <= 0;
                end
            end
        endcase
    end
end

// Contador de tiempo
always @(posedge clk or posedge rst) begin
    if (rst) begin
        seg_counter <= 14'd0; // Iniciar en 0000
    end else if (clk_mode) begin
        if (seg_counter == 14'd9999) begin
            seg_counter <= 14'd0; // Reiniciar a 0000 después de llegar a 9999
        end else begin
            seg_counter <= seg_counter + 1;
        end
    end
end

// Multiplexación de los displays de 7 segmentos
reg [15:0] mux_counter; // Contador para generar clk_mux (3 kHz)
wire clk_mux;

// Divisor de frecuencia para la multiplexación
always @(posedge clk or posedge rst) begin
    if (rst) begin
        mux_counter <= 16'd0;
    end else if (mux_counter == 16'd16666) begin  // 50 MHz / 16,667 ≈ 3 kHz
        mux_counter <= 16'd0;
    end else begin
        mux_counter <= mux_counter + 1;
    end
end

assign clk_mux = (mux_counter == 16'd16666); // Genera un pulso de 3 kHz

always @(posedge clk_mux or posedge rst) begin
    if (rst) begin
        digit_select <= 2'd0;
    end else begin
        digit_select <= digit_select + 1;
    end
end

// Segmentación del valor del contador en 4 dígitos
wire [3:0] dig1, dig2, dig3, dig4;
assign dig1 = seg_counter % 10;
assign dig2 = (seg_counter / 10) % 10;
assign dig3 = (seg_counter / 100) % 10;
assign dig4 = (seg_counter / 1000) % 10;

reg [3:0] current_digit; // Dato del dígito actual

always @(*) begin
    case (digit_select)
        2'd0: current_digit = dig1;  // Unidades
        2'd1: current_digit = dig2;  // Decenas
        2'd2: current_digit = dig3;  // Centenas
        2'd3: current_digit = dig4;  // Unidades de millar
        default: current_digit = 4'd0;
    endcase
end

// Lógica para manejar los anodos y segmentos
always @(*) begin
    an = 4'b1111;  // Desactivar todos los anodos por defecto
    case (digit_select)
        2'd0: an = 4'b1110; // Activar dígito 1
        2'd1: an = 4'b1101; // Activar dígito 2
        2'd2: an = 4'b1011; // Activar dígito 3
        2'd3: an = 4'b0111; // Activar dígito 4
    endcase
end

// Módulo de decodificador de 7 segmentos
always @(*) begin
    case (current_digit)
        4'd0: seg = 7'b1000000; // "0"
        4'd1: seg = 7'b1111001; // "1"
        4'd2: seg = 7'b0100100; // "2"
        4'd3: seg = 7'b0110000; // "3"
        4'd4: seg = 7'b0011001; // "4"
        4'd5: seg = 7'b0010010; // "5"
        4'd6: seg = 7'b0000010; // "6"
        4'd7: seg = 7'b1111000; // "7"
        4'd8: seg = 7'b0000000; // "8"
        4'd9: seg = 7'b0010000; // "9"
        default: seg = 7'b1111111;  // Apagado
    endcase
end

endmodule
