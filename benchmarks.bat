@haxe benchmarks.hxml >NUL

@echo testing with Vector:
@echo .
@echo ------------------- Node -------------------------------------
@node Export\benchmarks\benchmarks.js
@echo .
@echo ------------------- CPP --------------------------------------
@Export\benchmarks\Benchmarks.exe
@echo .
@echo ------------------- Neko -------------------------------------
@neko Export\benchmarks\benchmarks.n
@echo .
@echo .
@echo .

@haxe -D PixelMatrixUseArray benchmarks.hxml >NUL
@echo testing with Array:
@echo .
@echo ------------------- Node -------------------------------------
@node Export\benchmarks\benchmarks.js
@echo .
@echo ------------------- CPP --------------------------------------
@Export\benchmarks\Benchmarks.exe
@echo .
@echo ------------------- Neko -------------------------------------
@neko Export\benchmarks\benchmarks.n
@echo .
@echo .
@echo .

@haxe -D PixelMatrixUseUInt32Array benchmarks.hxml >NUL
@echo testing with UInt32Array:
@echo .
@echo ------------------- Node -------------------------------------
@echo .
@node Export\benchmarks\benchmarks.js
@echo ------------------- CPP --------------------------------------
@echo .
@Export\benchmarks\Benchmarks.exe
@echo ------------------- Neko -------------------------------------
@echo .
@neko Export\benchmarks\benchmarks.n
@echo .
@echo .
@echo .

@haxe -D PixelMatrixUseBytes benchmarks.hxml >NUL
@echo testing with Bytes:
@echo .
@echo ------------------- Node -------------------------------------
@node Export\benchmarks\benchmarks.js
@echo .
@echo ------------------- CPP --------------------------------------
@Export\benchmarks\Benchmarks.exe
@echo .
@echo ------------------- Neko -------------------------------------
@neko Export\benchmarks\benchmarks.n
@echo .
@echo .
@echo .

@pause