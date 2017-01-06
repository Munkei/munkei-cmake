file( GLOB doc_files
  "${CMAKE_CURRENT_SOURCE_DIR}/*.md"
  )

set( html_dir   "${CMAKE_CURRENT_BINARY_DIR}/html" )
set( html_files )
set( mdl_config "${CMAKE_SOURCE_DIR}/.mdlrc" )

file( MAKE_DIRECTORY "${html_dir}" )

foreach( file IN LISTS doc_files )
  get_filename_component( basename "${file}" NAME )
  get_filename_component( name     "${file}" NAME_WE )

  find_program( MDL_EXECUTABLE mdl )
  add_test(
    NAME              markdown_${name}
    COMMAND           ${MDL_EXECUTABLE}
    --config "${mdl_config}"
    --warnings
    "${file}"
    WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
    )

  set( html "${html_dir}/${name}.html" )
  find_program( PANDOC_EXECUTABLE pandoc )
  add_custom_command(
    OUTPUT            ${html}
    COMMAND           ${PANDOC_EXECUTABLE}
    --from markdown_github-hard_line_breaks
    --to html5
    --output ${html}
    --data-dir "${CMAKE_SOURCE_DIR}"
    --standalone
    --table-of-contents
    --highlight-style=pygments
    --self-contained
    ${file}
    MAIN_DEPENDENCY   ${file}
    WORKING_DIRECTORY ${html_dir}
    VERBATIM
    )

  list( APPEND html_files ${html} )

  find_program( shell
    NAMES sh bash
    DOC "Shell command"
    )
  find_program( ASPELL_EXECUTABLE aspell )
  add_test(
    NAME              spellcheck_${name}
    COMMAND           "${shell}"
    -c "'${ASPELL_EXECUTABLE}' list --home-dir '${CMAKE_SOURCE_DIR}' --mode html < '${html}'"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )
  set_tests_properties( spellcheck_${name} PROPERTIES
    FAIL_REGULAR_EXPRESSION "^."
    )
endforeach( file IN LISTS doc_files )

add_custom_target( html ALL
  SOURCES ${doc_files}
  DEPENDS ${html_files}
  )
