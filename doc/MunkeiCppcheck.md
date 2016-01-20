# MunkeiCppcheck #

```cmake
cppcheck(
  [ENABLE ...]
  [EXECUTABLE ...]
  [FORCE]
  [IGNORE ...]
  [INCLUDE_DIRS ...]
  [INCONCLUSIVE]
  [OPTIONS ...]
  [REQUIRED]
  [SUPPRESS ...]
  [TEMPLATE ...]
)
```

Creates a test called `cppcheck` that runs [Cppcheck] in
`${CMAKE_CURRENT_SOURCE_DIR}`.

For details about some of the options below see Cppcheck's documentation (e.g.
`man cppcheck`).

*   `ENABLE` *(optional)*

    Corresponds to Cppcheck's `--enable` option. Default is `all`.

*   `EXECUTABLE` *(optional)*

    Specify the path to `cppcheck`.

*   `FORCE` *(optional)*

    Corresponds to Cppcheck's `--force` option.

*   `IGNORE` *(list, optional)*

    Paths to ignore. Corresponds to Cppcheck's `-i` option.

*   `INCLUDE_DIRS` *(list, optional)*

    Corresponds to Cppcheck's `-I` option.

*   `INCONCLUSIVE` *(optional)*

    Corresponds to Cppcheck's `--inconclusive` option.

*   `OPTIONS` *(list, optional)*

    Additional options for `cppcheck`.

*   `REQUIRED` *(optional)*

    If specified, not being able to find Cppcheck will be seen as an error.

*   `SUPPRESS` *(list, optional)*

    Corresponds to Cppcheck's `--suppress` option.

*   `SUPPRESS` *(string, optional)*

    Corresponds to Cppcheck's `--template` option.

## Requirements ##

*   [Cppcheck] (optional)

---

  [Cppcheck]: http://cppcheck.sourceforge.net
