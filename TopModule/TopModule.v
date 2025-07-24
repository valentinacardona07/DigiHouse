module TopModule(
    input wire clk,             // Reloj global 50 MHz
    input wire reset,           // Reset global

    // Entradas específicas
    input wire panic_btn,
    input wire smoke_detected,
    input wire pir1,
    input wire pir2,
    input wire btn_up,
    input wire btn_down,
    input wire stop_up,
    input wire stop_down,
    input wire presence1,
    input wire presence2,
    input wire light_sensor,

    // Salidas
    output wire buzzer,
    output wire alert_light,
    output wire door_unlock,
    output wire call_help,
    output wire led_output_1,
    output wire led_output_2,
    output wire [3:0] step_out,
    output wire PWM1,
    output wire PWM2,
    output wire smart_light
);

// === Sistema de emergencia ===
Emergency_System emergency_inst (
    .clk(clk),
    .reset(reset),
    .btn_activate(panic_btn),
    .smoke_detected(smoke_detected),
    .buzzer(buzzer),
    .led_alert(alert_light)
);

// === Smart Alarm (sensores PIR) ===
SmartAlarmSystem alarm_inst (
    .clk(clk),
    .reset_n(~reset),         // Reset activo en bajo
    .pir_input_1(pir1),
    .pir_input_2(pir2),
    .led_output_1(led_output_1),
    .led_output_2(led_output_2)
);

// === Control de motor paso a paso ===
StepperControl stepper_inst (
    .clk(clk),
    .btn_Up(btn_up),
    .btn_Down(btn_down),
    .stop_Up(stop_up),
    .stop_Down(stop_down),
    .step_out(step_out)
);

// === Servo doble control ===
servo_principal servo_inst (
    .clk(clk),
    .presence_1(presence1),
    .presence_2(presence2),
    .PWM1(PWM1),
    .PWM2(PWM2)
);

// === Smart Light ===
smartlight_system smartlight_inst (
    .clk(clk),
    .reset(reset),
    .light_sensor(light_sensor),
    .led_out(smart_light)
);

endmodule
