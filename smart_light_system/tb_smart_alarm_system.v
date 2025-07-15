`timescale 1ns / 1ps

module tb_SmartAlarmSystem;

    reg clk = 0;
    reg reset_n = 0;
    reg pir_input_1 = 0;
    reg pir_input_2 = 0;

    wire led_output_1;
    wire led_output_2;

    // Instancia del DUT
    SmartAlarmSystem uut (
        .clk(clk),
        .reset_n(reset_n),
        .pir_input_1(pir_input_1),
        .pir_input_2(pir_input_2),
        .led_output_1(led_output_1),
        .led_output_2(led_output_2)
    );

    // Clock de 50 MHz
    always #10 clk = ~clk;

    initial begin
        // Inicialización
        $dumpfile("smart_alarm_system.vcd");
        $dumpvars(0, tb_SmartAlarmSystem);

        // Reset
        reset_n = 0;
        #50;
        reset_n = 1;

        // Simulación PIR 1
        #100;
        pir_input_1 = 1; #100;
        pir_input_1 = 0;

        // Simulación PIR 2
        #200;
        pir_input_2 = 1; #100;
        pir_input_2 = 0;

        // Esperar que LEDs se apaguen
        #5_000_000;

        $finish;
    end

endmodule
