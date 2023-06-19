@echo off
color 02
echo.
echo BBBBB    A    CCCCC K     K  U    U PPPPP
echo B    B  A A  C      K   K    U    U P    P
echo BBBBB  AAAAA C      K K      U    U PPPPP
echo B    B A   A C      K   K    U    U P
echo BBBBB  A   A  CCCCC K     K   UUUU  P
echo.
echo FFFFF IIIII SSSSS IIIII  CCCCC  OOOOO
echo F       I   S       I   C     C O   O
echo FFFF    I   SSSSS   I   C     C O   O
echo F       I       S   I   C     C O   O
echo F     IIIII SSSSS IIIII  CCCCC  OOOOO
echo.
echo DDDD  EEEEE L       FFFFF IIIII L     EEEEE    SSSSS EEEEE RRRR   V   V EEEEE RRRR
echo D   D E     L       F       I   L     E        S     E     R   R  V   V E     R   R
echo D   D EEEE  L       FFFF    I   L     EEEE     SSSSS EEEE  RRRR   V   V EEEE  RRRR
echo D   D E     L       F       I   L     E            S E     R  R   V   V E     R  R
echo DDDD  EEEEE LLLLL   F     IIIII LLLLL EEEEE    SSSSS EEEEE R   R   VVV  EEEEE R   R
echo.
echo==================================================
echo Il processo di copia avra inizio fra 5 secondi...
timeout /t 1 /nobreak >nul
echo Il processo di copia avra inizio fra 4 secondi...
timeout /t 1 /nobreak >nul
echo Il processo di copia avra inizio fra 3 secondi...
timeout /t 1 /nobreak >nul
echo Il processo di copia avra inizio fra 2 secondi...
timeout /t 1 /nobreak >nul
echo Il processo di copia avra inizio fra 1 secondi...
timeout /t 1 /nobreak >nul
echo==================================================

echo . >> back-up_log.txt
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
    shutdown /s /t 20
)
