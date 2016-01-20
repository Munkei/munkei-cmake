# MunkeiCoverage #

Creates a code coverage report, using [gcov]/[LCOV].

Call `enable_coverage()` once. Then for each target that should be included in
the measuring run `coverage_target()`.

## `enable_coverage()` ##

```cmake
enable_coverage(
  [REQUIRED]
)
```

Enables coverage. Adds a target called `coverage` that does the measuring and
produces the report.

*   `REQUIRED` *(optional)*

    If specified, not being able to find `genhtml` or `lcov` will cause an
    error.

## `coverage_target()` ##

```cmake
coverage_target(
  <TARGET>
)
```

Includes a target (`<TARGET>`) among those measured.

**Note** that `enable_coverage()` must have been called *before*.

## Requirements ##

*   [gcov] (optional)
*   [LCOV] (optional)

---

  [gcov]: https://gcc.gnu.org/onlinedocs/gcc/Gcov.html

  [LCOV]: http://ltp.sourceforge.net/coverage/lcov.php
