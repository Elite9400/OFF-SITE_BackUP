@echo off
setlocal enabledelayedexpansion

color 02
echo.
<inserisci qui gli altri comandi di testo>
echo.
echo==================================================
echo Il processo di copia avrà inizio tra 5 secondi...
timeout /t 1 /nobreak >nul
<inserisci qui gli altri comandi di timeout>
echo==================================================
<inserisci qui le istruzioni per scrivere l'ora di avvio>
<inserisci qui i controlli sull'esistenza dei dischi>
echo==================================================
echo Avvio copia di back-up out-site.
echo==================================================
echo================================================== >> back-up_log.txt
echo COPIA DISCO - %date% >> back-up_log.txt
echo================================================== >> back-up_log.txt

if not exist K:\ (
	echo Errore: disco K: non trovato - %date% %time% >> back-up_log.txt
    echo Errore: disco K: non trovato.
	echo . >> back-up_log.txt
    pause
    exit /b
)
if not exist D:\ (
	echo Errore: disco D: non trovato - %date% %time% >> back-up_log.txt
    echo Errore: disco D: non trovato.
	echo . >> back-up_log.txt
    pause
    exit /b
)
echo==================================================
echo Avvio copia di back-up out-site.
echo==================================================
echo================================================== >> back-up_log.txt
echo ORARIO INIZIO COPIA: %date% %time% >> back-up_log.txt
echo================================================== >> back-up_log.txt
echo Copia in corso del disco K: nel disco D:...

REM Misura il tempo di completamento
set start_time=!time!

Xcopy K:\*.* D:\ /C /V /F /E /Y /I /J /Z 2>> back-up_log.txt
if errorlevel 1 (
    echo Errore durante la copia dei file.
	echo================================================== >> back-up_log.txt
	echo ERRORI DURANTE LA COPIA: %date% %time% >> back-up_log.txt
	echo================================================== >> back-up_log.txt
    pause
    exit /b
)

REM Misura il tempo di completamento
set end_time=!time!

echo==================================================
echo Copia completata.
echo==================================================
echo Il lavoro e' stato completato.

REM Calcola la durata della copia
set /a elapsed_time_hours=!end_time:~0,2!-!start_time:~0,2!
set /a elapsed_time_minutes=!end_time:~3,2!-!start_time:~3,2!
set /a elapsed_time_seconds=!end_time:~6,2!-!start_time:~6,2!

echo Durata della copia: !elapsed_time_hours!:!elapsed_time_minutes!:!elapsed_time_seconds!
echo================================================== >> back-up_log.txt
echo Durata della copia: !elapsed_time_hours!:!elapsed_time_minutes!:!elapsed_time_seconds! >> back-up_log.txt
echo================================================== >> back-up_log.txt

timeout /t 10 /nobreak >nul
if errorlevel 1 (
	echo================================================== >> back-up_log.txt
	echo ORARIO FINE COPIA: %date% %time% >> back-up_log.txt
	echo================================================== >> back-up_log.txt
    echo Spegnimento del computer in corso...
	echo . >> back-up_log.txt
   shutdown /s /f /t 600
)
