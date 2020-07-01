project(valac)

cmake_minimum_required(VERSION 3.16)

set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS true)

find_package(unofficial-glib CONFIG REQUIRED)


include_directories("gee" "vala" "ccode" "codegen" "gobject-introspection" "./")

file(GLOB GEE_SRC "./gee/*.c")
add_library(gee SHARED ${GEE_SRC})

file(GLOB VALA_SRC "./vala/*.c")
add_library(vala SHARED ${VALA_SRC})
target_link_libraries(vala gee unofficial::glib::gio unofficial::glib::glib unofficial::glib::gmodule unofficial::glib::gobject)

file(GLOB CCODE_SRC "./ccode/*.c")
add_library(ccode SHARED ${CCODE_SRC})
target_link_libraries(ccode gee vala unofficial::glib::gio unofficial::glib::glib unofficial::glib::gmodule unofficial::glib::gobject)

file(GLOB CODEGEN_SRC "./codegen/*.c")
add_library(codegen SHARED ${CODEGEN_SRC})
target_link_libraries(codegen gee vala ccode unofficial::glib::gio unofficial::glib::glib unofficial::glib::gmodule unofficial::glib::gobject)

file(GLOB COMPILER_SRC "./compiler/*.c")
add_executable(valac ${COMPILER_SRC})
target_link_libraries(valac gee vala ccode codegen unofficial::glib::gio unofficial::glib::glib unofficial::glib::gmodule unofficial::glib::gobject)

file(GLOB GOBJECT_INTROSPECTION_SRC "./gobject-introspection/*.c")
add_library(gidl ${GOBJECT_INTROSPECTION_SRC})
add_executable(gobject-introspect ${GOBJECT_INTROSPECTION_SRC})

set(VAPIGEN_SRC 
    "./vapigen/valavapigen.c"
    "./vapigen/valagidlparser.c")
add_executable(vapigen ${VAPIGEN_SRC})
target_link_libraries(vapigen gee vala gidl unofficial::glib::gio unofficial::glib::glib unofficial::glib::gmodule unofficial::glib::gobject)

set(VAPIGEN_SRC 
    "./vapigen/valavapicheck.c"
    "./vapigen/valagidlparser.c")
add_executable(vapicheck ${VAPIGEN_SRC})
target_link_libraries(vapicheck gee vala gidl unofficial::glib::gio unofficial::glib::glib unofficial::glib::gmodule unofficial::glib::gobject)
