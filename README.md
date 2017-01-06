# Munkei's CMake Modules #

[![GitHub license](https://img.shields.io/github/license/Munkei/munkei-cmake.svg?style=flat-square)](https://github.com/Munkei/munkei-cmake/blob/master/LICENSE.md)

---

## Modules ##

*   **[MunkeiAddCompileFlags]**

    Add compiler flags for specific languages, but skip flags not supported by
    the compiler.

*   **[MunkeiCcache]**

    Use [ccache].

*   **[MunkeiCoverage]**

    Create a code coverage report, using [gcov]/[LCOV].

*   **[MunkeiCppcheck]**

    Make a test that runs [Cppcheck].

*   **[MunkeiStatistics]**

    Make a target that prints some code statistics, using [cloc].

*   **[MunkeiTags]**

    Make a target that generates tags, using [Exuberant Ctags].

*   **[MunkeiValgrind]**

    Adds tests for running targets through [Valgrind].

*   **[MunkeiVersionFromGit]**

    Get version-related data from [Git] tags.

*   **[MunkeiWasher]**

    Make a test that runs [Washer].

`Munkei.cmake` adds its parent directory to CMake's module loading logic, so if
you use:

```cmake
include( path/to/munkei-cmake/Munkei.cmake )
```

Then each module can be `include()`d using just its name.

## Requirements ##

*   CMake v3.0.0 or later

## License ##

The MIT License (MIT)

Copyright (c) 2016-2017 Theo Willows

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

---

  [ccache]: https://ccache.samba.org

  [cloc]: https://github.com/AlDanial/cloc

  [Cppcheck]: http://cppcheck.sourceforge.net

  [Exuberant Ctags]: http://ctags.sourceforge.net

  [gcov]: https://gcc.gnu.org/onlinedocs/gcc/Gcov.html

  [Git]: https://git-scm.com

  [LCOV]: http://ltp.sourceforge.net/coverage/lcov.php

  [MunkeiAddCompileFlags]: doc/MunkeiAddCompileFlags.md

  [MunkeiCcache]: doc/MunkeiCcache.md

  [MunkeiCoverage]: doc/MunkeiCoverage.md

  [MunkeiCppcheck]: doc/MunkeiCppcheck.md

  [MunkeiStatistics]: doc/MunkeiStatistics.md

  [MunkeiTags]: doc/MunkeiTags.md

  [MunkeiVersionFromGit]: doc/MunkeiVersionFromGit.md

  [MunkeiValgrind]: doc/MunkeiValgrind.md

  [MunkeiWasher]: doc/MunkeiWasher.md

  [Valgrind]: http://valgrind.org

  [Washer]: https://github.com/Munkei/Washer
