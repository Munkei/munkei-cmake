# The MIT License (MIT)
#
# Copyright (c) 2016-2017 Theo Willows
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

function( valgrind )
  set( options
    REQUIRED
    )
  set( oneValueArgs
    EXECUTABLE
    )
  set( multiValueArgs
    TARGETS
    )
  cmake_parse_arguments( ARGS
    "${options}"
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGN}
    )

  if( NOT DEFINED ARGS_TARGETS )
    message( FATAL_ERROR "[MunkeiValgrind] No targets specified" )
  endif( NOT DEFINED ARGS_TARGETS )

  if( DEFINED ARGS_EXECUTABLE )
    set( valgrind ${ARGS_EXECUTABLE} )
  else( DEFINED ARGS_EXECUTABLE )
    find_program( valgrind valgrind )
  endif( DEFINED ARGS_EXECUTABLE )

  if( valgrind )
    message( STATUS "[MunkeiValgrind] Using Valgrind (${valgrind})" )
    foreach( target ${ARGS_TARGETS} )
      set( test_name valgrind-${target} )
      message( STATUS
        "[MunkeiValgrind] Adding Valgrind test for ‘${target}’ (‘${test_name}’)"
        )
      add_test(
        NAME              ${test_name}
        COMMAND           ${valgrind}
        --quiet
        --leak-check=yes
        --errors-for-leak-kinds=all
        $<TARGET_FILE:${target}>
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        )
    endforeach( target ${ARGS_TARGETS} )
  elseif( ARGS_REQUIRED )
    message( FATAL_ERROR "[MunkeiValgrind] Could not find Valgrind" )
  else()
    message( STATUS "[MunkeiValgrind] Skipping" )
  endif()

endfunction( valgrind )
