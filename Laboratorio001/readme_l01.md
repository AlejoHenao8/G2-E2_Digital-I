# Informe Laboratorio 01 
## Punto 1: Compuertas Logicas en Quartus.

 La primera parte del laboratorio consistia en programar desde Quartus,las siguentes compuertas logicas: AND,NOT,OR y XOR esto se hizo en Verilog como se puede ver en el archivo compuertas.v en la carpeta src, en el programa se difinieron las salidas desde S1,S2,S3 y S4 , las entradas como A,B y C, luego se le asigno a cada salida la logica correspondiete de cada compuerta logica deseada, S1 para AND, S2 para NOT, S3 para OR y S4 para XOR.

 La segunda parte del laboratorio fue la programación del Testbench que se utilizaria para simular las compuertas logicas en el archivo compuertas.v, para esto se definieron las entradas como reg y las salidas como wire, posteriormente se definieron todas las combinaciones de 1 o 0 de las variables, para obtener todas las salidas posibles, finalmente se escribio un pequeño script para crear un archivo .vcd para la posterior simulación con Icarus y gtkwave, todo lo anterior se puede ver en el archivo compuertas_tb.v.

 La ultima parte del laboratorio consistio en la simulación de las compuertas logicas con Icarus y gtkwave, para esto desde la carpeta build en el terminal se corrio el siguente comando "gtkwave compuertas.vcd" esto comenzo la simulación que tuvo los resultados que se pueden observar en la siguente imagen:

 ![](Imagenes/Gráfica_compuertas.png)


## Punto 2: Sumador de bits en Quartus.




