# MunkeiTags #

```cmake
tags(
  [EXECUTABLE ...]
  [REQUIRED]
)
```

Creates a target called `TAGS` that runs [Exuberant Ctags] in
`${CMAKE_CURRENT_SOURCE_DIR}`.

*   `EXECUTABLE` *(path, optional)*

    Specify the path to `ctags`.

*   `REQUIRED` *(optional)*

    If specified, not being able to find `ctags` will cause an error.

## Requirements ##

*   [Exuberant Ctags] (optional)

---

  [Exuberant Ctags]: http://ctags.sourceforge.net
