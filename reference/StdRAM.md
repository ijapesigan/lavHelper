# Standardized Solution from RAM Matrices

Computes the standardized solution from RAM matrices.

## Usage

``` r
StdRAM(ram_est)
```

## Arguments

- ram_est:

  List. A list of RAM matrices (`A`, `S`, `F`, and `M`) for one group
  with unstandardized estimates.

## Value

Returns a list of RAM matrices with the standardized solution.

## Details

Standardized solution for the means is not yet supported (the
standardized `M` matrix is set to zero).

## See also

Other Lavaan Helper Functions:
[`Lav2RAM()`](https://ijapesigan.github.io/lavHelper/reference/Lav2RAM.md),
[`RAM2Lav()`](https://ijapesigan.github.io/lavHelper/reference/RAM2Lav.md),
[`ThetaHat()`](https://ijapesigan.github.io/lavHelper/reference/ThetaHat.md)

## Author

Shu Fai Cheung

## Examples

``` r
fit <- lavaan::sem(
  model = "mpg ~ wt",
  data = mtcars
)
StdRAM(
  ram_est = Lav2RAM(
    lav_mod = lavaan::lavInspect(
      object = fit,
      what = "est"
    )
  )
)
#> $A
#>     mpg         wt
#> mpg   0 -0.8676594
#> wt    0  0.0000000
#> 
#> $S
#>           mpg wt
#> mpg 0.2471672  0
#> wt  0.0000000  1
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
