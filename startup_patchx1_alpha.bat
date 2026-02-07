@echo off
:: Configurable setting that will be applied permanently!
:: It's strongly recommended to not change any value you don't know!
:: You should ignore it if you don't know what are you doing!
:: Leave blank for default configuration.
:: Don't include executable in PATH!
:: Your yt-dlp executable must be named yt-dlp.exe!
:: Your ffmpeg file should also named ffmpeg.exe to prevent checking failure.
:: Or you can set override_ffmpeg_check to 1 to skip ffmpeg checking(not recommended)
:: NOTE!: override_ffmpeg_check is only applied to PATH configuration setting! If the value is set to 1, you must specify the ffmpeg file in the PATH configuration because...
:: the program won't automatically detect and load ffmpeg since it can't tell if ffmpeg really exists because the check is skipped.
:: This configuration will only be used if the program failed to detect and/or load the executable.
:: The path don't need to be warped in quotation mark because it's atomatically handled.
set ydurl=
set ytdp=
set ffmPath=C:\Users\giahu\Downloads\Compressed\ffmpeg-master-latest-win64-gpl\bin
set ytdlPath=
set override_ffmpeg_check=0

@echo off
setlocal
setlocal enabledelayedexpansion
if "%LEGACY_MODE%"=="1" goto ok
set LEGACY_MODE=1
start "" conhost.exe "%~f0"
exit /b

:ok
title yt-dlp (pre-intialize...)
echo Intializing...
chcp 65001 1>nul 2>nul
call :trcai
mode con: lines=30 cols=121
cd %~dp0
cls
title yt-dlp (intialize...)
if exist "yt-dlp.exe" goto pok
if "%ytdlPath%" neq "" goto chkPath
:chpt
cls
title yt-dlp (^^!)
echo Look like yt-dlp is missing^^!
echo Please make sure there are yt-dlp executable named "yt-dlp.exe" and is the same directory at this application^^!
echo Would you like to download it now?
echo Or you can specify a path to your yt-dlp executable
echo You can enter the path in ytdlPath by editing this file to make it permanent^^!
echo 1: Download
echo 2: Specify path
echo 3: Exit
choice /c 123 /n /m "Your choice:"
if %errorlevel% == 1 goto download
if %errorlevel% == 2 goto spec
exit

:chkPath
if exist "%ytdlPath%\yt-dlp.exe" (cd "%ytdlPath%" & goto okpt2)
cls
title yt-dlp (^^!)
echo ERROR: Failed to find yt-dlp with your configuration^^! Please check it and make sure it's correct^^!
echo Possible fix:
echo Make sure this application has sufficent permission
echo Make sure the file permission is correctly configurated
echo If you use advanced option, please make sure the link and target path is correct
echo Avoid using special character name if possible
echo This configuration will be ignored^^!
echo Press any key to continue.
pause 1>nul 2>nul
goto chpt
exit

:spec
cls
title yt-dlp (\)
echo Specify the path to yt-dlp executable.
echo This will only work temporarily^^!
echo It mean that you will need to enter your yt-dlp path again each time you relaunch.
echo To make it apply automatically, please enter your yt-dlp path in ytdlPath value by editing this file.
echo Don't include the executable in the path^^!
echo Don't warp the path with quotation mark because it's automatically handled, doing so may cause problem^^!
set /p ydpep= yt-dlp Path:
if exist "%ydpep%\yt-dlp.exe" (cd "%ydpep%" & goto okpt2)
cls
title yt-dlp (/^^!\)
echo Error: Failed to find yt-dlp with your specified PATH^^!
echo Please make sure the Path you specified is correct^^!
echo Possible fix:
echo Make sure this application has sufficent permission
echo Make sure the file permission is correctly configurated
echo If you use advanced option, please make sure the link and target path is correct
echo Avoid using special character name if possible
echo 1: Retry
echo 2: Go back
choice /c 12 /n /m "Your choice:"
if %errorlevel% == 1 goto spec
if %errorlevel% == 2 goto ok
exit

:download
if "%defaultyd%" == 1 (set ydurl=&set defaultyd=0)
if "%defaultpt%" == 1 (set ytdp=&set defaultpt=0)
cls
title yt-dlp (.)
echo Setup yt-dlp
echo This will help you download yt-dlp
echo Press 1 to start.
echo Press 2 for advanced settings.
echo Press 3 to cancel
choice /c 123 /n /m "Your choice:"
if %errorlevel% == 1 goto setup
if %errorlevel% == 2 goto advc
if %errorlevel% == 3 goto ok
exit

:setup
cls
title yt-dlp (setup)
echo Downloading... Please wait^^!
if "%ydurl%" == "" (set ydurl=https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe&set defaultyd=1)
if "%ytdp%" == "" (set ytdp=%~dp0\yt-dlp.exe&set defaultpt=1)
bitsadmin /transfer "ytdlpdownloader%random%" /download /priority FOREGROUND "%ydurl%" "%ytdp%"
if %errorlevel% neq 0 goto error
title yt-dlp (finish)
echo setting up done^^!
echo press any key to go back^^!
pause 1>nul 2>nul
goto ok

:error
cls
title yt-dlp (/^^!\)
echo Error: Failed to download yt-dlp
echo Possible fix:
echo Please check your internet connection^^!
echo Make sure this application has sufficient permission
echo Make sure the file permission is correctly configured
echo If you use advanced option, please make sure the link and target path are correct^!
echo Avoid using special character names if possible
echo Do you want to retry?
echo 1: Retry
echo 2: Go back
choice /c 12 /n /m "Your choice:"
if %errorlevel% == 1 goto setup
if %errorlevel% == 2 goto download
exit

:advc
cls
title yt-dlp (*)
echo Set up configuration:
if "%ydurl%" == "" (echo: Download URL: Default - https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe) ELSE (echo: Download URL: %ydurl%)
if "%ytdp%" == "" (echo: Target PATH: Default - %~dp0\yt-dlp.exe) ELSE (echo: Target PATH: %ytdp%)
echo.
echo -----------------------------------------------------------------------------------------------------------------------
echo Option:
echo 1: Change Download URL
echo 2: Change Target PATH
echo 3: Go back
choice /c 123 /n /m "Your choice:"
if %errorlevel% == 1 goto chgurl
if %errorlevel% == 2 goto chgpath
if %errorlevel% == 3 goto download
exit

:chgurl
cls
title yt-dlp (configuration...)
if "%ydurl%" == "" (echo: Current download URL: Default - https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe) ELSE (echo: Current download URL: %ydurl%)
echo If you want to set it back to default configuration, leave it blank.
set tydurl=
set /p tydurl= Your Download URL:
cls
title yt-dlp (configuration)
echo Is this URL correct?
if "%tydurl%" == "" (echo: New download URL: Default - https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe) ELSE (echo: New download URL: %tydurl%)
echo Y: Yes, finish.
echo N: No, change it.
echo C: Discard and cancel.
choice /c YNC /n /m "Your choice:"
if %errorlevel% == 1 (set ydurl=%tydurl%&goto advc)
if %errorlevel% == 2 goto chgurl
if %errorlevel% == 3 goto advc
exit

:chgpath
cls
title yt-dlp (configuration...)
if "%ytdp%" == "" (echo: Current target PATH: Default - %~dp0\yt-dlp.exe) ELSE (echo: Current target PATH: %ytdp%)
echo If you want to set it back to default configuration, leave it blank.
set tytdp=
set /p tytdp= Your target PATH:
cls
title yt-dlp (configuration)
echo Is this PATH correct?
if "%tytdp%" == "" (echo: New target PATH: Default - %~dp0\yt-dlp.exe) ELSE (echo: New target PATH: %tytdp%)
echo Y: Yes, finish.
echo N: No, change it.
echo C: Discard and cancel.
choice /c YNC /n /m "Your choice:"
if %errorlevel% == 1 (set ytdp=%tytdp%&goto advc)
if %errorlevel% == 2 goto chgurl
if %errorlevel% == 3 goto advc
exit

:pok
cls
cd %~dp0
:okpt2
title yt-dlp (checking version)
echo Checking yt-dlp version... Please wait^^!
yt-dlp.exe --version
title yt-dlp (checking update)
echo Checking for yt-dlp update... Please wait^^!
yt-dlp.exe --update
title yt-dlp (ffmpeg)
echo Checking ffmpeg...
goto ffmpegchk
:postchk
echo ok
:reload
set url=
cls
title yt-dlp
if "%ffnot%" == "1" echo Notice: Ffmpeg not found^^! Please type _ffmpeg for more info^^!
echo Enter video url you want to download^^!
set /p url= Your URL:
if "%url%" == "" goto reload
set "surl=%url:!=^^^!%"
set "surl=!surl:>=^>!"
set "surl=!surl:<=^<!"
set "surl=!surl:|=^|!"
set "surl=!surl:&=^&!"
if "!surl:~0,1!"=="_" goto command
title yt-dlp (working)
echo Downloading...
if "%ffnot%" == "1" (yt-dlp "%url%") ELSE (yt-dlp --ffmpeg-location "%YffmPath%" "%url%")
title yt-dlp (done)
echo Finished^^!
echo.
echo ========================================================================================================================
echo.
echo Do you want to download another video?
echo Y: Yes
echo N: No
choice /c YN /n /m "Your choice:"
if %errorlevel% == 1 goto reload
endlocal
exit

:ffmpegchk
cls
if "%override_ffmpeg_check%" == "1" goto ffpach
if exist "ffmpeg.exe" (set YffmPath=%~dp0&goto postchk)
if exist "%ffmPath%\ffmpeg.exe" (set YffmPath=%ffmPath%&goto postchk)
if exist "%ytdlPath%\ffmpeg.exe" (set YffmPath=%ytdlPath%&goto postchk)
set ffnot=1
if "%ffmPath%" == "" goto postchk
cls
title yt-dlp (^^!)
echo ERROR: Failed to find ffmpeg with your configuration^^! Please check it and make sure it's correct^^!
echo Possible fix:
echo Make sure this application has sufficient permission
echo Make sure the file permission is correctly configured
echo If you use advanced option, please make sure the link and target path is correct
echo Avoid using special character name if possible
echo This configuration will be ignored^^!
echo press any key to continue.
pause 1>nul 2>nul
goto postchk
exit

:ffpach
if "%ffmPath%" neq "" goto sfpach
cls
title yt-dlp (/^^!\)
echo ERROR^^!: The flag "override_ffmpeg_check" is currently enabled but the path is not provided^^!
set ffnot=1
echo Please check your configuration again and make sure the Path is specified or disable override_ffmpeg_check^^!
echo Ffmpeg will be ignored due to invalid configuration^^!
echo Press any key to continue.
pause 1>nul 2>nul
goto postchk
exit

:sfpach
if exist "%ffmPath%" goto postchk
cls
title yt-dlp (/^^!\)
echo ERROR^^!: Your configuration lead to an invalid or inaccessible path^^!
set ffnot=1
echo Please check your configuration again and make sure the specified Path is correct^^!
echo Ffmpeg will be ignored due to invalid configuration^^!
echo Press any key to continue.
pause 1>nul 2>nul
goto postchk
exit

:command
cls
set FurlFc=%url:_=%
if /i "%FurlFc%" == "ffmpeg" goto ffmpeg
if /i "%FurlFc%" == "info" goto info
if /i "%FurlFc%" == "help" goto help
if /i "%FurlFc%" == "about" goto abot
if /i "%FurlFc%" == "settings" goto settings
if /i "%FurlFc%" == "lang" goto lang
if /i "%FurlFc%" == "exit" goto exit
if /i "%FurlFc%" == "docs" goto docs
if /i "%FurlFc%" == "changelog" goto chglg
if /i "%FurlFc%" == "version" goto ver
cls
title yt-dlp (/^^\)
echo Invalid/Unknow command^^!
echo Type _help for help.
echo Press any key to continue.
pause 1>nul 2>nul
goto reload
exit

:ver
cls
title yt-dlp (i)
echo yt-dlp console (this program): Version alpha internal 021225
echo Checking for yt-dlp version... Please be patience^^!
yt-dlp.exe --version
echo Press any key to go back
pause 1>nul 2>nul
goto reload


:exit
exit

:ffmpeg
cls
title yt-dlp (you found a secret... press any key to continue)
echo Ffmpeg center section.
echo Coming soon^^!
echo We are working on this^^!
echo There will be something here in the future^^!
echo stay still^^!
pause 1>nul 2>nul
goto ffmpegn
goto reload
exit

:ffmpegn
title yt-dlp (ffmpeg)
if "%ffnot%" == "1" (goto ffmpeg1) ELSE (goto ffmpeg2)

:ffmpeg1
title yt-dlp (ffmpeg information)
cls
echo About: ffmpeg is a powerful, robust and open-source application that can process multimedia file.
echo Why?: ffmpeg is an essential program that can work with yt-dlp to make it even more powerful
echo What will it do?: yt-dlp will use ffmpeg to process videos data and encoding, which will help yt-dlp choose the
echo best video format for you.
echo Additional information: ffmpeg also come with ffprobe and ffplay, which is also a part of ffmpeg project, both ffmpeg and
echo ffprobe is needed for yt-dlp.
echo -Currently, ffmpeg is not set up yet, if you want to use ffmpeg functionality, you can download it from ffmpeg website
echo -If you already have ffmpeg installed and extracted in your computer, make sure that the executable is placed with the
echo  same directory of this file.
echo -If you don't want to put ffmpeg with this file, you can enter the path to ffmpeg executable by changing the ffmPath
echo  value in this file to make it permanent.
echo -Or you can also enter the path temporary here, note that it won't be permanent if you choose this option, that mean you 
echo  will need to enter ffmpeg path everytime you launch.
echo -Unlike yt-dlp, ffmpeg require more complicated process to set-up automatically, but I am working on it, It seem to be 
echo  possible, but more difficult than yt-dlp.
echo -This application is currently in beta-alpha stage that still need ton of improvment and stuffs, so it is currently
echo  private and not available for public, if you can somehow see and read this message, then you must be someone special
echo  who has early access
echo -This application still need ton of cooking and coding, which will be a very tough time and I might abandon it.
echo  But I hope I won't.
echo -I have had a tough time making this, also lacks of time life and many other things that is preventing me from doing it
echo  but I will try my best.
echo -Enough talking around, see ya^^! Actually this won't be seen by anyone btw...
pause
goto reload

:ffmpeg2
title yt-dlp (ffmpeg)
cls
echo Nothing to see here, still working on this, something will be here soon.
echo -^>
pause 1>nul 2>nul
cls
call :timeam 1
<NUL set /p=.
call :timeam 1
<NUL set /p=.
call :timeam 1
<NUL set /p=.
call :timeam 1
if %errorlevel% neq 0 (call :timeam 3)
call :timeam 1
echo.
echo -^>
pause 1>nul 2>nul
cls
call :timeam 1
<NUL set /p=.
call :timeam 1
<NUL set /p=.
call :timeam 1
<NUL set /p=.
call :timeam 1
<NUL set /p=.
call :timeam 1
<NUL set /p=.
call :timeam 1
if %errorlevel% neq 0 (call :timeam 5)
call :timeam 1
echo.
echo -^>
pause 1>nul 2>nul
cls
call :timeam 1
<NUL set /p=.
call :timeam 1
<NUL set /p=.
call :timeam 1
<NUL set /p=.
call :timeam 1
<NUL set /p=.
call :timeam 1
<NUL set /p=.
call :timeam 1
<NUL set /p=.
call :timeam 1
<NUL set /p=.
call :timeam 1
<NUL set /p=.
call :timeam 1
<NUL set /p=.
call :timeam 1
<NUL set /p=.
call :timeam 1
if %errorlevel% neq 0 (call :timeam 10)
call :timeam 1
echo.
echo -^>
pause 1>nul 2>nul
cls
echo ....Do you want to see information about ffmpeg and note from me?
pause 1>nul 2>nul
echo No option for you then...
echo I will show it btw..
pause 1>nul 2>nul
goto ffmpeg1
exit


:info
cls
title yt-dlp (you found a secret... press any key to continue)
echo Information section.
echo Coming soon^^!
echo We are working on this^^!
echo There will be something here in the future^^!
echo stay still^^!
pause 1>nul 2>nul
goto reload
exit

:help
cls
title yt-dlp (you found a secret... press any key to continue)
echo Help section.
echo Coming soon^^!
echo We are working on this^^!
echo There will be something here in the future^^!
echo stay still^^!
pause 1>nul 2>nul
goto reload
exit

:abot
cls
title yt-dlp (you found a secret... press any key to continue)
echo About section.
echo Coming soon^^!
echo We are working on this^^!
echo There will be something here in the future^^!
echo stay still^^!
pause 1>nul 2>nul
goto reload
exit

:settings
cls
title yt-dlp (you found a secret... press any key to continue)
echo Settings section.
echo Coming soon^^!
echo We are working on this^^!
echo There will be something here in the future^^!
echo stay still^^!
pause 1>nul 2>nul
goto reload
exit

:lang
cls
title yt-dlp (you found a secret... press any key to continue)
echo Language setting section.
echo Coming soon^^!
echo We are working on this^^!
echo There will be something here in the future^^!
echo stay still^^!
pause 1>nul 2>nul
goto reload
exit

:exit
cls
goto exit

:docs
cls
title yt-dlp (you found a secret... press any key to continue)
echo Documentation section.
echo Coming soon^^!
echo We are working on this^^!
echo There will be something here in the future^^!
echo stay still^^!
pause 1>nul 2>nul
goto reload
exit

:chglg
cls
title yt-dlp (you found a secret... press any key to continue)
echo Changelogs section.
echo Coming soon^^!
echo We are working on this^^!
echo There will be something here in the future^^!
echo stay still^^!
pause 1>nul 2>nul
goto reload
exit

:trca %1=Color %2=Str [%3=/n]
setlocal enableDelayedExpansion
set "str=%~2"
:trca2
:# Replace path separators in the string, so that the final path still refers to the current path.
set "str=a%ECHO.DEL%!str:\=a%ECHO.DEL%\..\%ECHO.DEL%%ECHO.DEL%%ECHO.DEL%!"
set "str=!str:/=a%ECHO.DEL%/..\%ECHO.DEL%%ECHO.DEL%%ECHO.DEL%!"
set "str=!str:"=\"!"
:# Go to the script directory and search for the trailing -
pushd "%ECHO.DIR%"
findstr /p /r /a:%~1 "^^-" "!str!\..\!ECHO.FILE!" nul
popd
:# Remove the name of this script from the output. (Dependant on its length.)
for /l %%n in (1,1,12) do if not "!ECHO.FILE:~%%n!"=="" <nul set /p "=%ECHO.DEL%"
:# Remove the other unwanted characters "\..\: -"
<nul set /p "=%ECHO.DEL%%ECHO.DEL%%ECHO.DEL%%ECHO.DEL%%ECHO.DEL%%ECHO.DEL%%ECHO.DEL%"
:# Append the optional CRLF
if not "%~3"=="" echo.
endlocal & goto :eof

:trcav %1=Color %2=StrVar [%3=/n]
if not defined %~2 goto :eof
setlocal enableDelayedExpansion
set "str=!%~2!"
goto :trca2

:trcai
set "ECHO.COLOR=call :trca"
set "ECHO.DIR=%~dp0"
set "ECHO.FILE=%~nx0"
set "ECHO.FULL=%ECHO.DIR%%ECHO.FILE%"
:# Use prompt to store a backspace into a variable. (Actually backspace+space+backspace)
for /F "tokens=1 delims=#" %%a in ('"prompt #$H# & echo on & for %%b in (1) do rem"') do set "ECHO.DEL=%%a"
goto :eof


:trea
:: v23c
:: Arguments: hexColor text [\n] ...
:: \n -> newline ... -> repeat
:: Supported in windows XP, 7, 8.
:: This version works using Cmd /U
:: In XP extended ascii characters are printed as dots.
:: For print quotes, use empty text.
SetLocal EnableExtensions EnableDelayedExpansion
Subst `: "!Temp!" >Nul &`: &Cd \
SetLocal DisableDelayedExpansion
Echo(|(Pause >Nul &Findstr "^" >`)
Cmd /A /D /C Set /P "=." >>` <Nul
For /F %%# In (
'"Prompt $H &For %%_ In (_) Do Rem"') Do (
Cmd /A /D /C Set /P "=%%# %%#" <Nul >`.1
Copy /Y `.1 /B + `.1 /B + `.1 /B `.3 /B >Nul
Copy /Y `.1 /B + `.1 /B + `.3 /B `.5 /B >Nul
Copy /Y `.1 /B + `.1 /B + `.5 /B `.7 /B >Nul
)
:__trea
Set "Text=%~2"
If Not Defined Text (Set Text=^")
SetLocal EnableDelayedExpansion
For %%_ In ("&" "|" ">" "<"
) Do Set "Text=!Text:%%~_=^%%~_!"
Set /P "LF=" <` &Set "LF=!LF:~0,1!"
For %%# in ("!LF!") Do For %%_ In (
\ / :) Do Set "Text=!Text:%%_=%%~#%%_%%~#!"
For /F delims^=^ eol^= %%# in ("!Text!") Do (
If #==#! EndLocal
If \==%%# (Findstr /A:%~1 . \` Nul
Type `.3) Else If /==%%# (Findstr /A:%~1 . /.\` Nul
Type `.5) Else (Cmd /A /D /C Echo %%#\..\`>`.dat
Findstr /F:`.dat /A:%~1 .
Type `.7))
If "\n"=="%~3" (Shift
Echo()
Shift
Shift
If ""=="%~1" Del ` `.1 `.3 `.5 `.7 `.dat &Goto :Eof
Goto :__trea



:timeam

if "%~1" == "" (set timeam=0) ELSE (set timeam=%~1)
timeout /t %timeam% /nobreak 1>nul 2>nul
if "%~2" NEQ "" (<NUL set /p=.)
exit /b


exit
exit
exit
:# The following line must be last and not end by a CRLF.
-

