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

function( cppcheck )
  set( options
    FORCE
    INCONCLUSIVE
    REQUIRED
    )
  set( oneValueArgs
    CPPCHECK_EXECUTABLE
    ENABLE
    NAME
    TEMPLATE
    )
  set( multiValueArgs
    OPTIONS
    SUPPRESS
    )
  cmake_parse_arguments( ARGS
    "${options}"
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGN}
    )

  set( CMAKE_EXPORT_COMPILE_COMMANDS ON PARENT_SCOPE )

  if( DEFINED ARGS_CPPCHECK_EXECUTABLE )
    set( CPPCHECK_EXECUTABLE ${ARGS_CPPCHECK_EXECUTABLE} )
  else( DEFINED ARGS_CPPCHECK_EXECUTABLE )
    find_program( CPPCHECK_EXECUTABLE cppcheck )
  endif( DEFINED ARGS_CPPCHECK_EXECUTABLE )

  if( CPPCHECK_EXECUTABLE )
    message( STATUS "[MunkeiCppcheck] Using Cppcheck: ${CPPCHECK_EXECUTABLE}" )

    if( NOT ARGS_ENABLE )
      set( ARGS_ENABLE all )
    endif( NOT ARGS_ENABLE )

    set( options
      --enable=${ARGS_ENABLE}
      --error-exitcode=2
      --inline-suppr
      --project=${CMAKE_BINARY_DIR}/compile_commands.json
      )

    if( ARGS_FORCE )
      set( options ${options} --force )
    endif( ARGS_FORCE )

    if( ARGS_INCONCLUSIVE )
      set( options ${options} --inconclusive )
    endif( ARGS_INCONCLUSIVE )

    foreach( suppress ${ARGS_SUPPRESS} )
      set( options ${options} --suppress=${suppress} )
    endforeach( suppress ${ARGS_SUPPRESS} )

    if( DEFINED ARGS_TEMPLATE )
      set( options ${options} --template=${ARGS_TEMPLATE} )
    endif( DEFINED ARGS_TEMPLATE )

    foreach( option ${ARGS_OPTIONS} )
      set( options ${options} ${option} )
    endforeach( option ${ARGS_OPTIONS} )

    if( DEFINED ARGS_NAME )
      set( name ${ARGS_NAME} )
    else( DEFINED ARGS_NAME )
      set( name cppcheck )
    endif( DEFINED ARGS_NAME )

    message( STATUS "[MunkeiCppcheck] Adding test ‘${name}’" )
    add_test(
      NAME              ${name}
      COMMAND           ${CPPCHECK_EXECUTABLE}
      ${options}
      .
      WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
      )
  elseif( ARGS_REQUIRED )
    message( FATAL_ERROR "[MunkeiCppcheck] Could not find Cppcheck" )
  else( CPPCHECK_EXECUTABLE )
    message( STATUS "[MunkeiCppcheck] Skipping Cppcheck" )
  endif( CPPCHECK_EXECUTABLE )

  set( CPPCHECK_EXECUTABLE ${CPPCHECK_EXECUTABLE} PARENT_SCOPE )
endfunction( cppcheck )
