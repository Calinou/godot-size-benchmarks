# Godot Size Benchmarks

This repository contains a program that compiles Godot export templates with
various settings to decrease file size.

## Results

The results below were generated on Fedora 33 with GCC 10.2.1 from the Godot
3.2.3 stable source code. All binaries had their debug symbols stripped.

- **`full`** builds have all modules enabled.
- **`micro`** builds have commonly-used modules enabled (such as mbedTLS or
  Theora/WebM); lesser-used modules are disabled.
- **`pico`** builds have all modules disabled and are optimized for size instead
  of speed.
- Builds with a **`_2d`** suffix have 3D support disabled.

Check the [build script](src/godot_size_benchmarks.nim) for the list of SCons
flags used by each build type.

| Platform | Build type     | Size (uncompressed) | Size (compressed) |
| -------: | -------------- | ------------------- | ----------------- |
|  Android | `full`         | 11.8 MB             | 11.8 MB           |
|  Android | `full_2d`      | 9.5 MB              | 9.5 MB            |
|  Android | `micro`        | 9.8 MB              | 9.8 MB            |
|  Android | `micro_2d`     | 8.5 MB              | 8.5 MB            |
|  Android | `pico`         | 8.1 MB              | 8.1 MB            |
|  Android | `pico_2d`      | 7.1 MB              | 7.1 MB            |
|    HTML5 | `full`         | 13.0 MB             | 4.0 MB            |
|    HTML5 | `full_2d`      | 11.3 MB             | 3.4 MB            |
|    HTML5 | `micro`        | 11.5 MB             | 3.4 MB            |
|    HTML5 | `micro_2d`     | 10.2 MB             | 3.1 MB            |
|    HTML5 | `pico`         | 10.9 MB             | 3.2 MB            |
|    HTML5 | `pico_2d`      | 9.7 MB              | 2.9 MB            |
|    Linux | `full`         | 30.9 MB             | 12.0 MB           |
|    Linux | `full_2d`      | 25.9 MB             | 10.0 MB           |
|    Linux | `micro`        | 27.3 MB             | 10.4 MB           |
|    Linux | `micro_2d`     | 23.4 MB             | 9.0 MB            |
|    Linux | `pico`         | 15.7 MB             | 6.0 MB            |
|    Linux | `pico_2d`      | 13.5 MB             | 5.1 MB            |
|  Windows | `full`         | 26.7 MB             | 10.2 MB           |
|  Windows | `full_2d`      | 22.5 MB             | 8.6 MB            |
|  Windows | `micro`        | 23.7 MB             | 9.0 MB            |
|  Windows | `micro_2d`     | 20.2 MB             | 7.7 MB            |
|  Windows | ~~`pico`~~     | *(build failing)*   | *N/A*             |
|  Windows | ~~`pico_2d`~~  | *(build failing)*   | *N/A*             |

### Platform-specific notes

- **Android:** Android APK sizes were measured after building for `armv7` only,
  which means only one architecture was included in the APK. Android APKs are
  already compressed on creation, hence the compressed size being identical to
  the uncompressed size.
- **HTML5:** Displayed file sizes only include the main WebAssembly blob. The
  accompanying JavaScript file's size (330 KB uncompressed, 75 KB gzipped)
  remains mostly constant. Compressed sizes were measured by compressing the
  WebAssembly blob with `gzip -6`, which is the compression level used on most
  Web servers (after enabling compression for `.wasm` files).
- **Linux:** Binaries were compiled with link-time optimization enabled.
  Compressed sizes were measured by creating ZIP archives using
  `7z a -mx9 <file>.zip <file>`.
- **Windows:** Binaries were compiled using MinGW with link-time optimization
  enabled. Compressed sizes were measured by creating ZIP archives using
  `7z a -mx9 <file>.zip <file>`.

## Running the benchmark locally

**Note:** The benchmark runner currently only supports Linux.

### Pre-requisites

- [Nim](https://nim-lang.org/) 0.20.0 or later (can be installed via
  [choosenim](https://github.com/dom96/choosenim)).
- Godot build dependencies set up for
  [Android](http://docs.godotengine.org/en/latest/development/compiling/compiling_for_android.html),
  [HTML5](https://docs.godotengine.org/en/latest/development/compiling/compiling_for_web.html),
  [Linux](https://docs.godotengine.org/en/latest/development/compiling/compiling_for_x11.html) and
  [Windows](https://docs.godotengine.org/en/latest/development/compiling/compiling_for_windows.html) (MinGW).
- This Git repository **(with submodules initialized)**.

### Running

```bash
git clone --recursive https://github.com/Calinou/godot-size-benchmarks.git
cd godot-size-benchmarks/
nimble run
```

Wait for the script to build all binaries; they will be available in the
`godot/bin/` directory.

## Resources

- [Optimizing a build for size](http://docs.godotengine.org/en/latest/development/compiling/optimizing_for_size.html)
  in the Godot documentation.
- [Multiple APK support in Google Play](https://developer.android.com/google/play/publishing/multiple-apks)
  to publish one APK per CPU architecture, greatly reducing the file size.

## License

Copyright © 2019-2021 Hugo Locurcio and contributors

Unless otherwise specified, files in this repository are licensed under the MIT
license; see [LICENSE.md](LICENSE.md) for more information.
