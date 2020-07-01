# Vala-win 
在Windows上使用MSVC编译Vala编译器。

English version : [English](https://github.com/ZacharyJia/vala-win/blob/master/README.md)

这是一个为了帮助想要在Windows上使用MSVC来编译Vala语言编译器的支持项目。

我也会定期提供最新的预编译版本。如果你只是想要寻找一个在Windows上使用的Vala编译器，而不想安装MSYS2之类的软件，那么你可以直接去[Release页面](https://github.com/ZacharyJia/vala-win/releases)下载最新预编译二进制文件即可。

## 通过CMake编译Vala编译器
### 编译需求:
1. Visual Studio 2019 (旧版本的MSVC可能也可以工作，但是我只在2019版本上做了测试)
2. Vcpkg (用来为我们提供MSVC编译的GLib库，这是vala依赖， 具体的安装使用支持请参阅[vcpkg](https://github.com/microsoft/vcpkg))
3. cmake
4. 从[gnome website](http://ftp.acc.umu.se/pub/gnome/sources/vala/0.48/)网站上下载的Vala的压缩包

### 编译步骤:
1. 安装Vcpkg并且和MSVC集成(使用`vcpkg integrate install`命令, 具体请参阅Vcpkg文档)
2. 通过Vcpkg安装GLib: `vcpkg install glib:x86-windows`.
3. 克隆本仓库到本地: `git clone https://github.com/ZacharyJia/vala-win.git`
4. 将Vala压缩包解压到本仓库下. 解压完成后，你应该能看到本仓库的几个文件应该在Vala源代码的根目录下。
5. 在当前目录下创建build文件夹，并生成cmake文件: `mkdir build && cd build && cmake ..`
6. 使用CMake进行编译 (`cmake --build . --config Release`), 或者用 Visual Studio 打开build文件夹下生成的 `sln` 文件进行手动编译。

### 已知问题：
目前`valac`不能自动找到内置的vapi文件，因为内置vapi文件的位置是在编译的时候在`config.h`（`PACKAGE_DATADIR`宏）中指定的。目前我将这个值留空了，你可以使用 `valac --vapidir=[vapi files dir] example.vala`这样的命令来手动指定vapi文件所在的文件夹。如果你使用[Meson](https://github.com/mesonbuild/meson)作为编译工具的话，你可以设置一个名为`VALAFLAGS`的环境变量，将它的值设为`--vapidir=[vapi files dir]`，meson编译时会自动使用它。

如果你对以上问题有解决方案，欢迎提交PR或者Issue。


### 修改日志：

- 2020年7月1日  更新到0.48.7版本