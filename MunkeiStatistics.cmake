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

function( statistics )
  set( options
    REQUIRED
  )
  set( oneValueArgs
    EXECUTABLE
  )
  set( multiValueArgs
    EXCLUDE_DIRS
    OPTIONS
  )
  cmake_parse_arguments( ARGS
    "${options}"
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGN}
  )

  if( DEFINED ARGS_EXECUTABLE )
    set( cloc ${ARGS_EXECUTABLE} )
  else( DEFINED ARGS_EXECUTABLE )
    find_program( cloc cloc )
  endif( DEFINED ARGS_EXECUTABLE )

  if( cloc )
    message( STATUS "[MunkeiStatistics] Using cloc: ${cloc}" )

    set( options )

    foreach( dir ${ARGS_EXCLUDE_DIRS} )
      set( options ${options} "--exclude-dir=${dir}" )
    endforeach( dir ${ARGS_EXCLUDE_DIRS} )

    if( ARGS_OPTIONS )
      set( options ${options} ${ARGS_OPTIONS} )
    endif( ARGS_OPTIONS )

    message( STATUS "[MunkeiStatistics] Adding target ‘statistics’" )
    add_custom_target( statistics
      COMMAND           ${cloc}
                          ${options}
                          .
      WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    )
  elseif( ARGS_REQUIRED )
    message( FATAL_ERROR "[MunkeiStatistics] Could not find cloc" )
  else()
    message( STATUS "[MunkeiStatistics] Skipping" )
  endif()
endfunction( statistics )
