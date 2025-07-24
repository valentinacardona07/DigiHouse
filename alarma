module alarma (
    input wire clk,              // Reloj del sistema (50 MHz)
    input wire reset,            // Botón para apagar la alarma (activo en alto)
    input wire btn_activate,     // Botón para activar alarma
    input wire smoke_detected,   // Sensor de humo
    output wire buzzer,          // Buzzer activo en bajo
    output wire led_alert        // LED activo en bajo (parpadea)
);

    reg alarm_active = 0;

    // Para detección de flanco
    reg btn_prev = 0;
    reg smoke_prev = 0;
    reg reset_prev = 0;

    // Registro para parpadeo
    reg [25:0] blink_counter = 0;  // 26 bits para contar hasta 50 millones
    reg led_blink = 0;

    // === LÓGICA DE ALARMA ===
    always @(posedge clk) begin
        // Flancos
        if (reset && !reset_prev)
            alarm_active <= 0;
        else if ((btn_activate && !btn_prev) || (smoke_detected && !smoke_prev))
            alarm_active <= 1;

        btn_prev   <= btn_activate;
        smoke_prev <= smoke_detected;
        reset_prev <= reset;
    end

    // === PARPADEO DEL LED ===
    always @(posedge clk) begin
        if (alarm_active) begin
            // Contador para parpadeo (50M ciclos = 1 segundo)
            if (blink_counter >= 2_500_000) begin
                blink_counter <= 0;
                led_blink <= ~led_blink;
            end else begin
                blink_counter <= blink_counter + 1;
            end
        end else begin
            // Reiniciar cuando no hay alarma
            blink_counter <= 0;
            led_blink <= 0;
        end
    end

    // === SALIDAS ACTIVAS EN BAJO ===
    assign buzzer    = ~alarm_active;         // Siempre encendido si alarma activa
    assign led_alert = ~(alarm_active && led_blink); // Parpadea mientras haya alarma

endmodule
