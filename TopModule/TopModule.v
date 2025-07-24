module TopModule(
    input wire clk,                  // Reloj de 50 MHz
    input wire reset_n,             // Reset global activo en bajo

    // Emergency System Inputs
    input wire panic_btn,           // Botón de pánico (activo en alto)
    input wire smoke_detected,      // Sensor de humo (activo en alto)

    // Smart Alarm PIR
    input wire pir1,
    input wire pir2,

    // Stepper Control
    input wire btn_Up,
    input wire stop_Up,
    input wire btn_Down,
    input wire stop_Down,

    // Servo Presence Detection
    input wire presence_1,
    input wire presence_2,

    // Outputs
    output wire alarm_buzzer,
    output wire led_alert,
    output wire led_pir1,
    output wire led_pir2,
    output wire [3:0] stepper_out,
    output wire servo_pwm1,
    output wire servo_pwm2
);

    // ────────────────────────────────────────
    // 🔔 Módulo de Emergencia
    Emergency_System emergency_inst (
        .clk(clk),
        .reset(reset_n),
        .btn_activate(panic_btn),
        .smoke_detected(smoke_detected),
        .buzzer(alarm_buzzer),
        .led_alert(led_alert)
    );

    // ────────────────────────────────────────
    // 👀 Módulo de Sensores PIR
    SmartAlarmSystem pir_alarms (
        .clk(clk),
        .reset_n(reset_n),
        .pir_input_1(pir1),
        .pir_input_2(pir2),
        .led_output_1(led_pir1),
        .led_output_2(led_pir2)
    );

    // ────────────────────────────────────────
    // 🌀 Control del Motor Paso a Paso
    StepperControl stepper_inst (
        .clk(clk),
        .btn_Up(btn_Up),
        .stop_Up(stop_Up),
        .btn_Down(btn_Down),
        .stop_Down(stop_Down),
        .step_out(stepper_out)
    );

    // ────────────────────────────────────────
    // 🚪 Servo doble (puerta)
    servo_principal dual_servo (
        .clk(clk),
        .presence_1(presence_1),
        .presence_2(presence_2),
        .PWM1(servo_pwm1),
        .PWM2(servo_pwm2)
    );

endmodule
