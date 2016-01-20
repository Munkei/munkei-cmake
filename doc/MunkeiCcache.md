# MunkeiCcache #

```cmake
ccache(
  [EXECUTABLE ...]
  [REQUIRED]
)
```

Adds [ccache] to compilation, if available.

*   `EXECUTABLE` *(optional)*

    Specifies the path to `ccache`.

*   `REQUIRED` *(optional)*

    If present then the inability to find `ccache` will generate an error.

## Requirements ##

*   [ccache] (optional)

---

  [ccache]: https://ccache.samba.org
