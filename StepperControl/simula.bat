@echo off
echo === Compilando StepperControl ===
iverilog -o sim StepperControl.v tb_StepperControl.v

if errorlevel 1 (
    echo ❌ Error en compilación
    pause
    exit /b
)

echo === Ejecutando simulación ===
vvp sim

echo === Abriendo GTKWave ===
start gtkwave stepper_sim.vcd

pause
