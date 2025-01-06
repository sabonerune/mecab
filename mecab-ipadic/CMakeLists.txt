set(COMPILED_DICTIONARY_DIR "${CMAKE_CURRENT_BINARY_DIR}/ipadic")
add_custom_command(
  OUTPUT
  ipadic/char.bin
  ipadic/matrix.bin
  ipadic/sys.dic
  ipadic/unk.dic
  ipadic/dicrc
  ipadic/COPYING
  COMMAND ${CMAKE_COMMAND} -E make_directory "${COMPILED_DICTIONARY_DIR}"
  COMMAND mecab-dict-index -d . -o "${COMPILED_DICTIONARY_DIR}" --dictionary-charset EUC-JP --charset "${MECAB_DICT_CHARSET}"
  COMMAND ${CMAKE_COMMAND} -E copy_if_different dicrc "${COMPILED_DICTIONARY_DIR}"
  COMMAND ${CMAKE_COMMAND} -E copy_if_different COPYING "${COMPILED_DICTIONARY_DIR}"
  DEPENDS
  dicrc
  char.def
  matrix.def
  unk.def
  Adj.csv
  Adnominal.csv
  Adverb.csv
  Auxil.csv
  Conjunction.csv
  Filler.csv
  Interjection.csv
  Noun.adjv.csv
  Noun.adverbal.csv
  Noun.csv
  Noun.demonst.csv
  Noun.nai.csv
  Noun.name.csv
  Noun.number.csv
  Noun.org.csv
  Noun.others.csv
  Noun.place.csv
  Noun.proper.csv
  Noun.verbal.csv
  Others.csv
  Postp-col.csv
  Postp.csv
  Prefix.csv
  Suffix.csv
  Symbol.csv
  Verb.csv
  COPYING
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)
add_custom_target(
  mecab-ipadic ALL
  DEPENDS
  ipadic/dicrc
  ipadic/char.bin
  ipadic/matrix.bin
  ipadic/sys.dic
  ipadic/unk.dic
  ipadic/COPYING
)
install(DIRECTORY "${COMPILED_DICTIONARY_DIR}" TYPE BIN)
