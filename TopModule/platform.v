module platform(
    input clk,                   // Reloj de 50 MHz
    input [1:0] switch_pos,      // Interruptor de 3 posiciones: 01 = subir, 10 = bajar
    input stop_Up,               // Final de carrera superior (activo en bajo)
    input stop_Down,             // Final de carrera inferior (activo en bajo)
    output reg [3:0] step_out    // Salidas para el ULN2003 (IN1 a IN4)
);

    parameter STEP_DELAY = 100_000; // Control de velocidad: 0.1 s por paso a 50 MHz

    reg [22:0] step_timer = 0;       // Contador de tiempo entre pasos
    reg [2:0] step_index = 0;        // Índice de paso actual

    // Secuencia de pasos (half-step: 8 pasos)
    reg [3:0] step_sequence [0:7];

    initial begin
        step_sequence[0] = 4'b1000; // IN4
        step_sequence[1] = 4'b1100; // IN4 + IN3
        step_sequence[2] = 4'b0100; // IN3
        step_sequence[3] = 4'b0110; // IN3 + IN2
        step_sequence[4] = 4'b0010; // IN2
        step_sequence[5] = 4'b0011; // IN2 + IN1
        step_sequence[6] = 4'b0001; // IN1
        step_sequence[7] = 4'b1001; // IN1 + IN4
    end

    always @(posedge clk) begin
        if (step_timer >= STEP_DELAY) begin
            step_timer <= 0;

            // Lógica del interruptor y finales de carrera
            case (switch_pos)
                2'b01: begin
                    if (stop_Up != 0) begin
                        // Avanzar
                        if (step_index < 7)
                            step_index <= step_index + 1;
                        else
                            step_index <= 0;
                    end
                end

                2'b10: begin
                    if (stop_Down != 0) begin
                        // Retroceder
                        if (step_index > 0)
                            step_index <= step_index - 1;
                        else
                            step_index <= 7;
                    end
                end

                default: begin
                    // switch_pos = 00 o 11 → No hacer nada
                    step_index <= step_index;
                end
            endcase
        end else begin
            step_timer <= step_timer + 1;
        end

        // Salida al ULN2003
        step_out <= step_sequence[step_index];
    end

endmodule


