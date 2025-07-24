`timescale 1ns/1ps

module tb_Emergency_System;

    // Señales internas
    reg clk = 0;
    reg reset = 0;
    reg btn_activate = 0;
    reg smoke_detected = 0;
    wire buzzer;
    wire led_alert;

    // Instancia del módulo bajo prueba (UUT)
    Emergency_System uut (
        .clk(clk),
        .reset(reset),
        .btn_activate(btn_activate),
        .smoke_detected(smoke_detected),
        .buzzer(buzzer),
        .led_alert(led_alert)
    );

    // Generador de reloj (50 MHz -> periodo = 20ns)
    always #10 clk = ~clk;

    initial begin
        $display("Inicio de simulación");
        $dumpfile("Emergency_System.vcd");
        $dumpvars(0, tb_Emergency_System);

        // 🟢 Etapa 0: Sistema inactivo
        #100;

        // 🟡 Etapa 1: Presionar botón de activación (flanco)
        btn_activate = 1;
        #40;
        btn_activate = 0;
        #500;

        // 🔴 Etapa 2: Reset manual
        reset = 1;
        #20;
        reset = 0;
        #500;

        // 🔥 Etapa 3: Activación por humo (sensor)
        smoke_detected = 1;
        #30;
        smoke_detected = 0;
        #1000;

        // 🔁 Etapa 4: Otro reset mientras NO hay humo
        reset = 1;
        #20;
        reset = 0;
        #300;

        $display("Fin de simulación");
        $finish;
    end

endmodule
