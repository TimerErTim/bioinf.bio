#import "linear-algebra.typ": *

// --- Interpolation Function ---
/// Predicts y for an arbitrary x value using local polynomial regression.\
/// data: array of (x, y) tuples (should be sorted by x for best performance)\
/// x-target: the x value you want to interpolate at\
/// window: number of neighbors to consider (odd integer)\
/// degree: degree of polynomial to fit (e.g., 3 for cubic)
#let interpolate-smooth(data, x-target, window: 7, degree: 3) = {
  let n = data.len()
  let half-win = calc.floor(window / 2)

  // 1. Find the index of the data point closest to x-target
  // (Simple linear scan; for massive datasets, binary search is better)
  let closest-idx = 0
  let min-dist = calc.abs(data.at(0).at(0) - x-target)

  for i in range(1, n) {
    let dist = calc.abs(data.at(i).at(0) - x-target)
    if dist < min-dist {
      min-dist = dist
      closest-idx = i
    }
  }

  // 2. Determine Window Indices around the closest point
  let start-idx = calc.max(0, closest-idx - half-win)
  let end-idx = calc.min(n, start-idx + window)

  // Shift window if hitting the right edge
  if (end-idx - start-idx < window) and (start-idx > 0) {
    start-idx = calc.max(0, end-idx - window)
  }

  let subset = data.slice(start-idx, end-idx)

  // 3. Build Normal Equations (Centered at x-target)
  // We center at x-target so that the evaluated polynomial
  // P(0) corresponds exactly to the predicted y.
  let mat-size = degree + 1
  let AtA = range(mat-size).map(_ => range(mat-size).map(_ => 0.0))
  let AtY = range(mat-size).map(_ => 0.0)

  for point in subset {
    let dx = point.at(0) - x-target // Distance from our target
    let dy = point.at(1)

    // Vandermonde row powers
    let powers = range(mat-size * 2).map(p => {
      if p == 0 { 1.0 } else { calc.pow(dx, p) }
    })

    for r in range(mat-size) {
      for c in range(mat-size) {
        AtA.at(r).at(c) += powers.at(r + c)
      }
      AtY.at(r) += powers.at(r) * dy
    }
  }

  // 4. Solve coefficients [c0, c1, c2...]
  // The polynomial is y = c0 + c1*dx + c2*dx^2...
  // Since we want y at x-target, dx is 0.
  // Therefore, the result is simply c0.
  let coeffs = solve-linear(AtA, AtY)

  coeffs.at(0)
}

// --- Main Intersection Function ---
// Returns an array of x-values where the smoothed data crosses the line y = mx + c
#let find-linear-intersections(
  data,
  slope: 0,
  intercept,
  window: 7,
  degree: 3,
) = {
  let roots = ()
  let n = data.len()
  let half-win = calc.floor(window / 2)

  // We store the "signed distance" from the line for the previous point
  // to detect when we cross zero.
  let prev-dist = none
  let prev-x = none

  for i in range(n) {
    // 1. Setup Window (Clamped to edges)
    let start-idx = calc.max(0, i - half-win)
    let end-idx = calc.min(n, start-idx + window)
    if (end-idx - start-idx < window) and (start-idx > 0) {
      start-idx = calc.max(0, end-idx - window)
    }

    let subset = data.slice(start-idx, end-idx)
    let center-x = data.at(i).at(0)

    // 2. Perform Local Polynomial Fit (to find smoothed y)
    let mat-size = degree + 1
    let AtA = range(mat-size).map(_ => range(mat-size).map(_ => 0.0))
    let AtY = range(mat-size).map(_ => 0.0)

    for point in subset {
      let dx = point.at(0) - center-x
      let dy = point.at(1)
      let powers = range(mat-size * 2).map(p => if p == 0 { 1.0 } else {
        calc.pow(dx, p)
      }) // Fixed 0^0
      for r in range(mat-size) {
        for c in range(mat-size) { AtA.at(r).at(c) += powers.at(r + c) }
        AtY.at(r) += powers.at(r) * dy
      }
    }

    let coeffs = solve-linear(AtA, AtY)
    let smoothed-y = coeffs.at(0) // c0 is the value at center-x

    // 3. Calculate Distance from Line
    let line-y = slope * center-x + intercept
    let dist = smoothed-y - line-y

    // 4. Check for Crossing
    if prev-dist != none {
      // If signs are different, we crossed the line
      if (prev-dist > 0 and dist < 0) or (prev-dist < 0 and dist > 0) {
        // Linear interpolation to find precise x where dist == 0
        // formula: x = x1 + (0 - y1) * (x2 - x1) / (y2 - y1)
        let frac = (0.0 - prev-dist) / (dist - prev-dist)
        let crossing-x = prev-x + frac * (center-x - prev-x)
        roots.push(crossing-x)
      }
    }

    prev-dist = dist
    prev-x = center-x
  }
  roots
}
