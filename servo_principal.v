module servo_principal(
    input clk,                   // Reloj 50 MHz
    input presence_detected,     // Sensor de presencia (activo en alto)
    output reg PWM               // Señal PWM para el servo
);

    parameter PWM_PERIOD = 1_000_000;     // 20 ms @ 50 MHz
    parameter MIN_DUTY = 50_000;          // 0.6 ms → posición cerrada
    parameter MAX_DUTY = 100_000;         // 2.0 ms → posición abierta
    parameter CLOSE_DELAY = 125_000_000;  // 2.5 s @ 50 MHz

    reg [25:0] counter = 0;
    reg [25:0] duty = MIN_DUTY;

    reg [31:0] presence_timer = 0;
    reg presence_last = 0;

    // PWM generation
    always @(posedge clk) begin
        if (counter >= PWM_PERIOD - 1)
            counter <= 0;
        else
            counter <= counter + 1;

        PWM <= (counter < duty) ? 1 : 0;
    end

    // Lógica de control: abre de inmediato cuando no hay presencia,
    // cierra tras 2.5 s si la presencia se mantiene
    always @(posedge clk) begin
        if (!presence_detected) begin
            // Sin presencia → abrir servo inmediatamente
            duty <= MAX_DUTY;
            presence_timer <= 0;
        end else begin
            // Hay presencia
            if (presence_timer < CLOSE_DELAY)
                presence_timer <= presence_timer + 1;
            else
                duty <= MIN_DUTY; // Cerrar tras 2.5 s
        end
    end

endmodule
