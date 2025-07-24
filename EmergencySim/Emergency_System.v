module Lab3digital1 (
    input wire clk,            // Reloj de 50 MHz
    input wire reset_n,        // Reset activo en bajo
    input wire panic_btn_n,    // Botón de pánico activo en bajo
    input wire danger_sense,   // Sensor de peligro activo en alto
    output reg alarm,          // Zumbador
    output reg alert_light,    // LED de alerta
    output reg door_unlock,    // Relé para puerta
    output reg call_help       // Comunicación
);

    // Temporizador de activación por pánico
    localparam integer PANIC_THRESHOLD = 100_000_000; // 2 segundos @ 50MHz
    localparam integer ALARM_HOLD_TIME = 500_000_000; // 10 segundos @ 50MHz

    reg [26:0] panic_counter = 0;
    reg [28:0] alarm_hold_counter = 0;

    reg alarm_active = 0;

    wire panic_pressed = (panic_btn_n == 1'b0);
    wire reset_pressed = (reset_n == 1'b0);

    always @(posedge clk) begin
        if (!reset_n) begin
            panic_counter <= 0;
            alarm_hold_counter <= 0;
            alarm_active <= 0;
        end else begin
            if (!alarm_active) begin
                if (panic_pressed) begin
                    if (panic_counter < PANIC_THRESHOLD)
                        panic_counter <= panic_counter + 1;
                    else begin
                        alarm_active <= 1;  // Activar alarma tras 2s
                        alarm_hold_counter <= 0;
                    end
                end else begin
                    panic_counter <= 0;  // Botón liberado antes de tiempo
                end
            end else begin
                // ALARMA ACTIVA
                if (reset_pressed && danger_sense == 0) begin
                    alarm_active <= 0;
                    panic_counter <= 0;
                    alarm_hold_counter <= 0;
                end else begin
                    // Mantenemos la alarma durante 10 segundos
                    if (alarm_hold_counter < ALARM_HOLD_TIME)
                        alarm_hold_counter <= alarm_hold_counter + 1;
                    else if (danger_sense == 0)
                        alarm_active <= 0;
                end
            end
        end
    end

    // Salidas del sistema
    always @(*) begin
        if (alarm_active) begin
            alarm       = 1;
            alert_light = 1;
            door_unlock = 1;
            call_help   = 1;
        end else begin
            alarm       = 0;
            alert_light = 0;
            door_unlock = 0;
            call_help   = 0;
        end
    end

endmodule
