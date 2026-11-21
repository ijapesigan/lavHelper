# RAM to lavaan Matrices

Converts a list of RAM matrices to a list of `lavaan` model matrices.

## Usage

``` r
RAM2Lav(ram, lav_mod, standardized = FALSE)
```

## Arguments

- ram:

  List. A list of RAM matrices (`A`, `S`, `F`, and `M`) for one group.

- lav_mod:

  List. A list of `lavaan` model matrices for one group. They are used
  as holders of the output.

- standardized:

  Logical. If `TRUE`, the `psi` and `theta` matrices contain the
  correlations (the variances are kept). Default is `FALSE`.

## Value

Returns a list of `lavaan` model matrices for one group.

## See also

Other Lavaan Helper Functions:
[`Lav2RAM()`](https://ijapesigan.github.io/lavHelper/reference/Lav2RAM.md),
[`StdRAM()`](https://ijapesigan.github.io/lavHelper/reference/StdRAM.md),
[`ThetaHat()`](https://ijapesigan.github.io/lavHelper/reference/ThetaHat.md)

## Author

Shu Fai Cheung

## Examples

``` r
fit <- lavaan::sem(
  model = "mpg ~ wt",
  data = mtcars
)
lav_mod <- lavaan::lavInspect(
  object = fit,
  what = "est"
)
RAM2Lav(
  ram = Lav2RAM(
    lav_mod = lav_mod
  ),
  lav_mod = lav_mod
)
#> $lambda
#>     mpg wt
#> mpg   1  1
#> wt    1  1
#> 
#> $theta
#>     mpg wt
#> mpg   0  0
#> wt    0  0
#> 
#> $psi
#>          mpg        wt
#> mpg 8.697561 0.0000000
#> wt  0.000000 0.9274609
#> 
#> $beta
#>     mpg        wt
#> mpg   0 -5.344472
#> wt    0  0.000000
#> 
```
