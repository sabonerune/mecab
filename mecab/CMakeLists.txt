set(PACKAGE \"${PROJECT_NAME}\")
set(VERSION \"${mecab_VERSION}\")

include(CheckIncludeFiles)
include(CheckSymbolExists)
include(CheckCXXSourceCompiles)
include(CheckTypeSize)
# TODO: AC_APPLE_UNIVERSAL_BUILD
check_include_files(dirent.h HAVE_DIRENT_H)
check_include_files(fcntl.h HAVE_FCNTL_H)
check_symbol_exists(getenv stdlib.h HAVE_GETENV)
find_package(Iconv)
if(Iconv_FOUND)
  set(HAVE_ICONV 1)
  check_cxx_source_compiles("
    #include <stdlib.h>
    #include <iconv.h>
    extern \"C\" size_t iconv(
      iconv_t cd,
      char * *inbuf,
      size_t *inbytesleft,
      char * *outbuf,
      size_t *outbytesleft
    );
    int main() { return 0; }\n"
    ICONV_NOT_REQUIRE_CONST
  )
  if(NOT ICONV_NOT_REQUIRE_CONST)
    set(ICONV_CONST const)
  endif()
endif()
check_symbol_exists(mmap sys/mman.h HAVE_MMAP)
find_package(Threads)
if(CMAKE_USE_PTHREADS_INIT)
  set(HAVE_PTHREAD_H 1)
  check_cxx_source_compiles("
    #include <sched.h>
    int main() {
      int a = 10;
      __sync_fetch_and_add(&a, 10);
      __sync_val_compare_and_swap(&a, 0, 10);
      sched_yield();
      return 0;
    }\n"
    HAVE_GCC_ATOMIC_OPS
  )
  check_cxx_source_compiles("
    #include <libkern/OSAtomic.h>
    int main() {
      int a = 10;
      OSAtomicAdd32(10, &a);
      OSAtomicCompareAndSwapInt(10, 0, &a);
      return 0;
    }\n"
    HAVE_OSX_ATOMIC_OPS
  )
endif()
check_include_files(stdint.h HAVE_STDINT_H)
check_include_files(string.h HAVE_STRING_H)
check_include_files(sys/mman.h HAVE_SYS_MMAN_H)
check_include_files(sys/stat.h HAVE_SYS_STAT_H)
check_include_files(sys/types.h HAVE_SYS_TYPES_H)
check_cxx_source_compiles("
  __thread int a = 0;
  int main() {
    a = 10;
    return 0;
  }\n"
  HAVE_TLS_KEYWORD
)
check_include_files(unistd.h HAVE_UNISTD_H)
check_cxx_source_compiles("
  unsigned long long int n;
  int main() { return 0; }\n"
  HAVE_UNSIGNED_LONG_LONG_INT
)
check_include_files(windows.h HAVE_WINDOWS_H)
configure_file(config.h.cmake.in config.h/config.h)

add_library(common_compiler_flags INTERFACE)
set(IS_DEBUG_AND_ROOT "$<AND:$<CONFIG:Debug>,$<STREQUAL:${CMAKE_PROJECT_NAME},mecab>>")
set(MSVC_WALL "$<$<CXX_COMPILER_ID:MSVC>:/W4>")
set(GCC_LIKE_SUPPORTS "$<CXX_COMPILER_ID:ARMClang,AppleClang,Clang,GNU,LCC>")
set(GCC_LIKE_WALL "$<${GCC_LIKE_SUPPORTS}:-Wall;-Wextra>")
target_compile_options(
  common_compiler_flags
  INTERFACE
  "$<${IS_DEBUG_AND_ROOT}:${MSVC_WALL}>"
  "$<${IS_DEBUG_AND_ROOT}:${GCC_LIKE_WALL}>"
)

add_subdirectory(src)

target_include_directories(mecab PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/config.h)

if(MECAB_BUILD_EXAMPLES)
  add_subdirectory(example)
endif()
