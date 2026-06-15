#import "statistics.typ": mean, variance

/// Performs linear regression using an iterative approach.
/// - points: array of (x, y) tuples
/// - returns: tuple of (beta_1, beta_0) where y = beta_1 * x + beta_0
#let linear-regression-iterative(points) = {
  let y-mean = mean(points.map(p => p.at(1)))
  let x-mean = mean(points.map(p => p.at(0)))
  let x-variance = variance(points.map(p => p.at(0)))

  let w(x) = {
    return (x - x-mean) / (x-variance * points.len())
  }

  let beta_1 = points.map(((x, y)) => (w(x) * y)).sum()
  let beta_0 = y-mean - beta_1 * x-mean

  return (beta_1, beta_0)
}
