# 🔄 StepperControl – Controlador de Motor Paso a Paso (Verilog)

Este proyecto implementa el control de un motor paso a paso **28BYJ-48** usando un driver **ULN2003**, con lógica FSM y protección por finales de carrera.

---

## 📁 Archivos

| Archivo                   | Descripción |
|---------------------------|-------------|
| `StepperControl.v`        | Módulo principal |
| `tb_StepperControl.v`     | Testbench funcional |
| `simula.bat`              | Script para compilar y simular |
| `.gitignore`              | Exclusiones para el repo |

---

## ⚙️ Funcionamiento

- El motor avanza si:
  - `btn_Up = 0`
  - `stop_Up = 1`

- El motor retrocede si:
  - `btn_Down = 0`
  - `stop_Down = 1`

- FSM con `step_index` y temporizador `STEP_DELAY` para controlar velocidad
- Salida `step_out[3:0]` envía la secuencia al ULN2003

---

## 🧪 Simulación

### Requisitos:

- Icarus Verilog
- GTKWave

🖥️ Terminal:

```bash
iverilog -o sim StepperControl.v tb_StepperControl.v
vvp sim
gtkwave stepper_sim.vcd
