# MunkeiVersionFromGit #

```cmake
version_from_git(
  [GIT_EXECUTABLE ...]
  [INCLUDE_HASH ...]
  [LOG ...]
  [TIMESTAMP ...]
)
```

Gets the version information from [Git].

*   `GIT_EXECUTABLE` *(optional)*

    The name of, or full path to, Git. If not defined it will be found using
    `find_package( Git )`.

*   `INCLUDE_HASH` *(boolean, optional)*

    Whether to include the current Git hash as part of the meta data, *if* the
    current HEAD is *not* at a tag, à la `git describe`.

    Default: `ON`

*   `LOG` *(boolean, optional)*

    Whether to log the different parts obtained from Git.

    Default: `OFF`

*   `TIMESTAMP` *(string, optional)*

    A time-stamp format (see CMake’s `string( TIMESTAMP ... )`), that, if
    defined, will be added as a part of the meta data.

## Variables Set ##

*   `GIT_TAG`

    The current (latest) Git tag.

*   `SEMVER`

    The full semantic version, including identifiers and meta data.

*   `VERSION`

    The full three-part version, suitable for use with `project()`.

*   `VERSION_MAJOR`

    The major version number.

*   `VERSION_MINOR`

    The minor version number.

*   `VERSION_PATCH`

    The patch version number.

## Example ##

```cmake
include( MunkeiVersionFromGit )

# Use it
version_from_git(
  LOG       ON
  TIMESTAMP "%Y%m%d%H%M%S"
)

# Use `VERSION` for your project
project( MyProject
  VERSION ${VERSION}
)

# Use the full semantic version for things like package name, etc.
set( CPACK_PACKAGE_FILE_NAME MyProject-v${SEMVER} )
```

## Requirements ##

*   [Git]

---

  [Git]: https://git-scm.com
