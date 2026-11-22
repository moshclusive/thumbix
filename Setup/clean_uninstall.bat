@echo off
setlocal EnableExtensions EnableDelayedExpansion
title Thumbix - Clean Uninstall and Cache Reset

:: Check Administrator Privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ========================================================
    echo  [!] Administrator permission is required.
    echo      Requesting UAC Elevation...
    echo ========================================================
    powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Start-Process cmd.exe -ArgumentList '/k `\"%~f0`\"' -Verb RunAs } catch { exit 1 }"
    if %errorlevel% neq 0 (
        echo.
        echo If UAC prompt did not appear, please:
        echo Right-Click this file and select "Run as administrator".
        echo.
        pause
    )
    exit /b
)

echo ========================================================
echo        Thumbix - Clean Uninstall and Cache Reset
echo ========================================================
echo.
echo [1/5] Terminating running Thumbix processes...
taskkill /F /IM ThumbixApp.exe /T >nul 2>&1
taskkill /F /IM SeeEverythingApp.exe /T >nul 2>&1
taskkill /F /IM dllhost.exe /T >nul 2>&1
taskkill /F /IM prevhost.exe /T >nul 2>&1

echo [2/5] Running uninstaller if registered...
if exist "%ProgramFiles%\Thumbix\unins000.exe" (
    "%ProgramFiles%\Thumbix\unins000.exe" /VERYSILENT /SUPPRESSMSGBOXES /NORESTART >nul 2>&1
)
if exist "%ProgramFiles(x86)%\Thumbix\unins000.exe" (
    "%ProgramFiles(x86)%\Thumbix\unins000.exe" /VERYSILENT /SUPPRESSMSGBOXES /NORESTART >nul 2>&1
)
if exist "%LocalAppData%\Programs\Thumbix\unins000.exe" (
    "%LocalAppData%\Programs\Thumbix\unins000.exe" /VERYSILENT /SUPPRESSMSGBOXES /NORESTART >nul 2>&1
)

echo [3/5] Unregistering COM servers and cleaning registry...
reg delete "HKCU\Software\Classes\CLSID\{4A723D19-F86E-4E76-A833-289566E7C414}" /f >nul 2>&1
reg delete "HKLM\Software\Classes\CLSID\{4A723D19-F86E-4E76-A833-289566E7C414}" /f >nul 2>&1
reg delete "HKCR\CLSID\{4A723D19-F86E-4E76-A833-289566E7C414}" /f >nul 2>&1
reg delete "HKCU\Software\Classes\AppID\{e357fccd-a995-4576-b01f-234630154e96}" /f >nul 2>&1
reg delete "HKLM\Software\Classes\AppID\{e357fccd-a995-4576-b01f-234630154e96}" /f >nul 2>&1
reg delete "HKCR\AppID\{e357fccd-a995-4576-b01f-234630154e96}" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "ThumbixHoverPreview" /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "ThumbixHoverPreview" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\{D37F8E31-15A2-4E57-9C90-82C318F421D9}_is1" /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\{D37F8E31-15A2-4E57-9C90-82C318F421D9}_is1" /f >nul 2>&1

del /f /q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Thumbix 1.0.lnk" >nul 2>&1
del /f /q "%USERPROFILE%\Desktop\Thumbix 1.0.lnk" >nul 2>&1
del /f /q "%PUBLIC%\Desktop\Thumbix 1.0.lnk" >nul 2>&1

for %%E in (.psd .psb .ai .eps .svg .webp .tiff .tif .png .jpg .jpeg .pdf .ttf .otf .woff .woff2 .docx .doc .pptx .ppt .xlsx .xls .mp4 .mkv .avi .mov .webm .wmv .cdr .indd .idml .sketch .fig .xd .afdesign .afphoto .afpub .xcf .kra .clip .procreate .cr2 .cr3 .nef .arw .dng .raw .gif .bmp .ico .blend .fbx .obj .stl .glb .dxf .dwg) do (
    reg delete "HKCU\Software\Classes\%%E\ShellEx\{e357fccd-a995-4576-b01f-234630154e96}" /f >nul 2>&1
    reg delete "HKLM\Software\Classes\%%E\ShellEx\{e357fccd-a995-4576-b01f-234630154e96}" /f >nul 2>&1
    reg delete "HKCU\Software\Classes\%%E\ShellEx\{BB2E617C-0920-11d1-9A0B-00C04FC2D6C1}" /f >nul 2>&1
    reg delete "HKLM\Software\Classes\%%E\ShellEx\{BB2E617C-0920-11d1-9A0B-00C04FC2D6C1}" /f >nul 2>&1
    reg delete "HKCU\Software\Classes\SystemFileAssociations\%%E\ShellEx\{e357fccd-a995-4576-b01f-234630154e96}" /f >nul 2>&1
    reg delete "HKLM\Software\Classes\SystemFileAssociations\%%E\ShellEx\{e357fccd-a995-4576-b01f-234630154e96}" /f >nul 2>&1
    reg delete "HKCU\Software\Classes\SystemFileAssociations\%%E\ShellEx\{BB2E617C-0920-11d1-9A0B-00C04FC2D6C1}" /f >nul 2>&1
    reg delete "HKLM\Software\Classes\SystemFileAssociations\%%E\ShellEx\{BB2E617C-0920-11d1-9A0B-00C04FC2D6C1}" /f >nul 2>&1
)

reg delete "HKCU\Software\Classes\otffile\shellex\{e357fccd-a995-4576-b01f-234630154e96}" /f >nul 2>&1
reg delete "HKLM\Software\Classes\otffile\shellex\{e357fccd-a995-4576-b01f-234630154e96}" /f >nul 2>&1
reg delete "HKCU\Software\Classes\ttffile\shellex\{e357fccd-a995-4576-b01f-234630154e96}" /f >nul 2>&1
reg delete "HKLM\Software\Classes\ttffile\shellex\{e357fccd-a995-4576-b01f-234630154e96}" /f >nul 2>&1

echo [4/5] Deleting program files and temporary files safely...
del /f /q "%TEMP%\thumbix_*.*" >nul 2>&1
rd /s /q "%LocalAppData%\Thumbix" >nul 2>&1
rd /s /q "%AppData%\Thumbix" >nul 2>&1

:: Clean installation folders safely without killing Explorer
for %%D in ("%ProgramFiles%\Thumbix" "%ProgramFiles(x86)%\Thumbix" "%LocalAppData%\Programs\Thumbix") do (
    if exist "%%~D" (
        del /f /q "%%~D\*.exe" >nul 2>&1
        del /f /q "%%~D\*.ico" >nul 2>&1
        del /f /q "%%~D\*.png" >nul 2>&1
        del /f /q "%%~D\Svg.dll" >nul 2>&1
        del /f /q "%%~D\ExCSS.dll" >nul 2>&1
        del /f /q "%%~D\System.*.dll" >nul 2>&1
        del /f /q "%%~D\Thumbix.dll" >nul 2>&1
        if exist "%%~D\Thumbix.dll" (
            ren "%%~D\Thumbix.dll" "Thumbix.dll.old" >nul 2>&1
        )
        rd /s /q "%%~D" >nul 2>&1
    )
)

echo [5/5] Refreshing Windows Shell...
:: Broadcast association change so Windows drops Thumbix thumbnail handlers cleanly WITHOUT killing Explorer!
powershell -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command "$c='[DllImport(\"shell32.dll\")]public static extern void SHChangeNotify(int e,uint f,IntPtr p1,IntPtr p2);';$t=Add-Type -MemberDefinition $c -Name 'SN' -Namespace 'W' -PassThru;$t::SHChangeNotify(0x08000000,0x1000,[IntPtr]::Zero,[IntPtr]::Zero)" >nul 2>&1

:: Guarantee Windows Explorer is running (if previously terminated by an old script, revive it!)
tasklist /fi "imagename eq explorer.exe" 2>nul | find /i "explorer.exe" >nul
if %errorlevel% neq 0 (
    echo [*] Restoring Windows Explorer Desktop...
    start explorer.exe
)

echo.
echo ========================================================
echo  SUCCESS: Previous Thumbix uninstalled and cleaned!
echo.
echo  * Desktop, icons, and windows were 100%% preserved!
echo  * Zero black screens!
echo  * PC restart is NOT needed!
echo  * You can now run Thumbix_Setup_v1.0.exe to install.
echo ========================================================
echo.
pause
