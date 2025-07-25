// ---------- House.v --------------------------------------------------
module House
(
    // ═══════════ Entradas de placa ═══════════
    input  wire       CLK_50,          // Reloj de 50 MHz

    // — Alarma —
    input  wire       RESET_ALARM,     // Reset activo-alto
    input  wire       BTN_ACTIVATE,
    input  wire       SMOKE_SENSOR,

    // — Plataforma (motor PAP) —
    input  wire [1:0] SWITCH_POS,
    input  wire       LIMIT_UP_N,      // Activo-bajo
    input  wire       LIMIT_DOWN_N,    // Activo-bajo

    // — Servos —
    input  wire       PRESENCE_S1,
    input  wire       PRESENCE_S2,

    // — Iluminación —
    input  wire       LIGHTS_RESET_N,  // Reset activo-bajo para SmartLights
    input  wire       PIR_INPUT_1,
    input  wire       PIR_INPUT_2,

    // ═══════════ Salidas de placa ═══════════
    output wire       BUZZER_OUT,
    output wire       LED_ALERT_OUT,
    output wire [3:0] STEPPER_OUT,
    output wire       SERVO_PWM1,
    output wire       SERVO_PWM2,
    output wire       LED_LIGHT_1,
    output wire       LED_LIGHT_2
);

    /* ───────────────── 1. Alarma ───────────────── */
    alarma u_alarma (
        .clk            (CLK_50),
        .reset          (RESET_ALARM),
        .btn_activate   (BTN_ACTIVATE),
        .smoke_detected (SMOKE_SENSOR),
        .buzzer         (BUZZER_OUT),
        .led_alert      (LED_ALERT_OUT)
    );

    /* ───────────────── 2. Plataforma (PAP) ───────────────── */
    platform u_platform (
        .clk        (CLK_50),
        .switch_pos (SWITCH_POS),
        .stop_Up    (LIMIT_UP_N),
        .stop_Down  (LIMIT_DOWN_N),
        .step_out   (STEPPER_OUT)
    );

    /* ───────────────── 3. Servos SG90 ───────────────── */
    servo_principal u_servos (
        .clk        (CLK_50),
        .presence_1 (PRESENCE_S1),
        .presence_2 (PRESENCE_S2),
        .PWM1       (SERVO_PWM1),
        .PWM2       (SERVO_PWM2)
    );

    /* ───────────────── 4. Iluminación PIR ───────────────── */
    SmartLights u_lights (
        .clk         (CLK_50),
        .reset_n     (LIGHTS_RESET_N),
        .pir_input_1 (PIR_INPUT_1),
        .pir_input_2 (PIR_INPUT_2),
        .led_output_1(LED_LIGHT_1),
        .led_output_2(LED_LIGHT_2)
    );

endmodule
