enable_language(C CXX)

set(MSVC_CHARSET_COMPILE_OPTION "$<$<C_COMPILER_ID:MSVC>:/source-charset:utf-8;/execution-charset:${MECAB_DICT_CHARSET}>")
set(OTHER_CHARSET_COMPILE_OPTION "$<$<NOT:$<C_COMPILER_ID:MSVC>>:-finput-charset=UTF-8;-fexec-charset=${MECAB_DICT_CHARSET}>")
set(CHARSET_COMPILE_OPTION "${MSVC_CHARSET_COMPILE_OPTION};${OTHER_CHARSET_COMPILE_OPTION}")

add_executable(example_lattice_c example_lattice.c)
target_link_libraries(example_lattice_c PRIVATE mecab)
target_compile_options(example_lattice_c PRIVATE ${CHARSET_COMPILE_OPTION})

add_executable(example_lattice_cpp example_lattice.cpp)
target_link_libraries(example_lattice_cpp PRIVATE mecab)
target_compile_options(example_lattice_cpp PRIVATE ${CHARSET_COMPILE_OPTION})

add_executable(example_c example.c)
target_link_libraries(example_c PRIVATE mecab)
target_compile_options(example_c PRIVATE ${CHARSET_COMPILE_OPTION})

add_executable(example_cpp example.cpp)
target_link_libraries(example_cpp PRIVATE mecab)
target_compile_options(example_cpp PRIVATE ${CHARSET_COMPILE_OPTION})

add_executable(thread_test thread_test.cpp)
target_link_libraries(thread_test PRIVATE mecab)
target_compile_options(thread_test PRIVATE ${CHARSET_COMPILE_OPTION})

set_target_properties(
  example_lattice_c example_lattice_cpp example_c example_cpp thread_test
  PROPERTIES INSTALL_RPATH $<$<STREQUAL:${MECAB_LIB_TYPE},SHARED>:$ORIGIN/../lib>
)

install(
  TARGETS
  example_lattice_c
  example_lattice_cpp
  example_c
  example_cpp
  thread_test
)
