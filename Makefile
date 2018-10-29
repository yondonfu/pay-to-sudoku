ROOT_DIR := $(shell dirname $(realpath $(MAKEFILE_LIST)))

ifeq ($(OS),Windows_NT)
	detected_OS := Windows
	DLL_EXT := .dll
else
	detected_OS := $(shell uname -s)
	ifeq ($(detected_OS),Darwin)
		DLL_EXT := .dylib
		export LD_LIBRARY_PATH := /usr/local/opt/openssl/lib:"$(LD_LIBRARY_PATH)"
		export CPATH := /usr/local/opt/openssl/include:"$(CPATH)"
		export PKG_CONFIG_PATH := /usr/local/opt/openssl/lib/pkgconfig:"$(PKG_CONFIG_PATH)"
	else
		DLL_EXT := .so
	endif
endif

all: build/src/libmysnark$(DLL_EXT)

build:
	mkdir -p build

build/src/libmysnark$(DLL_EXT): build/Makefile
	make -C build
	cp build/snark/libmysnark$(DLL_EXT) target/debug/deps
	cp build/snark/libmysnark$(DLL_EXT) target/release/deps

build/Makefile: build CMakeLists.txt
	cd build && cmake ..

depends/libsnark/CMakeLists.txt:
	git submodule update --init --recursive

clean:
	rm -rf build target/debug/deps/libmysnark$(DLL_EXT) target/release/deps/libmysnark$(DLL_EXT)