# lavaan to RAM Matrices

Converts a list of `lavaan` model matrices to a list of RAM matrices.

## Usage

``` r
Lav2RAM(lav_mod)
```

## Arguments

- lav_mod:

  List. A list of `lavaan` model matrices for one group (for example,
  the output of `lavaan::lavInspect(object, what = "est")` for a single
  group model).

## Value

Returns a list of the `A`, `S`, `F`, and `M` RAM matrices.

## See also

Other Lavaan Helper Functions:
[`RAM2Lav()`](https://ijapesigan.github.io/lavHelper/reference/RAM2Lav.md),
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
Lav2RAM(
  lav_mod = lavaan::lavInspect(
    object = fit,
    what = "est"
  )
)
#> $A
#>     mpg        wt
#> mpg   0 -5.344472
#> wt    0  0.000000
#> 
#> $S
#>          mpg        wt
#> mpg 8.697561 0.0000000
#> wt  0.000000 0.9274609
#> 
#> $F
#>     mpg wt
#> mpg   1  0
#> wt    0  1
#> 
#> $M
#>      mpg wt
#> [1,]   0  0
#> 
```
