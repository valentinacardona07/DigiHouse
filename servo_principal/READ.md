# 🔄 Servo Principal (2 Servomotores) – Sistema de control de presencia

Este módulo controla **dos servomotores** mediante sensores de presencia y genera señales PWM con tiempo de retardo de cierre tras 2.5 segundos de detección continua.

---

## 📦 Archivos

| Archivo                | Descripción |
|------------------------|-------------|
| `servo_principal.v`    | Módulo principal de dos servos |
| `tb_servo_principal.v` | Testbench funcional |
| `simula.bat`           | Script de simulación (Windows) |
| `.gitignore`           | Archivos ignorados |
| `servo_principal.vcd`  | Archivo de onda |

---

## ⚙️ Descripción

- **Servo 1**: se abre si no hay presencia (`presence_1 == 0`), y se cierra tras 2.5s de presencia.
- **Servo 2**: se cierra si hay presencia (`presence_2 == 1`), y se abre tras 2.5s sin presencia.
- PWM de 20ms de período (50Hz) usando reloj de 50MHz.

---

## 🧪 Simulación

### Requisitos

- Icarus Verilog
- GTKWave

### Ejecutar (en Windows):

```bat
simula.bat
