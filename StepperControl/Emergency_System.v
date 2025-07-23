module Emergency_System (
    input wire clk,           // PIN_23 (Reloj 50MHz)
    input wire reset_n,       // PIN_91 (Botón físico activo bajo)
    input wire panic_btn_n,   // PIN_141 (Botón pánico activo bajo)
    input wire danger_sense,  // PIN_142 (Sensor PIR activo alto)

    output wire alarm_pin,        // PIN_30 (Zumbador activo bajo)
    output wire alert_light_pin, // PIN_74 (LED rojo activo bajo)
    output wire door_unlock_pin, // PIN_125 (Relé activo bajo)
    output wire call_help_pin    // PIN_126 (Comunicación activa baja)
);

    // Estados FSM
    typedef enum reg [1:0] {
        INACTIVE       = 2'b00,
        EMERGENCY      = 2'b01,
        POST_EMERGENCY = 2'b10
    } state_t;

    state_t state = INACTIVE, next_state;

    // Temporizadores
    localparam EMERGENCY_TIMEOUT = 5_000_000;  // ~100 ms a 50 MHz
    localparam RECOVERY_TIMEOUT  = 10_000_000; // ~200 ms

    reg [23:0] timer = 0;

    // Señales internas
    wire reset      = ~reset_n;       // Activo alto internamente
    wire panic_btn  = ~panic_btn_n;   // Activo alto internamente
    reg  panic_prev = 0;

    // Salidas internas (lógica positiva)
    reg alarm        = 0;
    reg alert_light  = 0;
    reg door_unlock  = 0;
    reg call_help    = 0;

    // Detección de flanco de subida en botón de pánico
    always @(posedge clk) begin
        panic_prev <= panic_btn;
    end

    // FSM principal
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

    // Lógica de transición de estado
    always @(*) begin
        next_state = state;

        case (state)
            INACTIVE: begin
                if ((panic_btn && !panic_prev) || danger_sense)
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

            default: next_state = INACTIVE;
        endcase
    end

    // Lógica de salidas internas
    always @(*) begin
        alarm       = 0;
        alert_light = 0;
        door_unlock = 0;
        call_help   = 0;

        case (state)
            EMERGENCY: begin
                alarm        = ~timer[22];  // Parpadeo rápido
                alert_light  = 1;
                door_unlock  = 1;
                call_help    = 1;
            end

            POST_EMERGENCY: begin
                alert_light = timer[21];  // Parpadeo lento
            end
        endcase
    end

    // Salidas físicas (adaptadas a lógica activa baja)
    assign alarm_pin        = ~alarm;
    assign alert_light_pin  = ~alert_light;
    assign door_unlock_pin  = ~door_unlock;
    assign call_help_pin    = ~call_help;

endmodule
