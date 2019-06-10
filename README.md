# Godot Size Benchmarks

This repository contains a program that compiles Godot export templates with
various settings to decrease file size.

## Results

The results below were generated on Fedora 30 with GCC 9.1.1 from the Godot
3.1.1 stable source code. Binaries had their debug symbols stripped, and ZIP
archives were created using `7z a -mx9 <file>.zip <file>`. Android APK sizes
were measured after building for `armv7` only, which means only one architecture
was included in the APK.

- **`full`** builds have all modules enabled.
- **`micro`** builds have commonly-used modules enabled (such as mbedTLS or
  Theora/WebM); lesser-used modules are disabled.
- **`pico`** builds have all modules disabled and are optimized for size instead
  of speed.
- Builds with a **`_2d`** suffix have 3D support disabled.

Check the [build script](src/godot_size_benchmarks.nim) for the list of SCons
flags used by each build type.

| Platform | Build type | Size (uncompressed) | Size (in a ZIP archive) |
| -------: | ---------- | ------------------- | ----------------------- |
|    Linux | `full`     | 30.9 MB             | 12.0 MB                 |
|    Linux | `full_2d`  | 25.9 MB             | 10.0 MB                 |
|    Linux | `micro`    | 27.3 MB             | 10.4 MB                 |
|    Linux | `micro_2d` | 23.4 MB             | 9.0 MB                  |
|    Linux | `pico`     | 15.7 MB             | 6.0 MB                  |
|    Linux | `pico_2d`  | 13.5 MB             | 5.1 MB                  |
|  Android | `full`     | 11.8 MB             | *N/A*                   |
|  Android | `full_2d`  | 9.5 MB              | *N/A*                   |
|  Android | `micro`    | 9.8 MB              | *N/A*                   |
|  Android | `micro_2d` | 8.5 MB              | *N/A*                   |
|  Android | `pico`     | 8.1 MB              | *N/A*                   |
|  Android | `pico_2d`  | 7.1 MB              | *N/A*                   |

## Running the benchmark locally

**Note:** The benchmark runner currently only supports Linux.

### Pre-requisites

- [Nim](https://nim-lang.org/) 0.19.6 or later (can be installed via
  [choosenim](https://github.com/dom96/choosenim)).
- Godot build dependencies set up for
  [Linux](https://docs.godotengine.org/en/latest/development/compiling/compiling_for_x11.html)
  and
  [Android](http://docs.godotengine.org/en/latest/development/compiling/compiling_for_android.html).
- This Git repository _(with submodules initialized)_.

### Running

```bash
git clone --recursive https://github.com/Calinou/godot-size-benchmarks.git
cd godot-size-benchmarks/
nimble run
```

Wait for the script to build all binaries; they will be available in the
`godot/bin/` directory.

## Resources

- [Multiple APK support in Google Play](https://developer.android.com/google/play/publishing/multiple-apks)
  to publish one APK per CPU architecture, greatly reducing the file size.

## License

Copyright © 2019 Hugo Locurcio and contributors

Unless otherwise specified, files in this repository are licensed under the MIT
license; see [LICENSE.md](LICENSE.md) for more information.
