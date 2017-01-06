# MunkeiCppcheck #

```cmake
cppcheck(
  [CPPCHECK_EXECUTABLE ...]
  [ENABLE ...]
  [FORCE]
  [INCONCLUSIVE]
  [OPTIONS ...]
  [REQUIRED]
  [SUPPRESS ...]
  [TEMPLATE ...]
)
```

Creates a test called `cppcheck` that runs [Cppcheck] in on all files, using
CMake’s `compile_commands.json`.

For details about some of the options below see Cppcheck’s documentation (e.g.
`man cppcheck`).

*   `CPPCHECK_EXECUTABLE` *(optional)*

    Specify the path to `cppcheck`.

*   `ENABLE` *(optional)*

    Corresponds to Cppcheck’s `--enable` option. Default is `all`.

*   `FORCE` *(optional)*

    Corresponds to Cppcheck’s `--force` option.

*   `INCONCLUSIVE` *(optional)*

    Corresponds to Cppcheck’s `--inconclusive` option.

*   `OPTIONS` *(list, optional)*

    Additional options for `cppcheck`.

*   `REQUIRED` *(optional)*

    If specified, not being able to find Cppcheck will be seen as an error.

*   `SUPPRESS` *(list, optional)*

    Corresponds to Cppcheck’s `--suppress` option.

*   `SUPPRESS` *(string, optional)*

    Corresponds to Cppcheck’s `--template` option.

## Requirements ##

*   [Cppcheck] (optional)

---

  [Cppcheck]: http://cppcheck.sourceforge.net
