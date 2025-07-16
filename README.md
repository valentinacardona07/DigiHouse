# 🏠 DigiHouse: Proyectos de Control Digital en Verilog

Bienvenido a **DigiHouse**, una colección de proyectos desarrollados en **Verilog HDL** para simular y controlar sistemas digitales aplicados al hogar inteligente.

Este repositorio contiene dos subproyectos independientes, cada uno con su propio módulo, testbench, documentación y simulación funcional:

---

## 🚨 [EmergencySim](./EmergencySim)

### Descripción:
Un sistema de emergencia digital basado en FSM que responde a:
- Botón de pánico
- Sensor de peligro
- Reset manual

### Salidas activadas:
- Zumbador (`alarm`)
- Luz de alerta (`alert_light`)
- Desbloqueo de puerta (`door_unlock`)
- Comunicación (`call_help`)

📁 Archivos clave:
- `Emergency_System.v`
- `tb_Emergency_System.v`
- `simula.bat` ← ejecuta simulación completa
- `README.md` ← documentación específica del proyecto

---

## 🔄 [StepperControl](./StepperControl)

### Descripción:
Controlador de motor paso a paso 28BYJ-48 utilizando secuencia **half-step** y driver ULN2003. Incluye protección por finales de carrera y control de botones.

🔧 Características:
- Avance con `btn_Up` y `stop_Up`
- Retroceso con `btn_Down` y `stop_Down`
- Control de velocidad con `STEP_DELAY`

📁 Archivos clave:
- `StepperControl.v`
- `tb_StepperControl.v`
- `simula.bat`
- `README.md`

---

## 💻 Requisitos generales

- [Icarus Verilog](http://iverilog.icarus.com/)
- [GTKWave](http://gtkwave.sourceforge.net/)

💡 Ambos subproyectos se pueden simular fácilmente desde terminal o haciendo doble clic en `simula.bat`.

---

## 📚 Licencia y Autoría

> Proyecto académico para la materia de Digital I por **Valentina Cardona, Daniel Ramírez y Samuel Miranda**  
> Universidad Nacional de Colombia Sede bogotá- Facultad de Ingeniería Electrónica – Colombia 🇨🇴  
> Licencia: MIT (libre para uso académico y profesional)


