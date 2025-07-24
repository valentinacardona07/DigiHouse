module TopModule (
    input wire clk,
    input wire reset,
    
    // Emergency System
    input wire btn_activate,
    input wire smoke_detected,
    output wire buzzer,
    output wire led_alert,

    // Smart Light System
    input wire pir_input_1,
    input wire pir_input_2,
    output wire led_output_1,
    output wire led_output_2,

    // Stepper Control
    input wire btn_Up,
    input wire stop_Up,
    input wire btn_Down,
    input wire stop_Down,
    output wire [3:0] step_out,

    // Servo System
    input wire presence_1,
    input wire presence_2,
    output wire PWM1,
    output wire PWM2
);

    // Emergency System instance
    Emergency_System emergency_inst (
        .clk(clk),
        .reset(reset),
        .btn_activate(btn_activate),
        .smoke_detected(smoke_detected),
        .buzzer(buzzer),
        .led_alert(led_alert)
    );

    // Smart Light System instance
    SmartAlarmSystem smart_light_inst (
        .clk(clk),
        .reset_n(~reset),  // reset activo en bajo
        .pir_input_1(pir_input_1),
        .pir_input_2(pir_input_2),
        .led_output_1(led_output_1),
        .led_output_2(led_output_2)
    );

    // Stepper Motor Control
    StepperControl stepper_inst (
        .clk(clk),
        .btn_Up(btn_Up),
        .stop_Up(stop_Up),
        .btn_Down(btn_Down),
        .stop_Down(stop_Down),
        .step_out(step_out)
    );

    // Dual Servo System
    servo_principal servo_inst (
        .clk(clk),
        .presence_1(presence_1),
        .presence_2(presence_2),
        .PWM1(PWM1),
        .PWM2(PWM2)
    );

endmodule
