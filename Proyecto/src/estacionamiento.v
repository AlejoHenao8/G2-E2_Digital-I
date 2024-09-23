module estacionamiento (
    input wire clk,           // Señal de reloj
    input wire ech,           // Señal del pulso "echo"
    output reg trigger_o,     // Señal de activación del "trigger"
    output reg led_50cm,      // LED para la distancia entre 0 y 50 cm
    output reg led_100cm,     // LED para la distancia entre 60 y 100 cm
    output reg led_200cm,     // LED para la distancia entre 110 y 200 cm
    output reg buzzer         // Buzzer
);

    // Parámetros para el cálculo de tiempo
    parameter CLOCK_FREQ = 50000000; // Frecuencia del reloj 50MHz
    parameter SOUND_SPEED = 34300;   // Velocidad del sonido en cm/s
    parameter DISTANCE_50CM = 50;    // Umbral de 50 cm
    parameter DISTANCE_60CM = 60;    // Umbral de 60 cm
    parameter DISTANCE_100CM = 100;  // Umbral de 100 cm
    parameter DISTANCE_110CM = 110;  // Umbral de 110 cm
    parameter DISTANCE_200CM = 200;  // Umbral de 200 cm

    // Cálculo de los tiempos umbrales en ciclos de reloj 

    parameter TIME_50CM  = (2 * DISTANCE_50CM * CLOCK_FREQ) / SOUND_SPEED;  // Tiempo para 50 cm
    parameter TIME_60CM  = (2 * DISTANCE_60CM * CLOCK_FREQ) / SOUND_SPEED;  // Tiempo para 60 cm
    parameter TIME_100CM = (2 * DISTANCE_100CM * CLOCK_FREQ) / SOUND_SPEED; // Tiempo para 100 cm
    parameter TIME_110CM = (2 * DISTANCE_110CM * CLOCK_FREQ) / SOUND_SPEED; // Tiempo para 110 cm
    parameter TIME_200CM = (2 * DISTANCE_200CM * CLOCK_FREQ) / SOUND_SPEED; // Tiempo para 200 cm

/*  //Tiempos sugeridos para simular en GTKWave
    parameter TIME_50CM  = 100;  // Tiempo para 50 cm
    parameter TIME_60CM  = 210;  // Tiempo para 60 cm
    parameter TIME_100CM = 900; // Tiempo para 100 cm
    parameter TIME_110CM = 1200; // Tiempo para 110 cm
    parameter TIME_200CM = 1500; // Tiempo para 200 cm
*/
    reg [31:0] echo_time;     // Contador de tiempo para el pulso "echo"
    reg measuring;            // Bandera que indica si estamos midiendo el tiempo
    reg [23:0] trigger_count; // Contador para el tiempo de activación del trigger
    reg [31:0] delay_count;   // Contador para el retraso entre triggers

    // Inicialización de registros
    initial begin
        measuring <= 0;
        echo_time <= 0;
        trigger_count <= 0;
        delay_count <= 0;
        trigger_o <= 0;
        led_50cm <= 0;  // Inicialmente apagado
        led_100cm <= 0; // Inicialmente apagado
        led_200cm <= 0; // Inicialmente apagado
        buzzer <= 0;    // Inicialmente apagado
    end

    // FSM para generar el pulso "trigger" (10us cada 60ms aprox.)
    always @(posedge clk) begin
        if (delay_count == 0) begin
            if (trigger_count == 0) begin
                trigger_o <= 1; // Activa el trigger por 10us
                trigger_count <= CLOCK_FREQ / 100000; // 10us a 50MHz
            end else if (trigger_count == 1) begin
                trigger_o <= 0; // Desactiva el trigger
                trigger_count <= 0;
                delay_count <= CLOCK_FREQ / 16; // Retardo de aprox. 60ms entre triggers
            end else begin
                trigger_count <= trigger_count - 1;
            end
        end else begin
            delay_count <= delay_count - 1;
        end
    end

    // Estado de medición de la señal "echo"
    always @(posedge clk) begin
        if (trigger_o == 0 && ech == 1 && !measuring) begin
            // Comenzamos a medir cuando recibimos el flanco ascendente de "echo"
            measuring <= 1;
            echo_time <= 0;
        end else if (measuring) begin
            if (ech == 0) begin
                // Terminamos de medir cuando recibimos el flanco descendente de "echo"
                measuring <= 0;

                // Apagamos todos los LEDs (anodos) y el buzzer antes de determinar cuál encender
                        //Invertir los valores de estas variables para simular
                led_50cm <= 1;  
                led_100cm <= 1;
                led_200cm <= 1;
                buzzer <= 1;

                // Encender solo el LED correspondiente en función de la distancia medida
                if (echo_time <= TIME_50CM) begin
                    // Encender LED para menos de 50 cm y activar buzzer
                    led_50cm <= 0;
                    buzzer <= 0; // Activar buzzer
                end else if (echo_time > TIME_50CM && echo_time < TIME_100CM) begin
                    // Encender LED para entre 60 cm y 100 cm
                    led_100cm <= 0;
                end else if (echo_time > TIME_100CM) begin
                    // Encender LED para entre 110 cm y 200 cm
                    led_200cm <= 0;
                end
            end else begin
                // Seguimos midiendo el tiempo del pulso "echo"
                echo_time <= echo_time + 1;
            end
        end
    end

endmodule