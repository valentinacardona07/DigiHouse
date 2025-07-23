module TopModule (
    input wire clk,
    input wire reset_n,

    // Emergency system inputs
    input wire panic_btn,
    input wire danger_sense,

    // Motor inputs
    input wire btn_Up,
    input wire stop_Up,
    input wire btn_Down,
    input wire stop_Down,

    // PIRs
    input wire pir_input_1,
    input wire pir_input_2,

    // OUTPUTS

    // Emergency outputs
    output wire alarm,
    output wire alert_light,
    output wire door_unlock,
    output wire call_help,

    // Motor output
    output wire [3:0] step_out,

    // PIR LEDs
    output wire led_output_1,
    output wire led_output_2
);

    wire reset = ~reset_n;  // Activo en alto para Emergency_System

    // 1. Emergency System
    Emergency_System emergency_unit (
        .clk(clk),
        .reset(reset),
        .panic_btn(panic_btn),
        .danger_sense(danger_sense),
        .alarm(alarm),
        .alert_light(alert_light),
        .door_unlock(door_unlock),
        .call_help(call_help)
    );

    // 2. Stepper Control
    StepperControl motor_unit (
        .clk(clk),
        .btn_Up(btn_Up),
        .stop_Up(stop_Up),
        .btn_Down(btn_Down),
        .stop_Down(stop_Down),
        .step_out(step_out)
    );

    // 3. PIRs Smart Alarm
    SmartAlarmSystem pir_unit (
        .clk(clk),
        .reset_n(reset_n),
        .pir_input_1(pir_input_1),
        .pir_input_2(pir_input_2),
        .led_output_1(led_output_1),
        .led_output_2(led_output_2)
    );

endmodule
