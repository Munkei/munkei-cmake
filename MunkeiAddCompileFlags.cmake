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

include( CheckCCompilerFlag       )
include( CheckCXXCompilerFlag     )
include( CMakeParseArguments      )

function( add_compile_flags )
  set( options
    REQUIRED
  )
  set( oneValueArgs
    LOG
  )
  set( multiValueArgs
    LANGUAGES
  )
  cmake_parse_arguments( ARGS
    "${options}"
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGN}
  )

  if( NOT DEFINED ARGS_LANGUAGES )
    get_property( ARGS_LANGUAGES GLOBAL PROPERTY ENABLED_LANGUAGES )
  endif( NOT DEFINED ARGS_LANGUAGES )

  foreach( lang ${ARGS_LANGUAGES} )
    foreach( flag ${ARGS_UNPARSED_ARGUMENTS} )
      set( should ${ARGS_REQUIRED} )

      if( NOT ${should} )
        set( CMAKE_REQUIRED_QUIET YES )
        if( "${lang}" STREQUAL C )
          check_c_compiler_flag( "${flag}" supported )
        elseif( "${lang}" STREQUAL CXX )
          check_cxx_compiler_flag( "${flag}" supported )
        else()
          message( FATAL_ERROR
            "[MunkeiAddCompileFlags] Unsupported language ‘${lang}’"
          )
        endif()

        if( supported )
          set( should YES )
        elseif( ${ARGS_LOG} )
          message( STATUS
            "[MunkeiAddCompileFlags] Flag ‘${flag}’ unsupported for language ${lang}"
          )
        endif()
        unset( supported CACHE )
      endif( NOT ${should} )

      if( ${should} )
        if( ${ARGS_LOG} )
          message( STATUS
            "[MunkeiAddCompileFlags] Adding flag ‘${flag}’ for language ${lang}"
          )
        endif( ${ARGS_LOG} )

        set( CMAKE_${lang}_FLAGS "${CMAKE_${lang}_FLAGS} ${flag}" )
      endif( ${should} )
    endforeach()

    set( CMAKE_${lang}_FLAGS ${CMAKE_${lang}_FLAGS} PARENT_SCOPE )
  endforeach()

endfunction( add_compile_flags )
