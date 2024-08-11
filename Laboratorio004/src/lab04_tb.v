`timescale 1ns / 1ps

module lab04_tb;

    reg clk;
    reg rst;
    reg switch1;
    reg switch2;
    reg switch3;
    wire [6:0] seg;
    wire [3:0] an;

    // Instancia del módulo a probar
    lab04 uut (
        .clk(clk),
        .rst(rst),
        .switch1(switch1),
        .switch2(switch2),
        .switch3(switch3),
        .seg(seg),
        .an(an)
    );

    // Generación del reloj (50 MHz)
    always #10 clk = ~clk;  // Periodo de 20 ns => 50 MHz

    initial begin
        // Inicialización de señales
        clk = 0;
        rst = 1;
        switch1 = 0;
        switch2 = 0;
        switch3 = 0;
        
        // Liberar el reset
        #100 rst = 0;
        
        // Probar el conteo en segundos (modo por defecto)
        #500_000_000; // Esperar 10 ms (10 MHz en tiempo real) para que cuente hasta 1
        
        // Cambiar a décimas de segundo
        switch1 = 1;
        #100_000_000; // Esperar 1 ms en tiempo real
        switch1 = 0;
        
        // Cambiar a centésimas de segundo
        switch2 = 1;
        #10_000_000; // Esperar 0.1 ms en tiempo real
        switch2 = 0;
        
        // Cambiar a milésimas de segundo
        switch3 = 1;
        #1_000_000; // Esperar 0.01 ms en tiempo real
        switch3 = 0;
        
        // Finalizar simulación
        #100_000;
        $finish;
    end

endmodule
