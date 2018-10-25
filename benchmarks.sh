#!/bin/bash
echo

haxe benchmarks.hxml &>/dev/null
echo testing with Vector:
echo 
echo ------------------- Node -------------------------------------
node Export/benchmarks/benchmarks.js
echo
echo ------------------- CPP --------------------------------------
./Export/benchmarks/Benchmarks
echo
echo ------------------- Neko -------------------------------------
neko Export/benchmarks/benchmarks.n
echo
echo
echo

haxe -D PixelMatrixUseArray benchmarks.hxml &>/dev/null
echo testing with Array:
echo 
echo ------------------- Node -------------------------------------
node Export/benchmarks/benchmarks.js
echo
echo ------------------- CPP --------------------------------------
./Export/benchmarks/Benchmarks
echo
echo ------------------- Neko -------------------------------------
neko Export/benchmarks/benchmarks.n
echo
echo
echo

haxe -D PixelMatrixUseUInt32Array benchmarks.hxml &>/dev/null
echo testing with UInt32Array:
echo 
echo ------------------- Node -------------------------------------
node Export/benchmarks/benchmarks.js
echo
echo ------------------- CPP --------------------------------------
./Export/benchmarks/Benchmarks
echo
echo ------------------- Neko -------------------------------------
neko Export/benchmarks/benchmarks.n
echo
echo
echo

haxe -D PixelMatrixUseBytes benchmarks.hxml &>/dev/null
echo testing with Bytes:
echo 
echo ------------------- Node -------------------------------------
node Export/benchmarks/benchmarks.js
echo
echo ------------------- CPP --------------------------------------
./Export/benchmarks/Benchmarks
echo
echo ------------------- Neko -------------------------------------
neko Export/benchmarks/benchmarks.n
echo
echo
echo
