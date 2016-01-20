# MunkeiWasher #

```cmake
washer(
  [EXECUTABLE ...]
  [OPTIONS ...]
  [REQUIRED]
)
```

Adds a test called `washer` that runs [Washer].

*   `EXECUTABLE` *(path, optional)*

    Specify the path to `washer`.

*   `OPTIONS` *(list, optional)*

    Additional options for `washer`.

*   `REQUIRED` *(optional)*

    If specified, not being able to find `washer` will cause an error.

## Requirements ##

*   [Washer] (optional)

---

  [Washer]: https://github.com/Munkei/Washer
