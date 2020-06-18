# vala-win
Build [Vala](https://wiki.gnome.org/Projects/Vala) compiler for windows using MSVC.

Chinese version : [中文](https://github.com/ZacharyJia/vala-win/blob/master/README-CN.md)

This is a support repository for users who want to build the Vala compiler using MSVC in windows. 

I will also provide pre-built binaries in [Releases](https://github.com/ZacharyJia/vala-win/releases). 
If you are just looking for a native Vala compiler without msys2 or something else, just go to [Releases](https://github.com/ZacharyJia/vala-win/releases) and download the latest pre-built binary.

## Build Vala compiler with cmake
### requirements:
1. Visual Studio 2019 (older msvc might work, but I just tested on this version)
2. Vcpkg (Provide glib support, get support on [vcpkg](https://github.com/microsoft/vcpkg))
3. cmake
4. A source file tarball of Vala from [gnome website](http://ftp.acc.umu.se/pub/gnome/sources/vala/0.48/)

### Steps:
1. Install vcpkg and integrate with msvc (a `vcpkg integrate install` command, see more on vcpkg's document)
2. Install glib with vcpkg: `vcpkg install glib:x86-windows`.
3. Clone this repository: `git clone https://github.com/ZacharyJia/vala-win.git`
4. Extract the vala source tarball into this repository. Therefore all files in this repository will be in the root directory of Vala's source.
5. Create a `build` directory and generate cmake files: `mkdir build && cd build && cmake ..`
6. Build using cmake (`cmake --build . --config Release`), or open the `sln` file with visual studio for manually building.


### Known Issue(s):
Currently the `valac` cannot find the built-in vapi files autmatically, since its location is set in the `config.h`(the `PACKAGE_DATADIR` macro) when compile. Now we leave it empty and you can use `valac --vapidir=[vapi files dir] example.vala` to specify it manually. If you are using [meson](https://github.com/mesonbuild/meson) for building your Vala project, you can set a environmnet variable named `VALAFLAGS`, whose value shoudl be `--vapidir=[vapi files dir]`, and meson will use it automatically.

If you have any solutions to the issue(s), PR or Issue is welcomed.