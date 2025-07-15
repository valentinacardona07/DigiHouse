@echo off
echo === Eliminando archivo gigante .vcd del historial ===
git-filter-repo.exe --path emergency_system.vcd --invert-paths

echo === Ignorando .vcd para el futuro ===
echo *.vcd>>.gitignore
git add .gitignore
git commit -m "Ignorar .vcd y limpiar historial"

echo === Haciendo push forzado al repo ===
git push origin main --force

echo === Completado 🚀 ===
pause
