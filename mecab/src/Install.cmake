cmake_path(ABSOLUTE_PATH INSTALL_PREFIX NORMALIZE OUTPUT_VARIABLE prefix)
set(mecabrc_path "${prefix}/bin/mecabrc")
message(STATUS "Installing: ${mecabrc_path}")
file(WRITE "${mecabrc_path}" "dicdir = ${prefix}/bin/ipadic")
