# Package

version       = "1.0.0"
author        = "Hugo Locurcio"
description   = "Benchmarks to compare Godot binary sizes with different build-time options"
license       = "MIT"
srcDir        = "src"
bin           = @["godot_size_benchmarks"]

# Dependencies

requires "nim >= 0.20.0"
requires "cligen >= 0.9.19"

# Tasks

task run, "Run benchmarks":
  const execName =
    when defined(windows):
      "godot_size_benchmarks.exe"
    else:
      "./godot_size_benchmarks"

  exec "nimble build -d:release && " & execName
