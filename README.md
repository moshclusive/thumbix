# Thumbix

<p align="center"><img src="assets/Thumbix-logo.png" alt="Thumbix logo" width="320"></p>

> Windows Explorer thumbnails and live hover previews for design files. See PSD, AI, EPS, SVG and font files right in Explorer, without opening Photoshop or Illustrator.

## What Thumbix Does

Thumbix is a Windows thumbnail provider and hover preview engine for designers. It does two things:

1. **Native Explorer thumbnails.** Windows File Explorer shows a real image thumbnail for 14 file formats that Windows cannot preview on its own.
2. **Live hover preview.** Rest your mouse over a supported file in Explorer or on the Desktop and a floating card appears with a larger preview, dimensions, file size and date.

## Formats and Defaults

All 14 formats have thumbnails ON by default. Hover preview is ON for design and font formats, and OFF by default for JPG, PNG and JPEG (thumbnail only). Every format can be switched on or off in Settings.

| Format | Thumbnail | Hover preview |
| --- | --- | --- |
| PSD, PSB | ON | ON |
| AI, EPS, SVG | ON | ON |
| TIFF, TIF | ON | ON |
| TTF, OTF, WOFF, WOFF2 | ON | ON |
| JPG, JPEG, PNG | ON | OFF |

## Key Features

- **Thumbnails for design files.** PSD, PSB, AI, EPS and SVG files show real previews in Explorer. No need to open the design app just to find a file.
- **Font previews.** TTF, OTF, WOFF and WOFF2 files show a rendered font specimen as their thumbnail.
- **Hover preview card.** Hover over a design or font file to see a larger preview with width, height, file size and date.
- **Settings window.** A dark-theme manager with one row per format and two toggles per row (Thumbnail, Hover Preview), live search, and settings saved instantly.
- **Starts with Windows.** The hover engine runs silently in the background from logon. No tray icon, no window in your way.
- **Clean uninstall.** Uninstall from Windows Settings, or run the clean uninstall scripts in `Setup/`. No PC restart needed.

## Download and Install

1. Go to the [Releases](../../releases) page.
2. Download `Thumbix_Setup_v1.0.exe` and run it.
3. Done. Thumbnails appear in Explorer right away, and the hover engine starts with Windows.

**Requirements:** Windows 10 or 11, 64-bit. Thumbix uses the .NET Framework that ships with Windows, so no extra runtime needs to be installed.

On first install, a welcome card appears with links to the developer and a way to support the project.

## How to Use

- **Open Settings:** launch Thumbix from the Start Menu. Turn any format's thumbnail or hover preview on or off.
- **Preview a file:** hover over a supported file in Explorer or on the Desktop. The preview card shows the image, its dimensions, size and date.
- **Turn hover on for photos:** JPG, PNG and JPEG have hover OFF by default. Open Settings and switch Hover Preview on for them if you want it.
- Settings are saved instantly to `%LOCALAPPDATA%\Thumbix\settings.ini`.

## How It Works

Thumbix registers a native thumbnail provider with Windows. It reads embedded previews from PSD, PSB, AI and EPS files (using stream seeking, so large files are not fully loaded just to find the preview), renders SVG, renders font specimens for TTF, OTF, WOFF and WOFF2, and uses the Windows Imaging Component for raster images. The hover engine is a silent background process that watches the mouse over Explorer and Desktop windows.

**Command line modes** (`ThumbixApp.exe`):

| Mode | What it does |
| --- | --- |
| (no argument) | Opens Settings and starts the background engine |
| `/welcome` | Shows the welcome card, then Settings |
| `/register` | Registers the provider and all extensions |
| `/unregister` | Removes the registration |
| `/background` | Runs the silent hover engine only |
| `/kill` | Stops the hover engine |
| `/refresh` | Refreshes Explorer file associations |

## Uninstall

Uninstall from Windows Settings, or run `Setup/clean_uninstall.bat` or `Setup/clean_uninstall.ps1`. The scripts stop Thumbix processes, remove its registry keys and refresh the shell. Note: they also stop the shared thumbnail host processes (`dllhost.exe`, `prevhost.exe`), so thumbnails from other apps may briefly reload.

Note: the project was first called SeeEverything, so that name may still appear inside the app and in registry values. It works as is for v1.0 and may be renamed in a later release.

## Contributing

Found a bug or have an idea? See [CONTRIBUTING.md](CONTRIBUTING.md).

## Third-Party Libraries

Thumbix uses Svg.NET and ExCSS (both MIT licensed) for SVG rendering. See [THIRD-PARTY-NOTICES.md](THIRD-PARTY-NOTICES.md).

## License

Distributed under the **PolyForm Noncommercial License 1.0.0** - free for personal, non-commercial use. You may use it and share it, but you may **not** sell it or claim it as your own. See [LICENSE](LICENSE).

## Author

**Moshiur Rahman ([@moshclusive](https://github.com/moshclusive))** - Graphic Designer, tool builder.

- LinkedIn: https://www.linkedin.com/in/moshclusive/
- Facebook: https://www.facebook.com/moshclusive
- Buy Me a Coffee: https://www.supportkori.com/moshclusive
