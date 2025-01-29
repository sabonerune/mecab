cmake_minimum_required(VERSION 3.15...3.31)
project(mecab VERSION 0.996 LANGUAGES CXX)

option(MECAB_BUILD_PROGRAMS "Build Programs" ON)
option(MECAB_BUILD_SHARED_LIBS "Build shared libraries" ON)

if(BUILD_SHARED_LIBS OR MECAB_BUILD_SHARED_LIBS)
  set(MECAB_LIB_TYPE SHARED)
else()
  set(MECAB_LIB_TYPE STATIC)
endif()

option(MECAB_USE_UTF8_ONLY "Enable UTF-8 only mode" OFF)
if(MECAB_USE_UTF8_ONLY OR NOT WIN32)
  set(DEFAULT_CHARSET UTF-8)
else()
  set(DEFAULT_CHARSET SHIFT-JIS)
endif()
set(MECAB_DICT_CHARSET ${DEFAULT_CHARSET} CACHE STRING "Dic charset")
set_property(
  CACHE MECAB_DICT_CHARSET PROPERTY
  STRINGS "UTF-8" "SHIFT-JIS" "EUC-JP" "UTF-16" "UTF-16BE" "UTF-16LE" "ASCII"
)

option(MECAB_BUILD_EXAMPLES "Build Example Programs" OFF)

add_subdirectory(mecab)
add_subdirectory(mecab-ipadic)

option(MECAB_BUILD_JUMANDIC "Build jumandic" OFF)
if(MECAB_BUILD_JUMANDIC)
  add_subdirectory(mecab-jumandic)
endif()
