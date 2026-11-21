# Extract Parameter Estimates

Extracts the parameter estimates of a `lavaan` object, including fixed
parameters, defined parameters, and equality and inequality constraints.

## Usage

``` r
ThetaHat(object, est = NULL)
```

## Arguments

- object:

  Object of class `lavaan`.

- est:

  Numeric vector. If not `NULL`, the parameter estimates are replaced
  with the supplied vector (one value for each row of the parameter
  table). This is used to update the values in the parameter vector
  using new estimates.

## Value

Returns a list with the following elements

- est:

  Parameter estimates.

- par_names:

  Parameter names.

- def:

  Defined parameters.

- ceq:

  Equality constraints.

- cin:

  Inequality constraints.

- fixed:

  Fixed parameters.

- free:

  Names of the free parameters.

## See also

Other Lavaan Helper Functions:
[`Lav2RAM()`](https://ijapesigan.github.io/lavHelper/reference/Lav2RAM.md),
[`RAM2Lav()`](https://ijapesigan.github.io/lavHelper/reference/RAM2Lav.md),
[`StdRAM()`](https://ijapesigan.github.io/lavHelper/reference/StdRAM.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
fit <- lavaan::sem(
  model = "mpg ~ b1 * wt",
  data = mtcars
)
ThetaHat(
  object = fit
)
#> $est
#>         b1   mpg~~mpg     wt~~wt 
#> -5.3444716  8.6975605  0.9274609 
#> 
#> $par_names
#> [1] "b1"       "mpg~~mpg" "wt~~wt"  
#> 
#> $def
#> logical(0)
#> 
#> $ceq
#> logical(0)
#> 
#> $cin
#> logical(0)
#> 
#> $fixed
#> [1] "wt~~wt"
#> 
#> $free
#> [1] "b1"       "mpg~~mpg"
#> 
```
