# zsh-johnnydecimal

Collection of zsh functions to work with Johnny.Decimal document hierachies
More info can be found at https://johnnydecimal.com/

## Functions

### `jcd`

```
jcd AREA CAT
```

Changes the active directory to `AREA.CATEGORY` with `pushd`.
Going back to the original directory can be done with `popd`.

### `jcp`

```
jcd AREA CAT SRC [SRC [SRC ...]]
```

Copies `SRC` to `AREA.CATEGORY`, adding the next index in front of the name.

### `jmv`

```
jcd AREA CAT SRC [SRC [SRC ...]]
```

Moves `SRC` to `AREA.CATEGORY`, adding the next index in front of the name.

### `jmkdir`

```
jmkdir AREA DESC
jmkdir AREA CAT DESC
```

Creates either `AREA` or `AREA.CAT` subfolders with the supplied (short) description.
