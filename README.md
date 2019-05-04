# zsh-johnnydecimal

Collection of zsh functions to work with Johnny.Decimal document hierachies
More info can be found at https://johnnydecimal.com/

File Hiearchy example:
```
10-19 Area
\-- 10 Category
    \-- Object
\-- 11 Category
    \-- Object
\-- 12 Category
    \-- Object
```

## Installation

  * Set the environment variable `JOHNNYDECIMAL_BASE` to the base directory
	* If this is not set, it will default to `~/johnny`
  * `source johnnydecimal.zsh`

## Functions

### `jcd`

```
jcd AREA.CATEGORY
```

Changes the active directory to `AREA.CATEGORY` with `pushd`.
Going back to the original directory can be done with `popd`.

### `jcp`

```
jcd AREA.CATEGORY SRC [SRC [SRC ...]]
```

Copies `SRC` to `AREA.CATEGORY`.

### `jmv`

```
jcd AREA CAT SRC [SRC [SRC ...]]
```

Moves `SRC` to `AREA.CATEGORY`.
