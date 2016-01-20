# MunkeiValgrind #

```cmake
valgrind(
  [EXECUTABLE ...]
  [REQUIRED]
  TARGETS
    <TARGETS>
)
```

Adds tests for running `<TARGETS>` through [Valgrind].

*   `EXECUTABLE` *(path, optional)*

    Specify the path to `valgrind`.

*   `REQUIRED` *(optional)*

    If specified, not being able to find `valgrind` will cause an error.

*   `TARGETS` *(list)*

    The targets to run with Valgrind.

## Requirements ##

*   [Valgrind] (optional)

---

  [Valgrind]: http://valgrind.org
