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

    // ?? Para simulación, umbral reducido (~200 ms)
    localparam integer PANIC_THRESHOLD = 100_000_000; // 200 ms @ 50 MHz

    reg [23:0] panic_counter = 0;
    reg alarm_active = 0;

    wire panic_pressed = (panic_btn_n == 0);
    wire reset_pressed = (reset_n == 0);

    // FSM
    always @(posedge clk) begin
        if (!reset_n) begin
            panic_counter <= 0;
            alarm_active <= 0;
        end else begin
            if (!alarm_active) begin
                if (panic_pressed) begin
                    if (panic_counter < PANIC_THRESHOLD)
                        panic_counter <= panic_counter + 1;
                    else
                        alarm_active <= 1;  // Activar alarma tras 200 ms
                end else begin
                    panic_counter <= 0;
                end
            end else begin
                if (reset_pressed && !danger_sense) begin
                    alarm_active <= 0;
                    panic_counter <= 0;
                end
            end
        end
    end

    // Salidas combinacionales
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
