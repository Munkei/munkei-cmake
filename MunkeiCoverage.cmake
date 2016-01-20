# The MIT License (MIT)
#
# Copyright (c) 2016 Theo Willows
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

cmake_minimum_required( VERSION 3.0.0 )

include( CMakeParseArguments )

function( enable_coverage )
  set( options
    REQUIRED
  )
  set( oneValueArgs )
  set( multiValueArgs )
  cmake_parse_arguments( ARGS
    "${options}"
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGN}
  )

  find_program( genhtml genhtml )
  find_program( lcov    lcov )
  if( genhtml AND lcov )
    message( STATUS "[MunkeiCoverage] Using genhtml (${genhtml})" )
    message( STATUS "[MunkeiCoverage] Using lcov (${lcov})"       )

    set( coverage_dir  ${CMAKE_BINARY_DIR}/coverage )
    set( tracefile     ${coverage_dir}/lcov.info    )

    file( MAKE_DIRECTORY ${coverage_dir} )

    add_custom_command(
      COMMAND           ${lcov}
                          --base-directory ${CMAKE_SOURCE_DIR}
                          --capture
                          --checksum
                          --directory ${CMAKE_BINARY_DIR}
                          --no-external
                          --output-file ${tracefile}
                          --test-name ${PROJECT_NAME}
      WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
      VERBATIM
      COMMENT           "Running lcov"
      OUTPUT            ${tracefile}
    )

    add_custom_target( coverage
      COMMAND           ${genhtml}
                          --show-details
                          --output-directory ${coverage_dir}
                          --title ${PROJECT_NAME}
                          --legend
                          ${tracefile}
      COMMENT           "Running genhtml"
      DEPENDS           ${tracefile}
      VERBATIM
      WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    )
    message( STATUS "[MunkeiCoverage] Added target ‘coverage’" )

    set( COVERAGE_ENABLED TRUE PARENT_SCOPE )
  elseif( ARGS_REQUIRED )
    message( FATAL_ERROR
      "[MunkeiCoverage] Couldn't find `genhtml` and/or `lcov`"
    )
  else()
    message( STATUS "[MunkeiCoverage] Skipping" )
  endif()
endfunction( enable_coverage )

function( coverage_target target )
  if( COVERAGE_ENABLED )
    target_compile_options( ${target} PRIVATE
      -fprofile-arcs
      -ftest-coverage
    )

    target_link_libraries( ${target}
      gcov
    )

    set( target_name coverage-measure-${target} )
    add_custom_target( ${target_name}
      COMMAND           ${target} || true
      COMMENT           "Measuring coverage of ‘${target}’"
      VERBATIM
      WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    )
    add_dependencies( coverage ${target_name} )
  endif( COVERAGE_ENABLED )
endfunction( coverage_target )
