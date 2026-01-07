// --- Linear Algebra Helpers ---
// Solves Ax = b using Gaussian elimination with partial pivoting
#let solve-linear(A, b) = {
  let n = A.len()
  let M = A // Copy A
  let x = b // Copy b (will become solution)
  let indices = range(n)

  // Forward elimination
  for i in range(n) {
    // Pivot selection
    let pivot-row = i
    let max-val = calc.abs(M.at(i).at(i))
    for k in range(i + 1, n) {
      if calc.abs(M.at(k).at(i)) > max-val {
        max-val = calc.abs(M.at(k).at(i))
        pivot-row = k
      }
    }

    // Swap rows
    let temp-row = M.at(i)
    M.at(i) = M.at(pivot-row)
    M.at(pivot-row) = temp-row
    let temp-val = x.at(i)
    x.at(i) = x.at(pivot-row)
    x.at(pivot-row) = temp-val

    // Eliminate
    for j in range(i + 1, n) {
      let factor = M.at(j).at(i) / M.at(i).at(i)
      x.at(j) = x.at(j) - factor * x.at(i)
      for k in range(i, n) {
        M.at(j).at(k) = M.at(j).at(k) - factor * M.at(i).at(k)
      }
    }
  }

  // Back substitution
  let solution = range(n).map(_ => 0.0)
  for i in range(n).rev() {
    let sum = 0.0
    for j in range(i + 1, n) {
      sum += M.at(i).at(j) * solution.at(j)
    }
    solution.at(i) = (x.at(i) - sum) / M.at(i).at(i)
  }
  solution
}