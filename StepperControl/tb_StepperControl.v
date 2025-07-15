`timescale 1ns / 1ps

module tb_StepperControl;

    reg clk = 0;
    reg btn_Up = 1;       // Inactivo
    reg stop_Up = 1;      // Sin detener
    reg btn_Down = 1;     // Inactivo
    reg stop_Down = 1;    // Sin detener
    wire [3:0] step_out;

    // Instanciar el DUT
    StepperControl uut (
        .clk(clk),
        .btn_Up(btn_Up),
        .stop_Up(stop_Up),
        .btn_Down(btn_Down),
        .stop_Down(stop_Down),
        .step_out(step_out)
    );

    // Clock: 50 MHz → 20 ns periodo
    always #10 clk = ~clk;

    initial begin
        $dumpfile("stepper_sim.vcd");
        $dumpvars(0, tb_StepperControl);

        // Espera inicial
        #100;

        // Simula avance (btn_Up presionado)
        btn_Up = 0;
        repeat (10) #2_000_000; // ~0.1 s = 5_000_000 ciclos de 20 ns
        btn_Up = 1;

        // Simula retroceso (btn_Down presionado)
        btn_Down = 0;
        repeat (5) #2_000_000;
        btn_Down = 1;

        // Simula bloqueo por fin de carrera superior
        btn_Up = 0;
        stop_Up = 0; // Activado
        #5_000_000;
        btn_Up = 1;
        stop_Up = 1;

        // Simula retroceso otra vez
        btn_Down = 0;
        #10_000_000;
        btn_Down = 1;

        $finish;
    end

endmodule
