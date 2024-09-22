`timescale 1ns / 1ps

module estacionamiento_tb;

    // Declaración de señales
    reg clk;
    reg ech;
    wire trigger_o;
    wire led_50cm;
    wire led_100cm;
    wire led_200cm;
    wire buzzer;

    // Instancia del módulo a probar
    estacionamiento dut (
        .clk(clk),
        .ech(ech),
        .trigger_o(trigger_o),
        .led_50cm(led_50cm),
        .led_100cm(led_100cm),
        .led_200cm(led_200cm),
        .buzzer(buzzer)
    );

    // Generar el reloj con un periodo de 20ns (50MHz)
    always begin
        #10 clk = ~clk;
    end

    // Inicialización de señales
    initial begin
        // Inicialización del reloj
        clk = 0;
        ech = 0;
        
        // Simulación: Ciclo de medición a 30ms
        // Paso 1: Trigger se activa por 10us (ya manejado por el módulo)
        
        // Paso 2: Simular respuesta del pulso "echo" con diferentes tiempos de propagación

        // Distancia de 30cm (debería encender el LED de 50cm y el buzzer)
        #10000;  // Espera 100us antes de empezar
        ech = 1;  // Pulso de inicio de "echo"
        #1750;    // Pulso de duración para ~30cm (tiempo aproximado de eco)
        ech = 0;  // Pulso de fin de "echo"
        
        // Espera unos ciclos antes de la siguiente medición
        #500;

        // Distancia de 75cm (debería encender el LED de 100cm)
        #10000;  // Espera 100us antes de empezar
        ech = 1;  // Pulso de inicio de "echo"
        #4380;    // Pulso de duración para ~75cm (tiempo aproximado de eco)
        ech = 0;  // Pulso de fin de "echo"
        
        // Espera unos ciclos antes de la siguiente medición
        #500;

        // Distancia de 150cm (debería encender el LED de 200cm)
        #10000;  // Espera 100us antes de empezar
        ech = 1;  // Pulso de inicio de "echo"
        #19770;    // Pulso de duración para ~150cm (tiempo aproximado de eco)
        ech = 0;  // Pulso de fin de "echo"
        
        // Espera unos ciclos antes de la siguiente medición
        #5000;

        // Finalizar la simulación
        $finish;
    end

    // Dumps para ver en GTKWave
    initial begin
        $dumpfile("estacionamiento_tb.vcd");
        $dumpvars(0, estacionamiento_tb);
    end

endmodule
