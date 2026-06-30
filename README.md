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
  <a href="https://liberapay.com/Agundur/donate">
    <img src="https://liberapay.com/assets/widgets/donate.svg" alt="Donate using Liberapay">
  </a>
</div>

## What's included

A clean, minimal starting point for a **KDE Plasma 6 Plasmoid** — pure QML, no boilerplate:

| Feature | Details |
|---|---|
| Compact + Full representation | Panel icon expands to full popup |
| Config dialog | `configNetwork.qml` with KCM.SimpleKCM + `main.xml` for persistent settings |
| i18n | `translate/` with `.po` files for de, en, es, fr — `ki18n_install` wired up |
| Qt Quick Test | `tests/tst_plasmoid.qml` — run with `ctest` |
| Clean CMake | Only what's needed: ECM, KF6 Config/I18n/KCMUtils, Qt6 Quick/Test |

## Requirements

- Qt ≥ 6.7
- KDE Frameworks ≥ 6.10
- CMake ≥ 3.16
- Extra CMake Modules (ECM)

On openSUSE Tumbleweed:
```bash
sudo zypper install cmake extra-cmake-modules kf6-ki18n-devel kf6-kconfigwidgets-devel \
     kf6-kcmutils-devel qt6-quick-devel qt6-test-devel
```

On Arch / KDE neon / Ubuntu with KDE PPA — install the equivalent `*-dev` packages.

## Build

```bash
git clone https://github.com/Agundur-KDE/KDE-Plasma-Plasmoid-template.git
cd KDE-Plasma-Plasmoid-template
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j$(nproc)
sudo make install
```

## Test

```bash
cd build
cmake .. -DCMAKE_BUILD_TYPE=Debug
make tst_plasmoid
ctest --output-on-failure
```

Tests live in `tests/tst_plasmoid.qml`. Add `TestCase { }` blocks there as your plasmoid grows.

## Quick install without CMake (for development)

```bash
kpackagetool6 --install package/
# reload with:
plasmoidviewer -a de.agundur.myplasmoid
# or on Wayland:
QT_QPA_PLATFORM=xcb plasmoidviewer -a de.agundur.myplasmoid
```

## Customising

1. **Rename** — find/replace `de.agundur.myplasmoid` and `myplasmoid` in `CMakeLists.txt` and `package/metadata.json`
2. **UI** — edit `package/contents/ui/FullRepresentation.qml` for the popup content
3. **Settings** — add entries to `package/contents/config/main.xml` and a matching field in `configNetwork.qml`
4. **C++ plugin** — uncomment `add_subdirectory(plugin)` in `package/CMakeLists.txt` and add your plugin there

## Contributing

Fork and adapt freely. If you improve something others would benefit from, a pull request is welcome.
