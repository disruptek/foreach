version = "1.0.1"
author = "disruptek"
description = "A sugary for loop with syntax for typechecking loop variables"
license = "MIT"
requires "nim >= 0.20.0"

task test, "Runs the test suite":
  exec "nim c -r foreach.nim"
