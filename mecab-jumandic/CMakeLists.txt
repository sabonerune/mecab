set(COMPILED_DICTIONARY_DIR "${CMAKE_CURRENT_BINARY_DIR}/jumandic")
add_custom_command(
  OUTPUT
  jumandic/char.bin
  jumandic/matrix.bin
  jumandic/model.bin
  jumandic/sys.dic
  jumandic/unk.dic
  jumandic/dicrc
  jumandic/char.def
  jumandic/feature.def
  jumandic/left-id.def
  jumandic/matrix.def
  jumandic/model.def
  jumandic/pos-id.def
  jumandic/rewrite.def
  jumandic/right-id.def
  jumandic/unk.def
  jumandic/COPYING
  COMMAND ${CMAKE_COMMAND} -E make_directory "${COMPILED_DICTIONARY_DIR}"
  COMMAND mecab-dict-index -d . -o "${COMPILED_DICTIONARY_DIR}" --dictionary-charset UTF-8 --charset "${MECAB_DICT_CHARSET}"
  COMMAND ${CMAKE_COMMAND} -E copy_if_different dicrc "${COMPILED_DICTIONARY_DIR}"
  COMMAND ${CMAKE_COMMAND} -E copy_if_different char.def "${COMPILED_DICTIONARY_DIR}"
  COMMAND ${CMAKE_COMMAND} -E copy_if_different feature.def "${COMPILED_DICTIONARY_DIR}"
  COMMAND ${CMAKE_COMMAND} -E copy_if_different left-id.def "${COMPILED_DICTIONARY_DIR}"
  COMMAND ${CMAKE_COMMAND} -E copy_if_different matrix.def "${COMPILED_DICTIONARY_DIR}"
  COMMAND ${CMAKE_COMMAND} -E copy_if_different model.def "${COMPILED_DICTIONARY_DIR}"
  COMMAND ${CMAKE_COMMAND} -E copy_if_different pos-id.def "${COMPILED_DICTIONARY_DIR}"
  COMMAND ${CMAKE_COMMAND} -E copy_if_different rewrite.def "${COMPILED_DICTIONARY_DIR}"
  COMMAND ${CMAKE_COMMAND} -E copy_if_different right-id.def "${COMPILED_DICTIONARY_DIR}"
  COMMAND ${CMAKE_COMMAND} -E copy_if_different unk.def "${COMPILED_DICTIONARY_DIR}"
  COMMAND ${CMAKE_COMMAND} -E copy_if_different COPYING "${COMPILED_DICTIONARY_DIR}"
  DEPENDS
  dicrc
  char.def
  feature.def
  left-id.def
  matrix.def
  model.def
  pos-id.def
  rewrite.def
  right-id.def
  unk.def
  Assert.csv
  Auto.csv
  AuxV.csv
  ContentW.csv
  Demonstrative.csv
  Emoticon.csv
  Noun.hukusi.csv
  Noun.keishiki.csv
  Noun.koyuu.csv
  Noun.suusi.csv
  Postp.csv
  Prefix.csv
  Rengo.csv
  Special.csv
  Suffix.csv
  Wikipedia.csv
  COPYING
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)
add_custom_target(
  mecab-jumandic ALL
  DEPENDS
  jumandic/char.bin
  jumandic/matrix.bin
  jumandic/model.bin
  jumandic/sys.dic
  jumandic/unk.dic
  jumandic/dicrc
  jumandic/char.def
  jumandic/feature.def
  jumandic/left-id.def
  jumandic/matrix.def
  jumandic/model.def
  jumandic/pos-id.def
  jumandic/rewrite.def
  jumandic/right-id.def
  jumandic/unk.def
  jumandic/COPYING
)
install(DIRECTORY "${COMPILED_DICTIONARY_DIR}" TYPE BIN)
