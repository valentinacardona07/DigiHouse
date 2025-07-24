@echo off
echo === Simulación servo_principal ===
iverilog -o sim.out servo_principal.v tb_servo_principal.v
vvp sim.out
gtkwave servo_principal.vcd
pause
