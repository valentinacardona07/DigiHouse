module SmartAlarmSystem (
    input wire clk,
    input wire reset_n,

    input wire pir_input_1,
    input wire pir_input_2,

    output reg led_output_1,
    output reg led_output_2
);

parameter integer HOLD_TIME = 50_000_000; // 1 segundo a 50 MHz

// Estados con nombres intuitivos
parameter WAITING     = 2'b00;
parameter DETECTED    = 2'b01;
parameter LED_ON_HOLD = 2'b10;

// PIR 1
reg [1:0] state_1;
reg [25:0] counter_1;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        state_1 <= WAITING;
        counter_1 <= 0;
        led_output_1 <= 0;
    end else begin
        case (state_1)
            WAITING: begin
                if (pir_input_1) begin
                    state_1 <= DETECTED;
                    led_output_1 <= 1;
                    counter_1 <= HOLD_TIME;
                end
            end
            DETECTED: begin
                if (!pir_input_1) begin
                    state_1 <= LED_ON_HOLD;
                end
            end
            LED_ON_HOLD: begin
                if (counter_1 > 0)
                    counter_1 <= counter_1 - 1;
                else begin
                    state_1 <= WAITING;
                    led_output_1 <= 0;
                end
            end
        endcase
    end
end

// PIR 2
reg [1:0] state_2;
reg [25:0] counter_2;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        state_2 <= WAITING;
        counter_2 <= 0;
        led_output_2 <= 0;
    end else begin
        case (state_2)
            WAITING: begin
                if (pir_input_2) begin
                    state_2 <= DETECTED;
                    led_output_2 <= 1;
                    counter_2 <= HOLD_TIME;
                end
            end
            DETECTED: begin
                if (!pir_input_2) begin
                    state_2 <= LED_ON_HOLD;
                end
            end
            LED_ON_HOLD: begin
                if (counter_2 > 0)
                    counter_2 <= counter_2 - 1;
                else begin
                    state_2 <= WAITING;
                    led_output_2 <= 0;
                end
            end
        endcase
    end
end

endmodule