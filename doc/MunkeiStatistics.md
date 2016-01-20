# MunkeiStatistics #

```cmake
statistics(
  [EXCLUDE_DIRS ...]
  [EXECUTABLE ...]
  [OPTIONS ...]
  [REQUIRED]
)
```

Creates a target called `statistics` that prints code statistics using [cloc].

*   `EXCLUDE_DIRS` *(list, optional)*

    Directories to exclude.

*   `EXECUTABLE` *(path, optional)*

    Specify the path to `cloc`.

*   `OPTIONS` *(list, optional)*

    Additional options for `cloc`.

*   `REQUIRED` *(optional)*

    If specified, not being able to find `cloc` will cause an error.

## Requirements ##

*   [cloc] (optional)

---

  [cloc]: https://github.com/AlDanial/cloc
