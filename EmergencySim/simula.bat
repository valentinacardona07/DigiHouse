```bat
@echo off
<<<<<<< HEAD
echo === Compilando Emergency_System ===
iverilog -o sim Emergency_System.v tb_Emergency_System.v
=======
echo === Compilando StepperControl ===
iverilog -o sim StepperControl.v tb_StepperControl.v
>>>>>>> 4e0fb24 (primer archivo StepperControl)

if errorlevel 1 (
    echo ❌ Error en compilación
    pause
    exit /b
)

echo === Ejecutando simulación ===
vvp sim

echo === Abriendo GTKWave ===
<<<<<<< HEAD
start gtkwave emergency_system.vcd
=======
start gtkwave stepper_sim.vcd
>>>>>>> 4e0fb24 (primer archivo StepperControl)

pause