<div align="center">
  <h1>KDE Plasma 6 Plasmoid Template</h1>

  <a href="https://kde.org/">
    <img src="https://img.shields.io/badge/KDE_Plasma-6.7+-blue?style=flat&logo=kde" alt="KDE Plasma 6">
  </a>
  <a href="https://www.gnu.org/licenses/gpl-3.0.html">
    <img src="https://img.shields.io/badge/License-GPL--2.0%2B-blue.svg" alt="License: GPL-2.0+">
  </a>
  <a href="https://paypal.me/agundur">
    <img src="https://img.shields.io/badge/donate-PayPal-%2337a556" alt="PayPal">
  </a>
</div>

## What's included

A clean, minimal starting point for a **KDE Plasma 6 Plasmoid** — pure QML, no boilerplate:

| Feature | Details |
|---|---|
| Compact + Full representation | Panel icon expands to full popup |
| Config dialog | `configGeneral.qml` with KCM.SimpleKCM + `main.xml` for persistent settings |
| i18n | `translate/` with `.po` files for de, es, fr (English is the source language, needs no `.po`) — `ki18n_install` wired up, `Messages.sh` extracts strings |
| Qt Quick Test | `tests/tst_plasmoid.qml` — run with `ctest` |
| Clean CMake | Only what's needed: ECM, KF6 Config/I18n/KCMUtils, Qt6 Quick/Test/QuickTest |

## Requirements

- Qt ≥ 6.7
- KDE Frameworks ≥ 6.10
- CMake ≥ 3.16
- Extra CMake Modules (ECM)

On openSUSE Tumbleweed:
```bash
sudo zypper install cmake kf6-extra-cmake-modules kf6-ki18n-devel kf6-kconfig-devel \
     kf6-kcmutils-devel qt6-quick-devel qt6-test-devel qt6-quicktest-devel
```

On Arch / KDE neon / Ubuntu with KDE PPA — install the equivalent `*-dev` packages.

**Not on Tumbleweed and just want to build/test without installing all of the
above?** The CI container has everything preinstalled:

```bash
docker run --rm -it -v "$PWD":/src -w /src ghcr.io/agundur-kde/plasmoid-ci:latest bash
```

Only useful for the CMake/`ctest`/`qmllint` build-and-test path — for pure QML
iteration you don't need this or the packages above, see "Quick iteration" below.

## Build

```bash
git clone https://github.com/Agundur-KDE/KDE-Plasma-Plasmoid-template.git
cd KDE-Plasma-Plasmoid-template
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$HOME/.local"
make -j$(nproc)
make install
```

(No `sudo` needed — installing to your own `~/.local` is enough for Plasma
to find the plasmoid. For pure QML iteration you don't need to build/install
at all, see "Quick iteration" below.)

## Test

```bash
cd build
cmake .. -DCMAKE_BUILD_TYPE=Debug
make tst_plasmoid
ctest --output-on-failure
```

Tests live in `tests/tst_plasmoid.qml`. Add `TestCase { }` blocks there as your plasmoid grows.

## Rename for your project

After cloning, run the interactive rename script once:

```bash
bash rename.sh
```

It replaces all occurrences of `de.agundur.myplasmoid` / `myplasmoid` / `KDE-Template`,
renames the `.po` translation files, and updates `metadata.json` (name, description, author, URLs).

## Translations

After adding or changing an `i18n()`/`i18nc()` call in the QML, run:

```bash
./Messages.sh
```

This extracts every translatable string into `translate/template.pot` and merges it
into each existing `translate/<lang>/*.po` (adds new strings, keeps existing
translations and each file's header). Translators then fill in the empty `msgstr`
entries in the `.po` files.

## Quick iteration without installing (for development)

`plasmoidviewer` can load a package straight from its source folder — no
`kpackagetool6 --install` / `sudo make install` round-trip needed while
you're just iterating on QML:

```bash
plasmoidviewer -a package/
```

Edits to QML/config files apply on the next restart of `plasmoidviewer`.
Only install for real (`kpackagetool6 --install package/`, or `make
install` for the compiled plugin) once you need a real desktop/panel
placement or system icon-theme resolution.

## Customising

1. **Rename** — find/replace `de.agundur.myplasmoid` and `myplasmoid` in `CMakeLists.txt` and `package/metadata.json`
2. **UI** — edit `fullRepresentation`/`compactRepresentation` in `package/contents/ui/main.qml` for the popup content. Keep them inline there rather than splitting into separate files — QML ids (like `root`) aren't visible across files, so a separate file can't reach back into `main.qml`'s state.
3. **Settings** — add entries to `package/contents/config/main.xml` and a matching field in `configGeneral.qml`
4. **C++ plugin** — optional, disabled by default. Uncomment `add_subdirectory(plugin)` in `package/CMakeLists.txt` if you need a C++-backed QML type; `package/plugin/FileReader.*` is a working example to start from. It's intentionally simple: it opens whatever path its `path` property is set to. Fine for a config-driven path you control — don't wire it up to untrusted/user-supplied input without adding your own validation.

## Contributing

Fork and adapt freely. If you improve something others would benefit from, a pull request is welcome.
