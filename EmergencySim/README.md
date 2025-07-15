<<<<<<< HEAD
# 🚨 Proyecto: Emergency System en Verilog

Este proyecto implementa un sistema digital de emergencia, diseñado para activar alertas, luces, desbloqueo de puertas y llamada de auxilio, todo con protección por flanco y sensores.
=======
# 🔄 Proyecto: Control de Motor Paso a Paso en Verilog

Este proyecto implementa el control digital de un **motor paso a paso 28BYJ-48** utilizando un **driver ULN2003** y una secuencia **half-step de 8 pasos**.
>>>>>>> 4e0fb24 (primer archivo StepperControl)

---

## 📁 Archivos

<<<<<<< HEAD
| Archivo                    | Descripción |
|----------------------------|-------------|
| `Emergency_System.v`       | Módulo principal con FSM |
| `tb_Emergency_System.v`    | Testbench funcional |
| `simula.bat`               | Simulación automática para Windows |
| `.gitignore`               | Ignora archivos temporales |
| `docs/`                    | Capturas GTKWave (opcional) |
=======
| Archivo                   | Descripción |
|---------------------------|-------------|
| `StepperControl.v`        | Módulo principal del sistema |
| `tb_StepperControl.v`     | Testbench funcional para simulación |
| `simula.bat`              | Script de simulación para Windows |
| `.gitignore`              | Archivos ignorados |
| `docs/waveform.png`       | Captura de GTKWave (opcional) |
>>>>>>> 4e0fb24 (primer archivo StepperControl)

---

## ⚙️ Funcionalidad

<<<<<<< HEAD
El sistema responde a:

- Botón de pánico (`panic_btn`)
- Sensor de peligro (`danger_sense`)
- Reset (`reset`)
- Controla salidas:
  - `alarm`
  - `alert_light`
  - `door_unlock`
  - `call_help`

FSM con tres estados:

- `INACTIVE`
- `EMERGENCY`
- `POST_EMERGENCY`

---

## 💻 Simulación

### ✅ Requisitos:

- [Icarus Verilog](http://iverilog.icarus.com/)
- [GTKWave](http://gtkwave.sourceforge.net/)

### 🧪 Ejecutar en terminal:

```bash
iverilog -o sim Emergency_System.v tb_Emergency_System.v
vvp sim
gtkwave emergency_system.vcd
=======
- El motor avanza cuando:
  - `btn_Up = 0` (botón presionado)
  - `stop_Up = 1` (sin fin de carrera activado)
  
- El motor retrocede cuando:
  - `btn_Down = 0`
  - `stop_Down = 1`
  
- Cuando se alcanza un fin de carrera (`stop_Up = 0` o `stop_Down = 0`), el motor se bloquea en ese sentido.

- El sistema utiliza una **FSM implícita con índice de paso** para manejar la secuencia `step_out[3:0]` que controla el ULN2003.

---

## 🧪 Simulación

### ✅ Requisitos:

- Icarus Verilog
- GTKWave

### 🛠️ Comandos manuales:

```bash
iverilog -o sim StepperControl.v tb_StepperControl.v
vvp sim
gtkwave stepper_sim.vcd
>>>>>>> 4e0fb24 (primer archivo StepperControl)
