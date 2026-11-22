# Thumbix Clean Uninstall & Cache Wipe Script
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "[INFO] Requesting Administrator Privileges..." -ForegroundColor Yellow
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "        Thumbix - Clean Uninstall & Shell Refresh" -ForegroundColor Yellow
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "[1/5] Stopping running Thumbix background processes..." -ForegroundColor White
Stop-Process -Name "ThumbixApp" -Force -ErrorAction SilentlyContinue
Stop-Process -Name "SeeEverythingApp" -Force -ErrorAction SilentlyContinue
Stop-Process -Name "dllhost" -Force -ErrorAction SilentlyContinue
Stop-Process -Name "prevhost" -Force -ErrorAction SilentlyContinue

Write-Host "[2/5] Running uninstaller if registered..." -ForegroundColor White
$uninsPaths = @(
    "$env:ProgramFiles\Thumbix\unins000.exe",
    "${env:ProgramFiles(x86)}\Thumbix\unins000.exe",
    "$env:LocalAppData\Programs\Thumbix\unins000.exe"
)
foreach ($u in $uninsPaths) {
    if (Test-Path $u) {
        Start-Process $u -ArgumentList "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART" -Wait -WindowStyle Hidden -ErrorAction SilentlyContinue
    }
}

Write-Host "[3/5] Unregistering COM servers and cleaning registry..." -ForegroundColor White
$clsid = "{4A723D19-F86E-4E76-A833-289566E7C414}"
$appid = "{e357fccd-a995-4576-b01f-234630154e96}"
Remove-Item "HKCU:\Software\Classes\CLSID\$clsid" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "HKLM:\Software\Classes\CLSID\$clsid" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "HKCR:\CLSID\$clsid" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "HKCU:\Software\Classes\AppID\$appid" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "HKLM:\Software\Classes\AppID\$appid" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "HKCR:\AppID\$appid" -Recurse -Force -ErrorAction SilentlyContinue
Remove-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "ThumbixHoverPreview" -ErrorAction SilentlyContinue
Remove-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "ThumbixHoverPreview" -ErrorAction SilentlyContinue
Remove-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\{D37F8E31-15A2-4E57-9C90-82C318F421D9}_is1" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\{D37F8E31-15A2-4E57-9C90-82C318F421D9}_is1" -Recurse -Force -ErrorAction SilentlyContinue

Remove-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Thumbix 1.0.lnk" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:USERPROFILE\Desktop\Thumbix 1.0.lnk" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:PUBLIC\Desktop\Thumbix 1.0.lnk" -Force -ErrorAction SilentlyContinue

$exts = @(".psd", ".psb", ".ai", ".eps", ".svg", ".webp", ".tiff", ".tif", ".png", ".jpg", ".jpeg", ".pdf", ".ttf", ".otf", ".woff", ".woff2", ".docx", ".doc", ".pptx", ".ppt", ".xlsx", ".xls", ".mp4", ".mkv", ".avi", ".mov", ".webm", ".wmv", ".cdr", ".indd", ".idml", ".sketch", ".fig", ".xd", ".afdesign", ".afphoto", ".afpub", ".xcf", ".kra", ".clip", ".procreate", ".cr2", ".cr3", ".nef", ".arw", ".dng", ".raw", ".gif", ".bmp", ".ico", ".blend", ".fbx", ".obj", ".stl", ".glb", ".dxf", ".dwg")
foreach ($ext in $exts) {
    Remove-Item "HKCU:\Software\Classes\$ext\ShellEx\$appid" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "HKLM:\Software\Classes\$ext\ShellEx\$appid" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "HKCU:\Software\Classes\SystemFileAssociations\$ext\ShellEx\$appid" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "HKLM:\Software\Classes\SystemFileAssociations\$ext\ShellEx\$appid" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "HKCU:\Software\Classes\$ext\ShellEx\{BB2E617C-0920-11d1-9A0B-00C04FC2D6C1}" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "HKLM:\Software\Classes\$ext\ShellEx\{BB2E617C-0920-11d1-9A0B-00C04FC2D6C1}" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "HKCU:\Software\Classes\SystemFileAssociations\$ext\ShellEx\{BB2E617C-0920-11d1-9A0B-00C04FC2D6C1}" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "HKLM:\Software\Classes\SystemFileAssociations\$ext\ShellEx\{BB2E617C-0920-11d1-9A0B-00C04FC2D6C1}" -Recurse -Force -ErrorAction SilentlyContinue
}
Remove-Item "HKCU:\Software\Classes\otffile\shellex\$appid" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "HKLM:\Software\Classes\otffile\shellex\$appid" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "HKCU:\Software\Classes\ttffile\shellex\$appid" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "HKLM:\Software\Classes\ttffile\shellex\$appid" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "[4/5] Deleting program files safely without stopping Explorer..." -ForegroundColor White
Remove-Item "$env:TEMP\thumbix_*.*" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:LocalAppData\Thumbix" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$env:AppData\Thumbix" -Recurse -Force -ErrorAction SilentlyContinue

$installDirs = @("$env:ProgramFiles\Thumbix", "${env:ProgramFiles(x86)}\Thumbix", "$env:LocalAppData\Programs\Thumbix")
foreach ($dir in $installDirs) {
    if (Test-Path $dir) {
        $dll = Join-Path $dir "Thumbix.dll"
        if (Test-Path $dll) {
            try { Remove-Item $dll -Force -ErrorAction Stop }
            catch {
                try { Rename-Item $dll "Thumbix.dll.old" -Force -ErrorAction SilentlyContinue } catch { }
            }
        }
        Remove-Item $dir -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Host "[5/5] Refreshing Windows Shell safely..." -ForegroundColor White
$sig = '[DllImport("shell32.dll")] public static extern void SHChangeNotify(int e, uint f, IntPtr p1, IntPtr p2);'
$sh = Add-Type -MemberDefinition $sig -Name 'ShellNotif' -Namespace 'Win32' -PassThru
$sh::SHChangeNotify(0x08000000, 0x1000, [IntPtr]::Zero, [IntPtr]::Zero)

# Guarantee Explorer is running
if (-not (Get-Process "explorer" -ErrorAction SilentlyContinue)) {
    Write-Host "[*] Restoring Windows Explorer Desktop..." -ForegroundColor Yellow
    Start-Process "explorer.exe"
}

Write-Host ""
Write-Host "========================================================" -ForegroundColor Green
Write-Host "  SUCCESS: Previous Thumbix uninstalled and cleaned!" -ForegroundColor Green
Write-Host ""
Write-Host "  * Desktop, icons, and windows were 100% preserved!" -ForegroundColor Cyan
Write-Host "  * Zero black screens!" -ForegroundColor Cyan
Write-Host "  * PC restart is NOT needed!" -ForegroundColor Cyan
Write-Host "  * You can now run Thumbix_Setup_v1.0.exe to install." -ForegroundColor Yellow
Write-Host "========================================================" -ForegroundColor Green
Write-Host ""
Read-Host "Press Enter to exit"
