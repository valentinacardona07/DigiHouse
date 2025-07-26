// ───────────────────────────────────────────────
//   Simulación doble PIR con 2 sensores (activos‑BAJO)
//   Cada PIR controla un LED (activo‑ALTO)
//   Retardo de apagado por 5 segundos por canal
// ───────────────────────────────────────────────
module SmartLights(
    input  wire clk,            // 50 MHz
    input  wire reset_n,        // Reset asíncrono activo‑BAJO
    input  wire pir_input_1,    // PIR 1 (activo‑BAJO simulado con botón)
    input  wire pir_input_2,    // PIR 2 (activo‑BAJO simulado con botón)
    output reg  led_output_1,           // LED 1 (activo‑ALTO)
    output reg  led_output_2            // LED 2 (activo‑ALTO)
);

    // ───── Parámetros ─────
    parameter CLK_FREQ_HZ   = 50_000_000;
    parameter HOLD_TIME_SEC = 5;

    localparam integer MAX_COUNT = CLK_FREQ_HZ * HOLD_TIME_SEC;
    localparam integer CNT_W     = 28;          // 2^28 ≈ 268 M > 250 M

    // ───── Señales internas ─────
    wire pir1 = ~pir_input_1;                   // ‘1’ cuando se activa PIR 1
    wire pir2 = ~pir_input_2;                   // ‘1’ cuando se activa PIR 2

    reg [CNT_W-1:0] hold_cnt1 = 0;
    reg [CNT_W-1:0] hold_cnt2 = 0;

    // ───── Lógica LED 1 ─────
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            hold_cnt1 <= 0;
            led_output_1      <= 1'b0;
        end else if (pir1) begin
            hold_cnt1 <= 0;
            led_output_1      <= 1'b1;
        end else if (hold_cnt1 < MAX_COUNT) begin
            hold_cnt1 <= hold_cnt1 + 1'b1;
            led_output_1      <= 1'b1;
        end else begin
            led_output_1 <= 1'b0;
        end
    end

    // ───── Lógica LED 2 ─────
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            hold_cnt2 <= 0;
            led_output_2      <= 1'b0;
        end else if (pir2) begin
            hold_cnt2 <= 0;
            led_output_2      <= 1'b1;
        end else if (hold_cnt2 < MAX_COUNT) begin
            hold_cnt2 <= hold_cnt2 + 1'b1;
            led_output_2      <= 1'b1;
        end else begin
            led_output_2 <= 1'b0;
        end
    end

endmodule
