#import "cubic-spline.typ": *
#import "linear-algebra.typ": *

/// --- Main Calculation Function ---\
/// Calculates derivatives for non-uniform data using moving least squares.\
/// data: array of (x, y) tuples\
/// order: derivative order (1, 2, or 3)\
/// window: number of neighbors to include (odd integer). Higher = smoother.\
/// degree: degree of fitting polynomial (must be >= order).
#let diff-smooth(data, order: 1, window: 7, degree: 3) = {
  assert(window >= degree + 1, message: "Window must be larger than degree.")
  assert(
    degree >= order,
    message: "Degree must be >= requested derivative order.",
  )

  let result = ()
  let half-win = calc.floor(window / 2)
  let n = data.len()

  for i in range(n) {
    // 1. Identify Window Indices (clamp to edges)
    let start-idx = calc.max(0, i - half-win)
    let end-idx = calc.min(n, start-idx + window)

    // Adjust start if we hit the right edge to keep window size constant-ish
    if (end-idx - start-idx < window) and (start-idx > 0) {
      start-idx = calc.max(0, end-idx - window)
    }

    let subset = data.slice(start-idx, end-idx)
    let center-x = data.at(i).at(0)

    // 2. Build Normal Equations (X^T * X * beta = X^T * y)
    // We center x at 0 for numerical stability: x_local = x_j - center_x
    let mat-size = degree + 1
    let AtA = range(mat-size).map(_ => range(mat-size).map(_ => 0.0))
    let AtY = range(mat-size).map(_ => 0.0)

    for point in subset {
      let dx = point.at(0) - center-x
      let dy = point.at(1)

      // Precompute powers of dx for the Vandermonde row
      let powers = range(mat-size * 2).map(p => if p == 0 { 1.0 } else {
        calc.pow(dx, p)
      })

      // Fill AtA (Symmetric)
      for r in range(mat-size) {
        for c in range(mat-size) {
          AtA.at(r).at(c) += powers.at(r + c)
        }
        AtY.at(r) += powers.at(r) * dy
      }
    }

    // 3. Solve for Coefficients [c0, c1, c2, c3...]
    // y ~ c0 + c1*x + c2*x^2 ...
    let coeffs = solve-linear(AtA, AtY)

    // 4. Extract Derivative
    // f'(0) = 1! * c1
    // f''(0) = 2! * c2
    // f'''(0) = 3! * c3
    let fact = (1, 1, 2, 6, 24).at(order)
    let val = coeffs.at(order) * fact

    result.push((center-x, val))
  }
  result
}
