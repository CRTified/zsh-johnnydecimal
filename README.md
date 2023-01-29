# zsh-johnnydecimal

Collection of zsh functions to work with Johnny.Decimal document hierachies
More info can be found at https://johnnydecimal.com/


## Installation

  * Set the environment variable `JOHNNYDECIMAL_BASE` to the base directory
	* If this is not set, it will default to `~/johnny`
  * `source johnnydecimal.zsh`

### NixOS + Home-Manager

Add the following input to your `flake.nix`:

``` nix
inputs = { 
  zsh-johnnydecimal.url = "github:CRTified/zsh-johnnydecimal";
};
```

Then, add `zsh-johnnydecimal.zshPlugin` to your home-manager 
`programs.zsh.plugins` list and add the appropriate session variable, e.g.:

``` nix

home.sessionVariables = {
  # Path to johnny.decimal basedir
  "JOHNNYDECIMAL_BASE" = "~/johnny/";
}
```

Don't forget to change the path.

## Functions

### `jcd`

```
jcd CATEGORY.UNIQUE
```

Changes the active directory to `CATEGORY.UNIQUE` with `pushd`.
Going back to the original directory can be done with `popd`.

### `jcp`

```
jcd CATEGORY.UNIQUE SRC [SRC [SRC ...]]
```

Copies `SRC` to `CATEGORY.UNIQUE`.

### `jmv`

```
jcd CATEGORY.UNIQUE SRC [SRC [SRC ...]]
```

Moves `SRC` to `CATEGORY.UNIQUE`.

### `jmkarea`

```
jmkarea CATEGORY DESC
```

Creates the area for `CATEGORY`, using the given description.
`CATEGORY` can be any index within the desired area.

### `jmkcat`

```
jmkcat CATEGORY DESC
```

Creates the category `CATEGORY` with the given description.

### `jmkuni`

``` shell
jmkuni CATEGORY.UNIQUE DESC
```

Creates the unique folder `CATEGORY.UNIQUE` with the given description.

### `jwd`

``` shell
jwd CATEGORY.UNIQUE CMD [ARG [ARG [ARG ...]]]
```

Executes `CMD [ARG [ARG [ARG ...]]]` inside the directory for `CATEGORY.UNIQUE`.

## Example

### Setup of Example Environment
``` shell
$ export JOHNNYDECIMAL_BASE=/tmp/jd
$ find $JOHNNYDECIMAL_BASE
# Nothing here
```

### Hierachy creation

``` shell
$ jmkarea 10 Finance
mkdir: created directory '/tmp/jd/10-19 Finance'

$ jmkarea 20 Administration
mkdir: created directory '/tmp/jd/20-29 Administration'

$ jmkcat 21 "Company Registration"
mkdir: created directory '/tmp/jd/20-29 Administration/21 Company Registration'

$ jmkcat 22 Contracts
mkdir: created directory '/tmp/jd/20-29 Administration/22 Contracts'

$ jmkuni 22.01 "Cleaning contract"
mkdir: created directory '/tmp/jd/20-29 Administration/22 Contracts/22.01 Cleaning contract'

$ jmkuni 22.02 "Office Lease"
mkdir: created directory '/tmp/jd/20-29 Administration/22 Contracts/22.02 Office Lease'

```

The resulting file structure is

``` shell
$ find $JOHNNYDECIMAL_BASE
/tmp/jd
/tmp/jd/20-29 Administration
/tmp/jd/20-29 Administration/22 Contracts
/tmp/jd/20-29 Administration/22 Contracts/22.02 Office Lease
/tmp/jd/20-29 Administration/22 Contracts/22.01 Cleaning contract
/tmp/jd/20-29 Administration/21 Company Registration
/tmp/jd/10-19 Finance
```

### Adding Files

``` shell
$ pwd
~/example
$ ls
'Security bond details.xlsx'  'Signed lease agreement.pdf'  'Terms & conditions.doc'

$ jcp 22.02 Security\ bond\ details.xlsx Signed\ lease\ agreement.pdf
'Security bond details.xlsx' -> '/tmp/jd/20-29 Administration/22 Contracts/22.02 Office Lease/Security bond details.xlsx'
'Signed lease agreement.pdf' -> '/tmp/jd/20-29 Administration/22 Contracts/22.02 Office Lease/Signed lease agreement.pdf'

$ jmv 22.02 Terms\ \&\ conditions.doc Signed\ lease\ agreement.pdf
copied 'Terms & conditions.doc' -> '/tmp/jd/20-29 Administration/22 Contracts/22.02 Office Lease/Terms & conditions.doc'
removed 'Terms & conditions.doc'

# Note that it only copied the first file - not the second one, as that already exists
$ ls
'Security bond details.xlsx'  'Signed lease agreement.pdf'
$ find $JOHNNYDECIMAL_BASE
/tmp/jd
/tmp/jd/20-29 Administration
/tmp/jd/20-29 Administration/22 Contracts
/tmp/jd/20-29 Administration/22 Contracts/22.02 Office Lease
/tmp/jd/20-29 Administration/22 Contracts/22.02 Office Lease/Terms & conditions.doc
/tmp/jd/20-29 Administration/22 Contracts/22.02 Office Lease/Signed lease agreement.pdf
/tmp/jd/20-29 Administration/22 Contracts/22.02 Office Lease/Security bond details.xlsx
/tmp/jd/20-29 Administration/22 Contracts/22.01 Cleaning contract
/tmp/jd/20-29 Administration/21 Company Registration
/tmp/jd/10-19 Finance
```

### Navigating

``` shell
$ pwd
~/example
$ jcd 22.02
/tmp/jd/20-29 Administration/22 Contracts/22.02 Office Lease ~/example
$ ls
'Security bond details.xlsx'  'Signed lease agreement.pdf'  'Terms & conditions.doc'
$ pwd
/tmp/jd/20-29 Administration/22 Contracts/22.02 Office Lease
$ popd
~/example
$ pwd
~/example
```
