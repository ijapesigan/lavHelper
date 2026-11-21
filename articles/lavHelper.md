# lavHelper: Helper Functions for lavaan Models

## Description

Helper functions for `lavaan` models (R Core Team, 2026): conversion
between `lavaan` model matrices and reticular action model (RAM)
matrices, the standardized solution from RAM matrices, and the parameter
estimates of a fitted model including fixed parameters, defined
parameters, and constraints.

## Installation

You can install the development version of `lavHelper` from
[GitHub](https://github.com/ijapesigan/lavHelper) with:

\
`if`` ``(``!`[`require`](https://rdrr.io/r/base/library.html)`(`[`"pak"`](https://pak.r-lib.org/)`)``)`` `[`install.packages`](https://rdrr.io/r/utils/install.packages.html)`(``"pak"``)`\
`pak``::`[`pkg_install`](https://pak.r-lib.org/reference/pkg_install.html)`(``"ijapesigan/lavHelper"``)`

## Example

\
[`library`](https://rdrr.io/r/base/library.html)`(``package ``=`` ``"lavHelper"``)`

A regression of `mpg` on `wt` and `disp` fitted with `lavaan`.

\
`fit`` ``<-`` ``lavaan``::`[`sem`](https://rdrr.io/pkg/lavaan/man/sem.html)`(`\
`  model ``=`` ``"mpg ~ b1 * wt + b2 * disp"``,`\
`  data ``=`` ``mtcars`\
`)`\
`lav_mod`` ``<-`` ``lavaan``::`[`lavInspect`](https://rdrr.io/pkg/lavaan/man/lavInspect.html)`(`\
`  object ``=`` ``fit``,`\
`  what ``=`` ``"est"`\
`)`

[`Lav2RAM()`](https://ijapesigan.github.io/lavHelper/reference/Lav2RAM.md)
converts the `lavaan` model matrices to RAM matrices.

\
`ram`` ``<-`` `[`Lav2RAM`](https://ijapesigan.github.io/lavHelper/reference/Lav2RAM.md)`(`\
`  lav_mod ``=`` ``lav_mod`\
`)`\
`ram``$``A`\
`#>      mpg        wt        disp`\
`#> mpg    0 -3.350825 -0.01772474`\
`#> wt     0  0.000000  0.00000000`\
`#> disp   0  0.000000  0.00000000`

[`StdRAM()`](https://ijapesigan.github.io/lavHelper/reference/StdRAM.md)
gives the standardized solution.

\
[`StdRAM`](https://ijapesigan.github.io/lavHelper/reference/StdRAM.md)`(`\
`  ram_est ``=`` ``ram`\
`)``$``A`\
`#>      mpg         wt       disp`\
`#> mpg    0 -0.5439967 -0.3644932`\
`#> wt     0  0.0000000  0.0000000`\
`#> disp   0  0.0000000  0.0000000`

[`RAM2Lav()`](https://ijapesigan.github.io/lavHelper/reference/RAM2Lav.md)
converts RAM matrices back to `lavaan` model matrices.

\
[`RAM2Lav`](https://ijapesigan.github.io/lavHelper/reference/RAM2Lav.md)`(`\
`  ram ``=`` ``ram``,`\
`  lav_mod ``=`` ``lav_mod`\
`)``$``beta`\
`#>      mpg        wt        disp`\
`#> mpg    0 -3.350825 -0.01772474`\
`#> wt     0  0.000000  0.00000000`\
`#> disp   0  0.000000  0.00000000`

[`ThetaHat()`](https://ijapesigan.github.io/lavHelper/reference/ThetaHat.md)
extracts the parameter estimates, including the fixed parameters.

\
[`ThetaHat`](https://ijapesigan.github.io/lavHelper/reference/ThetaHat.md)`(`\
`  object ``=`` ``fit`\
`)``$``est`\
`#>            b1            b2      mpg~~mpg        wt~~wt      wt~~disp `\
`#> -3.350825e+00 -1.772474e-02  7.708828e+00  9.274609e-01  1.043191e+02 `\
`#>    disp~~disp `\
`#>  1.488077e+04`

## References

R Core Team. (2026). *R: A language and environment for statistical
computing*. R Foundation for Statistical Computing.
<https://www.R-project.org/>
