# Lab 04: Contador de segundos, décimas y centésimas de segundos.

En este laboratorio se implementó un contador de segundos, décimas, centésimas y milésimas de segundo en el display de 7 segmentos. Usando:
- Registros.
- Contadores.
- Divisores de frecuencia.
- Máquinas de Estado.
- Multiplexación.
  
A continuación de explica el procedimiento usado para construir el laboratorio.

### Entradas y Salidas
- Entradas
    - clk: Señal de reloj de entrada de 50 MHz.
    - rst: Señal de reset para reiniciar el sistema.
    - switch1, switch2, switch3: Interruptores para seleccionar el modo de tiempo (segundos, décimas, centésimas o milésimas de segundo).
- Salidas
  - seg: Señales para los segmentos a-g del display de 7 segmentos.
  - an: Señales para los ánodos de los 4 dígitos del display.

```
module lab04(
    input clk,             
    input rst,               
    input switch1,           
    input switch2,           
    input switch3,           
    output reg [6:0] seg,    
    output reg [3:0] an
);
```
### Parámetros y Registros
- Parámetros
    - cont_1s, cont_100ms, cont_10ms, cont_1ms: Valores predefinidos para generar diferentes frecuencias (1 Hz, 10 Hz, 100 Hz y 1 kHz) a partir del reloj de 50 MHz.
    - WIDTH: Calcula el ancho necesario para el contador basándose en el valor más grande (cont_1s).
- Registros
  - counter: Contador que divide la frecuencia del reloj para generar las señales clk_mode.
  - mode: Registra el modo de visualización seleccionado (segundos, décimas, centésimas o milésimas).
  - clk_mode: Señal de reloj que controla el incremento del seg_counter.
  - seg_counter: Contador de tiempo que se muestra en el display.
  - digit_select: Registra qué dígito del display está activo.
  - mux_counter: Contador para dividir el reloj y generar la señal clk_mux para la multiplexación del display.
  - current_digit: Valor del dígito que se muestra en el display en el momento.

```
parameter cont_1s = 50000000;     
parameter cont_100ms = 5000000;   
parameter cont_10ms = 500000;     
parameter cont_1ms = 50000;       
localparam WIDTH = $clog2(cont_1s); 
reg [WIDTH-1:0] counter;          // Contador para dividir la frecuencia

reg [1:0] mode;                   
reg clk_mode;                     // Señal de reloj para el modo actual
reg [13:0] seg_counter;           // Contador de tiempo de 14 bits
reg [1:0] digit_select;           
```
### Máquina de Estados para el Modo de Visualización

La máquina de estados selecciona el modo en función de los interruptores switch1, switch2 y switch3. Dependiendo de los interruptores, se cambia el valor del registro mode, que controla la frecuencia del reloj en que se cuenta el tiempo (segundos, décimas, centésimas, milésimas).

```
// Máquina de estado para cambiar de modo
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
```
### Divisor de Frecuencia
Se divide la frecuencia del reloj de entrada "clk" según el modo seleccionado "mode". Por ejemplo, cuando mode es 2'b00 (segundos), el contador se reinicia cuando alcanza cont_1s, lo que genera una señal de 1 Hz. Este contador controla la señal clk_mode que se usa para incrementar el seg_counter.
```
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
```
### Contador de Tiempo
El seg_counter se incrementa en cada pulso de clk_mode. Cuando seg_counter alcanza 9999, se reinicia a 0000.
```
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
```
### Multiplexación del Display de 7 Segmentos
Para manejar los 4 dígitos del display de 7 segmentos con solo un conjunto de señales de segmentos "seg", se multiplexan los dígitos. Se activan los ánodos de los dígitos secuencialmente "an", y se actualiza el valor mostrado por los segmentos rápidamente. El contador "mux_counter" divide el reloj de entrada para generar un reloj de aproximadamente 3 kHz "clk_mux", lo que garantiza que el multiplexado sea lo suficientemente rápido para que el ojo humano perciba que todos los dígitos están encendidos al mismo tiempo, mientras, "digit_select" selecciona qué dígito está activo en un momento dado. Los valores individuales de los dígitos se calculan dividiendo el "seg_counter" para obtener unidades, decenas, centenas y miles (dig1, dig2, dig3, dig4).

```
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
```
#### Animación explicativa del funcionamiento del Múltiplexor (El izquierdo)
<p style="text-align: center;">
  <img src="https://www.cyberphysics.co.uk/graphics/animations/MUX.gif" alt="Animación de Múltiplexor">
</p>


## Resultado del laboratorio
El resultado representado en la FPGA puede verse en el siguiente [Vídeo](https://youtube.com/shorts/_sQfcN54WRc?feature=share)

