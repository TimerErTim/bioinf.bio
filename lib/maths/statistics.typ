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

/// Calculates the mean and standard deviation of a numeric array.
/// - population: if true, calculates population standard deviation, otherwise sample standard deviation.
#let mean-stddev(data, population: true) = {
  (mean(data), stddev(data, population: population))
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

#let chi-square-teststatistic(expected, observed) = {
  let deviations = observed.zip(expected).map(((observed, expected)) => calc.pow((observed - expected), 2) / expected)
  let t = deviations.sum()
  (
    "deviations": deviations,
    "t": t
  )
}

#let normal-cdf-upper(z) = {
  // Berechnet das obere Ende (1 - Phi(z)) der Standardnormalverteilung
  let abs-z = calc.abs(z)
  
  // Konstanten nach Abramowitz & Stegun (Formel 26.2.17)
  let p = 0.2316419
  let b1 = 0.319381530
  let b2 = -0.356563782
  let b3 = 1.781477937
  let b4 = -1.821255978
  let b5 = 1.330274429
  
  let t = 1 / (1 + p * abs-z)
  
  // Dichtefunktion Z(z)
  let pi = 3.141592653589793
  let Z-val = calc.exp(-calc.pow(abs-z, 2) / 2) / calc.sqrt(2 * pi)
  
  // Approximation des oberen Schleifenendes
  let upper-tail = Z-val * (
    b1 * t 
    + b2 * calc.pow(t, 2) 
    + b3 * calc.pow(t, 3) 
    + b4 * calc.pow(t, 4) 
    + b5 * calc.pow(t, 5)
  )
  
  if z >= 0 {
    return upper-tail
  } else {
    return 1 - upper-tail
  }
}

#let chisq-pvalue(x2, df: 1) = {
  // Sicherheitsabfragen für unzulässige Werte
  if x2 < 0 or df <= 0 { return 1.0 }
  if x2 == 0 { return 1.0 }
  
  if df == 1 {
    // Exact shortcut: Chi-square(1) is just Z^2
    let z = calc.sqrt(x2)
    return 2 * normal-cdf-upper(z)
  } else {
    // Wilson-Hilferty-Transformation for df >= 2
    let v = 2 / (9 * df)
    let ratio = x2 / df
    let z = (calc.pow(ratio, 1/3) - (1 - v)) / calc.sqrt(v)
    return normal-cdf-upper(z)
  }
}

#let chi-square-ablehnungsbereich(df: 1, alpha: 0.05) = {
  // Using Wilson-Hilferty approximation for the quantile of the chi-square distribution
  // Q ≈ df * (1 - 2/(9*df) + sqrt(2/(9*df)) * z_alpha )^3
  // where z_alpha is the quantile of the standard normal for 1-alpha

  // Compute the inverse error function approx for z_alpha based on Abramowitz & Stegun (7.1.26)
  // We need z_alpha = sqrt(2) * erfinv(2 * (1 - alpha) - 1)
  // We'll use the approximation for erfinv.
  let a = 0.207  // Magic constant for erfinv approximation
  let p = 2 * (1 - alpha) - 1
  // avoid edge cases
  let sign = if p >= 0 { 1 } else { -1 }
  let ln1mp2 = calc.ln(1 - p * p)
  let erfinv = sign * calc.sqrt(
      calc.sqrt(
        calc.pow((2 / (calc.pi * a)) + (ln1mp2 / 2), 2)
        - (ln1mp2 / a)
      ) - ((2 / (calc.pi * a)) + (ln1mp2 / 2))
    )

  let z_alpha = calc.sqrt(2) * erfinv

  // Wilson-Hilferty Formel
  let v = 2 / (9 * df)
  let critical-value = df * calc.pow(1 - v + z_alpha * calc.sqrt(v), 3)
  
  return critical-value
}

#let _chi-square-ref-ablehnungsbereich = (
  (df: 1, alpha: 0.3, threshold: 1.07),
  (df: 1, alpha: 0.25, threshold: 1.32),
  (df: 1, alpha: 0.2, threshold: 1.64),
  (df: 1, alpha: 0.15, threshold: 2.07),
  (df: 1, alpha: 0.1, threshold: 2.71),
  (df: 1, alpha: 0.05, threshold: 3.84),
  (df: 2, alpha: 0.3, threshold: 2.41),
  (df: 2, alpha: 0.25, threshold: 2.77),
  (df: 2, alpha: 0.2, threshold: 3.22),
  (df: 2, alpha: 0.15, threshold: 3.79),
  (df: 2, alpha: 0.1, threshold: 4.61),
  (df: 2, alpha: 0.05, threshold: 5.99),
  (df: 3, alpha: 0.3, threshold: 3.66),
  (df: 3, alpha: 0.25, threshold: 4.11),
  (df: 3, alpha: 0.2, threshold: 4.64),
  (df: 3, alpha: 0.15, threshold: 5.32),
  (df: 3, alpha: 0.1, threshold: 6.25),
  (df: 3, alpha: 0.05, threshold: 7.81),
  (df: 4, alpha: 0.3, threshold: 4.88),
  (df: 4, alpha: 0.25, threshold: 5.39),
  (df: 4, alpha: 0.2, threshold: 5.99),
  (df: 4, alpha: 0.15, threshold: 6.74),
  (df: 4, alpha: 0.1, threshold: 7.78),
  (df: 4, alpha: 0.05, threshold: 9.49),
  (df: 5, alpha: 0.3, threshold: 6.06),
  (df: 5, alpha: 0.25, threshold: 6.63),
  (df: 5, alpha: 0.2, threshold: 7.29),
  (df: 5, alpha: 0.15, threshold: 8.12),
  (df: 5, alpha: 0.1, threshold: 9.24),
  (df: 5, alpha: 0.05, threshold: 11.07),
)

#let relative-error(entries-expected, entries-observed) = {
  let errors = entries-expected.zip(entries-observed).map(((expected, observed)) => calc.abs(expected - observed) / expected)
  errors.sum() / errors.len()
}

#let is-difference-significant(entries-expected, entries-observed, alpha: 0.05) = {
  let test-statistics = chi-square-teststatistic(entries-expected, entries-observed)
  let critical-value = chi-square-ablehnungsbereich(df: entries-expected.len() - 1, alpha: alpha)
  test-statistics.t > critical-value
}

#let is-contingency-table-significant-independent(..rows, alpha: 0.05) = {
  let rows = rows.pos()
  let edge-distr-horizontal = (0,) * rows.len()
  let edge-distr-vertical = (0,) * rows.at(0).len()
  let total-sum = 0
  let expected-rows = ((0,) * rows.at(0).len(),) * rows.len()
  for (y, row) in rows.enumerate() {
    for (x, cell) in row.enumerate() {
      edge-distr-horizontal.at(y) += cell
      edge-distr-vertical.at(x) += cell
      total-sum += cell
    }
  }
  for (y, total-horizontal) in edge-distr-horizontal.enumerate() {
    for (x, total-vertical) in edge-distr-vertical.enumerate() {
      expected-rows.at(y).at(x) = total-horizontal * total-vertical / total-sum
    }
  }
  
  let test-statistics = rows.zip(expected-rows).map(((observed, expected)) => chi-square-teststatistic(expected, observed).t).sum()
  let critical-value = chi-square-ablehnungsbereich(df: (rows.len() - 1) * (rows.at(0).len() - 1), alpha: alpha)
  test-statistics > critical-value
}

