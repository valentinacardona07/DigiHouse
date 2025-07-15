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

### Opciones:

🟢 Terminal:

```bash
iverilog -o sim smart_alarm_system.v tb_smart_alarm_system.v
vvp sim
gtkwave smart_alarm_system.vcd
