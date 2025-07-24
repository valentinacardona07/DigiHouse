module servo_principal(
    input clk,                     // Reloj 50 MHz
    input presence_1,             // Sensor para servo 1 (activo en alto)
    input presence_2,             // Sensor para servo 2 (activo en alto)
    output reg PWM1,              // PWM para servo 1
    output reg PWM2               // PWM para servo 2
);

    parameter PWM_PERIOD = 1_000_000;     // 20 ms @ 50 MHz
    parameter MIN_DUTY = 50_000;          // 0.6 ms → posición mínima
    parameter MAX_DUTY = 100_000;         // 2.0 ms → posición máxima
    parameter CLOSE_DELAY = 125_000_000;  // 2.5 s @ 50 MHz

    // PWM counter compartido
    reg [25:0] counter = 0;

    // Servo 1
    reg [25:0] duty_1 = MIN_DUTY;
    reg [31:0] timer_1 = 0;

    // Servo 2
    reg [25:0] duty_2 = MAX_DUTY;
    reg [31:0] timer_2 = 0;

    // Generación del PWM compartido
    always @(posedge clk) begin
        if (counter >= PWM_PERIOD - 1)
            counter <= 0;
        else
            counter <= counter + 1;

        PWM1 <= (counter < duty_1) ? 1 : 0;
        PWM2 <= (counter < duty_2) ? 1 : 0;
    end

    // Lógica de control del servo 1 (igual a `servo_principal`)
    always @(posedge clk) begin
        if (!presence_1) begin
            duty_1 <= MAX_DUTY;
            timer_1 <= 0;
        end else begin
            if (timer_1 < CLOSE_DELAY)
                timer_1 <= timer_1 + 1;
            else
                duty_1 <= MIN_DUTY;
        end
    end

    // Lógica de control del servo 2 (igual a `servo_habitacion`)
    always @(posedge clk) begin
        if (!presence_2) begin
            duty_2 <= MIN_DUTY;
            timer_2 <= 0;
        end else begin
            if (timer_2 < CLOSE_DELAY)
                timer_2 <= timer_2 + 1;
            else
                duty_2 <= MAX_DUTY;
        end
    end

endmodule
