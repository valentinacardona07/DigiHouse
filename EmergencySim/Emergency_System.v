module Emergency_System (
    input wire clk,           // PIN_23 (Reloj 50MHz)
    input wire reset,         // PIN_24 (Botón físico)
    input wire panic_btn,     // PIN_25 (Botón pánico)
    input wire danger_sense,  // PIN_26 (Sensor peligro)
    output reg alarm,         // PIN_27 (Zumbador)
    output reg alert_light,   // PIN_28 (LED rojo)
    output reg door_unlock,   // PIN_29 (Relé puerta)
    output reg call_help      // PIN_30 (Comunicación)
);

    // Estados
    parameter INACTIVE       = 2'b00;
    parameter EMERGENCY      = 2'b01;
    parameter POST_EMERGENCY = 2'b10;

    reg [1:0] state = INACTIVE;
    reg [1:0] next_state = INACTIVE;

    // Constantes de tiempo
    localparam EMERGENCY_TIMEOUT = 5_000_000;  // ~100 ms @ 50 MHz
    localparam RECOVERY_TIMEOUT  = 10_000_000; // ~200 ms

    // Contador de tiempo
    reg [24:0] timer = 0;

    // Flanco de subida en panic_btn
    reg panic_r1 = 0, panic_r2 = 0;
    wire panic_rising = panic_r1 & ~panic_r2;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            panic_r1 <= 0;
            panic_r2 <= 0;
        end else begin
            panic_r1 <= panic_btn;
            panic_r2 <= panic_r1;
        end
    end

    // Máquina de estados
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= INACTIVE;
            timer <= 0;
        end else begin
            state <= next_state;
            if (state != next_state)
                timer <= 0;
            else
                timer <= timer + 1;
        end
    end

    // Transiciones
    always @(*) begin
        next_state = state;
        case (state)
            INACTIVE: begin
                if (panic_rising || danger_sense)
                    next_state = EMERGENCY;
            end
            EMERGENCY: begin
                if (timer >= EMERGENCY_TIMEOUT && ~danger_sense)
                    next_state = POST_EMERGENCY;
            end
            POST_EMERGENCY: begin
                if (timer >= RECOVERY_TIMEOUT)
                    next_state = INACTIVE;
            end
        endcase
    end

    // Salidas
    always @(*) begin
        alarm       = 0;
        alert_light = 0;
        door_unlock = 0;
        call_help   = 0;

        case (state)
            EMERGENCY: begin
                alarm       = ~timer[22];  // Parpadeo rápido
                alert_light = 1;
                door_unlock = 1;
                call_help   = 1;
            end
            POST_EMERGENCY: begin
                alert_light = timer[21];  // Parpadeo lento
            end
        endcase
    end

endmodule


