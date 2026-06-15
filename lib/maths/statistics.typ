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
  assert(
    n > (if population { 0 } else { 1 }),
    message: "Insufficient data points for variance calculation.",
  )

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
  assert(
    n > (if population { 0 } else { 1 }),
    message: "Insufficient data points for covariance calculation.",
  )

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
  let deviations = observed
    .zip(expected)
    .map(((observed, expected)) => (
      calc.pow((observed - expected), 2) / expected
    ))
  let t = deviations.sum()
  (
    "deviations": deviations,
    "t": t,
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
  let upper-tail = (
    Z-val
      * (
        b1 * t
          + b2 * calc.pow(t, 2)
          + b3 * calc.pow(t, 3)
          + b4 * calc.pow(t, 4)
          + b5 * calc.pow(t, 5)
      )
  )

  if z >= 0 {
    return upper-tail
  } else {
    return 1 - upper-tail
  }
}

#let chi-square-pvalue(x2, df: 1) = {
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
    let z = (calc.pow(ratio, 1 / 3) - (1 - v)) / calc.sqrt(v)
    return normal-cdf-upper(z)
  }
}

#let relative-error(entries-expected, entries-observed) = {
  let errors = entries-expected
    .zip(entries-observed)
    .map(((expected, observed)) => calc.abs(expected - observed) / expected)
  errors.sum() / errors.len()
}

#let student-t-pvalue(t, df, alternative: "two-sided") = {
  // 1. Fallback für sehr große Freiheitsgrade (t-Verteilung konvergiert gegen Normalverteilung)
  if df > 500 {
    let p-two = 2 * normal-cdf-upper(calc.abs(t))
    if alternative == "two-sided" { return p-two }
    if alternative == "greater" {
      return if t >= 0 { p-two / 2 } else { 1 - (p-two / 2) }
    }
    if alternative == "less" {
      return if t <= 0 { p-two / 2 } else { 1 - (p-two / 2) }
    }
  }

  // 2. Exakte analytische Berechnung über trigonometrische Reihen
  let theta = calc.atan(t / calc.sqrt(df))
  let cdf = 0.0

  if calc.even(df) {
    // Symmetrische Reihe für gerade Freiheitsgrade
    let m = int((df - 2) / 2)
    let term_sum = 1.0
    let prod = 1.0

    if m >= 1 {
      for i in range(1, m + 1) {
        prod *= (2 * i - 1) / (2 * i)
        term_sum += calc.pow(calc.cos(theta), 2 * i) * prod
      }
    }
    cdf = 0.5 + (calc.sin(theta) / 2) * term_sum
  } else {
    // Symmetrische Reihe für ungerade Freiheitsgrade
    if df == 1 {
      cdf = 0.5 + theta / calc.pi
    } else {
      let m = int((df - 3) / 2)
      let term_sum = calc.cos(theta)
      let prod = 1.0

      if m >= 1 {
        for i in range(1, m + 1) {
          prod *= (2 * i) / (2 * i + 1)
          term_sum += calc.pow(calc.cos(theta), 2 * i + 1) * prod
        }
      }
      cdf = 0.5 + (theta.rad() + calc.sin(theta) * term_sum) / calc.pi
    }
  }

  // Rückgabe basierend auf der gewünschten Hypothesenrichtung
  if alternative == "two-sided" {
    return 2 * calc.min(cdf, 1 - cdf)
  } else if alternative == "greater" {
    return 1 - cdf
  } else if alternative == "less" {
    return cdf
  }
}

#let one-sample-t-test(
  values,
  expected-mu: 0,
  alpha: 0.05,
  alternative: "two-sided",
) = {
  let (mean, stddev) = mean-stddev(values)
  let t = (mean - expected-mu) / (stddev / calc.sqrt(values.len()))
  let df = values.len() - 1
  let p-value = student-t-pvalue(t, df)
  (
    "t-value": t,
    "p-value": p-value,
    "is-significant": p-value < alpha,
  )
}

#let two-sample-t-test(
  values1,
  values2,
  expected-mu: 0,
  alpha: 0.05,
  alternative: "two-sided",
) = {
  let (mean1, stddev1) = mean-stddev(values1)
  let (mean2, stddev2) = mean-stddev(values2)
  let t = (
    (mean1 - mean2)
      / calc.sqrt(
        stddev1 * stddev1 / calc.sqrt(values1.len())
          + stddev2 * stddev2 / calc.sqrt(values2.len()),
      )
  )
  let df = calc.min(values1.len() - 1, values2.len() - 1)
  let p-value = student-t-pvalue(t, df)
  (
    "t-value": t,
    "p-value": p-value,
    "is-significant": p-value < alpha,
  )
}

#let chi-square-anpassungstest(observed, distr, alpha: 0.05) = {
  assert(
    observed.len() == distr.len(),
    message: "Observed and distribution must have the same length.",
  )
  let total-observed = observed.sum()
  let expected = distr.map(it => it * total-observed)
  let test-statistics = chi-square-teststatistic(expected, observed)
  let p-value = chi-square-pvalue(test-statistics.t, df: observed.len() - 1)
  (
    "expected": expected,
    "t-value": test-statistics.t,
    "p-value": p-value,
    "is-significant": p-value < alpha,
  )
}

#let chi-square-independence-test(..rows, alpha: 0.05) = {
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
  let test-statistics = rows
    .zip(expected-rows)
    .map(((observed, expected)) => {
      chi-square-teststatistic(expected, observed).t
    })
    .sum()
  let p-value = chi-square-pvalue(
    test-statistics,
    df: (rows.len() - 1) * (rows.at(0).len() - 1),
  )
  (
    "test-statistics": test-statistics,
    "p-value": p-value,
    "is-significant": p-value < alpha,
  )
}

#let is-difference-significant(
  entries-expected,
  entries-observed,
  alpha: 0.05,
) = {
  let test-statistics = chi-square-teststatistic(
    entries-expected,
    entries-observed,
  )
  let critical-value = chi-square-ablehnungsbereich(
    df: entries-expected.len() - 1,
    alpha: alpha,
  )
  test-statistics.t > critical-value
}

#let is-contingency-table-significant-independent(..rows, alpha: 0.05) = {
  chi-square-independence-test(..rows, alpha: alpha)
}

#let mean-squares-within(..groups) = {
  let groups = groups.pos()
  let sum = 0
  let count = 0
  for group in groups {
    let group-mean = mean(group)
    for value in group {
      sum += calc.pow(value - group-mean, 2)
    }
    count += group.len()
  }
  sum / (count - groups.len())
}

#let mean-squares-between(..groups) = {
  let groups = groups.pos()
  let groups-mean = mean(groups.flatten())
  let sum = 0
  for group in groups {
    let group-mean = mean(group)
    sum += calc.pow(group-mean - groups-mean, 2)
  }
  sum / (groups.len() - 1)
}

#let _log-gamma(x) = {
  let p = (
    676.5203681218851,
    -1259.1392167224028,
    771.3234287776531,
    -176.61502916214059,
    12.507343278686905,
    -0.13857109526572012,
    9.9843695780195716e-6,
    1.5056327351493116e-7,
  )
  if x < 0.5 {
    return calc.ln(calc.pi / calc.sin(calc.pi * x)) - _log-gamma(1 - x)
  }
  let x = x - 1
  let sum = 0.99999999999980993
  for i in range(p.len()) { sum += p.at(i) / (x + i + 1) }
  let t = x + p.len() - 0.5
  return 0.5 * calc.ln(2 * calc.pi) + (x + 0.5) * calc.ln(t) - t + calc.ln(sum)
}

#let _beta-incomplete(x, a_param, b_param) = {
  if x <= 0.0 { return 0.0 }
  if x >= 1.0 { return 1.0 }

  let a = float(a_param)
  let b = float(b_param)

  // Symmetrie-Eigenschaft nutzen
  if x > (a + 1.0) / (a + b + 2.0) {
    return 1.0 - _beta-incomplete(1.0 - x, b, a)
  }

  let lbeta = _log-gamma(a) + _log-gamma(b) - _log-gamma(a + b)
  let front = calc.exp(a * calc.ln(x) + b * calc.ln(1.0 - x) - lbeta) / a

  // Reihenentwicklung nach Taylor/Abramowitz
  let sum = 0.0
  let term = 1.0
  sum += term

  for j in range(1, 60) {
    let j_f = float(j)
    // Multiplikativer Faktor für das nächste Glied der Reihe
    term *= ((a + b + j_f - 1.0) * x) / (a + j_f)
    sum += term
    if calc.abs(term) < 1e-12 { break }
  }

  return calc.min(1.0, calc.max(0.0, front * sum))
}

#let f-pvalue(f, df1, df2) = {
  if f <= 0 or df1 <= 0 or df2 <= 0 { return 1.0 }

  let x = (float(df1) * float(f)) / (float(df1) * float(f) + float(df2))
  let p_val = 1.0 - _beta-incomplete(x, float(df1) / 2.0, float(df2) / 2.0)

  return calc.min(1.0, calc.max(0.0, p_val))
}

#let anova-test(..groups, alpha: 0.05) = {
  let groups = groups.pos()
  let mean-squares-within = mean-squares-within(..groups)
  let mean-squares-between = mean-squares-between(..groups)
  let f = mean-squares-between / mean-squares-within
  let N = groups.map(it => it.len()).sum()
  let p-value = f-pvalue(f, groups.len() - 1, groups.at(0).len() - 1)
  (
    "msw": mean-squares-within,
    "msb": mean-squares-between,
    "f-value": f,
    "p-value": p-value,
    "is-significant": p-value < alpha,
  )
}

#let ranks(values, by: it => it) = {
  let counts = (:)
  for value in values {
    let key = str(by(value))
    if key in counts {
      counts.at(key).push(value)
    } else {
      counts.insert(key, (value,))
    }
  }
  counts = counts.pairs().map(((key, values)) => (eval(key), values))
  counts = counts.sorted(key: it => it.at(0))
  let index = 0
  for (_, values) in counts {
    let rank = (index + 1 + index + values.len()) / 2
    index += values.len()
    for value in values {
      (
        (
          "value": value,
          "rank": rank,
        ),
      )
    }
  }
}

#let wilcoxon-rank-sum-statistic(
  grp-a,
  grp-b,
) = {
  let n-a = grp-a.len()
  let n-b = grp-b.len()
  let n = n-a + n-b
  let ranks = ranks(
    grp-a.map(it => (it, "a")) + grp-b.map(it => (it, "b")),
    by: it => it.at(0),
  )
  let rank-sum-a = ranks
    .filter(it => it.value.at(1) == "a")
    .map(it => it.rank)
    .sum()
  let rank-sum-b = ranks
    .filter(it => it.value.at(1) == "b")
    .map(it => it.rank)
    .sum()
  // Return the W statistic (lowest sum of ranks for groups)
  return (
    "n_a": n-a,
    "n_b": n-b,
    "w-statistic": calc.min(rank-sum-a, rank-sum-b),
  )
}

#let wilcoxon-signed-rank-statistic(pairs) = {
  let diff = pairs.map(((a, b)) => a - b)
  let ranks = ranks(diff, by: calc.abs)
  let t-plus = ranks.filter(it => it.value >= 0).map(it => it.rank).sum()
  let t-minus = ranks.filter(it => it.value < 0).map(it => it.rank).sum()
  return (
    "n": pairs.len(),
    "w-statistic": calc.min(t-plus, t-minus),
  )
}
