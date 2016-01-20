# MunkeiAddCompileFlags #

```cmake
add_compile_flags(
  [LANGUAGES ...]
  [LOG <YES|NO>]
  [REQUIRED]
  <FLAGS>
)
```

Adds compiler flags, a bit like `add_compile_options()` but with more options.
Without `REQUIRED`, only flags supported by the compiler (or each compiler) are
added.

*   `LANGUAGES` *(list, optional)*

    To which languages to add the flags. Default is the value of the
    `ENABLED_LANGUAGES` global property.

*   `LOG` *(boolean, optional)*

    Whether to log which flags are added, and which are not. Default is to not
    log.

*   `REQUIRED` *(optional)*

    If used, then all `FLAGS` are added, without checking whether the
    compiler(s) supports them.

*   `FLAGS` *(list)*

    The compiler flags.
