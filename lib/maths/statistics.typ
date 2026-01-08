// --- Statistics Helpers ---

/// Calculates the arithmetic mean of a numeric array.
#let mean(data) = {
  assert(data.len() > 0, message: "Cannot calculate mean of empty array.")
  data.sum() / data.len()
}

/// Calculates the median of a numeric array.
#let median(data) = {
  assert(data.len() > 0, message: "Cannot calculate median of empty array.")
  let sorted = data.sorted()
  let n = sorted.len()
  let mid = calc.floor(n / 2)
  if calc.rem(n, 2) == 0 {
    (sorted.at(mid - 1) + sorted.at(mid)) / 2
  } else {
    sorted.at(mid)
  }
}

/// Calculates the variance of a numeric array.
/// - population: if true, calculates population variance (division by N), 
///               otherwise calculates sample variance (division by N-1).
#let variance(data, population: false) = {
  let n = data.len()
  assert(n > (if population { 0 } else { 1 }), message: "Insufficient data points for variance calculation.")
  
  let avg = mean(data)
  let sum-sq-diff = data.map(x => calc.pow(x - avg, 2)).sum()
  
  let divisor = if population { n } else { n - 1 }
  sum-sq-diff / divisor
}

/// Calculates the standard deviation of a numeric array.
/// - population: if true, calculates population standard deviation, otherwise sample standard deviation.
#let stddev(data, population: false) = {
  calc.sqrt(variance(data, population: population))
}

/// Calculates the standard error of the mean (SEM).
#let sem(data) = {
  stddev(data, population: false) / calc.sqrt(data.len())
}

/// Calculates the coefficient of variation (CV).
#let cv(data) = {
  let avg = mean(data)
  if avg == 0 { return 0 }
  stddev(data, population: false) / avg
}

/// Calculates the covariance between two numeric arrays.
/// - population: if true, calculates population covariance, otherwise sample covariance.
#let covariance(data-x, data-y, population: false) = {
  let n = data-x.len()
  assert(n == data-y.len(), message: "Datasets must have the same length.")
  assert(n > (if population { 0 } else { 1 }), message: "Insufficient data points for covariance calculation.")
  
  let avg-x = mean(data-x)
  let avg-y = mean(data-y)
  
  let sum-prod-diff = 0.0
  for i in range(n) {
    sum-prod-diff += (data-x.at(i) - avg-x) * (data-y.at(i) - avg-y)
  }
  
  let divisor = if population { n } else { n - 1 }
  sum-prod-diff / divisor
}

/// Calculates the Pearson correlation coefficient between two numeric arrays.
#let correlation(data-x, data-y) = {
  let cov = covariance(data-x, data-y)
  let std-x = stddev(data-x)
  let std-y = stddev(data-y)
  
  if std-x == 0 or std-y == 0 {
    return 0
  }
  
  cov / (std-x * std-y)
}

/// Calculates the mode(s) of a numeric array.
/// Returns an array of the most frequent values.
#let mode(data) = {
  assert(data.len() > 0, message: "Cannot calculate mode of empty array.")
  let counts = (:)
  for val in data {
    let key = str(val)
    if key in counts {
      counts.insert(key, counts.at(key) + 1)
    } else {
      counts.insert(key, 1)
    }
  }
  
  let max-count = 0
  for val in counts.values() {
    if val > max-count {
      max-count = val
    }
  }
  
  let modes = ()
  for (key, count) in counts {
    if count == max-count {
      // Try to convert back to float/int if possible
      modes.push(eval(key))
    }
  }
  modes
}

/// Calculates the range (max - min) of a numeric array.
#let range-stat(data) = {
  assert(data.len() > 0, message: "Cannot calculate range of empty array.")
  calc.max(..data) - calc.min(..data)
}

/// Calculates the root mean square (RMS) of a numeric array.
#let rms(data) = {
  assert(data.len() > 0, message: "Cannot calculate RMS of empty array.")
  let sum-sq = data.map(x => calc.pow(x, 2)).sum()
  calc.sqrt(sum-sq / data.len())
}


#let q-factor(data) = {
  assert(data.len() > 0, message: "Cannot calculate Q-factor of empty array.")
  let max-val = calc.max(..data)
  let min-val = calc.min(..data)
  (max-val - min-val) / max-val
}
