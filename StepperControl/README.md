
# 🔁 StepperControl – Control de Motor Paso a Paso con ULN2003 (Verilog)

Este módulo implementa el control de un motor **paso a paso** con secuencia *half-step* de 8 pasos, compatible con el driver **ULN2003A**. Se controla mediante botones para avanzar/retroceder y se protege con finales de carrera.

---

## 📁 Archivos

| Archivo                  | Descripción |
|--------------------------|-------------|
| `StepperControl.v`       | Módulo principal de control del motor paso a paso |
| `tb_StepperControl.v`    | Testbench para simulación funcional |
| `simula.bat`             | Script para simular en Windows |
| `.gitignore`             | Exclusión de archivos generados automáticamente |
| `stepper_sim.vcd`        | Archivo de onda generado para GTKWave |

---

## ⚙️ Descripción del sistema

- 🕹️ **Entradas:**
  - `btn_Up`: botón para avanzar el motor (activo en bajo)
  - `btn_Down`: botón para retroceder el motor (activo en bajo)
  - `stop_Up`: fin de carrera superior (bloquea avance)
  - `stop_Down`: fin de carrera inferior (bloquea retroceso)

- 🔁 **Salida:**
  - `step_out[3:0]`: señal de control de fases para el ULN2003A (IN1 a IN4)

- ⏱️ **Velocidad:**
  - Un paso cada 100,000 ciclos de reloj (2ms a 50MHz)

---

## 🧠 Lógica de funcionamiento

```verilog
if ((btn_Up == 0) && (stop_Up != 0))
    avanzar();
else if ((btn_Down == 0) && (stop_Down != 0))
    retroceder();
````

* La secuencia de paso es de tipo *half-step*, mejorando precisión y suavidad.
* Avanza o retrocede el motor según los botones, siempre que no se activen los finales de carrera.
* Cuando no se presionan botones o hay bloqueo, el motor permanece en su posición.

---

## 🔄 Diagrama de flujo simplificado

```
               +-------------+
               | Espera      |
               +-------------+
                  |     |
    btn_Up==0 && !stop_Up  btn_Down==0 && !stop_Down
         v                     v
  +-------------+     +---------------+
  | Avanzar paso|     | Retroceder paso|
  +-------------+     +---------------+
         \               /
          ---------------
                 |
                 v
            Actualizar salida
```

---

## 🧪 Simulación

### Requisitos:

* Icarus Verilog
* GTKWave

### Ejemplo de uso:

```bash
iverilog -o sim StepperControl.v tb_StepperControl.v
vvp sim
gtkwave stepper_sim.vcd
```
