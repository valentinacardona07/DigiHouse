`timescale 1ns / 1ps

module tb_servo_principal;

    reg clk = 0;
    reg presence_1 = 0;
    reg presence_2 = 0;
    wire PWM1, PWM2;

    // Instancia del DUT (Device Under Test)
    servo_principal uut (
        .clk(clk),
        .presence_1(presence_1),
        .presence_2(presence_2),
        .PWM1(PWM1),
        .PWM2(PWM2)
    );

    // Reloj de 50MHz
    always #10 clk = ~clk;

    initial begin
        $dumpfile("servo_principal.vcd");
        $dumpvars(0, tb_servo_principal);

        // Escenario de prueba

        $display("Inicio de simulación");

        // Inicialmente sin presencia
        presence_1 = 0;
        presence_2 = 0;
        #5_000_000;

        // Detecta presencia en 1 (abre)
        $display("Presencia detectada en sensor 1");
        presence_1 = 1;
        #130_000_000;

        // Se retira presencia 1
        $display("Presencia retirada en sensor 1");
        presence_1 = 0;
        #20_000_000;

        // Detecta presencia en 2 (cierra)
        $display("Presencia detectada en sensor 2");
        presence_2 = 1;
        #130_000_000;

        $display("Fin de simulación");
        $finish;
    end

endmodule
