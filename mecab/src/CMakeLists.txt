add_library(
  mecab ${MECAB_LIB_TYPE}
  char_property.cpp
  char_property.h
  common.h
  connector.cpp
  connector.h
  context_id.cpp
  context_id.h
  darts.h
  dictionary_compiler.cpp
  dictionary_generator.cpp
  dictionary_rewriter.cpp
  dictionary_rewriter.h
  dictionary.cpp
  dictionary.h
  eval.cpp
  feature_index.cpp
  feature_index.h
  freelist.h
  iconv_utils.cpp
  iconv_utils.h
  lbfgs.cpp
  lbfgs.h
  learner_node.h
  learner_tagger.cpp
  learner_tagger.h
  learner.cpp
  libmecab.cpp
  mecab.h
  mmap.h
  nbest_generator.cpp
  nbest_generator.h
  param.cpp
  param.h
  scoped_ptr.h
  stream_wrapper.h
  string_buffer.cpp
  string_buffer.h
  tagger.cpp
  thread.h
  tokenizer.cpp
  tokenizer.h
  ucs.h
  ucstable.h
  utils.cpp
  utils.h
  viterbi.cpp
  viterbi.h
  writer.cpp
  writer.h
)
target_include_directories(mecab PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>" $<INSTALL_INTERFACE:include>)
target_compile_definitions(mecab PRIVATE HAVE_CONFIG_H MECAB_DEFAULT_RC="${CMAKE_INSTALL_PREFIX}/bin/mecabrc" DIC_VERSION=102)
target_link_libraries(
  mecab PRIVATE
  $<$<BOOL:${Iconv_FOUND}>:Iconv::Iconv>
  $<$<BOOL:${CMAKE_USE_PTHREADS_INIT}>:Threads::Threads>
  common_compiler_flags
)

if(MECAB_USE_UTF8_ONLY)
  target_compile_definitions(mecab PRIVATE MECAB_USE_UTF8_ONLY)
endif()

if(MECAB_LIB_TYPE STREQUAL "SHARED")
  target_compile_definitions(mecab PRIVATE DLL_EXPORT)
else()
  target_compile_definitions(mecab PUBLIC MECAB_LINK_STATIC)
endif()

install(TARGETS mecab)
install(FILES mecab.h DESTINATION include/mecab)

if(CMAKE_VERSION VERSION_LESS 3.27)
  file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/mecabrc" "dicdir = ${CMAKE_INSTALL_PREFIX}/bin/ipadic")
  install(FILES "${CMAKE_CURRENT_BINARY_DIR}/mecabrc" DESTINATION "${CMAKE_INSTALL_PREFIX}/bin")
else()
  install(CODE "execute_process(COMMAND ${CMAKE_COMMAND} \"-DINSTALL_PREFIX=$<INSTALL_PREFIX>\" \"-P${CMAKE_CURRENT_SOURCE_DIR}/Install.cmake\")")
endif()

add_executable(mecab-app mecab.cpp winmain.h)
set_target_properties(mecab-app PROPERTIES OUTPUT_NAME mecab)
target_link_libraries(mecab-app PRIVATE mecab common_compiler_flags)

add_executable(mecab-cost-train mecab-cost-train.cpp winmain.h)
target_link_libraries(mecab-cost-train PRIVATE mecab common_compiler_flags)

add_executable(mecab-dict-gen mecab-dict-gen.cpp winmain.h)
target_link_libraries(mecab-dict-gen PRIVATE mecab common_compiler_flags)

add_executable(mecab-dict-index mecab-dict-index.cpp winmain.h)
target_link_libraries(mecab-dict-index PRIVATE mecab common_compiler_flags)

add_executable(mecab-system-eval mecab-system-eval.cpp winmain.h)
target_link_libraries(mecab-system-eval PRIVATE mecab common_compiler_flags)

add_executable(mecab-test-gen mecab-test-gen.cpp winmain.h)
target_link_libraries(mecab-test-gen PRIVATE mecab common_compiler_flags)

set_target_properties(
  mecab-app
  mecab-cost-train
  mecab-dict-gen
  mecab-dict-index
  mecab-system-eval
  mecab-test-gen
  PROPERTIES
  EXCLUDE_FROM_ALL $<NOT:$<BOOL:${MECAB_BUILD_PROGRAMS}>>
  INSTALL_RPATH $<$<STREQUAL:${MECAB_LIB_TYPE},SHARED>:$ORIGIN/../lib>
)

if(MECAB_BUILD_PROGRAMS)
  install(
    TARGETS
    mecab-app
    mecab-cost-train
    mecab-dict-gen
    mecab-dict-index
    mecab-system-eval
    mecab-test-gen
  )
endif()
