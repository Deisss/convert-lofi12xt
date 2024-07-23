@echo off
setlocal enabledelayedexpansion

set "input_folder="
set "output_folder="
set "sample_rate=24000"

:parse_args
if "%~1"=="" goto :start_conversion
if "%~1"=="-i" (set "input_folder=%~2" & shift & shift & goto :parse_args)
if "%~1"=="-o" (set "output_folder=%~2" & shift & shift & goto :parse_args)
if "%~1"=="-r" (set "sample_rate=%~2" & shift & shift & goto :parse_args)
shift
goto :parse_args

:start_conversion
if "%input_folder%"=="" (echo Input folder is required & exit /b 1)
if "%output_folder%"=="" (echo Output folder is required & exit /b 1)

rem Remove trailing slash if existing
if %input_folder:~-1%==\ set input_folder=%input_folder:~0,-1%
if %output_folder:~-1%==\ set output_folder=%output_folder:~0,-1%

rem Counting how many audio files there is
for /f "tokens=*" %%a in ('dir /b /s "%input_folder%\*.mp3" "%input_folder%\*.wav" "%input_folder%\*.flac" "%input_folder%\*.aac" "%input_folder%\*.ogg" "%input_folder%\*.aif"') do (
    set /a total_files+=1
)

rem Creating the initial root folder if needed
mkdir "!output_folder!" >nul 2>&1

set /a file_counter=0
for /r "%input_folder%" %%a in (*.mp3 *.wav *.flac *.aac *.ogg *.aif) do (
    set /a file_counter+=1

    rem Creating variables to know where we are
    set "relative_path=%%a"
    set "relative_path=!relative_path:%input_folder%\=!"

    rem Determine output format
    if /i "%%~xa"==".aif" (
        set "output_ext=.aif"
    ) else (
        set "output_ext=.wav"
    )

    rem Set output file path
    set "output_file=%output_folder%\!relative_path!"
    set "output_file=!output_file:~0,-4!!output_ext!"
    set "output_dir=!output_file!\..\"

    rem Generating the folder if needed
    mkdir "!output_dir!" >nul 2>&1

    rem Print progress on the same line
    echo Doing sample !file_counter!/%total_files%
    ffmpeg -i "%%a" -ac 1 -ar %sample_rate% -hide_banner -loglevel error "!output_file!" || echo Error processing "%%a"
)

endlocal
