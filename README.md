# Godot Size Benchmarks

This repository contains a program that compiles Godot export templates with
various settings to decrease file size.

## Results

The results below were generated on Fedora 29 with GCC 8.3.1 from the Godot 3.1
stable source code. Binaries had their debug symbols stripped, and ZIP archives
were created using `7z a -mx9 <file>.zip <file>`.

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
|    Linux | `full`     | 28.6 MB             | 11.1 MB                 |
|    Linux | `full_2d`  | 24.0 MB             | 9.3 MB                  |
|    Linux | `micro`    | 25.3 MB             | 9.7 MB                  |
|    Linux | `micro_2d` | 21.8 MB             | 8.4 MB                  |
|    Linux | `pico`     | 16.2 MB             | 6.0 MB                  |
|    Linux | `pico_2d`  | 13.9 MB             | 5.2 MB                  |

## Running the benchmark locally

**Note:** The benchmark runner currently only supports Linux.

### Pre-requisites

- [Nim](https://nim-lang.org/) 0.19.4 or later (can be installed via
  [choosenim](https://github.com/dom96/choosenim)).
- Godot build dependencies set up for
  [Linux](https://docs.godotengine.org/en/latest/development/compiling/compiling_for_x11.html).
- This Git repository _(with submodules initialized)_.

### Running

```bash
git clone --recursive https://github.com/Calinou/godot-size-benchmarks.git
cd godot-size-benchmarks/
nimble run
```

Wait for the script to build all binaries; they will be available in the
`godot/bin/` directory.

## License

Copyright © 2019 Hugo Locurcio and contributors

Unless otherwise specified, files in this repository are licensed under the MIT
license; see [LICENSE.md](LICENSE.md) for more information.
