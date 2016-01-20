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

function( cppcheck )
  set( options
    FORCE
    INCONCLUSIVE
    REQUIRED
  )
  set( oneValueArgs
    ENABLE
    EXECUTABLE
    TEMPLATE
  )
  set( multiValueArgs
    IGNORE
    INCLUDE_DIRS
    OPTIONS
    SUPPRESS
  )
  cmake_parse_arguments( ARGS
    "${options}"
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGN}
  )

  if( DEFINED ARGS_EXECUTABLE )
    set( cppcheck ${ARGS_EXECUTABLE} )
  else( DEFINED ARGS_EXECUTABLE )
    find_program( cppcheck cppcheck )
  endif( DEFINED ARGS_EXECUTABLE )

  if( cppcheck )
    message( STATUS "[MunkeiCppcheck] Using Cppcheck: ${cppcheck}" )

    if( NOT ARGS_ENABLE )
      set( ARGS_ENABLE all )
    endif( NOT ARGS_ENABLE )

    set( options
      --enable=${ARGS_ENABLE}
      --error-exitcode=2
      --inline-suppr
    )

    if( ARGS_FORCE )
      set( options ${options} --force )
    endif( ARGS_FORCE )

    if( ARGS_INCONCLUSIVE )
      set( options ${options} --inconclusive )
    endif( ARGS_INCONCLUSIVE )

    foreach( dir ${ARGS_IGNORE} )
      set( options ${options} -i "${dir}" )
    endforeach( dir ${ARGS_IGNORE} )

    foreach( dir ${ARGS_INCLUDE_DIRS} )
      set( options ${options} -I "${dir}" )
    endforeach( dir ${ARGS_INCLUDE_DIRS} )

    foreach( suppress ${ARGS_SUPPRESS} )
      set( options ${options} --suppress=${suppress} )
    endforeach( suppress ${ARGS_SUPPRESS} )

    foreach( option ${ARGS_OPTIONS} )
      set( options ${options} ${option} )
    endforeach( option ${ARGS_OPTIONS} )

    if( DEFINED ARGS_TEMPLATE )
      set( options ${options} --template=${ARGS_TEMPLATE} )
    endif( DEFINED ARGS_TEMPLATE )

    message( STATUS "[MunkeiCppcheck] Adding test ‘cppcheck’" )
    add_test(
      NAME              cppcheck
      COMMAND           ${cppcheck}
                          ${options}
                          .
      WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    )
  elseif( ARGS_REQUIRED )
    message( FATAL_ERROR "[MunkeiCppcheck] Could not find Cppcheck" )
  else()
    message( STATUS "[MunkeiCppcheck] Skipping Cppcheck" )
  endif()
endfunction( cppcheck )
