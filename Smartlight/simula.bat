@echo off
echo === Compilando SmartAlarmSystem ===
iverilog -o sim smart_alarm_system.v tb_smart_alarm_system.v

if errorlevel 1 (
    echo ❌ Error en compilación
    pause
    exit /b
)

echo === Ejecutando simulación ===
vvp sim

echo === Abriendo GTKWave ===
start gtkwave smart_alarm_system.vcd

pause