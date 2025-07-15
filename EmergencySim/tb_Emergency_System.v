`timescale 1ns/1ps

module tb_Emergency_System;

    reg clk = 0;
    reg reset = 0;
    reg panic_btn = 0;
    reg danger_sense = 0;

    wire alarm, alert_light, door_unlock, call_help;

    Emergency_System uut (
        .clk(clk),
        .reset(reset),
        .panic_btn(panic_btn),
        .danger_sense(danger_sense),
        .alarm(alarm),
        .alert_light(alert_light),
        .door_unlock(door_unlock),
        .call_help(call_help)
    );

    // Clock: 50 MHz = 20 ns
    always #10 clk = ~clk;

    initial begin
        $dumpfile("emergency_system.vcd"); // GTKWave
        $dumpvars(0, tb_Emergency_System);

        // Reset
        reset = 1;
        #100;
        reset = 0;

        // Trigger panic button (simulate rising edge)
        #100;
        panic_btn = 1;
        #20;
        panic_btn = 0;

        // Let it run through EMERGENCY → POST_EMERGENCY → INACTIVE
        #2_000_000; // Wait ~40ms
        danger_sense = 1;  // Activate danger
        #1_000_000;
        danger_sense = 0;  // Clear danger
        #10_000_000;

        // Trigger again with danger_sense input only
        #1_000_000;
        danger_sense = 1;
        #2_000_000;
        danger_sense = 0;

        #20_000_000;

        $finish;
    end

endmodule
