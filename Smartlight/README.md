# 🛡️ SmartAlarmSystem – Sistema de Alarma con Sensores PIR (Verilog)

Proyecto que implementa un sistema digital para monitorear movimiento mediante **dos sensores PIR**. Controla la activación de LEDs indicadores por 1 segundo tras la detección.

---

## 📁 Archivos

| Archivo                      | Descripción |
|------------------------------|-------------|
| `smart_alarm_system.v`       | Módulo principal (FSM doble) |
| `tb_smart_alarm_system.v`    | Testbench funcional |
| `simula.bat`                 | Script de simulación para Windows |
| `.gitignore`                 | Ignora archivos generados |
| `smart_alarm_system.vcd`     | Archivo de onda (simulación) |

---

## 🧪 Simulación

### Requisitos:

- Icarus Verilog
- GTKWave

### Instrucciones (terminal):

```bash
iverilog -o sim smart_alarm_system.v tb_smart_alarm_system.v
vvp sim
gtkwave smart_alarm_system.vcd

       +-----------+         pir_input = 1
       |  WAITING  |  ------------------------+
       +-----------+                         |
            |                                |
            | pir_input = 1                  |
            v                                |
       +-----------+         pir_input = 0   |
       | DETECTED  |  -------------------+   |
       +-----------+                    |   |
            |                           |   |
            | pir_input = 0            |    |
            v                          |    |
     +------------------+             |    |
     |  LED_ON_HOLD     |<------------+    |
     +------------------+                  |
            |                              |
            | counter == 0                |
            v                              |
       +-----------+ <---------------------+
       |  WAITING  |
       +-----------+

Estado	Significado
WAITING	Espera movimiento. LED apagado.
DETECTED	Movimiento detectado. LED se enciende e inicia contador.
LED_ON_HOLD	El LED permanece encendido por 1 segundo tras la detección.

Cada PIR (pir_input_1 y pir_input_2) tiene su propia FSM y control de LED.

HOLD_TIME = 50,000,000 ciclos → equivale a 1 segundo @ 50 MHz.

